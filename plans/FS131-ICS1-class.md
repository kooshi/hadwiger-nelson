# FS131-ICS1 — five colours by field and by class: the quadratic dichotomy, the family, CLS in full, ℚ(√23, ∛2)

*de Bruijn, the kernel lane's implementer, on Opus. Brief `data/fs131/briefs/FS131-ICS1-class.md` (on `main`); branch
`fs131-kcs1`, worktree `.claude/worktrees/kcs1`, at `9db09ce35` on launch (the planner's skeleton with `main` merged in).
Launched 2026-10-16 18:43 UTC. The plan is `plans/FS131-KCS1-class-plan.md` (FS131-KCS1's record). Nothing is fenced.*

## Theorems this phase proved

Every theorem below is [kernel], on the gated commit (§ Stage 4); its axioms are the kernel's print
(`data/fs131/ics1/axioms-all.txt`). **std3** = `[propext, Classical.choice, Quot.sound]`; **W** =
`StandingFive.kloosterman_bound` (Weil's bound, `[Weil1948]` p. 207); **EL** = `Rigidity.positive_entropy_rigidity`
(`[EinsiedlerLindenstrauss2022]` Thm 1.3). Both are declared outside theorems.

*The quadratic dichotomy and the family* (`Instances/SqrtFiveClass`):
- `SqrtFiveClass.five_le_chromaticNumber_planeOver_sqrt_iff` — for squarefree `m`, `5 ≤ χ(ℚ(√m)²)` ⟺ `m ≡ 47, 143, 167 (mod 168)` — std3 + W + EL
- `SqrtFiveClass.five_le_localBound_sqrt_iff` — for squarefree `m`, `5 ≤ L(ℚ(√m))` ⟺ the same — std3 + W + EL
- `SqrtFiveClass.chromaticNumber_planeOver_sqrt_eq_five` — `χ(ℚ(√d)²) = 5` at squarefree `d` in the class that is a square, zero included, modulo 11 or modulo 19 — std3 + W + EL
- `SqrtFiveClass.localBound_sqrt_eq_five` — `L(ℚ(√d)) = 5` there — std3 + W + EL
- `SqrtFiveClass.colorable_five_planeOver_sqrt`, `localBound_sqrt_le_five`, `exists_maximal_card_eq_of_isSquare` — the upper halves and the prime they use — std3

*CLS in full and the two readings of `L`* (`Rigidity/FourColourPlaces`):
- `Rigidity.five_le_localBound_iff` — `5 ≤ L(F)` ⟺ no stable prime of `F(i)` satisfies `IsFourColourPlace` — std3 + W
- `Rigidity.tca_iff_forall_not_isFourColourPlace` — T-C(A) at `S = ∅` ⟺ the same — std3 + W
- `Rigidity.colorable_four_levelTarget_one_iff`, `exists_ratioAtMost_lt_quarter_iff`, `five_le_chromaticNumber_levelTarget_one_iff`, `exists_ratioAtMost_of_not_isFourColourPlace` — CLS per place — std3 + W
- `Rigidity.colorable_four_levelTarget_one_of_isFourColourPlace` — a listed place's level-one target is four-colourable — std3
- `Rigidity.five_le_localBoundAllLevels_iff` — `5 ≤ L_all(F)` ⟺ `5 ≤ L(F)` — std3 + W
- `Rigidity.min_localBoundAllLevels_five` — `min(L_all(F), 5) = min(L(F), 5)` — std3 + W + EL
- `Rigidity.localBoundAllLevels_le_localBound`, `chromaticNumber_planeOver_le_localBoundAllLevels`, `five_le_chromaticNumber_levelTarget_of_ratioAtMost`, `exists_isFourColourPlace_rat` — std3

*The bridge from a usable prime* (`Arith/StableAboveUsable`):
- `UpperHalf.localBound_le_unitQuadrance` — `L(F) ≤ χ(Γ_q)` at a usable prime — std3
- `UpperHalf.localBound_le_finitePlane`, `exists_stablePrime_card_eq_sq`, `nonempty_hom_levelTarget_one_unitQuadrance` — std3

*ℚ(√23, ∛2)* (`Instances/SqrtTwentyThreeCbrtTwo`):
- `SqrtTwentyThreeCbrtTwo.chromaticNumber_planeOver_sqrt23_cbrt2_eq_five` — `χ(ℚ(√23, ∛2)²) = 5` — std3 + W + EL
- `SqrtTwentyThreeCbrtTwo.localBound_sqrt23_cbrt2_eq_five`, `five_le_localBound_sqrt23_cbrt2` — `L = 5`, `L ≥ 5` — std3 + W
- `SqrtTwentyThreeCbrtTwo.localBound_sqrt23_eq_four` — `L(ℚ(√23)) = 4` — std3 + W + EL
- `SqrtTwentyThreeCbrtTwo.not_isTotallyReal_F23` — the field has a complex place — std3
- `SqrtTwentyThreeCbrtTwo.card_ne_sq_of_pow_eq`, `nonempty_ringHom_padic_eleven_F23`, `exists_usablePrime_eleven_F23`, `numberField_F23`, `isSquare_twentyThree`, `exists_cube_two`, `cbrtTwo_pow_three` — std3

*The ruled `ClassRatio` edit* (items 1027, 1029): `Rigidity.ratioAtMost_dyadic_of_six_le` (new), and
`exists_card_two_pow_sq`, `chromaticNumber_le_four_dyadic`, `chromaticNumber_le_four_of_small` (made public) — std3.

## Stage 1 — SAVED: the readback

### 1.1 Quotations

All nine blockquotes of the brief are verbatim in their named sources (`data/fs131/ics1/quote_check.py`, a copy of
FS131-KCS1's checker: it strips the `> ` prefix, collapses whitespace and searches the named source; its planted control —
one word of the first quote changed — is reported `MISMATCH` and exits 1). Run 2026-10-16 18:46 UTC from the worktree:
`9 quotes, 0 mismatches`, exit 0 (`data/fs131/ics1/logs/quote_check.out`); plant: `9 quotes, 1 mismatches`, exit 1
(`logs/quote_check_plant.out`). The line numbers ruling 1027 cites (A1 `SqrtFiveClass.lean` ll. 39–41, A2 ll. 64–66, A3
`FourColourPlaces.lean` ll. 73–74, A4 `SqrtTwentyThreeCbrtTwo.lean` l. 80, the bridge `StableAboveUsable.lean` ll. 44–45;
`Rigidity/SqrtClassFive.lean` l. 270) are where the statements stand.

### 1.2 Findings from the readback

- **R1 — the skeleton has 35 leaves, not 36.** The four files hold 12 + 4 + 7 + 12 `sorry`s (`FourColourPlaces`,
  `StableAboveUsable`, `SqrtFiveClass`, `SqrtTwentyThreeCbrtTwo`); the plan's table (§ 3.1) counts 13 in the instance
  module, whose `instance : NumberField F23 := numberField_F23` is not a leaf. The planner's build log's 85 `sorry`
  warnings are 35 distinct lines, each printed more than once (`sort -u` of the log's `declaration uses` lines: 35). No
  statement is missing; the count is a bookkeeping slip.
- **R2 — the drafted `ratioAtMost_dyadic_of_six_le` carries an unread binder.** The plan's § 3.5 item 1 drafts it with
  `(h2 : 2 ∈ P)`; the `f ≥ 6` branch of `ratioAtMost_dyadic` (ll. 1458–1477) reads only `ha`, `hQ` and `f`'s bound — `h2`
  enters `ratioAtMost_dyadic` only through `exists_card_two_pow_sq`, which the new lemma replaces by its hypothesis `hQ`.
  A public theorem with an unread hypothesis fails the linters (`unusedVariables` in the build, `unusedArguments` in
  `lake lint`). I state it without `h2`: strictly stronger, and no weaker in meaning, since `|𝓞 ⧸ P| = (2^f)²` with
  `f ≥ 6` already makes `P` dyadic. The ruling fixes the lemma's name, place and role, not its binders; reported to the
  coordinator with the gate.

### 1.3 The target, the rulings, the order of work

**Target.** Replace each of the 35 `sorry`s of the four skeleton modules with a proof, changing no stored statement;
make the ruled `ClassRatio` edit; pass the full gate (`data/fs131/clone1/run-gate.sh`'s steps, copied under
`data/fs131/ics1/`) on one commit; read each head statement aloud against row 123; draft the front-file edits.

**Rulings in force for this job** (inventory items 1025, 1027):
1. *The `ClassRatio` edit* (item 1027 (1)): state `ratioAtMost_dyadic_of_six_le` as a public theorem after
   `ratioAtMost_dyadic`; make `chromaticNumber_le_four_of_small` and `chromaticNumber_le_four_dyadic` public, with
   docstrings; call them by name, no `open private`. Touch no other line of `ClassRatio` (FS131-IFR1 edits l. 92,
   `ratioAtMost_of_charBound`, on its own branch). Done in the first build. Each is a ruled change in the statement
   comparison.
2. Part B (the ring lemma) is not this job's.
3. The commit hook runs the privacy guard; a refusal is reworded, never `--no-verify`.

**Before the first proof edit**: the stored statements of 21 modules dumped from the compiled skeleton
(`data/fs131/ics1/lean/StatementDump.lean`, a copy of FS131-ICO2's dumper; print `data/fs131/ics1/statements-before.txt.gz`,
taken 2026-10-16 18:48 UTC at `9db09ce35` against the build the planner made of `09fc7f4c2`'s text, which
`lake build --no-build` reported up to date, `logs/uptodate-0.log`): `ClassRatio`, its 19 downstream modules (the three
skeleton modules among them) and `StableAboveUsable`.

**Order** (the plan's § 3.3, kept): the `ClassRatio` edit; `Rigidity/FourColourPlaces` (leaves 8, 9, 10, 1, 2, 3–7, 11,
12; re-price after 8 and 1); `Arith/StableAboveUsable` (u3, u12, heads); `Instances/SqrtFiveClass` (s1–s5, then s6–s7);
`Instances/SqrtTwentyThreeCbrtTwo` (t2, t4, t1, t5, t3, t6, t7–t10, t11). A build through `./scripts/build.sh` under the
slot after each module, and a saved stage. Iteration is in a real-copy farm of the compiled library (`build/ics1-farm`,
gitignored), never evidence.

## Stage 2 — SAVED: the ruled `ClassRatio` edit and `Rigidity/FourColourPlaces`

**The ruled edit** (items 1027 (1) and 1029, `Proofs/HadwigerNelson/Rigidity/ClassRatio.lean`; four declarations, no
other line): `exists_card_two_pow_sq` (l. 1046), `chromaticNumber_le_four_dyadic` and `chromaticNumber_le_four_of_small`
made public, each with a docstring and its statement unchanged; `ratioAtMost_dyadic_of_six_le` added after
`ratioAtMost_dyadic`, stated without the drafted `h2` (item 1029 (b)): `(P) {a} (ha : conjO F a − a ∉ P.P) {f}
(hQ : |𝓞 ⧸ P| = (2^f)²) (hf : 6 ≤ f) : ∃ c < 1/4, RatioAtMost P c`, its proof `ratioAtMost_dyadic`'s `f ≥ 6` branch
copied (30 lines). `ratioAtMost_dyadic` itself is untouched: the ruling places the new lemma after it, so it cannot call
it; a later edit could let it, removing the copy.

**`Rigidity/FourColourPlaces`, twelve leaves, 82 lines, against the plan's 260.** Routes as planned, but with no
`open private` (ruling 1027 (1)), and two departures:
- leaf 10 (`five_le_chromaticNumber_levelTarget_of_ratioAtMost`) uses the public `HadwigerNelson.not_colorable_of_mul_lt`
  (`LocalGlobal`) at `a = ⌊c·N⌋₊`, not `SqrtClassFive`'s private counting lemma: `c ≥ 0` from the empty independent set,
  `4⌊cN⌋ ≤ 4cN < N`;
- leaf 12 (`min_localBoundAllLevels_five`) needs no case split: `min(L, 5) ≤ χ(F²) ≤ L_all` and `min(L, 5) ≤ 5`.
Leaf 1 reads `2 ∉ P` at `Q ∈ {3, 7}` from `stablePrime_card_of_two_notMem` (an odd stable prime's `Q` is a power of an odd
prime, so `Q ∉ {2, 4, 8, 16, 32}`), and at `2 ∈ P` gets `Q = 2^f` from `exists_card_two_pow_sq`. Two private helpers:
`not_five_le_of_colorable_four`, `exists_conj_sub_notMem_of_not_isRamified`.

**Re-price after leaves 8 and 1** (`LEAN.md` § The kernel's cost model: from the first two leaves, never the plan's
table): leaf 8 is 2 lines against 6, leaf 1 is 32 against 50, the module 82 against 260. Re-priced total for part A: about
0.4–0.7 of the planned 1,100 lines (measured at the end: about 775, § 3).

**The build** (`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 scripts/slot.py --mem 8 --cpus 4 -- env MEMMAX=8G BATCH=3
./scripts/build.sh`, on `bd3f68c1b`): exit 0, "build: OK — 738 of 738 batches, 21 module(s) rebuilt, 3 module(s) with
warnings, 22m32s" — `ClassRatio`, its 19 downstream modules and the root; every warning a `sorry` in the three modules not
yet proved (4 + 7 + 12 distinct lines); `ClassRatio` and `FourColourPlaces` warning-free (`logs/build-1.log`,
`logs/build-1-full.log`). Iteration before it was in a real-copy farm (`data/fs131/ics1/lean1.sh`, `build/ics1-farm`), its
axiom probe `probes/Axioms1.lean`: `five_le_localBound_iff` and the per-place forms on the standard three and
`kloosterman_bound`, `min_localBoundAllLevels_five` on those and `positive_entropy_rigidity`, `localBoundAllLevels_le_localBound`
on the standard three.

## Stage 3 — SAVED: `Arith/StableAboveUsable`, `Instances/SqrtFiveClass`, `Instances/SqrtTwentyThreeCbrtTwo`; `main` merged; the statement comparison

**`Arith/StableAboveUsable`, four leaves, 389 lines against the plan's 300.** u12 (`exists_stablePrime_card_eq_sq`) by the
plan's route, built as private lemmas: the valuation subring `B` of `F` at `𝔭` and its residue map (`Arith`'s two
localization lemmas); `B[i] = {z ∈ F(i) : Re z, Im z ∈ B}` as a valuation subring of `F(i)` (`gaussSubring`, `gaussVal`;
the valuation property by `gauss_key`: `b = t·a` with `t ∈ B` makes `a + bi` or its inverse integral, `1 + t²` being a
unit as `−1` is no square in `𝔽_q`); conjugation-stable; not `⊤` (`1/q ∉ B`, because `r(q) = 0` makes `q` a non-unit);
then `UpperHalf.exists_stablePrime_of_valuationSubring`. The residue count (`card_eq_sq_of_localRing_eq`):
`StandingFive.card_fixed_of_involution` gives `|𝓞 ⧸ P| = |k₀|²`; `B` maps onto the fixed field `k₀` through the residue
map with kernel `B`'s non-units (`res(a + bi) = ρ(a) + ρ(b)·ι`, and a fixed residue has `2ρ(b)ι = 0`), as `r` maps onto
`𝓞 F ⧸ 𝔭` with the same kernel, so `|k₀| = |𝓞 F ⧸ 𝔭|` through `B ⧸ ker`. `i` is taken as this module's own integer
`iO` (coordinates known), since `exists_I_integer` does not fix the sign. u3 is `chromaticNumber_le_four_of_small`'s hom,
copied as planned, with `k₀ ≃+* k` by `FiniteField.ringEquivOfCardEq`. New imports: `Arith/StandingFive` (for
`card_fixed_of_involution`) and `Mathlib.FieldTheory.Finite.GaloisField`; the comparison below shows that no stored
statement moved.

**`Instances/SqrtFiveClass`, seven leaves, 34 lines against 160** (the census spec, optional, not written): exactly the
plan's routes, with `ZMod.natCast_eq_zero_iff` for `p ∣ d`.

**`Instances/SqrtTwentyThreeCbrtTwo`, twelve leaves, 223 lines against 380.** One private lemma, `exists_ringHom_F23`,
carries both embeddings. `F23` maps to any field of characteristic zero holding a cube root `y` of 2 and a square root of
23, with `∛2 ↦ y`: first `ℚ(∛2) → L` (`algHomAdjoinIntegralEquiv` at the root `y` of the minimal polynomial `X³ − 2`,
irreducible by `X_pow_sub_C_irreducible_of_prime`, with no rational cube root of 2 by the 2-adic valuation), then
`ℚ(∛2)(√23) → L` (`nonempty_algHom_adjoin_of_splits`; `X² − 23` splits in `L`), and `F23 ⊆ ℚ(∛2)(√23)`. Applied at
`ℚ_[11]` (Hensel at 7, `exists_padicInt_cube_eq_two`) for t6, and at `ℂ` with `y = ω∛2` for t11 (a real embedding would
fix `ω∛2` under conjugation, so `ω` would be real and hence 1). New import: `Mathlib.FieldTheory.KummerPolynomial`.
The plan's t6 had two separate steps for this, and t11 a third: here they are one lemma. `localBound_sqrt23_cbrt2_eq_five`
rests on Weil's bound alone; its lower half is the ratio argument (`five_le_chromaticNumber_of_two_notMem`), with no
measure rigidity.

**Two spec examples** in `FourColourPlaces` (not stored; checked at elaboration): `ℚ`'s ramified stable prime is listed, and
`localBoundAllLevels ⊥ ≤ 2` (`UpperHalf.exists_stablePrime_rat`).

**The re-price, measured**: about 775 lines (`ClassRatio` 45, the four modules 82 + 389 + 34 + 223) against the planned
1,100; proof work from 18:50 to 19:22 UTC. Every leaf was written once in the farm, and fixed there in at most four rounds.

**`main` merged** (item 1032): `c7cce9659`, with no conflict; `main` brought eight new modules (`Arith/FibreCert7`,
`FibreCert7Check`, `FibreCert7Bound`, `PadicPlane/*`) and no edit to an existing Lean module. Their compiled artifacts (64
files under `lib/lean` and `ir`) were copied from `main`'s checkout by checksum, with no file of a module this branch
changed among them (`logs/copy-list.txt`, `copy-rsync.txt`; the source's checksums before and after the copy equal, the
copies equal to the source). `PadicPlane/Tower` imports `ClassRatio`, so it and `Values` recompiled; the other six did
not. A text search found none of this landing's public names, and no `open private`, in the incoming modules
(`dupnames.sh` at the gate is the full check).

**The build** (on `77490cdb1`, the merge plus the two examples; two earlier launches were stopped by PID while still
queued for the slot, having read nothing: `logs/build-2-queued-stopped.log`, `build-2b-queued-stopped.log`): exit 0,
"build: OK — 739 of 739 batches, 7 module(s) rebuilt, 0 module(s) with warnings, 20m18s" (`logs/build-2.log`,
`build-2-full.log`).

**The statement comparison** (`data/fs131/ics1/statements.py`, a copy of FS131-ICO2's comparator with this landing's rules;
the after print `statements-after.txt.gz` from that build): `VERDICT CLEAN: 0 failure(s)` (`logs/statements.out`). Every
stored type and definition of the 21 modules is unchanged. The ruled changes are exactly these: `exists_card_two_pow_sq`,
`chromaticNumber_le_four_dyadic` and `chromaticNumber_le_four_of_small` are PUBLICIZED, each one's stored type equal to its
private one up to the hygienic hash that its instance binder's name carries, which is minted from the declaration name;
Lean's own hash of each stored type is unchanged (`logs/publicized-hashes.txt`: 1954668111, 610681485, 1953704367 before
and after). `ratioAtMost_dyadic_of_six_le` is the one new public constant. The rest are 39 private helpers. Planted
controls (`--plant`, `logs/statements-plant.out`): a changed stored type, a dropped constant, an unlisted public constant,
a changed publicized type, and a binder from another module that only a too-wide blanking would pass — **all five fired**.
On the first run two plants could not fire: one searched the raw print for `Q = 3`, which is not there, and one widened
the blanking after the ruled blanking had already rewritten the hash. Both were fixed in the plant code; the comparison
itself did not change.

## Stage 4 — SAVED: the gate on one commit

**The gate's inputs** (commits `815f7121a` and `6ff038e87`; each step watched red where the step has a red to watch):
- `scripts/Axioms.lean`: the landing's 45 public records, from the kernel's print of the five modules
  (`data/fs131/ics1/lean/AxiomsAll.lean` → `axioms-all.txt`, 56 public and 135 private records, no `sorryAx`), by
  `data/fs131/ics1/audit_block.py` (FS131-ICO2's generator, copied): 9 IMPORTED on `kloosterman_bound`, 7 on
  `positive_entropy_rigidity` and `kloosterman_bound`, 29 CLEAN; 11 of `ClassRatio`'s were already filed. `--coverage`:
  all 56 filed under their class. The generator's plant (run against the audit file as it stood before the filing, since
  the plant needs unfiled records): an unknown axiom, a `sorryAx` and a misfiled CLEAN record, all three reported, exit 1
  (`logs/audit-block-plant.out`).
- `scripts/axioms-controls.txt`: `baseline` imported 83 → 99 and `imported_declared` 84 → 100, with their digest texts and
  the tally paragraph (Weil's bound 64 → 80 records, E–L 27 → 34, both 14 → 21; union 99). **Seen red first**: the
  self-test against the old controls failed exactly `baseline` and `imported_declared`, naming them (`prep/axioms-selftest-red.log`);
  green after (`prep/axioms-selftest-green.log`).
- `scripts/Assumptions.lean`: the `.condition HadwigerNelson.Arith.IsUsablePrime` entry **retired** — the step failed it as
  `stale-condition`, "concluded by [SqrtTwentyThreeCbrtTwo.exists_usablePrime_eleven_F23]: the entry is not needed"
  (`prep/assumptions-red.log`; `LEAN.md`'s rule for a condition a landing concludes).
- `Rigidity.exists_isFourColourPlace_rat`, a public theorem added to `FourColourPlaces`: the step failed
  `IsFourColourPlace` as `undeclared-never-concluded` (taken by one theorem, concluded by none); the model the gate rule
  asks for is a theorem concluding it at its model (`LEAN.md` § The gate, FS124-L2's rule). The spec `example` saying the
  same was replaced by it (an `example` is not stored). The comparator lists it in `ALLOWED_PUBLIC` with that reason.
- `scripts/assumptions-ledger.txt`: `--write-ledger` added 23 rows, every one `RESTS <W or EL> <a record of this
  landing>`, none a `TAKES` (no statement of this landing takes a declared hypothesis); header `rests=105 → 128`.
- `scripts/vacuity-baseline.txt`: header `declarations=22431 → 22478`.

**The run** (`data/fs131/ics1/run-gate.sh`, a copy of `data/fs131/clone1/run-gate.sh`, launched from a snapshot;
`data/fs131/ics1/gate/run-pass.out`): `HEAD=6ff038e87… tracked-modified=0`; up to date (exit 0); `sorry` lines 0;
line-initial `axiom` lines 5 (as at the p-adic gate); dupnames 0, its self-test 0; axioms 0, its self-test 0 (316 s);
vacuity 0, its self-test 0; assumptions 0, its self-test 0; architecture 0; lint 0 (`-- Linting passed for Proofs.`, 14
linters `(2/2) Passed!`); the three digests 0. "tracked files modified after the pass: 2": this record and
`data/fs131/ics1/lean/ReadAloud.lean` (an import line added while the pass ran), neither an input of any step.

**Count changes against the latest landed gate** (the p-adic plane's, `data/fs131/iqp3/gate/`, on `7180f4b40` = `e3e1dbb73`):

| count | iqp3 | ics1 | change | why |
|---|---|---|---|---|
| audit records | 11,466 | 11,511 | +45 | the 56 public records of the five modules less the 11 `ClassRatio` records already filed |
| clean | 10,804 | 10,833 | +29 | 28 from the generator, and `exists_isFourColourPlace_rat` |
| axiom-free | 574 | 574 | 0 | — |
| imported | 83 | 99 | +16 | 9 on Weil's bound alone (CLS's seven, `L(ℚ(√23, ∛2)) = 5` and `≥ 5`), 7 on E–L and Weil's bound (the dichotomy, its local form, the family's `χ` and `L`, `χ(ℚ(√23, ∛2)²) = 5`, `L(ℚ(√23)) = 4`, `min_localBoundAllLevels_five`) |
| declared purchases | 5 | 5 | 0 | — |
| assumptions `rests` | 105 | 128 | +23 | 9 + 2·7 rows; the other eight counts unchanged |
| vacuity `declarations` | 22,431 | 22,478 | +47 | `ClassRatio` +4 (three made public, one added; the scan skips private names) and the four modules' 17 + 4 + 7 + 15 = 43 (`vacuity-new.txt`; the 17 include two compiler-made `…match_1_1` auxiliaries of destructuring lambdas in `exists_ratioAtMost_lt_quarter_iff` and `five_le_chromaticNumber_levelTarget_one_iff`) |
| vacuity `refutations-skipped`, `sites` and verdicts | 243; 1,458 (0, 0, 3, 38, 1,415, 2) | the same | 0 | no site: the modules' structures are number-theoretic and their one colourability hypothesis is `Colorable k` of a finite graph (`LEAN.md`: the scan is silent on such modules) |
| dupnames generated on demand | 31 | 31 | 0 | — |

**The structures' models** (the scan is silent; `LEAN.md` § The gate asks the landing to name each model):
- `StablePrime F`: `ℚ`'s prime above 2 (`UpperHalf.exists_stablePrime_rat`, library theorem; ramified, so listed:
  `Rigidity.exists_isFourColourPlace_rat`, this landing); `ℚ(√47)`'s prime above 11 (`SqrtFortySeven.exists_stablePrime_eleven`);
  the prime above any usable prime (`UpperHalf.exists_stablePrime_card_eq_sq`, this landing).
- `¬ IsFourColourPlace P` and `RatioAtMost P c` with `c < 1/4`: `ℚ(√47)`'s prime above 11, with `|𝓞 ⧸ P| = 11²`
  (`SqrtFortySeven.stablePrime_card_sqrt47`), odd so not ramified (`IsRamified.isDyadic`), and the ratio by
  `Rigidity.ratioAtMost_of_two_notMem` — library theorems, not stored as one statement.
- `IsUsablePrime 𝔭`: `SqrtTwentyThreeCbrtTwo.exists_usablePrime_eleven_F23` (this landing); `ℚ(√47)` above 11
  (`QuadraticPrime.exists_maximal_card_eq` at 11).
- `nonempty_hom_levelTarget_one_unitQuadrance`'s `k`: `𝓞 F ⧸ 𝔭` at a usable prime, as `localBound_le_unitQuadrance` uses it.
- `card_ne_sq_of_pow_eq`'s hypotheses: at `F23`, `p = 7`, `k = 3`, `a = 2` (its use in `five_le_localBound_sqrt23_cbrt2`).
- The family's arithmetic: `d = 47` (the module's spec).
- `ratioAtMost_dyadic_of_six_le`'s (an unramified dyadic stable prime with `|𝓞 ⧸ P| = (2^f)²`, `f ≥ 6`): **no model in
  the library**. One exists at a field where 2 is inert of residue degree at least 6 and stays inert in `F(i)`; none is
  exhibited here. The lemma is the `f ≥ 6` branch CLS's proof calls, and it is used there only.

## Stage 5 — SAVED: the read-aloud against row 123

From the gated build's own print with full names (`data/fs131/ics1/lean/ReadAloud.lean` → `data/fs131/ics1/read-aloud.txt`),
against `LEDGER.md` row 123 and `[Davies2026]` p. 5 as the row quotes it. `χ(·)` is Mathlib's `SimpleGraph.chromaticNumber`
(`ℕ∞`) of `(unitDistance ℂ).induce (planeOver F)`, the unit-distance graph on `F² = {z : Re z, Im z ∈ F}`;
`fieldOfRadicands {m}` is the subfield of `ℝ` generated by `√m`; `localBound F` is `⨅ P : StablePrime F, χ(levelTarget P 1)`
(level one, the norm-one residues of `𝓞 (F(i)) ⧸ P`).

1. **`SqrtFiveClass.five_le_chromaticNumber_planeOver_sqrt_iff`**: `∀ {m : ℕ}, Squarefree m → (5 ≤ χ(ℚ(√m)²) ↔ m % 168 = 47 ∨
   m % 168 = 143 ∨ m % 168 = 167)`. *In words*: for squarefree `m`, the plane over `ℚ(√m)` needs at least five colours exactly
   when `m ≡ 47, 143, 167 (mod 168)`. Squarefree `m ≢` the class gets 2, 3 or 4 (the table); `m = 1` gives `ℚ`, outside
   the class, 2. *Against the row*: row 123 states `χ = 5` at named members and a family; this is the class-wide lower half
   with its converse, with no list. *Against `[Davies2026]` p. 5*: it asks, for `n ≡ 47, 143, 167 (mod 168)`, for a
   five-chromatic graph in `ℚ(√n)²` and whether `ℚ(√n)²` is six-colourable. This gives `χ(ℚ(√n)²) ≥ 5` for every squarefree
   such `n`, and so the existence of a finite subgraph that is not four-colourable (de Bruijn–Erdős), but it exhibits no
   graph. *Not claimed*: any finite graph; any value at the class (only `≥ 5` here).
2. **`SqrtFiveClass.five_le_localBound_sqrt_iff`**: the same class, read for `L(ℚ(√m)) ≥ 5`.
3. **`SqrtFiveClass.chromaticNumber_planeOver_sqrt_eq_five`**: `∀ {d}, Squarefree d → d % 168 ∈ {47, 143, 167} →
   IsSquare (d : ZMod 11) ∨ IsSquare (d : ZMod 19) → χ(ℚ(√d)²) = 5` (the print elides the two `ZMod` types; the source and
   the stored types read them), and **`localBound_sqrt_eq_five`**, `L(ℚ(√d)) = 5` there. *In words*: a squarefree class member
   that is a square, zero included, modulo 11 or modulo 19 has a plane needing exactly five colours, and local bound five.
   *Against the row*: the row's family is "every squarefree `d ≡ 47, 143, 167 (mod 168)` with `L = 5` (44 of the 52 with
   `d ≤ 3000`)"; the derivation computed "`L = 5`" as "11 or 19 stable", and that is this hypothesis. The count is re-checked
   by exact arithmetic (`tools/fs131_ics1_census.py`: 52 class members, 44 reached, the same as the ledger; its plant, the
   zero case dropped, gives 41 and fails). *Not claimed*: the eight members `d ≤ 3000` that are a square neither modulo 11
   nor modulo 19 — 167, 887, 1055, 1319, 1823, 2351, 2735, 2903 — at which `L` is open (`Γ₃₁` undecided); the row's wider
   reading "with `L = 5`" beyond this hypothesis. The upper half rests on the standard three; the lower on W and EL.
4. **`Rigidity.five_le_localBound_iff`**: `∀ (F : Subfield ℝ) [NumberField F], 5 ≤ L(F) ↔ ∀ P : StablePrime F,
   ¬ IsFourColourPlace P`, with `IsFourColourPlace P := IsRamified P ∨ ∃ Q ∈ {2, 3, 4, 7, 8, 16, 32}, |𝓞 (F(i)) ⧸ P| = Q²`.
   *In words*: `L(F) ≥ 5` exactly when no prime of `F(i)` fixed by conjugation is ramified over `F`, has `Q ∈ {3, 7}` (its
   fixed field `𝔽₃` or `𝔽₇`), or is dyadic with `Q ∈ {2, 4, 8, 16, 32}` (inert of norm at most 32). With
   `tca_iff_forall_not_isFourColourPlace` (T-C(A) at `S = ∅` likewise), `colorable_four_levelTarget_one_iff` (a level-one
   target is four-colourable exactly at a listed place), `exists_ratioAtMost_lt_quarter_iff` (the all-levels four-colour ratio
   is below `1/4` exactly off the list) and `five_le_chromaticNumber_levelTarget_one_iff`, this is FS100-CLS's statement in
   full: "every stable place has `r_v < 1/4` ⟺ no stable level-one target has `χ ≤ 4` ⟺ `L(F) ≥ 5` … the places with
   `r_v ≥ 1/4` are exactly `q ∈ {3, 7}`, dyadic inert `Q ≤ 32`, and dyadic ramified". The list is arithmetic (a predicate on
   the residue size and ramification), placed beside the colouring theorem, so the classification is a theorem.
   *Model*: `ℚ`'s prime above 2, ramified, is listed (`exists_isFourColourPlace_rat`). *Not claimed*: anything at six;
   novelty — prior art not yet searched (item 1027). On W alone.
5. **`Rigidity.five_le_localBoundAllLevels_iff`, `min_localBoundAllLevels_five`**: with `localBoundAllLevels F :=
   ⨅ P, ⨅ m ≥ 1, χ(levelTarget P m)`, `5 ≤ L_all(F) ↔ 5 ≤ L(F)` and `min(L_all(F), 5) = min(L(F), 5)`. *In words*: CLS's
   "level-one or all-levels reading of `L`" — the two readings agree through five. *Not claimed*: that they agree above
   five.
6. **`UpperHalf.localBound_le_unitQuadrance`**: `∀ (F) [NumberField F] {𝔭}, IsUsablePrime 𝔭 → L(F) ≤ χ(Γ_q)`,
   `Γ_q = unitQuadrance (𝓞 F ⧸ 𝔭)`, with `exists_stablePrime_card_eq_sq` (the stable prime above has `q²` residues). *In
   words*: a usable prime's residue plane is one of `L`'s level-one targets up to a homomorphism, so row 52's bound
   `χ(F²) ≤ χ(Γ_q)` holds in `L`'s own words. Prior art: row 52's (`[Moorhouse2010]` §8.2, §10.3); the form in `L` is
   this landing's bridge. *Not claimed*: that the prime above `𝔭` is unique. Standard three.
7. **`SqrtTwentyThreeCbrtTwo.chromaticNumber_planeOver_sqrt23_cbrt2_eq_five`**: `χ(F23²) = 5`, `F23 = Subfield.closure
   {√23, cbrtTwo}`, `cbrtTwo = 2 ^ ((1 : ℝ) / 3)` (pinned by `cbrtTwo_pow_three : cbrtTwo ^ 3 = 2`); **`localBound_sqrt23_cbrt2_eq_five`**
   `L(F23) = 5`; **`localBound_sqrt23_eq_four`** `L(ℚ(√23)) = 4`; **`not_isTotallyReal_F23`** `¬ IsTotallyReal F23`. *In words*:
   the plane over `ℚ(√23, ∛2) ⊂ ℝ` needs exactly five colours; its local bound is five, its real quadratic subfield's is
   four, and the field has a complex place. *Against the row*: "ℚ(√23, ∛2) has `L = 5` while its totally real subfields
   have `L ≤ 4` (X28D-CP2), so the complex-place step is load-bearing there" — held: `L(F23) = 5`, `L(ℚ(√23)) = 4`, and
   `ℚ` (`L(ℚ) ≤ 2`, the library's
   `Rigidity.localBound_bot_le_two`). *Not claimed*: that `ℚ` and `ℚ(√23)` are all of `F23`'s totally real
   subfields (X28D's Galois-theoretic statement); that the kernel's proof uses the complex place — the headline is stated for
   every real number field and asks no total reality, so the instance is the headline at a field with a complex place.
   `L = 5` on W alone; `χ = 5` on W and EL.
8. **`Rigidity.ratioAtMost_dyadic_of_six_le`** (the ruled addition): an unramified dyadic stable prime with
   `|𝓞 ⧸ P| = (2^f)²`, `f ≥ 6`, has all-levels ratio below `1/4`. Standard three.

**Not claimed by the landing as a whole**: anything at `L ≥ 6`; any explicit five-chromatic graph; χ(ℚ(√167)²) ≥ 5's
second route (every stable place 4-thick; planner's F5); novelty of CLS's general statement (not yet searched); `ℚ(√47)`'s
value keeps row 121's attribution.

## Drafts for the front page

*Each draft names its file, its section, and the words it replaces or follows. The counts are the second gate's (§ Stage 6,
on `960882257`, equal to the merge `21a5fc591` in `Proofs/`, `scripts/` and the package files). No novelty wording: CLS's
general statement has not been searched for by name (item 1027), so "prior art not yet searched" stands where a novelty
line would go; `ℚ(√47)`'s value keeps the ledger's attribution.*

**D1 — `CLAUDE.md` § Trust ledger, the audit's sentence.** Replace "the current audit reads 10885 clean and 5 declared
purchases, and 83 imported (and 574 axiom-free; 11,547 records at FS131-ICT3, three colours on abelian Cayley graphs,
2026-10-16)" with: "the current audit reads 10914 clean and 5 declared purchases, and 99 imported (and 574 axiom-free;
11,592 records at FS131-ICS1, five colours by field and by class, 2026-10-16)".

**D2 — `CLAUDE.md` § Trust ledger, the imports' tallies.** (a) Replace "with sixty-four imported records (twelve of them the
three-colour criterion's" with "with eighty imported records (twelve of them the three-colour criterion's", and after
"…and `borelChromaticNumber_padicPlane_three`)" (the p-adic clause, which closes the Weil parenthesis) insert before its
closing parenthesis: "; sixteen five colours by field and by class's, FS131-ICS1: CLS in full — `Rigidity.five_le_localBound_iff`
over the arithmetic list `Rigidity.IsFourColourPlace`, its per-place forms, T-C(A)'s and the all-levels reading's — and
`L(ℚ(√23, ∛2)) = 5` with its lower half, nine of them on Weil's bound alone; the other seven on E–L too". (b) Replace "with
twenty-seven, fourteen of which rest on Weil's bound too (" with "with thirty-four, twenty-one of which rest on Weil's bound
too (", and before "; the collapse's general form" insert ", and FS131-ICS1's seven: the quadratic dichotomy
`SqrtFiveClass.five_le_chromaticNumber_planeOver_sqrt_iff` with its local form, the family's `χ = 5` and `L = 5`,
`χ(ℚ(√23, ∛2)²) = 5`, `L(ℚ(√23)) = 4`, and the two readings of `L` agreeing through five".

**D3 — `CLAUDE.md` § Trust ledger, "What the library assumes".** Replace "`axioms=3 rests=105 named=19 inline=14 outside=7
ours=21 open=5 takes=109 mentions=2` — three outside theorems declared as axioms, with one hundred and five (axiom, theorem)
rows resting on them, ninety theorems, thirteen of them on two and one on three;" with "`axioms=3 rests=128 named=19 inline=14
outside=7 ours=21 open=5 takes=109 mentions=2` — three outside theorems declared as axioms, with one hundred and twenty-eight
(axiom, theorem) rows resting on them, one hundred and six theorems, twenty of them on two and one on three;". (Check:
85 + 2·20 + 3 = 128.)

**D4 — `CLAUDE.md` § The gate, the vacuity counts.** Replace "`declarations=22519 refutations-skipped=243 sites=1465`" with
"`declarations=22566 refutations-skipped=243 sites=1465`"; the second sentence (`vacuous=0 stale=0 declared=3 witnessed=40
generic=1420 unknown=2`) is unchanged.

**D5 — `CLAUDE.md` § Frontier, the "Last filed" line.** Replace "Last filed: **three colours on abelian Cayley graphs**
(FS131-KTC1, …; no value of `χ(ℝ²)` moved); before it," with "Last filed: **five colours by field and by class** (FS131-KCS1,
FS131-ICS1, 2026-10-16: four modules through the gate on `960882257` — for squarefree `m`, `χ(ℚ(√m)²) ≥ 5` exactly when
`m ≡ 47, 143, 167 (mod 168)`; `χ = L = 5` at each such squarefree `d` that is a square modulo 11 or 19; `L(F) ≥ 5` exactly
when no conjugation-fixed prime of `F(i)` is on an arithmetic list (CLS in full), and the two readings of `L` agree through
five; `χ(ℚ(√23, ∛2)²) = 5`, a field with a complex place; stated in `plans/KERNEL-HOLDS.md`; no value of `χ(ℝ²)` moved);
before it, **three colours on abelian Cayley graphs** (FS131-KTC1, FS131-ICT1, FS131-ICT2, FS131-ICT3),".

**D6 — `plans/KERNEL-HOLDS.md`, "What the kernel holds, beyond the interval".** After "…the derivation is this project's,
and the kernel's check is this landing's;" (the end of **the main clause through five**) insert: "**five colours by field
and by class** (FS-131, FS131-ICS1): for squarefree `m`, `χ(ℚ(√m)²) ≥ 5` exactly when `m ≡ 47, 143, 167 (mod 168)`
(`SqrtFiveClass.five_le_chromaticNumber_planeOver_sqrt_iff`; and `L(ℚ(√m)) ≥ 5` likewise, `…five_le_localBound_sqrt_iff`);
`χ(ℚ(√d)²) = L(ℚ(√d)) = 5` at every such squarefree `d` that is a square, zero included, modulo 11 or modulo 19
(`SqrtFiveClass.chromaticNumber_planeOver_sqrt_eq_five`, `…localBound_sqrt_eq_five`; 44 of the 52 class members below
3000); **CLS in full** — for every real number field `F`, `L(F) ≥ 5` exactly when no prime of `F(i)` fixed by conjugation is
ramified over `F`, has fixed field `𝔽₃` or `𝔽₇`, or is dyadic inert of norm at most 32 (`Rigidity.five_le_localBound_iff`
over the arithmetic predicate `Rigidity.IsFourColourPlace`; per place, the level-one target is four-colourable exactly at a
listed place and the all-levels four-colour ratio is below `1/4` exactly off the list,
`Rigidity.colorable_four_levelTarget_one_iff`, `…exists_ratioAtMost_lt_quarter_iff`; T-C(A) likewise,
`…tca_iff_forall_not_isFourColourPlace`; a listed place exists, `…exists_isFourColourPlace_rat`), on Weil's bound alone, and
the level-one and all-levels readings of `L` agree through five (`Rigidity.min_localBoundAllLevels_five`); a usable prime's
plane is a level-one target, `L(F) ≤ χ(Γ_q)` (`UpperHalf.localBound_le_unitQuadrance`, standard three; the bound is row
52's, in `L`'s words); and `χ(ℚ(√23, ∛2)²) = 5` with `L = 5`, while `L(ℚ(√23)) = 4` and the field has a complex place
(`SqrtTwentyThreeCbrtTwo.chromaticNumber_planeOver_sqrt23_cbrt2_eq_five`, `…localBound_sqrt23_cbrt2_eq_five`,
`…localBound_sqrt23_eq_four`, `…not_isTotallyReal_F23`) — row 123's class, family and complex-place instance; the lower halves
on `[EinsiedlerLindenstrauss2022]` Thm 1.3 and Weil's bound, the upper halves on the standard three. Prior art: CLS's general
statement not yet searched; the quadratic instances are posed as open by `[Davies2026]` p. 5 (row 123); `ℚ(√47)`'s value as row
121. Not claimed: anything at `L ≥ 6`; an explicit five-chromatic graph; `L` at the eight class members below 3000 that are a
square neither modulo 11 nor modulo 19 (167 first);"

**D7 — `LEDGER.md` row 123, the grade.** Replace "the family (44 of 52, `d ≤ 3000`), CLS in full and ℚ(√23, ∛2) keep the
derivation's grade:**" with: "**[kernel] since FS131-ICS1 for the quadratic dichotomy — for squarefree `m`, `χ(ℚ(√m)²) ≥ 5`
⟺ `m ≡ 47, 143, 167 (mod 168)` (`SqrtFiveClass.five_le_chromaticNumber_planeOver_sqrt_iff`, its `L` form
`…five_le_localBound_sqrt_iff`) —; the family as the derivation computed it, `χ = L = 5` at every squarefree `d` in the class
that is a square, zero included, modulo 11 or modulo 19 (`SqrtFiveClass.chromaticNumber_planeOver_sqrt_eq_five`,
`…localBound_sqrt_eq_five`; 44 of the 52 with `d ≤ 3000`, re-counted by `tools/fs131_ics1_census.py`); CLS in full
(`Rigidity.five_le_localBound_iff` over `Rigidity.IsFourColourPlace`, the per-place forms `colorable_four_levelTarget_one_iff`,
`exists_ratioAtMost_lt_quarter_iff`, `five_le_chromaticNumber_levelTarget_one_iff`, T-C(A)'s `tca_iff_forall_not_isFourColourPlace`,
the all-levels reading `five_le_localBoundAllLevels_iff`, `min_localBoundAllLevels_five`; on Weil's bound alone, the last on E–L
too); and ℚ(√23, ∛2) (`SqrtTwentyThreeCbrtTwo.chromaticNumber_planeOver_sqrt23_cbrt2_eq_five`, `localBound_sqrt23_cbrt2_eq_five`
on Weil's bound alone, `localBound_sqrt23_eq_four`, `not_isTotallyReal_F23`) — `Instances/SqrtFiveClass`,
`Rigidity/FourColourPlaces`, `Instances/SqrtTwentyThreeCbrtTwo`, with the bridge `UpperHalf.localBound_le_unitQuadrance`
(`Arith/StableAboveUsable`); the rest keeps the derivation's grade — the ledger's wider family "with `L = 5`" at the class
members that are a square neither modulo 11 nor modulo 19 (eight below 3000, 167 first; `L` open there), `χ(ℚ(√167)²) ≥ 5`'s
second route, and X28D's statement that `ℚ` and `ℚ(√23)` are all of ℚ(√23, ∛2)'s totally real subfields:**". And in the row's
*Prior art* sentence, after "…it has no local bound and no statement over a general number field.", add: "CLS's general statement:
prior art not yet searched (FS131-ICS1, item 1027)." The row's address column gains `Proofs/HadwigerNelson/Instances/SqrtFiveClass.lean`,
`Rigidity/FourColourPlaces.lean`, `Instances/SqrtTwentyThreeCbrtTwo.lean`, `Arith/StableAboveUsable.lean`; `plans/FS131-ICS1-class.md`.

**D8 — `ROADMAP.md` § 3, item 1.** Replace the item ("**Not stored as theorems** (`LEDGER.md` row 123; …) … the case with a
complex place.") with: "1. **Row 123's remainder** (the class, the family as the derivation computed it, CLS in full and
ℚ(√23, ∛2) are kernel theorems since FS131-ICS1, `plans/KERNEL-HOLDS.md`): `L` at the class members that are a square neither
modulo 11 nor modulo 19 — 167, 887, 1055, 1319, 1823, 2351, 2735, 2903 below 3000 — which needs a target the kernel does not
hold (`Γ₃₁` first, undecided); and `χ(ℚ(√167)²) ≥ 5` by its second route (every stable place 4-thick)." And in the appendix,
group B, row 123's line: replace "| 123 | hand | yes |" with "| 123 | kernel, hand | yes |" (its kernel part as D7).

**D9 — `README.md`, the table "Planes over number fields".** After the row "`χ(ℚ(√47)²) = 5`. Also `χ = 5` over ℚ(√143), …"
insert the row: "| For squarefree `m`, `χ(ℚ(√m)²) ≥ 5` exactly when `m ≡ 47, 143, 167 (mod 168)`, and `χ(ℚ(√d)²) = 5` at each
such squarefree `d` that is a square (zero included) modulo 11 or modulo 19. `L(F) ≥ 5` exactly when no prime ideal of `F(i)`
that conjugation maps to itself is ramified over `F`, has a residue field of 9 or 49 elements, or lies above 2 with at most
`32²` elements in its residue field. `χ(ℚ(√23, ∛2)²) = 5`, at a field with a complex place, while `L(ℚ(√23)) = 4`. |
`SqrtFiveClass.five_le_chromaticNumber_planeOver_sqrt_iff`, `SqrtFiveClass.chromaticNumber_planeOver_sqrt_eq_five`,
`Rigidity.five_le_localBound_iff`, `SqrtTwentyThreeCbrtTwo.chromaticNumber_planeOver_sqrt23_cbrt2_eq_five` | std3 + **EL** +
**W** (the class criterion `L(F) ≥ 5`: std3 + **W**) | `[Davies2026]` p. 5 asks, for these residue classes, for a
five-chromatic graph and whether six colours suffice: the lower bound `≥ 5` holds at every such squarefree `n`, with no graph
exhibited, and five colours suffice at the squares modulo 11 or 19. The class criterion: prior art not yet searched | 123 |".

**D10 — `LEAN.md` § Searching — Lean, new lines** (the planner's § 3.5 item 2 first):
- "`decide` on `Squarefree n` at a numeral sticks at the well-founded `Nat.minSqFac`; for a prime use `(by norm_num : Nat.Prime
  n).prime.squarefree` (FS131-KCS1)."
- "`ValuationSubring.mul_mem`, `add_mem`, `neg_mem`, `sub_mem` take the two elements explicitly (`B.mul_mem x y hx hy`); the
  `SubringClass` forms `mul_mem hx hy` take the membership proofs alone (FS131-ICS1)."
- "`UpperHalf.exists_I_integer` gives an integer `i` of `F(i)` with `i² = −1` and `ī = −i`, not its sign: a proof that needs
  `(i : ℂ) = I` builds the integer itself (`StableAboveUsable`'s private `iO`, from `exists_I_integer`'s own proof; FS131-ICS1)."
- "A field generated by a cube root `c` of 2 and `√23` maps to any field `L` of characteristic zero that holds a cube root `y` of
  2 and a square root of 23, with `c ↦ y` and no Galois closure: `IntermediateField.algHomAdjoinIntegralEquiv` at the root `y` of
  `minpoly ℚ c = X³ − 2` (irreducible by `X_pow_sub_C_irreducible_of_prime`, in `Mathlib.FieldTheory.KummerPolynomial`, not in
  the library's closure before; no rational cube root of 2 by `padicValRat.pow` at 2), then `L` as a `ℚ(c)`-algebra through that
  map and `IntermediateField.nonempty_algHom_adjoin_of_splits` for `√23` over `ℚ(c)`. One lemma serves the `p`-adic embedding and
  a complex embedding (`SqrtTwentyThreeCbrtTwo.exists_ringHom_F23`, private; FS131-ICS1)."
- "A valuation subring of `F(i)` above a valuation subring `B` of `F` at an inert place: `B[i] = {z : Re z, Im z ∈ B}` is one
  when `1 + t²` is a unit of `B` for every `t ∈ B` (`b = t·a` gives `a + bi` or its inverse); `ValuationSubring.ofSubring` with the
  case split `b/a ∈ B` or `a/b ∈ B`, and `UpperHalf.exists_stablePrime_of_valuationSubring` names the stable prime
  (`StableAboveUsable`'s private `gaussVal`; FS131-ICS1)."
- "`decide` gave 'Expected type must not contain free variables' on a closed residue fact (`((23 : ℕ) : ZMod 11) ≠ 0`) passed as an
  argument while a `haveI : Fact (Nat.Prime 11)` was in scope; stated as a closed lemma and passed, it elaborated (seen once; the
  mechanism not read; FS131-ICS1)."
- "The assumptions step counts a theorem concluding `∃ x, P x ∧ …` as concluding `P`: a landing that proves such an existence
  makes a declared `.condition` for `P` `stale-condition`, and the entry is retired (`Arith.IsUsablePrime` by
  `SqrtTwentyThreeCbrtTwo.exists_usablePrime_eleven_F23`, FS131-ICS1). A predicate a new module takes as a hypothesis with no
  theorem concluding it fails as `undeclared-never-concluded`, and an `example` exhibiting a model does not count, being not
  stored: state the model as a theorem (`Rigidity.exists_isFourColourPlace_rat`, FS131-ICS1)."
- "A destructuring `fun ⟨_, h⟩ => …` or `let ⟨_, h⟩ := …` in a term-mode proof leaves a public `….match_1_1` auxiliary that the
  vacuity scan counts in `declarations=` (FS131-ICS1: two in `Rigidity/FourColourPlaces`); reconcile the count with them, or
  write the proof with `obtain`."
- "Making a private theorem public is a rename: its instance binders' hygienic hash, minted from the declaration name, moves,
  and Lean's hash of the stored type (which reads no binder name) does not. A statement check across the change compares the
  private constant with its public name with that hash blanked for those constants alone, and the stored-type hashes equal
  (`data/fs131/ics1/statements.py`'s `PUBLICIZED`, `logs/publicized-hashes.txt`; FS131-ICS1)."
- "A landing whose branch changed a module that main's newer modules do not import copies only those new modules' build files
  from main's tree (a full `rsync --checksum` dry run lists `ClassRatio` and its 19 downstream modules too, which it would replace
  by builds of the old source): the copy, a checksum manifest before and after, and the build rebuilds the root alone
  (`data/fs131/ics1/logs/copy2-*`; FS131-ICS1)."

**D11 — `plans/POROS-2026-10-13-number-field-findings.md` § 3.3** (its writer's; the planner's § 3.5 item 3, unchanged):
"`Cay(𝒪/𝔓^m, image of the unit vectors)`, `𝔓` a prime of `F(i)` fixed by complex conjugation, `m ⩾ 1`" → "`Cay(𝒪/𝔓, the
norm-one residues)`, `𝔓` a prime of `F(i)` fixed by complex conjugation (level one; the all-levels reading agrees through five,
`Rigidity.min_localBoundAllLevels_five`)".

**D12 — `ARCHITECTURE.md`, the row `Rigidity/ClassRatio`** (not edited here; FS131-IFR1 edits the same module): append to its
description "Public since FS131-ICS1 (items 1027, 1029): `exists_card_two_pow_sq`, `chromaticNumber_le_four_dyadic`,
`chromaticNumber_le_four_of_small`, and `ratioAtMost_dyadic_of_six_le` (the `f ≥ 6` branch of `ratioAtMost_dyadic`, stated alone)."

**D13 — the Proof Atlas** (rebuilt locally at the filing): row 123's grade from [hand] to [kernel] for the dichotomy, the family as
computed, CLS in full and ℚ(√23, ∛2); [hand] stays for the wider family's eight members and the second route at ℚ(√167).

**D14 — `CLOSED-QUESTIONS.md`** (if the filing keeps `[Davies2026]`'s question there): the quadratic residue classes'
lower half `χ(ℚ(√n)²) ≥ 5` is now a kernel theorem for every squarefree `n ≡ 47, 143, 167 (mod 168)`; six-colourability is
answered (five colours) at the members that are squares modulo 11 or 19, and open at the rest; no graph is exhibited.

## Stage 6 — SAVED: the second gate, after `main`'s second merge (item 1047)

`main` gained the three-colour criterion (`8ebb647bc`, three `CayleyThree/` modules) after the first gate, so `main` merged
again (`21a5fc591`). Two conflicts, both resolved by keeping both landings' entries: `scripts/Axioms.lean` (the two CLEAN
blocks before `=== PURCHASED ===`, the three-colour block first) and the vacuity header (`declarations=22566`, its sites and
verdicts the three-colour gate's: my modules add no site). `Proofs.lean` and `ARCHITECTURE.md` merged with no conflict;
the architecture check passes (`logs/arch-2.txt`). **The build copy**: a full `rsync --checksum` dry run from `main`'s
checkout listed 86 files, among them `ClassRatio`'s and its 19 downstream modules', which it would have replaced by builds of
the old source (`logs/copy2-dryrun-full.txt`). So only the three `CayleyThree` modules' 24 files were copied; their imports
(`Arith/ThreeColourCharacter`, `Kempe`, `LocalGlobal`, Mathlib) include nothing this branch changed. Manifests before and
after: the source unchanged, the copies identical (`logs/copy2-*`). **The build** on `21a5fc591`: exit 0, "241 of 241
batches, 1 module(s) rebuilt" — the root alone — "0 module(s) with warnings, 7m18s" (`logs/build-4.log`, `build-4-full.log`).
The 21 dumped modules were not rebuilt, so the statement comparison of Stage 3 (redone after the model theorem, Stage 4)
reads the modules as gated.

**The run** on `960882257` (two commits after the merge, touching only `plans/` and `data/`: `git diff 21a5fc591 960882257 --
Proofs Proofs.lean scripts lakefile.toml lake-manifest.json lean-toolchain` is empty), logs `data/fs131/ics1/gate/`
(the first gate's kept as `gate-1/`): `tracked-modified=0`; up to date; `sorry` lines 0; line-initial `axiom` lines 5;
dupnames 0 and its self-test 0; axioms 0 and its self-test 0; vacuity 0 and its self-test 0; assumptions 0 and its self-test
0; architecture 0; lint 0; the three digests 0 (each flags only `CLAUDE.md`'s recorded counts, which D1–D4 carry). "tracked
files modified after the pass: 1" — this record, its drafts written during the run.

**Count changes against the three-colour gate** (`data/fs131/ict3/gate/`, on `2b04f38d5`):

| count | ict3 | ics1 (second gate) | change | why |
|---|---|---|---|---|
| audit records | 11,547 | 11,592 | +45 | this landing's 45 newly filed public records (56 in the five modules, 11 filed before) |
| clean | 10,885 | 10,914 | +29 | 28 from the generator, and `exists_isFourColourPlace_rat` |
| axiom-free | 574 | 574 | 0 | — |
| imported | 83 | 99 | +16 | 9 on W alone, 7 on EL and W |
| declared purchases | 5 | 5 | 0 | — |
| assumptions `rests` | 105 | 128 | +23 | 9 + 2·7; the other eight counts unchanged |
| vacuity `declarations` | 22,519 | 22,566 | +47 | as against iqp3: `ClassRatio` +4, the four modules +43 |
| vacuity sites, verdicts, `refutations-skipped` | 1,465 (0, 0, 3, 40, 1,420, 2); 243 | the same | 0 | no site |
| dupnames generated on demand | 31 | 31 | 0 | — |

The first gate (`gate-1/`, on `6ff038e87`, before the three-colour criterion) read the same changes against the p-adic gate
(§ Stage 4); the two runs agree in every change.
