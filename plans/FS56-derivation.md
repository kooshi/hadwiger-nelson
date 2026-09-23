# FS-56 — the derivation file: every theorem this milestone proved outside the kernel

*Written 2026-09-23 by the FS-71 batch-6b implementer (`plans/FS71-theorem-audit.md`, row 71; G60). Enumeration:
`plans/FS56-field-blowup.md` read in full (98 lines, the brief's "read in full" — this is the theorem's cleanest, final
write-up); `plans/FS56-quadratic-167.md` read in full (400 lines: §0 the certificate at 23, §1 the same B1–B4 lemmas in an
earlier form plus §2's "hard limit" cap theorem and the ratio-bound reading, §3–§4 the not-landed Q1 search and its checker
soundness obligations, §5 what the milestone is not, §M the modeling passes, §PA the prior-art gate); `plans/STUB-quadratic-167.md`
grepped, confirmed superseded by `plans/FS56-quadratic-167.md` §3–§5 (no independent content); `data/fs56/README.md`,
`data/fs56/q0/RESUME.md` read in full (short); `plans/SESSION-HANDOFF-2026-09-16-fs56.md` grepped. `LEDGER.md` row 71 read
as the seed. Grades are `CLAUDE.md` § Notation's.*

## The theorems

**FS56-T1 — Every congruence between subsets of a field plane is an isometry of that plane. [hand; the FS-56 implementer, 2026-09-16]** Let `F ⊆ ℝ` be a subfield, `Y, Y′ ⊂ F²` with `|Y| ≥ 2`, and `φ` a Euclidean isometry with `φ(Y) = Y′`. Then
`φ` is `z ↦ uz + t` or `z ↦ u z̄ + t` with `u, t ∈ F(i)` and `u ū = 1`. *The argument:* every isometry of `ℂ` has one of those two
forms with `|u| = 1`; picking `y₁ ≠ y₂ ∈ Y` gives `u = (φ(y₂) − φ(y₁))/(y₂ − y₁)` (or the conjugate-denominator form), which
lies in `F(i)` because `F(i)` is closed under complex conjugation (`F` real) and under the field operations; `t = φ(y₁) − u y₁`
then also lies in `F(i)`, and `u ū = 1` follows from `|u| = 1` together with `u ∈ F(i)`. *Proof:* `plans/FS56-field-blowup.md`
§ "B1 — every congruence between subsets of F² is an isometry of F²" (the complete three-line proof); restated as Lemma B1
in `plans/FS56-quadratic-167.md` §1 (identical proof, one paragraph). *Proof verdict:* closes. *Rests on it:* FS56-T2 (the
finiteness and solvability of the isometry group `T` generates); every consequence of the blow-up (row 71's whole content).
*Prior art:* ours — the fact that a congruence of point sets in a coordinate field is realised by a field-rational isometry
is elementary and not separately attributed; `[MatolcsiEtAl2025]`'s own Theorem 1 (MRVZ) works over `ℝ` throughout and never
raises the question of which field an isometry's coefficients live in. zbMATH: `ab:"fractional chromatic number" & ab:"unit
distance graph"` (4 hits, all this project's own prior-art neighbours — `[MatolcsiEtAl2025]` and its cousins — none stating
a field-rationality lemma). *Kernel:* declined — would need `Isom(ℂ)`'s classification plus a field-closure argument; no
consumer beyond FS56-T2, itself declined for want of amenability/Følner infrastructure.

**FS56-T2 — The geometric fractional blow-up stays inside the field. [hand; the FS-56 implementer, 2026-09-16, transcribing MatolcsiEtAl2025 Theorem 1 with the field kept]** For every subfield `F ⊆ ℝ`, every finite `H ⊂ F²`, every family
`𝒞` of pairs of congruent subsets of `H` (each of size ≥ 2) and every `ε > 0`, there is a finite `G ⊂ F²` with
`χ_f(G) ≥ χ_gf(H; 𝒞) − ε`; hence `χ(F²) ≥ ⌈χ_gf(H; 𝒞)⌉`. *The argument:* MRVZ's Theorem 1 verbatim, with three checks specific to
keeping the field: (i) the finite set `T` of isometries realising a pair of `𝒞` is, by FS56-T1, a subset of
`F(i) ⋊ (U_F ⋊ ⟨conj⟩)` — translations by `F(i)` (abelian, normal) extended by rotations `U_F` (abelian) extended by order 2
— hence solvable, hence amenable, hence has a right Følner sequence `R_m`; (ii) `G_m = ⋃_{σ∈R_m} σH ⊂ F²` since every
`σ ∈ Isom(F²)` by (i); (iii) the near-invariance argument bounding `|R_mT∖R_m|` terms each by `χ_f(G_m) ≤ χ(ℝ²) ≤ 7` (row
33) closes by compactness of the weight-≤7 regular fractional colourings of `H`. *Proof:* `plans/FS56-field-blowup.md`
§ "B2 — MRVZ Theorem 1, with the field kept" (the five-step proof in full); restated generalised to a level-`k` dial in
`plans/FS56-quadratic-167.md` Lemma B2 (§1) and its obligation-pass discharge table (§M2, five numbered sub-obligations).
*Proof verdict:* closes (re-derived here: each of the three field-specific checks is a direct consequence of FS56-T1 plus
standard amenability facts — solvable ⟹ amenable is textbook, and a finite union of translates of a finite congruent set by
a Følner sequence of a group acting by isometries is the standard blow-up construction). *Rests on it:* row 71's whole
content — FS56-T3 (`χ_f(K²) = 4`), the CRT-consistency check FS56-T3's corollary, and FS56-T5 below (the "hard limit" cap,
which uses the SAME field-internal machinery from the other direction). *Prior art:* the mathematical content — the blow-up
construction, the Følner-sequence averaging, the compactness closing argument — is `[MatolcsiEtAl2025]` (MRVZ) Theorem 1,
already held and read in full. **Ours:** noticing and proving that the *whole argument stays inside `F`* — nowhere does the
published proof need to leave the field its input graph lives in, once the isometry group is checked to be field-rational
(FS56-T1) — which turns a bound on `χ_f(ℝ²)` into a bound on `χ_f(F²)` for any number field `F`, the first non-residue,
non-additive lower-bound instrument this project holds. zbMATH: `ab:"amenable" & ab:"Følner" & ab:"fractional chromatic"`
not run (the amenability/Følner mechanism is textbook and MRVZ's own; the *field-internal* reading is this project's own
recognition, not separately searchable); `ab:"geometric fractional chromatic number" & ab:"number field"` — not run (the
milestone's own gate, §PA below, already searched this exact question in two disciplines and found nothing). *Kernel:*
declined — "a formal B2 would need amenability and Følner sequences for countable solvable groups" (`plans/FS56-field-blowup.md`
§ "Dependencies, stated plainly"), infrastructure not held and not currently planned.

**FS56-T3 — `χ_f(K²) = 4`, and the finitary independence ratio of `K²` is exactly 1/4. [hand + cert; the FS-56 implementer, 2026-09-16, with MatolcsiEtAl2025's witness]** For `K = ℚ(√3,√11)`: `χ_f(K²) = 4`, and every finite unit-distance graph
`G ⊂ K²` has independence ratio `α(G)/|G| ≥ 1/4`, with ratios arbitrarily close to `1/4` attained by finite subgraphs.
*The argument:* MRVZ's `G27` (their Definition 2, Moser coefficients in `ℤ⁴`) lies in `K²`; their Theorem 3 gives
`χ_gf(G27) = 4` from a computer-verified rational dual witness. By FS56-T2, `χ_f(K²) ≥ sup_G χ_f(G) ≥ 4`. By Theorem B
(`chromaticNumber_seamPlane`, kernel), `χ_f(K²) ≤ χ(K²) = 4`. For the independence ratio's other direction: MRVZ's Theorem 2
bounds `χ_f(G) ≤ 1/α₁` where `α₁` is the infimum of independence ratios over finite subgraphs, using an independent set of a
large cube in the lattice spanned by `G`'s vertices — a lattice inside `K²` — so the infimum over finite `G ⊂ K²` is exactly
`1/4`. *Proof:* `plans/FS56-field-blowup.md` §"B3 — the corollary" and the paragraph "Independence ratio"; restated as
Corollary B3 in `plans/FS56-quadratic-167.md` §1 with the explicit connection to `[CranstonRabern2015]`'s first question
("What is the fractional chromatic number of `ℚ(√3,√11) × ℚ(√3,√11)`?", bracketed `76/21 ≤ · ≤ 4` before this milestone).
**Re-verified, not taken on trust**: `tools/fs56_gf_check.py` recomputes `G27`'s 49 unit edges from exact field arithmetic,
decides all 16,855 congruences by its own isometry test (not MRVZ's published witness's pairing), enumerates all 182,304
independent sets, and CERTIFIES `χ_gf(G27) ≥ 4` in 12 s (`data/fs56/g27/check-g27.log`); five planted faults each fired for
their designed reason, and a relabelled faithful twin passed (`data/fs56/g27/controls-g27.json`). *Proof verdict:* closes.
*Rests on it:* answers `[CranstonRabern2015]`'s conclusion's first question (`CLOSED-QUESTIONS.md` §1.6); FS56-T5's cap
(the same value 4.36 caps `χ_f` from above, so `χ_f(K²) = 4` is between the field-blow-up floor and the additive/residue
ceiling); `data/fs56/g27/`. *Prior art:* **partly** — MRVZ's Theorem 3 and the rational dual witness for `χ_gf(G27) ≥ 4` are
`[MatolcsiEtAl2025]`'s (bit.ly/fcn-4); Theorem B (`χ(K²) = 4`, the matching upper bound) is this project's kernel result,
itself re-establishing `[Fischer1994]`'s 1994 value (row 57). **Ours:** the value `χ_f(K²) = 4` and the independence-ratio
statement, which needed both halves joined through FS56-T2's field-internal blow-up — neither paper states it, and
`[CranstonRabern2015]`'s question was open. zbMATH: `ab:"fractional chromatic number" & ab:"unit distance graph"` (4 hits,
already checked — none states `χ_f` of a field plane); the milestone's own gate (§PA below) ran a citation search on
`[CranstonRabern2015]` itself (11 Semantic Scholar / 8 OpenAlex citing records) and found none addressing a field plane.
*Kernel:* declined — no fractional-chromatic-number infrastructure exists in `Proofs/`; Theorem B itself is already kernel.

**FS56-T4 — The class-sum certificate's weak duality. [hand; the FS-56 implementer, 2026-09-16]** Fix a subfield `F ⊆ ℝ`, a finite `H ⊂ F²`, a level `k`. Let `y_Y` be rational weights on sets `Y ⊆ H`, `1 ≤ |Y| ≤ k`, such that (i) every congruence
class of listed sets with `|Y| ≥ 2` sums to 0, (ii) the singletons sum to `w`, (iii) every independent set `S` of `H` has
`Σ_{Y⊆S} y_Y ≤ 1`. Then `χ_gf(H; k) ≥ w`. *The argument:* for any feasible `γ` (a regular fractional colouring whose aggregate
`γ̄` is constant on congruence classes of size-≤k sets, 1 on singletons): `Σ_S γ(S) ≥ Σ_S γ(S) Σ_{Y⊆S} y_Y` by (iii) and
`γ ≥ 0`; swapping the finite double sum gives `Σ_Y y_Y γ̄(Y)`, and since `γ̄` is constant on each class this is
`Σ_classes γ̄_c Σ_{Y∈c} y_Y`, which by (i)–(ii) equals `w · 1 = w` (only the singleton class survives; every size-≥2 class
contributes `γ̄_c · 0`). *Proof:* `plans/FS56-field-blowup.md` § "The certificate form the checker reads" (the Lemma and
its one-paragraph proof); the same argument generalised to a level-`k` dial and restated as "weak duality of the class-sum
certificate" in `plans/FS56-quadratic-167.md` §M2's obligations table. *Proof verdict:* closes. *Rests on it:* every
CERTIFIED verdict `tools/fs56_gf_check.py` prints (the checker's soundness rests on exactly this lemma); FS56-T3's
re-verification of `χ_gf(G27) ≥ 4`. *Prior art:* ours — a direct weak-duality argument for the specific class-sum
relaxation this project's checker uses; MRVZ's own certificate form is a "row" form (`(4,−y)` rows against a distinguished
vertex), which the milestone's own text notes "converts mechanically" to this symmetric class-sum form — the symmetric
form and its duality proof are this project's. zbMATH not separately queried (an elementary LP-duality argument, entirely
internal to the checker's own design). *Kernel:* declined — no consumer beyond the standard-library checker itself.

**FS56-T5 — The hard limit for every fractional route: the cap on `χ_f(F²)`. [hand; the FS-56 implementer, 2026-09-16]** For a subfield `F ⊆ ℝ`: `χ_f(F²) ≤ min(4.36, χ_f(target) at every usable place of F)`. Consequently a finite `H ⊂ F²` can
certify four colours via FS56-T2 only if every usable place of `F` has `χ_f(target) > 3` — which fails exactly at a usable
`𝔽₃` residue plane (`χ_f(Γ₃) = 3`) or a dyadic place ramified in `F(i)/F` (`χ_f = 2`). For `ℚ(√167)` the cap is `4.36` (its
usable places' `χ_f` are all `≥ χ_f(Γ₂₃) ≈ 5.03`); for `ℚ(√11)` and `ℚ(√23)` the cap is `χ_f(Γ₇) = 49/14 = 3.5` (`α(Γ₇) = 14`
exactly) — still above the 3-colour threshold. *The argument:* a residue homomorphism `F² → target` pulls a fractional colouring
of the target back to one of `F²` of the same weight, so `χ_f(F²) ≤ χ_f(target)` at every usable place; separately,
restricting Croft's measurable colouring of `ℝ²` (`[MatolcsiEtAl2025]` (1)) bounds `χ_f(F²) ≤ χ_f(ℝ²) ≤ 4.36`. A finite `H`
with `χ_gf(H;k) > 3` would, by FS56-T2, give `χ_f(F²) > 3`, contradicting any usable-place cap at or below 3. *Proof:*
`plans/FS56-quadratic-167.md` §2 "The hard limit, for every fractional route [theorem]" (lines 103–107), with the specific
values for `ℚ(√167)`, `ℚ(√11)`, `ℚ(√23)` computed there from the row-52 finite-plane bound and `α(Γ₇) = 14` (row 60's
exact value). *Proof verdict:* closes. *Rests on it:* row 71's "the route's cap (3 at `𝔽₃`, 3.5 at `𝔽₇`, 4.36)"; the
negative finding that FS-56's own search (Q1, below) could not exceed the cap at small height, consistent with but not
implied by this theorem; FS-58's registered side target at `ℚ(√11)`/`ℚ(√23)` (a narrower window, `3 < χ_f ≤ 3.5`, than
`ℚ(√167)`'s `3 < χ_f ≤ 4.36`). *Prior art:* the pull-back fact (a residue homomorphism bounds `χ_f` the same way it bounds
`χ`) is a direct consequence of row 52's finite-plane bound (`colorable_of_residue`, kernel) applied to fractional
colourings instead of ordinary ones — not separately published; the numerical cap `4.36` is `[MatolcsiEtAl2025]`'s own
measurable bound on `χ_f(ℝ²)`. zbMATH not separately queried (a direct consequence of this project's own kernel theorem
plus MRVZ's published numerical constant; not itself a claim with independent existence to search for). *Kernel:* declined
— would restate row 52's `colorable_of_residue` for fractional colourings, infrastructure not held.

**FS56-T6 — `[DuczVarga2026]`'s augmentation must leave `K`. [hand; the FS-56 implementer, 2026-09-16, a consistency check]** `[DuczVarga2026]`'s `G29 = G27 ∪ {p, q}` has `χ_gf(G29) > 4.0007`; by FS56-T2, no field containing `G29` can have a
four-colourable plane. `G29`'s two new points involve `√5` and `η = i√((415 + 79√33)/8)`, both outside `K = ℚ(√3,√11)` —
consistent with Theorem B (`χ(K²) = 4`), and corrects `BIBLIOGRAPHY.md`'s prior row, which had said the augmentation stays
"inside the Moser lattice". *Proof:* `plans/FS56-field-blowup.md` § "B4 — a consistency check against `[DuczVarga2026]`"
(three lines, the field-membership computation on the new points' coordinates). *Proof verdict:* closes. *Rests on it:*
nothing further rests on it beyond the bibliography correction it forces; it is a check that FS56-T2 and Theorem B agree
(a negative control on the machinery, not a new bound). *Prior art:* the object `G29` and the value `χ_gf(G29) > 4.0007`
are `[DuczVarga2026]`'s; **ours** is checking where its two new points live and that this is consistent with Theorem B —
the check itself, not a result `[DuczVarga2026]` states or needs. zbMATH not queried (an internal consistency check between
two already-held results, not a claim with independent literature to search). *Kernel:* declined — no consumer; the
correction is bibliographic (`BIBLIOGRAPHY.md`'s `[DuczVarga2026]` row), not mathematical infrastructure.

**FS56-T7 — The checker's soundness obligations: congruence grouping, branch-and-bound exhaustiveness, multiquadratic arithmetic. [hand + tools; the FS-56 implementer, 2026-09-16]** `tools/fs56_gf_check.py`'s three non-trivial internal
obligations each hold: (a) **grouping is sound** — the equal-orientation map test `(z′−a)(y₂−y₁) = (z−y₁)(b−a)` (rotation)
or its conjugate form (reflection) decides congruence exactly, because it is equivalent to the existence of `u ∈ F(i)`,
`uū=1`, with `z′ = uz + t` on every point of `Y`, which by FS56-T1 is exactly when `Y, Y′` are congruent; (b)
**branch-and-bound is exhaustive** — including or excluding each vertex in turn, with the bound "current value plus the
positive weights of sets meeting only undecided vertices" an upper bound on every completion, never prunes a feasible
optimum; (c) **the multiquadratic arithmetic is sound** — square roots of distinct squarefree pairwise-coprime integers are
`ℚ`-linearly independent (Besicovitch), so equality of the integer-vector representation is equality in `F`, and
`√a·√b = (∏_{shared primes} d)·√(∏_{symmetric-difference primes})` for coprime squarefree radicands correctly reduces
products back into the same basis. *Proof:* `plans/FS56-quadratic-167.md` §M2's obligations table, rows "checker: grouping
is sound", "checker: branch-and-bound is exhaustive", "checker: multiquadratic arithmetic" (each with its one-line
argument and its negative control: a homometric pair for (a), agreement with full enumeration on `G27` and random small
graphs for (b), a non-squarefree radicand refused and `(√3·√11)²=33` / `ω₃ω̄₃=1` as spec tests for (c)). *Proof verdict:*
closes (three short, checkable arguments; each has a negative control recorded and, per `plans/FS56-quadratic-167.md` §D,
run — the checker's `--self-test` exercises all three). *Rests on it:* every CERTIFIED verdict of `tools/fs56_gf_check.py`,
hence FS56-T3's re-verification and every future certificate this checker validates (including any future Q1 landing).
*Prior art:* Besicovitch's `ℚ`-independence-of-square-roots theorem is classical (not separately cited by the milestone);
the isometry-test and branch-and-bound design are this project's own, built for this checker. zbMATH not queried (standard
checker-soundness obligations, entirely internal). *Kernel:* declined — a standard-library Python checker's correctness
proof, not a target for formalisation; no stub plans one.

## Readings and measurements that were called theorems

- **The ratio-bound reading (R-C)**: *the ratio bound on pieces `Cay(Λ,W)` can reach above 3 only if no compact place has
  least character mean ≤ −1/2*. Explicitly marked `[reading]` with its own killing test in `plans/FS56-quadratic-167.md` §2
  ("Not a theorem: split places are handled heuristically, and the product form of character means across places is an
  unproved equidistribution statement... Killing test: ℚ(√167) pieces whose ratio bound plateaus at or below 3 under every
  equidistributing choice of `W`"). Not filed — the milestone itself refuses to call it a theorem. Minted as **FS-58 R1**
  at the close.
- **The local character-mean table** (`data/fs56/local-ratios.out`): floating-point readings at each place, labelled a
  reading throughout (`data/fs56/README.md`: "readings (floats); ceilings are theorems" — the *ceilings* are FS56-T5, the
  *means themselves* are not claimed as exact).
- **ℚ(√167)² at small height** (§D, phase D): no triangle or 5-cycle to denominator 10,920, odd girth 7, additive 4/5
  colourings to denominator 5,460, 3-colourable radius-3 balls of 37,681 and 215,409 points — all `[exact]`/`[tools]`
  computations about specific finite pieces, explicitly not extrapolated to a general claim ("Q1 not landed"). Not filed as
  theorems; they are the negative evidence behind the decision not to build the beam search (§D's own verdict).
- **`G27` at levels 1, 2 of the level-`k` programme**: `χ_f = 3.000`, pairs `3.722`, full `4` (certified — this last value
  *is* FS56-T3). The level-1/level-2 readings are calibration measurements (float LP), not separately claimed theorems.

## Conjectures surfaced, not claimed

None with a *gap* proof verdict. **Q1** ("some `H ⊂ ℚ(√167)²` with `χ_gf(H; pairs∪triples) > 3`") was registered as a
prediction (P4, probability 0.35) and is explicitly **not landed** — the milestone's own §D concludes "abandoned before
running, not scored: its informative outcome... predates the decision" — recorded as an open question, carried to FS-58,
never claimed as a theorem here.

## Prior art re-attributed

- FS56-T2, FS56-T3: `[MatolcsiEtAl2025]`'s own Theorems 1–3 remain correctly attributed as the mathematical core; this
  audit confirms, and additionally records that FS56-T2's *field-internal reading* of Theorem 1 (never leaving `F`) is not
  stated anywhere in MRVZ's own paper (confirmed by the milestone's own prior-art gate, §PA below, which searched
  specifically for this and found nothing).
- FS56-T6: corrects `BIBLIOGRAPHY.md`'s `[DuczVarga2026]` row, which said the augmentation "stays inside the Moser
  lattice" — this is `plans/FS56-field-blowup.md`'s own correction, already applied at the milestone's close; confirmed
  here, not newly found.
- The credits already recorded in `plans/FS56-quadratic-167.md` §C are confirmed as read: "`G27`, its congruence list and
  its rational witness are Matolcsi, Ruzsa, Varga and Zsámboki's (bit.ly/fcn-4); the geometric fractional chromatic number
  is Ambrus, Csiszárik, Matolcsi, Varga and Zsámboki's."

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| FS56-T1 | declined — `Isom(ℂ)` classification plus field closure; no consumer beyond FS56-T2 |
| FS56-T2 | declined — amenability and Følner sequences for countable solvable groups not held |
| FS56-T3 | declined — no fractional-chromatic-number infrastructure; Theorem B (its kernel half) already kernel |
| FS56-T4 | declined — an LP-duality fact internal to the standard-library checker |
| FS56-T5 | declined — would restate row 52's `colorable_of_residue` for fractional colourings |
| FS56-T6 | declined — a bibliography correction, not mathematical infrastructure |
| FS56-T7 | declined — standard-library checker correctness, no stub plans a formal version |
