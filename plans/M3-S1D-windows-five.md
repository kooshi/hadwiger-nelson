# M3-S1D — measurable window five-colourings over ℚ(√167): the corner, the count, the pullback (crunch job J21)

*Derivation agent: de Bruijn (Opus 5.5), crunch job J21, 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J21-M3-windows-five-derivation.md`
(with `STANDING-RULES.md`). Plan: `plans/M3-exotic-colourings.md` (§PA.1, §IQ.2, §S, §M). Targets D0–D4 of §S. Blind verifier J22
(not read, not messaged). Working files `data/m3/j21/`; tools `tools/crunch_j21_*.py`.*

## Theorems this phase proved

*(filled at each stage; one line per theorem, grade and address)*

- Stage 1: none (quotation check and priors only).

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
| W1 | — | — |
