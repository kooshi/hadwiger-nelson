
## Stage 4 — SAVED: the price

### 4.1 Per node, in lines of Lean, low–high

**The narrow route** (what the chain reads: Thm 1.2, through the core of § 3.1, at A-irreducible semisimple actions lifted to
an S-adic solenoid; § 2.4). Each figure is new Lean unless marked; "R ≈ n" is the release's measured size for the analogous
layer on `SL_n(ℝ)/SL_n(ℤ)` (§ 2.3), the one comparison the method has.

| node | contents | Mathlib / library / release | lines |
|---|---|---|---|
| N-A arithmetic | local fields `K_v` with EL's normalized `\|·\|_v`, Haar scaling (2.1) at real, complex and `p`-adic places; the S-integer lattice discrete and cocompact in `K_∞ × K_T`; the duality `M̂ ≅ (K_∞ × K_T)/M^∨`, equivariant, homeomorphic, measurable; the product formula in δ-form; Lemma 7.4 (skeleton `sorry`) | M: completions, `prod_abs_eq_one`, `logEmbedding`, `unitLattice`, Minkowski `O_K ⊂ K_∞`; L: countable Pontryagin duality (`Rigidity/Duality`) | 4,000–10,000 |
| N-B leafwise measures (C1a) | `µ̃_x^V` for S-linear `V` on `X × Ω`: construction from subordinate σ-algebras and `condExpKernel`, normalization, (3.1), (3.4), growth bound ⟹ (3.3), Prop 3.2, measurability into locally finite measures | R ≈ 9,000 for real root leaves; generic parts port (§ 3.2) | 6,000–15,000 (port ≈ 1,500–3,000 of it) |
| N-C entropy contributions (C1b–C1c, **the deepest node**) | thin-boundary partitions in every direction, increasing subordinate `C_V`, `H(C_V \| T⁻¹C_V)` for countably generated σ-algebras, Prop 3.4 relative to `Ω` (well defined, = volume growth, trivial ⟺ 0, `≤ h(T\|Ω)` with equality at `U⁻`) | R ≈ 22,000 (`Entropy/` with the root-future parts of `Geometry/`); P: 3,018 lines already ported (`Outside/OAI015*`) | 12,000–28,000 (port ≈ 3,000–6,000 of it) |
| N-D Thm 5.1 | (5.2), Haar contributions, the atom estimate (5.4) via thin boundaries and the product formula, (5.6) | none; the release's upper bound has another mechanism | 2,000–5,000 |
| N-E Lyapunov algebra and the subadditive half of (6.3) | weights and coarse classes over local fields (§§ 6.1–6.2, semisimple), `W^[χ] = ⋂ U⁻`, (6.2); `h(αⁿ, U⁻) ≤ Σ h(αⁿ, W^[χ])` | none | 2,500–7,000 (**+4,000–8,000 if the inequality needs the product structure**: `[10]` § 8 unread) |
| N-F § 7, narrow | Lemma 7.2 (proved: 89 lines, + its wrapper on contributions), Thm 7.1 without a base, Prop 7.5 (Hopf-type constancy along `W^[χ′]`; `Ω` = projective classes of locally finite measures, a compact metric space), Cor 7.6, the invariance argument (periods closed — the port leaf; largest S-linear subgroup; Luzin, Poincaré recurrence, Chabauty limits; conditional measures over `φ`; invariance from invariant leafwise measures) | M: `Conservative.ae_mem_imp_frequently_image_mem`, `Measure.ext_of_integral_eq_on_compactlySupported`; R (real leaves): `RootLeafHopf`, `SynchronizedReturns`, `RootInvariance`, `PublishedEKL` ≈ 6,000–8,000 | 7,000–17,500 |
| N-G glue | core ⟹ Thm 1.2 (proved, 14 lines); transport across `M̂ ≅ (K_∞ × K_T)/M^∨` of ergodicity, entropy (`ksEntropy_map`) and Haar; the chain switched from `haar_or_zero_entropy` | L: `ksEntropy_map`, `isAddHaarMeasure_of_add_invariant` | 800–2,000 |
| **narrow total** | | | **34,000–85,000** (93,000 with N-E's risk); port share ≈ 5,000–10,000 |

**The full route** (Thm 1.3 as declared) adds: X1 adeles — the restricted-product topology, `K` discrete and cocompact in
`𝔸_K`, Tate's self-duality `𝔸̂ ≅ 𝔸` with `K^⊥ = K`, Lemma 2.1 (Mathlib has `NumberField.AdeleRing` as a definition only):
6,000–14,000; X2 Prop 2.2, Lemma 2.4, Lemma 4.3 (Jordan decomposition over `ℚ`, roots of unity in a Galois closure,
Zariski density of finite-index `Λ`): 2,000–5,000; X3 Lemma 4.2's lift and § 4.3's assembly: 1,500–4,000; X4 the base —
Prop 3.5, the Rokhlin addition formula, Lemma 7.3, (7.4)–(7.7), every contribution relative to `X_base`: 3,000–7,000; X5
Jordan blocks — footnote 3's unwritten modification of `[10]` § 7, §6.4 (Lemmas 6.2–6.3, Prop. 6.4), supporting subgroups,
the full product structure of Thm 6.1 from `[5]`'s proof: 6,000–14,000. **Extra 18,500–44,000; full total 53,000–130,000.**

### 4.2 The calibration applied

Both leaves came in at or below a plan's figure (§ 3.2), as `LEAN.md` § The kernel's cost model predicts; they bear on the
glue and port shares, which I therefore read at the low half of their ranges. They do not bear on the deep nodes, whose
ranges come from the release's measured layers (§ 2.3): the release proved the same method — leafwise measures, entropy
contributions, Hopf-type returns, invariance from leafwise periods — for `SL_n` in about 90,000–97,000 lines, and the narrow
route's midpoint (≈ 55,000) sits below it for reasons named in § 2.3 (compact, abelian, semisimple, no Weyl group, no cusp)
against one that raises it (mixed real, complex and `p`-adic leaves). **Central figures: narrow ≈ 50,000 lines, full ≈
80,000 lines.**

### 4.3 Converted at the measured rate

At 850–913 hand-written lines per active hour (`plans/FS131-close-inventory.md` item 825), with the port share at the
2,600 per hour one ported night measured (low ends at 913 and the small port share, high ends at 850 and the large):

| route | lines | of which port | active hours |
|---|---|---|---|
| narrow (Thm 1.2 at the pieces; retires the axiom) | 34,000–85,000 (central 50,000) | 5,000–10,000 | **34–92** (central ≈ 51) |
| full (Thm 1.3 as declared) | 53,000–130,000 (central 80,000) | 5,000–10,000 | **55–145** (central ≈ 85) |

### 4.4 The narrower statement, and what it saves

**The library's one use needs Thm 1.2, and the narrow route proves it with no declared theorem**: once the core
(`exists_infinite_invariant_of_ksEntropy_ne_zero`) is proved, `haar_or_zero_entropy_of_core` (proved here) replaces
`Rigidity.haar_or_zero_entropy` in Lemma Γ, and **`positive_entropy_rigidity` is then read by nothing on the chain** (its
other reader, `positive_entropy_rigidity_of_polishSpace`, has no consumer) — the import leaves the trust ledger without Thm
1.3 being proved. The saving against the full route: **18,500–44,000 lines (about a third), 21–50 active hours**, and two
reading gaps the full route cannot avoid (footnote 3's unwritten non-semisimple modification; the product structure "from
[5, Thm 8.2] (or more precisely its proof)"); the narrow route keeps one risk from `[10]` § 8 (N-E). A narrower still form —
Thm 1.2 only for the pieces' actions, `ℤ²` by multiplication in `F(i)` — saves nothing further of substance: the core's proof
already runs at that generality (one number field, semisimple), and `haar_or_zero_entropy_of_core` costs nothing extra.

**No route around the theorem was found** for PE-2: every route seen goes through positive-entropy rigidity at some
non-virtually-cyclic `ℤ²` (searched: the paper, its § 1 history, the release's statements; not searched further).

### 4.5 The order I would build it in

1. **In parallel, no dependencies:** N-A (arithmetic and the duality `M̂ ≅ (K_∞ × K_T)/M^∨`, Lemma 7.4's `sorry`); the port
   of the release's remaining generic conditional-entropy layer at this pin (the `tools/fs131_ie1_port.py` method).
2. **Read `[10]` §§ 6–8 first** (not held; arXiv/ETH) — the source proofs of N-B, N-C and N-E's inequality — and settle N-E's
   risk before typing N-C.
3. N-B (leafwise measures on S-linear groups, generalizing the release's real-leaf files; the periods leaf is done), then
   **N-C, the critical path** (Prop 3.4).
4. N-D and N-E, in parallel once N-C's interface is typed.
5. N-F and N-G: the core proved; Lemma Γ switched to `haar_or_zero_entropy_of_core`; the axiom's records audited off the
   chain. The full route's extras (X1–X5), if Thm 1.3 itself is wanted, come after and touch nothing the chain reads.
