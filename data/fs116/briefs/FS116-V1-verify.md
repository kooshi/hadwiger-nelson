# Brief FS116-V1 — a blind second mind on three claims of FS-116's frozen list

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-V1
  identity: Ephodos in its verification form — your agent file (`.claude/agents/ephodos-verifier.md`) is your identity, your lane's workflow, and the `ephodos-verification` procedure preloaded beside it; `ephodos-recognition` and `ephodos-invention` are yours to invoke fresh with the Skill tool if you choose
  role: blind verifier of three fixed statements; blind, the same model as the minds whose work you may later compare against (Opus 5.5)
  launch: now, beside two derivation jobs of FS-116 (FS116-N1, FS116-Y1) and two jobs of FS-121, all working other claims
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: § Fences
  channel: message the coordinator ("main") by SendMessage with any question mid-flight, including any question of which reading a statement means; the report goes to `data/fs116/reports/FS116-V1.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS116-V1-verification.md`
  touches: `plans/FS116-V1-verification.md`, `data/fs116/v1/`, `tools/fs116_v1_*.py`, `data/fs116/reports/FS116-V1.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are the second mind on three statements. Another mind works the same list; nothing more about that work is yours until your
own verdicts are committed.

## Why this job

FS-116 asks whether an explicit radius exists within which no valid six-coloured fragment with unit arcs survives about a vertex of at
least four colours (`data/fs116/claims.md` § 1). Its plan builds on the first two statements below, and FS-114's close left the third
owed a second mind before anything final rests on it. Before Lean's kernel sees a result, this project trusts a blind mind re-deriving a
statement fixed in advance, and the record shows where hand derivations here fail: the sentence claims more than the argument carried.
So attack each statement, not only its steps. TRUE, FALSE with a counterexample, GAP at a named step and MISSTATED are all results.

## The statements

Derive or refute each, exactly as written, with its *not claimed* line as part of it. The definitions they use are the frozen list's
§ 0, and `data/fs114/claims.md` §§ 0, 6 where the list does not restate them.

> - **FS116-O1-YESLIM** *(proposed at the opening)*: "for every k ≥ 1, if for every R > 0 some closed disc of radius R carries a valid
>   k-coloured fragment (a map of an open set containing the disc, bounded by segments and circular arcs, k-coloured with no two interior points of one colour at
>   distance exactly 1), then χ_m⁰(ℝ²) ≤ k; at k = 6, then χ(ℝ²) ≤ 6, with no MR". *Not claimed:* the converse; that the limit colouring is a map, saturated or
>   regular; anything about the fragments' centres; anything from fragments on discs of one bounded radius.
> — source: data/fs116/claims.md § 3. Two claims from the opening

> - **FS116-O1-SATPIN** *(proposed at the opening)*: "let p be a vertex of at least four colours of a valid k-coloured fragment saturated
>   on a disc about p, every tile at p with a cone of positive angle; each edge e at p, with side colours a (clockwise) and b (counter-clockwise) and unit normal
>   ν pointing to b's side, is near p of exactly one of two types — (split) an arc of the unit circle about a point y of ω(p) at which both a and b have support,
>   a unit arc of kind both; or (tangent) a segment or an arc of radius at least 1 along which every x has x + ν(x) in the closure of colour a and x − ν(x) in the
>   closure of colour b, so that p + ν(p) carries a and p − ν(p) carries b, two antipodal points of ω(p) on the normal to e at p; and every colour of p is
>   carried on ω(p)". *Not claimed:* anything at a cusp at `p`; that the split centre has four colours; that any saturated valid six-coloured fragment about a
>   four-colour vertex exists; SAT-STRIP.
> — source: data/fs116/claims.md § 3. Two claims from the opening

> - **FS114-N7-3T** (`plans/FS114-derivation.md` § 3, verbatim): "**Three or more tactic edges at a degree-4 vertex with a (Q)-free ring are excluded at radius
>   `1 + ε`**, except the open-cap family **OC** (`+−+`, a Reuleaux lens beside a `60°` anti-lens; with a fourth tactic edge, the Reuleaux bowtie whose lenses
>   do not border the caps): the `(2, 1, 1, 0)` patterns, the pinwheel, `γ = 0°` and non-Reuleaux lenses, `++−`, `−++` die in every member (with N7-HUB: at a
>   four-colour vertex, non-Siamese and simple, whose ring is (Q)-free after the bends, each of the six change points `y_k` is a vertex of at least four colours:
>   the directions toward `p` there lie in tiles of `p` reaching `y_k`, a tip, which meets `B(y_{k−1},1) ∩ B(y_{k+1},1)`, so its colour is carried at `y_{k±1}`
>   by no other tile, and the outward directions in tiles of `p`'s colours outside `B̄(p,1)` whose `p`-tiles face away)". *Not claimed* (the entry's own line,
>   verbatim): "rings with (Q) arcs (N7-HUBQ, the tip with (Q) arcs allowed, needs the change point's ±60° points free of (Q) arcs — the named GAP); OC (its
>   forced structure N7-OCTB and a route to `√3`, not closed); the pinwheel's E1 and E2 in N7's readings R-E1, R-E2 (GAP; whether R-E2 is the construction
>   side's E2 is not settled, `plans/FS114-C-close.md` stage 2 §2.5)".
> — source: data/fs116/claims.md § 8. K — FS-114's owed second mind

The first two may be worked in either order; the third is the largest. Commit your verdicts on the first two before you begin the third,
so that a halt costs the third and never the first two.

## What you may read

The frozen list `data/fs116/claims.md` (in `data/fs116/`, only it and your own `data/fs116/v1/` are open to you) and `data/fs114/claims.md`; `CLAUDE.md`; the grokkings (preloaded); `LEDGER.md`; the held papers
(`BIBLIOGRAPHY.md`, `~/source/library/`); and the held inputs' own homes from milestones before FS-114: `plans/FS110-*.md`,
`plans/FS111-*.md`, `plans/FS112-*.md` and their `data/` directories. Anything not named here and not in § Fences: ask before reading.

## Fences

Until your verdicts on all three statements are committed, do not read any of these (and never `git log -p` or `git show` on them, nor the
bodies of their commits):
- FS-116's plan and its records: `plans/FS116-local-exclusion.md`, `plans/FS116-N1-proof.md`, `plans/FS116-Y1-construction.md`,
  `plans/FS116-close-inventory.md`; the directories `data/fs116/briefs/`, `data/fs116/reports/`, `data/fs116/o1/`, `data/fs116/n1/`
  and `data/fs116/y1/`; tools named `tools/fs116_*` other than yours.
- FS-116's stub and the question records: `plans/STUB-local-exclusion.md`, `plans/POROS-2026-09-28-fs116-question.md`,
  `plans/POROS-2026-09-28-close-reread.md`.
- FS-121's plan and records: `plans/FS121-map-step.md`, `plans/FS121-close-inventory.md`, everything under `data/fs121/`, and
  `plans/STUB-map-step.md`.
- FS-114's records, for the third statement: every file matching `plans/FS114-*`, and everything under `data/fs114/` except
  `data/fs114/claims.md`; `plans/STUB-route-t-count.md`.
- The session transcripts (`~/.claude/projects/`, `chats-bak/`), the coordinator's scratch, and any other job's scratch directory.
- Added by amendment 1: the Clerk's unvetted copy and its job files, `data/workflow3/cl2/`, `plans/WORKFLOW3-CL2-n7-definitions.md`,
  `data/workflow3/reports/CL2.md`, `data/workflow3/briefs/CL2-n7-definitions.md`, and `tools/cl2_extract.py`.

If a search prints fenced text, stop reading and log the touch at once (standing rule 8).

## After your verdicts

Once your verdicts on all three statements are committed, your second phase opens the first derivations for the divergence table: the
plan's § 3.4–3.5 and § 4.1–4.1a for the first two statements, and FS-114's N7 proof record with FS-114's derivation file § 3 for the third
(the paths are in § Fences). Nothing else in the fence opens.

## Done means

1. **Your record**, `plans/FS116-V1-verification.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS116-V1-verification.md` from the repository root before each stage's commit, holding your procedure's sections: the
   readback, your expected verdict with its probability for each statement before any derivation, your derivation or stall, the attack
   on each statement, one `verification:` block per statement, and, after the verdicts' commit, the divergence table with every
   divergence classed.
2. **The report** in the standing rules' form, one RESULT line per statement with your count of minds ("blind, the same model").

## What is yours to decide

Your route, your order within the rule above, and your verdicts. If a statement is ambiguous, ask "main" which reading is meant and
I will ask its author. If a statement is wrong as posed, MISSTATED with the corrected statement is a finding, not a failure.

## Stages (save and commit each; standing rule 2)

1. The readback and the registered expectations.
2. The first two statements: derivation, attack, verdicts committed.
3. The third: derivation, attack, verdict committed.
4. The divergence table, then the report.

Thank you.

## Amendment 1 (2026-09-29 05:59 UTC): the definitions you asked for, and the author's readings

Your questions of 2026-09-29 are answered in one file you may read: `data/fs116/v1-n7-definitions.md`. It holds the definitions for
N1–N7, copied verbatim from FS-114's records with their addresses and vetted by me to carry definitions only (its header says what was
cut and why), the entry's `statement:` and `not claimed:` fields, and the author's readings of SATPIN, as relayed:

> (S1) The reading a ≠ b is meant. An "edge" in the statement is a boundary arc between tiles of two different colours. A boundary arc between two tiles of one colour is not an edge in the statement's sense.
> — source: data/fs116/v1-n7-definitions.md § The author's readings of FS116-O1-SATPIN (relayed to FS116-V1 by message, 2026-09-29)

> (S2) The reading "one of" is meant: every edge is at least one of the two types. "Exactly one" is not meant to assert that no edge satisfies both descriptions as written.
> — source: data/fs116/v1-n7-definitions.md § The author's readings of FS116-O1-SATPIN (relayed to FS116-V1 by message, 2026-09-29)

Where the sources leave a term open (a four-colour vertex with exactly or at least four colours; how `ε` is quantified), they do not settle
it: state which reading you work, or both. The fence gains the Clerk's job files (§ Fences, last bullet). Unchanged: no agents of your own
(standing rule 1: staffing is Kooshi's budget, and I can review only work I know exists).
