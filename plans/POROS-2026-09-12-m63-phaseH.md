# Poros — M63 phase H, building a base FOR a rotation (2026-09-12)

*Advising the engineer opening `plans/M63-phaseH-a-base-for-a-rotation.md` (commit `448e186`).
Uncommitted by me; the engineer commits it by path. Cards are numbered `PH-n` and are stable
identifiers — cite them, never renumber. Phase G's advisory record is
`plans/POROS-2026-09-12-m63-rotation-screen.md`, cards `RS-1`…`RS-7`.*

**The frame, on its five axes, as I read it before asking anything.**

| axis | as the record states it | address |
|---|---|---|
| object | a base built *for* `cos θ = 11/32 + (3/32)√33`, rather than `[Parts2020a]`'s lattice inherited | phase H §0, §4 |
| question | which of the six stamped requirements on a candidate base are actually necessary | §4's table, three rows stamped `INHERITED` |
| discipline | 2-adic arithmetic of `K = ℚ(√3,√11)`, decided by a residue map into `𝔽₄`; the solver only afterwards | §2.2, and `tools/residue_colouring.py` |
| audience | the product owner tonight; a stranger at the write-up, answering `[Parts2020a]` §4's sentence | §1 |
| product | a base that defeats the residue certificate, then an arena a solver refuses | §0 sentence 2 |

**Where I disagree with the coordinator, up front, since he asked for it.** His "direction inversion"
— that growing a base makes the four-colouring harder to fire, "backwards from every other argument in
this project" — is **not an inversion** (PH-6). It is this project's ordinary monotonicity seen once
through a sufficient condition instead of directly, and carrying it in the record as a surprise invites
an agent to distrust a correct monotone argument for feeling too familiar.

---

## Evidence inventory

- `plans/M63-phaseH-a-base-for-a-rotation.md`, the handoff, 317 lines — read against: six requirements whose `PROVED` / `INHERITED` stamps each survive a second reading — surprised: yes; **H1 is stated one prime stronger than the certificate it is derived from** (PH-2), and **F1 is a falsifier that cannot fire and whose firing would be good news** (PH-1)
- `data/m62/m63-phaseG-screen-r2.44.json`, `results[]`, all eleven rotation classes — read against: the per-prime residue reports agreeing with the both-primes criterion of §2.2 — surprised: yes, decisively; the new rotation's row is `free_delta: []` at prime 17 and `free_delta: [[0,0]]` at prime 239, so the rotation died at **one** prime while the other was already covered by inherited material (PH-2)
- the same file, the eleven `verdict` fields against the five `residue_certificate` fields — read against: nothing yet, since the handoff never states the base rate — surprised: yes; **six classes defeat the certificate at both primes and five of those six are four-colourable anyway** (PH-4)
- `tools/phaseg_screen.py:307-375`, the residue certificate — read against: a check that can be skipped without saying so — surprised: yes; the distance-2 negative control is guarded by `if two_pair and not mono_two`, so a base with no distance-2 pair silently loses the control while `usable` still becomes `True` (PH-5)
- `tools/residue_colouring.py:46-64`, `mod2` and `residue_of_coords` — read against: a `None` path that a caller could read as a benign verdict — surprised: yes; `usable: False` is returned on the same footing as silence, so **a base can "pass" the certificate by making it inapplicable** (PH-5)
- `tools/residue_colouring.py:67-88`, `colour()` — read against: whether the screen inherits its per-unit-component basepoints — surprised: no, in the safe direction; `phaseg_screen.py:333` computes `phi` from the absolute origin and never calls `colour()`, so the cross-copy differences are meaningful. Had it used `colour()`, a unit-disconnected base would have produced a meaningless `Δ`
- `tools/typem.py:1128-1160`, `parts_lattice` — read against: §4's phrase "`parts_lattice`'s four generators" — surprised: yes; there are no generators in the source. It is a congruence lattice (`(a−b), (a−c), (a−d)` even, `a−b+c+d ≡ 0 mod 4`) cut by an exact totally-real disk, and its coordinates confine it to a **4-dimensional ℚ-subspace** of the 8-dimensional `K²` (PH-3)
- the witness `u` of §3, re-derived rather than lifted — read against: §3's instruction not to trust the numbers — surprised: no; `|u|² = 7/3 + (1/3)√33` exactly, and `φ(u) = (0,0)` at **both** primes, so it is inside the colouring's domain and the certificate stays applicable when it is added
- the same file, `cross.equal_radius_ordered` across all eleven classes — read against: `ρ₁₅` being the only class carrying the equal-radius kind that `u` would supply — surprised: yes, and it corrected me; **two** classes carry one, both have a `d² = 0` representative, and the second (`cos = 5/16 - 3/16√33`, 18 pairs, 54 monochromatic cross edges at prime 239) is `sat` (PH-8)
- `data/m62/rotations-exact-moser-r2.05.json` — read against: whether a second base is already censused and might already realise a live kind — surprised: unread (I list it as a standing finding; it is a census of rotations, not a residue screen, so it cannot decide the question on its own)

---

## PH-1 — F1 is a falsifier that cannot fire, and its firing would be good news

question: can-the-one-kind-falsifier-fire-and-would-it-mean-what-it-says
  evidence: `data/m62/m63-phaseG-screen-r2.44.json`, row `cos = -11/32 + -3/32*sqrt33`, reports
    `kinds: 2` on `parts_lattice` with squared radii `{1.1525, 3.2766}` and `{2.0132, 3.9846}` —
    all four inside `2.0612²`, so they survive the tightest cut phase H would use
  expected: a falsifier whose uninformative outcome is reachable, per §8 discipline item 6
  ask: can F1's premise — "the base carries only ONE kind at this angle" — hold on the §4 candidate,
    and if it did, would it weaken the direction?
  if it cannot fire: F1 is struck and replaced by the count that does carry weight
  if it can fire: F1 stands, but its verdict must be inverted, because one kind is survivable
  answered by: derivation, on the artifact
  cost: nil
  rank: 8
  status: answered — it cannot fire, and its firing would be good news

**Reachability.** Any base containing `parts_lattice` at a radius that admits `u` already carries two
kinds before `u` is added, and `u`'s diagonal makes three. F1's premise is unreachable on the candidate
§4 names, at every radius the phase would use. Under this project's own rule — *state the uninformative
outcome and confirm it is reachable* — F1 has not been tested by passing.

**Meaning, which is the half that matters.** Every pair inside one non-centre kind shares one `d²` and
therefore one valuation, so a kind contributes either the class `0` or only nonzero classes, never both.
The centre family supplies all three nonzero classes and never `0` (`d² = 1`) — confirmed on the
artifact, where `Delta` at prime 239 is exactly `[[0,1],[1,0],[1,1]]`. So:

> **The certificate is defeated at a prime iff at least one non-centre kind is monochromatic there.**

One non-centre kind suffices, and the diagonal (`d² = 0`) is monochromatic at every prime. **A base whose
only non-centre kind is `u`'s diagonal is the minimal surviving configuration** — precisely the object the
phase is trying to build, and F1 would have reported it as bad news. Replace F1 with: *per prime, the
number of non-centre kinds with `v_𝔭(d²) > 0`, which must be ≥ 1 at each.*

**Ruling: adopted by the engineer, F1 struck with its reason recorded rather than silently omitted.**

---

## PH-2 — H1 asks for one prime more than the certificate does, and the record already shows the difference

question: is-the-live-sigma-condition-per-prime-or-at-both-primes
  evidence: same row, the two `residue_report` entries. Prime `sqrt33_2adic(17)`: `Delta` all four
    classes, `monochromatic_cross: 24`, `free_delta: []`. Prime `sqrt33_2adic(239)`: `Delta` missing
    `[0,0]`, `monochromatic_cross: 0`, `free_delta: [[0,0]]`. The 24 monochromatic edges are kind 1,
    `σ = 17/6 + (5/18)√33 ≈ 4.429` — nowhere near the diagonal `σ = 14/3 + (2/3)√33 ≈ 8.496`
  expected: §2.2's criterion, that a base survives only by realising a `σ` live at **both** primes
  ask: does defeating the certificate need one kind monochromatic at both primes, or one kind
    monochromatic at each prime — not necessarily the same kind?
  if one at each: the design target is a single prime, the space is ~4× wider, and `is_live` as written
    would reject material that works
  if one at both: §2.2 and §5.2 stand as written
  answered by: derivation, then the artifact
  cost: nil
  hunch: one at each — the two primes are two independent colourings and either one suffices to kill
  falsifier: a reason `φ` at the two `S` values is not two independent four-colourings of `K²`
  rank: 2
  status: answered — one at each, and `parts_lattice` already supplies prime 17 at this angle

The certificate at prime 𝔭 fires iff some `δ ∈ 𝔽₄` lies outside `Δ_𝔭`. `Δ_17` and `Δ_239` are computed
from two different colourings, and **either one firing four-colours the arena**. So survival is

> `Δ_17 = 𝔽₄` **and** `Δ_239 = 𝔽₄` — i.e. some kind monochromatic at 17 **and** some kind monochromatic
> at 239, *not necessarily the same kind*.

`parts_lattice` at this angle already satisfies the first half. **It died at 239 alone.** §5.2's
`is_live` requires `all(... for S in PRIMES)` and therefore reads kind 1 — the very kind that covers 17
— as dead. §4's H1 is stronger than the certificate it is derived from.

**What this buys.** The residue field is `𝔽₄`, so a per-prime condition is one class in four against one
in sixteen. More usefully, it removes the pinning: the diagonal is the **only** kind whose `σ` is fixed
(`1/(1−cos θ)`, forcing radius exactly 2.0611 and hence a whole new lattice), while off-diagonal kinds
are a one-parameter family in `λ` with free radii. The phase does not have to reach `u`.

**Ruling: confirmed by the engineer digit for digit, adopted as a correction to the handoff.** He added
a control I had not seen: `d²` is *not* invariant under the sign of `cos θ` (kind 1 is `≈ 0.543` at one
sign and `≈ 8.31` at the other), yet the residue verdict is identical at both signs for every kind at
both primes — forced, because `𝔽₄` has characteristic 2 so `φ(−v) = φ(v)`. That control could have
failed and did not.

---

## PH-3 — the generator's image is a 4-dimensional subspace, and `u` is outside it

question: what-is-the-image-of-the-generator-the-phase-is-about-to-enumerate-over
  evidence: `tools/typem.py:1128` writes every base point as `x = (a + b√33)/12`, `y = (c√3 + d√11)/12`
    — so `x ∈ ℚ ⊕ ℚ√33` and `y ∈ ℚ√3 ⊕ ℚ√11`, a 4-dimensional ℚ-subspace of the 8-dimensional `K²`;
    §3's witness has `x = (1/3, −1/2, −1/6, 0)` and `y = (1/3, 1/2, 1/6, 0)`, outside it in both
    coordinates
  expected: §6's failure was a property of one sweep's generator
  ask: is the same restriction built into the base the phase inherits, and what does escaping it cost?
  if it is: §6's failure is structural rather than incidental, and the cost of leaving the subspace is
    a rank increase that must be priced before a core is spent
  if it is not: the closure is a modest enlargement and can be built directly
  answered by: derivation, then a count the engineer runs
  cost: nil to see; minutes to count
  rank: 3
  status: answered — it is structural; the engineer priced it at rank 7 and 19,921 points

§6's sweep failed because its generator could not represent the object it was searching for. **The same
restriction is built into `parts_lattice` itself**, which is why `u` is absent from it: not a shortage of
radius, but a 4-dimensional coordinate shape inside an 8-dimensional space. §4's phrase "`parts_lattice`'s
four generators" also has no referent in the source — it is a congruence lattice, and a ℤ-basis has to be
derived before the closure can be formed.

**Priced by the engineer, and my estimate was wrong in the useful direction.** The closure
`Λ_parts + ℤ⟨Galois orbit of u⟩` has **rank 7, not 8** — the two spans meet only at 0 and every generator
has a zero `√33`-slot in `y` — giving **5,317 points at r = 2 and 19,921 at r = 2.44**, with `Λ_parts`
contained and `0 of 3,433` missing as a positive control. I had priced a five-figure disaster; the arena
at ~39,800 vertices is large but the expected verdict is SAT and that is the cheap direction. He also
recorded the boundary: **ζ₆-closure would force rank 8 and a cut of ~1.9·10⁸**, and he is dropping
ζ₆-closure deliberately and saying so.

**The rule to carry, which is the durable part:** before believing any zero over a family, write down the
generator's image as a subspace and exhibit the target's coordinates inside or outside it. A positive
control proves the instrument finds things of the shape it can represent, and nothing else.

---

## PH-4 — the direction has a measured base rate on disk, and the handoff does not state it

question: what-happens-to-a-base-that-defeats-the-certificate
  evidence: `data/m62/m63-phaseG-screen-r2.44.json`, the eleven `verdict` fields read against the five
    `residue_certificate` fields. Five classes are certificate-killed. **Six defeat the certificate at
    both primes — and of those six, five are `verdict: "sat"` and only `cos = -7/8` (the record's own
    rotation, `ρ₁₅` relabelled) is `unsat`**
  expected: nothing — the handoff states F4 ("the arena is four-colourable anyway") as "the expected
    outcome" without a number, so the direction's prior is carried as a feeling
  ask: on the nearest reference class anyone holds, how often does defeating the certificate produce a
    refusal?
  if rarely: the corrected H1 is necessary and measured-not-sufficient, and the phase's report must
    carry that number beside its verdict rather than discovering it again
  if usually: a live kind is close to sufficient and the design criterion is nearly the whole problem
  answered by: the record — already computed, never assembled
  cost: nil
  rank: 4
  status: answered, then **narrowed by PH-8** — one in six across the whole class, but the class is not
    homogeneous and the sharp reference set is n = 2

> **On `parts_lattice` at radius 2.44, six of eleven rotation classes defeat the residue certificate at
> both primes. Five of the six are four-colourable by the solver. The sixth is `ρ₁₅`.**

This is not a reason to stop — it is a different base and a different question, and a base rate over
rotations on one lattice is not a base rate over lattices at one rotation. It is the reason to **state
the expected outcome before the run and score it**, per §8 discipline item 1, and to report a SAT at the
end as *the fifth of six*, not as a surprise. RS-7's open hunch — *whether a live σ is ever sufficient is
untested* — is in fact tested, five times, negatively, and the ledger entry should say so.

**It also aims the phase.** If defeating the certificate is common and refusing is rare, the certificate
is not the binding constraint and H6 ("enough unit-distance structure", `INHERITED and unquantified`) is.
Six data points say the phase's real risk is not finding a live kind but finding one inside a base rich
enough to refuse — and `19,921` points at 8.3 edges per point is the first time that has been affordable.

---

**Superseded in part by PH-8.** The count is right and the reference class is wrong: five of the six do
not carry the feature `u` would supply, so they are not the set the new base joins. Read PH-8 first.

---

## PH-8 — my own base rate was over-broad, and the sharp reference set has a counterexample on disk

question: which-rotations-are-the-right-comparison-for-a-base-that-has-acquired-u
  evidence: `data/m62/m63-phaseG-screen-r2.44.json`, the `cross.equal_radius_ordered` field across all
    eleven classes. **Two** classes carry an equal-radius kind, not one: `cos = -7/8` (30 pairs, `σ = 8`)
    and `cos = 5/16 - 3/16√33` (18 pairs, `σ = 7/3 + (1/3)√33`). The first is `unsat`; the second is
    `sat`
  expected: PH-4's six certificate-defeating classes are one homogeneous reference set
  ask: is the set the new base joins "classes that defeat the certificate", or the narrower "classes
    carrying an equal-radius kind" — the feature `u` is being acquired to supply?
  if the narrower: the prior is 1 of 2 rather than 1 of 6, and there is a concrete on-disk instance that
    has the feature and four-colours anyway, which is a calibrated negative the phase can interrogate
  if the wider: PH-4 stands as written
  answered by: the record, then exact arithmetic on the two σ values
  cost: minutes
  hunch: the narrower — `u` supplies an equal-radius kind and nothing else
  falsifier: the second equal-radius class turning out not to carry a `d² = 0` representative, making
    `ρ₁₅` the only one and the comparison n = 1
  rank: 1
  status: answered — the narrower, and the falsifier did not fire

**Two corrections to myself, in order of how much they matter.**

**1. "Diagonal" is not a class invariant, and I nearly built a hypothesis on it.** §8 discipline item 3
already says the census's `diag` column is not invariant under the base's symmetries. It bites here:
`d²(σ, cos) = σ − (σ−1)/cos` flips with the sign representative, so `ρ₁₅` reads `d² = 0` at `cos = +7/8`
and `d² = 16` at `cos = −7/8` — the same arena under `v ↦ −v`. Checked exactly, both classes:

| class | σ | `d²` at `cos` | `d²` at `−cos` |
|---|---|---|---|
| `ρ₁₅` | `8` | `16` | **`0`** |
| `5/16 − 3/16√33` | `7/3 + (1/3)√33` | `14/3 + (2/3)√33` | **`0`** |

So **both** classes carry a genuine `d² = 0` diagonal kind at one of their representatives. The invariant
statement is *carries an equal-radius kind*, equivalently *the base holds a point at squared norm
`1/(2 ∓ 2cos θ)`* — the diagonal and the antipodal target being one fact seen at two signs.

**2. The reference set is n = 2, and one of the two is a negative.** `cos = 5/16 − 3/16√33` has the
feature the whole phase is being built to acquire — an equal-radius kind with a `d² = 0` representative —
and **its arena at radius 2.44 is four-colourable.** So:

> Acquiring `u`'s diagonal kind is necessary to defeat the residue certificate and is **demonstrably not
> sufficient**, with the counterexample already on disk.

**And the count does not predict.** `5/16 − 3/16√33` has **54** monochromatic cross edges at prime 239 —
more than `ρ₁₅`'s 30 — and is `sat`. Any instinct to maximise the monochromatic-edge count as a progress
measure is refuted before it is formed.

**What this is worth, which is more than the discouraging number it replaces.** The phase has had no
calibrated bed: a known negative that carries the target feature. It has one, free, on disk, at the same
radius on the same lattice with the same tooling. **The cheap question to put beside the expensive build
is: what does `ρ₁₅` have that `5/16 − 3/16√33` lacks?** Both have an equal-radius kind; both defeat the
certificate; one refuses. Whatever separates them is the phase's real target, and it is neither `H1` nor
the certificate — which is PH-4's re-aiming toward `H6`, arriving with an instance attached instead of a
base rate.


## PH-5 — two ways the certificate reports a benign verdict while checking nothing

question: can-the-certificate-pass-a-base-by-becoming-inapplicable
  evidence: `tools/phaseg_screen.py:341` guards the negative control as `if two_pair and not mono_two`,
    so a `None` `two_pair` skips it and `usable` still becomes `True` on line 345; and lines 337-340
    return `usable: False` on `non_integral or mono_unit`, which a caller reads on the same footing as
    silence
  expected: a filter that says which of "fired", "silent", and "could not be evaluated" happened
  ask: on a new base, can the certificate return a benign verdict without having tested anything?
  if it can: a design loop optimising against the certificate can satisfy it by breaking its
    applicability, and the phase's headline filter switches itself off without saying so
  if it cannot: the two-outcome framing of §0 sentence 2 is complete
  answered by: the record — read the guard
  cost: nil
  hunch: it can, and a new base is exactly where both paths open
  falsifier: a caller that distinguishes `usable: False` from `free_delta: []` before proceeding
  rank: 5
  status: open — the engineer holds the caller

Two paths, both silent:

1. **`two_pair is None`.** The control that proves `φ` is Theorem B's colouring — a distance-2 pair must
   come out monochromatic — is skipped when the base has no distance-2 pair, and `usable` is still set
   to `True`. `parts_lattice` always has one; a sparse or tightly-cut base need not. Assert
   `two_pair is not None`, or refuse.
2. **`usable: False` reads as silence.** If any base point is not 2-integral from the origin, or any
   interior edge comes out monochromatic, the row is marked unusable and the screen proceeds — correctly,
   but **the phase's two boxes are "fires" and "silent", and this is a third thing.** A base that breaks
   2-integrality defeats the certificate by making it inapplicable, which is a Goodhart hazard for any
   loop that iterates on bases *against the certificate*.

`φ(u) = (0,0)` at both primes, so `u` itself is in the domain and this does not bite today. It bites the
first time a base is generated rather than chosen.

**One count now reconciled rather than left hanging.** `classes: [1728,1728,1728,1682]` sums to 6866
against `vertices: 6865`; the engineer traced the excess to the S-side copy of the centre, which `Arena`
masks out while the certificate colours all `2n` indices — so the check runs on a **superset** of the
arena's edges, the conservative direction. Harmless, and now in writing.

---

## PH-6 — the "direction inversion" is ordinary monotonicity, and the record should not call it a surprise

question: is-the-certificates-monotonicity-really-backwards
  evidence: §7 F3 — "*this cannot fire against you … which is the exact opposite of the usual
    monotonicity in this project, where adding material only tightens*"
  expected: an inversion, per the coordinator's brief
  ask: does growth move colourability and the certificate in opposite directions, or the same one?
  if the same: F3's content is right and its framing is wrong, and the framing is the dangerous half
  if opposite: every monotone argument in the phase needs re-checking
  answered by: derivation
  cost: nil
  rank: 6
  status: answered — the same direction

Adding material can only make a graph harder to colour. Adding material can only enlarge `Δ` and so only
make the certificate — *a sufficient condition for four-colourability* — harder to fire. **Those are the
same statement about the same quantity**, seen once directly and once through a one-sided filter. F3's
conclusion (the elimination is not recoverable by enlarging the base) is correct and is the ordinary
anti-monotonicity of a negative verdict.

Why the framing matters rather than being pedantry: an agent told to expect an inversion will look for
one, and the one thing that *is* unusual here — that a filter can be defeated by breaking its
applicability rather than its conclusion (PH-5) — is not an inversion either, and will be missed while
the ordinary monotonicity is being treated as exotic. I would delete the last sentence of F3 and keep the
rest.

---

## PH-7 — a shortcut I proposed, tested, and killed, and the criterion that survives it

question: can-an-existing-deep-ray-of-the-base-be-made-monochromatic-cheaply
  evidence: at prime 239 every one of the 12 points at `|p|² = 2 + (2/9)√33` (radius 1.8101) has
    `φ = (0,0)`, while every one of the 12 at `|p|² = 5/6 + (1/18)√33` has `φ ≠ (0,0)` — computed from
    `tools/residue_colouring.py` on points found by the lattice's own `S`/`P` test
  expected: on a ray through a residue-zero point, every cross-edge partner is monochromatic, because
    the residue map is multiplicative
  ask: does `Λ_parts` already contain a 239-deep ray whose second cross-edge partner would defeat the
    certificate, making the rank-7 module unnecessary?
  if yes: the base is `Λ_parts` plus a handful of points rather than 19,921
  if no: the rank-7 construction is the route, and the reason is worth having
  answered by: derivation, then exact arithmetic on the two candidate points
  cost: minutes
  hunch: yes — the deep shell already exists, only its partner is missing
  falsifier: the second root's scalar failing to be 2-integral, so that the partner is shallower than
    the point it was scaled from
  rank: 7
  status: **killed by its own falsifier**

**What was verified, and it is worth keeping.** The residue map is multiplicative on the valuation ring:
`φ(μ·w) = φ(μ)·φ(w)` in `𝔽₄`, tested on 48 (point, scalar) pairs across both primes, **48 agree, 0
disagree**. Hence for a collinear cross pair `(u, λu)`,

> `φ(u) − φ(λu) = φ(u)·(1 + φ(λ))` in `𝔽₄`, so the kind is 𝔭-monochromatic **iff `φ(u) = 0` or
> `φ(λ) = 1`** — and in general, with no integrality caveat, **iff `v_𝔭(1 − λ) + v_𝔭(u) > 0`.**

Two mechanisms, and the handoff knows only one: `λ = 1` is the diagonal, `λ = −1` the antipodal pair
(`v(1 − λ) = v(2) > 0`, monochromatic at every prime for any negation-closed base), and a quarter of all
`λ` satisfy `φ(λ) = 1`.

**What was killed.** The ray through the 239-deep shell carries exactly two cross-edge partners, the two
roots of `λ² − 2cos θ·λ + (1 − 1/n)`. `Λ_parts` holds one. The other is
`λ₂ = 13/16 + (1/16)√33`, giving a point at `|q|² = 223/96 + (109/288)√33`, radius **2.12063** — inside
the endpoint bound 2.12458 by 0.004, with Galois conjugate 0.1488 > 0 so the totally-real cut admits it,
and **not** in `Λ_parts` (`12·x` is `−49/4`, not an integer). Both roots satisfy the law exactly. But
`φ_239(q) = (0,1) ≠ φ_239(w) = (0,0)`, and at prime 17 `q` is not even 2-integral. **The kind is not
monochromatic and the shortcut is dead.**

**The mechanism of the miss, which is the part that generalises.** `φ(λ·w) = φ(λ)·φ(w)` needs `λ` in the
valuation ring. Here `λ₁ + λ₂ = 2 cos θ`, and `2 cos θ` is **not** 2-integral at either prime (checked:
`residue_of_coords` returns `None` for both `cos` and `2cos`). So `min(v(λ₁), v(λ₂)) < 0`: **on every ray,
at least one of the two partners has a non-2-integral scalar**, and multiplying a deep point by it makes
the partner *shallower*, not deeper. That is exactly why the diagonal is special — it is the one place the
two roots coincide at `λ = 1` and the argument cannot leak.

**One identity worth keeping, and its limit.** `(1−λ₁)(1−λ₂) = 2 − 2cos θ − 1/n`, so
`v(1−λ₁) + v(1−λ₂) = v(2 − 2cos θ − 1/n)`, root-free. Tested on all four recorded radii: the value is
non-2-integral at every one and exactly `0` at the diagonal norm `(7+√33)/3`. So it is **too weak to be
the design filter** — a negative sum does not say which root is bad — and I record it as an identity, not
an instrument. The instrument remains §5.2's `is_live`, corrected to run per prime (PH-2).

---

## hunch ledger

hunch: the-live-sigma-condition-is-per-prime
  claim: defeating the residue certificate needs one kind monochromatic at each prime above 2, not one
    kind monochromatic at both; §4 H1 and §5.2 `is_live` are one prime too strong
  basis: derived
  address: two independent `𝔽₄` colourings, either of which four-colours the arena if some `δ` is free
  falsifier: a reason `sqrt33_2adic(17)` and `sqrt33_2adic(239)` are not two independent colourings
  registered: 2026-09-12
  status: confirmed (by: derivation, then `data/m62/m63-phaseG-screen-r2.44.json` — the new rotation's
    row is `free_delta: []` at 17 with 24 monochromatic cross edges from `σ = 17/6 + (5/18)√33`, and
    `free_delta: [[0,0]]` at 239; the engineer independently recomputed all four kinds at both primes
    and both signs of `cos`)

hunch: the-one-kind-falsifier-cannot-fire
  claim: F1's premise is unreachable on any base containing `parts_lattice` at a radius admitting `u`,
    and a single non-centre kind is a surviving configuration rather than a weakening one
  basis: read
  address: `data/m62/m63-phaseG-screen-r2.44.json`, row `-11/32 + -3/32*sqrt33`, `kinds: 2`, all four
    squared radii inside `2.0612²`
  falsifier: a cut radius the phase would actually use at which one of the two kinds loses an endpoint
  registered: 2026-09-12
  status: confirmed (by: the four recorded radii, 1.0735 / 1.8101 / 1.4188 / 1.9961, all below 2.0612;
    and by the derivation that the centre family supplies the three nonzero classes and no kind supplies
    both `0` and a nonzero class)

hunch: a-deep-ray-of-the-base-can-be-completed-cheaply
  claim: `Λ_parts` already holds a 239-residue-zero shell, so adding the second cross-edge partner on
    that ray defeats the certificate at 239 without the rank-7 module
  basis: measured
  address: all 12 points at `|p|² = 2 + (2/9)√33` have `φ_239 = (0,0)`
  falsifier: the second root `λ₂` failing to be 2-integral, so `φ(λ₂ w) ≠ φ(λ₂)φ(w)` and the partner is
    shallower than `w`
  registered: 2026-09-12
  status: killed (by: exact computation — `λ₂ = 13/16 + (1/16)√33` satisfies the law, puts the
    partner at radius 2.12063 inside the bound, and gives `φ_239(q) = (0,1) ≠ 0`; `q` is not 2-integral
    at 17 at all. The mechanism: `λ₁ + λ₂ = 2cos θ` and `2cos θ` is not 2-integral, so one root per ray
    is always bad)

hunch: the-residue-map-is-multiplicative
  claim: `φ(μ·w) = φ(μ)·φ(w)` in `𝔽₄` for `μ` in the valuation ring, so a kind's monochromaticity
    factorises as `φ(u)·(1 + φ(λ)) = 0`
  basis: derived
  address: `φ` is reduction at a prime of `K(i)` with residue field `𝔽₄`, and reduction is a ring map
  falsifier: one (point, scalar) pair with `φ(μw) ≠ φ(μ)φ(w)`
  registered: 2026-09-12
  status: confirmed (by: 48 pairs across both primes and six scalars including non-units, 48 agree,
    0 disagree — and by the general form `v_𝔭(1−λ) + v_𝔭(u) > 0`, which needs no integrality hypothesis
    and reproduces the diagonal, the antipodal and the centre verdicts)

hunch: defeating-the-certificate-is-far-from-sufficient
  claim: on the nearest reference class anyone holds, five of the six rotation classes that defeat the
    residue certificate at both primes are four-colourable anyway
  basis: read
  address: `data/m62/m63-phaseG-screen-r2.44.json` — six rows with `residue_certificate: null`, of which
    five have `verdict: "sat"` and only `cos = -7/8` is `unsat`
  falsifier: a row I have miscounted, or a `null` certificate that means "not attempted" rather than
    "did not fire"
  registered: 2026-09-12
  status: open — the count is read off the artifact; the `null` semantics are the engineer's to confirm

---

## What I did not do

1. **I did not launch any search, solver, or sweep.** Everything above is a read of committed artifacts
   plus exact arithmetic on at most a few dozen points, run to check a claim I was about to make. The
   rank-7 count, the ray scan, and every verdict belong to the engineer's instruments.
2. **I did not read `data/m62/rotations-exact-moser-r2.05.json`.** A second base is already censused for
   rotations. It carries no residue screen, so it cannot decide PH-2 or PH-4 on its own — but if the
   phase ever wants a second base rate, or a sanity check that the criterion behaves on a base that is
   not `parts_lattice`, it is on disk and it is free. Standing finding.
3. **I did not confirm the `residue_certificate: null` semantics** that PH-4's count rests on. If `null`
   can mean "not attempted" rather than "did not fire", the base rate moves. One line for the engineer.
4. **I did not check whether the rank-7 closure keeps the unit hexagon** — it contains `Λ_parts`, so it
   does, but the argument that `Δ` holds all three nonzero classes runs through the centre family, and
   on a base that is *not* a superset of `parts_lattice` that step needs redoing rather than reusing.
   RS-5's caveat 4, still standing, now with a second consumer.
