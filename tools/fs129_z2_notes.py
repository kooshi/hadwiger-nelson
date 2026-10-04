#!/usr/bin/env python3
"""FS129-Z2 — dated notes on five records that are not derivation files (FS-129 inventory items 59, 96).

Each note is a paragraph inserted directly after the paragraph or bullet it corrects (found by an anchor string that must occur once), the original
text left standing; nothing is removed.

    python3 tools/fs129_z2_notes.py --apply          # insert each note once (refuses if one is already present)
    python3 tools/fs129_z2_notes.py --check          # each note present once, directly after its anchor's paragraph; git diff deletes no line
    python3 tools/fs129_z2_notes.py --check --fault  # one note's text altered in memory — the check must fail (it fires)
"""
from __future__ import annotations

import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
D = "*Dated note (FS129-Z2, 2026-10-03; the text above stands as written).*"
SIDE1 = ("holds for the **whole-tile restriction** of radius at most `√3` — the tiles meeting the open disc, each with its whole closure "
         "(FS129-OR1-WHOLE) — and not for a round neighbourhood: a fragment's tiles are the components of its open set minus `Γ`, so a round "
         "restriction can cut one tile into two pieces of one colour less than 1 apart (a Siamese pair) and can disconnect the meeting set of two "
         "closures (non-simple) (`plans/FS129-OR1-audit.md` § J1 and its control `fs129-or1-cut`). The sentence is true about the arcs — a round "
         "restriction also removes every non-(Q) ring arc — but does not carry class membership (`plans/FS129-SR1-audit.md` § 2.3). On the whole-tile "
         "restriction the bends keep validity, non-Siamese, simplicity and `p`'s colours and leave only the (Q) arcs (FS129-OR1-BENDFRAG; at any `k`, "
         "FS129-SR1-BENDANY; derived, one mind, kernel pending). Source: FS-129 inventory items 59, 96.")
NOTES = [
    ("plans/FS114-NB5-verification.md", "So the whole statement reads `√3`.",
     f"{D} The radius note's \"restrict first\" {SIDE1}"),
    ("plans/FS114-NB6-verification.md", "radius, and the ring of a fragment bent so is `Γ`-arc-free off its (Q) arcs.",
     f"  {D} \"Bends on a fragment … on a neighbourhood of `B̄(p, 1 + ε)`\" {SIDE1}"),
    ("plans/FS114-N7-proof.md", "about `p` (NB6 §1b.0: then every ring `Γ`-arc but the (Q) arcs is removed",
     f"{D} \"the map is bent on a fragment of radius `1 + ε` about `p`\" {SIDE1} With FS129-OR1-QFREE (non-Siamese simple) and FS129-SR3-QFREE-NS "
     "(non-Siamese) this setting's class — a (Q)-free ring at a four-colour vertex — has no member on a disc of radius above 1: the per-pattern kills "
     "below stand as arguments about an empty class, and stay owed only where Siamese pairs are allowed."),
    ("plans/FS116-Y4-construction.md", "the double tip's existence is not shown. Whether FLANK closes them is the next question (§ 3.4).",
     f"  {D} The (Q)-free rings that carry (R2) arcs are now reached: bending a fragment on a whole-tile restriction of radius at most `√3` keeps "
     "EMPTY's class and leaves only (Q) arcs, so \"no non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p "
     "of at least four colours has a ring carrying no (Q) arc\" (FS129-OR1-QFREE), and without \"simple\" (FS129-SR3-QFREE-NS, on FS116-V6's route, which "
     "never uses simplicity) — each derived, one mind, kernel pending (`plans/FS129-derivation.md`; FS-129 item 96). FLANK is not needed for them."),
    ("plans/FS116-local-exclusion.md", "DENSE3 is a claim of its own (the claim list's LOCAL-DENSE).",
     f"  {D} The local DENSE3 is now held at `r = 3` (FS129-OR1-LOCALDENSE: \"every valid six-coloured fragment on a closed disc B̄(x, 3) has, in "
     "B̄(x, 3), a vertex of at least four colours or a vertex with a repeated colour\"; possibly vacuous), but \"the same question\" holds only in the "
     "non-Siamese simple class: LOCAL-DENSE's alternative is a vertex of at least four colours *or one with a repeated colour*, and C114-LOCAL-F excludes "
     "only the first, so DISC-F follows from C114-LOCAL-F with LOCAL-DENSE where no vertex has a repeated colour (FS129-OR1-DISCF-NS); in the Siamese or "
     "non-simple class it needs, besides, the same exclusion about repeated-colour vertices or four-colour vertices within a bounded distance of every "
     "repeated-colour vertex (GS-4's density form; `plans/FS129-OR1-audit.md` § J19; FS-129 item 59). Each derived, one mind, kernel pending."),
]


def para_end(L: list[str], k: int) -> int:
    """Index after the paragraph or bullet holding line k: the next blank line, the next bullet at the same or lower indent, or a heading."""
    ind = len(L[k]) - len(L[k].lstrip())
    j = k + 1
    while j < len(L):
        s = L[j]
        if not s.strip() or s.startswith("#"):
            break
        if s.lstrip().startswith("- ") and (len(s) - len(s.lstrip())) <= max(ind, 0) and not L[k].lstrip().startswith("- ") is False:
            break
        if s.lstrip().startswith("- ") and (len(s) - len(s.lstrip())) <= ind:
            break
        j += 1
    return j


def apply() -> int:
    for f, anchor, note in NOTES:
        p = ROOT / f
        t = p.read_text(encoding="utf-8")
        if note in t:
            raise SystemExit(f"already present: {f}")
        L = t.split("\n")
        hits = [k for k, ln in enumerate(L) if anchor in ln]
        if len(hits) != 1:
            raise SystemExit(f"anchor found {len(hits)} times in {f}")
        j = para_end(L, hits[0])
        L[j:j] = [note]
        p.write_text("\n".join(L), encoding="utf-8")
    print(f"applied {len(NOTES)} notes")
    return 0


def check(fault: bool) -> int:
    probs = []
    notes = list(NOTES)
    if fault:
        f, a, n = notes[0]
        notes[0] = (f, a, n.replace("whole-tile", "round"))
    for f, anchor, note in notes:
        L = (ROOT / f).read_text(encoding="utf-8").split("\n")
        hits = [k for k, ln in enumerate(L) if ln == note]
        a = [k for k, ln in enumerate(L) if anchor in ln]
        if len(hits) != 1 or len(a) != 1 or not (a[0] < hits[0] <= a[0] + 6):
            probs.append(f"{f}: note present {len(hits)} times, anchor {len(a)} times, or not directly after it")
    d = subprocess.run(["git", "diff", "--numstat", "HEAD", "--"] + [f for f, _, _ in NOTES], cwd=ROOT, capture_output=True, text=True).stdout
    for ln in d.splitlines():
        a_, r, f = ln.split("\t")
        if r != "0":
            probs.append(f"{f}: git diff deletes {r} lines")
    print(f"notes check: {len(NOTES)} notes, {len(probs)} problems")
    for p in probs:
        print("  ", p)
    if fault:
        print("(--fault)", "— it fires" if probs else "— IT DID NOT FIRE")
        return 0 if probs else 1
    return 1 if probs else 0


if __name__ == "__main__":
    sys.exit(apply() if "--apply" in sys.argv else check("--fault" in sys.argv))
