#!/usr/bin/env python3
"""J25 stage 4: the crunch index's rows for J36, J37-J39, J45-J49 and FS-100 (addresses only), and the post-close inventory's ticks.
Every anchor asserted at its expected count before anything is written.  Usage: apply_stage4.py [--plant]"""
import sys, pathlib
ROOT = pathlib.Path('/home/kooshi/source/lean-dir')
IDX = 'plans/CRUNCH-2026-09-25-INDEX.md'
INV = 'plans/CRUNCH-2026-09-25-post-close-inventory.md'
E = []
def rep(f, old, new, n=1): E.append((f, old, new, n))

rep(IDX, "| **G79** — minted at the front page | `plans/CRUNCH-2026-09-25-post-close-inventory.md` row 25 | — | — | — | — | `CLAUDE.md` § Grokkings (J44) |\n",
 "| **G79** — minted at the front page | `plans/CRUNCH-2026-09-25-post-close-inventory.md` row 25 | — | — | — | — | `CLAUDE.md` § Grokkings (J44) |\n"
 "\n## Addendum — the last jobs of the crunch (J25, the front page; addresses only)\n\n"
 "| item | record | tools and data | report | where it lands |\n|---|---|---|---|---|\n"
 "| **J36** — Poros: \"reads infinitely many primes\" named and ranked | `plans/POROS-2026-09-25-infinitely-many-primes.md` | `tools/crunch_j36_band7.py` | J36 | FS-100 (§2–§3); `plans/FS84-close-inventory.md` |\n"
 "| **J37** — Poros: the wanted poster at ℚ(√47), four colours | `plans/POROS-2026-09-25-wanted-poster-47.md` | — | J37 | FS-100 (§2.1, §3, §6.4 P1) |\n"
 "| **J38** — Poros: the wanted poster over the type-(B) fields | `plans/POROS-2026-09-25-wanted-poster-59.md` | `tools/crunch_j38_band.py`; `data/crunch-2026-09-25/j38-band.out` | J38 | FS-100 (§2.3, §9); FS-98's re-aim |\n"
 "| **J39** — Poros: the wanted poster at ℚ(√167), five colours | `plans/POROS-2026-09-25-wanted-poster-167.md` | `tools/crunch_j39_thick.py`; `data/crunch-2026-09-25/j39/` | J39 | FS-100 (§2.3, §2.5); FS-59's and FS-96's re-aims |\n"
 "| **J45** — SI and its companions, derived | `plans/FS84-SI-D-derivation.md` | `tools/crunch_j45_gap7.py` | J45 | FS-100 (§2.2); `plans/FS84-close-inventory.md` |\n"
 "| **J46** — the same, blind | `plans/FS84-SI-V-verification.md` | `tools/crunch_j46_checks.py`, `tools/crunch_j46_g2.py` | J46 | FS-100 (§2.2) |\n"
 "| **J47** — FS-100 minted | `data/crunch-2026-09-25/j47-record.md` | — | J47 | `plans/STUB-measure-rigidity-three-fields.md`; `plans/FRONTIER-STUBS.md` rank 3 |\n"
 "| **J48** — FS-100 stage 1, the bundled blind check | `plans/FS100-BC-verification.md` | `tools/crunch_j48_places.py`, `tools/crunch_j48_controls.py`; `data/fs100/j48/` | J48 | FS-100 (status block, §2.3) |\n"
 "| **J49** — FS-100 stage 2, KT-1 | `plans/FS100-KT1-ambrus-ball.md` | `tools/fs100_kt1_ball.py`, `tools/fs100_kt1_grid.py`; `data/fs100/kt1/` | J49 | `LEDGER.md` rows 92, 112 (grades); `BIBLIOGRAPHY.md` `[AmbrusEtAl2023]`; `plans/PA-ambrus2023-audit.md` |\n"
 "| **FS-100** — minted, stages 1–2 done, FS-97 absorbed; open, not run | `plans/STUB-measure-rigidity-three-fields.md` | — | J47, J48, J49 | `plans/FRONTIER-STUBS.md` rank 3; `CLAUDE.md` § Paths forward (a pointer) |\n")

# inventory ticks
def tick(row, old_status, new_status):
    E.append((INV, old_status, new_status, 1))
tick(32, "| owner check after J44 | open |",
 "| owner check after J44 | done — Kooshi set the ceiling at 325,000 until the crunch ends (6460c11e); J25 leaves `CLAUDE.md` under 300,000 (J25 record, stage 6) |")
tick(34, "| J38 record §2.2, tools/crunch_j38_band.py; data/crunch-2026-09-25/reports/J38.md | open |",
 "| J38 record §2.2, tools/crunch_j38_band.py; data/crunch-2026-09-25/reports/J38.md | done at J25 stage 3 (eefcc02a): FS-100 §9, as the control card's evidence |")
tick(35, "| J38 record §4.4, §4.5 | open |",
 "| J38 record §4.4, §4.5 | done at J25 stage 3 (eefcc02a): FS-98 re-aimed to T-B1 alone (J38's R1 verbatim); DP and the control card homed in FS-100, which absorbed FS-97 |")
tick(37, "| CLAUDE.md § Paths forward, J44 record stage 3 | open |",
 "| CLAUDE.md § Paths forward, J44 record stage 3 | done at 15f5f37e (J44 stage 3) |")
tick(38, "| BIBLIOGRAPHY.md § A; plans/FS86-row88-rigidity.md §R-close 4.4 | open |",
 "| BIBLIOGRAPHY.md § A; plans/FS86-row88-rigidity.md §R-close 4.4 | done at 974f8810 (J44 stage 5) |")
tick(39, "| [BachocEtAl2014]'s § A row said \"not held, abstract only\" while § B held it; now agree | BIBLIOGRAPHY.md | open |",
 "| [BachocEtAl2014]'s § A row said \"not held, abstract only\" while § B held it; now agree | BIBLIOGRAPHY.md | done at 974f8810 (J44 stage 5) |")
tick(42, "| J47 held item 1; J39 R4 | open |",
 "| J47 held item 1; J39 R4 | done at J25 stage 3 (eefcc02a): verbatim in FS-59's stub and `plans/FRONTIER-STUBS.md`; a pointer in `CLAUDE.md` |")

def main():
    edits = list(E)
    if '--plant' in sys.argv:
        edits.append((INV, 'an anchor no file holds (J25 plant)', 'x', 1))
    texts = {}
    for f, old, new, n in edits:
        texts.setdefault(f, (ROOT / f).read_text(encoding='utf-8'))
        c = texts[f].count(old)
        if c != n:
            print(f'FAIL: {f}: anchor found {c} times, expected {n}: {old[:90]!r}'); sys.exit(1)
        texts[f] = texts[f].replace(old, new)
    for f, t in texts.items():
        (ROOT / f).write_text(t, encoding='utf-8'); print('wrote', f)
    print('RESULT: PASS')
if __name__ == '__main__':
    main()
