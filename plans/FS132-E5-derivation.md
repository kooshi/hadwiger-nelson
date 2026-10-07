# FS132-E5 — the witness card: derivation record

*Ephodos, a derivation job in FS-132's second round (brief `data/fs132/briefs/FS132-E5-witness-card.md`, written 2026-10-07 UTC).
Three claims: C132-WIT, C132-WIT-EX, C132-GRUNDY7. One mind throughout; nothing here is blind. `M/` is the manuscript's section
folder, `/home/kooshi/source/math/preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/build/sections/`.*

## Theorems this phase proved

- Stage 1: none (the readback, the predictions, the recognition, the statements).

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
