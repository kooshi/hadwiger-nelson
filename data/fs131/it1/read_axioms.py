#!/usr/bin/env python3
"""FS131-IT1 — read a print of `#print axioms` lines (lean/Axioms.lean, lean/Models.lean) and check every record.

A record is `'<name>' depends on axioms: [a, b, c]` (possibly wrapped over lines) or `'<name>' does not depend on any
axioms`.  PASS iff the number of records is the number expected; every record's axioms are a subset of the standard
three, except the records named by --sorry FILE (one name a line), each of which must carry exactly the standard three's
subset and `sorryAx` — it reads an upstream leaf another job proves, and a record of that list WITHOUT `sorryAx` fails
too, so the list cannot go stale in silence; and (with --names FILE) the records are exactly the `#print axioms` lines
of FILE, in order.
`--control` appends a record resting on `sorryAx` that the list does not name and one on an undeclared axiom, and must
report both; exit 0 only then.
Usage: read_axioms.py <print.txt> <expected-count> [--names audit-block.txt] [--sorry sorry-expected.txt] [--control]
"""
import re, sys, pathlib
STD = {"propext", "Classical.choice", "Quot.sound"}
argv = sys.argv[1:]
def opt(flag):
    if flag in argv:
        i = argv.index(flag); v = argv[i + 1]; del argv[i:i + 2]; return v
    return None
names_file, sorry_file = opt("--names"), opt("--sorry")
control = "--control" in argv
args = [a for a in argv if not a.startswith("--")]
text = pathlib.Path(args[0]).read_text()
want = int(args[1])
expect_sorry = set(pathlib.Path(sorry_file).read_text().split()) if sorry_file else set()
if control:
    text += "'Planted.one' depends on axioms: [propext, sorryAx]\n'Planted.two' depends on axioms: [Classical.choice,\n Some.undeclared_axiom]\n"
    want += 2
recs = []
for m in re.finditer(r"'([^']+)' (depends on axioms: \[([^\]]*)\]|does not depend on any axioms)", text):
    axs = [a.strip() for a in (m.group(3) or "").replace("\n", " ").split(",") if a.strip()]
    recs.append((m.group(1), axs))
bad = []
for n, a in recs:
    extra = set(a) - STD
    if n in expect_sorry:
        if extra != {"sorryAx"}:
            bad.append((n, f"listed as reading the upstream leaf, but its extra axioms are {sorted(extra)}"))
    elif extra:
        bad.append((n, f"beyond the standard three: {sorted(extra)}"))
unseen = sorted(expect_sorry - {n for n, _ in recs})
errors = len(re.findall(r": error", text))
print(f"records: {len(recs)} (expected {want}); on the standard three: {sum(1 for n, a in recs if not (set(a) - STD))}; "
      f"with `sorryAx` as listed: {sum(1 for n, a in recs if n in expect_sorry and set(a) - STD == {'sorryAx'})} of {len(expect_sorry)} listed; "
      f"not as expected: {len(bad)}; listed and not printed: {len(unseen)}; error lines in the print: {errors}")
for n, why in bad:
    print(f"  NOT AS EXPECTED {n}: {why}")
for n in unseen:
    print(f"  LISTED, NOT PRINTED {n}")
ok = len(recs) == want and not bad and not unseen and errors == 0
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
print("PASS: every record is as expected" if ok else "FAIL")
sys.exit(0 if ok else 1)
