#!/usr/bin/env python3
"""J25 stage 2: the [AmbrusEtAl2023] grade upgrade (J49 §3.3), applied with every anchor asserted exactly once.

Usage: apply_ambrus.py [--plant]   (--plant demands an anchor no file holds: must exit 1 and write nothing)
"""
import sys, pathlib
ROOT = pathlib.Path('/home/kooshi/source/lean-dir')
NEW_RECHECK = ("its certificate re-checked here, cert + hand: `m₁(ℝ²) ≤ 0.246989 < 0.2470` — exact on H1–H3 and H6 (J26, "
               "`plans/PA-ambrus2023-audit.md`), ball arithmetic on H4 and H5 (J49, `plans/FS100-KT1-ambrus-ball.md`); Watson §13.74 "
               "and §15.31 cited; the authors' Mathematica notebook not run, and its similarity-for-congruence and Lipschitz gaps shown harmless")
OLD_RECHECK = ("its certificate re-checked here — J26, `plans/PA-ambrus2023-audit.md`: exact on the finite obligations, double precision "
               "on the Bessel obligation with Lipschitz constants derived here; the authors' Mathematica notebook not run, and its "
               "similarity-for-congruence and Lipschitz gaps shown harmless")
EDITS = [
  # (file, old, new, expected count)
  ('LEDGER.md',
   "**its certificate re-checked here** (J26, `plans/PA-ambrus2023-audit.md`: exact on the finite obligations, double precision on the "
   "Bessel obligation with Lipschitz constants derived here; the authors' Mathematica notebook not run, and its similarity-for-congruence "
   "and Lipschitz gaps shown harmless)",
   "**its certificate re-checked here, cert + hand: `m₁(ℝ²) ≤ 0.246989`** (exact on H1–H3 and H6, J26, `plans/PA-ambrus2023-audit.md`; "
   "ball arithmetic on H4 and H5, J49, `plans/FS100-KT1-ambrus-ball.md`; Watson §13.74 and §15.31 cited; the authors' Mathematica notebook "
   "not run, and its similarity-for-congruence and Lipschitz gaps shown harmless)", 1),
  ('LEDGER.md',
   "`[AmbrusEtAl2023]` Thm 1 (its certificate re-checked by J26), FS-66's certificates at 11 and 19",
   "`[AmbrusEtAl2023]` Thm 1 (its certificate re-checked, cert + hand: J26 exact, J49 ball arithmetic; `m₁(ℝ²) ≤ 0.246989`), FS-66's "
   "certificates at 11 and 19", 1),
  ('LEDGER.md',
   "| hand + external (AmbrusEtAl2023 at real places; its certificate re-checked by J26) |",
   "| hand + external (AmbrusEtAl2023 at real places; its certificate re-checked by J26 and J49, cert + hand) |", 1),
  ('plans/FS86-derivation.md', OLD_RECHECK, NEW_RECHECK, 2),
  ('plans/R88-derivation.md',
   "computer-assisted; its certificate re-checked by J26, `plans/PA-ambrus2023-audit.md`);",
   "computer-assisted; its certificate re-checked, cert + hand, `m₁(ℝ²) ≤ 0.246989`: exact on H1–H3 and H6 by J26,\n"
   "`plans/PA-ambrus2023-audit.md`, ball arithmetic on H4 and H5 by J49, `plans/FS100-KT1-ambrus-ball.md`);", 1),
  ('BIBLIOGRAPHY.md',
   "**re-checked by J26**, `plans/PA-ambrus2023-audit.md`; its eq. (23)",
   "**re-checked by J26**, `plans/PA-ambrus2023-audit.md` (exact on H1–H3 and H6); **H4 and H5 re-checked in ball arithmetic by J49** "
   "(`tools/fs100_kt1_ball.py`, `plans/FS100-KT1-ambrus-ball.md`), so `m₁(ℝ²) ≤ 0.246989 < 0.2470` is [cert + hand] here; its eq. (23)", 1),
  ('plans/PA-ambrus2023-audit.md', "`J₀` at about 640,000 points",
   "`J₀` at 493,471 distinct points (about 646,000 evaluations with the refined grids' overlaps; count corrected by J49)", 2),
  ('plans/PA-ambrus2023-audit.md',
   "not interval-certified; worst margin 2.3·10⁻⁶); Watson §13.74, §15.31 cited. Address: `tools/j26_ambrus_check.py`,\n"
   "  `data/pa-ambrus2023/j26-check.out`; §3.2.",
   "not interval-certified; worst margin 2.3·10⁻⁶); Watson §13.74, §15.31 cited. Address: `tools/j26_ambrus_check.py`,\n"
   "  `data/pa-ambrus2023/j26-check.out`; §3.2. *Superseded 2026-09-26 (front-page job J25, from J49): H4 and H5 are certified in ball\n"
   "  arithmetic — J49-T1, J49-T2 [cert], `plans/FS100-KT1-ambrus-ball.md` — so `m₁(ℝ²) ≤ 0.246989 < 0.2470` is [cert + hand]; every\n"
   "  \"not interval-certified\" and \"on trust\" below is J26's state before J49. J49-T3 adds to J26-T3: on `[1000, 10⁴]` the notebook's\n"
   "  constant 0.03 is not only unjustified but false (harmless here).*", 1),
]

def main():
    plant = '--plant' in sys.argv
    edits = list(EDITS)
    if plant:
        edits.append(('LEDGER.md', 'an anchor no file holds (J25 plant)', 'x', 1))
    texts = {}
    for f, old, new, n in edits:
        p = ROOT / f
        texts.setdefault(f, p.read_text(encoding='utf-8'))
        c = texts[f].count(old)
        if c != n:
            print(f'FAIL: {f}: anchor found {c} times, expected {n}: {old[:80]!r}')
            sys.exit(1)
        if texts[f].count(new) != 0 and new not in old:
            print(f'FAIL: {f}: replacement already present: {new[:80]!r}'); sys.exit(1)
    for f, old, new, n in edits:
        texts[f] = texts[f].replace(old, new)
    for f, t in texts.items():
        (ROOT / f).write_text(t, encoding='utf-8')
        print('wrote', f)
    print('RESULT: PASS')

if __name__ == '__main__':
    main()
