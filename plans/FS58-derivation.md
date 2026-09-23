# FS-58 — the derivation file: every theorem this milestone proved outside the kernel

*Written 2026-09-23 by the FS-71 batch-6c implementer (`plans/FS71-theorem-audit.md`, rows 72–73; G54, G55, G59, G60, G61
named in the brief). Enumeration: `plans/FS58-four-colours.md` read in full (624 lines); `plans/FS58-prelude-seven-cycle-gadget.md`
read in full (158 lines); `data/fs58/README.md`, `data/fs58/chain-11/README.md`, `data/fs58/search-167/README.md`,
`data/fs58/search-23/README.md`, `data/fs58/witness-11/README.md`, `data/fs58/witness-191/README.md`,
`data/fs58/witness-23/README.md`, `data/fs58/witness-23/minimal/README.md`, `data/fs58/witness-47/README.md`,
`data/fs58/witness-71/README.md`, `data/fs58/witness-95/README.md` (all 11 read in full — 58 KB total). `tools/fs58_local.py`,
`tools/fs58_witness.py`, `tools/fs58_check_witness.py` read for their docstrings only, per the brief (frozen; not run).
`Proofs/HadwigerNelson/ThreeAdicBarrier.lean` and `Proofs/HadwigerNelson/Instances/SqrtEleven.lean` read for their top-level
declaration names (`rg "^theorem\|^def"`), confirming row 72's `colorable_three_integralDirectionPlane` and row 73's
`four_le_chromaticNumber_planeOver_eleven` / `four_le_chromaticNumber_planeOver_of_sqrt_eleven_mem`. `plans/STUB-quadratic-witnesses-kernel.md`
(FS-60, the kernel target for the tools-grade witnesses below) read in full. `LEDGER.md` rows 72–73 read as the seed. Grades
are `CLAUDE.md` § Notation's.*

*Not filed separately: D1, the 3-adic barrier for general `d ≡ 2 (mod 3)`, is **kernel already** (row 72,
`colorable_three_integralDirectionPlane`) — see the census note in `data/fs71/batch-6c.md`. The `ℚ(√11)` chain witness
(R-B3, R-D2) is likewise **kernel already** (row 73, `four_le_chromaticNumber_planeOver_eleven`).*

## The theorems

**FS58-T1 — The split 3-adic tower is Hoffman-tight at three colours at every level, with the level-1 characters as the unique minimisers. [hand]** Let `S_m = Cay((O/3^m)², C_m)`, `O = ℤ₃[i]`, `|C_m| = 8·9^{m−1}` (the unit circle over `ℚ(√d)`'s
completion at the inert prime 3, `d ≡ 2 (mod 3)`, at level `m`). Its eigenvalues are character means `E_t ψ(αt + β/t)` over
`t ∈ (O/3^m)^×`. At level 1 the least is `−4 = −d(S_1)/2` (the eight-point Kloosterman sums; the ratio bound is exactly
tight, `81/3`). For `m ≥ 2`, every character primitive at level `m` (not a pullback from level `m−1`) has mean at most
`(9/4)·9^{−m/2}` — strictly above `−1/2` — so `S_m`'s least eigenvalue equals `S_1`'s scaled by the covering degree, attained
only by the 16 characters pulled back from level 1. *Proof:* `plans/FS58-four-colours.md` §2 D2 and §M2's hand-obligation
table: (i) a character with exactly one unit coordinate has mean 0 at level `m ≥ 2` (substitute `t ↦ t(1 + 3^{m−1}s)`; the
non-unit term is unchanged mod `3^m`, the unit term's contribution sums to 0 over `s ∈ O/3`); (ii) a character with both
coordinates units has `|S| ≤ 2·9^{m/2}` (stationary phase: `m = 2k` gives `S = 9^k Σ_{αt₀² ≡ β (3^k)} ψ(…)` over at most two
Hensel roots; `m = 2k+1` the same with a quadratic Gauss sum of modulus 3). *Test:* exact at `m = 1, 2, 3` (`data/fs58/opening/`,
§0 O1): measured `|S| = 53.6` at `m = 3` against the hand bound `54`. *Proof verdict:* closes for the hand estimate (i)–(ii); the general-level bound is a standard-technique estimate whose own prior art is unread (see *Prior art* below), not a gap in the argument as stated. *Rests on it:* FS58-T2 (the pullback conclusion);
D3.3's tower screen (no finite level of the tower rules out a chain target `3u`). *Prior art:* check owed — the prime-power
stationary-phase/Kloosterman-sum bound is classical (Salié's method; FS-58's own §PA flags it "standard... not re-read,
owed before any external claim"); zbMATH `ti:"Salie sum"` (3 hits: "On Salié's sum" and near variants — the classical
literature exists and was not read here) and `ab:"stationary phase" & ab:"finite field" & ab:"circle"` (query malformed by
the API on this run; not retried within budget). The application to `ℚ(√d)`'s inert-3 tower and its use as a rigidity
screen is FS-58's own. *Kernel:* declined — no consumer this milestone names beyond the tools-side chain search; the
generalisation to arbitrary level is a hand estimate, not carried into `ThreeAdicBarrier.lean`.

**FS58-T2 — Every proper 3-colouring of every level of the split 3-adic tower is pulled back from level 1, hence affine. [derived (row 72's Theorem-A framework; FS38-D2-A); tools confirms level 1's colourings are exhaustively affine]** By
FS58-T1's tightness and G54's Theorem D2-A (`FS38-D2-A`: a Hoffman-tight `k`-colouring is balanced, gap-free, and its
Fourier support lies on the minimising eigenspace), every proper 3-colouring of `S_m` (any `m`) is pulled back from `S_1`.
`S_1`'s eight proper 3-colourings (origin pinned to 0, one neighbour to 1) are, by exhaustive solver enumeration, each
affine (`x ↦ σ(L(x))` for an `𝔽₃`-linear form `L`) — **[tools, verified for `m ≤ 3`]** — so every 3-colouring at any level of
the tower is affine. (A short supporting fact used implicitly: since `Hom(O_{(3)}², ℤ/3) = Hom((O/3)², ℤ/3)`, every
*additive* 3-colouring of the whole 3-integral lattice is automatically a pullback from level 1 too — D3.6.) *Proof:*
`plans/FS58-four-colours.md` §2 D2 conclusion and §0 O1 (the exhaustive enumeration). *Proof verdict:* closes — for the
"pulled back from `S_1`" half (FS58-T1 + FS38-D2-A); the "hence affine" half is a *tools*-grade fact about `S_1` specifically
(exhaustive at `m ≤ 3` only, not a hand proof that `S_1`'s 3-colourings are affine from its Fourier support). *Rests on it:*
`plans/FS58-four-colours.md` R-B1's empirical confirmation over `ℚ(√11)` (399 of 427 quotients refuse three colours; the 21
that accept admit exactly one linear form up to sign), which is this theorem's consequence realised on the field's actual
direction pools — the route-C screen (D3.7, FS58-T6) is therefore structurally blind on 3-integral pools, which is exactly
what R-B1 found and P1 (0.8 confidence) lost against. *Prior art:* ours (G54's Theorem D2-A is the general mechanism,
already filed as `FS38-D2-A`; this is its instance at the inert-3 tower). *Kernel:* declined — `FS38-D2-A`'s own kernel
status governs; no separate target.

**FS58-T3 — Periodic 3-colourings of the 3-integral graph factor through a tensor product of the 3-adic tower and the stable residue planes. [hand; corrected 2026-09-17 from an erroneous first version]** Let `F = ℚ(√d)`, `d ≡ 2 (mod 3)`
squarefree, `G₃` the unit-distance graph on 3-integral unit vectors of `F²`, `S` the 3-integral unit circle,
`Λ₃ = ℤ[S]` the group it generates. Every periodic 3-colouring of `G₃` factors through a finite quotient of `Λ₃`, and `S`
surjects onto `C_m × Π_𝔮 C_𝔮` (weak approximation on the conic, over the 3-adic levels `C_m` and the conjugation-stable
primes `𝔮` of `F(i)`), so every such finite quotient graph is a **tensor product** `S_m × Π_𝔮 P_𝔮` of a level of the 3-adic
tower and levels of the stable residue planes. *Proof:* `plans/FS58-four-colours.md` §2 D3.4. The first version of this
argument (dated the same day, corrected in the same file) worked in `A = O_{(3)}²` instead of `Λ₃`; at every conjugation-stable
prime `𝔮` of `F(i)` every unit vector is `𝔮`-integral, so `A` maps onto `P_𝔮` while `1/𝔮 ∉ Λ₃` (prime inversion, G55) — the
first version concluded every finite quotient is a 3-group, which is false for `Λ₃` and only true for `A`. *Proof verdict:*
closes for the factorisation and the surjectivity (the group-theoretic claim). **It does NOT close for the further claim
this theorem is used to support** — that every 3-colouring of such a tensor product is itself pulled back from one factor
(needed to conclude every periodic 3-colouring of `G₃` is affine): the text explicitly marks this "not derived", a
multiplicativity-type property of `K₃`-colourings of a product graph whose prior art (Häggkvist–Hell–Miller–Neumann-Lara
1988; Greenwell–Lovász 1974, for `K_n` factors) is unread. §0 O7's measurement (`q = 7, 11, 19, 23`: every 3-colouring of
`S₁ × P_q` found is pulled back from `S₁`, with the `q = 3` positive control separating at once) is evidence for this
further claim, not a proof of it — filed as a measurement in § "Readings and measurements", with **FS-67** as the open
general theorem it is an instance-hunt for. *Rests on it:* row 73's "every periodic 3-colouring of the 3-integral pools
tried is affine" rests on FS58-T2 (the tower alone) plus this unclosed multiplicativity claim wherever a stable residue
factor is present — the affine conclusion is therefore proven only where the tensor factor is trivial (pure 3-adic tower)
and measured (not proven) wherever a residue-plane factor is mixed in. *Prior art:* check owed — Häggkvist–Hell–Miller–
Neumann-Lara (1988) and Greenwell–Lovász (1974) are named but unread; zbMATH `ab:"multiplicativity" & ab:"chromatic
number" & ab:"tensor product"` (0 hits) and `ab:"Hedetniemi" & ab:"three colourable"` (0 hits) — this specific three-colour
multiplicativity question was not found in print; FS-67's stub is the standing target. *Kernel:* declined — the open
half (FS-67) is what would need a kernel target, not this factorisation lemma.

**FS58-T4 — The finite/infinite forcing dichotomy, by compactness. [hand]** For the countably infinite graph `G₃`
(3-integral unit vectors of `F²`) with an exhausting chain of finite subgraphs: a difference `δ` is forced equal at three
colours by *some* finite subgraph of `G₃` if and only if no proper 3-colouring of the whole of `G₃` separates the pair —
i.e. a finite forcer exists iff `G₃` itself is rigid at `δ`. *Proof:* `plans/FS58-four-colours.md` §2 D3.5 and §M2's table:
(⟸) if every finite subgraph in the exhausting chain had a separating 3-colouring, a pointwise-convergent subsequence
(König's-lemma / compactness argument on a countable vertex set) gives a separating 3-colouring of all of `G₃`; (⟹)
`Forces` is monotone under subgraph inclusion. *Proof verdict:* closes (a routine compactness argument in the style of
de Bruijn–Erdős, over a countable graph — no ultrafilter or choice needed beyond König's lemma). *Rests on it:* the phase
B/C decision procedure (§3): "no finite forcer at this direction pool" is read directly off a quotient colouring of the
infinite graph (D3.7, FS58-T6), never from an exhaustive finite search; the open status of `ℚ(√167)` (FS-59) is stated in
exactly this vocabulary ("is `G₃` rigid?"). *Prior art:* check owed — the compactness theorem for graph colourings is
de Bruijn–Erdős (1951) in general (uncountable graphs, via Tychonoff/ultrafilters); Mathlib's `Combinatorics/Compactness.lean`
holds the general Rado-selection machinery this rests on (`Finset.rado_selection`, `Set.Finite.rado_selection`, docstring
citing de Bruijn–Erdős 1951) but **no direct `SimpleGraph.Colorable` wrapper exists** (checked: `rg` over
`Mathlib/Combinatorics/SimpleGraph/Coloring*.lean` finds no `iSup`/compactness lemma tied to `Colorable`) — this is exactly
FS-39's phase-A target (`plans/STUB-plane-bridge.md` D2). zbMATH `ab:"compactness" & ab:"chromatic number" & ab:"infinite
graph"` (1 hit, an Oberwolfach report, not a citable source) and `ab:"de Bruijn" & ab:"Erdos" & ab:"colouring theorem"`
(0 hits). *Kernel:* stub (FS-39, phase A/D2) — Mathlib's Rado-selection lemmas exist; a `SimpleGraph.Colorable`-specific
wrapper does not.

**FS58-T5 — The direction-set quotient screen. [hand]** Let `W₀` be a finite symmetric set of unit vectors,
`Λ₀ = ℤ[W₀]`, `L ≤ Λ₀` a finite-index subgroup with `W₀ ∩ L = ∅`. If the finite quotient Cayley graph
`Cay(Λ₀/L, W₀ mod L)` admits a proper 3-colouring `c̄` with `c̄(0̄) ≠ c̄(\overline{3u})`, then no unit-distance graph whose
edge vectors all lie in `W₀` forces the pair `(p, p + 3u)` equal at three colours, for any `p ∈ Λ₀`: the pullback
`x ↦ c̄(x̄ − p̄)` is proper on `Cay(Λ₀, W₀)` and separates every translate. *Proof:* `plans/FS58-four-colours.md` §2 D3.7.
*Proof verdict:* closes. *Controls, both reachable (exercised in phase B1):* on `L = 3Λ₀` (the 3-adic quotient) no
separation exists, matching FS58-T2 (an affine colouring never separates `3u`); on an `L` where `3u ≡ w ∈ W₀`, the pair is
literally an edge, so every proper colouring separates it. *Rests on it:* R-B1's null over `ℚ(√11)` (0 of 427 lattice
records kill the pool — a structural consequence of FS58-T2, not this screen's own limitation); phase B's design
(`tools/fs58_chain.py screen`). *Prior art:* ours (a pullback/translation argument on a Cayley quotient; no specific paper
found — zbMATH `ab:"quotient" & ab:"Cayley graph" & ab:"colouring" & ab:"lift"`, 0 hits). *Kernel:* declined — a
boundary-free SAT screening tool, no kernel consumer named.

**FS58-T6 — A distance-2 virtual edge chains into a forced pair at `3u`. [hand, three lines]** If a finite 3-integral graph
over `F` separates `x` from `x + 2u` in every 3-colouring (a virtual edge at `2u`), then any graph containing it plus the
four-point run `x, x+u, x+2u, x+3u` (and its translate by `u`) forces `x` and `x+3u` equal at three colours. *Proof:*
`plans/FS58-four-colours.md` §2 D3.8: `c(x), c(x+u), c(x+2u)` pairwise distinct (three unit edges in a 3-colouring)
determines `c(x+2u)` as the unique remaining colour given `c(x), c(x+u)`; the same for `c(x+u), c(x+2u), c(x+3u)`
determines `c(x+3u)`; combined with the virtual edge's separation of `(x, x+2u)`, `c(x+3u) = c(x)` follows by elimination.
*Proof verdict:* closes. *Rests on it:* reframes the search target as a Moser-spindle-shaped question (a 4-chromatic
`{1,2}`-graph with one distance-2 edge over `F`) rather than a direct `3u`-forcing question — the more geometric target
D3 recommends; not pursued as a separate route in this milestone (superseded by the direct `ℚ(√11)` forcer, R-B2/B3).
*Prior art:* ours (elementary; not searched separately — the pattern is the Moser-spindle mechanism itself, already
attributed to `[Moser1961]` elsewhere in the project). *Kernel:* declined — no consumer this milestone built.

**FS58-T7 — The pigeonhole-forcing lemma, generalised from Wormald. [hand]** For a finite `T ⊂ F²`, call `U ⊆ T` **odd**
when the unit-distance graph on `⋃_{u ∈ U} S(u, 1) ∩ F²` contains an odd cycle. If `T` admits no 3-colouring that is proper
on `T`'s own unit edges and leaves no odd subset `U ⊆ T` monochromatic, then `χ(F²) ≥ 4`, witnessed by `T`, one odd cycle
per odd subset used, and one edge from each cycle vertex to a point of its subset. *Proof:* `plans/FS58-four-colours.md`
§2 D7: a monochromatic odd `U` forces its cycle into two colours, a contradiction; no independence hypothesis on `U` is
needed (a `U` sharing a unit edge with a cycle vertex is never monochromatic under a colouring proper on `T`'s edges,
so independence is the *search's* filter, not the lemma's hypothesis). *Proof verdict:* closes. *Prior art:*
`[Wormald1979]` is the `s = 5` instance (13 points, all 5-subsets, bijectively attached 5-cycles); the general statement
(any odd cycle length, arbitrary subset size, no independence hypothesis) is this milestone's generalisation — recorded
as such in FS-58's own §PA. zbMATH `ab:"odd cycle" & ab:"pigeonhole" & ab:"unit distance"` (0 hits) and `au:"Wormald" &
ti:"colouring"` (2 hits, both on random-graph colouring, unrelated to this construction). *Rests on it:* route W (§0 O6,
phase W), which found no independent odd subset of size 3–5 at the heights tried over `ℚ(√11)` or `ℚ(√167)` — closed as a
route (§C, "not the reason if χ ≥ 4 is true"), the lemma itself is not refuted, only unfired at this height. *Kernel:*
declined — no kernel target named; the certificate, if one is ever found, is "a few hundred vertices, kernel-checkable
by the SAT bridge" per the plan, unbuilt.

**FS58-T8 — `χ(ℚ(√d)²) ≥ 4` certified for `d = 23, 47, 71, 95, 191`. [tools]** For each `d ∈ {23, 47, 71, 95, 191}`, an
explicit finite unit-distance graph over `ℚ(√d)` (297/670 points/edges at `d=23`, 169/385 at 47, 148/346 at 71, 1068/3096
at 95, 483/1203 at 191 — the 95 witness not 1-minimal) has no proper 3-colouring, certified by `tools/fs58_check_witness.py`
(standard library, rebuilds every edge in exact rational arithmetic, checks the LRAT proof with an independent RUP
checker, refuses twelve planted faults each for its named reason and refuses the same files under the wrong radicand)
and by a decorrelated recheck sharing no code with the generator or the checker (all edges re-derived in exact rational
arithmetic; Minisat22 and Lingeling — two further solver codebases — refusing three colours; a verified 4-colouring on
deletion). So `χ(ℚ(√d)²) ≥ 4` at each; combined with the residue plane at 7 (`[Moorhouse2010]` Cor. 8.3 / `[Fischer1990]`)
this gives `χ(ℚ(√d)²) = 4` exactly at `d = 23, 71, 95, 191` and `4 ≤ χ(ℚ(√47)²) ≤ 5` (the plane at 11 gives the upper bound
5, since 47 has no usable plane at 7). *Proof:* `plans/FS58-four-colours.md` §R-B5 (the certified-witness table). *Proof verdict:* closes. *Rests on it:* row 74 (FS-61's later census re-derives and extends this with a general procedure over
40 fields, re-certifying these six from its own balls). *Prior art:* checked at the time — FS-58's own §PA found nothing
in print giving `χ ≥ 4` for any real quadratic field; ℚ(√47)'s bracket is `CLOSED-QUESTIONS.md`-adjacent (Benda–Perles OP
11.6). *Kernel:* stub (FS-60, `plans/STUB-quadratic-witnesses-kernel.md` — a certificate type over `Adjoin d ℤ`, priced
against a generic `UDCert` on the `ℚ(√23)` witness first; not yet built).

**FS58-T9 — No rational odd-parity diamond chord exists for `d ≡ 7 (mod 8)`. [hand; unsure — owner to re-derive]** For
`d ≡ 7 (mod 8)` squarefree, no diamond of the shape underlying `ℚ(√11)`'s forcer construction (the "diamond plus three
rational steps" 5-cycle mechanism, §R-B2) has a rational chord of odd parity — the mechanism that builds `ℚ(√11)`'s
52-point forcer from rational directions does not transfer to any such field. *Proof:* `plans/FS58-four-colours.md`
§R-B5 states the conclusion in one sentence ("a hand obstruction: for `d ≡ 7 (mod 8)` no diamond chord is a rational
vector of odd parity, which removes the 'diamond + three rational steps' 5-cycles that drive `ℚ(√11)`'s forcer") with no
derivation chain written out on disk. *Proof verdict:* **unsure — owner to re-derive** (the claim is plausible — it is the
stated reason `ℚ(√23)`'s route to a forced pair had to diverge from `ℚ(√11)`'s, R-B5 — but the parity/valuation argument
itself is not on disk anywhere searched: `plans/FS58-four-colours.md`, `data/fs58/`). *Rests on it:* explains (if it
closes) why `ℚ(√23)`'s route used a saturated 3-non-integral lattice instead of a diamond chain, and by extension why
`ℚ(√167)` (also `d ≡ 7 (mod 8)`, R-B5 confirms) is not landed by the direct route. *Prior art:* not searched separately
(this is FS-58's own unwritten lemma, not a literature claim). *Kernel:* declined — pending the owner's re-derivation.

## Readings and measurements that were called theorems

* **The tensor-rigidity of `S₁ × P_q` at `q = 7, 11, 19, 23` (§0 O7).** Called a derivation step ("the quotient graph is a
  tensor product... measured") inside D3.4; it is a *measurement* — a solver claim on four specific `q`, with `q = 3` as
  the positive control (the plane there is 3-colourable, and the tensor product separates at once, as required). It does
  **not** establish the general multiplicativity claim FS58-T3 leaves open; **FS-67 is the open theorem this is evidence
  for**, and G61(2)'s warning ("this was leaned on as if proved") applies exactly here — row 72's own text states "its
  tensor products with the residue planes at 7, 11, 19, 23 are rigid" as if settled, when the general case is unproved.
* **"Forcing at small size tracks short odd cycles through the rational directions" (R-B4).** Explicitly labelled
  `[reading]` in the plan, with its own killing test (a 3-non-integral class of smaller odd girth that still fails to
  force). Not a theorem.
* **D5 — screens at the other places** (compact places with no 3-colourable residue plane screen nothing; split places
  other than 2, 3 with a Hoffman floor above 3 screen nothing). A direct corollary of the Hoffman ratio bound applied to
  each named residue plane — no independent content beyond citing that bound at each place; not filed as a separate
  theorem.
* **D6 — the ratio route's local problem.** Stated (not measured): the plan registers the expected shape of a local LP
  over 2-adic character shells but the LP was **never run** (§C: "declined below... the local statement is
  `[BardestaniMallahiKarai2015]` Lemma 3.8's over `ℚ_p`"). Not a theorem; carried as a stated-but-unlanded target into
  FS-39/FS-61.
* **`fq_chi.py`'s rebuild** (`data/fs62/README.md`, out of scope for this file — filed under `plans/FS62-derivation.md`'s
  measurements section; noted here only because the brief's seed line for row 72's tools clause is adjacent).

## Conjectures surfaced, not claimed

* **FS58-T3's multiplicativity gap** (demoted above): "3-colourings of `G × H` with `χ(H) > 3` factor through `G`" — open,
  named FS-67's stub target.
* **`G₃`'s rigidity over `ℚ(√167)`** (D3, "what is not claimed: that `G₃` is rigid"): declined as moot for `ℚ(√11)` (the
  finite forcer answers what rigidity was for there) and carried into FS-59 as the open question for `ℚ(√167)`.

## Prior art re-attributed

None found for this milestone's own theorems (FS58-T1–T9); the barrier `D1` (kernel already, row 72) already records its
own split attribution in the plan text ("the mechanism is theirs [Moorhouse2010/Madore2015/Fischer1990]; the barrier and
its use as a design rule are ours") and needs no edit.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| FS58-T4 | **stub** (FS-39, phase A/D2) — Mathlib's Rado-selection compactness lemmas exist; no `SimpleGraph.Colorable`-specific wrapper |
| FS58-T8 | **stub** (FS-60, `plans/STUB-quadratic-witnesses-kernel.md`) — priced, not built |
| FS58-T1, T2, T3, T5, T6, T7 | declined (tools-side screening lemmas and estimates with no kernel consumer named) |
| FS58-T9 | declined, pending the owner's re-derivation |
