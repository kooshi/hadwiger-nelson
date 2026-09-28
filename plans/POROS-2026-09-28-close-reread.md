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
- `plans/FS114-unit-arc-question.md`, the plan (§G, §PA, §IQ, the chosen form) — read against: the plan attacks DENSE3's form ("every valid map", the NO itself), does not commit to the four-colour form for maps that are not periodic, and leaves FS-115 unopened (0.65, hunch `fs115-waits`); its §IQ structural form names an invariant or says none is known; card 2 (local or global) is answered "global" or left open, not "local" — surprised: unread
- `plans/FS114-N-proof.md` … `plans/FS114-N7-proof.md` and `data/fs114/reports/FS114-N*.md`, seven proof rounds (N, N2–N7) — read against: each round excludes a local configuration about a four-colour or repeated-colour vertex at radius ≤ 3 (the bowtie at "root 3" among them), none closes the NO, and the last round's stall is a named step; at least one round attempts a plane-wide count (Euler/discharging) — surprised: unread
- `plans/FS114-NB-verification.md`, `-NB4`, `-NB5`, `-NB6`, the proof side's blind verifiers — read against: four verifications for seven proof rounds, so three rounds (N2, N3, N7) stand at one mind; each verdict TRUE or TRUE-after-repair, none FALSE — surprised: unread
- `plans/FS114-Y-construction.md` … `-Y6`, six construction rounds — read against: no YES; each construction dies at a missing second four-colour vertex or at a pinned corner (G83's reading), and the Reuleaux bowtie family is the round-3/4 object, closed at root 3 — surprised: unread
- `plans/FS114-YB-verification.md`, `-YB2` … `-YB5`, the construction side's blind verifiers — read against: each confirms its round's refutation or finds a counting slip; none turns a refutation into a YES — surprised: unread
- `plans/FS114-L60-audit.md` — read against: an audit that the reduction (row 135's) holds at the 60° boundary, TRUE, one mind — surprised: unread
- `plans/FS114-CV-verification.md`, `plans/FS114-CVB-verification.md`, the composition checks — read against: the composition of the round results into a statement about every map checked at two minds, one blind, and found to hold with a scope restriction — surprised: unread
- `plans/FS114-derivation.md` — read against: between 10 and 40 theorems filed, most [hand] at one or two minds; none closes the NO or the YES — surprised: unread
- `data/fs114/claims.md`, the frozen claim list — read against: every theorem in the derivation file appears once, with its grade — surprised: unread
- `plans/FS114-C-close.md`, the close record (reconciliation, headline, sweeps, `## Drafts for the front page`) — read against: FS-114 **closed undecided** (0.85): NO not landed, YES not landed; one or two ledger rows (137–138) drafted; between two and four successor stubs minted; its draft "Next:" names one of its own successors — surprised: unread
- `plans/FS114-close-inventory.md` (89 KB) — read against: Kooshi's question on "the collapse" and a mass-transport lead logged; items on staffing and the workflow switch; no decision left open that bears on the ranking — surprised: unread

**FS-111, the cone scale**
- `plans/FS111-cone-scale.md`, the plan — read against: card 1 (does the route to seven close with two doors) answered at §IQ, by derivation, **"a third statement is needed"** (0.6, hunch `third-statement-needed`); the prior-art gate names regularity of near-minimisers (De Giorgi, Almgren, Taylor) and distance-avoiding compactness (Bukh, Falconer–Marstrand, Furstenberg–Katznelson–Weiss) — surprised: unread
- `plans/FS111-M-regularity.md`, `-M2`, `-M3` (finiteness), `-M4` (cascade), four derivation rounds — read against: partial regularity results for near-optimal band-proper six-colourings (a density or perimeter bound at one or two minds), no cone-scale lower bound proved, and no refuting family — surprised: unread
- `plans/FS111-W-wild.md`, the wild side — read against: a construction side looking for a family with holes → 0 and cone scale → 0; none found; one or more no-gos on how such a family could look — surprised: unread
- `plans/FS111-V0-verification.md`, `-VM2`, `-VMW` — read against: V0 checks the plan's §IQ derivation (card 1), VM2 checks M2, VMW checks M and W; each TRUE or TRUE-after-repair, with M2-INTRAD's scope narrowed — surprised: unread
- `plans/FS111-derivation.md` — read against: between 5 and 20 theorems, mostly [hand] one mind; an erratum to `plans/FS107-derivation.md` concerning FS107-MEET or RR's (A) — surprised: unread
- `data/fs111/claims.md` — read against: agrees with the derivation file — surprised: unread
- `plans/FS111-C-close.md` (101 KB) — read against: FS-111 **closed undecided** (0.85); the erratum to FS-107 changes the route to seven from "two doors" to "two doors plus a named third statement"; successor stubs minted (two to four); its draft "Next:" names its own successor — surprised: unread
- `plans/FS111-close-inventory.md` — read against: fewer items than FS-114's (27 KB against 89 KB) because fewer rounds ran — surprised: unread

**The side job, and the frontier**
- `plans/BASE-V-verification.md`, the blind re-derivation of row 134's four print steps — read against: all four hold, possibly one after a local repair (0.8, hunch `the-base-print-steps-hold`) — surprised: unread
- `plans/FRONTIER-STUBS.md`, the ranked table and closed list — read against: unchanged since FS-112's close apart from Workflow 3.0; FS-114 at 1, FS-111 at 2, FS-104 at 3, FS-115 at 4; 66 ranked rows, each FS number once — surprised: unread
- `CLAUDE.md` § Paths forward, ranked — read against: mirrors the frontier file's top 29 rows plus the group row 30–66 — surprised: unread
- the stubs the closes name, `plans/STUB-global-step.md`, `plans/STUB-reg-scale.md`, `plans/STUB-stuck-ray.md` and every new stub file — read against: the new stubs exist as files (the stub rule), each with a question, a bearing on the answer and a solver reading; FS-115's stub updated by FS-114's close with its fate — surprised: unread

**The absent (written from the frame, not found in the directory)**
- a §IQ score for each milestone (G72's count "sixteen of nineteen" updated to eighteen or nineteen of twenty-one) and a G79 line (example or counterexample invariant) in each close — read against: present in both closes — surprised: unread
- the Sirgedas prior-art debt (`[Polymath16threads]` `[16.317]`) — read against: still unfetched (Kooshi's call) or fetched by `tools/fetch_hn_google_group.py` and read — surprised: unread
- a scored registered prediction in each close (the verdict labels) — read against: present — surprised: unread

**The conditions of the last reading**
- the two close jobs themselves — read against: each close wrote 86–101 KB in about forty minutes (commits 16:46–17:24), at the end of a milestone run overnight and a workflow switch in the day; so each close was written from the job records' reports more than from the records, and its reconciliation will quote reports — surprised: unread

### 1.3 The hunch ledger, carried forward (unscored until stage 2)

hunch: third-statement-needed
  claim: FS-114's NO at every complexity bound plus a cone-scale lower bound does not give `lim µ₆(ε) < 1` alone; R's (A) at unbounded
    complexity, a uniform hole bound, or a NO for the limit's boundary class is also needed
  basis: derived
  falsifier: a derivation that every family with holes → 0 and cone scale ≥ s₀ has a subsequence of bounded complexity whose limit is a
    segment-and-arc map
  registered: 2026-09-27
  status: open

hunch: the-unit-arc-no-is-global
  claim: no explicit radius R excludes every valid fragment about a four-colour vertex; the NO needs a plane-wide count
  basis: analogy
  falsifier: an explicit radius R with a derived exclusion of every valid fragment on the disc of radius R about a four-colour vertex
  registered: 2026-09-27
  status: open

hunch: the-base-print-steps-hold
  claim: S–V Lemma 5, Prop. 18, Lemma 6's `< 9` branch and CUSP-BASE's one-mind items hold in the curved a.e. setting with unit arcs (0.8)
  basis: prior
  falsifier: a configuration meeting a step's hypotheses where its conclusion fails
  registered: 2026-09-27
  status: open

hunch: fs115-waits
  claim: FS-114's plan will not commit to the four-colour form for maps that are not periodic, so FS-115 does not open before FS-114's phases (0.65)
  basis: derived
  falsifier: FS-114's accepted plan choosing the four-colour form for aperiodic maps
  registered: 2026-09-27
  status: open

hunch: every-valid-map-has-a-four-colour-vertex
  claim: the terminal modification of every valid six-map with unit arcs has a vertex of at least four colours, outside FS112-C-ENDS's named
    residue
  basis: derived
  falsifier: a flaw in the chain of `plans/POROS-2026-09-27-night-aim.md` § 6, or a valid map whose terminal modification has no four-colour
    vertex
  registered: 2026-09-27
  status: open

Two hunches registered today, before the reading:

hunch: the-closes-nominate-themselves
  claim: each close's draft "Next:" names one of its own successor stubs as the next milestone, and neither names FS-104 or the other close's
    successor (0.7)
  basis: prior
  falsifier: either close's "Next:" naming a stub it did not mint
  registered: 2026-09-28
  status: open

hunch: fs114-closed-undecided
  claim: FS-114 closes with neither the NO nor the YES landed, and at least one local exclusion (the Reuleaux bowtie at root 3) held at two
    minds (0.85)
  basis: read
  falsifier: `plans/FS114-C-close.md`'s verdict line reading NO or YES landed, or no local exclusion held at two minds
  registered: 2026-09-28
  status: open

### 1.4 The question, so far

no question: the re-read has not been made; every item above is unread, and a card written now would be drawn from the summary I arrived with
  need: stage 2 — read each inventory item against its expectation above, the middle of each close record on purpose, and score the ledger

### "Would have searched here" log

- (none this stage)

### Theorems this phase proved

None: this job is a re-read and a re-rank. It proves nothing.
