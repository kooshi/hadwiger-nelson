#!/usr/bin/env python3
"""EXT-OAI3 — the keyword sweep over the index (Python `re`, never grep -E: CLAUDE.md § Searching).

Reads index.jsonl and families.tsv (or, with --index FILE, another copy of index.jsonl: the planted-fault control).
For every pattern prints the families it hits, and where (F = family title or catalogue sentence, T = a manuscript title,
A = a catalogue abstract, P = the abstract pdftotext read). Case-insensitive; whitespace and hyphens are interchangeable.
"""
import json, re, sys, csv
from pathlib import Path
HERE = Path(__file__).resolve().parent
idx = HERE / "index.jsonl"
if "--index" in sys.argv: idx = Path(sys.argv[sys.argv.index("--index") + 1])
ms = [json.loads(l) for l in open(idx, encoding="utf-8")]
fams = {}
with open(HERE / "families.tsv", encoding="utf-8") as fh:
    for r in csv.DictReader(fh, delimiter="\t", quoting=csv.QUOTE_NONE):
        fams[r["family"]] = r

def W(s):  # a phrase: spaces match any run of whitespace or hyphens; e/é, o/ő folded by the patterns themselves
    return re.sub(r" ", r"[\\s\\-–]+", s)

GROUPS = {
 "A — the discipline's words (the brief's list)": [
    W("chromatic number of the plane"), r"Hadwiger", r"Nelson", W("unit distance"), W("unit distance graph"),
    W("distance avoiding"), W("measurable chromatic"), r"Falconer", r"de Grey", r"Moser", r"polychromatic",
    r"Erd[oő]s.{0,40}unit[\s\-]distance",
 ],
 "A — from the other side (the brief's list)": [
    r"colou?r\w*.{0,80}(plane|Euclid)", r"(plane|Euclid)\w*.{0,80}colou?r", W("distance graph"), W("forbidden distance"),
    r"densit\w+.{0,80}avoid", r"avoid\w*.{0,80}(distance|densit)",
 ],
 "A — widened by me: the same questions elsewhere": [
    r"chromatic", r"colou?ring", r"Ramsey", W("distance set"), W("distinct distance"), r"repeated[\s\-]distance", r"pinned",
    r"Borsuk", r"Kneser", r"independence (ratio|number|density)", r"independent set", W("sphere packing"), r"kissing",
    r"\bdistances?\b", r"isosceles|equilateral|congruent cop", r"Steinhaus", r"Lov[aá]sz", r"Hoffman",
 ],
 "B — what this project assumes or poses": [
    W("measure rigidity"), r"rigidity", r"Furstenberg", r"[×x]\s?2.{0,6}[×x]\s?3", r"invariant measure", r"Rajchman",
    r"Kloosterman", r"Weil", r"Bochner", r"Herglotz", r"positive[\s\-]definite", r"Tarski", r"real[\s\-]closed", r"semialgebraic|semi-algebraic",
    r"Einsiedler|Lindenstrauss|Katok|Rudolph", r"character group|Pontryagin|solenoid|adel", r"equidistribut", r"joining",
    r"Hedetniemi", r"fractional chromatic", r"Cayley graph", r"unit[\s\-]vector", r"finite (field|plane)", r"quadratic field|number field",
 ],
 "D — methods and neighbours": [
    r"tiling|tile\b|tessellat", r"Voronoi", r"planar (map|graph)", r"four[\s\-]colou?r", r"Kempe", r"Borel|measurable", r"descriptive",
    r"Lebesgue densit|finite perimeter|isoperimetr", r"incidence", r"Szemer[eé]di", r"Delsarte|linear programming bound|semidefinite",
    r"ergodic", r"Euclidean", r"lattice", r"graph", r"Lean",
 ],
}
only = None
if "--only" in sys.argv: only = sys.argv[sys.argv.index("--only") + 1]
for g, pats in GROUPS.items():
    if only and not g.startswith(only): continue
    print("=" * 110); print(g)
    for p in pats:
        rx = re.compile(p, re.I | re.S)
        hits = {}
        for f, r in fams.items():
            if rx.search(r["title"] + " " + r["description"]): hits.setdefault(f, set()).add("F")
        for m in ms:
            if rx.search(m["title"]): hits.setdefault(m["family"], set()).add("T")
            if rx.search(m["abstract"]): hits.setdefault(m["family"], set()).add("A")
            if rx.search(m.get("pdf_abstract", "")): hits.setdefault(m["family"], set()).add("P")
        s = " ".join(f"{f}[{''.join(sorted(hits[f]))}]" for f in sorted(hits))
        if len(hits) > 60: s = f"({len(hits)} families — too broad to list; read by eye instead)"
        print(f"  /{p}/  →  {len(hits)} families: {s}")
