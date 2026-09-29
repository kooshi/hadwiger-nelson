# Brief FS116-N3 — Ephodos: FS-116's proof side, round 4 (semi-hubs: RING-TRANSFER-Q)

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-N3
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job's procedure, opening with `ephodos-recognition` invoked fresh with the Skill tool
  role: a derivation job on FS-116's frozen claim list, proof side, round 4
  launch: now, beside FS116-S1 (SAT-STRIP) and FS116-Y3 (the construction side, on Γ-free four-colour vertices), neither blind to you, FS116-V3 (a blind verifier) and FS-121's jobs
  mission: § Why this job
  statements: § Your claims
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — a derivation job; but write nothing about your work where FS116-V3 or FS121-V4 could read it before their verdicts (standing rule 8): only your record, your data directory and your report
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs116/reports/FS116-N3.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` is part of it too if you build an exact check
  record: `plans/FS116-N3-proof.md`
  touches: `plans/FS116-N3-proof.md`, `data/fs116/n3/`, `tools/fs116_n3_*.py`, `data/fs116/reports/FS116-N3.md`
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are Ephodos, on the proof side of FS-116's first round.

## Why this job

Round 3 (`plans/FS116-N2-proof.md`) found RING-TRANSFER MISSTATED and derived its corrected form RING-TRANSFER-C for rings whose placing
change points are hubs (all four germs at ±60° off (Q) arcs); for ring types with (Q) arcs it stalled (RING-TRANSFER-Q, GAP): a placing rule is
needed at **semi-hubs**, change points where one pair of germs lies on (Q) arcs. The capped strip's type recurs at both of its change points
through semi-hubs, and the strip supplies their four colours, not a lemma. N2's advice for D2's next object: a four-colour vertex whose ring
carries an arc of Γ, at distance 1 from a Γ-free one, together with its semi-hubs. RING-GERM's (i) and (ii) (the list's § 10) are exactly the
half-rules a semi-hub needs, and FS116-N1-GERM-R (one mind; under blind check now) is the pointwise form. Your job is the semi-hub rule.

## Your claims

The frozen claim below was found MISSTATED at round 3; your work is its (Q)-arc case in the corrected form, RING-TRANSFER-C's statement
extended to semi-hubs (RING-TRANSFER-Q, GAP there), as `plans/FS116-N2-proof.md` § 3.3 states them. Propose the semi-hub rule as a
statement in your record before deriving it, so it can be frozen for a blind check. The frozen words, for reference:

> - **RING-TRANSFER** *(this list)*: for each ring type at a vertex of at least four colours, the ring types of the vertices of at least four colours it places at
>   distance 1 are determined by a finite rule; state the rule, derive it, and name the ring types that can recur at every vertex they place. *Not claimed:*
>   that the rule is the same at `k = 6` and `k = 7`.
> — source: data/fs116/claims.md § 5. D1 — the ring

Held inputs at two minds: RING-GERM, RING-TWIST-C and FS116-N1-TWIST-LIT (the list's § 10, reading L of "change point": a change point has the
ring off Γ on both sides; "arc of Γ on ω(p)" read as an edge), FS116-O1-SATPIN in its corrected wording, and N7-HUB (b), (c). One-mind inputs:
RING-Q-PRIME, RING-TWIST-Q, FS116-N1-QDISK (round 1), and from round 1's stage 4 (`plans/FS116-N1-proof.md` § 4) FS116-N1-GERM-R and
-GERM-S (RING-GERM without "non-Siamese"), RING-Q-PRIME-S, -QFREE4, -TOUCH (the touch point's shape), -ECHO and -AXIS, and a recognition from FS-121's round 2 that saturation makes every colour change across
an interface an exchange with a unit neighbour (`plans/FS121-D3-proof.md` § 1.2, § 2.3). An open construction question bears on you: does any
fragment of the class have a qualifying window (a 120° arc of ω(p) free of D)? None is held.

## What you read

The plan in full (`plans/FS116-local-exclusion.md`, especially § 1.2's *bears* lines, § 3.3, § 4.3–4.6), the frozen list and its § 9
controls and killing tests, round 1's and its verifiers' records named above, the stub (`plans/STUB-local-exclusion.md`),
`plans/FS114-derivation.md` and the FS-114 records it cites (N6-RING60 and N7-HUB above all), and the grokkings in your context.

## Done means

1. **Your record**, `plans/FS116-N3-proof.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS116-N3-proof.md`
   from the repository root before each stage's commit: the readback, the recognition stage, then a `derivation:` entry for the claim
   with its verdict (TRUE, FALSE with a counterexample, GAP at a named step, or MISSTATED with the corrected statement) and one for every
   lemma, each stating where it fails on the strip and the disk and what it says at `k = 7` (the list's § 9).
2. **The report** in the standing rules' form. Your last words are exactly "FS116-N3 idle; report sent to the coordinator": the report
   goes by message, and the hand-back carries nothing else.

## What is yours to decide

Your route: the ring types, how to enumerate them by derivation (never by a program — the list's § 9 forbids enumerating ring types), and
which recur. The plan's stop rule is yours: three failed attempts on one step, then `ephodos-recognition`, then `ephodos-invention` if every
home dies on one line. If RING-TRANSFER as posed is the wrong statement, MISSTATED with the corrected one is a finding.

## Stages (save and commit each; standing rule 2)

1. The readback, then recognition on the claim.
2. and on: one relay-result per stage — the ring types, the rule, the recurring types.
Last: the report.

Thank you.
