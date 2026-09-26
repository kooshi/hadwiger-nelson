# FS-47 — The unit-vector ring in the kernel: prime inversion, the two-colour classification, and the five-level for every wall-broken field (STUB, 2026-09-14; Kooshi: kernel-check every single thing GPT Astra proved)

**Re-aimed at FS-91's close.** The statement is Lemma C/C′ with no Galois hypothesis (row 100; FS91-J07-3, J07-4, J02-L2, J10-L1): `ℤ[U_F] = O′`, the ring integral at the stable primes, except possibly at a ramified stable dyadic place (which occurs at ℚ(√5), ℚ(√17), ℚ(α)); prime inversion is its corollary.

**Re-aimed at M2's close (2026-09-25):** D3, prime inversion, is in the kernel in valuation form, with D5's `3/8 ∈ ℤ[U_{K(√7)}]` and the chain theorem in ring form (`LEDGER.md` row 105): Chevalley's domination replaces lying-over, so no number field is needed. **Left:** the number-field reading — the `σ`-stable valuation subrings of a number field with `p` in the maximal ideal are exactly its conjugation-stable primes above `p` — which is row 57's gap and the one lemma also missing under Theorem A's field form (G35, G43) and under ASTRA T7 beyond `K(√7)` (with FS-37); Lemma R at its corrected scope (the FS-86 re-aim above); D4; D6. Phase B's second inhabitant (`ℚ` at `p = 3`, the 'only if') was not built.

**Re-aimed at FS-86's close (2026-09-25):** B1's Lemma R (`ℤ[U_F]` = elements integral at every stable prime) is the natural target, **at its corrected scope**: no stable prime ramified in `F(i)/F` (FS86-CL2; it fails at ℚ(√5), ℚ(√17)).

*Read beside: `reference/ChatGPT-local-global-tightness-conjecture/local-global-further-results.md` §§1, 2, 6 (Lemma 1.1,
Theorems 1.2, 2.1, 6.1, Corollary 6.2) and `VERIFICATION.md` rows 1–3, 7; `plans/STUB-chain-theorem.md` (FS-45, the chain lemma
and its instances, which this stub's Theorem 6.1 consumes); `plans/STUB-field-level-criteria.md` (FS-37, whose residue-degree
machinery Corollary 6.2 needs); `Proofs/HadwigerNelson/ResidueColouring.lean` (`normOne_subset_valuationSubring`: the "only if"
direction of prime inversion is already there in valuation form), `TwoColourResidue.lean` (row 63, the two-colour mechanism),
`SquareClass.lean` (`planeOver`, the 2-adic square-class calculus); `CLAUDE.md` G35, G41, G55, row 57 (Theorem A's own gap).*

**Credit.** Lemma 1.1 and Theorems 1.2, 2.1, 6.1 and Corollary 6.2 are **GPT Astra's** (OpenAI, 2026-09-14). The "only if" of
Theorem 1.2 is M56's local-ring argument; the statement was M56 §M1.7 L7's conjecture, written 2026-09-06 and never stubbed.
**Prior art, found 2026-09-16 (`[Fischer1990b]`, read in full):** Fischer proved Theorem 1.2 for multiquadratic fields at odd
unramified primes (his Theorem 1, both directions, the "if" by a sum of two unit vectors; Lemma 1 is the integrality), for every
prime of a real quadratic field (Theorems 3 and 4: 1/2 ∈ Σ₀ iff N ≡ 7 mod 8), and gave the whole ring for real quadratic fields
in closed form (Theorem 5). GPT Astra's statement for every number field and every prime, through lying-over, is the general
form; the credit line names both, and Fischer's Theorem 5 supplies ready-made quadratic inhabitants (`ℚ(√5)`, `ℚ(√7)`).

## 1. Mission context, in plain language

Let `F ⊂ ℝ` be a number field, `E = F(i)`, `U` its unit vectors (`u ū = 1`) and `R = ℤ[U]` the ring they generate — which is
also their additive span, because `U` is closed under products (M56's `Σ₀`; Fischer's unit-vector lattice). Three theorems of the
advisor's are about `R` alone, and each is a hand proof the record now relies on (G55):

- **Lemma 1.1 / Theorem 1.2 (prime inversion).** A maximal ideal of `R` containing a rational prime `p` is the kernel of
  reduction at a conjugation-stable prime `P` of `O_E` above `p`, with `R ⊆ O_{E,P}`; hence `1/p ∈ R` **iff** no stable prime
  lies above `p`. So "the 2-adic wall is broken" (G35) **is** "`1/2 ∈ R`", and Fischer's `1/k` obstruction (G41) is decided by
  the primes.
- **Theorem 2.1.** `χ(F²) = 2 ⟺ L(F) = 2` for every real number field: a two-colouring makes walk parity a unital ring
  homomorphism `R → 𝔽₂`, whose kernel Lemma 1.1 lifts to a stable dyadic prime with trivial residue involution, whose residue
  graph is a matching.
- **Theorem 6.1 / Corollary 6.2.** Given a four-colour forcer at distance `8/3` over `K = ℚ(√3,√11)` (M56's, FS-45 certifies
  it): every real `F ⊇ K` with no stable dyadic prime has `1/2 ∈ R`, so `3/8 ∈ R` and the chain theorem gives `χ(F²) ≥ 5`; for
  multiquadratic `F ⊇ K` the stable dyadic residue graph is always `K₄` (ramified is excluded by the unit triangle, residue
  degree two would put `i` into the completion), so `L(F) ≤ 5 ⟹ χ(F²) = L(F)`.

This stub puts all of them in the kernel. The chain theorem itself and its explicit instances are FS-45; the three-colour
classification is FS-46. What is specifically this stub's is the **commutative algebra of `R`** — lying-over into the ring of
integers, the overring-of-a-valuation-ring dichotomy, the parity homomorphism — and the **field-level** statements that Theorem
A's gap (row 57: "that a number field with a conjugation-fixed prime supplies the valuation subring") has kept out of the kernel
until now. It is the same gap seen from the ring `R` rather than from a certificate, and closing it here closes it for FS-37.

## 2. What we know

| fact | trust | where |
|---|---|---|
| unit vectors lie in the valuation subring of a conjugation-fixed prime (the "only if" of 1.2, valuation form) | **kernel** | `normOne_subset_valuationSubring`, row 57 |
| a residue map into a reduced char-2 ring that conjugation fixes two-colours the plane (the "if" of 2.1's mechanism) | **kernel** over an explicit valuation subring; no real-field inhabitant yet | `colorable_two_unitDistance_induce_of_valuationSubring`, row 63; FS-37 |
| Lemma 1.1, Theorems 1.2, 2.1, 6.1, Cor. 6.2 | hand, GPT Astra; read here, sound | `VERIFICATION.md` rows 1–3, 7 |
| lying-over for integral extensions | Mathlib | `Mathlib/RingTheory/Ideal/GoingUp.lean` (`Ideal.exists_ideal_over_*`; check the exact names at opening) |
| valuation subrings: `x ∈ A ∨ x⁻¹ ∈ A` | Mathlib | `ValuationSubring.mem_or_inv_mem` |
| `1/3 ∈ R(K)` explicitly (the Moser twist: `2ρ + 2ρ̄ − 3 = 1/3`) and `1/3 ∈ R(ℚ(√2,√3))`, `R(ℚ(√3,√5))` explicitly (one unit vector each; FS-48) | derived; [C] | M56 L7; `independent_check.py`; FS-48 |

## 3. Derivations first — the kernel shapes

**D1 — the ring.** `unitVectors F : Set ℂ := {z | z ∈ planeOver F ∧ normSq z = 1}`; `unitRing F := Subring.closure (unitVectors F)`;
lemma `unitRing_eq_addSubgroup_closure` (the additive closure is already a ring: `1 ∈ U`, `U · U ⊆ U`). Membership lemmas for
`1/3` over `K` (from `FieldWall.moserTwist`) and over `ℚ(√2,√3)`, `ℚ(√3,√5)` (from FS-48's identities) are the inhabitants.

**D2 — Lemma 1.1.** Statement, at the level Mathlib speaks: for `m` a maximal ideal of `R` with `(p : ℤ) ∈ m`, there is a prime
`P` of `𝓞 E` above `p`, fixed by conjugation, with `R ≤ (valuation subring at P)` and `m = R ⊓ (maximal ideal)`. Proof plan: `B :=
Algebra.adjoin R (𝓞 E)` is integral over `R`; lying-over gives `n`; `P := n.comap (algebraMap (𝓞 E) B)`; the localisation `B_n`
sits between the DVR `(𝓞 E)_P` and `E`, and a subring between a valuation subring and its field is the subring or the field
(from `mem_or_inv_mem`; check whether Mathlib states it — if not, a ten-line lemma); `B_n ≠ E` because `p ∈ n B_n` is a nonzero
non-unit; stability by the `a / ā` argument (`a ∈ P ∖ P̄` gives a unit vector of positive `P`-valuation). The number-field
plumbing — `𝓞 E` as a Dedekind domain, `IsDedekindDomain.HeightOneSpectrum`, the valuation subring at `P` — is where the days go;
a cheaper first form takes the valuation subring `𝒪` and its maximal ideal as **data** (as Theorem A does) and proves
`R ≤ 𝒪 ∧ m = R ⊓ 𝔪` for the `𝒪` lying-over produces, deferring "`𝒪` is the valuation subring of a prime of `𝓞 E`" to FS-37.

**D3 — Theorem 1.2.** `one_div_mem_unitRing_iff : (1/p : ℂ) ∈ unitRing F ↔ ¬ ∃ P stable above p`. The "if" from D2 (`p` not a
unit of `R` ⟹ a maximal ideal ∋ `p` ⟹ a stable prime); the "only if" from `normOne_subset_valuationSubring` (row 57).

**D4 — Theorem 2.1.** `colorable_two_planeOver_iff : (unitDistance ℂ).induce (planeOver F) |>.Colorable 2 ↔ L F = 2`, where the
right side is stated as "there is a stable dyadic prime whose residue involution is trivial" (the residue graph is then a
matching, `Cay(κ, {1})`, and `L = 2`). (⟹): from a two-colouring `c`, `φ r := c r − c 0` in `ZMod 2` is well defined on `R`
outright (no walks), additive because `c (r + u) = c r + 1` on unit steps, multiplicative because `∑ u_i ∑ v_j` has `nm` unit
terms, unital; `ker φ` is maximal with `2 ∈ ker φ`; D2; a nontrivial involution would lift a `b ≠ σ b` to a unit vector `a/ā`
reducing to `b/σ(b) ≠ 1` against `φ(u) = 1`. (⟸): row 63's `colorable_two_unitDistance_induce_of_valuationSubring` — its
real-field inhabitant is FS-37's item, and this stub supplies it for the fields where D2 lands.

**D5 — Theorem 6.1, general form.** `five_le_chromaticNumber_planeOver_of_one_half_mem (hK : seamField ≤ F)
(h : (1/2 : ℂ) ∈ unitRing F) (hG : Forces core 4 a b)` from FS-45's chain lemma with `δ = 8/3`, `3/8 = 3 · (1/2)^3 ∈ R` (ring
closure), and a representation of `3/8` as a *finite* sum of unit vectors — which membership in `Subring.closure` provides
noncomputably (`Subring.closure_induction`) but the chain construction needs explicitly: state the lemma with the sum as data
(`u : Fin m → ℂ`, `∑ u = 3/8`, `‖u j‖ = 1`), and derive the `1/2 ∈ R` form by `closure_induction` into an existential. Then
`five_le_chromaticNumber_planeOver_of_wallBroken` composes D3 (no stable dyadic prime ⟹ `1/2 ∈ R`).

**D6 — Corollary 6.2.** For multiquadratic `F ⊇ K`: the dyadic completion has residue degree ≤ 2; ramified contradicts the
unit triangle; residue degree 2 contains `√−3`, with `√3` gives `i`, so the prime splits — FS-37's square-class calculus
(`SquareClass.lean`) is the right home; this stub states the corollary and leaves the completion arithmetic to FS-37 unless it
falls out of D2's `𝒪`-as-data form.

## 4. Phases

| phase | what | cost | stop rule / acceptance |
|---|---|---|---|
| PA | `[Fischer1990]` §§1–3 read against D1–D3 (is prime inversion there? Thm 10's `1/k` is the consumer); `[Moorhouse2010]` §7; Mathlib's `GoingUp.lean` and `ValuationSubring` API read at the version pinned | half a day | anything found moves the credit line; the Mathlib names go into the skeleton |
| A | D1 and the inhabitants; D3's "only if" from row 57 | half a day | `unitRing`, `one_third_mem_unitRing_seamField` and the two FS-48 inhabitants `#eval`/`decide`d |
| B | D2 in the `𝒪`-as-data form, then D3 | 3–5 days | `one_div_mem_unitRing_iff` on the standard three axioms; vacuity: `K` at `p = 3` inhabits the "if" (`1/3 ∈ R`), `ℚ` at `p = 3` the "only if" |
| C | D4 | 2 days | `colorable_two_planeOver_iff`; `ℚ(√5)` and `ℚ(√2)` as inhabitants of `L = 2` |
| D | D5, after FS-45 lands | 1 day | `five_le_chromaticNumber_planeOver_of_wallBroken` with `K(√7)` and `K(√5)` as inhabitants |
| E | D6, with FS-37 | FS-37's cost | the multiquadratic five-level as a theorem |
| F | the record: G55's `[hand]` tags rewritten to kernel; row 57's gap sentence rewritten; FS-37 re-scoped | half a day | gates green; `CLAUDE.md` under 150,000 bytes |

## 5. Registered predictions

| id | prediction | if it fails |
|---|---|---|
| P1 | Mathlib's lying-over and valuation-subring API carry D2 without a custom Dedekind-domain development, in the `𝒪`-as-data form | the missing lemma is named and priced; the full form waits on FS-37 |
| P2 | D4's parity homomorphism needs no walk parity at all (the colouring is the function) | a well-definedness obligation appears — then the walk form, with `SimpleGraph.Walk` |
| P3 (hunch) — **LOST 2026-09-16** | prime inversion is not in Fischer or Moorhouse in this form (both state the `1/k` obstruction as a consumer, not the characterisation) | the credit line names the paper — it does: `[Fischer1990b]` Thm 1 (multiquadratic, odd unramified p) and Thms 3–5 (quadratic). The hunch checked `[Fischer1990]` and not his second 1990 paper, which sat unread behind an interlibrary loan |

## 6. Failure and jackpot clauses

Failure: D2 does not close in the `𝒪`-as-data form — then Theorem 1.2 stays `[hand]` with the obstruction named, and D4/D5 are
stated with `1/p ∈ R` as an explicit hypothesis (still kernel, one hand step short). No jackpot: the stub is a derivation, and
its consequences stop at five.

## 7. Bearing on 6, honestly

**None; medium as mechanism.** It is the kernel form of the arithmetic that decides which denominators a field's unit vectors
can sum to, which is what decides the walls (G35), the additive obstruction (G41) and — through the chain — the five-level of
the conjecture. It closes, from the ring side, the one hand step every field-level sentence since M58 has carried.

## 8. Addresses

`Proofs/HadwigerNelson/ResidueColouring.lean`, `TwoColourResidue.lean`, `SquareClass.lean`, `FieldWall.lean` (`moserTwist`),
`Copy.lean`/`Homogeneous.lean` (via FS-45); Mathlib `RingTheory/Ideal/GoingUp.lean`, `RingTheory/Valuation/ValuationSubring.lean`,
`NumberTheory/NumberField/Basic.lean`; `reference/ChatGPT-local-global-tightness-conjecture/`; records to `data/fs47/` if any.

## Where the 2026-09-25 work on this lives

*Addresses and titles only, added by the 2026-09-25 crunch's bookkeeper (job J30). The index of that day's work, with its results, is `plans/CRUNCH-2026-09-25-INDEX.md`; a blind verifier does not open it.*

- `plans/M2-kernel-lane.md` §2.2 — the kernel lane's plan on this stub; scratch skeleton `data/m2/j04/K3PrimeInversion.lean`
- `plans/M2-S3K-unit-ring.md` — job J16's record (in progress at this writing); module `Proofs/HadwigerNelson/UnitRing.lean`
- `plans/FS91-S1D-character.md` §2.3–§2.4 — job J07's record: the unit-vector ring's completions (Lemma C, C′)
- `plans/FS91-S0FV-three-colours-blind.md` §2.2 — job J09's record: its localisation lemma J2
- `plans/FS91-S1V-character.md` §3.2 — job J10's record: the blind re-derivation
- `plans/FS91-close-inventory.md` rows 13, 73, 79 — items for this stub, including its re-aim (row 79)

## Where the 2026-09-26 work on this lives

*Pointer block (consolidation job C1, 2026-09-26): addresses only — each result lives in its ledger row and derivation entry; the per-job index is `plans/CRUNCH-2026-09-26-x2x3-INDEX.md`.*

See: `LEDGER.md` row 120 (`plans/FS100-derivation.md` FS100-MR (its hypothesis `R = O′`)); row 123 (`plans/FS100-derivation.md` FS100-EXC).
