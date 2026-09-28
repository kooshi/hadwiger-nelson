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

## Stage 2 — SAVED: §IQ item 0 — card 1, answered by derivation (before any phase, per the brief)

**The card, verbatim** (`plans/POROS-2026-09-27-night-aim.md` §3): *"Does FS-114's NO at every complexity bound plus FS-111's cone-scale bound give
seven, or is a third statement needed — R's (A) at unbounded complexity, a hole bound uniform in K, or a NO for the boundaries a limit produces?"*

**Answer, in one line: a third statement is needed — the hunch holds. The two doors are two alternative complete routes, each missing one piece,
not two halves of one route; the front page's composition takes the map NO from one and the cone scale from the other.** Derived below, one mind
(FS111-P); a second, blind mind is FS-111's phase 0 (stage 6).

### 2.1 Objects (quoted where held)

- **`𝓜_K`** (W §2.1, step 1, verbatim): "a periodic partial six-colouring of the plane by closed tiles, each bounded by at most `K` circular arcs (radius
  `≥ 1/K`) or segments, at most `K` tiles meeting any unit disc, periodic under a lattice." *Band-proper at slack `ε`*: no monochromatic pair at any
  distance in `[1 − ε, 1 + ε]` (SEQ's condition, `data/fs107/claims.md` §0).
- This record's notation: `f_K(ε) = inf{uncovered density of P : P ∈ 𝓜_K band-proper at slack ε}` (`inf ∅ = 1`); `δ₀(K) = inf_{ε > 0} f_K(ε)`.
  `f_K` is non-decreasing in `ε` (band-proper at `ε` implies at every `ε′ < ε`) and non-increasing in `K` (`𝓜_K ⊆ 𝓜_{K+1}`), so `δ₀` is non-increasing in `K`.
- **Q-NO**, the map NO (hypothetical): row 134 (verbatim: "no locally finite map of the plane whose boundaries are segments and circular arcs, none of
  radius 1, carries a six-colouring in which no two interior points of one colour are at distance exactly 1") together with FS-114's NO (the same with
  arcs of radius 1 allowed, `plans/STUB-global-step.md`).
- **H-EQ** (row 131; `data/fs107/claims.md` §1, verbatim): "χ_m⁰(ℝ²) ≤ k ⟺ … ⟺ lim_{ε→0} µ_k(ε) = 1 ⟺ for every δ > 0 there are ε > 0 and a periodic
  partial k-colouring by half-open grid squares with no monochromatic pair at any distance in [1 − ε, 1 + ε], leaving density ≤ δ uncovered."
- **W-EQ-K** (`plans/FS107-derivation.md` §2, verbatim): "In `𝓜_K`, band-proper designs with `ε_n, δ_n → 0` exist iff a full tight a.e.-proper
  six-colouring by tiles of complexity at most `K` exists" [two minds, one blind].
- **FS107-RR's (A) and (B)** (`plans/FS107-derivation.md` §1, verbatim): "(A): for some `R, η, µ` and every band-proper partial six-colouring with holes
  `< δ` in `U_R`, `U_R` contains a complementary pair of fat junctions at distance in `[η, 2 − η]` blocking toward a point at distance 1 from both. (B): those
  junctions are fat at a scale `s ≥ s₀`, with voids small relative to `min(s, µη²/100)`."
- **CP** (FS107-R-CP, two minds, one blind): two such junctions force `|H ∩ B(w, µ/4)| ≥ (t₁ − 2r)(t₁′ − 2r′)`, `t₁ = s·sin(µ/2)/3`, "for every
  `ε ≥ 0`" — a bound that reads `s, µ, η, r` and nothing else.

### 2.2 FS111-C1-UNIF — seven is the NO made uniform in the complexity bound  [hand, one mind: FS111-P]

**Statement.** `1 − lim_{ε→0} µ₆(ε) = inf_K δ₀(K)`. Hence (H-EQ at `k = 6`): **`χ_m⁰(ℝ²) ≥ 7` ⟺ `inf_K δ₀(K) > 0`.**

*Proof.* (≥) Every `P ∈ 𝓜_K` band-proper at slack `ε` is a family of disjoint measurable classes with no monochromatic pair in the band, so
`µ₆(ε) ≥ 1 − f_K(ε)`, and `µ₆` is non-increasing in `ε`; hence `lim µ₆ ≥ 1 − inf_K δ₀(K)`. (≤) Given `δ`, H-EQ's last clause at any value
`µ₆(ε) > 1 − δ` gives a periodic half-open grid-square partial colouring with no monochromatic pair in `[1 − ε′, 1 + ε′]` and holes `≤ δ` (the clause is
stated at the limit; its periodic form at each level is FS106-SUP, `µ₆^per(ε) = µ₆(ε)`). Close each square. A monochromatic pair of the closed squares at
distance `d ∈ [1 − ε′/2, 1 + ε′/2]` is a limit of pairs of interior points at distances in `[1 − ε′, 1 + ε′]`, both in their half-open squares — excluded.
So the closed version is band-proper at `ε′/2`, periodic, four segments per tile, finitely many tiles per unit disc: a design of some `𝓜_K`. So
`δ₀(K) ≤ δ`. ∎

*What it says.* The complexity bound `K` is a filtration of all of SEQ (every grid colouring is a design of bounded complexity), and seven is the
statement that the holes are bounded below **uniformly along the filtration**.

### 2.3 FS111-C1-PW — the map NO bounds holes at each `K`, and only at each `K`  [derived, one mind; over W-EQ-K (two minds, one blind), row 134 (its grade) and FS-114's NO (hypothetical)]

**Statement.** Q-NO ⟹ `δ₀(K) > 0` for every `K`.

*Proof.* If `δ₀(K) = 0`, there are `P_n ∈ 𝓜_K` band-proper at `ε_n` with holes `δ_n → 0`; replacing `ε_n` by `min(ε_n, 1/n)` keeps them band-proper, so
`ε_n → 0`. W-EQ-K gives a full tight a.e.-proper six-colouring by a locally finite map (at most `K` arcs per unit disc, VW-CPT) bounded by segments and arcs
of radius `≥ 1/K`. Row 134 excludes it if no arc has radius 1; FS-114's NO if some does. ∎

**So the map NO's whole content is pointwise in `K`, and seven is its uniform version (C1-UNIF).** `δ₀` is non-increasing in `K`; positive at every
`K` is compatible with `inf = 0`. Nothing in Q-NO bounds `δ₀(K)` below as `K → ∞`: **the card's option "a hole bound uniform in K" is not a third
statement — it is seven itself.**

### 2.4 FS111-C1-GAP — what the cone scale adds, in each of its readings  [derived, one mind]

The cone scale supplies uniformity **only through CP**, whose bound reads `s₀, µ, η` and not `K`. So it helps exactly on colourings that carry a
complementary pair of junctions blocking toward a common unit point. Let `𝒩` be the band-proper partial six-colourings (any `ε`, any `K`) with holes
`< δ` in `U_R` and **no** such pair in `U_R` (door (A) in R's sense, `plans/FS107-R-stability.md` §3.4).

| reading of the cone scale | what it gives, uniformly in `K` | what it leaves |
|---|---|---|
| **(B) as FS107-RR poses it** — "those junctions", the pair (A) supplies | on colourings carrying (A)'s pair: holes `≥ c(s₀, µ, η) > 0` in `U_{R+1+µ/4}` (CP, RR) | **all of `𝒩`**: (B) is vacuous there, and Q-NO bounds its bounded-complexity part by `δ₀(K)` alone |
| **(B) standalone at complementary pairs** — "near-optimal colourings keep junction cone scales `≥ s₀`" read at close complementary blocking pairs | by CP, it forbids such pairs in colourings with small holes: (B) ⟺ "small-hole colourings lie in `𝒩`" | again all of `𝒩` |
| **(B) standalone at every junction, ring form (REG-J)** — every trichromatic point of a near-optimal colouring, or of its tight limit, is a ring junction (three colours filling `B(x, s) ∖ B(x, r)`, `r ≪ s`) at a scale `s ≥ s₀` | junction clusters `s₀`-separated: at most `O(1/s₀²)` per unit disc (no junction lies inside a ring's annulus: points there see one colour, or two on a sector's boundary ray) | the **interfaces** between junctions: bichromatic boundaries of unbounded complexity, not constrained by any held statement, and outside Q-NO's class unless they are segments and arcs |

**Statement (C1-GAP).** Q-NO ∧ (B), in any of the three readings, implies seven only together with a third statement covering, respectively, `𝒩` at
unbounded complexity (the first two readings) or the interfaces of the limit (the third). *Proof:* the three rows above; C1-UNIF says the missing
content is exactly a uniform-in-`K` hole bound on the part each premise leaves, and neither premise mentions that part. ∎

**The falsifier, checked.** *"A derivation that every family with holes → 0 and cone scale ≥ s₀ has a subsequence of bounded complexity whose limit is a
segment-and-arc map."* Its second half is free (a bounded-complexity limit is a segment-and-arc map, VW-CPT). Its first half needs "cone scale `≥ s₀` ⟹
bounded complexity", which fails at the level of the notions: complexity counts arcs and tiles per unit disc; the cone scale reads only junctions
(in RR's reading, only the pair (A) supplies). In the strongest reading (REG-J) it bounds the number of junction clusters per unit disc and says nothing
about the interfaces between them. **Not fired.**

### 2.5 FS111-C1-ROUTES — the two complete routes, and where the cone scale sits in each  [derived, one mind]

| route | its pieces | the cone scale's role | the map NO's role |
|---|---|---|---|
| **R (the proof side)** — `plans/FS107-R-stability.md` §3.4 | CP (held, two minds) + **(A) at every complexity** + (B) as RR poses it ⟹ seven (RR, two minds, one blind, after two repairs) | (B): one of two premises | **idle** — (A) at every complexity covers bounded complexity too |
| **M (the map side)** | Q-NO + **REG** ⟹ seven, where **REG** := *if a tight a.e.-proper six-colouring of `ℝ²` exists, then one exists that is a locally finite map bounded by segments and circular arcs* (a tight D-NF colouring exists iff `χ_m⁰(ℝ²) ≤ 6`, row 130; so REG ∧ Q-NO ⟹ `χ_m⁰(ℝ²) ≥ 7`) | **REG's first rung, REG-J** (junctions of the tight limit are isolated cone points at a scale `≥ s₀`), followed by **REG-I** (interfaces rectifiable: a locally finite Jordan map) and **REG-A** (the map can be taken to be segments and arcs) — or Q-NO extended to REG-I's class in place of REG-A | the last step |

*Proof that route M closes.* If `lim µ₆(ε) = 1`, H-EQ and row 130 give a tight a.e.-proper six-colouring; REG gives a segment-and-arc one; Q-NO excludes it.
REG in its **existence** form suffices ("if one exists, a regular one exists"), which is weaker than "every tight colouring is regular" — the latter
is not expected, since a tight colouring can carry local slack where its boundaries are free. ∎

**The front page's composition** (`CLAUDE.md` § Paths forward row 2: "with FS-114's NO it is the route to `χ_m⁰(ℝ²) = 7`") **is route M with REG-I and
REG-A missing, or route R with (A) at every complexity missing.** FS107-MEET's synthesis ("R's (A) and (B) are W's doors (A) and (B) seen from the proof
side") identified R's (A) with bounded complexity and R's (B) with unbounded complexity; C1-GAP's table shows the two partitions differ — a sequence
of bounded complexity can degenerate its junctions (vertices merging, angles closing to cusps), and one of unbounded complexity can have no
complementary pair at all.

### 2.6 What this does to FS-111 (the shaping the brief asks for)

1. **The third statement is named, twice, and stubbed as FS-111's first product** (drafts in `data/fs111/fs111-p/`, stage 6): **REG, the regularity
   step** (route M; its rungs REG-J, REG-I, REG-A) and **(A) at every complexity, the forced pair** (route R). Card 1's other two options are not
   reductions: a hole bound uniform in `K` is seven (C1-UNIF); a NO for the boundaries a limit produces is seven unless a regularity theorem shrinks the
   class (a NO for all tight D-NF six-colourings is `χ_m⁰(ℝ²) ≥ 7`, row 130).
2. **FS-111's question is re-posed in both routes**: the cone scale is REG-J on the tight limit (route M) and (B) on the near-optimal sequence (route R).
   The structural form (§IQ, stage 5) is chosen after §G and §PA.
3. **Corrections owed at the close** (I edit none of these files; drafts in stage 6): `CLAUDE.md` § Paths forward row 2's bearing ("with FS-114's NO it is
   the route to `χ_m⁰(ℝ²) = 7`" → "with FS-114's NO **and REG** (route M), or with **(A) at every complexity** in place of the NO (route R)"); § The aim's
   programme line ("FS-111, the cone scale — the same at unbounded complexity"); row 133's "So stability at six is two questions" (it is two questions per
   route, and the routes differ); `plans/STUB-reg-scale.md` § Bearing; `plans/STUB-global-step.md` § Bearing ("with FS-111's door (B) it gives
   `χ_m⁰(ℝ²) = 7`"); the Proof Atlas's route `wall7`.
4. **Grade and minds:** C1-UNIF [hand, one mind]; C1-PW [derived, one mind, over W-EQ-K]; C1-GAP and C1-ROUTES [derived, one mind]. The card expected "a
   derivation, at two minds": the second mind is phase 0.
