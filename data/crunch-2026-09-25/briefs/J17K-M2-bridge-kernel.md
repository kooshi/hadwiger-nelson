*Brief for crunch job **J17K**, milestone M2 (FS-39, `plans/STUB-plane-bridge.md` phases B0–B1 and C; the C3 lemmas), kernel. Opus 5.5,
2026-09-25. Written by J17 (`plans/M2-S1D-bridge.md` §3.2, §3.4), at the owner's request after the owner ruled "YES to the kernel follow-on" and
sent Lemma NP to the kernel "via Mathlib's Polynomial.abc" in place of a blind verifier.*

Hello. You are de Bruijn (`DEBRUIJN.md`), the kernel engineer for FS-39's bridge, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`,
`WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** No
children: do not use the Agent tool, a fork or a workflow (delegation here is one level deep; staffing is Kooshi's budget decision, and the owner
can only review work it knows about). **If your record already exists, you are resuming: read it and the brief, check the last SAVED stage
against `git log -- <record>`, and continue at the first stage not SAVED. Redo nothing saved.** You run after J16 in M2's serial kernel lane
(J14 → J15 → J16 → J17K).

## The question, and why now
Every "`χ(ℝ²) = …`" sentence this project writes rests on the bridge `χ(ℝ²) = sup` over real number fields `F` of `χ(F²)`. J17 wrote it in full by
hand (`plans/M2-S1D-bridge.md` §2; the proof is `[Madore2015]` ¶5.4's, by Tarski) and priced its kernel form: the one deep input — real
algebraic points exist on every rational variety with a real point — needs quantifier elimination for real closed fields, which Mathlib lacks,
so it costs months. What the kernel can have **now** is (a) the bridge and its corollary C4 as theorems conditional on that one input, stated as
a named `Prop`; (b) the real-closed-field instances every eventual proof of that input needs, which are Mathlib's own open TODO; (c) Lemma NP,
the only fresh hand algebra in J17, by Mathlib's Mason–Stothers. **Every outcome counts** (rule 4): a leaf that will not close, named with its
obstruction, is a result.

## The statements (verbatim, each with its address)
- **C1** (`plans/M2-kernel-lane.md` §4.2): "For every finite graph `H` and every map `f : V(H) → ℝ²` with `‖f(x) − f(y)‖ = 1` on every edge,
  there is a real number field `F` and a map `g : V(H) → F²` with `‖g(x) − g(y)‖ = 1` on every edge." (Non-injective `g` allowed.)
- **C2** (same address): "`χ(ℝ²) = sup { χ(F²) : F ⊂ ℝ a number field }`, the chromatic number of `F²` meaning that of the unit-distance graph
  on `F × F`."
- **C4** (same address): "`χ(ℝ²) ≠ 6` if and only if every real number field `F` with `χ(F²) = 6` has a finite extension `F′ ⊂ ℝ` with
  `χ(F′²) = 7`" (`plans/STUB-plane-bridge.md` §5, FS62-T2), given C2.
- **B0, B1** (`plans/M2-S1D-bridge.md` §3.2, "What the kernel can have now, honestly"): "**B0 — (RC)**, `IsRealClosed ℝ` and
  `IsRealClosed (algebraicClosure ℚ ℝ)`: ~1 day, upstreamable, needed by every route." and "**B1 — the bridge as a conditional theorem**:
  `chromaticNumber_plane_eq_iSup_numberField_of_descent (h : RealAlgebraicDescent) : …` with `RealAlgebraicDescent` the statement of C1 (or of
  (∃T) for `R_alg ⊆ ℝ`) as a `Prop`, … plus C4 (FS62-T2) on top". (The same paragraph's "the hypothesis `VACUITY DECLARED`" is **superseded**
  below, *The hypothesis and the vacuity gate*.)
- **(∃T)** (`plans/M2-S1D-bridge.md` §2.1): "a system of polynomial equations over a real closed `R` with a solution in a real closed `R′ ⊇ R` has
  one in `R`".
- **Lemma NP** (`plans/M2-S1D-bridge.md` §2.3): "There is no nonconstant `a ∈ ℂ(t)` for which `a³ − a` is a square in `ℂ(t)`." Its hand proof is
  there in full: `a = p/q` coprime; `c²q³ = e²·p(p − q)(p + q)` forces `e² = λq³` and `c² = λ·p(p − q)(p + q)`; the four pairwise coprime factors
  are squares, `p = α², q = β², p − q = γ², p + q = δ²`; then "`α⁴ = β⁴ + (γδ)²`" contradicts Mason–Stothers because "`deg γ + deg δ … ≤ 2D`"
  with `D := max(deg α, deg β) ≥ 1`.
- **C3, one-variable containment form** (derived from J17-T5, §2.3): for `F : Subfield ℝ` with every element algebraic over `ℚ` and `t : ℝ`
  transcendental over `F`, the two reals `x := 2 + liouvilleNumber 10` and `y := √(x³ − x)` do not both lie in `F⟮t⟯`. (J17's own C3 is about
  `π`; Mathlib lacks `π`'s transcendence, and §2.3 names `x = 2 + L` as the kernel-friendly choice: "Any real transcendental `x > 1` in place of
  `π` works — e.g. `x = 2 + L`".)
- Mathlib, verbatim: `FieldTheory/IsRealClosed/Basic.lean` line 26, "TODO (Artie Khovanov) : real numbers, real algebraic numbers, hyperreals form
  a real closed field"; `IsRealClosed.of_linearOrderedField [LinearOrder R] [IsStrictOrderedRing R] (isSquare_of_nonneg : ∀ {x : R}, 0 ≤ x →
  IsSquare x) (exists_isRoot_of_odd_natDegree : ∀ {f : R[X]}, Odd f.natDegree → ∃ x, f.IsRoot x) : IsRealClosed R` (line 60);
  `protected theorem Polynomial.abc {a b c : k[X]} (ha : a ≠ 0) (hb : b ≠ 0) (hc : c ≠ 0) (hab : IsCoprime a b) (hsum : a + b + c = 0) :
  (natDegree a + 1 ≤ (radical (a * b * c)).natDegree ∧ natDegree b + 1 ≤ (radical (a * b * c)).natDegree ∧ natDegree c + 1 ≤
  (radical (a * b * c)).natDegree) ∨ derivative a = 0 ∧ derivative b = 0 ∧ derivative c = 0` (`NumberTheory/FLT/MasonStothers.lean:55`).

**The Lean statements** (proposed; refine them at the skeleton, and record every change with its reason):
```lean
/-- Real algebraic points exist on every rational variety that has a real point. True (Tarski; Artin–Lang) — not provable here. -/
def RealAlgebraicDescent : Prop :=
  ∀ (n : ℕ) (S : Finset (MvPolynomial (Fin n) ℚ)), (∃ x : Fin n → ℝ, ∀ p ∈ S, MvPolynomial.aeval x p = 0) →
    ∃ x : Fin n → ℝ, (∀ i, IsAlgebraic ℚ (x i)) ∧ ∀ p ∈ S, MvPolynomial.aeval x p = 0

theorem exists_numberField_drawing_of_descent (hD : RealAlgebraicDescent) {ι : Type*} [Finite ι] (G : SimpleGraph ι)
    (f : ι → ℂ) (hf : ∀ x y, G.Adj x y → dist (f x) (f y) = 1) :
    ∃ F : Subfield ℝ, NumberField F ∧ ∃ g : ι → ℂ, (∀ i, g i ∈ planeOver F) ∧ ∀ x y, G.Adj x y → dist (g x) (g y) = 1   -- C1

theorem iSup_numberField_le_chromaticNumber_plane :                                                                  -- free half, no hypothesis
    ⨆ (F : Subfield ℝ) (_ : NumberField F), ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ≤ (unitDistance ℂ).chromaticNumber

theorem chromaticNumber_plane_eq_iSup_numberField_of_descent (hD : RealAlgebraicDescent) :                          -- C2
    (unitDistance ℂ).chromaticNumber = ⨆ (F : Subfield ℝ) (_ : NumberField F), ((unitDistance ℂ).induce (planeOver F)).chromaticNumber

theorem exists_numberField_chromaticNumber_eq_plane_of_descent (hD : RealAlgebraicDescent) :                        -- attainment
    ∃ F : Subfield ℝ, NumberField F ∧ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber = (unitDistance ℂ).chromaticNumber

theorem chromaticNumber_plane_ne_six_iff_of_descent (hD : RealAlgebraicDescent) :                                    -- C4
    (unitDistance ℂ).chromaticNumber ≠ 6 ↔ ∀ F : Subfield ℝ, NumberField F →
      ((unitDistance ℂ).induce (planeOver F)).chromaticNumber = 6 →
      ∃ F' : Subfield ℝ, F ≤ F' ∧ NumberField F' ∧ ((unitDistance ℂ).induce (planeOver F')).chromaticNumber = 7

instance : IsRealClosed ℝ                                                                                             -- B0
instance : IsRealClosed (algebraicClosure ℚ ℝ)                                                                        -- B0

theorem not_isSquare_cube_sub_self {k : Type*} [Field k] [IsAlgClosed k] [CharZero k] {a : RatFunc k}                -- Lemma NP
    (ha : a ∉ Set.range (RatFunc.C (K := k))) : ¬ IsSquare (a ^ 3 - a)
```

**The hypothesis and the vacuity gate — read this before writing a docstring.** The owner's request says "one DECLARED hypothesis, named for
the vacuity gate". **Do not put the `VACUITY DECLARED:` marker on `RealAlgebraicDescent` or on the theorems that assume it**, and follow J14's
precedent instead. `CLAUDE.md` § The gate, verbatim: "`DECLARED` (deliberate emptiness, named with its reason in the docstring as
`VACUITY DECLARED:` and printed every run)". J14, verbatim (`plans/M2-S1K-chain.md`, "Deviation from the brief"): "the gate reads
`VACUITY DECLARED:` as a checked claim that a hypothesis's domain is **provably empty** … `G4` is unproved, not empty". `RealAlgebraicDescent` is
**true** (Tarski), so the marker would assert a falsehood. Do instead what `five_le_chromaticNumber_planeOver_seven_of_G4` does
(`Proofs/HadwigerNelson/Instances/SevenConditional.lean`): a docstring that says "**Conditional, and not vacuous**", names the hypothesis's truth
(Tarski 1951; Artin–Lang, Lang 1953; `plans/M2-S1D-bridge.md` §2.1) and why it has no kernel proof (Mathlib has no quantifier elimination for real
closed fields, §3.1 there). "Named for the vacuity gate" is met by the name `RealAlgebraicDescent` itself, the `_of_descent` suffix on every
theorem that assumes it, and your report of each one's `vacuity.sh` verdict (expected `GENERIC`, or no site at all: a `Prop` hypothesis is not a
`Coloring` binder). **Ship two controls beside the hypothesis**, which together show it is neither absurd nor trivially true:
- *a partial inhabitant* — `realAlgebraicDescent_one`: the statement for `n = 1` (a set of univariate rational polynomials with a common real
  root has a common real algebraic root: if some member is nonzero its root is algebraic, else take `0`);
- *a planted false twin* — `RationalDescent` (the same statement with `x i ∈ Set.range ((↑) : ℚ → ℝ)` in place of `IsAlgebraic ℚ (x i)`) and
  `not_rationalDescent` (from `X₀² − 2`), proved in the kernel: the analogous hypothesis one notch stronger is refutable, so a false hypothesis of
  this shape would not have survived review.
If you judge the owner meant the marker literally, the owner's answer is one docstring line; ask in your report, do not block on it.

## Read first, from disk
- `plans/M2-S1D-bridge.md` §2.0 (conventions: `(H)`, `(dBE)`, `(RC)`), §2.1 (route T, the proof you encode), §2.2 (C2 with attainment: "every
  term is at most 7, `S` is finite, and **the supremum is a maximum**"), §2.3 (Lemma NP and Snyder's proof), §2.4 (C4), §3.1 (what Mathlib holds,
  by file), §3.2 (the prices).
- The repository: `Proofs/HadwigerNelson/UnitDistance.lean` (`unitDistance`, `chromaticNumber_unitDistance_congr`), `Reduction.lean:51`
  (`chromaticNumber_plane_eq_complex`), `Instances/Interval.lean:35` (`chromaticNumber_plane_interval`, the `≤ 7` you need for attainment),
  `SquareClass.lean:63` (`planeOver`), `Chain.lean:182` (`planeOverSubring`), `Kempe.lean` around line 131 (the `Finset.rado_selection` pattern),
  `Instances/SevenConditional.lean` (the conditional-theorem docstring to copy); J15's `Proofs/HadwigerNelson/Transcendental.lean` if it landed
  (`planeOverIso`, the adjunction `F⟮t⟯` as a `fieldRange`, needed only for C3), else `data/m2/j04/K2Transcendental.lean`.
- Mathlib: `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom` (`Combinatorics/SimpleGraph/Finsubgraph.lean:154`), `Finset.rado_selection`
  (`Combinatorics/Compactness.lean:64`); `ENat.exists_eq_iSup_of_lt_top`, `ENat.sSup_mem_of_nonempty_of_lt_top` (`Data/ENat/Lattice.lean:108–118`)
  for attainment; `algebraicClosure` (`FieldTheory/AlgebraicClosure.lean:40`); `IntermediateField.adjoin` with finitely many integral generators
  for "finite over `ℚ`"; `Analysis/Polynomial/Order.lean` and `intermediate_value_Icc` for odd-degree roots over `ℝ`; `Polynomial.abc`;
  `exists_associated_pow_of_mul_eq_pow'` (`RingTheory/PrincipalIdealDomain.lean:482`) for "coprime factors of a square are squares";
  `Liouville.transcendental`, `transcendental_liouvilleNumber`.

## Fenced
Nothing is fenced from you.

## Stages
1. The quotation check (every quotation above against its address; log each); C0 (a probability per product, and the three registered below);
   then **price from the skeleton's first two leaves** — `exists_numberField_drawing_of_descent` (the encoding of a unit-distance drawing as a
   `Finset` of rational `MvPolynomial`s, and "finitely many algebraic reals generate a number field") and `IsRealClosed ℝ` — and record the price
   beside `plans/M2-S1D-bridge.md` §3.2's (~40k). Save.
2. `Proofs/HadwigerNelson/Bridge.lean`: `RealAlgebraicDescent`, its two controls, C1, the free half, C2, attainment, C4; a spec example per
   definition; each headline read aloud against C1, C2, C4 above (~120k). Save.
3. `Proofs/HadwigerNelson/RealClosed.lean`: the two B0 instances (upstreamable: write them in Mathlib's style, no project imports) (~60k). Save.
4. `Proofs/HadwigerNelson/NoParam.lean`: Lemma NP via `Polynomial.abc`; a planted fault watched red, then restored. The plant to use is the
   **genus-0 twin**: the same statement for `a ^ 2 - 1` is false (`a = (X² + 1)/(2X)` gives `a² − 1 = ((X² − 1)/(2X))²`), so NP's proof run on it
   must fail, and the counterexample should be proved in the kernel beside it — a red that comes from the curve's genus, not from scaffolding.
   (Dropping `CharZero k` is *not* a good plant: NP stays true in odd characteristic; only the proof's derivative step breaks.) Then, if time
   remains, the C3 one-variable form, and C3⁺ (J17-T6: no embedding into a purely transcendental extension of any number field — restriction to
   a line) last (~80k). Save.
5. The gate, the module map, the report (~40k).

**Priority if short:** B1 (C1 → free half → C2 → attainment) → C4 → B0 (`ℝ`, then the algebraic numbers) → Lemma NP → C3 one-variable → C3⁺.
**Stop rule:** at 3.5 hours or 350k, land what is green in that order and name the leaves left, each with its obstruction; if C1's encoding is
still open at 75 minutes, land C2 and C4 with C1's graph form (the C1 statement itself, as `RealAlgebraicDrawing : Prop`) as the hypothesis
instead, and name the encoding as the leaf left.

**Registered before you start** (J17's; both outcomes reachable for each; score them in your record):
| id | prediction | p |
|---|---|---|
| P-J17Ka | B1 and C4 land green, conditional on `RealAlgebraicDescent`, inside 2 hours | 0.60 |
| P-J17Kb | both B0 instances land | 0.60 |
| P-J17Kc | Lemma NP lands via `Polynomial.abc` in at most 200 lines | 0.50 |

## Kernel lines (verbatim, every kernel brief)
- "Build only as `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`, never `lake build`; iterate with
  `scripts/slot.py --mem <measured> --cpus 4 -- lake env lean <file>` (it builds nothing, and does not apply the lakefile's options:
  `autoImplicit` is off only in the real build)."
- "On a slot refusal (exit 75), wait ten minutes and retry; never raise a cap."
- "The gate: the build green, zero `sorry`, `./scripts/axioms.sh` and `./scripts/vacuity.sh` green with their counts reported, an inhabitant per
  structure hypothesis, a spec example per definition."
- "Prose in any module a certificate imports is written as `--` comments."
- "You are the only kernel job running; the owner starts the next one when you report."

Also: new modules only (a declaration added to `SquareClass.lean` or `Chain.lean` rebuilds their dependents); add each to `Proofs.lean`, to
`ARCHITECTURE.md`'s module map (`python3 tools/check_architecture.py` green), and each public theorem to `scripts/Axioms.lean`'s CLEAN section.
The two `IsRealClosed` instances are global `instance`s on types you do not own: they are true and canonical (Mathlib's TODO), so they may be
global, but say in the docstring that they are upstream candidates and must be deleted when Mathlib gains them. Measured iteration peak in this
lane: 3.4 GB (`--mem 8` is honest; re-measure). No `native_decide`, no solver (the ban holds; keep the "would have searched here" log). Read each
headline statement aloud against its informal claim before the gate. Report the vacuity counts and state any change to `CLAUDE.md` § The gate's
recorded counts as a proposed edit (you do not edit `CLAUDE.md`).

## Record and paths
Record: `plans/M2-S4K-bridge.md`, with "Theorems this phase proved". Working files: `data/m2/j17k/`; any exact check in `tools/crunch_j17k_*.py`,
with a planted fault watched red. Budget 350k (harness); hand back by 420k. Report (rule 9) after stage 5, or at any halt you can foresee, to
`data/crunch-2026-09-25/reports/J17K.md`, and SendMessage the same text to `"main"`. Any follow-on job (B2, `(∃T)` in the kernel, is months and is
**not** one: name it only as a leaf) as a Q-line with its brief file.
