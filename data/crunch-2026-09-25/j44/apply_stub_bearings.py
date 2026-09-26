#!/usr/bin/env python3
"""J44 stage 4: forward propagation (WORKFLOW 9) — one provisional-bearings line per stub the two closes name, and G79 to the stubs
whose wall it bears on. Each anchor must occur once per file, or nothing is written.  --plant: an absent anchor; exit 1."""
import sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
H = "**Provisional bearings, updated at row 88's and FS-67's closes (2026-09-25, J44):** "
CRUNCH = "**Provisional bearings, updated at the 2026-09-25 crunch's close (M1–M3):**"
E = {  # stub file: (anchor, where, text)
 "STUB-windows-five-nonmixing.md": ("## Provisional bearings\n\n", "after",
   "G54's product sentence (row 115, FS67-DC2): a `k`-gap-free factor pulls back against every abelian Cayley factor with `λ* < 1/(k−1)`, "
   "sharp — the integral twin of M3-J21-MX."),
 "STUB-adelic-window-colouring.md": (CRUNCH, "before",
   "G76's colouring-level split (rows 111–113: finite-place spectra are pullbacks over type (B), none exists at ℚ(√47)); G54's product "
   "sentence (row 115: a gap-free factor's colouring pulls back against a mixing one)."),
 "STUB-character-classification.md": ("## Provisional bearings (for the re-grokking at the opening, WORKFLOW 3.1)\n\n", "after",
   "rows 114–115 — FS67-DC1 and DC2 are pullback theorems of the shape \"a colouring of a product of local targets is local at one place\", and "
   "FS67-DA4 shows that locality can fail between gap-free factors from four colours up (G54)."),
 "STUB-tight-quotients.md": ("## 1. Mission context, in plain language", "before",
   "Lemma T (FS67-T, row 115): a 5-Hoffman-tight quotient is 5-gap-free, so its products with mixing factors pull back (FS67-DC2; G54's "
   "product sentence)."),
 "STUB-ratio-bound-kernel.md": ("## 1. Mission context, in plain language", "before",
   "Lemma T (FS67-T, row 115) is the ratio bound's equality lemma — Hoffman-tight at `k` ⟹ every `k`-colouring balanced and gap-free; in print, "
   "`[Haemers2021]` p. 4."),
 "STUB-four-colour-inheritance.md": (CRUNCH, "before",
   "FS67-DA4 (row 114): non-local four-colourings of products exist between gap-free factors from four colours up (G54's product sentence)."),
 "STUB-five-colours-47.md": (CRUNCH, "before",
   "G79 — the wall here is a counterexample invariant (rows 96, 113); flip the poster and ask what every four-colouring the plane already has "
   "must carry. The wanted-poster session J37 is its first test."),
 "STUB-infinite-place-spectra.md": ("## Provisional bearings\n\n", "after",
   "G79 — this stub's class is what a counterexample must carry and may be empty; flip the poster and ask what every invariant four-colouring "
   "must carry. The wanted-poster session J38 is its first test."),
 "STUB-ultrametric-continuation.md": ("## Provisional bearings\n\n", "after",
   "G79 — both gaps describe what a non-pullback must carry; the example invariant is what every pullback carries that a transient colouring "
   "could not. The wanted-poster session J38 is its first test."),
 "STUB-four-colours-167.md": (CRUNCH, "before",
   "G79 (the wanted-poster session J39 is its first test); G76's row-88 edit does not reach five colours here — the count needs every non-tight "
   "ratio below `1/5`, and the real place's `m₁ ≥ 0.229` exceeds it (row 92's \"Not claimed\"), so row 112 says nothing at ℚ(√167)."),
 "STUB-tight-product-colourings.md": (CRUNCH, "before",
   "G79 — FS-67's close reads itself this way (`plans/FS67-tight-products.md` §R-close R.2): the counterexample invariant, a Hedetniemi pair in "
   "`E_k(G)`, came from print; the example invariant at three colours, a colouring of `E_3(G)`'s non-zero-winding part, is the missing step."),
}
if "--plant" in sys.argv:
    E["STUB-ratio-bound-kernel.md"] = ("zzq absent zzq", "before", "x")
new = {}
for f, (a, where, txt) in E.items():
    p = ROOT / "plans" / f
    t = p.read_text(encoding="utf-8")
    c = t.count(a)
    if c != 1:
        sys.exit(f"FAIL: {f}: anchor occurs {c} times; nothing written")
    if H in t:
        sys.exit(f"FAIL: {f}: already carries J44's line; nothing written")
    line = H + txt
    new[p] = t.replace(a, a + line + "\n\n", 1) if where == "after" else t.replace(a, line + "\n\n" + a, 1)
for p, t in new.items():
    p.write_text(t, encoding="utf-8")
print(f"PASS: {len(new)} stubs")
