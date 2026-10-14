#!/usr/bin/env python3
"""FS131-ID1 — the skeleton's statements against the BUILT module's stored constants.

`skeleton` is the footer print of the skeleton at 34d9113b2 (data/fs131/id1/stmt/Skeleton.txt: the file elaborated at
the path data/fs131/id1/stmt/Copy.lean); `built` is the dump of the compiled module's own `.olean`
(lean/StatementDump.lean).  The two are printed from two paths, and an instance binder's stored NAME carries the
file's module name (`inst._@.<module>.<n>._hygCtx._hyg.<k>` — the tool defect FS131-IU1's record names).  A binder's
name is no part of a statement, so both texts are compared after THIS FILE'S two module names — `data.fs131.id1.stmt
.Copy` (the copy) and `Proofs.HadwigerNelson.Arith.DyadicQuadratic` (the module) — are rewritten to `M` inside that
pattern, and nowhere else (a hygienic name minted in a Mathlib module, `x._@.Mathlib.Data.FunLike.Basic…`, is the same
in both prints and is left alone); the number of statements the rewrite touched is printed, and Lean's own hash of
each stored type (which reads no binder name) is compared as it stands, unrewritten.  Every named constant of the
skeleton must be in the built module with the same kind, the same hash and the same rewritten text.

`--control` plants three faults in the built side (one character of a stored statement and its hash; one kind; one
declaration removed) and must report exactly three; a fourth control checks that the rewrite is not what makes the
texts agree: with the rewrite switched off the comparison must report a TEXT difference on every statement that
carries a binder name minted in this file, and on no other.
Usage: statements_built.py <Skeleton.txt> <statements-built.txt> [--control]
"""
import re, sys, pathlib

NS = "HadwigerNelson.DyadicQuadratic."
PAT = re.compile(r"_@\.(?:data\.fs131\.id1\.stmt\.Copy|Proofs\.HadwigerNelson\.Arith\.DyadicQuadratic)\.(\d+)\._hygCtx")


def read_dump(path):
    out, cur = {}, None
    for ln in pathlib.Path(path).read_text().splitlines():
        if ln.startswith("@@ "):
            parts = ln.split(" ")
            internal = parts[-1] == "INTERNAL"
            name = " ".join(parts[2:-1] if internal else parts[2:])
            cur = {"kind": parts[1], "internal": internal or name.startswith("_private."), "hash": None, "type": None}
            if name in out:
                print(f"DUPLICATE NAME IN DUMP {path}: {name}"); sys.exit(2)
            out[name] = cur
        elif ln.startswith("TYPE ") and cur is not None:
            h, _, raw = ln[5:].partition(" ")
            cur["hash"], cur["type"] = h, raw
    if not out:
        print(f"EMPTY DUMP: {path} — the reader or the dumper is broken"); sys.exit(2)
    return out


def compare(skel, built, rewrite=True):
    bad, touched = [], 0
    norm = (lambda t: PAT.sub(r"_@.M.\1._hygCtx", t)) if rewrite else (lambda t: t)
    n = 0
    for name, b in skel.items():
        if b["internal"]:
            continue
        n += 1
        a = built.get(name)
        if a is None:
            bad.append(f"MISSING  {b['kind']} {name}: in the skeleton, not in the built module"); continue
        if a["kind"] != b["kind"]:
            bad.append(f"KIND     {name}: {b['kind']} -> {a['kind']}")
        if a["hash"] != b["hash"]:
            bad.append(f"HASH     {b['kind']} {name}: Lean's hash of the stored statement differs")
        if PAT.search(b["type"]) or PAT.search(a["type"]):
            touched += 1
        if norm(a["type"]) != norm(b["type"]):
            bad.append(f"TEXT     {b['kind']} {name}: the stored statement's text differs")
    return n, touched, bad


def main():
    control = "--control" in sys.argv
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    skel, built = read_dump(args[0]), read_dump(args[1])
    if not control:
        n, touched, bad = compare(skel, built)
        new_pub = sorted(k for k, v in built.items() if k not in skel and not v["internal"])
        n_priv = sorted(k for k, v in built.items() if k.startswith("_private.") and not re.search(r"\._|\.(match|eq|proof)_\d", k.split(".0.", 1)[-1]))
        print(f"compared: {n} named constants of the skeleton against the built module ({len(built)} constants stored); "
              f"kind, Lean's hash, and text after the rewrite of this file's module name in binder names ({touched} statement(s) carry one)")
        print(f"named public constants in the built module that the skeleton does not hold: {len(new_pub)} {new_pub}")
        print(f"private declarations in the built module (helpers): {len(n_priv)}")
        for b in bad:
            print(b)
        print("PASS: the built module stores the skeleton's statements" if not bad and not new_pub else f"FAIL: {len(bad)} difference(s), {len(new_pub)} new public name(s)")
        sys.exit(1 if bad or new_pub else 0)
    # controls
    import copy
    b2 = copy.deepcopy(built)
    v = NS + "colorable_two_planeOver_sqrt"
    b2[v]["type"] = b2[v]["type"][:-1] + ("!" if b2[v]["type"][-1] != "!" else "?")
    b2[NS + "dyadic_shape_two_mod_four"]["kind"] = "AXIOM"
    del b2[NS + "exists_rat_add_mul_sqrt_eq"]
    _, _, bad = compare(skel, b2)
    ok1 = len(bad) == 3
    print(f"CONTROL 1: {len(bad)} of 3 planted faults reported — {'the check can fail' if ok1 else 'DID NOT FIRE AS PLANTED'}")
    for b in bad:
        print("  " + b)
    b3 = copy.deepcopy(built)
    b3[v]["hash"] = str(int(b3[v]["hash"]) + 1)
    _, _, bad = compare(skel, b3)
    ok2 = len(bad) == 1 and bad[0].startswith("HASH")
    print(f"CONTROL 2 (a hash moved by one): {len(bad)} reported — {'the hash is read' if ok2 else 'DID NOT FIRE AS PLANTED'}")
    n, touched, bad = compare(skel, built, rewrite=False)
    ok3 = len(bad) == touched and all(b.startswith("TEXT") for b in bad)
    print(f"CONTROL 3 (the rewrite off): {len(bad)} TEXT difference(s), {touched} statement(s) with a binder name minted in this file — "
          f"{'the rewrite touches those lines and only those' if ok3 else 'UNEXPECTED'}")
    sys.exit(0 if ok1 and ok2 and ok3 else 1)


if __name__ == "__main__":
    main()
