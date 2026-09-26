# FS67-J27V — blind verification of FS-67's fixed claim list (crunch job J27V)

*De Bruijn, blind verifier, Opus 5.5, 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J27V-FS67-verifier.md` (+ `STANDING-RULES.md`).
Blind phase = stages 1–2: nothing fenced was opened before stage 2's commit.*

## Theorems this phase proved

*(Filled at each stage; grades per `CLAUDE.md` § Notation. "Inputs" are the brief's verified inputs.)*

- J27V-T1 (= V-DA-1′) — TRUE [hand]; §2.1.
- J27V-T2 (= V-DA-2′) — TRUE [hand]; §2.2.
- J27V-T3 (= V-DA-3) — TRUE [hand, given `[GreenwellLovasz1974]` Cor. 1]; §2.3.
- J27V-T4 (= V-DA-4) — TRUE [hand, given `[Tardif2023]` Thm 1 (its graphs are finite, checked in the PDF) and T3]; §2.4.
- J27V-T5 (V-DB-1, partial) — GAP at a named step; proved: the non-3-colourable case (via El-Zahar–Sauer as cited in `[Tardif2023]`), and a
  winding invariant `w₂` constant on components of `K₃^G`; §2.5.
- J27V-T6 (= V-DB-2) — TRUE [hand + tools exact: `tools/crunch_j27v_fq9.py`]; §2.6.
- J27V-T7 (= V-DC-1) — TRUE [hand, given `[GodsilEtAl2020]` Result 1 and Thm 4.16(1)]; §2.7.
- J27V-T8 (= V-DC-2 with `τ_k = 1/(k−1)`, sharp) — TRUE [hand, from J21-MX's mixing lemma]; §2.8.
- J27V-T9 (= V-DD-1) — TRUE [hand, given `[GodsilEtAl2020]` Results 1 and 5]; §2.9.
- J27V-T10 (V-DD-2) — GAP at a named step; the reduction to a spectral Hedetniemi pair is proved; §2.10.

## Stage 1 — SAVED (the quotation check, C0)

### 1.1 The quotation check (standing rule 5)

| item | source | result |
|---|---|---|
| the eleven claims V-DA-1′ … V-DC-3 and the §4.1 definitions | `plans/FS67-tight-products.md` §4.1, §4.3, §5.1 (fenced) | **not checkable** in the blind phase — the plan is fenced; to be checked at stage 4 against the plan. Every verdict below is on the brief's wording |
| `[GreenwellLovasz1974]` Theorem 1, Corollaries 1 and 3 | held PDF pp. 335–336 (scanned; read as page images) | **verbatim match** with `plans/PA-products-GL1974-LT2002.md` §1.2 (Thm 1: "Suppose G is a connected graph such that any two n-colourings of G differ in at least two points. Then each n-colouring of K_n × G is induced by an n-colouring of one of the factors."; Cor 1: "If χ(G) > n and G is connected then K_n × G is uniquely n-colourable."; Cor 3: "(K_n)^k has exactly k n-colourings.") |
| `[Tardif2008]` §4.2 A(n), B(n), "A(n) implies B(n) and B(n) implies H(n)"; Thm 3.2 | held PDF, text layer | present as the brief says (§4.2: "In [17] it is proved that A(n) implies B(n) and B(n) implies H(n)"; Thm 3.2: "Let G be a graph such that every vertex of G is in an n-clique. For every graph H, if χ(G × H ) = n , then min { χ(G), χ(H ) } = n .") |
| `[Tardif2023]` Theorem 1 | held PDF | "For any integers n ≥ 4 and m > n, there exist graphs G, H such that χ(G) ≥ m, χ(H) > n and χ(G × H) ≤ n." Its §2 makes both graphs finite (`G = Ω_w(K_m)`, tuples of subsets of `V(K_m)`; `H = K_n^G`). |
| `[GodsilEtAl2020]` Results 1–5, §4 | held PDF (arXiv 1801.08243) | present; Result 5: "Let G and H be graphs such that χv (G) = χv (H). If both G and H admit connected strictly complementary dual solutions, then every optimal vector coloring of G × H is a convex combination of vector colorings induced by the factors." Thm 4.16(1): "If G is a 1-walk-regular graph … If H is a connected graph and χv (G) < χv (H), then every optimal vector coloring of G × H is induced by G." |
| `[GodsilRobersonRooney2017]` §4.3 Thm 4.9 | held PDF (arXiv 1512.04972) | present; its proof gives, for 1-walk-regular `G` of degree `r`, least eigenvalue `τ`, optimal strict colouring with edge inner product `τ/r`, i.e. `χv = 1 − r/τ` |
| `[Zhang2012]` Thm 1.8 | held PDF | present, cases (i)–(iii) as the stub states |
| J21-MX | `plans/M3-S1D-windows-five.md` §3.2 | present (lemma, consequence `θ = λ*/(1+λ*)`, Theorem J21-MX) |
| G54, row 72 | `CLAUDE.md`, `LEDGER.md` | present |

**Fence log.** Read before stage 2's commit: the stub `plans/STUB-tight-product-colourings.md` (allowed), which itself carries a one-sentence sketch of
DA-2′ ("every loop of `K_k^G` is adjacent only to itself …", from `plans/PA-tardif2023.md` §5.4). My §2.2 proof is written independently but that
sentence was seen. Also read (not fenced): `[TardifWrochna2019]` pp. 1–5 (abstract, §1.2) while working V-DB-1. Nothing fenced opened.

### 1.2 C0 — probabilities per claim (set after the stage-1 reading, before any written derivation)

| claim | P(TRUE as worded) | why |
|---|---|---|
| V-DA-1′ | 0.97 | the stub's `C₅ × K₄` recolouring, generalised |
| V-DA-2′ | 0.95 | stub's sketch; the loop argument is short |
| V-DA-3 | 0.90 | GL Cor 1 plus Weichsel-type connectivity |
| V-DA-4 | 0.85 | needs finiteness in Tardif 2023 |
| V-DB-1 | 0.50 | "every connected non-bipartite `G`" is stronger than El-Zahar–Sauer; unclear |
| V-DB-2 | 0.85 | needs `UD(𝔽₉,2)` tight and 3-colourable |
| V-DC-1 | 0.85 | simplex vector colouring + GEA Thm 4.16 |
| V-DC-2 | 0.80 | J21-MX gives a colouring of `G`; pulling back needs a bootstrap |
| V-DD-1 | 0.50 | Result 5 gives convex combinations; the colouring's discreteness must kill the mixture |
| V-DD-2 | 0.35 | existence of a regular tight counterexample is unclear |

### 1.3 Would-have-searched log (running)

1. *Would have run a colouring search on `E₃(C₅)` (213 maps) to probe V-DB-1.* Instead derived its winding classes by hand (§2.5).
2. *Would have enumerated the 80 `𝔽₃`-functionals on `𝔽₉²` for a linear 3-colouring of `UD(𝔽₉,2)`.* Instead derived the functional
   `Tr((1−i)u + iv)` from three trace conditions (§2.6) and checked only that one, exactly.
3. *Would have searched for a regular graph `X` with `λ_min(X) ≥ −d_X/(k−1)` and a Hedetniemi partner (V-DD-2).* Declined; GAP recorded (§2.10).
