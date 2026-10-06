#!/usr/bin/env python3
"""FS131-L6A: before a merge is committed, check that the index holds the merge and nothing else.

  tools/fs131_l6a_mergeindex.py <theirs-ref> [<conflict-path> ...]

Run in a worktree with a merge in progress (MERGE_HEAD set), every conflict resolved and staged.
With base = merge-base(HEAD, theirs):

  * MERGE_HEAD is <theirs-ref>'s commit;
  * no path is unmerged;
  * the staged paths (index against HEAD) are exactly the paths theirs changed since base whose
    content at theirs differs from HEAD's;
  * every staged path outside the named conflict paths is taken whole from theirs
    (index blob = theirs blob) — and a path both sides changed that is not a named conflict
    path is reported (BOTH), because it merged by itself and nobody read it;
  * every named conflict path is staged and is a path both sides changed;
  * no tracked file differs between the working tree and the index.

Exit 0 iff all hold. The check's control is run live and logged in the record: an extra file
staged (EXTRA) and a conflict path left unstaged.
"""
import subprocess
import sys


def git(*a, check=True):
    return subprocess.run(["git", *a], check=check, capture_output=True, text=True).stdout


def names(*a):
    return {p for p in git(*a).split("\n") if p}


def blob(spec):
    r = subprocess.run(["git", "rev-parse", "--verify", "-q", spec], capture_output=True, text=True)
    return r.stdout.strip() or None


def main(argv):
    if not argv:
        print(__doc__)
        return 2
    theirs, conflicts = argv[0], set(argv[1:])
    faults = []
    mh = blob("MERGE_HEAD")
    th = blob(theirs + "^{commit}")
    if mh is None:
        faults.append("NO-MERGE: MERGE_HEAD is not set")
    elif mh != th:
        faults.append(f"WRONG-MERGE: MERGE_HEAD {mh[:8]} is not {theirs} ({th[:8]})")
    base = git("merge-base", "HEAD", theirs).strip()
    unmerged = names("diff", "--name-only", "--diff-filter=U")
    for p in sorted(unmerged):
        faults.append(f"UNMERGED {p}")
    staged = names("diff", "--cached", "--name-only", "HEAD")
    theirs_changed = names("diff", "--name-only", base, theirs)
    ours_changed = names("diff", "--name-only", base, "HEAD")
    expected = {p for p in theirs_changed if blob(f"{theirs}:{p}") != blob(f"HEAD:{p}")}
    for p in sorted(staged - expected):
        faults.append(f"EXTRA staged, not of the merge: {p}")
    for p in sorted(expected - staged):
        faults.append(f"MISSING from the index: {p}")
    both = theirs_changed & ours_changed
    for p in sorted(staged - conflicts):
        if p in both:
            faults.append(f"BOTH sides changed, merged unread: {p}")
        elif blob(f":{p}") != blob(f"{theirs}:{p}"):
            faults.append(f"NOT-THEIRS: staged {p} is not {theirs}'s blob")
    for p in sorted(conflicts):
        if p not in staged:
            faults.append(f"CONFLICT-PATH not staged: {p}")
        if p not in both:
            faults.append(f"CONFLICT-PATH not changed by both sides: {p}")
    dirty = names("diff", "--name-only")
    for p in sorted(dirty):
        faults.append(f"DIRTY (working tree differs from the index): {p}")
    print(f"merge of {theirs} ({(th or '?')[:8]}) into {blob('HEAD')[:8]}, base {base[:8]}: "
          f"staged {len(staged)} path(s), {len(staged & both)} changed by both sides "
          f"({', '.join(sorted(staged & both)) or 'none'}), {len(staged - both)} taken whole from theirs")
    for f in faults[:20]:
        print("  " + f)
    print("merge-index: PASS" if not faults else f"merge-index: FAIL ({len(faults)} fault(s))")
    return 1 if faults else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
