#!/usr/bin/env python3
"""FS131-IMM4: read a `#print axioms` receipt (`lake env lean data/fs131/imm/AxiomsIMM.lean`) and classify every record.

Lean wraps a long axiom list over several lines and prints a name with an apostrophe inside its quotes (`lift_succ'`), so the
records are re-joined first (a continuation line starts with a space) and each record is parsed whole. Classes:

  standard  exactly [propext, Classical.choice, Quot.sound]
  subset    a proper subset of the standard three (including no axioms at all)
  sorry     sorryAx among them
  other     any other axiom (always a failure)

Usage:
  fs131_imm_axioms.py RECEIPT [--expect-sorry NAME ...]   # exit 1 unless the sorry records are exactly the named ones
  fs131_imm_axioms.py --self-test                          # plants four faults and watches each fire
"""
import re
import sys

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
REC = re.compile(r"^'(.+)' (depends on axioms: \[(.*)\]|does not depend on any axioms)$")


def records(text):
    lines, out = [], []
    for raw in text.splitlines():
        if raw.startswith(" ") and lines:
            lines[-1] += " " + raw.strip()
        else:
            lines.append(raw.rstrip())
    for line in lines:
        m = REC.match(line)
        if m:
            axioms = set() if m.group(3) is None else {a.strip() for a in m.group(3).split(",") if a.strip()}
            out.append((m.group(1), axioms))
    return out


def classify(axioms):
    if "sorryAx" in axioms:
        return "sorry"
    if axioms - STANDARD:
        return "other"
    return "standard" if axioms == STANDARD else "subset"


def check(text, expect_sorry):
    recs = records(text)
    counts = {"standard": 0, "subset": 0, "sorry": 0, "other": 0}
    bad = []
    sorry_names = set()
    for name, axioms in recs:
        cls = classify(axioms)
        counts[cls] += 1
        if cls == "other":
            bad.append(f"foreign axiom: {name} {sorted(axioms)}")
        if cls == "sorry":
            sorry_names.add(name)
    for name in sorted(sorry_names - set(expect_sorry)):
        bad.append(f"unexpected sorryAx: {name}")
    for name in sorted(set(expect_sorry) - sorry_names):
        bad.append(f"expected sorryAx missing (the control did not fire): {name}")
    return len(recs), counts, bad


def report(text, expect_sorry):
    n, counts, bad = check(text, expect_sorry)
    print(f"{n} records: {counts['standard']} standard three, {counts['subset']} on fewer, "
          f"{counts['sorry']} with sorryAx, {counts['other']} foreign")
    for b in bad:
        print("FAIL:", b)
    if n == 0:
        print("FAIL: no records parsed")
        return 1
    if not bad:
        print("PASS")
    return 1 if bad else 0


def self_test():
    good = ("'A.x' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n"
            "'A.y'' depends on axioms: [propext]\n"
            "'A.z' does not depend on any axioms\n"
            "'A.ctl' depends on axioms: [propext, sorryAx, Classical.choice, Quot.sound]\n")
    cases = [
        ("clean receipt with its control", good, ["A.ctl"], True),
        ("a planted sorry", good + "'A.w' depends on axioms: [sorryAx]\n", ["A.ctl"], False),
        ("a planted foreign axiom", good + "'A.v' depends on axioms: [propext, Lean.ofReduceBool]\n", ["A.ctl"], False),
        ("the control missing", good.replace("sorryAx, ", ""), ["A.ctl"], False),
        ("nothing parsed", "garbage\n", [], False),
    ]
    ok = True
    for label, text, exp, should_pass in cases:
        n, counts, bad = check(text, exp)
        passed = (not bad) and n > 0
        fired = "passes" if passed else "fires"
        verdict = passed == should_pass
        ok &= verdict
        print(f"{'ok' if verdict else 'WRONG'}: {label} — {fired} ({n} records, {counts})")
    n, counts, _ = check(good, ["A.ctl"])
    if not (n == 4 and counts == {"standard": 1, "subset": 2, "sorry": 1, "other": 0}):
        print("WRONG: wrapped lines or an apostrophe name misparsed", n, counts)
        ok = False
    print("SELF-TEST PASS" if ok else "SELF-TEST FAIL")
    return 0 if ok else 1


def main(argv):
    if argv[1:] == ["--self-test"]:
        return self_test()
    if len(argv) < 2:
        print(__doc__)
        return 2
    expect = []
    if "--expect-sorry" in argv:
        i = argv.index("--expect-sorry")
        expect = argv[i + 1:]
        argv = argv[:i]
    with open(argv[1]) as f:
        return report(f.read(), expect)


if __name__ == "__main__":
    sys.exit(main(sys.argv))
