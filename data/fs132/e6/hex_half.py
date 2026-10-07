#!/usr/bin/env python3
"""FS132-E6 — the second round's three seven-label controls, re-run on the honeycomb seven-colouring at another circumradius.

  hex_half.py hex7    [--radius 0.4]   the ring card's control `hex7-crossings`   (data/fs132/e4/ring_card_checks.py hex7)
  hex_half.py witness [--radius 0.4]   the witness card's control `margin-witness` (data/fs132/e5/margin_check.py witness)
  hex_half.py hexrel  [--radius 0.4]   the first round's control `hex7-relation`   (data/fs132/e2/ring_checks.py hexrel)

Nothing under e2, e4 or e5 is edited: the source text of each script is read, the ONE line that sets the hexagon's
circumradius is replaced (asserted to occur exactly once), and the text is executed with the original subcommand.
Default radius 1/2: every tile has diameter exactly 1, so each vertex's three tiles touch its unit circle (at the three
opposite vertices) and no margin is left.  --radius 0.4 reproduces the original outputs (the planted fault of the controls
in plans/FS132-E6-derivation.md: the counts must then be the ones the second round recorded).
--closed (hexrel only): the vertices at distance exactly 1 from the centre are counted as inside the unit circle; at
radius 1/2 the circle passes through three vertices, so the original's strict float comparison counts them at random."""
import sys, pathlib, re
ROOT = pathlib.Path(__file__).resolve().parents[3]
SRC = {
    "hex7":    ("data/fs132/e4/ring_card_checks.py", "R7 = 0.4\n", "R7 = {r}\n", ["hex7"]),
    "witness": ("data/fs132/e5/margin_check.py", "R, S3 = 0.4, math.sqrt(3.0)\n", "R, S3 = {r}, math.sqrt(3.0)\n", ["witness"]),
    "hexrel":  ("data/fs132/e2/ring_checks.py", "\nR = 0.4\n", "\nR = {r}\n", ["hexrel"]),
}
mode = sys.argv[1]
radius = "0.5"
if "--radius" in sys.argv:
    radius = sys.argv[sys.argv.index("--radius") + 1]
path, old, new, args = SRC[mode]
text = (ROOT / path).read_text(encoding="utf-8")
assert text.count(old) == 1, (path, text.count(old))
text = text.replace(old, new.format(r=radius))
if "--closed" in sys.argv:        # hexrel only: count the vertices AT distance 1 from the centre as inside the circle
    old2 = "inside_r = 0.75 if fault else 1.0\n"
    assert mode == "hexrel" and text.count(old2) == 1
    text = text.replace(old2, "inside_r = 0.75 if fault else 1.0 + 1e-9\n")
sys.argv = [str(ROOT / path)] + args
print(f"radius={radius} ", end="")
exec(compile(text, str(ROOT / path), "exec"), {"__name__": "__main__", "__file__": str(ROOT / path)})
