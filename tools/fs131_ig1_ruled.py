#!/usr/bin/env python3
"""FS131-IG1 — the two ruled differences in `Rigidity/Pieces`' stored statements, each shown to be exactly what was ruled
and nothing else, from two outputs of `data/fs131/ig1/lean/StatementDump.lean` (before any edit, after the build):

1. `exists_pieceChain` (the coordinator's ruling, option (a)): the stored type after is the stored type before with the
   one bound name `fun (hM : ` renamed `fun (_hM : `, and nothing else; the kernel's hash of the type is unchanged
   (`Expr.hash` does not read binder names).
2. `isSolenoid_pieceDual` (inventory item 726's standing word, an unread binder dropped): the stored type after is the
   stored type before with the hypothesis removed — printed `, (HadwigerNelson.Rigidity.IsPiece F p M) -> (BODY)`, an
   arrow because the body never read it, so after `, BODY` — and the section variable `{p : …AdmissiblePair F} ` that
   only it read, and nothing else.

3. `isErgodicOn_map_toPiece`, `integral_eq_zero_of_isAddHaarMeasure` (item 726's word; the lint's `unusedArguments`
   named them): the stored type after is the stored type before with the one instance binder
   `[… : MeasureTheory.IsProbabilityMeasure …]` removed, and nothing else.

`--control`: plants a change of one character in each after-type (in memory) and requires every check to fail.
Exit 0 when both hold (or, under --control, both fail); 1 otherwise; 2 if a type is missing (a broken dump).
Prints no type (each is tens of kilobytes): lengths, counts and verdicts only.
Usage: fs131_ig1_ruled.py <before.txt> <after.txt> [--control]
"""
import sys

NS = "HadwigerNelson.Rigidity."


def types(path, names):
    out, want = {}, None
    for ln in open(path, encoding="utf-8"):
        if ln.startswith("@@ "):
            parts = ln.split()
            want = parts[2] if parts[2] in names else None
        elif want and ln.startswith("TYPE "):
            h, t = ln[5:].rstrip("\n").split(" ", 1)
            out[want] = (h, t)
            want = None
    for n in names:
        if n not in out:
            print(f"BROKEN: {n} has no TYPE line in {path}")
            sys.exit(2)
    return out


ARROW = ", (HadwigerNelson.Rigidity.IsPiece F p M) -> ("


def drop_binder(t):
    """`…, (IsPiece F p M) -> (BODY)` becomes `…, BODY`: the arrow and the body's parentheses removed"""
    if t.count(ARROW) != 1 or not t.endswith(")"):
        return None
    return t.replace(ARROW, ", ")[:-1]


def main():
    control = "--control" in sys.argv
    a, b = [x for x in sys.argv[1:] if not x.startswith("--")]
    inst = [NS + "isErgodicOn_map_toPiece", NS + "integral_eq_zero_of_isAddHaarMeasure"]
    names = [NS + "exists_pieceChain", NS + "isSolenoid_pieceDual"] + inst
    before, after = types(a, names), types(b, names)
    if control:
        for n in names:
            h, t = after[n]
            after[n] = (h, t[:-1] + ("X" if t[-1] != "X" else "Y"))
    bad = 0
    n = NS + "exists_pieceChain"
    (hb, tb), (ha, ta) = before[n], after[n]
    k = tb.count("fun (hM : ")
    ok1 = k == 1 and ta == tb.replace("fun (hM : ", "fun (_hM : ") and ha == hb
    print(f"{'SAME UP TO THE RULED NAME' if ok1 else 'DIFFERS'} {n}: occurrences of the bound name {k}; "
          f"lengths {len(tb)} -> {len(ta)}; hash {hb} -> {ha}")
    bad += not ok1
    n = NS + "isSolenoid_pieceDual"
    (hb, tb), (ha, ta) = before[n], after[n]
    pvar = "{p : HadwigerNelson.Rigidity.AdmissiblePair F} "
    t1 = drop_binder(tb)
    ok2 = t1 is not None and tb.count(pvar) == 1 and t1.replace(pvar, "") == ta and ha != hb
    print(f"{'SAME UP TO THE DROPPED BINDER' if ok2 else 'DIFFERS'} {n}: lengths {len(tb)} -> {len(ta)}; "
          f"after removing the binder and `p`: {len(t1.replace(pvar, '')) if t1 else 'binder not found'}")
    bad += not ok2
    for n in inst:
        (hb, tb), (ha, ta) = before[n], after[n]
        key = " : MeasureTheory.IsProbabilityMeasure"
        ok3 = tb.count(key) == 1 and ta.count(key) == 0
        if ok3:
            i = tb.rfind("[", 0, tb.index(key))
            depth, j = 0, i
            while True:
                depth += (tb[j] == "[") - (tb[j] == "]")
                j += 1
                if depth == 0:
                    break
            t3 = tb[:i - 1] + tb[j:] if tb[i - 1] == " " else None  # " [inst : …]" and the space before it
            ok3 = t3 == ta
        print(f"{'SAME UP TO THE DROPPED INSTANCE' if ok3 else 'DIFFERS'} {n}: lengths {len(tb)} -> {len(ta)}")
        bad += not ok3
    if control:
        print(f"CONTROL: {bad} of {len(names)} planted changes reported — "
              f"{'the check can fail' if bad == len(names) else 'DID NOT FIRE'}")
        sys.exit(0 if bad == len(names) else 1)
    print("PASS" if not bad else f"FAIL ({bad})")
    sys.exit(0 if not bad else 1)


if __name__ == "__main__":
    main()
