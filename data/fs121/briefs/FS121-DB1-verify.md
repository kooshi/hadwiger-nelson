# Brief FS121-DB1 — a blind second mind on four claims of FS-121's frozen list

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS121-DB1
  identity: Ephodos in its verification form — your agent file (`.claude/agents/ephodos-verifier.md`) is your identity, your lane's workflow, and the `ephodos-verification` procedure preloaded beside it; `ephodos-recognition` and `ephodos-invention` are yours to invoke fresh with the Skill tool if you choose
  role: blind verifier of four fixed statements; blind, the same model as the minds whose work you may later compare against (Opus 5.5)
  launch: now, beside FS-121's derivation job FS121-D1 (other claims of the same list) and three jobs of FS-116
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: § Fences
  channel: message the coordinator ("main") by SendMessage with any question mid-flight, including any question of which reading a statement means; the report goes to `data/fs121/reports/FS121-DB1.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS121-DB1-verification.md`
  touches: `plans/FS121-DB1-verification.md`, `data/fs121/db1/`, `tools/fs121_db1_*.py`, `data/fs121/reports/FS121-DB1.md`
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the second mind on four statements. Another mind works the same list; nothing more about that work is yours until your
own verdicts are committed.

## Why this job

FS-121 asks whether a tight colouring of the plane can be replaced by a map bounded by segments and circular arcs: route M's second half
toward seven colours. Its round of derivations builds on the four statements below, all about the ends of the "ladders" (families of
unit-parallel interface curves) in a saturated colouring. Before Lean's kernel sees a result, this project trusts a blind mind
re-deriving a statement fixed in advance, and the record shows where hand derivations here fail: the sentence claims more than the
argument carried. So attack each statement, not only its steps. TRUE, FALSE with a counterexample, GAP at a named step and MISSTATED are
all results. Note the frozen list's vacuity rule: no held saturated colouring has a curved tangent interface at any number of colours, and
two of these statements say so of their own class.

## The statements

Derive or refute each, exactly as written, with its *not claimed*, *Colours* and *Inhabitant* lines as part of it. The definitions they
use are the frozen list's § 0; its § 1 holds the inputs you may use as held, at the grades given there.

> - **C121-ENDS** (this list): in an honest saturated colouring in D-NF satisfying REG-J′, the chain of unit parallels of an interface arc of finite radius
>   ends, off a null set of normals, at a unit arc J_1 whose centre z carries J_1's outer colour; either z also carries J_1's inner colour — J_1 is of kind
>   both and z is a vertex with at least four colours or a repeated colour, at least four when no colour at z has density 0, so J_1 is (Q) — or it does not
>   — J_1 is (R2), and z is a point of Σ carrying at least three colours, and at least three distinct colours when no colour at z has density 0.
>   *Not claimed:* that every chain ends at a (Q) arc; that an (R2) end exists in any saturated colouring; that an (R2) centre has four colours.
>   *Colours:* every `k`. *Inhabitant:* `k = 7`, R7 (every interface a split unit arc; its centres carry six colours, with cusps).
> — source: data/fs121/claims.md § 2. The ladder ends

> - **C121-OUT** (this list): in an honest saturated colouring in D-NF satisfying REG-J′, the unit parallel away from the centre of every tangent-type
>   interface arc of radius n (n a positive integer, or infinite for a segment) is, off Σ, a tangent-type interface arc of radius n + 1; so every curved
>   interface of tangent type lies in a one-sided infinite family of concentric interface arcs of radii n, n + 1, n + 2, … over one angular window.
>   *Not claimed:* that a saturated colouring with a curved tangent interface exists. *Colours:* every `k`. *Inhabitant:* `k = 9`, SQ9 (the flat case,
>   `n` infinite); **none held for the curved case at any `k`**.
> — source: data/fs121/claims.md § 2. The ladder ends

> - **C121-PER** (this list): in an honest saturated colouring in D-NF satisfying REG-J′ whose interfaces carry only finitely many radii of curvature — in
>   particular a doubly periodic one satisfying ¬LRA — every curved interface is a split unit arc of kind both and no (R2) arc occurs; where no colour has
>   density 0 at an arc's centre, every such arc is (Q).
>   *Not claimed:* that a tight colouring can be taken periodic. *Colours:* every `k`. *Inhabitant:* `k = 7`, R7.
> — source: data/fs121/claims.md § 2. The ladder ends

> - **C121-LRA-LINE** (this list): in an honest saturated colouring in D-NF satisfying REG-J′, if interface pieces of radii tending to infinity accumulate at
>   a point x₀ of an interface curve with normal ν there, then pieces of radii tending to infinity accumulate at x₀ + kν for every integer k.
>   *Not claimed:* that such a line is impossible. *Colours:* every `k`. *Inhabitant:* **none held** (no held saturated colouring has LRA; the statement is
>   a reduction).
> — source: data/fs121/claims.md § 2. The ladder ends

## What you may read

The frozen list `data/fs121/claims.md` (in `data/fs121/`, only it and your own `data/fs121/db1/` are open to you); `CLAUDE.md`; the
grokkings (preloaded); `LEDGER.md`; the held papers (`BIBLIOGRAPHY.md`, `~/source/library/`); and the held inputs' homes from earlier
milestones: `plans/FS106-*.md`, `plans/FS107-*.md`, `plans/FS110-*.md`, `plans/FS111-*.md`, `plans/FS112-*.md`, `plans/FS114-*.md` and
their `data/` directories. Anything not named here and not in § Fences: ask before reading.

## Fences

Until your verdicts on all four statements are committed, do not read any of these (and never `git log -p` or `git show` on them, nor the
bodies of their commits):
- FS-121's plan and records: `plans/FS121-map-step.md`, `plans/FS121-D1-proof.md`, `plans/FS121-close-inventory.md`; the directories
  `data/fs121/briefs/`, `data/fs121/reports/`, `data/fs121/o1/` and `data/fs121/d1/`; tools named `tools/fs121_*` other than yours.
- FS-121's stub and the question records: `plans/STUB-map-step.md`, `plans/POROS-2026-09-28-fs116-question.md`,
  `plans/POROS-2026-09-28-close-reread.md`.
- FS-116's plan and records, which discuss these statements: `plans/FS116-local-exclusion.md`, `plans/FS116-N1-proof.md`,
  `plans/FS116-Y1-construction.md`, `plans/FS116-V1-verification.md`, `plans/FS116-close-inventory.md`, the directory `data/fs116/`, and
  `plans/STUB-local-exclusion.md`.
- The session transcripts (`~/.claude/projects/`, `chats-bak/`), the coordinator's scratch, and any other job's scratch directory.

If a search prints fenced text, stop reading and log the touch at once (standing rule 8).

## After your verdicts

Once your verdicts on all four are committed, your second phase opens the first derivations for the divergence table: FS-121's plan,
§ 3.2–3.4 (the paths are in § Fences). Nothing else in the fence opens.

## Done means

1. **Your record**, `plans/FS121-DB1-verification.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS121-DB1-verification.md` from the repository root before each stage's commit, holding your procedure's sections: the
   readback, your expected verdict with its probability for each statement before any derivation, your derivation or stall, the attack
   on each statement, one `verification:` block per statement, and, after the verdicts' commit, the divergence table with every
   divergence classed.
2. **The report** in the standing rules' form, one RESULT line per statement with your count of minds ("blind, the same model").

## What is yours to decide

Your route, your order, and your verdicts. If a statement is ambiguous, ask "main" which reading is meant and I will ask its author. If
a statement is wrong as posed, MISSTATED with the corrected statement is a finding, not a failure.

## Stages (save and commit each; standing rule 2)

1. The readback and the registered expectations.
2. The four statements: derivations, attacks, verdicts committed (split across two stages if long).
3. The divergence table, then the report.

Thank you.
