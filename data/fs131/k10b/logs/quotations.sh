#!/bin/bash
# FS131-K10b stage 1: each quotation of the brief, grep -F in the file the brief names.
M=/home/kooshi/source/lean-dir
W=$M/.claude/worktrees/fs131-w10k
chk () { # file, string
  if grep -qF -- "$2" "$1"; then echo "MATCH  | $(basename $1) | ${2:0:90}"; else echo "MISS   | $(basename $1) | ${2:0:90}"; fi
}
chk $M/CLAUDE.md "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time."
chk $M/plans/FS131-close-inventory.md "484. **FS131-K10 done at its Stage 5: wave 10 planned — dispositions for all fourteen rows, a foundation, a skeleton of eleven, four rows"
chk $M/plans/FS131-close-inventory.md "485. **Rulings on K10's held items, and its slot.** (a) **Three implementers by file, as it splits them**; the first, FS131-I10A"
chk $M/plans/FS131-close-inventory.md "493. **FS131-I10A done: all nine leaves of wave 10's first file pair proved — \`SpectralInputs\` and \`CharacterColouring\` hold no \`sorry\`, over"
chk $M/plans/FS131-close-inventory.md "494. **Rulings on I10A's held items, and its slot.** (a) **The two unread instance arguments are dropped from the statements** —"
chk $M/plans/FS131-close-inventory.md "491. **FS131-E8 done: nine entries derived, none stalled — the bridge (item 490, its §§ 3.1–3.7 unchanged since), the consumers traced row by"
chk $M/plans/FS131-close-inventory.md "492. **Rulings on E8's held items, and its slot.** (a) **REG-J′ and C121-REGJ keep their frozen words in the stubs' question sections and"
chk $M/plans/FS131-kernel-plan.md "### 7.3 What each wave's planning job must hold"
chk $M/plans/FS131-kernel-plan.md "3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in"
chk $M/plans/FS131-kernel-plan.md "4. **Names every hypothesis from outside the backlog** in the declaration's docstring and in § 7.4's list; never imports a hand result of ours as an"
chk $W/plans/FS131-w10-kernel-plan.md "### 3.3 The rows not stated, and what stating them needs"
chk $W/plans/FS131-w10-kernel-plan.md "- **J45-N1 (a), (b)**: the topology \`τ′_S\` on \`R = unitRing F\` as an infimum of three induced topologies — profinite (finite-order characters),"
chk $W/plans/FS131-w10-kernel-plan.md "- **J45-SI-J**: complex \`L²\`, spectral measures of vectors, the spectral measure of a tensor of independent factors as a convolution, and"
chk $W/plans/FS131-w10-kernel-plan.md "- **J45-SI-5**: SI-J, SI-3 (not a row), rotation by \`U\`, and the frequency argument \"its colour has frequency ≥ 2/3\" — as written it cites ergodic"
chk $W/plans/FS131-w10-kernel-plan.md "- **J45-SI-C**: SI-J with no \`c₂\`, and four finite facts about \`γ = ⌊4(2x + 3y)/7⌋\` on \`Γ₇\` (49 vertices, 392 directed edges): a \`decide\`,"
chk $W/plans/FS131-w10-kernel-plan.md "**What proving the floor in Lean would take** (Keryx's ask; a candidate row for a later wave). (i) \`χ(U₁₂₈) ≥ 7\`: Hoffman's ratio bound for a"
chk $M/plans/FS131-E8-derivation.md "derivation: FS131-E8-SI5C"
chk $M/plans/FS131-E8-derivation.md "  handoff: de Bruijn — it replaces \"ergodic averages along a tempered Følner sequence\" in J45-SI-5 (c) for wave 10's second planning pass:"
chk $W/plans/FS131-I10A-implementation.md "2. **\`sp_if\`'s hypothesis \`hcirc : I.NegCircle\` has no model in the file.** The plan's § 5.5 prices one at \`Interface.trivial\` at \"an hour\""
chk $W/plans/FS131-I10A-implementation.md "3. **To apply \`si4_equivariant\` to \`𝒜 = factorSigma\`** one needs \`(factorSigma T hT l).comap (T x) = factorSigma T hT l\`."
