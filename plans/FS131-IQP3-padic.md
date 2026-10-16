# FS131-IQP3 — the p-adic plane to the gate: the ruled drops, five colours at 23, lint, the gate, the read-aloud and the drafts

*de Bruijn, the kernel lane's implementer. Brief `data/fs131/briefs/FS131-IQP3-padic.md` (on `main`; a copy is
`data/fs131/iqp3/brief-copy.md`). Worktree `.claude/worktrees/il5`, branch `fs131-kpa1`, from `f8ebf37f5`. The successor of
FS131-IQP2 (record `plans/FS131-IQP2-padic.md`, stopped at stage 1 at a pause Kooshi called) and FS131-IQP1 (record
`plans/FS131-IQP1-padic.md`); the plan is `plans/FS131-KPA1-padic-plan.md`. No fence. Started 2026-10-16.*

## Theorems this phase proved

To be filled at the gate, with each theorem's axioms as `#print axioms` gives them.

## Stage 1 — SAVED: the readback

### 1.1 The quotations

The brief's four quotations (inventory items 1018, 1020, 1014 and 1002, `plans/FS131-close-inventory.md`), checked with
line breaks folded by the planner's checker, unchanged (`tools/fs131_kpa1_quotes.py`):

- against this worktree's copy of the inventory: **all four verbatim** (`data/fs131/iqp3/quotes.out`, exit 0);
- against `main`'s copy (`--root /home/kooshi/source/lean-dir`): **all four verbatim** (`data/fs131/iqp3/quotes-main.out`,
  exit 0);
- the planted control (one character of the first quotation changed) is refused: exit 1, `[0] NOT FOUND`
  (`data/fs131/iqp3/quotes-plant.out`).

The branch is at `f8ebf37f5`, as the brief says; `git status` showed no tracked change at the start (only the first job's
untracked logs under `data/fs131/iqp1/` and `data/fs131/kpa1/`). The worktree's `.lake/build` holds no `.olean` of the
eight landing modules (`PadicPlane/*`, `Arith/FibreCert7*`): it is `main`'s build, so the first build compiles them.

### 1.2 What is left, in order (FS131-IQP2's § 1.2, checked against the source)

Each line number of FS131-IQP2's § 1.2 was read against `PadicPlane/Tower.lean` at `f8ebf37f5` and holds: the binder
`(hk : 1 ≤ k)` at l. 346 and its `have _ := hk` at ll. 349–350, the call at l. 421; the binder `hpP` of
`charSum_levelOne_of_unitCircle` at l. 442, its `have _ := hpP` at ll. 447–448, the call at l. 486. `exists_levelEmbedding`
reads `hpP` (its own, for `p ≠ 2` and `charP_quot_pow`), which stays. No other file of `Proofs/` or `scripts/` names either
theorem (`grep -rn`). One correction to the route at 23: FS131-IQP1 and item 1002 give `κ ≈ 7.97`; the exact least cosine
sum over the circle of `𝔽₂₃²` is `−7.9606871…` (a float evaluation, for the docstring only; stage 2) and `circleCos_ge`'s
certificate (`M = 7960687200`, `κ₀ = M/(24·10⁹)`) gives `κ = 24κ₀ = M/10⁹ = 7.9606872`, so `1 + 24/κ = 4.0148…`; the value
`⌈·⌉ = 5` is unchanged.

The order: (1) the two drops; (2) `five_le_borelChromaticNumber_padicPlane_twentyThree` in place of `four_le_…`, with the
module docstring and `ARCHITECTURE.md`'s row brought to it; (3) the build and the lint — a saved stage; (4) the gate on one
commit with the statement comparison, the ruled changes listed, the vacuity scan's new sites and `#print axioms` of every
head statement — a saved stage; (5) the read-aloud — a saved stage; (6) the drafts — a saved stage; (7) the report.

## Stage 2 — SAVED: the ruled drops, five colours at 23, the build and the lint

**The two drops** (inventory item 1014, ruling (1)), `PadicPlane/Tower.lean`: `(hk : 1 ≤ k)` removed from
`exists_levelEmbedding` with its `have _ := hk` and comment, the call in `towerRatio_of_ratioAtMost` now
`exists_levelEmbedding p P hpP h2 hQ k`; `(hpP : ((p : ℕ) : 𝓞 (fieldI ⊥)) ∈ P.P)` removed from
`charSum_levelOne_of_unitCircle` with its `have _ := hpP` and comment, the call in `towerRatio_of_charSum` now
`charSum_levelOne_of_unitCircle p P h2 hQ h`. No proof line other than those changed: both proofs read neither binder.

**`five_le_borelChromaticNumber_padicPlane_twentyThree`** (item 1014, ruling (2)), `PadicPlane/Values.lean`, in place of
`four_le_…`: `5 ≤ borelChromaticNumber (padicPlane 23)`. The route the predecessors priced, with one private helper:
- `charSum_unitCircle_ge_of_circleCos` (private, 45 lines with its docstring): for a prime `Q` and any `κ`, the cosine-sum
  hypothesis of `CircleCos.circleCos_ge` (every `(α, β) ≠ 0` below `Q`) gives the character-sum form that
  `le_borelChromaticNumber_of_charSum` takes, `−κ(Q + 1) ≤ Re Σ_{s ∈ unitCircle Q} ψ s` for every `ψ ≠ 1`. The plane's form of
  `Rigidity/ClassRatio`'s private `charBound_one_of_circleCos`, with no residue field: `ψ(1, 0) = ζ^α`, `ψ(0, 1) = ζ^β`
  (`IsPrimitiveRoot.eq_pow_of_pow_eq_one` at `Complex.isPrimitiveRoot_exp`; `Q • v = 0` by `ext <;> simp`), so
  `ψ v = ζ^{(αv₁ + βv₂) mod Q}` from `v = v₁.val • (1, 0) + v₂.val • (0, 1)`; `ψ ≠ 1` gives `(α, β) ≠ 0`; the real part of `ζ^m`
  is `cos(2πm/Q)` (`Complex.exp_ofReal_mul_I_re`); `unitCircle Q` is the same `Finset.filter` as `circleCos_ge`'s sum, by
  definition, so no bijection is needed.
- the theorem (19 lines): `circleCos_ge` at `Q = 23` gives `κ₀ < 1/3` with `2/24 ≤ κ₀`; `κ = 24κ₀` has `2 ≤ κ` and
  `1 + 24/κ = 1 + 1/κ₀ > 4`, so `5 ≤ ⌈1 + 24/κ⌉` by `Nat.lt_ceil`, and `le_borelChromaticNumber_of_charSum 23` closes it. No
  import added (`Arith/CircleCos` is in `Values`' closure through `Tower` → `Rigidity/ClassRatio`).
- Elaborated first in a scratch file over `Rigidity/ClassRatio`'s compiled closure (`data/fs131/iqp3/scratch/Five23.lean`,
  the value step against a stand-in for the bound with its exact statement), two rounds: one `rw` chain for `Q • (0, 1) = 0`
  that did not fire, replaced by `ext <;> simp`, and one argument order. Then copied into `Values`.
- 64 lines added against `four_le`'s 12 removed: within the 50–70 the predecessors priced. **Its axioms are fewer than
  `four_le`'s**: the cosine bound is a `decide +kernel` certificate on the standard three, where `four_le` read Weil's bound
  (stage 4 prints them).
- The exact least cosine sum, for the docstring only (a float evaluation, not a check): `−7.9606871865…` over the 24 points;
  the certificate's `κ = 7.9606872` is above it, as a lower bound's constant must be.

**Text brought to what is proved** (docstrings and the map only): `Values`' module docstring (`5 ≤ χ_Bor(ℚ₂₃²) ≤ 8`, the lower
end's source, "any value at 23 beyond `[5, 8]`", the Models paragraph's model at 23, the title's "and FS131-IQP3");
`ARCHITECTURE.md`'s `PadicPlane/Values` row (the same; "proved by FS131-IQP1 and FS131-IQP3"); `tools/check_architecture.py`
PASS (`data/fs131/iqp3/arch0.txt`).

**The build** (the brief's command line: `--mem 8 --cpus 5`, `MEMMAX=8G BATCH=3`; `data/fs131/iqp3/build1.log`, full output
`build/gate/build/20261016T174449Z-4091013.log`): **OK — 736 of 736 batches, 9 modules rebuilt** (`Arith/FibreCert7` 3.3 s,
`FibreCert7Check` 33 s, `FibreCert7Bound` 1.3 s, `PadicPlane/Basic`, `Measure`, `Upper`, `Tower` 9.1 s, `Values` 4.6 s, and the
root), **0 with warnings, 22 m 59 s**. `grep -rnP '\bsorry\b'` over the eight landing modules: 0 lines.

**The lint** (`lake lint --no-build -- --no-build --trace` under the slot; `data/fs131/iqp3/lint1.log`): exit 0, "Linting passed
for Proofs.", all 14 linters `(2/2) Passed!`. With the two binders gone, `unusedArguments` has nothing to find in them; the new
helper is private, the new theorem has its docstring.
