# Brief FS121-V5 — a blind second mind on three round-3 claims of FS-121's list (§ 8)

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS121-V5
  identity: Ephodos in its verification form — your agent file (`.claude/agents/ephodos-verifier.md`) is your identity, your lane's workflow, and the `ephodos-verification` procedure preloaded beside it; `ephodos-recognition` and `ephodos-invention` are yours to invoke fresh with the Skill tool if you choose
  role: blind verifier of three fixed statements; blind, the same model as the minds whose work you may later compare against (Opus 5.5)
  launch: now, beside FS-116's jobs; no other FS-121 job runs
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: § Fences
  channel: message the coordinator ("main") by SendMessage with any question mid-flight, including any question of which reading a statement means; the report goes to `data/fs121/reports/FS121-V5.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS121-V5-verification.md`
  touches: `plans/FS121-V5-verification.md`, `data/fs121/v5/`, `tools/fs121_v5_*.py`, `data/fs121/reports/FS121-V5.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are the second mind on three statements. Another mind works the same list; nothing more about that work is yours until your
own verdicts are committed.

## Why this job

FS-121 asks whether a tight colouring of the plane can be replaced by a map bounded by segments and circular arcs: route M's second half
toward seven colours. Its rounds have run, and its two strongest partial results are one-mind: that no large-radius accumulation occurs in
any colouring with a cocompact symmetry, and that the singular set is locally finite in every grid colouring, through a facing lemma. They are
the milestone's last statements to check before its close (§ 8). This project wants a blind mind to re-derive each statement fixed in advance,
and the record shows where hand derivations here fail: the sentence claims more than the argument carried. So attack each statement, not
only its steps. TRUE, FALSE with a counterexample, GAP at a named step and MISSTATED are all results.

## The statements

Derive or refute each, exactly as written, with its *not claimed* line as part of it. The definitions they use are the list's § 0 (D-NF,
saturated, honest, Σ, REG-J′, LRA); its § 1 holds the inputs you may use as held, at the grades given there, and its §§ 2, 5–7 hold
statements already held by two minds (C121-ENDS, -OUT, -PER, -LRA-LINE, DB1-L3, FS121-V2-SECTOR, FS121-D3-GRUNDY, -FALLSAT, the § 7.2 lemmas).

> - **FS121-D2-SYM** *(proposed at round 3)*: in an honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, if for some integer r ≥ 2 the angular windows of its radius-r arcs are bounded below by a positive constant — in particular if it is invariant under a group of isometries of the plane, each mapping the partition to itself up to a permutation of the colours, with a compact set whose images cover the plane, such as a doubly periodic colouring — then ¬LRA holds *Not claimed:* ¬LRA without such a bound (C121-NOLRA's open step, § 3); that a tight colouring can be taken symmetric; anything from a bound at r = 1
> — source: data/fs121/claims.md § 8. Added at round 4

> - **FS121-D4-FACE** *(proposed at round 3)*: in an a.e.-proper measurable colouring, let x be a point, e a unit vector and e⊥ a unit vector orthogonal to it; if the open half-box {x − s e + t e⊥ : 0 < s < ε, |t| < ε} and the open box {x + s e + t e⊥ : g < s < g + ε′, |t| < ρ} both lie almost everywhere in one class S_c, with ε, ε′ > 0 and 0 < 2g < ρ², then no point of supp S_c is at distance exactly 1 from x; so in a saturated colouring the colour c has density 1 at x *Not claimed:* the same with a curved near side (a tangent unit disc in place of the half-box admits the in-contact x − e); the same without the lateral margin (2g ≥ ρ² is not covered); anything at an x where c has density 1; honesty, D-NF, REG-J′ (none is used)
> — source: data/fs121/claims.md § 8. Added at round 4

> - **FS121-D4-GRID** *(proposed at round 3)*: in every honest saturated a.e.-proper grid colouring with finitely many colours — closed countable sets B_x, B_y ⊂ ℝ, a.e. one colour on each open cell I × J of ℝ ∖ B_x by ℝ ∖ B_y, cells sharing an edge of positive length coloured differently — B_x and B_y are locally finite, so the singular set Σ is locally finite and each point of Σ meets at most four interface arcs *Not claimed:* B_x or B_y uncountable (a Cantor set of breakpoints: GAP there — at a gap's end c may have density 1 from the far side, where the facing lemma is silent); grid colourings in which adjacent cells may share a colour; any bound on the number of breakpoints per unit length
> — source: data/fs121/claims.md § 8. Added at round 4

## What you may read

The list `data/fs121/claims.md` (in `data/fs121/`, only it and your own `data/fs121/v5/` are open to you); `CLAUDE.md`; the
grokkings (preloaded); `LEDGER.md`; the held papers (`BIBLIOGRAPHY.md`, `~/source/library/`); and the held inputs' homes from earlier
milestones: `plans/FS106-*.md`, `plans/FS107-*.md`, `plans/FS110-*.md`, `plans/FS111-*.md`, `plans/FS112-*.md`, `plans/FS114-*.md` and
their `data/` directories, except the one FS-111 file § Fences names. Anything not named here and not in § Fences: ask before reading.

## Fences

Until your verdicts on all three statements are committed, do not read any of these (and never `git log -p` or `git show` on them, nor the
bodies of their commits):
- FS-121's plan and records: `plans/FS121-map-step.md`, `plans/FS121-D1-proof.md`, `plans/FS121-DB1-verification.md`,
  `plans/FS121-D2-proof.md`, `plans/FS121-D3-proof.md`, `plans/FS121-D4-proof.md`, `plans/FS121-V2-verification.md`,
  `plans/FS121-V3-verification.md`, `plans/FS121-V4-verification.md`, `plans/FS121-C1-proof.md`,
  `plans/FS121-close-inventory.md`; the directories `data/fs121/briefs/`, `data/fs121/reports/`, `data/fs121/o1/`, `data/fs121/d1/`,
  `data/fs121/db1/`, `data/fs121/d2/`, `data/fs121/d3/`, `data/fs121/d4/`, `data/fs121/v2/`, `data/fs121/v3/`, `data/fs121/v4/`, `data/fs121/c1/`; tools named `tools/fs121_*` other than yours.
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

Once your verdicts on all three are committed, your second phase opens the first derivations for the divergence table: the round-2 proof
record of large-radius accumulation, § 2, and the round-3 proof record of the singular set, §§ 2.1–2.2 (their paths are in § Fences).
Nothing else in the fence opens.

## Done means

1. **Your record**, `plans/FS121-V5-verification.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS121-V5-verification.md` from the repository root before each stage's commit, holding your procedure's sections: the
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
