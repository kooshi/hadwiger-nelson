# FS116-V4 — a blind second mind on FS116-S1-KAPPA, FS116-S1-RUNG and FS116-S1-QF

*Job FS116-V4 (Ephodos, verification form), brief `data/fs116/briefs/FS116-V4-verify.md` with its Amendment 1. Opened 2026-10-03 15:13 UTC.
Blind, the same model (Opus 5.5) as the minds whose records stage 4 opens. The brief first listed six statements. **The coordinator withdrew
FS116-Y3-NBTIP, FS116-Y3-TIGHTLENS and FS116-Y3-STARFORCE from this job (Amendment 1, 15:14 UTC)**, because they were frozen without the
setting they are stated in (FS116-Y3-TIPS and its labels). They were withdrawn, not left undone.*

## Theorems this phase proved

None yet: the derivations are stage 2's.

## Fence log

No fenced path read, listed or searched, as of stage 1. Every file read so far: the brief, `plans/STANDING-RULES.md`,
`data/fs116/claims.md`, `data/fs114/claims.md`, `plans/FS114-derivation.md` § 3 (statements and fields, with every `argument:` line filtered out
before display), the gate script `.claude/skills/ephodos/scripts/derive_gate.py` and its `example-verification.md`. Searched with `grep` on
`CLAUDE.md`, `LEDGER.md`, the grokkings, `data/fs114/claims.md` and `plans/FS114-derivation.md` for "TIPS", "HEX3", "STRIPCEIL", "S1-LENS", "NBTIP",
"STARFORCE", "TIGHTLENS": no hits.

## "Would have searched here" log

None yet. No program enumerates anything in this job. The checks are exact evaluations of named quantities (stage 2's controls).

## Stage 1 — SAVED (2026-10-03 15:33 UTC)

### 1.1 The readback

Each of the six statements in the brief's § The statements was compared character for character with its line in `data/fs116/claims.md` § 12,
by a short script that matched the line beginning "- **<name>**". **All six match.** The three statements of this job, as the list holds them:

> - **FS116-S1-KAPPA** *(proposed at round 3)*: at a vertex p of four colours and no more of a valid fragment on a closed disc of radius above 1 about p, Siamese pairs allowed, whose ring carries no (Q) arc, every germ of ω(p) (an arc just clockwise or just counter-clockwise of a ring point) lies in the closure of tiles of exactly one colour absent at p, κ, and the germ 60° on carries the other; so κ's change points form a finite non-empty set invariant under the rotation by 60° about p, each half-open 60° window of ω(p) holds an odd number of them, and antipodal germs carry different colours; in a non-Siamese fragment the change points are exactly y + 60°ℤ for one ring point y *Not claimed:* anything when the ring carries a (Q) arc; anything at k ≥ 7 (at k = 9 SQ9's r(45°) and r(225°) carry one colour); that any vertex of the class exists at six colours
> — `data/fs116/claims.md` § 12

> - **FS116-S1-RUNG** *(proposed at round 3)*: let p be a degree-4 vertex of four colours of a valid fragment whose four edges are segments along the four half-axes, with tiles coloured c_I, c_II, c_III, c_IV by quadrant, and suppose the fragment saturated at every point of the east edge's first segment [p, p + (ℓ, 0)], 0 < ℓ ≤ L_E; if a tile of colour c_IV has a point w in its closure with |w − q_N| < 1, q_N = p + (0, 1), then |w − p − (s, 1)| ≤ 1 for every s in [0, ℓ]; and the same at each edge and axis point, turned and reflected with the quadrants; in particular a contact of c_IV at r(φ), 90° < φ < 150°, gives ℓ ≤ cos φ + √(sin φ (2 − sin φ)), which at φ = 120° is FS116-Y1-STRIPCEIL's x* = √(√3 − 3/4) − 1/2 *Not claimed:* anything at a partner point where the edge is not saturated; anything for edges that are not segments; that a contact exists in quadrant II in any fragment of SAT-STRIP's class (FS116-S1-LENS supplies one where the ring carries no (Q) arc)
> — `data/fs116/claims.md` § 12

> - **FS116-S1-QF** *(proposed at round 3)*: no non-Siamese valid fragment on B̄(p, 2), saturated on B̄(p, 1), whose ring ω(p) carries no (Q) arc, has at p a degree-4 vertex of four colours whose four edges are segments at right angles *Not claimed:* SAT-STRIP itself (rings with (Q) arcs, Siamese fragments, crosses not at right angles stay open: § 2.5's G1–G3); anything at k ≥ 7 (at k = 9 SQ9 meets every other hypothesis); that the class is non-empty at six colours without the cross
> — `data/fs116/claims.md` § 12

**Terms the statements use, and where they are fixed.** Valid fragment, (Q), tiles, Γ, ring, change point, Siamese, saturated: the list's § 0,
quoted there. "Change point" is read as the brief directs (§ 10's reading: the ring off Γ on both sides). Three terms are the statements' own and
are read as written: a *germ* (KAPPA's parenthesis), *κ's change points* (points of ω(p) where κ differs on the two germs), and a *contact of
c_IV at r(φ)* (RUNG: read as "r(φ) lies in the closure of a tile of colour c_IV", the only reading under which its "in particular" follows from its
main clause). `r(φ)` is `p + (cos φ, sin φ)`; `L_E` is read as the length of the east edge's first segment. Two names inside the statements
are not on the list and are not needed: FS116-Y1-STRIPCEIL's x* (RUNG gives it by formula, which is what is checked) and FS116-S1-LENS (in a
*not claimed* line).

**Questions sent to the coordinator** (by message, between 15:15 and 15:33 UTC; the exact minutes were not logged):
1. *(about the withdrawn statements)* FS116-Y3-TIPS's setting and labels: answered by Amendment 1, which withdrew the three statements.
2. *(KAPPA, two wording points)*: (a) does "lies in the closure of tiles of exactly one colour absent at p" mean
   exactly one of the two absent colours has a tile whose closure holds the germ (reading B), or that the germ lies in the closures of tiles of
   one colour in all, an absent one (reading A)? (b) In the last clause, are "the change points" κ's change points or § 10's ring change points?
   **Answered by the coordinator (received about 15:37 UTC), from the author's record's definitions, verbatim, with nothing of its argument:**
   (a) "Let `K(g)` be the set of absent colours among the colours of the tiles whose closure holds the whole germ `g`." and "A **germ** of `ω(p)`
   at `θ` is the arc `(θ, θ + δ)` or `(θ − δ, θ)` of `ω(p)` for small `δ`" — that is reading B; (b) "A change point is a `θ` with `κ(θ^−) ≠ κ(θ^+)`."
   — and the coordinator's ruling, labelled as an inference of its own, that the last clause's "the change points" are κ's, superseding within
   KAPPA the brief's pointer to § 10. These definitions are added to the `given:` line below; they arrived after stage 1's predictions were
   written and before any verdict.

### 1.2 What this mind was given (the `given:` line, in full)

Before any verdict: the three statements and their *not claimed* lines (the brief and the list's § 12); the list's §§ 0–11 in full, which hold
earlier statements of the same programme, among them FS116-N1-AXIS (a lemma QF and RUNG plainly build on: "(b) a tile of colour c_IV approaches q_N
along 0⁺ and one of colour c_III along 180⁻, both above the line y = 1"), FS116-O1-SATPIN (the tangent type: "x + ν(x) in the closure of colour a and
x − ν(x) in the closure of colour b"), RING-TWIST-C and RING-GERM; `data/fs114/claims.md`; the statements of `plans/FS114-derivation.md` § 3,
among them FS114-N6-NOQ's N6-RING60 ("a four-colour vertex whose ring carries no (Q) arc has ring change points exactly y + 60°ℤ, six ring tiles
alternating the absent colours") and FS114-N7-3T's N7-HUB. **These were read as statements, with no argument and no verdict on any of the three,
and they are informed priors:** N6-RING60 is close to KAPPA's last clause, AXIS (b) to RUNG's setting, and SATPIN's tangent type to the rung itself.
The brief said the three are round 3's "two strongest partial results" and that "SAT-STRIP decided in one class (the last statement of the first
three below, with two lemmas it rests on)". That sentence carries the author's verdict on QF ("decided"), and it tells me that KAPPA and RUNG are
the lemmas QF rests on. So on QF I am blind to the argument and **not** blind to the author's verdict. No sketch, route or record of the author's
was seen.

### 1.3 The registered expectations

*Written at 15:33 UTC, after about twenty minutes of thinking about the statements (the setting, the twist at 60°, the partner of an edge point).
So these are informed predictions, not naive ones. They come before any derivation is written down, but not before I had thought about routes.
The commit order shows they come before the stage 2 derivation.*

| statement | predicted verdict | probability | likeliest break |
|---|---|---|---|
| KAPPA | derived | 0.70 | the wording, not the mathematics: "exactly one colour absent at p" read as "of one colour in all" fails at an arc of Γ on ω(p) with one of p's colours on one side; and "the change points" read as § 10's ring change points fails where a κ change point ends an arc of Γ on ω(p). The parity and the twist themselves I expect to hold with Siamese pairs allowed |
| RUNG | derived | 0.75 | the Siamese case. The statement does not assume non-Siamese, so the colour-c_IV tiles along the line y = 1 may be several tiles. Then w's tile need not be any of them, and "≤ 1" could fail between w and a far rung point |
| QF | derived | 0.60 | the step from "a change point in each open 60° arc beside an axis point" to "its outer tile is the rung tile at that axis point". It needs the axis point not to be a change point, and it needs the outer colour to be forced. A ring arc of Γ with one of p's colours on a side, or a non-simple tile, might let the outer colour escape. The second break is the final topological step |

### 1.4 The one relay-lemma every later step uses

derivation: V4-CHORD
  statement: two points r(α), r(β) of a unit circle about p, at angular separation δ = |α − β| ∈ [0°, 180°], are at distance 2 sin(δ/2); so
    the distance is 1 at δ = 60°, below 1 for δ < 60° and above 1 for 60° < δ ≤ 180°; and for β > α the chord from r(α) to r(β)
    points in the direction (α + β)/2 + 90°
  uses only: the law of cosines on the isosceles triangle p, r(α), r(β)
  not claimed: anything about circles of other radii
  argument: § 1.4 argument
  verdict: derived
  grade: hand
  minds: 1
  model: α = 0°, β = 60° — r(0°) = (1, 0), r(60°) = (1/2, √3/2), distance 1
  prior art: known — elementary
  handoff: none — a relay-result for stage 2

control: v4-chord
  of: V4-CHORD — the chord is 1 at 60°, below 1 at 59°, above 1 at 61°, checked in exact arithmetic (sympy)
  run: python3 -c "import sympy as s;d=lambda a,b:s.sqrt((s.cos(a)-s.cos(b))**2+(s.sin(a)-s.sin(b))**2);r=s.pi/180;print(s.nsimplify(s.simplify(d(0,60*r)))==1, bool(d(0,59*r)<1), bool(d(0,61*r)>1))"
  expect: True True True
  fault: python3 -c "import sympy as s;d=lambda a,b:s.sqrt((s.cos(a)-s.cos(b))**2+(s.sin(a)-s.sin(b))**2);r=s.pi/180;print(s.nsimplify(s.simplify(d(0,90*r)))==1, bool(d(0,59*r)<1), bool(d(0,61*r)>1))"

## 1.4 argument

|r(α) − r(β)|² = 1 + 1 − 2 cos δ = 4 sin²(δ/2). On [0°, 180°], sin(δ/2) increases, and 2 sin 30° = 1. The midpoint of the chord lies in the
direction (α + β)/2 from p, and the chord is perpendicular to that direction, pointing ccw (+90°) when going from the smaller angle to the larger.
