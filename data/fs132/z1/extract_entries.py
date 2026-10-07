#!/usr/bin/env python3
"""FS132-Z1: extract every derivation:/control:/verification:/invention: block of the six
derivers' records, verbatim, with its line number, into one file per record (for reading)
and a TSV index (name, kind, verdict, grade, minds, line). Reads only; writes under data/fs132/z1/."""
import re, sys, pathlib
root = pathlib.Path(__file__).resolve().parents[3]
out = pathlib.Path(__file__).resolve().parent
recs = ["E1", "E2", "E3", "E4", "E5", "E6"]
hdr = re.compile(r"^(derivation|control|verification|invention): (\S+)\s*$")
rows = []
for r in recs:
    src = root / "plans" / f"FS132-{r}-derivation.md"
    lines = src.read_text().split("\n")
    blocks = []
    i = 0
    while i < len(lines):
        m = hdr.match(lines[i])
        if m:
            j = i + 1
            while j < len(lines) and lines[j].strip() != "":
                j += 1
            blk = lines[i:j]
            blocks.append((i + 1, m.group(1), m.group(2), blk))
            i = j
        else:
            i += 1
    with open(out / f"entries-{r}.txt", "w") as f:
        for (ln, kind, name, blk) in blocks:
            f.write(f"### {r} line {ln}\n" + "\n".join(blk) + "\n\n")
            fields = {}
            for b in blk[1:]:
                mm = re.match(r"^  (\w[\w ]*?): (.*)$", b)
                if mm:
                    fields[mm.group(1)] = mm.group(2)
            rows.append((r, str(ln), kind, name, fields.get("verdict", fields.get("of", ""))[:100],
                         fields.get("grade", "")[:80], fields.get("minds", "")[:100]))
with open(out / "entries-index.tsv", "w") as f:
    f.write("record\tline\tkind\tname\tverdict_or_of\tgrade\tminds\n")
    for row in rows:
        f.write("\t".join(row) + "\n")
print(len(rows), "blocks")
