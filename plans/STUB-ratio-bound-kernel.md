# FS-51 — The ratio bound in the kernel: an exact rational Delsarte dual for the finite planes, and χ(UD(𝔽₈₃, 2)) ≥ 6 as a kernel theorem (STUB, 2026-09-14; minted at FS-50's close from the advisor's Q4)

*Read beside: `plans/STUB-independence-threshold.md` §S4 D9 and §M2 (the nonnegative-combination identity, whose pair-level
case this is), `plans/FS50-certificate-soundness.md` (the one-page derivation), `tools/fplane_cert_check.py` (the exact
checker whose pair-level restriction is the object here), `Proofs/HadwigerNelson/LocalGlobal.lean`
(`add_one_le_chromaticNumber_of_indepNum_le`), `Instances/IndependenceThreshold.lean`; `CLAUDE.md` row 53, G44, G54, FS-41.*

## 1. Mission context, in plain language

Every floor this project states for a finite plane's chromatic number above five — "`χ(UD(𝔽₈₃, 2)) ≥ 6` by the spectrum",
row 53's sieve from 59 up — is derived from Hoffman's ratio bound on float character sums, and **none of it is in the
kernel**. FS-50 showed the shape of an exact certificate for an independence bound: a rational nonnegative-combination
identity over the orbit algebra, checked by exact linear algebra; at the pair level (no triple matrix `Y`, only
`M(g) ⪰ 0` — Delsarte's LP) the same identity certifies the ratio bound itself, or any value the LP dual can be rounded to,
and the kernel lemma `add_one_le_chromaticNumber_of_indepNum_le` turns it into `χ ≥ 6`. The obstacle the advisor named:
positive-definiteness of the dual function over `ℚ` — the characters live in `ℚ(ζ_p)`, so the PSD condition is on blocks of
size `p − 1` grouped by the Galois orbits, unless the certificate is carried as a Gram factor `Z = BᵀB` with rational `B`,
which the kernel checks by `n²` big-integer multiplications (GMP `Nat`, Kronecker packing — D9).

## 2. What we know

| fact | trust | where |
|---|---|---|
| the ratio bound α ≤ 1,199.46 at 83 and the floor 6; Delsarte = ϑ′ = Hoffman at 11, 19, 23, 83 | float | `data/fplane/spectral-p83.json`, `theta-below-84.json` |
| the exact certificate shape and a checker that accepts one at 11 (triple level) | exact-rational | FS-50 phase D′ |
| the kernel consumer at `(6, 1148)` and `(k, a)` in general | kernel | `LocalGlobal.lean` |
| `card_le_mul_of_colorable`; `decide +kernel` costs; the GMP-`Nat` cost model | kernel; measured | `CLAUDE.md` § The kernel's cost model |

## 3. Derivations first

**D1 — the pair-level certificate.** For `S` independent with indicator `x`, `Σ_{u,v} x_u x_v Z[u,v] ≥ 0` for any PSD `Z`;
choose `Z = BᵀB` on `V = 𝔽_p²` that is `G`-invariant (a function of `Q(v − u)`), zero on the unit circle's class where the
identity needs it, and read the identity `N·|S| − |S|² ≥ …` — Delsarte's dual, one rational function on `p` classes plus a
Gram factor. The rounding is the pair-level case of `fplane_cert_round.py`; the target `N` is the ratio bound's floor
(`≤ 1,199` at 83 gives `χ ≥ 6` since `6 · 1148 < 6889` needs `≤ 1148` — **no**: the floor 6 needs only `5 · 1199 < 6889`,
i.e. `α ≤ 1377`; the ratio bound certifies far more than the floor needs, so the rounding has slack).

**D2 — the kernel form.** State `indepNum_le_of_gram_identity`: a `G`-invariant rational `B` and multipliers whose identity
holds coefficient-wise (a `decide`-able check over the `p` classes once the structure constants are literals) give
`(finitePlane p).indepNum ≤ N`; then `add_one_le_chromaticNumber_of_indepNum_le` closes `six_le_chromaticNumber_finitePlane83`.
Price the `Nat` arithmetic: `B` is `r × p²` with `r ≤ p`; `BᵀB`'s class sums are `p` numbers each a sum of `p²·r` products —
`≈ 6·10⁷` big-integer multiplications at 83, in the kernel's GMP `Nat` — measure before promising (the M04 pattern: pack
rows into big `Nat`s).

## 4. Phases

| phase | what | cost | stop rule |
|---|---|---|---|
| A | the pair-level rational certificate at 11, 19, 23, 83 (`fplane_cert_round.py --pair-only`), accepted by the checker | a day | a certificate at each prime, `N` at or below the ratio bound's floor |
| B | the kernel statement and its `decide`-able check at 11 (`five_le_…11` from the pair level as the control against the existing kernel theorem) | two days | green |
| C | at 83: `six_le_chromaticNumber_finitePlane83`, the floor in the kernel for the first time | days; priced in B | the ledger's row 53 rewritten with a kernel address |

## 5. Bearing on 6, honestly

**None; medium as mechanism.** It moves every "by the spectrum" sentence in the record from float to kernel, and it is the
first step of the triple-level kernel form (FS-52).
