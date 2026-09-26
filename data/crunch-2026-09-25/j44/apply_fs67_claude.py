#!/usr/bin/env python3
"""J44 stage 3: apply FS-67's CLAUDE.md drafts, read from J42's own checker (data/fs67/j42/claude_md_drafts.py), to CLAUDE.md.

The G72 line is anchored after the row-88 close's tenth sentence ("**ten of ten**."), as J42's R.8c orders it. Every anchor must occur
exactly once or nothing is written.   --plant: rename one anchor so it is absent; must exit 1 with CLAUDE.md untouched.
"""
import sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
src = (ROOT / "data/fs67/j42/claude_md_drafts.py").read_text(encoding="utf-8")
head = src.split('if "--plant" in sys.argv')[0]
ns = {"__file__": str(ROOT / "data/fs67/j42/claude_md_drafts.py")}
exec(head, ns)                         # builds ns["D"] against CLAUDE.md on disk
D = ns["D"]
cm_p = ROOT / "CLAUDE.md"
cm = cm_p.read_text(encoding="utf-8")
out = cm
n = 0
for kind, name, anchor, new in D:
    if name.startswith("G72 count"):
        anchor = "**ten of ten**."     # after the row-88 close's tenth sentence
    if "--plant" in sys.argv and name == "G61 (3)":
        anchor = anchor + " zzq"
    c = out.count(anchor)
    if c != 1:
        sys.exit(f"FAIL: {name}: anchor occurs {c} times; nothing written")
    if kind == "replace":
        out = out.replace(anchor, new, 1)
    elif kind == "insert-before":
        out = out.replace(anchor, new + anchor, 1)
    elif kind == "insert-after":
        out = out.replace(anchor, anchor + new, 1)
    else:
        sys.exit(f"FAIL: unknown kind {kind}")
    n += 1
cm_p.write_text(out, encoding="utf-8")
print(f"PASS: {n} edits; net {len(out.encode()) - len(cm.encode()):+d} bytes; CLAUDE.md now {len(out.encode()):,} bytes")
