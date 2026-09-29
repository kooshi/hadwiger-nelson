#!/usr/bin/env python3
"""FS116-V3 helper: wrap the five statements verbatim (from data/fs116/claims.md § 11) into verification-block statement fields."""
import sys, textwrap, json
NAMES = ["FS116-N1-GERM-R", "FS116-N1-GERM-S", "FS116-N1-TOUCH", "FS116-N1-ECHO", "FS116-N1-AXIS"]
claims = open("data/fs116/claims.md", encoding="utf-8").read().split("## 11.", 1)[1]
out = {}
for n in NAMES:
    for line in claims.splitlines():
        s = line.strip()
        if s.startswith("-") and (n + "**") in s:
            body = s[1:].strip()
            # drop the bold name and the "(proposed at round 2):" tag, keep the statement from its first word
            stmt = body.split("*(proposed at round 2)*:", 1)[1].strip()
            out[n] = stmt
FIELDKEYS = {"statement","given","committed","predicted","verdict","method","attack","divergences","counterexamples","minds","grade"}
def field(key, text, width=150):
    lines = textwrap.wrap(text, width=width, initial_indent="  %s: " % key, subsequent_indent="    ", break_long_words=False, break_on_hyphens=False)
    for l in lines[1:]:
        k = l.strip().split(":", 1)[0].lower()
        assert not (":" in l and k in FIELDKEYS), l
    return "\n".join(lines)
json.dump(out, open("data/fs116/v3/statements.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
if __name__ == "__main__":
    for n in NAMES:
        print(n, len(out[n]))
