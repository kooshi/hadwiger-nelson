#!/usr/bin/env python3
"""J27D stage 1: every statement the brief quotes must occur verbatim in plans/FS67-tight-products.md.
Usage: crunch_j27d_quotes.py [--plant]   (--plant mutates one quote; the check must then FAIL)."""
import re, sys
brief = open("data/crunch-2026-09-25/briefs/J27D-FS67-derivation.md").read()
plan = open("plans/FS67-tight-products.md").read()
norm = lambda s: re.sub(r"\s+", " ", s)
brief, plan = norm(brief), norm(plan)
# the claim statements: **ID** (§x.y) "..."; the definitions block; FS67's inner quote
quotes = re.findall(r'\*\*(?:D[A-D]-\d′?)\*\* \(§[\d.]+\) "([^"]+)"', brief)
quotes += re.findall(r'Definitions \(§4\.1\): "(Graphs are .+?)\*\*FS67', brief)
quotes += re.findall(r'\*\*FS67\(G, k\)\*\*: "([^"]+)"', brief)
if "--plant" in sys.argv:
    quotes[3] = quotes[3].replace("k ≥ 3", "k ≥ 2", 1)
bad = [q for q in quotes if q not in plan]
for q in quotes:
    print(("OK   " if q not in bad else "MISS ") + q[:90])
print(f"{len(quotes)} quotes, {len(bad)} missing")
sys.exit(1 if bad else 0)
