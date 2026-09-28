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
