#!/usr/bin/env python3
"""FS131-LN1: check every quotation of a brief against its source, verbatim.

A quotation is a run of `> ` lines closed by a `> — source: <path>` line.  Each quoted
line must occur, character for character, as a substring of one line of the source
file (a brief quotes the head of a long line, so a substring and not a whole line).

  tools/fs131_ln_quotes.py <brief.md>            exit 0 iff every quoted line is found
  tools/fs131_ln_quotes.py --self-test <brief>   plants one altered character in every
                                                 quotation in turn and requires each
                                                 plant to be reported, and requires the
                                                 unaltered brief to have >= 1 quotation
"""
import sys
from pathlib import Path

SRC = "> — source: "


def quotations(text):
    """[(source path, [(brief line number, quoted line)])]"""
    out, cur = [], []
    for n, line in enumerate(text.splitlines(), 1):
        if line.startswith(SRC):
            out.append((line[len(SRC):].strip(), cur))
            cur = []
        elif line.startswith("> "):
            cur.append((n, line[2:]))
        elif line.startswith(">"):
            cur.append((n, line[1:]))
        else:
            if cur:
                raise SystemExit(f"line {n}: a quotation with no source line: {cur[0][1][:60]!r}")
    if cur:
        raise SystemExit("the brief ends inside a quotation with no source line")
    return out


def check(text, root):
    """[(brief line, source, quoted line, source line number or None)]"""
    rows = []
    for src, lines in quotations(text):
        path = root / src
        if not path.is_file():
            raise SystemExit(f"source not found: {src}")
        body = path.read_text().splitlines()
        for n, q in lines:
            hit = next((i for i, s in enumerate(body, 1) if q.rstrip() and q.rstrip() in s), None)
            rows.append((n, src, q, hit))
    return rows


def main(argv):
    self_test = "--self-test" in argv
    args = [a for a in argv if not a.startswith("--")]
    if len(args) != 1:
        raise SystemExit(__doc__)
    brief = Path(args[0])
    root = Path(__file__).resolve().parent.parent
    text = brief.read_text()
    rows = check(text, root)
    if not rows:
        print("FAIL: the brief has no quotation — nothing was checked")
        return 1
    if self_test:
        lines = text.splitlines()
        fired = 0
        for n, src, q, hit in rows:
            if hit is None:
                print(f"SELF-TEST FAIL: the unaltered brief already mismatches at line {n}")
                return 1
            mutated = list(lines)
            body = mutated[n - 1]
            # alter the last character of the quoted line: it lies inside the quotation
            mutated[n - 1] = body[:-1] + ("X" if body[-1] != "X" else "Y")
            got = [r for r in check("\n".join(mutated) + "\n", root) if r[3] is None]
            if [r[0] for r in got] != [n]:
                print(f"SELF-TEST FAIL: the plant at brief line {n} was not reported alone: {got}")
                return 1
            fired += 1
        print(f"SELF-TEST OK: {fired} plants, one per quoted line, each reported alone at its line")
        return 0
    bad = 0
    for n, src, q, hit in rows:
        where = f"{src}:{hit}" if hit else "NOT FOUND"
        print(f"{'ok  ' if hit else 'MISS'} brief:{n:<4} -> {where:<60} {q[:70]!r}")
        bad += hit is None
    print(f"{len(rows)} quoted lines, {len(rows) - bad} found verbatim, {bad} missing")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
