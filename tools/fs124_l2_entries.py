#!/usr/bin/env python3
"""FS124-L2: the milestone's thirty entries — which are kernel theorems after this landing and which stay by hand.

Reads the theorem record (`plans/FS124-derivation.md`: `derivation: <id>` blocks with `statement:`, `not claimed:`,
`verdict:`, `handoff:`), the ledger's rows 161–163, the kernel claim list (`data/fs124/claims-K2.md`) and the gate's
saved axioms log, and checks the table CLASS below, which is this job's reading and is written here once:

  ENTRIES     the entries of the theorem record are exactly the table's keys (thirty)
  ROW         a kernel entry's statement stands word for word (whitespace apart) in the ledger row named for it
  LIST        each of the nine entries of the second module stands word for word in the kernel claim list, with its
              *not claimed* line
  RECORD      every Lean name the table gives has exactly one record in the audit's log, under the banner the table
              says (CLEAN, or IMPORTED for the two of the first module that rest on a declared outside theorem)

Usage: fs124_l2_entries.py DERIVATION LEDGER CLAIMS AXIOMS_LOG [--plant] [--table]
  --table   print the table as markdown rows (for the record)
  --plant   four faults in memory, one at a time (an entry the table lacks; a word changed in a statement; a Lean
            name with no record; a record under the wrong banner), each required to be refused; the unplanted
            inputs must pass first.
Exit 0 when every check holds (or every plant fired); 1 otherwise.
"""
import re
import sys
from pathlib import Path

P = "HadwigerNelson.Plane."
# id -> (state, lean names, ledger row, note).  state: K1 = kernel since FS124-L1; K2 = kernel by this landing;
# H = stays by hand, with its reason.
CLASS = {
    "C124-RADIUS-GRAPH": ("K1", ["radius_graph"], 161, ""),
    "C124-RADIUS-COUNTABLE": ("K1", ["radius_countable"], None, ""),
    "C124-RADIUS-UP": ("K1", ["radius_up"], 161, ""),
    "C124-RADIUS-DOWN": ("K1", ["radius_down"], 161, "on the declared outside theorem `proper_to_borel_weak`"),
    "C124-RADIUS-FIVE": ("K1", ["radius_five"], 161, "on the declared outside theorem `no_proper_five_coloring`"),
    "C124-EVERY-DIRECTION": ("H", [], None, "no kernel job: stated in no module (FS124-L1's open item 1)"),
    "C124-SHADOW-OPEN": ("K2", ["shadow_open"], 162, ""),
    "C124-TYPE": ("K2", ["piece_type"], 162, "wider than the entry: no hypothesis |w − x| = 1"),
    "C124-CENTRE-HALF": ("K2", ["centre_half"], 162, ""),
    "C124-CENTRE": ("K2", ["tight_centre"], None, ""),
    "C124-STRADDLE": ("K2", ["tight_straddle"], 162, ""),
    "C124-COMPLETION": ("H", [], None, "no kernel job: a corollary of C124-STRADDLE at one point, stated in no module "
                                       "(its handoff: \"subsumed by C124-STRADDLE, which crosses\")"),
    "C124-ANTIPODE": ("H", [], None, "no kernel job: handed off \"as written\" and not among the nine a planner fixed"),
    "C124-OPEN": ("H", [], None, "no kernel job: a relay-result (its handoff: none)"),
    "C124-FORCED-PIECES": ("K2", ["closePair_forced_pieces"], 163, ""),
    "C124-FORCED": ("H", [], None, "no kernel job for the entry: its first sentence follows from the kernel's C124-BOTH "
                                   "(`closePair_both_saved_of_isSector`: saved by both); its second, tightness along the "
                                   "arc, is stated in no module; its topological input is now a kernel theorem "
                                   "(`IsTriodCut.exists_opposite`)"),
    "C124-FORCED-AS-POSED": ("H", [], None, "a refutation by a held object (fragment BB with a band): no kernel job"),
    "C124-LONE": ("K2", ["closePair_lone"], 163, ""),
    "C124-LONE-EXISTS": ("H", [], None, "needs a held object's tiles: the entry's object is fragment S1 with a band; the "
                                        "kernel holds the same sentence by another witness "
                                        "(`exists_closePair_not_separatesAt`, on `lonePair`)"),
    "C124-BOTH": ("K2", ["closePair_both_separate", "closePair_both_saved", "closePair_both_saved_of_isSector"], 163,
                  "first clause; second clause in both forms — for arc-edged decompositions, and in the list's words "
                  "for sector points over the three-arcs lemma"),
    "C124-FOUR": ("K2", ["closePair_four"], 163, ""),
    "C124-SECOND": ("H", [], None, "no kernel job: handed off \"after C124-FOUR\" and not among the nine"),
    "C124-EDGE-CLOSED": ("H", [], None, "needs a held object's tiles (FS-112's strip); its handoff: only with a consumer"),
    "C124-EDGE": ("H", [], None, "a computation on one held object; subsumed by C124-EDGE-CLOSED"),
    "C124-SIX": ("H", [], None, "no kernel job: handed off \"after C124-CENTRE\" and not among the nine"),
    "C124-SIX-CONES": ("H", [], None, "no kernel job: subsumed by C124-SIX"),
    "C124-HALF": ("H", [], None, "no kernel job: over the inherited C132-WIT-SIDE, whose module is not built"),
    "C124-HALF-TWO": ("H", [], None, "no kernel job: subsumed by C124-HALF's module"),
    "C124-KIND": ("H", [], None, "a calibration at seven by formula; its handoff: only with a consumer"),
    "C124-FORCED-SEVEN": ("H", [], None, "needs a held object (the hexagonal seven-colouring); the kernel holds a control "
                                         "of the same kind on another object (`exists_closePair_seven_not_separatesAt`)"),
}
IMPORTED = {"radius_down", "radius_five"}
NINE = ["C124-SHADOW-OPEN", "C124-TYPE", "C124-CENTRE-HALF", "C124-CENTRE", "C124-STRADDLE", "C124-FORCED-PIECES",
        "C124-LONE", "C124-BOTH", "C124-FOUR"]


def norm(s):
    return re.sub(r"\s+", " ", s).strip()


def entries(text):
    out = {}
    for m in re.finditer(r"^derivation: (\S+)\n((?:  .*\n)+)", text, re.M):
        out[m.group(1)] = dict(re.findall(r"^  ([a-z ]+): (.*)$", m.group(2), re.M))
    return out


def rows(text):
    return {int(m.group(1)): norm(m.group(0)) for m in re.finditer(r"^\| (\d+) \|.*$", text, re.M)}


def check(ents, led, claims, recs, table):
    bad = []
    if set(ents) != set(table):
        bad.append(f"ENTRIES: in the record and not the table {sorted(set(ents) - set(table))}; "
                   f"in the table and not the record {sorted(set(table) - set(ents))}")
    by = {}
    for n, ax, sec in recs:
        by.setdefault(n, []).append(sec)
    for i, (state, names, row, _) in table.items():
        if i not in ents:
            continue
        st = norm(ents[i].get("statement", ""))
        if state != "H" and row is not None and st not in led.get(row, ""):
            bad.append(f"ROW {i}: its statement does not stand word for word in row {row}")
        if i in NINE:
            if st not in claims:
                bad.append(f"LIST {i}: its statement does not stand word for word in the kernel claim list")
            if norm(ents[i].get("not claimed", "")) not in claims:
                bad.append(f"LIST {i}: its not-claimed line does not stand word for word in the kernel claim list")
        for n in names:
            want = "IMPORTED" if n in IMPORTED else "CLEAN"
            got = by.get(P + n, [])
            if got != [want]:
                bad.append(f"RECORD {n} ({i}): expected one record under {want}; found {got}")
    return bad


def main(argv):
    a = [x for x in argv if not x.startswith("--")]
    if len(a) != 4:
        print(__doc__)
        return 2
    sys.path.insert(0, str(Path(__file__).resolve().parent))
    import fs124_l1_records as e
    ents = entries(open(a[0], encoding="utf-8").read())
    led = rows(open(a[1], encoding="utf-8").read())
    claims = norm(open(a[2], encoding="utf-8").read())
    recs = e.l1.l10b.records(open(a[3], encoding="utf-8").read())
    if not ents or not led or not recs:
        print(f"UNREADABLE: entries {len(ents)}, ledger rows {len(led)}, records {len(recs)}")
        return 2
    bad = check(ents, led, claims, recs, CLASS)
    if "--plant" in argv:
        if bad:
            print(f"PLANT NOT RUN: the unplanted inputs already fail ({len(bad)})")
            for b in bad:
                print("FAIL", b)
            return 1
        import copy
        ps = []
        t = dict(CLASS); del t["C124-KIND"]; ps.append(("an entry the table lacks (C124-KIND)", "ENTRIES", ents, led, recs, t))
        e2 = copy.deepcopy(ents); e2["C124-LONE"]["statement"] = e2["C124-LONE"]["statement"].replace("does not separate", "separates")
        ps.append(("a word changed in a statement (C124-LONE)", "ROW C124-LONE", e2, led, recs, CLASS))
        r2 = [r for r in recs if r[0] != P + "closePair_four"]; ps.append(("a Lean name with no record (closePair_four)", "RECORD closePair_four", ents, led, r2, CLASS))
        r3 = [(n, ax, "IMPORTED" if n == P + "shadow_open" else sec) for n, ax, sec in recs]
        ps.append(("a record under the wrong banner (shadow_open)", "RECORD shadow_open", ents, led, r3, CLASS))
        ok = True
        for label, prefix, pe, pl, pr, pt in ps:
            pb = check(pe, pl, claims, pr, pt)
            fired = [b for b in pb if b.startswith(prefix)]
            print(f"plant: {label}: {'FIRED' if fired else 'DID NOT FIRE'} — {fired[0][:150] if fired else pb[:2]}")
            ok = ok and bool(fired)
        print("plants: every one of 4 fired; the unplanted inputs pass" if ok else "plants: FAILED")
        return 0 if ok else 1
    k1 = [i for i, v in CLASS.items() if v[0] == "K1"]
    k2 = [i for i, v in CLASS.items() if v[0] == "K2"]
    h = [i for i, v in CLASS.items() if v[0] == "H"]
    if "--table" in argv:
        print("| entry | after this landing | Lean | note |")
        print("|---|---|---|---|")
        for i, (state, names, row, note) in CLASS.items():
            s = {"K1": "kernel, since FS124-L1", "K2": "**kernel, by this landing**", "H": "by hand"}[state]
            print(f"| {i} | {s} | {', '.join('`' + n + '`' for n in names) or '—'} | {note or '—'} |")
    print(f"entries: {len(ents)}; kernel since FS124-L1: {len(k1)}; kernel by this landing: {len(k2)}; by hand: {len(h)}")
    for b in bad:
        print("FAIL", b)
    print("entries: PASS" if not bad else f"entries: FAIL ({len(bad)})")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
