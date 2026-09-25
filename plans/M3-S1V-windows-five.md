# M3 — J22, the blind verifier of J21's windows-at-five claims (FS-64 at five colours over ℚ(√167))

*Job J22 of the 2026-09-25 crunch; de Bruijn, Opus 5.5. Brief: `data/crunch-2026-09-25/briefs/J22-M3-windows-five-verifier.md` with
`STANDING-RULES.md`. Blind: J21's record `plans/M3-S1D-windows-five.md`, `data/m3/j21/`, `tools/crunch_j21_*.py`, J21's brief and
report, `plans/M3-exotic-colourings.md`, `plans/M3-close-inventory.md`, commits whose subject begins "J21:", and
`plans/CRUNCH-2026-09-25-INDEX.md` are fenced until B1 (and B2, if any) are committed. The owner added three J21 claims (MX, TH, RED),
quoted from the fenced record's lines 29–37, to verify in B1 after the fixed list's deciding claim, and one number to settle exactly
(the place above 59).*

## Theorems this phase proved

*(filled per stage; one line each, grade and address)*

## Stage 1 — SAVED

### 1.1 The quotation check (standing rule 5)

| # | quotation in the brief or the owner's message | source | result |
|---|---|---|---|
| Q1 | the Q2 definitions (`G_v = F_v²`, `T_v`, `Γ_S`, `ι_S`, measurable window `k`-colouring), "J21's and J22's briefs quote these, and FS86-Cx-C14 and FS86-CL1 verbatim" | the definitions' own source is the M3 plan (fenced); compared with `plans/FS86-C-Coxeter.md` round 2 step 5 "Setting" and FS86-Cx-C14 (`plans/FS86-derivation.md` §9) | **not verbatim to C14, and equivalent to it.** C14's setting takes `G_v = O_v` at odd stable places and the hyperbola `F_v × F_v` at split ones; the brief takes `G_v = F_v²` everywhere. At a stable place `T_v ⊂ O_v²` (a unit vector has no pole when `−1` is a non-square), so `Cay(F_v², T_v)` is a disjoint union of translates of `Cay(O_v², T_v)`; at a split place `(x, y) ↦ (x + iy, x − iy)` carries `x² + y² = 1` onto `uw = 1` (a unimodular map at odd `p`). Colourability and ratios agree. The brief quotes neither C14's nor CL1's statement in full; its fragments are checked below. |
| Q2 | CL1 "is graded "[hand, one mind (the close planner)]"" | `plans/FS86-derivation.md` §9, FS86-CL1 | **truncated**: the source reads "[hand, one mind (the close planner), from C14.1–C14.3 (two derivations) and the all-levels ratios; external input AmbrusEtAl2023 at real places]". The quotation closes the bracket early and drops the inputs; no widening. |
| Q3 | "C14.2 (c) at `p = 2` is **not checked**" | FS86-CL1 | verbatim ✓ |
| Q4 | "`[AmbrusEtAl2024]`'s `m₁(ℝ²) ≤ 0.2470` and Croft's `m₁ ≥ 0.22936` (external, second-hand: carry them as such)" | `BIBLIOGRAPHY.md` rows `[AmbrusEtAl2024]`/`[Ambrus2023]` (l. 187) and `[AmbrusEtAl2023]` (l. 258); FS86-Cx-C14 | **key discrepancy, same paper**: C14 and CL1 cite `[AmbrusEtAl2023]` Thm 1 for `≤ 0.2470`; both keys name arXiv:2207.14179. The `[AmbrusEtAl2023]` row says the PDF is held and §2, §5 read; the `[AmbrusEtAl2024]` row says "not held … not read — second-hand". Content consistent; Croft's bound is quoted in CL1 as "restated in `[AmbrusEtAl2024]`'s row" ✓. I carry `m₁ ≤ 0.2470` as external, computer-assisted, unchecked here. |
| Q5 | the fixed list D0–D4 "quoted verbatim from `plans/M3-exotic-colourings.md` §S" | fenced | **not checkable** (the source is fenced); taken as the statements to verify. |
| Q6 | the owner's J21-MX, J21-TH, J21-RED, "quoted verbatim from `plans/M3-S1D-windows-five.md` lines 29–37" | fenced | **not checkable**; taken as the statements to verify. |
| Q7 | the owner's news: J01-7 verified (band characters of `R_F` torsion plus archimedean, `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`); M1's CLG verified blind | no source named | not checked; not used below. |
| Q8 | "`plans/FS86-derivation.md` Lemma P and C9", "`LEDGER.md` rows 69, 75, 92, 94, 95, 96", "`plans/FS66-derivation.md` T8", "`[Zhang2012]` Thm 1.8 and Prop. 1.7 (held)", "`[KechrisMarks2020]` §4.6–§4.7 (path)" | the files | all exist ✓ (FS86-LP, FS86-Cx-C9; rows present; FS66-T8 at l. 345; Zhang's PDF held, read in full per its row; the Kechris–Marks PDF present). |
| Q9 | D1-fac's attributions: "FS-66's all-levels certificate" at 23, "Lemma P" at 167, "C14.2 (c)" at odd split places | row 75; FS86-LP; FS86-Cx-C14's proof | ✓ each names an existing result: row 75 gives `U(23) = 97.984637` against `529/5`; FS86-LP covers ramified towers; C14.2 (c) is the split-place ratio-0 lemma. |
| Q10 | D4: "C9's colouring `⌊4θ⌋` over ℚ(√11) … over `{∞, 7}`" | FS86-Cx-C9 | consistent: C9 reads "`θ = (2x + 3y)/7` read at the stable prime above 7, plus an archimedean linear term `ℓ` with `0 < max ℓ ≤ 1/28`". **Scope note:** ℚ(√11) has two real places and 7 splits in it (`(11/7) = (4/7) = 1`), so "`{∞, 7}`" means one real place and one place above 7. |
| Q11 | D1-2: "Each dyadic place of ℚ(√167) (split in `F(i)/F`)" | arithmetic | ✓ with a note: 2 is ramified in ℚ(√167) (`167 ≡ 3 mod 4`), so there is **one** dyadic place; its completion is `ℚ₂(√167) = ℚ₂(i)` because `−167 ≡ 1 (mod 8)` is a 2-adic square, so `i ∈ F_v` and the place splits in `F(i)/F`; residue field `𝔽₂`. |
| Q12 | D1-3: "FS-64's configuration (ii)" | `plans/STUB-adelic-window-colouring.md` l. 75 | configuration (ii) is "the barrier prime, 3" ✓. **Fence note:** I read this stub's lines naming the configurations. It is a stub, not a crunch record; its last edit is `2ac6a338` (FS-89's close, 14:08), before the crunch queue (`d2e4dcca`, 14:46) and before J06 opened M3 (`22bd1d12`, 15:50), so it carries no M3 route. Logged as a deliberate read, not a slip. |

**Fence log:** no fenced file opened. `git log --oneline` output (which the harness also shows) listed "J21:" subjects; no `git show` of any.

### 1.2 The deciding claim

**D2(a)** decides M3's five-colour question in the window format: with D0 (any `S` with a real place contains the real plane's
measurable question) and D1 (no real place: a count), D2(a)–(b) and D3 would make "a measurable window five-colouring over `S`" equivalent
to `χ_µ(ℝ²) ≤ 5` for every `S` whose finite factors have ratio `< 1/5`. It is verified first; then the owner's three J21 claims; then the
rest.

### 1.3 C0 — a probability per claim before derivation

*Honesty note:* written after reading the verified inputs (FS86 §9 with Coxeter's C14 proof, rows 69/75/92/94–96, FS66-T8), during which
I re-walked C14.1 and C14.3 and thought through D3's diagonal; so the priors for D1, D3 and D1-2 are not clean.

| claim | TRUE | GAP | FALSE | why |
|---|---|---|---|---|
| **D2(a)** (deciding) | 0.10 | 0.85 | 0.05 | "ratio `< 1/5`" is a counting hypothesis; a selection (a colouring of `A` read off `A × B`) usually needs a spectral one; a FALSE needs `χ_µ(ℝ²) ≥ 6`, out of reach |
| D2(b) | 0.10 | 0.85 | 0.05 | same as D2(a), plus D3 |
| D0 | 0.95 | 0.03 | 0.02 | definitional plus a pullback |
| D1 | 0.85 | 0.12 | 0.03 | C14.1/C14.3 at five colours |
| D1-fac | 0.75 | 0.20 | 0.05 | the exact margin at 59 is the risk |
| D1-43 | 0.15 | 0.80 | 0.05 | the level-one certificate `α(Γ₄₃) ≤ 365` is not an all-levels bound (FS-69 open) |
| D1-2 | 0.80 | 0.15 | 0.05 | C14.2 (c) at `q = 2` not checked in FS-86 |
| D1-3 | 0.90 | 0.08 | 0.02 | arithmetic plus C14.2 (c) at `q = 9` |
| D3 | 0.85 | 0.12 | 0.03 | a shifted diagonal is a copy of the factor |
| D4 | 0.90 | 0.08 | 0.02 | C9 plus the hexagonal colouring |
| J21-MX | 0.85 | 0.12 | 0.03 | the standard mixing selection, measurable form |
| J21-TH | 0.55 | 0.15 | 0.30 | Weil leaves 59 to an exact spectrum; the non-thick side at 61 is close to Weil's bound |
| J21-RED | 0.65 | 0.15 | 0.20 | rests on TH's thick side and on MX |

### 1.4 "Would have searched here" log

*(one line per move; filled as they come)*
