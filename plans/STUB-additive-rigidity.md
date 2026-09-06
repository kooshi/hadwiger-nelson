# FS-1 — Additive rigidity: the design principle for a 5-tight unit-distance graph (STUB, 2026-09-06)

*Minted at the M56 close on Kooshi's direction ("do each actually advance our understanding in a way that helps us
get to 6? If so, stub all 3"). Written to the stub rule's standard: everything the deciding session knew, in plain
language, so a session with zero memory can subplan it. Read beside this: `plans/M56-arithmetic-of-tightness.md`
§S1 (L1–L7), §M1.5 (the Kempe localization), §R2 (the seed), §R3 (the witnesses, L8); `Proofs/HadwigerNelson/
Additive.lean`; `tools/additive.py`; `CLAUDE.md` G41, G26, G32, G37, G38; `plans/DESCENT-ALGORITHM.md` for what
the descent (M49–M53) was doing before the field wall stopped it.*

## 1. Mission context, in plain language

χ(ℝ²) ≥ 6 needs a finite unit-distance graph that is **5-tight**: some pair of its points is forced to share a
colour in every proper 5-colouring; rotating the graph about one endpoint until the other lands one unit from its
image then refuses five colours (`OneDefect.lean`, the spindle theorem, kernel). Nobody has such a graph. The only
5-tight object anyone has is Exoo–Ismailescu's {1, 2}-graph H (214 points, 1,004 unit edges, 446 distance-2
edges), whose forced pair sits at distance 5.

M56 found WHY H is tight, and the reason is arithmetic. Let Λ be the ℤ-span of H's unit edge vectors (a rank-4
lattice) and consider the additive colourings: homomorphisms φ : Λ → ℤ/5 nonzero on every unit vector, colouring a
point by φ(p − p₀). Every additive colouring is a proper colouring; in every one, a pair whose difference is
m·u (u a unit vector, m ∈ {2, 3, 4}) is SEPARATED (φ(mu) = mφ(u) ≠ 0) and a pair whose difference lies in 5Λ is
IDENTIFIED. On H: exactly 18 additive colourings exist up to palette; the forced pair (205, 206) is the unique
non-adjacent pair every one of them identifies; all 446 distance-2 edges and all distance-3/4 pairs are separated by
every one; 18 of H's 35 five-colourings ARE the additive ones and the other 17 differ from an additive colouring in
at most two vertices; and for the paper's smaller G (205 points) ALL 18 five-colourings are additive — G's colouring
space is exactly its additive family.

So H is tight because its colouring space is (nearly) its additive family, and additive families force 5Λ-pairs
for free. **The design principle this stub is about:** a unit-distance graph whose 5-colourings are all additive,
and which contains a pair at a 5Λ-difference, is 5-tight by arithmetic — no search needed for the forcing, only
for the additivity. The distance-2 edges of H are the constraints that KILL its non-additive colourings while
costing the additive family nothing (every additive colouring already separates them); the descent (M49–M53) tried
to replace them with unit material and stalled at the field wall (Theorem B: inside K = ℚ(√3, √11) the unit part
is always 4-colourable, so its 5-colourings have a free fifth colour and are never near-additive). The principle
says what the unit material must do — reduce the additive DEFECT of the colouring space to zero — and the
instrument measures it.

## 2. What we know (the facts the derivations start from)

| fact | status | where |
|---|---|---|
| an additive colouring is a proper colouring; a hom separating p, q refutes `Forces`; L1: p − q = e·w ⟹ φ p = φ q | kernel | `Additive.lean` |
| F_true ⊆ F_add ∩ F_K (the additive and Kempe localizations) | theorem (plan) + measured | M56 §S1 L2, §M1.5, §R1 |
| the seed: F_add = {(205, 206)} over 21,787 pairs; 18/35 colourings additive, rest at defect ≤ 2; G entirely additive | measured, exact | M56 §R2, `data/m56/` |
| K-fabric U at 4: 8 additive colourings; the solver's colourings separate every depth-2 pair — non-additively; U is NOT additively rigid at 4 | measured | M56 §R1 |
| the witnesses at 5: additive families of 24 (Heule-510), 432 (W), ≥ 2,981 (the 1581); their forced pairs (91, 291, 356) all separated non-additively; W's sampled 5-colourings at the random baseline from the additive family (defect 850–876 of 1,175) | measured | M56 §R3 |
| no plane over a wall-broken field has an additive k-colouring for k ≤ 10 (1/5 ∈ Σ₀ always; 1/2, 1/3, 1/7 from the spindle rotations) — so every rich enough chunk loses its ℤ/5-homs | derived (L7) | M56 §M1.7 |
| the spindle rotation at distance 5 is τ₅ = (49 + 3i√11)/50 ∈ K(i): a pair forced at distance 5 spindles INSIDE K | fact | `FieldWall.lean`'s vocabulary; E–I §2 |
| the descent's cull found 149 of the seed's 273 standing cheats sufficient (M52) and the residue obstruction gave μ ≥ 3 inside K (T17) | measured + theorem | M52, T17 |
| Theorem B: K-point unit graphs are 4-colourable — a K-point chunk is never 5-tight; the principle needs a wall-broken field (F₂₄₇, Heule's, de Grey's) | theorem (hand) | `plans/FIELD-WALL-THEOREM.md` |

## 3. The derivations to do first (G30: before any instrument)

**D1 — the reduction theorem (kernel, an afternoon).** If every proper 5-colouring of a finite unit-distance graph X
is additive (equals π ∘ φ(· − p₀) for some admissible φ : Λ(X) → ℤ/5 and palette π) and p − q ∈ 5Λ(X) with
|p − q| ≥ 1/2, then p, q are forced equal at five colours (L1 applied to each colouring), hence by
`OneDefect.not_colorable_of_forced_equal` the spindle union is not 5-colourable and χ(ℝ²) ≥ 6. State it with the
additivity hypothesis as "∀ C : X.Coloring (Fin 5), ∃ φ admissible, ∃ π, C = π ∘ φ" over the lattice-as-vertex-type
of `Additive.lean`; the proof is `Forces` from L1 plus the existing spindle theorem. Its value is as a TARGET
statement: the hypotheses are exactly what phase B must produce.

**D2 — the free constraints.** A constraint "p ≠ q" costs the additive family nothing iff φ(p − q) ≠ 0 for EVERY
admissible φ, i.e. p − q lies outside the union of the admissible kernels. For d = m·u (u a unit vector of X,
m ≢ 0 mod 5) this is automatic. Compute, per chunk, the "additively free" difference classes (the complement of the
kernel union — on a rank-4 lattice with 72 homs, 72 hyperplanes of 𝔽₅⁴); these are the pairs a virtual edge may
sit on without touching the additive skeleton, and the classes the descent's cheats occupy (distance 2 = 2u) are
the first instance. Derivation: on H, are ALL 446 cheats at differences 2u for unit vectors u of H (predicted yes,
M56 measured them all separated by every hom), and which OTHER free classes exist (distance 3 = 3u, 4 = 4u, 2√3, …)?

**D3 — additive rigidity at lower k, the bridging case.** Call X *additively k-rigid* when every proper
k-colouring is additive. The grid is additively 2-rigid, the hexagonal lattice ball additively 3-rigid (unique
colourings). At four colours in K the additive family has ≤ 8 members, so an additively 4-rigid K-chunk has ≤ 8
four-colourings up to palette. Derive what prevents it: a Kempe swap on a component of the {a, b}-subgraph of an
additive colouring is proper; it is additive only if the component is a union of whole cosets of Λ_c^φ inside X
(the swapped colouring's differences must again be a hom) — so any additive colouring with an {a, b}-component that
is a PROPER part of a coset, both parts present in X, yields a non-additive colouring by one swap. Hence: **X is
additively k-rigid only if, for every admissible φ and every c ≠ 0, every {a, a − c}-component of X is a whole
coset-intersection** — a lattice/graph condition, checkable without colourings. On the hexagonal lattice at 3 the
components are the whole cosets (the {a, b}-subgraph of the (√−3)-colouring on a ball is the ball's intersection
with one line direction… check). Prediction P1 below follows.

**D4 — where the skeleton lives (the richness dial, folded from the M56 close's item 2).** By L7 every rich enough
chunk of a wall-broken field has no ℤ/5-hom at all, and then the principle has nothing to build on. The dial: grow
a chunk of each field (hexagonal fabric plus the field's rotations, as `tools/closure.py` grows closures) and record
the admissible-hom count against size; the last chunk with a nonempty additive family is the principle's ceiling
in that field. Derive first what kills the homs: a unit vector entering 5Λ, or the hyperplane cover — for the
1581 (rank 16) 3,000 homs survive, for Heule-510 (rank 8) 96, for W 1,728; the ranks and the unit-class counts
say the cover is far from complete on all three.

**D5 — the descent, re-read through the principle.** The descent removed cheats by adding unit material (halos)
that killed every 5-colouring separating the forced pair. In the principle's terms it was pushing the colouring
space of unit ∪ (remaining cheats) toward the additive family, cheat by cheat, and the field wall said the unit
part inside K can never get there (4-colourable ⟹ a free fifth colour). In a wall-broken field the unit part CAN
be 5-chromatic (W is), but W's colouring space is at the random baseline. The gauge the descent never had is the
**defect distribution** of sampled colourings: a monotone quantity a design step can be scored by, continuous where
"cheats remaining" was a count. Derive what a single added point can do to the defect (the additive kill census:
a point at a lattice offset kills the non-additive colourings whose neighbourhood it cannot colour and no additive
one when its offset is at an additively free difference from its neighbours).

## 4. The order of work

| phase | what | cost | reads |
|---|---|---|---|
| 0 | D1–D5 written out; D3's coset-component condition stated as a checkable predicate | a day, no compute | P1 |
| A | kernel: the reduction theorem (D1) on `Additive.lean`'s vocabulary; instrument: `additive.py rigid --k` (enumerate the k-colourings up to palette by SAT blocking under a cap; test each for additivity; verdicts `additively-rigid` / `not-rigid: n non-additive of N` / `capped`), `additive.py free --k` (D2's free classes), `additive.py defect --trend` (the defect distribution as a scored gauge with the random baseline printed beside it) | a day | — |
| B1 | the bridging case at four colours in K: the Moser spindle, the 122-core, the 588-core, the seed's unit part, small hexagonal balls — which are additively 4-rigid, and where D3's component condition first fails | an hour | P1, P2 |
| B2 | the seed at five colours in reverse: remove cheats one at a time (and the M52 cull's 124 redundant ones as a batch) and record the additive defect distribution of the colouring space — which cheats hold additivity, and what the free-class structure (D2) of the necessary ones is | hours | P3 |
| B3 | the richness dial (D4) in Heule's field and F₂₄₇ | hours | P4 |
| B4 | the design attempt: W (F₂₄₇) plus its depth-one partner points, scored by the defect gauge — do added points move the sampled colourings toward the additive family at all, and which offsets do (the additive kill census, D5) | hours–a day | P5 |
| C | close: gate, `data/`, the Frontier, the re-ranked frontier set |  | |

## 5. Registered predictions

| # | prediction | basis | confidence |
|---|---|---|---|
| P1 | the Moser spindle is additively 4-rigid (all its 4-colourings are ℤ/4- or 𝔽₂²-homs of its rank-4 lattice); the hexagonal ball is additively 3-rigid | small colouring spaces; D3 | medium |
| P2 | no K-chunk of more than ~50 points is additively 4-rigid: D3's component condition fails (a residue colouring's {a,b}-components are proper parts of cosets on any chunk with a boundary), and the 122-core and 588-core each have non-additive 4-colourings | D3 | medium-high |
| P3 | on the seed, every single cheat removal keeps the colouring space within defect ≤ 3 of the additive family, and the M52 cull's 124 redundant cheats can be removed together at defect ≤ 3; the cheats that hold additivity are the ones on the fewest free classes | the cheats are individually redundant (M52) | medium-low |
| P4 | Heule's field loses its last ℤ/5-hom on hexagonal-fabric chunks below 3,000 points once a √15 rotation is included; F₂₄₇ likewise below 3,000 with the ρ₂₄₇ rotation | the 1581 keeps thousands at 1,581 points, rank 16; a chunk closed under one rotation has a fuller hyperplane cover | low |
| P5 | W's depth-one partner points do NOT move the sampled defect by more than 5 % of the baseline — thin material does not fix floppiness (M55's absorption, in the additive gauge) | G40 | medium |

## 6. Failure and jackpot clauses

* **Jackpot**: an additively 5-rigid unit-distance chunk with a 5Λ-pair at distance ≥ 1/2 — HALT, verify (the
  `rigid` enumeration complete, not capped; a second encoding; the pair's difference re-derived exactly), then
  D1 in the kernel with the chunk's data: χ(ℝ²) ≥ 6.
* **P2 holds and no additively 4-rigid K-chunk exists beyond the spindle**: the principle is unreachable with
  unit material at four colours by the Kempe mechanism; then FS-2's question (is the colouring space the Kempe
  closure of the additive family?) becomes THE question at five, and this stub's B4 is demoted.
* **P5 refuted** (the defect moves): the additive kill census becomes the descent's new score, and the descent
  resumes in F₂₄₇ under it — a new milestone.
* **The richness ceiling (P4) is below the size any 5-chromatic chunk needs**: the principle cannot apply to
  5-chromatic material at all in that field; record per field.

## 7. Instruments (all in `tools/additive.py`; every subcommand with a planted control seen red first)

`rigid --k [--cap N]` (control: the grid at 2 rigid; the hex ball at 3 rigid; U at 4 not rigid, with the count);
`free --k` (control: the seed's 446 cheats all in free classes); `defect --trend --baseline` (prints the random
baseline for the stage's n and k beside the histogram; control: a random colouring reads at the baseline);
`kill-census --k --pool FILE` (D5; control: a point whose neighbourhood is a rainbow K₅ minus one colour kills the
colourings that use that colour on it). The chunk grower for D4 reuses `tools/closure.py` (the half-spindle words)
and `five_dial.py cross-lattice` (F₂₄₇ glue points).

## 8. Costs (desktop)

Rank ≤ 4 lattices: milliseconds per question. Colouring enumeration under a cap: the seed's 35 took 255 s; a
1,000-point chunk with millions of colourings is capped at a sample (the `capped` verdict is not "rigid"). The
richness dial: minutes per chunk (SAT for the homs above rank 8). B4: an hour per pool.

## 9. Addresses

`tools/additive.py` (the stage vocabulary: `--seed`, `--object`, `--witness`, `--heule510`, `--degrey`,
`--field16`, `--graph`, `--planted`); `data/m56/` (the seed's 35 colourings dumped, W's 200 sampled, the homs
records with every colouring as a colour vector); `tools/m56_seed_G.py` (G's colourings); the seed's exact
coordinates `twodist.ei_H()` / `ei_G()`; the M52 cull `data/m52/culled-final.json` (the 149 standing cheats); the
witness `data/m54/witness-exact-core-8over3.json`; the 1581 `tools/degrey_cert.json`; Heule-510
`tools/heule510.json`; the spindle theorem `Proofs/HadwigerNelson/OneDefect.lean`.

## §B. Decisions at minting

| decision | choice | alternative | why | confidence |
|---|---|---|---|---|
| the richness dial | a phase of this stub (D4, B3), not a milestone | its own stub | alone it is a survey; it matters only as the principle's ceiling | high |
| the kernel piece | D1, the reduction theorem, first — it names the target | measure first | the hypotheses ARE the design spec; an afternoon | high |
| the bridging case | four colours in K before five anywhere | five directly | the calibrated-bed rule; D3's obstruction is visible at four | high |
| bearing on 6 | HIGH: a sufficient condition the kernel can hold, and a continuous gauge for the descent's stalled goal | — | — | — |

## §H. Handoff for the session that opens M57 (written 2026-09-06 at the compaction before it)

**Kooshi's decision:** M57 = this stub (FS-1, rank 1 of `plans/FRONTIER-STUBS.md`). Do NOT re-decide it.

**Read, in this order, before anything else:** (1) `CLAUDE.md` § Frontier — the M56 paragraph, G41, § Paths forward's
pointer; (2) this stub, §1–§B in full; (3) `plans/M56-arithmetic-of-tightness.md` §S1 (the derivations L1–L7), §M1.5
(the Kempe localization), §R1–§R3 (the numbers this stub's facts table cites); (4) `Proofs/HadwigerNelson/Additive.lean`
(the four theorems D1 composes with; note `Forces` lives in `Forcer.lean`, `Separated` in `Fan.lean`, the spindle
theorem `not_colorable_of_forced_equal` in `OneDefect.lean`); (5) `tools/additive.py`'s module docstring and
`data/m56/README.md` (the stage vocabulary, the verdict words, what a row licenses).

**Then WORKFLOW step 3 onward, no shortcuts:** rename this file to `plans/M57-additive-rigidity.md` (git mv; keep the
FS-1 row in `FRONTIER-STUBS.md` with status "opened as M57"); write the subplan (the skeleton for D1 — the reduction
theorem's exact statement over `Additive.lean`'s vocabulary, `sorry` at the leaf — and the instrument's subcommand
table with its controls; measure before specifying only where cost decides a shape); commit; the three modeling
passes as FRESH Skill invocations (`debruijn-domain-modeling`, then `debruijn-obligation-modeling`, then
`debruijn-experience-modeling`), each committed before the next; then implement. The calibrated-bed rule applies:
the four-colour bridging case (B1: is the Moser spindle additively 4-rigid; where D3's coset-component condition
first fails on K-chunks) runs BEFORE anything at five colours. Register P1–P5 as they stand unless the subplan's
derivations sharpen them — and if a derivation settles one before measurement, say so in the subplan as M56 did.

**Cheap first computations the subplan may run** (scratch, then reproduced under controls in phase A): the Moser
spindle's 4-colourings up to palette against its 8-or-fewer additive ones (seconds); the seed's 446 cheats' free
classes under D2 (seconds); D3's component condition on the hexagonal ball (seconds).

**Running at the compaction:** the M55 108 targeted asks on the full-pool thickened witness (pid 839605, ~9 h,
`build/m55/ask-depth2.log`; result `data/m55/ask-W-plus-cross-depth2-k5.json` when written; exit 3 = jackpot;
registered P-M55-10: 0 hits). Read its result when it exists, record it as an M55 §R6 addendum and an FS-3 datum,
then move the untracked `data/m54/critical-W-plus-cross-depth2.json` into `data/m55` and commit. It is the only
untracked path; the tree is otherwise clean at commit `2520113`.

**Standing rules that bit this session:** kill by PID (never `pkill -f` a pattern matching the shell); `build/` is
gitignored — scripts go in `tools/`; ALWAYS `./scripts/build.sh`; one heavy job at a time; every claim of
"separated" carries a verified colouring, every "forced-additively" is theory-level and worded so (L2); a complete
sweep listing no forced pairs has settled every pair as separated (the inverted-candidate incident, M56 §R5).
