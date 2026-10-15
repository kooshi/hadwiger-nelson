# Draft claim list M2-herglotz-bochner — Herglotz–Bochner on a countable discrete abelian group, with uniqueness; Bochner for an induced topology

*Drafted by FS131-KN3 (the chain's planner) for Keryx to fix; a draft, not a fixed claim list. Kind: planner and implementer (ruling 4: formalized, a module of its own).*

## The leaves it carries (quoted by script)

> NF2-LEAF-03: Herglotz–Bochner on a countable discrete abelian group, with uniqueness — discharges `BochnerHerglotz` (13 takers). Printed: `[Rudin1962]` 1.4.3 and 1.3.6; the hypothesis's docstring says "not quoted from a held copy"; the read-back is owed (`ARCHITECTURE.md` § Trust: "the page not read"). Mathlib at the pin: no positive-definite functions on groups, no Bochner (searched "positive.definite function", "PositiveDefinite", "herglotz", "bochner's theorem": only Poisson and Jensen files); it holds `Topology/Algebra/PontryaginDual.lean` and Riesz–Markov–Kakutani (`MeasureTheory/Integral/RieszMarkovKakutani/`). My call: **formalize**, as a planner-and-implementer job of its own — more than an hour, a classical theorem with a self-contained proof, and thirteen statements wait on it. Size unknown.
> — source: data/fs131/claims-NF2.md § The chain's leaves

> NF2-LEAF-11: J45-N1 (a) at `S = ∅`: the characters continuous for the profinite-plus-archimedean topology on `ℤ[U_F]` are exactly `T + A` (J45 § 1.2, § 5.4; `plans/FS131-w10-kernel-plan.md` § 3.3: "not stated"). With it `SpectralInputs.spectral_carried_iff` reads at `T + A`, over `BochnerOn` — Bochner for a topology induced from a locally compact group, the same `[Rudin1962]` 1.4.3 (leaf 3's job should prove this form too).
> — source: data/fs131/claims-NF2.md § The chain's leaves

## Statements

1. `SpectralChain.BochnerHerglotz G` for every countable `AddCommGroup G` — the `Prop` is through the gate; this module proves it.
2. `SpectralInputs.BochnerOn t` for a topology `t` induced by a homomorphism with dense range into a locally compact abelian group — through the gate as a `Prop`; proved here in the form M10 reads.

## Derivation addresses

`[Rudin1962]` 1.4.3, 1.3.6 — **the page is not read** (`ARCHITECTURE.md` § Trust; the map's § X5). No derivation of ours

## Imports

`SpectralChain` (for the `Prop`), Mathlib's `RieszMarkovKakutani`

## Exports

discharges 13 takers of `BochnerHerglotz`

## Can run beside

new files only

## Not claimed

Any size or price. That the statements marked "to type" elaborate as written. What I read: not read by me beyond the `Prop`s; size unknown.
