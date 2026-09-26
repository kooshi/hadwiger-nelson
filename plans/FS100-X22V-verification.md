# FS-100 — X22V: blind verification of list X22 (the type-(B) fields given MR, and SEL-k)

*Job X22V (wave 3 of the ×2×3 crunch, 2026-09-26), Coxeter, Opus 5.5, blind verifier. Brief
`data/crunch-2026-09-26-x2x3/briefs/X22V-type-B-verifier.md` with `STANDING-RULES.md`. Owner "main"; stop time moved by the owner to 12:50 UTC.
Working files `data/fs100/x22v/`; checks `tools/x22v_*.py`.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| X22V-C0 | over ℚ(√59), ℚ(√83), ℚ(√131) the unique dyadic place of `F` (`e = 2, f = 1`) is inert in `L = F(i)`, so none is a ramified stable dyadic place | [tools exact; controls ℚ(√5) ramified, ℚ(√167) split; plant fires] + [hand] | Stage 1 §1.3; `tools/x22v_c0.py`, `data/fs100/x22v/c0*.out` |

| X22V-F1 | a finite positive `U`-invariant `E`-null measure on `R̂` has, given MR, Fourier coefficients 0 at every `y ≠ 0` | [hand] | §2.1 |
| X22V-F2 | given MR, over a type-(B) field, every `R ⋊ U`-invariant probability on `X₄(F)` is carried by Pull (no T-B1) | [hand, one mind] | §2.1 |
| X22V-R | given MR, over a type-(B) field, every four-colouring outside Pull is affinely transient; so row 88 ⟺ no affinely transient colouring | [hand, one mind] | §2.3, corrected §3.1 |
| X22V-T4 | a transient colouring shows every measure method only Pull: its Følner spectral measures and their `U`-averages are carried by the finite `D = (R ∩ 𝔓⁴)^⊥` | [hand, one mind] | §2.5 |
| X22V-FLk | FL-K at `k` colours: `ν̂(u) = −(k/(k−1)) P(c¹(0) = c²(u))`, `ν(R̂) = (k/(k−1)) P(c¹(0) ≠ c²(0))` | [hand, not blind (§1.5); identities tools exact] | §2.6; `tools/x22v_simplex.py` |
| X22V-SELk | SEL-k TRUE given MR: `F²` is `k`-colourable iff it has a translation- and rotation-invariant random `k`-colouring with spectrum on `T + A` | [hand, one mind] | §2.6 |

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

## Stage 2 — SAVED (blind derivations: C-1 to C-4, SEL-k with FL-K)

*Setting as `plans/R88-derivation.md` Notation and J45 §1.2: `X₄(F)` (more generally `X_k(F)`) the proper colourings of `Cay(R, U)`;
`M_T` the translation-invariant Borel probabilities on it; `M_Aff ⊂ M_T` those also invariant under `c ↦ c(u·)`, `u ∈ U` (the group
`R ⋊ U`); `X′ = X₄ ∖ Pull`; `𝒜_∅` the `E_∅ = T + A` factor (J45-N2), `p(x) = P(c(x) = · | 𝒜_∅)`, `h = E[g | 𝒜_∅]`; `m` Haar measure on `R̂`.
Inputs used by statement only: MR(F); J45-N1, N2, SI-1 to SI-4, B⁺, R-U; T-A (R88-TA (i)–(vi)); R88-TA1; R88-B2-3; Theorem C (row 112)
at `S = ∅`; T-J38-2.*

### 2.1 Two facts every claim below uses

**X22V-F1 (MR in Fourier form) [hand].** If `τ` is a finite positive `U`-invariant measure on `R̂`, then `τ̂(uy) = τ̂(y)` for all `u ∈ U`,
`y ∈ R` (`τ̂(y) = ∫ χ(y) dτ = ∫ (u·χ)(y) dτ = ∫ χ(uy) dτ`). If moreover `τ(E) = 0`, MR gives `τ = b·m`, so `τ̂(y) = 0` for every `y ≠ 0`.
(Haar is `E`-null: each `E_S` is Haar-null (J45-N1) and `E = ⋃_S E_S` is a countable union — `S` ranges over finite sets of the countably many
split places.)

**X22V-F2 (the rotation-invariant case of Q-μ) [hand, one mind]: given MR(F), over a type-(B) field, every `μ ∈ M_Aff` is carried by Pull.**
*Proof.* Rotation-invariance of `μ` gives `σ̂_μ(uy) = E⟨g(0), g(uy)⟩ = E⟨g(0), g(y)⟩` (the law of `c(u·)` is the law of `c`), so `σ_μ` is
`U`-invariant. R-U: `σ_μ(E ∖ (T + A)) = 0`. So `τ := σ_μ|_{R̂∖E} = σ_μ|_{R̂∖E_∅}`, `U`-invariant, positive, finite, `E`-null; by F1,
`τ̂(u) = 0` for every `u ∈ U`. SI-3 at `S = ∅`: `∫_{R̂∖E_∅} Re χ(u) dσ_μ = −(4/3) P(c¹(0) = c²(u))`; the left side is `τ̂(u) = 0`. So equality
holds at every `u`, and B⁺ (given Theorem C at `S = ∅`, row 112, and FS38-D2-A) gives: `μ` is carried by Pull. B⁺'s hypothesis is
translation-invariance only (J45 §5.4: "equality at every `u` implies `μ` is carried by Pull"), so non-ergodic `μ` is covered (J48's BC-6
checked exactly this). ∎ *Same thing, second form:* if `μ ∈ M_Aff` had `μ(X′) > 0`, then `μ|_{X′}/μ(X′) ∈ M_Aff` (X′ is `R ⋊ U`-invariant
because Pull is, R88-TA (i)) and F2 applied to it is a contradiction. No closedness of `X′` is used.

### 2.2 C-1 — the step of T-J38-2 that used T-B1, and whether MR with Theorem C replaces it

**The step.** T-J38-2 (i): "`X′ = X₄(F) ∖ Pull` is closed" — true under T-B1 because Pull is a finite set of isolated points, hence open.
It is used in (ii) for one thing: **to get an `R ⋊ U`-invariant probability on `X′`** from `X′ ≠ ∅` (an amenable group acting on the compact
space `X′` has an invariant probability; without closedness `X′` is not compact). Everything after that — Theorem C on `X′`, SI, B⁺, the SP
witness — needs only a measure `ν ∈ M_Aff` with `ν(X′) = 1`.

**For measures that are already rotation-invariant, MR with Theorem C replaces it** (F2): no closedness is needed.

**For a merely translation-invariant `μ`, it does not, and I find no replacement.** C-1 and Q-μ quantify over `M_T` (row 111: "every
translation-invariant random four-colouring"). Take `μ ∈ M_T` with `μ(Pull) = 0`. MR speaks only about `U`-invariant measures on `R̂`, and
`σ_μ` is not `U`-invariant. The two ways to make it so both fail:
1. *Average the colouring measure.* `ν_n = |Φ_n|⁻¹ Σ_{u∈Φ_n} u_*μ` (Følner sets of the countable abelian group `U`); every weak-* limit
   `ν ∈ M_Aff`, and F2 puts it on Pull. But `u_*μ(Pull) = μ(Pull) = 0` for every `u` and the limit may still have `ν(Pull) = 1`: `μ ↦ μ(Pull)` is
   only upper semicontinuous (Pull closed; portmanteau gives `ν(Pull) ≥ limsup ν_n(Pull) = 0`, nothing more). It is continuous exactly when
   Pull is clopen — T-B1. In the language of convex sets: `M′ = {μ ∈ M_T : μ(Pull) = 0}` is a `U`-invariant convex face, but a `G_δ`, not closed,
   so Markov–Kakutani gives a `U`-fixed point only in its closure, which may lie in the face of Pull-measures.
2. *Average the spectral measure.* `τ_μ = σ_μ|_{R̂∖E}` has `τ̂_μ(u) ≤ 0` for all `u` and `< 0` for some (SI-3 and B⁺'s contrapositive: `μ` is not
   on Pull). Its `U`-averages converge weak-* to a `U`-invariant `τ̄`, but `E` is dense and not closed, so `τ̄` may charge `E`; MR then only says
   `τ̄|_{R̂∖E} = b·m`, and `τ̄̂(1) = τ̄|_{T+A}^(1)` can be negative with no contradiction. And averaging loses the per-`u` strictness (it may hold only
   on a Følner-null set of `u`).

What a proof of C-1 would need, stated so it can be aimed at: **a continuous, affine, `U`-invariant functional on `M_T` that vanishes on the
Pull-measures and is positive on `M′`** (then `Φ(ν) = lim Φ(ν_n) = Φ(μ) > 0` contradicts F2), or equivalently a proof that
`lim_n |Φ_n|⁻¹ Σ_{u∈Φ_n} P_μ(c(0) ≠ c(4u)) > 0` for every `μ ∈ M′`. The pair statistic `P_μ(c(0) ≠ c(4))` is continuous and affine and
vanishes on Pull (`4 ∈ 𝔓⁴ = 4O`), but it is not `U`-invariant, and its `U`-average is the quantity in question. This is exactly the obstruction
`plans/R88-derivation.md` §G (T-C′) records: "the weak-* limit of `U`-averages can move mass onto Pull". **Not refuted either:** a FALSE would
need a `μ ∈ M′`, i.e. a non-Pull colouring, which is row 88's "no" (R88-TA2 shape).

**C-1, my verdict: GAP** at "a translation-invariant `μ` with `μ(Pull) = 0` has an `R ⋊ U`-invariant weak-* limit with `ν(Pull) < 1`" — the
closedness of `X′`, i.e. T-B1. **TRUE for `M_Aff`** (F2), which is the rotation-invariant part of Q-μ, not Q-μ.

### 2.3 C-2 — `F(R) ≠ 0` iff Q-tr, given MR

(⟹) is R88-TA (iv) (unconditional). (⟸) needs, given Q-tr and MR, that every `μ ∈ M_T` is on Pull (R88-TA (iv): `F ≠ 0` iff Q-μ ∧ Q-tr).
Q-tr gives: each non-Pull colouring has a translation-invariant measure on its orbit closure charging `X′` — a member of `M′` — and the
question returns to §2.2's step with no new input: Q-tr is about translation orbit closures, and the missing step is rotational. **GAP at the
same step.**

**What MR does give, exactly (X22V-R, [hand, one mind]):** call `c ∉ Pull` *affinely transient* if every `R ⋊ U`-invariant probability on the
closure of its `R ⋊ U`-orbit is carried by Pull. **Given MR(F), over a type-(B) field: `F(R) ≠ 0` iff no colouring is affinely transient.**
*Proof.* (⟹) `F(R) ≠ 0` ⟹ `F(R) = P(R)` (finite-index ideal, R88-TA (ii)) ⟹ every colouring is periodic ⟹ a pullback (row 88, V3) ⟹ `X′ = ∅`.
(⟸) If `F(R) = 0`, some `c ∉ Pull` exists (else `X₄ = Pull` and `4 ∈ F(R)`); `Y` = the closure of its `R ⋊ U`-orbit is compact and invariant;
if `c` is not affinely transient, some `ν ∈ M_Aff` on `Y` has `ν(X′) > 0`, contradicting F2's second form. ∎ Affine transience and Q-tr's
transience are not comparable in general (the `R ⋊ U`-orbit closure of a transient colouring contains limits of its rotations, which need not be
transient; and a non-transient colouring can be affinely transient). So C-2 holds with "affinely transient" in place of "transient"; as stated it
is GAP.

### 2.4 C-3 — T-B1 ⟺ row 88 ⟺ Q-tr, given MR

- T-B1 ⟹ row 88, given MR: T-J38-2 (iii) (input). Row 88 ⟹ T-B1: R88-TA1 ("`F(R) ≠ 0` ⟹ T-B1"; with `X₄ = Pull` finite every point is isolated).
  So **T-B1 ⟺ row 88 given MR: TRUE** (inputs; my re-derivation of the ⟸ half is F2 plus the closedness step of §2.2).
- Row 88 ⟹ Q-tr: R88-TA (iv). T-B1 ⟹ Q-tr: R88-TA1.
- Q-tr ⟹ row 88 (or Q-tr ⟹ T-B1), given MR: **GAP**, C-2's (⟸).

**C-3: GAP** at the last link (Q-tr ⟹ row 88). What is TRUE: given MR, row 88 ⟺ T-B1 ⟹ Q-tr, and row 88 ⟺ no affinely transient colouring.

### 2.5 C-4 — "Over ℚ(√59), no four-colouring of the plane is transient" (twenty minutes, used)

Unconditional as stated, and it is one of row 88's two halves (Q-tr; R88-TA (iv)). **The transfer of EF_F⁺'s method fails at one step, for
all three of its tools at once:**

**X22V-T4 [hand, one mind] — a transient colouring shows every measure method only Pull.** Let `c` be transient over a type-(B) field. (a) Every
translation-invariant probability on its orbit closure is carried by Pull (definition). (b) Hence every Følner spectral measure of `c` — every
weak-* limit of `|B_n|⁻¹ Σ_{x∈B_n} ⟨g(x), g(x + y)⟩` as a positive-definite function of `y`, `B_n` Følner in `R` — is the spectral measure of such a
measure (the empirical measures `|B_n|⁻¹ Σ δ_{t·c}` have limit points in `M_T` on the orbit closure, and `μ ↦ σ̂_μ(y)` is continuous), so it is
carried by `D := (R ∩ 𝔓⁴)^⊥`, the finitely many characters of `R/(R ∩ 𝔓⁴)` (every pullback is `𝔓⁴`-periodic). (c) `D` is finite, closed and
`U`-invariant, so every `U`-average and every weak-* limit of `U`-averages of such measures is again carried by `D ⊂ T`. (d) So every `U`-invariant
measure on `R̂` built from `c`'s statistics already satisfies EF_F⁺'s conclusion (carried by `T + A`) and MR's (its `E`-null part is 0): the method
runs and returns no information about whether `c ∈ Pull`. ∎

Tool by tool: **Lemma 3.1′ / EF's pigeonhole** needs a measure of zero entropy to act on; the only ones on offer are (d)'s, on `D`. **Lemma Z's
wandering shells** (X12B-Z: "a finite measure on `ℤ ∪ {∞}` invariant under `k ↦ k + h` … gives `ℤ` measure 0") needs finite mass; for a single
orbit there is no finite invariant mass off Pull (a shift-invariant *set* can be all of `ℤ`). **The polynomially many rational multipliers** are a
counting device inside the pigeonhole and inherit its need for a measure. This is R88-B2-3's theorem in EF's vocabulary ("no measure argument
(T-C's included) can reach" T-B2).

**C-4: GAP** at "from 'every invariant measure of the orbit closure is on Pull' to '`c ∈ Pull`'" — which is Q-tr itself, so the method's transfer
proves nothing, and C-4 stays as open as row 88. **Not FALSE either**: a transient colouring is a non-Pull colouring (R88-TA2), row 88's "no".
**What a wrong-reason pass would look like** (the brief's question): (i) EF_F⁺ applied to `c`'s Følner or `U`-averaged spectral measure, concluding
"carried by `T + A`, so by Theorem C `c` is a pullback" — the conclusion is about the measure, which is Pull's by transience, not about the point;
(ii) Lemma Z applied to the defect set `{z : c(z) ≠ p(z)}` along `u_w`-shells, concluding positive density from "shells wander" — wandering proves
zero mass for a finite invariant measure and says nothing about a set's density (T-B2's named step, "from propagation to positive density", R88
§G); (iii) any argument whose last line is "so the orbit closure's invariant measures are on Pull", which is transience's hypothesis, not its
negation.

### 2.6 SEL-k, with FL-K derived (not blind; see §1.5)

**X22V-FLk [hand; the `k = 4` case read before deriving, the general `k` derived here; exact check of the identities `tools/x22v_simplex.py`].**
Let `e_0, …, e_{k−1}` be the regular simplex, `⟨e_i, e_j⟩ = (k/(k−1))δ_ij − 1/(k−1)`, `μ ∈ M_T` on `X_k(F)`, `σ = σ_μ` the trace spectral measure of
`g(x) = e_{c(x)}`, `ν := σ|_{R̂∖E_∅}`, `(c¹, c²)` the relatively independent self-joining over `𝒜_∅`. Then for every `u ∈ U`:
`ν̂(u) = −(k/(k−1)) P(c¹(0) = c²(u))` and `ν(R̂) = (k/(k−1)) P(c¹(0) ≠ c²(0))`. *Proof.* For probability vectors `p, q`:
`⟨Σ p_i e_i, Σ q_j e_j⟩ = (k/(k−1))⟨p, q⟩ − 1/(k−1)` (`Σ p_i = Σ q_j = 1`). N2: the spectral projection onto `E_∅` is `E[· | 𝒜_∅]`, so
`σ|_{E_∅}` has Fourier transform `E⟨h(0), h(y)⟩`. Properness: `σ̂(u) = −1/(k−1)`. So `ν̂(u) = −1/(k−1) − (k/(k−1))E⟨p(0), p(u)⟩ + 1/(k−1)`, and
`E⟨p(0), p(u)⟩ = P(c¹(0) = c²(u))` by conditional independence; at `y = 0`, `ν(R̂) = 1 − E|h(0)|² = (k/(k−1))(1 − E⟨p(0), p(0)⟩)`. ∎ At `k = 4`,
and when `μ ∈ M_Aff` (so `σ(E ∖ E_∅) = 0` by R-U and `ν = σ|_{R̂∖E}`), this is X03D-FL-K's statement. The check (`data/fs100/x22v/simplex.out`):
the Gram matrix is PSD of rank `k − 1` with unit diagonal, and both identities hold on random finite joint laws with `c(0) ≠ c(u)`, `k = 2, …, 8`;
the plant (off-diagonal `−1/k`) fails 149 times (`simplex-plant.out`).

**SEL-k: TRUE, given MR [hand, one mind].** (⟸) A random `k`-colouring is a probability on the non-empty set `X_k(F)`; any point of its support
`k`-colours `Cay(R, U)`, and `F²` is a disjoint union of translates of it. (⟹) If `X_k(F) ≠ ∅`, the amenable group `R ⋊ U` (metabelian) acting on
the compact metrizable `X_k(F)` has an invariant probability `μ ∈ M_Aff`. By F1–F2's first lines (R-U, then MR), `ν = σ|_{R̂∖E} = σ|_{R̂∖E_∅}`
is `b·m` and `ν̂(u) = 0`; by FLk, `P(c¹(0) = c²(u)) = 0` for every `u ∈ U`, i.e. `supp p(x) ∩ supp p(x + u) = ∅` a.s. (countably many edges). The
selection `c′(x) = min supp p(x)` (SI-4 at `k` colours; versions chosen by `p(x)(ω) = p(0)(T_x ω)`) is an `𝒜_∅`-measurable, translation-equivariant,
almost surely proper `k`-colouring. Its law `μ′` is translation-invariant; it is rotation-invariant because `μ` and `𝒜_∅` are (`E_∅` is
`U`-invariant), so `p(ux)(ω) = p(x)(R_u ω)` and `c′(u·)` has the law of `c′`. Its spectral measure is that of `e_{c′(0)} ∈ L²(𝒜_∅)`, carried by
`E_∅ = T + A ⊂ E` (N2). ∎ The route uses MR only as "no SP witness" (`ν̂(1) = 0`), which is MR by J46-8. **The named risk (FL-K, one mind) is
not load-bearing beyond SI-3's identity at `k` colours**, which I re-derived and checked exactly. Scope: "outside row 100's exception" enters only
through MR's scope; R-U, N1, N2 hold for every real number field. Reading: "`F²` has a translation-invariant random colouring" is read on `R`
(countable), as in J45; on `F²` itself the uncountable translation group would need a different measurable set-up, and the claim should say `R`.

### 2.7 Would-have-searched-here log (stage 2)

- C-1: would have looked for a small non-Pull translation-invariant colouring measure by search on a finite quotient; instead named the missing
  step and the functional that would close it. (No finite quotient could decide it anyway: periodic colourings are pullbacks.)
- C-4: would have searched for transient colourings near a pullback with a sparse defect; instead proved the method's blindness (X22V-T4).
- SEL-k: would have tried random joint laws in floating point; instead an exact rational check of the two identities with a plant.

## Stage 3 — SAVED (the write-up: verdicts, committed before any fenced file is opened)

### 3.1 Verdicts

| claim | verdict | grade of what I hold | the step, or the route |
|---|---|---|---|
| **C-0** | **TRUE** | [tools exact + hand] | `d ≡ 3 (mod 8)`: one dyadic place, `F_𝔭 = ℚ₂(√3)`, inert in `L/F` (`L_𝔓 = ℚ₂(√3)(√−3)`); controls ℚ(√5) ramified, ℚ(√167) split; plant fires (§1.3) |
| **C-1** | **GAP** | TRUE on `M_Aff` [hand, one mind] (X22V-F2) | as stated (every *translation*-invariant `μ`): the step "a translation-invariant `μ` with `μ(Pull) = 0` has an `R ⋊ U`-invariant limit off Pull". The step of T-J38-2 that used T-B1 is (i), closedness of `X′`, used only to get an `R ⋊ U`-invariant probability on `X′`; for rotation-invariant measures MR with Theorem C (via R-U, SI-3, B⁺) replaces it, for translation-invariant ones nothing I have does (§2.2). **"T-B1 is not used" holds only for the rotation-invariant half of Q-μ** |
| **C-2** | **GAP** | the corrected form TRUE [hand, one mind] (X22V-R) | (⟹) R88-TA (iv); (⟸) is the same step as C-1: Q-tr is about translation orbit closures, the missing step is rotational. **What holds:** given MR, every four-colouring outside Pull is *affinely transient* (every `R ⋊ U`-invariant probability on its `R ⋊ U`-orbit closure is on Pull), so row 88 ⟺ no affinely transient colouring |
| **C-3** | **GAP** | T-B1 ⟺ row 88 ⟹ Q-tr TRUE (inputs: T-J38-2 (iii), R88-TA1, R88-TA (iv)) | the last link, Q-tr ⟹ row 88, is C-2's (⟸) |
| **C-4** | **GAP** | X22V-T4 [hand, one mind]: a transient colouring shows every measure method only Pull's spectrum (carried by the finite `D = (R ∩ 𝔓⁴)^⊥`) | EF_F⁺'s three tools each need a measure off Pull (the pigeonhole needs zero entropy of a measure; Lemma Z's wandering needs finite mass; the multipliers live inside the pigeonhole); a transient colouring supplies none, so the method returns nothing. C-4 stays as open as row 88; not FALSE (a transient colouring would be row 88's "no"). Wrong-reason pass: §2.5 (i)–(iii) |
| **SEL-k** | **TRUE, given MR** | [hand, one mind; the identities exact-checked, `tools/x22v_simplex.py`] | (⟸) trivial; (⟹) an `R ⋊ U`-invariant `μ` exists (amenability); R-U and MR make its non-`E` part `b·m`, so `ν̂(u) = 0`; FLk (`k` colours) gives disjoint conditional supports on every edge; SI-4's selection is an `𝒜_∅`-measurable, translation- and rotation-invariant random `k`-colouring with spectrum on `T + A ⊂ E`. FL-K is load-bearing only as SI-3's identity at `k` colours (FLk), derived here — **not blind** (§1.5) |

**The main finding, in one sentence.** MR closes the **rotation-invariant** half of Q-μ at the type-(B) fields with no T-B1, but Q-μ and row 111
quantify over translation-invariant measures, and between the two sits exactly the step T-B1 was bought for: a translation-invariant non-Pull
colouring measure whose rotations all drift onto Pull (a colouring that is affinely transient but not transient). So given MR the type-(B) question
is: **row 88 ⟺ T-B1 ⟺ no affinely transient colouring**, with Q-tr strictly downstream, not equivalent, as far as I can derive.

**A correction to stage 2's §2.3 (my own), recorded here rather than by editing a saved stage:** "Affine transience and Q-tr's transience are not
comparable in general" is stronger than I proved. What I can say: no implication between them is known to me, and **"affinely transient ⟹
transient", given MR, would prove C-1** (given MR every non-Pull colouring is affinely transient; if each were transient, a `μ ∈ M′` would have
`μ`-a.e. point transient, but `μ`-a.e. point is generic for an ergodic component `μ_c` with `μ_c(X′) = 1`, so non-transient — so `M′ = ∅`). So the
single missing step of C-1, C-2 and C-3 can be stated three equivalent-looking ways: (a) the closure of `M′` contains no `U`-fixed point; (b) every
affinely transient colouring is transient; (c) for every `μ ∈ M′`, `lim inf_n |Φ_n|⁻¹ Σ_{u∈Φ_n} P_μ(c(0) ≠ c(4u)) > 0` for some Følner `Φ_n`.
(I have checked (a) ⟺ C-1-given-MR and (b) ⟹ C-1-given-MR; (c) ⟹ C-1 via F2 as in §2.2; the converses of (b) and (c) I have not checked.)

### 3.2 C0 scored

| claim | C0 (P TRUE) | verdict | comment |
|---|---|---|---|
| C-0 | 0.97 | TRUE | as expected |
| C-1 | 0.20 | GAP | the prior came from R88 §G's reading, which the derivation confirms at the same step |
| C-2 | 0.20 | GAP | as expected; the corrected form (affine transience) is new here |
| C-3 | 0.20 | GAP | as expected |
| C-4 | 0.05 | GAP | as expected; X22V-T4 makes the method's blindness a theorem |
| SEL-k | 0.70 | TRUE given MR | easier than expected: MR is used only as "no SP witness" |

### 3.3 Proposed edits (the front-page lane decides; I edit none of these files)

- **Stub `plans/STUB-measure-rigidity-three-fields.md` §2.3 / status block and `CLAUDE.md` item 24 / FS-98's row:** wherever MR is said to reduce
  the type-(B) question, keep "row 88 ⟺ T-B1 (given MR)" and **do not add "⟺ Q-tr"** unless a derivation closes the rotational step; add
  "given MR, every non-Pull colouring is affinely transient (X22V-R)". If X22D reports C-1 TRUE, its proof must be checked at the step "a
  translation-invariant `μ` with `μ(Pull) = 0` is not moved onto Pull by `U`-averaging" before any row carries it.
- **`LEDGER.md` § B, two lines** (X22V-F2, X22V-R), one (X22V-T4), and SEL-k (X22V-SELk) at [hand, one mind, given MR].
- **`plans/R88-derivation.md` §G, T-C′'s last clause:** its reading ("even a full classification of `U`-invariant measures would leave Q-μ open
  without T-B1-type isolation") is now a derived statement at the type-(B) fields: MR is that classification, it gives `M_Aff ⊂` Pull-measures,
  and the remainder is the rotational step (a)–(c) above.
- **FS-98's stub** (transience over the type-(B) fields): a second target beside T-B1, "affinely transient ⟹ transient" (§3.1 (b)).

### Would-have-searched-here log (stage 3)

(none: the stage is a write-up)
