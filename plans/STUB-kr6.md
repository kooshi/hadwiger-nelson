# FS-77 — KR6: is de Grey's lattice with the ρ₁₅ orbit four-colourable? (stub)

*Minted 2026-09-23 at FS-73's close, from `plans/FS73-derivation.md` T34 (implementer F, phase P4). Rank 6: one object, priced.*

> **FS-79's verdict (2026-09-24): not reached.** FS-79 named KR6 as an open instance (§IQ item 5) and did not decide it. By G73, no
> cell-local topological invariant will certify its four-colourability either way; a window-frequency LP (FS-80) or a periodic colouring
> with `W ⊇ 8Λ_dG` is what could.

## The object and the question

**KR6** is de Grey's lattice over K plus the ζ₆-orbit of `ρ₁₅` — rank 6, 78 unit vectors, over K(√5) (`data/fs73/rank6/lattice-KR6.json`).
What is known (T34): `1/4, 1/3 ∈ KR6`, so `N = 2, 3, 4, 6` are inadmissible; a `5·KR6`-periodic colouring would restrict to a
`5Λ_dG`-periodic one, which de Grey's lattice refuses; so **KR6 has no periodic colouring at any `N ≤ 6`**; forcing is monotone upward, so
`F ⊇ 8Λ_dG` and KR6 has no gapped colouring; `KR6/Λ_dG ≅ ℤ² × (ℤ/4)²`; Heule-510's embedding is not inside it. **Its four-colourability
is open.**

Either answer is informative: **not four-colourable** is a five-chromatic lattice graph of rank 6 over K(√5), a field already known
five-chromatic (Heule-510), so a small object rather than a new bound; **four-colourable with no periodic colouring** is a C3-aper
counterexample at four colours (FS-76) on arithmetic fabric — the first anywhere.

## Routes, cheapest first

1. **Period groups `W ⊇ 8Λ_dG` that miss `U`** (P4's suggestion): a periodic colouring must be `W`-periodic for such a `W`; enumerate
   the admissible `W` by the index of `W ∩ Λ_dG`-compatible extensions and ask each quotient (the G68 screen).
2. **A ℤ² subshift over de Grey's colourings**: every four-colouring restricts on each `Λ_dG`-coset to one of the 9,120 colourings of
   `Λ_dG/8Λ_dG` (row 78; Hubai's count), so KR6's colourings are configurations of a ℤ² × finite subshift on 9,120 symbols with local
   rules from the `ρ₁₅` edges — decide it by transfer matrices or a finite-strip search.
3. **A ball and a solver** only after 1–2, aimed at degree ≥ 14 (G65).

## Provisional bearings

G68, G69 (rigid fabric plus a wall-breaking copy), G65, G21, G71 (four colours: no `Θ`), G62 and G7 (`ρ₁₅` is the type-M rotation at `n = 4`).
Row 78; FS73-T31–T35.

## Bearing on the answer

None on the answer: a question about periodic colourings of one lattice, which the direction does not use. On that programme: the
smallest place a four-colour C3-aper counterexample could be on arithmetic fabric — four-colourable with no periodic colouring would be
the first.
