# FS131-FC8 stage 3: file the ready rows with an apply function. Every slot is asserted (by a dry pass over all rows) before anything is written.
import rows, sys
from common import R
import build_table  # sets statuses (writes owed.md again, unchanged)
todo = [r for r in rows.ROWS if r["status"] == "ready" and r["apply"]]
texts = {}
def cur(f): return texts.get(f) if f in texts else open(R + f).read()
# dry pass: apply sequentially in memory; any assertion aborts before writes
for r in todo:
    f, fn = r["apply"]; texts[f] = fn(cur(f))
for f, t in texts.items(): open(R + f, "w").write(t)
for r in todo: print("filed", r["id"], "->", r["apply"][0], "(%d bullets)" % len(r.get("bullets", [])) if r.get("bullets") else "")
print(len(todo), "rows filed;", sum(1 for r in rows.ROWS if r["status"] == "ready" and not r["apply"]), "ready rows left unfiled (bibliography appends)")
