#!/usr/bin/env python3
"""FS131-K1: parse plans/LEAN-BACKLOG.md into one record per row.

Reads the backlog's own machine tags (<!--row ...-->, <!--needs ...-->, <!--q ID field-->) and
writes data/fs131/k1/rows.json: id, section, ordinal, role line, address, upstream ids, and each
quoted field (statement, not_claimed, grade, minds, handoff, uses_only, notes, merge notes,
cautions).  Nothing is paraphrased: every field is the backlog's quoted text with its '> ' stripped.

  python3 tools/fs131_k1_rows.py            # write rows.json, print counts
  python3 tools/fs131_k1_rows.py --show ID  # print one row's fields
  python3 tools/fs131_k1_rows.py --table    # one line per row: section, ord, id, role, upstream
  python3 tools/fs131_k1_rows.py --self-test
"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BACKLOG = ROOT / "plans" / "LEAN-BACKLOG.md"
OUT = ROOT / "data" / "fs131" / "k1" / "rows.json"

SECTIONS = {
    "## The order": "order",
    "## FS-129's compositions": "comps",
    "## Left the order": "left",
    "## Named by a merge line or a caution, not in the order": "extras",
}
EXPECTED = {"order": 178, "comps": 32, "left": 26, "extras": 23}

ROW_RE = re.compile(r"^<!--row (\S+) (\S+)-->$")
NEEDS_RE = re.compile(r"^<!--needs ([^:]+):\s*(.*?)-->$")
Q_RE = re.compile(r"^<!--q (\S+) (\S+)-->$")
HEAD_RE = re.compile(r"^### (?:(\S+)\. )?(\S+)$")


def parse(text):
    rows, order = {}, []
    section = None
    cur = None
    field = None
    for line in text.splitlines():
        if line.startswith("## "):
            section = SECTIONS.get(line.strip())
            cur = None
            field = None
            continue
        if section is None:
            continue
        m = HEAD_RE.match(line)
        if m:
            cur = {"id": m.group(2), "ordinal": m.group(1) or "x", "section": section,
                   "upstream": [], "fields": {}, "cautions": [], "meta": ""}
            if cur["id"] in rows:
                raise SystemExit(f"duplicate row id {cur['id']}")
            rows[cur["id"]] = cur
            order.append(cur["id"])
            field = None
            continue
        if cur is None:
            continue
        m = ROW_RE.match(line)
        if m:
            if m.group(1) != cur["id"]:
                raise SystemExit(f"row tag {m.group(1)} under heading {cur['id']}")
            cur["address"] = m.group(2)
            continue
        m = NEEDS_RE.match(line)
        if m:
            ups = m.group(2).strip()
            cur["upstream"] = [u for u in ups.split(",") if u] if ups else []
            continue
        if line.startswith("**Address**"):
            cur["meta"] = line
            continue
        if line.startswith("**Cautions:**"):
            cur["cautions"] = re.findall(r"\[(C\d+)\]", line)
            continue
        m = Q_RE.match(line)
        if m:
            field = m.group(2)
            cur["fields"].setdefault(field, "")
            continue
        if field is not None:
            if line.startswith("> "):
                cur["fields"][field] += line[2:] + "\n"
            elif line.startswith(">"):
                cur["fields"][field] += line[1:] + "\n"
            elif line.startswith("**") and field.startswith("merge@"):
                cur["fields"][field] += "[[" + line + "]]\n"
    for r in rows.values():
        r["fields"] = {k: v.strip() for k, v in r["fields"].items()}
        mm = re.search(r"\*\*Role\*\* ([^·]+)", r["meta"])
        r["role"] = mm.group(1).strip() if mm else ""
    return rows, order


def check(rows, order):
    errs = []
    from collections import Counter
    c = Counter(rows[i]["section"] for i in order)
    for s, n in EXPECTED.items():
        if c.get(s, 0) != n:
            errs.append(f"section {s}: {c.get(s, 0)} rows, expected {n}")
    if len(order) != 259:
        errs.append(f"{len(order)} rows, expected 259")
    for i in order:
        if "statement" not in rows[i]["fields"]:
            errs.append(f"{i}: no statement")
    return errs


def main(argv):
    text = BACKLOG.read_text()
    rows, order = parse(text)
    if "--self-test" in argv:
        # plant: drop one row heading and a statement; the check must fire on both
        bad = text.replace("### 1. FS106-DIAM", "### 1x FS106-DIAM", 1)
        r2, o2 = parse(bad)
        e2 = check(r2, o2)
        assert any("order" in e for e in e2), e2
        bad2 = text.replace("<!--q FS106-L statement-->", "<!--q FS106-L statemnt-->", 1)
        r3, o3 = parse(bad2)
        e3 = check(r3, o3)
        assert any("FS106-L: no statement" in e for e in e3), e3
        print("self-test: both planted faults fired")
        return 0
    errs = check(rows, order)
    if errs:
        print("\n".join(errs))
        return 1
    if "--show" in argv:
        rid = argv[argv.index("--show") + 1]
        r = rows[rid]
        print(f"{r['section']} {r['ordinal']} {rid} | {r['role']} | up: {','.join(r['upstream'])} | cautions: {r['cautions']}")
        for k, v in r["fields"].items():
            print(f"--- {k}\n{v}")
        return 0
    if "--table" in argv:
        for i in order:
            r = rows[i]
            print(f"{r['section']:6} {r['ordinal']:>4} {i:28} {r['role'][:28]:28} {','.join(r['upstream'])}")
        return 0
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps({"order": order, "rows": rows}, ensure_ascii=False, indent=1))
    print(f"wrote {OUT.relative_to(ROOT)}: {len(order)} rows")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
