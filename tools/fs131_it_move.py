#!/usr/bin/env python3
"""FS131-IT1: check the move of `MapGraph`'s `namespace HadwigerNelson.Thomassen` block into its own module, byte for byte.

Reads the original `MapGraph.lean` at a git revision (default `02e85433`, the branch point) and checks:
  1. the block — from the line `namespace HadwigerNelson.Thomassen` through the line `end HadwigerNelson.Thomassen`, inclusive, with its
     trailing newline — occurs exactly once, verbatim, in the new module;
  2. the new `MapGraph.lean` equals the original with exactly that block and the one blank line after it removed, and exactly one line,
     `import Proofs.HadwigerNelson.Thomassen`, inserted after the last original import.
`--plant` runs the same check against a copy of the new module with one byte of the block changed, and must report FAIL: a checker that
cannot see a changed byte has not been tested by passing.

Usage: fs131_it_move.py [--rev REV] [--plant]
Exit: 0 both checks pass (or, with --plant, the planted copy fails as it must); 1 a check fails (or the plant was not seen).
"""
import subprocess
import sys

MAPGRAPH = "Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean"
MODULE = "Proofs/HadwigerNelson/Thomassen.lean"
IMPORT = "import Proofs.HadwigerNelson.Thomassen"


def block_of(text: str) -> tuple[int, int]:
    start = text.index("namespace HadwigerNelson.Thomassen\n")
    end_marker = "end HadwigerNelson.Thomassen\n"
    end = text.index(end_marker, start) + len(end_marker)
    return start, end


def check(orig: str, module: str, mapgraph: str) -> list[str]:
    fails = []
    s, e = block_of(orig)
    blk = orig[s:e]
    n = module.count(blk)
    if n != 1:
        fails.append(f"block occurs {n} times in the new module (expected 1); block is {len(blk)} bytes")
    # expected MapGraph: block and one following blank line removed, import inserted after the last import
    rest = orig[:s] + orig[e + 1:] if orig[e:e + 1] == "\n" else None
    if rest is None:
        fails.append("the original block is not followed by a blank line")
        return fails
    lines = rest.split("\n")
    last_imp = max(i for i, l in enumerate(lines) if l.startswith("import "))
    expected = "\n".join(lines[:last_imp + 1] + [IMPORT] + lines[last_imp + 1:])
    if mapgraph != expected:
        a, b = mapgraph.split("\n"), expected.split("\n")
        k = next((i for i, (x, y) in enumerate(zip(a, b)) if x != y), min(len(a), len(b)))
        fails.append(f"MapGraph differs from the expected remainder at line {k + 1}: got {a[k:k+1]!r}, expected {b[k:k+1]!r}")
    return fails


def main() -> int:
    args = sys.argv[1:]
    rev = args[args.index("--rev") + 1] if "--rev" in args else "02e85433"
    plant = "--plant" in args
    orig = subprocess.run(["git", "show", f"{rev}:{MAPGRAPH}"], check=True, capture_output=True, text=True).stdout
    module = open(MODULE, encoding="utf-8").read()
    mapgraph = open(MAPGRAPH, encoding="utf-8").read()
    s, e = block_of(orig)
    print(f"original block at {rev}: {orig[:s].count(chr(10)) + 1}..{orig[:e].count(chr(10))} ({e - s} bytes)")
    if plant:
        # plant A: one character of the moved block changed in the module; plant B: one character added to MapGraph's remainder
        ms, _ = block_of(module)
        i = module.index("def offTwo", ms)
        planted_module = module[:i] + module[i:].replace("v ≠ x ∧ v ≠ y", "v ≠ x ∨ v ≠ y", 1)
        j = mapgraph.index("namespace HadwigerNelson.Plane")
        planted_mapgraph = mapgraph[:j] + " " + mapgraph[j:]
        ok = True
        for name, (mo, mg) in {"A (module byte)": (planted_module, mapgraph), "B (MapGraph byte)": (module, planted_mapgraph)}.items():
            fails = check(orig, mo, mg)
            for f in fails:
                print(f"  plant {name}: FAIL:", f)
            print(f"plant {name}:", "FAIL (as it must)" if fails else "PASS (checker blind)")
            ok = ok and bool(fails)
        return 0 if ok else 1
    fails = check(orig, module, mapgraph)
    for f in fails:
        print("FAIL:", f)
    print("move check:", "FAIL" if fails else "PASS")
    return 1 if fails else 0


if __name__ == "__main__":
    sys.exit(main())
