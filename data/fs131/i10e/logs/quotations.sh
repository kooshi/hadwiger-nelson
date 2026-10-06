#!/usr/bin/env bash
# FS131-I10E: the brief's quotations against their sources (standing rule 3). grep -F of each quoted string.
# Usage: quotations.sh <worktree> <main tree>
W="$1"; M="$2"
n=0; ok=0
chk () { # file, string
  n=$((n+1))
  if grep -qF -- "$2" "$1"; then ok=$((ok+1)); echo "MATCH   $1 :: ${2:0:70}"; else echo "MISSING $1 :: ${2:0:70}"; fi
}
chk "$M/CLAUDE.md" "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time."
chk "$M/plans/FS131-close-inventory.md" "509. **FS131-K10b done at its Stage 9: wave 10's second planning pass — the finite-target floor stated as two rows, the read-backs"
chk "$M/plans/FS131-close-inventory.md" "510. **Rulings on K10b's held items, and its slot.** (a) **Three implementers by file, as it splits them**, on branches cut from"
chk "$M/plans/FS131-close-inventory.md" "500. **FS131-K10b, by message mid-job, before stating the floor's import: the bound for the circle sums is a theorem of the held"
chk "$M/plans/FS131-close-inventory.md" "503. **FS131-K10b, by message mid-job: J45-SI-J holds at a wider class by a shorter route — no spectral measure, no \"Bernoulli has"
chk "$W/Proofs/HadwigerNelson/Arith/Floor128.lean" "theorem charSum_128_ge {k : Type} [Field k] [Fintype k] [DecidableEq k] (hcard : Fintype.card k = 128 ^ 2)"
chk "$W/Proofs/HadwigerNelson/Arith/Floor128.lean" "theorem targetFloor_eight_128 : TargetFloor 8 128 :="
chk "$W/plans/FS131-w10-kernel-plan.md" "### 7.2 Row (i) — the target at 128, no outside theorem: \`Floor128.targetFloor_eight_128 : TargetFloor 8 128\`"
chk "$W/plans/FS131-w10-kernel-plan.md" "### 7.1 The ratio bound — where it lives, and its class"
chk "$W/plans/FS131-w10-kernel-plan.md" "### 9.3 Prices (re-priced from this pass's proved leaves: the ratio bound, 170 lines in two rounds; \`GapSeven\`, eight facts in one)"
chk "$W/plans/FS131-w10-kernel-plan.md" "### 9.4 For the joining job"
chk "$W/Proofs/HadwigerNelson/Arith/FloorPlanes.lean" "theorem exists_mulShift_eq {F : Type*} [Field F] [Finite F] (ψ₀ : AddChar F ℂ) (hψ₀ : ψ₀ ≠ 1) (φ : AddChar F ℂ) :"
chk "$W/Proofs/HadwigerNelson/Arith/NormOneTarget.lean" "theorem card_normOne {k : Type*} [Field k] [Fintype k] [DecidableEq k] {Q : ℕ} (hcard : Fintype.card k = Q ^ 2) :"
chk "$W/Proofs/HadwigerNelson/Arith/NormOneTarget.lean" "theorem card_filter_pow_eq_one {k : Type*} [Field k] [Fintype k] [DecidableEq k] {d : ℕ} (hd0 : d ≠ 0)"
# the negative control: a string that is in none of the files must read MISSING
n=$((n+1))
if grep -qF -- "FS131-I10E-planted-string-that-is-nowhere" "$W/plans/FS131-w10-kernel-plan.md"; then echo "CONTROL BROKEN"; else echo "CONTROL  (planted string reads missing, as it must)"; n=$((n-1)); fi
echo "$ok of $n match"
[ "$ok" -eq "$n" ]
