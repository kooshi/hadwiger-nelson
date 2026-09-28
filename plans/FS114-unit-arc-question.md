# FS-114 — the unit-arc question: is there a valid six-map with unit arcs? Its central statement, the global step: can such a map have a vertex of four colours or a repeated colour within 3 of every point? (the plan)

*Written by the milestone planner (job FS114-P; de Bruijn, Opus 5.5), 2026-09-27, by WORKFLOW steps 3–5, from the brief
`data/fs114/briefs/P114-planner.md` and `data/fs114/briefs/STANDING-RULES.md` (both read in full, rule 0 first). The stub is
`plans/STUB-global-step.md`; its sibling stubs `plans/STUB-stuck-ray.md` (FS-115) and `plans/STUB-reg-scale.md` (FS-111). The close inventory is
`plans/FS114-close-inventory.md` (opened empty at stage 1; the owner is its only writer). The fixed claim list is `data/fs114/claims.md`; working files
are under `data/fs114/fs114-p/`; exact checks under `tools/fs114_p_*.py`. Stages are saved and committed one at a time (standing rule 2).*

## Theorems this phase proved

None. A planner states claims and derives nothing that the milestone's jobs are to derive (the brief: "Do not derive the global step yourself; the jobs
do."). Every mathematical sentence below is a quotation with its address, a reading graded as such, or a statement of what a phase is to decide.

## Would-have-searched-here log (standing rule 3)

- Stage 1: none.

## Stage 1 — SAVED: files read from disk, and the quotation check (standing rule 5)

### 1.1 Files read from disk (this order)

1. The brief and `STANDING-RULES.md`, in full (rule 0 first).
2. `CLAUDE.md` § The aim and § Counter-priors, from disk (lines 74–140); then G82 and G83 from disk. The session's loaded copy of `CLAUDE.md` matches the
   disk at a9410925 (the programme line names "FS-114, the unit-arc question"; § Paths forward row 1 and G83 read identically), so the rest of `CLAUDE.md`
   was read from that copy; the size on disk is 298,978 bytes.
3. `LEDGER.md`: the header and the claim list; rows 1–130 by their first 420 characters (the mechanism and the headline); rows 131–136 in full.
4. `plans/STUB-global-step.md` in full; `plans/STUB-stuck-ray.md` in full; `plans/STUB-reg-scale.md` in full.
5. FS-112's close: `plans/FS112-unit-arc-half.md` §R-close stage 3 (3.0–3.6) in full; `plans/FS112-derivation.md` §§1–3 in full and §4's entries by
   headline; `data/fs112/fs112-c/reconciliation.md` §§1.5–1.11 in full; `data/fs112/claims.md` §§0–1 and §§7–11 in full (§§2–6 by heading — their
   verdicts are in §11).
6. `plans/POROS-2026-09-27-night-aim.md` in full (§3's cards 1–3; §5's hunches; §6).
7. `plans/PROTOCOL-competitor-and-advisor.md` §§0–1 in full (rules 1–14, as amended at FS-112's close) and §3's tenth and eleventh runs.
8. `plans/FS112-close-inventory.md` items 1–16 and 59–80 (the header copied into `plans/FS114-close-inventory.md`).
9. `data/fs112/fs112-pa/extracts.md` on `[16.263]`–`[17.282]` (the Sirgedas, Siamese and slack-pair comments), and `BIBLIOGRAPHY.md` on `[Oostema2020]`.
10. WORKFLOW steps 3–5 and `DEBRUIJN.md`: from the session's loaded copies (both unchanged since 2026-09-23 by `git log`; checked at stage 2).

### 1.2 The quotation check

`tools/fs114_p_quotes.py` (normalises whitespace, typographic quotes, backticks, bold and italic markers; exits 1 on any MISSING). Output
`data/fs114/fs114-p/quotes.out`: **18 of 18 FOUND** — Kooshi's three quotations in the brief (`CLAUDE.md`; `plans/FS112-close-inventory.md` items 59 and
70), the stub's head question and "Choosing the form is the milestone's first decision." (`plans/STUB-global-step.md`), card 2 and its falsifier and
hunch and §6's "A local exclusion about **one** four-colour vertex would be the whole NO, with no ray step and no density" (`plans/POROS-2026-09-27-night-aim.md`),
Sirgedas's phrase (in `data/fs112/fs112-pa/extracts.md`, `[16.317]`, and with "[sic]" in the inventory's item 16), "search for a finite graph is out.",
the name ruling (item 77), and the standing rules' four quotations of Kooshi. **Control:** `--self-test` alters one word ("within 3" → "within 2") in
the stub's head question; the altered twin reads MISSING and the faithful one FOUND (`data/fs114/fs114-p/quotes-selftest.out`: PASS). Later stages add
their quotations to the same checker (`--file`), and every quotation the claim list uses is run through it before the claim list is committed.

### 1.3 Findings of the check (none changes a statement)

1. **A precision of address, not a misquotation.** The brief places "`[16.317]`, in the Google group hadwiger-nelson-problem". `[16.317]` is a **held**
   comment — de Grey, Polymath16 thread 16, 2020-10-31 (`data/fs112/fs112-pa/extracts.md` l. 565) — which *mentions* the near-proof; the near-proof itself
   is what lives in the Google group and is unheld. The debt is recorded at §PA with that address.
2. **The held context of `[16.317]` says more than the brief quotes**, verbatim: "(This would strengthen the old result of Thomassen, wich applied only to
   scaleable tilings.)" So de Grey's own reading of Sirgedas's target is "non-Siamese", against Thomassen's "scaleable" — two different hypotheses, and
   `[14.160]` / `[15.19]` record the threads disagreeing about which one Thomassen leaves. The claim list states both and keeps them apart.
3. **`[17.282]` carries a second slack statement** the stub does not quote (verbatim): "But we can also say that no two TPs that share exactly one colour
   can be less than d^2-1 apart." It is the slack twin of a one-shared-colour pair lemma, and a candidate for §IQ's structural form (stage 3).
4. **The brief's "the night advisor's §6 form" is one mind over FS112-C-ENDS** (NIGHT-A §6: "one mind, mine, over the close's links"), and C-ENDS is itself
   one mind outside a named residue (`plans/FS112-derivation.md`). The form decision (stage 5) carries that grade.

## Stage 1 — SAVED

## Stage 2a — SAVED: §G part 1, the grokkings G1–G83 (WORKFLOW 3.1; `CLAUDE.md` at a9410925)

*Correction to 1.1 item 10: WORKFLOW.md and DEBRUIJN.md last changed at d2df03c1 ("FP: stage 4"), before this session began; the loaded copies are the
disk's.*

*One line per entry: **bears** (what it says about this milestone's object and the phase it changes), **silent** (why), or **falsifiable here**
(registered in stage 5). The object is FS-112's: a **valid map** — locally finite, bounded by segments and circular arcs, arcs of radius 1 allowed, a
six-colouring with no two interior points of one colour at distance exactly 1 (`plans/FS112-derivation.md`, header). No field, lattice, residue plane or
finite graph enters it, so most of the arithmetic corpus is silent for one reason, recorded once as FS-112 did: **(F)** "the entry is about
unit-distance graphs over a field, lattice Cayley graphs, residue planes or finite witnesses; the object here is a map of `ℝ²` read almost everywhere".
Phase labels (defined at stage 5): **N** the proof side, **Y** the construction side, **NB**, **YB** their blind verifiers, **CV** second minds on
FS-112's composition, **R0** BASE-V's repair if a step fails, **A** a competition advisor, **close**.*

| G | verdict | reason, and the phase it changes |
|---|---|---|
| G1 field wall | silent | (F) |
| G2 construction grammar | silent | (F); a (Q) centre is a "ring-heart" only in the loose sense that unit arcs ring it — no rotated copy |
| G3 radially crystal | silent | (F) |
| G4 one shell vocabulary | silent | (F) |
| G5 ownership factorization | silent | (F) |
| G6 hexagram is fabric | silent | (F) |
| G7 detuning | silent | (F) |
| G8 direction group | silent | (F) |
| G9 rigidity at the forcing level | silent | (F); the map question is itself the top rung (maps need six, row 132), so "ask one rung below" has no rung |
| G10 forcing distributed | silent | (F); its "expect no organ" is G17's claim for card 2, taken there |
| G11 Moser-free five | silent | (F) |
| G12 quadrature law | silent | (F) |
| G13 fan ladder | **bears** | a colour step is confinement at a centre, a k-set count invisible to pair statements; every NO lemma of FS-112 that lasted is a vertex count (SIX, NB4P, A4SIX, NOBOTH), and the pinned corner is a coverage failure (a colourless cone). → N: state each local lemma as what `ω(v)` and the rhombus completions must cover at a four-colour vertex, before any pair statement; Y: read each stop as a coverage failure and name the colour missing |
| G14 width without degree | silent | (F) |
| G15 pigeonhole × kill | **bears** | card 2's two answers are the two halves of one shape: a count over the plane is Act One (an unavoidable set — DENSE3 already is one, `F ∪ R` within 3), the local exclusions are the kills (reducible configurations) — the four-colour theorem's architecture. → N: the global route is "unavoidable set by a count × each member excluded locally"; the claim list keeps C-ACT1's clause that a list of kills with no Act One decides nothing |
| G16 distance-2 pigeonhole | silent | (F) |
| G17 globality at the top rung | **falsifiable here** | card 2's hunch ("global") rests on it: sub-rung compulsions have small carriers (FS-112's lemmas all read radius ≤ 3), the top rung arrives "at the last vertex". Registered (E-LOC); falsifier: an explicit radius `R` with every valid fragment about a four-colour vertex excluded. → N: every step states the radius it reads |
| G18 composition sees what search cannot | silent | a SAT-composition rule; nothing here is solved |
| G19 5-tight fabric | silent | (F) |
| G20 brick colourings | **bears** | a tight colouring by force, certified exactly: CAL-7. → Y, YB: every new tile checker accepts the brick and the hexagonal seven-colouring before any refusal is believed; the strip and the disk as FS-112 rebuilt them are the six-colour calibrations |
| G21 a negative measures its enumeration | **bears** | FS-112's registration miss was this rule (E1's acceptance test "sufficient-looking and … not the step's condition"). → every registration (stage 5) names its population and whether its acceptance test is the step's exact condition; Y: a family of formula candidates that all fail measures the family's image (free parameters counted against the configuration's); an exclusion "of every valid fragment on `B(v, R)`" states the class of fragments it quantifies over |
| G22 where a six-colouring cannot live | **bears** | polygonal and Condition-5 maps need seven (rows 132, 134), so a YES has unit arcs and non-polygonal tiles. → Y: no candidate without a unit arc; the (Q)/(R2) reduction (FS112-N2-RED) says which arcs a candidate may carry |
| G23 refining not a route down | silent | the cell family |
| G24 gap law | **bears** | the step to seven is integrality, never a relaxation. → failure clause: no argument one class at a time; a count over the plane must count configurations of several classes together |
| G25 forcing ladder recursive | silent | (F) |
| G26 six-forcer reduction | silent | (F) |
| G27 hidden arithmetic symmetry | silent | (F) |
| G28 fine-tail forcing factors | silent | (F); its method half ("say which classes a sweep swept") is G21's |
| G29 the cell family closed | **bears** | its comparison is `[Voronov2023]` Thm 1.3's radius-3 disc: for **closed** classes the NO is local with an explicit radius, 3. The precedent for card 2's "local" answer, lost where closedness is lost (row 132: closed classes are the tight question itself). → N: ask what of Thm 1.3's radius-3 argument survives for a.e.-proper maps with unit arcs, and name the step that closedness bought |
| G30 measurement generates, derivation kills | **bears** | the next room: the question sits between planar-map colouring (discharging, Euler characteristic, combinatorial curvature) and convex geometry of diameter 1 (Reuleaux polygons); "write it for an outside reader" is §PA's naming; failure mode 5 (a theorem over an empty domain) — every statement about a valid map is about a possibly empty class. → §PA; the claim list's header; N: the count is written in the curvature room's words |
| G31 no held object carries a top-rung compulsion | silent | (F) |
| G32 two-distance dial | silent | (F) |
| G33 batches compose | silent | a descent-search rule |
| G34 field is the selection | silent | (F) |
| G35 wall is 2-adic | silent | (F) |
| G36 residue colouring | silent | (F) |
| G37 endgame's shape | silent | (F) |
| G38 linear method's thresholds | silent | (F) |
| G39 redundancy before rigidity | silent | (F) |
| G40 absorption | silent | (F); its map shadow (a region with a spare colour extends) is the hole-filling tool of row 132, which FS-112 found fails exactly where no colour is free (the pinned corner) — used under G13 |
| G41 additive colourings | silent | (F) |
| G42 additive rigidity | silent | (F) |
| G43 residue plane seals fields | silent | (F) |
| G44 Kloosterman control | silent | (F) |
| G45 lifts | silent | (F) |
| G46 recognise the classical theory first | **bears** | name the object where it lives: an infinite locally finite planar map whose faces have diameter at most 1 and whose vertex types are constrained — combinatorial curvature, discharging, unavoidable sets, Euler characteristic of the torus for periodic maps; the (Q) skeleton as a dual graph (Sirgedas's quads and arrows); read the exact rebuilds' data layout (FS-112's checkers' input format) as well as the plans' words. → §PA; N stage 1; Y reads `tools/fs112_yb2_objects.py`'s data before designing |
| G47 compulsion face of sealing | silent | (F) |
| G48 tightness mechanism | silent | (F) |
| G49 prior-art gate | **bears** | §PA in the discipline's words (discharging, curvature, tilings, Reuleaux); grep the held Polymath16 threads and the 55 held Geombinatorics issues for the headline object; zbMATH `ti:`, `au:` and all-field beside `ab:`. → §PA |
| G50 read what the search found | **bears** | unheld or unread items touching the milestone block it until scanned: Sirgedas's argument (unheld; Kooshi's call), Hockertz's manuscript and the wiki's tile-rule page (unheld), `[Oostema2020]` (abstract only), the Geombinatorics issues after April 2021. → §PA records each with its reading status; N and Y read, at stage 1, the held sections §PA names |
| G52 breaking the wall | silent | (F) |
| G53 counting compulsion | silent | (F); its shape (a count on a circle about a designated point) is G13's here |
| G54 tight or slack | silent | (F); "tight" there is Hoffman's, not the map's (slack for no `ε`) |
| G55 unit-vector ring | silent | (F) |
| G56 window for six | silent | (F) |
| G57 window triangle-free | silent | (F) |
| G58 antipodal conjecture | silent | (F) |
| G59 wall at six | silent | (F) |
| G60 fractional colourings | **bears** | one class at a time the bound is `⌈1/α⌉ ≤ 5` (row 129). → failure clause; N: a discharging count must not reduce to a density bound on one class (a charge per tile of one colour is such a reduction) |
| G61 three colours break at arithmetic | silent | (F) |
| G62 twisted bilayers | silent | (F); its commensurate ⟹ finite quotient is G68's periodic reading, taken there |
| G63 transcendence free | silent | (F) |
| G64 six may be a value no field attains | silent | (F); its warning (skipping is not evidence for seven) is general and kept |
| G65 refusal phase diagram | silent | SAT balls |
| G66 tower | silent | (F) |
| G67 grokked by form | **bears** | → close: every statement minted is written with its trigger, *Do* and killing test or what it forbids; this §G's verdicts are scored for how many came from *Do* lines (its killing test) |
| G68 quotient before ball | **bears** | its periodic principle in map form: a doubly periodic valid map is a valid map on a torus, where `V − E + F = 0` holds exactly and FS112-N3-PER gives a periodic terminal modification. → N: run any count on the torus first (no averaging, no boundary), then on aperiodic maps by Følner averaging; Y: every periodic candidate is a finite torus map checked exactly |
| G69 rigidity arithmetic | silent | (F) |
| G70 √3-clean is residue | silent | (F) |
| G71 three colours linear; the index at a swap | **bears** | row 132: the index of density traces "fails where a unit-arc interface faces a bowtie"; FS-110's winding transport fails across same-type edges (YB3-SAME). A winding or index invariant is the natural "global" certificate and has a recorded failure exactly at this milestone's configurations. → N: a topological-degree route must say what it does at a swap; E12 (G71 at a bowtie seam with unit arcs) stays falsifiable (FS112-BOWTIE is a bowtie with unit arcs; its seam is the test object) |
| G72 invariant question | **bears** | → §IQ (stage 3) |
| G73 four colours cell by cell | silent | (F); lattice colour complexes |
| G74 layers | silent | (F) |
| G75 triangles and linear identities | silent | (F) |
| G76 local theorem, global extension | silent | (F); its shape ("local rigidity, then realisability") has a map shadow — a local fragment realised versus extended — which is G82's and G83's here |
| G77 character colourings | silent | (F) |
| G78 frozen walls | silent | (F); its moral (moves cannot see a frozen part) is FS-112's stuck chain, where merges and shaves fail — FS-115's, taken there |
| G79 example invariant | **bears** | DENSE3, U1, NB4P, N2-RED and COR3 are example invariants; the walls (the stuck ray, the pinned corner) were counterexample invariants, and the pinned corner flipped (C-PARTNERS). → §IQ asks what every valid map carries at its four-colour vertices; Y reads every stop as a statement about every valid map before designing past it; the close records the kind of each result |
| G80 infinite rank | silent | (F) |
| G81 field is the plane | silent | (F) |
| G82 stability; the printed chain first | **bears** | the limit object is a map (W-EQ-K); look first for the printed regular theorem's own chain (S–V Cor. 1 and Woodall's degree reduction, already made curved); price certificates at the feature's scale. And its compactness half: at a fixed complexity bound the class of valid fragments is closed under Hausdorff limits (W-EQ-K's), so if Q-full_K's NO holds some radius `R(K)` excludes every valid fragment on a disc — the NO is local at each `K`, non-explicitly. → claim C-COMPACT (stated, not derived here); N: card 2 is then about an **explicit** `R` and its uniformity in `K`, not about truth |
| G83 four-colour vertices | **falsifiable here** | the milestone's own entry: the theorems hold unless row 134's base fails (BASE-V); its reading's killing test is "FS-114 decided by an argument that reads no such vertex". → N: every route says which vertices of `F ∪ R` it reads; the close scores the reading; Y follows its *Do* (list `F`, `R`; read both rhombus corners of every close complementary pair) |
| G51 competitor and advisor | **bears** | at FS-112 every truth divergence came from a blind verifier and the sides met twice without contact. → staffing (stage 5): a proof side against a construction side, a blind verifier per side, retractions counted |

**Tally of part 1:** 83 entries — bears 25 (G13, G15, G20, G21, G22, G24, G29, G30, G46, G49, G50, G60, G67, G68, G71, G72, G79, G82, G51, and the
falsifiable G17, G83 also bear), silent 58, falsifiable here 2 (G17, G83; with E12 under G71). Drawn from a *Do* line: G13, G15, G20, G21, G22, G29 (its
comparison clause, in the body), G46, G49, G50, G60, G67, G68 (its body's periodic principle, not its *Do*), G71 (body), G79, G82 (*Do* and body), G83.

## Stage 2a — SAVED
