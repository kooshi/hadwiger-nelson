#!/usr/bin/env python3
"""FP stage 2: CLOSED-QUESTIONS.md §3 — D7 (absoluteness entry, LW3's print addresses), D5 (GS Conjecture 1), D2 (Kainen), D1
(Polymath 2021), D4 (Erdős's band question, closed by others). Each old string asserted to occur once."""
from pathlib import Path

def once(text, old, new, where):
    n = text.count(old)
    assert n == 1, f"{where}: old string occurs {n} times: {old[:80]!r}"
    return text.replace(old, new)

p = Path("CLOSED-QUESTIONS.md"); t = p.read_text(encoding="utf-8")

# D7
t = once(t,
    "Shelah–Soifer 2003, epilogue (\"…precisely because the answer depends upon the system of axioms we choose for set theory?\");",
    "Shelah–Soifer 2003, epilogue (\"…precisely because the answer depends upon the system of axioms we choose for set theory?\"; in the "
    "journal as `[ShelahSoifer2003b]` p. 45);", "D7a")
t = once(t,
    "and absoluteness a ZF + DC audit of the chain (FS-104; a reading, not claimed).",
    "and absoluteness a ZF + DC audit of the chain (FS-104; a reading, not claimed). `[Soifer2007]` p. 86 prints, with no proof, "
    "*\"Chromatic Number of the Plane Theorem. In ZFS the chromatic number of the plane is 5, 6, or 7.\"* (ZFS is ZF + DC + LM, p. 86); "
    "since `[deGrey2018]` the value with full choice also lies in {5, 6, 7}, so that example no longer separates the two systems. Link 2's "
    "use of choice sits in de Bruijn–Erdős alone, its averaging needing only ZF + DC (a reading, one mind: the consolidation run's LW3), "
    "so given MR absoluteness is the null-set step done without choice.", "D7b")

new_entries = (
    "- **A probabilistic de Bruijn–Erdős theorem.** `[GwynStavrianos2022]` p. 24: *\"Conjecture 1. pk (G) = qk (G) for general graphs G. By "
    "consequence, pk = qk.\"* — `p_k(G)` the least worst-edge probability of a monochromatic edge over random `k`-colourings of `G`"
    " (Definition 13, p. 22), `q_k(G)` the best lower bound from summable edge weights (Definition 12, p. 21), equal on finite graphs (their "
    "Theorem 9, p. 23); *\"the conjecture represents a full probabilistic analogue of the de Bruijn-Erdős theorem\"* (p. 24). **Answered at "
    "[hand] in its Definition-13 form** (two minds, not blind: the consolidation run's LW and LW2): the probability measures on `{1..k}^V` "
    "are weak-* compact, and the sets of those giving every edge of a finite `F` monochromatic probability at most `sup_F p_k(F)` are "
    "closed, non-empty (Theorem 9) and have the finite intersection property. **Not answered:** its *\"By consequence, pk = qk\"* for the "
    "plane, which also rests on their Theorem 7 (p. 22), whose proof exchanges a finitely additive mean with an expectation with no Fubini "
    "theorem behind it (a gap, two readers). **Not kernel-checked.**\n"
    "- **Is the chromatic number of the plane robust?** `[Kainen1992]` p. 35: *\"(2) CONJECTURE. The chromatic number of the plane is "
    "robust.\"* Robustness, p. 34: *\"The robustness of f for (M,r) is largest u for which f(G(M, (-u + r, u + r))) = f(G(M,r)), where f is "
    "any graph invariant (e.g., chromatic number or clique size); f is robust if it has positive robustness.\"* His Theorem 1 (p. 34) "
    "colours the band graph `G(u)` with Isbell's seven colours for `u ≤ (√7 − 2)/(√7 + 2)`. **Reduced, not answered** [hand; the "
    "consolidation run's LW2, checked by FP]: every `G(u)` contains a closed band, so `χ(G(u)) ≥ 7` by `[Voronov2023]` Thm 1.1 (verified, "
    "`LEDGER.md` row 132); with his Theorem 1 the conjecture holds iff `χ(ℝ²) = 7` — posed in 1992, the bold form in other words. Its "
    "measurable analogue is row 131's question, `lim µ₆(ε) < 1`. **Not kernel-checked.**\n"
    "- **Can Thomassen's six-colour theorem be strengthened by allowing the unit-radius tactic?** `[Polymath2021]` p. 199: *\"Our failure to "
    "discover 6-tilings of larger disks motivates hope that one might be able to strengthen the seminal result of Thomassen [11], who "
    "showed that the plane cannot be tiled with six colors if the distance between adjacent tiles of the same color is strictly greater "
    "than 1, i.e. we prohibit tilings in which either (i) some unit-diameter circle encloses two same-colored tiles, or (ii) the "
    "unit-radius tactic is employed. It may be possible to eliminate criterion (ii) via an exhaustive computer search of all "
    "possibilities, but this has, as yet, remained beyond our reach.\"* The tactic, p. 194: *\"a tile T of color 1 can share a boundary "
    "segment E with a tile U of color 2 and also a point P with a tile V also of color 2, if E is drawn as an arc of radius 1 centered on "
    "P.\"* (both quotations two readers, the consolidation run's LW and LW2). **Answered in the complementary direction only:** row 134 "
    "drops criterion (i) and forbids every radius-1 arc (Condition 5), for segment-and-arc maps almost everywhere — a case the paper does "
    "not ask, incomparable with Thomassen's theorem (§2.8). FS-112's NO (`plans/STUB-unit-arc-half.md`) would answer the question as posed "
    "for locally finite segment-and-arc tilings, whatever reading of (i), since FS-112 forbids neither (i) nor (ii); outside that class "
    "(the paper's tiles are bounded by closed curves, p. 191) FS-112 is silent. The one exact known positive with the tactic is "
    "`[AxenovichEtAl2014]` Thm 4.2's six-coloured strip of height `√15/2 + √3`; the paper's six-tiled disk (Fig. 10, p. 200) prints no "
    "coordinates (LW2). **Not kernel-checked; nothing claimed.**\n")
t = once(t, "- *Checked, and not listed (no poser found):*", new_entries + "- *Checked, and not listed (no poser found):*", "D5/D2/D1")

# D4: after the Benda–Perles "Closed by others" bullet, before the d(6) = 1 entry
erdos = (
    "- *Closed by others, listed so it is not re-closed:* **Erdős's band question**, as `[BrownDunfieldPerry1994]` p. 113 quote it (their "
    "[1], Erdős 1985): *\"Let G be the graph formed by connecting all the pairs of points (a, b) in E² where the distance between a and b is "
    "between α and β, where α < 1 < β. Then what is the chromatic number of G, denoted h(2, α, β)?\"* They printed *\"h(2, α, β) ≥ 6 for all "
    "α, β\"* (from their Theorem 9's proof) and `≤ 7` for some; `[Voronov2023]` Thm 1.1 gives `h(2, α, β) ≥ 7` for every band, and it is 7 "
    "for every band inside `(1 − u, 1 + u)`, `u ≤ (√7 − 2)/(√7 + 2)` (`[Kainen1992]` Thm 1; `[Voronov2023]` Cor. 1.1). The answer is "
    "Voronov's; `LEDGER.md` row 132 verifies his proof after local repairs.\n")
t = once(t, "- **`d(6) = 1`** — `[deGreyParts2022]` §4 asks whether a", erdos + "- **`d(6) = 1`** — `[deGreyParts2022]` §4 asks whether a", "D4")
p.write_text(t, encoding="utf-8")
print("CLOSED-QUESTIONS applied")
