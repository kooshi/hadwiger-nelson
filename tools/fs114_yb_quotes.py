#!/usr/bin/env python3
"""FS114-YB: the quotation check (standing rule 5).  Each row of a TSV file is `id <TAB> source <TAB> quotation`; the quotation must occur
verbatim in the source after one stated normalisation: typographic double and single quotes unified, Markdown backticks and bold markers
removed, runs of whitespace collapsed to one space.  A source `pdf:<path>:<first>-<last>` is read through `pdftotext` (plain mode and
`-layout` mode, because plain mode dehyphenates line-broken words).  Verdicts: FOUND, MISSING.  A row whose source cannot be read prints
UNREADABLE and the exit status is 2 (a check that could not run never reads as a pass).

Run: python3 tools/fs114_yb_quotes.py data/fs114/fs114-yb/quotes.tsv            (exit 0 iff every row FOUND)
     python3 tools/fs114_yb_quotes.py --self-test                              (an altered word must turn FOUND into MISSING)
"""
from __future__ import annotations
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def norm(s: str) -> str:
    s = s.replace("“", '"').replace("”", '"').replace("‘", "'").replace("’", "'")
    s = s.replace("`", "").replace("**", "")
    s = re.sub(r"\s+", " ", s)
    return s.strip()


def read_source(src: str) -> list[str]:
    if src.startswith("pdf:"):
        _, path, rng = src.split(":")
        a, b = rng.split("-")
        out = []
        for mode in ([], ["-layout"]):
            r = subprocess.run(["pdftotext", *mode, "-f", a, "-l", b, os.path.expanduser(path), "-"], capture_output=True, text=True)
            if r.returncode != 0:
                raise OSError(f"pdftotext failed on {path}")
            out.append(r.stdout)
        return out
    path = os.path.expanduser(src)
    if not os.path.isabs(path):
        path = os.path.join(ROOT, path)
    with open(path, encoding="utf-8") as f:
        return [f.read()]


def check_rows(rows):
    bad = 0
    unreadable = 0
    for rid, src, q in rows:
        try:
            texts = [norm(t) for t in read_source(src)]
        except OSError as e:
            print(f"{rid}\tUNREADABLE\t{src}\t{e}")
            unreadable += 1
            continue
        nq = norm(q)
        ok = any(nq in t for t in texts)
        print(f"{rid}\t{'FOUND' if ok else 'MISSING'}\t{src}")
        bad += (not ok)
    print(f"-- {len(rows) - bad - unreadable} of {len(rows)} FOUND; {bad} MISSING; {unreadable} UNREADABLE")
    return 2 if unreadable else (1 if bad else 0)


def load(path):
    rows = []
    with open(path, encoding="utf-8") as f:
        for line in f:
            line = line.rstrip("\n")
            if not line.strip() or line.startswith("#"):
                continue
            rid, src, q = line.split("\t", 2)
            rows.append((rid, src, q))
    return rows


def self_test(path):
    rows = load(path)
    rid, src, q = rows[0]
    words = q.split(" ")
    i = max(range(len(words)), key=lambda k: len(words[k]))
    altered = " ".join(words[:i] + [words[i] + "x"] + words[i + 1:])
    print("self-test: the first row as written, then with its longest word altered (must be FOUND, then MISSING)")
    a = check_rows([(rid, src, q)])
    b = check_rows([(rid + "-altered", src, altered)])
    ok = (a == 0 and b == 1)
    print(f"self-test {'PASSED' if ok else 'FAILED'}")
    return 0 if ok else 1


if __name__ == "__main__":
    if sys.argv[1:2] == ["--self-test"]:
        sys.exit(self_test(os.path.join(ROOT, "data/fs114/fs114-yb/quotes.tsv")))
    sys.exit(check_rows(load(sys.argv[1])))
