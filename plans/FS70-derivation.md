# FS-70 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Written 2026-09-22 by the product owner, mid-milestone (phase 1e running), under the rule minted the same day (WORKFLOW 2.0
steps 7 and 9): a milestone's hand theorems, derived theorems and tools-grade theorems are numbered here — statement, grade,
where the proof lives, what rests on it, and its kernel status — and `LEDGER.md` § B indexes them one line each. Grades are
`CLAUDE.md` § Notation's. A theorem's proof is not repeated here when a record holds it; this file is the index that survives
the ledger row's compression. T10 and T11 were filled from phase 1e's "Theorems this phase proved" heading.*

## The theorems

**T1 — The triangle lemma. [hand; the phase-0 implementer, from the planner's additive screen]** For an additive ℤ/4-colouring
`φ` of a 2-unit lattice holding a unit triangle (`ζ₆ ∈ Λ`): `φ(i√3) = 0 ⟺ φ(2) = 0 ⟺ φ(1) = 2`. *Proof:* `φ(1) ≠ 0` (1 is a unit vector), so `φ(2) = 2φ(1) = 0 ⟺ φ(1) = 2`; and `ζ₆ + ζ̄₆ = 1`, `ζ₆ − ζ̄₆ = i√3` give
`φ(i√3) = φ(1) − 2φ(ζ̄₆)`, with `φ(ζ₆), φ(ζ̄₆) ∈ {1, 3}` when `φ(1) = 2` (both nonzero, summing to 2), so `φ(i√3) = 0`; conversely
`φ(i√3) = 0` forces `φ(1) = 2φ(ζ̄₆) ∈ {0, 2}`, hence 2 (`data/fs70/records/phase-0.md` §4(i)). *Rests on it:* the additive screen's list of
chainable targets (`4/3`, `8/3`, and `4/7` with the 7-family) and the death of Haugland's `i√3` virtual edge on 2-unit fabric.
*Kernel:* not worth it — an instance of `addMonoidHom` arithmetic (row 50's framework).

**T2 — The additive Kempe screen. [hand; the phase-1 implementer; re-derived by the owner]** Let `φ : Λ → G`, `|G| = 4`, be a
proper additive colouring of the unit-distance graph on `Λ` (unit-vector set `U`), `φ(0) = 0`, `b ≠ 0`, and let
`R_b = ⟨ z + w : z, w ∈ U, φ(z) = b, φ(w) = −b ⟩`. The `(0, b)`-Kempe component of the origin has colour-0 part exactly `R_b`; the
swap `0 ↔ b` on it is a proper colouring of every finite subgraph; hence if `δ ∉ R_b` for some `b` (with `φ(δ) = 0`), **no finite
graph on `Λ` forces `(0, δ)` at four colours, at any radius**. *Proof:* `data/fs70/records/phase-1.md` §4.1;
`data/fs70/owner/review-phase1-2026-09-22.md` §1 (the alternation argument, closure under negation). *Control:* de Grey's
lattice over K reads rigid at `8/3` (`po_kempe_control_K.py`), as Harder's forced pair requires. *Rests on it:* the death of
Harder's transposed lattice `S₂`, the 7-family, L4b, d6 (phase 1); the rigidity join with T7 (phase 1d §6). *Kernel:* **worth a
stub** — Kempe swaps on a Cayley graph of an abelian group, and `¬ Forces` from an escaping component: a small theorem beside
`FanGap.lean`, and the Kempe theory `CLAUDE.md` FS-2 wants. Generalised by T10.

**T3 — The 3-adic gate. [derived from kernel rows 72 and 45; the planner, phase 0]** A lattice all of whose unit vectors are
3-integral maps homomorphically into `UD(𝔽₉, 2)` (`χ = 3`, `tools/fs70_fq_plane.py`), so every graph on it is 3-colourable and
carries no four-colour pair compulsion (the spare-colour lemma). *Rests on it:* the death of every lattice without `u`; the
uniqueness in T5. *Kernel:* the components are kernel (`ThreeAdicBarrier.lean` is the ℚ(√d) form; the ℚ(√3,√5) reduction into
`𝔽₉²` is not written) — **stub-worthy at the kernel level of row 72's generalisation**, not separately.

**T4 — Commensurate ⟹ 2-unit in `E₀ = ℚ(√−3,√−5)`. [hand + PARI; the phase-1c implementer; re-derived by the owner]** `E₀` has one
prime above 2 (`e = f = 2`), inert over its real subfield ℚ(√15) and therefore fixed by complex conjugation; for `ψ ∈ E₀` with
`ψψ̄ = 1`, `2v(ψ) = 0`. So every unit vector of `E₀` is a 2-unit, every rotation commensurate with a base in `E₀` gives a
2-integral arena, and the residue map to `𝔽₄` four-colours it at every radius (Theorem A). *Proof:* `data/fs70/records/phase-1c.md`
§3; `review-phase1c-2026-09-22.md` §1. *Rests on it:* 3,290 of 3,499 rotation classes dead without a solver. *Kernel:* declined
(needs the arithmetic of `E₀` in Lean; the statement is a one-line consequence of `normOne_subset_valuationSubring` once the
prime's fixedness is available — FS-47's territory).

**T5 — The six quartic CM subfields of `F(i)` at 2 and at 3. [hand + exact enumeration; the owner]** T4's argument run at 2 and at
3 over the six quartic CM subfields: a prime of `E⁺` fixed by conjugation in `E` makes every unit vector a `p`-unit; a split pair
allows poles. **`ℚ(√3,√−5)` is the unique subfield where both primes split** (`−15 ≡ 1 (mod 8)`, `−5 ≡ 1 (mod 3)`); `ℚ(√5,√−3)` and
`ℚ(√15,i)` break the wall but are 3-integral; `ℚ(√3,i)`, `ℚ(√5,i)`, `E₀` are 2-integral. Table and counts:
`data/fs70/owner/cm-subfields-2026-09-22.md`, `po_cm_subfield.py`. *Rests on it:* the lattice Λ′ (rank 4, `½, ⅓ ∈ Λ′`, every
rotation commensurate), which T6 then closed. *Kernel:* declined.

**T6 — The fan-gap closure. [derived from kernel rows 56 and 66; the phase-1d implementer; verified by the owner on Λ′ and L6]** Let
`Λ` be a lattice whose complete unit-vector set is `U` (complete: every unit vector of `Λ` has denominator dividing the lattice's
`M`), and `N` with `U ∩ NΛ = ∅`. A proper four-colouring of `Cay(Λ/NΛ, U mod N)` four-colours every unit-distance graph on `Λ`
(`unitQuadrance_colorable_of_quotient`); if it has a **fan gap** at some vertex (a colour absent from the closed neighbourhood),
then `slack_addCayley_of_fanGap` and `Slack.forces_iff_of_hom` give **`Forces G 4 u v ↔ u = v` for every unit-distance graph `G`
on `Λ`**. *Proof:* `data/fs70/records/phase-1d.md` §5.1; the Lean statements read in `review-phase1d-2026-09-22.md` §1.
*Instances:* Λ′ (N = 5, 10, 15, 16), L6 (N = 5), L2 (N = 5), L1 (N = 5, 7), `zeta12+rho15` (N = 3) — each colouring committed under
`data/fs70/quotient/`, Λ′'s and L6's re-verified by `po_verify_quotient*.py`. *Control:* de Grey's K-lattice has no gapped
colouring at any `N ≤ 12` (`po_gap_finder_K.py`). *Kernel:* **the composition is a two-line theorem over the existing lemmas
and should be written** (a `Forces`-closure for `unitQuadrance` over a lattice quotient) — stub with T2.

**T7 — The split-prime tower, classified. [tools + derived; the phase-1d implementer]** `P_m = Cay((O/𝔭^m)², {(t, t⁻¹)})`, `O` the
completion of ℚ(√3,√5) at its prime above 2 (`e = f = 2`, split in `F(i)`), is Hoffman-tight at four colours at every level
1–6 (`λ_min = −d/3`); the minimising characters stabilise at 756 from level 4 and `H_min(m)` is the pullback of `H_min(4)`
(order 4); a real `δ` is forced iff `δ mod π⁴ ∈ {0, 2(1+√3)}`, so **`d₀ = 3`**. **The kill:** every additive four-colouring of `P₃`
is exhibited (1,728) and their kernels meet trivially, so **no finite 2-unit fabric over ℚ(√3,√5) forces a four-colour pair at
𝔭-depth ≤ 2** (`Forces.image`'s contrapositive) — `2` and `2/3` dead; `4/3`, `4`, `4/7`, `4/√3` (`v_𝔭 = 4`) and `8/3` (6) forced in
the local plane. SAT confirmation at level 4 (UNSAT at an `H_min` member in 6 s; SAT at the image of 2). *Proof and data:*
`data/fs70/records/phase-1d.md` §3, `data/fs70/tower/`. *Kernel:* the exhibited colourings are `decide`-grade; **the level-4
refusal's LRAT core is the phase-2 deliverable** (row 67's recipe), deferred.

**T8 — The rigidity join. [tools; the phase-1d implementer]** The rich 2-unit lattices (`twounits:14/30/42`, 212 / 660 / 1,220 unit
vectors) are Kempe-rigid (T2) at exactly `4/3, 8/3, 4, 4/7, 4/√3` under all 48 additive colourings and escape at exactly `2, 2/3`
— the partition T7 makes by depth, from an instrument sharing no code with it. Rigidity is sound for every graph in the lattice;
escape only for graphs built from the generators (their saturation is unaffordable). `data/fs70/kempe-rich.json`.

**T9 — Periodic colourings are residue colourings, prime by prime. [hand + checked; the owner; the dichotomy a reading with
P-M1 registered]** For a rank-4 lattice whose ℚ-span is a CM field `E` and an odd prime `p` prime to its denominators,
`Λ/pΛ ≅ O_E/pO_E`, and a period-`p` colouring is Theorem A's colouring on the target the unit vectors' reductions generate: a
prime of `E⁺` **split** in `E` supplies the residue plane `UD(𝔽_q, 2)`, **inert** the norm-one Cayley graph `Cay(𝔽_{q²}, μ_{q+1})`,
**ramified** a level-2 norm-one graph. **Checked:** de Grey's 54 unit vectors reduce mod 5 onto exactly the 24 elements of the
split torus of `𝔽₂₅` and mod 7 onto all 48 of `𝔽₄₉`'s, so its N = 5 and N = 7 quotients are the residue planes at 25 and 49,
five-chromatic by phase 0's computation — the arithmetic behind its rigidity and Harder's forced pair. Over ℚ(√3,√5) the
hexagonal fabric's `E₀` meets an inert prime at 5 and a totally split one at 7 with four-colourable, gapped targets.
`data/fs70/owner/mechanism-periodic-colourings-2026-09-22.md`. *Kernel:* the identification `Λ/pΛ ≅ O/p` is textbook; declined.
*Rests on it:* G69 (minted at the close if P-M1 survives phase 1e).

**T10 — The periodic Kempe screen. [hand; the phase-1e implementer; the L3 exhibitions re-derived by the owner]** Let `c` be a
proper four-colouring of `Cay(Λ/NΛ, U mod N)` (`U` the complete unit-vector set, `N` admissible), `C` its pull-back, `a = C(0)`,
`b ≠ a`. Let `Q` be the quotient's two-colour subgraph (classes coloured `a` or `b`; one edge per `(ȳ, s)`, `s ∈ U`, carrying
the voltage `s`), `Q₀` the component of `0̄`, `p(x̄)` the voltage of a spanning-tree walk `0̄ → x̄`, `V` the ℤ-span of the
fundamental-cycle voltages `p(ȳ) + s − p(ȳ + s̄)`. Then the `(a, b)`-Kempe component `K₀` of the origin **in the infinite lattice
graph** satisfies `K₀ ∩ (class x̄) = p(x̄) + V`, so **`δ ∈ K₀ ⟺ δ̄ ∈ Q₀ ∧ δ − p(δ̄) ∈ V`**. Corollaries: **(T10.1)** if `δ ∉ K₀` for
some `b`, the swap `a ↔ b` on `K₀` is a proper four-colouring of every graph on `Λ` separating `(0, δ)`, so `¬ Forces` at `δ` on
`Λ` at every radius; **(T10.2)** `V ⊆ NΛ`, and `[NΛ : V]` is the deciding invariant (81 on the rank-6 L3 at N = 2); **(T10.3)** the
`Q₀` conjunct is redundant where the `V` test passes (`δ ∈ V ⟹ δ̄ = 0̄`); **(T10.4)** `c(δ̄) ≠ c(0̄)` separates outright;
**(T10.5)** `c(δ̄) = c(0̄)` refutes `Separated` at `δ` on every graph on `Λ` — one periodic colouring kills one of the two
compulsions at every target; **(T10.6)** with `U` a generator set only, the escape is sound for graphs whose edges lie in `U`. T2 is
the additive case (`V = R_b`); phase 1d's fan gap (T6) is the case `Q₀ = {0̄}`. *Proof:* `data/fs70/records/phase-1e.md` §2.1
and its "Theorems this phase proved". *Controls:* de Grey's K-lattice reads rigid at `8/3` under all six periodic colourings and
escapes at `2` and `4` under five — discriminating; L1's gapped colouring escapes everywhere at the gap colour; the additive case
agrees with T2 at every target. *Kernel:* **stub with T2/T6** (FS-2): the voltage-lattice form is the theorem to write; the
exhibition on a finite ball is what the kernel would check.

**T11 — The rank-6 L3 carries no four-colour compulsion at arity 2. [derived, on committed colourings; exhibited]** For
`Λ = ⟨ζ₆^m u^n (|n| ≤ 2)⟩ + ζ₆·{w, w̄}` (42 unit vectors, wall-broken, 3-non-integral) and every chainable target
`δ ∈ {2, 2/3, 4/3, 8/3, 4, i√3}`: `¬ Forces` (T10.1 at N = 2 and 4) and `¬ Separated` (T10.5 at N = 2 and 6), hence
`arityFloor G 4 ≥ 3` for every unit-distance graph `G` on L3 — row 66's `three_le_arityFloor_heule510` one field over. The
`Forces` half is exhibited on a 109,957-point, 758,196-edge word ball (the implementer's `verify-escape`; the owner's
`po_verify_kempe_L3.py` on a ball, edges, components and swaps of its own — every target). **Note against T9:** L3's colourings
are gap-free at every N tried and it is loose anyway — at rank 6 the quotient colourings are not a field's residue colourings, and
the Kempe index, not the gap, decides. *Kernel:* the exhibition is `decide`-grade on a 110k-point graph — priced, not pursued.

## Conjectures surfaced, not claimed (the close's stub sweep)

- **C1** (phase 1c): commensurate ⟹ 2-unit holds for every CM base whose prime above 2 is not split over the real subfield and
  fails where it is split — T5 supplies the in-field instance (`ℚ(√3,√−5)`), which T6 then closed; the general question is a
  `nflist` sweep.
- **C2** (phase 1c, phase 1b): a twisted bilayer's cross-edge set over this field is fixed by the rotation and does not grow with
  the base (measured at two ranks and on ρ₁₅'s circle at four radii).
- **C3** (owner, T9): a lattice is rigid — carries a four-colour forced pair somewhere — iff its reductions cover the residue
  circles at every small odd prime and the tower at 2 is tight at the target's depth; the inheritance half is exactly what row 67
  leaves open.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| T2 + T6 | **stub**: Kempe swaps and gapped-quotient closure for `Forces` on lattice unit-distance graphs — small, over existing lemmas |
| T7 | **phase 2 / stub**: the level-4 LRAT core, row 67's recipe |
| T3 | with row 72's generalisation, not separately |
| T1, T4, T5, T8, T9 | declined (instances, enumerations, or number theory Lean does not yet hold) |
