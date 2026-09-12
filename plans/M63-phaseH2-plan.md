# M63 phase H2 — the plan

*Written 2026-09-12 by the phase-H2 planner, for a **separate implementing agent with zero memory of
the conversation that produced it**. Self-contained on purpose: everything you need is here or named by
absolute path. The mission brief this plan answers is
`/home/kooshi/source/lean-dir/plans/M63-phaseH2-find-the-base.md`; read this file first and whole, then
that one, because **§2 below overturns the brief's central target and the brief's own author asked for
exactly that verdict.***

**The product owner's ruling that supersedes the brief's §2:** `plans/M63-phaseH2-the-family.md`
(§4, §5, §8). **The prior-art gate's report:** `plans/M63-phaseH2-prior-art.md` — read §PA.0, it is one
page and it carries the closed formula this plan's §3.2 is built on. **Advisory record for this phase:**
`plans/POROS-2026-09-12-m63-phaseH2.md`, cards `PH2-1`…`PH2-10` (the advisor, Poros). Stage 1's: `plans/POROS-2026-09-12-m63-phaseH.md`, cards `PH-1`…`PH-10`.
Cards are cited, never renumbered.

---

## §0 — Restart point, in one paragraph

Every unit-distance graph known to need five colours is built from **one lattice joined to a rotated
copy of itself** (Parts's "type M"), and in fifty years only **one rotation angle** has ever worked:
`ρ₁₅`, `cos θ = 7/8`. Phase G found a second candidate angle and then killed it on Parts's lattice.
Stage 1 (phase H) built the first base ever designed *for* a rotation rather than inherited, defeated
the four-colouring argument that had killed that angle, and the resulting graph was **still
four-colourable, in 2.1 seconds**. The brief for this session says the gap is one arithmetic quantity —
*how many lattice points lie on one fixed circle* — and asks you to maximise it from 8 to about 30.
**That target is achievable, already achieved on paper, and not the binding constraint;** §2 gives the
evidence and §3 gives the target that replaces it. The replacement is cheaper, it is aimed at a field
where a sixth colour is not already ruled out, and its screen costs microseconds.

**And it has already produced an object, which is the one thing to read this plan for.** The rotation
`ρ₆₃` (`cos θ = 31/32`) on Parts's own lattice cut at radius 4 gives **25,843 points, 10.65 unit edges
per point against the record's 8.32, and 126 cross edges decomposing 60 + 36 + 30 — the record's exact
decomposition — with the residue certificate defeated at both primes and a field, `K(√7)`, that is
6-open where the record's is 5-sealed.** All of that is measured (§4, item E4). **Nobody has ever asked
a solver whether it is four-colourable.** That question, with its controls, is this session's product.

## §1 — The two sentences that must survive every report

1. **The new rotation is un-eliminated, not alive.** One argument against it can no longer be made.
   Nothing shows it produces anything. Forgetting this oversells every result in this phase.
2. **Silence is not evidence.** The four-colour certificate fires ⟹ the graph is four-colourable; it
   stays silent ⟹ *nothing whatever*. Forgetting this stops you at the first ambiguous answer.

A third, from the advisor's card `PH-10`, which is the honest scope of the whole direction and belongs
in the closing report verbatim:

3. **No type-M arena has ever been shown to PRODUCE five-chromaticity rather than to CONTAIN it.**
   `ρ₁₅`'s arena at radius 2.44 contains **Heule-510** — a 510-vertex graph certified 5-chromatic
   *before* type M is applied to it (`chromaticNumber_heule510`, kernel-checked, ledger row 53). So the
   phase's positive reference is one instance with a known external cause beside one negative, not two
   understood instances.

---

## §2 — Verdict on the mission's framing, with the evidence

The brief's §2 says: *"The quantity to maximise is the number of module points lying on one fixed
circle"*, calibrated on three rows — the record's lattice has **30** points on its circle and refuses
four colours; a second rotation has **18** and does not; stage 1's base has **8** and does not.

**The theorem underneath it is sound and you will use it.** Delete from a type-M arena every cross edge
whose two base-point endpoints have the same residue at one of the two primes above 2; what remains has
every cross-edge residue difference nonzero, so the residue colouring `φ` colours both halves and the
arena is four-coloured. Hence

> **`margin(arena) = min` over the two primes of the count of residue-monochromatic cross edges**

is an exact upper bound on how *few* cross edges a refusal could be carried by, and `margin ≥ 1` is
**necessary**. That is `PH-9`, and it is a theorem, not a correlation.

**Five things say the count is the wrong objective.** Each has an address; four are measured here.

**(a) The count is unbounded, so "maximise it" has no maximum — and the brief's own falsifier §8.1
("if the ceiling is below ~18 the mission is over") cannot fire.** The circle is a coset of the
norm-one group of `K(i)`, which is infinite and rationally parametrised, so a module with any
prescribed number of circle points exists (advisor `PH2-1`, derived). Exhibited exhaustively here as
well: enumerating K-points of `|p|² = (7+√33)/3` by coordinate denominator `q`, with the search box
forced by the fixed conjugate radii, gives **0 points at `q ≤ 3`, 12 at `q = 6` (containing the brief's
witness `u`), and 36 at `q = 12`.** **36 exceeds the record's 30.** So the brief's §2 closing question —
*"can a module in ℚ(√3,√11) put ~30 points on the circle?"* — is **YES, at denominator 12, before any
search.** The live quantity was never the count; it is the *price* of a module holding them.

**(b) And the price is paid in exactly the thing a base needs.** The ℤ-span of those 36 points is a
rank-8 module of covolume 42.49 whose totally-real cut at radius 2.44 is **3,037 points** — affordable,
and holding all 36 circle points. It has **0 points of norm 1, and therefore 0 unit edges.** Not few:
none. For a module base, a unit edge exists iff the module contains a point of squared norm exactly 1
(differences of module points are module points), so this is forced rather than unlucky.

**(c) So requirement "H6" is not unquantified after all — and it is a theorem this repository already
owns, not a new conjecture.** The brief (§6) calls *"enough unit-distance structure"* inherited and
unquantified, and says it would most like that judgement disproved. It is not disproved; it is
**quantified**: a module base is a **Cayley graph** of the module, with connection set its points of
squared norm 1, so **the unit-distance structure IS the norm-1 shell count**, and every point's unit
degree is that count (truncated only by the cut). That is `addCayleyMap`, ledger row 56,
`Proofs/HadwigerNelson/LocalGlobal.lean` (prior art `[Moorhouse2010]` §4.2, `[CervantesKrebs2023]`) —
**cite it, do not re-measure it.** Parts's lattice: **30** points of norm 1, 28,566 unit edges on 3,433
points, mean degree 16.64 (the cut truncation). Stage 1's base: 4.19–5.49 edges per point. The 36-point
module: **0**.

Consequently the phase's two requirements are **two shell counts of the same module — norm 1 and norm
`n`** — which is exactly why they trade against each other. And the comparison the advisor measured
(`PH2-3`, corrected twice by its own re-check, both times against its own earlier claim):

> the record's 30 circle points **are in the module** and therefore carry its full Cayley degree
> **30**; the new circle has **none** in any module of that coarseness, and its best point outside
> carries **1**.

**30 against 1, not 14 against 1** — the earlier 14 double-counted a tangency and was measured inside a
cut that truncates the neighbourhood of a radius-2 point. A vertex of unit degree 1 carrying one cross
edge has degree 2, and by absorption (`CLAUDE.md` G40, `Proofs/HadwigerNelson/Absorb.lean`) it carries
no compulsion at all. **Thirty of those carry thirty times nothing.**

And from the arithmetic side, completing the same picture: on a module of Parts's coarseness the new
circle is **capped at 18** points, and buying the missing factor costs one more `√3` in the denominator
— **81× the arena at equal radius** (advisor `PH2-9`, from the prior-art agent's calculation). So the
brief's target is **free at one end** (abandon the unit structure, as the 36-point module does) and
**81× at the other**, and the brief states neither.

**(d) The mechanism, which explains the record and is base-free.** The record's circle is
`|p|² = 1/(2 − 2cos θ) = 1/(2 − 7/4) = 4 = 2²`, and **2 ∈ K**. So `ρ₁₅`'s equal-radius circle is the
**unit-distance lattice's own radius-2 shell**: its 30 circle points are exactly `2 ×` its 30 norm-1
points (measured: 30 of 30 land in the lattice). The record's 30 diagonal cross edges are therefore not
a representation number that had to be found — they are a **free consequence of its 30 unit
directions**, which is also why they have unit degree 11–14 rather than 1. Generalised and checked
across phase G's whole reference set:

> **Of the 11 rotation classes in `data/m62/m63-phaseG-screen-r2.44.json`, exactly 2 have
> `1/(2−2cos θ)` or `1/(2+2cos θ)` a square in `K` — `−7/8` and `5/16 − 3/16√33` — and those are
> exactly the 2 with a nonzero equal-radius cross-edge count (30 and 18). All 9 others have neither,
> and all 9 report 0.** 11 of 11, no exceptions.

(The second class's square radius is `((1/2) + (1/6)√33)² = (7+√33)/6`, root 1.457427 — which is the
radius `plans/M63-phaseH-a-base-for-a-rotation-RUN.md` §H9 reports for its 18 endpoints. So the
advisor's `PH-8` sign correction and this criterion are one fact.)

**The new rotation has NEITHER circle a square in `K`.** `(7+√33)/3` is not a square; neither is the
antipodal `(43 − 3√33)/97`. Its circle points are arithmetically independent of its unit vectors, which
is why `u` provably has no unit neighbour anywhere in Parts's lattice (§H5, exhaustive) and why the
36-point module has no unit vectors at all.

**(e) The killer instance: a rotation with 1.8× the record's count that is provably four-colourable for
an unrelated reason.** Take `t = 3`, i.e. `cos θ = 17/18`, so the circle is `|p|² = 9` — the radius-3
shell of Parts's own lattice. Measured on this desktop:

| quantity | value |
|---|---|
| `parts_lattice(3.05)` (endpoint bound `2t²/√(4t²−1)` = 3.0426) | **8,347 points** |
| points of norm 1 | 30 |
| points of norm 9 | **54** (the 30 tripled, plus 24 more) |
| `3 × (norm-1 points)` landing inside the cut | 30 of 30 |
| `sin²θ = 35/324`, a square in `K`? | **No** — so it is a legitimate type-M rotation |
| cross edges at `cos = 17/18` | **126**, of which **54 equal-radius** |
| equal-radius `d² = 0` ⟹ residue-monochromatic at both primes | yes, by construction |

**54 free equal-radius cross edges, against the record's 30, on his own lattice, with no new base and
no new point — and the arena is four-colourable regardless**, because the radicand `4n−1 = 35 ≡ 3
(mod 8)` leaves the 2-adic wall standing, so `CLAUDE.md` G1/G35 four-colours the whole thing. **A
rotation can beat the record's circle count by 80% and be dead for a reason with no reference to the
count.** That is the count demoted by an instance rather than by an argument.

**One gate on that sentence, and the cheap way off it (advisor, and it is right).** *"The wall stands ⟹
the arena is four-colourable"* runs through G35's **field-level** statement, which `CLAUDE.md` marks
`[kernel over subrings; field level gated]`, gated on `FS-37`. **Do not leave the phase's best
falsification resting on a gated step when the ungated one is to hand:** run the phase's own residue
certificate on `n = 9`'s arena, at a prime above 2 of `ℚ(√3,√11,√35)(i)`. If it fires you hold an
explicit colouring anyone can re-check edge by edge, the gate disappears, and the falsification becomes
unconditional — and it exercises the certificate on a base that is not stage 1's. **Add this as gate
item G5; it is minutes.**

### §2.1 — The verdict, stated so it can be argued with

**The count is a necessary quantity, a *fragility* measure, and not an objective.** `margin ≥ 1` is
necessary and proved; `margin = 30` is not shown to be sufficient by anything (its one positive
instance refuses for an externally known reason — §1 sentence 3), and raising the count is measurably
free while everything a base actually pays for is measurably not. The advisor puts it exactly:
*"deleting the monochromatic edges at either prime makes `φ/φ` proper, so the arena is within
`min(|M₁₇|,|M₂₃₉|)` edges of provably colourable — that is exact. But it is a fragility measure, not a
hardness measure: the necessary condition is only `M_𝔭 ≠ ∅` at each prime, which 8 satisfies as well as
30."* (`PH2-6`.)

**Do not delete the count from your reports.** Every candidate still states its margin per prime and
its radius-sum list (the brief's §10 requires it, and it is what makes the criterion inheritable by the
next base instead of re-run on it). Just do not *optimise* it.

---

## §3 — The target that replaces it

> **A rotation is worth building a base for when its equal-radius circle is a shell of a
> unit-distance-rich lattice — i.e. when `1/(2 ∓ 2cos θ) = t²` for a `t` the lattice is closed under —
> and when its radicand `4t²−1` both breaks the 2-adic wall and leaves 11 inert.** The first condition
> makes the circle free *and* high-degree; the second is what keeps a fifth (and a sixth) colour
> arithmetically possible at all.

Written out, the family. Set `n = 1/(2 − 2cos θ)`, the circle's **squared** radius. Then

```
cos θ = (2n − 1)/(2n) ,     sin²θ = (4n − 1)/(4n²) ,     circle radius = √n
endpoint bound 1/|sin θ| = 2n/√(4n−1)  >  √n  always, so every member is geometrically admissible
arena's field = K(√(4n−1))
```

**Index the family by `n`, not by `√n`.** The planner's first draft screened `n = t²` over integers `t`,
which is the sub-family where the circle is a *`K`-rational rescaling* of the unit shell. That is the
**strong** condition and it is what makes a circle free. But `n ∈ ℤ` with `n` **not** a square is still a
perfectly good member — its circle is just an ordinary shell of whatever module realises it, with no
inherited degree. Screening only perfect squares **hides four of the six 6-open members below radius
5.6**, which is the generator-image error of §3.1 committed at the top of the plan. So the screen has
**two** criteria and they are different:

| criterion | what it buys |
|---|---|
| **`n` is a square in `K`** (`n = t²`, `t ∈ K`) | the circle is `t ×` (the unit shell). If also `t ∈ O_Λ` (§3.1), **every norm-1 point of the module is a circle point, with the module's full Cayley degree** — free, and rich |
| **the module merely realises `\|p\|² = n`** | the circle is non-empty; its count is a representation number and its degree is whatever the module gives. Cheaper to *have*, worth much less |

With `n = 1/(2 + 2cos θ)` in place of `1/(2 − 2cos θ)` the same table describes the antipodal family;
the two are one rotation class at its two sign representatives (advisor `PH-8`), so screen both.

**The screen, from `cos θ` alone, in microseconds** (verified here; reproduce it as gate item G3;
"pts at `|p|² = n`" is measured in `parts_lattice(3.05)`, 8,347 points, norm-1 shell **30**):

| n | `cos θ` | `4n−1` | sqfree | mod 8 | wall | `sin θ ∉ K`? | 11 | `n` sq in `K`? | pts at `n` | radius | verdict |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 1/2 | 3 | 3 | 3 | stands | **NO** | split | yes | 30 | 1.000 | dead — `ρ ∈ K(i)` |
| **2** | **3/4** | **7** | **7** | **7** | **breaks** | yes | **inert** | no | **0** | **1.414** | **6-OPEN, circle empty → the "find a base" target** |
| 3 | 5/6 | 11 | 11 | 3 | stands | **NO** | split | yes | 42 | 1.732 | dead — `ρ ∈ K(i)` |
| 4 | 7/8 | 15 | 15 | 7 | breaks | yes | **split** | yes | **30** | 2.000 | `ρ₁₅`, **the record** — and its field is **5-sealed** |
| 5 | 9/10 | 19 | 19 | 3 | stands | yes | inert | no | 60 | 2.236 | dead (wall) |
| 6 | 11/12 | 23 | 23 | 7 | breaks | yes | split | no | 0 | 2.449 | 5-sealed |
| 8 | 15/16 | 31 | 31 | 7 | breaks | yes | split | no | 0 | 2.828 | 5-sealed |
| 9 | 17/18 | 35 | 35 | 3 | stands | yes | inert | yes | **54** | 3.000 | **dead (wall) — and §2(e)'s falsification** |
| **10** | 19/20 | 39 | 39 | 7 | **breaks** | yes | **inert** | no | — | 3.162 | **6-open**, no free circle |
| **16** | **31/32** | **63** | **7** | **7** | **breaks** | yes | **inert** | **YES (t=4)** | — | **4.000** | **`ρ₆₃` — 6-OPEN *and* free circle. The target** |
| **20** | 39/40 | 79 | 79 | 7 | **breaks** | yes | **inert** | no | — | 4.472 | **6-open**, no free circle |
| **22** | 43/44 | 87 | 87 | 7 | **breaks** | yes | **inert** | no | — | 4.690 | **6-open**, no free circle |
| **24** | 47/48 | 95 | 95 | 7 | **breaks** | yes | **inert** | no | — | 4.899 | **6-open**, no free circle |
| 25 | 49/50 | 99 | 11 | 3 | stands | **NO** | split | yes | — | 5.000 | dead — `ρ ∈ K(i)` |
| 27 | 53/54 | 107 | 107 | 3 | stands | yes | inert | yes | — | 5.196 | dead (wall) |
| 64 | 127/128 | 255 | 255 | 7 | **breaks** | yes | **inert** | **YES (t=8)** | — | 8.000 | **6-open *and* free circle — the second one** |

*(Rows with `sin θ ∉ K` = **NO** are dead by the advisor's `PH2-8` screen: the rotation then lies in
`K(i)`, the whole arena sits in `K²`, and `chromaticNumber_seamPlane` — χ(K²) = 4, kernel-checked —
four-colours **every** base for it. It costs one square test and it kills `n = 1, 3, 25` outright. Ask
it first, on every rotation this phase proposes.)*

**The classification statement this produces. State it with NO radius in it** — radius is not what a
base pays; `radius⁴ / covolume` is, and the free-circle condition is exactly what makes the circle cost
nothing:

> Among `cos θ = (2n − 1)/(2n)`:
> — **the circle is FREE iff `n = t²` with `t ∈ ℤ`**, because then `t·v` is a circle point for every
>   unit vector `v` by module closure, so the count is `≥ |S|` on **any** base, with no design at all;
> — **the field is 6-OPEN iff `n` is even and `squarefree(4n−1)` is a non-residue mod 11.**
> The two conditions are **independent**. **`n = 16` is the smallest `n` meeting both; `n = 64` is the
> next.** The members meeting only 6-openness — `n = 2, 10, 20, 22, 24` at `n ≤ 31` — are **live design
> targets, not free ones.** And the record's own `n = 4` is wall-breaking but **11-split, hence
> 5-sealed**, so `ρ₁₅` can only ever deliver a five-chromatic object, never a rung toward χ ≥ 6.

`t ∈ ℤ`, **not** `t ∈ K`: for `t ∈ K \ ℤ` the module must additionally be closed under multiplication
by `t`, which costs exactly what `λ`-closure costs (`PH2-5`). At `n ≤ 31` it makes no difference — only
16 qualifies either way — but it bites at larger `n`, and §3.1 and E1 handle it.

**And one methodological note, recorded because it is the reason the statement above has no radius in
it.** The advisor claimed uniqueness *"at radius ≤ 8"*, was corrected to *"≤ 4"*, and **that was also
false**: `n = 10` sits at radius 3.162 and both of us missed it. One cause for both errors — a sweep
restricted to hexagonal-shell values of `n`, which silently excludes five of the six 6-open members.
The advisor's own note on it is the durable part: **a wrong restriction produces more than one wrong
claim, and fixing the one you noticed does not fix the others.** It had already corrected that
restriction in a different sentence, and the fix did not propagate to the claim built on it.

### §3.2 — The count is now a closed formula, in print, and it retires every enumeration

**The prior-art gate fired, in the branch §8 calls branch 2** (`plans/M63-phaseH2-prior-art.md` §PA.0,
run in parallel with this plan). The shell count was found not in number theory but in the
**quasicrystal** literature: `[BaakeGrimm2003]`, *A note on shelling*, Theorem 1 and Corollary 1, whose
closing Remark extends it verbatim to a totally complex extension of a totally real field of class
number one — **our case exactly**, `k = ℚ(√3,√11)`, `K = k(i)`. For a module `M`:

```
count on the circle of squared radius r²   =   |U_M| · ∏  ( v_𝔭(r²) + 1 )      over SPLIT primes 𝔭 | r²
   zero unless every INERT prime divides r² to an even power
   U_M = { ζ ∈ μ(K(i)) : ζ·M = M }
```

**For our field this collapses to one prime.** `μ(K(i)) = μ₁₂`, of order **12** — not 6, because
`√3 ∈ k` puts `ζ₁₂ = (√3 + i)/2` in `K` (derived three independent ways). The primes above 2 are
**inert** with residue field `𝔽₄` (Theorem B's own `𝔽₄`), so they contribute a factor of exactly **1**
at any exponent; the prime above 3 has norm 9 ≡ 1 (mod 4) and **splits**. So

> **count = `|U_M| · (v_𝔮(α_eff) + 1)`**, `𝔮` the prime above 3, `α_eff` the squared radius divided by
> the norm of the module's scaling.

**It reproduces the brief's whole §2 table, including two rows it was not fitted to** — the record's 30
as `6 × 5` and the second class's 18 as `6 × 3`, both out-of-sample; stage 1's 8 as `4 × 2`; and two
measured predictions, `12` and `36`. **It could have failed and did not.**

**Four consequences, and they change what you compute rather than what you conclude.**
1. **Never enumerate a shell count again — evaluate it.** The planner's exhaustive
   denominator-by-denominator enumeration (§10.2) is now the *control* on the formula, not the
   instrument. Keep it exactly for that: evaluate the formula, enumerate one case, require agreement.
2. **`30` is impossible on a `ζ₁₂`-closed module**, since `12 ∤ 30`; such a module gives **36**. So
   "reach 30" was never even the right integer.
3. **The brief's circle is the arithmetically poor choice, and now quantifiably so:**
   `v_𝔮((7+√33)/3) = −2` against `v_𝔮(4) = 0` for the record. The target circle is 3-adically deficient
   by exactly `𝔮²` — *that* is why a module of Parts's coarseness yields 18 there where his yields 30.
4. **`(1/3)·O_L`, the maximal order scaled, carries 36 on the brief's own circle and 60 on `n = 2`'s**
   [measured in the gate]. The lever is `ζ₁₂`-closure, which costs **no 3-adic depth** — not more
   denominator. That is a cheaper route to the count than anything in the brief, and it is still not the
   binding constraint (§2c).

**Two targets follow, and they are different jobs.**

**Target A — `n = 16`, `ρ₆₃`: the circle is already there.** Free, rich, 6-open, on Parts's own lattice
cut at radius 4. This is item **E4** and it is the phase's product.

**Target B — `n = 2`, `cos θ = 3/4`, `ρ₂ = (3 + i√7)/4`: arithmetically the best member in sight, and
its obstruction is THINNESS, not an empty circle.** Radicand 7, so the same 6-open field `K(√7)` as
`ρ₆₃`; radius `√2 = 1.4142`, the **cheapest of any member**, well below the brief's 2.0611; endpoint
bound 1.5119.

*The planner's first draft of this row said "the circle is empty" and that is wrong twice over — the
product owner corrected it in commit `c77b18e` and the correction is the more useful fact.* What is
true: Parts's lattice has **0** points at `|p|² = 2`, and `2` is not a square in `K`, so there is no
free shell. What is also true, and better:

- `2 = 1² + 1²`, so the circle carries the **rational** point `p = (1, 1)` — no radicals, no
  denominators. It is absent from his lattice only because his coordinates confine `y` to
  `ℚ√3 ⊕ ℚ√11` (`PH-3`'s 4-dimensional subspace).
- By §3.2's formula, `r² = 2` is a **unit at the prime above 3**, exactly like the record's `r² = 4` —
  so **its circle count equals the record's**: **60** points on `(1/3)·O_L`, against **36** for the
  brief's own circle [both measured in the prior-art gate].
- **180 of its circle points already have a unit neighbour inside Parts's lattice, four of them at
  denominator 1 and adjacent to `(1,0)`** — against the brief's angle managing 72 glue points at
  cheapest denominator 42.

**So `n = 2` is alive, 6-open, richer than the brief's circle, and cheaper than the record. What
probably kills it is thinness:** only **499** Parts-lattice points lie inside its endpoint bound
1.5119, so the arena is on the order of **1,000 vertices** — against a 509-vertex record that was
reduced from a 3,433-point base. **And thinness cannot be bought with radius**, because material past
the endpoint bound carries no cross edge and is absorbed (`CLAUDE.md` G40). A base for `n = 2` must
therefore be *denser inside radius 1.512* than Parts's lattice is, which is a different and harder
design problem than "hold the circle". **This is item E4b, and its first question is now the density
question, not the circle question.**

**`n = 16` is the target of this phase.** `cos θ = 31/32`, and its rotation is
`ρ₆₃ = (31 + 3i√7)/32`. Three independent reasons it is the best object on the table, one of which is
the advisor's (`PH2-4`) and none of which is the circle count:

1. **Its circle is free and rich.** `|p|² = 16 = 4²` and `4 ∈ ℤ ⊆ O_Λ`, so the circle is the radius-4
   shell of Parts's own lattice and contains `4 × (its 30 norm-1 points)` automatically — so ≥ 30
   equal-radius cross edges whose endpoints carry the **module's full Cayley degree 30**, not the
   degree 1 of an isolated adjoined point (§2c).
2. **Its field is 6-open.** The radicand's squarefree part is **7**, and `K(√7)` is one of the fields
   `CLAUDE.md` G43/G37 names 6-open (wall broken, 11 inert). That is `FS-22`'s field
   (`plans/STUB-sqrt7-phase-pinning.md`). `ρ₁₅`'s field `K(√15)` is **5-sealed**, so a success at
   `ρ₁₅`-like angles delivers a new 5-chromatic object; a success here is the only item in this phase
   that could be a rung toward χ ≥ 6.
3. **The project already knows this rotation.** `√ρ₆₃ = (3√7 + i)/8` is one of the four generators of
   de Grey's edge-direction group (`CLAUDE.md` G8) — so the angle is *already implicated in the
   unit-distance problem*, and the honest novelty claim is narrower than "a new angle": **no type-M
   base-plus-rotated-copy construction at any `n ≠ 4` is in print, as far as this repository knows.**
   `arccos(31/32)` is the second angle in `[PartsOdd2022]`'s 6-chromatic **odd-distance** graph — a
   different problem, on the hexagonal lattice (`plans/M63-phaseG-bases-and-rotations.md` line 125).
   §8 is the branch that settles whether the narrower claim holds.

**Settled before you start: none of the new members is in phase G's census, so none of this is a
reproduction of that screen.** Checked against `data/m62/m63-phaseG-screen-r2.44.json` directly — its
26 angles and 11 class representatives contain **exactly one rational cosine, `−7/8`** (the advisor's
`PH2-4`), and `cos = 3/4` (`n = 2`), `cos = 17/18` (`n = 9`) and `cos = 31/32` (`n = 16`) are **absent
from all 26**. The reason is the generator's image again: the census enumerated rotations from *radius
pairs realised by Parts's lattice cut at 2.44*, and `n = 2`'s circle has **0** points in that lattice at
any radius while `n = 9` and `n = 16` need radius 3 and 4. **The census is a fact about one lattice at
one radius, not about the angles** — which is what the prior-art gate registered as the thing to check
before anything is built, and it is now checked.

**Why phase G's census did not contain it, and the scope correction that follows.** Phase G enumerated
rotations from *radius pairs realised by Parts's lattice cut at radius 2.44*. `ρ₆₃`'s circle sits at
radius 4. It was excluded **by the cut radius, not by arithmetic.** So:

> The brief's §6 ruling *"do not pay for radius"* is a fact about **one angle**. It was derived from the
> stage-1 rotation's endpoint bound `1/|sin θ| = 2.1246`, past which its cross-edge set is provably the
> same 104 edges. The endpoint bound is `2n/√(4n−1)` and **depends on the rotation**: it is ≈ `√n`. For
> `ρ₆₃` you must pay for radius 4, and it buys the entire circle. For Target B you pay for radius
> **1.512**, which is *less* than the brief's own base.

**Cost of paying it, measured, and this corrects the advisor's one arithmetic slip.** Parts's lattice is
**rank 4** — its congruence coordinates confine it to a 4-dimensional ℚ-subspace of the 8-dimensional
`K²` (`PH-3`) — so its cut grows like `r⁴`, not `r⁸`:

| cut radius | points | `r⁴` prediction from 3,433 at 2.44 |
|---|---|---|
| 2.44 | 3,433 (committed; `typem_exact` §4 asserts it) | — |
| 3.05 | **8,347** (measured here) | 7,827, 6% low |
| 4.04 | gate item G4 | **≈ 25,400** |

So `ρ₆₃`'s base is on the order of **25,000 points and a 50,000-vertex arena** — about 7× the record's
arena, not the 52× an `r⁸` estimate gives. The solver on this box refused a 6,865-vertex arena in
10.7 s and four-coloured a 41,034-vertex one in 43.3 s. **This is an ordinary-sized job.**

### §3.1 — The generator's image, written down before any enumeration

Required by the brief's §7 and by `CLAUDE.md` (*"before believing any zero over a family, write down
the generator's image and check the target is inside it"*). Three enumerations appear in this plan;
here is each one's image and where its target sits.

| enumeration | the generator's image | is the target inside? |
|---|---|---|
| **`ω_t` integer screen** (G3) | `{cos = 1 − 1/(2t²) : t ∈ ℤ, 2 ≤ t ≤ T}` | `ρ₁₅` (t=2) and `ρ₆₃` (t=4) are inside. **`t ∈ ℤ` is a strict sub-family** — see the row below. Do not report "no further members" from this sweep |
| **the full free-circle family** (E1) | `{t ∈ K : t² is the circle radius², and t·Λ ⊆ Λ}` — i.e. `t` in the **multiplier ring** `O_Λ = {t ∈ K : tΛ_parts ⊆ Λ_parts}`. `ℤ ⊆ O_Λ` always, which is the only reason the integer sweep works at all | `O_Λ` may be strictly larger than `ℤ`. **Compute it** (E1); every `t ∈ O_Λ` with a wall-breaking, 11-inert `4t²−1` is a free-circle type-M rotation on his own lattice, and the integer sweep sees only `t ∈ ℤ` |
| **circle-point enumeration by denominator** (E4) | all `K`-points `(x,y)` with both coordinates of denominator dividing `q`; **exhaustive at each `q`**, because all four conjugates of `|p|²` are *fixed*, so `a² + 3b² + 11c² + 33d² ≤ q² · max_σ n_σ` bounds every coordinate | the brief's witness `u` has denominator 6 and appears at `q = 6` — verified, it is found. This is the fix for the failure the brief's §7 describes: the earlier sweep restricted the **second coordinate** to `ℚ + ℚ√3` and so could not represent `u`. This generator restricts nothing but the denominator |

---

## §4 — The queue

Ordered by cost-to-information, not by the brief's numbering. **Every item states its prediction before
it runs, its cost with the machine, why both outcomes are reachable, and its controls.** Score each as
**met / not met / not decided** — never "partly". Write the score into
`plans/M63-phaseH2-RUN.md` as you go; that file is the phase's record and the only thing that survives
you.

**This box is the desktop: 32 cores, 128 GB.** Timings below were measured on it. Per-operation ratios
carry to the laptop; wall-clock totals and safe job counts do not.

### Gate — nothing downstream is believable until these five reproduce

**G1 — Parts's lattice, rebuilt, with the brief's §8.5 number.** `typem_exact.parts_lattice_exact(Fr("2.44"))`
must give **3,433** points; **30** of norm 1; **30** on `|p|² = 4`; and `typem.CrossLaw.collinear((7/8,0,0,0)).edges(pts)`
must give **126 = 60 centre + 36 off-diagonal + 30 equal-radius**. *Cost: ~4 s.* **If this does not
reproduce, stop and report — nothing after it is believable** (the brief's §8.5, and the standing
discipline in `plans/M63-phaseH-a-base-for-a-rotation.md` §8.2).
*Prediction: reproduces exactly. Both outcomes reachable: `typem_exact --self-test` §4 asserts these
literals, so a mismatch means a broken tree and is a real signal, not a formality.*
*Control (two-sided): run the same decomposition at a deliberately wrong cosine and require
`0 < (126 − wrong_count) < 126` — stage 1 measured that a wrong cosine keeps exactly the 60 centre
edges, whose condition does not involve `cos θ`, so the guarded value must be 126 and the planted one
exactly 60. **Assert both bounds.** A planted verdict of 126 means the plant stopped firing; a planted
verdict of 0 means it fired too much and the centre family is also broken.*

**G2 — the solver positive control.** `typem.refuses_four` on the `ρ₁₅` arena over `parts_lattice(2.44)`
must return the **string** `'unsat'`. Stage 1: 10.7 s; phase G: 12.2 s. *Cost: ~11 s.* **No SAT verdict
anywhere in this phase may be believed until this has returned UNSAT in the same process tree**, because
that arena contains Heule-510. *Note: `refuses_four` returns a string, not a bool — `st != "unsat"` is
the only safe test. And `five_dial.sat` with `wall=0` or `wall=None` silently switches to an **unbounded
in-process** solver and returns a model of a different Python type; always pass a positive wall.*

**G3 — the `ω_t` screen, reproduced.** Regenerate §3's table from `cos θ` alone: for `t = 2…12`,
`sin²θ` and `typem.k_is_square(sin²θ)` (must be `False` or the rotation lies in `K(i)` and Theorem B
four-colours every base — the advisor's `PH2-8`; it kills `t = 5`), the squarefree part of `4t²−1`, its
class mod 8, and `typem_exact.wall_and_eleven`. *Cost: seconds.*
*Prediction: the table reproduces, including `t = 5` failing the `sin θ ∉ K` screen and `t = 4` coming
back wall-breaking and 11-inert. **One row is contested and both readings are reachable:** the planner
reads `t = 8` (radicand 255, squarefree 255, 255 ≡ 2 mod 11, a non-residue) as **also** 6-open, while
the advisor's `PH2-4` claims `t = 4` is the unique 6-open member at radius ≤ 8. Resolve it with
`typem_exact.wall_and_eleven` and report which of the two is wrong — do not average them.*
*Control (two-sided): `typem_exact.wall_and_eleven` has its own §8 self-test asserting `15/5/3 →
split+split` and `7/35/13/2 → inert+inert`. Run `typem_exact.py --self-test` and require it green
**before** trusting any row. Note the trap: `wall_and_eleven` and `eleven_status` **swallow every
exception into a silent `None`** and stash the reason on a function attribute; assert that no row is
`None` rather than letting one pass.*

**G4 — the pricer, calibrated, and the rank-4 scaling confirmed.** Build `parts_lattice` at 2.44, 3.05
and 4.04 and check the counts against §3's `r⁴` law; then compute the covolume instrument and confirm
it reproduces a number the phase already holds. *Cost: ~2 min at 4.04 for the cut; the cross-edge law
at 25k points is `O(n²)`-ish and took 7.9 s at 8,347, so budget ~2 min.*

The covolume instrument, written out because **nothing in `tools/` computes a covolume or a lattice
determinant** — the advisor's tool survey confirms no `covolume`, no determinant, no LLL anywhere:

```
A K-element is a 4-tuple (a,b,c,d) = a + b√3 + c√11 + d√33.  A point is a pair of them: 8 rationals.
Conjugate-coordinate inner product:   <u,v> = Tr(u·v) = 4(a₀b₀ + 3a₁b₁ + 11a₂b₂ + 33a₃b₃),
                                      summed over BOTH coordinates of the point.
  (This IS the Euclidean inner product in conjugate coordinates: Σ_σ x_σ² = Tr(x²).)
covol(Λ) = sqrt(det Gram(Z-basis of Λ))   under that form.
For a FULL-RANK (rank 8) module:  cut count at radius r  ≈  (π r²)⁴ / covol(Λ).
  (The cut region is four independent disks of radius r, one per real place.)
```

*Predictions, all three registered and all three checkable against numbers already on disk or measured
here:* (i) the instrument reproduces `|det V| = 528` as `2⁴·√(1·3·11·33)` — the one covolume-adjacent
number stage 1 already had (`…RUN.md` §H4); (ii) on the rank-8 module of §2(a) it predicts **2,880**
against a measured **3,037** — agreement to about 5%; (iii) the `r⁴` law reproduces 8,347 at 3.05 from
3,433 at 2.44 to within 10%. *Both outcomes reachable: a pricer that misses any of the three by an order
of magnitude is not an instrument and must be fixed before it is used to reject anything — and
rejecting-by-price is exactly what item E4 does.*
*Control (two-sided): price a module you can also enumerate, and require
`0 < |predicted − measured| / measured < 0.5`. The lower bound fails if you have accidentally wired the
prediction to the measurement; the upper bound fails if the pricer is wrong. Do this on **two** modules
of different rank, because there is no rank-8 calibration point anywhere in the record — §2(a)'s 3,037
is the only one and it was measured by the planner with ad-hoc code, so **re-derive it, do not import
it.***

**G5 — the `n = 9` falsification, taken off its gated step.** §2(e) is the plan's strongest single
argument against the brief's target, and as stated it leans on G35's field-level claim, which
`CLAUDE.md` marks gated on `FS-37`. Replace the gate with an explicit certificate: build
`parts_lattice(3.05)` (8,347 points — measured, 0.6 s), form the arena at `cos θ = 17/18`, and run the
phase's own residue certificate at a prime above 2 of `ℚ(√3,√11,√35)(i)`. *Cost: minutes.*
*Prediction: it fires, producing a `δ ∈ 𝔽₄` free of `Δ` and hence an explicit four-colouring anyone can
re-check edge by edge. 0.75 — the wall standing says the field's plane is four-colourable, and the
certificate is the constructive form of that, but the certificate is **one-sided** and could stay silent
while the arena is still colourable for another reason.* **Both outcomes reachable and both useful:** if
it fires, §2(e) becomes unconditional and the phase holds *"54 free cross edges, 1.8× the record, with
an explicit four-colouring"* — a much stronger sentence. If it stays silent, §2(e) keeps its gate,
**say so plainly rather than quietly dropping the qualifier**, and the 54-vs-30 count comparison still
stands on its own. *Control: the certificate must **fire** on the stage-1 `--no-u` base (stage 1's
`P-H13` measured free `δ = (0,0)` at prime 239 there) and must stay **silent** on the `ρ₁₅` arena, which
is forced since that arena is 5-chromatic. Both directions, asserted: an instrument that cannot
reproduce a known firing may not be believed when it goes silent, and one that fires on `ρ₁₅` is broken.*

### E1 — the multiplier ring, and the complete free-circle family on his own lattice

**Rank 1.** *Cost: minutes. No solver.*

**What.** Compute `O_Λ = {t ∈ K : t·Λ_parts ⊆ Λ_parts}` — exactly, by testing candidate `t` against the
lattice's own congruence conditions rather than by enumerating points. Then enumerate every `t ∈ O_Λ`
with `|t|` and all its conjugates inside a workable cut radius, and screen each through G3's columns:
`sin θ ∉ K`, wall-breaking, 11-inert, endpoint bound, and the count of points at `|p|² = t²`.

**Why this and not the integer sweep.** §3.1's middle row. `ℤ ⊆ O_Λ` is why `t = 2, 3, 4, …` work at
all, and the integer sweep is the sub-family `t ∈ ℤ`. If `O_Λ = ℤ` then **the integer table of §3 is the
complete free-circle family on his lattice and that is a clean, final, base-free statement about the
monoculture.** If `O_Λ ⊋ ℤ` there are members nobody has enumerated. Either answer is a result.

**A named first candidate, constructed and verified here, which also answers E1 constructively.**
`√3 ∉ O_{Λ_parts}`: multiplication by `√3` **swaps his two coordinate spaces** (`√3·(a + b√33) =
a√3 + 3b√11`, which lands in the `y`-space, and `√3·(c√3 + d√11) = 3c + d√33`, which lands in the
`x`-space), measured at **399 of 400** sampled points leaving the shape. **But the Galois completion**

```
Λ′ = Λ_parts + √3·Λ_parts        is closed under ×√3, because √3·Λ′ = √3Λ + 3Λ ⊆ Λ′   (3Λ ⊆ Λ)
```

**is**, and it contains `Λ_parts`, hence its 30 norm-1 points, hence `ℤ[√3] ⊆ O_{Λ′}`. So `Λ′` makes
**every `n = m²` and every `n = 3m²` a free circle** — verified for `n = 12`: `2√3 × (the 30 norm-1
points)` gives **30 distinct points, all of squared norm exactly 12**, where the same product lands
**0 of 30** inside `Λ_parts`. **Price `Λ′` first** (G4); it is one named module and it is the cheapest
way to test whether `O_Λ ⊋ ℤ` matters in practice.

**Prediction.** `O_Λ ⊇ ℤ` certainly, and `O_{Λ′} ⊇ ℤ[√3]` by the argument above. Planner's prior at
**0.6** that `O_{Λ_parts} = ℤ` exactly (his lattice's
congruences are stated in integer coordinates with denominator 12, and multiplication by `√3` or `√33`
moves the `x`-slots into the `y`-slots, which his coordinate shape forbids — but `(1+√33)/2`-type
elements and rational scalars `1/2`, `1/3` have not been checked and a rational `t < 1` would give a
*smaller* circle, hence a cheaper one).
**Both outcomes reachable:** `O_Λ = ℤ` is a decidable finite check on the congruence conditions, and
`O_Λ ⊋ ℤ` is exhibited by a single witness `t`. Neither is forced by construction.
**Controls (two-sided).** (i) Positive: `t = 2` and `t = 3` must land in `O_Λ`, and `2·Λ ⊆ Λ` must be
confirmed *by point containment* as well as by the congruence argument — `0 < (members found) − (members
found with the test deliberately inverted) < |candidates|`. (ii) Negative plant: feed the test a `t`
that provably fails (`t = 1/2`, if `Λ` has any point of odd numerator) and require a refusal; feed it
`t = 1` and require acceptance. **Assert both.** A test that accepts `1/2` has stopped discriminating.

### E2 — Heule-510 ∩ the cross edges: does the only known refusal use this family at all?

**Rank 2.** *Cost: minutes. No solver.* The advisor ranks this first of all and the planner agrees it
is the best item in either list.

**What.** The only arena that refuses four colours does so because it contains Heule-510. Ask how many
of that arena's **126** cross edges are edges of Heule-510, and how they split across the three cross
families (60 centre / 36 off-diagonal / 30 equal-radius). Then ask which of them are
residue-monochromatic at each prime.

**Why it decides the queue.** If the refusal routes through the equal-radius family, the brief's target
is vindicated *as a mechanism* rather than as a two-point correlation, and `margin` becomes a real
design quantity. If it routes mostly through the other families, then the family this whole direction
has been built to acquire is **not on the refusal's path**, and the corrected target of §3 is the only
one standing.

**The data is committed and this is a loop, not a run.** `/home/kooshi/source/lean-dir/data/m62/g510/state.pkl`
(committed, 339,653 bytes, produced by `tools/mkstate.py`) carries `nv=757`, `centre=0`,
`labels[i] = ['v', <arena index>]`, `live` = 757 arena indices in `0…6865`, and `start` = the 509 group
ids of the Heule-510 selection minus the pinned centre. The per-vertex arena index is
`live[members[g][0]]` over `start ∪ {centre}`. The arena is `typem.Arena` on `parts_lattice(2.44)`, so
`n = 3433`, index `i` is the L-side copy of base point `i` and index `n+i` the S-side copy of the **same**
base point — one shared index set, and the rotated half reuses the base's internal edge list verbatim
(`typem.py:463-481`).

**Provenance warning, and it is the one that has bitten three agents.** The containment was verified in
`/home/kooshi/source/lean-dir/data/m62/round1/verify244.log` (`510/510 vertices, L-side 375, S-side 135`;
`2504/2504 Heule edges present; 0 arena edges not in Heule's list`) but **the verifying script was never
committed**, and `/tmp/arena244.pkl` is stale and marked *"regenerate rather than trust"*
(`plans/STUB-parts-reproduction.md:243`). Rebuild the arena; do not load that pickle. And read
`tools/parts_edges.py:85-89` before you start: *"A base relation does not know which side a shared point
is on, which produced 54 cross edges where the record has 18, and has now caused faults in three
separate agents."* **The L/S side assignment of the shared centre is the trap.**

**Prediction, registered.** The planner's derivation-free expectation is **30 of 126**, splitting **12
at the shared centre + 18 off-centre**, with the 18 all subtending `arccos(7/8)`. Basis: three
independent records agree on the 30/18 split —
`plans/M62-evolutionary-type-m.md:1118-1121` (*"Of the 30 edges running between the two halves, all 30
are explained: 18 at cos = 7/8 and 12 incident to the shared centre"*), `typem.py:444` (*"Verified
against Heule-510: all 18 of its cross edges subtend exactly arccos(7/8)"*), and
`data/m62/m63-edge-verify-509.json`'s `geometry.by_class = {'L-L': 1732, 'L-S': 30, 'S-S': 517}`. **A
planner-side spot computation from `state.pkl` reproduced 30 = 12 + 18, but it is unreplicated and is
not a repository record — re-derive it, and treat a disagreement as a finding about the pickle, not
about the record.** *Confidence high on 30; the informative part is the **next** question, which nobody
has recorded: **how the 18 split between off-diagonal and equal-radius, and how many are
residue-monochromatic.** Confidence there: none. Both outcomes reachable — the 18 could be all
equal-radius (18 ≤ 30, fits) or all off-diagonal (18 ≤ 36, also fits), and the record already forbids
"only one family" (`§R9`: reference-only → SAT, auxiliary-only → SAT, both → UNSAT), so a mixed answer
is the one the evidence leans toward and a pure answer would be the surprise.*
**Controls (two-sided).** (i) The reconstruction must reproduce **510 vertices and 2,504 induced
edges** before its cross count is read; if it does not, the index mapping is wrong and the cross count
is meaningless. (ii) Plant: shift the S-side offset by one (`n+i → n+i+1`) and require the induced edge
count to **drop**, with `0 < 2504 − planted < 2504`. A planted count still equal to 2,504 means the
plant never fired; a planted count of 0 means the harness is comparing nothing. (iii) The arena's own
cross total must come back as **126** from `typem.CrossLaw`, not from the pickle.

### E3 — how thin can the only known refusal get? (the two thinning experiments)

**Rank 3.** *Cost: ~30–60 min of solver on 32 cores.* Run the advisor's narrow version **first**; the
planner's wide version second, and only if the narrow one leaves the question open.

**E3a — thin the diagonal matching only, 30 → k.** Hold base, radius, kinds and tooling fixed; delete
`30 − k` of the 30 equal-radius cross edges and re-solve, for `k = 30, 24, 18, 12, 8, 4, 1`. This varies
the brief's own variable and nothing else. *Why the advisor's framing is better than the planner's: the
wide 126-edge version answers "which **kinds** carry the refusal", which is confounded for the brief's
question.* Sample several subsets per `k`, **include one closed under negation and the two Galois
flips** so that the `k = 8` row matches stage 1's own 8-point symmetry orbit, and state the sampling
beside the curve.
*Prediction: planner at 0.55 that the arena is still UNSAT at `k = 8`. Basis: Heule-510's refusal uses
at most 18 off-centre cross edges (E2), the orbit-minimal refusing subtypes in
`data/m62/subtype-census.json` use **18** off-centre edges, and 8 < 18 — so the honest read is that the
curve breaks somewhere in `8 ≤ k ≤ 18` and 0.55 is a genuine coin-flip, not a hedge.*
**Both outcomes are reachable and both are informative, which is why this experiment is worth its
cores:** still UNSAT at `k = 8` **refutes the brief's §2 on the phase's own positive instance, at
exactly stage 1's count**; a first SAT at some `k` gives the threshold the brief's §6 says nobody has
("30 refuses and 18 does not, on two instances. **That is two data points and not a threshold.**").
**Controls (two-sided).** (i) `k = 30` (nothing deleted) must return UNSAT — this is G2 re-run in the
same harness, and if the harness cannot reproduce it the curve is noise. (ii) `k = 0` (the whole
diagonal family deleted) must return **SAT**, and `data/m62/m63-phaseG-screen-r2.44.json` §R9 already
says the reference-only and auxiliary-only subsets are both SAT, so a `k = 0` UNSAT means the deletion
is not reaching the edge list. **Require `0 < (UNSAT count at k=30) − (UNSAT count at k=0) ` and the
`k=0` row SAT.** (iii) Assert the edge count actually deleted each time; **an elimination carries an
exact quantifier or it is not an elimination.**

**E3b — thin all 126.** Greedy irredundant subset over the whole cross-edge set: try each deletion,
keep it if still UNSAT. Reports the size **and composition** of a cross-edge set that carries the
refusal. Only run this if E3a's curve is ambiguous. *Cost: ~126 solver calls; UNSAT calls ~11 s, SAT
calls ~2 s, so 15–25 min sequential and far less across cores.*

### E4 — `ρ₆₃`: build the base, screen it, and ask the solver

**Rank 4, and the phase's product.** *Cost: ~5 min to build and screen; one SAT call on ~50,000
vertices, budget 1 h with a wall.*

**What.** `cos θ = 31/32`. Cut `parts_lattice` at radius ≥ the endpoint bound `2·16/√63 = 4.0316`; use
**4.04**. Then, in order: the symmetry gate (negation and the three Galois flips, zero images outside);
the count at `|p|² = 16` and the check that `4 × (norm-1 points)` lands inside; unit edges per point;
`typem.CrossLaw.collinear((31/32,0,0,0)).edges(pts)` and its decomposition into centre / off-diagonal /
equal-radius; the radius-sum (`σ`) spectrum per kind with `d² = σ − (σ−1)/cos θ`; the residue verdict
per prime; then the arena and `refuses_four`.

**Most of this item is already measured. Read the next block before you plan your time.**

The planner ran the base build and the screen, with the project's own committed instruments and with
the `ρ₁₅` positive control reproduced in the same process (`126 = 60 + 36 + 30` at `cos = 7/8` on
`parts_lattice(2.44)`). Desktop, single core:

| quantity | measured | cost |
|---|---|---|
| `parts_lattice(4.04)` | **25,843 points** (planner's `r⁴` prediction 25,400 — 1.7% off) | 1.7 s |
| points of norm 1 | **30** | — |
| points of norm 16 (the circle) | **30**, and all 30 of `4 × (norm-1 points)` are inside the cut | — |
| `sin²θ = 63/1024`, a square in `K`? | **No** — `PH2-8`'s screen passes, the rotation is not in `K(i)` | — |
| `typem_exact.wall_and_eleven(sin²θ)` | **`(True, (True, 'inert+inert'))`** — wall **breaks**, 11 **inert at both primes**, so the field is **6-OPEN** | — |
| `typem_exact.wall_and_eleven(7)` | the same, confirming the field is `K(√7)` | — |
| equal-radius kind `d² = 0` → residues at the two primes | **`(0,0)` and `(0,0)`** — the residue certificate is **defeated at both primes** | — |
| cross edges at `cos = 31/32` | **126 = 60 centre + 36 off-diagonal + 30 equal-radius** — *the record's exact decomposition, at a different angle, in a 6-open field* | 27 s |
| unit edges | **275,316 → 10.65 per point**, against the record's **8.32** | **776 s** |

**So this base is denser than the fabric the record is built on, its cross structure is
decomposition-identical to the record's, its field is 6-open where the record's is 5-sealed, and its
circle is free. The only thing nobody has ever done is ask the solver.** That is the item.

**Registered predictions for what remains.**
- **P1 — `parts_lattice(4.04)` has 22,000–29,000 points.** *Already **met**: 25,843. Re-derive it; a
  disagreement means a broken tree.*
- **P2 — ≥ 30 points at `|p|² = 16`, all 30 scaled unit points inside.** *Already **met**: exactly 30,
  30 of 30. Note it did **not** exceed 30, where `n = 9` gave 54 — so `n = 16`'s circle is exactly the
  scaled unit shell and nothing more.*
- **P3 — the certificate is silent at both primes.** *Already **met**, and near-forced, **which is
  exactly why it is worth almost nothing on its own.** Re-read §1 sentence 2: silence is not evidence.*
- **P4** — **the arena is four-colourable (SAT).** *0.7.* Basis, stated so it can be scored: of the
  eleven rotation classes phase G screened, six defeat the certificate at both primes and **five of the
  six are SAT**; of the two carrying an equal-radius kind, one is SAT (`PH-4`, `PH-8`). So the base rate
  is against every candidate, and P4 is the honest expectation rather than a hedge. **An UNSAT here is
  the phase's headline result and the first type-M refusal at a rotation other than `ρ₁₅` in fifty
  years — which is precisely why it must survive G2, and why a SAT is the cheap direction.**
- **P5** — the number of **kinds** at this angle is ≥ 2. *0.7; `H4` in
  `plans/M63-phaseH-a-base-for-a-rotation.md` is **inherited, not proved** (`PH-2`), so a one-kind base
  must still be asked and not discarded — a base whose only non-centre kind is the diagonal is the
  **minimal surviving configuration**, and an earlier falsifier would have reported that target as a
  failure.*

**Both outcomes reachable.** SAT and UNSAT are both live: the object exists, is affordable, has no
prior verdict anywhere in the record, and the solver decides it in seconds-to-minutes either way. There
is no construction forcing either answer — contrast the brief's §8.1, whose "mission over" outcome
§2(a) shows is unreachable.

**What is NOT yet done, and it is the half that matters most.** The **independent `K[x]/(x² − D)`
recount has not been run at this cosine.** The 126 came from `typem.CrossLaw.collinear`, i.e. **from the
law, at a new parameter** — and a wrong law *invents* edges, which makes a refusal arrive faster and
cheaper and **looks exactly like success**. Being built by the law is the reason the law needs checking,
not the reason it does not. Also not done: the symmetry gate, `C0` containment, the `σ` spectrum per
kind, the arena, and the ask.

**But you only have to recount 36 of the 126, and the other 90 are a free two-sided control** (the
advisor, after the planner flagged that reproducing the record's exact decomposition at a new parameter
is the most flattering output a derived law can give). **90 of the 126 are forced by `|S| = 30` alone
and involve no law, no parameter and no cosine:**

- **centre family = exactly `2|S| = 60`.** The shared centre `0` joins `ρv` whenever `|v| = 1` (that is
  `|S|` edges) and `p` joins `ρ0 = 0` whenever `|p| = 1` (another `|S|`). Nothing cosine-dependent
  appears in either condition.
- **equal-radius family = exactly `|S| = 30`** whenever `n = t²`, because the circle points **are**
  `t · (unit vectors)` — which is also why this base came out at exactly 30 and not more, where
  `n = 9` gave 54.

**So: predict 60 and 30 from `|S|` BEFORE the recount, then recount. If the independent implementation
returns anything but 60 and 30 for those two families, the recount itself is broken; if it returns them,
you have a control that cost nothing and a calibration for the 36 that are genuinely at risk.** That
turns the gating control from *"re-derive everything"* into *"re-derive the one third actually exposed,
with the other two thirds as its calibration"* — three times cheaper and strictly stronger.

**Budget.** The build is ~15 minutes end to end and **776 s of it is `unit_edges_fast` on 25,843
points** — that is the one expensive step, so build once, persist it (§6), and never rebuild it to
re-read a number. The arena is **51,686 vertices with ~550,600 interior edges and 126 cross edges**.
For scale: this project's solver refused a 6,865-vertex arena in 10.7 s and four-coloured a
41,034-vertex one in 43 s, so budget a 1 h wall and expect minutes.

**Recoverability, specifically for this arena.** The single ask is one solver call and either finishes
or hits its wall, so it needs no checkpoint — but **the 776-second unit-edge build does**, and anything
downstream of an UNSAT does: the reduction stage this milestone reproduces took **hours** on the
record's 3,433-point base, and this base is 7.5× larger. So: persist the base after the cut, again
after the cross-edge law, again after the unit edges (§6's E4 row), **never rebuild it to re-read a
number**, and if an UNSAT sends you into reduction, checkpoint per accepted deletion with the resume
command named beside the path — outside `build/`.

**Controls (two-sided).** (i) **G2 in the same process tree**, immediately before the ask. (ii) `C0`:
`parts_lattice(2.44) ⊆ parts_lattice(4.04)` — all 3,433 present. (iii) The cross-edge count must be
re-verified by the **independent** `K[x]/(x² − D)` expansion that shares no step with the law
(`rational part = 1`, `radical part = 0`; the pattern is in `tools/phaseg_screen.py` and in
`plans/M63-phaseH-a-base-for-a-rotation.md` §3), because **a wrong law invents edges, which makes a
refusal arrive faster and cheaper and looks exactly like success.** (iv) The wrong-cosine plant from
G1, re-run on this base: `0 < (correct count) − (wrong-cosine count) < (correct count)`, with the
planted value expected to be exactly the centre family. (v) The unit-edge proposal gate: run
`typem.unit_edges_fast` at the shipped slack and at `1e4 ×` it and require **identical exact sets**;
this is `typem_exact` §6b's standing control and it reads the shipped default out of the function
signature by `inspect` rather than restating it — **do not hardcode `1e-7` anywhere.**

**And state the two shell counts in the same breath** — the norm-1 count and the norm-`n` count.
They are the two quantities the whole phase reduces to (§2c), and **nobody has ever reported them as a
pair for any base** (advisor's closing line).

**The direction-of-error rule for this item, because it has two halves that fail opposite ways.** The
unit edges are **measured** (a float proposes, exact arithmetic decides), so the only possible error is
a **missed** edge, which makes colouring easier — so **a refusal is robust and a SAT is the suspect
verdict**. The cross edges are **derived from a law at a new parameter**, so the possible error is an
**invented** edge, which makes a refusal arrive cheaply — so **there a refusal is the suspect verdict.**
Before trusting either, ask which half produced it. Being built by the law is the reason the law needs
checking, not the reason it does not.

### E4b — `n = 2`: the one place "find the base" still applies, at the cheapest radius of all

**Rank 4b — run it if E4 returns SAT, or in parallel on spare cores since it needs no solver until the
end.** *Cost: the screen is minutes; the base design is the open part.*

`cos θ = 3/4`. Circle `|p|² = 2`, radius **1.4142**; endpoint bound **1.5119**, so the entire cross set
lives inside radius 1.512 — **cheaper than the brief's own base and far cheaper than `ρ₆₃`'s.** Radicand
**7**: wall-breaking, 11-inert, the same **6-open** field `K(√7)` as `ρ₆₃`. `sin²θ = 7/16` is not a
square in `K`, so `PH2-8`'s screen passes.

**Parts's lattice has 0 points at `|p|² = 2`, and 2 is not a square in `K`, so there is no free shell.**
But the circle is non-empty in `K²` with a *rational* witness, `p = (1, 1)` — `1² + 1² = 2`. It is
absent from his lattice only because his coordinates confine `y` to `ℚ√3 ⊕ ℚ√11` (`PH-3`). **This is
the brief's mission, intact, re-aimed at a circle that is 2 instead of `(7+√33)/3` and a field that is
6-open instead of 5-sealed.**

**The design problem, stated as the two shell counts of §2(c).** Find a ℤ-module in `K²`, closed under
negation and the two Galois flips, whose **norm-1 shell is large** (that is the unit-distance structure,
by `addCayleyMap`) and whose **norm-2 shell is large** (that is the margin). Both are shell counts of
one module, so price the pair, not either alone. Starting points, cheapest first:
1. **`ℤ²`** — norm-1 shell 4, norm-2 shell 4 (`(±1,±1)`). Poor but nonzero, and a calibration point.
2. **`ℤ² + (the hexagonal wheel)`** — the wheel `{(0,0), (±1,0), (±1/2, ±√3/2)}` supplies 6 norm-1
   points; ask whether the sum's norm-2 shell grows and at what covolume (G4's pricer).
3. **a Minkowski-sum fabric built around `(1,1)` rather than adjoining it** — the structural lesson of
   §2(b,c): stage 1 adjoined a circle point to a fabric and got degree 1; build the fabric so the
   circle point is *in* it and it carries the full Cayley degree.
4. **the multiplier-ring route** — if E1 finds `√2 ∉ O_Λ` for every rich Λ you try, then `n = 2`'s
   circle can never be a scaled unit shell and its points will always be adjoined; say so, because that
   is the same verdict §2 reached for the stage-1 rotation and it would be the *second* instance of the
   pattern rather than the first.

**Report the thinness column beside the circle count, because it is what decides this item and it
needs no solver.** `Λ_parts(1.5119)` holds **499** points, so the cross-edge-bearing arena is ≈**1,000
vertices**. **Give the unit-edge count inside radius 1.5119 and its per-point figure, and compare it to
`ρ₆₃`'s 10.65 per point.** If `n = 2` comes in at a fraction of that, it is thin for a *measured*
reason and can be ranked honestly instead of on its radius. And note §3.2's formula says its circle
count *equals the record's* (60 on `(1/3)·O_L`), so **the circle is not what is wrong with `n = 2`** —
one more instance of the count not being the constraint.

**Prediction.** Planner at **0.5**, honestly a coin flip, that a module exists with norm-1 shell ≥ 12
and norm-2 shell ≥ 12 at a cut of ≤ 50,000 points. *Both outcomes reachable: the pricer decides it
before anything is built, and either answer is a statement about `K`'s shell arithmetic rather than
about a search.*
**Controls (two-sided).** The pricer's G4 controls, plus: any module you propose must be **checked to
contain `(1,1)` and its symmetry orbit**, and the circle count must be read from the **enumerated cut**,
not from the design intent — `enumerate_ball` is float-Cholesky and can silently drop a point (§5
trap 1), and here a dropped point is a silently lost margin.

### E4c — the named fallback, and why it is NOT another member of the family

*The product owner asked for a named gate on `n = 12` as the fallback, and for the result at `ρ₆₃` that
would make the session spend its remainder there. Here is the gate, and here is the reason the planner
thinks the honest fallback is a different item.*

**`n = 12`** — `cos θ = 23/24`, circle `|p|² = 12`, radius 3.4641, radicand `47` (`47 ≡ 7 mod 8`, wall
**breaks**; `47 ≡ 3 mod 11`, a QR, so 11 **splits** → **5-sealed**). Two facts measured here that make
it worse than its radius suggests:

1. **Its circle is NOT free on Parts's lattice.** `12 = (2√3)²` *is* a square in `K`, but `2√3 ∉
   O_{Λ_parts}` (E1's measurement: `2√3 × (the 30 norm-1 points)` lands **0 of 30**). So `n = 12` is a
   **design** target needing the Galois completion `Λ′`, not a free one — the same class of work as
   `n = 2`, at 2.4× the radius.
2. **It is 5-sealed**, so even a win there is a new five-chromatic object and **no rung toward χ ≥ 6.**

**So the planner's recommendation, offered against the product owner's framing as invited:** if `ρ₆₃`
returns **SAT** with its cross-edge recount clean, then what the phase has learned is a statement about
the **recipe** — *a dense base (10.65 edges/point against the record's 8.32), a free circle at full
Cayley degree, and a 6-open field are together insufficient* — and **no other member of the family is
worth a solver slot on that evidence**, `n = 12` least of all, since it is strictly poorer on both
counts above. **The right use of the remainder is then E2 and E3: what does the one known refusal
actually use?** That is the mechanism question, it runs on committed objects, and it is the only thing
that would tell you what a *fourth* requirement even looks like.

**The trigger, stated so it can be checked rather than argued:** spend the remainder on another member
of the family **only if `ρ₆₃` returns UNSAT** — in which case the next member to build is the cheapest
**free** one, `n = 64` at radius 8, as a second instance of a working recipe — **or if `ρ₆₃`'s recount
of the 36 law-dependent cross edges fails**, in which case the `ρ₆₃` verdict is void, nothing has been
learned, and `n = 12` is no better placed than it was. *Confidence: medium. The one fact that would
change it is `n = 12`'s norm-1 and norm-12 shell counts on `Λ′` coming back far richer than `ρ₆₃`'s 30
and 30 — which §3.2's formula can evaluate in seconds, so **evaluate it before accepting this ruling**.*

### E5 — the λ-sweep, pre-screened and priced

**Rank 5.** *Cost: minutes for the screen; hours only if you build from it.* Run this if E4 returns SAT
and there is session left, or if E1 says `O_Λ = ℤ` and the free-circle family is exhausted.

**What.** Phase G §12.5's parametrisation: a collinear cross pair is `(p, λp)` with `λ ∈ K`,

```
a(λ) = |p|² = 1/(λ² − 2cos θ·λ + 1) ,    d² = (1 − λ)²·a(λ) ,    σ = a(λ)(1 + λ²)
```

and the kind is `𝔭`-monochromatic iff `v_𝔭(d²) > 0`. Phase G §12.6 found **30,610 live λ** for the
stage-1 rotation. Screen them, in this order, each stage free relative to the next:

1. **`sin θ ∈ K`?** — one square test. If yes, the rotation lies in `K(i)` and Theorem B four-colours
   every base: dead. (`PH2-8`. It kills `t = 5` in §3's table, and the planner would not have run it.)
2. **`N_{ℚ(√33)/ℚ}(a(λ))` smoothness** — one line of exact arithmetic per λ. **The primes in that
   norm's denominator are forced into every representative's coordinates, hence into the module, hence
   into the covolume.** This is the advisor's pricer (`PH2-3`) and it is free. `λ = 1`: `16/9`, smooth.
   `λ = −1`: `16/97` — a prime **no base can shed**. `ρ₁₅`'s own: `N(4) = 16`, the smoothest possible.
3. **per-prime liveness, not both-primes** — `PH-2`: the certificate is defeated at `𝔭` iff *some*
   non-centre kind is monochromatic there, and **the kinds need not be the same at the two primes.**
   At the stage-1 angle prime 17 is already covered by 24 inherited off-diagonal edges; only **239**
   needs new material. Phase G §12.4's `Σ_live` and `plans/M63-phaseH-a-base-for-a-rotation.md` §5.2's
   `is_live` both demand **both** primes on one kind and are **one prime too strong** — fix that before
   using either.
4. **is `a(λ)` a square in `K`?** — if yes the circle is a `K`-scaling of the unit shell and §3 applies:
   free and rich. If no, it is an independent shell and §2(b,c) applies: you pay for it in unit degree.
5. **covolume price** (G4) before any enumeration.

**Prediction.** Planner at **0.7** that most of the 30,610 die at stage 2 on a large prime in
`N(a(λ))`, and at **0.75** that no surviving λ has `a(λ)` a square in `K` for this angle — because the
two candidates that *would* be squares are `λ = ±1`, and §2(d) already establishes that neither of this
rotation's two circles is a square. *Both outcomes reachable: the screen is a per-λ filter with no
aggregate, so "many survive" and "none survive" are both expressible, and a surviving λ with a square
`a(λ)` would be a **new free-circle rotation** and an immediate promotion to E4's treatment.*
**Controls (two-sided).** (i) Point the whole pipeline at `ρ₁₅` first: it must return `λ = 1` with
`a = 4`, a square, `N(a) = 16`, monochromatic at both primes, **and 30 circle points** — and phase G
§12.5 records that `σ = 17/3` returns the record's own auxiliary radii `(17 ± √33)/6`, which is a second
independent row to hit. (ii) Plant a λ known dead (`λ = 0`, the centre family, `d² = 1`, never
monochromatic) and require rejection; plant `λ = 1` and require acceptance. Assert both.
(iii) **`residue_of_coords` returns a silent `None`** when a value is not 2-integral, and
`tools/phaseh_base.py:326` tests `== (0, 0)` — so `None` is silently scored as *not monochromatic*,
which under-reports the margin. That is the conservative direction, but **assert on the `None` rather than
letting it pass**; the brief's §5.2 says so and the code does not do it.

### Demoted, with reasons — not deleted

| item | why it moved |
|---|---|
| **the brief's §8.1** (bound the shell count from above; *"if the ceiling is below ~18 the mission is over"*) | **Struck.** The ceiling does not exist (§2a: 36 points at denominator 12, and unbounded in general), so the falsifier's informative outcome is unreachable. Do not spend literature time on it — §8 below reassigns the prior-art search |
| **the brief's §8.2** (build a base at 20–24 circle points) | **Demoted below E4.** It varies the quantity §2 demotes, on a circle §2(c) shows is poor at any count. E3a answers the same question (*what count suffices?*) on the one instance that refuses, for a fraction of the cost |
| **the brief's §8.4 / `PH-3`** (does negation closure move the count?) | **Answered NO, on arithmetic, before any run.** The antipodal circle is `|p|² = 1/(2 + 2cos θ) = (43 − 3√33)/97`. Parts's lattice cannot hold a single one of its points: its squared norms are all `(S + 2P√33)/144` for integers `S, P`, and `S = 144·43/97` is not an integer. The circle *is* non-empty in `K²` — the planner constructed a witness, §10 has it — but `N_{ℚ(√33)/ℚ}(2 + 2cos θ) = 1552/256 = 97/16`, so **97 is forced into every representative's coordinate denominators** (the advisor's `PH2-3`, and the planner's witness has denominator **194 = 2·97**, independently). The advisor also measured **0 of 3,433** lattice points with a unit neighbour on that circle, against 72 on the diagonal one. Rank it below the gate |
| **building a base for the stage-1 rotation at all** | **Demoted below `ρ₆₃` (E4) and below `n = 2` (E4b).** §2(c,d): that rotation's circle lies on no cheap shell, its circle points reach unit degree **1** where the record's reach **30**, the module that fills it best has **zero** unit vectors, its achievable count on a module of Parts's coarseness is **capped at 18** and lifting that cap costs **81×** the arena, and — decisively — **its field is the 5-sealed `K(√(sin²θ))`, so even a success there is a five-chromatic object and not a rung toward χ ≥ 6.** `ρ₆₃`'s circle is free, rich and **6-open**; `n = 2`'s is empty but sits at radius 1.41 in the same 6-open field with a rational witness. Spend the session's solver-heavy slot on `ρ₆₃`. *This is the plan's largest departure from the brief; the product owner has since re-aimed the phase the same way, independently* |
| the joint-reduction route, the small-half probe, edge-thinning of the record as a *product* | closed with reasons before this phase; do not reopen (brief §9) |

---

## §5 — Instruments: what exists, what to write, and the traps

**Nothing under `tools/` is trusted.** The Lean kernel re-derives anything that matters. But do not
rebuild these.

| what | where | note |
|---|---|---|
| Parts's lattice, exact | `typem_exact.parts_lattice_exact(Fr("2.44"))` → `(pts, coeffs)` | `typem.parts_lattice(r: float)` is the float-sorted sibling: **same set, possibly different order**. `typem_exact`'s `--self-test` §4 asserts the literals 1603 / 3433 / 4513 |
| the exact sign predicate | `typem.ksign`, `typem.kcmp` | **A float may propose; it may never decide.** `typem.kfloat` is for display and sort keys only |
| squareness in `K` | `typem.k_is_square(x) -> bool` | returns a bool and **throws the root away** |
| **square roots in `K`** | **does not exist in `typem` or `typem_exact`** | lift `ksqrt` from `plans/M63-phaseH-a-base-for-a-rotation.md` §5.1 — it is written out there and it **verifies by squaring before returning**, which is the only reason it is safe. (`tools/pool_field_restrict.py:123` has `sqrt_K` on a *different* representation; converting is more work than lifting) |
| **sum of two squares / norm from `K(i)`** | **does not exist anywhere** | a one-sided witness test is enough and is cheap: `n` is a sum of two squares iff `∃ t ∈ K` with `n(1+t²)` a square in `K` (set `x = ty`). Searching `t` over small denominators **proves YES** on a hit and proves nothing on a miss — say which you got |
| the cross-edge law as a parameter | `typem.CrossLaw.collinear(cos)` | three structural refusals: `cos == 0`, `ksign(1−cos²) ≤ 0`, and `k_is_square(1−cos²)`. **`typem_exact.census_edges` constructs `CrossLaw(cos=…)` directly and bypasses all three** |
| the arena and the ask | `typem.Arena`, `typem.refuses_four` | `Arena` indexes L at `i` and S at `n+i` **on one shared index set**, and the rotated half **reuses the base's internal edge list verbatim** (`typem.py:467-469`). `Arena.__init__` **raises `StopIteration` if the origin is absent from `pts`** |
| the residue colouring | `residue_colouring.sqrt33_2adic(17)`, `…(239)`, `residue_of_coords(x, y, S)` | the two conjugation-fixed primes above 2. Returns an `𝔽₄` element as a bit pair, **or `None`** when not 2-integral |
| the whole phase-G screen | `tools/phaseg_screen.py` | symmetry gate · wide-proposal edge control and its self-test · calibration · the independent `K[x]/(x²−D)` recount · the residue certificate · `σ` and `d²` per kind |
| stage 1's base builder | `tools/phaseh_base.py` | flags: `--r2` (default `"17/4"`), `--no-u`, `--sat`, `--wall` (1800), `--skip-calib`, `--out`, `--solver-control`. **No checkpoint, no resume, no `--jobs`** |
| the committed screen artifact, with the `σ` spectrum per class | `data/m62/m63-phaseG-screen-r2.44.json` → `results[].cross.kinds[]` carries `radii`, `sigma`, `d_squared`, `equal_radii`, `ordered_pairs` | **this is what makes the criterion re-usable on a new base instead of re-run on it.** The `cos` field is a **string** like `"-11/32 + -3/32*sqrt33"`; parse it, and control the parser on two known cosines before believing a table built from it |
| the seam pattern instrument | `typem.patterns_inc`, `cross_endpoints`, `clash`, `kills_all_boxes_inc` | **committed, working, and never run on the radius-2.44 arena.** `|P_L| = 55` on 30 endpoints was measured on an *earlier* base in 57 s; 18,408 boxes on the Parts-lattice arena's S side in 116 s. The 20,000 cap has never been reported hit. Available if E2/E3 leave the mechanism open |
| Heule-510's arena indices | `data/m62/g510/state.pkl` | see E2. **`/tmp/arena244.pkl` is stale and marked "regenerate rather than trust"** |

### Traps, each one capable of a silent wrong answer

1. **`phaseh_base.enumerate_ball` is a float-Cholesky Fincke–Pohst with hard-coded `±1e-9` fudges**
   (`tools/phaseh_base.py:113` the docstring, `:115` the Cholesky, `:124` and `:128` the fudges). Its
   docstring says *"the verdict is exact later"* — true of **membership**
   (`totally_real_ok` → `ksign`), **false of completeness.** A missed point makes a graph easier to
   colour, so **for a SAT verdict this is the dangerous direction**, and for a *designed* base a missed
   circle point is a silently lost margin. If you enumerate a cut, assert the count against the pricer
   and assert that every point you designed in is present.
2. **`residue_of_coords` returns a silent `None`**, and `tools/phaseh_base.py:326` compares
   `RC.residue_of_coords(d2, ZERO4, S) == (0, 0)`, so a non-2-integral `d²` scores as *not
   monochromatic*. Conservative for the margin, but **assert on the `None`** — the brief's §5.2 says so
   and the code does not do it.
3. **The certificate can pass a base by becoming inapplicable** (`PH-5`). `phaseg_screen`'s
   distance-2 negative control is guarded by `if two_pair and not mono_two`, so a base with no
   distance-2 pair **silently loses the control while `usable` still becomes `True`**; and
   `usable: False` reads on the same footing as silence. Your boxes are *fires*, *silent*, and
   **could not be evaluated** — three, not two. `phaseh_base.certificate` at least **raises** rather
   than returning, so a run aborts and writes nothing; catch it deliberately.
4. **`refuses_four` returns a string**, and **`five_dial.sat` with `wall` falsy switches to an unbounded
   in-process solver** returning a model of a different type. Always pass a positive wall.
5. **`kills_all_boxes` returns a 3-tuple and `kills_all_boxes_inc` a 2-tuple.** Not interchangeable.
   `clash` **early-returns once it has 9 survivors**, so its survivor list is capped and is not a
   witness set.
6. **`parts_group()` returns closures** — not picklable, so it cannot cross a multiprocessing boundary.
7. **Python here is 3.14 and multiprocessing defaults to `forkserver`**, so a worker **re-imports the
   module** and any state a parent left in a module-level global is **empty in the worker**. The symptom
   is a `KeyError` on a key the parent plainly holds, which points at the dictionary and not at the
   process model. Pass `mp_context=multiprocessing.get_context("fork")` or give the pool an
   `initializer`. **`typem_exact.wall_and_eleven` memoises on function attributes**, which a worker
   inherits *not at all*, and stashes its errors there too — so a worker's error is invisible to the
   parent.
8. **`unit_edges_exact_vec` (`tools/phaseh_base.py:233`) forms a common denominator `L` over **all**
   points and builds `np.int64` arrays from it (`:251`), chunked at 2,000,000 pairs (`:257`), with no
   dtype guard.** At denominator 12 this is fine; at 97 or 194 it is not. If you ever
   build a base on the antipodal circle, check this first.
9. **`typem_exact.parts_lattice_exact` derives its search *bounds* from floats** with a `+2` pad, even
   though membership is exact. A pad is not a proof.
10. **`phaseh_base.main` rebuilds Parts's lattice at radius 3 regardless of `--r2`** and re-cuts; that is
    the expensive step, and it is wrong for any `--r2` past 9.

### Build and process discipline — each with its reason

- **Never `lake build`, bare *or named*. Always `./scripts/build.sh`.** Lake 5.0.0 has no job limit and
  sizes its pool from the machine; data modules here peak near 9 GB each and an unrestricted build has
  taken this desktop down. A *named* target is not safe either — Lake silently queues every stale
  dependency into the same pool. (No Lean work is planned in this phase; the rule stands anyway.)
- **One heavy job at a time**, and check the whole process table — `ps -eo pid,pgid,etime,args
  --no-headers | grep -E 'python3|cadical'` — not a PID list you assembled earlier. A PID filter can
  only show you what you already knew about.
- **Never stop a background job by matching its command line.** The wrapper's own command line contains
  the pattern, so it kills the shell issuing it; that cost five incidents in one session. Launch with
  `setsid`, read the pgid from the live process table **after** launch, and stop the process *group*.
- **Never edit a shell script while it is running** — bash reads it lazily by byte offset and the live
  process resumes mid-token. Launch long runs from a snapshot copy.
- **Never edit anything under `tools/` while a multiprocessing run is live** — `forkserver` workers
  re-import.
- **Do not read credential files** (`auth.json`, `.env`, keyrings) when inspecting any tool's config.
- **On any unexplained process crash, from any process: HALT and report to the product owner
  immediately.** Do not diagnose, retry, or work past it — working past one is how a filesystem event
  here lost about fifty compiled modules. **Your own `timeout` firing is not an unexplained crash; say
  so explicitly when it happens.**

---

## §6 — Recoverability

Any step expected to exceed ~15 minutes checkpoints at natural acceptance points and resumes exactly
from them. **Checkpoints must NOT live under `build/`** — that tree is described in `CLAUDE.md` as
regenerable scratch, and on 2026-09-11 an agent tidying up after itself deleted a directory there while
a live job's only resume file sat in a sibling. Nothing in this plan writes to `build/`.

```
CHECKPOINT ROOT:   /home/kooshi/source/lean-dir/data/m62/h2-ckpt/          (create it; never clean it)
RUN RECORD:        /home/kooshi/source/lean-dir/plans/M63-phaseH2-RUN.md   (append as you go)
```

| step | what is persisted, when | if the process dies at any instant, the relaunch redoes | resume command |
|---|---|---|---|
| G1–G4 (gate) | nothing; each is under ~2 min | the whole gate | rerun |
| **E1** multiplier ring | `h2-ckpt/E1-multipliers.json` after **each candidate `t`** decided | at most one candidate | `python3 tools/h2_omega.py --stage multipliers --resume data/m62/h2-ckpt/E1-multipliers.json` |
| **E2** Heule ∩ cross | `h2-ckpt/E2-heule-cross.json` once, at the end; the reconstruction is ~1 min | the whole item | rerun |
| **E3a** thinning curve | `h2-ckpt/E3a-thin.jsonl`, **one line per (k, subset, verdict) as each solver call returns** | at most one solver call (≤ 11 s) | `python3 tools/h2_thin.py --resume data/m62/h2-ckpt/E3a-thin.jsonl` |
| **E4** `ρ₆₃` | `h2-ckpt/E4-rho63-base.json` after the **cut**, again after the **cross-edge law**, again after **unit edges**, before the SAT ask; the SAT verdict appended as its own line | the last unfinished stage only — never the cut | `python3 tools/h2_rho63.py --r2 <exact> --resume data/m62/h2-ckpt/E4-rho63-base.json` |
| **E5** λ-sweep | `h2-ckpt/E5-lambda.jsonl`, one line per λ screened | at most one λ | `python3 tools/h2_lambda.py --resume data/m62/h2-ckpt/E5-lambda.jsonl` |

**Capture the state into the record before signalling any kill.** A verdict written only at the end of
a run is lost when the run is stopped, and the log is not the record. And **a run that blocks something
is presumed killable**: weigh the run against what it blocks, default to killing it, and **name what
the kill forfeits out loud** — one such kill in this milestone cost a registered out-of-sample
prediction.

---

## §7 — Reporting

The brief's §10 and `WORKFLOW.md` § "How to report to the user" bind. Three things this phase gets
wrong if it is not told:

1. **A written judgement over the rows, and no aggregate verdict.** Six agreeing and one disagreeing is
   **seven facts, not a score.**
2. **Do not report "N candidates eliminated" as the result.** Seven defects found in this milestone were
   **every one** biased toward making the work look productive, because a dropped edge yields an easier
   graph, yields a colouring, and reads as a sound elimination. **The count of eliminations is the
   outcome to be least satisfied with** — it is the cheapest thing to manufacture by accident. Audit the
   results you like at the same rate as the ones you do not, and when an artifact and its written record
   disagree, suspect the newest thing in the file first.
3. **Every candidate base states its radius-sum (`σ`) list with every verdict**, or the criterion is
   re-run on the next base instead of inherited and the base-free half of the result is lost in the
   artifact though it stays true in the mathematics.

---

## §8 — The prior-art branch

**The gate has run and reported: `plans/M63-phaseH2-prior-art.md`. Branch 2 fired.** Read it; §3.2
above is its main product. The short version: the shell count is **unbounded** (so branch 1 could not
fire, as §2a independently found), and it has an **exact closed formula in print** —
`[BaakeGrimm2003]`, found in the quasicrystal literature and not in number theory, which reproduced the
brief's own 30 and 18 out-of-sample. **Add `[BaakeGrimm2003]` to `BIBLIOGRAPHY.md` with what of ours
rests on it, where our copy is, and how much has been read per section, and keep
`python3 tools/bib_audit.py` green.**

**One question it could not close, and it matters to E4's novelty claim.** *Has anyone in print built a
base-plus-rotated-copy graph at a rotation other than `ρ₁₅`?* `[Parts2020a]` says in his own words
**"working constructions of type M with other rotations are not known yet"**, and nothing the gate
searched contradicts him — but the **Polymath16 corpus and the crystallography literature were not
searched exhaustively for a construction rather than an angle**, and `[PartsOdd2022]`'s `arccos(31/32)`
(which *is* `ρ₆₃`) is a construction on the hexagonal lattice for the **odd-distance** problem that the
gate did not open. **Recorded as: unrefuted, not confirmed.** If E4 lands, that gap is the one a
reviewer will find first — close it before the claim is written, and read `[PartsOdd2022]` §§2–3 rather
than characterising it from its abstract (`CLAUDE.md` G50).

The branches, kept for the record and for anything the gate is asked next:

1. **It bounds the shell count below ~18.** *This cannot happen* — §2(a) exhibits 36 points
   exhaustively at denominator 12, so a literature bound saying otherwise is a misreading of the
   question (almost certainly a bound at fixed **discriminant** or fixed **covolume**, which is a
   different and genuinely interesting statement: *the count is unbounded but its price is not*, which is
   §3's pricer in the literature's own words). **Report it that way, and adopt the bound as a pricer if
   it is one.**
2. **It gives a formula or construction for the shell count.** Then E4's P2 and E5's stage 4 become
   arithmetic instead of enumeration. Adopt it, and keep one enumerated instance as the control.
3. **It finds nothing.** The recorded negative is itself a finding about where the unworked ground is,
   and it goes in `§PA` of the run record: *"searched X, Y, Z under these names; nothing."*

**Reassign the search, because the question changed.** Send the agent these, in this order:

- **Has any type-M (one lattice ∪ a rotated copy) *unit-distance* construction ever been built at an
  angle other than `arccos(7/8)`?** Specifically `arccos(31/32)` — which is in print for the
  **odd-distance** problem (`[PartsOdd2022]`, held at `~/source/library/pdf/arXiv-2206.12632.pdf`, already read to §1/§2/§4 per `BIBLIOGRAPHY.md`) and, as far as
  this repository knows, never for unit distances. **If it has, E4 is a reproduction and not a
  discovery, and the session must know that before it spends its solver slot.**
- **Is the criterion of §2(d) in print** — that the equal-radius family of a type-M rotation is
  non-empty for free exactly when `1/(2 ∓ 2cos θ)` is a square in the coordinate field? Search under
  *similar sublattice*, *shell of a lattice*, *scaled copy of a lattice*, *multiplier ring / order of a
  lattice*, and in the Polymath16 corpus under `ω_t`.
- **The `ω_t` family's own provenance**, beyond `[Polymath16wiki]`: who wrote down
  `cos θ = 1 − 1/(2t²)` first, and did anyone enumerate which members break the 2-adic wall?

Anything found goes into `BIBLIOGRAPHY.md` **the same day**, with what of ours rests on it, where our
copy is, and how much has actually been read per section — and `python3 tools/bib_audit.py` must stay
green. **An abstract is not a reading** (`CLAUDE.md` G50).

---

## §9 — Acceptance, mapped item by item onto the brief's §10

| the brief's §10 asks | how this plan delivers it |
|---|---|
| **§5's prior-art section exists**, with a recorded negative if nothing was found | §8, as `§PA` of `plans/M63-phaseH2-RUN.md`, with the search **reassigned** because §2(a) answered the original question |
| **every experiment's prediction and cost registered before it runs**, scored after as met / not met / not decided | §4: every item carries a prediction with a numeric confidence, a cost with the machine named, and a scoring line. Register them in the run record **before** the command, not after |
| **confirm both outcomes are reachable**, the informative one and the uninformative one | §4: stated per item. And two of the brief's own falsifiers are struck for failing exactly this test — §8.1's "mission over" outcome is unreachable (§2a), and its §8.4 is answered before any run |
| **every control seen red before it is believed green**, with the plant bounded on both sides `0 < guarded − planted < threshold` | §4: every item's controls are written in that form, with the **lower** bound's meaning spelled out (the plant has stopped firing) and the **upper** bound's (it fires too much). And name what a wrong-reason red would look like before believing one — three plants in this milestone fired for the wrong reason, one dying on an out-of-range index *before* reaching the guard it was written to test. The repair is a **pair**: the stub that must fail beside a faithful stub that must **pass** |
| **the known-answer sanity check (§8.5) reproduces 30** before any new number is believed | **G1**, and it is a hard stop |
| **any candidate base states its radius-sum list with every verdict** | §7 item 3 |
| **a written judgement over the rows, and no aggregate verdict** | §7 item 1 |
| **the two sentences carried into every report** | §1, plus the advisor's `PH-10` scope sentence as a third |

**And what "done" looks like, beyond the acceptance list.** This phase is done when the run record can
answer, each with its evidence and its controls discharged:

1. Does the only known type-M refusal route through the equal-radius family, and on how few cross edges
   can it be carried? (E2, E3a)
2. Is the free-circle family on Parts's own lattice exactly `t ∈ ℤ`, or larger? (E1)
3. What does `ρ₆₃` do — the first type-M rotation other than `ρ₁₅` ever asked the unit-distance
   question, in a **6-open** field, on a base **denser** than the record's and with the record's exact
   cross-edge decomposition? (E4)
3b. And is there a module for `n = 2` carrying both shells — the brief's mission, re-aimed at the
   cheapest radius in the family and the same 6-open field? (E4b)
4. And the honest scope sentence: **whatever happened, no type-M arena has yet been shown to produce
   five-chromaticity rather than to contain it.**

---

## §10 — What lives only in the planner's context

*Written because files are the only memory that crosses between agents, and the implementer arrives with
none of the planning conversation. Decisions with their reasons, dead ends with why they died, and two
constructed objects.*

### 10.1 — Three witness points, constructed and verified here

**The brief's witness, re-derived** (do not lift on faith; the brief says so and it is right):

```
u = ( 1/3 − √3/2 − √11/6 ,  1/3 + √3/2 + √11/6 )
  as 4-tuples over (1, √3, √11, √33):   x = (1/3, −1/2, −1/6, 0)   y = (1/3, 1/2, 1/6, 0)
  |u|² = (7 + √33)/3 = 1/(2 − 2cos θ)   exactly,   radius 2.061113
```

**A second witness, on the antipodal circle, constructed by the planner and not in any other file:**

```
w = ( (67√3 − 5√11)/194 ,  (19√3 − 13√11)/194 )
  as 4-tuples:   x = (0, 67/194, −5/194, 0)   y = (0, 19/194, −13/194, 0)
  |w|² = (43 − 3√33)/97 = 1/(2 + 2cos θ)   exactly,   radius 0.5153951
  the antipodal cross pair (w, ρ(−w)) has |w − ρ(−w)|² = 1 : the independent K[x]/(x²−D) expansion
  returns rational part 1 and radical part 0
  d² = 4|w|² = (172 − 12√33)/97 , residue (0,0) at BOTH primes -> monochromatic at every prime
  φ(w) = (0,0) at both primes, so w is inside the colouring's domain and PH-5's applicability trap
  does not bite
```

**Two honesty notes on that verification, because the checks are weaker than they look.**
(i) The **radical part is identically zero for any collinear pair** — the coefficient is
`2[uₓv_y − u_yvₓ]` and `v = ±u` makes it vanish — so it is **vacuous** at `λ = ±1` (this is stage 1's
own `P-H1b`). (ii) The **rational part being 1 is an algebraic identity** given `|w|² = 1/(2+2cos θ)`:
`(1+cos)²n + (1−cos²)n = n(2+2cos) = 1`. So the only content is `|w|² = n`, which was checked
exactly. **The non-vacuous check is the wrong-cosine control**, which stage 1 ran and which kept only
the 60 centre edges of 104 — the right number for a reason, since the centre family's condition does
not involve `cos θ`.

**A third witness, trivial and now the most useful of the three:** the circle of Target B
(`n = 2`, `cos θ = 3/4`, 6-open field `K(√7)`) contains the **rational** point

```
p = (1, 1) ,    |p|² = 2 ,    radius 1.4142
```

absent from Parts's lattice only because his coordinates confine `y` to `ℚ√3 ⊕ ℚ√11` (`PH-3`). No
radicals, no denominators, no 97. Recorded because the phase spent a night constructing points with
denominators 6 and 194 for circles in a **5-sealed** field while a circle in a **6-open** field had an
integer point on it.

**And why `w` is a dead end rather than a lead:** its denominator is **194 = 2·97**, and
`N_{ℚ(√33)/ℚ}(2 + 2cos θ) = 97/16` forces **97** into every representative of that circle. The advisor
derived the forcing independently and measured **0 of 3,433** Parts-lattice points with a unit
neighbour on that circle. Trap 8 in §5 (int64 overflow in the exact unit-edge routine) bites at that
denominator. Recorded so nobody constructs it a third time.

### 10.2 — The 36 circle points, and the module they span

Exhaustive enumeration of `K`-points on `|p|² = (7+√33)/3` by coordinate denominator `q`:
**0 at `q ≤ 3`, 12 at `q = 6` (including `u`), 36 at `q = 12`.** Both counts are multiples of 6, which looked
like support for the product owner's `ζ₆` hypothesis — **it is not**, for two reasons now both settled.
The counting sets here are not `ζ₆`-stable (`ζ₆` multiplies a denominator by 2, taking `q = 6` to
`q = 12`), so the multiples of 6 are not evidence; and **the relevant group is `μ₁₂`, of order 12, not
`⟨ζ₆⟩`** — `√3 ∈ K` puts `ζ₁₂ = (√3 + i)/2` in `K(i)` (§3.2, derived three independent ways). The
correct and now-proved statement is §3.2's `|U_M|` factor: the count is a multiple of
`|U_M| = |{ζ ∈ μ₁₂ : ζM = M}|`. Stage 1's base had 8 = 4 × 2, so its `|U_M|` was 4.

The ℤ-span of the 36 is **rank 8, covolume 42.491**, and its totally-real cut at radius 2.44 holds
**3,037 points** — against a pricer prediction of 2,880 (5%). It contains all 36 circle points, the
origin, is closed under negation, is **not** closed under the Galois flips, and has **0 points of norm
1 and 0 unit edges.** That last pair is §2(b) and it is the most useful number the planner produced.

*The planner's enumeration and pricing code was ad-hoc scratch and is **not** committed. **Re-derive
both**, with the controls in G4 — a number produced once by uncommitted code is provenance, not a
measurement.*

### 10.3 — Dead ends, and why each died

| tried | died because |
|---|---|
| **maximise the circle count** (the brief's target) | §2. Unbounded, hence no maximum; free, hence not the constraint; and a counter-instance at `t = 3` beats the record's count by 80% while being provably four-colourable |
| **close `ζ₆` around `u` itself** | rank 8 with covolume ≈ 6.5×10⁻⁴ and ≈ 1.9×10⁸ cut points (stage 1 §H4). **The expensive thing was never `ζ₆` — it was `ζ₆` *together with* Parts's lattice.** `u·O_{K(i)}` alone would be far coarser. But it is moot: §2(c) says a module built around `u`'s circle has no unit shell, whatever its covolume |
| **the antipodal / negation-closure family** (`PH-3`, brief §8.4) | 97 forced into every coordinate denominator; 0 of 3,433 lattice points have a unit neighbour there; trap 8 bites. §10.1 |
| **requiring `λ·Λ ⊆ Λ` for off-diagonal λ** | the advisor's correction, and it is right: you need only that `λp` be in the base **for each circle point `p` you use** — one extra point per used point, not a `ℤ[λ]`-module. `λ`-closure *enlarges* the module, so it is a pure cost, and `λ = 1` is the unique λ where the closure is free (`λp = p`). The planner's formula *"the count equals the circle count whenever the module is closed under ×λ"* is true and hides that cost |
| **`min` over primes as a hardness measure** | it is exact as a **fragility** measure (within `min` edges of *provably* colourable) and the necessary condition is only `M_𝔭 ≠ ∅` at each prime, which 8 satisfies as well as 30. `PH2-6` |

### 10.4 — Open, and offered rather than resolved

- **Is `a = 1/(2+2cos θ)` a norm from `K(i)`, in general?** The planner found a witness for all four
  circles tested (so all four are non-empty in `K²`) by the `n(1+t²)` square test; the advisor reduced
  the general question to *"is `101 − 11√33` a sum of two squares in `K`"*, i.e. one Hilbert-symbol
  computation at the primes above 2 and 97, and did not finish it. **Unresolved, and it does not block
  anything** — the forced 97 settles the ranking either way.
- **The advisor's `PH2-7`**, offered in the hypothetical mood by its own author: the diagonal kind is a
  perfect **matching** (`p ↦ ρp`, injective, `λ = 1` being the coincident root), and a matching is
  1-regular and carries no colour pressure (`CLAUDE.md` G14). Sharper: by G46 the rotated half shares
  the index set, so an arena colouring can be written `(C, π∘C)`; a diagonal cross edge then needs
  `π(C(p)) ≠ C(p)` — a condition on `p`'s **colour class** — while the shared centre needs
  `π(C(0)) = C(0)`. So inside that family the diagonal kind's entire contribution is *"π moves every
  colour the circle hits and fixes the centre's"*: **at most four conditions, however many points the
  circle has.** The planner's reservation, sent to the advisor and not yet answered: the record's actual
  refusal (Heule-510) is **not** in that family, so the bound may be about a family the answer never
  lived in. **Carry it as "a sufficient family in which the count is nearly worthless, hence the count's
  value must come from outside that family", not as a bound on the count.** Note the fatal instance
  stage 1 already has: `φ(u) = (0,0) = φ(0)` at both primes.
- **§H9's question is still open and this plan does not answer it:** *what does `ρ₁₅` have that
  `5/16 − 3/16√33` lacks?* **Both** have a square equal-radius circle (§2d), so the free-circle
  criterion separates those two from the other nine and from the stage-1 rotation, and **does not
  separate them from each other.** The difference is 30 versus 18 — how many of the 30 scaled unit
  points land inside the cut — and whether that is the whole story is untested. `typem.patterns_inc`
  on both arenas is the cheapest instrument nobody has pointed at it.
- **One contested row, now resolved, and the resolution is recorded because the mechanism repeats.**
  The advisor's `PH2-4` claimed `n = 16` is the unique 6-open member at radius ≤ 8; the planner read
  `n = 64` (radicand 255, squarefree 255, `255 ≡ 2 (mod 11)`, a non-residue) as also 6-open. **The
  advisor was wrong and conceded, and its own printed table contained the refutation** — the sweep had
  printed `n = 64` as 6-open and the prose said unique. Correct statement: **`n = 16` is unique at
  radius ≤ 4; `n = 64` is the second, at radius 8.** The advisor's note on its own error is the durable
  part: *"the data was right and my prose was new — `CLAUDE.md`'s own rule, when an artifact and its
  written record disagree suspect the newest thing in the file, and I was the newest thing."*
- **One case neither the planner nor the advisor has covered: `n = 36`** (`cos = 71/72`, radicand
  `143 = 11·13`). **11 divides the radicand, so 11 ramifies** — neither inert nor split — and G43's
  criterion is stated for inert-versus-split and is **silent**. Both of us marked it "no" and that is a
  guess, not a reading. **A ramified 11 is a third column and the screen should say so rather than
  guessing.** And it is **routine, not a curiosity**: `11 | 4n−1 ⟺ n ≡ 3 (mod 11)`, so it hits
  **`n = 3, 14, 25, 36, 47, …` — one member in eleven**, and the screen as written tests `d % 11 ≠ 0`,
  which is a convention and not a theorem. Worth one line from whoever owns G43 before the screen
  ships, because it will bite the next screen even if it does not bite this one.
- **`data/m62/rotations-exact-moser-r2.05.json`** is a rotation census on a base that is **not** Parts's
  lattice, and it has sat unread through three advisory ledgers. It carries no residue screen, so it
  cannot decide anything alone — but if this phase ever wants a second base, or a check that the
  criterion behaves on a base that is not `Λ_parts`, it is on disk and it is free.

### 10.5 — One fault found and deliberately not fixed

`CLAUDE.md` line 124 reads *"Extended to radius 2.44 (3,433 points, 179 orbits) **the base** contains
Heule-510 exactly"*. Its source, `plans/M62-evolutionary-type-m.md:1361`, reads **"the arena"**, and
line 845 gives the split: 375 of Heule-510's vertices in the base, the other 136 (135 in the
`verify244.log`, the difference being the shared centre counted twice) on the rotated copy. Read
literally the Frontier asserts a 5-chromatic subgraph of `K²`, contradicting `chromaticNumber_seamPlane`
(χ(K²) = 4, kernel-checked) four rows below it in the same file. **The fix is one word — "arena" for
"base" — plus the 375/136 split named.** Found by the advisor (`PH-10`), verified in stage 1, and left
to the product owner both times: `CLAUDE.md` is a project instruction file and **an agent's request is
not authority to edit one.** It is recorded here a third time so it is not lost a third time.
