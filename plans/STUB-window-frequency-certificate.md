# FS-80 — a window-frequency certificate at four colours, kept small by the symmetry (stub)

**At the 2026-09-26 consolidation (2026-09-26, consolidation job C3b; `LEDGER.md` rows 121, 123).** Five is held at [hand] by measure rigidity at both targets — `χ(ℚ(√47)²) = 5` (row 121) and `χ(ℚ(√167)²) ≥ 5` (row 123) — so a four-colour window-frequency certificate there would restate a held value in a checkable format, not decide it. One colour up it is the shape of a six-certificate, FS-59's question since 2026-09-26. Provisional bearings add: G80.

**J29 (2026-09-25; `plans/FS84-five-colours-47.md`):** ℚ(√47) is a target beside ℚ(√167) — its fractional cap `121/28 > 4`.

**Provisional bearings, updated at the 2026-09-25 crunch's close (M1–M3):** G78 (in rank one the Kempe route cannot see a frozen wall — an averaged certificate is not a Kempe argument, row 108).

> **Re-aimed at FS-85's close (2026-09-24).** On de Grey's lattice a **radius-1** averaged certificate cannot lift `120Λ` to `8Λ`: the 54
> pair-correlation equalities admit a weight supported entirely off the 42 characters (FS85-C14, verified exactly; row 87). Radius ≥ 2
> and joint four-class averaged certificates are untested (a float probe agrees; uncertified). Row 85's proof is **structure-derived and
> pointwise** (a linear identity per family, then a splitting at the tight dyadic quotient; G75) — G73's third format, not the averaged
> one. So at ℚ(√167) price radius ≥ 2 from the start, and read the residue-label test (G73's reading) beside it.

*Minted 2026-09-24 at FS-79's close, from the one obstruction route its competition left open (`LEDGER.md` row 80, G73; the
competition advisor's product-axis reading, close-inventory item 88; `plans/FS79-derivation.md` §6 R3–R4). Rank 3: speculative, and
the only solver-free route to five colours over ℚ(√167) left standing. Written for a session with zero conversation memory.*

## Mission, in plain language

**The target is five colours over ℚ(√167)**: find a lattice of unit vectors over that field whose unit-distance graph cannot be
four-coloured, with a certificate a reader can check. Four is proven (`LEDGER.md` row 79). The local–global conjecture predicts at
least six (`CLAUDE.md` G59).

**How four was proven, and why that tool stops.** At three colours every colouring of a lattice graph has an integer *height* whose
average slope lies in a polytope `Θ₃` computed from the generators; `Θ₃ = ∅` refused three colours on `L21cc6506` with a certificate of
kilobytes, where refuting finite patches were priced near 10⁸ points (row 79, G71, G72). FS-79 asked for the four-colour analogue and
proved that **nothing local in one cell of the colour complex will do** (row 80, G73): edge-local heights exist only on four-colourable
presentations of rank ≤ 2, the loop winding is the graph's parity, parity-free face fluxes are trivial on every triangle-free
unit-distance lattice, and the coindex topological bounds stop at four on every unit-distance graph. Those are no-gos of four named
formats. **Three kinds of certificate are left** (Coxeter's C5, de Bruijn's §5 reading, the advisor's §7): averaged (window
frequencies), non-local (cocycles reading windows of radius ≥ 2) and structure-derived (group ring, counting on a base pattern). This
stub is the first of them.

**What a window-frequency certificate is.** Every four-colouring of a lattice graph carries, for each finite window `W ⊂ Λ`, the
frequencies with which each colouring of `W` appears — the `W`-marginal of an invariant measure on the colouring space (Kind 0_W,
`plans/FS79-invariant-question.md` §IQ item 3). Those frequencies must agree on the overlaps of `W` with its translates; the set of
consistent vectors is a polytope, and its emptiness — a Farkas vector — refuses four colours. **In rank 1 this is exact** (a
circulation on the window-state graph exists iff a colouring does; FS79-T4), and it refutes `G(ℤ,{1,3,7,12,17,22})` where the
fractional chromatic number is 29/8 < 4. FS-73's `Θ₃ = ∅` is itself such a certificate at three colours — an averaged pair statistic
plus the integrality of the winding (Poros's reading, FS79-T4). **The obstacle is size** (§D.4 of the FS-79 plan): a window large
enough to hold a refuting subgraph gives only that subgraph's refutation in LP form, so a certificate earns its place only if its size is
bounded by the presentation and is far below the best plain refutation. What made `Θ₃` small was that it lives on the group of
characters, a space of fixed dimension, and that `L21cc6506`'s unit vectors are five rotations of one rational pattern
(`U = {1, v, v̄, z, z̄}·U_R`, FS73-T40): one pull-back per layer.

## The question

**Is there a window-frequency Farkas certificate of non-four-colourability on some lattice over ℚ(√167) (or on a benchmark with
refutation rank ≥ 2) whose size is controlled by the point group and the multilayer structure — the averaging move of G72 at four
colours?** Sub-questions, cheapest first:
1. **The advisor's residue-label reading first** (FS79 §6 R3; unchecked): the product of any invariant measure with Haar measure on the
   𝔭-adic odometer is a consistent joint, so residue labels add nothing to a window programme. Check the derivation; its killing test is
   a residue-labelled window LP that refutes where the unlabelled one of the same window does not.
2. **A rank-≥ 2 benchmark** (FS-79's (Q-obs) required refutation rank `ρ₄ ≥ 2`, FS79-T7): the plan knew none with a certified
   `χ_f ≤ 4` and `χ = 5` beyond products with rank-1 graphs; a general-position `S` gives `ρ₄ ≥ 2` for free, so every five-chromatic
   unit-distance lattice (Heule-510's, over K(√5)) qualifies once a `χ_f ≤ 4` certificate exists — find one, or work on "refuted by
   no colour-class density".
3. **Symmetry-reduced window LPs** on ℚ(√167)'s survivors (row 81; phase 0's seven minimal survivors and whatever P3b leaves), with
   the point group (multiplication by `i`, conjugation and the Galois flip, which permute `L21cc6506`'s unit vectors, P3) and the layer
   structure used to reduce the programme — the Sherali–Adams hierarchy on the group, in the discipline's words.
4. **Beside it** (each could be its own stub if it grows): cocycles reading windows of radius ≥ 2 (`[CGHO2025coh]` Thm 5.8: a dense
   finite-difference class, strip gluing and one mixing direction make every continuous cocycle trivial at every radius — the gluing
   lemma for `Cay(Λ, S)` is the work, and it fails where the colouring space is rigid); the **index** topological bounds
   `ind(B₀) + 1`, `ind(H) + 2`, which `[SimonyiTardos2006]`'s Zig-zag Theorem does not constrain (FS79-T26); algebraic certificates in
   `ℤ[Λ]` (FS-10).

## Outcomes (each reachable)

- **(a)** a certificate of this kind refusing four colours on a named lattice, with a standalone checker — on a ℚ(√167) lattice it is
  `χ(ℚ(√167)²) ≥ 5`, the conjecture's next level at its cheapest exposed prediction;
- **(b)** a size no-go: window certificates on a named family grow with the smallest refuting subgraph — then five at ℚ(√167) is
  arithmetic's (FS-59) or a non-local certificate's;
- **(c)** not landed, typed: the residue-label reading decided either way; a benchmark found or not; the LP sizes measured.

## What is known (pointers)

`LEDGER.md` rows 79–81; `plans/FS79-derivation.md` T3–T7, T17–T30, §6; `plans/FS79-invariant-question.md` §IQ, §D.3–§D.4, §C.4
(the acceptance criteria per face, reusable); `plans/FS79-C-Coxeter.md` C5; `plans/FS79-C-deBruijn.md` §5;
`plans/POROS-2026-09-23-fs79-plan.md` §5.4 (the exactness argument and its size caveat); `data/fs79/checks/` (the rank-1 laboratory:
window-state graphs, the benchmarks).

## Provisional bearings (WORKFLOW step 2)

G73 (what is left, and the looseness instrument), G72 (the averaging move; this is its four-colour form), G60 (what `χ_f` caps and what
it does not), G71 (the three-colour certificate this imitates), G62/G7 (the multilayer), G65 (the plain refutation's price, which the
certificate must beat), G21 (a size claim measures the family it was measured on), G51 (a competition fits: two routes, window LPs and
radius-2 cocycles). Kernel: FS-75 is the model of a certificate type with a soundness theorem.

## Bearing on χ ≥ 6

None directly; speculative and high on the programme: a four-colour certificate that scales with the symmetry is the first solver-free
route to five on lattices whose refuting patches are out of a solver's reach, and one colour up it is the shape of a six-certificate.
