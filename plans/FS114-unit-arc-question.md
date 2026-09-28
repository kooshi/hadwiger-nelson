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
- Stages 2–6: none. The §PA queries (zbMATH, Semantic Scholar, greps of held texts) are reading, not a search for a witness; no map,
  colouring, tile graph or configuration was enumerated or scanned. The one computation run was the quotation checker.

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

**Tally of part 1** (corrected at stage 2b; the saved count read 25 and 58): 83 entries — bears 19 (G13, G15, G20, G21, G22, G24, G29, G30, G46, G49,
G50, G60, G67, G68, G71, G72, G79, G82, G51), falsifiable here 2 (G17, G83, both also bearing; with E12 under G71), silent 62. Drawn from a *Do* line: G13, G15, G20, G21, G22, G29 (its
comparison clause, in the body), G46, G49, G50, G60, G67, G68 (its body's periodic principle, not its *Do*), G71 (body), G79, G82 (*Do* and body), G83.

## Stage 2a — SAVED

## Stage 2b — SAVED: §G part 2 (the rows; the method rules) and part 3 (the extraction)

### §G part 2a — `LEDGER.md` rows (rows 131–136 in full; rows 1–130 by headline and mechanism; (F) as in part 1)

- r1 silent — a graph on two circles (F)
- r2 silent (F)
- r3 silent (F)
- r4 **bears** — fan ⟺ coverage: the count at a centre (G13) → N
- r5 silent (F)
- r6 silent — the 120° identity: elementary geometry, nothing here
- r7 silent — greedy colouring
- r8 silent — de Grey's balance (F)
- r9 silent (F)
- r10 silent (F)
- r11 silent — the "strip automaton" is a graph tube, not a geometric strip
- r12 silent (F)
- r13 silent (F)
- r14 silent (F)
- r15 silent (F)
- r16 silent (F)
- r17 silent — two circles meet in {point, mirror}: elementary geometry the local lemmas use, nothing more
- r18 silent (F)
- r19 silent (F)
- r20 silent (F)
- r21 silent (F)
- r22 silent (F)
- r23 silent (F)
- r24 silent (F)
- r25 silent (F)
- r26 silent (F)
- r27 silent (F)
- r28 silent (F)
- r29 silent (F)
- r30 silent (F)
- r31 silent (F)
- r32 silent — the hex-shell pigeonhole in the `{1, √3, 2}` distance graph (F)
- r33 **bears** — the classical interval's brick colouring is CAL-7, the tight seven-colour control (G20) → Y, YB
- r34 silent — coset colourings; the polygonal floor is carried by G22
- r35 silent — cell family
- r36 silent — cell family
- r37 silent — cell family
- r38 silent — cell family (its pigeonhole × kill is G15's)
- r39 silent — cell family
- r40 **bears** — `[Voronov2023]` Thm 1.3 verified at FS-106: closed classes need seven on a disc of radius 3 — card 2's local precedent (G29) → N
- r41 **bears** — the limit lemma: bounded families in one compact region; compactness in the kernel, the graph-side ancestor of C-COMPACT (G82) → N stage 1; a kernel note for the close
- r42 silent (F)
- r43 silent (F)
- r44 silent (F)
- r45 silent (F)
- r46 silent (F)
- r47 silent (F)
- r48 silent (F)
- r49 silent (F)
- r50 silent (F)
- r51 silent (F)
- r52 silent (F)
- r53 silent (F)
- r54 silent (F)
- r55 silent (F)
- r56 silent (F)
- r57 silent (F)
- r58 silent (F) — minimal gadgets in a host graph
- r59 silent (F)
- r60 silent (F)
- r61 silent (F)
- r62 silent (F)
- r63 silent (F)
- r64 silent (F)
- r65 silent (F)
- r66 silent (F) — the fan gap frees pairs on graphs; its map shadow is the colourless cone, used under G13
- r67 silent (F)
- r68 silent (F)
- r69 silent (F)
- r70 silent (F)
- r71 silent (F)
- r72 silent (F)
- r73 silent (F)
- r74 silent (F)
- r75 silent (F)
- r76 silent (F)
- r77 silent — the theorem audit's method is WORKFLOW's step 9, followed at the close
- r78 silent (F)
- r79 silent (F)
- r80 silent (F)
- r81 silent (F)
- r82 silent (F)
- r83 silent (F)
- r84 silent (F)
- r85 silent (F)
- r86 silent (F)
- r87 silent (F)
- r88 silent (F)
- r89 silent (F)
- r90 silent (F)
- r91 silent (F)
- r92 silent (F)
- r93 silent (F)
- r94 silent (F)
- r95 silent (F)
- r96 silent (F)
- r97 silent (F)
- r98 silent (F)
- r99 silent (F)
- r100 silent (F)
- r101 silent (F)
- r102 silent (F)
- r103 silent (F)
- r104 silent (F)
- r105 silent (F)
- r106 silent (F)
- r107 silent (F)
- r108 silent (F)
- r109 silent (F)
- r110 silent (F)
- r111 silent (F)
- r112 silent (F)
- r113 silent (F)
- r114 silent (F)
- r115 silent (F)
- r116 silent (F)
- r117 silent (F)
- r118 silent (F)
- r119 silent (F)
- r120 silent (F)
- r121 silent (F)
- r122 silent (F)
- r123 silent (F)
- r124 silent (F)
- r125 silent (F)
- r126 silent (F)
- r127 silent (F)
- r128 **bears** (bearing only) — given MR the plane's number is a field's: a NO reaches `χ(ℝ²) = 7` only through rows 128 and 131 and FS-111's door
- r129 **bears** — row 123's five is one class at a time, capped at `⌈1/α⌉ ≤ 5` (G60) → failure clause
- r130 **bears** (bearing only) — `χ_CP = χ_m⁰`: a YES gives `χ(ℝ²) ≤ 6` with no MR (link 2)
- r131 **bears** — the stability equivalence and its two proof no-gos (hole counts capped at `O(ε)`; trichromatic points invisible to partial colourings): they bind arguments on near-colourings; FS-114's NO is on full, tight maps (W-EQ-K moved the question there), so a count at vertices is not capped by them → N states which side of W-EQ-K it works on
- r132 **bears** — hole-filling fails exactly at bichromatic vertices of degree ≥ 4; the index fails at a unit-arc interface facing a bowtie; maps need six (Woodall; Townsend); S–V Question 2 is the question → N (the printed tools and where they stop), §PA
- r133 **bears** — W-EQ-K: at complexity `K`, vanishing-hole designs ⟺ a valid map of complexity `≤ K`; so FS-114 decides Q-full_K for each `K` and must cover aperiodic limit maps; W-TAN (complementary vertices within 2 are tangent pairs or bowties) → claim list (Q-full, Q-full_K), N
- r134 **bears** — the Condition-5 NO: a local base (radius 2 about a cubic trichromatic vertex) plus moves plus one non-local step, the cone's bi-infinite chain along a line (N4-FIN) — the only non-local step held; its base's print steps are BASE-V's → N (card 2), R0
- r135 **bears** — the milestone's statement and its inputs: DENSE3, N3-BASE, N2-RED, NOBOTH, COR3, C-ENDS, C-COMPOSE → every phase; CV second-minds C-ENDS, C-COMPOSE, C-PARTNERS
- r136 **bears** — the controls and card 2's lower bounds: a valid fragment on the disc of radius `H/2 = √15/4 + √3/2 ≈ 1.834` about a four-colour midline vertex (the strip), and on `B̄(A_0, φ)` about a four-colour corner (the disk, attained); the pinned corner is where a second four-colour vertex is needed → N (any explicit `R` exceeds 1.834), Y (the dial)

**Tally of part 2a:** 136 rows — bears 13 (r4, r33, r40, r41, r128–r136), silent 123.

### §G part 2b — the method rules (`CLAUDE.md` § The standard of evidence, § What compute helps, § The shape of the proof, § Trust ledger, § Toolchain, § Building, § Searching, § The gate, § Make the gate fail; § Delegation; § Counter-priors)

| rule | verdict | reason → phase |
|---|---|---|
| no native evaluation in the headline | silent | nothing here is kernel-evaluated |
| the artifact is the certificate plus the checker | **bears** | a YES is a map by formula plus an exact checker a reviewer re-runs → Y, YB |
| the witness must be re-derivable | **bears** | every candidate stated as a construction rule, not coordinates → Y |
| read the final statement aloud | **bears** | the claim list's NO is read against S–V Question 2's and `[Polymath2021]` p. 199's words → claim list, close |
| report the hunt honestly | **bears** | every failed candidate family recorded with its image → Y |
| write the certificate for the reviewer early | **bears** | Y writes, at design time, what a reviewer must check of a candidate; N writes, for each lemma, what a verifier must re-derive → Y, N |
| order verification by marginal value | **bears** | checkers run the decisive pair first → Y, YB |
| what compute helps; kernel pricing | silent | no kernel work planned in the contest (the Lean lane is a decision of stage 5) |
| the shape of the proof (rung B) | silent | rung B |
| trust ledger | silent | no Lean in the contest; the close's kernel decisions ("stub — with FS-114" on 40 of FS-112's entries) are named at stage 5 |
| the ban and Kooshi's ruling beyond it | **bears** | candidates by formula, checked exactly in seconds; no search for maps, colourings or configurations → every brief's "would have searched here" log |
| `scripts/slot.py`; RAM the discriminator | **bears** | any exact check above 2 GiB or 2 minutes → every tool-running job |
| Python 3.14 `forkserver` | **bears** | any multiprocessing checker passes a `fork` context → Y, YB |
| symmetry-break before SAT; pysat interrupts | silent | no solver |
| build through `scripts/build.sh` only | silent | no Lean in the contest (stage 5's Lean-lane decision cites it) |
| halt on any unexplained crash | **bears** | every brief |
| the checkpoint rule (PROTECTED) | **bears** | every job saves stage by stage; any exact run over 15 minutes checkpoints, its resume command written in its record → every brief |
| a run that blocks something is killable | **bears** | the owner's rule for BASE-V's and FS-111's jobs against FS-114's phases; no job here should run long |
| kill by PID; verify a kill by effect | **bears** | every brief |
| a pipe can kill the producer | **bears** | exit statuses read directly → every brief |
| never edit a running script | **bears** | tools run from their committed form |
| searching: `ugrep`, `rg -uu`, `exact?` | **bears** (the first two) | §PA's greps use `grep -F` or `rg`; completeness questions `rg -uu` |
| the gate: vacuity | **bears** | every statement about valid maps quantifies over a possibly empty class; the claim list says so; a Lean statement of the NO would carry `VACUITY DECLARED` or an inhabitant — the NO's domain is empty exactly when it is true |
| every structure-hypothesis ships an inhabitant | **bears** | each local lemma about fragments names a held fragment it applies to (the strip, the disk, BOWTIE) → N, NB |
| negative controls, planted faults | **bears** | every checker plants a fault that fires for its own reason, beside a faithful twin → Y, YB |
| both outcomes reachable | **bears** | every registration of stage 5 |
| a one-sided filter's applicability | **bears** | a local exclusion is one-sided: "does not apply" is not "excluded" → N, NB |
| the generator's image and a parameter count | **bears** | Y's families |
| an exact tile checker's ACCEPT is the suspect verdict | **bears** | every ACCEPT prints pairs examined against pairs the map has → Y, YB |
| a caveat written and stepped over | **bears** | the form's grade (one mind over C-ENDS, with a residue) travels into every summary → report, claim list |
| a true explanation stops the search | **bears** | a candidate failing one gate is checked against all before use as a test case → Y |
| delegation one level deep | **bears** | every brief, with its reason |
| the crunch | silent | not a crunch |
| Counter-priors rules 1–4 | **bears** | rank the routes by bearing; registered `p` never caps; "say what it would take and start"; the standard of evidence does not move → stage 5 |

### §G part 3 — the extraction (each *bears* as an instruction to a phase; carried into stage 5's phase table and the briefs)

1. **Card 2 first, reframed by compactness** (G17, G29, G82; r40, r41, r134, r136) → **N stage 1**: before any route, decide the claim C-COMPACT (at each
   complexity bound `K`, Q-full_K's NO holds iff some radius `R(K)` admits no valid `K`-fragment on a disc; a reading of the planner's, not derived);
   then card 2 is about an **explicit** radius, uniform in `K` (a local NO, which would reach Q-full too, row 134's chain using no bound), against a
   count whose contradiction appears only at a scale set by the map. Every step states its reading radius; any explicit `R` exceeds `H/2 ≈ 1.834`.
2. **The G15 architecture** (G13, G15; r4) → **N**: the global route is "an unavoidable set by a count × each member excluded locally"; DENSE3 is
   already an unavoidability statement with unavoidable set `F ∪ R`; each local lemma is a coverage count at a centre (the vertex, its (Q) arcs'
   ends, the rhombus completions).
3. **Voronov's radius 3** (G29, r40) → **N stage 1**: name the step of `[Voronov2023]` Thm 1.3 that closedness buys, and whether a map with unit arcs,
   read almost everywhere, can replace it — the one printed explicit-radius NO in the neighbourhood.
4. **The torus first** (G68) → **N**: any count runs on a doubly periodic valid map, a map on a torus (`V − E + F = 0` exactly, FS112-N3-PER), before
   the aperiodic case (Følner averaging over a plane of quadratic growth); **Y**: every periodic candidate is a finite torus map checked exactly.
5. **Swaps** (G71, r132) → **N**: a winding or index route says what it does at a unit-arc interface facing a bowtie; E12 stays falsifiable with
   FS112-BOWTIE's seam as its test object.
6. **No one class at a time** (G24, G60; r129) → failure clause in every brief; a charge per tile of one colour is such a reduction.
7. **Calibration** (G20, G21; r33; the gate rules) → **Y, YB**: checkers accept the brick, the hexagonal seven-colouring, the strip and the disk before
   any refusal is believed; planted faults with faithful twins; every ACCEPT prints pairs examined.
8. **What a YES must carry** (G22, G79; r136) → **Y**: unit arcs, (Q)/(R2) only (FS112-N2-RED), the T2 budget (FS112-C-PARTNERS: a cubic trichromatic
   vertex has at most three close complementary partners, at rhombus completions); the pentagon-skeleton design test (the stub's open item 3) first;
   every stop read as a NO lemma before designing past it.
9. **Read at the opening** (G46, G49, G50) → **N, Y stage 1**: the held sections §PA names (stage 3), in the words of their disciplines.
10. **The base** (r134; BASE-V) → **R0**, conditional: if BASE-V reports a failing step, the repair is the first phase and row 134 and every FS-112
    row resting on N3-BASE are regraded before N builds on them.
11. **Which vertices** (G83) → **N**: every route says which vertices of `F ∪ R` it reads; the close scores G83's reading.
12. **Scope** (r131, r133) → **N**: every NO says whether it is Q-full_K's (for which `K`) or Q-full's, whether it uses the complexity bound, and on
    which side of W-EQ-K it works.
13. **Staffing and counting** (G51) → stage 5: a proof side against a construction side, a blind verifier per side, CV on the composition,
    retractions counted.
14. **Registrations** (G21; the gate rules) → stage 5: each names its population, whether its test is the step's exact condition, and both outcomes'
    reachability.
15. **Form** (G67) → **close**: every statement minted ends with its trigger, *Do* and killing test or what it forbids.

**The test of the re-grokking** (WORKFLOW 3.1 item 3). It changes the plan in four places: (i) card 2 is reframed before any route — by compactness
the local/global dichotomy is not about truth at a fixed `K` but about explicitness and uniformity (extraction 1, from G82's body and r41); (ii) a
torus-first order for any count (G68's periodic principle, which no stub named); (iii) Voronov's radius-3 disc enters as the one printed local NO to
test (G29's comparison clause, r40); (iv) a winding route must face the swap (G71 via r132). Each is an instruction in the phase table (stage 5).

## Stage 2b — SAVED

## Stage 3 — SAVED: §PA (the prior-art gate) and §IQ (the invariant question)

### §PA — searched 2026-09-27 by the planner (zbMATH Open API for discovery; Semantic Scholar for S–V's citing list; OpenAlex rate-limited this session; full text of the held Polymath16 threads and of the held Geombinatorics issues XXX(4)–XXXVI(1) by `pdftotext`/`grep`; raw outputs `data/fs114/fs114-p/zb_*.json`, `s2_*.json`, `polymath16-greps.txt`, `geomb-extracts.txt`; every quotation below checked, `data/fs114/fs114-p/quotes-stage3.out`, 30 of 30 FOUND)

**The recognition sentence (G46), used as the query.** FS-114's object is an infinite, locally finite planar map whose faces have diameter at most
1, coloured with six colours so that no two points of open faces of one colour are at distance exactly 1; whether one exists is a question about
tilings with prescribed local vertex types (four-colour, repeated-colour, cubic trichromatic), and a NO would be, in the planar-map discipline, an
**unavoidable set composed with reducibility** (discharging; the four-colour theorem's architecture) or a **combinatorial-curvature count** on the map's
face-adjacency graph. In the unit-distance discipline the one printed argument of the second kind is `[Thomassen1999]`'s: its map graph `M` (faces
adjacent when their boundary cycles meet) is locally Hamiltonian, and its Lemma 1 — "If G is a connected, locally finite, and locally Hamiltonian
graph with at least 13 vertices, then G has a vertex of degree at least 6." (held text, as quoted in `plans/FS106-V-verification.md`) — is the
positive-curvature finiteness statement of Higuchi's discipline (the icosahedron is the extremal case).

| # | question (WORKFLOW 3.2) | what was done | finding |
|---|---|---|---|
| 1 | the discipline's words | zbMATH: `ab:discharging & ab:"unit distance"` (1); `ab:discharging & (ab:tiling \| ab:tilings \| ab:tessellation)` (1); `ab:"combinatorial curvature" & (ab:tiling \| …)` (2); `ab:"infinite planar" & ab:curvature` (10); `ab:"Gauss-Bonnet" & (…planar graph…)` (2); `ab:"locally Hamiltonian" & ab:degree` (10); `ab:"exclusion zone" & ab:colo*` (0); `ab:Reuleaux & ab:colo*` (3, none on topic); `ab:"chromatic number of the plane"` with disk/strip (2), with tiling/tiles (3), with regions/maps/measurable (8); `(ab:map \| ab:maps) & ab:"distance 1" & ab:colo* & ab:plane` (0) | **No printed work applies discharging or combinatorial curvature to a map colouring avoiding a distance.** The tools exist, apart: `[Mohar2002]` (Trans. AMS 354, Zbl 0996.05031; reviewer's review read): "the discharging method … can be extended from finite planar graphs to infinite planar graphs of subexponen[tial growth]" — the aperiodic count's tool; `[Higuchi2001]` (J. Graph Theory 38, Zbl 0996.05041; author's summary, a claim): combinatorial curvature of infinite planar graphs; Hua–Su 2020 (non-negative curvature; title only). Off topic: Lavollée–Swanepoel 2023 (matchstick graphs), Heule 2021, Donnelly 2018, Kruskal 2008 (retired at FS-112). `[SokolovVoronov2025]` is now printed: Discrete Math. 349 (2026) 115321 (zbMATH, no Zbl id yet; `BIBLIOGRAPHY.md` l. 126 already has it) |
| 2 | two disciplines | (i) planar maps: discharging, curvature, Euler characteristic × (ii) unit-distance map colourings: `[Thomassen1999]`, `[Woodall1973]`, S–V, Polymath16 | **PA-A (a recognition): the printed NOs for regular maps are local with explicit radii.** `[Voronov2023]` Thm 1.3: closed classes, a disc of radius 3; `[Thomassen1999]`: nice colourings, a curvature count on `M` reading 13 faces for its core and a region of diameter `12k + 30` (`k ≤ 10` in the plane, FS106-V3's repair) for its 2-separator analysis; S–V Cor. 1 (row 134's base): radius 2 about a trichromatic vertex, after reduction moves. **The one non-local step this project holds is a reduction step, not a kill**: N4-FIN's bi-infinite chain along a line (row 134). And per FS106-V3, "Niceness is used at exactly **two** steps: the rainbow step (touching faces, and two faces touching one face, differ) and the count of same-coloured faces inside a curve of diameter `< 2`." — at bounded complexity the second holds for every map (at most `K` tiles per unit disc), so **on a valid map only the rainbow step reads the colouring's metric**, and it fails exactly where two same-coloured faces touch one face at distance below or exactly 1 |
| 3 | the question, not only the method | the held Polymath16 threads grepped (`polymath16-greps.txt`: "discharg" 0, "Euler" 2, "curvature" 16, "non-Siamese" 6, "dual graph" 31, "Thomassen" 24, "locally Hamiltonian" 0, "exclusion zone" 102, "largest disk" 5, "6-tiling of the plane" 4, "Sirgedas" 93) | **The local form is a question in print.** Thread 7 (Mixon, 2018-06-16): "What is the radius of the largest disk in $\mathbb{R}^2$ that can be 6-colored?"; answered from below only (the disk, 2.124; `[Polymath2021]`), and wrongly from above the same day by Hockertz ("The answer for a 6-coloring is thus the circumcircle radius of a hexagon with side length 1, which is a circle with radius 1."). An explicit `R` for FS-114's NO answers its upper side for maps with unit arcs. **Sirgedas's near-proof was pursued at least in part as a search**: de Grey, thread 16 (2020-05-27): "Especially if Philip and Tom reach some kind of closure on their attempts to perform an exhaustive search of non-Siamese 6-tilings, that would merit a stand-alone article." De Grey's own gloss of the target (`[16.317]`): "(This would strengthen the old result of Thomassen, wich applied only to scaleable tilings.)"; his ladder (`[17.5]`): "4 unconditionally, 5 if measurable, 6 if tile-based, 7 if scaleable-non-Siamese-tile-based"; and (thread 16, on Sirgedas's sphere colouring) "because “nice” means not only non-Siamese, which Tom’s tiling is, but also scaleable, which Tom’s tiling very much isn’t." — so "non-Siamese" and "scaleable" are two hypotheses, and Thomassen needs both |
| 4 | outside arXiv | held Geombinatorics XXX(4)–XXXVI(1), text layers grepped (`geomb-extracts.txt`; XXX(2)–(3) unreadable Type-3 printouts, a blind spot); the Google group and Hockertz's manuscript unheld | Five held items cite `[Polymath2021]` (Heule 2021, XXXI(2); de Grey–Parts 2022, XXXII(2); `[Parts2023]`, XXXII(4); Mundinger et al. 2024 and Soifer 2024, XXXIV(1)); **none states or answers the unit-arc question or bounds a six-tileable disc from above.** De Grey–Parts 2022, p. 69: "Since a block-structured 6-tiling of the plane excluding distance 1 can only use tiles with at most five edges" — an Euler-type constraint for one family, unproved there. `[Parts2023]`'s tilings were optimised with "the HNT program [9], specially developed for solving such problems by Tom Sirgedas" (its [9]: the Google group thread `a701Kwnhp_A`, unheld). "discharg" occurs only in essays on the four-colour theorem (XXXIII(2), XXXVI(1)) |
| 5 | the poser's citation graph | S–V (Question 2): Semantic Scholar's citing list of arXiv:2502.01958; `[Polymath2021]` (p. 199): the held issues (row 4; no index reaches it); Mixon's thread-7 question: the threads | S–V: one citing work, Axenovich–Liu–Sagdeev 2025 (arXiv:2512.15516, abstract read: Euclidean Ramsey for unit copies of `H`; off topic). OpenAlex's search cluster returned 429 this session, so no OpenAlex citing list was obtained — **a limit, not a zero**; FS-112's OpenAlex lists (Thomassen 7 + 1, Axenovich 9, Coulson 5) stand |
| 6 | open every neighbouring citing work | the five held items (row 4) grepped for tiles and arcs; de Grey–Parts p. 69 read; `[Parts2023]`'s reference list read; Axenovich–Liu–Sagdeev's abstract | none on topic; the method-bearing debts are Ágoston 2025 (below) and the Google group |
| 7 | two databases | zbMATH and Semantic Scholar; OpenAlex attempted, rate-limited | the two used share no source for these records; zbMATH's `nicely` query (39 hits) found one on topic, Ágoston 2025, already known at abstract level (FS-112) |
| 8 | full author listings in the question's vocabulary | zbMATH `au:`: Sirgedas (1), Hockertz (0), Gibbs (11), de Grey (9), Ágoston (9), Thomassen with unit-distance words (1); Parts, Woodall, Townsend, Coulson, Voronov at FS-106–FS-110 | Sirgedas's one indexed paper is `[Sirgedas2021]` (the sphere of radius above ≈ 12.44 seven-colourable, Geombinatorics XXX(3) 138–151; held as a render, unread — its "stitch" of unit-radius arcs, `[16.263]`, is construction vocabulary for Y). **Ágoston 2025** (*A lower bound on the number of colours needed to nicely colour a sphere*, DCG 74(3) 691–718, Zbl 1580.05061): the one printed sharpening of Thomassen's count (eight on spheres) — its method unread, a debt for N. Gibbs: nothing on tilings in print; Hockertz: nothing indexed |

**Owner's item 79 closed on the way:** `[Oostema2020]`'s last page is **389** — the publisher's landing page at doi 10.29007/btmj reads "pages
373-389" (`data/fs114/fs114-p/oostema.html`); OpenAlex's 355 is its record's defect. Proposed for `BIBLIOGRAPHY.md` (stage 5 §5.6).

**What the gate changes in the plan.**
- (a) **Card 2 gets its evidence from print, and it leans local.** Every printed NO in the neighbourhood is local with an explicit radius (PA-A); the
  "global" hunch rests on G17's analogy alone. The registration E-LOC (stage 5) is set against that, and N's first stage asks, of each printed
  radius, which hypothesis bought it (closedness for Voronov; the rainbow step for Thomassen; Condition 5 for S–V's base).
- (b) **A route the stub did not name — Thomassen's count on a valid map** (route T). His Lemma 1 and his topological steps read no metric, so they
  hold for every map with faces of diameter at most 1; only the rainbow step reads the colouring. The route asks what the rainbow step's failure at a
  face of map-degree at least 6 forces in a valid map — a Siamese pair or the unit-radius tactic are the candidates — and whether the curvature
  count (average map-degree 6 in the plane) then over-spends them. This is an unavoidable-set argument with Thomassen's count as Act One (G15).
- (c) **Mixon's thread-7 question is the local form in print**; an explicit `R` answers its upper side for maps with unit arcs, and is cited so.
- (d) **Sirgedas's near-proof was pursued at least in part as an exhaustive search** (Gibbs and Sirgedas, 2020); its statement is FS-114's
  four-colour form restricted to non-Siamese tilings, and its method may be one Kooshi's ruling excludes. The debt stands as the gate's first, for
  Kooshi's call on fetching from the Google group; nothing in the plan waits for it.
- (e) **The aperiodic count has a printed tool**: discharging on infinite planar graphs of subexponential growth (`[Mohar2002]`); the torus case needs
  none (G68).

**Papers still needed (for the report).** None blocks the opening. Debts: Sirgedas's argument and the HNT simulator thread (Google group; Kooshi's
call); Hockertz's manuscript (dropbox, thread 6); `[Mohar2002]` and `[Higuchi2001]` (not held; fetchable); Ágoston 2025 (DCG; arXiv version to be
found by N at stage 1); `[Sirgedas2021]` (held as a render; for Y). **Proposed `BIBLIOGRAPHY.md` rows** (the close writes them): `[Mohar2002]`
(review read, not held); `[Higuchi2001]` (author's summary, a claim; not held); Ágoston 2025 (Zbl 1580.05061 added; method unread); Axenovich–Liu–Sagdeev
2025 (arXiv:2512.15516; abstract read; off topic; cites S–V); `[Oostema2020]` (last page 389 confirmed at the publisher); `[Polymath16threads]` (thread
7's disk question and thread 16's non-Siamese search, both quoted here); the Google group row (add the HNT simulator thread `a701Kwnhp_A`).

### §IQ — the invariant question (WORKFLOW 3.3)

1. **The existence form.** Is there a valid six-map with unit arcs — a locally finite map of the plane bounded by segments and circular arcs, arcs of
   radius 1 allowed, six-coloured so that no two interior points of one colour are at distance exactly 1 (Q-full; Q-full_K at complexity `K`)?
2. **The structural form.** *For every valid map, what discrete datum does it carry at each of its vertices of at least four colours and each vertex
   with a repeated colour — the vertices DENSE3 puts within 3 of every point — such that validity is a condition on that datum within a bounded
   radius, and the datum's average over the plane is fixed by the map's topology alone?* Posed for every valid map at once (periodic or not), in the
   widest class where it is defined (locally finite, curved, almost everywhere, no complexity bound, as row 134's chain used none), by derivation
   only. A NO then reads: the local conditions force the datum's average away from the value topology fixes.
3. **The invariant it forces: none known in print for maps with unit arcs.** Three candidates, each a reading with its killing test, handed to the
   sides as starting points, not results:
   - **(a) The rainbow deficit on the map graph** (route T; §PA (b)). Every map carries its map graph `M`, whose average degree over the plane is 6
     (Euler; Thomassen's Lemma 1 is its positive-curvature half). At a face of map-degree `6 + r` a six-colouring spends at least `r + 1` colour
     repetitions in the face's closed neighbourhood; each repetition in a valid map is a Siamese pair or the unit-radius tactic. *Killing test:* a
     valid local fragment by formula with a face of map-degree at least 7 whose closed neighbourhood repeats a colour with neither a Siamese pair nor a
     unit arc.
   - **(b) The (Q) skeleton** (Sirgedas's quads and arrows, `[16.346]`): every four-colour vertex with its (Q) arcs, and the rhombus completions its close
     complementary pairs force (FS112-N3-COR3, FS112-C-PARTNERS), as a discrete planar structure with local rules. *Killing test:* a valid fragment whose
     four-colour vertices violate a rule the skeleton asserts (a quad emitting fewer than four arrows, or a close complementary pair not a rhombus
     completion).
   - **(c) The arc budget as a charge**: the total angle of unit arcs centred at each vertex of `F` (at least 60° or six arcs at four colours, FS112-A4SIX;
     180° at five, FS112-SIX), against what their ends demand. *Killing test:* a valid fragment whose four-colour vertex carries arcs below the budget a
     charge rule assumes.
   G79's flip, stated: FS-112's walls were counterexample invariants (the stuck ray, the pinned corner); DENSE3 and C-PARTNERS are example invariants.
   §IQ asks for the example invariant at the vertices DENSE3 names, and for its average.
4. **Its route.** Derivation only. The construction side's fragments by formula check derived claims (each killing test above); they never answer
   the structural form.
5. **The open instances it would decide.** The global step (FS-114, in the form chosen at stage 5); C-LOCAL (an explicit radius); Mixon's question's
   upper side for maps with unit arcs (thread 7); `[Polymath2021]` p. 199's hope; `[SokolovVoronov2025]` Question 2's unit-arc half; the non-Siamese
   case of the four-colour form (de Grey's `[16.317]`); the pentagon-skeleton test (the stub's open item 3); and for FS-115, whether its (b′) and (b″)
   are needed at all.

## Stage 3 — SAVED

## Stage 4 — SAVED: the fixed claim list (`data/fs114/claims.md`)

**Written and checked.** `data/fs114/claims.md`: §0 definitions (valid map, unit arc, (Q), (R2), `M*`, `F`, `R` from FS-112's derivation header; `𝓜_K`;
Siamese, scalable, nice and the map graph in their authors' words; "reads radius `R`" and "valid fragment on a disc", this list's); §1 the questions
(Q-full, Q-full_K; S–V Question 2, `[Polymath2021]` p. 199, Mixon's disk question, de Grey's non-Siamese target; the global step as the stub states it);
§2 the fourteen held inputs, each headline verbatim with its grade; §3 the forms — GS-D, GS-4, GS-1, C114-EXISTS-F, C114-LOCAL-F, C114-LOCAL-FR, C-LOCAL
(carried with its FS-112 verdict), C114-COMPACT; §4 the route claims — C114-VOR, C114-THOM-TOP, C114-RAINBOW, C114-CURV, C114-SKELETON, C114-BUDGET; §5
the construction claims — C114-PENT, C114-DIAL, C114-TORUS, C114-SIRGEDAS-FORM; §6 shared constraints; §7 not claimed. **Quotations:** 45 in the list,
each paired with its source in `data/fs114/fs114-p/quotes-claims.tsv`; `tools/fs114_p_quotes.py --file …` reads **63 of 63 FOUND** (the list's 45 plus
the brief's 18; `quotes-claims.out`), and a separate pass confirms every one of the 45 appears literally in the list itself. The checker gained two
normalisations, applied to both sides alike (blockquote markers; a hyphen at a line's end joined to the next word, for the OCR text of `[Thomassen1999]`),
and its self-test still fires (`quotes-selftest.out`: PASS); stage 3's quotations re-run, 30 of 30 FOUND after one TSV line was rejoined.

**A correction to stage 2b, extraction 1 (and part 1's G82 line).** I called the compactness claim "a reading of the planner's". It is FS112-A's, one
mind, already recorded in C-LOCAL's own note ("At bounded `K`, a NO gives some radius by compactness [hand, one mind: FS112-A, over
`plans/FS107-derivation.md` W-EQ-K's compactness step"), over VW's compactness step (TRUE at W's class, one mind). C114-COMPACT carries that attribution;
what this plan adds is only its use — card 2 read as a question about an explicit, uniform radius. (Found at stage 4 by reading C-LOCAL's text in full,
which stage 2 had read by its §11 verdict alone — G50's rule, the note that "reads like knowledge", on the planner.)

**Design notes on the list (why each new claim exists).**
- C114-LOCAL-F and C114-LOCAL-FR separate the two anchors card 2 could use: four-colour vertices alone (needs C114-EXISTS-F, NIGHT-A's one-mind step
  over FS112-C-ENDS) or four-colour and repeated-colour vertices (needs only FS112-N3-DENSE3, two minds).
- C114-VOR and C114-THOM-TOP / C114-RAINBOW / C114-CURV are the two printed local NOs (§PA, PA-A) taken apart at the step where each reads the colouring's
  metric; C114-CURV is Thomassen's Lemma 1 asked locally, with its dependence on the complexity bound stated.
- C114-SIRGEDAS-FORM gives the construction side the non-Siamese case as a target it can check, so that de Grey's `[16.317]` statement is tested from the
  positive side while its argument stays unheld.

## Stage 4 — SAVED

## Stage 5 — SAVED: the plan (WORKFLOW 4) — the form, the phases, the decisions, the registrations

### 5.0 The first decision: the form of the global step (four parts)

- **The choice.** Attack the global step in **DENSE3's form (GS-D): the NO itself**, with FS112-N3-DENSE3 (two minds, one blind) as the held property
  of every counterexample. The anchor of a local route is left to the proof: four-colour and repeated-colour vertices together (C114-LOCAL-FR, which
  needs nothing further), or four-colour vertices alone (C114-LOCAL-F with C114-EXISTS-F, NIGHT-A §6's one-mind step, second-minded by CV). The
  four-colour form (GS-4) is used **only for doubly periodic maps**, where FS112-C-COMPOSE (2) makes it the NO with no ray step. **The four-colour form is
  not chosen for aperiodic maps, so FS-115 does not open on FS-114's account.**
- **Alternatives weighed.** (a) GS-4 for every map: it would let a proof ignore repeated-colour vertices, at the price of FS-115's (b′) and (b″) — two
  further GAPs about rays and long chains, the kind of non-local structure a local route exists to avoid. (b) GS-1 alone (NIGHT-A §6): one four-colour
  vertex plus a local exclusion about it. It is the sharpest target, but it rests on FS112-C-ENDS (one mind, with a named residue).
- **Why GS-D won.** It needs only two-mind inputs, and it contains GS-1 as a sub-route: choosing GS-D gives up nothing GS-1 offers, while GS-4 for
  aperiodic maps adds two GAPs that no route to the NO needs (FS112-C-COMPOSE (1)). Route T (Thomassen's count, §PA (b)) reads no four-colour vertex
  at all and does not use row 134's base, so it is untouched by the choice and by any failure BASE-V might find.
- **Confidence: medium-high.** What would change it: the proof side finds that repeated-colour vertices on long stuck chains resist every local
  exclusion while four-colour vertices do not, and C-ENDS's residue cannot be closed. Then (b′) and (b″) become the bottleneck, FS-115 opens, and the owner
  hears so at once.

### 5.1 Phases (at most three agents at once across tonight's jobs, all Opus 5.5; one level deep; FS-114 takes each slot that frees, NIGHT-A §1)

| phase | job | what | reads first | produces | guidance |
|---|---|---|---|---|---|
| **R0** (conditional) | FS114-R0 | **If BASE-V reports a failing step, the repair runs first**: re-derive the failing step in FS-112's setting or name what replaces it; regrade row 134 and every FS-112 entry resting on FS112-N3-BASE (DENSE3 among them) before N builds on them. The owner briefs it from BASE-V's report | BASE-V's record (after it reports) | the repair, or the step named as a GAP with what rests on it | 300k |
| **N**, round 1 | FS114-N | the proof side. **Stage 1: card 2, by derivation** — C114-COMPACT's use (can the radius be explicit, uniform in `K`?), C114-VOR (the step closedness buys in `[Voronov2023]` Thm 1.3), C114-THOM-TOP (Thomassen's Lemma 1 and topology on valid maps' map graphs; faces that touch themselves or are not discs); a verdict on the route (local, anchored at `F ∪ R` or `F`; or the count), every step stating its reading radius. **Stage 2: the route, torus first** (G68) — C114-RAINBOW, C114-CURV, C114-BUDGET for route T, or C114-LOCAL-FR / -F for the local route, on doubly periodic maps. **Stage 3: aperiodic maps** — averaging (`[Mohar2002]`'s discharging for subexponential growth) or the local exclusion's uniformity; GS-D's verdict at its grade, or its GAP named | `data/fs114/claims.md`; this plan's §G part 3, §PA, §IQ, 5.0–5.2 (not 5.3 until its stage 1 is committed); `[Thomassen1999]` (held text, 4 pages); `plans/FS106-V-verification.md` §2.1 and V3 stage 2 (Voronov's and Thomassen's proofs as verified); FS-112's derivation file; `[Mohar2002]` and Ágoston 2025, fetched at stage 1 | `plans/FS114-N-proof.md`; `tools/fs114_n_*.py` | 400k |
| **Y**, round 1 | FS114-Y | the construction side. **Stage 1:** calibrate (FS-112's exact checkers run, never edited, on the strip, the disk, FS112-BOWTIE, the brick and the hexagonal seven-colouring; any new checker in `tools/fs114_y_*.py` accepts all five first); read FS-112's rebuild data (G46); **C114-PENT derived before anything is built**. **Stage 2:** C114-DIAL (a valid fragment about a four-colour vertex beyond `≈ 1.834`, or a derived obstruction at a named radius); C114-TORUS (a doubly periodic design by formula from FS112-C-PARTNERS' budget, or each member's failure with its parameter count); C114-SIRGEDAS-FORM. **Stage 3:** §IQ's killing tests (a)–(c) on every fragment held; G71's E12 at FS112-BOWTIE's seam; every stop sent to the owner as a statement about every valid map (G79) | `data/fs114/claims.md`; §G part 3, §PA, §IQ, 5.0–5.2; FS-112's construction records and tools (`plans/FS112-Y-construction.md`, `-Y3-`, `-YB2-`; `tools/fs112_yb2_*`, `tools/fs112_yb3_frags.py`); `[Polymath2021]` pp. 190–201; `[Sirgedas2021]` (render; its stitch of unit arcs) | `plans/FS114-Y-construction.md`; `tools/fs114_y_*.py` | 400k |
| **CV** | FS114-CV | blind second minds on the composition: FS112-C-ENDS **with its residue** (close it, or name the configuration it misses), FS112-C-COMPOSE, FS112-C-PARTNERS, and C114-EXISTS-F (NIGHT-A §6); derived from the links' statements, fenced from the assembly | `data/fs114/claims.md` §§0, 2, 3; the link records (`plans/FS112-N-proof.md` N2-4 and N3-4; `plans/FS112-NB-verification.md` §2.3 #10; `plans/FS112-YB3-verification.md` §3) | `plans/FS114-CV-verification.md` | 250k |
| **NB, YB** | FS114-NB, FS114-YB | blind verifiers, each launched at its side's hand-back; instance files (the owner's) list the claim ids with the side's verdicts withheld | as their briefs | `plans/FS114-NB-verification.md`, `-YB-` | 300k each |
| **A** (optional) | FS114-A | a competition advisor — **only if a slot would otherwise idle while both sides run**; else the owner compares the round at its end (protocol rule 14) | both sides' records, per the protocol | `plans/POROS-2026-09-27-fs114-competition.md` | 350k |
| **round 2** | — | planned by the owner at round 1's boundary, aimed at the sides' meeting point (a plan addendum, as FS-112 did) | — | — | — |
| **close** | FS114-C | WORKFLOW 9 from the close inventory | — | — | — |

**Launch order** (the slots FS-114 receives, first to last): R0 if BASE-V fails; **N**; **Y**; **CV**; NB at N's hand-back; YB at Y's hand-back; A only
into an idle slot. N goes first because card 2 is a question about the shape of a proof, and a NO is the likelier answer; Y goes second because its
fragments are the controls every local step of N must fail on (C-BEYOND), and the two meet at the radius dial.

**Checkpoints** (the PROTECTED rule): every job saves stage by stage in its record (standing rule 2); a killed job's relaunch redoes at most one stage.
No exact check planned here runs long; any that would exceed 15 minutes writes its state after each named member it checks and records its resume
command in the record before it starts.

### 5.2 Decisions (four parts each; 5.0 is D1)

| # | choice | alternative weighed | why this one | confidence (and what would change it) |
|---|---|---|---|---|
| D2 | one proof side, with card 2 as its stage 1 | two proof competitors, one local, one counting | the protocol's lesson (§3: "two routes to one heart are a synthesis, not a competition"); the construction side's fragments bound any local route from below, so proof against construction meets at the radius dial | medium — if N's stage 1 finds both routes live and independent, round 2 gives each its own side |
| D3 | no reading job before the contest | a reading job P0, as at FS-112 | the held reading is short (Thomassen, 4 pages; Voronov's and Thomassen's proofs already verified at FS-106 with records), the rest is two fetchable papers, and tonight's slots are shared with FS-111 and BASE-V | medium — if N's or Y's stage-1 reading passes about 100k tokens, the owner adds P0 in round 2 |
| D4 | CV as its own blind job | N re-derives FS112-C-ENDS inside its stage 2 | a second mind must be blind to FS112-C's and FS112-C2's assembly, and N would read it as input; C-ENDS gates GS-1 only, so CV runs beside the contest, not before it | high |
| D5 | the registrations (5.3) fenced from both sides and their verifiers until each has committed its stage 1 | let them read 5.3 and score the walks as primed alike | FS-112's owner ruling (its inventory item 10): the first measurement (card 2's verdict) is worth two samples only if neither is primed | high — **held for the owner** as a ruling to confirm |
| D6 | no Lean lane in this milestone | a phase K: the statement of Q-full in Lean (segment-and-arc maps, almost-everywhere validity), `sorry` at every leaf, vacuity DECLARED | the statement is still moving (C114-THOM-TOP asks whether faces must be discs; C114-COMPACT whether the class is closed under limits); a skeleton is written once the class is fixed. Not a cost argument (§ Counter-priors) | medium — **held for the owner**: if Kooshi wants the statement in Lean now, K runs into the first idle slot, a skeleton only |
| D7 | Y runs FS-112's exact checkers as they are, and writes wrappers (periodic pairs for a torus map) in `tools/fs114_y_*.py` | a new checker from scratch | FS-112's three checkers are calibrated on the strip, the disk and FS-110's fragments at two or three rebuilds; a wrapper inherits that calibration and must re-earn it on the torus (a planted periodic pair) | medium — if no FS-112 checker handles the arithmetic a torus design needs, Y writes a new one and calibrates it on all five controls first |
| D8 | the choice of route is N's, at stage 1, by derivation | the planner picks local or count now | the brief: "Do not derive the global step yourself; the jobs do." The planner's evidence (PA-A: every printed regular NO local with an explicit radius; G17 for global) is registered (E1), not imposed | high |

### 5.3 Registered expectations (instruments for G21, scored at the close; never caps — § Counter-priors rule 2; each with its population and both outcomes reachable) — **fenced from N, Y, NB, YB and CV until each has committed its stage 1** (D5)

| # | expectation | p | population | both outcomes reachable |
|---|---|---|---|---|
| E1 | card 2: N's stage-1 verdict chooses a **local** route (an explicit-radius exclusion anchored at `F ∪ R` or `F`) over a plane-wide count | 0.55 | N's stage-1 verdict | yes — either route is N's to choose, by derivation (PA-A for local; G17 and NIGHT-A's hunch for global) |
| E2 | an **explicit** radius is derived for some local exclusion (C114-LOCAL-FR or -F TRUE with `R` named) within FS-114 | 0.15 | N's and NB's verdicts on C114-LOCAL-FR, -F | yes — a derivation with `R`, or GAP |
| E3 | GS-D decided (NO or YES) at one mind within FS-114 | 0.2 | the milestone's verdict | yes — a NO by derivation, or a valid map by formula checked exactly |
| E4 | a NO for doubly periodic maps at one mind | 0.3 | N's stage-2 verdict | yes — derivation, or a periodic valid map by formula (C114-TORUS) |
| E5 | C114-THOM-TOP TRUE (Lemma 1 and the topological steps hold for every valid map's map graph, self-touching and non-disc faces handled) | 0.7 | N's and NB's verdicts | yes — a valid fragment by formula whose map graph breaks a step (a face touching itself at a vertex is the first candidate) |
| E6 | C114-RAINBOW TRUE as stated | 0.5 | N's and NB's verdicts | yes — MISSTATED or FALSE with a fragment repeating a colour around a face with neither a Siamese pair nor a unit arc |
| E7 | C114-CURV's radius depends on `K` (no uniform `R₀`) | 0.7 | N's verdict | yes — a uniform `R₀`, or a family of maps whose degree-≤5 regions grow with `K` |
| E8 | CV confirms FS112-C-ENDS, C-COMPOSE and C-PARTNERS | 0.8 | CV's verdicts | yes — a counterexample configuration refutes one |
| E9 | CV closes C-ENDS's residue, so C114-EXISTS-F holds at two minds | 0.55 | CV's verdict | yes — the residue closed, or a configuration it misses named |
| E10 | C114-PENT: the pentagon skeleton admits the third unit-arc boundary | 0.3 | Y's and YB's verdicts | yes — a valid extension by formula, or a derived obstruction at a named point |
| E11 | C114-DIAL: a valid fragment about a four-colour vertex beyond `≈ 1.834`, by formula | 0.25 | Y's objects, checked exactly | yes — an exact fragment, or a derived obstruction at a named radius |
| E12 | a YES by formula (a valid map of the plane) | 0.03 | Y's objects | yes — the checker and a formula; a NO by derivation |
| E13 | C114-SKELETON: a discrete form of the local structure at four-colour vertices, derived | 0.4 | N's or Y's derivation | yes — derived, or shown to lose information a NO needs |
| E14 | G83's reading survives: the decisive argument of the milestone reads vertices of `F ∪ R` | 0.8 | the close's reading of the milestone's best argument | yes — an argument reading no such vertex (route T could be one) |
| E15 | a blind verifier (NB, YB or CV) finds a divergence of truth | 0.6 | the round's verifiers | yes (FS-112: one in every round) |
| E16 | G71's index survives the bowtie seam with unit arcs (E12 at FS-112, untested) | 0.75 | Y's test at FS112-BOWTIE's seam | yes — a swap forced with `\|ΔInd\| = 2` refutes it |
| E17 | a named obstruction or GAP as the product | 0.85 | the milestone | — |

### 5.4 The ban, and Kooshi's ruling beyond it

To 2026-10-01 no finite-witness search of any kind (standing rule 3); beyond it, "search for a finite graph is out." For this milestone: candidate maps
and fragments are **given by formula** and checked exactly in seconds; no program enumerates maps, colourings, tile graphs, dual graphs, vertex types or
parameters. Sirgedas's and Gibbs's 2020 exhaustive search of non-Siamese tilings (§PA row 3) is the kind of method the ruling excludes; its statement is
a claim the sides may attack by derivation. Every brief carries the "would have searched here" log.

### 5.5 Carry-over (not this milestone's work; for the owner and the close)

- **FS-115 stays unopened** (5.0); its stub's line "it moves to 2 the day FS-114's plan commits to that form" did not fire. Its (b′), (b″) and bowtie end
  (c) keep their bearing only through GS-4 for aperiodic maps and C-ENDS's residue (CV).
- **FS-111** is unaffected by the form; its card 1 (does the map NO at every complexity bound plus a cone-scale bound give seven) reads FS-114's NO in
  whatever form lands — at every `K`, which C114-COMPACT's uniformity question bears on.
- **Kernel decisions**: 40 of FS-112's derivation entries read "Kernel: stub — with FS-114". They move with D6 to the milestone that lands the NO.

### 5.6 Proposed edits for the close (I edit none of these files)

- `BIBLIOGRAPHY.md`: the rows listed at §PA ("Proposed `BIBLIOGRAPHY.md` rows"), and `[Oostema2020]`'s last page confirmed as 389 at the publisher
  (the owner's item 79).
- `CLOSED-QUESTIONS.md`: nothing now; if an explicit `R` lands, Mixon's thread-7 question ("What is the radius of the largest disk in $\mathbb{R}^2$ that
  can be 6-colored?") gets its upper side for maps with unit arcs.
- `plans/STUB-stuck-ray.md`: its bearing line gains "FS-114's plan chose DENSE3's form (2026-09-27); FS-115 bears through the four-colour form for
  aperiodic maps and through FS112-C-ENDS's residue".
- `CLAUDE.md` G83's *Do* could name route T's vertex-free candidate as its killing test's likeliest instance — at the close, if route T lands.

### 5.7 Briefs (stage 6)

Drafted at stage 6 for the owner to launch: `data/fs114/briefs/N114-proof.md`, `Y114-construction.md`, `CV114-composition.md`,
`NB114-verify-proof.md`, `YB114-verify-construction.md`, and `A114-advisor.md` (optional). R0's brief is the owner's, from BASE-V's report.

## Stage 5 — SAVED

## Stage 5b — SAVED: §PA addendum — the Google group `hadwiger-nelson-problem`, held tonight

*The owner's message (commit 3d12fbae): Kooshi authorised the fetch; the group is held at `~/source/library/hadwiger-nelson-problem-group/` (README,
`threads/<id>.txt`, two attachments), outbound links not fetched. This supersedes §PA's "unheld" for the group; every quotation below checked,
`data/fs114/fs114-p/quotes-group.out`, 39 of 39 FOUND (the group's 21 plus the brief's 18).*

**Reading status, section by section (G50).**

| thread | messages, dates | read |
|---|---|---|
| `J_Tw1_hUxQI` "Graph Coloring by Simulation" | 328, 2019-12-14 → 2020-05-21 | **in part**: lines 1–40 (the opening), 589–770 (the first searcher; the curved-edge count; de Grey's Siamese reply), 885–945 (the second searcher and its rules), 4150–4200 (the search's findings), 4455–4545 (the searcher's flaw; its goal); grepped whole for "siamese", "searcher", "exhaustive", "prove that there". About 4,300 lines unread |
| `Z50mmulkXCQ` "6-coloring a degree 5 graph" | 27, 2020-09-12 → 2023-08-13 | **in full** (every message body; quoted replies skipped; the images the posts describe are not held) |
| the other nine | Simulator (38), Coloring a sphere (85), 4-coloring infinite strip (8), coloring small disks (1), TileDist (1), Golomb Triangle Coordinates (5), graph coloring with a SAT solver (13), SAT-solving a grid of tiles (18), pentagonal tiling (6) | titles and first lines only |
| attachments `disk.pdf`, `jaan13.dual` | — | not opened |

**What it says, verbatim.**
1. **The near-proof was a search, and it broke.** Goal (2020-03-09): "My goal for this searcher was to prove that there's no 6-color non-siamese
   tiling"; earlier: "The main goal is to try get an exhaustive search to decide that there's no infinite 6-color tiling." Its rules include "1. no vertex
   can have the same color neighbor" and "2. no polygon can have two vertices with matching colors" (a vertex is a tile, a polygon a map vertex). Its
   finding (2020-03-08): "So, a valid tiling can't have an enclosed vertex with 3 neighbors." and "So, I think all the big pieces are in place for a
   proof. I'm not sure how to make it convincing that the code is correct, though." The next day: "Oh no... in thinking about how to more rigorously
   explain the basics of the searcher, I realized a problem." (a tile-attachment order the search could not reach). Nothing later in the thread's read
   sections repairs it.
2. **The count.** Sirgedas, 2020-01-21: "each quad in the graph "emits" an arrow for each of its degree-5 vertices. I think I can show that an infinite
   6-color graph would have 80+% of its edges curved."; on degree 4: "Allowing a degree-4 vertex can prevent curved edges adjacent to that vertex, but I
   think it creates another quad/pentagon."; at five colours: "so 200% of the edges are curved, so a 5-coloring is impossible." De Grey, the same day:
   "Unfortunately, the fact that tile-based colourings need 6 colours was already known :-)" and "a proof that we need 7 colours unless there are
   Siamese tiles would still be a really big result."
3. **The derivational program** (`Z50mmulkXCQ`): "One interesting thing to note is that all the interior vertices have degree 5. Degree 6 isn't possible
   with only 6 colors."; "Note that the emitted curved edges must all be unique (the curve lies on a unit radius circle centered on the emitting
   vertex)."; the cover rule, "Cover rule: For a degree-5 6-colored graph, every vertex must "cover" each color. (e.g. each vertex must either be red or
   have a red neighbor). Proof: otherwise there's a duplicate color among those 6 vertices."; red blocks, "Then, a 6-colored 5-regular graph that covers
   the plane can be partitioned into red blocks"; their metagraph, "Also this graph can't have pentagons." and "Similarly the metagraph can't have a
   quadrilateral. (Well, I'm pretty certain, but the proof below is a bit sloppy(?))." hence "So, the red metagraph must have only triangles."; the
   Euler count (2022-05-01), "1 quad "emits" 4 curved edges. This is 2n edges (80% of all edges)."; and his own status (2020-10-16): "Not much
   progress, even for the degree-5 graphs, but I feel like proving it impossible should be within reach with a clever idea or two."

**The recognition (PA-B): route T is Sirgedas's program.** His "graph" is the tiles' edge-adjacency dual; in a non-Siamese tiling its closed
neighbourhoods are rainbow ("Degree 6 isn't possible with only 6 colors"), so Euler's formula forces quads — four-colour vertices — among its faces,
and each quad "emits" unit arcs: at five colours the count over-spends the edges (a counting proof, in a post, that non-Siamese tilings need six); at six
it leaves room (80% of edges curved when every tile has five neighbours), and the cover rule, the red blocks and the triangular metagraphs were his
attempts to close it — open when he stopped (2022). FS-112's example invariants are his arrows made theorems (FS112-A4SIX, FS112-NB4P: what a
four-colour vertex's unit arcs are; FS112-N3-COR3: his "two steps"). What FS-114 would add is (i) proofs in place of posts, (ii) the Siamese pairs his
program set aside — FS112-N3-DENSE3's `R` — and (iii) the tiles with four edge-neighbours he set aside. Siamese pairs are exactly what separates
de Grey's non-Siamese target (`[16.317]`) from the whole question.

**What changes in the plan.**
- **N's stage 1** reads `Z50mmulkXCQ` in full and `J_Tw1_hUxQI`'s sections above, and states route T as Sirgedas's program with its three gaps named;
  **the five-colour count is route T's positive control**: any six-colour count N builds must reproduce "tile-based colourings need six" in the
  non-Siamese case (row 132's maps-need-six, here by counting), and say where six's 20% room is spent.
- **New claims**, `data/fs114/claims.md` §8: C114-EDGE-RAINBOW, C114-DUAL-COUNT, C114-REDBLOCK, C114-ENCLOSED3, C114-FIVE-COUNT.
- **E14 corrected**: route T reads four-colour vertices too (its quads), so it is not the candidate for G83's killing test that 5.3 suggested; E14's
  population is unchanged. **New registrations**: E18 — the non-Siamese case (de Grey's `[16.317]`; C114-SIRGEDAS-FORM's NO) decided at one mind within
  FS-114, p 0.25 (population: N's verdict; both outcomes reachable — a derivation, or a non-Siamese valid map by formula); E19 — Sirgedas's red-block
  and metagraph statements hold as stated for valid maps with no Siamese pair and five edge-neighbours per tile, p 0.6 (population: N's and NB's
  verdicts on C114-REDBLOCK; FALSE or MISSTATED reachable by a fragment).
- **Novelty wording**: the count, the cover rule and the red blocks are Sirgedas's (group posts, 2020–2022, informal); FS-114's results along route T are
  "proofs not found in print" of statements he stated or aimed at.
- **D1 stands**; it gains a reason: route T needs no anchor and reads `F` and `R` through the dual, which is GS-D's shape.
- **The search itself is not reused**: its findings (C114-ENCLOSED3) are statements to derive by hand; the ban and Kooshi's ruling cover our searches,
  and a finding of a flawed search is no input to a proof.

## Stage 5b — SAVED

## Stage 6 — SAVED: the briefs, and the hand-off

**Briefs drafted for the owner to launch** (each points to `STANDING-RULES.md`, carries the no-children rule with its reason, the ban with Kooshi's
ruling and the "would have searched here" log, the fences of protocol rule 1 and standing rule 13 by path, neutral commit subjects, and the report
format of standing rule 9; quotations checked, `data/fs114/fs114-p/quotes-briefs.out`, 26 of 26 FOUND):
- `data/fs114/briefs/N114-proof.md` — FS114-N, the proof side: stage 1 card 2 by derivation (C114-COMPACT's use, C114-VOR, C114-THOM-TOP, route T with
  its positive control C114-FIVE-COUNT, the verdict with every step's radius); stage 2 the torus; stage 3 aperiodic maps. 400k.
- `data/fs114/briefs/Y114-construction.md` — FS114-Y, the construction side, identical but for § Your side: calibration on five controls, C114-PENT
  before anything is built, C114-DIAL, C114-TORUS, C114-SIRGEDAS-FORM, the killing tests of §IQ and §8, E12 at BOWTIE's seam. 400k.
- `data/fs114/briefs/CV114-composition.md` — FS114-CV, blind second minds on FS112-C-ENDS (its residue the point), C-COMPOSE, C-PARTNERS, C114-EXISTS-F,
  with C-HORNEND and C-DOUBLE; fenced from the assembly until its stage 1. 250k.
- `data/fs114/briefs/NB114-verify-proof.md`, `YB114-verify-construction.md` — templates; the owner writes each instance file (claim ids or objects,
  verdicts withheld) at the side's hand-back. 300k each.
- `data/fs114/briefs/A114-advisor.md` — optional, only into an idle slot. 350k.
- R0 (BASE-V's repair) has no brief: the owner writes it from BASE-V's report if a step fails.

**Held for the owner** (each a decision of stage 5): D5 — the registrations fenced from every job until its stage 1 is committed (FS-112's ruling;
confirm); D6 — no Lean lane now (whether Kooshi wants a skeleton phase K for Q-full's statement at once); the launch order N, Y, CV, NB and YB at the
hand-backs, A only into an idle slot.

## Stage 6 — SAVED
