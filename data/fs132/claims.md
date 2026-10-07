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
- **2026-10-07 (after FS132-E2's Stage 3, commit `7b76f48f`; FS-132 inventory item 7): card 3's six claims have their verdicts,
  and four entries of that record enter the list** — each statement read whole in its entry there:

> derivation: C132-RING-TAME
> — source: plans/FS132-E2-derivation.md Stage 3

> derivation: C132-RING-WIND
> — source: plans/FS132-E2-derivation.md Stage 3

> derivation: C132-ORBIT
> — source: plans/FS132-E2-derivation.md Stage 3

> derivation: C132-SEP
> — source: plans/FS132-E2-derivation.md Stage 3

> derivation: C132-LONG
> — source: plans/FS132-E2-derivation.md Stage 3

  **Derived, [hand], one mind**: C132-FILL, C132-NOESS, C132-REL, C132-INDEX, C132-TRI-STRIP as fixed above; **C132-RING-WIND**
  (a tame ring's winding number exists and is 3 modulo 6 — no colouring in it), **C132-ORBIT** (every extracted triangle
  centre of a weak measurable six-colouring carries an orbit index with values 2, 3 or 4 — over the release's Corollary 5.4
  taken at its statement), **C132-SEP** (one computation about the unit chord's angle). **Stalled**: **C132-LONG**, the forcing
  statement, at the winding number of the three outside labels on a triangle centre's unit circle; and **C132-RING-TAME**, the
  stalled step as a statement of its own — the pure-side palette changes at finitely many directions, no two of them 60°
  apart — at its first clause, "the three-label form of the release's two-label strip rigidity". *Not claimed*: each entry's
  own line; in particular C132-RING-TAME is said by its own entry to be possible only on a normal form (local slack along
  the ring breaks it) and not to be enough for C132-LONG by itself; C132-M-CV stalls with C132-LONG.
- **2026-10-07 (after FS132-E3's Stage 4, commit `33686856`; FS-132 inventory item 9): the second reading has its verdict, and
  one posed statement is derived at a wider form that enters the list** — each read whole at its address:

> derivation: C132-DIAG-WIDE
> — source: plans/FS132-E3-derivation.md Stage 4

>   statement: let U be an open set of the plane containing the closed unit disc about a point p, c a weak measurable six-colouring of U, and D, D′ two disjoint pairs of labels; then there is no measurable map w from the unit circle to {D, D′} with w(e) ⊂ P_p(e) and w(Re) ≠ w(e) for almost every unit vector e, R the rotation by π/3
> — source: plans/FS132-E3-derivation.md Stage 4

> derivation: C132-RUN-CV
> — source: plans/FS132-E3-derivation.md Stage 4

  **C132-RUN-CV: stalls at FS112-N3-DENSE3**, the route's first input — its alternative "or a repeated colour" reads the cyclic
  order of tiles at a point, and without it the restated input is C132-M-CV itself; the route's other inputs (the terminal
  modification and what serves it) are dissolved, not stalled. C132-M-CV stays open, and stalls by the other route at
  C132-RING-TAME (the dated line above). **C132-DIAG-WIDE** ([hand], one mind): no centre of a weak measurable six-colouring
  has a ring alternating under the 60° rotation between two disjoint pairs of labels — C132-DIAG as posed is its instance at a
  four-cycle's two diagonals. *Not claimed*: each entry's own line. **Not reached**: C132-RADIUS.
- **2026-10-07 (after FS132-P2's Stage 2, commit `f6f14aaf`; FS-132 inventory item 11): the milestone's second round — two
  cards of the asking lane, re-posed on the first night's results, and six claims, each posed, not derived** — read each whole
  in the stub's section, with its controls, the two forms and "What each answer gives":

> question: can-a-triangle-ring-change-at-two-points-sixty-degrees-apart
> — source: plans/STUB-six-by-the-nerve.md § The question, re-posed after the first night

> - **C132-COMP (posed, not derived).** No weak measurable six-colouring of an open set containing the closed unit discs about two
> — source: plans/STUB-six-by-the-nerve.md § The question, re-posed after the first night

> - **C132-PLACE (posed).** What the transfer (C132-M-ORBIT's (⋆), read at a triangle centre) and C132-TRI-STRIP force near a ring
> — source: plans/STUB-six-by-the-nerve.md § The question, re-posed after the first night

> - **C132-TURN (posed).** In a weak measurable six-colouring of a closed disc of radius above 2 about a triangle centre `x`, every
> — source: plans/STUB-six-by-the-nerve.md § The question, re-posed after the first night

> question: do-witnessed-cycles-exist-with-no-hypothesis-on-the-centres
> — source: plans/STUB-six-by-the-nerve.md § The question, re-posed after the first night

> - **C132-WIT (posed).** C132-M-ORBIT, C132-M-EXCL and C132-TRI-STRIP with each set `K_j` replaced by a two-point set `{p, q_j}`
> — source: plans/STUB-six-by-the-nerve.md § The question, re-posed after the first night

> - **C132-WIT-EX (posed).** Every weak measurable `k`-colouring has, in every closed disc of radius above 1, a point with a
> — source: plans/STUB-six-by-the-nerve.md § The question, re-posed after the first night

> - **C132-GRUNDY7 (posed).** For no order of the seven labels is the island colouring or the stripe colouring
> — source: plans/STUB-six-by-the-nerve.md § The question, re-posed after the first night

  **The ring card** (first): C132-COMP — no two triangle centres with disjoint label triples closer than 2 — then C132-PLACE
  and C132-TURN; the composition behind C132-COMP is the asking lane's, two lines, unchecked. **The witness card** (second):
  C132-WIT, C132-WIT-EX, C132-GRUNDY7. The two share no claim. **The asking lane's ruling on the class of C132-RING-TAME**: its
  second clause is posed as a conclusion for every weak colouring living on triangles alone (the ring card, C132-TURN); its
  first clause for honest (Grundy) colourings, after C132-GRUNDY7. As with the first round, each claim is stated by its
  deriver in its record before it is derived; a change is a dated line here.
- **2026-10-07 (after FS132-E4's Stage 1, commit `2344f702`; FS-132 inventory item 13): the ring card's three claims as their
  deriver states them** — read § 1.4 of that record whole, with its terms (a witnessed edge and triangle; an edge outer- or
  inner-blocked at a point; a pure side; the outside state of the ring):

> - **C132-COMP**, the stub's statement, verbatim (`plans/STUB-six-by-the-nerve.md` § The first claims a deriver takes).
> — source: plans/FS132-E4-derivation.md § 1.4

> - **C132-PLACE**, as one statement and a list under it: with a witnessed triangle at `x` and a pure side at the ring
> — source: plans/FS132-E4-derivation.md § 1.4

> - **C132-TURN**, the stub's statement, verbatim. Expected verdict: a stall, with two entries on the way —
> — source: plans/FS132-E4-derivation.md § 1.4

  C132-COMP and C132-TURN stand as posed; C132-PLACE is fixed as stated there. **Entries the deriver expects on the way, each
  named now and fixed when its verdict is saved**: C132-CROSS and C132-COMP-SHARP (wider forms of C132-COMP — the second with
  the proviso weakened to "no interface set on the unit circle about the crossing point"), C132-WITNESS (a relay-result),
  C132-ALT and C132-TURN-EDGE (two steps toward C132-TURN). **An overlap, ruled**: the strips with a fixed witness point in
  place of a limiting direction are the witness card's C132-WIT; the ring card's deriver uses that form as a step inside
  C132-CROSS, and the entry that crosses to the kernel lane is the witness card's.
- **2026-10-07 (after FS132-E5's Stage 1, commit `c0284a2d`; FS-132 inventory item 14): the witness card's three claims as their
  deriver states them** — read § 1.4 of that record whole:

> - **C132-WIT-ORBIT.** C132-M-ORBIT's statement (`plans/FS132-E3-derivation.md` Stage 3) with "for each j modulo 4 let K_j be a
> — source: plans/FS132-E5-derivation.md § 1.4

> - **C132-WIT-EXCL.** C132-M-EXCL's statement with the same replacement.
> — source: plans/FS132-E5-derivation.md § 1.4

> - **C132-WIT-STRIP.** Let k ≥ 3 be an integer, x a point, U an open set containing the unit circle about x, c a weak measurable
> — source: plans/FS132-E5-derivation.md § 1.4

> **C132-WIT-EX** — as posed, with the definition written out. For every integer k ≥ 1, every weak measurable k-colouring of the
> — source: plans/FS132-E5-derivation.md § 1.4

> **C132-GRUNDY7** — the posed sentence has two clauses, and my verdicts will be about these:
> — source: plans/FS132-E5-derivation.md § 1.4

  C132-WIT is fixed as the conjunction of its three statements; C132-WIT-EX as posed with its definition written out, and an
  anchored form the deriver will also rule on; C132-GRUNDY7 as two clauses, the second in two readings ("some output" and
  "every output" of the Grundy construction).
- **2026-10-07 (after FS132-E4's Stage 2, commit `5c04c375`; FS-132 inventory item 15): C132-COMP is derived as posed, [hand],
  one mind, through two wider entries that enter the list, with one relay-result** — each statement read whole in its entry
  (C132-COMP's own entry there carries the stub's statement, quoted above at the second round's line):

> derivation: C132-CROSS
> — source: plans/FS132-E4-derivation.md Stage 2

> derivation: C132-COMP-SHARP
> — source: plans/FS132-E4-derivation.md Stage 2

> derivation: C132-WITNESS
> — source: plans/FS132-E4-derivation.md Stage 2

  **C132-CROSS** is a covering count that reads no properness, no palette, no limiting direction and no connectedness — only
  the exclusions and two points of each set; **C132-COMP-SHARP**: six labels, witnessed triangles on disjoint triples at two
  points less than 2 apart, a common unit point in the open set — then one of the six edge sets lies on the unit circle about
  that point; C132-COMP as posed is its instance. *Not claimed*: each entry's own line.
- **2026-10-07 (after FS132-E4's Stage 3, commit `44f4bdc9`; FS-132 inventory item 16): the ring card's other two claims have
  their verdicts, and two entries enter the list** — each statement read whole in its entry:

> derivation: C132-PLACE
> — source: plans/FS132-E4-derivation.md Stage 3

> derivation: C132-ALT
> — source: plans/FS132-E4-derivation.md Stage 3

> derivation: C132-TURN-EDGE
> — source: plans/FS132-E4-derivation.md Stage 3

  **C132-PLACE: derived** ([hand], one mind), with its list by the germs of the outside state 60° to either side. **C132-ALT**
  ([hand]): no alternating step orbit has two adjacent ring points that both have a pure side — derived in step form; its
  measurable form for inner–inner pairs only. **C132-TURN-EDGE** ([hand]): at a step of the ring under the stated sides, the
  ring point carries no witnessed edge of the two ring labels. **C132-TURN: stalls** at the step from the card's hypothesis to
  that witness — that the ring point is a cyclic centre, and that the witnessed triangle its hypothesis gives contains the
  pair of ring labels (the relation of C132-EXT-DISC's clause (5), which no entry of that record uses). *Not claimed*: each
  entry's own line; no ring by formula was built.
- **2026-10-07 (after FS132-E5's Stages 2–3, commits `641b0836`, `7b47db5a`; FS-132 inventory item 18): two of the witness card's
  claims have their verdicts, and five entries of that record enter the list** — each statement read whole in its entry:

> derivation: C132-WIT-SIDE
> — source: plans/FS132-E5-derivation.md

> derivation: C132-WIT-MARGIN
> — source: plans/FS132-E5-derivation.md

> derivation: C132-WIT-CROSSED
> — source: plans/FS132-E5-derivation.md

> derivation: C132-WIT-SUPER
> — source: plans/FS132-E5-derivation.md

> derivation: C132-WIT-EX-FIN
> — source: plans/FS132-E5-derivation.md

  **C132-WIT: derived** ([hand] and derived from the first night's entries; one mind) — and **not a widening**: a two-point set
  is an admissible set and the straddle set only shrinks, so C132-WIT-ORBIT and C132-WIT-EXCL are C132-M-ORBIT and C132-M-EXCL
  themselves; C132-WIT-STRIP is wider than C132-TRI-STRIP, which is its corollary. **C132-WIT-SIDE** — any measurable
  labelling, one witness, one side of one unit circle near a ring point — is the entry on which the strips, C132-TRI-STRIP and
  C132-CROSS's first step all sit, and the one that crosses to the kernel lane for them. **C132-WIT-EX: stalls** at the
  selection of a point through which connected pieces of two smoothed classes pass and reach a common second point (the
  extraction's step at the annulus about an isolated centre); on the way C132-WIT-MARGIN (the statement as posed is free
  wherever a colouring has a margin, at points that are no centres), C132-WIT-CROSSED, **C132-WIT-SUPER** (the exclusion
  carried by any connected subset of one smoothed class's superlevel set — no hole, no centre, no isolation, one label at a
  time) and C132-WIT-EX-FIN (an anchored witnessed cycle on every disc with finitely many centres). *Not claimed*: each
  entry's own line. **Not yet answered**: C132-GRUNDY7.
- **2026-10-07 (after FS132-E5's Stage 4, commit `1cf25b20`; FS-132 inventory item 19): C132-GRUNDY7 has its verdict** — read
  each entry whole:

> derivation: C132-GRUNDY7-NOT
> — source: plans/FS132-E5-derivation.md

> derivation: C132-GRUNDY7-LOCAL
> — source: plans/FS132-E5-derivation.md

  **C132-GRUNDY7: stalls at its second clause, which is not one statement** — "the Grundy-ization of each" names a family (a
  maximality choice at each step, after a choice of order). Derived: **C132-GRUNDY7-NOT** (for no order is the honeycomb
  colouring, the island colouring or the stripe colouring a Grundy colouring — true already of the unmodified honeycomb, so
  the clause does not test the planted slack) and **C132-GRUNDY7-LOCAL** (for an order beginning with a label of the slack
  vertex, some output has one label on the whole slack ball). **The second clause is withdrawn as posed**; its two readings —
  "some output" and "every honest seven-colouring" — are open and go to the asking lane to pose or drop. **The class of
  C132-RING-TAME's first clause is not decided by this claim.**
- **2026-10-07 (after FS132-P3's Stage 1, commit `59a6fada`; FS-132 inventory item 21): A correction to two lines above, the
  coordinator's.** The line for FS132-E4's Stage 3 calls C132-TURN's stall "the relation of C132-EXT-DISC's clause (5)". That
  reads the clause more widely than its entry: clause (5) is derived for the extraction's own continua (its step S11, from
  their radii filling an interval), and says nothing of whatever witnesses a hypothesis hands a point; for those the relation
  is false in general (the witness card's record gives an anchored witnessed triangle at a point whose transition graph is a
  path — hand, one mind, no control). **C132-TURN's stall is: that a witnessed triangle given at a point lies in that point's
  own transition graph — a statement no entry of this list asserts.** And C132-TURN as posed carries the defect its poser
  now names: "every cyclic centre of which carries a witnessed triangle" attaches data of a unit circle to a point defined by
  its small balls, with nothing joining them. It stands as stalled and is not re-posed in that form.
- **2026-10-07 (after FS132-P3's Stage 3, commit `83058514`; FS-132 inventory item 23): the milestone's third round — one card
  of the asking lane and three claims, each posed, not derived** — read the stub's section "The question, re-posed after the
  second round" whole, with its two forms, its controls and "What each answer gives":

> question: what-does-a-seeds-circle-force-in-the-balls-about-its-ring-points
> — source: plans/STUB-six-by-the-nerve.md

> - **C132-LENS (posed, not derived).** On a six-sector turning seed, if at each of the ring points `y_1` and `y_{−1}` at least two
> — source: plans/STUB-six-by-the-nerve.md

> - **C132-PLACED (posed).** At the four-label ring point `y` of C132-LENS (ii): in the grammar of C132-PLACE's list, the labels
> — source: plans/STUB-six-by-the-nerve.md

> - **C132-ARC (posed).** In the setting of C132-COMP-SHARP, with exactly one of the six sets — a set of `x`, with labels `t_0`,
> — source: plans/STUB-six-by-the-nerve.md

  **The object is re-cut**: a *seed* — a point with data on its unit circle, however it came by them — and what that circle
  forces in the balls about its ring points. **C132-LENS first** (the composition behind it is the asking lane's, four lines,
  unchecked; it posits no witness at the ring point and does not use the extraction's clause (5)); then C132-PLACED and
  C132-ARC. **Left out of this milestone by the asking lane's recommendation, adopted**: whether, in the class of all weak
  colourings, a point with usable data must exist — C132-WIT-EX's open form, C132-RING-TAME's first clause for all weak
  colourings, and C132-GRUNDY7's two readings go to FS-127 and FS-128. As before, each claim is stated by its deriver in its
  record before it is derived; a change is a dated line here.

