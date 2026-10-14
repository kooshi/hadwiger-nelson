#!/usr/bin/env python3
"""FS131-KJ1 stage 2: resolve a conflict in which both sides added lines at one place — keep both, the incoming side's lines
first (they are on main, through the gate), then this branch's. Refuses a file whose conflict has a non-empty common ancestor
part (diff3 style) or more than one conflict hunk, so that nothing but 'both added' is resolved this way."""
import sys
for path in sys.argv[1:]:
    lines = open(path).read().split("\n")
    out, ours, theirs, state, hunks = [], [], [], 0, 0
    for l in lines:
        if l.startswith("<<<<<<< "):
            assert state == 0; state = 1; hunks += 1
        elif l.startswith("||||||| "):
            sys.exit(f"{path}: diff3 base part present; not a both-added conflict")
        elif l == "=======" and state == 1:
            state = 2
        elif l.startswith(">>>>>>> ") and state == 2:
            out += theirs + ours; ours, theirs, state = [], [], 0
        elif state == 1:
            ours.append(l)
        elif state == 2:
            theirs.append(l)
        else:
            out.append(l)
    assert state == 0 and hunks == 1, f"{path}: hunks={hunks} state={state}"
    open(path, "w").write("\n".join(out))
    print(f"{path}: 1 hunk resolved, both sides kept")
