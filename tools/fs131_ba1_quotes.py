#!/usr/bin/env python3
"""FS131-BA1: check each quotation of a brief verbatim against the file its `— source:` line names.
(A copy of FS131-KA1's `tools/fs131_ka_quotes.py` under this job's prefix: standing rule 7 bars editing another job's tool.)

A quotation is a run of `> ` lines followed by `> — source: <path> [rest]`. The path is resolved against the main tree
(`/home/kooshi/source/lean-dir`) unless absolute; `CLAUDE.md § …` resolves to the main tree's CLAUDE.md. Whitespace runs
(line breaks included) are folded to one space on both sides before the search.

  python3 tools/fs131_ba1_quotes.py <brief>            # exit 0 iff every quotation is found
  python3 tools/fs131_ba1_quotes.py <brief> --self-test # plants a one-letter change in the first quotation; must fail
"""
import re
import sys
from pathlib import Path

MAIN = Path("/home/kooshi/source/lean-dir")


def fold(s: str) -> str:
    return re.sub(r"\s+", " ", s).strip()


def quotations(text: str):
    out, cur = [], []
    for line in text.splitlines():
        if line.startswith("> — source:"):
            src = line[len("> — source:"):].strip()
            out.append((" ".join(cur), src))
            cur = []
        elif line.startswith("> "):
            cur.append(line[2:])
        else:
            cur = []
    return out


def resolve(src: str) -> Path:
    tok = src.split()[0]
    p = Path(tok)
    return p if p.is_absolute() else MAIN / p


def check(text: str) -> int:
    qs = quotations(text)
    if not qs:
        print("NO QUOTATIONS FOUND — the checker read nothing")
        return 2
    bad = 0
    for q, src in qs:
        path = resolve(src)
        if not path.exists():
            print(f"MISSING SOURCE {path}")
            bad += 1
            continue
        body = fold(path.read_text())
        ok = fold(q) in body
        print(f"{'verbatim' if ok else 'MISMATCH'}  {path.name}  «{q[:70]}»")
        bad += 0 if ok else 1
    print(f"{len(qs)} quotations, {bad} failures")
    return 1 if bad else 0


def main():
    brief = Path(sys.argv[1]).read_text()
    if "--self-test" in sys.argv:
        qs = quotations(brief)
        first = qs[0][0]
        i = next(j for j, ch in enumerate(first) if ch.isalpha())
        planted = first[:i] + ("x" if first[i] != "x" else "y") + first[i + 1:]
        rc = check(brief.replace(first[:40], planted[:40], 1))
        print("SELF-TEST:", "FIRED (good)" if rc != 0 else "DID NOT FIRE (bad)")
        sys.exit(0 if rc != 0 else 1)
    sys.exit(check(brief))


if __name__ == "__main__":
    main()
