# M57 — the theorem audit (FS-71 batch 3b; ledger row 51)

*Filed 2026-09-22 by the batch-3b implementer. Enumeration: `plans/M57-additive-rigidity.md` (grepped per §S.4's
discipline; §S1 "The derivations, done" D1–D5 read in full, lines 211–297; §R0–§R8 read in full, lines 672–843,
including the R2/R3/R4/R5/R7 tables and the R5 addendum on de Grey's dial, lines 844–865; §H's handoff skimmed for
module names only, lines 168–203). `data/m57/README.md` (in full); `Proofs/HadwigerNelson/AdditiveRigid.lean` (in
full, every declaration listed by `rg`); `LEDGER.md` row 51 and § B. Not read: §1–§9, §B (mission/cost setup, the
stub's own pre-subplan text, all superseded by §S1/§R); §M1–§M3 (the modeling passes — the domain/obligation/
experience decisions are process, not new mathematics, and §R0's kernel block already names every surviving
declaration); `tools/additive_rigid.py` (per the batch-1/2b/3b finding that a tool docstring restates the plan;
`data/m57/README.md` already gives the subcommand table).*

## The theorems

**M57-T1 — D1, the reduction theorem. [hand + kernel; the M57 implementer]** On a chunk's vertex set `S` (a finite
subset of a lattice `Λ`), if every proper `k`-colouring is constant on the cosets of some subgroup `H ⊇ k·Λ`
(`IsAdditive`), then for `p, q ∈ S` with `p − q = k·w ∈ H`: `Forces Γ k p q` — hence, via the spindle theorem
(`add_one_le_chromaticNumber_unitDistance_of_additivelyRigid`), a unit-distance drawing with `|p − q| ≥ 1/2` gives
`χ(ℝ²) ≥ k + 1`; the numeral form at `k = 5` is `six_le_chromaticNumber_plane_of_additivelyRigid`. Non-vacuous: the
unit path `(0,0)–(1,0)–(2,0)` is additively 2-rigid, drawn at unit spacing gives `χ(ℝ²) ≥ 3`
(`three_le_chromaticNumber_plane_of_pathGraph`); the hexagon `ℤ/6` at three colours is the red (`0 1 0 1 0 2`
separates `0` from `3 = 3·1`, `cycleGraph_six_not_additivelyRigid`), and `pathGraph_not_additivelyRigid_three`
pins the other direction (at three colours the path's unique-up-to-symmetry colouring is `3·V`-periodic without
being a coset colouring). **What the theorem does not do:** "every colouring is additive" is a universal over all
colourings supplied by an untrusted enumeration; at a jackpot the kernel certificate is the pair's forcing by
refutation, never the additivity census — the module docstring is explicit about this. *Proof:* plan §S1 "D1"
(lines 213–229); the kernel block, §R0 (lines 674–691). *Proof verdict:* closes. *Rests on it:* every
`AdditivelyRigid`/`Forces` reading in `data/m57/`; row 51's own citation. *Prior art:* the reduction (a subgroup's
cosets give a colouring; a difference in `k·H` is forced) is the chunk form of Fischer's additive-colouring
framework (`[Fischer1990]` — already row 50/51's attribution); the spindle composition (`add_one_le_…`) is this
project's own (G26, kernel already). No fresh query — the statement is this project's own reduction over held
prior art. *Kernel:* kernel (`IsAdditive`, `AdditivelyRigid`, `isAdditive_of_addMonoidHom`, `IsAdditive.apply_eq`,
`forces_of_additivelyRigid`, `add_one_le_chromaticNumber_unitDistance_of_additivelyRigid`,
`six_le_chromaticNumber_plane_of_additivelyRigid`, `pathGraph_additivelyRigid`,
`three_le_chromaticNumber_plane_of_pathGraph`, `cycleGraph_six_not_additivelyRigid`,
`pathGraph_not_additivelyRigid_three`, `AdditiveRigid.lean`) — already row 51's citation, filed here with its full
quantified statement and its two reds per FS-71's shape. **Note the plan's own naming (`IsAdditiveOn`,
`additivelyRigidOn`) differs from the shipped declarations (`IsAdditive`, `AdditivelyRigid`); the `On` suffix was
dropped during implementation — confirmed by `rg` against the actual module, not by memory of the plan's prose.**

**M57-T2 — D2, the free classes. [hand; the M57 implementer]** On `A_k = Λ/kΛ` the admissible homomorphisms'
kernels split the nonzero classes three ways: *forced* (in every kernel), *free* (in no kernel — every additive
colouring separates them), *mixed*. At `k = 5` (prime), every `m·u` with `u` a unit class and `m ∈ 𝔽₅ˣ` is free
(`φ(mu) = mφ(u) ≠ 0` for every admissible `φ`) — **this is M56-T5 (L5) restated as a class trichotomy** rather
than a per-pair statement; at `k = 4` freeness is not automatic (`2u` with `φ(u) = 2` in `ℤ/4` vanishes). A free
class is one where a new unit direction or lattice point's edges can be added at zero cost to the additive family;
a mixed class costs some homs but not all. *Proof:* plan §S1 "D2" (lines 231–240). *Proof verdict:* closes.
*Rests on it:* M57-T4 (D4, the richness/sparseness tension); the seed's cheats and M50's distance-3/4 virtual
edges (free by this classification, per plan text). *Prior art:* the `k = 5` half is M56-T5's own restatement
(cross-reference, not independent content); the general forced/free/mixed trichotomy and its k=4 non-automaticity
are this entry's own addition. *Kernel:* declined (a classification used by the instrument, no standalone
consumer).

**M57-T3 — D3, the Kempe obstruction to additive rigidity, exact (G42's gauge characterisation). [hand; the M57
implementer, correcting the pre-subplan stub's mechanism]** Let `c_φ` be an admissible additive colouring,
`a ≠ b` colours, `c = a − b`, `K` a component of the `{a,b}`-subgraph (edges = units `u` with `φ(u) = ±c`; `K`
lies in one coset of `Λ_c^φ = ⟨u : φ(u) = ±c⟩`, M56's Kempe localization, M56 §M1.5). (i) The swap `a ↔ b` on `K`
is a proper colouring. (ii) A colouring is additive iff its same-colour relation is induced by a subgroup, in
particular translation-invariant. (iii) If the `{a,b}`-subgraph has two components `K₁ ≠ K₂` with `p ∈ K₁`,
`p' ∈ K₂` same-coloured, and `S` holds an untouched pair `(r,s)` at the same difference `p' − p` (both outside
`K₁`), the swap on `K₁` separates `p` from `p'` while leaving `r,s` equal — not additive. (iv) **Hence, on a chunk
rich enough to hold such a witness pair: additive `k`-rigidity requires every `{a,b}`-subgraph of every admissible
hom's colouring to be connected** — this is `CLAUDE.md` G42's gauge characterisation, `γ(X,k) = Σ (components − 1)`
over `(hom, colour pair)`, with `γ = 0` iff rigid. Instances (v): no hexagonal ball of radius `≥ 2` is additively
4-rigid (parallel same-colour lines give disconnected subgraphs); K-fabric `U` is not rigid (M56 measured
`Λ_c^φ ⊊ Λ`, 2,321 pairs separated by the sublattice mechanism); at five colours (`ℤ/5`, `c ∈ {±1,±2}`)
connectivity needs the units with `φ(u) ∈ {±c}` to span `Λ` **and** to connect `S` — a per-hom, millisecond
check. *Proof:* plan §S1 "D3" (lines 242–268), correcting the pre-subplan stub's coset-component condition (its
mechanism, not its conclusion). *Proof verdict:* closes. *Rests on it:* M57-T6 (R1's K-fabric non-rigidity
census, an instance of (v)); M57-T8 (R3's witness census); FS70-T2 and FS70-T10 (the Kempe screen, FS-70's
generalisation of this same mechanism to a lattice-wide, not just chunk, statement). *Prior art:* the swap-is-a-
proper-colouring fact (i) is classical Kempe-chain theory, unattributed by name in the plan; the additive-iff-
subgroup-induced characterisation (ii) is `[Fischer1990]`'s own definition, restated; the connectivity necessary
condition (iv) and its gauge `γ` are this project's own (G42 is minted here); zbMATH: `ab:"Kempe chain" &
ab:"connected" & ab:"coloring"` (2 hits, neither opened — general Kempe-chain surveys, not this additive-rigidity
specialisation), `ab:"additive coloring" & ab:"rigid"` (0 hits). *Kernel:* declined — M56 §M1.8 already records
"the Kempe theorem is NOT in kernel scope (a component-swap lemma nobody has written)"; generalised and finally
given a kernel form by FS-70 (FS70-T2, FS70-T10, stub-worthy per that milestone's own decision), not by M57.

**M57-T4 — D4, the richness dial tension. [hand + reading; the M57 implementer]** A chunk loses its `ℤ/5`-homs two
ways: a unit vector enters `5Λ` (M56-T1/T5's obstruction), or the hyperplane cover closes (every functional on
`𝔽₅^r` vanishes on some unit class). For `s` unit classes in general position, **the expected number of surviving
functionals is `5^r·(4/5)^s`**, vanishing past `s ≈ 7.2r` — a probabilistic estimate under a genericity
assumption, not an exact count for a specific object (the plan's own table, R5, measures the real objects against
it: Heule-510, `r = 8`, keeps 96 of an estimate near zero, because its 60 direction classes are far from generic).
The design tension: richness (D4) kills homs while sparseness (D3) leaves disconnected Kempe subgraphs, so the
additive-rigidity principle can only live where a small nonzero family has connected subgraphs. *Proof:* plan §S1
"D4" (lines 270–280). *Proof verdict:* closes for the expectation formula under the stated genericity model;
**the formula's real-object predictions are a reading, not a theorem** (R5 measures the real objects far off the
generic estimate — see § "Readings" below). *Rests on it:* M57-T9 (R5's richness census, which finds the formula
inapplicable to crystalline material). *Prior art:* the expected-surviving-functionals computation is standard
probabilistic combinatorics (a union bound / inclusion-style expectation over random hyperplanes); ours as
applied here; no query run (elementary). *Kernel:* declined.

**M57-T5 — D5, the additive kill census. [hand; the M57 implementer]** A point `p` added to a chunk `X` with unit
neighbours `N(p) ⊆ S` kills a colouring `c` iff `c(N(p))` uses all `k` colours. For an **additive** colouring: if
`p` is in-lattice (`p − p₀ ∈ Λ`), `φ(p − p₀)` is its own colour and no neighbour wears it (`φ(p − y) ≠ 0` for every
unit `p − y ∈ Λ`) — **an in-lattice point never kills an additive colouring by coverage**; it can only kill the
homomorphism itself, by a new unit vector landing in `ker φ`. If `p` is out-of-lattice in a genuinely new
direction, `φ` extends with one free value and survives iff some choice avoids the neighbours' colours (the
ordinary rainbow condition); if `p − p₀ ∈ ℚΛ ∖ Λ`, the extension must satisfy `φ(m(p−p₀)) ∈ m·G` for `m` coprime
to `k`. *Proof:* plan §S1 "D5" (lines 282–296). *Proof verdict:* closes. *Rests on it:* M57-T9 (R4's family-delta
census on `W`'s depth-one cross points, which confirms the theorem's prediction exactly — 65 of 67 in-lattice
points leave the family unchanged). *Prior art:* ours — a case analysis on the extension of a group homomorphism
along a new generator, elementary but not previously stated for this object; no query run (elementary algebra).
*Kernel:* declined.

**M57-T6 — The four-colour bridging bed carries no additively-rigid K-chunk beyond `K₄ − e`. [tools; the M57
implementer]** On the 122-core, the 588-core, the seed's unit part (EI4), and hexagonal balls of radius 2 and 3:
every chunk is Kempe-open under both residue colourings and every `ℤ/4`-type colouring (`γ = 200, 182, 126, 36,
60`), and on the three larger cores the solver's first 2,000 four-colourings sampled are *all* non-additive, at
defects near the random baseline (67–78 of 122; 143–153 of 588; 128–147 of 214). *Proof:* plan §R1 (lines
693–712), the table and its scoring (P1, P1′, P1″, P2). *Proof verdict:* closes (as a tools-grade census over the
five chunks and 2,000-colouring samples named; not a claim about every K-chunk). *Rests on it:* row 51's own
"every unit-distance object held is Kempe-open by orders of magnitude". *Prior art:* ours — an instance of
M57-T3's necessary condition, measured. *Kernel:* declined (a finite census, no closed-form consumer).

**M57-T7 — Exoo–Ismailescu's `G` is exactly additively rigid at five colours, and rigidity is far from necessary for forcing. [tools; the M57 implementer]** On `G`'s `{1,2}`-graph (205 points, 966 unit + 423 distance-2 edges),
the additive family is 18 colourings and `γ = 0`: all 180 `{a,b}`-subgraphs connected, and the complete
enumeration of `G`'s colourings returns exactly those 18, all additive (35 total on `G`'s unit-attachment `H`:
18 additive + 12 at defect 1 + 5 at defect 2). **But rigidity is sufficient, not necessary, for forcing**: of
`M49`'s 19 separating edge-deletion lists, 6 of 19 admit colourings at the random baseline (defect 79–90 of 214)
with no additive structure at all, and the 252-cheat forcing subset (M49's `ddmin` survivors, still forcing
`A = B`) has a colouring space above 5,000 up to palette in three defect regimes (1,701 within 14, 2,167 at
16–28, 576 at 94–105 — the random baseline) — **a forcing subset can keep the forced pair while losing
additivity almost entirely.** *Proof:* plan §R2 (lines 761–784), the P3/P6/P7/P9/P10 scoring. *Proof verdict:*
closes. *Rests on it:* row 51's headline ("only Exoo–Ismailescu's G is rigid, and only with its cheats"); the
"principle names a sufficient condition, not necessary" reading that closes M57's own open question about
whether rigidity is required for a forcer. *Prior art:* ours — the exact census of one held witness's colouring
space; no external analogue (this is the specific object's arithmetic, not a general theorem). *Kernel:* declined
(the census result; `AdditivelyRigid` itself, which `G` happens to satisfy, is kernel per M57-T1).

**M57-T8 — Every 5-chromatic witness held is Kempe-open by orders of magnitude at five colours. [tools; the M57
implementer]** On Heule-510 (96 homs = 24 partitions, complete), `W` (1,728 = 432, complete) and de Grey's 1581
(a 300-hom SAT sample, census on 200): every additive 5-colouring is loose (misses a colour at some neighbourhood)
on 16–24% of its vertices, and every colour pair of every hom is disconnected into 6–72 components — three
orders of magnitude from Kempe-closed. *Proof:* plan §R3 (lines 714–725), the P8 scoring. *Proof verdict:*
closes. *Rests on it:* row 51's headline. *Prior art:* ours, an exact census of three held objects. *Kernel:*
declined.

**M57-T9 — The richness dial: `F₂₄₇`'s thickening kills the additive family before it could close it; de Grey's crystalline closure never dies. [tools + derived; the M57 implementer]** `W`'s 71 depth-one cross points in
`F₂₄₇` all extend the family (67 in-lattice — by M57-T5 (D5), unchanged at 65 of 67; 4 of index 5, killing a third
of the homs); by 63 points (1,238 total) **500 of `W`'s own unit vectors become 5-divisible**, so the family dies
outright — the exact mechanism (M56-T1/L7's obstruction realised at depth one), not the hyperplane-cover heuristic
of M57-T4 as originally registered. By contrast, de Grey's gen-1 half-spindle closure (24,065 points, 358 distinct
directions, rank 32) **keeps at least 300 `ℤ/5`-homs at every radius measured, including the whole closure** — no
unit vector ever enters `5Λ`, because the crystal's direction set (329 within radius 1) grows far slower than its
point count. *Proof:* plan §R4 (lines 727–742), §R5 (lines 785–803), the R5 addendum (lines 844–865). *Proof verdict:* closes. *Rests on it:* row 51; FS70-T4/T5 (FS-70's later classification of which CM fields keep 2-unit
or 5-unit structure, the same mechanism one field over). *Prior art:* ours — an exact finite computation on two
held field constructions. *Kernel:* declined.

## Readings and measurements that were called theorems

- **M57-T4's expected-functional-count formula, applied to real objects**: the plan itself notes Heule-510
  (`r = 8`, 60 direction classes) keeps 96 homs against a generic estimate that would predict near-zero at that
  `s` — the formula is a genericity heuristic, and M57-T9 shows the real objects (crystalline, far from generic)
  systematically violate its prediction in the family's favour. Not filed as a general theorem about real chunks.
- **R6/R8's four-sentence summary** (lines 805–842) restates M57-T1–T9 for a reader; not separate content.
- **P1–P10** (§S2, §M2.3): registered predictions, scored in R6 — process, not theorems.

## Conjectures surfaced, not claimed

None beyond M56's L7 (indexed there; M57 consumes but does not restate it as open).

## Prior art re-attributed

None beyond the plan's own attributions to `[Fischer1990]` (D1's framework, row 50/51's existing citation).

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M57-T1 (D1) | kernel (`AdditiveRigid.lean`, full list above) |
| M57-T2 (D2) | declined |
| M57-T3 (D3 / G42) | declined; generalised in the kernel by FS70-T2/T10 |
| M57-T4 (D4) | declined |
| M57-T5 (D5) | declined |
| M57-T6 (R1 census) | declined |
| M57-T7 (R2, G's exact rigidity) | declined (the census); `AdditivelyRigid` itself is kernel (M57-T1) |
| M57-T8 (R3 census) | declined |
| M57-T9 (R4/R5 census) | declined |
