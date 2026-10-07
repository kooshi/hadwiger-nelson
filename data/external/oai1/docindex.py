#!/usr/bin/env python3
"""EXT-OAI1 stage 6: an index of the cone's documented declarations: each /-- docstring -/ with the declaration
that follows it, up to its `:=` (or 6 lines).  usage: docindex.py <lean-root> <file-list> > out"""
import sys, re, pathlib
root = pathlib.Path(sys.argv[1])
for rel in pathlib.Path(sys.argv[2]).read_text().split():
    lines = (root / rel).read_text().splitlines()
    print(f"\n######## {rel}  ({len(lines)} lines)")
    i = 0
    while i < len(lines):
        if lines[i].lstrip().startswith('/--'):
            j = i
            while '-/' not in lines[j]: j += 1
            doc = ' '.join(l.strip() for l in lines[i:j+1])
            k = j + 1; decl = []
            while k < len(lines) and len(decl) < 7:
                decl.append(lines[k]); 
                if ':=' in lines[k] or lines[k].rstrip().endswith('where'): break
                k += 1
            print(f"L{i+1}: {doc}")
            for d in decl: print(f"      {d}")
            i = k + 1
        else: i += 1
