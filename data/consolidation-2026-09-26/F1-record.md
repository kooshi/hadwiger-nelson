# F1 — audit of `CLAUDE.md`'s git history for text compressed out (record)

*Job F1 of the 2026-09-26 documentation consolidation. Opus 5.5, as Coxeter (archivist). Brief:
`data/consolidation-2026-09-26/briefs/F1-history-audit.md` (+ `STANDING-RULES.md`). HEAD at launch: `d03df9a8` (E2's report).
Working files (read-only helpers and per-commit candidate lists): `data/consolidation-2026-09-26/f1/`.*

**Gates at launch** (exit statuses read directly): `claude_md_fact_audit.py --base d03df9a8` PASS; `--dupes` = 10 repeated runs;
`fs71_ledger_b_check.py --strict` PASS; `bib_audit.py` PASS; `check_architecture.py` PASS. `CLAUDE.md` 283,274 bytes;
`plans/GROKKING-INSTANCES.md` 9,599 bytes.

**Standard** (E1's brief, E2's report): *intrinsic* = a rule's statement, its reasoning (the *why*), a condition, a *Do* line, a killing
test, a demotion record, an entry's only example; *incidental* = a second or later instance, an incident story behind a rule already
stated. **My working classification of a removal:** *current-state* = a superseded claim replaced by its correction, a correction trail,
milestone narrative or history (dates, run times of a superseded attempt, search query words) — the header sends these to git, so they
are left; *compression* = text whose content was still current, cut or shortened to fit the byte budget — judged intrinsic or incidental.

## Method

`f1/lost.py <commit>` joins the hard-wrapped lines of `<commit>^:CLAUDE.md` into blocks, splits them into sentences, and for every sentence
the commit removed (under 60 % of its 5-word shingles left in `<commit>:CLAUDE.md`) prints how much survives today in (a) `CLAUDE.md`,
(b) + `LEDGER.md` + `plans/GROKKING-INSTANCES.md`, (c) + every `plans/*.md` and `data/**/*.md`. Candidates are the sentences with (a) < 0.5;
each is then read in place and judged by hand. `f1/removed_words.tsv` counts, for every commit touching `CLAUDE.md`, the words it
removed (multiset difference) and added. The detector is a finder, not a verdict: a sentence re-worded in full reads as "lost" (it is then
checked by hand), and a sentence whose words all survive elsewhere in the file reads as "kept" even if its sense went (the risk is
accepted: a cut sentence whose every 5-word run survives verbatim somewhere is rare).

## Stage 1 — SAVED

**The compression commits** — every commit that the history shows cutting text to a byte budget (the header's four raises, the commit
messages' own words, and a removed-words count), with `CLAUDE.md`'s bytes before → after and the words it removed:

| commit | date | bytes | words removed / added | why (from its message) |
|---|---|---|---|---|
| `c5e55f12` | 09-10 | 564,620 → 83,841 | 76,001 / 1,670 | "current state only" — the narrative cut (full narrative last at `fd658af`); audited once already by `724d4411`, `3b813df1` (09-12) and `6852a2ae` (09-15, the checkpointing rule) |
| `00923679` | 09-13 | 152,371 → 149,397 | 673 / 193 | the wall-breaking pass, under the 150,000 ceiling |
| `34464cba` | 09-13 | 149,388 → 149,695 | 2,071 / 2,044 | FS-38 close: "to stay under the ceiling, superseded narration came out of rows 64–65, G52, G31, G21, G53, G51's extension and the longest gate-failure paragraphs — every rule and every instance kept" |
| `fc2775f2` | 09-13 | 149,695 → 149,899 | 893 / 936 | "to hold the 150,000-byte ceiling … the September-12 gate narratives are compressed to their rules and G7, G21, G31, G46, G49, G51–G54 and rows 64–65 tightened" |
| `ce22f675` | 09-14 | 149,899 → 148,998 | 364 / 241 | the paths-forward mirror's low ranks collapsed (the "2026-09-14 trims") |
| `2f53a4ca` | 09-14 | 148,998 → 149,519 | 93 / 184 | FS-50 minted at the ceiling |
| `267b42f0`, `ece3905e`, `3779cb50`, `cf647b23` | 09-16/17 | 187,151 → 199,785 | 701 / 2,587 | closes at the 200,000 ceiling ("superseded Q(√167) detail trimmed from row 71") |
| `3bfdc209` | 09-21 | 239,632 → 249,994 | 153 / 1,716 | FS-66 close at 249,994 of 250,000 |
| `d0df4f82` | 09-21 | 246,496 → 242,682 | 768 / 109 | "trim ahead of FS-66's close … Narrative and correction trails out … no method rule's reasoning touched" |
| `f7f1433e`, `d6901249`, `f74ade25`, `d87fa955`, `10802f79`, `b441fb56` | 09-21 | 242,682 → 239,632 | 1,061 / 642 | the no-loss compression pass (A, W, B, C), fact-audited; measured floor ≈ 228k |
| `1f43ba40` | 09-22 | 272,577 → 272,208 | 87 / 11 | G56's two retellings of row 69 → pointers |
| `b1fc5bbc` | 09-22 | 272,208 → 211,073 | 8,852 / 41 | rows 1–75 extracted verbatim to `LEDGER.md` |
| `18ce5980`, `9ac6a758`, `df202277`, `de8bb61c`, `3dcb8de8`, `2ac6a338` | 09-24/25 | 247,561 → 274,896 | 3,147 / 6,720 | closes at the 275,000 ceiling; `de8bb61c` "compressed to budget … Compression without loss" |
| `0f4cf93a`, `15f5f37e` | 09-25 | 275,608 → 294,994 | 483 / 3,444 | J24 / J44 rewrites during the crunch (temporary 325k) |
| `179c6c5b` … `17a8602e` (J05 batches 1–7) | 09-25 | 296,413 → 283,826 | 2,334 / 332 | J05's no-loss compression pass (`data/crunch-2026-09-25/j05-record.md`) |
| `28caf446`, `dcf26687`, `f24b4f4e` (E1) | 09-26 | 299,491 → 281,823 | 2,715 / 66 | design (b): incidentals out to `plans/GROKKING-INSTANCES.md`; verified passage by passage by E2 — not re-audited here beyond the owner's two items |

Out of scope, with the reason: `93f3d2eb` (09-02, "scrub the low-level fault vocabulary … the record does not need its forensics") — a
deliberate removal of incident forensics before any budget existed; the G67 pass (09-22, seven batches) — additive (0–44 words removed a
batch); every other commit — under 60 removed words, or a close that rewrote its own rows to current state.

## Stage 2 — SAVED

**The audit, commit by commit.** Candidate lists: `f1/cand/<commit>.txt` (every removed sentence with its survival scores; `f1/filt.py`
shows the ones in grokkings and method sections). Verdict columns: *kind* = compression (C) or current-state rewrite (S); *grade* =
intrinsic (I) or incidental (i); *action* = restored to `CLAUDE.md` (→CM), restored to `plans/GROKKING-INSTANCES.md` (→GI), or left
(already elsewhere, or current-state). Ids R… and I… are the restorations of stage 3.

| commit | removed passage (first words) | kind | grade | action |
|---|---|---|---|---|
| `c5e55f12` | G30 "Measurement generates; induction kills. The failure is never the measuring …"; "Sorted by provenance, the record is close to a clean dichotomy … Roughly 7-for-7 against 0-for-10"; "The rule this yields is NOT "measure less" …"; Kooshi's "catch-22" | C | I (the rule's evidence and its condition, Kooshi's words) | →CM R-G30a (the two claim lists →GI) |
| `c5e55f12` | G30 "Falsifier: none needed; like G21 … the tally is falsifiable and should be re-sorted at every tenth milestone" | C | I (killing test; G30 has none today) | →CM R-G30a |
| `c5e55f12` | G30 "prefer measurements that turn a DIAL (… informative in both directions …) over searches that hunt for a POSITIVE (whose null result is uninterpretable …); … so a zero reading bounds the instrument …" | C | I (the why of "prefer dials … calibrated beds") | →CM R-G30b |
| `c5e55f12` | G30 mode 1 "write the escape clause to the same standard … protects it from hindsight bias but not from being false" | C | I (why) | →CM R-G30c; the P6 story →GI |
| `c5e55f12` | G30 mode 2 "… "no seam-field object forces five" does not imply "no seam-field halo replaces a defect"" | C | I (only example) | →CM R-G30d; the P4b/P7 story →GI |
| `c5e55f12` | G30 mode 3 "… converts one bug into two"; the "cost budget" defer message | C | I (why + only example) | →CM R-G30e; the rest →GI |
| `c5e55f12` | G30 mode 4 ""derived, therefore ours" is exactly the inference this grokking forbids …"; "… where it can still change the work" | C | I (why) | →CM R-G30f; story →GI |
| `c5e55f12` | G30 mode 6 "Every one of these readings is TRUE … the instrument answered and the question closed" | C | I (why) | →CM R-G30g; the thirteen-item list →GI |
| `c5e55f12` | G30 ladder "The pattern: the project hits a wall in discipline N … the walls ARE the theorems …" | C | I (why of the ladder rule) | →CM R-G30h |
| `c5e55f12` | G30 positive form "Rule: before spending days of compute on a conjecture, write it for an outside reader …" + its instance | C | I (a rule found nowhere today, with its only example) | →CM R-G30i |
| `c5e55f12` | G30 fifth-mode story (ValuationLaw, the defence written and not run, vacuity.sh by machine) | C | i | →GI |
| `c5e55f12` | G21 "… because a conservative test converts a *finding* into a *measurement of my own instrument*, silently …"; "… to say what a refusal therefore cannot mean"; "scope lines inside an artifact do not survive into summaries unless they are in the headline"; "Falsifier: none needed …" | C | I (why, condition, why, killing test) | →CM R-G21a |
| `c5e55f12` | G21 instances: M35→M36; M45 (the seven virtual edges); M50 cast census; 2026-09-09 probes ×3; FS-28 controls ×2; M51 speedup | C | i | →GI |
| `c5e55f12` | G46 corollary's last clause "read a search's failure as information about the search's genre, not about the objects"; "Falsifier for the rule: …" | C | I | →CM R-G46a; M58/M59 origin story →GI |
| `c5e55f12` | G49 "(a) The check ran at the close, where it can only assign credit. Run at the opening it changes what the milestone is *for*"; "the gap was real, and it was a gap between literatures, not in them"; "Falsifier: three milestones running whose gate changes nothing …" | C | I (whys, killing test; G49 has a *Do* but no killing test) | →CM R-G49a; M58–M61 recognitions, FS-18 and FS-23 measurements →GI |
| `c5e55f12` | G50 "the more expensive misses were not unsearched — they were unread …"; "search → record → rank → forget … it is a debt …"; "the cost of the scan is not the reason it keeps being skipped …" | C | I (the rule's whys) | →CM R-G50a; the six held-paper instances →GI |
| `c5e55f12` | G51 "One attempt failing is a fact about the attempt."; "Falsifier: a second run of this shape in which the competitor and the advisor produce nothing …" | C | I (why; the core claim's killing test — today's tests the cost window only) | →CM R-G51a; the first run's evidence list →GI |
| `c5e55f12` | § The gate: refutation skip's why, `STALE`'s and `GENERIC`'s whys, the load-bearing control's why | C | I (whys) | →CM R-gate; the gate's origin and first-run stories →GI |
| `c5e55f12` | § Searching: "(Naming a hidden directory explicitly works; it is recursive discovery from `.` that skips it.)"; "`Nat.testBit_two_pow_sub_one` was reported missing here on exactly that error." | C | I (condition; only example) | →CM R-search; the measured blind spots and the other absence claims →GI |
| `c5e55f12` | § kernel's cost model "This model predicted core's … LRAT checker cost to within 20% … which is why to trust it." | C | I (why) | →CM R-kernel |
| `c5e55f12` | every Frontier, ledger-row, paths-forward and math-grokking narrative (≈ 500 k bytes); the math grokkings' old falsifiers | S | — | left: history, and every entry's killing test was re-authored by the G67 pass (2026-09-22); the math claims were already audited against `b54942aa` by `724d4411` and `3b813df1` |
| `fc2775f2`, `34464cba` | G51 "… because the cost of being wrong has become the cost of having *been* wrong" | C | I (why of escalation) | →CM R2 |
| `fc2775f2`, `34464cba` | filter "more material only adds to the set of colour differences and the certificate needs a value outside it" | C | I (why) | →CM R3 |
| `fc2775f2` | "Reasoning finds the controls you thought about; planting finds the ones you did not." | C | I (why of "plant faults routinely") | →CM R4 |
| `34464cba` | standard of evidence "a different *kind* of artifact, because twenty half-instance refutations are individually within reach of proof logging …"; "not at the write-up, or you will pay for evidence nothing rests on" | C | I (whys) | →CM R5, R6 |
| `34464cba` | "… because a ruling that survives its bad evidence needs new grounds, not a quiet pass" | C | I (why) | →CM R7 |
| `34464cba` | "A prediction whose target region the apparatus cannot enter is not a prediction, it is a formality that will read as a finding when it fails." | C | I (why of "both outcomes reachable") | →CM R8 |
| `34464cba` | "… it is an unexplained failure that happens to agree with you" | C | I (why) | →CM R9 |
| `34464cba` | "… because that third state is where this file's oldest failure mode hides" | C | I (why) | →CM R10 |
| `34464cba` | "a confession can flatter, because *"I filed it under the wrong heading"* is tidier and more forgivable than what actually happened" | C | I (why) | →CM R11 |
| `34464cba` | "… and treat a same-size edit inside one second as the case your caching cannot see" | C | I (condition) | →CM R12 |
| `34464cba` | G52 "… and the shared centre pins the colour twist that might have repaired it (measured: **0 of 24** twists at either prime)" | C | I (a step of the mechanism) | →CM R13 |
| `fc2775f2`, `34464cba` | G46/G51/§ standard-of-evidence "declined the credit" sentences; § Two machines "Corrected 2026-09-12 … 32 cores" and the struck figures; "The replay also showed the adaptive policy …"; "Third instance in one milestone of a decisive zero …" | C | i | →GI |
| `fc2775f2`, `34464cba` | G7, G21, G31, G49, G53 and the rest of the gate-failure paragraphs (each kept in shorter words: checked sentence by sentence) | C | — | left: content intact |
| `fc2775f2`, `34464cba`, `00923679`, `ce22f675`, `2f53a4ca` | Frontier, ledger rows 64–67, paths forward; G31/G43/G47/G48 claims FS-38 superseded | S | — | left |
| `e803cf95`, `c9fee3f0`, `5802168f` | struck figures, a withdrawn self-diagnosis, the "inverted monotonicity" | S | — | left (corrections) |
| `267b42f0`, `ece3905e`, `3779cb50`, `cf647b23`, `bc6e7c69`, `3fb7b69f`, `097eb9c8`, `85113d7b`, `4936e9f7`, `c47faa57` | G56/G59/G60/G61/G64 claims later corrected or superseded; row 71's Q(√167) detail | S | — | left |
| `d0df4f82` | G58 "A decider is being asked to refute, which is the expensive direction and the wrong one for an existence claim." | C | I (why of "a FINDER, never a decider") | →CM R1 |
| `d0df4f82` | G58 "A test whose informative outcome was never shown to be reachable …"; G64 "A fresh instance of this file's own rule …" | C | i | →GI |
| `d0df4f82` | G56's correction record, G58's search words, G59's two-route narrative, row 68 and G64 tightened | S / C | — | left: correction trails (S), or content intact (C; row 68's rounding rule is in `LEDGER.md` row 68 in full) |
| `f7f1433e`, `d6901249`, `f74ade25`, `d87fa955`, `10802f79`, `b441fb56`, `1f43ba40` | Frontier items re-pointed at their rows and grokkings; the grade legend hoisted to § Notation | C | — | left: fact-audited moves, nothing lost |
| `b1fc5bbc` | rows 1–75 | C | — | left: verbatim in `LEDGER.md` (every removed sentence ≥ 0.8 there but four rows since rewritten to current state) |
| `18ce5980`, `9ac6a758`, `df202277`, `3dcb8de8`, `2ac6a338` | G54's and G61's *Do* lines, G76, G50's FS-86 instance | S / C | — | left: rewritten to current state at each close, or kept in shorter words |
| `de8bb61c` | G51's run records (FS-73, FS-79, FS-81, FS-85) and covert channels | C | i | left: in `plans/PROTOCOL-competitor-and-advisor.md` §3, as today's G51 says |
| `0f4cf93a` | G63 "The paper had been in our bibliography, its row naming the theorem, for two weeks (G50)." | C | i | →GI (§G50) |
| `0f4cf93a`, `15f5f37e` | G63's Remark-1 gap and Q-const rewritten after M2 | S | — | left |
| J05 batches 1–7 | Frontier and paths-forward rows turned to pointers; G72's counts | C | — | left: J05's fact-audited moves; G72's counts in `GROKKING-INSTANCES.md` (E1) |
| E1 `28caf446`, `dcf26687`, `f24b4f4e` | design (b) | C | — | verified passage by passage by E2; owner items 1–2 in stage 3 |

**Counts.** Compression commits audited: 38 (table of stage 1). Intrinsic restorations: 13 from the 09-13 squeeze, 1 from the 09-21
trim, 21 from the 09-10 narrative cut's method grokkings and sections — 35 passages to `CLAUDE.md`. Incidental passages lost and bound
for `GROKKING-INSTANCES.md`: 11 groups. Current-state rewrites and incidentals already in plans or records: every other flagged sentence
(≈ 2,600 of the detector's candidates, most of them the narrative cut's history).

**Would have searched here:** none — no finite-witness search is needed for a history audit.

## Stage 3 — restorations (in batches)

### Batch 1 — the 09-13 squeeze and the 09-21 trim → `CLAUDE.md` (R1–R13)

Each is the removed words verbatim from the named parent revision, inserted where the surviving sentence stands today; the only
edits are joining punctuation ("—", ";", "."), the line-wrap hyphen "whole- object" → "whole-object" (R5), and R3's parenthesis moved
from before "; it is **false**" to before today's "— adding material" (its sentence was reshaped at `fc2775f2`).

| id | where today | restored words | source |
|---|---|---|---|
| R1 | G58, after "never a decider on the full plane." | "A decider is being asked to refute, which is the expensive direction and the wrong one for an existence claim." | `d0df4f82^` |
| R2 | G51, "the same speed produces escalation" | ", because the cost of being wrong has become the cost of having *been* wrong" | `34464cba` (cut at `fc2775f2`) |
| R3 | "Do not mistake a one-sided filter …" | "(more material adds colour differences, and the certificate needs a value outside them)" | `34464cba` (cut at `fc2775f2`) |
| R4 | "… scars, not foresight" | "Reasoning finds the controls you thought about; planting finds the ones you did not." | `34464cba` (cut at `fc2775f2`) |
| R5 | § standard of evidence, the reviewer bundle | "— a different *kind* of artifact, because twenty half-instance refutations are individually within reach of proof logging where one whole-object refutation was not" | `34464cba^` |
| R6 | same | ", not at the write-up, or you will pay for evidence nothing rests on" | `34464cba^` |
| R7 | "carry what it MEASURES" | ", because a ruling that survives its bad evidence needs new grounds, not a quiet pass" | `34464cba^` |
| R8 | "Confirm that BOTH outcomes are reachable" | "A prediction whose target region the apparatus cannot enter is not a prediction, it is a formality that will read as a finding when it fails." | `34464cba^` |
| R9 | "a control going RED is not evidence either" | "— it is an unexplained failure that happens to agree with you." (old: "Where the uninformative outcome cannot be named, **a red control is not yet evidence** — it is an unexplained failure that happens to agree with you.") | `34464cba^` |
| R10 | "Bound a plant's effect on BOTH sides" | ", because that third state is where this file's oldest failure mode hides" | `34464cba^` |
| R11 | "A TRUE explanation …" | "— a confession can flatter, because *"I filed it under the wrong heading"* is tidier and more forgivable than what actually happened" | `34464cba^` |
| R12 | "… verify its own RESTORE" | ", and treat a same-size edit inside one second as the case your caching cannot see" | `34464cba^` |
| R13 | G52, the free circle | ", and the shared centre pins the colour twist that might have repaired it (measured: **0 of 24** twists at either prime)" | `34464cba^` |

Gates after batch 1: audit PASS, dupes 10, ledger-B PASS, bib PASS, architecture PASS; `CLAUDE.md` 284,566 bytes.

### Batch 2 — the narrative cut's method grokkings → `CLAUDE.md` (R-G21a, R-G30a–i, R-G46a, R-G49a, R-G50a, R-G51a)

Verbatim from `c5e55f12^` except where noted (old words quoted):

| id | entry | restored | rewording, with the old words |
|---|---|---|---|
| R-G30a | G30 | "Sorted by provenance, the record is close to a clean dichotomy: **derived from structure first, then measured — survived, every one**; **measured first, then interpreted — died, every one** … now 8-for-8 against the measurement-first column's 0-for-10. The rule this yields is NOT "measure less" — …"; Kooshi's "catch-22"; the falsifier (tally re-sorted every tenth milestone) | the two claim lists → GI §G30 with a pointer "(the two lists: …)"; "now 8-for-8 …" is the later instance's own words ("the derivation-first column wins again, now 8-for-8 against the measurement-first column's 0-for-10"); Kooshi's quote was "stated in this form on Kooshi's correction, which is the load-bearing half: *"…"*" |
| R-G30b | G30 | the DIAL / CALIBRATED sentence, replacing today's "Prefer dials to searches for a positive, and calibrated beds whose answer is known." | dropped: "and has now come back flat four times" (a 2026-09-10 count) and "(`plans/M45-arity-floor.md` is that pattern made into a milestone)" — both in GI §G30 |
| R-G30c | mode 1 | "Write the escape clause to the same standard as the prediction: a pre-registered interpretation is still an interpretation, and being committed in advance protects it from hindsight bias but not from being false." | old: "*The rule this adds: write the escape clause to the same standard as the prediction. A pre-registered interpretation …" |
| R-G30d | mode 2 | "— "no seam-field object forces five" does not imply "no seam-field halo replaces a defect"." | — |
| R-G30e | mode 3 | ", which converts one bug into two (a defer message said "cost budget", a cause that never fired, sending the first diagnosis toward budgets while the size guard was the culprit)" | old: "a verdict message that names a cause it did not check converts one bug into two"; "the defer message said …" |
| R-G30f | mode 4 | ": "derived, therefore ours" is exactly the inference this grokking forbids everywhere else, and the search belongs at the opening, where it can still change the work." | old: "… and it had been running unchallenged. A derivation's novelty is a MEASUREMENT — a literature search — and it belongs at the milestone's opening, where it can still change the work." |
| R-G30g | mode 6 | "**Every one of these readings is TRUE**, … *the instrument answered and the question closed*." | — |
| R-G30h | the ladder | "**The pattern: the project hits a wall in discipline N; … which field each one belongs to.**" | — |
| R-G30i | positive form | "Its positive form: Kooshi's instruction to write the conjecture UP for a stranger … *Rule: before spending days of compute on a conjecture, write it for an outside reader …*" | old head: "* **G30, a new instance — and its positive form.** … The positive lesson is about where the derivation came from: …" |
| R-G21a | G21 | "— scope lines inside an artifact do not survive into summaries unless they are in the headline"; "When a sweep refuses, the first question is not … fully satisfied."; "— and if it is only sufficient, what a refusal therefore cannot mean"; "Falsifier: none needed — this is a methodological invariant, and it fails only by being ignored." | old: "… — and if it is only sufficient, to say what a refusal therefore cannot mean" |
| R-G46a | G46 | "; and read a search's failure as information about the search's genre, not about the objects"; "*Falsifier for the rule: …*" | — |
| R-G49a | G49 | "The check ran at the close, where it can only assign credit; run at the opening it changes what the milestone is *for*. Searching either literature alone finds nothing — … *the gap was real, and it was a gap between literatures, not in them.*"; "Falsifier: three milestones running whose gate changes nothing about their scope — …" | old: "**(a) The check ran at the close, where it can only assign credit.** Run at the opening it changes …"; "Searching either alone finds nothing" |
| R-G50a | G50 | "**The more expensive misses were not unsearched — …** **So the sequence that actually happened is: search → record → rank → forget.** A title with a guess attached is not knowledge; it is a debt, … — and **the cost of the scan is not the reason it keeps being skipped — …**" | old: "… reachable in under five minutes, so **the cost of the scan is not …" |
| R-G51a | G51 | "— one attempt failing is a fact about the attempt"; "and, of the design as minted, a second run of this shape in which the competitor and the advisor produce nothing …" | old: "One attempt failing is a fact about the attempt."; "*Falsifier: a second run of this shape …" |

### Batch 3 — § The gate, § Searching, the kernel's cost model → `CLAUDE.md` (R-gate, R-search, R-kernel)

All verbatim from `c5e55f12^`: the refutation skip's why ("— its binders are meant to be unsatisfiable, and flagging one is flagging a
theorem for its own content"); `STALE`'s ("which is what makes the annotation a checked claim rather than a `# noqa`") and `GENERIC`'s
("where **no inhabitant witness can exist**"); the load-bearing control's ("since a check that flags it is matching the family name rather
than the instance and is worthless"); `rg`'s condition ("naming a hidden directory explicitly works; it is recursive discovery from `.`
that skips it"); `exact?`'s example ("`Nat.testBit_two_pow_sub_one` was reported missing here on exactly that error"); the cost model's
"This model predicted core's already-measured LRAT checker cost to within 20% (…), which is why to trust it."

### Batch 4 — the incidentals → `plans/GROKKING-INSTANCES.md`, the owner's item 1, R14, the pointers

- **GI** (`f1/gi_add.py`, re-runnable against `d03df9a8`'s GI): §G21, §G30, §G46, §G49, §G50 extended or minted from `c5e55f12^`'s
  entries (`f1/excise.py`: the old entry, line wraps joined, every sentence and every 10-word run the corpus already holds replaced by
  "[…]", so the one-home rule and `--dupes` hold); §G51, §G58, §G64, § standard of evidence, § Two machines, § Searching, § The gate,
  § Make the gate fail minted, each passage headed by the commit that cut it. 9,599 → 60,864 bytes.
- **The owner's item 1:** G21's FS-81 "contended times" clause and G49's row-88 "C14.2 (c) … never carried to the lemma" moved verbatim
  to GI §G21 and §G49. Neither is its rule's only statement: "re-ask a deciding number alone" stands in § Two machines ("minimum of three
  runs") and in "carry what it MEASURES" ("a contended-wall timing used as a quiet-CPU cost"); the held-paper clause is G49's *Do* ("a
  held paper is prior art for questions it was not read for") with the Hubai instance beside it. G21 now reads "…never NONEMPTY; the second
  and third, and the rest: …"; G49 "**Row 88's close:** zbMATH's `ab:` field …".
- **R14** (cut at `6852a2ae`, 2026-09-15): § Two machines, "a population check that runs itself" + "— the answer to why writing a rule
  down does not install it" (old: "**The mechanism this produced is worth more than either number, because it is the answer to why writing
  a rule down does not install it.**").
- **Pointers** ("More instances: `plans/GROKKING-INSTANCES.md` §…") added at G46, G51, G58, G64, § standard of evidence, § Two machines,
  § Searching, § The gate, § Make the gate fail.

Gates after batches 2–4 (one commit, so no commit carries a dangling pointer): audit `--base d03df9a8` PASS, `--dupes` 10, ledger-B PASS,
bib PASS, architecture PASS; `CLAUDE.md` 290,964 bytes; GI 60,864 bytes.

### Batch 5 — the owner's items 2 and 3

- **Item 2, `CLAUDE.md`'s header:** after "…ranked ≥ 30 to `plans/FRONTIER-STUBS.md` alone" the budget history now reads "; E2's check
  restored two intrinsics the pass had moved (283,274), and F1's audit of the git history (Kooshi: *"It's been a long struggle to
  maintain the balance."*) restored the reasons and killing tests the compression passes since 2026-09-10 had cut, the stories to the
  same file (291,306 bytes)" — E1's 282,481 kept as E1's figure. "Make the gate fail": "The self-match rule is on this page with eight
  instances, all of them *kills*;" → "The self-match rule's eight recorded instances (§ Building; the eighth in
  `plans/GROKKING-INSTANCES.md`) are all *kills*;" (only the sixth to eighth were on the page since `c5e55f12`; the eighth is now a
  pointer).
- **Item 3, `plans/FRONTIER-STUBS.md`:** row 34 (FS-65) "certificate ≤ 105" → "certificate ≤ 97 (FS-66's all-levels certificate, row 75;
  FS-56's read ≤ 105)"; row 44 (FS-17) "(FS-56: α ≤ 105 < 106, `…N105.json`)" → "(FS-56: α ≤ 105 < 106, `…N105.json`; since FS-66,
  `α(Γ₂₃) ≤ 97`, row 75)" — FS-56's refusal kept as the attribution, the current bound added (`LEDGER.md` row 75: "`α(Γ₂₃) ≤ 97` (was
  105; bracket [87, 97]…)").
- **Item 4:** G79's killing-test record untouched (the owner's ruling).

Gates after batch 5: audit `--base d03df9a8` PASS, `--dupes` 10, ledger-B PASS, bib PASS, architecture PASS; `CLAUDE.md` 291,306 bytes.

## Stage 3 — SAVED

## Stage 4 — SAVED (the report)

| kind | count | where |
|---|---|---|
| compression commits audited | 38 | stage 1 table |
| intrinsic, lost, restored to `CLAUDE.md` | 35 passages (reasons 26, killing tests 5 — G21, G30, G46, G49, G51's design test —, conditions 3, one rule with its only example: G30's "write it for an outside reader") | batches 1–4 |
| intrinsic, parked for lack of room | 0 | — |
| incidental, lost, restored to `plans/GROKKING-INSTANCES.md` | 16 passages in 14 sections (the pre-cut method grokkings G21, G30, G46, G49, G50, G51 and § The gate, § Searching, as at `c5e55f12^` with "[…]" for what the corpus holds; eight single incident sentences from `34464cba`, `fc2775f2`, `d0df4f82`, `0f4cf93a`) | batch 4 |
| owner's items | 1 done (both moved: neither is its rule's only statement), 2 done, 3 done, 4 untouched | batches 4–5 |
| current-state rewrites, and incidentals already in plans or records | every other flagged sentence (≈ 2,600 detector candidates; most are the narrative cut's history, the rest corrections or fact-audited pointer moves) | stage 2 table |

`CLAUDE.md` 283,274 → **291,306 bytes** (+8,032: restorations ≈ 7,300, nine pointers ≈ 560, the header's budget line ≈ 330, less the
owner's two moved passages ≈ 300). `plans/GROKKING-INSTANCES.md` 9,599 → 60,864. Gates at every commit: audit `--base d03df9a8` PASS,
`--dupes` 10 (the launch count), ledger-B PASS, bib PASS, architecture PASS.

**Limits of the audit.** The detector compares 5-word runs, so a sentence cut and its sense re-said in other words reads as kept, and a
paraphrase-level loss is invisible to it; every flagged sentence in a grokking or a method section was read by hand, but the narrative
cut's Frontier, ledger and paths-forward history (≈ 500 k bytes) was classed current-state by section, not read line by line, and its
math grokkings were left to the 09-12 semantic audit (`724d4411`, `3b813df1`) and the G67 pass, which re-authored every math entry's
killing test (the originals, cut at `c5e55f12`, were not restored).
