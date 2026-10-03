# FS121-V5 — a blind second mind on FS121-D2-SYM, FS121-D4-FACE and FS121-D4-GRID

*Job FS121-V5 (Ephodos, verification form), brief `data/fs121/briefs/FS121-V5-verify.md`, written by Keryx 2026-09-29; launched 2026-10-03.
Blind, the same model (Opus 5.5) as the minds whose records the second phase opens. Statements from the frozen list `data/fs121/claims.md` § 8
(frozen 2026-10-03 14:45 UTC). Verdict words: TRUE / FALSE / GAP / MISSTATED, mapped to the gate's derived / refuted / gap.*

## Theorems this phase proved

- **FS121-D4-FACE — TRUE** [hand; two minds, blind, the same model] — § 2.1; with **V5-DIAM** and **V5-PAIR** [hand, one mind], § 2.1.
- **V5-FACE-SHARP** — FACE's conclusion holds under `ρ² ≥ 2g − g²` (weaker than `2g < ρ²`), and fails for `ρ² < 2g − g²` [hand; the counterexample
  tools exact (`tools/fs121_v5_face.py cex`); one mind] — § 2.2.
- **FS121-D4-GRID — TRUE** [derived from FS121-D4-FACE; two minds, blind to the argument, given the lemma; the same model]; and `Σ = B_x × B_y` with
  exactly four interface arcs at each point — § 2.3.
- **V5-GRID-CANTOR** — for uncountable `B_x` the breakpoint clause is false (SQ9 with a null Cantor set of breakpoints) [hand, one mind] — § 2.4.

## Would-have-searched-here log (standing rule 5)

- None so far. No move of this job is a search for a finite witness; every check is a hand derivation or an exact computation whose shape the
  derivation fixes. (The ban's date, 2026-10-01, has passed; the rule's text is still in `plans/STANDING-RULES.md`, so the log is kept.)

## Fence log (standing rule 8)

- No fenced path read. Before reading the allowed FS-111/112/114 records I ran `grep -lE "FS-?121|FS-?116"` over them and read the matching lines
  of `plans/FS111-derivation.md`, `plans/FS112-derivation.md` and `plans/FS114-derivation.md` (truncated to 260 characters): FS-111's own pointers
  to its successors ("Rests on it: … FS-121 …") and two FS116-O1 errata in FS-114's file. Nothing from FS-121's rounds. Not a touch of a fenced path.
- The harness showed recent commit subjects at launch (neutral: "FS116-N3: stage 1", "FS-116, FS-121: inventory items", …) and the auto-memory index,
  whose FS-121 line says only that FS-116 and FS-121 opened 2026-09-29. No content.
- 2026-10-03 ~15:15 UTC: the coordinator's answer to my question (§ 1.3) quoted four definitions from the header of `plans/FS121-D2-proof.md`
  (ll. 6–9), a fenced record, and said the rest stays fenced. Logged as a disclosed, coordinator-mediated touch: it carried definitions of terms, no
  argument, route or verdict.

## Stage 1 — SAVED: readback, readings, what was given, registered predictions

### 1.1 Files read, in order

1. The brief `data/fs121/briefs/FS121-V5-verify.md`, in full. 2. `plans/STANDING-RULES.md`, in full. 3. `data/fs121/claims.md`, in full (§§ 0–8).
4. `.claude/agents/ephodos-verifier.md` (my identity file; its workflow is the one loaded at launch). 5. `data/fs111/claims.md` ll. 25–60 and
100–120 (D-NF's context, the essential boundary, free/contact, C-SAT-T). 6. `plans/FS111-M-regularity.md` §§ 2.1–2.3 (saturation as contact; M-SATC;
M-SLACKFREE) and §§ 3–3.2 (the setting, (H1), (H2), M-PINCH, M-C11). 7. `plans/FS111-M2-regularity.md` § 4.1 (Σ, REG-J′'s use, M2-INTRAD and its
"Not proved" line, M2-REDUCE-A) and § 4.3. 8. `plans/FS111-derivation.md`: the entries FS111-M-PINCH, FS111-M2-INTRAD, FS111-M-REDUCE-I,
FS111-C-SAT-T-HONEST, FS111-W-NOREP (statement lines only), FS111-W-LADDER (statement lines only). 9. `.claude/skills/ephodos/scripts/derive_gate.py`
(the grammar and the verification and control checkers). Preloaded at launch: `CLAUDE.md`, the grokkings (G84 and G85 bear here), the memory index.

### 1.2 Readback (standing rule 3)

`tools/fs121_v5_quotes.py` (output `data/fs121/v5/quotes.out`, exit 0; planted-fault run `data/fs121/v5/quotes-fault.out`, every check fails, exit 0):
- **The brief's three statements equal the frozen list's § 8 lines character for character** (642, 735 and 700 characters).
- **Fourteen definitional quotations the list makes "verbatim", and this job uses, occur in their named sources** (whitespace runs collapsed): D-NF
  (two pieces), *saturated*, *honest*, (H1)/(H2), Σ, REG-J′, LRA, *kind both*, FS111-M-PINCH, FS111-M2-INTRAD, FS112-N3-NOBOTH, FS111-W-NOREP,
  FS111-W-LADDER. 17 of 17.
- Not checkable by me: the § 8 statements against their proposing records (`plans/FS121-D2-proof.md`, `plans/FS121-D4-proof.md`), which are fenced.

control: fs121-v5-quotes
  of: FS121-D2-SYM — the readback: the brief's three statements against the frozen list, and fourteen of the list's quotations against their sources
  run: cd .. && python3 tools/fs121_v5_quotes.py --quiet
  expect: checks: 17  pass: 17  fail: 0  mode: clean
  fault: cd .. && python3 tools/fs121_v5_quotes.py --quiet --fault

### 1.3 Readings

**Fixed by the sources** (no question needed):
- *Essential boundary point*: a point of some `∂_e S_j = A*_j ∖ S̃_j`, `A*_j = {x : d̄_j(x) > 0}` (`data/fs111/claims.md` § 0).
- *At distance exactly 1 from the support*: `T₁(x)` meets `supp S_j` — `plans/FS111-M-regularity.md` § 2.1 proves "not `j`-free ⟺ `T₁(x) ∩ supp S_j ≠
  ∅`" and glosses saturation in these words; the literal reading `dist(x, supp S_j) = 1` would make saturation impossible, since `x ∈ supp S_j` for
  every `j ∈ P(x)`. FS121-D4-FACE's "no point of supp S_c is at distance exactly 1 from x" is the same notion: `T₁(x) ∩ supp S_c = ∅`.
- *Interface arc* in REG-J′: a `C^{1,1}` curve of the essential boundary off Σ (M-C11), as `plans/FS111-M2-regularity.md` § 4.1 uses it.
- *a.e.-proper*: `(Leb ⊗ σ)`-almost every unit pair is bichromatic (D-NF); with finitely many colours `k` (D-NF's `f : ℝ² → [k]`).

**Asked of the author** (sent to "main" at about 15:10 UTC; answered about 10:15, verbatim):
> On FS121-D2-SYM, answered from the author's record (its author is past its line; I quote its header's definitions only, and the rest of that file
> stays fenced). Verbatim, plans/FS121-D2-proof.md ll. 6–9: "a *piece* is a maximal circular arc or segment of an interface curve (FS111-M2-INTRAD
> (iii)'s "chain of segments and circular arcs"); a *junction* is a point of an interface arc, off Σ, where two pieces meet; the *window* of a
> circular arc is the angle it subtends at its centre; a *radius-r arc* is a maximal arc of one circle of radius r contained in the closure of the
> interface set". So "angular window" is as you read it. A radius-r arc is a maximal arc of one circle within the interface set's closure: closest to
> your (A), and note it is not cut at points of Σ if the circle continues there. Whether segments count among LRA's pieces of radius tending to
> infinity is not defined in that header: treat it as an ambiguity and give the verdict under each reading.

So, for FS121-D2-SYM: **radius-r arc** = a maximal arc of one circle of radius `r` in the closure of the interface set; **window** = its subtended
angle; **¬LRA** is worked under two readings: **(L∞)** the accumulating pieces may include segments (radius `∞`), and **(Lfin)** they are circular
arcs of finite radii `→ ∞`.

### 1.4 What this mind was given before its verdicts (the `given:` lines draw on this)

- The three statements verbatim, with their *not claimed* lines, which carry route hints: GRID's "at a gap's end c may have density 1 from the far side,
  where the facing lemma is silent" (so GRID's first derivation applies FACE at gap ends); FACE's "a tangent unit disc in place of the half-box admits the
  in-contact x − e"; D2-SYM's "(C121-NOLRA's open step, § 3)".
- The brief's § Why this job: "its two strongest partial results are one-mind: that no large-radius accumulation occurs in any colouring with a cocompact
  symmetry, and that the singular set is locally finite in every grid colouring, through a facing lemma" — the first mind's belief that two statements
  hold, and a lemma-level route hint for GRID (FACE is its lemma). The brief's § Fences: FS-111's W-NOREP proof is one "which the first statement
  strengthens".
- The whole frozen list: the held inputs of § 1, the two-mind statements of §§ 2, 5–7 (C121-ENDS, -OUT, -PER, -LRA-LINE, DB1-L3, FS121-V2-SECTOR,
  FS121-D3-GRUNDY, -FALLSAT, the § 7.2 lemmas), and the one-line descriptions of C121-NOLRA and C121-REGJ.
- The author's four definitions quoted in § 1.3.
- From the preloaded context: G84 and G85 (contact, integer radii, "What escapes is radii → ∞, FS-115's stuck ray"); `CLAUDE.md`'s FS-121 and FS-115 rows;
  FS111-M2 § 4.1's "Not proved" line, which describes LRA's shape (arcs of radii `n_i → ∞` at a flat point, their chains far apart).
- Not given: any FS-121 proof record, data, tool, brief or report; the verdicts or arguments of the first derivations.

### 1.5 Registered predictions (written before any derivation is written; informed, not naive)

*Honesty note.* These were formed after reading the brief, the list and the definitions' sources, and after about twenty minutes of thought in which I
sketched, unwritten, a route for each statement. They are informed priors: the probabilities below say how far I trust those sketches, not a naive
base rate.

- **FS121-D4-FACE: derived — 0.88.** Likeliest break: the direction from `x` along `+e`, where the near side only touches `x` and the far box must do all
  the work; second, a parameter edge (large `g`) where the box would not reach the circle — I expect it to be excluded by the hypotheses themselves.
- **FS121-D4-GRID: derived — 0.80.** Likeliest break: getting from "a breakpoint set that is not locally finite" to the configuration FACE needs (one
  colour on both sides of a thin run, with enough height); second, the count of interface arcs at a point of Σ.
- **FS121-D2-SYM: derived — 0.65.** Likeliest break: the "in particular" clause, since a cocompact symmetry bounds windows below only if arcs of one
  radius are locally finitely many (M2-INTRAD's finiteness step, one mind); second, accumulating segments under reading (L∞), which no window reaches;
  third, how the window bound reaches pieces far from the arcs it constrains.

### 1.6 The three blocks, as registered at stage 1

*Each block below carries this mind's prediction in the gate's grammar at the stage-1 commit. Its verdict line says that no derivation exists yet;
stage 2 replaces the verdict, method, attack, counterexamples, minds and grade lines, and keeps the statement, given, and predicted lines.*

verification: FS121-D2-SYM
  statement:
    in an honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, if for some integer r ≥ 2 the angular windows of its
    radius-r arcs are bounded below by a positive constant — in particular if it is invariant under a group of isometries of the plane, each
    mapping the partition to itself up to a permutation of the colours, with a compact set whose images cover the plane, such as a doubly
    periodic colouring — then ¬LRA holds *Not claimed:* ¬LRA without such a bound (C121-NOLRA's open step, § 3); that a tight colouring can be
    taken symmetric; anything from a bound at r = 1
  given: the statement with its not-claimed line; the brief in full; the frozen list in full; the author's four definitions (§ 1.3); everything
    else seen is listed in § 1.4
  committed: 2026-10-03 — stage 1 registers the prediction only
  predicted: derived — 0.65 — likeliest break: the in-particular clause, which needs arcs of one radius to be locally finitely many (one mind)
  verdict: stalls at: not yet derived — stage 1 registers the prediction; stage 2 writes this mind's verdict here
  method: not yet — stage 2
  attack: § 1.5 Registered predictions
  divergences: none — the comparison opens only after the verdicts' commit (the brief's § After your verdicts)
  counterexamples: none — nothing attacked yet; stage 2
  minds: 1 — no derivation yet
  grade: hand

verification: FS121-D4-FACE
  statement:
    in an a.e.-proper measurable colouring, let x be a point, e a unit vector and e⊥ a unit vector orthogonal to it; if the open half-box {x − s
    e + t e⊥ : 0 < s < ε, |t| < ε} and the open box {x + s e + t e⊥ : g < s < g + ε′, |t| < ρ} both lie almost everywhere in one class S_c, with
    ε, ε′ > 0 and 0 < 2g < ρ², then no point of supp S_c is at distance exactly 1 from x; so in a saturated colouring the colour c has density 1
    at x *Not claimed:* the same with a curved near side (a tangent unit disc in place of the half-box admits the in-contact x − e); the same
    without the lateral margin (2g ≥ ρ² is not covered); anything at an x where c has density 1; honesty, D-NF, REG-J′ (none is used)
  given: the statement with its not-claimed line; the brief in full (its § Why calls two of the list's statements the milestone's one-mind partial
    results, and says GRID's local finiteness goes through this statement); the frozen list in full; the author's four definitions (§ 1.3);
    everything else seen is listed in § 1.4; no FS-121 record
  committed: 2026-10-03 — the stage-2 commit ("FS121-V5: stage 2"), before any FS-121 record was opened
  predicted: derived — 0.88 — likeliest break: the direction from x along +e, where the near side only touches x and the far box must do all the work
  verdict: derived
  method: a pair lemma by Fubini (V5-PAIR) and a crossing criterion by connectedness; the half-box for every direction but e, the far box for e
    (§ 2.1); the first route unknown to this mind until the comparison
  attack: § 2.2 The attack on FS121-D4-FACE
  divergences: none — the comparison opens only after this commit; stage 4 replaces this line with its table's address
  counterexamples: thin truth: g = 1/10, ρ = 11/25 (2g − g² ≤ ρ² < 2g, outside the hypothesis), with H and B a.e. in S_c — the margin enters
    only as (1 − g)² + ρ² ≥ 1, in Step 2(a) of § 2.1, so the sharp hypothesis is ρ² ≥ 2g − g²
  minds: 2 — blind to: the first derivation's record, data and route (plans/FS121-D4-proof.md, data/fs121/d4/); method: V5-PAIR and the crossing
    criterion (§ 2.1); the same model (Opus 5.5)
  grade: hand

verification: FS121-D4-GRID
  statement:
    in every honest saturated a.e.-proper grid colouring with finitely many colours — closed countable sets B_x, B_y ⊂ ℝ, a.e. one colour on
    each open cell I × J of ℝ ∖ B_x by ℝ ∖ B_y, cells sharing an edge of positive length coloured differently — B_x and B_y are locally finite,
    so the singular set Σ is locally finite and each point of Σ meets at most four interface arcs *Not claimed:* B_x or B_y uncountable (a
    Cantor set of breakpoints: GAP there — at a gap's end c may have density 1 from the far side, where the facing lemma is silent); grid
    colourings in which adjacent cells may share a colour; any bound on the number of breakpoints per unit length
  given: the statement with its not-claimed line, which names the facing lemma; the brief in full, whose § Why says the singular set is locally
    finite in every grid colouring "through a facing lemma"; the frozen list in full, which holds that lemma as FS121-D4-FACE; the author's four
    definitions (§ 1.3); § 1.4 lists the rest; no FS-121 record
  committed: 2026-10-03 — the stage-2 commit ("FS121-V5: stage 2"), before any FS-121 record was opened
  predicted: derived — 0.80 — likeliest break: reaching, from a breakpoint set that is not locally finite, the configuration FACE needs
  verdict: derived
  method: Cantor–Bendixson to consecutive thin columns, a pigeonhole over k + 1 of them, then FS121-D4-FACE at a column edge (§ 2.3); the key
    step was given as a named lemma, so this route shares it with the first by construction; Steps 1, 2 and 4 are this mind's
  attack: § 2.4 The attack on FS121-D4-GRID
  divergences: none — the comparison opens only after this commit; stage 4 replaces this line with its table's address
  counterexamples: none — searched by removing saturation, adjacency, countability and finitely many colours in turn (§ 2.4); the countability
    example (SQ9 with a null Cantor set of breakpoints) refutes the breakpoint clause only outside the hypotheses, where the not-claimed line
    already places it (as a GAP: a wording defect, § 2.4)
  minds: 2 — blind to: the first derivation's record, data and argument; method: Cantor–Bendixson and a pigeonhole of this mind's own around
    the given lemma; the same model (Opus 5.5)
  grade: derived from: FS121-D4-FACE

## Stage 2 — SAVED: FS121-D4-FACE and FS121-D4-GRID — derivations, attacks, verdicts

*Written from the statements, the definitions' sources and the held inputs only (§ 1.4). No FS-121 record was opened.*

### 2.1 FS121-D4-FACE — the derivation by this mind's route

*Frame.* `x = 0`, `e = (1, 0)`, `e⊥ = (0, 1)`; `H = (−ε, 0) × (−ε, ε)` (the half-box), `B = (g, g + ε′) × (−ρ, ρ)` (the far box), both a.e. in
`S_c`, `0 < 2g < ρ²`. A point `p` **crosses** an open set `U` when `T₁(p) ∩ U ≠ ∅`.

**V5-DIAM** [hand]. *In an a.e.-proper colouring, a connected open set `U` lying a.e. in one class contains no two points at distance exactly 1; so
its diameter is at most 1.* — If `p, q ∈ U`, `|p − q| = 1`, take `r` with `B(p, 2r), B(q, 2r) ⊆ U`. For `p′ ∈ B(p, r)` the circle `T₁(p′)` passes
within `r` of `q`, so it meets `B(q, 2r)` in an arc of positive length. The pairs `(p′, u)`, `p′ ∈ B(p, r)`, `p′ + u ∈ U`, have positive
`Leb ⊗ σ` measure; the pairs with `p′ ∉ S_c` or `p′ + u ∉ S_c` are null (the second by Fubini, `∫ |(U ∖ S_c) − u| dσ(u) = 0`); so a positive measure
of monochromatic unit pairs remains — against a.e.-properness. If `diam U > 1`, the continuous `|· − p|` on the connected `U` takes the value 1. ∎
*So* `B` (convex, of diameter `(ε′² + 4ρ²)^{1/2}`) has `ρ ≤ 1/2`, hence `g < ρ²/2 ≤ 1/8`.

**V5-PAIR** [hand]. *If `U` is open and a.e. in `S_c`, and every point of an open set `V` crosses `U`, then `|V ∩ S_c| = 0`.* — For each
`p ∈ V ∩ S_c`, `{u : p + u ∈ U}` is a non-empty relatively open subset of `S¹`; integrating, the pairs `(p, u)` with `p ∈ S_c`, `p + u ∈ U` have
measure `> 0` if `|V ∩ S_c| > 0`, and removing the null set with `p + u ∈ U ∖ S_c` leaves monochromatic unit pairs of positive measure. ∎

**The crossing criterion.** For a connected open `U` put `d_U(p) = inf_{q∈U} |p − q|`, `D_U(p) = sup_{q∈U} |p − q|`. If `d_U(p) < 1 < D_U(p)`, then
`U` has points inside and outside `T₁(p)` and, being connected, meets it. Both functions are 1-Lipschitz, so this holds on an open set of `p`.

**Step 1 — every direction but `e`, by the half-box.** `y = (cos φ, sin φ)`, `φ ≢ 0`. For `q = (−s, t) ∈ H`:
`|y − q|² = 1 + 2s cos φ − 2t sin φ + s² + t²`. (a) `D_H(y) > 1`: take `|t| = ε/2` with `t sin φ ≤ 0` and `s → 0⁺`; the value tends to
`1 + t² + 2|t sin φ| > 1`. (b) `d_H(y) < 1`: if `sin φ ≠ 0`, `t = τ sgn(sin φ)`, `s = τ²` gives `1 − 2τ|sin φ| + O(τ²) < 1`; if `sin φ = 0` then
`φ = π` and `t = 0` gives `(1 − s)² < 1`. So `y` has an open neighbourhood `V_y` of points crossing `H`.

**Step 2 — the direction `e`, by the far box.** `p = (1 + a, b)`, `q = (s, t) ∈ B`: `|p − q|² = (1 + a − s)² + (b − t)²`. (a) `D_B(p) ≥
(1 + a − g)² + (|b| + ρ)² ≥ (1 + a − g)² + ρ²` (letting `s → g⁺`, `t → −ρ sgn b`), which at `a = 0` is `1 − 2g + g² + ρ² > 1` because `ρ² > 2g`; so
`D_B(p) > 1` for `|a| < η`. (b) `q = (g + ε′/2, b)` gives `d_B(p) ≤ |1 + a − g − ε′/2| < 1` for `|a| < g` (as `g + ε′/2 < 1/8 + 1/2 < 2`). So
`V_e = {|a| < min(η, g), |b| < ρ}` is an open neighbourhood of `e` of points crossing `B`.

**Step 3 — the first clause.** Every `y ∈ T₁(x)` has an open `V_y` of points crossing `H` or `B`; V5-PAIR gives `|V_y ∩ S_c| = 0`, so `y ∉ supp S_c`.
**Step 4 — the density clause.** For `r < ε`, `B(x, r) ∩ {first coordinate < 0} ⊆ H`, so `d̄_c(x) ≥ 1/2` and `c ∈ P(x)`. If `x ∉ S̃_c`, then
`x ∈ ∂_e S_c` is an essential boundary point whose essential multicolour contains `c`, and saturation puts a point of `supp S_c` on `T₁(x)`
(`plans/FS111-M-regularity.md` § 2.1's equivalence), against Step 3. So `x ∈ S̃_c`: `c` has density 1 at `x`. ∎

*Uses only:* a.e.-properness and the openness of `H` and `B` (first clause); D-NF's densities and saturation at `x` (second clause). Not honesty,
REG-J′, or the number of colours. **The margin enters once, in Step 2(a), and only as `(1 − g)² + ρ² > 1`.**

### 2.2 The attack on FS121-D4-FACE

- *Smallest and degenerate cases.* `g, ε, ε′ → 0⁺`: the steps are uniform. `g` large: excluded by the hypotheses themselves (V5-DIAM: `g < 1/8`); the
  case "the box does not reach the circle about `x + e`" cannot occur inside the hypotheses.
- *Each hypothesis removed.* Without the far box, the direction `e` is uncovered: `S_c = H ∪ Q`, `Q` the small open box just beyond `x + e` below, is
  a.e.-proper and puts `x + e` in `supp S_c`. Without the half-box, every other direction is uncovered. Without saturation the density clause fails:
  the model below has density `1/2` at `x`. Each hypothesis is used.
- **Where the attack succeeds — the lateral margin.** (i) **For `ρ² < 2g − g²` the first clause is FALSE** (exact, `cex` below): `g = 1/10`,
  `ρ = 2/5`, `ε = 1/10`, `ε′ = 1/20`, `Q = (1, 1 + 1/200) × (−1/200, 1/200)`, `S_c = H ∪ B ∪ Q`, the rest of the plane coloured by squares of side
  `1/4` in 36 colours `(i mod 6, j mod 6)`: no class has a unit pair, and `x + e ∈ cl Q ⊆ supp S_c` is at distance 1 from `x`. This confirms the
  not-claimed line ("2g ≥ ρ² is not covered") and is not a counterexample to the statement. (ii) **For `2g − g² ≤ ρ² ≤ 2g` the conclusion still
  holds — a thin truth.** Step 2(a) needs only `(1 − g)² + ρ² > 1`; at equality, every `p ≠ e` near `e` still crosses `H` (if `a < 0`) or `B` (if
  `(a, b) ≠ (0, 0)`, `a ≥ 0`, since then `(1 + a − g)² + (|b| + ρ)² > 1`), and V5-PAIR on the open punctured neighbourhood `V_e ∖ {e}` gives
  `|V_e ∩ S_c| = 0`. **So the sharp hypothesis is `ρ² ≥ 2g − g²`, i.e. `(1 − g)² + ρ² ≥ 1`: the half-height of the far box reaching the unit circle
  about `x + e`.** Exhibited parameter (exact, `thin` below): `g = 1/10`, `ρ = 11/25`.
- *The curved near side.* With an open unit disc `D(x − e, 1)` a.e. in `S_c` in place of `H`, its centre `x − e` is in `supp S_c` at distance 1 from
  `x`: the conclusion fails at once. Confirms the not-claimed line.
- *Converse.* The statement is one-way.
- **Model of the hypotheses** (non-saturated, `c` not of density 1 at `x`): `g = 1/20`, `ρ = 2/5`, `ε = 1/10`, `ε′ = 1/20`, `S_c = H ∪ B`, the strip
  `(0, g) × (−ρ, ρ)` in a colour `d`, the rest as in `cex`; `H ∪ B` has diameter `< 1` (`(0.2² + 0.5²)^{1/2} < 1`), so the colouring is a.e.-proper,
  and the first clause holds there. Saturated models: `x` interior to a tile (`c` of density 1), e.g. SQ9.

control: v5-face-margin-cex
  of: FS121-D4-FACE — the attack: with the margin dropped to ρ² < 2g − g², the exact counterexample to the first clause (confirms the not-claimed line)
  run: cd .. && python3 tools/fs121_v5_face.py cex
  expect: True
  fault: cd .. && python3 tools/fs121_v5_face.py cex --fault

control: v5-face-thin
  of: FS121-D4-FACE — the thin truth: a parameter pair outside 2g < ρ² that meets the sharp condition (1 − g)² + ρ² > 1
  run: cd .. && python3 tools/fs121_v5_face.py thin
  expect: outside the hypothesis (2g >= rho^2): True; sharp condition ((1-g)^2 + rho^2 > 1): True
  fault: cd .. && python3 tools/fs121_v5_face.py thin --fault

### 2.3 FS121-D4-GRID — the derivation by this mind's route

*Setting.* `B_x, B_y ⊂ ℝ` closed and countable; for components `I` of `ℝ ∖ B_x` and `J` of `ℝ ∖ B_y`, the cell `I × J` is a.e. one colour; cells
sharing an edge of positive length differ; the colouring is honest, saturated, a.e.-proper, with `k` colours.

**Step 1 — consecutive thin columns (Cantor–Bendixson).** Suppose `B_x` is not locally finite. Some bounded interval holds infinitely many of its
points, so the derived set `B_x′` (closed, countable) is non-empty, and it has an isolated point `b` (a non-empty closed subset of `ℝ` with no isolated
point is perfect, hence uncountable). Take `δ` with `B_x′ ∩ (b − δ, b + δ) = {b}`; `b` is a limit of `B_x` from one side, say the right (the left is
the mirror image). For each `η > 0`, `B_x ∩ [b + η, b + δ/2]` is finite (else it has a limit point there, in `B_x′`), so `B_x ∩ (b, b + δ/2]` is a
sequence `b_1 > b_2 > ⋯ ↓ b`, and the columns `I_m = (b_{m+1}, b_m)` are components of `ℝ ∖ B_x`, consecutive (`I_{m+1}` and `I_m` share the endpoint
`b_m`), of widths `w_m → 0`.

**Step 2 — a repeated colour across a short run (pigeonhole).** Fix a bounded open interval `J₀` of length `h > 0` inside a component of `ℝ ∖ B_y`,
with midpoint `y₀`, and let `c_m` be the colour of `I_m × J₀`. Choose `M` with `w_m < h²/(16k)` for `m ≥ M`. Among `c_M, …, c_{M+k}` two agree:
`c_i = c_j = c` with `M ≤ j < i ≤ M + k`; `i − j ≥ 2` because neighbours differ (exact check `pigeon` below: every `k + 1` colours with neighbours
distinct repeat at index distance in `[2, k]`, `k ≤ 6`).

**Step 3 — FACE.** `x = (b_i, y₀)`, the right edge of the column `I_i`; `e = (1, 0)`. The half-box with `ε = min(w_i, h/2)` lies in `I_i × J₀`, colour
`c`. The far box with `g = b_{j+1} − b_i = w_{i−1} + ⋯ + w_{j+1}` (at least one and at most `k − 1` columns, so `0 < g < h²/16`), `ε′ = w_j`,
`ρ = h/2` is exactly `I_j × J₀`, colour `c`; and `2g < h²/8 < h²/4 = ρ²`. FS121-D4-FACE: `c` has density 1 at `x`. But `I_{i−1} × J₀`, of colour
`c_{i−1} ≠ c`, contains the open half-disc of radius `min(w_{i−1}, h/2)` on the right of `x`, so `c` has upper density at most `1/2` there. So `B_x`
is locally finite; and `B_y` likewise, with the axes exchanged.

**Step 4 — Σ.** Now the cells form a locally finite grid of open rectangles, and every point of `B_x × B_y` is a vertex of four of them.
- *A cell's interior:* a density point of its colour, not an essential boundary point.
- *A point of an open edge* between cells of colours `a ≠ a′`: a ball missing the other cells meets only the two half-discs, open, connected, made
  of density points, with the point in both closures — (H1), (H2) hold; each colour with the point in its support has density `1/2` there; not in Σ.
- *A vertex:* the four quadrants' colours alternate around it (adjacent quadrants share edges). If only two colours occur they sit on opposite
  quadrants, and an open set a.e. equal to two opposite open quadrants of a ball is contained in their union (the vertex is not interior to the
  union of the two closed quadrants), hence disconnected — (H2) fails; with three or four colours (H1) fails. Every vertex is an essential boundary
  point, so it is in Σ.
- *Cusps:* none. `supp S_j` is the locally finite union of the closed `j`-cells, and a closed rectangle has density at least `1/4` at each of its
  points.
So `Σ = B_x × B_y`, locally finite, and each vertex meets exactly four interface arcs, the open edges ending at it. ∎

*Uses only:* FS121-D4-FACE's density clause (Step 3); the countability of `B_x`, through Cantor–Bendixson (Step 1); the finitely many colours and
the adjacency rule (Step 2, and `c_{i−1} ≠ c` in Step 3); (H1), (H2) and Σ's definition (Step 4). Honesty is automatic for a grid colouring.

### 2.4 The attack on FS121-D4-GRID

- *Saturation removed* (exact, `nonsat` below): `B_x = (1/4)ℤ ∪ {1/(4n) : n ≥ 1}`, `B_y = (1/4)ℤ`, 72 colours `(m mod 6, j mod 6, p)` with `p`
  alternating along the thin columns — a.e.-proper, neighbours distinct, `B_x` not locally finite. Saturation is used.
- *Adjacency removed:* split one column of SQ9 at `{a + 1/n}` with every sub-cell keeping the column's colour: `B_x` is not locally finite.
  Confirms the not-claimed line.
- **Where the attack succeeds — countability.** Add to SQ9's `B_x = (1/2)ℤ` a null Cantor set `C` inside one column's interior, every sub-cell
  keeping its column's colour. No two gaps of `C` share an endpoint, and the two extreme gaps are adjacent only to SQ9's old neighbours, so every
  hypothesis holds but countability; the colouring is SQ9 a.e.; `B_x` is not locally finite. **So for uncountable `B_x` the breakpoint clause is
  FALSE, not a GAP** as the not-claimed line's parenthesis says; Σ is SQ9's, so this example says nothing against the Σ clause, which is what remains
  open there. A wording defect in the not-claimed line, for the author (§ 3's divergence table carries it).
- *Finitely many colours removed:* Step 2's pigeonhole fails; no counterexample built (D-NF has finitely many colours).
- *The count:* exactly four arcs at each point of Σ; "at most four" is true and not sharp only in the sense that four is attained everywhere.
- **Model:** SQ9 (`B_x = B_y = (1/2)ℤ`, nine colours, squares of side `1/2` at period `3/2`), the list's held inhabitant: `Σ = (1/2)ℤ²`, four arcs at
  each vertex.

control: v5-grid-pigeon
  of: FS121-D4-GRID — Step 2: every k + 1 colours with neighbours distinct repeat at index distance between 2 and k, for k = 2..6
  run: cd .. && python3 tools/fs121_v5_grid.py pigeon
  expect: violations: 0
  fault: cd .. && python3 tools/fs121_v5_grid.py pigeon --fault

control: v5-grid-nonsat
  of: FS121-D4-GRID — the attack: an a.e.-proper, unsaturated grid colouring with accumulating breakpoints (saturation is used)
  run: cd .. && python3 tools/fs121_v5_grid.py nonsat
  expect: True
  fault: cd .. && python3 tools/fs121_v5_grid.py nonsat --fault
