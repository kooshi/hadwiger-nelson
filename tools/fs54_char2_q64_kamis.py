"""Independent sets of U_64 = Cay(F_4096, mu_65) by KaMIS (FS-54): export, run, verify, record.

  python3 tools/fs54_char2_q64_kamis.py export             # build/fs54-u64/u64.graph (METIS, 1-indexed)
  python3 tools/fs54_char2_q64_kamis.py record SEED OUT     # verify KaMIS's output file OUT and write the record

Field: F_2[t]/(t^12 + t^3 + 1) (data/fs54/char2/poly64.txt = 4105), elements as 12-bit masks; vertex i is the element i;
i ~ j iff i XOR j lies in mu_65 = {x : x^65 = 1}, rebuilt here by carry-less arithmetic and compared with
data/fs54/char2/mu64.npy. A record states a verified independent set — a LOWER bound on alpha and nothing else — plus
its translation stabiliser {w : A + w = A} (the largest F_2-subspace the set is periodic under).
"""
import json
import sys
from pathlib import Path

import numpy as np

POLY, M2, Q = 4105, 12, 64
N = 1 << M2
ROOT = Path(__file__).resolve().parent.parent
GRAPH = ROOT / "build" / "fs54-u64" / "u64.graph"


def clmul(a, b):
    r = 0
    while b:
        if b & 1:
            r ^= a
        b >>= 1
        a <<= 1
        if a >> M2:
            a ^= POLY
    return r


def power(x, e):
    r = 1
    while e:
        if e & 1:
            r = clmul(r, x)
        x = clmul(x, x)
        e >>= 1
    return r


def unit_circle():
    mu = [x for x in range(1, N) if power(x, Q + 1) == 1]
    assert len(mu) == Q + 1, len(mu)
    stored = sorted(int(x) for x in np.load(ROOT / "data" / "fs54" / "char2" / "mu64.npy"))
    assert stored == mu, "mu64.npy disagrees with the carry-less rebuild"
    return mu


def export():
    mu = unit_circle()
    GRAPH.parent.mkdir(parents=True, exist_ok=True)
    with open(GRAPH, "w") as f:
        f.write(f"{N} {N * len(mu) // 2}\n")
        for i in range(N):
            f.write(" ".join(str(j + 1) for j in sorted(i ^ u for u in mu)) + "\n")
    print(f"wrote {GRAPH}: {N} vertices, {N * len(mu) // 2} edges, {len(mu)}-regular")


def record(seed, out):
    mu = unit_circle()
    bits = [int(line.strip()) for line in open(out) if line.strip()]
    assert len(bits) == N, len(bits)
    A = [i for i in range(N) if bits[i] == 1]
    S = set(A)
    bad = [(a, a ^ u) for a in A for u in mu if (a ^ u) in S]
    if bad:
        raise SystemExit(f"REFUSED: not independent, e.g. {bad[0]} — a pipeline bug, not a finding")
    stab = [w for w in range(N) if all((a ^ w) in S for a in A)]
    dim = len(stab).bit_length() - 1
    rec = {
        "graph": "U_64 = Cay(F_4096, mu_65), F_2[t]/(t^12+t^3+1), vertex = element mask, i ~ j iff i^j in mu_65",
        "claim": "a verified independent set: alpha(U_64) >= size. Nothing about any upper bound.",
        "tool": "KaMIS redumis (OMP_NUM_THREADS=1)", "seed": seed, "size": len(A),
        "thresholds": {"hoffman_and_delsarte_lp_upper": 768, "six_colours_need": 683, "seven_colours_need": 586,
                       "linear_8_colouring_class": 512},
        "translation_stabiliser_dim": dim, "set": A,
    }
    dst = ROOT / "data" / "fs54" / "char2" / f"kamis-q64-seed{seed}.json"
    dst.write_text(json.dumps(rec))
    print(f"seed {seed}: independent set of {len(A)} VERIFIED; periodic under an F_2-subspace of dimension {dim}; -> {dst}")


if __name__ == "__main__":
    if sys.argv[1] == "export":
        export()
    elif sys.argv[1] == "record":
        record(int(sys.argv[2]), sys.argv[3])
