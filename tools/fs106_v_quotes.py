#!/usr/bin/env python3
"""FS106-V stage 1: check every straight-quoted string in a claim list or brief against its sources.

Each quoted string ("...") is split at ellipses ("…" or ". . .") and every piece of at least 12 characters must occur,
after deleting all whitespace, in the concatenation of the source text layers (pdftotext -layout of the PDFs) and the
repository files named on the command line. A piece that does not occur is reported with the longest prefix that does,
so a garbled symbol is told apart from a changed word.

Usage: tools/fs106_v_quotes.py <quoted-file> [--src <pdf-or-text>]... [--plant]
--plant mutates one known-present quote (one word changed) and one known-absent (a sentence invented) and asserts the
tool reports the first as absent and still reports an untouched quote present: a plant that cannot fire tests nothing.
Exit 0 always on a completed run (the report is the result); exit 2 if the plant does not fire.
"""
import re
import subprocess
import sys
import unicodedata


def norm(s: str) -> str:
    s = unicodedata.normalize("NFKC", s)
    s = s.replace("­", "")  # soft hyphen
    return re.sub(r"\s+", "", s)


def load(path: str) -> str:
    if path.endswith(".pdf"):
        out = subprocess.run(["pdftotext", "-layout", path, "-"], capture_output=True, text=True, check=True)
        return out.stdout
    with open(path, encoding="utf-8") as f:
        return f.read()


def quotes(text: str):
    # straight double quotes, possibly across lines; skip backtick code spans' contents
    # pair straight quotes left to right (any length), then keep the long ones; a minimum length in the regex
    # itself shifts the pairing after a short quote such as "proper"
    for m in re.finditer(r'"([^"]*)"', text, flags=re.S):
        if len(norm(m.group(1))) < 12:
            continue
        line = text.count("\n", 0, m.start()) + 1
        yield line, m.group(1)


def pieces(q: str):
    for p in re.split(r"…|\. \. \.|\[[^\]]*garbled[^\]]*\]", q):
        p = p.strip()
        if len(norm(p)) >= 12:
            yield p


def longest_prefix(p: str, hay: str) -> int:
    n = norm(p)
    lo, hi = 0, len(n)
    while lo < hi:
        mid = (lo + hi + 1) // 2
        if n[:mid] in hay:
            lo = mid
        else:
            hi = mid - 1
    return lo


def check(qfile: str, srcs, extra_quotes=()):
    raw = [load(s) for s in srcs]
    # the haystack holds each source twice: as printed, and de-hyphenated at line ends ("multi-\ncolor")
    hay = "".join(norm(r) for r in raw) + "".join(norm(re.sub(r"(?<=[a-z])-\n\s*(?=[a-z])", "", r)) for r in raw)
    text = load(qfile)
    rows = []
    for line, q in list(quotes(text)) + list(extra_quotes):
        for p in pieces(q):
            ok = norm(p) in hay
            k = len(norm(p)) if ok else longest_prefix(p, hay)
            rows.append((line, ok, k, len(norm(p)), p))
    return rows


def main():
    args = sys.argv[1:]
    plant = "--plant" in args
    args = [a for a in args if a != "--plant"]
    qfile = args[0]
    srcs = [args[i + 1] for i, a in enumerate(args) if a == "--src"]
    rows = check(qfile, srcs)
    for line, ok, k, n, p in rows:
        tag = "OK  " if ok else f"MISS {k}/{n}"
        print(f"l.{line:4d} {tag} {p[:110]!r}")
    print(f"pieces={len(rows)} ok={sum(r[1] for r in rows)} miss={sum(not r[1] for r in rows)}")
    if plant:
        good = [r for r in rows if r[1]]
        if not good:
            print("PLANT: no present quote to mutate"); sys.exit(2)
        base = good[0][4]
        words = base.split()
        i = max(range(len(words)), key=lambda j: len(words[j]))
        mutated = " ".join(words[:i] + [words[i][::-1] + "x"] + words[i + 1:])
        r2 = check(qfile, srcs, extra_quotes=[(0, mutated), (0, "the plane is coloured by seven closed hexagons of unit width")])
        planted = [r for r in r2 if r[0] == 0]
        untouched = [r for r in r2 if r[0] == good[0][0] and r[4] == base]
        fired = all(not r[1] for r in planted) and len(planted) == 2 and untouched and untouched[0][1]
        print(f"PLANT mutated={mutated[:60]!r} fired={fired}")
        if not fired:
            sys.exit(2)


if __name__ == "__main__":
    main()
