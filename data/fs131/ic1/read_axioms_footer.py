#!/usr/bin/env python3
"""FS131-IC1 — read a print of lean/AxiomsFooter.lean and check every record.

A record is `AXIOMS <public|private> <name> : [a, b, c]`; the print ends with `AXIOMS-COUNT n`.
Real run: PASS iff the count line is there and agrees with the records, the nine written theorems of the skeleton are
all among them, and every record's axioms are a subset of the standard three.
`--control` (the print of the copy in which `isClosed_band` is `sorry`): PASS iff exactly the expected records rest on
`sorryAx` — the planted leaf and the two theorems that read it — and every other record is clean.
Usage: read_axioms_footer.py <print.txt> [--control]
"""
import re, sys, pathlib
STD = {"propext", "Classical.choice", "Quot.sound"}
NS = "HadwigerNelson.ThreeColourCharacter."
WRITTEN = [NS + n for n in ("exists_int_vector_of_forall_neg", "exists_character_of_box_point",
           "exists_character_of_properAlong", "isClosed_band", "bandSet_nonempty_of_finite",
           "bandSet_three_nonempty_of_proper", "fieldBandSet_three_nonempty_of_colorable", "exists_character_one_two")] \
          + ["HadwigerNelson.ThreeColour.Winding.exists_box_point"]
PLANT_REACH = {NS + n for n in ("isClosed_band", "bandSet_three_nonempty_of_proper", "fieldBandSet_three_nonempty_of_colorable")}
control = "--control" in sys.argv
text = pathlib.Path([a for a in sys.argv[1:] if not a.startswith("--")][0]).read_text()
recs = {}
for m in re.finditer(r"^AXIOMS (public|private) (\S+) : \[([^\]]*)\]$", text, flags=re.M):
    recs[m.group(2)] = (m.group(1), {a.strip() for a in m.group(3).split(",") if a.strip()})
cm = re.search(r"^AXIOMS-COUNT (\d+)$", text, flags=re.M)
if cm is None or int(cm.group(1)) != len(recs) or not recs:
    print(f"READER BROKEN OR PRINT INCOMPLETE: {len(recs)} records, count line {cm.group(1) if cm else 'absent'}"); sys.exit(2)
missing = [w for w in WRITTEN if w not in recs]
dirty = {n: sorted(ax - STD) for n, (_, ax) in recs.items() if ax - STD}
npub = sum(1 for k, _ in recs.values() if k == "public")
print(f"records: {len(recs)} ({npub} public, {len(recs) - npub} private); of the skeleton's nine theorems missing: {missing}; "
      f"resting on an axiom beyond the standard three: {len(dirty)}")
for n, (k, ax) in sorted(recs.items()):
    print(f"  {k:7} {n} : {sorted(ax)}")
if control:
    ok = set(dirty) == PLANT_REACH and all(v == ["sorryAx"] for v in dirty.values()) and not missing
    print(f"CONTROL: sorryAx reported on {len(dirty)} records, expected exactly {sorted(PLANT_REACH)} — "
          f"{'the check can fail, and names the leaf' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
    sys.exit(0 if ok else 1)
ok = not missing and not dirty
print("PASS: every record is on the standard three" if ok else "FAIL")
sys.exit(0 if ok else 1)
