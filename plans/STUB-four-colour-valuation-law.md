# STUB — the 2-adic law of four-colour compulsions

*Minted 2026-09-09 out of the mascot challenge. Not a milestone; a theorem with a write-up
attached, and the arithmetic half of anything FS-20 says about compulsions.*

## The statement

Over `K = ℚ(√3, √11)`, with `𝔭` the conjugation-fixed prime above 2 of Theorem B:

- a pair **forced monochromatic** in every proper 4-colouring has `v_𝔭(difference) > 0` — for
  rational `d²`, `d²` is 2-adically **even**;
- a pair **forced to differ** has `v_𝔭(difference) = 0` — `d²` is a 2-adic **unit**.

Both are one line from Theorem B: the residue colouring is itself a proper 4-colouring, so any
compulsion must survive it, and it identifies exactly the pairs of positive valuation. The six
`ℤ/4`-type additive colourings of the Eisenstein lattice sharpen the first to `v ≥ 2`.

## Why it is worth writing down

**It explains a published table nobody explained.** `[Parts2020a]` Table 1 lists the minimal gadget
sizes for four-colour compulsions, found by computer: monochromatic pairs at `8/3` (367 vertices)
and `8/√3` (421); non-monochromatic pairs at `3` (214), `7/3` (319), `5/3` (315), `1/3` (312),
`√(11/3)` (308). **Every monochromatic distance is 2-adically even and every non-monochromatic one
is a 2-adic unit.** Parts offers no explanation and does not appear to notice the pattern.

**It explains our own M53 rigidity dial**, which found forced pairs only at that depth over 15,230
pairs and recorded it as an unexplained regularity (`plans/FIELD-WALL-SESSION-HANDOFF.md` §8).

**And it comes with a selection identity.** For any rotation `ω` with `cos θ = c`, since `ω̄ = 1/ω`,
`ω² + ω + 1 = ω·(2c + 1)`, so the third rung of a ladder is `(2c+1)` times the first. Normalise the
first rung to 1 and the third is exactly `2c + 1`; at the Moser twist `c = 5/6` that is `8/3`,
2-adically deep, and the spindle over it adjoins `√(4·(8/3)² − 1) = √247/3`. So `8/3` and
`ℚ(√3,√11,√247)` — Exoo–Ismailescu's own field — fall out of `cos θ = 5/6` in two lines rather than
by search.

## The companion duality, also worth stating

**A plane-wide pigeonhole at distance `d` forbids every virtual edge at `d`.** Our kernel has such
pigeonholes at `√3` (`core9_plane`) and at 2 (`core122_plane`), and `Homogeneous.lean` transports
one forced pair to all pairs at that distance. So `√3` and `2` admit **no compulsion of either
kind** at four colours: not monochromatic (the valuation law), not distinct (the pigeonhole). They
are permanently free, which is why the hexagonal shell's own pigeonhole cannot be sharpened.

## Status

Hand-proved, checked against two independent empirical tables. Not kernel-checked — it needs
Theorem B's residue map exposed as a colouring over an arbitrary `K`-object, which `FieldWall4.lean`
has, plus the `ℤ/4` family, which `Additive.lean` has. Estimated an afternoon.
