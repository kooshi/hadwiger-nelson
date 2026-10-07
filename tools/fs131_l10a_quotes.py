#!/usr/bin/env python3
"""FS131-L10A: the brief's quotations against their sources (standing rule 3).

Reads the brief, takes every `> quote` / `> — source: <where>` pair, and counts the
verbatim occurrences of the quote in the named file. A quote is MATCH when it occurs
exactly once, MULTI when more than once (reported, not a failure), MISSING at zero.

  tools/fs131_l10a_quotes.py <brief> <repo-root>
  tools/fs131_l10a_quotes.py --self-test <brief> <repo-root>

`<repo-root>` resolves the sources given by a repository-relative path (`CLAUDE.md`,
`plans/…`); absolute paths are read as given. Exit 0 iff no quote is MISSING and at
least one pair was read (a brief with no pair is a failure of the reader, not a pass).

--self-test plants two faults and watches each fire beside the faithful run: one
character of a quote changed (must read MISSING), and a source path that does not
exist (must read NO-SOURCE). It exits 0 iff the faithful run passes and both fire.
"""
import os
import re
import sys


def pairs(brief_text):
    out = []
    lines = brief_text.split("\n")
    i = 0
    while i < len(lines):
        ln = lines[i]
        if ln.startswith("> ") and not ln.startswith("> — source:"):
            if i + 1 < len(lines) and lines[i + 1].startswith("> — source:"):
                src = lines[i + 1][len("> — source:"):].strip()
                out.append((ln[2:], src))
                i += 2
                continue
        i += 1
    return out


def resolve(src, root):
    # "CLAUDE.md § The gate" -> CLAUDE.md ; an absolute path is taken whole
    path = src.split(" § ")[0].strip()
    if not os.path.isabs(path):
        path = os.path.join(root, path)
    return path


def check(pair_list, root):
    rows = []
    for quote, src in pair_list:
        path = resolve(src, root)
        if not os.path.isfile(path):
            rows.append(("NO-SOURCE", 0, quote, src))
            continue
        with open(path, encoding="utf-8") as f:
            n = f.read().count(quote)
        verdict = "MATCH" if n == 1 else ("MULTI" if n > 1 else "MISSING")
        rows.append((verdict, n, quote, src))
    return rows


def report(rows):
    bad = 0
    for verdict, n, quote, src in rows:
        print(f"{verdict:9s} n={n}  {quote[:70]!r}  <- {src}")
        if verdict in ("MISSING", "NO-SOURCE"):
            bad += 1
    print(f"pairs={len(rows)} match={sum(r[0] == 'MATCH' for r in rows)} "
          f"multi={sum(r[0] == 'MULTI' for r in rows)} bad={bad}")
    return bad


def main(argv):
    self_test = "--self-test" in argv
    args = [a for a in argv if a != "--self-test"]
    if len(args) != 2:
        print(__doc__)
        return 2
    brief, root = args
    with open(brief, encoding="utf-8") as f:
        ps = pairs(f.read())
    if not ps:
        print("FAIL: no quote/source pair read from the brief")
        return 1
    rows = check(ps, root)
    bad = report(rows)
    if not self_test:
        print("quotations: PASS" if bad == 0 else "quotations: FAIL")
        return 0 if bad == 0 else 1
    # plant 1: one character of the first quote changed
    q0, s0 = ps[0]
    mutated = q0[:-2] + ("X" if q0[-2] != "X" else "Y") + q0[-1]
    r1 = check([(mutated, s0)], root)
    fired1 = r1[0][0] == "MISSING"
    print(f"plant 1 (one character changed): {r1[0][0]} -> {'fired' if fired1 else 'DID NOT FIRE'}")
    # plant 2: a source that is not a file
    r2 = check([(q0, "no/such/file.md § nowhere")], root)
    fired2 = r2[0][0] == "NO-SOURCE"
    print(f"plant 2 (a source that does not exist): {r2[0][0]} -> {'fired' if fired2 else 'DID NOT FIRE'}")
    ok = bad == 0 and fired1 and fired2
    print("self-test: PASS" if ok else "self-test: FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
