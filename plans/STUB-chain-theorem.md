# FS-45 — Chain, don't spindle: the unit-vector ring, the chain theorem, and the conjecture's five-level (STUB, 2026-09-14; minted from GPT Astra's response to the conjecture write-up)

**Re-aimed at M2's close (2026-09-25):** D1–D3 are in the kernel (`LEDGER.md` row 103): the chain theorem over the graph induced on the chain's point set — not a `copyUnion`-style `chainUnion` as §3 D1 proposed, since shared points must be one vertex — in four forms and a ring form (FS-47's `1/δ ∈ ℤ[U_F]`); `χ(ℚ(√2,√3)²) ≥ 4`, with the 18-vertex list's refusal as a second oracle by the gadget algebra (no LRAT); `G4 → χ(K(√7)²) ≥ 5`. **Left:** phase C's certificate — a fresh LRAT of the 588-core's pinned refusal, fed to the kernel as its core (row 67's recipe) — a solver run, so **after the ban (2026-10-01)**, and then the unconditional `K(√7)` bound; `χ(ℚ(√2,√3)²) ≤ 4` by the dyadic residue colouring; G55's vertex bound `m(n − 1) + 1`. The {1, 2}-host consumer stays FS-49's.

*Read beside: `reference/ChatGPT-local-global-tightness-conjecture/local-global-further-results.md` (the proofs, §§1–2, 4–7)
and `VERIFICATION.md` there (our read of each claim, and the two scripts that check the identities); `docs/local-global-tightness.md`
(what was sent, with the definitions of `L(F)` and `R`); `plans/M56-arithmetic-of-tightness.md` §M1.7 L7 (our conjecture
"1/p ∈ Σ₀(F²) iff no conjugation-fixed prime above p", which Theorem 1.2 below proves); `Proofs/HadwigerNelson/Copy.lean`,
`Homogeneous.lean`, `OneDefect.lean` (the kernel pieces the chain lemma is built from); `data/m53/forced-spindle-core-8over3.json`
(the 588-vertex 8/3 forcer, the input the conditional results need); `CLAUDE.md` G35, G41, G48, G55, ledger rows 43, 44, 57, 63, 64.*

**Credit.** Theorems 1.2, 2.1, 4.1, 6.1, Corollary 6.2, the 18-vertex graph and the eight multipliers are **GPT Astra's**
(OpenAI, 2026-09-14, in conversation with Kooshi; `reference/…/local-global-further-results.md`), read here and found sound
(`VERIFICATION.md`). Ours: the conjecture of Theorem 1.2 (M56, one direction proved there), the 8/3 forcer, the spindle
theorem and the transport lemmas the kernel form will stand on.

## 1. Mission context, in plain language

Every lower bound this project holds above two colours came from one move: find two points that every `k`-colouring of some
finite graph paints alike, then rotate a second copy about one of them so the pair sits at distance 1 — the **spindle** — which
forces a `(k+1)`-th colour and adjoins `√(4d² − 1)` to the field. GPT Astra's **Theorem 4.1** generalises the move and, in
doing so, removes the field extension. Let `U` be the unit vectors of `E = F(i)` and `R = ℤ[U]` the ring they generate (M56's
`Σ₀`, the unit-vector lattice, which is already a ring because `U` is closed under products). If a finite graph over `F` forces
two points at difference `δ` equal in every `k`-colouring, then **every `k`-colouring of `F²` is periodic under the ideal `δR`**
(transport the gadget by every isometry `z ↦ t + u(z − a)`; periods add). So if `1/δ ∈ R` — that is, `1/δ = u₁ + ⋯ + u_m` for
unit vectors `u_j` — then `1` is a period, contradicting the edge from `0` to `1`: **`χ(F²) > k`**, with an explicit finite
witness: `m` copies of the gadget chained along the `u_j` (copy `j` placed by `z ↦ s_{j−1} + u_j z`, `s_j = δ(u₁ + ⋯ + u_j)`,
so `s_m = 1`) plus the one closing edge `0 — 1`, at most `m(n − 1) + 1` vertices, all in `F`. The spindle is the case `m = 2`,
which is why the spindle theorem's threshold is `d ≥ 1/2` (row 44) and its field `F(√(4d² − 1))`.

Two things follow, and both bear on the record.

**(i) The primes decide which denominators the unit-vector ring holds.** **Theorem 1.2:** `1/p ∈ R` iff no conjugation-stable
prime of `F(i)` lies above `p`. The "only if" is the valuation argument we hold (a unit vector is integral at a stable prime);
the "if" is new — a maximal ideal of `R` containing `p` lifts, by lying-over through `R·O_E`, to a prime `n` whose contraction
`P` to `O_E` is stable (else `a/ā` for `a ∈ P ∖ P̄` is a unit vector of positive valuation) and whose localisation is exactly
`O_{E,P}`. So **"the 2-adic wall is broken" is exactly "1/2 ∈ R"** — G35's condition in Fischer's language, and M56 L7's
conjecture is proved. **Theorem 2.1** is its two-colour consequence: `χ(F²) = 2 ⟺ L(F) = 2` for **every** real number field
(bipartite ⟹ the parity of a unit-vector walk is a unital ring homomorphism `R → 𝔽₂` ⟹ a stable dyadic prime with trivial
residue involution ⟹ the residue graph is a matching). Row 63's `[hand]` two-colour iff was multiquadratic only.

**(ii) The conjecture's five-level, conditional on one measured object.** Over `K = ℚ(√3,√11)`, M56 measured a pair at distance
`8/3` forced equal by every four-colouring of deep K-fabric (`data/m53/forced-spindle-core-8over3.json`: a 588-vertex,
2,886-edge core, one solver refusal, the pair's spindle giving the 5-chromatic witness of row 47). **Prior art (found by FS-70's
gate, 2026-09-21, read in the held thread text): Jannis Harder, Polymath16 first thread, 28 April 2018 — the same forced pair on
de Grey's `V + V + H`, 745 vertices, spindled at `arccos(119/128)`; and `[Polymath2021]`'s strip forcer (Parts, March 2021,
61,216 vertices). M56's core is a rediscovery, 588 against 745.** Call that input `G₄`. For
any real field `F ⊇ K` with the wall broken, `1/2 ∈ R(F)`, so `3/8 = 3 · (1/2)³ ∈ R(F)`, and Theorem 4.1 with `δ = 8/3` gives
**`χ(F²) ≥ 5`** (Theorem 6.1) — wall-broken is *sufficient* for five over `K`, where the record had it only as necessary
(G35). **Corollary 6.2:** for every real multiquadratic `F ⊇ K` with `L(F) ≤ 5`, `χ(F²) = L(F)` — at 2 such a field's stable
dyadic residue graph is `K₄` (ramified is excluded by the unit triangle, residue degree two would put `i` into the completion),
so `L = 4` is the Moser spindle and `L = 5` is Theorem 6.1 against the bound at 11. **Over `K(√7)` explicitly** (§7):
`w = (−3 + i√7)/4` is a unit vector with `w³ + w̄³ − 3w² − 3w̄² = 3/8`, so **eight** chained copies of the forcer — multipliers
`w³, w̄³, −w², −w², −w², −w̄², −w̄², −w̄²` — plus one edge is a unit-distance graph over the 6-open field `K(√7)` with at most
`8 · 588 − 7 = 4,697` vertices that needs five colours, **by hand given `G₄`**, against the `ρ₆₃` arena's 51,133 vertices by
solver (row 64). It does not touch six: the chain reaches `χ > k` only from a `k`-forcer, and no five-forcer exists over a
sealed field (row 66).

**A third item, on the six-target.** GPT Astra's research note (`six-colour-research-directions.md` §1) states the host
sentence the record had only cheat by cheat (M49–M50): **one** five-colour virtual edge at distance 2, in any field `F ⊇ K`,
transported onto each of the 892 length-2 edges of Exoo–Ismailescu's 426-vertex six-chromatic `{1, 2}`-graph
(`[ExooIsmailescu2019]`), is a six-chromatic unit-distance graph over `F` — one gadget, where row 43's hex-shell host needs a
√3 gadget **and** a distance-2 gadget. Over a 5-sealed field no such gadget exists (row 66: `Separated ↔ Adj`), so its field
must be 6-open; on the `ρ₆₃` arena the ask is already answered, since phase H4's sweep of 1,306,721,748 pairs for virtual edges
includes every pair at squared distance 4: zero. The kernel consumer is blocked on a certificate of the `{1, 2}` graph (row 44:
priced at ~50 M hints and deferred).

## 2. What we know

| fact | trust | where |
|---|---|---|
| Theorem 4.1 (forced pair ⟹ periods `δR`; `1/δ ∈ R ⟹ χ(F²) > k`) and the finite chain | hand, GPT Astra; read here, sound | `local-global-further-results.md` §4; `VERIFICATION.md` row 5 |
| Theorem 1.2 (`1/p ∈ R` iff no stable prime above `p`), Lemma 1.1 (lying-over to a stable prime, `B_n = O_{E,P}`) | hand, GPT Astra; read here, sound; "only if" is ours (M56 L7, the local-ring argument) | §1; `VERIFICATION.md` rows 1–2 |
| Theorem 2.1 (`χ = 2 ⟺ L = 2`, all real number fields) | hand, GPT Astra; read here | §2; `VERIFICATION.md` row 3 |
| the 18-vertex, 33-edge graph over `ℚ(√2,√3)`: not 3-colourable, 4-coloured; 25 of 33 edges critical | **[C]** twice — the advisor's `verify_local_global_extensions.py` (exact `Fraction` arithmetic in the basis `1, √2, √3, √6`) and our `independent_check.py` (sympy radicals, exhaustive search) | `example_qsqrt2_qsqrt3.json` |
| `χ(ℚ(√2,√3)²) = 4`: upper bound at 2 (`ℚ₂(√2,√3)` contains neither `i` nor `√−3`, so `F(i)` is unramified there with residue `𝔽₄`, graph `K₄`) | hand, checked here; the Moser spindle is **not** in this field (no `√11`) — a Moser-free four-chromatic plane | `VERIFICATION.md` row 6 |
| the eight multipliers over `ℚ(√7)(i)`: unit, sum `3/8` | **[C]** twice | both scripts |
| `G₄`: the 8/3 forced pair over `K` | **[S]** one cadical refusal on the 588-core (no proof log on disk); the sweep behind it is M56's (163 of 178 pairs at 8/3 forced) | `data/m53/forced-spindle-core-8over3.json`; M56 §R1 |
| Theorem 6.1, Corollary 6.2, the eight-copy witness | hand, GPT Astra, **conditional on `G₄`**; read here | §§6–7 |
| the Exoo–Ismailescu host sentence | derivation (homogeneity, `Separated.transport`); the arena's distance-2 pairs already swept: 0 | `six-colour-research-directions.md` §1; `plans/M63-phaseH4-sweep.md` |

## 3. Derivations first

**D1 — the chain lemma in the kernel.** Given `G`, `Forces G k a b` (`Arity.lean`), a drawing `q : ι → ℂ` with
`q b − q a = δ`, and `u : Fin m → ℂ` with `‖u j‖ = 1` and `δ * ∑ j, u j = 1`: the union of the copies `z ↦ s_{j−1} + u_j (z − q a)`
(`s_j = δ ∑_{i ≤ j} u_i`) with the edge `(s₀, s_m)` is not `k`-colourable. Pieces we hold: `isometry_affine`,
`transport_pair_of_isometry`, `Forces.transport` (`Homogeneous.lean`); `copyUnion` and `chromaticNumber_copyUnion_le`
(`Copy.lean`, two copies — generalise to a `Fin m`-indexed union `chainUnion`); `not_colorable_of_forced_equal` (`OneDefect.lean`)
for the closing edge. Target statements: `not_colorable_chainUnion` and `add_one_le_chromaticNumber_unitDistance_of_chain`; the
spindle (`spindleRot`, `m = 2`) recovered as a corollary is the consistency check. **Read aloud:** the conclusion is about the
finite union drawn in `ℂ`, and about `planeOver F` only through the copies' coordinates.

**D2 — the 18-vertex instance.** A certificate over `ℚ(√2,√3)`: check first whether `UDCert` (built for the tower
`ℚ(√3,√5,√7,√11)`) admits radicand 2; if not, a direct drawing with `Real.sqrt 2`, `Real.sqrt 3`, the 33 edges by `norm_num`
(non-edges are not needed — the graph is a subgraph), the 3-refusal by `decide` (18 vertices), the 4-colouring by `decide`.
Products: `four_le_chromaticNumber_planeOver (ℚ(√2,√3))` and the first Moser-free four-chromatic unit-distance graph in the
kernel. The upper bound (`= 4`) is FS-37's shape (the field supplies the valuation subring) and is not this stub's.

**D3 — the `K(√7)` witness in the kernel.** Certify `G₄`: the 588-core with the pair pinned unequal, refused at four colours,
as an LRAT replayed by the kernel (M34's pipeline; 588 vertices and 2,886 edges is below the 122-carrier's cost class), giving
`Forces core 4 a b`; then D1 with the eight multipliers gives **`five_le_chromaticNumber_planeOver (K(√7))`** — row 64's
field-level fact in the kernel by a hand-sized argument, and the first kernel-checked five-chromatic object in a 6-open field.
The core's coordinates lie in `K`; the copies are rotated by powers of `w` over `K(√7)`; the drawing's unit edges are exact
identities in the tower `ℚ(√3,√7,√11)`, which `UDCert` already covers.

**D4 — the ring theorems are FS-47's.** Theorems 1.2, 2.1, 6.1 (general form) and Corollary 6.2 are kernel targets of
`plans/STUB-unit-vector-ring-kernel.md` (Kooshi, 2026-09-14: every result the advisor proved is kernel-checked); this stub
supplies the chain lemma they consume and the explicit instances.

**D5 — the host consumer is FS-49's.** `six_le_chromaticNumber_plane_of_separated_two` — from a certificate of the `{1, 2}`
graph and a five-colour `Separated` pair at distance 2, `χ(ℝ²) ≥ 6` — lives in `plans/STUB-distance-two-gadget.md`, together
with the search for the pair; the `Fin m`-indexed union this stub builds (D1) is what it reuses.

## 4. Phases

| phase | what | cost | stop rule / acceptance |
|---|---|---|---|
| PA | the prior-art gate: `[Fischer1990]` (the unit-vector ring and Thm 10 — is Theorem 1.2 there?), `[Moorhouse2010]` §7–8, `[Madore2015]` §3, `[Soifer2024]` ch. 11 (Benda–Perles), for "sum of unit vectors", "monochromatic pair periodic", "chromatic number of the plane over a quadratic field"; whether `χ(ℚ(√2,√3)²)` is on record anywhere (`[AxenovichEtAl2014]`, `[Johnson2006]`) | half a day | anything found goes to `BIBLIOGRAPHY.md` the same day; a prior statement of Theorem 1.2 or 4.1 moves the credit line |
| A | D1 in the kernel | 1–2 days | `not_colorable_chainUnion` with the spindle as a corollary; vacuity: the 18-vertex chain as the inhabitant |
| B | D2 the 18-vertex instance | half a day | `four_le_chromaticNumber_planeOver` for `ℚ(√2,√3)`; `#eval` of the 33 edges |
| C | D3: the pinned refusal of the 588-core as an LRAT; the eight-copy instance | a day (solver minutes; kernel replay at M34's per-cube cost) | `five_le_chromaticNumber_planeOver (K(√7))`; the union's five-colourability asked and verified (P2) |
| D | the record: rows and grokkings rewritten in place; `CLOSED-QUESTIONS.md` only if PA finds the two- or three-colour classification posed; FS-48's chains (`ℚ(√3,√5)` first) ride on phase B's certificate shape | half a day | gates green; `CLAUDE.md` under 150,000 bytes |

## 5. Registered predictions (both outcomes reachable)

| id | prediction | if it fails |
|---|---|---|
| P1 | the 588-core's pinned refusal certifies as an LRAT under 10⁶ lines and replays in the kernel under M34's cost | the certificate is shrunk to its core first (FS-38 K3's recipe), or `G₄` is re-measured on a smaller M56 stage |
| P2 | the eight-copy `K(√7)` object is five-colourable (the chain does not overshoot to six) | a refusal at five colours is a **six-chromatic** unit-distance graph in a 6-open field: HALT AND VERIFY (two encodings, the drawing re-checked exactly) — jackpot, and not expected: each copy is four-colourable and the closing edge adds one constraint |
| P3 | D1 needs no geometry beyond `Copy.lean` and `Homogeneous.lean` | the missing lemma is named and priced before any proof |
| P4 (hunch) | `UDCert` does not admit radicand 2 and D2 is a direct drawing | an afternoon either way |

## 6. Failure and jackpot clauses

Failure: the 588-core refusal does not reproduce — then `G₄` is unsupported, Theorem 6.1 and Corollary 6.2 stay conditional
with the condition unmet, and M56's forced-pair sweep is re-run before anything else. Jackpot: only P2's refusal, which is not
expected. The stub's honest ceiling is a mechanism plus a cheaper five-witness.

## 7. Bearing on 6, honestly

**None directly; medium as mechanism.** The chain theorem replaces the spindle by an ideal-theoretic statement — the forced
differences of `F²` generate an ideal of periods, and the field's primes decide which denominators the unit-vector ring holds —
which is the programme's shape (a derivation with the object as its example). It settles the conjecture's five-level for every
multiquadratic field over `K` given one measured forcer, generalises the two-colour classification to all real number fields,
and puts the first 6-open field's five-digit in the kernel cheaply. What it cannot do is produce a five-forcer, which is the only
input the chain needs to reach six and which rows 66–67 say no sealed field supplies; over a 6-open field the chain is a cheaper
witness generator than the spindle once a five-forced pair exists, and whether one does is FS-43's and FS-44's question.

## 8. Addresses

`reference/ChatGPT-local-global-tightness-conjecture/` (the response, the two scripts, `VERIFICATION.md`); `docs/local-global-tightness.md`;
`Proofs/HadwigerNelson/Copy.lean`, `Homogeneous.lean`, `OneDefect.lean`, `Arity.lean`, `SquareClass.lean` (`planeOver`),
`Instances/CompositumFive.lean` (`chromaticNumber_le_planeOver_of_sevenFree`, the `planeOver` bound pattern); `data/m53/forced-spindle-core-8over3.json`;
`tools/forced_spindle.py`; records to `data/fs45/` with a README row per file.

## Where the 2026-09-25 work on this lives

*Addresses and titles only, added by the 2026-09-25 crunch's bookkeeper (job J30). The index of that day's work, with its results, is `plans/CRUNCH-2026-09-25-INDEX.md`; a blind verifier does not open it.*

- `plans/M2-kernel-lane.md` — the kernel lane's plan (M2)
- `plans/M2-S1K-chain.md` — job J14's record: this stub's theorem and instances in the kernel
- `Proofs/HadwigerNelson/Chain.lean`, `Proofs/HadwigerNelson/Instances/SqrtTwoThree.lean`, `Proofs/HadwigerNelson/Instances/SevenConditional.lean` — the modules
- `data/crunch-2026-09-25/reports/J14.md` — the job report
- `plans/M2-close-inventory.md` rows 18–28, 35 — items for this stub, including its re-aim (row 35)
