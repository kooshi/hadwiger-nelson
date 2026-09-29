# FS121-V3 — a blind second mind on FS121-V2-SECTOR, FS121-D3-GRUNDY and FS121-D3-FALLSAT

*Job FS121-V3, briefed by Keryx on 2026-09-29 (`data/fs121/briefs/FS121-V3-verify.md`). Ephodos in its verification form: blind, the same
model (Opus 5.5) as the minds whose work this record will later be compared against. The claim list is `data/fs121/claims.md` (frozen
2026-09-29 07:03 UTC, § 6). Standing rules: `plans/STANDING-RULES.md`. Stages are saved and committed in order; the commit order is the
record of what this mind could not yet have seen.*

## Theorems this phase proved

- **FS121-V2-SECTOR** — TRUE: at a point of Σ of an honest saturated colouring with REG-J′, a colour with a region of positive angle has no
  other region there. [hand, one mind — blind, the same model] § 2.3.
- **FS121-D3-GRUNDY** — TRUE, with the maximal classes built by exhaustion (dependent choice, no Zorn). [hand, one mind — blind, the same model]
  § 2.2.
- **FS121-D3-FALLSAT** — TRUE, and the argument carries the fall property (every point outside `int supp A_j` is `j`-bound).
  [hand, one mind — blind, the same model] § 2.1.
- **Lemma S** (the shadow lemma, I-D1 re-derived) and **Lemma B** (adding a small ball) [hand, one mind] § 2.0.
- **Corollary C-π**: a region of positive angle at a point of Σ has angle at most π. [hand, one mind] § 2.3.
- **Corollary C-cusp**: two zero-angle regions of one colour at a point of Σ have collinear tangent directions. [hand, one mind] § 2.3.
- Stage 1 proved nothing.

## Would-have-searched-here log (standing rule 5)

- *(stage 1)* none: no move of this job is a search for a finite witness; every check here is a hand derivation or exact arithmetic on
  objects given by formula.
- *(stage 2)* I would have searched for a saturated colouring containing a same-colour sector and cusp (a counterexample to FS121-V2-SECTOR's
  new case) with a local-search colourer on a fine grid; instead I derived the obstruction (§ 2.3 step 2) and checked its one covering step
  exactly on one configuration given by formula (control `fs121-v3-tangent-cusp`). The GRUNDY control runs a deterministic procedure on one
  formula colouring of a lattice patch; it enumerates nothing.

## Fence log (standing rule 8)

- No fenced path has been opened, listed or searched. Searches were run only over `data/fs121/claims.md`, `data/fs111/claims.md`,
  `plans/FS111-M-regularity.md`, `plans/FS111-M2-regularity.md`, `plans/FS111-derivation.md` (entry headers and lines matching
  "sector"), `plans/FS111-M3-finiteness.md`, `plans/FS111-M4-cascade.md`, `plans/FS111-cone-scale.md`, `plans/FS111-C-close.md`,
  `plans/FS106-derivation.md`, `data/fs106/claims.md`, `CLAUDE.md` and `LEDGER.md` — all open by the brief. `plans/FS111-W-wild.md`
  was not opened. The `grep -l "^verification:" plans/*.md` run to find a record format printed four fenced *file names*
  (`plans/FS116-V1-verification.md`, `plans/FS116-V2-verification.md`, `plans/FS121-DB1-verification.md`,
  `plans/FS121-V2-verification.md`) and no content; none was opened. Logged 2026-09-29 07:10 UTC; it carried nothing.
- **Relayed fenced text, disclosed** (2026-09-29, received about 07:25 UTC, before any verdict): the coordinator's answer to my question on
  readings quoted, verbatim, the definitions of the sector lemma's proposing record (`plans/FS121-V2-verification.md` ll. 150–153, a fenced
  file): "a disc `B(z, r)` whose only point of Σ is `z` and in which the essential boundary is the finitely many interface arcs at `z`; every
  region of the fan is an open set a.e. of one colour" and "a region of positive angle has `D(W)` an open arc, a zero-angle region has
  `D(W) = ∅` and a tangent direction `φ`". It carried definitions only (no route, no verdict); it confirms the reading of § 1.3.

## Stage 1 — SAVED: the readback and the registered expectations

### 1.1 What was given before any verdict (the `given:` line in full)

- The brief, whose § The statements quotes the three statements; its mission paragraph says that two lemmas held at two minds "pass, at
  one case, through the first statement", that the other two are "the ground the milestone's cover route is about to be built on", and
  its § Fences calls `plans/FS111-W-wild.md` "FS-111's W-NOREP proof, which the first statement strengthens". No verdict, sketch, route
  or lemma of any first derivation was in it.
- The whole frozen list `data/fs121/claims.md`: its definitions (§ 0), held inputs (§ 1: M-PINCH, M2-INTRAD, FS112-N3-NOBOTH, W-NOREP,
  W-LADDER, FS-116's qualification, the controls R7, SQ9, HEX9, DISC7, DISCK7), and every other statement on it, among them **DB1-L3**
  (§ 5: "no colour occupies two sectors of positive angle, whatever cusps are present at the point or elsewhere", a round-1 proposal)
  and the names FS121-D3-SWAP1D and FS121-D1-VT, FS121-D1-EROSION.
- Open records read, by section: `data/fs111/claims.md` § 0–1; `plans/FS111-M-regularity.md` stage 2 (§ 2.1–2.6: M-SATC, M-SLACKFREE,
  M-R7, M-R7-FORCE, M-DEADLOCK) and the opening of stage 3 (the setting and M-PINCH's statement and proof steps 1–2);
  `plans/FS111-M2-regularity.md` § 1.3–1.6 and the opening of § 2.1 (MUA, M2-COV, M2-ZERO, M2-INT, M2-FIX, DISC7, KERSHNER, M2-HULLC's
  statement); the entry headers of `plans/FS111-derivation.md` and the lines of it that match "sector" (W-NOREP's statement, which
  § 1 already quotes; M-POLAR's model line "each up's 120° sector is the polar cone of its 60° arc of contact directions"; a not-claimed
  line "that the pieces' blow-ups are sectors (a cone structure at x is REG-J′'s content)"; and an entry at l. 676, "at the centre of a
  unit arc of kind both in a saturated colouring, the inner colour's sector points toward the arc"). The grokkings (preloaded; G84, G85
  describe contact regularity and integer radii) and `CLAUDE.md`.
- The list's § 7 (the cover route, frozen 07:06 UTC), read at 07:26 UTC after the coordinator pointed to its § 7.0: its definitions of
  MUA ("maximal under inclusion up to null sets"), of *j-bound* ("at distance exactly 1 from `F_j`", `F_j` the closure of colour `j`),
  of a Grundy-bound colouring (which quotes FS121-D3-GRUNDY's clause and says "its output is Grundy-bound"), and the statements
  C121-NOPAR, C121-NOPAR-C5, C121-C1-BOUND, C121-C1-GMAP (whose inhabitant line reads "R7 (every class a MUA set)"), C121-C1-SAT,
  C121-C1-COVMAP, C121-C1-FLAT.
- The coordinator's answer (07:25 UTC): my three readings of § 1.3 stand; the relayed definitions are logged under § Fence log.
- Prior knowledge: none of this project's FS-121 work; general measure theory (Lebesgue density, Federer's measure-theoretic boundary,
  Zorn's lemma).

### 1.2 The quotation check (standing rule 3)

The brief's three quotations (the lines beginning `> - **` in § The statements) were compared with `data/fs121/claims.md` by exact
substring test (a one-off `python3` run, 2026-09-29 07:05 UTC): **3 of 3 found verbatim**, *not claimed* lines included. No mismatch.

### 1.3 The readback: each statement restated, with the terms it uses

**FS121-V2-SECTOR.** Quoted: "in an honest saturated colouring in D-NF satisfying REG-J′, at every point of Σ, a colour that occupies a
sector of positive angle occupies no other region there, of positive or of zero angle *Not claimed:* that a colour cannot occupy two
zero-angle regions at one point; anything without REG-J′; that the point itself is saturated (not used)". *Restated:* let `f` be honest,
saturated, in D-NF, with REG-J′; let `z ∈ Σ` and `r > 0` with `B(z, r) ∩ Σ = {z}` and finitely many interface arcs meeting `z`. The
components of `B(z, r)` minus those arcs are the *regions* at `z`, each a.e. of one colour; a region's *angle* is the angle at `z` between
the tangent directions of its two bounding arcs. The claim: if colour `a` has a region of positive angle at `z`, no other region at `z`
has colour `a`. *Terms:* Σ, REG-J′, honest, saturated, D-NF from § 0; "sector", "region", "angle", "occupies" are not defined on the list;
my reading is the one just given (sent to "main" 07:20 UTC; confirmed 07:25 UTC, with the proposing record's own definitions, § Fence log).

**FS121-D3-GRUNDY.** Quoted: "every a.e.-proper k-colouring (S_1, …, S_k) of the plane can be modified, keeping it a.e.-proper with k
colours and never raising a point's colour index, into a measurable Grundy colouring (A_1, …, A_k): A_1 is a MUA set, each A_m is maximal
among sets with null unit pairs inside the complement of A_1 ∪ … ∪ A_(m−1) that contain S_m minus that union, every point of the support
of A_m is at distance exactly 1 from the support of A_i for every i < m, and so at every essential boundary point x every colour of P(x)
other than the largest is bound at x *Not claimed:* that the colour max P(x) is bound (the output need not be saturated); uniqueness; that
the output lies above f in any order; any regularity of the classes; that a saturated input stays saturated". *Restated:* from any
a.e.-proper `k`-colouring build, colour by colour, `A_m` maximal (up to null sets) among unit-avoiding sets inside `C_m = ℝ² ∖ (A_1 ∪ ⋯ ∪
A_{m−1})` that contain `S_m ∩ C_m`; the new colouring `g = m` on `A_m` satisfies `g ≤ f` pointwise, is a.e.-proper, `A_1` is MUA, and
`supp A_m ⊆ supp A_i + S¹` for `i < m`; hence at every essential boundary point every colour of `P(x)` except `max P(x)` is bound.
*Terms:* MUA is `plans/FS111-M2-regularity.md` § 1.4's (not on the list's § 0); support = `cl S̃` (the same § 1.5); "bound at x" is not
defined in § 0 — read as the statement's own gloss, `x` at distance exactly 1 from the support; confirmed by "main" and by the list's § 7.0 ("at distance exactly 1 from `F_j`").

**FS121-D3-FALLSAT.** Quoted: "every partition of the plane, up to a null set, into k measurable sets each maximal among measurable sets
with null unit pairs (a measurable idomatic partition of the unit-distance graph, the classes of a measurable fall colouring) is an honest
saturated a.e.-proper k-colouring *Not claimed:* the converse — a saturated honest colouring need not be idomatic (FS121-D3-SWAP1D, § 2.3;
trivially also with an unused colour); that any idomatic partition exists with fewer than seven classes". *Restated:* if `A_1, …, A_k` are
MUA sets with pairwise null overlaps and co-null union, the colouring `x ↦ j` on `A_j` (any choice on the null rest) is a.e.-proper and
every essential boundary point of it is at distance exactly 1 from the support of every colour of its essential multicolour. *Terms:*
"maximal" read up to null sets (literally, no measurable set is maximal: adding a point keeps the pairs null); confirmed by "main" and by § 7.0's MUA ("maximal under inclusion up to null sets").

### 1.4 Registered expectations (written before any derivation is written down)

*Honesty about timing.* These were registered after about an hour of reasoning in thought, before a line of any derivation was written
into this record. By then the reasoning had (i) a short route in mind for FS121-D3-FALLSAT and FS121-D3-GRUNDY (maximality contradicted by
adding a small ball), and (ii) for FS121-V2-SECTOR a case analysis on the limit of the edge contacts at `z` that closes every placement of
the second region except one, and stalls there. So the predictions below are *informed*, not naive, and the one for FS121-V2-SECTOR is
aimed at the place the reasoning stalled.

| statement | expected verdict | probability | likeliest break |
|---|---|---|---|
| FS121-V2-SECTOR | derived | 0.45 (gap 0.40, refuted 0.10, misstated 0.05) | a zero-angle region of the sector's own colour that arrives at `z` along the same ray as one of the sector's edges, separated from the sector only by thin regions of other colours: there the contacts of the sector's edge sit on the one side where neither region's unit shadow reaches |
| FS121-D3-GRUNDY | derived | 0.88 | a wording break, not a truth break: "never raising a point's colour index" is a pointwise claim about sets defined up to null sets, and "maximal" read literally names nothing |
| FS121-D3-FALLSAT | derived | 0.92 | the same literal reading of "maximal"; or a representative of the classes on which the essential multicolour and the supports are computed differently |

### 1.5 The attack, as registered (each extended in stage 2)

- **FS121-V2-SECTOR:** the smallest configurations first — two opposite sectors of one colour (a bowtie); two sectors touching at one
  direction across a cusp of another colour; a sector and a cusp in a general direction; a sector and a cusp tangent to the sector's
  edge. Then each hypothesis removed: REG-J′ (infinitely many arcs at `z`); saturation (the checkerboard corner, proper and unsaturated).
  Where it succeeds: locate the placement no argument closes.
- **FS121-D3-GRUNDY:** `k = 1, 2`; an input already saturated (R7); an empty colour class; maximality removed; the order of colours
  reversed (does "the largest" matter).
- **FS121-D3-FALLSAT:** `k = 1`; a partition into unit-avoiding classes not all maximal (the hexagonal seven-colouring, M-DEADLOCK);
  a cover in place of a partition (DISC7); the converse (R7, whose down classes' maximality is undecided).

### 1.6 Placeholder blocks (stage 1: prediction registered, no derivation yet)

*At stage 1 (commit `ad211625`) this subsection held three `verification:` blocks whose verdict read "stalls at: stage 1 — the derivation has
not begun"; they were there so the gate could read the registered predictions. Stage 2 replaces them by § 2.5's blocks, whose `predicted:`
lines are unchanged, character for character. The stage-1 text is in git.*

## Stage 2 — SAVED: the three derivations, the attacks, the verdicts

*Written 2026-09-29 from the statements alone (§ 1.1's given). No first derivation has been read. Every step names what it consumes.
Notation: `T₁(y)` the unit circle about `y`; `D_y = B(y, 1)` the open unit disc; `Sh(W) = {y : T₁(y) ∩ W ≠ ∅}` the unit shadow of a set `W`
(open when `W` is open); `supp S_j = cl S̃_j` (equal to the support of `Leb|S_j`).*

### 2.0 Two lemmas every derivation below uses

**Lemma S (the shadow lemma; I-D1 re-derived).** *If `A` is measurable with null unit pairs, `y` is a density-1 point of `A` and `d̄_A(w) = θ > 0`,
then `|y − w| ≠ 1`. Hence for every open set `W` of density-1 points of `A`: `S̃_A ∩ Sh(W) = ∅`, `A ∩ Sh(W)` is null, and `supp A ∩ Sh(W) = ∅`.*
Proof. Suppose `|y − w| = 1`. For small `ρ` put `P = A ∩ B(w, ρ)` and `Q = B(y, 3ρ)`. For `p ∈ B(w, ρ)` the circle `T₁(p)` passes within `ρ` of
`y`, so it holds an arc of length `≥ 2ρ` inside `Q`; hence `{(p, u) : p ∈ P, u ∈ S¹, p + u ∈ Q}` has `Leb ⊗ length` measure `≥ 2ρ|P|`. Those pairs
with `p + u ∉ A` have measure `≤ ∫_{Q∖A} length{u : q − u ∈ B(w, ρ)} dq ≤ πρ·|Q ∖ A|` (translation invariance for each `u`, then Fubini; a unit
circle meets a disc of radius `ρ < 1/10` in an arc of length `≤ πρ`). Along `ρ_k → 0` with `|P| ≥ (θ/2)πρ_k²`, and with `|Q ∖ A| = o(ρ²)`
(density 1 at `y`), the unit pairs of `A` inside `P × Q` have measure `≥ ρ_k²(θπρ_k − o(ρ_k)) > 0`: a contradiction. For the corollary: a point of
`W` has `A`-density 1, so no density point of `A` lies on a unit circle through it; `A ∖ S̃_A` is null (Lebesgue); `Sh(W)` is open and misses
`S̃_A`, so it misses its closure. ∎ *(It is `data/fs111/claims.md` § 1's I-D1 and the step M2-INT names; re-derived here because this list's § 1
does not hold it.)*

**Lemma B (a small ball can always be added where a class is absent from the annulus).** *Let `A` be unit-avoiding, `x` a point with
`dist(T₁(x), supp A) ≥ 2η > 0` (or `supp A = ∅`), `0 < η ≤ 1/4`, and `G ⊆ B(x, η)` measurable. Then `A ∪ G` is unit-avoiding.*
Proof. `A_η(x) = {q : ||q − x| − 1| ≤ η}` lies within `η` of `T₁(x)`, so it misses `supp A`, and `A ∩ A_η(x) ⊆ A ∖ S̃_A` is null. Unit pairs
inside `G`: none (diameter `< 1`). A unit pair `(p, p + u)` with one end in `G` and the other in `A` has the other end in `A ∩ A_η(x)`; for each
`u` the set of such `p` is a translate of a subset of a null set, so the pairs have measure 0 (Fubini). Pairs inside `A`: null. ∎

### 2.1 FS121-D3-FALLSAT — derivation

Let `A_1, …, A_k` be measurable, MUA, with `|A_i ∩ A_j| = 0` (`i ≠ j`) and `|ℝ² ∖ ⋃ A_j| = 0`. Put `f(x) = min{j : x ∈ A_j}` on `⋃ A_j` and
`f = 1` on the null rest: an honest (one colour per point) measurable colouring, with `S_j = f⁻¹(j)` differing from `A_j` by a null set. So
`S̃_j = Ã_j`, `d̄_j`, `P(x)` and `supp S_j = supp A_j` are those of the `A_j`.
1. *a.e.-proper.* The pairs `(x, u)` with `f(x) = f(x + u) = j` lie in the unit pairs of `A_j` (null) or have an end in the null set
   `S_j Δ A_j` (null, by Fubini as in Lemma B). Uses: each `A_j` unit-avoiding.
2. *Saturated.* Let `x` be an essential boundary point (`x ∈ ∂_e S_i` for some `i`) and `j ∈ P(x)`; suppose `T₁(x) ∩ supp A_j = ∅`. (`supp A_j`
   is closed and `T₁(x)` compact, so the distance is some `2η > 0`, `η ≤ 1/4`; if `supp A_j = ∅` then `A_j` is null and `j ∉ P(x)`.) By Lemma B
   with `G = B(x, η)`, `A_j ∪ B(x, η)` is unit-avoiding; `A_j` is MUA, so `|B(x, η) ∖ A_j| = 0`. Then `x ∈ S̃_j`, and every `i ≠ j` has
   `|A_i ∩ B(x, η)| ≤ |A_i ∩ A_j| = 0`, so `d̄_i(x) = 0`. Hence `x ∉ ∂_e S_j` (a density-1 point) and `x ∉ A*_i ⊇ ∂_e S_i` for `i ≠ j`: `x` is
   not an essential boundary point. Contradiction. So every essential boundary point is at distance exactly 1 from the support of each colour
   of `P(x)`. Uses: `A_j` maximal up to null sets; the pairwise null overlaps (for `d̄_i(x) = 0`); nothing about the other classes' maximality.
∎ **Verdict: derived (TRUE).**

*What the argument carries beyond the sentence* (not a flaw): step 2 never used that `x` is an essential boundary point until its last line;
it proves that **every** point `x` and **every** colour `j` have `x ∈ int supp A_j` or `T₁(x) ∩ supp A_j ≠ ∅` (FS111-M-SATC (ii), class by
class) — the fall property, stronger than saturation. And saturation for colour `j` uses only `A_j`'s own maximality.

### 2.2 FS121-D3-GRUNDY — derivation

Let `f` be an a.e.-proper `k`-colouring, `S_m = f⁻¹(m)`; each `S_m` is unit-avoiding (its unit pairs are monochromatic edges). Build `A_1, …, A_k`
by induction, with `U_0 = ∅`, `U_m = A_1 ∪ ⋯ ∪ A_m`, `C_m = ℝ² ∖ U_{m−1}`, `S′_m = S_m ∩ C_m`, and the family
`𝓕_m = {B measurable : S′_m ⊆ B ⊆ C_m, B unit-avoiding}` (exact inclusions), preordered by inclusion up to null sets.
1. *A maximal element exists.* `S′_m ∈ 𝓕_m`. With `μ(B) = Σ_n 2^{−n}|B ∩ B(0, n)|/|B(0, n)|`, let `β(B) = sup{μ(B′) − μ(B) : B′ ∈ 𝓕_m, B′ ⊇ B}`;
   choose `B_0 = S′_m` and `B_{n+1} ⊇ B_n` in `𝓕_m` with `μ(B_{n+1}) ≥ μ(B_n) + β(B_n)/2`; `E = ⋃ B_n` is in `𝓕_m` (an increasing union of
   unit-avoiding sets is unit-avoiding: a unit pair of `E` lies in some `B_n × B_n`). If some `B′ ∈ 𝓕_m`, `B′ ⊇ E`, had `|B′ ∖ E| > 0`, then
   `μ(B′) − μ(E) = c > 0` and `β(B_n) ≥ c` for every `n`, so `μ(B_n) → ∞`, against `μ ≤ 1`. So `A_m := E` is maximal (up to null sets) in
   `𝓕_m`. *(This exhaustion uses dependent choice only; FS111-M-SATC used Zorn's lemma for the cover form.)*
2. *A colouring below `f`.* `A_m ⊆ C_m` makes the `A_m` pairwise disjoint; `A_m ⊇ S′_m` gives `U_m ⊇ S_1 ∪ ⋯ ∪ S_m` by induction, so the `A_m`
   cover the plane (every point, exactly), and `g = m` on `A_m` has `g(x) ≤ f(x)` for **every** point `x` (`x ∈ S_{f(x)} ⊆ U_{f(x)}`). `g` is
   measurable and a.e.-proper (each `A_m` unit-avoiding), with at most `k` colours.
3. *`A_1` is MUA.* A unit-avoiding `B ⊇ A_1` contains `S_1 = S′_1` and lies in `C_1 = ℝ²`, so `B ∈ 𝓕_1` and `|B ∖ A_1| = 0`.
4. *The Grundy property.* Let `i < m` and `x ∈ supp A_m`; suppose `T₁(x) ∩ supp A_i = ∅`, with distance `2η`, `0 < η ≤ 1/4` (or `supp A_i = ∅`).
   `G = A_m ∩ B(x, η)` has positive measure (`x ∈ supp A_m`). By Lemma B, `A_i ∪ G` is unit-avoiding; it contains `S′_i` and lies in `C_i`
   (`G ⊆ A_m ⊆ C_m ⊆ C_i`, as `U_{i−1} ⊆ U_{m−1}`); and `|G ∖ A_i| = |G| > 0` (`A_m ∩ A_i = ∅`). So `A_i` is not maximal in `𝓕_i`:
   contradiction. Hence **every point of `supp A_m` is at distance exactly 1 from `supp A_i`**, for every `i < m`. (If `A_i` is null, the same
   argument shows every later `A_m` is null, so the property is never vacuously violated by an empty class.)
5. *The "and so".* At an essential boundary point `x` of `g`, `m := max P(x)` has `d̄_m(x) > 0`, so `x ∈ supp A_m`; by step 4, `x` is at
   distance exactly 1 from `supp A_i` for every `i < m`, in particular for every `i ∈ P(x) ∖ {m}`: each such colour is bound at `x` (§ 7.0's
   *j-bound*).
∎ **Verdict: derived (TRUE).** *Uses only:* each input class unit-avoiding; maximality of `A_i` for the `i < m` (never of `A_m` itself — the
last class `A_k = C_k` is maximal for free); Lemma B.

### 2.3 FS121-V2-SECTOR — derivation

*Setting (§ 1.3's reading, confirmed; the proposing record's definitions as relayed).* `f` honest, saturated, in D-NF, with REG-J′; `z ∈ Σ`;
`r < 1/4` with `B(z, r) ∩ Σ = {z}` and the essential boundary in `B(z, r)` equal to finitely many interface arcs at `z`. Off Σ, M-PINCH's
hypotheses hold (Σ's definition), and M-PINCH's two cases give at every arc point two unit discs tangent there from opposite sides, each on one
side of the arc (split: the arc is a unit arc, one disc is its own and the other its reflection lies in the outer colour near the point — or,
directly, M2-INTRAD's integer radii ≥ 1): so every arc is `C^{1,1}` with curvature in `[−1, 1]`. Consequences used:
- (F-a) *Tangents at `z`.* An arc of curvature `≤ 1` inside `B(z, r)` has length `< 4r` (its tangent turns by at most its length, so a piece of
  length `ℓ ≤ 1` moves `≥ ℓ cos 1` along its initial direction), so it reaches `z` with a tangent direction.
- (F-b) *Regions.* The components of `B(z, r) ∖ (arcs ∪ {z})` are the regions; each is open, connected, has `z` in its closure, and is a.e. of
  one colour (no essential boundary inside it: Federer's criterion — zero measure-theoretic boundary in a connected open set — or the relayed
  definition), so each of its points is a density-1 point of that colour. A region bounded by arcs with tangent directions `φ < φ′` contains,
  for every direction strictly between, an initial segment of the ray from `z` (its *angle* is `φ′ − φ`); a zero-angle region lies between two
  arcs with one tangent direction `γ`, and meets every small circle `∂B(z, ρ)`.
- (F-c) *The lens.* Two arcs tangent at `z` to one direction, written as graphs `h = e(t)` over that direction, satisfy
  `−(1 − √(1 − t²)) ≤ e(t) ≤ 1 − √(1 − t²)` for small `t` (curvature in `[−1, 1]`, ODE comparison for `e′`): a zero-angle region with tangent
  direction `γ` and normal `ν` lies, near `z`, strictly outside `cl D_{z+ν}` and strictly outside `cl D_{z−ν}`.

**Lemma N (contacts are normal).** *If `x` is an arc point between regions `W` (colour `a`) and `W′`, and `y ∈ supp S_a` with `|y − x| = 1`, then
`y = x ± ν(x)`, `ν(x)` the unit normal of the arc at `x`.* Proof. By Lemma S, `T₁(y) ∩ W = ∅`. Near `x` the arc splits a small ball into a
part of `W` and a part of `W′`; a unit circle through `x` transversal to the arc enters the `W` side. So `T₁(y)` is tangent to the arc at `x`. ∎

**Lemma A (edge contacts).** *For every arc `e` bounding an `a`-region, with tangent direction `φ` and normal `ν` at `z`, one of `z + ν`, `z − ν`
lies in `supp S_a`; precisely, for arc points `x_n → z` there are `a`-contacts `y_n = x_n + σ_n ν(x_n)` (saturation: `a ∈ P(x_n)`; Lemma N), and
every limit point of `(y_n)` is `z + σν` with `σ = ±1`.* (`supp S_a` is closed; `ν(x_n) → ν` by (F-a).)

**Lemma D (own side forces containment).** *If in Lemma A the contacts lie on the `W` side of `e` (`σ_n ν(x_n)` points into `W` for infinitely
many `n`), then `W ⊆ cl D_{z+σν}`.* Proof. The points `x_n + ρσ_nν(x_n)`, `ρ` small, are in `W` and in `D_{y_n}`, so `W ∩ D_{y_n} ≠ ∅`; by
Lemma S (`y_n ∈ supp S_a`) `T₁(y_n) ∩ W = ∅`; `W` is connected, so `W ⊆ D_{y_n}`; let `n → ∞`. ∎

**Lemma C (two sides exclude a contact).** *Let `u` be a unit vector. If some `a`-region at `z` meets `E_u := ℝ² ∖ cl D_{z+u}` and some
`a`-region at `z` (possibly the same) meets `D_{z+u}`, then `z + u ∉ supp S_a`.* Proof. Fix `p ∈ W ∩ E_u` and `p′ ∈ W′ ∩ D_{z+u}`; for `y` in a
small ball about `z + u`, `|p − y| > 1` and `|p′ − y| < 1`. If `|y − z| < 1`, the points of `W` within `1 − |y − z|` of `z` are inside `D_y` and
`p` is outside, so `T₁(y)` meets the connected `W`. If `|y − z| > 1`, the points of `W′` within `|y − z| − 1` of `z` are outside `cl D_y` and `p′`
inside, so `T₁(y)` meets `W′`. So the ball, less the null circle `T₁(z)`, lies in `Sh(W) ∪ Sh(W′)`; by Lemma S, `S_a` is null there. ∎
*Where the hypotheses come from:* a ray from `z` in direction `e` enters `D_{z+u}` if `e·u > 0` and `E_u` if `e·u < 0`
(`|ρe − u|² = 1 − 2ρ e·u + ρ²`); a zero-angle region with direction `γ` does the same according to the sign of `γ·u` (its points at a small
fixed distance lie in a thin window about `γ`); a zero-angle region with `γ·u = 0` lies in `E_u ∩ E_{−u}` near `z` by (F-c).

**The theorem.** Let `R_1` be an `a`-region of positive angle, directions `(α, β)`, `0 < β − α < 2π`, edges `e_α`, `e_β` with normals
`ν_α` (direction `α + π/2`, pointing into `R_1`'s side of `e_α`) and `ν_β` (direction `β + π/2`, pointing away from `R_1`'s side of `e_β`). Let
`R_2 ≠ R_1` be another `a`-region; its directions lie in the closed complementary arc `[β, α + 2π]`. Every direction of `R_1` near `α` has
`e·ν_α > 0`, and every one near `β` has `e·ν_β < 0`. Also `(α + π, α + 2π) ∪ (β, β + π) ⊇ (β, α + 2π)` (as `β > α`).
1. **`R_2` has a direction `γ` strictly inside `(β, α + 2π)`** (always so if `R_2` has positive angle; so if it is a zero-angle region with
   `γ ∉ {α, β}`). If `γ ∈ (α + π, α + 2π)`, then `γ·ν_α < 0`: with `u = ν_α`, `R_1` meets `D` and `R_2` meets `E`; with `u = −ν_α`, `R_1` meets
   `E` and `R_2` meets `D`. Lemma C removes both `z ± ν_α` from `supp S_a`, against Lemma A at `e_α`. If `γ ∈ (β, β + π)`, the same at `e_β`
   (`γ·ν_β > 0`, `R_1` has `e·ν_β < 0`). Contradiction.
2. **`R_2` is a zero-angle region with `γ = α`** (the case `γ = β` is the mirror image). `R_2` arrives along the ray of `e_α`, below it, with
   only zero-angle regions between. By (F-c) `R_2` lies near `z` in `E_{ν_α} ∩ E_{−ν_α}`. With `u = ν_α`: `R_1` meets `D_{z+ν_α}` (its rays have
   `e·ν_α > 0`) and `R_2` meets `E_{ν_α}`, so Lemma C gives `z + ν_α ∉ supp S_a`. Now apply Lemma A to `R_2`'s own bounding arc on `R_1`'s side
   (tangent direction `α`, normal `±ν_α`): its `a`-contacts converge to `z + ν_α` (excluded) or to `z − ν_α`, which lies on `R_2`'s side of that
   arc. Lemma D then gives `R_2 ⊆ cl D_{z−ν_α}`, against `R_2 ⊆ E_{−ν_α}` near `z`. Contradiction.
So no `a`-region other than `R_1` exists at `z`. ∎ **Verdict: derived (TRUE).**

*Uses only:* saturation at the arc points near `z` (never at `z` — the *not claimed* line's "not used" is borne out); Lemma S (null unit pairs
of `S_a`); REG-J′'s fan (finitely many arcs, Σ isolated at `z`); the two-sided unit tangent discs of M-PINCH, only for the curvature bound;
connectedness of regions. Not used: honesty beyond the colouring being a function, M2-INTRAD's finiteness, W-NOREP, DB1-L3, any colour count.

**Corollaries the same lemmas carry** (not on the list; one mind; offered, not claimed by the statement):
- (C-π) *A region of positive angle has angle at most π.* If `β − α > π`, `R_1` alone has rays with `e·ν_α > 0` and with `e·ν_α < 0`; Lemma C
  (with `W = W′ = R_1`) removes both `z ± ν_α`, against Lemma A. In particular a colour's region cannot wrap around the tip of another colour's
  zero-angle region with nothing else at `z`.
- (C-cusp) *Two zero-angle regions of one colour at `z` have collinear directions* (`γ₃ = ±γ₂`). By Lemma D and (F-c), the contacts of a
  zero-angle region's two arcs converge only to its far sides `z + ν₂` and `z − ν₂`, both then in `supp S_a`; a second region with `γ₃·ν₂ ≠ 0`
  meets `D_{z+ν₂}` or `D_{z−ν₂}` while the first meets both `E`'s, and Lemma C removes one of them. The collinear cases (the same ray, or
  opposite rays) are not reached: this is the edge the *not claimed* line sits on.

### 2.4 The attacks

**FS121-V2-SECTOR.**
- *Smallest configurations* (§ 1.5's list): the bowtie (two opposite sectors) and two sectors touching across a cusp of another colour fall under
  step 1 (the second sector always has a direction strictly inside `(β, α + 2π)`); a sector and a cusp in a general direction, step 1; the sector
  and a cusp along the ray of its own edge — the registered likeliest break — step 2, which needs the new ingredient (Lemma D). The exact check
  `fs121-v3-tangent-cusp` (§ 2.6) re-verifies Lemma C's covering in step 2's configuration on 14,641 rational points near `z + ν_α`, and its fault
  (the cusp removed) shows that `R_1` alone leaves the half with `|y − z| < 1` uncovered: the cusp is what excludes `z + ν_α`.
- *Hypotheses removed.* Saturation: the statement fails — a proper colouring by `1/4`-cells in `1/2`-blocks, each block's two diagonal cells one
  colour and its two anti-diagonal cells another, blocks coloured by a coarse periodic pattern so that same-colour cells lie in one block
  (diameter `√2/2 < 1`) or more than 1 apart, has a colour on two opposite quadrants at every block centre (a bowtie); it has slack, so no
  essential boundary point is bound (FS111-M-SLACKFREE). REG-J′: not claimed; without the fan the notion of a region at `z` dissolves (arcs
  accumulating at `z` without meeting it make "the regions at `z`" undefined — a reading of REG-J′'s "meeting", recorded as such, not a
  counterexample).
- *Where the attack succeeds* (the nearest false or unreached statements): (a) "a colour occupies at most one region at `z`" — not claimed; the
  lemmas reach it except for two zero-angle regions of one colour on one line through `z` (C-cusp): that collinear configuration is the edge. (b)
  Saturation at the arc points cannot be weakened to "bound on one side only" without losing Lemma A.
- *Inhabitants.* R7 at a lattice point: three `120°` up sectors and three down cusps, six colours, each once — each up's edge contacts at its own
  opposite vertices (its own side: Lemma D's containment is the Reuleaux triangle inside the unit disc about each vertex), each down cusp's
  contacts at the far sides (the adjacent ups' vertices, where the cusp's colour has a backward cusp, FS111-M-R7-FORCE); nothing contradicts the
  lemmas. SQ9 at a corner (four `90°` sectors, four colours) and HEX9 at a vertex (three `120°` sectors) likewise.

**FS121-D3-GRUNDY.**
- `k ≤ 4`: vacuous (no a.e.-proper `k`-colouring: `χ_m⁰(ℝ²) ≥ χ(ℝ²) ≥ 5`); `k = 1`: `ℝ²` is not unit-avoiding.
- *A saturated input* (R7, whose seven classes are MUA by FS111-VMW-R7-MAX, one mind): each `S_m` is already maximal in `𝓕_m`, so the output is
  R7 itself, and the Grundy property is R7's strongest saturation. *A tight unsaturated input* (the hexagonal seven-colouring): the procedure
  applies; nothing forces its output to be saturated (not claimed).
- *Maximality removed* (take `A_m = S′_m`): on the hexagonal colouring the point of an edge between colours 1 and 2 is free for colour 1
  (FS111-M-DEADLOCK), so points of `supp A_2` there are not at distance 1 from `supp A_1`: the Grundy property fails; maximality is used.
  The discrete control `fs121-v3-grundy-skeleton` (§ 2.6) shows the same on a triangular-lattice patch: with the extension step removed, 34
  violations.
- *"The largest" removed:* not claimed; the argument gives nothing about `max P(x)`, since step 4 enlarges only earlier classes.
- *Pointwise "never raising":* holds at every point, because the families use exact inclusions (step 2). *An empty class:* handled (step 4).
- *Where the attack succeeds:* at the two not-claimed items, which the argument does not reach: the colour `max P(x)` (step 4 enlarges only
  earlier classes, so nothing binds the top colour), and a saturated input staying unchanged (true for R7, whose classes are MUA; not argued
  here for a saturated input with a class that is not maximal). Neither is a counterexample to the statement.

**FS121-D3-FALLSAT.**
- `k ≤ 4`: vacuous. Every class of such a partition is non-null (a null set is not maximal), so an unused colour is impossible (the *not
  claimed* line's "trivially also with an unused colour" is about the converse, and is right: an honest saturated colouring with an unused colour
  is not idomatic).
- *Maximality removed:* the hexagonal seven-colouring partitions the plane into unit-avoiding sets and is not saturated (FS111-M-DEADLOCK: the
  far vertices of a hexagon are `√13/4 < 1` from an edge midpoint; re-checked by hand) — used.
- *Partition removed* (a maximal cover with overlaps, DISC7): no honest colouring is given; a selection may lose saturation (the list's
  C121-C1-COVMAP says DISC7's merged map does) — the partition hypothesis is what makes the selection unnecessary.
- *Inhabitant:* R7, if its seven classes are MUA — FS111-VMW-R7-MAX (hand, one mind) says they form a maximal admissible cover with disjoint
  classes, hence (FS111-M2-COV) seven MUA classes; so the hypothesis class is non-empty at `k = 7` at one mind's grade.
- *Where the attack succeeds:* nowhere against the statement; the argument carries the stronger fall property (§ 2.1).

### 2.5 The verification blocks (verdicts committed at this stage)

verification: FS121-V2-SECTOR
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, at every point of Σ, a colour that occupies a sector of positive
    angle occupies no other region there, of positive or of zero angle *Not claimed:* that a colour cannot occupy two zero-angle regions at
    one point; anything without REG-J′; that the point itself is saturated (not used)
  given: the statement, the frozen list data/fs121/claims.md (§§ 0–7), open FS-111 records and two relayed definition lines, as § 1.1 lists; no first derivation, sketch or verdict
  committed: 2026-09-29
  predicted: derived — 0.45 — likeliest break: a same-colour zero-angle region along the ray of one of the sector's own edges
  verdict: derived
  method: limits of the edge contacts at z sorted by two disc tests (Lemmas C and D of § 2.3), with the lens bound on arcs tangent to one
    direction; the first derivation not seen (it may share the route: the same model)
  attack: § 2.4 The attacks
  divergences: none — the first derivation stays fenced until these verdicts are committed (stage 3 writes the table)
  counterexamples: none — the bowtie, two sectors across a cusp, a sector and a cusp in a general direction and along its own edge's ray, and
    R7, SQ9, HEX9 at their vertices, each by the lemmas; without saturation a bowtie exists (a proper slack colouring), outside the hypotheses
  minds: 1 — blind, the same model; derived from the statement alone before the first derivation was read
  grade: hand

verification: FS121-D3-GRUNDY
  statement: every a.e.-proper k-colouring (S_1, …, S_k) of the plane can be modified, keeping it a.e.-proper with k colours and never
    raising a point's colour index, into a measurable Grundy colouring (A_1, …, A_k): A_1 is a MUA set, each A_m is maximal among sets with
    null unit pairs inside the complement of A_1 ∪ … ∪ A_(m−1) that contain S_m minus that union, every point of the support of A_m is at
    distance exactly 1 from the support of A_i for every i < m, and so at every essential boundary point x every colour of P(x) other than
    the largest is bound at x *Not claimed:* that the colour max P(x) is bound (the output need not be saturated); uniqueness; that the
    output lies above f in any order; any regularity of the classes; that a saturated input stays saturated
  given: the statement, the frozen list data/fs121/claims.md (§§ 0–7), open FS-111 records and two relayed definition lines, as § 1.1 lists; no first derivation, sketch or verdict
  committed: 2026-09-29
  predicted: derived — 0.88 — likeliest break: a wording one, "never raising" pointwise against sets defined up to null sets
  verdict: derived
  method: exhaustion by a weighted measure (dependent choice) for each maximal class, then an earlier class enlarged by a small ball of a later
    class where the earlier support misses the unit circle; the first derivation not seen
  attack: § 2.4 The attacks
  divergences: none — the first derivation stays fenced until these verdicts are committed (stage 3 writes the table)
  counterexamples: none — k ≤ 4 (vacuous), a saturated input (R7), the hexagonal input with and without maximality, an empty class, and the
    discrete skeleton on a triangular-lattice patch (control fs121-v3-grundy-skeleton)
  minds: 1 — blind, the same model; derived from the statement alone before the first derivation was read
  grade: hand

verification: FS121-D3-FALLSAT
  statement: every partition of the plane, up to a null set, into k measurable sets each maximal among measurable sets with null unit
    pairs (a measurable idomatic partition of the unit-distance graph, the classes of a measurable fall colouring) is an honest saturated
    a.e.-proper k-colouring *Not claimed:* the converse — a saturated honest colouring need not be idomatic (FS121-D3-SWAP1D, § 2.3;
    trivially also with an unused colour); that any idomatic partition exists with fewer than seven classes
  given: the statement, the frozen list data/fs121/claims.md (§§ 0–7), open FS-111 records and two relayed definition lines, as § 1.1 lists; no first derivation, sketch or verdict
  committed: 2026-09-29
  predicted: derived — 0.92 — likeliest break: "maximal" read literally, which names no set
  verdict: derived
  method: a small ball added to a class where its support misses the unit circle (Lemma B), contradicting maximality; the first derivation not
    seen
  attack: § 2.4 The attacks
  divergences: none — the first derivation stays fenced until these verdicts are committed (stage 3 writes the table)
  counterexamples: none — k ≤ 4 (vacuous), the hexagonal seven-colouring (maximality removed: unsaturated), DISC7 (partition removed), R7 as
    the inhabitant at one mind's grade
  minds: 1 — blind, the same model; derived from the statement alone before the first derivation was read
  grade: hand

### 2.6 Controls (exact; each with a planted fault that fires)

control: fs121-v3-tangent-cusp
  of: FS121-V2-SECTOR — step 2's configuration: a 60-degree sector's ray and a cusp tangent to its edge, 14,641 rational points near z + ν_α,
    none uncovered off the circle |y − z| = 1
  run: python3 ../tools/fs121_v3_shadow.py
  expect: 0
  fault: python3 ../tools/fs121_v3_shadow.py --drop-cusp

control: fs121-v3-grundy-skeleton
  of: FS121-D3-GRUNDY — the construction's discrete skeleton on a triangular-lattice patch with a formula colouring: proper, never raising,
    A_1 maximal, the Grundy property; violations counted
  run: python3 ../tools/fs121_v3_grundy.py
  expect: 0
  fault: python3 ../tools/fs121_v3_grundy.py --no-extend

*What the controls are and are not.* `fs121-v3-tangent-cusp` re-verifies Lemma C's covering on one configuration by exact rational arithmetic
(sign changes of `|p − y|² − 1` along a ray of `R_1` and along a polygonal path inside `R_2`, the path's containment checked exactly); its fault
removes the cusp and 7,260 points go uncovered. `fs121-v3-grundy-skeleton` is the finite analogue of § 2.2 steps 1–4 (maximal independent sets
in place of MUA sets); its fault removes the maximal extension and 34 violations appear. Neither is evidence for the measure-theoretic steps;
each shows that the step it mirrors is the one doing the work. Outputs: `data/fs121/v3/controls.out`.
