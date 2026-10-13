# Draft claim list M3-markov-kakutani — Markov–Kakutani, twice: an invariant probability measure on a closed invariant set of colourings

*Drafted by FS131-KN3 (the chain's planner) for Keryx to fix; a draft, not a fixed claim list. Kind: planner and implementer (ruling 4).*

## The leaves it carries (quoted by script)

> NF2-LEAF-04: Markov–Kakutani, twice — discharges `InvariantMeasureOnClosed` (7 takers). Printed: `[Kakutani1938]`; `BIBLIOGRAPHY.md`: not held; the docstring: "not read". Mathlib: no fixed-point theorem for commuting affine maps, no invariant measure for an amenable action (searched "markov.?kakutani", "amenab": Følner filters, Riesz–Markov–Kakutani and `MeasureTheory/Measure/Prokhorov.lean` only). My call: **formalize**, its own job; the fixed-point theorem is a page and compactness of the probability measures is Prokhorov's file. Size unknown.
> — source: data/fs131/claims-NF2.md § The chain's leaves

## Statements

1. `SpectralChain.InvariantMeasureOnClosed F` for every `F` with `unitRing F` countable — the `Prop` is through the gate; this module proves it.

## Derivation addresses

`[Kakutani1938]` — **not held, not read** (the map's § X5). No derivation of ours

## Imports

`SpectralChain`, Mathlib's `Measure/Prokhorov`

## Exports

discharges 7 takers

## Can run beside

new files only

## Not claimed

Any size or price. That the statements marked "to type" elaborate as written. What I read: not read by me; size unknown.
