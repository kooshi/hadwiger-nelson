"""FS129-P1: build the ranked table of plans/FRONTIER-STUBS.md from the current file and the draft rows in
plans/POROS-2026-10-03-fs129-rerank.md § Draft re-rank; write data/fs129/p1/frontier-table-draft.md. Asserts every FS number
of the current table once, FS-130 added, ranks 1..N contiguous. --fault drops one row (the assertion must fire)."""
import re, sys
ROOT = "/home/kooshi/source/lean-dir/"
front = open(ROOT + "plans/FRONTIER-STUBS.md").read().split("\n")
rec = open(ROOT + "plans/POROS-2026-10-03-fs129-rerank.md").read()
row_re = re.compile(r"^\| (\d+) \| \*\*FS-(\d+) ")
start = next(i for i, l in enumerate(front) if l.startswith("| rank | stub |"))
end = next(i for i in range(start, len(front)) if front[i].startswith("## Closed"))
old = {}
for l in front[start:end]:
    m = row_re.match(l)
    if m:
        old[int(m.group(2))] = (int(m.group(1)), l)
sec = rec[rec.index("**The rows that change**"): rec.index("FS-117 (rank 10) and FS-109 (rank 11) keep their rows")]
new = {}
for l in sec.split("\n"):
    m = row_re.match(l)
    if m:
        new[int(m.group(2))] = l
order = [124, 123, 104, 128, 125, 122, 120, 127, 126, 117, 109, 108]
by_old_rank = [fs for fs, (r, _) in sorted(old.items(), key=lambda kv: kv[1][0])]
rest = [fs for fs in by_old_rank if fs not in order and fs != 115]
order += rest[:5] + [130, 115] + rest[5:]
if "--fault" in sys.argv:
    order = order[:-1]
assert sorted(order) == sorted(list(old) + [130]), "an FS number is missing or doubled"
assert len(order) == len(set(order))
out = []
for rank, fs in enumerate(order, 1):
    line = new.get(fs) or old[fs][1]
    line = row_re.sub(lambda m: f"| {rank} | **FS-{m.group(2)} ", line, count=1)
    if fs == 117:
        a = "and none at all if a fragment's bends keep the class (FS-123's first question)"
        assert line.count(a) == 1
        line = line.replace(a, "and none in the non-Siamese class, the bends keeping it (row 149)")
    out.append(line)
for fs in new:
    assert fs in order
open(ROOT + "data/fs129/p1/frontier-table-draft.md", "w").write("\n".join(front[start:start + 2] + out) + "\n")
print(f"rows {len(out)}; ranks 1..{len(out)}; FS-130 at {order.index(130) + 1}; FS-115 at {order.index(115) + 1}; top three", order[:3])
