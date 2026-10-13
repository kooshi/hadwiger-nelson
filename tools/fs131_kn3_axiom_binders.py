#!/usr/bin/env python3
"""FS131-KN3: the declared theorem's binders, read from the kernel's print of its type.

Reads a log made by `lake env lean data/fs131/kn3/FirstLayerCheck.lean` and requires that the printed type of
`positive_entropy_rigidity` holds each instance binder the page's hypotheses need: an abelian group, a topology, a
σ-algebra and `BorelSpace X` (the measure of the page is a Borel measure). A section `variable` the statement does not
mention is not a binder of an `axiom`; this check is the reading that found it.

usage: fs131_kn3_axiom_binders.py <log>     exit 0: all present; exit 1: one missing, named.
Control: run on data/fs131/kn3/logs/FirstLayerCheck-before-binder-fix.log — it must exit 1 and name BorelSpace.
"""
import re, sys
text = open(sys.argv[1]).read()
m = re.search(r"@positive_entropy_rigidity : (.*?)\n@haar_or_zero_entropy", text, re.S)
if not m:
    print("FAIL: the axiom's type is not in the log"); sys.exit(1)
head = m.group(1).split("IsSolenoid X")[0]
need = ["AddCommGroup X", "TopologicalSpace X", "MeasurableSpace X", "BorelSpace X"]
missing = [n for n in need if n not in head]
if missing:
    print("FAIL: binders missing before `IsSolenoid X`:", ", ".join(missing)); sys.exit(1)
print("ok: the axiom's type binds", ", ".join(need)); sys.exit(0)
