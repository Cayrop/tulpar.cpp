# Pidfile Policy

## Production pidfile

<REPO_ROOT>/ops/run/llama-server.pid

## Benchmark/test profile pidfiles

<REPO_ROOT>/ops/run/<profile>.pid

## Rules

1. Start script checks if pidfile exists and process is still alive; if so, it does NOT start a new process.
2. Start script writes the PID to pidfile after launching the process.
3. Stop script reads the PID only from the pidfile.
4. Stop script validates the PID via /proc/PID/exe and /proc/PID/cmdline to confirm it is the expected llama-server process.
5. If PID validation fails, stop is aborted.
6. pgrep is used ONLY for discovery and verification; it is never used for kill operations.
7. Legacy process pidfile capture is permitted; capture does NOT grant stop authority.
8. Stop requires explicit human approval via --i-have-explicit-approval flag.

## PID validation criteria

- /proc/PID/exe must resolve to build/bin/llama-server (production) or build-p3/bin/llama-server (baseline).
- /proc/PID/cmdline must contain the model path.
- Port/host from cmdline should match expected values (0.0.0.0:8080 for production).

## Safety invariants

- No signal is ever sent to a process without pidfile-based PID verification.
- No process is ever killed without explicit human approval (for production).
- No process is ever killed using pgrep | xargs kill patterns.
- Capture-only operations do not imply stop authority.