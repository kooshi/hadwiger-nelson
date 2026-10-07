# FS-132 — six by the nerve: the plan (§G, §PA, §IQ, the route)

*Opened 2026-10-07 (UTC) by Ephodos, job FS132-E1 (brief `data/fs132/briefs/FS132-E1-opening-and-first-claim.md`). The stub is
`plans/STUB-six-by-the-nerve.md`; the claim list is `data/fs132/claims.md` (the coordinator's). The derivation's record is
`plans/FS132-E1-derivation.md`. State of the problem this plan stands on: the stub's § The mission (six or seven; the transfer with
no hypothesis), not the `CLAUDE.md` this job was launched with, which still says five, six or seven.*

## Readback

**The job.** Open the milestone; state card 1's two readings as claims; derive C132-EXT with C132-CORES — the manuscript's
Proposition 7.1 with `k` labels in place of five, at the weakest hypothesis on the cyclic centres its argument reads — and say what
the statement says on the two calibration colourings at seven. Then, as far as care carries, the readings.

**Quotation check** (standing rule 3): `data/fs132/e1/readback.py` looks for every quoted line of the brief in its source —
`quotations=6 lines_matched=6 lines_mismatched=0` (`data/fs132/e1/readback.out`); with one character of each line changed it
reports six mismatches. No finding about the brief.

**Three notes on the ground**, as the brief gives them and as I found them:
- The release's §§ 5–8 stand under "We now assume a weak measurable five-coloring" (`M/palettes.tex:3`, `M/transitions.tex:4`,
  `M/interfaces.tex:4`; `M` is the release's `build/sections/`). Its Definition 1.2 ("weak measurable `k`-coloring",
  `M/introduction.tex:83–96`) and Lemma 4.3 (`M/transfer.tex:266–270`) are stated at every `k`.
- "Slack" names three things on these pages: row 132's forbidden interval of distances; the freedom to recolour near a vertex
  (G95) — **local slack** here; and Hoffman slack of a residue plane (G54), which this milestone never means.
- The kernel's errata for `emptyNS` (`plans/FS131-L8A-landing.md` § 7) and the planner's record for the four-colour vertex
  (`fs131-w7:plans/FS131-w7-kernel-plan.md`) are evidence for card 1's readings; this job did not reach them (§ The route).

## §G — the re-grokking

*Walked 2026-10-07 from the preloaded entries G1–G92 by their bodies, with G93–G95 as drafted
(`plans/EXT-OAI2-reading.md` § 5.1, "Proposed grokkings"), from inside this question: a measurable `k`-colouring proper at almost
every unit pair; its transition graphs and cyclic centres; the nerve map and the cover theorem; one centre with a label cycle and
continua; and whether rows 137 and 148–149 read more of a map than that. Ledger rows read by mechanism at their openings: 131, 132,
137, 145, 148, 149 (`LEDGER.md` ll. 176–194); rows 133–134, 138–144, 150, 153 only through `CLAUDE.md` item 31 and the stub — said
plainly, a debt of the second job where it reads rows 138 and 150.*

**Bears** (what it says about this milestone's object, and the phase it changes):
- **G94 (drafted)** — the milestone's thesis. *Falsifiable here*: its killing test is card 1. Its first half ("off the centres …
  land in the complete graph; covering dimension forces an essential loop; fibres over edge midpoints are continua") is C132-EXT.
  → Phase EXT. Its *Do* says "the statement to prove is local finiteness of cyclic centres"; the derivation reads less and more:
  nothing for the existence of a centre, and **isolation of the one essential centre** for its continua (registered, P3).
- **G95 (drafted)** — local finiteness of cyclic centres is false under local slack at seven, so EXT must carry a hypothesis on
  the centres and CORES must not need one. → Phase EXT: the island colouring is the control for both; *Do* executed there.
- **G93 (drafted)** — every statement is posed for weak measurable colourings and cites the transfer. → all phases.
- **G79** — the example invariant against the wall. [P₆] and [L₆] are counterexample invariants (G95 kills them under local
  slack); "every colouring has cyclic centres, at every `k`" is an invariant every solution carries. → **changes the plan**:
  C132-CORES is derived first and with no hypothesis on the centres; the finiteness hypothesis is confined to the continua.
- **G92** — read each held argument at the class its argument carries. → Phase EXT (the weakest hypothesis; a disc in place of
  the square; what five is used for: `α < 1/5` and one finite pigeonhole); phase RUN-EMPTY (the `uses only:` of FS116-V6 § 2.2).
- **G15, G25** — pigeonhole × kill. EXT is Act One at every `k`: a disjunction over the cycle lengths `3, …, k`; the kills attach
  to its output. At six the triangle has no kill (three labels outside), so Act One must be sharpened (card 3) or the kill made
  non-local. G25: the next rung's kill is a 5-chromatic graph in a four-label region — a second route to the measurable
  EMPTY, a search's (already queued by the reading § 3.5). → the order of claims; RUN-EMPTY's alternative route.
- **G83, G91** — the two arguments card 1 reads. G83's straddle (two points of one colour on two unit circles within 1) is, in
  measure, two density-one points of one label at distance exactly 1 (the manuscript's Lemma 6.3): it needs no tile. G91: "six is
  spent where the ring has exactly two absent colours and where the tip sector holds only `p`'s colours" — the first becomes the
  ring hypothesis of the measurable form (a palette meeting the outside pair), the second a palette-transfer statement
  (Lemma 5.2). → Phase RUN-EMPTY: these two are predicted to restate; the steps that read sectors and tiles at a hub are where
  it can stall (P4).
- **G86** — a tile count cannot see Siamese pairs; the whole NO "must be a local exclusion reading distances between points of
  colour classes". The extraction's clause (3) is of that kind: for `z` in the support of an endpoint label, the continuum lies
  in the closed unit disc about `z` or outside the open one. → Phase RUN-EMPTY: V6-COUNT's count over tiles must become a
  count over labels and continua; phase RUN-CV: a route through a count or a modification of tiles is predicted to stall (P5).
- **G82** — a weak-* limit of near-colourings is a colouring; "where the limit object is a map, look first for the printed regular
  theorem's own chain". The manuscript did exactly this to `[SokolovVoronov2025]` Props. 1–2 (`M/interfaces.tex:11–14`). → Phase
  RADIUS (weak-* compactness on a disc); phase RUN-CV (the chain to look at is S–V's Cor. 1, row 134).
- **G21** — a negative measures its enumeration. A verdict "the argument does not run" measures my dictionary unless it exhibits
  the configuration. → **changes the readings' grammar**: "stalls at a named step" and "refuted by an object" are kept apart; a
  stall never says the measurable statement is false.
- **G13** — coverage at a centre is a set property invisible to pair sweeps. The palette is the fan at `x` in measure. → the ring
  hypothesis of the readings is stated on palettes (sets of labels per direction), never on pairs of classes.
- **G22** — no polygonal or cell-constant six-colouring exists. → the `model:` of every `k`-generic entry is at seven; at six the
  class may be empty, and the entries say so.
- **G60** — no argument that runs one class at a time gives six. Screen for every restated step: EXT reads pairs (the transition
  graph) and cycles of pairs; a restatement that bounds one class alone is not where six is spent.
- **G71** — a three-colouring's height. In a region where the nerve map takes three labels it lands in a circle, and the class of
  a loop is a winding number, additive over the centres inside. → §IQ item 3 and card 3: the candidate invariant is the loop's
  class in the nerve's fundamental group; for triangles it is a signed count.
- **G84, G85, G88–G90** — the saturated normal form. They bear on **who supplies EXT's hypothesis**: under REG-J′ the singular set
  is locally finite, and a cyclic centre is a singular point, so EXT's hypothesis holds there (a candidate composition, not
  derived here). G90's accumulation question is card 2's in the map vocabulary. → no change to EXT's derivation.
- **G87** — the lookout. Card 3's collision stands; one whiff found here, reported in the record: "finite" is sufficient for the
  continua and the island colouring's conclusion survives at centres where the hypothesis fails on every disc.
- **G29, G26** — only for C132-RADIUS and card 3: the radius at which a refusal lives (ours 1.02–1.38 in the cell family against
  Voronov's 3); `hexShell_plane` is a held statement about every colouring with fewer than seven colours (row 43).
- **G64** — its sentence "equally consistent with every field being `≤ 5` and `χ(ℝ²) = 5`" is false since the release; a draft
  replacement is this job's by-product if budget remains.

**After the walk, relayed by the coordinator the same day** (the front page refiled at `main` `35116159`; G93–G95 filed as
drafted, G95 now saying "local slack" — compared against the drafts walked above: no difference in what bears):
- **FS-133, Derived** (`plans/FS133-E1-derivation.md`, C133-ONE; row 129 refiled): `α₁(ℝ²) = m₁(ℝ²)` with no hypothesis, [hand],
  one mind. It makes G60's bearing unconditional — one class at a time is capped below six with no MR — and changes nothing in
  the plan. C133-PAIR (a transfer for forbidden label pairs at algebraic distances) is a neighbour of the structural form and
  is silent at six, by the coordinator's reading; unread here.
- **`[OAIMath2026]` family 156** (the stub's bearing line of 2026-10-07; `extension.tex`, `topology.tex`, `six-labels.tex` **read
  at statements only**): at the threshold number of labels a smooth admissible map to a simplex has a support complex whose
  facets all have `dim + 1` labels and sum to a mod-two cycle (its Theorem "Supports at equality"); for the projective plane and
  six labels that is the six-vertex triangulation — every pair of labels in exactly two triangles, every link a five-cycle.
  The seven-label analogue this project already holds a model of is the hexagonal colouring's nerve on a period torus (every
  pair of colours adjacent, every link a six-cycle). → **bears on card 3 and §IQ item 3 only**: the candidate invariant is a
  degree of the nerve map into the complex with triangles filled, and the unit distance must enter it (without the metric a
  three-coloured hexagonal tiling is all triangles). Its first step needs an open cover, so local slack (the reviewer's note);
  nothing in C132-EXT uses it.

**Silent:** G1–G12, G14, G16–G20, G23, G24, G27, G28, G31–G45, G48, G52–G59, G61–G63, G65, G66, G68–G70, G73–G78, G80, G81.
(Retired, carried elsewhere: G30, G46, G47, G49–G51, G67, G72.) G54's "slack" is another sense of the word (above).

**What the re-grokking changed in the plan.** (1) CORES is split from EXT and stated with no hypothesis (G79, G95). (2) EXT is
derived on a disc with the hypothesis read step by step (G92), and the island colouring is run as G95's test. (3) The readings'
verdicts are three, not two (G21). (4) RUN-EMPTY's dictionary puts clause (3)'s confinement where non-Siamese stood (G86).

## §PA — the prior-art gate

**The object in its disciplines' words.** *Combinatorial geometry:* measurable colourings of the plane avoiding distance 1 almost
everywhere; map-type colourings; the exclusion along an interface (`[SokolovVoronov2025]`, `[Voronov2023]`, `[Townsend2005]`,
`[Woodall1973]`, `[Thomassen1999]`). *Dimension theory:* Lebesgue's covering theorem — a cover of a square by small sets has
order at least three (`[HurewiczWallman1948]` Thm IV 2, held since FS131-LEB); the nerve of a cover and the canonical map to it;
the classical use on this problem is `[Raiskii1970]` and `[Woodall1973]` (three sets covering the plane realize all distances).
*Geometric measure theory:* a partition into measurable classes; the transition rate `D_ij(B, h)/|h|` is the directional
perimeter of the `i`–`j` interface in `B` where the classes have finite perimeter, and a cyclic centre is a point of the support
of three pairwise interfaces — a triple junction, with no regularity assumed.

**Searched, 2026-10-07 (UTC).**
- Web, two queries in the first discipline's words (six-colour forms of the release's statements; "transition graph", "cyclic
  centers", "exclusion continua" with the chromatic number of the plane): no page indexing the release, nothing on a six-colour
  form. Seen in a listing only.
- arXiv, the search listing for "chromatic number of the plane", newest first (the API returned 503; the listing was read through
  a fetch): the newest entries are arXiv:2606.28157 and arXiv:2606.12325, both held (`[DuczVarga2026]`, `[Ducz2026]`); **nothing
  dated from 2026-10-06 on**. Seen in a listing only.
- zbMATH Open API: three queries prepared (the question under "nerve", "covering dimension", "Sperner", "Lebesgue covering";
  Raiskii's paper; measurable colourings 2019–2026) — **the API returned 503 on each**. A prior-art debt, retried before the report.
- `BIBLIOGRAPHY.md`: `[OAIMath2026]` is held (l. 401), `[HurewiczWallman1948]` and `[VanderWoude2023]` (ll. 403–404);
  `[Raiskii1970]` is "Listing only … not held, unread" (l. 873).
- The release itself on six: "The remaining alternatives six and seven are unresolved." (`M/introduction.tex:70`, as the stub
  quotes it). Its Lean states at every `k` the pieces listed in the reading § 4.2; the extraction's assembly is typed `Fin 5`.

**Result.** Not found in print: the extraction stated at every `k`; any six-colour form of §§ 6–8. The statement C132-EXT is a
reading of a published proof at the class its argument carries — the argument is `[OAIMath2026]`'s; what is this project's is the
statement at `k`, the hypothesis read, and the consequences drawn.

## §IQ — the invariant question (G72)

1. **Existence form** (the stub, verbatim): "*Is there an object?* **Is there a measurable six-colouring of a closed disc of radius
   above 1 about a point `p`, proper at almost every unit pair inside the disc, in which `p` is a cyclic centre whose label cycle
   has length four and almost every palette on `p`'s ring holds one of the two labels outside the cycle?**"
2. **Structural form** (the stub, verbatim): "*About every solution, in the widest class where it makes sense.* **For every `k ≥ 5`
   and every measurable `k`-colouring of a large disc, proper at almost every unit pair — no regularity, no normal form — what must
   its cyclic centres carry: is a label cycle of length at least four forced at some centre exactly when `k ≤ 6`?**"
   *Checked:* not the existence form reworded — (1) asks for one object with a prescribed ring at one centre; (2) asks for
   something every colouring carries at every `k` and that tells six from seven.
3. **The invariant it forces:** none known; finding it is the milestone. What C132-EXT supplies toward it: at each *isolated*
   cyclic centre, for all small scales, a loop of the nerve map and a simple label cycle whose edges carry continua; candidates
   for the invariant are the stub's (the loop's class in the fundamental group of the complete graph, with the relation a disc
   imposes; G71's winding number where three labels are present).
4. **Route:** derivation only. Computation checks a derived shape on colourings given by formula.
5. **Open instances it would decide:** FS-123's first case (the (Q)-free ring with no class hypothesis) — by the existence form;
   whether route M's map step is on the road to seven; [G₆] in the measurable class.

## The readings, stated (for the claim list; sent to the coordinator)

**The data.** For a weak measurable six-colouring `c`, an **extracted centre** is what C132-EXT's conclusion gives: a point `x`
isolated in the set `𝓛` of cyclic centres; a simple cycle of labels `i_0, …, i_{ℓ−1}`, `3 ≤ ℓ ≤ 6`; a radius `ρ > 0`; and for
each `j` mod `ℓ` a compact connected `K_j ⊂ B̄(x, ρ)` with (1) `x ∈ K_j` and `K_j ∩ ∂B(x, ρ) ≠ ∅`; (2) a limiting direction `v_j`
of `K_j` at `x`; (3) `H_{i_j} ∩ Δ(K_j) = H_{i_{j+1}} ∩ Δ(K_j) = ∅`, where `H_i` is the closed essential support of class `i` and
`Δ(K) = {z : min_{q∈K}|z − q| < 1 < max_{q∈K}|z − q|}`; (4) `K_j ⊂ H_{i_j} ∩ H_{i_{j+1}}` (clause (4) is this job's addition,
derived with C132-EXT). **The toolkit** beside it: the statements of `[OAIMath2026]` §§ 5, 6, 8 that the reading § 4.2 marks
"uses the count? no" — palettes and their transport (Def. 5.1, Lemma 5.2), the 60° exclusion (Cor. 5.4), the avoiding trace
(Lemma 6.2), the two state lemmas with their count hypotheses (Lemmas 6.3, 6.4), the one-sided strips (Lemma 8.1), binary strip
rigidity (Lemma 8.6).

**The dictionary** (map → measurable): a vertex `p` of at least four colours → an extracted centre `p` with `ℓ = 4`; a tile of `p`
of colour `c` → the label `c` of the cycle with its two continua and its support `H_c`; an interior point of a tile of colour `c`
→ a density-one point of class `c`; the ring off `Γ` → the palette `P_p(e)`; "a ring carrying no (Q) arc" → "almost every palette
`P_p(e)` contains one of the two labels outside the cycle"; a tip at `y` → a label `c` of the cycle with `y ∈ H_c`. **No
counterpart is assumed** for: non-Siamese, simple, a tile's sector at a point, the cyclic order of tiles at a point, an edge
shared by two tiles, finitely many tiles meeting a small disc. Where the map used "the same tile", the measurable side has only
clause (3) in its confinement form: for `z ∈ H_c`, `c` an endpoint label of `K_j`, either `K_j ⊂ B̄(z, 1)` or `K_j ∩ B(z, 1) = ∅`.

**C132-RUN-EMPTY.** *Statement:* each step of the route FS116-V6 § 2.2 (`plans/FS116-V6-verification.md`: V6-DIAM, V6-E1, V6-DICH,
V6-RING, V6-WIN, V6-GERM, V6-TIP, V6-HUBS, V6-ANTI, V6-HUG, V6-COUNT, read with FS129-SR3-EMPTY-NS's sector form of the last)
has a restatement under the dictionary, true of every weak measurable six-colouring of an open set containing a closed disc of
radius above 1 about an extracted centre `p` with `ℓ = 4` whose palettes almost everywhere contain a label outside the cycle,
derived from the data, the toolkit and that ring hypothesis alone; and the restated steps end in a contradiction — so that no
such colouring exists (**C132-M-EMPTY**, the existence form's NO, named here so that it can be derived by another route).
*"Runs"* is the verdict `derived`. The other two verdicts: `stalls at:` the first step, in the route's order, with no derived
restatement, with the left-hand term of the dictionary it reads; `refuted:` a weak measurable six-colouring by formula in
C132-M-EMPTY's class. *Not claimed:* that C132-M-EMPTY is false if the route stalls; anything at a centre whose ring is not of
that kind (the (Q) rings, FS-124); anything at `k ≠ 6`; that the extraction ever returns `ℓ = 4`; that a point whose transition
graph contains a four-cycle is an extracted centre.

**C132-RUN-CV.** *Statement:* each input of the route to FS114-CV-EXISTS (`plans/FS114-CVB-verification.md` § 1.4, by the entry's
`uses only:` — FS112-N3-DENSE3, FS112-N2-TERM with its terminal modification `M*`, N4-FIN, and "a modification creating no unit
arc keeps a four-colour vertex's colours at the vertex") has a restatement under the dictionary, true of every weak measurable
six-colouring of the plane whose cyclic centres are finite in every closed disc, derived from the data and the toolkit alone;
and the restated steps give an extracted centre with `ℓ ≥ 4` (**C132-M-CV**, [G₆] in the measurable class under C132-EXT's
hypothesis). Verdicts as above; a `stalls at:` names the input and what it modifies or counts. *Not claimed:* that C132-M-CV is
false if the route stalls; that a six-colouring whose extracted centres are all triangles exists; card 3's statement; anything
without the hypothesis on the centres.

## The route

**Stages of FS132-E1** (each saved in `plans/FS132-E1-derivation.md` and committed before the next; each is hand work, minutes
to an hour, no run over a minute; a kill redoes the stage in progress and nothing saved):
1. The readback and this plan. *Checkpoint:* this file, committed.
2. Recognition on C132-EXT (`ephodos-recognition`, fresh). *Stop rule:* a description under which the statement is forced, or
   the stranger's statement.
3. C132-CORES and C132-EXT: the manuscript's § 7 walked with `k` labels, each step's reading of the count and of the centres; the
   two controls at seven; the conclusion at six as a list. *Stop rule:* an entry with its verdict; a step that reads five is a
   statement defect against `plans/EXT-OAI2-reading.md` § 4.2 and a message.
4. (if context allows; else the second job) C132-RUN-EMPTY, then C132-RUN-CV, C132-DIAG, C132-RADIUS.

**Failure clauses.** The stub's stand. Added: if the derivation of EXT needs a clause the posed statement lacks, the clause is
built into the statement and reported, never patched silently; if a reading's dictionary proves too poor to state a step, that is
a `stalls at:` with the missing term named, and the frame is attacked there (is the extraction's conclusion the right object?).

**Registered predictions** (each scored at the record job; registered after reading the manuscript's §§ 6–7 and before writing
any argument — said because a prediction made after the reading is worth less):
- **P1** C132-EXT holds as posed at every `k`: 0.93. *Decides:* whether the cards are asked on its conclusion as posed.
- **P2** C132-CORES holds with no hypothesis on the centres, on every closed disc of radius above 1: 0.90. *Decides:* whether
  "centres exist at every `k`" is filed as the first invariant every solution carries.
- **P3** "closed and totally disconnected" suffices for the continua *by the manuscript's argument*: 0.05; some hypothesis weaker
  than finite suffices by another argument: 0.55. *Decides:* whether card 2 is a derivation job or closed here.
- **P4** C132-RUN-EMPTY: `derived` 0.45, `stalls at` a step reading sectors at a hub 0.45, `refuted` 0.10. *Decides:* how the
  second job is cut. (The asking lane's 0.60 for "runs".)
- **P5** C132-RUN-CV `derived`: 0.10. **P6** C132-DIAG holds: 0.75; C132-RADIUS holds as posed: 0.85.
- **P7** this milestone decides six against seven: 0.02 — an instrument, never a reason to aim lower.
