#!/usr/bin/env python3
"""FS131-K1: check data/fs131/k1/dispositions.csv against plans/LEAN-BACKLOG.md.

Checks, each an exact quantifier:
  1. every row id of the backlog (its `<!--row ID ...-->` tags, read here independently of fs131_k1_rows.py)
     appears exactly once in the CSV, and the CSV names no id the backlog lacks;
  2. every disposition is one of formalize, merged into, excluded, outside theorem;
  3. every *merged into* target (one or several, ';'-separated) is a *formalize* row, and the merged row's wave is
     its first target's;
  4. every *excluded* and every *outside theorem* row cites a reason and an address;
  5. every *formalize* row has an integer wave and a module, and each of its upstream ids (the backlog's
     `<!--needs ...-->` tag plus the CSV's extra_upstream column) resolves to rows in an earlier or the same wave:
     a formalize upstream is itself; a merged upstream is its targets; an excluded upstream is its replacement, and an
     excluded upstream with no replacement must be named in the row's reason as "drops <id>"; an outside theorem
     is wave 0. An upstream id the backlog lacks must be the row's outside_backlog entry.

  python3 tools/fs131_k1_dispositions.py              # check; exit 0 green, 1 with every failure listed
  python3 tools/fs131_k1_dispositions.py --self-test  # plant one fault of each kind and watch each fire
"""
import csv
import io
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BACKLOG = ROOT / "plans" / "LEAN-BACKLOG.md"
CSVP = ROOT / "data" / "fs131" / "k1" / "dispositions.csv"
DISPS = {"formalize", "merged into", "excluded", "outside theorem"}


def backlog_graph(text):
    ids = re.findall(r"^<!--row (\S+) \S+-->$", text, re.M)
    needs = {}
    for m in re.finditer(r"^<!--needs ([^:]+):\s*(.*?)-->$", text, re.M):
        needs[m.group(1)] = [u for u in m.group(2).split(",") if u]
    return ids, needs


def check(text, csv_text):
    errs = []
    ids, needs = backlog_graph(text)
    rows = list(csv.DictReader(io.StringIO(csv_text)))
    seen = {}
    for r in rows:
        seen[r["id"]] = seen.get(r["id"], 0) + 1
    for i in ids:
        if seen.get(i, 0) != 1:
            errs.append(f"[once] {i} appears {seen.get(i, 0)} times")
    for i in seen:
        if i not in ids:
            errs.append(f"[once] {i} is not a backlog row")
    by = {r["id"]: r for r in rows}
    for r in rows:
        i, d = r["id"], r["disposition"]
        if d not in DISPS:
            errs.append(f"[disposition] {i}: '{d}'")
            continue
        if d == "merged into":
            tg = [t for t in r["merged_into"].split(";") if t]
            if not tg:
                errs.append(f"[merge] {i}: no target")
            for t in tg:
                if t not in by or by[t]["disposition"] != "formalize":
                    errs.append(f"[merge] {i}: target {t} is not a formalize row")
            if tg and tg[0] in by and r["wave"] != by[tg[0]]["wave"]:
                errs.append(f"[merge] {i}: wave {r['wave']} differs from its target's {by[tg[0]]['wave']}")
        if d in ("excluded", "outside theorem"):
            if not r["reason"].strip() or not r["address"].strip():
                errs.append(f"[reason] {i}: {d} without a reason and its address")
        if d == "formalize":
            try:
                int(r["wave"])
            except ValueError:
                errs.append(f"[wave] {i}: formalize row with wave '{r['wave']}'")
                continue
            if not r["module"].strip():
                errs.append(f"[wave] {i}: formalize row with no module")
    def wave_of(u):
        x = by[u]
        if x["disposition"] == "formalize":
            return [(u, int(x["wave"]))]
        if x["disposition"] == "outside theorem":
            return [(u, 0)]
        if x["disposition"] == "merged into":
            return [(t, int(by[t]["wave"])) for t in x["merged_into"].split(";") if t and t in by
                    and by[t]["disposition"] == "formalize"]
        if x["disposition"] == "excluded" and x["replacement"]:
            t = x["replacement"]
            return [(t, int(by[t]["wave"]))] if t in by and by[t]["disposition"] == "formalize" else []
        return None
    for r in rows:
        if r["disposition"] != "formalize":
            continue
        try:
            w = int(r["wave"])
        except ValueError:
            continue
        ups = needs.get(r["id"], []) + [u for u in r["extra_upstream"].split(";") if u]
        for u in ups:
            if u not in by:
                if u != r["outside_backlog"]:
                    errs.append(f"[upstream] {r['id']}: upstream {u} is not a backlog row and not named outside_backlog")
                continue
            res = wave_of(u)
            if res is None:
                if f"drops {u}" not in r["reason"]:
                    errs.append(f"[upstream] {r['id']}: upstream {u} is excluded with no replacement and not dropped")
                continue
            for t, wt in res:
                if t != r["id"] and wt > w:
                    errs.append(f"[upstream] {r['id']} (wave {w}): upstream {u} resolves to {t} in wave {wt}")
    return errs, rows


def main(argv):
    text = BACKLOG.read_text()
    csv_text = CSVP.read_text()
    if "--self-test" in argv:
        ok = True
        lines = csv_text.splitlines(keepends=True)
        hdr, body = lines[0], lines[1:]
        def run(name, t, c, key):
            nonlocal ok
            e, _ = check(t, c)
            fired = any(key in x for x in e)
            print(f"  plant {name}: {'FIRED' if fired else 'SILENT'} {e[:1]}")
            ok = ok and fired
        # 1. a duplicated row, and a backlog row dropped
        run("duplicate id", text, hdr + body[0] + "".join(body), "[once]")
        run("missing id", text, hdr + "".join(body[1:]), "[once]")
        # 2. a merge whose target is excluded
        c = csv_text.replace("FS111-V0-CLOSE,order,merged into,FS129-SR2-CLOSURE",
                             "FS111-V0-CLOSE,order,merged into,FS112-L60", 1)
        assert c != csv_text
        run("merge into a non-formalize row", text, c, "[merge]")
        # 3. an excluded row with no reason
        rows = list(csv.DictReader(io.StringIO(csv_text)))
        out = io.StringIO()
        w = csv.DictWriter(out, fieldnames=rows[0].keys())
        w.writeheader()
        for r in rows:
            if r["id"] == "FS112-BUDGET2":
                r = dict(r, reason="", address="")
            w.writerow(r)
        run("excluded without reason", text, out.getvalue(), "[reason]")
        # 4. an upstream in a later wave: FS106-TS-C needs FS106-DIAM; push DIAM to wave 9
        out = io.StringIO()
        w = csv.DictWriter(out, fieldnames=rows[0].keys())
        w.writeheader()
        for r in rows:
            if r["id"] == "FS106-DIAM":
                r = dict(r, wave="9")
            w.writerow(r)
        run("upstream in a later wave", text, out.getvalue(), "[upstream]")
        # 5. a formalize row whose upstream is excluded with no replacement and not dropped
        out = io.StringIO()
        w = csv.DictWriter(out, fieldnames=rows[0].keys())
        w.writeheader()
        for r in rows:
            if r["id"] == "FS116-S1-KAPPA":
                r = dict(r, reason=r["reason"].replace("drops FS116-V4-OUTER", "uses FS116-V4-OUTER"))
            w.writerow(r)
        run("excluded upstream not dropped", text, out.getvalue(), "[upstream]")
        print("self-test:", "every plant fired" if ok else "A PLANT WAS SILENT")
        return 0 if ok else 1
    errs, rows = check(text, csv_text)
    if errs:
        print("\n".join(errs))
        print(f"FAIL: {len(errs)} problem(s)")
        return 1
    from collections import Counter
    c = Counter(r["disposition"] for r in rows)
    print(f"OK: {len(rows)} rows, each once; {dict(c)}; every merge target formalize; every exclusion cited; "
          f"every upstream in an earlier or the same wave")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
