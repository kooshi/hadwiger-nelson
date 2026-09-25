# M3-PA-mixing — prior art for J21-MX (the mixing selection) and its neighbours

*Prior-art reader J23cpa (de Bruijn, Opus 5.5), 2026-09-25, for the product owner; brief
`data/crunch-2026-09-25/briefs/J23cpa-M3-mixing-prior-art.md` with `STANDING-RULES.md`. Touches only this file,
`data/m3/j23cpa/` and `~/source/library/pdf/`. Nothing here edits `BIBLIOGRAPHY.md`, `CLAUDE.md`, `LEDGER.md` or J23c's files; the
bibliography rows and corrections below are proposals. Every negative measures its query's words (G21); nothing is called "new".*

## The claim under test (verbatim)

`plans/M3-S1D-windows-five.md` lines 29–31 ("Theorems this phase proved"):

> "**J21-MX (mixing selection)** — `K` compact abelian, `ν` a probability on `T_K ⊆ K`, `λ* = sup_{ξ≠0}|ν̂(ξ)| < 1/(k−1)`: for every Borel
> graph `X`, a Borel proper `k`-colouring of `X × Cay(K, T_K)` yields the Borel proper `k`-colouring `φ(x) = min{j : μ(W(x,·)^{-1}(j)) >
> λ*/(1+λ*)}` of `X`; for measurable `W` proper off a null vertex set, `φ` is measurable and proper off a null vertex set. [hand] §3.2"

Its proof (§3.2 of the same file) has two parts: the compact expander-mixing lemma "`μ(P)μ(Q) ≤ λ* √(μ(P)(1−μ(P))μ(Q)(1−μ(Q)))`" for
edge-free `P, Q`, and a plurality selection "`φ(x) = min{j : μ(W(x, ·)^{-1}(j)) > θ}`", `θ = λ*/(1+λ*) < 1/k`.

**Its parts, for scoring** (each is scored separately in the verdict):
- **(F)** the finite case: `K` a finite abelian group; equivalently (take `X = K_k^H`) `K_k^{Cay(K,T)} → K_k`, i.e. `Cay(K, T)` is a factor
  for which Hedetniemi's conjecture holds at `k` against every `X`;
- **(S)** the spectral threshold `λ* < 1/(k−1)` as the hypothesis on that factor (two-sided: every non-trivial `|ν̂|`, not `λ_min` alone);
- **(B)** the Borel form (every `X` on a standard Borel space, Borel `W` ⟹ Borel `φ`), and **(M)** the measurable form (format N′);
- **(C)** the compact mixing lemma itself.

## Stage 0 — SAVED (quotation check, plan)

**Quotation check (standing rule 5).**

| brief's text | source | result |
|---|---|---|
| J21-MX block quote | `plans/M3-S1D-windows-five.md` lines 29–31 | **verbatim** |
| "its finite case generalises Burr–Erdős–Lovász `χ(G × K_n) = min(χ(G), n)`" | same file §3.2 "Prior art and the classical case": "For `K = ℤ/n` with `T_K = K ∖ 0` (the complete graph), `λ* = 1/(n − 1)`, and J21-MX is the classical `χ(G × K_n) = min(χ(G), n)` (Burr–Erdős–Lovász 1976, as cited in `[Zhu2025]` §1)" | **faithful** (the brief's paraphrase; checked: uniform `ν` on `ℤ/n ∖ 0` has `ν̂(ξ) = −1/(n−1)` for `ξ ≠ 0`, so the hypothesis is `n > k`, and J21-MX at every `k < n` is equivalent to the classical equality) |
| "J23c ran 24 zbMATH queries and 3 web searches" | `data/m3/j23c/gate-queries.out` (24 `QUERY` lines); R3.10 ("two web searches" for J21-MX, "one web search" for the Kempe row) | **faithful for the whole gate**; 14 of the 24 queries were on J21-MX (plus J21's own 9 in §3.7) |
| ADFS 2004, "GAFA; 'Graph products, Fourier analysis and spectral techniques'" | R3.10: "`[AlonDinurFriedgutSudakov2004]` (GAFA 14; zbMATH 1056.05104 …)"; zbMATH title in `data/m3/j23c/gate-reviews.out` | **faithful** |
| "Tardif–Wrochna 2019 (Hedetniemi-type products, strongly multiplicative graphs)" | R3.10: "Tardif–Wrochna 2019 (*Hedetniemi's conjecture and strongly multiplicative graphs*, zbl 1427.05090; review withheld)" | **faithful** (paraphrase of a title) |
| "Godsil–Roberson–Rooney 2020 (as J23c's R3.10 names it)" | R3.10: "Godsil–Roberson–Rooney 2020 (*Vector coloring the categorical product of graphs*, zbl 1442.05056)" | **faithful to R3.10, but R3.10 is wrong twice:** the paper has five authors (Godsil, Roberson, Rooney, Šámal, Varvitsiotis; Math. Program. 182 (2020) 275–314) and is **held and part-read** as `[GodsilEtAl2020]` (`BIBLIOGRAPHY.md` line 281; copies `pdf/arXiv-1801.08243.pdf` and `pdf/arXiv-1801.08243-godsil-roberson-rooney-samal-varvitsiotis-…pdf`), not an "unread" unheld neighbour — a correction owed to R3.10 |
| "`[Zhang2012]` Thm 1.8 (held), `[Zhu2021]` (now held), `[KechrisMarks2020]` Problem 4.23 (held)" | `BIBLIOGRAPHY.md` lines 279, 326; R3.10's `[Zhu2021]` row | **faithful** |

**Plan (one paper per stage, committed after each):** 1 ADFS 2004; 2 Tardif–Wrochna 2019; 3 `[GodsilEtAl2020]`; 4 the held three
(`[Zhang2012]` Thm 1.8, `[Zhu2021]`, `[KechrisMarks2020]` Problem 4.23) plus the Borel-product literature the gate points to; 5 the
zbMATH gate (WORKFLOW 3.2 items 1–3, 8); 6 verdict, proposed rows, the list for Kooshi, report.

## Stage 1 — SAVED: paper 1, `[AlonDinurFriedgutSudakov2004]`

**Copy.** N. Alon, I. Dinur, E. Friedgut, B. Sudakov, *Graph products, Fourier analysis and spectral techniques*, GAFA 14(5) (2004)
913–940, doi 10.1007/s00039-004-0478-3, zbMATH 1056.05104. Held as the authors' preprint dated **October 21, 2003** (22 pp., TeX), from
`https://web.math.princeton.edu/~nalon/PDFS/adfs8.pdf` → `~/source/library/pdf/AlonDinurFriedgutSudakov2004-graph-products-fourier-spectral.pdf`
(not on arXiv: the arXiv API returned nothing for the title or the author triple; the Tel Aviv copy `adfs3.pdf` is a 404). Journal
pagination unchecked.

**Reading log.**
- **Abstract, §1 (pp. 1–3), read in full.** The "weak product" is our categorical product ("Two vertices `(g1, h1)` and `(g2, h2)` are adjacent
  in `G × H` if `g1 g2` is an edge of `G` and `h1 h2` is an edge of `H`", p. 1). Every theorem is about **powers** `H^n` of one base graph:
  Thm 1.1 (`K_r^n`, `r ≥ 3`: "the only colorings of G by r colors are those induced by colorings of one of the factors `K_r`", credited to
  Greenwell–Lovász [18]); Thm 1.2 (stability); Prop. 1.3 (`α(H^n)/|H^n| = α(H)/|H|`, `H` vertex-transitive); **Thm 1.4** (if
  "`α(H)/r = −µ_r/(d − µ_r)`" — Hoffman tightness — then maximum independent sets of `H^n` are "`{v ∈ V(H)^n : v_i ∈ J}`" for `H` connected,
  non-bipartite); Thm 1.5 (stability). The colouring consequence is the Remark after Thm 1.4: if in addition "`χ(H) = r/α(H)`" then "every
  optimal coloring of `H^n` is induced by a coloring of one of the multiplicands".
- **§2–§4 (Fourier on `ℤ_r^n`, the Boolean lemmas, the proofs of 1.1–1.2): skimmed for statements only** (they are the `K_r` case of §5).
  **§4.1 read:** Thm 4.4, the infinite weak product `×_A K_r` with the product measure — a measurable independent set of measure `1/r` is a.e.
  a dictatorship; the remark "In [18], an example due to Pósa is presented that shows, using ultra-filters, an optimal coloring of G which is
  not of the form `σ(S) = S_j`. Of course, the color classes thus formed must be non-measurable." **§4.2 read:** Conjecture 4.5 (juntas for
  independent sets of measure `> α` in `K_r^n`).
- **§5 (pp. 14–18) read in full:** Prop. 1.3's proof; Lemma 5.1 (Hoffman's bound with its equality case and a defect form); proofs of 1.4,
  1.5 by tensor eigenbases. **§5.1 (examples) read to the Kneser item; §6 (concluding remarks) read in full**, including "Most of the results
  proved here can be extended to independent sets in weak products of different regular factors `H_i` … We omit the detailed statements".
- **References mined:** [18] Greenwell–Lovász (held); [12] Brown–Nowakowski–Rall (ultimate categorical independence ratio); [20]
  Hahn–Hell–Poljak; [23] Krivelevich–Sudakov, *Pseudo-random graphs* (the expander-mixing lemma's survey home); [25] Larose–Tardif
  (`[LaroseTardif2002]`, held).

**Bearing on J21-MX.**
- **(F)/(S): not in this paper.** ADFS characterise maximum (and near-maximum) independent sets of `H^n` under **Hoffman tightness** — a
  one-sided condition on `µ_r` plus an equality — and deduce the colouring statement only for optimal colourings of `H^n` with `χ(H) = r/α(H)`.
  J21-MX has an **arbitrary** first factor `X` (no spectral hypothesis, not a power), a two-sided inequality `λ* < 1/(k−1)` with no
  tightness, and **any** proper `k`-colouring (whose classes need not be maximum). Neither statement implies the other: ADFS need no mixing
  (e.g. line graphs with `µ_r = −2` and large positive eigenvalues), J21-MX needs no tightness.
- **(B)/(M): the nearest printed relative is §4.1** — measurable independent sets of the infinite power `×_A K_r` — and its remark that
  non-measurable (ultrafilter) optimal colourings escape the dictatorship. J21-MX's null-set step (§3.2, "Edges with both ends in `Z` are not
  controlled") is the same phenomenon one level down; ADFS do not treat a Borel or measurable **first factor**.
- **(C): the method is shared, the lemma is not stated.** ADFS use Hoffman's bound (Lemma 5.1) for one set; J21-MX's lemma is the two-set
  (bipartite, "edge-free pair") bound, whose finite form is the expander mixing lemma at `e(P, Q) = 0` (Krivelevich–Sudakov's survey [23];
  scored at stage 4).
- **The cylinder lemma (J21-NG1):** ADFS's Thm 1.5 is the literature's form of the planner's lemma — stability **near the maximum** — and
  §4.2's example ("`I = {S : at least two of … S1, S2, S3 are equal to 0}`", measure `7/27` in `K_3^n`, not a dictatorship) is the printed
  instance that a density-above-a-threshold cylinder lemma fails, as NG1 found for `UD(ℝ²) × B`.

**Verdict for this paper:** does not contain J21-MX or any of (F), (S), (B), (M); shares its Fourier method and is the printed home of the
refuted cylinder lemma's correct (near-maximum) form.

## Would have searched here (the ban to 2026-10-01)

*(Empty so far: a reading job runs no finite-witness search.)*
