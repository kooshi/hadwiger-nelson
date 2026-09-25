# FS-91 stage S1, job J08 — six at the exposed fields (character colourings only)

*Crunch job J08 (de Bruijn, Opus 5.5, 2026-09-25), under `data/crunch-2026-09-25/briefs/J08-M1-six-at-exposed-fields.md` and
`STANDING-RULES.md`. Plan: `plans/FS91-character-local-global.md` §S "J08", §M.1 (read in full except the fenced §P.basis). Data:
`data/fs91/j08/`. Tools: `tools/crunch_j08_*.py`. **Characters only, never `χ`**: every statement below is about band characters
(`Θ_k`, `χ_char`); at `k ≥ 4` the absence of a character colouring says nothing about `χ` (G71).*

## Stage 1 — SAVED (the quotation check, the fence log, C0)

### Q. The quotation check (standing rule 5)

| # | the brief's quotation | source | result |
|---|---|---|---|
| Q1–Q6 | SIX-a … SIX-f | plan §S "J08" | **verbatim, all six** (whitespace-normalised substring match, script in the stage-1 commit message's session). Note: in the plan only SIX-a and SIX-e are inside quotation marks; SIX-b, -c, -d, -f are the same words unquoted — no change of meaning |
| Q7 | "`κ(Γ_q) = max_c min_{t ∈ V_c} |t|/q`, with `χ_char(Γ_q) = ⌈1/κ(Γ_q)⌉`" | plan §M.1 | **verbatim** for `κ`; the `⌈1/κ⌉` clause is §M.1's general "`χ_char = ⌈1/κ⌉`" instantiated — agrees |
| Q8 | "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `CLAUDE.md` Frontier item 23 | **verbatim** |
| Q9 | rows 50, 53, 68–71, 75 as summarised in the brief | `LEDGER.md` | **agree**, with one attribution slip: "K(√7)'s usable primes 83 and ≥ 103" is row 68's sentence; row 53 gives only "K(√7) (83)" and de Grey's "131, 479". 97/529 = 0.1834 > 1/6 (row 75) agrees |
| Q10 | the owner's news: `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`; J01-7 verified | `plans/FS91-S0V2-SWm-second-reading.md` lines 42, 56, 197 | **agrees** |

### F. Fence log (§P.basis)

**A leak, logged.** My first `grep -n "basis"` over the plan printed, besides §P.basis's line number, **line 583 of the plan's
"Theorems this phase proved" table, whose row J03-3 states the planner's hand answer at `q = 23`** (bands 6, 7, 8), and a fragment of
line 565 (§X). §P.basis itself (lines 508–512) was not read. I therefore **know the planner's claimed answer at 23**. Consequences: (i)
my 23 result is produced by an exact tool from the derived law, never by hand, so the planner's claim cannot enter it; (ii) C0's number
for 23 below is contaminated and is recorded with the uncontaminated heuristic beside it; (iii) the plan's fence covers §P.basis only,
yet J03-3 in the theorems table carries its content — **a fence defect for the owner** (J11's fence: J11 is fenced from the plan? — the
brief says J11 is fenced from my record, data, tools and brief; whether J11 may read the plan's theorems table is the owner's call).

### C0. Registered probabilities (before any tool ran)

| id | statement | p | basis |
|---|---|---|---|
| C0-a | SIX-a true as stated | 0.97 | re-derived in my head before stage 2 (two lines: a line `Tr(ax) = t` meets the norm-`c` circle iff `X² − tX + c` is irreducible or a square) |
| C0-23 | a band six-character exists at level one of Γ₂₃ | 0.10 (contaminated); uncontaminated heuristic **0.77** | heuristic: for `c` a non-square, band 6 needs `t² − 4c` a square at `t = 1, 2, 3` (three coin flips), 11 values of `c`: `1 − (7/8)^11`. The file `data/fplane/periodic-below-71.json` also carries an untrusted solver refusal of seven colours on the one-direction circulant at 23, which (see stage 3) bounds characters too |
| C0-43 | a band six-character exists at level one of Γ₄₃ | 0.12 | band 6 needs `t = 1..7` (seven flips), 21 values: `1 − (127/128)^21 ≈ 0.15`, shaded for the same untrusted circulant refusal at 43 |
| C0-167 | `χ_char(ℚ(√167)²)` given CLG_6, CLG_7 | 6: 0.10; 7: 0.30; 8: 0.50; ≥ 9: 0.10 | 23 and 43 dominate; 59, 67, … refuse six by certificate (rows 68–69) |

