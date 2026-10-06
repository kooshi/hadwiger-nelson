#!/usr/bin/env python3
"""FS131-I5: names wave 5 declares (its own files since its fork from wave 4) that another live body also declares.

`tools/fs131_qa1_dupes.py` (FS131-QA1's, not edited here) knows the bodies w1-w4 and ww but not wave 5. This check reuses its
textual declaration reader (`qualified_decls`) and asks one question: does a qualified name declared in wave 5's own files
(`git diff --name-only <fork> fs131-w5`) appear, at the tip of another body, either in a different file (a duplicated fact or a
collision when both are imported) or in the same file but absent from that file at the fork (both bodies added it: a merge
collision)? A name present at the fork in the same file is inherited, not a duplicate.

Usage: fs131_i5_dupes.py               report (exit 1 if any collision)
       fs131_i5_dupes.py --self-test   plants a wave-5 name into another body's declaration set and watches it fire,
                                       beside a faithful control that must stay quiet
"""
import collections
import importlib.util
import os
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location("qa1", os.path.join(HERE, "fs131_qa1_dupes.py"))
qa1 = importlib.util.module_from_spec(spec)
spec.loader.exec_module(qa1)

W5 = "fs131-w5"
FORK = "9a8de899"  # FS131-I4e's report: where fs131-w5 left fs131-w4
OTHERS = ["main", "fs131-w2", "fs131-w4", "fs131-w4c", "fs131-ww"]


def git(*a):
    r = subprocess.run(["git", *a], capture_output=True, text=True)
    if r.returncode != 0:
        raise SystemExit(f"git {' '.join(a)} failed: {r.stderr.strip()}")
    return r.stdout


def decls_at(ref, paths=None):
    """{qualified name: set(files)} over the .lean files under Proofs/ at ref (or the given paths)."""
    if paths is None:
        paths = [p for p in git("ls-tree", "-r", "--name-only", ref, "--", "Proofs").split() if p.endswith(".lean")]
    out = collections.defaultdict(set)
    for p in paths:
        r = subprocess.run(["git", "show", f"{ref}:{p}"], capture_output=True, text=True)
        if r.returncode != 0:
            continue
        for q, _ in qa1.qualified_decls(r.stdout):
            out[q].add(p)
    return out


def collisions(own, fork_decls, others):
    """own: {name: files} declared in wave 5's own files; others: {body: {name: files}}."""
    found = []
    for name, files in own.items():
        for body, d in others.items():
            if name not in d:
                continue
            for f in d[name]:
                if f not in files:
                    found.append((name, body, f, "different file"))
                elif f not in fork_decls.get(name, set()):
                    found.append((name, body, f, "same file, added by both since the fork"))
    return found


def report():
    own_paths = [p for p in git("diff", "--name-only", FORK, W5, "--", "Proofs").split() if p.endswith(".lean")]
    own = decls_at(W5, own_paths)
    fork_decls = decls_at(FORK, own_paths)
    own = {n: f for n, f in own.items() if not (fork_decls.get(n) and f <= fork_decls[n])}  # drop names inherited at the fork
    others = {b: decls_at(b) for b in OTHERS}
    found = collisions(own, fork_decls, others)
    print(f"wave 5 own files: {len(own_paths)}; names new since the fork: {len(own)}; bodies compared: {', '.join(OTHERS)}")
    for name, body, f, why in sorted(found):
        print(f"COLLISION {name}  {body}:{f}  ({why})")
    print(f"total: {len(found)} collisions")
    return 1 if found else 0


def self_test():
    own = {"A.foo": {"X.lean"}, "A.bar": {"X.lean"}}
    fork = {"A.bar": {"X.lean"}}
    faithful = {"b": {"A.bar": {"X.lean"}, "A.other": {"Y.lean"}}}
    planted_file = {"b": {"A.foo": {"Y.lean"}}}
    planted_same = {"b": {"A.foo": {"X.lean"}}}
    ok = (collisions(own, fork, faithful) == []
          and len(collisions(own, fork, planted_file)) == 1
          and len(collisions(own, fork, planted_same)) == 1)
    print("self-test:", "OK (faithful quiet; both plants fire)" if ok else "FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(self_test() if sys.argv[1:] == ["--self-test"] else report())
