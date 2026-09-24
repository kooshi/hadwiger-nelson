# FS-75 — the three-colour criterion in the kernel, and `χ(ℚ(√167)²) ≥ 4` with it (stub)

> **Re-aimed at FS-81's close (2026-09-24).** The target is now **T4 for the whole family**, not one field. FS-81 proved at [hand, two
> independent derivations] (`LEDGER.md` row 82; `plans/FS81-derivation.md` T1–T5) that `χ(ℚ(√d)²) ≥ 4` for every squarefree
> `d ≡ 11 (mod 12)`, and the sharpest form is parametric: **the five listed layers `{vᵏ : |k| ≤ 2}·U₅` have empty `Θ₃`**, `v` the
> type-M rotation. The kernel route, leaf by leaf: (1) FS73-T22's ⟹ direction (this stub's leaf 1, unchanged — everything rests on it);
> (2) the pull-back lemma (FS81-T1, two lines); (3) L1 as an inverse limit over finite symmetric sets (FS81-T2; state it in that form);
> (4) C1(5), the rational layer (FS81-T3: T40's cell list is a finite exact computation, the chain argument short); (5) L3, the torsion
> character `τ` and L4′ (FS81-T4); (6) the five-layer statement parametric in `d` (FS81-T5), whose instance at 167 subsumes this stub's
> old target. **Fallback, per field:** a kernel checker for FS-81's structural certificate (R1–R4; FS81-T9, T12) run on the 40 census
> fields at `K_B(d) ≤ 3`, or V2's relation-form checker (leaf 2 below) on the old certificates. **Cheap first derivation** (FS81 §5 R2):
> T41's shape `{1, v, z}·U^(5)` empties at K = 1 only at d = 23, 71, 119, 167 (all ≡ 23 mod 48), not at 263, 311, 359 — a threshold in
> `n` like configuration B's (FS81-T8); T8's norm-bound method should decide it in an afternoon. Solver needs: **none**. The text below
> is the stub as minted at FS-73's close; its leaves 1–3 stand.

*Minted 2026-09-23 at FS-73's close, from the kernel decisions of `plans/FS73-derivation.md` T22 (stub) and T39 (stub). Rank 3:
none on six, high on trust — it moves the first bound above three at the conjecture's cheapest exposed prediction from a
checker's word to the kernel's, and it is the kind of certificate Kooshi prefers to a large graph.*

## Mission, in plain language

FS-73 proved **χ(ℚ(√167)²) ≥ 4** (`LEDGER.md` row 79): the lattice `L21cc6506` (60 unit vectors, denominator 420) has no proper
three-colouring. The proof has two halves. **The criterion** (T22, its ⟹ direction; T42, V2's forward-lift form): a Cayley graph of
a finitely generated torsion-free abelian group is three-colourable only if some character `θ` puts every generator in
`[1/3, 2/3]` mod 1 — so an empty rotation set `Θ₃` refuses three colours. **The certificate** (T39): three independent exact trees,
each with Farkas-vector leaves, each checked by a standalone Fraction-only checker, prove `Θ₃ = ∅`. Neither half is in the kernel.
Put both there, and compose them with the embedding into ℚ(√167)² — **without** the finite non-three-colourable graph, which is
guaranteed by compactness and has never been exhibited.

## Shape — three leaves and a composition

1. **The criterion's ⟹ direction** (T42's route is the one to formalise: no parity step, no generation hypothesis;
   `data/fs73/records/verify-P3b-q167.md` §1). A proper 3-colouring of `addCayley S` on `Λ = span S ≅ ℤ^r` lifts through the grid
   `ℤ^m → Λ` to a height with steps in `{1, 2}` (the two-step sums around a square lie in `{2, 3, 4}` and agree mod 3, hence
   agree); its winding on the relation lattice `R` is a homomorphism into `3ℤ`; box averages give near-additive maps with values in
   `[1, 2]^m` and exact on `R`; a cluster point of the averages (compactness of the box) is linear, exact on `R`, in `[1, 2]` on
   every generator; and since `ℤ^m/R` is free, `R` is a direct summand and the map descends to a `θ` on `Λ`. Mathlib holds the
   compactness (`IsCompact.tendsto_subseq`) and the splitting of a free quotient; the Følner step on boxes of `ℤ^m` is elementary.
   **Only the relation form is needed downstream** (T42): if `θ ∈ Θ₃` then `x_j = frac θ(u_j) ∈ [1/3, 2/3]` and `r·x ∈ ℤ` for every
   relation `r` — one line, and the certificate uses that direction alone.
   *Option to price, not checked:* every Farkas leaf has a strict margin, and box averages are near-additive with an explicit error,
   so a finite box of explicit size should already refuse — a limit-free route to an explicit finite witness (likely huge).
2. **The certificate checker** — V2's relation-branching tree (`tools/fs73v2_check.py`; the lemma "relation form",
   verify-P3b-q167.md §2): a branch node names a relation `r` (checked `Σ r_j u_j = 0` in integers) and an integer range, its
   children carry `r·x ≤ lo − 1`, `r·x = k`, `r·x ≥ hi + 1`; a leaf gives rational multipliers whose combination `w·x ≤ ρ` has
   `Σ_j min(w_j/3, 2w_j/3) > ρ`. The checker derives every constraint from `(r, lo, hi)`, so a certificate cannot state one. A
   `Bool` over literal data with a soundness theorem, in the house pattern (`NarrowCert.check`; the kernel's cost model: pack into
   big `Nat`s, `List.all` not `∀ x ∈ l`, never build tables during evaluation). Relation coefficients stay small (`|r_j| ≤ 3`, T42).
3. **The lattice in the plane** — `(a, b, c, e) ↦ ((a + b√167)/420, (c + e√167)/420)` is additive and injective, and `u` is a unit
   vector iff `a² + 167b² + c² + 167e² = 420²` and `ab + ce = 0`; each listed vector is checked by `decide` in ℤ. FS-60's
   certificate type over `Adjoin d ℤ` (or `UDCert` parametrised by its coordinate ring) supplies the transfer
   (`UDCert.chromaticNumber_le_planeOver` shape). Completeness of `U` is **not** needed for soundness (verify-P3b-q167.md §2): a
   listed subset with empty `Θ₃` already refuses three colours on a subgraph of the plane.
4. **Compose:** `Θ₃(S) = ∅` ⟹ `addCayley S` not 3-colourable ⟹ `3 < χ(ℚ(√167)²)`, stated as
   `four_le_chromaticNumber_planeOver_sqrt167`, standard three axioms, no native purchase.

**The smallest instance first:** T41's 36 vectors `{1, v, z}·U_R` have `Θ₃ = ∅` by a 1,050-leaf certificate (5.7 KB,
`data/fs73/verify-v2/L21cc6506-sub-1vz-empty.json.gz`) and a half-page hand proof (four inequality cases), and they are a minimal
obstruction. Then the full 60-vector tree (V2: 30,344 leaves, 149 KB) as a control that the checker scales.

## Also owed, in order

- **FS-60's fields through `Θ`, not LRATs** (G71's *Do*): a three-colour question on a lattice is decided by a `Θ` tree, and the
  13 quadratic witnesses of rows 72–74 are three-colour refusals. ℚ(√47)'s shape refuses in 2,997 nodes (653 KB) against a ball's
  LRAT of tens of MB (T26); `Ld65c8ee8` over ℚ(√11) in 20,843 nodes (T43). One checker, one soundness theorem, every field.
- **T23's affine corollary and T25** (ℚ(√11)'s `F = 3Λ` with no forcer): one exact tree per lattice once the criterion is kernel.
- **Declined for now: T24's density** (the McShane-type extension). It is the analytic part and nothing downstream consumes it in
  the kernel.

## Expectations and clauses

- The checker is cheap (high: 1,050 leaves of small rationals; FS-53's `check` and FS-38's cores are the precedent).
- The ⟹ direction is the cost, **unpriced** — price it from its first two leaves after an obligation pass, never from this table
  (`CLAUDE.md` § What compute actually helps: `Kempe.lean`'s 22 leaves were priced at 1½ days and closed in about 40 minutes).
- **Not a failure:** a ⟹ direction that needs the finite-box route instead of compactness; report which.

## Provisional bearings (WORKFLOW 2.0 step 2)

G71 (the criterion and its *Do*: decide three-colour questions by `Θ₃`), G30 (5: every theorem whose hypothesis is a structure
ships an inhabitant — `Ld14c588b`'s linear colouring and ℚ(√11)'s 16 points are the positive inhabitants), G21 (a certificate is
about its enumeration: the checker must re-derive every constraint), G61 (the 3-adic barrier: the refusing directions have 3 in a
denominator — `L21cc6506`'s key does). Rows 72–74, 79. Theorems FS73-T22, T23, T25, T26, T39–T42, T44; FS58-T4 (compactness, now
kernel through `forces_iff_exists_finite`).

## Bearing on χ ≥ 6

None directly. It puts the conjecture's falsification field's best lower bound in the kernel, and it is the first kernel
certificate type that refuses colourings of an infinite graph by a polytope rather than a finite graph by a resolution proof.
