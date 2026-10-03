#!/usr/bin/env python3
"""FS-129 stage 0 (job FS129-IX1) — the index of every derived theorem and the dependency map between them.

Mechanical: every field is read from a file by this script; a field it cannot read is left empty and listed under CHECK,
never filled by guess. No mathematics, no judgement.

    python3 tools/fs129_index.py              # build data/fs129/index/ (exit 1 on a duplicate id, a census failure, or an id-set mismatch)
    python3 tools/fs129_index.py --self-test  # plant faults in memory; each must fire, once, for its own reason
    python3 tools/fs129_index.py --out DIR    # write elsewhere

Inputs: plans/*-derivation.md (both grammars, read through tools/fs71_ledger_b_check.py, imported, never copied; the new
grammar through the Ephodos gate's own parser, which that module imports), LEDGER.md (§ A rows, § B rows),
.claude/skills/grokkings/SKILL.md (entry headers G1…).

The rules this script fixes (the README restates them):
  id resolution of a token found in `uses only:` or a "Rests on it" paragraph, tiers in order, first hit wins:
    1. the token is exactly an entry id (ids are corpus-wide unique; a duplicate is a failure of the run);
    2. `<prefix>-<token>` is an entry id, prefix being the stem of the file the text sits in (a bare `T3`, `V5-RING`);
    3. nothing else. A token that would match exactly one id as a suffix (`C-HULL` for `FS111-C-HULL`) is NOT resolved: it is
       listed as a suffix candidate, because choosing it would be a guess.
  edges: Y -> X when X's `uses only:` names Y (source `uses`) or Y's "Rests on it" paragraph names X (source `rests`), `both` when both.
  era: the file prefix's number (M<n>; FS<n> with n <= 103 is A, n >= 104 is R); a prefix with no number is placed by § B's
  milestone column when that holds M<n> / FS-<n>; otherwise CHECK.
Standard library only, plus the census module.
"""
from __future__ import annotations

import argparse
import contextlib
import csv
import importlib.util
import io
import json
import re
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "tools"))
import fs71_ledger_b_check as census  # noqa: E402  (imported, never copied; never edited)

GROK_PATH = ROOT / ".claude" / "skills" / "grokkings" / "SKILL.md"
OUT_DIR = ROOT / "data" / "fs129" / "index"

MARK_RE = re.compile(r"\*(Proof|Proof verdict|Rests on it|Prior art|Kernel):\*")
RESTS_LABEL = re.compile(r"\brests\s+on\s+it\b", re.I)
RESTS_PHRASE = re.compile(r"\brests\s+on\b", re.I)
TOKEN_RE = re.compile(r"(?<![A-Za-z0-9_./-])[A-Za-z0-9][A-Za-z0-9_]*(?:[-.][A-Za-z0-9_]+)*(?![/])")
FILE_EXT = re.compile(r"\.(md|py|lean|jsonl|csv|json|txt|sh|toml|tex|pdf|log)$", re.I)
PREFIXED = re.compile(r"^(?:FS|M)\d+[A-Z]?\d*[A-Za-z0-9]*-")
MILESTONE_PTR = re.compile(r"^(?:FS|M)-?\d+[A-Z]?\d*$")
HYPHEN_UPPER = re.compile(r"^[A-Z][A-Za-z0-9_]*-")
BARE_SHAPED = re.compile(r"^[A-Z]{1,3}\d+[a-z]?$")
GROK_HEAD = re.compile(r"^\* \*\*G(\d+) — (.*?)\*\*\s*$")
GROK_REF = re.compile(r"\bG(\d{1,3})\b")
ROW_REF = re.compile(r"\brows?\s+(\d{1,3}(?:\s*[–,-]\s*\d{1,3})*)", re.I)
DEBRUIJN = re.compile(r"de ?bruijn", re.I)
MD_HEAD = re.compile(r"^#{1,6}\s")
TRUNC = 400


def ws(s: str) -> str:
    return re.sub(r"\s+", " ", s or "").strip()


def trunc(s: str, n: int = TRUNC) -> str:
    return s if len(s) <= n else s[: n - 1] + "…"


# ------------------------------------------------------------------ era

def era_of(prefix: str, milestone: str) -> tuple[str, str]:
    """(era, how). A numbered prefix is placed by its number; any other by § B's milestone column; else CHECK."""
    m = re.fullmatch(r"M(\d+)[A-Z]?\d*", prefix)
    if m:
        return "A", f"prefix {prefix}"
    m = re.fullmatch(r"FS(\d+)", prefix)
    if m:
        return ("A" if int(m.group(1)) <= 103 else "R"), f"prefix {prefix}"
    ms = [(a, b) for a, b in re.findall(r"\b(M|FS-?)(\d+)", milestone)]
    eras = {("A" if a == "M" or int(b) <= 103 else "R") for a, b in ms}
    if len(eras) == 1:
        return eras.pop(), f"§ B milestone column `{milestone}`"
    return "CHECK", f"prefix `{prefix}` carries no milestone number and § B's milestone column reads `{milestone}`"


# ------------------------------------------------------------------ reading one file, both grammars

def read_derivation_file(text: str, prefix: str, fname: str) -> tuple[list[dict], list[str]]:
    """Entries of one file as raw records (no resolution yet), and the census's own printed lines (failures, notes)."""
    buf = io.StringIO()
    with contextlib.redirect_stdout(buf):
        cens, _fails = census.read_file(text, prefix, fname)
    printed = [x for x in buf.getvalue().splitlines() if x.strip()]
    out: list[dict] = []
    g = census.gate()
    lines, _fenced = g.strip_fences(text)
    # ---- the older grammar
    matches = list(census.ENTRY_RE.finditer(text))
    for i, m in enumerate(matches):
        full = census.full_id(m.group("id"), prefix)
        body_end = matches[i + 1].start() if i + 1 < len(matches) else len(text)
        body = text[m.end(): body_end].split("\n## ")[0]
        line = text.count("\n", 0, m.start()) + 1
        marks = list(MARK_RE.finditer(body))
        fields: dict[str, str] = {}
        for j, mk in enumerate(marks):
            if mk.group(1) in fields:
                continue
            end = marks[j + 1].start() if j + 1 < len(marks) else len(body)
            fields[mk.group(1)] = ws(body[mk.end(): end])
        stmt = ws(body[: marks[0].start()]) if marks else ""
        out.append({
            "id": full, "file": f"plans/{fname}", "line": line, "grammar": "old", "title": m.group("title"),
            "statement": stmt, "not_claimed": "", "grade": m.group("grade"), "minds": "", "verdict": fields.get("Proof verdict", ""),
            "uses_raw": "", "rests_text": fields.get("Rests on it", ""), "rests_form": "label" if "Rests on it" in fields else "",
            "handoff": "", "kernel": fields.get("Kernel", ""), "span_text": ws(m.group(0) + body), "prefix": prefix,
            "no_marker": not marks, "has_uses_field": False,
        })
    # ---- the new grammar (the gate's blocks)
    stops = [i for i, x in enumerate(lines) if MD_HEAD.match(x) or ((mm := g.HEAD.match(x)) and mm.group(1) == "derivation")]
    stops_any = [i for i, x in enumerate(lines) if MD_HEAD.match(x) or g.HEAD.match(x)]
    for b in g.blocks(lines, fname):
        if b["kind"] != "derivation":
            continue
        h = b["line"] - 1
        end = h + 1
        while end < len(lines) and lines[end].strip() and lines[end][0] in " \t":
            end += 1
        stop = next((i for i in stops if i > h), len(lines))
        stop_any = next((i for i in stops_any if i > h), len(lines))
        prose_lines = lines[end:stop]
        prose = "\n".join(prose_lines)
        mm = RESTS_LABEL.search(prose)
        form = "label"
        if not mm:
            mm = RESTS_PHRASE.search(prose)
            form = "phrase"
        rests_text, rests_form = "", ""
        if mm:
            para_end = prose.find("\n\n", mm.start())
            rests_text = ws(prose[mm.start(): para_end if para_end != -1 else len(prose)])
            rests_form = form
        f = b["fields"]
        span = "\n".join(lines[h:stop_any])
        out.append({
            "id": census.full_id(b["name"], prefix), "file": f"plans/{fname}", "line": b["line"], "grammar": "new",
            "title": "", "statement": ws(f.get("statement", "")), "not_claimed": ws(f.get("not claimed", "")),
            "grade": ws(f.get("grade", "")), "minds": ws(f.get("minds", "")), "verdict": ws(f.get("verdict", "")),
            "uses_raw": ws(f.get("uses only", "")), "rests_text": rests_text, "rests_form": rests_form,
            "handoff": ws(f.get("handoff", "")), "kernel": "", "span_text": ws(span + "\n" + prose), "prefix": prefix,
            "no_marker": False, "has_uses_field": "uses only" in f,
        })
    return out, printed


# ------------------------------------------------------------------ resolving ids

def tokens_of(text: str) -> list[str]:
    out = []
    for m in TOKEN_RE.finditer(text):
        t = m.group(0)
        if FILE_EXT.search(t):
            continue
        out.append(t)
    return out


def resolve(text: str, prefix: str, ids: set[str], suffix_index: dict[str, list[str]]) -> dict:
    """{resolved: [ids in order, unique], unresolved: [(token, class)], suffix: [(token, [candidate ids])]}."""
    resolved: list[str] = []
    unresolved: list[tuple[str, str]] = []
    suffix: list[tuple[str, list[str]]] = []
    seen_u: set[str] = set()
    for t in tokens_of(text):
        hit = None
        for cand in (t, f"{prefix}-{t}", t.split(".")[0] if "." in t else None):
            if cand and cand in ids:
                hit = cand
                break
        if hit is None and "." in t:
            q = f"{prefix}-{t.split('.')[0]}"
            if q in ids:
                hit = q
        if hit:
            if hit not in resolved:
                resolved.append(hit)
            continue
        if t in seen_u:
            continue
        if MILESTONE_PTR.match(t) or re.fullmatch(r"FS-\d+", t):
            cls = "milestone"
        elif PREFIXED.match(t):
            cls = "prefixed"
        elif "-" in t and HYPHEN_UPPER.match(t):
            cls = "hyphenated"
        elif BARE_SHAPED.match(t) and not re.fullmatch(r"G\d+", t):
            cls = "bare"
        else:
            continue
        seen_u.add(t)
        unresolved.append((t, cls))
        if cls in ("hyphenated", "bare") and t in suffix_index:
            suffix.append((t, suffix_index[t]))
    return {"resolved": resolved, "unresolved": unresolved, "suffix": suffix}


# ------------------------------------------------------------------ graph

def tarjan(nodes: list[str], adj: dict[str, set[str]]) -> list[list[str]]:
    index: dict[str, int] = {}
    low: dict[str, int] = {}
    on: set[str] = set()
    stack: list[str] = []
    comps: list[list[str]] = []
    counter = 0
    for root in nodes:
        if root in index:
            continue
        work = [(root, iter(sorted(adj.get(root, ()))))]
        index[root] = low[root] = counter
        counter += 1
        stack.append(root)
        on.add(root)
        while work:
            v, it = work[-1]
            adv = False
            for w in it:
                if w not in index:
                    index[w] = low[w] = counter
                    counter += 1
                    stack.append(w)
                    on.add(w)
                    work.append((w, iter(sorted(adj.get(w, ())))))
                    adv = True
                    break
                elif w in on:
                    low[v] = min(low[v], index[w])
            if adv:
                continue
            work.pop()
            if work:
                low[work[-1][0]] = min(low[work[-1][0]], low[v])
            if low[v] == index[v]:
                comp = []
                while True:
                    w = stack.pop()
                    on.discard(w)
                    comp.append(w)
                    if w == v:
                        break
                comps.append(sorted(comp))
    return comps


def descendants(adj: dict[str, set[str]], v: str) -> set[str]:
    seen: set[str] = set()
    todo = [v]
    while todo:
        x = todo.pop()
        for y in adj.get(x, ()):
            if y not in seen and y != v:
                seen.add(y)
                todo.append(y)
    return seen


# ------------------------------------------------------------------ the build

def parse_ledger(text: str) -> tuple[dict[int, tuple[int, str]], dict[str, tuple[int, str]]]:
    """({row number: (line, text)} from § A, {§ B id: (line, milestone)})."""
    rows: dict[int, tuple[int, str]] = {}
    brows: dict[str, tuple[int, str]] = {}
    section = None
    for n, line in enumerate(text.splitlines(), 1):
        if line.startswith("## A."):
            section = "A"
        elif line.startswith("## B."):
            section = "B"
        elif line.startswith("## ") or line.startswith("# "):
            section = None
        if section == "A":
            m = re.match(r"^\|\s*(\d+)\s*\|", line)
            if m:
                rows[int(m.group(1))] = (n, line)
        elif section == "B":
            m = census.ROW_RE.match(line)
            if m:
                cid = m.group("id").strip("` ")
                if cid and cid != "id" and not set(cid) <= {"-"}:
                    brows.setdefault(cid, (n, m.group("ms").strip()))
    return rows, brows


def parse_grokkings(text: str) -> dict[int, dict]:
    out: dict[int, dict] = {}
    cur = None
    lines = text.splitlines()
    for n, line in enumerate(lines, 1):
        m = GROK_HEAD.match(line)
        if m:
            cur = int(m.group(1))
            out[cur] = {"title": m.group(2), "line": n, "text": []}
        elif cur is not None and MD_HEAD.match(line):
            cur = None
        elif cur is not None:
            out[cur]["text"].append(line)
    for g in out.values():
        g["text"] = "\n".join(g["text"])
    return out


def build(files: dict[str, str], ledger_text: str, grok_text: str) -> dict:
    """The whole index, from file texts: {records, edges, defects, ...}. `files` maps `<prefix>-derivation.md` to its text."""
    raw: list[dict] = []
    census_lines: list[str] = []
    for fname in sorted(files):
        prefix = fname[: -len("-derivation.md")]
        recs, printed = read_derivation_file(files[fname], prefix, fname)
        raw.extend(recs)
        census_lines.extend(printed)
    defects: list[dict] = []
    for x in census_lines:
        if x.startswith("FAIL"):
            defects.append({"kind": "census-fail", "text": x})
    recs_by_id: dict[str, dict] = {}
    for r in raw:
        if r["id"] in recs_by_id:
            o = recs_by_id[r["id"]]
            defects.append({"kind": "duplicate-id", "id": r["id"], "addresses": [f"{o['file']}:{o['line']}", f"{r['file']}:{r['line']}"],
                            "text": f"id {r['id']} defined at {o['file']}:{o['line']} and {r['file']}:{r['line']}; the first is indexed, the second dropped"})
            continue
        recs_by_id[r["id"]] = r
    ids = set(recs_by_id)
    rows, brows = parse_ledger(ledger_text)
    groks = parse_grokkings(grok_text)
    suffix_index: dict[str, list[str]] = defaultdict(list)
    for i in sorted(ids):
        parts = i.split("-")
        for k in range(1, len(parts)):
            suffix_index["-".join(parts[k:])].append(i)

    # ---- per-record fields
    unresolved_all: list[dict] = []
    for i in sorted(recs_by_id):
        r = recs_by_id[i]
        check: list[str] = []
        ms = brows.get(i, (None, ""))[1]
        if i not in brows:
            check.append("no LEDGER.md § B row")
        r["milestone"] = ms
        r["ledger_b_line"] = brows.get(i, (None, ""))[0]
        r["era"], r["era_how"] = era_of(r["prefix"], ms)
        if r["era"] == "CHECK":
            check.append("era: " + r["era_how"])
        if r["grammar"] == "new" and not r["statement"]:
            check.append("no statement: field")
            defects.append({"kind": "no-statement", "id": i, "addresses": [f"{r['file']}:{r['line']}"],
                            "text": f"entry {i} ({r['file']}:{r['line']}) has no statement"})
        if r["grammar"] == "old" and r["no_marker"]:
            check.append("older entry has none of *Proof:*, *Proof verdict:*, *Rests on it:*, *Prior art:*, *Kernel:*; statement left empty")
        if r["grammar"] == "old" and not r["statement"] and not r["no_marker"]:
            check.append("older entry: no text between the header and *Proof:*; statement left empty")
        vm = re.match(r"[\"“'*_`(]*([A-Za-z][A-Za-z-]*)", r["verdict"])
        r["verdict_class"] = vm.group(1).lower() if vm else ""
        if not r["verdict"]:
            check.append("no verdict field")
        if r["handoff"] and DEBRUIJN.search(r["handoff"]) and re.match(r"none\b", r["handoff"], re.I):
            check.append("handoff begins `none` yet names de Bruijn in the field; indexed as a lean-order seed (the field, not the line, decides)")
        u = resolve(r["uses_raw"], r["prefix"], ids, suffix_index) if r["uses_raw"] else {"resolved": [], "unresolved": [], "suffix": []}
        rs = resolve(r["rests_text"], r["prefix"], ids, suffix_index) if r["rests_text"] else {"resolved": [], "unresolved": [], "suffix": []}
        r["uses_ids"] = [x for x in u["resolved"] if x != i]
        r["rests_ids"] = [x for x in rs["resolved"] if x != i]
        r["self_refs"] = [x for x in (u["resolved"] + rs["resolved"]) if x == i]
        for src, d in (("uses only", u), ("rests on it", rs)):
            for tok, cls in d["unresolved"]:
                unresolved_all.append({"from": i, "address": f"{r['file']}:{r['line']}", "where": src, "token": tok, "class": cls,
                                       "suffix": next((c for t, c in d["suffix"] if t == tok), [])})
        r["uses_rows"] = sorted({int(n) for m in ROW_REF.finditer(r["uses_raw"]) for n in re.findall(r"\d+", m.group(1)) if int(n) <= 400})
        r["uses_grokkings"] = sorted({int(n) for n in GROK_REF.findall(r["uses_raw"]) if int(n) in groks})
        r["mentions_grokkings"] = sorted({int(n) for n in GROK_REF.findall(r["span_text"]) if int(n) in groks})
        r["check"] = check
    # ---- ledger rows and grokkings citing each id
    cited_rows: dict[str, list[int]] = defaultdict(list)
    for n, (_, text) in rows.items():
        for t in {t for t in tokens_of(text) if t in ids}:
            cited_rows[t].append(n)
    cited_groks: dict[str, list[int]] = defaultdict(list)
    for n, g in groks.items():
        for t in {t for t in tokens_of(g["title"] + "\n" + g["text"]) if t in ids}:
            cited_groks[t].append(n)
    for i, r in recs_by_id.items():
        r["ledger_rows"] = sorted(cited_rows.get(i, []))
        r["grokkings"] = sorted(cited_groks.get(i, []))

    # ---- edges
    esrc: dict[tuple[str, str], set[str]] = defaultdict(set)
    for i, r in recs_by_id.items():
        for y in r["uses_ids"]:
            esrc[(y, i)].add("uses")
        for z in r["rests_ids"]:
            esrc[(i, z)].add("rests")
    edges = sorted((a, b, "both" if len(s) == 2 else next(iter(s))) for (a, b), s in esrc.items())
    adj: dict[str, set[str]] = defaultdict(set)
    radj: dict[str, set[str]] = defaultdict(set)
    for a, b, _ in edges:
        adj[a].add(b)
        radj[b].add(a)
    disagreements: list[dict] = []
    for a, b, s in edges:
        if s == "rests":
            X = recs_by_id[b]
            if X["has_uses_field"] and X["uses_raw"].strip() and a not in X["uses_ids"]:
                disagreements.append({"edge": (a, b), "kind": "rests-only",
                                      "note": f"{a}'s Rests-on-it names {b}; {b}'s `uses only:` exists and omits {a}"
                                              + ("" if X["uses_ids"] else " [and names no id at all]"),
                                      "addresses": [f"{recs_by_id[a]['file']}:{recs_by_id[a]['line']}", f"{X['file']}:{X['line']}"]})
        elif s == "uses":
            Y = recs_by_id[a]
            if Y["rests_text"].strip() and b not in Y["rests_ids"]:
                disagreements.append({"edge": (a, b), "kind": "uses-only",
                                      "note": f"{b}'s `uses only:` names {a}; {a}'s Rests-on-it paragraph exists and omits {b}"
                                              + ("" if Y["rests_ids"] else " [and names no id at all]"),
                                      "addresses": [f"{recs_by_id[b]['file']}:{recs_by_id[b]['line']}", f"{Y['file']}:{Y['line']}"]})
    nodes = sorted(ids)
    comps = tarjan(nodes, adj)
    cycles = [c for c in comps if len(c) > 1]
    for c in cycles:
        defects.append({"kind": "cycle", "members": c, "text": "dependency cycle: " + ", ".join(c)})
    for i, r in recs_by_id.items():
        d = descendants(adj, i)
        r["n_dependents_direct"] = len(adj.get(i, ()))
        r["n_dependents_transitive"] = len(d)
        r["n_upstream_direct"] = len(radj.get(i, ()))
    return {"records": recs_by_id, "edges": edges, "disagreements": disagreements, "unresolved": unresolved_all, "defects": defects,
            "cycles": cycles, "comps": comps, "adj": adj, "radj": radj, "groks": groks, "ledger_rows": rows, "census_lines": census_lines,
            "ids": ids}


# ------------------------------------------------------------------ lean order

def lean_order(ix: dict) -> dict:
    recs, radj = ix["records"], ix["radj"]
    seeds = sorted(i for i, r in recs.items() if r["handoff"] and DEBRUIJN.search(r["handoff"]))
    closure: set[str] = set(seeds)
    todo = list(seeds)
    while todo:
        x = todo.pop()
        for y in radj.get(x, ()):
            if y not in closure:
                closure.add(y)
                todo.append(y)
    # condense: order components, dependencies first
    comp_of = {m: k for k, c in enumerate(ix["comps"]) for m in c}
    cadj: dict[int, set[int]] = defaultdict(set)
    indeg: dict[int, int] = defaultdict(int)
    cnodes = sorted({comp_of[i] for i in closure})
    for i in closure:
        for y in radj.get(i, ()):
            if y in closure and comp_of[y] != comp_of[i]:
                if comp_of[i] not in cadj[comp_of[y]]:
                    cadj[comp_of[y]].add(comp_of[i])
                    indeg[comp_of[i]] += 1
    first = {k: ix["comps"][k][0] for k in cnodes}
    ready = sorted((k for k in cnodes if indeg[k] == 0), key=lambda k: first[k])
    order: list[int] = []
    import heapq
    h = [(first[k], k) for k in ready]
    heapq.heapify(h)
    while h:
        _, k = heapq.heappop(h)
        order.append(k)
        for n in sorted(cadj[k]):
            indeg[n] -= 1
            if indeg[n] == 0:
                heapq.heappush(h, (first[n], n))
    assert len(order) == len(cnodes), "lean-order: internal error, condensation not acyclic"
    seq: list[tuple[str, bool]] = []
    for k in order:
        c = [m for m in ix["comps"][k] if m in closure]
        for m in c:
            seq.append((m, len(ix["comps"][k]) > 1))
    return {"seeds": seeds, "closure": closure, "sequence": seq}


# ------------------------------------------------------------------ writers

def header(what: str, cmd: str, commit: str, comment: str = "#") -> str:
    return f"{comment} {what} | command: {cmd} | written at commit {commit}"


def git_commit() -> str:
    r = subprocess.run(["git", "rev-parse", "--short=10", "HEAD"], cwd=ROOT, capture_output=True, text=True)
    h = r.stdout.strip() if r.returncode == 0 else "unknown"
    d = subprocess.run(["git", "status", "--porcelain", "--", "plans", "LEDGER.md", ".claude/skills/grokkings/SKILL.md"],
                       cwd=ROOT, capture_output=True, text=True)
    dirty = [x for x in d.stdout.splitlines() if "-derivation.md" in x or "LEDGER.md" in x or "grokkings" in x]
    return h + (" (inputs modified in the working tree: " + "; ".join(x.strip() for x in dirty) + ")" if dirty else " (inputs clean)")


def scan_lines(files: dict[str, str], ledger_text: str, ix: dict) -> dict[str, list[tuple[str, str]]]:
    """Lines naming a stall or a GAP: {category: [(address, text)]}. Address file:line, with `in <id>` for a derivation line."""
    spans: dict[str, list[tuple[int, str]]] = defaultdict(list)
    for i, r in ix["records"].items():
        spans[r["file"]].append((r["line"], i))
    for v in spans.values():
        v.sort()
    out: dict[str, list[tuple[str, str]]] = {"stalls": [], "GAP": [], "gap": []}
    rowline = {ln: n for n, (ln, _) in ix["ledger_rows"].items()}

    def scan(path: str, text: str) -> None:
        for n, line in enumerate(text.splitlines(), 1):
            cats = []
            if re.search(r"stalls at", line, re.I):
                cats.append("stalls")
            if re.search(r"\bGAPs?\b", line):
                cats.append("GAP")
            elif re.search(r"\bgaps?\b", line, re.I):
                cats.append("gap")
            if not cats:
                continue
            addr = f"{path}:{n}"
            if path.startswith("plans/"):
                inside = [i for ln, i in spans.get(path, []) if ln <= n]
                if inside:
                    addr += f" (after entry {inside[-1]})"
            elif n in rowline:
                addr += f" (row {rowline[n]})"
            for c in cats:
                out[c].append((addr, line.strip()))

    for fname in sorted(files):
        scan(f"plans/{fname}", files[fname])
    scan("LEDGER.md", ledger_text)
    return out


def write_all(ix: dict, files: dict[str, str], ledger_text: str, out: Path, cmd: str, commit: str) -> dict:
    out.mkdir(parents=True, exist_ok=True)
    recs = ix["records"]
    stats: dict = {}
    # theorems.jsonl
    fields = ["id", "milestone", "era", "era_how", "file", "line", "grammar", "title", "statement", "not_claimed", "grade", "minds", "verdict",
              "verdict_class", "uses_raw", "uses_ids", "uses_rows", "uses_grokkings", "rests_text", "rests_form", "rests_ids", "handoff", "kernel",
              "ledger_rows", "grokkings", "mentions_grokkings", "ledger_b_line", "n_dependents_direct", "n_dependents_transitive",
              "n_upstream_direct", "self_refs", "check"]
    with open(out / "theorems.jsonl", "w", encoding="utf-8") as f:
        f.write(json.dumps({"_header": header("one record per theorem (an entry in a plans/*-derivation.md file); consumers skip this line",
                                              cmd, commit, "")[1:].strip()}, ensure_ascii=False) + "\n")
        for i in sorted(recs):
            f.write(json.dumps({k: recs[i][k] for k in fields}, ensure_ascii=False) + "\n")
    # edges.csv
    with open(out / "edges.csv", "w", encoding="utf-8", newline="") as f:
        f.write(header("edge from a result to each result that uses it; source = uses (the user's `uses only:`) | rests (the used one's Rests-on-it) | both; "
                       "consumers skip lines starting #", cmd, commit) + "\n")
        w = csv.writer(f, lineterminator="\n")
        w.writerow(["from", "to", "source"])
        w.writerows(ix["edges"])
    srcs = defaultdict(int)
    for _, _, s in ix["edges"]:
        srcs[s] += 1
    stats["edges"] = dict(srcs)
    # disagreements.md
    D = ix["disagreements"]
    with open(out / "disagreements.md", "w", encoding="utf-8") as f:
        f.write(header("pairs the two directions of the record disagree on", cmd, commit, "<!--").replace("<!--", "<!--", 1) + " -->\n\n")
        f.write("# Disagreements between `uses only:` and \"Rests on it\"\n\n")
        for kind, title in (("rests-only", "A's Rests-on-it names B; B's `uses only:` exists and omits A"),
                            ("uses-only", "B's `uses only:` names A; A's Rests-on-it paragraph exists and omits B")):
            sub = [d for d in D if d["kind"] == kind]
            f.write(f"## {title} ({len(sub)})\n\n")
            for d in sub:
                f.write(f"- {d['note']} — {d['addresses'][0]}; {d['addresses'][1]}\n")
            f.write("\n")
    stats["disagreements"] = {k: sum(1 for d in D if d["kind"] == k) for k in ("rests-only", "uses-only")}
    stats["disagreements_noid"] = sum(1 for d in D if "[and names no id at all]" in d["note"])
    # unresolved.md
    U = ix["unresolved"]
    with open(out / "unresolved.md", "w", encoding="utf-8") as f:
        f.write(header("every id-shaped token in a `uses only:` line or a Rests-on-it paragraph that resolves to no entry", cmd, commit, "<!--") + " -->\n\n")
        f.write("# Unresolved references\n\nResolution rule: exact id, then `<this file's prefix>-<token>`; nothing else. "
                "Classes: `prefixed` = begins with a milestone/file prefix like FS111- (the likely dangling ones); `hyphenated` = other uppercase hyphenated names "
                "(claim names, constants, shorthand); `bare` = a short token like T3/R7 with no hyphen; `milestone` = a milestone pointer like FS-126. "
                "A `suffix candidate` is a unique-or-not entry whose id ends in `-<token>`; none is resolved, each is a guess left to the reader.\n\n")
        for cls in ("prefixed", "hyphenated", "bare", "milestone"):
            sub = [u for u in U if u["class"] == cls]
            f.write(f"## class `{cls}` ({len(sub)} references, {len({u['token'] for u in sub})} distinct tokens)\n\n")
            for u in sorted(sub, key=lambda u: (u["token"], u["from"])):
                cand = f" — suffix candidates: {', '.join(u['suffix'][:6])}{' …' if len(u['suffix']) > 6 else ''}" if u["suffix"] else ""
                f.write(f"- `{u['token']}` — in {u['where']} of {u['from']} ({u['address']}){cand}\n")
            f.write("\n")
    stats["unresolved"] = {c: sum(1 for u in U if u["class"] == c) for c in ("prefixed", "hyphenated", "bare", "milestone")}
    stats["unresolved_with_suffix_candidate"] = sum(1 for u in U if u["suffix"])
    # orphans.md
    orph = sorted(i for i in recs if not ix["adj"].get(i))
    with open(out / "orphans.md", "w", encoding="utf-8") as f:
        f.write(header("results nothing uses (no outgoing edge in edges.csv)", cmd, commit, "<!--") + " -->\n\n# Orphans\n\n")
        f.write("A result is listed when no `uses only:` line and no other result's Rests-on-it paragraph resolves to a use of it from here; "
                "an older-format result's dependents come only from other entries' text, so many older results are here by the format, not by their role.\n\n")
        for i in orph:
            r = recs[i]
            f.write(f"- {i} — {r['file']}:{r['line']} — {r['grammar']} — era {r['era']}\n")
    stats["orphans"] = len(orph)
    stats["orphans_new"] = sum(1 for i in orph if recs[i]["grammar"] == "new")
    # hubs.md
    hub = sorted(recs, key=lambda i: (-recs[i]["n_dependents_transitive"], -recs[i]["n_dependents_direct"], i))
    with open(out / "hubs.md", "w", encoding="utf-8") as f:
        f.write(header("results by count of dependents, top 100 (the rest are in theorems.jsonl)", cmd, commit, "<!--") + " -->\n\n# Hubs\n\n")
        f.write("| rank | id | direct | transitive | address | era |\n|---|---|---|---|---|---|\n")
        for k, i in enumerate(hub[:100], 1):
            r = recs[i]
            f.write(f"| {k} | {i} | {r['n_dependents_direct']} | {r['n_dependents_transitive']} | {r['file']}:{r['line']} | {r['era']} |\n")
    # cycles.md
    with open(out / "cycles.md", "w", encoding="utf-8") as f:
        f.write(header("dependency cycles (strongly connected components of size > 1 in edges.csv); never broken silently", cmd, commit, "<!--") + " -->\n\n# Cycles\n\n")
        if not ix["cycles"]:
            f.write("none.\n")
        for c in ix["cycles"]:
            f.write(f"- {len(c)} members: {', '.join(c)}\n")
    stats["cycles"] = len(ix["cycles"])
    stats["cycle_members"] = sum(len(c) for c in ix["cycles"])
    stats["self_refs"] = sum(1 for r in recs.values() if r["self_refs"])
    # open-steps.md
    lines = scan_lines(files, ledger_text, ix)
    opens = [i for i in sorted(recs) if recs[i]["verdict_class"] in ("gap", "stalls", "refuted")]
    with open(out / "open-steps.md", "w", encoding="utf-8") as f:
        f.write(header("open steps: entries by verdict, then every line naming a stall or a GAP", cmd, commit, "<!--") + " -->\n\n# Open steps\n\n")
        f.write(f"## 1. Entries whose verdict class (first word of the verdict field) is gap, stalls or refuted ({len(opens)})\n\n")
        for i in opens:
            r = recs[i]
            f.write(f"- {i} — {r['file']}:{r['line']} — {r['grammar']} — verdict: {r['verdict']}\n")
        f.write(f"\n## 2. Lines containing \"stalls at\", any case ({len(lines['stalls'])})\n\n")
        for a, t in lines["stalls"]:
            f.write(f"- {a}: {t}\n")
        f.write(f"\n## 3. Lines containing the word GAP in capitals ({len(lines['GAP'])})\n\n")
        for a, t in lines["GAP"]:
            f.write(f"- {a}: {t}\n")
        f.write(f"\n## 4. Lines containing the word gap in another case, no capital GAP on the line ({len(lines['gap'])})\n\n")
        for a, t in lines["gap"]:
            f.write(f"- {a}: {t}\n")
    stats["open_entries"] = len(opens)
    stats["open_lines"] = {k: len(v) for k, v in lines.items()}
    # grokking-uses.md
    G = ix["groks"]
    uses: dict[int, list[str]] = defaultdict(list)
    for i, r in recs.items():
        for n in r["mentions_grokkings"]:
            uses[n].append(i)
    with open(out / "grokking-uses.md", "w", encoding="utf-8") as f:
        f.write(header("for each grokking, the entries whose text mentions it (the token G<n>), their milestones, the era by majority", cmd, commit, "<!--") + " -->\n\n# Grokking uses\n\n")
        f.write("A mention is the token `G<n>` anywhere in an entry's text (its block, its argument line, its prose); it can be a different G "
                "(a graph named G1) — the reader checks. \"cited by grokking\" counts ledger-row and grokking texts that name the entry's id, from the other direction.\n\n")
        for n in sorted(G):
            ids_n = sorted(uses.get(n, []))
            era = defaultdict(int)
            for i in ids_n:
                if recs[i]["era"] in ("A", "R"):
                    era[recs[i]["era"]] += 1
            if not ids_n:
                maj = "none (no entry mentions it)"
            elif era["A"] == era["R"]:
                maj = "CHECK: tie (A=%d, R=%d)" % (era["A"], era["R"])
            else:
                maj = "A" if era["A"] > era["R"] else "R"
            f.write(f"## G{n} — {G[n]['title']}\n\n- SKILL.md line {G[n]['line']}; entries mentioning it: {len(ids_n)} (A={era['A']}, R={era['R']}); era by majority: {maj}\n")
            ms = sorted({recs[i]["prefix"] for i in ids_n})
            f.write(f"- milestones (file prefixes): {', '.join(ms) if ms else '—'}\n")
            f.write(f"- entries: {', '.join(ids_n) if ids_n else '—'}\n\n")
    stats["grok_unmentioned"] = sum(1 for n in G if not uses.get(n))
    stats["grok_ties"] = sum(1 for n in G if uses.get(n) and sum(1 for i in uses[n] if recs[i]['era'] == 'A') == sum(1 for i in uses[n] if recs[i]['era'] == 'R'))
    # lean-order.md
    lo = lean_order(ix)
    with open(out / "lean-order.md", "w", encoding="utf-8") as f:
        f.write(header("the results whose handoff names de Bruijn (SEED) and everything they rest on, each after what it uses", cmd, commit, "<!--") + " -->\n\n# Lean order\n\n")
        f.write(f"Seeds: {len(lo['seeds'])} entries whose `handoff:` matches /de ?bruijn/i. Closure: {len(lo['closure'])} entries (seeds plus every entry reaching a seed along edges.csv). "
                "Order: dependencies first; ties by id; a cycle's members are listed together and flagged CYCLE, in id order, not broken. "
                "`needs` lists the direct upstream ids inside the closure. Older-format results have `handoff` empty here, their `Kernel:` text is copied (cut at 120).\n\n")
        pos = {i: k for k, (i, _) in enumerate(lo["sequence"], 1)}
        f.write("| # | id | role | address | era | needs | kernel / handoff |\n|---|---|---|---|---|---|---|\n")
        for k, (i, cyc) in enumerate(lo["sequence"], 1):
            r = recs[i]
            needs = sorted(y for y in ix["radj"].get(i, ()) if y in lo["closure"])
            role = ("SEED" if i in lo["seeds"] else "upstream") + (" (handoff begins `none`)" if i in lo["seeds"] and re.match(r"none\b", r["handoff"], re.I) else "") + (" CYCLE" if cyc else "")
            tail = trunc(r["handoff"] or r["kernel"], 120).replace("|", "\\|")
            f.write(f"| {k} | {i} | {role} | {r['file']}:{r['line']} | {r['era']} | {', '.join(needs)} | {tail} |\n")
    stats["lean_seeds"] = len(lo["seeds"])
    stats["lean_closure"] = len(lo["closure"])
    stats["lean_cycle_members"] = sum(1 for _, c in lo["sequence"] if c)
    # statements-*.md
    for era in ("A", "R", "CHECK"):
        sel = sorted((i for i in recs if recs[i]["era"] == era), key=lambda i: (recs[i]["file"], recs[i]["line"]))
        with open(out / f"statements-{era}.md", "w", encoding="utf-8") as f:
            f.write(header(f"one line per theorem of era {era}: id, address, statement cut at {TRUNC} characters", cmd, commit, "<!--") + " -->\n\n")
            f.write(f"# Statements, era {era} ({len(sel)})\n\n")
            for i in sel:
                r = recs[i]
                s = r["statement"] if r["statement"] else ("[title only, statement empty] " + r["title"] if r["title"] else "[statement empty]")
                f.write(f"- {i} | {r['file']}:{r['line']} | {trunc(s)}\n")
    # checks.md
    with open(out / "checks.md", "w", encoding="utf-8") as f:
        f.write(header("every CHECK the script raised: fields it could not read, eras it could not place, defects", cmd, commit, "<!--") + " -->\n\n# CHECK lines\n\n")
        n = 0
        TO = "older entry: no text between the header and *Proof:*; statement left empty"
        to_ids = [i for i in sorted(recs) if TO in recs[i]["check"]]
        if to_ids:
            per = defaultdict(int)
            for i in to_ids:
                per[recs[i]["file"]] += 1
            f.write(f"CHECK: {len(to_ids)} older-format entries have no text between the header and `*Proof:*`, so `statement` is empty in the index "
                    f"(their statement, if any, is the header's title, kept in `title` and shown in statements-*.md); per file: "
                    + ", ".join(f"{k.split('/')[-1][:-14]}={v}" for k, v in sorted(per.items())) + ". Each record's own `check` list carries the line; the ids are in theorems.jsonl.\n")
            n += 1
        for i in sorted(recs):
            for c in recs[i]["check"]:
                if c == TO:
                    continue
                f.write(f"CHECK: {i} ({recs[i]['file']}:{recs[i]['line']}): {c}\n")
                n += 1
        for d in ix["defects"]:
            f.write(f"CHECK: defect `{d['kind']}`: {d['text']}\n")
            n += 1
        for x in ix["census_lines"]:
            if not x.startswith("FAIL"):
                f.write(f"census note: {x[:300]}\n")
        stats["checks"] = n
    # counts
    by_era: dict = defaultdict(int)
    by_gr: dict = defaultdict(int)
    by_verdict: dict = defaultdict(int)
    by_vc: dict = defaultdict(int)
    for r in recs.values():
        by_era[r["era"]] += 1
        by_gr[r["grammar"]] += 1
        by_verdict[(r["grammar"], r["verdict_class"])] += 1
    stats["theorems"] = len(recs)
    stats["by_era"] = dict(by_era)
    stats["by_grammar"] = dict(by_gr)
    stats["by_verdict"] = {f"{g}:{v}": n for (g, v), n in sorted(by_verdict.items())}
    stats["with_uses_ids"] = sum(1 for r in recs.values() if r["uses_ids"])
    stats["with_rests_text"] = sum(1 for r in recs.values() if r["rests_text"])
    stats["with_rests_ids"] = sum(1 for r in recs.values() if r["rests_ids"])
    stats["rests_text_no_id"] = sum(1 for r in recs.values() if r["rests_text"] and not r["rests_ids"])
    stats["no_ledger_row_cites"] = sum(1 for r in recs.values() if not r["ledger_rows"])
    stats["handoff_debruijn_new"] = len(lo["seeds"])
    stats["defects"] = defaultdict(int)
    for d in ix["defects"]:
        stats["defects"][d["kind"]] += 1
    stats["defects"] = dict(stats["defects"])
    return stats


# ------------------------------------------------------------------ the self-test

def _new(name: str, statement: str = "every planted integer n satisfies n + 0 = n", uses: str = "that 0 is the additive identity",
         handoff: str = "none — planted", rests: str = "nothing; it is planted.") -> str:
    st = f"  statement: {statement}\n" if statement else ""
    return (f"derivation: {name}\n{st}  uses only: {uses}\n  not claimed: that n · 0 = n\n  argument: § Argument\n  verdict: derived\n"
            f"  grade: hand\n  minds: 1\n  model: n = 3\n  prior art: known\n  handoff: {handoff}\n\nRests on it: {rests}\n\n")


_OLD = ("**FS97-T1 — The planted older theorem. [hand; the planter]**\nFor every planted integer n, n + 1 > n. *Proof:* add one. "
        "*Proof verdict:* closes (trivially). *Rests on it:* FS97-T2 only. *Prior art:* none. *Kernel:* declined.\n\n"
        "**FS97-T2 — A second older theorem. [hand]**\nFor every planted n, n + 2 > n. *Proof:* twice. *Proof verdict:* closes. "
        "*Rests on it:* nothing. *Prior art:* none. *Kernel:* declined.\n\n")
_LEDGER = ("# L\n\n## A. The ledger\n\n| # | Result | Where | When |\n|---|---|---|---|\n"
           "| 1 | planted row citing FS99-N0 and G2 | x | FS-99 |\n| 2 | a row citing nothing | x | FS-99 |\n\n"
           "## B. Theorems\n\n| id | milestone | the theorem | grade | proof | kernel |\n|---|---|---|---|---|---|\n")
_GROK = "# G\n\n* **G1 — A planted grokking. [reading]**\n  body naming FS99-N1 here.\n* **G2 — Another. [hand]**\n  body.\n"


def _planted(extra: dict[str, str] | None = None, ids: tuple[str, ...] = ()) -> tuple[dict[str, str], str]:
    base_ids = ("FS99-N0", "FS99-N1", "FS97-T1", "FS97-T2") + ids
    ledger = _LEDGER + "".join(f"| {i} | FS-99 | planted | hand | x | declined |\n" for i in base_ids)
    files = {
        "FS99-derivation.md": "# FS-99 planted\n\n" + _new("FS99-N0", handoff="de Bruijn — queued", rests="FS99-N1 (G1).")
        + _new("FS99-N1", uses="FS99-N0 (the identity)", rests="nothing.", handoff="de Bruijn — queued") + "## Argument\n\ntext\n",
        "FS97-derivation.md": "# FS-97 planted\n\n" + _OLD,
    }
    files.update(extra or {})
    return files, ledger


def self_test() -> int:
    ok = True

    def run(files, ledger):
        buf = io.StringIO()
        with contextlib.redirect_stdout(buf):
            return build(files, ledger, _GROK)

    def kinds(ix):
        c: dict[str, int] = defaultdict(int)
        for d in ix["defects"]:
            c[d["kind"]] += 1
        return dict(c)

    # --- the clean planted corpus, field by field
    files, ledger = _planted()
    ix = run(files, ledger)
    r = ix["records"]
    expect = {
        "FS99-N0": dict(grammar="new", era="A", statement="every planted integer n satisfies n + 0 = n", not_claimed="that n · 0 = n", grade="hand", minds="1",
                        verdict="derived", verdict_class="derived", uses_raw="that 0 is the additive identity", uses_ids=[], rests_ids=["FS99-N1"],
                        handoff="de Bruijn — queued", ledger_rows=[1], grokkings=[], mentions_grokkings=[1], milestone="FS-99", line=1 + 2),
        "FS99-N1": dict(grammar="new", uses_ids=["FS99-N0"], rests_ids=[], grokkings=[1], n_dependents_direct=0, ledger_rows=[]),
        "FS97-T1": dict(grammar="old", era="A", title="The planted older theorem", statement="For every planted integer n, n + 1 > n.", grade="hand; the planter",
                        verdict="closes (trivially).", verdict_class="closes", rests_ids=["FS97-T2"], kernel="declined.", line=1 + 2, minds="", uses_raw=""),
    }
    clean_ok = True
    for i, exp in expect.items():
        for k, v in exp.items():
            if r[i][k] != v:
                print(f"    {i}.{k}: got {r[i][k]!r}, expected {v!r}")
                clean_ok = False
    clean_ok = clean_ok and ("FS99-N0", "FS99-N1", "both") in ix["edges"] and ("FS97-T1", "FS97-T2", "rests") in ix["edges"] \
        and kinds(ix) == {} and ix["unresolved"] == []
    print(f"self-test: the clean planted corpus indexes field by field, edges both+rests, no defect, no unresolved: {clean_ok}")
    ok = ok and clean_ok
    lo = lean_order(ix)
    lo_ok = [i for i, _ in lo["sequence"]] == ["FS99-N0", "FS99-N1"] and lo["seeds"] == ["FS99-N0", "FS99-N1"]
    print(f"self-test: lean-order puts a used result before its user and takes the seeds from `handoff:`: {lo_ok}")
    ok = ok and lo_ok

    # --- plants, each alone
    def plant(name, extra, ids, want_kind, check=None):
        nonlocal ok
        f2, l2 = _planted(extra, ids)
        ix2 = run(f2, l2)
        k = kinds(ix2)
        try:
            extra_ok = check(ix2) if check else True
        except (IndexError, KeyError):
            extra_ok = False  # a plant that did not fire cannot show its details: report it as not fired, never crash
        fired = k.get(want_kind, 0) == 1 and set(k) == {want_kind} and extra_ok if want_kind != "unresolved" else \
            (len(ix2["unresolved"]) == 1 and k == {} and extra_ok)
        print(f"self-test: plant '{name}' fires once, for its own reason ({want_kind}): {fired} (defects {k}, unresolved {len(ix2['unresolved'])})")
        ok = ok and fired

    plant("an entry with no statement", {"FS96-derivation.md": "# p\n\n" + _new("FS96-N0", statement="")}, ("FS96-N0",), "no-statement",
          lambda ix2: ix2["records"]["FS96-N0"]["statement"] == "" and any("no statement" in c for c in ix2["records"]["FS96-N0"]["check"]))
    plant("a `uses only:` id that resolves to nothing", {"FS96-derivation.md": "# p\n\n" + _new("FS96-N0", uses="FS96-NOPE (nothing there)")},
          ("FS96-N0",), "unresolved",
          lambda ix2: ix2["unresolved"][0]["token"] == "FS96-NOPE" and ix2["unresolved"][0]["class"] == "prefixed")
    cyc = _new("FS96-A", uses="FS96-B", rests="nothing.") + _new("FS96-B", uses="FS96-A", rests="nothing.")
    plant("a dependency cycle", {"FS96-derivation.md": "# p\n\n" + cyc}, ("FS96-A", "FS96-B"), "cycle",
          lambda ix2: ix2["cycles"] == [["FS96-A", "FS96-B"]] and [x for x, c in lean_order(ix2)["sequence"] if c] == [] )
    dup = {"FS95-derivation.md": "# p\n\n" + _new("FS99-N0")}
    plant("an id defined in two files", dup, (), "duplicate-id",
          lambda ix2: ix2["defects"][0]["addresses"][0].startswith("plans/FS95") or ix2["defects"][0]["addresses"][1].startswith("plans/FS95"))
    plant("a header the census rejects (a parenthetical before the dash)",
          {"FS96-derivation.md": "# p\n\n**FS96-T1 (the planted one) — Planted. [hand; X]**\nA statement. *Proof:* p. *Proof verdict:* closes. *Rests on it:* n. *Prior art:* a. *Kernel:* k.\n\n"},
          (), "census-fail", lambda ix2: "parenthetical" in ix2["defects"][0]["text"])
    # a cycle among seeds is reported in lean-order, not broken
    f3, l3 = _planted({"FS96-derivation.md": "# p\n\n" + _new("FS96-A", uses="FS96-B", rests="nothing.", handoff="de Bruijn")
                       + _new("FS96-B", uses="FS96-A", rests="nothing.", handoff="de Bruijn")}, ("FS96-A", "FS96-B"))
    lo3 = lean_order(run(f3, l3))
    cyc_ok = [(i, c) for i, c in lo3["sequence"] if c] == [("FS96-A", True), ("FS96-B", True)]
    print(f"self-test: a cycle among handed-off results is listed in lean-order with its members, flagged: {cyc_ok}")
    ok = ok and cyc_ok
    # a disagreement: B's rests names C, C's uses-only omits B
    dis = _new("FS96-B", rests="FS96-C.") + _new("FS96-C", uses="that 0 is the additive identity", rests="nothing.")
    f4, l4 = _planted({"FS96-derivation.md": "# p\n\n" + dis}, ("FS96-B", "FS96-C"))
    ix4 = run(f4, l4)
    dis_ok = len(ix4["disagreements"]) == 1 and ix4["disagreements"][0]["kind"] == "rests-only" and ix4["disagreements"][0]["edge"] == ("FS96-B", "FS96-C")
    print(f"self-test: a pair the two directions disagree on lands in disagreements: {dis_ok}")
    ok = ok and dis_ok
    # an era the script cannot place goes to CHECK
    f5, l5 = _planted({"ZQ9-derivation.md": "# p\n\n" + _new("ZQ9-N0")}, ("ZQ9-N0",))
    l5 = l5.replace("| ZQ9-N0 | FS-99 |", "| ZQ9-N0 | row 9 |")
    ix5 = run(f5, l5)
    era_ok = ix5["records"]["ZQ9-N0"]["era"] == "CHECK" and ix5["records"]["FS99-N0"]["era"] == "A"
    print(f"self-test: a prefix with no milestone number is placed CHECK, FS99 is A: {era_ok}")
    ok = ok and era_ok
    # FS104 is R, FS103 is A
    f6, l6 = _planted({"FS104-derivation.md": "# p\n\n" + _new("FS104-N0"), "FS103-derivation.md": "# p\n\n" + _new("FS103-N0")}, ("FS104-N0", "FS103-N0"))
    ix6 = run(f6, l6)
    era2 = ix6["records"]["FS104-N0"]["era"] == "R" and ix6["records"]["FS103-N0"]["era"] == "A"
    print(f"self-test: the era boundary (FS103 A, FS104 R): {era2}")
    ok = ok and era2
    print("RESULT:", "PASS" if ok else "FAIL")
    return 0 if ok else 1


# ------------------------------------------------------------------ main

def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--out", default=str(OUT_DIR))
    a = ap.parse_args()
    if a.self_test:
        return self_test()
    files = {f.name: f.read_text(encoding="utf-8") for f in sorted((ROOT / "plans").glob("*-derivation.md"))}
    ledger_text = (ROOT / "LEDGER.md").read_text(encoding="utf-8")
    grok_text = GROK_PATH.read_text(encoding="utf-8")
    ix = build(files, ledger_text, grok_text)
    # the census's own id set must equal ours (fail loud)
    cens_entries, _rows, _ph, _hf = (lambda b: (b[0], b[1], b[2], b[3]))(_census_load())
    mismatch = sorted(set(cens_entries) ^ set(ix["records"]))
    for m in mismatch:
        print(f"FAIL: id {m} is in only one of the census and this index")
    cmd = "python3 tools/fs129_index.py" + ("" if a.out == str(OUT_DIR) else f" --out {a.out}")
    stats = write_all(ix, files, ledger_text, Path(a.out), cmd, git_commit())
    print(json.dumps(stats, ensure_ascii=False, indent=1, default=list))
    hard = [d for d in ix["defects"] if d["kind"] in ("duplicate-id", "census-fail")]
    for d in hard:
        print("FAIL:", d["text"])
    bad = bool(mismatch or hard)
    print("RESULT:", "FAIL" if bad else "PASS (index written; defects and CHECK lines are in checks.md)")
    return 1 if bad else 0


def _census_load():
    buf = io.StringIO()
    with contextlib.redirect_stdout(buf):
        return census.load()


if __name__ == "__main__":
    sys.exit(main())
