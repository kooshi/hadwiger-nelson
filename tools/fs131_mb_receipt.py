#!/usr/bin/env python3
"""FS131-MB1: read the receipt `data/fs131/mb/MBAxioms.lean` prints, and hold it to this job's claims.

The receipt prints, per record, a verdict and the `sorry`-proved declarations of its dependency closure with their
modules (`RECORD <name> | <verdict> | axioms: [...] | sorry leaves (n): [module:name, ...]`), and per model theorem
whether its proof term calls the landed theorem (`APPLIES <d> <- <t> | APPLIED / NOT-APPLIED`).

The claims checked (exit 0 iff all hold):
  * every record in WHOLE reads STANDARD-THREE;
  * every record in VIA_PAINT reads SORRY-VIA-PAINT-ONLY, its only axiom beyond the standard three is `sorryAx`, and
    every `sorry` leaf it names is in PAINT_LEAVES — the one open leaf of `Plane/Models/Paint` (implementer A's) the stuck
    vertex reads, `brickBase_mem_interiorPts`;
  * every record in OPEN reads SORRY-IN-OWN-FILES (the verdict that must fire while a leaf of this job's files is open);
  * every pair in APPLIED reads APPLIED, and the planted wrong pairing in NOT_APPLIED reads NOT-APPLIED.

`--self-test` plants four faults in a copy of the output, one at a time, and requires each to be reported: a WHOLE
record given `sorryAx`; a VIA_PAINT record given a `sorry` leaf in `Plane.Models.Stuck`; an OPEN record marked
STANDARD-THREE; the control pairing marked APPLIED. The faithful output must pass beside them.
"""
import re, sys, os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
NS = "HadwigerNelson.Plane."
PAINT = "Proofs.HadwigerNelson.Plane.Models.Paint"
# the one open leaf of `Plane/Models/Paint` the stuck vertex reads (a point strictly inside a brick is an interior point of the base)
PAINT_LEAVES = {"brickBase_mem_interiorPts"}

WHOLE = ["cuspFrag_isRingArc", "cuspFrag_coloursAt_I", "cuspFrag_radiusTwo_disjoint", "cuspFrag_bend_away",
         "cuspFrag_bend_toward", "stuckArcs_nondegenerate", "stuckArcs_finite", "frontier_stuckW_subset",
         "stuckCol_locallyConstant", "stuckModel_valid", "stuckModel_no_unit_pair"]
VIA_PAINT = ["stuckModel_coloursAt", "stuckModel_hasSectors", "stuckModel_isHorn", "stuckModel_flanks",
             "stuckModel_contacts", "stuckModel_not_mergeAvailable", "stuckModel_not_rayAvailable",
             "stuckModel_not_shaveAvailable", "stuckModel_isStuck", "stuckModel_hyps", "stuckModel_partition",
             "stuckModel_horn_cases", "stuckModel_shadow"]
OPEN = ["stuckModel_terminal", "shadowModel_valid", "shadowModel_condition5", "shadowModel_flanks",
        "shadowModel_doublyShadowed", "shadowModel_flank_ne", "awayModel_hyps", "awayModel_r2Contacts"]
APPLIED = [("cuspFrag_bend_away", "ArcMap.bend_away_whole"), ("cuspFrag_bend_toward", "ArcMap.bend_toward"),
           ("shadowModel_flank_ne", "ArcMap.flank_ne_of_doublyShadowed")]
NOT_APPLIED = [("cuspFrag_bend_away", "ArcMap.bend_toward")]


def parse(text):
    """Lean wraps long messages; a message runs from its `info:` line to the next line that starts a message."""
    msgs, cur = [], None
    for line in text.split("\n"):
        if re.search(r"(^|: )(RECORD|APPLIES) ", line) or line.startswith("slot:") or re.match(r"^\S+\.lean:\d+:\d+: ", line):
            if cur is not None:
                msgs.append(cur)
            cur = line
        elif cur is not None:
            cur += " " + line.strip()
    if cur is not None:
        msgs.append(cur)
    recs, apps = {}, {}
    for m in msgs:
        r = re.search(r"RECORD (\S+) \| (\S+) \| axioms: \[(.*?)\] \| sorry leaves \((\d+)\): \[(.*?)\]\s*$", m)
        if r:
            name = r.group(1).replace(NS, "")
            axioms = [a.strip() for a in r.group(3).split(",") if a.strip()]
            leaves = [l.strip() for l in r.group(5).split(",") if l.strip()]
            recs[name] = (r.group(2), axioms, leaves)
            continue
        a = re.search(r"APPLIES (\S+) <- (\S+) \| (\S+)", m)
        if a:
            apps[(a.group(1).replace(NS, ""), a.group(2).replace(NS, ""))] = a.group(3)
    return recs, apps


def check(text):
    recs, apps = parse(text)
    bad = []
    std = {"propext", "Classical.choice", "Quot.sound"}
    for n in WHOLE:
        if n not in recs:
            bad.append(f"{n}: no record"); continue
        v, ax, lv = recs[n]
        if v != "STANDARD-THREE" or not set(ax) <= std or lv:
            bad.append(f"{n}: expected STANDARD-THREE, read {v} axioms={ax} leaves={lv}")
    for n in VIA_PAINT:
        if n not in recs:
            bad.append(f"{n}: no record"); continue
        v, ax, lv = recs[n]
        extra = set(ax) - std
        ok_leaves = all(l.startswith(PAINT + ":") and l.split(":", 1)[1].replace(NS, "") in PAINT_LEAVES for l in lv)
        if v != "SORRY-VIA-PAINT-ONLY" or extra != {"sorryAx"} or not lv or not ok_leaves:
            bad.append(f"{n}: expected SORRY-VIA-PAINT-ONLY through Paint's open leaves, read {v} axioms={ax} leaves={lv}")
    for n in OPEN:
        if n not in recs:
            bad.append(f"{n}: no record"); continue
        v, ax, lv = recs[n]
        if v != "SORRY-IN-OWN-FILES":
            bad.append(f"{n}: expected SORRY-IN-OWN-FILES (an open leaf of this job's files), read {v}")
    for pair in APPLIED:
        if apps.get(pair) != "APPLIED":
            bad.append(f"{pair}: expected APPLIED, read {apps.get(pair)}")
    for pair in NOT_APPLIED:
        if apps.get(pair) != "NOT-APPLIED":
            bad.append(f"{pair}: the control pairing must read NOT-APPLIED, read {apps.get(pair)}")
    return recs, apps, bad


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    path = args[0] if args else os.path.join(ROOT, "data/fs131/mb/MBAxioms-stage3.out")
    with open(path) as f:
        text = f.read()
    if "--self-test" in sys.argv:
        _, _, bad0 = check(text)
        plants = [
            ("a WHOLE record given sorryAx",
             lambda t: re.sub(r"(RECORD " + re.escape(NS) + r"cuspFrag_bend_away \| )STANDARD-THREE( \| axioms: \[)",
                              r"\1STANDARD-THREE\2sorryAx, ", t, count=1, flags=re.S)),
            ("a VIA_PAINT record given a leaf in Stuck",
             lambda t: t.replace("Proofs.HadwigerNelson.Plane.Models.Paint:" + NS + "brickBase_mem_interiorPts",
                                 "Proofs.HadwigerNelson.Plane.Models.Stuck:" + NS + "stuckModel_valid", 1)),
            ("an OPEN record marked STANDARD-THREE",
             lambda t: re.sub(r"(RECORD " + re.escape(NS) + r"shadowModel_flank_ne \| )SORRY-IN-OWN-FILES", r"\1STANDARD-THREE", t,
                              count=1)),
            ("the control pairing marked APPLIED",
             lambda t: t.replace("ArcMap.bend_toward | NOT-APPLIED", "ArcMap.bend_toward | APPLIED", 1)),
        ]
        fired = 0
        for label, plant in plants:
            t2 = plant(text)
            _, _, bad = check(t2)
            hit = t2 != text and len(bad) >= 1
            print(f"plant: {label}: {'FIRED' if hit else 'SILENT'} ({len(bad)} finding(s); text changed: {t2 != text})")
            fired += 1 if hit else 0
        ok = fired == len(plants) and not bad0
        print(f"self-test: {fired} of {len(plants)} plants fired; faithful run {len(bad0)} finding(s) -> {'OK' if ok else 'FAIL'}")
        sys.exit(0 if ok else 1)
    recs, apps, bad = check(text)
    for n in WHOLE + VIA_PAINT + OPEN:
        if n in recs:
            v, ax, lv = recs[n]
            print(f"{n}\t{v}\tleaves={[l.split(':', 1)[1].replace(NS, '') for l in lv]}")
    for k, v in apps.items():
        print(f"APPLIES {k[0]} <- {k[1]}\t{v}")
    print(f"{len(recs)} records, {len(apps)} pairings; findings: {len(bad)}")
    for b in bad:
        print("  FINDING:", b)
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
