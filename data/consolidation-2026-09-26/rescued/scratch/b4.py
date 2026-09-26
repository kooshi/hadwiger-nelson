import sys; sys.path.insert(0, sys.argv[1]); from items import replace_items
P="/home/kooshi/source/lean-dir/CLAUDE.md"
t=open(P).read()
R=[
("| FS-48 the ℚ(√3,√d) table — `plans/STUB-biquadratic-table.md` | **re-aimed at FS-91's close:** three colours decided",
 "| FS-48 the ℚ(√3,√d) table — `plans/STUB-biquadratic-table.md` | three colours decided"),
("| a full prior-art session in the vocabulary of coincidence site lattices, Moiré superlattices and aperiodic order (G62): does that literature already hold the rotation screen, the index arithmetic, or a colouring theory for planar modules? … | none directly; free classification theorems if they exist, the negative if they do not, and the paper's second-discipline vocabulary (FS-20) |",
 "| a prior-art session in the vocabulary of coincidence site lattices, Moiré superlattices and aperiodic order (G62): does it already hold the rotation screen, the index arithmetic, or a colouring theory for planar modules? … | none directly; free classification theorems or the negative, and the paper's second-discipline vocabulary (FS-20) |"),
("| none directly; mechanism — whether `L(F)` is the right invariant or must become its all-levels form, and the first exact density of a `p`-adic plane |",
 "| none directly; mechanism — whether `L(F)` must become its all-levels form |"),
("which vertices of the ρ₆₃ arena are frozen in every five-colouring? A vertex with a free colour in some five-colouring is forced to nothing (row 66 against the graph itself) … | medium as an instrument — explains H4's null by theorem or hands the hunt its first frozen material in a 6-open field; two-sided |",
 "which vertices of the ρ₆₃ arena are frozen in every five-colouring? … | medium as an instrument — explains H4's null by theorem or hands the hunt its first frozen material in a 6-open field |"),
("— `α < ⌈q²/6⌉` closes a wall member outright (G64); closes, never opens; FS-57's target from the other side |",
 "— `α < ⌈q²/6⌉` closes a wall member outright (G64); FS-57's target from the other side |"),
("side digit five refused at 31 (which now has three named consumers … | **none on χ(ℝ²), as its stub says; idle compute only**",
 "side digit five refused at 31 … | **none on χ(ℝ²); idle compute only**"),
# the mission's (2)
("The conjecture is proved for L ≤ 4 over every real number field (row 99) and\nL ≤ 5 for multiquadratic F ⊇ K (G55). Its remaining *testable* range is L = 5 outside that class (FS-84, FS-48), then",
 "Its proved range is item 10's; its remaining *testable* range is L = 5 outside it (FS-84, FS-48), then"),
("ℚ(√47) the cheapest (FS-81 priced a refusal there and did not land it, row 84; FS-84; no character four-colouring, row 96)",
 "ℚ(√47) the cheapest (row 84, FS-84; no character four-colouring, row 96)"),
("at discriminant 668 (characters need eight there, given CLG, row 101)",
 "at discriminant 668 (characters need eight there, row 101)"),
# the reframe paragraph
("entries are written to be reasoned from, not looked up: each ends with what it makes you do and what would kill it (G67). These entries are the most important prior art this project holds; they are in context so that they are used, and a plan\nthat reasons from the literature's analogies while they sit unread has used them as background. FS-70 is the instance: G54's classifier, G16/G32's\npigeonhole form and G40's absorption each bore on it and none was run until asked for.***",
 "entries are written to be reasoned from, not looked up, each ending in G67's form. These entries are the most important prior art this project holds; they are in context so that they are used, and a plan\nthat reasons from the literature's analogies while they sit unread has used them as background (FS-70 is the instance, `WORKFLOW.md` § Why).***"),
]
for a,b in R:
    assert t.count(a)==1, a[:80]
    t=t.replace(a,b)
open(P,"w").write(t)
NEW={
4:"""4. **Existing witnesses hold nothing to extract — on sealed objects by theorem, on 6-open ones by measurement** (G31; rows 43, 66). De
   Grey's 1581 and the `ρ₆₃` arena sit in **6-open** fields, where no residue target exists, so their nulls stay measured and
   unexplained: a χ ≥ 6 gadget must be constructed, not found.""",
10:"""10. **The conjecture's proved range** (G55; GPT Astra, hand, read here): χ(F²) = L(F) for every real number field with **L ≤ 4**
   (row 99, [hand, three derivations]; G74), and, given the measured 8/3 forcer, for every multiquadratic F ⊇ K with L ≤ 5, by the chain
   theorem. Its exposed predictions are the target's (§ The mission): the cheapest, four for ℚ(√11) and ℚ(√23), are met (row 73); at
   ℚ(√47) (L = 5: 3 and 7 unusable, 11 usable) it predicts exactly five against a proven 4 ≤ χ ≤ 5 — open (row 84; FS-84), and a
   four-colouring there would carry an invariant measure whose spectrum is carried by no `T + A + Fin_S`, `S` finite (row 113). With every
   residue level allowed, `L` is unchanged at 7, 11, 19, 23 (row 75, G66).""",
}
replace_items(NEW)
