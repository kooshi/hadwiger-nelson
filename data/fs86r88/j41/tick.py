#!/usr/bin/env python3
"""J41 — set the status cell of rows in plans/FS86-row88-close-inventory.md, and append rows J41 found missing.

    python3 data/fs86r88/j41/tick.py <stage-json>      # apply {"status": {n: text}, "add": [[kind, item, source, status], ...]}

Idempotent: a row's status cell is replaced whatever it held; an added row is skipped if its item text is already present.
Exits 1, loudly, if a named row number is not found (a status for a row that does not exist is a defect, never a no-op).
"""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

INV = Path(__file__).resolve().parents[3] / "plans" / "FS86-row88-close-inventory.md"
ROW = re.compile(r"^\| (\d+) \|(.*)\| ([^|]*) \|\s*$")


def main() -> int:
    spec = json.loads(Path(sys.argv[1]).read_text(encoding="utf-8"))
    status = {int(k): v for k, v in spec.get("status", {}).items()}
    lines = INV.read_text(encoding="utf-8").splitlines()
    seen: set[int] = set()
    last = 0
    for i, line in enumerate(lines):
        m = ROW.match(line)
        if not m:
            continue
        n = int(m.group(1))
        last = max(last, n)
        if n in status:
            lines[i] = f"| {n} |{m.group(2)}| {status[n]} |"
            seen.add(n)
    missing = sorted(set(status) - seen - {int(r[0]) for r in spec.get("add", []) if str(r[0]).isdigit()})
    text = "\n".join(lines)
    added = 0
    for row in spec.get("add", []):
        n, kind, item, source, st = row
        if item in text:
            continue
        lines.append(f"| {n} | {kind} | {item} | {source} | {st} |")
        text = "\n".join(lines)
        added += 1
    if missing:
        print(f"FAIL: status given for rows not in the table: {missing}")
        return 1
    INV.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"statuses set: {len(seen)}; rows added: {added}; last row before adding: {last}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
