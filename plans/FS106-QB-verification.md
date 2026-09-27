# FS106-QB — blind second mind on FS106-TQ's quantitative route (FS-106, the regular half)

*Job FS106-QB (Coxeter, Opus 5.5), 2026-09-27. Brief: `data/fs106/briefs/B106-blind-second.md`; instance sheet:
`data/fs106/briefs/QB106-instance.md`; standing rules: `data/fs106/briefs/STANDING-RULES.md`. Blind: nothing fenced was opened before stage 3's
commit. Working directory `data/fs106/fs106-qb/`; tools `tools/fs106_qb_*.py`.*

## Theorems this phase proved

*(filled at stage 3; one line per theorem, grade, address)*

## Stage 1 — SAVED

### 1.1 Quotation check (standing rule 5)

| quotation (in the brief or the sheet) | source | result |
|---|---|---|
| TQ-EQ, TQ-EPS2, TQ-SUP, TQ-HIT, "quoted verbatim from the deriver's list of theorems" | FS106-TQ's record (fenced) | **unchecked until stage 4** (the source is fenced) |
| C-Q-EQ "(l. 170): "`χ_m⁰(ℝ²) ≥ 7` if and only if `lim_{ε→0} µ₆(ε) < 1`."" | `data/fs106/claims.md` l. 170 | matches |
| line numbers C-Q-REM l. 162, C-Q-COMP l. 167, C-Q-LOCAL l. 179 | `data/fs106/claims.md` | match |
| "The definitions of `µ₆(ε)`, `µ₆⁰`, CP colourings, the normal form and the rest are in `data/fs106/claims.md` §0, §1 and §6" | `data/fs106/claims.md` | **discrepancy: `µ₆⁰` is defined nowhere in `claims.md`** (grep: no occurrence). I fix my own definition (§1.2) and check TQ's at stage 4 |
| "`LEDGER.md` row 130's statement: `χ_CP(ℝ²) = χ_m⁰(ℝ²)`" | `LEDGER.md` l. 175 | matches (row 130 reads "`χ_CP(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ) ≤ χ_m(ℝ²) ≤ χ_B(ℝ²)`", no MR) |
| D-M "(FS-103's `data/fs103/claims.md` D-M, verbatim)" | `data/fs103/claims.md` l. 47–48 | matches (truncated before `χ_B`, no change of sense) |
| D-CP "(FS-103's D-CP (b), verbatim)" | `data/fs103/claims.md` l. 35–38 | matches, truncated; the dropped sentence matters here: **"No joint measurability is part of the definition."** (used in §2.5) |
| D-VPROP, D-VMC (`[Voronov2023]` Defs. 2.1, 2.3–2.4) | `library/pdf/arXiv-2304.10163-voronov.pdf`, text layer l. 215–274 | match |
| C-Q-STAB's `[SokolovVoronov2025]` §9 p. 26 quotation | `library/pdf/arXiv-2502.01958-maptype.pdf`, text layer l. 1038–1041 | matches. Context not quoted in the claim, relevant here: the same paragraph says "the area of regions S = S(ε), after excluding which we obtain a proper coloring with forbidden distance interval [1 − ε, 1 + ε], at ε → 0 has asymptotics S(ε) = Ω(ε2 )" (no proof printed) and cites "the 1/6997 part of the plane remains uncolored [8]" |
| `[Parts2020c]` "more than 99.985698% of the Euclidean plane" | `library/pdf/arXiv-2010.12668-parts-what-percent-plane-5-6-colored.pdf`, abstract | matches; the paper's own void fraction is "δ6 ≈ 0.000143017209" (§2.3) |
| I-D1, I-D2, I-D4 (from `plans/FS103-M-derivation.md`) | fenced for this job | unchecked (not used as inputs below except I-D4, which I re-derive in §2.6) |
| standing rule 0's Kooshi quotation | `CLAUDE.md` § Counter-priors (read from disk) | matches |

Also found: `BIBLIOGRAPHY.md` l. 171 lists `[Parts2020c]` as "not held"; it is held at `library/pdf/arXiv-2010.12668-parts-what-percent-plane-5-6-colored.pdf`
(file dated 2026-09-27 00:15). A correction owed.

### 1.2 My definitions (fixed before any derivation)

- `σ` normalised arc length on `S¹`; `σ_t` its dilate to the circle of radius `t`; `H¹` arc length. Upper density `d̄(A) = limsup_{R→∞} |A ∩ B(0,R)|/|B(0,R)|`,
  lower density `d̲` with `liminf`.
- **Tight family:** disjoint measurable `C₁, …, C₆` with `(Leb ⊗ σ){(x, w) : x ∈ C_j, x + w ∈ C_j} = 0` for each `j`.
  **`µ₆⁰`** `:= sup d̄(C₁ ∪ ⋯ ∪ C₆)` over tight families.
- **`ε`-slack family:** D-MU's condition, `(Leb ⊗ Leb){(x, y) ∈ C_j² : 1 − ε ≤ |x − y| ≤ 1 + ε} = 0`; `µ₆(ε)` as D-MU.
- **`µ₆^per(ε)`:** the same supremum over `ε`-slack families invariant under `Lℤ²` for some `L > 0` (the "periodic grid-square" families; the density
  exists).
- **`µ₆^tile(ε)`:** the same supremum over `ε`-slack families each of whose classes is, up to a null set, a union of cells `hk + [0, h)²`, `k ∈ ℤ²`, for some
  `h > 0` (pixelated; V-2.1's tiles specialised to a square grid). `µ₆^{tile,per}` both at once.
- **NC ("near-covering a.e.-proper colourings of every disc"):** for every `R > 0` and `δ > 0` there is a tight family inside `B(0, R)` covering at least
  `(1 − δ)|B(0, R)|`. (The strong reading, `δ = 0`, is treated too.)
- **Hitting-form argument (TQ-HIT):** an argument whose only use of the uncovered set `H` is that `H` meets every unit circle `T₁(u)` and every bicycle
  `T₁(u) ∪ T₁(v)`, `1 < |u − v| < 2`, in a set of positive length (equivalently, for strips, that `H` has positive measure in every `η`-neighbourhood of each).

### 1.3 Expectations, registered before any written derivation (after one mental pass; nothing fenced seen)

| claim | my expectation | probability |
|---|---|---|
| TQ-EQ / C-Q-EQ | TRUE, no MR, no Voronov; the hard direction (vanishing holes ⟹ colouring) by weak-* compactness, the circle's Fourier decay making the unit-pair form continuous, then a support selection | 0.85 |
| TQ-EPS2 | TRUE **only conditionally** on a Voronov-type non-existence (V-1.3's band form on `U₃`), since without one a band-proper full 6-colouring would leave nothing uncovered; constant improvable | 0.8 that it is conditional; 0.8 that it holds given V-1.3 |
| TQ-SUP | TRUE under my definitions; `µ₆^per(ε) = µ₆(ε)` at every `ε`, not only in the limit | 0.8 |
| TQ-HIT | TRUE as a limitation statement; the density constant is not optimal | 0.9 |
| C-Q-REM (i), core, (ii) | TRUE; `η = 1/10` suffices for `ε ≤ 1/2`; (ii) needs a jointly measurable version (D-CP has none built in) | 0.85 |
| C-Q-COMP (i) | TRUE (through row 130 for `χ_CP`) | 0.85 |
| C-Q-COMP (ii) | attained: TRUE; `µ₆(ε) < 1`: TRUE only conditional on V-1.1, and equivalent to it | 0.75 |
| C-Q-LOCAL | TRUE for `δ >` Parts's void fraction (shrink the tiles); the equality case needs a fact about the tiling not checked; the consequence TRUE in a sharpened form: on partial colourings a trichromatic-point lemma is as strong as C-Q-STAB itself | 0.7 |

**G21 audit, registered now:** the flattering reading of TQ-EQ is "the problem became easy". My expectation: the equivalence is a compactness
restatement that moves no value — it trades "no measurable a.e.-proper 6-colouring" for "a bound on `µ₆(ε)` uniform in `ε`", and every bound held
(TQ-EPS2's, S–V's `Ω(ε²)`) tends to 0 with `ε`.

### 1.4 Controls

1. **The constants of C-Q-REM (i)** in exact-plus-interval arithmetic (`tools/fs106_qb_rem_constants.py`), with planted faults that must fail for
   their own reason: `η = 0.12` (above the threshold); one common scale `ρ` for both points (no admissible geometry); `ε = 0.9` (the arc bound breaks).
2. **Known positives for the equivalence at other `k`:** at `k = 7` the hexagonal colouring has slack, so `lim µ₇(ε) = 1` and `χ_m⁰ ≤ 7`, consistent;
   at `k = 4`, `χ_m⁰ ≥ χ(ℝ²) ≥ 5` (I-EASY) forces `lim µ₄(ε) < 1`, consistent with Croft's `δ₄ ≈ 0.0825` (`[Parts2020c]` §2.1) — a statement the
   equivalence must not contradict.
3. **The analytic step's necessity:** the compactness step must use the decay of `σ̂`; with the edge measure replaced by a non-Rajchman one it must not
   go through (row 130's "false without it"), and I check my proof uses the decay exactly once.
4. **TQ-EPS2's direction:** the fill argument must use "six" only through V-1.3 — with seven colours (the hexagonal tiling, no holes, slack) it must
   produce no contradiction.

### "Would have searched here" log

- (none yet)
