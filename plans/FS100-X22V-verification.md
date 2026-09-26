# FS-100 — X22V: blind verification of list X22 (the type-(B) fields given MR, and SEL-k)

*Job X22V (wave 3 of the ×2×3 crunch, 2026-09-26), Coxeter, Opus 5.5, blind verifier. Brief
`data/crunch-2026-09-26-x2x3/briefs/X22V-type-B-verifier.md` with `STANDING-RULES.md`. Owner "main"; stop time moved by the owner to 12:50 UTC.
Working files `data/fs100/x22v/`; checks `tools/x22v_*.py`.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| X22V-C0 | over ℚ(√59), ℚ(√83), ℚ(√131) the unique dyadic place of `F` (`e = 2, f = 1`) is inert in `L = F(i)`, so none is a ramified stable dyadic place | [tools exact; controls ℚ(√5) ramified, ℚ(√167) split; plant fires] + [hand] | Stage 1 §1.3; `tools/x22v_c0.py`, `data/fs100/x22v/c0*.out` |

(Filled in at each stage.)

## Stage 1 — SAVED (the claims verbatim, quotation check, C-0, C0)

### 1.1 The claims, copied verbatim from `plans/CRUNCH-2026-09-26-x2x3-queue.md`

§7, first paragraph (lines 243–246):


---

## §7. Wave 3 — do the findings transfer to the other wanted posters? (planned 06:20; claim lists fixed 06:25, before any derivation)

List X22 (lines 285–304):

  depth) that implies 'Y has no CP five-colouring', and say whether any held result gives it: row 75 (five refused at 23 at every level), row 71
  (five refused at 43 at level one), five-colour bounds on `m₁`-type densities of `ℝ²`."

### List X22 — the type-(B) fields ℚ(√59), ℚ(√83), ℚ(√131) (X22D derives; X22V verifies blind)

Inputs quoted verbatim: T-J38-2 and T-J38-3 (stub §2, J38 block); row 111: "`F(R) ≠ 0` iff every translation-invariant random four-colouring of
the plane is a pullback from the tight place (Q-μ) and no colouring is transient — none whose orbit closure's invariant measures all live on
the pullbacks without its being one (Q-tr)".

The claims:
- **C-0.** "ℚ(√59), ℚ(√83) and ℚ(√131) lie outside row 100's exception: their stable dyadic place is inert, not ramified, in `L/F`."
- **C-1.** "Given MR, at `F ∈ {ℚ(√59), ℚ(√83), ℚ(√131)}`, Q-μ holds: every translation-invariant random four-colouring of `F²` is almost
  surely a pullback from the tight place. T-B1 is not used."
- **C-2.** "Given MR, at those fields: `F(R) ≠ 0` (row 88) iff Q-tr (no four-colouring is transient)."
- **C-3.** "Given MR, at those fields: T-B1 ⟺ row 88 ⟺ Q-tr."
- **C-4.** "Over ℚ(√59), no four-colouring of the plane is transient." (TRUE, FALSE, or GAP at a named step. It asks whether EF_F⁺'s method —
  Lemma 3.1′, EF's pigeonhole against polynomially many rational unit-vector multipliers, Lemma Z's wandering shells — transfers from invariant
  measures to a single colouring's orbit.)
- **SEL-k** (the advisor's F2; a reduction, for every `k`). "For every real number field `F` outside row 100's exception and every `k ≥ 2`,
  given MR: `F²` is `k`-colourable iff it has a translation- and rotation-invariant random `k`-colouring whose spectral measure is carried by

§7's paragraph on MR's standing (lines 248–253), copied because "given MR" is defined there:

**Kooshi, verbatim (relayed 06:17):** *"We still have usage left for crunching. Do these findings transfer to the other wanted posters? Please
continue the queue with asks about them."*

**Where waves 1–2 left MR** (from the reports, `data/crunch-2026-09-26-x2x3/reports/`): EF_F⁺ is TRUE by two derivations (X01D; X12B blind,
by its own route), and X01V's GAP at the multiplier step was absorbed by X12B's rational-unit-vector multipliers. PE-2 is TRUE by X02D and
X02V blind, given EL2021 Thm 1.2 through (★); PE-1 as stated is FALSE. SP-Cor passed X05V blind. So **MR(F) holds for every real number

### 1.2 Quotation check (standing rule 5)

| quotation (in the queue's list X22 or my brief) | source | result |
|---|---|---|
| row 111: "`F(R) ≠ 0` iff every translation-invariant random four-colouring of the plane is a pullback from the tight place (Q-μ) and no colouring is transient — none whose orbit closure's invariant measures all live on the pullbacks without its being one (Q-tr)" | `LEDGER.md` row 111, first sentence | **verbatim** |
| T-J38-2 and T-J38-3, "stub §2, J38 block" | `plans/STUB-measure-rigidity-three-fields.md` §2.3, J38 block | present, quoted there from J38 §3.5 and §4.7; J48's correction to T-J38-3 ("on each `R`-coset of `F²`") is carried beside it. The queue says "stub §2"; the block is §2.3 — an address slip only |
| MR(F): "every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure" | stub §1, quoting J38 §3.5, T-J38-2 (iii) | verbatim; the queue's scope sentence ("every real number field at [hand] grade, with the scope of row 100's exception") matches the stub's status block ("every real number field with `R_F = O′` (row 100: every `F` without a ramified stable dyadic place …)") |
| brief: "X03D's FL-K (the relatively independent self-joining over the `E`-factor)" | `plans/FS100-X03D-derivation.md` theorems table line 12 (statement) | the statement matches in substance; the queue does not quote FL-K's text, so nothing to mis-quote |
| brief's verified inputs: "rows 67, 88, 90–92, 111, 112 (Theorem C); J45's lemma statements" | `LEDGER.md` rows as numbered; J45 §5.4 | all present; row 112 is Theorem C over the real fields of S2 |

No quotation in the claim list is a paraphrase that changes a quantifier. One reading to fix before deriving (below, §1.5): "translation-invariant
random four-colouring" in C-1 and row 111 is a translation-invariant Borel probability on `X₄(F)`, **not** assumed rotation-invariant
(`plans/R88-derivation.md` Notation: "(Q-μ) every such `μ` is carried by Pull", `μ` "translation-invariant").

### 1.3 C-0 — decided (exact, seconds)

**X22V-C0 [tools exact + hand].** `59 ≡ 83 ≡ 131 ≡ 3 (mod 8)`, so 2 ramifies in `F = ℚ(√d)` (`𝔭² = (2)`, `f = 1`) and `F_𝔭 = ℚ₂(√d) = ℚ₂(√3)`
(`3d ≡ 1 (mod 8)` is a square in `ℚ₂`). `L_𝔓 = ℚ₂(√3, i) = ℚ₂(√3)(√−3)`, and `ℚ₂(√−3)/ℚ₂` is the unramified quadratic extension, so
`L_𝔓/F_𝔭` is unramified of degree 2: **inert**, hence conjugation-stable and not ramified. PARI (`tools/x22v_c0.py`, `data/fs100/x22v/c0.out`):
each field has one dyadic place, `e_F = 2, f_F = 1`, inert in `L/F`. Controls: ℚ(√5) reads "RAMIFIED (stable)" (row 100's named exception field),
ℚ(√167) reads "split (not stable)". Plant (`--plant`, `x² + d` for `x² − d`): all three verdicts flip to RAMIFIED and the tool exits 1
(`data/fs100/x22v/c0-plant.out`). **C-0: TRUE.**

### 1.4 C0 — my probabilities before deriving (11:47 UTC)

| claim | P(TRUE as stated) | why |
|---|---|---|
| C-0 | 0.97 (now decided TRUE) | `d ≡ 3 (mod 8)` puts the dyadic place of `F(i)` at row 67's `ℤ₂[ω][√3]` |
| C-1 | 0.20 | `plans/R88-derivation.md` §G, T-C′'s last clause, reads the opposite: "even a full classification of `U`-invariant measures would leave Q-μ open without T-B1-type isolation (the weak-* limit of `U`-averages can move mass onto Pull, the plan's §M.1)". MR is exactly such a classification. A proof would have to beat that reading |
| C-2 | 0.20 | its ⟸ is C-1 in disguise (Q-tr does not obviously help the rotation step) |
| C-3 | 0.20 | T-B1 ⟺ row 88 is T-J38-2 (iii) (input); Q-tr ⟹ row 88 is C-2's ⟸ |
| C-4 | 0.05 | R88-B2-3: "no measure argument (T-C's included) can reach" T-B2, Q-tr's single-pullback case; EF_F⁺ is a measure argument |
| SEL-k | 0.70 | given MR, the non-`E` part of a rotation-invariant spectrum is a Haar multiple, whose Fourier coefficients at `u ≠ 0` vanish; SI-4's selection at `k` colours then looks direct |

### 1.5 Fence note — a slip, disclosed

At 06:38, reading the **statement** of X03D-FL-K, a `sed` range one screen too wide printed lines 168–172 of `plans/FS100-X03D-derivation.md`,
which include FL-K's three-line proof (§3.2). The brief fences that proof. So **my FL-K derivation below is not blind**: I read the proof's
first line (tetrahedral inner products and conditional independence) before deriving. I derive the `k`-colour form independently and say
where it is the same computation; the owner should weight it as "re-derived after seeing the proof", not as blind. Nothing else fenced was opened.

### 1.6 Would-have-searched-here log (stage 1)

- Would have scanned small real quadratic fields for dyadic behaviour; instead the three fields and two named controls, fixed by the claim.
