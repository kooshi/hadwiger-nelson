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
