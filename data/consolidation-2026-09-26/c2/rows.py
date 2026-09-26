#!/usr/bin/env python3
"""C2 helper: print BIBLIOGRAPHY.md table rows whose text contains any given key, column by column,
truncating each column to N chars (env W, default 400). Usage: rows.py Key1 Key2 ..."""
import os, sys
W = int(os.environ.get("W", "400"))
L = open(os.path.join(os.path.dirname(__file__), "..", "..", "..", "BIBLIOGRAPHY.md"), encoding="utf-8").read().split("\n")
for i, line in enumerate(L, 1):
    if not line.startswith("|"): continue
    first = line.split("|")[1] if line.count("|") > 2 else ""
    if any(f"[{k}]" in first for k in sys.argv[1:]):
        cols = [c.strip() for c in line.strip().strip("|").split(" | ")]
        print(f"--- line {i}: {len(cols)} cols, {len(line)} chars")
        for j, c in enumerate(cols):
            print(f"  [{j}] {c[:W]}{'…' if len(c) > W else ''}")
