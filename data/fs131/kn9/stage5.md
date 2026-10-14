
## Stage 5 — SAVED: the lanes after this job, and the drafts

### 5.1 The lanes (none shares a file with another)

| lane | writes | needs | who |
|---|---|---|---|
| **M5-E** — `Rigidity/EntropyFibres`' 9 leaves | that file | Mathlib; the port; `Rigidity/Entropy` | an implementer; the finite-fibred trio is the bulk |
| **M5-P** — `Rigidity/PositiveEntropy`'s 10 leaves (`haar_or_zero_entropy` last) | that file | M5-E's statements | an implementer; may run beside M5-E |
| **M9-R** — `exists_mul_stableIntegers_le`, `dense_mixedEmbedding_nsmul_unitRing` | `Rigidity/RingScope` | Mathlib's Dedekind and mixed-embedding API | an implementer; on M8b's path (the first) |
| **M9-S** — `noRamifiedStableDyadic_of_tca` | one proof in `Rigidity/ChainAtTA` | nothing new | an implementer, any time (off the path) |
| **T** — `TateModel F` and its construction (`ψ`, the five facts of § 4.1) | new files | M9-R (`c·O′ ⊆ R`), PD (D2's case) | **a planner first**, who measures the two forms of `ψ_w` on the first two leaves |
| **M8b** — `TateModel F` typed, then M8b-2, -3, -4 over it | new files | N (landed), M9-R, PD; lane T's structure (its statement, not its proof) | **a planner**, on § 4's vocabulary |

The order on the chain's longest path: M9-R and the M8b planner can start now; lane T's planner beside them (it shares no
file); M5-E and M5-P are independent of all three.

### 5.2 Drafts for files I do not write

- **`data/fs131/claims-NF2.md` § Dated lines** (each follows the last line there):
  - "2026-10-14 — **The finite-fibred step reads the declared clause (4) as stated; `haar_or_zero_entropy` takes no
    `PolishSpace` (FS131-KN9, the coordinator's ruling).** Over the Borel σ-algebra of `X ⧸ G` for every compact T1 group: a
    finite partition whose cells lie in translates of an open `U` with `(U − U) ∩ G = {0}` — on which the projection is an open
    embedding, so images of Borel subsets of a cell are Borel — and the pattern of a partition `P` on the cosets give
    `H_n(P) ≤ H_n(pattern) + log |Q|` (`Rigidity.ksEntropy_eq_zero_iff_of_finite`, module `Rigidity/EntropyFibres`; a plan, not a
    proof). The binder `[PolishSpace X]` added by FS131-KN8 (inventory item 761) is gone: no Lusin–Souslin is read. The kernel's
    dump shows exactly that binder removed, and the statement is again FS131-KN7's."
  - "2026-10-14 — **EF_F⁺ on a weaker reading of the ring (FS131-KN9; a reading, one mind; the kernel is its test).** X01D's
    model, Lemma PF, the pigeonhole and Step 6's finite orbits read `R` only through `R ⊆ O′` (FS91-J10-L1 (c)) and `c·O′ ⊆ R`
    for an integer `c ≥ 1` (FS91-J10-L1 (e)), both over every real number field. If M8b's proof is written so (the coordinator's
    ruling: it is planned so), EF_F⁺ and MR⁺ hold over every real number field, NF2-MRPLUS-SCOPE (a)'s GAP at row 100's
    exception fields closes, and `R = O′` (Lemma C′) leaves the headline's path unless module M12 reads it; the class `L ≥ 5`
    is inside the scope either way."
  - "2026-10-14 — **M9's two unnumbered results are typed (FS131-KN9).** The density of the ring as
    `Rigidity.dense_mixedEmbedding_nsmul_unitRing` (`N·R` dense in `L ⊗ ℝ` for every `N ≥ 1`; EN1 § 8.2 route 4, reading no
    `R = O′`); `R = O′` as `Rigidity.unitRing_eq_stableIntegers`, off M8b's path, planned in words; `R ⊆ O′` proved
    (`Rigidity.unitRing_le_stableIntegers`)."
  - "2026-10-14 — **Strong approximation and Lusin–Souslin leave EF_F⁺'s inputs (FS131-KN9; a plan).** Step 6's finite
    `U`-orbits on `L/Λ` follow from `d·O′ ⊆ Λ ⊆ d⁻¹·O′` and the finiteness of `O′/nO′`; the leaves' Borel isomorphisms from
    σ-compactness (closed embeddings on compact pieces). Tate's duality in the form the model reads stays, as lane T."
- **`LEAN.md` § Searching — Lean**, new lines:
  - "A definition over the stable valuation subrings (`StablePrime.localRing`, `Arith/UpperHalf`) needs `[NumberField F]`;
    without it the elaborator reports `failed to synthesize NumberField ↥F` at the first use (FS131-KN9, `Rigidity.stableIntegers`)."
  - "At the pin `continuous_mul_left` is deprecated for `continuous_const_mul` (FS131-KN9)."
  - "Mathlib at the pin holds `NumberField.AdeleRing`, `IsDedekindDomain.FiniteAdeleRing` and `NumberField.InfiniteAdeleRing` as
    topological rings, `NumberField.prod_abs_eq_one`, `NumberField.Embeddings.pow_eq_one_of_norm_eq_one` (Kronecker),
    `NumberField.classNumber`, `Ideal.card_inertia_eq_ramificationIdxIn` and `Ideal.Quotient.stabilizerHom_surjective`; it holds
    nothing of the adeles' duality — no discreteness of `K`, no compact quotient, no additive characters (searched by name,
    FS131-KN9, `data/fs131/kn9/logs/Names9.log`; `Mathlib/NumberTheory/Padics/AddChar.lean` treats `ℤ_p` only)."
  - "A ruling that removes one binder of a statement is shown from the kernel's side by two dumps of the compiled module and
    `tools/fs131_kn9_binder.py`: the old print holds the binder's text once and, with it removed, is the new print; the other
    constants are unchanged; the control keeps one character of the binder and must fail (FS131-KN9)."
- **`Rigidity/Pieces`' module docstring** (lane G's file, or the landing): "at each piece, with `[PolishSpace (PieceDual M)]`
  from `Rigidity.polishSpace_dual`." becomes "at each piece (it takes no `PolishSpace` since FS131-KN9)."
- **`BIBLIOGRAPHY.md`**: a row **`[Tate1950]`** — J. Tate, *Fourier analysis in number fields and Hecke's zeta-functions*, thesis,
  Princeton (1950), in Cassels–Fröhlich (eds.), *Algebraic Number Theory* (1967) 305–347 — role: the source of the self-duality
  lane T formalizes (§ 4.1 there: the additive characters and `K^⊥ = K`); **not held, not read** (recalled). A row
  **`[Weil1967]`** — A. Weil, *Basic Number Theory*, Grundlehren 144, Springer (1967), Ch. IV — the same role; **not held, not
  read** (recalled). `[ChothiEverestWard1997]` (row at l. 95/764): cited again by X01D l. 118 for the `S`-integer duality;
  unread here. `[EinsiedlerLindenstrauss2022]`: nothing read by this job beyond Theorems 1.2–1.3 as quoted in
  `Rigidity/PositiveEntropy`'s docstring.
- **`ARCHITECTURE.md`**: written by this job (its rows for `Rigidity/EntropyFibres` and `Rigidity/RingScope`, and the
  `PositiveEntropy` row); § Trust: nothing new (no axiom added; the declared theorem untouched).
