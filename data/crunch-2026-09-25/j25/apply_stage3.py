#!/usr/bin/env python3
"""J25 stage 3: FS-100's status and J48's corrections, the re-aims of FS-59, FS-96, FS-98, FS-97's absorption, and their mirrors in
plans/FRONTIER-STUBS.md and CLAUDE.md § Paths forward. Every anchor asserted at its expected count before anything is written.
Usage: apply_stage3.py [--plant]"""
import sys, pathlib
ROOT = pathlib.Path('/home/kooshi/source/lean-dir')
S100 = 'plans/STUB-measure-rigidity-three-fields.md'
FS = 'plans/FRONTIER-STUBS.md'
R42 = ("\"refusing five at ℚ(√167) (χ ≥ 6) needs χ_CP(ℝ²) ≥ 6 modulo MR, PL(23,43), FS-69; FS-59's own χ ≥ 5 waits only on MR "
       "(T-J39-4)\"")
R3 = ("\"(i) for existence the places are `{∞, 23, 43}`, modulo SP (the split places drop out, T-J39-1); (ii) GAP-1 does not arise in "
      "the CP format; (iii) GAP-2 is PL(23, 43), FS-67's Hedetniemi question in CP form (rows 114–115); (iv) its payoff is T-J39-5\"")
R1 = ("\"Over ℚ(√59), ℚ(√83), ℚ(√131): for each `p ∈ Pull` there is a finite `B ⊂ R` such that every `c ∈ X₄(F)` with `c|_B = p|_B` "
      "equals `p`. Route through the determinacy ladder (co-finite: R88-B2-1; half-space: FS86-dB-H); the named step is the "
      "split-dominated re-centring. Control: at ℚ(√11) a gapped periodic colouring is not isolated (C9 with a shrinking archimedean "
      "term), so the proof must use gap-freeness.\"")
E = []
def ins_after(f, anchor, text, n=1): E.append((f, anchor, anchor + text, n))
def rep(f, old, new, n=1): E.append((f, old, new, n))

# ---------------- FS-100 stub ----------------
ins_after(S100, "source.*\n",
 "\n**Status at the crunch's close (2026-09-26, front-page job J25).** **Stage 1 — DONE** (J48, `plans/FS100-BC-verification.md`): BC-1 to\n"
 "BC-8 all TRUE, blind, \"no difference of truth\" (J48's report); its caveat, J48's held item 1: \"the confirmation is route-dependent for\n"
 "seven of eight claims (both minds composed the same permitted lemmas), so a flaw shared by J45's SI/R-U, T-C or row 98 would be shared\n"
 "too\". Its corrections (J48 §3.4) are applied in §2.3. **Stage 2 — DONE, certified** (J49, `plans/FS100-KT1-ambrus-ball.md`):\n"
 "`m₁(ℝ²) ≤ 0.246989 < 0.2470` [cert + hand]. **FS-97 is absorbed here** (owner ruling on J47's proposal; §9; its stub carries the banner).\n"
 "Left in-ban: stages 0, 3, 4 (Kronecker selection, after the crunch, per Kooshi), 5 and 6; P1 from 2026-10-01. **Nothing here is a\n"
 "Frontier result: the milestone has not run.**\n")
rep(S100, "| [hand, two derivations]; rests on `[AmbrusEtAl2023]` | rows 92, 110 |",
          "| [hand, two derivations]; rests on `[AmbrusEtAl2023]` ([cert + hand] since J49) | rows 92, 110 |")
rep(S100, "rests on `[AmbrusEtAl2023]` when `θ` has an archimedean part |",
          "rests on `[AmbrusEtAl2023]` ([cert + hand] since J49) when `θ` has an archimedean part |")
rep(S100, "rests on `[AmbrusEtAl2023]`, FS-66 at 11 and 19, Lemma P,",
          "rests on `[AmbrusEtAl2023]` ([cert + hand] since J49), FS-66 at 11 and 19, Lemma P,")
rep(S100, "**J38 (ℚ(√59), ℚ(√83), ℚ(√131), four colours) — every theorem [hand, one mind]:**",
          "**J38 (ℚ(√59), ℚ(√83), ℚ(√131), four colours) — every theorem [hand, one mind; blind-checked TRUE by J48, stage 1]:**")
rep(S100, "**J39 (ℚ(√167), five colours) — every theorem [hand, one mind];",
          "**J39 (ℚ(√167), five colours) — every theorem [hand, one mind; blind-checked TRUE by J48, stage 1];")
ins_after(S100, "Here Iso(F) is T-B1, vacuous when there is no tight place.\"\n",
 "  *J48's correction (§3.4 item 4):* it holds \"on each `R`-coset of `F²`\", and outside ℚ(√47) and type (B) it rests on the one-mind\n"
 "  class forms of T-C and T-C(A).\n")
rep(S100, "(every `k`, every totally real `F`)\n- **T-J39-1**",
 "(every `k`, every totally real `F`)\n"
 "  *J48's correction (§3.4 item 1; the theorem unchanged):* step 5's \"`R̂_prof = ∏_{stable w} O_{L_w}`\" had no input — by Lemma C\n"
 "  (FS91-J07-3) the profinite and stable topologies on `R` agree, and by Lemma C′ (FS91-J07-4) `(L⊗ℝ) × R̂_prof` is an open subgroup of\n"
 "  finite index of `(L⊗ℝ) × ∏_{stable w} O_{L_w}`, equal to it unless a stable dyadic place is ramified in `L/F` with `R̄₂` proper\n"
 "  (ℚ(√5)); there the colouring extends by independent copies on the finitely many cosets. Lemmas C and C′ join its inputs.\n"
 "- **T-J39-1**")
rep(S100, "It\n  \"uses neither FS-66 nor Zhang\".\n",
 "It\n  \"uses neither FS-66 nor Zhang\". **Re-graded onto two routes (owner ruling on J48's held item 2):** J39's, through `m₁`\n"
 "  (`[AmbrusEtAl2023]`), and **J48's, through de Grey's graph** — J48-N4, \"`N₄(ℚ(√167)) = ∅`: every stable place of ℚ(√167) is 4-thick,\n"
 "  23 by `0.331695… < 1/3` (margin `1.6·10⁻³`)\" [tools, rigorous interval arithmetic], so `Y_{F,4} = UD(ℝ²)`, and a CP four-colouring of\n"
 "  it would four-colour de Grey's 1581-vertex graph almost surely, which rung B refuses (J48 §2.4). **The de Grey route needs no\n"
 "  `[AmbrusEtAl2023]`**; its one numerical input is the 23 margin. BC-3 TRUE [hand + tools]. **J48's corollary (J48-N4cor) [hand]:** \"For\n"
 "  every totally real `F` with `N₄(F) = ∅` — every stable place 4-thick — MR(F) ⟹ `χ(F²) ≥ 5`\".\n")
ins_after(S100, "`UD(ℝ²)`\" (§3.3 (b)).\n",
 "  *J48's correction (§3.4 item 2):* (ii)'s hypothesis \"43's all-levels ratio is `< 1/5`\" is used by neither proof and is dropped.\n")
rep(S100, "| `[AmbrusEtAl2023]` | P4, P5, P7, P8, P9 | Theorem C (row 112) | T-J39-4 only (`m₁ < 1/4` at four); not T-J39-3 |",
          "| `[AmbrusEtAl2023]` ([cert + hand] since J49) | P4, P5, P7, P8, P9 | Theorem C (row 112) | T-J39-4's `m₁` route only; its de Grey route (J48) and T-J39-3 need none |")
rep(S100, "| the ball-arithmetic evaluation finding a violated margin (§6 Stage 2) |",
          "| the ball-arithmetic evaluation finding a violated margin (§6 Stage 2) — **scored: met** (J49, certified; §7's failure clause does not fire) |")
rep(S100, "| a FALSE or GAP at step 5 or 6 |",
          "| a FALSE or GAP at step 5 or 6 — **scored by J48:** BC-1 TRUE; steps 3, 6 and 7 hold; step 5 held after a repair of its statement (Lemma C and a finite-index extension, §2.3) |")
rep(S100, "| **unregistered**: the opening registers one, with its uninformative outcome and whether it is reachable (G21) |",
          "| **unregistered: the FS-100 planner registers it at stage 0**, with its uninformative outcome and whether it is reachable (G21) |")
ins_after(S100, "| an SP witness over any real field (a `U`-invariant, positive, `E`-null measure with negative mean at 1) |\n",
 "| X-R1 | FS-97's (R1) \"closes by a limit argument\" (carried at FS-97's absorption) | 0.3 (\"J41's prior, from the records only\") | `plans/STUB-infinite-place-spectra.md` | none named there; the planner writes one at stage 0 |\n")
rep(S100, "| 1 | the bundled blind check of the posters' one-mind theorems (§6.1) |",
          "| 1 | **DONE (J48)** — the bundled blind check of the posters' one-mind theorems (§6.1) |")
rep(S100, "| 2 | KT-1: `[AmbrusEtAl2023]`'s obligation H4 in ball arithmetic (§6.2) |",
          "| 2 | **DONE, certified (J49)** — KT-1: `[AmbrusEtAl2023]`'s obligation H4 in ball arithmetic (§6.2) |")
rep(S100, "### 6.1 Stage 1 — the bundled blind check, its fixed claim list (for a brief; Kooshi may run it inside the crunch)",
          "### 6.1 Stage 1 — the bundled blind check, its fixed claim list — DONE (J48, `plans/FS100-BC-verification.md`)")
rep(S100, "### 6.2 Stage 2 — KT-1, and what its failure would do to each row",
          "### 6.2 Stage 2 — KT-1, and what its failure would do to each row — DONE, certified (J49, `plans/FS100-KT1-ambrus-ball.md`)")
rep(S100, "| T-J39-4 | loses `Y_{F,4}`'s refusal; MR alone no longer gives `χ(ℚ(√167)²) ≥ 5` |",
          "| T-J39-4 | its `m₁` route loses `Y_{F,4}`'s refusal; the de Grey route (J48) does not, so MR still gives `χ(ℚ(√167)²) ≥ 5` |")
rep(S100, "  - Stage 1 FALSE at step 5 or 6 →", "  - (Did not fire: J48.) Stage 1 FALSE at step 5 or 6 →")
rep(S100, "  - Stage 2 violated → §6.2's table; inconclusive → the grade stays.",
          "  - Stage 2 violated → §6.2's table; inconclusive → the grade stays. (Neither fired: J49 certified.)")
rep(S100, "**This\nstub proposes that FS-97 be absorbed into FS-100** at the next front-page pass, with a banner; its (R1) question at type (B) is reached through\nT-B1 (FS-98). Held for the owner; FS-97's stub is not edited here.",
 "**FS-97 is\nabsorbed into FS-100** (owner ruling on J47's proposal, applied 2026-09-26 by front-page job J25; FS-97's stub carries the banner); its (R1)\n"
 "question at type (B) is reached through T-B1 (FS-98), and its priors carry to §4 (X-R2, X-R1).\n\n"
 "**Also homed here from J38 (post-close inventory row 35; J38 §4.5 R5, R4):** DP as a named lemma, verbatim: \"over a type-(B) field, a\n"
 "translation-invariant random four-colouring with a finite-place proper factor colouring is carried by Pull\" — the MR-free route for the\n"
 "pure-point layer at type (B); and J38's control card (§4.4, rank 2): for an inert dyadic place of norm `Q ∈ {4, 8, 16, 32}`, does `O/4O`\n"
 "carry a band-4 character — an exact enumeration once a derivation fixes `O` and the level (standing rule 3's edge). Its evidence is\n"
 "T-J38-4 [tools exact] (row 34 of the post-close inventory): \"tight dyadic tower of type (B): |S₄|=24, 12 band-4 characters on O/4O (order\n"
 "4), none on O/2O; Θ₄(R_F)≠∅, so no type-(B) lattice is the control; level one decides nothing at dyadic towers\".")

# ---------------- FS-59, FS-96, FS-97, FS-98 stubs ----------------
S59 = 'plans/STUB-four-colours-167.md'
rep(S59, "**Cross-reference (2026-09-25, J47):** J39 found",
 "**Re-aimed at the crunch's close (2026-09-26, J25; post-close inventory row 42, from J39's R4):** " + R42 + ". T-J39-4 is blind-checked\n"
 "TRUE (J48, BC-3) and by J48's de Grey route needs no `[AmbrusEtAl2023]`; MR is FS-100's lemma. J39's ranking line: \"the conjecture's widest\n"
 "gap, archimedean modulo MR and PL\". A five-colouring falsifying \"≥ 6\" is local at no prime, 43 at depth excepted (FS-69).\n\n"
 "**Cross-reference (2026-09-25, J47):** J39 found")
S96 = 'plans/STUB-windows-five-nonmixing.md'
rep(S96, "**Cross-reference (2026-09-25, J47):** J39's re-aim of this stub (its R3: \"for existence the places are `{∞, 23, 43}`, modulo SP\"; GAP-2 is PL(23, 43)) is listed in `plans/STUB-measure-rigidity-three-fields.md` §2.5 (FS-100) for the next front-page pass; not applied here.",
 "**Re-aimed at the crunch's close (2026-09-26, J25; J39's R3, `plans/POROS-2026-09-25-wanted-poster-167.md` §4.5):** " + R3 + ". Both\n"
 "qualifiers, *for existence* and *modulo SP*, are part of the statement; a deterministic window over split places stays open as a window\n"
 "(FS-100 §2.5). T-J39-1 and T-J39-5 are blind-checked TRUE (J48, BC-2, BC-4; BC-4 (ii) with its 43 hypothesis dropped); SP and MR are\n"
 "FS-100's. The questions below stand as M3 left them, read through (i)–(iv).")
S97 = 'plans/STUB-infinite-place-spectra.md'
ins_after(S97, "(T-C′, the remainder of row 88's measure half)\n",
 "\n> **Absorbed into FS-100 (2026-09-26; owner ruling on J47's proposal, applied by front-page job J25).** Its questions are FS-100's\n"
 "> (`plans/STUB-measure-rigidity-three-fields.md` §9): Q2 is MR (SP ⟺ ¬MR, two derivations), Q3 is answered at type (A) by R-U and reduced\n"
 "> to T-B1 at type (B) by T-J38-2, Q4 is SP-Cor, and (R1) at type (B) is reached through T-B1 (FS-98). Its priors carry to FS-100 §4. Kept as\n"
 "> the record of its minting; demoted, never deleted.\n")
S98 = 'plans/STUB-ultrametric-continuation.md'
ins_after(S98, "(a ball agreeing with a pullback on a patch) measures balls, never the plane — the questions are derivations.*\n",
 "\n**Re-aimed at the crunch's close (2026-09-26, J25; post-close inventory rows 34–35, J38 §4.5 R1):** to **T-B1 alone**, recorded with\n"
 "T-J38-2 (given MR(F), row 88 ⟺ T-B1; blind-checked TRUE by J48, BC-6). J38's statement for a brief, verbatim: " + R1 + " T-B2 is\n"
 "demoted: T-B1 ⟹ Q-tr ⟹ T-B2. MR and DP are homed in FS-100, which absorbed FS-97. The determinacy ladder's two proved rungs: R88-B2-1\n"
 "(co-finite) and row 91's H (half-space).\n")

# ---------------- plans/FRONTIER-STUBS.md ----------------
rep(FS, "*FS-100 minted 2026-09-25 by crunch job J47 at rank 3",
 "*At the crunch's close (2026-09-26, J25) no rank moved: FS-97 is absorbed into FS-100 (owner ruling on J47's proposal) and keeps rank 13 under\n"
 "its banner so the numbering stands; FS-59, FS-96 and FS-98 re-aimed (J39's R4 and R3, J38's R1); FS-100's stages 1–2 done (J48, J49).*\n\n"
 "*FS-100 minted 2026-09-25 by crunch job J47 at rank 3")
rep(FS, "**At M3's close:** window five-colourings over finitely many places reduced to nine places (row 110); a five-colouring no window gives is untouched. |",
 "**At M3's close:** window five-colourings over finitely many places reduced to nine places (row 110); a five-colouring no window gives is untouched. **At the crunch's close (J25; post-close inventory row 42):** " + R42 + " — MR is FS-100's lemma. |")
rep(FS, "(only a whole-plane colouring with ≤ 5 colours, local at no prime, would: FS-64; since FS-89 it cannot be a character colouring, row 96).",
 "(only a whole-plane colouring with ≤ 5 colours, local at no prime (43 at depth excepted, FS-69), would: FS-64; since FS-89 it cannot be a character colouring, row 96); J39's ranking: \"the conjecture's widest gap, archimedean modulo MR and PL\".")
rep(FS, "re-aimed at the M1 and M3 closes (2026-09-25) |", "re-aimed at the M1 and M3 closes (2026-09-25) and at the crunch's close (2026-09-26) |")
rep(FS, "Stages: a bundled blind check of T-J39-1/3/4/5 and T-J38-1/2/3; KT-1, `[AmbrusEtAl2023]`'s H4 in ball arithmetic; MR's prior-art gate; Kronecker selection; MR itself. FS-84 keeps its search stages; FS-97's absorption proposed |",
 "Stages: **1 (the bundled blind check, J48) and 2 (KT-1, J49) done in the crunch** — the stub's status block; left: the reframe (0), MR's prior-art gate (3), Kronecker selection (4, after the crunch), MR itself (5), EI-2 at ℚ(√11) (6); P1 post-ban. FS-84 keeps its search stages; **FS-97 absorbed** (owner ruling) |")
rep(FS, "| the blind check one verifier; KT-1 minutes (needs `python-flint`); MR a Furstenberg-type wall, unpriced | minted; J38's and J39's theorems one mind, T-J37-1 two |",
 "| stage 3 a day of reading; MR a Furstenberg-type wall, unpriced | minted; stages 1–2 done (J48, J49); FS-97 absorbed |")
rep(FS, "| 13 | **FS-97 invariant four-colourings whose spectrum reads infinitely many places** — `plans/STUB-infinite-place-spectra.md` (minted at row 88's close) | Row 88's measure half beyond Theorem C (row 112): spectra on the union over finite `S` of `T + A + Fin_S` and on no single one (R1: no Haar measure on the full product), or reading infinitely many split places (R2: entropy, ×2×3 rigidity); the ℚ(√47) form (row 113) | none directly; the only measure route to `F(R)` over type (B) and to `χ(ℚ(√47)²)` | unpriced (a derivation) | minted 2026-09-25 at row 88's close | none |",
 "| 13 | **FS-97 — absorbed into FS-100 (2026-09-26)** — `plans/STUB-infinite-place-spectra.md` (minted at row 88's close; banner) | Its questions are FS-100's (that stub's §9): the measure half beyond Theorem C (row 112) — (R1) spectra on the union over finite `S` and on no single one, (R2) infinitely many split places, entropy and ×2×3 — is MR, R-U, T-B1 and SP-Cor there. Kept at its rank so the numbering stands | — (FS-100's) | — | absorbed 2026-09-26 (owner ruling on J47's proposal); the closed list | none |")
rep(FS, "43 at depth needs `B₁(43) < 369.8` (FS-69). |",
 "43 at depth needs `B₁(43) < 369.8` (FS-69). **Re-aimed at the crunch's close (J25; J39's R3):** " + R3 + ". |")
rep(FS, "| minted at M3's close | none until 2026-10-01 |", "| minted at M3's close; re-aimed at the crunch's close (2026-09-26) | none until 2026-10-01 |")
rep(FS, "| Isolation across an ultrametric front (T-B1) and defect growth (T-B2), both stopped at one named step by two minds (row 111):",
 "| **Re-aimed at the crunch's close (J25; J38's R1):** T-B1 alone — given MR, row 88 ⟺ T-B1 (T-J38-2; FS-100); T-B2 demoted, T-B1 ⟹ Q-tr ⟹ T-B2. Isolation across an ultrametric front (T-B1) and defect growth (T-B2), both stopped at one named step by two minds (row 111):")
rep(FS, "| unpriced (a derivation) | minted 2026-09-25 at row 88's close | none until 2026-10-01; after it a finite shadow",
 "| unpriced (a derivation) | minted 2026-09-25 at row 88's close; re-aimed at the crunch's close (2026-09-26) | none until 2026-10-01; after it a finite shadow")
ins_after(FS, "the sharp mixing pullback (row 115); **Paid (theorem and no-go)**.\n",
 "* **FS-97 invariant four-colourings whose spectrum reads infinitely many places** — `plans/STUB-infinite-place-spectra.md`. **Absorbed into\n"
 "  FS-100 2026-09-26** (owner ruling on J47's proposal; `plans/STUB-measure-rigidity-three-fields.md` §9; the stub carries the banner): its\n"
 "  questions are MR, R-U, T-B1 and SP-Cor there; it keeps rank 13 in the table so the numbering stands.\n")

# ---------------- CLAUDE.md ----------------
C = 'CLAUDE.md'
rep(C, "*Last updated: 2026-09-25 — **row 88's question and FS-67 closed**",
 "*Last updated: 2026-09-26 — **the 2026-09-25 crunch closed** (queue `plans/CRUNCH-2026-09-25-queue.md` §8: its jobs, its expectations scored,\n"
 "its hand-over to 2026-10-01); FS-100's stages 1–2 ran and FS-97 was absorbed into it (the stub). Before it, 2026-09-25 — **row 88's question and FS-67 closed**")
rep(C, "**Ranked stubs** (FS-100 minted at rank 3 by crunch job J47,",
 "**Ranked stubs** (at the crunch's close no rank moved: FS-97 absorbed into FS-100 and kept at rank 13 under its banner; FS-59, FS-96, FS-98 re-aimed. FS-100 minted at rank 3 by crunch job J47,")
rep(C, "only a whole-plane colouring with ≤ 5 colours, local at no prime, would: FS-64) …;",
 "only a whole-plane colouring with ≤ 5 colours, local at no prime (43 at depth excepted, FS-69), would: FS-64) …; its ≥ 6 is archimedean modulo MR and PL, its ≥ 5 waits only on MR (FS-100; the stub);")
rep(C, "first a blind check of J38's and J39's one-mind theorems, then KT-1 and Kronecker selection |",
 "stages 1 (blind check, J48) and 2 (KT-1, J49) done — the stub's status block; FS-97 absorbed; next the reframe, MR's reading room, Kronecker selection |")
rep(C, "| 13 | **FS-97 invariant four-colourings whose spectrum reads infinitely many places** — `plans/STUB-infinite-place-spectra.md` (minted at row 88's close) | row 88's measure half beyond Theorem C (row 112): spectra on the union over finite `S` of `T + A + Fin_S` and on no single one (R1), or reading infinitely many split places (R2); entropy and ×2×3; the ℚ(√47) form | none directly; the only measure route to `F(R)` over type (B) and to `χ(ℚ(√47)²)` |",
 "| 13 | **FS-97 — absorbed into FS-100 (2026-09-26)** — `plans/STUB-infinite-place-spectra.md` (banner) | row 88's measure half beyond Theorem C (row 112) — (R1), (R2), entropy and ×2×3, the ℚ(√47) form — is FS-100's MR, R-U, T-B1 and SP-Cor; kept at its rank so the numbering stands | — |")
rep(C, "| D2 at seven places, the null-set step; FS-64 at five colours over ℚ(√167) after row 110 |",
 "| re-aimed (J39's R3): for existence the places are `{∞, 23, 43}` modulo SP; GAP-1 does not arise in the CP format; GAP-2 is PL(23, 43), FS-67's question in CP form; D2 at seven places and the null-set step as M3 left them; FS-64 at five colours over ℚ(√167) after row 110 |")
rep(C, "| isolation across an ultrametric front (T-B1) and defect growth (T-B2), both stopped at one named step by two minds (row 111); the expansive-subdynamics reading |",
 "| re-aimed (J38's R1) to isolation across an ultrametric front (T-B1) alone — given MR, row 88 ⟺ T-B1 (FS-100); defect growth (T-B2) demoted; both stopped at one named step by two minds (row 111); the expansive-subdynamics reading |")

def main():
    edits = list(E)
    checks = []
    if '--plant' in sys.argv:
        edits.append((C, 'an anchor no file holds (J25 plant)', 'x', 1))
    texts = {}
    for f, old, new, n in checks + edits:
        texts.setdefault(f, (ROOT / f).read_text(encoding='utf-8'))
    for f, old, new, n in edits:
        c = texts[f].count(old)
        if c != n:
            print(f'FAIL: {f}: anchor found {c} times, expected {n}: {old[:90]!r}'); sys.exit(1)
        if n and old not in new and texts[f].count(new):
            print(f'FAIL: {f}: replacement already present'); sys.exit(1)
        texts[f] = texts[f].replace(old, new)
    before = {f: (ROOT / f).stat().st_size for f in texts}
    for f, t in texts.items():
        (ROOT / f).write_text(t, encoding='utf-8')
        print(f'wrote {f}: {before[f]} -> {len(t.encode())} bytes')
    print('RESULT: PASS')

if __name__ == '__main__':
    main()
