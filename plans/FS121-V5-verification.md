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
- **FS121-D2-SYM — TRUE**, under both readings of ¬LRA [derived from FS111-M2-INTRAD, C121-OUT, FS111-M-C11; two minds, blind, the same model;
  the in-particular clause and reading (L∞) rest on M2-INTRAD's per-radius finiteness, one mind] — §§ 3.2–3.4; with **V5-OFF** [hand], **V5-LOC**,
  **V5-ARC** and **V5-RAY** [derived from FS111-M-C11], one mind each — § 3.1.
- **V5-SYM-UP** — a window bound at one radius `r ≥ 2` holds with the same constant at every radius `R ≥ r` [derived, one mind] — § 3.5.
- **V5-SYM-CPT** — under a cocompact symmetry every curved interface is a unit arc of kind both: no tangent-type curved interface, no (R2) arc,
  without assuming ¬LRA [derived, one mind; rests on M2-INTRAD's per-radius finiteness] — § 3.5.
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
  committed: 2026-10-03 — the stage-3 commit ("FS121-V5: stage 3"), before any FS-121 record was opened
  predicted: derived — 0.65 — likeliest break: the in-particular clause, which needs arcs of one radius to be locally finitely many (one mind)
  verdict: derived
  method: V5-RAY (long nearly straight arcs of cl 𝓘 accumulating at a point put a segment into Σ, by M-C11's graph form), reached by a round
    trip inward to radius r (M2-INTRAD) and back out over the window (C121-OUT); (L∞) by the chain's alternation; the in-particular clause by
    compactness and M2-INTRAD's per-radius finiteness (§§ 3.1–3.4); the first route unknown to this mind until the comparison
  attack: § 3.6 The attack on FS121-D2-SYM
  divergences: none — the comparison opens only after this commit; stage 4 replaces this line with its table's address
  counterexamples: none — searched: the held models R7, SQ9, HEX9 (window clause vacuous), r = 1, a bound only on bounded sets, degenerate
    arcs, segments under (L∞); no held object at any k has an arc of radius ≥ 2 to test the window clause (§ 3.6)
  minds: 2 — blind to: the first derivation's record, data and argument (plans/FS121-D2-proof.md beyond the four definitions the coordinator
    quoted); method: V5-RAY and the inward–outward round trip (§§ 3.1–3.2); the same model (Opus 5.5); the in-particular clause and reading (L∞)
    rest on M2-INTRAD's per-radius finiteness, one mind
  grade: derived from: FS111-M2-INTRAD, C121-OUT, FS111-M-C11

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

## Stage 3 — SAVED: FS121-D2-SYM — derivation, attack, verdict

*Written from the statement, the definitions' sources, the held inputs and the author's four definitions (§ 1.3) only. No FS-121 record opened.*

### 3.1 Setting and lemmas

*Setting.* An honest saturated colouring in D-NF with `k` colours, satisfying REG-J′ (Σ locally finite, so closed; finitely many interface arcs at
each point of Σ). `𝓘 = ⋃_j ∂_e S_j`, the interface set. A **piece**, a **radius-r arc** and its **window**: the author's definitions (§ 1.3); an arc
has positive length (with a degenerate one-point "arc" counted, every circle of radius `r` touching an interface curve from outside would give window
0, and the hypothesis would hold only for colourings with no interface — the reading is forced). **LRA at `x₀`**: pairwise distinct pieces `A_n`
with `dist(x₀, A_n) → 0` and radii `R_n → ∞` — reading **(Lfin)** circular pieces of finite radii; reading **(L∞)** segments (radius `∞`) allowed too.

**V5-OFF** [hand]. *`cl 𝓘 ∖ Σ ⊆ 𝓘`, and no point of `𝓘` is a density point of any class.* — (ii) At `y ∈ ∂_e S_a`, `d̄_a(y) > 0`, so no other
class has density 1, and `y ∉ S̃_a` by definition. (i) Let `y = lim y_m ∉ Σ`, `y_m ∈ ∂_e S_a` (one colour, after a subsequence). As `y_m ∉ S̃_a`,
some `b ≠ a` has `d̄_b(y_m) > 0` (finitely many colours; again one `b` after a subsequence). So `y_m ∈ supp S_a ∩ supp S_b`, and `y` too. If
`y ∉ 𝓘`, every colour has `d̄_j(y) = 0` or density 1 at `y`, and at most one has density 1; so `a` or `b` has density 0 at `y` with `y` in its
support — a cusp, in Σ. ∎

**V5-LOC** [derived from FS111-M-C11]. *Each `y ∈ cl 𝓘 ∖ Σ` has a ball `B*` missing Σ in which `cl 𝓘 ∩ B* = 𝓘 ∩ B*` is the graph `Γ` of a `C^{1,1}`
function over the tangent line at `y`, `|φ(s)| ≤ s²/2`.* — `y ∈ 𝓘` (V5-OFF) and `y ∉ Σ`, so (H1), (H2) hold at `y` with a ball `N` and colours
`a, b`. Every essential boundary point in `N` meets M-PINCH's hypotheses with this `N` (saturation everywhere; `d̄_a, d̄_b > 0` there puts it in
`cl P_a ∩ cl P_b`), so M-C11 makes `∂_e S_a ∩ N′` a `C^{1,1}` curve, a Lipschitz graph over its tangent at `y` with that parabolic bound
(`plans/FS111-M-regularity.md` § 3.2 (ii)); in `N` only `a, b` have positive measure, so `𝓘 ∩ N = ∂_e S_a ∩ N`. Shrink to `B* ⊆ N′` missing the closed
Σ; V5-OFF gives `cl 𝓘 ∩ B* = 𝓘 ∩ B*`. ∎ **V5-ARC** (corollary). *If an arc `A` of a circle or line, of positive length, lies in `cl 𝓘`, every point
of `A` off Σ and not an end of `A` is an interior point of a piece lying on `A`'s circle (or line); of tangent type if the radius is not 1* (a
split-type point makes the local interface one unit arc, M-C11). — `A ∩ B*` contains a sub-arc through the point inside the simple arc `Γ`, so
`Γ = A` near it.

**V5-RAY** [derived from FS111-M-C11, through V5-LOC]. *Let `C_n ⊆ cl 𝓘` be arcs of circles of radii `R_n → ∞`, or segments, no two sharing a
sub-arc of positive length, with points `p_n ∈ C_n`, `p_n → x₀`, from which `C_n` continues for arclength `≥ λ > 0` with unit tangent `u_n → u`. Then
Σ contains the open segment `(x₀, x₀ + λu)`; so Σ is not locally finite.* — Parametrise the continuation by arclength: `|c_n(s) − p_n − s u_n| ≤
s²/R_n`, so `c_n(s) → x₀ + su` uniformly on `[0, λ]`. Let `x₁ = x₀ + tu`, `0 < t < λ`, and suppose `x₁ ∉ Σ`; `x₁ ∈ cl 𝓘` as a limit of `c_n(t)`. Take
`B* = B(x₁, ρ*)` from V5-LOC with `ρ* < min(t, λ − t)/2`, `ρ* ≤ 1/2`. For large `n` the sub-arc `c_n([t − 0.6ρ*, t + 0.6ρ*])` lies in `B*`, passes
within `ρ*/4` of `x₁`, and has both ends outside `B(x₁, ρ*/2)`. It lies in `Γ`, a graph over the tangent line; the projection is a homeomorphism on
`Γ`, so the sub-arc's projection is monotone between its ends, which lie beyond `±0.45ρ*`, and passes within `ρ*/4` of 0 — so the ends lie on
opposite sides and the sub-arc contains `Γ` over `[−0.45ρ*, 0.45ρ*]`. Two large `n ≠ m` then share that sub-arc: a contradiction. So `x₁ ∈ Σ`. ∎

### 3.2 The main clause under (Lfin)

Let `θ₀ > 0` bound below the windows of all radius-`r` arcs, `r ≥ 2`, and suppose LRA at `x₀` by circular pieces `A_n`, `R_n` strictly increasing and
`> r` (a subsequence), `q_n ∈ A_n`, `q_n → x₀`, `z_n` the centre and `ω_n` the window of `A_n`.
1. **Inward to radius `r`.** `A_n` is of tangent type (`R_n ≥ 2`; V5-ARC). FS111-M2-INTRAD: the unit parallel of a tangent-type interface arc is again an
   interface arc — off Σ its points are interface points (`plans/FS111-M2-regularity.md` § 4.1 step (1)). So the arc of the circle `(z_n, R_n − 1)` over
   `cl ω_n` lies in `cl 𝓘` (Σ meets it in finitely many points), and by V5-ARC its points off a finite set are interior points of tangent-type pieces of
   radius `R_n − 1`. Iterating `R_n − r` times (every radius on the way is `≥ r + 1 ≥ 3`): the arc of the circle `(z_n, r)` over `cl ω_n` lies in `cl 𝓘`.
2. **The window.** That arc lies in one radius-`r` arc `P_n`, of window `W_n ⊇ cl ω_n`, `|W_n| ≥ θ₀` — the only use of the hypothesis.
3. **Outward over the window.** Off a finite set, the points of `P_n` are interior points of tangent-type pieces of radius `r` (V5-ARC, `r ≥ 2`).
   C121-OUT: the unit parallel away from the centre of each is, off Σ, a tangent-type interface arc of radius `r + 1`. So the arc of `(z_n, r + 1)` over
   `W_n` lies in `cl 𝓘`; iterating, `C_n` := the arc of `(z_n, R_n)` over `W_n` lies in `cl 𝓘`. It contains `A_n` (one circle, `W_n ⊇ ω_n`), so `q_n ∈ C_n`.
4. **The ray.** `W_n` is an interval of angles of length `≥ θ₀` containing `q_n`'s angle, so `C_n` continues from `q_n` on one side for arclength
   `≥ R_nθ₀/2 ≥ 1` (large `n`). The `C_n` have distinct radii, so no two share a sub-arc. V5-RAY with `λ = 1` and `u_n → u` (a subsequence): Σ contains a
   segment, against REG-J′. ∎

*Uses only:* M2-INTRAD's parallel step (two minds on its core), C121-OUT (two minds), M-C11 (three), Σ's cusp clause, the window bound at one `r ≥ 2`,
and REG-J′'s first clause (in V5-RAY). **Not M2-INTRAD's per-radius finiteness.** `r ≥ 2` is used in steps 1 and 3: at `r = 1` the radius-1 arc may
be of split type, and C121-OUT's outward step is for tangent-type arcs — the route breaks exactly where the not-claimed line puts `r = 1`.

### 3.3 Reading (L∞): segments among the pieces

(★) *No point is an accumulation point of circular pieces*: of radii `→ ∞` by § 3.2; of bounded radii by M2-INTRAD's per-radius finiteness ("arcs of
any bounded radius are locally finitely many", § 4.1 (iii); **one mind**, VM2-FIN′). So LRA under (L∞) has all but finitely many `A_n` segments.
(a) *Lengths bounded below along a subsequence:* V5-RAY (two distinct maximal pieces sharing a sub-arc of positive length would lie on one interface
curve there, V5-LOC, and be one piece). (b) *Lengths `→ 0`:* take `η` with `B(x₀, η) ∩ Σ ⊆ {x₀}`; for large `n`, `A_n ⊆ B(x₀, η)` has an end `e_n ≠ x₀`,
off Σ, where the interface is one `C^{1,1}` curve `Γ` (V5-LOC). Two segment pieces meeting off Σ on a `C¹` curve are collinear and one piece, so
segment pieces of `Γ` near `e_n` are separated by circular ones, finitely many by (★): `Γ` is a finite chain near `e_n`, and the piece `B_n` next to
`A_n` at `e_n` is circular. A circular piece is next to at most two pieces, so infinitely many `B_n` are distinct, with `dist(x₀, B_n) ≤ |x₀ − e_n| → 0`:
against (★). ∎ **So under (L∞) the statement holds too, resting in addition on M2-INTRAD's one-mind finiteness step.**

### 3.4 The in-particular clause (a cocompact symmetry gives the bound, at every `r ≥ 2`)

Let a group `G` of isometries map the partition to itself up to colour permutations, and `K` be compact with `⋃_{g∈G} gK = ℝ²`. Densities, supports,
`∂_e`, Σ and `cl 𝓘` are `G`-invariant; `g` maps radius-`r` arcs to radius-`r` arcs with equal windows. *Only finitely many radius-`r` arcs meet `K`:*
otherwise take `q_m ∈ K` on distinct ones `P_m`, `q_m → q`; Σ is finite near `q`, so each `P_m` carries a radius-`r` piece `Q_m` (V5-ARC) with
`dist(q, Q_m) → 0`, and distinct maximal arcs carry distinct pieces — infinitely many radius-`r` pieces accumulate at `q`, against M2-INTRAD's
per-radius finiteness (**one mind**). Every radius-`r` arc `P` meets some `gK`, so `g⁻¹P` meets `K` and has `P`'s window: the minimum over the finitely
many arcs meeting `K` bounds all windows below (vacuously if there are none). With § 3.2: **¬LRA**. ∎ (The doubly periodic case is `G` a lattice of
translations.)

### 3.5 What the argument carries beyond the sentence

- **V5-SYM-UP** [derived, one mind]. *Under the hypothesis at `r` with constant `θ₀`, every circular piece of finite radius `R ≥ r` lies in a radius-`R`
  arc of window `≥ θ₀`, so on an arc of `cl 𝓘` of length `≥ Rθ₀`: the bound at one radius propagates, with its constant, to every larger radius.* —
  § 3.2 steps 1–3 with `A` any such piece.
- **V5-SYM-CPT** [derived, one mind; rests on M2-INTRAD's per-radius finiteness]. *Under a cocompact symmetry as in § 3.4, no piece is a tangent-type
  arc of finite radius: every curved interface is a unit arc of split type, of kind both.* — A tangent-type piece of radius `R₀` (any `R₀ ≥ 1`) has, by
  C121-OUT, tangent-type concentric pieces of every radius `R ≥ R₀`; for `R ≥ max(2, R₀)` each lies on a radius-`R` arc of window `≥ θ₀` (§ 3.4 and
  V5-SYM-UP); a group element moves it to meet `K` at `q_R`, from which it continues `≥ Rθ₀/2`; with `q_R → q ∈ K`, V5-RAY makes Σ non-locally-finite.
  What remains curved is of split type, a unit arc of kind both (`plans/FS111-M-regularity.md` § 3.1). This is C121-PER's conclusion for doubly periodic
  colourings (two minds, held) **without its hypothesis ¬LRA** — a consistency check against a held statement, met; and R7, SQ9, HEX9 meet it.
  So the in-particular clause's sentence ("¬LRA") is weaker than what its argument carries, and for cocompact colourings the window hypothesis is,
  a posteriori, vacuous (no radius-`r` arcs, `r ≥ 2`).

### 3.6 The attack on FS121-D2-SYM

- **Vacuity and models.** R7 (`k = 7`), SQ9 and HEX9 (`k = 9`), all doubly periodic, satisfy every hypothesis — the window clause vacuously, having no
  arc of radius `≥ 2` — and ¬LRA. No held object at any `k` has an arc of radius `≥ 2` (C121-OUT's inhabitant note), so no object tests the window clause;
  by V5-SYM-CPT no cocompact one can.
- *REG-J′ removed:* V5-RAY's contradiction is with Σ's local finiteness; without it the route stops there. *The bound removed:* C121-NOLRA's open step;
  the route needs it at step 2 only. *A bound only on bounded sets:* not enough for this route — the centres `z_n` run off to infinity, and the windows
  constrained are theirs.
- ***r = 1*:** the route breaks at steps 1 and 3, where the radius-1 arc may be split-type (C121-ENDS's inner end) and C121-OUT does not apply; neither a
  counterexample nor a proof was found. Confirms the not-claimed line.
- *Degenerate arcs:* if one-point arcs counted, the hypothesis would hold only for interface-free colourings (§ 3.1); the author's "maximal arc" is read
  as an arc of positive length — a wording point for the author (§ 4's table).
- *The converse* (¬LRA ⇒ a bound): not derived, untestable on held objects (none has the arcs).
- **Where the attack succeeds:** at no counterexample — none found at the statement's scope. It succeeds at the statement's dependence edges: the
  in-particular clause and reading (L∞) are carried only through M2-INTRAD's per-radius finiteness, held at one mind; the main clause under (Lfin) is
  not. And it finds the sentence narrower than its argument (§ 3.5): the carried exceeds the conveyed, at V5-SYM-UP and V5-SYM-CPT.
