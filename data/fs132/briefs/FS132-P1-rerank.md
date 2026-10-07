# Brief FS132-P1 — the frontier after an outside proof of six became this project's literature: the re-rank, and the question of the milestone that opens on it

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word. Launch line: "Your brief is on disk: read it in full first."*

brief: FS132-P1
  identity: Poros — your agent file (`.claude/agents/poros.md`) is your identity and your lane's workflow (job 1: the re-rank and the next question); invoke `poros-anomaly-hunt` fresh with the Skill tool for the re-read, as job 1 says, and `poros-reframing` if the frame itself has moved — it may have
  role: the ask lane at the largest change of ground this project has had — re-read what an outside release proves, in its Lean and in its manuscript, against this project's whole theory; re-rank the frontier with those theorems as literature; say what of the running Lean backlog still bears; and pose the question of FS-132, the milestone that opens on them, aimed at six against seven; and the stub of FS-133, a consequence Kooshi wants built on at once
  launch: into the first slot that frees; a Lean audit of the release and a reading of its manuscript are finishing — their records are your inputs, and both have saved the stages you need
  mission: § Why this job
  statements: § What Kooshi asked, and where the ground now is
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind
  channel: message the coordinator ("main") by SendMessage for **the question of FS-132 as soon as its card is saved** (a deriver's slot waits on it), for any consequence of the release that a short job could turn into a result this week (one is already named below — say whether it comes first), and for a question you cannot work around; the report goes to `data/fs132/reports/FS132-P1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/POROS-2026-10-07-after-release.md`
  touches: `plans/POROS-2026-10-07-after-release.md`, `plans/STUB-*.md` (question sections, and the stub you mint for FS-132 — never a banner, never another lane's bearing lines), `data/fs132/p1/`, `data/fs132/reports/FS132-P1.md`; **not** `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md` (your re-rank is a draft in your record: I file it), the outside clone at `/home/kooshi/source/math` (read it; write nothing into it)
  budget: about 350k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. Two weeks ago this project's theory arrived at one sentence — given measure rigidity, the plane's chromatic number is that of
measurable colourings proper at almost every unit pair, and the question is whether holes of vanishing density can save a colour — and
you ranked the frontier under it. Yesterday an outside organisation published, among 722 machine-found manuscripts, a proof that the
plane is not five-colourable. It proves that sentence's reduction outright, for every number of colours, by a rigidity theorem of its
own; then it removes five by deriving interface exclusions from measurable data alone, with no regularity assumed. This project built
its Lean proof today: it compiles at its pinned toolchain on the standard three axioms, and the statement is the claim. Kooshi has
made it literature of this project. The ground you ranked has moved under every stub. Rank it again.

## Why this job

The problem is now six or seven, for everyone, and the proof that made it so is public: every group that works on this problem can
read it today. What this project has that they do not is the other half — months of theory about exactly what the release leaves open:
the regularity programme at six, the tight six-maps, the local exclusions, and a kernel library of thousands of statements about them
— and a reduction it reached independently, so that it already knows what the next question is in its own words. Kooshi's instruction
is to use that: build on the release and move first. Which question is the one to move on is yours, by your lane's one rule — rank a
route by its bearing on the answer, never by its difficulty — and both of its answers must be results.

## What Kooshi asked, and where the ground now is

**His words** (`data/external/EXT-OAI1-request.md`, read whole — the file gives the five questions the third answers; the first is
the trigger of his standing instruction, the second his decision after the build, the third his plan: import; the front page's two
sentences; a stub for the consequence; the backlog paused until your re-rank):

> > We have an analysis trigger. OpenAI released a trove of manuscripts on open questions. Have a special slot reviewer check it for anything related to our project. Clone it in `~/source`, as I'll be exploring it for other things as well. https://github.com/openai/math
> — source: data/external/EXT-OAI1-request.md

> > You may use their proof as any other literature. Cite it, build on it, let's use it to slingshot us past anyone else working on this problem.
> — source: data/external/EXT-OAI1-request.md

> > 1. port or import: let's import and adopt parts piecemeal if needed. 2. indeed 3. definitely build on it... write the stub 4. not sure, probably allow, but audit what it does 5. pause the backlog, lets come to a stopping point, collect ourselves and have poros rerank.
> — source: data/external/EXT-OAI1-request.md


**What happened today, item by item** (the FS-131 inventory, `plans/FS131-close-inventory.md`; the first lines are quoted as addresses
— read each item whole: they carry what was checked by whom, and what was not):

> 607. **KOOSHI'S STANDING CONDITIONAL HAS FIRED (item 489): an outside release holds a claimed proof, with a Lean formalization, that the plane is not five-colourable — `χ(ℝ²) ≥ 6` with no assumption on the colour classes** (source: Kooshi's message, 2026-10-07 about 01:30 UTC, verbatim in `data/external/EXT-OAI1-request.md`; the release cloned by me to `~/source/math`, commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a`, one commit dated 2026-10-06, 3.1 GB, 132,851 files).
> — source: plans/FS131-close-inventory.md

> 611. **EXT-OAI2, first message: the dictionary — the outside manuscript's "weak measurable colouring" is exactly this project's `χ_m⁰` object, its transfer theorem is `χ(ℝ²) = χ_m⁰(ℝ²)` with no hypothesis, and it does not do without measure rigidity: it proves one of its own** (source: EXT-OAI2's message to "main", 2026-10-07; record `plans/EXT-OAI2-reading.md` stage 1, commit `6c2d2134` on `main`; a reading, one mind, of definitions and statements — the proofs unread at this stage).
> — source: plans/FS131-close-inventory.md

> 613. **EXT-OAI2, second message: the outside manuscript's transfer is read in full — no gap found, one mind, one pass; it proves measure rigidity at the real algebraic numbers by a route that uses no entropy and no Einsiedler–Lindenstrauss, and it does not give this project's rigidity at a number field** (source: EXT-OAI2's message to "main", 2026-10-07; record `plans/EXT-OAI2-reading.md` stage 2, commit `183010ff` on `main`; their §§ 2–4, 1,557 lines).
> — source: plans/FS131-close-inventory.md

> 614. **EXT-OAI1, third message: THE OUTSIDE PROOF BUILDS HERE, ITS HEADLINE RESTS ON THE STANDARD THREE AXIOMS, AND ITS STORED STATEMENT IS THE CHALLENGE'S — `χ(ℝ²) ≥ 6` is a kernel-checked theorem on this machine at the release's toolchain, and so is the transfer `χ_m⁰(ℝ²) ≤ χ(ℝ²)` for every number of colours** (source: EXT-OAI1's message to "main", 2026-10-07 about 02:25 UTC; record `plans/EXT-OAI1-audit.md` stage 4, commit `e56ea847` on `main`; everything cited under `data/external/oai1/`).
> — source: plans/FS131-close-inventory.md

> 615. **KOOSHI'S WORD ON THE OUTSIDE RELEASE, 2026-10-07 (verbatim; also in `data/external/EXT-OAI1-request.md`, second word): "You may use their proof as any other literature. Cite it, build on it, let's use it to slingshot us past anyone else working on this problem."**
> — source: plans/FS131-close-inventory.md

> 616. **EXT-OAI1, fourth message: the outside proof's shape, from its Lean — two arms and a three-line headline; the five-colour arm assumes only a measurable weak colouring and builds every structured object from it by measure; a covering obstruction on a disc closes it** (source: EXT-OAI1's message to "main", 2026-10-07; record `plans/EXT-OAI1-audit.md` stage 6, commit `8fc4ab79` on `main`; `data/external/oai1/docindex-five.txt` (232 documented declarations), `module-graph-five.txt`. Statements and definitions read by it, and `Five.lean` whole; no proof below it line by line).
> — source: plans/FS131-close-inventory.md

> 617. **KOOSHI'S THIRD WORD, 2026-10-07 (verbatim; `data/external/EXT-OAI1-request.md`, third word, with the five questions it answers): "1. port or import: let's import and adopt parts piecemeal if needed. 2. indeed 3. definitely build on it... write the stub 4. not sure, probably allow, but audit what it does 5. pause the backlog, lets come to a stopping point, collect ourselves and have poros rerank. — Oh look, you've already laid out basically the same plan. Carry on then. Make sure your handoff carries the new plan."**
> — source: plans/FS131-close-inventory.md

> 618. **EXT-OAI2, third message: the outside manuscript's obstruction at five is read in full — no gap found, one mind; it goes around the map step and proves no regularity; five is one count spent in three five-only statements; two of them are false at seven, so at six they can hold only on a normal form — and that normal form is this project's** (source: EXT-OAI2's message to "main", 2026-10-07; record `plans/EXT-OAI2-reading.md` stages 3–4, commits `2f18d416`, `422dec3e`, `1076316a` on `main`; their §§ 5–8, 2,747 lines).
> — source: plans/FS131-close-inventory.md


**Your inputs, by address** (read them whole; nothing in this brief stands in for them):
- the audit of the release's Lean: `plans/EXT-OAI1-audit.md` — stage 4 (the build, the axioms, the statement), **stage 6 (the proof's
  shape: the chain of named statements with their exact hypotheses, which hold for every number of colours and which for five, and
  the auditor's one-mind reading of where five is used)**, with `data/external/oai1/docindex-five.txt` (232 documented declarations);
- the reading of its manuscript: `plans/EXT-OAI2-reading.md` — stage 1 (the dictionary: their notion is this project's `χ_m⁰`
  object), stage 2 (the transfer, read in full: rigidity proved at the real algebraic numbers, by properties no number field has),
  stage 3 (the obstruction at five, in four acts, and how it goes around the map step), and **stage 4 (every step against every
  `k`: the three five-only statements, what six would need — its [P₆], [L₆], [G₆], [A₆] — against rows 131–154, and a calibration
  showing two of them false at seven)**; its last stage, the front page's replacement sentences, may still be in progress;
- the release itself, read-only: `/home/kooshi/source/math` — the manuscript's source under its `preprints` folder for the
  five-colour paper, the Lean under `lean/OAI/Geometry/PlaneColoring`, and a catalogue of 371 other result families
  (`/home/kooshi/source/math/CONTENTS.md`) that nobody here has read.

**The ground as this project wrote it before today** (`CLAUDE.md` § The aim and § Counter-priors; first lines):

> 1. **Given MR, the plane is the measurable problem.** `χ(ℝ²) = χ_CP(ℝ²) = χ_m⁰(ℝ²)` — the fewest colours in a Lebesgue-measurable colouring
> — source: CLAUDE.md

> 3. **Density cannot give six.** One colour class at a time is capped below 4.37 (row 129); a proof of six must use how the classes fit
> — source: CLAUDE.md

> 4. **Regular colourings need seven, verified and almost everywhere** (row 132). Closed colour classes need seven (`[Voronov2023]` Thm 1.3: six
> — source: CLAUDE.md

> 5. **So, given MR, Hadwiger–Nelson is one question: can vanishing holes save a colour?** With no MR, `χ_m⁰(ℝ²) ≥ 7` iff six classes, each
> — source: CLAUDE.md

> 6. **Its tools are Voronov's circle topology made robust, and the density topology** (approximate continuity, Lebesgue density, De Giorgi's
> — source: CLAUDE.md

> 1. **Rank a route by its bearing on the answer**, never by its difficulty, its length or its formalization effort.
> — source: CLAUDE.md


**The ranking you made** (`plans/FRONTIER-STUBS.md`, its top three; read the file whole):

> | 1 | **FS-124 the (Q) ring** — `plans/STUB-q-ring.md` (minted 2026-10-03 by FS116-Z2; FS-116's successor; route M's first half, and route R's exact-map form) | does every vertex of at least four colours whose ring carries (Q) arcs, and every vertex of five or six colours, die within an explicit radius? **First** (its question section, FS129-P1): what a (Q) ring passes to the four-colour vertices its change points place, and whether that is conserved — if it is, cases 1, 3 and 5 are one statement about the placed skeleton. Held: the placing rule (FS116-RING-GERM and FS116-N3-SEMI; the assembled rule FS116-RING-TRANSFER-QC one mind); since FS-129, two change points 60° apart whose far germs lie off (Q) arcs share no sole tip and no sole outer colour, and E2 at one blade dies (row 150), and DISC-F follows from the exclusion in the non-Siamese simple class (row 153). Left: SEMI-PAR3, the disk's corner (RING-Q false below `≈ 1.5985`), crossed reciprocity, the five- and six-colour vertices (FS116-Y2-SIXFRAG holds every disc below `3/2`), the recurrence, FS114-K1's (Q) residues (E1, E2 at two or more blades, the Reuleaux HALF class); its Siamese class (case 7) waits on FS-123's card | the main remaining case set of C114-LOCAL-F and the YES side's home: every held positive past `√3` has (Q) arcs on its four-colour rings (row 136), and in the non-Siamese class no other ring survives past `1 + ε` (row 149); a NO here with FS-123's is C114-LOCAL-F (`[SokolovVoronov2025]` Question 2's unit-arc half; with route M's map step at six, `χ(ℝ²) = 7` given MR), and in a valid map it leaves no close complementary cubic trichromatic pair, route R's exact-map form (FS112-N3-COR3; FS129-OR1 § J15); valid fragments about (Q)-ring vertices on discs of every radius give `χ(ℝ²) ≤ 6` with no MR (FS116-O1-YESLIM, held). Each case alone is a piece | unpriced | minted 2026-10-03; rank 1 since FS-129 (FS129-P1) | no solver wanted: derivation, exact fragments by formula; FS-116's list § 9 binds it through its stub
> — source: plans/FRONTIER-STUBS.md

> | 2 | **FS-123 the Siamese class** — `plans/STUB-qfree-ring.md` (minted 2026-10-03 by FS116-Z2 as the (Q)-free ring; re-aimed at FS-129, its banner) | in the non-Siamese class, simple or not, no vertex of at least four colours whose ring carries no (Q) arc survives past `1 + ε` (row 149: FS-112's bends, run on a whole-tile restriction of radius at most `√3`, keep the class and leave only (Q) arcs). Left: the same with Siamese pairs — FS129-OR1-QFREE-CLASS reduces it to FS116-Y4-EMPTY's Siamese form — and then the Siamese class of FS-124's cases. **First** (`plans/POROS-2026-10-03-fs129-rerank.md` § 2.4, card 3): does FS116-V6's route to EMPTY read non-Siamese anywhere but among the tiles at `p`, at the ring's tips and at the hug tiles? Leads: the V5-RING family holds without simplicity; G83's straddle is a near miss in the Siamese class (FS129-MR1, table of misses) | a necessary piece of C114-LOCAL-F: valid maps may carry Siamese pairs, which no tile count sees (G86), so the six-map NO needs this class; with FS-124 it is C114-LOCAL-F (with route M's map step, `χ(ℝ²) = 7` given MR); Siamese fragments about such vertices on discs of every radius give `χ(ℝ²) ≤ 6` with no MR (FS116-O1-YESLIM holds for every valid fragment) | unpriced | minted 2026-10-03; question 1 answered at FS-129; re-ranked 1 → 2 (FS129-P1) | no solver wanted: derivation, reading, exact fragments by formula; FS-116's list § 9 binds it through its stub
> — source: plans/FRONTIER-STUBS.md

> | 3 | **FS-104 `χ_CP(ℝ²)` at six** — `plans/STUB-cp-plane-six.md` (minted 2026-09-26 by R3 from R1's N2; its banner) | **Rank 3 since FS-107's close; below route M's local exclusion since FS-114's and FS-111's closes; re-aimed at the reframe, not demoted.** Is `χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6` (row 130)? Its null-set step to Falconer's `χ_m` is one sub-question of row 131's question (`plans/STUB-regularity-wall.md`); standing: `χ_B`, the ZF + DC audit (Soifer's Open AC Problem 62.14); the density family (a CP five-colouring needs `m_j(ℝ²) ≥ j/5`; `m₄(ℝ²) < 4/5`?), `k`-point correlations (FS-80's route), `χ_g(H)` (post-ban). At FS-129: route (c)'s linear-identity format is empty wherever a residue target is slack (row 151); route (b)'s literal CP reading is empty for rotation-invariant laws, and a five-colour Falconer fan — which would give Falconer's `χ_m ≥ 6`, not `χ_m⁰` — can live only over fields with no `𝔽₃` or `𝔽₇` place, its tip in its apex's class at every `𝔽₁₁` and `𝔽₁₉` place (row 152). **Route (e), route M at five**: given REG-J′₅ the top colour at five is equivalent to this stub's YES (row 154; FS-128 carries it), and the cover route's rungs MUA-REG-P and MUA-FIN (FS-120 carries both) need no NO beyond FS106-AE-MAP6 — a reduction if neither must spend five, a restatement (FS111-VM2-EQ5) if one must (`plans/POROS-2026-10-03-fs129-rerank.md` § 2.4, card 2) | decisive both ways: a NO — a CP five-colouring — gives `χ(ℝ²) = 5` with no MR (link 2; FS-44's side); a YES gives `χ(ℝ²) ≥ 6` given MR (row 128), a new lower bound independent of the six-map NO that leaves six against seven; a question about measurable colourings (row 130); on the direct routes a named no-go, or a tie of `χ_CP` to `χ_m`, is the likely product; route (e) is the route whose pieces may be colour-generic | unpriced; the reading first | minted 2026-09-26; re-ranked 1 → 3 by RF1, its null-set step folded into FS-107 | none for the reading and derivations; `χ_g(H)`'s LP post-ban |
> — source: plans/FRONTIER-STUBS.md


## Done means

1. **Your readback and the re-read.** Check the quotations above against their sources; read the two records, the six inventory
   items, the manuscript's introduction and overview, and `plans/FRONTIER-STUBS.md` whole. Then the anomaly hunt, fresh, over the
   release against this project's theory: what does their proof do that this project believed needed more, and what does this
   project hold that their proof does not reach? Register, before you rank: which stub you expect to be first, and whether you
   expect the next milestone's question to be about six-colour measurable colourings directly or about one named step of their
   argument. Commit and push.
2. **The triage of every ranked stub and of the aim's six links**, each in one line with its reason: *answered* by the release
   (FS-104 is the first candidate — say exactly which form is answered and which is not); *unconditional now* (which sentences lose
   "given MR", and — from the reading's stage 2 — which keep it: the field rows do); *re-aimed* (the stubs about tight six-maps and
   the map step: does a finite cyclic core for measurable colourings, proved at five, change what route M's regularity step must
   supply at six?); *unchanged*; *closed as a direction*. Every answered or re-aimed stub gets its banner drafted (I file banners).
3. **The question of FS-132**, as a card in a stub you mint: existence form and structural form (the second not the first
   reworded), provisional bearings, what a YES and a NO each give, and the first claim a deriver should take. The frame to test,
   stated as a question and not as a route: the release closes five by a cover of order two against a disc; at six a point may
   carry three colours and that obstruction is gone — so what, in this project's holdings or in the release's statements that hold
   for every number of colours, takes its place? **Message me when the card is saved.**
4. **The one-class consequence gets a stub of its own — Kooshi's word: "definitely build on it... write the stub".** It is named
   by the manuscript's reader (inventory item 613 (1); its sketch is § 2.6 of `plans/EXT-OAI2-reading.md`): the release's rigidity
   theorem run for one colour class would give `α₁(ℝ²) = m₁(ℝ²)` and its fractional form with no hypothesis — a clause of a 2026
   conjecture and a 1996 question — and the manuscript does not state it; one step is unchecked. **Mint its stub as FS-133** (the
   number is fixed), in the stub rule's full form: the mission context in plain language, the question card with both forms, what
   each answer gives, the question in the literature it answers (`CLOSED-QUESTIONS.md` is this project's list of those;
   `LEDGER.md` row 129 is where this project stands on it), the unchecked step as the first claim a deriver takes, and the
   prior-art risk of someone else drawing it from a public proof. Say whether FS-133 or FS-132 takes the deriver's first slot,
   and list any other consequence a short job could close this week, each the same way.
5. **The backlog is paused, by his word, until this re-rank** ("pause the backlog, lets come to a stopping point, collect ourselves
   and have poros rerank"). FS-131's waves 6 (the saturated class), 7 (the four-colour vertex), 9 (the reductions) and 10 (the
   arithmetic floors) each have briefed jobs waiting; their state is `plans/SESSION-HANDOFF-2026-10-06.md` §§ 2–4. In one table:
   which waves formalize something the new frontier stands on and resume first, which formalize something the release answers or
   supersedes and are retired or re-aimed, and which can wait — so that three agent slots go where they bear. This table is what
   restarts the milestone, or does not.
6. **The re-rank**, as a draft of `plans/FRONTIER-STUBS.md`'s table in your record, with FS-132 placed; and the catalogue's other
   families that a route of the new ranking could use — named from their catalogue entries only, each marked unread.
7. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed; your gate
   (`.claude/skills/poros/scripts/poros_gate.py all` on the card, from its skill directory's conventions) green; the report in
   standing rule 11's form. Stopping at a saved stage with the card sent and the re-rank part-drafted is a good report.

## What is yours to decide

The ranking, the question, its two forms, and what comes first. Attack the frame — including this brief's: if the release shows that
this project's road to seven (the tight map made a map, then a local exclusion) is not the shortest one, or that the question is not
"six against seven for measurable colourings" at all, that is the finding this job exists to make. And attack the release's reach as
hard: what it proves is five; say exactly what it does not prove. Do not lean toward yes: a question whose NO is a theorem is as good
a milestone as one whose YES is. You start no agents of your own (standing rule 1: delegation is one level deep, because the
coordinator can only review work it knows exists).
