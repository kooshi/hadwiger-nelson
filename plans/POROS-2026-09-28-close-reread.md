# Poros — the boundary re-read of FS-114's and FS-111's closes, and the draft re-rank (job R1, 2026-09-28)

*Poros (Opus 5.5), job R1, for Keryx; brief `data/workflow3/briefs/R1-poros-close-reread.md` (commit 09c92381), with
`plans/STANDING-RULES.md` as part of it. Identity `.claude/agents/poros.md`; `poros-anomaly-hunt` invoked fresh with the Skill tool before
stage 1 (its order: inventory by provenance, expectation, then read). No fences: both milestones are closed and no blind job is running. The
hunch ledger is carried forward from `plans/POROS-2026-09-27-night-aim.md` § 5 (the latest Poros record with a ledger).*

## Stage 1 — SAVED

### 1.1 Readback of the brief

The brief holds one quotation. Checked against its source:

- *"Understood. Let's close up, then hand off to a completely fresh session with a note to check for keryx and be watchful of the new workflow in
  comparison to the old."*, cited to `plans/WORKFLOW3-test-drive.md` row K2 — **verbatim match**, line 12 of that file (row K2, "2026-09-28 ~21:35
  UTC").

Other statements in the brief, checked:
- "`CLAUDE.md` has about 11,000 bytes of room under its 300,000-byte limit" — **true**: `wc -c CLAUDE.md` reads 288,911, so 11,089 bytes of room.
- "Rank by bearing on the answer, never by difficulty, length or formalization effort (`CLAUDE.md` § Counter-priors, rule 1)" — unquoted and a
  fair restatement of `CLAUDE.md` l. 132: "**Rank a route by its bearing on the answer**, never by its difficulty, its length or its formalization
  effort."
- "Your hunch ledger, carried forward from `plans/POROS-2026-09-27-night-aim.md` § 5, with that record's § 2 ranking and § 3's first questions" —
  true: § 5 holds five hunches, § 2 the ranking, § 3 three cards.
- "The ban on finite-witness search ends 2026-10-01" — consistent with `CLAUDE.md` § Toolchain ("No search for a finite witness runs from
  2026-09-24 to 2026-10-01").
- "their new stubs FS-116 to FS-122, whichever were minted" — not yet checked; `plans/FRONTIER-STUBS.md` holds no FS-116 to FS-122 row (grep, this
  stage), as expected, since Keryx files after this job. Checked in stage 2 against the closes.

No mismatch.

**The task, restated.** Two milestones closed today under Workflow 3.0: FS-114 (the unit-arc question) and FS-111 (the cone scale). A fresh session
will open the next milestone from the ranking this job drafts. I re-read each close's whole record against expectations written here, before
the reading; score my hunch ledger in the open; and draft (a) the ranked-stubs table of `plans/FRONTIER-STUBS.md` exactly as its rows should read,
every new stub at its rank, FS-114 and FS-111 moved to the closed list, a banner line for each demoted stub, and (b) the `CLAUDE.md` § Paths
forward rows and "Next:" clause, within about 2,000 net bytes. I rank by bearing on the answer. Keryx files; I write only this record,
`data/workflow3/r1/` and the report.

**The conditions of this reading, stated before it.** Before writing the expectations below I had seen, beyond `CLAUDE.md` and the night-aim
record: the commit subjects of both milestones (`git log`, 2026-09-27 18:00 onward), which are neutral except a few. The ones that carry content,
and so shaped the expectations below: "FS-114: the Reuleaux bowtie family closed at root 3 by two blind routes; construction round 5 launched";
"FS-114 inventory: no Reuleaux bowtie reaches root 3 (construction side, one mind)"; "FS-114: the bowtie exclusion at root 3 verified"; "FS-114
inventory: the reduction's chain intact at the 60-degree boundary"; "FS-114 inventory: Kooshi's question on the collapse; mass transport as a
lead"; "FS111-M2: stage 4 (M2-INTRAD scope corrected)"; "FS111-M3: stage 3 (cascade statement)"; "FS111-C: stage 3 — the derivation file, an
erratum to FS-107's, the query tool". I had also listed the job directories (`data/fs114/`, `data/fs111/`) and plan files by name, and read the
frontier file's header, its first ranked row and its closed-list head. I had read none of the close records, plans, derivation files, job
records or BASE-V's record.

### 1.2 Evidence inventory (by provenance; expectations written before any of these was opened)

*The order is provenance, oldest first within each milestone: plan, the proof and construction rounds, the audits, the derivation file, the
close, its inventory; then the side job; then the frontier. Each expectation is measurable where I could make it so; the ones farthest from my
hunches are written from the instrument's design or from the goal.*

**FS-114, the unit-arc question**
- `plans/FS114-unit-arc-question.md`, the plan (§G, §PA, §IQ, the chosen form) — read against: the plan attacks DENSE3's form ("every valid map", the NO itself), does not commit to the four-colour form for maps that are not periodic, and leaves FS-115 unopened (0.65, hunch `fs115-waits`); its §IQ structural form names an invariant or says none is known; card 2 (local or global) is answered "global" or left open, not "local" — surprised: yes; on the form no — the plan (ll. 511–512) says "The four-colour form is not chosen for aperiodic maps, so FS-115 does not open on FS-114's account" — but card 2 was neither answered "global" nor left open: it was reframed by compactness (`plans/FS114-C-close.md` §4.1 item 1; FS114-N114-COMPACT, two minds), and the plan's own E1 ("card 2 chooses a local route over a count", 0.55) scored not met
- `plans/FS114-N-proof.md` … `plans/FS114-N7-proof.md` and `data/fs114/reports/FS114-N*.md`, seven proof rounds (N, N2–N7) — read against: each round excludes a local configuration about a four-colour or repeated-colour vertex at radius ≤ 3 (the bowtie at "root 3" among them), none closes the NO, and the last round's stall is a named step; at least one round attempts a plane-wide count (Euler/discharging) — surprised: yes; the count came first (FS114-N2-ENDS: route T's charge, negative only at a degree-4 four-colour vertex with three or four tactic edges) and set rounds 2–6's targets; the exclusions landed at `√3` and `1 + ε`, not at "radius ≤ 3" in general; round 7 was not run (the close's §1.3, Kooshi's ruling, inventory item 121) — read through the close's §2.2 table and the derivation file, not the seven records
- `plans/FS114-NB-verification.md`, `-NB4`, `-NB5`, `-NB6`, the proof side's blind verifiers — read against: four verifications for seven proof rounds, so three rounds (N2, N3, N7) stand at one mind; each verdict TRUE or TRUE-after-repair, none FALSE — surprised: no; rounds 2 and 6 had no blind verifier (§2.1: N3 "none run (item 57: the slot went to FS-111)", N7 "none"), so N3's lemmas and N7-3T stand at one mind, as expected in kind
- `plans/FS114-Y-construction.md` … `-Y6`, six construction rounds — read against: no YES; each construction dies at a missing second four-colour vertex or at a pinned corner (G83's reading), and the Reuleaux bowtie family is the round-3/4 object, closed at root 3 — surprised: yes; no YES, but the deaths are not "a missing second four-colour vertex": every kill is "a straddle: two tiles of one colour forced along two unit circles to come within 1, seen at second order" (drafted row 138, `plans/FS114-C-close.md` l. 418); the capped strip holds discs below `φ²/√2 ≈ 1.8512` (FS114-Y-DIAL, two minds)
- `plans/FS114-YB-verification.md`, `-YB2` … `-YB5`, the construction side's blind verifiers — read against: each confirms its round's refutation or finds a counting slip; none turns a refutation into a YES — surprised: yes; a divergence of truth in every round, 21 in all, four of them raising a claim and all four flattering the NO, one (E2's cut to S6) on YB5 alone (§2.4)
- `plans/FS114-L60-audit.md` — read against: an audit that the reduction (row 135's) holds at the 60° boundary, TRUE, one mind — surprised: yes; FS112-L60 ("below 60°", two minds and a tool) is FALSE at exactly 60° — the tool's plant sat at 50° (§2.2 row N4-L60; drafted §G21 instance)
- `plans/FS114-CV-verification.md`, `plans/FS114-CVB-verification.md`, the composition checks — read against: the composition of the round results into a statement about every map checked at two minds, one blind, and found to hold with a scope restriction — surprised: yes; stronger than expected: FS114-CV-EXISTS, every valid map has a vertex of at least four colours, in the map itself, residue empty, two minds blind to each other by different routes (§2.3)
- `plans/FS114-derivation.md` — read against: between 10 and 40 theorems filed, most [hand] at one or two minds; none closes the NO or the YES — surprised: no; 46 entries (43 derived, 3 stalled or gapped), none closing the NO or the YES (close stage 3); entry FS114-N114-COMPACT read in full (ll. 288–305)
- `data/fs114/claims.md`, the frozen claim list — read against: every theorem in the derivation file appears once, with its grade — surprised: yes; its own lines contradict the close's headline: C114-COMPACT (l. 117: "for each `K`, Q-full_K's NO holds if and only if some radius `R(K)` admits no valid fragment … The question card 2 leaves is whether an explicit `R`, and one uniform in `K`, exists") and l. 282 ("a NO at bounded `K` only is Q-full_K's, not Q-full's") — against "the unit-arc NO is exactly C114-LOCAL-F" (§2.6 item 1); finding F1
- `plans/FS114-C-close.md`, the close record (reconciliation, headline, sweeps, `## Drafts for the front page`) — read against: FS-114 **closed undecided** (0.85): NO not landed, YES not landed; one or two ledger rows (137–138) drafted; between two and four successor stubs minted; its draft "Next:" names one of its own successors — surprised: yes; undecided as expected, but two stubs minted (FS-116, FS-117) and two numbers skipped (FS-118, FS-119, §5), and the drafted "Next:" is "Next: Poros's re-rank" (l. 476), not a successor of its own
- `plans/FS114-close-inventory.md` (89 KB) — read against: Kooshi's question on "the collapse" and a mass-transport lead logged; items on staffing and the workflow switch; no decision left open that bears on the ranking — surprised: no; read by sample — items 78, 79, 121 through the close's citations (§4.3 item 3, §5, the stub FS-115's paragraph) — the mass-transport lead checked (NB6-MTP) and the close-now ruling (item 121); no ranking decision left open

**FS-111, the cone scale**
- `plans/FS111-cone-scale.md`, the plan — read against: card 1 (does the route to seven close with two doors) answered at §IQ, by derivation, **"a third statement is needed"** (0.6, hunch `third-statement-needed`); the prior-art gate names regularity of near-minimisers (De Giorgi, Almgren, Taylor) and distance-avoiding compactness (Bukh, Falconer–Marstrand, Furstenberg–Katznelson–Weiss) — surprised: yes; card 1 answered at round 0 (FS111-P, FS111-V0 blind) as "a third statement is needed", but one of my three candidates is not a third statement at all: "a hole bound uniform in `K` is not a third statement but seven itself" (FS111-C1-UNIF, two minds; close §2.6 item 1) — read through the close's §2.1 round 0, not the plan's own text
- `plans/FS111-M-regularity.md`, `-M2`, `-M3` (finiteness), `-M4` (cascade), four derivation rounds — read against: partial regularity results for near-optimal band-proper six-colourings (a density or perimeter bound at one or two minds), no cone-scale lower bound proved, and no refuting family — surprised: yes; the object changed at round 2 from tight colourings to maximal covers (measurable fall colourings), M2-REDUCE-C at five turned out a reformulation (FS111-VM2-EQ5), and the named gap is the pinch at a junction (M4-MOVE, one mind) — read through the close's §2.1 and §2.6
- `plans/FS111-W-wild.md`, the wild side — read against: a construction side looking for a family with holes → 0 and cone scale → 0; none found; one or more no-gos on how such a family could look — surprised: yes; W-NEG (two minds): every existence rung is TRUE at `k ≥ 7` and its failure at `k ≤ 6` is `χ_m⁰(ℝ²) ≤ k`, so no wild object can refute a rung; W's own registrations (no saturated seven-colouring, 0.65) were FALSE by de Grey's R7, in print since 2018 (§4.5)
- `plans/FS111-V0-verification.md`, `-VM2`, `-VMW` — read against: V0 checks the plan's §IQ derivation (card 1), VM2 checks M2, VMW checks M and W; each TRUE or TRUE-after-repair, with M2-INTRAD's scope narrowed — surprised: no; three divergences of truth, each resolved by an exact object naming the wrong mind (§2.2)
- `plans/FS111-derivation.md` — read against: between 5 and 20 theorems, mostly [hand] one mind; an erratum to `plans/FS107-derivation.md` concerning FS107-MEET or RR's (A) — surprised: yes; 85 entries, four times my upper bound, and the erratum to FS-107's file concerns the gloss "K-C6 vacuous" beside HX-STALL (close stage 3), not FS107-MEET
- `data/fs111/claims.md` — read against: agrees with the derivation file — surprised: yes; Q-NO is defined over every locally finite segment-and-arc map (l. 44, no complexity bound) and REG-A_k's output is "a segment-and-arc map" (l. 97): route M consumes the NO at unbounded complexity — which bears on F1
- `plans/FS111-C-close.md` (101 KB) — read against: FS-111 **closed undecided** (0.85); the erratum to FS-107 changes the route to seven from "two doors" to "two doors plus a named third statement"; successor stubs minted (two to four); its draft "Next:" names its own successor — surprised: yes; undecided as expected; three stubs minted (FS-120–FS-122); its "Next" clause defers: the successors "await Poros's rank" (l. 535)
- `plans/FS111-close-inventory.md` — read against: fewer items than FS-114's (27 KB against 89 KB) because fewer rounds ran — surprised: no; read by sample (item 38, Kooshi's ruling; the close's F1–F5); nothing bearing on the ranking left open

**The side job, and the frontier**
- `plans/BASE-V-verification.md`, the blind re-derivation of row 134's four print steps — read against: all four hold, possibly one after a local repair (0.8, hunch `the-base-print-steps-hold`) — surprised: no; Lemma 5 and Prop. 18 TRUE blind, Lemma 6's `< 9` branch TRUE under H, Lemma 3 and Cor. 3 at cusps TRUE; Lemma 4 at cusps not landed (stays one mind); the print's Prop. 18 sketch has one false sentence (l. 296; the FS-114 close §2.3 row "BASE-V's regrade")
- `plans/FRONTIER-STUBS.md`, the ranked table and closed list — read against: unchanged since FS-112's close apart from Workflow 3.0; FS-114 at 1, FS-111 at 2, FS-104 at 3, FS-115 at 4; 66 ranked rows, each FS number once — surprised: yes; unchanged as expected (FS-114 1, FS-111 2, FS-104 3, FS-115 4, 66 rows), but the file that says it "holds current state only" (l. 3) carries eighteen dated re-rank paragraphs of history under § Ranked stubs (ll. 40–76) — for Keryx
- `CLAUDE.md` § Paths forward, ranked — read against: mirrors the frontier file's top 29 rows plus the group row 30–66 — surprised: no; it mirrors the frontier file's top 29 rows and the group row
- the stubs the closes name, `plans/STUB-global-step.md`, `plans/STUB-reg-scale.md`, `plans/STUB-stuck-ray.md` and every new stub file — read against: the new stubs exist as files (the stub rule), each with a question, a bearing on the answer and a solver reading; FS-115's stub updated by FS-114's close with its fate — surprised: yes; FS-116's bearing still carries the pre-card-1 composition: "with FS-111's door (B) (as FS-111's close leaves it) it is the map route to `χ_m⁰(ℝ²) = 7`" (`plans/STUB-local-exclusion.md` § Bearing), which card 1 found needs a third statement; FS111-C's §D8 drafted that fix for the closed FS-114 stub only (finding F3); FS-115's stub carries FS-114's dated paragraph and the cross-milestone link (ll. 50–56)

**The absent (written from the frame, not found in the directory)**
- a §IQ score for each milestone (G72's count "sixteen of nineteen" updated to eighteen or nineteen of twenty-one) and a G79 line (example or counterexample invariant) in each close — read against: present in both closes — surprised: yes; both present, but each close increments G72's count from the same base: FS-114's draft reads "seventeen of twenty" (`plans/FS114-C-close.md` l. 571) and FS-111's says the coordinator "composes the two closes' increments" (`plans/FS111-C-close.md` §4.2) — filed as drafted, the count would read one short (eighteen of twenty-one) (finding F6)
- the Sirgedas prior-art debt (`[Polymath16threads]` `[16.317]`) — read against: still unfetched (Kooshi's call) or fetched by `tools/fetch_hn_google_group.py` and read — surprised: yes; the Google group was archived 2026-09-27 by `tools/fetch_hn_google_group.py`; `J_Tw1_hUxQI` read in part, about 4,300 lines unread (the FS-114 close's bibliography drafts, l. 624)
- a scored registered prediction in each close (the verdict labels) — read against: present — surprised: no; FS-114 Brier 0.134 over 16 resolved (§4.5), FS-111 0.119 over 13 (§4.5)

**The conditions of the last reading**
- the two close jobs themselves — read against: each close wrote 86–101 KB in about forty minutes (commits 16:46–17:24), at the end of a milestone run overnight and a workflow switch in the day; so each close was written from the job records' reports more than from the records, and its reconciliation will quote reports — surprised: no; each close read the reports in full and the job records at named sections (FS-114 close stage 2 preamble; FS-111 close §1.1) — a summary-first reading, as expected; the anomalies below are where its residue shows

### 1.3 The hunch ledger, carried forward (unscored until stage 2)

hunch: third-statement-needed
  claim: FS-114's NO at every complexity bound plus a cone-scale lower bound does not give `lim µ₆(ε) < 1` alone; R's (A) at unbounded
    complexity, a uniform hole bound, or a NO for the limit's boundary class is also needed
  basis: derived
  falsifier: a derivation that every family with holes → 0 and cone scale ≥ s₀ has a subsequence of bounded complexity whose limit is a
    segment-and-arc map
  registered: 2026-09-27
  status: confirmed (by: derivation — FS111-C1-GAP's location, two minds (FS111-P; FS111-V0, blind), and FS111-C1-UNIF, two minds: a third
    statement is needed; of my three candidates, "a uniform hole bound" is seven itself, not a third statement; `plans/FS111-C-close.md` §2.6 item 1)

hunch: the-unit-arc-no-is-global
  claim: no explicit radius R excludes every valid fragment about a four-colour vertex; the NO needs a plane-wide count
  basis: analogy
  falsifier: an explicit radius R with a derived exclusion of every valid fragment on the disc of radius R about a four-colour vertex
  registered: 2026-09-27
  status: killed (by: derivation — FS114-N114-COMPACT, two minds: at each complexity bound the NO is equivalent to a local exclusion at some
    radius `R(K)`, so "the NO needs a plane-wide count" is false as a claim about the NO's form; and FS114-N2-REFINE, one mind: a tile count is blind
    to Siamese pairs, so no count is the whole NO. What survives is the uniformity of `R` in `K`, re-registered below as `local-f-overshoots`)

hunch: the-base-print-steps-hold
  claim: S–V Lemma 5, Prop. 18, Lemma 6's `< 9` branch and CUSP-BASE's one-mind items hold in the curved a.e. setting with unit arcs (0.8)
  basis: prior
  falsifier: a configuration meeting a step's hypotheses where its conclusion fails
  registered: 2026-09-27
  status: confirmed (by: derivation — BASE-V, blind: S–V Lemma 5 and Prop. 18 TRUE, Lemma 6's `< 9` branch TRUE under H, Lemma 3 and Cor. 3 at
    cusps TRUE; Lemma 4 at cusps not landed, so CUSP-BASE's D5 items 1–4 and 6 stay at one mind — the confirmation covers the rest only;
    `plans/BASE-V-verification.md`)

hunch: fs115-waits
  claim: FS-114's plan will not commit to the four-colour form for maps that are not periodic, so FS-115 does not open before FS-114's phases (0.65)
  basis: derived
  falsifier: FS-114's accepted plan choosing the four-colour form for aperiodic maps
  registered: 2026-09-27
  status: confirmed (by: `plans/FS114-unit-arc-question.md` ll. 511–512, "The four-colour form is not chosen for aperiodic maps, so FS-115 does not
    open on FS-114's account")

hunch: every-valid-map-has-a-four-colour-vertex
  claim: the terminal modification of every valid six-map with unit arcs has a vertex of at least four colours, outside FS112-C-ENDS's named
    residue
  basis: derived
  falsifier: a flaw in the chain of `plans/POROS-2026-09-27-night-aim.md` § 6, or a valid map whose terminal modification has no four-colour
    vertex
  registered: 2026-09-27
  status: confirmed (by: derivation — FS114-CV-EXISTS, two minds blind to each other (FS114-CV; FS114-CVB by a shorter route), stronger than
    registered: in the map itself, the residue empty)

Two hunches registered today, before the reading:

hunch: the-closes-nominate-themselves
  claim: each close's draft "Next:" names one of its own successor stubs as the next milestone, and neither names FS-104 or the other close's
    successor (0.7)
  basis: prior
  falsifier: either close's "Next:" naming a stub it did not mint
  registered: 2026-09-28
  status: killed (by: `plans/FS114-C-close.md` l. 476, "**Next: Poros's re-rank**"; `plans/FS111-C-close.md` l. 535, successors that "await Poros's
    rank" — neither close named its own successor)

hunch: fs114-closed-undecided
  claim: FS-114 closes with neither the NO nor the YES landed, and at least one local exclusion (the Reuleaux bowtie at root 3) held at two
    minds (0.85)
  basis: read
  falsifier: `plans/FS114-C-close.md`'s verdict line reading NO or YES landed, or no local exclusion held at two minds
  registered: 2026-09-28
  status: confirmed (by: `plans/FS114-C-close.md` §2.6 and l. 162 — undecided; the Reuleaux bowtie family excluded at `√3` by two independent
    derivations)

### 1.4 The question, so far

At stage 1 the honest exit stood — *no question yet: the re-read had not been made, and a card written then would have been drawn from the
summary I arrived with; need: stage 2.* Stage 2 replaced it with the cards in §2.4. (The inventory's "surprised" fields above were filled in place at
stage 2; the expectations are as committed at stage 1, `5fca15b3`.)

## Stage 2 — SAVED

*The re-read, by `poros-anomaly-hunt`: every inventory item above read against the expectation committed at stage 1 (`5fca15b3`), its result filled in
place with its address. Read in full: both close records; FS-114's derivation entry FS114-N114-COMPACT; `data/fs114/claims.md` §3 (ll. 105–125) and l.
282; `data/fs111/claims.md` ll. 44–48 and 97–99; the "Bearing on the answer" of all five new stubs and of `plans/STUB-stuck-ray.md`; FS-114's plan ll.
505–520 and 587–600 (by grep). Read through the closes' reconciliations, not first-hand: the fourteen FS-114 job records and the nine FS-111 job records
(their "Theorems" tables and divergence tables as the closes quote them). The job records were not opened where no anomaly pointed; that is the
sampling, stated.*

### 2.1 What is curious, and what pattern would make it a matter of course

**F1 — The FS-114 headline says "exactly" where its own claim list says "iff uniform".** The close: "So **the unit-arc NO is exactly C114-LOCAL-F**:
an explicit radius `R` about a vertex of at least four colours within which no valid fragment exists" (`plans/FS114-C-close.md` §2.6 item 1); the drafted
row 137: "**With unit arcs, the six-map question is local** … its NO is exactly an explicit radius about a vertex of at least four colours within which no
such map fragment exists" (l. 417). What the derivations hold: C114-LOCAL-F with FS114-CV-EXISTS **implies** the NO for every locally finite map (two
minds on CV-EXISTS); the converse is FS114-N114-COMPACT, whose statement is "TRUE at every `K`; a radius uniform in `K` exists iff C-LOCAL holds"
(`plans/FS114-derivation.md` l. 289) — compactness at each complexity bound, and nothing across bounds. The claim list says it outright: "a NO at bounded
`K` only is Q-full_K's, not Q-full's" (`data/fs114/claims.md` l. 282). So the NO could hold with exclusion radii growing with the complexity, and then
LOCAL-F (one explicit radius) fails while no valid map exists. **The pattern:** a sufficient form promoted to an equivalence in the headline, the
scope clause kept only in the claim list — G21's "a caveat you write and then step over". **Correction owed** (§3's drafts carry it): "exactly" →
"suffices"; "the six-map question is local" → "at each complexity bound the six-map question is local (compactness), and one radius uniform in the
complexity is the whole NO". It propagates to the drafted `last`, `prog`, `i31` and G83 units, the FS-114 closed banner, and the atlas node LOCALF and its
two edges. It matters for route M: FS-111's Q-NO is the NO for every locally finite map (`data/fs111/claims.md` l. 44, no complexity bound), exactly the
form LOCAL-F gives and compactness does not.

**F2 — Route M's two halves are described in opposite tones.** FS-116 (the NO): "**Decisive at every complexity**" (`plans/STUB-local-exclusion.md` §
Bearing). FS-121 (the map step): "**Decisive at its top, and at its top the answer restated**" (`plans/STUB-map-step.md` § Bearing). The logic is symmetric
(FS111-C-SEVEN-M, C-REG-EQ, two minds each): seven ⟺ Q-NO ∧ REG-A₆; each conjunct is necessary for seven (a valid six-map is a tight colouring; REG-A₆
holds vacuously when no tight six-colouring exists); each is equivalent to seven given the other; and a failure of either gives `χ(ℝ²) ≤ 6` with no MR
(a valid map, or a tight six-colouring). "The answer restated given the NO" is what any conjunct of a two-part equivalence is, and it is as true of the NO
given REG-A₆. **The pattern:** each close described its own successor from inside its own milestone; FS111-C's discovery that the doors are two routes,
not halves, was written against FS-111's old composition, and FS114-C wrote in parallel. The re-rank below states the two as a pair. What *is*
asymmetric, and what I rank on: the NO is not vacuous under seven — it is a statement about maps a proof can reach (six rounds of local kills, named
residues) and it answers a posed question (`[SokolovVoronov2025]` Question 2's unit-arc half); REG-A₆ at six is vacuous under seven, so its proof must be
colour-generic (true at `k ≥ 7` on inhabitants such as R7, FS111-W-NEG), and its colour-generic rung is FS-120.

**F3 — FS-116's bearing carries the composition card 1 retired.** "with FS-111's door (B) (as FS-111's close leaves it) it is the map route to
`χ_m⁰(ℝ²) = 7`" (`plans/STUB-local-exclusion.md` § Bearing). FS-111's card 1, two minds: the NO plus the cone scale gives seven only through a third
statement (FS111-C1-GAP), and with FS-121's map step it gives seven (C-SEVEN-M). FS111-C's §D8 drafted this fix for `plans/STUB-global-step.md`, the
closed stub, not for FS-116, which FS114-C was minting at the same hour. **Correction owed:** in FS-116's bearing, "with FS-111's door (B) (as FS-111's
close leaves it)" → "with FS-121's map step (route M; FS111-C-SEVEN-M, two minds)". A mechanism of the parallel closes, not an error of either.

**F4 — Both milestones stopped at the same place: uniformity in the complexity bound.** FS-114: the NO is local at each `K`, and a radius uniform in `K`
is the open statement (FS114-N114-COMPACT). FS-111: the NO bounds holes at each `K` and only there (FS111-C1-PW), and seven is the bound uniform in `K`
(FS111-C1-UNIF). Neither close cites the other on it. What would make it a matter of course: every result at a fixed complexity bound is bought by
compactness, which is free (W-EQ-K), so the program's bounded-complexity rows (133–138) all sit on the cheap side of one line, and the answer lives in
uniformity across complexity. It is the same wall seen twice — the one G82 names ("a refutation is regular, and only its limit is wild"). It sharpens what
FS-116 must deliver (a radius independent of complexity, F1) and what FS-121 must (a map whose complexity is not bounded in advance).

**F5 — Every FS-114 kill is second-order.** The drafted row 138: "Every kill is a straddle: two tiles of one colour forced along two unit circles to come
within 1, seen at second order"; FS114-Y5-PXKILL's contradiction "appears only at second order (YB4-2ND)" (§2.3). A second-order contradiction is the kind
an ε-band of slack can absorb unless the configuration's own scale is bounded below (G82's pricing rule: "price each certificate at its feature's
scale, never at `ε`'s"). Nobody has asked whether FS-114's kills survive a band. If they do, uniformly in complexity, there is a third route — the NO
proved stably on FS-107's grid-square near-colourings, with no map step; if they do not, route M must pass through FS-121. That is the rank-1 card
(§2.4) and a hunch (§2.3).

**F6 — The two closes increment G72's count from the same base.** FS-114's draft: "seventeen of twenty" (`plans/FS114-C-close.md` l. 571); FS-111's:
"the coordinator composes the two closes' increments" (§4.2). Filed as FS-114 drafted it, the count is one short: both closes came "through", so it
should read **eighteen of twenty-one**. For Keryx.

**F7 — The frontier file's history.** `plans/FRONTIER-STUBS.md` l. 3 says it "holds current state only", and § Ranked stubs opens with eighteen dated
re-rank paragraphs (ll. 40–76), each a closed ranking's story. My draft adds one paragraph in the same form, because that is the file's practice; whether
they move to git is Keryx's call.

**F8 — FS-115's bearing has moved from FS-114 to FS-121, at one mind.** CV-EXISTS made the four-colour density form moot for the NO ("(b′) and (b″) bear
only on GS-4's density form … never on the NO", `plans/STUB-stuck-ray.md` l. 52). What is left is FS111-C's reading that FS-111's ¬LRA (large-radius
accumulation, one of REG-A₆'s conditions by FS111-M2-REDUCE-A, two minds) "is this stub's stuck ray in another form" (FS111-C §D8; FS-114 inventory item
78). The identification — a pencil of circles of radius `k + 1` in a valid map against saturated interfaces whose radii grow without bound — is one mind's
and unchecked. It becomes a rung of FS-121, beside FS-120.

**Which result stands without its mechanism.** FS114-CV-EXISTS has one ("in a map with none every stuck chain of the terminal modification is
bi-infinite, which N4-FIN forbids", drafted row 137). FS111-C1-UNIF has one ("the complexity bound filters all of H-EQ's grid colourings", drafted
‹R111-a›). **FS-114's local kills do not**: each is a case, and the drafted G83 reading ("what is left is four-colour vertices whose rings carry (Q)
arcs, the class every exclusion so far had to except") names the residue by the method's blind spot, not by a property of the maps. N7-HUB (one mind,
unverified) is the only example invariant offered for it; the close's own §4.1 says G79's flip "arrived only in rounds 5–6".

**What path has nobody considered.** The robust route of F5; and, dually, asking FS-121's map step for the complexity class of its output (F4): if
REG-A₆ produced maps of bounded complexity, route M would need only the NO at each `K`, which compactness already makes local, and FS-116's uniformity
would be more than route M consumes (card 2).

### 2.2 Registrations scored

Five hunches carried from NIGHT-A and two registered at stage 1, scored in place in §1.3: **confirmed** — `third-statement-needed` (derivation, two
minds), `the-base-print-steps-hold` (derivation, BASE-V blind; Lemma 4 at cusps excepted), `fs115-waits` (read), `every-valid-map-has-a-four-colour-vertex`
(derivation, two minds, stronger than registered), `fs114-closed-undecided` (read); **killed** — `the-unit-arc-no-is-global` (by FS114-N114-COMPACT and
N2-REFINE), `the-closes-nominate-themselves` (by the two closes' "Next" clauses). NIGHT-A's three cards: card 1 answered (a third statement is needed;
FS-111 round 0); card 2 answered by reframing (local at each `K`; uniformity open); card 3 answered by BASE-V. **Scored by basis, as the lane file's study
reads it:** of the five NIGHT-A hunches, the three derived ones scored 3 of 3, the one from prior 1 of 1, the one from analogy 0 of 1; my two stage-1
hunches (read, prior) 1 of 2. Nothing here changes the study's order (read above derived above prior).

### 2.3 New hunches (registered before the answer)

hunch: kills-are-not-band-stable
  claim: FS-114's straddle kills (row 138's "seen at second order") do not survive an ε-band of slack uniformly in the complexity, so FS-116's
    exclusions cannot be made stable by their own proofs, and route M to seven must pass through FS-121's map step (0.65)
  basis: analogy
  falsifier: FS114-Y4-RSTOPALL (the bowtie at `√3`) re-derived for band-proper fragments with slack `ε` and holes of density `< η`, at a radius and a
    margin independent of `ε`, `η` and the complexity
  registered: 2026-09-28
  status: open

hunch: local-f-overshoots
  claim: FS-116's one explicit radius is stronger than the NO: no held compactness gives a radius uniform in the complexity from the NO for every
    locally finite map, so C114-LOCAL-F can fail while no valid map exists (0.6)
  basis: derived
  falsifier: a derivation that valid fragments about four-colour vertices at every radius give a valid locally finite map of the plane (compactness
    across complexity bounds)
  registered: 2026-09-28
  status: open

hunch: route-m-consumes-unbounded-maps
  claim: FS-121's map step, if it lands, produces segment-and-arc maps of no bounded complexity, so route M consumes the NO for every locally finite map,
    the form only a uniform radius gives (0.7)
  basis: derived
  falsifier: a derivation that REG-A₆'s map can be taken of bounded complexity (then the NO at each `K`, local by compactness, suffices for route M)
  registered: 2026-09-28
  status: open

### 2.4 The cards

question: do-fs114-kills-survive-a-band
  evidence: drafted row 138, "Every kill is a straddle … seen at second order" (`plans/FS114-C-close.md` l. 418); FS114-Y5-PXKILL "appears only at
    second order (YB4-2ND)" (§2.3); FS111-C1-UNIF "seven iff `inf_K δ₀(K) > 0`" and C1-PW "Q-NO ⟹ `δ₀(K) > 0` for every `K`" (FS111-C §B lines);
    FS107's H-EQ: a refutation is a sequence of periodic grid-square colourings (`CLAUDE.md` § The aim, link 5); G82
  expected: that some FS-114 kill had been priced against a band — none was
  ask: Does FS114-Y4-RSTOPALL, the bowtie killed at `√3`, survive as an exclusion for band-proper fragments with slack ε and small holes, at a radius and margin independent of ε and the complexity?
  if it survives: a robust route M exists — FS-116 posed on FS-107's grid-square near-colourings (with a robust form of CV-EXISTS) is a route to seven
    with no map step; FS-116 is posed that way from its opening, and FS-121 drops below FS-104
  if it dies: the margin is second-order in a scale the band can shrink; FS-116 stays exact, route M needs FS-121 as ranked, and G82's pricing rule
    gains an instance
  answered by: derivation — a fresh mind at FS-116's opening (its §IQ), on one kill, before round 7's queue
  cost: one to two hours of one derivation
  hunch: it dies — the straddle's margin is the square of the configuration's own scale, and at unbounded complexity nothing bounds that scale below
  falsifier: RSTOPALL re-derived with slack ε and holes < η at a radius and margin independent of ε, η and complexity
  rank: 1

question: which-no-does-route-m-consume
  evidence: FS111-C-SEVEN-M "Q-NO ∧ REG-A₆ ⟹ `χ_m⁰(ℝ²) ≥ 7`"; Q-NO over every locally finite map (`data/fs111/claims.md` l. 44); REG-A_k's output "a
    segment-and-arc map" (l. 97); FS114-N114-COMPACT "a radius uniform in `K` exists iff C-LOCAL holds" (`plans/FS114-derivation.md` l. 289);
    FS111-V0-WIGGLE, notching raises complexity at no cost
  expected: route M's two halves agree on the complexity class they hand across
  ask: Can FS-121's map step, when it produces a segment-and-arc map, produce one of bounded complexity — or must route M's NO cover every locally finite map?
  if bounded: route M consumes only the NO at each `K`, local by compactness; FS-116's target is a radius `R(K)` for each `K`, and its uniformity is a
    bonus, not the route
  if unbounded: FS-116 must deliver one radius uniform in the complexity (C114-LOCAL-F as posed), and F1's correction reads "LOCAL-F suffices, and
    route M needs its uniformity"
  answered by: derivation — FS-121's opening, or FS-116's §IQ if FS-121 is not open
  cost: an hour's derivation against FS111-M2-INTRAD and V0-WIGGLE
  hunch: unbounded (hunch `route-m-consumes-unbounded-maps`)
  falsifier: a derivation that REG-A₆'s map can be taken of bounded complexity
  rank: 2

### 2.5 What this does to the ranking (for stage 3)

- **FS-116 at 1, FS-121 at 2, as route M's pair**, stated symmetrically (F2), each necessary for seven, jointly sufficient, a failure of either `χ(ℝ²) ≤ 6`
  with no MR. FS-116 first: it is not vacuous under seven, it answers a posed question, and its opening queue is ready.
- **FS-104 stays 3**: FS-121 at five carries its question in cover form (FS111-VM2-EQ5), and FS-104 keeps its other routes.
- **FS-122 at 4**: A-ALL is equivalent to seven outright (FS111-W-NEG), an independent route whose smaller statements (B-RR, a robust count) bear only
  through it.
- **FS-120 at 5, FS-115 at 6**: rungs of FS-121 — the pinch at a junction (colour-generic, FS111-M4-MOVE, one mind), and ¬LRA if F8's reading holds.
- **FS-117 at 7**: partial by theorem (G86), the non-Siamese NO; it aims FS-116.
- Every old rank from FS-109 (5) down moves three places (8–69); FS-114 and FS-111 go to the closed list.

### "Would have searched here" log

- Stage 1: none.
- Stage 2: none — reading only; the anomalies were checked against the records by `grep` and `sed`, never by a search for an object.

### Theorems this phase proved

None: this job is a re-read and a re-rank. It proves nothing.
