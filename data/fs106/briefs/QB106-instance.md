*Instance sheet for job **FS106-QB**: the blind second mind on FS106-TQ. The brief is `data/fs106/briefs/B106-blind-second.md`; this sheet
fills in what the planner left to the owner. Written by the product owner, 2026-09-27.*

- **Your job id:** FS106-QB.
- **Your record:** `plans/FS106-QB-verification.md`.
- **Your working directory:** `data/fs106/fs106-qb/`.
- **Your tools:** `tools/fs106_qb_*.py`.
- **Budget:** about 250k tokens by the harness's count. Hand back by 350k.

## The claims assigned to you, in priority order

The first four are quoted verbatim from the deriver's list of theorems; their wording is the deriver's. The rest are in `data/fs106/claims.md`,
at the lines given. The definitions of `µ₆(ε)`, `µ₆⁰`, CP colourings, the normal form and the rest are in `data/fs106/claims.md` §0, §1 and §6.
The earlier result you may use as input is `LEDGER.md` row 130's statement: `χ_CP(ℝ²) = χ_m⁰(ℝ²)`. **G21 applies:** the flattering reading of
item 1 is "the problem became easy". Audit it at least as hard as any other item.

1. **TQ-EQ**, above all the direction from vanishing holes to a colouring: "`χ_m⁰(ℝ²) ≤ 6 ⟺ χ_CP ≤ 6 ⟺ µ₆⁰ = 1 ⟺ lim µ₆(ε) = 1 ⟺` periodic
   grid-square slack partial 6-colourings with vanishing holes `⟺` near-covering a.e.-proper colourings of every disc. No MR, no Voronov."
   The claim-list form is C-Q-EQ (l. 170): "`χ_m⁰(ℝ²) ≥ 7` if and only if `lim_{ε→0} µ₆(ε) < 1`."
2. **TQ-EPS2:** "every partial 6-colouring with `Leb ⊗ Leb`-null band pairs leaves lower density `≥ ε²/78` uncovered."
3. **TQ-SUP:** "`µ₆⁰ = lim µ₆(ε) = lim µ₆^tile(ε) = lim µ₆^per(ε)`: the tight and slack suprema coincide." Fix your own definitions of the tile
   and periodic versions, and say what they are.
4. **TQ-HIT:** "strips of width `2ε` at spacing `1/2` (density `4ε`) are effective holes meeting every unit circle and bicycle: a hitting-form
   argument proves at most `O(ε)`."
5. **C-Q-REM** (l. 162), both halves, the pointwise core as its own line.
6. **C-Q-COMP** (l. 167), (i) and (ii).
7. **C-Q-LOCAL** (l. 179).

## Fences, beyond the brief's list

Do not open any of these until your stage 3 is committed:
- `plans/FS106-TQ-derivation.md` and `data/fs106/fs106-tq/`;
- `plans/FS106-TS-derivation.md` and `data/fs106/fs106-ts/`;
- `plans/FS106-V-verification.md` and `plans/FS106-VB-verification.md`;
- `data/fs106/reports/`;
- `plans/FS106-close-inventory.md`.

`[SokolovVoronov2025]`, `[Voronov2023]` and `[Parts2020c]` in `~/source/library/` are open to you.

**Stage 4:** read the TQ record only, and record every divergence, of truth and of route.
