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

## Stage 2 — SAVED: paper 2, Tardif–Wrochna 2019

**Copy.** C. Tardif, M. Wrochna, *Hedetniemi's conjecture and strongly multiplicative graphs*, SIAM J. Discrete Math. 33(4) (2019) (journal
pagination and doi unchecked here), zbl 1427.05090 (review withheld); **arXiv:1808.04778v1** (14 Aug 2018, 32 pp.) →
`~/source/library/pdf/TardifWrochna2019-hedetniemi-strongly-multiplicative.pdf`. The arXiv v1 is what was read.

**Reading log.**
- **Abstract, table of contents, §1 (§1.1 "Multiplicativity and strong multiplicativity", §1.2 "Exponential graphs") read in full; §2.1–§2.2
  (walks, reduced walks, universal covers) read; theorem list of §3–§6 and Appendices A–B read by statement (grep of every
  `Theorem/Lemma/Corollary` line); proofs of §3–§6 not read** — they are covering-space arguments about the **target** and cannot bear on
  a spectral hypothesis on a factor.
- The paper's subject is the **target**: "A graph K is multiplicative if a homomorphism from any product G × H to K implies a homomorphism
  from G or from H. Hedetniemi's conjecture states that all cliques are multiplicative." (abstract). "Strongly multiplicative": "for any
  connected graphs G, H with odd cycles C, C′, a homomorphism from (G × C′) ∪ (C × H) ⊆ G × H to K implies a homomorphism from G or H." The
  results: odd cycles (Thm 1, credited to El-Zahar–Sauer and Häggkvist–Hell–Miller–Neumann-Lara), square-free graphs (Thm 8, [Wro17b]),
  "Theorem 2. Let K be a graph such that every edge is contained in at most one square. Then K is strongly multiplicative", and "the third
  power of any graph of girth > 12" (Cor. 21). "Though more graphs are amenable to our methods, they still make no progress for the case of
  cliques."
- §1.2, verbatim: "a graph K is multiplicative if and only if `K^G` admits a homomorphism to K, for all G that do not."

**Bearing on J21-MX.** None on (F), (S), (B), (M), (C). J21-MX fixes the target `K_k` and puts a hypothesis on **one factor**
(`Cay(K, T)` with `λ* < 1/(k−1)`), for **every** other factor: in §1.2's language its finite case is `K_k^{Cay(K,T)} → K_k`, a statement
about one exponential graph, not about multiplicativity of `K_k` (Hedetniemi, false for `k ≥ 5` by Shitov). Tardif–Wrochna prove
multiplicativity of targets other than cliques by topology (universal covers, the ♦-fundamental group); nothing spectral, measurable or
Borel appears (grep: "spectr", "eigen", "measur", "Borel" — no hits).

**A side find for the project (not for J21-MX):** "An interesting small example is the 4-chromatic graph known as the Moser spindle" (§1.1,
after Theorem 2) — **the Moser spindle is strongly multiplicative, hence multiplicative**: if `G × H` maps homomorphically to the Moser
spindle, then `G` or `H` does. Proposed as a bibliography note (§ proposals), with no consumer here yet.

**Verdict for this paper:** does not contain J21-MX or any of its parts; it is a neighbour by title only.

## Stage 3 — SAVED: paper 3, `[GodsilEtAl2020]` (Godsil–Roberson–Rooney–Šámal–Varvitsiotis)

**Copy.** C. Godsil, D. E. Roberson, B. Rooney, R. Šámal, A. Varvitsiotis, *Vector coloring the categorical product of graphs*, Math.
Program. 182 (2020) 275–314, zbl 1442.05056; held as arXiv:1801.08243v1 (24 Jan 2018, 38 pp.), twice under two names (`cmp`: byte-identical):
`~/source/library/pdf/arXiv-1801.08243.pdf` and `…/arXiv-1801.08243-godsil-roberson-rooney-samal-varvitsiotis-vector-coloring-categorical-product.pdf`.
**Five authors; R3.10's "Godsil–Roberson–Rooney 2020" and "unread neighbour" are wrong** (held since FS-86, key `[GodsilEtAl2020]`).

**Reading log (this reading; the bibliography's earlier status was "abstract, Def. 1.1, (A′)/(B′), Cor. 4.4 statement").**
- **Abstract, §1.1 "Summary of results", §1.2 "Applications", §1.3 "Motivations from graph coloring" (pp. 1–7): read in full.**
- **§2.3 "Vector Hedetniemi" (Thm 2.12 with proof, Remark 2.13): read in full.** "Theorem 2.12. For any graphs G and H we have
  `χv(G × H) = min{χv(G), χv(H)}`." The proof tensors two dual matrices of `(D′)`.
- **§4.1 "Factors with different vector chromatic numbers": read from Corollary 4.4 to Lemma 4.5 in full** (the Pak–Vilenchik passage).
- §2.1–2.2, §3, §4.2–4.4, §5: not read (rank/strict-complementarity machinery for describing all optimal vector colourings; nothing about
  integral colourings of a product with an arbitrary factor, by the §1 summary).
- **Reference mined:** "[11] Igor Pak and Dan Vilenchik. Constructing uniquely realizable [graphs]" — Discrete Comput. Geom. 50 (2013)
  (read at stage 4).

**The find: the spectral threshold (S) is in print, for vector colourings of `K_m × H`.** §4.1, verbatim: "Corollary 4.4 above generalizes a
result of Pak and Vilenchik [11]. They show that if an r-regular graph H with eigenvalues `λ1 ≥ λ2 ≥ … ≥ λn` satisfies `λ(H) < r/(m − 1)`,
where `λ(H) = max_{i≥2} |λi|`, then the product `Km × H` is uniquely vector m-colorable." — the **same two-sided normalised threshold** as
J21-MX's `λ* < 1/(k − 1)` (with `ν` uniform on the neighbourhood, `λ* = λ(H)/r`). And, verbatim: "Pak and Vilenchik also note that their
result implies that `Km × H` is uniquely m-colorable as well. However, it is known [8] that if H is connected and `χ(H) > m`, then `Km × H` is
uniquely m-colorable. Since their hypotheses imply that `χv(H) > m`, they also imply that `χ(H) > m`, and so the classical result is already
more general in this regard." The mechanism GRRSV give: "`−λn = |λn| ≤ λ(H) < r/(m−1)` ⟹ `1 − r/λn > m`", and `1 − r/λn` is a lower bound on
`χv(H)` (Hoffman's bound in vector form).

**Bearing on J21-MX, part by part.**
- **(S), the threshold as a hypothesis on a product factor: in print** — Pak–Vilenchik (as reported by GRRSV §4.1), first factor `K_m`,
  conclusion about **vector** colourings (and, via Greenwell–Lovász, unique ordinary `m`-colourability, which needs no spectral hypothesis).
- **(F), arbitrary first factor, integral conclusion: not in this paper.** Theorem 2.12 with `χv(H) > k` gives, from `χ(X × H) ≤ k`, only
  `χv(X) ≤ k` — vector, not integral, colourability of `X`. J21-MX's conclusion `χ(X) ≤ k` is stronger, and its hypothesis is stronger too
  (two-sided `λ*` against GRRSV's one-sided route through `λ_n`): with only `χv(H) > k` the integral statement is Hedetniemi for `(X, H)` at
  `k`, false in general for `k ≥ 4` (Tardif 2023) — so the two-sidedness is what the plurality selection spends.
- **Result 4 / Corollary 4.2** (every optimal vector colouring of `G × H` induced by `G` when `χv(G) < χv(H)`, `H` connected, `G` with a
  strictly complementary dual of positive diagonal) is the vector analogue of "every colouring of the product descends"; J21-MX's `φ` is an
  integral selection with no uniqueness claim. Not the same statement.
- **(B)/(M), (C): not in this paper.**

**Verdict for this paper:** (S) is **partly in print** — the threshold `λ(H) < r/(m − 1)` on a regular factor, against the complete graph
`K_m`, for vector colourings (Pak–Vilenchik 2013; GRRSV Cor. 4.4 generalises it). The integral statement for an arbitrary first factor
(F), and the Borel/measurable forms, are not here.

## Stage 4 — SAVED: paper 4, `[PakVilenchik2013]` (found at stage 3)

**Copy.** I. Pak, D. Vilenchik, *Constructing uniquely realizable graphs*, Discrete Comput. Geom. 50(4) (2013) 1051–1071,
doi 10.1007/s00454-013-9545-6. Not on arXiv (API: nothing for the author pair). The authors' PDF `https://www.math.ucla.edu/~pak/papers/GRP4.pdf`
fails TLS verification at the host ("unable to get local issuer certificate"), so it was fetched through the Wayback Machine
(`https://web.archive.org/web/2024id_/…/GRP4.pdf`, HTTP 200; TeX output dated 2013-06-15, 34 pp., the accepted-version layout; not compared
with the journal) → `~/source/library/pdf/PakVilenchik2013-constructing-uniquely-realizable-graphs.pdf`.

**Reading log.** Abstract; §1.2 "Uniquely k-colorable and vector k-colorable graphs" (pp. 4–5) in full; §2's statements of Theorems 1–3 and
the Ramanujan construction after Theorem 3; §5.1 heading ("Proof of Theorem 3" — it reduces unique `k`-colourability to universal rigidity
of the simplex framework, Theorem 1); §8 "Conclusions and open problems" in full. §3–§7 and the appendices (universal rigidity, SDP, stress
matrices) not read — they prove rigidity, not a colouring-selection statement.

**Statements, verbatim.**
- "Theorem 3. Let H be an r-regular graph with `λ < r/(k − 1)`. Then `G = Kk ⊗ H` is uniquely k-colorable and uniquely vector k-colorable.
  Furthermore, the k-colorability problem for G can be solved in polynomial time." Here `λ` is "`λ(H)` (the second largest eigenvalue in
  absolute value)" (§8.1), and `⊗` is the tensor (categorical) product.
- §1.2: "We could not find any mention in the literature about uniquely vector k-colorable graphs, nor the relation to unique k-colorability."
- §8.1 poses: "take a universally rigid framework R and an r-regular graph H. Find a condition on `λ(H)` … so that `R ⊗ H` is universally rigid."

**Bearing on J21-MX.**
- **(S): in print here first (2013), in the same normalisation** — `λ(H)/r < 1/(k−1)` for a regular factor `H` of a categorical product.
  J21-MX's `λ* = sup_{ξ≠0}|ν̂(ξ)|` with `ν` uniform on a finite connection set is exactly `λ(H)/r` for `H = Cay(K, T)`; J21-MX allows a
  weighted `ν` and a compact group.
- **(F): not here.** The first factor is `K_k`, and the conclusion (unique `k`-colourability) is for that one product; as GRRSV note, its
  ordinary-colouring half is already Greenwell–Lovász's without any spectral hypothesis. J21-MX's first factor is arbitrary and its
  conclusion is that the first factor is `k`-colourable — a Hedetniemi-type descent, not a uniqueness statement. The proof routes differ
  too (rigidity and stress matrices here; a two-set mixing inequality and a plurality selection in J21-MX).
- **(B)/(M), (C): not here.**

**Verdict for this paper:** (S) is **in print as a hypothesis in a product-colouring theorem** (Pak–Vilenchik Thm 3, `K_k ⊗ H`); the
statement J21-MX makes with it — for every first factor, integral, Borel, measurable — is not.

## Stage 5 — SAVED: the held three, the surveys, the gate (WORKFLOW 3.2 items 1–3, 8), and paper 5 `[BrakensiekDavies2024]`

**Held papers re-read for this question.**
- **`[KechrisMarks2020]` §4.6 "Hedetniemi's Conjecture" (pp. 31–33 of the 9 Oct 2020 version) read in full.** Problem 4.23, verbatim: "If
  G, H are analytic graphs, is it true that `χB(G × H) = min{χB(G), χB(H)}`?", with `C_B(k)`: "For any analytic graphs G, H,
  `χB(G), χB(H) ≥ k ⟹ χB(G × H) ≥ k`." Known: `C_B(2)`, `C_B(2^ℵ0)` (Cor. 4.24, [KST, 6.11]), `C_B(3)` (Prop. 4.25); "We do not know any
  other results along these lines. Is `C_B(4)` true?" Nothing restricts one factor. **J21-MX gives `C_B(k+1)` for every pair `(X, H)` with
  `H = Cay(K, T_K)` `k`-mixing** (its §3.2 remark, checked: `χ_B(H) > k` because a Borel independent set has measure `≤ θ < 1/k`), a
  positive special case, not an answer. The survey's own statement of the finite problem is out of date ("C(k) for k ≥ 5 is unknown" in the
  body; the Addendum records Shitov). KST 1999 (§6 (E), (F)) not held, not read — by KM's account it is about uncountable Borel chromatic
  numbers (the `G₀`-dichotomy), not finite `k`.
- **`[Zhang2012]` Thm 1.8** — not re-read; its bearing is fixed by `BIBLIOGRAPHY.md` line 279 and J21 §3.6: a statement about **maximum**
  independent sets of products of vertex-transitive graphs, so it bears on the cylinder lemma, not on J21-MX's selection (whose classes need
  not be maximum). No change.
- **`[Zhu2021]`** — its Theorem 3 (R3.10 row, J23c's reading) is the input to J21-NG2 (the ratio alone cannot carry the descent); it says
  nothing spectral. No change.
- **`[Tardif2008]` §3 "Supporting Evidence" (pp. 48–49) and §6.1 read in full** (held, `tardif-2008-…GTN54.pdf`). The survey's class of
  "one factor constrained, the other free" results — "In the preceeding three results, the factor G is heavily constrained (to find an
  n-coloring of `K_n^G`), but the factor H is free" — is exactly J21-MX's form (`K_k^{Cay(K,T)} → K_k`). Its members: "Theorem 3.2 [14]: Let
  G be a graph such that every vertex of G is in an n-clique. For every graph H, if `χ(G × H) = n`, then `min{χ(G), χ(H)} = n`", with [14] =
  "S.A. Burr, P. Erdős, and L. Lovász; On graphs of Ramsey type, Ars Combinatoria, 1, 167–190 (1976)"; Thm 3.3 [15] (Turzík: every two
  edges joined by a third); Thm 3.4 [16] (Hajós sums). **No spectral or measure-theoretic member.** Thm 3.8 [23]: "`χ(G × H) ≥ min{χf(G),
  χf(H)}/2`". The survey cites ADFS ([48]) only for independent sets of products.
- **`[Zhu2025]` §1 (held arXiv 2502.16078) re-checked for J21's attribution:** it says "The conjecture first appeared in a journal article of
  Burr, P. Erdős and Lovász [4] in 1976" and does **not** state `χ(G × K_n) = min(χ(G), n)` in §1 (grep for "× Kn", "G × K", "complete graph":
  no §1 hit). **The attribution J21 §3.2 gives ("Burr–Erdős–Lovász 1976, as cited in `[Zhu2025]` §1") is supported by `[Tardif2008]` Thm 3.2,
  not by `[Zhu2025]` §1** — a correction owed (the statement and the credit stand; the secondary source changes). Its §2.2 (vector
  chromatic number) records GRRSV's Result 1; nothing on a mixing factor.

**The gate** (zbMATH Open API, abstracts; `data/m3/j23cpa/zb.py` is a copy of J23c's tool; outputs `data/m3/j23cpa/gate-queries.out`,
`…/gate-queries-2.out`; every negative measures its words, G21). Items 1–3 (the object in the discipline's words — "tensor/direct/categorical
product", "expander", "uniquely colorable", "exponential graph", "Borel/measurable" — and the question), 8 (author listings):

| query | hits | on point |
|---|---|---|
| `expander & categorical product`; `categorical product & Fourier`; `weak product & coloring`; `exponential graph & eigenvalue`; `pseudo-random & Hedetniemi`; `Hedetniemi & spectral` (2, off-topic volumes); `uniquely colorable & eigenvalue`; `tensor product & uniquely & colorable` | 0 each (except as noted) | — |
| `expander & tensor product & coloring` | 2 | **`[BrakensiekDavies2024]`** (below) |
| `direct product & expander` (14); `direct product & chromatic number & expander` (1) | 15 | hardness-amplification "direct products" (a different product); none |
| `multiplicative & eigenvalue & homomorphism`; `Borel & expansion & chromatic`; `measurable & spectral gap & chromatic`; `compact group & chromatic number` | 3, 1, 0, 0 | none |
| `uniquely vector` | 3 | `[PakVilenchik2013]` (zbl 1280.05092), `[GodsilRobersonRooney2017]` — both already read/held |
| `uniquely & colorable & expander` | 1 | `[PakVilenchik2013]` |
| `expander mixing & coloring`; `dictator & coloring & product` | 1, 1 | Potapov 2022 (perfect 2-colourings), a SODA volume; none |
| author listings: `au:"Vilenchik, Dan"` (29), `au:"Brakensiek, Joshua" & tensor` (3), `au:"Marks, Andrew S." & product` (0), `au:"Bernshteyn, Anton" & product` (2) | | Langberg–Vilenchik 2012 (arXiv 1211.1467; abstract read: an expander-mixing lemma for generalised products `G^k`, not a colouring descent); Brakensiek 2017 (vertex isoperimetry for tensor powers of cliques; title only); nothing on point |
| `Borel & categorical product`; `Borel chromatic & Hedetniemi`; `measurable & Hedetniemi` | 0 each | — (with J21's and J23c's 9 + 14 earlier queries, 41 queries in all) |

**Paper 5 — `[BrakensiekDavies2024]`.** J. Brakensiek, S. Davies, *Robust factorizations and colorings of tensor graphs*, SIAM J. Discrete Math.
38(1) (2024) 883–916, doi 10.1137/23M1552474, zbl 1533.05210 (summary withheld); arXiv:2207.08913v2 (27 Nov 2023, 27 pp.) →
`~/source/library/pdf/BrakensiekDavies2024-robust-factorizations-colorings-tensor-graphs.pdf`. **Read:** abstract, §1 to §1.1's theorem
statements, §1.3.3 (hardness sketch), the conclusion's "Extending past `K3`" paragraph. Their object is `H` "ϵ-near `K3 × G`" (edges deleted,
at most an `ϵ` fraction per vertex); "Theorem 1.2. Fix `ϵ < 1/40`. Let H be ϵ-near `K3 × G`, where graph G is a 3ϵ-edge-expander. Then, there
is an algorithm running in time poly(n) that extracts a valid 3-coloring of H." **Bearing:** a second instance of "first factor a clique,
second factor an expander" (combinatorial edge expansion, algorithmic, robust to deletions); **not J21-MX** — no arbitrary first factor, no
colourability descent, no spectral threshold in `k`. It cites Greenwell–Lovász for the three colourings of `K3 × K3 × K3`, and not
Pak–Vilenchik (grep).

**(C), the compact mixing lemma.** Its finite form at `e(P, Q) = 0` is the expander mixing lemma with the `(1 − |P|/n)(1 − |Q|/n)`
refinement (Krivelevich–Sudakov's survey, ADFS's [23]; equivalently Haemers's bound for two sets with no edges between them) —
**[external, not re-read here]**: neither source is held; `[Haemers2021]` (held) states the one-set ratio bound only (read: its Theorems 1–2
and the interlacing section, grep for a two-set form: none). The compact-group form is the same two lines with Parseval on `K`; its one-set
case is the compact Hoffman bound of `[BachocDeCorteOliveiraVallentin2014]` (held, arXiv 1301.1054; not re-read).

## Stage 6 — SAVED: the verdict, proposals, and the list for Kooshi

### The verdict on J21-MX, part by part (never "new")

| part | position | where, exactly |
|---|---|---|
| **J21-MX as stated** (compact abelian `K`, weighted `ν`, every Borel `X`; Borel and measurable (N′) forms) | **not found by these searches** | 41 zbMATH queries (J21 §3.7: 9; J23c R3.10: 14; here: 18 + 4 in `data/m3/j23cpa/gate-queries-3.out`), 3 + 3 web searches, six papers read at the sections that bear (stages 1–5) |
| **(S) the threshold `λ(H)/r < 1/(k−1)` on a regular factor of a categorical product** | **in print** (2013) | `[PakVilenchik2013]` Thm 3: "Let H be an r-regular graph with `λ < r/(k − 1)`. Then `G = Kk ⊗ H` is uniquely k-colorable and uniquely vector k-colorable" — first factor `K_k` only; generalised to vector colourings by `[GodsilEtAl2020]` Cor. 4.4 (§4.1) |
| **(F) the finite case, arbitrary first factor, integral conclusion** (`K_k^{Cay(K,T)} → K_k`) | **not found**; **partly in print** at `K = ℤ/n`, `T = K ∖ 0`: the classical `χ(G × K_n) = min(χ(G), n)` | `[Tardif2008]` Thm 3.2, credited to Burr–Erdős–Lovász 1976 (every vertex in an `n`-clique; `K_n` is the case J21-MX recovers). The genre — "the factor G is heavily constrained … but the factor H is free" — is `[Tardif2008]` §3's; none of its members is spectral |
| the vector analogue of (F) | **in print**, weaker | `[GodsilEtAl2020]` Thm 2.12: `χv(G × H) = min{χv(G), χv(H)}`; with `χv(H) > k` it gives `χv(X) ≤ k`, not `χ(X) ≤ k` |
| **(B) Borel, (M) measurable** | **not found** | `[KechrisMarks2020]` §4.6: `C_B(2)`, `C_B(3)`, `C_B(2^ℵ0)` only; "We do not know any other results along these lines." J21-MX is a positive special case of Problem 4.23 (`C_B(k+1)` for pairs with a `k`-mixing compact Cayley factor), not an answer |
| **(C) the compact mixing lemma** | **classical in finite form** [external, not re-read]; compact form a routine transcription | the expander mixing lemma at `e(P, Q) = 0` with the `(1 − μ)` refinement (Krivelevich–Sudakov, *Pseudo-random graphs*; Haemers's two-set bound); one-set compact case `[BachocEtAl2014]` |
| the three named neighbours | **none contains J21-MX or a part of it except GRRSV's (S) passage** | ADFS 2004 (maximum independent sets of powers under Hoffman tightness; stage 1); Tardif–Wrochna 2019 (multiplicativity of targets, topological; stage 2); `[GodsilEtAl2020]` (vector colourings; stage 3) |

**Undecided at:** one unread neighbour, paywalled — Špacapan 2011 (below); its title ("k-independence number of direct products … and
Hedetniemi's conjecture") is the one listing that could hold a density form of (F). Low expectation, not zero.

**Scope note for whoever writes J21-MX up.** The proof is two classical ingredients — the plurality selection of the Burr–Erdős–Lovász argument
("a colour of measure `> θ`" in place of "a colour appearing twice") and the expander mixing lemma — so a reviewer may call the finite case
folklore even if no printed statement exists; any claim should be for the statement (arbitrary first factor, two-sided `λ*`, compact `K`,
Borel/measurable) and should cite Pak–Vilenchik and GRRSV as the printed uses of the same threshold.

### Corrections owed (proposals; J23c's files are not touched)

1. `plans/M3-exotic-colourings.md` R3.10: "Godsil–Roberson–Rooney 2020 … (zbl 1442.05056)" → five authors (Godsil, Roberson, Rooney,
   Šámal, Varvitsiotis), **held and part-read** as `[GodsilEtAl2020]`; and "'new' waits on ADFS and Tardif–Wrochna being read" → read: neither
   contains it; the nearest printed relatives are `[PakVilenchik2013]` Thm 3 and `[GodsilEtAl2020]` Cor. 4.4 (same threshold, first factor
   `K_k`).
2. `plans/M3-S1D-windows-five.md` §3.2 and `plans/M3-derivation.md` (M3-J21-MX): "(Burr–Erdős–Lovász 1976, as cited in `[Zhu2025]` §1)" →
   "(Burr–Erdős–Lovász 1976, `[Tardif2008]` Thm 3.2)": `[Zhu2025]` §1 credits BEL only with the conjecture's first appearance in print.
3. `[KechrisMarks2020]`'s body says "C(k) for k ≥ 5 is unknown"; its Addendum records Shitov. Anyone quoting §4.6 should quote both.

### Proposed `BIBLIOGRAPHY.md` rows (for the front-page lane)

| key | reference | role · copy · read |
|---|---|---|
| **[AlonDinurFriedgutSudakov2004]** | N. Alon, I. Dinur, E. Friedgut, B. Sudakov, *Graph products, Fourier analysis and spectral techniques*, GAFA 14(5) (2004) 913–940, doi 10.1007/s00039-004-0478-3, zbMATH 1056.05104 | maximum and near-maximum independent sets of weak (= categorical) powers `H^n` under Hoffman tightness are dictatorships, with stability; the printed form of the cylinder lemma J21-NG1 refutes above the near-maximum range. `pdf/AlonDinurFriedgutSudakov2004-graph-products-fourier-spectral.pdf` (authors' preprint, 21 Oct 2003). Read: abstract, §1, §4.1, §4.2, §5, §5.1 to Kneser, §6; §2–§4 statements only (2026-09-25, J23cpa) |
| **[TardifWrochna2019]** | C. Tardif, M. Wrochna, *Hedetniemi's conjecture and strongly multiplicative graphs*, SIAM J. Discrete Math. 33(4) (2019), zbl 1427.05090; arXiv:1808.04778 | multiplicative and strongly multiplicative **targets** (odd cycles, square-free graphs, graphs with every edge in at most one square — **the Moser spindle among them** — cubes of girth-`> 12` graphs). `pdf/TardifWrochna2019-hedetniemi-strongly-multiplicative.pdf` (arXiv v1). Read: abstract, §1, §2.1–2.2; theorem statements of §3–§6 and App. A–B |
| **[PakVilenchik2013]** | I. Pak, D. Vilenchik, *Constructing uniquely realizable graphs*, Discrete Comput. Geom. 50(4) (2013) 1051–1071, doi 10.1007/s00454-013-9545-6, zbl 1280.05092 | Thm 3: `λ(H) < r/(k−1)` ⟹ `K_k ⊗ H` uniquely `k`-colourable and uniquely vector `k`-colourable — the printed home of J21-MX's threshold. `pdf/PakVilenchik2013-constructing-uniquely-realizable-graphs.pdf` (authors' copy via the Wayback Machine; the host's TLS chain is incomplete). Read: abstract, §1.2, Thms 1–3 statements, §8 |
| **[BrakensiekDavies2024]** | J. Brakensiek, S. Davies, *Robust factorizations and colorings of tensor graphs*, SIAM J. Discrete Math. 38(1) (2024) 883–916, doi 10.1137/23M1552474, zbl 1533.05210; arXiv:2207.08913 | 3-colouring graphs ϵ-near `K3 × G`, polynomial when `G` is an edge expander (Thm 1.2), NP-hard in general. `pdf/BrakensiekDavies2024-robust-factorizations-colorings-tensor-graphs.pdf` (arXiv v2). Read: abstract, §1–§1.1, §1.3.3, §5's "Extending past `K3`" |
| `[GodsilEtAl2020]` (update) | — | read status add: §1.1–§1.3, §2.3 (Thm 2.12 with proof), §4.1 Cor. 4.4 to Lemma 4.5 (2026-09-25, J23cpa); the two held copies are byte-identical |
| `[Tardif2008]` (update) | — | read status add: §3 and §6.1 in full (2026-09-25, J23cpa); Thm 3.2 [14] is the citation for BEL's `χ(G × K_n) = min` |
| listing rows | Langberg–Vilenchik, *Edge distribution in generalized graph products* (arXiv 1211.1467; abstract read, negative); Špacapan 2011 (below; not held); Kechris–Solecki–Todorčević 1999 (not held; by `[KechrisMarks2020]` about uncountable Borel chromatic numbers) | — |

### Papers for Kooshi (paywalled or not fetchable by script)

1. S. Špacapan, *The k-independence number of direct products of graphs and Hedetniemi's conjecture*, European J. Combin. 32(8) (2011)
   1377–1383, doi 10.1016/j.ejc.2011.07.002, zbl 1284.05204 (review withheld; not on arXiv). The one unread listing that could decide (F).
2. *(low)* A. S. Kechris, S. Solecki, S. Todorčević, *Borel chromatic numbers*, Adv. Math. 141 (1999) 1–44, doi 10.1006/aima.1998.1771 — §6 (E), (F),
   for completeness of the Borel-product row.
Also owed but openly available (not fetched, budget): M. Krivelevich, B. Sudakov, *Pseudo-random graphs* (2006), for (C)'s attribution.

## Theorems this phase proved

None. A reading job; every statement above is quoted or scored, not derived.


## Would have searched here (the ban to 2026-10-01)

*Empty: a reading job, no move was a finite-witness search.*
