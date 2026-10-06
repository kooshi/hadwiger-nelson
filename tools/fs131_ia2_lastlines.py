#!/usr/bin/env python3
"""FS131-IA2: build the scratch copy of `exists_procStep` with the arc step's two changed places (record § 3.6 and Stage 8).

Reads `Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean`, takes the theorem `exists_procStep` (its docstring to the blank line before
`/-! ### A run of the procedure -/`), renames it `exists_procStep'`, and applies the two edits the last job makes there:
  (1) the call: `exists_arcStep hG.valid hG.clean hmax …`  ->  `exists_arcStep' hG.valid hG.plane hG.clean hmax …`
  (2) the `pot_le` bullet of the arc step: the degree clause is read at `x ∈ T` as `∃ m' ≤ m`.
Each pattern must occur EXACTLY once in the extracted text, or the tool exits 1 naming it (so a drift of `Procedure.lean` cannot pass in
silence). Writes the copy to stdout, to be placed inside `namespace HadwigerNelson.Plane.ArcMap` with `variable {k : ℕ} {F : ArcMap k}`.

  python3 tools/fs131_ia2_lastlines.py [Procedure.lean]            # the copy on stdout, exit 0
  python3 tools/fs131_ia2_lastlines.py --self-test                 # plants: a pattern removed, a pattern doubled; both must exit 1
"""
import sys
from pathlib import Path

SRC = Path(__file__).resolve().parents[1] / "Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean"
START = "/-- **The procedure's step exists**"
END = "/-! ### A run of the procedure -/"
EDITS = [
    ("theorem exists_procStep (", "theorem exists_procStep' ("),
    ("      exists_arcStep hG.valid hG.clean hmax hQ hR hnb hT (show (0 : ℝ) < 1 / 2 by norm_num)\n",
     "      exists_arcStep' hG.valid hG.plane hG.clean hmax hQ hR hnb hT (show (0 : ℝ) < 1 / 2 by norm_num)\n"),
    ("    · intro x _\n"
     "      obtain ⟨mx, -, hmx⟩ := exists_hasDegree_of_mem_dom (hGd x)\n"
     "      obtain ⟨jx, hjx⟩ := exists_hasHornCount (hGd x)\n"
     "      obtain ⟨j', hj', hjx'⟩ := hhorns x jx hjx\n"
     "      rw [pot_eq (hdegs x mx hmx) hjx', pot_eq hmx hjx]\n"
     "      omega\n",
     "    · intro x hx\n"
     "      obtain ⟨mx, -, hmx⟩ := exists_hasDegree_of_mem_dom (hGd x)\n"
     "      obtain ⟨jx, hjx⟩ := exists_hasHornCount (hGd x)\n"
     "      obtain ⟨m', hm', hdeg'⟩ := hdegs x hx mx hmx\n"
     "      obtain ⟨j', hj', hjx'⟩ := hhorns x jx hjx\n"
     "      rw [pot_eq hdeg' hjx', pot_eq hmx hjx]\n"
     "      omega\n"),
]


def build(text: str) -> str:
    if text.count(START) != 1 or text.count(END) != 1:
        raise SystemExit(f"FAIL: start/end markers occur {text.count(START)}/{text.count(END)} times, each must occur once")
    body = text[text.index(START):text.index(END)].rstrip() + "\n"
    for old, new in EDITS:
        n = body.count(old)
        if n != 1:
            raise SystemExit(f"FAIL: pattern occurs {n} times, must occur once: {old.splitlines()[0]!r}")
        body = body.replace(old, new)
    return body


def main():
    if "--self-test" in sys.argv:
        text = SRC.read_text()
        fired = 0
        for label, planted in (("pattern removed", text.replace(EDITS[1][0], "", 1)),
                               ("pattern doubled", text.replace(EDITS[2][0], EDITS[2][0] + EDITS[2][0], 1))):
            try:
                build(planted)
                print(f"plant ({label}): DID NOT FIRE (bad)")
            except SystemExit as ex:
                print(f"plant ({label}): FIRED — {ex}")
                fired += 1
        build(text)
        print("unplanted: PASS")
        print("SELF-TEST:", "PASS" if fired == 2 else "FAIL")
        sys.exit(0 if fired == 2 else 1)
    src = Path(sys.argv[1]) if len(sys.argv) > 1 else SRC
    sys.stdout.write(build(src.read_text()))


if __name__ == "__main__":
    main()
