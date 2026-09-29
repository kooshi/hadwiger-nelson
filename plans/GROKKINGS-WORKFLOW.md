# The workflow grokkings — retired from `CLAUDE.md`, recorded and not loaded

*Moved verbatim from `CLAUDE.md` § Grokkings on 2026-09-28, at Kooshi's word: "retire any workflow grokkings into their own file,
recorded but not always loaded". Each entry below is a rule about how the project works whose content the lanes' workflows now carry;
`CLAUDE.md` keeps its number and title, with a line naming where it is carried, so every `GN` cited across `plans/` still resolves.
Their second and later instances stay in `plans/GROKKING-INSTANCES.md`. The numbers are stable identifiers: never renumber, never
reuse. Read by address, never loaded; `tools/claude_md_fact_audit.py` joins this file to its corpus.*

## The paragraph that opened § Grokkings

***Every milestone opens with the reframe (WORKFLOW 2.0 step 3, Kooshi, 2026-09-22): first the re-grokking (3.1) — each entry below, each
row's mechanism in `LEDGER.md` and each method rule read from inside the milestone's question and its bearing extracted into the plan's phases, the
recognition it yields being the prior-art gate's (3.2) search query — then, for a derivation milestone, the invariant question (3.3, G72) — then the subplan (4); with the rigor of the modeling passes (6). The
entries are written to be reasoned from, not looked up, each ending in G67's form. These entries are the most important prior art this project holds; they are in context so that they are used, and a plan
that reasons from the literature's analogies while they sit unread has used them as background. FS-70 is the instance: G54's classifier, G16/G32's
pigeonhole form and G40's absorption each bore on it and none was run until asked for.***

## The entries

* **G30 — Measurement generates; derivation kills. [method]** A measurement buys a candidate pattern; a
  conclusion is bought by a derivation or a pre-registered replication on fresh objects. Sorted by provenance — three times, the
  last over 2026-09-05 to 2026-09-26 (the lists, the counting rule and the counts: `plans/GROKKING-INSTANCES.md` §G30) — the record
  is lopsided in one direction: **derived from structure first — survived, all but a few**, and each that died was one
  derivation's step, caught by another derivation, a review or an exact counterexample; **measured first, then interpreted — died,
  all but a few**, and each that survived had been bought afterwards by a test it could have failed or by a derivation. The rule this yields is NOT "measure less" — every derivation above began life as a pattern somebody noticed in
  a measurement, and the quadrature and stacking laws were derived precisely because earlier censuses had shown where to look
  (Kooshi's correction, the load-bearing half: *"the interesting patterns that become intuited and derived show up first from
  measurement, so it's a catch-22."*). Prefer measurements that turn a DIAL (a parameter whose behaviour is informative in both
  directions — G29's ladder, the hetero-dimer effort curve against overlap) over searches that hunt for a POSITIVE (whose null
  result is uninterpretable); and prefer CALIBRATED test beds — ask the new question on an object whose answer is already
  certified, so a zero reading bounds the instrument instead of being mistaken for a fact about the world. Failure modes:
  1. An escape clause whose interpretation contradicts what is already proven about the objects. Write the escape clause to the
     same standard as the prediction: a pre-registered interpretation is still an interpretation, and being committed in advance
     protects it from hindsight bias but not from being false.
  2. A prediction applying a grokking whose quantifier does not match the measurement — "no seam-field object forces five" does
     not imply "no seam-field halo replaces a defect".
  3. A verdict message naming a cause it did not check, which converts one bug into two (a defer message said "cost budget", a
     cause that never fired, sending the first diagnosis toward budgets while the size guard was the culprit).
  4. A derivation that is correct and second — novelty is a literature search at the opening (G49): "derived, therefore ours" is
     exactly the inference this grokking forbids everywhere else, and the search belongs at the opening, where it can still
     change the work.
  5. A theorem over a provably empty domain: every theorem whose hypothesis is a structure ships a named
     inhabitant (`scripts/vacuity.sh` enforces this).
  6. A correct instance recorded where a theorem was available (look for `[measured]` beside a small finite
     list, hypotheses narrower than the proof uses, a `decide` doing a step ring theory names). After
     generalizing, delete each hypothesis once and confirm the proof breaks. **Every one of these readings is TRUE**, which is
     exactly why they survive every gate this project has — nothing is wrong, something is merely smaller than it needed to be.
     The cause is not a bad inference; it is that *the instrument answered and the question closed*.
  7. A hypothesis implied by the emptiness of the conclusion's domain (`¬ Colorable G⁺ k → ∀ C : G.Coloring
     (Fin k), …` with G ≤ G⁺); remedies: the two-way form, a witness folded into the checked `Bool`
     (`NarrowCert.check`), or the inhabitant as a hypothesis.

  When a wall resists derivation, name the discipline its statement lives in and look for the theorem there
  (so far: graph theory → SAT → formal verification → Euclidean geometry → algebraic number theory → p-adic
  algebra → additive combinatorics → finite-field geometry; → topology (entered at FS-79: its cell-local four-colour formats are empty or blind and the coindex bounds stop at four on
  unit-distance graphs; the index bounds and non-local cocycles are open, row 80); → topological dynamics and algebraic `ℤ^d`-actions (entered at FS-89, row 95; its ergodic theory of amenable actions at row 88's close, row 111); → descriptive set theory (Borel and measurable combinatorics, entered at M3, rows 109–110); unentered: commutative algebra, FS-10).
  **The pattern: the project hits a wall in discipline N; the wall is a theorem in discipline N + 1; that theorem explains the
  wall and opens the next room. Every transition was forced by a specific obstruction, never by wandering — which is why
  "derivation kills, measurement generates" keeps holding: the walls ARE the theorems, and the work is recognizing which field
  each one belongs to.** Its positive form: Kooshi's instruction to write the conjecture UP for a stranger forced its structural
  statement (the unit-distance graph on F² is the Cayley graph of the additive group F(i) with connection set the norm-one
  torus), and the classical tool (Woodall/Fischer additive colourings) became visible the moment the object was named. *Rule:
  before spending days of compute on a conjecture, write it for an outside reader in its native mathematical vocabulary; the
  write-up is a derivation attempt in disguise, and it is cheaper than one census.* *Falsifier: none needed; like G21 this is a
  methodological invariant and it fails only by being ignored — but the tally is falsifiable: by a measurement-first reading
  that survives with neither a registered test nor a derivation behind it, or by derivation-first claims dying at the
  measurement-first rate.*
  *Do: when a measurement suggests a law — a pattern, a zero, a count that looks general — record it as a candidate, never a
  conclusion, and buy the conclusion separately: derive it, or register a replication on fresh objects before running it; before
  spending days of compute on it, write it for an outside reader in its native vocabulary, and if it resists derivation, find the
  discipline where its statement lives and seek the theorem in it; prefer a dial to a search for a positive, and ask a calibrated bed
  first; write every escape clause to the prediction's standard, and check that a grokking's quantifier matches the measurement before
  applying it. Killing test: the one above — a reading bought by neither a test nor a derivation that survives, or derivations dying
  as often as readings (the sort: `plans/GROKKING-INSTANCES.md` §G30).*
* **G46 — Recognize the classical theory first. [method]** Name the object in the vocabulary of the theory it
  already belongs to (Cayley graphs → character sums; frameworks → rigidity) and let that theory decide the
  question's shape before any search; the search then produces predicted instances, and the controls correct
  scope. Rank stubs accordingly: a finite exact computation plus a named theorem beats an object search; a
  stub with no recognition yet is a reading room; and read a search's failure as information about the search's genre, not
  about the objects. The recognition sentence is the prior-art query (G49).
  **And read the construction's own data layout, not only the plan's vocabulary for it** (2026-09-12): the result that
  closed M63's rotation screen came from four lines of `Arena.__init__` — the rotated half carries the same index set and
  internal edge list as the original — a mathematical fact the plan's vocabulary had no word for. When a plan and an
  implementation describe the same object, the implementation is the one that cannot round off. More instances: `plans/GROKKING-INSTANCES.md` §G46. *Do: when a new object or question appears — at a milestone's opening, or with a new prime, ring or construction — name it in the
  words of the theory it already belongs to and let that theory say possible, impossible or where before any search runs; use that
  recognition sentence as the prior-art query (G49); read the implementation's data layout as well as the plan's words for it; rank a
  stub that reduces to an exact finite computation and a named theorem above one that hunts for an object, and hold a stub
  with no recognition as a reading room; read a failed search as news about the search's genre. Killing test: a frontier milestone
  whose object search delivers what no recognition predicted — then the ranking is wrong for that genre.*
* **G49 — The prior-art gate. [method, measured]** Recognition is half the rule; the other half is a search
  at the milestone's opening (WORKFLOW step 3.2): in the discipline's words, never ours; under two disciplines;
  for the question as well as the method; outside arXiv. Past misses came from checking at the close,
  searching coined vocabulary, and searching one literature when the object sat in two. The check ran at the close, where it
  can only assign credit; run at the opening it changes what the milestone is *for*. Searching either literature alone finds
  nothing — which is also the honest explanation of why four milestones of reconstruction felt like discovery: *the gap was
  real, and it was a gap between literatures, not in them.* The field-plane
  reduction was derived independently at least six times, and the Polymath16 corpus (2018–2026) poses
  Theorem B's question while citing Fischer, Moorhouse and Vinh zero times — **and Theorem B's value was in print in 1994**
  (`[Fischer1994]`, read and verified 2026-09-22): a seven-page proceedings paper titled in the discipline's word for our
  object (*planar geometric graph*), in no citation database, found only by listing its author's works (WORKFLOW 3.2 item 8). **And the two-database cross-check has a
  failure mode that looks exactly like agreement** (2026-09-12): two citation databases both returned **zero** citing
  works for the survey that would have settled whether our object was known — both carried the same upstream
  identifier and both were the *preprint*, while one held the **published** chapter separately, with four citing
  works. **A zero from two databases sharing a source is one database's zero**: compare identifiers and versions,
  not counts, and open the citing lists; run that way it surfaced a 2007 paper counting sums of two squares over a
  **real quadratic** base. **And the audit's own gate, run on 254 theorems (FS-71):** six re-attributions, all in held papers read
  for a different question — a shell-counting formula in the quasicrystal literature (`[BaakeGrimm2003]`), a two-colour criterion
  in `[Fischer1990]` Thm 1's general form, odd-degree bipartiteness in `[Moorhouse2010]` §7.1; and one citation whose yearless key
  the bibliography audit could not see pointed at the wrong paper for six days. More instances: `plans/GROKKING-INSTANCES.md` §G49. **Row 88's close:** zbMATH's `ab:` field cannot hit a record whose summary is withheld (BMK 2017, `[ChenDai2017]`), so run `ti:`, `au:` and all-field queries beside it. *Do: at every
  close, run the gate on the theorems filed, in the words of the discipline each belongs to; a held paper is prior art for questions it
  was not read for — and grep the held Polymath16 threads for every milestone's headline object, in the discipline's words ("ring",
  "periodic", "colourings of `R₂`") and by its own numbers, before calling it new. Falsifier: three milestones running whose
  gate changes nothing about their scope — then the cost is not buying anything and the gate should be a close-time check after
  all.*
* **G50 — Read what the search found. [method]** A held-but-unread paper, or a bibliography title whose guess
  touches a live milestone, blocks that milestone's opening until scanned. **The more expensive misses were not unsearched —
  they were unread, sitting in our own bibliography under notes that had already guessed right.** **So the sequence that
  actually happened is: search → record → rank → forget.** A title with a guess attached is not knowledge; it is a debt, and it
  accrues interest at exactly the rate the project does work in that area — and **the cost of the scan is not the reason it
  keeps being skipped — the reason is that a title with a guess attached reads like knowledge.** An abstract is not a reading. Walk
  the citation graph of the paper that *posed* the question; cross-check citations in two databases; mine
  every read paper's references into the bibliography the same day; mark reading per section. More instances: `plans/GROKKING-INSTANCES.md` §G50. *Do: grep `BIBLIOGRAPHY.md` for a paper's arXiv id and Zbl number before fetching it or calling it unheld; scan, at the opening
  and before the derivation, every held-but-unread paper whose title touches the milestone. Killing test: three consecutive
  gates whose blocking papers, read, changed nothing.*
* **G51 — A competitor and an advisor beat one mind. [measured, one session]** A friendly competitor on the
  same problem plus an advisor (Poros, `~/source/poros`) advising both caught errors one agent missed, and
  two independent attempts hitting one wall licensed an impossibility theorem (row 58) — one attempt failing is a fact about the
  attempt. Design: isolate each
  agent's scratchpad (a shared temp directory is a covert channel), brief both identically, give the advisor
  the record and a written expectation, rule prior art shared. Records: `plans/COXETER-2026-09-08-mascot.md`,
  `plans/POROS-2026-09-08-mascot.md`. **The protocol and both briefs verbatim, with the review of what the advisor did (frame, instrument, refutation,
  method — decisive on all four): `plans/PROTOCOL-competitor-and-advisor.md` (2026-09-22), the template for the next use.** **The mechanism is not carefulness — it is a COST WINDOW** (2026-09-12): in
  one phase three agents exchanged about twenty messages, eight constructions or registrations were retracted, and
  the final plan contains none of those errors — **every retraction was free** (nothing committed, no solver time
  paid, nothing claimed to a third party). **Fast public error is the cheapest instrument available, but only while
  retraction is free, and in that window it should be spent rather than rationed**; once retraction is expensive the
  same speed produces escalation, because the cost of being wrong has become the cost of having *been* wrong. **Front-load the disagreement into the window before anything is paid for**, and
  **count the retractions in it: zero is not agreement, it means the disagreement has not started yet and will
  arrive later at full price.** *Do: at a wall, bring a second mind in while retraction is still free, and count the
  retractions — the wall FS-73 named for it — the inheritance question — returned a theorem at three colours; the next is the
  four-colour question (G71), where two independent attempts meeting one obstruction would license the negative.
  Killing test: a phase whose disagreement cost more than the error it caught; and, of the design as minted, a second run of this
  shape in which the competitor and the advisor produce nothing the single agent would not have produced alone, and the
  corrections all flow one way.* More instances: `plans/GROKKING-INSTANCES.md` §G51. Its runs: the protocol's §3. The standing rules they left: hand-backs content-free, every report by explicit message; working files in scratch until hand-back; neutral commit subjects from the first competitive commit on; work in stages from the first turn (FS-86 lost three responses to the output-token limit); quote statements verbatim in briefs; tell the advisor of every stand-down and launch.
* **G67 — A grokking is grokked by its form, and the reframe is re-grokking. [method; measured on one milestone]** The corpus
  is read in one of two modes — as background (understood, and left where it lies) or as an instrument (reasoned from) — and
  which mode an entry gets is set by its *shape*, not by its truth or its place in this file. On FS-70 the entries that fired
  were the ones written as laws and dials with an imperative and a falsifier: G65's degree law (*aim a ball before it is
  built*), G53's counting screen, G55's chain closers. The ones that sat silent while bearing directly were written as
  descriptions or memoirs: G54 says "classified by one sign" and never *when you meet a new prime, compute the sign first*;
  G16 and G32 narrate a milestone's route in the past tense; G40 states absorption as a result, not as the prediction to make
  before an arena is built. So **every entry ends with what it makes you do and what would kill it**, under one marker —
  `*Do: … Killing test: …*` — so the form can be scanned for: the *Do* opens with its **trigger** (*when you meet a new prime;
  before an arena is built; when a pair sweep reads zero*), never a bare verb, and the second half takes one of two shapes, by
  grade — a reading or a measurement names its **falsifier**; a theorem names what it **forbids** (*nothing kills it; it kills
  X*), and a falsifier invented for a theorem is a category error. An entry without both is understood, not grokked. The word was already right:
  "grokking" is first-person, held knowledge, and it indicts the failure by its name — an entry in context and not reasoned
  from was not grokked. What failed was the mode of reading, and the shape of the entry sets the mode. Hence the act that
  opens every milestone (WORKFLOW 3.1) is named for what it is, **re-grokking the goal** — reading the theory from inside the
  new question — and not "audit", which is felt as an instruction to check where "re-grok" is felt as an instruction to
  think. Every entry in this section has been re-examined for its form (2026-09-22) and given it where it was a memoir; a new
  entry is held to the same form at minting. *Do: when you write or read an entry, find its trigger, its Do, and its killing
  test or what it forbids; an entry without them is background, and a bearing it holds will be missed. Killing test: at the
  next re-grokking, count the* bears *verdicts drawn from a Do line against those drawn from an entry's body — if the form did
  the work, the first count dominates; and a §G written from entries in the form that still misses a bearing a memoir would
  have supplied. First data point (FS-71): a milestone whose object is the corpus itself drew its verdicts from grade tags and bodies,
  not Do lines — expected, and not a count against the form. M2's miss: G56 held the bridge's credit ("FS-39's bridge, which is
  `[Madore2015]` ¶5.4 plus de Bruijn–Erdős") in its body, not its Do; walked by its title it read silent, and the plan announced the
  credit as a finding.*
* **G72 — Pose a question that cannot be answered without an invariant every solution carries. [method; Kooshi's wording,
  2026-09-23; one instance (FS-73)]** *Its dual is G79.* The four-colour bound over ℚ(√167) (row 79) was not found by aiming at ℚ(√167). Both attacks that
  did aim at it had stalled: FS-61 searched for a refuting finite patch, and the refusing patches were priced near 10⁸ points; FS-73's
  P2b screen searched for colourings and left two lattices undecided. The bound fell out of a question about something else. *Does every
  colouring look like a periodic one?* was asked of every lattice at once, with the lattice's arithmetic removed and search forbidden.
  That question cannot be answered without saying something about an arbitrary colouring. The prior-art gate had named the object in its
  home discipline's words (a hom-shift), and that discipline's standard handle on arbitrary three-colourings is the height. The height's
  slope described every colouring, so existence became a finite polytope question, and three people independently turned it on the open
  instance (G71). **The reframing is three moves, and they outlive the tool.**
  1. Ask about the whole solution space, not about one solution.
  2. Take integers from the topology of the target: its loops, or, one dimension up, its spheres.
  3. Average over the symmetry to make those integers linear, and certify on the symmetry group rather than on the graph. A finite witness
     has to rebuild the symmetry by brute force. That is why the witness runs to 10⁸ points while the certificate is kilobytes.

  *Do: in every derivation milestone's plan (WORKFLOW 3.3, its §IQ), write the milestone's question twice.
  - **The existence form:** is there an object, a colouring, a forcer?
  - **The structural form:** a question about every solution. Pose it in the most general class where it still makes sense, with the
    arithmetic stripped when it can be. Its answer must need an invariant that all solutions carry.

  Route the structural form through derivation, with search excluded. Name the invariant it forces, or say that none is known; then
  finding one is the milestone. When a new exact decision procedure lands, point it at the open-instance list the same day. Killing test:
  across derivation milestones, count the results that came through the structural question against those that came from searches or
  extensions of a known tool. If the structural question keeps producing nothing a direct attack would not, the method is ceremony.*
  **The count so far — eighteen of twenty-one** (each derivation close's §IQ record; milestone by milestone in `plans/GROKKING-INSTANCES.md` §G72; the latest, FS-114 and FS-111, both through).
