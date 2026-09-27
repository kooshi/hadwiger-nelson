# FS-67 — 3-colourings of a tight graph times a non-3-colourable one: do they all come from the tight factor?

**At the 2026-09-26 re-rank (job R3; `plans/RERANK-2026-09-26.md` § Application — R3): rank 11 → 5 in `plans/FRONTIER-STUBS.md`.** **Re-aimed:** product locality (PL) in CP form at the non-mixing places, `k = 5, 6` — must a CP `k`-colouring of `UD(ℝ²) × ∏ G_v` come from `UD(ℝ²)`? The theory route B needs (R1 §2.1); `PL_∃(23, 43)` is its instance (FS-59, FS-96); given FS-103's F1 (a candidate composition, not a result: given MR, row 120, and T-J39-3, at a real field with no non-thick stable place, `χ(ℝ²) = χ_CP(ℝ²) = χ(F²)`), PL is the only non-archimedean content left in the target. **derived that PL is necessary for S under HN = 7 and for the conjecture's six-clauses; soft as to truth** (Hedetniemi fails for finite graphs from four colours up; these factors do not mix). Provisional bearings add: FS-103 (the collapse — F1, a candidate composition, not a result), FS-104 (`χ_CP(ℝ²)` at six), FS-105 (harden MR). **Added at FS-106's close (owner, 2026-09-27):** G82 — the archimedean factor's CP colourings are limits of periodic grid-square slack colourings with vanishing holes (row 131); whether PL's non-mixing factors survive that limit is unasked.

**At the 2026-09-26 consolidation (2026-09-26, consolidation job C3b; `LEDGER.md` row 125).** Its CP form at 23 and 43, `PL_∃(23, 43)`, is one conjunct of six at ℚ(√167): "Given MR: `χ(ℚ(√167)²) ≤ 5` ⟺ `Y = UD(ℝ²) × G₂₃ × G₄₃` has a cut-and-project five-colouring (the ⟸ half needs no MR; two real places merge to one `UD(ℝ²)` factor because `G × G` is CP-`k`-colourable iff `G` is); `Y` has none ⟺ `χ_CP(ℝ²) ≥ 6 ∧ PL_∃(23, 43)`; and `PL_∃(23, 43)` is exactly the direction missing from `χ_CP(ℝ²) ≥ 6 ⟹ χ(ℚ(√167)²) ≥ 6`. No held result gives either conjunct, and no one-point density bound can (Croft's `m₁ ≥ 0.2293 > 1/5`, `[Croft1967]`)." (FS-96, FS-59.)

**Closed as a milestone, re-aimed (FS-67's close, 2026-09-25, crunch job J42; `plans/FS67-tight-products.md` §R-close first, then
`plans/FS67-derivation.md`; draft ledger rows 114–115).** Words, fixed: *gap-free* colouring = a **fall** (frozen) colouring, every closed
neighbourhood meets every colour; *Hoffman-tight* = `λ_min = −d/(k−1)` (G54). Csernák 2023's "tight" means gap-free, not Hoffman-tight; this
stub's title means Hoffman-tight.

**What is answered** (each by two blind derivations unless marked; addresses in the derivation file):
- **The criterion** (FS67-DA1, DA2): every `k`-colouring of `G × H`, for every connected `H` with `χ(H) > k`, comes from `G` **iff** every
  `k`-colouring of `G` is gap-free **and** `χ(E_k(G)) ≤ k`, `E_k(G)` the improper maps of the exponential graph `K_k^G`. A gap is enough to
  fail (the minting's `C₅ × K₄`, generalised); for non-`k`-colourable `G` the statement is Hedetniemi's `H(k)` for `G`.
- **Gap-freedom is not enough from four colours up** (FS67-DA3, DA4): `G = K_k × X` is connected and uniquely `k`-colourable, and fails
  exactly when `X` has a Hedetniemi partner — so at every `k ≥ 4`, by `[Tardif2023]`. **This is a composition of print, not ours** (owner's
  ruling, 2026-09-25): Duffus–Sands–Woodrow 1985's `B(n) ⟹ H(n)` (reported by `[Tardif2008]` §4.2 and `[GodsilEtAl2020]` §1.3) with
  `[Tardif2023]` gives `B(n)` — and so `A(n)` — false for every `n ≥ 4`. It is not a `CLOSED-QUESTIONS.md` entry. Whether DSW's own proof
  builds `K_n × X` is undecided until DSW is read (not held).
- **It holds** for `G = K_k^s` (Greenwell–Lovász, PA-P3; FS67-GL) and for every `G` whose vertices all lie in `k`-cliques (FS67-CL, J40,
  one mind).
- **Mixing pins it, at every `k`, sharply** (FS67-DC2, DC2S): `G` `k`-gap-free (any graph) and `H = Cay(A, T)` finite abelian with
  `λ* < 1/(k−1)` ⟹ every `k`-colouring of `G × H` comes from `G`; `H = K_k` shows `1/(k−1)` cannot be raised. For 1-walk-regular
  Hoffman-tight `G`, against every connected `H` with `χv(H) > k` (FS67-DC1), and in the equal-`χv` case under `[GodsilEtAl2020]` Result 5
  (FS67-DD1) — both conditional on GRRSV's vector theorems.
- **The measured facts this stub was minted to justify:** `UD(𝔽₉, 2)` is connected, Hoffman-tight at three colours and so 3-gap-free
  (FS67-DB2, FS67-T), and `Γ₁₁` mixes (`λ* = 0.476 < 1/2`, FS67-DC3): **FS-58's "rigid tensored with the residue plane at 11" is a theorem.**
  At 7 it is not: `Γ₇` neither mixes (`λ* = 0.562`) nor has `χv > 3` (2.78) — it sits in the gap regime, where only the open three-colour
  question below would decide it.

**What is left — the re-aimed question.**
1. **Three colours (DB-1, `B(3)` widened to gap-free).** Is `χ(E_3(G)) ≤ 3` for every connected non-bipartite `G`, hence the criterion for
   every connected 3-gap-free `G`? Proved: the non-3-colourable case (El-Zahar–Sauer, relayed); a two-step winding `D_C` constant on every
   component of `K_3^G` (Lemma W, FS67-W); every component with `D_C ≡ 0` for some odd walk is 3-colourable (FS67-DB1Z, `[TardifWrochna2019]`
   §3 external). **The missing step, reached by two blind routes:** a 3-colouring of the loopless components of `E_3(G)` on which every
   `D_C ≠ 0` (they exist, with edges, at `G = C₅`, where they are 3-colourable by hand, FS67-C5). Readings first: `[ElZaharSauer1985]` (where
   non-3-colourability enters) and `[Tardif2006alg]` (an algorithm from a 3-colouring of a product to one of a factor) — neither held.
2. **A Hoffman-tight counterexample at `k ≥ 4` (DD-2).** Via `K_k × X` it needs a Hedetniemi pair `(X, H)` with `X` connected, regular and
   `μ_min(X) ≥ −d_X/(k−1)` (FS67-DD2R); any Hoffman-tight counterexample's `H` is outside the mixing regime and, for 1-walk-regular `G`, has
   `χv(H) ≤ k < χ(H)` (FS67-DD2N). First step, by hand: is `[Tardif2023]`'s `Ω_w(K_m)` regular (its §2, held)? Then `[Tardif2022frac]` (not held).
3. **Zhang's IS-imprimitive exception**: does GRRSV's "connected strictly complementary dual solution" hypothesis reach `[Zhang2012]` Thm
   1.8's case (ii)? Routes at hand, never run: row 89's tightness split, R3a's pointwise tetrahedron splitting (row 85).

**Post-ban stages (after 2026-10-01; not queued).** **PB-1**: an exact 3-colouring finder on `E_3(G)`'s non-zero-winding part at `G = C₇`
(2,187 maps) and `K₃ × C₅` (`3^15` maps), generator image stated (G21); `C₅` is retired (FS67-C5); a refusal is FALSE for item 1's first
clause only (neither graph is claimed 3-gap-free). **PB-2**: the spectrum of `Ω_w(K_m)` if item 2's hand step leaves it open, and of
`[Tardif2022frac]`'s factors once held. **Not feasible as written:** the plan's PB on `UD(𝔽₉, 2)`, `U₄`, `U₃₂` — `E_k(G)` has `k^{|V(G)|}`
vertices (`3^81`, `4^16`, `4^1024`).

**Bearing on χ ≥ 6: none.** Mechanism only: the answer to "when must a colouring of a product be local at one factor" in the class where
it is sharp (mixing factors), and a clean no-go (gap-freedom alone, from four colours up). **Provisional bearings:** G54 (tight ⟹ gap-free;
the drafted product sentence), G61 (3), G71 (heights: Lemma W is the height read two steps at a time), G72 (the criterion came through the
structural question), row 109 (the mixing selection this stub's DC-2 bootstraps).

*The sections below are the stub's history at its earlier closes; §3's deliverables table is superseded by the list above.*

**At M3's close:** for maps *into the Moser spindle* the answer is yes in print (`[TardifWrochna2019]` Thm 2, strong multiplicativity; found by M3's prior-art reader, `plans/M3-PA-mixing.md` Stage 2).

**Provisional bearings, updated at row 88's and FS-67's closes (2026-09-25, J44):** G79 — FS-67's close reads itself this way (`plans/FS67-tight-products.md` §R-close R.2): the counterexample invariant, a Hedetniemi pair in `E_k(G)`, came from print; the example invariant at three colours, a colouring of `E_3(G)`'s non-zero-winding part, is the missing step.

**Provisional bearings, updated at the 2026-09-25 crunch's close (M1–M3):** G76's mixing sentence (a factor leaves a product colouring when it mixes, not when its ratio is small, row 109).

**At FS-89's close (2026-09-25), from the Greenwell–Lovász / Larose–Tardif reading (`plans/PA-products-GL1974-LT2002.md` §4; PA-P1 to PA-P5, hand, filed there):**
- **Settled for `G = K_k^s`** (`k ≥ 3`, `s ≥ 1`; PA-P3): for every connected `H` with `χ(H) > k`, of any cardinality and any `χ_f(H)`, the `k`-colourings of `K_k^s × H` are exactly `σ ∘ pr_i`, `i ≤ s` — `[GreenwellLovasz1974]` Theorem 1 iterated (`K_k^{s−1} × H` is connected by Weichsel's theorem, cited and not held, and its colourings are gap-free), and, by its zbMATH review, the main theorem of `[Larose2002]` (not held). Theorem 1's hypothesis on the factor that is not `K_n` is exactly gap-freedom (PA-P1). Among G54's tight residue targets this covers `Γ₃ = UD(𝔽₃, 2) ≅ K₃ × K₃` (by `(a, b) ↦ (a + b, a − b)`; the owner checked the 18 edges by script) and the dyadic `U₂ = Cay(𝔽₄, μ₃) = K₄`, with their direct powers (PA-P4) — **not** FS-58's `S₁ = UD(𝔽₉, 2)` (81 vertices, degree 8; `K₃⁴` has degree 16), not `U₃₂` or `U₄`, and no tower level ≥ 2. So D1's "closes as a citation" fires for that class only, and the stub stays open.
- **§5.4's criterion at `G = K_k` is inside Greenwell–Lovász's proof** (PA-P2): Case 1 isolates the loops, and Case 2's `γ'` (a repeated value of a non-injective map) is a proper `k`-colouring of `E_k(K_k)` that colours each map within its own image — the shape a proof for a tight `G` must take; a candidate for D4's kernel form beside PA-T6.
- **The equal-ratio case with IS-primitive factors** (PA-P5, hand, conditional on `[Zhang2012]` Thm 1.8 as printed in arXiv v1): `G`, `H` vertex-transitive, `α(G) = |G|/k`, `H` connected with `χ(H) > k` and `χ_f(H) = k`, both IS-primitive (Zhang's term: no independent `A` with `|A| < α` and `|A|/|N[A]|` equal to the independence ratio) ⟹ `G × H` is MIS-normal, so the classes of every `k`-colouring are maximum and of one type, and — `H` not being `k`-colourable — pulled back from `G`. Zhang's case (ii), the exception, is exactly equal ratios with an IS-imprimitive factor.
- **Rows 88–89 against the FS-86 re-aim below** (the reader noted that the re-aim reads Thm 1.8 for the strict case only): row 88 uses case (i) with a strict inequality, as the re-aim says; row 89 meets the equal ratio 1/4 between K's two dyadic factors, both four-colourable, and decides which factor a class comes from by tightness (each class `a(x) + b(y)`), not by MIS-normality. So neither row is FS-67's equal-ratio case with `χ(H) > k`, which PA-P5 now answers when both factors are IS-primitive. **What is left**, for tight `G` other than `K_k^s`: equal ratio with an IS-imprimitive factor (row 89's tightness route is the tool at hand); `χ_f(H) < k < χ(H)` for vertex-transitive `H`, where the classes need not be maximum and MIS-normality says nothing (`[Tardif2023]`'s regime); and every non-vertex-transitive `H`.
- **`[LaroseTardif2002]` does not bear directly**: its projectivity and canonical-independent-set theorems are about powers `G^n`, whose cofactor has `χ ≤ χ(G)`, and projectivity does not give canonical classes (truncated simplices, its Thm 5.1); its Problem 6.1 leads to `[Zhang2012]`.

**At FS-89's close (2026-09-25), from the `[Tardif2023]` reading (`plans/PA-tardif2023.md` §5.4, PA-T6, hand):** this stub's question has an exact exponential-graph form (its dichotomy first posed at `k = 4` as Poros's FS-85 hunch P-prod, `plans/POROS-2026-09-24-fs85-competition.md` §3, never sent). For `G` all of whose proper `k`-colourings are gap-free, every loop of `K_k^G` is adjacent only to itself, so a `k`-colouring of `G × H` (`H` connected) is either pulled back from `G` or maps `H` into `E_k(G)`, the subgraph of `K_k^G` on the improper maps; hence **every `k`-colouring of `G × H` for every connected `H` with `χ(H) > k` is pulled back from `G` iff `χ(E_k(G)) ≤ k`**. Greenwell–Lovász is the case `G = K_k`; Tardif's Theorem 1 is the opposite phenomenon, and his construction (a normalised constant clique, image-≤ 3 maps, a tree closing in odd cycles) is the template for a counterexample inside `E_k(G)` for a tight `G`. A proof is a `k`-colouring of `E_k(G)`, which may be taken to colour each map within its own image. Testing it on a finite `G` is a finite-witness question, for after 2026-10-01. `[GreenwellLovasz1974]` is now read in full (the banner above).

**Re-aimed at FS-86's close (2026-09-25):** `[Zhang2012]` Thm 1.8(i) answers the main case for vertex-transitive factors with a strict ratio inequality and `H` connected (row 88); what is left is the equal-ratio case (tightness decides it at K, row 89) and the integrality gap `χ_f(H) ≤ k < χ(H)` *[narrowed at FS-89's close: the banner above]*.

> **Re-aimed at FS-85's close (2026-09-24): the four-colour form.** `G` Hoffman-tight at four colours (every four-colouring gap-free), `H`
> with `χ(H) > 4`: is every four-colouring of a (sparse) product of `G` and `H` pulled back from `G`? **Answered yes once** (FS85-R3a,
> row 85): on each component of de Grey's five-family graph, the colouring of the product of the tight dyadic quotient with the
> non-four-colourable mod-5 torus is local at one prime above 2 — Poros (round 2)'s product reading, confirmed in shape — by a pointwise
> tetrahedron splitting slice by slice, not by second moments (C14 rules those out there). Bears on FS-86, where a product of the tight
> dyadic `K₄` with the stable targets is exactly the shape a rigid lattice would need.

*Minted 2026-09-20 at FS-61's close; its own plan predicted the minting (`plans/FS61-quadratic-census.md` §M2: "proposed to the
owner as a stub at the close"), and both of its sweeps recommended it (`data/fs61/CLOSE-proposals.md` F.4). Written for a reader
with no conversation memory. Read beside: `CLAUDE.md` G54 (tight or slack), G61 (2), row 67 (the towers), row 72 (the 3-adic
barrier); `plans/FS58-four-colours.md` §0 O7 and D3.4; `plans/FS61-quadratic-census.md` §PA "Headline 3".*

## 1. The question, in plain language

Take two graphs. `G` is 3-colourable and **Hoffman-tight at three colours** — its least eigenvalue is exactly `−d/2`, so every
3-colouring of it is balanced and *gap-free*: every vertex sees both other colours (G54; the 3-adic plane `UD(𝔽₉, 2)` and every
level of its tower are like this, row 72). `H` is **not** 3-colourable (a residue plane at 7, 11, 19, 23). Their categorical product
`G × H` — pairs, adjacent when both coordinates are — is 3-colourable by pulling back a colouring of `G`.

> **Is every 3-colouring of `G × H` pulled back from `G`?**

FS-58 measured *yes* at `H = UD(𝔽₇, 2)` and `UD(𝔽₁₁, 2)` with `G` the 3-adic plane (§0 O7: "rigid tensored with any non-3-colourable
residue plane"), and **its plan leaned on it as if it were a theorem** (D3.4: the quotient screens are blind because periodic
colourings are affine). It is not a theorem anyone here has found.

## 2. What is known, and what is NOT

* **It is not `[ElZaharSauer1985]`, and not multiplicativity at all.** Multiplicativity says *which factor* of a product maps to
  `K₃`; it says nothing about what a colouring of the product looks like (`[Zhu2025]` Def. 3.1, Thms 4.1–4.5, via FS-61's sweep).
* **The nearest printed statement is `[GreenwellLovasz1974]`'s** (read in full at FS-89's close): Theorem 1 — for connected `G`
  whose `n`-colourings are all gap-free, every `n`-colouring of `Kₙ × G` is induced by one factor — and its Corollary 1, *if `G`
  is connected and `χ(G) > n` then `Kₙ × G` is uniquely `n`-colourable* (verbatim as `[Tardif2008]` §4.2 quotes it). The factor
  whose colourings are pulled back is `Kₙ` itself, or `Kₙ^s` iterated (the banner above). For a general *uniquely* 3-colourable
  factor it is Duffus–Sands–Woodrow's statement B(n) (1985), conjectural. **Of the four originals only Greenwell–Lovász has been
  read**; Duffus–Sands–Woodrow, Häggkvist–Hell–Miller–Neumann-Lara and El-Zahar–Sauer stay relays (`BIBLIOGRAPHY.md` § R.4).
* **As FS-58's stub worded it, the statement is FALSE** [checked by FS-61's planner]: `G = C₅` coloured `(0,1,0,1,2)`, `H = K₄`.
  The vertex of `C₅` coloured 1 has both neighbours coloured 0, so recolouring the single vertex `(1, a)` of `C₅ × K₄` to colour 2
  is proper and does not factor through `C₅`. The obstruction is a **gap** — a vertex that does not see both other colours.
* **The repairing hypothesis is gap-freedom**, which a Hoffman-tight `G` has in *every* 3-colouring (Blokhuis–Brouwer–Haemers
  via `[AbiadEtAl2025]`; G54). So the conjecture is: **`G` Hoffman-tight at three colours (or merely: every 3-colouring of `G`
  gap-free), `H` connected with `χ(H) > 3` ⟹ every 3-colouring of `G × H` factors through `G`.**
* **An unverified sketch exists** (FS-61's prior-art sweep): an eigenvalue argument for tight `G` and `H` with `λ_min(H)/d(H) > −1/2`
  — by Weil, the residue planes from about `q = 17` up; the measured cases `q = 7, 11` are *outside* it. Nobody has checked it.
* **Where it bites beyond FS-58:** FS-61's phase A.7 found periodic 3-colourings of 3-non-integral lattices factoring through
  groups of order 27 … 4096, one through `(ℤ/8)⁴` — a pure 2-group — and **found no rule** for which quotients carry non-affine
  colourings. A quotient that is 3-colourable but *not* tight is exactly where colourings stop being pulled back; this stub's
  statement is the clean half of that missing rule. And FS-64's §3a (regular mixed colourings are colourings of a tensor
  product) lives in the same algebra from the other side.

## 3. Deliverables, cheapest first

| # | what | cost |
|---|---|---|
| D1 | **The prior-art gate, properly** (WORKFLOW 3.2, items 5–8): Duffus–Sands–Woodrow 1985, HHMN 1988, `[Larose2002]` (the tight case for `K_k^s` in exponential-graph form, by its review), Tardif's survey — *read*, not relayed; zbMATH author listings for each; the reconfiguration literature's "frozen" colourings of products. Greenwell–Lovász 1974 is read (FS-89's close): the tight case is printed for `G = K_k^s` only, so the stub does not close as a citation | hours + the papers (§ R.4) |
| D2 | **Exhaustive small cases**: every Hoffman-tight 3-colourable Cayley graph on ≤ ~100 vertices against `K₄`, the Moser spindle, `UD(𝔽₇,2)`: count 3-colourings of the product against 3-colourings of `G`. One counterexample kills the conjecture as stated | an afternoon, SAT with model counting |
| D3 | **The proof or its obstruction**: check the sweep's eigenvalue sketch; the gap-free case without tightness (is gap-freedom in *every* colouring enough, or is the spectrum doing work?) | open |
| D4 | **The kernel form**, if D3 lands: `Coloring (G ×ˢ H) (Fin 3)` factors through `G` under `GapFree` — row 66's `FanGap` vocabulary already names the hypothesis's negation | days |

## 4. Bearing on χ(ℝ²) ≥ 6, stated honestly

None directly. It is mechanism: the justification under FS-58's blind-screen reading and FS-61's A.7, and the three-colour model of
a statement the programme wants at five colours — *when does a colouring of a product of local targets have to be local at one
place?* — which is the local–global conjecture's shape (G48) and FS-66's and FS-64's common ground.

## 5. Failure and jackpot clauses

* **Jackpot:** the theorem, with gap-freedom as the exact hypothesis — then "quotient screens are blind on tight pools" is derived,
  not measured, and A.7's missing rule has its first half.
* **Informative failure:** a tight `G` and a non-3-colourable `H` with a 3-colouring of `G × H` that is not pulled back. FS-58's
  D3.4 reading and G61 (2) would then be measurements of two planes and nothing more, and would be reworded.

**Provisional bearings, added 2026-09-23 (FS-73's close):** **G71** — on a lattice graph the three-colourings are governed by `Θ₃`, and at ℚ(√11)'s `Λ₁₀` "every colouring is affine" is now a theorem (16 isolated points of order 3; `plans/FS73-derivation.md` T25) — one of the two measured facts under G61 (2) that this stub was to justify, proved by a different route (the character torus, not the product). **A caution from FS-73's plan stage** (Poros, G59): a finite-`U` quotient `Cay(Λ/NΛ, U mod N)` is a *diagonal subgraph* of the product of its residue targets, not the product, so FS-58's tensor identification does not transfer to lattice quotients; this stub's question stays about the true categorical product.

## Where the 2026-09-25 work on this lives

*Addresses and titles only, added by the 2026-09-25 crunch's bookkeeper (job J30). The index of that day's work, with its results, is `plans/CRUNCH-2026-09-25-INDEX.md`; a blind verifier does not open it.*

- `plans/M3-S1D-windows-five.md` §3.2 and §3.6 — job J21's record: products of a measured graph with compact Cayley factors
- `plans/M3-close-inventory.md` rows 16, 21, 22 — the related items
