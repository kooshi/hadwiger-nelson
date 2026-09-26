#!/usr/bin/env python3
"""J30 scratch sweep: classify every scratch file (skipping owner-* and locks) by exact content match
against the repository (HEAD tree, then all history), ~/source/library, and ~/source/lean-dir-rescue."""
import os, subprocess, hashlib, sys, json, collections
S = "/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad"
R = "/home/kooshi/source/lean-dir"
files = []
for root, dirs, fs in os.walk(S):
    rel = os.path.relpath(root, S)
    top = rel.split(os.sep)[0]
    if top.startswith("owner-") or top in ("locks", "j30"):
        dirs[:] = []; continue
    if rel == ".":
        dirs[:] = [d for d in dirs if not d.startswith("owner-") and d not in ("locks", "j30")]
    for f in fs:
        p = os.path.join(root, f)
        if os.path.islink(p) or not os.path.isfile(p): continue
        files.append(os.path.relpath(p, S))
files.sort()
# git blob hashes of scratch files
out = subprocess.run(["git", "hash-object", "--stdin-paths"], input="\n".join(os.path.join(S, f) for f in files),
                     capture_output=True, text=True, cwd=R, check=True).stdout.split()
assert len(out) == len(files)
head = {}
for line in subprocess.run(["git", "ls-tree", "-r", "HEAD"], capture_output=True, text=True, cwd=R, check=True).stdout.splitlines():
    meta, path = line.split("\t", 1)
    head.setdefault(meta.split()[2], path)
hist = {}
for line in subprocess.run(["git", "rev-list", "--objects", "--all"], capture_output=True, text=True, cwd=R, check=True).stdout.splitlines():
    parts = line.split(" ", 1)
    if len(parts) == 2: hist.setdefault(parts[0], parts[1])
# working-tree untracked files too (data dirs of running jobs)
wt = {}
unt = subprocess.run(["git", "ls-files", "--others", "--exclude-standard"], capture_output=True, text=True, cwd=R, check=True).stdout.split()
if unt:
    h = subprocess.run(["git", "hash-object", "--stdin-paths"], input="\n".join(unt), capture_output=True, text=True, cwd=R, check=True).stdout.split()
    wt = dict(zip(h, unt))
def sha(p):
    h = hashlib.sha256()
    with open(p, "rb") as fh:
        for b in iter(lambda: fh.read(1 << 20), b""): h.update(b)
    return h.hexdigest()
lib = {}
for base in [os.path.expanduser("~/source/library"), os.path.expanduser("~/source/lean-dir-rescue")]:
    for root, dirs, fs in os.walk(base):
        for f in fs:
            p = os.path.join(root, f)
            try:
                if os.path.getsize(p) < 200 * 2**20: lib.setdefault(sha(p), p)
            except OSError: pass
basenames = collections.defaultdict(list)
for path in head.values(): basenames[os.path.basename(path)].append(path)
rows = []
for f, blob in zip(files, out):
    p = os.path.join(S, f); size = os.path.getsize(p)
    if blob in head: cls, where = "A-head", head[blob]
    elif blob in hist: cls, where = "A-history", hist[blob]
    elif blob in wt: cls, where = "A-worktree", wt[blob]
    else:
        s = sha(p)
        if s in lib: cls, where = "C-library", lib[s]
        elif os.path.basename(f) in basenames: cls, where = "name-match", ";".join(basenames[os.path.basename(f)][:3])
        else: cls, where = "unmatched", ""
    rows.append((f, size, cls, where))
with open(os.path.join(S, "j30", "sweep.tsv"), "w") as fh:
    for r in rows: fh.write("\t".join(map(str, r)) + "\n")
c = collections.Counter(r[2] for r in rows)
print(len(rows), dict(c))
