# FS-38 — The residue tower: a fan gap at level one frees every pair above it (opened 2026-09-13; stub minted the same morning by the Poros wall-breaking pass, `plans/POROS-2026-09-13-wall-breaking.md`)

> **Reading order for the implementer.** §PA and §S below are the plan; §M1–§M3 are the modeling passes; the skeleton is
> listed in §S10 and lives in `Proofs/HadwigerNelson/FanGap.lean`, `TwoAdicTower.lean` and `Instances/FanGap11.lean`,
> `Instances/FanGap19.lean`, `Instances/TwoAdicFour.lean`, `Instances/TwoAdicFive.lean`. §1–§8 are the stub as minted;
> §4–§6 of it are **superseded by §S** (the derivation D0 decided the stub's phases B/B′ before any run, and phase C is
> replaced by the certificate instance test) and are kept only as the registered state the milestone opened against.
> The product owner's brief that reshaped the stub is quoted where §S relies on it; its scratch lived in
> `/tmp` and is not a record.

*Read beside: `plans/M60-five-colour-residue-obstruction.md` (the origin reduction; `Forces` on a Cayley graph decided by one
table), `plans/M61-local-global-tightness.md` §S5 (G48, the mechanism this stub tries to complete), `plans/M56-arithmetic-of-
tightness.md` §R (the four-colour forcing at 2-adic depth 3 that this stub must reproduce before it may be believed),
`plans/M59-finite-plane-lift.md` and `Proofs/HadwigerNelson/Lift.lean` (the level-p² plane, used there only as an obstruction),
`plans/STUB-family-keeping-thickening.md` §H (i) (the forced-distance table at residue norm 0 — the instance test this stub's
phase C runs), `BIBLIOGRAPHY.md` `[BardestaniMallahiKarai2015]` (the local-field object).*

## 1. Mission context, in plain language

The programme reads a number field F through the residue map at a prime 𝔭 of F(i) fixed by complex conjugation. At level one
that map lands the unit-distance graph on F² in a finite object: at a prime above 2 with residue field 𝔽₄ it is the clique K₄
(Theorem B's four colours), at a prime above p ≡ 3 (mod 4) it is the finite Euclidean plane UD(𝔽_p, 2). Every bound the
programme holds is a level-one bound, and every "sealed" in the record means "sealed at level one".

The forcing the programme needs is not at level one. The four-colour forced pairs from which every 5-forcer's spindle was
built — de Grey's pair at distance 4, the antipodal pairs at 4/√3, T20's pairs at 8/3 and 8/√3 — sit at 2-adic depth: the
dial on the descent's K-fabric reads 163 of 178 pairs forced at valuation 6, 8 of 11 at 8/√3, and **zero** at valuations 2
and 4 (`data/m53/rigidity-dial-it4.json`); M56 measured the same fabric's true forced set as 171 pairs at depth 3 and none
at depth 2, and recorded no mechanism (`plans/M56-arithmetic-of-tightness.md:409-410,728-733`). At 11 and five colours the
record knows only level one, where the plane forces nothing (`finitePlane11_forces_iff`, kernel), and every five-colour
sweep ever run — on the 1581, on Heule-510/553, on the two-core union, on the ρ₆₃ arena over 1.3 billion pairs — read zero
on a *critical* 5-chromatic object, which is not where the four-colour pairs were ever found.

**The object this stub names.** For 𝔭 with residue ring O/𝔭^m, the **level-m residue plane** is the Cayley graph
P_m = Cay(O/𝔭^m, S_m), S_m the image of the norm-one group (for 𝔭 ∣ p unramified of degree one, O/𝔭^m = ℤ/p^m and
P_m = UD(ℤ/p^m, 2) = `unitQuadrance (ZMod (p ^ m))`, a type that elaborates today). The maps P_{m+1} → P_m are graph
homomorphisms (`unitQuadrance.map` along `ZMod (p^{m+1}) → ZMod (p^m)`), and their inverse limit is the unit-distance graph
of the 𝔭-adic plane — the anisotropic quadratic graph over a local field of `[BardestaniMallahiKarai2015]`. A colouring of
a level-m plane is **d-continuous** (d < m) if it is constant on the cosets of 𝔭^d/𝔭^m; the residue colouring is
1-continuous by definition.

**The question.** For (𝔭, k): what is the least level m such that every proper k-colouring of P_m is d-continuous for some
d < m — and what d? In M60's vocabulary: at level m, is the origin forced equal to 𝔭^d·v for every v? A "yes" at (11, 5)
for some m says that a fabric over a 5-sealed field, deep enough to see level m at 𝔭 ∣ 11, forces a pair at a distance d
with 11 ∣ d² — the pair G48 needs — and its spindle is a 6-forcer in a 6-open field. A "no" at every affordable m says the
residue mechanism cannot supply that pair.

## 2. What we know

| fact | trust | where |
|---|---|---|
| level one at 11 forces nothing at any colour count it admits, every p ≡ 3 (4) | kernel | `PlaneRotation.lean:184-190`, `ResidueObstruction11.lean` |
| level one at 2 over K(i) is K₄: uniquely 4-colourable | by definition of Theorem B's residue map | `FieldWall4.lean` §7–§8 |
| K-fabric at four colours: forced pairs at valuation 6 (163/178), 8/√3 (8/11), none at valuations 2, 4; F_true = 171 at depth 3, 0 at depth 2 | measured, complete sweeps | `data/m53/rigidity-dial-it4.json`; M56 §R |
| the level-p² plane's residue map and the lift obstruction | kernel | `Lift.lean:19-22,217` |
| the finite Borel chromatic number of the local plane is finite iff the form is anisotropic (−1 not a square in the completion) — the wall, on the Borel side | external, read | `BIBLIOGRAPHY.md:45` |
| the tower P_m as a colouring object: **never named or computed here** | absence, grep 2026-09-13 | `plans/`, `Proofs/` |

## 3. Derivations first (G46: the object in its discipline before any run)

**D1 — the tower and its homomorphisms, in the kernel's vocabulary.** `unitQuadrance (ZMod (p ^ m))` is the level-m plane;
`unitQuadrance.map (ZMod.castHom …)` is P_{m+1} → P_m. State d-continuity as `∀ v, Forces (P_m) k 0 (p^d • v)` through
M60's origin reduction (`forces_iff_forces_zero_sub`), so that ONE table decides it: a k-colouring of P_m that is not
periodic under some p^d·v refutes d-continuity at level m (`not_forces_zero_of_not_periodic`, kernel), and a forcing
verdict at level m is "every k-colouring is p^d-periodic" — a refusal of the Separated ask, solver-side, kernel-promotable
only through a certificate. The kernel half of a positive result is therefore the *lower* levels' refutations and the
transfer; the forcing verdict itself is solver-side unless the level is small enough to decide.

**D2 — from the tower to a fabric (the transfer).** A finite unit-distance graph in F² with coordinates integral at 𝔭 maps
homomorphically to every P_m. If every k-colouring of P_m is d-continuous, then every k-colouring of the fabric that FACTORS
through P_m identifies pairs at 𝔭-depth ≥ d — but a fabric's colourings need not factor. What the tower gives directly is
weaker and exact: the fabric's colourings restricted to the fibres. The derivation to make: under what hypothesis on the
fabric (a chunk containing a full set of representatives of P_m's vertices, joined as P_m is joined) does every k-colouring
of the fabric induce a k-colouring of P_m? Answer sketch: a chunk that contains, for every edge of P_m, a lifted unit edge
between lifts of its endpoints, with the lifts CONSISTENT (one lift per class), is an induced copy of P_m's quotient — that
is the lift question of M59 turned around, and M59's obstruction (a residue configuration lifts only if it is a shadow)
says such a chunk need not exist. So the honest transfer is compactness in the other direction: if the 𝔭-adic plane's
k-colourings are all d-continuous, then some finite chunk forces every depth-d pair it contains (the colouring space of the
local plane is compact, and "every finite chunk separates the pair" would yield a separating colouring of the whole plane).
The size of that chunk is the design number, and phase C measures it on the 2-adic bed where the answer is known to be
"about depth 3".

**D3 — the two primes are opposite at level one, and the question is whether they meet above it.** At 2 the level-one
object is a clique, so 1-continuity is trivially forced at level one and the interesting depth is where continuity FAILS
to propagate upward (M56: the additive family over-forces depth 2; the truth forces depth 3). At 11 level one is pairwise
free. If the tower at 11 never becomes continuous at five colours, the residue mechanism has no six-level; if it does at
level m, the level names the depth and therefore the SIZE of the fabric a 6-forcer over a sealed field needs.

**D4 — the prior-art gate (WORKFLOW 3a), before any run.** Search under the discipline's names: "finite Euclidean graphs
over rings ℤ/p^r" (Medrano–Myers–Stark–Terras have a rings paper — recalled, not read, not in the bibliography), "unit
distance graphs over ℤ/n", "chromatic number of Cayley graphs on ℤ/p^m × ℤ/p^m", "colourings of the p-adic plane /
quadratic graphs over local fields" (Bardestani–Mallahi-Karai's object; do they compute Borel χ for anisotropic binary forms
over ℚ_p, and is it p+1 or the level-one plane's value?). Record the result in §PA either way.

## 4. Phases — SUPERSEDED BY §S6 (2026-09-13); kept as the stub's registered state

| phase | what | cost | stop rule |
|---|---|---|---|
| PA | the prior-art gate (D4) | half an hour | finds a computed value of χ for the p-adic plane → read it before building |
| A | **the 2-adic tower on the certified bed**: P_m over K(i) at four colours, m ≤ 8 (|P_m| = 4^m), by exact enumeration where small and SAT above; record, per m, the least d with every 4-colouring d-continuous | an afternoon | if no m ≤ 8 forces valuation-6 pairs while chunks do (M56), the frame is killed here and the stub closes as a negative |
| B | **the 11-adic level two at five colours**: P₂ = UD(ℤ/121, 2), 14,641 vertices, degree 132; the Separated ask at the origin for each class of 11·v under the rotation group — a SAT model is a verified non-periodic table (kernel `¬Forces`); a refusal on every class is "1-continuous at level 2", solver-side | a day | refusal on every class → phase C; a model on any class → phase B′ (level 3, 1.77 M vertices, only if affordable) or close as "not continuous at the affordable levels" |
| C | **the instance test**: B9 (i) of `plans/BACKLOG-FOR-OPUS.md` — the forced-distance table at residue norm 0 on Heule-510 ∪ its gen-1 closure and W ∪ its F₂₄₇ cross lattice, asked under the jackpot protocol; the size of the fabric that first forces, read against the level found in B | a day of CPU, existing instruments | any forced pair at 11 ∣ d² is HALT AND VERIFY (two encodings, the residue check, the spindle field computed) |
| D | the derivation of the level from the structure of P_m (the connection set S_m over ℤ/p^m: p^{m−1}(p+1) points; the quotient P_m → P_{m−1} has fibres of size p²; is the fibre graph a clique, a matching, empty?) — the shape that makes A's and B's verdicts matters of course | two days | if the fibre structure alone decides continuity, the level is a theorem and the stub's question is closed by derivation for every p |

## 5. Registered predictions — SUPERSEDED BY §S7 (P1 refuted in its second clause, P2 decided by derivation, P3 confirmed, P4 met with a caveat; the scoring is in §S7)

| id | prediction | falsifier |
|---|---|---|
| P1 | at 2 over K(i), four colours: some level m ≤ 8 has every 4-colouring constant on valuation-6 cosets and some 4-colouring separating a valuation-4 pair — matching `data/m53/rigidity-dial-it4.json` | the tower separating valuation-6 pairs at every m ≤ 8 |
| P2 | at 11, five colours, level 2: the first Separated ask returns a model (P₂ is not 1-continuous) — because level one is pairwise free and the fibres of P₂ → P₁ are sparse | a refusal on every class at level 2 |
| P3 | the fibre graph of P_m → P_{m−1} at 11 is empty (no unit vector is ≡ 0 mod 𝔭, since x² + y² ≡ 0 has only the zero solution mod 11 — `quadrance_eq_zero_iff`), so continuity at 11 can only come from cycles through several fibres, never from a fibre's own edges — which is why P2 is expected to hold at level 2 and the interesting question is the growth of the least d with m | a nonempty fibre graph at 11 |
| P4 | the prior-art gate finds the spectra of P_m over ℤ/p^r in the literature and no colouring value | a computed χ(P_m) in print |

## 6. Failure and jackpot clauses — SUPERSEDED BY §S6's stop rules

**Failure at A:** the 2-adic tower never forces at any affordable level → chunk forcing is not tower-continuity; the M56 fact
belongs to another discipline (reconfiguration, FS-2); this stub closes as a clean negative and the Poros frame is killed
in its ledger. **Failure at B/B′:** no continuity at 11 up to the affordable level → the residue mechanism cannot supply the
six-level's pair through the tower; route A of `plans/PROGRAMME-ALGEBRAIC-PROOF.md` §3 is closed *at its mechanism*, and
the bet moves toward "no six through sealed fields" — recorded as such, with the level reached. **Jackpot:** any forced
pair at 11 ∣ d² on a fabric over a sealed field (phase C) is HALT AND VERIFY: two encodings, the residue check, the spindle
radicand 4d² − 1, the spindle field's sieve (wall broken, 11 inert), then the spindled object's four-colour and
five-colour asks — a refusal of five in a 6-open field is the programme's target object and is treated as a candidate
until certified.

## 7. Bearing on 6, honestly

Medium-high as a frame, medium as work. It is the only stub that changes the programme's OBJECT (level one → the tower)
rather than adding an instance inside it; it predicts the one four-colour fact the record measured and never explained;
it is finite and cheap at 2; and at 11 it is two-sided. Its risk is the transfer (D2): continuity of the local plane's
colourings gives forcing on some finite chunk by compactness, but the chunk's size is not bounded by the argument, and a
fabric we can build may not reach it. Phase C measures that on the bed where the answer is known.

## 8. Addresses

`Proofs/HadwigerNelson/UnitQuadrance.lean` (`unitQuadrance`, `unitQuadrance.map`), `ResidueObstruction.lean` (the origin
reduction, `not_forces_zero_of_not_periodic`), `Lift.lean` (`ZMod (p ^ 2)`, `residue`), `LocalGlobal.lean`
(`quadrance_eq_zero_iff`, `addCayleyMap`, `unitQuadrance_colorable_of_quotient`), `tools/fplane.py` (the Cayley machinery,
periodic quotients), `tools/fpcompel.py` (sets / filter / augment), `data/m53/rigidity-dial-it4.json`, `data/fplane/`.

---

## §PA. The prior-art gate (WORKFLOW 3a; run 2026-09-13 before the modeling passes)

*Each object named for a stranger, searched under two disciplines, the result recorded either way. Every work
found is a `BIBLIOGRAPHY.md` entry today with its read status; a title seen only in a search listing is marked so.*

| object, in a stranger's words | discipline 1 · what was found | discipline 2 · what was found | verdict |
|---|---|---|---|
| **A proper k-colouring in which some vertex's neighbourhood misses a colour other than its own** — "a vertex that can be recoloured", "a non-frozen vertex" | **Graph recolouring / reconfiguration.** The notion is standard: a colouring is *frozen* when no single vertex can be recoloured, i.e. every vertex sees all k−1 other colours; the isolated vertices of the k-recolouring graph (`[BrewsterEtAl2020]`, arXiv 1712.00200, *frozen H-colourings*, abstract read; the k-colouring case is Cereceda–van den Heuvel–Johnson 2008, recalled, unverified, not added). Our "fan gap at v" is exactly "v is not frozen in C". | **Uniquely colourable graphs.** In a uniquely k-colourable graph every k-colouring is frozen (Harary–Hedetniemi–Robinson 1969, recalled); `[KlotzSander2017]` (abstract read): in a uniquely colourable Cayley graph the colour classes are cosets of a subgroup; `[Basic2026]` (listing + summary) answers their Problem 3.6. Our result is the opposite pole: a Cayley graph with *no* forced pair at all. | The per-vertex notion is folklore; its **use** — a gap in the target graph, pulled back along a homomorphism, kills every forced pair in the source — was not found stated anywhere. Negative recorded. |
| **If G → P is a graph homomorphism and P has a k-colouring with a free colour at every vertex, then no two vertices of G are forced equal by all k-colourings** — "compulsion-freeness is hereditary under homomorphisms into slack targets" | Graph homomorphisms / cores: searched "homomorphism" + "uniquely colorable" + "forced"; nothing beyond "a homomorphic image of a uniquely colourable graph…" type facts (listings). | Reconfiguration: "frozen" is studied as a global property of one colouring, never as a property transported along a homomorphism. | **Not found.** The lemma is elementary; its absence from the literature is consistent with nobody having had the pair-compulsion question on a quotient plane. Negative recorded. |
| **The Cayley graph of (ℤ/p^r)² on the unit circle {x² + y² = 1}** — "the finite Euclidean graph over the ring ℤ/p^r" | **Spectral graph theory of finite rings.** `[MMST1998]`, A. Medrano, P. Myers, H. M. Stark, A. Terras, *Finite Euclidean graphs over rings*, Proc. AMS 126(3) (1998) 701–710 — **listing only**: the AMS PDF returned 403 to a scripted fetch; every citing listing says the graphs over ℤ/p^r are non-Ramanujan for r ≥ 2 (spectra). A sequel on ℤ/2^r (`[AJC43-Z2r]`, Australas. J. Combin. 43, p. 295, author unverified, fetched as binary, **unread**). No listing mentions chromatic number, colourings, cliques, or the quotient maps ℤ/p^{r+1} → ℤ/p^r. | **Cayley graphs of abelian groups.** `[CervantesKrebs2023]` (held): a grep of both held PDFs for `p^2`, `prime power`, `Z_4`, `Z_8`, `Z_9` returns nothing — the matrix method is not applied to prime-power cyclic factors in those two papers (grep, not a read). | The tower's **spectra** are prior art (unread here); its **colourings** are not found. The stub's P4 ("spectra in print, no colouring value") is **met at the level of listings**, with the caveat that `[MMST1998]` itself is unread. |
| **The unit-distance graph of the plane over a non-archimedean local field, anisotropic form** — "the quadratic graph over ℚ_p, p ≡ 3 (mod 4)" | **Descriptive set theory / harmonic analysis.** `[BardestaniMallahiKarai2015]` §3 (the anisotropic case, **read 2026-09-13**): their upper bound colours F^n by the ϖ-adic digits in positions −m..0, `c(x) = ({x_i}_m)_i` — a colouring **constant on cosets of a lattice, i.e. factoring through a finite quotient**, with q^{(m+1)n} colours; they remark χ_Bor(QG_{ℚ_p}) = O(p²) and *"in certain cases, one can attempt to quantify"*. So "continuity" (a colouring factoring through a finite level) is exactly their mechanism, in the crudest form. | **Finite-field geometry.** `[Moorhouse2010]` Table 6.1, `[Madore2015]` Prop. 3.2: the level-one bound χ(F²) ≤ χ(UD(𝔽_q, 2)) — the sharp form of the same mechanism, held and read. | Nobody asks whether the *sharp* level-one colouring has slack, or what the tower's colourings do. **Bonus, [hand], for the close's `CLOSED-QUESTIONS.md`:** their "quantify" remark has a clean instance — χ_Bor of the unit-distance graph over `F = ℚ₁₁(√11)` is **exactly 5**. Canonically (Poros): `c(x) := table([x₁] mod 𝔭, [x₂] mod 𝔭)` where `[·]` strips the canonical √11-adic fractional digits; adjacent points have an integral difference (unit vectors are integral, `−1` a non-square mod 11), hence equal fractional parts, so `c` is proper by the table's properness, and `[·]` is locally constant so `c` is locally constant, hence Borel. `≥ 5`: Heule-510 embeds as a unit-distance graph because the quadrance identity is polynomial and `3 = 5²`, `5 = 4²` in ℚ₁₁. Over ℚ₁₁ itself only `≤ 5` is established: no 5-chromatic unit-distance graph without √11 is held. |
| **Does any unit-distance graph over a field whose plane at 11 is 5-colourable carry two points forced equal by every 5-colouring?** — the question itself | Polymath16 (2018-05-02, Gibbs; `CLOSED-QUESTIONS.md` §1.4): asked for the forced pair at 5/3 over Heule's field, never answered; M60 answered it for distances with 11 ∤ d². | Searched "forced monochromatic pair" / "5-chromatic unit distance" / "Heule" outside arXiv: nothing beyond the Polymath thread. | The question is the record's own and Polymath's; this milestone answers it **for every distance**. |

**Search discipline note (G49).** The searches above used the disciplines' words (frozen, uniquely colourable, finite
Euclidean graph over rings, quadratic graph over a local field), never this project's ("fan gap", "slack", "sealed").
Two fetches failed (AMS 403; an AJC PDF returned as binary) and are marked unread rather than characterised from their
abstracts (G50); the one held paper the gate needed read — Bardestani–Mallahi-Karai §3 — was read today.

---

## §S. The subplan (2026-09-13, de Bruijn as planner; advisor: Poros, `plans/POROS-2026-09-13-fs38-subplan.md`)

### §S0. State on disk at opening

- Repository: `main` at 4c4b11e, gate green; nothing running. The stub renamed to this file; references re-pointed;
  `plans/FRONTIER-STUBS.md` row 1 marked *opened 2026-09-13* (no re-ranking until the close).
- **Kernel facts this milestone builds on** (all on the standard three axioms): `Forces`/`Separated`/`Fan`
  (`Forcer.lean:41`, `Fan.lean:79,71`); `Forces.image`, `Separated.image`, `addCayleyTranslate`,
  `forces_iff_forces_zero_sub`, `not_forces_zero_of_not_periodic`, `Aperiodic`, `CoincidesAtNonedges`,
  `forces_iff_eq_of_aperiodic`, `separated_iff_adj_of_coincides` (`ResidueObstruction.lean`);
  `Forces.eq_of_forall_exists_not_periodic`, `rotHom`, `finitePlane_forces_iff` (`PlaneRotation.lean`);
  `unitQuadrance`, `unitQuadrance.map`, `UDCert.drawingHom` (`UnitQuadrance.lean:251`);
  the certified 5-colouring of `UD(𝔽₁₁,2)` as `finitePlane11Colouring`/`finitePlane11Coloring` with
  `finitePlane11_aperiodic`, `finitePlane11_coincides`, `finitePlane11_forces_iff`, `finitePlane11_separated_iff`,
  `three_le_arityFloor_finitePlane11` (`Instances/FinitePlane11.lean`, `Instances/ResidueObstruction11.lean`);
  Heule-510's reduction `heule510Reduce11` and `heule510_colorable_five`; the 19-plane's periodic 5-colouring
  `circ19Table ∘ projAlong (1,1)` (`Instances/LocalGlobal19.lean:49-56`); Mathlib's `PadicInt.toZMod : ℤ_[p] →+* ZMod p`
  and `PadicInt.toZModPow`; `CoverAtLeast`/`coverColors` (`CoverageMono.lean:36`); `arityFloor` and
  `three_le_arityFloor_of_aperiodic_coincides` (`Arity.lean`).
- **Measured this morning by the product owner** (scratch `pilot11.py`, `pilot2.py`; reproduced by the planner and by
  Poros today, so three runs of each): the three gapped vertices of the certified 11-table — `(2,4)` own colour 1,
  neighbours `{0,3,4}`, gap 2; `(7,8)` own 0, `{1,2,4}`, gap 3; `(9,6)` own 0, `{1,2,4}`, gap 3; the level-2 repaint at
  a lift of `(2,4)` proper on all 1,932,612 directed edge checks of `UD(ℤ/121,2)`, fibre non-constant, negative
  control 55 conflicts. The 2-adic pilot's table (§2 of the brief) reproduced through level 5 in 1.4 s: no gap at
  levels 1–5 (solver UNSAT, untrusted, **no positive control on the 2-adic object**), free at depths 0–3 (verified
  colourings, 3 per depth at levels ≥ 4, all differences at levels ≤ 3), **forced at depth 4 at level 5** (3 of 3,
  solver refusals, untrusted).
- **Measured today by the planner** (scratch `<scratchpad>/fs38/planner/`, nothing committed; every number below is
  re-produced by the implementer under controls before it is a record):
  1. **The double gap at 11 is SAT**: a proper 5-colouring of `UD(𝔽₁₁,2)` with colour 4 absent from
     `N[(0,0)] ∪ N[(1,0)]` (22 vertices; the two share exactly two neighbours), verified proper on all 726 edges and the
     absence checked on all 22; single-gap positive control SAT; on the same code path "three colours absent from
     `N[(0,0)]`" is UNSAT (the refusal outcome is reachable); a triple gap on a triangle's closed neighbourhoods is
     SAT too. Poros reproduced it independently (colour 2, 0.01 s) with the control "forbid one colour everywhere =
     four-colour the plane = UNSAT". **The certified table has no shared gap on any edge** (its two colour-3 gaps sit
     at quadrance 8), so the kernel needs a second 121-entry literal.
  2. **The double gap at 19 is SAT** (40 vertices, verified). The kernel's own periodic 19-colouring has single gaps
     (at `x + y ∈ {4, 10}`, colour 1) but **fails `CoincidesAtNonedges` at shifts 7 and 12**; the solver's 361-entry
     table's coincidence property is unverified (a format ambiguity in a quick check).
  3. **Level 4 at 2 has no aperiodic 4-colouring**: forbidding periods one at a time went UNSAT after three —
     `2√3`, `2√3·ω`, `2√3·(1+ω)` (depth 2, one ω-orbit; pilot basis `(0,0,0,2), (0,0,2,2), (0,0,2,0)`). So every
     4-colouring of P₄ is periodic under one of those three, and the kernel form of P₄'s freeness is a **short list**
     of tables, not one (≥ 2; exact count to be measured).
  4. **LRAT prices** (cadical `-q --lrat --no-binary --unsat`, the flags of `scripts/regen-check.sh`): P₅ + edge
     `(0, δ)` with δ of depth 4, four colours: UNSAT in 0.1 s, **4,068 LRAT lines** (696 KB); control without the edge
     SAT. P₆ + depth-4 edge 6,680 lines, + depth-5 edge 9,659 lines, ~1 s each. The proofs are tiny; the pipeline's
     cost is the clause table: P₅ has 24,576 edges (3.1× de Grey's 7,877), P₆ has 196,608 (25×).
  5. **A ring-free representation of every level** validated against the pilot (§S3).
  6. Heule-510 has **115 residue classes with ≥ 2 points** (510 points on 121 residues; `data/fplane/reduce-heule510-p11.json`);
     the first same-residue pair is `(0, 475)` at residue `(0,0)`; the classes over the gapped residues are
     `(2,4): {233, 248, 312, 313, 426, 441}`, `(7,8): {72, 79, 322}`, `(9,6): {123, 299, 306, 463, 470}`. M60's live
     pair `(19, 59)` has residues `(0,1)` and `(2,1)` (distinct, non-adjacent) — the positive control on which M60 and
     this milestone agree.
- **Poros's findings today** (its record; not re-run by the planner): no common neighbourhood `N(0) ∩ N(δ)` in the
  2-adic tower at levels 3–7 contains an odd cycle (all bipartite; `|N(0) ∩ N(δ)| = 2` at depth 0, `deg/3` at the top
  depth), so the depth-4 forcing has **no local witness**; and `data/fplane/spectral-p83.json` has floor 6 at 83,
  K(√7)'s first usable prime, with no six-colour ask on record (§S8, surfaced for the product owner).

### §S1. Units — fixed once

**Depth of a pair** `z, w ∈ K(i)` at a prime `𝔓` of `K(i)` above 2: `depth(z, w) := v_𝔓(z − w)`, with `𝔓² = (2)` so
`v_𝔓(2) = 2`. For a rational squared distance `d²`, `v_𝔓(d²) = 2·v_𝔓(z − w)` (conjugation fixes 𝔓) and `v_𝔓(d²) = 2·v₂(d²)`,
hence **`depth = v₂(d²)`**. Translation table for the record's three usages:

| record | its unit | in depth |
|---|---|---|
| M53 `rigidity-dial-it4.json` `v2` = 6 / 4 / 2 | `v₂(d²)` | depth 6 (8/3, 8/√3, 8) / depth 4 (4, 4/√3, 4/3) / depth 2 (2, 2/√3, 2√3) |
| M56 "depth 3 / depth 2" | `v₂(d²)/2` | depth 6 / depth 4 |
| the handoff's "level 3" | M56's unit | depth 6 |
| the tower's **level** `m` | the ring `O/𝔓^m` | a difference lives at level `m` with depth `< m`; depth `≥ m` is the zero of level `m` |

K(i) has **two** primes above 2 (e = 2, f = 2, g = 2 over ℚ), swapped by √11 ↦ −√11; for `d² ∈ ℚ` or `ℚ·3` the two
depths agree, for other `d² ∈ K` they can differ, and every fabric statement below reads "at either prime".

### §S2. D0 — the fan-gap theorem, its corollaries, their exact hypotheses, and the hand gaps

**Vocabulary.** `FanGap C v γ` — in the proper colouring `C` of `P`, colour `γ` is absent from the closed
neighbourhood of `v`: `γ ≠ C v ∧ ∀ w, P.Adj v w → C w ≠ γ`. It is the negation of the record's coverage at level `k−1`:
`(∃ C, ∃ γ, FanGap C v γ) ↔ ¬ CoverAtLeast P k v [] (k − 1)` (bridge lemma, `CoverageMono.lean:36`'s vocabulary; the
reconfiguration literature's "v is not frozen in C"). `Slack P k` — every vertex has a gapped colouring.
`DoubleSlack P k` — every **edge** `v ~ w` has a colouring with **one** colour absent from `N[v] ∪ N[w]`.

**D0.1 The repaint (one definition, both uses).** For `f : G →g P`, `C : P.Coloring (Fin k)`, a set `U ⊆ V(G)` that is
independent in `G`, and a colour `γ` absent from `N_P(f u)` for every `u ∈ U`: the map `x ↦ γ` on `U`, `x ↦ C (f x)` off
`U`, is a proper colouring of `G`. *Proof.* An edge `x ~ y` with both ends in `U` is excluded; with `x ∈ U`, `y ∉ U`:
`f y ∈ N(f x)` so `C (f y) ≠ γ`; with neither: `f` is a homomorphism. ∎ Graph-level; no finiteness, no surjectivity;
`γ ≠ C (f u)` is **not** needed for properness.

**D0.2 The fan-gap theorem (the brief's Lemmas A and B merged, no case split on `f u = f u'`, no forces-freeness
hypothesis on `P`).** `f : G →g P`, `FanGap C (f u) γ`, `u ≠ u'` ⟹ `¬ Forces G k u u'`. *Proof.* If
`C (f u) ≠ C (f u')`, `C ∘ f` separates. Otherwise repaint `U = {u}`: `C' u = γ ≠ C (f u) = C (f u') = C' u'`. ∎
**Corollaries.** (a) `Slack P k` ⟹ for every `f : G →g P`: `Forces G k u u' → u = u'` (the brief's Lemma B without
its first hypothesis — in particular `P` itself is forces-free: the brief's "forces-free" premise is **redundant**).
(b) `FanGap.comap`: a gap at `f u` pulls back to a gap at `u` in `C ∘ f` (the brief's A′), so `Slack.of_hom` — slackness
passes from `P` to every `G` with a homomorphism into `P`, **no surjectivity**. (c) On a Cayley graph one gapped
vertex gives `Slack` by translation (`addCayleyTranslate`). (d) `Slack (unitQuadrance S) k` and `φ : R →+* S`
(`S` nontrivial) give `Slack (unitQuadrance R) k` by `unitQuadrance.map` — so **the tower at 11 (`ZMod (11^m)`) and the
completion (`ℤ_[11]`, via Mathlib's `PadicInt.toZMod`) are instances, not steps**: the brief's Corollary 1 needs no
induction and its Corollary 2 needs no level and no "images distinct in R".

**D0.3 The arity-k filter.** `f : G →g P`, `FanGap C (f p) γ`, and every partner `q ∈ Q` has `q ≠ p` and `C (f q) ≠ γ`
⟹ `¬ Fan G k p Q`. (Repaint `{p}`; the fan needs some `q` with `C' q = C' p = γ`.) The pair theorem is the case
`Q = [u']` together with the pullback case. **Scope:** a fan whose class `Q` has, in every gapped colouring of `P`, some
partner's image on the gap colour **survives** — G15's wide-class pigeonholes are not touched (Poros E(ii)); the
dichotomy G54 of the brief is therefore **one-directional**: gap ⟹ no forced pair is a theorem; no gap ⟹ forcing is
an observation at 2 and 3 (the 2-adic K₄ and `UD(𝔽₃,2)` at three colours have no gap and do carry forced pairs).

**D0.4 The double repaint (new today; Poros's card D, measured SAT).** `f : G →g P`, one colouring `C` with
`FanGap C (f u) γ` and `FanGap C (f u') γ` (**the same** `γ`), `¬ G.Adj u u'` ⟹ `¬ Separated G k u u'` (repaint
`U = {u, u'}`). With `DoubleSlack P k`, `P.Colorable k`, and `∀ x y, Separated P k x y → P.Adj x y` (the plane's own
virtual edges are edges — M60's `separated_iff_adj_of_coincides` at 11): for every `f : G →g P`,
**`Separated G k u u' ↔ G.Adj u u'`**. *Cases.* `f u = f u'`: pull back any colouring. Images distinct, non-adjacent:
`Separated.image` would make them adjacent. Images adjacent: the double repaint. ∎ `DoubleSlack` is hereditary under
homomorphisms (`FanGap.comap` twice) and, on `finitePlane p`, follows from **one** shared-gap table `C₀` at the base
edge `((0,0),(1,0))`: for an edge `v ~ w` take the automorphism `σ` with `σ v = (0,0)`, `σ w = (1,0)` — translate by
`−v`, then rotate by the conjugate of `d = w − v` (`rotHom` by `d` sends `(1,0)` to `d`, so its inverse sends `d` to
`(1,0)`) — and **pull back**: `C₀ ∘ σ` has `γ` absent on `σ⁻¹(N[(0,0)] ∪ N[(1,0)]) = N[v] ∪ N[w]`. Written the other way
round the gap lands on the wrong pair (Poros).

**D0.5 Corollary 2, stated at its proofs' level.** Let `P = finitePlane 11` with `Slack P 5` and `DoubleSlack P 5`
(two `decide`s on two 121-entry tables). Then for every graph `G` with a homomorphism into `P`:
`Forces G 5 u u' ↔ u = u'` and `Separated G 5 u u' ↔ G.Adj u u'` — **the whole arity-2 compulsion structure of the
sealing plane pulls back to every unit-distance graph over the field.** Instances, all kernel: every `Valid` `√7`-free
tower certificate with `11 ∤ D` (through `drawingHom Q4.sevenFree.res11`; the same hypothesis as M60); Heule-510
(`heule510Reduce11`), including the same-residue pair `(0, 475)` M60 was silent on and the `5/3` pair `(19, 59)` on
which M60 and this agree; `unitQuadrance R` for every ring `R` with a hom to `ZMod 11` — `ZMod (11^m)` for every `m ≥ 1`,
`ℤ_[11]`, `Adjoin 11 ℤ_[11]` (Heule's completion's integers, via `Adjoin.lift PadicInt.toZMod 0`). The same at 19 for the
forces half (the kernel's own 19-colouring has gaps); the virtual-edge half at 19 needs a coinciding table (§S6 K3).
**The hand gap, named:** the field-level sentence — *no finite unit-distance graph over a field `F` with a usable prime
of residue degree one above 11 (or 19) carries a pair compulsion at five colours* — adds to the kernel statements exactly
the step of M58/M60: translate one vertex to the origin, then every **coordinate** `x, y` is `𝔭`-integral because unit
vectors are (`−1` is not a square mod 11, and 2 is a unit there), so the graph is such a certificate / maps into
`unitQuadrance O_𝔭`. (At 2 the analogous step is about the **complex number** `z = x + iy`, not the coordinates — §S3
[hand 2]; the two hand steps are not the same step.) That step is row 57's
open gap and is **not** closed here. **Scope (Poros E(i)):** "usable of residue degree one above 11" — for multiquadratic
`F ⊇ K` this is every 5-sealed field (residue degrees are 1 or 2, `q = p² ≡ 1 (mod 4)` is never usable, and every plane
from 59 up refuses five), and **19 is never of degree one over K** (3 is a non-residue mod 19). It is not "every field":
a non-multiquadratic field could be sealed by a degree-three prime at 23–47 whose plane is undecided.

**D0.6 What this decides in the record.** G48's six-level question — does a 5-sealed field carry a pair forced equal
at five colours, necessarily at `11 ∣ d²`? — is answered **no** for every such field (arity 2); FS-6's design target has
no instance; its never-run central computation (B9 (i), the forced-distance table at residue norm 0) has a known answer,
every entry refuted; FS-16's 51 residue-allowed-distance asks are answered — a five-colour virtual edge over such a field
is a unit edge; the four measured five-colour nulls on sealed objects (Heule-510/553, the two-core union) become matters
of course; **the nulls on 6-open objects (the 1581, the ρ₆₃ arena) are untouched** — no 5-colourable residue target
exists for them, by definition of 6-open; and `not_colorable_of_fan` can never fire at five colours over such a field
(separable partners must be adjacent, and adjacent partners are never in a fan of a proper colouring).
**The sentence for the bearing on 6 (Poros):** over a field where 11 is usable of degree one, at five colours, G15's
factorisation has a **free Act One** (six points in one residue class carry a monochromatic pair in every 5-colouring)
and an **impossible Act Two** (a kill is a virtual edge, and a five-colour virtual edge is a unit edge) — so the whole of
a 6-forcer's work moves into a 6-open extension, where no residue plane is five-colourable. That is stronger than "the
mechanism has no instance": in-field, the mechanism's second act cannot exist.

### §S3. D1 — the 2-adic law as registered predictions, with the representation measured

**The object.** `O = ℤ₂[ω][√3]`, `ω² = −1 − ω`, `π = 1 + √3`, `𝔓 = (π)`, `𝔓² = (2)`, residue field `𝔽₄`; `O = ℤ₂[ω][π]`
is the ring of integers of `ℚ₂(√3, ζ₃)` because `π` is Eisenstein over `ℤ₂[ω]` (`π² − 2π − 2 = 0`) — **[hand]**.
`P_m := Cay(O/𝔓^m, S_m)`, `S_m = {z : z z̄ = 1}`, `|P_m| = 4^m`, `|S_m| = 3·2^{m−1}`; the object is the **complex form**
(Theorem B's `K₄` at level one), not `unitQuadrance (O_K/𝔭^m)` — at 2 the coordinates `x, y` of a unit vector are not
integral, only `z = x + iy` is, so the pairs form does not reduce (its level one is a 4-cycle).

**The representation (kernel shape, validated today at m = 1..7 and against the pilot's graphs at m = 4, 5).**
`O/𝔓^m ≅ (ℤ/2^⌈m/2⌉)[ω] ⊕ π·(ℤ/2^⌊m/2⌋)[ω]` as additive groups — `z = A + πB`, `A = a + bω`, `B = c + dω` — because
`𝔓^{2j} = 2^j O` and `𝔓^{2j+1} = 2^{j+1}ℤ₂[ω] ⊕ π·2^j ℤ₂[ω]` (from `π² = 2 + 2π`). The norm is an explicit integer form:
`N(A + πB) = (a² − ab + b² + 2(c² − cd + d²)) + π·(2ac − ad − bc + 2bd + 2(c² − cd + d²))`, so
`S_m = {(a,b,c,d) : a² − ab + b² + 2(c² − cd + d²) ≡ 1 (mod 2^⌈m/2⌉) ∧ 2ac − ad − bc + 2bd + 2(c² − cd + d²) ≡ 0 (mod 2^⌊m/2⌋)}`.
Conjugation `(a,b,c,d) ↦ (a − b, −b, c − d, −d)`; multiplication by `ω`: `(a,b,c,d) ↦ (−b, a − b, −d, c − d)` (preserves
`S_m`; checked at m = 5); the level map `m + 1 → m` reduces `A` and `B` modulo the smaller powers; the pilot's basis
`1, ω, √3, ω√3` is reached by `(a,b,c,d) ↦ (a + c, b + d, c, d)`. **Ring-free, decidable, uniform in `m`.** Two hand steps then stand side by side with the same trust shape, and
the record must carry both (Poros): **[hand 1]** this explicit Cayley graph IS `Cay(O/𝔓^m, S_m)` (the derivation above);
**[hand 2]** a K-certificate translated to the origin draws into it, because unit vectors of `K(i)` are `𝔓`-integral —
row 57's gap, and the even-denominator obstacle (Heule's `D = 96`; K-certificates carry halves) that stops the record's
`u * D = 1` drawing at 2. Neither is kernel. **Controls on the formula, run today:** the discriminating one is the
coincidence with the pilot's graphs at levels 4 and 5 under `(a,b,c,d) ↦ (a+c, b+d, c, d)` (a different construction of
the same object); the count `|S_m| = 3·2^{m−1}` is tuned-to and does not discriminate on its own — so it was perturbed:
dropping the `2` in the real part gives 18 at `m = 3` and 24 at `m = 5`; dropping the `2` in the `π`-part gives 9 at
`m = 2`, 18, 36, 72, 144 at `m = 3..6`. Both perturbations leave the count at some level; the formula is the only one of
the three that holds the count at every level 1–7. Alternative weighed: `Adjoin 3 ((ℤ/2^j)[ω])` as a
genuine `CommRing` — reaches only even levels, and the threshold level 5 is odd (§S8).

**Registered predictions (both outcomes reachable; the pilot's numbers are the prior, not the record):**

| id | prediction | if it holds | if it fails |
|---|---|---|---|
| P-A1 | at every level `m ≤ 8`, every difference of depth `≤ 3` is separated by some 4-colouring of `P_m` (all differences asked, verified models) | free at depth ≤ 3 is a record; with K3's tables it is kernel at levels 4 and 5 | a refusal at some depth-≤-3 difference (untrusted until a second solver agrees) kills the negative half and with it the only fabric transfer |
| P-A2 | from level 5 on, **every** difference of depth `≥ 4` is forced (all differences asked; refusals on two solvers; the P₅ instance kernel through LRAT) | the 2-adic law's positive half is a record, kernel at level 5 | a verified separating colouring at some depth-≥-4 difference: the law is not "depth ≥ 4", record the true threshold per level |
| P-A3 | no 4-colouring of any `P_m`, `m ≤ 8`, has a fan gap. **Not an independent prediction (Poros): at levels ≤ 5 it is a THEOREM of K3** — a gap at level `m` pulls back along the level map to a gap at every level `m' ≥ m` (`FanGap.comap`), one gap on a Cayley graph gives `Slack` by translation, `Slack` gives pairwise free (D0.2 (a)), and P₅ has a forced pair (the LRAT) — so no level ≤ 5 has a gap, kernel-grade. Above 5 the same chain makes it a corollary of P-A2 at that level. The T-phase `gap` subcommand is therefore a **consistency check on the solver** at levels 6–8, with the planted control (delete the edges from one vertex to one colour class; the ask must flip) as the solver's self-check | the 2-adic side of G54 ("2 has no gap") is kernel at levels ≤ 5 and solver-consistent above | a verified gapped colouring at any level contradicts P-A2 below it — one of the two instruments is wrong, HALT |
| P-A4 | every 4-colouring of `P_m` has a nonzero period at every level `m ≥ 2` (measured at 4: one of three depth-2 elements; **measured at 2 today: all 576 Latin-square colourings of `K₄ □ K₄` are periodic**, so "some period is unavoidable" appears at level 2 already) | a structural input to phase D: "some period" below level 5, "all of depth ≥ 4" from level 5 | an aperiodic colouring at some level ≤ 4 — then one table suffices there |
| P-A5 | the number of tables needed for P₄'s freeness is 2 or 3 | the kernel instance is that list | more — the kernel instance is a longer list; nothing else changes |
| P-A6 (Poros's hunch, basis: derivation + M56) | for every `m ≥ 5` the forced set of `P_m` at four colours is exactly `{depth ≥ 4}` — which is `F_add`, the additive family's forced set: an additive 4-colouring is a hom `Λ → G` with `\|G\| = 4`, so it kills `4Λ ⊆ 𝔓⁴O` and factors through `O/4O = P₄` (M56's P1′, `plans/M56-arithmetic-of-tightness.md:405-412`, measured there and never derived; a two-line theorem) | the tower is **no sharper than the additive family** as a fabric instrument on the calibrated bed: the depth-6 forcing of U (the 16-pair non-additive residue M56 named) is invisible to it, because U's separating 4-colourings at depth 4 are exactly its non-additive ones, which factor through no level | a level `m ≤ 8` whose forced set differs from `{depth ≥ 4}` — a free depth-4 difference or a forced depth-3 one |

**The reachability check on the uninformative outcome:** P-A1–P-A3 have positive controls on the same code path
(P-A1: the refusals at depth 4; P-A2: the verified models at depth ≤ 3; P-A3: the planted gap) and P-A2's refusals get a
second encoding or solver (Poros B/G) — a FORCED row is never written from one solver's UNSAT. **At level 5 the second
encoding is the kernel itself**: the LRAT-checked refusal of `P₅ + edge` (K3) makes the level-5 forcing at depth 4
**kernel**, not solver — a checked refutation beats a second CDCL run (Poros).

### §S4. D2 — the transfer: what the tower bounds and what it does not

1. **Freeness transfers, one way.** A K-fabric `G` with a homomorphism into `P_m` (the hand step: translate, then
   𝔓-integrality) cannot force a pair whose image in `P_m` is separated (`Forces.image`). With P₄ pairwise free,
   **no K-fabric forces a four-colour pair of depth ≤ 3 at either prime above 2** — the mechanism behind M53's
   `0 of 6,669 / 5,470 / 767` at depth 2. Kernel-promotable through K3 (the tables) once a K-plane drawing into level 4
   exists (§S8: priced, declined for this milestone).
2. **Forcing does not transfer.** `P_m` forcing `(0, δ)` says nothing about any finite chunk: its colourings need not
   factor through `P_m`. The measured K-fabric is **free at depth 4** (`16/3`: 0 of 2,145; `16`: 0) where the tower
   forces it, and forced at depth 6 where the tower permits it. So the tower **bounds K-fabric forcing to depth ≥ 4;
   the record's fabric forces at 6; depths 4–5 are unexplained** (Poros A). "Small-chunk effect" is a reading with a
   falsifier: a K²-fabric forcing a four-colour pair at 4/3, 4, 4/√3 or 4√3 confirms it; a derivation that K-fabric can
   never force depth 4 exposes the tower's depth-4 verdict as a continuous-colouring artifact.
3. **What is not a retrodiction target.** De Grey's distance-4 and antipodal-4/√3 pairs (G9): his half lives in
   `ℚ(√3,√5,√11)²`, the wall broken by 15 ≡ 7 (mod 8), no conjugation-fixed prime above 2 in `F(i)`, no hom into this
   tower. (The brief's §2 read them as the tower's fit; withdrawn — Poros A, planner retraction 1.)
4. **The compactness direction** (stub D2): if every 4-colouring of the local plane `O²` were continuous, some finite
   chunk would force each forced pair; but continuity is exactly the open question and the tower's forcing at level 5
   is a statement about colourings that already factor through level 5. No transfer is claimed from it.

### §S5. Phase D — the derivation plan (a day, capped; a recorded stall is a result)

Inputs on disk at the start: P₂ = K₄ □ K₄ (8 cliques; 576 colourings = Latin squares; prove it: the eight cliques are
`{a + εv}` and `{a + ε(a + c)}` — the brief's (i)); adjacent fibres joined by two `K_{2,2}`'s (the brief's (ii)); every
4-colouring of P₄ has a depth-2 period `2√3·u` (§S0 item 3); no common neighbourhood in levels 3–7 contains an odd cycle
(Poros); the level-5 forcing has, by construction, no local witness.

Questions, in order, each with its stall statement:
- **D-1 (structure of the period sets).** For `m = 2, 3, 4`: which nonzero periods does every 4-colouring have? (P-A4;
  at level 2 all 576 colourings are periodic — measured today; ask which periods, and whether they are depth-1 elements.) If the unavoidable periods
  form the coset `𝔓^{m−2}·(units mod 𝔓)` at every `m ≤ 4`, state and prove it for `m = 2` by hand.
- **D-2 (propagation).** Does "every 4-colouring of `P_{m+1}` factors through `P_m`" propagate from `m = 4` to all
  `m ≥ 4` by a structural argument? **Input (P-A6):** the additive 4-colourings factor through `P₄` by exponent; the
  question is whether every 4-colouring of `P_m`, `m ≥ 5`, is forced to agree with an additive one on `𝔓⁴`-cosets. Candidate: the fibre over `v` is a `V₄`-torsor; for each direction `s̄ ∈ S_m` the lifts
  form a coset of an order-2 subgroup `H(s̄)`; `x` and `x + δ` share their neighbours over `s̄` iff `δ ∈ H(s̄)`; the
  forcing of `(x, x + δ)` is then a property of the map `s̄ ↦ H(s̄)`. If the map's structure is the same at every level
  `m ≥ 4` the propagation is a theorem; if not, say which level breaks it.
- **D-3 (the dichotomy's other side).** Is "no gap at level one ⟹ no gap at any level" a theorem for a Cayley tower?
  Gaps pull **up** (A′), not down. Below level 5 the question is settled by K3's chain (P-A3); at level `m ≥ 5` it is
  settled by P-A2 at that level (a forced pair forbids every gap). The descent argument (a gap at level `m + 1` descends
  when every colouring factors through `P_m` and `S_{m+1} → S_m` is onto — check onto-ness once: `|S_{m+1}| = 2|S_m|` with
  fibres of size 2) is needed only to get gap-freedom at `m + 1` from level `m` without P-A2. Record; do not spend the
  day on the general case.
- **D-4 (why 11 is slack).** Is there a 5-colouring of `UD(𝔽₁₁,2)` in which **every** vertex is gapped (each
  neighbourhood uses three colours)? One solver ask; if SAT, verify and keep the table — it is the strongest possible
  form of slackness and a natural kernel literal. Not needed for any theorem.

Stop rule: one day; the write-up is "derived: … / not derived, stalls at …".

### §S6. Phases, costs, stop rules, and the instrument's shape

| phase | what | cost (desktop, 16 physical cores; one heavy job at a time) | stop rule / acceptance |
|---|---|---|---|
| **K1 kernel, general** | `FanGap.lean`: `FanGap`, `Slack`, `DoubleSlack`, the repaint, D0.1–D0.4, `FanGap.comap`, `Slack.of_hom`, `DoubleSlack.of_hom`, the Cayley transports, the `unitQuadrance`/ring-hom corollary, `Fan.image`, the `CoverAtLeast` bridge | half a day | every `sorry` closed; the negative control (delete the gap hypothesis, confirm the proof breaks — G30 §6) done once |
| **K2 kernel, 11 and 19** | `Instances/FanGap11.lean`: the gap `decide` (12 lookups), `Slack (finitePlane 11) 5`; the shared-gap table as a 121-entry literal (`decide` proper + absent on 22), `DoubleSlack (finitePlane 11) 5` by translation + `rotHom`; `Forces ↔ =` and `Separated ↔ Adj` for every `G →g finitePlane 11`; `ZMod (11^m)`, `ℤ_[11]`, `Adjoin 11 ℤ_[11]`; the certificate corollaries; **Heule-510** both iffs, `3 ≤ arityFloor` (5-colourable, no pair compulsion), the pair `(0, 475)` and the control `(19, 59)`; reds: a present colour refused as a gap, the level-one `K₄` at 2 (`addCayley` on `F4`'s units) has no gap (`decide` over 256 functions). `Instances/FanGap19.lean`: the gap in the kernel's own 19-colouring (10 lookups), `Slack`, `Forces ↔ =` for `G →g finitePlane 19`, `ZMod (19^m)`, `ℤ_[19]`; the double gap at 19 as a 361-entry literal **if** a coinciding table is also obtained (else the virtual-edge half at 19 is dropped with a note) | a day | vacuity green with the inhabitants named in-file; `finitePlane_forces_iff` kept (it covers 3 and 2) |
| **K3 kernel, 2-adic (should)** | `TwoAdicTower.lean`: `twoAdicLevel m`, `normForm m`, `twoAdicPlane m`, conjugation and `ω`-multiplication as graph automorphisms, the level maps as graph homs, `#guard`s on `|S_m|`. `Instances/TwoAdicFour.lean`: the table list (literals), `Forces (twoAdicPlane 4) 4 x y ↔ x = y` via `Forces.eq_of_forall_exists_not_periodic` and one `decide` (255 × tables × 256). `Instances/TwoAdicFive.lean`: `Forces (twoAdicPlane 5) 4 0 d ↔ levelMap d = 0` — the forward direction from level 4 by pullback, the backward direction by **one LRAT refusal** of `P₅ + edge (0,(4,0,0,0))` through the existing pipeline (`emit_mask.py` on a 1024-vertex, 24,577-edge list; measure one segment's build memory first) and `Forces.map` along `ω`-multiplication for the other two depth-4 differences; the level-one `K₄` control | a day; the pipeline run is the risk | decline the LRAT half (keep the statement solver-only, `sorry`-free by dropping it) if one segment's build exceeds the cap or the run exceeds a day; the level-4 tables are kept regardless |
| **T tools + records** | `tools/fs38_tower.py`: subcommands `build` (levels at 2 in the §S3 representation; `ZMod (p^m)²` at 11/19), `gap` (fan-gap ask with the planted control), `forced` (per-difference Separated asks — **all** differences, no sampling; refusals re-asked on a second solver or encoding), `doublegap` (the shared-gap ask at an edge), `tables` (aperiodic-cover search for level 4), `recolour` (the level-2 repaint record at 11 and 19), `lrat` (emit the P₅ + edge CNF and LRAT); records `data/fs38/tower-p2-k4-m<M>.json` (m ≤ 8; **65,536 vertices at m = 8 — measure memory at 7 first**; checkpoint per level under `data/fs38/ckpt/`, never `build/` or `/tmp`; resume command in the README), `data/fs38/gap-p11-k5.json`, `doublegap-p11-k5.json`, `doublegap-p19-k5.json`, `p4-tables.json`, `recolour-p11-level2.json`; `data/fs38/README.md` with one row per file and a "not recorded here" list. Controls: a planted fibre edge caught; every verified model re-checked by an independent function against every edge; the negative control of the brief at 11 (55 conflicts); the level-2 Latin-square count 576; UNSAT never written as a fact | half a day of engineering, an hour of runs below m = 8 | every headline names its population and trust word |
| **D derivation** | §S5 | a day, capped | a recorded stall is a result |
| **C close** | the documents listed in the brief §3: `CLAUDE.md` row 66 and G54 (one-directional, as §S2 D0.3 states it), G48 rewritten, G31 reread, § Paths forward + `plans/FRONTIER-STUBS.md` re-ranked (FS-6 demoted under a banner; **FS-16 closed**, not kept — the brief's "FS-16 kept" is withdrawn by D0.4); `CLOSED-QUESTIONS.md`: Polymath16 2018-05-02 answered no at every distance, and the [hand] χ_Bor = 5 over ℚ₁₁(√11); the Poros hunch ledger scored; `BIBLIOGRAPHY.md` entries (§PA); `data/fs38/README.md` | half a day | `CLAUDE.md` under 150,000 characters; current-state-only |

**Order.** K1 → K2 → T (records, incl. the 11-adic level-2 repaint) → K3 → D → C. K1 and K2 are the headline and are
not blocked by anything solver-side except the shared-gap table (ask it first; seconds).

### §S7. The stub's predictions, scored; the brief's, registered

| id | as registered | verdict today |
|---|---|---|
| stub P1 | tower at 2 forces valuation-6 and separates valuation-4 pairs at some `m ≤ 8` | **first clause holds, second REFUTED** by the pilot (depth 4 forced from level 5) — solver-side; P-A2 is its registered replacement |
| stub P2 | P₂ at 11 is not 1-continuous (a Separated model at level 2) | **decided by derivation** (D0.2 + the gap): every level is pairwise free; the level-2 repaint is the record's instance |
| stub P3 | the fibre graph at 11 is empty | **confirmed** (pilot: 0 fibre edges; the reason `a² + b² ≡ 0` has only the zero solution mod 11) |
| stub P4 | prior art has spectra of `P_m` over ℤ/p^r and no colouring value | **met at the level of listings**; `[MMST1998]` unread (§PA) |
| brief "the 2-adic tower forces exactly depth ≥ 4 from level 5, free at depth ≤ 3 at every level" | — | registered as P-A1/P-A2 with both outcomes reachable and a second solver on refusals |
| retractions in the planning window | — | requested of the brief: **7** (Lemma B's forces-free hypothesis; the tower/ring-R detour to Corollary 2; the ramified level ring; "FS-16 stands"; de Grey's pairs as the tower's fit; "reproduces M56"; "every 5-sealed field" → residue degree one); planner: **1** (de Grey's pairs); Poros public: **1** ("𝔓-integrality of translated coordinates" at 2 — it is `z`, not the coordinates); Poros's proposed drop of `P.Colorable k` from D0.4's iff **declined**: with `P` edgeless and `k = 0`, `DoubleSlack` is vacuous, `Separated G 0 u u'` holds for want of colourings, and `Adj` is false |
| new P-K1 | the shared-gap 121-entry table decides proper and doubly absent in the kernel | trivial to fail: a corrupted table is refused (planted red) |

### §S8. Decisions settled at subplanning (house format: choice · alternative · why · confidence)

| # | choice | alternative weighed | why this one | confidence |
|---|---|---|---|---|
| 1 | Headline = D0.5: the residue plane's arity-2 compulsion structure at five colours (Forces ↔ =, Separated ↔ Adj) pulls back to every unit-distance graph over the field; the 2-adic law second | the brief's headline (Corollary 2 = no forced pair) alone | the double gap is measured SAT twice and the composite is a one-page theorem; it closes FS-16 as well as FS-6 | high — the one fact that would change it: a hole in D0.4's third case, which Poros and I both re-derived |
| 2 | One repaint definition over an independent set `U`, with the pair, fan and double-repaint theorems as its three uses | three separate constructions | one properness proof, three consumers; the obligation pass has one induction-free lemma to close | high |
| 3 | No forces-freeness hypothesis anywhere; `finitePlane_forces_iff` kept as the theorem that covers 3 and 2 | keep the brief's Lemma B shape (forces-free ∧ gapped) | the hypothesis is redundant (D0.2 (a)); a redundant hypothesis is G30 §6's smell | high |
| 4 | The tower at 11, `ℤ_[11]`, `Adjoin 11 ℤ_[11]` and `ZMod (11^m)` as **instances** of the ring-hom corollary; no induction | the brief's Corollary 1 by induction on `m` | the induction proves a special case of a two-line corollary; `PadicInt.toZMod` makes the completion free | high |
| 5 | Drop the ramified level ring `Adjoin 11 (ZMod (11^j))` and the "images distinct in R" kernel form | build it as the brief asked | strictly weaker than D0.5 and needs `tools/` to compute a level; nothing rests on it | high |
| 6 | 2-adic kernel object = the ring-free explicit representation of §S3 (`addCayley` on a product of `ZMod`s with a decidable norm form), uniform in the level | `Adjoin 3 ((ℤ/2^j)[ω])` as a genuine `CommRing` (even levels only; a hand-built Eisenstein ring) | the threshold level 5 is odd; the graph is fully specified by group + connection set; the ring is used only in the [hand] identification, recorded | medium — if the domain pass finds the odd-level structure can be a genuine quotient ring cheaply, switch |
| 7 | 2-adic kernel scope = P₄ freeness (tables) + P₅ forcing at depth 4 by one LRAT + the pullback iff; **no** K-plane drawing into the level ring | (a) also draw the K-plane (`oddDenom`/`psiA` generalised to level 4: the 2-adic root of −11 by Hensel, the localisation); (b) LRAT at level 6 | (a) is a 1–2 day modelling task on `ValuationLaw.lean`'s machinery with its own hand gap (𝔓-integrality) — priced, declined, an FS candidate; (b) P₆'s 196,608-edge clause table is 25× de Grey's — out of the pipeline's budget | medium — the one fact: if one P₅ segment's build memory exceeds the cap, the LRAT half is declined too |
| 8 | Level-4 freeness as a **list** of tables with `Forces.eq_of_forall_exists_not_periodic` | one aperiodic table (`Aperiodic col`) | no aperiodic 4-colouring of P₄ exists (measured, §S0 item 3) | high |
| 9 | Records under `data/fs38/`; the level-2 repaint at 11 reproduced as a record; all 2-adic runs to m = 8 with memory measured at 7 first | run straight to 8 | 65,536 vertices × 384 neighbours in Python lists is ~GB; the box has 128 GB but one heavy job at a time | high |
| 10 | 19: the forces half in the kernel from the existing colouring; the virtual-edge half **dropped** with a one-line note ("needs a coinciding table") | chase the 361-entry coinciding table now | the gap `decide` is ten lookups; 19 is degree one only over fields without √3 (e.g. ℚ(√5,√11)), where no object of ours lives, so the virtual-edge half buys nothing today (Poros) | high |
| 11 | `[MMST1998]` entered as listing-only/unread; no claim rests on it | characterise it from citing abstracts | G50: an abstract is not a reading | high |
| 12 | Poros's 83 card (is `UD(𝔽₈₃,2)` six-colourable? floor 6, K(√7)'s first usable prime) is **surfaced to the product owner, default not run** | run it in T | it is outside this milestone's question and is the product owner's ranking call | — (not mine) |

### §S9. Gap audit against the brief (every promise: planned / changed / dropped with reason)

| brief item | status |
|---|---|
| `git mv` to `plans/FS38-residue-tower.md`; re-point references; mark the row opened | **done** |
| §PA with two disciplines per object, negatives recorded, works into `BIBLIOGRAPHY.md` the same day | **done** (§PA; bibliography rows added with this commit) |
| Kernel: Lemmas A, A′, B ring-free in a new leaf module | **planned, strengthened** (K1: one merged theorem; B's first hypothesis dropped) |
| Kernel: the gap at 11 (`decide`) and at 19 | **planned** (K2; at 19 on the kernel's own colouring) |
| Kernel: the tower corollary at `ZMod (11^m)` for all `m`, "the statement over any ring R with a hom to ZMod 11 is cleaner" | **planned as the ring-hom corollary + instances**, plus `ℤ_[11]` and `Adjoin 11 ℤ_[11]` (K2) |
| Kernel: the certificate corollary with drawn images DISTINCT in R, at the ramified level ring | **changed**: replaced by the stronger `∀ i ≠ j, ¬ Forces` with no distinctness and no level ring (D0.5, decision 5) |
| Instance test: a pair with `11 ∣ d²` M60 could not refute, and a positive control where both agree | **planned**: `(0, 475)` and `(19, 59)` on Heule-510 |
| Every structure-hypothesis theorem ships its inhabitant | **planned** (the certified colourings are the inhabitants; the `K₄`-at-2 and present-colour reds) |
| Kernel (priced): the 2-adic level-4 plane, one aperiodic table, the K-certificate drawing (`√11 ↦ ±√3`) | **changed**: level 4 as a table LIST (no aperiodic table exists); the drawing **declined with its price** (decision 7) |
| Kernel (priced): the forcing half as `P₅ + edge` through the LRAT pipeline, declined if > a day | **priced at 4,068 LRAT lines and planned as a should** (K3), with the decline rule |
| Tools: `fs38_tower.py`, records to m = 8 at 2, controls listed, UNSAT never a fact, the level-2 repaint at 11 as a record | **planned** (T), with a second solver on every refusal and the planted-gap control added |
| Phase D candidates (i)–(iv) | **planned** (§S5) with Poros's negative (no local witness) as input |
| Documents at the close (row 66, G54, G48, G31, re-rank, `CLOSED-QUESTIONS`, hunch ledger, bibliography, README) | **planned** (C), with two changes: FS-16 **closed** rather than kept; G54 stated one-directionally |
| "Nothing here touches Separated; FS-16 stands" | **overturned** by D0.4 (measured SAT at 11 and 19) |
| "de Grey's own forced pairs" as the tower's retrodiction | **dropped** (§S4 item 3) |
| "reproduce M56's depth-3 fact" | **changed** to "bound K-fabric forcing to depth ≥ 4; depth 2 explained; depths 4–5 unexplained" (§S4) |
| Units fixed once | **done** (§S1) |


### §S10. The skeleton — every signature and full statement, `sorry` at every leaf, elaborating

Built through `./scripts/build.sh` (never `lake build`): **`build: OK — 170 of 170 batches`** (2026-09-13, the final
run after three one-line fixes: a self-referential name inside a `UDCert.` theorem body, two `noncomputable` markers on
`PadicInt`-dependent definitions, and a NAMED `Fact (Nat.Prime 19)` instance so the root import does not collide with
`PlaneFreedom`'s anonymous one). Registered in `Proofs.lean`; `scripts/build_order.py` reads imports and needs no
telling. Six modules, 48 `sorry` leaves, listed by module with what closes each (the obligation pass, §M2, refines):

| module | imports | declarations (leaf = `sorry`) |
|---|---|---|
| `Proofs/HadwigerNelson/FanGap.lean` | `ResidueObstruction`, `CoverageMono` | `FanGap` (def, decidable), `Slack`, `DoubleSlack` (defs); leaves: `FanGap.comap`, `exists_fanGap_iff_not_coverAtLeast`, `pullbackRepaint` (the `Coloring.mk` properness), `pullbackRepaint_apply_of_mem`, `…_of_not_mem`, `not_forces_of_fanGap`, `not_fan_of_fanGap`, `not_separated_of_fanGap_of_fanGap`, `Fan.image`, `Slack.of_hom`, `Slack.forces_eq`, `Slack.forces_iff`, `Slack.self_forces_iff`, `DoubleSlack.of_hom`, `separated_iff_adj_of_doubleSlack`, `FanGap.translate`, `slack_addCayley_of_fanGap`, `doubleSlack_of_hom_to_base`; closed by term: `Slack.unitQuadrance_of_ringHom`, `DoubleSlack.unitQuadrance_of_ringHom`, `unitQuadrance_forces_eq_of_ringHom`, `UDCert.forces_eq_of_slack`, `UDCert.separated_iff_adj_of_doubleSlack` |
| `Proofs/HadwigerNelson/Instances/FanGap11.lean` | `FanGap`, `Instances/ResidueObstruction11`, `LocalGlobal`, `PlaneRotation`, `Mathlib…Padics.RingHoms` | leaves (`decide +kernel`): `finitePlane11_fanGap` (12 lookups), `finitePlane11_not_fanGap_zero` (red), `finitePlane11_doubleGap_proper` (121²), `finitePlane11_doubleGap` (22 lookups), `heule510_residue_zero_eq_475`; leaf (proof): `finitePlane11_exists_hom_to_base` (translate, then `rotHom` by the conjugate of `w − v`), `three_le_arityFloor_heule510`; closed by term: `finitePlane11_slack`, `finitePlane11_doubleSlack`, `forces_eq_of_hom_finitePlane11`, `forces_iff_of_hom_finitePlane11`, `separated_iff_adj_of_hom_finitePlane11`, `zmodPow11_forces_eq`, `padicInt11_forces_eq`, `padicInt11_separated_iff_adj`, `adjoin11PadicRes`, `adjoin11_padicInt11_forces_eq`, `UDCert.forces_eq_11`, `UDCert.separated_iff_adj_11`, `heule510_forces_eq`, `heule510_forces_iff`, `heule510_separated_iff_adj`, the two `example`s `¬ Forces … 5 0 475` and `¬ Forces … 5 19 59`; data: `finitePlane11DoubleGapTable` (121 entries, three `#guard`s) |
| `Proofs/HadwigerNelson/Instances/FanGap19.lean` | `FanGap`, `Instances/LocalGlobal19`, `LocalGlobal`, Padics | leaves: `finitePlane19QuotColouring_proper` (`decide +kernel`, 361²), `finitePlane19_fanGap` (10 lookups); closed: `finitePlane19_slack`, `forces_eq_of_hom_finitePlane19`, `zmodPow19_forces_eq`, `padicInt19_forces_eq`. No virtual-edge half (decision 10) |
| `Proofs/HadwigerNelson/TwoAdicTower.lean` | `ResidueObstruction`, `LocalGlobal` | `TwoAdicLevel` (abbrev; three `rfl` identities at levels 1, 4, 5), `twoAdicNormRe/Pi`, `twoAdicCircle` (decidable), `twoAdicPlane` (decidable adjacency), `twoAdicConj`, `twoAdicOmega` (additive homs, proved), `twoAdicLevelMap`; `example`s **passing**: `\|S_1\| = 3`, `\|S_2\| = 6`, `\|S_3\| = 12` by `decide`; leaves: `twoAdicCircle_four_card` (24), `twoAdicCircle_five_card` (48), `twoAdicOmega_mem_circle`, `twoAdicConj_mem_circle`, `twoAdicOmegaHom` (`map_rel'`), `twoAdicLevelMap_mem_circle`, `twoAdicLevelHom` (`map_rel'`), `twoAdicPlane_one_no_fanGap` (the level-one `K₄` control, `decide` over 256 functions) |
| `Proofs/HadwigerNelson/Instances/TwoAdicFour.lean` | `TwoAdicTower`, `FanGap` | data: `twoAdicFourTable₁…₅` (the five 256-entry tables of `data/fs38/p4-tables.json`, two `#guard`s), `twoAdicFourTables`; leaves: `twoAdicFourTables_proper` (`decide`), `twoAdicFourTables_cover` (`decide`, 255 × 5 × 256), `twoAdicFour_forces_iff` (`Forces.eq_of_forall_exists_not_periodic` + `forces_iff_forces_zero_sub`), `twoAdicFour_not_slack` (from level five, §S3 P-A3) |
| `Proofs/HadwigerNelson/Instances/TwoAdicFive.lean` | `Instances/TwoAdicFour`, `FanGap` | `twoAdicFiveDelta`, `twoAdicFiveDelta_ne_zero` (`decide`, closed); leaves: `twoAdicFiveDelta_mem_ker` (`decide`), `twoAdicFive_ker_eq` (`decide`), **`twoAdicFive_not_colorable_with_edge`** (the LRAT refusal through the M05 pipeline — K3's one solver-dependent leaf; if declined, this theorem and the two below it are removed, never left as `sorry`), `twoAdicFive_forces_delta`, `twoAdicFive_forces_of_ker` (the `ω`-orbit via `Forces.map (twoAdicOmegaHom 5)`), `twoAdicFive_not_forces_of_ne` (pullback of a level-four table along `twoAdicLevelHom 4`), `twoAdicFive_forces_iff`, `twoAdicFive_forces_iff'`, `twoAdicFive_not_slack` |

**Inhabitants for the vacuity gate** (every theorem whose hypothesis is a structure): `finitePlane11Colouring.toColoring`,
`finitePlane11DoubleGapColoring`, `finitePlane19QuotColoring` (the `Coloring` binders of the instance theorems);
`FanGap.lean`'s theorems bind `C : P.Coloring (Fin k)` parametrically (`GENERIC`); the reds: `finitePlane11_not_fanGap_zero`
and `twoAdicPlane_one_no_fanGap`. **Read aloud against §S2:** `not_forces_of_fanGap` is D0.2; `separated_iff_adj_of_doubleSlack`
is D0.4 with `hc` kept; `UDCert.forces_eq_11`/`heule510_forces_eq` are D0.5's certificate and witness forms;
`twoAdicFive_forces_iff` is §S3's law at its threshold.

**Data files to commit with the implementation** (not yet under `data/fs38/`): `doublegap-p11-k5.json`,
`doublegap-p19-k5.json`, `p4-tables.json` — regenerated by `tools/fs38_tower.py` and re-verified before they are records;
the planner's scratch copies are provenance only.

---

## §M1. Domain-modeling pass (`debruijn-domain-modeling`, fresh invocation, 2026-09-13)

**Grok.** Two objects. (i) A colouring `C` of a target graph `P`, a homomorphism `f : G →g P`, and a set `U` of
vertices of `G` whose images all miss a colour `γ` on their open neighbourhoods; the only move is *overwrite `C ∘ f`
with `γ` on `U`*, which is proper iff `U` is independent. Every consumer is that one move with `U` a singleton or a
pair. (ii) The additive group `O/𝔓^m` for `O = ℤ₂[ω][π]`, `π = 1 + √3`, presented as `A + πB` with `A` and `B`
Eisenstein integers modulo two adjacent powers of 2, and its norm — which is a **pair of Eisenstein forms**:
`N(A + πB) = (N(A) + 2N(B)) + π·(Tr(A, B) + 2N(B))` with `N(a + bω) = a² − ab + b²` and
`Tr(A, B) = A·B̄ + Ā·B = 2ac − ad − bc + 2bd`, the ω-components vanishing because both are rational.

**The one cut.** Intrinsic: a gap is "a colour absent from a closed neighbourhood"; the repaint's hypothesis is the
open half; independence of `U` is a property of the set; the 2-adic level is an Eisenstein module of rank 2 with
coefficient rings at two 2-powers, and the circle is the fibre of the norm form over `(1, 0)`. Incidental, and stripped:
the case split on `f u = f u'` (gone in D0.2 already); the two separate colourings the brief's double repaint used
(one colouring, two vertices); the `%`-on-ℤ form of the norm (an artefact of the pilot's Python); the "three
hypotheses" shape of the virtual-edge theorem, whose `hc` was a patch for the empty-colouring corner.

**Placement.** Everything extrinsic. `FanGap`, `Slack`, the new `Fusable` are predicates beside `SimpleGraph.Coloring`;
`TwoAdicLevel m` stays a plain product (its `AddCommGroup`, `Fintype`, `DecidableEq` come free) and the norm form is a
function beside it — no index carries a level, no subtype carries "on the circle".

**Reframes taken.**
1. **`DoubleSlack` → `Fusable`.** The virtual-edge theorem's true hypothesis is one predicate on pairs of `P`:
   `Fusable P k v w := ∃ C, C v = C w ∨ ∃ γ, SharedGap C v w γ` (a colouring that coincides at the pair, or shares a
   gap at it). It is hereditary under homomorphisms (`Fusable.of_hom`: pull back the coincidence, or the two gaps),
   it supplies its own colouring (so the `k = 0`/edgeless corner needs no `hc`), and at `11` it is assembled by cases
   — adjacent: the shared-gap table transported; non-adjacent or equal: M60's `finitePlane11_separated_iff` read as
   `¬ Separated`, i.e. a coincidence. Statement: `separated_iff_adj_of_fusable (h : ∀ v w, Fusable P k v w) (f : G →g P) :
   Separated G k u u' ↔ G.Adj u u'` — one hypothesis, and it is exactly what the plane has.
2. **The repaint is `Set.piecewise`.** `pullbackRepaint f C U γ … := Coloring.mk (U.piecewise (fun _ => γ) (C ∘ f)) _`,
   with `hind : G.IsIndepSet U` (Mathlib's name for the independence) and `hgap` the open half of the gaps. The two
   apply lemmas are `Set.piecewise_eq_of_mem` / `Set.piecewise_eq_of_not_mem` — no `if`, no classical `Decidable`
   threaded through statements.
3. **`SharedGap C v w γ := FanGap C v γ ∧ FanGap C w γ`**, named because it is decided on the table, transported along
   automorphisms, and consumed by the double repaint and by `Fusable` — three uses, one name.
4. **Eisenstein forms in the ring, not integers modulo.** `EisMod n := ZMod n × ZMod n` with `norm`, `trace`, `conj`,
   `omegaMul` (the last two additive homs); `TwoAdicLevel m := EisMod (2 ^ ((m+1)/2)) × EisMod (2 ^ (m/2))` (the same
   type as before); `normForm m z := (norm z.1 + dbl m (norm z.2), trace (castDown m z.1) z.2 + 2 · norm z.2)` valued
   in `ZMod (2 ^ ((m+1)/2)) × ZMod (2 ^ (m/2))`; `twoAdicCircle m := {z | normForm m z = (1, 0)}`. Two bridging maps
   carry the mixed moduli: `castDown m : ZMod (2 ^ ((m+1)/2)) →+* ZMod (2 ^ (m/2))` (a ring hom, `ZMod.castHom`) and
   `dbl m : ZMod (2 ^ (m/2)) →+ ZMod (2 ^ ((m+1)/2))`, `x ↦ 2·x̃` (additive; the only place `val` appears). The ω- and
   conjugation-invariance of the circle become `ring` identities on `EisMod` (`norm_omegaMul`, `trace_omegaMul_omegaMul`,
   `norm_conj`, `trace_conj_conj`) plus `map_*` for the two bridges — instead of modular arithmetic on integers.
5. **One cast family.** `castDown (m+1)` is the level map's `A`-component and `castDown m` its `B`-component AND the
   in-level reduction inside `normPi`; the four repeated `ZMod.castHom (pow_dvd_pow 2 (by omega …))` collapse to one
   definition, and `normForm` commutes with the level map by `map_add`/`map_mul` and one lemma about `dbl`.

**Ugliness read and answered.** `hc` threaded for a corner case → reframe 1. `if x ∈ U` under `open Classical` with two
hand apply-lemmas → reframe 2. Integer `%` on a quantity that lives in `ZMod` → reframe 4. Four copies of one cast →
reframe 5. `FanGap`'s two conjuncts, the `k − 1` in the coverage bridge (correct at `k = 0`: both sides false), the
product type with `z.1.1` projections: read, kept — no consumer inspects a level index, and the tables index by four
`Fin 4`s exactly as `z.1.1 z.1.2 z.2.1 z.2.2`.

**Seams validated.** Unsampled members: `k = 0` (every `FanGap` false; `Slack`/`Fusable` false on a nonempty graph; the
theorems' hypotheses fail rather than their conclusions lying); an edgeless `P` (`Slack` true for `k ≥ 2`, and indeed no
pair is forced); `TwoAdicLevel 0` (one vertex, no edge; harmless); a `U` with two vertices of one fibre (the repaint
is fine). Adversarial member: a `Slack` graph is never uniquely colourable — consistent with `[KlotzSander2017]`'s
opposite pole. Illegal states: none in `TwoAdicLevel m` (every tuple is an element of `O/𝔓^m`, [hand 1]). Next-lemma
test: "one colouring gapped everywhere" (D-4) states as `∃ C, ∀ v, ∃ γ, FanGap C v γ`; "conjugation is an automorphism"
states as `Prod.map conj conj`; the depth of a difference is the kernel of `twoAdicLevelMap`, no depth function needed.
Decorrelated checks: the level-1..3 circle counts `decide` in the build against the derivation; the tables were
verified by an independent Python check and are `decide`d in K3.

**Applied to the skeleton** (this commit; build re-run): `FanGap.lean` — `SharedGap`, `Fusable`, `Fusable.of_hom`,
`not_separated_of_sharedGap`, `not_separated_of_fusable`, `separated_iff_adj_of_fusable`, `fusable_of_not_separated`,
`fusable_of_hom_to_base`, the repaint via `Set.piecewise`/`IsIndepSet`; `DoubleSlack` removed. `Instances/FanGap11.lean`
— `finitePlane11_sharedGap`, `finitePlane11_fusable`, consumers restated. `TwoAdicTower.lean` — `EisMod` with its four
forms and their invariance lemmas, `castDown`, `dbl`, `normForm`, the circle as a fibre, `twoAdicOmega`/`twoAdicConj` as
`prodMap`s, the level map as `prodMap` of `castDown`s. §S10's leaf list is superseded by the modules themselves; the
count moves with the pass (`grep -c sorry`).

---

## §M2. Obligation-modeling pass (`debruijn-obligation-modeling`, fresh invocation, 2026-09-13)

**The space.** No induction anywhere: every general leaf is a finite case analysis (a `by_cases` on membership, a
`rcases` on a disjunction, a `Prod.ext`) and every instance leaf is `decide` over a finite type. The one recursion in
sight — the tower's levels — never enters a proof: each statement is at one level or across one level map. So the
recursor is `cases`, the local obligation of every theorem is one case of a repaint or one component of a form, and
the pass's work is naming the stepping stones so the cases are two lines.

**Partition.** *Prove*: the general theorems of `FanGap.lean`, the Eisenstein invariances and commutations, the
level-map facts, the 19 properness (derived, below). *Test*: every `decide` — the two gaps at 11, the shared gap, the
two table propernesses, the circle counts at 4 and 5, the cover, the kernel enumeration, the `K₄` control, the
`#guard`s. *Assume*: nothing inside the kernel; [hand 1]/[hand 2] stay outside it (§S3).

**A false leaf, caught (the pass's best product).** `twoAdicLevelHom (m) : twoAdicPlane (m + 1) →g twoAdicPlane m`
is uninhabitable at `m = 0`: level 0 has one vertex and no edge, level 1 is `K₄`, and a homomorphism cannot send an
edge to a loop — `addCayley_adj` demands `L u ≠ L v`, which fails exactly when `1 = 0` in `ZMod (2 ^ ⌈m/2⌉)`, i.e.
at `m = 0`. **Statement changed:** `twoAdicLevelHom (m : ℕ) : twoAdicPlane (m + 2) →g twoAdicPlane (m + 1)` with
`toFun := twoAdicLevelMap (m + 1)`; the additive map `twoAdicLevelMap` stays at every `m` (it is fine at 0), and
`twoAdicLevelMap_mem_circle` stays at every `m` (level 0's circle is everything). The local obligation that carries
`map_rel'`: **`twoAdicLevelMap_ne_zero_of_mem_circle`** — an element of `S_{m+2}` maps to a nonzero element of level
`m + 1`, because its image lies on `S_{m+1}` by commutation and `(1, 0) ≠ (0, 0)` there (`Fact (1 < 2 ^ ((m+2)/2))`).
That is "no fibre carries an edge", as a lemma. The consumer at level five uses `twoAdicLevelHom 3 : P₅ →g P₄`.

**The stepping stones, named (added to the skeleton as leaves, so the descent is visible in the file):**

| stone | statement | closes |
|---|---|---|
| `repaintAt f C u γ hgap` | the singleton repaint, `pullbackRepaint f C {u} γ (Set.pairwise_singleton _ _) _`, with `repaintAt_apply_self` and `repaintAt_apply_of_ne` | `not_forces_of_fanGap`, `not_fan_of_fanGap` in four lines each (no `Set.mem_singleton_iff` bookkeeping repeated) |
| `EisMod.omegaMul_omegaMul_omegaMul` | `ω³ = id` (`ext; simp; ring`) | `twoAdicOmega_injective` (a left inverse), hence `ω u ≠ ω v` in `twoAdicOmegaHom.map_rel'` |
| `EisMod.norm_map`, `EisMod.trace_map` | `norm (Prod.map φ φ z) = φ (norm z)`, `trace (Prod.map φ φ z) (Prod.map φ φ w) = φ (trace z w)` for a ring hom `φ` (`map_add`, `map_mul`, `map_sub`, `map_pow`, `map_ofNat`) | `normForm_twoAdicLevelMap`'s second component; `normForm_twoAdicOmega` via `omegaMul_map` |
| `EisMod.omegaMul_map` | `omegaMul (Prod.map φ φ z) = Prod.map φ φ (omegaMul z)` (`map_neg`, `map_sub`) | the `castDown` inside `normForm` commutes with `ω` |
| `castDown_dbl` | `castDown (m + 1) (dbl (m + 1) x) = dbl m (castDown m x)` — both sides are `2·x̃` read modulo `2^⌈m/2⌉`, and `2^⌈m/2⌉ ∣ 2^{⌊m/2⌋+1}` | `normForm_twoAdicLevelMap`'s first component; the only `val` lemma beside `dbl.map_add'` |
| `dbl.map_add'` | `2·((x + y).val) = 2·x.val + 2·y.val` in `ZMod (2 ^ ⌈m/2⌉)`: `ZMod.val_add`, `Nat.mod_add_div`, and `((2 ^ (⌊m/2⌋ + 1) : ℕ) : ZMod (2 ^ ⌈m/2⌉)) = 0` by `ZMod.natCast_zmod_eq_zero_iff_dvd` and `pow_dvd_pow` (`omega` for the exponent inequality) | `dbl` itself |
| `three_le_arityFloor_of_forces_eq_of_separated_adj` | `G.Colorable k → (∀ u v, Forces G k u v → u = v) → (∀ u v, Separated G k u v → G.Adj u v) → 3 ≤ arityFloor G k` — the general form of `three_le_arityFloor_of_aperiodic_coincides` (`ResidueObstruction.lean:185`), whose proof body uses only these three facts through `le_arityFloor_iff` and `two_le_arityFloor` (G30 §6: a theorem was available where an instance was recorded) | `three_le_arityFloor_heule510` in one line, and any future object with both iffs |
| `finitePlane19QuotColouring_proper` **derived, not decided** | from `circ19_ker`, `circ19_image`, `circ19_proper` and `map_sub`: an edge's difference is on the circle, its projection is in `circ19D` and nonzero, so `circ19Table` differs — the argument inside `unitQuadrance_colorable_of_quotient`, replayed for this named colouring | a 361²-pair `decide` avoided |

**Per-leaf shapes (the case table each proof transcribes).**
- `FanGap.comap`: `⟨h.1, fun w hw => h.2 (f w) (f.map_rel hw)⟩` — `(C.comap f) x = C (f x)` is `rfl`.
- `pullbackRepaint` properness: four cases on `x ∈ U`, `y ∈ U`; (in, in) is `hind hx hy (G.ne_of_adj hxy) hxy`;
  (in, out) is `hgap x hx (f y) (f.map_rel hxy)` after `Set.piecewise_eq_of_mem/_of_not_mem`; (out, in) the same
  with `hxy.symm`; (out, out) is `C.valid (f.map_rel hxy)`.
- `not_forces_of_fanGap`: `by_cases hc : C (f u) = C (f u')`; if not, `hF (C.comap f)` contradicts; if so, `hF (repaintAt f C u γ h.2)`
  reads `γ = C (f u')`, then `hc ▸ h.1`.
- `not_separated_of_sharedGap`: `U = {u, u'}`, independence from `Set.pairwise_pair` (`hadj` and `hadj ∘ Adj.symm`), the
  gap hypothesis by `Set.mem_insert_iff`/`mem_singleton_iff`; the two `apply_of_mem`s give `γ = γ`.
- `not_separated_of_fusable`: `rcases` the disjunction; coincidence pulls back (`hS (C.comap f) hc`), the shared gap is
  the previous theorem. `Fusable.of_hom`, `fusable_of_not_separated` (classical `not_forall`, `not_not`),
  `separated_iff_adj_of_fusable` (`by_contra` + `Separated.of_adj`): two or three lines each.
- `FanGap.translate`: `addCayleyTranslate_apply`, `add_sub_cancel`, `addCayley_adj_add_iff_right`; `slack_addCayley_of_fanGap`:
  translate by `v − x` and `sub_sub_cancel`. `fusable_of_hom_to_base`: `hv.symm ▸ h₀.1`, `.comap σ`.
- `exists_fanGap_iff_not_coverAtLeast`: split into `not_coverAtLeast_of_fanGap` (→: `coverColors` excludes `C v` and `γ`,
  so its card is `≤ k − 2 < k − 1`, with `k ≥ 2` from `γ ≠ C v`) and `exists_fanGap_of_not_coverAtLeast` (←: a colouring
  with `card < k − 1` leaves `coverColors ∪ {C v}` short of `univ`, so `Finset.eq_univ_iff_forall` yields the gap); a
  helper `coverColors_nil` (the `Q = []` clause is `v ∈ []`, false). ~25 lines; a "should", the record's vocabulary only.
- `finitePlane11_exists_hom_to_base`: `σ := (rotHom h').comp (addCayleyTranslate _ (−v))` with `d = w − v` on the circle
  (`unitQuadrance_adj`), `h' : d.1 ^ 2 + (−d.2) ^ 2 = 1` (`neg_sq`); `σ v = rot 0 = 0`, `σ w = rot_{(a,−b)} (a, b) = (a² + b², 0) = (1, 0)`
  by `rotHom_apply` and `linear_combination`.
- `finitePlane11_fusable`: `by_cases` adjacency; adjacent → `fusable_of_hom_to_base finitePlane11_sharedGap …`; else
  `fusable_of_not_separated (fun hS => h (finitePlane11_separated_iff.mp hS))`.
- `twoAdicOmegaHom.map_rel'`: `addCayley_adj` both sides; `ω u ≠ ω v` by injectivity; `−ω u + ω v = ω (−u + v)` by
  `map_neg`, `map_add`; membership by `twoAdicOmega_mem_circle`. `twoAdicLevelHom.map_rel'`: the same with
  `twoAdicLevelMap_ne_zero_of_mem_circle` in place of injectivity.
- `normForm_twoAdicOmega`, `normForm_twoAdicConj`, `normForm_twoAdicLevelMap`: `Prod.ext` then the stones.
- `twoAdicFour_forces_iff`: bundle each table as `Coloring.mk col (twoAdicFourTables_proper col hmem)`; the cover
  supplies `∀ d ≠ 0, ∃ c, ¬ Periodic c d`; `Forces.eq_of_forall_exists_not_periodic` (`LocalGlobal.lean:134`) closes →.
- `twoAdicFive_forces_delta`: a colouring with `C 0 ≠ C δ` is a colouring of `P₅ ⊔ fromEdgeSet {s(0, δ)}` (`sup_adj`,
  `fromEdgeSet_adj`, `Sym2.eq_iff`), refuted by the LRAT leaf. `twoAdicFive_forces_of_ker`: `rcases twoAdicFive_ker_eq hd`
  into the four elements; `Forces.map _ (twoAdicOmegaHom 5)` with `map_zero` carries `δ` to `ωδ` to `ω²δ`.
  `twoAdicFive_not_forces_of_ne`: `hF.image (twoAdicLevelHom 3)` lands in `P₄`, `twoAdicFour_forces_iff` says `0 = L d`.
  `twoAdicFive_not_slack`: `Slack.self_forces_iff` against `δ ≠ 0`. `twoAdicFour_not_slack`: **one line** —
  `fun h => twoAdicFive_not_slack (h.of_hom (twoAdicLevelHom 3))` (slackness pulls UP along the level hom).

**`decide` budgets** (kernel, from the record's measured rates): the gap at 11, 121 adjacency checks — trivial; the
shared-gap table's properness, 121² = 14,641 pairs — the same as `finitePlane11_colouring_proper`, seconds; the 19 gap,
361 checks; the circle counts at 4 and 5, 256 and 1,024 `normForm` evaluations; the kernel enumeration at level five,
1,024 `castHom` evaluations; the `K₄` control, 256 functions × 32 checks. **The two expensive ones:** each level-4
table's properness as stated — `∀ u v, Adj u v → …` — is 65,536 pairs each evaluating `normForm` twice, ×5 tables
≈ 650k form evaluations; **measure one table first** (Poros). If it exceeds a minute, restate through the circle as a
literal: `twoAdicCircleFour : List (TwoAdicLevel 4)` (24 entries) with `mem_twoAdicCircle_four_iff` (256 evaluations,
once), then properness as `∀ z, ∀ s ∈ list, col z ≠ col (z + s)` (5 × 256 × 24 = 30,720 lookups) bridged to `Adj` by
`addCayley_adj` — M04's "emit big tables as literals" rule applied to the connection set. The cover is 255 × 5 × 256
lookups with no form evaluation; fine as stated.

**The one solver-dependent leaf.** `twoAdicFive_not_colorable_with_edge` decomposes as: (i) the computable equivalence
`TwoAdicLevel 5 ≃ Fin 1024` (`finProdFinEquiv` twice — no literal needed); (ii) the edge list `E'` on `Fin 1024`
emitted by `tools/fs38_tower.py lrat` (24,577 pairs, as a generated `Edges.lean`); (iii) `decide`: every listed pair is
an edge of `P₅ ⊔ fromEdgeSet {s(0, δ)}` under the equivalence, and (completeness, so the CNF is the whole graph) every
edge is listed — 24,577 + 1,024 × 48 checks; (iv) the pipeline's `¬ (edgeGraph 1024 E').Colorable 4` from the LRAT
(`emit_mask.py`, `regen-check.sh`'s flags; the pins are the pipeline's, as for Heule-553); (v) the homomorphism
`edgeGraph 1024 E' →g P₅ ⊔ edge` from (iii) and `Colorable.of_hom`. Completeness (iii, second half) is not needed for
soundness — a subgraph's refusal refutes the whole — and is kept only as the check that the certificate is about the
object named; drop it if its `decide` is the expensive part.

**Adversarial validation the implementer runs at the close** (each must BREAK): delete `hne` from
`not_forces_of_fanGap` (then `u = u'` and the repaint separates nothing); drop `γ ≠ C v` from `FanGap` (then
`γ = C (f u)` and the repainted `u` matches `u'`); drop `hadj` from `not_separated_of_sharedGap` (independence of
`{u, u'}` fails); shift the level hom back to `m + 1 → m` (the `m = 0` case is the counterexample found above); change
one entry of the shared-gap table (the `decide` refuses); `#print axioms` on every public theorem of the six modules
(`scripts/axioms.sh`), since a `sorry` three imports deep inherits silently.

**Applied to the skeleton** (this commit; build re-run): `twoAdicLevelHom` re-indexed; the eight stones added as
leaves with their statements; `twoAdicFive_not_forces_of_ne`'s and `twoAdicFour_not_slack`'s docstrings name
`twoAdicLevelHom 3`; `finitePlane19QuotColouring_proper`'s docstring names its derivation.

---

## §M3. Experience-modeling pass (`debruijn-experience-modeling`, fresh invocation, 2026-09-13)

**The users, inhabited.** (1) The implementer of an instance module, holding `f : G →g finitePlane 11` and a goal
`Forces G 5 u u' ↔ u = u'`: wants one name to cite and dot-notation that reads. (2) The reader of the record (row 66,
G54, the report), who cites names for a stranger: wants the theorem about the graph itself, not the homomorphism
bookkeeping. (3) The next prime — someone with a 5-colouring of `UD(𝔽_p, 2)` for `p = 23, 31, …` should the
undecided planes fall: wants a recipe that never mentions `11`. (4) `exact?`, holding a goal `u = u'` with `f` and
`h : Forces G 5 u u'` in context: finds a lemma only if its conclusion is the goal and its side goals close from
context — so the instance wrappers (`forces_eq_of_hom_finitePlane11 f h`) are what it returns; `Slack.forces_eq_of_hom
finitePlane11_slack f h` it cannot, since `finitePlane11_slack` is a library constant, not a hypothesis. (5) `simp`,
holding exactly the tagged set: the Eisenstein invariances and the rfl-apply lemmas of the graph homs.

**Reframes taken (applied to the skeleton in this commit).**
1. **One convention for both hereditary properties: the graph-alone theorem is primary, the hom form is `_of_hom`.**
   `Slack.forces_eq`/`Slack.forces_iff` are now statements about a slack graph `G` itself; `Slack.forces_eq_of_hom`/
   `Slack.forces_iff_of_hom` take `h : Slack P k` and `f : G →g P` (one line each through `Slack.of_hom`). `self_forces_iff`
   is gone — it was the primary statement wearing a qualifier. The ∀-pairs property is named, so it gets the same shape:
   `PairwiseFusable P k := ∀ v w, Fusable P k v w`, `PairwiseFusable.of_hom`, `PairwiseFusable.separated_iff_adj`
   (graph-alone; Poros's suggestion), `PairwiseFusable.separated_iff_adj_of_hom`. Consumers read
   `finitePlane11_slack.forces_iff_of_hom f` and `finitePlane11_pairwiseFusable.separated_iff_adj_of_hom f`; the record
   reads "a slack graph has no forced pair; a pairwise-fusable graph has no virtual non-edge; both pass to every graph
   mapping into it".
2. **The base-edge transport is a theorem about every `unitQuadrance R`, not about `11`** (G30 §6): for any commutative
   ring, an edge `v ~ w` is carried onto `((0,0), (1,0))` by translation then rotation by the conjugate of `w − v`
   (`unitQuadrance_exists_hom_to_base`), so one shared-gap table at the base edge makes every edge fusable
   (`unitQuadrance_fusable_of_sharedGap_base`). `finitePlane11_exists_hom_to_base` is deleted; the 11 module assembles
   `finitePlane11_pairwiseFusable` from the general lemma and M60's coincidences. The recipe for the next prime is then:
   a table with a gap (`decide`) → `slack_addCayley_of_fanGap`; a table with a shared gap at the base edge (`decide`) →
   `unitQuadrance_fusable_of_sharedGap_base`; the plane's own coincidences → `fusable_of_not_separated`. `FanGap.lean`
   imports `PlaneRotation` for `rotHom`.
3. **`simp` normal forms.** The invariances rewrite toward "no `ω`, no conjugation, no ring hom inside a form":
   `EisMod.norm_omegaMul`, `norm_conj`, `norm_map`, `trace_omegaMul_omegaMul`, `trace_conj_conj`, `trace_map` are `@[simp]`;
   `omegaMul_map` is stated as `Prod.map φ φ (omegaMul z) = omegaMul (Prod.map φ φ z)` (map inward, `ω` outward) so that
   `trace_omegaMul_omegaMul` fires next; `castDown_dbl` pushes the cast inward. Each strips one constructor from the
   argument of a form, so the set terminates. The rfl lemmas `twoAdicOmegaHom_apply`, `twoAdicLevelHom_apply`,
   `repaintAt_apply_self` are `@[simp]` too; the conditional apply lemmas stay untagged (simp uses them when the
   membership is in context).
4. **Two reds added** where a consumer would first mistrust a table: `finitePlane11_sharedGap_corrupt_refused` (the
   base table with `(0, 0)` overwritten by the gap colour is refused as a shared gap — the M04 "corrupted table" pattern)
   and `finitePlane19_not_fanGap_zero` (a present colour refused at 19).

**Names, cold-read.** `FanGap` (the record's fan vocabulary; the docstring says "not frozen" for the stranger),
`Slack`, `SharedGap`, `Fusable`, `PairwiseFusable`, `repaintAt`, `pullbackRepaint`: each reads as its one-line contract.
`castDown`, `dbl`, `normForm`, `EisMod`, and the `twoAdic*` prefix: one vocabulary. Instance names follow the record's
`<conclusion>_of_hom_<target>` and `<object>_<conclusion>` patterns and the `_11` suffix of M60. The convention is a
contract: `X.of_hom`, `X.<conclusion>`, `X.<conclusion>_of_hom` for both hereditary properties.

**Argument order.** The homomorphism first, the property second (`Slack.of_hom f h`, `FanGap.comap f h`), matching
Mathlib's `Coloring.comap f C`, so dot-notation reads `h.of_hom f`, `h.comap f`. Statements the instances cite are
never stated on the wrong side of an iff: `Forces ↔ =` and `Separated ↔ Adj`, with the `→` halves named (`forces_eq`).

**Breakdown surface.** A consumer whose table lacks a gap sees `decide` refuse `FanGap …` — the honest failure, at the
span of the claim. The reds pin it. No tactic, no notation, no `autoParam` is minted: the domain owns none, and the
zero-annotation path is the instance wrapper.

**Validated as the user.** API-only proof: `heule510_forces_iff`, `heule510_separated_iff_adj`,
`three_le_arityFloor_heule510` close from public names alone with no `unfold`. The next-prime recipe is stated above in
five names and mentions no prime. Every "Try this" a reader would paste — the instance wrappers — elaborates in the
build. Unrequested bytes refused: no `Bool` twin of `FanGap` (decidability suffices), no notation, no typeclass.

---

## §R1. The kernel, read aloud against the claims (phases K1 and K2, 2026-09-13)

*Written by the implementing engineer. Phase K3's results and the tools-side records live in
`plans/FS38-tower-records.md`, not here. Every statement below is `sorry`-free and on the standard three axioms.*

### R1.1 The general theorems, read aloud (`Proofs/HadwigerNelson/FanGap.lean`, 0 `sorry`)

**§S2 D0.1, the repaint.** *Claimed:* "for `f : G →g P`, a colouring `C` of `P`, an independent `U ⊆ V(G)` and a
colour `γ` absent from `N_P(f u)` for every `u ∈ U`, the map `γ` on `U` and `C ∘ f` off `U` is a proper colouring of
`G`; graph-level, no finiteness, no surjectivity, and `γ ≠ C (f u)` is not needed." *The statement says:*
`pullbackRepaint (f : G →g P) (C : P.Coloring (Fin k)) (U : Set V) (γ : Fin k) (hind : G.IsIndepSet U)
(hgap : ∀ u ∈ U, ∀ w, P.Adj (f u) w → C w ≠ γ) : G.Coloring (Fin k)` — `Set.piecewise`, four cases on membership, no
`Fintype`, no `Nontrivial`, no hypothesis relating `γ` to `C (f u)`. *Not claimed:* nothing about `U` beyond
independence, and nothing about `f` beyond being a homomorphism.

**§S2 D0.2, the fan-gap theorem.** *Claimed:* "`f : G →g P`, `FanGap C (f u) γ`, `u ≠ u'` ⟹ `¬ Forces G k u u'`;
no case split on `f u = f u'`, no forces-freeness hypothesis on `P`." *The statement says:* exactly that —
`not_forces_of_fanGap (f : G →g P) (h : FanGap C (f u) γ) (hne : u ≠ u') : ¬ Forces G k u u'`. The two branches are
`C (f u) ≠ C (f u')` (the pullback separates) and `=` (the singleton repaint separates). *Not claimed:* nothing when
`u = u'` — and that is not slack, it is false, since a vertex is forced equal to itself (control C1 below).

**§S2 D0.2 (a), slackness is forces-freeness.** `Slack.forces_iff (h : Slack G k) : Forces G k u u' ↔ u = u'`, with
`Slack.forces_iff_of_hom (h : Slack P k) (f : G →g P)` as the consumer form. The brief's "forces-free `P`" premise is
gone, and its absence is a theorem rather than an omission: `P` itself is slack, so `P` is forces-free.
**No `Colorable` premise appears, and none is missing:** `Slack G k` exhibits a `k`-colouring at every vertex, so it
*implies* `G.Colorable k` on a nonempty vertex type; the vacuous corner (no colourings, every pair forced) cannot
satisfy the hypothesis.

**§S2 D0.3, the arity-`k` filter.** `not_fan_of_fanGap (h : FanGap C (f p) γ) (hQ : ∀ q ∈ Q, q ≠ p ∧ C (f q) ≠ γ) :
¬ Fan G k p Q`. *Read aloud:* a fan dies when some gapped colouring puts every partner's image off the gap colour.
*Not claimed, and the scope is the point:* a fan one of whose partners lands on `γ` in every gapped colouring of `P`
**survives**, so G15's wide-class pigeonholes are untouched. The hypothesis is on the list `Q`, per colouring.

**§S2 D0.4, the double repaint.** *Claimed:* "one colouring with the same `γ` absent from both closed neighbourhoods
of `f u` and `f u'`, and `¬ G.Adj u u'`, gives `¬ Separated G k u u'`." *The statement says:*
`not_separated_of_sharedGap (h : SharedGap C (f u) (f u') γ) (hadj : ¬ G.Adj u u') : ¬ Separated G k u u'`, the repaint
over `{u, u'}` whose independence is exactly `hadj`. The composite iff ships as
`PairwiseFusable.separated_iff_adj (h : PairwiseFusable G k) : Separated G k u u' ↔ G.Adj u u'`, with the `_of_hom`
form for consumers. **The shipped shape is §M3's `Fusable`, not §S2's `DoubleSlack`,** and that settles the one point
Poros and the planner disputed at subplanning: `DoubleSlack` needed `P.Colorable k` (edgeless `P` at `k = 0` makes
`DoubleSlack` vacuous, `Separated` true for want of colourings and `Adj` false), while `Fusable P k v w` — *some*
colouring coincides at the pair or shares a gap at it — **carries its own colouring per pair**, so the premise is
implied rather than assumed. Neither statement was weakened to close.

**Transports, each read as "no arithmetic, no prime".** `FanGap.comap` (a gap at the image is a gap upstairs);
`Slack.of_hom`, `Fusable.of_hom`, `PairwiseFusable.of_hom` (heredity under any homomorphism, **no surjectivity**);
`FanGap.translate` and `slack_addCayley_of_fanGap` (on a Cayley graph of any abelian group, ONE gapped vertex is
slackness everywhere); `unitQuadrance_exists_hom_to_base` and `unitQuadrance_fusable_of_sharedGap_base` (over EVERY
commutative ring, one shared-gap table at the base edge `((0,0), (1,0))` makes every edge fusable, by translation then
rotation by the conjugate of `w − v`); `Slack.unitQuadrance_of_ringHom` and `PairwiseFusable.unitQuadrance_of_ringHom`
(the finite-plane bound as functoriality, so the tower and the completions are **instances, not induction steps**);
`UDCert.forces_eq_of_slack` and `UDCert.separated_iff_adj_of_fusable` (the certificate forms, M58's hypotheses
exactly, every pair, with no "images distinct"). `three_le_arityFloor_of_forces_eq_of_separated_adj` is the general
form of M60's `three_le_arityFloor_of_aperiodic_coincides` — G30 §6, a theorem where an instance had been recorded.
`Fan.image` and `exists_fanGap_iff_not_coverAtLeast` are the record's vocabulary, the latter tying a gap to the
failure of `CoverAtLeast P k v [] (k − 1)` in both directions.

### R1.2 The instances at 11, read aloud (`Instances/FanGap11.lean`, 0 `sorry`)

*Claimed (§S2 D0.5):* "with `Slack` and pairwise fusability of `UD(𝔽₁₁, 2)` at five colours, for every graph `G` with a
homomorphism into the plane: `Forces G 5 u u' ↔ u = u'` and `Separated G 5 u u' ↔ G.Adj u u'` — the whole arity-2
compulsion structure of the sealing plane pulls back." *The statements say* exactly that
(`forces_iff_of_hom_finitePlane11`, `separated_iff_adj_of_hom_finitePlane11`), resting on two `decide`s over two
121-entry tables: `finitePlane11_fanGap` (colour `2` absent from `N[(2, 4)]` in the certified table) and
`finitePlane11_sharedGap` (colour `4` absent from `N[(0,0)] ∪ N[(1,0)]` in the SAT-found table, whose properness is
decided over all `121²` pairs). The instances: `zmodPow11_forces_eq` (every level `ZMod (11 ^ m)`, `m ≠ 0`),
`padicInt11_forces_eq` and `padicInt11_separated_iff_adj` (`ℤ_[11]`, through Mathlib's `PadicInt.toZMod`),
`adjoin11_padicInt11_forces_eq` (`Adjoin 11 ℤ_[11]`), `UDCert.forces_eq_11` and `UDCert.separated_iff_adj_11` (every
`Valid` `√7`-free certificate with `11 ∤ D`), and Heule-510's three theorems plus `three_le_arityFloor_heule510`.
`heule510_residue_zero_eq_475` puts vertices `0` and `475` in the same residue class, so the pair M60's residue law
was silent about is refuted here, and `(19, 59)` — the `5/3` pair where M60 and this agree — is the control.

**What is NOT claimed, restated so it cannot be read past.** (i) The **field-level sentence** — that no finite
unit-distance graph over a field with a usable prime of residue degree one above 11 carries a five-colour pair
compulsion — needs M58/M60's hand step (translate a vertex to the origin; then every coordinate is `𝔭`-integral) and
is **not formalized**; it is row 57's open gap. (ii) Nothing about a field whose planes at usable primes refuse five
colours — de Grey's at 131, the `ρ₆₃` arena's `K(√7)` at 83: by definition of 6-open no 5-colourable residue target
exists, so these theorems have no hypothesis to take there, and the measured nulls on those objects stay measured.
(iii) **Arity 2 only.** (iv) Nothing about `𝔭` above 2, where the level-one object is `K₄` and has no gap at all — **[hand until K3]**: every closed neighbourhood of `K₄` is the whole of it, so no colour is free; the kernel form is phase K3's `twoAdicPlane_one_no_fanGap`, still a leaf.

### R1.3 The instances at 19 (`Instances/FanGap19.lean`, 0 `sorry`) — and a FALSE statement in the skeleton

`finitePlane19QuotColouring_proper` is **derived, not decided**, as §M2 designed it (an edge's difference lies on the
circle, so its projection along `(1,1)` is nonzero and lands in `circ19D`, where `circ19Table` never repeats) — a
`361²`-pair `decide` avoided. Then `finitePlane19_fanGap`, `finitePlane19_slack`, `forces_eq_of_hom_finitePlane19`,
`zmodPow19_forces_eq`, `padicInt19_forces_eq`. No virtual-edge half at 19 (§S8 decision 10, unchanged).

**The finding.** The skeleton's gap witness at 19 was **false**, and `decide +kernel` refuted it:
`projAlong (1,1) w = 1·w.2 − 1·w.1 = y − x`, **not** `x + y`, which both the module docstring ("at `x + y = 4`") and
the skeleton's vertex `(4, 0)` assumed. `(4, 0)` lies in the class `y − x = −4 = 15`, where the colour is `1` and the
ten neighbour classes carry `{0, 2, 3, 4}` — **all five colours on the closed neighbourhood, no gap at all.**
Enumerating all nineteen classes, **exactly two are gapped**: class `4` (own colour `4`, gap `1`) and class `10` (own
colour `3`, gap `1`). So the witness is not generic and the coordinate is load-bearing. The vertex is now `(0, 4)`
(class `4`) for the gap and for its red alike; **nothing was weakened** — `finitePlane19_slack` is the same statement,
because the Cayley transport is translation-invariant — and the module doc now states the projection, names both
gapped classes, and records that `(4, 0)` has no gap. The advisor had independently reported the same misreading
("at (4,0) its colour is 4"), which is the reading for the *class* 4 and not for that vertex; two readers made one
error, and only the kernel caught it.

### R1.4 The negative controls, with the kernel's exact complaint

*Sharpened beyond what §M2 asked: instead of watching a proof break when a hypothesis is deleted, each weakened
**statement** is refuted by a concrete model, so what is recorded is falsity and not unprovability. The three are
**library content** at the end of `FanGap.lean` (a commit message is not a record — CLAUDE.md, row 65), so the build
re-runs them; each concludes `False`, which is why `vacuity.sh`'s refutations-skipped count moves by three.*

| # | the weakening | what happens |
|---|---|---|
| C1 | `not_forces_of_fanGap` without `u ≠ u'` | **statement false**: `not_forces_of_fanGap_needs_ne` derives `False` from it at one vertex, no edges, two colours (a vertex is forced equal to itself, and a gap does not change that). As a proof-break: `Unknown identifier hne.symm`. |
| C2 | `FanGap` without its first conjunct `γ ≠ C v` | **statement false**: `fanGap_needs_ne_own_colour` derives `False` at two vertices, no edges, **one** colour — where the gap colour is forced to be the vertex's own, so the repaint changes nothing. As a def-change: the `Decidable` instance fails the kernel's type check and four `⟨…⟩`/`rcases` sites stop being inductive. |
| C3 | `not_separated_of_sharedGap` without `¬ G.Adj u u'` | **statement false**: `not_separated_of_sharedGap_needs_nonadjacent` derives `False` at `K₂` with three colours (an edge shares a gap and is separated by every colouring). As a proof-break: `Unknown identifier hadj` at the independence step. |
| — | the faithful partner | `example : ¬ Forces (⊥ : SimpleGraph (Fin 2)) 2 0 1` through `not_forces_of_fanGap` **passes**, so the three refusals are about the deleted hypotheses and not about the scaffolding. |
| C4 | `finitePlane11DoubleGapTable` entry `(0, 1)`: `2 → 0` | the **properness** `decide` refuses: *"Tactic `decide` proved that the proposition `∀ {u v}, (finitePlane 11).Adj u v → finitePlane11DoubleGapColouring u ≠ finitePlane11DoubleGapColouring v` is false"* — `(0,0) ~ (0,1)` becomes monochromatic. |
| C5 | `finitePlane11DoubleGapTable` entry `(0, 0)`: `0 → 4` | properness stays **green** (the gap colour was absent from `N(0,0)`, so the corrupted table is still proper — the advisor checked all 726 edges), the `#guard` fires, and **both** `FanGap` `decide`s refuse: at `(0,0)` by `γ ≠ C v`, at `(1,0)` because `(0,0)` is its neighbour. |

**A correction to the file, made on the advisor's reading.** `finitePlane11_sharedGap_corrupt_refused` closes from
`FanGap`'s first conjunct alone (`hSG.1.1 h00.symm`): it never runs a table `decide`, and the corrupted table is still
a proper colouring. Its docstring called it "the M04 corrupted-table control" and now calls it what it is — a red on
the **definition** — and points at C4/C5, which are the reds on the `decide`s.

**An instrument lesson from the advisor's own retraction, worth more than the correction.** The advisor's
independent check of the 19 colouring reported the same wrong vertex, and its properness control *could not*
catch it: `circ19D` is symmetric under negation, so the colouring built from `x + y` is ALSO proper on all
3,610 edges and has the SAME two gapped classes — only the vertex labels differ. **A control that passes for
both candidate readings discriminates neither** (G21's shape, on a control rather than on a search): the
properness check was pointed at a property both functionals share, and the discriminating question — which
functional does the *definition* compute — was never asked of the definition. Both readers had encoded the
docstring's summary instead of `projAlong`'s body. What caught it was `decide`, on a statement neither reader
doubted. G46's habit ("read the construction's own data layout, not the plan's vocabulary for it") applies to
a *docstring* exactly as it does to a plan.

### R1.4a The elaborated statements, printed rather than read off the source

*The read-aloud done by the machine: `#check` on the headline names, so a hidden hypothesis or an implicit
instance would show. Nothing is conditioned on colourability, on finiteness, or on a prime, where the claim
says it is not.*

```
@not_forces_of_fanGap : ∀ {V W} {G : SimpleGraph V} {P : SimpleGraph W} {k : ℕ} (f : G →g P)
  {C : P.Coloring (Fin k)} {u u' : V} {γ : Fin k}, FanGap C (f u) γ → u ≠ u' → ¬Forces G k u u'
@not_separated_of_sharedGap : ∀ {V W} {G : SimpleGraph V} {P : SimpleGraph W} {k : ℕ} (f : G →g P)
  {C : P.Coloring (Fin k)} {u u' : V} {γ : Fin k},
  SharedGap C (f u) (f u') γ → ¬G.Adj u u' → ¬Separated G k u u'
@Slack.forces_iff : ∀ {V} {G : SimpleGraph V} {k : ℕ}, Slack G k → ∀ {u u' : V}, Forces G k u u' ↔ u = u'
@PairwiseFusable.separated_iff_adj : ∀ {V} {G : SimpleGraph V} {k : ℕ},
  PairwiseFusable G k → ∀ {u u' : V}, Separated G k u u' ↔ G.Adj u u'
@forces_iff_of_hom_finitePlane11 : ∀ {V} {G : SimpleGraph V} (f : G →g finitePlane 11) {u u' : V},
  Forces G 5 u u' ↔ u = u'
@separated_iff_adj_of_hom_finitePlane11 : ∀ {V} {G : SimpleGraph V} (f : G →g finitePlane 11) {u u' : V},
  Separated G 5 u u' ↔ G.Adj u u'
@UDCert.forces_eq_11 : ∀ {n} (c : UDCert n), c.CoordsIn Q4.sevenFree → ∀ {u : ZMod 11}, u * ↑c.denom = 1 →
  c.Valid = true → ∀ {i j : Fin n}, Forces (edgeGraph n c.edges) 5 i j → i = j
@UDCert.separated_iff_adj_11 : ∀ {n} (c : UDCert n), c.CoordsIn Q4.sevenFree → ∀ {u : ZMod 11},
  u * ↑c.denom = 1 → c.Valid = true →
  ∀ {i j : Fin n}, Separated (edgeGraph n c.edges) 5 i j ↔ (edgeGraph n c.edges).Adj i j
@heule510_forces_iff : ∀ {i j : Fin 510}, Forces (edgeGraph 510 heule510.edges) 5 i j ↔ i = j
@heule510_separated_iff_adj : ∀ {i j : Fin 510},
  Separated (edgeGraph 510 heule510.edges) 5 i j ↔ (edgeGraph 510 heule510.edges).Adj i j
three_le_arityFloor_heule510 : 3 ≤ arityFloor (edgeGraph 510 heule510.edges) 5
finitePlane19_slack : Slack (finitePlane 19) 5
```

Two readings to make explicit from the print. **Heule-510's two `iff`s are UNCONDITIONAL** — no certificate
hypothesis survives in them, because `heule510Reduce11` already discharged M58's three at M60; so "the record's
5-chromatic witness in a 5-sealed field has no forced pair and no virtual non-edge at five colours" is now a
closed theorem about that graph, where the record had a measured null. And **`UDCert.forces_eq_11` quantifies
over ALL pairs `i j`** with no condition on their distance, where M60's law had to know the residue of the
squared distance — which is what makes the pair `(0, 475)`, invisible to M60, fall out here.

### R1.5 The gate, with every count that moved

| gate | reading |
|---|---|
| `./scripts/build.sh` | **OK — 170 of 170 batches**, 6 modules rebuilt, 3m36s. The only warnings are the `declaration uses 'sorry'` lines of `TwoAdicTower.lean` (24), `Instances/TwoAdicFour.lean` (3) and `Instances/TwoAdicFive.lean` (10) — phase K3's, untouched here. |
| `grep -n sorry` on the three modules | **zero**, all three. |
| `./scripts/axioms.sh` | **OK — 914 clean, 10 axiom-free, 5 declared purchases**, the same five native purchases as before (all M03's Moser-spindle certificate routes), "purchase ledgers agree", and *no record appeared, disappeared or changed its axioms* other than the 68 FS-38 records added to the audit. Every one of the 68 is `[propext, Classical.choice, Quot.sound]` except `unitQuadrance_exists_hom_to_base`, which is `[propext, Quot.sound]`. **Count moved 846 → 914** because the audit now names FS-38's surface; the digest prints `RECORDED COUNT IS STALE — update CLAUDE.md § Trust ledger: 846 clean → 914`, which is phase C's edit, deliberately not made here. |
| `./scripts/vacuity.sh` | **FAIL, and not on anything in this phase.** `declarations 6261 → 6405`, `refutations-skipped 242 → 262`, `sites 220 → 259`, `witnessed 12 → 14`, `generic 203 → 238`, `unknown 2 → 4`, `vacuous=0 stale=0 declared=3`. The two new UNKNOWNs are **`twoAdicFive_forces_delta` and `twoAdicFive_forces_of_ker`** — phase K3's `sorry` leaves in `Instances/TwoAdicFive.lean`, a file created by the skeleton commits and never edited here, so the gate **would read red at `31702dc`** — an inference, not a measurement: both sites are unchanged since `02d1fef` and the verdict there is a function of that file alone, but nobody ran `vacuity.sh` at the tip (§S10 reports the build only), and this phase did not spend a build to measure it. A reader auditing *when* the gate went red will find no run before this one. Their inhabitant is a 4-colouring of `twoAdicPlane 5`, which is K3's to ship; adding them to `scripts/vacuity-baseline.txt` would be K3's judgement to record and is deliberately NOT made here. **Every site this phase introduced is green:** two WITNESSED (`finitePlane11DoubleGapColoring` by `finitePlane11_colorable_five`, `finitePlane19QuotColoring` by itself) and 35 GENERIC (the parametric colouring binders of `FanGap.lean` and the hom wrappers — the caller's obligation). The three refutation controls are counted in `refutations-skipped`, by design. |
| `./scripts/vacuity.sh --self-test` | **OK — every one of the seven planted controls fired, and the two silent ones stayed silent**, including the load-bearing `UNKNOWN planted_unknown_prop`. |
| `lake lint` | **OK — "Linting passed for Proofs."**, exit 0, run under the same `systemd-run` memory cap. |

### R1.7 What this phase did not do

Phase K3 (`TwoAdicTower.lean`, `Instances/TwoAdicFour.lean`, `Instances/TwoAdicFive.lean` — 37 `sorry` leaves) and
phase T (`tools/fs38_tower.py` and the `data/fs38/` records) are other agents'; nothing here touches them, and the
`doublegap-p11-k5.json` record that produced `finitePlane11DoubleGapTable` is still to be committed by phase T — the
table in the module is untrusted data whose only check is the two `decide`s, which is the arrangement §S6 asked for.
The field-level sentence of D0.5 stays a hand step (row 57). `CLAUDE.md`, `plans/FRONTIER-STUBS.md`,
`CLOSED-QUESTIONS.md` and `BIBLIOGRAPHY.md` are phase C's, unedited here — including the two stale counts this phase
moved (the axiom ledger's 846 → 914 and the gate's declaration/site counts above), which phase C must carry over
rather than read as a failure.

### R1.6 Decisions implementation forced, and one it did not

| # | decision | alternative weighed | why | confidence |
|---|---|---|---|---|
| 1 | The gap witness at 19 is `(0, 4)`, not the skeleton's `(4, 0)` | leave the statement and report it unprovable | the skeleton's statement is **false**, not hard: `(4, 0)`'s closed neighbourhood carries all five colours. `(0, 4)` is the same class the docstring's reading intended, so the theorem's content is unchanged and `finitePlane19_slack` is untouched | high — `decide` settles both directions, and the nineteen-class enumeration says exactly two classes are gapped |
| 2 | `SharedGap` gets **no** `Decidable` instance; `finitePlane11_sharedGap` is `⟨by decide +kernel, by decide +kernel⟩` | mint `instance : Decidable (SharedGap …)` so one `decide` reads the whole conjunction | an instance is a permanent utterance into every future search (DEBRUIJN `global_speech_acts`) and one table does not need it; two `decide`s through `FanGap`'s own instance cost 22 lookups and read the same | high — if a later prime wants `decide` on `SharedGap` directly, the instance is two lines then |
| 3 | The three negative controls are **library theorems** that refute the weakened statements, not scratch files that watch a proof break | keep them in `build/fs38-k/controls/` and cite them from the commit message | a gitignored file is not a record (row 65's lesson, verbatim), and a refutation is stronger evidence than an elaboration failure: it says the hypothesis is *needed*, not merely *used*. The cost is three declarations and `refutations-skipped +3` | high |
| 4 | `scripts/vacuity-baseline.txt` is **not** edited, so the vacuity gate stays red on K3's two sites | add the two K3 sites to the baseline and report the gate green | the baseline is the ledger of unresolved emptiness, and it "only ever SHRINKS"; a site whose inhabitant is another phase's deliverable is that phase's entry to make. Reporting a red I did not cause is honest; silencing it is the failure mode this project's gates exist to prevent | high |
| 5 | Not taken: no statement in `FanGap.lean` was restated, strengthened or weakened | §M3's shapes were already the strongest the proofs support | the obligation pass had priced every leaf; the only shape changes are seventeen `:= by sorry` bodies becoming `:=` terms. The one point that could have been weakened — dropping `P.Colorable k` — was already settled by §M3's move from `DoubleSlack` to `Fusable`, which makes the premise implied rather than assumed | high |


---

## §R2. The 2-adic kernel, read aloud against the claims (phase K3, 2026-09-13)

*Written by the implementing engineer, in §R1's shape. The tools-side measurements this phase consumed are phase T's
(`plans/FS38-tower-records.md`); nothing here edits them. Every statement below is `sorry`-free.*

### R2.1 The tower's structure, read aloud (`Proofs/HadwigerNelson/TwoAdicTower.lean`, 0 `sorry`)

**§S3, the object.** *Claimed:* "`P_m = Cay(O/𝔓^m, S_m)` in the ring-free representation: the additive group
`(ℤ/2^⌈m/2⌉)[ω] ⊕ π·(ℤ/2^⌊m/2⌋)[ω]`, the circle the fibre of an explicit pair of Eisenstein forms over `(1, 0)`,
uniform in the level." *The statements say:* `TwoAdicLevel m` is a product of four `ZMod`s (an `abbrev`, so the
`AddCommGroup`, the `Fintype` and the `DecidableEq` are Mathlib's and nothing is built); `normForm m` is the pair
`(N(A) + 2N(B), Tr(A, B) + 2N(B))` with the doubling `dbl` and the reduction `castDown` spelled out;
`twoAdicCircle m` is its fibre over `(1, 0)` with a `DecidablePred` instance; `twoAdicPlane m := addCayley
(twoAdicCircle m)` with a `DecidableRel`. **Kernel-checked spec facts:** `|S_1| = 3`, `|S_2| = 6`, `|S_3| = 12`
(examples), `twoAdicCircle_four_card = 24` and `twoAdicCircle_five_card = 48` — the `3·2^{m−1}` law at the two levels
the instances use. *NOT claimed, and this is the phase's load-bearing limit:* **that this graph is `Cay(O/𝔓^m, S_m)`
is [hand 1] and is not in the kernel.** The kernel knows a Cayley graph on a product of `ZMod`s under an explicit
quadratic form; that the form is the norm of `ℤ₂[ω][π]/𝔓^m` is the plan's hand derivation, and every sentence below
that mentions `O`, `𝔓` or a *depth* inherits it. **[hand 2]** — that a `K`-certificate translated to the origin draws
into `P_m` — is likewise absent; nothing in these three modules draws a certificate, so **no statement here is about
the plane, about `K`, or about any unit-distance graph.**

**The forms' symmetries.** `EisMod.norm_omegaMul`, `norm_conj`, `trace_omegaMul_omegaMul`, `trace_conj_conj` (both
forms are invariant under multiplication by `ω` and under conjugation), `norm_map`, `trace_map`, `omegaMul_map` (both
forms commute with a ring homomorphism applied componentwise). These are §M3's `simp` set, oriented to strip one
constructor from a form's argument, and they are what makes the level-map and automorphism proofs two lines each.

**The one arithmetic stone.** `two_pow_succ_eq_zero (m) : (2 : ZMod (2 ^ ⌈m/2⌉)) ^ (⌊m/2⌋ + 1) = 0` and
`two_mul_natCast_mod (m a) : 2 * ↑(a % 2^⌊m/2⌋) = 2 * ↑a` in the `A`-ring. *Read aloud:* doubling cannot see the
ambiguity in a `B`-ring representative, because `⌈m/2⌉ ≤ ⌊m/2⌋ + 1`. Both of `dbl`'s obligations — that it is
additive at all, and that it commutes with reduction (`castDown_dbl`) — are corollaries, which is why `ZMod.val` is
read in exactly one place in the module.

**The symmetries as graph maps.** `twoAdicOmegaHom m : P_m →g P_m` (multiplication by `ω`; injective because
`ω³ = id`, and the circle is preserved because the forms are), and `twoAdicLevelHom m : P_{m+2} →g P_{m+1}`.
*Claimed (§M2's false leaf):* "the level hom cannot start at `m = 0`." *The statement says* it starts at `m + 2 →
m + 1`, and the reason is now itself a theorem: `no_hom_twoAdicPlane_one_to_zero` — level `0` is one point with no
edge, level `1` is `K₄`, so **no** map from level 1 to level 0 respects adjacency. The local obligation that carries
`map_rel'` is `twoAdicLevelMap_ne_zero_of_mem_circle`: a circle point two levels up reduces to a *nonzero* point,
i.e. no fibre carries an edge. The additive map `twoAdicLevelMap m` and `twoAdicLevelMap_mem_circle` are stated at
every `m`, including `0`, where they are true and harmless.

**Level one has no gap.** *Claimed (§R1.2 (iv), left there as "[hand until K3]"):* "the 2-adic side of the dichotomy
at level one: `P₁` is `K₄`, every closed neighbourhood is the whole graph, so no colour is free." *The statement
says:* `twoAdicPlane_one_no_fanGap` — for every one of the 256 functions `TwoAdicLevel 1 → Fin 4` that is proper, and
every colour `γ`, `γ` is not absent from `N[0]`. `decide +kernel`, and it needs `synthInstance.maxSize 1000` (the
default 128 cannot assemble the instance for a `∀` over a function type at this nesting — the option is set at the
declaration, which is where its necessity is visible). *Not claimed:* nothing about levels 2–4 directly; their
gaplessness comes from level five, below.

### R2.2 Level four is pairwise free (`Instances/TwoAdicFour.lean`, 0 `sorry`)

*Claimed:* "`Forces (twoAdicPlane 4) 4 x y ↔ x = y`, from a list of tables through
`Forces.eq_of_forall_exists_not_periodic`." *The statement says* exactly that (`twoAdicFour_forces_iff`), resting on
two `decide`s: every one of the five tables is proper, and every one of the 255 nonzero differences is a non-period of
one of them (`twoAdicFourTables_cover`). *Not claimed:* **no table here is aperiodic** — that is the reason it is a
list, the fact is phase T's measurement, and the kernel statement needs only the cover. *Not claimed:* minimality —
the record's two-table cover is an upper bound found by search, and the five kept here are not claimed to be fewest.

**Where the cost went, and the restatement §M2 held in reserve.** Properness stated over `Adj` is 65,536 pairs each
evaluating `normForm` twice: **measured at 2 min 08 s for one table** in the kernel, so ~11 minutes for five. Taken
through the connection set — `twoAdicCircleFour`, the 24 points of `S₄` as a **literal** — it is 256 shifts × 24
points per table with no form evaluation: 71 s for the whole module, and **38 s at a 6.8 GB peak** once R2.4a's
`List.all` restatement replaced the `∀ s ∈ list` form. That
is M04's rule ("emit big tables as literals; never let the kernel build one") applied to the connection set, and
§M2 had priced it before implementation. The literal is untrusted; `mem_twoAdicCircleFour_iff` re-derives membership
from `normForm` at all 256 points in **both** directions, so a missing point and an invented point both fail.
`proper_of_shift_ne` is the bridge, and it is `addCayley_adj` in both directions of the connection set's disjunction.

### R2.3 Level five forces exactly the kernel of the level map (`Instances/TwoAdicFive.lean`, 0 `sorry`)

*Claimed:* "`Forces (twoAdicPlane 5) 4 0 d ↔ twoAdicLevelMap 4 d = 0` — the forward direction by pullback from level
four, the backward direction by ONE LRAT-checked refusal transported to the other two depth-4 differences by the
`ω`-automorphism." *The statements say:*

* `twoAdicFive_not_colorable_with_edge : ¬ (twoAdicPlane 5 ⊔ fromEdgeSet {s(0, δ)}).Colorable 4`, `δ = ((4,0),(0,0))`.
  **This is the only solver-dependent declaration in the phase**, and what it rests on is not CaDiCaL's word: the
  kernel replays the certificate.
* `twoAdicFive_forces_delta : Forces (twoAdicPlane 5) 4 0 δ` — one step from it (a colouring with `C 0 ≠ C δ` *is* a
  colouring of the graph with the edge).
* `twoAdicFive_forces_of_ker` — the whole kernel `{0, δ, ωδ, ω²δ}` (`twoAdicFive_ker_eq`, `decide +kernel` over all
  1,024 elements), by `Forces.map` along `twoAdicOmegaHom 5`, which fixes `0`.
* `twoAdicFive_not_forces_of_ne` — outside the kernel, `Forces.image` along `twoAdicLevelHom 3 : P₅ →g P₄` lands in
  level four, which is pairwise free.
* `twoAdicFive_forces_iff` and `twoAdicFive_forces_iff'` (every pair, by the Cayley reduction
  `forces_iff_forces_zero_sub`).
* `twoAdicFive_not_slack` and `twoAdicFour_not_slack` — one line each; slackness pulls **up** along the level hom, so
  a gap at level four would make level five slack, contradicting the forced pair. **Every level `≤ 5` is gapless**,
  and at level one that is also proved directly (R2.1), so the two routes agree where they overlap.

**What is NOT claimed.** (i) Nothing above level five: the records' forced sets at levels 6–8 are phase T's, on two
solver engines, and no statement here reaches them. (ii) **Nothing about depth.** The kernel statement is about the
*kernel of the level map*, and that set is itself **decided**, as four explicit tuples (`twoAdicFive_ker_eq`). So
[hand 1] supplies only the **name** `𝔓⁴/𝔓⁵` for a set the kernel already knows, and the sentence "a difference of
𝔓-depth ≥ 4 is forced" is that name plus the level-`m`/depth dictionary of §S1 — worth separating, because "the
kernel of the level map is `𝔓⁴/𝔓⁵`" otherwise reads as one hand step when it is a decided fact wearing a
hand-supplied name (Poros, 2026-09-13).
(iii) **Nothing about any unit-distance graph, any field, or the plane** — that transfer is [hand 2] (row 57's gap),
and §S4's one-way reading of it is unchanged by this phase. (iv) Nothing about *five* colours: the tower at 2 is a
four-colour object, and G48's mechanism asks about five. (v) `twoAdicFive_not_forces_of_ne` refutes forcing at the
origin only through the level map — it does not say `P₅` has an aperiodic colouring (it has none, by the same
argument as level four).

### R2.4 The certificate: what is committed, what the kernel re-derives, and the one bookkeeping gap

**The artifact, and what of it is in the repository.** Committed under `data/fs38/lrat/`: the 24,577-pair edge list
(`P₅`'s 24,576 edges and the added pair `(0, δ)` last) and `manifest.json` — SHA-256s, CaDiCaL's exact flags and
seed, the pins, and the negative control at exit 10 *without* the edge. **Not** committed: the proof bytes, since
`*.lrat` is ignored repository-wide and phase T's standing decision (commit `a72edc5`) is that the regeneration is
byte-identical from the committed inputs.

**So this phase puts the proof's content into the repository for the first time, in a form that needs neither the
`.lrat` nor CaDiCaL**: the emitted `Cnf/` modules carry the clauses the proof uses and the propagation hints that
justify them, and the kernel replays every step. **The record said "generated, not checked"; after K3 it is
checked** — by the Lean kernel through M05's verified checker, not by an external LRAT checker, of which there is
still none on this machine.

**What the kernel is shown is the refutation's own core, and that is the phase's largest engineering decision.**
The committed proof reaches **861 of the formula's 99,335 clauses — 125 vertices and 778 edges** (backward
reachability from the empty clause). A subgraph that refuses refutes every graph it maps into, so the core proves the
*identical* Lean statement. The full instance was built first, and the measurement is the argument:

| | full instance | the core |
|---|---|---|
| vertices / edges | 1,024 / 24,577 | **125 / 778** |
| formula clauses | 99,335 | **3,240** |
| `twoAdicFive_agrees` (the trust boundary) | **853 s, 33.2 GB peak** | **5.9 s** |
| the certificate segment (the proof replay) | 4.8 s | **2.2 s** |
| emitted source | 940 KB | **100 KB** |

The proof replay was never the cost: the 1,339 LRAT lines trim to 182 derived clauses at the full instance and 116 at
the core, one segment either way. The cost was `agreesWithCNF` over a **formula** ten times Heule-510's, for a
refutation that needs a thirtieth of it — and it twice took this machine to the edge of its memory, which is what
settled the decision. A reviewer now re-checks a 31× smaller artifact.

**The bookkeeping gap, named rather than smoothed.** `data/fs38/lrat/manifest.json` describes the **full** instance,
and the kernel consumes a core **derived from it** by a scratch script (`build/fs38-k3/core_resolve.py`, gitignored,
touching neither `tools/` nor `data/`). This phase cannot close that: `data/` is another agent's file. What makes it
a gap rather than a hole is that the Lean modules are self-contained — `twoAdicFiveCoreIdx` records which vertex of
the full level each core index is, and the kernel checks every listed pair against `P₅` itself — so nothing a
reviewer needs is missing. **What is owed is one row in the record saying the kernel consumes a core**, and the
regeneration recipe is in `Instances/TwoAdicFive/Edges.lean`'s module docstring.

**The provenance chain to the committed data is closed, and checked rather than asserted.** Rebuilding the DIMACS
from the *committed* edge list and the *committed* pins reproduces the manifest's `p5-plus-edge.cnf` SHA-256 exactly
(`ed119bd5…ba58744e`), and the `.lrat` this phase read matches the manifest's hash for it. Every core edge was
checked to be a member of the committed edge list before anything was emitted. **And the two implementations of the
formula were compared directly**, before the kernel was asked to: `#eval` of `coloringCNF 4 1024 twoAdicFiveEdges`
against `tools/coloring.py`'s `base_clauses` — 99,332 clauses both sides, the same first clause, the same clause at
index 1,024, and the same last four (the added pair, as variables `0` and `2048`). That is the check a reviewer would
ask for first and the one `agreesWithCNF` cannot do cheaply: it says the Lean formula and the DIMACS CaDiCaL read are
the same object, leaving the kernel the *packing* and the *proof*.

Four independent checks then stand between the generator and the theorem, and each fails loudly rather than lying:

1. **`twoAdicFive_agrees`** — the clause table holds the formula `coloringCNF 4 125 twoAdicFiveEdges ++ cubeCNF 4 125
   twoAdicFiveCube`, decided slot by slot against clauses Lean computes from its own definitions.
2. **`twoAdicFive_unsat`** — every derivation step propagates, replayed by the kernel from the base watermark; the
   watermarks are checked by the elaborator, so a miscount is a type error naming the two segments that disagree.
3. **`twoAdicFiveEdges_all_ok`** — every one of the 778 listed pairs really is an edge of `P₅` under the generator's
   indexing `i ↦ ((i/128, (i/16) % 8), ((i/4) % 4, i % 4))` composed with `twoAdicFiveCoreIdx`, or else is exactly the
   added pair `(0, δ)`. This is the check that the certificate is about the object named: a disagreement about the
   indexing would leave nearly every listed pair a non-edge (control C5).
4. **The pins are a clique, in the kernel.** The formula pins three vertices to three colours, which is sound only by
   palette symmetry, which needs them pairwise adjacent. `twoAdicFiveTriangle` proves that adjacency **from the edge
   list**, not from the manifest's `pins_are_a_clique`, and `Gadget.ofUnsat` + `not_colorable_of_gadget` compose the
   refutation with it. Without it the refusal could be a statement about the pins instead of about the graph.

**Soundness direction, stated once.** Only "a colouring yields a satisfying assignment" is ever used, so an edge list
that is *too small*, a table that is wrong, or a certificate that is wrong each makes a check fail; none can produce
a false theorem (`Sat/Encoding.lean`). **Completeness of the edge list is therefore neither claimed nor needed** —
which is exactly why shipping the core costs nothing in rigour.

**Three generated docstrings were corrected by hand.** `tools/emit_mask.py` hardcodes Heule-510's prose, so the
emitted modules called this object "de Grey's half graph" and described the cube as "the joining edge's endpoint".
A docstring is environment data, not a comment, so left alone they would have been a false statement about the object
in the environment. They now name the level-five plane, the added pair and the triangle; a regeneration overwrites
them, and the modules say so.

### R2.4a Two cost traps, measured — and neither is about this object

*Both were found by bisection after the level-five module was killed at a memory cap, and both are general facts about
`decide` in this toolchain rather than facts about the 2-adic tower. They are recorded here because each is invisible
in the source and each is worth an order of magnitude.*

**Trap 1 — `∀ x ∈ l, P x` is catastrophic where `l.all f = true` is free.** The claim "every listed pair is an edge"
was first stated as `∀ e ∈ twoAdicFiveEdges, …` and discharged by `decide +kernel`. Measured under a hard cgroup cap,
sampling RSS every second:

| form | peak | time |
|---|---|---|
| `∀ e ∈ (778 pairs), (twoAdicPlane 5).Adj … ∨ …` | 20.8 GB | killed at 61 s |
| `∀ e ∈ (778 pairs), normForm … = (1,0) ∨ …` | 32.8 GB | heartbeat timeout at 137 s |
| **`∀ e ∈ (778 pairs), e.1 ≠ e.2`** — on a **bare** import, no `ZMod`, no graph | **31.9 GB** | **timeout at 136 s** |
| `twoAdicFiveEdges.all twoAdicFiveEdgeOk = true` | **3.5 GB** | **5 s** |

The third row is the one that settles it: the trivial predicate on a bare import costs the same as the real one, so
the blowup is in the **`∀ x ∈ l` decision procedure**, not in the arithmetic, not in the graph, and not in the list's
provenance (a flat literal and a `List.flatten` of chunks cost the same). The repair is to state the check as a
`Bool` and discharge it through `List.all`, recovering the per-element statement with `List.all_eq_true`. Applied to
both instance modules: **`Instances/TwoAdicFive.lean` 3.57 GB / 6 s** (from over 22.9 GB and killed);
`Instances/TwoAdicFour.lean` 6.76 GB / 38 s (from 6.8 GB / 70 s — the same repair, half the time).

**Trap 2 — a numeral literal at an unreduced type index.** `TwoAdicLevel 5` unfolds to
`EisMod (2 ^ ((5 + 1) / 2)) × EisMod (2 ^ (5 / 2))`, and a 48-point circle literal written directly at that type makes
the elaborator resolve every one of its 192 numerals against `ZMod (2 ^ ((5 + 1) / 2))`: **32.9 GB and a heartbeat
timeout, for a definition with no proof in it at all.** The identical 48 points written at
`List ((ZMod 8 × ZMod 8) × (ZMod 4 × ZMod 4))` and ascribed cost **2.5 GB / 2 s** — but the ascription then puts the
data behind a defeq wall that the kernel pays on every access, so the shipped answer is to carry **no literal at
all** and evaluate `normForm` per edge instead. **Level four's 24-point literal is the same shape and is why that
module still costs 6.8 GB**; it is left as it stands because it is inside budget and already committed, and the
cheaper shape is recorded here rather than applied at the end of a phase.

**What this says about the earlier 33 GB.** The full-instance clause table's 853 s / 33.2 GB was a *third*,
unrelated cost — `agreesWithCNF` over 99,335 formula clauses — and it is the one the unsat core removed. Three
independent order-of-magnitude costs, none of them the SAT proof, which replays in **2.2 s**.

### R2.5 The negative controls, with what each red says

*Every check that decides something here was broken on purpose and watched to fail; C2 and C3 were **re-run against
the current shape** after R2.4a's restatement changed it, because a control that passed against earlier code has not
been run against this code. Each was restored, the restore verified byte-identical, and the file re-checked green
(CLAUDE.md's mutation-harness rule: the restore is checked, not assumed).*

| # | what was broken | what went red, and why that is the named reason |
|---|---|---|
| C1 | `twoAdicCircle 4`'s cardinality claimed as 23 instead of 24 | `decide` refuses `twoAdicCircle_four_card` — the count is decided from `normForm`, not asserted |
| C2 | one entry of the 24-point circle literal moved off the circle | **both** `mem_twoAdicCircleFour_iff` (the literal is not the circle) and table 1's shift fact go red — the literal is checked in both directions, so an invented point fails as loudly as a missing one |
| C3 | one entry of level-4 table 1 changed | table 1's shift fact refuses: the table is no longer proper across a circle shift |
| C4 | the level hom re-indexed to `m + 1 → m` (the false leaf §M2 found) | elaboration fails — but as a `whnf` timeout, **a red for an unnamed reason**, which is why `no_hom_twoAdicPlane_one_to_zero` was minted: it says the *statement* at `m = 0` is refutable, not merely unprovable |
| C5 | the certificate's vertex decode perturbed (`/16` → `/8`) | `twoAdicFiveEdges_all_ok` refuses — the check tying the generator's index order to this file's arithmetic is load-bearing, not decorative |
| C6 | one port moved off the triangle (`17` → `18`) | `twoAdicFiveTriangle`'s membership refuses — the pins' soundness is not taken from the manifest |
| C7 | one digit of the packed certificate altered | the segment's `Justified` step refuses — the kernel replays propagation and does not take CaDiCaL's word. **Its first attempt did not plant** (my pattern missed the literal), and a control that did not fire is not a control that passed, so it was re-planted and re-run |
| C8 | two clause-table chunks swapped in the table's spine | `twoAdicFive_agrees` refuses — the trust boundary between the emitted table and the formula Lean computes from its own definitions |


### R2.6 The gate, with every count that moved

* **`./scripts/build.sh`: OK** — 420 of 420 batches, 3 modules rebuilt, **0 warnings, 8m52s**, run at `BATCH=4` with
  a guard that would have killed it at 60 GB. **Peak total `lean` RSS across the whole run: 6 GB.** For contrast, the
  same library with the full instance and the `∀ x ∈ l` forms went **over the 100 GB cap and was stopped twice**;
  both figures are in R2.4 and R2.4a, and the second is why the shapes changed.
* **Per-module peaks, measured under a hard cgroup cap with RSS sampled every second**:
  `Instances/TwoAdicFive.lean` **3.57 GB / 6 s**; `Instances/TwoAdicFour.lean` **6.76 GB / 38 s**; one generated
  clause-table module **815 MB / 0.4 s**; `Cnf/Table` **5.9 s**; `Cnf/Seg000` **2.2 s**; `Cnf/Cert` **0.83 s**.
* **Zero `sorry`** in all six modules (the single repository-wide `grep` hit is the word inside `Packed.lean`'s
  docstring, which predates this phase).
* **`./scripts/axioms.sh`: OK — 947 clean, 10 axiom-free, 5 declared purchases**, the *same* five as before: no
  native evaluation was bought. Every K3 declaration is `[propext, Classical.choice, Quot.sound]`; `twoAdicFive_agrees`
  needs only `[propext]` and `twoAdicFiveDelta_mem_ker` only `[propext, Quot.sound]`. The clean count moves
  **914 → 947** with this phase's block in `scripts/Axioms.lean`.
* **`./scripts/vacuity.sh`: OK**, and the two sites §R1.5 left red are now green: `declarations 6405 → 6484`,
  `refutations-skipped 262 → 265`, `sites 259 → 260`, `witnessed 14 → 17`, **`unknown 4 → 2`**.
  `twoAdicFive_forces_delta` and `twoAdicFive_forces_of_ker` read **WITNESSED by `twoAdicFiveColouring`** — level
  four's first table pulled back along `twoAdicLevelHom 3` — so the baseline again holds only the two sites whose
  inhabitant *is* Hadwiger–Nelson. **`--self-test`: OK**, all seven planted defects fired, including the load-bearing
  one that must read `UNKNOWN` rather than `VACUOUS`.
* **The headline statements, printed rather than read off the source** (`#check`, elaborated):
  ```
  twoAdicFour_forces_iff : ∀ {x y : TwoAdicLevel 4}, Forces (twoAdicPlane 4) 4 x y ↔ x = y
  twoAdicFive_forces_iff : ∀ {d : TwoAdicLevel 5},
      Forces (twoAdicPlane 5) 4 0 d ↔ (twoAdicLevelMap 4) d = 0
  twoAdicFive_forces_iff' : ∀ {x y : TwoAdicLevel 5},
      Forces (twoAdicPlane 5) 4 x y ↔ (twoAdicLevelMap 4) (y - x) = 0
  twoAdicFive_not_colorable_with_edge : ¬(twoAdicPlane 5 ⊔ fromEdgeSet {s(0, twoAdicFiveDelta)}).Colorable 4
  twoAdicLevelHom : (m : ℕ) → twoAdicPlane (m + 2) →g twoAdicPlane (m + 1)
  no_hom_twoAdicPlane_one_to_zero : ∀ (f : TwoAdicLevel 1 → TwoAdicLevel 0),
      ¬∀ (u v : TwoAdicLevel 1), (twoAdicPlane 1).Adj u v → (twoAdicPlane 0).Adj (f u) (f v)
  ```
  Read aloud against the claims: the level-four statement quantifies over *every* pair with no side condition; the
  level-five one is an `iff` about the **kernel of the level map**, not about depth; the refusal is about
  `twoAdicPlane 5` with **one** extra pair; the level hom starts at `m + 2 → m + 1` and the theorem beneath it says
  why. **`R1.2 (iv)`'s "[hand until K3]" marker can now be struck** — `twoAdicPlane_one_no_fanGap` closes by
  `decide +kernel` over all 256 functions — but that edit is in implementer K's subsection and is left to the
  product owner rather than rewritten here.

### R2.7 Decisions implementation forced

| # | decision | alternative weighed | why | confidence |
|---|---|---|---|---|
| 1 | Level-4 properness is taken **through the connection set** (`twoAdicCircleFour` as a literal), not over `Adj` | state it over `Adj` as the skeleton did and pay the kernel | measured, not guessed: 2 min 08 s for **one** table over `Adj` against ~11 s through the circle, and the module drops from ~11 min to 71 s. §M2 had priced this restatement in reserve and set the trigger at one minute | high — the literal is checked both ways at all 256 points, so the cheaper route is not a weaker one |
| 2 | The five committed tables are kept; the record's two-table cover is not imported | swap in `minimum_cover_found.tables` from `data/fs38/p4-tables.json` | after decision 1 the count costs ~11 s each, so the 2-cover buys ~33 s and costs one more untrusted literal; and no pair of the five committed tables covers, so it is a genuinely new table, not a subset | high |
| 3 | The pins' clique property is proved **in the kernel from the edge list** (`twoAdicFiveTriangle`), and the refutation is composed with it through `Gadget` | take `pins_are_a_clique: true` from the manifest, as the tools-side check already verified it | a pinned formula's refusal is a statement about the graph only if the pins are a clique; taking that from the generator would put the one step that makes the refutation *mean* something outside the kernel. It costs three list-membership `decide`s | high — this is Heule-510's `Bound.lean` shape, reused rather than invented |
| 4 | `twoAdicFiveEdges_adj` is stated as "an edge of `P₅`, **or else** the added pair", avoiding `Sym2`/`Set` membership inside a `decide` | decide adjacency in the sup graph directly | the sup's second summand is a singleton `Set (Sym2 _)`, whose decidability instance is a fight with no mathematical content; the disjunction is decidable as it stands and the hom does the case split once | high |
| 5 | **The kernel consumes the unsat CORE, not the full instance** — 125 vertices, 778 edges, 3,240 clauses | consume the committed 24,577-edge instance as the brief named it | measured, and the measurement is the argument: the full instance's clause table cost **853 s at a 33.2 GB peak** for a refutation that reaches 861 of its 99,335 clauses, and it twice took the machine to the edge of its memory. The core proves the **identical** Lean statement (a subgraph's refusal refutes the graph it maps into), builds in **5.9 s**, and shrinks the emitted source from 940 KB to 100 KB. A reviewer re-checks a 31× smaller artifact | high on the engineering; **medium on the bookkeeping** — `data/fs38/lrat/manifest.json` still describes the full instance, and only whoever owns `data/` can add the row that says the kernel consumes a core derived from it. Flagged, not silently left |
| 8 | Both "for every element of this list" checks are stated as a **`Bool`** and discharged through `List.all` | keep the `∀ x ∈ l, P x` form and raise the heartbeat limit | raising the limit does not fix it: `∀ e ∈ (778 pairs), e.1 ≠ e.2` costs **31.9 GB** and times out **on a bare import with no arithmetic in it**, while `l.all f = true` on the real predicate costs **3.5 GB and 5 s**. The `∀ x ∈ l` decision procedure is the cost, and `List.all_eq_true` recovers the per-element statement in one line | high — three independent bisection runs, and the control is the trivial predicate on a bare import |
| 6 | Three emitter-hardcoded docstrings corrected by hand in the generated modules | leave them, since `tools/` owns the template and a regeneration overwrites them | they called this object "de Grey's half graph". A docstring is environment data, and a false sentence about the object in the environment is exactly what this project's docstring rule exists to prevent. The modules now say that a regeneration overwrites them | high |
| 7 | `no_hom_twoAdicPlane_one_to_zero` minted as a theorem | keep the level-hom indexing as a remark with the by-hand re-indexing as its control | the by-hand control fires as a `whnf` timeout — a red for an unnamed reason, which this project does not count as evidence. The theorem says the `m = 0` statement is **refutable**, not merely unprovable | high |

**What the core route re-prices.** §S8 decision 7 declined a level-six LRAT on the size of `P₆`'s 196,608-edge
clause table. That estimate is about the **instance**; this phase's measurement is that the kernel only ever needs
the **core**, which here was 0.8% of the formula's clauses. A level-six attempt should extract the core before
emitting anything, and the recipe is now exercised end to end rather than argued for.

