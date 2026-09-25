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
