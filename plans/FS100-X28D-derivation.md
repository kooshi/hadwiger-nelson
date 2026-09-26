# FS100-X28D — how much of the complex-place case of `χ(F²) ≥ min(L(F), 5)` is real

*Job X28D of the 2026-09-26 ×2×3 crunch (brief `data/crunch-2026-09-26-x2x3/briefs/X28D-complex-place-scope.md`, with
`STANDING-RULES.md`). de Bruijn, Opus 5.5, one mind. Working files `data/fs100/x28d/`; exact checks `tools/x28d_check.py`.*

Conventions (as in `plans/FS100-X23D-derivation.md` §1): `F ⊆ ℝ` a number field, `L = F(i)`; a finite place `v` of `F` is
**stable** iff it does not split in `L/F`; its target is `Γ_q` (odd `v`, inert, residue `𝔽_q`, `q ≡ 3 (mod 4)`), `U_Q` (dyadic,
inert, `Q = N v`) or a 2-colourable graph (dyadic, ramified: FS54-T2 (b)); `L(F)` is the least chromatic number of a target.

## Theorems this phase proved

| id | statement | grade | address |
|---|---|---|---|
| X28D-P | odd local degree preserves *ramified* in `F_v(i)/F_v` at a dyadic place (closes FS54-T2's parity step, whose text says "local degree" where the proof needs ramification indices) | hand | Stage 1 |
| X28D-S | `L(E) ≥ L(F)` for every finite extension `E ⊇ F` of real number fields: stable places of `E` lie over stable places of `F`, and each target of `E` contains (induced) or out-colours one of `F` | hand | §2.1 |
| X28D-CP1 | CP-1 TRUE: a real number field with `L ≥ 3` has even degree; with a non-real embedding and `L ≥ 5`, even degree `≥ 4` | hand | §2.2 |
| X28D-CP2 | CP-2 FALSE: `F = ℚ(√23, ∛2)`, signature `(2, 2)`, `L(F) = 5`; its totally real subfields `ℚ`, `ℚ(√23)` have `L = 2, 4` | hand + tools exact | §2.3; `tools/x28d_check.py` |
| X28D-CP3 | CP-3 FALSE: `L` rises `4 → 5` in the cubic step `ℚ(√23) ⊂ ℚ(√23, ∛2)`; `χ` rises `3 → 4` unconditionally in the totally real cubic step `ℚ(√3) ⊂ ℚ(√3, 2cos(2π/7))` | hand + tools exact (the `χ` half rests on row 99 and G56's `U₈`) | §3.1 |
| X28D-ODD | the true core of CP-3: an odd-degree extension preserves `L = 2` and `χ = 2` (FS54-T2 relative to any base) | hand | §3.2 |
| X28D-CUBE | cube roots are impotent exactly where `μ₃` is absent: for `E = F(∛m)` and a stable place `v` with `ζ₃ ∉ F_v`, some `w | v` has `f(w|v) = 1` and odd local degree, so `w`'s target is `v`'s; hence `L(F(∛m)) = L(F)` whenever some place attaining `L(F)` has `ζ₃ ∉ F_v` (residue `𝔽_q`, `q ≡ 2 mod 3`; `𝔽₃` without `ζ₃`; dyadic of odd residue degree), and then `χ(F(∛m)²) = χ(F²)` unconditionally when `L(F) ≤ 4` (row 99) | hand | §3.2 |

## Would have searched here

- Stage 2: a PARI `nflist` sweep over `(2,1)` quartics / `(2,2)` sextics for `L ≥ 5` with small subfields — not run; the field was
  built from local conditions and PARI only checked it (§2.3).
- Stage 3: a sweep over cubic extensions of `ℚ(√3)` for one that kills the `𝔽₃` place — not run; the cyclic cubic of conductor 7 was
  chosen because 3 has order 3 in `(ℤ/7)ˣ/{±1}` (inert), and the pure cubics were excluded by X28D-CUBE before any computation.

## Stage 1 — SAVED

**Quotation check** (standing rule 5), each against its source:

| brief's quotation | source | verdict |
|---|---|---|
| FS54-T2: "the 2-adic trichotomy (split/ramified/inert at a prime above 2) and its corollary: every odd-degree real number field is 2-colourable" | `LEDGER.md` § B row FS54-T2 (line 358) | verbatim ✓ |
| "`plans/FS54-derivation.md` T2; `[Moorhouse2010]` §7.1" | `LEDGER.md` § B row FS54-T2, prior-art column "hand; corollary is Moorhouse2010 §7.1" | ✓ |
| X29C's ruling: "an independence-ratio bound survives removing edges, so the complex place's factor is bounded by its circle subgraph's `m₁`" (the brief's paraphrase, not a quotation) | `plans/FS100-derivation.md` FS100-CX: "restricting the extended colouring to its compact real form … turns the factor into `UD(ℝ²)` … ratio `m₁`, and the count runs unchanged (dropping edges is the safe direction)" and "which the restriction answers by monotonicity of the ratio under removing edges" | faithful ✓ |
| X25B-G1 | `plans/FS100-X25B-derivation.md` l. 99: "A real field with a complex place `w` has an archimedean split factor `Cay(ℂ², {(a, a⁻¹)})` in `G_S`. Its ratio is not derived here and is not among the named inputs" | the brief's "disputed by X25B (`X25B-G1`)" is faithful ✓ |
| X23D §3.3 | `plans/FS100-X23D-derivation.md` §3.3: "For every real number field `F` outside row 100's exception, given MR(F) (and, with a complex place, MR's own scope there): `χ(F²) ≥ min(L(F), 5)`" | the brief drops "outside row 100's exception" and "MR's own scope there"; neither changes CP-1–CP-3, logged |

**FS54-T2's parity step, checked.** The source (`plans/FS54-derivation.md` l. 55–57) reads: "some prime above 2 has odd local
degree, so `i ∉ F_𝔭` (`ℚ₂(i)/ℚ₂` is a ramified quadratic extension, hence has even local degree over any field it sits inside
with odd degree already forced), giving case (b)". As written, "`i ∉ F_𝔭`" gives only *not split*; case (b) is *ramified*, and the
parenthetical's "even local degree" does not by itself exclude *inert*. **The step closes with ramification indices** [hand]:
`ℚ₂(i) ⊆ F_𝔭(i)` and `ℚ₂(i)/ℚ₂` is ramified, so `e(F_𝔭(i)/ℚ₂)` is even; `e(F_𝔭/ℚ₂)` divides the odd `[F_𝔭:ℚ₂]`; so
`e(F_𝔭(i)/F_𝔭) = 2`. The corollary is TRUE; the wording is short one word ("ramification index" for "local degree"). Correction
owed (wording only) to `plans/FS54-derivation.md` T2. Used below as **Lemma P**: *for any extension `E_w/F_v` of odd degree with
`F_v(i)/F_v` ramified, `E_w(i)/E_w` is ramified* (same proof with `F_v` in place of `ℚ₂`).

**C0 probabilities** (registered before stage 2's exact checks; the derivations below were sketched first, so these are not blind):

| claim | TRUE | FALSE | GAP | why |
|---|---|---|---|---|
| CP-1 | 0.95 | 0.03 | 0.02 | odd degree ⟹ a ramified dyadic stable place ⟹ `L = 2`; a real quadratic field is totally real |
| CP-2 | 0.15 | 0.75 | 0.10 | a cube root can raise a residue degree at an `𝔽₇` place (`7 ≡ 1 mod 3`), so `L` can rise to 5 in a cubic step over a totally real field with `L = 4` |
| CP-3 | 0.20 | 0.70 | 0.10 | `L` is monotone upward in any extension, but an odd-degree step can raise every minimising residue field `𝔽_q` to `𝔽_{q³}` |

## Stage 2 — SAVED

### 2.1 Two lemmas used throughout [hand]

**Lemma S (stable places lie over stable places, and targets only grow).** Let `E/F` be a finite extension of real number fields,
`w | v` finite places. (i) If `v` splits in `F(i)/F` then `w` splits in `E(i)/E` (`i ∈ F_v ⊆ E_w`). (ii) If `v` is inert with residue
`𝔽_Q` (odd or dyadic), then `w` is stable iff `f(w|v)` is odd, and then `w` is inert with residue `𝔽_{Q^f}` (`E_w(i) ⊇` the unramified
quadratic of `F_v` iff `f(w|v)` is even) and its target `Γ_{Q^f}` or `U_{Q^f}` contains `v`'s target as an **induced** subgraph
(`𝔽_{Q²} ⊆ 𝔽_{Q^{2f}}` and, for `f` odd, `x^{Q^f+1} = x^{Q+1}` on `𝔽_{Q²}`, so `μ_{Q^f+1} ∩ 𝔽_{Q²} = μ_{Q+1}`). (iii) If `v` is dyadic
ramified, `w`'s target (if `w` is stable) has `χ ≥ 2 = χ(v`'s target`)`. **Hence `L(E) ≥ L(F)` for every finite extension `E ⊇ F`**
(every target of `E` contains, or out-colours, a target of `F`; a field with no stable place has `L = ∞` and stays so by (i)).

**Lemma P** (stage 1): odd local degree preserves *ramified* at a dyadic place. With (ii): **odd local degree preserves *stable***.

### 2.2 CP-1 — TRUE [hand]

*Proof.* Let `F` be real with `L(F) ≥ 5`. If `[F:ℚ]` were odd, the local degrees above 2 sum to an odd number, so some `F_𝔭`, `𝔭 | 2`,
has odd degree over `ℚ₂`, and Lemma P (with `ℚ₂(i)/ℚ₂` ramified) makes `𝔭` ramified in `F(i)`: a target of `χ ≤ 2` (FS54-T2 (b)),
so `L(F) = 2`. So `[F:ℚ]` is even. Degree 2: a real quadratic field `ℚ(√d)`, `d > 0`, is totally real. So a real `F` with a non-real
embedding and `L(F) ≥ 5` has even degree `≥ 4`. ∎ *The non-real hypothesis is used only to exclude degree 2;* the parity half holds for
every real field with `L(F) ≥ 3`.

### 2.3 CP-2 — FALSE, with `F = ℚ(√23, ∛2)` [hand + tools exact]

**The construction** (derived, not searched): start from the totally real `ℚ(√23)`, whose only small targets are two `𝔽₇` places
(`L = 4`, `χ = 4`: row 73), and adjoin a cube root that is inert at 7 but cannot create a small target anywhere else.

*Hand proof that `L(F) = 5`.* `F = ℚ(√23)(∛2)` has degree 6, signature `(2, 2)` (the real `∛2` gives two real embeddings, the complex
cube roots four non-real ones). Only places above 2, 3, 7 can carry a target of `χ ≤ 4` (G59's rule: residue `𝔽₃`, `𝔽₇`, dyadic ramified or inert of norm `≤ 32`; row 117):
- **2:** `−23 ≡ 1 (mod 8)` is a square in `ℚ₂`, so `ℚ₂(√23) = ℚ₂(i)`; every completion of `F` above 2 contains `i`: **split**, no target.
- **3:** `(23/3) = (2/3) = −1`, so `ℚ(√23)` has one place above 3 with completion `ℚ₉ = ℚ₃(i)`; every place of `F` above it is split.
- **7:** `(23/7) = (2/7) = +1`, two places with completion `ℚ₇`; 2 is not a cube mod 7 (the cubes are `±1`) and `7 ∤ 6`, so
  `ℚ₇(∛2)` is the **unramified cubic**: each place of `F` above 7 has `f = 3`, residue `𝔽₃₄₃`, target `Γ₃₄₃` (`χ ≥ 7`: past Weil's
  `q = 98`, G56).
- Every other stable place of `F` lies over a stable place of `ℚ(√23)` (Lemma S (i)) at an odd `p ≡ 3 (mod 4)`, `p ≥ 11`, with target
  `⊇ Γ_p`, `χ ≥ 5`. And 11 attains 5: `(23/11) = +1`, `11 ≡ 2 (mod 3)` makes 2 a cube in `ℚ₁₁`, so `x³ − 2 = (x − a)·(irreducible
  quadratic)` over `ℚ₁₁` and a place with `f = 1`, residue `𝔽₁₁`, target `Γ₁₁` (`χ = 5`). **`L(F) = 5`.**

*Hand proof that no totally real subfield has `L ≥ 5`.* A quadratic subfield `ℚ(√e) ≠ ℚ(√23)` would put a biquadratic field (degree 4)
inside a sextic; a second cubic subfield would put `ℚ(∛2)`'s conjugate, hence `ζ₃`, inside `F`, or make a compositum of degree 9.
So the subfields are `ℚ, ℚ(√23), ℚ(∛2), F`; the totally real ones are `ℚ` (`L = 2`) and `ℚ(√23)` (`L = 4`). ∎

*Exact check* (`tools/x28d_check.py`, `data/fs100/x28d/check.out`, PARI 2.17, under a second): `F`'s polynomial
`x⁶ − 69x⁴ − 4x³ + 1587x² − 276x − 12163`, 2 real roots; dyadic `["split", e = 6, f = 1]`; above 3 `[e 3, f 2]` split; above 7 two places
`[1, 3, stable]`; above 11 two stable `[1, 1]`; small targets `[]`; `nfsubfields` returns exactly the four subfields above, the totally
real ones with small targets (`ℚ`: dyadic ramified, `𝔽₃`, `𝔽₇`; `ℚ(√23)`: two `𝔽₇`). **Plants, all fired for the named reason**
(`data/fs100/x28d/plant-*.out`, exit 1 each; the clean run exit 0): `--plant-sqrt7` (√7 for √23: an `𝔽₃` target appears),
`--plant-sqrt5` (√5: the dyadic place is no longer split), `--plant-real` (the totally real cubic `x³ − 3x + 1` for `∛2`: the field
is itself a totally real subfield with `L ≥ 5`, and the subfield assertion fires on it), `--plant-cube3` (stage 3's field).

**So CP-2 is FALSE.** *What it means for X23D-COR:* the complex-place case of `χ(F²) ≥ min(L(F), 5)` does **not** reduce to the totally
real case by monotonicity; at `ℚ(√23, ∛2)` it rests on FS100-CX (the restriction to the compact real form at the complex place,
X23D/X23V, answering X25B-G1) and on MR's scope at a complex place. Unconditionally `4 ≤ χ(F²) ≤ 5` there (`ℚ(√23) ⊆ F`, row 73;
`Γ₁₁`, row 52).

*Would have searched here (stage 2):* a PARI `nflist` sweep over signature-(2,1) quartics or `(2,2)` sextics for `L ≥ 5` with small
subfields — **not run**; the field was built from the local conditions (a totally real `L = 4` base whose only small targets sit at a
prime `q ≡ 1 (mod 3)`, plus a cube root that is a non-cube there), and PARI only checked it.

## Stage 3 — SAVED

### 3.1 CP-3 — FALSE [hand + tools exact]

**(a) `L` is not preserved: `ℚ(√23) ⊂ ℚ(√23, ∛2)`, degree 3, `L`: `4 → 5`** (§2.3). Given MR and FS100-COR at a complex place
(FS100-CX), `χ`: `4 → 5` as well; unconditionally only `4 ≤ χ ≤ 5` upstairs.

**(b) `χ` is not preserved, unconditionally, in a totally real cubic step: `F = ℚ(√3) ⊂ E = ℚ(√3, 2cos(2π/7))`.** `χ(F²) = 3`
(`[Fischer1990]` Thm 9, `d = 3 ≡ 3 (mod 12)`; row 99). In `E`: 3 is ramified in `ℚ(√3)` and inert in the cyclic cubic of conductor 7
(3 has order 3 in `(ℤ/7)ˣ/{±1}`), so `E` has one place above 3, `e = 2`, `f = 3`, residue `𝔽₂₇` — **no prime of residue field `𝔽₃`**.
`√3 ∈ E` gives triangles, so by the three-colour classification (row 99; G55's `√3` case: "`χ(F²) = 3 ⟺` some prime has residue field
`𝔽₃`") **`χ(E²) ≥ 4`**. Upper: the one dyadic place (`e = 2`, `f = 3`) is inert in `E(i)` with `Q = 8`, target `U₈`, 4-colourable
(G56, FS-54 [tools]), so `χ(E²) = L(E) = 4` (also row 99's `L ≤ 4` clause). *Exact check* (`data/fs100/x28d/check.out`): `E`'s
polynomial `x⁶ − 2x⁵ − 18x⁴ + 54x³ + 11x² − 142x + 97`, 6 real roots; above 3 `[[2, 3, stable]]`; dyadic `["inert", 2, 3]`; small
targets `["dyadic inert Q=8 (4)"]`; the base `ℚ(√3)` has `["dyadic inert Q=2 (4)", "stable F_3 place (3)"]`. Plant `--plant-cube3`
(`∛2` for `2cos(2π/7)`) fires: the `𝔽₃` place survives (`[[6, 1, stable]]`) — as X28D-CUBE (§3.2) predicts.

*Side finding, from the `--plant-real` output:* the **totally real** sextic `ℚ(√23, 2cos(2π/9))` has no target of `χ ≤ 4`
(`data/fs100/x28d/plant-real.out`: `small=[]`; 7 is inert in the cyclic cubic of conductor 9), so `L ≥ 5` there too: the rise
`4 → ≥ 5` in a cubic step over `ℚ(√23)` does not need a complex place. Not claimed beyond `L ≥ 5` (11 is inert in that cubic, so
its value of `L` was not read).

**Verdict: CP-3 FALSE**, on both halves, with an unconditional counterexample to the `χ` half.

### 3.2 What of "cube roots are impotent" is true [hand]

**X28D-ODD.** If `E/F` has odd degree and `L(F) = 2`, then `L(E) = χ(E²) = 2`. *Proof:* `L = 2` only at a dyadic ramified place `v`
(every other target has `χ ≥ 3`: G59's rule); the local degrees above `v` sum to `[E:F]`, odd, so some `w | v` has odd local
degree, and Lemma P keeps it ramified. ∎ With `F = ℚ` this is FS54-T2's corollary, and `ℚ(∛2)`'s plane is bipartite.

**X28D-CUBE.** Let `m ∈ F^×` be a non-cube, `E = F(∛m)`, `v` a stable place of `F` with `ζ₃ ∉ F_v`. Then some `w | v` has
`f(w|v) = 1` and odd local degree, so `w` is stable with `v`'s residue field and target. *Proof:* `E ⊗ F_v = F_v[x]/(x³ − m)`. If `m` is
a cube in `F_v`, a factor of degree 1 exists. If not, `F_v(∛m)` has degree 3; were `f = 3`, it would be unramified, hence Galois over
`F_v`, hence contain the ratio `ζ₃` of two roots, and `[F_v(ζ₃):F_v] ≤ 2` divides 3 — so `ζ₃ ∈ F_v`, contrary to hypothesis. So `f = 1`
and the local degree is 1 or 3; Lemma S (ii) and Lemma P finish. ∎ `ζ₃ ∉ F_v` holds at every odd place with residue `𝔽_q`,
`q ≡ 2 (mod 3)` (`𝔽₁₁`, `𝔽₂₃`, `𝔽₄₇`, …), at dyadic places of odd residue degree (`U₂`, `U₈`, `U₃₂`), and at a 3-adic place unless
`F_v ⊇ ℚ₃(√−3)`.
- **Corollary.** `L(F(∛m)) = L(F)` whenever some place attaining `L(F)` has `ζ₃ ∉ F_v`; then, by row 99, `χ(F(∛m)²) = χ(F²)`
  **unconditionally** when `L(F) ≤ 4`, and given MR and FS100-CX when `L(F) = 5`. E.g. every `ℚ(√d, ∛m)` with `d ≡ 3, 7 (mod 12)` whose
  `𝔽₃` place has `ζ₃ ∉ F_v` stays three-chromatic.
- **Where cube roots are potent:** only at places with `ζ₃ ∈ F_v` — residue `𝔽_q`, `q ≡ 1 (mod 3)`: **`𝔽₇`** (the four-colour target),
  **`𝔽₁₉`** (five), `U₄`, `U₁₆` (four) — and 3-adic places containing `√−3`. `ℚ(√23, ∛2)` is exactly this: its base's only small targets
  are `𝔽₇` places and 2 is a non-cube mod 7.

So Kooshi's recollection is right for `L = 2` (FS54-T2, any odd degree) and for pure cube roots at places without `ζ₃` (most of the
small targets: `𝔽₃` without `√−3`, `𝔽₁₁`, the dyadic `U₂`, `U₈`, `U₃₂`); it is false at `𝔽₇` and `𝔽₁₉`, and false for general cubic
extensions at every value of `L ≥ 3`.

### 3.3 Consequences for the complex-place case of FS100-COR

1. **The complex-place case is real and not reducible.** CP-2's field `ℚ(√23, ∛2)` has `L = 5`, a complex place, and no totally real
   subfield with `L ≥ 5`; its `χ ≥ 5` (given MR) needs FS100-CX. And by X28D-CUBE's potency list, the pure-cube-root route produces such
   fields exactly over bases whose small targets sit at `𝔽₇` / `𝔽₁₉` / `U₄` / `U₁₆`.
2. **How much is free.** By CP-1, complex-place fields with `L ≥ 5` have even degree `≥ 4`; odd-degree complex-place fields
   (`ℚ(∛2)`, any `F(∛m)` over an `L = 2` base) are bipartite and never enter COR's `L ≥ 5` clause. For `L ≤ 4` row 99 needs no MR at any
   field. So COR's complex-place content is exactly: even degree `≥ 4`, `L ≥ 5`, complex place — nonempty (CP-2, `L = 5`).
3. **Nothing here re-derives FS100-CX or MR at a complex place.** This job decides CP-1–CP-3 only.

### 3.4 Proposed edits (for the front-page lane; not made here)

- `LEDGER.md` § B: seven rows, X28D-P, S, CP1, CP2, CP3, ODD, CUBE, home `plans/FS100-X28D-derivation.md`.
- `plans/FS54-derivation.md` T2: "odd local degree … `i ∉ F_𝔭` … giving case (b)" — the step needs ramification indices (Stage 1);
  wording only, the corollary stands.
- FS100-COR's scope sentence (`plans/FS100-derivation.md`): record that the complex-place case is inhabited and not reducible by
  monotonicity (X28D-CP2), so FS100-CX is load-bearing there.
- G43's Do line already warns "a larger field can lose a prime its subfield had"; X28D-S is its monotone form (`L` rises, never falls,
  under extension) and X28D-CUBE says when a cube root is the step that loses it.

*Prior art:* every step is standard local algebraic number theory (unramified extensions are Galois; Kummer; ramification indices
multiply); the application to `L(F)` is this job's. No gate run (elementary; declared as a debt only if the owner wants one).
