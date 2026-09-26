# Row 88's question — the close-time prior-art gate (crunch job J35, de Bruijn, Opus 5.5, 2026-09-25)

*Brief: `data/crunch-2026-09-25/briefs/J35-row88-prior-art-gate.md` (with `STANDING-RULES.md`). Milestone plan: `plans/FS86-row88-rigidity.md`
(§S.0 terms, §S.1 statements, §PA J28's opening gate). Records gated: J28D `plans/FS86-R88-D-derivation.md`, J28V
`plans/FS86-R88-V-verification.md`. Working files: `data/fs86r88/j35/` — `zb.py` (zbMATH Open API or, with `-o`, OpenAlex; every query and
its hit count appended to `queries.log`), `zbtext.py` (a zbMATH record's review/summary text). Papers saved to `~/source/library/pdf/`.
Verdict vocabulary (the brief's): *in print* / *partly in print* / *not found by these searches* / *undecided*. Nothing here is called new.*

## Theorems this phase proved

None. This is a prior-art gate: it attributes, it does not derive. (Every mathematical remark below is a reading of a printed source against
a filed statement, graded as such.)

## Would-have-searched-here log

Empty so far: a prior-art gate runs literature queries, not finite-witness searches; no solver, finder or enumeration was run or wanted.

## Stage 1 — SAVED (the quotation check; tooling; controls)

### 1.1 Quotation check (standing rule 5)

| brief item | source | result |
|---|---|---|
| T-A (i)–(vi), "Let `F` be a type-(B) field, or any real field in S2 … and so `F(R) = F_μ(R)`." | plan §S.1, first bullet | **verbatim** (line breaks differ only) |
| T-C, "Over a type-(B) field, every translation-invariant … is carried by Pull." | plan §S.1, T-C bullet | **verbatim**; §S.1 adds a parenthesis fixing `Fin_S` ("the characters continuous for the `S`-adic topology") that the brief omits — omission, not a change |
| T-C(A), "Over ℚ(√47), no translation-invariant … carried by no `T + A + Fin_S`." | plan §S.1, T-C(A) bullet | **verbatim** |
| "J28D states T-C for the whole class S2, wider than §S.1's type-(B) wording" | J28D §3 verdict line: "T-C: TRUE [hand, one mind], at the stated scope and on all of S2"; class (TC-class) in §3.2 | **confirmed**; J28V proves T-C over ℚ(√59), ℚ(√83), ℚ(√131) only (its J28V-4) |
| item 4's partials | J28D Stage 4 (B2-1, B2-2, B2-3; T-B1 route notes), J28V §2.4 (B2-a…e), §2.5 (B1-a…c) | the brief's summaries are paraphrases, not quotations; checked for scope: "every archimedean-bounded subset of `R` has upper Banach density zero (J28D's L-B2-2)" is **wider than L-B2-2's statement**, which is "`d*(z + kU) = 0` for every `z ∈ R` and `k ≥ 1`" (J28D §5.2); J28D's B2-2 proof ("`kU` lies in the archimedean ball of radius `k`, while every Følner set of `R` has archimedean extent `→ ∞`") does prove the wider form for any set bounded in `L ⊗ ℝ`. Gated below at the proved scope, with the wider form noted |
| J28V-7, "every non-zero ideal of `ℤ[U_F]` has finite index" | J28V theorems table: "T-A (i)–(vi); every non-zero ideal of `ℤ[U_F]` has finite index, for every real `F` (no Lemma R)" | **verbatim** (the brief quotes the second clause) |
| J28V-6, "C14.2 (c) at `q = 2`" | J28V table: "C14.2 (c) holds at `q = 2` (the split-place integrals are `1, −1, 0, 0, …`)"; C14.2 (c) itself: `plans/FS86-C-Coxeter.md` "Lemma C14.2 (c) Split `v`: `H(F_v)` has ratio `0` with error `η(n) ≤ 3/(2n + 4)`" | **verbatim** |

No spurious gap and no widening in the brief except the one noted (item 4, L-B2-2), which does not change a verdict.

### 1.2 Tooling and controls

- **zbMATH empty-result control:** `ab:"zzqxnonsenseword"` → HTTP 404 → printed `0 hits` (J28's finding reproduced: 404 is the API's empty
  result, not an outage). **Positive control:** `ab:"forced periodicity"` → 3 hits, `[HervaKari2023]` first (J28's count reproduced).
- A failed request prints `ERROR` and, after three tries, `UNANSWERED` — never a zero. None so far.
- Second database: OpenAlex (`zb.py -o`), relevance-ranked full-text search; its hit counts measure word overlap, not topic, and are
  recorded for completeness only.

## Stage 2 — SAVED (result 1: T-A, the decomposition)

**The object in its disciplines' words.** (Topological dynamics of amenable actions) a compact shift space `X₄(F)` (a subshift of
`{0,1,2,3}^R`, `R` a countable abelian group of finite rank) with a finite set Pull of periodic points; T-A (iii)–(v) say: the forced group is
non-zero iff the **measure centre** of `X₄(F)` (the closed support of all invariant measures) lies in Pull and every point's **minimal centre
of attraction** / orbit-closure measure centre lies in Pull, the latter read through the **upper Banach density of return times** — the
**Furstenberg correspondence principle** for amenable groups. (Symbolic dynamics / combinatorics) the forced group as a "forced periodicity"
statement (Kari–Szabados; `[HervaKari2023]`); B2-1's no-finite-defect as **frozen** colourings (`[AlonEtAl2021]`).

**Queries** (all logged in `data/fs86r88/j35/queries.log`, 2026-09-25):

| db | query | hits | relevant |
|---|---|---|---|
| ZB | `ab:"upper Banach density" & ab:"invariant measure" & ab:"amenable"` | 0 | — |
| ZB | `ab:"upper Banach density" & ab:"invariant"` | 9 | Björklund–Bulinski 2017, Conant 2025 (off-target) |
| ZB | `ab:"Banach density" & ab:"invariant measures" & ab:"orbit closure"` | 0 | — |
| ZB | `ab:"correspondence principle" & ab:"amenable" & ab:"upper Banach density"` | 2 | **Bergelson–Moragues 2021** (Zbl 1501.37009), Beiglböck–Bergelson–Fish 2010 (Zbl 1187.43002) |
| ZB | `ab:"measure center" & ab:"Banach density"` | 1 | Yin–Wu–Deng 2015 (semi-flows) |
| ZB | `ab:"measure center" & ab:"amenable"` | 1 | Wang–Zhou 2016 (Zbl 1363.28019; Acta Sci. Nat. Univ. Sunyatseni 55(3) 52–54; summary read) |
| ZB | `ab:"minimal center of attraction" & ab:"amenable"` | 1 | **Chen–Dai 2017** (Zbl 1385.37038; JMAA 456, 1397–1414; arXiv:1707.07786) |
| ZB | `ab:"frozen" & ab:"coloring"` | 13 | none structural (random CSP "frozen variables"); `[AlonEtAl2021]` not indexed under it |
| ZB | `ab:"invariant measures" & ab:"periodic orbits" & ab:"subshift" & ab:"coloring"` | 0 | — |
| ZB | `ab:"proper colorings" & ab:"Z^d" & ab:"invariant measures"` | 0 | — |
| ZB | `ab:"subshift" & ab:"every configuration is periodic"` | 0 | — |
| ZB | `ab:"all configurations are periodic" & ab:"finite"` | 1 | Gamard 2018 (coverable subshifts; off-target) |
| ZB | `ab:"graph colorings" & ab:"invariant measures" & ab:"periodic"` | 0 | — |
| ZB | `ab:"unit distance graph" & ab:"periodic coloring"` | 0 | — |
| OA | `upper Banach density return times invariant measures orbit closure amenable group` | 74 | none closer than the ZB hits |
| OA | `every invariant measure supported on periodic orbits proper colorings subshift abelian group` | 22 | none on target |
| OA | `frozen colorings Cayley graph infinite degree` | 33 | Peled–Spinka 2018/2020 (`[PeledSpinka2023]`'s preprints; ℤ^d, bounded degree) |

**Papers opened, and what was read.**
- **Bergelson–Moragues, *An ergodic correspondence principle, invariant means and applications*** (Israel J. Math. 2021; arXiv:2003.03029;
  saved `BergelsonMoragues2021-ergodic-correspondence-invariant-means.pdf`). Read: §1 (Thms 1.1, 1.4), §2 to Prop. 2.7 with proofs.
  **Thm 2.3** (Furstenberg correspondence for countable amenable `G`, along a Følner sequence `(F_N)`): for `E ⊆ G` there is a system and
  a clopen `A` with `μ(A) = d̄_{(F_N)}(E)` — its proof is the orbit closure of `1_E` in `{0,1}^G` with a weak-* limit of Følner empirical
  measures, i.e. the "≤" half of L-CL. **Prop. 2.7** ("an amenable version of Proposition 3.9 in [F5]", Furstenberg 1981): for a continuous
  action on a compact metric space, every **ergodic** invariant measure on the orbit closure of `x₀` has `x₀` quasi-generic for it along some
  Følner sequence — the "≥" half of L-CL for clopen sets (max over invariant measures is attained at an ergodic one). Definition 2.2
  defines `d*` as the sup over Følner sequences, which for a countable abelian group agrees with the translate form J28 uses.
- **Chen–Dai 2017** (saved `ChenDai2017-minimal-center-attraction-amenable.pdf`). Read: §1 (Def. 1.1, Lemma 1.2), §2.3 (Prop. 2.7,
  Cor. 2.8). **Lemma 1.2:** the minimal `F`-centre of attraction of `x` is `{y : d̄_F({g : gx ∈ U}) > 0 ∀ U ∋ y}` — the Følner-net-relative
  form of T-A (v)'s criterion (T-A (v) uses `d*`, the sup over nets).
- **`[AlonEtAl2021]`** (held, arXiv:1903.11685). Re-read: §1 (definition of frozen, Thm 1.1), §2 (Prop. 2.1, Prop. 2.2, Cor. 2.3–2.5).
  "A `q`-coloring of `G` is frozen if any `q`-coloring of `G` which differs from it on finitely many sites is identical to it." Prop. 2.2's
  non-existence criterion needs **maximum degree `Δ` finite**; `Cay(R, U)` has infinite degree, so the paper is silent on it.

**Verdict — T-A: partly in print, at these parts.**
- **(v) is in print as a method, not as a statement:** its engine L-CL (J28D §5.2: "for a countable abelian group acting on a compact space,
  a point `c` and a clopen `C`, `d*{t : t·c ∈ C} = max μ(C)` over invariant `μ` on `O(c)‾`") is the combination Bergelson–Moragues 2021
  Thm 2.3's construction (≤) + Prop. 2.7 (≥), itself the amenable form of Furstenberg 1981 Prop. 3.9 (for ℤ). The notion "transient" is,
  in the literature's words, **"the measure centre of the orbit closure of `c` lies in Pull"** (Chen–Dai Lemma 1.2 is its Følner-relative
  characterisation; Wang–Zhou 2016 defines the measure centre for amenable actions, summary only). J28D and J28V each re-proved L-CL; the
  record should cite Bergelson–Moragues for it.
- **(vi) is elementary topology** (an orbit closure meeting an isolated point contains it in the orbit); no attribution needed.
- **(i)–(iv), at their stated scope** (the forced group of a type-(B) field's four-colour shift; its sandwich with `F_μ`; the split into
  Q-μ and Q-tr): **not found by these searches.** The sandwich `F ⊆ F_μ ⊆ P` is this project's FS-73 frame (G60, `plans/FS73-derivation.md`
  T38), not the milestone's. No printed statement that every colouring of a number-field unit-distance graph (or any infinite-degree abelian
  Cayley graph) is periodic, or that its colouring shift's measure centre is a finite set of periodic points, was found (J28's §PA.3 item 1
  agrees).
- **B2-1 in the literature's word** (carried here from result 4 because it is the frozen notion): "every pullback is **frozen**"
  (`[AlonEtAl2021]`'s definition verbatim fits); their Prop. 2.2 does not apply (infinite degree). Not found as a statement.

## Stage 3 — SAVED (result 2: T-C, and J28V-6 / C14.2 (c), which T-C's split places rest on)

**The object in its disciplines' words.** (Harmonic analysis / spectral theory of stationary processes) a translation-invariant random
proper four-colouring of `Cay(R, U)`, embedded tetrahedrally, is a stationary `ℝ³`-valued process on the countable group `R` whose
spectral measure `σ` has `σ̂ = −1/3` on `U` — a *translation-invariant strict vector 4-colouring* in Karger–Motwani–Sudan's term; "carried
by `T + A + Fin_S`" is "continuous in probability for the `S`-adic topology", so the process lives on the locally compact completion `G_S`
(Bochner; a Doob measurable modification). (Measurable combinatorics) T-C is then a statement about **measurable proper colourings of a
Cayley graph on an LCA group, `a.e.` proper**, decided by the **Hoffman bound for measurable independent sets** (Bachoc–DeCorte–Oliveira–
Vallentin) on a product with one Hoffman-tight compact factor, with **Hoffman equality ⟹ the colour classes lie in the least eigenspace**
(Blokhuis–Brouwer–Haemers's finite fact, G54) and a measurable, stationary form of **Zhang's product count** (`[Zhang2012]` Thm 1.8).

**Queries** (2026-09-25; `queries.log`):

| db | query | hits | relevant |
|---|---|---|---|
| ZB | `ab:"Hoffman" & ab:"compact group" & ab:"independence"` | 0 | — |
| ZB | `ab:"spectral bounds" & ab:"independence ratio" & ab:"operator"` | 0 | (the `ab:` field misses it; see next) |
| ZB | `Hoffman & "independence ratio" & operator` (all fields) | 1 | **Bachoc–DeCorte–Oliveira 2014** (Zbl 1302.05047) |
| ZB | `ab:"Hoffman bound" & ab:"measurable"` | 0 | — |
| ZB | `Hoffman & bound & measurable & "chromatic number"` | 1 | DeCorte–Golubev 2019 (hyperbolic plane; off-target) |
| ZB | `ti:"spectral bounds for the independence ratio"` | 1 | BDOV 2014 |
| ZB | `ab:"invariant random" & ab:"proper coloring"` | 0 | — |
| ZB | `ab:"translation-invariant" & ab:"random coloring"` | 3 | none on target (Burton–Keane 1991 percolation) |
| ZB | `ab:"measurable chromatic number" & ab:"p-adic"`; `"measurable chromatic number" & "p-adic"` | 0; 0 | (BMK is indexed without a summary: "contents unavailable due to conflicting licenses") |
| ZB | `ab:"factor of iid" & ab:"proper coloring"` | 0 | — |
| ZB | `ab:"Hoffman" & ab:"equality" & ab:"coloring" & ab:"eigenspace"` | 0 | — |
| ZB | `ti:"invariant" & ti:"colorings" & ti:"Cayley"`; `ti:"random colorings" & ti:"invariant"` | 0; 0 | — |
| ZB | `ti:"invariant" & ti:"colorings"` | 4 | Timár 2011 (random planar maps; off-target) |
| ZB | `"stationary" & "proper colorings" & "spectral"`; `"strict vector coloring" & "Cayley"` | 0; 0 | — |
| ZB | `ab:"Kronecker factor" & ab:"stationary process" & ab:"extension"`; `ab:"continuous in probability" & ab:"stationary" & ab:"locally compact abelian"` | 0; 0 | — |
| ZB | `au:"Bardestani, Mohammad"` (the poser of the `p`-adic question: complete listing, 14 entries) | 14 | **BMK 2017** (Zbl 1360.05050, Israel J. Math. 217, 313–335) is the one on the subject, with BMK 2018 (structured Cayley graphs) |
| OA | `translation-invariant random proper colorings abelian group spectral measure periodic` | 54 | Grebík–Greenfeld–Rozhoň 2023 (measurable tilings; periodicity of measurable tilings — a neighbour, not the object) |
| OA | `measurable colorings Cayley graph compact abelian group Hoffman equality eigenspace` | 0 | — |
| OA | `invariant measures on the space of proper colorings of a Cayley graph classification` | 141 | Peled–Spinka 2020 lecture notes (`[PeledSpinka2023]`'s programme; ℤ^d) |

**zbMATH caveat (a finding about the instrument, G21):** `ab:` searches the review/summary text, and for records whose text is withheld
("zbMATH Open Web Interface contents unavailable due to conflicting licenses" — BMK 2017, Chen–Dai 2017, `[PeledSpinka2023]`) it can
never hit. So a zero on an `ab:` query measures the *reviewed* literature only; all-field and `ti:`/`au:` queries were added for that reason.

**Papers opened, and what was read.**
- **Bachoc–DeCorte–Oliveira–Vallentin 2014**, *Spectral bounds for the independence ratio and the chromatic number of an operator*
  (held since at least FS-56 as `library/pdf/arXiv-1301.1054-…`; **`BIBLIOGRAPHY.md` row `[BachocEtAl2014]` says "not held" — wrong,
  correction owed**). Read: §2 to Thm 2.3 (Def. 2.1, Thm 2.2 with proof, Thm 2.3's statement). **Def. 2.1:** "A measurable set `I ⊆ V` is
  called an independent set of `A` if `(Af, f) = 0` for each `f ∈ L²(V)` which vanishes almost everywhere outside of `I`" — for a positive
  convolution operator `A = ν *` this is exactly J28D's **edge-null** (`⟨1_I, ν * 1_I⟩ = 0`). **Thm 2.2** is Hoffman's ratio bound for such
  sets on a probability space (with an `ε`-slack for non-constant `A1_V`); Thm 2.3 the chromatic form.
- **Bardestani–Mallahi-Karai 2017** (`[BardestaniMallahiKarai2017]`, held). Newly read here: §3.2 in full through Lemma 3.11 (the isotropic
  `p`-adic case) and the reference list's [12], [13]. **Thm 3.7:** the `T`-chopped hyperbola graph `Cay(ℚ_p², S_T)`,
  `S_T = {(x, y) : xy = 1, p^{−T} ≤ ‖x‖ ≤ p^T}`, has `χ_Bor ≥ 1 + (2T + 1)/4`, via the log-uniform symmetric measure `μ_T` on `S_T` and
  **Lemma 3.8:** `μ̂_T ≥ −4/L`, `L = (4T + 2)(1 − 1/p)`; the inputs are **Lemma 3.9–3.10** (the integral of `ψ(as)` over a ball and over a
  valuation shell: `1 − 1/p`, `−1/p`, `0` — the "one-negative" values) and **Lemma 3.11** (the non-stationary vanishing of the incomplete
  Bessel integral unless the valuation is even and `r = m/2`), which they take from **Sally–Taibleson 1966, Lemma 8(i)** (and Sally 1998
  Lemma 10.10). No parity restriction on `p` appears in §3.2 (the only "`p > 2`" in the paper is §1's remark on quantifying the
  anisotropic case), and Thm 1.1 is stated for every local field of characteristic zero.

**Verdict — C14.2 (c) and J28V-6: partly in print.** C14.2 (c)'s computation (`plans/FS86-C-Coxeter.md` "Lemma C14.2 (c) Split `v`: `H(F_v)`
has ratio `0` with error `η(n) ≤ 3/(2n + 4)`", by the average `ν_n` over `k ∈ [−n, n]` of the Haar measures on `(π^kε, π^{−k}ε^{−1})`
and Hoffman's bound) **is Bardestani–Mallahi-Karai 2017 §3.2** (Thm 3.7, Lemmas 3.8–3.11) in window form: the same measure (their `μ_T`,
log-uniform over the shells `p^{−T} ≤ ‖s‖ ≤ p^T`), the same case split, the same order of bound (`−4/L` against C14.2 (c)'s
`−(1 + 2/(q − 1))/(2n + 1)`), with the vanishing step from Sally–Taibleson 1966. BMK state it over `ℚ_p` (all `p`, dyadic included) for the
Borel chromatic number; C14.2 (c)'s form over an arbitrary split `F_v` with residue size `q`, as a windowed independence ratio, is the
project's transcription. **J28V-6** ("C14.2 (c) holds at `q = 2` (the split-place integrals are `1, −1, 0, 0, …`)"): the one-variable
integrals are BMK Lemma 3.10 (and textbook: the Ramanujan-sum values of `∫_{O^×} ψ(bε)dε`, e.g. Tate's thesis's local computation); the
`q = 2` case of the whole computation is in BMK for `ℚ₂`; **the instance `F_v = ℚ₂(i)` (uniformiser `1 + i`, `q = 2`) that T-C(A) needs is a
transcription not literally printed.** *Undecided at one step:* whether Sally–Taibleson's Lemma 8(i) itself excludes residue characteristic 2
— not fetched (list for Kooshi). J28V's and J21-D1-2's re-derivations at `q = 2` make that step independent of the citation. **Correction
owed:** FS-86's C14.2 (c) (Coxeter's record) cites BMK Thm 1.1 for the Borel chromatic number of the split plane but not §3.2 for its
computation; `BIBLIOGRAPHY.md` already says (FS-58, 2026-09-17) that BMK's Lemma 3.8 is "the published local form of FS-58 D6", so this is a
held source not carried to the lemma that uses it (G49's pattern).

**Verdict — T-C: partly in print, in its inputs; the theorem not found by these searches.**
- *In print, by input:* the measurable Hoffman bound on edge-null sets (NH-Y′, C14.2 (c)) is BDOV 2014 Thm 2.2; the split places' ratio 0
  is BMK 2017 §3.2 (above); the archimedean ratio `m₁ ≤ 0.2470` is `[AmbrusEtAl2023]` Thm 1 (already cited by J28D); the product count
  (C14.3, and C5 in stationary form) is `[Zhang2012]` Thm 1.8's counting (already cited: C14.3 names it); Hoffman equality forcing the least
  eigenspace is Blokhuis–Brouwer–Haemers's in finite form (G54), and C6 is its measurable form on a compact group — the equality case of BDOV
  Thm 2.2's proof (`‖g‖² = β − β²` with `g` in the `m(A)`-eigenspace), not stated as a theorem there; C1–C2 (spectral measure on a subgroup of
  continuous characters ⟺ continuity in probability; the stationary extension to `G_S`) are Bochner and Doob, as J28D names them.
- *Not found by these searches:* any classification of translation-invariant random (or measurable) proper colourings of a unit-distance
  graph over a number field, or of any infinite-degree abelian Cayley graph, by spectral type; any statement that such a colouring with
  spectrum in a locally compact dual is a pullback from a finite residue colouring. The nearest printed classifications of invariant
  measures on a proper-colouring shift are Peled–Spinka's (`[PeledSpinka2023]`: ℤ^d, bounded degree, measures of maximal entropy / Gibbs
  states, "long-range order" — a different notion, already recorded in `BIBLIOGRAPHY.md`).

## Stage 4 — SAVED (result 3: T-C(A), the type-(A) form over ℚ(√47))

**The object in its disciplines' words.** (Measurable / fractional colouring) "no translation-invariant random proper four-colouring of the
unit-distance graph over ℚ(√47) is continuous in probability for an `S`-adic topology" — equivalently (J28V §2.2, J28D §3.3) the measurable
independence ratio of the completion `G_S` is `< 1/4`, a **fractional-chromatic / independence-density** statement about the local–global
product. (Euclidean Ramsey theory) the question it bears on is the chromatic number of the plane over a real quadratic field, `χ(ℚ(√47)²)`,
which this project holds at `4 ≤ χ ≤ 5` (row 84).

**Queries** (2026-09-25; `queries.log`):

| db | query | hits | relevant |
|---|---|---|---|
| ZB | `"chromatic number" & "quadratic field" & "unit distance"` | 0 | — |
| ZB | `"chromatic number" & "real quadratic" & plane` | 0 | — |
| ZB | `ab:"unit distance graph" & ab:"number field"` | 0 | — |
| ZB | `"unit-distance graph" & "algebraic numbers" & "chromatic"` | 0 | — |
| ZB | `ti:"planar geometric graph"` (the 1994 vocabulary control) | 1 | `[Fischer1994]` (held) — the control fires |
| ZB | `au:"Fischer, Klaus G."` (complete listing) | 27 | the three on the subject, all held: 1990 (Zbl 0744.05061), 1990 (Zbl 0733.05048), 1994 (Zbl 0836.05030) |
| ZB | `au:"Johnson, Peter D.*" & (ti:"coloring" \| ti:"colouring" \| ti:"chromatic")` (the poser's listing) | 31 | Johnson 1982 *Coloring abelian groups* (Zbl 0485.05009); **Johnson 2000, *Infinite graphs and the fractional chromatic number: some recent surprises*, Geombinatorics 9(3) 135–144 (Zbl 0945.05021)** — review read: "the relation between the fractional chromatic number of the full graph and the fractional chromatic number of finite subgraphs"; `[Johnson2000]`, `[Johnson2006]` (already listed as unread debts) |
| ZB | `au:"Johnson, Peter D." & "chromatic number"` | 0 | (name form; the wildcard form above is the one that works — recorded as an instrument note) |
| OA | `chromatic number of the plane over a real quadratic field four colorings` | 286 | none on target (relevance noise) |
| OA | `unit distance graph Q(sqrt 47) chromatic number` | 116 | none on target |
| OA | `measurable chromatic number unit distance graph number field adelic` | 0 | — |

**Papers opened.** None new beyond zbMATH review texts (Johnson 1999, 2000; Fischer's three are held and read, `BIBLIOGRAPHY.md`). The
inputs of T-C(A) are T-C's (stage 3): BDOV 2014 Thm 2.2 (Hoffman on the tail), BMK 2017 §3.2 (split places, the dyadic one included —
T-C(A)'s `S` may contain the split place above 2 of ℚ(√47), where `ℚ(√47)_v = ℚ₂(i)`), `[AmbrusEtAl2023]` (real place), FS-66 (11, 19),
`[Zhang2012]` (the product count).

**Verdict — T-C(A): not found by these searches** (the statement: "Over ℚ(√47), no translation-invariant Borel probability measure on
`X₄(F)` has its spectral measure carried by `T + A + Fin_S` for a finite set `S` of split places; hence …", plan §S.1). Its inputs are in
print as listed. **Undecided at one named source:** `[Johnson2000]` (*Problems posed in or arising from "Colorings of metric spaces"*) and
Johnson 2000 (*Infinite graphs and the fractional chromatic number*, Geombinatorics 9(3)) may pose the fractional/measurable question for
rational or algebraic planes; neither is held (Geombinatorics — browser fetch). T-C(A) does **not** decide `χ(ℚ(√47)²)`, so it answers no
posed question even if one is found there; it restricts the spectral type of a hypothetical four-colouring (the analogue of G60's
fractional cap read on invariant measures).
