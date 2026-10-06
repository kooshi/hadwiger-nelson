#!/usr/bin/env python3
"""FS131-MB1: the statement check — no statement or definition of the skeleton changed.

For `Plane/Models/Stuck.lean` and `Plane/Models/Bends.lean`, every declaration of the skeleton at the base
commit (the planner's tip, `fe9d6d32`) must occur verbatim in the working file: a theorem by its head (from
`theorem` through the first `:=`), a definition whole (through the blank line that ends it; a definition is
a statement). The other files of the tree must not differ from the base outside the paths the brief gives
this job.

Exit 0 iff every head is found once and no forbidden path differs. `--self-test` runs the check on a copy of
each file with one character of each head changed, in turn, and requires every one to be reported; and runs
the faithful check beside it, which must pass.
"""
import os, re, subprocess, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BASE = "fe9d6d32"
FILES = ["Proofs/HadwigerNelson/Plane/Models/Stuck.lean", "Proofs/HadwigerNelson/Plane/Models/Bends.lean"]
ALLOWED = [
    r"^Proofs/HadwigerNelson/Plane/Models/Stuck\.lean$",
    r"^Proofs/HadwigerNelson/Plane/Models/Bends\.lean$",
    r"^scripts/Axioms\.lean$",
    r"^plans/FS131-MB1-implementation\.md$",
    r"^tools/fs131_mb_[A-Za-z0-9_]*\.py$",
    r"^data/fs131/mb/",
    r"^data/fs131/reports/FS131-MB1\.md$",
]
DECL = re.compile(r"^(?:noncomputable )?(theorem|def) (\S+)")


def git(*args):
    return subprocess.run(["git", "-C", ROOT] + list(args), check=True, capture_output=True, text=True).stdout


def heads(text):
    """(name, kind, head) for each declaration: a theorem's head ends at its first `:=`, a definition's at the
    blank line after it."""
    lines = text.split("\n")
    out = []
    i = 0
    while i < len(lines):
        m = DECL.match(lines[i])
        if not m:
            i += 1
            continue
        kind, name = m.group(1), m.group(2)
        j = i
        block = []
        while j < len(lines) and lines[j].strip() != "":
            block.append(lines[j])
            j += 1
        body = "\n".join(block)
        if kind == "theorem":
            k = body.find(":=")
            if k < 0:
                raise SystemExit(f"no := in the block of {name}")
            body = body[: k + 2]
        out.append((name, kind, body))
        i = j
    return out


def check(mutate=None):
    """Returns (rows, missing). `mutate = (file, index)` changes one character of that head in the working text."""
    rows, missing = [], 0
    for f in FILES:
        base = git("show", f"{BASE}:{f}")
        with open(os.path.join(ROOT, f)) as fh:
            cur = fh.read()
        hs = heads(base)
        for idx, (name, kind, head) in enumerate(hs):
            text = cur
            if mutate == (f, idx):
                pos = text.find(head)
                if pos < 0:
                    raise SystemExit(f"self-test: {name} absent before the plant")
                # change the last character of the declaration's name, inside the head
                at = pos + head.index(name) + len(name) - 1
                text = text[:at] + ("X" if text[at] != "X" else "Y") + text[at + 1:]
            n = text.count(head)
            rows.append((f, name, kind, n))
            if n != 1:
                missing += 1
    return rows, missing


def forbidden():
    changed = [l for l in git("diff", "--name-only", BASE).split("\n") if l]
    untracked = [l for l in git("ls-files", "--others", "--exclude-standard").split("\n") if l]
    bad = [p for p in changed + untracked if not any(re.search(a, p) for a in ALLOWED)]
    return changed + untracked, bad


def main():
    if "--self-test" in sys.argv:
        rows0, miss0 = check()
        fired = total = 0
        for f in FILES:
            n = len(heads(git("show", f"{BASE}:{f}")))
            for idx in range(n):
                total += 1
                _, miss = check(mutate=(f, idx))
                fired += 1 if miss >= 1 else 0
        ok = miss0 == 0 and fired == total and total > 0
        print(f"self-test: {fired} of {total} planted head changes reported; faithful run {miss0} missing -> "
              f"{'OK' if ok else 'FAIL'}")
        sys.exit(0 if ok else 1)
    rows, missing = check()
    for f, name, kind, n in rows:
        print(f"{os.path.basename(f)}\t{kind}\t{name}\tcount={n}")
    paths, bad = forbidden()
    print(f"{len(rows)} skeleton declarations, {missing} not found verbatim once")
    print(f"{len(paths)} path(s) differ from {BASE} or are new; outside this job's paths: {len(bad)}")
    for p in bad:
        print(f"  FORBIDDEN PATH: {p}")
    sys.exit(1 if (missing or bad) else 0)


if __name__ == "__main__":
    main()
