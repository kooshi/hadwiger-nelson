#!/usr/bin/env python3
"""FS131-I5e: check that `cor3` moved verbatim (inventory item 299 (a)).

Extracts the declaration `theorem cor3` — its docstring, statement and body, from the `/--` that opens its docstring to the line
before the next top-level item — from the old module at a git ref and from the new module in the working tree, and compares the two
byte for byte. Also checks that the old module no longer declares it in the working tree, and that exactly one file under `Proofs/`
declares it.

Usage: fs131_i5_cor3_move.py [--ref a804de21] [--self-test]
Exit 0 only when every check passes; any failure prints FAIL lines and exits 1.
"""
import pathlib
import re
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
OLD = "Proofs/HadwigerNelson/Plane/ValidMap/Dense.lean"
NEW = "Proofs/HadwigerNelson/Plane/ValidMap/Cor3.lean"
NAME = "cor3"


def extract(text: str, name: str) -> str:
    """The block from the docstring opening before `theorem <name> ` to the end of its body (the line before the next blank line
    that is followed by a top-level item, or the next top-level item)."""
    lines = text.splitlines(keepends=True)
    decl = [i for i, l in enumerate(lines) if re.match(rf"^theorem {re.escape(name)}[ \n]", l)]
    if len(decl) != 1:
        raise ValueError(f"expected one `theorem {name}`, found {len(decl)}")
    d = decl[0]
    # back up to the docstring's opening `/--`
    s = d - 1
    while s >= 0 and not lines[s].startswith("/--"):
        s -= 1
    if s < 0:
        raise ValueError("no docstring above the declaration")
    # forward to the next top-level item (a line starting with a non-space, non-`--` token) after the body
    t = d + 1
    while t < len(lines):
        l = lines[t]
        if l.strip() == "" or l.startswith(" ") or l.startswith("\t"):
            t += 1
            continue
        break
    # drop trailing blank lines
    while t > d and lines[t - 1].strip() == "":
        t -= 1
    return "".join(lines[s:t])


def git_show(ref: str, path: str) -> str:
    return subprocess.run(["git", "-C", str(ROOT), "show", f"{ref}:{path}"], check=True, capture_output=True,
                          text=True).stdout


def check(old_text: str, new_text: str, old_now: str, proofs_hits: list) -> list:
    fails = []
    try:
        a = extract(old_text, NAME)
    except ValueError as ex:
        return [f"old module at the ref: {ex}"]
    try:
        b = extract(new_text, NAME)
    except ValueError as ex:
        return [f"new module: {ex}"]
    if a != b:
        fails.append("the block differs (docstring, statement or body)")
        al, bl = a.splitlines(), b.splitlines()
        for i, (x, y) in enumerate(zip(al, bl)):
            if x != y:
                fails.append(f"  first difference at block line {i + 1}:\n    old: {x!r}\n    new: {y!r}")
                break
        else:
            fails.append(f"  lengths differ: {len(al)} vs {len(bl)} lines")
    if re.search(rf"^theorem {NAME}[ \n]", old_now, re.M):
        fails.append(f"the old module still declares `{NAME}`")
    if len(proofs_hits) != 1:
        fails.append(f"expected one declaration of `{NAME}` under Proofs/, found {len(proofs_hits)}: {proofs_hits}")
    if not fails:
        print(f"block: {len(a.splitlines())} lines, {len(a.encode())} bytes, identical")
    return fails


def proofs_declarations() -> list:
    hits = []
    for p in (ROOT / "Proofs").rglob("*.lean"):
        if re.search(rf"^theorem {NAME}[ \n]", p.read_text(), re.M):
            hits.append(str(p.relative_to(ROOT)))
    return hits


def main(argv):
    ref = "a804de21"
    if "--ref" in argv:
        ref = argv[argv.index("--ref") + 1]
    old_text = git_show(ref, OLD)
    new_text = (ROOT / NEW).read_text()
    old_now = (ROOT / OLD).read_text()
    hits = proofs_declarations()
    if "--self-test" in argv:
        # each planted fault must fire; the unplanted run must pass
        base = check(old_text, new_text, old_now, hits)
        ok = not base
        print(f"control (as is): {'PASS' if not base else 'FAIL'}")
        plants = {
            "one byte in the statement": (old_text, new_text.replace("hd : dist u u' < 2", "hd : dist u u' ≤ 2", 1), old_now, hits),
            "one byte in the docstring": (old_text, new_text.replace("FS112-STOP's object", "FS112-STOP object", 1),
                                          old_now, hits),
            "the body changed": (old_text, new_text.replace(":= by\n  sorry", ":= by\n  exact sorry", 1), old_now, hits),
            "still in the old module": (old_text, new_text, old_text, hits),
            "declared twice": (old_text, new_text, old_now, hits + ["planted"]),
        }
        for label, args in plants.items():
            if args[1] == new_text and label in ("one byte in the statement", "one byte in the docstring", "the body changed"):
                print(f"plant '{label}': COULD NOT PLANT (pattern absent)")
                ok = False
                continue
            f = check(*args)
            fired = bool(f)
            print(f"plant '{label}': {'fired' if fired else 'DID NOT FIRE'}")
            ok = ok and fired
        print("SELF-TEST", "PASS" if ok else "FAIL")
        return 0 if ok else 1
    fails = check(old_text, new_text, old_now, hits)
    for f in fails:
        print("FAIL", f)
    print("PASS" if not fails else "FAIL")
    return 0 if not fails else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
