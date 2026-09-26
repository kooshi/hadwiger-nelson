# Poros — J39: the wanted poster for a five-colouring of ℚ(√167)'s plane

*Crunch job J39, 2026-09-25. Advisor session (Poros, `~/source/poros/CLAUDE.md`), one of three wanted posters (J37 at ℚ(√47), J38 at
ℚ(√59), this one at ℚ(√167)). Brief: `data/crunch-2026-09-25/briefs/J37-39-poros-wanted-posters.md` (J39 block), with the owner's
launch-message updates 1–3. Standing rules: `data/crunch-2026-09-25/briefs/STANDING-RULES.md`. Opus 5.5. No children; no finite-witness
search; this record is the only file edited besides the report.*

## Stage 1 — SAVED: the expectation, written before reading the siblings or assembling anything

*Written from `CLAUDE.md` alone (items 12, 15, 17, 22, 25; G48, G56, G59, G64, G76), before opening the sibling posters, the J36 record,
the M3 records or FS-59's stub, so that the later reading is read against something.*

**The target.** The conjecture (G48) predicts χ(ℚ(√167)²) ≥ 6 (six by the main clause if the wall at six falls at 23 or 43, seven by the
bold form); proven is 4 (rows 79, 82). The counterexample wanted is a five-colouring `c : ℚ(√167)² → [5]` of the unit-distance graph,
necessarily local at no finite place, since every finite residue target refuses five (23 at every level, row 75; 43 and 59 onward by
the spectrum; the wall at 2 is broken, 167 ≡ 7 (mod 8), so no dyadic target; 3, 7, 11, 19, 31 unusable).

**E1 — the expectation that matters most, and why the 167 poster should differ from 47's and 59's in kind.** A five-colouring of the
*real* plane, restricted to ℚ(√167)², is such a counterexample. So the poster's class contains every five-colouring of ℝ², and closing
the poster (proving χ(ℚ(√167)²) ≥ 6) proves χ(ℝ²) ≥ 6: **rung D itself**. At four colours over ℚ(√47) and ℚ(√59) the real place is
excluded for free (χ(ℝ²) ≥ 5, and measurably by the independence density 0.2470 < 1/4, `[AmbrusEtAl2023]`), which is what lets a
spectral argument force the counterexample onto finite primes. At five the real place is not excluded: the density `m₁(ℝ²)` lies in
[0.2293, 0.2470], above 1/5, and χ_m(ℝ²) ≥ 6 is open. **So I expect a gap, not a theorem, and I expect the gap to contain the archimedean
class — colourings whose invariant measures live on the real place's characters — which is Hadwiger–Nelson's upper-bound question at five
restricted to one field.** Prediction: whatever shared identity J38 found (MR, Kronecker selection) survives at five only in its
finite-place half, and breaks exactly at the step that uses the real place's density being below 1/k.

**E2 — the constraints I expect on the poster:** (i) local at no finite place (row 75 plus the spectra; theorems); (ii) not a character
colouring, i.e. no single character of the unit-vector ring puts every unit vector in the band [1/5, 4/5] (row 96; hand, two
derivations); (iii) some M3 statement about measurable window colourings over finitely many places at five colours (J21; grade unknown to
me); (iv) J36 F7: the T-C(A) spectral method silent at five. I expect (ii) and (iii) to overlap (a character colouring is a one-place
window), and I expect nothing that constrains a non-measurable or archimedean-supported colouring.

**E3 — the example invariant.** No five-colouring of ℚ(√167)² is known to exist, so "every colouring we can prove exists" is empty here.
I expect the flip to come from five-colourings of *other* field planes (every one we own is local at 11 or 19, or at an inert dyadic
place): the invariant "every five-colouring of a field plane is local at a finite place, or at the real place". I expect the poster's
constraint (i) to be its shadow, and I expect the example-invariant route to be *no easier* here, because at five its archimedean case is
again rung D.

**E4 — owner item 2.** I expect "the posters are not all the same" to be the finding at five: 47 and 59 end in one lemma about finite
primes; 167 ends in the real place.

**Falsifier of E1:** a record in the day's work that excludes measurable (or all) five-colourings supported on the real place's
characters over ℚ(√167) — e.g. an M3 statement that uses something beyond density, such as the arithmetic of ℚ(√167) itself, to refuse
the archimedean class.

## Stage 2 — SAVED: quotation check, inventory, one exact check

### 2.1 Quotation check (standing rule 5)

| quoted in the brief or launch message | source | verdict |
|---|---|---|
| "The conjecture predicts at least six against a proven four; this is its widest gap" | `CLAUDE.md` Paths forward, FS-59 row: "the conjecture's widest gap — predicted ≥ 6 against a proven 4" | agrees |
| "row 75 (five is refused at 23 at every level of the tower)" | `LEDGER.md` row 75 (`U = 97.984637` (23) against 529/5); `CLAUDE.md` item 17 | agrees; note it covers 7, 11, 19, 23 and **not 43** |
| "row 96 (no character five-colouring)" | row 96: "ℚ(√167)'s has no character five-colouring (`Θ₅ = ∅`)" | agrees; row 101 says more ("character colourings of ℚ(√167)'s … planes need exactly 8", given CLG) |
| "§3.2–§3.4 (mixing selection; at most nine places)" | `plans/M3-S1D-windows-five.md` §3.2–§3.4; J21-RED "`S_red ⊆ {∞, 2, 3, 5, 7, 23, 29, 43, 61}`" | agrees |
| owner 2: "the real place's independence ratio is at least 0.2293 > 1/5" | J36 F7: "`m₁(ℝ²) ≥ 0.2293` (Croft's construction), which exceeds 1/5, 1/6 and 1/7" | agrees |
| owner 2: J38's MR(F) and "given isolation of the pullbacks" | J38 §3.5 T-J38-2 (iii): "MR(F) ∧ T-B1 ⟹ `F(R) ≠ 0`" | agrees |
| J36 F7: "FS-66's certificate at 23 (`97/529 = 0.1834 < 1/5`)" | row 75: the all-levels certificate reads `U = 97.984637`, ratio `0.18523` (J21-D1fac); 97 is the **level-one** integer bound `α(Γ₂₃) ≤ 97` | **a small slip in J36 F7**: the level-one bound quoted as the all-levels ratio. Conclusion (`< 1/5`) unaffected. Correction owed |

### 2.2 Evidence inventory (read against Stage 1)

| item | expected (Stage 1) | surprised? |
|---|---|---|
| J38 poster §3, §4.3, §4.7 | MR at four colours; a prediction about 167 | no — §4.7 predicts "its skeleton breaks at step (2)", my E1 |
| J37 poster §3.1–§3.3 | four-colour poster, Kronecker selection | **yes, one line**: J2's "fractional local–global principle `ι(F²) = max(m₁(ℝ²), max_stable r_v)`" — the real place already appears as a *factor* in a four-colour identity; at five it is the only factor that matters |
| J36 F2–F5, F7, §4.1–§4.4 | F7 = my E1 | no on F7; **yes on F4/F5**: R-U and SP are colouring-free, so they survive at five verbatim — I had expected the shared identities to break, and the *colouring-free* half does not |
| J45 (`plans/FS84-SI-D-derivation.md`) theorem list, §4.2 | SI at four colours | SI-1/SI-3's constants are the tetrahedron's `−1/3, −4/3`; the argument uses only a regular simplex, so at `k` colours they are `−1/(k−1)`, `−k/(k−1)` [checked by hand, §3.3 (a)] |
| M3-S1D theorem list, §3.2–§3.6 | a window no-go at five | **yes**: J21-D0 already states my E1 ("a 'no' over every `S` containing a real place implies `χ_µ(ℝ²) ≥ 6`"); **J21-MX is k-generic and removes whole infinite products of places**, which is the tool that makes the five-colour reduction work (§3.3) |
| M3 §R3.4–§R3.5, §IQ.2, §R4.L | "landed in part" | IQ.2 names the measurable Hedetniemi question and `χ_µ(ℝ²) ≥ 6` as its `S = {∞₁}` slice — but only for **window** colourings; it does not claim windows are all colourings (§3.3 shows that, modulo MR, they are) |
| FS-59 stub §00, §0; FS-64 stub banners; FS-96 stub | the five-colour aim "untouched" | FS-96 carries GAP-1, GAP-2 and 43; its list of non-thick places includes the **split** places 2, 3, 5, 7, 29, 61, which the measure route removes (§3.3 (c)) |
| `LEDGER.md` rows 75, 96, 98–115 (heads) | rows 75, 96 | rows 114–115 (FS-67: products with a gap-free or mixing factor; the `E_k(G)` criterion) bear on the product lemma the 167 poster needs (§3.3 (d)) |
| `~/source/poros/.claude/skills/*` | — | **not read in full** (budget); the identity file `~/source/poros/CLAUDE.md` was read in full |

### 2.3 One exact check (in ban: seconds, a derived claim's input)

`tools/crunch_j39_thick.py` → `data/crunch-2026-09-25/j39/thick.out`: the mixing constant `λ*` of the stable local planes at level one is
`0.331695` (23), `0.271869` (43), `0.248626` (59), reproducing J21-TH; so **23 is 4-thick but not 5-thick** (`1/4 < λ* < 1/3`, margin
`1.6·10⁻³` below `1/3`); level two at 23's new characters reach `0.083332 ≤ 2/(p+1)` (Lemma P, sharp). Plants: `ξ = 0` fires; the first
"wrong circle" plant (`x² + y² = 2`) **could not fire** — 2 is a square mod 23, so it is a scaled copy with the same spectrum — and was
replaced by the split hyperbola `x² − y² = 1`, which fires. (Used in §3.3 (e), T-J39-4.)

### 2.4 Would-have-searched-here log (Stages 1–2)

- Would have asked a solver whether `UD(ℤ/1849, 2)` (43 at level two) is five-colourable, to close the hole in row (i). Instead: recorded the
  hole (§3.1 P1) and pointed to FS-69's derivation route.

## Stage 3 — SAVED: the poster, its composition, and what survives at five colours

*Notation (J45, J37, J38): `F = ℚ(√167)`, `L = F(i)`, `U` the unit vectors, `R = ℤ[U]`, `X₅(F)` the proper five-colourings of `Cay(R, U)`;
`T`, `A` the torsion and archimedean characters of `R̂`, `E_S = T + A + Fin_S`, `E = ⋃_S E_S`; `σ_μ` the trace spectral measure of the
**simplex** embedding (five colours: the vertices of a regular 4-simplex, `⟨e_i, e_j⟩ = −1/4`). `G_v = Cay(O_{L_w}, S¹(O_{L_w}))`, the
full-depth local plane at a stable place `v` (compact); `UD(ℝ²)` the Euclidean unit-distance graph. **CP colouring** of a locally compact
abelian Cayley graph: a translation-invariant random colouring, continuous in probability, proper almost surely at each fixed edge.
**Thick** (J21-TH): the place's compact local piece has mixing constant `λ* < 1/(k−1)`.*

### 3.1 The poster — theorems (one row per constraint on a five-colouring `c` of ℚ(√167)²)

| # | the constraint, verbatim | scope | grade | address | instrument |
|---|---|---|---|---|---|
| P1 | "The residue ceiling does not drop up the tower at 7, 11, 19 or 23" with "`97.984637` (23) against 529/5"; at 43 "`α(Γ₄₃)/1849 ≤ 0.1974`" (level one) and "the fibre-share inequality alone gives exactly Hoffman's `0.21376`, so it cannot close 43 at depth"; 59 "`0.199119854095` exactly"; "every stable `p ≥ 67` [Weil + Lemma P]"; "the ramified 167 `≤ 0.12615`"; the wall is broken (`167 ≡ 7 (mod 8)`, every dyadic place split) | every stable place at every level **except 43 at level ≥ 2**; so `c` is a residue colouring at no place and no depth, **43 at depth excepted** | [cert] at 23 (FS-66's checker); [cert] at 43 level one (row 69); [tools exact] at 59; [hand, Weil] above | rows 75, 69, 110; `plans/M3-S1D-windows-five.md` §2.3, §2.6 | residue maps; FS-66's all-levels certificates; Weil |
| P2 | "ℚ(√167)'s has no character five-colouring (`Θ₅ = ∅`)"; and, given CLG, "character colourings of ℚ(√167)'s … planes need exactly 8" | every `θ ∈ R̂`, `x ↦ ⌊kθ(x)⌋` | [hand, compositions of row 95; two derivations]; row 101 given CLG | rows 96, 101 | band rigidity (rows 95, 98), then a Weil count |
| P3 | "no measurable window five-colouring reads a finite set of places with no real place and none above 43"; "a Borel window five-colouring over any `S` exists iff one exists over `S_red ⊆ {∞, 2, 3, 5, 7, 23, 29, 43, 61}`, and with a real place and only thick finite places the question is exactly `χ_B(ℝ²) ≤ 5`" | measurable/Borel windows over finite `S` | [hand + tools exact + cert, two derivations (J21; J22 blind)] | row 110; `plans/M3-S1D-windows-five.md` §3.4 | J21-D1's count; J21-MX's mixing selection |
| P4 | "If `G` is amenable: `Γ` is `k`-colourable ⟺ `Col_k(Γ)` carries a `G`-invariant Borel probability measure" (stated at four colours; the proof is `k`-free) | the existence of `c` is that of an `R ⋊ U`-invariant random five-colouring | [hand, two derivations (S1b-i; S1V-5)] | J37 P6 | Følner averaging |
| P5 | **T-J39-1** (§3.2): a five-colouring yields a CP five-colouring of `Y = UD(ℝ²) × G₂₃ × G₄₃` or an SP witness over ℚ(√167); conversely the first yields a five-colouring | every `c` | [hand, one mind; a composition of J45 SI (at `k = 5`), R-U, J21-MX (random form), J21-SL] | §3.2 | the colouring-free skeleton of J36–J38 |

*Context, not constraints:* `χ(ℚ(√167)²) ≥ 4` (rows 79, 82); the plane is triangle-free (`√3 ∉ F`, G57) and has no Moser spindle; every
lattice over `F` has rank ≤ 4 (FS-59 §0).

### 3.2 T-J39-1 and T-J39-3, with the proof [hand, one mind; a composition]

> **T-J39-3 (every `k`, every totally real `F`).** Let `N_k(F)` be the finite set of stable places of `F` that are not `k`-thick, and
> `Y_{F,k} = UD(ℝ²) × ∏_{v ∈ N_k(F)} G_v`. If `F²` is `k`-colourable, then **either** (A) `Y_{F,k}` carries a CP `k`-colouring, **or** (B)
> some `U`-invariant finite positive measure `τ` on `R̂` has `τ(E) = 0` and `∫ Re χ(1) dτ(χ) < 0` (an SP witness, so MR(F) fails, J45
> SP-oi). Conversely (A) ⟹ `F²` is `k`-colourable. **So, given MR(F): `F²` is `k`-colourable iff `Y_{F,k}` has a CP `k`-colouring.**
>
> **T-J39-1 (the instance).** At `F = ℚ(√167)`, `k = 5`: `N₅(F)` is the four places above 23 and 43 (J21-TH; §2.3), and merging each
> conjugate pair (J21-SL) gives `Y = UD(ℝ²) × G₂₃ × G₄₃`. **The split places 2, 3, 5, 7, 29, 61 do not appear.**

*Proof.*
1. (⟸) Embed `R` diagonally into one real place and one place above each prime of `N_k(F)`. A unit vector goes to a unit vector at every
   factor, so `ι(R)` spans a copy of `Cay(R, U)` in `Y`. Restrict a CP colouring of `Y` to a random coset `g + ι(R)`. It is proper almost
   surely at each of countably many edges, hence at all of them. Colour each `R`-coset of `F²` this way.
2. (⟹) `X_k(F) ≠ ∅` is compact and `R ⋊ U`-invariant, and `R ⋊ U` is amenable, so it carries an invariant `μ` (P4). A rotation about 0
   fixes `c(0)`, so `σ_μ` is `U`-invariant (J45 SP-Cor's first lines).
3. **SI at `k` colours.** J45-SI-1 and SI-3 use only the regular simplex: for probability vectors `p, q`,
   `⟨Σp_i e_i, Σq_j e_j⟩ = (k/(k−1))Σp_i q_i − 1/(k−1) ≥ −1/(k−1)`, with equality iff `p` and `q` have disjoint supports. So
   `∫_{R̂∖E_S} Re χ(u) dσ_μ = −(k/(k−1)) P(c¹(0) = c²(u)) ≤ 0`, and equality at every `u` makes `x ↦ min supp P(c(x) = · | 𝒜_S)` an
   `𝒜_S`-measurable, equivariant proper `k`-colouring (SI-4). Nothing else in J45 §2.2 uses four.
4. Take `S = ∅`. By R-U (colouring-free), `σ_μ(E ∖ (T + A)) = 0`, so `∫_{R̂∖E_∅} Re χ(u) dσ_μ = ∫_{R̂∖E} Re χ(u) dσ_μ`, and by the
   `U`-invariance of `σ_μ` this does not depend on `u` (J45 A⁺ remark (ii)). If it is negative, `τ = σ_μ|_{R̂∖E}` is (B). If it is 0,
   step 3 gives an equivariant proper `k`-colouring `c′` with spectrum in `T + A` (J45-N2).
5. **From `c′` to a CP colouring of the completion.** `T + A` is the dual image of `G_∅ = (L ⊗ ℝ) × R̂_prof` (J45-N1), so the Koopman
   representation on `L²(𝒜_∅)` extends continuously to `G_∅`, and by Mackey's point realisation `c′` extends to a stationary random colouring
   of `Cay(G_∅, cl ι(U))`, continuous in probability. It is proper a.s. at each edge: for `t = lim u_n`,
   `P(C(g) = C(g + t)) = lim P(C(0) = C(u_n)) = 0`. **Here `R̂_prof = ∏_{stable w} O_{L_w}`, and `cl ι(U)` is the full product of the local
   circles** — weak approximation for the norm-one torus at every finite set of places (J21-RED's input), hence in the product topology.
6. **Delete every `k`-thick stable place at once (J21-MX, random form).** Put `K = ∏_{v stable, thick} O_{L_w}` and `ν = ⊗ Haar(S¹_v)`. A
   non-trivial character of `K` has finitely many non-trivial components, so `|ν̂| ≤ max_v λ*_v`, and the maximum over thick places exists
   (Weil makes all but finitely many small); at `k = 5` over ℚ(√167) it is `0.24863` (59) `< 1/4`. J21-MX's proof runs fibrewise: a.s.,
   for each edge `x ∼ x′` of the other factors, the two fibre classes of colour `j` are edge-free up to a null set, which is all the mixing
   lemma uses. Choose the threshold `θ′` uniformly in `(λ*/(1+λ*), 1/k)`, once, independent of everything. Then
   `φ(x) = min{j : Haar{b : C(x, b) = j} > θ′}` is a stationary random proper `k`-colouring. It is continuous in probability, because the
   fibre measures are (`E|m_j(x) − m_j(x′)| ≤ P(C(x, ·) ≠ C(x′, ·))`) and `θ′` a.s. misses their values.
7. **Merge isomorphic factors** (J21-SL, random form: for every `s`, `(x, y) ↦ C(x, x + s, y)` keeps every edge). The two real places merge
   to one `UD(ℝ²)`, and so does each conjugate pair of stable places. This leaves `Y_{F,k}`. ∎

*Inputs:* J45 SI-1, SI-3, SI-4 (at `k`), N1, N2, RU, SP-oi (one derivation; blind check J46 running); P4; J21-MX, J21-SL (two derivations);
J21-TH and §2.3 (the thick table); weak approximation for `R¹_{L/F}𝔾_m`. *New here:* steps 3 (the simplex constant), 5 (CP extension) and
6 (MX for an infinite product of places, in random form, with a random threshold). *Not used:* FS-66, Zhang, `[AmbrusEtAl2023]`.
*Not claimed:* anything at a complex place of a non-totally-real `F`.

### 3.3 Composition

**(a) What the poster adds up to — one statement, conditional.**

> *If ℚ(√167)'s plane is five-colourable, then MR(ℚ(√167)) fails (SP has a witness), or `Y = UD(ℝ²) × G₂₃ × G₄₃` carries a CP
> five-colouring. That colouring is not a pullback from `G₂₃` (P1, row 75) nor, at level one, from `G₄₃`; it is not a character colouring
> (P2), and no window over the finite places alone gives it (P3).*

Grade: [hand, one mind] for the dichotomy (T-J39-1); the exclusions [cert] and [hand, two derivations]. It does not decide
`χ(ℚ(√167)²)`.

**(b) The gap, named — four pieces.**
- **G-SP (branch (B))**: J37's continuous layer, verbatim. It is colouring-free, so it is the same class at four and five colours. No
  control anywhere (J37 §3.3 (c)).
- **G-∞ (branch (A), pulled back from the real place)**: CP five-colourings of `UD(ℝ²)`. **This piece is non-empty iff `χ_CP(ℝ²) ≤ 5`.**
  `χ_CP(ℝ²) ≥ χ(ℝ²) ≥ 5` (de Bruijn–Erdős on restrictions), and `≥ 5` also by density (a CP class is a stationary 1-avoiding set with
  continuous autocorrelation, so `m₁ ≤ 0.2470 < 1/4` applies, as in T-C(A)). **Emptying G-∞ is at least as hard as the measurable
  chromatic number of the plane being ≥ 6 (open since Falconer's `≥ 5`, 1981 [external])**, and it follows from χ(ℝ²) ≥ 6.
- **G-43 (branch (A), pulled back from 43 at depth)**: a five-colourable level of `UD(O/43^m, 2)`, `m ≥ 2`. That would be a residue
  five-colouring, so it falsifies the conjecture's level-one `L` but not its all-levels form. Excluded by G66's reading ("the tower never
  rises", [reading]); FS-69 carries the certificate (`B₁(43) < 369.8`, priced machine-long).
- **G-H (branch (A), a Hedetniemi failure)**: CP five-colourings of `Y` when no factor has one. This is D2(a)'s GAP-2 in CP form: "every
  CP five-colouring of `UD(ℝ²) × G₂₃ × G₄₃` yields one of `UD(ℝ²)`". Call it **PL(23, 43)**.

**(c) Controls — is each piece known to be non-empty somewhere?**
- G-∞: **yes at seven colours, for every field** — the hexagonal seven-colouring pulled back along a real place (J36 F7; J21-D4's
  inhabitant `sevenBrick`). At five and six it is the measurable Hadwiger–Nelson question.
- G-43: none; the tower never drops where certified (7, 11, 19, 23; row 75).
- G-H: a *mixed* CP colouring exists in a related field — C9 over ℚ(√11) is a Borel window four-colouring over `{∞, 7}`, a.e. a pullback
  from neither factor (J21-D4) — but there `Γ₇` is itself four-colourable, so it is not a Hedetniemi failure. Finite Hedetniemi failures
  exist from four colours up in the abstract class (`[Tardif2023]`, `[Zhu2025]`, per G55). None is known among local unit-distance graphs.
- G-SP: none (J37 §3.3 (c)).

**(d) Redundancy, and where constraints almost meet.**
- **Logically, every theorem row lives inside branch (A)**: P1 ⊂ P3, since a residue colouring is a window. P2's characters lie in
  `T + A` (row 98), so they are windows over `∞` and finitely many stable levels. **No row of the poster touches G-SP**, as at ℚ(√47).
- **J1 — P3's reduction and T-J39-1 almost meet.** For existence, T-J39-1 shrinks J21-RED's nine places to three (`∞, 23, 43`), modulo
  G-SP. The split places 2, 3, 5, 7, 29, 61 drop out through rotation averaging and R-U. A deterministic window over split places stays
  open **as a window** (FS-96). As a route to a five-colouring, it is either G-SP or already a CP colouring of `Y`.
- **J2 — P1 at 43 and G-H.** If FS-69 gives 43's all-levels ratio `< 1/5`, then both non-thick factors refuse five by count, and PL(23, 43)
  is exactly D2(a) with its ratio hypothesis met.
- **J3 — G-H and FS-67 (rows 114–115).** PL(23, 43) is FS-67's product question with `G = G₂₃ × G₄₃` (not five-colourable) and
  `H = UD(ℝ²)`. That is Hedetniemi at five for `G`, whose finite-graph criterion is row 114's "`χ(E_k(G)) ≤ k`". Row 115's mixing
  hypothesis fails here: `λ* = 0.3317` (23) and `0.2719` (43) are both `≥ 1/4`.

**(e) T-J39-4 — at four colours ℚ(√167)'s whole remainder is MR [hand, one mind; a composition].** At `k = 4` every stable place of
ℚ(√167) is 4-thick: `λ* = 0.33170 < 1/3` at 23 (§2.3, margin `1.6·10⁻³`), `0.27187` at 43, `0.24863` at 59, Weil beyond, `0.15160` at 167.
So `Y_{F,4} = UD(ℝ²)`, which has no CP four-colouring (`m₁ ≤ 0.2470 < 1/4`, `[AmbrusEtAl2023]`). T-J39-3 then gives:
> **T-J39-4.** "A four-colouring of ℚ(√167)'s plane yields an SP witness over ℚ(√167); so MR(ℚ(√167)) ⟹ `χ(ℚ(√167)²) ≥ 5`."

This is ℚ(√47)'s SP-Cor at the field FS-59 names, reached by mixing instead of T-C(A)'s count. It uses neither FS-66 nor Zhang, and it
checks J36 F7's "probably includes ℚ(√167) (not checked)". **So the lower bound five at ℚ(√167) waits on the same lemma as ℚ(√47).**

**(f) T-J39-5 — given MR and the product lemma, the conjecture at ℚ(√167) is the plane's measurable chromatic number [hand, one mind; a
composition].**
> **T-J39-5.** "(i) Unconditionally: `χ(ℚ(√167)²) ≥ 6 ⟹ χ_CP(ℝ²) ≥ 6`. (ii) If MR(ℚ(√167)) holds, 43's all-levels ratio is `< 1/5`, and
> PL(23, 43) holds, then `χ_CP(ℝ²) ≥ 6 ⟹ χ(ℚ(√167)²) ≥ 6`."

*Proof.* (i) Pull a CP five-colouring of `UD(ℝ²)` back to `Y` and apply T-J39-1's (⟸). (ii) If ℚ(√167)² were five-colourable, MR would put
us in branch (A), and PL would give a CP five-colouring of `UD(ℝ²)`. ∎

*Reading of T-J39-5 [reading].* Modulo MR, one product lemma and 43, **the conjecture's widest gap is not arithmetic**. ℚ(√167) is
five-colourable exactly when the plane is, in the continuous-in-probability sense. The same holds for every totally real field whose
non-5-thick stable places refuse five at every level and satisfy the product lemma. At five colours all such fields stand or fall
together. *Killing test:* a totally real field whose stable places all refuse five robustly, with `χ(F²) ≤ 5` shown by a colouring that
no real place and no finite place explains. That colouring would be in G-SP, the one piece with no control.

### 3.4 Owner item 2 — which shared identities survive at five colours over ℚ(√167)

| identity | at four colours (ℚ(√47), type (B)) | at five over ℚ(√167) | why |
|---|---|---|---|
| **MR(F)** / SP (J36 F5, J45 SP-oi/if) | the colouring-free remainder at both | **survives verbatim; the same statement** | colouring-free. T-J39-4 makes it the missing lemma for `χ ≥ 5` at ℚ(√167) too |
| **SI** (J45 SI-1 to SI-4) | `−1/3`, tetrahedron | **survives**, `−1/(k−1) = −1/4`, 4-simplex | uses only a regular simplex (§3.2 step 3) |
| **R-U** (J45-RU) | removes `E_S ∖ (T + A)` | **survives verbatim**; removes the split places | colouring-free |
| rotation averaging (J36 F4) | safe at ℚ(√47); needs T-B1 at type (B) | **safe for existence** | Pull is empty at five; if G-43 fires, a five-colouring exists anyway |
| **EI-2** (J36 §4.1) | = the finite-place factor | **survives** (`k`-free); lands on `Y`, does not finish | its output is branch (A) |
| **Kronecker selection** (J37 J1) | finishes the pure-point layer at ℚ(√47) | **survives as a reduction** (threshold `1/(k−1) = 1/4`); lands in branch (A); does not finish | a window on `T + A` is no contradiction at five |
| **finite-place product principle** (J36 F6) | refuses: every factor `< 1/4` | **the ratio half is vacuous over every real field**; the mixing half survives as J21-MX | `m₁(ℝ²) ≥ 0.2293 > 1/5`; the real place is slack at five, so its pullback clause needs a tight maximum that does not exist |
| **the last step** — T-C(A) at `S = ∅` / Theorem C | a count (ℚ(√47)); a pullback from the tight place (type (B)) | **breaks**: replaced by "`Y` has no CP five-colouring", which contains `χ_CP(ℝ²) ≥ 6` | the only step that reads the real place's ratio against `1/k` |
| Iso / T-B1, DP (J38) | type (B) only | vacuous (no tight place, Pull empty) | — |

**The answer to Kooshi's suspicion.** The three posters share a skeleton, and at ℚ(√167) the skeleton reaches further than J38 predicted.
Every step up to the last one is colouring-free or colour-count-free (MR/SP, SI, R-U, averaging, Følner, mixing selection). Together they
reduce each question to one product of local graphs **that includes the real place**, `Y_{F,k}`: T-J39-3, a local–global principle with
`∞` among the places, conditional on MR. The posters differ only in what decides `Y_{F,k}`:
- at ℚ(√47), a count;
- at type (B), a pullback theorem at the tight place;
- at ℚ(√167), nothing we own. There `Y` contains the plane's measurable five-colour question.

**So the posters are the same up to their last line, and at five colours the last line is rung D in measurable form.** T-J38-3 ("MR(F) ∧
Iso(F) ⟹ every four-colouring of `F²` is a pullback from a tight place") is the four-colour instance of T-J39-3 plus a theorem deciding
`Y_{F,4}`.

### 3.5 Would-have-searched-here log (Stage 3)

- Would have searched for a CP (or periodic) five-colouring of `Γ₂₃ × Γ₄₃ × (a finite model of the plane)`, to test PL(23, 43). Instead:
  named PL and its FS-67 form (§3.3 (d) J3).
