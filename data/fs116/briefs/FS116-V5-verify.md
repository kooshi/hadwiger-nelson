# Brief FS116-V5 — a blind second mind on eight claims of FS-116's list (§§ 12–14)

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-V5
  identity: Ephodos in its verification form — your agent file (`.claude/agents/ephodos-verifier.md`) is your identity, your lane's workflow, and the `ephodos-verification` procedure preloaded beside it; `ephodos-recognition` and `ephodos-invention` are yours to invoke fresh with the Skill tool if you choose
  role: blind verifier of eight fixed statements; blind, the same model as the minds whose work you may later compare against (Opus 5.5)
  launch: now, beside FS116-V4 and FS121-V5, two blind verifiers working other claims
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: § Fences
  channel: message the coordinator ("main") by SendMessage with any question mid-flight, including any question of which reading a statement means; the report goes to `data/fs116/reports/FS116-V5.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS116-V5-verification.md`
  touches: `plans/FS116-V5-verification.md`, `data/fs116/v5/`, `tools/fs116_v5_*.py`, `data/fs116/reports/FS116-V5.md`
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k — a successor on this brief continues from your last saved stage

Hello. You are the second mind on eight statements. Other minds worked the same statements; nothing more about that work is yours until your
own verdicts are committed.

## Why this job

FS-116 asks whether an explicit radius exists within which no valid six-coloured fragment with unit arcs survives about a vertex of at
least four colours, one radius for every complexity, Siamese pairs allowed (`data/fs116/claims.md` § 1). Two groups of statements about such a
vertex were added to the list at round 4: five about a vertex whose ring carries no arc of Γ (§ 14's two and § 12's last three, which use
§ 14's labels), and three about semi-hubs, as § 13's setting words define them (§ 13). Before
anything rests on them, this project wants a blind mind to re-derive each statement fixed in advance. The record shows where hand derivations
here fail: the sentence claims more than the argument carried. So attack each statement, not only its steps. TRUE, FALSE with a counterexample,
GAP at a named step and MISSTATED are all results. Commit your verdicts on the first group before you begin the second, so that a halt costs at
most the second group.

## The statements

Derive or refute each, exactly as written, with its *not claimed* line as part of it. The definitions they use are the list's § 0, the
statements of §§ 10–11 they build on, **§ 14's setting words for the first group and § 13's for the second, with each section's notes**, and
`data/fs114/claims.md` §§ 0, 6 where the list does not restate them. "Change point" is read as the list's § 10 reads it: the ring off Γ on both
sides. Where § 13's or § 14's notes say a phrase has no definition, state your reading and give your verdict under it; if two readings change
the verdict, give both.

**The first group** (the Γ-free vertex; the two § 14 statements first, since the other three are stated in their labels):

> - **FS116-Y3-SIX** *(proposed at round 3)*: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring carries no arc of Γ, the ring has exactly six change points, 60° apart, each a hub, and p has exactly four tiles *Not claimed:* anything in the Siamese class (there RING-GERM's tip is GERM-S's tile, not necessarily a tile of p, and the count is not run); anything at k ≥ 7 (SQ9 at k = 9 has twelve); that any such fragment exists
> — source: data/fs116/claims.md § 14

> - **FS116-Y3-TIPS** *(proposed at round 3)*: in FS116-Y3-SIX's setting, with the hubs y_k = e(60k), each hub has exactly one tip, the tips of antipodal hubs are opposite tiles of p, and up to rotation of the labels the four tiles of p, counter-clockwise, are T1 tipping y_0 and y_1 (cone at p in [−30°, 90°]), T3 tipping y_2 (in [30°, 210°]), T2 tipping y_3 and y_4 (in [150°, 270°]) and T4 tipping y_5 (in [210°, 30°]) *Not claimed:* anything in the Siamese or non-simple class; that the cones fill their ranges (each δ is free in its interval); that any such fragment exists
> — source: data/fs116/claims.md § 14

> - **FS116-Y3-NBTIP** *(proposed at round 3)*: in FS116-Y3-TIPS's setting, the tip of each hub meets the open unit disc about each of the two neighbouring hubs; so no hub has a neighbour's tip colour as an outer colour, and the only outer colour of y_2 is 4 and of y_5 is 3 *Not claimed:* anything about outer tiles of other colours; anything outside the Γ-free class (there consecutive change points need not be 60° apart)
> — source: data/fs116/claims.md § 12. Added at round 4

> - **FS116-Y3-TIGHTLENS** *(proposed at round 3)*: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours whose ring carries no arc of Γ, labelled as FS116-Y3-TIPS, the edges of p satisfy (Q1) δ_4 = −30° or δ_1 = 30° or δ_2 = 210°; (Q2) δ_3 = 270° or δ_1 = 30° or δ_2 = 210°; (Q4) δ_2 = 150° or δ_4 = 30° or δ_3 = 210°; (Q5) δ_1 = 90° or δ_4 = 30° or δ_3 = 210° — for each lens beside a single tip, the tip of one of its two hubs is tight at p for that hub; so at least two edges of p lie along flanking directions of hubs, and no such fragment has a generic star *Not claimed:* that any star satisfying (Q1)–(Q5) occurs; anything below radius √3 (a generic star there is neither excluded nor built); anything in the Siamese or non-simple class; anything at k ≥ 7 (a third absent colour survives near q_k)
> — source: data/fs116/claims.md § 12. Added at round 4

> - **FS116-Y3-STARFORCE** *(proposed at round 3)*: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours whose ring carries no arc of Γ, labelled as FS116-Y3-TIPS, the edges of p are δ_1 = 90°, δ_2 = 150°, δ_3 = 270°, δ_4 = −30° (FS116-N2-HEX3's star); 3 is an outer colour of y_0 and of y_4, and 4 of y_1 and of y_3; each of these four hubs has that outer colour alone or two outer tiles, counter-clockwise 2, 3 at y_0; 4, 2 at y_1; 1, 4 at y_3; 3, 1 at y_4; and near q_1, q_5 the lens points carry colour 2, near q_2, q_4 colour 1 *Not claimed:* that any such fragment exists, at any radius; anything below radius √3; anything in the Siamese or non-simple class; anything at k ≥ 7
> — source: data/fs116/claims.md § 12. Added at round 4

**The second group** (semi-hubs):

> - **FS116-N3-SEMI** *(proposed at round 4)*: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) be a semi-hub of the ring of p; then y is a vertex of at least four colours, or y is a vertex of exactly three colours one of whose edges at y is an arc of the unit circle about r(ψ + 60°) or about r(ψ − 60°) whose two side colours are both carried at that centre, which is then a vertex of at least four colours, or y is a full parallel semi-hub of exactly three colours — the two absent at p and the colour of the tile of p whose cone holds ψ + 180° (kind O) or ψ (kind T) in its interior. *Not claimed:* that a semi-hub has four colours; that the third alternative occurs, or that it is excluded; anything at a closed change point (the disk's corner); Siamese or non-simple fragments; anything at `k ≥ 7`.
> — source: data/fs116/claims.md § 13

> - **FS116-N3-PAIR** *(proposed at round 4)*: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, if both germs of one pair at a change point of the ring lie on (Q) arcs and the two arcs have the same pair of colours, then the inner colour of each is the outer colour of the other. *Not claimed:* anything about two (Q) arcs not at one pair's germs.
> — source: data/fs116/claims.md § 13

> - **FS116-N3-CROSS** *(proposed at round 4)*: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours, let y = r(ψ) be a crossed full semi-hub of kind O of the ring of p, u⁺ on a (Q) arc of inner colour a and outer colour a′ and v⁻ on one of inner colour b and outer colour b′; then every tile of p at y has a cone at y of zero angle, and the outer colours at y lie in {a′, b′}; if y has four colours and every tile at y a cone of positive angle at y, its outer colours are a′ and b′ and its missing pair is {a, b}, and, unless an edge of p runs along ω(y) at p, p is a change point of the ring of y, that ring being b just counter-clockwise of p and a just clockwise, and p is a semi-hub of kind O of the ring of y. *Not claimed:* that y has four colours; that p is a crossed semi-hub of y's ring; anything about y's ring away from p; anything at `k ≥ 7`.
> — source: data/fs116/claims.md § 13

## What you may read

The list `data/fs116/claims.md` (in `data/fs116/`, only it and your own `data/fs116/v5/` are open to you), `data/fs114/claims.md` and
`plans/FS114-derivation.md` (its entries' statements; not the records their `argument:` lines point to); `CLAUDE.md`; the grokkings (preloaded);
`LEDGER.md`; the held papers (`BIBLIOGRAPHY.md`, `~/source/library/`); and the held inputs' own homes from milestones before FS-114:
`plans/FS110-*.md`, `plans/FS111-*.md`, `plans/FS112-*.md` and their `data/` directories. Anything not named here and not in § Fences: ask
before reading.

## Fences

Until your verdicts on all eight statements are committed, do not read any of these (and never `git log -p` or `git show` on them, nor the
bodies of their commits):
- FS-116's plan and records: files matching `plans/FS116-*` other than your own record; the directories `data/fs116/briefs/`, `data/fs116/reports/`,
  `data/fs116/o1/`, `data/fs116/n1/`, `data/fs116/n2/`, `data/fs116/n3/`, `data/fs116/s1/`, `data/fs116/y1/`, `data/fs116/y2/`, `data/fs116/y3/`,
  `data/fs116/v1/`, `data/fs116/v2/`, `data/fs116/v3/`, `data/fs116/v4/`, `data/fs116/cl1/`, and the file `data/fs116/v1-n7-definitions.md`;
  tools named `tools/fs116_*` other than yours.
- The stubs and the question records: files matching `plans/STUB-*`, `plans/POROS-2026-09-28-fs116-question.md`,
  `plans/POROS-2026-09-28-close-reread.md`.
- FS-121's plan and records: files matching `plans/FS121-*`, and the directory `data/fs121/`.
- FS-114's job records, which hold the routes of the statements these re-work: files matching `plans/FS114-N*`, `plans/FS114-Y*` and
  `plans/FS114-C*`, `plans/FS114-close-inventory.md`, `plans/FS114-L60-audit.md`, `plans/FS114-unit-arc-question.md`, and the directories
  matching `data/fs114/fs114-*`, `data/fs114/briefs/` and `data/fs114/reports/`.
- The Clerk's job files: `data/workflow3/cl2/`, `plans/WORKFLOW3-CL2-n7-definitions.md`, `data/workflow3/reports/CL2.md`.
- The session transcripts (`~/.claude/projects/`, `chats-bak/`), the coordinator's scratch, and any other job's scratch directory.

If a search prints fenced text, stop reading and log the touch at once (standing rule 8).

## After your verdicts

Once your verdicts on all eight are committed, your second phase opens the first derivations for the divergence table: the hub construction's
record, `plans/FS116-Y3-construction.md` §§ 2–4, and the semi-hub proof's record, `plans/FS116-N3-proof.md` §§ 1.2 and 2–3. Nothing else in the
fence opens.

## Done means

1. **Your record**, `plans/FS116-V5-verification.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS116-V5-verification.md` from the repository root before each stage's commit, holding your procedure's sections: the
   readback, your expected verdict with its probability for each statement before any derivation, your derivation or stall, the attack
   on each statement, one `verification:` block per statement, and, after the verdicts' commit, the divergence table with every
   divergence classed.
2. **The report** in the standing rules' form, one RESULT line per statement with your count of minds ("blind, the same model"). Your last
   words are exactly "FS116-V5 idle; report sent to the coordinator".

## What is yours to decide

Your route, your order within a group, and your verdicts. If a statement is ambiguous, ask "main" which reading is meant; I answer from its
author's definitions, never its argument, or rule it an ambiguity for you to report under both readings. If a statement is wrong as posed,
MISSTATED with the corrected statement is a finding, not a failure. If the setting words frozen beside a statement are wrong or not enough,
say so: that is a finding too.

## Stages (save and commit each; standing rule 2)

1. The readback and the registered expectations.
2. The first group (SIX, TIPS, NBTIP, TIGHTLENS, STARFORCE): derivation, attack, verdicts committed.
3. The second group (SEMI, PAIR, CROSS): derivation, attack, verdicts committed.
4. The divergence table, then the report.

If you reach your hand-back line after stage 2, stop there and say so; a fresh mind takes stage 3 on this brief. You start no agent of your own
(`plans/STANDING-RULES.md` rule 1: staffing is Kooshi's budget, and I can review only work I know exists).

Thank you.
