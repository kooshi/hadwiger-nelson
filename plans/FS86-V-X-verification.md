# Verifier X — FS-86, blind verification of X-D, X-D′, X-H

Scratch record; nothing here is committed. Owner: the coordinating session. Author: verifier X.

## C0 — predictions (saved before any derivation is written; before any repository file but the brief is opened)

Honesty note: these were formed while reading the brief, which states the three claims; a rough mental
sketch of X-H and of X-D′'s two-step shape (cycles, then a last-residue gap argument) formed during that
reading. No file other than the brief and CLAUDE.md (already in context) had been read.

| claim | proved as stated | gap (named step missing) | refuted |
|---|---|---|---|
| X-D′ (one pullback + any residue alternative; under V3) | 0.70 | 0.25 | 0.05 |
| X-D periodicity half, "every F with row 67's tower, no Waring lemma" | 0.45 | 0.50 (expected missing step: at residues on no cycle, a periodic intermediate colouring must be gap-free, which is V3-type input, not free for every F) | 0.05 |
| X-D pullback half (under V3) | 0.90 (as a corollary of X-D′) | 0.08 | 0.02 |
| X-H (unique continuation from a half-space) | 0.85 | 0.12 | 0.03 |
| X-H for non-real F | 0.70 | 0.25 | 0.05 |

Expected shape of the verdicts: X-H by a walk that lowers `h` by a fixed amount per step, using density of a
congruence subgroup of unit vectors in the archimedean torus; X-D′ by (1) periodicity at residues on a cycle of
the "forced-disagreement" digraph via a cycle-sum semigroup that is a finite-index group, (2) a least-fixed-point
colouring plus a gap argument at the last differing transient residue, which uses V3.

## Would-have-searched-here log

(one line per move I would have made by search, and what I did instead)

- (C1, X-D′) Would have enumerated the 1,179,936 four-colourings of P₄ against a sample β to look for an exceptional arc
  digraph (a residue on a cycle whose cycle sums might not generate). Instead: Lemma C proves the cycle semigroup is a
  finite-index group for EVERY cycle, uniformly, so no colouring of P₄ needs to be looked at.

## Reading done before C1 (all permitted by the brief)

CLAUDE.md (in context: Notation, G21, G30, G54, G55, G66, G68, G71, G73, G75); LEDGER rows 66, 67, 87; FS38-derivation
D2-A, D2-B statements; FS86 plan §0, §IQ, §S.4, §R-review, Stage A theorems; FS86-B1-verification Lemma R and its headings.
Not opened: the competitor's file, its successor preamble, any other scratch directory, the close inventory, git log.

## C1 — blind derivations

### Common setting and notation (mine)

- `F` a number field, `L = F(i)`, `U = U_F` the unit vectors (norm-one elements of `L/F`), a multiplicative group with `−1 ∈ U`
  and `U = −U`; `R = ℤ[U]` = the ℤ-span of `U` (a ring, since `U` is closed under products).
- `V = L ⊗_ℚ ℝ`, a real vector space of dimension `2n`, `n = [F:ℚ]`; `R ⊆ L ⊆ V`, and `R` spans `V` over ℝ.
- `T_∞ ⊆ V` the closure of `U` in `V`. For real `F`, `V = ℂ^n` (one factor per real place) and `T_∞ = (S¹)^n`.
- `π : R → O/𝔓⁴` the dyadic reduction; `K := ker π`, an ideal of `R` of index 256; `T := π(U)`; `P₄ = Cay(O/𝔓⁴, T)`.
- For `t ∈ T`: the fibre `U_t := {u ∈ U : πu = t}` (nonempty). `U_4 := {w ∈ U : πw = 1}`, the kernel of the group map
  `U → (O/𝔓⁴)^×`, so a subgroup of finite index in `U`; and `u·U_4 ⊆ U_{πu}` for every `u ∈ U`.

**Facts used (each elementary).**
- (F1) `R` is torsion-free of rank `2n`, so `R/NR` is finite for every `N ≥ 1` (`dim_{𝔽_p} R/pR ≤ rank`, then filter).
- (F2) For real `F`, `U` is dense in `T_∞ = (S¹)^n`: the Cayley map `t ↦ (1+it)/(1−it)` sends `F` into `U`, is a
  homeomorphism `ℝ → S¹ ∖ {−1}` at each real place, and `F` is dense in `F ⊗ ℝ = ℝ^n`.
- (F3) Every finite-index subgroup `U'` of `U` is dense in `T_∞`: the closures of finitely many cosets of `U'` cover
  `T_∞`, so `cl(U')` is a closed subgroup of finite index, hence open, hence all of the connected group `T_∞`.
- (F4) For every nonzero ℝ-linear `Λ : V → ℝ` and every `a ∈ U`, the function `x ↦ Λ(ax)` on `T_∞` takes a negative value.
  It is odd (`−1 ∈ T_∞`), and it is not identically zero, because `T_∞` spans `V` and `a` is invertible in `V`.

### Lemma C (cycle sums generate a finite-index group; no Waring-type input)

**Statement.** There is an integer `N ≥ 1`, depending only on `U_4`, with the following property. Let `m ≥ 1`, let
`t_1, …, t_m ∈ T`, and let `C := U_{t_1} + ⋯ + U_{t_m}`. Let `Σ` be the additive semigroup that `C` generates (finite
sums of one or more elements of `C`). Then `Σ` is a group, and `Σ ⊇ N·R`. If `Σ t_j = 0`, then `C ⊆ K`, hence `NR ⊆ K`.
[hand; mine; real `F` in (F2), and C3 treats non-real `F`.]

**Proof.**
- (a) **No nonzero `Λ` is `≥ 0` on `C`.** Fix `u_j⁰ ∈ U_{t_j}`. The function `Φ(x_1,…,x_m) = Σ_j Λ(u_j⁰ x_j)` on `T_∞^m`
  is continuous and odd. It is not identically zero, because its dependence on `x_1` alone is `Λ(u_1⁰x_1)`, which is odd
  and nonzero by (F4). So `Φ < 0` on a nonempty open set. `U_4^m` is dense there by (F3), and `Σ_j u_j⁰w_j ∈ C` for
  `w_j ∈ U_4`.
- (b) **The convex cone of `C` is all of `V`.** Otherwise the supporting-hyperplane theorem puts it in `{Λ ≥ 0}` for some
  `Λ ≠ 0`, contradicting (a).
- (c) **Finitely many `s_1, …, s_k ∈ C` positively span `V`** (write each `±e_i` of a basis as a finite nonnegative
  combination, and collect the terms). Writing each `−s_i` in the cone and adding up gives a relation `Σ a_i s_i = 0` with
  every `a_i > 0` real. The relation space is defined over ℚ (`s_i ∈ L`), so a strictly positive rational relation exists;
  scale it to integers `a_i ≥ 1`. Then `−s_i = (a_i − 1)s_i + Σ_{j≠i} a_j s_j ∈ Σ`, and `0 ∈ Σ`. So the group `G′`
  generated by the `s_i` lies in `Σ`, and it has rank `2n`.
- (d) **`Σ` is a group.** For `s ∈ Σ`, some integer `k ≥ 1` has `ks ∈ G′`, because `G′ ⊗ ℚ = L`. Then
  `−s = (k−1)s + (−ks) ∈ Σ`.
- (e) **`Σ ⊇ NR`.** `Σ` is a group containing `C`, so it contains `C − C ⊇ u_1⁰(w − 1)` for every `w ∈ U_4`. Hence
  `Σ ⊇ u_1⁰·I`, where `I` is the ℤ-span of `{w − 1 : w ∈ U_4}`. Let `A := ℤ[U_4]`. Then:
  - `I` is an ideal of `A`, since `(w−1)w′ = (ww′−1) − (w′−1)`.
  - The ℝ-span of `U_4 − 1` is the ℝ-span of `T_∞ − 1`, which holds `−2`, hence `1`, hence `V`. So `I ⊗ ℚ = L`, and some
    integer `N₁ ≥ 1` lies in `I`, giving `N₁A ⊆ I`.
  - `R = Σ_{v ∈ V₀} vA` for a finite set `V₀` of coset representatives of `U/U_4`, and each `v ∈ ℚA`. So `N₂R ⊆ A` for
    some `N₂ ≥ 1`.
  - Put `N := N₁N₂`. Then `NR ⊆ I`, and `u_1⁰` is a unit of `R` (its inverse `ū_1⁰` lies in `U`), so
    `NR = u_1⁰NR ⊆ u_1⁰I ⊆ Σ`. ∎

*Why this is not a Waring lemma.* It never shows that sums of a bounded number of unit vectors cover a residue class. It
shows only that the semigroup contains a full-rank lattice (from the cone), and that a semigroup containing a full-rank
lattice in a rank-`2n` torsion-free group is a group. The finite index then comes from the **group** that the fibres generate.

### X-D′ — **PROVED** (under V3; and the periodicity half needs only V3's gap-freeness clause) [hand; mine]

**Setting.** `γ₁ : O/𝔓⁴ → {4 colours}` is a proper colouring of `P₄`, and `β : O/𝔓⁴ → {4 colours}` is any function. `c`
is a proper four-colouring of `Cay(R, U)` with `c(z) ∈ {γ₁(πz), β(πz)}`. Put `S := {r : β(r) ≠ γ₁(r)}` and
`D := {z : c(z) ≠ γ₁(πz)}`. Then `D ⊆ π⁻¹(S)`, `c = β∘π` on `D`, and `c = γ₁∘π` off `D`. Write `D_r := D ∩ π⁻¹(r)`.

**The arc digraph `𝒜`.** There is an arc `r → r′` iff `r ∈ S`, `r′ − r ∈ T` and `γ₁(r′) = β(r)`.
**The exclusion relation.** `r ~ r′` iff `r, r′ ∈ S`, `r′ − r ∈ T` and `β(r) = β(r′)`.

**Lemma 1 (the whole constraint set).** Take `z ∈ R`, `u ∈ U`, `r = πz`, `r′ = r + πu`. Then `c` colours the edge
`{z, z+u}` properly iff none of the following holds:
- (A1) `z ∈ D`, `z+u ∉ D`, and `r → r′`;
- (A2) `z ∉ D`, `z+u ∈ D`, and `r′ → r`;
- (E) `z, z+u ∈ D`, and `r ~ r′`.

*Proof.* The four membership cases; the case `z, z+u ∉ D` never conflicts, because `γ₁` is proper on `P₄`. ∎

Since `U = −U` and `π(−u) = −πu`, the case (A2) is the case (A1) seen from the other endpoint. So a set `D′ ⊆ π⁻¹(S)`
gives a proper colouring `c_{D′}` (`β∘π` on `D′`, `γ₁∘π` off it) iff it satisfies:
- (C1) `z ∈ D′_r` and `r → r′` imply `z + U_{r′−r} ⊆ D′_{r′}`;
- (C2) `z ∈ D′_r` and `r ~ r′` imply `(z + U_{r′−r}) ∩ D′ = ∅`.

`D` itself satisfies both.

**Step 1: residues on a cycle.** Let `W := {r : D_r ≠ ∅}`. By (C1), `W` is closed under arcs. Call `r ∈ W` **recurrent**
if it lies on a directed cycle of `𝒜` (whose vertices are then all in `W`). For such a cycle `r = r_0 → ⋯ → r_m = r`, apply
(C1) around it: `D_r + C ⊆ D_r` with `C = U_{t_1}+⋯+U_{t_m}`, `t_j = r_j − r_{j−1}` and `Σ t_j = 0`. Hence
`D_r + Σ ⊆ D_r`, and by Lemma C, `D_r + NR = D_r`. **Every recurrent `D_r` is `NR`-periodic**, with one `N` for all.
No V3 is used here.

**Step 2: the least fixed point.** The **transient** residues are `𝒯 := W ∖ {recurrent}`. `𝒜` restricted to `𝒯` is
acyclic; fix a topological order. Define `D⁻`:
- `D⁻_r := D_r` for recurrent `r`;
- `D⁻_r := ∅` for `r ∉ W`;
- for `r ∈ 𝒯`, in order: `D⁻_r := ⋃_{r″ → r, r″ ∈ W} (D⁻_{r″} + U_{r−r″})`.

Four claims:
- (i) `D⁻ ⊆ D`, by induction and (C1) for `D`.
- (ii) `D⁻` is `NR`-periodic: `(X + U_t) + NR = (X + NR) + U_t`.
- (iii) `D⁻` satisfies (C2), because (C2) is inherited by subsets. It satisfies (C1): take `z ∈ D⁻_r` and `r → r′`; then
  `r, r′ ∈ W`. If `r′` is recurrent, `z + U ⊆ D_{r′} = D⁻_{r′}`. If `r′` is transient, `D⁻_{r′} ⊇ D⁻_r + U_{r′−r}` by
  definition. So `c⁻ := c_{D⁻}` is proper.
- (iv) `c⁻` is `NR`-periodic, since `NR ⊆ K` and `γ₁∘π`, `β∘π` are `K`-periodic. **By V3 it is a `P₄`-pullback, hence
  gap-free** (no fan gap).

**Step 3: the gap argument at the last transient residue.** Suppose `D ≠ D⁻`. Only transient residues can differ, so let
`r` be the **last** transient residue in the order with `D_r ≠ D⁻_r`, and pick `z ∈ D_r ∖ D⁻_r`. Let `c′` be `c⁻` with
`z` repainted `β(r)`, that is, `c_{D⁻ ∪ {z}}`. Check Lemma 1 on the edges at `z`:
- (A1) `z ∈ D` and `r → r′` give `z+u ∈ D_{r′}`. The residue `r′ ∈ W` is recurrent or a later transient, so
  `D_{r′} = D⁻_{r′}`, and `z+u` lies in the new set. No conflict.
- (A2) Impossible, since `z` is in the new set.
- (E) `z+u ∈ D⁻ ⊆ D` and `z ∈ D` would violate (C2) for `D`.

So `c′` is proper and differs from `c⁻` only at `z`. Hence `β(r) ≠ γ₁(r) = c⁻(z)` is absent from `N[z]` in `c⁻`: **a fan
gap in a periodic colouring**, contradicting (iv). So `D = D⁻`, `c = c⁻` is `NR`-periodic, and **by V3 `c` is a
`P₄`-pullback.** ∎

**What the proof uses.**
- `γ₁` proper on `P₄`. Its gap-freeness is **not** used.
- `β`: nothing.
- `U = −U` and `π(U) = T`.
- Lemma C, which needs the density (F2)–(F3), the span (F4) and the finite rank (F1).
- V3 exactly twice: (V3-gf) *every `NR`-periodic proper four-colouring of `Cay(R,U)` of the form `c_{D⁻}` has no fan gap*,
  used at Step 3; and (V3-pb) *periodic ⟹ `P₄`-pullback*, used only for the final sentence. Without (V3-pb) the conclusion
  is "`c` is `NR`-periodic". Without (V3-gf) the proof stops at Step 3, and only the recurrent residues are proved periodic.

**Adversarial attempt (by formula).** `D := π⁻¹(S′) ∩ {h > 0}`, with `h` additive and nonzero and `S′ ⊆ S`:
- If `S′` contains a recurrent residue, it breaks at Step 1. (C1) around a cycle needs `{h>0} + C ⊆ {h>0}`, but `C`
  contains `s` with `h(s) < 0` (Lemma C (a)), and any `z` with `0 < h(z) < −h(s)` gives `z + s ∉ D`.
- If `S′` is all transient, it breaks at Step 3. At the last transient residue of `S′` the half-space is not of the least
  fixed point's form. Concretely, the least fixed point ignores the wall and `c⁻` gains a fan gap.

So the attempt is killed by a theorem, not by a colouring search.

### Lemma C′ (the dyadic refinement: cycle sums contain a dyadic congruence ideal) [hand; mine; uses B1's Lemma R (b)]

**Statement.** Let `F` be real, with row 67's tower at the conjugation-stable dyadic prime `𝔓` used by `π`, and with
B1's Lemma R (b): `R/nR ≅ ∏_{𝔔 stable, 𝔔|n} O_𝔔/nO_𝔔`, and `U` dense in `∏ T(O_𝔔)`. Then there is `m ≥ 4`, depending only
on the local field `ℚ₂(ζ₁₂)` and its conjugation, such that in Lemma C **`Σ ⊇ K_m := R ∩ 𝔓^m`** for every cycle.

**Proof.** `Σ ⊇ u_1⁰·I` (Lemma C (e)), and `K_m` is an ideal of `R`, so it suffices to show `I ⊇ K_m`. `I` has finite
index, so `I ⊇ nR` for some `n`, and `I` is the preimage of its image in `R/nR ≅ ∏ O_𝔔/n`. That image is the span of
the image of `U_4 − 1`. By density, the image of `U_4` is the image of `∏_𝔔 T₄(O_𝔔)`, where
`T₄(O_𝔓) = T(O_𝔓) ∩ (1 + 𝔓⁴)` and `T₄(O_𝔔) = T(O_𝔔)` at every other stable prime. Taking elements that are 1 at all
places but one, the image is `⊕_𝔔 (J_𝔔 mod n)`, with `J_𝔔 :=` the ℤ_p-span of `T₄(O_𝔔) − 1`. Place by place:
- **Odd stable `𝔔`.** `J_𝔔` is an ideal of the ℤ_p-algebra generated by `T(O_𝔔)`, which is `O_𝔔` (Lemma R (4)). It
  contains `t − 1` for a Teichmüller `t` of order `Q+1`, which is a unit. So `J_𝔔 = O_𝔔`.
- **Another stable dyadic prime `𝔓′`, as at K.** `ζ₁₂ ∈ T(O_{𝔓′})` generates `O_{𝔓′}`, and `ζ₁₂ − 1` is a unit (12 is
  not a prime power). So `J_{𝔓′} = O_{𝔓′}`.
- **At `𝔓`.** `T₄(O_𝔓)` is an open subgroup of the 2-adic points of a smooth connected variety, hence Zariski-dense in it.
  Its ℚ₂-affine span is that of `T(F_𝔓)`, which contains `±1`, hence `0`, and spans `L_𝔓`. So `J_𝔓` is a full-rank
  ℤ₂-lattice in `O_𝔓`, and it holds `𝔓^m` for some `m`.

So the image of every `x ∈ K_m` lies in the image of `I`, and `x ∈ I + nR = I`. ∎

(An exact value of `m` is computed in C1-check below; the proof needs only that it is finite.)

**Consequence for X-D′: V3 is not needed.** Rerun Steps 1–3 with `K_m` in place of `NR`.
- Every recurrent `D_r` is `K_m`-periodic, and so is `D⁻`. Hence `c⁻ = κ∘π_m`, where `π_m : R → O/𝔓^m` (onto, by density)
  and `κ` is a function on `O/𝔓^m`.
- `c⁻` is proper and `π_m(U) = S_m`, so `κ` is a proper four-colouring of `P_m`.
- `P_m` is four-tight at every level (exact at levels 1–8, then D2-B's induction). So `κ` has no fan gap (D2-A (iv)), and
  neither has `c⁻`.
- Step 3 then gives `c = c⁻ = κ∘π_m`, and D2-B pulls `κ` back from `P₄`.

**So X-D′'s conclusion holds for every real `F` with row 67's tower and Lemma R, with no V3 at all.** Under V3, as stated,
it holds a fortiori.

### X-D — **PROVED, both halves; and the periodicity half is stronger than stated** [hand; mine]

- **The pullback half** is X-D′ with `β := γ₂`.
- **The periodicity half, for every real `F` with row 67's tower (K included), with no Waring-type lemma and no V3.** It is
  Lemma C′ plus Steps 1–3 as rerun above. It gives more than periodicity: `c` is a `P_m`-pullback, hence (D2-B) a
  `P₄`-pullback.
  - **K's two dyadic places** cost nothing. `π` reads one place, and at the other `J_{𝔓′} = O_{𝔓′}`, so the other place
    never enters the period. B1 states that Lemma R holds for K.
  - **The inputs are named, and none is V3:** the archimedean density (F2)–(F4); Lemma R (b), for which B1 proves every
    step for real `F` with `F(i)/ℚ` Galois — I read its steps (2)–(5) as general for real `F`; tightness of every `P_m`
    (D2-A, D2-B); and the extra fact in X-D that `γ₂` is proper, so there are no exclusion constraints (C2) and arcs from
    `S` stay in `S`.

**What my C0 prediction got wrong.** I predicted a gap: "the transient step needs periodic ⟹ gap-free, which is V3-type".
It closes because the periodic colouring the transient step meets is not an arbitrary periodic colouring. It is periodic
under a **dyadic** congruence ideal `K_m`: the odd stable places drop out, because cycle sums generate everything there. So
it lives on the tight tower `P_m`, and gap-freeness comes from Hoffman's equality case, not from V3. Without Lemma C′'s
dyadic refinement, the gap I predicted is real: a merely `NR`-periodic colouring over a field with a slack odd place
(ℚ(√11) at 7) can be gapped.

**Adversarial attempt (by formula): a Kempe swap.** Let `γ₂ := τ∘γ₁`, with `τ` the transposition of colours `a, b`. Then
the arcs of `𝒜` are exactly the edges of `P₄`'s `{a,b}`-subgraph, in both directions, so every residue of `W` lies on a
2-cycle and is recurrent. A two-phase colouring is then "swap `a ↔ b` on a union of Kempe components of `γ₁∘π`". The
candidate non-periodic colouring swaps a single Kempe component. It is killed by Step 1: the Kempe component of `z`
contains `z + Σ ⊇ z + K_m`, so **every `{a,b}`-Kempe component of a `P₄`-pullback on `Cay(R, U)` is infinite and
`K_m`-periodic**. This is a by-product: every Kempe swap of a pullback is again a pullback, consistent with row 67.

**C1-check (exact; `fs86-v-x/jp_check.py`, seconds).** The script samples 49 elements `w(t) = (1+it)/(1−it)` with
`t ∈ 2ℤ₂[√3]`. For each it asserts that `w` has norm one under `ζ ↦ ζ⁻¹` and that `v_𝔓(w − 1) ≥ 4`. Their `w − 1` span a
ℤ₂-lattice with HNF diagonal 2-valuations `[2, 5, 4, 3]` (in the basis `1, ζ, ζ², ζ³`), which contains `2⁵O`. **So
`𝔓^{10} ⊆ J_𝔓`, and `m ≤ 10`** (an upper bound, since a sample spans a sublattice of `J_𝔓`).
- The value is plausible. `w − 1 = 2it − 2t² + ⋯`, so the `F`-direction of `J_𝔓` sits deeper than `𝔓⁴`.
- **Plants, each seen to fire:**
  - `noconj` (conjugation replaced by `ζ ↦ ζ⁵`): the norm-one assertion fires;
  - `zerot` (only `t = 0`): "NOT full rank", exit 1;
  - `shallow` (`t` of valuation ≤ 1): the depth assertion fires.

### X-H — **PROVED, for every number field `F`, real or not** [hand; mine]

**Proof.** Let `n := |Q|`. Then `nR ⊆ ker π`, and `nR` is an ideal, so `γ` factors through the finite ring `R/nR` (F1).
Put `U_n := {w ∈ U : w ≡ 1 mod nR}`, the kernel of `U → (R/nR)^×`. It has finite index in `U`, and `u·U_n ⊆ u + nR`.
- **The functional.** `h` extends uniquely to an ℝ-linear `Λ ≠ 0` on `V = R ⊗ ℝ = L ⊗ ℝ`.
- **The steps.** For each class `q ∈ R/nR` and each colour `a ≠ γ̄(q)`:
  - gap-freeness gives `u_{q,a} ∈ U` with `γ̄(q + u_{q,a}) = a`;
  - (F3)–(F4) give `w_{q,a} ∈ U_n` with `Λ(u_{q,a}w_{q,a}) < 0`;
  - put `v_{q,a} := u_{q,a}w_{q,a} ∈ U`. Then `γ̄(q + v_{q,a}) = a` and `h(v_{q,a}) < 0`.
  - There are finitely many pairs, so `δ := min −h(v_{q,a}) > 0`.
- **The walk.** Suppose `c(z_0) ≠ γ(z_0)`. Given `z_k` with `c(z_k) ≠ γ(z_k)`, put `a := c(z_k)`,
  `q := z_k mod nR` and `z_{k+1} := z_k + v_{q,a}`. Then `γ(z_{k+1}) = a = c(z_k) ≠ c(z_{k+1})`, since `c` is proper and
  `v ∈ U`. So `z_{k+1}` is again a disagreement, with `h(z_{k+1}) ≤ h(z_k) − δ`.
- **The contradiction.** For large `k`, `h(z_k) ≤ min ε ≤ ε(πz_k)`, so `z_k` lies in the agreement set. ∎

**What it uses.**
- `c` is proper.
- `γ` has no fan gap: every colour other than `γ(z)` appears on `z + U`. `γ`'s own properness is not used.
- `γ` is periodic, which gives finitely many step types and a uniform `δ`.
- `h ≠ 0`, used through (F4).
- The density (F2)–(F3) and the span-and-oddness fact (F4).
- It holds for any number of colours `k`, not only four.

**Where "gap-free" is used, and the adversarial attempt, by formula, at ℚ(√11).** Gap-freeness is used exactly at the
choice of `u_{q,a}`.
- Take a periodic colouring `γ` pulled back from a gapped four-colouring of `Γ₇` (row 66: gapped colourings exist at 7,
  and ℚ(√11)'s 7 is usable).
- At a point `z*` of a gapped class, the colour `a₀` is absent from `N[z*]`. Let `c := γ` with `z*` repainted `a₀`; `c` is
  proper.
- For any `h ≠ 0`, take `ε ≡ h(z*) − 1`. Then `c` agrees with `γ` on `{h ≤ ε}`, yet `c ≠ γ`.
- So the hypothesis is necessary, and the proof fails exactly where it must: there is no step into the colour `a₀` from
  `z*`'s class.

The hypothesis `h ≠ 0` is also necessary: with `h = 0` and `ε ≡ −1` the agreement set is empty.

**Non-real `F` (C3).** Let `L = F[X]/(X² + 1)` (a field, or `F × F` when `i ∈ F`), and let `U` be the norm-one group.
- At a complex place, `T(ℂ) = {(s, 1/s)} ≅ ℂ^×`, which is connected. The Cayley map `t ↦ (1+it)/(1−it)` has image
  `ℂ^× ∖ {−1}`, dense. `F` is dense in `∏ F_v`, so `U` is dense in `T(F ⊗ ℝ) = ∏ S¹ × ∏ ℂ^×`, a connected group. That is
  (F2)–(F3).
- `{(s, 1/s)}` spans `ℂ × ℂ` over ℝ: take `s = 1, i, 2, 2i`. And `−1 ∈ U`. That is (F4).
- The torus is not compact there, so `h` is unbounded on `U`. The proof needs only one step of negative `h` per step type,
  so this does no harm.

**X-H holds for non-real `F`, and `F` real is not needed.**

## C2 — comparison with the competitor's working file

Opened only after every C1 verdict above was saved: `fs86-comp-debruijn/FS86-C-deBruijn.md`, §6.2, §6.3, §6.3a, §6.4.
Nothing else in that file or directory was read. The competitor's names are "Theorem D" (X-D), "Theorem D′" (X-D′, in
§6.3a) and "Theorem H" (X-H).

**No divergence of truth.** Every step of D, D′ and H that I checked is correct, and each statement as written is true.
The divergences are of scope, completeness and route.

| # | where | kind | the competitor | mine / the verdict |
|---|---|---|---|---|
| D1 | D′, statement ("Let F satisfy V3") | **scope: V3 is not needed** | V3 is used at step (3), to make `c^min` gap-free, and for the conclusion | Lemma C′: the cycle-sum group contains `R ∩ 𝔓^m` (`m ≤ 10`, exact check). So `c^min` is a pullback from the tight `P_m`, and gap-free by D2-A (iv). The conclusion then follows by D2-B. **D′ holds for every real `F` with row 67's tower and Lemma R (b), with no V3.** True as stated; stronger in truth |
| D2 | D, "the pullback half needs V3" | **scope** | pullback half conditional on V3 | By D's own Eulerian step plus Lemma C′, `c` is `K_m`-periodic, so `c = κ∘π_m` with `κ` a colouring of `P_m`, and D2-B pulls it back from `P₄`. No gap argument and no V3 |
| D3 | D, "Free control … at ℚ(√11) it gives periodicity … V3 fails" | scope (a weaker-than-true remark) | reads as if a two-phase colouring over ℚ(√11) might be periodic but not a pullback | Lemma C′ applies at ℚ(√11): at 7, and at the ramified 11, a Teichmüller `t` has `t − 1` a unit, so the cycle sums generate everything there. **Every two-phase colouring over ℚ(√11) is a `P₄`-pullback.** The 7-adic colourings that break V3 are never two-phase mixtures, so the control is consistent, but the sentence undersells the theorem |
| D4 | D, step 6 ("`ℚ(U₄) = F(i)`") | completeness at class scope | justified by "a non-rational `v^{24}` from `ℚ(√−59)`'s norm-one group", which is specific to ℚ(√59) (I checked: `u = (1+i√59)/(1−i√59) = (−58+2i√59)/60` is not a root of unity, so `u^{24} ∉ ℚ(i)`) | the statement is at class scope (K included). It closes for every real `F` by density: `U₄` is dense in `(S¹)^n`, which spans `V`, so the ℚ-span of `U₄` is `L` ((F2)–(F3)); for non-real `F`, see C3 |
| D5 | D, step 7 (finite index of `nwR`) | scope of an input | cites B1's Lemma R / V2, which B1 proves for real `F` with `F(i)/ℚ` Galois | avoidable. The group contains `C − C ⊇ u_1(U₄ − 1)`, so it holds `u_1 I₄ ⊇ NR` with `N` from (F1) alone (Lemma C (e)). Only for the V3-free pullback (D1, D2) is Lemma R (b) needed |
| D6 | D, steps 4–5 (the group property) | route | `S_x` is closed under `ℕ[U₄]`, and `−1 = 5t₊ + 5t₋ + 5·1` with `t± = −(3±4i)/5 ∈ U₄`, so `ℕ[U₄] = ℤ[U₄]`. I checked: `t − 1 = −4(2±i)/5` has `v_𝔓 = 4` (`𝔓² = 2`, `2 ± i` a unit); `5t₊ + 5t₋ + 5 = −1` | the archimedean cone lemma (Lemma C (a)–(d)). **Theirs is shorter and purely dyadic** (it needs `e(𝔓/2) = 2`, true in the class); mine needs no special unit. Keep both |
| D7 | D, step 2 (Eulerian) | route, and it corrects my C0 | tightness of `P₄` gives every vertex outside a colour class exactly `−λ_min = 8` neighbours in it. So the residue digraph has in-degree = out-degree = 8 and **every residue is recurrent: no transient step is needed in D** | I used the transient machinery plus Lemma C′ for D. I checked their step: it follows from `M1_A = (da/n)1 + λ_min(1_A − (a/n)1)`, `a = n/4`, which gives `−λ_min` neighbours in `A` off `A`. **Theirs is the cleaner proof of D's periodicity half**, needing neither V3 nor Lemma C′. My C0 "gap" prediction for D is refuted by this step |
| D8 | D′, steps (3)–(4) | none | `Φ` = forward closure of the recurrent part; take `x ∈ π(Y)` with no arc into `π(Y)` (a sink of the acyclic part), and a gap at `z` | identical to my Steps 2–3 (least fixed point; the last differing transient residue). I re-derived their case split on the neighbour `w`, and it is complete: `w ∈ Φ` gives a `β = β` conflict in `c`; `w ∉ Φ` gives an arc into `π(Y)` |
| D9 | H, steps 3–4 | route | explicit archimedean form `h = Σ Re(ᾱ_jσ_j·)`, `inf h(C_a) = −ρ = −Σ|α_j|`, and a descent on `M(x) = inf h` over each residue's disagreement set | a fixed-step walk, with the negative step found by oddness under `−1 ∈ U` and density. Equivalent. **Their class `C_a` is a coset of `ker π`, which need not be an ideal; density holds because `ker π ⊇ |Q|R`, an ideal.** They do not say this, but it is true |
| D10 | H, scope | agreement, plus two additions | "any number field", only gap-freeness used, gapped `γ` escapes, non-real `F` shorter | agree on all four. Additions: `γ`'s properness is never used, and the theorem holds for any number of colours. For `i ∈ F`, "`R ⊗ ℚ = F(i)`" should read `F[X]/(X²+1) ≅ F × F`; the proof is unchanged (`T(ℂ) = ℂ^×`) |
| D11 | H, "Equivalently: … unbounded below … on some residue class" | checked | — | true: if every class's disagreement set were bounded below by `b_x`, then `ε(x) := b_x − 1` would contradict H |
| D12 | §6.3a other bullets (stripes via Lemma W; three phases) | not checked | — | outside my brief; not verified |

**§6.4 (the prior-art gate).** Its queries are recorded with hit counts. I ran no gate, since the brief did not ask for one.
One observation for the owner: X-H is a "no one-sided defect" statement, and the symbolic-dynamics words the competitor
lists as not run ("expansive direction", "one-sided rigidity") are the right next queries.

## C3 — scope

1. **Does X-D's periodicity half hold for every `F` with row 67's tower, K included? Yes.**
   - **Two independent proofs.**
     - The competitor's route: Eulerian, then the dyadic `−1`, then finite index. Its class-scope steps close by D4
       (density gives `ℚ(U₄) = L`) and D5 (finite index from finite rank alone, no Lemma R).
     - Mine: Lemma C and Lemma C′.
   - **At K.** `π` reads `𝔓₁`. At `𝔓₂`, `ζ₁₂ − 1` is a unit, so `𝔓₂` never enters the period. With Lemma C′ the
     conclusion is a `𝔓₁`-pullback, consistent with VK (each `R_K`-coset is a pullback at one of the two places).
   - **Non-real `F` with the same tower.** The periodicity half holds too: density at the complex places (the C3 part of
     X-H) gives D4, and D5 needs only finite rank. The V3-free pullback also needs Lemma R (b) at `F`, which I have not
     checked for non-real `F`.
2. **What does X-D′ need of V3, exactly?** At most two clauses.
   - (a) The periodic colouring `c^min = c⁻` ("`β` on a periodic set, `γ₁` elsewhere") has no fan gap. This is used once,
     at the last transient residue.
   - (b) Periodic ⟹ `P₄`-pullback, used only for the final sentence.
   - **With Lemma C′ neither is needed.** `c^min` is a `P_m`-pullback, so (a) holds by D2-A (iv) on the tight `P_m`, and
     (b) holds by D2-B. The inputs that replace V3 are Lemma R (b) and the tightness of every level of the dyadic tower.
     No odd-place independence ratio and no Zhang are needed.
3. **Does X-H need `F` real? No.** It holds for every number field, including `i ∈ F`, where `L = F × F`. At complex
   places, `T(ℂ) = ℂ^×` is connected, spans `ℂ × ℂ` and contains `−1`. It holds for any number of colours, and `γ`'s
   properness is not used.

## Theorems this phase proved

Each is one line, with its grade and where its proof lives (this record, `fs86-v-x/VERIFIER-X.md`). None is kernel.

- **VX-C (Lemma C).** Over any number field with dense unit vectors (every real `F`; non-real `F` by X-H's C3), the
  additive semigroup generated by a cycle's fibre sums `U_{t_1}+⋯+U_{t_m}` is a group and contains `NR`, with `N`
  depending only on `U_4`. [hand; mine] §Lemma C.
- **VX-C′ (Lemma C′).** For real `F` with row 67's tower and Lemma R (b), that group contains `R ∩ 𝔓^m` with `m ≤ 10`.
  [hand + tools exact for the bound; `jp_check.py`, three plants fire] §Lemma C′, §C1-check.
- **VX-D′.** X-D′ as stated (under V3) holds. Stronger, **without V3**: for every real `F` with row 67's tower and
  Lemma R (b), a proper four-colouring with `c(z) ∈ {γ₁(πz), β(πz)}` (`γ₁` proper on `P₄`, `β` arbitrary) is a
  `P₄`-pullback. [hand; mine; route identical to the competitor's D′ at the gap step] §X-D′, §Lemma C′.
- **VX-D.** X-D, both halves. Periodicity for every `F` with row 67's tower (K included; non-real as in C3), and the
  pullback half without V3 (given Lemma R (b)). [hand; mine, with the competitor's Eulerian step as a second, simpler
  route] §X-D, C2 D2, D7.
- **VX-K (a corollary).** Every two-colour Kempe component of a `P₄`-pullback on `Cay(R, U_F)` is infinite and
  `R ∩ 𝔓^m`-periodic. [hand] §X-D, adversarial attempt.
- **VX-11 (a corollary).** Over ℚ(√11), every two-phase colouring (as in X-D′) is a `P₄`-pullback, although periodic
  colourings that are not pullbacks exist there. [hand] C2 D3.
- **VX-H.** X-H for every number field (real or not), any number of colours; it uses only `γ`'s gap-freeness and
  periodicity, `c` proper, and `h ≠ 0`. Gap-freeness is necessary: a one-point repaint of a gapped `Γ₇`-pullback over
  ℚ(√11) breaks it. [hand; mine] §X-H.
- **Exact check.** `J_𝔓 ⊇ 𝔓^{10}` in `ℤ₂[ζ₁₂]` under `ζ ↦ ζ⁻¹`. [tools exact; plants `noconj`, `zerot`, `shallow` each
  fire] `jp_check.py`.

## Would-have-searched log (continued)

- (C1, X-H) Would have searched for a gapped periodic colouring to test necessity. Instead: row 66's theorem (gapped
  colourings of `Γ₇` exist) and a one-point repaint, by formula.
- (C1, Lemma C′) Would have run a solver-free but exhaustive search for `m`. Instead: a proof that `m` is finite (Zariski
  density), and a 49-element exact sample bounding it (`m ≤ 10`), which checks a derived claim and searches nothing.
- (C2) No search moves.

## Token account

About 185k tokens at the end of C4, within the brief's budget of about 350k.
