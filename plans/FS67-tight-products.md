# FS-67 — k-colourings of a tight graph times a non-k-colourable one: do they all come from the tight factor? (plan; crunch job J27)

*Planner: J27 (de Bruijn, Opus 5.5), 2026-09-25, brief `data/crunch-2026-09-25/briefs/J27-FS67-reframe.md` (template J03, with
`STANDING-RULES.md`). Stub: `plans/STUB-tight-product-colourings.md`. Read at commit `6d2f2950` (`CLAUDE.md` identical on disk to HEAD
there; its only difference from the session-start copy is the J24a "Open milestones" line). Paths: `data/fs67/j27/`, `tools/crunch_j27_*`.
**This file carries routes; it is fenced from the blind verifier (J27V) until J27V's verdicts are committed.***

**Budget note (honest deviation).** `LEDGER.md` (277 KB) was walked by its 97 row heads plus the mechanisms `CLAUDE.md`'s grokkings carry
for each row; the full text of a row was not read where its head and grokking are silent on products. Budget, not judgement: the
harness count at the walk's start was ~250k of 350k.

## Theorems this phase proved

*(Planning job: none claimed. The sketches in §IQ and §S are routes for the derivation, graded [reading] until J27D proves them.)*

## Stage 1 — SAVED (quotation check, priors, §G.1)

### 1.1 Quotation check (standing rule 5)

| brief's text | source | result |
|---|---|---|
| "the product question's remainder after the Greenwell–Lovász reading: the equal-ratio case with an IS-imprimitive factor, and the gap `χ_f(H) ≤ k < χ(H)`" | `plans/CRUNCH-2026-09-25-queue.md`:182 | **verbatim** |
| title "k-colourings of a tight graph times a non-k-colourable one: do they all come from the tight factor?" | stub title reads "3-colourings of a tight graph times a non-3-colourable one: …" | **generalised paraphrase** (3 → k), faithful to the stub's re-aims at FS-85/86/89 (four-colour and general-`k` forms); logged, no consequence |
| the gap "`χ_f(H) ≤ k < χ(H)`" | stub banner writes "`χ_f(H) < k < χ(H)` for vertex-transitive `H`" (after PA-P5 takes `χ_f(H) = k` with both factors IS-primitive) | **both right at their scope**: the queue's `≤` includes the equal case, whose IS-imprimitive half is the queue's first item; no conflict |
| J21-MX, NG1/NG2, `[TardifWrochna2019]` Thm 2 (unquoted descriptions) | `plans/M3-S1D-windows-five.md` "Theorems this phase proved"; `plans/M3-PA-mixing.md` Stage 2 | **faithful**: J21-MX's hypothesis is two-sided `λ* < 1/(k−1)` on a compact abelian Cayley factor; NG2 is at `k = 125` |

### 1.2 Priors, registered before any derivation (scored at the close)

The recognition in §IQ was reached while reading the inputs (no derivation written); these are registered now, before any is.

| id | statement | prior |
|---|---|---|
| P-A | For every `k ≥ 4` some connected, uniquely `k`-colourable (so gap-free) `G` and connected `H` with `χ(H) > k` have a `k`-colouring of `G × H` not pulled back from `G` (route: `G = K_k × X` from a Hedetniemi counterexample `(X, H)`, `[Tardif2023]` at `k = 4`, `[Shitov2019]` beyond) | 0.90 TRUE |
| P-A′ | For `X` connected with `χ(X) > k`: FS-67 holds for `G = K_k × X` iff no connected `H` with `χ(H) > k` has `χ(X × H) ≤ k` | 0.70 TRUE (as an iff; the ⟸ direction needs GL Thm 1 on `K_k × (X × H)` and care with connectivity) |
| P-B | Three colours: for every connected `G` all of whose 3-colourings are gap-free and every connected `H` with `χ(H) > 3`, every 3-colouring of `G × H` is pulled back from `G` (route: El-Zahar–Sauer's colouring of `K_3^G`'s improper part) | 0.55 TRUE, 0.15 FALSE, 0.30 GAP |
| P-C | Spectral pullback: `G` connected, gap-free at `k`; `H = Cay(K, T)` (finite or compact abelian) with `λ* < τ_k` ⟹ every `k`-colouring of `G × H` is a pullback from `G`. At some explicit `τ_k > 0` | 0.90 TRUE |
| P-C′ | …at Pak–Vilenchik's threshold `τ_k = 1/(k−1)` itself | 0.45 TRUE |
| P-D | Hoffman-tight `G` at `k ≥ 4` in the gap regime: a Hoffman-tight counterexample is exhibited by hand | 0.30; a theorem for all tight `G`: 0.10; GAP: 0.60 |
| P-E | Equal ratio, IS-imprimitive factor (vertex-transitive `G`, `H`): a counterexample by hand 0.25; a theorem 0.15; GAP 0.60 | — |
| P-F | The stub's unverified FS-61 eigenvalue sketch (one-sided `λ_min(H)/d(H) > −1/2`, tight `G`, `k = 3`) is TRUE as stated | 0.30 |
| P-G | No outcome of this milestone moves a bound on `χ(ℝ²)` or on any field plane | 0.97 |

### 1.3 §G.1 — the grokkings, walked (from `CLAUDE.md` at `6d2f2950`)

*Stages named: **DA** (the Hedetniemi transfer and the gap-free no-go), **DB** (three colours), **DC** (spectral pullback), **DD** (tight
at `k ≥ 4`; equal ratio, IS-imprimitive; the gap regime), **V** (blind verifier), **PB** (post-ban finite tests, after 2026-10-01).*

- G1 — silent: no field; FS-67 is abstract graph products.
- G2 — silent: construction geometry.
- G3 — silent: radii/angles of witnesses.
- G4 — silent: shell inventory.
- G5 — silent: 1-sums, not products.
- G6 — silent: hexagram containment.
- G7 — silent: rotation family.
- G8 — silent: direction group.
- G9 — silent: forcing pairs in the plane, not product colourings.
- G10 — silent: criticality of the 1581.
- G11 — silent: Moser-free witnesses.
- G12 — silent: quadrature law.
- G13 — bears: a fan gap is exactly non-gap-freedom; row 66 names it (`FanGap`) — DA's "non-gap-free ⟹ FS-67 fails" lemma and D4's kernel vocabulary → DA.
- G14 — silent: matchings in arenas.
- G15 — silent: pigeonhole × kill in witnesses.
- G16 — bears: its converse uses `K₄ × K₄` uniquely colourable, which is GL Cor. 3 (PA finding 2) — an FS-67-type step already inside a hand theorem; DA's control → DA.
- G17 — silent: sub-rung carriers.
- G18 — silent: solver composition (no solver).
- G19 — silent: "5-tight" fabric is a different sense of tight.
- G20 — silent: brick colourings.
- G21 — bears: a small-case "no counterexample" measures its generator (tight Cayley ≤ 100 vertices); PB must state the generator's image; audit liked results → PB, V.
- G22 — silent: six-colourings of the plane.
- G23 — silent: cell family scale.
- G24 — bears: FS-67's open remainder is an integrality gap (`χ_f(H) ≤ k < χ(H)`), where relaxations are blind — expect no spectral route there → DD (combinatorial routes only).
- G25 — silent: forcing ladder.
- G26 — silent: 6-forcer reduction.
- G27 — silent: Galois flips.
- G28 — silent: fine tail.
- G29 — silent: cell dial.
- G30 — bears: every theorem ships an inhabitant (a tight `G`, a connected non-`k`-colourable `H`); delete each hypothesis once; ladder: graph products → spectral → topology (ES, TW) → DA–DD.
- G31 — silent: extraction from witnesses.
- G32 — silent: two-distance dial.
- G33 — silent: batch descent.
- G34 — silent: in-field descent.
- G35 — silent: 2-adic wall.
- G36 — silent: residue colouring on descent stages.
- G37 — silent: descent endgame.
- G38 — bears (weak): row 82's "every three-colouring additive at d ≡ 3, 7 (mod 12)" is a second route to G61(3)'s affinity, a DB consumer to cite beside → DB.
- G39 — silent: critical sets of forced pairs.
- G40 — silent: absorption in arenas.
- G41 — bears: row 89/Fischer's two colourings on K — two tight factors each supply colourings when `χ(H) = k`; the control that `χ(H) > k` is needed → DA hypothesis deletion.
- G42 — silent: additive rigidity gauge.
- G43 — bears: composite residue targets beat a prime only through an integrality-gap factor; FS-67's gap regime is the colouring-level twin — §S bearing statement.
- G44 — bears: `λ*(Γ_q) = max|Kloosterman|/(q+1) ≈ 2√q/(q+1)` decides which residue planes meet DC's threshold `1/(k−1)` — exact spectra exist → DC instance table.
- G45 — silent: lifting.
- G46 — bears: name the object in its home theory — Hedetniemi-type products, exponential graphs `K_k^G`, uniquely colourable graphs → §PA, DA.
- G47 — silent: residue distance law.
- G48 — bears (weak): "when must a colouring of a product of local targets be local at one place" is FS-67's only programme bearing → §S bearing.
- G49 — bears: author listings for Duffus–Sands–Woodrow, El-Zahar–Sauer, HHMN, Larose, Tardif, Zhang, Bonato → §PA.
- G50 — bears: `[Tardif2008]` held (ES's proof, §4.2), `[Zhang2012]` held, DSW not held — read before deriving → §PA, DB.
- G51 — bears: one derivation agent plus a blind verifier with a fixed list (the protocol's seventh-run form) → §S.
- G52 — silent: radius sums.
- G53 — silent: counting compulsion in arenas.
- G54 — bears: FS-67's `G` is G54's tight plane (D2-A: every `k`-colouring balanced, gap-free, periodic); does tightness do work beyond gap-freedom? U₃₂'s rigid 11 colourings are a DD control → DD, DC.
- G55 — bears: PA-T4 corrected its Hedetniemi remark (products of residue targets are fine at four colours); FS-67 is the colouring-level analogue → §S bearing.
- G56 — silent: six-colour window.
- G57 — silent: triangles in window planes.
- G58 — silent: antipodal colourings.
- G59 — bears: fractional minimum of products; a composite target escapes only through a factor with `χ_f ≤ k < χ` — the same gap regime → §S bearing.
- G60 — silent: field-internal fractional blow-up.
- G61 — bears: (3) "stays rigid tensored with the residue planes at 7 and 11 (the general statement is FS-67, unproved, and false without gap-freedom)" is the measured fact DB would justify → DB; falsifiable: P-B.
- G62 — silent: bilayers.
- G63 — silent: transcendence.
- G64 — silent: six as a value.
- G65 — silent: solver phase diagram (no solver until PB).
- G66 — bears (weak): the 3-adic tower is tight at every level (row 72), so DB's theorem would cover every level at once; carry is irrelevant here → DB consumers.
- G67 — bears (method): any grokking minted at the close is written with Do and Killing test → close.
- G68 — bears: a gapped colouring frees pairs; in product form, a gap gives a non-pullback colouring (the stub's C₅ × K₄) → DA's non-gap-free half.
- G69 — silent: lattice rigidity by quotients.
- G70 — bears: `K₄ × K₄` unique colourability (GL Cor. 3) is an FS-67 instance used in a hand theorem → DA control.
- G71 — bears: `K₃`'s universal cover is a line (heights) — the topological reason ES works at three and the route for DB; no height at four, consistent with P-A's failure → DB, DA.
- G72 — bears: §IQ.
- G73 — bears: at four colours cell-local invariants are blind and coindex bounds stop at four; Tardif's non-colourability is topological (Simonyi–Tardos) — DD expects Tardif-template obstructions, not local ones → DD.
- G74 — silent: field-level layers.
- G75 — bears: R3a (row 85) answered FS-67 once at `k = 4` by a pointwise tetrahedron splitting — a structure-derived pullback route → DD candidate route.
- G76 — bears: S2's pullback uses Zhang (i) strictly (row 88); two tight places give a choice per coset (row 89) → §S bearing; DA control.
