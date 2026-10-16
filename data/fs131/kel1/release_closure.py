"""FS131-KEL1: the import closure of a release module inside the release's Lean tree, with line counts.

Usage: python3 -I release_closure.py <release lean root> <module name> [--files]
Reads `import OAI.…` lines only (Mathlib imports are counted separately as names). Prints the closure's file
count, total lines, lines per top folder, and the Mathlib modules imported directly by files in the closure.
"""
import sys, pathlib, re, collections

root = pathlib.Path(sys.argv[1])
start = sys.argv[2]
show = "--files" in sys.argv
def path_of(mod):
    return root / (mod.replace(".", "/") + ".lean")
seen, stack, mathlib = set(), [start], set()
while stack:
    m = stack.pop()
    if m in seen:
        continue
    seen.add(m)
    p = path_of(m)
    if not p.exists():
        print("MISSING", m); continue
    for ln in p.read_text().splitlines():
        mm = re.match(r"^\s*import\s+(\S+)", ln)
        if not mm:
            continue
        dep = mm.group(1)
        if dep.startswith("OAI."):
            stack.append(dep)
        else:
            mathlib.add(dep)
lines = {m: len(path_of(m).read_text().splitlines()) for m in seen if path_of(m).exists()}
by = collections.Counter()
for m, n in lines.items():
    parts = m.split(".")
    key = ".".join(parts[:5]) if len(parts) > 5 else ".".join(parts[:-1])
    by[key] += n
print(f"closure of {start}: {len(lines)} files, {sum(lines.values())} lines")
for k, v in sorted(by.items(), key=lambda kv: -kv[1]):
    print(f"  {v:7d}  {k}")
print("direct non-OAI imports:", sorted(mathlib))
if show:
    for m in sorted(lines):
        print(lines[m], m)
