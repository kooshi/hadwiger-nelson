#!/usr/bin/env python3
"""FS116-Z1 working survey: list every derivation/verification/control block in FS-116's records (the gate's parser)."""
import sys, pathlib
ROOT = pathlib.Path("/home/kooshi/source/lean-dir")
sys.path.insert(0, str(ROOT / ".claude/skills/ephodos/scripts"))
import derive_gate as G
recs = sorted(ROOT.glob("plans/FS116-*.md"))
for p in recs:
    lines, _ = G.strip_fences(G.read(str(p)))
    bl = list(G.blocks(lines, str(p)))
    print(f"== {p.name}: {len(bl)} blocks")
    for b in bl:
        f = b["fields"]
        if b["kind"] == "control":
            print(f"   control {b['name']} of={f.get('of','')[:60]}")
            continue
        v = " ".join(f.get("verdict","").split())[:70]
        g = " ".join(f.get("grade","").split())[:50]
        m = " ".join(f.get("minds","").split())[:70]
        print(f"   {b['kind'][:5]} {b['name']} | {v} | {g} | {m}")
