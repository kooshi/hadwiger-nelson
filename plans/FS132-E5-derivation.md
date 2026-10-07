# FS132-E5 — the witness card: derivation record

*Ephodos, a derivation job in FS-132's second round (brief `data/fs132/briefs/FS132-E5-witness-card.md`, written 2026-10-07 UTC).
Three claims: C132-WIT, C132-WIT-EX, C132-GRUNDY7. One mind throughout; nothing here is blind. `M/` is the manuscript's section
folder, `/home/kooshi/source/math/preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/build/sections/`.*

## Theorems this phase proved

- Stage 1: none (the readback, the predictions, the recognition, the statements).
- C132-WIT-ORBIT, C132-WIT-EXCL — the first night's exclusion with four points in place of four compact sets; the same theorems
  restated. [derived from C132-M-ORBIT, C132-M-EXCL], one mind. Stage 2, § The exclusion, step by step.
- C132-WIT-STRIP — the strips at a triangle with one witness per edge and the side rule `|x + e − q_j| ≷ 1`; C132-TRI-STRIP is
  its corollary. [hand], one mind. Stage 2, § The strips, with one witness per edge.
- C132-WIT — the claim as posed. [derived], one mind. Stage 2.
- C132-WIT-SIDE — one witness excludes its labels on one side of a unit circle near a ring point; any measurable labelling.
  [hand], one mind. Stage 3, § Argument — one side of a unit circle.
- C132-WIT-MARGIN — labels whose supports keep off an annulus about a unit circle are witnessed at its centre by every
  nearby point. [hand], one mind. Stage 3, § Argument — witnesses by margin.
- C132-WIT-CROSSED — a support that approaches a unit circle from both sides at three points has no witness at its centre.
  [hand], one mind. Stage 3, § Argument — a label that crosses the circle has no witness.
- C132-WIT-SUPER — limits of connected subsets of one smoothed class's superlevel sets carry the straddle exclusion; no
  hole, no centre. [hand], one mind. Stage 3, § Argument — connected pieces of a smoothed class carry the exclusion.
- C132-WIT-EX-FIN — an anchored witnessed cycle at a centre on every disc with finitely many centres. [derived from
  C132-EXT-DISC], one mind. Stage 3.
- C132-WIT-EX — **not proved: stalls** at the selection of a point with connected pieces of two classes through it. Stage 3,
  § The stall.
- C132-GRUNDY7-NOT — no order makes the hexagonal colouring (circumradius 2/5), the island colouring or the stripe colouring
  a Grundy colouring. [hand], one mind. Stage 4.
- C132-GRUNDY7-LOCAL — for an order beginning with a label of the slack vertex, some output of the Grundy construction has
  one label on the whole slack ball. [hand], one mind. Stage 4.
- C132-GRUNDY7 — **not proved: stalls** at its second clause, which names a family of colourings, not one. Stage 4.

## Stage 1 — SAVED: the readback, the predictions, the recognition, the statements

### 1.1 Readback of the brief

`data/fs132/e5/readback.py` checks each quotation of the brief as an exact substring of its source: **17 quotations, 17 matched,
0 mismatched**; with `--fault` (one character of the first quotation changed) it prints `mismatched=1`. No finding about the
brief's quotations.

**Read, and how far** (standing rule 10): the claim list whole, every dated line; the stub's re-posed section whole; the asking
lane's Stages 1 and 2 whole; `plans/FS132-E3-derivation.md` Stage 3 whole (M0–M9 and the route table; M4–M6 reworked by hand,
M7–M9 read line by line and not reworked); `plans/FS132-E2-derivation.md` Stage 3, the entries C132-ORBIT to C132-RING-TAME and
the arguments "the orbit index", "one-sided pure strips", "the unit chord's angle" (the rest of that stage not read);
`plans/FS132-E1-derivation.md` Stage 3 whole (S0–S11 read; S2, S7's mesh step and S9 reworked, because Stage 3 here stands on
them); `plans/EXT-OAI2-reading.md` § 5.6 with its two arguments (the rest not read); `plans/FS121-D3-proof.md` § 2.1–2.2 (the
construction and its entry; the rest not read); `LEDGER.md` row 143 as quoted in the brief (rows 140–142 **not read**);
`plans/FS132-close-inventory.md` **not read** (the claim list's dated lines carry the same items; a debt, named in the report);
of the manuscript, `M/palettes.tex:60–125` (Definition 5.1's closing paragraphs and Lemma 5.2's statement) and
`M/angular.tex:60–100` (the end of Lemma 8.1's proof); `M/interfaces.tex` **not opened** — the proof of clause (3) is taken from
the first deriver's S7 and S9, which rework it, and that is said wherever it is used.

### 1.2 Predictions, registered before the recognition was invoked

Honest about their timing: they were formed while reading the inputs and before `ephodos-recognition` was invoked or any
argument was written; nothing was derived before them.

| claim | prediction | probability | the decision it bears on |
|---|---|---|---|
| C132-WIT, the exclusion | derived, and as an instance: a two-point set is a compact set through `p` with a second point, so no step can read more | 0.95 | whether Stage 2 walks M0–M9 for a restatement or for a check |
| C132-WIT, the strips | derived, with the changes of side where the ring point is at distance 1 from `q_j` | 0.90 | whether C132-TRI-STRIP's limiting directions are a hypothesis or a choice of witness |
| C132-WIT-EX | derived 0.10; stalls 0.75; refuted by formula 0.05; in any case a defect of the statement found (a witnessed cycle at a point that is no centre) 0.80 | — | whether Stage 3 argues for a proof, for a colouring, or for a restatement |
| C132-GRUNDY7 | its first clause derived 0.90, and thinly (it fails already for the unmodified hexagonal colouring); its second clause not a statement as posed (the construction is a choice) 0.85; some form of the second clause derived 0.30 | — | whether Stage 4 computes on two colourings or rules on a class |

### 1.3 Recognition (`ephodos-recognition`, invoked fresh at this stage)

**The stall read.** None of my own yet; the card's is "an answer found and not derived" on one side (three records each found
that their arguments read one further point per edge) and "a known theorem that almost applies" on the other (the extraction,
whose one failing hypothesis is the isolation of the centre).

**For the stranger** (a convex geometer who works on ball hulls and distance-avoiding sets; nothing of this project's
vocabulary). *A measurable partition of the plane into `k` classes is given, each class meeting almost none of its unit
translates. `H_i` is the closed essential support of class `i`. For two points `p ≠ q` let `Δ(p, q)` be the set of `z` with
`min(|z − p|, |z − q|) < 1 < max(|z − p|, |z − q|)`: the two open lunes between the unit circles about `p` and about `q`. For a
label `i` put `Q_i(p) = {q : H_i ∩ Δ(p, q) = ∅} ∪ {p}`. Then `Q_i(p)` is the set of `q` within 1 of every point of
`H_i ∩ B(p, 1)` and at least 1 from every point of `H_i ∖ B̄(p, 1)`: the intersection of the closed unit discs about the points
of `H_i` inside the unit disc of `p` with the complements of the open unit discs about the points of `H_i` outside it.
Unknown: is there, in every closed disc of radius above 1, a point `p` and a cyclic sequence of at least three distinct labels
such that consecutive labels `i, i′` have `Q_i(p) ∩ Q_{i′}(p) ≠ {p}`?* The reader stops at no word. **This is a** question about
the *ball-polar* (the unit-ball dual, the first step of the ball hull, of spindle convexity) of the part of each support inside a
unit disc, cut by the unit neighbourhood of the part outside.

**What the write-up shows that the card's words did not.** For `q` near `p` the set `Δ(p, q)` is two thin lunes along the unit
circle of `p`, at distance about 1 from `p`: in direction `f` from `p` it lies outside the circle where `f·(q − p) > 0` and
inside where `f·(q − p) < 0`, with thickness about `|f·(q − p)|`. **Nothing in the definition is near `p`.** So "a witnessed
cycle at `p`" is a property of the unit circle about `p` — which labels' supports keep off which side of it — and says nothing of
which labels meet at `p`, nor that any do.

**The features, sorted** (each with its receipt; Stage 2 and Stage 3 carry the arguments and the controls).

| feature of "an extracted centre" | sort | receipt |
|---|---|---|
| a point `p` and a cycle of `ℓ` labels | determines | every statement at issue is about them |
| for each edge, one point `q_j ≠ p` with both labels' supports off `Δ(p, q_j)` | determines | C132-M-ORBIT's M4–M6 consume `p ∈ K`, `K ≠ {p}` and the exclusion, point by point (Stage 2); the strips consume one `q` (Stage 2) |
| the rest of `K_j` | accompanies | `Δ({p, q}) ⊂ Δ(K)` for `{p, q} ⊂ K`: the two-point hypothesis is the weaker one, and a two-point set is itself an admissible `K` (Stage 2) |
| connectedness of `K_j` | accompanies, at the consumers; **determines, at the source** | no step of M0–M9 or of the strips reads it; the proof of clause (3) reads the connectedness of the *approximating* sets (S9), which is where witnesses come from (Stage 3) |
| the limiting direction `v_j` | accompanies, split | consumed only through "some point of `K_j` lies inside the unit circle about the ring point `x + e`", which a fixed `q` gives at the directions with `2e·(q − x) > |q − x|²` (Stage 2, control `strip-sides`) |
| `K_j ⊂ H_{i_j} ∩ H_{i_{j+1}}` (clause (4)), the labels present at `p` | accompanies | no consumer reads it; in the hexagonal seven-colouring every point within 0.01 of a vertex carries a witnessed triangle of the vertex's labels (Stage 3, control `margin-witness`) |
| `p` a cyclic centre; `p` isolated among the centres | accompanies, at the consumers | the same control: those points are not centres |
| six labels | determines | M2 and M9 spend it (the first night's entry; not re-derived) |

**Homes, several.** (1) *This project's own*: `Forces`/`Separated` are not it; the home is C132-CONFINE (a set that misses a
straddle set lies on one side of every unit circle about a support point) — the witness is C132-CONFINE's hypothesis at its
smallest instance. (2) *Convexity*: the ball-polar and spindle convexity (Mayer's "Überkonvexität"; Bezdek, Lángi, Naszódi and
Papez's ball-polyhedra — recalled, not read): `Q_i(p)` is a ball-polar cut by exteriors; what that field holds (the ball hull
is the intersection of the unit discs containing the set; a set and its ball-polar have constant-width completions) decides
nothing here, because the question is whether two labels' polars share a second point, a statement about the partition. (3)
*Dimension theory*: Lebesgue's covering theorem for the cover by the components of the smoothed classes — the home of
C132-CORES-FREE; it gives a point of multiplicity three at every scale and says nothing of the diameters of pairwise
overlaps, which is what a witness needs (Stage 3 names this as the stall). (4) *Graph colouring*: Grundy and fall colourings
(row 143's home), for the third claim: a Grundy colouring is a sequence of relatively maximal independent sets, and the
finite theory's first fact carries over — the output of the greedy procedure is not a function of the input.

**The recognition, where it differs from the plan's.** The asking lane takes the object to be *a point with a witnessed cycle*
and asks whether such points exist without a hypothesis on the centres. The description under which the first claim is forced
is smaller and sits elsewhere: **the object is a unit circle with a cyclic list of labels kept off its lunes**. Under it:
(i) C132-WIT is not a widening but the same theorem (an instance one way, monotonicity of `Δ` the other); (ii) the existence
claim comes apart into two — witnesses that a *margin* gives (three labels absent from an annulus about a unit circle; free in
every colouring with local slack, and found at points that are no centres) and witnesses that *connected pieces* give (the
extraction's source); a proof of existence in general must cover colourings with neither, and a refutation must have neither
at every point of a disc; (iii) what the road's existence step needs from a centre is not a witness but its class in the
label graph, which no witness carries. (iii) is a remark for the asking lane, not a claim of mine.

### 1.4 The statements, as my verdicts will be about them (sent to the coordinator)

**C132-WIT** — three statements, each with a verdict of its own; the claim as posed is their conjunction.
- **C132-WIT-ORBIT.** C132-M-ORBIT's statement (`plans/FS132-E3-derivation.md` Stage 3) with "for each j modulo 4 let K_j be a
  compact set containing p and a point other than p with H_{a_j} ∩ Δ(K_j) = ∅ and H_{a_{j+1}} ∩ Δ(K_j) = ∅" replaced by "for each
  j modulo 4 let q_j be a point other than p with H_{a_j} ∩ Δ({p, q_j}) = ∅ and H_{a_{j+1}} ∩ Δ({p, q_j}) = ∅".
- **C132-WIT-EXCL.** C132-M-EXCL's statement with the same replacement.
- **C132-WIT-STRIP.** Let k ≥ 3 be an integer, x a point, U an open set containing the unit circle about x, c a weak measurable
  k-colouring of U, i_0, i_1, i_2 three distinct labels, N the set of the other k − 3 labels, and for each j modulo 3 let q_j
  be a point other than x with H_{i_j} ∩ Δ({x, q_j}) = ∅ and H_{i_{j+1}} ∩ Δ({x, q_j}) = ∅; then for every unit vector e with
  |x + e − q_j| ≠ 1 for j = 0, 1, 2 there are an arc A about e and a width w > 0 such that almost every point x + r f with f
  in A and 1 < r < 1 + w has its label in N if |x + e − q_j| < 1 for at least two j, and almost every point x + r f with f in
  A and 1 − w < r < 1 has its label in N if |x + e − q_j| > 1 for at least two j; the unit vectors f with |x + f − q_j| = 1 for
  some j are those with 2 f·(q_j − x) = |q_j − x|², at most six; and P_x(e), read with samplings inside U, meets N for almost
  every e.

**C132-WIT-EX** — as posed, with the definition written out. For every integer k ≥ 1, every weak measurable k-colouring of the
plane and every closed disc D of radius greater than 1, there are a point p of D, an integer ℓ ≥ 3, distinct labels
i_0, …, i_{ℓ−1} and points q_0, …, q_{ℓ−1} other than p such that for each j modulo ℓ the closed essential supports H_{i_j} and
H_{i_{j+1}} both miss Δ({p, q_j}). I shall also say what holds of the **anchored** form (in addition `p ∈ H_{i_j}` and
`q_j ∈ H_{i_j} ∩ H_{i_{j+1}}` for every j), because the form as posed is met at points where none of the labels is present.

**C132-GRUNDY7** — the posed sentence has two clauses, and my verdicts will be about these:
- **(i)** for no order of the seven labels is the hexagonal seven-colouring with circumradius 2/5, the island colouring
  (EXT-OAI2-SLACK7-L) or the stripe colouring (EXT-OAI2-SLACK7-P) a Grundy colouring in FS121-D3-GRUNDY's sense;
- **(ii)** as posed, "the Grundy-ization of each … has finitely many cyclic centres in every disc and finitely many changes on
  every ring" — FS121-D3-GRUNDY's construction takes each class by Zorn's lemma, so "the Grundy-ization" names a family of
  colourings; I rule on **(ii-some)**: for some order, some output of the construction on each colouring has the two finiteness
  properties; and **(ii-every)**: every output, for every order, has them.

*Gate at this stage*: `derive_gate.py all` reports one failure, "no derivation entry" — expected, since this stage derives
nothing; the first entries are Stage 2's.

## Stage 1 — SAVED

## Stage 2 — SAVED: C132-WIT

**Verdict: derived**, in three statements. The exclusion's two are the first night's theorems restated and nothing more: the
two-point form is an instance of each, and each follows from its two-point form. The strips' is a wider statement than
C132-TRI-STRIP, which becomes its corollary. No step of either argument reads a second point of a set besides the centre, its
connectedness, its compactness, a limit of its points or a limiting direction; the one place a limit of points was written
(the strips) reads it only to find a single point on the right side of one unit circle.

### The entries

derivation: C132-WIT-ORBIT
  statement: let U be an open set of the plane containing the closed unit disc about a point p, let c be a weak measurable six-colouring of U (a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair (z, u) of a point z of U and a unit vector u with z + u in U), let a_0, a_1, a_2, a_3 be four of the labels and X, Y the other two, and for each j modulo 4 let q_j be a point other than p with H_{a_j} ∩ Δ({p, q_j}) = ∅ and H_{a_{j+1}} ∩ Δ({p, q_j}) = ∅, where H_a is the closed essential support of the class of a and Δ(K) is the set of z with min over q ∈ K of |z − q| below 1 and max over q ∈ K of |z − q| above 1; then there are no angle ψ and number δ > 0 such that (i) for every integer k and almost every θ with |θ − ψ − kπ/3| < δ the palette P_p(e(θ)) (`[OAIMath2026]` Definition 5.1, read at the centre p with samplings inside U) contains X or Y, and (ii) for every η > 0 the set of θ in (ψ − η, ψ + η) whose palette contains X and the set of those whose palette contains Y both have positive measure
  uses only: C132-M-ORBIT (`plans/FS132-E3-derivation.md` Stage 3) at K_j = {p, q_j}, a compact set containing p and a point other than p; nothing else. Read against its argument step by step (§ The exclusion, step by step): of the sets it reads, for each j, that p is in the set, one point q_j of it other than p, and the two-label exclusion for the pair {p, q_j}
  not claimed: more than C132-M-ORBIT — this is that theorem, not a wider one: C132-M-ORBIT follows from it by taking any q_j in K_j other than p, since Δ({p, q_j}) ⊂ Δ(K_j) (control `delta-monotone`); what C132-M-ORBIT does not claim; that the labels a_j are present at p or anywhere near it (nothing in the hypotheses says so, and nothing in the argument uses it); a second reading of M7 to M9, which I read and did not rework
  argument: § The exclusion, step by step
  verdict: derived
  grade: derived from: C132-M-ORBIT
  minds: 1
  model: none can exist (a non-existence). The hypotheses on the q_j alone are met with room at every point p within 0.01 of a vertex of the hexagonal seven-colouring, for the vertex's three labels and every q_j within 0.012 of p (control `margin-witness`, Stage 3) — at seven labels, where the statement does not apply
  prior art: partly: as C132-M-ORBIT's own line (`plans/FS132-E3-derivation.md` Stage 3); the restatement is this project's; owed — three zbMATH queries on 2026-10-07 05:26 UTC answered 503 (§ Prior art, this job)
  handoff: none — subsumed by C132-M-ORBIT, which crosses; what the kernel lane should take from this entry is that its hypothesis may be stated with four points q_j in place of four compact sets, losing nothing

derivation: C132-WIT-EXCL
  statement: let U, p, c, the labels a_0, a_1, a_2, a_3, X, Y and the points q_0, q_1, q_2, q_3 be as in C132-WIT-ORBIT; then it is not the case that for almost every unit vector e the palette P_p(e) contains X or Y
  uses only: C132-M-EXCL at K_j = {p, q_j}
  not claimed: more than C132-M-EXCL (it follows from this entry as C132-M-ORBIT does from C132-WIT-ORBIT); what C132-M-EXCL does not claim
  argument: § The exclusion, step by step
  verdict: derived
  grade: derived from: C132-M-EXCL
  minds: 1
  model: none can exist (a non-existence); the model line of C132-WIT-ORBIT. An instance worth its sentence: no weak measurable six-colouring of an open set containing a closed unit disc carries only two labels, almost everywhere, on an annulus about the unit circle — the four absent labels are witnessed at the centre by every nearby point
  prior art: partly: as C132-WIT-ORBIT
  handoff: none — subsumed by C132-M-EXCL, which crosses

derivation: C132-WIT-STRIP
  statement: let k ≥ 3 be an integer, x a point, U an open set containing the unit circle about x, c a weak measurable k-colouring of U, i_0, i_1, i_2 three distinct labels, N the set of the other k − 3 labels, and for each j modulo 3 let q_j be a point other than x with H_{i_j} ∩ Δ({x, q_j}) = ∅ and H_{i_{j+1}} ∩ Δ({x, q_j}) = ∅; then for every unit vector e with |x + e − q_j| ≠ 1 for j = 0, 1, 2 there are an arc A about e and a width w > 0 such that almost every point x + r f with f in A and 1 < r < 1 + w has its label in N if |x + e − q_j| < 1 for at least two j, and almost every point x + r f with f in A and 1 − w < r < 1 has its label in N if |x + e − q_j| > 1 for at least two j; the unit vectors f with |x + f − q_j| = 1 for some j are those with 2 f·(q_j − x) = |q_j − x|², at most six; and P_x(e), read with samplings inside U, meets N for almost every e
  uses only: that an open set missing H_i meets the class of i in a null set; |x + r f − q|² = r² + |q − x|² − 2 r f·(q − x) and its continuity in (r, f); that two edges of a triangle have all three vertices among their endpoints; for the last clause the end of the proof of `[OAIMath2026]` Lemma 8.1 (`M/angular.tex:71–88`, read: radii tending to 1 from the pure side through typical samplings at the centre x; no count of labels), taken for a colouring of U on the first night's local reading of the palettes (one mind, `plans/FS132-E3-derivation.md` M0)
  not claimed: purity of both sides at one direction; that P_x(e) lies inside N; anything at the at most six excluded directions; that the labels i_j are present at x; that a point x with such q_j is a cyclic centre (it need not be: control `margin-witness`, Stage 3); anything for a cycle of four or more labels; that the class is inhabited at six
  argument: § The strips, with one witness per edge
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7, the hexagonal seven-colouring with circumradius 2/5, x the vertex (0, 2/5) with labels 0, 3, 2, and q_j the point of each of its three edges at distance 0.3 from x: |q_j − x|² = 0.09, so the side changes where f·(q_j − x)/|q_j − x| = 0.15, about 8.6° from the perpendiculars, and N = {1, 4, 5, 6}; there both sides are in fact pure at every direction (the three labels keep off the annulus 0.97 ≤ |z − x| ≤ 1.03), so the model satisfies the statement with room and does not test the side rule — the control `strip-sides` does
  prior art: partly: `[OAIMath2026]` Lemma 8.1 is the strip statement at five labels for continua with limiting directions; C132-TRI-STRIP (`plans/FS132-E2-derivation.md` Stage 3) is its form at every k for a triangle; the form with one witness per edge and the side rule |x + e − q_j| ≷ 1 not found — owed (§ Prior art, this job)
  handoff: de Bruijn — as C132-TRI-STRIP's general form: three points in place of three continua with limiting directions; the leaf is one inequality on |x + r f − q| and a case split on three signs. C132-TRI-STRIP then follows by choosing, for each direction, a witness close enough to x (§ The strips, last paragraph)

derivation: C132-WIT
  statement: C132-M-ORBIT, C132-M-EXCL and C132-TRI-STRIP with each set `K_j` replaced by a two-point set `{p, q_j}` — for the strips, with the changes of side at the directions `f` with `2 f·(q_j − x) = |q_j − x|²`
  uses only: C132-WIT-ORBIT, C132-WIT-EXCL and C132-WIT-STRIP, which are the three restatements written out
  not claimed: that the restated exclusions are wider than the originals (they are the same theorems); what each of the three does not claim
  argument: § The exclusion, step by step
  verdict: derived
  grade: derived from: C132-WIT-ORBIT, C132-WIT-EXCL, C132-WIT-STRIP
  minds: 1
  model: the model lines of the three
  prior art: partly: as the three
  handoff: none — the three entries carry what crosses

control: delta-monotone
  of: C132-WIT-ORBIT — the two-point hypothesis is the weaker one: the straddle set of {p, q} lies in the straddle set of every finite K containing p and q (100,000 fixed samples)
  run: python3 ../data/fs132/e5/wit_check.py mono
  expect: in-the-smaller=28434 violations=0
  fault: python3 ../data/fs132/e5/wit_check.py mono --fault

control: strip-sides
  of: C132-WIT-STRIP — the side rule: just outside the unit circle about x in direction f a point lies in the straddle set of {x, q} exactly when |x + f − q| < 1, just inside exactly when |x + f − q| > 1 (200,000 fixed samples, |q − x| between 0.05 and 2.5); the fault predicts the side by the sign of f·(q − x), the rule for a limiting direction
  run: python3 ../data/fs132/e5/wit_check.py sides
  expect: samples=200000 outer=50147 inner=149853 disagreements=0
  fault: python3 ../data/fs132/e5/wit_check.py sides --fault

### The exclusion, step by step

*What each step of C132-M-ORBIT's argument (`plans/FS132-E3-derivation.md` Stage 3, M0–M9, with the ring form and the fixed
form) reads of a set `K_j`. "Reworked" means I re-derived the step from its inputs; "read" means line by line, not re-derived.*

| step | what it reads of `K_j` | with `K_j = {p, q_j}` | my reading |
|---|---|---|---|
| M0, the toolkit | nothing | unchanged | read |
| M1, the state | nothing | unchanged | reworked |
| M2, the chart and (⋆) | nothing | unchanged | reworked (`|Z| = 2cos(π/3 + d/2)`, and the two unit partners on the circle) |
| M3, every hub has a tip | nothing; it defines `Tip(k)` by the support of a label inside the unit disc | unchanged | reworked |
| M4, confinement | `p ∈ K`, and then **each point `q` of `K` on its own**: for `z_n ∈ H_a`, `|z_n − p| < 1`, the exclusion at the pair `{p, q}` gives `|z_n − q| ≤ 1`; the limit is in `n`, not in `q` | `q_j ∈ B̄(y_k, 1)` for `j` an index of a set of the tip, hence `q_j·e(ψ_k) > 0` | reworked |
| M5, one tip, opposite at antipodes | that each `K_j` holds a point other than `p`: one point | `q_j` cannot lie in `B̄(y_k, 1) ∩ B̄(−y_k, 1) = {p}` | reworked |
| M6, three axes | "Pick `q_j ∈ K_j`, `q_j ≠ 0`": one point per set, and the signs of M4 | the points `q_j` are the hypothesis | reworked, with its case list; the count of 64 patterns is the first night's control, not rerun |
| M7, the unit-pair relation | nothing | unchanged | read |
| M8, Lemma S (the density lemma) | nothing — it is a statement about the function `s` on an interval and the relation (†), which comes from properness, M5 and M6 | unchanged | read; not reworked — its constants (`3/4`, `3ρ/16`, `(9/16)ρ`) I checked for arithmetic only |
| M9, the kill | nothing | unchanged | read |
| the ring form | nothing | unchanged | reworked |
| the fixed form | clause (1) of the extraction, as "`K_j ≠ {p}`" | not needed: `q_j ≠ p` is the hypothesis | reworked |

**So**: the argument consumes of the four sets exactly the four pairs `{p, q_j}` and the two-label exclusion at each. It does
not read compactness either (the minimum and maximum in `Δ` are over two points). A two-point set `{p, q_j}` is a compact set
containing `p` and a point other than `p`, so C132-WIT-ORBIT is C132-M-ORBIT at such sets; and for any compact `K_j ∋ p` with
another point `q_j`, `Δ({p, q_j}) ⊂ Δ(K_j)` (a smaller set has a larger minimum and a smaller maximum), so the hypothesis of
C132-M-ORBIT gives that of C132-WIT-ORBIT. **The two are one theorem.** The same for C132-M-EXCL, whose argument adds only
Cor. 5.4 and a connectedness argument on the circle of directions. The asking lane's `generalization` item for this
(`plans/POROS-2026-10-07-fs132-night.md` § 1.3, finding A) is therefore a restatement, not a generalization; what is new in it
is the description of the hypothesis, which Stage 3 uses.

**Where the falsifier could have fired and did not.** The card's falsifier: "a step of C132-M-ORBIT's M0–M9 … that reads a
second point of one set, its connectedness or a limit of its points". M4's "in the limit `K ⊂ B̄(y_k, 1)`" is a limit of the
support points `z_n → y_k`, not of points of `K`. No step fires it.

### The strips, with one witness per edge

Translate so `x = 0`. Fix `j` and write `q = q_j`, `i, i′` for its two labels. For a unit vector `f` and `r > 0`,

> `|r f − q|² = r² + |q|² − 2 r f·q`,

which at `r = 1` equals 1 exactly when `2 f·q = |q|²`: the two points (one if `|q| = 2`, none if `|q| > 2`) where the unit
circle about `q` meets the unit circle about 0. That is the list of excluded directions, at most two for each `j`.

Let `e` be a unit vector with `|e − q| ≠ 1`. *If `|e − q| < 1`*: by continuity there are an arc `A_j` about `e` and `w_j > 0`
with `|r f − q| < 1` for `f ∈ A_j`, `1 < r < 1 + w_j`; such a point is farther than 1 from 0 and nearer than 1 to `q`, so it
lies in `Δ({0, q})`. Shrinking `A_j` and `w_j`, the closed strip lies in `U` (the unit circle is compact and `U` open). The
open strip misses `H_i` and `H_{i′}`, so the classes of `i` and `i′` are null on it. *If `|e − q| > 1`*: the same with
`1 − w_j < r < 1`, where the point is nearer than 1 to 0 and farther than 1 from `q`. (Control `strip-sides`; its fault, the
perpendicular rule, disagrees on a quarter of the samples.)

Now let `e` have `|e − q_j| ≠ 1` for all three `j`. Of the three signs of `1 − |e − q_j|` two agree, say for `j` and `j′`.
The edges `j` and `j′` of the triangle have `i_0, i_1, i_2` among their endpoints, so on the common strip — the arc
`A_j ∩ A_{j′}`, the width `min(w_j, w_{j′})`, on the outer side if the common sign is `+` and the inner if `−` — all three
labels are null and almost every point has its label in `N`. That is the first two clauses.

*The palette clause.* The unit vectors outside the at most six excluded ones are covered by countably many arcs on each of
which one side is pure with a fixed width. The end of the proof of the manuscript's Lemma 8.1 (`M/angular.tex:71–88`) then
runs as written: for each such arc the restriction "label in `N`" holds for almost every direction of the arc at almost every
radius of the pure side's interval; intersect with the full-measure set of radii `r` for which `(x, r)` is a typical sampling;
take radii tending to 1 from the pure side; a weak-* limit is a trace in `𝒲_x`, its coordinates outside `N` vanish on the arc,
its coordinates sum to 1, and its positive coordinates lie in `P_x` almost everywhere. So `P_x(e) ∩ N ≠ ∅` for almost every `e`
of the arc; countably many arcs. ∎

**C132-TRI-STRIP as its corollary.** Let `x`, `K_j`, `v_j` satisfy clauses (1)–(3) of C132-EXT-DISC with `ℓ = 3`, and let `e`
be perpendicular to no `v_j`. For each `j` take `q_j = q_{j,m} = x + s w ∈ K_j` with `w` so near `v_j` that `e·w` has the sign
of `e·v_j` and `|e·w| > |e·v_j|/2`, and `s < |e·v_j|`: then `|x + e − q_j|² − 1 = s(s − 2 e·w)` has the sign opposite to
`e·v_j`, and `Δ({x, q_j}) ⊂ Δ(K_j)`. C132-WIT-STRIP at these three witnesses is C132-TRI-STRIP's conclusion at `e`. The
witnesses depend on `e`; the conclusion is local in `e`, so that costs nothing. **What the limiting direction was for**: to
supply, for every direction off the perpendicular, a witness on the wanted side of one unit circle. With witnesses fixed in
advance the side is decided by the witness, and the six changes of side move from the perpendiculars of the `v_j` to the
directions `f` with `2 f·(q_j − x) = |q_j − x|²` — at angle `arccos(|q_j − x|/2)` from `q_j − x`, which tends to the
perpendicular as `q_j → x`. The card's reading of this identity
(`plans/POROS-2026-10-07-fs132-night.md` § 1.3, "an outer strip where `f·w > s/2` and an inner strip where `f·w < s/2`") is
confirmed.

**For the ring card's deriver** (a remark, not a claim of mine): C132-COMP's proviso "in a direction perpendicular to none of
that centre's three limiting directions" may be read, with witnesses in place of continua, as "at a distance other than 1
from each of that centre's three witnesses".

### Prior art, this job

Three queries to the zbMATH Open API on 2026-10-07 05:26 UTC, each answered **503** (as for the first night's three derivers):
`("measurable coloring" | "measurable colouring" | "measurable chromatic number") & plane & py:2024-2026`;
`("ball hull" | "spindle convex" | "ball-polyhedra") & ("unit distance" | "chromatic number")`;
`("Grundy" | "fall coloring" | "fall colouring") & (measurable | Borel)`. **A prior-art debt**, carried with the milestone's: no
statement of this record was searched for in print. Mayer's and Bezdek–Lángi–Naszódi–Papez's work on spindle convexity is
recalled, not read, and nothing here rests on it.

## Stage 2 — SAVED

## Stage 3 — SAVED: C132-WIT-EX

**Verdict: stalls**, at a step named below, with five statements derived on the way. In one paragraph: the statement as
posed is **free wherever a colouring has a margin** — three labels whose supports keep off an annulus about one unit circle —
and every colouring by formula this record can test has one, the two slack colourings included, at points that are not
centres; it is **derived, in its anchored form and at a centre, on every disc with finitely many cyclic centres**; and for a
colouring with no margin and infinitely many centres in a disc it is neither derived nor refuted. The step that will not go
is not the proof of the exclusion: that step, redone here, needs only connected pieces of one smoothed class and reads no
hole, no centre and no isolation (C132-WIT-SUPER). It is the step before it — producing, at some point, connected pieces of
two classes that share that point and a second one.

### A relay from the coordinator, first (2026-10-07, on the ring card's C132-CROSS)

*Relayed:* the ring card's deriver has derived C132-COMP through C132-CROSS (`plans/FS132-E4-derivation.md` Stage 2), whose
step B1 uses the strips with a fixed witness — a set is "outer-blocked" at a ring point `w` if some `q` of it has
`|w − q| < 1`, "inner-blocked" if `|w − q| > 1` — and the entry that crosses to the kernel lane for the strips is to be mine;
if the two come out differently, say which is right. **Read: B1 (ll. 253–263 there) and the two definitions (ll. 142–150).
They agree with C132-WIT-STRIP's side rule, word for word in substance**: outer side excluded where `|w − q| < 1`, inner
where `|w − q| > 1`, nothing where `|w − q| = 1`. Two differences of form, both to B1's credit and both repaired here:
(i) B1 is stated edge by edge, for any set `E` of labels excluded at a pair, where C132-WIT-STRIP is stated for a triangle;
(ii) B1 reads **no properness** — the strip clauses hold for any measurable labelling — where C132-WIT-STRIP assumes a weak
colouring, which only its palette clause uses. **How it changes my work**: the edge-level statement is entered below as
C132-WIT-SIDE, at the class the argument carries, and it is the entry that should cross for both consumers; C132-WIT-STRIP's
first two clauses are C132-WIT-SIDE applied three times, and C132-CROSS's B1 is C132-WIT-SIDE verbatim. Nothing in Stage 2
is withdrawn.

### The entries

derivation: C132-WIT-SIDE
  statement: let U be an open set of the plane, c a measurable map from U to a finite set of labels, H_i the closed essential support of the class of i, E a set of labels, x and q two distinct points with H_i ∩ Δ({x, q}) = ∅ for every i in E, and w a point of U with |w − x| = 1 and |w − q| ≠ 1; then there is η > 0 such that almost every point z of B(w, η) with |z − x| > 1 has its label outside E if |w − q| < 1, and almost every point z of B(w, η) with |z − x| < 1 has its label outside E if |w − q| > 1
  uses only: that {z : |z − q| < 1 < |z − x|} and {z : |z − x| < 1 < |z − q|} are open and lie in Δ({x, q}); that an open subset of U missing H_i meets the class of i in a null set. No properness, no palette, one witness
  not claimed: anything when |w − q| = 1; anything about the other side of the unit circle about x; that the labels of E are present anywhere
  argument: § Argument — one side of a unit circle
  verdict: derived
  grade: hand
  minds: 1
  model: the model of C132-WIT-STRIP, edge by edge
  prior art: partly: it is step B1 of the ring card's C132-CROSS (`plans/FS132-E4-derivation.md` Stage 2, derived the same night by another mind) and the first paragraph of C132-TRI-STRIP's argument with its point held fixed; in print, the mechanism of `[OAIMath2026]` Lemma 8.1 for continua; this form owed
  handoff: de Bruijn — the statement as written; it is the leaf under C132-WIT-STRIP, C132-TRI-STRIP and C132-CROSS, and by the coordinator's ruling the entry that crosses for the strips

derivation: C132-WIT-MARGIN
  statement: let c be a measurable map from the plane to a finite set of labels, H_i the closed essential support of the class of i, p a point, η > 0, and I a set of labels each of whose supports H_i misses the open annulus of the points z with 1 − η < |z − p| < 1 + η; then H_i ∩ Δ({p, q}) = ∅ for every i in I and every point q with 0 < |q − p| ≤ η; so if I has at least three labels, every cyclic order of three or more of them, with any such points q_j, satisfies the conclusion of C132-WIT-EX at p
  uses only: the triangle inequality — a point z with one of |z − p|, |z − q| below 1 and the other above 1 has | |z − p| − 1 | < |q − p|
  not claimed: that p is a cyclic centre, or that any label of I is present at p (control `margin-witness`: thirteen points about a vertex, twelve of them no centres); that every weak colouring has such a point; the anchored form
  argument: § Argument — witnesses by margin
  verdict: derived
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring with circumradius 2/5, and the island and the stripe colourings built on it at a vertex v: every p within 0.01 of v, I the three labels of v, η = 0.012 (control `margin-witness`); in the plain colouring the same at every vertex
  prior art: owed — elementary; the statement is this project's
  handoff: none — a relay-result: it says where C132-WIT-EX is free, and that a witnessed cycle does not locate a centre

derivation: C132-WIT-CROSSED
  statement: let H be a set of the plane, p a point and f_1, f_2, f_3 three distinct unit vectors such that each point p + f_m is a limit of points of H nearer than 1 to p and a limit of points of H farther than 1 from p; then no point q other than p has H ∩ Δ({p, q}) = ∅
  uses only: the definition of Δ; that two distinct points have at most two points at distance 1 from both
  not claimed: anything when H approaches the unit circle about p from both sides at two points only — then the one candidate is q = p + f_1 + f_2; anything for a set that touches the circle from one side
  argument: § Argument — a label that crosses the circle has no witness
  verdict: derived
  grade: hand
  minds: 1
  model: H a hexagon of label 3 of the hexagonal seven-colouring and p the centre of the neighbouring hexagon of label 0: H crosses the unit circle about p along an arc (the fault of control `margin-witness`: with the thirteen points taken about a hexagon's centre, 327,600 samples of the annulus carry a vertex label)
  prior art: owed — elementary
  handoff: none — a relay-result: with C132-WIT-MARGIN it says which labels can be witnessed at a point, from the trace of their supports near its unit circle

derivation: C132-WIT-SUPER
  statement: let k ≥ 1 be an integer, c a weak measurable k-colouring of the plane, i a label, p_i^ε(z) the proportion of the disc of radius ε about z lying in the class of i, α > 0, (ε_n) a sequence of positive numbers tending to 0, C_n connected sets with p_i^{ε_n} > α at every point of C_n, and K the set of the limits of convergent sequences (z_n) with z_n in C_n; then no point of the closed essential support H_i has one point of K nearer than 1 and another farther than 1
  uses only: weak properness in the form |A_i ∩ (A_i − u)| = 0 for every unit vector u (from almost every u by continuity of translation in L¹), which gives p_i^ε(y) + p_i^ε(z) ≤ 1 at every unit pair (y, z); that a connected set with a point nearer than 1 to z and a point farther than 1 has a point at distance 1; p_i^ε → 1 on the class and 0 off it in L¹ on bounded sets. One label; no second label, no map to a graph, no hole, no cyclic centre, no isolation, no count of labels
  not claimed: that K has more than one point for any choice of the C_n — where a class is dust near a point every such K through it is that point (§ The stall); anything for sets C_n that are connected only after holes are filled
  argument: § Argument — connected pieces of a smoothed class carry the exclusion
  verdict: derived
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring with circumradius 2/5, label 0, α = 1/4, C_n the closed hexagon of centre (0, 0) for every n (the proportion is at least 1/3 at each of its points once ε_n < 0.3): K is that hexagon, and the conclusion is its margin — diameter 0.8, every other hexagon of label 0 more than 1.03 away
  prior art: partly: it is the proof of clause (3) of `[OAIMath2026]` Proposition 7.1 as the first deriver reworked it (`plans/FS132-E1-derivation.md` S2, S7, S9; `M/interfaces.tex` not opened by this job), with the fibre of the graph map replaced by any connected subset of one superlevel set, which removes the holes and with them every use of the centres; that form owed
  handoff: de Bruijn — beside the release's `continuum_limit_support_exclusion` and `diskAverage_unit_pair` (named by the first deriver as general in the label type): the same proof with the hypothesis "connected, inside one superlevel set"; read the formal statement back against this one

derivation: C132-WIT-EX-FIN
  statement: let k ≥ 1 be an integer, c a weak measurable k-colouring of the plane and D a closed disc of radius greater than 1 containing finitely many cyclic centres of c; then there are a cyclic centre p in the interior of D, an integer ℓ with 3 ≤ ℓ ≤ k, distinct labels i_0, …, i_{ℓ−1} forming a cycle of the transition graph of p, and points q_0, …, q_{ℓ−1} other than p such that for each j modulo ℓ the supports H_{i_j} and H_{i_{j+1}} both miss Δ({p, q_j}) and both contain p and q_j
  uses only: C132-EXT-DISC (`plans/FS132-E1-derivation.md` Stage 3) — its clause (1) for a point q_j of K_j on the circle of radius ρ about p, clause (3) with Δ({p, q_j}) ⊂ Δ(K_j), clause (4) for the two anchors, clause (5) for the cycle
  not claimed: anything on a disc with infinitely many cyclic centres; that ℓ ≥ 4
  argument: § Argument — where the centres are finite
  verdict: derived
  grade: derived from: C132-EXT-DISC
  minds: 1
  model: the model of C132-EXT-DISC — the hexagonal seven-colouring at the vertex (0, 2/5) with q_j the points of its three edges at distance 0.3
  prior art: partly: as C132-EXT-DISC
  handoff: none — subsumed by C132-EXT-DISC, which crosses

derivation: C132-WIT-EX
  statement: for every integer k ≥ 1, every weak measurable k-colouring of the plane and every closed disc D of radius greater than 1, there are a point p of D, an integer ℓ ≥ 3, distinct labels i_0, …, i_{ℓ−1} and points q_0, …, q_{ℓ−1} other than p such that for each j modulo ℓ the closed essential supports H_{i_j} and H_{i_{j+1}} both miss Δ({p, q_j})
  uses only: what is derived towards it — C132-WIT-MARGIN (it holds at every point with a margin for three labels), C132-WIT-EX-FIN (it holds on every disc with finitely many cyclic centres), C132-WIT-SUPER (it holds at every point through which, for each edge of some cycle, connected pieces of both smoothed classes pass and reach a common second point) — and nothing that covers a colouring with none of the three
  not claimed: that it is false — no colouring is offered against it, and none this record can write by formula could be one (§ The stall, last paragraph); the anchored form beyond C132-WIT-EX-FIN
  argument: § The stall
  verdict: stalls at: the selection of a point through which connected pieces of two smoothed classes pass and reach a common second point — the extraction's step S8 (`plans/FS132-E1-derivation.md`; the manuscript's `M/interfaces.tex:581–590` by that record), where an annulus about an isolated centre makes each fibre of the graph map cross from the centre's core to a fixed circle; with a second cyclic centre in every ball about the first there is no map on any annulus, and Lebesgue's covering theorem, which still gives a point of multiplicity three at every scale, bounds no diameter of a pairwise overlap from below
  grade: hand
  minds: 1
  model: where the statement is known to hold: every colouring with a margin (C132-WIT-MARGIN's model) and every disc with finitely many centres (C132-WIT-EX-FIN's). No model of its failure is known
  prior art: owed — the statement is the asking lane's; nothing to search beyond the milestone's gate, which this job did not extend (§ Prior art, this job)
  handoff: Poros — not derived; stalls at the step named; the smallest open form is § The stall, (O)

control: margin-witness
  of: C132-WIT-MARGIN — the plain, island and stripe colourings at seven: thirteen points within 0.01 of the vertex X = (0, 2/5), the annulus 0.988 ≤ |z − p| ≤ 1.012 about each (7 radii × 3600 angles): no sample carries a label of X, and the four other labels are all seen; the fault takes the thirteen points about a hexagon's centre
  run: python3 ../data/fs132/e5/margin_check.py witness
  expect: colourings=3 points=13 samples=982800 vertex-labels-on-annulus=0 labels-seen=1456
  fault: python3 ../data/fs132/e5/margin_check.py witness --fault

### Argument — one side of a unit circle

Let `|w − q| < 1`. `V = {z : |z − q| < 1 < |z − x|}` is open, and each of its points has `q` nearer than 1 and `x` farther,
so `V ⊂ Δ({x, q})` and `V` misses `H_i` for `i ∈ E`. `V ∩ U` is an open subset of `U` missing `H_i`, so the class of `i` is
null on it. `|w − q| < 1` is an open condition on `w`: there is `η` with `B(w, η) ⊂ U` and `|z − q| < 1` on `B(w, η)`, and then
`{z ∈ B(w, η) : |z − x| > 1} ⊂ V`. With `|w − q| > 1` the same for `{z : |z − x| < 1 < |z − q|}`. ∎ (Control `strip-sides`,
Stage 2.)

### Argument — witnesses by margin

Let `0 < |q − p| ≤ η` and `z ∈ Δ({p, q})`. If `|z − p| < 1 < |z − q|` then `|z − p| ≥ |z − q| − |q − p| > 1 − η`; if
`|z − q| < 1 < |z − p|` then `|z − p| < 1 + η`. Either way `z` lies in the annulus, which `H_i` misses. ∎

*The model's margins, by hand.* In the three colourings a point of a label `i` of the vertex `v` lies in the hexagon `T_i ∋ v`
(within 0.8 of `v`), in `B(v, 0.03)` (the recoloured part), or in another hexagon of label `i` (more than
`(√21 − 2)·0.4 > 1.033` from `T_i`, hence from `v`). For `|p − v| ≤ 0.01` these are within 0.81 of `p` or more than 1.023
from it; the annulus `0.988 < |z − p| < 1.012` holds none. So **every point of the closed disc of radius 0.01 about `v`
carries a witnessed triangle on the three labels of `v`, with every `q` within 0.012 of it**; in the plain colouring, the same
about every vertex. Of these points only `v` (and, in the island colouring, the points where an island's rim meets the edge)
is a cyclic centre; a point of the disc off the three edges has one label in a neighbourhood.

### Argument — a label that crosses the circle has no witness

Suppose `q ≠ p` and `H ∩ Δ({p, q}) = ∅`. Fix `m`. Points `z_n ∈ H` with `|z_n − p| < 1`, `z_n → p + f_m`, are not in
`Δ({p, q})`, so `|z_n − q| ≤ 1`, and `|p + f_m − q| ≤ 1`. Points `z′_n ∈ H` with `|z′_n − p| > 1`, `z′_n → p + f_m`, give
`|z′_n − q| ≥ 1`, and `|p + f_m − q| ≥ 1`. So the three distinct points `p + f_m` are at distance 1 from `p` and from `q`;
two distinct points have at most two such points. ∎

*Read with C132-WIT-MARGIN*: whether a label can be witnessed at `p` by a nearby point is read off the trace of its support
near the unit circle of `p` — never if it crosses the circle at three points, always if it keeps off an annulus; in between
(a support that touches the circle from one side) the side decides, as in C132-WIT-SIDE.

### Argument — connected pieces of a smoothed class carry the exclusion

*The unit-pair inequality* (the first deriver's S2, reworked). Weak properness gives `|A_i ∩ (A_i − u)| = 0` for almost
every unit vector `u`; `u ↦ |A_i ∩ (A_i − u) ∩ B|` is continuous for every ball `B`, so it is 0 for every unit `u`. For a unit
pair `(y, z)` and `h` uniform in the disc of radius `ε`, the events `y + h ∈ A_i` and `z + h ∈ A_i` then meet in a null set, so
`p_i^ε(y) + p_i^ε(z) ≤ 1`.

*The exclusion.* Let `z_0` have `q, q′ ∈ K` with `|z_0 − q| < 1 < |z_0 − q′|`, and take `q_n, q′_n ∈ C_n` with `q_n → q`,
`q′_n → q′`. There are a ball `B` about `z_0` and `n_0` such that for `n ≥ n_0` and `z ∈ B`: `|z − q_n| < 1 < |z − q′_n|`.
`C_n` is connected and `y ↦ |z − y|` continuous, so some `y ∈ C_n` has `|z − y| = 1`; `p_i^{ε_n}(y) > α`, hence
`p_i^{ε_n}(z) ≤ 1 − α`. This holds at **every** `z ∈ B` — there is no exceptional set, because nothing was filled. So
`α |A_i ∩ B| ≤ ∫_B |1_{A_i} − p_i^{ε_n}| → 0`: the class is null on `B`, and `z_0 ∉ H_i`. ∎

*What it gives the existence question.* Call a point `q` **reached from `x` in label `i`** if `x` and `q` both lie in such a
set `K` (for some `α > 0`, some `ε_n → 0`, some connected `C_n`). Then `H_i ∩ Δ({x, q}) = ∅`. So a cycle of labels is
witnessed at `x` as soon as, for each of its edges, some `q_j ≠ x` is reached from `x` in both labels of the edge — by
different connected sets for the two labels, at different thresholds if need be. The extraction's fibre components are one way
to get this (both smoothed classes exceed `α` along one connected fibre); a connected piece of each class alone is enough.

### Argument — where the centres are finite

C132-EXT-DISC gives `x ∈ 𝓛 ∩ int D`, the cycle, `ρ > 0` and the continua. Put `p = x` and take `q_j ∈ K_j ∩ ∂B(x, ρ)`
(clause (1)): `q_j ≠ p`. `{p, q_j} ⊂ K_j`, so `Δ({p, q_j}) ⊂ Δ(K_j)`, which both supports miss (clause (3)). `p, q_j ∈ K_j ⊂
H_{i_j} ∩ H_{i_{j+1}}` (clause (4)). The cycle is one of `Γ_p` (clause (5) — **the clause with one mind behind it that
contradicts a sentence of the manuscript**; it is used here for the words "forming a cycle of the transition graph" and for
nothing else). ∎

### The stall

**What is in hand, in the order of the extraction.** (a) *A point of multiplicity three at every scale, with no hypothesis*:
for `0 < α < 1/k` the components of the sets `{p_i^ε > α}` cover the plane, and by C132-WIT-SUPER's first step (with `K` two
points of one component) their diameters are at most `1 + o(1)` as `ε → 0` — the first deriver's S7 with nothing filled, so
with no exceptional set. A closed disc of radius above 1 has no such cover of multiplicity two (S6), so at every small scale
some point lies in three of the sets: this is C132-CORES-FREE's mechanism, and it reads nothing of the centres. (b) *The
exclusion from connected pieces, with no hypothesis*: C132-WIT-SUPER. (c) *Missing*: a point `x`, a cycle, and for each edge
connected pieces of its two smoothed classes that pass arbitrarily near `x` at every scale of a sequence and reach a common
point at a distance from `x` bounded below along the sequence.

**Why (a) does not give (c).** At a point of multiplicity three the three components through it overlap pairwise in open
sets, but nothing bounds those overlaps' diameters from below: four sectors `i, l, j, l′` about a point give, at every scale,
two points of multiplicity three whose `i`–`j` overlap has the diameter of the scale. The extraction answers this by taking
the whole core as one object and its boundary loop as the cycle — here the four-cycle `i, l, j, l′`, whose four overlaps are
the four rays — and to do that it needs a loop around the core on which the map to the label graph is defined: an annulus
free of other centres. With centres accumulating at every centre, cores sit inside every annulus.

**Why a class of dust defeats (b) locally.** There are measurable sets all of whose smoothed pieces shrink: nested closed
curves of a second label around a point, of thickness tending to 0 faster than their radius, leave the point a density point
of the first label while every connected subset of `{p^ε > α}` near it has diameter tending to 0 with `ε`. Planted in the
three free labels of `B(v, 0.03)` in the hexagonal seven-colouring, such a pattern is proper for the same reason the islands
are, and at its points C132-WIT-SUPER produces no witness. **The statement still holds there — by the margin**
(C132-WIT-MARGIN). So the two sources of witnesses are independent, and a colouring refuting the statement on a disc would
have to defeat both at every point of the disc.

**(O) The smallest open form.** *Is there, for some `k`, a weak measurable `k`-colouring of the plane and a closed disc `D` of
radius above 1 such that at every point `p` of `D` the graph on the labels with an edge `{a, b}` whenever some `q ≠ p` has
`H_a` and `H_b` both missing `Δ({p, q})` is a forest?* Derived necessary conditions on such a colouring: `D` contains
infinitely many cyclic centres (C132-WIT-EX-FIN); at no point of `D` do three labels have a common margin
(C132-WIT-MARGIN) — in particular it has no local slack of the hexagonal kind anywhere in `D`; and at no point of `D` is
there a cycle of labels each edge of which has a point reached in both its labels (C132-WIT-SUPER). **No colouring by formula
is offered**, and none of this record's could serve: the hexagonal seven-colouring with any circumradius strictly inside its
admissible range, and everything planted in its slack, has margins about every vertex. A tight colouring (one with no
margin anywhere) with accumulating centres is what a refutation needs; whether this project's tight seven-colourings (row
140's) have margin-free discs was not examined here. That is a question for the asking lane, not a search request: nothing
here is enumerable.

### The two controls at seven: what the statement returns

- **The island colouring's accumulation centre `v`.** The statement holds at `v` itself: the triangle of its three labels,
  witnessed by every `q` within 0.012 of `v` (C132-WIT-MARGIN; control `margin-witness`, whose first point is `v`). It also
  holds anchored: `v` lies in the three supports, a point of the 1–2 edge between two islands lies in `H_1 ∩ H_2`, and points
  of the other two edges in their supports. So the first deriver's sentence "With clauses (1)–(3) alone the straight edges do
  satisfy it at `v`" is confirmed and sharpened: the margin gives it, connectedness plays no part, and the same holds at every
  point within 0.01 of `v`, centre or not. What fails at `v` is only what C132-EXT-DISC adds: a *connected* set through `v`
  inside `H_1 ∩ H_2`.
- **The stripe colouring's unit circle.** On a disc of radius above 1 the statement returns the witnessed triangles about
  the honeycomb's vertices, as in the plain colouring; the stripes change none of them (they use the three labels of `v`
  inside `B(v, 0.03)`, where those labels already had their margin). **At the centre `x` of the striped circle it returns
  nothing on the stripe labels**: the unit circle about `x` passes through `v`, so it crosses two of the three hexagons at `v`
  along arcs, and those two labels have no witness at `x` at all (C132-WIT-CROSSED) — with the stripes or without. So the
  striped ring is the ring of a point that carries no witnessed triangle on those labels: the stripe colouring is a control
  for a palette with three labels (the reading's use of it), and is **not** a witnessed triangle whose ring changes
  infinitely often. No vertex of the honeycomb lies near enough to the unit circle about `v` to make it one (vertices are at
  distances 0.4, 0.69, 0.8, 1.06, 1.2, … from `v`; the margin about a vertex reaches 0.033).

### For the coordinator's question: what in the two-point data tells a meeting point from a margin

**Nothing in the exclusions; the anchors do, and only as far as "the labels meet", not as far as "a cyclic centre".** The
exclusion `H ∩ Δ({p, q}) = ∅` is a statement about a neighbourhood of the unit circle of `p`; that classes meet at `p` is a
statement about a neighbourhood of `p`. Adding clause (4) at the two points — `p` in the support of every label of the cycle,
`q_j` in the supports of both labels of its edge — excludes the margin points that are no meeting points (in the model, the
points of `B(v, 0.01)` off `v`). It does not give a centre: in the slack of the hexagonal colouring, let label 3 also fill a
small disc inside the hexagon of label 1 tangent to the 1–2 edge at a point `p` near `v`. Then `p` lies in all three supports,
the 2–3 edge at `v` supplies a point of `H_2 ∩ H_3`, the margin supplies every exclusion — an anchored witnessed triangle at
`p` — while labels 2 and 3 meet near `p` only at `p`, with transition area `O(|h|^{3/2})`, so the pair 23 is no edge of `Γ_p`
and `Γ_p` is a path. (Hand, one mind, no control.) What makes a centre is a property of every small ball about the point,
which no finite set of points records.

## Stage 3 — SAVED

## Stage 4 — SAVED: C132-GRUNDY7

**Verdict: the claim as posed stalls at its second clause, which is not yet a statement.** Its first clause is derived, and
thinly: no order makes either slack colouring a Grundy colouring — but none makes the *unmodified* hexagonal colouring one
either, so the clause does not test the planted slack. Its second clause speaks of "the Grundy-ization of each": the
construction takes each class by Zorn's lemma after an order has been chosen, so it names a family of colourings. Of that
family: for the orders that begin with a label of the slack vertex, **some** member has a single label on the whole slack
ball, with no centre in it and a constant ring across it (derived); that some member is tame on every disc and every ring,
or that every member is, is not derived, and the two slack colourings cannot decide it.

*Labels.* The reading's vertex `v` with labels 1, 2, 3 (islands of label 3 on the 1–2 edge) is, in the scripts, the vertex
`X = (0, 2/5)` with labels 3, 2, 0 (islands of label 0 on the 3–2 edge); the four other labels are 1, 4, 5, 6. The text below
uses the reading's names.

### The entries

derivation: C132-GRUNDY7-NOT
  statement: for no order of the seven labels is the hexagonal seven-colouring with circumradius 2/5, the island colouring (EXT-OAI2-SLACK7-L) or the stripe colouring (EXT-OAI2-SLACK7-P) a Grundy colouring in the sense of FS121-D3-GRUNDY, in which the class first in the order is maximal, up to null sets, among measurable sets with null unit pairs and each later class is maximal among such sets inside the complement of the earlier classes
  uses only: the two margins of the hexagonal colouring (two points of one hexagon at most 0.8 apart; distinct hexagons of one label more than 1.033 apart) and that the slack colourings differ from it only inside the ball of radius 0.03 about v, by labels of v; for the second reason FS121-D3-GRUNDY's step (b), which follows from the definition alone (a positive-measure set of points of a later class whose unit circles meet an earlier class in zero length could be added to the earlier class)
  not claimed: that this tells the slack colourings from the hexagonal one — it does not, and that is the finding; anything about the hexagonal colouring at circumradius 1/2, or about this project's seven-colouring R7, which FS121-D3-GRUNDY's model line says is Grundy in every order
  argument: § Argument — neither is honest, and neither is the colouring they were planted in
  verdict: derived
  grade: hand
  minds: 1
  model: the three colourings themselves; control `grundy-margins` — the hexagons of one label thickened by 0.016 hold no unit pair with 60 points just outside one of them, and the unit circles about a point of an island and about a point of a hexagon near v carry only the four labels that are not labels of v
  prior art: partly: Grundy and fall colourings of finite graphs are classical (row 143's line: Dunbar et al. 2000, by that row; not read by this job); that a colouring with a margin is not Grundy is immediate from FS121-D3-GRUNDY; owed beyond that
  handoff: none — a calibration for the asking lane's ruling on the class of C132-RING-TAME; nothing here is for the kernel

derivation: C132-GRUNDY7-LOCAL
  statement: for each of the island colouring and the stripe colouring, and each order of the seven labels beginning with one of the three labels of the vertex v, some output (A_1, …, A_7) of FS121-D3-GRUNDY's construction on that colouring in that order has the first class A_1 containing almost every point of the ball of radius 0.03 about v; in such an output no point of that open ball is a cyclic centre, and for the stripe colouring's point x the palette P_x(e) is the single first label for almost every direction e with x + e in that ball
  uses only: that the class of a label a of v together with B(v, 0.03) holds no unit pair (two points of the ball are less than 0.06 apart; a point of the ball and a point of the hexagon of a at v at most 0.83; a point of the ball and a point of another hexagon of a more than 1.003); that the construction's family at its first step contains every measurable set with null unit pairs that contains the class, and that every member lies below a maximal one (its own chain argument, FS111-M-SATC (i) by that record, not re-read); that a ball carrying one label almost everywhere has no transition between two classes, and every circle sample through it has that label's coordinate equal to 1 there
  not claimed: anything about the output outside B(v, 0.03) — the maximal extension is a choice there, and nothing bounds what it does; that every output in such an order contains the ball; anything for an order beginning with one of the four other labels; that any output has finitely many cyclic centres in every disc or finitely many changes on every ring
  argument: § Argument — some honest output erases the planted slack
  verdict: derived
  grade: hand
  minds: 1
  model: the order 3, 1, 2, 4, 5, 6, 7 on the island colouring: the first class starts from the hexagons of label 3 with the islands and is extended over B(v, 0.03), swallowing the 1–2 edge near v
  prior art: owed — the statement is this project's
  handoff: none — a calibration

derivation: C132-GRUNDY7
  statement: For no order of the seven labels is the island colouring or the stripe colouring (`plans/EXT-OAI2-reading.md` § 5.6) a Grundy colouring, and the Grundy-ization of each (FS121-D3-GRUNDY's construction) has finitely many cyclic centres in every disc and finitely many changes on every ring
  uses only: for its first clause C132-GRUNDY7-NOT; for its second, what is derived of the family the construction defines — C132-GRUNDY7-LOCAL
  not claimed: that the second clause is false in either reading — no honest seven-colouring with accumulating centres or a ring that changes infinitely often is exhibited; that it is true in either
  argument: § What the second clause is, and what is left of it
  verdict: stalls at: the second clause, at the words "the Grundy-ization of each" — FS121-D3-GRUNDY's construction lets A_m be any maximal element of a family, after an order is chosen, and its own entry does not claim uniqueness; read as "some output" the clause is derived only inside the slack ball (C132-GRUNDY7-LOCAL), read as "every output" not at all: no statement held here bounds the complexity of a relatively maximal set with null unit pairs
  grade: hand
  minds: 1
  model: what the first clause holds of — the three colourings of C132-GRUNDY7-NOT; for the second clause read as "some output", the output of C132-GRUNDY7-LOCAL inside the ball
  prior art: owed — the claim is the asking lane's
  handoff: Poros — not derived; stalls at the step named; the smallest open forms are § What the second clause is, and what is left of it, (G1) and (G2)

control: grundy-margins
  of: C132-GRUNDY7-NOT — (a) the hexagons of label 0 thickened by 0.016 against 60 points 0.008 outside the hexagon of centre (0, 0): no unit pair on 3600 angles each, and both margins hold; (b) in the island colouring the unit circles about a point of island 6 and about a point of the label-3 hexagon near the vertex carry only the labels 1, 4, 5, 6; the fault thickens by 0.1
  run: python3 ../data/fs132/e5/margin_check.py grundy
  expect: thickened-unit-pairs=0 margins=True,True ring-labels-at-island-point=1456 ring-labels-at-tile-point=1456
  fault: python3 ../data/fs132/e5/margin_check.py grundy --fault

### Argument — neither is honest, and neither is the colouring they were planted in

Fix one of the three colourings and an order. *First reason (the first class is not maximal).* Let `ℓ` be the first label
and `T` a hexagon of label `ℓ` more than 2 from `v`. Put `E = {z ∉ T : dist(z, T) < 0.016}`: a set of positive measure, in
the neighbouring hexagons, so disjoint from the class of `ℓ`. A point `z ∈ E` and a point `z′` of the class of `ℓ` or of `E`:
if `z′ ∈ T ∪ E`, `|z − z′| ≤ 0.8 + 0.032 < 1`; if `z′` is in another hexagon of label `ℓ`, `|z − z′| > 1.033 − 0.016 > 1`; if
`z′` is a recoloured point, it is within 0.03 of `v` and `|z − z′| > 1.9`. So the class of `ℓ` with `E` added has null unit
pairs: the class is not maximal. *Second reason (unbound points; the one that concerns slack).* Let `a` be the earliest in
the order of the three labels of `v`, `b` another of them. The points of label `b` within 0.01 of `v` have positive measure
(a sector of a hexagon, less the islands; or a third of the stripes). The unit circle about such a point `y` holds no point
of label `a`: those are within 0.81 of `y` or more than 1.023 from it (Stage 3, the model's margins). So a positive measure
of points of the later label `b` have unit circles meeting the class of `a` in the empty set, against step (b) of
FS121-D3-GRUNDY. ∎ Both reasons hold for the unmodified hexagonal colouring word for word. (Control `grundy-margins`.)

**What this says of the test the claim proposed.** "Is the island colouring a Grundy colouring?" is answered no by the
hexagonal colouring's own margins, before any island is planted. The slack was never planted: it is the base colouring's,
and the islands and the stripes only spend it. So the first clause cannot show that honesty removes the two pathologies.

### Argument — some honest output erases the planted slack

Let `a` be a label of `v` and `S_a` its class in the island or the stripe colouring: points of the hexagons of label `a` and
points of `B(v, 0.03)`. `S_a ∪ B(v, 0.03)` holds no unit pair, by the three distances in the entry's `uses only`. It
contains `S_a`, so it is a member of the family from which the construction takes `A_1` when `a` is first in the order; a
maximal member above it is a maximal member of the family, and the construction may take it. Continue the construction in
any way. In the output, almost every point of `B(v, 0.03)` has label `a`. Every point `z` of the open ball has a ball about
it with one label almost everywhere, so no pair of labels has a transition there and `Γ_z` has no edge: the island colouring's
centres inside the ball, and their accumulation at `v`, are gone. For the stripe colouring, a circle sample centred near `x`
with radius near 1 is, on directions `e` with `x + e` in the open ball, equal to `a` almost everywhere once the centre and
radius are close enough; so every trace has `a`-coordinate 1 there and `P_x(e) = {a}` for almost every such `e`. ∎

### What the second clause is, and what is left of it

**The defect.** FS121-D3-GRUNDY's construction: "let `A_m` be maximal, under inclusion up to null sets, among measurable `T`
with null unit pairs and `S_m ∖ (A_1 ∪ ⋯ ∪ A_{m−1}) ⊆ T ⊆ R_{m−1}`" — a maximal element by Zorn, of a family that depends on the
order chosen and on every earlier choice; its entry's `not claimed` line lists "uniqueness". C132-GRUNDY7-LOCAL already shows
three outputs of one colouring that differ on a ball (one for each label of `v` taken first). So "the Grundy-ization of each
… has finitely many cyclic centres" has no truth value until it is quantified.

**The two readings, as open statements.**
- **(G1), "some".** *For the island colouring and for the stripe colouring there are an order and an output of the
  construction with finitely many cyclic centres in every disc and finitely many changes on every ring.* Derived inside
  `B(v, 0.03)` only. What is missing is a maximal extension of a hexagon class that is explicit everywhere: a set by formula
  with a proof of maximality. This project holds one honest seven-colouring by formula (R7, by FS121-D3-GRUNDY's model line),
  but its classes do not contain the hexagonal colouring's, so it is not an output on these inputs.
- **(G2), "every".** *Every measurable Grundy seven-colouring has finitely many cyclic centres in every disc and finitely
  many changes on every ring* — the form the asking lane's ruling needs, since it wants to pose C132-RING-TAME's first
  clause "for honest colourings". Nothing here derives it or refutes it.

**What honesty does and does not remove, as far as derived.** It removes the way the two pathologies were made: in a Grundy
colouring no positive-measure set of points of one label has an earlier label free on it (step (b)), so three labels cannot
all be free in a ball, which is what the islands and the stripes spend. It is not shown to remove accumulating centres or
rings with infinitely many changes made another way.

**A reading, with its killing test (not an entry; one mind; it leans on G84's sentence "Maximality leaves bands free", whose
source rows I did not read).** A point of a later class is bound to an earlier class by *any* point of that class's support
at distance 1. Two boundary pieces of the same pair of labels that face each other at distance 1 can therefore bind each
other whatever their pattern: near two points `y_0`, `z_0` at distance 1 the unit-pair relation is, to first order, "equal
coordinate along `z_0 − y_0`", so one label on a measurable set of bands near `y_0` and on the complementary bands near `z_0`,
the other label on the rest, is proper and each band is held by its partner. If that survives the second-order terms and the
other five classes, honest colourings with rings that change infinitely often exist at seven, and the normal form for
C132-RING-TAME's first clause is not honesty. *Killing test*: a proof of (G2), or of its ring half, for Grundy
seven-colourings; *confirming test*: one Grundy seven-colouring by formula with a banded pair of facing unit arcs.

**So, for the ruling this claim was to decide** — "in which class the ring's finiteness is to be posed": this claim does not
decide it. The test it proposed is thin on its first half and undefined on its second. What can be said: honesty forbids the
*known* construction of a wild ring; it is not known to forbid a wild ring; and the calibration that would tell is a banded
honest colouring at seven, or its exclusion — (G2) and the reading above.

## Stage 4 — SAVED

## Predictions scored

| claim | registered | outcome |
|---|---|---|
| C132-WIT, the exclusion | derived as an instance, 0.95 | **met** — and more: the two forms are one theorem |
| C132-WIT, the strips | derived with the side rule, 0.90 | **met** |
| C132-WIT-EX | derived 0.10; stalls 0.75; refuted 0.05; a defect of the statement 0.80 | **stalls**; the defect found (witnesses by margin at points that are no centres) |
| C132-GRUNDY7 | first clause derived, thinly, 0.90; second clause not a statement 0.85; some form of it derived 0.30 | first two **met**; the third met only locally (C132-GRUNDY7-LOCAL), so scored **not met** as registered |

The asking lane's registered expectations (`plans/STUB-six-by-the-nerve.md`, for its own scoring): C132-WIT 0.90 — derived.
C132-WIT-EX derived 0.30, stalls 0.50, refuted 0.20 — stalls, but not where its hunch put the stall ("at the proof of clause
(3)"): that proof runs with no centre (C132-WIT-SUPER); the stall is one step earlier. C132-GRUNDY7 0.60 — its first half
holds and its second is not a statement.

## Where a successor takes over

Nothing of this record is half-done. Open, each stated as a question in its section: (O) of Stage 3; (G1), (G2) and the
reading of Stage 4. Unread by this job and worth a reader: `plans/FS132-close-inventory.md` items 3, 6, 7, 9; `LEDGER.md`
rows 140–142; `M/interfaces.tex` (the manuscript's own proof of clause (3), taken here from the first deriver's reworking);
M7–M9 of `plans/FS132-E3-derivation.md`, which I read and did not rework.
