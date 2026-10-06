#!/usr/bin/env python3
"""FS131-IR1: read a `#print axioms` output against its source and against a stated expectation.

A record is `'<name>' depends on axioms: [a, b, ...]` (possibly wrapped over lines) or `'<name>' does not depend on any axioms`.
Names may hold primes (`foo'`): a name is read as a run of non-space characters between the opening quote and `' depends` /
`' does not` (FS131-IO2's classifier once dropped a primed name; the self-test plants one).

PASS (exit 0) only when: the number of records equals the number of `#print axioms` commands in the source; every command's name has
its record; no record holds an axiom outside the standard three and `sorryAx`; and the set of names through `sorryAx` is EXACTLY the
`--expect-sorry` list (comma-separated, short or full names; empty by default).

  python3 tools/fs131_ir_axsum.py <out> <source.lean> [--expect-sorry a,b,c]
  python3 tools/fs131_ir_axsum.py --self-test     # four plants, each must fail; the unplanted control must pass
"""
import re
import sys

STD = {"propext", "Classical.choice", "Quot.sound"}


def records(text):
    flat = re.sub(r"\n\s+", " ", text)
    out = {}
    for m in re.finditer(r"^'(\S+)' depends on axioms: \[([^\]]*)\]", flat, re.M):
        out[m.group(1)] = {a.strip() for a in m.group(2).split(",") if a.strip()}
    for m in re.finditer(r"^'(\S+)' does not depend on any axioms", flat, re.M):
        out[m.group(1)] = set()
    return out


def commands(src):
    return [m.group(1) for m in re.finditer(r"^#print axioms (\S+)", src, re.M)]


def judge(out_text, src_text, expect_sorry):
    recs, cmds = records(out_text), commands(src_text)
    lines, ok = [], True
    if len(recs) != len(cmds):
        ok = False
        lines.append(f"MISMATCH: {len(cmds)} print commands but {len(recs)} records")
    for c in cmds:
        if c not in recs:
            ok = False
            lines.append(f"NO RECORD for {c}")
    sor = sorted(n for n, a in recs.items() if "sorryAx" in a)
    oth = sorted((n, sorted(a - STD)) for n, a in recs.items() if not a <= STD | {"sorryAx"})
    std = sorted(n for n, a in recs.items() if a <= STD)
    for n, a in oth:
        ok = False
        lines.append(f"OTHER AXIOM {n} {a}")

    def match(short):
        return [n for n in recs if n == short or n.endswith("." + short)]
    want = set()
    for s in expect_sorry:
        got = match(s)
        if len(got) != 1:
            ok = False
            lines.append(f"EXPECTED-SORRY name {s} matches {len(got)} records")
        want.update(got)
    for n in sor:
        if n not in want:
            ok = False
            lines.append(f"SORRY-UNEXPECTED {n}")
    for n in sorted(want):
        if n not in sor:
            ok = False
            lines.append(f"SORRY-EXPECTED-BUT-STANDARD {n}")
    head = (f"records {len(recs)} (print commands {len(cmds)}): standard-three-or-fewer {len(std)}, through sorryAx {len(sor)}, "
            f"other {len(oth)}")
    return ok, [head, "THROUGH sorryAx:"] + [f"  {n}" for n in sor] + lines + ["PASS" if ok else "FAIL"]


def self_test():
    src = "#print axioms A.foo\n#print axioms A.bar'\n#print axioms A.baz\n"
    out = ("'A.foo' depends on axioms: [propext, Classical.choice, Quot.sound]\n"
           "'A.bar'' depends on axioms: [propext,\n Classical.choice]\n"
           "'A.baz' depends on axioms: [propext, sorryAx]\n")
    good = judge(out, src, ["baz"])[0]
    plants = {
        "sorryAx planted in a standard record": judge(out.replace("[propext, Classical.choice, Quot.sound]", "[propext, sorryAx]"), src, ["baz"])[0],
        "the primed record dropped": judge(out.replace("'A.bar'' depends on axioms: [propext,\n Classical.choice]\n", ""), src, ["baz"])[0],
        "a foreign axiom": judge(out.replace("[propext, sorryAx]", "[propext, sorryAx, Foo.ax]"), src, ["baz"])[0],
        "an expected sorry that is standard": judge(out, src, ["baz", "foo"])[0],
    }
    print("control (unplanted):", "PASS" if good else "FAIL")
    allfired = good
    for name, passed in plants.items():
        print(f"plant — {name}:", "FIRED" if not passed else "DID NOT FIRE")
        allfired = allfired and not passed
    print("SELF-TEST:", "ok" if allfired else "FAILED")
    sys.exit(0 if allfired else 1)


def main():
    if "--self-test" in sys.argv:
        self_test()
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    exp = []
    if "--expect-sorry" in sys.argv:
        v = sys.argv[sys.argv.index("--expect-sorry") + 1]
        exp = [x for x in v.split(",") if x]
        args = [a for a in args if a != v]
    ok, lines = judge(open(args[0]).read(), open(args[1]).read(), exp)
    print("\n".join(lines))
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
