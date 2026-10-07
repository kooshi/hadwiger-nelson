#!/usr/bin/env python3
"""FS131-I6C iteration aid (never evidence): elaborate `LocalGraph.lean` against the *built* oleans when `Curve.lean`
has declarations the last build does not hold yet. Writes a scratch file = LocalGraph with Curve's declarations from
`MARK` on (the lens block) inlined after its `variable` line, so `lake env lean` can check it without a build.
Usage: python3 data/fs131/i6c/scratch/mk_scratch.py <out.lean>"""
import sys, pathlib
root = pathlib.Path(__file__).resolve().parents[4]
curve = (root / "Proofs/HadwigerNelson/Plane/Saturated/Curve.lean").read_text()
lg = (root / "Proofs/HadwigerNelson/Plane/Saturated/LocalGraph.lean").read_text()
MARK = "/-! ## The lens point (FS131-I6C)"
END = "/-- The chord of two unit vectors is at least `2 sin` of half the angle between them. -/"
block = curve[curve.index(MARK):curve.index(END)]
anchor = "variable {k : ℕ}\n"
assert lg.count(anchor) == 1
pathlib.Path(sys.argv[1]).write_text(lg.replace(anchor, anchor + "\n" + block))
