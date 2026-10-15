# Draft claim list M10-continuity-group — J45-N1 (a) at `S = ∅`: the characters continuous for the profinite-plus-archimedean topology are exactly `T + A`

*Drafted by FS131-KN3 (the chain's planner) for Keryx to fix; a draft, not a fixed claim list. Kind: planner and implementer.*

## The leaves it carries (quoted by script)

> NF2-LEAF-11: J45-N1 (a) at `S = ∅`: the characters continuous for the profinite-plus-archimedean topology on `ℤ[U_F]` are exactly `T + A` (J45 § 1.2, § 5.4; `plans/FS131-w10-kernel-plan.md` § 3.3: "not stated"). With it `SpectralInputs.spectral_carried_iff` reads at `T + A`, over `BochnerOn` — Bochner for a topology induced from a locally compact group, the same `[Rudin1962]` 1.4.3 (leaf 3's job should prove this form too).
> — source: data/fs131/claims-NF2.md § The chain's leaves

## Statements

1. to type — the topology `τ′_∅` on `unitRing F`, and `SpectralInputs.contChars τ′_∅ = TA F`, both inclusions (EN1 § 3.3). **This is where the spectral lemmas' reader gets its description of the one set `TA F`.**
2. then `SpectralInputs.spectral_carried_iff` reads at `TA F`, over `BochnerOn τ′_∅` (M2).

## Derivation addresses

EN1 § 8.1 rows 2, 4: J45 § 2.1 (ll. 110–113, 126–135) (`plans/FS84-SI-D-derivation.md`); `plans/FS131-EN1-derivation.md` § 3.3; J28V-7 (`plans/R88-derivation.md` l. 182: `NR` of finite index — Lemma F, in C0)

## Imports

`Arith/SpectralInputs`, `Rigidity/ChainAtTA`, C0

## Exports

N2 at `T + A` for M11

## Can run beside

new files; after C0's Lemma F

## Not claimed

Any size or price. That the statements marked "to type" elaborate as written. What I read: not read by me beyond EN1's table; size unknown.
