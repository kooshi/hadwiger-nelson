#!/usr/bin/env python3
"""FS131-IV1 — a dump of data/fs131/iv1/lean/StatementDump.lean in compact form.

The dumper prints each stored type and value raw, with every instance term written out: tens of megabytes for the constants
of the three modules.  This keeps each line's identity and drops its bulk:

  @@ <KIND> <name> [INTERNAL]                                   (unchanged)
  TYPE  <Lean's hash> sha256=<of the raw text> len=<its length> <its first 160 characters>
  VALUE <Lean's hash> sha256=<…> len=<…> <first 160 characters>

Two compact lines are equal exactly when the two raw texts have one hash, one SHA-256 and one length, so
`statement_diff.py` reads a pair of compact dumps as it reads a pair of raw ones.
Usage: compact_dump.py <raw-dump.txt> <compact.txt>
"""
import hashlib, sys, pathlib
src, dst = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])
out, n = [], 0
for ln in src.read_text().splitlines():
    for tag in ("TYPE ", "VALUE "):
        if ln.startswith(tag):
            h, _, raw = ln[len(tag):].partition(" ")
            ln = f"{tag}{h} sha256={hashlib.sha256(raw.encode()).hexdigest()} len={len(raw)} {raw[:160]}"
            n += 1
            break
    out.append(ln)
if n == 0:
    print(f"NOTHING TO COMPACT in {src}: not a raw dump"); sys.exit(2)
dst.write_text("\n".join(out) + "\n")
print(f"{src} ({src.stat().st_size} bytes, sha256 {hashlib.sha256(src.read_bytes()).hexdigest()}) -> {dst} ({dst.stat().st_size} bytes), {n} stored terms")
