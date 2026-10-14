#!/usr/bin/env python3
"""FS131-IPA1: append entries to a port table (data/fs131/ko1/port/<Module>.json), keeping its format.

Usage: addpatch.py <Module> patches <source line> <old> <new> <reason-key or text>
       addpatch.py <Module> adaptations <source line> <old> <new> <reason-key or text>
Reason keys name the reasons below (one text per kind of change, so that every entry of a kind reads alike).
Refuses an entry already present (same line and old token).
"""
import json
import pathlib
import sys

T = pathlib.Path("/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/data/fs131/ko1/port")
R = {
    "if_pos": "core renamed `if_pos` to `ite_eq_left` after v4.32.0 (with `if_neg` → `ite_eq_right`: `LEAN.md` § Searching "
              "— Lean); at v4.32.0 only the old name, the same statement (`Init/Core.lean` at v4.34.1: `theorem if_pos … := "
              "ite_eq_left hc`)",
    "if_neg": "core renamed `if_neg` to `ite_eq_right` on 2026-07-21 (`LEAN.md`; FS132-I2's patch); at v4.32.0 only the "
              "old name, the same statement",
    "prod_le_prod": "Mathlib renamed `Finset.prod_le_prod` to `Finset.prod_le_prod₀` after v4.32.0; at v4.32.0 the lemma "
                    "has the old name, the same hypotheses and statement (`Mathlib/Algebra/Order/BigOperators/"
                    "GroupWithZero/Finset.lean:38` here, `:39` at v4.34.1)",
    "of_eval": "`Measurable.of_eval` (v4.34.1, `Mathlib/MeasureTheory/MeasurableSpace/Constructions.lean:596`, proved "
               "there as `measurable_pi_iff.mpr hf`) is not at v4.32.0; `measurable_pi_lambda` (`Constructions.lean:590` "
               "here) is the same statement with the function explicit, which `apply` unifies",
    "compProd": "at v4.34.1 `compProd_map_condDistrib` takes `hX : AEMeasurable X μ` and `hY : AEMeasurable Y μ`; at "
                "v4.32.0 it takes `hY` only, with the same conclusion (`Mathlib/Probability/Kernel/CondDistrib.lean:82` "
                "at both pins): the first argument is dropped",
    "eLpNorm": "at v4.34.1 `eLpNorm_congr_norm_ae` takes `hf : AEStronglyMeasurable f μ` and `hg : AEStronglyMeasurable "
               "g μ` before `hfg`; at v4.32.0 it takes `hfg` only, with the same conclusion (`Mathlib/MeasureTheory/"
               "Function/LpSeminorm/Basic.lean:411` here, `:452` there): the two measurability arguments are dropped",
    "condDistrib_comp": "at v4.34.1 `condDistrib_comp` takes `hX : AEMeasurable X μ`; at v4.32.0 it takes the map `X` "
                        "itself, explicit, with the same conclusion (`Mathlib/Probability/Kernel/CondDistrib.lean:183` "
                        "here, `:182` there): the map is passed in place of its measurability",
    "condDistrib_self": "at v4.34.1 `condDistrib_self` takes `hY : AEMeasurable Y μ`; at v4.32.0 it takes the map `Y` "
                        "itself, explicit, with the same conclusion (`Mathlib/Probability/Kernel/CondDistrib.lean:204` "
                        "here, `:199` there): the map is passed in place of its measurability",
    "probmap_proof": "the class of `plans/FS131-KO1-port-plan.md` § 3.3, in a PROOF: at v4.34.1 `μ.map f` of a probability "
                     "measure is one by an instance for every `f`; at v4.32.0 only through "
                     "`Measure.isProbabilityMeasure_map (hf : AEMeasurable f μ)` (`Mathlib/MeasureTheory/Measure/"
                     "Typeclasses/Probability.lean:124`). The instance is supplied by `haveI` from the measurability the "
                     "proof's context holds; the statement is untouched",
    "setOf": "Mathlib renamed `setOf` and its lemmas to `Set.ofPred` on 2026-07-09 (`LEAN.md` § Searching — Lean; "
             "FS132-I2's patches); at v4.32.0 the lemma is `Set.mem_setOf_eq`, the same statement",
}
mod, key, line, old, new, why = sys.argv[1:7]
p = T / f"{mod}.json"
t = json.loads(p.read_text()) if p.exists() else {}
t.setdefault(key, [])
for e in t[key]:
    if e[0] == int(line) and e[1] == old:
        raise SystemExit(f"already present: {e}")
t[key].append([int(line), old, new, R.get(why, why)])
for k in ("patches", "adaptations"):
    for e in t.get(k, []):
        if e[3] in R:
            e[3] = R[e[3]]
        if e[3] in R or len(e[3]) < 40:
            raise SystemExit(f"a reason that is a key or too short: {e}")
p.write_text(json.dumps(t, ensure_ascii=False, indent=1) + "\n")
print(f"{mod}: {key} += [{line}, {old!r} → {new!r}]")
