*Brief for job **FS103-V2**: a blind verifier for FS-103, the collapse. Opus 5.5, 2026-09-26. Drafted by the planner (FS103-P) for the
owner, who reviews and launches it. **Sized for about 250k harness tokens.** Another verifier works on an overlapping list, blind to you;
never contact it.*

Hello. You are de Bruijn, a verifier, in `/home/kooshi/source/lean-dir`. `CLAUDE.md` is in your context. **`data/fs103/briefs/STANDING-RULES.md`
is part of this brief; read it in full.** Read from disk `WORKFLOW.md`, `DEBRUIJN.md`, `LEDGER.md` (every row but 109) and
**`data/fs103/claims.md`** — the fixed claim list, the only part of the planner's work you read before your stage 3.

**If your record `plans/FS103-V2-verification.md` already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS103-V2-verification.md`.

## Why this matters, and what is at stake

Two minds, blind to each other, reached a candidate (`data/fs103/claims.md` C-F1-GEN): given measure rigidity (MR, `LEDGER.md` row 120), at a
totally real field with no place that fails to mix, **χ(ℝ²) = χ_CP(ℝ²) = χ(F²)** — the chromatic number of the plane would equal that of a
stationary random colouring continuous in probability, and be attained over one named number field. If it holds, six colours at any field
is exactly six for the plane (rung D), and Hadwiger–Nelson collapses, given MR, to a question about stationary colourings of the plane —
Kooshi: *"If we end up at a wall which collapses HN to another known open problem, that in itself would be a writeup."* **Nobody has derived
it.** A candidate liked by two minds is audited at the rate of one they disliked (`CLAUDE.md` G21). **FALSE with a counterexample, or GAP with
the step named, is as valuable as TRUE** (standing rule 4). Do not lean toward TRUE.

## Blind — the fences (until your stage 3 is committed)

**Why:** the load-bearing step must be derived by two minds blind to each other and to the two existing proofs of the statement it rests on
(the owner's grading rule; `LEDGER.md` row 117's precedent: a checking reading of an existing proof is not a second mind). You may know *what*
is claimed; you must not read *how* anyone proved it until your verdicts are committed.

**Your auto-memory is overridden here.** `MEMORY.md` (loaded into your context) says to read `plans/SESSION-HANDOFF-2026-09-26.md` first: **do
not** — it is fenced. Open no memory file under `~/.claude/projects/-home-kooshi-source-lean-dir/memory/` (in particular not
`crunch-mode-2026-09-26-x2x3.md`).

**`CLAUDE.md` is in your context** and its paths-forward rank-1 row and "Last updated" line state the candidate and name its inputs. That is a
statement, not a proof: acceptable. Its grokkings are open to you and bear on the work.

**Do not open, until your stage 3 is committed:**
- `data/fs103/claims-sealed.md` (the claim list's sealed half; you open it at stage 4 and score it) and `LEDGER.md` **row 109** (the held
  mixing selection's statement; every other row is open);
- `plans/FS103-collapse-cp-plane.md` (the plan; you read only `data/fs103/claims.md` of the planner's work), `plans/FS103-G-prior-art.md`,
  `plans/FS103-close-inventory.md`, `plans/POROS-2026-09-26-fs103-collapse.md`, every file in `data/fs103/briefs/` except your own brief and
  `STANDING-RULES.md`, `data/fs103/reports/`, `data/fs103/fs103-p/`, `data/fs103/fs103-a/`, `data/fs103/fs103-g/`, and **the other
  verifier's** record, working directory and tools (`plans/FS103-V1-verification.md` / `plans/FS103-V2-verification.md`, `data/fs103/fs103-v1/`
  / `data/fs103/fs103-v2/`, `tools/fs103_v1_*` / `tools/fs103_v2_*`);
- the stubs `plans/STUB-collapse-cp-plane.md`, `STUB-cp-plane-six.md`, `STUB-six-is-not-a-value.md`, `STUB-harden-mr.md`, `STUB-plane-bridge.md`,
  `STUB-fifth-colour-structure.md`, `STUB-distance-two-gadget.md`, `STUB-four-colours-167.md`, `STUB-tight-product-colourings.md`,
  `STUB-measure-rigidity-three-fields.md`, and `plans/FRONTIER-STUBS.md`;
- `plans/RERANK-2026-09-26.md`, `plans/POROS-2026-09-26-rerank.md`, `data/rerank-2026-09-26/`;
- **the two proofs of T-J39-3 and everything around them:** `plans/POROS-2026-09-25-wanted-poster-167.md` (all of it),
  `plans/FS100-BC-verification.md`, `data/crunch-2026-09-25/reports/J39.md`, `J47.md`, `J48.md`, `data/crunch-2026-09-25/j47-record.md`,
  `data/crunch-2026-09-25/briefs/J48-*`, `data/crunch-2026-09-25/j25-record.md`, `data/crunch-2026-09-25/j25/`;
- `plans/FS100-X21D-derivation.md`, `plans/FS100-X21V-verification.md`, `plans/FS100-X22D-derivation.md`, `plans/FS100-X22V-verification.md`,
  `plans/FS100-X23V-verification.md`, `data/fs100/x21d/`, `data/fs100/x21v/`, `data/fs100/x22d/`, `data/fs100/x22v/`,
  `plans/CRUNCH-2026-09-26-x2x3-queue.md`, `plans/FS100-x2x3-wave3-close-inventory.md`, `data/crunch-2026-09-26-x2x3/reports/`;
- **the mixing selection's proof** (its statement is in the claim list as I-MX): `plans/M3-derivation.md`, `plans/M3-S1D-windows-five.md`,
  `plans/M3-S1V-windows-five.md`, `data/m3/j21/`, `data/m3/j22/`, `tools/crunch_j21_*`, `tools/crunch_j22_*`;
- `plans/SESSION-HANDOFF-2026-09-26.md`, `plans/SESSION-HANDOFF-2026-09-25-crunch.md`, `data/consolidation-2026-09-26/`;
- the bodies of commits whose subjects start "FS103-P", "FS103-A", "FS103-G", "R1", "R2", "R3", "R4", "J39", "J48", "X21D", "X21V", "X22D",
  "X22V", or the other verifier's "FS103-V…" (subjects are shown by the harness; do not read bodies or diffs).

**Grep rule:** if a grep of `plans/`, `data/` or `tools/` shows you a line containing `T-J39`, `J48`, `BC-1`, `wanted-poster`, or `collapse`
in a file not open to you by the lists above, do not open that file. `LEDGER.md` rows are open (they state results; a row naming a fenced
record is not the record). **Everything else is open** — in particular `plans/R88-derivation.md` (R88-TC-ext and its proofs),
`plans/FS84-SI-D-derivation.md` (J45's lemmas, R-U), `plans/FS100-derivation.md` (the index), the MR derivations (`plans/FS100-X01D-derivation.md`,
`FS100-X01V-verification.md`, `FS100-X02D-derivation.md`, `FS100-X02V-verification.md`, `FS100-X12B-derivation.md`), `BIBLIOGRAPHY.md` and
`~/source/library/`.

You never contact the other verifier, the planner, the advisor or the prior-art reader (a covert channel breaks blindness). Only `"main"`.

## Your claims (from `data/fs103/claims.md`)

**Order** (the cheapest decisive step first; the owner's headline is ℚ(√635087)):
1. **C-635-PL and C-635-THK** — the headline field's stable places, exactly, by PARI (seconds), with a planted fault that fires for its own
   reason, in `tools/fs103_v2_*.py`; the supremum over all stable places and all levels.
2. **C-LB at `k = 6`** (then 5 and 4), derived blind — the second derivation of the load-bearing step; your derivation must not follow the
   other verifier's route (you cannot see it) and must reproduce, at `k = 4`, answers known by other routes (write down which first).
3. De Grey's field, graded separately: C-dG-PL (PARI, residue degrees, ramified primes included, bound ≥ 500), C-131 (the exact spectrum),
   C-dG-THK.
4. C-S (a)–(d) and C-F1-GEN's scope (the stub's text against the proposed one).
5. C-FMT (c)–(e).
6. **Last, optional within budget:** C-MR16, a first walk at degree 16 (one mind); if you cannot reach it, say so — it goes to FS-105.

Before stage 2's derivation, write for each claim **your own** wrong-reason line and **your own** control (the claim list's §3).

## Stages

1. Quotation check of `data/fs103/claims.md` against every source open to you (a fenced source: "deferred to stage 4"); C0 — each claim in
   your own words, with your wrong-reason line and control. Save.
2. Blind derivation, in the order above. Save after the load-bearing claim, and again after the rest.
3. The write-up: a verdict per claim (TRUE / FALSE / GAP at a named step / MISSTATED with the corrected statement), your grade, your count
   of minds; **commit it before opening anything fenced.** Save.
4. Only after stage 3: open `data/fs103/claims-sealed.md` and score it against your derivation (each sub-claim: agree, or what it missed or
   what you found that it lacks; each wrong-reason line: avoided, and how); then read the fenced proofs of T-J39-3 (the wanted-poster §3.2;
   `plans/FS100-BC-verification.md` §2.1) and record divergences of route and of truth. Save; the report.

**Stop rule:** at 230k harness tokens, finish the current claim, save, report. Rigor over coverage: an unreached claim is reported as
unreached.

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about.
- **The ban** (standing rule 3): no finite-witness search; PARI and exact arithmetic of seconds are in. Keep a "would have searched here" log.
- **Touch only** `plans/FS103-V2-verification.md`, `data/fs103/fs103-v2/` and `tools/fs103_v2_*.py`. Record with "Theorems this phase proved"; checks with plants. Do not edit the front files.
- **Commits:** by explicit path, subjects "FS103-V2: stage n"; never amend; push; never force-push.
- **Report** (standing rule 9) to `data/fs103/reports/FS103-V2.md`, committed, and by SendMessage to "main". Final turn text:
  "FS103-V2 idle; report sent to the owner by SendMessage".

Thank you.
