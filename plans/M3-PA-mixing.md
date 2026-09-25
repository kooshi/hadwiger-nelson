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

## Would have searched here (the ban to 2026-10-01)

*(Empty so far: a reading job runs no finite-witness search.)*
