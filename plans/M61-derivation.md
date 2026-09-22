# M61 — the derivation file: the local–global tightness conjecture, opened (ledger row 56)

*Filed 2026-09-22 by FS-71 batch 3c. Read: `plans/M61-local-global-tightness.md` §S1–S6 (the derivations), §R0–R8 (the
results). This is the milestone that names the local bound `L(F)` (`CLAUDE.md` § Notation) and states the tightness
mechanism (G48's "the forcer deletes exactly the local bound it beats"); it also contains one item, the circulant
identification, that is explicitly dated 2026-09-09 and attributed to FS-25 (`plans/FS25-P2.md` §2) — batch 5's
territory, flagged below and not filed here to avoid double-filing.*

## The theorems

**M61-T1 — The local bound `L(F)`, and which primes contribute nothing. [hand; the M61 opening session]** For a real
number field `F`, `L(F) := min` over every prime `𝔭` of `F` at which a residue colouring exists, of that colouring's
colour count: at `𝔭 | 2` with conjugation fixing `𝔭` in `F(i)`, the count is `N(𝔭) ∈ \{2, 4\}` (Theorem B / Fischer's
bipartite case); at `𝔭 | p ≡ 3 (mod 4)` with residue field `𝔽_{p^f}`, `f` **odd**, the count is `χ(UD(𝔽_{p^f}, 2))`.
**Primes with even residue degree, or above `p ≡ 1 (mod 4)`, contribute nothing**: the residue field then contains
`√−1`, so the homomorphism's `u ≠ v` clause fails (the circle degenerates). *Proof:*
`plans/M61-local-global-tightness.md` §S1, first paragraph (the definition and the exclusion argument), citing
M58 §S1 for the odd-`f` reduction. *Proof verdict:* closes. *Rests on it:* G48's whole vocabulary (`L(F)` is used
throughout `CLAUDE.md` from this point on); row 56's headline; the observation (§S1, second paragraph) that
"residue-degree-three planes matter only outside the multiquadratic world" — every field this project holds has
primes of residue degree 1 or 2 only, so `L(F)` for held fields is decided entirely by degree-one primes and the walls
at 2 and 3, and the odd-residue-degree-`≥3` machinery is dormant except for cubic fields (Haugland's). *Prior art:* the
reduction mechanism is R52-T1's / M58-T1's (`[Moorhouse2010]`, `[Manturov2012]`, `[Madore2015]`); the *naming and
organizing* of `L(F)` as a single invariant, with the exclusion of even-degree and split primes stated explicitly, is
this entry's contribution — not found in the held sources (each states the degree-one, odd-`p` reduction but does not
name a "least local bound" invariant or characterize which primes are silent). zbMATH:
`ab:"local bound" & ab:"chromatic number" & ab:"number field"` (0 hits). *Kernel:* declined — an organizing
definition over the already-kernel ring-level reduction (`unitQuadrance.map`); no separate Lean object.

**M61-T2 — The odd-degree face: Weil + Hoffman over `𝔽_q`, `q = p^f`. [hand, a direct generalization of M58-T1; the
M61 opening session]** The Kloosterman-sum spectral identity and the Weil bound extend verbatim from `𝔽_p` to any
finite field `𝔽_q`, `q ≡ 3 (mod 4)`: `χ(UD(𝔽_q, 2)) ≥ 1 + (q+1)/(2√q)`, hence `≥ 6` from `q = 62` — so among cubic
residue fields only `q = 27` (`𝔽_{3^3}`) needs a solver; `q = 343` and above are `≥ 10`-chromatic by the formula alone.
Measured at `q = 27` (`𝔽₃[t]/(t³−t−1)`, 729 vertices, degree 28): four colours refused in 7 s (the solver's claim),
five colours undecided at a 20-million-conflict budget. *Proof:* `plans/M61-local-global-tightness.md` §S1, second
paragraph and its table row; §R1 item 5; §R3, the `UD(𝔽₂₇,2)` row. *Proof verdict:* closes for the general Weil bound
(a direct restatement of M58-T1's argument with `p` replaced by `q`); the specific value at `q = 27` (four refused,
five undecided) is `[tools]`, a solver claim only. *Rests on it:* the sieve's cubic column (§R7 item 4, "a residue
field `𝔽₂₇` above 3 gives no bound below 5"); FS-8 (the Haugland 7-adic check, since his field's cubic subfield sees
`f = 3` at the prime 3 — this entry supplies the exact bound his field would need: `≥ 5` from `q = 27` alone, nothing
tighter without a solver). *Prior art:* the Weil-bound generalization from prime `p` to prime power `q` is the standard
form of Weil's theorem for Kloosterman sums over any finite field, not specific to this project; not separately
attributed since M58-T1's own citation (`[MMST1998]`) already covers finite fields generally. zbMATH: not separately
queried (identical to M58-T1's). *Kernel:* declined — same status as M58-T1 (a float derivation, not formalized); the
`q = 27` solver claim has no kernel form (no `GaloisField 3 3` `decide` support, per the plan's own parenthetical).

**M61-T3 — ϑ = Hoffman on the finite planes, by arc-transitivity: every linear relaxation collapses. [hand, applying
Lovász's theorem; the M61 opening session]** `UD(𝔽_p, 2)` is the Cayley graph of `𝔽_{p²}` on the norm-one subgroup
`μ_{p+1}`, a **generalized Paley graph** `GP(p², p−1)` with automorphism group containing `𝔽_{p²} ⋊ O(2,𝔽_p)`
(order `2p²(p+1)`), transitive on vertices and, since `O(2)` acts transitively on the circle, on arcs. For an
arc-transitive graph, `ϑ(G) = n·(−λ_min)/(λ_max − λ_min)` (`[Lovasz1979]` Thm 9) — the Lovász theta number IS the
Hoffman ratio bound — and since `ϑ(Ḡ) = n/ϑ(G)` for vertex-transitive graphs, the **whole chain
`ω ≤ ϑ(Ḡ) ≤ χ_f ≤ χ` collapses to Hoffman's bound**. Measured (the norm-class LP solved for `ϑ` and Schrijver's `ϑ′`
at eleven primes): equal to Hoffman to `2·10⁻¹⁰` everywhere, so **the first digit (`χ ∈ \{5,6\}` at 23, 31, 43, 47) is
integrality-carried below `p = 59`: no linear relaxation can reach it, only a cardinality refutation of `α` itself
can.** *Proof:* `plans/M61-local-global-tightness.md` §S2 (the recognition of the graphs as generalized Paley graphs
and the theta-collapse argument), §R1 item 2, §R3 (the theta table). *Proof verdict:* closes for the collapse argument
(a direct application of Lovász's theorem once arc-transitivity is recognized); the numerical equality is `[tools]`
(a float LP, `\|ϑ − Hoffman\| ≤ 2·10⁻¹⁰`, not an exact certificate). *Rests on it:* the reading that the finite planes
"reproduce G24's pathology exactly" (`ω` low, every relaxation low, `χ` high) — a cross-reference to the cell family's
own gap law, not a new claim; the observation that closing 23–47 needs a SAT/cardinality question, never a relaxation
(shapes every later FS-53/FS-57/FS-59 approach to the window primes). *Prior art:* `[Lovasz1979]` (Theorem 9) is the
whole mechanism, held and cited; the **recognition** that `UD(𝔽_p,2)` is a generalized Paley graph and arc-transitive,
and the consequent collapse of the whole `ω ≤ ϑ(Ḡ) ≤ χ_f ≤ χ` chain to one number, is this entry's application, not
separately stated in `[Lovasz1979]` or elsewhere held. zbMATH: `ab:"Lovasz theta" & ab:"arc-transitive" & ab:"Hoffman bound"`
(0 hits). *Kernel:* declined — the collapse argument needs Lovász's theorem (not in Mathlib) and the LP is a
float computation; the *counting* bound it feeds (`card ≤ χ·α`) is kernel (`card_le_chromaticNumber_mul_indepNum`),
but no certified `α` refusal exists yet to consume it (§S2, "No instance today").

**M61-T4 — The periodic quotient: `χ_per(p) = χ(C_p)`, the circulant of a null direction. [hand; elementary linear
algebra, the M61 opening session]** A colouring of `𝔽_p²` with nonzero period `d` is constant on the cosets of the
line `ℓ = 𝔽_p·d` (the only order-`p` subgroups of `𝔽_p²` are its lines); it is proper only if `ℓ` misses the unit
circle (a **null line**, `p+1)/2` of them, all one rotation orbit since `μ_{p+1}` acts on directions with stabilizer
`±1`), and then it is exactly a proper colouring of the quotient **circulant** `C_p := Cay(𝔽_p, π(S))`
(`π` the projection along `ℓ`, `|π(S)| = (p+1)/2`, symmetric, `0 ∉ π(S)`). Hence **`χ_per(p) = χ(C_p)`,
`χ(UD(𝔽_p,2)) ≤ χ(C_p)`, and `α(UD(𝔽_p,2)) ≥ p·α(C_p)`** (an independent set of the circulant lifts to a union of
parallel null lines). Measured (`p ≤ 71`): `χ(C_p) = 3, 4, 6, 5, 8, 8, 8, [9,10], [9,10], [9,12], [9,12]` at
`p = 3, 7, 11, 19, 23, 31, 43, 47, 59, 67, 71`; at `p = 11` the plane's own five-chromaticity is carried by **non-periodic**
colourings only (`χ(C_{11}) = 6 > 5`) — the first prime where that happens; the 19-plane's five is periodic and became
a 19-entry kernel certificate. *Proof:* `plans/M61-local-global-tightness.md` §S3 (the derivation, pre-empted at the
top by the 2026-09-09 circulant-identification note — see the flag below), §R1 item 3, §R3 (the periodic-quotient
table). *Proof verdict:* closes for the quotient mechanism and the three consequent inequalities (elementary); the
`χ(C_p)` table values above `p = 19` are `[tools]`, solver claims with the `hi` half (an exhibited, lifted-and-verified
colouring) trusted and the `lo` half not. *Rests on it:* the reading "the periodic upper bound is the finite analogue
of M37's coset colourings… the periodic family is the wrong family from 23 on" (a cross-reference to the plane's own
lattice-colouring pathology, row 34–41); the 19-plane's kernel certificate (`chromaticNumber_finitePlane19_le_five`,
`indepNum_finitePlane19_ge`, via `lines19`). *Prior art:* ours — the reduction of a periodic colouring to a circulant
quotient is elementary linear algebra over `𝔽_p²`, not separately attributed. zbMATH:
`ab:"circulant" & ab:"periodic coloring" & ab:"Euclidean"` (0 hits). *Kernel:* **kernel, the general quotient
mechanism and the 19-instance**: `addCayleyMap`, `colorable_of_addCayleyMap`, `projAlong`,
`unitQuadrance_colorable_of_quotient` (the general theorem); `finitePlane19_colorable_five`,
`chromaticNumber_finitePlane19_le_five`, `lines19_isIndepSet`, `indepNum_finitePlane19_ge` (the 19 instance). This
entry's own derivation prose is therefore largely subsumed by its own kernel form — filed here because the *converse*
half ("a periodic proper colouring of the plane IS a colouring of the circulant", needed to read a solver refusal of
`C_p` as a refusal of every periodic plane-colouring) is explicitly **not** in the kernel (§R6: "the converse of the
periodic quotient… is not in the kernel; it is needed only to READ a solver refusal of the circulant").

**M61-T5 — The mechanism of tightness: a spindle escapes its own sealing prime. [hand, field-level step; ring-level
composition kernel; the M61 opening session]** Over a field `F` sealed at `k` by a usable prime `𝔭` (residue plane
`k`-colourable and pairwise free — `F_𝔭(k) = \{0\}`), a pair forced equal at `k` colours has `𝔭 | d²` (M60); its
spindle adjoins `√(4d² − 1)`, and since `4d² − 1 ≡ −1 (\text{mod } 𝔭)`, **every prime of the spindled field `F′` above
`p` has EVEN residue degree — `p` is no longer usable in `F′`.** So the local bound is attained one level up "because
the forcer's own construction removes exactly the prime that gave the bound it beats — never a coincidence of fields."
Every attained row of the field table is an instance: the Moser spindle (`d² = 3` over `ℚ(√3)`, sealed at 3;
`4·3−1 = 11 ≡ −1 (mod 3)`, and indeed 3 is inert in `ℚ(√11)`); K-fabric's forced pairs at `2, 4, 2√3, 8/3` (all
`𝔭₂`-divisible), whose spindles at `2` and `8/3` adjoin `√15` and `√247` (`15 ≡ −1 (mod 16)`, `247 ≡ 7 (mod 8)`,
breaking the 2-adic wall). **The consequence at the 6-level**: over a field 5-sealed by 11 (Heule's, K(√247), K(√23)),
a five-colour forced pair has `11 | d²`; its spindle adjoins `√(4d² − 1) ∈ \{√43, √131, 5√7, √10, …\}`, each
`≡ √−1 (mod 11)`, so the spindled field is 6-open by construction (11 stays inert, every remaining usable prime `≥ 67`
by M58-T1) — the 6-level question reduces to ONE: *does any 5-sealed field carry a pair forced equal at five colours?*
*Proof:* `plans/M61-local-global-tightness.md` §S5 (the theorem, its proof by valuation, and the 2-adic special case);
§R1 item 1 (the field-level restatement, "in the kernel as `Forces.isEmpty_ringHom_of_spindle_radicand`" — see the
kernel note below); §R7 item 1. *Proof verdict:* closes. *Rests on it:* G48's whole naming (this IS "the tightness
mechanism" G48 is named for — the brief's own question, "is it wholly kernel or does M61's plan carry a hand step?",
answered: a hand step); FS-45/FS-48's design vocabulary ("the forcer's field is predicted by its construction"); row
66's later, stronger closure (the mechanism has *no instance* over any 5-sealed multiquadratic field — this entry is
the mechanism itself, row 66 the theorem that the six-level design target built on it never fires). *Prior art:* ours
— the valuation computation (`4d²−1 ≡ −1 (mod 𝔭)` when `𝔭 | d²`) is elementary, and the field-level consequence
(residue-degree parity) is this project's own reading of it; not found elsewhere. zbMATH:
`ab:"spindle" & ab:"unit distance graph" & ab:"prime"` (0 hits). *Kernel:* **kernel, ring-level composition only**
(`isSquare_neg_one_of_spindle_radicand`, `no_ringHom_of_spindle_radicand`, `Forces.no_hom_of_spindle_radicand`,
`Forces.isEmpty_ringHom_of_spindle_radicand`, all in `LocalGlobal.lean`, instantiated at `p = 11` and `p = 3`); **the
field-level translation — "no ring hom to `ZMod p`" implies "every prime of `F′` above `p` has even residue degree" —
is the hand step, explicitly named as such** (§R2: "It does NOT say the FIELD of the spindled graph has no prime above
`p` of odd residue degree; that is the hand argument"). Declined at the field level; stub-worthy alongside M58-T2/FS-47.

## Readings and measurements that were called theorems

- **The equivariant-colouring symmetry-narrowing findings** (§S4, §R1 item 4, §R3): order-2/3 equivariant 5-colourings
  exist at 11, only the half-turn-with-double-swap survives at 19, and even that is refused at 23 (external cadical,
  1,110 s). These are `[tools]` measurements, correctly not filed as a general theorem — the "reading" that "the
  survivable symmetry narrows with `p` to the half-turn with a colour double-swap" is explicitly a reading (§S4), and
  row 56's own ledger text already correctly grades this "[tools]... no rotationally symmetric 5-colouring of Γ₂₃ —
  solver", per the brief's seed. Not re-filed.
- **The gluing obstruction (§S6, "Derivation (c), notes only")** — explicitly registered as not run (§R6: "Phase C…
  notes only, as registered"). No content to file.
- **P2's second half** ("pairs at distances 3 and 4 have `r = 9, 16 ≢ 1 (mod 11)`, so they are NEVER virtual edges at
  five colours over a sealed field") — this is an *instance* of M60-T2's general hex-shell corollary at `p = 11`,
  already filed there; not a separate theorem.

## Conjectures surfaced, not claimed

- **The field-level statement recurs a fourth time** (§R6: "The field-level statement of §S5… stays a hand argument,
  as M58's integrality does") — the same gap as M58/M59/M60's, not re-filed; M61-T5 is exactly the entry that carries
  it here, marked declined at the field level above.

## Flagged, not filed: the circulant identification belongs to batch 5

`plans/M61-local-global-tightness.md` §S3 opens with a blockquote dated **2026-09-09** and headed "THE CIRCULANT IS
IDENTIFIED", explicitly crediting `plans/FS25-P2.md` §2 ("FS-25 item E3") for the exact combinatorial description
`D = \{t : t² − 4ν \text{ is a non-square}\}` of the circulant's connection set, its spectrum as literally half the
plane's (`λ_{C_p}(a) = ½·λ_{UD}(aγ)`), and the consequent reduction of "does the periodic family reach six" to four
finite checks. This is a **later addition folded into M61's file after the fact**, and `plans/FS25-P2.md` is
explicitly assigned to batch 5 (`plans/FS71-theorem-audit.md` §G.2, "Batch 5 — FS-24–FS-38… plans `FS25-P2`…"). This
batch did not open `plans/FS25-P2.md` and does not file this theorem, to avoid duplicating batch 5's work; flagged
here so batch 5's reader knows the same content is folded into M61's plan file as well as its own, and should file it
once, from `FS25-P2.md` (the primary source, per the blockquote's own dating), with a cross-reference added to this
entry.

## Prior art re-attributed

None new. `[Lovasz1979]` was already correctly cited in the plan and in row 56's ledger text (§R0's bibliography line).

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M61-T1 | declined — an organizing definition |
| M61-T2 | declined — float derivation; the `q = 27` value is solver-only, no kernel support for `GaloisField 3 3` |
| M61-T3 | declined — needs Lovász's theorem (not in Mathlib) and a float LP |
| M61-T4 | **kernel** for the general mechanism and the 19-instance; the converse (needed to read a circulant refusal) declined |
| M61-T5 | kernel for the ring-level composition (`Forces.isEmpty_ringHom_of_spindle_radicand`); declined at the field level — stub (FS-47, alongside M58-T2) |
