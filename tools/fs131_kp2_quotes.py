#!/usr/bin/env python3
"""FS131-KP2's readback (standing rule 3): every quotation in the brief, checked verbatim against its source.

Each quotation is read from the brief itself (the `> ` line before its `> — source:` line), so a mistyped copy here cannot
hide a mismatch. A quotation's source is the file the brief names, read at the commit the brief names where it names one
(the brief's leaf at `ae881022`; the inventory on `main`; the record on `fs131-w5`). Exit 0 iff every quotation is found
verbatim. `--self-test` plants one changed character in each quotation and requires every plant to fail.
"""
import subprocess
import sys

MAIN = "/home/kooshi/source/lean-dir"
TREE = MAIN + "/.claude/worktrees/fs131-w5"
BRIEF = MAIN + "/data/fs131/briefs/FS131-KP2-collar.md"


def git_show(repo, rev, path):
    return subprocess.run(["git", "-C", repo, "show", f"{rev}:{path}"], check=True, capture_output=True,
                          text=True).stdout


def sources():
    """Map a brief's source string to the text it names."""
    return {
        "CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)":
            git_show(MAIN, "main", "CLAUDE.md"),
        TREE + "/Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean":
            git_show(TREE, "ae881022", "Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean"),
        TREE + "/plans/FS131-I5-implementation.md 44.3 The construction's design (D1; for the construction leaves)":
            git_show(TREE, "ae881022", "plans/FS131-I5-implementation.md"),
        "plans/FS131-close-inventory.md": git_show(MAIN, "main", "plans/FS131-close-inventory.md"),
    }


def quotations():
    lines = open(BRIEF, encoding="utf-8").read().splitlines()
    out = []
    for i, line in enumerate(lines):
        if line.startswith("> — source: ") and i > 0 and lines[i - 1].startswith("> "):
            out.append((lines[i - 1][2:], line[len("> — source: "):]))
    return out


def check(quotes, src):
    bad = []
    for q, s in quotes:
        text = src.get(s)
        if text is None:
            bad.append(("no source", s, q))
        elif q not in text:
            bad.append(("not verbatim", s, q))
    return bad


def main():
    src = sources()
    quotes = quotations()
    if len(quotes) != 9:
        print(f"FAIL: expected 9 quotations in the brief, read {len(quotes)}")
        return 1
    if "--self-test" in sys.argv:
        fired = 0
        for j, (q, s) in enumerate(quotes):
            planted = q[:-3] + ("X" if q[-3] != "X" else "Y") + q[-2:]
            mod = list(quotes)
            mod[j] = (planted, s)
            if check(mod, src):
                fired += 1
            else:
                print(f"PLANT {j} DID NOT FIRE: {s}")
        print(f"self-test: {fired} of {len(quotes)} plants fired")
        return 0 if fired == len(quotes) else 1
    bad = check(quotes, src)
    for kind, s, q in bad:
        print(f"MISMATCH ({kind}) [{s}]: {q}")
    for q, s in quotes:
        print(f"ok  [{s[:60]}…]  {q[:70]}…")
    print("PASS" if not bad else f"FAIL: {len(bad)} quotation(s)")
    return 0 if not bad else 1


if __name__ == "__main__":
    sys.exit(main())
