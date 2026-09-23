# Poros — FS-73 certification of the two four-colour refusals (2026-09-23)

Advisor record. Sole writer: Poros. Not committed by me; the product owner commits.
Brief: advise implementer A (agent `a0aa37660636d6597`) on certifying the two refusals of FS-73 P1d/P1d′ on de Grey's
lattice over K = ℚ(√3,√11) — the pair at 8/9 and the pair at v = −(4/9)(1+√−11), each refused on a Minkowski ball of
radius 1.5 (39,829 points, average degree 18.4) — after five smaller balls (R = 1.0 … 1.4, degree 8.3–16.6) came back
UNKNOWN at 1,500 s.

## §1. My expectation, written before reading A's record, the plan's rows, or any code (from the brief alone)

Written at 2026-09-23, after reading only the product owner's brief, the Poros identity files, and `CLAUDE.md` G65 from
disk. Everything below is a registered expectation, to be scored against the record.

**E1. Why the small balls are hard (basis: analogy + derived arithmetic).** G65 is measured at **three** colours, where the
random-graph threshold is average degree ≈ 4.7 and the peak sat at 4–6. At **four** colours the random-graph threshold is
≈ 8.9, so the four-colour hardness peak should sit roughly at degree 8–14 and the "decides in seconds" shoulder should start
near 2.5–3× threshold, degree ≈ 22–27. G65's degree law with g = 54 reproduces the brief's numbers exactly (R = 1.0 → 8.26,
1.4 → 16.64, 1.5 → 18.39), and prices the proposed balls: **R = 1.75 → degree 22.2, ≈ 74 k points; R = 2.0 → 25.3,
≈ 126 k points; R = 2.5 → 30.1, ≈ 307 k points** (points by R⁴ scaling from 39,829 at 1.5). So the five UNKNOWNs sat inside
the four-colour peak, and R = 1.5 at 18.4 sits on its upper shoulder — which is what 1,407 s against a 1,500 s cap looks like.

A second, independent reason, which the degree law does not see: these are **forcing** asks, not colourability asks. The
ball is four-colourable (the lattice is); only the one constraint c(−h) ≠ c(+h) is to be refuted, so the instance is a
satisfiable, near-rigid graph plus one clause family, and its refutation must carry the constraint across the whole
rigid structure between ±h. A small ball may simply not force the pair at all (the forcing material lies outside it), in
which case its UNKNOWN is a hard *satisfiable* instance, not a slow refutation.

**E2. What degree-up should do (registered prediction; falsifiable).** At R = 2.0 (degree ≈ 25) both asks refuse, and the
8/9 ask takes well under its R = 1.5 time — I register **under 400 s** for 8/9 and **under 36 s** for v. Falsifier: 8/9 at
R = 2.0 UNKNOWN at 1,500 s, or slower than at R = 1.5 — which would say the difficulty is not the four-colour peak but the
proof's globality (or an encoding artefact), and the ball is the wrong object.

**E3. What could make the two refusals false (each a thing to check in code, not prose).**
- (a) **Symmetry break overreach — my rank-1 suspicion.** Once c(−h) = 0, c(+h) = 1 is pinned (sound, by colour symmetry),
  the residual colour symmetry is only the swap 2 ↔ 3 and there is **no** translation symmetry left. Any further pin — a
  clique elsewhere pinned to fixed colours, a vertex pinned by "vertex-transitivity", or a value-precedence chain over all
  four colours in vertex-index order that does not start at the pinned pair — can over-constrain and manufacture UNSAT.
  The CLAUDE.md toolchain checklist (pin a clique, then precedence) is written for *colourability* asks; transplanted
  verbatim into a *pair* ask it is unsound. Tell: a refusal that becomes SAT when the break is removed.
- (b) **Invented edges.** Edges are derived from U. A vector admitted to U by a float test, a norm-one test in the wrong
  embedding (the conjugate rather than the plane's), or a coordinate mix-up (lattice basis vs complex coordinates) adds
  non-unit edges, which make refusals *easier*. Under CLAUDE.md's measured/derived rule, a refusal on a law-derived graph is
  the suspect verdict. Check: every u ∈ U has |u|² = 1 exactly in K in the embedding the plane uses; the 54 are closed under
  negation and the point group.
- (c) **The pair is not the claimed pair.** ±h are in one coset only if δ ∈ Λ. If δ ∉ Λ (e.g. if 1/9 ∉ Λ and the code
  snapped h to a nearby coset point), the refused pair is a different vector. Check δ ∈ Λ in exact integer coordinates, and
  that the two pinned vertices differ by exactly δ.
- (d) **Pipeline.** The verdict read from the wrong file (a stale CNF, a cached run, a different ball), kissat's exit code
  20 not actually checked, or a timeout misread as UNSAT.
- (e) **Consistency test available for free:** every colouring the project already owns (Theorem B's residue colourings at
  the primes above 2, Fischer's ℤ/4 colouring, the census's periodic colourings) must give ±h one colour for both δ. For
  additive colourings into a group of exponent 4 this is automatic for δ ∈ 8Λ ⊆ 4Λ (G41), so it is **not** evidence —
  but a found colouring separating either pair would kill the refusal outright.

**E4. The frame-level concern I bring in (basis: prior).** The object to certify is not "a ball refuses" but "(0, δ) is
forced", and G55's transport makes forcing compositional: a finite H forcing (0, δ) forces every translate and point-group
image, so F is certified by **one certificate per generator of 8Λ under the point group**, and Harder's 8/3 = 3·(8/9)
would follow from the 8/9 certificate by chaining three copies — a check against known prior art, not an extra ask. So
the right certified object is the graph the refutation actually touches (the LRAT core's vertices), reached by going up in
degree and then shrinking the *proof*, and the equality F = 8Λ has a second, cheap half — F ⊆ 8Λ — certified by exhibited
periodic colourings on a finite quotient (a proper colouring of Cay(Λ/NΛ, U mod N) is a checkable file). The quotient can
only ever certify the ⊆ half: a quotient colouring proves a pair is free, never forced.

## §2. Evidence inventory

- `data/fs73/records/phase-P1.md`, A's phase record (working tree, whole file) — read against: E1–E4, the two refusals on a sound encoding and a verified U — surprised: yes
  (i) §Step 4: the R = 1.5 row for the 8/3 control took 122 s on the Minkowski ball, against 8 s for the same pair on
  FS-70's 23,083-point word ball (§P1c). A larger, denser ball was fifteen times slower, against E2.
  (ii) The three refusals on the *identical* R = 1.5 ball, all at degree 18.41, took 36.6 s (v), 122 s (8/3) and 1,407 s
  (8/9). That is a 38× spread at one degree, which no reading by degree can produce.
- `data/fs73/census/K-rows.jsonl`, every `force`, `confirm` and `pd3` row — read against: the record's numbers and clause counts matching the stated pins — surprised: no
  v's CNF has 1,506,472 clauses and 8/9's has 1,586,130. The difference, 79,658 = 2·39,829 (+1 precedence unit, −1 pin), is
  exactly the precedence chain. So v's CNF carries three pins and no precedence, and the non-identical cadical re-run
  (91.4 s, 1,586,130 clauses) was pair + precedence.
  The 4-core equals the ball at every radius, so "ask on the k-core" is a no-op on these balls.
- `tools/fs73_screen.py`, the forcing path (`graph_cnf`, `forcing_ask`, `cmd_force_K`, `cmd_confirm_K`, `run_cnf`, `minkowski_ball`, `ball_graph`, `core`; lines 777–976, 1268–1356) — read against: E3(a)–(d) — surprised: no
  Precedence is emitted only between consecutive unpinned colours. So v's ask (pins 0, 1 and a common neighbour at 2) has
  no precedence, and 8/9's (pins 0, 1) has only 2-over-3. Both are sound breaks for an ask that is invariant under colour
  permutations.
  There are no at-most-one clauses, which is sound.
  The pair is placed at ±h only when δ ∈ 2Λ, and every edge is an exact lattice difference in U.
  One loud defect, not a silent one: `run_cnf` reads any `s ` line lacking "UNSATISFIABLE" as SAT. An `s UNKNOWN` would
  therefore become SAT and then trip the model assertion: a crash, never a false refusal.
- `plans/FS73-rigidity-dichotomy.md`, §0 (the normal form), §S.2 P1d and P1d′ — read against: the brief — surprised: no
  "9 ∣ N is inadmissible since 1 ∈ 9Λ" already records that 1/9 ∈ Λ.
- `scratchpad/fs73-poros-cert/olat.py` and `cmpU.py`, my independent check (Λ as Z/9 with Z ∈ ℤ[ζ₆, w]) — read against: E3(b) and E3(c) — surprised: yes
  The 30 generators span exactly (1/9)O_E, where O_E = ℤ[ζ₆, w] is the ring of integers of E = ℚ(√−3, √−11).
  U = {Z/9 : Z·Z̄ = 81} has 54 elements and equals A's U element by element; v and 8/9 have exactly A's H-coordinates.
  Word distances by breadth-first search: v 2, 8/3 3, 8/9 4.
- The absent: no row asks v at R = 1.25–1.4, and no LRAT is on file for either refusal — read against: a replication ladder for both targets — surprised: no
  The ladder was run for 8/9 only.

## §3. Hunch ledger

hunch: encoding-overreach
  claim: the forcing CNFs pin more than the colour symmetry allows (pair pins plus a clique or precedence), manufacturing UNSAT
  basis: prior
  falsifier: `graph_cnf` emitting precedence only among unpinned colours, and v's CNF carrying no precedence
  registered: 2026-09-23
  status: killed (by: `tools/fs73_screen.py` `graph_cnf` lines 858–873 and the clause-count difference 79,658 = 2n in `K-rows.jsonl`)

hunch: invented-edges
  claim: U contains a non-unit vector, so the balls carry non-unit edges
  basis: prior
  falsifier: an independent exact enumeration of U equal to A's element by element
  registered: 2026-09-23
  status: killed (by: `scratchpad/fs73-poros-cert/cmpU.py` — 54 = 54, sets equal)

hunch: eight-ninths-is-a-corollary-of-v
  claim: v's refusal alone forces 8/9, because 8/9 = −(v + v̄) and complex conjugation is a lattice automorphism fixing 0; and v's orbit alone spans 8Λ
  basis: derived
  falsifier: v̄ ∉ the point group's orbit of v, or −(v + v̄) ≠ 8/9 in exact arithmetic, or ℤ[ζ₆]v + ℤ[ζ₆]v̄ ≠ 8Λ
  registered: 2026-09-23
  status: confirmed (by: derivation — v = −(8/9)w, v̄ = −(8/9)(1 − w), so v + v̄ = −8/9 and ℤ[ζ₆]v + ℤ[ζ₆]v̄ = (8/9)ℤ[ζ₆, w] = (8/9)O_E = 8Λ; checked in exact integers in `olat.py`; conjugation maps each generator ζ₆^m ρ^n to ζ₆^{−m} ρ^{−n})

hunch: word-distance-sets-the-cost
  claim: on a fixed ball the forcing ask's cost is set by the pair's word distance in Cay(Λ, U), not by the ball's degree
  basis: measured
  falsifier: an ask at word distance 2 on an equal-degree ball that runs to the cap while a distance-4 ask on it refuses fast
  registered: 2026-09-23
  status: open (three points on one ball; a candidate, not a law)

hunch: degree-up-helps (E2)
  claim: at R = 2.0 (degree ≈ 25) 8/9 refuses under 400 s and v under 36 s
  basis: analogy
  falsifier: 8/9 at R = 2.0 UNKNOWN at 1,500 s or slower than at R = 1.5
  registered: 2026-09-23
  status: open — and weakened by the 8/3 control (122 s on the denser Minkowski ball against 8 s on the word ball)

## §4. Exchanges

(newest last)

**X1 — PO → Poros (mid-reading).** A handed back at ~561k tokens; the successor is A2 (`a5a8bcae844341aa4`). The PO had
independently checked the same soundness point I checked (v's common-neighbour pin with no precedence) and asked A2 to fix
the recipe's wording. An independent verifier is rebuilding both refusals; I must not message it.

**X2 — Poros → A2, the rank-1 card.**
question: is-anything-besides-v-on-the-critical-path
  evidence: 8/9 = −(v + v̄) exactly (v = −(8/9)w, w = (1+√−11)/2); conjugation is in the point group; Λ = (1/9)O_E so
    ℤ[ζ₆]v + ℤ[ζ₆]v̄ = 8Λ (`olat.py`); word distances v 2, 8/3 3, 8/9 4 against 36.6 s, 122 s, 1,407 s on one ball (`K-rows.jsonl`)
  expected: two refusals to certify, 8/9 the hard one, degree-up the lever (the brief's frame)
  ask: given 8/9 = −(v + v̄), is anything left on the certification critical path besides v's refusal, and what is the smallest object it certifies on?
  if nothing else: drop 8/9's replication ladder; certify v from its R = 1.5 refusal by cadical LRAT and assumption-core rounds (three pins, no precedence); 8/9's refusal stays as corroboration
  if something else: 8/9 is certified off the critical path, on H ∪ (conj(H) + v) or directly, and the reason is recorded
  answered by: Implementer A2
  cost: one message; the route change saves the whole 8/9 ladder
  hunch: nothing else — the PO's "both must replicate" ruling predates the identity
  falsifier: a PO ruling or a lattice fact that makes 8/9's direct certificate necessary
  rank: 1
Also sent: the soundness checks (clean), the `s UNKNOWN` → SAT parse item (loud, not a soundness defect), the 4-core no-op,
and the (1/9)O_E coordinates as a reviewer-facing option.

**X3 — Poros → PO.** The same finding, stated for the PO, with "no defect found".

**X4 — PO → Poros.** The PO checked both identities, told A2 its degree-up instruction no longer binds (the route is A2's
call), and asked that the word-distance hunch stay registered. **Its structural remark, recorded as context for the close:**
with Λ = (1/9)O_E and F = 8Λ, the colouring space factors through O_E/8O_E, which — 2 splitting in ℚ(√33) (33 ≡ 1 mod 8) —
is the product of the level-3 quotients at the two primes above 2; row 67's 2-adic tower stabilisation may be the local
shadow of this global fact, and whether the two match level for level is a question for the close, not for A2 now.

**X5 — Poros → A2, addendum (a reading instruction, the answer known).** The kernel already holds the finite half:
`Proofs/HadwigerNelson/OneDefect.lean:113` `forces_of_not_colorable_append_single` — ¬ Colorable (E ++ [(u, v)]) k →
Forces (edgeGraph n E) k u v. So v's certificate is a plain non-4-colourability certificate of H_v plus the one non-unit
edge {0, v}, through the rung-B / FS-58 pipeline; with that edge the pair and its common neighbour are a triangle, so the
existing pins are the standard clique pin. Same form for the independent-verifier artifact. Assumption-core caution: keep
the pins' vertices outside the selector set, rebuild the final CNF from the kept list, assert its sha256.

**X6 — A2 → Poros: the card answered "nothing else", and the route is running.**
- A2 re-derived both identities in exact integers with A's lattice layer:
  - 1/9, ζ₆/9, w/9 and ζ₆w/9 have Λ-coordinates (4,−2,−2,−1), (2,−1,0,−1), (2,−1,−1,0) and (1,−1,0,0), with
    determinant −1. So Λ = (1/9)O_E.
  - v̄ = (−16,8,8,8), and v + v̄ = (−32,16,16,8) = −(8/9).
  - v's orbit under the order-24 point group has 12 elements, and its Hermite form is 8·I₄.
- The route A2 took:
  - Assumption-core rounds from the existing R = 1.5 refusal of v. The pinned triangle stays outside the selector set.
  - Go up in degree only if the rounds stall.
  - The final CNF is rebuilt from the kept list, with its sha256 asserted. It is stated as "H_v + {0, v} is not
    4-colourable".
  - LRAT from cadical, plus an unpinned recheck by a second solver.
  - 8/9 is kept as corroboration: a direct refusal if cheap, otherwise the composite graph.
  - A2 is also fixing the `s UNKNOWN` parse, with a plant.

The card changed the move: the 8/9 degree ladder is dropped. By the core's economic stop I now stop asking; the domain builds.

**Registered for the close (basis: analogy).** The assumption-core fixpoint H_v has **at most 3,000 vertices**.
- Basis: v is at word distance 2. Harder's 8/3, at distance 3, has an in-house core of 588 vertices and a published one of 745.
- Falsifier: a fixpoint with more than 3,000 vertices, or rounds that stall and force the degree-up.

## §1′. The expectations, scored

| expectation | verdict | why |
|---|---|---|
| E1, why the small balls are hard | half right | The small balls do sit in the four-colour hardness band, but the band is not the whole story. On one ball, at one degree, the pair's word distance orders the cost (see the next section). |
| E2, degree-up helps | open, weakened | Never run: v needs no smaller or larger ball. The 8/3 control points against it: 122 s on the denser Minkowski ball against 8 s on the word ball. |
| E3(a), symmetry-break overreach | killed | `graph_cnf` emits precedence only among unpinned colours. |
| E3(b), invented edges | killed | U equals my independent enumeration, element by element. |
| E3(c), pair not the claimed pair | killed | δ ∈ Λ, and both targets' coordinates check exactly. |
| E3(d), pipeline | clean | One loud path found (`s UNKNOWN` read as SAT, then a crash); A2 is fixing it. |
| E4, composition | confirmed, sharpened | One generator suffices, v, and 8/9 is a corollary of it. |

## §5. Retractions and my own errors

- **My error: frame acceptance in E1/E2.**
  - The brief itself gave both refusals on the *same* ball at the same degree: 1,407 s against 36.6 s. That is a 38× spread
    that no reading by degree can produce.
  - I wrote E1 and E2 inside the brief's degree frame, and G65's, without noticing it.
  - The anomaly surfaced only when I read the rows and the word distances.
  - What caused the miss: the expectation was written from the frame the brief arrived in. The brief's numbers were never read
    against that frame before I wrote the expectation.
- **No retractions on either side.** A2 accepted the card after re-deriving it, and the PO checked both identities
  independently. Zero retractions is not evidence of agreement (G51). Here the disagreement was settled by derivation in
  exact arithmetic, so there was no cost window to spend.
