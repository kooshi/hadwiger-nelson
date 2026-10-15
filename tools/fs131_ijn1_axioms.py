#!/usr/bin/env python3
"""FS131-IJN1 — the axioms of every declaration of the ten compiled modules this job writes, read from the output of
`data/fs131/ijn1/lean/Axioms.lean` (run on the built tree). FS131-IJ3's reader (`tools/fs131_ij3_axioms.py`), rewritten
for these modules and this job's classes; that one is not edited.

Each record is classed:
- CLEAN: a subset of the standard three axioms.
- IMPORTED: the standard three and declared outside theorems (`Rigidity.positive_entropy_rigidity`,
  `StandingFive.kloosterman_bound`), at least one, nothing else.
- OPEN-LEAF: `sorryAx` among them (with the standard three and the declared theorems allowed), every `sorry` source one
  of the leaves of other lines (OTHER_LEAVES: M13's six private leaves, the density bound's instance) or M9's `R = O′`
  (off the path).
Exit 0 only if: every record is one of the three; every name in MUST_CLEAN is CLEAN; every name in MUST_IMPORTED is
IMPORTED; the headline's `sorry` sources are exactly HEADLINE_LEAVES; every name in REQUIRED is present; and the planted
record (`PLANT`) reads IMPORTED.
`--control`: plants four faults in memory (an unknown axiom into `noRamifiedStableDyadic_of_tca`; `sorryAx` sourced in a
proved leaf, `ZdAction.mulTwoThree_model`, into `entropySplit`; the declared theorem into `zeroEntropyCarried`; a ninth
source, M9's `R = O′`, into the headline's) and requires exactly those four reported.
Usage: fs131_ijn1_axioms.py <axioms.txt> [--control]
"""
import re
import sys

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
NS = "HadwigerNelson.Rigidity."
MP = "Proofs.HadwigerNelson.Rigidity."
DECLARED = {NS + "positive_entropy_rigidity", "HadwigerNelson.StandingFive.kloosterman_bound"}
M13 = {NS + n for n in ("card_fibre", "norm_charSum_new_le", "ratioAtMost_dyadic", "chromaticNumber_le_four_of_small",
                        "ratioAtMost_cert", "charBound_one_exact")}
DENSITY = {"HadwigerNelson.Plane.upperDensity_le_of_oneAvoidingDensityBound"}
OFF_PATH = {NS + "unitRing_eq_stableIntegers"}
OTHER_LEAVES = M13 | DENSITY | OFF_PATH
HEADLINE = NS + "min_localBound_five_le_chromaticNumber"
HEADLINE_LEAVES = M13 | DENSITY
MUST_CLEAN = {NS + n for n in (
    "noRamifiedStableDyadic_of_tca", "ZdAction.mulTwoThree_model", "zeroEntropyCarried",
    "zeroEntropyCarried_of_numberField", "card_words_badStarts_le", "mul_card_heavyNames_le",
    "mul_measureReal_light_le_blockEntropy", "rpow_mul_exp_le_exp", "exists_forall_exp_le_measureReal_nameCell",
    "exists_admissiblePair", "colorable_two_levelTarget_one_of_isRamified", "mrPlus_of_split_of_carried",
    "min_localBound_five_le_chromaticNumber_of_closed", "Counting.ratio_unramified_of_tca")}
MUST_IMPORTED = {NS + n for n in ("entropySplit", "mrPlus", "haar_or_zero_entropy", "entropySplit_of_admissiblePair",
                                  "min_localBound_five_le_chromaticNumber_closed")}
REQUIRED = sorted(MUST_CLEAN | MUST_IMPORTED | {HEADLINE})


def parse(path):
    recs, srcs, leaves = {}, {}, {}
    for ln in open(path, encoding="utf-8"):
        ln = ln.rstrip("\n")
        m = re.match(r"AXIOMS (\S+) (public|private) (\S+) : \[(.*)\]$", ln)
        if m:
            mod, kind, name, ax = m.groups()
            recs[(mod, name)] = {"kind": kind, "axioms": {a.strip() for a in ax.split(",") if a.strip()}}
            continue
        m = re.match(r"SORRY-FROM (\S+) : \[(.*)\]$", ln)
        if m:
            srcs[m.group(1)] = {a.strip() for a in m.group(2).split(",") if a.strip()}
            continue
        m = re.match(r"SORRY-LEAF (\S+) (\S+) (\S+) l\.(\S+)$", ln)
        if m:
            leaves.setdefault(m.group(1), []).append((m.group(2), m.group(3), m.group(4)))
    return recs, srcs, leaves


def classify(name, ax, srcs):
    extra = ax - STANDARD
    if not extra:
        return "CLEAN", ""
    if extra <= DECLARED:
        return "IMPORTED", ""
    if "sorryAx" in extra and extra <= {"sorryAx"} | DECLARED:
        s = srcs.get(name, set())
        if not s:
            return "BAD", "sorryAx with no source named"
        other = sorted(s - OTHER_LEAVES)
        if other:
            return "BAD", f"sorry sourced outside the other lines' leaves: {other}"
        return "OPEN-LEAF", f"sources {sorted(s)}"
    return "BAD", f"axioms {sorted(extra)}"


def main():
    control = "--control" in sys.argv
    path = [a for a in sys.argv[1:] if not a.startswith("--")][0]
    recs, srcs, leaves = parse(path)
    if not recs:
        print("NO RECORDS — the printer or the reader is broken")
        return 2
    def key(name):
        return next(k for k in recs if k[1] == name)
    if control:
        recs[key(NS + "noRamifiedStableDyadic_of_tca")]["axioms"].add("planted.unknownAxiom")
        recs[key(NS + "entropySplit")]["axioms"].add("sorryAx")
        srcs[NS + "entropySplit"] = {NS + "ZdAction.mulTwoThree_model"}
        recs[key(NS + "zeroEntropyCarried")]["axioms"].add(NS + "positive_entropy_rigidity")
        srcs[HEADLINE] = set(srcs.get(HEADLINE, set())) | OFF_PATH
    present = {name for (_, name) in recs}
    missing = [n for n in REQUIRED if n not in present]
    if missing:
        print(f"MISSING RECORDS: {missing}")
        return 2
    bad, counts = [], {}
    plant_ok = False
    for (mod, name), r in sorted(recs.items()):
        cls, why = classify(name, r["axioms"], srcs)
        if mod == "PLANT":
            plant_ok = cls == "IMPORTED"
            print(f"PLANT {name}: {cls} (must read IMPORTED)")
            continue
        counts.setdefault(mod, {}).setdefault(cls, 0)
        counts[mod][cls] += 1
        tag = f"{cls:9} {mod.replace(MP, '')} {r['kind']} {name} : {sorted(r['axioms'])}" + (f" — {why}" if why else "")
        print(tag)
        if cls == "BAD":
            bad.append(tag)
        elif name in MUST_CLEAN and cls != "CLEAN":
            bad.append(f"NOT CLEAN {name}: {cls}")
        elif name in MUST_IMPORTED and cls != "IMPORTED":
            bad.append(f"NOT IMPORTED {name}: {cls}")
    hs = srcs.get(HEADLINE, set())
    if hs != HEADLINE_LEAVES:
        bad.append(f"HEADLINE  sorry sources {sorted(hs)} differ from the expected {sorted(HEADLINE_LEAVES)}")
    print("THE HEADLINE'S LEAVES:")
    for (src, mod, line) in sorted(leaves.get(HEADLINE, [])):
        print(f"  {src} ({mod.replace('Proofs.HadwigerNelson.', '')}, l. {line})")
    for mod, c in sorted(counts.items()):
        print(f"COUNT {mod.replace(MP, '')}: " + ", ".join(f"{k} {v}" for k, v in sorted(c.items())))
    print(f"RECORDS {sum(sum(c.values()) for c in counts.values())}")
    if not plant_ok:
        bad.append("PLANT: the planted record did not read IMPORTED")
    for b in bad:
        print("FAIL " + b)
    if control:
        ok = len(bad) == 4
        print(f"CONTROL: {len(bad)} of 4 planted faults reported — "
              f"{'the check can fail' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
        return 0 if ok else 1
    print("PASS" if not bad else f"FAIL: {len(bad)}")
    return 0 if not bad else 1


if __name__ == "__main__":
    sys.exit(main())
