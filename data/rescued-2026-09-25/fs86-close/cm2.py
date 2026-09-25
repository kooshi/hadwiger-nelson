p='CLAUDE.md'
s=open(p,encoding='utf-8').read()
def R(old,new):
    global s
    assert s.count(old)==1,(s.count(old),old[:80])
    s=s.replace(old,new)
# open milestones
R("**Open milestones, in order.** **None is open.** **FS-85 — can four-colour rigidity exist without triangles? — CLOSED 2026-09-24** (rows 85–87, G75; `plans/FS85-rigidity-without-triangles.md`, its §R-close first; `plans/FS85-derivation.md`; the stub carries the banner); FS-74 closed by it. **Next, Kooshi's choice (2026-09-25): FS-86, four-colour rigidity over ℚ(√59) and ℚ(√83)** (`plans/STUB-dyadic-rigidity-triangle-free.md`; routes 1–3 solver-free), in the finite-witness-free week to 2026-10-01 (§ Toolchain).",
  "**Open milestones, in order.** **None is open.** **FS-86 — four-colour rigidity over ℚ(√59) and ℚ(√83) — CLOSED 2026-09-25** (rows 88–94, G76; `plans/FS86-dyadic-rigidity.md`, its §R-close first; `plans/FS86-derivation.md`; the stub carries the banner); FS-85 closed before it (rows 85–87). **Next: a fresh advisor chooses, and Kooshi decides** (his words: \"the missing theorem, 2 hours of sanctioned search time, or something else\"): FS-89, FS-90, or another row, in the finite-witness-free week to 2026-10-01 (§ Toolchain).")
R("**Ranked stubs** (re-ranked 2026-09-24 at FS-85's close, one rank per row: FS-86, FS-87, FS-88 minted at ranks 2, 8, 15; FS-67 moved to 9 for its four-colour form; FS-59, FS-76, FS-80 re-aimed; G75 forwarded.",
  "**Ranked stubs** (re-ranked 2026-09-25 at FS-86's close, one rank per row: FS-86 closed; FS-89, FS-90 minted at ranks 2, 3; FS-59, FS-83, FS-84, FS-64, FS-67, FS-76, FS-87 re-aimed; G76 forwarded.")
R("R2.6 predicts no rigidity |", "R2.6 predicts no rigidity. **At FS-86's close:** no measurable window four-colouring exists here at all (row 92, one mind), but at five colours the window count fails at the real place (`m₁ ≥ 0.229 > 1/5`), so this question is untouched |")
R("at `k = 4` over ℚ(√47) its five-clause; from four colours up emptiness proves only that no character colouring exists (G71, G73). The plan-phase advisor's question; solver-free |",
  "at `k = 4` over ℚ(√47) its five-clause; from four colours up emptiness proves only that no character colouring exists (G71, G73). The plan-phase advisor's question; solver-free. **Re-aimed at FS-86's close:** at `k = 4` dead on type-(B) planes (finite type, row 91; every measurable window, row 92) and for measurable windows over ℚ(√47) (row 92); live at `k = 5` over ℚ(√167) and for characters of infinite type (FS-89) |")
R("a matched ball priced out (row 84). Next: P3b's exact `Θ₄` cells on the 10 (solver-free), the chain route on any that stays rigid, then D1's deep pass (SAT) |",
  "a matched ball priced out (row 84). Next: P3b's exact `Θ₄` cells on the 10 (solver-free), the chain route on any that stays rigid, then D1's deep pass (SAT). **At FS-86's close:** a four-colouring falsifying the five-clause cannot be a measurable window colouring over finitely many places (row 92, one mind) |")
R("`P = F` now holds on de Grey's lattice by derivation (row 85) |",
  "`P = F` now holds on de Grey's lattice by derivation (row 85); at the field level over type-(B) fields Kempe swaps, patchworks and half-space defects cannot break inheritance (row 91), and `P(R) ≠ F(R)` there would be a four-colour inheritance failure on a non-finitely-generated abelian Cayley graph |")
R("then the theorem as a conditional one with (S″) named; dB2 as a small instance |",
  "then the theorem as a conditional one with (S″) named; dB2 as a small instance; **FS-86's candidates:** `ℤ[T] = O` (W1) and Theorem A by W's route (row 90), the K classification (row 89), Lemma R (with FS-47), C12.1 (row 93) |")
R("the four originals unread (`BIBLIOGRAPHY.md` § R.4) |",
  "the four originals unread (`BIBLIOGRAPHY.md` § R.4). **Re-aimed at FS-86's close:** `[Zhang2012]` Thm 1.8(i) answers the main case for vertex-transitive factors with a strict ratio inequality (row 88); what is left is the equal-ratio case (tightness decides it, row 89) and the integrality gap `χ_f(H) ≤ k < χ(H)` |")
R("Its one-place, windowless case — one character colouring the whole field — is FS-83 |",
  "Its one-place, windowless case — one character colouring the whole field — is FS-83. **At FS-86's close:** with any finite set of places and measurable windows it cannot four-colour a type-(B) plane non-periodically (row 92); its five-colour aim at ℚ(√167) is untouched |")
open(p,'w',encoding='utf-8').write(s)
print(len(s.encode()))
