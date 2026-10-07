#!/usr/bin/env python3
"""FS124-I1: no statement of the skeleton changed — checked on the stored terms, not on the files' text.

Compares two prints made by `data/fs124/i1/lean/Statements.lean` (one line per constant of the three modules:
kind, full name, `Expr.hash` of the stored type, `Expr.hash` of a definition's value, the type pretty-printed):

    statements_check.py <before.txt> <after.txt>

Every row of <before> must be in <after> character for character, except rows whose name the elaborator
generates on demand inside a proof (`._simp_N_M`, `._proof_N`, `.match_N`, …): those belong to proofs, which
this job changes, and are listed, not compared.  Names in <after> that <before> lacks are listed (helpers).
Exit 0 iff every compared row is identical and at least 57 theorems and 3 definitions were compared.

`--control` plants two faults in a copy of <after> — one digit of one theorem's type hash changed, one
definition's row removed — and exits 0 iff both are reported and nothing else is.
"""
import re, sys

GENERATED = re.compile(r"(\._simp_\d+_\d+|\._proof_\d+(_\d+)?|\.match_\d+|\._auxLemma\.\d+|\.congr_simp|\._eq_\d+)$")

def rows(path_or_text, is_text=False):
    text = path_or_text if is_text else open(path_or_text).read()
    out = {}
    for ln in text.splitlines():
        if ln.startswith("TOTAL ") or " | type-hash " not in ln:
            continue
        head = ln.split(" | ", 1)[0]
        kind, name = head.split(" ", 1)
        out[name] = (kind, ln)
    return out

def compare(before, after):
    fails, compared, skipped = [], {"theorem": 0, "def": 0, "other": 0}, []
    for name, (kind, ln) in sorted(before.items()):
        if GENERATED.search(name):
            skipped.append(name); continue
        if name not in after:
            fails.append(f"MISSING  {name}")
        elif after[name][1] != ln:
            fails.append(f"CHANGED  {name}\n    before: {ln}\n    after:  {after[name][1]}")
        compared[kind if kind in ("theorem", "def") else "other"] += 1
    new = sorted(n for n in after if n not in before)
    return fails, compared, skipped, new

def main():
    control = "--control" in sys.argv
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    before = rows(args[0])
    after_text = open(args[1]).read()
    if control:
        lines = after_text.splitlines()
        # fault 1: the first non-generated theorem row gets one digit of its type hash changed
        i = next(j for j, l in enumerate(lines)
                 if l.startswith("theorem ") and not GENERATED.search(l.split(" | ")[0]))
        m = re.search(r"type-hash (\d)", lines[i])
        d = m.group(1)
        lines[i] = lines[i][:m.start(1)] + ("1" if d != "1" else "2") + lines[i][m.end(1):]
        name1 = lines[i].split(" | ")[0].split(" ", 1)[1]
        # fault 2: the first definition's row is removed (`monoPairSet`, `AeProperOn`, … — never a generated one)
        k = next(j for j, l in enumerate(lines)
                 if l.startswith("def ") and "casesOn" not in l and "recOn" not in l and "_flat_ctor" not in l)
        name2 = lines[k].split(" | ")[0].split(" ", 1)[1]
        del lines[k]
        fails, *_ = compare(before, rows("\n".join(lines), is_text=True))
        got = sorted(f.split()[1] for f in fails)
        ok = got == sorted([name1, name2])
        print(f"control: planted CHANGED at {name1}, MISSING at {name2}; reported: {got}")
        print("control: OK — both faults reported and nothing else" if ok else "control: FAILED")
        sys.exit(0 if ok else 1)
    after = rows(after_text, is_text=True)
    fails, compared, skipped, new = compare(before, after)
    for f in fails:
        print("FAIL " + f)
    print(f"compared: {compared['theorem']} theorems, {compared['def']} definitions, {compared['other']} other "
          f"(structure, constructor, recursor); identical: {sum(compared.values()) - len(fails)}")
    print(f"generated inside proofs, not compared ({len(skipped)}): {', '.join(skipped) if skipped else 'none'}")
    print(f"names the job added ({len(new)}): {', '.join(new) if new else 'none'}")
    enough = compared["theorem"] >= 57 and compared["def"] >= 3
    if not enough:
        print("FAIL too few rows compared: the reader is broken")
    sys.exit(0 if (not fails and enough) else 1)

if __name__ == "__main__":
    main()
