#!/usr/bin/env python3
"""FS131-KN4 stage 1: check every quoted line of the brief against the claim list, byte for byte.

Usage: check_quotes.py [--plant]
  --plant  corrupt one character of the claim list in memory and require the check to fire.
"""
import re, sys, pathlib
root = pathlib.Path(__file__).resolve().parents[3]
brief = (root / "data/fs131/briefs/FS131-KN4-three-four-colours-plan.md").read_text()
claims = (root / "data/fs131/claims-NF4.md").read_text()
if "--plant" in sys.argv:
    claims = claims.replace("squarefree `m ≡ 11 (mod 12)`", "squarefree `m ≡ 11 (mod 24)`", 1)
quotes = re.findall(r"^> (NF4-[A-Z0-9-]+: .*)$", brief, flags=re.M)
claim_lines = {l.split(":", 1)[0]: l for l in claims.splitlines() if l.startswith("NF4-")}
bad = 0
for q in quotes:
    key = q.split(":", 1)[0]
    if claim_lines.get(key) == q:
        print(f"MATCH    {key}  ({len(q)} chars)")
    else:
        bad += 1
        print(f"MISMATCH {key}")
missing = set(claim_lines) - {q.split(':',1)[0] for q in quotes}
print(f"quotes={len(quotes)} claim-lines={len(claim_lines)} mismatches={bad} claim-lines-not-quoted={sorted(missing)}")
sys.exit(1 if bad or missing else 0)
