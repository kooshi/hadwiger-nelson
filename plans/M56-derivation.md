# M56 — the theorem audit (FS-71 batch 3b; ledger row 50)

*Filed 2026-09-22 by the batch-3b implementer. Enumeration: `plans/M56-arithmetic-of-tightness.md` (grepped per
§S.4's discipline; §S1 "The derivations, done" L1–L6 read in full, lines 248–327; §M1 read in full, lines 424–513,
including M1.7's L7 and M1.8's kernel-scope note; §M2.1's proof table read in full, lines 516–530; §R3's witness
table and L8 read in full, lines 756–788; §R4–R6 read in full, lines 790–825; §S2's predictions skimmed for basis
column only); `data/m56/README.md` (in full); `Proofs/HadwigerNelson/Additive.lean` (in full, 123 lines — every
declaration); `LEDGER.md` row 50 and § B; `BIBLIOGRAPHY.md`'s `[Fischer1990]` and `[Fischer1990b]` rows (grepped,
not re-read in full — both are held and already read per their own rows, 2026-09-06 and 2026-09-16). Not read:
`plans/M56-arithmetic-of-tightness.md` §§1–2, 4–9, §B, §S3–S5, §S7 (setup, cost tables, instrument spec, all
prose the plan itself supersedes with §S1/§M1/§R); `tools/additive.py` (its content is in `data/m56/README.md`
per batch 1/2b's repeated finding that a tool docstring restates the plan).*

## The theorems

**M56-T1 — L1, the exponent-divisibility lemma (chunk form). [hand + kernel; the M56 implementer]** Let `X` be a
finite unit-distance graph with points in `F(i)`, `Λ = Λ(X)` the ℤ-span of its unit edge vectors, `φ : Λ → G` a
homomorphism into an abelian group of exponent `e`. Then **`φ(p) = φ(q)` whenever `p − q ∈ e·Λ`** (the base case,
kernel — `addMonoidHom_apply_eq_of_sub_eq_nsmul`, `addMonoidHom_apply_eq_of_sub_eq_exponent_nsmul`), and more
sharply **`φ` vanishes on `Λ ∩ e·Λ₍ₑ₎ = {d ∈ Λ : n·d ∈ eΛ for some n coprime to e}`, and this set equals `eΛ`
exactly** (the localization collapses because `Λ/eΛ` is `e`-torsion and `n` is invertible on it — not kernel, an
`addOrderOf` argument). *Corollary (Fischer's obstruction, chunk form):* if some unit vector `u ∈ k·Λ₍ₖ₎`, `X` has
no additive `k`-colouring. *Proof:* plan §S1 "L1" (lines 250–259); the collapse, §M1.1 (lines 430–433) and
§M2.1's table row "L1, the collapse" (line 521, via `addOrderOf_dvd_iff_nsmul_eq_zero` and `addOrderOf_eq_one_iff`
on the `e`-torsion group `Λ/eΛ`). *Proof verdict:* closes. *Rests on it:* M56-T4, T5, T6, T7 below; M57-T2 (D2);
row 50's "the additive spindle theorem" clause. *Prior art:* the base divisibility identity is textbook group
theory as applied to a chunk's difference lattice; Fischer's obstruction corollary is `[Fischer1990]`'s 1/k ∈ Σ₀
obstruction (Thm 1(ii)/Example 1, already attributed in row 50: "1/5 ∈ Σ₀(ℚ²) for every field ⟹ no plane has an
additive 5-colouring" is this lemma's plane-level instance) — no fresh query run; textbook algebra. *Kernel:*
kernel (`addMonoidHom_apply_eq_of_sub_eq_nsmul`, `addMonoidHom_apply_eq_of_sub_eq_exponent_nsmul`,
`Additive.lean`) for the base case; declined for the localization collapse (plan's own verdict, §M1.8: "NOT a
kernel obligation — the kernel statement is L1 on eΛ directly").

**M56-T2 — L2, the direction of every certificate. [hand + kernel; the M56 implementer, correcting the stub's D1]**
Every additive colouring is a proper colouring (Fischer Thm 1(i)), so with `F_true(X,k)` the pairs forced equal in
every proper `k`-colouring and `F_add(X,k)` the pairs identified by every admissible homomorphism:
**`F_true(X,k) ⊆ F_add(X,k)`, and every additively separated pair is truly separated.** The additive theory
therefore exhibits colourings and separations solver-free and bounds where forcing can live from *one side only*:
**"no admissible hom" proves nothing about `χ(X)`** (a chunk of `ℚ(√167)²` with `1/7 ∈ Λ` has no additive
7-colouring and is 7-colourable) — withdrawing the pre-milestone stub's `certify-not-colorable` clause and its
"an additive prediction contradicted by a complete sweep is a bug" clause (the expected finding is a non-additive
separating colouring, not a bug). *Proof:* plan §S1 "L2" (lines 261–277). *Proof verdict:* closes. *Rests on it:*
every `forced-additively`/`separated-additively` verdict in `data/m56/`, `data/m57/`; M57-T1 (D1, the same fact
lifted to `IsAdditiveOn`/`AdditivelyRigid`). *Prior art:* `[Fischer1990]` Thm 1(i) (an additive colouring is
proper) — already attributed in row 50; the one-sided-certificate reading and the two withdrawn stub clauses are
the M56 implementer's own correction, not previously stated in the literature this project holds; zbMATH:
`ab:"additive coloring" & ab:"unit distance"` (0 hits, 2026-09-22). *Kernel:* kernel (`additiveColoring`,
`not_forces_of_addMonoidHom`, `not_separated_of_addMonoidHom`, `Additive.lean`) — already row 50's citation, filed
here with its full quantified statement per FS-71's shape.

**M56-T3 — L3, the rank. [hand; the M56 implementer]** Every point of the Exoo–Ismailescu seed and of every
descent object has the shape `((a√3 + b√11)/12, (c + d√33)/12)` (`x ∈ √3·ℚ(√33)`, `y ∈ ℚ(√33)`), so `Λ ⊂ ℚ⁴` has
rank `≤ 4` and `Hom(Λ/mΛ, ℤ/m)` has `m⁴` elements (256 at `m = 4`, 625 at `m = 5`); for the classical witnesses
(Heule-510, de Grey's 1581, W) the rank is `≤ 32` and the hom question is a hyperplane-avoidance problem over
`𝔽_p` (`r` variables, one constraint per unit-direction class), enumerable below rank 9 and solved by SAT above.
*Proof:* plan §S1 "L3" (lines 279–285), the coordinate shape citing an earlier item ("T18") of the descent's own
record. *Proof verdict:* closes. *Rests on it:* M56-T4, T5 (the finite enumeration `tools/additive.py` runs on);
M57-T2's rank-dependent enumeration bound. *Prior art:* ours — a chunk-specific coordinate fact about this
project's own objects, not a general theorem; the coordinate shape itself traces to M52-T1's PSLQ verification
(`ℚ(√3,√11)` containment). *Kernel:* declined (a finite-object coordinate fact, no consumer beyond the instrument).

**M56-T4 — L4, what L1 says on the bed. [hand; the M56 implementer]** On `U` (the four-colour fabric, 1,953
points), the M53 rigidity dial's forced-equal classes at 2-adic valuation 2 (`4/3, 4, 12`) and valuation 4
(`16/3, 16`) read FREE (0 of 2,145 and 0 of 179 respectively), while valuation 6 (`64/9, 64/3`) reads forced
(163/178, 8/11). By M56-T1 (L1), a pair at squared distance `4u` with `u` of 2-adic depth `≥ 2` in `Λ` is forced
in **every** additive 4-colouring; since the dial shows valuation-4 classes free, **the 4-colourings separating
them on `U` must be non-additive, and the additive-rigidity conjecture is false on `U`** at that valuation — the
freedom is carried entirely by non-additive colourings. *Proof:* plan §S1 "L4" (lines 287–297); confirmed at the
subplan by §S6's checks (not separately re-read here). *Proof verdict:* closes (conditional on the dial's reading,
which is M53's kernel-adjacent tools-grade measurement, `data/m53/rigidity-dial-it4.json` — not re-verified in
this batch). *Rests on it:* M57-T3 (D3, the Kempe obstruction, whose measured non-rigidity on `U` this predicts);
row 50's standing counterexample (`Additive.lean`'s docstring cites this fabric directly). *Prior art:* ours — a
derivation combining M56-T1 with M53's own measurement; no external analogue. *Kernel:* declined (the conclusion
is a reading off a `tools/`-grade dial, not itself a closed-form statement to kernelize).

**M56-T5 — L5, what L1 says at five. [hand; the M56 implementer]** At `k = 5` the only group is `ℤ/5`, so an
additive 5-colouring of a chunk `X` is `φ : Λ/5Λ ≅ 𝔽₅^r → 𝔽₅` nonzero on every unit class, up to the scalar action
of `𝔽₅ˣ`. For any unit vector `u` and `m ∈ {2,3,4}`: `φ(mu) = m·φ(u) ≠ 0` and `φ(5u) = 0`. **Hence in every
additive 5-colouring, every pair at distance `2u, 3u` or `4u` along a lattice direction `u` is separated, and
every pair at distance `5u` is forced equal.** Instance: the Exoo–Ismailescu seed's forced pair `(205,206)` sits
at distance `5u`; its 446 cheats are `2u`-pairs; M50's 148 absolute virtual edges sit at `3u`/`4u`. *Proof:* plan
§S1 "L5" (lines 299–309). *Proof verdict:* closes. *Rests on it:* M57-T2 (D2's "free classes at k=5" restates this
exactly, generalizing to the "free/forced/mixed" trichotomy at general `k`); the seed's P3′ prediction (M57-R2).
*Prior art:* the mechanism (`φ(mu) = mφ(u)` for `m` coprime to the exponent) is the same textbook fact underlying
M56-T1; Fischer's Example 1 already covers the k=5 obstruction's plane-level form (row 50). *Kernel:* declined
(chunk-specific; a direct corollary of M56-T1's kernel statement at `e = 5`, not separately proved in Lean).

**M56-T6 — L6, Fischer's obstruction as the field-as-input statement. [hand; the M56 implementer]** For the plane
`F²`, `1/k ∈ Σ₀(F²)` kills every additive `k`-colouring, and `Σ₀` is a ring, so `1/2 ∈ Σ₀` kills every
`2ᵃ`-colouring and `1/3` every `3ᵇ·(…)`-colouring, with `1/5 ∈ Σ₀` always. `1/2 ∈ Σ₀(F²)` holds exactly when the
2-adic wall is broken (a unit vector of even denominator) and fails when a conjugation-fixed prime above 2 exists
(`Σ₀` lies in its local ring); likewise `1/3` against the 3-adic wall. **Consequently, over every wall-broken
field this project holds (Heule's, de Grey's, F₂₄₇) the plane has no additive `k`-colouring for any
`k ∈ {2,3,4,5,6,8,9,10,12,…}` — the first open value is 7** — while over `K` itself `1/2 ∉ Σ₀` (the residue
colouring's local ring) and `1/3, 1/5, 1/7 ∈ Σ₀`, so `K²` admits additive colourings only at `k` coprime to 105.
*Proof:* plan §S1 "L6" (lines 311–322). *Proof verdict:* closes. *Rests on it:* M56-T7 (L8, the additive spindle
theorem, which needs the wall-broken fields' `1/2 ∈ Σ₀` half); the standing statement in row 50 ("no 5-chromatic
witness has an additive 4-colouring"). *Prior art:* `[Fischer1990b]` Thm 4 gives the quadratic-field instance
(`1/2 ∈ Σ₀ iff N ≡ 7 (mod 8)`, already `CLAUDE.md` G35's citation) and Thms 1, 3 the multiquadratic/quadratic
prime-inversion machinery this generalizes informally; `Σ₀` being a ring is `[Fischer1990b]` §2–3's "component
lemma" (held, read in full 2026-09-16). This entry's own content — the *multiplicative* consequence ("1/2 kills
every `2ᵃ`-colouring") and its explicit instantiation across the four fields this project holds — is not stated
in either held Fischer paper in this form; zbMATH: `ti:"chromatic number" & ab:"biquadratic"` (0 hits). *Kernel:*
declined (an arithmetic reading of `[Fischer1990b]`'s machinery plus this project's own field census; no Lean
consumer named).

**M56-T7 — L8, the additive spindle theorem. [hand; the M56 implementer, derived after the witnesses were read]**
Let `(c,q)` be a pair forced equal at four colours on K-fabric with `q − c ∈ 4Λ_fabric` (2-adic depth `≥ 2`), and
let `R` be the rotation about `c` with `|Rq − q| = 1` (the spindle). Then the chord vector
`Rq − q = (Rq − Rc) − (q − c)` is a difference of two elements each in `4Λ` (one in the copy's lattice, one in the
fabric's), hence lies in `4Λ` of the union. **Every spindle over an additively-forced pair has its chord in `4Λ`,
so no additive 4-colouring of the union exists.** Confirmed on both spindle witnesses held: de Grey's 1581 (its
unique unit vector in `4Λ` is exactly its single cross edge `(11,802)`, at depth 2) and `W = core ∪ R(core)`
(its unique unit vector in `4Λ` is exactly its spindle chord `(565,1152)`, at depth 3, `8u/3 ∈ 8Λ`). Heule-510
(a SAT-shrinking of de Grey's construction) has lost the `4Λ` chord but not the `2Λ` ones. *Proof:* plan §R3's L8
(lines 765–774), with the witness census (lines 756–763) as its exhibited instances. *Proof verdict:* closes.
*Rests on it:* the standing reading in row 50 ("no 5-chromatic witness has an additive 4-colouring"); M56-T6's
wall-broken-field obstruction (L8's converse direction — the union's field must be wall-broken for the spindle to
exist at all). *Prior art:* ours — a synthesis of M56-T1's divisibility mechanism with G26's spindle mechanism
(kernel, `Instances/HexShell.lean`'s `hexShell_plane`); no external source states the "chord lands in 4Λ"
identity; zbMATH: `ab:"spindle" & ab:"chromatic number"` (5 hits — Soifer/Polymath-adjacent surveys of the
classical Moser spindle, none stating this arithmetic identity) — check owed on the five hits, not opened in this
batch (low priority: general χ ≥ 5 surveys, not additive-colouring papers). *Kernel:* declined (a derivation over
the kernel's `hexShell_plane` mechanism and M56-T1's kernel base case; not itself formalized — no consumer named
beyond this project's own reading).

## Readings and measurements that were called theorems

- **The defect gauge on `W`** (§R3, lines 776–782): 200 SAT-sampled five-colourings carry additive defect
  850–876 of 1,175 (none additive) and residue-per-coset defect 816–880, against a random-baseline estimate of
  `0.73n ≈ 858` — "the sampled colourings carry no detectable additive or residue structure". A measurement on
  one sampled population, not a theorem; consumed by M57's richness/rigidity census (M57-T8).
- **R4's three-sentence summary** (lines 790–802) restates M56-T1 through T7 in prose for a reader; not a
  separate claim.
- **P1′ through P7′** (§S2, lines 329–341): registered predictions, scored in §R6 (lines 818–825+) — process,
  not theorems; the scoring itself is bookkeeping, not filed.

## Conjectures surfaced, not claimed

- **L7 — the spindle rotation is the obstruction, and the fields' additive spectra follow (§M1.7, lines 478–493).**
  A spindle rotation at distance `d` has trace `ρ + ρ̄ = 2 − 1/d² ∈ Σ₀(F²)`, so `1/d² ∈ Σ₀(F²)` for every
  spindle-able distance `d` with `d² ∈ ℚ` — this half is a corollary of M56-T1/T6 and closes. The half that is a
  **conjecture, explicitly NOT claimed as M56's theorem** (the plan's own words, line 491): **`1/p ∈ Σ₀(F²)` iff
  no conjugation-fixed prime of `F(i)` lies above `p`.** One direction (no conjugation-fixed prime ⟹ 1/p ∈ Σ₀) is
  the local-ring argument and closes; the converse was open in M56. **Home of the proof: GPT Astra, 2026-09-14**
  (`CLAUDE.md` G55, "prime inversion" — the general form, every number field, every prime), filed under the
  2026-09-14 derivation file by batch 5, not here (plan §M.2: "the home of a theorem is where it was proved").
  Special cases predate both: `[Fischer1990b]` Thm 1 (multiquadratic `F` at odd unramified `p`) and Thms 3–4
  (every prime of a real quadratic `F`), held and read in full 2026-09-16 — noted in the plan's own text at the
  same line, added retroactively on 2026-09-16. Not a § B line here; batch 5 indexes the proof.

## Prior art re-attributed

None beyond what the plan's own §S1/§M1 text already attributes to `[Fischer1990]` (row 50's existing citation)
and, for L7, to `[Fischer1990b]` (already noted in the plan's own 2026-09-16 addendum, not a new finding of this
batch).

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M56-T1 (L1) | kernel (base case, `Additive.lean`); declined (the localization collapse) |
| M56-T2 (L2) | kernel (`additiveColoring`, `not_forces_of_addMonoidHom`, `not_separated_of_addMonoidHom`) |
| M56-T3 (L3) | declined |
| M56-T4 (L4) | declined |
| M56-T5 (L5) | declined |
| M56-T6 (L6) | declined |
| M56-T7 (L8) | declined |
| L7 (conjecture) | not filed here — proved by GPT Astra, 2026-09-14 (G55); home is batch 5's derivation file |
