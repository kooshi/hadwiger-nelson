# FS-89 Stage 0, part B — the exact four-colour band set of the rational unit circle at 5

*The Stage-0B agent's record (de Bruijn, Opus 5.5), from the owner's brief `data/fs89/briefs/S0B-band-set-brief.md`
(commit `0a346e98`). Outputs under `data/fs89/s0b/`. No SAT, no finder, no sweep; exact rational arithmetic only.*

**Objects.** `R₅ = ℤ[i][1/5]`; `U₅ = {iᵏwᵐ}` with `w = (3+4i)/5 = π/π̄`, `π = 2+i`; the band `B₄ = [1/4, 3/4]` mod 1;
`Θ₄(U₅) = {θ ∈ Hom(R₅, ℝ/ℤ) : θ(U₅) ⊆ B₄}`. `T + A` = torsion characters plus archimedean ones `λ_e(x) = Re(ē x)`.

## C0 — prediction, written before any computation (2026-09-25)

- **Is `Θ₄(U₅) ⊆ T + A`?** Probability **0.40** that it is (one prime suffices); **0.60** that a non-`T + A` point exists.
- *Why not lower:* a two-minute hand check (not a computation) of the slice `θ₂ + (a character trivial on ℤ[i] with
  zero π-component)` shows it rigid: one new 5-adic digit `t ∈ (1/5)ℤ/ℤ` shifts the pair `(θ(wᵐ), θ(iwᵐ))` by `(t, 2t)`,
  and no nonzero `t` keeps both within 1/4 of 0, so near the parity point the digit tree does not branch at all. The
  advisor's `5·(1/2)² = 1.25` assumes the base pair uniform; it is not.
- *Why not higher:* the rational pattern's four-colour cell set is larger than FS73-T40's three-colour one (order-3
  points become discs of radius 1/12; order-4 and mixed order-6 torsion points enter), so cell-to-cell transitions with
  nonzero digits can exist, and one branching strongly connected component is enough for a Cantor family.
- *Side predictions:* the four-colour cell list per period `5ℤ²` has 10–40 cells; the torsion part of `Θ₄(U₅)` is finite.

## C1 — the positive control: FS-81's three-colour result, reproduced on two code paths (2026-09-25)

Two exact models of the same set, written for this stage (each imports only the frozen clipping routine of
`tools/fs81_verify_thetaR.py`; nothing frozen is edited):
- **the L-layer model** (FS81-C-verification §1.2's): layers `wᵐL`, `L = (1/5)ℤ[i]`, states `μ ∈ ℂ/5ℤ[i]` in the cells of
  the rational pattern (`tools/fs89_s0b_cells.py`, `tools/fs89_s0b_graph.py`, `data/fs89/s0b/count_words.py`);
- **the orbit model** (derived in §1 below): layers `wᵐℤ[i]`, states `e ∈ ℂ/ℤ[i]` in the square `Q = [lo, hi]²`, one step
  `e' − w̄e ∈ π⁻¹ℤ[i]` (`tools/fs89_s0b_orbits.py`).

| check (band `[1/3, 2/3]`) | result | file |
|---|---|---|
| cells of the rational pattern | exactly FS73-T40: the 12-gon `c0 + D0` and the four points `c0 + (±5/6, ±5/6)` | `data/fs89/s0b/cells-k3.txt` |
| realizable L-layer words of length `n = 1..12` | 5 at every length (FS81-T8(a)) | `layerL-words-k3.txt` |
| orbit-model pieces at depth `K = 0..8` | 5 at every `K ≥ 1`: one polygon containing the centre `(1/2, 1/2)` and the four points `(a/3, b/3)`, `a, b ∈ {1, 2}` — the parity character's shrinking polygon (`→` the disc `|e − (1+i)/2| ≤ 1/6`) and `X₃` (FS81-T3) | `control-k3-none.txt` |
| planted fault 1: the forward digit lattice `π̄⁻¹ℤ[i]` in place of `π⁻¹ℤ[i]` | red: 0 pieces from `K = 1` (the parity character is no longer an orbit) | `control-k3-lattice-pibar.txt` |
| planted fault 2: the band's top edge moved in by 1/15 | red: one polygon, no `X₃` points | `control-k3-band-hi.txt` |
| cell-tool plants (drop the direction `(3+4i)/5`; band top −1/15) | red, each | (run log, this record) |

**The two models agree exactly at four colours too**: the number of orbit-model pieces at depth `K` equals the number of
L-layer words of length `2K − 1` — 29, 157, 593, 2017, 6349, 19113 at `K = 1..6` — and so do the point pieces (16, 88,
324, 1032, 3104, 8924). Both count the connected components of FS81-T8's `Θ_K` (characters of `5^{−K}ℤ[i]` with the band
on `|m| ≤ K`), by different layerings; the agreement is the cross-check.

**Four-colour depth table** (orbit model, `data/fs89/s0b/orbit-counts-k4.txt`; cells `data/fs89/s0b/cells-k4.txt`):

| depth K | pieces of `Θ_K` | point pieces | polygon pieces | ratio to K−1 |
|---|---|---|---|---|
| 1 | 29 | 16 | 13 | — |
| 2 | 157 | 88 | 69 | 5.41 |
| 3 | 593 | 324 | 269 | 3.78 |
| 4 | 2017 | 1032 | 985 | 3.40 |
| 5 | 6349 | 3104 | 3245 | 3.15 |
| 6 | 19113 | 8924 | 10189 | 3.01 |

At three colours the count is constant (5); at four it grows (about 1.7 per layer at `K = 6`, two layers per depth). The
rational pattern's four-colour cell list: 29 cells per period `5ℤ²` — one 12-gon (the parity cell), four hexagons (the
order-3 characters `X₃`, fattened), eight quadrilaterals, sixteen points (eight are the order-4 torsion characters
`(a + bi)/4`-type, in four 2-cycles; eight have `5 | ` the order of their restriction to `L`, so no torsion character
restricts to them). *Side prediction scored:* 10–40 cells — met (29).

## §1 — The orbit model (derivation; S0B-T1)

*Notation.* `⟨e, x⟩ = Re(ē x)`; `π = 2 + i`, `π̄ = 2 − i`, `w = π/π̄`; `A_m := wᵐℤ[i] = π^m π̄^{−m}ℤ[i]` (a fractional ideal);
`Q_β := [β, 1 − β]²`, and `Q := Q_{1/4}` at four colours.

1. *Layers.* `θ|_{A_m}` is `y ↦ ⟨e_m, w^{−m}y⟩` for a unique `e_m ∈ ℂ/ℤ[i]` (the dual of `ℤ[i]` under `⟨,⟩` is `ℤ[i]`).
2. *Compatibility.* `A_m ∩ A_{m+1} = wᵐπℤ[i]` (exponents `(m+1, −m)`). On `x = wᵐπy`, the two layers read `⟨π̄e_m, y⟩` and
   `⟨πe_{m+1}, y⟩`; they agree for all `y ∈ ℤ[i]` iff `e_{m+1} − w̄e_m ∈ π⁻¹ℤ[i]`. The relation is well defined on `ℂ/ℤ[i]`,
   because `w̄ℤ[i] = π̄π⁻¹ℤ[i] ⊆ π⁻¹ℤ[i]`.
3. *Gluing.* The family `{A_m}` is an interval family: `(A_{−M} + ⋯ + A_M) ∩ A_{M+1} = π^{M+1}π̄^{−M} = A_M ∩ A_{M+1}`, and
   symmetrically on the left. So a sequence that is compatible on consecutive layers glues to a unique character of
   `Σ_{|m|≤M} A_m = 5^{−M}ℤ[i]`, for every `M`, and hence to a unique character of `R₅`.
4. *Band.* `θ(iᵏwᵐ) = ⟨e_m, iᵏ⟩`. So `θ(±wᵐ) ∈ B` iff `Re e_m ∈ B` mod 1, and `θ(±iwᵐ) ∈ B` iff `Im e_m ∈ B` mod 1. The
   square `Q_β` has side `< 1`, so each class has a unique lift into it.

**S0B-T1.** `Θ_β(U₅) ≅ {(e_m)_{m∈ℤ} : e_m ∈ Q_β, e_{m+1} − w̄e_m ∈ π⁻¹ℤ[i]}`. Level `K` (the window `|m| ≤ K`) is FS81-T8's
`Θ_K`. A character is a forward orbit and a backward orbit that share `e₀`, with no other constraint between them.

- This is FS81-C-verification §1.2's argument with the layer `ℤ[i]` in place of `L = (1/5)ℤ[i]`.
- It is checked against that argument's model: the piece counts agree at every depth (C1).
- It is also checked against the adelic formula `θ(x) = ⟨e, x⟩ − {(β₂x₁ + β₁x₂)/2}_5`, value for value at `|m| ≤ 25`
  (`tools/fs89_s0b_heteroclinic.py`, "formula A = orbit B").

## §2 — Leaves: what `T + A` is in this model (S0B-T2)

- For a torsion `τ` (order prime to 5), the orbit of `τ + λ_d` is `e_m = c_τ(m) + w̄ᵐd`, with `c_τ(m)` periodic: a **leaf**.
- `τ + λ_d ∈ Θ_β` iff `|d| ≤ r_τ`, the **margin**: the least distance from a value of `τ` on `U₅` to the edge of the band.
  - ⟸: `|λ_d(u)| ≤ |d|`.
  - ⟹: each value class of `τ` on `U₅` is a coset `{iᵏwᵐ : m ≡ m₀ mod P}`, which is dense on the circle.
- So each leaf meets `Q_β` in a disc `D_τ` of radius `r_τ` about `c_τ(m)`, rotating with `m`.
- The leaves at four colours:
  - **parity** `θ₂`: centre `P = (1+i)/2`, constant, radius **1/4**;
  - **`X₃`**: centres `C ∈ {(a+bi)/3 : a, b ∈ {1,2}}`, cycled by `C ↦ lift(iC)` (`lift(iC) − P = i(C − P)`), radius **1/12**;
  - **order 4 and order 8**: radius 0.
- In adelic terms (`R̂₅ = (ℂ × ℚ_π × ℚ_π̄)/Δ(R₅)`, normalised to `(e; b₊, b₋)` with `b₊ ∈ ℤ_π`, `b₋ ∈ ℤ_π̄`):
  - `T + A = {(e; q, q) : q ∈ ℚ(i)}`, i.e. **the two 5-adic components are the images of one rational**;
  - the forward layers (`m ≥ 1`) read only `(e, b₊)`, and the backward ones only `(e, b₋)`;
  - so a forward orbit from `e₀` is a choice of `b₊`, and a backward one a choice of `b₋`.

**Criterion (derived).** `Θ_β(U₅) ⊆ T + A` forces the leaf discs to be pairwise disjoint in `Q_β`. If two different leaves
pass through one `e₀`, pairing the forward half of one with the backward half of the other is a character (S0B-T1), and it
is not `T + A` (S0B-T4).
- *At three colours* the discs are disjoint: the parity disc has radius 1/6, and the `X₃` points lie at distance `√2/6 ≈
  0.2357 > 1/6`. This is why FS81-T3 holds.
- *At four colours* they are not: `√2/6 < 1/4`, so **the four order-3 characters lie inside the parity character's disc.**
- *Threshold, for this pair of leaves only:* the parity and `X₃` discs meet iff `(1/2 − β) + (1/3 − β) ≥ √2/6`, i.e.
  `β ≤ (5 − √2)/12 ≈ 0.2988`. The other pairs of leaves were not examined.

## §3 — Answer (a): `Θ₄(U₅) ⊄ T + A`. The escaping points have a non-trivial 5-adic part.

**S0B-T3 (the heteroclinic characters).** Take `q = (1+i)/3` and `P = (1+i)/2`, and any `e` with `|e − q| ≤ 1/12` and
`|e − P| ≤ 1/4`. The lens is nonempty since `√2/6 < 1/3`; it contains `e = q` itself. Then
`θ* := (e; b₊ = q, b₋ = P)` lies in `Θ₄(U₅)`.
- On the forward layers `θ* = χ + λ_{e−q}`, and on the backward layers `θ* = θ₂ + λ_{e−P}`.
- Proof: S0B-T1, with the two leaves' halves glued at `e₀ = e`.
- Checked exactly by `tools/fs89_s0b_heteroclinic.py` (`data/fs89/s0b/heteroclinic-check.txt`):
  - at four values of `e`, including `e = q`, the band holds on `iᵏwᵐ` for `|m| ≤ 25`;
  - the adelic formula equals the orbit description value for value;
  - `θ*` equals `χ + λ` forward and `θ₂ + λ` backward;
  - three controls outside the lens fail where predicted: outside the parity disc they fail at `m = −11`, and outside the
    order-3 disc at `m = +11`.

**S0B-T4 (not `T + A`).** Suppose a character equals `τ₁ + λ_{c₁}` on every forward layer and `τ₂ + λ_{c₂}` on every
backward layer, with `τ₁ ≠ τ₂` torsion. Then it is not in `T + A`.
- Suppose `θ = τ + λ_c`, with `N` a common order.
- The forward layers sum to `S₊ = ℤ[i][1/π̄] = ⋃_K π̄^{−K}ℤ[i]`. There `λ_{N(c−c₁)} = 0`, so `N(c − c₁) ∈ ⋂_K π^Kℤ[i] = 0`,
  and `τ = τ₁` on `S₊ ⊇ ℤ[i]`.
- Torsion characters of order prime to 5 are determined on `ℤ[i]` (`R₅` is 5-divisible), so `τ = τ₁`.
- Likewise `τ = τ₂` on the backward side. So `τ₁ = τ₂`, a contradiction. ∎
- So `θ*` escapes. Its 5-adic data are two *different* rationals, `q` at π and `P` at π̄.

**S0B-T5 (the switching family: uncountable, with irrational 5-adic parts).** From `e₀ = q`, the forward orbits form a
perfect tree. So `Θ₄(U₅)` contains continuum many characters with layer-0 value `q` and backward half `χ`'s, pairwise
distinct. At most countably many are `T + A` (each leaf meets that fibre in countably many characters). Hence continuum
many escape, and all but countably many of those have `b₊ ∉ ℚ(i)`. The fibre `{b₊}` is compact and uncountable, so it
contains a Cantor set.

Proof. The construction:
1. *Switching is local.* At a common point of a parity-leaf orbit and an `X₃` disc, or the reverse, continuing on the
   other leaf is an orbit. The step checks are `P − w̄P = (−1+3i)/5 ∈ π⁻¹ℤ[i]` and `(i − w̄)C ∈ π⁻¹ℤ[i]` (via
   `−1 + 3i = π̄(−1+i)`).
2. *Recurrence.* `w̄` and `w̄/i` are not roots of unity. So on the parity leaf with displacement `ρ ∈ (√2/6 − 1/12, 1/4]`,
   the times at which the point lies strictly inside some `X₃` disc form an infinite set; the target arcs are open and
   nonempty. On an `X₃` leaf with `|δ| < 1/12`, the times at which it lies strictly inside the parity disc are infinite:
   `|(C−P) + (w̄/i)ᵐδ| < 1/4` holds on an open arc containing the antiparallel direction. At `δ = 0` it holds at every time.
3. *Invariance.* Switching back gives `ρ ∈ [√2/6 − |δ|, 1/4)`, and switching in gives `|δ| < 1/12`. So stage 2 applies
   again.
4. *Branching.* Two continuations from a common point differ at the next step by `(w̄ − i)(C − P) ≠ 0`.

So each strictly increasing sequence of switching times, alternating in direction and chosen among infinitely many at each
stage, gives a distinct orbit. ∎

- Exact prefixes: `tools/fs89_s0b_switching.py` (`data/fs89/s0b/switching-prefixes.txt`) runs three policies for 60 steps,
  with every step checked exactly. The policies make 29, 16 and 10 switches, and the orbits separate at times 1–2.
  Switching windows come about every 2–3 steps.

**What the escaping points are, exactly.** In the adelic coordinates, `T + A` is the set with `(b₊, b₋) ∈ Δ(ℚ(i))`. Every
escaping point found has 5-adic data off that diagonal. There are two kinds:
- *rational-heteroclinic*: `b₊`, `b₋` rational but different (S0B-T3). These form a countable union of 2-dimensional
  lens-shaped leaf pieces.
- *irrational*: `b₊` (or `b₋`) not in `ℚ(i)`, a Cantor set of them over each such `e₀` (S0B-T5).

The advisor's heuristic is confirmed in kind: a branching family exists at four colours. The mechanism is not the average
digit count, though. It is the geometry of two leaves' archimedean discs overlapping. **Scope:** this is about `ℤ[U₅]` alone.
It shows one prime does not suffice. It does **not** refute the rational statement over `ℤ[U_ℚ]` with every split prime
inverted (§6 derives what one more prime does).

## §4 — Answer (b): the torsion points of `Θ₄(U₅)` have many orders — 12 below 130 — against FS-81's bound `N = 6`

This is an exact finite list of the primitive band characters of `ℤ[i]/N`, `5 ∤ N`, `N ≤ 130`
(`data/fs89/s0b/torsion_points.py`, `torsion-points-k4-N130.txt`). There are **145 characters, of 12 orders**. The
columns: the order `N`; `|U₅ mod N|`; the count; the margin.

| N | `\|U₅ mod N\|` | count | margin (disc radius) |
|---|---|---|---|
| 2 | 2 | 1 | 1/4 |
| 3 | 4 | 4 | 1/12 |
| 4 | 4 | 8 | 0 |
| 7 | 8 | 8 | 1/28 |
| 8 | 8 | 8 | 0 |
| 22 | 12 | 12 | 1/44 |
| 26 | 24 | 12 | 1/52 |
| 31 | 16 | 16 | 1/124 |
| 41 | 20 | 20 | 7/164 |
| 48 | 16 | 16 | 1/48 |
| 76 | 20 | 20 | 3/76 |
| 79 | 20 | 20 | 9/316 |

- Every order found is one where `U₅ mod N` is small (at most 24), i.e. where `w` has small multiplicative order mod `N`.
- *Reading (one mind, not proved):* the torsion orders are unbounded, at the primes dividing the norms of `Φ_k(w)`. This
  agrees with the gluing verifier's reading as relayed by the owner.
  - The mechanism: for fixed `k`, a band character exists at a prime `p` when roughly `p·2^{−2k} ≳ 1`.
  - Killing test: a proof that no band character exists at any order above some bound; or the list stopping.
- *On the cell list:* the eight order-4 point cells are torsion (four 2-cycles, margin 0). The eight point cells whose
  restriction to `L` has order divisible by 5 are not torsion. Of the depth-1 point pieces:
  - the midpoints `(1/4, 1/2)` etc. each carry one word;
  - the corners `(1/4, 1/4)` etc. each carry three words, with different forward and backward digits;
  - so several leaves meet at each corner (§2's criterion, visible at depth 1).

## §5 — Depth by depth, and the stop rule

- The depth table in C1 counts the pieces of `Θ_K` for `K ≤ 6`.
- At every depth, exactly one polygon contains the parity centre (the parity leaf's shrinking polygon).
- At every depth, the pieces containing `θ*`'s restriction and the switching prefixes exist, because those characters lie in
  the inverse limit.

**The stop rule fired on its second branch:** a non-`T + A` family is exhibited, with a proof (S0B-T3–T5) that it persists
to every depth. Deeper levels were not computed: the derivation makes them unnecessary.

## §6 — Reading: dimension, self-similarity, and a second prime

- **Dimension.**
  - Over each `e₀` in the switching region, the fibre of `b₊` is a Cantor set in `ℤ₅`.
  - Its dimension is positive: switching windows recur at positive density, so the number of admissible length-`n`
    prefixes grows exponentially [derived, sketch].
  - The measured count of all pieces grows by about ×3.0 per depth at `K = 6`, i.e. about 1.73 per layer, and falling. So
    the entropy is at most about `log 1.7`, and the fibre dimension at most about `log₅ 1.7 ≈ 0.33` [measured bound, not a
    value].
  - As a whole, `Θ₄(U₅)` is: 2-real-dimensional leaf discs, plus 2-dimensional heteroclinic lenses, plus a Cantor bundle over
    an open set of `e₀`.
- **Self-similarity.**
  - The set is invariant under the shift `θ ↦ θ∘w`, and under conjugation (`b₊ ↔ b₋`, `e ↦ ē`).
  - Its combinatorics is a coding of irrational rotations (`w̄` and `w̄/i`) with free choices on open windows: a
    rotation-coded, sofic-like system over a finite leaf graph. It is not a self-similar set in the IFS sense. The leaf graph
    is infinite if the torsion orders are unbounded (§4).
- **A second prime, 13** (derived, not computed). Let `w₁₃ = (5+12i)/13` and `R' = ℤ[i][1/65]`.
  - *S0B-T6 (derived):* **no rational heteroclinic extends.** Let `Θ ∈ Θ₄(U')` restrict on `R₅` to a heteroclinic between
    torsion `τ₁ ≠ τ₂` with `τ₁ − τ₂` of order prime to 13 (the case of `θ*`). Then `Θ∘w₁₃ⁿ|_{R₅}` is heteroclinic between
    `T₁⁽ⁿ⁾` and `T₂⁽ⁿ⁾`, with `T₁⁽ⁿ⁾ − T₂⁽ⁿ⁾` the character of `w̄₁₃ⁿ(q₁ − q₂)` minus its 13-principal part. Its 13-part has
    exact order `13^{|n|}`, so one of `T₁⁽ⁿ⁾`, `T₂⁽ⁿ⁾` has 13-order at least `13^{|n|}` over a prime-to-13 part of bounded
    order.
  - A band torsion character of that shape has bounded 13-order. The reason: the image of `⟨w₅⟩` contains
    `1 + π₁₃^{v'}ℤ[i]/π₁₃^k` on the kernel of the prime-to-13 part. So the 13-part sweeps every multiple of `13^{−(k−v')}`,
    which leaves the band once `k > v'`. Here `w₅ ≡ 2 (mod π₁₃)`, of order 12.
  - So `|n| ≤ v'`, a contradiction for large `n`. ∎ The order-26 band characters of §4 are consistent: `k = 1` is allowed.
  - *Reading, not derived:* 13 also kills the infinitely-switching (irrational) family. Sketch:
    - along a long parity stretch of row 0, row `n = Θ∘w₁₃ⁿ|_{R₅}` equals `θ₂ + λ_{w̄₁₃ⁿc}` up to a 13-torsion character of
      bounded order (long stretches force it);
    - so row `n` must switch where row 0 does;
    - but its displacement is rotated by `w̄₁₃ⁿ`, which is dense, so for some `n` the switch is geometrically impossible.
    - Killing test: an exact 2-D orbit window (`e_{m,n}`, both steps) at depth `K` in both directions whose piece count grows
      like the 1-D one, or an explicit 2-D switching array.
  - This is the Furstenberg–Berend shape the advisor named: the second prime's unit acts at 5 as an isometry with dense orbits
    and breaks the one-parameter freedom that the single rotation `w̄` leaves.

## §7 — C0 scored

- Predicted `P(⊆ T + A) = 0.40`. The outcome is **no**, so the 0.60 side won.
- The hand check behind the prediction was right about what it looked at: near the parity *point* the digit tree does not
  branch.
- It missed the mechanism: other leaves' discs *reaching into* the parity disc. The branching lives at the disc's edge (a
  radius of about 0.24), not at its centre.
- Side predictions: 29 cells, inside the predicted 10–40 (met). "The torsion part is finite": **lost** (§4: 12 orders below
  130, and a reading that they are unbounded).

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| S0B-T1 | `Θ_β(U₅)` ≅ bi-infinite orbits in `Q_β` with `e_{m+1} − w̄e_m ∈ π⁻¹ℤ[i]` (layers `wᵐℤ[i]`) | hand; tools exact (two models agree to depth 6; adelic formula agrees) | §1 |
| S0B-T2 | leaves: `τ + λ_d ∈ Θ_β` iff `|d| ≤` margin; `T + A` = diagonal-rational 5-adic data; forward reads `b₊`, backward `b₋` | hand | §2 |
| S0B-T3 | `θ* = (e; q, P)`, `e` in the lens, lies in `Θ₄(U₅)` | hand + tools exact | §3 |
| S0B-T4 | forward `τ₁ + λ`, backward `τ₂ + λ`, `τ₁ ≠ τ₂` ⟹ not `T + A` | hand | §3 |
| S0B-T5 | from `e₀ = q` the forward orbits form a perfect tree; continuum many non-`T + A` points, a Cantor fibre of irrational `b₊` | hand; exact prefixes | §3 |
| S0B-T6 | a second prime (13) kills every rational heteroclinic whose torsion difference is prime to 13 | derived (one mind) | §6 |
| S0B-C1 | FS81-T3/T8 reproduced on two exact code paths at depth ≤ 8 (three colours), planted faults firing | tools exact | C1 |
| S0B-L4 | the band torsion characters of order ≤ 130: 145 characters, 12 orders (2, 3, 4, 7, 8, 22, 26, 31, 41, 48, 76, 79) | tools exact (finite list) | §4 |

## Would-have-searched-here log

- **Torsion list (§4).** A finite exact enumeration of the characters of `ℤ[i]/N`, one fixed set per `N ≤ 130`. It is not a
  search for a witness. It is logged here because it is a loop over orders; it was kept small (under a second) and is
  labelled a measurement.
- **Switching prefixes.** Instead of searching for long orbits, three fixed policies ("switch at the j-th window") were
  run and every step checked. The perfect tree itself is proved by hand (S0B-T5).
- **Deeper depths.** It would have been tempting to push the depth table to `K = 8–10` to "see" the survivors. I stopped at
  `K = 6`, because the derivation answers the question at every depth.
