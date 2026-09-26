# STUB — FS-96: windows at five colours over ℚ(√167) at the non-mixing places, and the null-set step (FS-64 at five, after M3)

**Re-aimed at the crunch's close (2026-09-26, J25; J39's R3, `plans/POROS-2026-09-25-wanted-poster-167.md` §4.5):** "(i) for existence the places are `{∞, 23, 43}`, modulo SP (the split places drop out, T-J39-1); (ii) GAP-1 does not arise in the CP format; (iii) GAP-2 is PL(23, 43), FS-67's Hedetniemi question in CP form (rows 114–115); (iv) its payoff is T-J39-5". Both
qualifiers, *for existence* and *modulo SP*, are part of the statement; a deterministic window over split places stays open as a window
(FS-100 §2.5). T-J39-1 and T-J39-5 are blind-checked TRUE (J48, BC-2, BC-4; BC-4 (ii) with its 43 hypothesis dropped); SP and MR are
FS-100's. The questions below stand as M3 left them, read through (i)–(iv).

**Since wave 3 (2026-09-26, consolidation job C3b; `LEDGER.md` rows 120, 123, 125):** "Given MR: `χ(ℚ(√167)²) ≤ 5` ⟺ `Y = UD(ℝ²) × G₂₃ × G₄₃` has a cut-and-project five-colouring (the ⟸ half needs no MR; two real places merge to one `UD(ℝ²)` factor because `G × G` is CP-`k`-colourable iff `G` is); `Y` has none ⟺ `χ_CP(ℝ²) ≥ 6 ∧ PL_∃(23, 43)`; and `PL_∃(23, 43)` is exactly the direction missing from `χ_CP(ℝ²) ≥ 6 ⟹ χ(ℚ(√167)²) ≥ 6`. No held result gives either conjunct, and no one-point density bound can (Croft's `m₁ ≥ 0.2293 > 1/5`, `[Croft1967]`)." T-J39-5 is exact; SP ⟺ ¬MR (FS-100 §2), so with MR held at [hand] (row 120) the qualifier *modulo SP* is met at that grade, and this stub's existence question is FS-59's six question in CP form. Five over ℚ(√167) is held (row 123), so a window five-colouring here would falsify the conjecture's "≥ 6". Provisional bearings add: G80; FS-59's head block.

*Minted 2026-09-25 at M3's close (crunch job J23c, from `plans/M3-close-inventory.md` rows 23 and 61, and the prior-art debt of row 22).
Numbered FS-96 by the front-page job (J24). Read first: `plans/M3-derivation.md` §5–§6, `plans/M3-S1D-windows-five.md` §3,
`plans/M3-S1V-windows-five.md` §2.1 and §3.4. Solver column: **none until 2026-10-01** for the derivations; the `κ` questions below are
finite and wait for the ban's end.*

## The mission, in plain language

The local–global conjecture predicts that the plane over ℚ(√167) needs at least six colours. A way it could fail is a five-colouring
read off finitely many "local coordinates" of the field (its places) through measurable windows (FS-64). M3 proved no such colouring
reads places with no real place and none above 43, and — through a new *mixing selection* (a colouring of a product with a well-mixing
compact factor yields a colouring of the rest) — that every place except twelve can be deleted from any window question without loss. So
the live question sits at nine places: the real place and the places above 2, 3, 5, 7, 23, 29, 43, 61. With a real place and only
deletable ("thick") places, the question is exactly whether the plane `ℝ²` has a Borel five-colouring — open in the literature. This stub
carries what is left between those two statements.

## What M3 established (addresses in `plans/M3-derivation.md`)

- D1 with its factor table (M3-J21-D1, D1fac, D1-2, D1-3): no window five-colouring over any `S` with no real place and no place above 43.
- The mixing selection (M3-J21-MX): a compact abelian factor with `λ* < 1/(k−1)` can be deleted from a Borel `k`-colouring of a product;
  measurably, into "proper off a null vertex set".
- The thick places (M3-J21-TH) and the reduction (M3-J21-RED): `S_red ⊆ {∞, 2, 3, 5, 7, 23, 29, 43, 61}`; the non-thick twelve have `λ*`
  from `0.2557` (61) to `1` (2) on their standard compact pieces, and the uniform measure is optimal there (M3-J21-UNIF).
- Ratio alone cannot carry the pullback (M3-J21-NG2, at 125 colours); the cylinder lemma is false (M3-J21-NG1); at a split place the whole
  local graph does not mix (M3-J21-NG3).

## The questions

1. **GAP-2, the non-thick factors.** Is every measurable (or Borel) proper five-colouring of `UD(ℝ²) × Γ_v` a pullback from `UD(ℝ²)` for
   `v` above 2, 3, 5, 7, 23, 29 or 61? J22's weaker sufficient condition: the **cross-independence ratio** `κ < 1/5` (no two
   cross-independent measurable sets both of measure `≥ 1/5`) on some compact piece. Is `κ < 1/5` on the standard piece
   `Cay(O², {(ε, ε⁻¹)})` at `q = 9, 25, 49, 29, 61`, or at 23? (`κ ≤ λ*/(1 + λ*)` gives only `0.2036` at 61; on the full split graph
   `κ ≥ 2/9`.) Finite questions — after 2026-10-01, and only at the extent a derivation fixes.
2. **GAP-1, the null-set step.** Does a measurable five-colouring of `ℝ²` proper off a null vertex set upgrade to one proper at every edge
   (N′ ⟹ E for `UD(ℝ²)` at five colours)? Or is a Borel hypothesis on the window the honest form?
3. **43 at depth (D1-43)** is FS-69's (`B₁(43) < 369.8`); listed here so that the two stubs are closed together.
4. **The prior-art debt first (inventory row 22).** Read `[AlonDinurFriedgutSudakov2004]` (stability of independent sets in weak
   products, Fourier-analytic), Tardif–Wrochna 2019 and Godsil–Roberson–Rooney 2020, and search the Borel-combinatorics literature on
   products (Conley–Kechris; Bernshteyn) before any claim that the mixing selection is new; then decide whether it enters
   `CLOSED-QUESTIONS.md` as a positive special case of `[KechrisMarks2020]` Problem 4.23 (a special case is not an answer).

## Registered expectations (to be re-registered at the opening)

- The prior-art reading finds the finite mixing form in print, 0.35.
- GAP-1 closed by derivation, 0.15; GAP-2 closed at one non-thick place, 0.15; a non-pullback five-colouring of `UD(ℝ²) × Γ_v` constructed
  (which would not falsify the conjecture by itself), 0.05.

**Failure clauses.** Nothing here decides `χ_µ(ℝ²)`; a "no" removes only the window format of falsifier, never a colouring of the plane no
window gives (J22 §4.3). A `κ` search is a witness search and waits for the ban's end.

## Deliverables

A derivation record with a "Theorems this phase proved" heading; a prior-art record for the mixing selection; a derivation file at the
close.

## Provisional bearings

**Provisional bearings, updated at row 88's and FS-67's closes (2026-09-25, J44):** G54's product sentence (row 115, FS67-DC2): a `k`-gap-free factor pulls back against every abelian Cayley factor with `λ* < 1/(k−1)`, sharp — the integral twin of M3-J21-MX.

G76 (with M3's addendum: mixing, not ratio, decides removal), G54 (the spectrum first — here its absolute value), G24/G43 (the real
factor's integrality gap), G60 (the density cap), G66 (43's tower), G48 (the conjecture's falsifier format), G50 (a held paper applied past
its statement: `[Zhang2012]`'s maximum sets), G72.

## Where the 2026-09-26 work on this lives

*Pointer block (consolidation job C1, 2026-09-26): addresses only — each result lives in its ledger row and derivation entry; the per-job index is `plans/CRUNCH-2026-09-26-x2x3-INDEX.md`.*

See: `LEDGER.md` row 125 (`plans/FS100-derivation.md` FS100-B12, FS100-B3).
