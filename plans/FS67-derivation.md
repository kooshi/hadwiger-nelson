# FS-67 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Written 2026-09-25 at FS-67's close (WORKFLOW 2.0 step 9) by crunch job J42 (de Bruijn, Opus 5.5, FS-67's close planner), from the plan
(`plans/FS67-tight-products.md`, the planner J27), the derivation record (`plans/FS67-J27D-derivation.md`, J27D) and the blind verification
(`plans/FS67-J27V-verification.md`, J27V). Grades are `CLAUDE.md` § Notation's, as each record gives them. A proof held in a record is not
repeated here; this file is the index that survives the ledger rows' compression. `LEDGER.md` § B will index every entry, one line each
(drafted in the plan's §R-close; `tools/fs71_ledger_b_check.py --strict`). **FS-67 added no Lean**, so nothing below is kernel-checked;
every kernel decision is recorded per entry.*

**Duplicates are merged, one entry per theorem.** An entry carries the id this file gives it; its title names every id the records give the
same theorem (J27D's table row `#n`, J27V's `J27V-Tn`), so a grep for either lands here. Independence is stated in the records' own words:
**blind** means J27V had seen neither J27D's derivation nor its statement (J27V's stages 1–2, committed at `e0762228` before J27D's record was
opened); **from the statement** means J27V had seen J27D's "Theorems this phase proved" table, not the proofs (J27V's stage 3). J27V's fence log
records one exposure: the stub's one-sentence sketch of DA-2′ ("every loop of `K_k^G` is adjacent only to itself …", PA-T6), read before its
blind phase. **No verdict of J27V diverges from J27D's** (J27V §4.2); J27V's two additions are filed as their own entries (FS67-DC2S,
FS67-C5).

**Merges and declines, explicit** (every "Theorems this phase proved" line of the three records has an entry or a line here):
- J27D `#7` (the link `χv = 1 + r/|λ_min|` for 1-walk-regular graphs) is `[GodsilRobersonRooney2017]` Thm 4.9 and Cor. 4.10, quoted [external],
  not a theorem of this milestone — filed as FS67-DC1's input.
- J27D `#9` ((M) the mixing inequality; (P) plurality is proper at `λ* < 1/(k−1)`) is M3-J21-MX's engine and selection (filed in
  `plans/M3-derivation.md`), re-derived in finite form with the argmax selection in place of J21's threshold selection — no new entry; they are
  FS67-DC2's first two steps.
- J27D `#15` (Lemma T) is filed as FS67-T; its abelian-Cayley case is FS38-D2-A (i), (iv) (filed), and its content is the equality case of
  Hoffman's ratio bound (Blokhuis–Brouwer–Haemers), which `CLAUDE.md`'s prior-art position lists as not ours.
- J27V-T5 (V-DB-1) and J27V-T10 (V-DD-2) are GAPs, not theorems; their proved parts are FS67-DB1R, FS67-W, FS67-DB1Z, FS67-C5 and FS67-DD2R,
  FS67-DD2N. The GAPs themselves are §5 (no entry format).
- The plan's J27 records claim nothing ("Planning job: none claimed").

**Who found what.** **J27** (the planner): the claim list and routes (§4.3, §5.1), graded [reading]. **J27D** (derivation): table rows `#1`–`#19`.
**J27V** (blind verifier; blind phase stages 1–2; stage 3 from J27D's statements; stage 4 the divergence table): J27V-T1 to T10, the C₅ structure,
the sharpness of DC-2, and the three DC-3 spot checks. **J40** (the close-time prior-art gate): FS67-CL, an observation, checked here in one step. **J42** (this close): no theorem of its own; the
file, and FS67-CL's one-step check.

**Notation, fixed once** (the plan's §4.1, verbatim): "Graphs are simple and loopless; `k ≥ 3`. A proper `k`-colouring `c` of `G` is *gap-free*
if every closed neighbourhood `N[x]` meets all `k` colours. `G` is *`k`-gap-free* if it is `k`-colourable and every proper `k`-colouring of it is
gap-free. A `k`-colouring `β` of `G × H` (categorical product) is *pulled back from `G`* if `β(x, h) = c(x)` for some `k`-colouring `c` of `G`.
`E_k(G)` is the graph on the maps `V(G) → [k]` that are not proper colourings, `f ∼ g` iff `f(u) ≠ g(v)` for every ordered edge `(u, v)` of `G`.
**FS67(G, k)**: "for every connected `H` with `χ(H) > k`, every proper `k`-colouring of `G × H` is pulled back from `G`"." `K_k^G` is the
exponential graph (all maps, with loops at the proper colourings); `Φ_β : h ↦ β(·, h)` is the fibre map (currying: `β` proper ⟺ `Φ_β` a
homomorphism `H → K_k^G`). `λ*` of `H = Cay(A, T)` is `max_{χ ≠ 1} |Σ_{t ∈ T} χ(t)|/|T|`; `χv` is the vector chromatic number.

**Scope, stated once.** Every statement is about abstract graphs and their categorical products; none is about a field plane or `χ(ℝ²)`.
**Bearing on χ ≥ 6: none.** "Not found in print" is not "new"; every *Prior art:* field is **pending J40** (the close-time gate,
`plans/FS67-PA-close.md`) until its verdicts are copied in at this close's last stage.

## §1. The Hedetniemi transfer: gap-freedom, the exponential graph, and the negative at `k ≥ 4`

**FS67-DA1 — DA-1′ (= J27D #1, J27V-T1): "If `G` is `k`-colourable but not `k`-gap-free, then for every graph `H` with at least two vertices there is a proper `k`-colouring of `G × H` not pulled back from `G`." [hand; two blind derivations: J27D §Stage 2 recolours one gapped vertex in one fibre; J27V §2.1 maps `H` onto two adjacent loops of `K_k^G`]**
*Proof:* J27D §Stage 2 "DA-1′"; J27V §2.1 with Lemma L0. Check `tools/crunch_j27d_da.py` part A → `data/fs67/j27d/da.out` (`G = C₅`,
`c = (0,1,0,1,2)`, `H = K₄`: proper, not pulled back); plant (recolour into `c(N(1))`) → `da-plant.out`, fires. *Proof verdict:* closes, twice.
No connectivity of `G` or `H`, no edge of `H`, any cardinality (J27D's hypothesis-use line; J27V: "With no edges in `H` the statement is still
true"). *Rests on it:* FS67-DA2's characterisation (the non-gap-free half); the stub's `C₅ × K₄` counterexample (FS-61's planner) as an
instance. *Prior art:* pending J40. The records: the stub's `C₅ × K₄` instance (FS-61's planner); `[GreenwellLovasz1974]` Thm 1's hypothesis is
gap-freedom (PA-P1, `plans/PA-products-GL1974-LT2002.md`). *Kernel:* stub (FS-67's D4: the gap is row 66's `FanGap`; a small finite statement).

**FS67-L1 — Lemma L1, loops are isolated (= J27D #2, J27V Lemma L0): "If `c` is a gap-free proper `k`-colouring of `G`, its only neighbour in `K_k^G` is `c`"; conversely a gap at `u` gives a second proper colouring adjacent to `c` (J27V's L0). [hand; two derivations: J27D §Stage 2; J27V §2, which had read the stub's one-sentence statement of it (fence log)]**
*Proof:* J27D §Stage 2 "Lemma L1"; J27V §2 "Lemma L0 (loops)". Check `tools/crunch_j27d_da.py` part B (`G = K₄`, `k = 4`: all 24 proper
colourings have only themselves as neighbour; `G = C₅`, `k = 3`: the gapped `c` has another). *Proof verdict:* closes, twice. *Rests on it:*
FS67-DA2, FS67-DA1 (J27V's route). *Prior art:* pending J40. The records: stated at FS-89's close as part of PA-T6 (`plans/PA-tardif2023.md`
§5.4, hand, one mind, not filed in a derivation file); Case 1 of `[GreenwellLovasz1974]`'s proof at `G = K_k` (PA-P2). *Kernel:* stub
(FS-67's D4).

**FS67-DA2 — DA-2′ and the characterisation (= J27D #3, J27V-T2; = PA-T6): "If `G` is `k`-gap-free, then FS67(G, k) holds if and only if `χ(E_k(G)) ≤ k`"; with FS67-DA1, FS67(G, k) ⟺ every proper `k`-colouring of `G` is gap-free ∧ `χ(E_k(G)) ≤ k`, and for non-`k`-colourable `G` it reads FS67(G, k) ⟺ `χ(K_k^G) ≤ k`, Hedetniemi's `H(k)` for `G`. [hand; two derivations of DA-2′: J27D §Stage 2; J27V §2.2, blind to J27D, having read PA-T6's one sentence; the characterisation J27D's, checked by J27V §4.2]**
*Proof:* J27D §Stage 2 "DA-2′" (⟸ by L1 and connectivity of `H`; ⟹ by a component `D` of `E_k(G)` with `χ(D) > k` and `β(u, f) = f(u)`; the
axiom of choice when `G` is infinite) and its "By-product"; J27V §2.2 and §4.2 row V-DA-2′. *Proof verdict:* closes, twice; gap-freedom is used
only in ⟸, through L1; no finiteness of `G` or `H`. *Rests on it:* FS67-DA3 (⟹), FS67-DB1R, the stub's re-aim; the §IQ invariant (the fibre
map lands in `E_k(G)` or is constant at a loop). *Prior art:* pending J40. The records: PA-T6 (`plans/PA-tardif2023.md` §5.4, one mind, FS-89's
close); Greenwell–Lovász is the case `G = K_k` (FS67-GL); multiplicativity's exponential-graph criterion (`[TardifWrochna2019]` §1.2, "a graph
K is multiplicative if and only if K^G admits a homomorphism to K, for all G that do not") is the non-`k`-colourable side. *Kernel:* stub
(FS-67's D4; Mathlib has no exponential graph, which the port would define).

**FS67-GL — Greenwell–Lovász re-derived as FS67(K_k, k) (= J27D #4): for `k ≥ 3`, `γ(f)` = the least colour a non-injective `f : [k] → [k]` repeats is a proper `k`-colouring of `E_k(K_k)`, so by FS67-DA2 every `k`-colouring of `K_k × Y` (`Y` connected, `χ(Y) > k`) is a bijection of the `K_k` coordinate — `K_k × Y` is uniquely `k`-colourable. [hand, one mind (J27D); check exact; J27V took the statement as an input, GreenwellLovasz1974 Cor. 1]**
*Proof:* J27D §Stage 2 "DA-3 (b)". Check `tools/crunch_j27d_da.py` part C: `γ` proper on `E_3(K_3)` (21 vertices, 30 edges) and `E_4(K_4)` (232,
1,314); plant (least *missing* colour) gives 2 and 122 monochromatic arcs, fires. *Proof verdict:* closes (one mind; the statement is printed).
*Rests on it:* FS67-DA3 (b), (c), (e) in J27D's route. *Prior art:* the statement is `[GreenwellLovasz1974]` Cor. 1 (read in full at FS-89's
close); the selection `γ` is Case 2's `γ′` of their proof (PA-P2, `plans/PA-products-GL1974-LT2002.md`); J40's verdict pending. *Kernel:* stub
(FS-67's D4; the stub names `γ′` as a candidate kernel form beside PA-T6).

**FS67-DA3 — DA-3 (= J27D #5, J27V-T3): "For `k ≥ 3` and a connected graph `X` with `χ(X) > k`, the graph `G = K_k × X` is connected and uniquely `k`-colourable, hence `k`-gap-free; and FS67(K_k × X, k) fails if and only if some connected graph `H` with `χ(H) > k` has `χ(X × H) ≤ k`." [hand; two blind derivations: J27D §Stage 2 with GL re-derived (FS67-GL); J27V §2.3 with GreenwellLovasz1974 Cor. 1 as input]**
*Proof:* J27D §Stage 2 "DA-3" (a)–(e): Weichsel's connectivity re-derived for any cardinality; unique colourability; gap-freedom; ⟸ by
`β((i, x), h) = c(x, h)`; ⟹ by GL on `K_k × (X × H)`. J27V §2.3. *Proof verdict:* closes, twice; J27V §4.2: "J27D's route is stronger (no
input)". *Rests on it:* FS67-DA4, FS67-DD2R; the §IQ "for a no" invariant (a Hedetniemi pair hidden in `E_k(G)`). *Prior art:* pending J40. The
records: `[Tardif2008]` §4.2 quotes Duffus–Sands–Woodrow's `B(n)` ("If G is uniquely n-colorable, H is connected, and χ(H) > n, then G × H is
uniquely n-colorable") and "In [17] it is proved that A(n) implies B(n) and B(n) implies H(n)" — DA-3 is an explicit form of `B(n) ⟹ H(n)`
at the construction `K_k × X`, with gap-free in place of uniquely colourable; `[DuffusSandsWoodrow1985]` not held. *Kernel:* stub (FS-67's D4;
needs FS67-GL and Weichsel's theorem, cited and not held).

**FS67-DA4 — DA-4, the negative from four colours up (= J27D #6, J27V-T4): "For every `k ≥ 4` there is a finite connected uniquely `k`-colourable graph `G` for which FS67(G, k) fails; and for every `k ≥ 3`, if FS67(G, k) holds for every finite connected `k`-gap-free `G`, then `χ(X × H) > k` for all finite graphs `X`, `H` with `χ(X), χ(H) > k`." [hand, from Tardif 2023 Thm 1 (external, read; its graphs finite by its §2); two blind derivations: J27D §Stage 2; J27V §2.4]**
*Proof:* J27D §Stage 2 "DA-4" (`[Tardif2023]` Thm 1 at `n = k`, `m = k + 1`; components of maximal `χ`; FS67-DA3 ⟸); J27V §2.4. *Proof verdict:*
closes, twice; both read the finiteness of Tardif's `G = Ω_w(K_m)` and `H = K_n^G` in his §2. **Headline, at exact scope:** the gap-free form of
FS-67 — even restricted to finite, connected, *uniquely* `k`-colourable `G` — fails at every `k ≥ 4`, witnessed by `G = K_k × X` for a
Hedetniemi pair `(X, H)`; it needs neither Duffus–Sands–Woodrow, nor `[Shitov2019]`, nor a monotonicity-in-`k` lemma (J27D). At `k = 3` the second
clause's conclusion is El-Zahar–Sauer's `H(3)`, which is true, so this route leaves `k = 3` open (FS67-DB1R, §5). *Rests on it:* the stub's
re-aim (the jackpot "gap-freedom as the exact hypothesis" is dead at `k ≥ 4`); the drafted `LEDGER.md` row and `CLAUDE.md` G54 line. *Prior art:*
pending J40. The records: J27's §PA 3.1 calls it "prior art by composition" — `[Tardif2008]` §4.2's `B(n) ⟹ H(n)` (Duffus–Sands–Woodrow 1985)
with `[Tardif2023]` (H(4) false) and `[Shitov2019]` gives `B(n)` false for every `n ≥ 4`; whether that consequence is stated in print is J40's
question. *Kernel:* declined — rests on `[Tardif2023]`'s construction [external]; the reduction step alone is FS67-DA3's stub.

**FS67-CL — the clique class (J40's observation, `plans/FS67-PA-close.md` Stage 2): FS67(G, k) holds for every graph `G` in which every vertex lies in a `k`-clique, the Burr–Erdős–Lovász class. [hand, one mind (J40, from GreenwellLovasz1974 Cor. 1 and Csernák 2023's Lemma 3.5, "not checked here beyond reading the two proofs it combines"); checked in one step by J42]**
*Proof:* J40 Stage 2 ("GL Cor. 1 on each clique, glued along overlaps as in Csernák's Lemma 3.5"). The one step (J42's check): for a vertex
`x` in a `k`-clique `Q`, `β` restricted to `Q × H ≅ K_k × H` is `σ_Q ∘ π₁` by GL Cor. 1 (`H` connected, `χ(H) > k`), so `x`'s fibre is constant;
all fibres constant is a pullback (`H` has an edge). No gluing and no connectivity of `G` is needed. *Proof verdict:* closes. *Scope:* such a `G`,
if `k`-colourable, is `k`-gap-free (each vertex sees the other `k − 1` colours in its clique); if not, the statement says `G × H` has no `k`-colouring,
which is Burr–Erdős–Lovász's `χ(G × H) = min` for this class (`[Tardif2008]` Thm 3.2). *Rests on it:* the drafted ledger row 114 (a class where
FS-67 holds with no spectral hypothesis, beside `K_k^s`, PA-P3). *Prior art:* J40 (verbatim): "a class J27D does not name"; its ingredients are
`[GreenwellLovasz1974]` Cor. 1 and Csernák 2023 (arXiv:2303.06406) Lemma 3.5, whose Thm 3.6 is the `A(n)`-type neighbour; not searched as a
statement. *Kernel:* stub (FS-67's D4; the smallest target of the family, given GL Cor. 1).

## §2. Spectral pullbacks: the strict regime

**FS67-DC1 — DC-1 (= J27D #8, J27V-T7): "If `G` is 1-walk-regular with `χv(G) = k` and `H` is connected with `χv(H) > k`, then every proper `k`-colouring of `G × H` is pulled back from `G`"; for 1-walk-regular `G`, `χv(G) = k` ⟺ `G` is Hoffman-tight at `k` (GRR2017 Thm 4.9, external), so DC-1 reads "1-walk-regular and Hoffman-tight at `k`", and against a 1-walk-regular `H` its hypothesis is `|λ_min(H)|/d(H) < 1/(k−1)`. [hand, conditional on GodsilEtAl2020 Results 1 and 4 with its §1.2 (J27D) or Thm 4.16(1) (J27V), external, read; two blind derivations]**
*Proof:* J27D §Stage 3 "DC-1" (the simplex vector colouring is optimal by Result 1; Result 4 makes its Gram matrix induced by `G`; unit vectors
with inner product 1 coincide); J27V §2.7 (the same colouring in GEA's normalisation; Thm 4.16(1)). *Proof verdict:* closes, twice, given the
external input; finite graphs (GRRSV's SDP setting). *Reach:* `χv(H) ≤ χ_f(H)`, so DC-1 never sees the gap `χ_f(H) ≤ k < χ(H)`; it needs no
vertex-transitivity of `H`, unlike `[Zhang2012]` Thm 1.8 (i) (J27D). *Rests on it:* FS67-DD2N (the 1-walk-regular negation); FS67-DC3's `Y`
column; FS67-DB2's consumer sentence (every tight 3-adic level against every `H` with `χv(H) > 3`). *Prior art:* pending J40. The records: J27's
§PA 3.1 finding 2 reads it off `[GodsilEtAl2020]` Result 4 ("if G is 1-walk-regular and H is connected with χv (G) < χv (H), then all of the
optimal vector colorings of G × H are induced by G"); the passage from vector colourings to proper colourings is the one step added. *Kernel:*
declined — rests on semidefinite duality results [external].

**FS67-DC2 — DC-2 at Pak–Vilenchik's threshold (= J27D #10 with #9's steps, J27V-T8): "If `G` is connected and `k`-gap-free, and `H = Cay(A, T)` for a finite abelian group `A` with `λ* = max_{χ ≠ 1} |Σ_{t ∈ T} χ(t)|/|T| < τ_k`, then every proper `k`-colouring of `G × H` is pulled back from `G`", with `τ_k = 1/(k−1)`, and "connected" deleted: it holds for every `k`-gap-free `G`, connected or not, finite or not. [hand; the algebra checked exact; two blind derivations: J27D §Stage 3; J27V §2.8, from M3-J21-MX's mixing lemma; the bootstrap is the same map in both]**
*Proof:* J27D §Stage 3 "DC-2": (M) mixing, `r(m_c(x))·r(m_c(y)) ≤ λ*²` for `x ∼ y`, `r(μ) = μ/(1−μ)`; (P) the plurality colouring is proper, hence
gap-free; (B) the bootstrap `e ↦ F(e) = se/(1 − (k−1−s)e)`, `s = (k−1)λ*²`, with `e* − e₀ = (1 − (k−1)s)/((1+s)(k−1−s))` positive iff `λ* < 1/(k−1)`.
J27V §2.8: the same bootstrap from J21-MX's threshold selection, `F(ε)/ε < 1` ⟺ `((k−1)λ* − 1)(λ* + 1) < 0`. Checks `tools/crunch_j27d_dc.py`
part A → `data/fs67/j27d/dc.out`: both identities reduce to 0 in sympy; exact rational iteration at `λ* = 1/(k−1) ∓ 1/1000`, `k = 3, 4, 5, 8`,
descends below the threshold (`e₄₀ ≤ 5·10⁻¹¹`) and does not start above it. *Proof verdict:* closes, twice. `H`'s connectivity,
non-bipartiteness and `χ(H) > k` are consequences of `λ* < 1/(k−1)`, not hypotheses (both records). With `A` compact abelian and `β` measurable the
conclusion holds almost everywhere on each fibre (J27D, one mind, a remark). *Rests on it:* FS67-DC2S; FS67-DC3's reading; FS67-DD2N (the
abelian-Cayley negation); the drafted `CLAUDE.md` G54 line and G61 (3) edit (the 11 half). *Prior art:* pending J40 (J27D's debt: "uniquely
colourable graph × expander" unsearched). The records: at `G = K_k` it is `[PakVilenchik2013]` Thm 3 ("Let H be an r-regular graph with λ < r/(k
− 1). Then G = Kk ⊗ H is uniquely k-colorable"); its steps (M), (P) are M3-J21-MX's (filed; "not found as stated" by J23cpa); `[GodsilEtAl2020]`
Result 4 puts a spectral condition on `G` and none on `H` beyond `χv(H) > k`, DC-2 the reverse. *Kernel:* declined for now, as M3-J21-MX's was
(no consumer in the kernel; the gate first); a candidate in this finite form (Parseval on a finite abelian group and a contraction).

**FS67-DC2S — DC-2's constant is sharp for the claim (J27V's addition, §2.8, §4.2): `H = K_k = Cay(ℤ/k, ℤ/k ∖ 0)` has `λ* = 1/(k−1)` exactly, and `(x, a) ↦ a` is a proper `k`-colouring of `G × K_k` not pulled back from `G`; so no `τ_k > 1/(k−1)` makes DC-2 true. [hand, one mind (J27V); J27D showed only that its method stops at the threshold]**
*Proof:* J27V §2.8 "Sharpness". *Proof verdict:* closes (one line: `λ*(K_k) = |−1|/(k−1)`; the colouring ignores `G`). *Rests on it:* the
drafted ledger row's "sharp". *Prior art:* pending J40; the `K_n` case of the mixing selection is Burr–Erdős–Lovász (`[Tardif2008]` Thm 3.2, as
M3-J21-MX records). *Kernel:* declined (a two-line remark; no consumer).

**FS67-DC3 — DC-3, the residue planes as `H` (= J27D #11; three rows re-computed by J27V): among `Γ_p = UD(𝔽_p, 2)` for primes `p ≡ 3 (mod 4)`, `p ≤ 103`, DC-1's and DC-2's hypotheses on `H` hold together at `k = 3` from `p = 11`, at `k = 4` from `p = 23` (at 31 by `1/3 − λ* = 4.88·10⁻⁶`), at `k = 5` from `p = 59`; `Γ₃` and `Γ₇` meet neither at any `k ≤ 5`; the two hypotheses never split on this table. [tools: 50-digit arithmetic with controls (J27D); rows `p = 7, 11, 31` re-computed from all `p²` characters at 60 digits, matching to every printed digit (J27V)]**
*Proof:* J27D §Stage 3 "DC-3" and `data/fs67/j27d/dc.out` part B (controls: `λ_min/d = −1/2` at 3; `λ_min + d/3 = 1.5617·10⁻⁴` at 31, G54's number;
plant, one antipodal pair dropped from every circle, fires at the 31 control); J27V §4.3, `tools/crunch_j27v_dc3.py` → `data/fs67/j27v/dc3.out`
(plant: the antipodal pair `(±1, 0)` dropped, mismatches at all three rows, `dc3-plant.out`; J27V's first plant, the circle `x² + y² = 2`, could
not fire and was replaced). *Proof verdict:* holds as a table, twice at three rows. *Reading* (J27D): at `k = 3` every `Γ_p`, `p ≥ 11`, is an `H`
against which every 3-gap-free `G` pulls back; `Γ₇` sits in the gap regime (`χv(Γ₇) = 2.78 < 3 < χ(Γ₇) = 4`); at `k = 5` the regime starts at
59, where Hoffman already refuses five colours (G44). *Rests on it:* the drafted G61 (3) edit (11 inside, 7 outside). *Prior art:* the spectra are
G44's (Kloosterman); pending J40 for nothing further. *Kernel:* declined (a tools table; no consumer).

## §3. Three colours: the reformulation, the winding and its zero class

**FS67-DB1R — the DB-1 reformulation (= J27D #12, J27V-T5 item 1): for any `G`, `χ(E_3(G)) ≤ 3` ⟺ every proper 3-colouring of `G × H`, `H` connected with `χ(H) > 3`, has at least one fibre `β(·, h)` that is a proper colouring of `G`. [hand; two blind derivations: J27D §Stage 4; J27V §2.5 item 1]**
*Proof:* J27D §Stage 4 "Reformulation" (from FS67-DA2's currying); J27V §2.5 item 1. *Proof verdict:* closes, twice. *Rests on it:* the named GAP
(§5.1): DB-1 is the statement that a proper fibre always exists. *Prior art:* pending J40. *Kernel:* stub (FS-67's D4, with FS67-DA2).

**FS67-W — Lemma W, the two-step winding (= J27D #13, J27V-T5 item 3): for an odd closed walk `C = (c₀, …, c_{L−1})` of `G` and any map `f : V(G) → ℤ/3`, `D_C(f) = Σ_{j<L} δ₂(f(c_{2j}), f(c_{2j+2}))` (`δ₂(a, a) = 0`, `δ₂(a, a−1) = +2`, `δ₂(a, a+1) = −2`) satisfies `D_C(f) = D_C(g) = 3·w_C(f, g)` on every arc `(f, g)` of `K_3^G`, `w_C` the winding of the interleaved walk; so `D_C` is constant on every component of `K_3^G` with an edge, `3 ∣ D_C`, and a proper colouring has `D_C = 6u`, `u` odd. J27V's form: `w₂^c(f) = (1/3)Σ δ(f(v_{i+2}) − f(v_i))`, constant on components, odd and non-zero on proper colourings; the two agree, `D_C = −6w₂^c`. [hand; two blind derivations; check exact]**
*Proof:* J27D §Stage 4 "The winding invariant (Lemma W)"; J27V §2.5 item 3; the identification J27V §4.2 row V-DB-1. Check `tools/crunch_j27d_db.py`
part A → `data/fs67/j27d/db.out`: all 1,026 arcs of `K_3^{C₅}` satisfy it; `E_3(C₅)` has 213 improper maps, `D` = 0 on 153 and ±6 on 30 each, and the
±6 maps span 60 edges; plant (sign of `δ₂` flipped) gives 270 violations, fires (`db-plant.out`). *Proof verdict:* closes, twice. *Rests on it:*
FS67-DB1Z; FS67-C5; the named GAP's statement (§5.1). A component carrying a loop has every `D_C ≠ 0`, so the gap lies exactly in the loopless
components of non-zero winding. *Prior art:* pending J40. The records: the interleaved walk is `[TardifWrochna2019]` §1.2's; the two-step
invariant as a vertex function is not attributed in either record. *Kernel:* declined (no consumer until the GAP closes).

**FS67-DB1Z — DB-1 on the zero class (= J27D #14, J27V-T5 item 4): a component `Q` of `E_3(G)` with `D_C ≡ 0` for some odd closed walk `C` of `G` is 3-colourable; hence, for connected 3-gap-free `G`, every 3-colouring `β` of `G × H` (`H` connected, `χ(H) > 3`) is pulled back from `G` unless `Φ_β(H)` lies in a component of `E_3(G)` with `D_C ≠ 0` for every odd `C`. [hand, given TardifWrochna2019 §3, external, not re-derived; two blind derivations]**
*Proof:* J27D §Stage 4 "What Lemma W settles" (restriction to `C` lands in the winding-0 arcs, `K_ε^C = τ(U(K₃)^C)`, TW §2.2; TW §3's median
homomorphism for square-free targets); J27V §2.5 item 4 (which notes the identification "winding zero = the constants' component" is TW's,
unchecked). *Proof verdict:* closes given the external input, twice. *Rests on it:* the partial form of DB-1's second clause; the named GAP's
complement. *Prior art:* the zero-class colouring is `[TardifWrochna2019]` §3's [external]; pending J40. *Kernel:* declined (rests on TW §3).

**FS67-C5 — the non-zero-winding part of `E_3(C₅)` is 3-colourable (J27V's addition, §2.5 item 5, §4.2): in each class `w₂ = ±1` there are 45 maps — 15 loops, 15 improper maps of type A and 15 of type B; each type-A map has exactly two type-A improper neighbours, one type-B and one loop, each type-B map exactly one (type-A) neighbour; so the improper part is a 2-regular graph with pendant leaves, 3-colourable, and `C₅` is no counterexample to DB-1's first clause at its non-zero class. [hand, one mind (J27V); its counts agree with J27D's exact evaluation, 60 maps and 60 edges]**
*Proof:* J27V §2.5 item 5; the counts against `data/fs67/j27d/db.out` (J27V §4.2). *Proof verdict:* closes (one mind; counts cross-checked).
*Scope:* `C₅` is not 3-gap-free (J27D's PB-1 note: a refusal at `C₅` "is FALSE for DB-1's first clause (not for its gap-free clause)";
its DA-1′ check uses a gapped colouring of `C₅`), so this is an instance of DB-1's first clause, not of its gap-free clause; the zero class at `C₅` rests on TW §3 [external]. *Rests on it:* post-ban stage PB-1 retired at `C₅` (J27V: "J27D's post-ban PB-1 cannot
refuse at `C₅`"). *Prior art:* none sought (an instance). *Kernel:* declined (an instance; a decide-sized check if ever wanted).

**FS67-T — Lemma T, tight ⟹ gap-free (= J27D #15): if `G` is `d`-regular on `n` vertices with `λ_min = −d/(k−1)`, every proper `k`-colouring has all classes of size `n/k` and every vertex has exactly `d/(k−1) > 0` neighbours in each other class, so it is gap-free. [hand, one mind (J27D); J27V used the same fact through G54]**
*Proof:* J27D §Stage 4 "Lemma T" (the ratio bound with equality; `1_S − (1/k)𝟙` is a `λ_min`-eigenvector). *Proof verdict:* closes. *Rests on it:*
FS67-DB2; FS67-DD2N (ii); the drafted G54 line. *Prior art:* the equality case of Hoffman's ratio bound (Blokhuis–Brouwer–Haemers; `CLAUDE.md`'s
prior-art position, "not ours"); its abelian-Cayley case is FS38-D2-A (i), (iv) (filed). J40 pending for nothing further. *Kernel:* stub (FS-51,
the ratio bound in the kernel; the equality case is its natural second lemma).

**FS67-DB2 — DB-2 (= J27D #16, J27V-T6): "`UD(𝔽₉, 2)`, and every level of the 3-adic tower that is Hoffman-tight at three colours, is connected and 3-gap-free." Level one: the circle has 8 points spanning `𝔽₉²`, spectrum `{8, 5⁸, 2²⁴, −1³², −4¹⁶}` (`λ_min = −4 = −d/2`), 3-coloured by a linear form — J27D's `x₀ + y₀ + x₁`, J27V's derived `Tr((1−i)u + iv)`. Every level `(ℤ₃[i]/3^j)²` is connected (Nakayama / Frattini) and 3-colourable (reduction); tightness per level is the hypothesis, not proved. [hand plus tools exact; two blind derivations with different colourings]**
*Proof:* J27D §Stage 4 "DB-2" and `db.out` part B; J27V §2.6, `tools/crunch_j27v_fq9.py` → `data/fs67/j27v/fq9.out` (plant fires at its C3). *Proof verdict:*
 closes, twice. **Tool note:** neither record planted a fault in the *tightness* check — J27D's two plants (drop a circle point; add
`±(1, 1)`) keep `λ_min = −d/2` and could not fire; the value is cross-checked by hand (the trace-form eigenvalue `−4`) and by J27V's exact spectrum.
*Rests on it:* with FS67-DC2 and FS67-DC3, every three-colouring of `UD(𝔽₉, 2) × Γ₁₁` is pulled back — G61 (3)'s measured "rigid tensored with
the residue plane at 11" is now a theorem; at `Γ₇` it is not reached (FS67-DC3). *Prior art:* pending J40 (tight ⟹ gap-free is FS67-T's
classical content). *Kernel:* declined — no kernel consumer; level one is a decide-sized finite check if FS-58's D3.4 is ever ported.

## §4. The tight and equal cases

**FS67-DD1 — DD-1 (= J27D #17, J27V-T9): "If `χv(G) = χv(H) = k`, `χ(H) > k`, `H` connected, and `G`, `H` satisfy `[GodsilEtAl2020]` Result 5's hypothesis, then every proper `k`-colouring of `G × H` is pulled back from `G`." [hand, conditional on GodsilEtAl2020 Results 1 and 5, external, read; two blind derivations by different routes]**
*Proof:* J27D §Stage 5 "DD-1" (one edge of `H`: the convex weight `a < 1` makes `β(x, ·)` a proper `k`-colouring of `H`, impossible, so `a = 1`); J27V
§2.9 (bounds from an edge of each factor sum to `1 ≤ (k−2)/(k−1)`, false). *Proof verdict:* closes, twice; J27V checked J27D's step
`N̄_{hh′} ≤ −(1−a)/(k−1)`. `χ(H) > k` is used exactly once; graph-connectivity of `H` enters only through Result 5's "connected strictly
complementary dual solutions" (both records). *Not reached:* whether DD-1 covers `[Zhang2012]` Thm 1.8's IS-imprimitive exception (J27D: GAP;
J27V did not verify it; §5.3). *Rests on it:* the equal-`χv` clause of the stub's re-aim. *Prior art:* pending J40; the records read it off
`[GodsilEtAl2020]` Result 5 (J27's §PA 3.1 finding 2, "the vector form of the equal case"). *Kernel:* declined (external SDP results).

**FS67-DD2R — the DD-2 reduction (= J27D #18, J27V-T10's proved part): for `d_X`-regular `X` with adjacency eigenvalues `μ`, `K_k × X` is `(k−1)d_X`-regular with eigenvalues `(k−1)μ` and `−μ`, so `K_k × X` is Hoffman-tight at `k` ⟺ `μ_min(X) ≥ −d_X/(k−1)`; with FS67-DA3, DD-2 holds via `K_k × X` iff there is a Hedetniemi pair `(X, H)` at some `k ≥ 4` with `X` connected, regular and `μ_min(X) ≥ −d_X/(k−1)`. [hand; two blind derivations: J27D §Stage 5; J27V §2.10]**
*Proof:* J27D §Stage 5 "Reduction"; J27V §2.10. *Proof verdict:* closes, twice ("the reductions are identical", J27V §4.2). *Rests on it:* the named
GAP (§5.2) and post-ban stage PB-2. *Prior art:* the spectrum of a tensor product is classical; pending J40 on the pair. *Kernel:* declined.

**FS67-DD2N — where a tight counterexample cannot live (= J27D #19; J27V agrees, §2.10 and §4.2): for every Hoffman-tight `k`-colourable `G` (tight ⟹ gap-free, FS67-T), no `H = Cay(A, T)` with `λ* < 1/(k−1)` witnesses the failure of FS67(G, k) (FS67-DC2); for 1-walk-regular tight `G`, every witness `H` has `χv(H) ≤ k < χ(H)` (FS67-DC1). So a tight counterexample, if one exists, lives in the gap regime of `H`, where Hedetniemi counterexamples live (one factor of a pair has `χ_f ≤ k`, `[Zhu2011]`). [hand; J27D; the 1-walk-regular half derived independently by J27V §2.10, the abelian-Cayley half checked by J27V §4.2]**
*Proof:* J27D §Stage 5 "Constraints any witness obeys" (i)–(iii); J27V §2.10 and §4.2 row V-DD-2 ("J27D's two negations for named classes follow
from DC-1 and DC-2, and I agree with both"). *Proof verdict:* closes (compositions of FS67-T, FS67-DC1, FS67-DC2). *Rests on it:* the stub's DD-2
residue. *Prior art:* pending J40. *Kernel:* declined (compositions of declined entries).

## §5. What is not proved: the named gaps (no entries)

**§5.1 DB-1 — GAP, the same step reached by two blind routes** (J27D §Stage 4; J27V §2.5, §3, §4.2). The claim (plan §4.3): "For every connected
non-bipartite graph `G`, `χ(E_3(G)) ≤ 3`; hence FS67(G, 3) holds for every connected 3-gap-free graph `G`." Proved: the non-3-colourable case
(El-Zahar–Sauer's `H(3)`, [external], via `[TardifWrochna2019]` Thm 1 in J27D, via `[Tardif2023]` §1 in J27V); the zero class (FS67-DB1Z); the
`C₅` instance (FS67-C5). **The missing step (J27D's words):** "a 3-colouring of the nonzero-winding part of `E_3(G)` built without "G is not
3-colourable"" — components of `E_3(G)`, `G` 3-colourable, with `D_C ≠ 0` for every odd closed walk `C`; they exist and have edges at `G = C₅`.
J27V's words: "a 3-colouring of the improper maps lying in components where every `w₂^c` is non-zero". J27V §3: "Two independent routes stalling
at one step is evidence the step is the real content, not a proof that it is hard." In the literature's words it is `B(3)` (Duffus–Sands–Woodrow),
generalised from uniquely colourable to gap-free, which `[Tardif2008]`'s survey and J27's web summary record as open.

**§5.2 DD-2 — GAP, the same ingredient named by both** (J27D §Stage 5; J27V §2.10). The claim (plan §4.3): "For some `k ≥ 4` there is a regular
Hoffman-tight (`λ_min = −d/(k−1)`) connected graph `G` for which FS67(G, k) fails". **The missing ingredient:** a Hedetniemi pair `(X, H)` at
some `k ≥ 4` with `X` connected, regular and `μ_min(X) ≥ −d_X/(k−1)` (FS67-DD2R). `[Tardif2023]`'s `X = Ω_w(K_m)` is not known to be regular and
its spectrum is not computed; `[Tardif2022frac]` is not held.

**§5.3 DD-1's reach to `[Zhang2012]`'s IS-imprimitive exception — GAP** (J27D §Stage 5, not attempted within budget; J27V did not verify it, §4.1):
the missing step is the comparison of GRRSV's "connected strictly complementary dual solution" with Zhang's IS-primitivity.
