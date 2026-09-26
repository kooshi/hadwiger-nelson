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
