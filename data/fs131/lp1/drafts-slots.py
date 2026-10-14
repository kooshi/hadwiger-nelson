#!/usr/bin/env python3
"""FS131-LP1 (FS131-LJ1's data/fs131/lj1/drafts-slots.py with this landing's slots): every draft's slot — the exact
words on `main` a draft replaces or follows — occurs exactly once there.  Reads each file as `git show <ref>:<file>`
(default ref `main`), whitespace-normalised.  The last entry is the control: a string that must be absent, reported as
such; exit 1 if any real slot does not occur exactly once or the control is found.  Usage: drafts-slots.py [ref]"""
import re
import subprocess
import sys

C, N, A, B, F = "CLAUDE.md", "LEAN.md", "ARCHITECTURE.md", "BIBLIOGRAPHY.md", "tools/claude_md_fact_audit.py"
SLOTS = [
    ("1 the audit's sentence", C, "the current audit reads 7531 clean and 5 declared purchases, and 38 imported (and 28 axiom-free; 7,602 records at the landing of FS-131's three-and-four-colours line, FS131-LJ1, 2026-10-14)"),
    ("1b the declared imports", C, "The library declares three outside axioms: `StandingFive.kloosterman_bound` — Weil's bound for Kloosterman sums, `[Weil1948]` p. 207, read against its page by two readers — with twenty imported records (twelve of them the three-colour criterion's and row 99's, FS131-LJ1); and, from `[OAIMath2026]` family 158, a Lean development built and audited here at its own pin, `Outside.OAI158.no_proper_five_coloring` — no map `ℂ → Fin 5` separates every unit pair — with six, and `Outside.OAI158.proper_to_borel_weak` — a proper `k`-colouring of the plane gives a Borel one proper at almost every unit pair — with twelve (three of them FS-131's: `χ(ℝ²) = χ_m(ℝ²)`, the Lebesgue-measurable chromatic number, in two forms and colour by colour, `Plane/LebesgueNumber`); no record rests on two of the three, and each of the two new ones is the release's stored statement term for term (`tools/fs132_i1_readback.py`, run again at the landing on the module as recompiled there);"),
    ("1c the palette lemmas", C, "kernel-checked at this pin on the standard three, and rest on neither declared outside theorem;"),
    ("2 the vacuity counts", C, "`declarations=16125 refutations-skipped=228 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`."),
    ("3 the nine counts", C, "`axioms=3 rests=39 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1` — three outside theorems declared as axioms, with thirty-nine theorems resting on them;"),
    ("3b the sentence it follows", C, "now the theorem `ThreeFourColours.localBound_le_chromaticNumber_of_le_four`, which rests on Weil's bound)."),
    ("4 GATE_CHANGES, the entry it follows", F, '(("7447", "5"), ("7531", "5")):'),
    ("5 the mission, row D", C, "in this library a theorem on the second declared outside theorem, `Outside.OAI158.proper_to_borel_weak`:"),
    ("6 where the problem stands, the collapse", C, "kernel-checked from the declared outside theorem `Outside.OAI158.proper_to_borel_weak` (the release's transfer, term for term) and this library's own N-EASY, and row 131's criterion read for the plane itself is `seven_le_chromaticNumber_plane_iff`, on that import alone —"),
    ("7 where the problem stands, the Lebesgue number", C, "so `χ(ℝ²) = χ_m(ℝ²)` on the declared outside theorem `Outside.OAI158.proper_to_borel_weak` (`Plane.chromaticNumber_plane_eq_chiLebesgue`; through the gate, FS131-LC1)"),
    ("8 where the problem stands, the discs", C, "*such a disc gives seven* is the contrapositive of `radius_down` and rests on the declared outside theorem `Outside.OAI158.proper_to_borel_weak`. So an exclusion on a disc reaches seven only through the transfer,"),
    ("9 open milestones, FS-124's disc criterion", C, "the half toward six on the standard three axioms and the half toward seven on the declared outside theorem `Outside.OAI158.proper_to_borel_weak`;"),
    ("10a the aim, item 5", C, "toward seven over the outside theorem on Borel transfer (row 161; [kernel] since FS124-L1)"),
    ("10b item 31", C, "the direction toward seven over the outside theorem on Borel transfer (row 161, [kernel] since FS124-L1)"),
    ("11 open milestones, the frontier's ground", C, "in this library since FS132-L1, each kernel-checked from one declared outside theorem (`Outside/OAI158`)."),
    ("12 the Frontier's Last filed", C, "Last filed: **the landing of FS-131's three-and-four-colours line** (FS131-LJ1, 2026-10-14:"),
    ("13a ARCHITECTURE § Trust, the transfer's row (its head)", A, "| `Outside.OAI158.proper_to_borel_weak` (`Outside/OAI158`) | `[OAIMath2026]` family 158, `lean/OAI/Geometry/PlaneColoring/BorelTransfer.lean` lines 436–437 at commit `adc7f124`"),
    ("13b ARCHITECTURE § Trust, the count", A, "Three at present."),
    ("14a LEAN.md § Assumptions, the port bullet's last sentence", N, "scoping changes no stored term, so the read-back prints the same bytes."),
    ("14b LEAN.md § Searching — Lean, the last bullet's end", N, "(`data/fs131/kj1/copy_build.sh`, FS131-KJ1; inventory item 694's condition)."),
    ("14c LEAN.md § Building, the bullet it follows", N, "and the manifest is then what shows that no copied file has been rewritten."),
    ("14d LEAN.md § The gate, the lint's bullet end", N, "an unused anonymous instance binder is, and the build's own linters do not warn about it."),
    ("15a BIBLIOGRAPHY, the release's row, what rests on it", B, "Imported by FS132-I1 and landed by FS132-L1 as two declared outside theorems (`Outside/OAI158`: `no_proper_five_coloring`, `proper_to_borel_weak`), on which ten records of the library rest, five each;"),
    ("15b BIBLIOGRAPHY, the release's row, its reading", B, "rest on the imported `proper_to_borel_weak`, `Plane.radius_five` on the imported `no_proper_five_coloring`; nine and six records of the audit rest on the two."),
    ("CONTROL (must be absent)", C, "the current audit reads 7531 clean and 5 declared purchases, zz"),
]


def norm(s):
    return re.sub(r"\s+", " ", s)


ref = sys.argv[1] if len(sys.argv) > 1 else "main"
texts, bad = {}, 0
for name, f, slot in SLOTS:
    if f not in texts:
        texts[f] = norm(subprocess.run(["git", "show", f"{ref}:{f}"], capture_output=True, text=True, check=True).stdout)
    n = texts[f].count(norm(slot))
    control = name.startswith("CONTROL")
    good = (n == 0) if control else (n == 1)
    bad += not good
    print(f"{'ok  ' if good else 'FAIL'}  {n}  {name}  ({f})")
print(f"slots: {len(SLOTS) - 1} checked on {ref}, control absent: {'yes' if texts[C].count(norm(SLOTS[-1][2])) == 0 else 'NO'}; "
      + ("SLOTS OK" if not bad else f"SLOTS FAILED ({bad})"))
sys.exit(1 if bad else 0)
