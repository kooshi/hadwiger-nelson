# Brief FS116-V2 — a blind second mind on three round-2 claims of FS-116's list

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-V2
  identity: Ephodos in its verification form — your agent file (`.claude/agents/ephodos-verifier.md`) is your identity, your lane's workflow, and the `ephodos-verification` procedure preloaded beside it; `ephodos-recognition` and `ephodos-invention` are yours to invoke fresh with the Skill tool if you choose
  role: blind verifier of three fixed statements; blind, the same model as the minds whose work you may later compare against (Opus 5.5)
  launch: now, beside FS-116's derivation jobs (a successor on FS116-N1's brief, and FS116-Y1) and FS-121's jobs, all working other claims
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: § Fences
  channel: message the coordinator ("main") by SendMessage with any question mid-flight, including any question of which reading a statement means; the report goes to `data/fs116/reports/FS116-V2.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS116-V2-verification.md`
  touches: `plans/FS116-V2-verification.md`, `data/fs116/v2/`, `tools/fs116_v2_*.py`, `data/fs116/reports/FS116-V2.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are the second mind on three statements. Another mind works the same list; nothing more about that work is yours until your
own verdicts are committed.

## Why this job

FS-116 asks whether an explicit radius exists within which no valid six-coloured fragment with unit arcs survives about a vertex of at
least four colours (`data/fs116/claims.md` § 1). Its next phase follows the ring of such a vertex (the unit circle about it) outward to a
contradiction, and it builds on the three statements below, which were added to the list at round 2 (§ 10). Before anything rests on them,
this project wants a blind mind to re-derive each statement fixed in advance. The record shows where hand derivations here fail: the
sentence claims more than the argument carried. So attack each statement, not only its steps. TRUE, FALSE with a counterexample, GAP at a
named step and MISSTATED are all results.

## The statements

Derive or refute each, exactly as written, with its *not claimed* line as part of it. The definitions they use are the list's § 0, and
`data/fs114/claims.md` §§ 0, 6 where the list does not restate them.

> - **RING-GERM** *(proposed at round 1)*: in a non-Siamese valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y be a change point of the ring, X the colour of the ring just counter-clockwise of y and X̄ the colour just clockwise, and u⁻, u⁺, v⁻, v⁺ the arcs of ω(p) just clockwise and just counter-clockwise of the ring points y + 60° and y − 60°; then p has four colours and no more, X and X̄ are the colours absent at p, and (i) if neither v⁻ nor u⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction to p lies in the cone of a tile of p; (ii) if neither u⁻ nor v⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction away from p lies in the cone of a tile of a colour of p that is not a tile of p; (iii) if none of the four lies on a (Q) arc, y is a vertex of at least four colours *Not claimed:* anything at k ≥ 7; that a change point with a germ on a (Q) arc has fewer than four colours (the strip's P₂ has four, with u⁺ and v⁻ on (Q) arcs); that the ring's change points are 60° apart (N6-RING60's conclusion, for (Q)-free rings)
> — source: data/fs116/claims.md § 10. Added at round 2

> - **RING-TWIST-C** *(proposed at round 1)*: at a vertex p of at least four colours of a valid fragment on a closed disc of radius above 1 about p (Siamese pairs allowed, any degree), the set D of points of ω(p) in the closure of a tile of one of p's colours is closed and lies in the union of the arcs of Γ on ω(p) and finitely many points; and for every half-open 60° window W of ω(p) with W ∪ σ(W) disjoint from D: p has four colours and no more; off a finite set, every point of W ∪ σ(W) lies in the closures of tiles of a single colour, one of the two colours absent at p, and this colour differs at θ and at θ + 60° for θ in W; every arc of Γ on ω(p) meeting W ∪ σ(W) in an arc has one colour on both sides; W holds an odd number of colour changes — points of W at which that colour differs on the two sides — each lying in the closures of tiles of the two absent colours and of no other colour; every change point in W is a colour change, and a colour change in W that is not a change point lies on an arc of Γ on ω(p) with one colour on both sides; so W holds an odd number of change points when no such arc meets W, in particular in every non-Siamese simple fragment *Not claimed:* anything at k ≥ 7; that any fragment of the class has a qualifying window (no held fragment has one: the strip's and the disk's D-free arcs are at most 60° and 87.83°); the parity of change points when a seam meets W (FS116-N1-TWIST-LIT: then it can fail)
> — source: data/fs116/claims.md § 10. Added at round 2

> - **FS116-N1-TWIST-LIT** *(proposed at round 1)*: RING-TWIST's parity clause as posed — every half-open 60° window W of ω(p) with W ∪ σ(W) disjoint from D holds an odd number of change points — holds on every fragment of RING-TWIST's class if and only if no fragment of that class has a half-open 60° window W with W ∪ σ(W) disjoint from D *Not claimed:* that the class has a fragment with a qualifying window; anything in the non-Siamese simple class, where the clause holds by RING-TWIST-C
> — source: data/fs116/claims.md § 10. Added at round 2

## What you may read

The list `data/fs116/claims.md` (in `data/fs116/`, only it and your own `data/fs116/v2/` are open to you), `data/fs114/claims.md` and
`plans/FS114-derivation.md` (its entries' statements; not the records their `argument:` lines point to); `CLAUDE.md`; the grokkings (preloaded); `LEDGER.md`; the held papers
(`BIBLIOGRAPHY.md`, `~/source/library/`); and the held inputs' own homes from milestones before FS-114: `plans/FS110-*.md`,
`plans/FS111-*.md`, `plans/FS112-*.md` and their `data/` directories. Anything not named here and not in § Fences: ask before reading.

## Fences

Until your verdicts on all three statements are committed, do not read any of these (and never `git log -p` or `git show` on them, nor the
bodies of their commits):
- FS-116's plan and records: `plans/FS116-local-exclusion.md`, `plans/FS116-N1-proof.md`, `plans/FS116-Y1-construction.md`,
  `plans/FS116-V1-verification.md`, `plans/FS116-close-inventory.md`; the directories `data/fs116/briefs/`, `data/fs116/reports/`,
  `data/fs116/o1/`, `data/fs116/n1/`, `data/fs116/y1/`, `data/fs116/v1/`, and the file `data/fs116/v1-n7-definitions.md`; tools named
  `tools/fs116_*` other than yours.
- FS-116's stub and the question records: `plans/STUB-local-exclusion.md`, `plans/POROS-2026-09-28-fs116-question.md`,
  `plans/POROS-2026-09-28-close-reread.md`.
- FS-121's plan and records: `plans/FS121-map-step.md`, `plans/FS121-close-inventory.md`, `plans/FS121-D1-proof.md`,
  `plans/FS121-DB1-verification.md`, the directories `data/fs121/briefs/`, `data/fs121/reports/`, `data/fs121/o1/`, `data/fs121/d1/`, and
  `plans/STUB-map-step.md`.
- FS-114's job records, which hold the routes of the statements these re-work: files matching `plans/FS114-N*`, `plans/FS114-Y*` and
  `plans/FS114-C*`, `plans/FS114-close-inventory.md`, `plans/FS114-L60-audit.md`, `plans/FS114-unit-arc-question.md`, and the directories
  matching `data/fs114/fs114-*`, `data/fs114/briefs/` and `data/fs114/reports/`.
- The Clerk's job files: `data/workflow3/cl2/`, `plans/WORKFLOW3-CL2-n7-definitions.md`, `data/workflow3/reports/CL2.md`.
- The session transcripts (`~/.claude/projects/`, `chats-bak/`), the coordinator's scratch, and any other job's scratch directory.

If a search prints fenced text, stop reading and log the touch at once (standing rule 8).

## After your verdicts

Once your verdicts on all three are committed, your second phase opens the first derivations for the divergence table: the round-1 proof
record, §§ 2–3 (its path is in § Fences). Nothing else in the fence opens.

## Done means

1. **Your record**, `plans/FS116-V2-verification.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS116-V2-verification.md` from the repository root before each stage's commit, holding your procedure's sections: the
   readback, your expected verdict with its probability for each statement before any derivation, your derivation or stall, the attack
   on each statement, one `verification:` block per statement, and, after the verdicts' commit, the divergence table with every
   divergence classed.
2. **The report** in the standing rules' form, one RESULT line per statement with your count of minds ("blind, the same model").

## What is yours to decide

Your route, your order, and your verdicts. If a statement is ambiguous, ask "main" which reading is meant and
I will ask its author. If a statement is wrong as posed, MISSTATED with the corrected statement is a finding, not a failure.

## Stages (save and commit each; standing rule 2)

1. The readback and the registered expectations.
2. RING-GERM: derivation, attack, verdict committed.
3. RING-TWIST-C and FS116-N1-TWIST-LIT: derivation, attack, verdicts committed.
4. The divergence table, then the report.

Thank you.
