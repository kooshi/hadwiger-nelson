# FS-75's minimal instance — `χ(ℚ(√167)²) ≥ 4` in the kernel (plan)

*Job J52, de Bruijn (Opus 5.5), 2026-09-26, planner. Brief: `data/crunch-2026-09-25/briefs/J52-FS75-kernel-167-planner.md`, with
`STANDING-RULES.md` and J03's template; owner's notes (in the launch message) override the brief. A kernel milestone: sections §G, §PA,
§S, §P, §M, §X — no §IQ (WORKFLOW 3.3 excludes a kernel port).*

*`CLAUDE.md` read from a snapshot taken at commit `592ea289c0056bdd851bdb3164b4ddcc5edb7fec` (`git show HEAD:CLAUDE.md`, owner's note 2;
J05's last `CLAUDE.md` commit then was `179c6c5b J05: stage 2 batch 1`). The snapshot lives at `data/fs75/j52/CLAUDE-snapshot.md`, is not
committed, and is deleted at the last stage.*

## Stage 1 — SAVED

### 1.1 Quotation check (standing rule 5)

| quotation in the brief | source | verdict |
|---|---|---|
| the stub's aim, "**Re-aimed at FS-91's close.** The kernel target is S1 … FS73-T22's ⟹ as the named hand inputs." | `plans/STUB-three-colour-criterion-kernel.md` line 3 | verbatim |
| "**The smallest instance first**" | stub, § Shape, after item 4 | verbatim (the stub has a trailing colon) |
| item 4, "**Compose:** `Θ₃(S) = ∅` ⟹ … no native purchase." | stub § Shape item 4 | verbatim |
| item 1, "**Only the relation form is needed downstream** (T42): … the certificate uses that direction alone" | stub § Shape item 1 | verbatim (a line break in the source) |
| item 2, "`{1, v, z}·U_R` have `Θ₃ = ∅` by a 1,050-leaf certificate (5.7 KB, …) and a half-page hand proof (four inequality cases)" | stub, "The smallest instance first" | verbatim |
| item 3, "each listed vector checked by `decide` in ℤ" | stub § Shape item 3: "each listed vector is checked by `decide` in ℤ" | not in quotation marks in the brief; a faithful paraphrase |
| the advisor's card, "ask: … / if under about three hours … / if over: …" | `plans/POROS-2026-09-26-next-two-milestones.md` lines 179–181 | verbatim |
| "J43's facts file shows **no field-level lower bound at either exposed field of the conjecture in the kernel**" | same record, line 81: "**No field-level lower bound at either exposed field is in the kernel.**" | faithful (not quoted in the brief) |
| FS-87's fallback, "**Next:** target 2, dB9's V1; then target 3, … price both from target 1's rate"; "17 minutes against a 4–6 hour price" | `plans/STUB-de-grey-chain-kernel.md` line 3 | verbatim |
| the hunch `leaf-one-is-elementary` | POROS record lines 217–223 | the brief's route sketch restates its claim faithfully |

No quotation fails. One scope note: the stub's item 1 describes the full criterion (descent to `Λ`, Følner, compactness); the brief's route
sketch and the hunch describe the relation form only. §S below takes the relation form and goes one step further (1.3).

### 1.2 The reading

- **The stub** (in full). Four shape items; the smallest instance is T41's 36 vectors (18 ± pairs), certificate
  `data/fs73/verify-v2/L21cc6506-sub-1vz-empty.json.gz`.
- **FS73-T22** (`plans/FS73-derivation.md` §4): the criterion, both directions, hand, two minds. **T39**: `L21cc6506` has `Θ₃ = ∅`, three
  routes; the kernel decision is this stub. **T41**: the 36-vector minimal obstruction, a 1,050-leaf certificate and a four-case hand
  proof in `θ`-space (E's product route: `μ₁ = c0 + 5k + δ₁`, cases by coordinate bounds). **T42**: V2's forward lift — steps in `{1, 2}`,
  the square argument (two-step sums in `{2, 3, 4}`, congruent mod 3, hence equal), winding `w : R → 3ℤ`, Følner averages, descent through
  the direct-summand property; and the relation form: "(a) If θ ∈ Θ, then x_j := θ(u_j) − ⌊θ(u_j)⌋ lies in B, and r·x ∈ ℤ for every
  r ∈ R" (`data/fs73/records/verify-P3b-q167.md` §2).
- **verify-P3b-q167.md §1–2** (in full). §1's steps 1–6; the hypotheses audit ("*Torsion-free*: used in step 5, and it is essential";
  "*S generating*: **not needed**"); the subgraph step `(a, b, c, e) ↦ ((a + b√167)/420, (c + e√167)/420)`. §2's certificate semantics:
  a branch names a relation `r` (checked `Σ r_j u_j = 0`) and `lo..hi`, children `r·x ≤ lo − 1`, `r·x = k`, `r·x ≥ hi + 1`; a leaf's
  rational multipliers (`≥ 0` on inequalities, any sign on equalities) give `w·x ≤ ρ` with `Σ_j min(w_j/3, 2w_j/3) > ρ`; "The checker
  derives every constraint from (r, lo, hi) itself."
- **The certificate's format** (`tools/fs73v2_check.py`, frozen, read only; the file itself): keys `verdict, d, key, units, relations,
  tree, stats`; `units` = 18 integer 4-vectors `(a, b, c, e)`, denominator 420; `relations` = 19 integer 18-vectors; a node is
  `["B", relIndex, lo, hi, children]` (`hi − lo + 3` children) or `["F", [[pathPos, num, den], …]]`. **Measured** (Python, seconds, on
  the file): 1,575 nodes, 1,050 leaves, 7,155 multiplier entries, depth ≤ 14 (mean 8.4), `|r_j| ≤ 2`, `|num| ≤ 11`, `den ≤ 30`, at most
  5 children. Small: the kernel check is not the cost.
- **House API** (grep): Mathlib's `SimpleGraph.addCayley` (`Combinatorics/SimpleGraph/Cayley.lean`, `fromRel (∃ g ∈ s, · + g = ·)`);
  the house's `planeOver`, `fieldOfRadicands`, and the precedent statement `four_le_chromaticNumber_planeOver_eleven : 4 ≤
  ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).chromaticNumber` (`Instances/SqrtEleven.lean`, a finite graph and an
  LRAT); `CayleyCertificate.lean` (a `Bool` over packed data, properness over the connection set only) and `NarrowCert` as the house
  checker pattern. No module holds `Θ` or a winding.

### 1.3 A finding at the reading, to be priced at stage 3

The certificate never uses the point `x`. Along a path it uses three facts about the functional `r ↦ r·x` on the relation lattice `R`:
its value on each branch relation is an integer (so exactly one child holds); it is additive on `R`; and on every `Q ∈ R` it is at least
`Σ_j min(Q_j/3, 2Q_j/3)` (the box minimum). **A proper three-colouring supplies such a functional directly, with no averaging:** the
forward lift's height along words gives `w(r) = D(a, word r⁺) − D(a, word r⁻)`, additive on `R`, `≡ 0 (mod 3)`, and — since a word of
length `n` has height gain in `[n, 2n]` — `w(r) ≥ |r⁺| − 2|r⁻| = Σ_j min(r_j, 2r_j)`. So `W = w/3 : R →+ ℤ` with
`3·W(Q) ≥ Σ_j min(Q_j, 2Q_j)`, and a leaf with integer multipliers `Λ` (the rational ones scaled per leaf) refutes by
`3W(Q) ≥ Σ min(Q_j, 2Q_j) > 3P ≥ 3W(Q)`. **No Følner sets, no Bolzano–Weierstrass, no Farkas lemma, no descent, no torsion-freeness.**
The real point `x` exists too (by LP duality from the same interval bound, 1.3's remark in §S), but the kernel target does not need it.
This is registered as a prediction (P-elem) and priced at stage 3; it is one mind's derivation and is audited there as hard as a result I
dislike.

### Would have searched here (stage 1)

- None.

## Stage 2 — SAVED

## §G — the re-grokking (WORKFLOW 3.1, crunch terse form)

*Walked from the snapshot (`CLAUDE.md` at `592ea289`) and `LEDGER.md` at the same commit, both open; § A read in full, § B grepped for
FS73-T22, T39, T41, T42 and FS81-T1–T5. The milestone's question in the theory's terms: **move row 79 (`χ(ℚ(√167)²) ≥ 4`) from a checker's
word to the kernel's, through the three-colour criterion's relation form (G71), T41's 36-vector certificate and the embedding** — a
kernel port; no mathematics is claimed new except the form of the criterion the kernel needs (1.3).*

### G.1 Grokkings (79)

- G1 — silent: the four/five wall; this is three colours.
- G2 — silent: construction grammar of five-chromatic witnesses.
- G3 — silent: radii of certified witnesses.
- G4 — silent: shell vocabulary over K.
- G5 — silent: 1-sums of de Grey's graph.
- G6 — silent: hexagram containment.
- G7 — bears: `v = (83 + i√167)/84` is the type-M rotation `n = 42` (`cos θ = 83/84`, radicand `4n − 1 = 167`); name it so in leaf 3's module doc → leaf 3.
- G8 — silent: direction group of K.
- G9 — silent: four-colour forcing over K.
- G10 — silent: forcing localisation.
- G11 — silent: Moser-free five-forcers.
- G12 — silent: quadrature of detuned copies.
- G13 — silent: fans are not used here.
- G14 — silent: matchings and colour pressure.
- G15 — silent: five-colour pigeonhole × kill.
- G16 — silent: distance-2 pigeonhole over K.
- G17 — silent: top-rung globality.
- G18 — bears: certify components, compose in the kernel — the theorem is three separately-checked leaves composed; no finite graph is ever built → §S.
- G19 — silent: five-tight fabric.
- G20 — silent: brick colourings.
- G21 — bears: a certificate measures its enumeration — the Lean checker derives every constraint from `(r, lo, hi)`, re-checks every relation, and plants must fire for their own reason → leaf 2.
- G22 — silent: six-colourings.
- G23 — silent: cell family.
- G24 — silent: gap law.
- G25 — silent: recursive forcing ladder.
- G26 — silent: six-forcer reduction.
- G27 — silent: Galois symmetry; the conjugate `{1, v̄, z̄}` is not needed.
- G28 — silent: fine-tail forcing.
- G29 — silent: cell family closed.
- G30 — bears: (5) the criterion's hypothesis is a structure — ship an inhabitant (a proper 3-colouring of a small `addCayley`); (6) state it over any `AddCommGroup` → leaves 1, 2.
- G31 — silent: pair compulsions at the top rung.
- G32 — silent: two-distance dial.
- G33 — silent: batch descent.
- G34 — silent: in-field descent.
- G35 — silent: the 2-adic wall bears on five colours.
- G36 — silent: residue colouring over K.
- G37 — silent: endgame of a five-forcer.
- G38 — bears: at three colours the obstruction covers all colourings, not only additive ones — the kernel's criterion is that passage; say so in leaf 1's doc → leaf 1.
- G39 — silent: critical-set localisation.
- G40 — silent: absorption.
- G41 — silent: four-colour additive yardstick.
- G42 — silent: additive rigidity.
- G43 — silent: residue sealing gives upper bounds.
- G44 — silent: Kloosterman spectra.
- G45 — silent: lifting residue configurations.
- G46 — bears: name the object classically — a proper 3-colouring is a homomorphism to `K₃`, whose universal cover is ℤ: a height and its winding cocycle; §PA's query words → §PA.
- G47 — silent: five-colour residue compulsions.
- G48 — silent: the conjecture's ≥ 6 at ℚ(√167) is untouched; this confirms nothing new.
- G49 — bears: the gate for a kernel milestone is Mathlib and core; attribution of the criterion (Chandgotia; FS-73's T22/T42) → §PA.
- G50 — bears: read Mathlib's statements, not memory, before the skeleton → §PA.
- G51 — silent: one planner, one implementer.
- G52 — silent: equal-radius family.
- G53 — silent: counting compulsion.
- G54 — silent: tight/slack residue planes.
- G55 — bears: row 103's chain theorem is the precedent statement shape (`planeOver (fieldOfRadicands …)`); no chain route exists at 167 at three colours (no triangle, no rhombus forcer) → leaf 4, §S alternatives.
- G56 — silent: window for six.
- G57 — bears: ℚ(√167) has no √3, so its unit-distance graph is triangle-free — why the Θ route, not a chain, is the only three-colour route here → §S alternatives.
- G58 — silent: antipodal conjecture.
- G59 — silent: wall at six.
- G60 — silent: fractional lower bounds.
- G61 — bears: the 3-adic barrier — directions integral at 3 are three-colourable (row 72, kernel), so a certificate must use a vector with 3 in its denominator (420 = 2²·3·5·7); T41's minimality (drop any ± pair ⟹ `Θ₃ ≠ ∅`) supplies free negative controls → leaf 2.
- G62 — bears: the 36 vectors are a three-layer multilayer `{1, v, z}·U_R`; the emitter states the construction (re-derivable witness) → leaf 3.
- G63 — silent: transcendence.
- G64 — silent: six as a value.
- G65 — silent: SAT phase diagram (no solver).
- G66 — silent: residue towers.
- G67 — bears: count at §G.4 how many bears came from Do lines against bodies → §G.4.
- G68 — silent: quotient screens (search; four colours).
- G69 — silent: rigidity over ℚ(√3,√5).
- G70 — silent: √3-clean colourings over K.
- G71 — bears: the criterion itself; *Do*: "decide it by `Θ₃`, an exact polytope tree with Farkas leaves"; "Nothing kills the three-colour theorem" — the kernel target is its ⟹ direction plus one tree → leaves 1, 2.
- G72 — silent: §IQ does not apply to a kernel port; but 1.3's winding is its "invariant every solution carries" — recorded at §G.4.
- G73 — silent: four-colour certificates.
- G74 — bears: the field-level alternative (row 82: `1/3 ∈ ℤ[U_F]` plus an odd cycle, `167 ≡ 11 (mod 12)`) proves the same bound for the whole family; declined here, it needs C1(5)'s cells and L1's inverse limit → §S alternatives.
- G75 — silent: four-colour identities on de Grey's lattice.
- G76 — silent: four-colour rigidity over type-(B) fields.
- G77 — silent: character colourings.
- G78 — silent: rank-one four-colour shifts.
- G79 — bears: the winding functional `W` is the *example* invariant (every 3-colouring carries it); the tree is the wanted poster for `W`, and the kernel needs only `W` → leaf 1, §G.4.

### G.2 Rows (115)

- row 1 — silent: two-circle 3-colouring.
- row 2 — silent: seam identity.
- row 3 — silent: coverage ratchet.
- row 4 — silent: fan ⟺ coverage.
- row 5 — silent: class-only graphs.
- row 6 — silent: 120° identity.
- row 7 — silent: greedy colouring.
- row 8 — silent: balanced 5-colouring.
- row 9 — silent: 120° compulsion.
- row 10 — silent: one-pivot cap.
- row 11 — silent: strip automaton.
- row 12 — silent: extension profile.
- row 13 — silent: negative knowledge, M17–M19.
- row 14 — silent: pair gluing.
- row 15 — silent: extension pressure.
- row 16 — silent: coupled automaton.
- row 17 — silent: circle intersections.
- row 18 — silent: near-relation.
- row 19 — silent: kill mechanism.
- row 20 — silent: pivot triangle.
- row 21 — silent: registered statistics.
- row 22 — silent: ladder pair.
- row 23 — silent: four-ladder object.
- row 24 — silent: hexagram.
- row 25 — silent: field-wall identity.
- row 26 — silent: de Grey anatomy.
- row 27 — silent: quadrature law.
- row 28 — silent: 2-adic kill engine.
- row 29 — silent: stacking law.
- row 30 — silent: mechanism hunt.
- row 31 — silent: five-colour pigeonhole carriers.
- row 32 — silent: six-programme.
- row 33 — silent: the interval; certificate machinery for finite graphs.
- row 34 — silent: coset chromatic number.
- row 35 — silent: coarse cells.
- row 36 — silent: scale non-monotone.
- row 37 — silent: gap atlas.
- row 38 — silent: gradient hunt.
- row 39 — silent: gap atlas, kernel.
- row 40 — silent: fine tail.
- row 41 — silent: limit lemma (compactness is not needed, 1.3).
- row 42 — silent: arity floor.
- row 43 — silent: de Grey bracketed.
- row 44 — silent: two-distance dial.
- row 45 — silent: batch descent.
- row 46 — silent: copy unions.
- row 47 — silent: M53.
- row 48 — silent: critical sets.
- row 49 — silent: absorption.
- row 50 — silent: additive yardstick (four colours).
- row 51 — silent: additive rigidity.
- row 52 — silent: finite-plane upper bound.
- row 53 — silent: field sieve.
- row 54 — silent: the lift.
- row 55 — silent: residue obstruction.
- row 56 — bears: `addCayleyMap`, `addCayleyColoring` — the house's `addCayley` API for the inhabitant and the corollary → leaf 1.
- row 57 — silent: Theorems A and B.
- row 58 — silent: Moser recipe threshold (three-colour rhombus needs triangles).
- row 59 — silent: 2-adic law over K.
- row 60 — silent: plane freedom.
- row 61 — silent: six-target generality.
- row 62 — silent: overcompression.
- row 63 — silent: two colours from inertia.
- row 64 — silent: ρ₆₃ arena.
- row 65 — silent: Parts's shape dropped.
- row 66 — silent: fan gap.
- row 67 — silent: 2-adic tower.
- row 68 — silent: six refused at 83.
- row 69 — silent: window for six.
- row 70 — silent: five refused at 27.
- row 71 — silent: five refused at 23 (ℚ(√167)'s L ≥ 6, not this bound).
- row 72 — bears: the 3-adic barrier (kernel) — the control that 3-integral directions three-colour; `ThreeAdicBarrier.Plane 167` and `diamond167` are the house's ℚ(√167) objects → leaves 2, 3.
- row 73 — bears: `four_le_chromaticNumber_planeOver_eleven`'s statement is the target's shape; ℚ(√11)'s is the only kernel field-level three-colour refusal so far, by LRAT → leaf 4.
- row 74 — silent: census (its witnesses are FS-60's).
- row 75 — silent: tower ceilings.
- row 76 — silent: ℚ(√3,√5) at five.
- row 77 — silent: theorem audit.
- row 78 — silent: `F = P = 8Λ`.
- row 79 — bears: the result being ported; "No finite non-3-colourable graph is exhibited" — the kernel theorem needs none (1.3) → all leaves.
- row 80 — silent: four colours cell by cell.
- row 81 — silent: `L21cc6506` four-colourable.
- row 82 — bears: the family theorem subsumes the instance at 167; the stub's re-aimed target; this milestone is its minimal instance → §S alternatives.
- row 83 — silent: census certificates (the stub's fallback, not needed).
- row 84 — silent: four colours calibrated.
- row 85 — silent: de Grey's lattice derived.
- row 86 — silent: triangle-free rigidity.
- row 87 — silent: slack plane.
- row 88 — silent: type-(B) frame.
- row 89 — silent: K's four-colourings.
- row 90 — silent: ℚ₂(√3) rigidity.
- row 91 — silent: type-(B) no-gos.
- row 92 — silent: measurable windows.
- row 93 — silent: dyadic towers.
- row 94 — silent: ℚ(√11) non-periodic four-colouring.
- row 95 — silent: rational band rigidity.
- row 96 — silent: character colourings at exposed fields.
- row 97 — silent: one prime.
- row 98 — silent: band rigidity at every band.
- row 99 — silent: three colours obey LG (needs S1; the stub's next target, not this one).
- row 100 — silent: CLG.
- row 101 — silent: character chromatic numbers.
- row 102 — silent: one prime fails.
- row 103 — bears: the kernel lane's precedent — statement form `4 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands …))).chromaticNumber`, `Chain.planeOverSubring`, `Chain.norm_eq_one_of_sq` → leaves 3, 4.
- row 104 — silent: transcendence.
- row 105 — silent: prime inversion.
- row 106 — bears: the stripe lemma's rate (447 lines, 17 minutes against a 4–6 hour price) — the price calibration for §S → §S pricing.
- row 107 — silent: the bridge.
- row 108 — silent: rank one.
- row 109 — silent: mixing selection.
- row 110 — silent: windows at five.
- row 111 — silent: row 88's split.
- row 112 — silent: Theorem C.
- row 113 — silent: ℚ(√47) measures (the second instance here is three colours, not four).
- row 114 — silent: products.
- row 115 — silent: mixing pullback.
- § B FS73-T22 — bears: the criterion; its ⟹ is leaf 1 in relation (winding) form → leaf 1.
- § B FS73-T39 — bears: the 60-vector tree is leaf 2's scaling control, optional → leaf 2.
- § B FS73-T41 — bears: the 36-vector minimal instance and its 1,050-leaf certificate; the four-case θ-space proof is declined (it needs θ, i.e. the full criterion) → leaf 2.
- § B FS73-T42 — bears: the forward lift and the relation form — the proof leaf 1 follows, minus the averaging → leaf 1.
- § B FS81-T1–T5 — silent for this instance: the family route (row 82); FS81-T2's inverse limit is the stub's next leaf, not this one.

### G.3 Method rules (the walk of `CLAUDE.md` § What compute actually helps, § Standard of evidence, § Trust ledger, § Toolchain,
§ Building, § The kernel's cost model, § Searching, § The package, § The gate, § Make the gate fail)

- M1 (a kernel leaf priced after an obligation pass is priced high; re-price from the first two leaves; grep Mathlib by shape at the skeleton) — bears: §S prices from the pass; J52K's stop rule → §S, J52K.
- M2 (Lean for certified checks; GMP `Nat`) — bears: integer arithmetic throughout the checker → leaf 2.
- M3 (a GPU is not a SAT accelerator) — silent.
- M4 (no native evaluation in the headline) — bears: `decide +kernel`, no `native_decide`, standard three axioms → leaf 4, J52K.
- M5 (the artifact is the certificate plus the checker) — bears: the certificate as a Lean literal with its provenance to the `.gz` → leaf 2.
- M6 (the witness must be re-derivable) — bears: state `{1, v, z}·U_R` in the module doc → leaf 3.
- M7 (read the final statement aloud) — bears: J52K's gate item → leaf 4.
- M8 (report the hunt honestly) — bears: the price and the swap are findings either way → §S.
- M9 (write the certificate for the reviewer early) — bears: what a sceptic checks is 18 unit identities, 19 relation identities, one tree, and the lift → §S.
- M10 (order verification by marginal value) — bears: the checker checks units and relations before the tree → leaf 2.
- M11 (`#print axioms`; grep per-declaration native axioms) — bears: J52K's gate → J52K.
- M12 (`lean4checker` is a publication gate) — silent: not run.
- M13 (elan pin; `source scripts/dev-env.sh`) — bears: `lake env lean` needs the env → §S.
- M14 (the finite-witness ban) — bears: §X; the certificate exists and is only checked → §X.
- M15 (inventory; ask before provisioning) — silent.
- M16 (pysat interrupts) — silent.
- M17 (venvs outside `build/`) — silent.
- M18 (break symmetry before SAT) — silent.
- M19 (Python 3.14 forkserver) — silent: the tool is single-process.
- M20 (CPU seconds, min of three, name the machine) — bears: J52K measures the checker's kernel time that way → J52K.
- M21 (predicted beside measured throughput) — bears: P-check registers the kernel check's time → §P.
- M22 (always `scripts/build.sh`, never `lake build`) — bears: J52K's build line → J52K.
- M23 (`lake env lean` builds nothing and skips `autoImplicit := false`) — bears: skeleton carries `set_option autoImplicit false` → §S.
- M24 (the batch is the plan; measure a module's peak) — bears: J52K measures the certificate module's RSS → J52K.
- M25 (on an unexplained crash, halt) — bears: J52K's brief → J52K.
- M26 (RAM is the discriminator; `scripts/slot.py`) — bears: builds under `slot.py --mem 60` → J52K.
- M27 (checkpoint and resume, PROTECTED) — bears: no run exceeds 15 minutes; the implementer's resume point is its last committed leaf, written in J52K → J52K.
- M28 (a blocking run is presumed killable, PROTECTED) — silent: no long runs.
- M29 (kill by pid, never by pattern) — bears: J52K's rules → J52K.
- M30 (a pipe can hide an exit status) — bears: the gate's exit status read directly → J52K.
- M31 (never edit a running script) — silent.
- M32 (docstrings rebuild dependents; `--` comments do not) — bears: settle the criterion module before the certificate module imports it → §S.
- M33 (`decide +kernel`, not `decide`) — bears → leaf 2.
- M34 (reduction steps cost; GMP `Nat`/`Int` free) — bears: 7,155 multiplier entries × 18 coordinates ≈ 1.3·10⁵ integer operations → leaf 2, §P.
- M35 (literals, never tables built during evaluation; no `List.range` + `List.map`) — bears: children's constraints built by a small recursion, the certificate a literal → leaf 2.
- M36 (`List.all`, not `∀ x ∈ l`) — bears → leaf 2.
- M37 (no numeral at an unsimplified type index) — bears: data in `ℤ`, `ZMod 3` only in proofs → leaves 1, 2.
- M38 (feed the kernel the core) — bears: the 36-vector minimal obstruction is the core; the 60-vector tree only a control → leaf 2.
- M39 (`grep -E` is ugrep; `^` inside a pattern) — bears: J52K's sorry scan uses the gate's `grep -rn` → J52K.
- M40 (`rg` respects `.gitignore`) — silent.
- M41 (a failed `exact?` is not an absence; grep core) — bears: §PA searched core and Mathlib by grep → §PA.
- M42 (`autoImplicit` off; `debruijn-init` for dependencies) — bears: no new dependency → §S.
- M43 (vacuity: every structure hypothesis ships an inhabitant) — bears: the criterion's hypothesis gets `inhabitant`; `Winding`'s emptiness under a passing certificate is a refutation (concludes `IsEmpty`/`False`) → leaves 1, 2.
- M44 (every gate keeps what it computed) — bears: J52K reads `build/gate/` before re-running → J52K.
- M45 (every definition has an `example`/`#eval`) — bears → §S.
- M46 (the Moser spindle proved twice) — silent.
- M47 (read the statement against `chromaticNumber`) — bears → leaf 4.
- M48 (make the gate fail) — bears: planted certificates (a non-relation, a negative multiplier on an inequality, a dropped child, a shifted range) must make `check` false → leaf 2.
- M49 (a positive signal for the thing that did not happen) — bears: the Python mirror reports leaves visited → leaf 2.
- M50 (a waiter's condition false at arming) — silent: no waiters planned.
- M51 (state the uninformative outcome; confirm it reachable) — bears: §P names both outcomes → §P.
- M52 (pre-decide how to respond to a red gate) — bears: J52K's stop rule → J52K.
- M53 (a sharp instrument loses coverage) — silent.
- M54 (a number carries what it measures) — bears: price in implementer wall-clock minutes; kernel check in CPU seconds → §S, §P.
- M55 (exactly one thing differs between compared numbers) — bears: the stripe-lemma rate is lines-and-minutes for one leaf; compared per leaf → §S.
- M56 (confirm both outcomes reachable) — bears → §P.
- M57 (measured and derived halves fail in opposite directions) — bears: the constraints are derived, so a refusal is the suspect verdict — plants and a mirror → leaf 2.
- M58 (a check reads the value the code ships) — bears: the soundness theorem's hypothesis is the shipped `check` → leaf 2.
- M59 (failure-path formatting) — silent.
- M60 (bound a plant on both sides) — silent.
- M61 (replay policies) — silent.
- M62 (a failing run understates cost) — bears: time the check on the passing certificate (`List.all` short-circuits on a plant) → §P.
- M63 (a caveat written then stepped over) — bears: the report says "relation form; no `θ`, no finite graph" at every mention → report.
- M64 (count a generator's free parameters) — silent.
- M65 (a true explanation stops the search for a second) — bears: audit 1.3 for a skipped step before trusting it → §S.
- M66 (a mutation harness verifies its restore) — bears: `tools/j52_*.py`'s plants restore and re-verify → leaf 2.
- M67 (mutate the constant) — silent.
- M68 (archiving a checker) — silent.
- M69 (enumerate the parameter first) — silent.
- M70 (a positive control proves only shapes its generator can represent) — bears: the inhabitant is an honest proper colouring, not a certificate → leaf 1.
- M71 (one-sided filters) — silent.
- M72 (scars, not foresight) — silent.
- Delegation (one level deep; at most three agents) — bears: J52K's brief carries it with its reason → J52K.
- Trust ledger (`sorryAx` fails the gate; purchases declared) — bears → J52K.
- Shape of the proof ("nothing in `tools/` is trusted") — bears: the emitter and mirror are untrusted; Lean refuses bad data → leaf 2.

### G.4 What the re-grokking changed

1. **The criterion's form.** G79 and G71 together, read against the certificate's semantics (1.3): the kernel needs the **winding
   functional**, not the point `x` or `θ`. Leaf 1 loses its analytic half (averages, compactness). Registered as P-elem.
2. **The transfer.** Rows 73 and 103 fix the statement shape; G30(6) and row 103 fix the transfer as an additive map `ℤ⁴ → ℂ` into
   `planeOver`, with no finite graph and no injectivity (leaf 3 shrinks to membership and eighteen norm identities).
3. **The alternatives are named and declined** (G55, G57, G74, row 82): no chain route at 167 (triangle-free); the family theorem is the
   stub's next target, not this one.
4. **The controls** (G21, G61, M48, M57): T41's minimality supplies negative controls for free — the certificate with one ± pair dropped
   cannot pass.
5. **G67's count:** of the 16 grokking bears, 7 came from a *Do* line (G7, G49, G50, G61, G62, G71, G74) and 9 from the body (G18,
   G21, G30, G38, G46, G55, G57, G67, G79); the first count at a kernel milestone, and the body carried slightly more.
6. **G72:** no §IQ, but the winding is the invariant every three-colouring carries; recorded so FS-75's next leaf (S1, row 99) is posed in
   the same shape.

**Counts** (recounted mechanically at stage 3 — the first tally, written by hand, read 21 / 9 / 50 and was wrong; G21): grokkings 79
(bears 16, silent 63, falsifiable 0 — the falsifiable items are 1.3's and are registered at §P); rows 115 (bears 7, silent 108) plus
§ B's five grep targets (bears 4, silent 1); method rules 75 (bears 53, silent 22).

### Would have searched here (stage 2)

- None.

## Stage 3 — SAVED

## §PA — what Mathlib, core and the house already hold (WORKFLOW 3.2, kernel form; grep over Mathlib, core and `Proofs/`)

| leaf | needs | held | where |
|---|---|---|---|
| 1 | the Cayley graph | `SimpleGraph.addCayley` (`fromRel (∃ g ∈ s, · + g = ·)`), `addCayley_adj` | Mathlib `Combinatorics/SimpleGraph/Cayley.lean` |
| 1 | permutation induction | `List.Perm` with `nil`/`cons`/`swap`/`trans` (`induction h` works), `Perm.recOnSwap'`, `perm_middle` | core `Init/Data/List/Perm.lean` |
| 1 | mod-3 to equality | `ZMod.intCast_eq_intCast_iff'`, `ZMod.intCast_zmod_eq_zero_iff_dvd` | Mathlib `Data/ZMod/Basic.lean` |
| 1 | `r = r⁺ − r⁻` | `Int.toNat_sub_toNat_neg : ↑n.toNat - ↑(-n).toNat = n` | core `Init/Data/Int/Order.lean` |
| 1 | word counts | `List.perm_iff_count`, `List.count_flatMap`, `List.count_replicate` (for `word_add_perm` by counts); for `wsum_word`, `Finset.sum_list_map_count` (the additive form of `prod_list_map_count`); **`List.sum_flatMap` is not held under that name** (grep, stage 3) | core `Init/Data/List/{Perm,Count}.lean`; Mathlib `Algebra/BigOperators/Group/Finset/Basic.lean:561` |
| 1 | compactness (**not needed**, 1.3) | `IsCompact.tendsto_subseq` exists | Mathlib `Topology/Sequences.lean:298` |
| 1 | the house's `addCayley` API | `addCayleyMap`, `addCayleyColoring`, `unitQuadrance_eq_addCayley` | `LocalGlobal.lean` |
| 2 | the checker pattern | `CayleyCertificate.Cert.check`/`sound`, `NarrowCert`: a `Bool` over literal data, soundness via `List.all_eq_true` | `CayleyCertificate.lean`, `NarrowFan.lean` |
| 2 | a finite-graph certificate | `UDCert` — **does not apply**: there is no finite graph (row 79); the `Θ` certificate is a new type | `Certificate.lean` |
| 3 | the field | `fieldOfRadicands`, `sqrt_mem_fieldOfRadicands`, `planeOver`, `mem_planeOver` | `SquareClass.lean` |
| 3 | unit norm from coordinates | `Chain.norm_eq_one_of_sq : z.re * z.re + z.im * z.im = 1 → ‖z‖ = 1`; `Chain.planeOverSubring` | `Chain.lean` |
| 3 | the house's ℚ(√167) objects | `ThreeAdicBarrier.Plane 167`, `diamond167` (not used: `iota` into `ℂ` is simpler) | `ThreeAdicBarrier.lean` |
| 4 | numeral form of the bound | `add_one_le_chromaticNumber_iff_not_colorable`, `lt_chromaticNumber_iff_not_colorable` | `UnitDistance.lean:60–72` |
| 4 | adjacency | `unitDistance` (`Adj x y := dist x y = 1`; use `unitDistance_adj`) | `UnitDistance.lean:40` |

**Attribution.** The criterion (T22) is FS-73's, both directions, two minds; its ⟹ by a forward lift and the relation form are V2's (T42);
the height lift through the universal cover of `K₃` is Chandgotia's height functions for four-cycle-free targets (`CLAUDE.md` § Frontier,
"Not ours"). **The winding form** — a proper three-colouring carries an additive functional on the relation lattice bounded below by the box,
read on words with no averaging — is this plan's reading of T42's steps 1–3 (1.3); it is the direction a relation-branching certificate
consumes. Not searched in print as a separate statement (a kernel milestone's gate is Mathlib); it is T42 minus its averaging step, and no
novelty is claimed for it.

**Negative, recorded:** no `Θ`, winding or height-function module in Mathlib or the house; no Mathlib Farkas lemma is needed.

### Would have searched here (§PA)

- None.

## §S — the swap, the skeleton, the obligation pass, the price

### S.0 The swap, decided: **FS-75 runs; no swap to FS-87**

- **The card's ask** (J50 §3.2): "after the obligation pass, what do the relation-form criterion's first two leaves cost in the kernel?"
- **The price, measured, not estimated:** leaf 1's children 1a–1d (`step_mem`, `step_cast`, `height_append`, `height_cast`,
  `height_bounds`, `step_square`, `height_perm` — seven lemmas, the lift and its path independence) **closed on the first elaboration, about
  five minutes of composing**, in the skeleton (`data/fs75/j52/skeleton/ThreeColourKernel.lean`). Leaf 2's computation is measured too:
  the full 1,050-leaf certificate, emitted as a literal by `tools/j52_intcert.py`, passes the skeleton's `ThetaCert.Cert.check` under
  `decide +kernel` in **19.4 CPU s (18.61 + 0.82, minimum of three: 19.43, 19.57, 19.49), peak 6.04 GB for the file** against 3.40 GB
  for the skeleton alone; desktop, `lake env lean`, one slot of 2 CPUs.
- **The remaining price, estimated from the pass** (implementer minutes; M2 measured such estimates 5–30× high): 1e words 25, 1f windings
  30, 1g packaging 45, the `addCayley` corollary 10; leaf 2's soundness 90 (the one real risk: induction over the nested `Tree`); leaf 3 40;
  leaf 4 5 (already type-checks over the `sorry`'d leaves); gate and controls 30. **Total ≈ 4.5 h at plan rates; at the first-two-leaves
  rate just measured, well under three hours.**
- **The choice:** FS-75's minimal instance runs. **Alternative weighed:** FS-87's targets 2–3 (dB9's V1, then the checker for Parts's
  nine trees), whose rate is known (target 1 in 17 minutes). **Why FS-75 wins:** the card's condition is met by measurement, not by
  estimate; and it fills the gap J50 named (no field-level lower bound at either exposed field in the kernel). **Confidence: high.** The
  fact that would change it: the nested-`Tree` soundness proof resisting three attempts (then J52K reports and the owner decides).

### S.1 Placement (per `ARCHITECTURE.md`; the skeleton lives outside `Proofs/` until sorry-free)

| module | contents | imports |
|---|---|---|
| `Proofs/HadwigerNelson/ThreeColour.lean` | §1–§2: `relMap`, `boxMin`, `Winding`, `ProperAlong`, the lift on words, `nonempty_winding`, `nonempty_winding_of_colorable`, the inhabitant | Mathlib's `Cayley`, `LocalGlobal` |
| `Proofs/HadwigerNelson/ThetaCert.lean` | §3: `Con`, `Tree`, `Cert`, the checker, `Cert.isEmpty_winding`, `Cert.not_properAlong`, `tinyK4` and its plants | `ThreeColour` |
| `Proofs/HadwigerNelson/Instances/SqrtOneSixSeven.lean` (+ `…/Cert.lean` for the literal) | §4–§5: `iota`, `norm_iota`, `unitOk`, `cert167` (emitted), `cert167_units`, `cert167_check`, `properAlong_of_colorable`, **`four_le_chromaticNumber_planeOver_sqrt167`** | `ThetaCert`, `SquareClass`, `Chain`, `UnitDistance` |

The literal module holds `--` comments only (M32: a docstring there rebuilds dependents) and is settled before `SqrtOneSixSeven` imports it.
`ARCHITECTURE.md` gets three rows; `scripts/Axioms.lean` gets the headline.

### S.2 The skeleton

`data/fs75/j52/skeleton/ThreeColourKernel.lean`, elaborating with `lake env lean` (3.3 CPU s, 3.40 GB), `set_option autoImplicit false`,
**18 `sorry` sites** left of 25 (1a–1d closed at S.0). Its statements, verbatim, are the specification; the headline:

```lean
theorem four_le_chromaticNumber_planeOver_sqrt167 :
    4 ≤ ((unitDistance ℂ).induce (planeOver (SquareClass.fieldOfRadicands {167}))).chromaticNumber
```

and the two reusable theorems:

```lean
theorem nonempty_winding (s : Fin m → A) {c : A → ZMod 3} (hc : ProperAlong s c) : Nonempty (Winding s)
theorem Cert.isEmpty_winding (c : Cert) (h : c.check = true) : IsEmpty (Winding c.gen)
```

**Spec validation, done at the skeleton:** the inhabitant `properAlong_one_two` (`x ↦ x mod 3` along `(1, 2)` on `ℤ`) is proved; the
hand-made control `tinyK4` (`S = {1, 2, 3}` in `ℤ`, i.e. `K₄`, five leaves on the relations `(3, 0, −1)`, `(2, −1, 0)`, derived by hand in
§S.3) **passes** `check` under `decide +kernel`, and three plants — a leaf's multipliers negated, a non-relation, a dropped child — each
return `false` under `decide +kernel`; the 36-vector certificate passes (S.0). The headline already type-checks over the `sorry`'d leaves.

### S.3 The obligation pass (every child, strictly smaller, with its route)

**Leaf 1 — `nonempty_winding`.**
- 1a `step_mem`, `step_cast` — **closed.** `step_cast` by generalising the difference to `x : ZMod 3`, `x ≠ 0`, and `decide`.
- 1b `height_append`, `height_cast`, `height_bounds` — **closed**, induction on the word generalising the base point.
- 1c `step_square` — **closed**: both two-step sums in `[2, 4]`, equal mod 3 by `step_cast`, then `ZMod.intCast_eq_intCast_iff'` and `omega`.
- 1d `height_perm` — **closed**, `induction h generalizing a`; the swap case is `step_square` after `add_right_comm`.
- 1e `wsum_word`, `length_word`, `word_add_perm` — `word_add_perm` by `List.perm_iff_count` (`count j (word v) = v j`); the other two by
  `List.sum_flatMap`/`List.length_flatMap` and `Finset.sum` over `List.finRange` (`Fin.sum_univ_eq_sum_range` or `List.sum_ofFn`).
- 1f `wind_shift` (one generator first: `height (a + s i) L = height a L + step (a + wsum L) i − step a i` from `height_perm` on
  `i :: L ~ L ++ [i]` and `height_append`; the two words' `wsum` agree, so the step terms cancel; then induction on `l`), `wind_add_diag`
  (`word (u + t) ~ word u ++ word t`, `height_append`, equal `wsum`), `wind_add` (the same plus `wind_shift` with `l = word u`), `wind_cast`
  (`height_cast` twice), `boxMin_le_wind` (`height_bounds` twice, `length_word`, and per coordinate `(r⁺ : ℤ) − 2r⁻ = min r (2r)` by `omega`).
- 1g `nonempty_winding` — for `r ∈ ker`, `wsum (word r⁺) = wsum (word r⁻)` (from `Σ r_j • s_j = 0` and `Int.toNat_sub_toNat_neg`);
  `W r := wind 0 r⁺ r⁻ / 3`, exact by `wind_cast`; additivity from `wind_add` and `wind_add_diag` with `t = r⁺ + r'⁺ − (r + r')⁺`
  (coordinatewise `a⁺ + b⁺ − (a+b)⁺ = a⁻ + b⁻ − (a+b)⁻ ≥ 0`); the bound from `boxMin_le_wind`. `nonempty_winding_of_colorable`: a
  colouring of `addCayley (Set.range s)` with `s j ≠ 0` is `ProperAlong` via `addCayley_adj`.

**Leaf 2 — `Cert.isEmpty_winding`.**
- 2a list–vector bridges: `vecOf l := fun j => l.getD j 0` on `Fin m`; `vecOf (addL l l') = vecOf l + vecOf l'` (no length hypothesis —
  why `addL` pads); `vecOf (smulL k l) = k • vecOf l`; `boxMin (vecOf q) = boxMinL q` when `q.length ≤ m`; the length facts
  (`addL`, `smulL` preserve `≤ m`).
- 2b each checked relation is in the kernel: `(lincomb r units).all (· == 0)` and `r.length ≤ units.length` give
  `relMap c.gen (vecOf r) = 0`, reading `c.gen j k = (units.getD j []).getD k 0`.
- 2c the path invariant `Good W path`: every `con` has `vecOf con.coef ∈ ker` and holds (`W = rhs` if `isEq`, `≤` otherwise).
- 2d coverage: for `t = W r`, some child of `childCons r lo hi` holds (`t ≤ lo − 1`; `t = lo + i` via `eqRun`; `t ≥ hi + 1` via `−r`).
- 2e the leaf: `leafOk path mults` and `Good W path` give `boxMin Q ≤ 3·W(Q) ≤ 3P < boxMinL Q = boxMin Q` — false.
- 2f the walk: **mutual structural recursion on the nested `Tree`** (theorems `checkTree_sound` / `checkKids_sound` mirroring `checkTree` /
  `checkKids`; Lean 4.32 accepts nested structural recursion in theorems), `checkKids` pairing each child with its constraint.
  **The one real risk of the milestone** — de-risked at stage 3: a mutual pair of theorems by nested structural recursion on this `Tree`
  elaborates (scratch test, not committed); the fallback is `Tree.rec` with an explicit `motive_2` for `List Tree`.

**Leaf 3.** `iota` additive (`Complex.ext`, `push_cast`, `ring`); `iota_mem` (`sqrt_mem_fieldOfRadicands`, subfield closure under the
integer operations and division by 420); `norm_iota` (`Chain.norm_eq_one_of_sq`, `Real.sq_sqrt`, `linear_combination` of the two integer
identities cast to `ℝ`); `cert167` emitted by `tools/j52_intcert.py --emit-lean` (renamed from its scratch `cert167Data`), `cert167_units`
and `cert167_check` by `decide +kernel` (measured, S.0); `properAlong_of_colorable`: `col ⟨iota a, iota_mem a⟩`, with `iota (a + gen j) −
iota a = iota (gen j)` at distance 1 because `unitOk` holds for the listed vector (`List.all_eq_true`, and `gen j` agrees with the list on
coordinates 0–3).

**Leaf 4.** Written; type-checks over the leaves (`add_one_le_chromaticNumber_iff_not_colorable`).

### S.4 Alternatives named and declined

- **T41's four-case hand proof, stated directly** (the brief's other option): it works in `θ`-space (`μ₁ = c0 + 5k + δ₁`, coordinate bounds),
  so it needs the full criterion — the real point, descent to `Λ` and torsion-freeness — which the checker route does not. Declined.
- **The family theorem** (row 82, FS81-T5): `167 ≡ 11 (mod 12)`, so it covers this field; it needs FS81-T2's inverse limit and C1(5)'s
  cell list in the kernel. It is the stub's next target; this milestone's leaf 1 is its first input. Declined here.
- **A chain route** (row 103): needs a three-colour forcer; ℚ(√167) has no triangle (no √3, G57), so no rhombus. Not available.
- **The finite-box route** (the stub's "option to price"): unnecessary — the winding form needs no limit at all.

### S.5 Second instance, if time allows

ℚ(√47)'s 2,997-node tree (FS73-T26): **check its format first** — if it is V2's relation-branching format the same checker applies with a new
`iota` (d = 47); if it is a `θ`-space tree (Coxeter's `certcheck.py` format) it needs a different checker and is out of this milestone.
Not checked here (`data/fs73/` is read-only and the question is J52K's first step of that phase).

### Would have searched here (§S)

- None. The certificate was re-checked, transformed exactly (integer scaling per leaf) and emitted; no new certificate was produced.

## Stage 4 — SAVED

## §P — registered predictions (before J52K runs; both outcomes of each are reachable)

| id | claim | probability | the informative outcome | the uninformative one, and why it is reachable |
|---|---|---|---|---|
| P-elem | leaf 1 closes with no analysis: no Følner sets, compactness, Bolzano–Weierstrass, Farkas lemma, descent or torsion-freeness — only `List.Perm`, `ZMod 3`, `omega`, `Finset` sums (1.3) | 0.90 | an analytic lemma is needed after all — 1.3 skipped a step (J50's hunch `leaf-one-is-elementary`'s falsifier, sharpened) | met — reachable if the additivity or decomposition step in S.3 1f–1g fails |
| P-tree | the nested-`Tree` soundness closes by mutual structural recursion, without the `Tree.rec` fallback | 0.80 | the fallback is needed (the recursion is accepted but the proof's IH shape fights it) | met |
| P-price | J52K lands the headline sorry-free, gate green, within 2.5 hours of wall clock | 0.70 | it takes longer — which leaf, named, is the finding | met |
| P-check | J52K's `cert_check` in the real module reproduces §S.0's 19.4 CPU s within ±25 % and stays under 8 GB | 0.85 | a different cost in the module (elaboration of the literal, or the build's options) | met |
| P-47fmt | ℚ(√47)'s 2,997-node tree (FS73-T26) is **not** in V2's relation-branching format (653 KB for 2,997 nodes reads like a `θ`-space tree) | 0.60 | it is in V2's format, and ℚ(√47)'s `≥ 4` becomes a one-line instance | it is not, and ℚ(√47) needs another checker |
| P-60 | the 60-vector certificate (30,344 leaves, 29× the leaves) checks in one module inside a 60 GB slot | 0.40 | it does — the checker scales as a control | memory or time forces a split (the kernel cost model: literal size) |

**Measured before registration, not a prediction:** the 1,050-leaf check passes under `decide +kernel` in 19.4 CPU s and 6.04 GB (§S.0); leaf
1's children 1a–1d closed on the first elaboration (§S.0). J50's hunch `leaf-one-is-elementary` is **supported and sharpened** by S.0 and 1.3: its
claim needed "a height on ℕ^m … box averages and Bolzano–Weierstrass"; the obligation pass removes the averages and the compactness too. Its
falsifier did not fire; the hunch's status moves from open to supported (one mind; J52K's stage 2 is the test).

## §M — the modeling passes (each freshly invoked with the Skill tool, in order domain → obligation → experience)

**Domain (`debruijn-domain-modeling`).**
- *The cut:* the relation lattice, the winding, and step-properness are intrinsic; the dimension 4, the denominator 420, the span `Λ`, injectivity
  of `iota` and torsion-freeness are incidental to the ⟹ direction and are gone from the statements (the ambient group is `ℕ → ℤ`, read with
  zero padding, so certificates of any dimension share one type).
- *Placement:* `Winding` bundles its functional with its bound (they never travel apart); `ProperAlong` is a `Prop` beside the colouring;
  `Cert.check` is a `Bool` whose only `Prop` face is the soundness theorem, so no drifting `Bool`/`Prop` pair.
- *Ugliness read:* the `{c}` re-binding in the lift lemmas is deliberate (the section's `c` is explicit for the definitions; a lemma needing
  properness takes `c` from `hc`); the balanced-pair hypothesis `wsum (word u) = wsum (word v)` threaded through four lemmas is the relation
  condition in the form the proofs consume, kept.
- *The next lemma for free:* the stub's next leaf (S1 over number fields, FS81-T2) needs the real point `x`; it states in this vocabulary as
  `Winding s → ∃ x ∈ [1/3, 2/3]^m, ∀ r ∈ ker, r·x ∈ ℤ` (finite LP duality from `minRise_le`), a separate lemma with no restatement of anything
  here. The model passes.

**Obligation (`debruijn-obligation-modeling`).**
- *Additivity, strengthened:* instead of constructing the common part `t` of two decompositions, a lemma `wind_eq_of_sub_eq` (balanced pairs with
  the same integer difference have the same winding: `u + v' = u' + v`, then `wind_add_diag` twice) makes `map_add` two lines.
- *Divisibility:* state `3 * W r = wind …` once; every downstream arithmetic step is then `omega`.
- *The walk:* `checkKids_sound` carries "some constraint in the remaining list holds" (an existential, not an index), so the nested recursion is
  structural and coverage is a separate lemma about `childCons`.
- *The leaf:* one induction over the multiplier list with a tupled conclusion (`Q` in the kernel ∧ `Q.length ≤ m` ∧ `W.ext Q ≤ P`) — the
  accumulator's type is the invariant.
- *Prove / test / assume:* prove the three reusable theorems and the headline; test `tinyK4` and its plants, the inhabitant, a plant on the real
  certificate; assume nothing beyond the standard three axioms.
- *Mutation audit (in J52K's brief):* delete `hs` from `nonempty_winding_of_colorable` and the sign guard from `leafOk`; each proof must break.

**Experience (`debruijn-experience-modeling`).**
- *Renamed* `boxMin` → `minRise` (with `minRise_le`, `minRise_le_wind`, `minRiseL`): the value is `|r⁺| − 2|r⁻|`, three times the box minimum,
  and the old name needed its docstring to say so.
- *Generalised the transfer* to any `(d, D)` and any real field holding `√d`: `ThetaPlane.iota d D`, `unitOk d D`, `norm_iota`,
  `properAlong_of_colorable`, and the consumer **`ThetaPlane.four_le_chromaticNumber_of_cert`** — the next consumers (ℚ(√47)'s tree if in
  format, the 60-vector control, FS-60's thirteen quadratic witnesses) are one line each, and the headline is itself one line.
- *The headline's name* is the stub's (`four_le_chromaticNumber_planeOver_sqrt167`), kept though its siblings spell the radicand in words
  (`…_eleven`, `…_two_three`): the stub fixed it and the brief quotes it; no alias minted.
- *Docstrings* state what is *not* built (no finite graph, no `θ`), so a reader does not go looking for it.

## §X — would have searched here

- None. Every exact computation checked or transformed the existing certificate (the frozen checker re-run; the integer scaling; the kernel check
  of the emitted literal); nothing was searched and no new certificate was produced. The one move declined: re-running V2's finder for a smaller
  60-vector certificate as the scaling control — the existing 30,344-leaf one is the control (P-60).

## Theorems this phase proved

- **The winding form of the criterion's ⟹ direction** (1.3): a colouring of an abelian group proper along `s` carries an additive `W` on
  `ker(r ↦ Σ r_j • s_j)` with `Σ_j min(r_j, 2r_j) ≤ 3W(r)`; and a V2 relation-branching certificate with integer multipliers leaves no such `W`.
  [hand, one mind; its first seven lemmas (children 1a–1d) kernel-checked in the skeleton, not yet in `Proofs/`] — `plans/FS75-kernel-167.md`
  §1.3, §S.3; `data/fs75/j52/skeleton/ThreeColourKernel.lean`. It is FS73-T42's steps 1–3 without its averaging, no novelty claimed.
- **T41's certificate in integer form passes the skeleton's checker in the kernel** [kernel, in a scratch module — not committed as a module; the
  module is J52K's] — 19.4 CPU s, §S.0; `tools/j52_intcert.py` (exact mirror, six plants each refused for its own reason, restore verified).
- **`tinyK4`**: `S = {1, 2, 3}` in `ℤ` has no winding, by a five-leaf certificate [hand; its `check` kernel-checked in the skeleton] — §S.2.

## Edits proposed for the front-page lane (not made here)

- `plans/STUB-three-colour-criterion-kernel.md`: under "Shape", item 1 — the kernel needs only the winding form; averages and compactness are
  needed for the full criterion (FS81-T2's route), not for any relation-branching certificate. Its status: "open; J52K running" once launched.
- `plans/FRONTIER-STUBS.md` row FS-75: the same one line.
- `BIBLIOGRAPHY.md`: nothing new.

## §R-close — FS-75's minimal instance, closed (crunch job J54, de Bruijn, Opus 5.5, 2026-09-26)

*WORKFLOW step 9 for the milestone "FS-75's minimal instance: `χ(ℚ(√167)²) ≥ 4` in the kernel", from
`data/crunch-2026-09-25/briefs/J54-FS75-close.md` (templates: J41's brief and M2's §R-close, `plans/M2-kernel-lane.md`; with
`STANDING-RULES.md`). The inventory is `plans/FS75-close-inventory.md`; the derivation file (kernel register and entries) is
`plans/FS75-derivation.md`; working files `data/fs75/j54/`. A kernel milestone: no §IQ. The gate was re-run by the owner at J52K's end
(inventory 31) and is not re-run here (no Lean is built by this job). Drafts for `LEDGER.md`, `CLAUDE.md` and `plans/FRONTIER-STUBS.md`
live here only; a front-page job applies them with FS-100's.*

### Stage 1 — SAVED (the quotation check; the inventory walk opened)

**1a. The quotation check (standing rule 5).** Every quotation and every stated number in J54's brief, against its source:

| # | the brief's text | source | verdict |
|---|---|---|---|
| Q1 | "a kernel leaf priced after a fine obligation pass is priced high" | `CLAUDE.md` line 1548 (on disk, after J05's compression): "**A kernel leaf priced after a fine obligation pass is priced high** (FS-73)" | verbatim (capital A in the source) |
| Q2 | `four_le_chromaticNumber_planeOver_sqrt167`, `four_le_chromaticNumber_planeOver_of_sqrt167_mem` (`…/Instances/SqrtOneSixSeven.lean`) | that file, lines 37 and 43 | present |
| Q3 | `ThreeColour.nonempty_winding`, `ThetaCert.Cert.isEmpty_winding`, `ThetaPlane.four_le_chromaticNumber_of_cert` | `ThreeColour.lean:257`, `ThetaCert.lean:336`, `ThetaPlane.lean:83` | present |
| Q4 | "`Sqrt167.cert_check` by `decide +kernel` in 12.22 CPU s at 5.49 GiB" | `plans/FS75-K-kernel-167.md` Stage 4 table: "**12.22 s** \| 5.49 GiB (5,753,076 KB)" | matches (instance module; the literal module is a further 7.12 s, 2.09 GiB) |
| Q5 | "the job took about 45 minutes against a planned 4.5 hours" | K record §5.5 P-price: "23:46 to 00:30, about 45 minutes to a green gate"; plan §S.0: "**Total ≈ 4.5 h at plan rates**" | matches; by commit times the launch (`147412fe`, 23:46) to the report (`5e4c22a4`, 00:33) is 47 minutes |
| Q6 | "both audited hypotheses shown necessary (J52K record §5.1)" | K record §5.1: "**Both hypotheses are necessary, not merely used**" | matches |
| Q7 | "`Σ_j min(r_j, 2r_j) ≤ 3W(r)`" | K record, "Theorems this phase proved": "`Σ_j min(r_j, 2r_j) ≤ 3W(r)`" | verbatim |
| Q8 | "FS-100's close took 116–118"; "FS-100's drafts add about 2,400 to 283,904" | `data/fs100/j53/front-page-drafts.out`: "rows 116–118 … (last number 118)", "CLAUDE.md: net +2357 bytes"; `wc -c CLAUDE.md` = 283,904 | matches |
| Q9 | "J52's 16 bears" | plan §G.4 item 5: "of the 16 grokking bears" | matches (grokkings only; rows 7 + § B 4, method rules 53 are separate) |
| Q10 | "It is red now on the 15 FS100 ids" | `python3 tools/fs71_ledger_b_check.py --strict`, exit 1: "RESULT: FAIL (15)", all 15 lines FS100 | matches |
| Q11 | "`tools/j52_intcert.py` needs `(d, D)` parameters first" | K record §5.4: "it is hard-wired to `d = 167`, `D = 420`" | matches |
| Q12 | "ℚ(√47)'s tree is a `θ`-space tree, not V2's relation-branching format" | K record §5.4 | matches |
| Q13 | "The owner re-ran the gate at the milestone's end (build, axioms, vacuity, architecture)" | inventory row 31 | matches |
| Q14 | J52's §P ids "P-elem, P-tree, P-price, P-check, P-47fmt, P-60"; J50's hunch `leaf-one-is-elementary` | plan §P; `plans/POROS-2026-09-26-next-two-milestones.md` lines 217–223 | all present |
| Q15 | "M2's rows 103–107 are the precedent for kernel ports" | `LEDGER.md` rows 103–107 | present |

No quotation fails.

**1b. The inventory walk.** `plans/FS75-close-inventory.md` held rows 1–33 at launch. J52K's report (`data/crunch-2026-09-25/reports/J52K.md`)
came after the last row; its eleven INVENTORY lines and two HELD decisions are folded in as rows 34–46, and this close's own findings as rows
47–49 (a correction owed to `CLAUDE.md` § The gate's vacuity counts, read from the owner's gate log; the ban measurement; the prior-art gate).
Each row is ticked at the stage that closes it; stage 6 is the final walk.

**Would have searched here (stage 1):** none.
