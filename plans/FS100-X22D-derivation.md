# FS-100 / crunch ×2×3 wave 3 — job X22D: the type-(B) fields given MR, and SEL-k (derivation record)

*de Bruijn (Opus 5.5), job X22D, 2026-09-26, from 11:32 UTC. Brief: `data/crunch-2026-09-26-x2x3/briefs/X22D-type-B-derivation.md`
(with `STANDING-RULES.md`); stop time 12:50 UTC (owner's change). Working files `data/fs100/x22d/`; checks `tools/x22d_checks.py`.
One mind. A blind verifier, X22V, works on the same claims; no contact.*

## Theorems this phase proved

*(Filled at each stage; grades as `CLAUDE.md` § Notation.)*

| id | statement (one line) | grade | address |
|---|---|---|---|
| X22D-C0 | ℚ(√59), ℚ(√83), ℚ(√131): one prime of `L = F(i)` above 2, stable, and inert in `L/F` (e = 1, f = 2 over the ramified prime of `F`); so outside row 100's exception | [hand + tools exact] | Stage 1, §1.4; `tools/x22d_checks.py` |
| X22D-QR | given MR, every `R ⋊ U`-invariant random four-colouring over ℚ(√59), ℚ(√83), ℚ(√131) is a.s. a pullback (`F_{μ,rot} = R ∩ 𝔓⁴`); no T-B1 | [hand, one mind; two routes: J38's step (3b) alone, and a selection through FL-K, Theorem C at `S = ∅`, gap-freeness] | Stage 2, §2.2 |
| X22D-RT | given MR, every translation-invariant random four-colouring is rotationally transient (non-Pull rotated windows have upper Banach density 0 in `U`); so Q-μ ⟺ TR-ROT, and T-B1 ⟹ TR-ROT | [hand, one mind] | Stage 2, §2.3 |
| X22D-EF | for every number field and finite `S`, `H_{E_S}` and `H_E` are `L²` of rotation-invariant factors (`E_S` = the `τ_S`-continuous characters) | [hand, one mind; textbook ingredients] | Stage 2, §2.2 step 1 |
| X22D-TRM | given MR, every four-colouring of a type-(B) plane outside Pull is rigid-motion-transient (non-Pull windows have upper Banach density 0 in `R ⋊ U`); so row 88 ⟺ "no rigid-motion-transient colouring" | [hand, one mind] | Stage 3, §3.1 |

## Stage 1 — SAVED (the quoted inputs, the quotation check, C0 per claim)

### 1.1 The inputs, copied verbatim (queue `plans/CRUNCH-2026-09-26-x2x3-queue.md` §7: its "where MR stands" paragraph, and list X22)

> **Where waves 1–2 left MR** (from the reports, `data/crunch-2026-09-26-x2x3/reports/`): EF_F⁺ is TRUE by two derivations (X01D; X12B blind,
> by its own route), and X01V's GAP at the multiplier step was absorbed by X12B's rational-unit-vector multipliers. PE-2 is TRUE by X02D and
> X02V blind, given EL2021 Thm 1.2 through (★); PE-1 as stated is FALSE. SP-Cor passed X05V blind. So **MR(F) holds for every real number
> field at [hand] grade, with the scope of row 100's exception** (a ramified stable dyadic place, where `R = O′` is not proved; X09C's audit).
> Every claim below is stated with that scope and asks whether its field is outside the exception. **"Given MR"** below means: given MR(F) at
> the grade and scope just described; each job names it as an input and does not re-derive it.
> 
> ### List X22 — the type-(B) fields ℚ(√59), ℚ(√83), ℚ(√131) (X22D derives; X22V verifies blind)
> 
> Inputs quoted verbatim: T-J38-2 and T-J38-3 (stub §2, J38 block); row 111: "`F(R) ≠ 0` iff every translation-invariant random four-colouring of
> the plane is a pullback from the tight place (Q-μ) and no colouring is transient — none whose orbit closure's invariant measures all live on
> the pullbacks without its being one (Q-tr)".
> 
> The claims:
> - **C-0.** "ℚ(√59), ℚ(√83) and ℚ(√131) lie outside row 100's exception: their stable dyadic place is inert, not ramified, in `L/F`."
> - **C-1.** "Given MR, at `F ∈ {ℚ(√59), ℚ(√83), ℚ(√131)}`, Q-μ holds: every translation-invariant random four-colouring of `F²` is almost
>   surely a pullback from the tight place. T-B1 is not used."
> - **C-2.** "Given MR, at those fields: `F(R) ≠ 0` (row 88) iff Q-tr (no four-colouring is transient)."
> - **C-3.** "Given MR, at those fields: T-B1 ⟺ row 88 ⟺ Q-tr."
> - **C-4.** "Over ℚ(√59), no four-colouring of the plane is transient." (TRUE, FALSE, or GAP at a named step. It asks whether EF_F⁺'s method —
>   Lemma 3.1′, EF's pigeonhole against polynomially many rational unit-vector multipliers, Lemma Z's wandering shells — transfers from invariant
>   measures to a single colouring's orbit.)
> - **SEL-k** (the advisor's F2; a reduction, for every `k`). "For every real number field `F` outside row 100's exception and every `k ≥ 2`,
>   given MR: `F²` is `k`-colourable iff it has a translation- and rotation-invariant random `k`-colouring whose spectral measure is carried by
>   `E`." **Named risk:** it rests on X03D's FL-K (the relatively independent self-joining over the `E`-factor), which is one mind; check it
>   blind. At `k = 5` over ℚ(√167) it would turn six into row 110's window question at `{∞, 23, 43, …}`, graded as a reduction, never as a
>   bound.

### 1.2 Quotation check (standing rule 5)

| quotation (where it appears) | source checked | result |
|---|---|---|
| Row 111 inside list X22 ("`F(R) ≠ 0` iff every translation-invariant random four-colouring … (Q-tr)") | `LEDGER.md` row 111 | **verbatim** |
| T-J38-2 (stub §2.3) | J38's poster `plans/POROS-2026-09-25-wanted-poster-59.md` §3.5 | verbatim for (i), (ii); (iii) elides with "…" the definition of MR(F) and the sentence "Since `F(R) ≠ 0` gives `X₄ = Pull`, finite, hence T-B1:" — an elision, **no change of meaning** |
| T-J38-3 (stub §2.3) | J38 §4.7 as quoted in the stub's BC-7 row | verbatim; J48's correction ("on each `R`-coset") carried in the stub |
| Brief: "Planner's claim C-1 is that MR alone gives Q-μ (every invariant random four-colouring is a pullback)" | queue list X22, C-1 | **paraphrase that drops a word**: C-1 says "every **translation**-invariant random four-colouring". The difference is exactly the step this record finds open (Stage 2): I work from the queue's verbatim C-1 |
| Brief: advisor's F3, "only the conditional moves" | `plans/POROS-2026-09-26-x2x3-crunch.md` line 413: "Only the conditional moves: 'row 88 ⟺ T-B1' becomes unconditional. Transience is outside the reach of the invariant-measure tools." | verbatim (the brief quotes the first clause) |
| SEL-k (queue) vs the advisor's F2 | same file line 410–412: "MR + FL-K ⟹ every `k`-colouring of `F²` induces one whose spectral measure is carried by `E`" | the queue's SEL-k is a faithful iff-form of F2 (it adds "translation- and rotation-invariant random" and the trivial converse) |
| Addendum: the advisor's sketch and correction (06:24, 06:25) | relayed in the brief only; not found in the advisor's record as of 06:43 | taken as quoted in the brief; one mind |
| X03D-FL-K | `plans/FS100-X03D-derivation.md` §3.2 | read from source (statement and proof) |
| Row 112 (Theorem C), R88-TA, R88-TC-count, R88 §G (T-C′'s last sentence) | `LEDGER.md` row 112; `plans/R88-derivation.md` §1, §2, §G | read from source |
| J45's SI-3, SI-4, B⁺, R-U, SP (J46-8) | stub §2.2 table (verbatim from J45/J46) | read from the stub; J45's record not reopened |

### 1.3 C0 — probabilities before derivation (06:44)

| claim | P(TRUE as stated) | the step I expect to decide it |
|---|---|---|
| C-0 | 0.95 | the splitting of 2 in `ℚ(√d, i)`, `d ≡ 3 (mod 8)` |
| C-1 | 0.35 | T-J38-2's use of T-B1 is in producing an `R ⋊ U`-invariant measure off Pull; for a merely **translation**-invariant `μ`, `σ_μ` is not `U`-invariant, so MR does not apply to it, and the `U`-average can move mass onto Pull (R88 §G, T-C′'s last sentence, J28D's reading). I expect: TRUE for rotation-invariant measures, GAP for translation-invariant ones |
| C-2 | 0.35 | the same step (⟸ needs C-1) |
| C-3 | 0.35 | the same step |
| C-4 | 0.05 TRUE, 0.9 GAP | transient colourings are invisible to every invariant measure (R88-B2-3) |
| SEL-k | 0.75 | whether the `E`-part is the `L²` of a factor (so the relatively independent joining exists) at every `k`; MR kills the unit correlations of the `E`-null part |

### 1.4 C-0 — TRUE [hand + tools exact]

`d ∈ {59, 83, 131}` has `d ≡ 3 (mod 8)`. In `F = ℚ(√d)`, `d ≡ 3 (mod 4)`, so `2 = 𝔭²` (`e = 2, f = 1`). In `L = ℚ(√d, i)`: 2 is ramified in `ℚ(i)`
and inert in `ℚ(√−d)` (`−d ≡ 5 (mod 8)`), so every prime of `L` above 2 has `e ≥ 2`, `f ≥ 2`, and `efg = 4` forces one prime `𝔓` with
`e = f = 2`. Then `e(𝔓|𝔭) = 1`, `f(𝔓|𝔭) = 2`: **inert in `L/F`**, and, being the only prime above `𝔭`, fixed by conjugation (stable). The other
stable places are odd primes of `F` inert in `L`, unramified in `L/F` (`L/F` ramifies only above 2). Row 100's exception ("possibly at a ramified
stable dyadic place") therefore does not arise. **Check** (`tools/x22d_checks.py`, PARI `idealprimedec`, seconds): 59, 83, 131 read inert; the
control ℚ(√5), row 100's named exception, reads ramified; ℚ(√47) reads split (no stable dyadic place). **Plant** (`--plant`: force `e(𝔓|𝔭) = 1`):
the ℚ(√5) control goes RED and the script exits 1 — watched firing.

### 1.5 Would have searched here (Stage 1)

- None. The one computation is an exact prime decomposition in three quartic fields and two controls.

## Stage 2 — SAVED (C-1, the key claim; C-0 was Stage 1)

**Verdict. C-1 as stated: GAP** — at one named step, **TR-ROT** (below), which is where T-B1 entered T-J38-2 and which MR does not reach.
**Its rotation-invariant form is TRUE** (X22D-QR): given MR, every `R ⋊ U`-invariant random four-colouring over a type-(B) field is almost
surely a pullback, with no T-B1 and no density input beyond Theorem C's own. Neither the planner's C-1 nor the advisor's F3 is right as
stated: C-1 over-reaches by one quantifier ("translation-invariant"); F3's "only the conditional moves" misses that the rotation-invariant
half of Q-μ moves, and that what is left of Q-μ is itself a transience statement (X22D-RT).

**Notation** (J38 §3; J45): `F` of type (B); `R = ℤ[U]`; `X₄ = X₄(F)`; Pull the finite, `Aff_F`-invariant set of pullbacks (R88-TA (i));
`g(x) = e_{c(x)}` the tetrahedral embedding (`⟨e_j, e_l⟩ = (4/3)δ_{jl} − 1/3`); `σ_μ` its trace spectral measure (`σ̂(y) = E⟨g(0), g(y)⟩`,
`σ(R̂) = 1`, `σ̂(u) = −1/3` on `U` by properness); `E_S = T + A + Fin_S`, `E = ⋃_S E_S`; `m` Haar measure on `R̂`.

### 2.1 Which step of T-J38-2 uses T-B1 (J38 §3.5, read line by line)

| step | what it does | uses T-B1? |
|---|---|---|
| 1 | Pull clopen, `X′` closed and `Aff_F`-invariant | **yes** (isolation makes each `{p}` a cylinder) |
| 2 = (i) | an invariant `μ` on `X′` has `μ(Pull) = 0`; Theorem C would carry it by Pull if its spectrum lay on some `E_S` | no (T-B1 only makes `X′` a compact space to put `μ` on) |
| 3 = (ii) | **(3a)** `X′ ≠ ∅` compact ⟹ an `R ⋊ U`-invariant `ν` on `X′`, so `ν(Pull) = 0`; **(3b)** from any `R ⋊ U`-invariant `ν` with `ν(Pull) = 0`: B⁺ at `S = ∅`, `U`-invariance of `σ_ν` moves `u` to 1, R-U, so `τ = σ_ν|_{R̂∖E}` is an SP witness | **(3a) yes; (3b) no** |
| 4 = (iii) | MR forbids `τ`; so `X′ = ∅` | no |

So **T-B1 is used exactly once: to manufacture, from a single colouring outside Pull, an `R ⋊ U`-invariant measure that gives Pull no
mass.** Step (3b) never looks at where `ν` came from. That gives the rotation-invariant theorem at once, and shows what the
translation-invariant one needs.

### 2.2 X22D-QR — given MR, every `R ⋊ U`-invariant random four-colouring is a pullback [hand, one mind; two routes]

> **X22D-QR.** Let `F` be ℚ(√59), ℚ(√83) or ℚ(√131) (more generally a real field in Theorem C's class where B⁺ and R-U hold), and assume
> MR(F). Then every `R ⋊ U`-invariant Borel probability `μ` on `X₄(F)` is carried by Pull. Equivalently `F_{μ,rot}(R) = P(R) = R ∩ 𝔓⁴`, where
> `F_{μ,rot}` is the set of differences that every `R ⋊ U`-invariant `μ` identifies almost surely.

*Route (a), J38's step (3b) with (3a) removed.* Pull is finite, Borel and `Aff_F`-invariant, so if `μ(Pull) < 1` then `μ′ := μ(· ∖ Pull)/μ(X₄ ∖ Pull)`
is `R ⋊ U`-invariant with `μ′(Pull) = 0`. Step (3b) applies to `μ′` verbatim and produces a `U`-invariant, finite, positive, `E`-null `τ` with
`∫ Re χ(1) dτ < 0`, which MR forbids (J46-8, its trivial direction: `m̂(1) = 0`). ∎ *Inputs:* B⁺ (J45, two derivations; itself given T-C and
FS38-D2-A), R-U and J45-N1 (two derivations), MR.

*Route (b), independent of B⁺'s statement (the selection).* Let `μ` be `R ⋊ U`-invariant.
1. **The `E`-factor exists.** For each finite `S`, `E_S` is exactly the set of characters of `R` continuous for the group topology `τ_S`
   induced by `R → R̂_prof × (L ⊗ ℝ) × ∏_{v∈S} L_v` (a `τ_S`-continuous character extends to the closure of `R` in that product, hence, by
   Pontryagin extension, to a character of the product, which is torsion × archimedean × `S`-local; the converse is clear). So
   `H_{E_S} := {f ∈ L²(μ) : σ_f(R̂ ∖ E_S) = 0} = {f : x ↦ U_x f is τ_S-continuous}` (Stone–Bochner). For bounded `f, h` in it,
   `‖U_x(fh) − fh‖₂ ≤ ‖f‖_∞‖U_x h − h‖₂ + ‖h‖_∞‖U_x f − f‖₂`, and Lipschitz truncations stay in it; so `H_{E_S} = L²(𝒜_S)` for a factor
   `𝒜_S`. With `S_n` exhausting the split places, `E = ⋃_n E_{S_n}` increasingly, so `H_E = L²(𝒜_E)`, `𝒜_E := ⋁_n 𝒜_{S_n}`. `E` is
   `U`-invariant (J45-N1), so `𝒜_E` is rotation-invariant. *(No Lemma C, no ring structure: this step holds over every number field.)*
2. **FL-K with `𝒜_E`** (X03D-FL-K's proof, which uses only `h = E[g | 𝒜] = P_E g` and properness): with `p(x) = P(c(x) = · | 𝒜_E)`,
   `h = Σ_j p_j e_j`, `ν := σ|_{R̂∖E}` and `(c¹, c²)` the relatively independent self-joining over `𝒜_E`,
   `ν̂(u) = −(4/3) P(c¹(0) = c²(u))` for `u ∈ U`. (Re-derived here: `σ̂(u) = −1/3`, `σ̂_E(u) = E⟨h(0), h(u)⟩ = (4/3)E⟨p(0), p(u)⟩ − 1/3`,
   `E⟨p(0), p(u)⟩ = P(c¹(0) = c²(u))`.)
3. **MR kills the cross-monochromatic rate.** `σ` is `U`-invariant (`μ` is), `E` is `U`-invariant, so `ν` is `U`-invariant, finite, positive
   and `E`-null: MR gives `ν = a·m`, and `m̂(u) = 0` for `u ≠ 0`. So `P(c¹(0) = c²(u)) = 0` for every `u ∈ U`: the supports
   `S(x) = {j : p_j(x) > 0}` are disjoint on every edge, for all edges at once almost surely (`R`, `U` countable). (This is J45-SI-3's
   equality case, reached here from MR.)
4. **Select.** `c′(x) := min S(x)` is a proper four-colouring almost surely, `𝒜_E`-measurable, with `R ⋊ U`-invariant law (conditional
   expectation onto the invariant factor commutes with the action; `min` acts on colour labels only). Its spectral measure is carried by
   `E` (its coordinates lie in `H_E`) and is `U`-invariant, so by R-U it is carried by `T + A = E_∅`. (J45-SI-4.)
5. **Theorem C at `S = ∅`** (row 112): `c′ ∈ Pull` almost surely; say `c′ = p`.
6. **Gap-freeness closes the supports.** `U` maps onto `S₄` modulo `𝔓⁴` (24 classes: R88-B2-1's count; weak approximation), and every
   four-colouring of `P₄` is gap-free (row 67, D2-A), so the neighbours `x + u` of any `x` carry, under `p`, every colour `≠ p(x)`. If
   `j ∈ S(x)` with `j ≠ p(x)`, pick `u` with `p(x + u) = j ∈ S(x + u)`: the supports meet on an edge, contradicting 3. So `S(x) = {p(x)}`,
   and `c(x) ∈ S(x)` almost surely (`P(c(x) = j, p_j(x) = 0) = E[p_j(x); p_j(x) = 0] = 0`). So `c = p ∈ Pull` almost surely. ∎

*Inputs of route (b):* MR; J45-N1; R-U; X03D-FL-K / J45-SI-3 (re-derived above); Theorem C at `S = ∅` (row 112; `[AmbrusEtAl2023]`, FS-66 at
11 and 19, …); row 67's gap-freeness. **No density bound is needed beyond Theorem C's own.** The advisor's sketch (addendum, 06:24) finished
by forcing `|S| = 1` from Hoffman-tightness, and the correction (06:25) found that step needs a per-class density `≤ 1/4` of the
set-valued classes `I_j = {y : j ∈ S(y)}` — a stationary max-over-factors bound that row 112's **statement** does not give (it is about
colourings, not independent sets; its proof's count `p_j ≤ ¼(1 − β_j) + r_X β_j` is per class and may well give it, but I did not reopen
J28D §3.2 to check). **Route (b) avoids that step:** it selects a colouring from the supports, lets Theorem C (which already contains the
count, at colouring level) make the selection a pullback, and closes the supports by gap-freeness, which is combinatorial. So the density
bound is **not** C-1's load-bearing input; Theorem C is, as in T-J38-1.

*Remark.* Route (b) at a fixed `S` is exactly the proof pattern of J45's B⁺ ("equality ⟹ carried by Pull"); what is new is only that MR
supplies the equality for every `R ⋊ U`-invariant `μ`. So X22D-QR was implicit in T-J38-2's step (3b); I state it because the records
state only the conditional (iii).

### 2.3 X22D-RT — what is left of Q-μ given MR is a rotational transience [hand, one mind]

> **X22D-RT.** Given MR(F) at a type-(B) field: for every translation-invariant random four-colouring `μ`, every finite `B ⊂ R` and every
> `δ > 0`, the set `{w ∈ U : μ(c|_{wB} ∉ Pull|_{wB}) > δ}` has upper Banach density 0 in `U`. Hence **given MR, Q-μ ⟺ no
> translation-invariant `μ` with `μ(Pull) = 0` is "rotationally transient" in this sense**, and T-B1 excludes such `μ`.

*Proof.* Let `F_n` be any Følner sequence of `U` (countable abelian). Every weak-* limit `ν` of `(1/|F_n|) Σ_{w∈F_n} w_*μ` is `R ⋊ U`-invariant
(`w` normalises `R`), so `ν(Pull) = 1` by X22D-QR. The cylinder `C_B = {c : c|_B ∈ Pull|_B}` is clopen and `Pull ∘ w = Pull`, so
`(w_*μ)(C_B) = μ(c|_{wB} ∈ Pull|_{wB})`, and its `F_n`-averages tend to `ν(C_B) = 1` along every Følner sequence and every convergent
subsequence. If the displayed set had upper Banach density `η > 0`, some Følner sequence would see it with density `→ η`, and the averages
of `μ(c|_{wB} ∉ Pull|_{wB})` would stay `≥ δη`. ∎ *T-B1 excludes it:* with `B ⊇ ⋃_{p∈Pull} B_p` (isolation windows; Pull finite), take `w`
with `μ(c|_{wB} ∈ Pull|_{wB}) > 0`; on that event `c ∘ w` agrees with a pullback `p ∘ w` on `B ⊇ B_{p∘w}`, so `c ∈ Pull`, and `μ(Pull) > 0`. ∎

### 2.4 TR-ROT, the step C-1 needs, named

> **TR-ROT.** "Over a type-(B) field, no translation-invariant random four-colouring `μ` with `μ(Pull) = 0` has every `U`-Følner average
> converge onto Pull" (equivalently, by X22D-RT: none is rotationally transient).

Why MR does not give it: MR speaks of `U`-invariant measures on `R̂`; `σ_μ` of a merely translation-invariant `μ` is not `U`-invariant, and
the `U`-average of `μ` can move mass onto Pull because Pull is closed and not open (R88 §G, T-C′'s last sentence, J28D's reading — confirmed
here as the exact point, not a reading about proofs). Nor does any spectral device repair it: `E` is not closed, so `E`-nullity does not pass
to weak-* limits of `U`-averages of `σ_μ|_{R̂∖E}`, and properness gives only the uniform constraint `σ̂(u) = −1/3`, which survives
averaging but is exactly what MR-plus-`T + A` measures satisfy. *Reading (one mind):* a rotationally transient `μ` must look like a pullback on
the window `wB` for Banach-almost every rotation `w` while agreeing with none globally; since `w` moves a finite window's split-place coordinates
by `|w|_v^{±1}`, the natural shape is a patchwork of pullbacks along split-place (ultrametric) regions — T-B1's own named obstruction (R88 §G:
"a split-dominated re-centring gives an ultrametric sphere"), now in a measure's costume. Row 91's D excludes two-pullback patchworks; three or
more phases are row 91's "three-phase case", not claimed.

**C-1's verdict, stated with its scope:**

| form | verdict | address |
|---|---|---|
| C-1 as stated ("every translation-invariant random four-colouring …; T-B1 is not used") | **GAP at TR-ROT** | §2.4 |
| C-1 for `R ⋊ U`-invariant random four-colourings | **TRUE** given MR, B⁺'s inputs, R-U | X22D-QR |
| C-1 as stated, given MR ∧ T-B1 | TRUE (T-J38-2 (iii); also X22D-RT's last clause) | §2.3 |

### 2.5 C-0's use here, and scope

X22D-QR route (b)'s step 1 holds over every number field; steps 3–6 need MR(F), R-U, Theorem C and a Hoffman-tight dyadic place with row 67's
tower. C-0 (Stage 1) puts the three fields inside MR's proved scope. Outside type (B), X22D-QR transfers to every field of Theorem C's class
(J28D's class form, one mind) where R-U holds.

### 2.6 Would have searched here (Stage 2)

- None. Nothing in C-1 is a finite object; the one tempting move (sample `U`-averages of a candidate patchwork colouring numerically, to see
  whether mass moves onto Pull) would be a search for a counterexample shape and was not made; §2.4's reading is stated as a reading.

## Stage 3 — SAVED (C-2, C-3, C-4)

### 3.1 C-2 — GAP at TR-ROT (one direction TRUE; TRUE with rigid-motion transience)

C-2: "Given MR, at those fields: `F(R) ≠ 0` (row 88) iff Q-tr (no four-colouring is transient)."
- **⟹ TRUE, needs no MR.** `F(R) ≠ 0` gives `X₄ = Pull` (row 88's frame; R88-TA (iv)), and a transient colouring is by definition outside Pull.
- **⟸ GAP at TR-ROT.** R88-TA (iv) needs Q-μ beside Q-tr. Given MR, Q-μ ⟺ TR-ROT (X22D-RT), so ⟸ holds given TR-ROT and not otherwise
  by any argument I have: a colouring `c ∈ X′` that is not transient carries a translation-invariant `μ` with `μ(Pull) = 0` on its orbit
  closure, and MR constrains that `μ` only through its `U`-average, which may sit on Pull (§2.4).
- **With transience taken over rigid motions, TRUE** (X22D-TRM below): given MR, `F(R) ≠ 0` iff no four-colouring outside Pull has all the
  `R ⋊ U`-invariant measures on its `R ⋊ U`-orbit closure carried by Pull. *Proof:* ⟹ as above. ⟸: for `c ∈ X′`, the `R ⋊ U`-orbit closure
  is compact and invariant under the amenable group `R ⋊ U`, and every invariant measure on it is carried by Pull (X22D-QR); so `c` is
  rigid-motion-transient, which the hypothesis forbids; so `X′ = ∅`. ∎ This is close to a tautology once X22D-QR is known; its content is
  X22D-QR, read as a constraint on counterexamples:

> **X22D-TRM** [hand, one mind]. Given MR, **every four-colouring of a type-(B) plane outside Pull is rigid-motion-transient**: for every
> finite window `B ⊂ R`, the rigid motions `g ∈ R ⋊ U` with `(g·c)|_B ∉ Pull|_B` have upper Banach density 0 in `R ⋊ U`.

*Proof.* X22D-QR, and the clopen correspondence (R88-CL) for the countable amenable group `R ⋊ U` — its "≤" direction (Følner empirical
measures along a sequence attaining the upper Banach density converge to an invariant measure giving the clopen set at least that mass) uses
only amenability. ∎ (R88-CL is stated for countable abelian groups; `[BergelsonMoragues2021]` is recorded in the ledger as "the amenable form";
I used only the ≤ half, which I re-derived as stated.) **For the poster** (J38 §3.1): a new row, conditional on MR — the counterexample is
rigid-motion-transient; branch (M) of P8 (an invariant measure off Pull) survives only for translation-invariant, non-rotation-invariant
measures, and there only in the rotationally transient form of X22D-RT.

### 3.2 C-3 — GAP at TR-ROT (two of its three links TRUE)

C-3: "Given MR, at those fields: T-B1 ⟺ row 88 ⟺ Q-tr."

| link | verdict | why |
|---|---|---|
| T-B1 ⟹ row 88 | TRUE given MR | T-J38-2 (iii); also X22D-RT's last clause (T-B1 ⟹ TR-ROT) with Q-tr from R88-TA (vi) |
| row 88 ⟹ T-B1 | TRUE, no MR | `X₄ = Pull` finite |
| row 88 ⟹ Q-tr | TRUE, no MR | as C-2 ⟹ |
| Q-tr ⟹ row 88 (or ⟹ T-B1) | **GAP at TR-ROT** | as C-2 ⟸ |

So C-3 as stated is GAP; "T-B1 ⟺ row 88" was already T-J38-2 (iii). With Q-tr read over rigid motions, C-3 is TRUE (X22D-TRM). Unconditionally,
T-B1 ⟹ Q-tr ⟹ T-B2 (R88-TA1) is unchanged.

**The advisor's F3, scored.** "Only the conditional moves: 'row 88 ⟺ T-B1' becomes unconditional" — the equivalence becomes unconditional at
MR's grade, TRUE. "Transience is outside the reach of the invariant-measure tools" — TRUE for R-transience (C-4 below). What F3 did not say:
the rotation-invariant half of Q-μ also moves (X22D-QR), which turns every counterexample into a rigid-motion-transient colouring
(X22D-TRM), and leaves Q-μ as TR-ROT, a transience statement about measures.

### 3.3 C-4 — GAP (capped at 20 minutes; spent about 5, 11:45–11:50 UTC — a correction of the saved heading, which gave a planned window)

C-4: "Over ℚ(√59), no four-colouring of the plane is transient."

**Verdict: GAP**, at one step, **C4-S**: *"a transient colouring supplies a finite measure on `R̂` (or on `X₄`) that is invariant under the
multipliers and charges something off Pull's spectrum."* It does not, by definition, and each of the three named methods needs one:

| method (X12B §2.1–§2.2, X01D's EF_F⁺) | what it consumes | what a transient `c` supplies |
|---|---|---|
| Lemma Z (X12B-Z, "wandering shells") | a **finite** `U`-invariant measure: the push-forward of `ν` along the equivariant `ord_w` is a finite measure on `ℤ ∪ {∞}` invariant under `k ↦ k + h`, hence null on `ℤ` | nothing off Pull: every invariant measure on the orbit closure is carried by Pull (R88-TA (v)), whose spectrum is the finite torsion set dual to `R/(R ∩ 𝔓⁴)` |
| EF's pigeonhole against the rational multipliers `U_ℚ(X)` (X12B-EF step 3) | `μ(qB) = μ(B)` for Bowen balls `B` of measure `≥ e^{−nβ}`, i.e. an invariant measure with zero entropy and positive mass on small balls | the same: the only invariant measures are Pull's |
| Lemma 3.1′ (zero dimension at `P⁺`, Shannon–McMillan–Breiman) | entropy of an invariant measure | the same |

The defect set of a transient colouring against the pullbacks has upper Banach density 0 (R88-TA (v)), so any averaging procedure along
translations or rigid motions (X22D-TRM, under MR) returns Pull; conditioning on the defects gives measures that are invariant under nothing
(the defect set has no Følner structure), so the multiplier pigeonhole has no measure to act on. A transfer would need a **closed-set**
analogue of EF's step — a statement about the orbit closure of `c` as a set, not about its invariant measures — in the way rows 95 and 98 are
closed-set rigidity for characters. None of the three methods is of that kind, and the orbit closure of a transient `c` is not a subset of
`R̂`, so Berend-type closed-set rigidity (rows 95, 98) does not apply to it either. This confirms R88-B2-3 ("invisible to every invariant
measure, and no measure argument … can reach it") for the three new measure tools, and F3's second clause.

*No FALSE:* a counterexample to C-4 is a transient colouring, which answers row 88 "no" (R88-TA2) — not available.

### 3.4 Would have searched here (Stage 3)

- C-4: I would have built finite patches of three-phase pullback patchworks along split-place regions and checked properness by machine, to
  see whether a transient colouring's window statistics can be realised. Not done (a search for a counterexample shape); the step is named
  instead.

## Stage 4 — SAVED (SEL-k, and X03D's FL-K as a second mind)

### 4.1 X03D-FL-K — TRUE, and wider than stated [hand, second mind]

Re-derived in §2.2 route (b) step 2 from its inputs, not from X03D's proof text: with `h = P_E g = E[g | 𝒜_E]`,
`ν̂(u) = −(4/3)P(c¹(0) = c²(u))` and `ν(R̂) = 1 − E|h(0)|² = (4/3)(1 − P(c¹(0) = c²(0)))` (`|h|² = (4/3)Σ_j p_j² − 1/3`). **Agrees with
X03D.** Two sharpenings, both from X22D-EF: (i) the identity needs no rotation-invariance if the joining is taken over `𝒜_E` (the factor of
§2.2 step 1); rotation-invariance with R-U only identifies `𝒜_E` with `𝒜_∅`, as X03D uses. (ii) at `k` colours (simplex embedding,
`⟨e_j, e_l⟩ = (k/(k−1))δ_{jl} − 1/(k−1)`): `ν̂(u) = −(k/(k−1))P(c¹(0) = c²(u))`, `ν(R̂) = (k/(k−1))P(c¹(0) ≠ c²(0))`, the same ratio. The
one input X03D did not write out, that the `E`-part is the `L²` of a factor so that the joining exists, is X22D-EF.

### 4.2 SEL-k — TRUE [hand, one mind], wider in scope than stated

SEL-k: "For every real number field `F` outside row 100's exception and every `k ≥ 2`, given MR: `F²` is `k`-colourable iff it has a
translation- and rotation-invariant random `k`-colouring whose spectral measure is carried by `E`."

*Proof.*
- **⟸** A random proper `k`-colouring of `Cay(R, U)` has a proper sample; the unit-distance graph of `F² ≅ L` is the disjoint union of the
  cosets `x + R` (every unit vector lies in `R`), each coloured by a translate of the sample. No MR used.
- **⟹** A `k`-colouring of `F²` restricts to `Cay(R, U)`; its `R ⋊ U`-orbit closure in the compact `X_k(F)` carries an `R ⋊ U`-invariant `μ`
  (`R ⋊ U` is amenable). Run §2.2 route (b) steps 1–4 at `k` colours: X22D-EF gives `𝒜_E`; FL-K at `k` (4.1 (ii)); `σ_μ` and `E` are
  `U`-invariant, so MR gives `σ|_{R̂∖E} = a·m`, `m̂(u) = 0` on `U`, so `P(c¹(0) = c²(u)) = 0` and the supports are disjoint on every edge
  (J45-SI-3's equality case); `c′ = min S` is a proper `k`-colouring, `𝒜_E`-measurable, with `R ⋊ U`-invariant law (J45-SI-4), so its
  spectral measure is carried by `E`. ∎

**Scope.** No step uses `R = O′` (Lemma C′) or any ring structure beyond `R = ℤ[U]` and the topology `τ_S`: **given MR(F), SEL-k holds over
every real number field**, row 100's exception included. The exception limits where MR is proved (X09C's audit), not SEL-k. **Sharper
conclusion:** the selected colouring's spectral measure is `U`-invariant, so by R-U ("every finite `U`-invariant measure on `R̂` gives
`E ∖ (T + A)` measure 0; every real number field") it is carried by **`T + A`**, and by the extension lemma (R88-TC-ext; its proof, Bochner and
Doob, does not use the colour count — I did not re-check that line by line) it extends to a stationary, continuous-in-probability,
a.e.-proper `k`-colouring of `Cay(G_∅, T_∅)`, `G_∅` the completion at the archimedean and stable places.

**The named risk, discharged.** FL-K was the risk ("one mind"); it is now two minds (4.1), and the factor it needs is X22D-EF. The
load-bearing input of SEL-k is **MR itself**, used once, at "`ν = a·m` ⟹ `ν̂ = 0` on `U`".

**Cross-checks against held results** (none contradicts SEL-k):
- *ℚ(√47), `k = 4`:* SEL-4 with R-U gives an invariant four-colouring with spectrum on `T + A = E_∅`, which T-C(A) at `S = ∅` forbids: so
  MR ⟹ `χ(ℚ(√47)²) ≥ 5`, **a second route to J45's SP-Cor**, by selection instead of A⁺'s strict inequality.
- *Type (B), `k = 4`:* SEL-4 with Theorem C and gap-freeness is X22D-QR (route (b)).
- *Row 116* (Kronecker selection onto `T + A` false over ℚ): its counterexample is a single window colouring whose spectrum lies in `E`
  (split-place characters) but whose `E`-factor has no `T + A` selection; SEL-k selects from the `R ⋊ U`-average, not from the given
  colouring, and needs MR for cross-properness. Over ℚ SEL-4's conclusion is met trivially (the dyadic residue two-colouring, torsion).
  No conflict.
- *ℚ(√167), `k = 5`:* SEL-5 + R-U + TC-ext gives: given MR, `χ(ℚ(√167)²) ≤ 5` iff `Cay(G_∅, T_∅)` has a stationary a.e.-proper five-colouring
  with `R ⋊ U`-invariant law. Removing the 5-thick places (J39's step) gives `Y = UD(ℝ²) × G₂₃ × G₄₃` (T-J39-1) — **SEL-5 re-derives T-J39-3's
  "given MR" iff by a different route (selection, not J39's).** So "six at ℚ(√167)" becomes row 110's window question at `{∞, 23, 43}` (and
  the plane's measurable five-colour question inside it) — **a reduction, never a bound**; it proves nothing about six.

### 4.3 Proposed edits (for the front-page and close lanes; I edit none of these files)

- **Stub `plans/STUB-measure-rigidity-three-fields.md` §2.3, J38 block:** add after T-J38-2: "*X22D (2026-09-26):* T-J38-2 uses T-B1 only in
  step 3a (manufacturing an `R ⋊ U`-invariant measure off Pull from a colouring). Given MR, every `R ⋊ U`-invariant random four-colouring is a
  pullback (X22D-QR), every counterexample is rigid-motion-transient (X22D-TRM), and Q-μ for translation-invariant measures is equivalent to
  TR-ROT (X22D-RT) — so C-1 as stated is GAP at TR-ROT." Also the poster's table (J38 §3.1): a row "P11 (given MR): rigid-motion-transient".
- **`LEDGER.md` row 111 or a new row** (front-page lane's call): "Given MR, the rotation-invariant half of Q-μ holds at type (B) (X22D-QR); what
  remains of Q-μ is TR-ROT, a rotational transience of translation-invariant measures (X22D-RT); every counterexample to row 88 is
  rigid-motion-transient (X22D-TRM). [hand, one mind; X22V blind]."
- **SEL-k's scope line:** "over every real number field given MR(F)"; its conclusion "carried by `T + A`" (R-U).
- **`R88-derivation.md` §G, T-C′'s last sentence** ("even a full classification of `U`-invariant measures would leave Q-μ open without
  T-B1-type isolation"): confirmed and sharpened to TR-ROT.

### 4.4 Would have searched here (Stage 4)

- None. SEL-k is a derivation; its cross-checks are held results.

### Verdicts, per claim

| claim | verdict | where |
|---|---|---|
| C-0 | **TRUE** [hand + tools exact] | §1.4 |
| C-1 | **GAP at TR-ROT** as stated; **TRUE** for `R ⋊ U`-invariant measures (X22D-QR) | §2 |
| C-2 | ⟹ TRUE; ⟸ **GAP at TR-ROT**; TRUE with rigid-motion transience (X22D-TRM) | §3.1 |
| C-3 | **GAP at TR-ROT** (T-B1 ⟺ row 88 and row 88 ⟹ Q-tr TRUE) | §3.2 |
| C-4 | **GAP at C4-S** (a transient colouring supplies no measure off Pull for Lemma Z, EF's pigeonhole or Lemma 3.1′) | §3.3 |
| SEL-k | **TRUE**, over every real number field given MR; conclusion sharpens to `T + A` | §4.2 |
| X03D-FL-K | **TRUE** (second mind); holds for translation-invariant `μ` over `𝒜_E`, and at every `k` | §4.1 |

