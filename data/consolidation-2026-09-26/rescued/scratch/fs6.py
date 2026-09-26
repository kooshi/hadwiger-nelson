p="/home/kooshi/source/lean-dir/plans/FRONTIER-STUBS.md"
t=open(p,encoding="utf-8").read()
def rep(old,new):
    global t
    n=t.count(old); assert n==1,(n,old[:90]); t=t.replace(old,new)
# open milestones
rep("**FS-100 stage 5 (the ×2×3 crunch) — CLOSED** (",
    "**FS-100 stage 5, wave 3 — CLOSED** (`LEDGER.md` rows 123–125; `plans/FS100-three-field-lemma.md` §R-close (stage 5, wave 3), `plans/FS100-derivation.md` §4; FS-101 minted at rank 3′), **Paid (theorem)**: `χ(F²) = L(F)` for `L ≤ 5` over every real number field (given MR), `χ(ℚ(√3,√5)²) = 5`, the type-(B) fields' rotation-invariant half, six at ℚ(√167) reduced to `χ_CP(ℝ²) ≥ 6 ∧ PL_∃(23, 43)`, [hand]; prior-art gate negative (X24R); TR-ROT under attack at the close (X27). **FS-100 stage 5 (the ×2×3 crunch) — CLOSED** (")
rep("**Paid (theorem)**: MR proved and `χ(ℚ(√47)²) = 5`, [hand], prior-art gate pending (X24R); the flip not landed, ED-2 false.",
    "**Paid (theorem)**: MR proved and `χ(ℚ(√47)²) = 5`, [hand]; prior-art gate negative (X24R); the flip not landed, ED-2 false.")
# ranked-stubs note
rep("*At FS-100 stage 5's close (2026-09-26, X10F) no rank moved:",
    "*At FS-100 stage 5 wave 3's close (2026-09-26, X30F): **FS-101 minted at rank 3′** (the kernel port of row 123; its rank is Kooshi's, the default just below FS-100, and the prime keeps every other rank number); no other rank moved: FS-100 (3), FS-59 (1), FS-98 (8), FS-48 (16) and FS-72 (20) updated from X29C's drafts, FS-84 (4) unchanged beyond its stub's answered banner.*\n\n*At FS-100 stage 5's close (2026-09-26, X10F) no rank moved:")
# FS-59
rep("so `χ(ℚ(√167)²) ≥ 5` at K0's grade (row 121); six waits on J39's T-J39-5 and its two lemmas.",
    "so `χ(ℚ(√167)²) ≥ 5` — **by two routes (row 123)**; six contains `χ_CP(ℝ²) ≥ 6 ∧ PL_∃(23, 43)` (row 125, which makes J39's T-J39-5 exact) — both conjuncts open, no density bound can give the first.")
rep("predicted ≥ 6 against a proven 4 (in the kernel, row 119) and ≥ 5 at K0's grade (row 121);",
    "predicted ≥ 6 against a proven 4 (in the kernel, row 119) and ≥ 5 (row 123);")
# FS-100
rep("MR proved (row 120), `χ(ℚ(√47)²) = 5` (row 121), [hand], prior-art gate pending (X24R); row 88 ⟺ T-B1; `χ(ℚ(√167)²) ≥ 5` at K0's grade; the flip not landed, ED-2 false (row 122). **Left:** the value's prior-art gate and EL2021 §2; MR at row 100's exception fields; X11K's kernel port; stage 4′ moot for ℚ(√47); P1 (post-ban) is FS-84's re-aim |",
    "MR proved (row 120), `χ(ℚ(√47)²) = 5` (row 121), [hand]; row 88 ⟺ T-B1; the flip not landed, ED-2 false (row 122). **At wave 3's close (`LEDGER.md` rows 123–125):** `χ(F²) = L(F)` for `L ≤ 5` over every real number field (row 123), the type-(B) rotation-invariant half (row 124), six at ℚ(√167) reduced (row 125) — [hand]; prior-art gate negative (X24R). **Left:** TR-ROT (under attack at the close: X27); C-4 (transience); MR at row 100's exception fields (no colouring consequence: they have `L = 2`); MR's complex-place case on an instance; the kernel port (FS-101); stage 4′ moot for ℚ(√47); P1 (post-ban) is FS-84's re-aim |")
rep("stage 5 closed 2026-09-26 (rows 120–122), re-aimed |", "stage 5 closed 2026-09-26 (rows 120–122), re-aimed; wave 3 closed 2026-09-26 (rows 123–125) |")
# FS-101 row after FS-100's
lines=t.split("\n")
idx=[i for i,l in enumerate(lines) if l.startswith("| 3 | **FS-100 ")]
assert len(idx)==1
lines.insert(idx[0]+1, "| 3′ | **FS-101 the main clause through five in the kernel** — `plans/STUB-main-clause-five-kernel.md` (minted 2026-09-26 by X29C at wave 3's close; rank Kooshi's, default just below FS-100) | Kooshi's target (06:5x): *\"The target for the Lean implementation should move to the more general 'every real' claim.\"* X11K2's skeleton `X11K.min_localBound_five_le_chromaticNumber` states `min(L(F), 5) ≤ χ(F²)` for every real number field over named inputs; `χ(ℚ(√47)²) ≤ 5` is sorry-free. Next: gate into `Proofs/`, `posDef_corr`, the upper half from row 52 and the stable-prime valuation subring (row 57's gap), then which inputs to build and which to keep as interfaces | none; the conjecture's proved range to the kernel's word | priced in the stub (X11K's and X11K2's prices) | minted 2026-09-26 | none (a kernel port) |")
t="\n".join(lines)
# FS-98
rep("T-B1 alone — row 88 ⟺ T-B1 (T-J38-2; MR held, row 120); T-B2 demoted, T-B1 ⟹ Q-tr ⟹ T-B2.",
    "T-B1 alone — row 88 ⟺ T-B1 (T-J38-2; MR held, row 120); T-B2 demoted, T-B1 ⟹ Q-tr ⟹ T-B2. **TR-ROT** beside T-B1 — 'no translation-invariant non-pullback colouring measure has every `U`-Følner average converge onto the pullbacks' (row 124; X22V §3.3) — T-B1 ⟹ TR-ROT; X27D/X27V attacked it at the close.")
# FS-48
rep("what remains is the four- and five-colour table.",
    "what remains is the four- and five-colour table; with MR, every entry with `L ≥ 5` has `χ ≥ 5`, and `= 5` at `L = 5` (row 123); the table is now `L(F)` alone up to five.")
# FS-72
rep("| Decide `group:u3:2+w4` (rank 8, 324 unit vectors;",
    "| **Five over ℚ(√3,√5) holds (row 123, given MR)**, so some finite graph over it is five-chromatic: the lattice's question is now whether that graph lives on `group:u3:2+w4` (post-ban), P-X23D-1's explicit form. Decide `group:u3:2+w4` (rank 8, 324 unit vectors;")
# closed list
rep("* **FS-100 stage 5 (the ×2×3 crunch)** — `plans/STUB-measure-rigidity-three-fields.md`. **Closed 2026-09-26**",
    "* **FS-100 stage 5, wave 3 (the ×2×3 crunch)** — `plans/STUB-measure-rigidity-three-fields.md`. **Closed 2026-09-26**, the milestone kept open at rank 3 (record `plans/FS100-three-field-lemma.md` §R-close (stage 5, wave 3); `plans/FS100-derivation.md` §4; close inventory `plans/FS100-x2x3-wave3-close-inventory.md`; queue `plans/CRUNCH-2026-09-26-x2x3-queue.md` §7; `LEDGER.md` rows 123–125): `χ(F²) = L(F)` for `L ≤ 5` over every real number field given MR (row 123), the type-(B) fields' rotation-invariant half (row 124), six at ℚ(√167) reduced (row 125); FS-101 minted; **Paid (theorem)**, [hand]; prior-art gate negative (X24R).\n* **FS-100 stage 5 (the ×2×3 crunch)** — `plans/STUB-measure-rigidity-three-fields.md`. **Closed 2026-09-26**")
rep("the flip's GAP and ED-2 false (row 122); **Paid (theorem)**, [hand], prior-art gate pending (X24R).",
    "the flip's GAP and ED-2 false (row 122); **Paid (theorem)**, [hand]; prior-art gate negative (X24R).")
open(p,"w",encoding="utf-8").write(t); print("ok")
