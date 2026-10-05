#!/usr/bin/env python3
"""FS131-QA3: the census of the definitions audit — every definition (def/abbrev/structure/inductive/class) and every
theorem in the audited modules of waves 4 and 5, read from git refs (never a worktree), with branch, path and line.

Reuses FS131-QA1's parser (`tools/fs131_qa1_decls.py`, imported read-only).

Usage:
  fs131_qa3_census.py list            TSV on stdout: ref, module, kind, name, line, signature (truncated)
  fs131_qa3_census.py check <tsv>     every row of <tsv> (a committed census) still names a declaration at its ref; exit 1 on a miss
  fs131_qa3_census.py --self-test     planted controls; exit 1 on any miss
"""
import importlib.util
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location("qa1", os.path.join(HERE, "fs131_qa1_decls.py"))
qa1 = importlib.util.module_from_spec(spec)
spec.loader.exec_module(qa1)

P = "Proofs/HadwigerNelson/Plane/"
V = P + "ValidMap/"
# (ref, module path): wave 5 first, then wave 4's three branches
AUDITED = [
    ("fs131-w5", V + "Chain.lean"), ("fs131-w5", V + "Terminal.lean"), ("fs131-w5", V + "Dense.lean"),
    ("fs131-w5", V + "HexRing.lean"), ("fs131-w5", V + "MapGraph.lean"), ("fs131-w5", V + "BaseWalk.lean"),
    ("fs131-w5", V + "BaseDense.lean"),
    ("fs131-w4", V + "Basic.lean"), ("fs131-w4", V + "Sectors.lean"), ("fs131-w4", V + "UnitArc.lean"),
    ("fs131-w4", V + "BaseSteps.lean"), ("fs131-w4", P + "SVMap.lean"), ("fs131-w4", P + "StuckChain.lean"),
    ("fs131-w4c", V + "Contact.lean"), ("fs131-w4m", V + "Moves.lean"), ("fs131-w4m", V + "Cone.lean"),
]
DEF_KINDS = {"def", "abbrev", "structure", "inductive", "class"}


def census(sources=None):
    rows = []
    for ref, path in AUDITED:
        text = sources.get((ref, path)) if sources is not None else qa1.git_show(ref, path)
        if text is None:
            rows.append((ref, path, "MISSING", "-", 0, ""))
            continue
        for d in qa1.parse(text):
            if d["kind"] in DEF_KINDS or d["kind"] in ("theorem", "lemma"):
                rows.append((ref, path, d["kind"], d["name"], d["line"], d["sig"][:160]))
    return rows


def main():
    if len(sys.argv) >= 2 and sys.argv[1] == "--self-test":
        return self_test()
    if len(sys.argv) >= 2 and sys.argv[1] == "list":
        for r in census():
            print("\t".join(str(x) for x in r))
        return 0
    if len(sys.argv) == 3 and sys.argv[1] == "check":
        have = {(r[0], r[1], r[3]) for r in census()}
        bad = 0
        for ln in open(sys.argv[2]):
            f = ln.rstrip("\n").split("\t")
            if len(f) < 4:
                continue
            if (f[0], f[1], f[3]) not in have:
                print("MISSING", f[0], f[1], f[3]); bad += 1
        print("check:", "OK" if bad == 0 else f"FAIL ({bad})")
        return 1 if bad else 0
    print(__doc__)
    return 2


def self_test():
    fails = 0
    base = ("/-- doc -/\ndef Foo (x : Nat) : Prop := x = x\n\n/-- s -/\nstructure Bar where\n  a : Nat\n\n"
            "theorem baz : True := trivial\n/-- not a decl\ndef Hidden : Prop := True\n-/\n")
    src = {k: "" for k in AUDITED}
    src[AUDITED[0]] = base
    names = {r[3] for r in census(src)}
    # control 1: the three real declarations are found
    for n in ("Foo", "Bar", "baz"):
        if n not in names:
            print("self-test FAIL: missed", n); fails += 1
    # control 2: a def inside a block comment is not a declaration
    if "Hidden" in names:
        print("self-test FAIL: counted a commented def"); fails += 1
    # control 3 (plant): drop `Foo` from the source; it must disappear
    src[AUDITED[0]] = base.replace("def Foo (x : Nat) : Prop := x = x\n", "")
    if "Foo" in {r[3] for r in census(src)}:
        print("self-test FAIL: planted removal not seen"); fails += 1
    # control 4: a missing module is reported, not silently skipped
    src2 = dict(src); src2[AUDITED[1]] = None
    if not any(r[2] == "MISSING" for r in census(src2)):
        print("self-test FAIL: missing module not reported"); fails += 1
    print("self-test:", "OK (4 controls)" if fails == 0 else f"FAIL ({fails})")
    return 1 if fails else 0


if __name__ == "__main__":
    sys.exit(main())
