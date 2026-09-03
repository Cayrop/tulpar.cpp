# Distortion experiment: iq3_xxs D4-256 grid vs alternative grids, Gaussian weights.
# Mirrors quantize_row_iq3_xxs_impl (ggml-quants.c:3938-4150):
#   per 32-elem subblock: signs exact, 31 scale candidates is=-15..15: s = max/(15+is*0.2),
#   per 4-group nearest grid codeword, LS scale refine, keep best candidate.
#   Decoder (dequantize_row_iq3_xxs:2587-2599): y = d*(l+1)/2 * grid_magnitude * sign.
# Difference from real: block-level d = max_scale/31 shared over 8 subblocks is replaced by
# per-subblock continuous d; common to all schemes, so relative comparison is clean.
import json, numpy as np

g = json.load(open("iq3xxs_grid_values.json"))["values"]
GRID = np.array([[ (v >> (8*j)) & 0xff for j in range(4)] for v in g], dtype=np.float64)  # 256 x 4 magnitudes
L2MAG = np.array([4*(2*l+1) - 2*(l==7) for l in range(8)], dtype=np.float64)
COSSET = np.stack(np.meshgrid(*[L2MAG[::2]]*4), axis=-1).reshape(-1, 4)
FULL = np.stack(np.meshgrid(*[L2MAG]*4), axis=-1).reshape(-1, 4)
print("grid:", GRID.shape, "coset:", COSSET.shape, "full:", FULL.shape)
print("coset set == grid set?", set(map(tuple, COSSET.tolist())) == set(map(tuple, GRID.tolist())))
print("grid byte set:", sorted(np.unique(GRID.ravel().tolist())))

IS = np.arange(-15, 16)

def quant_subblock(w, grid):
    # w: 32-vector (signs folded, magnitude values). returns mse of best scale candidate
    w = np.abs(w).reshape(8, 4)
    mx = w.max()
    if mx < 1e-6:
        return 0.0
    best = np.inf
    for is_ in IS:
        s = mx / (15.0 + is_ * 0.2)
        # nearest codeword per group under this scale: minimize ||w - s*m||^2
        d = (w[:, None, :] - s * grid[None, :, :]) ** 2
        m = grid[np.argmin(d.sum(axis=2), axis=1)]  # 8 x 4 chosen magnitudes
        num = (w * m).sum(); den = (m * m).sum()
        s2 = num / den if den else s
        err = (w - s2 * m) ** 2
        best = min(best, err.sum())
    return best


rng = np.random.default_rng(42)
N = 1500
for desc, make in [("N(0,1)", lambda: rng.standard_normal((N, 32))),
                   ("mixture 50% N(0,0.3) + 50% N(0,1.5)",
                    lambda: np.where(rng.random((N, 32)) < 0.5,
                                     0.3 * rng.standard_normal((N, 32)),
                                     1.5 * rng.standard_normal((N, 32))))]:
    w = make()
    power = (w ** 2).sum()
    for name, fn in [("D4-256 (real grid)", lambda x: quant_subblock(x, GRID)),
                     ("even-level coset (0,2,4,6)^4", lambda x: quant_subblock(x, COSSET)),
                     ("unconstrained 4096 (upper bound = scalar 3-bit)", lambda x: quant_subblock(x, FULL))]:
        mse = np.array([fn(w[i]) for i in range(N)])
        print(f"{desc:36s} {name:32s} MSE={mse.mean():10.5f}  {100*mse.mean()/power:8.4f}%  SNR={10*np.log10(power/mse.mean()):6.2f} dB")
    print()
