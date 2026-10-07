# FS132-E2 — card 3 of FS-132: must a cyclic centre that is not a triangle exist in every measurable six-colouring?

*Ephodos, 2026-10-07 (UTC). Brief: `data/fs132/briefs/FS132-E2-card-three.md`. Plan of the milestone (its §G, §PA, §IQ, read, not
redone): `plans/FS132-six-by-the-nerve.md`. The extraction this job is asked on: `plans/FS132-E1-derivation.md` Stage 3
(C132-EXT-DISC, C132-CORES-FREE, C132-CONFINE; [hand], one mind, kernel pending). Scripts and outputs: `data/fs132/e2/`. `M` is the
release's manuscript, `/home/kooshi/source/math/preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/build/sections/`
(read, never written).*

## Theorems this phase proved

*(Filled at each saved stage; see the stage that holds each entry.)*

## Stage 1 — SAVED: the readback, and what I expect before deriving

**The job, in my words.** The outside proof finds, in every weak measurable colouring with finitely many cyclic centres on a
disc, a centre with a label cycle and continua (C132-EXT-DISC, at every number of colours). At five every cycle length is
contradictory; at seven the honeycomb lives on triangles. The card asks whether, at six, a centre whose cycle is longer than a
triangle is forced, and proposes one frame: enlarge the target of the smoothed colouring from the complete graph on the labels to
the complex with triangles filled, and ask which centres stay essential. I am to state the claims (the target and the map; which
centres stay essential; the forcing statement), derive or stall each, and for every forcing statement say where seven escapes
and why five is consistent. The frame is the asking lane's proposal and not owed.

**Quotation check** (standing rule 3). `data/fs132/e2/readback.py` looks for every quoted line of the brief in the file its
source line names: `quotations=15 lines_matched=15 lines_mismatched=0` (`data/fs132/e2/readback.out`); with one character of each
line changed it reports fifteen mismatches. No finding about the brief.

**Read for this stage, each whole unless said:** the brief and `plans/STANDING-RULES.md`; the stub
`plans/STUB-six-by-the-nerve.md`; the plan `plans/FS132-six-by-the-nerve.md`; `plans/FS132-E1-derivation.md`;
`plans/POROS-2026-10-07-after-release.md` § 1.4; `plans/EXT-OAI2-reading.md` §§ 3.1–3.6, 4.1–4.4, 5.6; `plans/STUB-forced-pair.md`;
`plans/EXT-OAI3-review.md` § 3.2; `LEDGER.md` rows 132, 134, 137, 139 (132 and 139 as the brief quotes them); the claim list
`data/fs132/claims.md`; of the release, `M/introduction.tex:75–135`, `M/transitions.tex:1–75` (Definition 6.1, Lemma 6.2's
statement), `M/interfaces.tex:1–440` (Proposition 7.1, Lemmas 7.2–7.6 with proofs), `M/angular.tex:1–125` (Lemma 8.1 with proof,
Proposition 8.2's opening). **Not read:** `[Voronov2023]`'s PDF (its Theorems 1.1–1.3 are taken from this project's verification
record, `plans/FS106-V-verification.md` rows V-1.1, V-1.2, V-1.3, read at those three rows); `M/interfaces.tex:440–670` (Lemmas
7.7, 7.8 and the proof of Proposition 7.1 — taken from the first deriver's steps S8–S11); family 156's manuscript (the reviewer's
note only); the release's Lean.

**Registered before deriving** (after the reading above — said because a prediction made after reading is worth less; each is
scored at the report):
- **Q1.** The card's first branch as worded — "the essential centres are the cycles of length four to six and a metric cover
  statement forces one" — holds as worded: **0.10**. With triangles filled in the target no centre of any cycle length stays
  essential: **0.75**. *Decides:* whether the route runs through the filled target or stays on the graph-valued map.
- **Q2.** The forcing statement — a centre with a label cycle of length at least four in every weak measurable six-colouring
  with finitely many centres on a disc of some radius — is `derived` in this job: **0.03**; `stalls at` a named step: **0.95**;
  `refuted` by an object: **0.02**. *Decides:* what the report hands on (a theorem, a stall with the YES side's sketch, or an
  object). The asking lane's 0.35 was for its route landing, a different event.
- **Q3.** The place where six differs from seven is located at one named step, with seven's escape said in words and five's
  consistency checked: **0.80**. *Decides:* whether the stall, if it comes, is a result or only a stop.
- **Q4.** Recognition's homes are all killed and `ephodos-invention` is needed: **0.25**. *Decides:* whether Stage 2 is
  followed by an invention stage.
