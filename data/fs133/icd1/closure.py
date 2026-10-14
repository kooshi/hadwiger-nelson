#!/usr/bin/env python3
"""FS133-ICD1: the Proofs import closure of a module, read from the sources (iteration aid, not evidence)."""
import re, sys, os
W = "/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1"
def imports(m):
    p = os.path.join(W, m.replace(".", "/") + ".lean")
    if not os.path.exists(p): return []
    return [l.split()[1] for l in open(p) if l.startswith("import ")]
seen = set(); st = [sys.argv[1]]
while st:
    m = st.pop()
    if m in seen: continue
    seen.add(m)
    st += [i for i in imports(m) if i.startswith("Proofs.")]
want = sys.argv[2:]
for w in want: print(w, "IN" if w in seen else "not in")
if not want: print("\n".join(sorted(seen)))
