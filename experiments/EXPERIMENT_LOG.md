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
