#!/usr/bin/env python3
"""FS131-MB2: read the receipt `data/fs131/mb2/MB2Axioms.lean` prints, and hold it to this job's claims, stage by stage.

The receipt prints, per record, a verdict and the `sorry`-proved declarations of its dependency closure with their
modules (`RECORD <name> | <verdict> | axioms: [...] | sorry leaves (n): [module:name, ...]`), and per model theorem
whether its proof term calls the landed theorem (`APPLIES <d> <- <t> | APPLIED / NOT-APPLIED`). The format and the two
commands are FS131-MB1's (`tools/fs131_mb_receipt.py`, another job's tool, not edited); what is new here is that a
record resting on `Plane/Models/Paint` is held to **the exact set** of `Paint`'s open leaves it reads, and that the
claims are a table per stage:

  --stage 6   `shadowModel` whole, before the other half joins: its records rest on `sorryAx` through named leaves of
              `Paint` alone; `awayModel`'s and `stuckModel_terminal` are open.
  --stage 7   after `origin/fs131-wm` is merged: every record but the open ones reads the standard three.
  --stage 8   `awayModel` whole: every record but `stuckModel_terminal` reads the standard three.

The claims checked (exit 0 iff all hold):
  * every WHOLE record reads STANDARD-THREE, its axioms within the standard three, no `sorry` leaf;
  * every VIA_PAINT record reads SORRY-VIA-PAINT-ONLY, its only axiom beyond the standard three is `sorryAx`, and the
    `sorry` leaves it names are exactly its expected leaves of `Plane.Models.Paint`;
  * every OPEN record reads SORRY-IN-OWN-FILES (the verdict that must fire while a leaf of this job's files is open);
  * every pair in APPLIED reads APPLIED, and the planted wrong pairing reads NOT-APPLIED;
  * no record of the stage's table is missing from the output.

`--self-test` plants faults in a copy of the output, one at a time, and requires each to be reported, beside the
faithful output, which must pass: a WHOLE record given `sorryAx`; an OPEN record marked STANDARD-THREE; the control
pairing marked APPLIED; a WHOLE record's line deleted; and, where the stage has VIA_PAINT records, one given a leaf in
`Plane.Models.Stuck` and one given a leaf of `Paint` outside its expected set.
"""
import os, re, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
NS = "HadwigerNelson.Plane."
PAINT = "Proofs.HadwigerNelson.Plane.Models.Paint"
STD = {"propext", "Classical.choice", "Quot.sound"}

MEM = "brickBase_mem_interiorPts"
NONDEG = "hornArcs_nondegenerate"
FRONT = "frontier_hornSet_subset"
COL0 = "brickBase_col_zero"

MB1_WHOLE = ["cuspFrag_isRingArc", "cuspFrag_coloursAt_I", "cuspFrag_radiusTwo_disjoint", "cuspFrag_bend_away",
             "cuspFrag_bend_toward", "stuckArcs_nondegenerate", "stuckArcs_finite", "frontier_stuckW_subset",
             "stuckCol_locallyConstant", "stuckModel_valid", "stuckModel_no_unit_pair"]
MB1_VIA = ["stuckModel_coloursAt", "stuckModel_hasSectors", "stuckModel_isHorn", "stuckModel_flanks",
           "stuckModel_contacts", "stuckModel_not_mergeAvailable", "stuckModel_not_rayAvailable",
           "stuckModel_not_shaveAvailable", "stuckModel_isStuck", "stuckModel_hyps", "stuckModel_partition",
           "stuckModel_horn_cases", "stuckModel_shadow"]
SHADOW_WHOLE = ["shadowCol_locallyConstant", "shadowModel_mem_hornArcs", "shadowModel_hornSet_not_mem_hornArcs",
                "shadowModel_dists", "shadowModel_not_mem_arcs", "shadowModel_disjoint", "shadowModel_isOpen",
                "shadowModel_shadowCol", "shadowModel_tanHeight", "shadowModel_apart", "shadowModel_flank_source",
                "shadowModel_no_unit_pair", "shadowModel_not_isUnitArc", "shadowModel_witness_real",
                "shadowModel_shadow"]
# the leaves of `Paint` each record of `shadowModel` reads while they are open (stage 6)
SHADOW_VIA = {
    "shadowArcs_nondegenerate": {NONDEG},
    "frontier_shadowW_subset": {FRONT},
    "shadowModel_shadowW_subset": {MEM},
    "shadowModel_valid": {NONDEG, FRONT},
    "shadowModel_condition5": {NONDEG, FRONT},
    "shadowModel_mem_region": {NONDEG, FRONT, MEM},
    "shadowModel_flanks": {NONDEG, FRONT, MEM},
    "shadowModel_doublyShadowed": {NONDEG, FRONT, MEM},
    "shadowModel_flank_ne": {NONDEG, FRONT, MEM},
}
AWAY_LEAVES = ["awayArcs_nondegenerate", "frontier_awayW_subset", "awayModel_hyps", "awayModel_r2Contacts"]
AWAY_HELPERS = ["awayModel_P_coords", "awayModel_dist_sq", "awayModel_circPt", "awayModel_mem_circ",
                "awayModel_arcs_subset", "awayModel_isOpen_rect", "awayModel_closure_rect", "awayModel_frontier_rect",
                "awayModel_wall_mem", "awayModel_mem_awayW", "awayModel_rect_subset", "awayModel_rect_dist",
                "awayModel_not_mem_arcs", "awayModel_no_unit_pair", "awayModel_isPlaneMap", "awayModel_region_seven",
                "awayModel_brick", "awayModel_trig", "awayModel_ringPt_mem", "awayModel_approach_real",
                "awayModel_centre_brick", "awayModel_coloursAt", "awayModel_bend_toward"]

APPLIED_BASE = [("cuspFrag_bend_away", "ArcMap.bend_away_whole"), ("cuspFrag_bend_toward", "ArcMap.bend_toward"),
                ("shadowModel_flank_ne", "ArcMap.flank_ne_of_doublyShadowed")]
NOT_APPLIED = [("cuspFrag_bend_away", "ArcMap.bend_toward")]


def table(stage):
    """(whole, via, open, applied) for a stage; `via` maps a record to its expected set of `Paint` leaves."""
    if stage == 6:
        via = {n: {MEM} for n in MB1_VIA}
        via.update(SHADOW_VIA)
        return (MB1_WHOLE + SHADOW_WHOLE, via, ["stuckModel_terminal", "awayModel_hyps", "awayModel_r2Contacts"],
                APPLIED_BASE)
    if stage == 7:
        return (MB1_WHOLE + MB1_VIA + SHADOW_WHOLE + sorted(SHADOW_VIA), {},
                ["stuckModel_terminal", "awayModel_hyps", "awayModel_r2Contacts"], APPLIED_BASE)
    if stage == 8:
        return (MB1_WHOLE + MB1_VIA + SHADOW_WHOLE + sorted(SHADOW_VIA) + AWAY_LEAVES + AWAY_HELPERS, {},
                ["stuckModel_terminal"], APPLIED_BASE + [("awayModel_bend_toward", "ArcMap.bend_toward")])
    raise SystemExit(f"no table for stage {stage}")


def parse(text):
    """Lean wraps long messages; a message runs from its first line to the next line that starts a message."""
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


def check(text, stage):
    whole, via, open_, applied = table(stage)
    recs, apps = parse(text)
    bad = []
    for n in whole:
        if n not in recs:
            bad.append(f"{n}: no record"); continue
        v, ax, lv = recs[n]
        if v != "STANDARD-THREE" or not set(ax) <= STD or lv:
            bad.append(f"{n}: expected STANDARD-THREE, read {v} axioms={ax} leaves={lv}")
    for n, want in via.items():
        if n not in recs:
            bad.append(f"{n}: no record"); continue
        v, ax, lv = recs[n]
        extra = set(ax) - STD
        in_paint = all(l.startswith(PAINT + ":") for l in lv)
        got = {l.split(":", 1)[1].replace(NS, "") for l in lv}
        if v != "SORRY-VIA-PAINT-ONLY" or extra != {"sorryAx"} or not in_paint or got != want:
            bad.append(f"{n}: expected SORRY-VIA-PAINT-ONLY through exactly {sorted(want)}, read {v} axioms={ax} leaves={lv}")
    for n in open_:
        if n not in recs:
            bad.append(f"{n}: no record"); continue
        v, ax, lv = recs[n]
        if v != "SORRY-IN-OWN-FILES":
            bad.append(f"{n}: expected SORRY-IN-OWN-FILES (an open leaf of this job's files), read {v}")
    for pair in applied:
        if apps.get(pair) != "APPLIED":
            bad.append(f"{pair}: expected APPLIED, read {apps.get(pair)}")
    for pair in NOT_APPLIED:
        if apps.get(pair) != "NOT-APPLIED":
            bad.append(f"{pair}: the control pairing must read NOT-APPLIED, read {apps.get(pair)}")
    return recs, apps, bad


def plants(stage):
    whole, via, open_, _ = table(stage)
    w, o = whole[0], open_[0]
    out = [
        (f"a WHOLE record ({w}) given sorryAx",
         lambda t: re.sub(r"(RECORD " + re.escape(NS + w) + r" \| STANDARD-THREE \| axioms: \[)", r"\1sorryAx, ", t, count=1)),
        (f"an OPEN record ({o}) marked STANDARD-THREE",
         lambda t: re.sub(r"(RECORD " + re.escape(NS + o) + r" \| )SORRY-IN-OWN-FILES", r"\1STANDARD-THREE", t, count=1)),
        ("the control pairing marked APPLIED",
         lambda t: t.replace("ArcMap.bend_toward | NOT-APPLIED", "ArcMap.bend_toward | APPLIED", 1)),
        (f"a WHOLE record's line deleted ({whole[-1]})",
         lambda t: re.sub(r"RECORD " + re.escape(NS + whole[-1]) + r" \| ", "RECORD-GONE | ", t, count=1)),
    ]
    if via:
        v = sorted(via)[0]
        wrong = sorted({MEM, NONDEG, FRONT, COL0} - via[v])[0]
        out += [
            (f"a VIA_PAINT record ({v}) given a leaf in Stuck",
             lambda t: re.sub(r"(RECORD " + re.escape(NS + v) + r" \| .*?sorry leaves \(\d+\): \[)",
                              r"\1Proofs.HadwigerNelson.Plane.Models.Stuck:" + NS + "stuckModel_valid, ", t, count=1, flags=re.S)),
            (f"a VIA_PAINT record ({v}) given a leaf of Paint outside its set ({wrong})",
             lambda t: re.sub(r"(RECORD " + re.escape(NS + v) + r" \| .*?sorry leaves \(\d+\): \[)",
                              r"\1" + PAINT + ":" + NS + wrong + ", ", t, count=1, flags=re.S)),
        ]
    return out


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    stage = None
    for i, a in enumerate(sys.argv):
        if a == "--stage":
            stage = int(sys.argv[i + 1])
    if stage is None:
        raise SystemExit("usage: fs131_mb2_receipt.py --stage N [--self-test] [output]")
    args = [a for a in args if a != str(stage)]
    path = args[0] if args else os.path.join(ROOT, f"data/fs131/mb2/MB2Axioms-stage{stage}.out")
    with open(path) as f:
        text = f.read()
    if "--self-test" in sys.argv:
        _, _, bad0 = check(text, stage)
        ps = plants(stage)
        fired = 0
        for label, plant in ps:
            t2 = plant(text)
            _, _, bad = check(t2, stage)
            hit = t2 != text and len(bad) > len(bad0)
            print(f"plant: {label}: {'FIRED' if hit else 'SILENT'} ({len(bad)} finding(s); text changed: {t2 != text})")
            fired += 1 if hit else 0
        ok = fired == len(ps) and not bad0
        print(f"self-test (stage {stage}): {fired} of {len(ps)} plants fired; faithful run {len(bad0)} finding(s) -> "
              f"{'OK' if ok else 'FAIL'}")
        sys.exit(0 if ok else 1)
    recs, apps, bad = check(text, stage)
    whole, via, open_, _ = table(stage)
    for n in whole + sorted(via) + open_:
        if n in recs:
            v, ax, lv = recs[n]
            print(f"{n}\t{v}\tleaves={sorted(l.split(':', 1)[1].replace(NS, '') for l in lv)}")
    for k, v in apps.items():
        print(f"APPLIES {k[0]} <- {k[1]}\t{v}")
    counts = {}
    for n in whole + sorted(via) + open_:
        if n in recs:
            counts[recs[n][0]] = counts.get(recs[n][0], 0) + 1
    print(f"stage {stage}: {len(recs)} records in the output, {len(whole) + len(via) + len(open_)} claimed, {len(apps)} pairings; "
          f"verdicts {dict(sorted(counts.items()))}; findings: {len(bad)}")
    for b in bad:
        print("  FINDING:", b)
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
