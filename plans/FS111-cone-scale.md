# FS-111 — the cone scale: do near-optimal band-proper six-colourings keep their junctions fat? (the milestone plan; job FS111-P)

*Milestone planner FS111-P (de Bruijn, Opus 5.5), 2026-09-27, brief `data/fs111/briefs/P111-planner.md` with `data/fs111/briefs/STANDING-RULES.md`
(rule 0 read first). WORKFLOW steps 3–5. Stub: `plans/STUB-reg-scale.md`. No children were started; no contact but "main". The record is saved in
stages (standing rule 2); each stage's section is headed "Stage n — SAVED" and committed before the next begins.*

*Order of work, and why it departs from WORKFLOW 3's order once.* The brief says: "**Before anything else — the night advisor's card 1** … **Answer it
at §IQ, by derivation, before any phase**, and let the answer shape the milestone". So card 1 is derived in stage 2, before the re-grokking; its
answer decides which question §G is read from inside. §G (stage 3), §PA (stage 4), §IQ's structural form (stage 5), the claim list (stage 5) and the
plan (stage 6) follow in WORKFLOW's order.

## Theorems this phase proved

*(one line per theorem, its grade and its address; filled as stages land)*

## Would-have-searched-here log (standing rule 3)

*(one line per move that would have been a search, and what was done instead)*

## Stage 1 — SAVED: quotation check (standing rule 5), files opened, the record's frame

### 1.1 Files read from disk (in this order)

| file | how | note |
|---|---|---|
| `data/fs111/briefs/P111-planner.md`, `data/fs111/briefs/STANDING-RULES.md` | in full | resuming check: `plans/FS111-cone-scale.md` did not exist; a fresh start |
| `CLAUDE.md` | in full, as loaded at session start (the snapshot at `a9410925~1`), plus the four-line diff of `a9410925` (FS-112's close) read from disk | the diff: FS-114 renamed "the unit-arc question" in § The aim's programme line; FS-104's bearing corrected; "G1–G83"; one § Building pointer. Every other line of the loaded snapshot equals the disk file |
| `plans/STUB-reg-scale.md` | in full (post-`a9410925`: "Decisive jointly with (A) — a one-mind reading") | |
| `plans/POROS-2026-09-27-night-aim.md` | in full | §3 card 1, §5 hunch `third-statement-needed` |
| `plans/FS107-derivation.md` | in full | FS107-RR, FS107-MEET, W-EQ-K and their grades |
| `plans/FS107-stability.md` | §PA, §IQ (ll. 364–414), §R-close stages 1–3 (ll. 522–735) | |
| `plans/FS107-R-stability.md` | stages 2–3 (ll. 119–333): the shape, CP, SW, §3.4's reduction | |
| `plans/FS107-W-near-colourings.md` | §2 (ll. 126–242) and §4 (ll. 324–383) | W-EQ-K's proof, the generator image, the two doors |
| `data/fs107/claims.md` | §0–§1 | D-MU, `µ₆⁰`, SEQ/LIM, H-EQ, C-Q-STAB, C-VOID |
| `plans/STUB-global-step.md` | in full | FS-114's NO, its forms and failure clauses |
| `LEDGER.md` | header, the claim list, rows 128–136 in full (closely); the rest in stage 3 (§G part 2) | |
| `plans/FS112-close-inventory.md` | header, items 70–79 | |

### 1.2 Quotation check of the brief and the launch message (standing rule 5)

| # | quoted in the brief or message | source | result |
|---|---|---|---|
| Q1 | Kooshi: "My goal is to fully solve, and then verify in Lean, HN. Then we publish." (2026-09-26) | `CLAUDE.md` § The aim: *"My goal is to fully solve, and then verify in Lean, HN. Then we publish. (Anything we do must be formalized in Lean before publishing, …)"* | verbatim prefix; matches |
| Q2 | Kooshi: "Even decompressed, this is a bit beyond me, […]. I'll defer to a Poros agent." | `plans/FS112-close-inventory.md` item 70 | matches |
| Q3 | card 1: "Does FS-114's NO at every complexity bound plus FS-111's cone-scale bound give seven, or is a third statement needed — R's (A) at unbounded complexity, a hole bound uniform in K, or a NO for the boundaries a limit produces?" | `plans/POROS-2026-09-27-night-aim.md` §3, card `does-the-route-to-seven-close-with-two-doors`, "ask:" | matches |
| Q4 | its hunch: "a third statement is needed — the NO bounds holes by `δ(K)` with no uniformity in `K`, and (B) presupposes (A)'s junctions exist" | same card, "hunch:" | matches |
| Q5 | its falsifier: "a derivation that every family with holes → 0 and cone scale ≥ s₀ has a subsequence of bounded complexity whose limit is a segment-and-arc map" | same card, "falsifier:" | matches |
| Q6 | the question: "door (B): do near-optimal band-proper six-colourings keep junction cone scales `≥ s₀` on a set of positive measure?" (not in quotation marks in the brief) | `CLAUDE.md` § Paths forward row 2, verbatim; the stub's own wording is "(B) those junctions are fat at a scale `s ≥ s₀` — on a set of positive measure — with voids small relative to `min(s, µη²/100)`" | the brief's text is the front page's; the stub's (B) is conditional on (A)'s junctions ("those junctions") — the difference is card 1's point, carried into stage 2 |
| Q7 | message: FS-111 "decisive jointly with FS-114's NO is a one-mind reading (FS107-MEET, row 133's grade)" | `plans/STUB-reg-scale.md` § Bearing: "**Decisive jointly with (A) — a one-mind reading** (FS107-MEET, row 133's grade; …)"; row 133: "the meeting one mind (A2)" | matches in content; the stub's "(A)" is door (A) at bounded complexity, i.e. FS-114's NO with row 134 |
| Q8 | standing rules: *"From here on out, you may doubt your ability … You are capable, and you will surprise yourself."*; *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."*; *"search for a finite graph is out. It would be huge, not feasible."*; *"It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress."* | `CLAUDE.md` § Counter-priors; § Where the problem stands item 23; § Publication; `plans/CONSOLIDATION-2026-09-27.md` item 20 | all match |

**Result:** every quotation matches its source. One note (Q6): the front page poses door (B) standalone ("do near-optimal … colourings keep junction
cone scales `≥ s₀`"), the stub and FS107-RR pose it about "those junctions", the ones (A) supplies. Stage 2 derives what that difference costs.

### 1.3 Files this job may touch (the brief's list)

`plans/FS111-cone-scale.md` (this record and the plan), `data/fs111/` (claims, briefs, `data/fs111/fs111-p/`), `tools/fs111_p_*.py`, new files in
`~/source/library/`; `plans/FS111-close-inventory.md` created empty from FS-112's header in this stage — from now on the owner is its only writer.
