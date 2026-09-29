# Brief FS121-V2 — a blind second mind on three round-2 claims of FS-121's list

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS121-V2
  identity: Ephodos in its verification form — your agent file (`.claude/agents/ephodos-verifier.md`) is your identity, your lane's workflow, and the `ephodos-verification` procedure preloaded beside it; `ephodos-recognition` and `ephodos-invention` are yours to invoke fresh with the Skill tool if you choose
  role: blind verifier of three fixed statements; blind, the same model as the minds whose work you may later compare against (Opus 5.5)
  launch: now, beside FS-121's derivation jobs FS121-D2 and FS121-D3 (other claims of the same list) and FS-116's jobs
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: § Fences
  channel: message the coordinator ("main") by SendMessage with any question mid-flight, including any question of which reading a statement means; the report goes to `data/fs121/reports/FS121-V2.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS121-V2-verification.md`
  touches: `plans/FS121-V2-verification.md`, `data/fs121/v2/`, `tools/fs121_v2_*.py`, `data/fs121/reports/FS121-V2.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are a further mind on three statements. Another mind works the same list; nothing more about that work is yours until your
own verdicts are committed.

## Why this job

FS-121 asks whether a tight colouring of the plane can be replaced by a map bounded by segments and circular arcs: route M's second half
toward seven colours. Two of its ladder-end statements, already held by two minds, rest in one step on the first statement below, which has
one mind; the other two are lemmas about corners and partner curves that another milestone is about to use. All three were added to the list
at round 2 (§ 5). Before anything rests on them, this project wants a blind mind to re-derive each statement fixed in advance, and the record
shows where hand derivations here fail: the sentence claims more than the argument carried. So attack each statement, not only its steps.
TRUE, FALSE with a counterexample, GAP at a named step and MISSTATED are all results. Note the list's vacuity rule: no held saturated colouring
has a curved tangent interface at any number of colours.

## The statements

Derive or refute each, exactly as written, with its *not claimed* line as part of it. The definitions they use are the list's § 0; its § 1
holds the inputs you may use as held, at the grades given there.

> - **DB1-L3** *(proposed at round 1)*: in an honest saturated colouring in D-NF satisfying REG-J′, at every point of Σ no colour occupies two sectors of positive angle, whatever cusps are present at the point or elsewhere *Not claimed:* that a colour cannot occupy a sector and a cusp, or two cusps, at one point; anything without REG-J′
> — source: data/fs121/claims.md § 5. Added at round 2

> - **FS121-D1-VT** *(proposed at round 1)*: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, let I be a tangent-type interface arc between colours a and b that is not a unit arc curving toward b, and L its unit parallel on b's side, which carries a on its far side; at the image Y on L of any interior point of I, no interface arc ends at Y from the far side of L *Not claimed:* anything at the image of an endpoint of I (the far-side colour may change there); anything when I is a unit arc curving toward b (L is a point, the (Q) or (R2) end); anything with cusps (NOREP's hypothesis)
> — source: data/fs121/claims.md § 5. Added at round 2

> - **FS121-D1-EROSION** *(proposed at round 1)*: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, if a colour's sector at a point z has angle θ in (0, π) and both its edges begin with maximal straight pieces of the colour's tile boundary of lengths L₁ and L₂, then min(L₁, L₂) ≤ cot(θ/2), or each of the two pieces has a point of Σ at distance cot(θ/2) from z *Not claimed:* anything for curved edges (their partner curves cross elsewhere, and FS121-D1-VT still forbids the crossing at images of interior points); anything at θ ≥ π; anything with cusps
> — source: data/fs121/claims.md § 5. Added at round 2

## What you may read

The list `data/fs121/claims.md` (in `data/fs121/`, only it and your own `data/fs121/v2/` are open to you); `CLAUDE.md`; the
grokkings (preloaded); `LEDGER.md`; the held papers (`BIBLIOGRAPHY.md`, `~/source/library/`); and the held inputs' homes from earlier
milestones: `plans/FS106-*.md`, `plans/FS107-*.md`, `plans/FS110-*.md`, `plans/FS111-*.md`, `plans/FS112-*.md`, `plans/FS114-*.md` and
their `data/` directories, except the one FS-111 file § Fences names. Anything not named here and not in § Fences: ask before reading.

## Fences

Until your verdicts on all three statements are committed, do not read any of these (and never `git log -p` or `git show` on them, nor the
bodies of their commits):
- FS-121's plan and records: `plans/FS121-map-step.md`, `plans/FS121-D1-proof.md`, `plans/FS121-DB1-verification.md`,
  `plans/FS121-D2-proof.md`, `plans/FS121-D3-proof.md`, `plans/FS121-close-inventory.md`; the directories `data/fs121/briefs/`,
  `data/fs121/reports/`, `data/fs121/o1/`, `data/fs121/d1/`, `data/fs121/db1/`, `data/fs121/d2/`, `data/fs121/d3/`; tools named
  `tools/fs121_*` other than yours.
- FS-121's stub and the question records: `plans/STUB-map-step.md`, `plans/POROS-2026-09-28-fs116-question.md`,
  `plans/POROS-2026-09-28-close-reread.md`.
- FS-116's plan and records, where two of these statements were passed as inputs: `plans/FS116-local-exclusion.md`,
  `plans/FS116-N1-proof.md`, `plans/FS116-Y1-construction.md`, `plans/FS116-V1-verification.md`, `plans/FS116-V2-verification.md`,
  `plans/FS116-close-inventory.md`, the directory `data/fs116/`, and `plans/STUB-local-exclusion.md`.
- FS-111's W-NOREP proof, which the first statement localises: `plans/FS111-W-wild.md`.
- The session transcripts (`~/.claude/projects/`, `chats-bak/`), the coordinator's scratch, and any other job's scratch directory.

If a search prints fenced text, stop reading and log the touch at once (standing rule 8).

## After your verdicts

Once your verdicts on all three are committed, your second phase opens the first derivations for the divergence table: the round-1
verification record § 2.3 for the first statement, and the round-1 proof record §§ 1.3, 2.1–2.2 for the other two (their paths are in
§ Fences). Nothing else in the fence opens.

## Done means

1. **Your record**, `plans/FS121-V2-verification.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS121-V2-verification.md` from the repository root before each stage's commit, holding your procedure's sections: the
   readback, your expected verdict with its probability for each statement before any derivation, your derivation or stall, the attack
   on each statement, one `verification:` block per statement, and, after the verdicts' commit, the divergence table with every
   divergence classed.
2. **The report** in the standing rules' form, one RESULT line per statement with your count of minds ("blind, the same model").

## What is yours to decide

Your route, your order, and your verdicts. If a statement is ambiguous, ask "main" which reading is meant and I will ask its author. If
a statement is wrong as posed, MISSTATED with the corrected statement is a finding, not a failure.

## Stages (save and commit each; standing rule 2)

1. The readback and the registered expectations.
2. The three statements: derivations, attacks, verdicts committed (split across two stages if long).
3. The divergence table, then the report.

Thank you.
