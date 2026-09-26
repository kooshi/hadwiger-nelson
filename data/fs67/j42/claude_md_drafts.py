#!/usr/bin/env python3
"""J42: FS-67's CLAUDE.md drafts, each as (anchor/old text, new text); prints bytes and the net total (budget 3,000).
Checks every OLD text and anchor occurs exactly once in CLAUDE.md on disk; a missing anchor fails loudly (exit 1)."""
import sys, pathlib
root = pathlib.Path(__file__).resolve().parents[3]
cm = (root / "CLAUDE.md").read_text(encoding="utf-8")
row9_old = cm.splitlines()[287]
assert row9_old.startswith("| 9 | FS-67"), row9_old[:40]
D = [
 ("replace", "Paths forward row 9 (FS-67)", row9_old,
  "| 9 | FS-67 colourings of gap-free products — `plans/STUB-tight-product-colourings.md` | **Closed as a milestone at the crunch "
  "(rows 114–115), the stub re-aimed.** `G` gap-free (a fall colouring) at `k`, `H` connected, `χ(H) > k`: must every `k`-colouring of "
  "`G × H` come from `G`? Exactly when `χ(E_k(G)) ≤ k`; **no from four colours up** for some uniquely colourable `G` (a composition of "
  "print: Duffus–Sands–Woodrow's `B(k) ⟹ H(k)` with `[Tardif2023]`); yes against every mixing `H` (`λ* < 1/(k−1)`, sharp). **Left:** three "
  "colours (3-colour the non-zero-winding part of `E_3(G)`), a Hoffman-tight counterexample (a regular Hedetniemi factor with "
  "`μ_min ≥ −d/(k−1)`), Zhang's IS-imprimitive exception … | none; mechanism — G61 (3)'s 11 half now a theorem, its 7 half measured (G48, FS-64, FS-66) |"),
 ("insert-before", "G54: products", "**What it says about six:**",
  "**In a product, Hoffman-tight pulls back where the other factor mixes** (FS-67, rows 114–115): every colouring of a Hoffman-tight "
  "plane is gap-free — a fall colouring, which Csernák calls \"tight\", another sense of the word — and a gap-free `G` pulls back against "
  "every abelian Cayley `H` with `λ* < 1/(k−1)`, sharp at `K_k`; gap-freedom alone fails against some `H` from four colours up (`K_k × X`, "
  "`X` from a Hedetniemi pair), and whether Hoffman-tightness suffices is open — check the other factor's `λ*` before calling a product "
  "colouring local. "),
 ("replace", "G61 (3)", "(the general statement is FS-67, unproved, and false without gap-freedom)",
  "(at 11 a theorem: the plane is 3-gap-free and `Γ₁₁` mixes, `λ* < 1/2`, so every three-colouring of the product pulls back, rows "
  "114–115; at 7, where `Γ₇` neither mixes nor has `χv > 3`, still measured; false without gap-freedom)"),
 ("insert-after", "G72 count (after the row-88 close's tenth sentence, itself after this anchor)", "**nine of nine**.",
  " **Eleventh (FS-67):** the criterion `χ(E_k(G)) ≤ k` and the obstruction it names, a Hedetniemi pair in `E_k(G)`, through the structural "
  "question; the spectral pullback by extending a known tool; the three-colour selection not found: **eleven of eleven**."),
 ("insert-after", "G21 instance", "an existence theorem paraphrased as a classification at four addresses (G77).",
  " **FS-67's two:** plants that could not fire — a tightness plant that left `λ_min` where it was, and a circle `x² + y² = 2` that "
  "built an isomorphic graph (every circle is a similarity image of the unit circle)."),
 ("insert-after", "Frontier item 28", "and a statement about single heteroclinic colourings; **not landed**",
  None),  # placeholder replaced below
 ("insert-after", "Prior-art position, Ours", "the mixing selection and the windows at five over ℚ(√167) (rows 108–110);",
  " the product criterion `χ(E_k(G)) ≤ k` for gap-free `G`, its `K_k × X` form and the sharp mixing pullback for every gap-free `G` "
  "(rows 114–115; as far as the gate reached, Duffus–Sands–Woodrow 1985 unread);"),
 ("insert-after", "Prior-art position, Not ours", "its threshold beside `K_k` (`[PakVilenchik2013]`);",
  " Duffus–Sands–Woodrow's `B(n) ⟹ H(n)`, so with `[Tardif2023]` `B(n)` and `A(n)` fail for `n ≥ 4` (a composition of print), and "
  "the vector pullbacks under rows 114–115 (`[GodsilEtAl2020]` Thm 4.16);"),
 ("insert-after", "Last updated", "*Last updated: 2026-09-25 — ",
  "**FS-67 closed** (rows 114–115; G21, G54, G61, G72 edited): the product question answered negatively from four colours up for "
  "gap-free factors, a sharp mixing pullback, three colours open; **Paid (theorem and no-go)** (`plans/FS67-tight-products.md` §R-close). "),
]
# Frontier item 28: appended after item 27's paragraph (anchor: item 27's line end).
item27 = [l for l in cm.splitlines() if l.startswith("27. **Rank one at four colours")]
assert len(item27) == 1
D[5] = ("insert-after", "Frontier item 28 (new line after item 27)", item27[0][-60:],
  "\n28. **Colourings of products: mixing pins them, gap-freedom does not** (rows 114–115; FS-67, `plans/FS67-derivation.md`). A "
  "`k`-colouring of `G × H` must come from `G` exactly when `G`'s colourings are gap-free and the improper part of `K_k^G` is "
  "`k`-colourable; from four colours up that fails for some uniquely colourable `G` (a composition of print), and it holds whenever `H` "
  "mixes (G54). Three colours and Hoffman-tight `G` are open. Bearing on χ ≥ 6: none.")
if "--plant" in sys.argv:  # a G61 anchor that does not occur: the run must exit 1
    D[2] = ("replace", "G61 (3) PLANT", "(the general statement is FS-67, proved)", D[2][3])
net = 0; ok = True
for kind, name, anchor, new in D:
    n = cm.count(anchor)
    if n != 1:
        print(f"ANCHOR COUNT {n} (need 1): {name}: {anchor[:60]}"); ok = False
    old_b = len(anchor.encode()) if kind == "replace" else 0
    new_b = len(new.encode())
    net += new_b - old_b
    print(f"{name:45s} {kind:14s} old {old_b:5d}  new {new_b:5d}  net {new_b - old_b:+5d}")
print(f"NET BYTES {net} (budget 3000) -> {'within' if net <= 3000 else 'OVER'}")
if "--emit" in sys.argv:
    for kind, name, anchor, new in D:
        print(f"\n--- {name} [{kind}] anchor/old: «{anchor if len(anchor) < 200 else anchor[:120] + ' …'}»\nNEW: «{new}»")
sys.exit(0 if ok and net <= 3000 else 1)
