import re
p="/home/kooshi/source/lean-dir/CLAUDE.md"
t=open(p,encoding="utf-8").read()
def rx(s): return r"\s+".join(re.escape(w) for w in s.split())
def rep(old,new):
    global t
    ms=list(re.finditer(rx(old),t)); assert len(ms)==1,(len(ms),old[:80])
    m=ms[0]; t=t[:m.start()]+new+t[m.end():]
def ins_after(anchor,add):
    global t
    ms=list(re.finditer(rx(anchor),t)); assert len(ms)==1,(len(ms),anchor[:80])
    m=ms[0]; t=t[:m.end()]+add+t[m.end():]
# Last updated
rep("*Last updated: 2026-09-26 — **FS-100 stage 5** (the ×2×3 crunch, 2026-09-26):",
    "*Last updated: 2026-09-26 — **FS-100 stage 5, wave 3** (the ×2×3 crunch): **Paid (theorem)** — the local–global conjecture's main clause through five, `χ(F²) = L(F)` for `L(F) ≤ 5` over every real number field (row 123), with `χ(ℚ(√3,√5)²) = 5`, five across the `L ≥ 5` quadratic family and `χ(ℚ(√167)²) ≥ 5`; the type-(B) fields' rotation-invariant half (row 124); six at ℚ(√167) reduced to `χ_CP(ℝ²) ≥ 6` (row 125); prior-art gate negative (novelty \"not found\") (`plans/FS100-three-field-lemma.md` §R-close (stage 5, wave 3)). Its waves 1–2, **FS-100 stage 5** (the ×2×3 crunch, 2026-09-26):")
rep("the conjecture's cheapest exposed five-clause met, [hand], prior-art gate pending (X24R);",
    "the conjecture's cheapest exposed five-clause met, [hand]; prior-art gate negative (X24R);")
# mission (2)
rep("Its proved range is item 10's; its remaining *testable* range is L = 5 outside it (ℚ(√3,√5) and FS-48's table), then",
    "Its proved range is item 10's — every `L ≤ 5` (row 123); its remaining *testable* range is")
rep("exactly five at ℚ(√47) — **met** (row 121) — and at ℚ(√143), ℚ(√311), ℚ(√335) (met at K0's grade, row 121) and ℚ(√3,√5) (open, four proven: rows 73–74, G55)",
    "exactly five at ℚ(√47), ℚ(√143), ℚ(√311), ℚ(√335) and ℚ(√3,√5) — **all met** (rows 121, 123)")
rep("proven 4 in the kernel (row 119) and ≥ 5 at K0's grade (row 121)", "proven 4 in the kernel (row 119) and ≥ 5 (row 123)")
# item 10 (the 8/3-forcer clause kept as the one route independent of MR)
i=t.index("10. **The conjecture's proved range**"); j=t.index("\n11. ",i)
t=t[:i]+("10. **The conjecture's proved range** (G55; GPT Astra; rows 99, 123): χ(F²) = L(F) for every real number field with **L ≤ 5** — L ≤ 4\n"
 "   by row 99 [hand, three derivations], L = 5 given MR (row 120) by the class theorem and SP-Cor in every degree (row 123) [hand, every link two\n"
 "   derivations or more]; over multiquadratic F ⊇ K with L ≤ 5 also by the chain theorem, given the measured 8/3 forcer — the one route independent\n"
 "   of MR. Its exposed predictions are the target's (§ The mission): four for ℚ(√11) and ℚ(√23) (row 73), and five at ℚ(√47)\n"
 "   (row 121), ℚ(√143), ℚ(√311), ℚ(√335) and ℚ(√3,√5) (row 123) are met. With every residue level allowed, `L` is unchanged at 7, 11, 19, 23\n"
 "   (row 75, G66).")+t[j:]
# items 18, 22, 24, 29
rep("**Not landed: five over ℚ(√3,√5).**", "**Five over ℚ(√3,√5) lands, non-constructively** (row 123, given MR): the plane needs five, so some finite unit-distance graph over it is five-chromatic — no lattice of rank ≤ 6 carries it, and the rank-8 one is FS-72's object.")
rep("Five over ℚ(√167) is FS-59's question.", "Five over ℚ(√167) holds by two routes (row 123); six contains `χ_CP(ℝ²) ≥ 6` (row 125).")
rep("with MR held (row 120), row 88 ⟺ T-B1 (FS-98);",
    "with MR held (row 120), row 88 ⟺ T-B1 ⟺ no rigid-motion-transient four-colouring, and every rotation-invariant random four-colouring is a pullback (row 124); the translation-invariant half is one step, TR-ROT (under attack at the close: X27);")
ins_after("the flip stops at a quantitative T-C(A) (row 122). Bearing on χ ≥ 6: none; ℚ(√167)'s gap is now [5, 7].",
    " Wave 3 (rows 123–125): the class is `L ≥ 5` in every degree and SP-Cor holds on it, so χ(F²) = L(F) for `L ≤ 5` everywhere; ℚ(√3,√5) five; the type-(B) fields' rotation-invariant half; six at ℚ(√167) reduced to `χ_CP(ℝ²) ≥ 6 ∧ PL_∃(23, 43)`.")
# Not ours
rep("the bridge `χ(ℝ²) = sup_F χ(F²)` (`[Madore2015]` ¶5.4, by Tarski; noted by `[BendaPerles2000]`).",
    "the bridge `χ(ℝ²) = sup_F χ(F²)` (`[Madore2015]` ¶5.4, by Tarski; noted by `[BendaPerles2000]`); the extremal-trace name for MR's finitely generated case, the generalized Furstenberg conjecture (`[LacaWarren2018]`, open); Croft's `m₁(ℝ²) ≥ 0.2293` (`[Croft1967]`).")
# Open milestones
rep("FS-100 stage 5, the ×2×3 crunch (rows 120–122, G80; `plans/FS100-derivation.md` §3; the stub re-aimed, FS-97's banner);",
    "FS-100 stage 5, the ×2×3 crunch (rows 120–122, G80; `plans/FS100-derivation.md` §3; the stub re-aimed, FS-97's banner), and its wave 3 (rows 123–125; `plans/FS100-derivation.md` §4);")
# ranked table
rep("≥ 5 at K0's grade (row 121); six waits on J39's T-J39-5 and its two lemmas …",
    "**≥ 5 by two routes (row 123)**; six contains `χ_CP(ℝ²) ≥ 6 ∧ PL_∃(23, 43)` (row 125) — both conjuncts open, no density bound can give the first …")
rep("| **MR proved (row 120), `χ(ℚ(√47)²) = 5` (row 121)** — [hand], prior-art gate pending (X24R); with MR, row 88 ⟺ T-B1 and `χ(ℚ(√167)²) ≥ 5`; the in-ban round's results stand (rows 116–118); FS-97 absorbed. **Left:** the value's prior-art gate and EL2021 §2; MR at row 100's exception fields; X11K's kernel port; stage 4′ moot for ℚ(√47) | none |",
    "| **MR proved (row 120); `χ(ℚ(√47)²) = 5` (row 121); wave 3: `χ(F²) = L(F)` for `L ≤ 5` over every real number field (row 123), the type-(B) rotation-invariant half (row 124), six at ℚ(√167) reduced (row 125)** — [hand]; prior-art gate negative (X24R); the in-ban round's results stand (rows 116–118); FS-97 absorbed. **Left:** TR-ROT (under attack at the close: X27); C-4 (transience); MR at row 100's exception fields (no colouring consequence: they have `L = 2`); MR's complex-place case on an instance; the kernel port (FS-101); stage 4′ moot for ℚ(√47) | none |\n"
    "| 3′ | **FS-101 the main clause through five in the kernel** — `plans/STUB-main-clause-five-kernel.md` (rank Kooshi's; default just below FS-100) | Kooshi's target (06:5x): *\"The target for the Lean implementation should move to the more general 'every real' claim.\"* X11K2's skeleton states `min(L(F), 5) ≤ χ(F²)` for every real number field over named inputs; `χ(ℚ(√47)²) ≤ 5` is sorry-free. Next: gate into `Proofs/`, `posDef_corr`, the upper half from row 52 and the stable-prime valuation subring (row 57's gap), then which inputs to build and which to keep as interfaces | none; the conjecture's proved range to the kernel's word |")
rep("— row 88 ⟺ T-B1 (MR held, row 120); defect growth (T-B2) demoted …",
    "— row 88 ⟺ T-B1 (MR held, row 120); **TR-ROT** beside T-B1 (row 124; T-B1 ⟹ TR-ROT; X27D/X27V attacked it at the close); defect growth (T-B2) demoted …")
rep("L ≥ 5 by the verifier's reading. With √3: χ = 3 iff d ≡ 1 (mod 3) … |",
    "L ≥ 5 by the verifier's reading; with MR, every entry with `L ≥ 5` has `χ ≥ 5`, and `= 5` at `L = 5` (row 123). With √3: χ = 3 iff d ≡ 1 (mod 3) … |")
rep("decide `group:u3:2+w4` (rank 8, no additive or periodic four-colouring found) at four colours:",
    "**five over ℚ(√3,√5) holds (row 123, given MR)**, so some finite graph over it is five-chromatic; decide `group:u3:2+w4` (rank 8, no additive or periodic four-colouring found) at four colours:")
# G48
rep("**Proved range:** L ≤ 4 over every real number field (row 99), L ≤ 5 over multiquadratic F ⊇ K (G55), and at ℚ(√47) (row 121; the K0 fields at their grade)",
    "**Proved range:** L ≤ 5 over every real number field (rows 99, 123; `L = 5` given MR, row 120)")
rep("next the L = 5 fields where four is proven, ℚ(√47) first (FS-84; FS-81 priced it), and ℚ(√167) at L ≥ 6 (FS-59)",
    "the `L = 5` fields are met (rows 121, 123), so the next is ℚ(√167) at L ≥ 6 (FS-59)")
# G54
ins_after("ratio `1/4 − 2.745·10⁻⁶`).",
    " **At four colours no stable place has an integrality gap** (row 123): a stable place's target is four-colourable iff its all-levels ratio is `≥ 1/4` — only `𝔽₃`, `𝔽₇`, dyadic inert `Q ≤ 32` and dyadic ramified — so slack everywhere and `L ≥ 5` are one condition.")
# G56 Do line, X26B, precision
ins_after("otherwise L is 2, 3, 4, 5 or ≥ 7 before any solver, and over any F ⊇ K it is 5 or ≥ 7.",
    " An exception field of row 100 (a stable dyadic place ramified in `F(i)/F`) has `L = 2`: never scope a claim at `L ≥ 3` by that exception (row 123).")
rep("(CaDiCaL, FS-54) — and **at Q = 64", "(CaDiCaL, FS-54; by an F₂-linear formula, X26B, and by no F₄-linear one at 4, 16) — and **at Q = 64")
rep("(five refused by certificate everywhere but 31: rows 69–71)", "(five refused by certificate everywhere but 31: rows 69–71; at 27 row 70's `α(Γ₂₇) ≤ 141 < 146`)")
# G64
rep("(row 52; the field-level step is row 57's gap, FS-47)", "(row 52; row 57's gap is the kernel's, not the mathematics': the localisation at a prime is a DVR in every number field)")
# G76
rep("and at ℚ(√47) no such spectrum exists (row 113).",
    "and at ℚ(√47) no such spectrum exists (row 113); given MR, over the type-(B) fields every rotation-invariant random four-colouring is a pullback and row 88 ⟺ no rigid-motion-transient colouring (row 124); the translation-invariant half is TR-ROT; a transient colouring is invisible to every measure method.")
rep("never search for its falsifier; when a group of multipliers",
    "never search for its falsifier; never write 'row 88 ⟺ Q-tr' (row 124); when a group of multipliers")
# G79
rep("the colouring flip GAP'd at QTCA_{1/3} (row 122).*",
    "the colouring flip GAP'd at QTCA_{1/3} (row 122); FS-100 wave 3: the class theorem and SP-Cor in every degree from an example invariant (the independence-ratio profile every colour class obeys, place by place); the no-gos (B-3, C-4, TR-ROT) from counterexample invariants; X27 flips TR-ROT.*")
# G72
rep("the structural form produced the consumer statements and the example invariant (row 122).",
    "the structural form produced the consumer statements and the example invariant (row 122); its wave 3 transferred by extending held tools field by field (row 123).")
# G80
rep("(only row 100's exception fields are uncovered)", "(row 100's exception fields are uncovered for MR; they have `L = 2`, so no colouring consequence is lost, row 123)")
# ledger pointer
rep("**Rows 1–122 live in `LEDGER.md`**", "**Rows 1–125 live in `LEDGER.md`**")
open(p,"w",encoding="utf-8").write(t); print("ok")
