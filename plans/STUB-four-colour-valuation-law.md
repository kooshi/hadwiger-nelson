# The 2-adic law of four-colour compulsions — KERNEL-CHECKED 2026-09-09

*Minted 2026-09-09 out of the mascot challenge, and closed the same day
(`Proofs/HadwigerNelson/ValuationLaw.lean`, axioms exactly the standard three). Kept, per the
deprecate-never-delete rule, because the record of what it claimed before it was checked contains
one claim that did not survive — see §The companion duality below.*

## The statement

Over `K = ℚ(√3, √11)`, with `𝔭` the conjugation-fixed prime above 2 of Theorem B:

- a pair **forced monochromatic** in every proper 4-colouring has `v_𝔭(difference) > 0` — for
  rational `d²`, `d²` is 2-adically **even**;
- a pair **forced to differ** has `v_𝔭(difference) = 0` — `d²` is a 2-adic **unit**.

Both are one line from Theorem B: the residue colouring is itself a proper 4-colouring, so any
compulsion must survive it, and it identifies exactly the pairs of positive valuation.

**As kernel-checked, in both forms.** The *scalar* form reads through the distance rather than its
square — the same statement (`v_𝔭(d²) = 2·v_𝔭(d)`) and a shorter proof: write the difference as
`d · u` with `u` a unit vector, note that a unit vector is a *unit* of the odd-denominator ring `A`
and so has invertible residue, and the difference's residue is the scalar's. The *squared* form —
this stub's original phrasing — is `psiA_eq_zero_iff_normSq`: for any difference lying in `A` at
all, its residue vanishes exactly when `d²`'s does, because conjugation induces Frobenius on the
residue field, so `ψ(v)³ = ψ(v·v̄) = ψ(d²)` and in `𝔽₄` a cube vanishes only with its base. The
squared form needs no assumption that `d` lies in `K`, and `1 + i` is the instance that shows the
difference: a `K`-point difference of length `√2`, with `√2 ∉ K`, residue zero — so no pair of
`K`-points differing by `1 + i` is a virtual edge at four colours.

- `residueColouring_eq_iff_psiA_zero` — the law.
- `not_forces_of_residue_ne_zero` / `not_separated_of_residue_eq_zero` — its two consumers, in the
  hunt's own vocabulary.
- `not_forces_at` / `not_separated_at` — the same, taking the witness `(m, x)` with `m·d = den x`
  so a row of the table is one line.

## Why it was worth writing down

**It explains a published table nobody explained.** `[Parts2020a]` Table 1 lists the minimal gadget
sizes for four-colour compulsions, found by computer: monochromatic pairs at `8/3` (367 vertices)
and `8/√3` (421); non-monochromatic pairs at `3` (214), `7/3` (319), `5/3` (315), `1/3` (312),
`√(11/3)` (308). **Every monochromatic distance is 2-adically even and every non-monochromatic one
is a 2-adic unit.** Parts offers no explanation and does not appear to notice the pattern. §4 of
the module proves all seven rows: each distance is barred from the other column. And the red that
pins the reading: `8/3` and `7/3` share a denominator and land in different columns, so the
criterion is the numerator's valuation and nothing else.

**It explains our own M53 rigidity dial**, which found forced pairs only at that depth over 15,230
pairs and recorded it as an unexplained regularity (`plans/FIELD-WALL-SESSION-HANDOFF.md` §8).

**And it comes with a selection identity.** For any rotation `ω` with `cos θ = c`, since `ω̄ = 1/ω`,
`ω² + ω + 1 = ω·(2c + 1)`, so the third rung of a ladder is `(2c+1)` times the first. Normalise the
first rung to 1 and the third is exactly `2c + 1`; at the Moser twist `c = 5/6` that is `8/3`,
2-adically deep, and the spindle over it adjoins `√(4·(8/3)² − 1) = √247/3`. So `8/3` and
`ℚ(√3,√11,√247)` — Exoo–Ismailescu's own field — fall out of `cos θ = 5/6` in two lines rather than
by search. (Not formalized; it is arithmetic about a rotation, not about a colouring.)

## The companion duality — **RETRACTED 2026-09-09, in the formalization that found it**

This stub claimed: *a plane-wide pigeonhole at distance `d` forbids every virtual edge at `d`; our
kernel has such pigeonholes at `√3` (`core9_plane`) and at `2` (`core122_plane`), so `√3` and `2`
admit no compulsion of either kind at four colours.*

**The argument is unsound, and the reason is this repository's own rung B.** `core9_plane` and
`core122_plane` quantify over `(unitDistance ℂ).Coloring (Fin 4)` — proper four-colourings of the
*whole plane* — and `χ(ℝ²) ≥ 5` says that type is **empty**. Both theorems are true, both are
kernel-checked, and both are **vacuous**; a vacuous hypothesis forbids nothing. The emptiness is
now itself a theorem, `Instances/Interval.lean`'s `isEmpty_coloring_plane_four`, with the general
reading `vacuous_of_plane_four_coloring` beside it and a scope comment on each of the two
corollaries.

**What is untouched**: the milestone-M34 content those corollaries were written to carry — the
1-minimal nine- and 122-point carriers and their pigeonholes — quantifies over four-colourings of a
*finite graph that has them* (the nine-core is 3-colourable), and is unaffected. Ledger row 31 is
amended in place rather than withdrawn.

**What replaces it, and is open work.** The non-vacuous plane-level form must name a class of
objects that really is four-colourable, and over `K` Theorem B supplies one. The intended argument
survives in that setting, and the sketch is:

1. re-state the `√3` carrier over `K` — show `core9`'s nine points lie in `K²` (they are hexagram
   material, so this is expected, but the certificate stores them in the `ℚ(√3,√5,√7,√11)` tower
   and the bridge to `seamSpan` is not written);
2. suppose some `K`-object separates one `√3`-pair at four colours; transport it by `z ↦ az + b`
   with `a` a norm-one element of `K(i)`, which keeps every point in `K²`, to get a separating
   object for *every* `√3`-pair of `K`-points;
3. glue one onto each of the carrier's six `√3`-pairs; the union is a `K`-object with no proper
   four-colouring, contradicting Theorem B.

That would give **no virtual edge at `√3` over `K`**, which together with `not_forces_dist_sqrt_three`
(proved) makes `√3` carry no compulsion of either kind over `K` — the statement the retracted
argument was reaching for, in the only setting where it has content. Estimated a day, most of it
step 1.

## Status

Kernel-checked (`ValuationLaw.lean`, 30 audited declarations, standard three axioms), in both the
scalar and the squared form, with the seven rows of Parts's table, a model of the hypotheses, and
three reds. The duality is retracted
and its repair is stubbed above.
