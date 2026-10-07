question: does-the-six-colour-chain-run-with-no-map
  evidence: `plans/EXT-OAI2-reading.md` § 4.2 rows 10–13 (the manuscript's Lemmas 7.2–7.8: "uses the count? no", "typed at five only") and § 3.3 ("nothing in §§ 5–8 distinguishes Siamese pairs"); `LEDGER.md` row 137 ("every locally finite map of the plane bounded by segments and circular arcs"), rows 148–149 ("non-Siamese … valid six-coloured fragments"); `plans/FS114-derivation.md` l. 29, FS114-CV-EXISTS "uses only: … FS112-N2-TERM (the terminal modification `M*`"
  expected: the exclusions at six need a map — arcs, tiles, a locally finite singular set — so a tight colouring must first be made one (route M: FS-126, FS-127, FS-128)
  ask: do FS114-CV-EXISTS and FS116-Y4-EMPTY read arcs and tiles, or only what the release's extraction gives a measurable six-colouring: a point, a label cycle, connected interfaces with limiting directions, and the two-colour exclusion?
  if both run on the extraction's data: the map step is replaced by one statement about cyclic centres; FS-126 and the arcs half of FS-127 lose their consumer; FS-123 and FS-124 are re-posed for measurable colourings with no Siamese clause; the next claim is card 2
  if the exclusion runs and the existence step does not: the exclusions move to measurable colourings, and "some centre is not a triangle" becomes the milestone's open statement, with card 3's form as its first candidate and row 137's bending argument as the thing it must replace
  if a named step of the exclusion reads an arc or a tile count: route M's map step stands for that step; the ranking keeps FS-124 and FS-123 in the map class; the release enters six as the transfer and as lemmas inside FS-124's cases; the named step is the stub of what a measurable form would need
  answered by: derivation — Ephodos, reading the two arguments by their `uses only:` lines against the conclusion of the manuscript's Proposition 7.1 restated at six (claim C132-EXT)
  cost: one opening and one derivation job, no search; to read: the manuscript's §§ 7–8, `plans/FS116-V6-verification.md` § 2.2, `plans/FS114-derivation.md` ll. 26–60
  hunch: split — EMPTY runs (pieces of diameter at most 1, unit circles, the 60° twist); CV-EXISTS does not (it bends a map)
  falsifier: EMPTY's route naming an arc's curvature or a finite count of tiles at the vertex; or CV-EXISTS restated with no modification of the map
  rank: 1

question: what-the-extraction-needs-of-the-centres
  evidence: `plans/EXT-OAI2-reading.md` § 4.3, the row for step 9 ("[L₆] the centres whose transition graph has a cycle are locally finite … **Not supplied.**"); `plans/EXT-OAI1-audit.md` l. 404, `fullApprox_exists_of_finite_core` from "(L : Finset ℂ) (hL : ∀ x ∈ closedBall 0 8, ¬(transitionGraph c x).IsAcyclic → x ∈ L)"; the reading's EXT-OAI2-SLACK7-L, a seven-colouring by formula whose cyclic centres accumulate at one point
  expected: the extraction needs the centres finite on compacts, so at six that must be proved on a normal form (FS-127's question without arcs)
  ask: which property of the set of cyclic centres does the extraction's argument read — finite on compacts, or only closed and totally disconnected — and does the island colouring at seven, whose centres accumulate, still yield a point with its continua?
  if closed and totally disconnected suffices: [L₆] is replaced by a statement the island colouring satisfies; FS-127's accumulation question leaves the road; the normal form is not needed for the extraction, only for the exclusions
  if isolation is read at a named step: [L₆] stands as posed, for honest saturated colourings; FS-127 is re-aimed at it without arcs; the named step says what an accumulation of centres would break
  answered by: derivation — Ephodos
  cost: one derivation job on the manuscript's Lemmas 7.6–7.8 and Proposition 7.1; the island colouring is the test object, by formula
  hunch: total disconnectedness gives a point with essential loops at every small scale; the limiting directions of the continua are where it can fail
  falsifier: a step of Lemmas 7.6–7.8, Proposition 7.1 or Lemma 8.1 that reads an isolated centre — a continuum that must reach a fixed radius, or a direction that needs an annulus free of centres
  rank: 2

question: where-does-five-enter
  evidence: side A, `plans/FS131-close-inventory.md` l. 8333: "the cover's order — at six colours a point may need three positive coordinates, a 2-complex, where the disc is no obstruction"; side B, `plans/EXT-OAI2-reading.md` ll. 682–685: "the cover of order two against order three is not where five enters … Five enters in the two statements that would make one exist"
  expected: one of the two readings is wrong, and the record has already said which
  ask: with a triangle filled in the target wherever three classes meet cyclically, which centres of a measurable six-colouring stay essential, and is their forced existence a covering statement of order three with the unit distance in it?
  if the essential centres are the cycles of length four to six and a metric cover statement forces one: "some centre is not a triangle" is that statement — the shape of `[Voronov2023]` Thm 1.3 with holes, route R's (FS-122) — and needs no count of tiles, so G86's blindness does not reach it
  if a triangle centre is not filled by its own disc averages, or no order-three statement survives the holes: the target stays the graph, the existence step stays row 137's in the map class, and the premise both readings share is earned
  answered by: derivation — Ephodos, by `ephodos-invention` once recognition's homes are killed; the collision is § 1.4's invention signal, stated there in both sides' words
  cost: one derivation job; `[Voronov2023]` Thm 1.3's proof re-read for where closedness enters (row 132: once, "as compactness giving a band")
  hunch: the triangle fills and the statement is route R's in the release's vocabulary (0.35)
  falsifier: a triangle centre whose disc averages do not extend the map over it into the filled triangle; or a reading of Thm 1.3's proof that uses closedness beyond the band
  rank: 3
