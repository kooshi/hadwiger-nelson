import sys; sys.path.insert(0, sys.argv[1]); from rep import apply
P = "plans/STUB-tight-product-colourings.md"
R = "`plans/PA-products-GL1974-LT2002.md`"
banner = (
"**At FS-89's close (2026-09-25), from the Greenwell–Lovász / Larose–Tardif reading (" + R + " §4; PA-P1 to PA-P5, hand, filed "
"there):**\n"
"- **Settled for `G = K_k^s`** (`k ≥ 3`, `s ≥ 1`; PA-P3): for every connected `H` with `χ(H) > k`, of any cardinality and any "
"`χ_f(H)`, the `k`-colourings of `K_k^s × H` are exactly `σ ∘ pr_i`, `i ≤ s` — `[GreenwellLovasz1974]` Theorem 1 iterated "
"(`K_k^{s−1} × H` is connected by Weichsel's theorem, cited and not held, and its colourings are gap-free), and, by its zbMATH "
"review, the main theorem of `[Larose2002]` (not held). Theorem 1's hypothesis on the factor that is not `K_n` is exactly "
"gap-freedom (PA-P1). Among G54's tight residue targets this covers `Γ₃ = UD(𝔽₃, 2) ≅ K₃ × K₃` (by `(a, b) ↦ (a + b, a − b)`; "
"the owner checked the 18 edges by script) and the dyadic `U₂ = Cay(𝔽₄, μ₃) = K₄`, with their direct powers (PA-P4) — **not** "
"FS-58's `S₁ = UD(𝔽₉, 2)` (81 vertices, degree 8; `K₃⁴` has degree 16), not `U₃₂` or `U₄`, and no tower level ≥ 2. So D1's "
"\"closes as a citation\" fires for that class only, and the stub stays open.\n"
"- **§5.4's criterion at `G = K_k` is inside Greenwell–Lovász's proof** (PA-P2): Case 1 isolates the loops, and Case 2's `γ'` (a "
"repeated value of a non-injective map) is a proper `k`-colouring of `E_k(K_k)` that colours each map within its own image — the "
"shape a proof for a tight `G` must take; a candidate for D4's kernel form beside PA-T6.\n"
"- **The equal-ratio case with IS-primitive factors** (PA-P5, hand, conditional on `[Zhang2012]` Thm 1.8 as printed in arXiv v1): "
"`G`, `H` vertex-transitive, `α(G) = |G|/k`, `H` connected with `χ(H) > k` and `χ_f(H) = k`, both IS-primitive (Zhang's term: no "
"independent `A` with `|A| < α` and `|A|/|N[A]|` equal to the independence ratio) ⟹ `G × H` is MIS-normal, so the classes of every "
"`k`-colouring are maximum and of one type, and — `H` not being `k`-colourable — pulled back from `G`. Zhang's case (ii), the "
"exception, is exactly equal ratios with an IS-imprimitive factor.\n"
"- **Rows 88–89 against the FS-86 re-aim below** (the reader noted that the re-aim reads Thm 1.8 for the strict case only): row 88 "
"uses case (i) with a strict inequality, as the re-aim says; row 89 meets the equal ratio 1/4 between K's two dyadic factors, both "
"four-colourable, and decides which factor a class comes from by tightness (each class `a(x) + b(y)`), not by MIS-normality. So "
"neither row is FS-67's equal-ratio case with `χ(H) > k`, which PA-P5 now answers when both factors are IS-primitive. **What is "
"left**, for tight `G` other than `K_k^s`: equal ratio with an IS-imprimitive factor (row 89's tightness route is the tool at hand); "
"`χ_f(H) < k < χ(H)` for vertex-transitive `H`, where the classes need not be maximum and MIS-normality says nothing "
"(`[Tardif2023]`'s regime); and every non-vertex-transitive `H`.\n"
"- **`[LaroseTardif2002]` does not bear directly**: its projectivity and canonical-independent-set theorems are about powers `G^n`, "
"whose cofactor has `χ ≤ χ(G)`, and projectivity does not give canonical classes (truncated simplices, its Thm 5.1); its Problem "
"6.1 leads to `[Zhang2012]`.\n\n")
apply(P, [
 ("**At FS-89's close (2026-09-25), from the `[Tardif2023]` reading", banner + "**At FS-89's close (2026-09-25), from the `[Tardif2023]` reading"),
 ("this stub's question has an exact exponential-graph form.",
  "this stub's question has an exact exponential-graph form (its dichotomy first posed at `k = 4` as Poros's FS-85 hunch P-prod, "
  "`plans/POROS-2026-09-24-fs85-competition.md` §3, never sent)."),
 ("`[GreenwellLovasz1974]` itself is now held and being read (`plans/PA-products-GL1974-LT2002.md`).",
  "`[GreenwellLovasz1974]` is now read in full (the banner above)."),
 ("what is left is the equal-ratio case (tightness decides it at K, row 89) and the integrality gap `χ_f(H) ≤ k < χ(H)`.",
  "what is left is the equal-ratio case (tightness decides it at K, row 89) and the integrality gap `χ_f(H) ≤ k < χ(H)` "
  "*[narrowed at FS-89's close: the banner above]*."),
 ("* **The nearest printed statement is `[GreenwellLovasz1974]`'s, second-hand from `[Tardif2008]` §4.2**: *if `G` is connected and\n"
  "  `χ(G) > n` then `G × Kₙ` is uniquely `n`-colourable* — the colourable factor must be `Kₙ` itself. For a general *uniquely*\n"
  "  3-colourable factor it is Duffus–Sands–Woodrow's statement B(n) (1985), conjectural. **None of the four originals has been read\n"
  "  by anyone here** (all paywalled; `BIBLIOGRAPHY.md` § R.4) — every sentence in this bullet is a relay.",
  "* **The nearest printed statement is `[GreenwellLovasz1974]`'s** (read in full at FS-89's close): Theorem 1 — for connected `G`\n"
  "  whose `n`-colourings are all gap-free, every `n`-colouring of `Kₙ × G` is induced by one factor — and its Corollary 1, *if `G`\n"
  "  is connected and `χ(G) > n` then `Kₙ × G` is uniquely `n`-colourable* (verbatim as `[Tardif2008]` §4.2 quotes it). The factor\n"
  "  whose colourings are pulled back is `Kₙ` itself, or `Kₙ^s` iterated (the banner above). For a general *uniquely* 3-colourable\n"
  "  factor it is Duffus–Sands–Woodrow's statement B(n) (1985), conjectural. **Of the four originals only Greenwell–Lovász has been\n"
  "  read**; Duffus–Sands–Woodrow, Häggkvist–Hell–Miller–Neumann-Lara and El-Zahar–Sauer stay relays (`BIBLIOGRAPHY.md` § R.4)."),
 ("| D1 | **The prior-art gate, properly** (WORKFLOW 3.2, items 5–8): Greenwell–Lovász 1974, Duffus–Sands–Woodrow 1985, HHMN 1988, "
  "Tardif's survey — *read*, not relayed; zbMATH author listings for each; the reconfiguration literature's \"frozen\" colourings of "
  "products. If the tight case is printed, this stub closes as a citation | hours + the papers (§ R.4) |",
  "| D1 | **The prior-art gate, properly** (WORKFLOW 3.2, items 5–8): Duffus–Sands–Woodrow 1985, HHMN 1988, `[Larose2002]` (the "
  "tight case for `K_k^s` in exponential-graph form, by its review), Tardif's survey — *read*, not relayed; zbMATH author listings "
  "for each; the reconfiguration literature's \"frozen\" colourings of products. Greenwell–Lovász 1974 is read (FS-89's close): the "
  "tight case is printed for `G = K_k^s` only, so the stub does not close as a citation | hours + the papers (§ R.4) |"),
])
