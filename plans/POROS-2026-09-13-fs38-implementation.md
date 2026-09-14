# Poros, 2026-09-13 (evening) — the FS-38 implementation: reading the closed statements aloud, auditing the controls

*Written by a Poros pass advising the FS-38 implementation (implementer K: the kernel headline, phases K1–K2; implementer
T: the tools and records, phase T; product owner: de Bruijn; principal: Kooshi), continuing the morning record
`plans/POROS-2026-09-13-fs38-subplan.md`, whose hunch ledger, question cards and demanded controls are the baseline here.
Poros finds the question; it does not answer the problem. Every claim carries an address; every hunch a falsifier; the
domain (the kernel for K, the controls for T) decides the findings. Depth units as §S1 of `plans/FS38-residue-tower.md`:
`depth := v_𝔓(z − w) = v₂(d²)` for rational `d²`; M53's `v2` column is this number; M56's "depth 3" is depth 6 here.
This file is not committed by this pass; the close (phase C) commits it by path.*

## The situation survey on arrival

**The goal in the principal's words.** "Finding anything useful to get to 6 chromatic … or disproving it if we're at
that point" (Kooshi, 2026-09-13). The programme's standing bet: *χ(F²) equals its best local bound wherever that bound is
≤ 6* (G48, FS-15).

**The record by provenance.** Committed at `31702dc` (tree clean at opening): the subplan `plans/FS38-residue-tower.md`
through its three modeling passes (§S0–§S10, §M1–§M3); the skeleton — six modules, `FanGap.lean` (18 `sorry` leaves
read here), `Instances/FanGap11.lean` (8), `Instances/FanGap19.lean` (3), plus the three 2-adic modules for K3 (not this
phase's); the morning Poros record. Not on disk at opening: `tools/fs38_tower.py`, `data/fs38/`, `scratchpad/fs38/` —
phase T starts from nothing but the planner's scratch copies of two tables and the pilots.

**The instruments and their nulls.** The kernel (`decide +kernel` on 121- and 361-entry tables; the general theorems
by case analysis) — its null is a `sorry` that never closes or a statement that closes vacuously. The solver side
(cadical, untrusted refusals, verified models) — its null at the 2-adic `gap` ask is uninterpretable without the
planted control, since no SAT instance of that ask on that object is known at any level; its `forced` ask has no known
positive below level 5.

**The frame on its five axes, as the subplan holds it, each with its address.**

| axis | the subplan's commitment | address |
|---|---|---|
| object | `FanGap`, `Slack`, `SharedGap`, `Fusable`, `PairwiseFusable` on any graph `P`; the plane `UD(𝔽₁₁,2)` at five colours as the instance; `UD(𝔽₁₉,2)` for the forces half | §S2, §M1 reframes 1–3 |
| question | does the residue plane's whole arity-2 compulsion structure at five colours pull back to every graph mapping into it — `Forces ↔ =` and `Separated ↔ Adj` | §S2 D0.5, §S8 decision 1 |
| discipline | graph homomorphisms and one repaint over an independent set; Cayley translation and rotation for the transport | §S2 D0.1–D0.4, §M3 reframe 2 |
| audience | the kernel (three modules), then the record (row 66, G54, G48, G31) | §S6 rows K1–K2, C |
| product | "every `sorry` closed; the negative control done once"; "every headline names its population and trust word" | §S6 acceptance column |

## Evidence inventory

Each item read against an expectation written before the reading; the address is where the reading happened.

- `plans/POROS-2026-09-13-fs38-subplan.md` (the morning record, whole) — read against: its corrections all folded into §S by the planner, its ledger scorable now — surprised: no; every correction it requested is in §S9's audit table, and its ledger is carried below
- `plans/FS38-residue-tower.md` §S1 (units) — read against: one unit, `depth = v₂(d²)`, with the three record usages translated — surprised: no; the table has M53 `v2`, M56's halved unit, and the tower's level; "at either prime" for non-rational `d²`
- §S2 D0.1–D0.6 — read against: each theorem's hypotheses exactly what its proof uses, no forces-freeness anywhere, `hc` gone after §M1 — surprised: no; D0.4's `hc : P.Colorable k` is replaced by `Fusable` supplying its own colouring (§M1 reframe 1), which is the right shape: with `V` nonempty and `k = 0` no `Fusable` holds, so the hypothesis fails rather than the conclusion lying
- §S3 (the 2-adic law as P-A1–P-A6) and §S4 (what the tower bounds) — read against: both outcomes reachable for every prediction; forcing transfers nowhere — surprised: no; P-A3 is marked "not independent" as the morning pass argued; the FORCED rows stay solver-side above level 5
- §S6 (phases and acceptance) — read against: K1/K2 acceptance = every `sorry` closed + the negative control once; T acceptance = population and trust word per headline — surprised: yes, once: T's control list in §S6 names "a planted fibre edge caught; every verified model re-checked by an independent function against every edge; the negative control of the brief at 11 (55 conflicts); the Latin-square count 576; UNSAT never a fact" — but **not the planted-gap control at 2 that §S3's P-A3 row demands**, nor a positive control for `forced` at level 5. Both are asked of T in the opener (below)
- §S7–§S8 — read against: the stub's P1–P4 scored honestly; twelve settled decisions each with an alternative — surprised: no
- §M2 (obligation pass) — read against: every leaf a finite case analysis, the false leaf (`twoAdicLevelHom` at `m = 0`) re-indexed, the adversarial list complete — surprised: no; the list is: delete `hne`; drop `γ ≠ C v`; drop `hadj`; shift the level hom; change one table entry; `#print axioms`
- §M3 (experience pass) — read against: the graph-alone theorem primary, `_of_hom` derived; the base-edge transport a theorem for every ring — surprised: no; and the two reds added there (`finitePlane11_sharedGap_corrupt_refused`, `finitePlane19_not_fanGap_zero`) are read below
- `Proofs/HadwigerNelson/FanGap.lean` (every declaration, 18 leaves) — read against: each statement is its §S2 sentence with the §M1 shape — surprised: no on the statements. Read aloud: `not_forces_of_fanGap (h : FanGap C (f u) γ) (hne : u ≠ u') : ¬ Forces G k u u'` is D0.2 exactly (`Forces G k p q := ∀ C, C p = C q`, `Forcer.lean:41`); `not_separated_of_sharedGap (h : SharedGap C (f u) (f u') γ) (hadj : ¬ G.Adj u u') : ¬ Separated G k u u'` is D0.4's first half; `PairwiseFusable.separated_iff_adj (h : PairwiseFusable G k) : Separated G k u u' ↔ G.Adj u u'` is D0.4's composite with one hypothesis; `Slack.forces_iff (h : Slack G k) : Forces G k u u' ↔ u = u'` is D0.2 (a); `three_le_arityFloor_of_forces_eq_of_separated_adj (hcol) (hf) (hs)` is the right general form because `Compels` at arity 2 is exactly `¬Adj ∧ Separated` or `Forces` (`Arity.lean:182,195`) and `two_le_arityFloor` needs `Colorable` (`Arity.lean:254`); `unitQuadrance_exists_hom_to_base` states `σ v = (0,0) ∧ σ w = (1,0)`, and with `rotHom_apply` (`PlaneRotation.lean:94`: `(a w₁ − b w₂, b w₁ + a w₂)`) and `(a,b) = (d₁, −d₂)`, `rot d = (d₁² + d₂², 0) = (1,0)` — the direction is right; `FanGap.translate` reads correctly against `addCayleyTranslate_apply` (`t + v`, `ResidueObstruction.lean:82`)
- `Proofs/HadwigerNelson/Instances/FanGap11.lean` (every declaration, 8 leaves) — read against: the instance theorems are D0.5's forms with M60's hypotheses exactly (`Q4.sevenFree.res11`, `CoordsIn Q4.sevenFree`, `u * denom = 1`, `Valid`), Heule-510 through the existing `heule510Reduce11` (`FinitePlane11.lean:62`) — surprised: no on the statements; yes on one red, below. `heule510_colorable_five` exists (`FinitePlane11.lean:112`), so `three_le_arityFloor_heule510` has its colourability
- `finitePlane11Table` (`Instances/FinitePlane11.lean:70`), re-derived in `build/fs38-poros/check_tables.py` (Python over the Lean source text, circle recomputed, no `tools/` import) — read against: proper; gap colour 2 at `(2,4)`; colour 0 present at `(2,4)` so the red is reachable — surprised: no; 0 improper of 726 edges; own colour 1, neighbours `{0,3,4}`; exactly **three** gapped vertices `(2,4), (7,8), (9,6)`, the morning record's "3 gapped vertices" reproduced
- `finitePlane11DoubleGapTable` (`Instances/FanGap11.lean:54`), same script — read against: proper; the three `#guard`s; colour 4 absent from `N[(0,0)] ∪ N[(1,0)]`, 22 vertices — surprised: no; 0 improper; guards `0, 3, 1` hold; colours on the 22 are `{0,1,2,3}`, 4 absent; `(0,0) ~ (1,0)` with common neighbours `(6,3), (6,8)` (the morning's "exactly two"); 10 gapped (vertex, colour) pairs in the table overall
- `finitePlane11_sharedGap_corrupt_refused` (`Instances/FanGap11.lean:92`), the corrupted table computed — read against: the M04 "corrupted table" pattern, refused by a `decide` — surprised: yes; the table with `(0,0) := 4` is STILL a proper colouring (0 improper edges — 4 was absent from `N(0,0)`), so the `∃ C : Coloring` is inhabited as far as properness goes and the refusal comes from `SharedGap` alone, in fact from its **first conjunct** `γ ≠ C v` at `(0,0)` (and independently from the second at `(1,0)`, since `(0,0) ∈ N(1,0)` now carries 4). The honest proof is one line and exercises no `decide`; it is a red on the definition, not on the table. The §M2 control "change one entry of the table, the `decide` refuses" is the one that tests the `decide`, and K is asked to run it once and name the entry and the `decide` that went red
- `circ19Table ∘ projAlong (1,1)` (`Instances/LocalGlobal19.lean:49`), same script — read against: proper on `UD(𝔽₁₉,2)`; at `(4,0)` colour 4, neighbours `{0,2,3}`, gap 1; colour 0 present — surprised: no AT THE TIME, and the reading was WRONG: my script encoded the skeleton docstring's "`x + y = 4`" instead of `projAlong`'s definition (`LocalGlobal.lean:151`: `v.1·w.2 − v.2·w.1`, so along `(1,1)` it is `y − x`). K's `decide +kernel` refuted `FanGap … (4, 0) 1` (commit `795fc7b`); re-run under `y − x`: `(4,0)` has class 15, all five colours on `N[v]`, **no gap**; `(0,4)` has class 4, gap 1; exactly two gapped classes, 4 (own 4, gap 1) and 10 (own 3, gap 1). **Why my check could not catch it:** `circ19D = −circ19D`, so `circ19Table ∘ (x + y)` is ALSO a proper colouring (0 improper of 3,610) with the SAME gapped classes — my properness control passed for both candidate functionals and discriminated neither. The count 38 stands (2 classes × 19); the vertex was wrong. Poros public retraction 1; the mechanism is the seen/read cut — the summary (docstring) was read in place of the primary (the definition)
- `heule510_residue_zero_eq_475` (`Instances/FanGap11.lean:185`), `tools/heule510.json` rows 0, 475, 19, 59 read with the slot order of `NarrowFan.lean:48` (little-endian over √3, √5, √7, √11) — read against: 0 and 475 have the same residue `(0,0)`; 19 and 59 are the `5/3` pair with distinct residues — surprised: no; vertex 0 is the origin; vertex 475's four nonzero slots (9, 11, 8, 10) all carry the √11 bit, so `res11` (√11 ↦ 0) sends it to `(0,0)` by inspection, and every term of `d²(0, 475)` has a factor 11; vertex 19 ↦ `(0, 1)`, vertex 59 ↦ `(2, 1)` (`7 · 16 ≡ 2`, `7 · (−80) ≡ 1`), non-adjacent (difference `(2,0)`, quadrance 4), and `d²(19, 59) = 1/36 + 11/4 = 25/9` — the `5/3` pair
- `Proofs/HadwigerNelson/Instances/FanGap19.lean` (3 leaves) — read against: the forces half only, no virtual-edge half, a NAMED `Fact (Nat.Prime 19)` — surprised: no; the docstring states the coincidence failure at shifts 7 and 12 as the reason the virtual-edge half is absent
- `Arity.lean:90` (`Compels`), `:182` (`compels_two_eq`), `:195` (`compels_two_ne`) — read against: arity 2 is exactly `Separated`-on-a-non-edge or `Forces` on an injective pair — surprised: no
- The Poros gate (`~/source/poros/.claude/skills/poros/scripts/poros_gate.py`; the charter's `scripts/poros_gate.py` path is stale) — read against: self-test exits 0 with one warning — surprised: no (PASS, 0 failures, 1 warning on the example's unread item)
- The conditions of the last reading — read against: the morning pass at moderate depth with every primary opened; this pass fresh, every table re-derived, the implementers not yet heard from — surprised: no; what this pass has NOT read: any closed proof (none exist yet), any T artifact (none exist yet)
- `Proofs/HadwigerNelson/FanGap.lean` closed by K (18:06, `git diff` against `31702dc`: 174 insertions, 27 deletions, 0 `sorry`) — read against: no statement changes shape; every proof is §M2's case table; every hypothesis the plan calls load-bearing is used — surprised: no; the only statement-line changes are three `:= by` → `:=` (term mode); `not_forces_of_fanGap` uses `hne` (through `repaintAt_apply_of_ne … hne.symm`) and `h.1` (`γ ≠ C (f u)`) in the `C (f u) = C (f u')` branch and `C.comap f` in the other; `not_separated_of_sharedGap` builds `IsIndepSet {u, u'}` from `hadj` via `Set.pairwise_pair` and closes on `γ ≠ γ`; `PairwiseFusable.separated_iff_adj` is `not_separated_of_fusable Hom.id` plus `Separated.of_adj`; `three_le_arityFloor_of_forces_eq_of_separated_adj` mirrors `ResidueObstruction.lean:185` with `hs`/`hf` in place of the coincidence/aperiodicity iffs; `unitQuadrance_exists_hom_to_base` is `rotHom (d₁, −d₂) ∘ translate (−v)` with `σ v` by `neg_add_cancel` and `σ w` by `linear_combination`/`ring`; `exists_fanGap_iff_not_coverAtLeast` derives `2 ≤ k` from the gap and counts `insert γ (insert (C v) cover)`, ~50 lines against §M2's "~25"
- K1's commit `d5979f8` (18:08), its negative-control account — read against: §M2's list (delete `hne`; drop `γ ≠ C v`; drop `hadj`), each "the proof breaks" — surprised: yes, in the good direction: K sharpened each to "the weakened STATEMENT is false", refuted by a model — `not_forces_of_fanGap` without `u ≠ u'` at one vertex, no edges, two colours (`Forces u u` is trivially true); `FanGap` without `γ ≠ C v` at two vertices, no edges, one colour (every 1-colouring agrees, so the "gap" 0 = C v frees nothing); `not_separated_of_sharedGap` without `¬ Adj` at `K₂` with three colours (an edge is separated by every proper colouring). All three models check by inspection. The models are not in the file as `example`s (the diff adds none), so the commit message is their only record — to ask K where they were run
- `Instances/FanGap11.lean` closed by K (working tree, 18:09; 7 leaves → 0) — read against: D0.5's forms with M60's hypotheses, the two table `decide`s, `pairwiseFusable` by adjacency case, the corrupt red — surprised: no on the six; yes on the red, as card 1 predicted: `finitePlane11_fanGap`, `_not_fanGap_zero`, `_doubleGap_proper`, `heule510_residue_zero_eq_475` are `decide +kernel`; `_sharedGap` is two `FanGap` `decide`s (no global `Decidable (SharedGap …)` minted — a deliberate refusal of a global speech act, noted in a comment); `_pairwiseFusable` is `by_cases` adjacency → `unitQuadrance_fusable_of_sharedGap_base` / `fusable_of_not_separated` through `finitePlane11_separated_iff`, exactly §M2; `_sharedGap_corrupt_refused` is `hSG.1.1 h00.symm` — the definition's first conjunct, no `decide`, and its docstring's "M04 corrupted-table control" overclaims; correction sent to K with the fix (re-docstring; run the one-entry mutation once and name it)
- K2 at 11, commit `7cf33e5` (its message) — read against: the two live table controls run once, each `decide` seen red with its faithful partner green — surprised: no; entry `(0,1)` 2 → 0 refused by the PROPERNESS `decide`; entry `(0,0)` 0 → 4 keeps properness and both `FanGap` `decide`s refuse (at `(0,0)` by `γ ≠ C v`, at `(1,0)` because `(0,0)` is its neighbour), `#guard` first; logs under `build/fs38-k/controls/`; run before my message asked for them
- K2 at 19, commit `795fc7b` (message and `Instances/FanGap19.lean`) — read against: the corrected witness `(0,4)`, the red at `(0,4)` with colour 0 present, `finitePlane19_slack` unchanged, properness DERIVED not decided — surprised: no (after my own retraction above); the docstring now states `y − x`, names classes 4 and 10, and records that `(4,0)` has no gap
- `FanGap.lean:377-413`, the three refutation theorems (`not_forces_of_fanGap_needs_ne`, `fanGap_needs_ne_own_colour`, `not_separated_of_sharedGap_needs_nonadjacent`) and their faithful partner — read against: each `bad` hypothesis is the original statement minus exactly one hypothesis, transcribed faithfully; each model is the commit's; the partner passes on the same shape — surprised: no; (1) drops `hne`: `⊥` on `Unit`, `C ≡ 0 : Fin 2`, `γ = 1`, `Forces () ()` by `rfl`; (2) keeps only `FanGap`'s open half: `⊥` on `Fin 2`, one colour, `Forces` by `Subsingleton`; (3) drops `hadj`: `K₂` at three colours, `γ = 2`, `Separated.of_adj`. They conclude `False`, so `vacuity.sh`'s `refutations-skipped` moves 242 → 245 — flagged to K for the gate report
- K's gate report (message 18:27) and §R1 (`a81a9ca`, `55600fb`, `f42f11f`) — read against: `#print axioms` = the standard three on every public theorem; the count movements reported; no theorem overclaimed in §R1 — surprised: yes, twice, neither about K1/K2: (i) `axioms.sh` OK, 68 FS-38 records, 67 on the standard three and `unitQuadrance_exists_hom_to_base` choice-free (`[propext, Quot.sound]`), totals 846 → 914 clean (stale count flagged for phase C, not edited); `lake lint` OK; build 170/170 in 3m36s; (ii) **`vacuity.sh` is RED** on `twoAdicFive_forces_delta` and `twoAdicFive_forces_of_ker` — K3's `sorry` leaves in `Instances/TwoAdicFive.lean`, unchanged since the skeleton `02d1fef`, so the gate would have read red at the tip `31702dc` (an inference; nobody ran it there — §S10 reports only the build), and three modeling-pass commits went in on top of it. K declined to add the two sites to `scripts/vacuity-baseline.txt` ("it only ever SHRINKS"; another phase's inhabitant), which is right; the counts moved `declarations 6261 → 6405`, `refutations-skipped 242 → 262` (three are K's controls, the rest K3's skeleton), `sites 220 → 259`, `witnessed 12 → 14`, `generic 203 → 238`, `unknown 2 → 4`. §R1 read line by line against the source: no overclaim on any theorem; two trust-word softenings requested and taken in `f42f11f` ("was already red" → "would read red … an inference"; the 2-adic `K₄` no-gap fact marked [hand until K3])
- `data/fs38/tower-p2-k4-m6.json` re-derived here (`|S₆| = 96` from my norm form; `s·S₆ = S₆` for every `s`, `conj(S₆) = S₆`; T's index order) — read against: the forced set `{depth ≥ 4} ∖ 0` = 15 in orbits (3, 6, 6) under `⟨S₆, conj⟩`; T's 384 `S` positions = the SET `S₆ + 𝔓⁴`; T's `R` positions = `{depth ≥ 4} ∖ 0` — surprised: no; all three hold exactly (symmetric difference 0; 96 edges + 288 non-edges among the 384; orbit representatives `(0,0,0,4)` at depth 5 and `(0,4,0,0)`, `(0,4,4,0)` at depth 4, T's own). So at level 6 the plane's whole four-colour arity-2 structure is one statement: forced = `𝔓⁴` (solver word), virtual edges = `S₆ + 𝔓⁴` (⊆ derived from the forced set and adjacency; ⊇ measured as set equality). Handed to phase D as verified input
- Implementer T's control design (message, 18:22) — read against: the six questions of my opener each answered per subcommand with a reachable uninformative outcome, a two-sided plant, no refusal as fact, an independent verifier against the graph as built, 576 and the counts, §S1 units — surprised: yes, three times, twice in the good direction: (i) a control I did not name — the genuine ring `R = (ℤ/16)[ω,π]/(π² − 2π − 2)` built by relations, the ideal `(π^m)` as an explicit set EQUAL to the claimed lattice at every `m = 1..8`, `z·z̄` with vanishing ω-components matching the closed form on 2,000 random `z`, truncated multiplication agreeing on 3,000 — a test of [hand 1]'s LATTICE claim, which the tuned-to count cannot see, replacing the pilot coincidence (the pilot's code died with the planner's scratchpad, so §S3's named control is unrunnable as written); (ii) `forced` has no internal positive below level 5 — T says so plainly and supplies an external one (the diamond at three colours forces its apexes, at four frees them, same ask function) plus the level-6 prototype population (15 refused of 4,095 = `|𝔓⁴/𝔓⁶| − 1` exactly, 4,080 verified models), so P-A2's two outcomes are both seen in one run; (iii) a correction to the brief: at level 8 (65,536 vertices, 12.6 M edges) "all differences" becomes one representative per automorphism orbit with the rest DERIVED — accepted on three written conditions (generators verified as automorphisms, orbit sizes summed to 65,535, orbit-transferred refusals still "refused (solver, untrusted)"). Not surprising and worth keeping: second ENGINE and second ENCODING on every refusal; palette re-asks and orbit consistency as HALTs; the depth formula `min(2·v₂(A), 1 + 2·v₂(B))` re-derived here (2 is a uniformiser of `ℤ₂[ω]`, parities differ); the counts match my pre-registration exactly. Missing and asked for: `recolour` controls (my 132 / 380 / 363 expectations sent); the `tables` five-versus-2-or-3 to be said which
- `data/fs38/README.md` (18:38) and `data/fs38/ckpt/` during level 7 — read against: one row per file with what it licenses and its trust word; the resume command; a "not recorded here" list; a checkpoint present while a level is in flight — surprised: no on the shape (every row carries its trust word; the lrat row says "generated, not checked"; the count is disowned as a control; `ckpt/README` and a live `forced-p2-k4-m7.json` checkpoint of 213 KB exist; "Not recorded here" names level 8, the CNF, every kernel claim, and [hand 2]); yes on one row: `doublegap-p11-k5.json` cites `DoubleSlack` and `separated_iff_adj_of_doubleSlack`, the skeleton's names that §M1 removed — the shipped chain is `finitePlane11_sharedGap` → `unitQuadrance_fusable_of_sharedGap_base` → `finitePlane11_pairwiseFusable` → `PairwiseFusable.separated_iff_adj`; sent to T. Also noted: the README already carries my `E`/`S` legend, ahead of the level ≤ 6 JSONs that still mark edges `S`
- `data/fs38/p4-tables.json` (18:48) — read against: the committed five proper and covering; P-A5's 2 or 3; P-A4's depth-2 period at level 4 — surprised: no; period groups `[64, 32, 64, 32, 8]` recomputed here identically, common `{0}`; a 2-cover found (committed table 5 + one new table, both shipped, both verified, intersection `{0}`), no pair of the five covering; the aperiodicity refusal with its reachable SAT sibling ("none of TWO of the three")
- `data/fs38/recolour-p11-level2.json` (18:50) — read against: my pre-registered 132 / 0 improper / 363 / the lift separated from 120 fibre-mates; present-colour repaints improper; the own-colour repaint named as uninformative — surprised: no; every number met exactly (`gapped_vertices_are_exactly_the_lifted_base_gaps: true`); controls 55 / 22 / 55 improper edges for colours 0 / 3 / 4, bounded above, and the own-colour no-op recorded as "the UNINFORMATIVE outcome, stated so nobody counts it as a control" — the plan's rule applied by the implementer unprompted. Stub P2's record instance exists: level 2 at 11 is not 1-continuous, by exact arithmetic
- `data/fs38/doublegap-p11-k5.json`, `doublegap-p19-k5.json` (18:51) — read against: a verified shared-gap table at each prime; the committed 11 table re-verified with a planted red; the single-gap census at 19 beside it — surprised: no; at 11 the fresh table (colour 4 absent on the 22) differs from the committed one (`matches_this_run: false` — solver models are not reproducible, as the README says), the committed table re-verified proper with 10 gapped pairs (my count), the one-entry flip breaking properness and keeping the gap (fired); at 19 colour 4 absent on the 40-vertex closed union, verified; at 19 the base edge has **0** common neighbours against 2 at 11 — the common neighbours sit at `x = 1/2, y² = 3/4`, so this is exactly whether 3 is a square mod `p` (G44's `ω = 3` dichotomy), named so it is not mistaken for a surprise. Both `claim_scope`s still say "`DoubleSlack`'s witness" — the stale skeleton name already sent to T for the README
- `data/fs38/lrat/` (18:49): `manifest.json`, `p5-plus-edge-edges.json`, `p5-plus-edge.lrat` — read against: the level-5 refusal of `P₅ + (0, δ)`, `δ = (4,0,0,0)` at depth 4, its ω-orbit, the pins a verified clique, the edge-free formula SAT, the proof ending in the empty clause, the status "generated, not checked" — surprised: no; index of `δ` = 512 and its ω-orbit {512, 64, 576} check against the index order by hand; pins `[0,0], [16,1], [144,2]` verified pairwise adjacent ("without this a refusal could be a statement about the pins"); cadical exit 20 with the edge, 10 without; 1,339 LRAT lines (the planner priced 4,068 — a different run), last line the empty clause; SHA-256s for CNF (uncommitted, regenerable), LRAT and edge list. Consuming it is K3's
- `data/fs38/gap-p19-k5.json` (18:51, 240 s) — read against: the census 38 with `(0,4)` first; a SAT gap ask verified; every control with a reachable outcome or marked as not one — surprised: no; census exactly K's two classes (own colours 4 and 3, gap 1 throughout); the fresh ask found a gap (colour 1) verified on all 3,610 edges under a 2 M-conflict budget; the 4-colouring refusal (with a triangle through the origin pinned, "without the pins the ask did not return in ten minutes at 19") recorded as **informational**, load-bearing only where a refusal is recorded; the "three colours absent at once" ask recorded as `unknown` and **"informational, NOT a control"** with the reason — it refuses cheaply only when the circle induces an edge, `ω = 3` iff 3 is a square mod `p` (`[Krebs2022]`), 24 directed edges inside the circle at 11 and zero at 19 — the same mechanism I had named for the 0-versus-2 common neighbours, found independently by T
- `plans/FS38-tower-records.md` (18:57, 12.6 KB) — read against: every number in its table equal to the JSON's; each prediction scored with its population and trust word; incidents named — surprised: yes, twice: (i) the predictions table carries unfilled `<!--PA1-->`…`<!--VE-->` cells and says "met" for P-A1 and P-A3, registered over `m ≤ 8`, with only levels 1–6 recorded (sent to T: write the level range); the virtual-edge row misdates my registration (it was before level 6 was read, derived from level 5 — the 384 is the out-of-sample hit); (ii) **incident 1: T ran `pkill -f fs38_tower`**, which matched its own shell and killed the level-7 run at 11,000 of 16,383 asks — the checkpoint resumed it at 11,001 (the resume path's first real exercise; the aggregate model hash now covers only post-resume models, recorded) — **and the same command killed this pass's tree-watch monitor**, whose command line named `tools/fs38_tower.py` for a line count: it died with an abnormal exit between 18:39:51 and 18:40:36, the window of T's kill (timing-consistent, not measured; sent to T to confirm from its shell history). The rule's cross-agent form: `pkill -f` reaches every process on the box whose arguments contain the string, including processes the killer does not know exist. The plant column matches the JSONs (16/48, 32/96), so the message slip did not reach the document. Incidents 2 (a record written under a superseded control rule, re-run) and 3 (a hardcoded "the required control fired" print, now reading the control's fields) are T's own catches; T's diamond control first asked the wrong pair and went red, which is how it was found
- `data/fs38/tower-p2-k4-m7.json` (19:02, resumed after T's kill at ask 11,000) — read against: 63 refused = `4³ − 1` at depths 4/5/6 = 48/12/3; 16,320 verified free; no gap with the plant at 64/192; P-P1 at 1536 as a set — surprised: no on every verdict (the `R` positions equal `{depth ≥ 4} ∖ 0` and the `E + S` positions equal `S₇ + 𝔓⁴` under my own norm form, symmetric difference 0; second engine and encoding agree on all 63; orbit-consistent over 128 orbits); yes on two fields carrying the wrong quantity: `seconds: 43.3` and `peak_gb: 1.21` are the post-resume segment of a ~25-minute run (T's whole-run estimate: 11,000 + 5,250 + 133 asks in three segments), and the JSON had no resume provenance. Sent to T; T chose to **re-run level 7 clean after level 8** rather than label the number ("a number that needs a caveat to be read correctly is worse value than twenty minutes"), added a `timing` block to every level (`seconds_this_process`, `resumed_from_ask`, checkpoint path, whether the clock covers the whole level), and replaced the pinned encoding by one asking each of the 12 ordered colour pairs separately, so the refusals rest on no palette argument even in principle
- Phase D's status (message 19:12; nothing on disk yet) — read against: D-1's period census; D-2's propagation; my three inputs consistent — surprised: yes, in the good direction, three times: (i) D built the tower from the ring axioms independently of `tools/` — `P₂ = K₄ □ K₄` with its 8 cliques, `H(s̄) = 𝔽₂·(s̄ mod 𝔓)` at levels 2–6, `S_m → S_{m−1}` onto with fibres of 2, circle lists coinciding with the record at 4 and 5 — the **third construction** of the object and the replacement for §S3's unrunnable pilot coincidence; clique number 4 at level 2 and exactly 3 at every level ≥ 3; (ii) **D-1 corrects §S5's conjectured shape**: the unavoidable periods are not a coset `𝔓^{m−2}·units` but μ₃-TRIPLES `2x·{1, ω, ω²}` — at level 3 every colouring has a period in `{2, 2ω, 2ω²}`, at level 4 one in each of `{2u}`, `{2√3u}`, `{2πu}`, with no single element or pair unavoidable (verified colourings), from complete enumerations of 576 and 4,896 colourings; (iii) **D-2's conditional claim**: with `(L)_m` := "every 4-colouring of `P_m` has, for every `x`, one of `2x, 2xω, 2xω²` as a period", `(L)_M` on `x ∈ π^{M−5}(1 + πO)` implies every 4-colouring of `P_M` factors through `P_{M−1}` (M ≥ 5) — the sketch's one non-obvious step (the forced cube root of unity is the same `u₀`) checked here by hand: distinct cube roots of unity differ by a unit, and the alternative forces `u ≡ 2u₀ ≡ 0 (mod 𝔓)`. Placed for D: the claim's CONCLUSION is P-A2's top-depth row, already measured at 5–7 (`Forces(0, δ)` on a Cayley graph is "δ is a common period"), so its value is the derivation from `(L)`; and with `(L)`, P-P1 rests on P₄'s freeness plus the 231 level-4 identifying models and no refusal. `(L)` for additive colourings is two lines; for all colourings it is being tested at 4, 5, 6 — measured, not derived, if it holds; the forcing lives in no proper sub-Cayley graph at level 5 (18 checked, all free), so any proof is global. D-4: no 5-colouring of `UD(𝔽₁₁,2)` gaps every vertex (UNSAT; 6-colour positive SAT, 4-colour negative UNSAT); the maximum simultaneously gapped count is being computed
- `data/fs38/tower-p2-k4-m8.json` (19:16, uncommitted; 65,536 vertices, degree 384, 12,582,912 edges; 255 representatives asked, every difference decided by orbits) — read against: the three set equalities I registered — refused = `𝔓⁴ ∖ 0` (255), virtual edges = `S₈ + 𝔓⁴` (6,144), the representatives' orbits a partition of 65,535 with the refused ones covering exactly the refused set — plus the plant, the second opinion, and the timing provenance — surprised: no on every verdict: `R` positions = `{depth ≥ 4} ∖ 0` under my own norm form; `E + S` = 384 + 5,760 = 6,144 = `S₈ + 𝔓⁴`, symmetric difference 0 (P-P1's third out-of-sample hit); 255 orbit sizes sum to 65,535, the 15 refused representatives' to 255, at depths 4/5/6/7 = 192/48/12/3; plant 128/384 fired; every refusal's second opinion is the edge encoding with a selector on the second engine — no pinning, no palette argument — and the palette re-asks are labelled "a HALT, not a measurement"; the `timing` block says plainly the clock (424.8 s) and peak (9.15 GB) cover only the asks after a resume at ask 250. Level 7 is being re-run clean and levels 1–6 regenerated under the final code (T, 19:45)
- T's orbit-route validation (message 19:45; `data/fs38/README.md` point 4) — read against: the licence for level 8 being an argument (automorphisms fixing 0) rather than a measurement — surprised: yes, in the good direction: T ran `forced --orbits` at levels 3, 4, 5, 6 against the committed all-differences records and compared the verdict STRINGS position by position — 7/15/31/63 representatives against 63/255/1,023/4,095 individual asks — identical in every position for forcedness and separation alike. The measurement says the whole verdict table produced by representatives IS the table produced by asking everything, which is stronger than the argument it replaces. T's own words: "the control I nearly shipped level 8 without"
- T's second-opinion redesign (19:45) — read against: a cost estimate carrying its population — surprised: no, and the lesson is the record's own: the colour-pair encoding was 180 UNSAT-direction solves at level 8 (~30 s each, an hour and a half for one level), discovered at ask 250 of 255; replaced by one selector-guarded edge solve per refusal, the colour-pair sweep kept only where free (n ≤ 20,000), both recorded per refusal, agreeing where both ran (level 5, 3 of 3). T names it the third time this phase that a cost was a right measurement of the wrong population ("a successful walk is the expensive walk")
- T's commits `0124cfa`, `963ad95`, `754c1d3`, `d4f0e6f` (levels 1–7, the cover, the LRAT, both shared gaps, the repaint, the report) — read against: the same files I read in the tree — surprised: no; the regenerated levels 1–7 and level 8 are uncommitted at this writing
- Phase D's close (message 20:04): **the `(L)` route WITHDRAWN and replaced by a derivation** — read against: my expectation that `(L)` would hold at 4–6 and stall as a derivation — surprised: yes — on both halves, and this is the phase's largest finding. `(L)` is **false as a law** (verified counterexamples at level 4 at `x ≡ 1 + πω, 1 + πω²`, and 8 of 21 triples at level 5), and at the `x` the induction needed it was **equivalent to the forcing itself** — circular. My hand check of the propagation step had validated a step whose hypothesis was the conclusion; the check was right and the route was not, which is the failure my own card 1 was written to catch and did not. The replacement is classical (G46): **Hoffman's ratio bound with its equality case.** On a `d`-regular graph an independent set has `|A| ≤ n(−λ_min)/(d − λ_min)`; when `λ_min = −d/(k−1)` ("`k`-tight") that is exactly `n/k`, so every `k`-colouring has all classes of size `n/k`, each indicator lies in `span(1, E_min)`, hence **every colouring is periodic under `H_min = ∩ ker χ` over the minimising characters** — and **no colouring has a fan gap**, because repainting a gapped vertex would build an independent set of size `n/k + 1`. Checked here as stated: the equality case gives the period (a character is `H`-invariant iff `H ⊆ ker χ`), and the gap argument needs exactly the class sizes tightness supplies. Computed by D at levels 1–8: `λ_min(P_m) = −2^{m−1} = −d/3` (so the tower is 4-tight at every level), minimising characters 3, 9, 21, 45, 45, 45, 45, 45, common kernel `{0}` at levels ≤ 4 and **exactly `𝔓⁴/𝔓^m` at 5–8**, with a positive control (1,224 + 2,000 + 6 colourings whose class Fourier supports lie in `{1} ∪ E_min` and whose period group is the support's common kernel). Propagation derived for all `m` (the level map's fibres of size 2 double `d` and `λ`); the primitive-character bound plus an explicit ℤ₂ certificate (four units `u ≡ 1 (mod 𝔓)` whose `t − 1` vectors have elementary divisors 1, 2, 4, 4, so their span contains `4O = 𝔓⁴` and not `2O`) gives `M_m ⊇ 𝔓^{m−1}` for **every** `m ≥ 5` from a finite receipt — so `H_min = 𝔓⁴/𝔓^m` and the theorem is **for all `m ≥ 5`, not only the measured levels**: every 4-colouring of `P_m` is `𝔓⁴`-periodic, the tower's colouring space is `P₄`'s (1,179,936 colourings, census complete), `Forces ⟺ δ ∈ 𝔓⁴` and `Separated ⟺ δ ∈ S_m + 𝔓⁴` at every level. **So P-A2, P-A3 and P-P1 stop being solver records and become corollaries of a spectral identity, retrodicted by every level T measured.** D's item 4 reclassifies G54: `UD(𝔽₃,2)` at three colours is tight, the 2-adic level-one `K₄` is tight, and `UD(𝔽₇,2)` at four and `UD(𝔽₁₁,2)`, `UD(𝔽₁₉,2)`, `UD(𝔽₂₃,2)` at five are **slack** (`λ_min` = −4.49, −4.80, −7.61, −7.96 against the tight values −2.67, −3, −5, −6) — tight exactly where the record found forcing and no gap, slack exactly where it found gaps. **The classifier is Hoffman tightness, not gap-freedom**; "no gap ⟹ forcing" was never the statement. D-4: no 5-colouring of `UD(𝔽₁₁,2)` gaps every vertex (UNSAT, with its three controls); the maximum gapped count is a recorded stall
- `data/fs38/lrat/` after T's `0783ff2` — read against: T's report that the proof file is NOT committed and that the claim replacing it is checked — surprised: no, and the account is exact: `git ls-files` shows only `manifest.json` and `p5-plus-edge-edges.json`; `git check-ignore -v` confirms `.gitignore:14` (`*.lrat`) silently dropped the proof while the first README asserted it was there; the manifest now carries `lrat.committed = false` with `why_not_committed`, and the README and report say the same in their own words. The load-bearing substitute — byte-identical regeneration (same 55,729 bytes, same SHA-256, one thread, the manifest's seed), the determinism `scripts/regen-check.sh` already relies on — is the right replacement, and **row 64's failure is avoided in the one way that matters**: the artifact a reader re-checks is committed (edge list + checksums + flags + seed), where row 64's DRAT/LRAT lived in `/tmp` and are gone
- Phase D's `plans/FS38-derivation.md` (20:10, on disk, uncommitted) and its new prediction **P-D2** — read against: the 3-adic tower at three colours is tight at levels 1–4 with `H_min = 3·(ℤ/3^m)²` from level 2, D offering one SAT ask to score it — surprised: no, and **it needed no solver**: tightness is a character sum, so I computed `λ_min` and the minimisers' common kernel exactly (`build/fs38-poros/`, seconds, no solver) and **P-D2 is met out of sample at levels 1, 2 and 3** — `λ_min = −2, −6, −18` against `d = 4, 12, 36`, i.e. exactly `−d/2` at every level, four minimising characters throughout, and `H_min` equal to `3·(ℤ/3^m)²` element for element at `m = 2` (9 elements) and `m = 3` (81, one level deeper than D claimed). So every 3-colouring of `UD(ℤ/9, 2)` is 3-periodic **by the theorem**, and the ask D offered is unnecessary. My controls reproduce D's slack figures to six decimals (`λ_min = −4.493959` at 7, `−4.795755` at 11, against the tight values `−8/3` and `−3`), which is an independent confirmation of D's finite-plane table. Two readings worth carrying: the tightness classifier costs **seconds per (field, k)** on a laptop, so "which planes are tight" is a cheap sweep where FS-17 priced a desktop-day at one prime; and the 3-adic instance is plausibly the mechanism behind row 58's rhombus forcing at three colours over ℚ(√3) (`exists_forces_of_unit_drawing_three`) — a connection for phase C to state as a candidate, not a claim
- Phase D's second reply (20:20): Lemma 3's receipt re-verified on a second code path, two file corrections, and **P-D5** ("no prime plane above 3 can be tight at any colour count", registered *not* asserted because "bounding the degree does not by itself forbid a rational value") — read against: is the registered gap real, and is it closable — surprised: yes, in the good direction: **the gap closes elementarily in the range that decides everything, and the argument is already in the record as G44's own input.** Tightness at `k` colours needs `λ_min = −d/(k−1)` with `d = p ± 1`, and Weil gives `|λ_min| ≤ 2√p`, so tightness demands `(p+1)/(k−1) ≤ 2√p` — an explicit cutoff per colour count: `k = 3 ⟹ p ≤ 13`, `k = 4 ⟹ 31`, `k = 5 ⟹ 61`, `k = 6 ⟹ 97`, `k = 7 ⟹ 139` (computed here). Below the cutoffs I checked **every prime to 149 exhaustively** (`build/fs38-poros/`, character sums, seconds): `d/|λ_min|` is an integer at `p = 3` alone (`k = 3`), so **no prime plane above 3 is tight at any `k ≤ 7`** — which is the whole chromatic question, since `χ(ℝ²) ≤ 7`. No rationality or Galois-degree argument is needed for that range; D's degree bound is then a second, independent reason rather than the load-bearing one. **Scope correction to P-D5 as registered:** for unbounded `k` the claim is not settled by this — tightness needs `k − 1 ≈ √p/2`, so large `k` at large `p` is untouched, and "at any colour count" should read "at any `k ≤ 7`" (or carry D's degree argument for the rest). **And one caution on my own instrument:** the near-misses are the tell — `p = 31` reads `d/|λ_min| = 3.000044` (i.e. `k = 4.0000` to four decimals) and `p = 17` reads `2.0100`; the floating error on a sum of `d` unit-modulus terms is `~10⁻¹⁴`, ten orders below those margins, so the screen is decisive here, but a reader must be shown the margin rather than the rounded `k`, exactly as this record's own rule about a failing ratio displayed as `1×` demands
- Phase K3's two headlines (message 20:32; read in the source, `Instances/TwoAdicFour.lean:144`, `TwoAdicFive.lean:175,180`; all three modules 0 `sorry`, build in flight) — read against: §S10's statements, no hypothesis added or dropped, and the scope claim — surprised: no; `twoAdicFour_forces_iff {x y} : Forces (twoAdicPlane 4) 4 x y ↔ x = y` and `twoAdicFive_forces_iff {d} : Forces (twoAdicPlane 5) 4 0 d ↔ twoAdicLevelMap 4 d = 0` are §S10's statements verbatim, with `twoAdicFive_forces_iff'` the pair form through `forces_iff_forces_zero_sub`. **K3's own scope note is the right one and is the thing I would have insisted on**: nothing in the three modules is about depth, about `K`, or about any unit-distance graph — the level-5 theorem is about the kernel of K3's own level map. One refinement of what is `[hand]`: the kernel is *decided* as four explicit tuples (`twoAdicFive_ker_eq`, `TwoAdicFive.lean:50`), so what `[hand 1]` supplies is the NAME `𝔓⁴/𝔓⁵` for that set (and `[hand 2]` the drawing) — the four-element fact itself is kernel. Also settled: `twoAdicPlane_one_no_fanGap` is closed by `decide` over all 256 functions, so R1.2 (iv)'s "[hand until K3]" can be struck; the level-hom indexing is now the theorem `no_hom_twoAdicPlane_one_to_zero` rather than §M2's remark, minted because the natural control fires as a whnf timeout — "a red for an unnamed reason", which is this record's own rule applied without being asked; the pins are proved adjacent **from the edge list in the kernel** (`twoAdicFiveTriangle`) rather than taken from the manifest's `pins_are_a_clique`, which is the stronger arrangement; and the five level-4 tables were kept over my 2-cover on a measurement (§M2's reserve restatement through the 24-point circle literal: 71 s for the whole module against 2 min 08 s for one table stated over `Adj`, so the 2-cover would buy ~33 s and cost one new untrusted literal) — the right call, and the reason the count stopped mattering
- T's prototype numbers (`build/fs38-t/`, uncommitted, "no solver claim") — read against: nothing recorded — surprised: no; they are a prior for the records, not the records; the level-6 reading (forced set = depth ≥ 4 exactly) is noted below as prototype-consistent with P-A2 and P-A6, unscored

## The hunch ledger — carried from the morning, with this pass's entries

hunch: forcing-lives-at-a-level-of-the-prime
  claim: every k-colouring of a deep-enough chunk of a 𝔭-sealed plane agrees with a colouring of P_m for the least m at which P_m's k-colourings are all constant on 𝔭^{m'}-cosets; the four-colour forcing of K-fabric at depth 6 is the instance at 𝔭 ∣ 2
  basis: measured
  falsifier: the 2-adic tower P_m over K(i) at four colours admitting, at every m ≤ 8, a 4-colouring separating some pair of depth 6
  registered: 2026-09-13
  status: open, weakened (by: the pilot — the tower forces depth 4 from level 5 where the fabric is FREE at depth 4, `data/m53/rigidity-dial-it4.json` 16/3: 0 of 2,145; "deep enough" is an escape clause until a K-fabric forces depth 4; T's `forced` records at all differences are the next reading)

hunch: the-arena-null-is-thinness
  claim: ρ₆₃ and the 1581 read zero at arity 2 because both are near-critical, and a compulsion at five colours needs density
  basis: analogy
  falsifier: a dense 5-colourable object in a 6-open field that still reads zero over a complete pair sweep
  registered: 2026-09-13
  status: open, scope narrowed (by: D0.5 — on sealed objects the zero is a theorem once K2 closes; the hunch speaks only of 6-open objects)

hunch: the-bridge-is-classical-and-unstated
  claim: χ(ℝ²) = sup_F χ(F²) over real number fields, by de Bruijn–Erdős plus a real-algebraic drawing lemma
  basis: prior
  falsifier: a gap in the transfer argument found when it is written for the kernel
  registered: 2026-09-13
  status: open (FS-39, untouched by this milestone)

hunch: K-fabric-can-force-depth-4
  claim: some finite unit-distance graph in K² forces a four-colour pair at distance 4/3, 4, 4/√3 or 4√3 (depth 4), as the tower permits from level 5
  basis: analogy
  falsifier: a derivation that every 4-colouring of every finite K² graph separates every depth-4 pair
  registered: 2026-09-13
  status: open (phase D's question; nothing in K1–K2 or T decides it)

hunch: the-tower-is-the-additive-yardstick-at-depth-4
  claim: for m ≥ 5 the forced set of P_m at four colours is exactly {depth ≥ 4} = F_add, the additive family's forced set on K-fabric
  basis: derived
  falsifier: a level m ≤ 8 whose forced set differs from {depth ≥ 4} — a free depth-4 difference or a forced depth-3 one; or a non-additive 4-colouring of U that factors through some P_m
  registered: 2026-09-13
  status: open (this is §S3's P-A6; T's all-differences `forced` records at levels 5–8 score it)

hunch: no-gap-at-level-one-implies-forcing-somewhere
  claim: for (𝔭, k) whose level-one plane's k-colourings have no gap at any vertex, some finite unit-distance graph over the field forces a k-colour pair
  basis: measured
  falsifier: a (𝔭, k) with no gap at level one and a proof that no fabric forces
  registered: 2026-09-13
  status: killed (by: D's tightness classification, 20:04 — the claim named the wrong variable): the classifier is **Hoffman tightness**, not gap-freedom. Tight (λ_min = −d/(k−1)) ⟹ every class has size n/k ⟹ no fan gap AND every colouring periodic under H_min, both theorems from the ratio bound's equality case; slack ⟹ the bound permits a gap and says nothing. Tight exactly where the record found forcing and no gap (the prime above 2 at four colours, 3 at three), slack exactly where it found gaps (7 at four; 11, 19, 23 at five). So "no gap ⟹ forcing" was never the statement — "tight ⟹ no gap ∧ forced on H_min" is — and the open question becomes which (field, k) are tight

hunch: UD-F83-is-exactly-six-chromatic
  claim: UD(𝔽₈₃, 2) is 6-colourable, hence exactly 6-chromatic (spectral floor 6), so χ(K(√7)²) ≤ 6
  basis: prior
  falsifier: a refusal of six colours at 83, or α(UD(𝔽₈₃,2)) < 1,149 certified
  registered: 2026-09-13
  status: open (§S8 decision 12: surfaced to the product owner, default not run; not this phase's)

hunch: the-corrupt-red-tests-the-definition-not-the-table
  claim: `finitePlane11_sharedGap_corrupt_refused` closes from `SharedGap`'s first conjunct alone (`γ ≠ C v` at `(0,0)`), so it exercises no `decide`; the `decide`-testing control is the one-entry mutation of §M2, which must be run separately
  basis: measured
  falsifier: K's closing proof of the red using the table `decide` (a proof that needs the 22-lookup absence or the properness `decide` to refuse)
  registered: 2026-09-13
  status: confirmed (by: K's closing proof in the working tree at 18:09, `rintro ⟨C, -, h00, hSG⟩; exact hSG.1.1 h00.symm` — the first conjunct alone, no `decide`; the measurement that suggested it was `check_tables.py`, the confirmation is the proof itself, read at its address)

hunch: the-plan-lists-no-planted-gap-control-for-T
  claim: §S6's T row omits the planted-gap control at 2 that §S3's P-A3 row demands, and names no positive control for `forced` at level 5, so an implementer building from §S6 alone ships a `gap` subcommand whose only outcome on the 2-adic object is UNSAT and a `forced` subcommand never seen to fire on a known positive
  basis: read
  falsifier: T's control design naming both controls before its first real run
  registered: 2026-09-13
  status: killed in its second clause (by: T's control design of 18:22, which names the planted-gap control with a two-sided bound and an external `forced` positive — after my opener asked for both, so whether §S6 alone would have produced them is not readable; the first clause, that §S6's T row omits them, stands as a reading of the text and is a correction for phase C to fold into §S6)

hunch: level-6-forced-set-is-exactly-depth-4
  claim: at level 6 the forced set of P₆ at four colours is exactly the 15 nonzero elements of 𝔓⁴/𝔓⁶, i.e. {depth ≥ 4} (P-A2 and P-A6 at m = 6)
  basis: measured
  falsifier: T's recorded `forced` run at level 6 (all 4,095 differences, second engine and encoding on the 15 refusals, 4,080 models verified against every edge) reading anything but 15 refused, all at depth ≥ 4
  registered: 2026-09-13
  status: open (by: T's prototype at 18:22, uncommitted, one engine — a prior, not a record; confirmed only by the record run under the controls)

hunch: the-tower-stabilises-at-level-4
  claim: every 4-colouring of P_M for M ≥ 5 is pulled back from a 4-colouring of P₄, so the tower's colouring space is finite (P₄'s), the forced set at every level ≥ 5 is 𝔓⁴, and the virtual edges are S_M + 𝔓⁴ — D's D-2 route, conditional on (L)_M for x ∈ π^{M−5}(1 + πO)
  basis: derived
  falsifier: a verified 4-colouring of some P_M, M ≥ 5, that is not constant on 𝔓⁴-cosets — equivalently a verified model separating 0 from a depth-≥-4 difference (P-A2's refusals say none exists at 5–7, on the solver's word)
  registered: 2026-09-13
  status: CONFIRMED BY DERIVATION, by a different mechanism than the one registered (D, 20:04): not the (L) induction — which is dead — but Hoffman tightness, λ_min(P_m) = −d/3 at every level with the minimising characters' common kernel exactly 𝔓⁴/𝔓^m for m ≥ 5, propagation derived for all m from the level map's fibres of size 2 and an explicit ℤ₂ certificate for M ⊇ 𝔓⁴. The claim holds for EVERY m ≥ 5, not only the measured levels; the tower's colouring space is P₄'s (1,179,936 colourings)

hunch: L-holds-for-every-four-colouring
  claim: for every level m and every 4-colouring C of P_m and every x ∈ O, one of 2x, 2xω, 2xω² is a period of C (D's (L)); for additive colourings it is two lines (φ(2xu) ∈ 2G and 2x(1 + ω + ω²) = 0)
  basis: derived
  falsifier: a verified 4-colouring of some P_m with none of 2x, 2xω, 2xω² as a period for some x — decisive for the stabilisation route only when x lies in π^{m−5}(1 + πO)
  registered: 2026-09-13
  status: killed (by: D's verified counterexamples, 20:04 — level 4 at x ≡ 1 + πω and 1 + πω² (mod 𝔓²), and 8 of 21 triples at level 5; the falsifier fired inside the range the induction needed, and there the law was equivalent to the forcing it was invoked to prove, so the route was circular. Kept with its refutation: what it wrongly claimed was that a μ₃-triple period is unavoidable for every colouring and every x — true for additive colourings, false in general. My hand check of the propagation step was sound and validated a step whose hypothesis was its conclusion; card 1's "both outcomes readable" clause asked for the needed range to be recorded, which is what made the circularity visible when the test ran)

hunch: no-prime-plane-above-3-is-tight
  claim: for every prime p > 3 and every k ≤ 7, UD(𝔽_p,2) is NOT Hoffman-tight at k colours — so the forcing half of the tightness dichotomy is empty at every usable prime above 3, and the gaps at 7, 11, 19, 23, 83 are the generic case rather than small-prime accidents
  basis: derived
  falsifier: a prime p > 3 and a k ≤ 7 with λ_min(UD(𝔽_p,2)) = −d/(k−1) exactly
  registered: 2026-09-13
  status: confirmed (by: derivation — Weil's |λ_min| ≤ 2√p forces (p+1)/(k−1) ≤ 2√p, giving the cutoffs p ≤ 13/31/61/97/139 for k = 3/4/5/6/7, plus an exhaustive character-sum check of every prime to 149 in which d/|λ_min| is integral only at p = 3; D's registered P-D5 is this statement with "any colour count" for "k ≤ 7", and its Galois-degree argument is an independent second reason)

## Pre-registered expectations for T's artifacts (written before any T number existed)

Computed in `build/fs38-poros/level_counts.py` and a level-2 pullback script (Python, exact, no `tools/` import), so
T's numbers are read against something T did not produce:

| artifact | expectation | basis |
|---|---|---|
| `build` at 2, levels 1–7 | `\|S_m\| = 3, 6, 12, 24, 48, 96, 192`; level 1 is `K₄` (every nonzero element on the circle); level 2 has 16 vertices, degree 6, 48 edges, **no** circle element in the fibre over level 1 | the §S3 norm form, enumerated here |
| level 2 at 2, four colours | exactly **576** proper 4-colourings | backtracking enumeration here (and the Latin-square count) |
| `build` at 11 / 19, level 2 | `\|S_2\| = 132` at 11 and `380` at 19 — `p · \|S_1\|`; `S_2 → S_1` onto with uniform fibres | enumerated here |
| `recolour` at 11, level 2 | the pulled-back certified table is proper on `UD(ℤ/121, 2)` (0 improper) and has exactly **363** gapped vertices — `3 · 121`, the three base gaps `(2,4), (7,8), (9,6)` lifted, and no others, because `S_2 → S_1` is onto so `N(x̃)` maps onto `N(π x̃)` | enumerated here |
| `gap` at 11 (five colours) | SAT; a scan of the certified table finds exactly 3 gapped vertices | `check_tables.py` |
| `doublegap` at 11 | SAT with colour absent on all 22 of `N[(0,0)] ∪ N[(1,0)]`; the two share exactly 2 neighbours `(6,3), (6,8)` | `check_tables.py` |
| `gap` at 19 (five colours) | SAT; the quotient colouring has 38 gapped (vertex, colour) pairs | `check_tables.py` |

### A prediction of this pass, registered before the level-6 record was opened (18:29)

**P-P1 (Poros; basis: derived from T's level-5 record).** At level 5, `separated` reads 96 at depth 0 where the plane
has only 48 edges: 48 non-adjacent differences are virtual edges on the solver's word. Derivation: the three refused
differences `δ ∈ 𝔓⁴/𝔓⁵ ∖ 0` give `C(0) = C(δ)` in every 4-colouring; `δ ~ s + δ` for every circle point `s`, so
`C(s + δ) ≠ C(δ) = C(0)` — every `s + δ` is a virtual edge. The set `S₅ + 𝔓⁴` is the full preimage of `S₄` (24
classes × 4 lifts = 96 elements): 48 on the circle (edges) and 48 off it — exactly the 96 read. So, **for every level
`m ≥ 5`, if the forced set is `{depth ≥ 4}` (P-A2) then every element of `S_m + 𝔓⁴` — the preimage of `S₄`, of size
`24 · 4^{m−4}` — is a virtual edge: 96, 384, 1536, 6144 at m = 5, 6, 7, 8.** Two outcomes, both reachable and both
informative: *equal* — the plane's virtual edges are exactly "adjacent to a forced difference", a one-line theorem
once P-A2 is; *more* — there is a four-colour virtual edge at 2 that depth-4 forcing plus adjacency does not explain,
a compulsion the frame has no name for and phase D's first object. *Fewer* is impossible if P-A2 holds (a HALT: the
solver or the encoding is wrong). Falsifier of "equal": the level-6 record's `separated` total ≠ 384.

## The registered predictions, as scored so far

| id | prediction (§S3 / §S7) | what scores it | status at this writing |
|---|---|---|---|
| P-A1 | every level m ≤ 8, every depth-≤-3 difference separated by a verified 4-colouring | T's `forced` records (all differences, verified models) | **met at levels 1–7** (`data/fs38/tower-p2-k4-m{1..7}.json`, 18:24–19:02): every difference of depth ≤ 3 free with a model verified on every edge — 15/63/255 at levels 2–4 (all differences), 1,020 of 1,023 at 5, 4,080 of 4,095 at 6, 16,320 of 16,383 at 7; level 8 pending (by orbits) |
| P-A2 | from level 5, every depth-≥-4 difference forced (two solvers; level 5 kernel via K3) | T's `forced` records + a second solver; K3 later | **met at levels 5–7, solver word**: 3 refused at 5 (`𝔓⁴/𝔓⁵ ∖ 0`), 15 at 6 (12 at depth 4 in two orbits of 6, 3 at depth 5 in one orbit of 3), 63 at 7 (48/12/3 at depths 4/5/6), each on cadical + glucose4 + the second encoding (`P_m + edge` not 4-colourable) + the palette re-asks; orbit-consistent; kernel at 5 only via K3 |
| P-A3 | no fan gap at any level ≤ 8 (a theorem of K3 at ≤ 5; a solver consistency check above, with the planted control) | T's `gap` at 6–8 with the plant | **met at levels 1–7, solver word**; the plant fired at every level with `0 < deleted < degree` (1/3, 2/6, 4/12, 8/24, 16/48, 32/96, 64/192) and the model verified on the mutated arrays |
| P-A4 | every 4-colouring of P_m has a nonzero period at every m ≥ 2 (576 Latin squares at m = 2, all periodic) | T's `tables` / level-2 enumeration | **met at level 4 in its sharp form, solver word** (`data/fs38/p4-tables.json`, 18:48): a 4-colouring of P₄ periodic at NONE of the three depth-2 elements `2√3·ζ₃^j` is refused, with the reachable sibling (none of TWO of the three: SAT) fired — so every 4-colouring has one of those three as a period, §S0 item 3 as a record; level 2 by the 576 enumeration; levels 3 and 5–8 not asked |
| P-A5 | 2 or 3 tables suffice for P₄'s freeness | T's `tables` | **met at 2** (search result, an upper bound on the minimum): the committed five are all proper with period groups of sizes `[64, 32, 64, 32, 8]` — recomputed here, identical — meeting in `{0}`, so the list covers; **no pair of the five covers** (all ten pairs checked here), and the 2-cover is committed table 5 plus one new pool table, both shipped in the record with properness verified and trivial intersection, in the Lean literal's index order. `Instances/TwoAdicFour.lean`'s five are not wrong, only not minimal; shrinking is K3's call |
| P-A6 | forced set of P_m at four colours is exactly {depth ≥ 4} for m ≥ 5 | T's `forced` records | **met at levels 5–7, solver word** (the refused sets are exactly `𝔓⁴/𝔓^m ∖ 0`: 3, 15, 63 — the `R` positions recomputed here as the set `{depth ≥ 4} ∖ 0` at 6 and 7) |
| P-K1 | the shared-gap 121-entry table decides proper and doubly absent in the kernel; a corrupted table is refused | K2's two `decide`s and the one-entry mutation | **met** (`7cf33e5`: both `decide`s green; C4 refused by properness, C5 by both `FanGap` `decide`s) |
| **P-P1** (this pass) | virtual edges of P_m at m ≥ 5 are exactly `S_m + 𝔓⁴`, of size `24·4^{m−4}` | T's `separated` totals | **met as a SET at 5, 6, 7 and 8** — 96, **384**, **1536**, **6144** (registered 18:29 from level 5's count; the level-6 record opened 18:31; level 7 at 19:02; level 8 at 19:16, by orbits), each time the E + S positions equal to `S_m + 𝔓⁴` recomputed from my own norm form with symmetric difference 0; at m ≤ 4 the virtual edges are exactly the edges (6, 12, 24), consistent with no forcing there. **Scoring summary at the close of phase T:** P-A1 met at 1–8; P-A2 met at 5–8 (solver word, two engines, the second encoding without a palette argument; kernel at 5 only via K3); P-A3 met at 1–8 (plant fired at every level); P-A4 met at 2 (exhaustive) and 4 (the depth-2 triple, solver word), sharpened by D-1's μ₃-triples; P-A5 met at 2, inside its "2 or 3"; P-A6 met at 5–8; P-K1 met; P-P1 met at 5–8. Level 8's rows rest on the orbit derivation, validated position-by-position at 3–6 |

## Question cards

question: does-the-corrupt-red-fire-for-the-reason-its-docstring-names
  evidence: `Instances/FanGap11.lean:90-96` docstring "the M04 'corrupted table' control, on this table"; `build/fs38-poros/check_tables.py` output — the corrupted table has 0 improper edges of 726, `γ ≠ C v` fails at `(0,0)`, absence fails at `(1,0)`
  expected: a "corrupted table" red is refused by the table `decide` (M04's pattern: one entry changed, the checker refuses)
  ask: does K's proof of `finitePlane11_sharedGap_corrupt_refused` touch the table at all, or does it close from `SharedGap`'s first conjunct — and if the latter, is the one-entry mutation of §M2 run separately so the `decide` is seen to refuse once?
  if it closes from the first conjunct alone: rename or re-docstring the red as a control on the definition (`γ ≠ C v`), and run the one-entry mutation as the `decide` control, naming the entry and which `decide` refused
  if K's proof uses a `decide`: the docstring is right as it stands; record which `decide`
  answered by: Implementer K — one reply with the closing proof and the mutation's result
  cost: minutes
  hunch: the first conjunct alone — basis measured (the corrupted table is proper, so nothing else refuses it before `SharedGap`)
  falsifier: a closing proof that needs the 22-lookup absence or properness `decide`
  rank: 3
  fate: answered at 18:09 by K's proof — the first-conjunct branch; the fix (re-docstring as a definition red; run the one-entry mutation once and name the entry and the `decide`) sent to K, default stated

## The anomaly hunt's residue — what the results say that the frame did not expect

Four surprises survive verification, on three axes; the fourth is about the instruments.

1. **Object — and it is now derived, not conditional.** The tower is not a tower: **it stabilises at level 4**, by
   Hoffman tightness (D, 20:04; the `(L)` route that would have shown the same thing is dead and was circular). Every
   4-colouring of `P_m` for **every** `m ≥ 5` is `𝔓⁴`-periodic, so the colouring space is `P₄`'s (1,179,936
   colourings), `Forces ⟺ δ ∈ 𝔓⁴` and `Separated ⟺ δ ∈ S_m + 𝔓⁴` at every level, and T's levels 5–8 are
   retrodictions of a theorem rather than the evidence for one. Then K3's planned scope — the level-4 tables in the
   kernel plus the top-fibre refusal at level 5 — **is the whole 2-adic result, not a sample of it**, and the honest
   headline is "the local plane at 2 is four-colourable in exactly the ways `P₄` is, because the plane is
   Hoffman-tight at four colours". The question that replaces the tower's is *which (field, `k`) are tight*.
2. **Question.** The subplan asked one question of the tower — at which level do colourings become constant on
   cosets — and the records answer a two-sided one the frame had no word for: at four colours the plane's virtual
   edges are exactly "adjacent to a forced difference" (`S_m + 𝔓⁴`, met as a SET at 5, 6, 7 — P-P1). So at both
   sealing primes the plane's arity-2 structure is now completely described: at 11 with five colours it is trivial
   (slack and pairwise fusable, K2, kernel), at 2 with four colours it is "level-4-periodic" (forced = `𝔓⁴`, virtual
   = `S + 𝔓⁴`, solver word, derivation route in D-2). The frame's G54 stays one-directional; what was added is the
   virtual-edge half at 2.
3. **Product.** Three false or wrong statements in the plan and skeleton were caught this phase, each by a different
   instrument: `twoAdicLevelHom` at `m = 0` (the obligation pass, before implementation); `finitePlane19_fanGap` at
   `(4,0)` (K's `decide +kernel`, after two readers had endorsed it); §S5's conjectured period shape (D's complete
   enumeration). And the vacuity gate has been red since the skeleton commit `02d1fef` on two K3 sites, with three
   modeling-pass commits on top of it — no rule was broken (the gate is step 8), but the cheap half of the gate
   (`vacuity.sh`, seconds) could run at the skeleton commit and would have named the two sites a day earlier. A
   recommendation, not a finding.
4. **Instruments.** Four instrument lessons in one phase, each with its address in the inventory: a control that
   passes for both candidate readings discriminates neither (mine, the 19 functional); a plant that cannot fire on the
   quantity it is aimed at (T's deleted-term perturbations); `pkill -f` reaching a process of another agent (T's
   incident 1, my monitor); and a `seconds` field measuring the resumed segment of a killed run (T's level 7, now
   being re-run clean). None is new to `CLAUDE.md`; all four recurred inside one afternoon, which is the argument for
   the controls being mandatory rather than remembered.

## Question cards (continued)

question: is-L-true-for-non-additive-colourings
  evidence: D's message 19:12 — `(L)` is two lines for additive colourings; the D-2 induction needs `(L)_M` only at `x ∈ π^{M−5}(1 + πO)`; D-1's complete enumerations show the unavoidable periods are μ₃-triples; the forcing at level 5 lives in no proper sub-Cayley graph (18 checked); T's records show forced = `𝔓⁴ ∖ 0` at 5–7
  expected: `(L)` holds at levels 4, 5, 6 on the solver's word (no colouring refutes it), and stalls as a derivation for non-additive colourings
  ask: does every 4-colouring of `P_m` (m = 4, 5, 6) have, for every `x` in the range the induction needs, one of `2x, 2xω, 2xω²` as a period — and if a refuting colouring exists, is its `x` inside or outside that range?
  if it holds at 4–6: the stabilisation route is measured through level 6 and derived above it; the 2-adic headline becomes "forced = `𝔓⁴`, explained by `(L)`, which is proved for additive colourings and measured for all", and the stall "`(L)` for non-additive colourings" is phase D's recorded product and the next milestone's first question
  if a verified colouring refutes `(L)` inside the needed range: the route dies at that level; the colouring is a 4-colouring of `P_M` not pulled back from `P_{M−1}` — which would contradict P-A2's refusal at the top depth of that level, so one of the two instruments is wrong and the phase HALTS to find which
  if it refutes `(L)` only outside the needed range: the route survives with `(L)` weakened to the needed range; state the weakened law
  answered by: run — D's test, in flight at 19:12, "within the hour"
  cost: D's hour; no new instrument
  hunch: holds at 4–6 — basis derived (the conclusion is P-A2's measured top-depth row, and a refutation inside the range would contradict a refusal confirmed on two engines)
  falsifier: a verified colouring at some level with no period in `2x·μ₃` for an `x ∈ π^{m−5}(1 + πO)`
  rank: 1

question: does-K3-still-need-levels-above-five
  evidence: §S6 K3's scope (level-4 tables, the level-5 LRAT, the pullback iff); the stabilisation route (residue item 1); T's records at 6–8 as consistency checks; the vacuity gate red on K3's two sites since `02d1fef`
  expected: if the tower stabilises at level 4, K3's planned scope already IS the whole 2-adic result, and nothing at levels 6–8 needs the kernel
  ask: should phase C state the 2-adic result as "stabilises at level 4: `P₄` pairwise free (kernel), the top fibre forced at 5 (LRAT), every level above by `(L)`" — with levels 6–8 as solver-side consistency records — rather than as a per-level law?
  if yes: the record's 2-adic headline shrinks to one sentence with three trust words, and FS-38's sequel is `(L)` for non-additive colourings, not level 9
  if no (the product owner wants the per-level law stated): keep the table, but the trust word per level stays "solver, untrusted" above 5 and the sentence "the law is `P₄`'s" is still true
  answered by: human — the product owner, at the close
  cost: a decision; no run
  rank: 2
  note: rank 1 is the `(L)` card above (open, D's test); the answered card 1 of this record now sits at rank 3

## The recommendation (four parts, with its default)

**The choice.** Close K1/K2 as the milestone's kernel headline exactly as §R1 reads it (the three statements say what
§S2 claims; nothing added or dropped), and state the 2-adic side as **a theorem with a spectral mechanism**: the plane
`P_m` is Hoffman-tight at four colours at every level (`λ_min = −d/3`), so every colouring is `𝔓⁴`-periodic and none
has a fan gap, whence `Forces ⟺ δ ∈ 𝔓⁴` and `Separated ⟺ δ ∈ S_m + 𝔓⁴` for every `m ≥ 5` — with T's levels 5–8 as the
retrodiction and the level-4 census as the finite input. G54 is restated on the right variable: **tightness**, not
gap-freedom. Phase C carries the corrections below into the plan, the vacuity and axiom counts into `CLAUDE.md`, and
does not close green until K3 ships the `P₅` colouring inhabitant or declares the two sites.

**The alternative weighed.** State "the 2-adic law: forced exactly at depth ≥ 4 from level 5" as the second headline,
per level, on the solver's word — the brief's original shape with the morning's corrections, and what the records
alone would support.

**Why this one.** The per-level law is true on the records but is not the mechanism, and it is weaker in two ways that
matter: it is solver-word where the spectral statement is a theorem, and it is bounded by the levels measured where
the spectral statement covers every `m ≥ 5`. The tight/slack dichotomy also carries to the primes the record cares
about (2 and 3 tight, 7/11/19/23 slack) and hands FS-17 a computable question, which a per-level table does not.

**Confidence.** High on the kernel half (read line by line, every control reachable). High on the 2-adic shape now
that it is derived and retrodicts four measured levels — the one fact that would change it: an error in the
primitive-character step, whose finite receipt (four units, elementary divisors 1, 2, 4, 4) is the thing to re-check,
since everything for `m ≥ 5` rests on `M ⊇ 𝔓⁴` and on nothing else computed beyond level 8.

**The default.** If nobody acts: phase C writes the per-level table as the 2-adic result, the tightness mechanism stays
in D's file as a lemma nobody cites, G54 keeps the wrong variable, and the corrections to §S0, §S3, §S5, §S6 stay
unmade — the next reader of the plan inherits four wrong sentences with the right numbers beside them.

## Corrections requested so far, with addresses

- `Instances/FanGap11.lean:90-96`, the docstring of `finitePlane11_sharedGap_corrupt_refused` — "the M04 'corrupted
  table' control, on this table" overclaimed: the proof is `hSG.1.1 h00.symm`, the definition's first conjunct, and the
  corrupted table is still proper. **Done by K in `795fc7b`** (re-docstringed as a red on `FanGap`'s first conjunct,
  pointing at the two live table controls of `7cf33e5`).
- `plans/FS38-residue-tower.md` §S6, T row — the control list omits the planted-gap control at 2 (which §S3's P-A3 row
  demands) and any positive control for `forced` (none exists inside the tower below level 5; the diamond is the
  external one). **For phase C**: add both to the row so the record's control list matches what T ran.
- `plans/FS38-residue-tower.md` §S3, "the discriminating one is the coincidence with the pilot's graphs at levels 4 and
  5" — unrunnable (the pilot's code is gone with the planner's scratchpad); the replacement is T's ring-ideal check,
  whose scope is "the lattice description of `𝔓^m` GIVEN the presentation `R = (ℤ/16)[ω,π]/(π² − 2π − 2)`", the
  presentation itself staying [hand]. **For phase C**: say so in §S3.
- `plans/FS38-residue-tower.md` §S6, "ALL differences, no sampling" — at level 8 T decides every difference by
  one representative per automorphism orbit plus the orbit derivation, not by 65,500 solves. **For phase C**: state
  it as a derivation with its three conditions (generators verified, orbit sizes summed to 65,535, refusals still
  solver-word), not as a sample and not as "all asked".
- The skeleton's `finitePlane19_fanGap` at `(4,0)` was FALSE (docstring "`x + y = 4`"; the projection is `y − x`).
  **Done by K in `795fc7b`**, caught by `decide +kernel` — the kernel refusing a false statement before any reader did,
  the second such catch this milestone (the first was `twoAdicLevelHom` at `m = 0`, §M2).
- `plans/FS38-residue-tower.md` §S0, the 19 gapped classes written as "`x + y ∈ {4, 10}`" — a third coordinate
  order (the kernel's is `y − x`; the two class VALUES are the same under any order). **For phase C**: write `y − x`, and
  assert the coordinate-free sentence T proposes — 38 = 2·19 gapped (vertex, colour) pairs, every gap colour 1, on
  exactly the classes {4, 10}.
- `plans/FS38-residue-tower.md` §S3, the norm-form controls "dropping the `2` in the real part gives 18 at m = 3 …;
  dropping the `2` in the π-part gives 9, 18, 36, 72, 144" — those numbers are reproduced only by HALVING the
  coefficient (2 → 1); DELETING the term leaves `|S_m| = 3·2^{m−1}` at every level 1–7, as do a sign flip in `N` and
  a sign flip in `Tr` — four of six perturbations T tried cannot fire on the count (T, 18:33; its self-test went red on
  the deleted-term row, which is how it was found). **For phase C**: reword §S3 as "replace the coefficient 2 by 1",
  and name the deleted-term perturbation as the plant that cannot go red. A control-reachability instance in its
  purest form, found by an implementer planting faults routinely.
- `plans/FS38-residue-tower.md` §S5 D-1, "if the unavoidable periods form the coset `𝔓^{m−2}·(units mod 𝔓)` at every
  `m ≤ 4`" — refuted by D's complete enumerations (576 and 4,896 colourings at levels 2 and 3, plus level 4): the
  unavoidable structure is a DISJUNCTION over μ₃-triples `2x·{1, ω, ω²}` — one triple at level 3, three at level 4
  (`{2u}`, `{2√3u}`, `{2πu}`), no single element and no pair unavoidable. **For phase C**: replace the conjectured
  shape by D's, with D-1's verified colourings as the receipt.
- `plans/FS38-residue-tower.md` §S2 D0.3 and §S5 D-3, and the record's **G54** — the dichotomy is stated on
  gap-freedom ("gap ⟹ no forced pair is a theorem; no gap ⟹ forcing is an observation at 2 and 3"). The first half
  stands (it is `FanGap.lean`'s theorem). The second half is not the right statement at all: the classifier is
  **Hoffman tightness**, and tight ⟹ no gap ∧ every colouring periodic on `H_min` are both theorems of the ratio
  bound's equality case, verified against six planes (2 and 3 tight; 7 at four colours and 11, 19, 23 at five slack).
  **For phase C**: restate G54 on tightness, keep the kernel half as it is, and record the open question as "which
  (field, `k`) are tight" — which is computable and hands FS-17 a cheaper question than a colouring search.
- T's message of 18:33 says the gap plant deleted "1, 2, 4, 8, 32 and 64" edges at levels 1–6; the record files say
  16 of 48 at level 5 and 32 of 96 at level 6 (one colour class, `deg/3`, at every level). The records are right; the
  message slipped. Sent to T so `plans/FS38-tower-records.md` is written from the JSON.

## Retractions counted

Requested of the implementers: **1** of K (the corrupt red's docstring; done), plus two trust-word softenings in §R1
(done in `f42f11f`). Of T: **4** corrections to written records — the stale `DoubleSlack` names in the README and
two `claim_scope`s; the unfilled placeholder cells and "met" without a level range in the predictions table; the
misdated virtual-edge registration; the cross-agent reach of the `pkill -f` in incident 1 — beside four requests for
additions at design time (scope of the ring check; the level-8 orbit conditions; `recolour` controls; the `tables`
count), all four built. **T's own, self-caught and recorded: 4** — the diamond control asked the wrong pair and went
red; a record written under a superseded control rule; a headline print with a hardcoded "the control fired"; and the
`pkill -f` that killed its own level-7 run (resumed from the checkpoint at ask 11,001).
**Poros's own, public: 2** — (i) the 19 gap "at `(4,0)`", stated in both openers, wrong because my check encoded the
docstring's functional rather than the definition's, and undetectable by that check because `circ19D = −circ19D`
makes both candidate colourings proper with the same gapped classes; retracted to K and corrected to T within the
hour, the mechanism recorded in the inventory; (ii) a conditional defect report on the level-7 JSON's
`by_depth.separated` (1344 against a 384 I had read at level 6) — T's 18:36 regeneration had already made the field
S-only in every file (48, 288, 1344) and my level-6 reading was stale; withdrawn to T within ten minutes, before it
cost anything. Poros's own, private: 1 — the corrupt red was expected to be a
`decide` control and is a definition control (kept as the surprise it was; it became card 1, answered).
K's own: 1 — the false 19 witness, found and fixed by K before commit (K's count of the skeleton's error, not of its
own). **D's own: 1, and it is the largest of the phase** — the `(L)` route withdrawn as a derivation, with its
counterexamples exhibited and its circularity named, and replaced the same hour by a stronger mechanism; a retraction
that improved the result rather than costing it. **Mine, private and worth recording: 1** — I hand-checked `(L)`'s
propagation step and pronounced it sound, which it was, without asking whether the hypothesis it consumed was the
conclusion it served; the sketch's algebra was the part I could verify and the part that did not need verifying.
The lesson is card 1's own clause, now instanced on me: *write down the range of inputs a step needs before checking
the step*, because a correct derivation from an assumption equivalent to its conclusion reads exactly like a proof.
The G51 window is doing what it should: three retractions in three directions in the first twenty minutes and the
phase's biggest one at its end, every one free — nothing was committed under any of them.

## State at close-out (19:58; closed early at the product owner's request to limit concurrency)

**Committed and audited here:** K1/K2 (`d5979f8`, `7cf33e5`, `795fc7b`, `a81a9ca`, `55600fb`, `f42f11f`) — every
statement read against §S2, no overclaim. Phase T, complete at tip `0783ff2` (`b186391`, `0124cfa`, `963ad95`,
`754c1d3`, `d4f0e6f`, `1701479`, `0783ff2`): all eight tower levels, the gap censuses at 11 and 19, both shared gaps,
the level-4 cover, the level-5 LRAT artifact, the repaint, the README and the records document — **disk and git now
agree**, level 7 is a clean single-process run (1,015 s, 1.21 GB, `resumed_from_ask: null`), levels 1–6 are regenerated
under the final code, and T's `recheck` re-verified all eight from their files alone (0 inconsistent orbits at every
level; every per-depth example colouring proper on a freshly built graph and separating a difference of its depth).
The scores above therefore rest on committed records at every level 1–8, level 8's rows on the orbit derivation whose
licence is the position-by-position agreement at levels 3–6. Phase T closed at tip **`a72edc5`** (seven commits, 18 record files, the self-test green at 29 controls after every
edit), which also puts the standing recommendation on the LRAT bytes **on the page** rather than in a message
(`data/fs38/README.md` lines 108–112: leave the proof out, the reader's path being complete without it; if the bytes
are wanted, one narrow exception `!data/fs38/lrat/*.lrat` with its reason, never a change to the global rule) — so the
product owner decides from the record instead of re-deriving the options. Uncommitted at close: `TwoAdicTower.lean`
(K3's, in flight), `plans/FS38-derivation.md` (D's) and this file. **Read but not on disk:** phase D's four statements, sent
at 20:04 and being written into `plans/FS38-derivation.md`; the derivation is the phase's largest result and is audited
in the inventory above, but the file itself is unread by me. **Not read at all:** phase K3's statements (spawned 19:55,
after this audit; my opener names the two-table cover, the LRAT manifest's index order and pins, the red vacuity sites
with their inhabitant, and the records' per-level truth table). The product owner reads K3's statements aloud at review.

## What this pass held back, and why

- No solver run, no build, nothing heavy: the tables were checked by 726- and 3,610-edge Python loops in the scratch
  directory, seconds each.
- No opinion on χ(ℝ²); the ledger holds the bets with their falsifiers and dates.
- The 2-adic modules (`TwoAdicTower.lean`, `Instances/TwoAdicFour.lean`, `Instances/TwoAdicFive.lean`) are K3's and were
  not re-read here beyond §S10's listing; they are not this phase's headline.
