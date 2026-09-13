# Poros, 2026-09-13 (afternoon) — the FS-38 opening: attacking the brief before it is built on

*Written by a Poros pass advising the FS-38 subplan (planner: a de Bruijn agent; product owner: de Bruijn; principal:
Kooshi), with the brief `FS38-BRIEF.md` (scratch, uncommitted), its two pilots, and the morning pass
`plans/POROS-2026-09-13-wall-breaking.md` in context. Poros finds the question; it does not answer the problem. The
first job was adversarial — attack §1 and §2 of the brief while retraction costs one reply — and the record below is
ordered that way: what was checked, what broke, what the milestone's question is now. Every claim carries an address;
every hunch a falsifier; the ruling is a recommendation in four parts with its default; the domain (the kernel) decides
the findings. Depth units throughout: `depth` := v_𝔓(z − w) for the complex difference of a K-pair, 𝔓 the prime above
2 in K(i), 𝔓² = (2); for a rational squared distance d² this is v₂(d²). M53's `v2` column is this number
(`data/m53/rigidity-dial-it4.json`, `claim_scope`).*

## The situation survey on arrival

**The goal in the principal's words.** "Finding anything useful to get to 6 chromatic … or disproving it if we're at
that point" (Kooshi, 2026-09-13, quoted in the morning pass). The programme's standing bet, stated so it can be pushed
back on: *χ(F²) equals its best local bound wherever that bound is ≤ 6* (G48, FS-15), bold form χ(ℝ²) = 7.

**The record by provenance.** Committed: the kernel at 4c4b11e (846 declarations clean, five declared purchases);
`finitePlane_forces_iff` (`PlaneRotation.lean:186`, plane freedom at level one); `Forces.image`
(`ResidueObstruction.lean:64`); M60's residue obstruction; Theorem B. Uncommitted, in the scratchpad: the brief's
derivation D0 (Lemmas A, A′, B; Corollaries 1, 2), `pilot11.py` (the 11-adic recolouring at level 2), `pilot2.py`
(the 2-adic tower to level 7, solver verdicts, three samples per depth). On disk since this pass began: the planner's
`git mv` of the stub to `plans/FS38-residue-tower.md` and its re-pointed references.

**The instruments and their nulls.** The five-colour pair sweep — zero on every 5-chromatic unit-distance object,
sealed or 6-open. The residue filter (M60) — silent on 6-open fields by construction. Two new instruments this
morning: the fan-gap recolouring (a derivation, not a search) and the tower pilots (cadical via pysat, untrusted
refusals, verified models).

**The frame on its five axes, as the brief holds it, each with its address.**

| axis | the brief's commitment | address |
|---|---|---|
| object | the tower P_m = Cay(O/𝔭^m, S_m) at 11 (five colours) and at 2 (four colours), as colouring objects | brief §1 Corollary 1, §2 |
| question | "at which level does every k-colouring become constant on 𝔭^d-cosets" — answered NO at 11 by theorem, "depth ≥ 4 from level 5" at 2 by pilot | brief §1–§2 |
| discipline | graph homomorphisms and one recolouring lemma; ramified local rings at 2 | brief §1 ("graph-level, no rings"), §2 |
| audience | the kernel (a leaf module, an instance module) and the record (row 66, G54, G48 rewritten) | brief §3 |
| product | "the headline of the milestone is Corollary 2 and its kernel form, the 2-adic law is the second result" | brief §5, settled by the product owner |

## Evidence inventory

Each item read against an expectation written before the reading; the address is where the reading happened.

- Brief §1 Lemma A (a fan gap downstairs frees the whole fibre upstairs), re-derived from `Forcer.lean:41` and `Fan.lean:79` — read against: correct as stated, graph-level, no finiteness — surprised: no; the repaint is proper because a homomorphism sends N(u) into N(f u), and u′ ≠ u keeps its pulled-back colour
- Brief §1 Lemma B and A′ — read against: correct, with every hypothesis used — surprised: yes; the "forces-free P" hypothesis is redundant (a gap at v separates v from every x ≠ v by the same repaint — the planner's finding, confirmed here), and A′'s "whenever f is surjective" is never used (gaps pull back along any hom, and the induction needs no surjectivity)
- `Forces.image` (`ResidueObstruction.lean:64`), `unitQuadrance.map` (`UnitQuadrance.lean:82`) — read against: compulsions map forward; the cast ZMod (p^{m+1}) → ZMod (p^m) is a hom on `Nontrivial` alone — surprised: no at the time; amended after the obligation pass: fibres carry no edge for every level m ≥ 1, since a² + b² ≡ 0 (mod p^{2m}) is never 1 (mod p^{m+1}) — false at m = 0 (everything is 0 mod 1), where level 0 is one vertex with no edge and level 1 is K₄, so the level hom P₁ → P₀ does not exist; the kernel refused the m = 0 instance of `twoAdicLevelHom` before either reader did (planner, §M2)
- Brief §1 Corollary 1 (the tower at 11 pairwise free at every level) — read against: an induction along the casts — surprised: no as a statement; yes as a role: with the merged lemma it is an INSTANCE (P_m has a hom to P₁), not a step toward Corollary 2
- Brief §1 "Scope (a)", the kernel form of Corollary 2 — read against: the certificate graph mapped straight into `finitePlane 11` — surprised: yes; the brief routes through a ring R over ZMod 11 (`Adjoin 11 (ZMod (11^j))`), a level computed in `tools/`, and "drawn images DISTINCT in R" — none of which the merged lemma needs; the direct form is `∀ i ≠ j, ¬ Forces (edgeGraph n c.edges) 5 i j` for every Valid √7-free certificate with 11 ∤ D (`drawing_adj`, `UnitQuadrance.lean:235`, composed with `unitQuadrance.map`); converged independently with the planner
- Brief §1 "every 5-sealed field containing ℚ(√3,√11) has 11 usable of degree one", against `data/fplane/map.md` — read against: true for the multiquadratic table — surprised: yes, on the scope only; every 5-sealed row lists 11 first (K(√5), K(√23), K(√247), K(√5,√247), Heule's field), and the reason is arithmetic (a degree-one prime over K needs 3 and 11 both residues, i.e. p ≡ 11 (mod 12) and p a non-residue mod 11: 11, 83, 107, … with every plane from 59 up refusing five); but the brief says "every field", and a non-multiquadratic F ⊇ K may have a usable prime of residue degree 3 at 23–47 whose plane is undecided
- `pilot11.py`, run here — read against: 3 gapped vertices of the certified 11-table, 0 improper of 1,932,612, negative control > 0 — surprised: no; exactly that, control 55
- Brief §2 last paragraph, "depth 4 is … de Grey's own forced pairs (distance 4 and 4/√3, G9/row 26)", against `tools/degrey.py:9-11,216-228` and a run of `build()` reading the 16 basis slots — read against: the 791-half lies in K² = ℚ(√3,√11)² so the tower receives it — surprised: YES; S_a uses slots {1,3,11,33} but each half is an isometric copy of Y = S_a ∪ ρ₁₅·S_a minus two points, and Y uses {1,3,5,15,11,33,55,165}: the half lives in ℚ(√3,√5,√11)², where 15 ≡ 7 (mod 8) breaks the 2-adic wall, no conjugation-fixed prime above 2 exists in F(i), no residue map at 2 exists, and no hom into this tower exists. De Grey's distance-4 pairs are outside the tower's domain
- `data/m53/rigidity-dial-it4.json` (`classes`, `forced_pairs`, `claim_scope`) — read against: `v2` = v₂(d²); forced only at 64/9 and 64/3; zero at depth 4 — surprised: no; 16/3 (v2 = 4): 0 of 2,145; 4/3 and 4 and 12 (v2 = 2): 0 of 6,669 / 5,470 / 767; every forced pair at 64/9 or 64/3 (depth 6). This, and M56's F_true = 171 at depth 6 with every depth-4 pair separated (`plans/M56-arithmetic-of-tightness.md:405-412,726-734`), is the ONLY K-fabric retrodiction target the tower has
- Brief §2 table, the "no fan gap" column at levels 1–7 — read against: solver UNSAT with a control that the same ask can return SAT on THIS object — surprised: yes; the only SAT the gap ask ever returned was at 11 on a different graph (a control on the code path, not on the 2-adic object)
- Brief §2 table, the FORCED rows (depth ≥ 4 from level 5) — read against: a positive control at a cheap level — surprised: yes; none can exist below level 5 (K₄ and K₄ □ K₄'s Latin squares are pairwise free), so the forced side of the pilot has never been seen to fire on a known positive; 3 of 3 is complete only at the top depth of each level (𝔓^{m−1}/𝔓^m has three nonzero elements); the other depth classes are sampled 3 of 12 and 3 of 48
- Brief §2 units — read against: v_𝔓(z − w) = v_𝔓(d²)/2 = v₂(d²) for rational d², e(𝔓/2) = 2, f = 2, |O/𝔓^m| = 4^m — surprised: no; addendum: K(i) has TWO primes above 2 (g = 2), Galois-swapped by √11 ↦ −√11, so for non-rational d² ∈ K the depths differ and the fabric theorem reads "free at depth ≤ 3 at EITHER prime"; every record pair (d² ∈ ℚ or ℚ/3) agrees at both
- The common-gap ask at 11 (the planner's (3): a 5-colouring of UD(𝔽₁₁,2) with one colour absent from N[(0,0)] ∪ N[(1,0)]), run here, `scratchpad/fs38/poros/gap_and_p83.py` — read against: either outcome; the two share exactly two neighbours (x = 6, y = ±3) — surprised: no on the count (2), and the ask is SAT in 0.01 s, verified proper on every edge with colour 2 absent from the 22-vertex closed neighbourhood; control: forbidding colour 2 everywhere (four-colour the plane) is UNSAT as required. Rotations by norm-one elements are automorphisms transitive on the circle (`rotHom`, row 60), so one edge covers every edge by pullback
- The planner's independent double-gap run (its scratch `doublegap11.json`: colour 4 absent from N[(0,0)] ∪ N[(1,0)], verified on all 726 edges; a triple gap on a triangle's three closed neighbourhoods also SAT; the double gap SAT at 19 too) — read against: agreement with my colour-2 colouring on existence — surprised: no; two solver runs on two encodings agree, and the kernel's form should be one `decide` on one table
- The planner's level-4 fact (no aperiodic 4-colouring of P₄: forbidding the three periods 2√3·ζ₃^j, one ω-orbit at depth 2, is UNSAT) and its LRAT pricing (P₅ + edge (0, (4,0,0,0)) at four colours: UNSAT in 0.1 s, 4,068 LRAT lines; P₆ edges 6,680 and 9,659 lines; P₅ has 24,576 edges, P₆ 196,608) — read against: P₄'s freeness by ONE aperiodic table, and level-5 forcing solver-only — surprised: yes, twice; P₄'s freeness is a short LIST of tables through `Forces.eq_of_forall_exists_not_periodic`, and the level-5 forcing is KERNEL-grade through the existing LRAT pipeline (one refutation plus `Forces.map` along ω covers the ω-orbit), which is also the independent second encoding the FORCED rows needed
- A mechanism candidate for the 2-adic depth-4 forcing — "two fibre-mates at depth ≥ 4 share a common neighbourhood containing a triangle (or an odd cycle), which forces them equal at four colours by a two-line theorem" — tested at levels 3–7 on `pilot2.py`'s ring, `scratchpad/fs38/poros/triangle_and_ctrl.py` — read against: a triangle at depth ≥ 4 from level 5 and none below — surprised: yes; NO common neighbourhood at any level or depth contains a triangle or an odd cycle (all bipartite); |N(0) ∩ N(δ)| is 2 at depth 0 (the gluing pair, row 17) and exactly one third of the degree at the top depth (16, 32, 64 at levels 5, 6, 7). The forcing, if real, is global. Killed hunch, kept
- `data/fplane/spectral-p83.json`, `spectral-p131.json`, `spectral-below-600.json` — read against: six excluded by the spectrum at every usable prime of a 6-open field, or the six-colourability asked — surprised: yes, twice: at 83 (K(√7)'s first usable prime) `chi_floor` is 6 (Hoffman 5.743) and no `chi-p83-k6` record exists, so UD(𝔽₈₃,2) is exactly 6-chromatic iff it is 6-colourable, unasked; at 131 (de Grey's field's first usable prime) `chi_floor` is 8, and every other usable prime of K(√7) — 131, 167, 227, 479, 503, 563 — has floor ≥ 8, so under the programme's own conjecture χ(K(√7)²) is 6 exactly when UD(𝔽₈₃,2) is 6-colourable and 7 otherwise, and de Grey's field is predicted 7 outright
- Line-periodic six-colourings of UD(𝔽₈₃,2) (a circulant on ℤ/83 per direction, the shape of `fplane.py periodic`), run here — read against: unknown — surprised: no verdict; 42 directions degenerate (a circle point on the line), 42 UNSAT (solver), 0.5 s; my positive control first read "broken" and was a mis-specified EXPECTATION: `periodic-below-71.json` says `chi_circ = 6` at 11 (the certified five-colouring at 11 is not line-periodic), which is what my instrument returned. The 83 null carries that tool's scope: the cheap route does not give six there
- `plans/STUB-family-keeping-thickening.md` §H (i) / `plans/BACKLOG-FOR-OPUS.md` B9 — read against: the "central computation" asks forced-EQUAL pairs — surprised: no ("asked as forced-EQUAL pairs", line 22), so Corollary 2 answers every entry, as the brief says
- `CLOSED-QUESTIONS.md` §1.4 (Gibbs, 2018-05-02) — read against: a forced-equal ask at 5/3 on a graph over Heule's field — surprised: no; already answered by M60's congruence, and now by Corollary 2 for the whole graph
- `plans/` grepped for any five-colour forced pair on a unit-distance object over a sealed field — read against: none — surprised: no; M49's "G16 forced at five" and M57's rigidity are the Exoo–Ismailescu {1,2}-distance seed with its cheats
- The morning pass's hunch ledger (five hunches) and the stub's P1–P4 — read against: scorable now — surprised: yes; two hunches are killed by derivation and P1's second clause is refuted by the pilot; scored below
- `plans/FS38-residue-tower.md` §PA and §S0–§S9 (the planner's subplan, uncommitted) — read against: every correction sent folded in, nothing new wrong, every prediction with both outcomes reachable — surprised: yes, three times: P-A3 (no gap at 2) is written as an independent prediction with a planted control when at levels ≤ 5 it is a theorem of K3's LRAT (above); D0.4 carries `P.Colorable k` beside `DoubleSlack`, which implies it (the redundant-hypothesis smell the plan's own decision 3 names); and §S3's "complex form, not the pairs form" corrected THIS pass's own unit slip about 𝔓-integrality at 2. Not surprising and worth keeping: the §PA bonus (χ_Bor of the unit-distance graph over ℚ₁₁(√11) is exactly 5) is sound once the coset extension is stated through the canonical fractional part rather than chosen representatives; D-2's fibre picture (`s̄ ↦ H(s̄)` equidistributed over the three order-2 subgroups of the V₄ fibre) predicts |N(x) ∩ N(x+δ)| = deg/3 at the top depth, which this pass measured at levels 5–7 before D-2 was written
- The skeleton at 02d1fef (six modules, 48 `sorry` leaves, green through `./scripts/build.sh`), every declaration read against §S — read against: each statement is the §S statement, and every leaf sits downstream of what proves it — surprised: yes, once each way: `twoAdicFour_not_slack` is declared in `TwoAdicFour.lean` while its only proof (a gap at level 4 pulls back to level 5, slackness contradicts the LRAT-forced pair) lives in `TwoAdicFive.lean`, which imports it — a leaf upstream of its proof, sent to the planner; and `separated_iff_adj_of_doubleSlack` keeps `hc : P.Colorable k` with a correct reason (an edgeless P at k = 0 breaks the iff), so this pass's §S correction 2 was wrong and is withdrawn. Sound on reading: the LRAT leaf's shape, the kernel of the level map ({0, δ, ωδ, ω²δ}, four elements, decidable), the base-edge transport's direction, the certificate corollaries' hypotheses (M60's exactly), the level-one K₄ control
- The conditions of the last reading — read against: the brief written in a fresh session after the derivation, the pilots hours old, this pass at moderate context depth with every primary opened — surprised: no; the one thing not re-run here is the 2-adic pilot's solver rows (levels 5–7), taken as the brief reports them

## The anomaly hunt's residue

Three surprises survive verification, on three axes.

1. **Object.** The brief's §2 retrodiction target is outside the object's domain: de Grey's half is in ℚ(√3,√5,√11)²,
   wall-broken, and cannot map into the 2-adic tower over K(i). The honest target is M53/M56 alone — forced at depth 6,
   FREE at depths 4 and 2 — and against it the tower explains the depth-2 zero (theorem-grade), does not explain the
   depth-4 zero (the tower forces there), and merely permits depth 6. "Reproduces M56" is the pleasing fit (G21).
2. **Question.** The closure at 11 is larger than the brief states, and the brief's "dichotomy" is one-directional.
   With the common-gap colouring found, over every field with 11 usable of degree one the residue plane's entire
   arity-2 structure at five colours pulls back to every unit-distance graph: `Forces ↔ =` (the merged lemma) and
   `Separated ↔ Adj` (M60's adjacency of images plus the double repaint), so `not_colorable_of_fan` can never fire
   there (a fan's separable partners must be adjacent, and adjacent partners cannot be in a fan of a proper colouring).
   But nothing says "no gap ⟹ forcing": at 2 and 3 that is an observation, not a theorem.
3. **Product.** The programme's bet has a decidable digit at the field of its own object, and nobody has asked it:
   UD(𝔽₈₃,2) has spectral floor 6 and undecided six-colourability; every other usable prime of K(√7) has floor ≥ 8.
   FS-17 spends its desktop-day at 23, a prime usable over no field holding an object here.

## The commitments, given or chosen

| commitment | given / chosen | receipt or chooser | the milestone stands on it? |
|---|---|---|---|
| Lemma A (the repaint) and the merged lemma | given | re-derived here and by the planner from `Forcer.lean:41`, `Fan.lean:79` | yes |
| the gap at every vertex of UD(𝔽₁₁,2) at five colours | given | `pilot11.py` on the certified table (3 gapped vertices) + `addCayleyTranslate` | yes |
| the common gap at every edge of UD(𝔽₁₁,2) | given, solver-found and verified | `gap_and_p83.py`, ask 1, `rotHom` transitivity | for `Separated ↔ Adj` only |
| 𝔭-integrality of unit vectors (the hom from a field graph exists) | given for certificates with 11 ∤ D (`drawing_adj`); HAND for the field statement | row 57's open gap, G35's gate | the field-level headline |
| "every 5-sealed field ⊇ K has 11 of degree one" | given for multiquadratic F; chosen (asserted) for "every field" | `data/fplane/map.md`; the brief | the headline's scope |
| **the 791-half is K-fabric** | **chosen, and wrong** | G1's reading; `tools/degrey.py` says ℚ(√3,√5,√11) | the §2 "matter of course" |
| **"the 2-adic law" as a law about fabric** | **chosen** | the brief's §3; only the negative half transfers (`Forces.image`) | the second headline |
| the tower at 11 as the milestone's object | chosen, now moot | the stub; the merged lemma makes it an instance | no longer |
| the headline is Corollary 2 and its kernel form | given (the product owner settled it) | brief §5 | yes |
| T1's first digit is at 23 | chosen | FS-17's "smallest undecided prime" | the disproof branch |
| 6-open fields are untouched | given | no 5-colourable residue target exists there, by definition | the bearing on 6 |

## Said for a stranger (the object after the derivation)

*For a reader in graph theory who knows homomorphisms and nothing of this project.* Let f : G → P be a graph
homomorphism and C a proper k-colouring of P. Call a colour γ ≠ C(v) a *gap* at v if no neighbour of v receives γ. Then
every vertex u of G with a gap at f(u) can be repainted γ inside C ∘ f, so u is forced equal to no other vertex of G;
and if two adjacent v ~ w share a gap colour, every non-adjacent pair of G over (v, w) can be made monochromatic. So
whenever P has a gap at every vertex and a shared gap on every edge, the compulsion structure of every G mapping into
P at arity two is trivial: forced-equal pairs are single vertices and forced-distinct pairs are edges. The plane
UD(𝔽₁₁, 2) at five colours has both (Cayley symmetry carries one instance to all). Every unit-distance graph over a
number field with a usable degree-one prime above 11 maps into it. The finite planes at 3 (three colours) and the
clique at 2 (four colours) have no gap, and there forcing is observed. The stranger's words the room did not have:
*gap*, *shared gap*, *pullback of a compulsion structure*. Prior-art query in these words: "uniquely colourable /
rigid colourings of Cayley graphs", "vertex with a free colour under a homomorphism", "colourings constant on the
fibres of a covering" — the planner's §PA carries them.

## The hunch ledger — the morning pass scored, and this pass's entries

hunch: forcing-lives-at-a-level-of-the-prime
  claim: every k-colouring of a deep-enough chunk of a 𝔭-sealed plane agrees with a colouring of P_m for the least m at which P_m's k-colourings are all constant on 𝔭^{m'}-cosets; the four-colour forcing of K-fabric at depth 6 is the instance at 𝔭 ∣ 2
  basis: measured
  falsifier: the 2-adic tower P_m over K(i) at four colours admitting, at every m ≤ 8, a 4-colouring separating some pair of depth 6
  registered: 2026-09-13
  status: open, weakened (by: `pilot2.py` levels 5–7 — the tower forces depth 6 from level 7, so the falsifier did not fire; but the fabric U is FREE at depth 4 where the tower is FORCED from level 5, `data/m53/rigidity-dial-it4.json` 16/3: 0 of 2,145 — so chunk colourings do not all agree with P_m's, and "deep enough" is an escape clause until a K-fabric forces depth 4)

hunch: the-two-primes-differ-at-level-one-and-agree-higher
  claim: P₁ is a clique at 2 and pairwise free at 11, but for k = 5 some level m ≥ 2 at 11 has every 5-colouring of P_m constant on 𝔭-cosets
  basis: analogy
  falsifier: a verified 5-colouring of P₂ = UD(ℤ/121, 2) separating the origin from some 11·v
  registered: 2026-09-13
  status: killed (by: the fan-gap repaint, brief §1 Lemma A, and `pilot11.py` — the recoloured pullback separates a lift of (2,4) from its fibre-mates at level 2; Corollary 1 does it at every level; the falsifier fired by derivation)

hunch: the-sweeps-asked-the-wrong-object
  claim: a five-colour forced pair over a sealed field, if it exists, appears in deep 5-colourable fabric, not in a critical 5-chromatic object
  basis: analogy
  falsifier: a 5-colourable fabric over Heule's field whose 5-colourings separate every pair with 11 ∣ d² at every reachable depth
  registered: 2026-09-13
  status: killed (by: Corollary 2 — over every field with 11 usable of degree one no unit-distance graph carries a five-colour forced pair at any depth; the falsifier is now a theorem for every fabric, so the object was not wrong, the pair does not exist)

hunch: the-arena-null-is-thinness
  claim: ρ₆₃ and the 1581 read zero at arity 2 because both are near-critical, and a compulsion at five colours needs density
  basis: analogy
  falsifier: a dense 5-colourable object in a 6-open field that still reads zero over a complete pair sweep
  registered: 2026-09-13
  status: open, scope narrowed (by: Corollary 2 — on the SEALED objects (Heule-510/553, the two-core union) the zero is a theorem and thinness explains nothing; the hunch now speaks only of 6-open objects)

hunch: the-bridge-is-classical-and-unstated
  claim: χ(ℝ²) = sup_F χ(F²) over real number fields, by de Bruijn–Erdős plus a real-algebraic drawing lemma
  basis: prior
  falsifier: a gap in the transfer argument found when it is written for the kernel
  registered: 2026-09-13
  status: open (FS-39, untouched by this milestone)

hunch: P1-of-the-stub-depth-6-forced-depth-4-free
  claim: at 2 over K(i), four colours, some level m ≤ 8 has every 4-colouring constant on depth-6 cosets AND some 4-colouring separating a depth-4 pair
  basis: measured
  falsifier: the tower forcing depth-4 pairs at some level ≤ 8
  registered: 2026-09-13
  status: killed in its second clause (by: `pilot2.py` — depth 4 forced 3 of 3 at level 5, solver refusals, untrusted; its first clause holds from level 7). Note the miss's mechanism: the prediction was written from M53's fabric alone and would have been read as a match to de Grey's pairs had it held, which the domain check above shows would have been a category error either way

hunch: P2-P3-of-the-stub
  claim: at 11 level 2 the first Separated ask returns a model, and the fibre graph at 11 is empty
  basis: derived
  falsifier: a refusal on every class at level 2; a fibre edge at 11
  registered: 2026-09-13
  status: confirmed (by: derivation — Lemma A gives the model; a² + b² ≡ 0 (mod 11) has only the zero solution; `pilot11.py` prints 0 fibre edges)

hunch: K-fabric-can-force-depth-4
  claim: some finite unit-distance graph in K² forces a four-colour pair at distance 4/3, 4, 4/√3 or 4√3 (depth 4), as the tower permits from level 5
  basis: analogy
  falsifier: a derivation that every 4-colouring of every finite K² graph separates every depth-4 pair (then the tower's depth-4 forcing is a continuous-colouring artifact and "small-chunk effect" is dead)
  registered: 2026-09-13
  status: open (the two-sided form of the brief's "small-chunk effect"; M56's precedent — the additive family also over-forces exactly depth 4, P1′ — is a second reading, not evidence)

hunch: no-gap-at-2-below-level-6-is-a-theorem-of-the-level-5-refutation
  claim: "no 4-colouring of P_m has a fan gap" for m ≤ 5 follows from the kernel-checked forcing at level 5 by three kernel lemmas — a gap at level m ≥ 1 pulls back along the level map (a hom only from level 1 up — §M2) to every lift at level 5 (`FanGap.comap`), one gap on a Cayley graph gives slackness by translation, slackness gives pairwise freedom (D0.2 (a)), and P₅ has a forced pair (K3's LRAT); so the planner's P-A3 is a corollary of P-A2 at levels ≤ 5, needs no solver and no planted control there, and above level 5 is implied by P-A2 at that level
  basis: derived
  falsifier: a verified gapped 4-colouring of some P_m, m ≤ 5 — which would refute the LRAT-checked forcing, i.e. the kernel
  registered: 2026-09-13
  status: confirmed (by: derivation from D0.2, `FanGap.comap` and K3's statement; sent to the planner as §S correction 1)

hunch: the-tower-is-the-additive-yardstick-at-depth-4
  claim: for m ≥ 5 the forced set of P_m at four colours is exactly {depth ≥ 4} = F_add, the additive family's forced set on K-fabric (an additive colouring is a hom Λ → G with |G| = 4, kills 4Λ ⊆ 𝔓⁴O and factors through P₄ — a two-line theorem M56 holds only as a measurement, its P1′); the non-additive 4-colourings that free depth 4 on U factor through no level, so on the calibrated bed the tower is no sharper than the additive yardstick and the depth-6 forcing is invisible to it
  basis: derived
  falsifier: a level m ≤ 8 whose forced set differs from {depth ≥ 4} — a free depth-4 difference or a forced depth-3 one; or a non-additive 4-colouring of U that factors through some P_m
  registered: 2026-09-13
  status: open (measured equal through level 7 in `pilot2.py`; the additive half is a derivation, the "no sharper" half a reading)

hunch: no-gap-at-level-one-implies-forcing-somewhere
  claim: for (𝔭, k) whose level-one plane's k-colourings have no gap at any vertex, some finite unit-distance graph over the field forces a k-colour pair (observed at 2 with k = 4 and at 3 with k = 3)
  basis: measured
  falsifier: a (𝔭, k) with no gap at level one and a proof that no fabric forces — or the 2-adic level-4 plane being pairwise free at every level while being gap-free (then gap-freedom does not imply tower forcing either)
  registered: 2026-09-13
  status: open (this is the direction of the brief's "G54 dichotomy" that is NOT a theorem; the brief's phase D (iv) is the derivation attempt)

hunch: the-depth-4-forcing-has-a-local-witness
  claim: two fibre-mates at depth ≥ 4 in P_m (m ≥ 5) share a common neighbourhood containing a triangle or an odd cycle, which forces them equal at four colours
  basis: prior
  falsifier: a level and depth where the tower forces and every common neighbourhood is bipartite
  registered: 2026-09-13
  status: killed (by: `triangle_and_ctrl.py`, levels 3–7 — no triangle, no odd cycle, at any depth; common neighbourhoods are bipartite everywhere; the forcing, if real, is global, and phase D must look for a non-local witness)

hunch: UD-F83-is-exactly-six-chromatic
  claim: UD(𝔽₈₃, 2) is 6-colourable, hence exactly 6-chromatic (spectral floor 6), so χ(K(√7)²) ≤ 6 and the programme's conjecture predicts the ρ₆₃ arena's field is exactly 6-chromatic
  basis: prior
  falsifier: a refusal of six colours at 83 (solver, or α(UD(𝔽₈₃,2)) < 1,149 certified — 6,889/6 rounds up to 1,149)
  registered: 2026-09-13
  status: open (the line-periodic route is UNSAT in all 42 non-degenerate directions, `gap_and_p83.py`, same scope as `fplane.py periodic`; the equivariant route and α are unasked)

## Reading the wall

Where the work stopped: the brief's §2 fitted the tower to de Grey's pairs, which are not in the tower's domain, and
read its solver verdict as "the 2-adic law". What every reading held fixed: that a forcing verdict on the tower says
something about a chunk. It does not — only a FREE verdict transfers (`Forces.image`). The exact value: the fabric's
zero at depth 4 against the tower's forcing at depth 4 is the boundary where the two objects differ, and it is the one
number the brief's reading absorbs into an escape clause. The theorem at 11 is complete: pairwise free with a gap at
every vertex, shared gaps on every edge; nothing above level one was ever needed, and the tower there is an instance.
The dual: over a sealed field at five colours the pigeonhole is FREE (any six points in one residue class carry a
monochromatic pair) and every kill is IMPOSSIBLE in-field (`Separated ↔ Adj`) — so a 6-forcer's every kill lives in
a 6-open extension, which is exactly where the sweeps read zero and the residue instruments are blind by definition.

## The question cards

question: is-the-plane-at-83-six-colourable
  evidence: `data/fplane/spectral-p83.json` (`hoffman` 5.743, `chi_floor` 6); `spectral-p131.json` (`chi_floor` 8); `spectral-below-600.json` (K(√7)'s usable primes 131, 167, 227, 479, 503, 563 all floor ≥ 8; de Grey's 131, 479 floors 8, 13); no `chi-p83-k6*` under `data/fplane/`; `data/fplane/map.md` row K(√7)
  expected: the conjecture's first digit above five should have been asked at the first usable prime of the field that holds the programme's own 6-open object, and the record asks it at 23 (FS-17), a prime usable over no such field
  ask: is UD(𝔽₈₃, 2) six-colourable — equivalently, is it the first finite plane exactly six-chromatic — so that χ(K(√7)²) ≤ 6 and the conjecture predicts the ρ₆₃ arena's field is exactly 6?
  if six-colourable (a verified colouring): χ(K(√7)²) ≤ 6 by the finite-plane bound (the hand step of M58), the conjecture predicts 6 there and 7 for de Grey's field and K(√13); the ρ₆₃ line is the platform where a 6-forcer would confirm the bet's first digit, and the 7-level's arithmetic at 83 with six colours is the same G48/fan-gap question one level up (84 lookups decide its arity-2 half)
  if it refuses six (solver refusal, or α < 1,149 certified): L(K(√7)) ≥ 7, the conjecture predicts 7 for every 6-open field we hold, and no field yet named is predicted exactly 6 — the honest disproof branch loses its cheapest positive test and FS-17 at 23 becomes the only digit left
  answered by: run — the equivariant route first (`fplane.py equivariant` at (83, 6): colourings invariant under the order-84 rotation group up to a colour permutation, minutes), then α ≥ 1,149 by cube-and-conquer, then direct SAT (6,889 vertices, degree 84)
  cost: minutes for the equivariant route; a desktop-day for α; direct SAT unpriced — the 529-vertex plane at 23 ran four hours undecided
  hunch: six-colourable — basis prior, from nothing better than the floor's dip (71 → 7, 83 → 6, 107 → 7)
  falsifier: a refusal of six at 83, or α(UD(𝔽₈₃,2)) < 1,149
  rank: 1

question: does-any-K-fabric-force-depth-4
  evidence: `pilot2.py` (depth 4 forced 3 of 3 at level 5, solver); `data/m53/rigidity-dial-it4.json` (16/3, v2 = 4: 0 of 2,145 forced; 64/9: 163 forced); `plans/M56-arithmetic-of-tightness.md:405-412` (the additive family over-forces exactly depth 2 in M56's units = depth 4 here); `tools/degrey.py:216-228` (the 791-half is NOT in K², so G9's distance-4 pairs are not an instance)
  expected: if tower continuity were the mechanism of chunk forcing, the fabric would force at the lowest depth the tower forces, 4; it forces at 6 and is free at 4
  ask: does any finite unit-distance graph in K² force a four-colour pair at depth 4 (distance 4/3, 4, 4/√3, 4√3) — or does every K² graph separate every depth-4 pair, making the tower's depth-4 forcing a continuous-colouring artifact?
  if some K² graph forces depth 4: "small-chunk effect" is confirmed on its own falsifier, the tower's depth bound is tight for fabric, and phase D's derivation of "why depth 4" is a derivation about fabric
  if a derivation shows every K² graph separates depth 4: the tower's positive half is not a fabric law, the second headline shrinks to its negative half (no forcing at depth ≤ 3, theorem-grade from P₄ pairwise free), and the record's four-colour forcing at depth 6 keeps its old status — measured, mechanism unstated
  answered by: derivation — first: does every 4-colouring of P₅ factor through P₄ (phase D (iii)), and if so is the factoring forced by a structure a finite K² graph can lack; then a run on the deepest K² fabric held (M53's stages, M56's W) at the depth-4 classes, which M53 already did once and read zero
  cost: a day of derivation; the run is a re-ask of M53's dial at three classes, hours
  hunch: the fabric never forces depth 4 — basis analogy (the additive family's over-forcing at exactly this depth is the same shape and was already false on U)
  falsifier: one K² graph with a verified four-colour forced pair at 16/3, 16, 16/9 or 48
  rank: 2

question: is-no-gap-at-level-one-a-theorem-of-forcing
  evidence: brief §1 base cases (gaps at 11 and 19 at five colours, 7 at four; NONE at 3 with three colours, NONE at 2 with four); the rhombus forces at three colours over ℚ(√3) with images equal mod the prime above 3 (row 58, `exists_forces_of_unit_drawing_three`); K-fabric forces 171 pairs at four colours at 2 (M56); the brief's G54 wording "the level-one object's coverage slack decides whether a sealed field can force"
  expected: a dichotomy — gap ⟹ no forcing (theorem), no gap ⟹ forcing (the brief's reading) — but only the first direction has a proof
  ask: is "no gap at level one ⟹ some finite graph over the field forces a k-colour pair" a theorem, or an observation at 2 and 3 that a gap-free, forcing-free (𝔭, k) could refute?
  if a theorem: G54 is a dichotomy and the residue plane's gap structure is a complete classifier of which (field, k) can carry forced pairs; the 2-adic depth-4 forcing gets a derivation from gap-freedom
  if not: G54 is stated one-directionally, "3 and 2 have none, 11 has it" stays an observation, and the tower's positive half remains a solver record
  answered by: derivation — the brief's phase D (iv); the cheapest test object is the 2-adic level-4 plane, gap-free and pairwise free at the same time (if that holds at every level, gap-freedom does not even imply TOWER forcing)
  cost: a day, capped by the brief's own rule
  rank: 3

## The ruling (a recommendation, in four parts, with its default)

**The choice.** Open FS-38 as the product owner settled it, with three changes to what the brief builds. (1) The
headline theorem is the merged lemma and its certificate corollary in the DIRECT form — `∀ i ≠ j, ¬ Forces
(edgeGraph n c.edges) 5 i j` for every Valid √7-free certificate with 11 ∤ D, drawn straight into `finitePlane 11` —
with Heule-510 as the instance (M48/M54's measured zero becomes a kernel matter of course) and the Moser rhombus at
three colours over ℚ(√3) as the inhabited negative control where the gap hypothesis fails and forcing is real; no
ring R over ZMod 11, no level computed in `tools/`, no "distinct images in R". (2) The same module ships
`Separated ↔ Adj` from the shared-gap colouring found here (one 121-entry table plus `rotHom` transitivity), so the
milestone's honest headline is *the residue plane's arity-2 compulsion structure at five colours pulls back to every
unit-distance graph over a field with 11 usable of degree one* — and FS-16's 51 asks are answered in one stroke.
(3) The 2-adic result is stated at its proof's level: the negative half (no K-fabric forced pair at depth ≤ 3, from
ONE aperiodic 4-colouring of P₄ if the solver finds one, M60's exact shape) is the theorem; the positive half at
level 5 is KERNEL-grade through the LRAT pipeline (the planner's pricing: 4,068 lines, 0.1 s) and above level 5 a
solver record under phase A's controls, with a two-sided registered prediction (card 2), never "the 2-adic law" as a
fabric law, and never fitted to de Grey. Add one run outside the brief: the equivariant six-colouring ask at 83 (minutes), as the
milestone's out-of-sample instance of the programme's own conjecture.

**The alternative weighed.** The brief as written: Corollary 2 through the ring-R detour with a per-pair level,
"the 2-adic law" as the second result reproducing M56, de Grey's pairs as its retrodiction, 83 unasked and FS-17's
day spent at 23.

**Why this one.** The direct form is stronger (every pair, not the pairs whose images differ at some level), shorter
(one lemma, no tower), and removes a sub-phase and a hand-computed level; the shared-gap extension costs one table and
closes a ranked stub; the de Grey fit is a category error that would enter the record as a matter of course; and 83
is the one computation whose answer changes what the programme's conjecture predicts for the field it built an object
in, at a cost of minutes for the first route.

**Confidence.** High on (1) and (2) — both re-derived from the definitions here and by the planner independently, and
the shared-gap colouring is verified on every edge. Medium on (3) and on the 83 run — the one fact that would change
it: the equivariant route at 83 returning nothing and the α route priced above a desktop-day, in which case card 1 is
a stub for the next pass, not a phase of this one.

**The default.** If nobody acts, the planner ships the brief's form: the record carries "the tower reproduces M56"
with de Grey as its witness, the kernel carries a weaker corollary with a per-pair level, `Separated` stays open at
FS-16, and the first digit of the conjecture above five is sought at a prime that bears on no field holding an object.

## The honest disproof branch

The morning pass named two readings that would move the bet toward five: (a) the 11-adic tower never forcing at five
colours while the 2-adic tower reproduces the four-colour forcing, and (b) every plane at 23–47 five-colourable. (a)
is now half a theorem and half a permission: at 11 nothing forces at any level, by a reason that has nothing to do
with depth — the level-one colouring has slack — and at 2 the tower bounds fabric forcing to depth ≥ 4 without
reproducing the depth-6 fact. By the morning pass's own ledger the bet moves toward five; by its reasons it does
not, because Corollary 2 is exactly what the conjecture predicts for a sealed field (χ = 5 with trivial compulsion
structure), and it removes the constructive route THROUGH sealed fields, not the target. What is actually true after
this morning: a 6-forcer, if one exists, has every compulsion it uses in a 6-open field, where no residue plane is
five-colourable and every residue instrument is blind by definition; the only arithmetic the programme still holds
above five is the six-colour digit of the usable planes, and that digit is at 83 for K(√7), at 131 (floor 8, i.e. 7)
for de Grey's field. So the cheapest evidence either way is card 1: a six-colouring at 83 makes K(√7) the first field
the conjecture predicts exactly six and hands the ρ₆₃ line a target it can confirm; a refusal leaves the conjecture
saying seven everywhere it says anything, with no field predicted six and no instrument for five. Neither is a proof
of χ(ℝ²) ≤ 5, and the record still names no route to one.

## Corrections to the brief, with addresses

- §2 last paragraph, "depth 4 is … de Grey's own forced pairs (distance 4 and the antipodal 4/√3, G9/row 26)" —
  delete: the 791-half is in ℚ(√3,√5,√11)² (`tools/degrey.py:9-11,216-228`; `build()` slots include 5, 15, 55, 165),
  wall-broken, outside the tower's domain. The honest retrodiction target is M53/M56 only, and against it the tower
  explains depth 2, not depth 4.
- §1 Lemma B — the "forces-free P" hypothesis is redundant (a gap at v separates v from all x ≠ v); state the merged
  lemma (planner's (2)); A′'s "whenever f is surjective" is unused.
- §1 "Scope (a)" — replace the ring-R form by the direct form `∀ i ≠ j, ¬ Forces … 5 i j` via `drawing_adj` and
  `unitQuadrance.map` into `finitePlane 11`; drop `Adjoin 11 (ZMod (11^j))` and the level computed in `tools/`.
- §1 Corollary 2, "Let F be a field … Every 5-sealed field containing ℚ(√3,√11) has 11 usable of degree one" — state
  for "any field with a usable prime of residue degree one above 11 (or 19)" and note that every MULTIQUADRATIC
  5-sealed F ⊇ K qualifies at 11 (`data/fplane/map.md`); 19 is never degree one over K (3 is a non-residue mod 19);
  G43's "11 inert" means residue degree 2 (11 ramifies in K).
- §1 "(b) Nothing here touches `Separated`" — now false in the good direction: the shared-gap colouring exists
  (`gap_and_p83.py` ask 1), so `Separated ↔ Adj` over the same fields; FS-16 closes with this milestone.
- §2 table — the "no gap" rows have no control that the ask can return SAT on the 2-adic object; the FORCED rows have
  no positive control at any cheap level; the 3-per-depth samples are complete only at the top depth of each level.
- §3 "the 2-adic law is the second result" and G54 "the fan-gap dichotomy" — one-directional: gap ⟹ no forced pair
  is a theorem; no gap ⟹ forcing is an observation at 2 and 3 (card 3); tower FORCED ⟹ nothing for fabric.
- §3 "G31's 'the emptiness is not a field effect' reread (on sealed objects it IS a theorem now)" — agreed, and add
  the arity: it is a theorem at arity 2 and for the fan theorem's firing; arity-3 compulsions on sealed objects are
  not addressed, and on 6-open objects nothing is.
- §3 the 2-adic kernel piece — the planner's obstacle is real: `u * D = 1` fails at 2 (D even), and 𝔓-integrality of
  translated coordinates is row 57's hand gap; a re-based certificate in O/𝔓^{4+2a} with D·r_i = n_i checked there is
  a day of design; declining is honest and leaves the 2-adic negative half at M58's trust shape.

## Retractions counted

Requested of the brief (the product owner): six — the de Grey fit; Lemma B's redundant hypothesis (the planner's);
the ring-R kernel form; "every field"; "(b) nothing touches Separated"; "the 2-adic law" unqualified. Between the
planner and Poros: one — the planner withdrew de Grey's distance-4 pairs from its §S as the tower's retrodiction on
reading item A above (its count: 1); Poros retracted three, publicly: one on reading the planner's §S3 — "𝔓-integrality of
translated COORDINATES" at 2 is false (x = (z + z̄)/2 is not integral there; the complex number z is), which is why the
2-adic object is the complex form Cay(O/𝔓^m, S_m) and not `unitQuadrance (O_K/𝔭^m)` (its count: 1), and one on reading the skeleton — the request to drop `hc : P.Colorable k` from
`separated_iff_adj_of_doubleSlack`, which an edgeless P at k = 0 shows is needed; and one on the obligation pass — "no fibre edges at any level" and the gap-pull-up chain both silently assumed level ≥ 1, and the kernel refused the m = 0 hom (its count: 3). Requested of the
brief: seven (the six above plus the tower-as-a-step). Four retractions in two directions — a category error, a unit slip, a
redundant-hypothesis call that was itself wrong, a level bound the kernel enforced — is the G51 window doing its job; the modeling passes are where any
rest arrives, and a pass that changes a statement is read here again. Poros's own, private, before anything was sent: two — the 791-half first read as
K-fabric from G1 and killed against `tools/degrey.py`; a line-periodic "instrument broken" verdict that was a
mis-specified expectation, killed against `periodic-below-71.json`.

## What this pass held back, and why

- The 83 run is not started: one heavy job at a time is a hard rule and the planner's skeleton build has the machine;
  the equivariant ask is minutes and is the planner's or the product owner's to schedule.
- The fan/pigeonhole analysis is handed to the planner as SCOPE (Corollary 2 is arity 2; the fan theorem cannot fire
  over sealed fields at five colours), not as a phase — nothing in the frame says arity 3 is where a 6-forcer's
  compulsion lives.
- No opinion is offered on χ(ℝ²); the ledger holds the bets with their falsifiers and dates.
- The 2-adic pilot's solver rows were not re-run here; they are taken as the brief reports them, with their trust
  word, and phase A owns them.
