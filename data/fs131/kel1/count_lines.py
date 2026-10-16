"""FS131-KEL1: count a Lean file's lines — total, code (outside /- … -/ blocks and -- comments, non-blank), and doc.
Usage: python3 -I count_lines.py <file> [<from-line> <to-line>]"""
import sys
p = sys.argv[1]
L = open(p).read().split('\n')
a, b = (int(sys.argv[2]), int(sys.argv[3])) if len(sys.argv) > 3 else (1, len(L))
code = doc = blank = 0
depth = 0
for i, ln in enumerate(L, 1):
    s = ln.strip()
    in_block = depth > 0
    opens, closes = ln.count('/-'), ln.count('-/')
    is_doc = in_block or s.startswith('/-')
    depth += opens - closes
    if not (a <= i <= b):
        continue
    if not s:
        blank += 1
    elif is_doc or s.startswith('--'):
        doc += 1
    else:
        code += 1
print(f"{p} [{a}-{b}]: total {b - a + 1}, code {code}, doc/comment {doc}, blank {blank}")
