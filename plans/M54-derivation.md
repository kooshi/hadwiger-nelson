# M54 — the theorem audit (FS-71 batch 3a; ledger row 48)

*Filed 2026-09-22 by the batch-3a implementer. Enumeration: `plans/M54-five-colour-dial.md` read in full
(mission context through §3's D1–D4 derivations, the phase order, the modeling passes, §R0–§R8's close, and
the §R7 addendum recorded at the M55 close); `LEDGER.md` row 48 and § B; `Proofs/HadwigerNelson/CriticalSet.lean`
(full declaration list, to fix exact kernel names and to confirm the metric-space generalisation's kernel
status).*

## The theorems

**M54-T1 — D1: the critical-set localization theorem. [hand; the M54 implementer, generalising row 45's spare-colour
lemma]** Let `χ(G) = k+1` and `C(G) = {v : G − v is k-colourable}` (the critical set). If `(p,q)`, `p ≠ q`, is
forced equal at `k+1` colours, then `C(G) ⊆ N(p) ∩ N(q)` (in particular `p, q ∉ C(G)`); if `(p,q)`, `p ≁ q`, is
forced distinct, then `C(G) ⊆ N(p) ∪ N(q)` (again `p, q ∉ C(G)`). The spare-colour lemma is the special case
`C(G) = V` (impossible, since `V ⊄ N(p) ∩ N(q)` — `p ∉ N(p)`). **In the plane:** two distinct points have at
most two common unit neighbours and none beyond distance 2 (`PartnerLattice.eq_gluePoint_of_unit_pair`), so a
finite unit-distance graph forcing a pair equal at `χ(G)` colours has at most two critical vertices, none if the
pair is more than 2 apart; for a virtual edge, `|C(G)| ≤ deg p + deg q`. *Proof:* `plans/M54-five-colour-dial.md`
§3 D1 — for the forced-equal half: take `c ∈ C(G)` non-adjacent to `p`; `S = {p,c}` is independent, colour it
with the spare colour `k+1` over a `k`-colouring of `G − c ⊇ G − S`, separating `p` from `q`; the virtual-edge
half is the symmetric argument with `S = {p,q,c}`. *Proof verdict:* closes — a two-line argument per polarity,
checked here against the calibration case P-M54-1 (the theorem predicts every single-vertex deletion of the
Exoo–Ismailescu seed `H` refuses four colours, since `H`'s forced pair is at distance 5 and `2+2 < 5`; **MET**,
214/214 deletions refuse four colours in 1 s). *Rests on it:* every later critical-set reasoning in M54/M55
(row 49); M54-D4's "shape of any 6-forcer" corollary; `CLAUDE.md` G31's corollary about de Grey's 1581 (see
below). *Prior art:* ours — a graph-theoretic strengthening of the spare-colour lemma (itself credited to no
outside source, `LEDGER.md` row 45). No standard graph-colouring text states this exact localization (it is a
one-line consequence of criticality, likely folklore in the "critical graph" literature but not attributed to a
specific theorem here); zbMATH `ab:"critical graph" & ab:"forced" & ab:"coloring"` (0 hits matching this exact
shape — general critical-graph theory has many hits, none matching the "forced pair localizes the critical set"
statement); `ab:"list coloring" & ab:"precoloring extension" & ab:"critical"` (general critical/list-colouring
overlap, nothing matching). *Kernel:* **kernel, and MORE general than this entry's plane-specific statement.**
`CriticalSet.lean` (row 48) proves the graph-theoretic core abstractly (`criticalSet_subset_inter_neighborSet_of_forces`,
`criticalSet_subset_union_neighborSet_of_separated`, `not_mem_criticalSet_of_forces`,
`encard_criticalSet_le_degree_of_forces`) and **also** the metric-space form beyond the plane
(`criticalSet_eq_empty_of_forces_of_two_mul_lt_dist`, stated over any `[MetricSpace W]` with a general edge-length
`M`, not just unit distance) — so the "beyond distance 2 the critical set is empty" half generalizes cleanly,
while the "at most two critical vertices" bound (`encard_criticalSet_le_two_of_forces`) uses the plane's own
two-point circle intersection and is **not** claimed to survive to a general metric space (more than two points
can lie on the intersection of two unit spheres in higher dimensions or with repeated distances) — matching
`LEDGER.md` row 48's own phrasing, "generalized to edge-length sets and metric spaces, where the count ≤ 2 does
not survive."

**M54-T2 — The forcing-critical set reduces a spindle union's critical-set census to one ask per base vertex. [hand; the M54 implementer]** For `W⁺ = U ∪ R(U)` (a spindle union with fused centre `x`,
ring chord `y–R(y)`), define `F ⊆ U`, the *forcing-critical set* of `(x,y)` in `U`: `v ∈ F` iff `U − v` no
longer forces `x = y`. Then `C(W⁺) ⊆ F ∪ R(F)` — if `v ∈ U ∖ F` then `U − v` still forces `x = y` in `U`, so
`W⁺ − v ⊇ (U−v) ∪ R(U)` still refuses four colours (the copy `R(U)` still forces `x = R(y)`, and the ring chord
separates `y` from `R(y)`). *Proof:* `plans/M54-five-colour-dial.md` §R3 ("two lines" — the argument above,
verbatim). *Proof verdict:* closes. **Measured consequence** (tools grade, on the specific fabric `U`, 1,953
points): `F` for the pair `(35,1859)` is 7 vertices (all inside the 588-core of M53-T14), asked in 449 s over
1,951 candidates; `C(W⁺)` on the resulting 13 vertices (`F ∪ R(F)`) reduces a 3,905-point deletion census to 13
asks, all 13 confirmed critical. A second forced pair `(813,1939)` gives `F₂`, disjoint from `F₁`, so
`F₁ ∩ F₂ = ∅` and the three-fabric union `U ∪ R₁(U) ∪ R₂(U)` has **empty critical set by derivation** (a vertex
of `U` is critical for the union only if forcing-critical for *both* pairs; no copy vertex is, by the D1-style
argument one level up) — verified directly on the 34 load-bearing vertices, 34/34 non-critical, 0 unknown.
*Rests on it:* row 48's "the smaller (2,229 points) has no pair compulsion at five colours" (built from a
second, smaller-core version of the same reduction — see M54-T3); M54's D4 (the shape of a 6-forcer).
*Prior art:* ours — a project-specific localization technique built on M54-T1; no general graph-theory literature
addresses "forcing-critical" sets for a specific forced pair, since the notion presupposes the spindle
construction. zbMATH `ab:"forcing set" & ab:"graph coloring" & ab:"critical"` (general "forcing set" literature
in a different, unrelated sense — zero forcing sets for eigenvalue problems; nothing matching). *Kernel:*
declined — the reduction is a two-line derivation used as a tool-side speedup (450 s of forcing-asks in place of
a 900-s-walled 3,905-vertex census), with no standalone Lean statement or consumer.

**M54-T3 — Two 5-chromatic unit-distance graphs with empty critical set (the redundancy rung cleared). [tools;
the M54 implementer]** Two objects, both built from M54-T2's derivation with no vertex-deletion search beyond
confirming the derivation's bound: (i) the three-fabric union `U ∪ R₁(U) ∪ R₂(U)` (5,857 points, 41,390 unit
edges, `R₁–R₂` share no cross chord — the quadrature law, `CLAUDE.md` G12/M52) has `C = ∅`, confirmed on its 34
load-bearing vertices; (ii) a smaller twin, `core₁ ∪ R₁(core₁) ∪ core₂ ∪ R₂(core₂)` (`core₂` the second forced
pair's own 1-minimal shrink, 543 vertices; 2,229 points total, 12,030 unit edges) has `C = ∅` — the derivation's
upper bound is `core₁ ∩ core₂` (31 vertices), and the true critical set is strictly smaller: empty, all 31 asked
directly and non-critical. Both are the **first unit-distance objects this project holds whose 5-chromaticity
survives every single vertex deletion**, besides the Exoo–Ismailescu `{1,2}`-seed. *Proof:* `plans/M54-five-colour-dial.md`
§R4 (5,857-point object, 34/34 non-critical at a 1,800-s wall) and §R6 (2,229-point object, 31/31 non-critical at
a 900-s wall); both graphs independently confirmed to refuse four colours and admit five. *Proof verdict:*
closes (tools grade — exact geometry, direct SAT confirmation on the specific objects, matching the derived
upper bound exactly at zero). *Rests on it:* `LEDGER.md` row 48's own text ("Two 5-chromatic objects with no
critical vertex; the smaller (2,229 points) has no pair compulsion at five colours"); row 49's D2/absorption
reading, later theorem-ized (M55-derivation.md). *Prior art:* ours — the *construction* is new (built by
derivation, not search — see M54-T2); the underlying forced pairs (8/3, 8/√3) trace to Harder/Polymath16, per
M53-T14's credit. *Kernel:* declined — tools grade, no kernel certificate; the forcing-critical censuses and the
subsequent 5-colour sweeps are exact-arithmetic tool output (`tools/five_dial.py`), not Lean structures.

**M54-T4 — ν = δ₄: the fifth colour's smallest class is the 4-colourability deletion distance (D5). [hand; the
M54 implementer]** Define `ν(G) = min` over proper 5-colourings of the smallest colour class. A colour class `S`
has `G − S` 4-coloured by the other four colours and conversely, so `ν(G) = δ₄(G) := min{|S| : G − S$ is
4-colourable}`. Consequences: `ν ≥ 1 ⟺ χ ≥ 5`; `ν ≥ 2 ⟺ C(G) = ∅` (M54's redundancy rung is exactly this);
`ν ≥` the maximum number of vertex-disjoint 5-chromatic subgraphs. *Proof:* `plans/M54-five-colour-dial.md` §3
D5 — the equivalence `ν = δ₄` is immediate from the definitions (a colour class removed is exactly a set whose
removal 4-colours the rest, and vice versa). *Proof verdict:* closes. **Measured** (tools grade): `ν(H) = 38`
exact on the Exoo–Ismailescu seed (all 840 proper 5-colourings enumerated, smallest class 38, largest-smallest
42 — every colouring nearly balanced); `ν(W) = 1` (the single-spindle witness of M53-T14, vertex-critical);
`ν(\text{three-fabric union}) ≥ 2` (from `C = ∅`, M54-T3). *Rests on it:* row 49's D5 corollary
`ν(G) ≤ ν(G[A]) + |E(A,B) ∖ E(x,B)|`; the reading "every 5-chromatic witness ever built reads ν = 1
(vertex-critical or nearly)" against `ν(H) = 38`'s outlier status. *Prior art:* the equivalence `ν = δ₄` is
elementary (a restatement, not a discovery) — ours by construction of the definitions; "deletion distance to
`k`-colourability" is standard vocabulary in the defective/relaxed-colouring literature (`ab:"deletion
distance" & ab:"chromatic number"`, checked: general vertex-deletion-to-colourability results exist, none
phrased as "smallest colour class of an optimal `(χ+1)`-colouring", which is the specific identity here — a
restatement rather than new content). *Kernel:* declined — `ν`/`δ₄` has no Lean declaration; used purely as a
tool-side diagnostic (`tools/five_dial.py nu-exact`).

**D4 (not given a T-id — a reading, not a theorem): what the localization theorem predicts about any 6-forcer's
shape.** A 6-forcer built as "5-rigid fabric plus one spindle" needs
fabric `G` with a forced-equal pair at five colours; by M54-T1 that fabric has at most two critical vertices —
its 5-chromaticity must survive deletion of any single vertex but the pair's own two glue points. No known
5-chromatic unit-distance graph is within a factor of ten of that (de Grey's 1,581 near edge-critical; Heule's
shrunk to criticality; the M53 witness `W` a single spindle). *Proof:* `plans/M54-five-colour-dial.md` §3 D4 —
a direct reading of M54-T1's bound applied to the hypothetical shape of a 6-forcer, not a claim about an
existing object. *Proof verdict:* this is **not a theorem with an independent proof to verify** — it is
M54-T1 read at one remove, correctly flagged as such by the source ("This is the structural reason the 'one
gadget' reduction… relocates rather than shrinks the problem, made quantitative"). *Rests on it:* `CLAUDE.md`
G26/G32's framing of the "one gadget" reduction; the whole M54/M55 programme's shift from cheat-descent to
five-colour-dial. *Prior art:* ours — a reading about this project's own construction genre, not a
discipline-neutral claim. *Kernel:* not applicable — a reading, not a theorem; not filed in § B (per
`plans/FS71-theorem-audit.md` §M.1, a reading goes in section 3, never § B). Recorded here rather than in
"readings" below because it is stated at minting as a numbered derivation (D4) alongside three genuine
theorems, and separating it out keeps the numbering legible against the source.

**A note on de Grey's 1581 (CLAUDE.md G31's corollary).** The brief's seed flags G31's sentence — *"forcing at χ
allows ≤ 2 critical vertices, and this 1-sum has 3, so de Grey's 1581 has no forced pair at five"* — as a
candidate derivation to file under M54. **Not found stated in `plans/M54-five-colour-dial.md` or
`plans/M55-absorption.md`** (`rg -n "1581\|de Grey" plans/M54-five-colour-dial.md plans/M55-absorption.md` —
zero hits): M54/M55 build and measure the M53 fabric's own spindle unions, never de Grey's graph. The
"≤ 2 critical vertices" half is M54-T1 (kernel, row 48, this file). **"This 1-sum has 3" and the corollary
itself are `plans/FS25-P2.md`'s** (`grep -rn "1-sum has 3\|three critical vertices" plans/*.md` finds
"De Grey's 1581-vertex graph has at least three critical vertices at four colours (11, 802, …)" stated and
proved there, with the three critical vertices identified as exactly the seam of the 1-sum) — a milestone in
FS-71 batch 5's range (`plans/FS71-theorem-audit.md` §G.2, "Batch 5 — FS-24–FS-38"). **Flagged for batch 5, not
filed here**: FS25-P2's own derivation file should cite M54-T1 (this file) as the localization theorem it
combines with the 1-sum fact to reach "no forced pair at five colours"; that combination is the G31 corollary
proper and its home is FS25-P2, one identity that batch should record explicitly (a `Rests on it` cross-link to
`M54-T1`).

## Readings and measurements that were called theorems

- **"D2 — the absorption principle" is stated at M54's minting (§3) as "a reading with a derivation behind it";
  it is theorem-ized at M55** (`Absorb.extends_of_hubs`) — filed under `plans/M55-derivation.md`, not repeated
  here. M54's own registered falsifier for it (P-M54-4, "the two-spindle union has 0/0") **MET**, so D2 was
  never falsified within M54's own run — the phrase "falsified at one point in §4 phase C" in the header names
  where the registered *test* of D2 lives (phase C, the one-point falsifier of line 163), not an actual
  falsification event; confirmed by re-reading §R8's prediction table (P-M54-4: MET).
- **P-M54-5/6: the F₂₄₇ cross-lattice census** (71 distinct glue points from 208 candidates, 20 fusions, "the
  shadow of the K-lattice") is a measurement with a *reading* attached ("the cross lattice at depth one is not
  generic F₂₄₇ dust but the shadow of the K-lattice"), not a general theorem; not filed.
- **P-M54-6's second half** (the pool moved the critical set by three vertices, remotely, "a weak kill at three
  sites") is a measured fact about one specific object; the general mechanism it illustrates (a component of
  boundary-constrained non-4-colourable structure can un-critical a vertex collectively even when no individual
  new edge does) is stated as a reading in §Bʹ, not independently re-derived as a theorem here.

## Conjectures surfaced, not claimed

None found with a stated but unclosed proof.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M54-T1 | kernel (`CriticalSet.lean`, row 48) — and more general than this entry's plane-specific statement |
| M54-T2 | declined — tool-side speedup, no Lean consumer |
| M54-T3 | declined — tools grade, no kernel certificate |
| M54-T4 | declined — no Lean declaration, diagnostic only |
| D4 (no id) | not applicable — a reading, not filed in § B |
