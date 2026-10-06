#!/usr/bin/env python3
"""FS131-MB2: the statement check — no statement or definition changed, the skeleton's or FS131-MB1's.

For `Plane/Models/Stuck.lean` and `Plane/Models/Bends.lean`, every declaration at the base commit (FS131-MB1's
tip, `b7fbe6f9`: the planner's skeleton with MB1's proofs and helpers) must occur verbatim in the working
file: a theorem by its head (from `theorem` through the first `:=`), a definition whole (through the blank
line that ends it; a definition is a statement). The skeleton's own declarations (the planner's tip,
`fe9d6d32`) are checked the same way, so the two bases cannot drift apart unseen. The other files of the tree
must not differ from the base outside the paths the brief gives this job — except, since the coordinator's
mid-job direction to merge the other half (`origin/fs131-wm` at `87699974`, FS131-MA1), the paths that merge
brought: each of those must be byte-identical to its content at `87699974` (this job edits none of them).

Exit 0 iff every head is found once and no forbidden path differs. `--self-test` runs the check on a copy of
each file with one character of each head changed, in turn, and requires every one to be reported; and runs
the faithful check beside it, which must pass.
"""
import os, re, subprocess, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BASE = "b7fbe6f9"
SKELETON = "fe9d6d32"
MERGED = "87699974"
FILES = ["Proofs/HadwigerNelson/Plane/Models/Stuck.lean", "Proofs/HadwigerNelson/Plane/Models/Bends.lean"]
ALLOWED = [
    r"^Proofs/HadwigerNelson/Plane/Models/Stuck\.lean$",
    r"^Proofs/HadwigerNelson/Plane/Models/Bends\.lean$",
    r"^scripts/Axioms\.lean$",
    r"^plans/FS131-MB1-implementation\.md$",
    r"^tools/fs131_mb2_[A-Za-z0-9_]*\.py$",
    r"^data/fs131/mb2/",
    r"^data/fs131/reports/FS131-MB2\.md$",
    # one file of the other half's data, edited at the coordinator's direction (2026-10-06): its receipt's control 1 — two lines
    # expecting `stuckModel_hyps` and `awayModel_hyps` on `sorryAx` — dropped when both read the standard three (Stage 8)
    r"^data/fs131/ma/MAAxioms\.lean$",
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


def check(mutate=None, base_rev=None):
    """Returns (rows, missing). `mutate = (file, index)` changes one character of that head in the working text."""
    rows, missing = [], 0
    base_rev = base_rev or BASE
    for f in FILES:
        base = git("show", f"{base_rev}:{f}")
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


def same_as(rev, path):
    """Is the working file byte-identical to the path's content at `rev`?"""
    r = subprocess.run(["git", "-C", ROOT, "show", f"{rev}:{path}"], capture_output=True)
    if r.returncode != 0:
        return False
    try:
        with open(os.path.join(ROOT, path), "rb") as fh:
            return fh.read() == r.stdout
    except FileNotFoundError:
        return False


def forbidden(merged=MERGED):
    """Paths differing from BASE (or new) that are neither this job's nor brought unchanged by the merge of `merged`."""
    changed = [l for l in git("diff", "--name-only", BASE).split("\n") if l]
    untracked = [l for l in git("ls-files", "--others", "--exclude-standard").split("\n") if l]
    outside = [p for p in changed + untracked if not any(re.search(a, p) for a in ALLOWED)]
    bad = [p for p in outside if not same_as(merged, p)]
    return changed + untracked, outside, bad


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
        # the path check's partner: against the pre-merge tip as the "merged" reference, every path the merge brought must be
        # reported (it is absent or different there); against the true merged tip, none
        _, outside, bad_true = forbidden()
        _, _, bad_plant = forbidden(merged=BASE)
        path_ok = len(bad_true) == 0 and (len(outside) == 0 or len(bad_plant) == len(outside))
        ok = miss0 == 0 and fired == total and total > 0 and path_ok
        print(f"self-test: {fired} of {total} planted head changes reported; faithful run {miss0} missing; the path check "
              f"against the wrong reference reports {len(bad_plant)} of {len(outside)} merged path(s), against the true one "
              f"{len(bad_true)} -> {'OK' if ok else 'FAIL'}")
        sys.exit(0 if ok else 1)
    rows, missing = check()
    for f, name, kind, n in rows:
        print(f"{os.path.basename(f)}\t{kind}\t{name}\tcount={n}")
    rows_s, missing_s = check(base_rev=SKELETON)
    paths, outside, bad = forbidden()
    print(f"{len(rows)} declarations of {BASE}, {missing} not found verbatim once")
    print(f"{len(rows_s)} skeleton declarations of {SKELETON}, {missing_s} not found verbatim once")
    missing += missing_s
    print(f"{len(paths)} path(s) differ from {BASE} or are new; outside this job's paths: {len(outside)}, of which "
          f"{len(outside) - len(bad)} byte-identical to {MERGED} (the merged half) and {len(bad)} not")
    for p in bad:
        print(f"  FORBIDDEN PATH: {p}")
    sys.exit(1 if (missing or bad) else 0)


if __name__ == "__main__":
    main()
