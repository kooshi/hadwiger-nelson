# STUB — row 134's base with unit arcs in Lean (`row134BaseUA`): what stays outside, and the in-milestone job (draft by FS131-K5, for Keryx to file)

*Drafted 2026-10-04 by FS131-K5 (de Bruijn, the planner of FS-131's wave 5), at inventory item 191's word; **rewritten at the brief's amendment
(inventory items 196–197)**. Written for a planner with no memory of the session that wrote it.*

## What stays outside: provisionally nothing

Inventory item 197: the unit-arc statement of the base is wave 5's intermediate `Prop` **`Row134BaseUA`**, proved inside FS-131 (`row134BaseUA`,
`Plane/ValidMap/Dense`); only the pieces of `[SokolovVoronov2025]` the walk uses **by statement** become named outside `Prop`s. On FS112-N3-BASE's
table (`plans/FS112-N-proof.md` stage N3-3, read in full by this job), **every step of the base is read inside a proof**: each row names a use of
Condition 5 that the walk replaces by a unit-arc lemma (so the step's proof, not its statement, is what the walk consumes), and S–V Lemma 5 and
Prop. 18 enter through "(ii)", which the walk replaces by N3-II. No piece appears to be used purely by statement, so **this stub covers nothing
outside as far as the table shows**, and the whole base is ours to formalize — Keryx's stated option: place it in this milestone as its own planner
job. **Unconfirmed**: FS110-CB, -CD, -CE, -CC and `plans/BASE-V-verification.md` were not read by this job; the candidates to check for a
by-statement use are pure circle-colouring lemmas (a statement about finite colourings of one unit circle that never reads the map), if CB's
route cites any from the paper without re-proving it. The rest of this file is the brief for that in-milestone job.

## What `Row134BaseUA` states (the Lean text, `Proofs/HadwigerNelson/Plane/ValidMap/Chain.lean` on branch `fs131-w5`)

```lean
def Row134BaseUA : Prop :=
  ∀ (F : ArcMap 6) (u : ℂ), F.Valid → F.Covers u 2 → F.IsCubicTrichromatic u → F.BaseHyp u → F.NoInertNear u → False
```

In words: **in a valid six-coloured fragment covering the closed disc `B̄(u, 2)` — boundaries segments and circular arcs, arcs of radius 1
allowed — a cubic trichromatic vertex `u` (degree 3, three colours) such that no point of `B̄(u, 2)` carries four or more colours or a repeated
colour (`BaseHyp`), and no inert unit arc (neither side colour carried at its centre) is centred within distance 1 of `u` (`NoInertNear`), does
not exist.** `ArcMap`, `Valid`, `Covers`, `IsCubicTrichromatic`, `fourSet`, `repSet`, `Inert` are the library's (waves 3–5 of FS-131; read
`Plane/ArcMap`, `Plane/LocalMap`, `Plane/ValidMap/Basic`, `Plane/ValidMap/Chain`). It is wave 5's intermediate statement (inventory item 197), not an outside hypothesis; the job this stub describes **proves it** (`row134BaseUA`),
so that FS112-N3-BASE, -N3-DENSE3, FS129-OR1-LOCALDENSE and FS114-CV-EXISTS are unconditional but for any outside piece it names.

## Why this form (and not the Condition-5 base)

Row 134's base is `[SokolovVoronov2025]` Cor. 1 (no six-colouring of the plane by a map all of whose trichromatic vertices are cubic, under
their Conditions 1–6), read almost everywhere for curved arcs and locally at one cubic trichromatic vertex (CB's route reads `B̄(u, 2)`), with
FS-110's repairs (CB, CD: no `d = 2` exception; CE: D5's local repair R1–R4 and the Antipodal Lemma; CUSP-BASE: the base at cusp sectors). That
statement assumes Condition 5 (no unit arcs). FS-112 (`plans/FS112-N-proof.md` stage N3-3, the N3-BASE table; NB3 blind) re-ran the base **with
unit arcs**: each step that used Condition 5 is replaced by a unit-arc lemma whose exception is a vertex of four colours or a repeated colour within
2 of `u`, or nowhere. So the Condition-5 statement does not imply the unit-arc one as a black box — an (R2) arc and the in/out arcs at leaving
centres survive every bend — and `Row134BaseUA` is stated at the unit-arc class. The planner of wave 5 chose this form (plan § 2.2 of
`plans/FS131-w5-kernel-plan.md`, finding F-BASE): FS112-N3-BASE's Lean proof is then the inert pre-bend plus `Row134BaseUA`, and **the walk's
assembly is this job's**, with the walked steps available as theorems.

**Read-back against the sources (to be completed by this job's planner, who reads them):** S–V Cor. 1's hypotheses are the map type of their §
2 (Conditions 1–6); Condition 5 is replaced by the walked lemmas below, Condition 6 by "cubic trichromatic at `u` and no repeated colour in
`B̄(u, 2)`" (CB's local reading), almost-everywhere properness by `Valid` (interior points only). FS110-CB's "no `d = 2` exception" and CD's
Theorem D2 are inside the proof. Reading status in this job: `LEDGER.md` row 134's text and grade line read; `plans/FS112-N-proof.md` W4 (CB's
lines) and the N3-BASE table read; FS110-CB, -CD, -CE, -CC, `plans/BASE-V-verification.md` **not read**; the paper not read.

## Where it is used

- **FS112-N3-BASE** (`n3_base`, `Plane/ValidMap/Dense`): `Row134Base → Valid → Covers u 2 → IsCubicTrichromatic u → BaseHyp u → False`, by
  bending the inert unit arcs centred in `B̄(u, 1)` toward their centres (wave 4's `bend_toward`, FS112-N2-BENDS) and applying `Row134BaseUA`.
- Through it: **FS129-OR1-LOCALDENSE** (`localDense`), **FS112-N3-DENSE3** (`dense3`), **FS114-CV-EXISTS** (`cv_exists`) — the reduction of the
  unit-arc NO to C114-LOCAL-F (rows 135, 137).
- Control: `not_row134Base_seven` — the seven-colour form is false at the brick corner (six colours are spent, as N3-BASE's "where six is spent"
  says: the base's count).

## What its proof needs (the base's steps, and who supplies each)

| the base's step (CB / CE / S–V) | Condition 5 used for (FS-110) | with unit arcs: the lemma | where it lives |
|---|---|---|---|
| (P) sweep | — | holds as is | this job |
| (P′) for same-multicolour pairs | `ω(p′)` meets `Γ` finitely | FS112-N3-PAIRS (N3-P′) | wave 4: `pair_P'` |
| D2's strip `γ(u)` (S–V Prop. 10) | no arc from `u` on a unit circle | FS112-N3-FAIL (≤ 3 leaving centres) | wave 4: `fail_leavingCentre`, `fail_colours` |
| pseudo-colouring: `c′ ≠ ∅`, `|c′| ≤ 2`, finitely many two-colour points | the strip; Cor. 3; Condition 5 | N3's sub-lemmas (both-kind against NOBOTH; COR3; the inert pre-bend) | this job (FS-112's N3-3, not backlog rows), over wave 4's `noBoth` and wave 5's `cor3` |
| (i) | a transversal circle meets a tile | N3-I | wave 4: `pair_i` |
| (ii), Lemma 3's swaps and endpoints, CE7, **S–V Lemma 5**, **Prop. 18** | (ii) | N3-II | wave 4: `pair_ii`; Lemma 5 and Prop. 18 themselves: **this job** (two minds, both blind, BASE-V with CB/CD) |
| **Lemma 3** at cusps (BV-L3), NoDouble (BV-ND, BV-ND1) | — | FS114-BV-HEX's clauses | wave 5 (to be stated by its successor planner) |
| Cor. 3 (disjoint pigeonhole pairs) | `γ(u)`, `γ(u′)` | FS112-N3-COR3 | wave 5: `cor3` |
| CE5 (distance 2) | the strip's majority | FS112-N3-ANTI | wave 4: `anti` |
| Prop. 17 (the ring lemmas N2-ROT, N2-HEX) | the arc at `x₁` not on `ω(x₂)` | FS112-ROTHEX | wave 5 (to be stated) |
| **Lemma 6's `< 9` branch** | — | FS114-BV-HEX (BV-HEX, under H, unit arcs) | wave 5 (to be stated) |
| D5's reduction (R1–R4), the 10 + 1 count, hole-filling; **Lemma 4 at cusps** (CUSP-BASE D5 items 1–4, 6) | (P′), (i), generic centres | as above; centres moved off the finitely many unit-arc centres | **this job**; Lemma 4 at cusps is at **one mind** (CE) — BASE-V's blind derivation hit a GAP at Prop. 19(b) and the selection (FS114-BV-HEX's not-claimed line): the likeliest place for a defect to surface |
| D4's bicycle | `Ω₁`, `Ω₂` meet arcs finitely | as lines (ii), pseudo-colouring | this job |
| the eleventh point | `R` inside `γ(u)` | `R ⊂ B(u, 1)` by N-E1 | this job |
| L60-D5 (FS114-L60-WALK, merged into L60-LE): "the two ends of a circle-to-circle path (CB D5 item 1) are less than 1 apart" | — | at `ℓ ≤ 60°` | this job, over wave 4's `l60_le` |

## The records to read (in this order)

`plans/FS110-CB-verification.md` (the route, D1–D6 by line), `plans/FS110-CE-verification.md` (R1–R4, the Antipodal Lemma, E6), `plans/FS110-CD-verification.md`
(Theorem D2, `d = 2`), `plans/FS110-CC-verification.md` and FS110-CUSP-BASE in `plans/FS110-derivation.md`, `plans/BASE-V-verification.md` (Lemma 5,
Prop. 18, BV-*), `plans/FS112-N-proof.md` stages N3-3 and N3-4 (the walk and its sub-lemmas), `plans/FS112-NB3-verification.md` (the blind walk);
`[SokolovVoronov2025]` (grep `BIBLIOGRAPHY.md` for its arXiv id; its copy in `~/source/library/`) Lemmas 3–6, Props. 10, 17–19, Cor. 1.

## Estimate

About 40–60 leaves: the pseudo-colouring and its finiteness (5–8), D4's bicycle (6–10), D5's six items with CE's repair (10–15), Lemma 5 and Prop. 18
(6–10), the count and the eleventh point (5–8), the assembly (3–5) — two to three implementer sessions after one planning job, re-priced from its
first two leaves. Its dependencies: waves 4 and 5 statements as committed (it can plan on them before they land; it lands after them).

## Risks a fresh planner should check first

1. **The pre-bend at an arc ending at `u`.** `bend_toward` bends a whole arc, end vertices included; an inert arc of `ω(P)` with `P ∈ ω(u)` ending at
   `u` would move `u`. If the base needs `u` fixed, `NoInertNear` should exclude only inert arcs not ending at `u` (a definition change, for Keryx to
   rule, before wave 5 lands).
2. **The interface is generous, not restrictive**: `Row134BaseUA` takes `F.Valid`, so any further map fact the base reads can be proved, not assumed.
3. **Lemma 4 at cusps at one mind**: if a step fails, the finding is a statement defect of row 134's base (and of rows 135, 137 above it).
