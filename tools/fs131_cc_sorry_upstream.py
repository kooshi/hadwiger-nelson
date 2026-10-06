#!/usr/bin/env python3
"""FS131-CC2: where can `sorryAx` enter `BendCollar` from?

Usage: fs131_cc_sorry_upstream.py <build's full log> [--expect N] [--self-test]

Reads a build's full log (`build/gate/build/<stamp>.log`) for the warnings ``<file>:<line>:<col>: declaration uses `sorry` `` and the
working tree's import lines for the modules `Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean` imports, transitively (within
`Proofs/`). A declaration's axioms hold `sorryAx` only through a declaration that uses `sorry`, and it can reach only declarations of
its own module and of the modules that one imports. So if no module `BendCollar` imports has such a warning, every `sorryAx` of a
`BendCollar` declaration enters through `BendCollar`'s own `sorry` declarations, which are listed by line with their names.
Exit 0 iff no upstream module has a `sorry` warning, the log covers every upstream module's build status (it ends with the build's
success line), and, with `--expect N`, `BendCollar` has exactly N `sorry` declarations. `--self-test` plants a warning in an upstream
module (must fail, naming it), plants one in a module that is not upstream (must pass), truncates the log's last line (must fail), and
plants a linter warning in a collar module (must fail). A warning other than `sorry` in the collar's four modules fails the check.
"""
import pathlib
import re
import sys

TREE = pathlib.Path("/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5k")
TARGET = "Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean"
WARN = re.compile(r"warning: (Proofs/\S+\.lean):(\d+):\d+: declaration uses `sorry`")
OTHER = re.compile(r"warning: (Proofs/HadwigerNelson/Plane/ValidMap/(?:RadialPush|Pushforward|CollarMap|BendCollar)\.lean:\d+:\d+): (.*)")


def upstream():
    seen, todo = set(), [TARGET]
    while todo:
        f = todo.pop()
        for m in re.finditer(r"^import (Proofs(?:\.\w+)+)\s*$", (TREE / f).read_text(), re.M):
            g = m.group(1).replace(".", "/") + ".lean"
            if g not in seen and (TREE / g).exists():
                seen.add(g)
                todo.append(g)
    return seen


def decl_name(f, line):
    lines = (TREE / f).read_text().split("\n")
    m = re.match(r"(?:private |protected )?(?:noncomputable )?(?:theorem|lemma|def|instance)\s+(\S+)", lines[line - 1])
    return m.group(1) if m else lines[line - 1][:60]


def check(log_text, expect):
    up = upstream()
    warns = sorted({(m.group(1), int(m.group(2))) for m in WARN.finditer(log_text)})
    errs = []
    if "Build completed successfully" not in log_text and "All targets up-to-date" not in log_text:
        errs.append("the log does not end in the build's success line")
    bad = [(f, l) for f, l in warns if f in up]
    for f, l in bad:
        errs.append(f"upstream `sorry`: {f}:{l}")
    mine = [(f, l) for f, l in warns if f == TARGET]
    # linters silent: no warning other than `sorry` in the collar's four modules
    for m in sorted(set(OTHER.findall(log_text))):
        if "declaration uses `sorry`" not in m[1]:
            errs.append(f"a warning other than `sorry` in a collar module: {m[0]}: {m[1][:80]}")
    if expect is not None and len(mine) != expect:
        errs.append(f"BendCollar has {len(mine)} `sorry` declarations, expected {expect}")
    return errs, up, mine, warns


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    expect = int(sys.argv[sys.argv.index("--expect") + 1]) if "--expect" in sys.argv else None
    if expect is not None:
        args = [a for a in args if a != str(expect)]
    log_text = pathlib.Path(args[0]).read_text()
    if "--self-test" in sys.argv:
        up = sorted(upstream())
        plant_up = log_text + f"\nwarning: {up[0]}:1:8: declaration uses `sorry`\n"
        plant_down = log_text + "\nwarning: Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean:1:8: declaration uses `sorry`\n"
        plant_cut = log_text.replace("Build completed successfully", "Build cut").replace("All targets up-to-date", "cut")
        e1 = [x for x in check(plant_up, expect)[0] if up[0] in x]
        e2 = check(plant_down, expect)[0]
        e3 = [x for x in check(plant_cut, expect)[0] if "success line" in x]
        e0 = check(log_text, expect)[0]
        plant_lint = log_text + "\nwarning: Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean:9:9: Variable name `h` is not explicitly referenced.\n"
        e4 = [x for x in check(plant_lint, expect)[0] if "other than `sorry`" in x]
        print(f"FIRED (a linter warning in a collar module): {e4[0]}" if e4 else "DID NOT FIRE (a linter warning)")
        print(f"FIRED (an upstream warning): {e1[0]}" if e1 else "DID NOT FIRE (an upstream warning)")
        print("PARTNER PASS (a warning that is not upstream)" if not e2 else f"PARTNER FAILED: {e2}")
        print(f"FIRED (a cut log): {e3[0]}" if e3 else "DID NOT FIRE (a cut log)")
        print("PARTNER PASS (the unplanted log)" if not e0 else f"PARTNER FAILED: {e0}")
        ok = bool(e1) and not e2 and bool(e3) and not e0 and bool(e4)
        print(f"self-test: {'3 of 3 plants fired, 2 of 2 partners passed' if ok else 'FAILED'}")
        return 0 if ok else 1
    errs, up, mine, warns = check(log_text, expect)
    for e in errs:
        print("FAIL:", e)
    print(f"BendCollar imports {len(up)} modules of Proofs/ (transitively); `sorry` declarations in them: "
          f"{sum(1 for f, _ in warns if f in up)}")
    for f, l in mine:
        print(f"BendCollar `sorry` declaration, line {l}: {decl_name(f, l)}")
    print("PASS" if not errs else f"FAIL: {len(errs)} error(s)")
    return 0 if not errs else 1


if __name__ == "__main__":
    sys.exit(main())
