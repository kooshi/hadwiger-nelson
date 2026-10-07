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
