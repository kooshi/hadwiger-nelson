#!/usr/bin/env python3
"""FS131-IG1 (FS131-IDG1's `tools/fs131_idg1_docdump_diff.py`, aimed here) — a docstring edit moved no stored constant:
two outputs of `data/fs131/ig1/lean/DocDump.lean` (every constant of `Rigidity/DualGroup`, `Annihilator`, `SubgroupHaar`,
`Duality`, `DualConnected`, `UnitCircle`, `ZeroEntropyNames`: its head line, stored type, value, data view, and for a
theorem the hash of its proof), before and after the build that recompiles the seven modules, must be identical line
for line — internal constants and proofs included, since nothing but prose changed.

`--control`: plants three faults in the second dump in memory (one character of a stored type, a constant removed, a
constant added) and requires all three to be reported; exit 0 then, 1 otherwise.

Usage: fs131_ig1_docdump_diff.py <before.txt> <after.txt> [--control]
"""
import sys


def read(path):
    out, cur, order = {}, None, []
    mods = 0
    for ln in open(path, encoding="utf-8").read().splitlines():
        if ln.startswith("## MODULE"):
            mods += 1
        elif ln.startswith("@@ "):
            cur = ln.split(" ")[2]
            if cur in out:
                print(f"DUPLICATE {cur} in {path}")
                sys.exit(2)
            out[cur] = [ln]
            order.append(cur)
        elif cur is not None and ln.split(" ", 1)[0] in ("TYPE", "VALUE", "DATA", "PROOF"):
            out[cur].append(ln)
    if mods != 7 or not out:
        print(f"BROKEN DUMP {path}: {mods} modules, {len(out)} constants")
        sys.exit(2)
    return out


def main():
    control = "--control" in sys.argv
    a, b = [x for x in sys.argv[1:] if not x.startswith("--")]
    before, after = read(a), read(b)
    if control:
        k = sorted(after)[0]
        t = after[k][1]
        after[k][1] = t[:-1] + ("X" if t[-1] != "X" else "Y")
        del after[sorted(after)[1]]
        after["planted.added"] = ["@@ THM planted.added", "TYPE 0 True"]
    bad = []
    for n, lines in before.items():
        if n not in after:
            bad.append(f"MISSING {n}")
        elif after[n] != lines:
            bad.append(f"DIFFERS {n}")
    for n in after:
        if n not in before:
            bad.append(f"ADDED   {n}")
    print(f"constants: {len(before)} before, {len(after)} after; differing, missing or added: {len(bad)}")
    for x in bad[:20]:
        print(x)
    if control:
        ok = len(bad) == 3
        print(f"CONTROL: {len(bad)} of 3 planted faults reported — {'the check can fail' if ok else 'DID NOT FIRE'}")
        sys.exit(0 if ok else 1)
    print("PASS: identical" if not bad else "FAIL")
    sys.exit(0 if not bad else 1)


if __name__ == "__main__":
    main()
