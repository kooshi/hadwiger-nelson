# FS106-TQ — the quantitative route: is Hadwiger–Nelson's measurable form the stability of Voronov's theorem?

*Job FS106-TQ (de Bruijn, Opus 5.5), wave 2 of FS-106, opened 2026-09-27. Brief: `data/fs106/briefs/TQ106-quantitative.md` (the owner's
re-brief block first) with `data/fs106/briefs/STANDING-RULES.md`. Not blind to the print or to wave 1; blind to FS106-TS until stage 4 is
committed. Claims are `data/fs106/claims.md` §6; definitions §0 (D-MU, D-NF, D-SLACK, D-CP, D-M). Checks: `tools/fs106_tq_checks.py`, output
`data/fs106/fs106-tq/checks.out`, plants `data/fs106/fs106-tq/plants.out`.*

## Theorems this phase proved

*(filled stage by stage; grades per `CLAUDE.md` § Notation; "one mind" = this job, sighted unless said.)*

## Would-have-searched-here log (standing rule 3)

- Stage 1: none. The controls are exact geometry plus one float grid check of a hand inequality (`hex_pairs`, 425 pairs), which checks a
  derived bound and hunts for nothing.

## Stage 1 — SAVED: quotation check and controls

### 1.1 Quotation check (standing rule 5), each against its source on disk

| quoted in | the quotation | source | result |
|---|---|---|---|
| brief, claims C-Q-STAB | S–V §9: "if any upper bound µ(C1 ∪ · · · ∪ C6 ) ≤ µ∗6 < 1 on the fraction of the plane that can be correctly colored in 6 colors with forbidden interval [1− ε, 1 + ε], ε > 0 were established, it would follow definitively that χmap (R2 ) = 7." | `[SokolovVoronov2025]` p. 26 (text layer of `library/pdf/arXiv-2502.01958-maptype.pdf`) | **verbatim** (line breaks aside). The next sentence, not quoted anywhere: "Unfortunately, we only know that there exists a 6-coloring in which the 1/6997 part of the plane remains uncolored [8]." |
| brief | `[Parts2020c]`: "more than 99.985698 %" six-coloured; "95.99 %" five-coloured | abstract, `arXiv-2010.12668` p. 1: "a tiling of more than 99.985698% of the Euclidean plane with six colors … a tiling of more than 95.99% of the plane with five colors" | verbatim in substance; the re-brief's "95.99 % … five-coloured" drops "more than" (harmless) |
| claims C-Q-STAB | the advisor's wording "for some δ > 0 and every ε > 0, no colouring of the radius-3 disc by six band-proper colours plus a free seventh colour of density at most δ exists" | FS106-A | **not on disk in that form.** The advisor's record (`plans/POROS-2026-09-26-fs106-regular-half.md` l. 188) holds only "six band-proper colours plus a free seventh of density ≤ δ"; the long form is the planner's transcription of a message. Used below as the claim list's wording, attributed to it |
| claims I-D1, I-D4 | D1 and D4 | `plans/FS103-M-derivation.md` §3.1 | verbatim; I-D4's "…" drops D4's definition of `supp S_j`, as the advisor noted (stage 4 of its record) |
| claims I-M1 | "`χ_CP(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ)`" | `LEDGER.md` row 130 | verbatim (a substring of "`χ_CP(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ) ≤ χ_m(ℝ²) ≤ χ_B(ℝ²)`") |
| claims V-1.1, V-1.3 | Voronov Thms 1.1, 1.3 | `[Voronov2023]` pp. 2–3 | verbatim |
| re-brief | wave 1's state: V-1.1–1.3 TRUE after local repairs (two minds, one blind); C-AE-SLACK TRUE; C-CS-2 TRUE | `plans/FS106-V-verification.md` l. 112–113, `plans/FS106-VB-verification.md` l. 147, 241 | matches: C-CS-2 TRUE at V and VB (two minds, one blind); C-AE-SLACK TRUE at V only (**one mind**, "given V-1.3") |

**Reading of D-MU used throughout.** `µ₆(ε)` is non-increasing in `ε` (a family null on a wider band is null on a narrower one), so
`lim_{ε→0} µ₆(ε)` exists and equals `sup_ε µ₆(ε)`. S–V's "an upper bound … µ∗6 < 1 … ε > 0" with `µ∗₆` independent of `ε` is therefore exactly
`lim_{ε→0} µ₆(ε) < 1`; an `ε`-dependent bound `µ₆(ε) < 1` could not give their conclusion (§3 shows it always holds).

### 1.2 The controls, before any argument

| control | what the argument must do there | exact facts (`tools/fs106_tq_checks.py`) |
|---|---|---|
| **C1, the tight hexagonal 7-colouring**: regular hexagons of side `1/2` (diameter exactly 1), coloured by the index-7 sublattice | it is a.e.-proper and has **no** slack in form (a): each open hexagon holds a positive-measure set of pairs at distances in `[1 − ε, 1)`, near opposite vertices. So REM (i) must hold there only because those pairs are not kept, and C-Q-EQ must not turn it into a six-colouring | `hex_tight`: diameter `= 1` exactly, same-colour gap `(√21 − 2)/2 = 1.2913 > 1`. `hex_pairs` (hand bound, float check at `ε = 0.05`, 425 pairs): every pair of one hexagon at distance `≥ 1 − ε` has a point within `4ε/3` of a vertex. `hex_nonkept`: such a point `x` has `B(x, 2ε) ⊇ B(v, 2ε/3)`, of which the hexagon covers `1/3`, so the outside fraction is `≥ 2/27 > 1/20`: **not kept** at `η = 1/20` |
| **C2, the zigzag colouring** (`plans/FS103-M-derivation.md` §2.4): the slack hexagonal 7-colouring (side `2/5`) with every edge in the annulus `j ≤ |z| < j + 1` replaced by a zigzag of amplitude `ε₀/4`, wavelength `1/j` | proper at **every** edge, Borel, but its `L¹` modulus degrades at infinity. A uniform-in-space form of REM (ii) must **fail** there; the statement must be at the origin of a stationary colouring (the claim's form) or on one bounded region at a time (my route, §3) | at scale `ε ≫ 1/j` a point of a zigzag band has both colours at density near `1/2` in `B(x, ε/2)`, so it is not kept; the bands fill a fixed fraction `≍ ε₀·(perimeter/area)` of every far annulus. So `sup_z |{x ∈ Q + z : x not kept at ε}| ≥ c₀ > 0` for every `ε`, while for each fixed box it tends to 0 |
| **C3, `[Parts2020c]`'s six-tiling** | any stability constant `δ` must satisfy `δ ≤ δ₆`; any claim that six colours cover density `≥ 1 − δ₆ − o(1)` must be consistent with it | `parts`: `δ₆ = 1/6992.1655504123 = 1.430172·10⁻⁴`, coverage `0.9998569828 > 0.99985698`. His straight-sided void formula at his published optimum gives `ρ = 6985.23`, against his Table 1 "straight, wavy" `6985.378399`: consistent to 0.002 %, the curving increment being the rest |

**Plants** (`data/fs106/fs106-tq/plants.out`): each of the eight checks has a planted fault, and each fires alone, for its named reason. One
plant could not fire at first. `hex_pairs` tested a `2ε` tolerance, but the true bound is `4ε/3`, so a plant at `ε` also passed. That is a control
that cannot fail. I sharpened the check to the hand bound and planted `0.4ε`, below the axis pair `a = b = ε/2`; it now fires, on 154 pairs.

## Stage 1 — SAVED
