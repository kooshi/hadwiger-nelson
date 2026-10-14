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

## Stage 2 — SAVED: the statements typed (four new modules), the domain and obligation passes, read aloud

### 2.1 The cut (mine to decide)

| module | what | imports (project) | consumers |
|---|---|---|---|
| `Rigidity/Annihilator` | `dualAnnihilator N` (`N^⊥ ⊆ Ĝ`), `dualCoannihilator Y` (`Y^⊥ ⊆ G`), their Galois connection, closedness, the closure lemma; `finite_dualAnnihilator` (`N^⊥` finite when `G ⧸ N` is) | `Rigidity/DualGroup` | SubgroupHaar, Duality, Pieces leaf 9 |
| `Rigidity/SubgroupHaar` | `subgroupHaar Y` for a compact `Y ⊆ Ĝ`: probability, lives on `Y`, charges open sets meeting `Y`, Fourier coefficients the indicator of `Y^⊥` | `Rigidity/Annihilator` | Duality |
| `Rigidity/Duality` | **D2** (closed form, closure form, the case, the case on `Additive (AddChar G Circle)`), **D1** (`evalDualHom_surjective` from D2 at `G × ℤ`; `dualDualEquiv`; `additiveDualDualEquiv`) | `Rigidity/SubgroupHaar` | Pieces leaves 8, 9 |
| `Rigidity/DualConnected` | **D3**: extension of characters along injections, divisibility of the dual of a torsion-free group, connectedness; the negative partner at `ZMod 2` | `Rigidity/DualGroup` | Pieces leaf 8 |

`Rigidity/Pieces` imports `Rigidity/Duality` and `Rigidity/DualConnected` (the re-pointing), and the docstrings of
`isSolenoid_pieceDual` and `isTotallyIrreducible_pieceAction` name the theorems they read. **No statement of `Pieces` changed,
from the kernel's side**: every one of its 74 stored constants (type, and value for definitions) is identical before and after
the import (`data/fs131/kpd1/dump/PiecesDump.lean`; `data/fs131/kpd1/dump/pieces-{before,after}.txt`;
`tools/fs131_kpd1_dumpdiff.py` → `SAME: 74 constants`; its control `--plant` reports `DIFF … IsPiece.mk changed`, exit 1).

### 2.2 The domain pass (`debruijn-domain-modeling`, a fresh invocation, scoped to every new definition)

- **The annihilators are one Galois connection**, not two definitions: the one primitive is the pairing `⟨χ, g⟩ = χ g`, and
  `Y ≤ N^⊥ ↔ N ≤ Y^⊥` (both: `Y` and `N` kill each other) is `gc_dualAnnihilator`, written through `OrderDual`; every closure
  identity is Mathlib's `GaloisConnection` API. Named after Mathlib's `Submodule.dualAnnihilator`/`dualCoannihilator`, so a reader
  who knows the module version finds these. The intrinsic statement of D2 is then that **the closure operator of this
  connection on `Ĝ`'s side is the topological closure** (`dualAnnihilator_dualCoannihilator`, every `Y`); the closed form is the
  fixed-point form of it. Weighed: a general pairing type (no second use asked for); the algebraic half `(N^⊥)^⊥ = N` for every
  `N ⊆ G` (separation at `G ⧸ N`, ten lines; HX-1 would read it, no typed statement does) — **not typed**, named in § 4 as an
  optional extension.
- **Compactness is an instance binder on a `Subgroup`**: `subgroupHaar (Y : Subgroup (AddChar G Circle)) [CompactSpace Y]`. Mathlib's
  `ClosedSubgroup` is the image of "closed subgroup", but at the pin `IsTopologicalGroup ↥Y` is not synthesized for it (stage 1
  probe), and a definition taking `IsClosed` as an explicit proof argument would make every lemma about it unappliable by
  unification (`LEAN.md`, FS124-I4's line). Consumers with a closed `Y` supply `isCompact_iff_compactSpace.mp hY.isCompact`.
- **The Fourier coefficients as two lemmas, not an `if`**: `integral_subgroupHaar_of_mem` / `_of_not_mem` — the `if` form needs a
  `Decidable` instance in a statement, and the one consumer (`integral_subgroupHaar_eq`) cases on membership anyway.
- **The duality iso in Mathlib's costume**: `dualDualEquiv G : Multiplicative G ≃* PontryaginDual (AddChar G Circle)` (Mathlib's
  `PontryaginDual` is multiplicative; `G` is additive). The consumer form on `Multiplicative (Additive (AddChar G Circle))`
  (what `IsSolenoid`'s `dual_embeds` reads at `X = PieceDual M`) is **the same term**, `additiveDualDualEquiv G := dualDualEquiv G`,
  accepted by the elaborator as a definitional transport; its `apply` lemma is `rfl`.
- **Torsion-freeness is Mathlib's class** `[IsAddTorsionFree G]` (at the pin: `nsmul_right_injective`). Divisibility of `Ĝ` is a
  theorem (`exists_pow_eq`), not a `RootableBy` instance: its one consumer is D3's proof.
- **Unsampled members.** `G = 0`: `Ĝ` one point, every statement trivial and true. `Y = ⊥` (closed, a point): `Y^⊥ = G`,
  `subgroupHaar ⊥ = dirac 1` (`subgroupHaar_bot`, the spec). Uncountable `G`: D1, D2 true, the proofs (Polish) not; excluded by
  `[Countable G]` exactly where Fourier uniqueness is read. **Adversarial members**, each the reason for a hypothesis: a dense
  proper subgroup of `Ĝ` (the torsion characters of `ℤ`) has `Y^⊥ = 0` and `Y ≠ ⊤` — D2 needs `IsClosed`; `ZMod 2` — D3 needs
  torsion-freeness (`not_connectedSpace_dual_zmod_two`, typed); `N = ⊥ ⊆ ℤ` — `finite_dualAnnihilator` needs `G ⧸ N` finite.

### 2.3 The obligation pass (`debruijn-obligation-modeling`, a fresh invocation, scoped to every new statement)

Every statement checked true as typed; its decomposition is its plan (§ 4). No statement was false as first typed. Two
corrections the compiler made while typing, both of form not truth: `[Countable G]` moved off the section into the binders that
read Polishness (the linter found it unused on `extendByPow_apply`), and `T2Space Circle` is not synthesized in
`Rigidity/Annihilator`'s environment (it is in `Rigidity/Duality`'s, as `t2Space_of_metrizableSpace`), so closedness of
`{χ | χ g = 1}` is read through `ℂ` by a helper the route copy adds (`isClosed_setOf_apply_eq_one`; § 3). **Mutation audit** (each
hypothesis deleted once): `IsClosed` in D2 — false (the dense torsion subgroup); `[IsAddTorsionFree G]` in D3 — false (`ZMod 2`);
`[Finite (G ⧸ N)]` — false (`N = ⊥` in `ℤ`: `N^⊥ ≅ Circle`); `(U ∩ Y).Nonempty` in `subgroupHaar_pos` — false (`U` disjoint from
`Y` is null); continuity of `ψ` in D1 — built into `PontryaginDual` (a discontinuous character of `Ĝ` is no evaluation).
`[Countable G]` is read by the proofs only. **No vacuity**: every binder is inhabited at `G = ℤ` (a group, `Y = ⊤` closed with
`Y^⊥ = ⊥` — the case's hypotheses, `Duality`'s model example; `ψ = 1`; `IsAddTorsionFree ℤ`, Mathlib's instance).

### 2.4 Read aloud against the use and against a textbook

| statement | the use (stage 1 § 1.2) | textbook |
|---|---|---|
| `eq_top_of_isClosed_of_dualCoannihilator_eq_bot'` | U2, branch `N = 0`: "`Y^⊥ = 0` ⟹ `Y = ⊤`" on `AddSubgroup (PieceDual M)` — applied there by `exact` (probe 2) | the duality theorem for closed subgroups, `H = (H^⊥)^⊥` |
| `dualAnnihilator_dualCoannihilator_of_isClosed` | X02D HX-1 step 1, l. 109: "closed subgroups `Y ⊆ R̂` correspond to subgroups `N = Y^⊥ ⊆ R`, with `Y = N^⊥`" | same |
| `le_dualAnnihilator_dualCoannihilator`, `finite_dualAnnihilator` | U2, branch `N ≠ 0`: `Y ⊆ N^⊥`, finite | (not duality) |
| `evalDualHom_surjective`, `additiveDualDualEquiv` | U1, `dual_embeds`: an injective `PontryaginDual (Multiplicative (PieceDual M)) →* Multiplicative M` — given by `(additiveDualDualEquiv M).symm.toMonoidHom` (probe 2) | Pontryagin's duality theorem, `G → (Ĝ)^` an isomorphism, at discrete `G` |
| `connectedSpace_dual` | U1, `connectedSpace` at `PieceDual M` (probe 2, by `exact`) | "the dual of a discrete group is connected iff the group is torsion-free" |

**Which textbook, and how much read: none read.** No copy of any harmonic-analysis text is in `~/source/library/` (searched for
Rudin, Folland, Hewitt–Ross, Morris, Deitmar). The statements are recalled from W. Rudin, *Fourier Analysis on Groups* (1962;
`[Rudin1962]`, already a bibliography row, "not held, not read"): § 1.7 (the duality theorem) and § 2.1 (annihilators) — section
numbers recalled, not checked. This matters less than it would for an import: every statement here is to be **proved** in the
kernel, so the source's role is only that the statements are the standard ones, and the mutation audit above shows each
hypothesis load-bearing.

### 2.5 Models

`Annihilator`: the spec example `dualAnnihilator (⊤ : AddSubgroup ℤ) = ⊥` (proved). `SubgroupHaar`: `subgroupHaar_bot` (the spec,
a leaf). `Duality`: the case's hypotheses inhabited at `ℤ` (`⟨⊤, isClosed_univ, dualCoannihilator_top⟩`); `evalDualHom ℤ 0 = 1`.
`DualConnected`: `ConnectedSpace (AddChar ℤ Circle)` (an example over `connectedSpace_dual`) and the negative partner
`not_connectedSpace_dual_zmod_two` (a leaf). Every statement elaborates in the farm (`data/fs131/kpd1/logs/{annihilator,
SubgroupHaar,Duality,DualConnected,pieces}.log`, each exit 0 with `sorry` warnings only; options as the lakefile's:
`autoImplicit` off, `linter.missingDocs` on).
