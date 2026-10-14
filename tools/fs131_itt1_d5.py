#!/usr/bin/env python3
"""FS131-ITT1 — the drafts D5 changed docstrings only: every constant `data/fs131/itt1/lean/StatementDumpD5.lean` prints
for `Rigidity/Entropy` and `Rigidity/EntropySplitMax` (kind, full name, flags, stored type, value, DATA view) is the same,
line for line, in the dump made before the build that recompiled them and the one after (a docstring is not among those
lines). Usage: fs131_itt1_d5.py <before> <after> [--plant]   --plant changes one character of one stored type in memory
and must be reported. Exit 0: SAME (or, with --plant, the plant reported); 1 otherwise; 2: a dump is empty or broken."""
import sys


def read(path):
    out, cur, mods = {}, None, 0
    for ln in open(path, encoding="utf-8"):
        ln = ln.rstrip("\n")
        if ln.startswith("## MODULE "):
            mods += 1
        elif ln.startswith("@@ "):
            cur = ln
            if cur in out:
                print(f"DUPLICATE {cur[:120]}"); sys.exit(2)
            out[cur] = []
        elif cur is not None and ln.split(" ", 1)[0] in ("TYPE", "VALUE", "DATA"):
            out[cur].append(ln)
    if mods != 2 or not out or any(not v for v in out.values()):
        print(f"BROKEN DUMP {path}: modules={mods} constants={len(out)}"); sys.exit(2)
    return out


a, b = read(sys.argv[1]), read(sys.argv[2])
if "--plant" in sys.argv:
    k = next(k for k in b if "ksEntropy_eq_iSup_ksEntropyOn" in k)
    t = b[k][0]
    b[k] = [t[:40] + ("Y" if t[40] != "Y" else "Z") + t[41:]] + b[k][1:]
diff = sorted(k for k in set(a) | set(b) if a.get(k) != b.get(k))
print(f"constants: {len(a)} before, {len(b)} after; differing: {len(diff)}")
for k in diff:
    print(f"  DIFFERS {k[:160]}")
if "--plant" in sys.argv:
    ok = len(diff) == 1
    print("CONTROL: the plant is reported" if ok else "CONTROL DID NOT FIRE AS PLANTED")
    sys.exit(0 if ok else 1)
print("SAME: no stored statement or definition changed" if not diff else "FAIL")
sys.exit(0 if not diff else 1)
