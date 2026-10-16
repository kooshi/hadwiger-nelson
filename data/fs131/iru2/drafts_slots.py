#!/usr/bin/env python3
"""FS131-IRU2 stage 4: every slot the drafts name occurs exactly once in its file as `main` holds it (whitespace collapsed,
since a slot quoted on one line can wrap in the file). Usage: python3 -I drafts_slots.py <main-ref> [--plant]
--plant: changes one character of the first slot; it must read 0 and the run must exit 1."""
import re, subprocess, sys
SLOTS = [
    ("CLAUDE.md", "the current audit reads 10998 clean and 5 declared purchases, and 120 imported (and 575 axiom-free; 11,698 records at FS131-IFR1, the density form of the collapse, 2026-10-16)"),
    ("CLAUDE.md", "`axioms=3 rests=168 named=19 inline=14 outside=7 ours=21 open=5 takes=109 mentions=2`"),
    ("CLAUDE.md", "`declarations=22683 refutations-skipped=245 sites=1465`"),
    ("CLAUDE.md", "`vacuous=0 stale=0 declared=3 witnessed=40 generic=1420 unknown=2`"),
    ("CLAUDE.md", "Last filed: **the density form of the collapse** (FS131-KFR1, FS131-IFR1, FS131-IFR2, 2026-10-16: four modules through the gate on `b8cef1f36`, among them `α₁(F²) = max(m₁(ℝ²), ⨆_P r_P)` at every real number field with no hypothesis, `χ_f(F²) = 1/α_loc(F)`, the fractional collapse, and a finite triangle-free six-chromatic unit-distance graph. This is row 129's field clause; no value of `χ(ℝ²)` moved.); before it,"),
    ("CLAUDE.md", "the collapse, `χ(F²) = χ(ℝ²)` at uniformly thick fields, ℚ(√635087) and de Grey's field (row 128);"),
    ("LEDGER.md", "whether CLG-g's exception is ever realised; a kernel proof."),
    ("LEDGER.md", "That statement ranges over a type the kernel does not show to be non-empty (a stable prime exists by Chebotarev), and the splitting itself is not stated"),
    ("ROADMAP.md", "with its form that takes no hypothesis, `min(χ(F²), 5) = min(L(F), 5)` (`Rigidity.min_chromaticNumber_five_eq_min_localBound_five`)."),
    ("ROADMAP.md", "2. **Lemma C′** (row 100): for a real number field with no ramified stable dyadic prime, the unit-vector ring equals the ring of elements integral at every stable prime."),
    ("ROADMAP.md", "It was taken out of the library when the chain landed, because nothing read it and its proof was a `sorry`. The statement and its hand route are kept in `data/fs131/lch1/ring-scope-lemma-c-prime.lean`."),
    ("plans/KERNEL-HOLDS.md", "(`QuadraticPrime.exists_maximal_card_eq`, `…_of_ramified`)"),
    ("plans/POROS-2026-10-13-number-field-findings.md", "**Rank 8 — C8. The ring of unit vectors.**"),
    ("plans/FS131-KCS1-class-plan.md", "### 2.6 B — Lemma C′ (≈ 700 lines; route FS91-J10's, refined here)"),
]
ref = [a for a in sys.argv[1:] if a != '--plant'][0]
slots = list(SLOTS)
if '--plant' in sys.argv:
    f, s = slots[0]; slots[0] = (f, s.replace('10998', '10989', 1))
bad = 0
cache = {}
for f, s in slots:
    if f not in cache:
        cache[f] = re.sub(r'\s+', ' ', subprocess.run(['git', 'show', f'{ref}:{f}'], capture_output=True, text=True, check=True).stdout)
    n = cache[f].count(re.sub(r'\s+', ' ', s))
    ok = n == 1
    bad += not ok
    print(f"{'OK ' if ok else 'BAD'} {n} {f}: {s[:90]}")
print('SLOTS', len(slots), 'BAD', bad)
sys.exit(1 if bad else 0)
