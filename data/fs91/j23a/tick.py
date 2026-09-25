"""Set the status cell of rows in plans/FS91-close-inventory.md (J23a, M1's close planner).
Usage: python3 data/fs91/j23a/tick.py <json map {item: status}>; refuses unknown items and reports counts."""
import json, re, sys
path = "plans/FS91-close-inventory.md"
upd = {int(k): v for k, v in json.load(open(sys.argv[1])).items()}
lines = open(path, encoding="utf-8").read().split("\n")
seen = set()
for i, ln in enumerate(lines):
    m = re.match(r"^\| (\d+) \|", ln)
    if not m:
        continue
    n = int(m.group(1))
    if n in upd:
        cells = ln.split(" | ")
        # the status is the last cell: "... | <status> |"
        head, _sep, _tail = ln.rstrip().rpartition(" | ")
        lines[i] = head + " | " + upd[n] + " |"
        seen.add(n)
missing = set(upd) - seen
if missing:
    sys.exit(f"unknown items: {sorted(missing)}")
open(path, "w", encoding="utf-8").write("\n".join(lines))
print(f"updated {len(seen)} rows")
