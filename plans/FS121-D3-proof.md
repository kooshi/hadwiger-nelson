# FS121-D3 — honest saturation at six: C121-SAT6 (Ephodos, derivation job, round 2)

*Ephodos (Opus 5.5), job FS121-D3, brief `data/fs121/briefs/FS121-D3-sat6.md` with `plans/STANDING-RULES.md` as part of it. Claim:
`data/fs121/claims.md` § 4, C121-SAT6 (frozen 2026-09-29 05:41 UTC). Plan: `plans/FS121-map-step.md`. I write only this record, `data/fs121/d3/`,
`tools/fs121_d3_*.py` and `data/fs121/reports/FS121-D3.md`. Entries use my identity's grammar; `hand` is [hand], `derived from` is [derived],
`computed over` is [tools]; verdict `derived` is TRUE, `gap:` is GAP. **Words used below** (this record's, each defined from the list's § 0):
`F_j = supp S_j`; the **free set** `U_j = ℝ² ∖ (F_j + S¹)`, open, the points at distance exactly 1 from no point of `F_j`; a point is **`j`-bound** if it
is not in `U_j` (the list's "`j`-contact"); **MUA** is FS-111's maximal unit-avoiding set (`plans/FS111-derivation.md`, round 2's header).*

## Theorems this phase proved

*(filled at each stage; one line per theorem, grade, minds, address)*

- *(stage 1 proves nothing; the recognition is stated, its predicted neighbours are stage 2's)*
- FS121-D3-FALLSAT — every measurable idomatic partition (partition into MUA sets) is honest saturated; no regularity — [derived], one mind — § 2.1.
- FS121-D3-GRUNDY — every a.e.-proper k-colouring becomes a measurable Grundy colouring with k colours, bound on every colour of P(x) but the
  largest at each essential boundary point — [derived], one mind — § 2.2.
- FS121-D3-SWAP1D — on the circle of length 5/2 (unit graph y ~ y ± 1) a saturated honest three-colouring exists at the least number of colours and
  no idomatic three-partition does — [tools] exact, one mind — § 2.3.
- FS121-D3-EQ — C121-SAT6 holds if χ_m⁰ ≥ 7, fails only if χ_m⁰ ≤ 6, and given a NO for honest saturated ≤6-colourings is the answer — [derived],
  one mind — § 3.1.
- C121-SAT6 — GAP at the upper colour (TOP₆): the Grundy half free, three attempts stalled, the idomatic reading killed as a reduction — § 3.5.

## Would-have-searched-here log (standing rule 5)

- Stage 1: would have run a finder for an honest saturated colouring above the tight hexagonal seven-colouring, or for a "swap path" of colourings
  in the one-dimensional model of § 1.2. Did not: the model's colouring is written by hand (stage 2) and only checked by a tool.
- Stage 2: would have searched the 30 proper three-colourings of C₅ for an exchange path closing with the twist. Did not: the eight exchanges were
  found by hand (move the singleton colour once round the cycle); the tool checks the given path and enumerates C₅'s 243 maps only to confirm a
  standard fact (no idomatic three-partition), a set the derivation fixed.
- Stage 3: would have searched for a tight six-colouring's saturated re-choice, or for a periodic saturated six-colouring. Did not (the ban, and by
  FS121-D3-EQ such an object would already be `χ_m⁰(ℝ²) ≤ 6`); the attempts are derivations.

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

*At the opening the claim stood at FS111-C-SAT-T-HONEST's own GAP: "from a maximal cover (free, FS111-M-SATC) to an honest colouring bound on both sides
of every interface". Its entry, with the verdict of this job, is § 3.5's (moved there at stage 3, 2026-09-29, so that the file carries one entry per
name; the opening's verdict line is this paragraph).*

## Stage 1 — SAVED

## Stage 2 — SAVED: the recognition's three predictions — the idomatic half, the Grundy half, and a model that separates them

*Setting for §§ 2.1–2.2: `f` a measurable colouring of `ℝ²` with classes `S_1, …, S_k`, a.e.-proper (each class has `Leb ⊗ σ`-null unit pairs), in D-NF;
any `k`. `φ_A(y) = σ{w ∈ S¹ : y + w ∈ A}` (FS111-M2-ZERO). Prior-art queries of this stage (zbMATH Open API, 2026-09-29, `data/fs121/d3/zb-*.json`; hits
read by title; positive control `ti:"fall colorings of graphs"` → 3, Dunbar et al. 2000 among them): `q-fall` = “fall coloring | fall colouring |
idomatic” (32, all finite graphs); `q-inf` = “(fall coloring | idomatic | Grundy) & (measurable | Borel | infinite graph | unit distance)” (2, both
survey sampling — the Yates–Grundy estimator, a name collision); `q-grundy` = “(Grundy | b-coloring | b-chromatic) & (unit distance | plane |
measurable)” (15, none on colourings of a continuum); `q-sat` = “(saturated | maximal) & unit distance & (partition | coloring | colouring)” (2,
proceedings volumes). No hit states a fall, Grundy or saturation condition for a measurable colouring of a continuum.*

### 2.1 An idomatic partition is saturated (FS121-D3-FALLSAT)

*Argument.* Let every `S_j` be a MUA set, and let `x` be an essential boundary point with `j ∈ P(x)`, so `x ∈ A*_j ∖ S̃_j`. Suppose `x` is `j`-free:
`T₁(x) ∩ F_j = ∅`. `T₁(x)` is compact and `F_j` closed, so their distance is `2η > 0`, `η ≤ 1/2` wlog, and the closed annulus `A_η(x)` misses `F_j`;
since `S_j ∖ F_j` is null, `|S_j ∩ A_η(x)| = 0`. Put `B = B(x, η/2)`. A unit pair `(y, z)` with `y ∈ B`, `z ∈ S_j` has `z ∈ A_η(x)`, so by Fubini the
unit pairs of `B × S_j` are null (`∫_{S¹} |B ∩ (S_j ∩ A_η(x) − w)| dσ(w) = 0`); pairs inside `B` have length `< η < 1`. So `S_j ∪ B` has null unit pairs,
and maximality gives `|B ∖ S_j| = 0`: `x` is a density point of `S_j`, against `x ∉ S̃_j`. ∎ (The measure computation is FS111-C-FILL's.) No regularity
is used: FS111-M2-SELCOMP's clause "a regular maximal partition (a measurable fall colouring) is saturated" holds without "regular".

derivation: FS121-D3-FALLSAT
  statement: every partition of the plane, up to a null set, into k measurable sets each maximal among measurable sets with null unit pairs (a
    measurable idomatic partition of the unit-distance graph, the classes of a measurable fall colouring) is an honest saturated a.e.-proper k-colouring
  uses only: maximality of each class alone (never the others); FS111-C-FILL's measure estimate; that a class is a.e. contained in its support; no
    colour count, no regularity
  not claimed: the converse — a saturated honest colouring need not be idomatic (FS121-D3-SWAP1D, § 2.3; trivially also with an unused colour); that
    any idomatic partition exists with fewer than seven classes
  argument: § 2.1 An idomatic partition is saturated (FS121-D3-FALLSAT)
  verdict: derived
  grade: derived from: FS111-C-FILL
  minds: 1
  model: k = 7: R7, a partition into seven MUA sets (FS111-VMW-R7-MAX) and saturated (FS111-M-R7)
  prior art: partly: FS111-M2-SELCOMP states it for regular maximal partitions; fall colourings are Dunbar et al.'s (Zbl 0962.05020, finite graphs);
    “fall coloring | fall colouring | idomatic” (32), “(fall coloring | idomatic | Grundy) & (measurable | Borel | infinite graph | unit distance)” (2), none bearing
  handoff: de Bruijn — queued behind the measurable chain (FS-113), with FS111-C-FILL: a short lemma once D-NF and MUA sets are in Lean

### 2.2 The Grundy half is free (FS121-D3-GRUNDY)

*Construction.* Put `R_0 = ℝ²`. For `m = 1, …, k` in turn, let `A_m` be maximal, under inclusion up to null sets, among measurable `T` with null unit
pairs and `S_m ∖ (A_1 ∪ ⋯ ∪ A_{m−1}) ⊆ T ⊆ R_{m−1}` (a.e.), and put `R_m = R_{m−1} ∖ A_m`. The family is non-empty (it contains its lower bound, a subset
of `S_m`), and a chain has an upper bound in it by FS111-M-SATC (i)'s argument verbatim (a sequence along the chain maximising
`Σ_n 2^{−n}|T ∩ B(0, n)|/|B(0, n)|`; its union has null unit pairs as a countable increasing union and lies in `R_{m−1}`); so `A_m` exists by Zorn.
*It is a k-colouring.* Every point of `S_i` lies in `A_1 ∪ ⋯ ∪ A_i` (a.e.), so `R_{k−1} ⊆ S_k` and `A_k = R_{k−1}` (the family at `m = k` has the single
element `R_{k−1}`, unit-avoiding as a subset of `S_k`); the `A_m` partition the plane a.e.; each has null unit pairs. And `A_m ⊆ R_{m−1} ⊆ S_m ∪ ⋯ ∪ S_k`:
**a point's colour index never rises.**
*(b) Every point of `supp A_m` is `i`-bound for every `i < m`.* Let `Z = {y ∈ R_{i−1} ∖ A_i : φ_{A_i}(y) = 0}`. If `|Z| > 0`, some ball `B` of radius
`< 1/2` has `|Z ∩ B| > 0`; `A_i ∪ (Z ∩ B)` has null unit pairs (`∫_{Z∩B} φ_{A_i} = 0` by Fubini, and `Z ∩ B` has diameter `< 1`) and lies in
`R_{i−1}`, against the maximality of `A_i`. So `|Z| = 0`, and since `A_m ⊆ R_i = R_{i−1} ∖ A_i` for `m > i`, almost every `y ∈ A_m` has `φ_{A_i}(y) > 0`,
hence (as `A_i ∖ F_i` is null) `T₁(y) ∩ F_i ≠ ∅`. For `x ∈ supp A_m` take such `y_n → x` and `z_n ∈ T₁(y_n) ∩ F_i`; a limit point `z` of `(z_n)` has
`|x − z| = 1` and `z ∈ F_i`. *(c)* At an essential boundary point `x`, let `m = max P(x)`; `x ∈ A*_m ⊆ supp A_m`, so by (b) every `i ∈ P(x)`, `i < m`, is
bound at `x`. ∎

**What it says.** Half of saturation is free at every `k`: at each interface the lower colour is bound. At a two-colour interface point `x` with
`P(x) = {i, m}`, `i < m`, the lower colour's piece lies on one side of the unit circle about its partner (FS111-C-HULL at density points converging to the
partner, as in FS111-M-PINCH's Step 1) — the one-sided regularity of a maximal cover (FS111-M-COVER-SC), now on an honest partition. *(A reading, not
an entry: honesty itself is free; what the claim adds to a Grundy colouring is the second side of each interface.)*

derivation: FS121-D3-GRUNDY
  statement: every a.e.-proper k-colouring (S_1, …, S_k) of the plane can be modified, keeping it a.e.-proper with k colours and never raising a point's
    colour index, into a measurable Grundy colouring (A_1, …, A_k): A_1 is a MUA set, each A_m is maximal among sets with null unit pairs inside the
    complement of A_1 ∪ … ∪ A_(m−1) that contain S_m minus that union, every point of the support of A_m is at distance exactly 1 from the support of
    A_i for every i < m, and so at every essential boundary point x every colour of P(x) other than the largest is bound at x
  uses only: Zorn with FS111-M-SATC (i)'s chain argument; FS111-M2-ZERO's Fubini step in its relative form (maximality inside R_(i−1) forces φ > 0 a.e.
    on R_(i−1) minus A_i); compactness of unit circles and closedness of supports; no colour count, no regularity, no tightness
  not claimed: that the colour max P(x) is bound (the output need not be saturated); uniqueness; that the output lies above f in any order; any
    regularity of the classes; that a saturated input stays saturated
  argument: § 2.2 The Grundy half is free (FS121-D3-GRUNDY)
  verdict: derived
  grade: derived from: FS111-M-SATC, FS111-M2-ZERO
  minds: 1
  model: k = 7: R7 is a fixed point (every class is MUA, so A_m = S_m for every m in any order), every colour bound; k = 3 on the circle of length 5/2:
    FS121-D3-SWAP1D's colouring is Grundy in the order (a, b, c) (checked exactly, control FS121-D3-SWAP1D-GRUNDY)
  prior art: partly: the finite form — any proper k-colouring converted greedily into a Grundy colouring with at most k colours — is classical
    (recalled, not read); the measurable form not found — “(Grundy | b-coloring | b-chromatic) & (unit distance | plane | measurable)” (15),
    “(fall coloring | idomatic | Grundy) & (measurable | Borel | infinite graph | unit distance)” (2), none bearing
  handoff: de Bruijn — queued behind the measurable chain (FS-113), with FS111-M-SATC: Zorn on admissible sets and one Fubini estimate

### 2.3 A model that separates saturation from an idomatic partition (FS121-D3-SWAP1D)

*The model.* The definitions of D-NF, of saturation and of MUA sets read verbatim on the circle `C = ℝ/(5/2)ℤ` with `S¹` replaced by `S⁰ = {−1, +1}`
(`σ` its uniform measure): the unit-distance graph joins `y` and `y ± 1`. With `o = (0, 1, 2, 1/2, 3/2)`, the map `(x, i) ↦ x + o_i`, `x ∈ [0, 1/2)`,
`i ∈ ℤ/5`, is a measure-preserving bijection `[0, 1/2) × ℤ/5 → C`, and `x + o_i + 1 = x + o_{i+1}` (mod `5/2`): **every fibre is a five-cycle**. The fibre
family closes with a twist: as `x → 1/2⁻`, vertex `i` approaches the point where vertex `i + 3` of the fibre `x = 0⁺` starts.
*No two-colouring, no idomatic three-partition.* An a.e.-proper colouring restricts to a proper colouring of almost every fibre, and a partition into
MUA sets to a partition of almost every fibre into independent dominating sets (maximality is `φ > 0` off the set, which on `S⁰` says a neighbour lies in
it). `C₅` has no proper two-colouring, and no partition into three independent dominating sets: an independent set of `C₅` has at most two vertices, so
the sizes would be 2, 2, 1, and one vertex does not dominate `C₅`.
*A saturated honest three-colouring.* Colour `x + o_i` by `P_r(i)`, `r = ⌊18x⌋`, with the nine patterns (the word lists `P_r(0), …, P_r(4)`)
`ababc, abacb, abcab, acbab, cabab, babac, babca, bacba, bcaba`. Each is a proper colouring of `C₅`; `P_r` and `P_{r+1}` differ by exchanging the colours of
two adjacent vertices `v, u`; and `P_8(i) = P_0(i + 3)`, so no colour changes across the twist. The discontinuities of the colouring are exactly the two
points `r/18 + o_v`, `r/18 + o_u` of each exchange, `r = 1, …, 8`. At the first, the colour on the left is `P_{r−1}(v) = P_r(u)` and on the right
`P_r(v) = P_{r−1}(u)`; both occur beside the point `r/18 + o_u`, at distance 1, so both lie in their classes' supports there. Symmetrically at the second.
So every essential boundary point is bound for both colours of its multicolour: **the colouring is saturated, and it is honest and a.e.-proper, at the
graph's least number of colours, while no idomatic partition with that number exists.** ∎ Checked on the circle itself, without the fibres, by
`tools/fs121_d3_swap1d.py` (exact rationals; output `data/fs121/d3/swap1d.out`): 0 monochromatic overlaps under the shift by 1; 16 discontinuities, 0
unbound (point, colour) pairs; 0 Grundy defects in the order `(a, b, c)`; 0 idomatic three-partitions and 0 two-colourings of `C₅`. Plants: the twist
ignored (`--plant seam`) leaves four unbound pairs; one exchange removed (`--plant skip`, `P_3 → P_5` not an exchange) leaves two; the order `(c, a, b)`
(`--plant order`) has 18 Grundy defects; `C₆` (`--plant even`) has 6 idomatic partitions. Each fires for its own reason.

**What the model teaches.** Each change of colour at a saturated boundary point is an **exchange with a unit neighbour** (in one dimension, literally
an adjacent transposition of a fibre's colouring); saturation asks the colouring to vary only by such exchanges, and the fibres' odd cycles, which forbid
an idomatic partition, do not forbid it. The one-dimensional exchange is the flat ladder of FS111-W-LADDER (`β_{k+1} = τ_{k−1}`) seen along one normal
line.

derivation: FS121-D3-SWAP1D
  statement: on the circle R/(5/2)Z with the unit-distance graph y ~ y ± 1 and the definitions of D-NF, saturation and MUA sets read with S⁰ = {±1}
    in place of S¹, there is no a.e.-proper two-colouring and no partition into three MUA sets, and the colouring by formula of § 2.3 is an honest
    saturated a.e.-proper three-colouring, Grundy in the order (a, b, c); so an honest saturated colouring with the least number of colours can exist
    where no idomatic partition with that number does
  uses only: the fibration of the circle by five-cycles (x + o_i + 1 = x + o_(i+1)); that C₅ has no proper two-colouring and no idomatic three-partition;
    the nine patterns and their exchanges, checked exactly; no geometry of the plane
  not claimed: anything about the plane (the model is one-dimensional); that idomatic partitions fail in the plane at six colours; that every
    saturated colouring varies by exchanges in any dimension (in the plane M-PINCH's two types are the analogue, not a theorem of this entry)
  argument: § 2.3 A model that separates saturation from an idomatic partition (FS121-D3-SWAP1D)
  verdict: derived
  grade: computed over: the nine patterns and the 16 discontinuities of one colouring of R/(5/2)Z, exact rationals; the exhaustive 243 maps of C₅ to three colours
  minds: 1
  model: the colouring itself
  prior art: new — “(fall coloring | idomatic | Grundy) & (measurable | Borel | infinite graph | unit distance)” (2), “(saturated | maximal) & unit
    distance & (partition | coloring | colouring)” (2), none bearing; that C₅ has no fall three-colouring is Dunbar et al.'s standard example (recalled)
  handoff: none — a model that separates two notions; exact and finite, formalizable on demand

control: FS121-D3-SWAP1D-SAT
  of: FS121-D3-SWAP1D — the colouring is saturated; with the twist ignored (P_8 = P_0) four (point, colour) pairs are unbound
  run: python3 ../tools/fs121_d3_swap1d.py 2>&1 | tail -1
  expect: ALL HOLD
  fault: python3 ../tools/fs121_d3_swap1d.py --plant seam 2>&1 | tail -1

control: FS121-D3-SWAP1D-EXCHANGE
  of: FS121-D3-SWAP1D — every change is an exchange; with one exchange removed two (point, colour) pairs are unbound
  run: python3 ../tools/fs121_d3_swap1d.py 2>&1 | tail -1
  expect: ALL HOLD
  fault: python3 ../tools/fs121_d3_swap1d.py --plant skip 2>&1 | tail -1

control: FS121-D3-SWAP1D-GRUNDY
  of: FS121-D3-GRUNDY and FS121-D3-SWAP1D — the model's colouring is Grundy in the order (a, b, c); in the order (c, a, b) it has 18 defects
  run: python3 ../tools/fs121_d3_swap1d.py 2>&1 | tail -1
  expect: ALL HOLD
  fault: python3 ../tools/fs121_d3_swap1d.py --plant order 2>&1 | tail -1

control: FS121-D3-SWAP1D-NOFALL
  of: FS121-D3-SWAP1D — C₅ has no idomatic three-partition; C₆ has six
  run: python3 ../tools/fs121_d3_swap1d.py 2>&1 | tail -1
  expect: ALL HOLD
  fault: python3 ../tools/fs121_d3_swap1d.py --plant even 2>&1 | tail -1

## Stage 2 — SAVED

## Stage 3 — SAVED: what the claim is worth, three attempts on the upper colour, and the verdict

### 3.1 The claim's strength (FS121-D3-EQ)

*Argument.* By FS111-V0-RESCALE a tight a.e.-proper six-colouring exists iff `χ_m⁰(ℝ²) ≤ 6`. (i) If `χ_m⁰(ℝ²) ≥ 7` there is none, and C121-SAT6 at
`k = 6` holds vacuously. (ii) If C121-SAT6 fails at `k = 6`, some tight six-colouring exists, so `χ_m⁰(ℝ²) ≤ 6`, and `χ(ℝ²) ≤ χ_m⁰(ℝ²)` with no MR
(`LEDGER.md` row 130's I-EASY). (iii) Suppose no honest saturated a.e.-proper colouring of the plane with at most six colours exists (call it NO-SAT₆).
Then C121-SAT6 at `k = 6` holds iff no tight six-colouring exists (a tight one would have to be modified into an object NO-SAT₆ forbids), iff
`χ_m⁰(ℝ²) ≥ 7`. ∎ *Converse of (iii).* ⟸ is (i); ⟹: C121-SAT6 with NO-SAT₆ leaves no tight six-colouring, so `χ_m⁰(ℝ²) ≥ 7` by V0-RESCALE.

**What it says.** C121-SAT6 is implied by the answer seven, and its failure is `χ(ℝ²) ≤ 6` with no MR. Given a NO in the honestly saturated class in
full generality, it *is* the answer. FS-116's NO is posed for maps (with REG-J′ and ¬LRA between them, FS111-M2-REDUCE-A), so the honest route's
composition is SAT₆ ∧ REG-J′₆ ∧ ¬LRA ∧ Q-NO ⟹ seven, and each conjunct is the answer restated given the others — FS111-C-REG-EQ's caution, one rung
lower. A proof of C121-SAT6 that does not decide the answer must be a *procedure* that turns any tight six-colouring into a saturated one, and must use
six somewhere, because at seven every such procedure is untested (R7) and the form "above `f`" is false (the list's *colours* line).

derivation: FS121-D3-EQ
  statement: C121-SAT6 at k = 6 holds if χ_m⁰(ℝ²) ≥ 7; its failure implies χ_m⁰(ℝ²) ≤ 6, hence χ(ℝ²) ≤ 6 with no MR; and if no honest saturated
    a.e.-proper colouring of the plane with at most six colours exists, C121-SAT6 at k = 6 holds if and only if χ_m⁰(ℝ²) ≥ 7
  uses only: FS111-V0-RESCALE (a tight six-colouring exists iff χ_m⁰(ℝ²) ≤ 6); χ(ℝ²) ≤ χ_m⁰(ℝ²) (row 130's I-EASY); vacuity
  not claimed: that NO-SAT₆ holds (FS-116's NO is for maps, and reaches the claim's class only with REG-J′ and ¬LRA); that C121-SAT6 is equivalent to
    the answer without NO-SAT₆
  converse: § 3.1 The claim's strength (FS121-D3-EQ)
  argument: § 3.1 The claim's strength (FS121-D3-EQ)
  verdict: derived
  grade: derived from: FS111-V0-RESCALE
  minds: 1
  model: premises open; a conditional — at seven its analogue is empty of content, R7 being an honest saturated seven-colouring
  prior art: partly: its shape is FS111-C-REG-EQ's, one rung higher; “(saturated | maximal) & unit distance & (partition | coloring | colouring)” (2),
    “(fall coloring | idomatic | Grundy) & (measurable | Borel | infinite graph | unit distance)” (2), none bearing
  handoff: none — a caution about the rung's strength; it enters no proof

### 3.2 Attempt 1 — a variational selection (the plan's first route)

*The functional.* For an honest colouring the free boundary `Φ = ⋃_j (∂_e S_j ∩ U_j)` is relatively open in the essential boundary (`U_j` is open), and
where it is non-empty it has positive length: on a component `V` of `U_j` meeting `∂_e S_j`, `S_j` is neither null nor full on `V`, and a set whose
essential boundary in a connected open set has length 0 is null or full there (Federer's criterion, GMT 4.5.11, recalled, not read — cited unread by
FS-111 too). So saturation is exactly "the free boundary has length 0", and the plan's route asks for a tight six-colouring minimising the free length
per unit area, at which every free point admits an improving move.
*Where it stops, twice.* (a) **Existence of a minimiser needs a compactness that keeps honesty.** A limit of honest colourings in the weak-* topology is
a cover (row 131's Rajchman step makes it a.e.-proper, not honest); it is honest only under local perimeter bounds (compactness in BV), and the
tight colourings need not have them (FS111-V0-WIG7's wiggles; FS111-M3-IRREG's classes). A perimeter bound is a regularity rung — REG's, which the honest
route derives *from* saturation (FS111-M2-INTRAD needs it). **The variational route inverts the honest route's order**: it needs regularity to reach
saturation. (b) **A minimiser need not be saturated.** At seven, the tight hexagonal colouring admits no modification inside a disc of radius
`< 1 − √13/4` about an edge midpoint with a contact there for either edge colour (FS111-M-DEADLOCK), so its free edges survive every small
modification; its free length is lowered only by a global re-choice (to R7, free length 0). No descent move at a free point exists in general; the
"improving fill" the plan names is exactly what FS111-W-FILL-FREE forbids (a fill leaves the filled colour free on the new boundary). **Stalls** at the
existence of a descent move, which is the claim.

### 3.3 Attempt 2 — the idomatic reading (the plan's second route)

FS121-D3-FALLSAT makes a measurable idomatic partition with at most six classes a sufficient condition. It is **strictly stronger than the claim**:
FS121-D3-SWAP1D gives a unit-distance graph with a saturated honest colouring at its least number of colours and no idomatic partition with that number,
and the obstruction there is the finite one (`C₅` has no fall three-colouring) that saturation, asked only at the boundary, does not see. In the plane
the route also meets FS111-M2-NOSEL: a maximal cover's lens is two independent dominating sets meeting in positive measure, and no selection is
idomatic or saturated. **Killed as a reduction**: it replaces the claim by a statement that fails in a model where the claim's analogue holds. It stays a
sufficient condition, and at seven it is met (R7).

### 3.4 Attempt 3 — the Grundy half, then the upper colour

FS121-D3-GRUNDY gives, from any tight six-colouring, a Grundy colouring bound at every essential boundary point on every colour of `P(x)` but the largest.
The residue is one colour per boundary point: at a free point `x` of `m = max P(x)`, every other colour near `x` is lower (`B(x, η) ∩ R_{m−1} ⊆ A_m`, by
the relative maximality of `A_m`) and bound.
- *Re-maximise the upper colour* (a second pass in an order starting with `m`, or the single-class step "`A_m` maximal within `A_m ∪ U_m`"): `m` becomes
  bound on its whole boundary (a point of `U_m` on the new boundary could be added), but the new interface lies inside the old lower class `A_i`, and
  its points are bound for `i` only if `i`-material lies at distance exactly 1 from them, which the move does not supply: at the tight hexagonal
  colouring no position of an edge binds both colours (FS111-M-DEADLOCK), and a class grown at free points stays free on its new boundary
  (FS111-W-FILL-FREE). The pair `(i, m)` is bound on one side in either order.
- *Bind both by an exchange* (the model's lesson, § 2.3): the colour `m` gains across the interface must be lost at a unit neighbour — for a
  tangent-type interface, one unit along the normal into `i`'s side, the ladder rule `β_{k+1} = τ_{k−1}` of FS111-W-LADDER — and that rung must itself be
  an exchange, and so on along the normal in both directions: the cascade of FS111-M4-MOVE, which ends only where the ladder stops being ordinary.
  Binding one free upper colour is rebuilding every ladder through it; in the plane the ladders of different interface points cross.
**Stalls** at the global rebuild of the ladders through the free upper interfaces — the plan's "global re-choice", now localised to one side of each
interface.

### 3.5 The verdict

**GAP**, at the upper colour. The claim is reduced to TOP₆: *some Grundy colouring with at most six colours, obtained from a tight one, has its
largest essential colour bound at every essential boundary point* (TOP₆ ⟹ C121-SAT6 by FS121-D3-GRUNDY (c)); the lower half of every interface is
free (FS121-D3-GRUNDY). **What the reduction is and is not:** TOP₆ is a *named* step — one side of each interface, in a colouring whose other side is
already bound and whose free upper boundary borders only lower colours — but it is not a *smaller* statement: it implies the claim, it is not shown to
follow from it, and by FS121-D3-EQ any proof of it at six must spend six. Three attempts on it stalled (§§ 3.2–3.4); the idomatic reading is killed as a
reduction (§ 3.3). *Colours:* `k = 6` by nature. *Inhabitant:* at seven, R7 (a Grundy colouring in every order, saturated); no six-colour inhabitant is
held (none can be without `χ_m⁰(ℝ²) ≤ 6`). **P3** (C121-SAT6 reduced to a named step within D3, 0.2): **met as a naming, not as a reduction to a smaller
statement** — the coordinator's call whether § 4.1's trigger fires; my reading is that it does.

derivation: C121-SAT6
  statement: every tight a.e.-proper k-colouring can be modified, keeping it a.e.-proper with k colours, into an honest (one colour per point) saturated one, at k = 5 and k = 6
  argument: § 3.5 The verdict
  verdict: gap: the upper colour — every tight six-colouring is modified for free into a measurable Grundy colouring bound, at every essential boundary
    point, on every colour of its multicolour but the largest (FS121-D3-GRUNDY); binding the largest (TOP₆) is open: not by selection (FS111-M2-NOSEL),
    not by local moves (FS111-M-DEADLOCK, FS111-W-FILL-FREE), not by a variational selection without a compactness that keeps honesty (§ 3.2), not
    through an idomatic partition, which is strictly stronger (FS121-D3-SWAP1D); a proof must spend six (FS121-D3-EQ)

**A reading for the route choice (not an entry; one mind).** FS121-D3-GRUNDY makes honesty free: a measurable Grundy partition exists whenever a tight
colouring does, and at each of its interfaces the lower colour is bound (FS121-D3-GRUNDY (c)) and is maximal in the region its own lower colours leave
(a relative form of FS111-M2-FIX's shadow identity, not derived here), so it is carved by unit circles about its own points there. That is the cover route's regularity — one-sided, as on a maximal cover
(FS111-M-COVER-SC, FS111-M2-HULLC) — carried by a partition with no lenses. So **the cover route can run on Grundy partitions**: its NO (NO-PAR) is asked
of maps each of whose interfaces lies on a unit parallel of its lower colour's own components, and FS111-M2-NOSEL's lens, which blocked the passage from
cover to partition, is not met. Killing test: a step of the cover route (FS111-M2-REDUCE-C's face merging, MUA-REG-P, MUA-FIN) that uses a class's
maximality in the whole plane rather than in the region its lower colours leave.

### 3.6 The invention signal (G87)

Read for in every source of this job. **None found.** The stall is a known theorem that almost applies (Zorn, on covers), not two held truths that
contradict. The nearest whiff: "saturation is free on covers" (FS111-M-SATC) against "no saturated selection" (FS111-M2-NOSEL) — both at seven, about
different objects, and R7 inhabits both; no collision.

## Stage 3 — SAVED
