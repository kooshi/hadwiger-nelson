#!/usr/bin/env python3
"""FS131-I4k: compare every theorem statement of a module (the text from `theorem <name>` to its `:=`, whitespace-normalized)
between a git revision and the working tree. Prints added, removed and changed statements; exit 1 if any statement present in both
changed. Usage: fs131_i4_stmts.py <rev> <path> [--allow name ...]"""
import re, subprocess, sys
rev, path = sys.argv[1], sys.argv[2]
allow = set(sys.argv[sys.argv.index("--allow") + 1:]) if "--allow" in sys.argv else set()
def stmts(src):
    out = {}
    for m in re.finditer(r"^theorem (\S+)(.*?):=", src, re.S | re.M):
        out[m.group(1)] = " ".join(m.group(2).split())
    return out
old = stmts(subprocess.run(["git", "show", f"{rev}:{path}"], capture_output=True, text=True, check=True).stdout)
new = stmts(open(path).read())
changed = [n for n in old if n in new and old[n] != new[n]]
print(f"{len(old)} old, {len(new)} new, {len([n for n in new if n not in old])} added, "
      f"{len([n for n in old if n not in new])} removed, {len(changed)} changed")
bad = False
for n in changed:
    print(("ALLOWED " if n in allow else "CHANGED ") + n)
    bad |= n not in allow
for n in old:
    if n not in new: print("REMOVED " + n); bad = True
sys.exit(1 if bad else 0)
