# FS-50 §PA — the prior-art gate for "is α(UD(𝔽₈₃, 2)) ≥ 1,149?" (run 2026-09-14, before the subplan; WORKFLOW step 3a)

*The section the subplan carries as §PA. Half a day. Its output is one negative (no known bound below the threshold, no
exact value of α for any finite Euclidean plane in the literature) and one measured instrument: the real-plane
1-avoiding-set LP transplanted to the finite plane, which bites 12% at 11 and 0.2% at 83, where 4.2% is needed. Records
under `data/fs50/` (`lp-*.json`); the tool is `tools/fplane_lp.py` (self-test green).*

## 1. The names searched (the four questions of the gate)

1. **In the disciplines' words, never ours.** The object is (i) *the independence number of the finite Euclidean graph
   `E_q(2, 1)`* (Medrano–Myers–Stark–Terras, Bannai–Shimabukuro–Tanaka), (ii) *a subset of `𝔽_q²` avoiding one distance*
   — the single-distance case of the Erdős–Falconer problem over finite fields (Iosevich–Rudnev), (iii) *an independent
   set of the generalized Paley graph `GP(p², p − 1)`* — the Cayley graph of `𝔽_{p²}` on the norm-one subgroup of order
   `p + 1` (`[SchneiderSilva2013]`, already held), (iv) *a code in the norm-class translation scheme* (Delsarte, Schrijver),
   and, one level up, (v) *the density of planar sets avoiding unit distances* `m₁(ℝ²)` and the independence ratio of
   unit-distance graphs (Székely, de Oliveira Filho–Vallentin, Keleti–Matolcsi–de Oliveira Filho–Ruzsa, Ambrus et al.,
   Dúcz–Varga). Search strings used: "independence number unit distance graph finite field", "sets avoiding a single
   distance F_q^2", "finite Euclidean graph independent set Kloosterman", "generalized Paley graph independence number
   norm subgroup", "Erdős–Falconer single distance q^{3/2} sharp dimension two", "Lovász theta Cayley graph abelian group
   Delsarte linear programming", "exact maximum independent set vertex-transitive symmetry breaking", "Andrade Resende
   Werneck / NuMVC".
2. **Two disciplines.** Finite-field geometry and additive combinatorics (the Iosevich lineage) against algebraic graph
   theory and coding-theory bounds (Delsarte, Schrijver, generalized Paley graphs); the real-plane analogue as a third room.
3. **The question, not only the method.** "What is `α(UD(𝔽_q, 2))` exactly, at any `q`?" and "is there a 1-avoiding set
   of size `≈ q^{3/2}` in `𝔽_q²`?" — neither is posed or answered anywhere found. Every bound in the finite-field lineage is
   the ratio bound with Weil's estimate; the only constructions are the `p` points of a line in a non-residue direction.
4. **Outside arXiv, and the citation graph of the paper that posed the question.** `[IosevichRudnev2007]`'s 223 citing
   works on Semantic Scholar (arXiv:math/0509005) filtered by *independ|avoid|chromat|colour|unit distance|Euclidean
   graph|Paley|clique|Ramsey|distance graph* give 12 titles, all embedding results (cycles, paths, trees, configurations in
   large sets) — none on the independence number at one distance. `[Vinh2008]`'s citing works listed in **two databases
   with identifiers compared** (Semantic Scholar 34 via arXiv:0711.3508; OpenAlex 23 via `W3000727783`, the EJC DOI
   `10.37236/729`): the same lineage, none on `α`. EJC, Michigan Math. J. and IEEE Trans. Inform. Theory were reached
   directly.

## 2. What was found, with verdicts

| key | what it holds | verdict for FS-50 |
|---|---|---|
| `[Vinh2008]` (EJC 15 (2008) R5) | **Theorem 12 / eq. (13):** `α(E_q(d, Q, a)) ≤ 2q^{(3d−1)/2}/(q^{d−1} − q^{(d−1)/2}) ≤ 3q^{(d+1)/2}` — Hoffman's ratio bound with the Weil estimate `λ_min ≥ −2q^{(d−1)/2}`; `χ ≥ q^{(d−1)/2}/(4 + o(1))`; the triangle-free members as explicit Ramsey graphs `R(3, k)` | the prior art for "`α` of these planes is bounded by the ratio bound"; at `d = 2, q = 83` it reads `≤ 2,269` against our exact `1,199.46`; no exact value, no construction, the question not posed |
| `[HIKSU2008]` (arXiv:0804.3036) | "coloring" is the **edge**-colouring of `K_{q^d}` by quadrance (kaleidoscopic pseudo-randomness: every `k`-point configuration in a set of size `≫ q^{d(k−1)/k + …}`); diameters of the distance graph | not vertex colouring; not our question |
| `[IosevichRudnev2007]` | a set of size `> 2q^{(d+1)/2}` (the abstract's constant; `4q^{3/2}` in dimension two per the survey listings) determines every distance; `[CEHIK2012]` lowers the exponent to `4/3` for a *positive proportion* of distances | ratio-bound strength again; the single-distance question is not the "all distances" one; nothing in dimension two below `q^{3/2}` for one avoided distance |
| `[Schrijver1979]` (IEEE IT 25 (1979) 425–429) | `ϑ′ ≤ ϑ`; for a graph whose edge set is a union of classes of a symmetric association scheme, `ϑ` is computed by Delsarte's LP | **the blindness is a theorem plus a measurement**: our scheme's LP (`fplane.py theta`) equals Hoffman at 11, 19, 23, 83; so no LP or SDP over the scheme drops below 1,199 (M61 had `ϑ =` Hoffman by `[Lovasz1979]` Thm 9 for arc-transitive graphs; this names the coding-theory half) |
| `[SchneiderSilva2013]`, `[Krebs2022]`, `[Vinh2006]` (held) | the plane as `GP(p², p−1)`; `ϑ =` Hoffman by edge-transitivity; `α ≤ q^n/ω` (Krebs Prop. 6.1: `≤ 2,296` at 83) | already in the record; nothing sharper |
| **the real-plane lineage:** Székely 1984 (`12/43 ≈ 0.279`), `[OliveiraVallentin2010]` Thm 1.1 (the Fourier LP; `0.2684` with the triangle constraint), `[KMOR2016]` Lemma 3.2 (`0.258795`), Ambrus–Matolcsi 2022 (`0.2544`, triple correlations), `[AmbrusEtAl2023]` Lemma 1 and Theorem 1 (`0.2470`, the full inclusion–exclusion atoms of a 23-point set), `[DuczVarga2026]` (a finite unit-distance graph with independence ratio `< 1/4`, Erdős's question) | **the method: the autocorrelation LP with inclusion–exclusion constraints from small unit-distance subgraphs**, which improved the pure Fourier bound by 6–14% in the plane | **transplanted and measured — §3**; it does not reach at 83 |
| `[AndradeResendeWerneck2012]`, `[CaiEtAl2013]` | iterated local search for maximum independent set with `(1,2)`-swaps in `O(degree)` via tightness counts; NuMVC's edge weighting and configuration checking for minimum vertex cover | the two standard shapes, handed to WO-18's planner as pointers, its choice |
| the IP-symmetry names (Margot's isomorphism pruning; Ostrowski–Linderoth–Rossi–Smriglio's orbital branching) | symmetry-exploiting exact branch-and-bound | listed, unread; the cube-and-conquer over rotation orbits (stub D2) is the SAT-side form of the same idea |

**Not found under any name tried:** an exact value of `α(UD(𝔽_q, 2))` at any `q`; any upper bound on it other than the
ratio bound; any construction of a 1-avoiding set larger than a line. The certificate side of FS-50 is unworked ground,
and the independence ladder this project holds (`α(11) = 28`, `α(19) ≥ 76`, `α(23) ∈ [69, 131]`) is itself a table no
paper carries.

## 3. The transplant, measured: the autocorrelation LP on the finite plane (`tools/fplane_lp.py`)

**The derivation (the three lemmas hold verbatim on `𝔽_p²`).** For `S ⊆ 𝔽_p²` independent, `n = p²`, `δ = |S|/n`, the
autocorrelation `a(t) = |S ∩ (S + t)|/n` satisfies: (1) `a(t) = 0` on the unit circle; (2) for a finite unit-distance graph
with vertex set `V` and independence number `α_V`, `Σ_{x∈V} a(x) ≤ δ·α_V` (each `z` lies in at most `α_V` of the sets
`S − x`, `[KMOR2016]` Lemma 3.2 (2)), and since `a` is translation-invariant this holds for every translate `V + z`; (3)
Székely's inclusion–exclusion `Σ_{pairs ⊂ C} a(x − y) ≥ |C|δ − 1`; (4) `[AmbrusEtAl2023]` Lemma 1's atoms `a_X(ε)` for a
point set `X`; and Fourier positivity `â ≥ 0`. Averaging over the orthogonal group makes every quantity a function of
the quadrance class (`p − 1` classes of `p + 1` points; no isotropic vectors at `p ≡ 3 (mod 4)`), the Fourier constraint
becomes the scheme's eigenmatrix (Kloosterman sums, `fplane.scheme_eigen`), and with `g(c) = a/δ` on class `c`,
`g(0) = 1`, `g(1) = 0`, `|S| = 1 + (p+1)Σ_{c≥2} g(c)`: **without (2)–(4) this is exactly Delsarte's LP = `ϑ′`**; a size `s`
at which the LP with (2)–(4) is infeasible certifies `α < s` (a set of size `≥ s` contains one of size `s`, whose `a`
satisfies every row).

**Graphs drawn** (each `α_V` recomputed exactly by branch and bound, never assumed): the unit triangle, the rhombus, the
hexagonal wheel `W₆`, the Moser spindle (needs `√3` and `√11` in `𝔽_p`: present at 11 and 83, absent at 19 and 23), the
circle with its centre (`α = (p+1)/2`, the circle being `(p+1)/6` disjoint hexagons), two wheels sharing an edge, the
centre with two and three of the circle's hexagons, the 19-point hexagonal patch of the triangular lattice; rows for
every translate, deduplicated by class multiset (1,190 / 1,764 / 616 / 3,485 / 83 / … rows at 83).

| `p` | Delsarte (`ϑ′` = Hoffman) | + subgraph rows | drop | the graph that bites | + Székely, + atoms (10–19-point sets) | threshold `⌈n/k⌉` | truth |
|---|---|---|---|---|---|---|---|
| 11 | 34.550 | **30.392** | 12.0% | the spindle (30.39), the triangle (31.95), the patch (34.31) | 30 (no further drop) | 25 (`k = 5`) | **28** |
| 19 | 99.498 | 99.498 | 0 | no triangle at 19: no graph bites | — | 73 | ≥ 76 |
| 23 | 131.762 | **126.755** | 3.8% | the triangle only | 125–126 | 106 | ∈ [69, 131] |
| 83 | 1,199.459 | **1,197.064** | **0.2%** | the triangle only; the spindle's 3,485 rows do nothing | 1,197 | **1,149** (`k = 6`) | ? |

**Controls (self-test, green):** with no added rows the LP reproduces `ϑ′` from `data/fplane/theta-below-84.json`; the
verified sets stay feasible under every family (28 at 11, 76 at 19 — a row that cut below the truth would be a wrong
`α_V` or a wrong translate); a planted `α(W₆) = 2` moves the bound (34.55 → 29.99) and the move is bounded on both
sides (`0 < 4.56 < 6.55`), so the rows are live and the control can tell when they are not.

**Reading.** The instrument that closed a 10–14% gap in the real plane fades with `p`: 12% at 11, 3.8% at 23, 0.2% at 83,
against the 4.2% the threshold needs. A 7-point graph is 6% of the plane at 11 and 0.1% at 83, and the Hoffman-extremal
`g` concentrates its mass where no small graph's translates constrain it; the atoms of a 19-point set add nothing at
any prime. **So no local relaxation closes FS-50 at 83, and the certificate needs search** (the stub's phases B–C stand);
what the LP does give is a sharper bound at the small primes for the record (30 at 11 against 28; 126 at 23). A larger
`V` with exact `α_V` — the ball of radius 2 (≈ 3,500 points, `α` by SAT) or the 505-point union of the spindle's
rotations about a centre — is the one untried lever, priced not run: its `α_V` is itself an instance of the question.

## 4. What the gate aims

The milestone's certificate side answers a question no paper asks in this form; the coding-theory side says why the
relaxations are blind; the real-plane side says why local constraints cannot rescue them here. The two literatures
that could have held the answer do not cite each other (the Iosevich lineage never names Delsarte or Schrijver; the
`m₁(ℝ²)` lineage never names a finite field), which is where this project's finite-plane table sits.

## 5. Bibliography

Added the same day (§A): `[Vinh2008]`, `[HIKSU2008]`, `[OliveiraVallentin2010]`, `[KMOR2016]`, `[AmbrusEtAl2023]`,
`[Schrijver1979]`, `[AndradeResendeWerneck2012]`, `[CaiEtAl2013]`; `[IosevichRudnev2007]` updated with the citation walk;
§C listings for Ambrus–Matolcsi 2022, Székely 1984, Bachoc–Passuello–Thiéry 2015, `[CEHIK2012]`, Hart–Iosevich–Koh–Rudnev
2011, Podestá–Videla 2018, Yip's subfield-clique line, Margot 2002, Ostrowski et al. 2011. Seven PDFs into
`~/source/library/pdf/`.
