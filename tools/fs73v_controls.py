#!/usr/bin/env python3
"""FS-73 independent verifier: pair facts and the colourability control (Theorem B's residue colouring).

The residue colouring at a prime of E4 = Q(sqrt-3, sqrt-11) above 2 (two such primes, s = 1, 2) is computed by
fs73v_lattice.residue_colour and checked against every directed edge of the ball, recomputed from U.
"""
from __future__ import annotations

import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs73v_lattice as L  # noqa: E402
import fs73v_sat as S  # noqa: E402

if __name__ == "__main__":
    B = L.build(verbose=False)
    out = {"build": B["info"]}
    # float sanity cross-check of the exact unit set (never a decision): every u in U has |u| = 1 in both embeddings
    mx = 0.0
    for u in B["U"]:
        z = L.from_int(u)
        for e in (0, 1):
            mx = max(mx, abs(abs(L.to_complex(z, e)) - 1.0))
    out["U_float_max_dev_from_1"] = mx
    out["U_int36"] = B["U"]
    # the Z-coordinates of 1/9 and 4/9 in the HNF basis of 36*Lambda
    out["one_ninth_coeffs"] = L.member(B["H"], (4, 0, 0, 0))
    out["four_ninths_coeffs"] = L.member(B["H"], (16, 0, 0, 0))
    out["one_36th_in_Lambda"] = L.member(B["H"], (1, 0, 0, 0)) is not None
    out["one_18th_in_Lambda"] = L.member(B["H"], (2, 0, 0, 0)) is not None
    pf = {}
    for name in S.PAIRS:
        p, q, facts = S.pair_facts(B, name)
        facts["n_common_neighbours"] = len(facts.pop("common_neighbours"))
        pf[name] = facts
    out["pairs"] = pf
    # residue colouring
    for s in (1, 2):
        col = [L.residue_colour(tuple(int(t) for t in v), s) for v in B["pts"]]
        chk = S.verify_colouring(B, col)
        idx = B["index"]
        sep = {}
        for name in S.PAIRS:
            p, q, _ = S.pair_facts(B, name)
            sep[name] = (col[idx[p]], col[idx[q]])
        chk["pair_colours"] = sep
        out[f"residue_colouring_s{s}"] = chk
    print(json.dumps(out, default=str, indent=1))
