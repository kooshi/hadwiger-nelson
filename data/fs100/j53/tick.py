#!/usr/bin/env python3
"""J53 — tick rows of plans/FS100-close-inventory.md: set the status cell of row n. Refuses (exit 1, nothing written) a row that does not exist.
Usage: tick.py <json of {row: status}>   |   tick.py --plant  (asks for row 999; must exit 1)"""
import json, re, sys
P = "plans/FS100-close-inventory.md"
def main(m):
    lines = open(P, encoding="utf-8").read().split("\n")
    idx = {}
    for i, l in enumerate(lines):
        mm = re.match(r"^\| (\d+) \|", l)
        if mm: idx[int(mm.group(1))] = i
    bad = [r for r in m if int(r) not in idx]
    if bad:
        print("FAIL: no such rows", bad); return 1
    for r, st in m.items():
        i = idx[int(r)]; cells = lines[i].split(" | ")
        cells[-1] = st.replace("|", "/") + " |"
        lines[i] = " | ".join(cells)
    open(P, "w", encoding="utf-8").write("\n".join(lines)); print("ticked", len(m)); return 0
if __name__ == "__main__":
    if sys.argv[1] == "--plant": sys.exit(main({"999": "x"}))
    sys.exit(main(json.loads(open(sys.argv[1]).read())))
