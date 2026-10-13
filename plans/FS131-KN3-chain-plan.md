# FS131-KN3 — the chain under "the plane over the field of √47 needs five colours": its hypotheses as closed statements about a field, its first layer typed, and the rest cut into modules

*de Bruijn, the planner. Brief: `data/fs131/briefs/FS131-KN3-chain-plan.md`. Branch `fs131-wch`, worktree
`.claude/worktrees/fs131-wch`. Claims: `data/fs131/claims-NF2.md`. Stands on `plans/FS131-KN1-number-field-kernel-map.md`
(the map) and `plans/FS131-EN1-derivation.md` (the deriver's reading, § 8.1 its table).*

## Theorems this phase proved

Filled at each stage; the last stage's list is the record.

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_kn3_readback.py` compares, character for character, (a) every `> NF2-…:` line of the brief with the line of
that id in `data/fs131/claims-NF2.md`, and (b) every `NF2-LEAF-nn` of the claim list with item `nn` of the map's "The
chain's leaves, in dependency order", the paragraph joined into one line.

- (a) 16 quotations, **identical**. (b) 23 leaves against 23 map items, **identical**; no map item without a claim.
- Control (`--plant`): one character changed in `NF2-MRPLUS` and one in map item 13, in memory; both reported.

No mismatch; nothing for the coordinator from the readback of text.

### 1.2 The kernel theorems of the chain, read in the source

Read in full: `Proofs/HadwigerNelson/SpectralChain.lean` (649 lines). Read at the definitions the chain names:
`Arith/CharacterColouring.lean` (`torsionBy`, `archimedean`), `Arith/SpectralInputs.lean` (`IsHaarFourier`, `contChars`,
`BochnerOn`).

**The objects.** `unitVectors F : Set ℂ`; `unitRing F : Subring ℂ` (`R = ℤ[U]`); `Dual F := AddChar (unitRing F) Circle`
with the cylinder σ-algebra `dualMeasurableSpace` (the comap of the product σ-algebra under `χ ↦ (g ↦ (χ g : ℂ))`) and
**no topology**; `rot u χ := χ.compAddMonoidHom (mulLeft (uvRing u))`; `RotInv F τ := ∀ u, τ.map (rot u) = τ`.
`Measure` in Lean is a positive measure: the deriver's "finite positive measure" is `IsFiniteMeasure τ` and nothing more,
so the signed reading that fails cannot be typed by accident.

**The interface** (`Interface F`, ll. 130–144): `E TA : Set (Dual F)`, both measurable, `TA ⊆ E`, `rot u ⁻¹' E = E`, and
`h : Measure (Dual F) → unitVectors F → ENNReal`. All free data. Its `Prop`s:

| `Prop` (line) | reads of the interface | closed at `E := TA := T + A`, `h :=` entropy? |
|---|---|---|
| `Interface.RU` (161) | `E \ TA` | yes, and then it says `τ ∅ = 0`: true, one line |
| `Interface.APlus0` (169) | `TAᶜ` | yes: a sentence about `F` |
| `Interface.PE2` (177) | `E` (the Haar part is `E`-null), `h` | yes — but its third conjunct `τH I.E = 0` then asks `m(T + A) = 0`, which no proof on the path uses (§ 1.3) |
| `Interface.EFPlus` (186) | `h`, `TAᶜ` | yes |
| `Interface.MR` (192) | `E` | yes: it is then MR⁺(F) word for word |
| `Interface.R88TCA` (315) | `TAᶜ` | yes |
| `Interface.APlusOfR88` (320) | through the two above | yes |
| `Interface.Count` (326) | through `R88TCA`; `TCA F` is closed already | yes |

**The headline** `min_localBound_five_le_chromaticNumber [NumberField F]` (l. 595) takes: `hBH : BochnerHerglotz (unitRing F)`
and `hL1 : InvariantMeasureOnClosed F` — closed already, classical, to be formalized (ruling 4); `I : Interface F` — free;
`hTR`, `hCX : … → I.Count`; `hAP : I.APlusOfR88`; `hRU : I.RU`; `hMR : TCA F → I.PE2 ∧ I.EFPlus`; `hCLS : 5 ≤ localBound F →
TCA F` and `hRow99` — closed already. So **what it takes to close every hypothesis is two terms and no more: a set
`TA F : Set (Dual F)` with its measurability and rotation-stability, and an entropy `Measure (Dual F) → unitVectors F →
ENNReal`.** Everything else in the first layer is what the two deductions' *proofs* need to be statable (the pieces, Haar
with a topology, the printed theorem).

**The proved links, and what each reads** (checked in the source, not from the map):
- `Interface.mr_of_pe2_efPlus` (196): binds `hHE` at l. 198 and never uses it; uses `E` only through `TA_subset_E` (l. 204).
- `Interface.x4_eq_empty` (519): uses `measurableSet_E`, `measurableSet_TA`, `rot_preimage_E`, `TA_subset_E`, `hRU` (l. 544),
  `hA`, `hMR` at `τ := σ.restrict Eᶜ`.
- `Interface.five_le_chromaticNumber` (568), the headline (595), `…_of_totallyReal` (616), `chromaticNumber_eq_localBound` (626).

### 1.3 What the readback fixes for the architecture

1. **The interface is kept, with one concrete instance beside it** — not replaced. `Interface.x4_eq_empty` and the headline
   are through the gate and are exactly the compositions wanted; at the instance `E := TA := T + A` their hypotheses are
   closed. No gated statement changes.
2. **The entropy split is restated beside `Interface.PE2`, not discharged through it** (the deriver's first question).
   `Interface.PE2` at `E := T + A` carries the conjunct `τH (T + A) = 0`, i.e. `m(T + A) = 0` — J45-N1 (c) at `S = ∅`, which
   the deriver's walk puts off the path and which no proof on the path reads. Proving it to feed a clause nobody reads
   would put an off-path hand result back on the path. So the first layer states PE-2 in the page's own form — `τ = a • m
   + τ′` with `m` Haar and `h_{τ′}(u) = 0` — and proves MR⁺ from it and EF_F⁺ by the deriver's five lines (EN1-FROM-TWO),
   a new theorem beside `Interface.mr_of_pe2_efPlus`. The headline is then fed `I.MR` directly, through a variant of
   `five_le_chromaticNumber` that takes `hMR` (it is `x4_eq_empty` and three lines). What a landing would retire: nothing
   is retired; `Interface.PE2` stays as the abstract form and stops being a hypothesis of any closed statement.
3. **MR⁺'s scope hypothesis.** The deriver's line: MR⁺ holds for `R_F = O′`. The headline takes `hMR` under `TCA F`, and
   `TCA F` excludes a ramified stable dyadic place (ratio `1/2` there; the headline's docstring l. 592). So the scope is a
   hypothesis of EF_F⁺'s closed statement, and the module that proves "`TCA F` ⟹ no ramified stable dyadic place" is one
   of the leaves (the deriver's row 14; § the architecture).
