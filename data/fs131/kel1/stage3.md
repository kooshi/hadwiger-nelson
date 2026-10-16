
## Stage 3 — SAVED: the top typed, two leaves proved

### 3.1 The modules (branch `fs131-kel1` only; nothing here reaches `main` while `Skeleton` holds a `sorry`)

| module | what | lines (total / code) | `sorry` |
|---|---|---|---|
| `Proofs/HadwigerNelson/ELRigidity/Skeleton.lean` | the narrow route's top: the core `exists_infinite_invariant_of_ksEntropy_ne_zero` (EL Thm 4.1 read at a totally irreducible action on a solenoid); **`haar_or_zero_entropy_of_core`, proved from it** — Thm 1.2 exactly as `Rigidity.haar_or_zero_entropy` states it, with no declared theorem under it; **`eq_of_le_of_sum_le`, proved** — (7.8′)'s equality forcing, with a model; Lemma 7.4's arithmetic `virtuallyCyclic_of_proportional_weights` over Mathlib's `InfinitePlace`/`FinitePlace` | 94 / 49 | 2 |
| `Proofs/HadwigerNelson/ELRigidity/Linearity.lean` | **the fresh leaf**: Lemma 7.2's elementary core, `exists_eq_mul_abs_of_homogeneous_of_antitone`, three lemmas under it, a model exercising every clause | 122 / 89 | 0 |
| `Proofs/HadwigerNelson/ELRigidity/LeafPeriods.lean` | **the port leaf**: `[OAIMath2026]` `PrimePackets/LeafPeriods.lean` ll. 103–207 (8 declarations, the periods of a locally finite measure on `ℝ` a closed subgroup, `ℝ` or cyclic), copied by hand at this pin; then **generalized** to every locally compact Hausdorff topological abelian group (`leafPeriods`, `leafPeriods_eq_tests`, `isClosed_leafPeriods`) — EL p. 33's closed subgroup `W_x`, whose leaves are products of local fields; a model | 207 / 141 (ported 73, generalized 63) | 0 |

`Proofs.lean` imports the three; `ARCHITECTURE.md` has a row for each (`tools/check_architecture.py`: PASS). The skeleton's
statements were read aloud against the page: the core's conclusion is what Thm 4.1 gives at a totally irreducible action
(an adelic `G ≠ 0` on the lift, pushed down closed and infinite; EL p. 14 and § 7.2) and is true given Thm 1.3 (FS105-DED's
step 1–2 read it); Lemma 7.4's typed form is the page's with "Lyapunov weight" written out at every place, `χ = 0`
included (then every `ζᵢ` is a root of unity and `Λ` the multiples of their orders).

### 3.2 The calibration

**The fresh leaf** (Lemma 7.2's core). Designed and written 04:09–04:12 UTC, elaborated twice (one fix: `nsmul_eq_mul`
had rewritten the `ℤ^d`-smul in the model; and a deprecated import), green at 04:14 under `lake env lean` (2.9 s, 1.8 GB).
**89 code lines.** A plan line for "Lemma 7.2" would have read 100–200: it came in at the low end.

**The port leaf.** The release's 88 non-blank lines became 73 code lines here with **one proof patch** (`mem_ofPred_eq` →
`mem_setOf_eq`, a rename already in `LEAN.md`'s list of pin differences) and the release's `open scoped CompactlySupported`;
it elaborated on the first try (04:15). **The generalization from `ℝ` to a locally compact abelian group took 63 lines and
one added hypothesis (`[ν.Regular]`, an instance on `ℝ`)**, elaborated on the first try, because the release's proof is
generic (a convolution with `1`, Riesz uniqueness); the release's ℝ-only step (`AddSubgroup.dense_or_cyclic`) does not
generalize, and EL's replacement — the largest S-linear subgroup of `W_x` — is new work.

**What the two leaves calibrate, and what they cannot.** (1) The release's generic measure theory ports to this pin at about
one patch per hundred lines, consistent with FS131-IE1 and FS131-IP23 (2 to 6 patches per 500 lines). (2) Its real-leaf layer
generalizes to S-linear leaves at roughly its own size where the argument is generic, and must be rewritten where it reads
`ℝ`'s order, intervals or Besicovitch density on `ℝ` — the pattern for pricing nodes C1a–C1c. (3) Elementary glue (Lemma 7.2,
(7.8′), the core-to-Thm-1.2 step, 14 lines) lands at the low end of a plan's figure. (4) **Neither leaf calibrates the deep
nodes** (C1c, C1a, C3's subadditive half, Prop 7.5): for those the calibration is the release's measured size for the same
method on `SL_n` (§ 2.3), not these leaves.
