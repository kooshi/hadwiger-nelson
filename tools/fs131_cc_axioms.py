#!/usr/bin/env python3
"""FS131-CC2: read an axioms print against its expectations.

Usage: fs131_cc_axioms.py <print.lean> <print.out> [--self-test]

The print file lists `#print axioms <name>` lines under section comments `-- EXPECT STANDARD` (the record's axioms must be a subset of
`propext`, `Classical.choice`, `Quot.sound`) and `-- EXPECT SORRY` (the record must hold `sorryAx`, and nothing beyond it and the standard
three). The output is Lean's, one record per name: `'<name>' depends on axioms: [...]` or `'<name>' does not depend on any axioms`.
Checks: every name of the print file has exactly one record, every record is of a listed name, each record meets its section's
expectation. Exit 0 iff all hold; prints the counts and every `EXPECT SORRY` name (they are the outstanding debt, by name).
`--self-test` re-runs the check with one name moved to the other section, in each direction, with one record deleted, and with a foreign
axiom added to one record: each must fail and name its culprit; the unplanted partner must pass.
"""
import re
import sys

STANDARD = {"propext", "Classical.choice", "Quot.sound"}


def expectations(lean_text):
    section, out = None, []
    for line in lean_text.splitlines():
        s = line.strip()
        if s.startswith("-- EXPECT STANDARD"):
            section = "standard"
        elif s.startswith("-- EXPECT SORRY"):
            section = "sorry"
        m = re.match(r"#print axioms\s+(\S+)", s)
        if m:
            if section is None:
                raise SystemExit(f"FAIL: `#print axioms {m.group(1)}` before any EXPECT section")
            out.append((m.group(1), section))
    return out


def records(out_text):
    recs = {}
    dup = []
    for m in re.finditer(r"'([^']+)' (?:depends on axioms: \[([^\]]*)\]|does not depend on any axioms)", out_text):
        name = m.group(1)
        axs = set(a.strip() for a in (m.group(2) or "").replace("\n", " ").split(",") if a.strip())
        if name in recs:
            dup.append(name)
        recs[name] = axs
    return recs, dup


def check(exp, recs, dup):
    errs = [f"{n}: more than one record" for n in dup]
    names = [n for n, _ in exp]
    for n in set(names):
        if names.count(n) > 1:
            errs.append(f"{n}: listed more than once in the print file")
    for n, section in exp:
        if n not in recs:
            errs.append(f"{n}: no record in the output")
            continue
        axs = recs[n]
        if section == "standard" and not axs <= STANDARD:
            errs.append(f"{n}: expected the standard three or fewer, got {sorted(axs)}")
        if section == "sorry" and "sorryAx" not in axs:
            errs.append(f"{n}: expected sorryAx, got {sorted(axs)}")
        if section == "sorry" and not axs <= STANDARD | {"sorryAx"}:
            errs.append(f"{n}: an axiom beyond sorryAx and the standard three: {sorted(axs)}")
    for n in recs:
        if n not in names:
            errs.append(f"{n}: a record of a name the print file does not list")
    return errs


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    lean_text, out_text = open(args[0], encoding="utf-8").read(), open(args[1], encoding="utf-8").read()
    exp = expectations(lean_text)
    recs, dup = records(out_text)
    if "--self-test" in sys.argv:
        std = [n for n, s in exp if s == "standard"]
        sor = [n for n, s in exp if s == "sorry"]
        assert std and sor, "self-test needs a name in each section"
        plants = [
            ("a standard name expected to hold sorryAx", [(n, "sorry" if n == std[0] else s) for n, s in exp], recs, std[0]),
            ("a sorryAx name expected standard", [(n, "standard" if n == sor[0] else s) for n, s in exp], recs, sor[0]),
            ("a record deleted", exp, {n: a for n, a in recs.items() if n != std[-1]}, std[-1]),
            ("a foreign axiom in a record", exp, {**recs, std[0]: recs[std[0]] | {"bogusAx"}}, std[0]),
            ("a foreign axiom in a sorry record", exp, {**recs, sor[0]: recs[sor[0]] | {"bogusAx"}}, sor[0]),
        ]
        fired = 0
        for label, e, r, culprit in plants:
            errs = [x for x in check(e, r, dup) if culprit in x]
            if errs:
                fired += 1
                print(f"FIRED ({label}): {errs[0]}")
            else:
                print(f"DID NOT FIRE ({label})")
        partner = check(exp, recs, dup)
        print(f"self-test: {fired} of {len(plants)} plants fired, each naming its culprit; unplanted partner "
              f"{'PASS' if not partner else 'FAIL: ' + str(partner)}")
        return 0 if fired == len(plants) and not partner else 1
    errs = check(exp, recs, dup)
    for e in errs:
        print("FAIL:", e)
    n_std = sum(1 for _, s in exp if s == "standard")
    n_sor = sum(1 for _, s in exp if s == "sorry")
    for n, s in exp:
        if s == "sorry":
            print(f"on sorryAx: {n}")
    print(f"{len(exp)} names, {len(recs)} records: {n_std} expected standard, {n_sor} expected on sorryAx")
    print("PASS" if not errs else f"FAIL: {len(errs)} error(s)")
    return 0 if not errs else 1


if __name__ == "__main__":
    sys.exit(main())
