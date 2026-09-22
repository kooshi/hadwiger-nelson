# M49 — the theorem audit (FS-71 batch 2b; ledger row 44)

*Filed 2026-09-22 by the batch-2b implementer. Enumeration: `plans/M49-two-distance-descent.md` read
in full (§C, §Cʹ–§Cʹʹʹ, §D, §0, §R0–§R10, §S); `LEDGER.md` row 44 and § B; `Proofs/HadwigerNelson/`
declaration existence checked with `rg`. `data/m49-*` artifacts are referenced by name from the plan;
none opened (JSON provenance, not proofs, per the batch-1/2a precedent).*

## The theorems

**M49-T1 — Exoo–Ismailescu's 214-point {1,2} six-forcer, re-derived exactly. [tools; the phase-1
implementer]** For the 214-point set `H` (the [ExooIsmailescu2020] construction: seeds in
`ℚ(√3,√11)`, closed under two reflections and six `π/3` rotations, plus nine named points including
`A` (index 205) and `B` (index 206) at `|AB| = 5`), rebuilt here in exact rational arithmetic on the
4-coefficient basis with the paper's own published counts planted as assertions: `H` has exactly 1,004
unit edges and 446 distance-2 edges, and its proper 5-colourings (exhaustively enumerated up to
palette by blocking-clause SAT, first-occurrence breaking) number exactly 35, with `A = B` in every
one — i.e. `H` forces `A = B` at five colours, so (by the spindle theorem at `d = 5 ≥ 1/2`)
`6 ≤ χ(ℝ²; {1,2})`. *Proof:* §R1 (`plans/M49-two-distance-descent.md`, "Re-derivation from the paper's
data alone", `tools/twodist.py --seed`; the exhaustive-enumeration argument is a complete proof at
tools grade — every one of the 35 colourings is checked, not sampled). *Proof verdict:* closes.
*Rests on it:* row 44 (the ledger's headline for M49); the kernel spindle theorem
(`not_colorable_of_forced_equal`, `Spindle.lean`) as the finishing step. *Prior art:* this theorem —
`H` forces `A = B`, hence `χ(ℝ²;{1,2}) ≥ 6` — is [ExooIsmailescu2020]'s own (G. Exoo, D. Ismailescu,
*A 6-chromatic two-distance graph in the plane*, Geombinatorics 29 (2020); arXiv:1909.13177), already
held and read (M49; BIBLIOGRAPHY.md § A). Their own verification was "a custom exhaustive search
only" (§D) — the same genre of check as ours, independently re-implemented. zbMATH:
`au:"Exoo, G" & au:"Ismailescu"` (7 hits, the paper among them, confirmed against the held PDF);
`ab:"two-distance" & ab:"chromatic number" & ab:"plane"` (1 hit, De Neve et al.'s survey, not this
paper — a negative that measures the query's words, not a finding). *Kernel:* **priced, deferred, not
emitted.** The planned kernel route (`Instances/OneTwo.lean`, Route 1: `Forces` via `Gadget.ofUnsat`
on ports `(A, a₁, a₂, B)`, three cubes) was priced *before* any emission (§R1): the three cubes trim to
616,839 / 570,943 / 521,847 derived clauses carrying 24.0M / 22.9M / 19.8M hints — at the standing
kernel rate of 1.35 ms/hint, roughly 25 kernel-hours and ~600 MB of generated Lean source, comparable
to M06's whole de Grey certificate (34M hints / 27.8 h / 396 MB) for one gadget alone. Every cheaper
lever was measured and rejected (a vertex-shrunk core was the M07 move actually taken, see M49-T3; a
six-port design projected to ~78M hints, worse). **`Instances/OneTwo.lean` was never built — it is a
dangling address**: two docstrings cite it as if it exists (`Proofs/HadwigerNelson/DistanceGraph.lean:28`
— *"six-forcer (`Instances/OneTwo`) and, for free, by the hexagonal shell…"* — and
`Proofs/HadwigerNelson/Homogeneous.lean:93` — *"composed with `Instances/HexShell.lean`'s pigeonhole
(or with `Instances/OneTwo`'s single-class…"*), but no file or directory of that name exists anywhere
under `Proofs/HadwigerNelson/Instances/` (confirmed: `ls Proofs/HadwigerNelson/Instances/` lists no
`OneTwo*`, `find -iname '*onetwo*'` returns nothing). A reader following either docstring reaches
nothing.

**M49-T2 — Parts's {1,φ} six-forcer `G31` is edge-critical: every one of its 113 edges is essential. [tools/cert;
the phase-5 implementer]** For the 31-vertex graph `G31` (two copies of Parts's 16-vertex `G16`, fused
at vertex 1 and rotated by `arccos((95+√5)/100)`; 57 unit edges + 56 `φ`-edges, rebuilt exactly in
`ℚ(√5)` from [Parts2020b]'s two published edge lists and independently confirmed not-5-colourable),
**every single-edge deletion — all 56 `φ`-edges and all 57 unit edges — leaves a 5-colourable graph**
(113 SAT calls, models validated in-process; twenty independent greedy minimal-forcing-set orders all
return the full 56 as the answer to "fewest `φ`-edges keeping `A ≠ B` unsatisfiable" — i.e.
`μ(φ) = 56 = |φ-edges|` exactly). The forced-pair carrier `G16` alone (28 unit + 28 `φ`-edges, forcing
`1 = 16` at five colours) is likewise edge-critical, 28/28 and 28/28. *Proof:* §R5
(`plans/M49-two-distance-descent.md`, "μ(φ) exactly"; `scratchpad/parts31.py`, `build/m49-parts31.json`).
Reconstruction control: the induced `{1,φ}`-subgraph search on the rebuilt `G126` (350+350 edges,
matching Parts's own count) reproduces `G16`'s 28+28 edge lists exactly; the designed rotation's exact
identity `2·(5R)²·(5−√5)/100 = 1`, `R² = (5+√5)/10`, is checked symbolically, and the other 224
cross-copy pairs are shown to miss both `{1,φ}` distances by a numeric margin ≥ 0.0132 (a 60-digit
census — the rotation itself leaves `ℚ(√5)`, so only this half of the reconstruction is numeric, and
it is labelled as such in the record). *Proof verdict:* closes. *Rests on it:* row 44's tools clause
("Parts's {1,φ} forcer edge-critical (checked)"); nothing else in the ledger consumes edge-criticality
directly, but M50's phase-5 stub named it as a replication target for the skewscan (queued, not run —
`plans/M50-batch-descent.md` "The registered replication"). *Prior art:* the graph `G31` and its
non-5-colourability are [Parts2020b]'s (arXiv:2010.12656 — held, read at M49; BIBLIOGRAPHY.md's row
gives the title as **[title unverified]**, a debt this entry does not close). Whether Parts's own paper
states or uses edge-criticality is not established here — the finding is filed as **ours** on the
present evidence (the plan records it as a fresh exhaustive check, not a citation), with a check owed
against the actual paper text. zbMATH: `au:"Parts, J" & ab:"two-distance"` (0 hits — his own venue,
arXiv only, is outside zbMATH's coverage, a negative about the index, not the claim);
`ti:"edge-critical" & ab:"chromatic"` (21 hits, none matching this object by title — the standard
edge-critical-graph literature, unrelated to two-distance six-forcers). *Kernel:* declined — the
reconstruction is exact rational/sympy arithmetic in `ℚ(√5)`, not yet represented in Lean, and nothing
downstream consumes the criticality fact as a hypothesis.

**M49-T3 — The two-distance pigeonhole dial on the certified seed: 29 ≤ μ_H ≤ 252. [tools; the phase-2
implementer]** Where `μ_H` is the fewest of `H`'s 446 distance-2 edges (unit edges kept, WLOG) whose
presence still forces `A = B` at five colours: a single-deletion census (`forces_outcome(H − e)` for
each of the 446) finds exactly 29 edges whose lone removal admits a validated separating colouring —
each such edge therefore lies in **every** forcing subset (if `e ∉ S` then `S ⊆ H − e`, which does not
force, by `Forces`'s monotonicity in the edge set), giving the rigorous lower bound `μ_H ≥ 29` with no
heuristic step. A parallel delta-debugging shrink from the 417 individually-deletable edges reaches a
252-edge set that still forces (certified: UNSAT, 3-bit re-encode UNSAT), giving the upper bound
`μ_H ≤ 252` — explicitly **not** claimed to be 1-minimal (a necessity census on the 252 finds 114 of
them still individually deletable at the 960-second cap, so 252 is cap-limited, not exact). *Proof:*
§R2 (`plans/M49-two-distance-descent.md`; `build/m49-seed-edges.json`). *Proof verdict:* closes (both
bounds of the stated sandwich are individually rigorous; the exact value of `μ_H` between them is
explicitly undecided — P2 was registered as "μ_upper ≤ 149" and scored UNDECIDED, which is a fact about
the registered *prediction*, not about the *sandwich stated here*, which does close). *Rests on it:*
row 44's "29 ≤ μ ≤ 252 on the seed (measured)"; M50's phase-3 depth profile (`plans/M50-batch-descent.md`
§R3) recomputes the same 29 as the object's "floor" after two batch commits. *Prior art:* ours — the
quantity μ (G32) and this dial are this project's own vocabulary; the *mechanism* (an edge whose
deletion breaks forcing is necessary) is a one-line consequence of `Forces`'s edge-monotonicity, which
is already kernel (`Forcer.Forces.mono`, cited by G31) — so the lower-bound *argument* is an instance of
a held theorem, not new; what is filed here is the specific numeric result on this object. zbMATH:
`ab:"critical" & ab:"two-distance graph"` (0 hits); `ti:"minimum" & ti:"forcing set" & ab:"colouring"`
(3 hits, all about "forcing sets" in a different sense — completion/defining-set literature for Latin
squares and Steiner systems, not chromatic forcing). *Kernel:* declined — μ is deliberately kept out of
the kernel by design (§Cʹ item 5 of the plan: "a definition with no lemma API and no consumer besides
prose").

## Readings and measurements that were called theorems

- **§R3–§R3′ (the k = 4 calibration)**: P4b's prediction "the seam halo removes NONE" was refuted 34 of
  37 times, but this is a registered-prediction scorecard on one object, not a general theorem; the
  plan's own correction ("G1 speaks of pure unit material forcing five; a halo does a distance-2 edge's
  job in context") is prose reasoning about why the prediction was mis-derived from G1, not a new claim.
- **§R8–§R9 (the enumeration screen and designed kills)**: "the candidate space is enumerable, in any
  field" and the completeness caveat ("depth-one completeness for single-point kills is a corollary of
  `Glue.sphere_inter_sphere`") are both explicitly marked "to be written" in the plan itself — no proof
  is on disk beyond the one-paragraph sketch, and the claim is in any case a direct corollary of the
  already-kernel M22 gluing classification (`Glue.sphere_inter_sphere`, row 17), so it is not filed as a
  fresh theorem.
- **§R10's "closure-transfer angle" and "no-stall reframing"** are registered ideas for M51/M52's
  successors ("Kooshi's question... registered"), not results with a proof; the no-stall lemma is
  explicitly noted in the plan as, in full generality, *equivalent* to χ ≥ 6 itself.
- **§D's report on Parts's `d = 2` family** ("no pair at `5/√3` is forced equal there... his 199-vertex
  reduction cannot come from this pool") is a negative finding about a *different* reconstruction
  attempt, reported as an honest null, not a theorem.

## Conjectures surfaced, not claimed

None with a *gap* proof verdict — every theorem filed above closes on its own stated terms. The registered predictions P1–P8 (§R6) are scored outcomes of a campaign, not conjectures in FS-71's sense (a claim advanced as a theorem whose proof does not close); none is refiled here.

## Prior art re-attributed

- M49-T1: `[ExooIsmailescu2020]`'s own theorem (the six-forcer and its consequence `χ(ℝ²;{1,2}) ≥ 6`);
  our contribution is the independent re-derivation and the priced-but-undeployed kernel route. No
  bibliography edit needed — the row already states this.
- M49-T2: object `[Parts2020b]`'s; edge-criticality filed as ours pending a read of his paper (check
  owed, recorded above, not a bibliography edit here since the row's "[title unverified]" flag already
  covers the underlying debt).

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M49-T1 | **priced, deferred** — `Instances/OneTwo.lean`, ~50–67M hints across three cubes, ~25 kernel-hours, ~600MB; never emitted. Two dangling docstring references recorded (`DistanceGraph.lean:28`, `Homogeneous.lean:93`) |
| M49-T2 | declined — number-theoretic reconstruction (ℚ(√5) exact/sympy) not yet in Lean; no consumer |
| M49-T3 | declined — μ is deliberately out-of-kernel by the milestone's own design decision |
