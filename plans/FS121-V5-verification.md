# FS121-V5 — a blind second mind on FS121-D2-SYM, FS121-D4-FACE and FS121-D4-GRID

*Job FS121-V5 (Ephodos, verification form), brief `data/fs121/briefs/FS121-V5-verify.md`, written by Keryx 2026-09-29; launched 2026-10-03.
Blind, the same model (Opus 5.5) as the minds whose records the second phase opens. Statements from the frozen list `data/fs121/claims.md` § 8
(frozen 2026-10-03 14:45 UTC). Verdict words: TRUE / FALSE / GAP / MISSTATED, mapped to the gate's derived / refuted / gap.*

## Theorems this phase proved

*(Filled at stage 2, when the verdicts are committed.)*

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
  given: the statement with its not-claimed line; the brief in full; the frozen list in full; the author's four definitions (§ 1.3); everything
    else seen is listed in § 1.4
  committed: 2026-10-03 — stage 1 registers the prediction only
  predicted: derived — 0.88 — likeliest break: the direction from x along +e, where the near side only touches x and the far box must do all the work
  verdict: stalls at: not yet derived — stage 1 registers the prediction; stage 2 writes this mind's verdict here
  method: not yet — stage 2
  attack: § 1.5 Registered predictions
  divergences: none — the comparison opens only after the verdicts' commit (the brief's § After your verdicts)
  counterexamples: none — nothing attacked yet; stage 2
  minds: 1 — no derivation yet
  grade: hand

verification: FS121-D4-GRID
  statement:
    in every honest saturated a.e.-proper grid colouring with finitely many colours — closed countable sets B_x, B_y ⊂ ℝ, a.e. one colour on
    each open cell I × J of ℝ ∖ B_x by ℝ ∖ B_y, cells sharing an edge of positive length coloured differently — B_x and B_y are locally finite,
    so the singular set Σ is locally finite and each point of Σ meets at most four interface arcs *Not claimed:* B_x or B_y uncountable (a
    Cantor set of breakpoints: GAP there — at a gap's end c may have density 1 from the far side, where the facing lemma is silent); grid
    colourings in which adjacent cells may share a colour; any bound on the number of breakpoints per unit length
  given: the statement with its not-claimed line; the brief in full; the frozen list in full; the author's four definitions (§ 1.3); everything
    else seen is listed in § 1.4
  committed: 2026-10-03 — stage 1 registers the prediction only
  predicted: derived — 0.80 — likeliest break: reaching, from a breakpoint set that is not locally finite, the configuration FACE needs
  verdict: stalls at: not yet derived — stage 1 registers the prediction; stage 2 writes this mind's verdict here
  method: not yet — stage 2
  attack: § 1.5 Registered predictions
  divergences: none — the comparison opens only after the verdicts' commit (the brief's § After your verdicts)
  counterexamples: none — nothing attacked yet; stage 2
  minds: 1 — no derivation yet
  grade: hand
