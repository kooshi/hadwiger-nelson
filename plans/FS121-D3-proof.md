# FS121-D3 — honest saturation at six: C121-SAT6 (Ephodos, derivation job, round 2)

*Ephodos (Opus 5.5), job FS121-D3, brief `data/fs121/briefs/FS121-D3-sat6.md` with `plans/STANDING-RULES.md` as part of it. Claim:
`data/fs121/claims.md` § 4, C121-SAT6 (frozen 2026-09-29 05:41 UTC). Plan: `plans/FS121-map-step.md`. I write only this record, `data/fs121/d3/`,
`tools/fs121_d3_*.py` and `data/fs121/reports/FS121-D3.md`. Entries use my identity's grammar; `hand` is [hand], `derived from` is [derived],
`computed over` is [tools]; verdict `derived` is TRUE, `gap:` is GAP. **Words used below** (this record's, each defined from the list's § 0):
`F_j = supp S_j`; the **free set** `U_j = ℝ² ∖ (F_j + S¹)`, open, the points at distance exactly 1 from no point of `F_j`; a point is **`j`-bound** if it
is not in `U_j` (the list's "`j`-contact"); **MUA** is FS-111's maximal unit-avoiding set (`plans/FS111-derivation.md`, round 2's header).*

## Theorems this phase proved

*(filled at each stage; one line per theorem, grade, minds, address)*

- *(stage 1 proves nothing; the recognition is stated, its predicted neighbour is stage 2's)*

## Would-have-searched-here log (standing rule 5)

- Stage 1: would have run a finder for an honest saturated colouring above the tight hexagonal seven-colouring, or for a "swap path" of colourings
  in the one-dimensional model of § 1.2. Did not: the model's colouring is written by hand (stage 2) and only checked by a tool.

## Fence log (standing rule 8)

No path is fenced for this job. I read no session transcript, no `chats-bak/`, no auto-memory beyond the index the harness showed at launch. I write
nothing where FS121-DB1 or FS116-V1 read: only the four paths above.

## Slips

- *(none)*

## Stage 1 — SAVED: the readback, and the recognition

### 1.1 Readback of the brief

Every quotation in the brief, and the two plan phrases it paraphrases, checked verbatim by `tools/fs121_d3_quotes.py` (whitespace normalised,
nothing else; a missing source is a failure), input `data/fs121/d3/quotes-brief.tsv`, output `data/fs121/d3/quotes-brief.out`: **6 of 6 found, exit 0**.
The plant (the first quote altered by one character) is reported missing and fires (`data/fs121/d3/quotes-brief-plant.out`).
- C121-SAT6 with its *not claimed*, *colours* and *where six is spent* lines (`data/fs121/claims.md` § 4): found. Its inner quotation, the statement of
  FS111-C-SAT-T-HONEST, found verbatim in `plans/FS111-derivation.md`.
- FS-116's qualification (the list's § 1): found.
- The brief's two candidate routes and P3 (`plans/FS121-map-step.md` § 4.2, § 4.4): found verbatim; the brief's paraphrase matches.

**No mismatch.** One reading note, for Keryx: the plan's § 4.2 row for this job lists "**C121-SAT6** (the stub's C-SAT-T-HONEST at six), C121-FALL"; the
frozen list has no C121-FALL, and the brief assigns C121-SAT6 alone. I work C121-SAT6; what stage 2 says about fall colourings bears on the plan's
C121-FALL as a route, not as a claim.

**My claim, restated beside the quotation.** C121-SAT6 at `k = 6`: every tight a.e.-proper six-colouring can be modified, keeping it a.e.-proper with six
colours, into an honest saturated one. "Modified" is unrestricted (the list's *not claimed*: not local, not a selection), so the claim is its existence
form: **if a tight a.e.-proper six-colouring exists, an honest saturated a.e.-proper colouring with at most six colours exists** (an unused colour is in no
`P(x)`, so a saturated five-colouring is a saturated six-colouring). Verdicts owed: TRUE, FALSE with a counterexample by formula, GAP at a named step, or
MISSTATED; with its colour count and its inhabitant or "none held".

### 1.2 Recognition (`ephodos-recognition`, invoked fresh at this stage)

**The stall** (FS111-C-SAT-T-HONEST's verdict): "from a maximal cover (free, FS111-M-SATC) to an honest colouring bound on both sides of every
interface — a selection from a given cover fails (FS111-M2-NOSEL), local fills deadlock (FS111-M-DEADLOCK)". Its shape is *a known theorem that almost
applies*: Zorn gives saturation to covers, whose order (inclusion) is monotone, and has no order to run on partitions, where one class grows only as
another shrinks.

**For a stranger** (a graph theorist who works on colourings with domination conditions — fall, Grundy and b-colourings): *Let `G` be the graph on
`ℝ²` joining points at distance exactly 1. Colour `ℝ²` measurably with `k` colours so that almost no edge is monochromatic. Call a point a boundary point
of a class if the class has positive upper density there without density 1. Require: every boundary point of every class `j` is adjacent in `G` to a
point of the closure of class `j`'s density points. Given that some such colouring without the requirement exists, does one with it exist?* The words
the reader stops at are two: "boundary point" (the plane's topology, which a graph does not have) and "closure" (the same). Everything else is
graph theory: the requirement is **domination**, asked only at the boundary. A class that dominates every vertex outside it is an independent
dominating set; a partition into such sets is an **idomatic partition**, the classes of a **fall colouring**; a colouring in which every vertex of colour
`m` sees every colour `i < m` is a **Grundy colouring**; one in which every class has a vertex seeing every other colour is a **b-colouring**. The
reader's sentence: *"This is a fall colouring asked only on the boundary — a relative fall colouring, relative to the plane's topology."*

**Features, sorted** (receipt in brackets):
- that no class holds a unit pair (a.e.) — *determines* (every lemma below consumes it; without it every class is the plane);
- honesty (a partition) — *determines*: it is the one feature separating the claim from FS111-M-SATC, which holds for covers at every `k` (M-SATC's
  Zorn argument uses the inclusion order, which a partition does not have);
- saturation, through its consequence "no class can be enlarged at any of its own boundary points" — *determines* (split off: saturation at `x` for `j`
  is "`x ∉ U_j`", and `x ∈ U_j` is exactly "a disc about `x` can be added to class `j`", FS111-C-FILL);
- tightness of the input — *accompanies*: FS111-V0-RESCALE makes any a.e.-proper colouring tight by a dilation, and saturated colourings are tight
  (FS111-M-SLACKFREE); the claim's input is used only as "some a.e.-proper six-colouring exists";
- the colour count `k` — *determines* the truth value (R7 makes the existence form true at every `k ≥ 7`, vacuity at `k ≤ 4`) and *accompanies* every
  lemma below (none reads it);
- the geometry of `ℝ²` — *unsorted at the start*; **sorted by the model of stage 2**: the definitions of D-NF, saturation and MUA read verbatim on the
  line with `S¹` replaced by `S⁰ = {±1}`, and the one-dimensional unit-distance graph of a circle already separates saturation from an idomatic partition,
  so the separation is not a feature of the plane.

**Homes, each with its test:**
1. **Domination colourings of graphs: fall, Grundy, b-colourings** (Dunbar et al. 2000, Zbl 0962.05020, held under FS-67, recalled for its definitions;
   Irving–Manlove's b-colourings; Grundy colourings — recalled, not read). Dictionary: class ↔ colour class; MUA set ↔ independent dominating set
   (FS111-M2-ZERO: "a measurable independent dominating set of the unit-distance graph"); maximal cover ↔ a cover by independent dominating sets (free:
   extend each class); saturated honest colouring ↔ ?, **the blank line**: the graph home has no topology, so it has no word for "at the boundary only".
   *Tests.* The old proofs apply at once to two things: (a) *the greedy conversion*: every proper `k`-colouring is converted into a Grundy colouring with
   at most `k` colours by re-choosing the classes in order, each maximal in what the earlier ones leave — with Zorn in place of the finite greedy
   step, it applies verbatim to measurable colourings (stage 2, FS121-D3-GRUNDY); (b) *an idomatic partition is saturated* (stage 2, FS121-D3-FALLSAT,
   extending FS111-M2-SELCOMP's "a regular maximal partition (a measurable fall colouring) is saturated" to every partition into MUA sets). **It predicts
   a neighbour:** the home's standard fact that fall colourings need not exist — `C₅` has none with three colours, every maximal independent set of `C₅`
   having two vertices — says the idomatic reading might fail where saturation holds, if saturation is really weaker. The graph home cannot decide it
   (its blank line). Stage 2 decides it on a one-dimensional model.
2. **Territory games and pure equilibria** (each colour a player who grows where it is free; saturation = no player can grow at its own boundary).
   *Test:* killed as a theorem home. Existence theorems for pure equilibria need a potential or monotone best responses (supermodularity); a growth of
   one class is a loss of another, so no potential of the class measures increases under every growth (FS111-M § 2.1: "`Σ|S_j|` is constant on a torus"),
   and the growths are strategic substitutes, which only for two players can be reordered into complements. Kept as language for the named step.
3. **Optimal partitions and segregation** (Conti–Terracini–Verzini; the plan's home 1 for regularity). A two-sided interface condition arising from a
   joint variational principle is its whole content. *Test:* the dictionary's energy line is blank for a distance-1 constraint (the plan's § 2.1 killed it
   as a theorem home for the same reason); the plan's "variational selection" is this home's route, and its attempt is stage 3's.
4. **Saturated packings versus tilings** (a saturated packing exists by Zorn; a saturated exact cover is a tiling problem). *Test:* a restatement of
   the stall (covers ↔ packings allowed to overlap), no theorem. Killed.

**The recognition sentence:** *an honest saturated colouring is a fall colouring asked only at the boundary — every colour lost across an interface
is found at a unit distance from it, so each change of colour across an interface is a swap with a unit neighbour — and covers are the free,
overlapping relaxation; its free half is a Grundy colouring, in which every interface is bound on its lower colour.* **What it predicts, to be checked
in stage 2:** (i) the Grundy half is free at every `k`; (ii) every idomatic partition is saturated; (iii) saturation is strictly weaker than an idomatic
partition, already on a one-dimensional unit-distance graph whose three-colourings are fibred by five-cycles (`C₅` has no fall three-colouring, so that
graph has no measurable idomatic three-partition, while a saturated honest three-colouring is built by swaps). **It differs from the plan's second
route** (the idomatic reading, "a measurable fall six-colouring above a maximal cover"): an idomatic partition is a sufficient condition strictly stronger
than the claim, and on the model it is false where the claim holds. Reported to Keryx.

### 1.3 The claim, entered as it stands at the opening (the inherited GAP; rewritten at the verdict stage)

derivation: C121-SAT6
  statement: every tight a.e.-proper k-colouring can be modified, keeping it a.e.-proper with k colours, into an honest (one colour per point) saturated one, at k = 5 and k = 6
  argument: § 1.3 The claim, entered as it stands at the opening (the inherited GAP; rewritten at the verdict stage)
  verdict: gap: at the opening, FS111-C-SAT-T-HONEST's own — from a maximal cover to an honest colouring bound on both sides of every interface; worked
    at k = 6 from stage 2 on

## Stage 1 — SAVED
