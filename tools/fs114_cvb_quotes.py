#!/usr/bin/env python3
"""FS114-CVB: the quotation check (standing rule 5).

Each row is (label, source path, quotation).  A quotation passes when it occurs in its source after whitespace is collapsed
(OCR line breaks and Markdown wrapping are not text); it fails otherwise.  The run prints FOUND or MISSING per row and exits 1 on any
MISSING, so a failure is louder than a pass.

Plant (`--plant`): the first row's quotation is mutated by one word ("distinct" -> "PLANTEDWORD", a token absent from every source);
the run must then report that row MISSING, and exit 1.  A plant that cannot fire tests nothing: the mutated word is checked to occur in the
faithful quotation before the mutation, and the planted token is checked to occur in no source, so the plant is known to change the
text and cannot be re-found elsewhere.  (First version mutated to "different", which [Thomassen1999] also prints two lines further on
("x and its neighbors must have different colors"): the plant could not fire.  Recorded in the stage-1 record.)

Usage: python3 tools/fs114_cvb_quotes.py --file data/fs114/fs114-cvb/quotes-stage1.tsv [--plant]
The TSV has three tab-separated columns: label, source path (relative to the repository root, or absolute), quotation.
"""
from __future__ import annotations

import os
import re
import sys


def norm(s: str) -> str:
    return re.sub(r"\s+", " ", s).strip()


def load(path: str):
    rows = []
    with open(path, encoding="utf-8") as fh:
        for ln, line in enumerate(fh, 1):
            line = line.rstrip("\n")
            if not line.strip() or line.startswith("#"):
                continue
            parts = line.split("\t")
            if len(parts) != 3:
                raise SystemExit(f"{path}:{ln}: expected 3 tab-separated columns, got {len(parts)}")
            rows.append(tuple(parts))
    return rows


def main(argv):
    if "--file" not in argv:
        raise SystemExit(__doc__)
    tsv = argv[argv.index("--file") + 1]
    plant = "--plant" in argv
    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    rows = load(tsv)
    if plant:
        lab, src, qt = rows[0]
        if "distinct" not in qt:
            raise SystemExit("PLANT CANNOT FIRE: the first quotation lacks the word the plant mutates")
        rows[0] = (lab, src, qt.replace("distinct", "PLANTEDWORD", 1))
    cache = {}
    missing = 0
    for lab, src, qt in rows:
        p = src if os.path.isabs(src) else os.path.join(root, src)
        p = os.path.expanduser(p)
        if p not in cache:
            with open(p, encoding="utf-8", errors="replace") as fh:
                cache[p] = norm(fh.read())
        ok = norm(qt) in cache[p]
        missing += not ok
        print(f"{'FOUND  ' if ok else 'MISSING'}  {lab}  [{src}]")
    if plant and any("PLANTEDWORD" in t for t in cache.values()):
        raise SystemExit("PLANT CANNOT FIRE: the planted token occurs in a source")
    print(f"rows={len(rows)} found={len(rows) - missing} missing={missing}" + ("  (PLANT RUN)" if plant else ""))
    return 1 if missing else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
