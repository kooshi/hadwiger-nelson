import sys; sys.path.insert(0, sys.argv[1]); from items import replace_items
NEW={
1:"""1. **The 4/5 wall is 2-adic.** A unit-distance graph forces a fifth colour only if its coordinates break the
   2-adic wall (G1, G35).""",
3:"""3. **The design target has no instance** (G48, row 66): a pair forced equal at five colours over a 5-sealed field, spindled into a
   6-open field, is refused **by theorem** over every 5-sealed multiquadratic F ⊇ K — Γ₁₁'s fan gap frees every pair above it. FS-6 is
   dead; a 6-forcer's compulsions all live in 6-open fields. The frame that replaces it is **tight or slack** (G54, row 87).""",
8:"""8. **The type-M rotations are a classified one-integer family** (G7): `cos θ = (2n−1)/(2n)`, the spindle at distance `√n`; its member
   `n = 16`, the `ρ₆₃` arena, is **5-chromatic in the 6-open field K(√7)**, produced rather than inherited (row 64) — not the first 6-open
   platform (de Grey's own field is, G43) but the smallest, degree 8 against 16, and reached by the screen rather than found.""",
11:"""11. **The window for six, and who can see it** (G56, G59; rows 68–71). Six colours on a usable plane Γ_q are possible only in a
   five-member window (six is refused from 59 up), none decided, so **a single verified six-colouring at 23, 27, 43 or 47
   would be the first exactly six-chromatic finite Euclidean plane**. No field containing K can use any member, so **six is
   arithmetically excluded for every field the hunt has built in**. The window decides whether six is *reachable by the residue
   method*; its sharp target is fractional, α < q²/6 (G59).""",
14:"""14. **Real quadratic fields: three colours are decided, and four is a theorem of the family** (G61, G74, G65; rows 72–74, 79, 82–84).
   **The plane over any subfield of ℝ needs four once 1/3 lies in its unit-vector ring and it has an odd cycle** [hand, two independent derivations; row 82]
   — so every squarefree d ≡ 11 (mod 12) needs four (T4); **nothing is claimed new while `[Johnson2000]` and `[Johnson2006]` are unread**.
   **The census is complete** (row 83); ℚ(√47)'s bracket (item 10) cannot close from above by residues at any depth (§1.7, row 75). Over a
   number field three colours ask for a prime above 3 of residue field 𝔽₃, not for 1/3 (row 99, G74).""",
15:"""15. **Six may be a value no field attains — a claim stronger than χ(ℝ²) ≠ 6, not equivalent to it** (G64, FS-62): the wall at six
   (G56, G59) decides the value set of L and whether the conjecture predicts 6 or 7 at ℚ(√167); six hides only in the gap between L(F)
   and χ(F²), where every ceiling we own is silent but FS-64. Six being skipped is *not* evidence for seven.""",
17:"""17. **The residue ceiling does not drop up the tower where it can be certified** (G66, row 75): at 7, 11, 19, 23 no level reads
   lower than level one, so `UD(ℤ/529, 2)` cannot five-colour ℚ(√167)'s plane, `α(Γ₂₃) ≤ 97`, and χ_Bor of the `p`-adic plane is
   unbounded in `p` (`CLOSED-QUESTIONS.md` §1.8). That the ratio is exactly constant is **not proved** (FS-68).""",
18:"""18. **Where a five-forcer can live in a field is decided on finite quotients `Λ/NΛ`, and over ℚ(√3,√5) it is nowhere dense** (G68,
   G69, row 76): a lattice is rigid — the chain route's fabric — only where every odd prime's periodic target refuses; no lattice of
   rank ≤ 6 over ℚ(√3,√5) does, the rank-8 one is undecided (FS-72). **Not landed: five over ℚ(√3,√5).** **Over K the question is
   closed**: `F = P = 8Λ` on de Grey's lattice (rows 78, 85; item 23), and every four-colouring of `K²` is, per coset, local at one
   dyadic place, `F(R_K) = 4R_K` (row 89).""",
24:"""24. **Over the triangle-free fields ℚ(√59), ℚ(√83), ℚ(√131) one pair decides four-colour rigidity, and every natural way to break it fails**
   (rows 88–94, 96, 111–113, G76): the plane is rigid iff `(0, 4)` is forced (row 88) — **undecided**; the plane over `ℚ₂(√3)` is rigid (row 90), so the
   question is realising a local forcer without triangles. Every construction of a "no" that reads finitely much, and **every character
   colouring**, is excluded (rows 91–92, 96: HD1 holds); a "no" is transient or reads infinitely many split places (rows 111–112), and
   transience stops at two named steps (FS-98). ℚ(√2,√3), its member with triangles, is rigid given Heule's T721 (row 93). Toward six only
   through Soifer 55.1 (row 86).""",
26:"""26. **Character colourings are local in the existence sense** (rows 100–101, G77): a real number field's plane has a character `k`-colouring
   iff some residue target does, so a falsifier of the conjecture is no character at `k ≤ 5` (FS-83 answered) or over a quadratic field;
   given CLG the window is closed to characters (8 colours on Γ₂₃, 9 on Γ₄₃; the exposed fields: G64). That every character colouring is
   local is proved only at three colours (row 99) and at HD1's fields.""",
27:"""27. **Rank one at four colours, and windows at five over ℚ(√167)** (rows 108–110, G78, G76; M3, `plans/M3-derivation.md`). FS-76's
   rank-one question is *countable ⟹ finite* for four-colouring shifts of distance graphs on ℤ — **not landed**, stalled at one step by
   three minds. At five colours a factor leaves a product colouring when it **mixes**, not when its ratio is small, so the window question
   over ℚ(√167) lives at nine places; nothing touches `χ_µ(ℝ²)`.""",
}
replace_items(NEW)
