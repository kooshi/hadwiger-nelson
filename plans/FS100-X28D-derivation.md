# FS100-X28D — how much of the complex-place case of `χ(F²) ≥ min(L(F), 5)` is real

*Job X28D of the 2026-09-26 ×2×3 crunch (brief `data/crunch-2026-09-26-x2x3/briefs/X28D-complex-place-scope.md`, with
`STANDING-RULES.md`). de Bruijn, Opus 5.5, one mind. Working files `data/fs100/x28d/`; exact checks `tools/x28d_check.py`.*

Conventions (as in `plans/FS100-X23D-derivation.md` §1): `F ⊆ ℝ` a number field, `L = F(i)`; a finite place `v` of `F` is
**stable** iff it does not split in `L/F`; its target is `Γ_q` (odd `v`, inert, residue `𝔽_q`, `q ≡ 3 (mod 4)`), `U_Q` (dyadic,
inert, `Q = N v`) or a 2-colourable graph (dyadic, ramified: FS54-T2 (b)); `L(F)` is the least chromatic number of a target.

## Theorems this phase proved

(filled at stage 3)

## Would have searched here

(filled as it happens)

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
cube roots four non-real ones). By CP-1's list only places above 2, 3, 7 can carry a target of `χ ≤ 4` (G59's rule; row 117):
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
