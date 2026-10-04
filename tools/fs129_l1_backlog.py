#!/usr/bin/env python3
"""FS129-L1 — writes plans/LEAN-BACKLOG.md, the Lean backlog's input, and checks it against its sources.

    python3 tools/fs129_l1_backlog.py              # write plans/LEAN-BACKLOG.md, then verify it (exit 1 on any failure)
    python3 tools/fs129_l1_backlog.py --check      # verify the existing file against the sources, write nothing
    python3 tools/fs129_l1_backlog.py --fill-merges  # fill the `text` column of data/fs129/l1/merges.csv from its `lines`
    python3 tools/fs129_l1_backlog.py --self-test  # plant five faults; each must be caught, and the clean run must pass

What it does. The order is `data/fs129/index/lean-order-corrected.md` (178 rows, dependencies first). Every statement, *not
claimed* line, grade, minds line, handoff and dated erratum is read from `plans/*-derivation.md` by the census parser
(`tools/fs71_ledger_b_check.py`, whose `load` fixes the id set, and the Ephodos gate it imports for the newer grammar) and written
under its address. The merge lines are `data/fs129/l1/merges.csv`, copied from the four audits' lists with their addresses and
checked against the audits' own lines. Nothing is paraphrased: a cell the source lacks stays empty and is counted.

The check re-reads the written file and, by a second route (regular expressions over the raw lines at each row's address, not the
gate's parser), compares every quoted block with its source: a statement altered by one character, a dropped erratum, a merge line
that does not match its audit, a row placed before something it rests on, and a superseded entry listed for formalization each fail,
naming the id. Standard library plus the census module.
"""
from __future__ import annotations

import argparse
import contextlib
import csv
import io
import re
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import fs71_ledger_b_check as census  # noqa: E402

ROOT = census.ROOT
PLANS = ROOT / "plans"
IDX = ROOT / "data" / "fs129" / "index"
L1 = ROOT / "data" / "fs129" / "l1"
OUT = PLANS / "LEAN-BACKLOG.md"
INV = PLANS / "FS129-close-inventory.md"
MERGES = L1 / "merges.csv"
ORDER_NEW = IDX / "lean-order-corrected.md"
ORDER_OLD = IDX / "lean-order.md"
CORR_README = IDX / "README-corrections.md"
EDGES_OLD = IDX / "edges.csv"
EDGES_DROPPED = IDX / "edges-dropped.csv"
FS129_FILE = "plans/FS129-derivation.md"

NOTE_RE = re.compile(r"^\*{1,2}(?:Erratum|Errata|Correction)\b")
BANNER_RE = re.compile(r"^> \*\*Correction owed")
HEADING_RE = re.compile(r"^#{1,6}\s")
RAW_START_RE = re.compile(r"^(?:[-*]\s+)?(?:derivation|verification|invention):\s|^\*\*[A-Za-z0-9][A-Za-z0-9-]*?\s+—\s|^#{1,6}\s")
DER_FIELDS = ("statement", "uses only", "not claimed", "converse", "argument", "verdict", "grade", "minds", "model",
              "prior art", "handoff")
# ids a merge line writes in a shortened form; the entry is the one the line's own audit names (listed as a CHECK in the record)
ALIASES = {"FS84-S1-S1e": "FS84-S1e", "FS129-SR1-BENDANY": "BENDANY", "FS129-SA1-FALC-FAN": "FALC-FAN",
           "FS129-SA1-FALC-DICHO-K": "DICHO-K", "FS116-Y4-EMPTY": "EMPTY"}
EXPECT = {"rows": 178, "seeds": 78, "conditional": 3, "left": 26, "joined": 7, "fs129": 44, "superseded": 12, "z1_errata": 17}
CAUTION_ITEMS = (13, 109, 116, 118, 126, 131, 137, 139)
ERRATA_116 = ("FS112-L60", "FS112-C-ENDS", "FS112-C-DOUBLE", "FS112-N3-BASE", "FS114-N2-ENDS", "FS114-N3-JOINT", "FS114-N7-3T")
UPSTREAM_MISSING = ("J45-N1", "J45-N2", "J45-SI-4", "J45-SI-5", "J45-SI-J", "J45-SI-C", "J45-SP-oi", "J45-SP-if", "X25B-L1", "X25B-PZ")
UPSTREAM_MISSING_SRC = "plans/FS129-SA1-audit.md:744-745"


def ws(s: str) -> str:
    return re.sub(r"\s+", " ", s or "").strip()


def tok_in(idv: str, text: str) -> bool:
    return re.search(r"(?<![A-Za-z0-9])" + re.escape(idv) + r"(?![A-Za-z0-9-])", text) is not None


# ------------------------------------------------------------------------------------------------ reading the derivation files

def load_entries() -> tuple[dict[str, dict], list[str]]:
    """{id: entry} for every derivation entry, read by the census parser (id set) and by this module's own scan (text).

    Returns (entries, problems). The census's id set and this scan's must agree, or a problem is reported."""
    problems: list[str] = []
    buf = io.StringIO()
    with contextlib.redirect_stdout(buf):
        census_entries, _rows, _ph, header_fails = census.load()
    if header_fails:
        problems.append(f"the census reports {header_fails} header failures: {buf.getvalue()[:300]}")
    g = census.gate()
    out: dict[str, dict] = {}
    for f in sorted(PLANS.glob("*-derivation.md")):
        prefix = f.name[: -len("-derivation.md")]
        rel = f"plans/{f.name}"
        text = f.read_text(encoding="utf-8")
        raw = text.splitlines()
        stripped, _fenced = g.strip_fences(text)
        n = len(raw)
        starts = {i for i, l in enumerate(stripped, 1) if (g.HEAD.match(l) and g.HEAD.match(l).group(1) != "control") or HEADING_RE.match(l)}
        olds = []
        for m in census.ENTRY_RE.finditer(text):
            ln = text.count("\n", 0, m.start()) + 1
            olds.append((ln, m))
            starts.add(ln)
        ordered_starts = sorted(starts)
        entries_here: list[dict] = []
        for b in g.blocks(stripped, rel):
            if b["kind"] != "derivation":
                continue
            h = b["line"]
            j = h
            while j < n and stripped[j].strip() and stripped[j][0] in " \t":
                j += 1
            fl = b["fields"]
            entries_here.append({
                "id": census.full_id(b["name"], prefix), "file": rel, "line": h, "grammar": "new", "bend": j,
                "statement": fl.get("statement", ""), "pre_proof": "", "not_claimed": fl.get("not claimed", ""),
                "grade": fl.get("grade", ""), "minds": fl.get("minds", ""), "handoff": fl.get("handoff", ""),
                "uses_only": fl.get("uses only", ""), "verdict": fl.get("verdict", ""),
            })
        for ln, m in olds:
            span = text[m.start() + 2: m.end() - 3]
            rawid, rest = re.split(r"\s+—\s+", span, maxsplit=1)
            gm = re.search(r"\s\[([^\]]*)\Z", rest)
            title, grade = rest[: gm.start()], gm.group(1)
            ptail = text[m.end():].split("\n\n", 1)[0]
            pre = ptail.split("*Proof:*", 1)[0].strip()
            ptext = text[m.start(): m.end()] + ptail
            km = re.search(r"\*Kernel:\*\s*(.*)\Z", ptext, re.S)
            nm = re.search(r"\*Not claimed:\*\s*(.*?)(?=\s\*(?:Proof|Proof verdict|Rests on it|Prior art|Kernel):\*|\Z)", ptext, re.S)
            entries_here.append({
                "id": census.full_id(rawid, prefix), "file": rel, "line": ln, "grammar": "old", "bend": ln + ptext.count("\n"),
                "statement": title, "pre_proof": pre, "not_claimed": ws(nm.group(1)) if nm else "",
                "grade": grade, "minds": "", "handoff": ws(km.group(1)) if km else "", "uses_only": "", "verdict": "",
            })
        for e in entries_here:
            h = e["line"]
            nxt = next((s for s in ordered_starts if s > h), n + 1)
            e["notes"] = region_notes(raw, e["bend"], nxt, rel) + banner_above(raw, h, rel)
            e["rests"] = " ".join(" ".join(ps) for _l, ps in paragraphs(raw, e["bend"] + 1, nxt - 1) if re.match(r"^Rests on it:", ps[0]))
            if e["id"] in out:
                problems.append(f"id {e['id']} read twice by this module's scan")
            out[e["id"]] = e
        sec = errata_section_items(raw, rel)
        for item in sec:
            for e in entries_here:
                if tok_in(e["id"], item["lead"]):
                    e["notes"].append({"kind": f"errata-section item {item['n']}", "file": rel, "line": item["line"], "text": item["text"]})
            if not any(tok_in(e["id"], item["lead"]) for e in entries_here):
                SECTION_NOTES.setdefault(rel, []).append(item)
    for idv, locs in EXTRA_NOTES.items():
        for rel, ln in locs:
            raw = (ROOT / rel).read_text(encoding="utf-8").splitlines()
            para = next((ps for l0, ps in paragraphs(raw, 1, len(raw)) if l0 == ln), None)
            if para is None or not NOTE_RE.match(para[0]) or "A(R_F)" not in "\n".join(para):
                problems.append(f"{rel}:{ln} is not the erratum item 109 names (it must be an Erratum paragraph with A(R_F))")
                continue
            out[idv]["notes"].append({"kind": "erratum named by inventory item 109 (not positioned under the entry)", "file": rel, "line": ln, "text": "\n".join(para)})
    if set(out) != set(census_entries):
        problems.append("the census id set and this module's scan differ: only-census "
                        f"{sorted(set(census_entries) - set(out))[:5]} only-scan {sorted(set(out) - set(census_entries))[:5]}")
    return out, problems


SECTION_NOTES: dict[str, list[dict]] = {}
EXTRA_NOTES = {"FS89-S0A-2": [("plans/FS89-derivation.md", 32), ("plans/FS89-derivation.md", 332)],
               "FS89-S0A-10": [("plans/FS89-derivation.md", 32), ("plans/FS89-derivation.md", 332)],
               "FS89-CL2": [("plans/FS89-derivation.md", 32)]}


def paragraphs(raw: list[str], first: int, last: int):
    """Yield (line_no, [lines]) for the blank-line-separated paragraphs of raw[first-1:last] (1-based, inclusive)."""
    cur: list[str] = []
    start = 0
    for i in range(first, last + 1):
        l = raw[i - 1]
        if l.strip():
            if not cur:
                start = i
            cur.append(l)
        elif cur:
            yield start, cur
            cur = []
    if cur:
        yield start, cur


def region_notes(raw: list[str], bend: int, nxt: int, rel: str) -> list[dict]:
    notes = []
    for ln, ps in paragraphs(raw, bend + 1, nxt - 1):
        if NOTE_RE.match(ps[0]):
            notes.append({"kind": "dated note filed under the entry", "file": rel, "line": ln, "text": "\n".join(ps)})
    return notes


def banner_above(raw: list[str], h: int, rel: str) -> list[dict]:
    i = h - 2
    while i >= 0 and not raw[i].strip():
        i -= 1
        if h - 2 - i > 1:
            return []
    if i < 0:
        return []
    j = i
    while j > 0 and raw[j - 1].strip():
        j -= 1
    ps = raw[j: i + 1]
    if BANNER_RE.match(ps[0]):
        return [{"kind": "banner directly above the entry", "file": rel, "line": j + 1, "text": "\n".join(ps)}]
    return []


def errata_section_items(raw: list[str], rel: str) -> list[dict]:
    items = []
    start = next((i for i, l in enumerate(raw) if re.match(r"^## Errata", l)), None)
    if start is None:
        return items
    end = next((i for i in range(start + 1, len(raw)) if HEADING_RE.match(raw[i])), len(raw))
    cur = None
    for i in range(start + 1, end):
        m = re.match(r"^(\d+)\. \*\*(.+?)\*\*", raw[i])
        if m:
            if cur:
                items.append(cur)
            cur = {"n": int(m.group(1)), "lead": m.group(2), "line": i + 1, "lines": [raw[i]]}
        elif cur is not None:
            cur["lines"].append(raw[i])
    if cur:
        items.append(cur)
    for it in items:
        while it["lines"] and not it["lines"][-1].strip():
            it["lines"].pop()
        it["text"] = "\n".join(it["lines"])
    return items


# ------------------------------------------------------------------------------------------------ the order files

def parse_order(path: Path) -> list[dict]:
    rows = []
    new = path == ORDER_NEW
    for line in path.read_text(encoding="utf-8").splitlines():
        if not re.match(r"^\| \d+ \|", line):
            continue
        parts = [p.strip() for p in line.strip().strip("|").split("|", 7 if new else 6)]
        if new:
            n, idv, role, was, addr, era, needs, handoff = parts
        else:
            n, idv, role, addr, era, needs, handoff = parts
            was = n
        rows.append({"n": int(n), "id": idv, "role": role, "was": was, "address": addr, "era": era,
                     "needs": [x.strip() for x in needs.split(",") if x.strip()], "handoff_order": handoff})
    return rows


def parse_left(text: str) -> tuple[list[tuple[str, int]], list[str]]:
    m = re.search(r"^Left the Lean order \((\d+);[^\n]*?\): ([^\n]+)", text, re.M)
    left = [(a, int(b)) for a, b in re.findall(r"([A-Z0-9][A-Za-z0-9-]+) \(was (\d+)\)", m.group(2))] if m else []
    j = re.search(r"^Joined it \((\d+)\): ([^\n]+)", text, re.M)
    joined = [x.strip() for x in j.group(2).split(",")] if j else []
    return left, joined


def why_left(idv: str, old_ids: set[str], seeds: set[str]) -> str:
    """A shortest path in edges.csv (as IX1 wrote it) from the entry to a seed, each edge marked with its fate in edges-dropped.csv."""
    dropped = {}
    for r in csv.DictReader(l for l in EDGES_DROPPED.read_text(encoding="utf-8").splitlines() if not l.startswith("#")):
        dropped[(r["from"], r["to"])] = f"dropped: {r['class']}, sorted by {r['sorted_by']}"
    adj: dict[str, list[str]] = {}
    for r in csv.DictReader(l for l in EDGES_OLD.read_text(encoding="utf-8").splitlines() if not l.startswith("#")):
        adj.setdefault(r["from"], []).append(r["to"])
    prev = {idv: None}
    queue = [idv]
    hit = None
    while queue and hit is None:
        cur = queue.pop(0)
        for nx in sorted(adj.get(cur, [])):
            if nx in prev:
                continue
            prev[nx] = cur
            if nx in seeds:
                hit = nx
                break
            queue.append(nx)
    if hit is None:
        return "no path to a seed in edges.csv as IX1 wrote it (CHECK)"
    path = [hit]
    while prev[path[-1]] is not None:
        path.append(prev[path[-1]])
    path.reverse()
    steps = []
    for a, b in zip(path, path[1:]):
        steps.append(f"{a} → {b} [{dropped.get((a, b), 'kept')}]")
    return "in edges.csv as IX1 wrote it: " + "; ".join(steps)


# ------------------------------------------------------------------------------------------------ merges

def load_merges(entries: dict[str, dict]) -> tuple[list[dict], list[str]]:
    fails: list[str] = []
    rows = list(csv.DictReader(MERGES.open(encoding="utf-8", newline="")))
    for r in rows:
        key = f"{r['list']} item {r['item']}"
        for col in ("x_ids", "a_ids", "also_ids", "names_not_entries"):
            r[col + "_l"] = [x for x in r[col].split(";") if x]
        f, _, rg = r["lines"].rpartition(":")
        a, b = (int(x) for x in rg.split("-"))
        src = (ROOT / f).read_text(encoding="utf-8").splitlines()
        seg = src[a - 1: b]
        if any(not s.strip() for s in seg):
            fails.append(f"{key}: its lines {r['lines']} include a blank line")
        r["source_text"] = "\n".join(seg)
        if ws(r["text"]) != ws(r["source_text"]):
            fails.append(f"{key}: the text column differs from {r['lines']}")
        for col in ("x_ids_l", "a_ids_l", "also_ids_l"):
            for idv in r[col]:
                if idv not in entries:
                    fails.append(f"{key}: names id {idv}, which is not an entry of any derivation file")
                    continue
                shown = ALIASES.get(idv)
                if not (tok_in(idv, r["source_text"]) or tok_in(idv.split("-", 1)[1], r["source_text"])
                        or (shown and tok_in(shown, r["source_text"]))):
                    fails.append(f"{key}: id {idv} does not occur in its lines {r['lines']}")
        for nm in r["names_not_entries_l"]:
            if nm in entries:
                fails.append(f"{key}: {nm} is declared a non-entry but is an entry")
            if not tok_in(nm, r["source_text"]):
                fails.append(f"{key}: non-entry name {nm} does not occur in its lines")
    return rows, fails


def fill_merges() -> int:
    rows = list(csv.DictReader(MERGES.open(encoding="utf-8", newline="")))
    fields = list(rows[0].keys())
    for r in rows:
        f, _, rg = r["lines"].rpartition(":")
        a, b = (int(x) for x in rg.split("-"))
        r["text"] = ws(" ".join((ROOT / f).read_text(encoding="utf-8").splitlines()[a - 1: b]))
    with MERGES.open("w", encoding="utf-8", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=fields, lineterminator="\n")
        w.writeheader()
        w.writerows(rows)
    print(f"filled {len(rows)} merge lines")
    return 0


# ------------------------------------------------------------------------------------------------ the inventory items

def inventory_item(n: int) -> tuple[int, str]:
    lines = INV.read_text(encoding="utf-8").splitlines()
    start = next(i for i, l in enumerate(lines) if re.match(rf"^{n}\. ", l))
    end = start + 1
    while end < len(lines) and not re.match(r"^\d+\. ", lines[end]) and not HEADING_RE.match(lines[end]):
        end += 1
    seg = lines[start:end]
    while seg and not seg[-1].strip():
        seg.pop()
    return start + 1, "\n".join(seg)


# ------------------------------------------------------------------------------------------------ the model

def build_model(entries: dict[str, dict]) -> tuple[dict, list[str]]:
    fails: list[str] = []
    order = parse_order(ORDER_NEW)
    old = parse_order(ORDER_OLD)
    ctext = ORDER_NEW.read_text(encoding="utf-8")
    left, joined = parse_left(ctext)
    if len(order) != EXPECT["rows"]:
        fails.append(f"the corrected order has {len(order)} rows, the brief says {EXPECT['rows']}")
    seeds_new = [r for r in order if "SEED" in r["role"]]
    cond = [r for r in order if "conditional" in r["role"]]
    if len(seeds_new) != EXPECT["seeds"] or len(cond) != EXPECT["conditional"]:
        fails.append(f"seeds {len(seeds_new)} / conditional {len(cond)} differ from {EXPECT['seeds']} / {EXPECT['conditional']}")
    if len(left) != EXPECT["left"] or len(joined) != EXPECT["joined"]:
        fails.append(f"left {len(left)} / joined {len(joined)} differ from {EXPECT['left']} / {EXPECT['joined']}")
    new_ids = {r["id"] for r in order}
    old_ids = {r["id"] for r in old}
    if old_ids - new_ids != {a for a, _ in left}:
        fails.append("the corrected file's `Left the Lean order` line differs from lean-order.md minus the corrected order")
    if new_ids - old_ids != set(joined):
        fails.append("the corrected file's `Joined it` line differs from the corrected order minus lean-order.md")
    for r in order:
        if r["id"] not in entries:
            fails.append(f"order row {r['id']} is not an entry")
            continue
        e = entries[r["id"]]
        if r["address"] != f"{e['file']}:{e['line']}":
            STALE.append((r["id"], r["address"], f"{e['file']}:{e['line']}"))
        elif False:
            pass
    old_seeds = {r["id"] for r in old if "SEED" in r["role"]}
    f129 = [e for e in entries.values() if e["file"] == FS129_FILE]
    if len(f129) != EXPECT["fs129"]:
        fails.append(f"{FS129_FILE} has {len(f129)} entries, the brief says {EXPECT['fs129']}")
    superseded = {e["id"]: e for e in f129 if re.match(r"none — superseded by ", e["handoff"])}
    if len(superseded) != EXPECT["superseded"]:
        fails.append(f"{len(superseded)} superseded entries in {FS129_FILE}, the brief says {EXPECT['superseded']}")
    comps = [e for e in f129 if e["id"] not in superseded and e["id"] not in new_ids]
    comp_ids = {e["id"] for e in comps}
    # the compositions' upstream: full ids in `uses only:` and in a `derived from:` grade
    ups: dict[str, list[str]] = {}
    all_ids = sorted(entries, key=len, reverse=True)
    for e in comps:
        src = e["uses_only"] + " ; " + (e["grade"] if e["grade"].startswith("derived from:") else "")
        found = [i for i in all_ids if i != e["id"] and tok_in(i, src)]
        ups[e["id"]] = sorted(set(found))
    # a superseded entry named in `uses only:` is read as the form its handoff names (for the order only; both lists are shown)
    eff: dict[str, list[str]] = {}
    for k, v in ups.items():
        out_ids: set[str] = set()
        for u in v:
            if u in superseded:
                hm = re.match(r"none — superseded by (FS129-[A-Z0-9-]+?)(?:,? with (FS129-[A-Z0-9-]+?))?(?= |\)|;|,|$)", superseded[u]["handoff"])
                out_ids.update(x for x in (hm.groups() if hm else ()) if x)
                if not hm:
                    fails.append(f"{u}: superseded, but its handoff names no superseding entry the script can read")
            else:
                out_ids.add(u)
        eff[k] = sorted(out_ids - {k})
    # the `Rests on it:` prose of a composition names what rests on it; where that names a composition whose `uses only:` does not
    # name it, the pair is a CHECK, and the order also puts the used one first (safe under either reading unless it makes a cycle)
    reach: dict[str, set[str]] = {}
    def below(x: str, seen: set[str] | None = None) -> set[str]:
        seen = seen if seen is not None else set()
        for u in eff.get(x, []):
            if u not in seen:
                seen.add(u)
                below(u, seen)
        return seen
    after: dict[str, list[str]] = {k: [] for k in comp_ids}
    cand: set[tuple[str, str]] = set()  # (y, x): y's prose names x, and x's `uses only:` does not reach y
    for y in sorted(comp_ids):
        txt = entries[y]["rests"]
        for x in sorted(comp_ids):
            if x == y or not tok_in(x, txt) or y in below(x):
                continue
            if x in below(y):
                PROSE_CONFLICT.append((y, x))
            else:
                cand.add((y, x))
    for y, x in sorted(cand):
        if (x, y) in cand:
            if y < x:
                PROSE_MUTUAL.append((y, x))
        else:
            after[x].append(y)
            PROSE_ONLY.append((y, x))
    corder, cyc = topo(sorted(comp_ids), {k: sorted(set([u for u in v if u in comp_ids] + after.get(k, []))) for k, v in eff.items()})
    model = {"order": order, "old": old, "left": left, "joined": joined, "superseded": superseded, "comps": corder,
             "comp_cycle": cyc, "comp_after": after, "comp_ups": eff, "comp_ups_filed": ups, "old_seeds": old_seeds, "entries": entries}
    if cyc:
        fails.append(f"the compositions' order has a dependency cycle: {sorted(cyc)}")
    return model, fails


def topo(ids: list[str], deps: dict[str, list[str]]) -> tuple[list[str], set[str]]:
    """Dependencies first, ties by id; members of a cycle together, flagged."""
    remaining = set(ids)
    out: list[str] = []
    cyc: set[str] = set()
    while remaining:
        ready = sorted(i for i in remaining if all(d not in remaining or d == i for d in deps.get(i, [])))
        if not ready:
            group = sorted(remaining)
            cyc.update(group)
            out.extend(group)
            break
        out.append(ready[0])
        remaining.discard(ready[0])
    return out, cyc


CAUTION_TITLES = {
    13: "the conditional seeds (item 13)",
    109: "FS89-S0A-2 and its siblings are false as written (item 109)",
    116: "the errata the index cannot see (item 116)",
    118: "the rows that left the order (item 118)",
    126: "DOUBLETIP is not to replace V6-HUG's colour step (item 126)",
    131: "the same, as a statement defect (item 131)",
    137: "two merged forms omit a clause of their source (item 137)",
    139: "verifier records named for promotion, not counted (item 139)",
}


def governs(model: dict, extra_ids: list[str]) -> dict[int, list[str]]:
    order_ids = [r["id"] for r in model["order"]]
    g = {
        13: [r["id"] for r in model["order"] if "conditional" in r["role"]],
        109: ["FS89-S0A-2", "FS89-S0A-10", "FS89-CL2"],
        116: list(ERRATA_116),
        118: [a for a, _ in model["left"]],
        126: ["FS116-V6-HUG", "FS116-Y4-EMPTY", "FS129-MR1-DOUBLETIP", "FS129-SR3-EMPTY-NS"],
        131: ["FS116-V6-HUG", "FS116-Y4-EMPTY", "FS129-MR1-DOUBLETIP", "FS129-SR3-EMPTY-NS"],
        137: ["FS129-SR1-BENDLE3", "FS129-OR1-BEND3", "FS129-SR1-RINGBAND", "FS129-OA1-RINGWIND"],
        139: ["J45-N1", "J45-N2", "J45-SI-4", "J45-SI-5", "FS84-S1-S1e"],
    }
    del order_ids
    return g


# ------------------------------------------------------------------------------------------------ rendering

def quote(text: str) -> str:
    lines = text.split("\n") if text else [""]
    return "\n".join("> " + l if l else ">" for l in lines)


def qblock(idv: str, field: str, text: str, label: str) -> str:
    if text == "":
        return f"<!--q {idv} {field}-->\n**{label}:** *(empty in the source — no such field)*\n"
    return f"<!--q {idv} {field}-->\n**{label}:**\n{quote(text)}\n"


def merge_notes_for(idv: str, merges: list[dict]) -> list[tuple[dict, str]]:
    out: list[tuple[dict, str]] = []
    key = lambda m: f"{m['list']}-{m['item']}"
    for m in merges:
        labels = []
        if m["kind"] == "REPLACE":
            if idv in m["x_ids_l"]:
                labels.append("to formalize")
            if idv in m["a_ids_l"]:
                labels.append("replaced in whole or in the part the line names")
        elif m["kind"] == "AMEND":
            if idv in m["x_ids_l"]:
                labels.append("to formalize, as amended")
            if idv in m["a_ids_l"]:
                labels.append("named by the amending line")
        elif m["kind"] in ("DO-NOT-FORMALIZE", "QUOTE-WITH-ERRATA", "KEEP"):
            if idv in m["a_ids_l"]:
                labels.append({"DO-NOT-FORMALIZE": "do not formalize as stated", "QUOTE-WITH-ERRATA": "quote with its errata",
                               "KEEP": "unchanged"}[m["kind"]])
        if idv in m["also_ids_l"]:
            labels.append("named")
        if labels:
            out.append((m, " + ".join(labels)))
    # a line amended or replaced by a later one: the later line is shown beside it, on the rows the earlier names
    have = {key(m) for m, _ in out}
    for m, _lab in list(out):
        if m["status"].startswith(("amended-by:", "replaced-by:")):
            tgt = m["status"].split(":", 1)[1]
            if tgt not in have:
                later = next((x for x in merges if key(x) == tgt), None)
                if later:
                    out.append((later, f"the line that {'amends' if m['status'].startswith('amended') else 'replaces'} {key(m)}, shown because the earlier line names this row"))
                    have.add(tgt)
    return out


def render_row(idv: str, e: dict, head: str, meta: str, merges: list[dict], cautions: list[int], extra: str = "",
               uses: bool = False, ups: list[str] | None = None, aft: list[str] | None = None) -> str:
    s = [f"### {head}\n<!--row {idv} {e['file']}:{e['line']}-->", meta]
    if ups is not None:
        s.append(f"<!--needs {idv}: {','.join(ups)}-->")
    if aft:
        s.append(f"<!--after {idv}: {','.join(aft)}-->")
    if cautions:
        s.append("**Cautions:** " + ", ".join(f"[C{c}](#c{c})" for c in cautions))
    if extra:
        s.append(extra)
    s.append("")
    s.append(qblock(idv, "statement", e["statement"], "Statement as filed" + (" (the header's own words; the entry has no `statement:` field)" if e["grammar"] == "old" else "")))
    if e["pre_proof"]:
        s.append(qblock(idv, "pre_proof", e["pre_proof"], "Text between the header and `*Proof:*`"))
    s.append(qblock(idv, "not_claimed", e["not_claimed"], "Not claimed"))
    s.append(qblock(idv, "grade", e["grade"], "Grade as filed"))
    s.append(qblock(idv, "minds", e["minds"], "Minds as filed" + (" (older grammar: inside the grade)" if e["grammar"] == "old" else "")))
    s.append(qblock(idv, "handoff", e["handoff"], "Handoff as filed" if e["grammar"] == "new" else "`*Kernel:*` line as filed"))
    if uses:
        s.append(qblock(idv, "uses_only", e["uses_only"], "Uses only"))
    for n in e["notes"]:
        s.append(f"<!--q {idv} note@{n['line']}-->\n**{n['kind']} (`{n['file']}:{n['line']}`):**\n{quote(n['text'])}\n")
    for m, label in merge_notes_for(idv, merges):
        s.append(f"<!--q {idv} merge@{m['list']}-{m['item']}-->\n**Merge note — {label}** ({m['list']} item {m['item']}, `{m['lines']}`; status {m['status']}):\n{quote(m['text'])}\n")
    if e["file"] in SECTION_NOTES and "FS-114" in e["handoff"]:
        its = ", ".join(str(i["n"]) for i in SECTION_NOTES[e["file"]])
        s.append(f"*Section notes of `{e['file']}` (items {its}) govern this row's `*Kernel:*` line: see § How to read this file.*\n")
    return "\n".join(s)


def git(*args: str) -> str:
    r = subprocess.run(["git", *args], cwd=ROOT, capture_output=True, text=True)
    return r.stdout.rstrip("\n")


def write_md(model: dict, merges: list[dict]) -> tuple[str, dict]:
    entries = model["entries"]
    order = model["order"]
    cnt: dict[str, int] = {}
    cauts_all = governs(model, [])
    caut_of: dict[str, list[int]] = {}
    for c, ids in cauts_all.items():
        for i in ids:
            caut_of.setdefault(i, []).append(c)
    shown = {r["id"] for r in order} | set(model["comps"]) | {a for a, _ in model["left"]}
    named: dict[str, list[str]] = {}
    for m in merges:
        for col in ("x_ids_l", "a_ids_l", "also_ids_l"):
            for i in m[col]:
                named.setdefault(i, []).append(f"{m['list']} item {m['item']}")
    for i in UPSTREAM_MISSING:
        named.setdefault(i, []).append(f"SA1 § 6.3 'Upstream missing from the backlog's closure' ({UPSTREAM_MISSING_SRC})")
    for c, ids in cauts_all.items():
        if c in (109, 139):
            for i in ids:
                named.setdefault(i, []).append(f"inventory item {c}")
    extras = sorted(i for i in named if i not in shown and i not in model["superseded"])
    head = git("rev-parse", "--short=10", "HEAD")
    dirty = git("status", "--porcelain", "--", "plans/*-derivation.md", "plans/FS129-close-inventory.md", "plans/FS129-SR1-audit.md",
                "plans/FS129-SR2-audit.md", "plans/FS129-SA1-audit.md", "plans/FS129-SR3-audit.md", "data/fs129/index", "data/fs129/l1/merges.csv",
                "tools/fs129_l1_backlog.py")
    dirty_files = [l[3:] for l in dirty.splitlines() if "LEAN-BACKLOG" not in l]
    state = "inputs clean" if not dirty_files else "inputs NOT clean: " + ", ".join(dirty_files[:6])
    o = [f"<!-- the Lean backlog's input | command: python3 tools/fs129_l1_backlog.py | written at commit {head} ({state}) | FS129-L1, from data/fs129/index/lean-order-corrected.md, plans/*-derivation.md, data/fs129/l1/merges.csv -->",
         "", "# The Lean backlog's input", "",
         "*Written by `tools/fs129_l1_backlog.py` (the Clerk, FS129-L1); every statement, grade, handoff, erratum and merge line below is quoted by that script from the address given, never copied by hand. The check that re-reads this file against its sources is the same script's second half (`--check`). Where a cell is empty the source has no such field, and the count is in § Counts.*", ""]
    # ---- how to read
    o += ["## How to read this file", "",
          "- **The order** (§ The order) is `data/fs129/index/lean-order-corrected.md`, 178 entries, dependencies first, ties by id; a dependency cycle's members stand together, flagged CYCLE. A row's **role** is the corrected file's word: SEED (an entry whose `handoff:` names de Bruijn), *upstream* (an entry a seed rests on), ROUTE-ONLY (in the closure only through a second route's edge), CYCLE, and *conditional* for the three seeds whose `handoff:` begins \"none\" and names de Bruijn on a later line (inventory item 13). **Upstream ids** are the order file's `needs` column (the corrected edges, `data/fs129/index/edges-corrected.csv`).",
          "- **Address**: `plans/<file>:<line>`, the line of the entry's header, checked against the derivation file by the script.",
          "- **Statement**: for an entry in the Ephodos grammar, its `statement:` field; for an entry in the older grammar (every FS-112 entry among them) there is no such field, and the header's own words are quoted, marked as such. **Not claimed**, **grade**, **minds**, **handoff**: the fields of the entry; the older grammar has no `not claimed:` or `minds:` field (its minds are inside the grade) and its `*Kernel:*` line stands for the handoff. A cell the source lacks is shown empty, never filled from prose.",
          "- **Dated notes**: every paragraph filed under an entry that begins *Erratum*, *Errata* or *Correction*, every banner *Correction owed* directly above it, and every numbered item of a `## Errata` section whose bold lead names it, is quoted under its statement, with its address. Where such a note and the entry differ, the note governs (plans/FS112-derivation.md's own rule for its section).",
          "- **Merge notes**: the four audits' lists (SR1 § 6.2, SR2 § 4.3, SA1 § 6.3, SR3 § 5.1) are `data/fs129/l1/merges.csv`, one line each with its address and its text copied by the script and checked against the audit's own lines. A row carries each line that names it, quoted whole, with the way it names the row (*to formalize*; *replaced in whole or in the part the line names*; *do not formalize as stated*; *quote with its errata*; *unchanged*; *named*). A line's status is shown: SR1 item 2 is *amended-by* SR3 item 25 and SR2 item 19 is *replaced-by* SR3 item 23, as the later audit says of each; both lines are quoted, with their status, and neither is applied silently.",
          "- **Cautions** (§ Cautions) are inventory items, each quoted whole; a row lists the cautions that govern it.",
          "- **Never formalized as filed**: the twelve superseded entries of `plans/FS129-derivation.md` have no row; § FS-129's compositions lists each with its superseding form.",
          ""]
    for rel, items in sorted(SECTION_NOTES.items()):
        o.append(f"**Notes of `{rel}`'s errata section that name no entry** (quoted by the script; item 8 governs every FS-112 `*Kernel:*` line that reads \"stub — with FS-114\"):")
        o.append("")
        for it in items:
            o.append(f"<!--q SECTION {rel}#{it['n']}-->\n{quote(it['text'])}\n")
    status_lines = [m for m in merges if m["status"] != "applied"]
    o.append("**Merge lines whose status is not `applied`:** " + "; ".join(f"{m['list']} item {m['item']} ({m['status']})" for m in status_lines) + ".")
    o.append("")
    # ---- cautions
    o += ["## Cautions", ""]
    for c in CAUTION_ITEMS:
        ln, text = inventory_item(c)
        ids = cauts_all[c]
        o.append(f"### C{c}\n<a id=\"c{c}\"></a>\n**{CAUTION_TITLES[c]}** — `plans/FS129-close-inventory.md:{ln}`. **Rows it governs:** " +
                 (", ".join(f"`{i}`" for i in ids) if ids else "none") + ".")
        o.append("")
        o.append(f"<!--q C{c} text-->\n{quote(text)}\n")
        if c == 118:
            o.append("*Each row under § Left the order carries this caution.*\n")
    # ---- order
    o += ["## The order", ""]
    for r in order:
        e = entries[r["id"]]
        meta = f"**Address** `{e['file']}:{e['line']}` · **Role** {r['role']} · **Era** {r['era']} · **Was** {r['was']} in `lean-order.md` · **Upstream ids** " + (", ".join(r["needs"]) if r["needs"] else "none")
        o.append(render_row(r["id"], e, f"{r['n']}. {r['id']}", meta, merges, caut_of.get(r["id"], []), ups=r["needs"]))
        cnt["order_rows"] = cnt.get("order_rows", 0) + 1
    # ---- compositions
    o += ["## FS-129's compositions", "",
          f"Every non-superseded entry of `{FS129_FILE}` not in the order ({len(model['comps'])} entries), dependencies first, ties by id. **Upstream ids** are the full ids in the entry's `uses only:` and in a `derived from:` grade (the corrected edges do not cover these entries: the index predates them). The entry's `uses only:` is quoted so the reader can see what the ids were read from.", ""]
    for k, idv in enumerate(model["comps"], 1):
        e = entries[idv]
        ups = model["comp_ups"][idv]
        filed = model["comp_ups_filed"][idv]
        flag = " · CYCLE" if idv in model["comp_cycle"] else ""
        meta = f"**Address** `{e['file']}:{e['line']}` · **Role** FS-129 composition{flag} · **Upstream ids** " + (", ".join(ups) if ups else "none")
        if filed != ups:
            meta += " (the `uses only:` names " + ", ".join(filed) + "; a superseded form there is read as the form its handoff names)"
        aft = model["comp_after"][idv]
        if aft:
            meta += " · **Also placed after** " + ", ".join(aft) + " (their `Rests on it:` prose names this entry)"
        o.append(render_row(idv, e, f"C{k}. {idv}", meta, merges, caut_of.get(idv, []), uses=True, ups=ups, aft=aft))
        cnt["comp_rows"] = cnt.get("comp_rows", 0) + 1
    o += ["### Superseded forms (no row; never the thing to formalize)", "",
          "| id | address | handoff as filed (names the superseding form) | named by a merge line |", "|---|---|---|---|"]
    for idv, e in sorted(model["superseded"].items()):
        o.append(f"| {idv} | `{e['file']}:{e['line']}` | {e['handoff'].replace('|', '/')} | {'; '.join(named.get(idv, [])) or '—'} |")
    o.append("")
    # ---- left
    o += ["## Left the order", "",
          "The entries of `data/fs129/index/lean-order.md` that `lean-order-corrected.md` no longer holds (26). **Leaving means no seed rests on the entry along the corrected edges, which is not the same as having no value** (inventory item 118, caution C118). *Why*: the shortest path in `edges.csv` (as IX1 wrote it) from the entry to a seed, each edge marked with its fate in `edges-dropped.csv`; the README of the corrections (`data/fs129/index/README-corrections.md` § 2) says more of three of them.", ""]
    seeds = model["old_seeds"]
    old_ids = {r["id"] for r in model["old"]}
    oldrow = {r["id"]: r for r in model["old"]}
    for idv, was in model["left"]:
        e = entries[idv]
        why = why_left(idv, old_ids, seeds)
        meta = f"**Address** `{e['file']}:{e['line']}` · **Role in `lean-order.md`** {oldrow[idv]['role']} · **Was** {was} · **Why it left** {why}"
        o.append(render_row(idv, e, f"L{was}. {idv}", meta, merges, sorted(set(caut_of.get(idv, []) + [118]))))
        cnt["left_rows"] = cnt.get("left_rows", 0) + 1
    # ---- extras
    o += ["## Named by a merge line or a caution, not in the order", "",
          "Entries the audits' lists or the cautions name — to formalize, to replace, or as upstream the closure misses — that are in none of the sections above. Quoted so that the backlog session has the form each merge line points to. Their `Named by` lines are addresses; nothing here is a ruling (the superseded forms are not listed; see above).", ""]
    for idv in extras:
        e = entries[idv]
        meta = f"**Address** `{e['file']}:{e['line']}` · **Role** not in the order · **Named by** " + "; ".join(named[idv])
        o.append(render_row(idv, e, idv, meta, merges, sorted(caut_of.get(idv, []))))
        cnt["extra_rows"] = cnt.get("extra_rows", 0) + 1
    # ---- counts
    rows_all = cnt.get("order_rows", 0) + cnt.get("comp_rows", 0) + cnt.get("left_rows", 0) + cnt.get("extra_rows", 0)
    roles: dict[str, int] = {}
    for r in order:
        key = "SEED (conditional)" if "conditional" in r["role"] else ("SEED" if "SEED" in r["role"] else "upstream")
        roles[key] = roles.get(key, 0) + 1
    n_route = sum("ROUTE-ONLY" in r["role"] for r in order)
    n_cycle = sum("CYCLE" in r["role"] for r in order)
    applied_notes = sum(len(merge_notes_for(i, merges)) for i in shown | set(extras))
    n_notes = sum(len(entries[i]["notes"]) for i in shown | set(extras))
    n_caut = sum(len(caut_of.get(i, [])) for i in shown | set(extras))
    not_rows = sorted(i for i in named if i not in shown and i not in set(extras) and i not in model["superseded"])
    empty_nc = sum(1 for i in shown | set(extras) if entries[i]["not_claimed"] == "")
    empty_gr = sum(1 for i in shown | set(extras) if entries[i]["grade"] == "")
    old_rows = sum(1 for i in shown | set(extras) if entries[i]["grammar"] == "old")
    o += ["## Counts", "",
          f"<!--count rows={rows_all} order={cnt.get('order_rows', 0)} comps={cnt.get('comp_rows', 0)} left={cnt.get('left_rows', 0)} extras={cnt.get('extra_rows', 0)} merge_notes={applied_notes} notes={n_notes} cautions={n_caut}-->",
          f"- **Rows**: {rows_all} in all — {cnt.get('order_rows', 0)} in § The order, {cnt.get('comp_rows', 0)} in § FS-129's compositions, {cnt.get('left_rows', 0)} in § Left the order, {cnt.get('extra_rows', 0)} in the last section. Every row's statement is quoted: {rows_all} statement blocks (an older-grammar entry's is its header's words).",
          f"- **The order's rows by role**: " + ", ".join(f"{k} {v}" for k, v in sorted(roles.items())) + f"; of them {n_route} marked ROUTE-ONLY and {n_cycle} marked CYCLE (a mark can sit beside SEED or upstream).",
          f"- **Merge lines**: {len(merges)} in `data/fs129/l1/merges.csv` ({len([m for m in merges if m['status'] == 'applied'])} with status applied, {len(status_lines)} amended or replaced by a later line, both shown); {applied_notes} merge notes attached to rows (one per line per row it names).",
          f"- **Dated notes attached** (errata, corrections, banners, errata-section items): {n_notes}, across the rows above; the 17 errata FS129-Z1 and SA1 filed are all found (the script fails if not 17) and each is attached to the row it sits under, or is listed in `data/fs129/l1/README.md` § Coverage if its entry is not a row.",
          f"- **Cautions attached**: {n_caut} (row, item) pairs over {len(CAUTION_ITEMS)} items.",
          f"- **Cells left empty because the source has none**: {empty_nc} rows with no *not claimed* line ({old_rows} rows are in the older grammar, which has no such field); {empty_gr} with no grade.",
          f"- **Ids a merge line or caution names that have no row** (superseded forms excluded, listed above): " + (", ".join(f"`{i}`" for i in not_rows) if not_rows else "none") + ".",
          ""]
    return "\n".join(o), {"rows": rows_all, **cnt, "merge_notes": applied_notes, "notes": n_notes, "cautions": n_caut, "extras": extras,
                          "empty_nc": empty_nc, "empty_gr": empty_gr, "old_rows": old_rows, "no_row": not_rows}


# ------------------------------------------------------------------------------------------------ the check (a second route)

def indep(file: str, line: int) -> dict:
    """Fields of the entry whose header is at file:line, by regular expressions over the raw lines (not the gate's parser)."""
    raw = (ROOT / file).read_text(encoding="utf-8").splitlines()
    first = raw[line - 1]
    out = {"statement": "", "pre_proof": "", "not_claimed": "", "grade": "", "minds": "", "handoff": "", "uses_only": ""}
    if re.match(r"^(?:[-*]\s+)?derivation:", first):
        blk = [first]
        j = line
        while j < len(raw) and raw[j].strip() and raw[j][0] in " \t":
            blk.append(raw[j])
            j += 1
        body = "\n".join(blk[1:])
        keys = "|".join(re.escape(k) for k in DER_FIELDS)
        def grab(k: str) -> str:
            m = re.search(rf"^[ \t]+(?:[-*]\s+)?{re.escape(k)}[ \t]*:[ \t]?(.*?)(?=^[ \t]+(?:[-*]\s+)?(?:{keys})[ \t]*:|\Z)", body, re.M | re.S)
            return ws(m.group(1)) if m else ""
        out["statement"] = grab("statement")
        out["not_claimed"] = grab("not claimed")
        out["grade"] = grab("grade")
        out["minds"] = grab("minds")
        out["handoff"] = grab("handoff")
        out["uses_only"] = grab("uses only")
    else:
        chunk = "\n".join(raw[line - 1:])
        mm = re.match(r"\*\*(.*?)\]\*\*", chunk, re.S)
        assert mm, (file, line)
        span = mm.group(1)
        rest = re.split(r"\s+—\s+", span, maxsplit=1)[1]
        gm = re.search(r"\s\[([^\]]*)\Z", rest)
        title, grade = rest[: gm.start()], gm.group(1)
        ptail = chunk[mm.end():].split("\n\n", 1)[0]
        ptext = chunk[: mm.end()] + ptail
        km = re.search(r"\*Kernel:\*\s*(.*)\Z", ptext, re.S)
        nm = re.search(r"\*Not claimed:\*\s*(.*?)(?=\s\*(?:Proof|Proof verdict|Rests on it|Prior art|Kernel):\*|\Z)", ptext, re.S)
        out["statement"] = title
        out["pre_proof"] = ptail.split("*Proof:*", 1)[0].strip()
        out["grade"] = grade
        out["handoff"] = ws(km.group(1)) if km else ""
        out["not_claimed"] = ws(nm.group(1)) if nm else ""
    return out


def indep_notes(file: str, line: int) -> dict[int, str]:
    """{first line: paragraph text} of the dated notes filed between this header and the next header or heading."""
    raw = (ROOT / file).read_text(encoding="utf-8").splitlines()
    n = len(raw)
    nxt = next((i for i in range(line + 1, n + 1) if RAW_START_RE.match(raw[i - 1])), n + 1)
    out: dict[int, str] = {}
    i = line + 1
    while i < nxt:
        if NOTE_RE.match(raw[i - 1]) and (i == 1 or not raw[i - 2].strip()):
            j = i
            while j <= n and raw[j - 1].strip():
                j += 1
            out[i] = "\n".join(raw[i - 1: j - 1])
            i = j
        else:
            i += 1
    return out


def raw_para(file: str, line: int) -> str:
    raw = (ROOT / file).read_text(encoding="utf-8").splitlines()
    j = line
    while j <= len(raw) and raw[j - 1].strip():
        j += 1
    return "\n".join(raw[line - 1: j - 1])


def raw_item(file: str, line: int) -> str:
    raw = (ROOT / file).read_text(encoding="utf-8").splitlines()
    j = line + 1
    while j <= len(raw) and not re.match(r"^\d+\. \*\*", raw[j - 1]) and not HEADING_RE.match(raw[j - 1]):
        j += 1
    seg = raw[line - 1: j - 1]
    while seg and not seg[-1].strip():
        seg.pop()
    return "\n".join(seg)


def parse_md(md: str) -> dict:
    rows: list[dict] = []
    cur = None
    for line in md.split("\n"):
        m = re.match(r"<!--row (\S+) (\S+):(\d+)-->", line)
        if m:
            cur = {"id": m.group(1), "file": m.group(2), "line": int(m.group(3)), "needs": None}
            rows.append(cur)
            continue
        m = re.match(r"<!--needs (\S+): ?(.*)-->", line)
        if m and cur and cur["id"] == m.group(1):
            cur["needs"] = [x for x in m.group(2).split(",") if x]
        m = re.match(r"<!--after (\S+): ?(.*)-->", line)
        if m and cur and cur["id"] == m.group(1):
            cur["after"] = [x for x in m.group(2).split(",") if x]
    blocks: dict[tuple[str, str], str] = {}
    for m in re.finditer(r"<!--q (\S+) (\S+)-->\n((?:\*\*[^\n]*\n)?(?:>[^\n]*(?:\n|$))*)", md):
        body = m.group(3)
        qlines = [l for l in body.split("\n") if l.startswith(">")]
        text = "\n".join(l[2:] if l.startswith("> ") else "" for l in qlines)
        key = (m.group(1), m.group(2))
        if key in blocks:
            blocks[key] += "\n#DUP#"
        blocks[key] = text
    return {"rows": rows, "blocks": blocks}


def verify(md: str, model: dict, merges: list[dict], extras: list[str]) -> list[str]:
    fails: list[str] = []
    p = parse_md(md)
    blocks = p["blocks"]
    entries = model["entries"]
    seen_ids = [r["id"] for r in p["rows"]]
    if len(seen_ids) != len(set(seen_ids)):
        fails.append("a row id appears twice in the file")
    order_ids = [r["id"] for r in model["order"]]
    expected = order_ids + model["comps"] + [a for a, _ in model["left"]] + extras
    if seen_ids != expected:
        fails.append(f"the file's rows differ from the expected rows (first difference at {next((k for k, (a, b) in enumerate(zip(seen_ids, expected)) if a != b), min(len(seen_ids), len(expected)))})")
    nstat = 0
    for r in p["rows"]:
        idv = r["id"]
        src = indep(r["file"], r["line"])
        e = entries.get(idv)
        if e is None or (e["file"], e["line"]) != (r["file"], r["line"]):
            fails.append(f"{idv}: the row's address {r['file']}:{r['line']} is not the entry's")
            continue
        for field in ("statement", "pre_proof", "not_claimed", "grade", "minds", "handoff", "uses_only"):
            if field == "uses_only" and (idv not in model["comps"]):
                continue
            if field == "pre_proof" and not src["pre_proof"]:
                if (idv, field) in blocks:
                    fails.append(f"{idv}: a pre_proof block is quoted but the source has none")
                continue
            if field == "minds" and e["grammar"] == "old":
                want = ""
            else:
                want = src[field]
            got = blocks.get((idv, field))
            if got is None:
                fails.append(f"{idv}: the {field} block is missing from the file")
                continue
            if field == "statement":
                nstat += 1
            if ws(got) != ws(want):
                fails.append(f"{idv}: the {field} differs from its source ({r['file']}:{r['line']}): file says {ws(got)[:80]!r}…, source says {ws(want)[:80]!r}…")
        # dated notes: what the file holds under the entry is exactly what the source holds there, found by a second route
        want_notes = indep_notes(r["file"], r["line"])
        have = {int(k[1].split("@")[1]): v for k, v in blocks.items() if k[0] == idv and k[1].startswith("note@")}
        read_notes = {x["line"]: x for x in e["notes"]}
        for ln, txt in want_notes.items():
            if ln not in have:
                fails.append(f"{idv}: the erratum at {r['file']}:{ln} is missing from the file")
            elif ws(have[ln]) != ws(txt):
                fails.append(f"{idv}: the erratum at {r['file']}:{ln} differs from its source")
        for ln, x in read_notes.items():
            if ln not in have:
                fails.append(f"{idv}: the note at {x['file']}:{ln} (read for the entry) is missing from the file")
            elif x["kind"].startswith("dated note") and ln not in want_notes:
                fails.append(f"{idv}: the note at {x['file']}:{ln} is in the file but is not a paragraph the source files under the entry")
            elif x["kind"].startswith(("erratum named", "banner")):
                want = raw_para(x["file"], ln)
                if ws(have[ln]) != ws(want):
                    fails.append(f"{idv}: the note at {x['file']}:{ln} differs from its source")
            elif x["kind"].startswith("errata-section"):
                want = raw_item(x["file"], ln)
                if ws(have[ln]) != ws(want):
                    fails.append(f"{idv}: the errata-section item at {x['file']}:{ln} differs from its source")
        for ln in have:
            if ln not in read_notes:
                fails.append(f"{idv}: a note at line {ln} is in the file but was not read for the entry")
        # merge notes
        for m, _label in merge_notes_for(idv, merges):
            got = blocks.get((idv, f"merge@{m['list']}-{m['item']}"))
            if got is None:
                fails.append(f"{idv}: the merge note of {m['list']} item {m['item']} is missing")
            elif ws(got) != ws(m["source_text"]):
                fails.append(f"{idv}: the merge note of {m['list']} item {m['item']} differs from its audit's lines {m['lines']}")
        have_m = {k[1] for k in blocks if k[0] == idv and k[1].startswith("merge@")}
        want_m = {f"merge@{m['list']}-{m['item']}" for m, _ in merge_notes_for(idv, merges)}
        if have_m != want_m:
            fails.append(f"{idv}: merge notes in the file {sorted(have_m)} differ from the lines that name it {sorted(want_m)}")
    # cautions
    for c in CAUTION_ITEMS:
        _ln, text = inventory_item(c)
        got = blocks.get((f"C{c}", "text"))
        if got is None or ws(got) != ws(text):
            fails.append(f"C{c}: the caution's text differs from inventory item {c}")
    # the order: nothing before what it rests on
    fails += order_violations(p["rows"][: len(order_ids)], {r["id"]: r for r in model["order"]})
    fails += comp_violations(p["rows"], model)
    # the superseded: no row for one
    for r in p["rows"]:
        if r["id"] in model["superseded"]:
            fails.append(f"{r['id']}: a superseded entry is listed for formalization")
        e = entries.get(r["id"])
        if e and e["file"] == FS129_FILE and re.match(r"none — superseded by ", e["handoff"]):
            fails.append(f"{r['id']}: its handoff says it is superseded, and it has a row")
    # counts: the file's own count line against the file's markers
    m = re.search(r"<!--count rows=(\d+) order=(\d+) comps=(\d+) left=(\d+) extras=(\d+) merge_notes=(\d+) notes=(\d+) cautions=(\d+)-->", md)
    if not m:
        fails.append("the count line is missing")
    else:
        rows_n = len(p["rows"])
        notes_n = sum(1 for k in blocks if k[1].startswith("note@"))
        mn = sum(1 for k in blocks if k[1].startswith("merge@"))
        if int(m.group(1)) != rows_n or int(m.group(7)) != notes_n or int(m.group(6)) != mn:
            fails.append(f"the count line ({m.group(1)} rows, {m.group(6)} merge notes, {m.group(7)} notes) differs from the file ({rows_n}, {mn}, {notes_n})")
        if nstat != rows_n:
            fails.append(f"{nstat} statement blocks checked for {rows_n} rows")
    return fails


def order_violations(rows: list[dict], order_by_id: dict[str, dict]) -> list[str]:
    fails = []
    pos = {r["id"]: i for i, r in enumerate(rows)}
    for r in rows:
        role = order_by_id.get(r["id"], {}).get("role", "")
        for d in (r["needs"] or []):
            if d not in pos:
                fails.append(f"{r['id']}: rests on {d}, which has no row in the order")
            elif pos[d] > pos[r["id"]] and not ("CYCLE" in role and "CYCLE" in order_by_id.get(d, {}).get("role", "")):
                fails.append(f"{r['id']}: placed before {d}, which it rests on")
    return fails


def comp_violations(rows: list[dict], model: dict) -> list[str]:
    fails = []
    comps = [r for r in rows if r["id"] in set(model["comps"])]
    pos = {r["id"]: i for i, r in enumerate(comps)}
    for r in comps:
        for d in (r["needs"] or []) + r.get("after", []):
            if d in pos and pos[d] > pos[r["id"]] and r["id"] not in model["comp_cycle"]:
                fails.append(f"{r['id']}: placed before {d}, which it rests on")
    return fails


def model_checks(model: dict, merges: list[dict]) -> list[str]:
    fails = []
    entries = model["entries"]
    z1 = 0
    for f in sorted(PLANS.glob("*-derivation.md")):
        z1 += sum(1 for l in f.read_text(encoding="utf-8").splitlines() if re.match(r"^\*Erratum \(2026-10-03, FS129-(Z1|SA1)", l))
    if z1 != EXPECT["z1_errata"]:
        fails.append(f"{z1} errata of FS129-Z1/SA1 found in the derivation files, item 136 says {EXPECT['z1_errata']}")
    fz, _, rg = UPSTREAM_MISSING_SRC.rpartition(":")
    a, b = (int(x) for x in rg.split("-"))
    um = "\n".join((ROOT / fz).read_text(encoding="utf-8").splitlines()[a - 1: b])
    for i in UPSTREAM_MISSING:
        if i not in entries:
            fails.append(f"{i} (SA1's upstream missing from the closure) is not an entry")
        elif not (i in um or i.split("-", 1)[1] in um):
            fails.append(f"{i} does not occur in {UPSTREAM_MISSING_SRC}")
    for idv in ERRATA_116:
        if not entries[idv]["notes"]:
            fails.append(f"{idv}: item 116 names it for its errata and none was found under it")
    a1, a2 = entries.get("FS129-OA1-FALC-RED"), entries.get("FS129-SA1-FALC-RED")
    if a1 and a2:
        CHECKS.append("FS129-OA1-FALC-RED (superseded) and FS129-SA1-FALC-RED have " + ("identical" if ws(a1["statement"]) == ws(a2["statement"]) else "DIFFERENT") +
                      " statements (SA1 § 6.3 item 6 names the OA1 statement with the SA1 argument; the backlog row is the SA1 entry)")
    shown = {r["id"] for r in model["order"]} | {a for a, _ in model["left"]}
    for idv in sorted(shown):
        e = entries[idv]
        if e["file"] != FS129_FILE and re.search(r"superseded", e["handoff"]):
            CHECKS.append(f"{idv} has a row (it is in the Lean order), and its handoff says: {e['handoff'][:160]}")
    for m in merges:
        if m["status"] == "applied":
            for x in m["x_ids_l"]:
                if x in model["superseded"]:
                    CHECKS.append(f"{m['list']} item {m['item']} names {x} to formalize, and `{FS129_FILE}` marks {x} superseded")
    return fails


CHECKS: list[str] = []
STALE: list[tuple[str, str, str]] = []
PROSE_ONLY: list[tuple[str, str]] = []
PROSE_CONFLICT: list[tuple[str, str]] = []
PROSE_MUTUAL: list[tuple[str, str]] = []


def run(write: bool) -> int:
    CHECKS.clear()
    STALE.clear()
    PROSE_ONLY.clear()
    PROSE_CONFLICT.clear()
    PROSE_MUTUAL.clear()
    entries, problems = load_entries()
    merges, mfails = load_merges(entries)
    model, fails = build_model(entries)
    fails = problems + mfails + fails + model_checks(model, merges)
    md, stats = write_md(model, merges)
    if write:
        OUT.write_text(md, encoding="utf-8")
        print(f"wrote {OUT.relative_to(ROOT)} ({len(md)} bytes, {stats['rows']} rows)")
    else:
        md = OUT.read_text(encoding="utf-8")
    fails += verify(md, model, merges, stats["extras"])
    if STALE:
        byfile: dict[str, list[int]] = {}
        for idv, was, now in STALE:
            f, _, a = now.rpartition(":")
            _, _, b = was.rpartition(":")
            byfile.setdefault(f, []).append(int(a) - int(b))
        CHECKS.append(f"{len(STALE)} order rows carry a stale address (the derivation files gained lines after the index was written); "
                      "the backlog uses the current lines: " + "; ".join(f"{f}: {len(v)} rows, shifts {min(v)}..{max(v)}" for f, v in sorted(byfile.items())))
    for y, x in PROSE_ONLY:
        CHECKS.append(f"the `Rests on it:` prose of {y} names {x}, but {x}'s `uses only:` does not reach {y}; the order puts {y} before {x} anyway")
    for y, x in PROSE_MUTUAL:
        CHECKS.append(f"the `Rests on it:` prose of {y} names {x} and that of {x} names {y}; neither `uses only:` reaches the other; no order constraint taken from either")
    for y, x in PROSE_CONFLICT:
        CHECKS.append(f"the `Rests on it:` prose of {y} names {x}, but {y}'s `uses only:` reaches {x} (the two disagree on the direction); the order follows `uses only:`")
    for c in CHECKS:
        print(f"CHECK: {c}")
    for f in fails:
        print(f"FAIL: {f}")
    print("stats:", {k: v for k, v in stats.items() if k not in ("extras", "no_row")})
    print("RESULT:", "PASS" if not fails else f"FAIL ({len(fails)})")
    return 0 if not fails else 1


# ------------------------------------------------------------------------------------------------ the self-test

def self_test() -> int:
    global MERGES
    entries, problems = load_entries()
    merges, mfails = load_merges(entries)
    model, fails = build_model(entries)
    fails = problems + mfails + fails + model_checks(model, merges)
    md, stats = write_md(model, merges)
    clean = fails + verify(md, model, merges, stats["extras"])
    ok = True
    print(f"clean run: {len(clean)} failures (must be 0); rows {stats['rows']}, notes {stats['notes']}, merge notes {stats['merge_notes']}")
    if clean or stats["rows"] < 200 or stats["notes"] < 20 or stats["merge_notes"] < 40:
        print("FAIL: the clean run is not clean, or counted too little to mean anything")
        for f in clean[:10]:
            print("   ", f)
        ok = False

    def expect(name: str, found: list[str], needle: str) -> None:
        nonlocal ok
        hit = [f for f in found if needle in f]
        print(f"plant {name}: {'caught' if hit else 'NOT CAUGHT'} ({len(found)} failures)" + (f" — {hit[0][:110]}" if hit else ""))
        if not hit:
            ok = False

    # 1. a statement altered by one character
    victim = "FS116-Y4-EMPTY"
    m = re.search(r"<!--q " + victim + r" statement-->\n\*\*[^\n]*\n> ([^\n]*)", md)
    line = m.group(1)
    k = line.index("a") if "a" in line else 0
    altered = line[:k] + ("b" if line[k] != "b" else "c") + line[k + 1:]
    md1 = md[: m.start(1)] + altered + md[m.end(1):]
    expect("statement altered by one character", verify(md1, model, merges, stats["extras"]), f"{victim}: the statement differs")
    # 2. an erratum dropped from its entry
    victim = "FS114-N7-3T"
    ln = [n["line"] for n in entries[victim]["notes"]][0]
    md2 = re.sub(r"<!--q " + victim + rf" note@{ln}-->\n(?:[^\n]*\n)(?:>[^\n]*\n)*", "", md, count=1)
    expect("erratum dropped from its entry", verify(md2, model, merges, stats["extras"]), f"{victim}: the erratum at")
    # 3. a superseded entry listed for formalization
    sup = sorted(model["superseded"])[0]
    md3 = md + f"\n### Cx. {sup}\n<!--row {sup} {entries[sup]['file']}:{entries[sup]['line']}-->\n"
    expect("superseded entry listed for formalization", verify(md3, model, merges, stats["extras"]), f"{sup}: a superseded entry is listed")
    # 4. a merge line naming an id that does not exist
    # re-run the validation on a planted csv
    tmp = L1 / "merges.selftest.csv"
    rows = list(csv.DictReader(MERGES.open(encoding="utf-8", newline="")))
    rows[0]["x_ids"] = rows[0]["x_ids"] + ";FS129-NO-SUCH-ENTRY"
    with tmp.open("w", encoding="utf-8", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=list(rows[0].keys()), lineterminator="\n")
        w.writeheader()
        w.writerows(rows)
    saved = MERGES
    MERGES = tmp
    try:
        _rows, pf = load_merges(entries)
    finally:
        MERGES = saved
        tmp.unlink()
    expect("merge line naming an id that does not exist", pf, "FS129-NO-SUCH-ENTRY")
    # 5. an entry placed before something it rests on
    rows5 = parse_md(md)["rows"][: len(model["order"])]
    by = {r["id"]: r for r in model["order"]}
    pick = next(r for r in rows5 if r["needs"] and "CYCLE" not in by[r["id"]]["role"] and "CYCLE" not in "".join(by.get(d, {}).get("role", "") for d in r["needs"]))
    d = pick["needs"][0]
    i, j = rows5.index(pick), next(k for k, r in enumerate(rows5) if r["id"] == d)
    rows5[i], rows5[j] = rows5[j], rows5[i]
    expect("entry placed before something it rests on", order_violations(rows5, by), f"{pick['id']}: placed before {d}")
    print("RESULT:", "PASS" if ok else "FAIL")
    return 0 if ok else 1


def coverage() -> int:
    """Every dated note (Erratum / Errata / Correction paragraph, Correction-owed banner) in the derivation files and where this file puts it."""
    entries, problems = load_entries()
    merges, _ = load_merges(entries)
    model, _ = build_model(entries)
    md, stats = write_md(model, merges)
    rows = {r["id"] for r in parse_md(md)["rows"]}
    placed: dict[tuple[str, int], list[str]] = {}
    for idv, e in entries.items():
        for n in e["notes"]:
            placed.setdefault((n["file"], n["line"]), []).append(idv)
    print("| note | begins | filed under | in this file |")
    print("|---|---|---|---|")
    tot = {"row": 0, "norow": 0, "none": 0}
    for f in sorted(PLANS.glob("*-derivation.md")):
        raw = f.read_text(encoding="utf-8").splitlines()
        rel = f"plans/{f.name}"
        for ln, ps in paragraphs(raw, 1, len(raw)):
            if NOTE_RE.match(ps[0]) or BANNER_RE.match(ps[0]):
                who = placed.get((rel, ln), [])
                ins = [i for i in who if i in rows]
                state = "yes, under " + ", ".join(ins) if ins else ("no — entry is not a row" if who else "no — no entry above it")
                tot["row" if ins else ("norow" if who else "none")] += 1
                print(f"| `{rel}:{ln}` | {ps[0][:60].replace('|', '/')} | {', '.join(who) or '—'} | {state} |")
    print(f"\nattached to a row: {tot['row']}; under an entry that is not a row: {tot['norow']}; no entry above: {tot['none']}")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--check", action="store_true")
    ap.add_argument("--fill-merges", action="store_true")
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--coverage", action="store_true")
    a = ap.parse_args()
    if a.coverage:
        return coverage()
    if a.fill_merges:
        return fill_merges()
    if a.self_test:
        return self_test()
    return run(write=not a.check)


if __name__ == "__main__":
    sys.exit(main())
