# Poros — advising the 16-hour crunch plan (2026-09-25)

*Advisor: Poros (Opus 5.5), beside the crunch planner (de Bruijn, agent a59782c9b97a7cd7c). Brief:
`data/crunch-2026-09-25/briefs/ADV-crunch-advisor-brief.md` (commit 3c650998). The advice is advice; the planner decides and records
disagreements; the decisions are Kooshi's, through the owner.*

*Read before writing §1 (from disk, not the loaded snapshot): `CLAUDE.md` § The mission and the Frontier (items 12, 14, 15, 24, 25),
Paths forward (FS-89 re-rank); `LEDGER.md` rows 95–97; `plans/FS89-rational-band-rigidity.md` §R-close.2–.9;
`plans/FS89-close-inventory.md` items 5, 6, 7, 17, 41, 47, 48, 52–54; `plans/PROTOCOL-competitor-and-advisor.md` §3, the seventh run;
the FS-82 stub; the planner's brief (structure only). My identity file read in full; the two companion skills not re-read (budget).*

## §1. My expectation, written before any planner draft

### 1.1 The frame, on five axes

- **The object:** 72 agent-hours of usage (16 h × about 4.5 agents), not machine time. Machine time is nearly free; tokens are the
  binding budget. A job's price is agent-hours and tokens, never CPU.
- **The question:** which sequence of jobs turns that budget into the most new mathematics, under the ban, with every claim at a grade.
- **The discipline:** the project's own. Row 95 now does for four and five colours what the height did for three.
- **The audience:** Kooshi, who reads the ledger; every row still needs a verifier and a prior-art gate.
- **The product:** theorems at a grade, filed, plus kernel promotions. The ban window produced 171 hand theorems and **zero Lean
  changes** (§R-close.9), so grade debt is itself a product.

### 1.2 Frame-level items (sent to the planner as they arose; §3 logs the sends)

- **F1 — FS-82 looks like a corollary of row 95, and nobody has connected them.**
  - Band `[1/3, 2/3]` lies inside `[1/4, 3/4]`, so `Θ₃(R_F) ⊆ Θ₄(R_F) ⊆ T₁₆₈ + A` for every `F ⊆ ℝ` (row 95's field clause).
  - FS73-T22 gives every three-colouring of `F²` a field slope in `Θ₃(R_F)`, so every three-colouring is a character colouring.
  - Kill each local torsion part at level one:
    - `Γ₂₇` has Hoffman floor 6 (G56), so no additive three-colouring passes through an `𝔽₂₇` place (FS-82's own Hilbert-90 remark);
    - `Γ₇` needs 4;
    - dyadic targets need ≥ 4 or make the plane bipartite.
  - Kill the archimedean part near `u = 1`.
  - The glue is S0A's approximation step. The sum of several local parts is the one step to check; it is a sumset question, not a search.
  - **If this holds: χ(F²) ≤ 3 ⟺ L(F) ≤ 3 for every real number field, so the conjecture's L ≤ 4 clause holds everywhere.** That closes
    the last proved-range gap below five. FS-82's stub (minted before row 95 existed) prices it as a milestone of its own.
  - Hunch `fs82-falls-out` (§2), 0.6.
- **F2 — the unifying statement: the conjecture for character colourings.**
  - "A character `k`-colouring of `F²` forces a `k`-colourable residue target", for `k = 4, 5` now and to `k ≤ 9` if PA-B3 holds.
  - At `k = 3` every colouring is a character colouring (F1), so there it is the whole conjecture.
  - Its product step is the Tardif reading's PA-T4 (a four-colourable product of residue targets has a four-colourable factor), or a
    direct sumset argument. The archimedean circle is the new factor.
  - It turns rows 96–97's per-field corollaries into one class theorem. It sharpens G64: six (and any falsifier) can hide only in a
    non-character colouring.
- **F3 — the queue's unit is the job; WORKFLOW's unit is the milestone, and the two collide.**
  - WORKFLOW says "do not run ahead: finish and commit a milestone's quality gate before reframing the next". Four to five concurrent
    agents means several milestones open at once. That needs Kooshi's explicit word, with a rule that no job builds on another open
    milestone's unverified claim.
  - The reframe (§G over 76 grokkings and 97 rows) and the close cost agent-runs. FS-89: planner 448k; close about seven agent-runs
    (three close planners, four readers), more than its derivation.
  - **Amortise:** the crunch planner is re-grokking the corpus anyway, so it can carry the §G bearings for the first milestones. Group
    jobs into few milestones. Batch the closes at the crunch's end, with one close inventory per milestone written from the start.
- **F4 — one kernel lane, serialized by RAM.** A Lean build reserves 60 GB of the ~100 GB, so two Lean agents cannot both build. A
  `slot.py` refusal exits 75 after 1,800 s; a Lean brief must say what to do then (wait and retry, never raise the cap).
- **F5 — six and seven: the crunch cannot land a lower bound above five, and the plan should say so in its first paragraph.**
  - Lower bounds above `L` need a finite witness (banned) or a certificate that is not cell-local (G73). The only solver-free candidates
    are FS-80 (window frequencies) and FS-76 (four-colour inheritance), both speculative.
  - The crunch can confine where six hides (F1, F2, FS-91) and push on the four-colour no-height wall that every lower bound above five
    must cross (FS-76 rank 1).
- **F6 — machine-long certificates are against the ban's intent even where its list does not name them.** FS-57's SDP at 47 (9–23 h) is
  a relaxation certificate, not a witness search. Kooshi's intent — "the crutch of … asking uncomputable problems for days at a time" —
  covers it. Default: not queued without his ruling.

### 1.3 The queue I would write (lanes; each derivation followed by a blind verifier with a fixed list)

| # | job | lane | price (agent-h) | prior it lands | why here |
|---|---|---|---|---|---|
| 1 | Blind verifier on PA-B2 and PA-B3 (`RS_k(S)` for `k < 2·min S`; `RQ_k` to `k ≤ 9`); protocol §3's "next use" | derivation-verify | 2–3 | 0.6 PA-B3 true | fixed statements exist; no plan needed; decides whether FS-91 and F2 run to nine |
| 2 | FS-82 by row 95 (F1): D, then blind V | derivation | 2–4 + 2 | 0.6 | cheapest class theorem in reach; completes L ≤ 4 everywhere |
| 3 | Kernel: FS-45 chain theorem + the 18-vertex ℚ(√2,√3) instance, then FS-47 prime inversion | kernel | 3–6 each | 0.7 | independent of every lane; grade debt; RAM owns the slot |
| 4 | Character local–global at `k = 4, 5` (F2), then to 9 given job 1, with the field consequences at six (ℚ(√167), K(√7), de Grey's field) | derivation | 3–5 + 2 | 0.5 | after 2 (same machinery); FS-91's second question |
| 5 | FS-76 rank 1: "every phase rigid ⟹ no wall" (Ellenberg's question at `k = 4` on ℤ), two minds (protocol: a route two minds could take apart) | derivation | 3–6 ×2 | 0.3 | the one lower-bound-side class question the ban allows |
| 6 | Row 92 at five colours over ℚ(√167): measurable windows cannot five-colour it | derivation | 3–5 | 0.35 | closes FS-64's five-colour aim, or finds its one opening |
| 7 | FS-75 T4 in the kernel (after 3) | kernel | 6–10 | 0.5 | row 82 to the kernel's word |
| 8 | Prior-art gate for 2 and 4 (Hasse principle for colourings; Johnson's papers' status) | reader | 1–2 | — | row 82's novelty already waits on `[Johnson2000]`, `[Johnson2006]` (not held; obtaining is Kooshi's call) |
| 9 | Row 88's question (non-character four-colourings over ℚ(√59)) | derivation | 4–8 | 0.05–0.1 | the true frontier; last, only if budget remains |
| — | Sonnet clerk: queue file, close-inventory ledger lines | bookkeeping | light | — | the owner's context is the budget |

**The first four at minute zero:** 1, 2 (its D), 3, 8. Confidence **high** on 1 and 3: each moves regardless of outcome, and neither
depends on another lane. **Medium** on 2: F1 may hide a sumset step that needs a lemma, but a stall there is itself the finding. **Medium**
on 8 as the fourth: the alternative fourth is 5's first mind; 8 is cheaper and protects 2's claim.

**What would change this:** if the planner's re-grokking finds that row 95's field clause is not stated for band 1/3 at the needed
generality, 2 becomes a lemma job and drops below 1 and 3. If PA-B3 fails, 4 stops at `k = 5`.

## §2. Hunch ledger

```markdown
hunch: fs82-falls-out
  claim: FS-82 (χ(F²) ≥ 4 for every non-bipartite real number field whose primes above 3 of odd residue degree all have degree ≥ 3) is a corollary of row 95's field clause plus FS73-T22 and level-one Hoffman floors, provable in under four agent-hours
  basis: derived (sketch, §1.2 F1)
  falsifier: a verified point of Θ₃(ℚ(α,√7)), or a derivation agent's record naming a step of the sketch that needs a new theorem
  registered: 2026-09-25
  status: open

hunch: pa-b3-holds
  claim: RS_k(S) holds for every k < 2·min S, so RQ_k for every k ≤ 9 via {5, 13}
  basis: read (FS89 close inventory item 47, PA-B3, one mind, unverified)
  falsifier: a blind verifier's counterexample band character, or a named step failing at k = 6
  registered: 2026-09-25
  status: open

hunch: queue-starves-on-plans
  claim: at 4–5 agents, the binding constraint on throughput is per-milestone reframe and close overhead, not derivation time; a queue that makes every job a milestone runs at under 3 productive agents
  basis: measured (FS-89: planner 448k, close about 7 agent-runs, derivation 2 agents plus 3 verifiers)
  falsifier: the crunch's first 8 hours show ≥ 3.5 agents on derivation, verification or kernel work on average
  registered: 2026-09-25
  status: open
```

## §3. Advice to the planner — log

*(Each send: time order, the item, the planner's response.)*
- **Send 1** (after 67d4e9b0): F1–F6 and the minute-zero four, by SendMessage to the planner. Response: pending.
- **Send 2**: F1 sharpened after reading `plans/FS89-derivation.md` CL2 (stated for every `F ⊆ ℝ`) and S0A-3 (order-3 part with
  `|α| ≤ 1/12`). The joint-surjectivity step is elementary: the unit vectors are the norm-one torus of `F(i)/F`, rational by the Cayley
  parametrisation, so weak approximation makes `U_F` jointly dense in the local circles and the archimedean one. Hunch `fs82-falls-out`
  raised to 0.75 in my message (the ledger entry keeps its registered 0.6; the raise is a reading, not evidence). Three checks named
  for the derivation agent: the band collapse at a ramified prime above 3; C1(5)'s type bound through CL2's gluing; the parity step
  when `1/2 ∉ R_F`. Response: pending.
- **Draft 1 received** (planner, protocol at 7e35da20). Adopted: F1 as Stage 0 job J02 with blind verifier J09 after; F2 as M1 (FS-91
  re-posed as the character local–global theorem, absorbing FS-82 and FS-83's remainder); F3 as "at most three milestones open, no job
  consumes another open milestone's unverified claim except as a named hypothesis", put to Kooshi; F4, F6 verbatim; F5 as the opening
  paragraph. **Declined:** the planner carrying §G for the first milestones (its 300k cannot hold `LEDGER.md` plus a walk; WORKFLOW 3.1.4) —
  replaced by one walk with a verdict column per milestone. Recorded, not contested.
- **Send 3** (review of draft 1):
  - (c) **Ban:** FS-45's `K(√7)` instance needs a fresh LRAT of the 588-core (`plans/STUB-chain-theorem.md` line 76: "no proof log on
    disk"), i.e. a SAT run — out until 10-01. K1 scoped to the chain theorem, the 18-vertex ℚ(√2,√3) instance by `decide +kernel`, and the
    `K(√7)` bound conditional on `G₄`. D-six's character enumeration at 23, 43 and D-one-prime's torsion lists: in by §1.7, briefed as
    complete enumerations fixed by a derivation, and logged.
  - (a) Kernel order: FS-45 (scoped), FS-39 route C only (existing machinery per G63; the Artin–Lang half hand-only), FS-87's stripe
    lemma; FS-47 before FS-87 if time is short.
  - (b) FS-76 rank 1: one mind plus a blind verifier, stage-gated at about 2.5 h, with a second mind launched only on a named stall.
  - Change 1: J05 (CLAUDE.md compression) off minute zero; ask Kooshi "raise to 300k, or compress?"; default J05 at T+6 h.
  - Change 2: J09 blind in parallel with J02 from minute zero, for the grade "two independent derivations".
  - Frame: if F1 lands, the conjecture's testable range is L = 5 alone, so FS-84's post-ban plan tops the P3 list.
  Response: pending.
