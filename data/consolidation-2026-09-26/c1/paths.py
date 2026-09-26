#!/usr/bin/env python3
"""C1 stage 1: every repository path and commit hash the 2026-09-26 crunch's reports and records name — does it exist, committed?

Paths: backticked or bare tokens starting plans/, data/, tools/, Proofs/, scripts/, reference/ (a trailing ':line', '§…' or ',' is cut).
A token with a glob or an ellipsis is checked as a prefix. Hashes: 7-40 hex characters inside backticks, or in a report's COMMITS line.
Writes paths.tsv and prints every miss. Control: a planted fake path and a fake hash must be reported missing."""
import glob, os, re, subprocess, sys

R = "/home/kooshi/source/lean-dir"
HERE = os.path.dirname(os.path.abspath(__file__))
SOURCES = sorted(set(
    glob.glob(f"{R}/data/crunch-2026-09-26-x2x3/reports/*.md") + glob.glob(f"{R}/data/crunch-2026-09-26-x2x3/*.md")
    + [f"{R}/data/crunch-2026-09-25/reports/{j}.md" for j in ("J50", "J51", "J51D", "J51V", "J52", "J52K", "J53", "J53b", "J54", "J55")]
    + glob.glob(f"{R}/plans/FS100-*.md") + glob.glob(f"{R}/plans/FS75-*.md") + [f"{R}/plans/CRUNCH-2026-09-26-x2x3-queue.md"]
    + [f"{R}/plans/POROS-2026-09-26-x2x3-crunch.md"]
    + glob.glob(f"{R}/data/fs100/*-record.md") + glob.glob(f"{R}/data/fs100/*/*.md") + glob.glob(f"{R}/data/fs75/*/*.md")))
PATH = re.compile(r"(?<![\w/.-])((?:plans|data|tools|Proofs|scripts|reference)/[\w./*…+-]+)")
HASH = re.compile(r"`([0-9a-f]{7,40})`")
tracked = set(subprocess.run(["git", "ls-files"], capture_output=True, text=True, cwd=R, check=True).stdout.split("\n"))
tracked_dirs = {os.path.dirname(p) for p in tracked}
for p in list(tracked_dirs):
    while p:
        p = os.path.dirname(p)
        tracked_dirs.add(p)


def check_path(tok):
    tok = tok.rstrip(".,;:)")
    if "*" in tok or "…" in tok:
        pre = re.split(r"[*…]", tok)[0]
        return "tracked" if any(t.startswith(pre) for t in tracked) else "MISSING"
    if tok in tracked:
        return "tracked"
    if tok.rstrip("/") in tracked_dirs:
        return "tracked (directory)"
    if os.path.exists(os.path.join(R, tok)):
        return "UNTRACKED"
    return "MISSING"


def check_hash(h):
    r = subprocess.run(["git", "cat-file", "-e", f"{h}^{{commit}}"], cwd=R, capture_output=True)
    return "commit" if r.returncode == 0 else "NOT A COMMIT"


rows, seen = [], set()
for src in SOURCES:
    if not os.path.exists(src):
        rows.append((src.replace(R + "/", ""), "(source)", "MISSING SOURCE"))
        continue
    txt = open(src, encoding="utf-8").read()
    for tok in PATH.findall(txt):
        tok = tok.rstrip(".,;:)")
        if (src, tok) in seen:
            continue
        seen.add((src, tok))
        rows.append((src.replace(R + "/", ""), tok, check_path(tok)))
    for h in HASH.findall(txt):
        if (src, h) in seen or not re.search(r"[a-f]", h) or not re.search(r"\d", h):
            continue
        seen.add((src, h))
        rows.append((src.replace(R + "/", ""), h, check_hash(h)))
assert check_path("plans/NO-SUCH-FILE-c1-control.md") == "MISSING" and check_hash("deadbeef1") == "NOT A COMMIT", "control failed"
with open(os.path.join(HERE, "paths.tsv"), "w") as fh:
    fh.write("# C1: every path and hash named by the 2026-09-26 crunch's reports and records; source, token, status\n")
    for r in rows:
        fh.write("\t".join(r) + "\n")
bad = [r for r in rows if r[2] not in ("tracked", "tracked (directory)", "commit")]
print(len(SOURCES), "sources;", len(rows), "tokens;", len(bad), "not tracked / not commits")
for r in bad:
    print("\t".join(r))
