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

## Stage 2 — SAVED (§G.2 rows, §G.3 method rules, §G.4)

### 2.1 §G.2 — `LEDGER.md` rows 1–97, by mechanism

- row 1 — silent: two-circle 3-colourability.
- row 2 — silent: seam identity.
- row 3 — silent: coverage monotonicity.
- row 4 — bears: fan ⟺ compulsory coverage; "every closed neighbourhood sees all colours" is the gap-free notion GL's hypothesis is (PA-P1) → DA.
- row 5 — silent: class confinement.
- row 6 — silent: 120° identity.
- row 7 — silent: greedy colouring.
- row 8 — silent: de Grey balanced colouring.
- row 9 — silent: 120° compulsion.
- row 10 — silent: one-pivot cap.
- row 11 — silent: strip automaton.
- row 12 — silent: extension profile.
- row 13 — silent: growth-family hunt.
- row 14 — silent: pair gluing.
- row 15 — silent: extension pressure.
- row 16 — silent: coupled automaton.
- row 17 — silent: gluing classification.
- row 18 — silent: near-relation.
- row 19 — silent: kill mechanism.
- row 20 — silent: pivot triangle.
- row 21 — silent: registered statistics.
- row 22 — silent: ladder pair.
- row 23 — silent: four-ladder object.
- row 24 — silent: hexagram.
- row 25 — silent: field-wall identity.
- row 26 — silent: de Grey anatomy.
- row 27 — silent: quadrature censuses.
- row 28 — silent: 2-adic kill engine.
- row 29 — silent: stacking law.
- row 30 — silent: criticality factorisation.
- row 31 — silent: Act One carriers.
- row 32 — silent: hex-shell pigeonhole.
- row 33 — silent: classical interval.
- row 34 — silent: coset colourings.
- row 35 — silent: coarse cells.
- row 36 — silent: scale non-monotone.
- row 37 — silent: gap atlas.
- row 38 — silent: gradient hunt.
- row 39 — silent: gap atlas kernel.
- row 40 — silent: fine tail.
- row 41 — silent: limit lemma.
- row 42 — bears (weak): `Forces`/`Separated` vocabulary; "pulled back from `G`" is "every `(x,h),(x,h′)` forced equal" — the kernel form's phrasing option (D4) → V, stub D4.
- row 43 — silent: de Grey bracket.
- row 44 — silent: spindle theorem.
- row 45 — silent: batch descent.
- row 46 — silent: copy unions.
- row 47 — silent: M53 residue obstruction.
- row 48 — silent: critical-set localisation.
- row 49 — silent: absorption kernel.
- row 50 — silent: additive yardstick.
- row 51 — silent: additive rigidity.
- row 52 — silent: finite-plane bound.
- row 53 — silent: field sieve.
- row 54 — silent: lift.
- row 55 — silent: residue distance law.
- row 56 — bears (weak): `card_le_chromaticNumber_mul_indepNum` — the ratio bound DC's "class of measure > θ" uses in fractional form → DC.
- row 57 — silent: Theorems A and B (the colourings, not products).
- row 58 — bears: tight residue planes force (the rhombus at 3) — the tight → forcing mechanism FS-67 generalises to products → DD.
- row 59 — silent: 2-adic law on K.
- row 60 — silent: plane freedom.
- row 61 — silent: six-target statements.
- row 62 — silent: overcompression.
- row 63 — silent: two colours from inertia.
- row 64 — silent: ρ₆₃ arena.
- row 65 — silent: Parts coordinate shape.
- row 66 — bears: fan gap frees every pair above it — the gapped half; its `FanGap`/`Slack` vocabulary is D4's → DA, stub D4.
- row 67 — bears: the 2-adic tower is tight at four colours at every level and forces from level 5 — a tight `G` family at `k = 4` beyond `K₄` for DD's instance list → DD.
- row 68 — silent: six refused at 83.
- row 69 — silent: window.
- row 70 — silent: five refused at 27.
- row 71 — silent: five refused at 23; χ_f(K²) (the fractional min is G59's, not this row's).
- row 72 — bears: the 3-adic plane is tight at three colours at every level — DB's first consumer (FS-58's measured fact) → DB.
- row 73 — silent: quadratic fields need four.
- row 74 — silent: census.
- row 75 — bears (weak): fibre-share ratio at every level supplies `χ_f` of stable targets (PA-T4/T5 table) — the strict/gap regime classification of the programme's `H` → §S bearing.
- row 76 — silent: five over ℚ(√3,√5).
- row 77 — silent: theorem audit.
- row 78 — bears (weak): `F = P = 8Λ` — every four-colouring local at one dyadic place; the product reading's instance → §S bearing.
- row 79 — bears: three colours linear via heights; ES/TW's topological route at `k = 3` is the same universal-cover fact → DB.
- row 80 — bears: at four colours no cell-local certificate — DD expects no local invariant for `χ(E_4(G)) > 4` witnesses either → DD.
- row 81 — silent: `L21cc6506` loose.
- row 82 — bears (weak): three-colourings over fields; affinity consumer beside DB → DB.
- row 83 — silent: census certificates.
- row 84 — silent: four-colour calibration.
- row 85 — bears: R3a — on each component the colouring of (tight dyadic quotient) × (non-4-colourable mod-5 torus) is local at one prime, by pointwise tetrahedron splitting — FS-67 at `k = 4` answered once, a DD route → DD.
- row 86 — bears: `K_k × Y` uniquely colourable (Klotz–Sander Thm 4.2 after Greenwell–Lovász; `Y` connected) — the construction DA's `G = K_k × X` uses → DA.
- row 87 — bears: the middle case — a slack plane whose colourings all pull back from a tight quotient; pullback structure without tightness → DD (hypothesis: "pulls back from a tight quotient").
- row 88 — bears: Zhang Thm 1.8(i) at strict ratio gives the S2 pullback — the strict case already used; DC must say what it adds beyond it → DC.
- row 89 — bears: equal ratio `1/4` between two tight dyadic factors, each class `a(x) + b(y)` — the equal-ratio case with `χ(H) = k`, decided by tightness; DD's tool for the IS-imprimitive case → DD.
- row 90 — bears (weak): local rigidity at `ℚ₂(√3)` — pullback from `P₄` per coset; consumer → §S bearing.
- row 91 — silent: type-(B) no-gos (constructions of non-periodic colourings).
- row 92 — silent: measurable windows.
- row 93 — bears: tightness does not propagate up towers in general (Λ₅₁₀) — DD's instance list must check tightness per level, not assume it → DD.
- row 94 — silent: ℚ(√11) non-periodic colouring.
- row 95 — silent: band characters.
- row 96 — silent: band consequences.
- row 97 — silent: one prime.

### 2.2 §G.3 — method rules (`CLAUDE.md` § Grokkings [method] entries, § Building, § The gate, § What compute helps)

- G21 (negative measures its enumeration) — bears: PB's generator image stated; a "no counterexample" is about tight Cayley graphs of the sizes enumerated → PB.
- G30 (derivation kills; failure modes 1–7) — bears: modes 5 and 7 (inhabitants; emptiness of the conclusion's domain: "every `k`-colouring of `G × H`" with `G × H` `k`-colourable by pullback, so nonempty) → DA–DD, V.
- G46 (classical theory first) — bears: §PA.
- G49 (prior-art gate) — bears: §PA item 8 (zbMATH author listings).
- G50 (read what the search found) — bears: §PA reading list gates DB.
- G51 (competitor and advisor) — bears: §S staffing (derivation + blind verifier).
- G67 (form of grokkings) — bears: close.
- G72 (invariant question) — bears: §IQ.
- Checkpointing [PROTECTED] — silent: no run over 15 minutes (hand derivation).
- Blocking run presumed killable [PROTECTED] — silent: no runs.
- Kill by PID, never by pattern — silent: no background jobs.
- Pipes kill producers / exit status through `tail` — bears (weak): the `tools/crunch_j27d_*` checks run with exit status read directly → DA–DC tools.
- Never edit a running shell script — silent.
- Generated modules and invalidation; kernel cost model — silent: no kernel job in this milestone (D4 stays a stub).
- `scripts/build.sh` only; `lake env lean` is not the check — silent (no Lean).
- `scripts/slot.py` for jobs over 2 GiB / 2 min — bears (weak): any exact spectrum computation for DC's table stays under the threshold; else slot → DC.
- Unexplained crash: halt — silent unless it happens.
- Symmetry breaking before (UN)SAT — bears: PB only (post-ban small-case counts).
- Python 3.14 forkserver — silent.
- Searching: `ugrep` alternation, `rg -uu` — bears (weak): §PA greps of held PDFs use `grep -F`/`rg`.
- Every gate keeps its output — silent.
- Make the gate fail, watch it fail; plant faults — bears: every `tools/crunch_j27d_*` check plants a fault (a non-gap-free `G`; a colouring that is a pullback) and watches it fire → DA–DC.
- State the uninformative outcome and confirm it reachable — bears: P-A's route must be checked to be able to fail (e.g., if `G = K_k × X` were not gap-free the construction proves nothing about FS-67's hypothesis) → DA.
- One thing may differ between compared numbers — bears (weak): DC's threshold comparisons (`λ*` two-sided vs `λ_min/d` one-sided) → DC.
- A positive control proves only shapes the generator represents — bears: PB.
- A measured half and a derived half fail in opposite directions — silent (no measured graphs).
- Write the certificate for the reviewer early; order verification by evidential value — bears: V's claim list is written now (§S), before claims exist.
- Standard of evidence above rung B — silent: nothing here is χ ≥ 6.

### 2.3 §G.4 — what the re-grokking changed

1. **Added DA, the Hedetniemi transfer (G71, G73, row 86, G30 mode 5):** the stub's D3 asked "is gap-freedom in every colouring enough, or is
   the spectrum doing work?"; row 86's `K_k × Y` construction plus `[Tardif2023]` answers it at `k ≥ 4` in two lines (P-A) — so the stub's
   jackpot clause ("gap-freedom as the exact hypothesis") is expected dead at `k ≥ 4` and alive only at `k = 3` (DB) or for Hoffman-tight `G`
   (DD).
2. **Re-ordered: DB (three colours) before DD** (G71, row 79, G61(3)): at `k = 3` the universal-cover route exists and the consumer is named
   (FS-58's D3.4, G61(3)); at `k ≥ 4` the routes are combinatorial (G24, G73).
3. **Added DC, the spectral pullback** (G44, G54, row 88, J21-MX): it covers non-vertex-transitive `G`, which neither Zhang nor PA-P5
   reach, and tells the programme which residue `H` it applies to.
4. **Moved the stub's D2 (small-case SAT) to PB**, post-ban, with its generator image to be written (G21).
5. **The §S bearing statement changes** (G43, G55, G59, rows 75, 88): the programme's own products (residue targets at four colours) are in
   the strict regime by PA-T4, so FS-67's open remainder bears on no residue product at four colours; at five only through PA-T5's holes.

## Stage 3 — SAVED (§PA, the prior-art gate; about 40 minutes, time-boxed)

**Recognition (the query):** FS-67 is the question of *unique colourability of categorical products* — Duffus–Sands–Woodrow's `B(n)`
generalised from uniquely colourable to gap-free factors — and, through `K_k^G`, of the *exponential graph's non-loop part*; its spectral
home is *vector colourings of categorical products*. Searched in those words (zbMATH API, `data/fs67/j27/zb.sh`, outputs
`data/fs67/j27/gate-{1,2,3}.out`), plus one web search, plus the held PDFs `[Tardif2008]`, `[Zhu2025]`, `[GodsilEtAl2020]`.

### 3.1 Findings, ranked

1. **The hierarchy FS-67 sits in is printed, and it kills the gap-free form at `k ≥ 4`.** `[Tardif2008]` §4.2, verbatim: "A(n): If G and H
   are uniquely n-colorable, then each n-coloring of G × H is induced by a coloring of G or H. B(n): If G is uniquely n-colorable, H is
   connected, and χ(H) > n, then G × H is uniquely n-colorable. In [17] it is proved that A(n) implies B(n) and B(n) implies H(n). It is also
   conjectured that A(n) holds for all n." ([17] = Duffus–Sands–Woodrow, JGT 9 (1985) 487–495, not held; zbMATH review: "two conjectures,
   both stronger than Hedetniemi's, which have to do with unique colorability, and which we show to hold in certain special cases".)
   `B(n)` is FS-67 for uniquely `n`-colourable `G` (uniquely colourable ⟹ gap-free, §IQ). With `[Tardif2023]` (H(4) false) and `[Shitov2019]`,
   **`B(n)` is false for every `n ≥ 4`**, so FS-67's gap-free form is false at every `k ≥ 4` — P-A is prior art by composition, and DA's job
   is the explicit construction (`G = K_k × X`) and the index check (a web summary [external, source page not opened] states the implication
   as `(B_n) ⇒ (C_{n+1})` with `C_n`: "χ(G) = χ(H) = n ⟹ χ(G × H) = n", which is Tardif's `H(n)` shifted by one — the same content; DA checks it).
   **What stays open in print:** `A(3)`, `B(3)` ("only under additional restrictions, such as one of the factors being a complete graph", same
   web summary) — DB's target.
2. **The spectral home is `[GodsilEtAl2020]` (held; Results 2–5 read here, §1.1, `arXiv:1801.08243`).** Result 4, verbatim: "Let G and H be
   graphs such that χv (G) < χv (H) and H is connected. If G admits a strictly complementary dual solution with strictly positive diagonal,
   then every optimal vector coloring of G × H is induced by G." and "if G is 1-walk-regular and H is connected with χv (G) < χv (H), then all
   of the optimal vector colorings of G × H are induced by G." A proper `k`-colouring of `G × H` is a simplex vector `k`-colouring, optimal when
   `χv(G) = k` (Result 1: `χv(G × H) = min`), and a vector colouring induced by `G` with distinct simplex vectors is a pullback. **So FS-67 holds
   for every 1-walk-regular `G` with `χv(G) = k` against every connected `H` with `χv(H) > k`, `H` not assumed vertex-transitive** [reading
   until DC-1 is written; the link `χv(G) = 1 + d/|λ_min|` for 1-walk-regular `G` is `[GodsilRobersonRooney2017]`'s, held]. Its reach is the
   strict regime (`χv ≤ χ_f`, so `χv(H) > k` forces `χ_f(H) > k`), and it is a different class from Zhang's (i) (arbitrary `H`, `G`
   1-walk-regular). **Result 3** (equal `χv`: every optimal vector colouring a convex combination of the two induced ones iff `rk(G × H) =
   rk(G) + rk(H)`) and **Result 5** are the vector form of the equal case — a DD route that needs no IS-primitivity.
3. **`[PakVilenchik2013]` Thm 3** (via `plans/M3-PA-mixing.md` Stage 4, verbatim there): "Let H be an r-regular graph with λ < r/(k − 1). Then
   G = Kk ⊗ H is uniquely k-colorable" — FS-67 at `G = K_k` with a spectral `H`; GRRSV Result 4 generalises it; J21-MX is the Hedetniemi-type
   (not uniqueness) statement at the same threshold. DC-2 (the mixing bootstrap) is the integral, arbitrary-gap-free-`G` form.
4. **`[Larose2002]`** (zbMATH review, verbatim): "If a connected graph G does not admit a homomorphism into K, where K is an odd cycle or a complete
   graph of order at least 3, then, for every s ≥ 1, the graph G × K^s admits exactly s homomorphisms into K" — PA-P3 in print, and the same for
   odd-cycle targets.
5. **Three colours: `[ElZaharSauer1985]`'s argument and `[Tardif2006alg]`** ("a polynomial algorithm, which inputs a 3-coloring of a categorical
   product of two graphs and outputs a 3-coloring of one of the factors", zbMATH review) are the routes for DB; neither is held. `[Zhu2025]` §4
   states K₃'s multiplicativity without proof. The El-Zahar–Sauer colouring of `K_3^G` is the object DB must re-derive with `G` 3-colourable.
6. **Neighbours by title, unread:** Zhu 1996/1999 (uniquely `H`-colourable graphs), Lai 1987/1989 (unique homomorphisms onto odd cycles),
   Larose–Tardif 2000 (*Hedetniemi's conjecture and the retracts of a product of graphs*), Sauer 1992 (*An approach to Hedetniemi's conjecture*).

### 3.2 Negatives (each measures its words, G21)

`ab:"uniquely colorable" & ab:"categorical product"` 0; `ab:"uniquely colourable" & ab:"product"` 0; `ab:"Hedetniemi" & ab:"3-coloring" &
ab:"product"` 0; `ab:"induced by" & ab:"coloring of one" & ab:"factor"` 0; `ab:"uniquely" & ab:"product" & ab:"Hedetniemi"` 1 (a proceedings
volume). The author listing `au:"Tardif, Claude" & py:1995-2026` (73) was scanned by title: the four above are the only product-structure titles.

### 3.3 What §PA taught us about our own object (WORKFLOW 9's sweep, done early)

- **FS-67 at `k` contains Hedetniemi at `k`** (P-A′, DA-2): the question is not about tightness at all unless tightness is what excludes
  `K_k × X`. The stub's D3 question ("is gap-freedom enough, or is the spectrum doing work?") is answered at `k ≥ 4` by print: gap-freedom is not
  enough.
- **"Pulled back from `G`" in vector language is "the Gram matrix is `M ⊗ J`"**, and GRRSV's rank criterion `rk(G × H) = rk(G)` is an exact
  test for it in the strict regime — the invariant §IQ asks for, in the spectral regime.

### 3.4 Prior-art debts (for the close)

`[DuffusSandsWoodrow1985]` §3 (the special cases of A(n), B(n)), `[ElZaharSauer1985]`, `[Tardif2006alg]`, Larose–Tardif 2000, Sauer 1992 — none
held; `[GodsilRobersonRooney2017]`'s χv-of-1-walk-regular statement to be quoted by DC-1 from the held copy. Bibliography rows proposed at the close.

## Stage 4 — SAVED (§IQ, §S, §P)

### 4.1 §IQ — the invariant question (WORKFLOW 3.3)

**Definitions (fixed here; the briefs quote them).** Graphs are simple and loopless; `k ≥ 3`. A proper `k`-colouring `c` of `G` is *gap-free* if
every closed neighbourhood `N[x]` meets all `k` colours. `G` is *`k`-gap-free* if it is `k`-colourable and every proper `k`-colouring of it is
gap-free. A `k`-colouring `β` of `G × H` (categorical product) is *pulled back from `G`* if `β(x, h) = c(x)` for some `k`-colouring `c` of `G`.
`E_k(G)` is the graph on the maps `V(G) → [k]` that are not proper colourings, `f ∼ g` iff `f(u) ≠ g(v)` for every ordered edge `(u, v)` of `G`.
**FS67(G, k)**: "for every connected `H` with `χ(H) > k`, every proper `k`-colouring of `G × H` is pulled back from `G`".

1. **Existence form.** Is there a Hoffman-tight (or `k`-gap-free) `G`, a connected `H` with `χ(H) > k`, and a `k`-colouring of `G × H` not pulled
   back from `G`?
2. **Structural form.** For a graph `G`, describe *every* `k`-colouring of `G × H`, over *every* connected `H` with `χ(H) > k` at once — in the
   most general class (any `G`, any cardinality, no arithmetic): for which `G` does FS67(G, k) hold, and what is the obstruction when it fails?
3. **The invariant it forces.** Every solution carries its **fibre map** `Φ : H → K_k^G`, `Φ(h) = β(·, h)` (PA-T6), which is either constant at
   a loop or lands in `E_k(G)`. So the answer is a property of `G` alone, `χ(E_k(G)) ≤ k`, and the invariant is:
   - *for a yes*, a **selection** — a proper `k`-colouring of `E_k(G)` choosing a colour inside each map's image (Greenwell–Lovász's `γ′`;
     at `k = 3`, El-Zahar–Sauer's colouring, whose engine is `K₃`'s height, G71);
   - *in the strict spectral regime*, the **fibre-measure vector** `x ↦ (μ(β(x,·)⁻¹(j)))_j ∈ Δ_k` (J21-MX), or the **Gram matrix** `M ⊗ J`
     (GRRSV Result 4);
   - *for a no*, a **Hedetniemi pair** hidden in `E_k(G)`: `E_k(K_k × X)` contains the image of every `H` with `χ(X × H) ≤ k` (DA-3).
4. **Route.** Derivation only (J27D); the verifier checks fixed statements (J27V); finite tests of `χ(E_k(G))` on named small `G` are PB, after
   2026-10-01.
5. **Open instances it would decide.** `S₁ = UD(𝔽₉, 2)` and every level of the 3-adic tower at `k = 3` (FS-58 D3.4, G61(3)); `U₃₂`, `U₄` and the
   2-adic tower levels at `k = 4` (rows 67, 93); FS-61 A.7's non-affine periodic colourings; row 85's R3a as an instance; `[Zhang2012]`'s
   exception (ii); the equal-`χv` pairs of GRRSV Result 3.

### 4.2 §S — the stages as jobs

**Bearing on χ ≥ 6, honestly:** none. The programme's own products — residue targets at four colours — are in the strict regime by PA-T4
(every residue target needing five colours has `χ_f > 4`), where Zhang (i) already decides them; at five colours only through PA-T5's holes
(`Γ₃₁`, tower levels ≥ 2 at 27, 31, 43, 47). FS-67 is mechanism: the three-colour justification under FS-58 and G61(3), and the answer to
"when must a colouring of a product be local at one factor" in the class where the literature has it.

| stage | job | what | size | stop rule |
|---|---|---|---|---|
| S1 | **J27D** (Opus, derivation) | the claims below, in the order DA → DC → DB → DD; a record with "Theorems this phase proved"; checks in `tools/crunch_j27d_*.py` with plants | ~3 h, 350k | hand back by 420k; DD may end GAP with the missing step named |
| S2 | **J27V** (Opus, blind verifier) | the fixed claim list (§4.3), blind phase, then the lemma-statement phase, then the divergence table | ~2.5 h, 300k | a verdict per claim; blind phase capped at 60 % of budget |
| PB | post-ban (≥ 2026-10-01; not queued) | `χ(E_3(G))` and `χ(E_4(G))` on named small tight `G` (`S₁`, `U₄`, `U₃₂`) by an exact finder, generator image stated (G21) | — | — |

### 4.3 The claims (target statements; the verifier's fixed list quotes these verbatim)

- **DA-1** "If `G` is connected and `k`-colourable but not `k`-gap-free, then for every graph `H` with at least one edge there is a proper
  `k`-colouring of `G × H` not pulled back from `G`."
- **DA-2** "If `G` is `k`-gap-free and has no isolated vertex, then FS67(G, k) holds if and only if `χ(E_k(G)) ≤ k`." (PA-T6, re-derived.)
- **DA-3** "For `k ≥ 3` and a connected graph `X` with `χ(X) > k`, the graph `G = K_k × X` is connected and uniquely `k`-colourable, hence
  `k`-gap-free; and FS67(K_k × X, k) fails if and only if some connected graph `H` with `χ(H) > k` has `χ(X × H) ≤ k`."
- **DA-4** "For every `k ≥ 4` there is a finite connected uniquely `k`-colourable graph `G` for which FS67(G, k) fails; and for every `k ≥ 3`,
  if FS67(G, k) holds for every finite connected `k`-gap-free `G`, then `χ(X × H) > k` for all finite graphs `X`, `H` with `χ(X), χ(H) > k`."
- **DB-1** "For every connected non-bipartite graph `G`, `χ(E_3(G)) ≤ 3`; hence FS67(G, 3) holds for every connected 3-gap-free graph `G`."
- **DB-2** "`UD(𝔽₉, 2)`, and every level of the 3-adic tower that is Hoffman-tight at three colours, is connected and 3-gap-free." (Consumer of
  DB-1 or DC-1.)
- **DC-1** "If `G` is 1-walk-regular with `χv(G) = k` and `H` is connected with `χv(H) > k`, then every proper `k`-colouring of `G × H` is pulled
  back from `G`." (From `[GodsilEtAl2020]` Result 4; state the link between `χv(G) = k` and Hoffman-tightness for 1-walk-regular `G`, with its
  source.)
- **DC-2** "If `G` is connected and `k`-gap-free, and `H = Cay(A, T)` for a finite abelian group `A` with `λ* = max_{χ ≠ 1} |Σ_{t ∈ T} χ(t)|/|T| <
  τ_k`, then every proper `k`-colouring of `G × H` is pulled back from `G`" — with `τ_k` an explicit function of `k` that J27D states and proves
  (the target is Pak–Vilenchik's `1/(k−1)`; any explicit positive `τ_k` is a result).
- **DC-3** A table: for `k = 3, 4, 5` and the residue planes `Γ_q` of G44's exact spectra, which satisfy DC-1's or DC-2's hypothesis on `H`
  (exact, seconds; no search).
- **DD-1** "If `χv(G) = χv(H) = k`, `χ(H) > k`, `H` connected, and `G`, `H` satisfy `[GodsilEtAl2020]` Result 5's hypothesis, then every proper
  `k`-colouring of `G × H` is pulled back from `G`" — TRUE, FALSE with a counterexample, or GAP at a named step; and whether it reaches
  `[Zhang2012]`'s IS-imprimitive exception.
- **DD-2** "For some `k ≥ 4` there is a regular Hoffman-tight (`λ_min = −d/(k−1)`) connected graph `G` for which FS67(G, k) fails" — or its
  negation for a named class, or GAP naming the missing ingredient (the route to test: `K_k × X` is Hoffman-tight iff `λ_min(X) ≥ −d_X/(k−1)`
  for regular `X`, so DD-2 asks for a Hedetniemi pair `(X, H)` at `k` with that spectral condition on `X`; `[Tardif2022frac]`, *Counterexamples
  to Hedetniemi's conjecture with large fractional chromatic numbers*, is the first reading).

**Routes (fenced from J27V):** DA-1 recolour one gapped vertex in one fibre; DA-3 ⟸ by `β(i, x, h) = c(x, h)`, ⟹ by GL Cor. 1 on
`K_k × (X × H)`; DA-4 from `[Tardif2023]` Thm 1 (components of max χ) and `[Shitov2019]`; DB-1 by re-deriving El-Zahar–Sauer's colouring of
`K_3^G` and checking where non-3-colourability of `G` is used (the bipartite double cover `G × K₂` carries `(f, g)` as one proper 3-colouring;
heights, G71); DC-1 from GRRSV Result 4 and `[GodsilRobersonRooney2017]`; DC-2 by bootstrapping J21-MX's mixing lemma with gap-freedom: with
`ε = sup_{x, c ≠ φ(x)} m_c(x)`, the neighbour `x_c` of colour `c` gives `m_c(x)/(1 − m_c(x)) ≤ λ*²(k−1)ε/(1 − (k−1)ε)`, a contraction for small
`λ*` (naively `λ* ≲ 0.44` at `k = 3`); sharpen toward `1/(k−1)`; DD-1 from Result 3/5's convex-combination form restricted to simplex Gram
entries; DD-2 via `K_k × X`.

### 4.4 §P — registered predictions (priors of §1.2 stand; added here, before J27D runs)

| id | statement | prior |
|---|---|---|
| P-H | DC-1 TRUE as stated | 0.85 |
| P-I | DC-2 proved at some explicit `τ_k > 0` | 0.90; at `τ_k = 1/(k−1)`: 0.45 (= P-C′) |
| P-J | DD-1 TRUE | 0.40; FALSE 0.15; GAP 0.45 |
| P-K | DD-2 ends GAP | 0.60 (= P-D) |
| P-L | J27V records at least one divergence from J27D on a claim | 0.50 |
| P-M | DB-1's route needs the non-bipartite hypothesis only (not non-3-colourability) | 0.55 (= P-B's TRUE) |
