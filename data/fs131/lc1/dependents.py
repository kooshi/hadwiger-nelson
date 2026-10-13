#!/usr/bin/env python3
"""FS131-LC1: the modules a docstring edit rebuilds — every module of Proofs/ that imports, directly or not, one of the
named modules (a docstring is environment data: LEAN.md § Building).  Usage: dependents.py Mod.Name [Mod.Name ...]
Prints the edited modules, then their dependents in no particular order, then the count."""
import re, sys, pathlib
root = pathlib.Path(__file__).resolve().parents[3]
imports = {}
files = [root / "Proofs.lean"] + sorted((root / "Proofs").rglob("*.lean"))
for f in files:
    mod = ".".join(f.relative_to(root).with_suffix("").parts)
    imports[mod] = set(re.findall(r"^import\s+(Proofs(?:\.[\w']+)*)\s*$", f.read_text(), flags=re.M))
rev = {}
for m, ds in imports.items():
    for d in ds:
        rev.setdefault(d, set()).add(m)
seeds = sys.argv[1:]
for s in seeds:
    if s not in imports:
        sys.exit(f"no such module: {s}")
seen, todo = set(seeds), list(seeds)
while todo:
    m = todo.pop()
    for r in rev.get(m, ()):
        if r not in seen:
            seen.add(r); todo.append(r)
deps = sorted(seen - set(seeds))
print("modules in Proofs:", len(imports))
print("edited:", " ".join(seeds))
for d in deps:
    print("  dependent:", d)
print("rebuilt in all (edited and dependents):", len(seen))
