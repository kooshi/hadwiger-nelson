P="plans/FRONTIER-STUBS.md"; T=open(P,encoding="utf-8").read()
def one(old,new):
    global T
    assert T.count(old)==1,(T.count(old),old[:80]); T=T.replace(old,new)
# open milestones
one("**One milestone is open: FS-84** (ℚ(√47): five colours, rank 4; `plans/FS84-five-colours-47.md`): S1, its derivation, and S1V, its blind verification, are done (`plans/FS84-S1-derivation.md`, `plans/FS84-S1V-verification.md`); its next stages run from 2026-10-01. **FS-75's",
    "**One milestone is open: FS-84** (ℚ(√47): five colours, rank 4; `plans/FS84-five-colours-47.md`): its question is **answered** by FS-100 stage 5 (`LEDGER.md` row 121); S1, its derivation, and S1V, its blind verification, are done (`plans/FS84-S1-derivation.md`, `plans/FS84-S1V-verification.md`); its remaining stages (S2 onward, from 2026-10-01) are re-aimed toward an explicit triangle-free five-chromatic graph over ℚ(√47) (Soifer 55.1 as posed) — the owner's ruling; Kooshi may close it instead. **FS-100 stage 5 (the ×2×3 crunch) — CLOSED** (`LEDGER.md` rows 120–122; G80; `plans/FS100-three-field-lemma.md` §R-close (stage 5), `plans/FS100-derivation.md` §3; the stub re-aimed, rank 3; FS-97's banner), **Paid (theorem)**: MR proved and `χ(ℚ(√47)²) = 5`, [hand], prior-art gate pending (X24R); the flip not landed, ED-2 false. **FS-75's")
# ranked-stubs note
one("*At FS-100's in-ban close and FS-75's minimal-instance close (2026-09-26, J55) no rank moved:",
    "*At FS-100 stage 5's close (2026-09-26, X10F) no rank moved: FS-100 (rank 3) re-aimed (MR proved, row 120), FS-84 (4) answered and re-aimed (the owner's ruling), FS-59 (1), FS-98 (8) and FS-64 (12) updated, FS-97 (13) answered in its banner; the quantitative-T-C(A) candidate drafted at the close (§R-close (stage 5) 4.4) is not minted (held for Kooshi).*\n\n*At FS-100's in-ban close and FS-75's minimal-instance close (2026-09-26, J55) no rank moved:")
# FS-59 row
one("FS-59's own χ ≥ 5 waits only on MR (T-J39-4)\" — MR is FS-100's lemma. |",
    "FS-59's own χ ≥ 5 waits only on MR (T-J39-4)\" — MR is FS-100's lemma. **At FS-100 stage 5's close:** MR is held (row 120), so `χ(ℚ(√167)²) ≥ 5` at K0's grade (row 121); six waits on J39's T-J39-5 and its two lemmas. |")
one("| **the conjecture's widest gap** — predicted ≥ 6 against a proven 4; a five confirms",
    "| **the conjecture's widest gap** — predicted ≥ 6 against a proven 4 (in the kernel, row 119) and ≥ 5 at K0's grade (row 121); a five confirms")
# FS-100 row
one("FS-84 keeps its search stages; **FS-97 absorbed** (owner ruling) | none directly: a four-colouring of ℚ(√47)² falsifies the five-clause, five confirms it;",
    "FS-84 keeps its search stages; **FS-97 absorbed** (owner ruling). **At stage 5's close (the ×2×3 crunch, 2026-09-26; `LEDGER.md` rows 120–122; the stub's status block):** MR proved (row 120), `χ(ℚ(√47)²) = 5` (row 121), [hand], prior-art gate pending (X24R); row 88 ⟺ T-B1; `χ(ℚ(√167)²) ≥ 5` at K0's grade; the flip not landed, ED-2 false (row 122). **Left:** the value's prior-art gate and EL2021 §2; MR at row 100's exception fields; X11K's kernel port; stage 4′ moot for ℚ(√47); P1 (post-ban) is FS-84's re-aim | none directly: ℚ(√47)'s five-clause is met (row 121);")
one("| minted; stages 0–4 run, in-ban round closed 2026-09-26 (rows 116–118), stage 4 re-aimed as 4′; FS-97 absorbed |",
    "| minted; stages 0–4 run, in-ban round closed 2026-09-26 (rows 116–118), stage 4 re-aimed as 4′; FS-97 absorbed; stage 5 closed 2026-09-26 (rows 120–122), re-aimed |")
# FS-84 row
one("its spectral measure carried by `T + A + Fin_S` for a finite set `S` of split places" if False else "(row 113; the remainder is FS-97's). |",
    "(row 113; the remainder is FS-97's). **At FS-100 stage 5's close: answered** — `χ(ℚ(√47)²) = 5` (row 121), [hand], prior-art gate pending (X24R); S2 onward (post-ban) re-aimed toward an explicit triangle-free five-chromatic graph over ℚ(√47) (Soifer 55.1 as posed) — the owner's ruling; Kooshi may close it instead. |")
one("**open**: S1 and S1V done (`plans/FS84-S1-derivation.md`, `plans/FS84-S1V-verification.md`), the later stages from 2026-10-01 |",
    "**open**: S1 and S1V done (`plans/FS84-S1-derivation.md`, `plans/FS84-S1V-verification.md`); answered at FS-100 stage 5 (2026-09-26), the later stages re-aimed, from 2026-10-01 |")
# FS-98 row
one("T-B1 alone — given MR, row 88 ⟺ T-B1 (T-J38-2; FS-100);",
    "T-B1 alone — row 88 ⟺ T-B1 (T-J38-2; MR held, row 120);")
# FS-64 row
one("open at FS-100's stage 4′; at five colours the co-normal mechanism is unavailable there (the stub's head block).",
    "open at FS-100's stage 4′; at five colours the co-normal mechanism is unavailable there (the stub's head block). **At FS-100 stage 5's close:** moot at ℚ(√47) (row 121).")
# FS-97 row
one("is MR, R-U, T-B1 and SP-Cor there. Kept at its rank so the numbering stands |",
    "is MR, R-U, T-B1 and SP-Cor there — **answered at FS-100 stage 5** (MR, row 120; the banner); at type (B) only T-B1 remains (FS-98). Kept at its rank so the numbering stands |")
# closed list: add stage 5 before the in-ban entry
one("* **FS-100's in-ban round** — `plans/STUB-measure-rigidity-three-fields.md`. **Closed 2026-09-26**,",
    "* **FS-100 stage 5 (the ×2×3 crunch)** — `plans/STUB-measure-rigidity-three-fields.md`. **Closed 2026-09-26**, the milestone kept open at rank 3, re-aimed (record `plans/FS100-three-field-lemma.md` §R-close (stage 5); `plans/FS100-derivation.md` §3; close inventory `plans/FS100-x2x3-close-inventory.md`; queue `plans/CRUNCH-2026-09-26-x2x3-queue.md`; `LEDGER.md` rows 120–122; G80): MR(F) for every real number field with `R = O′` (row 120), `χ(ℚ(√47)²) = 5` (row 121), the flip's GAP and ED-2 false (row 122); **Paid (theorem)**, [hand], prior-art gate pending (X24R).\n* **FS-100's in-ban round** — `plans/STUB-measure-rigidity-three-fields.md`. **Closed 2026-09-26**,")
open(P,"w",encoding="utf-8").write(T); print("ok")
