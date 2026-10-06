#!/usr/bin/env python3
"""FS131-RP1 — read a `#print axioms` output against the records the Lean file asks for.

  fs131_rp_axioms.py LEAN OUT [--sorry NAME[,NAME]]
Every `#print axioms X` line of LEAN must have exactly one record in OUT.  A record is CLEAN when its axioms are a subset of
the standard three (`propext`, `Classical.choice`, `Quot.sound`); a name listed under --sorry MUST show `sorryAx` and nothing
else foreign (the control: the print is seen to show a `sorry` where one is known); any other foreign axiom fails.
Exit 0 iff every asked record is present once, every non-control record is CLEAN, and every control shows `sorryAx`.

  fs131_rp_axioms.py LEAN OUT [--sorry …] --self-test
plants, on a copy of OUT in memory: a record deleted; a clean record given `sorryAx`; a clean record given a native axiom;
the control's `sorryAx` removed; a record doubled.  Each must fail; the unplanted OUT must pass.
"""
import re
import sys
from pathlib import Path

STD = {"propext", "Classical.choice", "Quot.sound"}


def asked(lean):
    return re.findall(r"^#print axioms (\S+)", lean, re.M)


def records(out):
    recs = []
    for m in re.finditer(r"'([^']+)' depends on axioms: \[([^\]]*)\]", out, re.S):
        recs.append((m.group(1), {a.strip() for a in m.group(2).split(",") if a.strip()}))
    for m in re.finditer(r"'([^']+)' does not depend on any axioms", out):
        recs.append((m.group(1), set()))
    return recs


def check(lean, out, controls, quiet=False):
    names, recs, msgs, rows = asked(lean), records(out), [], []
    if not names:
        msgs.append("NO RECORD ASKED — a failure, not a pass")
    for n in names:
        got = [ax for (k, ax) in recs if k == n]
        if len(got) != 1:
            msgs.append(f"{'MISSING' if not got else 'DOUBLED'} {n} ({len(got)} records)")
            continue
        foreign = got[0] - STD
        if n in controls:
            if foreign != {"sorryAx"}:
                msgs.append(f"CONTROL-SILENT {n}: expected sorryAx, got {sorted(foreign) or 'the standard three'}")
            rows.append((n, "CONTROL sorryAx" if foreign == {"sorryAx"} else "CONTROL ?"))
        else:
            if foreign:
                msgs.append(f"FOREIGN {n}: {sorted(foreign)}")
            rows.append((n, "standard three" if not foreign else "FOREIGN " + ",".join(sorted(foreign))))
    for c in controls - set(names):
        msgs.append(f"CONTROL-NOT-ASKED {c}")
    if "error" in out:
        msgs.append("the output holds an error")
    if not quiet:
        for n, v in rows:
            print(f"{v:18s} {n}")
        for m in msgs:
            print(m)
        print(f"asked {len(names)}, records {len(recs)}, deviations {len(msgs)}")
    return msgs


def main(argv):
    if len(argv) < 3:
        print(__doc__)
        return 2
    lean, out = Path(argv[1]).read_text(), Path(argv[2]).read_text()
    controls = set(argv[argv.index("--sorry") + 1].split(",")) if "--sorry" in argv else set()
    if "--self-test" not in argv:
        return 1 if check(lean, out, controls) else 0
    if check(lean, out, controls, quiet=True):
        print("SELF-TEST FAILED: the unplanted output deviates")
        return 1
    names = [n for n in asked(lean) if n not in controls]
    a, ctl = names[0], sorted(controls)[0]
    rec = re.search(r"'" + re.escape(a) + r"' depends on axioms: \[[^\]]*\]", out, re.S).group(0)
    crec = re.search(r"'" + re.escape(ctl) + r"' depends on axioms: \[[^\]]*\]", out, re.S).group(0)
    plants = {
        "a record deleted": out.replace(rec, ""),
        "a clean record given sorryAx": out.replace(rec, rec[:-1] + ", sorryAx]"),
        "a clean record given a native axiom": out.replace(rec, rec[:-1] + ", Foo._native.native_decide.ax_1_1]"),
        "the control's sorryAx removed": out.replace(crec, crec.replace("sorryAx,", "").replace(", sorryAx", "")),
        "a record doubled": out + "\n" + rec + "\n",
    }
    ok = True
    for name, planted in plants.items():
        msgs = check(lean, planted, controls, quiet=True)
        print(f"plant '{name}': {'FIRED' if msgs else 'SILENT'} — {msgs[0] if msgs else ''}")
        ok = ok and bool(msgs) and planted != out
    print("SELF-TEST", "OK: 5 plants" if ok else "FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv))
