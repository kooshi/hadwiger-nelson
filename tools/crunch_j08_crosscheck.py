#!/usr/bin/env python3
"""J08 stage 5: measured cross-check of m(c) (hence kappa, chi_char) at the fields' deciding targets.

For q in {59, 83, 131, 167} (the targets SIX-e's minima and the ramified place above 167 rest on) every c in F_q^x:
m(c) from SIX-a's law (tools/crunch_j08_kappa.m_law) against m(c) read directly off the circle x^2 + y^2 = 1
(tools/crunch_j08_kappa.m_direct).  Plant: the law with t^2 + 4c must disagree (fires at the comparison); twin passes.
Writes data/fs91/j08/crosscheck.json always.
"""
import json
import sys
from fractions import Fraction
from math import ceil
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from crunch_j08_kappa import m_direct, m_law  # noqa: E402

OUT = Path(__file__).resolve().parent.parent / "data" / "fs91" / "j08" / "crosscheck.json"
rep, ok = {"kind": "fs91-j08-crosscheck", "rows": []}, True
for q in (59, 83, 131, 167):
    law = {c: m_law(q, c) for c in range(1, q)}
    dire = {c: m_direct(q, c) for c in range(1, q)}
    best = max(dire.values())
    agree = law == dire
    ok &= agree
    rep["rows"].append({"q": q, "agree": agree, "kappa_direct": str(Fraction(best, q)), "chi_char_direct": ceil(Fraction(q, best))})
    print(f"q={q}: law == direct at all {q-1} c: {agree}; direct kappa={Fraction(best, q)} chi_char={ceil(Fraction(q, best))}")
planted = {c: m_law(83, c, +1) for c in range(1, 83)}
fired = [c for c in range(1, 83) if planted[c] != m_direct(83, c)]
rep["plant"] = {"fired": bool(fired), "first_c": fired[:3]}
ok &= bool(fired)
print(f"plant t^2+4c at 83: fired={bool(fired)} at c={fired[:3]}")
rep["ok"] = bool(ok)
OUT.write_text(json.dumps(rep, indent=1) + "\n")
print("ALL OK" if ok else "FAILED")
sys.exit(0 if ok else 1)
