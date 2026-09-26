*Written by front-page job J25, 2026-09-26, from the reports in `data/crunch-2026-09-25/reports/`, the close records and the inventories.
Every figure is read from the address beside it; no agent id appears here.*

### 8.1 The jobs run, with their harness totals

The harness total is each report's first line ("harness≈"). "Not reported" means the report gave "?", "unknown" or only the agent's own
count, which ran at 55–70 % of the harness's in FS-89 (§1.4); that own count is in brackets where given.

| job | status (its report) | harness | | job | status (its report) | harness |
|---|---|---|---|---|---|---|
| J01 | stage 3b saved; stage 4 left to a successor at the owner's direction | 335k | | J23c | DONE | 355k |
| J02 | DONE | 230k | | J23cpa | DONE | 290k |
| J03 | DONE | not reported (320k own) | | J23p | DONE | not reported |
| J03a | DONE | not reported (135k own) | | J24 | DONE | not reported (200k own) |
| J04 | DONE | not reported (330k own) | | J24a | DONE | not reported (95k own) |
| J06 | DONE | not reported | | J26 | DONE | not reported (140k own) |
| J07 | DONE | 270k | | J27 | DONE | 355k |
| J08 | DONE | not reported (185k own) | | J27D | DONE | 340k |
| J09 | DONE | not reported (255k own) | | J27V | DONE | 370k |
| J09v | DONE | 210k | | J28 | DONE | 340k |
| J10 | DONE, resumed from stage 2 by J10b | 200k (J10b's session) | | J28D | DONE, over its 420k hand-back | 460k |
| J11 | DONE | not reported (120k own) | | J28V | stage 4 saved (stage 5 committed after its report, 9262898f) | 250k |
| J12 | DONE | not reported (≈200k own) | | J29 | DONE | 385k |
| J13 | DONE | not reported (130k own) | | J30 | DONE | 190k |
| J14 | DONE | 340k | | J31 | DONE | 405k |
| J15 | DONE | not reported (150k own) | | FS84-S1V | DONE | not reported (150k own) |
| J16 | DONE | not reported (175k own) | | J32 | DONE | not reported (75k own) |
| J17 | DONE | 205k | | J33 | DONE (report without a header line) | not reported |
| J17K | DONE (its stage 4 by budget rule to J17K2) | 335k | | J35 | DONE | not reported |
| J17K2 | DONE | not reported (an estimate of 200k; 125k own) | | J36 | DONE | 300k |
| J18 | DONE, a stall at a named step | 230k | | J37 | DONE | 215k |
| J19 | DONE | 230k | | J38 | DONE | not reported (215k own) |
| J20 | DONE | 400k | | J39 | DONE | not reported (200k own) |
| J21 | DONE | 460k | | J40 | DONE | 330k |
| J22 | DONE, resumed from stage 2 by J22b | not reported (190k own, J22b's) | | J41 | DONE | 285k |
| J23a | DONE, resumed at stage 3 by J23a2 | not reported (140k own, J23a2's) | | J42 | DONE | 260k |
| J23b | DONE | not reported (185k own) | | J44 | DONE | 285k |
| J23bd | DONE | not reported (45k own) | | J45 | DONE | 200k |
| J46 | DONE | 245k | | J47 | DONE | 175k |
| J48 | DONE (FS-100 stage 1) | not reported (215k own) | | J49 | DONE (FS-100 stage 2) | 136k |

**Totals.** 60 reports before J25's own, 58 of them DONE or DONE on resumption; 33 reported a harness figure, summing
to **9,616k**, against the plan's "roughly 9M tokens" for the whole crunch (§1.9) — so the crunch's true total, with 27 jobs unreported and
the clerk's runs, lies well above 9.6M. **Not run:** J05 (the ceiling rose instead), J17V (declined by the owner). **Still to run:** J43, the
bookend, after J25; J29-S4 (FS-84's S4), post-ban.

### 8.2 §5 scored once

*Scoring rule:* "happened" is read from the report named; a line is **met** when the event happened at `p ≥ 0.5` or did not happen at
`p < 0.5`, **missed** otherwise. E9 had no instrument and is unscored.

| id | p | happened? | met or missed | source |
|---|---|---|---|---|
| E1 PA-B2 TRUE | 0.85 | yes | met | J01's report: "PA-B2 TRUE" |
| E1b PA-B3 at `k = 6` | 0.65 | yes | met | J01: "PA-B3 TRUE at k = 6, 7, 8, 9" |
| E1c PA-B3 at every `k ≤ 9` | 0.50 | yes | met (at even odds) | J01, as above |
| E1d FALSE at some `k ≤ 9` | 0.10 | no | met | J01 |
| E2 J02 proves S1 | 0.65 | yes | met | J02: "S1 TRUE (J02-T2, hand)" |
| E2b J09 blind, the two agree | 0.40 | yes | **missed** | J09: "S1–S3 now two independent derivations" |
| E2c a point of `Θ₃(ℚ(α,√7))` | 0.03 | no | met | J02: "Θ₃(ℚ(α,√7))=∅ and χ=L=4"; J09 agrees |
| E3 the character local–global theorem at `k = 4, 5`, proved and blind-verified | 0.40 | yes | **missed** | J07: "CLG_k TRUE [hand] … every k ≥ 2, given H_k"; J10: "V1 TRUE (given H_k) … 24 of J07's 25 statements TRUE blind", one GAP at (g3) |
| E4 J08 decides character six-colourings of ℚ(√167) | 0.35 | yes, given CLG_7 | **missed** | J08: "no band six- or seven-character at either window member"; J11: "W4 TRUE for ℚ(√167) (χ_char=8 given CLG_7)" |
| E4b given E4, none exists | 0.80 | yes | met | J11, as above |
| E4c a band six-character of `Γ₂₃` | 0.03 | no | met | J08: "χ_char(Γ₂₃)=8" |
| E5 U3 at every `p ≡ 1 (mod 4)` | 0.35 | yes | **missed** | J12: "ONE-a TRUE at every p≡1(4)"; J13: "X1 TRUE at every p≡1(4)" |
| E6 FS-76 rank one proved | 0.25 | no | met | J18: "A-T1 GAP-at-KE"; J19: "A-T1 GAP at a named step" |
| E6b a counterexample | 0.05 | no | met | J18, J19 |
| E6c J18 stalls at a named step and J19 runs | 0.55 | yes | met | J18: "stall at a named step"; J19's report |
| E7 five-colour windows over ℚ(√167) excluded | 0.30 | no — landed in part | met | J21: "D2(a) GAP-at two steps"; M3's close: "landed in part" |
| E7b such a window colouring constructed | 0.03 | no | met | J21, J22 |
| E8 J14's chain theorem and 18-vertex instance green | 0.60 | yes | met | J14: "chain theorem TRUE in the kernel … 18-vertex oracle … kernel … Gate green" |
| E8b J15's route C green | 0.55 | yes | met | J15: "χ(F(t)²) = χ(F²) … [kernel] … gate green" |
| E8c J16 green | 0.35 | yes | **missed** | J16: "the stripe lemma — kernel, in full … Gate green" |
| E8d a new module through the full gate | 0.80 | yes | met | J14–J17K2 (gate green each) |
| E9 ≥ 3.5 agents on derivation, verification or kernel work, first 8 h | 0.40 | not measured | unscored | no utilisation log was kept |
| E9b ≥ 20 jobs DONE | 0.50 | yes (58) | met | §8.1 |
| E9c a halt costs more than one stage | 0.10 | no | met | the three resumptions (J10, J22, J23a) each resumed at the next unsaved stage |
| E10 M1 closed on the front page | 0.60 | yes | met | J24's report |
| E10b at least two milestones closed | 0.45 | yes (five) | **missed** | J24, J44 |
| E10c all three milestones closed | 0.25 | yes | **missed** | J24 |
| E11 at least three new `LEDGER.md` rows | 0.60 | yes (rows 98–115, eighteen) | met | `LEDGER.md` |
| E12 a lower bound above five | < 0.01 | no | met | — |

**The score:** 28 lines scored, **21 met, 7 missed**; Brier score 0.170; mean probability on the realised outcome 0.654. **Every miss is in
one direction: seven things happened that the planner put below even odds** — the class theorems (E2b, E3, E5), the six-colour decision
(E4), a kernel job (E8c) and the milestone count (E10b, E10c). The planner under-priced derivation work that had a blind verifier behind it.
Read with G21's warning: a calibration that errs only toward success is the direction to audit, and the blind verifiers are what audited it.

**"A good crunch", scored:** (1) a class theorem at "two independent derivations" or "derivation plus blind verification" (E2b, E3) — **met**
(J02 with J09; J07 with J10); (2) a kernel promotion (E8d) — **met**; (3) every landed milestone closed on the front page within the byte
cap — **met** (M1–M3 by J24, row 88 and FS-67 by J44; `CLAUDE.md` grew from 275,129 bytes at the plan to 294,994 after J44, 19,865 bytes
for five closes and J24a's pointers — under 4,000 per close on average, against the 300,000 then in force; row 88's draft 2,246, FS-67's
2,406, M3's 3,792); (4) no work lost to a halt beyond one stage — **met**, as far as
the reports show.

### 8.3 The milestones

- **Closed (five):** **M1 = FS-91** (rows 98–102, G77; `plans/FS91-character-local-global.md` §R-close), **Paid (theorem)**; **M2**, the
  kernel lane (rows 103–107; `plans/M2-kernel-lane.md` §R-close), **Paid (kernel)**; **M3** (rows 108–110, G78;
  `plans/M3-exotic-colourings.md` §R-close), Q1 **not landed**, Q2 **landed in part**; **row 88's question** (rows 111–113;
  `plans/FS86-row88-rigidity.md` §R-close), **Paid (theorem); row 88 not landed**; **FS-67** (rows 114–115; `plans/FS67-tight-products.md`
  §R-close), **Paid (theorem and no-go)**. G79 minted at the front page (Kooshi's grokking).
- **Open (one):** **FS-84**, ℚ(√47): five colours — S1 and S1V done, the rest post-ban (`plans/FS84-five-colours-47.md`).
- **Minted (nine):** FS-92 to FS-96 at M1–M3's closes; FS-97, FS-98, FS-99 at row 88's; FS-100 by J47 from the wanted posters. **FS-97 is
  absorbed into FS-100** (owner ruling, applied by J25).

### 8.4 What the queue hands to 2026-10-01, when the ban ends

**Post-ban stages** (each a search or an LP, forbidden in the crunch):

| stage | what | where it is written |
|---|---|---|
| FS-84's own | S4 the colouring side (J29-S4's row), S2 the four-class window LP, S3 the finite refusal and the chain | `plans/FS84-five-colours-47.md` §4.2 |
| FS-90 (Y1) | a triangle-free forcer of `(0, 4)` in a number field inside `ℚ₂(√3)` (row 90's T1), Kooshi's grant | `plans/FS86-row88-rigidity.md` §S.3; `plans/STUB-sanctioned-search-fs86.md` |
| FS-64 (Y2) | `χ_f(ℚ(√59)²) = 4` by an exact LP on derivation-fixed layered configurations | `plans/FS86-row88-close-inventory.md` row 53; `plans/STUB-adelic-window-colouring.md` |
| FS-100's P1 = J37's R4 (EI-F) | a triangle-free Dúcz–Varga-type finite `H ⊂ ℚ(√47)²` with `α(H) < \|H\|/4`, priced before any run | `plans/STUB-measure-rigidity-three-fields.md` §6.4 |
| FS-67's PB-2 | the spectra of `[Tardif2023]`'s `Ω_w(K_m)` and `[Tardif2022frac]`'s factors, once held | `plans/FS67-tight-products.md` §R-close; `plans/STUB-tight-product-colourings.md` |
| FS-45's D3 | the unconditional `K(√7)` five-colour instance, which needs a fresh LRAT for the 8/3 forcer (a solver run) | §2's "Not queued" |

**In-ban work left** (derivations and readings, runnable before 2026-10-01): **FS-100** stages 0 (the reframe; it registers X-MR), 3 (the MR
reading room), 4 (Kronecker selection — after the crunch, per Kooshi), 5 (MR itself) and 6 (EI-2 over ℚ(√11)); **J43**, the bookend
visualization, launched after J25.

### 8.5 Kooshi's rulings, and the owner's slips, of the crunch

**Kooshi's rulings** (addresses: `plans/SESSION-HANDOFF-2026-09-25-crunch.md` §1, §6, unless marked):
1. Sixteen usage-hours; 4–5 agents nonstop from a queue; jobs may propose jobs; no child spawns children.
2. The staffing cap: "Max 4 subagents for now", then 4–5 for the crunch; cut to 4 and later to 2 (§6).
3. `CLAUDE.md`'s budget: 300,000 bytes (1263d964), then 325,000 until the crunch ends, 300,000 the default after it (6460c11e).
4. Worktrees only by the recorded recipe; one Lean build at a time.
5. The ban on finite-witness search holds to 2026-10-01 (`CLAUDE.md` § Toolchain).
6. Push freely; never force-push (standing rule 6, as corrected).
7. G79, his grokking, verbatim in `plans/CRUNCH-2026-09-25-post-close-inventory.md` row 25 (minted by J44).
8. "Write up the portrait of 4 in 47 as a full milestone to be run at some point after the crunch" (FS-100's stub header; J47).
9. Kronecker selection is FS-100's stage 4, after the crunch ("yes to all 3", read as the owner's leans; §6).
10. **Open with him:** at most three milestones at once (the planner's default, §1.1); the Johnson papers and the fetch list (§2, §6);
    FS-90's two hours; post-ban Y1 and Y2.

**The owner's slips** (each found by the job named, or by the owner's own check):
1. STANDING-RULES item 6 said "never push", against Kooshi's rule (post-close inventory row 21; fixed 4991d06b).
2. The clerk's brief J00 said the same (row 24).
3. J26's brief attributed G27 to `[AmbrusEtAl2023]`; it is `[MatolcsiEtAl2025]`'s (J26's report).
4. J29's brief paraphrased CLG more widely than CLG_k gives (J29's report; the planner's §0 and §G.1 likely the source).
5. J37–J39's brief: "spectrum reads infinitely many primes" is wider than R88-TCA; literal only after rotation averaging (J37's report).
6. J41's brief said T-C over all of S2 is two blind derivations; the blind one is type (B) only (J41's report).
7. J47's brief cited priors at "J37 §4.6" that are in §4.5 R2 and §4.3 (b), and EI-2's 0.4 is "over slack fields" (J47's report).

**Owner rulings applied at the front page** (J44, J25): FS67-CL's grade; `B(n)`, `A(n)` a composition of print, not ours; `--dupes` at 13
accepted; G79 forwarded before J37–J39 tested it; FS-100's file named for the lemma, BC-8 optional (row 41); T-J39-4 re-graded onto the de
Grey route (J48's held item 2); FS-97 absorbed into FS-100 (J47's proposal); J17V declined.
