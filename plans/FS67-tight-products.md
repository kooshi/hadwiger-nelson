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
