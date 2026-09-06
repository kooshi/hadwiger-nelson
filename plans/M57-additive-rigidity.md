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
