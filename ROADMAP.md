# Roadmap: what is left to formalize

[`README.md`](README.md) lists this project's results with their status, and [`RESULTS.md`](RESULTS.md) every Lean theorem behind them, with its axioms. This page lists everything else this project holds: results proved
by hand, results computed outside the kernel, theorems the library assumes, and Lean work that is under way on branches. Every
item names the place where its full statement lives.

Items are ranked by their bearing on the open question, whether the plane needs six colours or seven. The page gives no time or
difficulty estimates.

## How to read this page

- **Grades** are those of `LEDGER.md`. **[kernel]** means checked by Lean's kernel in this library. **[hand]** is a proof written
  out by hand, by one or more independent minds (the row says how many). **[tools]** and **[measured]** are exact computations
  done outside the kernel, with controls. **[cert]** is a certificate accepted by a standalone checker, not by the kernel.
  **[derived]** means derived from results already held. **[reading]** is an interpretation, with the test that would kill it. A
  ledger row is kernel-checked unless it is marked otherwise.
- **The ledger's grades trail the library.** The Lean backlog (`plans/STUB-lean-backlog.md`) formalizes the hand results in
  waves. Its plan is that the ledger's rows are regraded to [kernel] when the backlog closes. Some rows marked [hand] are therefore
  already partly or wholly in the kernel. Row 131 is one: `Plane/Slack.lean` holds its equivalences, and the plane's case is
  `Outside.OAI158.seven_le_chromaticNumber_plane_iff`. Where the ledger and the kernel disagree, the kernel's print is the authority.
- **Nothing on this page is assumed by a theorem in the README's tables**, except the three outside theorems those tables name.

## 1. The plane: six against seven

The kernel holds `6 ≤ χ(ℝ²) ≤ 7` (given one outside theorem, item 2.3). It holds the reduction of "seven or six" to one statement
about measurable colourings (`Outside.OAI158.seven_le_chromaticNumber_plane_iff`, `Plane.seven_le_chromaticNumber_plane_iff_exists_ball`).
What is not yet in the kernel is most of this project's hand work on that statement:

1. **The Lean backlog's unlanded waves.** These are hand results about measurable six-colourings and their colour classes, planned
   as kernel modules. Their Lean work is unfinished and unmerged: it sits on branches of the project's private working
   repository, which this copy does not include, all last changed on 2026-10-06, and every one of those branches still has
   `sorry` in the modules it adds (counted outside comments and docstrings). The plan with every entry is
   `data/fs131/k1/dispositions.csv`, and its waves are described in `plans/FS131-kernel-plan.md` § 7.1.
   - **Wave 6, second half (23 entries):** saturated colourings, meaning colour classes carved by unit circles about their own
     points; their fragments and their ladders of unit parallels. Four branches add `Plane/Saturated/` modules (`Fragment`,
     `Accumulation`, `Centre`, `Owed`, `Parallel`, `CoverHull`, `CoverDiscs`, `ReduceI`), with 47 to 62 `sorry` each;
     `Fragment` alone has 19 on every one of them. No `Ladder` module exists yet.
   - **Wave 7 (20 entries):** points where four colours meet, called bowties and pinwheels, and a counting argument on the torus.
     One branch adds `Plane/FourColour/Basic`, `Bowtie` (15 `sorry`) and `Local` (9) and four `Plane/RouteT` modules, 25
     `sorry` in all; two more hold the `RouteT` modules alone, with one `sorry` (in `RouteT/Rainbow`). No `Pinwheel` module
     exists yet.
   - **Wave 9 (11 entries):** the reductions and the class statements. One branch adds six `Plane/Classes` and three
     `Plane/Reduction` modules, with 12 `sorry`; another adds five of them and `Reduction/Models`, with 2. Among the
     entries: seven colours are needed almost everywhere exactly when the uncovered density stays positive uniformly in the
     map's complexity.
   The planned modules of waves 1–5, 8 and 10, and of wave 6's first half, are on `main`: 151 of the 205 entries planned for
   formalization. That count is by module, not a check of each entry.
2. **Milestones derived by hand whose Lean phase is open** (`CLAUDE.md` § Paths forward):
   - **FS-132, six by the nerve** (rows 155–160): what a point with data on its unit circle is forced to carry, for every measurable
     colouring proper at almost every unit pair. Its first exclusion is in the kernel (`SixRing.no_outside_orbit`,
     `SixRing.not_ae_outside`). Its index lemmas and centres are skeletons on a branch.
   - **FS-124, the unit arc** (rows 161–164): fourteen of its thirty entries are kernel theorems. Of the other sixteen, five were
     handed to the kernel lane and have no plan yet: C124-ANTIPODE, C124-SECOND, C124-SIX, C124-HALF, and the second sentence of
     C124-FORCED (`plans/FS124-derivation.md`).
   - **FS-136, the point across** (rows 165–167): none of it is in the kernel. A planning job was launched on seven of its
     statements (`plans/FS136-derivation.md`; `CLAUDE.md` § Paths forward).
   - **FS-129, the cross-application audit** (rows 149–154): its 32 compositions are entries of the Lean backlog
     (`plans/FS129-derivation.md`).
3. **Theorems that take an open question as a hypothesis.** These are design targets, not results to formalize. They are the
   seven-target at six colours, `Plane.NoPar`, and valid six-coloured fragments on discs of every radius (rows 61, 145;
   `ARCHITECTURE.md` § 5, "Open questions and design targets").
4. **An outside theorem that a plane theorem takes as a hypothesis**: Voronov's Theorem 1.1 (`Plane.Voronov11`,
   `[Voronov2023]`), taken by `Plane.mu_lt_of_voronov11` (`ARCHITECTURE.md` § 5).
5. **Every row 128–167 not graded wholly [kernel]**: the appendix, group A.

## 2. The three outside theorems, and what landing each would mean

These are declared as axioms (`ARCHITECTURE.md` § 5; `CLAUDE.md` § Trust ledger). Each axiom's statement was read back against its
source, and each has a model of its hypotheses in its own file. "Landing" one means proving it in this library, so that every
record now resting on it rests on Lean's three standard axioms alone.

1. **O5, `Outside.OAI158.no_proper_five_coloring`**: no proper five-colouring of the plane (`[OAIMath2026]` family 158,
   `lean/OAI/Geometry/PlaneColoring/Five.lean` l. 124). Seven records rest on it, among them `6 ≤ χ(ℝ²) ≤ 7`, `6 ≤ χ_m⁰(ℝ²)` and `6 ≤ χ(ℚ(√635087)²) ≤ 7`. The
   release proves it in Lean at Lean and Mathlib `v4.34.1`, in 70 modules about 1,500 Mathlib commits away from this library's pin
   (`ARCHITECTURE.md` § 5). Landing it means porting that proof the way its transfer theorem was ported
   (`Outside/OAI158Basic` … `OAI158BorelTransfer`). Then `6 ≤ χ(ℝ²) ≤ 7` would hold on the standard three.
2. **EL, `Rigidity.positive_entropy_rigidity`**: Einsiedler and Lindenstrauss's rigidity theorem for `ℤ^d`-actions on solenoids
   (`[EinsiedlerLindenstrauss2022]` Theorem 1.3). It is read back clause by clause in `plans/FS131-KN7-chain-next.md` § 3.3. Twenty-seven records rest on it, among them the five-colour chain `min(L(F), 5) ≤ χ(F²)`, `χ(F²) = L(F)` whenever `L(F) ≤ 5`, `χ(ℚ(√47)²) = 5`, and the collapse `χ(F²) = χ(ℝ²)` at every uniformly thick real number field. Landing it would leave the
   chain resting on Weil's bound alone. Its formalization has been asked to be priced at some point, not yet
   (`data/fs131/REQUEST-2026-10-13.md`, W2).
3. **W, `StandingFive.kloosterman_bound`**: Weil's bound for Kloosterman sums (`[Weil1948]` p. 207). Fifty-eight records rest on it:
   the three-colour criterion, `χ(F²) = L(F)` at `L(F) ≤ 4`, and, with EL, the five-colour chain and the collapse at ℚ(√635087) and de Grey's field. Landing it as well as EL would put
   every number-field result in the README on the standard three.

Two pieces of `[OAIMath2026]` were assumed once and are no longer: the transfer `Outside.OAI158.proper_to_borel_weak` and the
rigidity step `Outside.OAI158.Spectral.residual_fourier`. Both are now theorems, their proofs ported. Before anything is published,
the cost of landing everything on the standard three axioms is to be measured (`CLAUDE.md` § The mission, Publication).

## 3. Planes over number fields

The kernel holds `χ(F²) ≤ L(F)` and `min(L(F), 5) ≤ χ(F²)` for every real number field, and their composition as one theorem:
`χ(F²) = L(F)` whenever `L(F) ≤ 5` (`Rigidity.chromaticNumber_planeOver_eq_localBound_of_le_five`), with its form that takes no hypothesis, `min(χ(F²), 5) = min(L(F), 5)` (`Rigidity.min_chromaticNumber_five_eq_min_localBound_five`). It holds Lemma C′ as typed (`Rigidity.unitRing_eq_stableIntegers`, row 100), its odd part at every real number field, and the components clause: the plane over every real number field has infinitely many components (`Rigidity.infinite_connectedComponent_planeOver`), through a stable prime at every real number field with no Chebotarev (`Rigidity.nonempty_stablePrime`, row 105); so `L(F) < ∞` everywhere (`Rigidity.localBound_lt_top`). It holds the values
through four colours and the five-colour values listed in the README. Left:

1. **Row 123's remainder** (the class, the family as the derivation computed it, CLS in full and ℚ(√23, ∛2) are kernel theorems since FS131-ICS1, `plans/KERNEL-HOLDS.md`): `L` at the class members that are a square neither modulo 11 nor modulo 19 — 167, 887, 1055, 1319, 1823, 2351, 2735, 2903 below 3000 — which needs a target the kernel does not hold (`Γ₃₁` first, undecided); and `χ(ℚ(√167)²) ≥ 5` by its second route (every stable place 4-thick).
3. **The parts of landed rows that stay outside the kernel.** In row 121: a finite triangle-free five-chromatic unit-distance
   graph over ℚ(√47), which exists by de Bruijn–Erdős but has not been exhibited, and the equivalence called "row 88 ⟺ T-B1" at
   ℚ(√59), ℚ(√83), ℚ(√131). In row 99: "no mixing", and `χ(ℚ(α, √7)²) = 4` with `α³ = α + 1`.
4. **Hand results taken as hypotheses** by the older conditional theorems: 21 entries, among them the chain's interface
   statements `SpectralChain.Interface.MR`, `PE2`, `EFPlus`, `RU`, `Count`. They are listed with their sources in `ARCHITECTURE.md`
   § 5, and every (hypothesis, theorem) pair is in `scripts/assumptions-ledger.txt`. The five-colour chain's headline takes none of
   them. The owner's instruction is that every hypothesis standing for a hand result of this project be discharged in the kernel
   (`data/fs131/REQUEST-2026-10-13.md`, W2). Some outside results are also taken this way: Herglotz–Bochner (`[Rudin1962]`),
   Markov–Kakutani (`[Kakutani1938]`), and Artin–Lang (`[Lang1953]`). Artin–Lang is the one hypothesis of the bridge
   `χ(ℝ²) = max_F χ(F²)` (row 107).
5. **The finite planes.** The local bound `L(F)` is a chromatic number of finite graphs, and several of those values are held
   outside the kernel. They come from exact certificates accepted by standalone checkers, and from computations with controls:
   five colours refused at 27 and at 23, six refused at 83, and the window for an exactly six-chromatic finite plane (rows 68–71).
   The open part is whether `L(F) = 6` is possible: it needs one of six finite targets, `Γ_q` at `q ∈ {23, 27, 31, 43, 47}` or
   `U₆₄`, to be six-chromatic, and none is decided (`CLAUDE.md` § Grokkings, the theory in one paragraph).
6. **Every row 52–127 not graded wholly [kernel]**: the appendix, group B.

## 4. Measurements around the early witnesses

Rows 12–51 come from the period when the project built and studied finite witnesses (rungs A and B). Their main objects are in the
kernel. What is marked [tools] or [hand] in them are statistics, searches and measurements around those objects. They do not bear
on the answer. Appendix, group C.

## 5. Before publication

1. **An independent kernel replay** with `lean4checker` (`scripts/lean4checker.sh`). It is the publication gate, not a milestone
   gate, and no replay covers the current tree (`ARCHITECTURE.md` § 5, Independent replay). It cannot re-check the three axioms.
2. **A statement-equivalence check** with `leanprover/comparator`: a small trusted file holding the challenge statements with
   `sorry`, checked against the whole library for statement equality, an axiom whitelist and a kernel replay (`CLAUDE.md` § The
   mission, Publication).
3. **The cost of landing everything on the standard three axioms**, measured first (item 2 above).

## Appendix: every ledger row not graded wholly [kernel]

Generated by `data/fs131/pr1/roadmap_appendix.py` from `data/fs131/pr1/nonkernel-rows.tsv`, which
`data/fs131/pr1/nonkernel_rows.py` builds from `LEDGER.md`. A row is listed when its text carries a grade other than [kernel], or a
phrase ("stays hand", "not in the kernel", "kernel pending", "no kernel job") that puts a part of it outside the kernel. "Part in the
kernel" says whether the row also carries a [kernel] grade. The heads are the ledger's own words: they use this project's working
vocabulary, which `BIBLIOGRAPHY.md` § E translates. The full statement, its grade and its sources are in the row. Of the ledger's
167 rows, 35 carry no mark outside the kernel and are not listed: rows 1–11, 14, 17, 18, 20, 22–25, 28, 33–36, 39, 55, 58, 60, 61,
66 and 103–107. (Row 107 is kernel-checked given one named hypothesis, Artin–Lang; see item 3.5.)

### A. The plane: six against seven (rows 128–167) — 40 rows

| row | grades outside the kernel | part in the kernel | the row's head, in the ledger's words |
|---|---|---|---|
| 128 | hand | no | The collapse: given MR, the plane's number is a field's. For every totally real number field `F` whose stable … |
| 129 | hand | yes | Row 123's five is a fractional bound rounded, and given MR the fractional local–global principle holds exactly … |
| 130 | hand, "stays [hand" | yes | The stationary number is a measurable one, and given MR so is Hadwiger–Nelson. With no MR: `χ_CP(ℝ²) = χ_m⁰(ℝ² …` |
| 131 | external, hand | no | The measurable question is a stability question. With no MR and no Voronov, for every `k`: `χ_m⁰(ℝ²) ≤ k` ⟺ `χ …` |
| 132 | hand | no | The regular half, verified and transferred almost everywhere. `[Voronov2023]` Thms 1.1–1.3 are proved by the p … |
| 133 | hand | no | Stability at six meets at one seam. R's reduction: given the quantified cone lemma, `χ_m⁰(ℝ²) ≥ 7` (row 131's … |
| 134 | hand | no | Under Condition 5 the regular half holds for curved maps: no locally finite map of the plane whose boundaries … |
| 135 | hand | no | With unit arcs, a six-map is governed by its four-colour vertices: in every locally finite map of the plane bo … |
| 136 | tools | no | Both printed six-coloured regions with unit arcs, rebuilt exactly, stop at one configuration — the pinned corn … |
| 137 | hand | no | With unit arcs, one local statement settles the six-map question: every locally finite map of the plane bounde … |
| 138 | hand | no | Where the count gives six room, the configurations die locally, and both printed positives are part of no six- … |
| 139 | hand | no | Stability at six: the doors are two routes, not halves, and each route's third statement is the answer restate … |
| 140 | hand | no | Route M's rungs: saturation pins interfaces between unit circles, maximal covers are free, and at five the map … |
| 141 | hand | no | The finiteness rung: a maximal class is as wild as its bands' zero sets, and in a fall colouring a pinch climb … |
| 142 | hand | no | The honest class's ladders end inward and never outward. In an honest saturated colouring with REG-J′, at ever … |
| 143 | hand | no | Honesty is free, and the map step's six-colour content is the top colour. Every a.e.-proper `k`-colouring beco … |
| 144 | hand | no | Symmetric and grid colourings are regular; what is open is aperiodic. No honest saturated REG-J′ colouring inv … |
| 145 | hand | no | The local exclusion decides both ways, and the unit circle about a four-colour vertex is a twisted circle colo … |
| 146 | hand | no | In saturated valid six-coloured fragments, the straight right-angled cross at a four-colour vertex whose ring … |
| 147 | hand | no | In non-Siamese simple valid six-coloured fragments, vertices of at least four colours propagate along the unit … |
| 148 | hand, "kernel pending" | no | In non-Siamese simple valid six-coloured fragments, a vertex of at least four colours whose unit circle carrie … |
| 149 | hand, "kernel pending" | no | In non-Siamese valid six-coloured fragments, simple or not, a vertex of at least four colours whose unit circl … |
| 150 | hand, "kernel pending" | no | The (Q)-ring case list, pruned: two change points 60° apart on a four-colour vertex's ring whose far germs lie … |
| 151 | hand, "kernel pending" | no | A slack residue target kills every linear identity on a colouring, at every number of colours: |
| 152 | hand, "kernel pending" | no | Falconer's fan, at every number of colours, and where a five-colour fan can live; route (b)'s literal reading … |
| 153 | hand, "kernel pending" | no | A local density lemma for fragments, and DISC-F from the local exclusion in the non-Siamese simple class: |
| 154 | hand, "kernel pending" | no | The map step at five, as an equivalence: |
| 155 | hand | yes | The (Q)-free exclusion with no map and no Siamese clause: for every measurable six-colouring proper at almost … |
| 156 | hand, "kernel pending" | no | Cyclic centres exist at every number of colours with no hypothesis; one carries the release's data wherever th … |
| 157 | hand, "kernel pending" | no | One witness blocks one side of a unit circle, with no properness; and two points less than 2 apart carrying wi … |
| 158 | hand, "kernel pending" | no | Three labels outside a triangle wind, and six is the one count at which they do; the forcing of a centre that … |
| 159 | hand, "kernel pending" | no | What a triangle point's ring is forced to do where it changes — the alternating ring excluded in step form, th … |
| 160 | cert, hand | no | In one finite family — a centre and its six ring points, each a *flower* of wedges — the three-label turning r … |
| 161 | hand | yes | The disc criterion, in measure — weak six-colourings of the open discs of every radius give `χ(ℝ²) ≤ 6` with n … |
| 162 | hand, tools | yes | What an open piece of one label forces one unit away, in every weak colouring — the one lemma; its form for on … |
| 163 | hand, tools | yes | What a close complementary pair forces at a common unit point, in measure — on pieces; with an arc where the m … |
| 164 | hand, "no kernel job" | no | The strip of FS-112 is closed at a point of its top edge against every weak six-colouring that keeps six named … |
| 165 | hand, "kernel pending", tools | no | The table at a point with pieced points on its unit circle, in every weak colouring that has the pieces; the c … |
| 166 | hand, "kernel pending" | no | The table run forward — a corner on which the pieces one unit away leave one label has that label; what a seed … |
| 167 | hand, "kernel pending", tools | no | The four held stops — each held six-coloured object stops at a point one unit from two of its vertices whose l … |

### B. Planes over number fields: the local–global conjecture, residue targets, character colourings (rows 52–127) — 66 rows

| row | grades outside the kernel | part in the kernel | the row's head, in the ledger's words |
|---|---|---|---|
| 52 | hand, "stay [hand" | yes | The finite-plane bound and the first exact wall-broken planes |
| 53 | derived | no | The field sieve |
| 54 | tools | no | The lift |
| 56 | tools | no | Local–global tightness |
| 57 | tools | yes | Theorems A and B. |
| 59 | hand | no | The 2-adic law of four-colour compulsions over K |
| 62 | tools | no | Overcompression is an orbit-closure gap |
| 63 | hand | yes | Two colours from inertia, and the 2-adic splitting of multiquadratic fields |
| 64 | tools | no | A five-chromatic unit-distance graph in a 6-OPEN field, at a rotation the field screen selected |
| 65 | tools | no | Dropping `[Parts2020a]`'s coordinate shape: the object dies, the family gains six results, and the direction c … |
| 67 | hand, tools | yes | The 2-adic tower stabilises at level 4 |
| 68 | tools | yes | Six colours refused at 83, by exact certificate |
| 69 | cert | yes | The window for an exactly six-chromatic finite Euclidean plane, narrowed to five members with two of them one … |
| 70 | cert, derived | no | Five colours refused at 27, and the wall at six made finite and fractional |
| 71 | cert, hand, measured | no | Five colours refused at 23; the fractional chromatic number of the plane over K is exactly 4; fractional colou … |
| 72 | tools | no | The 3-adic barrier |
| 73 | certified | yes | Real quadratic fields that need four colours |
| 74 | certified, hand, measured | no | The census of real quadratic fields: 14 planes certified to need four colours, and what decides a field is its … |
| 75 | cert, hand, tools | yes | The residue ceiling does not drop up the tower at 7, 11, 19 or 23 — one level-one inequality governs every lev … |
| 76 | derived, hand | no | Five colours over ℚ(√3,√5): not landed by a forcer (the value landed at row 123, [hand], through MR) — and whe … |
| 77 | method | no | The theorem audit: every theorem every milestone M17–FS-66 proved outside the kernel, found, filed and indexed |
| 78 | cert, hand, tools | yes | Four colours on de Grey's lattice: `F = P = 8Λ` — every four-colouring of it is `8Λ`-periodic — and where else … |
| 79 | cert, hand, tools | yes | Three colours are linear: every Cayley graph of a finitely generated torsion-free abelian group is 3-colourabl … |
| 80 | hand, tools | no | Four colours, cell by cell: no certificate of non-four-colourability comes from the colour complex one cell at … |
| 81 | cert, tools | no | ℚ(√167) at four colours: `L21cc6506` — the lattice that proved `χ(ℚ(√167)²) ≥ 4` — is four-colourable and loos … |
| 82 | derived, hand | yes | Three colours over every subfield of ℝ whose unit-vector ring holds 1/3: `χ(F²) ≥ 4` whenever `1/3 ∈ ℤ[U_F]` a … |
| 83 | cert, hand, reading | no | The census completed: all 40 squarefree `d ≡ 11 (mod 12)` below 500 carry a certified finite witness to `χ(ℚ(√ …` |
| 84 | cert, measured, reading | no | Four colours, calibrated before ℚ(√47): on de Grey's lattice the forcing graph X_A refuses four colours at R = … |
| 85 | hand | no | Four colours on de Grey's lattice, derived: every proper four-colouring of `Cay(Λ, U)` is `8Λ`-periodic, local … |
| 86 | hand | no | Four-colour rigidity without triangles exists in the abstract class, and in the plane it is exactly Soifer's p … |
| 87 | hand, tools | no | What does not reach `8Λ`, and a slack plane that forces anyway: on de Grey's lattice second moments cannot lif … |
| 88 | hand | no | The field-level frame for type-(B) fields: over ℚ(√59), ℚ(√83), ℚ(√131) either every four-colouring of the pla … |
| 89 | hand | no | Every four-colouring of the plane over K = ℚ(√3, √11) is, on each `R_K`-coset, a pullback from row 67's `P₄` a … |
| 90 | hand | no | The plane over `ℚ₂(√3)` is four-colour rigid — every four-colouring of it, measurable or not, is a pullback fr … |
| 91 | hand | no | Every natural construction of a non-periodic four-colouring of a type-(B) plane is impossible — two-pullback p … |
| 92 | hand | no | Measurable windows cannot colour type-(B) planes non-periodically: over every field in S2, a four-colouring re … |
| 93 | hand | no | What propagates up a dyadic tower and what does not: every unramified quadratic dyadic tower containing `√3` i … |
| 94 | hand | no | Two neighbours of the class, decided: an explicit non-periodic four-colouring of ℚ(√11)'s plane by formula, an … |
| 95 | hand | no | Rational band rigidity: every four-colour band character of the rational unit circle's ring `Q = ℤ[i][1/p : p …` |
| 96 | hand | no | What rational band rigidity settles at the exposed fields: HD1 holds for ℚ(√59), ℚ(√83), ℚ(√131) (every four-c … |
| 97 | hand | no | One prime is not enough, and why: over `ℤ[U₅]` the four-colour band set is not torsion plus archimedean — a he … |
| 98 | hand | no | Band rigidity at every band: for every finite set `S` of primes `≡ 1 (mod 4)` with `\\|S\\| ≥ 2` and every `k …` |
| 99 | "stay hand" | yes | Three colours obey the local–global conjecture over every real number field: `χ(F²) ≤ 3 ⟺ L(F) ≤ 3`, and `χ(F² …` |
| 100 | hand | no | The class theorem for character colourings (CLG), at existence scope: for every real number field `F` and `k ≥ …` |
| 101 | hand | no | The character chromatic numbers of the window's planes and of the exposed fields: every band `k`-character of … |
| 102 | hand | no | One prime fails three ways, at every split prime: `Θ₄(R_{{p}}) ⊄ T + A` for every `p ≡ 1 (mod 4)`; `MS₄({p})` … |
| 108 | hand | no | Rank-one four-colour inheritance, restated and reduced but not decided: for finite `D ⊂ ℤ_{>0}`, FS-76's rank- … |
| 109 | hand | no | The mixing selection: if `K` is compact abelian and a probability `ν` on `T_K ⊆ K` has every non-trivial Fouri … |
| 110 | hand | no | Windows at five colours over ℚ(√167): no measurable window five-colouring reads a finite set of places with no … |
| 111 | hand | no | Four-colour rigidity over a real S2 field splits into invariant measures and transience: `F(R) ≠ 0` iff every … |
| 112 | hand | no | Theorem C over the real fields: over every real field in S2, a translation-invariant random four-colouring of … |
| 113 | hand | no | At ℚ(√47) no invariant random four-colouring reads finitely many places: no translation-invariant probability … |
| 114 | hand | no | The colourings of a product with a gap-free factor. FS67(G, k) — every `k`-colouring of `G × H`, for every con … |
| 115 | hand | no | Mixing pins a product colouring. If `G` is `k`-gap-free (any graph, connected or not) and `H = Cay(A, T)`, `A` … |
| 116 | hand, reading | no | Kronecker selection is false as stated, and at ℚ(√47) its corrected form is the question. For a real number fi … |
| 117 | hand | no | T-C(A)'s class among real quadratic fields is the conjecture's `L ≥ 5` family, and SP-Cor holds over it. For ` …` |
| 118 | hand, reading | no | Rank one of Kronecker selection, and why Einsiedler–Lindenstrauss's classification does not apply. Over every … |
| 119 | hand | yes | `χ(ℚ(√167)²) ≥ 4` in the kernel, with no finite graph: a proper three-colouring of any abelian Cayley graph ca … |
| 120 | hand | no | Measure rigidity for the unit-vector group: for every real number field `F` with `R_F = O′` (row 100 — every ` …` |
| 121 | hand, "not in the kernel" | yes | `χ(ℚ(√47)²) = 5`: the local–global conjecture's cheapest exposed five-clause is met. MR at ℚ(√47) (row 120) wi … |
| 122 | hand | no | Where the other routes to MR stop: the one-sided flip needs a quantitative T-C(A); equidistribution is false; … |
| 123 | kernel, hand | yes | The local–global conjecture's main clause through five: for every real number field `F`, `χ(F²) ≥ min(L(F), 5) …` |
| 124 | hand | no | The type-(B) fields given MR: over ℚ(√59), ℚ(√83), ℚ(√131) every rotation- and translation-invariant random fo … |
| 125 | hand | no | Six at ℚ(√167) contains a question about the real plane alone. Given MR: `χ(ℚ(√167)²) ≤ 5` ⟺ `Y = UD(ℝ²) × G₂₃ …` |
| 126 | hand | no | TR-ROT is Q-μ, and its spectral side is closed on `E`. Given MR, over ℚ(√59), ℚ(√83), ℚ(√131) row 124's one st … |
| 127 | hand | yes | The main clause through five in the kernel, conditional on named hypotheses: `min(L(F), 5) ≤ χ(F²)` for every … |

### C. The witness era: measurements around kernel-checked objects (rows 1–51) — 26 rows

| row | grades outside the kernel | part in the kernel | the row's head, in the ledger's words |
|---|---|---|---|
| 12 | tools | no | Extension profile |
| 13 | tools | no | Negative knowledge |
| 15 | tools | no | First nonzero extension pressure |
| 16 | tools | no | The coupled automaton is dead |
| 19 | tools | no | Kill mechanism and partner web |
| 21 | tools | no | Registered statistics |
| 26 | tools | no | De Grey anatomy |
| 27 | tools | no | Quadrature law |
| 29 | tools | no | Stacking law |
| 30 | tools | no | Mechanism hunt |
| 31 | tools | no | Act One in the kernel |
| 32 | tools | no | Two-sided 6-programme |
| 37 | tools | no | Gap atlas |
| 38 | tools | no | Gradient hunt |
| 40 | tools | no | The fine tail |
| 41 | tools | no | Limit lemma |
| 42 | tools | no | The arity floor |
| 43 | tools | no | De Grey's witness, bracketed |
| 44 | tools | no | The two-distance dial |
| 45 | tools | yes | Batch descent |
| 46 | tools | no | Copy unions |
| 47 | hand | no | M53, halted when Theorem B was proved |
| 48 | tools | no | Critical-set localization |
| 49 | tools | no | Absorption |
| 50 | tools | no | The additive yardstick |
| 51 | tools | no | Additive rigidity |
