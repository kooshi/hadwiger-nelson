# Brief FS116-V3 — a blind second mind on five round-3 claims of FS-116's list

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-V3
  identity: Ephodos in its verification form — your agent file (`.claude/agents/ephodos-verifier.md`) is your identity, your lane's workflow, and the `ephodos-verification` procedure preloaded beside it; `ephodos-recognition` and `ephodos-invention` are yours to invoke fresh with the Skill tool if you choose
  role: blind verifier of five fixed statements; blind, the same model as the minds whose work you may later compare against (Opus 5.5)
  launch: now, beside FS-116's derivation jobs FS116-N2 and FS116-Y2 and FS-121's jobs, all working other claims
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: § Fences
  channel: message the coordinator ("main") by SendMessage with any question mid-flight, including any question of which reading a statement means; the report goes to `data/fs116/reports/FS116-V3.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS116-V3-verification.md`
  touches: `plans/FS116-V3-verification.md`, `data/fs116/v3/`, `tools/fs116_v3_*.py`, `data/fs116/reports/FS116-V3.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are the second mind on five statements. Another mind works the same list; nothing more about that work is yours until your
own verdicts are committed.

## Why this job

FS-116 asks whether an explicit radius exists within which no valid six-coloured fragment with unit arcs survives about a vertex of at
least four colours, one radius for every complexity, Siamese pairs allowed (`data/fs116/claims.md` § 1). Its next phases follow the ring of
such a vertex outward, and they build on the five statements below, added to the list at round 3 (§ 11): two extend a ring lemma to fragments
with Siamese pairs, which the question allows, and three describe the configurations its saturated-class claims stall at. Before anything
rests on them, this project wants a blind mind to re-derive each statement fixed in advance. The record shows where hand derivations here
fail: the sentence claims more than the argument carried. So attack each statement, not only its steps. TRUE, FALSE with a counterexample,
GAP at a named step and MISSTATED are all results.

## The statements

Derive or refute each, exactly as written, with its *not claimed* line as part of it. The definitions they use are the list's § 0 (and its
§ 10's statements, which these extend), and `data/fs114/claims.md` §§ 0, 6 where the list does not restate them. "Change point" is read as the
list's § 10 reads it: the ring off Γ on both sides.

> - **FS116-N1-GERM-R** *(proposed at round 2)*: in a valid k-coloured fragment on a closed disc of radius above 1 about a point p, for any k, Siamese pairs allowed, let y = r(ψ) be a point of ω(p), c a colour, and v⁻, v⁺, u⁻, u⁺ the arcs of ω(p) just clockwise and just counter-clockwise of r(ψ − 60°) and r(ψ + 60°); if v⁻ lies in the closure of a tile of colour c, no tile of colour c approaches y along a direction β with β − ψ in (150°, 330°); for v⁺ the interval is (−30°, 150°), for u⁻ (−150°, 30°), and for u⁺ (30°, 210°) *Not claimed:* anything about tiles that approach y only along the boundary directions ψ + 150°, ψ + 330°, ψ − 30°, ψ + 30°, ψ + 210°, ψ − 150°; anything when a germ lies on Γ with colour c on neither side
> — source: data/fs116/claims.md § 11. Added at round 3

> - **FS116-N1-GERM-S** *(proposed at round 2)*: in a valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, Siamese pairs allowed, let y be a change point of the ring, X the colour of the ring just counter-clockwise of y and X̄ the colour just clockwise, and u⁻, u⁺, v⁻, v⁺ the arcs of ω(p) just clockwise and just counter-clockwise of the ring points y + 60° and y − 60°; then p has four colours and no more, X and X̄ are the colours absent at p, and (i) if neither v⁻ nor u⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction to p lies in the cone of a tile of a colour c of p every tile of p of which colour lies in B̄(y, 1); (ii) if neither u⁻ nor v⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction away from p lies in the cone of a tile, not a tile of p, of a colour c of p every tile of p of which colour misses B(y, 1); (iii) if none of the four lies on a (Q) arc, y is a vertex of at least four colours *Not claimed:* anything at k ≥ 7; that the tile in (i) is a tile of p (that is RING-GERM, in the non-Siamese class); that a change point with a germ on a (Q) arc has fewer than four colours
> — source: data/fs116/claims.md § 11. Added at round 3

> - **FS116-N1-TOUCH** *(proposed at round 2)*: in a valid fragment on a closed disc of radius above 1 about a vertex p of four colours and no more, Siamese pairs allowed, let w be a point of ω(p) in the closure of a tile of one of p's colours which is not a change point of the ring and lies on no arc of Γ on ω(p), and suppose none of the four arcs of ω(p) just clockwise and just counter-clockwise of w + 60° and w − 60° lies on a (Q) arc; then the ring just clockwise and just counter-clockwise of w lies in tiles of one colour X absent at p, each of the four arcs lies in the closure of a tile of the other absent colour X̄ and of no tile of colour X, and no tile of colour X̄ has w in its closure *Not claimed:* that such a point exists in any fragment of SAT-QFREE's class; anything at k ≥ 7; anything when a germ lies on a (Q) arc
> — source: data/fs116/claims.md § 11. Added at round 3

> - **FS116-N1-ECHO** *(proposed at round 2)*: in a valid k-coloured fragment on a closed disc of radius above 2 about a point p, for any k, Siamese pairs allowed, let w be a point of ω(p) whose ring just clockwise and just counter-clockwise of w lies in tiles of one colour X absent at p; if the fragment is saturated at w and X is in w's essential multicolour, the point 2w − p lies in the closure of a tile of colour X *Not claimed:* anything when X has density 0 at w (a cusp); that the X-tile at 2w − p exists in any fragment of SAT-STRIP's class
> — source: data/fs116/claims.md § 11. Added at round 3

> - **FS116-N1-AXIS** *(proposed at round 2)*: let p be a degree-4 vertex of four colours of a valid fragment on a closed disc of radius above 1 about p, saturated on a disc about p, whose four edges are segments along the four half-axes, with tiles coloured c_I, c_II, c_III, c_IV by quadrant and absent colours X, X̄; then at q_N = p + (0, 1): (a) every tile approaching q_N along a direction below the horizontal has colour X or X̄; (b) a tile of colour c_IV approaches q_N along 0⁺ and one of colour c_III along 180⁻, both above the line y = 1; (c) the arcs of ω(p) just counter-clockwise of r(30°) and just clockwise of r(150°) lie on no (Q) arc; (d) if the arcs just clockwise of r(30°) and just counter-clockwise of r(150°) lie on no (Q) arc, every tile approaching q_N along a direction below the horizontal has one colour, and q_N is not a change point; and at each of the axis points q_E, q_W, q_S, read with the quadrants turned with it *Not claimed:* anything for four segments not at right angles; anything at k ≥ 7 for (d) (at k = 9 SQ9 fails it); that the axis points are touch points in any fragment saturated on B̄(p, 1); SAT-STRIP
> — source: data/fs116/claims.md § 11. Added at round 3

## What you may read

The list `data/fs116/claims.md` (in `data/fs116/`, only it and your own `data/fs116/v3/` are open to you), `data/fs114/claims.md` and
`plans/FS114-derivation.md` (its entries' statements; not the records their `argument:` lines point to); `CLAUDE.md`; the grokkings (preloaded); `LEDGER.md`; the held papers
(`BIBLIOGRAPHY.md`, `~/source/library/`); and the held inputs' own homes from milestones before FS-114: `plans/FS110-*.md`,
`plans/FS111-*.md`, `plans/FS112-*.md` and their `data/` directories. Anything not named here and not in § Fences: ask before reading.

## Fences

Until your verdicts on all three statements are committed, do not read any of these (and never `git log -p` or `git show` on them, nor the
bodies of their commits):
- FS-116's plan and records: `plans/FS116-local-exclusion.md`, `plans/FS116-N1-proof.md`, `plans/FS116-N2-proof.md`,
  `plans/FS116-Y1-construction.md`, `plans/FS116-Y2-construction.md`, `plans/FS116-V1-verification.md`, `plans/FS116-V2-verification.md`,
  `plans/FS116-close-inventory.md`; the directories `data/fs116/briefs/`, `data/fs116/reports/`,
  `data/fs116/o1/`, `data/fs116/n1/`, `data/fs116/n2/`, `data/fs116/y1/`, `data/fs116/y2/`,
  `data/fs116/v1/`, `data/fs116/v2/`, and the file `data/fs116/v1-n7-definitions.md`; tools named
  `tools/fs116_*` other than yours.
- FS-116's stub and the question records: `plans/STUB-local-exclusion.md`, `plans/POROS-2026-09-28-fs116-question.md`,
  `plans/POROS-2026-09-28-close-reread.md`.
- FS-121's plan and records: `plans/FS121-map-step.md`, `plans/FS121-close-inventory.md`, `plans/FS121-D1-proof.md`,
  `plans/FS121-DB1-verification.md`, `plans/FS121-D3-proof.md`, the directories `data/fs121/briefs/`, `data/fs121/reports/`,
  `data/fs121/o1/`, `data/fs121/d1/`, and `plans/STUB-map-step.md`.
- FS-114's job records, which hold the routes of the statements these re-work: files matching `plans/FS114-N*`, `plans/FS114-Y*` and
  `plans/FS114-C*`, `plans/FS114-close-inventory.md`, `plans/FS114-L60-audit.md`, `plans/FS114-unit-arc-question.md`, and the directories
  matching `data/fs114/fs114-*`, `data/fs114/briefs/` and `data/fs114/reports/`.
- The Clerk's job files: `data/workflow3/cl2/`, `plans/WORKFLOW3-CL2-n7-definitions.md`, `data/workflow3/reports/CL2.md`.
- The session transcripts (`~/.claude/projects/`, `chats-bak/`), the coordinator's scratch, and any other job's scratch directory.

If a search prints fenced text, stop reading and log the touch at once (standing rule 8).

## After your verdicts

Once your verdicts on all five are committed, your second phase opens the first derivations for the divergence table: the round-1 proof
record, § 4 (its path is in § Fences). Nothing else in the fence opens.

## Done means

1. **Your record**, `plans/FS116-V3-verification.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS116-V3-verification.md` from the repository root before each stage's commit, holding your procedure's sections: the
   readback, your expected verdict with its probability for each statement before any derivation, your derivation or stall, the attack
   on each statement, one `verification:` block per statement, and, after the verdicts' commit, the divergence table with every
   divergence classed.
2. **The report** in the standing rules' form, one RESULT line per statement with your count of minds ("blind, the same model").

## What is yours to decide

Your route, your order, and your verdicts. If a statement is ambiguous, ask "main" which reading is meant and
I will ask its author. If a statement is wrong as posed, MISSTATED with the corrected statement is a finding, not a failure.

## Stages (save and commit each; standing rule 2)

1. The readback and the registered expectations.
2. GERM-R and GERM-S: derivation, attack, verdicts committed.
3. TOUCH, ECHO and AXIS: derivation, attack, verdicts committed.
4. The divergence table, then the report.

Thank you.
