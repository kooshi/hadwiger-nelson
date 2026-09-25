import sys; sys.path.insert(0, sys.argv[1]); from rep import apply
R = "`plans/PA-products-GL1974-LT2002.md`"
C = "*[Correction at FS-89's close, 2026-09-25, from the products reader ("
def app(path, anchor, note):
    apply(path, [(anchor, anchor + note)])

app("plans/COXETER-2026-09-08-mascot.md",
 "combinatorial rigidity and the arithmetic are literally the same object.",
 "\n\n" + C + R + " §0 item 2, §3; the paper read in full): the fact used holds, but the gloss names the wrong result. "
 "`K₄ × K₄` is not uniquely 4-colourable: it has two 4-colourings up to relabelling, the two projections (48 labelled). That is "
 "Greenwell–Lovász 1974's Corollary 3 (p. 336, `n = 4`, `k = 2`: \"(K_n)^k has exactly k n-colourings\", for `n ≥ 3`). Their "
 "\"uniquely `n`-colourable\" statement is Corollary 1 — `K_n × G` with `G` connected and `χ(G) > n` — which does not apply here, "
 "since `χ(K₄) = 4`.]*")

app("plans/MASCOT-derivation.md", "neither of which cites this theorem).",
 " " + C + R + " §0 item 2, §3; the paper read in full): the `K₄ × K₄` step holds, but not as \"`K_n` is uniquely "
 "`n`-colourable in the categorical product\" — `K₄ × K₄` has two 4-colourings up to relabelling (48 labelled, as stated), which "
 "is `[GreenwellLovasz1974]` Corollary 3 (p. 336, `n = 4`, `k = 2`); the uniqueness statement is their Corollary 1 and needs "
 "`χ > n`. The check owed above is paid: the citation holds, as Corollary 3.]*")

app("plans/M50-batch-descent.md", "enumeration exploits — only colour-side POINTWISE operations are dead.",
 "\n  " + C + R + " §0 item 6, §3; both papers read in full): \"strongly projective graphs\" is not in Larose–Tardif 2002 "
 "(`[LaroseTardif2002]`, J. Graph Theory 40, a paper on powers, which never uses the phrase) — it is B. Larose's single-author "
 "*Strongly projective graphs*, Can. J. Math. 54 (2002) 757–768 (`[Larose2002]`, not held, its review read). The fact used here — "
 "every polymorphism of `K₅` is a projection up to a palette permutation — is Greenwell–Lovász 1974's Corollary 3 at `n = 5`. The "
 "Inv–Pol consequence is the general Galois correspondence given that fact, in neither paper; and \"trivial polymorphism clone\" is "
 "inexact: `Pol(K₅)` is the permuted projections, and only its idempotent part is trivial.]*")

app("plans/M50-derivation.md", "check owed against the two papers.",
 " " + C + R + " §0 item 6, §3; both papers read in full): the check is paid. The base fact holds: `[GreenwellLovasz1974]` "
 "Corollary 3 at `n = 5`. \"Strongly projective\" is misattributed: it is `[Larose2002]` (Larose alone, Can. J. Math. 54 (2002) "
 "757–768; not held, its review read), not `[LaroseTardif2002]`, which never uses the phrase. The Inv–Pol consequence is the general "
 "Galois correspondence given Corollary 3, in neither paper, and \"trivial polymorphism clone\" is inexact (`Pol(K₅)` is the permuted "
 "projections; only its idempotent part is trivial). The reader judges the `S₅` consequence promotable from reading to hand grade on "
 "that basis; this close notes it and leaves the grades above as filed.]*")

app("plans/M50-derivation.md", "so the consequences above stay *readings* pending a read.",
 " *[At FS-89's close, 2026-09-25: both are now held and read in full (" + R + "); the \"strongly projective\" strengthening is "
 "`[Larose2002]`'s, not `[LaroseTardif2002]`'s, and the row is § R.4 item 14 — see the note above.]*")

app("plans/STANDING-QUESTIONS.md", "seed's automorphisms, and the cluster structure the cube enumeration exploits.",
 "\n  " + C + R + " §3): the second citation has the wrong authors — *Strongly projective graphs*, Canad. J. Math. 54 (2002) "
 "757–768, is B. Larose's alone (`[Larose2002]`, not held, its review read); Larose–Tardif 2002 (`[LaroseTardif2002]`, J. Graph "
 "Theory 40) is a different paper and never uses the phrase. The projectivity fact itself is Greenwell–Lovász 1974's Corollary 3 "
 "(`n = 5`: `(K₅)^k` has exactly `k` five-colourings up to relabelling). \"Trivial polymorphism clone\" is inexact: only its "
 "idempotent part is trivial.]*")

app("plans/FS58-derivation.md", "half (FS-67) is what would need a kernel target, not this factorisation lemma.",
 "\n" + C + R + " §3–§4): Greenwell–Lovász 1974 is now read in full, so \"unread\" is stale for it (Häggkvist–Hell–Miller–"
 "Neumann-Lara 1988 stays unread). It does not reach the claim here: its Theorem 1 settles `K_n × G` for connected gap-free `G`, "
 "hence FS-67 for tight factors `K_k^s` (among them `UD(𝔽₃, 2) ≅ K₃ × K₃`), but `S₁` (81 vertices, degree 8) is no direct power of "
 "`K₃` (`K₃⁴` has degree 16).]*")

app("plans/FS58-four-colours.md",
 "is owed a reading before it is cited. The lifting step (every circle point modulo `𝔮^m` and `3^m` lifts jointly) stays.",
 "\n   " + C + R + " §3–§4): Greenwell–Lovász 1974 is read; its Theorem 1 covers `K_n × G` for connected gap-free `G`, so "
 "FS-67 for tight factors `K_k^s`, but not `S₁`, which is no direct power of `K₃`. The reading debt stays for HHMN 1988.]*")

app("plans/STUB-quadratic-census.md",
 "behind FS-58 D3.4; Johnson's 2000 status report and `[Johnson2006]` for any printed value.",
 "\n  *[At FS-89's close, 2026-09-25: the Greenwell–Lovász reading is paid (" + R + "); it settles the product statement for "
 "tight factors `K_k^s` only, not FS-58's `S₁`; FS-67 holds what is left.]*")

app("plans/SESSION-HANDOFF-2026-09-20.md",
 "true under gap-freedom/tightness); FS-59's stub gets the size-law reading once E.4 delivers the number.",
 "\n  " + C + R + " §3): \"true under gap-freedom/tightness\" overstates — the repaired statement is FS-67's open question, "
 "proved in print only when the tight factor is `K_k` or a power `K_k^s` (Greenwell–Lovász 1974, Thm 1; `[Larose2002]`).]*")

app("plans/FS71-theorem-audit.md", "(one textbook citation added, `[LaroseTardif2002]`)",
 " *[at FS-89's close: the content it was added for is `[Larose2002]`'s, not this paper's — `plans/M50-derivation.md`]*")
