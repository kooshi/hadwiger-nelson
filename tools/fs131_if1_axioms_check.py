#!/usr/bin/env python3
"""FS131-IF1: read the `#print axioms` output of a scratch audit and judge it.

usage: fs131_if1_axioms_check.py <lean output file> <expected record count>

The output has two banners, `=== IF1 RECORDS ===` and `=== IF1 CONTROL ===`. Every record after the first must depend on
a subset of the standard three axioms; every record after the second is a planted fault and must NOT (it rests on
`sorry`). One predicate judges both, so a pass says the predicate was seen to fire in this very run. The number of
records under the first banner must equal the expected count, so a record that silently failed to print is a failure.
Exit 0 only if all three hold. Iteration evidence; the gate's receipt is `scripts/axioms.sh`.
"""
import re
import sys

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
REC = re.compile(r"^'([^']+)' (?:depends on axioms: \[([^\]]*)\]|does not depend on any axioms)$")


def records(text):
    """[(section, name, axiom set)] — records rejoined across wrapped lines."""
    out, sec, buf = [], None, None
    for line in text.splitlines():
        if buf is not None:
            buf += " " + line.strip()
            if "]" in line:
                out.append((sec, buf))
                buf = None
            continue
        m = re.match(r"^=== IF1 (RECORDS|CONTROL) ===$", line)
        if m:
            sec = m.group(1)
        elif line.startswith("'"):
            if "depends on axioms: [" in line and "]" not in line:
                buf = line
            else:
                out.append((sec, line))
    if buf is not None:
        out.append((sec, buf))
    parsed = []
    for sec, line in out:
        m = REC.match(re.sub(r"\s+", " ", line.strip()))
        if not m:
            raise SystemExit(f"FAIL malformed record: {line!r}")
        axs = set(a.strip() for a in (m.group(2) or "").split(",") if a.strip())
        parsed.append((sec, m.group(1), axs))
    return parsed


def clean(axs):
    return axs <= STANDARD


def main():
    path, expected = sys.argv[1], int(sys.argv[2])
    recs = records(open(path).read())
    bad = 0
    lib = [r for r in recs if r[0] == "RECORDS"]
    ctl = [r for r in recs if r[0] == "CONTROL"]
    for _, name, axs in lib:
        ok = clean(axs)
        print(f"{'ok  ' if ok else 'FAIL'} {name}: {sorted(axs)}")
        bad += not ok
    if len(lib) != expected:
        print(f"FAIL count: {len(lib)} records under RECORDS, expected {expected}")
        bad += 1
    if not ctl:
        print("FAIL control: no planted record was read, so the predicate was not seen to fire")
        bad += 1
    for _, name, axs in ctl:
        fired = not clean(axs)
        print(f"{'ok  ' if fired else 'FAIL'} control {name}: {sorted(axs)} — {'fires' if fired else 'did NOT fire'}")
        bad += not fired
    print(f"RESULT: {'PASS' if not bad else 'FAIL'} — {len(lib)} records, {len(ctl)} control(s)")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
