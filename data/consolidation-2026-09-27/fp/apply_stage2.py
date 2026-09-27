#!/usr/bin/env python3
"""FP stage 2: LEDGER.md rows 106, 130, 131, 132, 134; plans/FS103-derivation.md FS103-M-EASY; plans/GROKKING-INSTANCES.md §G49.
Every replacement asserts its old string occurs exactly once (in the whole file, or inside the named row)."""
from pathlib import Path

def once(text, old, new, where):
    n = text.count(old)
    assert n == 1, f"{where}: old string occurs {n} times: {old[:80]!r}"
    return text.replace(old, new)

def row_edit(text, row, old, new):
    lines = text.split("\n")
    idx = [i for i, l in enumerate(lines) if l.startswith(f"| {row} | ")]
    assert len(idx) == 1, f"row {row}: {len(idx)} lines"
    lines[idx[0]] = once(lines[idx[0]], old, new, f"row {row}")
    return "\n".join(lines)

p = Path("LEDGER.md"); t = p.read_text(encoding="utf-8")

# C5 row 106
t = row_edit(t, 106,
    "**Prior art:** `[Parts2020hv]` §3 (human-verified); `FS85-V2-T5`; the kernel form ours.",
    "**Prior art:** `[Parts2020hv]` §3 (human-verified); `FS85-V2-T5`; `[Polymath16wikiProb]` Theorem 20's proof (a sketch) sorts the "
    "four-colourings of `ℤ[e^{πi/3}]` with no \"1tri\" hexagon into seven cases by their short rhombus diagonals with monochromatic long "
    "diagonal, three cases row by row — a neighbouring statement under a weaker hypothesis (the consolidation run's LW3); the kernel form ours.")

# C1 row 130
t = row_edit(t, 130,
    "the Rajchman step not searched (N) — a debt. **Naming:**",
    "the Rajchman step not searched (N) — a debt. The argument of the unconditional `χ(ℝ²) ≤ χ_m⁰(ℝ²)` (N-EASY) is in print as "
    "`[GwynStavrianos2022]` Lemma 2, Theorem 2 and Corollary 1 (p. 12), stated for badness under an invariant mean on E(2) (infimum 0 "
    "suffices, every colouring, quantitative `1/|E(G)|`); N-EASY follows with Haar averages in place of the mean, a step not printed "
    "(two readers, the consolidation run's LW and LW2). The averaging device is `[Polymath16wikiProb]`'s (2018–19), whose Lemmas 1–40 "
    "give the easy direction (`χ(ℝ²) ≤ χ_CP(ℝ²)`) for a finitely additive invariant random colouring by union bounds; the hard direction "
    "(an a.e.-proper measurable colouring to a CP one) is in neither. The null-set reduction's compactness step, de Bruijn–Erdős for list "
    "colourings by Tychonoff, is `[Johnson1994choice]` p. 125 (LW3). **Naming:**")

# C2 row 131
t = row_edit(t, 131,
    "(FS-107's gate); the Rajchman step not found in print. |",
    "(FS-107's gate); the Rajchman step not found in print. The step from a refutation to `χ(ℝ²) ≤ 6` is link 2's argument "
    "(`[GwynStavrianos2022]` Lemma 2 and Theorem 2, run with Haar averages; row 130), the holes filled with one colour, which leaves "
    "monochromatic unit pairs of density at most twice the holes'. `[Kainen1992]` p. 35 conjectures *\"The chromatic number of the plane "
    "is robust.\"* (some band of positive width needs no more colours than the plane); given `[Voronov2023]` Thm 1.1 that is `χ(ℝ²) = 7`, "
    "and this row's question is its measurable form (the consolidation run's LW2, checked by FP). |")

# C3 row 132
t = row_edit(t, 132,
    "no almost-everywhere form of any found in print (FS-106's gate); the repairs not in print. |",
    "no almost-everywhere form of any found in print (FS-106's gate); the repairs not in print. Before Voronov's seven, six for every band "
    "is `[BrownDunfieldPerry1994]` p. 113 (1994, from their Theorem 9's proof), after Erdős's question (1985, as they quote it); the "
    "seven-colour upper half of `[Voronov2023]` Cor. 1.1 is `[Kainen1992]` Thm 1 (p. 34, Isbell's colouring on the open band "
    "`(1 − u, 1 + u)`, `u ≤ (√7 − 2)/(√7 + 2)`) (the consolidation run's LW2). |")

# C4 row 134
t = row_edit(t, 134,
    "S–V Lemma 3's printed proof fails from `√3` (CB). |",
    "S–V Lemma 3's printed proof fails from `√3` (CB). `[Polymath2021]` p. 199 asks to strengthen `[Thomassen1999]` by eliminating "
    "*\"(ii) the unit-radius tactic\"* — FS-112's question, which a NO there answers for segment-and-arc tilings; this row is the "
    "complementary case (criterion (i) dropped, every radius-1 arc forbidden), not asked there and incomparable with Thomassen's theorem "
    "(two readers, the consolidation run's LW and LW2). `[Parts2021]` p. 181 uses the tactic (\"Wavy sides\") and measures it saving two "
    "colours in six-fold tilings (p. 182: *\"for m = 6, it is possible to reduce k from 31 to 29\"*) (LW2). |")
p.write_text(t, encoding="utf-8")

# C6 FS103-M-EASY
p = Path("plans/FS103-derivation.md"); t = p.read_text(encoding="utf-8")
t = once(t,
    "*Rests on it:* FS103-M-Q4's direction \"≤\". *Prior art:* classical in shape (Falconer-type averaging); not searched as stated.",
    "*Rests on it:* FS103-M-Q4's direction \"≤\". *Prior art:* its argument is in print as `[GwynStavrianos2022]` Lemma 2, Theorem 2 and "
    "Corollary 1 (p. 12), stated for badness under an invariant mean on E(2) (infimum 0 suffices, every colouring, quantitative "
    "`1/|E(G)|`); N-EASY follows with Haar averages in place of the mean, a step not printed; the averaging device is "
    "`[Polymath16wikiProb]`'s (2018–19) (two readers, the consolidation run's LW and LW2; `data/consolidation-2026-09-27/reports/LW2.md` § 0).",
    "FS103-M-EASY")
p.write_text(t, encoding="utf-8")

# F1 GROKKING-INSTANCES §G49: a new passage at the end of the section (before "## G50")
p = Path("plans/GROKKING-INSTANCES.md"); t = p.read_text(encoding="utf-8")
passage = (
    "*The consolidation run (2026-09-27), jobs LP and LV (`data/consolidation-2026-09-27/lp/record.md` stage 5, "
    "`data/consolidation-2026-09-27/lv/record.md` stage 2), a further instance of G49's held-paper clause:*\n\n"
    "**The consolidation run's instance:** `[Fischer1994]`'s value was restated in the two Geombinatorics surveys of the direction, "
    "`[Johnson2000]` p. 176 and `[Johnson2006]` p. 214 — the second being the survey `[Soifer2024]` ch. 11 sends readers to — and both "
    "left the four-colour question open (2000 poses the family `m ≡ 11 (mod 12)`; 2006 asks *\"does there exist a positive integer m such "
    "that χ(G(ℚ²(√m), 1)) ≥ 4?\"*). And Theorem A's construction was `[Fischer1990]` Thm 1(i), its first instances `[BendaPerles2000]`'s "
    "(1976), held and marked read since 2026-09-08 and credited only with 'the unit argument' — a held paper is prior art for questions it "
    "was not read for; and `[Madore2015]`'s footnote 5, held and read since FS-18, had pointed the bridge at `[BendaPerles2000]` all along, "
    "as `[Fischer1990]` p. 182 had in 1990.\n\n")
t = once(t, "## G50 — Read what the search found", passage + "## G50 — Read what the search found", "GROKKING-INSTANCES G50 heading")
p.write_text(t, encoding="utf-8")
print("stage 2 part 1 applied")
