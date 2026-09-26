#!/usr/bin/env python3
"""C2 (2026-09-26): does every 'held at' address in BIBLIOGRAPHY.md exist?  Extracts every backticked path that
names a file (a known document suffix, or a library/ pdf/ papers/ notes/ supplementary/ prefix) and resolves it
against ~/source/ (the file's stated base), ~/source/library/, and the repository root. Prints MISSING rows with
their line and key; also checks any md5 prefix written within 120 chars after the path. Exit 1 if anything is missing."""
import os, re, sys, hashlib
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", ".."))
SRC = os.path.expanduser("~/source"); LIB = os.path.join(SRC, "library")
BIB = open(os.path.join(ROOT, "BIBLIOGRAPHY.md"), encoding="utf-8").read().split("\n")
TICK = re.compile(r"`([^`\s]+)`")
DOC = re.compile(r"\.(pdf|djvu|txt|epub|ps|gz|html?|tex|zip|xml|json|md)$", re.I)
PRE = ("library/", "pdf/", "papers/", "notes/", "supplementary/", "~/source/")
MD5 = re.compile(r"md5[^`]{0,20}`?([0-9a-f]{8,32})")
def resolve(p):
    q = os.path.expanduser(p.replace("…", ""))
    for base in ("", SRC, LIB, ROOT):
        c = os.path.join(base, q) if base else q
        if os.path.isabs(c) and os.path.exists(c): return c
    return None
missing, found, mdbad, n = [], 0, [], 0
for i, line in enumerate(BIB, 1):
    key = (re.search(r"\*\*\[([A-Za-z0-9]+)\]\*\*", line) or [None, "-"])[1]
    for m in TICK.finditer(line):
        p = m.group(1)
        if "…" in p or "*" in p or "<" in p: continue
        if not (DOC.search(p) or p.startswith(PRE)): continue
        if "/" not in p and not p.startswith("~"): continue   # a bare filename is not an address
        n += 1
        r = resolve(p)
        if r is None: missing.append((i, key, p)); continue
        found += 1
        mm = MD5.search(line[m.end(): m.end()+120])
        if mm and os.path.isfile(r):
            h = hashlib.md5(open(r, "rb").read()).hexdigest()
            if not h.startswith(mm.group(1)): mdbad.append((i, key, p, mm.group(1), h[:8]))
print(f"addresses checked: {n}; found: {found}; missing: {len(missing)}; md5 mismatches: {len(mdbad)}")
for i, k, p in missing: print(f"  MISSING line {i} [{k}]: {p}")
for i, k, p, want, got in mdbad: print(f"  MD5 line {i} [{k}]: {p} wants {want} got {got}")
sys.exit(1 if missing or mdbad else 0)
