# EXPERIMENT_LOG.md (hygiene phase root log)

Format: agents.md section 16. Append-only.

## EXP-000: repo hygiene - hardcoded path elimination and history rewrite

PROBLEM
Scripts, configs, and evidence files hardcoded the absolute repo path
/home/gencer/llama.cpp. This breaks portability (any relocation or clone
path change silently breaks tooling) and leaks user-specific paths into
history and evidence artifacts.

EVIDENCE
309 occurrences of /home/gencer/llama.cpp across 207 tracked files:
39 .py, 26 .sh, 100 .json, 29 .md, 13 other (.env/.txt/.bak).
3 ELF experiment binaries carry embedded copies (not textually patchable).
53 occurrences of /home/gencer/models/... (external, out of scope this phase).

HYPOTHESIS
Replacing repo-root constants with dynamic resolution
(Path(__file__).parents[N] / git rev-parse --show-toplevel) preserves all
behavior on the current machine while removing the hard dependency; textual
prefix substitution (<REPO_ROOT>) keeps historical evidence readable without
absolute paths.

CHANGE
- 39 .py: ROOT dynamic + pathlib import where missing; sys.path and constant
  literals -> str(ROOT / "..."). Depth N verified per file against repo root.
- 24 .sh auto + build_variant.sh, restore_server.sh manual (heredoc env-var
  plumbing via TULPAR_SRC; cd via ${ROOT}).
- ops/manifest/prod_flags.env BINARY_PATH made repo-root-relative.
- Data/doc/evidence files: prefix -> <REPO_ROOT> marker.
- agents.md: sections 16-18 appended; own absolute-path mentions replaced.
- New: experiments/hygiene/path_cleanup_report.md,
  experiments/EXPERIMENT_LOG_TEMPLATE.md, this log.
- History: both commits tulpar/main..HEAD rewritten (amended trees), so no
  commit introduces the hardcoded path.

RESULT
No performance metrics; repo hygiene only.
Verification: code grep (*.py/*.sh/*.cu/*.cuh/*.cpp/*.h) = 0 matches.
Broad tracked-file grep = only the 2 verbatim self-references inside policy
section 17 text. py_compile 39/39 PASS; bash -n 26/26 PASS; JSON validity
100/100 PASS; functional dry-run/status/help checks PASS (see
experiments/hygiene/path_cleanup_report.md section 3).

WHY IT WORKED
Repo-root resolution depends only on file location inside the working tree,
which is invariant for any in-tree consumer; every downstream use was a pure
string concatenation from ROOT, so substituting the root expression at the
single definition point leaves all derived paths identical on the current
machine and correct on any other checkout location.

CAVEAT
Not measured: execution of ladder/traced/restore scripts (destructive or
GPU-bound; syntax-verified only). 3 ELF binaries retain embedded absolute
strings until rebuilt. Model-directory constants remain hardcoded by explicit
phase constraint; migration to env/config is a recorded follow-up.

## EXP-001: benchmark driver failure handling and VRAM monitor hardening

PROBLEM
Review found arm_run-style drivers continued measuring after a failed server
health check (failure misclassified as PROMPT_BUILD_FAIL via the /tokenize
exception) and the VRAM monitor silently produced zero samples if rocm-smi
was missing/failing, letting a run finish status=OK with vram_peak_b=0.
Sampled vram_peak_gib was also presented without a sampling caveat.

EVIDENCE
arm_run_p0.py:123, arm_run_p1.py:123, phase1b/bin/arm_run.py:120,
arm_run_p2.py:123: health result recorded, no early exit. VramMonitor.run in
7 drivers dropped None reads silently; subprocess.run raises FileNotFoundError
when rocm-smi is absent (uncaught inside the monitor thread loop).

HYPOTHESIS
Explicit fail-fast branches at health-check time and a mandatory first valid
VRAM sample before any rep eliminate misclassification and silent monitor
death without touching measurement logic or timing behavior.

CHANGE
- 4 untraced drivers (p0/p1/p1b/p2): on health fail -> status HEALTH_FAIL,
  record dumped BEFORE stop attempt, server stopped via srv_ctl, stop_rc
  recorded in a separate field (cannot mask HEALTH_FAIL), exit 5.
- All 7 monitored drivers: vram_used_bytes returns None on OSError,
  non-zero rocm-smi exit, regex miss, or empty stdout; monitor counts every
  None as failed_reads; new first_sample() gate before reps -> status
  VRAM_MONITOR_FAIL, exit 6 (server stop only where the driver owns it).
- Records gain vram_failed_reads and vram_peak_note documenting that 0.5 s
  sampling can miss transient peaks.
- experiments/phase2/fused_loader_audit.md: line-level audit of commit
  2e033a696 fused q4_0 loader (nibble planes, bit-exactness proof, strides,
  OOB, dispatch scope). No defect found; two hardening notes recorded.

RESULT
No performance metrics; robustness and audit only. py_compile 7/7 PASS;
offline unit test: first_sample() times out with failed_reads>=1 for all
four failure modes (non-zero exit, regex miss, empty stdout, OSError) and
returns true with a recorded peak on the success path.
Kernel audit verdict: fused loader correct for all RDNA3 DKQ=DV=256 configs.

WHY IT WORKED
Failures are now classified at the layer that detects them (health gate
before prompt build; monitor gate before measurement), so exit codes and
record statuses reflect the actual failing subsystem instead of whichever
downstream call happened to raise first.

CAVEAT
Traced drivers do not own their server lifecycle; VRAM_MONITOR_FAIL there
exits without stopping the server (wrapper script responsibility).
The 0.5 s sampling interval itself is unchanged; peak underestimation risk
remains inherent and is only documented, not fixed. Kernel static_assert
hardening for the plane-alignment invariant requires a separate approved
kernel-source change.
