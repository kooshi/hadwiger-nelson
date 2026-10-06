#!/usr/bin/env python3
"""FS131-L5 — read a `#print axioms` output against the records a Lean file asks for, each on EXACTLY the standard three.

  fs131_l5_axioms.py LEAN OUT
Every `#print axioms X` line of LEAN must have exactly one record in OUT, and that record's axioms must be exactly
{propext, Classical.choice, Quot.sound} — not a subset, not a superset.  Exit 0 iff so, and OUT holds no `error`.

  fs131_l5_axioms.py LEAN OUT --before OUT0 --red N1,N2,...
the control that fires: OUT0 is a print of the same names taken BEFORE the change (here FS131-M7's, on the line without the
proved outward bend); the reader must fail on it naming each of N1, N2, … through `sorryAx` (a name of --red that OUT0 does
not hold through `sorryAx` is itself a failure: the control would be vacuous).

  fs131_l5_axioms.py LEAN OUT --self-test
five plants on a copy of OUT in memory, each of which must fail naming its record: a record deleted; a record given `sorryAx`;
a record given a native axiom; a record with one of the three removed (a subset is not "exactly"); a record doubled.
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
        recs.append((m.group(1), frozenset(a.strip() for a in m.group(2).split(",") if a.strip())))
    for m in re.finditer(r"'([^']+)' does not depend on any axioms", out):
        recs.append((m.group(1), frozenset()))
    return recs


def check(names, out, only=None):
    """Return (rows, failures): failures is a list of (name, message)."""
    recs, rows, bad = records(out), [], []
    if not names:
        bad.append(("-", "NO RECORD ASKED — a failure, not a pass"))
    for n in names:
        if only is not None and n not in only:
            continue
        got = [ax for (k, ax) in recs if k == n]
        if len(got) != 1:
            bad.append((n, f"{'MISSING' if not got else 'DOUBLED'} ({len(got)} records)"))
            continue
        ax = set(got[0])
        if ax == STD:
            rows.append((n, "exactly the standard three"))
        else:
            extra, lack = sorted(ax - STD), sorted(STD - ax)
            bad.append((n, "NOT EXACTLY THE THREE:" + (f" foreign {extra}" if extra else "") + (f" lacking {lack}" if lack else "")))
    if re.search(r"\berror\b", out):
        bad.append(("-", "the output holds an error"))
    return rows, bad


def main():
    a = sys.argv[1:]
    lean, out = Path(a[0]).read_text(), Path(a[1]).read_text()
    names = asked(lean)
    if "--self-test" in a:
        rows, bad = check(names, out)
        ok = not bad
        print(f"unplanted: {'PASS' if ok else 'FAIL'} ({len(rows)} records on exactly the three)")
        n0, n1 = names[0], names[-1]
        rec = re.search(r"'" + re.escape(n0) + r"' depends on axioms: \[[^\]]*\]", out, re.S)
        rec1 = re.search(r"'" + re.escape(n1) + r"' depends on axioms: \[[^\]]*\]", out, re.S)
        assert rec and rec1, "the plants need the first and last asked records present"
        plants = [
            ("a record deleted", out.replace(rec.group(0), "", 1), n0),
            ("a record given sorryAx", out.replace(rec.group(0), rec.group(0)[:-1] + ", sorryAx]", 1), n0),
            ("a record given a native axiom", out.replace(rec1.group(0), rec1.group(0)[:-1] + ", foo._native.native_decide.ax_1_1]", 1), n1),
            ("a record with Quot.sound removed", out.replace(rec1.group(0), re.sub(r",?\s*Quot\.sound", "", rec1.group(0)), 1), n1),
            ("a record doubled", out + "\n" + rec.group(0) + "\n", n0),
        ]
        for label, planted, culprit in plants:
            assert planted != out, label
            _, b = check(names, planted)
            fired = any(k == culprit for k, _ in b)
            print(f"plant — {label}: {'FIRED naming ' + culprit if fired else 'NOT CAUGHT'}")
            ok &= fired
        print("SELF-TEST " + ("OK: every plant fired, the unplanted print passes" if ok else "FAILED"))
        return 0 if ok else 1
    rows, bad = check(names, out)
    for n, v in rows:
        print(f"{v:28s} {n}")
    for n, m in bad:
        print(f"FAIL {n}: {m}")
    rc = 1 if bad else 0
    if "--before" in a:
        out0 = Path(a[a.index("--before") + 1]).read_text()
        red = a[a.index("--red") + 1].split(",")
        _, bad0 = check(names, out0, only=set(red))
        got = {n: m for n, m in bad0}
        for n in red:
            m = got.get(n, "")
            fired = "sorryAx" in m
            print(f"CONTROL (the print before the merge) {n}: {'fails — ' + m if fired else 'DID NOT FAIL through sorryAx: ' + (m or 'reads clean')}")
            if not fired:
                rc = 1
    print(f"RESULT: {'PASS' if rc == 0 else 'FAIL'} — {len(rows)} of {len(names)} asked records on exactly the standard three")
    return rc


if __name__ == "__main__":
    sys.exit(main())
