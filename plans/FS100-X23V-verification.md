*Verification record of crunch job **X23V** (wave 3), Coxeter, blind verifier, Opus 5.5, 2026-09-26. Brief:
`data/crunch-2026-09-26-x2x3/briefs/X23V-spcor-every-field-verifier.md`, with `STANDING-RULES.md` as part of it. Stop 12:30 UTC.
Fenced until stage 3 is committed: `plans/FS100-X23D-derivation.md`, `data/fs100/x23d/`, the X23D brief, reports `X2*.md`, the advisor's
record `plans/POROS-2026-09-26-x2x3-crunch.md`, bodies of commits "X23D"/"X23 advisor". No subagents; no finite-witness search.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| X23V-CTL | the class condition fails at K, ℚ(√2,√3), ℚ(√11), ℚ(√23) — each at a named stable place carrying a periodic four-colouring (dyadic inert `Q = 2`; or `𝔽₇`) — and holds at ℚ(√47) | [tools exact, two routes, four plants fire; + hand] | §2.1, `tools/x23v_places.py` |
| X23V-Rb | every odd usable `q ≥ 11` has all-levels four-colour ratio `< 1/4`, and `χ(Γ_q) ≥ 5` iff `q ≥ 11`: no integrality gap on odd stable places | [hand, from FS-66, Hoffman, Weil, FS86-LP, G56] | §2.0 |
| X23V-CLS1 | the class condition ⟹ `L(F) ≥ 5`, every real number field | [hand] | §2.2 |
| X23V-CLS2 | `L(F) ≥ 5` ⟹ the class condition, for every real number field with no inert dyadic stable place over a ramified base of norm `≥ 64` | [hand, given X23V-Rb's inputs] | §2.2 |
| X23V-GF | `F = ℚ(√3)·M₇` (`M₇ ⊂ ℚ(ζ₂₉)`, degree 7) is totally real of degree 14, has one dyadic place, `(e, f) = (2, 7)`, inert in `F(i)/F` (`Q = 128`), and `L(F) ≥ 5`: CLS2's excluded case occurs | [hand + tools exact (PARI)] | §2.2, `data/fs100/x23v/gapfield.out` |
| X23V-AR | `UD(ℝ²)^{×n}` has ratio `m₁` for every `n` (C14.2 (a) + C14.3's induction); its Hoffman ratio is `0.2871` at every `n ≥ 1` | [hand; a re-walk of C14] | §2.3 |
| X23V-CX | at a complex place of `F`, the factor restricted to the circle `{(e^{iθ}, e^{−iθ})}` is `ℝ² × UD_{√2}(ℝ²)`, ratio `m₁`; so T-C(A)'s count runs over non-totally-real `F` | [hand, one mind] | §2.3 |
| X23V-SPC | SPC as graded in §3 | [hand] | §2.3 |
| X23V-Q35 | ℚ(√3,√5): dyadic place split in `L`; stable places exactly above `p ≡ 11, 59 (mod 60)`, all of residue degree one; class condition holds; `χ = 5` given MR and SPC | [hand + tools exact] | §2.5 |
| X23V-D1 | `N₄(F) = ∅` ⟹ the class condition; so D-1 is SPC's special case | [hand] | §2.6 |
| X23V-H | level-one least eigenvalues: `Γ₂₃ −7.96069` (`|λ|/d = 0.331695`), `Γ₂₇ −8` (Hoffman `2/9`), `Γ₃₁ −10.66651`, `Γ₄₃ −11.96223`, `Γ₄₇ −12.84653`, `U₃₂ −11` (tight), `U₆₄ −15`, `U₁₂₈ −19`: every Hoffman ratio `< 1/4` except `U₃₂` (`= 1/4`) | [tools, float with integer-exact controls (`U₂`, `Γ₃`, `U₆₄`); plant fires] | §4.2, `tools/x23v_hoffman.py` |
| X23V-DLP | the dyadic Lemma P (X23D's statement), re-derived from its statement: on an inert dyadic tower, at any base ramification `e`, a character new at level `m ≥ 2` has `|λ| ≤ Q^{m−1}` (normalised `1/(Q+1)`) | [hand; a second mind on X23D's statement, not blind to it] | §4.1 |

## Stage 1 — SAVED (quotation check; the claims verbatim; C0)

### 1.1 The claims, verbatim

**`plans/CRUNCH-2026-09-26-x2x3-queue.md` §7, its first paragraphs** (verbatim, lines 245–252; also `data/fs100/x23v/sec7-verbatim.txt`):

> **Kooshi, verbatim (relayed 06:17):** *"We still have usage left for crunching. Do these findings transfer to the other wanted posters? Please
> continue the queue with asks about them."*
> 
> **Where waves 1–2 left MR** (from the reports, `data/crunch-2026-09-26-x2x3/reports/`): EF_F⁺ is TRUE by two derivations (X01D; X12B blind,
> by its own route), and X01V's GAP at the multiplier step was absorbed by X12B's rational-unit-vector multipliers. PE-2 is TRUE by X02D and
> X02V blind, given EL2021 Thm 1.2 through (★); PE-1 as stated is FALSE. SP-Cor passed X05V blind. So **MR(F) holds for every real number
> field at [hand] grade, with the scope of row 100's exception** (a ramified stable dyadic place, where `R = O′` is not proved; X09C's audit).
> Every claim below is stated with that scope and asks whether its field is outside the exception. **"Given MR"** below means: given MR(F) at

**List X23** (verbatim, lines 306–326; also `data/fs100/x23v/listX23-verbatim.txt`):

> ### List X23 — every real number field: SP-Cor(F) and the class (X23D derives; X23V verifies blind) — **revised 06:27, before any X23 job launched, on the advisor's F1 and F4**
> 
> *The first draft (D-1 to D-4, 06:25) is replaced. D-1 and D-C survive below as D-1 and CTL. Nothing had been derived on the first draft.*
> 
> Inputs quoted verbatim: row 117 (quoted in list X21); SP-Cor and A⁺ at `S = ∅` (`plans/FS84-SI-D-derivation.md` §4.2, §5.4); X05V's re-derivation
> P0–P8 (`plans/FS100-X05V-verification.md` §2.1); J48-N4cor (quoted in list X21).
> 
> - **SPC(F)** (SP-Cor for every real number field; the advisor's F1 (a)). "For every real number field `F` outside row 100's exception: if T-C(A)
>   holds at `S = ∅` (every stable place of `L = F(i)` has all-levels four-colour ratio `< 1/4`), then J45's A⁺ and SP-Cor hold with J45's
>   proofs, and, given MR, `χ(F²) ≥ 5`." **Named risk (the advisor):** A⁺'s archimedean step when `F` has `n = [F:ℚ] > 2` real places. X03D's
>   `Λ = 0.4028 > 1/3` shows that first moments alone cannot do it; J45 did it at `n = 2`.
> - **CLS(F)** (the class; the advisor's F1 (b)). "For every real number field `F` outside row 100's exception: T-C(A) holds at `S = ∅` iff
>   `L(F) ≥ 5`." **Named risks (the advisor):** `q = 27`; the dyadic `U_Q` for `Q ≥ 64`; ramified stable places; the archimedean part at `n`
>   places.
> - **COR.** "SPC and CLS together give `χ(F²) ≥ min(L(F), 5)` for every real number field outside row 100's exception."
> - **CTL** (controls; each must come out as stated, and each can fail). "T-C(A) at `S = ∅` fails at K = ℚ(√3,√11), ℚ(√2,√3), ℚ(√11) and ℚ(√23),
>   where `L ≤ 4`. At ℚ(√47) it holds."
> - **Q35.** "ℚ(√3,√5) lies outside row 100's exception. Its stable places are exactly those above 11, 59 and the other primes of residue
>   degree one in `L/ℚ(√3,√5)` that are inert in `L/F`; 3, 7, 19, 23, 31, 43 and 47 are not stable; and T-C(A) holds there at `S = ∅`. Hence,
>   given MR and SPC, `χ(ℚ(√3,√5)²) = 5`." (The advisor's F4; its Legendre-symbol list is one mind. An exact check of seconds is in.)
> - **D-1** (the J48 route, kept). "Given MR, for every totally real number field `F` outside row 100's exception with `N₄(F) = ∅`: `χ(F²) ≥ 5`."

**Row 117, as list X21 quotes it** (the list X23 input "row 117 (quoted in list X21)"): "For `ℚ(√d)` real quadratic: every stable place of
`ℚ(√d, i)` has all-levels four-colour ratio `< 1/4` ⟺ `d ≡ 47, 143, 167 (mod 168)` ⟺ `L(ℚ(√d)) ≥ 5`; and over every real number field where
T-C(A) holds at `S = ∅`, J45's A⁺ and SP-Cor hold with J45's proofs — so MR(F) ⟹ `χ(F²) ≥ 5` at ℚ(√143), ℚ(√311), ℚ(√335) as at ℚ(√47)."

**J48-N4cor, as list X21 quotes it:** "For every totally real `F` with `N₄(F) = ∅` — every stable place 4-thick — MR(F) ⟹ `χ(F²) ≥ 5`".

### 1.2 Quotation check (standing rule 5)

| quotation | source | result |
|---|---|---|
| row 117 in list X21 | `LEDGER.md` row 117, bold statement | **verbatim** |
| J48-N4cor in list X21 | `plans/STUB-measure-rigidity-three-fields.md` lines 184–185 | **verbatim** |
| "SP-Cor and A⁺ at `S = ∅`" (§4.2, §5.4) | `plans/FS84-SI-D-derivation.md` §4.2 (SP-Cor), §Stage 3 (A⁺), §5.4 | addresses exist; **both statements are "over ℚ(√47)"** in J45 (§5.4: "A⁺: over ℚ(√47), given T-C(A) …"; "SP-Cor: over ℚ(√47), given T-C(A) at `S = ∅` …"); A⁺'s proof text says "(and every field in T-C(A)'s class)" |
| X05V's P0–P8 | `plans/FS100-X05V-verification.md` §2.1 | exists, as cited |
| R88-TCA | `plans/R88-derivation.md` line 162 | exists; its statement is a **theorem** ("no translation-invariant Borel probability on `X₄(F)` has spectral measure carried by `T + A + Fin_S`"), proved "over ℚ(√47), and (J28D) over every real field whose stable places all have all-levels ratio `< 1/4`" [class: J28D one mind] |
| "4-thick" | `plans/FS100-BC-verification.md` J48-THK: `λ*_v < 1/(k−1)` | defined there (`λ*_v` the sup over levels of `\|λ_min/d\|`) |
| "X03D's `Λ = 0.4028 > 1/3`" | not opened (not needed) | `0.4028 = \|J₀(j₁,₁)\|`, J45 §4.2's `λ̂(1)`; consistent |

**Two reading findings, logged before any derivation:**
- **(Q-a) SPC's gloss.** SPC writes "if T-C(A) holds at `S = ∅` (every stable place of `L = F(i)` has all-levels four-colour ratio `< 1/4`)".
  In R88-TCA the parenthesis is the **hypothesis of the class form** and T-C(A) the **conclusion**. So SPC contains the step "class condition ⟹
  T-C(A)'s statement" for every real number field — R88-TCA's class form, J28D one mind — and that is where the archimedean risk lives, not in
  A⁺ (whose proof uses T-C(A) as a black box). I score SPC under both readings: **(lit)** "T-C(A)'s statement holds at `S = ∅`" and **(cls)**
  "the class condition holds".
- **(Q-b) Q35's wording.** "the other primes of residue degree one in `L/ℚ(√3,√5)` that are inert in `L/F`": `L/ℚ(√3,√5)` *is* `L/F`, and
  residue degree one in `L/F` contradicts inert in `L/F`, so read literally the set is empty. I score the intended reading, **residue degree one
  in `F/ℚ`** (equivalently, residue field `𝔽_p`), inert in `L/F`, and record the wording as a correction owed.
- COR says "SPC and CLS together give `χ(F²) ≥ min(L(F), 5)`" with no "given MR" and no input for `L ≤ 4`; I score it as written and say what
  it needs.

### 1.3 C0 (my probabilities before deriving)

| claim | P(TRUE as stated) | why |
|---|---|---|
| CTL | 0.9 | four small fields with known `L ≤ 4`; ℚ(√47) is R88-TCA itself |
| CLS | 0.65 | ⟹ is a pullback; ⟸ needs an all-levels ratio `< 1/4` at every stable target of χ ≥ 5: the integrality gap, `q = 27`, dyadic `Q ≥ 64`, ramified bases |
| SPC | 0.6 | A⁺/SP-Cor are field-free given T-C(A); the class form's archimedean factor at `n` real places, and complex places of non-totally-real `F` |
| COR | 0.5 | as written it lacks the `L ≤ 4` half (row 99) and "given MR" |
| Q35 | 0.75 | a Legendre table plus Weil and FS-66 at 11; the wording (Q-b) |
| D-1 | 0.85 | 4-thick ⟹ Hoffman ratio `< 1/4`; a special case of SPC in the totally real case |

### 1.4 Would-have-searched-here log

- (none at stage 1)

## Stage 2 — SAVED (blind derivation: CTL, CLS, SPC, COR, Q35, D-1)

*Inputs used, by statement only: R88-TCA and R88-TC's summaries in `plans/R88-derivation.md`; C14.1–C14.3 (`plans/FS86-C-Coxeter.md` §Proof of C14);
FS86-LP (Lemma P, `plans/FS86-derivation.md`); J45 §Stage 3, §4.2, §5.4; X05V §2.1; rows 67, 75, 100, 112, 113, 117; G54, G56, G59; J48-THK
(`plans/FS100-BC-verification.md`). J28D's §3.3 (the class form's own proof) not read: my class-form steps below are a re-walk from the summaries.*

### 2.0 Two reductions used throughout

**(R-a) Stable places and their targets.** A stable place is a prime `𝔭` of `F` not split in `L = F(i)`. Odd `𝔭`: `L/F` is unramified there
(−1 is a unit), so stable ⟺ inert ⟺ `−1` a non-square in `𝔽_q = O_F/𝔭` ⟺ `q ≡ 3 (mod 4)` ⟺ `q = p^f`, `p ≡ 3 (mod 4)`, `f` odd (the usable
primes). Dyadic `𝔭`: split (not stable), ramified in `L/F` (target two-colourable, ratio `1/2`), or inert (target `U_Q`, `Q = N𝔭`).

**(R-b) Which stable targets have all-levels four-colour ratio `< 1/4`** [hand, from held certificates]. Odd `q`: `q = 3, 7` have `χ(Γ_q) = 3, 4`,
so ratio `≥ 1/4` at level one (a colour class pulls back); `q = 11, 19` ratio `< 1/4` at every level by FS-66's certificates (row 75; ramified
bases by FS86-LP: "FS-66's fibre-density inequality and its certificates bound every level of a ramified tower too"); `q = 23, 27, 31, 43, 47`
by Hoffman at level one (23: `0.3317`; 31: `1/4 − 2.745·10⁻⁶`; 27, 43, 47: Hoffman floor 6, G56) and FS86-LP at new levels (`2/(p+3)`);
`q ≥ 37` by Weil (`2√q/(q+1) < 1/3`) and FS86-LP. **Every odd usable `q ≥ 11` has all-levels ratio `< 1/4`, and `χ(Γ_q) ≥ 5` exactly for
`q ≥ 11`** — so on odd stable places there is no integrality gap between "target needs five" and "ratio `< 1/4`". Dyadic inert: `Q ≤ 32`
four-colourable (G56), ratio `≥ 1/4`; `Q = 64`: `λ_min = −15`, `d = 65`, Hoffman `0.1875`; `Q = 128`: floor 8; larger `Q` by Weil; at every
level of an **unramified** base by G54's inert-tower theorem (`λ_min(G_j) = Q^{j−1}λ_min(G₁)`, "new for Galois rings and even Q").
*Reading note:* FS86-LP is stated with `p`; at `q = p^f`, `f ≥ 3` (e.g. 27) over a ramified base I read it with `q` — not re-derived here.
**Not covered by any held lemma: a dyadic inert stable place over a ramified base (`e(𝔭|2) ≥ 2`) with `Q ≥ 64`** — FS86-LP is for odd
towers, G54's constancy for Galois rings (unramified). See 2.2.

### 2.1 CTL — first

**What a wrong-reason pass would look like** (written before the check):
- (W1) The four `L ≤ 4` fields fail because of a factor every field has — e.g. the real places read with Hoffman's `0.2871` in place of `m₁` —
  in which case ℚ(√47) fails too. The ℚ(√47) half guards this; the check must name, at each failing field, the failing **stable place**.
- (W2) A failure at a place that is not stable (a split dyadic place counted as stable), or ℚ(√47) passing because 3 or 7 was dropped from the
  stable list without being shown non-stable. The check must classify 2, 3, 7 by two routes.
- (W3) Reading-mismatch: the class condition fails while T-C(A)'s *statement* holds (or conversely). At each failing place the check must also
  exhibit what kills the statement: a four-colourable target whose residue pull-back is a periodic colouring, spectrum on `T`.

**Check** (`tools/x23v_places.py` → `data/fs100/x23v/places.out`; route A Kummer theory over `ℚ_p`, route B PARI `idealprimedec` on `F` and
on `L`, every prime `< 400`, agreeing everywhere; four plants fire, each for its intended reason — `data/fs100/x23v/places-plants.out`):

| field | failing stable places (the class condition) | what kills T-C(A)'s statement | verdict |
|---|---|---|---|
| K = ℚ(√3,√11) | both dyadic places, inert in `L/F`, `Q = 2`: `U₂ = K₄`, ratio exactly `1/4` (row 89's two tight places) | the residue colouring at either (Theorem B), periodic | fails ✓ |
| ℚ(√2,√3) | the dyadic place (`e = 4`, `f = 1`), inert, `Q = 2` | its `K₄` pull-back (G55: `χ = 4`) | fails ✓ |
| ℚ(√11) | dyadic inert `Q = 2`, **and** 7 (split in `F`, `𝔽₇`, `Γ₇` four-colourable) | either pull-back (C9's colouring at 7) | fails ✓ |
| ℚ(√23) | 7 (`23 ≡ 2`, a square mod 7); the dyadic place is split (`23 ≡ 7 (mod 8)`) | the `Γ₇` pull-back | fails ✓ |
| ℚ(√47) | none: 2 split, 3 and 7 inert in `F` (`𝔽₉`, `𝔽₄₉`, not stable); 11, 19 FS-66; 23, 31, 43, 47 (ramified) Hoffman + LP; Weil above | — (R88-TCA itself, two derivations) | holds ✓ |

W1 does not occur (every failure is at a named stable residue place, and ℚ(√47) passes); W2 does not occur (2, 3, 7 classified twice; plant
"dyadic −1 read as 3" and plant "flip the symbol at 7" are both caught by the PARI route); W3 does not occur (each failing place carries a
periodic four-colouring). **CTL: TRUE**, for the right reason.

### 2.2 CLS

**⟹ [hand].** If `L(F) ≤ 4`, some stable place's level-one target is four-colourable (R-a: residue field `𝔽₃`, `𝔽₇`, a ramified dyadic place,
or inert dyadic with `Q ≤ 32`); the pull-back of a largest colour class is a measurable independent set of density `≥ 1/4` in `Cay(O_v, T_v)`,
so the all-levels ratio is `≥ 1/4`. Contrapositive: the class condition ⟹ `L(F) ≥ 5`. Holds for every real number field.

**⟸ [hand, given R-b's inputs].** If `L(F) ≥ 5`, no stable place has residue field `𝔽₃` or `𝔽₇`, none is a ramified dyadic place, and every
inert dyadic one has `Q ≥ 64`. By R-b every odd stable place has all-levels ratio `< 1/4`, and so does every inert dyadic place over an
**unramified** base.

**GAP at one step, and it is realised.** An inert dyadic stable place over a **ramified** base with `Q ≥ 64` has level-one ratio `≤ 1/7`
(`U₁₂₈`, floor 8) but no held lemma bounds its new levels. It occurs: **`F = ℚ(√3)·M₇`, `M₇` the degree-7 subfield of `ℚ(ζ₂₉)`** — totally
real of degree 14; its one dyadic place has `(e, f) = (2, 7)` and is inert in `L/F` (`Q = 128`); 3 is stable with residue field `𝔽_{3⁷}`; 7 is
not stable (PARI, `data/fs100/x23v/gapfield.gp` → `gapfield.out`; locally `F_v = U₇(√3)`, `U₇` unramified of odd degree, so neither `−1` nor
`−3` is a square in `U₇` and `F_v(i) = F_v(√−3)` is unramified over `F_v`). So `L(F) ≥ 5` there, and CLS's ⟸ at `F` needs the missing
step. **The missing lemma:** "a dyadic Lemma P" — on an inert dyadic tower over a ramified base, the characters new at level `m ≥ 2` have
`|λ|/d < 1/3` (or directly: all-levels ratio `< 1/4`). **CLS: TRUE for every real number field with no inert dyadic stable place over a
ramified base of norm `Q ≥ 64`; GAP there (the missing lemma named; realised at ℚ(√3)·M₇).** The named risks: `q = 27` — covered at level one
(Hoffman floor 6) and, over an unramified base, by G54; over a ramified base by FS86-LP read with `q` (reading note in R-b); ramified stable
places — odd ones by FS86-LP, ramified-in-`L/F` dyadic ones have ratio `1/2` and `L ≤ 2` (both sides of CLS false); the archimedean part at `n`
places does not enter CLS (a condition on stable places only).

### 2.3 SPC

**(lit): "T-C(A)'s statement holds at `S = ∅`" ⟹ A⁺ at `S = ∅`, SP-Cor, and `χ ≥ 5` given MR — TRUE for every real number field** [hand].
A⁺'s proof (SI-3, SI-4, N2, then T-C(A) as a black box) and SP-Cor's (amenability of `R ⋊ U`, `σ_μ` `U`-invariant, R-U, A⁺ with its remark
(ii)) use no property of ℚ(√47): R-U and N1 are stated for every real number field (J45-RU, "with `G′_S` … R-U holds for every real number
field"); SP-if's archimedean circle needs one real place, which `F ⊆ ℝ` supplies; `−1 ∈ U` always. X05V's P0–P8 re-run verbatim with `F`
for ℚ(√47). Nothing about the number of real places enters **A⁺** at all.

**(cls): the class condition ⟹ T-C(A)'s statement at `S = ∅` — where the archimedean step lives.** R88-TCA's count: extend the colouring to
`G_∅ = ∏_{stable} O_{L_v} × (L⊗ℝ)` (R88-TC-ext; density by strong approximation, integrality by Lemma C′ — this is where row 100's exception
scopes the claim), split `G_∅ = X × Y′`, bound each colour class's density by the ratio of the product, and `1 ≤ 4·max(α(Y′), r_X) < 1`.
- **`n` real places — the named risk — is not a risk** [hand; a re-walk of C14]. By weak approximation for the `F`-rational torus `x² + y² = 1`,
  `U` is dense in `(S¹)^{r₁}` (and in every finite product of local circles), so the archimedean compact part is the categorical product
  `UD(ℝ²)^{×r₁}`. C14.2 (a) gives each factor ratio `m₁ ≤ 0.2470` with error `η`; C14.3 is an induction on the number of factors ("ratio of a
  product is the larger ratio"; its (R2) is `I₁ × G₂`), so `UD(ℝ²)^{×n}` has ratio `m₁` with error `nη` **for every `n`**, and C14's windows
  explicitly allow `s` archimedean factors. X03D's `Λ = 0.4028 > 1/3` is true and irrelevant: the product's least normalised eigenvalue is
  `−0.4028` at **every** `n ≥ 1` (one factor at `J₀`'s minimum, the rest trivial), so Hoffman gives `0.2871 > 1/4` already at `n = 1, 2`;
  ℚ(√47) (`n = 2`) was never done by first moments, and the `m₁` + Zhang-count route has no `n`-dependence.
- **Complex places of `F` (not totally real `F`) — a step no cited proof covers.** At a complex place `w` of `F`, `L_w ≅ ℂ × ℂ` and
  `T_w = {(z, 1/z) : z ∈ ℂ^×}` (the two extensions of `w` multiply to `N_{L/F}(u) = 1`): non-compact, and C14.2 has no archimedean lemma of
  this kind (its windows `Q_n^s` are real-place squares). **Lemma X23V-CX [hand, one mind]:** restrict to the compact circle
  `T′_w = {(e^{iθ}, e^{−iθ})} ⊆ T_w`; as vectors of `ℝ⁴`, `(cos θ, sin θ, cos θ, −sin θ) = cos θ·a + sin θ·b` with `a ⊥ b`, `|a| = |b| = √2`, so
  `Cay(ℂ², T′_w) ≅ ℝ² × UD_{√2}(ℝ²)`, ratio `m₁` with C14's (R1) (Fubini over the orthogonal plane, tiling in the circle's plane) and (R2)
  (the tiled set times `ℝ²`). An a.e.-proper colouring for `T_∅` is a.e.-proper for the smaller connection set with `T′_w` at `w`, so the count
  runs with `X` containing `Cay(ℂ², T′_w)` at ratio `m₁`. So the complex places are harmless, **by a lemma added here**.
- **Stable places.** Only finitely many have all-levels `|λ_min/d| ≥ 1/3` (residue fields 3, 7, 11, 19 and dyadic ones; Weil and FS86-LP
  put every other odd place below `1/3`), so `X` = the archimedean factors ∪ the places above 11, 19 ∪ all dyadic stable places (at most
  `[F:ℚ]`), each of ratio `< 1/4` **by the hypothesis** (C14.2 (b)'s proof is the full-coset argument, valid on any compact tower), is a
  finite product (C14.3); `Y′` is the tail, Hoffman ratio `ρ/(1+ρ) < 1/4` with `ρ = sup |λ_min/d| < 1/3` attained (Weil makes it a max).
  Under (cls) the dyadic GAP of 2.2 does not arise: the hypothesis supplies that place's ratio.

**SPC: TRUE for every totally real `F` outside row 100's exception, under both readings; for `F` with complex places TRUE under (lit), and
under (cls) TRUE given Lemma X23V-CX (added here, one mind).** Grades: A⁺/SP-Cor field-free [hand, J45 + this re-walk]; the class-form step
[hand; J28D one mind, re-walked here from statements, not blind to J28D's summary]. *Note:* under the hypothesis, row 100's exception is
automatic — a ramified stable dyadic place has ratio `1/2`.

### 2.4 COR

As written — "SPC and CLS together give `χ(F²) ≥ min(L(F), 5)`" — **GAP:** for `L(F) ≤ 4` neither SPC nor CLS says anything (CLS's
hypothesis fails and SPC does not apply); that half is **row 99** (`χ(F²) = L(F)` at `L ≤ 4`, every real number field, [hand, three
derivations]); and SPC's `χ ≥ 5` is "given MR", which COR drops. **With row 99 and MR added: TRUE for every real number field outside row
100's exception, except where CLS's ⟸ has its GAP** (an inert dyadic stable place over a ramified base with `Q ≥ 64`; realised at
ℚ(√3)·M₇), and with Lemma X23V-CX for non-totally-real `F`. Proposed wording: "Given MR and row 99, SPC and CLS give `χ(F²) ≥ min(L(F), 5)`
for every real number field outside row 100's exception with no inert dyadic stable place over a ramified base of norm `≥ 64`."

### 2.5 Q35

`F = ℚ(√3,√5)`, `L = F(i)`. **Dyadic:** `15 ≡ 7 (mod 8)`, so `−1 ≡ 15` in `ℚ₂^×/ℚ₂^{×2}` lies in the Kummer group `⟨3, 5⟩`: `i ∈ F_v`, the
dyadic place (`e = 2`, `f = 2`) is **split** in `L` — not stable, so `F` is outside row 100's exception (G35: an odd square class `≡ 7 (mod 8)`,
the wall broken). **Odd:** stable ⟺ `p ≡ 3 (mod 4)` with residue degree one in `F/ℚ` ⟺ `p ≡ 3 (mod 4)`, `(3/p) = 1` (⟺ `p ≡ 11 (mod 12)`), `(5/p) = 1`
(⟺ `p ≡ ±1 (mod 5)`) ⟺ **`p ≡ 11, 59 (mod 60)`**: 11, 59, 71, 131, 179, 191, 239, 251, 311, 359, … (both routes, every `p < 400`), each place
with residue field `𝔽_p`; 3 has `(e, f) = (2, 2)` (`𝔽₉`), 5 is `≡ 1 (mod 4)`; **3, 7, 19, 23, 31, 43, 47 not stable** ✓. **The class condition:**
the four places above 11 by FS-66 (11 unramified in `F`), 59 by Weil (`2√59/60 = 0.256 < 1/3`), the rest by Weil; four real places by 2.3. So
T-C(A) holds at `S = ∅` (R88-TCA's class form at `n = 4`), SPC gives `χ ≥ 5` given MR, and the stable place above 11 gives `χ ≤ χ(Γ₁₁) = 5`
(row 52; the place is conjugation-stable with residue ring `𝔽₁₁[i] = 𝔽₁₂₁`, no `√−1` in `𝔽₁₁`). `L(ℚ(√3,√5)) = 5`. **Q35: TRUE under the
intended reading** (residue degree one in `F/ℚ`); as literally worded its list clause is self-contradictory (Q-b) — a correction owed.

### 2.6 D-1

"4-thick" is `λ*_v < 1/3` (J48-THK), so Hoffman gives all-levels ratio `≤ λ*/(1 + λ*) < 1/4` at every stable place: `N₄(F) = ∅` ⟹ the class
condition ⟹ (SPC, totally real) `χ ≥ 5` given MR. **D-1: TRUE** [hand], as a special case of SPC; "outside row 100's exception" is automatic
(a ramified stable dyadic place has `λ_min = −d`, not 4-thick). *Note on J48's own route:* T-J39-3's `Y_{F,4} = UD(ℝ²) × ∏_{N₄} G_v` has one
`UD(ℝ²)`; for a totally real `F` of degree `n` the archimedean factor is `UD(ℝ²)^{×n}`, which also has no CP four-colouring by C14.3 (ratio
`m₁`) — J48-N4cor's "for every totally real `F`" holds with that reading.

### 2.7 Would-have-searched-here log (stage 2)

- Would have searched for a field realising the CLS gap by sweeping number fields. Instead: derived the local shape (`U_f(√3)`, `f` odd ≥ 7)
  and built one field by hand (ℚ(√3)·M₇, `M₇ ⊂ ℚ(ζ₂₉)`: 2 and 3 have order 28 mod 29), confirmed by one PARI factorisation (seconds).
- The stable-place tables are a complete exact enumeration of a set the derivation fixed (primes 2, 3, 7 decide the class condition; the
  `< 400` table is a cross-check of a congruence already derived). No search.

## Stage 3 — SAVED (the write-up; committed before any fenced file is opened)

### 3.1 Verdicts

| claim | verdict | the one-line reason |
|---|---|---|
| **CTL** | **TRUE** | fails at K, ℚ(√2,√3), ℚ(√11) (dyadic inert `Q = 2`; and 7 at ℚ(√11)), ℚ(√23) (7), each at a named stable place with a periodic four-colouring; holds at ℚ(√47); no wrong-reason pass (§2.1 W1–W3) |
| **CLS** | **GAP at one step** (TRUE elsewhere) | ⟹ TRUE for every real field; ⟸ TRUE except at an inert dyadic stable place over a ramified base of norm `Q ≥ 64`, where no held lemma bounds the new levels; the case occurs (ℚ(√3)·M₇, `Q = 128`). Missing lemma: a dyadic Lemma P |
| **SPC** | **TRUE** for totally real `F`; for `F` with complex places TRUE given Lemma X23V-CX (added here, one mind) | A⁺ and SP-Cor are field-free given T-C(A)'s statement; the class-form step's archimedean factor at `n` real places is C14.3's induction (ratio `m₁` at every `n`) — the advisor's named risk does not bite, and first moments fail already at `n = 1` |
| **COR** | **GAP as written** | for `L ≤ 4` it needs row 99, and "given MR" is dropped; with both added, TRUE outside CLS's gap (and with X23V-CX for non-totally-real `F`) |
| **Q35** | **TRUE** (intended reading) | dyadic split (`15 ≡ 7 mod 8`); stable = above `p ≡ 11, 59 (mod 60)`; 3, 7, 19, 23, 31, 43, 47 not stable; FS-66 at 11, Weil above; `χ ≤ 5` from 11. Literal wording self-contradictory (Q-b) |
| **D-1** | **TRUE** | 4-thick ⟹ Hoffman ratio `< 1/4` ⟹ the class condition; a special case of SPC |

**C0 scored.** CTL 0.9 → TRUE; CLS 0.65 → GAP (the named dyadic risk was the live one; `q = 27` and ramified odd places were not); SPC 0.6 →
TRUE (my risk was complex places, the advisor's `n > 2`; neither kills it, the first needs a lemma); COR 0.5 → GAP as written; Q35 0.75 →
TRUE; D-1 0.85 → TRUE. I leaned toward GAP on COR and CLS before deriving; both GAPs are specific (a missing input named, a field exhibited).

### 3.2 Corrections owed (proposed; the front-page lane decides)

1. **Q35's wording** (`plans/CRUNCH-2026-09-26-x2x3-queue.md` list X23): "primes of residue degree one in `L/ℚ(√3,√5)` that are inert in
   `L/F`" → "primes of residue degree one in `ℚ(√3,√5)/ℚ` (inert in `L/F`) — exactly those above `p ≡ 11, 59 (mod 60)`".
2. **SPC's gloss** identifies T-C(A) with its class condition. Any ledger text should read: "for every real number field whose stable places
   all have all-levels ratio `< 1/4`, T-C(A) holds at `S = ∅` (R88-TCA's class form; complex places by X23V-CX) and then J45's A⁺ and SP-Cor
   hold with J45's proofs".
3. **COR** should name its inputs: "given MR and row 99".
4. **CLS / COR scope:** add "with no inert dyadic stable place over a ramified base of norm `≥ 64`" until a dyadic Lemma P is proved.
5. **J48-N4cor / T-J39-3** (stub §2): for a totally real `F` of degree `n`, `Y_{F,4}`'s archimedean factor is `UD(ℝ²)^{×n}`; the conclusion
   stands by C14.3.
6. **Frontier item 18** ("Not landed: five over ℚ(√3,√5)"): given MR (and SPC's class form at four real places), `χ(ℚ(√3,√5)²) = 5`; an
   exposed five-clause of the conjecture met modulo MR.

### 3.3 Stub to mint or re-aim

- **A dyadic Lemma P** (FS-100, or a line in FS-68's stub): on an inert dyadic tower over a ramified base (`e(𝔭|2) ≥ 2`, `Q ≥ 64`), bound the
  characters new at level `m ≥ 2` (the odd analogue is FS86-LP, `|λ| ≤ 2p^{m−1}`); its first instance is ℚ(√3)·M₇ at `Q = 128`, `e = 2`.
  Decides CLS's gap and COR's scope. Solver-free.

### 3.4 Would-have-searched-here log (stage 3)

- None.

## Stage 4 — SAVED (fallback: X23D's lemma statements, read after stage 3's commit `3249a87c`)

*Opened only `plans/FS100-X23D-derivation.md`'s verdict paragraph and its lemma statements (stage 2 there: CTL, CLS; its SPC, COR, Q35, D-1
were not yet written at 06:39). Its §2.3 lemma lines carry one-line proof sketches inline; I read the dyadic one because it bears on my GAP.*

### 4.1 Agreement and disagreement

| claim | X23D (stage 2) | X23V (stage 3) | reconciliation |
|---|---|---|---|
| CTL | TRUE, every control for the stated reason | TRUE, no wrong-reason pass | agree; two tools, independent (`tools/x23d_class.py`, `tools/x23v_places.py`) |
| CLS | TRUE for every real number field (dyadic `Q ≥ 64` closed by "the dyadic Lemma P [hand, new]") | GAP at an inert dyadic stable place over a ramified base, `Q ≥ 64` (realised at ℚ(√3)·M₇) | **X23D's dyadic Lemma P is exactly my missing lemma.** Re-derived from its statement (below): TRUE, and it does not use the base's ramification. **CLS: TRUE**, two derivations (X23D's; mine plus X23D's lemma, re-derived) |
| `q = 27` | "not a risk": `λ_min(Γ₂₇) = −8`, Hoffman `2/9`, an H*-place | covered, but I attributed "floor 6" to Hoffman | X23V-H confirms `−8` independently; **my R-b's attribution at 27, 43, 47 was wrong** (Hoffman floors there are 5: ratios `0.2222, 0.2138, 0.2111`; G56's floor 6 is by certificate) — the conclusion `< 1/4` stands |
| Q35's list | X23D's quotation check (its Q6) flags the advisor's list as a paraphrase, agreeing in substance | my Q-b flags the queue's own wording as self-contradictory | two different defects, same substance; both are corrections owed |

**The dyadic Lemma P, re-derived from X23D's statement [hand].** Let `L_𝔓/F_v` be unramified quadratic with residue fields `𝔽_{Q²}/𝔽_Q`,
`Q = 2^f`, and `π` a uniformiser of `F_v` (hence of `L_𝔓`), `e(F_v/ℚ₂)` arbitrary. For `m ≥ 2`, `N(1 + π^{m−1}x) = 1 + π^{m−1}Tr(x) +
π^{2m−2}N(x) ≡ 1 + π^{m−1}Tr(x) (mod π^m)`, so the fibre of `S_m → S_{m−1}` over `s̄` is `{s + π^{m−1}s·t : t ∈ 𝔽_Q}` (the trace-zero line of
`𝔽_{Q²}/𝔽_Q` is `𝔽_Q` in characteristic 2): `Q` points. A character `ψ` new at level `m` is `ψ(π^{m−1}y) = ψ₀(βy)`, `β ≠ 0`; on a fibre it sums
to `Q·ψ(s)` if `Tr_{𝔽_{Q²}/𝔽_Q}(βs₀) = 0`, i.e. `βs₀ ∈ 𝔽_Q`, and to 0 otherwise (`s₀` the residue of `s`). Two admissible `s₀ ∈ μ_{Q+1}` differ by
an element of `𝔽_Q^× ∩ μ_{Q+1} = {1}` (`gcd(Q − 1, Q + 1) = 1`), so at most one residue class, `Q^{m−2}` points of `S_{m−1}`, contributes:
`|λ_ψ| ≤ Q^{m−1}`, against degree `Q^{m−1}(Q + 1)`. Nothing uses `e`. So at ℚ(√3)·M₇ (`Q = 128`, `e = 2`) every level has `|λ|/d ≤ max(19/129,
1/129) < 1/3` and ratio `< 1/4`. ✓ — **my stage-3 GAP on CLS closes, and with it the CLS-gap clause of COR.**

### 4.2 The Hoffman table, checked independently (X23V-H)

`tools/x23v_hoffman.py` → `data/fs100/x23v/hoffman.out` (0.6 s; the circle `μ_{q+1}` in `𝔽_{q²}`, the absolute trace): the values in the
theorems table; controls `U₂ = −1`, `Γ₃ = −2`, `U₆₄ = −15` exact, `Γ₇`'s Hoffman `0.3597 ≥ 1/4`; plant `wrong-circle` (`μ_{q−1}`) breaks three
controls (`hoffman-plant.out`, exit 1). `Γ₂₃`'s `0.331695` matches J48-N4's figure; `Γ₃₁`'s `0.333328` matches G54's `1/3 − 4.9·10⁻⁶`.

### 4.3 Verdicts after stage 4 (these supersede §3.1 where they differ)

| claim | verdict |
|---|---|
| CTL | **TRUE** |
| CLS | **TRUE** (my GAP closed by X23D's dyadic Lemma P, re-derived here) |
| SPC | **TRUE** for totally real `F`; for `F` with complex places TRUE given Lemma X23V-CX (mine, one mind) — X23D's SPC not yet written, so no comparison |
| COR | **GAP as written** (needs row 99 for `L ≤ 4`, and "given MR"); with both, TRUE (and X23V-CX for non-totally-real `F`) |
| Q35 | **TRUE** (intended reading; wording owed) |
| D-1 | **TRUE** |

Correction owed 4 of §3.2 (the dyadic scope clause) is withdrawn; ℚ(√3)·M₇ stays useful as the first field where the dyadic Lemma P is used.

### 4.4 Would-have-searched-here log (stage 4)

- None; the Hoffman table is a complete computation over sets the derivation fixed (the named `q`, `Q`).
