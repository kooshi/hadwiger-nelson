# FS-75 — the three-colour criterion in the kernel, and `χ(ℚ(√167)²) ≥ 4` with it (stub)

**At the 2026-09-26 re-rank (job R3; `plans/RERANK-2026-09-26.md` § Application — R3): rank 5 → 26 in `plans/FRONTIER-STUBS.md`.** A kernel port; none on six. Provisional bearings add: FS-103 (the collapse — F1, a candidate composition, not a result), FS-104 (`χ_CP(ℝ²)` at six), FS-105 (harden MR).

> **Minimal instance landed and closed, 2026-09-26** (FS-75's minimal instance; plan and close `plans/FS75-kernel-167.md`, its
> §R-close first; kernel record `plans/FS75-K-kernel-167.md`; register `plans/FS75-derivation.md`; `LEDGER.md` row 119, drafted).
> **`χ(ℚ(√167)²) ≥ 4` is in the kernel** — `four_le_chromaticNumber_planeOver_sqrt167`, standard three axioms, no native purchase, no
> finite graph — from T41's 36-vector certificate (1,050 leaves, 12.2 CPU s). Three reusable pieces: `ThreeColour.nonempty_winding`
> (the criterion's ⟹ in **winding form**: a colouring proper along `s` of any abelian group carries an additive `W` on the relation
> lattice with `Σ_j min(r_j, 2r_j) ≤ 3W(r)`), `ThetaCert.Cert.isEmpty_winding` (V2's relation-branching format, integer multipliers)
> and `ThetaPlane.four_le_chromaticNumber_of_cert` (any `d`, `D`, any real `F ∋ √d`). **What the shape below over-asked:** item 1's
> averages, compactness and descent are needed only for the full criterion (the real point `θ`), never by a relation-branching
> certificate; the "finite-box route" option is closed (the winding needs no limit). **Next (Kooshi's choice; a milestone of its
> own):** the family theorem, row 82 (FS81-T1–T5), with `nonempty_winding` as its first input and, as its second, the real point
> `x ∈ [1/3, 2/3]^m` with `r·x ∈ ℤ` on the lattice from a winding by finite LP duality (stated in this vocabulary at the plan's §M,
> not proved); then S1 and no mixing (row 99), as re-aimed below. **ℚ(√47)'s T26 tree** is a `θ`-space tree (Coxeter's `certcheck.py`
> format), not V2's: it needs a second checker. **Vocabulary for the next gate** (the close's gate, `plans/FS75-kernel-167.md` §R-close
> stage 2): the winding is the circulation of an integer tension (Minty 1962; Tutte's flow–tension duality), the relation lattice is the
> Heuberger matrix's (`[CervantesKrebs2023]`), the height is `[Chandgotia2017]`'s, the cocycle `[CGHO2025coh]`'s. **Price:** 4.5 h
> planned, 45 minutes to a green gate; even the re-price from the first two leaves ran 2–3× high. Solver needs: none.

**Re-aimed at FS-91's close.** The kernel target is S1 over every real number field (J02-T2's chain: J02-L1, L2, L3, L4(a) and a finite sumset) and no mixing (FS91-J09-J4, J09's proposal); every leaf is finite algebra plus one character-sum bound (Weil above 243, exact below), with FS81-T2 and FS73-T22's ⟹ as the named hand inputs. Fallback: a checker for ℚ(α,√7)'s prime data (FS91-J02-C1) and FS-81's census certificates.

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

**Provisional bearings added (2026-09-26, consolidation job C3b; `LEDGER.md` rows 123, 127):** ℚ(√167) needs five at [hand], through MR (row 123), so this stub's instance is that field's kernel lower bound (four); row 127 names row 99 among FS-101's hypotheses, so this stub's re-aimed target (S1 and no mixing, row 99, in the kernel) would discharge one (FS-101's `hRow99`).

## Bearing on χ ≥ 6

None directly. It puts the conjecture's falsification field's best lower bound in the kernel, and it is the first kernel
certificate type that refuses colourings of an infinite graph by a polytope rather than a finite graph by a resolution proof.

## Where the 2026-09-25 work on this lives

*Addresses and titles only, added by the 2026-09-25 crunch's bookkeeper (job J30). The index of that day's work, with its results, is `plans/CRUNCH-2026-09-25-INDEX.md`; a blind verifier does not open it.*

- `plans/FS91-S0F-three-colours.md` §4.5 — job J02's record, its re-aim of this stub
- `plans/FS91-S0FV-three-colours-blind.md` §3.5 — job J09's record, its re-aim of this stub
- `data/crunch-2026-09-25/reports/J02.md`, `J09.md` — the job reports
- `plans/FS91-close-inventory.md` rows 11, 117 — the re-aims
- `plans/FS75-kernel-167.md` (J52's plan; §R-close, J54), `plans/FS75-K-kernel-167.md` (J52K), `plans/FS75-derivation.md`,
  `plans/FS75-close-inventory.md` — FS-75's minimal instance, 2026-09-26
