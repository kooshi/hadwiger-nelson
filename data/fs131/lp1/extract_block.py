#!/usr/bin/env python3
"""FS131-LP1: print the block of one label from a read-back print, streaming (the comparator's own reader).
Usage: extract_block.py PRINT LABEL [FIELD]   (FIELD: type | etype | value | evalue | uses: that line only)"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3] / "tools"))
import importlib.util
spec = importlib.util.spec_from_file_location("rp", Path(__file__).resolve().parents[3] / "tools/fs131_ipa1_readback_port.py")
rp = importlib.util.module_from_spec(spec); spec.loader.exec_module(rp)
path, lab = sys.argv[1], sys.argv[2]
field = sys.argv[3] if len(sys.argv) > 3 else None
for kind, *rest in rp.blocks(rp.raw_lines(path)):
    if kind == "B" and rest[0] == lab:
        for ln in rest[1]:
            if field is None or (field == "uses" and ln.startswith("USES ")) or ln.startswith(f"DUMP   {field}"):
                print(ln)
        break
