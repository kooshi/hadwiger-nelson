# Brief FS116-N1 — Ephodos: FS-116's proof side, round 1 (the ring)

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-N1
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job's procedure, opening with `ephodos-recognition` invoked fresh with the Skill tool
  role: a derivation job on FS-116's frozen claim list, proof side, round 1
  launch: now, beside FS116-Y1 (the construction side, same milestone, not blind to you) and FS116-V1 (a blind verifier on other claims)
  mission: § Why this job
  statements: § Your claims
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — a derivation job; but write nothing about your work where FS116-V1 or FS121-DB1 could read it before their verdicts (standing rule 8): only your record, your data directory and your report
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs116/reports/FS116-N1.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` is part of it too if you build an exact check
  record: `plans/FS116-N1-proof.md`
  touches: `plans/FS116-N1-proof.md`, `data/fs116/n1/`, `tools/fs116_n1_*.py`, `data/fs116/reports/FS116-N1.md`
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are Ephodos, on the proof side of FS-116's first round.

## Why this job

FS-116's opening (FS116-O1) found that the object is the ring of a four-colour vertex: the unit circle about it, its (Q) arcs and change
points, and the four-colour vertices it places at distance 1 (`plans/FS116-local-exclusion.md` § 3.3, § 4.3). Phase D1 derives that ring's
structure first, because every later exclusion (D2) follows ring types outward to a contradiction, and because FS-114's case-by-case kills
never reached the vertex types that reach farthest. Your answer to RING-Q also decides D2's route (the plan's P3) and is the rung FS-121
takes as input (my ruling, `plans/FS121-close-inventory.md` item 8).

## Your claims

In this order, as the plan's § 4.4 sets it:

> - **RING-TWIST** *(this list)*: at a vertex `p` of at least four colours of a valid fragment on a closed disc of radius above 2 about `p` (Siamese pairs
>   allowed, any degree), the set `D` of points of `ω(p)` in the closure of a tile of one of `p`'s colours is contained in the union of the arcs of `Γ` on `ω(p)`
>   and finitely many points; and every half-open 60° window `W` of `ω(p)` with `W ∪ σ(W)` disjoint from `D` holds an odd number of change points. *Not claimed:*
>   anything at `k ≥ 7` (with three colours absent the parity fails: R7's lattice points); that `D` is non-empty.
> — source: data/fs116/claims.md § 5. D1 — the ring

> - **RING-Q** (card `what-do-q-rings-force`, `plans/POROS-2026-09-28-fs116-question.md` § 2.4, its ask verbatim: "At a vertex of at least four colours whose
>   ring carries a (Q) arc, which vertices of at least four colours, and which (Q) arcs, does the ring force at distance 1 — as N7-HUB does for (Q)-free
>   rings?") *(this list, as a claim)*: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex `p` of at least four colours
>   whose ring carries a (Q) arc, every change point of the ring that lies on no (Q) arc is a vertex of at least four colours; **RING-Q′**, the same for the
>   change points whose points at `±60°` on `ω(p)` also lie on no (Q) arc (N7-HUBQ's form). *Not claimed:* Siamese or non-simple fragments; that the (Q) arcs'
>   own ends are four-colour vertices. *Controls:* the strip's midline rings and the disk's corners (row 136); R7 at `k = 7`.
> — source: data/fs116/claims.md § 5. D1 — the ring

Then, if the budget holds:

> - **SAT-STRIP** *(this list)*: no valid fragment on `B̄(p, 2)` saturated on `B̄(p, 1)` has at `p` a degree-4 vertex of four colours whose four edges are
>   segments. *Not claimed:* anything at `k ≥ 7` (at `k = 9` the square nine-colouring of side 1/2 has such vertices, saturated); anything about unsaturated
>   fragments (the capped strip holds such a vertex to `φ²/√2`, FS114-Y-DIAL).
> — source: data/fs116/claims.md § 4. D0 — the saturated class

> - **SAT-QFREE** *(this list)*: in a valid fragment saturated on a disc about a vertex `p` of at least four colours, every tile at `p` with a cone of positive
>   angle, whose ring carries no (Q) arc, each split centre of FS116-O1-SATPIN and each point `p ± ν(p)` of its tangent type is a change point of the ring or
>   lies on an arc of `Γ` on `ω(p)`. *Not claimed:* rings with (Q) arcs; that such a vertex exists in a saturated fragment.
> — source: data/fs116/claims.md § 4. D0 — the saturated class

The two statements from the opening, FS116-O1-YESLIM and FS116-O1-SATPIN (the list's § 3), are one-mind inputs you may use, graded as
filed; a blind verifier is working them now. FS-121's FS121-O1-PER (`plans/FS121-map-step.md` § 3.3) is one mind as well.

## What you read

The plan in full (`plans/FS116-local-exclusion.md`, especially § 1.2's *bears* lines, § 3.3, § 4.3–4.6), the frozen list and its § 9
controls and killing tests, the stub (`plans/STUB-local-exclusion.md`), `plans/FS114-derivation.md` and the FS-114 records it cites
(N6-RING60 and N7-HUB above all), and the grokkings in your context.

## Done means

1. **Your record**, `plans/FS116-N1-proof.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS116-N1-proof.md`
   from the repository root before each stage's commit: the readback, the recognition stage, then one `derivation:` entry per claim with
   its verdict (TRUE, FALSE with a counterexample, GAP at a named step, or MISSTATED with the corrected statement), each stating where it
   fails on the strip and the disk and what it says at `k = 7` (the list's § 9).
2. **The report** in the standing rules' form. Your last words are exactly "FS116-N1 idle; report sent to the coordinator": the report
   goes by message, and the hand-back carries nothing else.

## What is yours to decide

Your route and the order within each pair. The plan's stop rule is yours: three failed attempts on one step, then `ephodos-recognition`,
then `ephodos-invention` if every home dies on one line. If a claim is wrong as posed, MISSTATED is a finding. If you find the plan's
frame wrong, say so.

## Stages (save and commit each; standing rule 2)

1. The readback, then recognition on each claim.
2. RING-TWIST.
3. RING-Q (and RING-Q′).
4. SAT-STRIP and SAT-QFREE, if the budget holds; then the report.

Thank you.
