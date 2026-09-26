#!/usr/bin/env python3
"""C1 stage 2: per job, the files its commits touched (subjects '<job>: ...'), grouped: plans, tools, data dirs, Proofs, other.
Only files still at HEAD are listed as addresses; files since deleted are counted."""
import collections, subprocess, sys, os
R = "/home/kooshi/source/lean-dir"
JOBS = sys.argv[1:]
head = set(subprocess.run(["git", "ls-files"], capture_output=True, text=True, cwd=R).stdout.split("\n"))
for job in JOBS:
    out = subprocess.run(["git", "log", "--format=@@%h %s", "--name-only", f"--grep=^{job}:", "--since=2026-09-25T12:00"],
                         capture_output=True, text=True, cwd=R).stdout
    commits, files = [], collections.OrderedDict()
    for line in out.splitlines():
        if line.startswith("@@"):
            commits.append(line[2:].split()[0])
        elif line.strip():
            files[line.strip()] = 1
    g = collections.defaultdict(set); gone = 0
    for f in files:
        if f not in head:
            gone += 1; continue
        top = f.split("/")[0]
        if top == "data":
            parts = f.split("/")
            g["data"].add("/".join(parts[:3]) + "/" if len(parts) > 3 else f)
        elif top in ("plans", "tools", "Proofs"):
            g[top].add(f)
        else:
            g["other"].add(f)
    print(f"## {job}  commits={len(commits)} ({' '.join(reversed(commits))})  gone-since={gone}")
    for k in ("plans", "tools", "data", "Proofs", "other"):
        if g[k]:
            print(f"  {k}: " + ", ".join(sorted(g[k])))
