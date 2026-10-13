#!/usr/bin/env python3
"""FS131-KN2 stage 1: the brief's quotations against their sources, and the claim list's three leaves against the map's X1 rows.

A quotation in the brief is a block `> ID: text` followed by `> — source: path § …`. Each is compared character for
character with the line `ID: text` of the claim list (or, for W2, searched verbatim in the request file). The three leaves
are compared with the second column of the map's § X1 table. `--control` plants a one-word change in every quotation and
must report DIFFERS for each; the exit status is 0 only when the run's verdicts are the expected ones.
"""
import re, sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
BRIEF = ROOT / "data/fs131/briefs/FS131-KN2-upper-half-plan.md"
CLAIMS = ROOT / "data/fs131/claims-NF1.md"
MAP = ROOT / "plans/FS131-KN1-number-field-kernel-map.md"
REQ = ROOT / "data/fs131/REQUEST-2026-10-13.md"
control = "--control" in sys.argv

def quotes(text):
    out = []
    for m in re.finditer(r"^> ([A-Z0-9-]+): (.*)\n> — source: (\S+)", text, re.M):
        out.append((m.group(1), m.group(2), m.group(3)))
    return out

brief = BRIEF.read_text()
claims = {}
for line in CLAIMS.read_text().splitlines():
    m = re.match(r"^(NF1-[A-Z0-9-]+): (.*)$", line)
    if m: claims[m.group(1)] = m.group(2)
req = REQ.read_text() if REQ.exists() else None
bad = 0; n = 0
for qid, text, src in quotes(brief):
    n += 1
    if control: text = text.replace(" the ", " a ", 1) if " the " in text else text + " x"
    if qid.startswith("NF1-"):
        ok = claims.get(qid) == text
    else:
        if req is None: print(f"{qid}: SOURCE ABSENT ({src})"); bad += 1; continue
        # the request file wraps lines; compare with whitespace runs collapsed
        norm = lambda s: re.sub(r"\s+", " ", s)
        ok = norm(text) in norm(req)
    print(f"{qid}: {'IDENTICAL' if ok else 'DIFFERS'} ({len(text)} characters; source {src})")
    bad += (not ok)
# the three leaves against the map's X1 rows
rows = {}
for line in MAP.read_text().splitlines():
    m = re.match(r"^\| `\[(S1a|S1b|S2)\]` \| (.*?) \| (.*?) \| (.*) \|$", line)
    if m: rows[m.group(1)] = (m.group(2), m.group(3))
for tag, cid, wid in (("S1a", "NF1-S1A", "NF1-WAIT-S1A"), ("S1b", "NF1-S1B", "NF1-WAIT-S1B"), ("S2", "NF1-S2", "NF1-WAIT-S2")):
    n += 2
    leaf, wait = rows.get(tag, (None, None))
    c, w = claims.get(cid), claims.get(wid)
    if control: c = (c or "") + " x"; w = (w or "") + " x"
    ok1, ok2 = leaf == c, wait == w
    print(f"map X1 [{tag}] leaf vs {cid}: {'IDENTICAL' if ok1 else 'DIFFERS'}; waiting rows vs {wid}: {'IDENTICAL' if ok2 else 'DIFFERS'}")
    bad += (not ok1) + (not ok2)
print(f"compared={n} differing={bad} mode={'control' if control else 'real'}")
sys.exit(0 if (bad == n if control else bad == 0) else 1)
