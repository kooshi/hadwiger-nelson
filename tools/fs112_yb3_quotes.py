#!/usr/bin/env python3
"""FS112-YB3 quotation check (standing rule 5).

Each quotation handed to this job (brief, instance file, standing rules) is searched verbatim in its
source after one normalisation: whitespace collapsed, typographic quotes and dashes mapped to ASCII,
backticks dropped, and (for PDF text layers) a line-final hyphen joined. A quotation is FOUND when the
normalised quotation is a substring of the normalised source; otherwise MISSING, with the longest
matching prefix printed so that a punctuation-only difference is visible.

Sources that are fenced for this job until its step 3 are listed with status FENCED and are not opened
unless --after-step3 is given.

--self-test: one quotation with one word altered must be MISSING, its faithful twin FOUND.
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
LIB = Path.home() / "source" / "library"


def norm(s: str) -> str:
    s = s.replace("’", "'").replace("‘", "'").replace("“", '"').replace("”", '"')
    s = s.replace("–", "-").replace("—", "-").replace("`", "")
    s = re.sub(r"-\s*\n\s*", "-", s)  # a hyphen at a line end keeps the hyphen, joins the lines
    s = re.sub(r"\s+", " ", s)
    return s.strip()


def pdf_text(path: Path, first: int, last: int) -> str:
    out = subprocess.run(["pdftotext", "-f", str(first), "-l", str(last), str(path), "-"],
                         check=True, capture_output=True, text=True).stdout
    return out


def source_text(src):
    kind = src[0]
    if kind == "file":
        return (ROOT / src[1]).read_text()
    if kind == "pdf":
        return pdf_text(src[1], src[2], src[3])
    raise ValueError(kind)


QUOTES = [
    # (id, where quoted, quotation, source, fenced?)
    ("AX-1", "brief step 2; claims §7",
     "The symmetric tiles have width 1/2, with the rounded boundary being a circular arc of radius 1 centered at the opposite "
     "corner of the tile. The tiles used in the top and bottom rows are determined by the distance 1 between the point of "
     "intersection of circular arcs and the opposite corner of a tile.",
     ("pdf", LIB / "pdf" / "axenovich-2014-chromatic-number-subsets-euclidean-plane.pdf", 8, 8), False),
    ("K-0", "standing rule 0",
     "From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. You are "
     "capable, and you will surprise yourself.", ("file", "CLAUDE.md"), False),
    ("K-3a", "standing rule 3",
     "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time",
     ("file", "CLAUDE.md"), False),
    ("K-3b", "standing rule 3", "search for a finite graph is out. It would be huge, not feasible.", ("file", "CLAUDE.md"), False),
    ("K-4", "standing rule 4",
     "A proven theorem about why its impossible is also valid. All novel knowledge is a success.", ("file", "CLAUDE.md"), False),
    ("K-10", "standing rule 10",
     "It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress.",
     ("file", "plans/CONSOLIDATION-2026-09-27.md"), False),
    ("C9", "used below (C-CHAIN-9, claims §3)",
     "No bi-infinite sequence `−1 < λ_k < υ_k < 1` with `λ_k ≤ f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`.",
     ("file", "plans/FS110-derivation.md"), False),
    ("C8", "used below (C-CHAIN-8, claims §3)",
     "At a vertex admitting no merge, ray merge or shave, a two-sector colour has exactly two horns `±a`, the vertex has degree 4, "
     "and the antipodes carry `P_cl(N) = {c, h, r}`, `P_cl(S′) = {c, g, r′}` with double sectors",
     ("file", "plans/FS110-derivation.md"), False),
    ("Y2-GAP", "instance (Y3-DISK-T* answers it)",
     "whether any recolouring near `Z^L_0` that keeps the arc lets `T*` be blue",
     ("file", "plans/FS112-Y-construction.md"), False),
    ("Y2-STRIPGAP", "instance (Y3-STRIPCUT answers it)",
     "freeing 4 needs `C_{−1}` and `C_2` cut along `ω(Q)`",
     ("file", "plans/FS112-Y-construction.md"), False),
]

# The nine Y3 claims quoted by the instance file; their source is fenced until step 3.
Y3_SOURCE = ("file", "plans/FS112-Y3-construction.md")


def y3_quotes():
    inst = (ROOT / "data/fs112/briefs/YB3-112-instance.md").read_text()
    out = []
    for m in re.finditer(r"- \*\*(Y3-[A-Z0-9*\-]+):\*\* \"(.*?)\"\n", inst, re.S):
        out.append((m.group(1), "instance file", m.group(2), Y3_SOURCE, True))
    return out


def longest_prefix(q, s):
    lo, hi = 0, len(q)
    while lo < hi:
        mid = (lo + hi + 1) // 2
        if q[:mid] in s:
            lo = mid
        else:
            hi = mid - 1
    return lo


def check(quotes, after_step3):
    found = missing = fenced = 0
    cache = {}
    for qid, where, q, src, is_fenced in quotes:
        if is_fenced and not after_step3:
            print(f"FENCED  {qid:12s} ({where}) source {src[1]} not opened before step 3")
            fenced += 1
            continue
        key = str(src)
        if key not in cache:
            cache[key] = norm(source_text(src))
        s = cache[key]
        nq = norm(q)
        if nq in s:
            print(f"FOUND   {qid:12s} ({where})")
            found += 1
        else:
            k = longest_prefix(nq, s)
            print(f"MISSING {qid:12s} ({where}); longest matching prefix {k}/{len(nq)} chars: ...{nq[max(0, k - 40):k]!r} | next {nq[k:k + 40]!r}")
            missing += 1
    print(f"found={found} missing={missing} fenced={fenced}")
    return missing


def self_test():
    faithful = QUOTES[0]
    altered = (faithful[0] + "-ALT", faithful[1], faithful[2].replace("opposite corner of the tile", "nearest corner of the tile"),
               faithful[3], False)
    print("self-test: faithful twin then one altered word")
    m = check([faithful, altered], False)
    if m != 1:
        print("SELF-TEST FAILED")
        return 1
    print("SELF-TEST PASSED (the altered quotation is MISSING, the faithful twin FOUND)")
    return 0


if __name__ == "__main__":
    if "--self-test" in sys.argv:
        sys.exit(self_test())
    after = "--after-step3" in sys.argv
    sys.exit(1 if check(QUOTES + y3_quotes(), after) else 0)
