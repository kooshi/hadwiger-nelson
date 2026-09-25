"""Exact-string replacements: each old string must occur exactly once."""
import sys, json
def apply(path, pairs):
    s = open(path, encoding="utf-8").read()
    for old, new in pairs:
        n = s.count(old)
        if n != 1:
            sys.exit(f"{path}: expected 1 occurrence, found {n}: {old[:120]!r}")
        s = s.replace(old, new)
    open(path, "w", encoding="utf-8").write(s)
    print(f"{path}: {len(pairs)} replacements")
