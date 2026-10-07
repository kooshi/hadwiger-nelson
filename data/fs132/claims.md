# FS-132 — the claim list: six by the nerve

*Fixed by Keryx, 2026-10-07 (UTC), before the derivation launches, from the asking lane's stub. Each claim is posed, not derived;
its statement is the stub's, quoted by its first line as the address — read each whole there, with the stub's § The question,
§ Existence form, § Structural form and § What each answer gives. A later change to this file is a dated line at its end.*

## The claims, in the order a deriver takes them

**1. The extraction at every number of colours** (two names, one statement and its corollary):

> **C132-EXT (posed, not derived).** *The extraction at every `k`.* For every `k` and every measurable `c : ℝ² → {1, …, k}` proper
> — source: plans/STUB-six-by-the-nerve.md

> Proposition 7.1 with `k` in place of five. In particular **C132-CORES**: for every `k`, such a colouring has a cyclic centre in
> — source: plans/STUB-six-by-the-nerve.md

**2. Card 1's two readings.** The card:

> question: does-the-six-colour-chain-run-with-no-map
> — source: plans/STUB-six-by-the-nerve.md

Its two claims are named here and **stated by the deriver in its plan before either is derived**; each statement is then fixed
in this file by a dated line, from the deriver's message:
- **C132-RUN-EMPTY** — that the argument of FS116-Y4-EMPTY (`plans/FS116-derivation.md`; in the kernel since wave 8 of the Lean
  backlog as `emptyNS`, at the class of FS129-SR3-EMPTY-NS) reads only what C132-EXT's conclusion gives a measurable six-colouring,
  or the named step at which it reads more.
- **C132-RUN-CV** — the same for FS114-CV-EXISTS (`plans/FS114-derivation.md`).

**3. Two statements posed beside them:**

> FS114-CV-EXISTS); **C132-DIAG (posed)**: in a measurable six-colouring no four-cycle centre has a ring alternating, almost
> — source: plans/STUB-six-by-the-nerve.md

> **C132-RADIUS (posed)**: `χ(ℝ²) = 7` iff some disc has no measurable six-colouring proper at almost every unit pair inside it
> — source: plans/STUB-six-by-the-nerve.md

**4. Behind them, as questions** (cards 2 and 3 of the stub; each becomes a claim only by a dated line here):

> question: what-the-extraction-needs-of-the-centres
> — source: plans/STUB-six-by-the-nerve.md

> question: where-does-five-enter
> — source: plans/STUB-six-by-the-nerve.md

## The two forms of the milestone's question

> *Is there an object?* **Is there a measurable six-colouring of a closed disc of radius above 1 about a point `p`, proper at almost
> — source: plans/STUB-six-by-the-nerve.md

> *About every solution, in the widest class where it makes sense.* **For every `k ≥ 5` and every measurable `k`-colouring of a
> — source: plans/STUB-six-by-the-nerve.md

*Not claimed* (read the stub's § Failure clauses whole): any value of `χ(ℝ²)`; the four statements the same road would need at
six — at most two labels along a ring, local finiteness of the cyclic centres, a cycle of length at least four at some centre,
the death of every such cycle — which are what the answer is made of and are nobody's yet; anything at a number field's plane.

## What the claims rest on, each at its grade

- The outside release, `[OAIMath2026]` family 158 — [kernel, outside]: kernel-checked in the release's own library at its pin,
  built and audited here (`plans/EXT-OAI1-audit.md` stage 4), **at five colours**: its extraction's Lean is typed at five. Its
  manuscript read in full, no gap found, one mind (`plans/EXT-OAI2-reading.md` stages 3–4); that the extraction "uses the count?
  no" is that reading's § 4.2, one mind — C132-EXT is the check of it.
- This project's six-colour chain: `LEDGER.md` rows 137 and 148–149, at the grades filed there; FS116-Y4-EMPTY at its wider
  class is kernel-checked on `main` (`Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean`, `emptyNS`).
- The two calibration colourings at seven (the islands and the stripes): `plans/EXT-OAI2-reading.md` § 5.6, [hand], one mind.

## Dated lines

- **2026-10-07 (after FS132-E1's Stage 1, commit `373d06fa`; FS-132 inventory item 2): card 1's two readings are fixed as the
  deriver's plan states them** — each read whole at its address, with the data and the dictionary it is stated over:

> **The data.** For a weak measurable six-colouring `c`, an **extracted centre** is what C132-EXT's conclusion gives: a point `x`
> — source: plans/FS132-six-by-the-nerve.md § The readings, stated

> **The dictionary** (map → measurable): a vertex `p` of at least four colours → an extracted centre `p` with `ℓ = 4`; a tile of `p`
> — source: plans/FS132-six-by-the-nerve.md § The readings, stated

> **C132-RUN-EMPTY.** *Statement:* each step of the route FS116-V6 § 2.2 (`plans/FS116-V6-verification.md`: V6-DIAM, V6-E1, V6-DICH,
> — source: plans/FS132-six-by-the-nerve.md § The readings, stated

> **C132-RUN-CV.** *Statement:* each input of the route to FS114-CV-EXISTS (`plans/FS114-CVB-verification.md` § 1.4, by the entry's
> — source: plans/FS132-six-by-the-nerve.md § The readings, stated

  **Two statements enter the list with them, each named inside its reading's statement and read there**: **C132-M-EMPTY** — that
  no colouring of the class C132-RUN-EMPTY names exists (the existence form's NO, in the measurable class); **C132-M-CV** — that
  the class C132-RUN-CV names has an extracted centre whose label cycle has length at least four. They are named apart from the
  readings because "the argument runs" and "the statement is true" come apart: a stall of a reading says nothing of its
  statement, and either statement may be derived by another route. *Not claimed*: each reading's own line, as its statement
  gives it. **One reading of the stub, the deriver's, adopted**: the existence form's "cyclic centre whose label cycle has length
  four" is read as an extracted centre with a cycle of length four — the extraction returns some centre, not a prescribed one,
  and its cycle need not consist of edges of that centre's own transition graph.
- **2026-10-07 (after FS132-E1's Stage 3, commit `eefdc6b1`; FS-132 inventory item 3): the first claim is derived, [hand], one
  mind, at two forms wider than posed, which enter the list** — C132-EXT and C132-CORES as posed are their instances at radius 8:

> derivation: C132-EXT-DISC
> — source: plans/FS132-E1-derivation.md Stage 3

>   statement: let k ≥ 1 be an integer, c a weak measurable k-colouring of the plane (`[OAIMath2026]` Definition 1.2), 𝓛 the set of its cyclic centres (the points x whose transition graph Γ_x, Definition 6.1 read with k labels, contains a cycle), and D a closed disc of radius greater than 1 with 𝓛 ∩ D finite; then there are a point x of 𝓛 in the interior of D, an integer ℓ with 3 ≤ ℓ ≤ k, distinct labels i_0, …, i_{ℓ−1}, a radius ρ > 0 with B̄(x, ρ) ⊂ D and 𝓛 ∩ B̄(x, ρ) = {x}, and for each j modulo ℓ a compact connected set K_j ⊂ B̄(x, ρ), a unit vector v_j and points q_{j,m} of K_j other than x, such that (1) x ∈ K_j and K_j meets the circle ∂B(x, ρ); (2) q_{j,m} → x and (q_{j,m} − x)/|q_{j,m} − x| → v_j as m → ∞; (3) H_{i_j} ∩ Δ(K_j) = ∅ and H_{i_{j+1}} ∩ Δ(K_j) = ∅, where H_i is the closed essential support of the class of label i and Δ(K) is the set of z with min over q ∈ K of |z − q| below 1 and max over q ∈ K of |z − q| above 1; (4) K_j ⊂ H_{i_j} ∩ H_{i_{j+1}}; (5) i_j i_{j+1} is an edge of Γ_x
> — source: plans/FS132-E1-derivation.md Stage 3

> derivation: C132-CORES-FREE
> — source: plans/FS132-E1-derivation.md Stage 3

>   statement: for every integer k ≥ 1 and every weak measurable k-colouring of the plane, every closed disc of radius greater than 1 contains a cyclic centre
> — source: plans/FS132-E1-derivation.md Stage 3

> derivation: C132-CONFINE
> — source: plans/FS132-E1-derivation.md Stage 3

>   statement: let K be a compact connected set and H a set with H ∩ Δ(K) = ∅; then for every z ∈ H, either K ⊂ B̄(z, 1) or K ∩ B(z, 1) = ∅; in particular, if x ∈ K and z ∈ H with |z − x| < 1 then K ⊂ B̄(z, 1), and if x ∈ K, z ∈ H, |z − x| = 1 and (q_m) is a sequence in K ∖ {x} tending to x with (q_m − x)/|q_m − x| → v, then v·(z − x) ≥ 0 when K ⊂ B̄(z, 1) and v·(z − x) ≤ 0 when K ∩ B(z, 1) = ∅
> — source: plans/FS132-E1-derivation.md Stage 3

  **C132-EXT-DISC** is the extraction on any closed disc of radius above 1 with finitely many cyclic centres, at every number
  of colours, with two clauses the manuscript does not state: (4) each continuum lies in both its labels' supports; (5) each
  edge of the returned cycle is an edge of the centre's own transition graph. **C132-CORES-FREE** needs no hypothesis on the
  centres. **C132-CONFINE** is a relay-result, the dictionary's replacement for "the same tile". **Card 2 is answered at the
  level of the argument** (that record, § Card 2, answered on the way): what the extraction reads of the centres is neither
  "finite" nor "closed and totally disconnected" — it is zero length, and isolation of the one essential centre; finiteness is
  sufficient and not necessary; a weaker sufficient hypothesis is a sketch there, not a claim here. **The relation asked at
  the first dated line**: one way, derived (clause (5)); the other way open, and false for the argument's own selection.
  *Not claimed*: each entry's own line; in particular nothing supplies the finiteness hypothesis for an arbitrary
  six-colouring, and nothing says a cycle longer than three is ever returned.
- **2026-10-07 (after FS132-E2's Stage 2, commit `1bb5954c`; FS-132 inventory item 5): card 3 is turned into six claims, fixed
  as that record states them** — each read whole at its address, with its *not claimed* line and the terms above the list:

> 1. **C132-FILL** (the card's (i): the target and the map). Let k ≥ 3 be an integer, X_k the union of 𝒢 with all its filled
> — source: plans/FS132-E2-derivation.md Stage 2, § The claims

> 2. **C132-NOESS** (the card's (ii): which centres stay essential). For k ≥ 4 every loop of 𝒢 is null-homotopic in X_k; and
> — source: plans/FS132-E2-derivation.md Stage 2, § The claims

> 3. **C132-REL** (the relation a disc imposes). In the setting of C132-FILL, for a circle C in the interior of D₁ that misses
> — source: plans/FS132-E2-derivation.md Stage 2, § The claims

> 4. **C132-INDEX** (the invariant that tells six from seven). Let a, b, c be three labels, Θ the union of the edges ab, bc, ca
> — source: plans/FS132-E2-derivation.md Stage 2, § The claims

> 5. **C132-TRI-STRIP** (what a triangle centre's ring carries, every k). Let k ≥ 3, c a weak measurable k-colouring of the
> — source: plans/FS132-E2-derivation.md Stage 2, § The claims

> 6. **C132-LONG** (the card's (iii): the forcing statement; the disc form of the claim list's C132-M-CV). There is a radius
> — source: plans/FS132-E2-derivation.md Stage 2, § The claims

  **The deriver's recognition, which changes the card's frame**: with every triangle filled in the target, every loop bounds,
  so no centre "stays essential" and the filled target carries no obstruction (C132-FILL, C132-NOESS). The statement that
  tells six from seven is posed in the unfilled label graph, on the unit circle about a triangle centre: an index of the three
  outside labels (C132-INDEX, a statement with no colouring in it), carried to the centre by C132-TRI-STRIP and summed over a
  disc by C132-REL. **C132-LONG** is the forcing statement, the disc form of C132-M-CV, which follows from it. *Not claimed by
  any of the six*: a value of `χ(ℝ²)`; that a six-colouring exists; that a cycle longer than three is ever returned.
- **2026-10-07 (after FS132-E3's Stage 3, commit `db43b298`; FS-132 inventory item 6): C132-M-EMPTY is derived, [hand], one
  mind, from two wider statements that enter the list; the reading C132-RUN-EMPTY has its verdict** — each read whole at its
  address:

> derivation: C132-M-ORBIT
> — source: plans/FS132-E3-derivation.md Stage 3

>   statement: let U be an open set of the plane containing the closed unit disc about a point p, let c be a weak measurable six-colouring of U (a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair (z, u) of a point z of U and a unit vector u with z + u in U), let a_0, a_1, a_2, a_3 be four of the labels and X, Y the other two, and for each j modulo 4 let K_j be a compact set containing p and a point other than p with H_{a_j} ∩ Δ(K_j) = ∅ and H_{a_{j+1}} ∩ Δ(K_j) = ∅, where H_a is the closed essential support of the class of a and Δ(K) is the set of z with min over q ∈ K of |z − q| below 1 and max over q ∈ K of |z − q| above 1; then there are no angle ψ and number δ > 0 such that (i) for every integer k and almost every θ with |θ − ψ − kπ/3| < δ the palette P_p(e(θ)) (`[OAIMath2026]` Definition 5.1, read at the centre p with samplings inside U) contains X or Y, and (ii) for every η > 0 the set of θ in (ψ − η, ψ + η) whose palette contains X and the set of those whose palette contains Y both have positive measure
> — source: plans/FS132-E3-derivation.md Stage 3

> derivation: C132-M-EXCL
> — source: plans/FS132-E3-derivation.md Stage 3

>   statement: let U, p, c, the labels a_0, a_1, a_2, a_3, X, Y and the sets K_0, K_1, K_2, K_3 be as in C132-M-ORBIT; then it is not the case that for almost every unit vector e the palette P_p(e) contains X or Y
> — source: plans/FS132-E3-derivation.md Stage 3

>   verdict: stalls at: V6-HUBS — "a tile of p tips at most two [change points], and two only if consecutive", whose argument is "a tile's tipped change points are pairwise within distance 1 (V6-DIAM)": the dictionary's left-hand term is the tile as one connected piece of diameter at most 1 holding two hubs in its closure ("the same tile"); the data confine a label's exclusion sets, not the label
> — source: plans/FS132-E3-derivation.md Stage 3

  **C132-M-ORBIT** is the exclusion at one six-fold orbit of ring directions; **C132-M-EXCL** its corollary for a ring whose
  palettes almost everywhere hold an outside label; C132-M-EMPTY as named in the first dated line is C132-M-EXCL at an
  extracted centre. They read of the extraction's data **clauses (1) and (3) only** — a point, four labels in a cycle, four
  compact sets through the point with the two-colour exclusion — and nothing of clauses (2), (4), (5), of connectedness, or of
  the centre's isolation. **The reading's verdict is "stalls at V6-HUBS"** (the one step that reads a tile as a connected
  piece), and its statement is derived all the same, with that step and the count replaced by a count of exclusion sets
  against three axes. *Not claimed*: each entry's own line — in particular nothing at a ring with palettes that hold no
  outside label on a set of positive measure near the orbit (the (Q) rings), nothing at seven labels, nothing at a cycle of
  three, five or six labels, and that a map's four-colour vertex carries the four sets is taken from row 134's base, not
  re-derived.

