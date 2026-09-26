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
