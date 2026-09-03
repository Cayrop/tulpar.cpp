# Traced Server Signal Behavior

Date: 2026-08-24 (Phase-2C documentation, from Phase-2B open issue 2)
Source evidence: experiments/phase2b/results.md sec 15 item 2,
experiments/phase2b/logs/force_kills.txt

## Observed behavior

- Server instances wrapped by rocprofv3 (kernel-trace mode) ignore SIGINT
  beyond ~300 s of runtime.
- Every traced stop in the Phase-2B window required SIGKILL escalation
  (6/6 traced instances; see force_kills.txt).
- Trace buffers flushed intact after each SIGKILL: verified by file
  sizes/timestamps and internally consistent kernel call counts
  (call counts matched the expected per-step math for 32/96/128 steps).

## Consequence

- A traced instance left running for more than ~300 s cannot be stopped
  with a normal signal; plan the stop before the instance outlives the
  measurement.
- SIGKILL on a traced instance does not corrupt or lose the trace output
  (observed in all 6 Phase-2B escalations).

## Recommendation

- Use short-lived traced instances: start, measure, stop promptly.
- Do not leave a traced instance running as a long-lived service.
- Budget for SIGKILL escalation when stopping any instance older than
  ~300 s; verify trace file integrity (size + call counts) after each
  forced stop.

## Scope

- This is a profiler artifact (rocprofv3 wrapper), not a production concern.
  Untraced production instances stop normally via the validated pidfile
  procedure (SIGTERM/SIGINT path in ops/bin/prod_stop.sh).
- No script changes were made for this behavior.
