#!/usr/bin/env bash
# FS131-I10F: the brief's quotations against their sources (standing rule 3). grep -F of each quoted string.
# Run from the worktree root. MAIN is the main checkout (the inventory and CLAUDE.md are filed there).
MAIN=/home/kooshi/source/lean-dir
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10f
n=0; ok=0
chk() { # file, string
  n=$((n+1))
  c=$(grep -cF -- "$2" "$1")
  if [ "$c" -ge 1 ]; then ok=$((ok+1)); echo "MATCH ($c)  $1 :: ${2:0:90}"; else echo "MISMATCH  $1 :: ${2:0:90}"; fi
}
chk "$MAIN/CLAUDE.md" "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time."
chk "$MAIN/plans/FS131-close-inventory.md" "509. **FS131-K10b done at its Stage 9: wave 10's second planning pass — the finite-target floor stated as two rows, the read-backs"
chk "$MAIN/plans/FS131-close-inventory.md" "510. **Rulings on K10b's held items, and its slot.** (a) **Three implementers by file, as it splits them**, on branches cut from"
chk "$MAIN/plans/FS131-close-inventory.md" "500. **FS131-K10b, by message mid-job, before stating the floor's import: the bound for the circle sums is a theorem of the held"
chk "$MAIN/plans/FS131-close-inventory.md" "503. **FS131-K10b, by message mid-job: J45-SI-J holds at a wider class by a shorter route — no spectral measure, no \"Bernoulli has"
chk "$W/Proofs/HadwigerNelson/Arith/ProductFactor.lean" "theorem contVec_prod_eq [AddCommGroup R] [Finite Ω₁] [MeasurableSingletonClass Ω₁] [IsProbabilityMeasure μ₁]"
chk "$W/Proofs/HadwigerNelson/Arith/MajorityVote.lean" "theorem ae_eq_measurable_of_majority {Ω I K : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ]"
chk "$W/Proofs/HadwigerNelson/Arith/NegCircleModel.lean" "theorem exists_parityHom :"
chk "$W/Proofs/HadwigerNelson/Arith/NegCircleModel.lean" "theorem negCircle_trivial_bot : (Interface.trivial (⊥ : Subfield ℝ)).NegCircle := by"
chk "$W/plans/FS131-w10-kernel-plan.md" "### 8.1 J45-SI-J — stated at a wider class, by a route with no spectral theory (\`Arith/ProductFactor.lean\`)"
chk "$W/plans/FS131-w10-kernel-plan.md" "### 8.2 The deriver's lemma FS131-E8-SI5C (\`Arith/MajorityVote.lean\`, \`ae_eq_measurable_of_majority\`, the leaf)"
chk "$W/plans/FS131-w10-kernel-plan.md" "### 8.5 A model of \`Interface.NegCircle\` (\`Arith/NegCircleModel.lean\`; two leaves, not proved)"
chk "$W/plans/FS131-w10-kernel-plan.md" "### 9.3 Prices (re-priced from this pass's proved leaves: the ratio bound, 170 lines in two rounds; \`GapSeven\`, eight facts in one)"
chk "$W/plans/FS131-w10-kernel-plan.md" "### 9.4 For the joining job"
echo "TOTAL: $ok of $n match"
[ "$ok" -eq "$n" ]
