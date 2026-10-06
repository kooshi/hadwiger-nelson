#!/usr/bin/env python3
"""FS131-I5q: check that `bv_l3` moved with its statement verbatim (inventory item 370 (a)), and that `l3_base` kept its own.

`bv_l3` leaves `Plane/ValidMap/HexRing` (where it was a `sorry`) for `Plane/ValidMap/BaseWalk`, after `BaseCtx.l3_base`, where it is
proved; `l3_base`'s argument is extracted into `l3_core`, its statement unchanged. The checks, on statements — the text from
`theorem <name>` to the `:= by` that opens the body, byte for byte:

1. `bv_l3`'s statement in the old module at the git ref equals its statement in the new module in the working tree;
2. the old module no longer declares `bv_l3` in the working tree, and exactly one file under `Proofs/` declares it;
3. in the new module `bv_l3` is declared after `BaseCtx.l3_base`;
4. `BaseCtx.l3_base`'s statement in the new module at the ref equals its statement in the working tree;
5. `bv_l3`'s body in the working tree holds no `sorry`.

The docstring and the body are free (the body was `sorry`; the docstring may gain the proof's route).

Usage: fs131_i5_bvl3_move.py [--ref 3b120cd3] [--self-test]
Exit 0 only when every check passes; any failure prints FAIL lines and exits 1.
"""
import pathlib
import re
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
OLD = "Proofs/HadwigerNelson/Plane/ValidMap/HexRing.lean"
NEW = "Proofs/HadwigerNelson/Plane/ValidMap/BaseWalk.lean"
NAME = "bv_l3"
KEPT = "BaseCtx.l3_base"


def decl_lines(text: str, name: str) -> list:
    return [i for i, l in enumerate(text.splitlines()) if re.match(rf"^theorem {re.escape(name)}[ \n]", l + "\n")]


def statement(text: str, name: str) -> str:
    """From `theorem <name>` to the first `:= by` at the end of a line (the body's opening), inclusive."""
    lines = text.splitlines(keepends=True)
    d = decl_lines(text, name)
    if len(d) != 1:
        raise ValueError(f"expected one `theorem {name}`, found {len(d)}")
    t = d[0]
    while t < len(lines) and not lines[t].rstrip().endswith(":= by"):
        t += 1
    if t == len(lines):
        raise ValueError(f"`theorem {name}`: no `:= by` found")
    return "".join(lines[d[0]:t + 1])


def body(text: str, name: str) -> str:
    """The indented lines after the statement, to the next top-level item."""
    lines = text.splitlines(keepends=True)
    d = decl_lines(text, name)[0]
    t = d
    while not lines[t].rstrip().endswith(":= by"):
        t += 1
    s = t + 1
    t = s
    while t < len(lines) and (lines[t].strip() == "" or lines[t].startswith(" ") or lines[t].startswith("\t")):
        t += 1
    return "".join(lines[s:t])


def git_show(ref: str, path: str) -> str:
    return subprocess.run(["git", "-C", str(ROOT), "show", f"{ref}:{path}"], check=True, capture_output=True,
                          text=True).stdout


def proofs_declarations() -> list:
    hits = []
    for p in sorted((ROOT / "Proofs").rglob("*.lean")):
        if re.search(rf"^theorem {NAME}[ \n]", p.read_text(), re.M):
            hits.append(str(p.relative_to(ROOT)))
    return hits


def check(old_ref: str, new_ref: str, new_now: str, old_now: str, hits: list) -> list:
    fails = []
    try:
        a = statement(old_ref, NAME)
    except ValueError as ex:
        return [f"old module at the ref: {ex}"]
    try:
        b = statement(new_now, NAME)
    except ValueError as ex:
        return [f"new module: {ex}"]
    if a != b:
        fails.append(f"`{NAME}`'s statement differs")
        for i, (x, y) in enumerate(zip(a.splitlines(), b.splitlines())):
            if x != y:
                fails.append(f"  first difference at statement line {i + 1}:\n    old: {x!r}\n    new: {y!r}")
                break
        else:
            fails.append(f"  lengths differ: {len(a.splitlines())} vs {len(b.splitlines())} lines")
    if decl_lines(old_now, NAME):
        fails.append(f"the old module still declares `{NAME}`")
    if len(hits) != 1:
        fails.append(f"expected one declaration of `{NAME}` under Proofs/, found {len(hits)}: {hits}")
    k = decl_lines(new_now, KEPT)
    n = decl_lines(new_now, NAME)
    if len(k) != 1:
        fails.append(f"expected one `theorem {KEPT}` in the new module, found {len(k)}")
    elif n and n[0] < k[0]:
        fails.append(f"`{NAME}` (line {n[0] + 1}) is declared before `{KEPT}` (line {k[0] + 1})")
    try:
        if statement(new_ref, KEPT) != statement(new_now, KEPT):
            fails.append(f"`{KEPT}`'s statement differs from the ref's")
    except ValueError as ex:
        fails.append(f"`{KEPT}`: {ex}")
    if re.search(r"\bsorry\b", body(new_now, NAME)):
        fails.append(f"`{NAME}`'s body holds a `sorry`")
    if not fails:
        print(f"`{NAME}`: statement {len(a.splitlines())} lines, {len(a.encode())} bytes, identical; after `{KEPT}`; "
              f"`{KEPT}`'s statement identical; no `sorry` in the body")
    return fails


def main(argv):
    ref = "3b120cd3"
    if "--ref" in argv:
        ref = argv[argv.index("--ref") + 1]
    old_ref = git_show(ref, OLD)
    new_ref = git_show(ref, NEW)
    new_now = (ROOT / NEW).read_text()
    old_now = (ROOT / OLD).read_text()
    hits = proofs_declarations()
    if "--self-test" in argv:
        base = check(old_ref, new_ref, new_now, old_now, hits)
        ok = not base
        print(f"control (as is): {'PASS' if not base else 'FAIL'}")
        for f in base:
            print("  ", f)
        st = statement(new_now, NAME)
        kept = statement(new_now, KEPT)

        def swap(text, block, a, b):
            assert a in block, a
            return text.replace(block, block.replace(a, b, 1), 1)

        # `bv_l3` moved in front of `l3_base`: cut its statement-and-body and paste it before `l3_base`'s statement
        blk = st + body(new_now, NAME)
        before = new_now.replace(blk, "", 1).replace(kept, blk + "\n" + kept, 1)
        plants = {
            "a hypothesis of bv_l3 changed": (old_ref, new_ref, swap(new_now, st, "(ht' : dist u₁ u₂ < 2)", "(ht' : dist u₁ u₂ ≤ 2)"),
                                              old_now, hits),
            "a hypothesis of bv_l3 dropped": (old_ref, new_ref, swap(new_now, st, " (hR₂ : F.RingProper u₂)", ""), old_now, hits),
            "bv_l3's conclusion changed": (old_ref, new_ref, swap(new_now, st, ": False := by", ": True := by"), old_now, hits),
            "still in the old module": (old_ref, new_ref, new_now, old_ref, hits),
            "declared twice": (old_ref, new_ref, new_now, old_now, hits + ["planted"]),
            "declared before l3_base": (old_ref, new_ref, before, old_now, hits),
            "l3_base's statement changed": (old_ref, new_ref, swap(new_now, kept, "(ht : 1 < dist u₁ u₂)", "(ht : 1 ≤ dist u₁ u₂)"),
                                            old_now, hits),
            "a sorry in bv_l3's body": (old_ref, new_ref, new_now.replace(st, st + "  have : True := by sorry\n", 1), old_now, hits),
        }
        for label, args in plants.items():
            f = check(*args)
            fired = bool(f)
            print(f"plant '{label}': {'fired' if fired else 'DID NOT FIRE'}" + (f" — {f[0]}" if fired else ""))
            ok = ok and fired
        print("SELF-TEST", "PASS" if ok else "FAIL")
        return 0 if ok else 1
    fails = check(old_ref, new_ref, new_now, old_now, hits)
    for f in fails:
        print("FAIL", f)
    print("PASS" if not fails else "FAIL")
    return 0 if not fails else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
