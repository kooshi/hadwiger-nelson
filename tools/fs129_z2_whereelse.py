#!/usr/bin/env python3
"""FS129-Z2 — the index's where-else column (FS-129 plan § 3 Stage 5; the stub's first deliverable: "For each novel lemma and theorem, where
else it applies, with addresses").

Reads the FS-129 readers' records and adds to every record of data/fs129/index/theorems.jsonl two fields, every other field kept byte for
byte (checked):
  where_else   — each site where an FS-129 reader found the theorem bearing outside its own milestone: a composition (an FS-129 entry names
                 it in its `uses only:`), a merge (one statement, a case, a duplicate, a shared lemma), a stronger form held, a step it closes,
                 shortens or reduces, a GAP it answers that its home does not link (answered elsewhere), or a mechanism's unapplied bearing.
  near_misses  — sites where a reader named it as nearly bearing and said which hypothesis fails (kept apart: a near miss is not a bearing).
Each item: {"site", "kind", "address" (reader record:line), "as" (the token the line uses for the theorem), "by" (the job), "lane"}.
Also writes data/fs129/index/where-else.md (the same content as tables, and the counts).

Sources (each a section of a reader's record, found by its heading; nothing is typed in by hand):
  tables  — the tables of misses (MA1 § 5.1, MA2 § 4.1, MR1 "Table of misses"); the merge lists and sweeps (SR1 Stage 3, § 6.1; SR2 §§ 2.1,
            3.1, 4.1; SA1 §§ 2.2, 4.2, 6.1; SR3 § 4.1); OA1 § 3.3's verdict table. A row's theorems are its ids; each gets the row's other ids as
            sites; the kind is read from the row's words (`kind_of`). A sweep row that begins "unchanged" and names no merge is skipped.
  verdicts — OA1's and OR1's "**Verdict …**" paragraphs: each theorem named gets the step (J<n>) as its site, the kind from the verdict word.
  entries — every FS-129 entry's `uses only:` line, read in the reader's record where it was derived (FS129-MR1-DOUBLETIP's with
            FS116-N2-STAR dropped, as plans/FS129-derivation.md has it): each theorem named gets the entry as a site, kind "composition".
Ids: an index id as written, or a hyphenated token with exactly one id (index or FS-129 entry) ending in "-<token>" (`V6-HUG`).

    python3 tools/fs129_z2_whereelse.py           # write the two fields and where-else.md; exit 1 if a check fails
    python3 tools/fs129_z2_whereelse.py --fault   # plant a fault (every address moved one line down); writes nothing; the address check
                                                  # must fail (it fires) — exit 0 when it does, 1 when it does not
"""
from __future__ import annotations

import json
import re
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TH = ROOT / "data" / "fs129" / "index" / "theorems.jsonl"
OUT_MD = ROOT / "data" / "fs129" / "index" / "where-else.md"
LANE = {"OA1": "A", "MA1": "A", "MA2": "A", "SA1": "A", "OR1": "R", "MR1": "R", "SR1": "R", "SR2": "R", "SR3": "R"}
TABLES = [  # (job, heading prefix as written in the record)
    ("MA1", "### 5.1 Table of misses"), ("MA2", "### 4.1 Table of misses"), ("MR1", "### Table of misses"),
    ("SR1", "## Stage 3 — SAVED: the merges"), ("SR1", "### 6.1 The sweep"),
    ("SR2", "### 2.1 The sweep"), ("SR2", "### 3.1 The sweep, second part"), ("SR2", "### 4.1 Item 63"),
    ("SA1", "### 2.2 The merge map"), ("SA1", "### 4.2 The 68 ids"), ("SA1", "### 6.1 The Lean order"),
    ("SR3", "### 4.1 Item 63's nine lines"), ("OA1", "### 3.3 The rest of the judged list"),
]
VERDICT_JOBS = ["OA1", "OR1"]
TOKEN_RE = re.compile(r"(?<![A-Za-z0-9_./-])[A-Za-z0-9][A-Za-z0-9_]*(?:-[A-Za-z0-9_]+)+")
STEP_RE = re.compile(r"\bJ(\d{1,2})\b")


def rec_path(job):
    return ROOT / "plans" / f"FS129-{job}-audit.md"


def load_index():
    lines = TH.read_text(encoding="utf-8").splitlines()
    head = lines[0]
    recs = [json.loads(x) for x in lines[1:]]
    return head, lines[1:], recs


def fs129_entries():
    """{name: (file, line, uses_only_text)} from the readers' records, where each entry was derived (their lines do not move). One correction
    is applied as plans/FS129-derivation.md applies it: FS129-MR1-DOUBLETIP's `uses only:` drops FS116-N2-STAR (FS-129 items 95, 100)."""
    out = {}
    for j in LANE:
        fname = f"plans/FS129-{j}-audit.md"
        L = rec_path(j).read_text(encoding="utf-8").splitlines()
        for k, ln in enumerate(L):
            m = re.match(r"^derivation: (\S+)", ln)
            if not m or m.group(1) in out:
                continue
            uses, j2 = "", k + 1
            while j2 < len(L) and L[j2].strip():
                if re.match(r"\s+uses only:", L[j2]):
                    uses = L[j2].split("uses only:", 1)[1]
                    j3 = j2 + 1
                    while j3 < len(L) and re.match(r"\s{4,}\S", L[j3]):
                        uses += " " + L[j3].strip()
                        j3 += 1
                j2 += 1
            if m.group(1) == "FS129-MR1-DOUBLETIP":
                uses = uses.replace("FS116-N2-STAR", "")
            out[m.group(1)] = (fname, k + 1, uses)
    return out


def resolver(ids, extra):
    allids = set(ids) | set(extra)
    suf = defaultdict(set)
    for i in allids:
        parts = i.split("-")
        for k in range(1, len(parts) - 1):
            suf["-".join(parts[k:])].add(i)

    def res(text):
        found = []
        for t in TOKEN_RE.findall(text):
            if t in allids:
                found.append((t, t))
            elif len(suf.get(t, ())) == 1:
                found.append((next(iter(suf[t])), t))
        seen, out = set(), []
        for i, t in found:
            if i not in seen:
                seen.add(i); out.append((i, t))
        return out
    return res


def kind_of(text):
    t = text.lower()
    if "near miss" in t:
        return "near miss"
    if any(w in t for w in ("citation miss", "answered elsewhere", "no link back", "without a link", "answered by")):
        return "answered elsewhere"
    if "not one statement" in t:
        return "shared step (not one statement)"
    if any(w in t for w in ("duplicate", "subsumed", "merge", "one lemma", "one statement", "is a case", "a case of", "special case", "instance")):
        return "merge"
    if any(w in t for w in ("weaken", "stronger", "every `k`", "every k", "sharpen")):
        return "stronger form held"
    if re.search(r"\bnot derived\b|\bnot entered\b|\bunapplied\b", t):
        return "bears unapplied"
    if re.search(r"\bcomposition\b|\bderived\b", t):
        return "composition"
    return "bears"


def sections(job, head):
    L = rec_path(job).read_text(encoding="utf-8").splitlines()
    start = next((k for k, ln in enumerate(L) if ln.startswith(head)), None)
    if start is None:
        raise SystemExit(f"heading not found: {job} {head!r}")
    end = next((k for k in range(start + 1, len(L)) if L[k].startswith("#")), len(L))
    return [(k + 1, L[k]) for k in range(start, end)]


def collect(index_ids, entries, res):
    items = defaultdict(list)   # id -> list of item dicts
    rel = lambda job: f"plans/FS129-{job}-audit.md"
    # tables: a row's theorems are the index ids of its key cell (the first cell naming one); its sites are the ids of its other cells,
    # less any pair already joined by an edge of edges-corrected.csv (a use already recorded is not "elsewhere"); a merge, a shared step or
    # an answer elsewhere is made symmetric when the row names at most six ids
    adjacent = set()
    for ln in open(ROOT / "data" / "fs129" / "index" / "edges-corrected.csv", encoding="utf-8"):
        if ln.startswith("#") or ln.startswith("from,"):
            continue
        a, b = ln.split(",")[:2]
        adjacent |= {(a, b), (b, a)}
    for job, head in TABLES:
        for n, ln in sections(job, head):
            if not ln.startswith("|") or set(ln.replace("|", "").strip()) <= {"-", ":", " "}:
                continue
            cells = [c.strip() for c in ln.strip().strip("|").split("|")]
            if cells and cells[0].lower() in ("row", "mechanism", "group", "held statement", "id", "step", "line", "from"):
                continue  # a header row
            if re.search(r"not read here|\bunread\b|not reached", ln, re.I):
                continue
            per = [res(c) for c in cells]
            key = next((k for k, ids in enumerate(per) if any(i in index_ids for i, _ in ids)), None)
            if key is None:
                continue
            subj = [(i, t) for i, t in per[key] if i in index_ids]
            others = [(i, t) for k, ids in enumerate(per) if k != key for i, t in ids if i not in {x for x, _ in subj}]
            if not others:
                continue
            text = " ".join(cells[key + 1:])
            kind = kind_of(ln)
            if kind == "bears" and re.match(r"\W*unchanged", text, re.I):
                continue
            sym = kind in ("merge", "shared step (not one statement)", "answered elsewhere") and len(subj) + len(others) <= 6
            pairs = [(i, t, s) for i, t in subj for s, _ in others]
            if sym:
                pairs += [(s, ts, i) for i, _ in subj for s, ts in others if s in index_ids]
            for i, tok, s in pairs:
                if s == i or (i, s) in adjacent:
                    continue
                items[i].append({"site": s, "kind": kind, "address": f"{rel(job)}:{n}", "as": tok, "by": f"FS129-{job}", "lane": LANE[job]})
    # verdict paragraphs
    for job in VERDICT_JOBS:
        L = rec_path(job).read_text(encoding="utf-8").splitlines()
        step = None
        k = 0
        while k < len(L):
            ln = L[k]
            if ln.startswith("#"):
                m = STEP_RE.search(ln)
                step = (f"J{m.group(1)}", ln.lstrip("# ").strip()) if m else None
            if ln.startswith("**Verdict") and step:
                para, j = [ln], k + 1
                while j < len(L) and L[j].strip() and not L[j].startswith("#"):
                    para.append(L[j]); j += 1
                ptxt = " ".join(para)
                vm = re.match(r"\*\*Verdict[^:]*:\s*([^*.,;—(]+)", ln)
                v = (vm.group(1).strip().lower() if vm else "")
                kind = ("closes" if v.startswith("closed") or "closed" in v.split()[:2] else "shortens" if v.startswith("shortened")
                        else "reduces" if v.startswith("reduced") else "near miss" if v.startswith("null") or v.startswith("not closed") else None)
                if kind:
                    site = step[1] if step[1].startswith(step[0]) else f"{step[0]} — {re.sub(r'^[0-9.]+ ', '', step[1])}"
                    for off, pl in enumerate(para):
                        for i, tok in res(pl):
                            if i in index_ids:
                                items[i].append({"site": site, "kind": kind if kind != "near miss" else "near miss",
                                                 "address": f"{rel(job)}:{k + 1 + off}", "as": tok, "by": f"FS129-{job}", "lane": LANE[job]})
                k = j
                continue
            k += 1
    # entries' uses only
    for name, (fname, line, uses) in sorted(entries.items()):
        job = name.split("-")[1] if name.startswith("FS129-") else ""
        for i, tok in res(uses):
            if i in index_ids:
                items[i].append({"site": name, "kind": "composition", "address": f"{fname}:{line}", "as": tok,
                                 "by": f"FS129-{job}", "lane": LANE.get(job, "")})
    # dedupe
    for i in list(items):
        seen, out = set(), []
        for it in items[i]:
            key = (it["site"], it["kind"], it["address"])
            if key not in seen:
                seen.add(key); out.append(it)
        items[i] = out
    return items


ROW_REF = re.compile(r"\brows?\s+(\d{1,3}(?:\s*(?:[–,-]|and)\s*\d{1,3})*)", re.I)


def rows_in(text):
    out = []
    for m in ROW_REF.finditer(text):
        nums = [int(x) for x in re.findall(r"\d+", m.group(1))]
        for x in nums:
            if 1 <= x <= 148 and x not in out:
                out.append(x)
    return out


def collect_rows(entries, res):
    """Ledger rows (not theorems.jsonl records, so listed in where-else.md only): each row named in an FS-129 entry's `uses only:`, and in
    the key cell of a table of misses, with the entry or the row's ids as sites."""
    items = defaultdict(list)
    for name, (fname, line, uses) in sorted(entries.items()):
        job = name.split("-")[1]
        for r in rows_in(uses):
            items[r].append({"site": name, "kind": "composition", "address": f"{fname}:{line}", "by": f"FS129-{job}", "lane": LANE[job]})
    for job, head in TABLES[:3]:
        for n, ln in sections(job, head):
            if not ln.startswith("|") or set(ln.replace("|", "").strip()) <= {"-", ":", " "}:
                continue
            cells = [c.strip() for c in ln.strip().strip("|").split("|")]
            if cells[0].lower() == "mechanism":
                continue
            kind = kind_of(ln)
            for r in rows_in(cells[0]):
                for s_, _ in [x for c in cells[1:] for x in res(c)]:
                    items[r].append({"site": s_, "kind": kind, "address": f"plans/FS129-{job}-audit.md:{n}", "by": f"FS129-{job}", "lane": LANE[job]})
    return items


def check_addresses(items, entries, shift=0):
    bad = []
    cache = {}
    for i, lst in items.items():
        for it in lst:
            f, n = it["address"].rsplit(":", 1)
            n = int(n) + shift
            L = cache.setdefault(f, (ROOT / f).read_text(encoding="utf-8").splitlines())
            if 0 < n <= len(L) and L[n - 1].startswith("derivation: ") and it["kind"] == "composition":
                ok = True  # the entry's header; the token is in its block
                if ok:
                    blk = []
                    for x in L[n - 1:]:
                        if not x.strip():
                            break
                        blk.append(x)
                    ok = it["as"] in " ".join(blk)
            else:
                L = cache.setdefault(f, (ROOT / f).read_text(encoding="utf-8").splitlines())
                ok = 0 < n <= len(L) and it["as"] in L[n - 1]
                if not it["site"].startswith("J"):
                    s_tok = it["site"]
                    ok = ok and (s_tok in L[n - 1] or s_tok.split("-", 2)[-1] in L[n - 1] or "-".join(s_tok.split("-")[1:]) in L[n - 1])
            if not ok:
                bad.append(f"{i} @ {f}:{n} (as {it['as']!r}, site {it['site']})")
    return bad


def main():
    fault = "--fault" in sys.argv
    head, raw, recs = load_index()
    for x, r in zip(raw, recs):
        if json.dumps(r, ensure_ascii=False) != x:
            raise SystemExit("theorems.jsonl does not re-serialize byte for byte; refusing to write")
    index_ids = {r["id"] for r in recs}
    entries = fs129_entries()
    res = resolver(index_ids, entries)
    items = collect(index_ids, entries, res)
    bad = check_addresses(items, entries, shift=1 if fault else 0)
    n_we = sum(1 for i in items for it in items[i] if it["kind"] != "near miss")
    n_nm = sum(1 for i in items for it in items[i] if it["kind"] == "near miss")
    th_we = sorted(i for i in items if any(it["kind"] != "near miss" for it in items[i]))
    print(f"where-else: {len(th_we)} theorems with a site, {n_we} sites; near misses {n_nm} on "
          f"{sum(1 for i in items if any(it['kind'] == 'near miss' for it in items[i]))} theorems; address check failures {len(bad)}")
    if fault:
        print("(--fault: every address moved one line down; nothing written)", "— it fires" if bad else "— IT DID NOT FIRE")
        return 0 if bad else 1
    if bad:
        for b in bad[:20]:
            print("BAD ADDRESS:", b)
        return 1
    # write
    out = [head]
    for x, r in zip(raw, recs):
        lst = items.get(r["id"], [])
        r2 = dict(r)
        r2["where_else"] = [it for it in lst if it["kind"] != "near miss"]
        r2["near_misses"] = [it for it in lst if it["kind"] == "near miss"]
        line = json.dumps(r2, ensure_ascii=False)
        assert line.startswith(x[:-1]), f"other fields changed for {r['id']}"
        out.append(line)
    TH.write_text("\n".join(out) + "\n", encoding="utf-8")
    write_md(recs, items, n_we, n_nm, th_we, collect_rows(entries, res))
    return 0


def write_md(recs, items, n_we, n_nm, th_we, row_items):
    era = {r["id"]: r["era"] for r in recs}
    by_lane = defaultdict(lambda: defaultdict(int))
    th_lane = defaultdict(set)
    for i, lst in items.items():
        for it in lst:
            by_lane[it["lane"]][it["kind"]] += 1
            if it["kind"] != "near miss":
                th_lane[it["lane"]].add(i)
    with open(OUT_MD, "w", encoding="utf-8") as f:
        f.write("<!-- the where-else column of theorems.jsonl as tables | command: python3 tools/fs129_z2_whereelse.py | FS129-Z2 -->\n\n"
                "# Where else each theorem bears (FS-129)\n\n"
                "Built by `tools/fs129_z2_whereelse.py` from the FS-129 readers' tables of misses, merge lists and sweeps, their verdict paragraphs, and every "
                "FS-129 entry's `uses only:` line; each site has the reader's address. `theorems.jsonl` carries the same items in the fields `where_else` and "
                "`near_misses` (a near miss names a failing hypothesis, and is not a bearing). Re-running `tools/fs129_index.py` rewrites `theorems.jsonl` "
                "without these fields; re-run this script after it.\n\n")
        f.write(f"**Counts**: {len(th_we)} theorems have a site, {n_we} sites in all (era A {sum(1 for i in th_we if era[i] == 'A')}, era R "
                f"{sum(1 for i in th_we if era[i] == 'R')}); near misses {n_nm}.\n\n| reading lane | theorems with a site | "
                + " | ".join(k for k in ("composition", "merge", "stronger form held", "answered elsewhere", "closes", "shortens", "reduces",
                                          "shared step (not one statement)", "bears unapplied", "bears", "near miss")) + " |\n|---|---|" + "---|" * 11 + "\n")
        for ln in ("A", "R"):
            f.write(f"| {ln} | {len(th_lane[ln])} | " + " | ".join(str(by_lane[ln][k]) for k in ("composition", "merge", "stronger form held",
                    "answered elsewhere", "closes", "shortens", "reduces", "shared step (not one statement)", "bears unapplied", "bears", "near miss")) + " |\n")
        f.write("\n## By theorem\n\n| theorem | era | site | kind | address | by |\n|---|---|---|---|---|---|\n")
        for i in sorted(items):
            for it in sorted(items[i], key=lambda it: (it["kind"] == "near miss", it["site"])):
                f.write(f"| {i} | {era[i]} | {it['site'].replace('|', '/')} | {it['kind']} | {it['address']} | {it['by']} |\n")
        f.write(f"\n## Ledger rows ({len(row_items)} rows, {sum(len(v) for v in row_items.values())} sites)\n\n"
                "A ledger row is not a record of `theorems.jsonl`, so its sites are listed here only: each row an FS-129 entry names in its `uses only:` "
                "line, or a table of misses names in its mechanism cell.\n\n| row | site | kind | address | by |\n|---|---|---|---|---|\n")
        for r in sorted(row_items):
            seen = set()
            for it in row_items[r]:
                k = (it["site"], it["address"])
                if k in seen:
                    continue
                seen.add(k)
                f.write(f"| {r} | {it['site']} | {it['kind']} | {it['address']} | {it['by']} |\n")


if __name__ == "__main__":
    sys.exit(main())
