#!/usr/bin/env python3
"""Measure J23c's CLAUDE.md draft: bytes between the M3 markers in the plan's §R-close (R4.G).
Reports the whole block and the block less its italic placement notes (lines starting with '*' and ending with ':*').
Plant: --plant appends 5,000 bytes to the block and must report OVER."""
import sys
s = open("plans/M3-exotic-colourings.md", encoding="utf-8").read()
a = s.index("<!-- M3-CLAUDE-DRAFT-BEGIN -->") + len("<!-- M3-CLAUDE-DRAFT-BEGIN -->")
b = s.index("<!-- M3-CLAUDE-DRAFT-END -->")
block = s[a:b]
if "--plant" in sys.argv:
    block += "x" * 5000
whole = len(block.encode())
notes = sum(len((L + "\n").encode()) for L in block.split("\n") if L.startswith("*") and L.rstrip().endswith(":*"))
net = whole - notes
print(f"block {whole} bytes; placement notes {notes}; net {net}; budget 4000; {'OK' if net <= 4000 else 'OVER'}")
sys.exit(0 if net <= 4000 else 1)
