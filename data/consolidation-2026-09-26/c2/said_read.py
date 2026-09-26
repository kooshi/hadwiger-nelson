#!/usr/bin/env python3
"""C2 helper: for a regex naming a paper, print each line of the given files that names it AND carries a
reading word (read, held, library/, pdf, fetched, scanned, abstract, review, §), trimmed around the match.
Usage: said_read.py REGEX file..."""
import re, sys
pat = re.compile(sys.argv[1], re.I)
verb = re.compile(r"\bread\b|reading|held|library/|\.pdf|fetch|scanned|abstract|review|summary|not in zbMATH|§", re.I)
W = 230
for f in sys.argv[2:]:
    for i, line in enumerate(open(f, encoding="utf-8", errors="replace"), 1):
        for m in pat.finditer(line):
            s = line[max(0, m.start()-W): m.end()+W].replace("\n", " ")
            if verb.search(s):
                print(f"{f.split('/')[-1]}:{i}: …{s}…"); break
