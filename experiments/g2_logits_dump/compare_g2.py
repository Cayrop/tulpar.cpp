#!/usr/bin/env python3
import argparse
import os
import struct
import sys
from array import array

def read_header(path):
    with open(path, "rb") as f:
        data = f.read(20)
    magic, version, seed, n_rows, n_vocab = struct.unpack_from("<IIIII", data)
    if magic != 0x474C4732:
        raise ValueError("bad magic")
    if version != 1:
        raise ValueError("bad version")
    return seed, n_rows, n_vocab

def read_toks(path, n_rows):
    if path.endswith(".bin"):
        path = path[:-4] + ".toks"
    elif not path.endswith(".toks"):
        path += ".toks"
    steps = []
    toks = []
    with open(path, "r", encoding="utf-8") as f:
        f.readline()
        for line in f:
            line = line.strip()
            if not line:
                continue
            step, tok = line.split("\t")
            steps.append(int(step))
            toks.append(int(tok))
    if len(steps) != n_rows or len(toks) != n_rows:
        raise ValueError(f"expected {n_rows} rows in {path}, got {len(steps)}")
    return steps, toks

def iter_logits(path, n_vocab, n_rows):
    with open(path, "rb") as f:
        f.seek(20)
        for _ in range(n_rows):
            buf = f.read(4 * n_vocab)
            if len(buf) != 4 * n_vocab:
                raise ValueError("short float row")
            logits = array("f")
            logits.frombytes(buf)
            yield logits

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("on")
    ap.add_argument("off")
    ap.add_argument("--threshold", type=float, default=1e-2)
    args = ap.parse_args()

    seed_a, n_rows_a, n_vocab_a = read_header(args.on)
    seed_b, n_rows_b, n_vocab_b = read_header(args.off)

    ok = True
    if (seed_a, n_rows_a, n_vocab_a) != (seed_b, n_rows_b, n_vocab_b):
        print("FAIL: header mismatch")
        print(f"  ON : seed={seed_a} n_rows={n_rows_a} n_vocab={n_vocab_a}")
        print(f"  OFF: seed={seed_b} n_rows={n_rows_b} n_vocab={n_vocab_b}")
        return 1

    steps_a, toks_a = read_toks(args.on, n_rows_a)
    steps_b, toks_b = read_toks(args.off, n_rows_b)

    first_token_mismatch = -1
    for step_idx in range(n_rows_a):
        if steps_a[step_idx] != steps_b[step_idx] or toks_a[step_idx] != toks_b[step_idx]:
            first_token_mismatch = step_idx
            break

    if first_token_mismatch >= 0:
        ok = False
        step_a = steps_a[first_token_mismatch]
        step_b = steps_b[first_token_mismatch]
        tok_a = toks_a[first_token_mismatch]
        tok_b = toks_b[first_token_mismatch]
        print(f"FAIL: first token mismatch at ON step {step_a} OFF step {step_b}: ON={tok_a} OFF={tok_b}")
        return 1

    max_abs_diff = 0.0
    diff_row = -1
    for row_idx, (logits_a, logits_b) in enumerate(zip(
        iter_logits(args.on, n_vocab_a, n_rows_a),
        iter_logits(args.off, n_vocab_b, n_rows_b),
    )):
        diff = max(abs(a - b) for a, b in zip(logits_a, logits_b))
        if diff > max_abs_diff:
            max_abs_diff = diff
            diff_row = row_idx

    print(f"tokens_match=true n_rows={n_rows_a} n_vocab={n_vocab_a} seed={seed_a}")
    print(f"logit_max_abs_diff={max_abs_diff:.9f} at row {diff_row}")
    if max_abs_diff < args.threshold:
        print(f"G2 PASS: text/token IDs identical and logit max abs diff < {args.threshold}")
    else:
        ok = False
        print(f"G2 FAIL: logit max abs diff >= {args.threshold}")

    return 0 if ok else 1

if __name__ == "__main__":
    sys.exit(main())
