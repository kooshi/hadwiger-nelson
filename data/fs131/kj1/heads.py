#!/usr/bin/env python3
"""FS131-KJ1: print every public declaration head (theorem/def/abbrev/instance/structure) of a Lean file — the statement
text up to its ':=' — with the line it starts on. A reading aid for the readback; not a check (text, not stored terms)."""
import re, sys
for path in sys.argv[1:]:
    lines = open(path).read().split("\n")
    print(f"=== {path}")
    i = 0
    while i < len(lines):
        l = lines[i]
        if re.match(r"^(noncomputable |protected )*(theorem|def|abbrev|instance|structure|lemma)\b", l):
            j = i
            buf = []
            while j < len(lines):
                buf.append(lines[j])
                if re.search(r":=\s*(by)?\s*$", lines[j]) or re.search(r":=", lines[j]) or lines[j].rstrip().endswith("where"):
                    break
                j += 1
            head = " ".join(s.strip() for s in buf)
            head = re.sub(r"\s*:=.*$", "", head)
            print(f"{i+1}: {head}")
            i = j + 1
        else:
            i += 1
