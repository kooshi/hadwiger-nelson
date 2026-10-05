#!/usr/bin/env python3
"""FS131-M6: the import closure of a module in the working tree (Proofs.* imports only).

  python3 tools/fs131_m6_closure.py <Module.Path> [<Module.Path> ...]   # prints each closure's Proofs modules, one per line
  python3 tools/fs131_m6_closure.py --reach <A> <B>                     # exit 0 iff module B is in A's closure (A itself included)
  python3 tools/fs131_m6_closure.py --self-test                          # Terminal reaches HornShadow (must) and HornShadow does not reach Terminal (must not)
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
IMP = re.compile(r"^import\s+(Proofs\.\S+)", re.M)


def imports(mod):
    p = ROOT / (mod.replace(".", "/") + ".lean")
    if not p.exists():
        raise SystemExit(f"NO SUCH MODULE {mod} ({p})")
    return IMP.findall(p.read_text())


def closure(mod):
    seen, todo = set(), [mod]
    while todo:
        m = todo.pop()
        if m in seen:
            continue
        seen.add(m)
        todo.extend(imports(m))
    return seen


def main():
    a = sys.argv[1:]
    if a and a[0] == "--self-test":
        t = "Proofs.HadwigerNelson.Plane.ValidMap.Terminal"
        h = "Proofs.HadwigerNelson.Plane.ValidMap.HornShadow"
        ok1 = h in closure(t)
        ok2 = t not in closure(h)
        print("Terminal reaches HornShadow:", ok1, "| HornShadow does not reach Terminal:", ok2)
        sys.exit(0 if ok1 and ok2 else 1)
    if a and a[0] == "--reach":
        r = a[2] in closure(a[1])
        print(f"{a[1]} {'REACHES' if r else 'does NOT reach'} {a[2]}")
        sys.exit(0 if r else 1)
    for m in a:
        c = sorted(closure(m))
        print(f"== {m}: {len(c)} Proofs modules")
        for x in c:
            print(x)


if __name__ == "__main__":
    main()
