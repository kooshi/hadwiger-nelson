import sys; sys.path.insert(0, sys.argv[1]); from rep import apply
old = ("`G` Hoffman-tight at three colours (every 3-colouring gap-free), `H` connected with `χ(H) > 3`: is every 3-colouring of `G × H` "
"pulled back from `G`? Measured yes for the 3-adic plane against the planes at 7 and 11 (FS-58 §0 O7) and leaned on there as if proved; "
"**false without gap-freedom** (`C₅ × K₄`); it is not Greenwell–Lovász and not multiplicativity; an unverified eigenvalue sketch covers "
"`q ≳ 17` only; the four originals are unread (`BIBLIOGRAPHY.md` § R.4) **Re-aimed at FS-85's close — the four-colour form:** `G` tight "
"at four colours, `χ(H) > 4`: is every four-colouring of the product pulled back from `G`? Answered yes once (FS85-R3a: the tight dyadic "
"quotient times the mod-5 torus, on de Grey's five-family graph), pointwise, not by second moments; bears on FS-86.")
new = ("`G` Hoffman-tight at `k` colours (every `k`-colouring gap-free), `H` connected with `χ(H) > k`: is every `k`-colouring of `G × H` "
"pulled back from `G`? Minted at `k = 3`, re-aimed at FS-85's close to `k = 4`. **Settled for `G = K_k^s`** (`[GreenwellLovasz1974]` "
"Thm 1 iterated; `[Larose2002]` by its review; `plans/PA-products-GL1974-LT2002.md` PA-P3): among the tight residue targets "
"`Γ₃ ≅ K₃ × K₃` and the dyadic `U₂ = K₄` with their powers — not FS-58's `S₁`, `U₃₂`, or any tower level ≥ 2. **For vertex-transitive "
"`H`**, `[Zhang2012]` Thm 1.8 gives yes at a strict ratio (row 88) and, conditional on the theorem as printed, at an equal one with both "
"factors IS-primitive (PA-P5); left there: an IS-imprimitive factor at equal ratio (row 89 decided its equal-ratio instance, both factors "
"four-colourable, by tightness) and `χ_f(H) < k < χ(H)`; and every non-vertex-transitive `H`. Answered yes once for a sparse product "
"outside that class (FS85-R3a: the tight dyadic quotient times the mod-5 torus on de Grey's five-family graph), pointwise, not by second "
"moments. The exact form: yes for every such `H` iff `χ(E_k(G)) ≤ k` (`plans/PA-tardif2023.md` PA-T6), whose `k`-colouring at "
"`G = K_k` is Greenwell–Lovász's proof (PA-P2); first posed at `k = 4` as Poros's FS-85 hunch P-prod. At `k = 3`: measured yes for the "
"3-adic plane against the planes at 7 and 11 (FS-58 §0 O7) and leaned on there as if proved; **false without gap-freedom** "
"(`C₅ × K₄`); not multiplicativity; an unverified eigenvalue sketch covers `q ≳ 17` only. Unread: Duffus–Sands–Woodrow, HHMN 1988, "
"El-Zahar–Sauer, `[Larose2002]` (`BIBLIOGRAPHY.md` § R.4). Bears on FS-86.")
apply("plans/FRONTIER-STUBS.md", [(old, new)])
