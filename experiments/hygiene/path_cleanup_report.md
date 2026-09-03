# Path Cleanup Report (EXP-000, Hygiene Phase)

Date: 2026-08-26. Branch: phase-2-staging-elimination.
Scope: remove all hardcoded `/home/gencer/llama.cpp` occurrences from tracked
files; enforce dynamic repo-root resolution; rewrite branch history.

## 1. Discovery

Total tracked-file matches before cleanup: 309 occurrences of
`/home/gencer/llama.cpp` across 207 files.

| category | files | strategy |
|---|---|---|
| Python scripts (.py) | 39 | `ROOT = Path(__file__).resolve().parents[N]`, N derived from script depth; literals -> `str(ROOT / "...")` |
| Shell scripts (.sh) | 24 auto + 2 manual | `ROOT="$(git rev-parse --show-toplevel)"`; literals -> `"${ROOT}/..."` |
| Evidence/data (.json) | 100 | prefix replaced with `<REPO_ROOT>` marker |
| Docs (.md incl. agents.md) | 29 | prefix replaced with `<REPO_ROOT>` marker |
| Other text (.env/.txt/.bak) | 13 | prefix replaced with `<REPO_ROOT>` marker; active config special-cased below |
| Total modified | 207 | |

Manual (non-pattern) shell edits:
- results2/build_variant.sh: SRC dynamic; heredoc python bodies now read the
  source path from `os.environ["TULPAR_SRC"]` (heredocs are quote-quoted, so
  `${SRC}` would not expand inside them).
- ops/legacy/restore_server.sh: added ROOT line; `cd "${ROOT}/build/bin"`.

Special case:
- ops/manifest/prod_flags.env: BINARY_PATH converted to repo-root-relative
  value `build-p3/bin/llama-server` with explanatory comment. No script
  consumes BINARY_PATH programmatically (verified by grep); prod_start.sh /
  prod_stop.sh resolve binaries from ROOT directly.

## 2. Classification

- IN-REPO paths (`/home/gencer/llama.cpp/...`): all replaced as above.
- MODEL/EXTERNAL paths (`/home/gencer/models/qwen38/*.gguf`): 53 occurrences,
  LEFT UNCHANGED per phase constraint. Flagged for future config migration:
  srv_ctl_*.sh MODEL=, ops/bin/*.sh MODEL=, results/orchestrate.py,
  results2/tulpar/p1_campaign.py, results2/ctest_kv.py, quant_analysis.py,
  assemble_baseline_v3.py, restore_server.sh, safe_commands.sh.
- Other external user paths in evidence captures (/home/gencer/.bun,
  .cargo, .local, .npm-global, .lmstudio): LEFT (historical environment
  records); not covered by this phase's zero-match mandate.
- ELF binaries with embedded path strings (cannot be patched textually;
  flagged, not modified):
  - experiments/phase4e/subagent_e/mmvq_bench
  - experiments/phase5/subagent_g/bench_gemm_routing
  - results2/tulpar/experiments/e1_gemv/e1_gemv
- Untracked generated artifacts under build/ (CMakeCache, InstallScripts.json,
  compile_commands.json) contain absolute paths by design of CMake; they are
  gitignored and regenerated per configure. Out of scope.

## 3. Per-script verification

All 39 .py: `python3 -m py_compile` PASS. Depth mapping verified for all 39:
`Path(__file__).resolve().parents[N] == git rev-parse --show-toplevel`.
All 26 .sh: `bash -n` PASS.

Functional checks:

| script | invocation | result |
|---|---|---|
| ops/bin/prod_start.sh | --dry-run | PASS (dynamic ROOT resolved identical paths) |
| ops/bin/baseline_start_template.sh | --profile hygiene-smoke --dry-run | PASS |
| ops/bin/prod_status.sh | status | PASS |
| ops/bin/baseline_status.sh | status | PASS |
| ops/bin/prod_health.sh | health GET | PASS (rc=0) |
| ops/bin/prod_stop.sh | no args (refusal path) | PASS (rc=1 usage) |
| ops/bin/baseline_stop_template.sh | no args (refusal path) | PASS (rc=1) |
| ops/bin/prod_capture_pid.sh | no env guard (refusal path) | PASS (rc=1) |
| experiments/phase1a/safe_commands.sh | ro mode | PASS |
| srv_ctl_p0/p1/p1b/p2/p2b.sh | status --profile hygiene-smoke | PASS (correct "NO pidfile" behavior) |
| arm_run_p0/p1/p2, arm_run(1b), p2b_run, p2b_run_traced2, traced_arm_p1 | --help | PASS |
| run_ladder_v3.sh, run_traced_arms.sh, run_untraced_ladder.sh (p1,p2), run_diag_128k.sh, run_gate.sh, run_ladder.sh, run_traced_arm_128k.sh, restore_prod.sh, restore_prod_p2b.sh, restore_server.sh, build_variant.sh | syntax-only | NOT EXECUTED (would launch builds/servers or patch kernel sources) |

Note: prod_start.sh --dry-run removed a stale production pidfile (stale PID
144016) as designed; pidfile restored from index afterwards.

## 4. Final grep results

Code-file verification (agents.md section 17 command):

    $ grep -rn "/home/gencer/llama.cpp" --include="*.py" --include="*.sh" \
        --include="*.cu" --include="*.cuh" --include="*.cpp" --include="*.h" .
    (zero output)

Broad tracked-file grep:

    agents.md:456:paths such as /home/gencer/llama.cpp.
    agents.md:466:  grep -rn "/home/gencer/llama.cpp" ...

These two are the mandated verbatim text of policy section 17 itself
(self-reference defining the prohibition and its verification command);
not a hardcoded path use.

## 5. History

Commits tulpar/main..HEAD rewritten so cleaned file versions replace the
hardcoded ones in-place (interactive rebase, both commits amended). See
EXPERIMENT_LOG.md EXP-000.

Post-rewrite chain (pre-rewrite state preserved on branch hygiene-backup):
| new hash | old hash | subject |
|---|---|---|
| ca49ee25b | 091aec112 | chore: Phase-1 full profiling trace baseline (V3 Q2_K_XL) |
| 2e033a696 | 2ca80327b | feat: eliminate staging dequant for q4_0 KV cache (PATH A) |
| this commit | - | chore: enforce dynamic repo root, add experiment log standard and fork-only policy |

Note: hashes of commits at or above this report are self-referential and
therefore recorded by subject only; the two base rows below are stable.
Base rows above list the post-hygiene-rewrite values of the original
phase commits.

`git log -p tulpar/main..HEAD | grep /home/gencer/llama.cpp` matches only:
the hygiene commit message that documents the removal, the verbatim policy
text of agents.md section 17, and the EXP-000 log description. No rewritten
commit introduces a hardcoded path; both amended commits show zero matches.

## 6. Blockers / follow-ups

- BLOCKED (flag only): 3 ELF binaries above carry embedded absolute paths;
  removal requires rebuild from their sources.
- FOLLOW-UP: migrate MODEL= constants to env var / config per section 17
  rule 3 (explicitly deferred by phase constraint).
- FOLLOW-UP: `<REPO_ROOT>` marker semantics documented here apply to all
  historical evidence JSON/md captures.
- FOLLOW-UP: `parents[N]` depth is verified today but breaks silently if a
  script is moved between directories; candidate for a shared helper module.

Verdict refined after review: repo-root hygiene is complete; external model
path migration remains open by explicit phase constraint.

REPO_ROOT_HYGIENE_OK; EXTERNAL_MODEL_PATH_MIGRATION_PENDING
