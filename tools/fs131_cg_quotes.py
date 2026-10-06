#!/usr/bin/env python3
"""FS131-CG1's readback (standing rule 3): every quotation in the brief, checked verbatim against its source.

Each quotation is read from the brief itself (the `> ` line before its `> — source:` line), so a mistyped copy here cannot
hide a mismatch. A quotation's source is the file the brief names, read at the commit the brief names where it names one
(`BendCollar.lean` at `b2ccfb7b`; KP2's plan on `fs131-w5` at `b2ccfb7b`; `CLAUDE.md` and the inventory on `main`).
Exit 0 iff every quotation is found verbatim. `--self-test` plants one changed character in each quotation in turn and
requires every plant to fail, and a quotation pointed at the wrong source to fail.
"""
import subprocess
import sys

MAIN = "/home/kooshi/source/lean-dir"
TREE = MAIN + "/.claude/worktrees/fs131-w5"
BRIEF = MAIN + "/data/fs131/briefs/FS131-CG1-collar.md"
BASE = "b2ccfb7b"
EXPECTED = 10


def git_show(repo, rev, path):
    return subprocess.run(["git", "-C", repo, "show", f"{rev}:{path}"], check=True, capture_output=True,
                          text=True).stdout


def sources():
    """Map a brief's source string to the text it names."""
    return {
        "CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)":
            git_show(MAIN, "main", "CLAUDE.md"),
        TREE + "/Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean":
            git_show(TREE, BASE, "Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean"),
        TREE + "/plans/FS131-collar-kernel-plan.md 5.2 The handoff (two implementers, split by file)":
            git_show(TREE, BASE, "plans/FS131-collar-kernel-plan.md"),
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
    if len(quotes) != EXPECTED:
        print(f"FAIL: expected {EXPECTED} quotations in the brief, read {len(quotes)}")
        return 1
    if "--self-test" in sys.argv:
        fired = 0
        plants = 0
        for j, (q, s) in enumerate(quotes):
            planted = q[:-3] + ("X" if q[-3] != "X" else "Y") + q[-2:]
            mod = list(quotes)
            mod[j] = (planted, s)
            plants += 1
            if check(mod, src):
                fired += 1
            else:
                print(f"PLANT {j} DID NOT FIRE: {s}")
        # a quotation pointed at a source that does not hold it
        plants += 1
        q0, _ = quotes[0]
        if check([(q0, "plans/FS131-close-inventory.md")], src):
            fired += 1
        else:
            print("PLANT wrong-source DID NOT FIRE")
        # the partner: the unplanted set passes
        partner = not check(quotes, src)
        print(f"self-test: {fired} of {plants} plants fired; unplanted partner {'PASS' if partner else 'FAIL'}")
        return 0 if fired == plants and partner else 1
    bad = check(quotes, src)
    for kind, s, q in bad:
        print(f"MISMATCH ({kind}) [{s}]: {q}")
    for q, s in quotes:
        print(f"ok  [{s[:60]}…]  {q[:70]}…")
    print("PASS" if not bad else f"FAIL: {len(bad)} quotation(s)")
    return 0 if not bad else 1


if __name__ == "__main__":
    sys.exit(main())
