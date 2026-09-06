# M57 — Additive rigidity: the design principle for a 5-tight unit-distance graph (opened 2026-09-06 from FS-1; the stub is §1–§H, the subplan §S)

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

---

## §S. Subplan (2026-09-06, the session after the M56 close; WORKFLOW step 3; Kooshi: "You are go for M57")

*Derivations before any instrument (G30). The skeleton is `Proofs/HadwigerNelson/AdditiveRigid.lean` (elaborates,
eight `sorry` leaves). The 108 asks of M55 are still running (pid 839605, 9 h at the opening) and are left alone.*

### S1. The derivations, done (D1–D5 sharpened; the stub's D3 corrected in its mechanism)

**D1 — the reduction theorem, stated at its least.** The reduction consumes only this: on the chunk's vertex set S,
every proper k-colouring is constant on the cosets of SOME subgroup H ⊇ k·V (`IsAdditiveOn`). That is weaker than
Fischer's notion (a hom into a group of order k, the instrument's `additive-test` verdict) and it is all L1 needs:
p − q = k·w ∈ H ⟹ C p = C q for every C, i.e. `Forces Γ k p q`; the spindle theorem (`add_one_le_chromaticNumber_
unitDistance_of_forces`) then gives χ(ℝ²) ≥ k + 1 from a drawing with unit edges and |p − q| ≥ 1/2. The vertex set S
is explicit because the ambient type is the lattice and a chunk is a finite subset of it — with S = V an isolated
point coloured freely would refute rigidity of every chunk. Five statements, all two lines once the definitions are
right: the bridge `isAdditiveOn_of_addMonoidHom` (H = ker φ), `IsAdditiveOn.apply_eq` (L1), `forces_of_
additivelyRigidOn`, the plane corollary at any k, and the k = 5 numeral form `six_le_chromaticNumber_unitDistance_
of_additivelyRigidOn` — the milestone's TARGET, its hypotheses the design specification. The model of every
hypothesis: the unit path `(0,0)–(1,0)–(2,0)` is additively 2-rigid on its three points, its endpoints differ by
`2·(1,0)`, drawn at unit spacing they are 2 apart, so χ(ℝ²) ≥ 3 — nothing new, and non-vacuous. The red: the hexagon
ℤ/6 at three colours has the proper colouring `0 1 0 1 0 2`, which separates 0 from 3 = 3·1 — not additively rigid.
**What the theorem does NOT do:** "every colouring is additive" is a universal over all colourings, supplied by an
UNTRUSTED enumeration; at a jackpot the kernel certificate is the pair's forcing by refutation (the M34 bridge / an
LRAT on the spindle union), never the additivity census. The reduction theorem is the statement that makes the
design target exact, and it is honest about that in its docstring.

**D2 — the free classes, and what they buy.** On A_k = Λ/kΛ the admissible homs' kernels split the nonzero classes
three ways: *forced* (in every kernel: F_add's classes), *free* (in no kernel: every additive colouring separates
them), *mixed*. A constraint p ≠ q costs the family nothing iff its class is free; at k = 5 (prime) every m·u with u
a unit class and m ∈ 𝔽₅× is free (φ(mu) = mφ(u) ≠ 0) — the seed's cheats (2u), M50's distance-3/4 virtual edges (3u,
4u) — so free ⊇ 𝔽₅×·S₅. At k = 4 it is not automatic (2u with φ(u) = 2 in ℤ/4 vanishes). **The design reading:** a
free class is also a class in which a new UNIT direction, or a new lattice point's edges, can be added without
killing any hom; a mixed class kills the homs whose kernel holds it — which is not a loss: the principle needs SOME
admissible hom to survive and EVERY colouring to be additive, and a smaller family is a smaller target (fewer Kempe
components to close, D3). Measured at the subplan (S6): the free count on the seed and which of its 21,787
non-adjacent pairs sit in free classes.

**D3 — the Kempe obstruction to additive rigidity, exact (the stub's coset-component condition, with its mechanism
corrected).** Let c_φ be an admissible additive colouring, a ≠ b colours, c = a − b, and K a component of the
{a, b}-subgraph (edges = units u with φ(u) = ±c; K lies in one coset of Λ_c^φ = ⟨u : φ(u) = ±c⟩, M56 §M1.5).
(i) The swap a ↔ b on K is a proper colouring (Kempe). (ii) A colouring is additive in Fischer's sense iff its
same-colour relation on S is induced by a subgroup — in particular it is TRANSLATION-INVARIANT: p − q = r − s ⟹
(c(p) = c(q) ⟺ c(r) = c(s)). (iii) **The witness of non-additivity:** if the {a, b}-subgraph has two components
K₁ ≠ K₂ with p ∈ K₁, p' ∈ K₂ of the same colour, and S holds a pair (r, s) with r − s = p' − p and r, s ∉ K₁ (both
in a third colour class, or both in K₂ — any such pair is same-coloured, since p' − p ∈ ker φ), then the swap on K₁
separates p from p' and leaves r, s equal: not additive, by (ii). (iv) Hence, on any chunk rich enough to hold such a
pair at the relevant difference (every chunk of interest): **additive k-rigidity requires every {a, b}-subgraph of
every admissible hom's colouring to be CONNECTED** — a lattice-and-graph condition with no colourings enumerated, and
the stub's version corrected: the swap on ONE WHOLE coset-intersection is already non-additive when the subgraph has
another component (the grid ball at 4 under the 𝔽₂²-hom (x mod 2, y mod 2): swapping one even row separates
(0, 2j) from (0, 2j + 2) while (0, 2j + 2), (0, 2j + 4) stay equal); swapping EVERY OTHER coset is additive again
(it is the ℤ/4-hom 2x + y) — which is how U's six ℤ/4-type colourings and its two residue colourings are related.
(v) Instances. Hexagonal lattice, the residue colouring at 4: Λ_c is a line (φ(u) = c on exactly one direction), so
every ball of radius ≥ 2 has parallel same-pair lines, disconnected {a, b}-subgraphs, and non-additive 4-colourings
by one swap — **no hexagonal ball of radius ≥ 2 is additively 4-rigid** (derived; P1″). K-fabric U: M56 measured
Λ_c^φ ⊊ Λ (2,321 pairs separated by the sublattice mechanism) — disconnected, not rigid, as the dial said. The
Moser spindle: its {a, b}-subgraphs ARE disconnected (the hub and a far apex share a colour with no path between
them) but a seven-point chunk may lack the untouched pair (r, s) — (iv) does not decide it, and P1 stays a
measurement. At five colours (ℤ/5, c ∈ {±1, ±2}): connectivity needs the units with φ(u) ∈ {±c} to span Λ (index 1)
AND to connect S — the **design condition**, checkable per hom in milliseconds (`kempe --components`). (vi) The seed:
its unit part is 4-colourable (Theorem B), so its 5-colourings include every 4-colouring with a fifth colour anywhere
— nowhere near additive; the cheats do the killing, and the 17 non-additive colourings of the {1, 2}-seed at defect
1–2 are single- or two-vertex swaps the cheats happen to allow (B2 checks each is one Kempe swap from one of the 18;
FS-2's P3, folded here at zero cost).

**D4 — the richness dial, derived before it is read.** A chunk loses its ℤ/5-homs two ways: a unit vector enters 5Λ
(L1, `obstruct` names it) or the hyperplane cover closes (every functional on 𝔽₅^r vanishes on some unit class).
For s unit classes in general position the expected number of surviving functionals is 5^r·(4/5)^s, which vanishes
past s ≈ 7.2·r: the 1581 (r = 16, 67 direction classes → ~134 signed) sits at the edge and keeps ~3,000 by structure,
Heule-510 (r = 8) keeps 96. Growing a chunk adds directions faster than rank (the closure folds: M41's 32 % fusion),
so the count falls to zero at some radius — that radius, per field, is the principle's ceiling. **The tension the
dial measures:** richness kills homs (D4) while sparseness leaves disconnected Kempe subgraphs (D3) — the principle
lives where a SMALL nonzero family has connected {a, b}-subgraphs; Exoo–Ismailescu's G (18 homs, every subgraph
closed by cheats) is the one point we hold. Directions in FREE classes (D2) connect subgraphs without killing homs:
the constructive move, if any exists inside a lattice — the norm-1 vectors of Λ(X) not yet used as edges (a finite
set for a rank-4 lattice) are the in-lattice design room, and S6 counts them on the seed.

**D5 — the additive kill census, derived.** A point p added to X with unit neighbours N(p) ⊆ S kills a colouring c
iff c(N(p)) uses all k colours (A1 at a blind point — the M49 kill mechanism). For an ADDITIVE colouring: if p is an
in-lattice point (p − p₀ ∈ Λ) then φ(p − p₀) is its own colour and no neighbour wears it (φ(p − y) ≠ 0 for every
unit p − y ∈ Λ) — **an in-lattice point never kills an additive colouring by coverage**; it can only kill the hom
itself, by a new unit vector p − y landing in ker φ (admissibility), which is D2's class question. If p is
out-of-lattice in a NEW direction (p − p₀ ∉ ℚΛ), φ extends with one free value g and survives iff some g avoids
{φ(y) : y ∈ N(p)} — exactly the rainbow condition, the same as for any colouring; if p − p₀ ∈ ℚΛ ∖ Λ the extension
must satisfy φ(m(p − p₀)) ∈ m·G (always, for m coprime to k). So the census scores a pool point by (kills over the
sampled non-additive colourings, kills over the additive family), with the additive half read from Λ alone. **The
descent, re-read:** its in-field halo points were all in-lattice (T13/T14: parent + ladder unit), so they never
killed an additive colouring — the loop was pushing toward the additive family exactly as the principle prescribes;
it could not arrive because inside K the unit part is 4-colourable, and a 4-colouring with one fifth-coloured vertex
has no rainbow neighbourhood anywhere an in-lattice point can reach; killing ALL of those is 4-tightness at every
neighbourhood, i.e. the χ(unit) crossing (G37, in the additive language). The census is therefore only meaningful
on a 5-chromatic unit part — W — and that is where B4 runs it.

### S2. Registered predictions, sharpened (committed before S6's scratch checks run)

| # | prediction | basis | confidence |
|---|---|---|---|
| P1 | the Moser spindle is additively 4-rigid: every one of its 4-colourings up to palette is the partition of a ℤ/4- or 𝔽₂²-hom of its rank-4 lattice | D3 (iv) does not apply (no untouched pair); the hom family is rich (both group types) | medium |
| P1′ | the hexagonal ball of radius 1 (7 points) is additively 3-rigid (one colouring) and additively 4-rigid | tiny colouring spaces | medium |
| P1″ | no hexagonal ball of radius ≥ 2 is additively 4-rigid, and the first non-additive colouring found is a single-line Kempe swap of the residue colouring | D3 (v), derived | high — settled by derivation, measured as a control |
| P2 | the 122-core, the 588-core and the seed's unit part each have non-additive 4-colourings, and for each the first one is a Kempe swap of a residue colouring on a component that is not the whole {a, b}-subgraph | D3 (iv)–(v); M56's Λ_c^φ ⊊ Λ on U | high on existence, medium on the swap being the first found |
| P3 | on the seed, for each of the 29 alone-essential cheats e, every separating colouring of H − e has additive defect ≤ 3; and the unit ∪ 252-cheat object (M49's ddmin survivors) has every colouring at defect ≤ 3 under a 5,000-colouring cap | the cheats are individually redundant (M49); the 17 non-additive colourings sit at 1–2 | medium-low |
| P4 | the 1581's gen-1 closure loses its last ℤ/5-hom on a ball about the origin pivot of fewer than 3,000 points, by the hyperplane cover (no unit vector in 5Λ); W ∪ its depth-2 cross lattice likewise below 3,000 points | D4: directions grow faster than rank | low |
| P5 | W's depth-one partner points (the 63 + 71 in-field cross points) kill fewer than 5 % of the 200 sampled colourings each, and no additive one; the depth-two pool's best point kills under 20 % | D5; G40 (thin material) | medium |
| P6 | on the seed's UNIT part, every one of the 18 admissible ℤ/5-homs has all ten {a, b}-subgraphs disconnected; each of the 17 non-additive colourings of the {1, 2}-seed is exactly one Kempe swap (component size 1 or 2) from one of the 18 | D3 (vi); defects 1–2 | medium-high |
| P7 | the free classes of 𝔽₅⁴ under the seed's 18 kernels are exactly 𝔽₅×·S₅ (72 classes) — no free class outside the scalar multiples of unit classes | the kernels are 18 of 156 hyperplanes; a non-multiple class has 31 hyperplanes to hide in | medium-low |

Jackpot and failure clauses: the stub's §6 stands verbatim. One addition: **if P1 is refuted** (the spindle has a
non-additive 4-colouring) the four-colour bridging case has no rigid bed at all, and B1 records where the smallest
rigid chunk is (the triangle, K₄ − e) before anything at five is asked.

### S3. The phases, re-shaped

| phase | what | reads |
|---|---|---|
| 0 | S1 (done); S6 scratch: the spindle's 4-colourings vs its additive family, the seed's free classes, the component census on the hex ball at 4 and on the seed's 18 homs at 5, the 17 non-additive seed colourings as swaps | P1, P6, P7 (scratch; phase A reproduces under controls) |
| A | kernel: burn the eight `sorry`s of `AdditiveRigid.lean` (D1), gate; instrument: `rigid`, `free`, `kempe --components`, `defect --trend`, `kill-census`, the `--hexball R` and `--ball R --centre i` stage restrictions, loaders for the 122-core / 588-core / the gen-1 closure / the depth-2 F₂₄₇ stage; every subcommand's control seen red first | — |
| B1 | the bridging case at four colours: spindle, hex balls r = 1, 2, 3 (at 3 and 4), 122-core, 588-core, the seed's unit part — `rigid` (complete where small, capped else) and `kempe --components` on each | P1, P1′, P1″, P2 |
| B2 | the seed at five: `free`; `kempe --components` on the 18; the 17 as swaps; the 29 single-cheat removals' separating lists (M49's exact lists) through `defect --trend`; the 252-cheat object's colourings under a cap | P3, P6, P7 |
| B3 | the richness dial: balls of growing radius in the gen-1 closure (`build/m31-closure-gen1.pts.json`) and in the depth-2 F₂₄₇ stage (`data/m55/W-plus-cross-depth2.json` with the exact `cross2` coordinates) — `homs --k 5` by SAT (capped) and `obstruct` per radius | P4 |
| B4 | `kill-census` on W with its depth-one pool (the in-field cross points) and the depth-two pool, against the 200 sampled colourings and the 432 additive ones | P5 |
| C | close: gate, `data/m57/` + README, the Frontier, the re-ranked frontier set (FS-2 is partly answered by B2's swap reading — re-rank it on that) | |

### S4. Costs (desktop)

Rank-≤ 4 lattice questions: milliseconds. The seed's 35 colourings: 255 s (M56). `rigid` at four colours on the
122-core: the colouring space is > 20,000 (M49) — capped at 2,000 sampled colourings, and ONE non-additive colouring
settles `not-rigid`; the `capped` verdict is not a rigidity claim. The component census: a BFS per (hom, colour pair)
— seconds on any object. The richness dial: SAT homs at rank 16–32 over 100–1,000 unit classes, seconds to a minute
per ball, ten radii per field: an hour. The kill census on W: 200 colourings × ~9,400 pool points × neighbourhood
lookups: minutes. Nothing here wants the server.

### S5. Settled at the subplan

| decision | choice | alternative | why | confidence |
|---|---|---|---|---|
| the additivity in the kernel | the weakest: constant on cosets of some H ⊇ k·V, on an explicit vertex set S | Fischer's (a hom into a group of order k) as the hypothesis | it is all the reduction consumes; the bridge lemma carries the stronger notion into it; S explicit because V is the lattice, not the chunk | high |
| the drawing | an arbitrary `dr : V → ℂ` with unit edges | an affine embedding of the lattice | the theorem never uses affinity; least hypotheses | high |
| D3's mechanism | the connected-{a, b}-subgraph condition (iv) with the untouched-pair witness (iii), replacing the stub's "proper part of a coset" | the stub's version | the grid computation (iv) shows a whole-coset swap is already non-additive; the stub's condition was neither necessary nor sufficient | high |
| what `rigid` decides | complete enumeration below a cap: `additively-rigid` / `not-rigid: n of N`; above the cap only `not-rigid` (one witness) or `capped` | a sampler's "all sampled additive" as evidence of rigidity | G21: a capped negative is a statement about the sample | high |
| FS-2's D3 (the seed's Kempe graph) | folded into B2 as the 17-as-swaps check | left to FS-2 | the 35 colourings are in hand and the check is minutes | high |
| the jackpot certificate | the pair's forcing by refutation (LRAT on the spindle union), the reduction theorem as the statement only | certify the additivity enumeration | additivity is a universal over colourings; only a refutation is kernel-checkable | high |

### S7. The instruments (all in `tools/additive.py`; every subcommand with a planted control seen red before its first real run)

| subcommand | what it computes | verdicts / record | controls (red then green) |
|---|---|---|---|
| `rigid --k [--cap N] [--with-cheats]` | SAT-enumerates proper k-colourings up to palette (blocking, vertex 0 pinned, first-occurrence canonical form), tests each for additivity by partition equality against the complete family (rank ≤ 8) or the linear test (above) | `additively-rigid` (complete, all N additive, each with its hom) · `not-rigid: n of N` (each non-additive colouring verified proper and re-tested; its defect and, if defect ≤ 2, whether it is one Kempe swap from an additive one) · `capped: 0 non-additive of N sampled` (NOT a rigidity verdict) | grid ball at 2 → rigid (1); hex r = 1 at 3 → rigid; hex r = 2 at 4 → not-rigid with the line swap; planted hexagon C₆ at 3 → not-rigid via `0 1 0 1 0 2`; the seed with cheats at 5 → not-rigid 17 of 35 (M56's numbers exactly) |
| `free --k [--classes …]` | the forced / free / mixed split of A_k's nonzero classes from the family; the stage's pairs by split | counts per split; `exact: false` when the family is a sample (free and forced are then both over-approximations, and say so) | grid at 2: free = the two odd classes; the seed at 5: 446/446 cheats free, the forced pair forced, 𝔽₅×·S₅ free |
| `kempe --components` | per admissible hom, per colour pair {a, b}: the component count of the {a, b}-subgraph on S, [Λ : Λ_c^φ], and whether an untouched same-difference pair exists for some cross-component same-colour pair (D3 (iii)); one swap per unstable pair, built, verified proper, tested non-additive | per hom `kempe-stable` / `kempe-unstable: m of C(k,2) pairs`, the witnesses in the record | hex r = 1 at 3: stable; hex r = 2 at 4, the residue hom: unstable with the swapped colouring non-additive by the linear test; grid ball at 2: stable |
| `defect --trend` | `defect`'s histogram plus the random baseline for (n, k) (random labellings under the best palette, 200 draws) beside it | histogram, mean, min, baseline | a random labelling reads at the baseline ± 2 %; a hom reads 0 |
| `kill-census --k --pool FILE --colourings FILE` | per pool point (exact frame): its unit neighbours in S, in-lattice or not (Λ-coordinates integral / rational / new direction), kills over the sampled colourings (rainbow neighbourhood), survival of each additive colouring (D5: in-lattice — a new unit in ker φ; out-of-lattice — the rainbow / extension condition) | the kill-count distribution, the top points, per-point records | a planted point rainbow under one colouring and not another; an in-lattice planted point kills no additive colouring; a planted out-of-lattice point with a rainbow neighbourhood under a hom kills it |
| stages: `--hexball R`, `--ball R --centre i`, `--core122`, `--core588`, `--gen1`, `--depth2` | the hex ball (exists as `--planted hex`; parametrized), a radius restriction of any stage about a vertex, and loaders for the four new objects in their exact frames | the stage header carries the restriction | fingerprints; the restricted stage's edge count re-derived |
| `tools/m57_richness.py` | the dial driver: radii × {`homs --k 5` (SAT, cap), `obstruct`}, one record per field | per radius: points, rank, unit classes, hom count (exact or ≥ cap), and at zero the mechanism | the 1581 itself reproduces M56's ≥ 2,981; Heule-510 its 96 |

### S6. Measured at the subplan (after the §S2 commit `b6b36de`; scratch scripts, no controls — phase A reproduces every number under controls before anything is claimed)

**(a) The four-colour bridging bed is EMPTY beyond the rhombus — P1 REFUTED.** The Moser spindle at four colours
has **16** proper colourings up to palette (brute force, 4⁷ labellings); its additive family is 48 homs = 12
partitions (ℤ/4 and 𝔽₂²), all 12 among the 16, and **4 colourings are non-additive**, each at defect 1 — e.g.
`0 1 2 0 1 2 3` (hub 0, both rhombi coloured alike, the far apexes 0 and 3). K₄ − e is additively rigid at 3 and 4
(one and two colourings, all additive); the hexagonal ball of radius 1 is rigid at 3 (one colouring) and NOT at 4
(11 colourings, 4 additive); radius 2 is rigid at 3 and, at 4, the residue hom's {0, 1}-subgraph has **three
components** (sizes 3, 3, 5: three parallel lines) whose single-component swap is proper and non-additive — D3 (v)
and P1″ confirmed on the mechanism; on that ball EVERY colour pair of EVERY hom (36 + 36) is disconnected.

**(b) The seed's free classes — P7 MET exactly.** Λ(H) has rank 4; H's 1,004 unit edges lie in **9 directions up
to sign** (three ζ₆-orbits: the ζ₆-image of every direction lies in Λ and is one of the nine), 18 signed classes mod
5. Of the 624 nonzero classes of 𝔽₅⁴: **forced 0, free 36 = 𝔽₅×·S₅ exactly, mixed 588**. The forced pair's
difference is the zero class (∈ 5Λ: L1). Non-adjacent pairs: 780 free (all 446 cheats, all 157 at d² = 9, all 11 at
d² = 16, and 166 others), 21,006 mixed, 1 in 5Λ. **The in-lattice design room is empty**: the norm-1 vectors of
Λ(H) with coordinates of absolute value ≤ 6 in the Hermite basis are exactly the nine edge directions — no unused
unit vector, so any new unit direction enlarges Λ and changes the family.

**(c) The sharpest necessary condition, found by reading the 17 (D3′ — VERTEX TIGHTNESS).** All 17 non-additive
colourings of the {1, 2}-seed are single-vertex recolourings of additive ones: 12 at defect 1 (one vertex, a
component of size 1 in the {x, y}-subgraph), 5 at defect 2 (two single-vertex recolourings, one of them sequential:
vertex 209 becomes free only after 207 moves). Every differing vertex lies in {207, 208, 209, 210, 211, 212, 213} —
the points Exoo–Ismailescu attached to G to make H. Call a vertex **loose** in a colouring when its neighbours use
fewer than k − 1 of the other colours (it can be recoloured), **tight** otherwise. Census over the 18 additive
colourings: on the {1, 2}-graph, 8 colourings have no loose vertex, 8 have one, 2 have two — **12 loose (colouring,
vertex) incidences, on six vertices of the attachment, = the 12 defect-1 colourings**; **on G (vertices 0–204 with
their own unit and cheat edges) there are 0 loose incidences in all 18 colourings** — G's rigidity IS vertex
tightness; on H's unit part alone 28–39 loose vertices per colouring, 102 vertices loose somewhere (the cheats'
job, in the principle's terms, is tightening: a cheat at 2u puts a fifth neighbour-colour on both ends). The Moser
spindle's twelve additive 4-colourings each have 2 or 3 loose vertices (the far apexes loose for the hub's colour, or
a whole rhombus loose for one colour) — its non-rigidity is looseness. **Derivation:** a loose vertex v in an
additive colouring f (missing colour y) gives the proper colouring c = f with v ↦ y, and c is non-additive whenever
S holds an untouched translate of (v, p') for some p' of colour f(v) (D3 (iii) with a size-1 component). Hence
**additive k-rigidity ⟹ every vertex tight in every admissible additive colouring** — per hom φ, the unit
vectors at v must cover G ∖ {0} under φ; in particular no admissible hom may be *thin* (φ(S) ⊉ G ∖ {0}), and the
minimum degree must be ≥ k − 1. This is a lattice computation (no colourings enumerated, no solver) and it is
CONTINUOUS: the loose-incidence count under the family is the gauge the stub asked for, solver-free, where the
defect gauge needs SAT-sampled colourings. Scored: **P6** first half MISSED literally (10 of the 180 (hom, colour
pair) subgraphs of the unit part are connected, 170 disconnected — component counts 1–16), second half MET for 12 of
17 (one swap) and MISSED for 5 (two single-vertex swaps); the 5 are Kempe-adjacent to a defect-1 colouring, so FS-2's
connectedness reading survives.

**(d) What the bed says about the milestone.** At four colours in K nothing beyond the rhombus is additively rigid
(P1 refuted; the failure clause fires: B1 records the tightness profile of the K-chunks rather than hunting a rigid
one). At five colours the one rigid object, G, is rigid by tightness, and tightness needs the cheats — the unit part
is loose at 102 vertices. So the principle's design question is exactly: **can unit material tighten every vertex
under every surviving hom?** — and the instrument for it is `tight`, run before `rigid`.

**Predictions re-registered on the scratch (P1 replaced; P8–P9 added; the rest stand):**

| # | prediction | basis | confidence |
|---|---|---|---|
| P1 (replaced) | no 4-chromatic K-chunk beyond K₄ − e is additively 4-rigid: the 122-core, the 588-core and U each have loose (vertex, hom) incidences under every residue colouring, at boundary vertices with fewer than three residue classes among their directions | (c); boundary degrees | high |
| P8 | on the 5-chromatic witnesses at five colours every additive colouring has loose vertices, more than 10 % of the vertices on each (Heule-510: 24 colourings; W: 432; the 1581: the 3,000-hom sample) | W's colourings at the random baseline; boundary vertices | medium-high |
| P9 | on every chunk the number of defect-1 non-additive colourings up to palette is at most the number of loose (colouring, vertex, missing colour) incidences, with equality on the seed (12 = 12) and on the spindle (4 < 30: palette collapse) | (c): each defect-1 colouring is a loose incidence | high on ≤, medium on the seed's equality being typical |
| P5′ (sharpened P5) | W's depth-one and depth-two cross points reduce the loose-incidence count of W's 432 additive colourings by under 5 % when adjoined (each point tightens only its own unit neighbours), and kill fewer than 5 % of the 200 sampled colourings | D5; (c) | medium |

## §M1. Domain modeling pass (2026-09-06, fresh invocation after the §S6 commit `30501cc`)

**M1.1 The object is a reconfiguration graph, and rigidity is a closure property.** The chunk's proper
k-colourings carry moves — single-vertex recolourings and Kempe swaps — and every obstruction S6 found is an
edge of that graph LEAVING the additive family A: a loose vertex is a Kempe component of size 1, a disconnected
{a, b}-subgraph a component of size ≥ 2. So "A is additively rigid" (A = the whole space) decomposes as "A is
closed under every move" (necessary, solver-free) plus "the move graph has no other component" (the remainder,
enumeration only). D3 and D3′ are one census: for each admissible hom and each colour pair, the components of the
{a, b}-subgraph; the **gauge** γ(X, k) := Σ over (hom, colour pair) of (components − 1), whose isolated-vertex
part is the loose-incidence count and whose remainder is the Kempe part; γ = 0 ⟺ A is tight and connected. On
the seed's unit part γ = 1,197 (from S6's histogram); on H's {1, 2}-graph the isolated part is 12 (= the 12
defect-1 colourings) and every size-≥ 2 swap is either the whole subgraph or lands on another additive colouring
(the 35 are complete, so no other non-additive colouring exists); on G, predicted γ = 0 (P10 below). Since
connected {a, b}-subgraphs imply every vertex has a neighbour of every other colour, tightness IS the size-1 face
of connectedness and needs no separate instrument. **The design principle, restated:** target γ = 0 first (lattice
and BFS, no colourings enumerated), rigidity second (`rigid`, where the space is enumerable). The four-colour bed
came out empty because γ > 0 on every K-chunk we hold, and that is a theorem for three-family material: a
ζ₆-orbit of unit directions hits each of the three nonzero residues of 𝔽₄ exactly once (ζ₆ acts on ℤ[ζ₆]/2 as a
primitive cube root of unity), so with ≤ 3 orbits (T13: the seed's and every descent object's three ladder
families) each residue class holds ≤ 3 directions and Λ_c^φ has rank ≤ 3 < 4 under either residue colouring — the
{a, a+c}-subgraphs lie in rank-3 slices, disconnected on any chunk of positive thickness. The 122-core and the
588-core have more orbits (seam-lattice words) and are computed, not derived.

**M1.2 Three forms of "additive", and which is the definition.** (i) *Implication*: constant on the cosets of some
H ⊇ k·V — equivalent to k·V-periodicity, which is the reduction's CONCLUSION; as a definition it makes the theorem
a tautology. The hom form with an arbitrary palette map is the same thing. (ii) *Iff*: the same-colour relation is
the trace of the coset partition of some H ⊇ k·V — Fischer's notion minus his order condition |V/H| ∣ k (never
read by the reduction; the family it admits is slightly broader — a coset colouring of V/H = 𝔽₅² on five
addresses whose differences hit all six lines has no functional injective on them, so it is not Fischer-additive
while being additive here — and the instrument's `additive` verdict, partition equality with an admissible hom, is
an instance). (iii) *Translation invariance* (p − q = r − s ⟹ (C p = C q ↔ C r = C s)) — the Kempe witness's
language, weaker than (ii) on a sparse chunk (no chain to add differences). **The definition is (ii)**; the
skeleton's `IsAdditiveOn` (implication form) is replaced.

**M1.3 The carrier is an address map, not a vertex set.** The chunk's points are addresses in a free abelian group;
the instrument's `point_coords` IS a map `Fin n → ℤ^r`. So the kernel statement takes `q : ι → V` and a graph on ι:
no `Set V`, no subtype, no `∈ S` hypotheses in any theorem, and the plane consumer
(`add_one_le_chromaticNumber_unitDistance_of_forces`) already quantifies over an arbitrary ι. V must be the
lattice (a free group of finite rank, where k·V has finite index): with V = ℂ, k·ℂ = ℂ and every additive
colouring is constant — the divisible ambient group is the wrong carrier, which is why the drawing `dr : ι → ℂ` is
a separate map and affinity in q is never used. Cross-component pairs: the instrument's per-component bases
correspond to an address group with a free generator per extra component, under which no cross difference lies in
k·V — the kernel takes whatever q is given, and the two readings agree. `Additive.lean` (M56) is the q = id case
and stays as it is; the reduction uses only its graph-free L1 lemma.

**M1.4 The reshaped skeleton (`Proofs/HadwigerNelson/AdditiveRigid.lean`, elaborates, eight `sorry`).**
`IsAdditive (q : ι → V) (C : Γ.Coloring (Fin k)) := ∃ H : AddSubgroup V, (∀ v, k • v ∈ H) ∧ ∀ a b, C a = C b ↔
q a − q b ∈ H`; `AdditivelyRigid q Γ k := ∀ C, IsAdditive q C`; `isAdditive_of_addMonoidHom` (H = ker φ, from
`C a = C b ↔ φ (q a) = φ (q b)` and k • G = 0); `IsAdditive.apply_eq` (L1); `forces_of_additivelyRigid`;
`add_one_le_chromaticNumber_unitDistance_of_additivelyRigid`; `six_le_…` (k = 5, numeral form). Spec on
Mathlib's graphs, no hand-rolled ones: `pathGraph 3` addressed by `i ↦ (i, 0)` in ℤ × ℤ is additively 2-rigid,
`Forces (pathGraph 3) 2 0 2` by the reduction (the `decide` on the address difference already passes), and
`3 ≤ χ(ℝ²)` from the unit drawing — the model of every hypothesis; the red: `cycleGraph 6` addressed by the identity
into `ZMod 6` (= `Fin 6`) at three colours with `0 1 0 1 0 2`.

**M1.5 The kill census is a family delta.** Adjoining a point p with unit vectors u_i = p − x_i (all in one coset
of Λ) gives Λ′ = Λ + ℤu₁, and A(X ∪ p) is computed from A(X) by cases on [Λ′ : Λ]: u₁ ∈ Λ (the family restricts to
the homs nonzero on the u_i); u₁ ∈ ℚΛ ∖ Λ of order m (each hom extends iff φ(m u₁) ∈ m·G — uniquely when m is
coprime to k); u₁ ∉ ℚΛ (k extensions per hom, the admissible ones those avoiding the rainbow). So the census is
`extend(A, p)` — one operation on one object — and its reading is the GAUGE DELTA γ(X ∪ p) − γ(X) alongside the new
family size, with the survival of sampled non-additive colourings (the rainbow condition) as the secondary column.
D5's kill counts were the shadow of this.

**M1.6 The richness dial's x-axis is the direction set.** The hom count of a chunk depends only on (Λ, S_k) — the
star {0} ∪ S has the same lattice as any chunk with those directions — so the dial is a function of the unit
direction set, filtered by the group's word length (the closure's generations), not of a ball's radius: the
"additive spectrum of the half-spindle group's orbit". Balls in the gen-1 closure and cross-lattice depths in F₂₄₇
are sampling paths through that function; each row reports (rank, |S_k|, hom count), and the radius is incidental.

| decision (domain pass) | choice | alternative | why | confidence |
|---|---|---|---|---|
| the target | Kempe-closure of the additive family (γ = 0), rigidity as its consequence | rigidity directly | closure is one solver-free census and every obstruction found is one of its edges; rigidity needs enumeration | high |
| the kernel carrier | an address map q : ι → V, graph on ι | a vertex set S ⊆ V with the graph on V | two membership hypotheses gone from every statement; matches `point_coords` and the plane consumer | high |
| the definition of additive | the iff form with H ⊇ k·V | the implication form; the hom form | (i) is the conclusion in disguise; the hom form needs an existential type; Fischer's order condition is not read | high |
| the gauge | γ = Σ (components − 1) with its isolated part named | loose incidences alone; the defect distribution | tightness is the size-1 face; one BFS census; solver-free where the defect needs SAT samples | high |
| the kill census | the family delta `extend(A, p)` and the gauge delta | kill counts | one operation on one object; the counts are its shadow | high |
| the dial's axis | (rank, |S_k|) with the radius incidental | the radius | the hom question is a function of the direction set | high |
| `Additive.lean` | untouched (q = id instance) | generalize its theorems to addresses | no consumer needs the address form of `not_forces`; a landed module | medium |
| the four-colour bed | γ > 0 on three-family K-material by rank (derived); the 122/588 cores computed | measured everywhere | one ζ₆-orbit per residue per family | high |

**P10 (registered by this pass):** γ(G, {1, 2}-graph, k = 5) = 0 — Exoo–Ismailescu's G is Kempe-closed under all 18
homs with its cheats as edges; and γ(H, {1, 2}) has isolated part exactly 12 with every size-≥ 2 component swap
additive or the whole subgraph (the 35 are complete). Confidence high on the second, medium-high on the first.

## §M2. Obligation modeling pass (2026-09-06, fresh invocation after §M1's commit `02969cb`)

### M2.1 The kernel — every leaf probed to its closing term (scratch copy `build/m57/AdditiveRigid-probe.lean`, green: no error, no `sorry`)

| leaf | closing term (the statement from which it is one line) | hypotheses it reads |
|---|---|---|
| `isAdditive_of_addMonoidHom` | `⟨φ.ker, fun v => by rw [mem_ker, map_nsmul, hk], fun a b => by rw [hC, mem_ker, map_sub, sub_eq_zero]⟩` | `hk`, `hC` (both directions) |
| `IsAdditive.apply_eq` | `let ⟨_, hk, hC⟩ := h; (hC a b).mpr (hab ▸ hk w)` | the ← direction and `k • v ∈ H` only |
| `forces_of_additivelyRigid` | `fun C => (h C).apply_eq hab` | — |
| `add_one_le_…_of_additivelyRigid` | `add_one_le_chromaticNumber_unitDistance_of_forces dr hdr hd hhalf (forces_of_additivelyRigid h hab)` | — |
| `six_le_…` | `by simpa using add_one_le_…` (the cast `((5+1 : ℕ) : ℕ∞) = 6` by `simp`) | — |
| `pathGraph_additivelyRigid` | via the local obligation `pathGraph_three_coloring_two : C a = C b ↔ (a.val + b.val) % 2 = 0` (9 cases by `fin_cases`, closed by `Fin.two_eq_of_ne_of_ne : x ≠ y → y ≠ z → x = z` on `Fin 2`, an 8-case `decide`); then `H = parity.ker`, `k • v ∈ H` by `generalize parity v = x; revert x; decide`, the iff by `fin_cases` + `decide` | `pathGraph_adj` |
| `three_le_…_of_pathGraph` | the plane corollary at `k = 2`, `a = 0`, `b = 2`, `w = (−1, 0)`, drawing `i ↦ (i : ℂ)`; unit edges by `fin_cases` over `pathGraph_adj` + `Complex.dist_eq`; `d = 2` by `norm_num`; `simpa` | — |
| `cycleGraph_six_not_additivelyRigid` | `hexColoring := Coloring.mk ![0,1,0,1,0,2] (by decide)`; `obtain ⟨H, hk, hC⟩ := h hexColoring`; `3 ∈ H` from `hk 1`; `(hC 0 3).mpr` gives `C 0 = C 3`; `absurd … (by decide)` | `k • v ∈ H` and the ← direction |

**The mutation audit, run on the definition.** (a) Delete `∀ v, k • v ∈ H`: `IsAdditive.apply_eq` loses `hk w` and the
reduction is unprovable (a colouring injective on addresses would be "additive" with `H = ⊥`); the hexagon red also
stops refuting. Load-bearing. (b) Delete the `→` direction of the iff: NOTHING in the reduction breaks (it reads only
`←`), and the hexagon red still refutes — so the hexagon does not pin the clause that keeps the definition from
being the conclusion in disguise. **A second red pins it:** at THREE colours the path's addresses never differ by an
element of `3 • V`, so every colouring is `3•V`-periodic and the implication form would call `pathGraph 3` additively
3-rigid; but `0 1 0` is no coset colouring — `C 0 = C 2` puts `(−2, 0)` in `H` (the → direction), `3 • (1, 0) ∈ H`, so
`(1, 0) ∈ H` and `(hC 0 1).mpr` gives `C 0 = C 1`, refuted by `decide`. `pathGraph_not_additivelyRigid_three` is in
the probe, green. (c) Replace `Fin k` by an arbitrary colour type: `Forces` is stated on `Fin k` and the composition
breaks — the vocabulary is the repository's, kept. (d) Delete `hhalf`: the spindle theorem refuses (its `hd` is exact,
`OneDefect.not_exists_dist_eq_and_dist_eq_one_of_lt_half`). Every hypothesis is read by some leaf.

**Prove / test / assume.** PROVE: the six theorems and the spec's rigidity (the path at 2). TEST (kernel-checked
concrete facts): the two reds, the `Forces (pathGraph 3) 2 0 2` example, `3 ≤ χ(ℝ²)` from the path. ASSUME (never in
the kernel): that a chunk's colourings are all additive — the untrusted enumeration's claim, consumed only as the
theorem's hypothesis; at a jackpot the certificate is a refutation.

### M2.2 The instrument's obligations (`tools/additive.py`; verify-as-control-flow: a check that fails is an assertion, never a log line)

| subcommand | proves about its own output (asserted) | tested (planted, red then green) | assumed (named in `claim_scope`) |
|---|---|---|---|
| `closure --k` | the components of each {a, b}-subgraph partition its vertex set and no subgraph edge crosses them; every swapped colouring is proper on the stage's FULL edge list (an improper swap is a catastrophe — the swap lemma is a theorem); non-additivity only by partition equality against a COMPLETE family, else `undecided`; γ = Σ (components − 1) recomputed from the listed components | the seed's unit part reproduces S6's 180-row histogram and γ = 1,197; the hex ball R = 2 at 4 gives the (3, 3, 5) line components with the swap non-additive; the planted disconnected chunk; G's {1, 2}-graph (P10) | the family's completeness (rank ≤ 8 enumeration; above, a SAT sample marks `exact: false` and γ is a LOWER bound) |
| `rigid --k [--cap N] [--with-cheats FILE]` | every enumerated colouring verified proper; additivity by partition equality (complete family) else per-colouring `undecided`; the verdict rule: `additively-rigid` iff the enumeration ended by UNSAT AND every colouring additive AND ≥ 1 colouring; `not-rigid: n of N` iff n ≥ 1 (complete or not); `capped` iff the cap was hit with 0 non-additive; 0 colourings = `vacuous` (χ > k, no rigidity claim) | the seed with cheats at 5: 35 / 18 (M56); the spindle at 4: 16 / 12; K₄ − e at 3, 4: rigid (1, 2); hex R = 1 at 3 rigid, at 4 not-rigid 7 of 11; the kernel's spec objects as instrument controls — `pathGraph 3` at 2 rigid, at 3 not-rigid, `cycleGraph 6` at 3 not-rigid with `0 1 0 1 0 2` among the non-additive (the kernel and the instrument agree on the same objects) | the solver's terminal UNSAT (completeness of the blocking enumeration) |
| `free --k` | at prime k, free ⊇ 𝔽_k×·S_k (asserted — a theorem); the three counts sum to k^r − 1; the stage's pairs each land in exactly one split | the grid at 2; the seed at 5 (36 / 0 / 588; 780 / 21,006 / 1) | family completeness (a sample over-approximates both free and forced, and the record says so) |
| `extend --point` / `kill-census --pool` | the case by [Λ′ : Λ] from `L.coords` (integral / rational of order m / None); in the in-lattice case NO additive colouring is killed by coverage (asserted — its own colour is free; the family shrinks only by admissibility); every extended colouring verified proper on X ∪ p; a sampled colouring killed iff its neighbourhood is rainbow, re-verified by attempting the extension | the hex ball plus an in-lattice point (0 additive kills, the restricted family); plus a new-direction point (the Moser twist of a unit: k − 1 admissible extensions per hom at one neighbour); a rainbow neighbourhood under a planted colouring → killed | the exact frame's unit verification of the pool's edges (M54/M55's cross-lattice files) |
| the richness driver | per row (rank, \|S_k\|, hom count exact-or-≥-cap); at zero the mechanism: `obstruct` fired (a unit in kΛ, exact) or the hom SAT's UNSAT | the 1581 reproduces M56's ≥ 2,981 and Heule-510's 96; the L7 witness chunks fire at the right exponents | the SAT's UNSAT at rank > 8 (a second encoding is run on the first zero row) |
| `--ball R --centre i` | the sub-stage's edge list re-derived from the exact frame (all pairs at exact dist² = 1 among the retained points) and asserted equal to the restriction of the stage's list; the sub-stage's fingerprint recorded | a ball that is the whole stage reproduces the stage's fingerprint | — |

### M2.3 Scoring — the evidence per prediction and the verdict rule

Verdicts: `met` · `met-in-substance` · `missed` · `vacuous` · `not-comparable` · `undecided`.

| # | evidence | met iff | met-in-substance iff |
|---|---|---|---|
| P1 (replaced) | `closure --k 4` on the 122-core, 588-core, U | each has γ > 0 with loose incidences under both residue colourings | γ > 0 by the Kempe part alone on some |
| P1′ | `rigid` on hex R = 1 at 3 and 4 | rigid at 3 (S6: yes) AND at 4 | — (S6 already: the 4-half MISSED — 11 colourings, 4 additive; scored now, reproduced in A) |
| P1″ | `closure --k 4` on hex R = 2, 3 | γ > 0 with the residue line swaps verified non-additive | — |
| P2 | `rigid --cap 2000` on the 122-core, 588-core, the seed's unit part at 4 | ≥ 1 non-additive each, the first found a single Kempe component swap of a residue hom | non-additive found but not a single swap |
| P3 | the 29 alone-essential cheats' separating lists (M49's exact lists, or re-enumerated by blocking, ~1 min each) through `defect`; the 252-cheat object under `rigid --cap 5000 --with-cheats` | every listed colouring at defect ≤ 3 | ≤ 5 |
| P4 | the driver on the gen-1 closure and the depth-2 F₂₄₇ stage | first zero row below 3,000 points, mechanism = cover | below 3,000 by a unit in 5Λ |
| P5′ | `extend` on W with the depth-one (63 + 71) and depth-two pools | max Δγ/γ < 5 % AND kills < 5 % of the 200 | one of the two |
| P6 | S6 (scored): first half MISSED (10 of 180 connected), second MET for 12 of 17 → **met-in-substance**; phase A's `closure` reproduces the histogram | — | — |
| P7 | S6 (scored): **MET**; `free` reproduces | — | — |
| P8 | `closure --k 5` on Heule-510 (24), W (432), the 1581 (sample) | loose fraction > 10 % of vertices in every colouring on each | on two of three |
| P9 | `closure` (loose incidences) vs `rigid` (defect-1 classes) on the seed with cheats, the spindle, hex R = 1 at 4, K₄ − e | ≤ everywhere AND equality on the seed | ≤ everywhere |
| P10 | `closure --k 5` on G's {1, 2}-graph and on H's | γ(G) = 0; H: isolated part 12 and no non-additive size-≥ 2 swap | G: isolated part 0 with every size-≥ 2 swap additive |

**The single jackpot path.** A `rigid --k 5` verdict `additively-rigid` (complete) on a UNIT-distance stage (no cheats)
that holds a non-adjacent pair with difference in 5Λ at distance ≥ 1/2 ⟹ HALT: (1) the enumeration re-run in the 3-bit
encoding with a different pinned vertex; (2) the pair's difference re-derived exactly (`L.coords` integral and ≡ 0 mod 5)
and its distance exactly; (3) the pair asked through `five_dial.py ask` (forced-equal, second encoding, JACKPOT file,
exit 3) — the kernel certificate is the refutation of the spindle union (the M34 bridge), the reduction theorem the
statement. The additivity census is never the certificate.

## §M3. Experience modeling pass (2026-09-06, fresh invocation after §M2's commit `35989b5`)

**M3.1 The verdict vocabulary — M56's words kept, three levels added, none confusable.** M56's pair words stand
(`forced-additively`, `separated-additively`, `kempe-separated:{sublattice,component}`, `kempe-forced`,
`not-comparable`, `vacuous`, `undecided`). New, at three levels: the STAGE (`rigid`): `additively-rigid` ·
`not-rigid: n of N` · `capped: 0 non-additive of N sampled` · `vacuous` (not k-colourable per the solver); the
FAMILY (`closure`): `family-kempe-closed` (γ = 0) · `family-kempe-open: γ = N` — per hom `kempe-closed` /
`kempe-open` (not `kempe-stable`: the concept §M1 named is closure, and `kempe-forced` is a pair word); per (hom,
colour pair) `connected` / `disconnected: c components`; per (hom, vertex) `tight` / `loose: missing {…}`. The
`free` split at the pair level: `forced-additively` (the zero class — L1) · `free` (every additive colouring
separates: the constraint costs the family nothing) · `mixed`; free ∪ mixed = M56's `separated-additively`.

**M3.2 Headlines carry population and conditioning in one sentence (G21).** Templates:
`[closure] EI-seed-unit k=5: γ = 1,197 over 18 additive colourings × 10 colour pairs (family complete, 72 Z/5-homs);
170 of 180 subgraphs disconnected (2–16 components), 10 connected; loose incidences L on M of 214 vertices; 170
swaps built, 170 proper, 170 non-additive (exact partition test)` — and when the family is a SAT sample the gauge
prints as `γ ≥ N (family incomplete: M sampled homs)`, never as a number. `[rigid] planted-moser k=4: not-rigid — 4
non-additive of 16 colourings up to palette (enumeration complete; family 12 partitions of 48 homs); defects {1: 4}`.
`[free] EI-seed-unit k=5: 624 nonzero classes → forced 0 / free 36 / mixed 588 (family complete; F5x·S5 = 36 ⊆ free);
21,787 non-adjacent pairs → forced-additively 1 / free 780 / mixed 21,006`. `[kill-census] W k=5: 134 pool points ×
family 432 × 200 sampled: γ̄ before 12.3 → after [11.9, 12.3] (Δγ̄ min −0.4 at point 57); sampled kills max 3 of 200;
family restricted at 13 points, extended at 0` — γ̄ = γ/|family| is the gauge when the family's size changes, and a
point that empties the family reads `vacuous`, not `γ = 0`. The richness driver's rows are `(rank, |S_k|, homs)` with
the radius an incidental column, and the first zero row names its mechanism (`obstruct` fired — exact; or the hom
SAT's UNSAT, re-run in a second encoding).

**M3.3 The jackpot line is a HALT, never a claim.** `rigid --k 5` reading `additively-rigid` on a stage with NO
cheats prints exactly:
```
[rigid] HALT — additively-rigid at five colours on a unit-distance stage. NOT a certificate. Before any claim:
  (1) python3 tools/additive.py rigid <stage> --k 5 --encoding 3bit --pin <another vertex>
  (2) python3 tools/additive.py free  <stage> --k 5 --pairs        # the 5Λ-pairs and their distances (need ≥ 1/2)
  (3) python3 tools/five_dial.py ask  <stage> --k 5 --pairs …      # the jackpot protocol: second encoding, JACKPOT file, exit 3
```
and its record has `jackpot_candidate: true` and no field a sweep reader treats as settled (no `verdicts` list in
M56's pair vocabulary); `claim_scope` says the verdict is the untrusted enumeration's claim, consumed by
`AdditiveRigid.lean` only as a hypothesis.

**M3.4 Breakdowns, designed.** `rigid` without `--cap` on a stage above 300 points applies cap 2,000 and says so in
the headline ("a capped verdict is never additively-rigid"). `--with-cheats FILE` with a fingerprint not the stage's
refuses naming both (M56's pattern); the record then says `edges_used: unit (1,004) + cheats (446)` and that the
family was filtered by admissibility on the cheat differences (automatic at prime k, not at 4). `extend --point`
with no unit neighbour in the stage refuses ("nothing to extend"). `kill-census` with a pool in another frame refuses
naming both frames. Silent non-errors forbidden structurally: a swap that is improper is an assertion (catastrophe),
never a skipped row; a BFS vertex set containing a third colour is an assertion; the `additively-rigid` verdict is
computed from `complete ∧ all_additive ∧ N ≥ 1`, so a cap cannot produce it.

**M3.5 The kernel surface.** Names: `IsAdditive` (Fischer's word; the docstring says "coset colouring along q" and
why the iff is the content) — no second name; `AdditivelyRigid`; `IsAdditive.apply_eq` (dot notation on the
hypothesis); `isAdditive_of_addMonoidHom` (the `of_` convention); **`isAdditive_additiveColoring`** (new, one line:
M56's `additiveColoring Γ φ h` with q = id IS additive here — the next lemma a consumer wants, stated in the
vocabulary for free); `forces_of_additivelyRigid` (what `exact?` returns for a `Forces` goal with rigidity in
context); `add_one_le_chromaticNumber_unitDistance_of_additivelyRigid` beside OneDefect's `_unitDistance_of_forces`
(k-generic family) and **`six_le_chromaticNumber_plane_of_additivelyRigid`** beside HexShell's
`six_le_chromaticNumber_plane_of_forced_pairs` (the χ ≥ 6 target family — renamed from `_unitDistance_`), with the
spec `three_le_chromaticNumber_plane_of_pathGraph`. No simp lemma: the definition is sealed and the API is the three
lemmas. The `Fin 2` helper is not in Mathlib (grepped) and is used once: inlined as a `have` inside
`pathGraph_three_coloring_two`. Docstrings: `forces_of_additivelyRigid` and the two corollaries say the rigidity
hypothesis is an untrusted enumeration's claim, never kernel-certified, and that the certificate of any
consequence is a refutation; each red's docstring names the clause it pins (`cycleGraph 6`: `k • v ∈ H` and ←;
`pathGraph 3` at three colours: →). Placement: `Proofs.lean` right after `Additive`; `scripts/Axioms.lean` an M57
block: the six theorems, `isAdditive_additiveColoring`, `pathGraph_additivelyRigid`,
`three_le_chromaticNumber_plane_of_pathGraph`, and the two reds.

**M3.6 `data/m57/README.md` — what a reader may conclude.** One table (artifact · stage · subcommand · derivation
instantiated · licence). The licence paragraph: *`additively-rigid` is the untrusted enumeration's claim (a SAT
blocking loop that ended UNSAT) — it licenses nothing by itself; the kernel consumes it as a hypothesis. `not-rigid`
carries a verified proper non-additive colouring — a CERTIFICATE that the stage is not rigid. γ is exact when the
family is complete and a lower bound when it is a sample; every `kempe-open` row carries a verified swapped
colouring, so γ > 0 with a verified swap is a certificate of non-rigidity, and γ = 0 proves nothing about rigidity.
`capped` licenses nothing. A `vacuous` richness row licenses "no additive k-colouring" only when `obstruct` fired
(exact); a SAT UNSAT is the solver's claim.*

**M3.7 The report to Kooshi at the close (house format; the findings so far, each with population and caveat).**
(a) *The four-colour bridging bed is empty beyond the rhombus.* The Moser spindle has 16 four-colourings up to
palette, 12 of them additive and 4 not (P1 refuted, S6, brute force over 4⁷); K₄ − e is the only additively 4-rigid
chunk found; the hexagonal ball of radius 1 already has 11 four-colourings with 4 additive. Caveat: rigidity at k = χ
with few colourings was the hope; even there a loose vertex appears at once. (b) *Exoo–Ismailescu's G is rigid by
vertex tightness, and H's non-additivity is exactly its attachment.* Over G's 18 additive 5-colourings not one vertex
is loose; H's seven attached vertices carry 12 loose incidences = its 12 defect-1 colourings, and its 5 defect-2
colourings are two single-vertex recolourings each. Caveat: measured on the {1, 2}-graph (cheats as edges); the unit
part alone is loose at 102 of 214 vertices — the cheats' job IS tightening. (c) *The design principle, restated:*
target Kempe-closure of the additive family (γ = 0: every {a, b}-subgraph of every admissible hom connected), a
solver-free lattice census; rigidity is its consequence when no other reconfiguration component exists; derived: on
three-family K-material the residue colourings' {a, b}-subgraphs lie in rank-3 slices, so γ > 0 always at four
colours. (d) *The reduction theorem is in the kernel* (eight leaves probed green; two reds pin its clauses; the path at
two colours is its non-vacuous model — χ(ℝ²) ≥ 3 from the unit path). Caveat: the theorem consumes rigidity as a
hypothesis; it certifies nothing about any chunk by itself. Decisions the close presents: (1) FS-2's seed half is
answered by B2 (re-rank it on the K-fabric half alone); (2) B4's design attempt runs only if the kill census refutes
P5′ (default: census yes, attempt no); (3) whether the richness dial's per-field ceiling changes FS-3's thickening
plan (know, do not decide).

| decision (experience pass) | choice | alternative | why | confidence |
|---|---|---|---|---|
| hom-level word | `kempe-closed` / `kempe-open` | `kempe-stable` (the stub) | the concept is closure; no prefix collision with the pair word `kempe-forced` | high |
| the gauge printed from a sample | `γ ≥ N (family incomplete)` | a number | a lower bound printed as a value is a lie a summary will repeat (G21) | high |
| the gauge under a changing family | γ̄ = γ/\|family\| beside γ | γ alone | a point that kills homs lowers γ for the wrong reason | high |
| the numeral corollary's name | `six_le_chromaticNumber_plane_of_additivelyRigid` | `…_unitDistance_…` | beside HexShell's `six_le_chromaticNumber_plane_of_forced_pairs`, the χ ≥ 6 family | high |
| the `Fin 2` helper | inlined `have` at its one use | a namespaced lemma | one use; a `HadwigerNelson.Fin.…` name misleads | high |
| `isAdditive_additiveColoring` | added (one line) | omitted | the next lemma a consumer wants, free in the vocabulary; ties M56's object to M57's definition | high |

## §R. Results (2026-09-06; every number from a record in `data/m57/`, every headline with its population)

### R0. The kernel and the instrument

**Kernel** (`Proofs/HadwigerNelson/AdditiveRigid.lean`, standard three axioms, `scripts/Axioms.lean` M57 block: 595 clean,
5 declared purchases; build OK, lint passed, no `sorry`): `IsAdditive q C` (the same-colour relation is the trace through
the address map q of the cosets of a subgroup H ⊇ k·V — the `↔` is the content), `AdditivelyRigid q Γ k`, the bridge
`isAdditive_of_addMonoidHom` and its M56 instance `isAdditive_additiveColoring`, `IsAdditive.apply_eq` (L1),
**`forces_of_additivelyRigid`** (the reduction), `add_one_le_chromaticNumber_unitDistance_of_additivelyRigid`,
**`six_le_chromaticNumber_plane_of_additivelyRigid`** (the target statement), the spec `pathGraph_additivelyRigid` with
`three_le_chromaticNumber_plane_of_pathGraph` (the unit path at two colours forces its endpoints equal by the
reduction; drawn at unit spacing, χ(ℝ²) ≥ 3 — the non-vacuous model), and the two reds `cycleGraph_six_not_additivelyRigid`
(pins `k • v ∈ H` and ←) and `pathGraph_not_additivelyRigid_three` (pins →: at three colours every colouring of the path
is 3·V-periodic, so the implication form would call it rigid, and `0 1 0` is no coset colouring). Every leaf closed with
the term §M2.1 recorded. **Instrument** (`tools/additive_rigid.py`, registered into `additive.py`: `closure`, `rigid`,
`free`, `extend`; the stages `--hexball R`, `--ball R² --centre i`, `--core122`, `--core588`, `--depth1`, `--depth2`;
17 planted controls green — the hex balls, K₄−e, the spindle's 16/12/4, the kernel's own spec objects (the path rigid at
2 and not at 3), the seed's 72/18 family after the cheat filter, its 12 loose incidences on 6 vertices, γ = 1,197 with
10 of 180 connected on the unit part, the 36/0/588 and 780/21,006/1 splits, the in-lattice and new-direction extension
cases). Drivers: `tools/m57_b2.py` (the seed at five), `tools/m57_richness.py` (the dial).

### R1. The bridging bed at four colours (P1 replaced, P1′, P1″, P2)

| chunk (frame) | additive family | γ | loose incidences (vertices) | Kempe part | disconnected / total | swaps non-additive |
|---|---|---|---|---|---|---|
| 122-core (field16) | 24 homs = 8 partitions | **200** | 115 (40 of 122) | 85 | 36 / 48 | 36 / 36 |
| 588-core (K8) | 8 partitions | **182** | 91 (55 of 588) | 91 | 47 / 48 | 47 / 47 |
| the seed's unit part (EI4) | 8 partitions | **126** | 58 (20 of 214) | 68 | 30 / 48 | 30 / 30 |
| hex ball R = 2 | 4 partitions | 36 | 6 (6 of 19) | 30 | 24 / 24 | 24 / 24 |
| hex ball R = 3 | 4 partitions | 60 | 6 (6 of 37) | 54 | 24 / 24 | 24 / 24 |

Per hom, every K-chunk is loose under BOTH residue colourings (the 122-core: 30 and 21 incidences; the 588-core: 9 and 7;
the seed's unit part: 13 and 13) and under every ℤ/4-type colouring — **P1 (replaced) MET**. P1″ MET (the hex balls'
line swaps, verified non-additive; every colour pair of every hom disconnected at R ≥ 2). P1′: rigid at 3 (one
colouring) MET, at 4 MISSED (11 colourings, 4 additive — S6, reproduced by the instrument). **P2**: `rigid --cap 2000` on
the three K-chunks returns `not-rigid: 2000 of 2000` — the solver's first two thousand four-colourings are ALL
non-additive, at defects 67–78 of 122, 143–153 of 588 and 128–147 of 214 — near the random baseline (≈ 0.73 n at
k = 4 is 89 / 429 / 156; the best palette of the 24 homs brings it down to these), not one of them a residue Kempe
swap: the existence half MET, the "first found is a single swap" half MISSED, and the reading is the same as W's at
five (M56 §R3): a SAT solver's colourings of K-fabric sit far from its additive family. The four-colour bed holds no
rigid chunk beyond K₄ − e, and the additive family of every K-chunk is Kempe-open by a wide margin.

### R3. The 5-chromatic witnesses at five colours (P8)

| witness | family | γ | loose incidences | loose vertices per additive colouring (min / median / max) | swaps |
|---|---|---|---|---|---|
| Heule-510 | 96 homs = 24 partitions (complete) | 3,014 | 2,306 on 284 of 510 | 84 / 91 / 98 of 510 (16–19 %) | 240 built, 240 non-additive |
| W (1,175, K(√247)) | 1,728 = 432 (complete) | 147,456 | 121,600 on 755 of 1,175 | 234 / 267 / 284 of 1,175 (20–24 %) | 4,320 built, 4,320 non-additive |
| de Grey's 1581 | a 300-hom SAT sample, census on 200 | ≥ 76,115 | 67,246 on 935 of 1,581 | 303 / 328 / 352 of 1,581 (19–22 %) | 2,000 built, 2,000 proper, all `undecided` (sampled family) |

**P8 MET** on all three: every additive 5-colouring of every witness is loose on a fifth of its vertices, and every
colour pair of every hom is disconnected (components 6–22 on Heule, 14–72 on W, 22–63 on the 1581). The additive
families of the witnesses are nowhere near Kempe-closed — the principle's necessary condition fails by three orders of
magnitude on the objects that are 5-chromatic, exactly where M56 read their colourings at the random baseline.

### R4. The family delta on W (P5′; `extend-W-core-8over3-k5.json`)

W's 71 depth-one cross points (M54's in-field glue points, K(√247)) all extend: **67 are in-lattice** (their first unit
vector lies in Λ(W)) and **4 have index 5** (u₁ ∈ ℚΛ ∖ Λ of order 5: each hom extends iff φ(5u₁) = 0, so a third of the
1,728 homs die — the family falls to 1,152 at those four points, and to 960 at two in-lattice points by admissibility).
The gauge per colouring, γ̄ = γ/|family| = 341.3 before, moves to [336.5, 343.7]: the largest fall, −4.8 (−1.4 %), is at
the index-5 points and comes from the family SHRINKING, not from tightening; the median move is +2.0 (a new point with
two neighbours is itself loose for two colours in every hom); the in-lattice points with the most neighbours move it by
−0.8 (point 14, ten neighbours) to −0.3. **The kills are a different story**: point 14 kills **110 of the 200** sampled
five-colourings (a rainbow neighbourhood under 55 % of them), point 4 (eight neighbours) 90, three more 10–40, the other
64 none — and, as D5 derived, **no in-lattice point kills an additive colouring by coverage** (the family is unchanged
at 65 of the 67). Scoring: **P5′ gauge half MET** (|Δγ̄| ≤ 1.4 % < 5 %), **kill half REFUTED** (55 % > 5 %). The reading:
the additive kill census separates the two things the descent's halos always did at once — a high-degree in-lattice
point kills the non-additive colourings whose neighbourhood it covers and leaves the additive family intact (the
principle's own move, at zero cost to the family), while the family's closure gauge is a global property that single
points barely move. Neighbour counts of the 71: 51 have two, 20 have three to nineteen; the killers are the latter.

### R7. Incidents (caught by controls or assertions; none moved a verdict)

1. **The sub-stage with no unit pairs.** `Chunk.pairs_at` (M56) filters to same-component pairs, so on an edgeless
   sub-stage (every point its own component) it returns nothing: the first Heule-510 dial read `edges 0` on all five
   balls INCLUDING the whole 510 (2,504 edges) — the control that caught it. Replaced by `unit_pairs` (float proposal,
   exact disposal, no component filter) in the dial and in `--ball`; the full 510 re-derives its 2,504.
2. **The 40-digit rounding boundary.** The depth-2 stage file holds 60-digit decimals; matching them to the exact
   candidates by equality of 40-digit renderings failed on one point whose 41st digit straddled a rounding boundary
   (every point matches its candidate at float tolerance; the assertion fired). Replaced by nearest-candidate matching
   confirmed in 70-digit arithmetic at 10⁻⁴⁰ with a 10⁻²⁰ uniqueness margin.
3. **Balls by point count on a dense closure.** The gen-1 closure's 1,581 points nearest the origin lie within radius
   0.34 and share no unit pair (the closure is dense near its centres); a dial indexed by count would have read
   "no homs" for the wrong reason. The `edges 0` column caught it; the dial is indexed by squared radius (§M1.6 already
   said the radius is incidental — the direction set is the axis, and a ball must be wide enough to hold one).
4. **`--seed` twice.** The stage flag `--seed` (Exoo–Ismailescu's seed) collided with the shuffle seed of `rigid`;
   argparse refused at registration. Renamed `--shuffle`.

### R2. The seed at five colours (P10, P3, P9, P6, P7; `b2-seed-k5.json`, `tools/m57_b2.py`)

**Exoo–Ismailescu's G is Kempe-closed and rigid, exactly.** On G's {1, 2}-graph (205 points, 966 unit + 423 distance-2
edges) the additive family is 18 colourings, and **γ = 0**: all 180 {a, b}-subgraphs connected, not one loose vertex,
and the complete enumeration returns 18 colourings, all additive — **P10 MET** in full (its H half too: γ(H) = 12 with
Kempe part 0 — every size-≥ 2 component is the whole subgraph — the 12 single-vertex swaps non-additive, and the
complete enumeration 35 = 18 additive + 12 at defect 1 + 5 at defect 2, M56's numbers). G's unit part alone: γ = 1,098,
loose on 96 of 205 vertices — the cheats do all the closing. **P9 MET**: loose incidences ≥ defect-1 classes on every
stage (the seed 12 = 12; the spindle 32 vs 4; the hex ball at 4: 6 = 6; K₄ − e: 4 vs 0 — its loose recolourings land on
the other additive colouring, the over-count the ≤ allows for). P6 and P7 stand as scored at S6, reproduced by the
instrument's controls.

**P3 MISSED, and the miss is the finding.** (a) M49's 19 separating lists (H − e for the refuser cheats e, 115
colourings, all proper on H − e) are bimodal: for 13 of the 19 edges every separating colouring lies within defect 5 of
the family (≤ 3 for five edges, 4–5 for eight), and for **six edges — (21,210), (56,168), (76,78), (78,168), (98,213),
(118,212) — H − e admits colourings at defect 79–90 of 214, the random baseline** (a 5-colouring with no additive
structure at all separates the pair once that one cheat is gone). (b) The 252-cheat object (M49's ddmin survivors,
which still force A = B) has a colouring space **above 5,000 up to palette** (the cap; H's is 35), in three regimes:
1,701 within defect 14 of the family (one of them additive), 2,167 at defects 16–28, and 576 at defects 94–105 — the
random baseline. So a forcing subset of the seed's cheats keeps the forced pair while losing additivity almost
entirely: **rigidity is sufficient for the forcing and far from necessary, on the seed's own subsets** — the 252-object
forces (205, 206) with thousands of non-additive colourings agreeing on the pair. The principle names a sufficient
condition; the seed H is its near-instance and G its exact instance; the descent's objects never were.

### R5. The richness dial (P4; `richness-{heule,f247,degrey}-k5.json`, `tools/m57_richness.py`; balls by squared radius about a centre, unit pairs re-derived exactly)

| field / object | ball r² ≤ | points | edges | rank | \|S₅\| | units in 5Λ | ℤ/5-homs | mechanism at zero |
|---|---|---|---|---|---|---|---|---|
| Heule-510 (about vertex 0) | 0.5 · 1 · 2 · 3 | 88 · 209 · 315 · 428 | 96 · 684 · 1,308 · 2,003 | 8 | 40 · 42 · 42 · 42 | 0 | **3,456** at all four | — |
| | 4 · whole (5.9) | 493 · 510 | 2,405 · 2,504 | 8 | 60 | 0 | **96** | — (M56's 96 reproduced) |
| F₂₄₇: W + its depth-one cross points, cumulative (the first m of 63) | — | 1,176 … 1,223 (m ≤ 48) | | 8 | 49 → 53 → 56 | 0 | 1,728 (m ≤ 8) → 960 (16–24) → 640 (32–48) | the cover |
| | — | 1,238 (m = 63) | 5,977 | 8 | 47 | **500** | **0** | a unit vector in 5Λ (exact) |
| F₂₄₇: the depth-2 stage (about W's centre) | 1 · 2 · 3 · 4 · 6 | 1,166 · 2,457 · 3,844 · 5,141 · 7,021 | 2,901 · 8,615 · 16,190 · 24,110 · 38,213 | 8 · 10 · 10 · 10 · 10 | 26 · 52 · 68 · 80 · 82 | 2,838 · 8,369 · 15,582 · 23,065 · 36,370 | **0** at every radius | a unit vector in 5Λ (exact) |

**P4 on F₂₄₇: MET-IN-SUBSTANCE** (the family dies below 3,000 points — at 1,238 — but by the exact obstruction, a unit
vector in 5Λ, not by the cover as registered). The mechanism is L7 realized at depth one: the depth-one cross points'
unit vectors, taken together, generate a lattice in which 500 of W's own unit vectors are 5-divisible (u/5 ∈ Λ), so no
hom into ℤ/5 can be nonzero on them — while any 48 of the 63 points leave a 640-hom family, and each point alone
leaves ≥ 960 (R4). In the depth-2 stage the phenomenon is total: 98 % of the unit vectors of every ball lie in 5Λ.
**Consequence for the principle:** on thickened F₂₄₇ material — the one construction that moved M54's redundancy dial
(FS-3) — the additive family is EMPTY from depth one on; the principle has no target there, and the design tension of
D4 (richness kills homs, sparseness leaves swaps) resolves against richness at the first thickening step. Heule-510
keeps a family to its last ring (3,456 homs on the inner 428 points, 96 on the whole); the de Grey dial: see below.

### R6. Scoring (verdicts per §M2.3)

| # | prediction | verdict | the measurement |
|---|---|---|---|
| P1 (replaced) | no 4-chromatic K-chunk beyond K₄ − e is additively 4-rigid; loose under both residue colourings | **met** | 122-core γ = 200 (residue homs loose 30, 21), 588-core 182 (9, 7), the seed's unit part 126 (13, 13); K₄ − e rigid at 3 and 4 |
| P1′ | hex ball R = 1 rigid at 3 and at 4 | **met at 3, missed at 4** | 1 colouring at 3; 11 at 4 with 4 additive |
| P1″ | no hex ball R ≥ 2 rigid at 4; the first non-additive is a line swap | **met** | R = 2, 3: every colour pair of every hom disconnected; the (3, 3, 5) line components; swaps non-additive |
| P2 | the K-chunks have non-additive 4-colourings, the first found a residue Kempe swap | **met / missed** | 2,000 of 2,000 non-additive on each, at defects 67–153 — none a single swap |
| P3 | H − e at defect ≤ 3 for the 29 essential e; the 252-object at ≤ 3 under a cap | **missed** | 13 of 19 lists within 5, six at 79–90; the 252-object: > 5,000 colourings in three regimes (≤ 14, 16–28, 94–105) |
| P4 | the family dies below 3,000 points by the cover (gen-1; F₂₄₇) | F₂₄₇ **met-in-substance**; de Grey: see the addendum | F₂₄₇: at 1,238 points (W + 63) by a unit vector in 5Λ; every depth-2 ball vacuous |
| P5′ | Δγ̄ < 5 % and kills < 5 % for W's depth-one points | **gauge half met, kill half refuted** | \|Δγ̄\| ≤ 1.4 %; point 14 kills 110 of 200 |
| P6 | all 180 subgraphs of the seed's homs disconnected; the 17 one swap each | **met-in-substance** (S6) | 170 of 180; 12 one swap, 5 two single-vertex swaps |
| P7 | free = 𝔽₅×·S₅ exactly (36) | **met** | 36 / 0 / 588 |
| P8 | every additive 5-colouring of every witness loose on > 10 % of vertices | **met** | 16–19 % (Heule), 20–24 % (W), 19–22 % (the 1581, sampled family) |
| P9 | defect-1 classes ≤ loose incidences, equality on the seed | **met** | 12 = 12; 4 ≤ 32; 6 = 6; 0 ≤ 4 |
| P10 | γ(G) = 0; H's isolated part 12 with no non-additive size-≥ 2 swap | **met** | γ(G) = 0, 18 = 18 additive; γ(H) = 12, Kempe part 0 |

Jackpot: not reached (no `additively-rigid` at five colours on any unit stage; the only rigid five-colour object is G, a
{1, 2}-graph). Failure clauses fired: "P1 refuted" (the four-colour bed is K₄ − e alone — recorded in R1); "P5′ refuted"
on its kill half (the census's kill column is M49's coverage kill with sampled colourings, not a new score — the
solver-free half, the gauge, is what the principle owns, and it barely moves).

### R8. What the milestone found, in four sentences

1. **Additive rigidity is a closure property, and its gauge is solver-free**: the additive family is rigid only if
   every {a, b}-subgraph of every admissible hom is connected (γ = 0; loose vertices are its size-1 face), and on
   Exoo–Ismailescu's G that is exactly what holds — γ = 0 and all 18 colourings additive — while H's 17 non-additive
   colourings are precisely its attachment's 12 loose incidences and their pairs.
2. **No unit-distance object we hold is anywhere near**: at four colours every K-chunk beyond the rhombus is
   Kempe-open (derived by rank for three-family material, measured on the 122- and 588-cores), and at five every
   additive colouring of every 5-chromatic witness is loose on a fifth of its vertices (γ = 3,014 / 147,456 /
   ≥ 76,115).
3. **Thickening kills the family before it could close it**: W's 63 depth-one cross points in F₂₄₇ generate a lattice in
   which 500 of W's unit vectors are 5-divisible, so the thickened stage has no additive 5-colouring at all (L7 at
   depth one), and each in-lattice point alone kills non-additive colourings without touching the family.
4. **The reduction theorem is in the kernel** with its two reds and the unit path as its model, and the principle it
   states is sufficient and far from necessary: the seed's 252-cheat forcing subset keeps the forced pair with a
   colouring space above 5,000, two thirds of it far from additive.

### R5 addendum — the de Grey dial (`richness-degrey-k5.json`, in flight at the close; rows as they landed)

The 1581's gen-1 half-spindle closure, regenerated exactly (24,065 points; balls about the origin pivot, unit pairs
re-derived exactly, the lattice on the distinct directions):

| ball r² ≤ | points | edges | distinct directions | rank | \|S₅\| | units in 5Λ | ℤ/5-homs |
|---|---|---|---|---|---|---|---|
| 1 | 11,053 | 36,288 | 329 | 32 | 243 | 0 | **≥ 300** (cap) |
| 2 | 16,597 | 72,239 | 333 | 32 | 247 | 0 | **≥ 300** (cap) |
| 4, whole | (running at the close; recorded when they land) | | | | | | |

**The contrast with F₂₄₇ is the reading.** De Grey's closure is crystalline: eleven thousand points within radius 1 span
only 329 unit directions (the half-spindle words permute a small direction set), the lattice has full rank 32 with no
unit vector 5-divisible, and the family survives — where W's 63 cross points, in 26 → 82 direction classes, made 500
units 5-divisible at once. FS-6's D1 is the derivation to run: a thickening keeps the family iff its new points are
in-lattice or new-direction and never rational of an order divisible by 5, and the two constructions sit on opposite
sides of that line. **P4 on de Grey: the family does NOT die below 3,000 points — MISSED at every radius measured so far**
(the 1581 itself keeps ≥ 2,981; its closure's inner 16,597 points keep ≥ 300).
