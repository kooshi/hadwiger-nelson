# FS-100 / crunch ×2×3 wave 3 — job X22D: the type-(B) fields given MR, and SEL-k (derivation record)

*de Bruijn (Opus 5.5), job X22D, 2026-09-26, from 11:32 UTC. Brief: `data/crunch-2026-09-26-x2x3/briefs/X22D-type-B-derivation.md`
(with `STANDING-RULES.md`); stop time 12:50 UTC (owner's change). Working files `data/fs100/x22d/`; checks `tools/x22d_checks.py`.
One mind. A blind verifier, X22V, works on the same claims; no contact.*

## Theorems this phase proved

*(Filled at each stage; grades as `CLAUDE.md` § Notation.)*

| id | statement (one line) | grade | address |
|---|---|---|---|
| X22D-C0 | ℚ(√59), ℚ(√83), ℚ(√131): one prime of `L = F(i)` above 2, stable, and inert in `L/F` (e = 1, f = 2 over the ramified prime of `F`); so outside row 100's exception | [hand + tools exact] | Stage 1, §1.4; `tools/x22d_checks.py` |

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

