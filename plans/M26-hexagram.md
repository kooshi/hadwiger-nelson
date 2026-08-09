# M26 — The hexagram: 6 pivots + metapivot, unconditionally

*Stub recorded 2026-08-08 (Kooshi's construction, corrected geometry); subplan
opened 2026-08-09 on Kooshi's go. §0 predictions are registered BEFORE the
experiments run — the commit of this section predates every instrument result
below it.*

## Scope

The **6+1 system**: the pivot hexagon of circumradius 1/√3 about the metapivot
m = (1+ζ₆)/3 — the M23 triangle T₁ = {0, 1, ζ₆} PLUS its point-reflection
through m, T₂ = {q₀, q₁, q₂} = {2m, 2m−1, 2m−ζ₆} (the mirror centroids,
already certified as the inner∩inner(m) glue points,
`Triangle.inner_inter_metaInner`). Seven ladders (six pivots + the metapivot,
each an M24 `outerPt`/`innerPt` family); all cross-webs classified; the
complete chord and fusion inventory; the colouring theorem
`chromaticNumber_hexagram`.

## §0 Registrations — predictions BEFORE instruments

### §0.1 E1 — The frame: coordinates, the ℤ/6 action, and the two new webs

Hand-derived at subplan opening; the instruments confirm or kill each line.

* **P1.1 (self-seeding, exact).** The T₂ pivots lie in ℚ(ζ₆):
  `q₀ = 2(1+ζ₆)/3`, `q₁ = (2ζ₆−1)/3 = i/√3`, `q₂ = (2−ζ₆)/3 = m̄`.
  The **meta-inner hex layer at height 0 IS the pivot hexagon**:
  `innerPt m metaAnchor (a, 0)` for a = 0..5 equals
  `q₀, ζ₆, q₁, 0, q₂, 1` in that address order (T₁ at odd addresses 1, 3, 5 —
  the M25 hub layer — T₂ at even addresses 0, 2, 4). So the six pivots are
  already vertices of M25's `fourLadder`, and the six unit pivot pairs are
  exactly the rot3 intra-chords of the meta-inner ladder. The promotion adds
  centres, not points.
* **P1.2 (the ℤ/6 action).** `rot6 z := m + ζ₆·(z − m)` cycles the pivots
  `q₀ → ζ₆ → q₁ → 0 → q₂ → 1 → q₀` (meta-inner address a ↦ a+1), satisfies
  `rot6² = ` M25's 120° `metaRot`, fixes the meta ladder up to address shift
  +1, and — with ALL six pivot ladders anchored at direction 1 (partner v+1) —
  carries every ladder family to a ladder family with hex-address shift +1
  (M25's `outerPt_hexRot` absorbing the rotated anchor).
* **P1.3 (four pair-orbits, two new masters).** The 21 centre pairs fall into
  exactly four ⟨rot6⟩-orbits: **unit** (6 pairs, rep (0,1) — M24's master),
  **pivot–meta** (6 pairs, rep (0,m) — M25's master), **adjacent** (6 pairs,
  rep (0,q₂), separation s = m̄, 3s = ḡ), **opposite** (3 pairs both
  orientations, rep (0,q₀), s = 2m, 3s = 2g). M26 proves TWO new master webs
  and transports everything else; the six unit webs come from M24's pair via
  rot6-powers (M25 did three of them at 120°), the six pivot–meta webs extend
  M25's `j : Fin 3` quantifier to `Fin 6`.
* **P1.4 (the eight new master forms, exact — signs in the (0→partner)
  orientation, `Tr(z) := z + z̄`, w₁ the 0-ladder word, w₂ the partner word,
  both anchors direction 1).** Derived by hand from
  `|s + ρ₂w₂ − ρ₁w₁|² ∈ {1, 0}` and 2Re(s·w̄) = (1/3)Tr(g·w) per g-factor:

  | family | cleared master (chord) | fusion constant |
  |---|---|---|
  | adj oo | `Tr(gw₁) − Tr(gw₂) + 3Tr(w₂w̄₁) = 4` | `= 7` |
  | adj oi | `√3Tr(gw₁) − Tr(gw₂) + 3Tr(w₂w̄₁) = 2√3` | `= 5√3` |
  | adj io | `Tr(gw₁) − √3Tr(gw₂) + 3Tr(w₂w̄₁) = 2√3` | `= 5√3` |
  | adj ii | `Tr(gw₁) − Tr(gw₂) + √3Tr(w₂w̄₁) = 0` | `= 3√3` |
  | opp oo | `2Tr(gw₁) − 2Tr(gw₂) + 3Tr(w₂w̄₁) = 7` | `= 10` |
  | opp oi | `2√3Tr(gw₁) − 2Tr(gw₂) + 3Tr(w₂w̄₁) = 5√3` | `= 8√3` |
  | opp io | `2Tr(gw₁) − 2√3Tr(gw₂) + 3Tr(w₂w̄₁) = 5√3` | `= 8√3` |
  | opp ii | `2Tr(gw₁) − 2Tr(gw₂) + √3Tr(w₂w̄₁) = 3√3` | `= 6√3` |

  (Adjacent uses `2Re(s·w̄₂) = (1/3)Tr(g·(ζ₆⁻¹w₂))`-type shifts since
  3s = ḡ = ζ₆⁻¹g — the ḡ-trace is a g-trace at a shifted address via M25's
  `g_shift`; the table rows above absorb that shift into w₂'s address. Exact
  signs and address conventions are what instrument D2 pins; the GENUS —
  which terms carry √3, the κ values, the doubling on the opposite web — is
  the registered claim.) Note the κ-echo: adjacent κ ∈ {4,7}/{2,5}/{0,3} —
  exactly M25's meta-web constants (same |s|², same radii) — while opposite
  doubles the g-coefficients and shifts κ to {7,10}/{5,8}/{3,6}.
* **P1.5 (no infinite families in the new webs).** Neither new web has a
  matching branch (no unit torsion `w₂ = ζ₆^k w₁` makes the master constant)
  nor a hub pencil: the mutual-membership points of adjacent pairs
  (0 ∈ inner(q₂), q₂ ∈ inner(0)) sit at ζ₁₂-fibre directions, which are
  **never lattice words** (M24's empty `Re = √3/2` fibre), and the opposite
  distance 2/√3 lies on no circle pair. All eight new chord families are
  finite sporadic lists. Contrast: the pivot–meta oi hub pencil (infinite)
  remains, now at all six pivots.

### §0.2 E2 — The engine transfers whole (the research risk, small this time)

* **P2.1 (no new ring input).** Every new master clears by √3-powers into
  M24/M25's ℤ[ζ₆,π] trace pairs (`hexTrace` with arbitrary ℤ[ζ₆]
  coefficients); ζ₁₂ never enters the arithmetic (the T₂ coordinates are in
  ℚ(ζ₆) — P1.1). The coefficient tables: adjacent = `gE`/`gF` at shifted
  addresses (ḡ = ζ₆⁻¹g), opposite = doubled (`2gE`/`2gF`). The kill toolkit
  carries: φ(2g) = 2φ(g) = 0, 3 ∤ 2gE wherever 3 ∤ gE, `alone_dvd`/`phi_dvd`
  verbatim, the pin kills at the same two-stage (mod √3, mod 3) ladder.
* **P2.2 (the mod-9 rescans).** `adjacent_kill`'s 36-pair mod-9 scan must be
  RE-RUN for each new (coefficient-table, κ) combination before its Lean
  decide is stated — the carry-forward's warning made binding. Prediction:
  all height-unbounded branches close under the existing kill genus (mod √3
  parity, mod 3 rows, mod 9 adjacent-heights); **failure clause**: a family
  whose endgame does not close under the toolkit plus realizable-address
  boundary decides is reported NOT LANDED, the χ theorem stated conditional
  on exactly that family, the milestone re-scoped openly.
* **P2.3 (sporadic windows).** All new-web sporadics live at |b| ≤ 1
  (medium confidence — the M24/M25 precedent; the census decides, no count
  prior registered).
* **P2.4 (the tangency is invisible — scope deletion).** The opposite-ii
  fusion (the triple tangency at m) is EMPTY at the lattice level: m is never
  a lattice word of any family (ζ₁₂ fibre), so the tangency kill is the
  ordinary fusion-κ run at `6√3` — **the `sphere_inter_sphere` tangency
  degeneracy is NOT needed** for the headline and leaves M26's scope. More
  generally, m ∉ hexagram: the object does not contain its own centre.

### §0.3 E3 — The census bed

* **P3.1 (instrument + controls).** `build/m26-census.py`: the exact
  quartic-field census extended to all 14 families (7 anchors × 2 circles),
  B = 30 with a growth check. Controls, all must pass before any new number
  is believed: the six unit-pair webs reproduce M24's PROVEN tables
  (transported addresses); the six pivot–meta webs reproduce M25's tables
  (the three T₂ webs as exact address shifts of the masters); a planted
  disagreement is refused by name. Promotion into
  `tools/couple.py --hexagram-census` happens at implementation, with the
  self-test carrying planted chord AND fusion disagreements (M25 discipline).
* **P3.2 (the fusion inventory).** Registered: the complete lattice-level
  fusion (coincidence) inventory of the hexagram is — the six pivots, each a
  TRIPLE point (meta-inner at its hex address, and the outer points of its
  two second-neighbour pivots — the rot6 transport of M25's
  `meta_fusion_oi`), PLUS M24's eight pair-fusion points transported to all
  six unit pairs, and NOTHING else: all eight new-web fusion families
  (adjacent ×4, opposite ×4) are EMPTY. (Medium on the "nothing else";
  the emptiness of the eight is high — the κ-shifted spines at P1.4's fusion
  constants.)
* **P3.3 (the loop census, the stub's ask made binding).** With 7 centres,
  pure-seam relations of length 4 exist — the pivot parallelogram: hexagon
  edges (0,1) and (q₀,q₁) are parallel with equal difference
  (0 − 1 = q₁ − q₀ = −1), so
  `S₀ ∘ S₁⁻¹ ∘ S_{q₁} ∘ S_{q₀}⁻¹ = id` (seam rotations compose to
  translations `t·(p−q)` which cancel on parallel edges). Length 4 is
  impossible at the triangle (M23: minimal 6, no parallel edge pairs). The
  census confirms the witness and reports the new minimum.

### §0.4 E4 — The colouring probe and the fork

* **P4.1 (the table, symmetry-first).** The b-independent colour probe runs
  on the fusion-deduped collapsed classes (M24/M25 method), **trying the
  rot6-equivariant solution first**: a colour permutation τ ∈ S₄ with
  `colour(rot6 z) = τ(colour z)` — τ a 3-cycle is the natural candidate
  (τ⁶ = id, fixed-point-free on the hex cycle it must break). If the
  symmetric probe is SAT, the properness burden collapses to the four
  orbit-representative webs plus intra; if UNSAT-symmetric but SAT-free, the
  free table ships and properness runs the full case bash (fallback, more
  decides, no new mathematics). Registered: symmetric SAT at medium
  confidence, free SAT at medium-high.
* **P4.2 (the fork, pre-committed).** If k = 4 is UNSAT at census depth and
  the kill is injection-verified, the milestone pivots to certifying the
  5-forcing — that outcome is the MORE valuable one and is taken without
  re-asking. k = 3 UNSAT is the control (the M24 witness sits inside).
* **P4.3 (the bounds).** χ ≥ 4 is free: `fourLadder ⊆ hexagram` (the first
  four anchors), M25's lower bound transports by subset monotonicity. χ ≤ 4
  is the table; the headline is `chromaticNumber_hexagram = 4`.

### §0.5 Instrument specs (run AFTER this section commits)

| # | instrument | checks |
|---|---|---|
| D1 | `build/m26-design.py` | P1.1 coordinates + hex-layer identity; P1.2 rot6 action + address shifts; P1.3 orbit table |
| D2 | same | P1.4: all eight masters verified symbolically (exact ℚ(√3,√11)-arithmetic), fusion constants, exact sign/address conventions fixed |
| D3 | same | ground truth: exact solve of each new family over \|b\|,\|d\| ≤ 8, all 36 address pairs, chord + fusion κ; sporadic tables extracted; P1.5/P2.3 checked |
| D4 | same | the m25-design2 discipline: the PLANNED Lean case tree (parity split, alone/φ/pin kills, mod-9 rescans P2.2, realizable-address boundary decides) replayed exhaustively against D3's ground truth — every decide pre-verified before Lean states it |
| D5 | `build/m26-census.py` | P3.1 full-object census + controls; P3.2 fusion inventory; point/edge counts |
| D6 | `build/m26-color.py` | P4.1 probe (symmetric-first), P4.2 controls (k=3 UNSAT, injection-verified if the fork fires) |
| D7 | `build/m26-loops.py` (or `couple.py --loops` if it parameterizes) | P3.3 length-4 witness + new minimum |

### §0 results — PENDING (recorded after the instruments run; nothing above
this line changes once committed)

## §1 Scope (post-§0 shape) — PENDING instruments

Preliminary, refined after D1–D7:

1. **The object** (`Proofs/HadwigerNelson/Hexagram.lean`, imports
   `MetaLadder`): `hexAnchor : Fin 7 → ℂ × ℂ` — indices 0–3 = M25's four
   anchors verbatim (so `fourLadder` is the restriction and the χ ≥ 4
   subset lemma is one line), 4–6 = the T₂ pivots with direction-1 partners.
   `hexagram : Set ℂ` the 14-family union.
2. **Transport** (§T): `rot6`, its pivot 6-cycle, `rot6² = metaRot`, the
   family transports with shift +1 — the M25 transport kit's square root.
3. **The adjacent master web** (§A): four completeness + four (empty) fusion
   theorems at (0, q₂), tables from D3.
4. **The opposite master web** (§O): same at (0, q₀).
5. **The extended quantifiers** (§U/§M): unit webs at all six pairs, meta
   webs at `j : Fin 6` — transports of M24/M25 masters.
6. **The colouring** (§C): the table from D6 (symmetric if SAT), decode over
   `Fin 7`, fusion agreement from P3.2, properness per orbit-representative
   web, `chromaticNumber_hexagram`.

MetaLadder's private engine (`web_master`/`web_master_rev`,
`hexTrace_rows_const`, `adjacent_kill`/`adjacent_mod9`, the pin-kill trio,
`metaRot_inj`) gets **promoted to public** in `MetaLadder.lean` at the
experience pass (the carry-forward's recommendation) — the cost is one
re-elaboration of `MetaLadder` and `Proofs.lean`, no generated dependents.

## M25 carry-forward (recorded at the M25 close, 2026-08-09)

What the M26 subplan can take as settled, and where the tooling lives:

* **The engine transfers whole.** `√3·ζ₁₂ = 1 + ζ₆` (`MetaLadder.sqrt3_mul_zeta12`)
  eliminated the twelfth root from every 1/√3-axis equation; the mirror-centroid
  axes are again ζ₁₂-coset directions at 1/√3 (and 2/√3 = 2·(1/√3) for the
  opposite pairs), so the same clearing applies. The expected master shape stays
  `κ − Tr(g·w₁) − μ·Tr(g·W) + λ·Tr(V) = 0` with new (κ, μ, λ) per radius pair —
  re-derive by the `build/m25-design2.py` pattern (exact tree vs exact ground
  truth over a window) BEFORE writing Lean; every M25 decide passed first try
  because of that discipline, and the one decide that was false as first stated
  (a boundary quantified over unrealizable addresses) was caught by it… by the
  kernel; the script check is what would have caught it earlier. Constrain
  boundary decides to REALIZABLE addresses (x₃ and y are functions of A, c and
  the seam signs — quantifying them freely can make a true kill undecidable).
* **The fusion-κ trick is anchor-generic**: a coincidence classification is the
  chord classification at normSq = 0, i.e. the same κ-parameterized spine at a
  shifted constant (M25: oo 4→7, oi/io 2→5, ii 0→3√3). Plan M26's decode
  well-definedness as κ-instances from the start, not as a separate enumeration.
* **`adjacent_kill` / `adjacent_mod9`** (two g-traces at heights h, h+1 never
  sum to 9·anything; residues pinned to {1,4,7} mod 9) closes height-unbounded
  endgame branches; it is address-table-generic over the gE/gF tables and
  should port to whatever coefficient tables the mirror-centroid webs produce
  (re-verify the 36-pair scan for the NEW tables first).
* **Public vs private in `MetaLadder.lean`**: public — `hexTrace`,
  `hexTrace_coords`, `inRing_hexTrace`, `gTr`/`uTr`, `gTrace_clear`/`uTrace_clear`,
  `gAddr`/`uAddr`, `hexTrace_rows`, `hexTrace_add`, `hexTrace_zero_height`,
  `hexTrace_eq_zero`, `hexTrace_pin`, `not_three_dvd_pin`, `alone_dvd`, `phi_dvd`,
  `phi_g_dvd`, `gE`/`gF` + their table facts, the bridges and fusion bridges, the
  four completeness and four fusion theorems, the transports. Private (re-derive
  locally per the house §0 pattern, or promote at the M26 experience pass) —
  `hexTrace_rows_const` (the κ-row extractor), `adjacent_kill`/`adjacent_mod9`,
  `web_master`/`web_master_eq`/`web_master_rev`, the per-family masters and
  cleared lemmas, the pin-kill wrappers (`g_pin_kill`, `u_pin_kill_dvd`,
  `u_pin_one`, `g_zero_ne_kappa`), `metaRot_inj`, the re-addressing lemmas
  (`outer0_to02` etc). Promoting `hexTrace_rows_const`, `adjacent_kill` and the
  pin-kill trio to public is probably the right M26 experience-pass call.
* **Lean idioms that cost time in M25** (all recorded in the session memory too):
  `Eq.trans` chains instead of `rw … at hspec` when the hypothesis mentions an
  `Exists.choose` whose ∃-type contains the rewritten term;
  `linear_combination (norm := (push_cast; ring)) h` whenever `h` carries
  compound casts; keep pow-atoms syntactically identical for `omega` (no
  `norm_num at` on them); multiline `.trans` continuations must indent past the
  `have` column.
* **The M26-specific new work** (updated by §0 above): the 2/√3-axis and
  adjacent-axis derivations (the tangency case DELETED from scope per P2.4),
  the 7-centre loop census with the registered length-4 parallelogram
  prediction (P3.3), and the D₆ symmetry decision — RESOLVED at registration:
  ℤ/6 rotation transport (rot6), reflections unnecessary (P1.2/P1.3).
