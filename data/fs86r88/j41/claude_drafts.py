#!/usr/bin/env python3
"""J41 — the drafted CLAUDE.md edits of row 88's close, as exact (old, new) pairs, checked against CLAUDE.md on disk.

    python3 data/fs86r88/j41/claude_drafts.py            # each `old` occurs exactly once; print the net bytes (budget 4,000)
    python3 data/fs86r88/j41/claude_drafts.py --plant    # adds an edit whose `old` is absent; must exit 1
    python3 data/fs86r88/j41/claude_drafts.py --out F    # write the edited text to F (never to CLAUDE.md: the front page applies)

CLAUDE.md is read, never written. A front-page job applies the pairs (they are also printed in the plan's §R-close, stage 4).
"""
from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
BUDGET = 4000

EDITS: list[tuple[str, str, str]] = [
    ("item 10 (T-C(A) at ℚ(√47))",
     "(row 74) — open (row 84; FS-84).",
     "(row 74) — open (row 84; FS-84); a four-colouring there would carry an invariant measure whose spectrum is carried by no `T + A + Fin_S`, `S` finite (row 113)."),
    ("item 24 (the decomposition and Theorem C)",
     "and **every character colouring** are excluded (rows 91–92, 96: HD1 holds), so a \"no\" must be a colouring no character gives.",
     "and **every character colouring** are excluded (rows 91–92, 96: HD1 holds), so a \"no\" must be a colouring no character gives. "
     "Rigidity splits into invariant measures and transience (row 111): every invariant random four-colouring whose spectrum reads finitely "
     "many places is a pullback (row 112), so a \"no\" is transient or reads infinitely many split places; transience stops at two named "
     "steps (isolation from a finite patch, defect growth)."),
    ("item 24 rows",
     "(rows 88–94, 96, G76): the plane is rigid iff",
     "(rows 88–94, 96, 111–113, G76): the plane is rigid iff"),
    ("G76 header grade",
     "[hand, two derivations for the frame, the local theorem and the no-gos (rows 88–92); the obstruction a reading, reached twice independently]**",
     "[hand, two derivations for the frame, the local theorem, the no-gos and the measure half (rows 88–92, 111–113); the obstruction a reading, reached twice independently]**"),
    ("G76 body (the colouring-level split)",
     "*Demotion record:* this entry said \"measure rigidity … not in print\";",
     "**For colourings** rigidity splits into invariant measures and transience — the measure centre of every orbit closure inside the "
     "pullbacks (row 111); a spectrum carried by `T + A + Fin_S`, `S` finite, extends to the completion and a stationary count against the "
     "tight factor makes it a pullback (row 112), and at ℚ(√47) no such spectrum exists (row 113). *Demotion record:* this entry said "
     "\"measure rigidity … not in print\";"),
    ("G76 reading narrowed (J28D's proposed edit; P-real)",
     "*Reading:* for all colourings the obstruction is the real place (non-real analogues are pinned on `T + A + Fin`, row 94).",
     "*Reading:* for all colourings the obstruction is the real place (non-real analogues are pinned on `T + A + Fin`, row 94) — false on "
     "`T + A + Fin_S`, where the real place is an input (`m₁ < 1/4`, row 112); it survives only for infinite-place spectra and transient colourings."),
    ("G76 Do line",
     "(one is not enough); with two tight places expect a choice per",
     "(one is not enough); when an invariant measure's spectrum reads finitely many places, extend it to the completion and count (row 112), "
     "never search for its falsifier; with two tight places expect a choice per"),
    ("G72 tenth count",
     "**nine of nine**.",
     "**nine of nine**. **Tenth (row 88):** Q-μ's invariant (spectral type) found and decisive on `T + A + Fin_S`, Q-tr's not: **ten of ten**."),
    ("G44 Do line (the missed bearing)",
     "from 59 five is refused for free, from 103 six.",
     "from 59 five is refused for free, from 103 six; at four colours a field's stable place from 37 up has `|λ_min|/d ≤ 2√p/(p+1) < 1/3` and needs no certificate (row 112)."),
    ("G49 instance (row 88's close)",
     "found by one zbMATH query in the discipline's words (\"forced periodicity\") the day it was needed. *Do: at every",
     "found by one zbMATH query in the discipline's words (\"forced periodicity\") the day it was needed. **Row 88's close:** C14.2 (c) is "
     "`[BardestaniMallahiKarai2017]` §3.2 in window form — held since FS-58 and named there, never carried to the lemma; and zbMATH's `ab:` "
     "field cannot hit a record whose summary is withheld (BMK 2017, `[ChenDai2017]`), so run `ti:`, `au:` and all-field queries beside it. *Do: at every"),
    ("G30 ladder",
     "→ topological dynamics and algebraic `ℤ^d`-actions (entered at FS-89, row 95);",
     "→ topological dynamics and algebraic `ℤ^d`-actions (entered at FS-89, row 95; its ergodic theory of amenable actions at row 88's close, row 111);"),
    ("prior-art position, Ours",
     "every kernel certificate. **Not ours:**",
     "four-colour rigidity split into invariant measures and transience, Theorem C over the real S2 fields and its ℚ(√47) form (rows 111–113); "
     "every kernel certificate. **Not ours:**"),
    ("prior-art position, Not ours",
     "(`[GodsilRobersonRooney2017]`, FS38-D2-A(ii) in vector words);",
     "(`[GodsilRobersonRooney2017]`, FS38-D2-A(ii) in vector words); the clopen correspondence (`[BergelsonMoragues2021]`), the measure "
     "centre (`[ChenDai2017]`), frozen colourings (`[AlonEtAl2021]`), the measurable Hoffman bound (`[BachocEtAl2014]`), the split-place "
     "hyperbola computation (`[BardestaniMallahiKarai2017]` §3.2) and the finite norm property of subrings of number fields (`[LevitzMott1972]`);"),
]


def main() -> int:
    edits = list(EDITS)
    if "--plant" in sys.argv:
        edits.append(("plant", "zzq this string is not in CLAUDE.md zzq", "x"))
    text = (ROOT / "CLAUDE.md").read_text(encoding="utf-8")
    bad = 0
    net = 0
    for name, old, new in edits:
        n = text.count(old)
        if n != 1:
            print(f"FAIL: {name}: `old` occurs {n} times (must be exactly once)")
            bad += 1
            continue
        d = len(new.encode()) - len(old.encode())
        net += d
        print(f"ok  {d:+5d} B  {name}")
        text = text.replace(old, new, 1)
    print(f"net: {net:+d} bytes (budget {BUDGET}); CLAUDE.md after: {len(text.encode()):,} bytes (ceiling 300,000)")
    if net > BUDGET:
        print("FAIL: over the byte budget")
        bad += 1
    if "--out" in sys.argv:
        out = Path(sys.argv[sys.argv.index("--out") + 1])
        if out.resolve() == (ROOT / "CLAUDE.md").resolve():
            print("FAIL: refusing to write CLAUDE.md itself")
            return 1
        out.write_text(text, encoding="utf-8")
    print("RESULT:", "PASS" if bad == 0 else f"FAIL ({bad})")
    return 0 if bad == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
