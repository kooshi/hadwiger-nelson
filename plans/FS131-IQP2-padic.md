# FS131-IQP2 — the p-adic plane to the gate: the ruled drops, five colours at 23, lint, the gate, the read-aloud and the drafts

*de Bruijn, the kernel lane's implementer. Brief `data/fs131/briefs/FS131-IQP2-padic.md` (on `main`; a copy is
`data/fs131/iqp2/brief-copy.md`). Worktree `.claude/worktrees/il5`, branch `fs131-kpa1`, at `ab6a2f288`. The predecessor's
record is `plans/FS131-IQP1-padic.md`; the plan is `plans/FS131-KPA1-padic-plan.md`. No fence. Started 2026-10-16.
Stopped at a pause Kooshi called, after stage 1.*

## Theorems this phase proved

None. Stage 1 (the readback) only; no Lean file edited, no build run.

## Stage 1 — SAVED: the readback

### 1.1 The quotations

The brief's two quotations (inventory items 1014 and 1002, `plans/FS131-close-inventory.md`), checked with line breaks
folded by the planner's checker, unchanged (`tools/fs131_kpa1_quotes.py`):

- against this worktree's copy of the inventory: **both verbatim** (`data/fs131/iqp2/quotes.out`, exit 0);
- against `main`'s copy (`--root /home/kooshi/source/lean-dir`): **both verbatim** (`data/fs131/iqp2/quotes-main.out`, exit 0);
- the planted control (one character of the first quotation changed) is refused: exit 1, `[0] NOT FOUND`
  (`data/fs131/iqp2/quotes-plant.out`).

The branch is at `ab6a2f288`, as the brief says; `git status` shows no tracked change (only the predecessor's untracked
logs under `data/fs131/iqp1/` and `data/fs131/kpa1/`).

### 1.2 What is left, in order

1. **The two ruled drops** (item 1014, ruling (1)), in `Proofs/HadwigerNelson/PadicPlane/Tower.lean`:
   - `exists_levelEmbedding` (l. 344): delete the binder `(hk : 1 ≤ k)` (l. 346) and the line `have _ := hk` with its
     comment (ll. 349–350). Its one call site is `towerRatio_of_ratioAtMost`, l. 421:
     `exists_levelEmbedding p P hpP h2 hQ k hk` becomes `exists_levelEmbedding p P hpP h2 hQ k`. The proof reads `hpP` (l. 378,
     for `p ≠ 2`), so `hpP` stays in this theorem.
   - `charSum_levelOne_of_unitCircle` (l. 441): delete the binder `(hpP : …)` (l. 442) and the line `have _ := hpP` with its
     comment (ll. 447–448). Its one call site is `towerRatio_of_charSum`, l. 486:
     `charSum_levelOne_of_unitCircle p P hpP h2 hQ h` becomes `charSum_levelOne_of_unitCircle p P h2 hQ h`.
   - Searched: no other module, script or data file of `Proofs/`, `scripts/` or `data/fs131/iqp1/` names either theorem.
     Each drop removes one binder of a stored type. Show it from the kernel's side as `LEAN.md` § Searching — Lean says
     (FS131-KN9's `tools/fs131_kn9_binder.py`, or FS131-LCH1's `ReAdd.lean` `mkArrow` re-add with a hash comparison
     against `data/fs131/iqp1/statements-before.txt`).
2. **`five_le_borelChromaticNumber_padicPlane_twentyThree`** in place of `four_le_…` (item 1014, ruling (2)), in
   `PadicPlane/Values.lean`. Statement: `5 ≤ borelChromaticNumber (padicPlane 23)`. The route, read but not written:
   - A private helper turns `CircleCos.circleCos_ge` (public, `Arith/CircleCos.lean`) into the hypothesis form of
     `le_borelChromaticNumber_of_charSum`. That form is `∀ ψ : AddChar (ZMod 23 × ZMod 23) ℂ, ψ ≠ 1 →
     -κ' ≤ (∑ s ∈ FibreCertSound.unitCircle 23, ψ s).re`, with `κ' = 24κ`.
   - The model for the helper is `Rigidity/ClassRatio.lean`'s private `charBound_one_of_circleCos` (ll. 1635–1765). On the
     plane it is shorter, with no residue field and no decomposition. It goes in four steps:
     1. `ψ(1, 0)^23 = ψ(0, 1)^23 = 1` (`AddChar.map_nsmul_eq_pow`, `ZMod.natCast_self`).
     2. `(Complex.isPrimitiveRoot_exp 23 _).eq_pow_of_pow_eq_one` gives `ψ(1, 0) = ζ^α` and `ψ(0, 1) = ζ^β` with `α, β < 23`.
     3. So `ψ v = ζ^((α·v.1.val + β·v.2.val) % 23)`, because `v = v.1.val • (1, 0) + v.2.val • (0, 1)`.
        `Re ζ^m = cos(2πm/23)` (`Complex.exp_nat_mul`, `Complex.exp_ofReal_mul_I_re`, as at ClassRatio l. 1745).
     4. `ψ ≠ 1` gives `α ≠ 0 ∨ β ≠ 0`.
   - `unitCircle 23` is `Finset.univ.filter fun x => x.1 ^ 2 + x.2 ^ 2 = 1` (`Arith/FibreCertSound.lean` l. 43). That is the
     same finset as `circleCos_ge`'s sum, so no bijection is needed.
   - The arithmetic: `circleCos_ge` gives `κ < 1/3` and `2/24 ≤ κ`. So `κ' = 24κ` satisfies `2 ≤ κ'` (the hypothesis
     `hκ`) and `κ' < 8`, which gives `4 < 1 + 24/κ'` and `5 ≤ ⌈1 + 24/κ'⌉₊` by `Nat.lt_ceil`.
   - `CircleCos` is already in `Values`' import closure (through `Tower` → `Rigidity/ClassRatio`, which imports it), so no
     import is added: an added import can move stored statements.
   - Priced at the predecessor's 50–70 lines.
   - Text to bring to what is proved: `Values`' module docstring (`4 ≤ χ_Bor(ℚ₂₃²) ≤ 8`, and "any value at 23 beyond
     `[4, 8]`") and the new theorem's own docstring; `ARCHITECTURE.md` l. 1020 (the `PadicPlane/Values` row), which names
     `four_le_…`.
3. **The build** under the slot (the brief's command line), then `lake lint --no-build -- --no-build --trace`: a saved stage.
4. **The gate on one commit** (brief § Done means step 3), with these parts:
   - `data/fs131/clone1/run-gate.sh`'s steps, copied under `data/fs131/iqp2/`, with their logs there. Every count change is
     explained against `data/fs131/ico2/gate/` (gated on `7c72b9bf7`).
   - The statement comparison against `data/fs131/iqp1/statements-before.txt`. Use the dumper
     `data/fs131/iqp1/lean/StatementDump.lean` with the three `Arith/FibreCert7*` modules added. The comparator is shaped like
     `data/fs131/ico2/statements.py`, with a planted control watched.
   - The ruled changes, listed: the three leaves at 23 moved out, the two drops, `four_le` → `five_le`, and the new helpers
     (the predecessor's ten private ones plus this job's).
   - The vacuity scan's new sites, each structure hypothesis's inhabitant named. The colouring binders read `GENERIC` in `k`
     and are inhabited at `p = 3`, `k = 3`.
   - `#print axioms` of every head statement.
   - Any statement dump committed gzipped (item 1011).
5. **The read-aloud** against ledger row 75 and FS66-T7 (brief step 4). Not claimed: the plain chromatic number of `ℚ_p²`;
   `6 ≤ χ_Bor(ℚ₂₃²)`; the level clause at 23.
6. **The drafts** for the front files (brief step 5): the planner's `plans/FS131-KPA1-padic-plan.md` § 5.2–5.6 brought to
   what is proved; the two `LEAN.md` lines of the predecessor's report (`hensels_lemma` gives only `‖z − b₀‖ < 1`; the
   `haar p` instance through a local `haveI`); the posers' question credited to them.
7. **The report.**

## What is left, for a successor

Stage 1 is saved. Every step of § 1.2 is open, starting at step 1. Nothing is half-done: no Lean file was edited, and
`.lake/build` is the copy of `main`'s build the brief describes, untouched by this job.
