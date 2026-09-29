# FS121-V3 — a blind second mind on FS121-V2-SECTOR, FS121-D3-GRUNDY and FS121-D3-FALLSAT

*Job FS121-V3, briefed by Keryx on 2026-09-29 (`data/fs121/briefs/FS121-V3-verify.md`). Ephodos in its verification form: blind, the same
model (Opus 5.5) as the minds whose work this record will later be compared against. The claim list is `data/fs121/claims.md` (frozen
2026-09-29 07:03 UTC, § 6). Standing rules: `plans/STANDING-RULES.md`. Stages are saved and committed in order; the commit order is the
record of what this mind could not yet have seen.*

## Theorems this phase proved

*(Filled at stage 2; stage 1 registers expectations only and proves nothing.)*

## Would-have-searched-here log (standing rule 5)

- *(stage 1)* none: no move of this job is a search for a finite witness; every check here is a hand derivation or exact arithmetic on
  objects given by formula.

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

verification: FS121-V2-SECTOR
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, at every point of Σ, a colour that occupies a sector of positive
    angle occupies no other region there, of positive or of zero angle *Not claimed:* that a colour cannot occupy two zero-angle regions at
    one point; anything without REG-J′; that the point itself is saturated (not used)
  given: the statement, the frozen list data/fs121/claims.md (§§ 0–7), open FS-111 records and two relayed definition lines, as § 1.1 lists; no first derivation, sketch or verdict
  committed: 2026-09-29
  predicted: derived — 0.45 — likeliest break: a same-colour zero-angle region along the ray of one of the sector's own edges
  verdict: stalls at: stage 1 — the derivation has not begun; this block registers the prediction only
  method: not yet derived; the first derivation is fenced until stage 3
  attack: § 1.5 The attack, as registered (each extended in stage 2)
  divergences: none — the first derivation stays fenced until the verdicts are committed
  counterexamples: none — nothing searched yet (stage 1)
  minds: 1 — blind, the same model; stage 1 holds no derivation
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
  verdict: stalls at: stage 1 — the derivation has not begun; this block registers the prediction only
  method: not yet derived; the first derivation is fenced until stage 3
  attack: § 1.5 The attack, as registered (each extended in stage 2)
  divergences: none — the first derivation stays fenced until the verdicts are committed
  counterexamples: none — nothing searched yet (stage 1)
  minds: 1 — blind, the same model; stage 1 holds no derivation
  grade: hand

verification: FS121-D3-FALLSAT
  statement: every partition of the plane, up to a null set, into k measurable sets each maximal among measurable sets with null unit
    pairs (a measurable idomatic partition of the unit-distance graph, the classes of a measurable fall colouring) is an honest saturated
    a.e.-proper k-colouring *Not claimed:* the converse — a saturated honest colouring need not be idomatic (FS121-D3-SWAP1D, § 2.3;
    trivially also with an unused colour); that any idomatic partition exists with fewer than seven classes
  given: the statement, the frozen list data/fs121/claims.md (§§ 0–7), open FS-111 records and two relayed definition lines, as § 1.1 lists; no first derivation, sketch or verdict
  committed: 2026-09-29
  predicted: derived — 0.92 — likeliest break: "maximal" read literally, which names no set
  verdict: stalls at: stage 1 — the derivation has not begun; this block registers the prediction only
  method: not yet derived; the first derivation is fenced until stage 3
  attack: § 1.5 The attack, as registered (each extended in stage 2)
  divergences: none — the first derivation stays fenced until the verdicts are committed
  counterexamples: none — nothing searched yet (stage 1)
  minds: 1 — blind, the same model; stage 1 holds no derivation
  grade: hand
