# PA — `[Tardif2023]`, read in full: *The chromatic number of the product of 5-chromatic graphs can be 4*

*Prior-art reader: de Bruijn, 2026-09-25, for the product owner (brief: `data/fs89/briefs/PA-tardif2023-reader-brief.md`). Nothing
here edits `BIBLIOGRAPHY.md`, `CLAUDE.md`, `LEDGER.md` or a stub; §7 and §8 are proposals for the close planner. Grades as in
`CLAUDE.md` § Notation. No finite-witness search was run; the one computation (§5.2) is exact-spectrum arithmetic, allowed in the
ban week.*

## 0. Headlines

1. **Both statements are right, and they are equivalent.** The paper's Theorem 1 (= the abstract): for `n ≥ 4`, `m > n` there are `G, H`
   with `χ(G) ≥ m`, `χ(H) > n`, `χ(G × H) ≤ n`. Our bibliography row's form (every `m₁, m₂ ≥ 5`, exact values, product below the
   minimum) is **not in the paper** but follows from Theorem 1 by deleting vertices, and implies it back (§4.1). The row's wording is
   ours, not the publisher's abstract, and should say so.
2. **Every citation in the repository holds at its stated scope** (§4, eleven sites). One overreaches in its *reason*: G55 and FS-46
   say the three-colour product argument "cannot run at four colours" because Hedetniemi fails there. For **residue targets** the
   product step does run at four colours: every residue target needing five colours has `χ_f > 4` at every tower level, so by
   `[Zhu2011]` a four-colourable product of residue targets has a four-colourable factor (§5.2, [derived + tools]). What stops a
   four-colour version of the argument is the descent to a finite quotient, not the product.
3. **Tardif's construction cannot occur among products of residue targets at four colours** — it needs a factor with `χ_f ≤ 4 < χ`,
   and no residue target has one (§5.2). At five colours the same holds except possibly through `Γ₃₁` or tower levels ≥ 2 at 27, 31,
   43, 47 (§5.3). The paper itself says nothing about fractional chromatic numbers or vertex-transitivity (one sentence on Shitov's bound
   aside).
4. **FS-67 in the paper's language** [hand, §5.4]: for a factor `G` all of whose `k`-colourings are gap-free, every `k`-colouring of
   `G × H` (`H` connected, `χ(H) > k`) is pulled back from `G` **iff the improper part of the exponential graph `K_k^G` is
   `k`-colourable**. Greenwell–Lovász is the case `G = K_k`; Tardif's Theorem 1 is the opposite phenomenon for a `G` with no
   `k`-colourings at all. His non-colourable configuration is the template for an FS-67 counterexample.

## 1. The copy

- **Held:** `~/source/library/pdf/Tardif2023-product-5-chromatic-graphs-can-be-4.pdf` — 6 pages, letter, pdfTeX. The PDF's creation date
  is **22 Nov 2022**. No journal header or doi.
- **Journal:** Combinatorica 43(6) (2023) 1067–1073, doi 10.1007/s00493-023-00047-2. Crossref (fetched 2026-09-25) gives: received
  **22 November 2022**, revised 29 April 2023, accepted 3 May 2023, online 12 June 2023. The journal's title capitalises
  *Chromatic Number … Graphs can be 4*.
- **So the held copy is the submitted version, before the April 2023 revision.** Differences visible without the journal text:
  - both have 16 references, but in a different order;
  - the journal cites Zhu's Poljak–Rödl note at its venue, Electron. J. Combin. 27 (2020) P3.2; the preprint has "manuscript (2019),
    arXiv:1911.12015";
  - `[Zhu2025]` Thm 3.8 restates the key claim with `w = 4k + 1`. That is the preprint's case `v = 2k` (the preprint allows any
    `v ≥ 2k`, `w = 2v + 1`), so the journal may state it in that form (unchecked).
- **Preprint typos** (none affects correctness; the journal copy may have fixed them):
  - p. 2: "an 8-chromatic graph `G = K₄^{Ω₁₃(K₈)}`" — should be `G = Ω₁₃(K₈)` (checked on the rendered page);
  - p. 2: "lim sup f(n)/n ≤ n/2" — should be `≤ 1/2`;
  - p. 3: `τ^{3,{1},{2}}_{a,d,b,}` has a stray comma;
  - p. 4: "conttradiction";
  - p. 5, Lemma 8's induction step: `σ^{2i+1,T}_{b,d}` should be `σ^{2i+2,T}_{b,d}`, and "the colour of `τ^{2i,R,T}_{c,d,a}`" should
    be `τ^{2i+1,R,T}_{c,d,a}`. Lemma 6, as it is applied, gives these indices.

## 2. Reading log (every section; statements verbatim)

**Abstract (p. 1).** "We show that for any integers n ≥ 4 and m > n, there exist graphs G, H such that χ(G) ≥ m, χ(H) > n and
χ(G × H) ≤ n. In particular for n = 4, this settles the last remaining open case of Hedetniemi's conjecture."

**§1 Introduction (pp. 1–2).**
- "Hedetniemi's conjecture of 1966 [6] states that the chromatic number of a categorical product of two graphs is the minimum of the
  chromatic numbers of the factors."
- On El-Zahar–Sauer: the identity "holds when min{χ(G), χ(H)} ≤ 4".
- "The minimal value of min{χ(G), χ(H)} for which 1 fails was brought down to 126 in [16], then 14 in [11], then 6 in [13]. Here we
  prove that the identity 1 can also fail with min{χ(G), χ(H)} = 5."
- "A graph K is called multiplicative if it satisfies the following property: If G × H admits a homomorphism to K, then G or H admits
  a homomorphism to K." Also: "El-Zahar and Sauer's result [2] is that K1, K2, K3 are multiplicative." And: "Here we show that K4 is
  nonmultiplicative."
- "The precise bound in Shitov's result depends on the smallest order of a graph with odd girth at least 7 and fractional chromatic
  number larger than 3. While [16] was finalised, this order was reduced to at most 83." *Trap:* this 83 is the circulant
  `Cay(ℤ₈₃, {±2, ±22, ±25, ±34})` (`[Zhu2025]` §3), unrelated to our `Γ₈₃`.
- **Theorem 1 (p. 2).** "For any integers n ≥ 4 and m > n, there exist graphs G, H such that χ(G) ≥ m, χ(H) > n and χ(G × H) ≤ n."
- "It is known (see [5]) that there exist no graphs G, H such that χ(G) = ∞, χ(H) > n and χ(G × H) ≤ n."
- Theorem 1 "does not refute the weak Hedetniemi conjecture". The Poljak–Rödl function is defined by
  "f(n) = min{χ(G × H) | min{χ(G), χ(H)} = n}"; "either lim f(n) = ∞ or lim f(n) ≤ 9".
- **Theorem 2 (p. 2).** "f(n) ≤ ⌈n/2⌉ + 3."
- On the construction: "G belongs to a well-studied family of graphs, and H is K_n^G. However, the subgraph of K_n^G actually used in
  the proof turns out to be fairly simple. It is a subdivision of a binary tree with 5-cycles appended to its leaves, connected to a copy
  of Kn to restrict the colours allowed on a vertex. Its size is linear with respect to m."
- Figure 1: "Subgraph of K₄^{Ω₁₃(K₈)}", a 5-chromatic `H` whose product with the 8-chromatic `Ω₁₃(K₈)` is 4-chromatic.

**§2 Proof of Theorem 1 (pp. 3–5).**
- Set-up: "We can suppose that m is a power of 2, m = 2^k. Let v ≥ 2k and w = 2v + 1. Our graph G is Ω_w(K_m), a 'universal graph
  for wide colourings'."
  - Its vertices are the tuples `(X₀, …, X_v)` with `|X₀| = 1`, `X_ℓ ≠ ∅`, `X_ℓ ∩ X_{ℓ+1} = ∅`, `X_ℓ ⊆ X_{ℓ+2}`.
  - Its edges join `X`, `Y` with `X_ℓ ⊆ Y_{ℓ+1}`, `Y_ℓ ⊆ X_{ℓ+1}`, `X_ℓ ∩ Y_ℓ = ∅`.
- "**Theorem 3** ([4, 12]). For any m ≥ 2 and odd w, χ(Ω_w(K_m)) = m." ("also implicit in [3, 1, 10]"). This is imported, not proved.
- "Our graph H is the exponential graph K_n^G … f and g, are joined by an edge if for every edge {u, v} of G, we have f(u) ≠ g(v). It is
  well known that G × K_n^G can be properly n-coloured by colouring the vertex (u, f) with colour f(u). Therefore χ(G × K_n^G) ≤ n,
  and it only remains to show that χ(K_n^G) > n."
- The maps: `σ^{ℓ,S}_{a,b}(X) = a` if `S ∩ X_ℓ ≠ ∅`, else `b`. `τ^{ℓ,R,T}_{a,b,c}(X) = a` if `R ∩ X_ℓ ≠ ∅`; else `b` if `T ∩ X_ℓ ≠ ∅`;
  else `c`.
- Lemmas 4–7 (pp. 3–4) give the adjacencies:
  - Lemma 4: `σ^{ℓ,S}_{a,b} ~ σ^{ℓ+1,S}_{c,a}`;
  - Lemma 5: `σ^{ℓ,R⊔T}_{a,b} ~ τ^{ℓ+1,R,T}_{c,d,a}`;
  - Lemma 6: `τ^{ℓ,R,T}_{a,b,c}` is adjacent to `σ^{ℓ+1,R}_{d,a}` and to `σ^{ℓ+1,T}_{d,b}`;
  - Lemma 7: `σ^{ℓ,{x}}_{a,b} ~ σ^{ℓ,{x}}_{a,c}`.
- **The image normalisation (p. 4):** "The constant maps form a n-clique … we can assume without loss of generality that each constant
  map is coloured with its own constant value. Every other element f … is adjacent to all the constant maps with a constant value which
  is not in the image of f. Therefore, every element of K_n^{Ω_w(K_m)} has a colour in its own image."
- **Lemma 8 (p. 4).** "For i = 0, 1, . . . , k − 1, there exists a set S ⊆ V(K_m) of size 2^{k−i−1} and two distinct vertices a, b of
  K_n such that the colour of σ^{2i,S}_{a,b} is a." A footnote credits Gábor Tardos with a simplification.
- **The end (p. 5).** At `i = k − 1` the set is `{x}`. The path `σ^{2k}_{b,c} – σ^{2k−1}_{c,a} – σ^{2k−2}_{a,b} – σ^{2k−1}_{d,a} –
  σ^{2k}_{b,d}` forces both endpoints to colour `b`, and Lemma 7 joins them, so the path closes into a 5-cycle. "Hence
  χ(K_n^{Ω_w(K_m)}) > n."
- **Where `n ≥ 4` is used:** Lemmas 5–6 and the induction step need four distinct colours `a, b, c, d`.
- **Walked line by line here [hand]:** Lemmas 4–8 and the closing cycle are correct once the typos above are corrected. The edge
  relation of `Ω_w` is symmetric, so "`f(X) ≠ g(Y)` for adjacent `X, Y`" covers both orientations of every edge. So Theorem 1 holds,
  given the imported Theorem 3.

**§3 Proof of Theorem 2 (p. 5).**
- "Following the approach of [15], we show that χ(K_s^{Ω_w(K_m)}) ≥ 2s − 6 for m > s ≥ 8 and w large enough."
- The argument: each 4-subset of colours spans a copy of `K₄^{Ω}`, which by Theorem 1 needs an extra colour. Disjoint 4-sets are
  completely joined. So the extra colours properly colour the Kneser graph `Kn(s, 4)`, whose chromatic number is `s − 6` by Lovász.
- Conclusion: "f(2s − 6) ≤ s, or f(n) ≤ n/2 + 3 for n even and at least 10". The small cases follow by monotonicity.

**References (p. 6):** 16 works, mined in §6.

## 3. The construction's shape

- **Hypotheses used:** none fractional, none about symmetry, none about odd girth. The only imported fact is `χ(Ω_w(K_m)) = m`
  (Theorem 3), whose lower bound is topological (`[SimonyiTardos2006]`, Wrochna 2019).
- **`H` is the exponential graph `K_n^G`.** Its non-`n`-colourability is elementary. It uses:
  - the constant-map clique `K_n` with the image normalisation;
  - maps with image of size ≤ 3 (`[Zhu2025]` notes they all lie in the closed neighbourhood of the constant clique);
  - a binary tree of depth `log₂ m`, built from `σ`/`τ` maps, with a 5-cycle at each leaf.
- **`G = Ω_w(K_m)`**, the universal graph for `w`-wide `m`-colourings (Gyárfás–Jensen–Stiebitz, Simonyi–Tardos).
- **The product colouring is the evaluation map `(u, f) ↦ f(u)`.** It is local at neither factor, and necessarily so, since neither
  factor is `n`-colourable.
- **Which factor carries the integrality gap is not stated.**
  - By `[Zhu2011]` some factor has `χ_f ≤ n` (§5.1). Since `K_n^G ⊇ K_n`, either `χ_f(G) ≤ n` or `χ_f(K_n^G) = n`.
  - The paper computes neither.
  - `[Zhu2025]` §3 lists this construction (its Thm 3.8) among the counterexamples to the *topological* weakening, but not among those
    to the *fractional* weakening ("`χ_f(G) > n` and `χ(H) > n` ⟹ `χ(G × H) > n`"). [reading, low confidence, an inference from
    silence]: the gap is in `G`.

## 4. Our citations, checked (Q2)

### 4.1 Which statement is right

**The abstract's statement is the paper's Theorem 1, verbatim.** The bibliography row's statement (every `m₁, m₂ ≥ 5` has `G, H` with
`χ(G) = m₁`, `χ(H) = m₂` and `χ(G × H) < min(m₁, m₂)`) is **not in the paper**, but it is **equivalent** to Theorem 1 [hand]:
- **Theorem 1 ⟹ row.** Say `m₁ ≤ m₂`. Apply Theorem 1 with `n = m₁ − 1 ≥ 4` and `m = m₂`. Delete vertices one at a time; each deletion
  lowers `χ` by at most 1, so there are induced subgraphs with `χ` exactly `m₂` and `m₁`. Their product is a subgraph of `G × H`, so it
  is still `≤ m₁ − 1`-colourable.
- **Row ⟹ Theorem 1.** Take `(m₁, m₂) = (n + 1, m)`.
- **The title's "can be 4".** Theorem 1 at `n = 4`, `m = 5`, trimmed to exactly five colours on each side, gives a product with
  `χ ≤ 4`. El-Zahar–Sauer (as the paper states them) gives `χ ≥ 4`. So `f(5) = 4`, matching `[Zhu2025]` §6.
- **Attribution.** The row calls its sentence "the publisher's abstract". Only the quoted clause ("the last remaining open case …")
  is the abstract's. The formula is a paraphrase and should be marked as ours.

### 4.2 Every citation site

| # | where | what it claims | verdict |
|---|---|---|---|
| 1 | `CLAUDE.md` G55 (line 902) | "Hedetniemi already fails (the product of two 5-chromatic graphs can be 4-chromatic, `[Tardif2023]`; from four colours up no level of the conjecture survives, `[Zhu2025]`)" | **holds** (§4.1; Theorem 1 alone covers every `n ≥ 4`). **The inference it supports overreaches for residue targets**: the product step survives at four colours (§5.2) |
| 2 | `CLAUDE.md` G43 | cites `[Shitov2019]`, `[Zhu2011]`, `[Zhang2012]`, **not** `[Tardif2023]` (the brief listed it) | n/a; its "only through an integrality gap `χ_f ≤ k < χ`" is exactly `[Zhu2011]`, and Tardif's examples are consistent with it (§3) |
| 3 | `BIBLIOGRAPHY.md` `[Tardif2023]` row | the `m₁, m₂` form; "publisher's abstract only"; "not held (closed access)"; "no arXiv version found"; "restated as `[Zhu2025]` Thm 3.8" | **statement holds** (equivalent, §4.1) but is not the paper's wording. **Read-status and holding are now stale.** The Thm 3.8 pointer is correct |
| 4 | `BIBLIOGRAPHY.md` `[ElZaharSauer1985]` row | "the conjecture fails at every higher level … so three colours is its last true level" | **holds**. Tardif p. 1: `K₁, K₂, K₃` multiplicative, `K_n` not for every `n ≥ 4` |
| 5 | `BIBLIOGRAPHY.md` `[Shitov2019]` row | "after `[Wrochna2020]` and `[Tardif2023]`, false at every level from four colours up" | **holds** |
| 6 | `BIBLIOGRAPHY.md` `[Zhu2025]` row | "fails for n ≥ 4 (`[Tardif2023]`; earlier n ≥ 5 `[Wrochna2020]`, n ≥ 13, n ≥ 125, large `[Shitov2019]`)"; f(5) = 4 | **holds**; matches Tardif's p. 1 history (126 → 14 → 6 → 5 in the `min χ` indexing) |
| 7 | `BIBLIOGRAPHY.md` alias `[Tardif2022]` → `[Tardif2023]` | re-keying | **holds** |
| 8 | `BIBLIOGRAPHY.md` `[TardifThirteen2022]` | "intermediate step (n ≥ 13) superseded by `[Tardif2023]`" | **holds**; it is Tardif's ref. [11], Combinatorica 42 (2022) 301–308 |
| 9 | `plans/STUB-three-colour-classification.md` l. 41, l. 119 (FS-46) | "at five the product of two 5-chromatic graphs can be 4-chromatic … so the same argument cannot run at the next level"; P3 (hunch): "the four-colour level cannot be proved by any product theorem … exactly where the argument would need it", falsifier "a product theorem for the specific factors (Cayley graphs of 𝔽_q²) at five colours" | **the fact holds; P3's falsifier is met at the product step** (§5.2): for residue targets `[Zhu2011]` plus their fractional floors is that product theorem. The four-colour level is blocked elsewhere, at the descent |
| 10 | `plans/STUB-adelic-window-colouring.md` l. 126 (FS-64) | "known Hedetniemi failures (`[Shitov2019]`, `[Tardif2023]`, `[Zhu2025]`) are built from exponential graphs and look nothing like Cayley graphs of abelian groups" | **holds**: `H = K_n^G`, `G = Ω_w(K_m)`; the paper uses no symmetry |
| 11 | `plans/FS86-C-Coxeter.md` l. 95 (C4) | "`HG × P₄` would have to be a Hedetniemi-type product (four-colourable while its factor `HG` perhaps is not; `[Tardif2023]` shows four is possible in general)" | **holds "in general"**, as an analogy. Tardif's exponent graph has no four-colourings, while `P₄` has them. The operative object is the improper part of `K₄^{P₄}`, which the paper does not treat (§5.4 makes this exact) |
| 12 | `plans/POROS-2026-09-23-fs73-plan.md` l. 76, l. 109 | composite-period colourings "not excluded by a prime-by-prime table", since `Λ/pqΛ`'s graph is a diagonal subgraph of the product and "at four colours Hedetniemi fails (`[Tardif2023]`…)" | **the conclusion holds, but for a different reason**: the diagonal graph is a *spanning subgraph* of the product, so a non-colourable product would not make it non-colourable either — true even if `K₄` were multiplicative. Tardif is not the operative reason |
| 13 | `plans/ASTRA-2026-09-14-derivation.md` l. 30; `plans/FS54-twenty-seven.md` l. 409; `plans/FS54-derivation.md` l. 314; `data/fs71/batch-6b.md` l. 81; `plans/FRONTIER-STUBS.md` l. 67 (as `[Tardif2022]`, "to check at PA") | the same one fact, or the re-keying | **hold**. The FRONTIER-STUBS row still carries the retired alias `[Tardif2022]` and says "Hedetniemi fails at five", meaning factors needing five, i.e. `K₄` |

## 5. Does the construction bear on our products? (Q3)

### 5.1 What any Tardif-type example must satisfy

`[Zhu2011]` (read here only as `[Zhu2025]` Thm 2.4, with its proof sketch) states `χ_f(G × H) = min(χ_f(G), χ_f(H))` for all finite
graphs. So if `χ(G × H) ≤ n`, some factor has `χ_f ≤ n`, and a Hedetniemi counterexample at `n` needs a factor with
**`χ_f ≤ n < χ`** — an integrality gap [derived]. The paper neither states nor uses this; its examples satisfy it (§3).
- **Where `[Zhang2012]` adds:** for vertex-transitive factors it gives the same ratio statement, plus Thm 1.8(i)'s structure — with a
  strict ratio inequality, every maximum independent set of the product is a preimage from one factor.
- **The two regimes:** Zhang's is the regime where colourings are local; Tardif's is the complementary one.
- **The paper has no theorem about vertex-transitive factors, and none about when `χ_f > n` factors can multiply to `n` colours** —
  by Zhu they never can.

### 5.2 Four colours: no residue target has the gap, so `K₄` is multiplicative on residue targets [derived + tools]

**Claim.** Take any finite family of residue targets: the usable planes `Γ_q` at any tower level, the dyadic `U_Q`, and hence every CRT
product of first-level targets. Their categorical product is 4-colourable iff some factor is.

**Proof.** A target needing five or more colours has `χ_f > 4`, as the table shows; then apply `[Zhu2011]`.

| target (all tower levels) | `χ_f` lower bound | source |
|---|---|---|
| `Γ₁₁` | `121/28.2043 = 4.290` | row 75's `B₁` certificate, every level |
| `Γ₁₉` | `361/77.5117 = 4.657` | row 75, every level |
| `Γ₂₃` | `529/97.9846 = 5.399` (Hoffman 4.0148) | row 75; Hoffman |
| `Γ₂₇` | Hoffman `1 + 28/8 = 4.5`, λ_min = −8 exact | row 70; ratio constant up inert towers (G54) |
| `Γ₃₁` | Hoffman `4.00004`; at level one `α ≤ 240` ⟹ `≥ 961/240 = 4.004` | G54's exact margin (`λ_min + d/3 = 1.56·10⁻⁴ > 0`); the only thin one |
| `Γ₄₃`, `Γ₄₇` | Hoffman 4.678, 4.736 | spectrum (`hoff.py`, below) |
| `Γ_q`, `q ≥ 59` | Hoffman ≥ 5.02 computed to 83; beyond, Weil gives `1 + (q+1)/(2√q) > 4` for every `q > 34` | G44 |
| `U₆₄`, `U_Q` (`Q ≥ 128`) | Hoffman 5.33 (λ_min = −15), floor 8 | G56, row 70 |

**Factors that need at most four colours:** `Γ₃`, the tower at 7, `U_Q` for `Q ≤ 32`, and the ramified dyadic targets.

**The spectrum script.** Hoffman floors `1 + d/|λ_min|` were recomputed from exact character sums in floating point
(`scratchpad pa-tardif/hoff.py`, not committed). It reproduces the controls: `Γ₃` = 3 (tight); 59 (5.02) and 71 (6.08) match "five
refused from 59 up" and "six from 71".

**Consequences.**
- **Tardif's phenomenon cannot occur among residue targets at four colours.**
- For G55's three-colour argument, **the step "a four-colourable product of targets has a four-colourable factor" holds for these
  factors**. So G55's "the same argument cannot run at four colours, where Hedetniemi already fails" names the wrong obstruction.
- What fails at four colours is the descent: at three colours the rhombus makes every colouring `3R`-periodic, and nothing gives an
  arbitrary four-colouring an ideal period over a general field (compare rows 85, 88–92, where periodicity is the whole question).

**Kernel-free caveat:** the claim rests on `[Zhu2011]`, which is unread here.

### 5.3 Five colours: the same, with two named holes [derived]

The factors needing six or more colours at level one have fractional certificates `χ_f > 5`:
- 23: `α ≤ 105`;
- 27: `α ≤ 141`, giving `≥ 5.17`;
- 43: `α ≤ 365`, giving `≥ 5.07`;
- 47: `α ≤ 371`, giving `≥ 5.95`;
- `q ≥ 59` and `U₆₄`: Hoffman.

These are rows 69–71, and they hold at every level for 23 (row 75), `q ≥ 59` and `U_Q` (`Q ≥ 64`).

**Not covered:**
- **`Γ₃₁`:** `χ_f ∈ [4.004, 6.58]`, and `χ(Γ₃₁) ≥ 5` undecided above five. A gap `χ_f ≤ 5 < χ` is open.
- **Levels ≥ 2 at 27, 31, 43, 47:** only Hoffman survives there, at 4.5, 4.0, 4.68 and 4.74.

**So:** a composite residue target can beat its best prime at five colours only through `Γ₃₁` or a higher tower level at 27, 31, 43 or
47. At six colours this is G59's W_f statement, already recorded.

### 5.4 FS-67 in exponential-graph form [hand, this reading]

**Definitions.** Let `G` have no isolated vertices, and suppose every proper `k`-colouring of `G` is gap-free: every closed
neighbourhood sees all `k` colours. The looped vertices of `K_k^G` are the proper `k`-colourings. Let `E_k(G)` be the subgraph of
`K_k^G` induced on the maps that are not proper colourings.

**The statements.**
- **(i)** Every loop is adjacent only to itself. If `f` is proper and `g ~ f`, then `g(v) ∉ f(N(v))`, which is every colour except
  `f(v)`, so `g = f`.
- **(ii)** Let `H` be connected. The `k`-colourings of `G × H` correspond to the homomorphisms `Φ : H → K_k^G`, via
  `c(u, h) = Φ(h)(u)`; this is the evaluation map of p. 3, read in both directions. By (i), either `Φ` is constant at a loop — a
  pullback from `G` — or `Φ(H) ⊆ E_k(G)`.
- **(iii)** Therefore: every `k`-colouring of `G × H` is pulled back from `G` for every connected `H` with `χ(H) > k` **iff
  `χ(E_k(G)) ≤ k`**.

**How it relates.**
- **Greenwell–Lovász** (`G × K_n` uniquely `n`-colourable when `χ(G) > n`; relayed in FS-67 §2) is the case `G = K_k`:
  `χ(E_k(K_k)) ≤ k`.
- **Tardif's Theorem 1** is the opposite: `χ(K_n^G) > n` for a `G` with no loops.
- **So FS-67's open remainder is exactly Tardif's regime.** That remainder is the integrality gap `χ_f(H) ≤ k < χ(H)`; Zhang settles the
  strict-ratio case.
- **His argument is the template for a counterexample:** a normalised constant clique, image-size-≤ 3 maps, and a tree ending in odd
  cycles, found inside `E_k(G)` for a tight `G`.
- **A proof would be a `k`-colouring of `E_k(G)`.** By the image normalisation, it may be taken to colour each map within its own
  image.
- This reframing is recorded nowhere in FS-67's stub or FS-86's derivation. It needs no search to state. Testing it on a finite `G`
  would be a finite-witness question, for after 2026-10-01.

## 6. References mined (Q4)

| Tardif's ref | work | here |
|---|---|---|
| [1] | S. Baum, M. Stiebitz, *Coloring of graphs without short odd paths between vertices of the same color class*, unpublished (2005) | not held, not cited |
| [2] | M. El-Zahar, N. Sauer, Combinatorica 5 (1985) 121–126 | `[ElZaharSauer1985]`, not held (paywalled) |
| [3] | A. Gyárfás, T. Jensen, M. Stiebitz, *On graphs with strongly independent color-classes*, JGT 46 (2004) 1–14 | not held, not cited |
| [4] | H. Hajiabolhassan, *On colorings of graph powers*, Discrete Math. 309 (2009) 4299–4305 | not held, not cited; a source of Theorem 3 |
| [5] | A. Hajnal, *The chromatic number of the product of two ℵ₁-chromatic graphs can be countable*, Combinatorica 5 (1985) 137–139 | not held, not cited |
| [6] | S. Hedetniemi, *Homomorphisms of graphs and automata*, Tech. Rep. 03105-44-T, Univ. Michigan (1966) | not held, not cited |
| [7] | L. Lovász, *Kneser's conjecture, chromatic number, and homotopy*, JCTA 25 (1978) 319–324 | `[Lovasz1978]` |
| [8] | S. Poljak, *Coloring digraphs by iterated antichains*, CMUC 32 (1991) 209–212 | not held; named in `[Zhu2025]` row only |
| [9] | Y. Shitov, Ann. of Math. 190 (2019) 663–667 | `[Shitov2019]`, not held |
| [10] | G. Simonyi, G. Tardos, *Local chromatic number, Ky Fan's theorem and circular colorings*, Combinatorica 26 (2006) 587–626 | `[SimonyiTardos2006]`, **held** (arXiv math/0407075) |
| [11] | C. Tardif, *… 14-chromatic graphs can be 13*, Combinatorica 42 (2022) 301–308 | `[TardifThirteen2022]` (listing) |
| [12] | M. Wrochna, *On inverse powers of graphs and topological implications of Hedetniemi's conjecture*, JCTB 139 (2019) 267–295 | not held, not cited; the other source of Theorem 3 |
| [13] | M. Wrochna, *Smaller counterexamples to Hedetniemi's conjecture*, arXiv:2012.13558 | `[Wrochna2020]`, **held, read** |
| [14] | X. Zhu, *A survey on Hedetniemi's conjecture*, Taiwanese J. Math. 2 (1998) 1–24 | not held (distinct from `[Zhu2025]`) |
| [15] | X. Zhu, *A note on the Poljak–Rödl function*, arXiv:1911.12015; journal: EJC 27 (2020) P3.2 | not held, not cited |
| [16] | X. Zhu, *Relatively small counterexamples to Hedetniemi's conjecture*, JCTB 146 (2021) 141–150 | not held; `[Zhu2025]`'s [77] |

Also held and relevant, though not cited by Tardif: `library/pdf/tardif-2008-hedetniemi-conjecture-40-years-later-GTN54.pdf` (FS-67's
Greenwell–Lovász relay).

## 7. Proposed bibliography row (for the close planner)

| key | entry | role | copy | read |
|---|---|---|---|---|
| **[Tardif2023]** | C. Tardif, *The Chromatic Number of the Product of 5-Chromatic Graphs can be 4*, Combinatorica 43(6) (2023) 1067–1073, doi 10.1007/s00493-023-00047-2 (received 22 Nov 2022, revised 29 Apr 2023, accepted 3 May 2023; Crossref); no arXiv version found | **Thm 1 (verbatim):** "For any integers n ≥ 4 and m > n, there exist graphs G, H such that χ(G) ≥ m, χ(H) > n and χ(G × H) ≤ n" — `K₄` (and every `K_n`, `n ≥ 4`) is not multiplicative; equivalent (by vertex deletion) to "every `m₁, m₂ ≥ 5` has `G, H` with `χ` exactly `m₁`, `m₂` and `χ(G × H) < min`" (ours, `plans/PA-tardif2023.md` §4.1). **Thm 2:** `f(n) ≤ ⌈n/2⌉ + 3`. **Construction:** `G = Ω_w(K_m)` (wide-colouring universal graph, `χ = m` imported from Hajiabolhassan 2009 / Wrochna 2019), `H = K_n^G`; non-colourability via a binary tree of image-≤ 3 maps closing in 5-cycles. Cited by G55, FS-46, FS-64, FS-73's plan review, FS86-C C4, and the other rows listed in the record; nothing of ours derived from it. By `[Zhu2011]` every such example has a factor with `χ_f ≤ n < χ`; no residue target has one at `n = 4` (record §5.2) | `library/pdf/Tardif2023-product-5-chromatic-graphs-can-be-4.pdf` — **the submitted preprint** (6 pp., dated 22 Nov 2022 = received date; typos listed in the record §1) | **read in full** (2026-09-25, de Bruijn; Theorem 1's proof walked line by line; the journal version unread) |

## 8. Theorems this reading proved

| id | statement | grade | where |
|---|---|---|---|
| PA-T1 | Tardif's Theorem 1 holds as proved, modulo the imported `χ(Ω_w(K_m)) = m` and the index typos of Lemma 8 | hand (a check, not new) | §2 |
| PA-T2 | The row's `m₁, m₂` form ⟺ Theorem 1 | hand | §4.1 |
| PA-T3 | Any Hedetniemi counterexample at `n` has a factor with `χ_f ≤ n < χ`; in Tardif's, `χ_f(G) ≤ n` or `χ_f(K_n^G) = n` | derived from `[Zhu2011]` (unread) | §3, §5.1 |
| PA-T4 | A product of residue targets (any levels, `U_Q`) is 4-colourable iff a factor is; G55's four-colour obstruction is the descent, not the product | derived + tools (floats; one thin margin at 31 covered by G54's exact sign) | §5.2 |
| PA-T5 | At five colours the same, except possibly via `Γ₃₁` or tower levels ≥ 2 at 27, 31, 43, 47 | derived | §5.3 |
| PA-T6 | Gap-free `G`: loops of `K_k^G` isolated; FS-67 for all connected `H` with `χ(H) > k` ⟺ `χ(E_k(G)) ≤ k`; Greenwell–Lovász is `G = K_k` | hand | §5.4 |

**Kernel decision for each:** decline for T1–T2 (they are checks). T3–T5 wait on `[Zhu2011]` being read. T6 is a candidate for FS-67's
stub and for its D4 kernel form.

## 9. Owed

- `[Zhu2011]` itself, which PA-T3–T5 rest on (ScienceDirect refuses scripted fetches; OpenAlex marks it free in a browser).
- The journal version, to confirm the typo fixes and the `w = 4k + 1` statement.
- Which factor of Tardif's example carries the gap (the reading in §3).
