#!/usr/bin/env python3
"""FS131-CC1's readback (standing rule 3): every quotation in the brief, checked verbatim against its source.

Each quotation is read from the brief itself (the `> ` line before its `> — source:` line), so a mistyped copy here cannot
hide a mismatch. A quotation's source is the file the brief names: KP2's plan on `fs131-w5` at `2736ab8c` (the commit this
branch was cut from, and the branch's head, both checked); `CLAUDE.md` and the inventory on `main`.
Exit 0 iff every quotation is found verbatim. `--self-test` plants one changed character in each quotation in turn and
requires every plant to fail, and a quotation pointed at the wrong source to fail; the unplanted set must pass.
"""
import subprocess
import sys

MAIN = "/home/kooshi/source/lean-dir"
W5 = MAIN + "/.claude/worktrees/fs131-w5"
BRIEF_PATH = "data/fs131/briefs/FS131-CC1-collar.md"
BASE = "2736ab8c"
EXPECTED = 9


def git_show(repo, rev, path):
    return subprocess.run(["git", "-C", repo, "show", f"{rev}:{path}"], check=True, capture_output=True,
                          text=True).stdout


def sources(rev_w5):
    """Map a brief's source string to the text it names."""
    return {
        "CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)":
            git_show(MAIN, "main", "CLAUDE.md"),
        W5 + "/plans/FS131-collar-kernel-plan.md 5.2 The handoff (two implementers, split by file)":
            git_show(W5, rev_w5, "plans/FS131-collar-kernel-plan.md"),
        "plans/FS131-close-inventory.md": git_show(MAIN, "main", "plans/FS131-close-inventory.md"),
    }


def quotations():
    lines = git_show(MAIN, "main", BRIEF_PATH).splitlines()
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
    quotes = quotations()
    if len(quotes) != EXPECTED:
        print(f"FAIL: expected {EXPECTED} quotations in the brief, read {len(quotes)}")
        return 1
    src = sources(BASE)
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
        plants += 1
        q0, _ = quotes[0]
        if check([(q0, "plans/FS131-close-inventory.md")], src):
            fired += 1
        else:
            print("PLANT wrong-source DID NOT FIRE")
        partner = not check(quotes, src)
        print(f"self-test: {fired} of {plants} plants fired; unplanted partner {'PASS' if partner else 'FAIL'}")
        return 0 if fired == plants and partner else 1
    bad = check(quotes, src)
    bad_head = check(quotes, sources("fs131-w5"))
    for kind, s, q in bad:
        print(f"MISMATCH at {BASE} ({kind}) [{s}]: {q}")
    for kind, s, q in bad_head:
        print(f"MISMATCH at fs131-w5's head ({kind}) [{s}]: {q}")
    for q, s in quotes:
        print(f"ok  [{s[:60]}…]  {q[:70]}…")
    ok = not bad and not bad_head
    print("PASS" if ok else f"FAIL: {len(bad)} at {BASE}, {len(bad_head)} at fs131-w5's head")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
