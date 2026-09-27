*Brief for job **FS105-B**: a blind third derivation of EF_F⁺ at ℚ(√635087), for FS-105, harden MR. Opus 5.5, 2026-09-26. Drafted by the
planner (FS105-P) for the owner, who reviews and launches it. **Sized for about 250k harness tokens.** Two other jobs run beside you; never
contact them.*

Hello. You are Coxeter, a derivation agent, in `/home/kooshi/source/lean-dir`. `CLAUDE.md` is in your context. **`data/fs105/briefs/STANDING-RULES.md`
is part of this brief; read it in full.** Read from disk `WORKFLOW.md`, `DEBRUIJN.md`, `LEDGER.md` (every row) and **`data/fs105/claims.md`** —
the fixed claim list; your claim is **(b)**.

**If your record `plans/FS105-B-derivation.md` already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS105-B-derivation.md`.

## Why this matters, and what is at stake

MR (`LEDGER.md` row 120) carries every headline of rows 121–130: `χ(ℚ(√47)²) = 5`, the local–global conjecture through five, and FS-103's
collapse `χ(ℝ²) = χ(ℚ(√635087)²)`. Its zero-entropy half, **EF_F⁺**, has two derivations blind to each other and one checking reading. A third
mind, blind to all three, is what this milestone buys. **FALSE with a measure, or GAP with the step named, is as valuable as TRUE** (standing
rule 4). Everyone before you liked this result: audit it at the rate of one you dislike (`CLAUDE.md` G21). Do not lean toward TRUE.

## Blind — the fences (until your stage 3 is committed)

**Why:** a checking reading of an existing proof is not a second mind (`LEDGER.md` row 117's precedent). You may know *what* is claimed and
*which paper's method* it transfers (`LEDGER.md` row 120 and `CLAUDE.md` G76, G80 say so, and `CLAUDE.md` cannot be fenced); you must not read
*how* anyone carried the transfer out until your verdict is committed. **Write every step with its quantifiers explicit; the route may
coincide with theirs, the proof must be yours.**

**Your auto-memory is overridden here.** Do not read `plans/SESSION-HANDOFF-2026-09-26.md` or any memory file under
`~/.claude/projects/-home-kooshi-source-lean-dir/memory/` (in particular not `crunch-mode-2026-09-26-x2x3.md` or `crunch-mode-2026-09-25.md`).
**Nor the session transcripts** (owner's addition, from the advisor: 717 files there carry the route): nothing under
`~/.claude/projects/-home-kooshi-source-lean-dir/` at all (every `*.jsonl`, `subagents/`, `memory/`), nothing under `chats-bak/` in the
repository, nothing under `/tmp/claude-1000/` outside your own scratchpad; and never `git log -p`, `git show` or `git diff` on a fenced path.

**Do not open, until your stage 3 is committed:**
- **the three existing proofs and everything around them:** `plans/FS100-X01D-derivation.md`, `plans/FS100-X01V-verification.md`,
  `plans/FS100-X12B-derivation.md`, and **every other `plans/FS100-*` file** (in particular `plans/FS100-derivation.md`, whose FS100-EFP entry
  sketches the proofs, and `plans/FS100-three-field-lemma.md`); `plans/CRUNCH-2026-09-26-x2x3-*`; `plans/POROS-2026-09-26-*`;
- **the directories** `data/crunch-2026-09-26-x2x3/`, `data/consolidation-2026-09-26/`, `data/fs100/`, `data/fs103/`, `data/rerank-2026-09-26/`,
  and `data/fs105/` except `data/fs105/claims.md`, `data/fs105/briefs/STANDING-RULES.md`, this brief and your own `data/fs105/fs105-b/`;
- `plans/FS105-*` except your own record; `plans/FS103-*`; `plans/FRONTIER-STUBS.md`; the stubs `plans/STUB-harden-mr.md`,
  `STUB-measure-rigidity-three-fields.md`, `STUB-main-clause-five-kernel.md`, `STUB-collapse-cp-plane.md`, `STUB-cp-plane-six.md`;
  `plans/SESSION-HANDOFF-*`;
- the tools `tools/x0*`, `tools/x1*`, `tools/x2*`, `tools/fs103_*`, `tools/fs105_*` other than yours;
- the bodies and diffs of commits whose subjects start "X01D", "X01V", "X12B", "X09C", "X24R", "X10F", "C2", "C3", "FS103", "FS105-P", "FS105-A",
  "FS105-R", "FS105-W" (subjects are shown by the harness; do not read bodies).

**Grep rule:** if a grep shows you a line containing `EF_F⁺`, `EFP`, `Lemma PF`, `3.1′`, `3.2′`, `X12B`, `Lemma Z`, `UZ`,
`wandering shell`, `local injectivity`, `two-scale` or `ℓ₁e₂` in a file not open to you by the lists
above, do not open that file. **Open:** `CLAUDE.md`; `LEDGER.md` (rows state results; a row naming a fenced record is not the record);
`BIBLIOGRAPHY.md`; `~/source/library/` — above all **`[EinsiedlerFish2010]`**
(`~/source/library/pdf/EinsiedlerFish2010-rigidity-measures-multiplicative-semigroup-polynomial-growth.pdf`, the method's source); the band-rigidity
and `R = O′` derivations for notation (`plans/FS89-derivation.md`, `plans/FS91-derivation.md`, `plans/R88-derivation.md`, `plans/FS84-SI-D-derivation.md`).

You never contact the other FS-105 jobs, the planner or the advisor (a covert channel breaks blindness). Only `"main"`.

## Your claim (from `data/fs105/claims.md` (b))

EF_F⁺ at `F = ℚ(√635087)`, verbatim there. **And a second, weaker statement** (owner's addition): **EF_F⁰** — *"`U`-ergodic, `h_μ(u) = 0` for every
`u` ⟹ `μ(E) = 1`"* (the advisor's wording) — derive it too and give it its own verdict: a GAP in the strong form alone is not a GAP in this one. **Before stage 2's derivation**, write in your record: the setting at this field from your own PARI
(seconds) — `L = F(i)`, its places, the split and inert primes, the archimedean places, `R = ℤ[U]` and whether `R = O′` (no stable dyadic place);
your model of `R̂`; the statement in your own words; **your wrong-reason line** (what a TRUE for a wrong reason would look like) and **your
control** (a case where you know the answer, e.g. `F = ℚ`, where the statement should reduce to a circle-type theorem you can state, or a
subgroup of `U` for which the conclusion must fail — say which and why before you derive).

## Stages

1. Quotation check of `data/fs105/claims.md` (b) and §0 against every source open to you (a fenced source: "deferred to stage 4"); the setting,
   C0 (your probability, and the step where a failure is most likely), the wrong-reason line and the control. Save.
2. The derivation, every step with its quantifiers, at `F₁`; exact checks of seconds under `tools/fs105_b_*.py` with a plant each. Save when the
   derivation's core step is written, and again at its end. Name the invariant the proof runs on (`CLAUDE.md` G72, G79) in your own words.
3. The write-up: TRUE / FALSE / GAP at a named step / MISSTATED with the corrected statement; your grade and count of minds; the step you found
   hardest; **commit it before opening anything fenced.** Save.
4. Only after stage 3: read `plans/FS100-X01D-derivation.md` §3, `plans/FS100-X12B-derivation.md` §2 and `plans/FS100-X01V-verification.md`
   §2.3 and §4, and record divergences of route and of truth, step by step. Save; the report.

**Stop rule:** at 220k harness tokens, finish the current step, save, report. Rigor over coverage.

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about.
- **The ban** (standing rule 3): no finite-witness search; PARI and exact arithmetic of seconds are in. Keep a "would have searched here" log.
- **Touch only** `plans/FS105-B-derivation.md`, `data/fs105/fs105-b/` and `tools/fs105_b_*.py`. Record with "Theorems this phase proved".
- **Commits:** by explicit path, subjects "FS105-B: stage n" (neutral); never amend; push; never force-push.
- **Report** (standing rule 9) to `data/fs105/reports/FS105-B.md`, committed, and by SendMessage to "main". Final turn text:
  "FS105-B idle; report sent to the owner by SendMessage".

Thank you.
