# FS131-KPD1 — Pontryagin duality for a countable discrete abelian group: what the chain reads, typed to its leaves, its route measured, priced

*The kernel lane's planner (de Bruijn), the fifth planner on the chain under "five colours at the square root of 47" and the first on
this one classical input. Brief: `data/fs131/briefs/FS131-KPD1-pontryagin.md`. Branch `fs131-wpd`, cut from `fs131-wk8` at
`b531d058e`, in the worktree `.claude/worktrees/fs131-wq1`. Working files: `data/fs131/kpd1/`.*

## Theorems this phase proved

None yet (a planning job; any route-test leaves proved are listed here as they land).

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

Checked by script (exact substring after stripping the `> ` prefix) against the sources the brief names:

| quotation in the brief | source | result |
|---|---|---|
| W2 (Kooshi, 2026-10-13) | `data/fs131/REQUEST-2026-10-13.md` l. 4 | identical |
| the dated line "A classical input the leaf list does not name …" | `data/fs131/claims-NF2.md` on `main`, l. 57 | identical |
| inventory item 761, whole | `plans/FS131-close-inventory.md` on `main`, l. 9198 | identical |

**A finding about the brief, small and not load-bearing.** Item 761's nested quotations of the last planner ("Its words: …") match
neither its report on disk (`data/fs131/reports/FS131-KN8.md`) nor its record verbatim, whitespace and backticks normalised: e.g. the
item has "Item 5 is done in words" where the report has "item 5 is done in words", and "M4: "the dual … For countable G it is Polish"
where the report has "for countable G Polish". They are presumably quoted from the hand-back text, which is not on disk. Two nested
quotations do match: "PE-1′'s total irreducibility needs it at `N = Y^⊥ = 0`" (the KN8 record § 2.3, l. 171–172) and "when unsure,
formalize" (`.claude/agents/debruijn.md`). Nothing in this job rests on the others.

### 1.2 Every use of D1 and D2 on the chain, by file and declaration, with what the site needs

The chain's typed statements that read duality are two leaves of `Rigidity/Pieces` (the KN8 record § 2.5, leaves 8 and 9, as the
file holds them on `fs131-wk8`):

**(U1) `Rigidity.isSolenoid_pieceDual`** (`Pieces.lean` l. 161): `[NumberField F] (hM : IsPiece p M) : IsSolenoid (PieceDual M)`.
Of `IsSolenoid`'s five fields (`Rigidity/Solenoid.lean` l. 48–58) two read duality:
- `dual_embeds : ∃ (n : ℕ) (f : PontryaginDual (Multiplicative X) →* Multiplicative (Fin n → ℚ)), Function.Injective f` at
  `X = PieceDual M = Additive (AddChar M Circle)`. **Needs D1 at `G = M`** (every continuous character of `M̂` is the evaluation at a
  point of `M`) **and separation** (`Rigidity.exists_apply_ne_one`, typed in `Rigidity/DualGroup`: the point is unique, so `ψ ↦ x` is
  a homomorphism, injective because `ψ = ev_x`). Then `M ⊆ fieldI F ≅ ℚⁿ` is not duality. The general D1 is what the site reads; no
  case of it is smaller.
- `connectedSpace : ConnectedSpace X`. The last planner's route (§ 2.5 leaf 8) reads D1 **and two more classical facts it does not
  name**: "the identity component's quotient is profinite, and a non-trivial one has a continuous character of finite order". That is
  structure theory of compact groups (a quotient by the identity component is totally disconnected; a profinite abelian group has a
  continuous character of finite order). **What the site needs** is the classical "a torsion-free `G` has a connected dual". I name it
  **D3** and type it here (stage 2): it is the dual of torsion-freeness, the third duality fact the chain reads.
- The other three fields (topological group, Hausdorff, compact) are `Rigidity/DualGroup`'s, not duality.

**(U2) `Rigidity.isTotallyIrreducible_pieceAction`** (`Pieces.lean` l. 167): `[NumberField F] (hM : IsPiece p M) :
(pieceAction hM).IsTotallyIrreducible`, i.e. for finite-index `Λ` and closed `α_Λ`-invariant `Y : AddSubgroup (PieceDual M)`,
`(Y : Set _).Finite ∨ Y = ⊤`. With `N := Y^⊥ ⊆ M`:
- `N = 0` ⟹ `Y = ⊤`: **D2 at the zero annihilator** (ruling 2's case: "a closed subgroup `Y` of `Ĝ` with `Y^⊥ = 0` is all of `Ĝ`").
- `N ≠ 0` ⟹ `Y` finite: the site reads `Y ⊆ N^⊥` — **no duality** (every `y ∈ Y` kills `Y^⊥` by definition) — and **`N^⊥` is finite
  when `M/N` is finite** (a character of `M` trivial on `N` is a character of the finite `M/N`) — **no duality either**, a finite
  count. The last planner's words "`Y ≅ (M/N)^` is finite" read the general D2 (`Y = N^⊥`); the site needs only the inclusion.
- So the general D2 is **not** what this site reads. The case is.

**(U3) Not typed, in words only.** EF_F⁺'s model (NF2-LEAF-21; KN8 § Stage 4, M8b) reads Tate's self-duality of the adeles; X02D's
HX-1 step 1 (`plans/FS100-X02D-derivation.md` l. 109) reads the general correspondence `Y ↔ Y^⊥` — HX-1 is not on NF2-LEAF-20's
list and has no typed statement. Neither is a typed use; § 3 says in words what of this route they would read.

**Not uses.** `not_isVirtuallyCyclic_pieceAction` and `integral_eq_zero_of_isAddHaarMeasure` read separation only
(`exists_apply_ne_one`); `Rigidity/DualGroup`'s Fourier uniqueness (`measure_eq_of_fourier`, X02D's T4) and Haar (`dualHaar`,
`isHaarFourier_iff`) are planned there and are not D1 or D2. `haar_or_zero_entropy` (M5) will need "totally irreducible and not
virtually cyclic ⟹ no virtually cyclic factors" from the declared Theorem 1.3's hypothesis: that reads the connectedness field of
`IsSolenoid` (a continuous map from the connected `X` into a finite `Y` is constant), not duality.

### 1.3 The statements the chain reads, restated

For a countable discrete abelian group `G` with `Ĝ = AddChar G Circle` under `Rigidity/DualGroup`'s scoped pointwise topology:
- **D1.** Every `ψ : PontryaginDual (AddChar G Circle)` is `χ ↦ χ g` for some `g : G` (unique by separation).
- **D2, the case read.** A closed `Y : Subgroup (AddChar G Circle)` with `∀ g, (∀ χ ∈ Y, χ g = 1) → g = 0` is `⊤`.
- **D3.** If `G` is torsion-free, `AddChar G Circle` is connected.
- **Not duality, read beside them:** if `G ⧸ N` is finite, `{χ | ∀ g ∈ N, χ g = 1}` is finite.

### 1.4 What Mathlib holds at the pin (names checked: `data/fs131/kpd1/probes/Names.lean`, log `data/fs131/kpd1/logs/names.log`, exit 0)

`Topology/Algebra/PontryaginDual.lean` is Mathlib's whole duality (the definition, `map`, finiteness for compact discrete `A`); no
duality theorem, no Peter–Weyl (KN7 § Stage 4 said the same). What the route below needs, each `#check`ed: `ext_of_forall_mem_
subalgebra_integral_eq_of_polish`, `Measure.haarMeasure`, `integral_mul_left_eq_self`, `IsOpenPosMeasure.open_pos`,
`IsTopologicalGroup.exist_openSubgroup_sub_clopen_nhds_of_one`, `Subgroup.quotient_finite_of_isOpen'`, `Module.Baer.of_divisible`,
`Module.Baer.extension_property_addMonoidHom`, `CharacterModule.dual_surjective_of_injective`, `AddCircle.injective_toCircle`,
`AddCircle.homeomorphCircle`, `connectedSpace_iff_clopen`, `AddChar.instFintype` (finite `G`), `AddSubgroup.toSubgroup'`,
`Subtype.borelSpace`. **Instances, measured:** on `↥Y` for `Y : Subgroup (AddChar G Circle)` with `[CompactSpace Y]` — topological
group, Hausdorff, Borel (countable `G`), locally compact; `haarMeasure ⊤` on `↥Y` elaborates, is a probability, Haar, open-positive,
left invariant, and `integral_mul_left_eq_self` applies. **Mathlib's `ClosedSubgroup` is not usable here as is**: `IsTopologicalGroup
↥Y` is not synthesized for `Y : ClosedSubgroup _` (the subgroup instance is keyed on `Subgroup`'s membership); hence the design
`Subgroup` + `[CompactSpace Y]` (stage 2). **The consumer's types fit by `exact`:** `IsClosed (Y : Set (PieceDual M))` is accepted as
`IsClosed ((AddSubgroup.toSubgroup' Y) : Set (AddChar M Circle))`; `PontryaginDual (Multiplicative (PieceDual M))` is `rfl` to
`PontryaginDual (Multiplicative (Additive (AddChar M Circle)))`; `ConnectedSpace (AddChar M Circle) → ConnectedSpace (PieceDual M)`
is `fun h => h`.
