# HELD — candidate routes for the FS-85 competition's advisor (final, 2026-09-24)

**Who wrote this, and for whom.** This file was written by the plan-phase advisor (Poros, the plan phase) of milestone FS-85, *can
four-colour rigidity exist without triangles?* The plan is `plans/FS85-rigidity-without-triangles.md`, commit 39ad44b6.

**What the items are.** Each item is a candidate route or reading that I formed while advising the planner and deliberately **did not
send**, so that neither competitor gets a head start.

**How to use them** (the owner's ruling R1 at FS-73, protocol rule 5). Offer them to **both competitors at the same moment**, and only
**after both have written their first route**. Every item is a hunch in the hypothetical mood, with its basis and falsifier. Nothing
here is checked beyond what is stated. Addresses are in `CLAUDE.md` (G-entries), `LEDGER.md` (rows) and `plans/FS79-derivation.md` /
`plans/FS73-derivation.md` (T-numbers).

**Vocabulary.**
- `𝒞^tf₄` is triangle-free Cayley graphs of `ℤ^r` with χ = 4 exactly.
- `𝒰^tf` is the unit-distance lattices of real fields without √3.
- `F` is the forced group at four colours, and `P` its periodic counterpart.

**Order to offer, if they go one at a time:** H6, then H5, H4, H2, H1. H3 is withdrawn.
- **H6 is frame-level.** It narrows which triangle-free fields are still open, using a kernel theorem, and it may go to both
  competitors early.
- **H5 is the route with the most in it.** It names specific fields and a falsifiable prediction.
- **H5 and H6 were written at stand-down.** The planner never saw them, and the plan (commit 39ad44b6) does not reflect them. Its
  P-S2(i) (a "yes" realised in 𝒰^tf, 0.03) and P-arith (0.30) were registered without them.

---

hunch: H5-the-dyadic-tight-target-in-a-triangle-free-field
  claim: The mechanism behind de Grey's rigidity may be 2-adic tightness rather than triangles, and it has a triangle-free analogue.
    - **The mechanism, by G54's reading** (implementer B at FS-73, restated in G54). A full-rank `F` appears where a lattice is
      integral at a prime whose residue target is Hoffman-tight at k, and no other prime's target has a gapped k-colouring. Over K the
      tight target is `K₄ × K₄` (G70).
    - **The analogue.** Take ℚ(√d) with `d ≡ 3 (mod 8)`. The prime above 2 is ramified in ℚ(√d) and inert in ℚ(√d, i), because −d ≡ 5
      (mod 8) makes 2 inert in ℚ(√−d). So its target is `U₂ = Cay(𝔽₄, μ₃) = K₄`. That is the "dyadic bound" giving L = 4 at
      `d ≡ 3 (mod 8)` (`[Fischer1990]` Thm 10(i); G61).
    - **K₄ is Hoffman-tight at four colours**: λ_min = −1 = −3/(4−1). Tightness propagates up an inert tower (G54).
    - **Every unit vector is integral there**, as at every conjugation-fixed prime (for z z̄ = 1, v(z) = v(z̄) forces v(z) = 0). So
      every lattice over the field maps into the dyadic tower.
    - **Choose d so that no other target can supply a gap.**
      - d ≡ 11 (mod 24), so the field needs four colours (row 82).
      - d a non-residue mod 7, so 7 is not usable and Γ₇, which is slack at four colours with gaps, is not a target.
      - Every remaining usable target (11, 19, 23, …) is ≥ 5-chromatic, so it has no four-colourings at all to supply a gap.
        *[Correction, FS-86's close (FS86-A2): ℚ(√59)'s stable odd places are 11, 23, 31, 43, 47, … and the ramified 59; 19 is inert in ℚ(√59). The conclusion (no four-colourable odd target) stands, for the ramified 59 by FS86-V3ram.]*
    - **The smallest such field is ℚ(√59).** 59 ≡ 3 (mod 8), 59 ≡ 11 (mod 24), and 59 ≡ 3 (mod 7), a non-residue. Then ℚ(√83), where
      83 ≡ 6 (mod 7).
    - **ℚ(√11) is excluded.** 11 ≡ 4 (mod 7) is a square, so 7 is usable, Γ₇ has a gapped four-colouring, and row 66 frees every pair
      over ℚ(√11). Consistent with that, FS-73's table found K's other CM subfields loose by a gap at N ∈ {2, 3, 5, 7}.
    - **The lattice must be rich, not just the field.** A lattice built from a subset of the unit vectors can stay integral at a
      non-stable prime and pick up that prime's gapped target. The record has an instance: FS-73's `K|Q(sqrt11,i)|D36` (triangle-free,
      "2-unit: inert(2)") is loose by a gap at **N = 5**, not at 7 (`data/fs73/table/TABLE.md`, line 10).
      - So the candidate lattice must contain `1/p` for every non-stable prime p whose local target four-colours with a gap: 3, 5, 7,
        13, …
      - Such lattices exist by prime inversion (`1/p ∈ ℤ[U_F]` at every non-stable p; G55). The saturated chain `Λ_M` with M divisible
        by those primes is the natural family.
      - What then remains four-colourable is the dyadic tower, plus composite quotients at `N = 2^a·q` with q stable (11, 23, …). Those
        composites are **not** ruled out here; see the falsifier.
    - **G54's reading therefore predicts a non-zero P, full rank at some 2-adic depth, on rich lattices over ℚ(√59)**: triangle-free
      four-colour rigidity in 𝒰^tf.
    - **Where the triangle would then be.** In the target, K₄, not in the lattice (see H4).
    - **It is never chainable.** A forced δ at positive 2-adic valuation is not a unit at the stable dyadic prime (FS79-T2), exactly as over
      K (χ(K²) = 4, Theorem B). So it answers step 2's existence question in 𝒰^tf, and does not touch Soifer 55.1 or five colours.
  basis: analogy
  basis note: derived for the arithmetic (the splitting of 2, K₄'s tightness, integrality at stable primes, the choice of d); the conclusion carries G54's reading from K (K₄ × K₄) to ℚ(√59) (K₄) by analogy, and P ≠ F is possible at four colours
  falsifier: a derivation that the dyadic tower of ℚ(√59), restricted to the unit vectors of some rich lattice, forces nothing at any depth (the row-67-style certificate: four units whose t − 1 span has 2-adic elementary divisors; an exact Smith-normal-form computation, in scope this week); or a gapped four-colouring of some ℚ(√59) lattice from a target this item missed
  registered: 2026-09-24
  status: open
  frame-level part:
    - **What the record's triangle-free null actually covered**, as far as I read rows 78, 81 and 84:
      - the four-colour rigidity screens in triangle-free fields ran in **wall-broken** fields, ℚ(√47) and ℚ(√167), both ≡ 7 (mod 8),
        where every prime above 2 splits in F(i), so there is no dyadic target at all;
      - or they ran in fields with a **usable 7**: FS-73's table of K's other CM subfields, which includes ℚ(√11). There Γ₇'s gap frees
        every pair.
    - **What the null does not cover.** None ran where the dyadic K₄ is the only four-colour target. ℚ(√59), for instance, is certified
      only at three colours (row 74).
    - **Why that matters.** "Every four-colour forced pair known uses a triangle" (G21) measured the fields that were enumerated, which
      are exactly the fields where G54's mechanism cannot run.
    - **Checked.** I listed every four-colour row of FS-73's `data/fs73/table/TABLE.md` without √3 in its field. There are seven.
      - Three are wall-broken: ℚ(√15,i), ℚ(√23,i) and ℚ(√47,i).
      - Three have a ramified dyadic prime: ℚ(√5,i), ℚ(√69,i) and ℚ(√141,i).
      - Exactly one has an inert dyadic prime, the K₄ target: `K|Q(sqrt11,i)|D36`, loose by a gap at N = 5.
      - No row is over ℚ(√59) or ℚ(√83).
      - So the record never asked a rich lattice over a field whose only four-colour target is the dyadic K₄.
    - **Send it early?** The competition advisor may judge this part frame-level and send it to both at once before the first routes
      (protocol rule 6). The owner's call.

hunch: H6-which-triangle-free-fields-are-already-free
  claim: Row 66 / G68 already decide a named part of step 2 on 𝒰^tf: the "no" is free there.
    - **The mechanism.** A homomorphism into a target with a gapped four-colouring frees every pair (`Slack.forces_iff_of_hom`). Every
      unit-distance graph over F maps into the residue target at each conjugation-stable prime.
    - **So F = 0 at four colours for every unit-distance graph over F** whenever some stable prime's target four-colours with a gap:
      - a usable 3 (Γ₃ is 3-colourable, so it four-colours with a gap);
      - a usable 7 (Γ₇ is slack at four colours, gaps found; G54's table);
      - a ramified dyadic prime (χ ≤ 2);
      - probably U₄ (the Clebsch graph, slack at four colours; whether it has a gapped colouring is unchecked).
    - **What is left open in 𝒰^tf** is two arithmetic types, and they are where the competitors' effort belongs:
      - **(A) wall-broken, with no small gapped plane.** ℚ(√47) and ℚ(√167): 47 ≡ 5 and 167 ≡ 6 (mod 7) are non-residues, so 7 is not
        usable. No dyadic target. This is where the chain could give five.
      - **(B) wall-standing with dyadic target U₂ = K₄, which is four-tight, and 7 not usable.** ℚ(√59), ℚ(√83). This is where G54
        predicts rigidity (H5), never chainable.
    - **Frame-level.** This narrows the class the competitors must treat. Consider sending it to both at once early (protocol rule 6),
      so neither spends round 1 proving a "no" that row 66 already gives.
  basis: derived
  basis note: row 66's kernel theorem applied at stable primes; the residue congruences checked by hand for 11, 47, 59, 83, 167 mod 7
  falsifier: a unit-distance graph over a field with a usable 7 carrying a four-colour forced pair (it would refute row 66, or the claim that Γ₇ has a gapped four-colouring)
  registered: 2026-09-24
  status: open

hunch: H4-triangles-in-the-quotient
  claim: If F has finite index, every four-colouring factors through the finite Cayley graph Cay(Λ/F, S mod F). For a sum-free S that quotient can acquire triangles, whenever s₁ + s₂ + s₃ ∈ F for some s₁, s₂, s₃ ∈ S. The sharp sub-question: must the rigid finite quotient of a triangle-free lattice graph contain triangles? "Yes" would locate the triangle in the quotient rather than in the lattice. H5 is an instance of this shape: the residue target K₄.
  basis: prior
  basis note: the finite-quotient form is `F = ⋂ Per(c)`, FS73-T36
  falsifier: a triangle-free lattice graph with finite-index F whose quotient by F is triangle-free
  registered: 2026-09-24
  status: open

hunch: H2-where-the-triangle-enters-step-1
  claim: On the Eisenstein cosets of de Grey's lattice, each unit triangle of a four-colouring misses exactly one colour. That turns a coset's colouring into Moore–Newman's height with a slope (G73: the only edge-local four-colour height lives on sum-closed halves). Hubai's stripes would then be the extreme-slope, frozen states. The 48 non-Eisenstein unit vectors are single-matching couplings between cosets (FS79-T37), and they could pin every coset's slope to the extreme. On this reading the triangle's use is exactly "a coset has a height", and a triangle-free lattice has no coset carrying one, so it needs another pinning mechanism (H5 proposes one: arithmetic, not topological).
  basis: analogy
  basis note: Moore–Newman's height; G73
  falsifier: a four-colouring of de Grey's lattice whose restriction to some Eisenstein coset is not an extreme-slope state (Hubai's description false on the lattice), or a derivation of 8Λ that uses no coset height
  registered: 2026-09-24
  status: open

hunch: H1-entropy-route-to-no
  claim: Step 2's "no" might go through entropy. F ≠ 0 at δ makes every point of the colouring shift δ-periodic, hence of zero topological entropy (the number of patterns on an n-box is at most exp(C·n^{r−1})); this half is now item 5 of the plan's list T, sent to the planner as a necessary condition. The route half is the rest: show that every four-colourable triangle-free S has a four-colouring with a positive-density set of pairwise non-adjacent "gapped" vertices (a vertex whose closed neighbourhood misses a colour), or some other positive-entropy mechanism. G68 (gap ⟹ free) and FS79-T1 (three-colourable ⟹ loose) are the two known instances. Caveat: positive entropy ⟹ F = 0 is sufficient, not necessary; in rank 1 a positive-entropy phase beside a rigid one already gives F = 0 (FS79-T35). And H5 predicts the route fails in 𝒰^tf at ℚ(√59), where G54 makes every colouring gap-free (tight ⟹ gap-free).
  basis: prior
  basis note: the zero-entropy half is derived (two lines); the gap half, which is the route, is prior
  falsifier: a triangle-free four-colourable S whose colouring shift has zero entropy (then the gap route cannot hold for it); H5 landing would be one
  registered: 2026-09-24
  status: open

hunch: H3-arithmetic-tight-target (WITHDRAWN, superseded by H5)
  claim: (as first written) the dyadic target of a triangle-free real quadratic field at d ≡ 3 (mod 8) is U₄ = Cay(𝔽₁₆, μ₅), the Clebsch graph, which is slack at four colours.
  basis: derived
  basis note: the graph identification only
  falsifier: —
  registered: 2026-09-24
  status: killed (by: the splitting of 2. At d ≡ 3 (mod 8) the dyadic prime of ℚ(√d) has norm 2 and is inert in ℚ(√d, i), so the target is U₂ = K₄, which is four-tight, not U₄. The identification U₄ = Clebsch is right, checked in seconds: 16 vertices, 5-regular, no triangles, eigenvalues 5, 1, −3. But U₄ is the target only of fields with a dyadic prime of norm 4 inert in F(i). My error; it was never sent to anyone.)
