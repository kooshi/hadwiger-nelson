# Brief FS121-V4 — a blind second mind on the cover route's lemmas (FS-121's list § 7)

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS121-V4
  identity: Ephodos in its verification form — your agent file (`.claude/agents/ephodos-verifier.md`) is your identity, your lane's workflow, and the `ephodos-verification` procedure preloaded beside it; `ephodos-recognition` and `ephodos-invention` are yours to invoke fresh with the Skill tool if you choose
  role: blind verifier of five fixed statements; blind, the same model as the minds whose work you may later compare against (Opus 5.5)
  launch: now, beside FS-121's derivation job FS121-D4 and verifier FS121-V3 (other claims of the same list) and FS-116's jobs
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: § Fences
  channel: message the coordinator ("main") by SendMessage with any question mid-flight, including any question of which reading a statement means; the report goes to `data/fs121/reports/FS121-V4.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS121-V4-verification.md`
  touches: `plans/FS121-V4-verification.md`, `data/fs121/v4/`, `tools/fs121_v4_*.py`, `data/fs121/reports/FS121-V4.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are the second mind on five statements. Another mind works the same list; nothing more about that work is yours until your
own verdicts are committed.

## Why this job

FS-121 asks whether a tight colouring of the plane can be replaced by a map bounded by segments and circular arcs: route M's second half
toward seven colours. Its cover route was opened tonight and its NO stated (the list's § 7); the five lemmas below relate that NO to the answer
and to FS-116's question, and they decide how the route is aimed. Before anything rests on them, this project wants a blind mind to re-derive
each statement fixed in advance. The record shows where hand derivations here fail: the sentence claims more than the argument carried. So
attack each statement, not only its steps. TRUE, FALSE with a counterexample, GAP at a named step and MISSTATED are all results. Two are about
objects given by formula (DISC7's merged map; germs of curves): an exact check of your own, with a planted fault that fires, is welcome.

## The statements

Derive or refute each, exactly as written, with its *not claimed* line as part of it. The definitions they use are the list's § 7.0 and § 0;
its § 1 holds the inputs you may use as held, at the grades given there.

> - **C121-C1-BOUND** (this addendum): in a locally finite map colouring, a point `x` of `F_i ∖ S_i` is `i`-bound if and only if it lies on the outer unit
>   parallel or on the far level of a connected component of `F_i`.
>   *Not claimed:* which of the two levels, or that the component is unique. *Inhabitants:* `k = 7`, R7; `k = 9`, SQ9.
> — source: data/fs121/claims.md § 7.2 Lemmas (every `k`)

> - **C121-C1-GMAP** (this addendum): (i) for every `k`, a Grundy-bound `k`-colouring that is a.e. equal to a locally finite map colouring makes that map
>   colouring a member of `𝒫_k` under the order `1 < 2 < … < k`; (ii) G-FIN₆ and C121-NOPAR together imply `χ_m⁰(ℝ²) ≥ 7`, and given C121-NOPAR, G-FIN₆
>   holds if and only if `χ_m⁰(ℝ²) ≥ 7`.
>   *Not claimed:* G-FIN₆; that a Grundy-bound colouring of a map colouring is again a map colouring. *Inhabitants of (i):* `k = 7`, R7 (every class a MUA
>   set).
> — source: data/fs121/claims.md § 7.2 Lemmas (every `k`)

> - **C121-C1-SAT** (this addendum): for every `k`, a locally finite map colouring with `k` colours whose edges are finite chains of segments and circular
>   arcs, and whose classes form an honest saturated colouring, is a member of `𝒫_k` under every total order of its colours; so C121-NOPAR implies that no
>   honest saturated six-colouring is a.e. equal to a locally finite map colouring whose edges are finite chains of segments and circular arcs.
>   *Not claimed:* the converse (a member of `𝒫_k` need not be saturated). *Inhabitants:* `k = 7`, R7; `k = 9`, SQ9 and HEX9.
> — source: data/fs121/claims.md § 7.2 Lemmas (every `k`)

> - **C121-C1-COVMAP** (this addendum): under every total order of the seven colours, DISC7's merged map (the faces coloured by the least colour, in that
>   order, of a disc containing them) has an edge point that is bound by neither of the two colours the edge separates; so it lies in `𝒫_7` under no order.
>   *Not claimed:* anything about other maximal covers, or about DISC7's classes themselves (each disc is its own far level). *Colours:* seven, a
>   statement about one object.
> — source: data/fs121/claims.md § 7.2 Lemmas (every `k`)

> - **C121-C1-FLAT** (this addendum): there are germs `L_k`, `U_k` at `P_k`, for every `k ∈ ℤ`, with `U_k > L_k` on both sides of `P_k`, every one of
>   curvature 0 at `P_k`, such that for every `k`: `L_k` is the unit parallel toward `P_k` of `L_{k+1}`, and `U_k` is the unit parallel toward `P_k` of
>   `U_{k−1}`. (So the relations `plans/FS110-derivation.md` states on circular arcs as "No bi-infinite sequence `−1 < λ_k < υ_k < 1` with `λ_k ≤
>   f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`", read on germs with `L_k` below the parallel of `L_{k+1}` and `U_k` above the parallel of `U_{k−1}`, hold with
>   equality for every `k`, and `λ_k = υ_k = 0`.)
>   *Not claimed:* that any locally finite map colouring realises these germs; anything about the other steps of row 134's chain on smooth boundaries.
>   *Colours:* none (a statement about germs of curves).
> — source: data/fs121/claims.md § 7.2 Lemmas (every `k`)

## What you may read

The list `data/fs121/claims.md` (in `data/fs121/`, only it and your own `data/fs121/v4/` are open to you); `CLAUDE.md`; the
grokkings (preloaded); `LEDGER.md`; the held papers (`BIBLIOGRAPHY.md`, `~/source/library/`); and the held inputs' homes from earlier
milestones: `plans/FS106-*.md`, `plans/FS107-*.md`, `plans/FS110-*.md`, `plans/FS111-*.md`, `plans/FS112-*.md`, `plans/FS114-*.md` and
their `data/` directories, except the one FS-111 file § Fences names. Anything not named here and not in § Fences: ask before reading.

## Fences

Until your verdicts on all three statements are committed, do not read any of these (and never `git log -p` or `git show` on them, nor the
bodies of their commits):
- FS-121's plan and records: `plans/FS121-map-step.md`, `plans/FS121-D1-proof.md`, `plans/FS121-DB1-verification.md`,
  `plans/FS121-D2-proof.md`, `plans/FS121-D3-proof.md`, `plans/FS121-D4-proof.md`, `plans/FS121-V2-verification.md`,
  `plans/FS121-V3-verification.md`, `plans/FS121-C1-proof.md`,
  `plans/FS121-close-inventory.md`; the directories `data/fs121/briefs/`, `data/fs121/reports/`, `data/fs121/o1/`, `data/fs121/d1/`,
  `data/fs121/db1/`, `data/fs121/d2/`, `data/fs121/d3/`, `data/fs121/d4/`, `data/fs121/v2/`, `data/fs121/v3/`, `data/fs121/c1/`; tools named `tools/fs121_*` other than yours.
- FS-121's stub and the question records: `plans/STUB-map-step.md`, `plans/POROS-2026-09-28-fs116-question.md`,
  `plans/POROS-2026-09-28-close-reread.md`.
- FS-116's plan and records, where two of these statements were passed as inputs: `plans/FS116-local-exclusion.md`,
  `plans/FS116-N1-proof.md`, `plans/FS116-Y1-construction.md`, `plans/FS116-Y2-construction.md`, `plans/FS116-V1-verification.md`,
  `plans/FS116-V2-verification.md`,
  `plans/FS116-close-inventory.md`, the directory `data/fs116/`, and `plans/STUB-local-exclusion.md`.
- FS-111's W-NOREP proof, which the first statement strengthens: `plans/FS111-W-wild.md`.
- The session transcripts (`~/.claude/projects/`, `chats-bak/`), the coordinator's scratch, and any other job's scratch directory.

If a search prints fenced text, stop reading and log the touch at once (standing rule 8).

## After your verdicts

Once your verdicts on all five are committed, your second phase opens the first derivations for the divergence table: the cover route's
proof record, §§ 2.1–2.5 (its path is in § Fences). Nothing else in the fence opens.

## Done means

1. **Your record**, `plans/FS121-V4-verification.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS121-V4-verification.md` from the repository root before each stage's commit, holding your procedure's sections: the
   readback, your expected verdict with its probability for each statement before any derivation, your derivation or stall, the attack
   on each statement, one `verification:` block per statement, and, after the verdicts' commit, the divergence table with every
   divergence classed.
2. **The report** in the standing rules' form, one RESULT line per statement with your count of minds ("blind, the same model").

## What is yours to decide

Your route, your order, and your verdicts. If a statement is ambiguous, ask "main" which reading is meant and I will ask its author. If
a statement is wrong as posed, MISSTATED with the corrected statement is a finding, not a failure.

## Stages (save and commit each; standing rule 2)

1. The readback and the registered expectations.
2. The five statements: derivations, attacks, verdicts committed (split across two stages if long).
3. The divergence table, then the report.

Thank you.
