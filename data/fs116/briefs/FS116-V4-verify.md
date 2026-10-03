# Brief FS116-V4 — a blind second mind on six round-3 claims of FS-116's list (§ 12)

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-V4
  identity: Ephodos in its verification form — your agent file (`.claude/agents/ephodos-verifier.md`) is your identity, your lane's workflow, and the `ephodos-verification` procedure preloaded beside it; `ephodos-recognition` and `ephodos-invention` are yours to invoke fresh with the Skill tool if you choose
  role: blind verifier of six fixed statements; blind, the same model as the minds whose work you may later compare against (Opus 5.5)
  launch: now, beside FS116-N3 (a derivation job of FS-116) and FS121-V5, working other claims
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: § Fences
  channel: message the coordinator ("main") by SendMessage with any question mid-flight, including any question of which reading a statement means; the report goes to `data/fs116/reports/FS116-V4.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS116-V4-verification.md`
  touches: `plans/FS116-V4-verification.md`, `data/fs116/v4/`, `tools/fs116_v4_*.py`, `data/fs116/reports/FS116-V4.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are the second mind on six statements. Another mind works the same list; nothing more about that work is yours until your
own verdicts are committed.

## Why this job

FS-116 asks whether an explicit radius exists within which no valid six-coloured fragment with unit arcs survives about a vertex of at
least four colours, one radius for every complexity, Siamese pairs allowed (`data/fs116/claims.md` § 1). Round 3 produced its two strongest
partial results: SAT-STRIP decided in one class (the last statement of the first three below, with two lemmas it rests on), and the case of a
four-colour vertex whose ring meets no arc of Γ reduced to one forced star (the last of the second three, with two lemmas). They were added
to the list at round 4 (§ 12). Before anything rests on them, this project wants a blind mind to re-derive each statement fixed in advance.
The record shows where hand derivations here fail: the sentence claims more than the argument carried. So attack each statement, not only its
steps. TRUE, FALSE with a counterexample, GAP at a named step and MISSTATED are all results. Commit your verdicts on the first three before you
begin the second three, so that a halt costs at most the second half.

## The statements

Derive or refute each, exactly as written, with its *not claimed* line as part of it. The definitions they use are the list's § 0 (and the
statements of §§ 10–11 it builds on), and `data/fs114/claims.md` §§ 0, 6 where the list does not restate them. "Change point" is read as the
list's § 10 reads it: the ring off Γ on both sides.

> - **FS116-S1-KAPPA** *(proposed at round 3)*: at a vertex p of four colours and no more of a valid fragment on a closed disc of radius above 1 about p, Siamese pairs allowed, whose ring carries no (Q) arc, every germ of ω(p) (an arc just clockwise or just counter-clockwise of a ring point) lies in the closure of tiles of exactly one colour absent at p, κ, and the germ 60° on carries the other; so κ's change points form a finite non-empty set invariant under the rotation by 60° about p, each half-open 60° window of ω(p) holds an odd number of them, and antipodal germs carry different colours; in a non-Siamese fragment the change points are exactly y + 60°ℤ for one ring point y *Not claimed:* anything when the ring carries a (Q) arc; anything at k ≥ 7 (at k = 9 SQ9's r(45°) and r(225°) carry one colour); that any vertex of the class exists at six colours
> — source: data/fs116/claims.md § 12. Added at round 4

> - **FS116-S1-RUNG** *(proposed at round 3)*: let p be a degree-4 vertex of four colours of a valid fragment whose four edges are segments along the four half-axes, with tiles coloured c_I, c_II, c_III, c_IV by quadrant, and suppose the fragment saturated at every point of the east edge's first segment [p, p + (ℓ, 0)], 0 < ℓ ≤ L_E; if a tile of colour c_IV has a point w in its closure with |w − q_N| < 1, q_N = p + (0, 1), then |w − p − (s, 1)| ≤ 1 for every s in [0, ℓ]; and the same at each edge and axis point, turned and reflected with the quadrants; in particular a contact of c_IV at r(φ), 90° < φ < 150°, gives ℓ ≤ cos φ + √(sin φ (2 − sin φ)), which at φ = 120° is FS116-Y1-STRIPCEIL's x* = √(√3 − 3/4) − 1/2 *Not claimed:* anything at a partner point where the edge is not saturated; anything for edges that are not segments; that a contact exists in quadrant II in any fragment of SAT-STRIP's class (FS116-S1-LENS supplies one where the ring carries no (Q) arc)
> — source: data/fs116/claims.md § 12. Added at round 4

> - **FS116-S1-QF** *(proposed at round 3)*: no non-Siamese valid fragment on B̄(p, 2), saturated on B̄(p, 1), whose ring ω(p) carries no (Q) arc, has at p a degree-4 vertex of four colours whose four edges are segments at right angles *Not claimed:* SAT-STRIP itself (rings with (Q) arcs, Siamese fragments, crosses not at right angles stay open: § 2.5's G1–G3); anything at k ≥ 7 (at k = 9 SQ9 meets every other hypothesis); that the class is non-empty at six colours without the cross
> — source: data/fs116/claims.md § 12. Added at round 4

> - **FS116-Y3-NBTIP** *(proposed at round 3)*: in FS116-Y3-TIPS's setting, the tip of each hub meets the open unit disc about each of the two neighbouring hubs; so no hub has a neighbour's tip colour as an outer colour, and the only outer colour of y_2 is 4 and of y_5 is 3 *Not claimed:* anything about outer tiles of other colours; anything outside the Γ-free class (there consecutive change points need not be 60° apart)
> — source: data/fs116/claims.md § 12. Added at round 4

> - **FS116-Y3-TIGHTLENS** *(proposed at round 3)*: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours whose ring carries no arc of Γ, labelled as FS116-Y3-TIPS, the edges of p satisfy (Q1) δ_4 = −30° or δ_1 = 30° or δ_2 = 210°; (Q2) δ_3 = 270° or δ_1 = 30° or δ_2 = 210°; (Q4) δ_2 = 150° or δ_4 = 30° or δ_3 = 210°; (Q5) δ_1 = 90° or δ_4 = 30° or δ_3 = 210° — for each lens beside a single tip, the tip of one of its two hubs is tight at p for that hub; so at least two edges of p lie along flanking directions of hubs, and no such fragment has a generic star *Not claimed:* that any star satisfying (Q1)–(Q5) occurs; anything below radius √3 (a generic star there is neither excluded nor built); anything in the Siamese or non-simple class; anything at k ≥ 7 (a third absent colour survives near q_k)
> — source: data/fs116/claims.md § 12. Added at round 4

> - **FS116-Y3-STARFORCE** *(proposed at round 3)*: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours whose ring carries no arc of Γ, labelled as FS116-Y3-TIPS, the edges of p are δ_1 = 90°, δ_2 = 150°, δ_3 = 270°, δ_4 = −30° (FS116-N2-HEX3's star); 3 is an outer colour of y_0 and of y_4, and 4 of y_1 and of y_3; each of these four hubs has that outer colour alone or two outer tiles, counter-clockwise 2, 3 at y_0; 4, 2 at y_1; 1, 4 at y_3; 3, 1 at y_4; and near q_1, q_5 the lens points carry colour 2, near q_2, q_4 colour 1 *Not claimed:* that any such fragment exists, at any radius; anything below radius √3; anything in the Siamese or non-simple class; anything at k ≥ 7
> — source: data/fs116/claims.md § 12. Added at round 4

## What you may read

The list `data/fs116/claims.md` (in `data/fs116/`, only it and your own `data/fs116/v4/` are open to you), `data/fs114/claims.md` and
`plans/FS114-derivation.md` (its entries' statements; not the records their `argument:` lines point to); `CLAUDE.md`; the grokkings (preloaded); `LEDGER.md`; the held papers
(`BIBLIOGRAPHY.md`, `~/source/library/`); and the held inputs' own homes from milestones before FS-114: `plans/FS110-*.md`,
`plans/FS111-*.md`, `plans/FS112-*.md` and their `data/` directories. Anything not named here and not in § Fences: ask before reading.

## Fences

Until your verdicts on all six statements are committed, do not read any of these (and never `git log -p` or `git show` on them, nor the
bodies of their commits):
- FS-116's plan and records: `plans/FS116-local-exclusion.md`, `plans/FS116-N1-proof.md`, `plans/FS116-N2-proof.md`, `plans/FS116-N3-proof.md`,
  `plans/FS116-S1-proof.md`, `plans/FS116-Y3-construction.md`, `plans/FS116-V3-verification.md`,
  `plans/FS116-Y1-construction.md`, `plans/FS116-Y2-construction.md`, `plans/FS116-V1-verification.md`, `plans/FS116-V2-verification.md`,
  `plans/FS116-close-inventory.md`; the directories `data/fs116/briefs/`, `data/fs116/reports/`,
  `data/fs116/o1/`, `data/fs116/n1/`, `data/fs116/n2/`, `data/fs116/y1/`, `data/fs116/y2/`,
  `data/fs116/v1/`, `data/fs116/v2/`, `data/fs116/v3/`, `data/fs116/n3/`, `data/fs116/s1/`, `data/fs116/y3/`, and the file `data/fs116/v1-n7-definitions.md`; tools named
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

Once your verdicts on all six are committed, your second phase opens the first derivations for the divergence table: the saturation job's
proof record, §§ 2.1–2.5, and the hub construction's record, §§ 2–4 (their paths are in § Fences). Nothing else in the fence opens.

## Done means

1. **Your record**, `plans/FS116-V4-verification.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS116-V4-verification.md` from the repository root before each stage's commit, holding your procedure's sections: the
   readback, your expected verdict with its probability for each statement before any derivation, your derivation or stall, the attack
   on each statement, one `verification:` block per statement, and, after the verdicts' commit, the divergence table with every
   divergence classed.
2. **The report** in the standing rules' form, one RESULT line per statement with your count of minds ("blind, the same model").

## What is yours to decide

Your route, your order, and your verdicts. If a statement is ambiguous, ask "main" which reading is meant and
I will ask its author. If a statement is wrong as posed, MISSTATED with the corrected statement is a finding, not a failure.

## Stages (save and commit each; standing rule 2)

1. The readback and the registered expectations.
2. KAPPA, RUNG and QF: derivation, attack, verdicts committed.
3. NBTIP, TIGHTLENS and STARFORCE: derivation, attack, verdicts committed.
4. The divergence table, then the report.

Thank you.

## Amendment 1 (2026-10-03 15:14 UTC): the job narrowed to its first three statements

Your question is right, and the gap is mine: the list's § 12 froze FS116-Y3-NBTIP, -TIGHTLENS and -STARFORCE without the setting they are
stated in (FS116-Y3-TIPS and its labels, and the record's definitions of a lens, its far vertex, flanking directions, tightness and the
generic star), and those live only in a record your fence closes, woven into its arguments. Rather than relay pieces of that record, I am
taking those three statements off this job: **your job is now FS116-S1-KAPPA, FS116-S1-RUNG and FS116-S1-QF only.** The other three will get a
blind check of their own, with their setting frozen beside them. Record in your report that the three were withdrawn by the coordinator, not
left undone. Your fence is unchanged, and the hub construction's record stays fenced from you. Unchanged too: no agents of your own (standing
rule 1: staffing is Kooshi's budget, and I can review only work I know exists).
