# M64 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Filed 2026-09-22/23 by the FS-71 batch-4a implementer (the theorem audit, `plans/FS71-theorem-audit.md`). M64 is
"the orbit-filling geometry of a level set" (`plans/M64-orbit-filling-polytope.md`, FS-34, subplanned 2026-09-10),
the milestone that carries `LEDGER.md` row 62's headline result — the orbit-closure theorem — even though the
theorem's first (inequality) form was actually derived inside M64's own §R5 and its corrected (equality) form
inside §R10, crediting the advisor Poros throughout. Enumeration: the whole plan file read in full (766 lines,
§PA–§R10); its two credited Poros advisories (`plans/POROS-2026-09-10-orbit-polytope.md`,
`plans/POROS-2026-09-10-b-closure-equality.md`) grepped for theorem-shaped content not already paraphrased in
M64's own §PA/§0/§R5/§R10 (none found beyond what M64 states in its own voice — the two files' headings and
theorem-labelled paragraphs match M64's account line for line); `data/m62/README.md` read for provenance
(tools-side only); `tools/parts_faces.py` docstring spot-checked (restates the plan, per the standing finding).
Batch 3c flagged `plans/POROS-2026-09-10-b-closure-equality.md` as this batch's file (confirmed, read in full by
batch 3c already; re-confirmed here as identical in content to M64 §R10).*

## The theorems

**M64-T1 — The orbit-closure equality theorem. [hand; the M64 implementer at §R5 (the inequality form and its
attribution to symmetric-IP folklore), sharpened to an equality by the advisor Poros at §R10(a) —
`plans/POROS-2026-09-10-b-closure-equality.md`]** Let `R` be an upward-closed family of subsets of a finite atom
set `A`, and let a group `H` act on `A` (no equivariance with `R`, with any colouring, or with any geometry is
required — `H` need only act on the atoms). Write `cl_H(M) = ⋃_{h∈H} h(M)` for the orbit closure of `M ⊆ A`, and
`min(R)` for the **inclusion-minimal** members of `R` (not the minimum-*size* ones, `{M}`). Then:

> **`M_H := min{ |S| : S ∈ R, S` is `H`-invariant `} = min{ |cl_H(M)| : M ∈ min(R) }`.**

*Proof:* `≤`: for any `M ∈ min(R)`, upward closure gives `cl_H(M) ⊇ M ∈ R`, so `cl_H(M) ∈ R`, and it is
`H`-invariant by construction. `≥`: an `H`-invariant `S ∈ R` contains some inclusion-minimal `M ∈ R` (minimal
within `S` is minimal outright, by upward closure), and `h(M) ⊆ h(S) = S` for every `h ∈ H`, so `cl_H(M) ⊆ S`. ∎
`plans/M64-orbit-filling-polytope.md` §R5 (the weaker one-directional inequality, restricted to `M ∈ {M}` and
`H ≤ Aut(A)`, both hypotheses later found unnecessary) and §R10(a) (the equality, both directions, general `H`
acting on `A`, no equivariance needed). **Direct corollary (§R10(b)), matching `LEDGER.md` row 62's own wording**:
an `H`-invariant selection is a union of `H`-orbits, and it refuses `k` colours iff it hits every minimal
correction set of the base problem (a property of the base, not of the rung) — so **`M_H` is a weighted minimum
hitting set over the `H`-orbits against the correction-set hypergraph `Y`, computable with no colouring ask at
all** once `Y` is on disk (phase A's fix). *Proof verdict:* closes. *Rests on it:* `LEDGER.md` row 62's whole
statement; the complete 16+6-subgroup rung lattice on both M63 level sets, computed in 58 seconds total and
matching all four of §R1's solver-searched values exactly (374/374/375/378 on the L side); the reading of
`[Parts2020a]` §6's *"none of the 376-vertex graphs is an overgraph of any of the 375-vertex graphs"* as one
instance of `min_M |cl_H(M)| > |M_H|` forbidding containment outright — reproduced independently at his own two
vertex counts, 375 and 376, with 0 of 1,302 negative containment tests, in his S-vs-L asymmetry too (S-side
cheapest nontrivial rung costs 8 vertices against L's 1). *Prior art:* the two-line argument is elementary, and
M64's own §R5 says so plainly: "the orbit of a feasible solution generates an invariant feasible solution" is the
combinatorial shadow of the averaging argument the symmetric-integer-programming literature is built on (core
points: `[HerrRehnSchurmann2013]` et al.; orbitopes: `[KaibelPfetsch2008]`; all named at M64's own §PA(b), held
not-read in `BIBLIOGRAPHY.md`). What is ours: identifying this gap as the exact content of `[Parts2020a]`'s own
*overcompression*, turning it into a solver-free upper bound on every rung, and measuring it on the record-holder's
own object. zbMATH: `ab:"orbit" & ab:"invariant" & ab:"feasible solution" & ab:"upward closed"` (0), `ab:"symmetry
gap" & ab:"integer programming" & ab:"covering"` (0). *Kernel:* declined — an elementary four-line lemma about
finite set families; every instance here is solver/computation-grounded rather than proof-grounded, and there is
no consumer that would make a Lean statement of it pay for itself yet.

**M64-T2 — The subgroup-lattice monotonicity theorem. [hand; the M64 implementer, per Poros's §R10(c)]** For
upward-closed `R` and a group acting on the atoms, `H ≤ K` implies `cl_H(M) ⊆ cl_K(M)` for every `M ⊆ A`, hence
`H ↦ M_H` is **monotone non-decreasing on the subgroup lattice, always** (no equivariance hypothesis, and no
dependence on the group order alone — two rungs of different order can be incomparable). *Proof:* immediate from
`cl_H(M) = ⋃_{h∈H} h(M) ⊆ ⋃_{k∈K} k(M) = cl_K(M)` when `H ≤ K`; combined with M64-T1's equality, `M_H ≤ M_K`.
`plans/M64-orbit-filling-polytope.md` §R10(c); verified with **0 violations across all 16 L-side rungs**. *Proof verdict:* closes. *Rests on it:* resolves M62's own apparently non-monotone symmetry ladder (582 vertices at
symmetry rung 1 against 558 at rung 3, `plans/M62-evolutionary-type-m.md` §R23) as a **search** failure rather than
a mathematical anomaly — since rung 1 admits every rung-3 selection, its true minimum is provably `≤ 558`, so
582-at-rung-1 was never optimal; explains why an earlier reading of "+4 at order 4 against +10 at order 3" as
non-monotone was a category error (Klein-four and `C₃` are incomparable subgroups, not points on one chain). *Prior art:* elementary set-containment; folklore once the question is posed on the subgroup lattice rather than ordered
by group order (which is what `[Parts2020a]`'s own §5.4 ladder, `24 → 6 → 3 → 2 → 1`, does — M64 names this as "the
wrong lattice" for his own method, §R10(c)). *Kernel:* declined — a one-line corollary of set containment.

**M64-T3 — The independence complex of the correction-set hypergraph is not a matroid. [tools; the M64
implementer]** For the M63 L-side (402 atoms, complex = droppable sets = the independence complex of the minimal
correction sets `Y`) and S-side stages, the basis-exchange axiom fails: **sampled violations exhibited in 3,296 of
4,000 trials on the L side and 1,029 of 1,128 on the S side** — an exhibited failure of the exchange axiom on a
concrete pair of maximum droppable sets is a decisive refutation (one verified counterexample suffices; the sample
size only measures how common failures are, not whether one exists). Consequently `{M}` is not, in general, the
basis set of a matroid, so `Prof` (its orbit-coordinate profile image) is **not** a linear image of a matroid base
polytope — consistent with, and independent confirmation of, `plans/M64-orbit-filling-polytope.md` §PA(c)'s a
priori argument that `Prof` is merely semilinear (a projection of `{M}`, via Ginsburg–Spanier/Barvinok–Woods) and
was never going to be a polytope's integer points. *Proof:* `plans/M64-orbit-filling-polytope.md` §0(viii): the
droppable sets form a downward-closed independence complex by construction (`S` refuses iff `A∖S` hits no member of
`Y`), and if it were a matroid `{M}` would be its basis set — the basis-exchange axiom (`x ∈ D∖D'` implies some
`y ∈ D'∖D` with `(D∖{x})∪{y}` droppable, for maximum droppable `D, D'`) is checked directly and fails on the
exhibited sample. *Proof verdict:* closes. *Rests on it:* confirms the L side's two convexity-unexplained profile
points (`(5,3,9,7)`, `(5,4,8,7)`, §R2/§R6) are consistent with the correct species rather than a computational
artifact — they are in fact fully explained by `Y` directly (§R6, a [tools] finding, not filed separately here).
*Prior art:* matroid basis-exchange is textbook (Whitney, 1935); the specific object — the independence complex of
a MUS/MCS correction-set hypergraph arising from a graph-colouring critical-subgraph search — has no prior art
found; zbMATH: `ab:"basis exchange" & ab:"independence complex" & ab:"matroid"` (0 for the specific combination
with a correction-set/MCS object), `ab:"minimal correction set" & ab:"matroid"` (0). *Kernel:* declined — a
negative existence result established by an exhibited counterexample on one finite computed object, not a general
theorem.

## Readings and measurements that were called theorems, or that could be mistaken for them

- **§PA's idealness question (C1-upstairs)** — "is `Y` an ideal 0/1 matrix?" is a *recognised question* (Lehman's
  characterisation of minimally non-ideal matrices, `[Lehman1990]`/`[Cornuejols2001]`/`[AbdiBlocking]`, named at
  M64's own gate), left **UNDECIDED** at the close (§R6, P5): the LP relaxation over the *harvested* (necessarily
  incomplete) `Y` reads below the integer optimum on both sides, which is consistent with idealness but does not
  decide it, since a lazy harvest only ever gives a lower bound on the true LP value. Not a theorem either way.
- **§0's two conservation laws** ("the profile set has affine dimension 2, not 4"; the 24-pair perfect matching,
  9-of-15 derived on the S side) — [tools] findings on two specific complete level sets (3,264 and 48 minima,
  exhaustively enumerated), confirmed by 24 solver asks; object-specific, not a general theorem about type-M level
  sets. The mechanism behind them (a correction set of size 2 forces one of a pair) is M64-T1's territory but the
  specific pairs found are data, not a theorem.
- **§0(v)'s convexity findings** ("the S-side convexity test could not fail, by Pick's theorem") — a correct but
  self-acknowledged non-finding (§0(v): "a check run against a criterion that cannot fire measures the criterion,"
  G21); not filed.
- **§0(x)/§R9's profile-map factorisation facts** (the L side factors through the pair-matching, the S side does
  not; the `2,646·1 + 273·2 + 24·3 = 3,264` decomposition; the two orbit-blocks are 6.3%-coupled yet nearly
  profile-independent) — [tools], exact but object-specific enumerations on the two level sets; no general claim
  made or filed.
- **§R1's decisive experiment (375/376/379 vertices at four rungs, 40/1,302/4 minima, containment 40-of-40 /
  0-of-1,302 / 0-of-4)** — the [tools] instance that M64-T1 explains; already correctly recorded in `LEDGER.md`
  row 62 as measured/exact data, not re-filed as a separate theorem here.

## Conjectures surfaced, not claimed

- **§2's C3 (the exchange classes as a termination measure for the expansion step)** — proposed, not established;
  its own falsifier ("the classes are constant across the loop's own recorded moves") is registered but phase F
  (which would test it) was **not run** (§R8). Live target: `plans/FRONTIER-STUBS.md` FS-35 already carries this
  bearing (per the M62-derivation file's cross-reference); no new stub minted here.
- **§2's C1-downstairs / P5 (idealness of `Y`)** stays undecided (see above); the falsifier — a complete, not
  merely harvested, hypergraph — was not built. No stub currently targets closing it specifically; flagged for
  whoever next touches `tools/parts_faces.py`.

## Prior art re-attributed

None beyond what M64's own §PA already recorded correctly in `BIBLIOGRAPHY.md` (the symmetric-IP / core-points /
orbitope literature, Lehman's idealness theorem, the Ginsburg–Spanier/Barvinok–Woods semilinear-projection
theorems — all already marked "not held / named only", with the milestone's own text stating plainly which parts
are theirs and which are the numbers/identification layered on top). The theorems filed above are that layering,
not a restatement of the named background.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M64-T1 | declined — elementary, computation-grounded; no Lean consumer yet |
| M64-T2 | declined — one-line corollary of set containment |
| M64-T3 | declined — a negative result from an exhibited counterexample on one finite computed object |
