#!/usr/bin/env python3
"""FS131-IE1 — does a Mathlib module's import closure hold a given module?  Reads the `import` lines of Mathlib's
sources at the pin (`.lake/packages/mathlib`), breadth first.  Usage: fs131_ie1_closure.py <target> <module>...
Prints one line per module: `holds` or `lacks`, and the import chain to the target when it holds.
A control: the target itself must read `holds` (pass it among the modules)."""
import re
import sys
from pathlib import Path

ML = Path("/home/kooshi/source/lean-dir/.lake/packages/mathlib")
IMP = re.compile(r"^\s*(?:public\s+)?(?:meta\s+)?import\s+(?:all\s+)?(\S+)")


def imports(mod):
    if not mod.startswith("Mathlib"):
        return []
    f = ML / (mod.replace(".", "/") + ".lean")
    if not f.exists():
        raise SystemExit(f"no source for {mod}")
    # the header only: import lines before the first line that is none of blank, a `--` comment, `module`, `prelude`
    # or an import (an `import Mathlib` inside a docstring's example is not an import)
    out, inblock = [], False
    for l in f.read_text().splitlines():
        t = l.strip()
        if inblock:
            inblock = "-/" not in t
            continue
        if t.startswith("/-") and not t.startswith("/-!") and not t.startswith("/--"):
            inblock = "-/" not in t[2:]
            continue
        if t == "" or t.startswith("--") or t.split("--")[0].strip() in ("module", "prelude"):
            continue
        m = IMP.match(l)
        if not m:
            break
        out.append(m.group(1))
    return out


def chain(start, target):
    prev, todo, seen = {start: None}, [start], {start}
    while todo:
        n = todo.pop(0)
        if n == target:
            out = []
            while n is not None:
                out.append(n)
                n = prev[n]
            return out[::-1], len(seen)
        for i in imports(n):
            if i not in seen:
                seen.add(i)
                prev[i] = n
                todo.append(i)
    return None, len(seen)


target = sys.argv[1]
for mod in sys.argv[2:]:
    c, n = chain(mod, target)
    print(f"{'holds' if c else 'lacks'}\t{mod}\t(closure read: {n} modules)" + (f"\tchain: {' -> '.join(c)}" if c else ""))
