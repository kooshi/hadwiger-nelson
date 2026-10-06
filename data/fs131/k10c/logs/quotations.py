#!/usr/bin/env python3
"""FS131-K10c: check every quotation of the brief against the source it names (standing rule 3).
A quotation is a line '> text' followed by a line '> — source: path'.  Each is looked up by plain
substring in the named file (relative paths are resolved against the main tree, then this worktree)."""
import re, sys, os
MAIN = "/home/kooshi/source/lean-dir"
WT = MAIN + "/.claude/worktrees/fs131-w10k"
brief = open(MAIN + "/data/fs131/briefs/FS131-K10c-wave10-third.md").read().split("\n")
ok = bad = 0
i = 0
while i < len(brief):
    ln = brief[i]
    if ln.startswith("> ") and i + 1 < len(brief) and brief[i + 1].startswith("> — source:"):
        text = ln[2:]
        src = brief[i + 1][len("> — source:"):].strip()
        src_path = src.split(" § ")[0].strip()
        cands = [src_path] if src_path.startswith("/") else [MAIN + "/" + src_path, WT + "/" + src_path]
        found = None
        for c in cands:
            if os.path.exists(c):
                body = open(c).read()
                if text in body:
                    found = c
                    break
        if found:
            ok += 1
            print(f"MATCH   {text[:70]!r}  in {found.replace(MAIN + '/', '')}")
        else:
            bad += 1
            print(f"NOMATCH {text[:70]!r}  source {src}")
        i += 2
    else:
        i += 1
print(f"{ok} match, {bad} do not")
sys.exit(1 if bad else 0)
