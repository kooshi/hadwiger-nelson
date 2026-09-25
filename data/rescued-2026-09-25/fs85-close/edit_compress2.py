from pathlib import Path
p = Path("CLAUDE.md"); t = p.read_text(encoding="utf-8")
def rep(old, new):
    global t
    n = t.count(old); assert n == 1, (n, old[:90]); t = t.replace(old, new)
def repitem(num, new):
    global t
    i = t.index(f"\n{num}. **"); j = t.index(f"\n{num+1}. **", i+1)
    t = t[:i+1] + new + t[j:]
rep("""[hand, two independent
   derivations; row 82]""", """[hand, two independent derivations; row 82]
  """)
# FS-59 row question cell
i = t.index("| 1 | **FS-59 ℚ(√167): five colours**")
a = t.index(" | **After FS-81:**", i); b = t.index(" **Re-aimed at FS-85's close:**", i)
t = t[:a] + (" | **After FS-81:** four is also row 82's, and a matched ball is priced out (row 84), so the solver-free routes come first; "
 "`L21cc6506` is loose at four colours (row 81). **Does ℚ(√167)² need five?** 7 minimal lattices of a finite part of the saturated chain "
 "survive capped screens and P3b (no `Θ₄` point from a calibrated finder; no quotient colouring to `N = 15`, undecided at Λ₂₃₂₈'s 13 and "
 "Λ₂₄₄₈'s 15). Next, cheapest first (the stub orders them): quotients at `N ≥ 16`, longer residue asks, the classification at 43, a real "
 "price of the exact `Θ₄` tree and a second finder (one full-dimensional cell makes a survivor loose, G73), the chain route (G55) on any "
 "rigid survivor, the `8 ∤ M` pattern; a ball only after, priced by a measured hardness band.") + t[b:]
# FS-65 row question cell
i = t.index("**FS-65 exact independence numbers** — `plans/STUB-exact-independence-solver.md` | ")
a = i + len("**FS-65 exact independence numbers** — `plans/STUB-exact-independence-solver.md` | ")
b = t.index(" | **none on χ(ℝ²); idle compute only**", a)
t = t[:a] + ("compute `α(Γ_q)` exactly at the window members, where off-the-shelf exact solvers fail (at 19, 361 vertices: branch-and-reduce 70 "
 "and `struction` 66 against a local search's 76 — no reduction fires on a vertex-transitive graph, and triangle-freeness leaves the "
 "clique bound at `n/2`); D1's symmetry-broken SAT re-ask left `k = 78` undecided at 19, so **row 68's null is NOT about the encoding** "
 "(G59) — the case for D2 and D4, the symmetry-aware methods; D3 the circle decomposition (`q−1` cosets of `μ_{q+1}`, 18 variables at 19). "
 "**Re-aimed 2026-09-21:** FS-66's relaxation (row 75) read below the level-3 one (77 vs 80.59 at 19; 97 vs 105 at 23) — price it at "
 "31, 43, 47 before any exact method") + t[b:]
repitem(15, """15. **Six may be a value no field attains — a claim stronger than χ(ℝ²) ≠ 6, not equivalent to it** (G64, FS-62). *"No subfield of
   ℝ has χ(F²) = 6"* implies χ(ℝ²) ∈ {5, 7} and is not implied by it. So the wall at six (G56, G59) decides the value set of L — hence,
   under the conjecture's bold form, of F ↦ χ(F²) — and whether the conjecture predicts 6 or 7 at ℚ(√167). **A six-chromatic field has
   L(F) ≥ 6, and L(F) = 6 needs one of six named finite graphs to be six-chromatic**; six hides only in the gap between L(F) and χ(F²),
   where every ceiling we own is silent but FS-64. Six being skipped is *not* evidence for seven.""")
repitem(16, """16. **The construction grammar is crystallography's, and transcendence is free** (G62, G63). Every witness is a twisted bilayer
   whose rotation is the Σ = n coincidence rotation of the order of discriminant 1 − 4n; commensurate twists are periodic, hence
   bounded by a finite quotient (FS-63 is the gate). And χ(F(t)²) = χ(F²) for transcendental t (`[Fischer1990]` Thm 6), so
   χ(ℚ(π)²) = 2: the chromatic number cannot see transcendence degree.""")
p.write_text(t, encoding="utf-8"); print(len(t.encode()))
