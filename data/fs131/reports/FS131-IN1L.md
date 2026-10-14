JOB FS131-IN1L (brief FS131-IN1-three-lanes) — DONE   harness≈300k (own≈250k)

RESULT:
- **Lane H — TRUE, all 7 leaves [kernel].** `Rigidity/HaarMultiple` proves:
  - `maxMultiple_smul_le` and `smul_le_iff_le_maxMultiple`;
  - `maxMultiple_le_measure_univ` and `sub_maxMultiple_add`;
  - `not_smul_le_sub_maxMultiple` and `map_sub_maxMultiple`;
  - `maxMultiple_self`.

  Each rests on `[propext, Classical.choice, Quot.sound]`. They are read against EN2-PE2-MAX step 1
  (`plans/FS131-EN2-derivation.md` § 5.2): the largest multiple `a` of Haar below `τ` is attained, `a ≤ τ(X)`,
  `τ − a·m` is a finite invariant measure, and no `c > 0` has `c·m ≤ τ − a·m`.
- **Lane C — TRUE, all leaves [kernel].** In `Rigidity/ChainAtTA`:
  - `measurableSet_TA`: `T + A` is measurable for the cylinder σ-algebra, at every real number field;
  - `rot_preimage_TA`: every rotation fixes `T + A`;
  - `exists_nonTorsion_unitVector`: `(3 + 4i)/5` is not torsion, at every subfield of `ℝ`;
  - two additions by your ruling: `rotInv_dirac_one` (the point mass at `1` is rotation-invariant) and
    `zeroEntropyCarried_model` (that point mass meets `ZeroEntropyCarried`'s hypotheses at every non-torsion
    vector, and its conclusion).

  All rest on the standard three. They are read against J45 Lemma N1 at `S = ∅`, and the second planner's § 3a.3.
- **Lane N — TRUE, all 9 leaves [kernel].** In `Rigidity/ZeroEntropyNames`:
  - EN2-CNT, `card_words_badStarts_le`: at most `(2a)^{θn+k} g^{2n/k}` words have at most `θn` bad starts;
  - EN2-ZE, `exists_forall_exp_le_measureReal_nameCell`: entropy zero puts every name cell above `e^{−βn}` on a
    set of mass `≥ 1 − η` for `n ≥ N₀`;
  - its six children: `mul_card_heavyNames_le`, `mul_measureReal_light_le_blockEntropy`, the maximal inequality
    `measure_frequentVisits_le` (the port's theorem, unfolded), `badStarts_nameOf_le_visits`,
    `rpow_mul_exp_le_exp`, `measureReal_lightCells_le`.

  In `Rigidity/SolenoidErgodic`, `ZdAction.IsErgodicOn.null_or_conull_of_ae_invariant`: strict ergodicity gives
  ergodicity for almost-invariant sets. All rest on the standard three. They are read against EN2-CNT and EN2-ZE
  (`plans/FS131-EN2-derivation.md` § 3.5) and KN7 § 2.3.
- **Consequence — TRUE [kernel].** The chain's headline with closed hypotheses,
  `min_localBound_five_le_chromaticNumber_of_closed`, now rests on the standard three. So do `chainInterface`,
  `five_le_chromaticNumber_of_mrPlus` and `entropySplit_of_every`. All four rested on `sorryAx` through lane C's
  leaves at the third planner's hand-back.
- **No statement and no definition changed**, from the kernel's side. All 61 named constants are the same. Exactly two
  are ADDED, the ruled pair. The control fired 6 of 6. The import `Outside/OAI015Maximal` moved no stored statement.
- **Build 4 is green.** No warning comes from this job's files. The only warnings are five `sorry`s, none of them mine.
- **Axioms of all 109 records of the four modules, from the built tree:**
  - 104 rest on the standard three or fewer;
  - 5 are not mine and rest on `sorry` from the three leaves not mine;
  - none rests on the declared printed theorem;
  - the planted record and a planted copy both fire.
- **The rest of the gate on this tree:** lint passed (14 linters). dupnames reports OK. The architecture check FAILS on
  one cell, which is not mine to edit (held below).

RECORD: plans/FS131-IN1L-implementation.md (branch fs131-wl1, tree .claude/worktrees/fs131-wch)   COMMITS: ac70d2c87 (the join) 8ea0ecd20 8522cff9e c862f6275 11a5fdfa7 458569aaa f63c3cfcf e1b7878cb, and this report's commit

INVENTORY:
- result — 21 kernel theorems on the standard three (lanes H, C and N) — record § Theorems this phase proved
- result — the headline with closed hypotheses is now sorry-free on the standard three. Before this job it held
  `sorryAx` (`data/fs131/kn7/logs/lean-axioms-check.log`); after, `data/fs131/in1l/axioms-after.txt` — record
  § Theorems this phase proved
- slip (the brief's, ruled) — the job id FS131-IN1 and all three of its paths were already taken on main by the
  torsion-theorem job. Renamed FS131-IN1L by your word — record header
- statement defect (the brief's, ruled) — lane C's fourth leaf was untyped. It is added as `rotInv_dirac_one` and
  `zeroEntropyCarried_model`, read against KN6 § 3a.3 — record § 1.2 and § Stage 2
- correction owed — `ARCHITECTURE.md`'s row of `Rigidity/ZeroEntropyNames` lacks the import `Outside/OAI015Maximal`.
  `tools/check_architecture.py` fails until it is filed. The rows of the three skeleton modules are stale — record
  § Drafts, `ARCHITECTURE.md`
- correction owed — four module docstrings still say "skeleton"/"leaves" for proved leaves, and `ZeroEntropyNames`
  still says "until the port is joined" — record § Drafts, module docstrings
- tool defect (an instrument note) — one `linarith` over a hypothesis about `badStarts` made Lean generate
  `badStarts.congr_simp`, a public constant. The statement check caught it and it is removed.
  `Environment.contains` skips realized constants unless `skipRealize := false` — record § Stage 4, `LEAN.md` draft
- statement observation (not a defect) — five hypotheses the proofs do not read:
  - `hc` of `mul_card_heavyNames_le`;
  - `hγ` of the Markov leaf;
  - `hθ` of `rpow_mul_exp_le_exp`;
  - `hθ` and `hn` of `card_words_badStarts_le`.

  Each is referenced by `have _ :=` for the unused-variables linter — record § Drafts, statement observations
- result — two elaborated model drafts, for `map_sub_maxMultiple` and `rpow_mul_exp_le_exp`, the only hypotheses
  without one in the library — `data/fs131/in1l/work/ModelDrafts.lean`
- result — the audit block, 58 `#print axioms` lines for CLEAN — `data/fs131/in1l/audit-block.lean`

HELD FOR THE COORDINATOR:
- The `ARCHITECTURE.md` import cell. It is outside my touches and the architecture check fails until it is filed.
  Alternative: allow me the one cell.
- The stale module docstrings. They are prose outside my touches, and an edit recompiles only `Proofs` today.
- The branch `fs131-wl1` is not pushed (the brief). The tree's compiled library is current for its head. Delete it or
  reuse it: your call.
- Lane C's re-price: 55 minutes for H and C together. Lane N took about 2 hours against the plan's "N1 is the
  longest".
