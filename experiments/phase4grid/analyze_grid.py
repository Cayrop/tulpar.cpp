#!/usr/bin/env python3
# Phase-4-GRID: structural analysis of iq3xxs_grid (READ-ONLY w.r.t. llama.cpp)
# Parses the table verbatim from ggml/src/ggml-common.h and runs structure tests.
import itertools
import re
import sys

from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HEADER = str(ROOT / "ggml/src/ggml-common.h")
OUT_VALUES = str(ROOT / "experiments/phase4grid/iq3xxs_grid_values.txt")
M32 = 0xFFFFFFFF


def parse_table():
    with open(HEADER, "r") as f:
        lines = f.readlines()
    start = None
    for i, ln in enumerate(lines):
        if ln.startswith("GGML_TABLE_BEGIN(uint32_t, iq3xxs_grid, 256)"):
            start = i + 1
            break
    if start is None:
        sys.exit("iq3xxs_grid not found")
    vals = []
    for ln in lines[start:]:
        if ln.startswith("GGML_TABLE_END()"):
            break
        vals.extend(int(tok, 16) for tok in re.findall(r"0x([0-9a-fA-F]{8})", ln))
    return vals


def bytes_of(v):
    # byte 0 = LSB (this is how __vsub4/dp4a lanes see it)
    return [(v >> (8 * k)) & 0xFF for k in range(4)]


def is_function_of_mask(grid_plane, mask):
    # grid_plane: list of 256 byte values. True if b[i] depends only on (i & mask).
    seen = {}
    for i in range(256):
        key = i & mask
        if key in seen:
            if seen[key] != grid_plane[i]:
                return False
        else:
            seen[key] = grid_plane[i]
    return True


def main():
    g = parse_table()
    print(f"parsed values: {len(g)}")
    assert len(g) == 256
    print(f"distinct values: {len(set(g))}")

    # ---------- values file ----------
    with open(OUT_VALUES, "w") as f:
        f.write("# iq3xxs_grid - extracted verbatim from ggml/src/ggml-common.h:1018-1049\n")
        f.write("# declaration: GGML_TABLE_BEGIN(uint32_t, iq3xxs_grid, 256)\n")
        f.write("# format: index  hex_u32  dec_u32  bytes(b3.b2.b1.b0 big-endian of printed hex)\n")
        for i, v in enumerate(g):
            b = bytes_of(v)
            f.write(f"{i:3d}  0x{v:08X}  {v:10d}  {b[3]:3d}.{b[2]:3d}.{b[1]:3d}.{b[0]:3d}\n")
    print(f"wrote {OUT_VALUES}")

    # ---------- D. value representation ----------
    all_bytes = set()
    for v in g:
        all_bytes.update(bytes_of(v))
    sb = sorted(all_bytes)
    print(f"\n[D] distinct byte values across all planes: {len(sb)}")
    print(f"[D] byte alphabet (dec): {sb}")
    print(f"[D] byte alphabet (hex): {[hex(x) for x in sb]}")
    print(f"[D] max byte = {max(sb)} (fits int8 unsigned range, all >= 0)")
    # is alphabet the same for every plane?
    for p in range(4):
        ps = sorted({bytes_of(v)[p] for v in g})
        print(f"[D] plane {p} alphabet (size {len(ps)}): {ps}")

    # per-plane distinct counts
    for p in range(4):
        print(f"[D] plane {p}: {len({bytes_of(v)[p] for v in g})} distinct values")

    # ---------- A. symmetry ----------
    print("\n[A] symmetry tests (matches out of 256):")
    def cnt(pred):
        return sum(1 for i in range(256) if pred(i))
    print(f"  grid[i] == grid[i^0xFF]                : {cnt(lambda i: g[i] == g[i ^ 0xFF])}")
    print(f"  grid[i] == grid[255-i]                 : {cnt(lambda i: g[i] == g[255 - i])}")
    print(f"  grid[i] == bytewise_neg255(grid[i^0xFF]): "
          f"{cnt(lambda i: g[i] == (~g[i ^ 0xFF]) & M32)}")
    # signed negation: -x as int8 per lane (mod 256), i.e. sign-flip of symmetric-around-0 lattice
    def sneg(v):
        return sum((((256 - b) % 256) << (8 * k)) for k, b in enumerate(bytes_of(v)))
    pairs = sum(1 for i in range(256) if any(g[j] == sneg(g[i]) and j != i for j in range(256)))
    selfneg = sum(1 for i in range(256) if sneg(g[i]) == g[i])
    print(f"  entries whose signed negation exists in table: {pairs} (+{selfneg} self-negated)")

    # ---------- monotonicity ----------
    mono_inc = all(g[i] < g[i + 1] for i in range(255))
    print(f"\n[table] strictly increasing as u32: {mono_inc}")

    # ---------- B. nibble decomposition ----------
    print("\n[B] nibble decomposition: grid[i] =?= combine(T_hi[i>>4], T_lo[i&0xF])")
    # for abelian ops the interaction term must vanish:
    #   xor-combine: g[h1,l] ^ g[h2,l]      must be independent of l
    #   add-combine: g[h1,l] - g[h2,l] (mod 2^32) must be independent of l
    def test_xor():
        for h1 in range(16):
            for h2 in range(16):
                ref = None
                for l in range(16):
                    d = g[16 * h1 + l] ^ g[16 * h2 + l]
                    if ref is None:
                        ref = d
                    elif d != ref:
                        return False
        return True

    def test_addsub():
        for h1 in range(16):
            for h2 in range(16):
                ref = None
                for l in range(16):
                    d = (g[16 * h1 + l] - g[16 * h2 + l]) & M32
                    if ref is None:
                        ref = d
                    elif d != ref:
                        return False
        return True

    print(f"  combine=xor : {test_xor()}")
    print(f"  combine=add : {test_addsub()}")
    print(f"  combine=sub : {test_addsub()}")

    # OR decomposition: bit-plane separability (each bit position driven only by hi or only by lo)
    or_ok = True
    detail = []
    for bitpos in range(32):
        dep_h_only = all(
            len({(g[16 * h + l] >> bitpos) & 1 for h in range(16)}) == 1 for l in range(16)
        )
        dep_l_only = all(
            len({(g[16 * h + l] >> bitpos) & 1 for l in range(16)}) == 1 for h in range(16)
        )
        ok = dep_h_only or dep_l_only
        detail.append((bitpos, "H" if dep_h_only else ("L" if dep_l_only else "-")))
        or_ok &= ok
    print(f"  combine=or  (bit-plane separability): {or_ok}")
    print(f"  per-bit driver (H=hi nibble, L=lo nibble, -=mixed): {''.join(d[1] for d in detail)}")

    # per-byte-lane combine variants (add mod 256 per lane), common in SIMD thinking
    def test_lane_add():
        for h in range(16):
            ref = None
            for l in range(16):
                pass
        # full test: b_lane(h,l) must equal Th[h] + Tl[l] mod 256 per lane
        for p in range(4):
            plane = [[bytes_of(g[16 * h + l])[p] for l in range(16)] for h in range(16)]
            # interaction test per lane: plane[h1][l]-plane[h2][l] mod 256 independent of l
            for h1 in range(16):
                for h2 in range(16):
                    ref = None
                    for l in range(16):
                        d = (plane[h1][l] - plane[h2][l]) % 256
                        if ref is None:
                            ref = d
                        elif d != ref:
                            return False
        return True
    print(f"  combine=add per byte lane (mod 256): {test_lane_add()}")

    # ---------- B2. per-plane functional dependency on subsets of index bits ----------
    print("\n[B2] per byte plane: minimal index-bit mask m s.t. plane_p(i) = f(i & m)")
    planes = [[[bytes_of(v)[p] for v in g]] for p in range(4)]
    for p in range(4):
        plane = [bytes_of(v)[p] for v in g]
        found = None
        for k in range(0, 9):
            hits = [m for m in range(256) if bin(m).count("1") == k and is_function_of_mask(plane, m)]
            if hits:
                found = (k, hits[:8])
                break
        if found:
            k, examples = found
            ex = ", ".join(f"0x{m:02X}" for m in examples)
            print(f"  plane {p}: minimal mask popcount = {k} (examples: {ex})")
        else:
            print(f"  plane {p}: depends on ALL 8 index bits")

    # joint: whole u32 as function of mask (expected: needs all 8 bits since 256 distinct)
    for k in range(0, 9):
        hits = [m for m in range(256) if bin(m).count("1") == k and is_function_of_mask(g, m)]
        if hits:
            print(f"  joint u32: minimal mask popcount = {k}")
            break
    else:
        print("  joint u32: depends on ALL 8 index bits")

    # ---------- C. arithmetic structure ----------
    print("\n[C] arithmetic structure tests:")
    diffs = {(g[i + 1] - g[i]) & M32 for i in range(255)}
    print(f"  linear (a*i+b): distinct first differences = {len(diffs)} (linear iff 1)")
    # piecewise: how many adjacent steps change exactly one byte lane?
    one_lane = sum(
        1 for i in range(255) if sum(1 for p in range(4) if bytes_of(g[i])[p] != bytes_of(g[i + 1])[p]) == 1
    )
    print(f"  adjacent pairs differing in exactly 1 byte lane: {one_lane}/255")

    # popcount dependence
    pop_ok = all(len({g[i] for i in range(256) if bin(i).count("1") == c}) == 1 for c in range(9))
    print(f"  grid[i] determined by popcount(i): {pop_ok}")

    # bit reversal
    def rev8(x):
        r = 0
        for _ in range(8):
            r = (r << 1) | (x & 1)
            x >>= 1
        return r
    rev_match = sum(1 for i in range(256) if g[i] == g[rev8(i)])
    print(f"  grid[i] == grid[bitrev8(i)]: {rev_match}/256")

    # gray-code walk: does index order visit rank-tuples in gray order?
    # map each entry to its per-plane symbol ranks within plane alphabet
    alpha = {}
    for p in range(4):
        alpha[p] = sorted({bytes_of(v)[p] for v in g})
    ranks = []
    for v in g:
        b = bytes_of(v)
        ranks.append(tuple(alpha[p].index(b[p]) for p in range(3, -1, -1)))  # (r_b3,r_b2,r_b1,r_b0)
    lex_sorted = all(
        (ranks[i][0], ranks[i][1], ranks[i][2], ranks[i][3])
        <= (ranks[i + 1][0], ranks[i + 1][1], ranks[i + 1][2], ranks[i + 1][3])
        for i in range(255)
    )
    print(f"  rank tuples non-decreasing in i (lexicographic enumeration): {lex_sorted}")

    # combinatorial number system check: are ALL C(11,4)=330 nondecreasing-in-rank tuples present?
    # NOTE: numeric sort of u32 == lex sort on (b3,b2,b1,b0); rank tuple lex order matches
    all_ranks = set(ranks)
    space = list(itertools.product(range(8), repeat=4))
    nd_space = [t for t in space if t[0] <= t[1] <= t[2] <= t[3]]
    present_nd = [t for t in nd_space if t in all_ranks]
    print(f"  nondecreasing rank tuples possible: {len(nd_space)}; present in table: {len(present_nd)}")
    inc_space = [t for t in space if t[0] < t[1] < t[2] < t[3]]
    present_inc = [t for t in inc_space if t in all_ranks]
    print(f"  strictly-increasing rank tuples possible: {len(inc_space)}; present: {len(present_inc)}")

    # ---------- E. crude index-distribution note ----------
    print("\n[E] index-space coverage: 256 distinct entries -> every q3 byte value maps to a unique entry.")
    print("    q3 bytes are encoder-chosen centroid ids; distribution is data-dependent,")
    print("    expected near-uniform over 0..255 for typical weights (no exploitable skew guaranteed).")

    print("\ndone.")


if __name__ == "__main__":
    main()
