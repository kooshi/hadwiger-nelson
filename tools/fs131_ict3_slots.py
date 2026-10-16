#!/usr/bin/env python3
"""FS131-ICT3 — every slot text the front-page drafts quote (plans/FS131-ICT3-three-colour.md § Stage 5) occurs exactly once in
its file in this tree. A slot found zero or several times is a MISS. --plant changes one character of each slot in memory and
requires every one reported. Exit 0 iff every slot is found once (and, with --plant, every plant fired)."""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SLOTS = [
    ("D1", "CLAUDE.md", "the current audit reads 10804 clean and 5 declared purchases, and 83 imported (and 574 axiom-free; 11,466 "
     "records at FS131-IQP3, the p-adic plane, 2026-10-16)"),
    ("D3", "CLAUDE.md", "`declarations=22431 refutations-skipped=243 sites=1458`, `vacuous=0 stale=0 declared=3 witnessed=38 "
     "generic=1415 unknown=2`."),
    ("D4a", "CLAUDE.md", "Last filed: **the p-adic plane** (FS131-KPA1, FS131-IQP1, FS131-IQP3, 2026-10-16:"),
    ("D4b", "CLAUDE.md", "before it, **the collapse** (FS131-KCL1, FS131-ICO1, FS131-ICO2) and every earlier filing, newest first"),
    ("D5", "CLAUDE.md", "the p-adic plane, the posers' question on the Borel chromatic number of `ℚ_p²` answered no and its values "
     "at 3, 7, 11, 19 and 23 (row 75);"),
    ("D6a", "plans/KERNEL-HOLDS.md", "the lower bound and the values: prior art not found in print (FS66-T7's search); the kernel "
     "proof is this project's;"),
    ("D6b", "plans/KERNEL-HOLDS.md", "**Theorems A and B**"),
    ("D7a", "LEDGER.md", "The ⟸, the density of periodic colourings and the statement about forced pairs stay [hand]."),
    ("D7b", "LEDGER.md", "`tools/fs73v_q11.py` | FS-73 |"),
    ("D8", "CLOSED-QUESTIONS.md", "**Not kernel-checked** (FS-75)."),
    ("D9", "ROADMAP.md", '| 79 | cert, hand, "stay [hand", tools | yes |'),
    ("D10", "plans/FRONTIER-STUBS.md", "**Minimal instance landed 2026-09-26 (row 119; `plans/FS75-kernel-167.md` §R-close):** "
     "`χ(ℚ(√167)²) ≥ 4` in the kernel, no finite graph, by T22's ⟹ in winding form and a checker for V2's certificates;"),
]


def run(plant):
    miss = 0
    for tag, f, text in SLOTS:
        if plant:
            i = len(text) // 2
            text = text[:i] + ("X" if text[i] != "X" else "Y") + text[i + 1:]
        n = (ROOT / f).read_text().count(text)
        ok = n == 1
        miss += not ok
        print(f"{'FOUND-ONCE' if ok else 'MISS      '} {tag} {f}: {n} occurrence(s)")
    print(f"{len(SLOTS)} slots, {miss} missed")
    if plant:
        return 0 if miss == len(SLOTS) else 1
    return 1 if miss else 0


if __name__ == "__main__":
    sys.exit(run("--plant" in sys.argv))
