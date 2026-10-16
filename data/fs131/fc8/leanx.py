# FS131-FC8: structured extraction of the LEAN.md draft bullets of the owed records (nested bullets kept as indented lines).
import re, glob, os
from common import R, flat
def rec(job): return sorted(glob.glob(R + f"plans/FS131-{job}-*.md"))[0]
def unq(b):
    b = flat(b)
    m = re.match(r'^\*?"(.*)"\*?\.?$', b)
    return m.group(1) if m and '"' not in m.group(1)[:0] else b
def block(job, start, stop=None):
    """bullets from 1-based line `start` (the heading line) on; stops at the next heading, bold-led non-bullet, or a '- **' file bullet."""
    t = open(rec(job)).read().split("\n"); i = start; items = []; cur = None; base = None
    for l in t[i:]:
        if re.match(r"^(#{1,4} |---)", l) or (re.match(r"^\*\*\S", l)) or re.match(r"^- \*\*`?(LEAN|ARCH|BIBL|CLAUDE|LEDGER|Docstrings)", l) or (stop and re.match(stop, l)): break
        m = re.match(r"^(\s*)- (.*)$", l)
        if m:
            ind = len(m.group(1))
            if base is None: base = ind
            if ind <= base:
                if cur: items.append(cur)
                cur = {"t": m.group(2), "sub": []}
            elif cur is not None: cur["sub"].append(m.group(2))
        elif cur is not None and l.strip() and l.startswith("  "):
            if cur["sub"]: cur["sub"][-1] += " " + l.strip()
            else: cur["t"] += " " + l.strip()
        elif cur is not None and not l.strip(): items.append(cur); cur = None
    if cur: items.append(cur)
    out = []
    for it in items:
        s = "- " + unq(it["t"])
        for sb in it["sub"]: s += "\n  - " + flat(sb)
        out.append(s)
    return out
