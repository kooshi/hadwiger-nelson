#!/usr/bin/env python3
"""FS131-I6D: no statement or definition changed since the branch's base.

Run from the repository root (the worktree):

    python3 tools/fs131_i6d_statements.py [--base 32f2ab4c] [--self-test]

Two rules, each read from `git show <base>:<file>` against the working tree:

* FROZEN files (another line's, or the foundation): byte-identical to the base.
* PROOF files (`FanBridge`, `FanExamples`): every line of the base survives, in order, in the working
  tree, except that a line `  sorry` may go, a line ending in `:= by` may lose its `by`
  (a `sorry` body replaced by a term), and a docstring's last line may lose its closing ` -/`
  (the docstring continued by added lines: an inhabitant note). So a statement, a docstring's text,
  a definition or a structure field that changed, moved or vanished fails; added lines pass.

`--self-test` plants three faults in a copy of the working text of `FanBridge` and watches each fire
(a bound in a statement changed; a hypothesis line deleted; a docstring line changed), with the
unplanted text as the partner that must pass. Exit 0 only if every check is as expected.
"""
import subprocess
import sys

FROZEN = [
    "Proofs/HadwigerNelson/Plane/Saturated/Basic.lean",
    "Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean",
    "Proofs/HadwigerNelson/Plane/Saturated/MapColouring.lean",
    "Proofs/HadwigerNelson/Plane/Saturated/Fan.lean",
    "Proofs/HadwigerNelson/Plane/Saturated/Curve.lean",
    "Proofs/HadwigerNelson/Plane/Saturated/LocalGraph.lean",
]
PROOF = [
    "Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean",
    "Proofs/HadwigerNelson/Plane/Saturated/FanExamples.lean",
]


def base_text(base, path):
    return subprocess.run(["git", "show", f"{base}:{path}"], check=True, capture_output=True, text=True).stdout


def survives(base, cur):
    """Violations: base lines that do not survive, in order, in `cur` (see the module docstring)."""
    cur_lines = cur.split("\n")
    pos = 0
    bad = []
    for n, line in enumerate(base.split("\n"), 1):
        if line.strip() == "sorry":
            # a sorry may stay or go
            if pos < len(cur_lines) and cur_lines[pos].strip() == "sorry":
                pos += 1
            continue
        alts = [line]
        if line.endswith(":= by"):
            alts.append(line[: -len(" by")])
        if line.endswith(" -/"):
            alts.append(line[: -len(" -/")])  # a docstring continued by added lines (an inhabitant note)
        found = None
        for k in range(pos, len(cur_lines)):
            if cur_lines[k] in alts:
                found = k
                break
        if found is None:
            bad.append((n, line))
        else:
            pos = found + 1
    return bad


def check(base, texts=None, quiet=False):
    fails = 0
    for path in FROZEN:
        cur = open(path).read()
        if cur != base_text(base, path):
            fails += 1
            if not quiet:
                print(f"FAIL frozen file changed: {path}")
    for path in PROOF:
        cur = texts[path] if texts and path in texts else open(path).read()
        bad = survives(base_text(base, path), cur)
        for n, line in bad:
            fails += 1
            if not quiet:
                print(f"FAIL {path}: base line {n} does not survive: {line[:110]}")
    return fails


def self_test(base):
    fb = PROOF[0]
    cur = open(fb).read()
    plants = {
        "bound changed": ("  le : R ≤ 1 / 2", "  le : R ≤ 1"),
        "hypothesis deleted": ("    (hsat : SaturatedOn c.cls (ball z R \\ {z})) : Nonempty (c.Fan z)", "    : Nonempty (c.Fan z)"),
        "docstring changed": ("punctured disc through `y` is the image of `(0, L)`", "punctured disc through `y` is the image of `[0, L]`"),
    }
    ok = True
    if check(base, quiet=True) != 0:
        print("SELF-TEST partner: the unplanted tree must pass and does not")
        ok = False
    else:
        print("self-test partner (unplanted): passes, as it must")
    for name, (old, new) in plants.items():
        if cur.count(old) != 1:
            print(f"SELF-TEST {name}: anchor not found exactly once — the control cannot fire")
            ok = False
            continue
        n = check(base, texts={fb: cur.replace(old, new)}, quiet=True)
        if n == 0:
            print(f"SELF-TEST {name}: planted and NOT caught")
            ok = False
        else:
            print(f"self-test {name}: fires ({n} line(s))")
    return ok


def main():
    base = "32f2ab4c"
    if "--base" in sys.argv:
        base = sys.argv[sys.argv.index("--base") + 1]
    if "--self-test" in sys.argv:
        ok = self_test(base)
        print("SELF-TEST", "OK" if ok else "FAILED")
        sys.exit(0 if ok else 1)
    n = check(base)
    print(f"statements against {base}: {len(FROZEN)} frozen files, {len(PROOF)} proof files — "
          + ("OK, nothing changed but proof bodies and added lines" if n == 0 else f"{n} FAILURE(S)"))
    sys.exit(0 if n == 0 else 1)


if __name__ == "__main__":
    main()
