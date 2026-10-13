#!/usr/bin/env python3
"""FS131-IU1 — read a print of `#print axioms` lines (lean/Axioms.lean, lean/Models.lean) and check every record.

A record is `'<name>' depends on axioms: [a, b, c]` (possibly wrapped over lines) or `'<name>' does not depend on any
axioms`.  PASS iff the number of records is the number expected, every record's axioms are a subset of the standard
three, and (with --names FILE) the records are exactly the `#print axioms` lines of FILE, in order.
`--control` appends a record resting on `sorryAx` and one on an undeclared axiom, and must report both; exit 0 only then.
Usage: read_axioms.py <print.txt> <expected-count> [--names audit-block.txt] [--control]
"""
import re, sys, pathlib
STD = {"propext", "Classical.choice", "Quot.sound"}
args = [a for a in sys.argv[1:] if not a.startswith("--")]
control = "--control" in sys.argv
text = pathlib.Path(args[0]).read_text()
want = int(args[1])
names_file = sys.argv[sys.argv.index("--names") + 1] if "--names" in sys.argv else None
if names_file: args = [a for a in args if a != names_file]
if control:
    text += "'Planted.one' depends on axioms: [propext, sorryAx]\n'Planted.two' depends on axioms: [Classical.choice,\n Some.undeclared_axiom]\n"
    want += 2
recs = []
for m in re.finditer(r"'([^']+)' (depends on axioms: \[([^\]]*)\]|does not depend on any axioms)", text):
    axs = [a.strip() for a in (m.group(3) or "").replace("\n", " ").split(",") if a.strip()]
    recs.append((m.group(1), axs))
bad = [(n, sorted(set(a) - STD)) for n, a in recs if set(a) - STD]
errors = len(re.findall(r": error", text))
print(f"records: {len(recs)} (expected {want}); resting on an axiom beyond the standard three: {len(bad)}; error lines in the print: {errors}")
for n, extra in bad:
    print(f"  NOT CLEAN {n}: {extra}")
ok = len(recs) == want and not bad and errors == 0
if names_file:
    listed = re.findall(r"^#print axioms (\S+)", pathlib.Path(names_file).read_text(), flags=re.M)
    got = [n for n, _ in recs][:len(recs) - (2 if control else 0)]
    same = listed == got
    print(f"names against {names_file}: {'the same list, in order' if same else 'DIFFER'} ({len(listed)} listed)")
    ok = ok and same
if control:
    fired = len(bad) == 2 and len(recs) == want
    print(f"CONTROL: {len(bad)} of 2 planted records reported — {'the check can fail' if fired else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
    sys.exit(0 if fired else 1)
print("PASS: every record is on the standard three" if ok else "FAIL")
sys.exit(0 if ok else 1)
