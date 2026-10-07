#!/usr/bin/env python3
"""FS131-LT5 stage 3: read a list of Lean modules' docstrings for the words that say a hypothesis is assumed.

The assumptions step (`scripts/Assumptions.lean`) cannot tell a hand result or an open question written out
in a binder over a theorem's own variables from a condition on those variables; the landing that brings such
a hypothesis declares it on its own word. This tool is the reading aid for that word: for each module it
extracts every doc comment (`/-- … -/`, `/-! … -/`) with the declaration that follows it, and prints each one
that holds one of the words below, the matching words first. It decides nothing: every hit is read by hand,
and the reading is in `plans/FS131-LT5-landing.md`.

    tools/fs131_lt5_docwords.py <file.lean> [<file.lean> …]
    tools/fs131_lt5_docwords.py --self-test

`--self-test` plants a module with five doc comments and requires: a docstring holding a word is printed with
its declaration; one holding none is not; a word inside a `--` line comment is not a hit; a word split across
two lines of a docstring is a hit (the text is read with its line breaks folded); and a module doc is read.
"""
from __future__ import annotations

import re
import sys
import tempfile
from pathlib import Path

WORDS = [
    "named hypothes", "named classical", "outside the backlog", "external", "classical",
    "[hand", "[tools", "[cert", "not kernel", "not in the kernel", "kernel pending",
    "open question", "open problem", "open claim", "open statement", "named open", "design target",
    "proved nowhere", "not proved", "unproved", "conjectur", "believed", "assum", "given mr",
    "is the hypothesis", "as a hypothesis", "hypothesis here", "hypotheses here", "taken as",
]

DOC = re.compile(r"/-[-!](.*?)-/", re.S)


def fold(s: str) -> str:
    return re.sub(r"\s+", " ", s).strip()


def docs(text: str) -> list[tuple[int, str, str]]:
    """(line, folded doc text, the declaration line that follows) for every doc comment."""
    out = []
    for m in DOC.finditer(text):
        line = text.count("\n", 0, m.start()) + 1
        rest = text[m.end():].lstrip("\n")
        nxt = rest.split("\n", 1)[0].strip() if rest else ""
        kind = "module doc" if text[m.start():m.start() + 3] == "/-!" else nxt
        out.append((line, fold(m.group(1)), kind))
    return out


def hits(path: Path) -> list[tuple[int, list[str], str, str]]:
    found = []
    for line, doc, decl in docs(path.read_text(encoding="utf-8")):
        low = doc.lower()
        ws = [w for w in WORDS if w in low]
        if ws:
            found.append((line, ws, decl, doc))
    return found


def report(paths: list[Path]) -> int:
    total = 0
    for p in paths:
        n_docs = len(docs(p.read_text(encoding="utf-8")))
        hs = hits(p)
        total += len(hs)
        print(f"=== {p} — {n_docs} doc comment(s), {len(hs)} with a word")
        for line, ws, decl, doc in hs:
            print(f"  l.{line} {ws}")
            print(f"    decl: {decl[:160]}")
            print(f"    doc : {doc[:900]}")
    print(f"modules={len(paths)} hits={total}")
    return 0


def self_test() -> int:
    planted = '''/-!
# A module doc that says the open question is here.
-/

/-- An ordinary lemma about addition. -/
theorem plain (n : Nat) : n + 0 = n := rfl

-- a line comment that says [hand] and is not a docstring
/-- A lemma over a hand result, [hand], written out in a binder. -/
theorem flagged (n : Nat) (h : n = n) : n + 0 = n := rfl

/-- A lemma whose word is split: a named
hypothesis from elsewhere. -/
theorem split (n : Nat) : n = n := rfl

/-- Nothing to see. -/
def quiet : Nat := 0
'''
    with tempfile.TemporaryDirectory() as d:
        p = Path(d) / "Planted.lean"
        p.write_text(planted, encoding="utf-8")
        hs = hits(p)
    got = [(decl.split("(")[0].strip(), ws) for _, ws, decl, _ in hs]
    want = [
        ("module doc", ["open question"]),
        ("theorem flagged", ["[hand"]),
        ("theorem split", ["named hypothes"]),
    ]
    ok = got == want
    for g in got:
        print(f"  hit: {g}")
    print("self-test: " + ("OK — the three planted hits and no other (the plain lemma, the quiet definition and the line comment are silent)"
                           if ok else f"FAIL — wanted {want}"))
    return 0 if ok else 1


def main(argv: list[str]) -> int:
    if len(argv) == 2 and argv[1] == "--self-test":
        return self_test()
    if len(argv) < 2:
        print(__doc__)
        return 2
    return report([Path(a) for a in argv[1:]])


if __name__ == "__main__":
    sys.exit(main(sys.argv))
