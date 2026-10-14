#!/usr/bin/env python3
"""FS131-IPB1: append entries to a port table (data/fs131/ko1/port/<Module>.json), keeping its format (FS131-IPA1's
data/fs131/ipa1/addpatch.py is the pattern, run unchanged for its own keys; this one adds `drop_omit` and
`global_instances` and this job's reason keys).

Usage: addentry.py <Module> patches|adaptations <source line> <old> <new> <reason-key or text>
       addentry.py <Module> drop_omit|global_instances|scoped <source line> <reason-key or text>
Refuses an entry already present, and a reason that is a key or shorter than 40 characters."""
import json
import pathlib
import sys

T = pathlib.Path("/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/data/fs131/ko1/port")
R = {
    "compProd": "at v4.34.1 `compProd_map_condDistrib` takes `hX : AEMeasurable X μ` and `hY : AEMeasurable Y μ`; at "
                "v4.32.0 it takes `hY` only, with the same conclusion (`Mathlib/Probability/Kernel/CondDistrib.lean:82` "
                "at both pins): the first argument is dropped",
    "condDistrib_comp": "at v4.34.1 `condDistrib_comp` takes `hX : AEMeasurable X μ`; at v4.32.0 it takes the map `X` "
                        "itself, explicit, with the same conclusion (`Mathlib/Probability/Kernel/CondDistrib.lean:183` "
                        "here, `:182` there): the map is passed in place of its measurability",
    "eventuallyConst": "at v4.34.1 Mathlib states that a set is eventually empty or everything as "
                       "`Filter.EventuallyEmptyOrUniv s l` (a definition new there, `EventuallyConst (· ∈ s) l`: "
                       "`Mathlib/Order/Filter/EventuallyConst.lean:77`), which `aeconst_of_forall_preimage_smul_ae_eq` "
                       "concludes, with `eventuallyEmptyOrUniv_iff` its unfolding; at v4.32.0 the lemma concludes "
                       "`EventuallyConst s l` and the same unfolding is `Filter.eventuallyConst_set` "
                       "(`EventuallyConst.lean:74` here), with the same right-hand side (as `OAI158Amenability`'s patch "
                       "at `Amenability.lean:385`)",
    "pmap_proof": "the class of `plans/FS131-KO1-port-plan.md` § 3.3, in a PROOF: at v4.34.1 `ProbabilityMeasure.map ν f` "
                  "takes the map and no proof; at v4.32.0 `ProbabilityMeasure.map ν {f} (f_aemble : AEMeasurable f ν)` "
                  "(`Mathlib/MeasureTheory/Measure/ProbabilityMeasure.lean:606`); the measurability is a closed term of "
                  "the proof's context",
    "pmap_adapt": "ADAPTED (plan § 4.3, Amendment 2 of FS131-KO1's brief): at v4.34.1 `ProbabilityMeasure.map ν f` takes "
                  "the map and no proof; at v4.32.0 `ProbabilityMeasure.map ν {f} (f_aemble : AEMeasurable f ν)` "
                  "(`Mathlib/MeasureTheory/Measure/ProbabilityMeasure.lean:606`); the same measure for a measurable map. "
                  "The inserted measurability is a closed term of the statement's context, no hypothesis and no binder",
    "cascade_omit": "part of the ruled cascade of `frequencyLaw` (the coordinator's rulings on FS131-IPA1, Amendments 3 "
                    "and 4 of its brief; item 767 ruling (a)): the declaration's statement names a definition of the "
                    "cascade, which at this pin takes the release's own section variables `[MeasurableMul₂ G] "
                    "[MeasurableInv G]`, so the `omit` of exactly those two cannot stand; the strip check of "
                    "`tools/fs131_ipa1_readback_port.py` (STRIP) shows the stored statement is the release's with those "
                    "binders inserted",
}
mod, key = sys.argv[1], sys.argv[2]
p = T / f"{mod}.json"
t = json.loads(p.read_text()) if p.exists() else {}
t.setdefault(key, [])
if key in ("patches", "adaptations"):
    line, old, new, why = sys.argv[3:7]
    entry = [int(line), old, new, R.get(why, why)]
    same = [e for e in t[key] if e[0] == int(line) and e[1] == old]
else:
    line, why = sys.argv[3:5]
    entry = [int(line), R.get(why, why)]
    same = [e for e in t[key] if e[0] == int(line)]
if same:
    raise SystemExit(f"already present: {same[0]}")
if entry[-1] in R or len(entry[-1]) < 40:
    raise SystemExit(f"a reason that is a key or too short: {entry[-1]!r}")
t[key].append(entry)
p.write_text(json.dumps(t, ensure_ascii=False, indent=1) + "\n")
print(f"{mod}: {key} += {json.dumps(entry, ensure_ascii=False)[:160]}")
