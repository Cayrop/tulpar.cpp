# V2 Kernel Attribution — Blockers

## B-1: rocprofv3 Assertion Failure

**Severity:** BLOCKER
**Symptom:** `std::optional<registered_library_api_table>::operator->() const: Assertion 'this->_M_is_engaged()' failed`
**Impact:** Cannot use rocprofv3 (preferred tool) for kernel tracing
**Workaround:** Use rocprofv2 (deprecated but functional)

## B-2: rocprofv2 Process Termination

**Severity:** HIGH
**Symptom:** Server exits after first request cycle when wrapped by rocprofv2
**Impact:** Each arm requires full server restart (~4s startup)
**Workaround:** Automated restart script per arm

## B-3: 128k Timeout

**Severity:** MEDIUM
**Symptom:** T-V2-128k-OFF prefill timed out at 300s (88k/127k tokens processed)
**Impact:** Decode not captured for 128k arm
**Note:** Prefill attribution still valid (FA=50.2%, MMQ=42.8%)

## B-4: ptrace_scope (resolved)

**Severity:** LOW
**Symptom:** `rocprofv3 --attach` fails with PTRACE_SEIZE error
**Resolution:** User set `sysctl -w kernel.yama.ptrace_scope=0`
