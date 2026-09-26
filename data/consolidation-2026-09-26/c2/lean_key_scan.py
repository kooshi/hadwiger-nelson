#!/usr/bin/env python3
"""C2 (2026-09-26): run tools/bib_audit.py's own resolution rule over files the audit does not walk
(it walks *.md only): Lean sources under Proofs/, and optionally other suffixes. Imports the audit's
regexes and its defined/alias sets, so a key resolves here exactly when it resolves there.
Usage: python3 lean_key_scan.py [suffix ...]   (default: .lean)   exit 1 if any key/arXiv id is unresolved."""
import os, sys, re
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", ".."))
sys.path.insert(0, os.path.join(ROOT, "tools"))
import bib_audit as B
suffixes = tuple(sys.argv[1:]) or (".lean",)
defined, aliases, _, _, _, _ = B.scan()
bib = open(B.BIB, encoding="utf-8").read()
bib_arxiv = {g for t in B.ARXIV.findall(bib) for g in t if g}
keys, arx, nfiles = {}, {}, 0
for dp, dn, fn in os.walk(ROOT):
    dn[:] = [d for d in dn if d not in (".git", ".lake", "build", "node_modules", ".claude")]
    for n in fn:
        if n.endswith(suffixes):
            nfiles += 1
            p = os.path.join(dp, n); t = open(p, encoding="utf-8", errors="replace").read()
            for k in B.KEY.findall(t) + B.YEARLESS.findall(t):
                keys.setdefault(k, os.path.relpath(p, ROOT))
            for tup in B.ARXIV.findall(t):
                for g in tup:
                    if g: arx.setdefault(g, os.path.relpath(p, ROOT))
mk = {k: v for k, v in keys.items() if k not in defined and k not in aliases and k not in B.NOT_KEYS}
ma = {k: v for k, v in arx.items() if k not in bib_arxiv}
print(f"files scanned ({','.join(suffixes)}): {nfiles}; keys cited: {len(keys)}; arXiv ids cited: {len(arx)}")
print(f"unresolved keys: {len(mk)}")
for k, v in sorted(mk.items()): print(f"   [{k}]  first seen in {v}")
print(f"unresolved arXiv ids: {len(ma)}")
for k, v in sorted(ma.items()): print(f"   arXiv:{k}  first seen in {v}")
sys.exit(1 if (mk or ma) else 0)
