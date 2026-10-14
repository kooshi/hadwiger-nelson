#!/usr/bin/env python3
"""FS131-KN6 stage 5: the declared (import-level) cone of files of the outside release, read only.

usage: python3 -I tools/fs131_kn6_import_cone.py <release lean root> <Module.Name> [<Module.Name> ...]
       python3 -I tools/fs131_kn6_import_cone.py --self-test

For each module named: the transitive closure of its `import` lines inside the release (modules whose file exists
under the root), with each file's line count, and the Mathlib imports met.  This is the cone AS DECLARED; the cone as
USED (by constants) needs the release's compiled files and is the port job's first step.  Nothing is written or run
in the release's tree.  --self-test builds a three-file tree in a temporary directory, one import of which is
commented out, and requires the closure to be exactly the two live files (a reader that took the commented import, or
missed a real one, fails)."""
import pathlib, re, sys, tempfile

IMPORT = re.compile(r"^(?:public\s+)?import\s+([A-Za-z0-9_.']+)\s*$")


def imports(path):
    out = []
    in_block = False
    for line in path.read_text().splitlines():
        s = line.strip()
        if in_block:
            if "-/" in s:
                in_block = False
            continue
        if s.startswith("/-"):
            if "-/" not in s:
                in_block = True
            continue
        m = IMPORT.match(s)
        if m:
            out.append(m.group(1))
        elif s and not s.startswith("--") and not s.startswith("module"):
            break  # imports are a prefix of the file
    return out


def cone(root, mod):
    seen, mathlib, todo = {}, set(), [mod]
    while todo:
        m = todo.pop()
        if m in seen:
            continue
        p = root / (m.replace(".", "/") + ".lean")
        if not p.exists():
            mathlib.add(m)
            continue
        seen[m] = sum(1 for _ in p.open())
        todo.extend(imports(p))
    return seen, mathlib


def self_test():
    with tempfile.TemporaryDirectory() as d:
        r = pathlib.Path(d)
        (r / "A.lean").write_text("import B\n-- import C\n/- import C -/\nimport Mathlib.X\n\ntheorem t : True := trivial\nimport C\n")
        (r / "B.lean").write_text("theorem b : True := trivial\n")
        (r / "C.lean").write_text("theorem c : True := trivial\n")
        seen, ml = cone(r, "A")
        ok = set(seen) == {"A", "B"} and ml == {"Mathlib.X"}
        print("self-test", "PASS" if ok else "FAIL", sorted(seen), sorted(ml))
        return 0 if ok else 1


def main():
    if sys.argv[1:] == ["--self-test"]:
        return self_test()
    root = pathlib.Path(sys.argv[1])
    for mod in sys.argv[2:]:
        seen, ml = cone(root, mod)
        total = sum(seen.values())
        print(f"== {mod}: {len(seen)} release files, {total} lines; Mathlib imports met: {len(ml)}")
        for m in sorted(seen, key=lambda x: (-seen[x], x))[:12]:
            print(f"   {seen[m]:6d}  {m}")
        if len(seen) > 12:
            print(f"   … and {len(seen) - 12} more")
    return 0


if __name__ == "__main__":
    sys.exit(main())
