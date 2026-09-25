# M3-S1D — measurable window five-colourings over ℚ(√167): the corner, the count, the pullback (crunch job J21)

*Derivation agent: de Bruijn (Opus 5.5), crunch job J21, 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J21-M3-windows-five-derivation.md`
(with `STANDING-RULES.md`). Plan: `plans/M3-exotic-colourings.md` (§PA.1, §IQ.2, §S, §M). Targets D0–D4 of §S. Blind verifier J22
(not read, not messaged). Working files `data/m3/j21/`; tools `tools/crunch_j21_*.py`.*

## Theorems this phase proved

*(filled at each stage; one line per theorem, grade and address)*

- Stage 1: none (quotation check and priors only).
- **J21-D0** — the corner: a window five-colouring over `{∞₁}` is a measurable proper five-colouring of `UD(ℝ²)`; pullbacks from a real
  place are window colourings over every `S ∋ ∞₁` (Borel to Borel, measurable to measurable); so a "no" over every `S` containing a real
  place implies `χ_µ(ℝ²) ≥ 6` (KM's everywhere-proper `χ_µ`). [hand] §2.1
- **J21-D1** — the count: for finite `S` with no real place, every factor of ratio `< 1/5` ⟹ no window five-colouring, in the
  everywhere-proper format, in C14′'s off-a-null-set format, and with finite levels at finite places. [hand; = C14.3 at `k = 5`] §2.2
- **J21-D1fac** — the factor table of ℚ(√167): 23 (both places) `≤ 0.18523` [cert, row 75]; 59 `≤ 0.19912` [tools: level-one spectrum,
  float with error `< 10⁻¹¹`, margin `8.8·10⁻⁴`; Lemma P]; every stable `p ≥ 67` [Weil + Lemma P]; the ramified 167 `≤ 0.12615`
  [Weil + Lemma P]; every odd split place `0` [C14.2 (c)]; the stable places below 59 are exactly 23 and 43 [tools]. §2.3
- **J21-D1-3** — the place above 3 is split in `F(i)/F` (`F_v = ℚ₉ ∋ i`), ratio 0 (C14.2 (c) at `q = 9`). [hand] §2.4
- **J21-D1-2** — C14.2 (c) holds verbatim at residue size `q = 2`, so the dyadic place (`F_v = ℚ₂(i)`, split) has ratio 0 with error
  `≤ 3/(2n+4)`. [hand; tools: FFT at `ℚ₂(i)`, `(2n+1)λ_min = −2` at `n = 1, 2, 3`, plant fires] §2.5
- **J21-D1-43p** — partial: windows reading the 43-adic places at level one are excluded (`α(Γ₄₃)/1849 ≤ 0.1974`, row 69); the
  fibre-share inequality alone gives exactly Hoffman's `0.21376`, so it cannot close 43 at depth. [hand + cert] §2.6
- **J21-SL (slicing)** — for a locally compact abelian `G`, `Γ = Cay(G, T)` and any measured graph `Y`, a measurable proper `k`-colouring of
  `Γ × Γ × Y` restricts, along `(x, y) ↦ (x, x + s, y)`, to a measurable proper `k`-colouring of `Γ × Y` for almost every `s` (every `s`
  if Borel); properness at every edge is kept for every `s`. [hand] §3.1
- **J21-D3** — `χ_µ(Γ_{∞₁} × Γ_{∞₂}) = χ_µ(Γ_{∞₁})`, and the same for `χ_B`. [hand; J21-SL] §3.1
- **J21-MX (mixing selection)** — `K` compact abelian, `ν` a probability on `T_K ⊆ K`, `λ* = sup_{ξ≠0}|ν̂(ξ)| < 1/(k−1)`: for every Borel
  graph `X`, a Borel proper `k`-colouring of `X × Cay(K, T_K)` yields the Borel proper `k`-colouring `φ(x) = min{j : μ(W(x,·)^{-1}(j)) >
  λ*/(1+λ*)}` of `X`; for measurable `W` proper off a null vertex set, `φ` is measurable and proper off a null vertex set. [hand] §3.2
- **J21-TH (the thick places of ℚ(√167))** — every finite place is 5-thick (a compact Cayley subgraph with `λ* < 1/4`) except the twelve
  above 2, 3, 5, 7, 29, 61 (split) and 23, 43 (stable); for those twelve the standard compact subgraph has `λ* ≥ 1/4` and the uniform
  measure is optimal. [tools + hand; Weil; Lemma P; Kloosterman sums at higher levels, classical] §3.3
- **J21-RED (the reduction)** — for every finite `S`, a Borel window five-colouring of ℚ(√167)'s plane over `S` exists iff one exists over
  `S_red`: `S` with every thick place removed and each conjugate pair (the two real places; the two places above a split prime) merged;
  `S_red ⊆ {∞, 2, 3, 5, 7, 23, 29, 43, 61}`. Measurable, format E over `S` ⟹ format N′ (proper off a null vertex set) over `S_red`. [hand]
  §3.4
- **J21-D2p** — D2(a) and D2(b) hold when every factor of `B` is thick (Borel: iff; measurable: ⟸, and ⟹ into format N′). [hand] §3.5
- **J21-NG1** — the planner's cylinder lemma is false already for `A′ = A = UD(ℝ²)`: an explicit independent set of `A × B` of density
  `> β` that is not a.e. a cylinder, for every `B` of the D2 class. [hand] §3.6
- **J21-NG2** — ratio alone cannot carry D2: a finite abelian Cayley graph `B` with `α(B)/|B| < 1/125` and a graph `A` with
  `χ(A × B) ≤ 125 < χ(A)` exist (Shitov's construction, Zhu's Theorem 3.5 instance). [hand, from `[Zhu2025]` §3 (read)] §3.6

---

## Stage 1 — SAVED (the quotation check, C0)

### 1.1 The quotation check (standing rule 5)

Mechanical checks by a short script (whitespace-normalised string equality) plus reading.

| # | quotation in the brief | source | result |
|---|---|---|---|
| Q1 | the Q2 definitions paragraph ("`F = ℚ(√167)`; `S` a finite set of places … a.e.-properness does not give properness on the countable set `ι_S(F²) + t`.)") | `plans/M3-exotic-colourings.md` §S | **verbatim** (script: MATCH) |
| Q2 | D0, D1, D1-fac, D1-43, D1-2, D1-3, D2(a), D2(b), D3, D4 | same, §S "Q2's target statements" | **verbatim**, all ten (script: MATCH each) |
| Q3 | FS86-Cx-C14's statement line | `plans/FS86-derivation.md` line 382 | **verbatim** (MATCH) |
| Q4 | FS86-CL1's statement line | same, line 411 | **verbatim** (MATCH) |
| Q5 | CL1's scope sentence ("**Not implied:** … are untouched.") | same, line 415ff | **verbatim** (MATCH) |
| Q6 | FS86-LP's statement line | same, line 72 | **verbatim** (MATCH) |
| Q7 | `[KechrisMarks2020]` "§4.7, verbatim: 'the unit distance graph on R², … is known to have 5 ≤ χ(U) ≤ χ_µ(U) ≤ χ_B(U) ≤ 7, … but the exact values of χ(U), χ_µ(U), χ_B(U) are unknown'" | `~/source/library/pdf/KechrisMarks-descriptive-graph-combinatorics-2020.pdf`, read via `pdftotext` | **words verbatim (with the ellipses), section wrong: the passage is Example 5.1 in §5.1 "Examples of graphs with countably infinite Borel chromatic number", pp. 45–46, not §4.7** (§4.7 is "Extensions", p. 33, about Louveau's directed-graph form of the G₀-dichotomy). **Slip** (the brief and `plans/M3-exotic-colourings.md` §PA.1 row 3 both say §4.7). The Problem 4.23 quote ("If G, H are analytic graphs, is it true that χ_B(G × H) = min{χ_B(G), χ_B(H)}?") and "We do not know any other results along these lines. Is C_B(4) true?" are in §4.6, **verbatim**. |
| Q8 | KM's `χ_µ` | KM §3, p. 16: "we define the Φ-chromatic number of D as being the smallest cardinality of a Polish space Y for which there is Φ-coloring c : X → Y of D … χµ (for a Borel measure µ) for the case of … µ-measurable chromatic numbers. Clearly χ ≤ χBM ≤ χB , χ ≤ χµ ≤ χB." | so `χ_µ(U)` is the least number of colours of a colouring **proper at every edge** whose classes are µ-measurable (µ = Lebesgue): Falconer's measurable chromatic number, the everywhere-proper notion. D0 is read in this sense. (KM's conull-invariant-set variant is defined only for the edge chromatic number `χ′_µ`.) |
| Q9 | Polymath16, fourth thread (Mixon, 5 May 2018), "Question. Consider all proper 5-colorings of Tamás’s $V_A\oplus V_A\oplus V_A$ … then the measurable chromatic number of the plane is at least 6 ." | `~/source/library/notes/polymath16-threads-1-18-text.txt`, byte 261056, inside the fourth thread (bytes 258179–334438) | **verbatim** |
| Q10 | first thread (Mixon), "Hans Parshall and I went through Falconer’s proof …" | same file, byte 70155 (before the second thread's opening at 95683) | **verbatim** |
| Q11 | Tao (fourth thread), "Falconer’s argument for CNP ≥ 5 in the measurable case basically proceeds by noting that one can without loss of generality fix one point, say the origin, to be an 'edge' vertex …" | same file, byte 270746; "Terence Tao says: May 5, 2018 at 11:18 am", inside the fourth thread | **verbatim**; context owed: Tao's comment opens "Let’s suppose for simplicity that we are using a coloring where the color regions are polygonal" |
| Q12 | LEDGER row 69, "five refused at 43: `α ≤ 365` against 370" | `LEDGER.md` row 69: "**Five refused at 43** (α ≤ 365 against the 370 five needs)" | faithful |
| Q13 | LEDGER row 75, "23's all-levels bound `97.984637` against 529/5" | row 75: "**`97.984637` (23)** against 529/5 … **none at 23 five-colourable**" | faithful; the bound is on `B₁(23)` (the fibre-share relaxation), hence on `α(G_k)/23^{2(k−1)}` at every level `k` |
| Q14 | "`[Zhang2012]` Thm 1.8 and Prop. 1.7 (held)" | `pdf/arXiv-1007.0797-zhang-independent-sets-direct-products.pdf` p. 4–5 | read: Prop. 1.7 "Let G be a vertex-transitive graph. Then, for every independent set A of G, \|A\|/\|N_G[A]\| ≤ α(G)/\|V(G)\|. Equality implies …"; Thm 1.8 "(i) G × H is MIS-normal, or (ii) … (iii) …" — MIS-normal = every **maximum** independent set is a cylinder |
| Q15 | "Croft's 0.22936 is a construction's density (a lower bound on `m₁`); `[AmbrusEtAl2024]`'s 0.2470 an external computer-assisted upper bound" | `BIBLIOGRAPHY.md` rows `[AmbrusEtAl2024]` / `[Ambrus2023]` and `[AmbrusEtAl2023]` | faithful: **both keys name one paper** (arXiv:2207.14179, Thm 1 `m₁(ℝ²) ≤ 0.2470`); C14 cites it as `[AmbrusEtAl2023]` |
| Q16 | planner's route for D4: "with an archimedean term below `1/28`" | FS86-Cx-C9: "`0 < max ℓ ≤ 1/28`" | **paraphrase, harmless**: C9 allows `max ℓ = 1/28` (the difference then lies in `[1/4, 3/4]`, still proper, half-open arcs); used below in C9's form |
| Q17 | planner's floats: Hoffman ratios `0.24908` (23), `0.21376` (43, least eigenvalue `−11.9622` on degree 44), `0.19912` (59) | `plans/M3-exotic-colourings.md` §X last paragraph | faithful to the plan; **re-derived at stage 2** (a tool) |
| Q18 | owner's news: J01-7 verified (every `k`-colour band character of `R_F` is torsion plus archimedean, `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`); J10 finds C-167 TRUE under the corrected `A` | `plans/FS91-S0V2-SWm-second-reading.md` (C2 verdict row) | consistent with the record's C2 verdict line; used here **only in scope sentences** (the character sub-case of the window format), never as a premise |

**Slips logged for the inventory:** Q7 (KM's §4.7 is §5.1 Example 5.1, in the brief and in the M3 plan §PA.1 row 3).

### 1.2 C0 — probabilities per claim, before any written derivation

*Honest note:* these were set after reading the sources above, during which two routes suggested themselves informally and are
disclosed so that the priors are read with them: (a) D3 by a shear-and-Fubini slicing of `ℝ² × ℝ²`; (b) for D2, a fibre-selection
argument that uses a factor's **mixing** (its largest non-trivial |eigenvalue|) rather than its independence ratio. Nothing was written
or computed before these numbers.

| claim | prior TRUE (as stated) | prior of the outcome I expect | notes |
|---|---|---|---|
| D0 | 0.97 | TRUE | definitional; the risk is a measurability subtlety in the pullback |
| D1 | 0.90 | TRUE | C14.3 at `k = 5`; risk: a defect in the measurable transplant |
| D1-fac | 0.80 | TRUE | 59 needs the exact spectrum (Weil misses it); 23 rests on row 75's certificate |
| D1-43 | 0.05 | GAP named (0.93) | Hoffman `≥ 1/5` at every level; the relaxation that could close it is banned |
| D1-2 | 0.80 | TRUE | C14.2 (c) read as uniform in the residue size `q` |
| D1-3 | 0.97 | TRUE | one congruence |
| D2(a) | 0.10 (full scope, Lebesgue, everywhere) | partial TRUE (0.60) with an obstruction named (0.80) | the planner's cylinder lemma I expect to be false (0.90) |
| D2(b) | 0.10 | reduces to D2(a) (0.85) | via (a) |
| D3 | 0.85 | TRUE | via (a) |
| D4 | 0.90 | TRUE | both members are formulas |

### 1.3 The would-have-searched log (running)

| # | the move a search would have made | what was done instead |
|---|---|---|
| W1 | run FS-66's second-level moment relaxation at 43 (84 GPU-days) to certify the all-levels ratio `< 1/5` | not run (banned; machine-long); D1-43 named GAP with the level-one partial (§2.6) |
| W2 | search `Γ₄₃`'s level-two graph for an independent set above `0.2·43⁴` (to refute D1-43) | not run; recorded as the killing test of the partial |
| W3 | search weighted measures `ν` on the 43-adic circle for a better mixing constant | not run; replaced by the symmetrisation argument (§2.6): the uniform measure is optimal, so no `ν` exists |
| W4 | search `Γ₂₃` for two edge-free sets of size `≥ 106` each (to show 23 is non-thick in the strong, combinatorial sense) | not run; 23 is reported "not thick by the spectral criterion", and whether such a pair exists is left open |
| W5 | search for a measurable (e.g. periodic) five-colouring of `UD(ℝ²) × H(ℚ₉)` or `× Γ₂₃` that is no pullback (a D2 counterexample candidate) | not run; the obstruction is named at the step instead (§3.5) |
| W6 | zbMATH, two queries' worth, for the mixing selection (§3.2) in the words "Hedetniemi eigenvalue / expander / Borel / measurable" | run (a prior-art gate, not a witness search): 9 queries, nothing on point (§3.7) |

---

## Stage 2 — SAVED (D0, D1, the factor table, D1-3, D1-2, D1-43)

**Conventions (used from here on).** For a place `v` of a real field `F`, `Γ_v = Cay(G_v, T_v)` with `G_v = F_v²`,
`T_v = {x² + y² = 1}` (the brief's). At a split place (`i ∈ F_v`) the linear automorphism `(x, y) ↦ (x + iy, x − iy)` of `F_v²` carries
`T_v` onto the hyperbola `{(t, 1/t)}` (`2` is invertible in `F_v`, also at `p = 2`), so `Γ_v ≅ H(F_v)`, C14's coordinates; a window
colouring transports through it (Haar to a multiple of Haar). At a stable place `T_v ⊂ O_{L_v}` (norm-one elements are units), so
`Γ_v` is a disjoint union of copies of `Cay(O_{L_v}, T_v)` over the countable group `F_v²/O_{L_v}`. **Ratio** of `Γ_v` means C14's
"ratio `r` with error `η`" ((R1) window densities of independent sets `≤ r + η(n)`, `η → 0`, and (R2) averageable near-optimal
sets), which C14.2 establishes at every real, stable and split place; at a stable place it equals `sup_k α(G_k)/|G_k|` (C14.2 (b);
FS66-T8). **Formats:** (E) proper at every edge of `Γ_S` (the brief's definition); (N) C14′'s — proper on pairs inside a conull `Ω`;
(L) finite levels at finite places.

### 2.1 D0 — TRUE [hand]

*Statement (verbatim, §S):* "A measurable window five-colouring over `S = {∞₁}` is exactly a proper five-colouring of the unit-distance
graph of `ℝ²` with Lebesgue-measurable classes; for every finite `S` containing a real place, a measurable proper five-colouring of that
graph pulls back to a measurable window five-colouring over `S`. Hence no measurable window five-colouring over any `S` containing a
real place implies `χ_µ(ℝ²) ≥ 6`."

*Proof.* (i) `G_{∞₁} = F_{∞₁}² = ℝ²`, `T_{∞₁} = S¹`, Haar measure is Lebesgue measure up to a constant, so `Γ_{∞₁} = UD(ℝ²)` and the two
definitions coincide word for word. (ii) Let `c : ℝ² → [5]` be proper with Lebesgue-measurable classes and `∞ ∈ S` a real place;
put `W = c ∘ π_∞`. If `(g, g + τ)` is an edge of `Γ_S` then `|τ_∞| = 1`, so `W(g) = c(g_∞) ≠ c(g_∞ + τ_∞) = W(g + τ)`. Its classes are
`c^{-1}(j) × G_{S∖∞}`: write `c^{-1}(j) = B ∪ Z` with `B` Borel and `Z` inside a Borel null set `Z′`; then `c^{-1}(j) × G_{S∖∞}` is
`B × G_{S∖∞}` (Borel) union a subset of the null set `Z′ × G_{S∖∞}` (σ-finiteness), so it is measurable for the completed Haar
measure. The same map sends Borel colourings to Borel windows. (iii) Contrapositive of (ii): if `χ_µ(ℝ²) ≤ 5`, a proper colouring with
at most five measurable classes exists (pad with empty classes), and (ii) produces a window five-colouring over every `S ∋ ∞`. ∎
*Scope.* `χ_µ` is `[KechrisMarks2020]`'s (§3, p. 16: a µ-measurable colouring proper at every edge; §1.1 Q8). D0 says nothing in the
other direction: that a window over `S` gives a colouring of `ℝ²` is §3's question (D2).

### 2.2 D1 — TRUE [hand; C14.3 at `k = 5`]

*Statement (verbatim):* "For every finite set `S` of places of ℚ(√167) containing no real place, if every local graph `Γ_v`, `v ∈ S`, has
measurable independence ratio `< 1/5`, then no measurable window five-colouring over `S` exists."

*Proof.* By C14.3 and induction on `|S|` (C14.4's argument, with no tight factor), `Γ_S` has ratio `r = max_{v∈S} r_v` with an error
`η(n) → 0`; in particular (R1): every measurable independent set `Y` has `d_n(Y) ≤ r + η(n)` in the product windows `Φ_n`. A window
five-colouring's classes `S¹,…,S⁵` are measurable and independent (format E), so `1 = Σ_j d_n(S^j) ≤ 5(r + η(n))`, and `n → ∞` gives
`1 ≤ 5r < 1`. ∎ In format (N) replace `S^j` by `S^j ∩ Ω` (independent, same measure); in format (L) a place read at level `m` is the finite
graph `G_m`, whose ratio is at most the all-levels ratio. *What was re-walked:* C14.1 (the step differing from Zhang's finite lemma uses
only `g ≥ r − ε` on `Φ_n ∖ N[Y]`) and C14.3's observations (i), (ii) and the Fubini identity `avg_x d¹(B(x)) = avg_b d²(N₂[X*_b])`, line by
line; no defect found. C14's main count and propagation (the tight factor) are **not** used. *Measurability:* C14's reduction to σ-compact
subsets, unchanged.

### 2.3 D1-fac — TRUE [hand + tools + cert]

*Statement (verbatim):* "At ℚ(√167) the local graph has measurable independence ratio `< 1/5` at 23 (FS-66's all-levels certificate), at
every stable odd place `p ≥ 59` (the level-one Hoffman ratio, constant up the inert tower), at the ramified place 167 (Lemma P), and at every
odd split place (C14.2 (c))."

**The places** (`tools/crunch_j21_spectra.py`, output `data/m3/j21/spectra.out`; every finite place with residue size `≤ 200`):
2 ramifies in `F` with `F₂ = ℚ₂(√167) = ℚ₂(i)` (`−167 ≡ 1 mod 8`), split in `F(i)/F`; odd `p ≠ 167` inert in `F` give `q = p² ≡ 1 (4)`,
split; `p` split in `F` gives two places of residue `𝔽_p`, stable iff `p ≡ 3 (4)`; 167 ramifies, residue `𝔽₁₆₇`, stable. **The stable
places are the two above each of 23, 43, 59, 67, 71, 79, 83, 103, 131, 139, 151, 163, … and the one above 167; below 59 only 23 and 43**
(the tool asserts it).

| place | ratio bound (every level) | source |
|---|---|---|
| 23, 23′ | `≤ 97.984637/529 = 0.18523` | row 75's certificate on `B₁(23)` bounds `α(G_k)/23^{2k}` at every `k` [cert]; Hoffman `0.24908` would not suffice |
| 43, 43′ | **open** (level one `≤ 365/1849 = 0.19740`; Hoffman `0.21376` at every level) | D1-43, §2.6 |
| 59, 59′ | `≤ 0.19912` | exact level-one spectrum: `λ_min = −14.917577` on degree 60 (tools, float, error `< 10⁻¹¹`, margin to `1/5` `8.8·10⁻⁴`); Lemma P: every level's Hoffman ratio is `max(0.19912, 2/62)` |
| stable `p ≥ 67` | `≤ max(2√p/(p + 1 + 2√p), 2/(p+3)) < 1/5` | Weil (`8√p < p + 1` from `p = 62`), Lemma P |
| 167 (ramified) | `≤ 0.12615` | level-one spectrum (Weil `0.1338`); Lemma P covers ramified towers |
| every odd split place | `0` (error `≤ 3/(2n+4)`) | C14.2 (c) |

The planner's three floats are reproduced to five places (0.24908, 0.21376, 0.19912); the tool's plant (the split form `x² − y² = 1` at
stable places) fires on all six planes checked (`data/m3/j21/spectra-plant.out`, exit 1).

### 2.4 D1-3 — TRUE [hand]

*Statement (verbatim):* "At ℚ(√167) the place above 3 is split in `F(i)/F`, so FS-64's configuration (ii) contributes a factor of
measurable independence ratio 0."

*Proof.* `167 ≡ 2 (mod 3)` is a non-residue, so 3 is inert in `F` and `F_v = ℚ₉` (unramified quadratic over `ℚ₃`) with residue field
`𝔽₉`; `9 ≡ 1 (mod 4)`, so `−1` is a square in `𝔽₉` and, by Hensel (`p` odd), in `F_v`: `i ∈ F_v`, `F_v(i) = F_v × F_v`, split. C14.2 (c)
at `q = 9` gives ratio 0 with error `≤ 3/(2n+4)`. ∎ *What it teaches:* FS-64's "place that bounds nothing" is, in C14's terms, a split
place — the best possible factor for the count, and (§3) a **non-mixing** one (its compact Kloosterman subgraph has `λ* = 5/8`), so it is
exactly the kind of factor the count likes and the pullback theorem cannot remove.

### 2.5 D1-2 — TRUE [hand + tools]

*Statement (verbatim):* "Each dyadic place of ℚ(√167) (split in `F(i)/F`) has local graph of measurable independence ratio `< 1/5`."

There is one dyadic place: `F_v = ℚ₂(i)`, `O = ℤ₂[i]`, `π = 1 + i`, residue field `𝔽₂`. **C14.2 (c)'s proof uses the residue size only
through `1/(q − 1) ≤ 1`**, and every step is valid for `q = 2`: take `ψ` of conductor `O` (exists for every local field; characters of
`F_v²` are `x ↦ ψ(ξ·x)` by self-duality); (a) `a_k, b_k ≥ 0 ⟹ E_k = 1`; (b) exactly one negative, equal to `−1`:
`∫_{O^×} ψ(cε) dε = (0 − 1/q)/((q−1)/q) = −1/(q − 1) = −1`, and `≤ −2`: `0`; at most two such `k`; (c) both negative and unequal
`a < b < 0`: the substitution `ε ↦ ε(1 + π^{−b}x)`, `x ∈ O`, is a measure-preserving bijection of `O^×` (`v(π^{−b}x) ≥ 1`), moves the
`ξ₂`-term by `ξ₂π^{−k}ε^{−1}(−y/(1+y))`, of valuation `≥ b + (−b) = 0`, hence in `ker ψ`, and the `ξ₁`-term by `(ξ₁π^kε π^{−b})x`,
linear in `x` with coefficient of valuation `a − b < 0`, so the `x`-average vanishes — no use of `p` odd; (d) `a_k = b_k < 0` at most one
`k` (the difference moves by 2), `|E_k| ≤ 1`. Hence `(2n+1)ν̂_n(ξ) ≥ −1 − 2/(q−1) = −3`, Hoffman on the compact window graph gives ratio
`≤ 3/(2n+4) → 0`; (R2) with `I = ∅`. ∎ **Tools** (`tools/crunch_j21_dyadic_hyperbola.py`, `data/m3/j21/dyadic.out`): on
`π^{−n}O²/π^{10−n}O²` the minimum over all non-trivial characters is `(2n+1)λ_min = −2` exactly at `n = 1, 2, 3` (above the floor `−3`;
Hoffman `0.400, 0.286, 0.222 ≤ 3/(2n+4)`); the plant (levels not averaged) gives `−(2n+1)` and fails at `n = 2, 3`
(`data/m3/j21/dyadic-plant.out`, exit 1). *Consequence:* **FS86-CL1's qualifier "split places odd" can be dropped at ℚ(√47) and
ℚ(√167)** (their dyadic places are split there, and the four-colour count needs ratio `< 1/4`, which 0 is) — a correction owed to CL1's
scope, one mind (this record).

### 2.6 D1-43 — GAP at "the all-levels ratio of the 43-adic plane"; partial results [hand + cert]

*Statement (verbatim):* "The 43-adic local graph of ℚ(√167) has measurable independence ratio `< 1/5`." (or: open, with the missing step named)

**Named missing step:** a bound `sup_k α(G_k)/43^{2k} < 1/5` for the tower `G_k = UD(ℤ/43^k, 2)` (equivalently, by FS66-T8, the Haar
measure of every measurable independent set of the 43-adic plane `< 1/5`). What is known and why it does not reach:
- level one: `α(Γ₄₃) ≤ 365 < 369.8` (row 69, certificate), ratio `≤ 0.19740`; `α(G_k)/43^{2k}` is non-decreasing in `k`, so level one is
  a lower bound for the question, not an upper one;
- every level: Hoffman `max(0.21376, 2/46) = 0.21376 ≥ 1/5` (Lemma P; spectrum §2.3);
- **the fibre-share inequality alone gives exactly Hoffman.** For an independent set of `G_k` with fibre shares `φ ∈ [0,1]^{Γ₄₃}`,
  `⟨φ, A₁φ⟩ ≤ 2Σφ(1 − φ)` (row 75). With `N = 43²`, `s = Σφ/N`, `ρ = Σφ²/N ≤ s`, `d = 44`, `λ_min = −L`: `⟨φ, A₁φ⟩ ≥ N(d s² − L(ρ − s²))`,
  so `(d + L)s² ≤ 2s + (L − 2)ρ ≤ Ls` (`L > 2`), i.e. `s ≤ L/(d + L)` — Hoffman, with equality possible only when `ρ = s`. So any hand
  route must couple the inequality to level one's integrality (`φ ∈ {0,1}` forces an independent set, `≤ 365`) — which is what the
  second-level moment relaxation does; it is priced at 84 GPU-days at 43 and banned this week (W1).

**Partial results.** (a) D1 holds for every `S` whose 43-adic places are read at **level one** (format L): the factor is `Γ₄₃` itself,
ratio `≤ 0.19740`. (b) No reweighting of the circle helps a spectral route: for any probability `ν` on the level-one circle `μ₄₄`, the
average of its rotates `ν_u(t) = ν(ut)` is uniform and `ν̂_u(ξ) = ν̂(uξ)`, so `max_{ξ≠0} |ν̂_unif| ≤ max_{ξ≠0} |ν̂|` and likewise for
`min ν̂`: **the uniform measure is optimal for both Hoffman and mixing** (used again in §3). *Killing test of the partial:* an independent
set of `UD(ℤ/43², 2)` of size `> 0.2·43⁴ = 683,720.2` would show depth helps past `1/5` (W2; not searched).

**Stage 2 in one line:** D0, D1, D1-fac, D1-3, D1-2 TRUE; D1-43 GAP at the all-levels ratio of the 43-adic plane (level-one windows
excluded). So **over every `S` with no real place and no 43-adic place, no measurable window five-colouring of ℚ(√167)'s plane exists**
(formats E, N, L).

---

## Stage 3 — SAVED (D3, the pullback theorem at partial scope, D2(a) and D2(b) with their obstructions)

### 3.1 The slicing lemma and D3 — TRUE [hand]

**Lemma J21-SL.** Let `G` be a locally compact abelian group with Haar measure `λ`, `Γ = Cay(G, T)`, and `Y` a graph on a σ-finite measure
space `(Y, µ_Y)`. Let `W : G × G × Y → [k]` have classes measurable for the completion of `λ ⊗ λ ⊗ µ_Y` and be proper on
`Γ × Γ × Y` (at every edge). Then for `λ`-almost every `s ∈ G`, `W_s(x, y) = W(x, x + s, y)` is a proper `k`-colouring of `Γ × Y` with
classes measurable for the completion of `λ ⊗ µ_Y`; if `W` is Borel, every `s` works.

*Proof.* The shear `M(x, s) = (x, x + s)` is a group automorphism of `G × G` preserving `λ ⊗ λ` (Tonelli and translation invariance in the
second variable), so `M × id_Y` preserves the completed product measure and `C′_j = (M × id)^{-1}(W^{-1}(j))` is measurable. By Fubini for
completed product measures, for `λ`-a.e. `s` every section `{(x, y) : (x, s, y) ∈ C′_j}` is measurable (`k` null exceptional sets). For
every `s`, if `x′ − x ∈ T` and `y ∼ y′` then `(x, x+s, y)` and `(x′, x′+s, y′)` differ by `(x′ − x, x′ − x)` in the two `Γ` coordinates,
an edge of `Γ × Γ × Y`, so `W_s` is proper at every edge. ∎

**D3.** *Statement (verbatim):* "`χ_µ(Γ_{∞₁} × Γ_{∞₂}) = χ_µ(Γ_{∞₁})`" (or the named obstruction). Both real places of ℚ(√167) have local
graph `UD(ℝ²)`. "≤": pull back along the first projection (as D0 (ii)). "≥": J21-SL with `Y` a point. ∎ **TRUE**, for `χ_µ` (everywhere
proper, KM's) and for `χ_B`. *The brief's question* ("say whether Falconer's argument does [transfer]"): no transfer is needed — the
diagonal is null, but its translates foliate `ℝ⁴` and almost every translate carries a measurable slice; Falconer's `χ_µ ≥ 5` for the
product then follows from the equality. *More generally:* two places with isomorphic local graphs (the two real places; the two places
above a prime that splits in `F`) can be merged into one in every window question (J21-RED).

### 3.2 The mixing selection — a pullback theorem for one mixing compact factor [hand]

**Lemma (expander mixing, compact form).** `K` compact abelian, Haar probability `μ`, `ν` a probability measure on `K` with
`λ* = sup_{ξ ∈ K̂∖0} |ν̂(ξ)|`. If `P, Q ⊆ K` are measurable and no `b ∈ P`, `t ∈ supp ν` has `b + t ∈ Q`, then
`μ(P)μ(Q) ≤ λ* √(μ(P)(1−μ(P))μ(Q)(1−μ(Q)))`. *Proof.* `0 = ∫_P ∫ 1_Q(b + t) dν(t) dμ(b) = Σ_ξ ν̂(ξ)·1̂_Q(ξ)·conj(1̂_P(ξ))` (up to the sign
convention of `ν̂`); the `ξ = 0` term is `μ(P)μ(Q)`, the rest is at most `λ*‖1_P − μ(P)‖₂‖1_Q − μ(Q)‖₂` by Cauchy–Schwarz and Parseval. ∎
*Consequence:* two edge-free measurable sets cannot both have measure `> θ := λ*/(1 + λ*)` (for then `μ/(1 − μ) > λ*` for each).

**Theorem J21-MX.** Let `k ≥ 2`, `K`, `ν` as above with `T_K ⊇ supp ν` and `λ* < 1/(k − 1)` (equivalently `θ < 1/k`). Let `X` be a graph on
a standard Borel space and `W : X × K → [k]` Borel and proper on `X × Cay(K, T_K)` (`(x, b) ∼ (x′, b + t)` whenever `x ∼ x′`, `t ∈ T_K`).
Then `φ(x) = min{j : μ(W(x, ·)^{-1}(j)) > θ}` is a Borel proper `k`-colouring of `X`.
*Proof.* Each fibre partitions `K` into `k` Borel sets, one of measure `≥ 1/k > θ`, so `φ` is defined everywhere; it is Borel because
`x ↦ μ(W(x,·)^{-1}(j))` is Borel for Borel `W`. If `x ∼ x′` and `φ(x) = φ(x′) = j`, then `P = W(x,·)^{-1}(j)` and `Q = W(x′,·)^{-1}(j)`
are edge-free (an edge `b → b + t` would be an edge `(x, b) ∼ (x′, b + t)` of the product coloured `j` twice) and both of measure `> θ`,
contradicting the lemma. ∎

**Measurable form (format N′).** Say a colouring is *proper off a null vertex set* (N′) if some null `Z` has every edge with an endpoint
outside `Z` properly coloured (format E is `Z = ∅`; N′ implies C14′'s N). If `(X, µ_X)` is σ-finite and `W` is measurable for the completed
product and N′ with null set `N`, put `Z = {x : W(x,·) not μ-measurable, or N_x not μ-null}` (null, by Fubini–Tonelli) and
`φ(x) = min{j : μ^*(W(x,·)^{-1}(j)) > θ}` (outer measure; `Σ_j μ^* ≥ 1`, so defined everywhere). Then `φ` is measurable (off `Z` by Tonelli,
on `Z` because `Z` is null) and N′ with null set `Z`: for `x, x′ ∉ Z` the proof above applies to `P ∖ N_x`; for `x ∉ Z`, `x′ ∈ Z`, with
`j = φ(x)` and `P′ ⊆ P ∖ N_x` σ-compact of full measure, every point of `W(x′,·)^{-1}(j)` avoids `P′ + T_K` (the edge has its endpoint
`(x, b) ∉ N`), and `K ∖ (P′ + T_K)` has measure `< θ` by the lemma, so `μ^*(W(x′,·)^{-1}(j)) < θ` and `φ(x′) ≠ j`. **Edges with both ends
in `Z` are not controlled** — outer-measure mixing fails in general (under CH an independent set of a mixing compact Cayley graph can have
full outer measure, by a transfinite construction) — **this is the null-set step, named.**

*Prior art and the classical case.* For `K = ℤ/n` with `T_K = K ∖ 0` (the complete graph), `λ* = 1/(n − 1)`, and J21-MX is the classical
`χ(G × K_n) = min(χ(G), n)` (Burr–Erdős–Lovász 1976, as cited in `[Zhu2025]` §1) — the proof is the classical one with "a pair of equal
colours" replaced by "a class of measure above the mixing threshold". A spectral (mixing) form, finite or measurable, was not found (§3.7).
*In KM's terms* it answers Problem 4.23's `C_B(k+1)` for pairs `(G, Cay(K, T_K))` with the second factor `(k)`-mixing, every analytic `G`
(χ_B of such a factor exceeds `k`, since its measurable independence ratio is at most `θ < 1/k` — the lemma with `P = Q`).

### 3.3 Which places of ℚ(√167) are thick — J21-TH [tools + hand]

A place `v` is **5-thick** if its local graph contains a compact open subgroup `K` with a probability `ν` on `T_v ∩ K` of `λ* < 1/4`; then
any window factor at `v` can be removed by J21-MX with `X` = the product of the other factors (restrict `W` to `G_{S∖v} × K`: edges of
`Cay(K, T_v ∩ K)` are edges of `Γ_v`; in the categorical product every factor moves, so the other factors stay inside `X`).

| kind | compact subgraph | `λ*` (every non-trivial character) | thick? |
|---|---|---|---|
| stable, residue `𝔽_p` | `Cay(O_{L_v}, T_v)`, Haar | `max(level-one max\|λ\|/(p+1), 2/(p+1))` (Lemma P for the new characters) | 59: `0.24863` (margin `1.4·10⁻³`); `p ≥ 67`: Weil `2√p/(p+1) < 1/4`; 167: `0.15160` — **thick**. 23: `0.33170`; 43: `0.27187` — **not** |
| split, residue `𝔽_q` | `Cay(O², {(ε, ε^{−1}) : ε ∈ O^×})` (hyperbola coordinates), Haar | level one `max_c \|K(c)\|/(q−1)`; one coordinate of valuation `−1`: `1/(q−1)`; levels `m ≥ 2`: `≤ 2q^{1−m/2}/(q−1) ≤ 2/(q−1)` (Kloosterman sums mod `π^m`, odd residue characteristic, modulus `≤ 2q^{m/2}`: classical stationary phase); unequal negative valuations: `0` (C14.2 (c) case (c)) | `q ≥ 67` by Weil (`8√q < q − 1`), and 89, 97, 121, 137, 157, 169, … by the tool — **thick**. `q = 2` (`λ* = 1`: `ε ≡ 1 mod π`), 9 (`0.625`), 25 (`0.411`), 29 (`0.339`), 49 (`0.277`), 61 (`0.2557`) — **not** |

(`data/m3/j21/spectra.out`.) So **the non-thick places of ℚ(√167) are exactly twelve**: the dyadic place, the places above 3, 5, 7
(inert in `F`, split in `F(i)/F`), the two above 29 and the two above 61 (split), and the two above 23 and the two above 43 (stable). Every
other finite place is 5-thick. *Optimality for the twelve (for these compact subgraphs):* the norm-one torus acts on `T_v ∩ K` and on the
characters; averaging any `ν` over it gives the Haar measure with `|ν̂_unif(ξ)| ≤ max_u |ν̂(uξ)|`, so no reweighting beats Haar (§2.6 (b)).
Other compact subgroups were not examined; "not thick" below means "not removable by J21-MX as run".

### 3.4 The reduction — J21-RED [hand]

**Theorem.** Let `S` be a finite set of places of ℚ(√167) and `S_red` the set obtained by deleting every 5-thick place and keeping one place
of each isomorphic pair (the two real places; the two places above 23, 29, 43, 61). Then `S_red ⊆ {∞, 2, 3, 5, 7, 23, 29, 43, 61}`, and:
1. (Borel) a Borel window five-colouring over `S` exists iff one exists over `S_red`;
2. (measurable) a window five-colouring over `S` in format E gives one over `S_red` in format N′; one over `S_red` in format E (resp. N′)
   gives one over `S` in format E (resp. N′).

*Proof.* "⟸": pullback (D0 (ii); `Z × G` stays null). "⟹": delete thick places one at a time by J21-MX (format N′ is preserved, §3.2), and
merge isomorphic pairs by J21-SL (which preserves E and N′: the slice of a null set is null for a.e. `s`). ∎

**Corollaries at ℚ(√167).** (a) With no real place: if `S` contains no place above 43, D1 with D1-fac excludes every window five-colouring
over `S` directly (formats E, N, L). **Every finite-place window falsifier must read a place above 43**, and a Borel one exists iff one exists
over `S_red ⊆ {43, 2, 3, 5, 7, 23, 29, 61}` (one place per conjugate pair) containing 43. (b) With a real place and only thick finite places: a Borel window
five-colouring over `S` exists iff `χ_B(ℝ²) ≤ 5`; a measurable one (E) forces a measurable five-colouring of `ℝ²` proper off a null vertex
set, and `χ_µ(ℝ²) ≤ 5` gives one. (c) Everything else — `S_red` containing `∞` and one of 2, 3, 5, 7, 23, 29, 43, 61 — is open.

### 3.5 D2(a) and D2(b) — TRUE at partial scope; GAP at two named steps

*D2(a), verbatim:* "Let `A` be the unit-distance graph of `ℝ²` and `B` a product of finitely many of ℚ(√167)'s finite places' local graphs,
every factor of `B` of measurable independence ratio `< 1/5`. Then `A × B` has a measurable proper five-colouring iff `A` does." (or its
failure, at a named step)

- **⟸**: TRUE (pullback, D0 (ii)).
- **⟹, every factor of `B` thick**: TRUE in the Borel category (`χ_B(A × B) ≤ 5 ⟹ χ_B(A) ≤ 5`, J21-RED), and in the measurable category
  **up to the null-set step**: a measurable proper five-colouring of `A × B` gives a measurable five-colouring of `ℝ²` proper off a null vertex
  set (N′), not yet one proper at every edge (**GAP-1**, §3.2's last paragraph).
- **⟹, some factor of `B` not thick** (the D2-eligible non-thick factors are 2, 3, 5, 7, 23, 23′, 29, 29′, 61, 61′; 43 fails D2's ratio
  hypothesis as far as is known): **GAP-2**, at the step "choose a colour of the fibre `W(x, ·)` consistently across `x ∼ x′`". The mixing
  selection needs `λ* < 1/4` and these factors have `λ* ∈ [0.2557, 1]`; the count needs every factor `< 1/5` and `A`'s `m₁ ≥ 0.22936` is
  above it. No construction of a non-pullback measurable five-colouring was attempted (W5).

*D2(b)* ("the same with `A` the categorical product of the unit-distance graphs of `ℝ²` at the two real places"): **equivalent to D2(a)**
(J21-SL merges the two real factors in either direction), so the same verdict: TRUE for `B` all thick (Borel; measurable into N′), GAP-2
otherwise, GAP-1 for the everywhere-proper measurable form.

### 3.6 Obstructions to the planner's route and to any ratio-only route

**J21-NG1 — the cylinder lemma is false, at the first step.** The planner's step: "an independent set of `A′ × B` of relative density
`> β` is a.e. a cylinder `I × B`". Counterexample with `A′ = A = UD(ℝ²)` (vertex-transitive, so the failure is not the non-transitive step
the plan named): let `D₀` be the union of open discs of radius `1/2` centred at the triangular lattice of spacing 2 (1-avoiding: points of one
disc are `< 1` apart, of two discs `> 1` apart; density `π/(8√3) = 0.2267`); tile the plane by squares of side `L`, let `E` be the union of
the even squares and `E′` the union of the odd squares shrunk by 2 on each side, so `E′` misses the 1-neighbourhood of `E`. Take `J ⊆ G_B`
independent of positive Haar measure (at a stable place a pulled-back independent set of `Γ_p`; at a split place the ball `πO²`, since
`(y₁ − x₁)(y₂ − x₂) ∈ π²O` is never 1). Then `S = ((D₀ ∩ E) × G_B) ∪ (E′ × J)` is independent in `A × B`, its fibre over each point of `E′`
is `J` (neither null nor conull), and its density is `≈ ½(0.2267 + d(J))`, which exceeds `β` as soon as `d(J) > 2β − 0.2267` — possible
for every D2-eligible `B`, since `β ≤ 0.18523 < 0.2267` (take `J` near-optimal: at 23 a pulled-back independent set of 87 points of `Γ₂₃`,
`d(J) = 0.1645 > 0.1438`; at a split place `β = 0` and `J = πO²` already works). Zhang's Thm 1.8 (i) is about **maximum** independent sets; a five-colouring's classes need not be maximum because
`5m₁ > 1`.

**J21-NG2 — the ratio alone cannot carry D2 (a finite no-go of that format).** `[Zhu2025]` §3, Theorem 3.5 (verbatim): "Let F be a graph of
odd girth at least 7, with p vertices. Then for q ≥ (p − 1)/2 and n = 3q + 2, χ(K_n^{F[K_q]}) > n", applied there with "the 83-vertex graph
of odd girth 7 with χf(F) > 3.07 (hence p = 83), and let q = 41 and n = 3q + 2 = 125" (the circulant `Cay(ℤ₈₃, {±2, ±22, ±25, ±34})`, named in
the survey's §3 after Theorem 3.3). Put `B = F[K₄₁]` and `A = K₁₂₅^B`. `B` is a Cayley graph of the abelian group `ℤ₈₃ × ℤ₄₁` (connection set
`(S_F × ℤ₄₁) ∪ ({0} × ℤ₄₁∖0)`), so vertex-transitive, with `α(B)/|B| = 1/χ_f(B) = 1/(41·χ_f(F)) < 1/(41·3.07) < 1/125`; evaluation is a proper
125-colouring of `A × B`; and `χ(A) > 125`. So **"`B` abelian Cayley with independence ratio `< 1/k` ⟹ (`χ(A × B) ≤ k ⟹ χ(A) ≤ k`)" is false
at `k = 125`**; any proof of D2(a) must use more of `B` than its ratio (J21-MX uses mixing, which `F[K₄₁]` lacks: its blow-up blocks carry
large eigenvalues). At `k = 5` the ratio-only statement is not decided here (the `n = 4, 5` counterexamples use `Ω`-graphs whose fractional
chromatic numbers were not determined).

**J21-NG3 — at a split place the whole local graph is not mixing; only compact subgraphs can be.** In hyperbola coordinates let `U₁, U′₁`
(and `U₂, U′₂`) be the sets of `x ∈ F_v` of valuation `≤ −2` whose second `π`-adic digit is 0, resp. 1 (at `q > 2` use the leading digit and
valuation `≤ −1`, with a split of `𝔽_q^×` into two halves). Then `P = U₁ × U₂` and `Q = U′₁ × U′₂` have window densities `→ 1/4` (`q = 2`) and
no edge between them: for `p ∈ P`, `q′ ∈ Q` both coordinate differences have negative valuation, so their product is never 1. So J21-MX cannot
be run on the full split graph, and its reach at a split place is exactly the compact subgraph's `λ*` (§3.3).

### 3.7 Prior-art gate for J21-MX (time-boxed; W6)

zbMATH API, abstracts: `"Hedetniemi" & "eigenvalue"` (1 hit, a Laplacian/domination paper), `"Hedetniemi" & "expander"` (0),
`"categorical product" & "eigenvalue" & "chromatic"` (0), `"Borel chromatic" & "product"` (0), `"measurable chromatic" & "product"` (0),
`"Hedetniemi" & "measurable"` (0), `"Hedetniemi" & "Borel"` (0), `"Hedetniemi" & "random"` (7, none on point), `"exponential graph" &
"fractional chromatic"` (2: Tardif 2001, Shitov 2019). Nothing on point; the negatives measure these words (G21). **Prior-art debt:** the
finite mixing form is plausibly folklore (it is the Burr–Erdős–Lovász argument with a spectral pigeonhole); a search in the words
"pseudo-random factor / dense factor / Hedetniemi's conjecture holds when" and the Borel-combinatorics literature on products
(Conley–Kechris, Bernshteyn) is owed before any novelty is claimed.

**Stage 3 in one line:** D3 TRUE (slicing); D2(a), D2(b) TRUE when every finite factor is 5-thick (Borel; measurable into N′), GAP-1 (the
null-set step) and GAP-2 (non-thick factors: 2, 3, 5, 7, 23, 29, 61 up to conjugation) otherwise; the planner's cylinder route is refuted
(NG1) and ratio-only routes are refuted in general (NG2). **At the one-real-place slice this proves nothing new about `χ_µ(ℝ²)`**: it shows
that adding thick finite places to `{∞}` neither helps nor hinders a five-colour window, so over such `S` the question is exactly the
plane's (Borel) measurable chromatic number.
