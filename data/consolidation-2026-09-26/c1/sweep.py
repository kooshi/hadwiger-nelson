#!/usr/bin/env python3
"""C1 (consolidation 2026-09-26) scratch sweep, after J30's method (data/rescued-2026-09-25/SWEEP.tsv).

Walks every file under /tmp/claude-1000 that could hold work:
  - the session scratch directory (skipping owner-* and locks, which are the owner's);
  - the loose files and j24/ at /tmp/claude-1000/ (outside any session);
  - the session's tasks/ directory: its regular files are the harness's background-shell outputs (its symlinks point at agent
    transcripts under ~/.claude, which is on disk, and are skipped).
Skipped outright: /tmp/claude-1000/bash-edit-diff/ (the harness's own git snapshots) and the empty session directories.

Classes, first match wins:
  A-head / A-history / A-worktree  identical git blob at HEAD, anywhere in history, or among untracked working-tree files;
  C-disk     identical bytes somewhere in ~/source/library or ~/source/lean-dir-rescue (J30's disk rescues included);
  J30:<cls>  J30 classified this path at this size on 2025-09-25 and the bytes have not changed since (d, c-text, render, ...);
  succ       >= 80 % of its substantive lines (>= 25 chars) appear verbatim in one tracked file (a successor);
  unmatched  everything else, with its best overlap for the reader.
Writes sweep.tsv beside itself: path-with-root-tag, bytes, mtime, class, detail.
"""
import collections, hashlib, os, subprocess, sys, time

T = "/tmp/claude-1000"
SESSION = os.path.join(T, "-home-kooshi-source-lean-dir", "229be71b-1af0-4601-bef0-f695943ce757")
S = os.path.join(SESSION, "scratchpad")
R = "/home/kooshi/source/lean-dir"
HERE = os.path.dirname(os.path.abspath(__file__))
J30_CUTOFF = time.mktime(time.strptime("2026-09-25 17:00", "%Y-%m-%d %H:%M"))


def walk_scratch():
    out = []
    for root, dirs, fs in os.walk(S):
        rel = os.path.relpath(root, S)
        if rel == ".":
            dirs[:] = [d for d in dirs if not d.startswith("owner-") and d != "locks"]
        for f in fs:
            p = os.path.join(root, f)
            if os.path.islink(p) or not os.path.isfile(p):
                continue
            out.append(("scratch/" + os.path.relpath(p, S), p))
    return out


def walk_tmp_root():
    out = []
    for f in os.listdir(T):
        p = os.path.join(T, f)
        if os.path.isfile(p) and not os.path.islink(p):
            out.append(("tmp/" + f, p))
    for root, dirs, fs in os.walk(os.path.join(T, "j24")):
        for f in fs:
            p = os.path.join(root, f)
            out.append(("tmp/" + os.path.relpath(p, T), p))
    tasks = os.path.join(SESSION, "tasks")
    for f in os.listdir(tasks):
        p = os.path.join(tasks, f)
        if os.path.isfile(p) and not os.path.islink(p):
            out.append(("tasks/" + f, p))
    return out


def git(*args, inp=None):
    return subprocess.run(["git", *args], input=inp, capture_output=True, text=True, cwd=R, check=True).stdout


def sha(p):
    h = hashlib.sha256()
    with open(p, "rb") as fh:
        for b in iter(lambda: fh.read(1 << 20), b""):
            h.update(b)
    return h.hexdigest()


def main():
    files = sorted(walk_scratch() + walk_tmp_root())
    blobs = git("hash-object", "--stdin-paths", inp="\n".join(p for _, p in files)).split()
    assert len(blobs) == len(files), (len(blobs), len(files))
    head = {}
    for line in git("ls-tree", "-r", "HEAD").splitlines():
        meta, path = line.split("\t", 1)
        head.setdefault(meta.split()[2], path)
    hist = {}
    for line in git("rev-list", "--objects", "--all").splitlines():
        parts = line.split(" ", 1)
        if len(parts) == 2:
            hist.setdefault(parts[0], parts[1])
    unt = git("ls-files", "--others", "--exclude-standard").split("\n")
    unt = [u for u in unt if u]
    wt = dict(zip(git("hash-object", "--stdin-paths", inp="\n".join(unt)).split(), unt)) if unt else {}
    # disk copies: hash only files whose size equals some unmatched scratch file's size
    sizes = {}
    for (tag, p), b in zip(files, blobs):
        if b not in head and b not in hist and b not in wt:
            sizes.setdefault(os.path.getsize(p), []).append(p)
    disk = {}
    for base in [os.path.expanduser("~/source/library"), os.path.expanduser("~/source/lean-dir-rescue")]:
        for root, dirs, fs in os.walk(base):
            for f in fs:
                q = os.path.join(root, f)
                try:
                    if os.path.getsize(q) in sizes:
                        disk.setdefault(sha(q), q)
                except OSError:
                    pass
    j30 = {}
    for row in open(os.path.join(R, "data/rescued-2026-09-25/SWEEP.tsv")):
        if row.startswith("#"):
            continue
        f, size, cls, where = (row.rstrip("\n").split("\t") + [""] * 4)[:4]
        if size.isdigit():
            j30[f] = (int(size), cls, where)
    # line index of tracked text files, for the successor test
    line2files = collections.defaultdict(set)
    for path in git("ls-files").split("\n"):
        if not path or path.startswith("chats-bak/"):
            continue
        q = os.path.join(R, path)
        try:
            if os.path.getsize(q) > 8 * 2**20:
                continue
            with open(q, encoding="utf-8") as fh:
                txt = fh.read()
        except Exception:
            continue
        for ln in txt.splitlines():
            s = ln.strip()
            if len(s) >= 25:
                line2files[s].add(path)
    rows = []
    for (tag, p), b in zip(files, blobs):
        size = os.path.getsize(p)
        mtime = os.path.getmtime(p)
        mt = time.strftime("%m-%d %H:%M", time.localtime(mtime))
        if b in head:
            cls, det = "A-head", head[b]
        elif b in hist:
            cls, det = "A-history", hist[b]
        elif b in wt:
            cls, det = "A-worktree", wt[b]
        else:
            s = sha(p) if size in sizes else None
            key = tag[len("scratch/"):] if tag.startswith("scratch/") else None
            if s and s in disk:
                cls, det = "C-disk", disk[s]
            elif key in j30 and j30[key][0] == size and mtime < J30_CUTOFF and j30[key][1] not in ("b-repo", "b-disk", "a"):
                cls, det = "J30:" + j30[key][1], j30[key][2]
            else:
                det = ""
                cls = "unmatched"
                try:
                    if size <= 20 * 2**20:
                        with open(p, encoding="utf-8") as fh:
                            sub = [l.strip() for l in fh.read().splitlines() if len(l.strip()) >= 25]
                        if sub:
                            hit = [l for l in sub if l in line2files]
                            cnt = collections.Counter(q for l in hit for q in line2files[l])
                            best = cnt.most_common(1)[0] if cnt else ("", 0)
                            det = f"{len(hit)}/{len(sub)} lines; best {best[0]} ({best[1]})"
                            if best[1] >= 0.8 * len(sub):
                                cls = "succ"
                        else:
                            det = "no substantive lines"
                    else:
                        det = "large"
                except UnicodeDecodeError:
                    det = "binary"
                if key in j30:
                    det += f"; J30 had {j30[key][1]} at {j30[key][0]} bytes"
        rows.append((tag, size, mt, cls, det))
    with open(os.path.join(HERE, "sweep.tsv"), "w") as fh:
        fh.write("# C1 sweep of /tmp/claude-1000, 2026-09-26. columns: where (scratch/ = the session scratch directory, tmp/ = "
                 "/tmp/claude-1000, tasks/ = the session's tasks directory); bytes; mtime; class; detail\n")
        for r in rows:
            fh.write("\t".join(map(str, r)) + "\n")
    c = collections.Counter(r[3] for r in rows)
    print(len(rows), dict(sorted(c.items())))


if __name__ == "__main__":
    main()
