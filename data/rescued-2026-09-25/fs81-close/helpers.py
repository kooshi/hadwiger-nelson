import re
from pathlib import Path
P = Path("/home/kooshi/source/lean-dir/CLAUDE.md")
def fx(old):
    return re.compile(r"\s+".join(re.escape(p) for p in old.split()))
def rep(old, new):
    global t
    ms = list(fx(old).finditer(t)); assert len(ms) == 1, (len(ms), old[:80])
    t = t[:ms[0].start()] + new + t[ms[0].end():]
def ins_before(anchor, new):
    global t
    ms = list(fx(anchor).finditer(t)); assert len(ms) == 1, (len(ms), anchor[:80])
    t = t[:ms[0].start()] + new + t[ms[0].start():]
def ins_after(anchor, new):
    global t
    ms = list(fx(anchor).finditer(t)); assert len(ms) == 1, (len(ms), anchor[:80])
    t = t[:ms[0].end()] + new + t[ms[0].end():]
