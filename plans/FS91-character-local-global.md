# FS-91 (crunch milestone M1) — the character local–global theorem, and band rigidity to nine colours

*The plan of milestone M1 of the 2026-09-25 crunch, opened on the stub `plans/STUB-band-rigidity-six.md` (FS-91). Written by crunch job
J03 (de Bruijn, Opus 5.5, the milestone's planner) under the brief `data/crunch-2026-09-25/briefs/J03-M1-reframe.md` and
`data/crunch-2026-09-25/briefs/STANDING-RULES.md`. WORKFLOW 2.0 steps 3–6 in one job: §G (3.1), §PA (3.2), §IQ (3.3), §S (4), §P, §M (6),
§X (the would-have-searched log). The close inventory is `plans/FS91-close-inventory.md` (the clerk opens it).*

**Fences.** This file carries routes. It is fenced from J09 (blind, stage 0) and from every verifier (J10, J11, J13) until that
verifier's verdicts are committed. §P.basis is also fenced from J08, so that J08's level-one derivation is independent of the planner's
hand check.

## Stage 1 — SAVED (the quotation check, §G.1)

### Q. The quotation check (standing rule 5): every quotation in the J03 brief against its source

| # | the brief's quotation | source | result |
|---|---|---|---|
| Q1 | "A character `k`-colouring of `F²` forces a `k`-colourable residue target" | `plans/POROS-2026-09-25-crunch-plan.md` line 39 | **verbatim** |
| Q2 | "at k = 4, 5 now, and to k ≤ 9 if PA-B3 survives its blind verifier" | same, line 39: "for `k = 4, 5` now and to `k ≤ 9` if PA-B3 holds." | **not verbatim**: "if PA-B3 holds" became "if PA-B3 survives its blind verifier". The meaning is kept and made stricter; logged as a brief slip |
| Q3 | "The product step is the Tardif reading's PA-T4, or a direct sumset argument; the archimedean circle is the new factor." | same, lines 41–42: "Its product step is the Tardif reading's PA-T4 (a four-colourable product of residue targets has a four-colourable factor), or a direct sumset argument. The archimedean circle is the new factor." | **not verbatim**: the parenthesis restating PA-T4 was dropped and two sentences joined; meaning kept |
| Q4 | "It turns rows 96–97's per-field corollaries into one class theorem." | same, line 43 | **verbatim**; the source continues "It sharpens G64: six (and any falsifier) can hide only in a non-character colouring." — carried into §IQ and J07's brief |
| Q5 | "Brief them as complete enumerations with the derivation that fixes the set, never as 'try orders until one works'." | same, line 130: "D-six's character enumeration at 23, 43 and D-one-prime's torsion lists: in by §1.7, briefed as complete enumerations fixed by a derivation, and logged." | **not verbatim, and partly not in the source**: "never as 'try orders until one works'" is not in the advisor's record; the nearest text is `STANDING-RULES.md` rule 3 ("\"Try cases until one works\" is out"). Substance agrees with both sources; logged as a brief slip (a paraphrase inside quotation marks — FS-86's hazard) |
| Q6 | the stub's question 2 figure "`α(Γ₂₃) ≤ 97` gives ratio 0.183 > 1/6" | `plans/STUB-band-rigidity-six.md` question 2; `LEDGER.md` row 75 | **agrees**: 97/529 = 0.1834 |
| Q7 | question 3's "U3 (`RS₄({p})` false at every single prime `p ≡ 1 (mod 4)`, proved at 5 only)" | the stub, question 3; `plans/FS89-derivation.md` §10 | **agrees** (unquoted in the brief) |

**Freshness of the house rules.** `CLAUDE.md` on disk is commit `1263d964` (the 300,000-byte budget line), the same text as the copy loaded
at this job's start (its budget sentence ends "with the file at 274,995"), and the tree was clean at start; `LEDGER.md`'s last commit is
`d9f2e9a8`. `LEDGER.md` § A (rows 1–97) was read in full from disk. **§ B was read by its structure and the entries that bear (FS54-T2,
FS73-T22, T40, FS81-T1–T7, FS86-B1-LR, LP, V3, V3ram, dB-Theta, dB-Sv, dB-HDint, dB-HDcert, Cx-C14, CL1), and FS-89's block through its
derivation file, read in full**; the rest of § B (M18–FS-73's lines) was not read line by line — a budget decision recorded for the owner,
since § B indexes theorems whose mechanisms the rows already carry.

### The milestone in the theory's terms (the recognition, one paragraph; §IQ states it formally)

A **character colouring** of a real field's plane is `x ↦ ⌊kθ(x)⌋` for a band character `θ ∈ Θ_k(R_F)`. Row 95 (with the gluing) says
that at `k = 4, 5` every such `θ` is `τ + ψ`, a torsion character plus an archimedean one; a torsion character of the Dedekind ring
`R_F` (G55's prime inversion: `R_F` is the ring of elements integral at every conjugation-stable prime) factors through the finitely many
stable local rings above its order, so `θ` is **a sum of local characters, one per stable place, plus one real-linear term per real
embedding**, and the band condition becomes a statement about a **sum of value sets** on the circle, once the unit vectors are known to
be jointly dense in the local norm-one groups and the archimedean circles (weak approximation on the norm-one torus). Question 1 asks
whether such a sum inside the band forces **one** summand inside the band — then that place's target is `k`-colourable by a character,
and the conjecture holds for character colourings wherever band rigidity holds. Question 2 is that theorem's instance at six colours: a
character six-colouring of ℚ(√167)'s plane exists iff one of its level-one targets (23, 43, 59, …, the ramified 167) carries a band
six-character, a finite question per target about which traces of the circle avoid a short interval. Question 3 is the one-prime side of
the same dynamics (rank one, where row 97 already fails). Questions 4 and 5 run in stage 0 and are consumed only as named hypotheses.

### G.1 The grokkings (every entry G1–G76, fresh from disk; verdict lines per the brief's form)

*Job names: J07 (question 1, the character local–global theorem), J08 (question 2, six at the exposed fields), J12 (question 3, one
prime), J10/J11/J13 their blind verifiers; S0 = the stage-0 jobs J01 (PA-B2/B3), J02 and J09 (FS-82's `k = 3` case).*

- G1 — bears: a wall-standing field has a dyadic target of χ ≤ 4, so the character theorem at `k ≥ 4` is automatic there; content lies in wall-broken fields → J07
- G2 — silent: construction rings; no characters
- G3 — silent: radii of held witnesses
- G4 — silent: shell inventory of five-forcers
- G5 — silent: 1-sum structure of the 1581
- G6 — silent: hexagram containment
- G7 — bears: the type-M relation `1 = 2n − nv − nv̄` supplies `1/3` in FS-82's field and names ℚ(√167)'s `Σ = 42` rotation → S0 (J02/J09)
- G8 — silent: edge-direction words
- G9 — silent: compulsions of held forcers
- G10 — silent: criticality sweeps
- G11 — silent: Moser-free five-forcers
- G12 — silent: coupling conics of detuned copies
- G13 — silent: fans; a gapped character colouring's consequences are row 66's, not asked
- G14 — silent: matching cross edges
- G15 — silent: pigeonhole × kill
- G16 — silent: distance-2 pigeonhole
- G17 — silent: sub-rung carriers
- G18 — silent: no solver composition
- G19 — silent: class sweeps
- G20 — silent: brick colourings
- G21 — bears: J08's level-one list measures its reduction — state the generator's image (every additive character, `q − 1` rotation classes) and run a known positive (23's eight-colour ceiling) → J08
- G22 — silent: about colourings of ℝ², not finite targets
- G23 — silent: cell-family scale
- G24 — silent: integrality gap of cell cores
- G25 — silent: forcer recursion
- G26 — silent: six-gadget targets
- G27 — silent: Galois automorphisms of witnesses
- G28 — silent: fine-tail virtual edges
- G29 — silent: cell family closed
- G30 — bears: derivation-only milestone; failure mode 5 (every structure hypothesis ships an inhabitant) and the discipline ladder (additive combinatorics, then arithmetic of tori) → J07, §PA
- G31 — silent: pair compulsions of held objects
- G32 — silent: two-distance dial
- G33 — silent: descent batches
- G34 — silent: in-field descent
- G35 — bears: dyadic stable places split (no target), ramified (χ ≤ 2) or inert (`U_Q`); the theorem's dyadic case is this trichotomy → J07
- G36 — silent: residue colouring on descent stages
- G37 — silent: endgame shape
- G38 — bears: a torsion band character is an additive colouring into `ℤ/N`; `[Fischer1990]` Ex. 4 (no additive `k < 11` over ℚ(√167)) is a free consistency control → J08
- G39 — silent: critical-set confinement
- G40 — silent: absorption
- G41 — bears: `[Fischer1994]`'s ℤ/4 colouring of K² is a band four-character, local at one dyadic place at level 3 — the dyadic positive control → J07
- G42 — silent: additive rigidity gauge
- G43 — bears: the targets are G43's usable planes plus dyadic `U_Q`; "a composite beats its best prime only through an integrality gap" — the character theorem says characters have no such gap → J07
- G44 — bears: Kloosterman/Weil control of Γ_q's characters; the level-one six-colour question is a quadratic-character sum over a short interval, Weil-bounded for large `q` → J08
- G45 — silent: lifting residue configurations
- G46 — bears: name the objects in their disciplines — sumsets on the circle; weak approximation on norm-one tori; character sums over intervals; circular colourings of Cayley graphs → §PA, J07, J08
- G47 — silent: level-one compulsion law
- G48 — bears: the character theorem is the conjecture for character colourings (every character colouring local at one prime after peeling); registered P-CLG → J07
- G49 — bears: gate in the discipline's words at the opening and at each job's close; zbMATH author listings (Johnson, Fischer, Berend) → §PA
- G50 — bears: `[Zhu2011]` (PA-T4's input) unread; the sumset route avoids it; `[Johnson2000]`, `[Johnson2006]` unobtained → §PA
- G51 — bears: the seventh run's shape — one derivation agent plus a blind verifier on a fixed list, lemma-statement fallback → §S
- G52 — silent: σ-criterion for rotations
- G53 — silent: counting compulsion on arenas
- G54 — bears: the Hoffman ratio gives a free screen — a band `k`-character is a `k`-colouring, so a certified `α < q²/k` refuses it at once (59, 67, 79, 83 at six) → J08
- G55 — bears: prime inversion makes `R_F` the ring integral at every stable prime (Lemma R); a torsion character factors through the stable local rings → J07
- G56 — bears: the window {23, 27, 31, 43, 47}; a band six-character of Γ₂₃ or Γ₄₃ would six-colour a window member whose floor is six — the first exactly six-chromatic finite plane → J08; falsifiable: registered as P-W6
- G57 — silent: clique rule; character sums do not use triangles
- G58 — bears: every band-character colouring is antipodal (`θ(−z) = −θ(z)`, colour involution `j ↦ k−1−j`); J08's positive controls are G58 instances → J08
- G59 — bears: the fractional wall bounds character colourings too (`α ≥ q²/k` for any band `k`-character); the six-colour thresholds per member → J08
- G60 — silent: fractional lower bounds; characters are upper-bound objects
- G61 — bears: three colours break at `1/3 ∈ ℤ[U_F]`; FS-82's residual case is S0's → S0 (J02/J09), consumed as a named hypothesis
- G62 — silent: bilayer grammar; layers enter through G74
- G63 — bears: transcendence is free (`[Fischer1990]` Thm 6), so the theorem is stated for number fields and names the finitely-generated extension as FS-39's gap → J07
- G64 — bears: the theorem sharpens G64 ("six can hide only in a non-character colouring"); J08 decides character six-colourings at ℚ(√167) → J07, J08
- G65 — silent: SAT phase diagram
- G66 — bears: level collapse is the band form of the fibre-share tax; `L` with all levels allowed; FS-68 open, so the theorem's target is stated at "some level" → J07
- G67 — bears: any grokking minted at the close carries its trigger, Do and killing test → close
- G68 — silent: quotient screens for lattice compulsions
- G69 — silent: lattice four-colour rigidity
- G70 — silent: √3-clean colourings
- G71 — bears: from four colours up emptiness of `Θ_k` is one-sided — every M1 statement is about characters only; at three colours every colouring is one → J07, J08 (scope lines)
- G72 — bears: §IQ's structural form, the invariant named (the local value sets) → §IQ
- G73 — silent: cell-local certificate no-gos
- G74 — bears: the layer method and its `5^{−k}` gluing; its reading tested again at bands 1/6–1/9 by J01 → S0; falsifiable: registered as P-G74
- G75 — silent: triangles in four-colour rigidity
- G76 — bears: the frame — closed-set rigidity with the real place rotated; count primes first; one prime is not enough → J07, J12

## Stage 2 — SAVED (§G.2 the rows, §G.3 the method rules, §G.4 what changed)

### G.2 The ledger rows (`LEDGER.md` § A, rows 1–97 by mechanism, fresh from disk)

- R1 — silent: two-circle three-colourability
- R2 — silent: seam identity
- R3 — silent: coverage monotonicity
- R4 — silent: fan ⟺ coverage
- R5 — silent: class-only graphs
- R6 — silent: 120° triangle identity
- R7 — silent: greedy colouring
- R8 — silent: de Grey balanced five-colouring
- R9 — silent: 120° compulsion
- R10 — silent: one-pivot cap
- R11 — silent: strip automaton
- R12 — silent: extension profile
- R13 — silent: negative knowledge of M17–M19
- R14 — silent: pair-gluing classification
- R15 — silent: extension pressure
- R16 — silent: coupled automaton
- R17 — silent: circle intersections
- R18 — silent: near-relation
- R19 — silent: kill mechanism
- R20 — silent: pivot-triangle layer
- R21 — silent: registered statistics
- R22 — silent: ladder pair four-chromatic
- R23 — silent: four-ladder object
- R24 — silent: hexagram
- R25 — silent: field-wall identity
- R26 — silent: de Grey anatomy
- R27 — silent: quadrature law censuses
- R28 — silent: 2-adic kill engine
- R29 — silent: stacking law
- R30 — silent: mechanism hunt
- R31 — silent: Act One carriers
- R32 — silent: six-programme hosts
- R33 — silent: the plane's interval (ℝ², not number-field characters)
- R34 — silent: coset chromatic number of the triangular lattice
- R35 — silent: coarse cells
- R36 — silent: scale non-monotone
- R37 — silent: gap atlas
- R38 — silent: gradient hunt
- R39 — silent: gap atlas kernel side
- R40 — silent: fine tail
- R41 — silent: limit lemma
- R42 — silent: arity floor
- R43 — silent: six-target
- R44 — silent: spindle theorem
- R45 — silent: batch descent, spare colour
- R46 — silent: copy unions
- R47 — silent: M53's witnesses
- R48 — silent: critical sets
- R49 — silent: absorption
- R50 — bears: `[Fischer1990]` Ex. 4 — no additive `k`-colouring with `k < 11` over ℚ(√167); every torsion band character is additive, so a free control → J08
- R51 — silent: additive rigidity
- R52 — bears: the finite-plane bound and its residue-degree condition define the targets the theorem may return → J07
- R53 — bears: the sieve's instances — K(√7)'s usable primes 83 and ≥ 103, de Grey's field 131 and 479 → J08
- R54 — silent: lifts
- R55 — silent: residue obstruction, subsumed
- R56 — bears: `addCayleyMap` and the periodic quotient — a torsion band character is a periodic colouring through a quotient; the kernel consumer if ever ported → J07
- R57 — bears: Theorem A's colouring and its named gap (a number field's stable prime supplies the valuation subring, not proved) — the pullback direction sits at that grade → J07
- R58 — silent: Moser recipe threshold
- R59 — silent: 2-adic law of compulsions
- R60 — silent: plane freedom
- R61 — silent: statement generality
- R62 — silent: overcompression
- R63 — bears: a ramified dyadic place two-colours the plane; the theorem's dyadic case uses it → J07
- R64 — silent: the ρ₆₃ arena
- R65 — silent: dropping Parts's shape
- R66 — silent: fan-gap transport; consequences of gapped character colourings not asked
- R67 — bears: the dyadic tower `P_m`, tight at four colours; the dyadic level bound a band character obeys → J07
- R68 — bears: six refused at 83 by certificate — K(√7)'s first target refuses every band six-character → J08
- R69 — bears: ceilings 8, 7, 8, 8, 10 at 23, 27, 31, 43, 47 by verified periodic colourings — the known positives for J08's enumeration → J08
- R70 — bears: `U_Q` four-colourable for `Q ≤ 32`, `U₆₄` floor six; the dyadic trichotomy → J07 (dyadic case)
- R71 — bears: five refused at 23, so a six-character there pins χ(Γ₂₃) = 6 → J08
- R72 — bears: the 3-adic barrier (FS-82's side) → S0
- R73 — bears: ℚ(√47)'s bracket; row 96's C-47 must fall out of the class theorem → J07 (control)
- R74 — silent: census of finite witnesses
- R75 — bears: `α(Γ₂₃) ≤ 97` (ratio 0.183, no ratio refusal at six); Lemma W warns that level collapse is not a ratio fact → J07, J08
- R76 — silent: FS-70's lattices
- R77 — bears: file every theorem in the derivation file and § B → close
- R78 — silent: de Grey's lattice `F = P`
- R79 — bears: the three-colour criterion (at three colours characters are everything) and χ(ℚ(√167)²) ≥ 4 → S0, J07 (scope)
- R80 — bears: from four colours up no height — every M1 statement is character-only → J07, J08 (scope lines)
- R81 — bears: `L21cc6506` carries lattice band four-characters (a full-dimensional cell) while the field's `Θ₄` is empty — statements must be field-level → J07
- R82 — bears: the field-level slope and FS81-T7's residual case → S0; the `k = 3` form of the theorem → J07
- R83 — silent: census certificates
- R84 — silent: ℚ(√47)'s survivors
- R85 — silent: de Grey's lattice derived
- R86 — silent: triangle-free rigidity
- R87 — silent: second moments on `Λ`
- R88 — bears: Lemma R (scope: fails at a ramified dyadic place, CL2) and Lemma P (ramified odd towers) — named hypotheses of J07's statement → J07
- R89 — bears: K's four-colourings are local at one dyadic place per coset, `[Fischer1994]`'s at level 3 — the theorem must allow either place → J07 (control)
- R90 — silent: the rigid local plane
- R91 — bears: HD1-fin and dB-Sv — a band character's split part vanishes, so only stable places carry torsion → J07
- R92 — bears: the window count fails at five colours at the real place (`m₁ ≥ 0.229`); characters escape by archimedean averaging — the sumset peeling is the character analogue → J07
- R93 — silent: dyadic tower tightness
- R94 — bears: C9 — ℚ(√11)'s non-periodic band four-character, Γ₇ plus an archimedean term; the theorem must return Γ₇ → J07 (control)
- R95 — bears: the input — RQ₄, RQ₅, the gluing, `T₁₆₈` at four → J07
- R96 — bears: the three per-field corollaries the class theorem must reproduce → J07 (control)
- R97 — bears: one prime — U3, `MS₄({5})`, U5 → J12

### G.3 The method rules (`CLAUDE.md` § Grokkings [method] entries are G.1's G21, G30, G46, G49, G50, G67, G72; below, every other rule)

- M-deleg (§ Delegation) — bears: the no-children rule, with its reason, in every brief → J07, J08, J10–J13
- M-evid-1 (standard of evidence: no native evaluation) — silent: no kernel purchase
- M-evid-2 (certificate plus checker, never the search) — bears: J08's refusals ship as a derivation plus a tiny exact checker → J08
- M-evid-3 (re-derivable witness) — bears: any band character found is given by a formula (`c`, `q`, `k`) → J08
- M-evid-4 (read the statement aloud) — bears: every headline read against "characters only, never χ" → J07, J08
- M-evid-5 (report the hunt) — bears: a null at 23 and 43 is a result → J08
- M-evid-6 (write the reviewer's certificate early) — bears: ask what a distrustful reader must check (the reduction `c ↦ V_c`) while deriving → J08
- M-evid-7 (order a verification by marginal value) — bears: verifiers take the load-bearing lemma first → J10, J11
- M-compute (what compute helps; a GPU is not a SAT accelerator) — silent
- M-price (kernel leaves priced after an obligation pass) — silent: no Lean this milestone
- M-shape (the proof's shape: reduction plus two computations) — silent
- M-tools (nothing in `tools/` is trusted) — bears: the enumeration tool checks a derived reduction; the derivation carries the claim → J08, J12
- M-trust (trust ledger, `native_decide`) — silent
- M-l4c (`lean4checker` a publication gate) — silent
- M-tc (toolchain, dev env) — silent
- M-sat (cadical, portfolio) — silent: banned
- M-inst (installed tools: PARI, GAP, sympy) — bears: exact arithmetic of seconds is in → J08, J12
- M-pysat (per-back-end interrupt) — silent
- M-venv (venvs outside `build/`) — silent
- M-sym (break symmetry before any SAT) — silent: no SAT
- M-ban (no finite-witness search to 2026-10-01; the would-have-searched log) — bears: every job's log; J08's and J12's enumerations logged as "at the edge" → all
- M-py (Python 3.14 forkserver) — silent: seconds-long tools
- M-mach (two machines; CPU seconds, minimum of three) — silent
- M-pred (predicted beside measured throughput) — silent
- M-build (`scripts/build.sh` only) — silent: no Lean
- M-lakeenv (`lake env lean` is not the gate) — silent
- M-batch (the batch is the plan; halt on any unexplained crash) — bears: the halt rule → all (standing rule 8)
- M-ram (RAM is the discriminator; `scripts/slot.py`) — bears: tools under 2 GiB and 2 minutes run without a slot → J08, J12
- M-ckpt (PROTECTED: checkpoint and resume) — bears: stages saved and committed → all
- M-kill (PROTECTED: a blocking run is presumed killable) — silent: no long runs
- M-pid (kill by pid, verify by effect) — silent
- M-pipe (a pipe can kill the producer; read a gate's exit status from the gate) — bears: tools' pass/fail read from their exit status → J08, J12
- M-edit (never edit a running script) — silent
- M-gen (generated modules and invalidation) — silent
- M-kcost (the kernel's cost model) — silent
- M-grep (ugrep alternation, `rg -uu`, a failed `exact?`) — silent: the planner's greps are single literals
- M-vac (vacuity; every structure hypothesis ships an inhabitant) — bears: J07's theorem ships inhabitants (Fischer on K, C9 on ℚ(√11), `θ₂`) → J07
- M-gatelog (gates keep what they computed) — silent
- M-eval (an `#eval` per definition) — silent
- M-neg (make the gate fail and watch it fail) — bears: every tool plants a fault → J08, J12
- M-absent (a positive signal for the thing that did not happen) — bears: the enumeration writes its result file on a null too → J08, J12
- M-waiter (a waiter's condition false at arming) — silent
- M-reach (state the uninformative outcome and confirm it reachable) — bears: every §P prediction names both outcomes, each reachable → §P
- M-predecide (settle the response to a red gate before it is yours) — bears: verifiers' fixed lists written now → J10, J11, J13
- M-swap (a sharp instrument loses coverage) — silent
- M-units (a number travels with what it measures) — bears: "no band six-character" is not "not six-colourable" → J08
- M-onething (two numbers differ in one thing) — bears: compare 23 at bands 1/6, 1/7, 1/8 with only `k` varying → J08
- M-both (both outcomes reachable; mis-specification evidence predates the result) — bears → §P
- M-wrongred (a red control needs a named wrong-reason red; plant beside a faithful stub) — bears → J08, J12 tools
- M-halves (a measured half and a derived half fail oppositely) — bears: J08's refusals come from a derived law (`V_c`), so check the law against a direct circle enumeration at one `q` → J08
- M-shipped (a check reads the shipped value) — bears: the band endpoints read from one definition → J08
- M-format (formatting is part of the check) — silent
- M-twoside (two-sided plant bounds) — silent
- M-replay (replay policies) — silent
- M-failcost (cost from a failing run) — silent
- M-caveat (a caveat written and stepped over) — bears: J07's summary re-read against its scope line → J07
- M-params (count the generator's free parameters) — bears: characters of `𝔽_{q²}` are 2-parameter, rotation leaves one (`N(a)`); the count justifies `q − 1` classes → J08
- M-second (a true explanation stops the search for a second) — bears: a target refusing six still needs its level collapse checked → J07, J08
- M-restore (a mutation harness verifies its restore) — silent
- M-const (mutate the constant) — bears: plant a mutated band constant → J08
- M-archive (archived checkers binding by name) — silent
- M-param1st (enumerate the parameter first) — bears: enumerate `c ∈ 𝔽_q^×`, never colourings met by chance → J08
- M-shape1 (a positive control proves only shapes the generator represents) — bears: the eight-colour control at 23 lies in the generator's image → J08
- M-onesided (a one-sided filter's inapplicability) — silent
- M-scars (plant faults routinely) — bears: covered by M-neg → J08, J12

### G.4 What the re-grokking changed in the plan

1. **Route added (primary): the direct sumset — "peeling" — route to question 1**, from G43's integrality-gap sentence, R92's window count at
   the real place and S0A-7's archimedean averaging read together: the archimedean circles are summands whose value sets contain 0, the
   torsion part splits over stable places (G55, R88), and an interval centred at ½ has the property that a sum of symmetric sets inside it
   keeps a summand inside it (§IQ). PA-T4 with `[Zhu2011]` (unread, G50) is kept as the alternative, not the route.
2. **Controls added to J07**, each with a known answer: `[Fischer1994]` on K (dyadic, level 3; G41, R89), C9 on ℚ(√11) (Γ₇ plus an
   archimedean term; R94), `θ₂` on a wall-standing field (G1, R63), and the reproduction of row 96's HD1, C-47, C-167 (R96).
3. **J08 made a derivation plus a fixed finite list**: the free screens first (six refused at 59, 67, 79, 83 by certificate and from 71 by
   spectrum at level one: G54, R68, R69), then the level-one reduction at 23 and 43 with `q − 1` classes, a known positive (the
   eight-colour ceilings, R69) and a free control (R50). Band 1/7 added beside 1/6 (the same enumeration; M-onething), and the sharp
   quantity named: the character chromatic number `χ_char` of each target and of ℚ(√167)'s plane.
4. **Level collapse at band `1/k` stated as a sub-claim with its arithmetic** (a sweep of step `1/p` meets `(−1/k, 1/k)` iff `p > k/2`),
   never assumed from a ratio (R75's Lemma W; G66); the theorem's conclusion is "a target at some level", level one where the collapse is
   proved.
5. **Lemma R's scope named as a hypothesis** (R88, CL2), with the ramified-dyadic case split off (L = 2; R63).
6. **Nothing removed.** J12 stays as stubbed, its torsion-order list fixed by a derivation first (U5, R97). FS-83's `k ≥ 6` remainder is J08
   plus J01.

## Stage 3 — SAVED (§PA, the prior-art gate)

*Time-boxed; zbMATH Open API for discovery (WORKFLOW 3.2 item 8). Queries and raw output: `data/fs91/j03/queries-{1..4}.txt`,
`pa-queries-{1..4}.txt`, `pa-johnson-listing.txt`, `pa-reviews-1.txt`; tools `data/fs91/j03/zb.py`, `zbrev.py`. **The API returned
HTTP 502 or timed out on 13 of 41 requests** (logged in the output files); a 404 is its empty result. Every negative below measures its
query's words (G21).*

### PA.1 The objects named in their disciplines' words

- **A character colouring is a circular colouring that is a group homomorphism.** `x ↦ kθ(x)` maps `F²` to `ℝ/kℤ` with every edge moved
  by at least 1, so it is a circular `k`-colouring; the least `k` with a band character is `⌈1/κ(U_F)⌉`, where
  `κ(U) = sup_θ min_{u∈U} ‖θ(u)‖` over characters of `ℤ[U]` — the **lonely-runner / view-obstruction parameter** of the set `U` in the
  character-theory form used for distance graphs (row 79 already reads rank 1 this way: `G(ℤ, D)` is 3-colourable iff `κ(D) ≥ 1/3`).
  Discipline: circular colouring of Cayley and distance graphs (Vince; Zhu; Liu), diophantine approximation (Cusick, Wills, Chen).
- **The class theorem is a local–global statement about `κ`**: `κ(U_F)` against the `κ` of each residue target's norm-one circle, the
  product step being a **sumset of symmetric sets inside an interval centred at ½** on the circle group — additive combinatorics — and the
  joint surjectivity being **weak approximation on the norm-one torus** `R¹_{F(i)/F}𝔾_m`, a rational variety (arithmetic of algebraic tori).
- **The per-target question is a quadratic-character sum over a short interval.** For `q` prime and `a ∈ 𝔽_{q²}^×` with `N(a) = c`, the
  values `Tr(az)` on `z ∈ μ_{q+1}` are exactly `V_c = {t ∈ 𝔽_q : t² − 4c is a non-square or 0}` (a line `Tr(ax) = t` meets the circle
  iff `X² − tX + c` has roots of norm `c` — the planner's derivation, to be re-derived by J08); a band `k`-character exists iff some `c`
  makes `t² − 4c` a non-zero square for every `|t| < q/k`. Discipline: runs of quadratic residues of a polynomial, Burgess's bounds for
  characters of polynomials, Weil.

### PA.2 Queries and what they returned (hits as returned; review or author summary marked)

| query (zbMATH) | hits | what bears |
|---|---|---|
| `ab:"circular chromatic number" & ab:"unit distance"` | 2 | **DeVos–Ebrahimi–Ghebleh, *Circular coloring the plane*, SIAM J. Discrete Math. 2007 (Zbl 1140.05303; author summary): `χ_c(ℝ²) ≥ 4`.** Character colourings are circular colourings, so `χ_c ≤ χ_char`; not about characters or fields. Kamiński–Medvedev–Milanič, plane-width (off the question) |
| `ab:"distance graph" & ab:"circular chromatic number"` | 9 | Zhu 2002, 2003; Liu–Zhu 2005; **Liu, *From rainbow to the lonely runner* (survey, 2008)**; Chang–Liu–Zhu 1999: the `κ` literature for `G(ℤ, D)` — rank 1, no number fields |
| `ab:"chromatic number" & ab:"p-adic"` | 3 | **Kang–Maharaj, *Distance graphs from p-adic norms*, Integers 2010 (Zbl 1213.05061; review): upper bounds on `χ(G(ℤ, D))` from `p`-adic divisibility of `D`** — a one-place residue colouring of a distance graph, the rank-1 shadow of the pullback direction; Bardestani–Mallahi-Karai 2020 (held as `[BardestaniMallahiKarai2017]`'s journal form) |
| `ti:"chromatic number" & ab:"rational points"` | 2 | Zaks 1992, Chilakamarri 1990 (rational spaces; off the question) |
| `au:"Fischer, Klaus G."` | 27 | the three held papers (1990, 1990b, 1994); nothing further on colouring |
| `au:"Johnson, Peter D." & cc:05C15` | 52 | **Johnson, *Problems posed in or arising from "Colorings of metric spaces": status report* (2000; Zbl 0974.05029; review): problem (1) is "the chromatic number … of `(X,1)`, when `X` is a finite algebraic extension of `Q²`"** — the question the class theorem answers for characters; **Johnson, *Euclidean distance graphs on the rational points* (2011 survey, Zbl 1243.05082)**; *Product colorings* (Geombinatorics 1991, Zbl 0848.05029; review one line: "two related problems on product colorings of the plane") — none held |
| `ab:"quadratic residues" & ab:"consecutive"` | 39 | Burgess 1963 (two papers, incl. *On Dirichlet characters of polynomials*), Buell–Hudson 1984/1986 (runs of residues), Caragiu 1993: the classical tools for J08's per-target question; nothing on norm-one circles |
| `ab:"Hedetniemi" & ab:"circular" & ab:"Cayley"`; `… & ab:"circular chromatic"` | 1; 1 | Hahn–Tardif 1997 (survey), Alishahi–Hajiabolhassan–Meunier 2017 (topological) — off the question |
| `ab:"local-global" & ab:"chromatic number"` | 3 | off the question (tree-depth; SDP gaps; Borel graphs) |
| `ab:"lonely runner" & ab:"distance graph" & ab:"circular chromatic"` | 1 | Liu–Zhu 2005 |
| empty (404): `unit distance & number field & coloring`; `additive coloring & unit distance`; `character & coloring & unit distance`; `unit circle & finite field & chromatic`; `lonely runner & finite field`; `unit distance graph & rational & circular`; `coloring & rational points & quadratic field`; `character sum & short interval & quadratic polynomial`; `quadratic residues & consecutive & polynomial & interval`; `Cayley graph & finite field & circular chromatic`; `sumset & circle & interval & symmetric` | 0 | — |
| unanswered (502 or timeout): `circular chromatic number & Cayley graph`; `circular chromatic number & abelian group`; `finite Euclidean & chromatic number`; `quadratic residue & polynomial & interval`; `view obstruction & chromatic`; `multiplicative subgroup & interval & finite field & avoid`; `lonely runner & chromatic number & Cayley`; `unit distance graph & field & chromatic number, 2000–2026` | — | **not searched**, recorded as a debt for the close's gate |

### PA.3 What the gate found, and what it changes

1. **The question is posed in print** (J02 flagged `[Fischer1990]` §1; the gate adds Johnson's 2000 status report, problem (1), quoting
   Benda–Perles). The class theorem answers it **for character colourings only** — never for `χ` — and says so in every statement.
2. **The discipline is circular colouring / the lonely-runner parameter `κ`**, which gives the milestone its sharp quantity: the
   **character chromatic number** `χ_char(G) = min{k : Θ_k ≠ ∅}` of a field plane and of each residue target, and the theorem
   `χ_char(F²) = min over stable places and levels of χ_char(target)`. J08 computes `χ_char` of Γ₂₃, Γ₄₃ and of ℚ(√167)'s plane.
3. **The per-target bound for large `q` is classical** (Weil, Burgess): J08 cites it, derives the explicit threshold, and enumerates below
   it — a complete list fixed by a derivation (standing rule 3's edge).
4. **Nothing found states the class theorem or the peeling lemma**; the peeling lemma is elementary and is to be treated as folklore-grade
   until a gate on it is answered (the 502 queries above). Kang–Maharaj is the one-place colouring of distance graphs in rank 1 — cited as
   the nearest printed relative.
5. **Debts** (for the close's gate): `[Johnson2000]` (the status report) and `[Johnson2006]` still unread and not held; Johnson 2011's
   survey not held; Liu's 2008 survey not held; DeVos et al. 2007 not held; the eight unanswered queries.

## Stage 4 — SAVED (§IQ, §S, §P; re-aimed at the owner's news of J01, J02 and J03a)

### 0. What M1 decides now (the re-aim; the owner's request 1)

Stage 0 landed the stub's headline. **J01** (blind) verified PA-B2 and PA-B3: band rigidity `RS_k(S)` at every `|S| ≥ 2` and `RQ_k` for
`k ≤ 9` — **consumed here as verified** (the owner's ruling); its all-`k` extension J01-7 (Lemma SW-m) has one reader and is being read
blind by **J03a** — consumed only as the named hypothesis "given J01-7, one reader". **J02** proved FS-82's three statements (S1: the
conjecture at `L ≤ 3` for every real number field; S2: at `L ≤ 4`; S3: `χ(ℚ(α,√7)²) = 4`) — one mind until **J09** (blind) lands, so
consumed as "given J02-T2/T3, one mind". What M1 still decides:
1. **The class theorem** (J07): a character colouring of any real number field's plane comes from one residue target — the conjecture for
   character colourings, at every `k` where band rigidity holds. Nothing in stage 0 proved it; J02-T1 is its `k = 3` torsion case.
2. **The character chromatic number at the exposed fields** (J08): whether Γ₂₃ or Γ₄₃ carries a band six-character (the window's one
   character-level question), `χ_char` of ℚ(√167)'s, K(√7)'s and de Grey's planes, and, last, the explicit band-1/6 torsion list of `Q`
   (N₀'s analogue, which J01 names as missing).
3. **One prime** (J12): U3 at every `p ≡ 1 (mod 4)`, `MS₄({5})`, U5.
4. **FS-82** closes when J09 reports; nothing more is queued on it.

### §IQ. The invariant question (WORKFLOW 3.3)

1. **The existence form.** Is there a real number field `F` and a band character `θ ∈ Θ_k(R_F)` such that no residue target of `F`
   carries a band `k`-character — a character colouring of a field plane local at no prime, i.e. a character falsifier of the
   conjecture? And, at the exposed field: is there a character six-colouring of ℚ(√167)'s plane?
2. **The structural form.** *For a finite family of compact abelian groups `G_v` with symmetric subsets `S_v = −S_v`, and a closed
   symmetric arc `B ⊂ ℝ/ℤ` centred at ½, classify every character `χ = Σ_v χ_v` of `∏ G_v` with `Σ_v χ_v(S_v) ⊆ B`: must some single
   `χ_v(S_v)` lie in `B`, and what may the others contribute?* The arithmetic is stripped to one input — that the unit vectors of `F` are
   jointly dense in the product of the stable local norm-one groups (every level) and the archimedean circles — after which the field
   disappears and the question is about value sets on the circle.
3. **The invariant it forces.** The **value-set profile** `(A_v)_v`, `A_v = χ_v(S_v)`, each symmetric and closed, with the archimedean
   factors' `A_v` intervals `[−|e_v|, |e_v|]` containing 0; its peel order and margins. Per target, the invariant is the trace set on the
   circle, `V_c` (§PA.1), a quadratic-residue pattern. At one prime (J12) the invariant is FS-89's leaf itinerary (the wall set), which at
   rank one need not vanish.
4. **Its route.** Derivation only. The exact computations admitted are complete lists over sets a derivation fixes first: J08's `(q, c)`
   below an explicit Weil threshold, J12's characters of `ℤ[i]/N` for `N` in a derived family.
5. **The open instances it would decide.** At once, for characters: ℚ(√47), ℚ(√143), ℚ(√311), ℚ(√335), ℚ(√3,√5) (`L = 5`: no character
   four-colouring); ℚ(√167) (`χ_char`, the six question); K(√7) and de Grey's field (every target refuses six: no character six-colouring
   given the theorem at six); ℚ(α,√7) (`k = 3`, J02); G64's sentence becomes "six, or any falsifier, hides only in a non-character
   colouring" (the advisor's F2). **The control** the day a new procedure lands: row 96's three corollaries, J02-T1, `[Fischer1994]` on K
   (dyadic, level 3) and C9 on ℚ(√11) (Γ₇ plus an archimedean term) must fall out.

**Is it already answered?** Not found in print (§PA); posed as a question by `[Fischer1990]` §1 and Johnson's 2000 status report (for `χ`).

### §S. The subplan: stages as jobs

| stage | job | kind | decides | deps | size |
|---|---|---|---|---|---|
| S0 | J01 | blind verifier | PA-B2, PA-B3 — **DONE, TRUE** (k ≤ 9); J01-7 proposed | — | — |
| S0 | J03a | blind verifier | J01-7 (Lemma SW-m, all `k`) | — (launched) | 2 h, 250k |
| S0 | J02 / J09 | derivation / blind derivation | FS-82 — J02 **DONE, TRUE** (one mind); J09 running | — | — |
| S1 | **J07** | derivation | the class theorem (statements CLG-a to CLG-g below) | J03 | 3 h, 350k |
| S1 | **J08** | derivation + fixed finite list | six at the exposed fields (SIX-a to SIX-f) | J03 | 3 h, 350k |
| S1 | **J12** | derivation + fixed finite lists | one prime (ONE-a to ONE-c) | J03 | 3 h, 350k |
| S2 | J10, J11, J13 | blind verifiers | J07's, J08's, J12's claims, from fixed lists written now | J07, J08, J12 | 2–2.5 h each |

**Shape** (G51, the seventh run): one derivation agent per question, a blind verifier on a fixed list written before any claim exists,
the lemma-statement phase as the fallback after a blind stall. J07 and J08 are independent and run in parallel; J08 consumes the class
theorem only as a named hypothesis ("given CLG_k, J07, unverified") for SIX-e.

**The target statements** (quoted verbatim by the briefs and the verifiers' lists; objects: FS-89's §0.1 notation, plus these).
*Definitions.* `F` a real number field (a subfield of ℝ of finite degree; other embeddings may be complex), `L = F(i)`, `c` complex
conjugation, `U_F` the unit vectors of `F²` read in `L`, `R_F = ℤ[U_F]`. A **stable place** is a prime `𝔓` of `L` with `c(𝔓) = 𝔓`. The
**residue target at level `m`** is `T_{𝔓,m} = Cay(O_𝔓/𝔓^m, S_{𝔓,m})`, `S_{𝔓,m}` the image of the local norm-one group. A **band
`k`-character** of an abelian Cayley graph `Cay(G, S)` is a homomorphism `λ : G → ℝ/ℤ` with `λ(S) ⊆ B_k`; `χ_char(G, S)` is the least
such `k` (∞ if none); `χ_char(F²)` is the least `k` with `Θ_k(R_F) ≠ ∅`. **`H_k`** is the hypothesis `Θ_k(R_F) ⊆ T + A` for every real
number field `F` (row 95 and the gluing at `k = 4, 5`; PA-B3 with the gluing at `k ≤ 9`, verified by J01; every `k` given J01-7).

**J07 — the class theorem.**
- **CLG_k.** "Let `k ≥ 3` satisfy `H_k`, and let `F` be a real number field. Then `Θ_k(R_F) ≠ ∅` if and only if some stable place `𝔓` of
  `F(i)` and some level `m ≥ 1` have a band `k`-character of `T_{𝔓,m}`. Hence `χ_char(F²) = min_{𝔓,m} χ_char(T_{𝔓,m})`, and a character
  `k`-colouring of `F²` exists only if some residue target of `F` is `k`-colourable."
- **CLG-a (pullback).** "A band `k`-character of `T_{𝔓,m}` composed with `R_F → O_𝔓/𝔓^m` lies in `Θ_k(R_F)`."
- **CLG-b (the peeling lemma).** "Let `k ≥ 2`, `X, Y ⊆ ℝ/ℤ`, `X = −X`, `X + Y ⊆ B_k`. If some `x ∈ X` lies outside `B_k`, then
  `Y ⊆ [1/k + ‖x‖, 1 − 1/k − ‖x‖]`."
- **CLG-c (joint surjectivity).** "For every `N ≥ 1`, the image of `U_F` in `R_F/NR_F` is the product, over the stable places `𝔓 | N`, of
  the images of the local norm-one groups, and it is jointly dense with the real places' unit circles" — or the weaker statement the
  proof needs, named; without `[FS86-B1-LR]`'s Galois scope (J02-L3 proves the reduced level).
- **CLG-d (the archimedean factor).** "If `θ = τ + ψ ∈ Θ_k(R_F)` with `τ` torsion and `ψ` archimedean, then `τ ∈ Θ_k(R_F)`" — for every
  real number field, including those with complex places (J02 §2.8: S0A-7's density step assumes compact archimedean norm-one groups).
- **CLG-e (level collapse).** "At a stable place of residue characteristic `p > k/2`, every band `k`-character of `T_{𝔓,m}` factors
  through `T_{𝔓,1}`" — and what holds at dyadic places and at `p ≤ k/2` (S0A-4 did bands 1/4, 1/5).
- **CLG-f (controls).** `[Fischer1994]`'s ℤ/4 colouring of K (row 89) returns a dyadic target at level 3; row 94's C9 on ℚ(√11) returns Γ₇;
  row 96's HD1, C-47, C-167 and J02-T1 fall out.
- **CLG-g (the conjecture for characters).** "Under `H_k`, for every real number field `F`: a character `k`-colouring of `F²` exists only if
  `L(F) ≤ k`, except possibly through a place of residue characteristic `p ≤ k/2` above level one" — with the exception made explicit.

**J08 — six at the exposed fields** (characters only; every statement read aloud against "never `χ`").
- **SIX-a (the reduction).** "For a prime `q ≡ 3 (mod 4)`, every band `k`-character of `Γ_q = Cay(𝔽_{q²}, μ_{q+1})` is
  `λ_a(x) = Tr_{𝔽_{q²}/𝔽_q}(ax)/q` for some `a ≠ 0`, and `λ_a` is band `k` iff no `t ∈ V_{N(a)}` has `|t| < q/k` (`t` read in
  `(−q/2, q/2)`), where `V_c = {t ∈ 𝔽_q : t² − 4c is a non-square or 0}`."
- **SIX-b (the two window members).** The complete list of `c ∈ 𝔽_q^×` giving band `k`-characters for `q ∈ {23, 43}`, `k ∈ {6, 7, 8}`; hence
  `χ_char(Γ₂₃)` and `χ_char(Γ₄₃)`.
- **SIX-c (every other usable prime).** For `k ∈ {6, 7}`: an explicit `Q_k` from Weil (or Burgess) above which no `Γ_q` has a band
  `k`-character, and the complete list below it.
- **SIX-d (ramified and higher levels).** The ramified place above 167 in ℚ(√167) and higher levels at 23 and 43: band 6- and 7-characters,
  or CLG-e's collapse.
> **Correction owed (2026-09-25 crunch):** see `plans/FS91-S1V-six.md` stages 3–4; carried in `plans/FS91-close-inventory.md` row 110. Not applied here; the close rewrites this entry.

- **SIX-e (the fields).** "Given CLG_6 and CLG_7 (J07, unverified): `Θ₆(R_{ℚ(√167)}) = ∅` iff no target of ℚ(√167) carries a band
  six-character, and `χ_char(ℚ(√167)²) = min` over its targets; the same for K(√7) and de Grey's field `K(√5,√7)`."
- **SIX-f (last, if budget allows).** The band-1/6 torsion characters of `Q` (N₀'s analogue).

**J12 — one prime.**
- **ONE-a (U3).** "For every prime `p ≡ 1 (mod 4)`, `Θ₄(R_{{p}}) ⊄ T + A`."
- **ONE-b (`MS₄({5})`).** Is every `U₅`-minimal closed subset of `Θ₄(R₅)` contained in `T + A`?
- **ONE-c (U5).** Are the orders of band torsion characters of `R_{{p}}` unbounded at one prime — by a derived infinite family, each member
  checked by an exact finite computation; never a list extended in search of a pattern.

**Budgets, stop rules, checkpoints** (every job): stages saved and committed by path; a halt costs one stage; resume from the brief file.
Stop at 350k harness (hand back by 420k), or at a verdict per claim saved.

### §P. Registered predictions (before any stage-1 job runs; both outcomes reachable for each)

**P.1 The milestone's outcome** (exclusive, the highest rung; sum 1):

| id | outcome | p |
|---|---|---|
| O1 | CLG_k proved (J07) and blind-verified (J10) at every `k` (J03a TRUE), controls reproduced, and `χ_char(ℚ(√167)²)` pinned (J08) | 0.30 |
| O2 | CLG_k proved and verified at `k ≤ 9` only (or every `k` without the pin) | 0.25 |
| O3 | CLG proved with a named gap left (totally real `F` only, or CLG-c at nilpotent levels) | 0.22 |
| O4 | J07 GAP at a named step; J08 and J12 land | 0.18 |
| O5 | a counterexample: a band character of some `R_F` with no band target | 0.05 |

**P.2 Side predictions**

| id | statement | p |
|---|---|---|
| P-J03a | J03a finds Lemma SW-m TRUE at every `k ≥ 3` | 0.80 |
| P-W6 | a band six-character exists at level one of Γ₂₃ or Γ₄₃ (it would six-colour a window member of floor six) | 0.15 |
| P-167 | `χ_char(ℚ(√167)²) ≥ 7` (given CLG) | 0.80 |
| P-167-8 | `χ_char(ℚ(√167)²) = 8` exactly (given CLG) | 0.45 |
| P-CM | CLG-d holds for real number fields with complex places | 0.60 |
| P-U3 | ONE-a proved at every `p` | 0.75 |
| P-MS5 | ONE-b answered "no" (a non-`T + A` minimal set exists at one prime) | 0.60 |
| P-U5 | ONE-c answered "unbounded" by a derived infinite family | 0.35 |
| P-log | every M1 job's would-have-searched log non-empty and no search run | 0.85 |

*G74's reading at bands 1/6–1/9 over every split prime was decided before this registration (J01, TRUE at `k ≤ 9`); not registered.*

**P.basis (fenced from J08 and J11).** The planner's hand evaluation of SIX-a at `q = 23` (one mind, unverified; SIX-a itself unverified):
at `k = 6` and `k = 7` the excluded traces are `|t| ≤ 3`, and no `c` makes `−4c, 1 − 4c, 4 − 4c, 9 − 4c` all non-zero squares mod 23 (`c`
must be a non-square since `−1` is; the 11 non-squares each fail); at `k = 8` (`|t| ≤ 2`) exactly `c ∈ {11, 20, 21}` pass — matching row
69's verified eight-colour ceiling at 23. Hence P-W6's weight sits on 43 (a heuristic `21/2⁷` expected passing classes at `k = 6`).

## Stage 5 — SAVED (§M the modeling passes, §X the log; the briefs are separate files)

### §M.1 `debruijn-domain-modeling` (invoked fresh with the Skill tool; applied to §S's statements)

- **The band's `k` is incidental; the intrinsic parameter is the arc.** The peeling lemma holds for every closed symmetric arc
  `B_β = [β, 1 − β]`, `0 < β ≤ ½` (its complement is an arc about 0; the argument reads only `‖·‖`). So the statements take `β`, and the
  sharp invariant is the **lonely-runner parameter** `κ(G, S) = max{β : some character λ has λ(S) ⊆ B_β}` (compactness makes it a
  maximum); `χ_char = ⌈1/κ⌉`. **CLG in its converged form: `κ(R_F, U_F) = max over stable places 𝔓 of κ(O_𝔓, S_𝔓)`, under `H_β` for the
  `β` in question.** SIX-b and SIX-c become computations of one number per target, `κ(Γ_q) = max_c min_{t ∈ V_c} |t|/q`, not yes/no lists
  per `k` (J08's brief states both).
- **The level index `m` is incidental to CLG.** Characters of the completed local ring `O_𝔓` that are continuous have finite level, so
  "the local target at `𝔓`" is the pair `(O_𝔓, S_𝔓)` with continuous characters and the index disappears from the theorem; level collapse
  (CLG-e) becomes a separate lemma computing local `κ` from level one when `p > 1/(2β)`.
- **The archimedean factor is a place like the others.** Real places `(ℂ, S¹)` and complex places (`F_w(i) ≅ ℂ²`, norm-one group `≅ ℂ^×`)
  both have local `κ = 0`: every real-linear character takes values near 0 on the local norm-one group (an interval about 0 at a real
  place; all of ℝ or 0 at a complex one). So CLG-d dissolves into CLG-c (joint density at the archimedean places too) plus "archimedean
  `κ = 0`" — which answers J02's warning (§2.8) by a different route than compactness, and is P-CM's content.
- **Unsampled members:** `F = ℚ` (the only stable place is the ramified `(1 + i)`, local `κ = ½`, `θ₂`); a field with no stable dyadic
  place and every usable `q` large (ℚ(√167), K(√7)); a real field with complex places (ℚ(α, √7)). **Adversarial member of the peeling
  lemma:** two factors both outside `B_β` — excluded by the lemma itself (peel either one and the other must lie inside), so the survivor
  exists but need not be unique; the statement says "some", never "exactly one".
- **The next lemma, predicted:** `κ(F′) ≤ κ(F)` for `F ⊆ F′` (restriction) — in the model it reads as "a larger field's stable places lie
  over the smaller field's with smaller or equal local `κ`", and J07 should check that CLG reproduces it.

### §M.2 `debruijn-obligation-modeling` (invoked fresh; the proof trees the briefs hand on)

**CLG (⟹), the statement from which it derives: the `n`-fold peeling lemma** — "if `X_1 + ⋯ + X_n ⊆ B_β` with each `X_j` symmetric and
non-empty, then some `X_j ⊆ B_β`", by induction on `n` (peel `X_1` if it leaves `B_β`, else stop; the rest's sum stays in `B_β`; CLG-b is
the step, needing only the peeled set symmetric). The tree:
1. **Input** — `H_β` gives `θ = τ + ψ`, `τ` of finite order `N`, `ψ` a real functional (row 95 and the gluing).
2. **The finite quotient** — `A = R_F/NR_F` is a finite ring, `A = ∏_𝔪 A_𝔪` over its maximal ideals (CRT), so `τ = Σ_𝔪 τ_𝔪`. **The
   obligation that carries arithmetic:** which `𝔪` occur (stable primes of `L` above `N`, under Lemma R's scope; in general, what J02-L2
   says) and what `A_𝔪` is.
3. **Joint image** — the image of `U_F` in `A` contains a product `∏_𝔪 N_𝔪` of local norm-one images (J02-L3's Hilbert-90 lift does the
   reduced level; the nilpotent levels are the new step), and every fibre of `U_F → A` is dense in `∏_{w | ∞} T(F_w)` (weak approximation
   for the rational torus; a finite-index subgroup of a dense subgroup of a connected group is dense).
4. **The sumset** — so the closure of `θ(U_F)` contains `Σ_𝔪 τ_𝔪(N_𝔪) + Σ_w ψ_w(T(F_w))`; each set symmetric (`−1 ∈ U_F`), each
   archimedean one containing 0.
5. **Peel** — by the `n`-fold lemma some `τ_𝔪(N_𝔪) ⊆ B_β`; it is not archimedean. So `τ_𝔪` is a band character of the local target.
6. **Controls** — `θ₂`, `[Fischer1994]`, C9, row 96, J02-T1.
**Level collapse (CLG-e)**, by induction down the radical filtration of `A_𝔪`: if `τ_𝔪` is non-zero on the last non-zero power `J^r`, the
norm-one elements `1 + x`, `x` in the anti-invariant line of `J^r/J^{r+1}`, rotated by some circle element `s` with `τ(s·line) ≠ 0`, sweep
`τ(s)` through a full coset of `(1/p)ℤ/ℤ`, which meets `(−β, β)` when `p > 1/(2β)`; so `τ_𝔪` kills `J^r`, and down to the residue field.
At `p = 2` the step is ½ and the collapse stops (Fischer's level 3 at `k = 4`); at `p = 3` and `β ≤ 1/6` likewise.
**SIX-a** is two lines (a line `Tr(ax) = t` meets the circle iff `X² − tX + c` has roots of norm `c`, i.e. a non-square or zero
discriminant); SIX-b and SIX-c are complete lists over sets the reduction and an explicit Weil threshold fix. **ONE-a** is a construction
(S0B-T3's heteroclinic at a general `p`; the lens `√2/6 < 1/4` is `p`-free, the step rule is not). **ONE-b** reduces to one construction
and one lemma: a minimal set meeting `T + A` is a leaf circle, so a counterexample is a switching character with bounded run lengths in
both directions that is uniformly recurrent; the obligation is whether S0B-T5's tree admits switches at bounded gaps.

### §X. The planner's "would have searched here" log

- **§P.basis:** would have run a script over `c` at `q = 23` for bands 1/6–1/8; instead evaluated the four quadratic-residue conditions by
  hand for the 11 non-squares (a derivation-fixed set of 11, done by hand, logged as the ban's edge; its tool form is J08's).
- **Question 1:** would have sampled random band characters of small rings to look for a two-place counterexample to the peeling; instead
  derived the peeling lemma (§M.2), for which none can exist.
- **§PA:** zbMATH discovery queries only (the gate's instrument, not a witness search).

### The briefs written (stage 5)

`data/crunch-2026-09-25/briefs/`: J03a-SWm-blind-reading.md (the owner's first request; launched), J07-M1-character-local-global.md,
J10-M1-character-blind-verifier.md, J08-M1-six-at-exposed-fields.md, J11-M1-six-blind-verifier.md, J12-M1-one-prime.md,
J13-M1-one-prime-blind-verifier.md. Each verifier's fixed list quotes §S verbatim and was written before any claim existed.

## Theorems this phase proved (the planner; all one mind, unverified, handed to J07/J08 to re-derive)

| id | statement (one line) | grade | where |
|---|---|---|---|
| J03-1 | the peeling lemma: `X = −X`, `X + Y ⊆ B_β`, some `x ∈ X` outside `B_β` ⟹ `Y ⊆ [β + ‖x‖, 1 − β − ‖x‖]`; its `n`-fold form by induction | hand, one mind | §S CLG-b, §M.2 |
| J03-2 | SIX-a: the trace set of `λ_a` on `μ_{q+1}` is `V_{N(a)} = {t : t² − 4N(a)` a non-square or 0`}` | hand, one mind | §PA.1, §S |
| J03-3 | at `q = 23` no band six- or seven-character; band eight-characters exactly at `c ∈ {11, 20, 21}` (given J03-2) | hand, one mind | §P.basis (fenced) |
| J03-4 | archimedean places (real and complex) have local `κ = 0`; a finite-index subgroup of a dense subgroup of a connected group is dense | hand, one mind | §M.1, §M.2 |

## Proposed edits (for the front-page lane; this job edits none of these files)
- `plans/FRONTIER-STUBS.md` / `CLAUDE.md` FS-91 row: the milestone is opened as "the character local–global theorem"; its band-rigidity
  question is answered at `k ≤ 9` (J01) and pending J03a at every `k`.
- `BIBLIOGRAPHY.md`: candidate rows (listing only, unread) — DeVos–Ebrahimi–Ghebleh 2007; Kang–Maharaj 2010; Liu 2008 (survey);
  Johnson 2011 (survey, Zbl 1243.05082); Johnson, *Product colorings* (1991, Zbl 0848.05029); Burgess 1963 (characters of polynomials).

## Where the 2026-09-25 work on this lives

*Addresses and titles only, added by the 2026-09-25 crunch's bookkeeper (job J30). The index of that day's work, with its results, is `plans/CRUNCH-2026-09-25-INDEX.md`; a blind verifier does not open it.*

- the jobs' records: `plans/FS91-S0V-band-to-nine.md` (J01), `plans/FS91-S0F-three-colours.md` (J02), `plans/FS91-S0V2-SWm-second-reading.md` (J03a), `plans/FS91-S1D-character.md` (J07), `plans/FS91-S1D-six.md` (J08), `plans/FS91-S0FV-three-colours-blind.md` (J09), `plans/FS91-S1V-character.md` (J10), `plans/FS91-S1V-six.md` (J11); `plans/FS91-S1D-one-prime.md` (J12, in progress) and `plans/FS91-S1V-one-prime.md` (J13, queued)
- tools `tools/crunch_j01_*`, `tools/crunch_j02_*`, `tools/crunch_j03a_*`, `tools/crunch_j07_*`, `tools/crunch_j08_*`, `tools/crunch_j09_*`, `tools/crunch_j10_*`, `tools/crunch_j11_*`; data `data/fs91/j01/` to `data/fs91/j11/`
- reports `data/crunch-2026-09-25/reports/J01.md` … `J11.md`; close inventory `plans/FS91-close-inventory.md`

## §R-close — the close (WORKFLOW step 9, the mathematics half; crunch job J23a, M1's close planner)

*Written by crunch job J23a (de Bruijn, Opus 5.5) under `data/crunch-2026-09-25/briefs/J23a-M1-close-math.md` and `STANDING-RULES.md`,
worked item by item from `plans/FS91-close-inventory.md` (items 1–130; item 130 is the owner's forward of J23p's first verdict, logged by
this job). Kooshi's words for the close, verbatim at `plans/FS89-rational-band-rigidity.md:923`: "close out with the findings"; "I don't
want to lose anything from before"; "All novel knowledge is a success." Results are filed in `plans/FS91-derivation.md`; every draft for
`LEDGER.md`, `CLAUDE.md`, `plans/FRONTIER-STUBS.md` and the stub banners is written here and nowhere else — a front-page job applies them.
Nothing in this section judges a verdict a record reached; where two records differ, both are filed with addresses.*

### Stage 1 — SAVED (the quotation check; the inventory walk)

**Quotation check (standing rule 5).**

| # | quoted in the brief or the owner's messages | source | result |
|---|---|---|---|
| Q1 | "close out with the findings"; "I don't want to lose anything from before"; "All novel knowledge is a success." | `plans/FS89-rational-band-rigidity.md:923` (Kooshi's words for FS-89's close) | **verbatim** |
| Q2 | the owner's forward of J23p: Manners §5.5, "the appropriate results are false for {θ₅^r}" | `plans/FS91-PA-close.md:97`: "are false for the smaller set `{θ₅^r : r ≥ 0}`" | **abridged, meaning kept** ("the appropriate results" precedes the line break; "the smaller set" and "`: r ≥ 0`" dropped) |
| Q3 | the forward's `[EinsiedlerLindenstrauss2022]` p. 3: "certainly works also for solenoids though this does not seem to have been written" | `plans/FS91-PA-close.md:116` | **verbatim** |
| Q4 | the brief's inventory items (FS89-CL2's "archimedean", row 95's wording, G74's and G76's killing tests, item 25, "every real number field") | items 8, 61, 69, 70, 78 | agree in substance; the items are paraphrases by their own authors, cited at their addresses |

**The inventory walk.** Every item 1–130 now carries a disposition in its status cell (`data/fs91/j23a/tick.py`, the map
`data/fs91/j23a/stage1-ticks.json`):

| disposition | items | count |
|---|---|---|
| ticked now, needing no drafting | 5 (declined: a blind verifier's reading-depth note), 10 (nothing owed), 18 and 21 (superseded by 67, 68), 27 (merged into 20), 91 and 93 (operational, acted on), 112 (nothing owed), 124, 125, 128, 129 (declined for M1: crunch-wide) | 12 |
| → stage 2, the derivation file (results; rulings applied as grading rules; held items that set an entry's verification line; corrections that change a filed statement) | 1, 2, 7, 12–14, 23–26, 59, 60, 62, 65, 67, 68, 72–76, 81, 86–89, 92, 95–110 (except 111), 113–115, 118, 126 | 48 |
| → stage 3, §R-close (slips, predictions, token counts, J01's folded stage 4, the §G bears items, the prior-art debts) | 4, 9, 16, 17, 19, 20, 22, 28–31, 33–58, 63, 64, 66, 71, 77, 80, 82, 84, 90, 94, 111, 116, 120, 122, 127, 130 | 53 |
| → stage 4, the drafts (corrections, held wording, stubs) | 3, 6, 8, 11, 15, 32, 61, 69, 70, 78, 79, 83, 85, 117, 119, 121, 123 (and 89, 105, 109, 110, 113, 130 a second time) | 17 (+6) |

**State of the blind checks at this stage.** J13 (the blind check of J12's one-prime results) is running; its record
`plans/FS91-S1V-one-prime.md` and report `data/crunch-2026-09-25/reports/J13.md` do not exist yet. So stage 2 files J12's theorems at
"one derivation (J12); blind check J13 pending", and stage 3 waits for J13's verdicts (the brief's rule).

**Would have searched here (stage 1):** none — bookkeeping only.

### Stage 2 — SAVED (the derivation file)

`plans/FS91-derivation.md` files every theorem M1 proved outside the kernel: **70 entries** covering **122 theorem ids** from the ten
"Theorems this phase proved" tables (the planner's, J01, J03a, J02, J09, J07, J10/J10b, J08, J11, J12) plus J11's `Γ₁₁` remark; duplicates are
merged, one entry per theorem, each title naming every other id (the control `data/fs91/j23a/coverage.py` finds every id; its plant, a fake
id, is reported missing and the run exits 1). Sections: §1 band rigidity at every band; §2 the unit-vector ring with no Galois hypothesis;
§3 three colours (statements about `χ`); §4 the class theorem CLG; §5 the character chromatic numbers at the exposed fields; §6 one prime
(J12; **J13 pending** on every entry); §7 the conjecture sweep (ten open items, each routed to a stub or a decline in stage 4).

**Verification status at filing** (each entry states its own; the records' words):
- **Three or more derivations:** Lemma C′ (J09's J2, J07, J10-T6); the peeling lemma (J03, J07, J10); CLG-d (J03, J07, J10); weak approximation
  (J07, J09, J10); the pullback (J07, J08, J10, J11); level collapse (J07, J08, J10, J11); SIX-a (J03, J08, J11); `χ_char(Γ₂₃) = 8` (J03,
  J08, J11); `χ_char(Γ₁₁) = 6` (J08, J10, J11).
- **Two independent derivations or two blind readings:** SW-m and band rigidity at every band (J01, J03a); PA-B2 (J01, J03a's second route);
  S1, S2, S3 and J02-L1–L4, T1, C2 (J02, J09); CLG_k and its `κ` form, CLG-g (bar (g3) at `k = 7`), HD1, C-47, C-167, CL3–CL5 under the wide
  `A` (J07, J10); Lemma C, LB/LB′ (J07, J10); `χ_char(Γ₄₃) = 9`, the Weil threshold, the band-6/7 list, `Γ₂₇`, the three fields (J08, J11).
- **One mind:** J01-1 (with FS-89's reader), J01-3, J01-4 (sharpness reproduced by J03a's plant), J03a-5, J03a-6, J03a-9; J09's J1, J-K, J4,
  J4-A, J4-T6; J10-L1, L7, L8, T9; J08-9, J08-10, J08-11; J11-T9 (compared in J11-T13); every J12 entry (J13 pending).
- **A GAP, filed as corrected:** J07-11's (g3) at `k = 7` (J10-T8): "exact level `2e(𝔭|3) + 1`", not "`e(𝔭|3) = 1`, exact level 3".
- **Records that differ on a grade** (index §2.3), filed both ways with addresses: J01-7 (record "one mind", two blind readings since); J02's
  S1–S3 (record "composition", two derivations since); J07-3/J07-4 (record "one mind", re-derived by J10 and, for C′, by J09); J08-6 (record
  "one mind", three other derivations); J08-8's `≤ 8` (corrected to `≤ 7`); J08-4's constants (100, 144 against 97, 141 — the same lists);
  J09's J2 (owner ruling "one mind"; its completed form reached independently by J07 and J10).

**Kernel decisions:** 11 stubs (FS-47 for Lemma C, C′, J02-L2, J10-L1; FS-75, re-aimed, for the three-colour chain J02-L1, L3, T1, T2, T3,
C1, C2 and J09's J4), every other entry declined with its reason (an external theorem — Berend, Weil — or no consumer). M1 added no Lean.

**Prior art at filing:** §1 carries J23p's first verdict (partly in print, `[Manners2015]` Lemma 5.3); every other entry reads "pending the
close gate" or names the held input it uses (Berend, Furstenberg, Weil, GPT Astra, Fischer 1990/1994, `[MMST1998]`).

**Inventory:** 48 items ticked "done (J23a stage 2)" with the entry each landed in (`data/fs91/j23a/stage2-ticks.json`); five of them (89,
105, 109, 110, 113) stay routed to stage 4 for their drafts.

**What stage 3 waits for.** J13's verdicts on J12 (the brief's rule: stage 3 does not start until `data/crunch-2026-09-25/reports/J13.md`
says DONE), and J23p's further verdicts (the owner forwards them).

**Would have searched here (stage 2):** none — filing only; the coverage control is a string check over a fixed list of ids.

*Addendum to stage 2 (after its commit): J23p's seven close-gate verdicts (inventory item 131, the owner's forward) are folded into
`plans/FS91-derivation.md`'s prior-art paragraph and the entries they bear on (FS91-J01-7, J07-2, J07-3, J07-4, J07-7, J02-T2, J08-1, §6's
header). Their use in the prior-art positions and the drafts is stage 3's and stage 4's.*

### Stage 3 — SAVED (the re-reads, the predictions, the verdict, the tallies)

*Written by J23a's successor (J23a2, de Bruijn, Opus 5.5), resuming from stage 2 under the same brief. Stages 1–2 were not redone.*

#### 3.0 What landed after stage 2, and where it went

| what | source | where it is filed |
|---|---|---|
| **J13 DONE** — the blind check of J12: every J12 claim (X1–X3) and every one of J12's 26 lemma statements TRUE; `MS₄({5})` false by a second, independent route (branching + entropy compression) | `plans/FS91-S1V-one-prime.md`; report `data/crunch-2026-09-25/reports/J13.md` | `plans/FS91-derivation.md` §6: every "J13 pending" replaced (commit 575346d0); new entries FS91-J13-T5 (a second family, exponential orders at 5) and FS91-J13-T6/L1 (J13's route) |
| **Owner ruling on J13's held item** — "the ledger carries J12's constructive route at every `p` as primary, and J13's independent existence route at 5 as the second derivation; J12-MSp's 'every `p`' is re-checked on J13's own frame" | owner, 2026-09-25 (brief of this resumption) | §6's header; FS91-J12-MS, J12-MSp |
| **J09v DONE** — J4, J4-C, J4-A re-derived blind by a second route; J4-A TRUE with `L(F)` over all stable valuation rings, FALSE (bipartite case only) under J09 §2.6's stated reading | `plans/FS91-S1V-no-mixing.md`; report `…/J09v.md` | FS91-J09-J4 (two derivations; J09v-2 merged), J02-T2 (third derivation), J02-C1 (third), J09-J4-A (two, corrected; J09v-7 merged), J07-9 (J09v-3 at `k = 3`), new entry FS91-J09v-8 (no mixed types, any real number field) |
| **The owner's scope note on CLG** — "CLG_k (J07-7) is an existence statement … It does NOT say that every character colouring of the plane is itself pulled back from one stable place. At k = 3 that stronger classification does hold — J09's J4 … — but not by CLG" | owner to J23a2, 2026-09-25 | `plans/FS91-derivation.md` §4's heading rewritten and a scope paragraph added; inventory item 163 (owner slip); every draft in stage 4 holds CLG at this scope |
| **J26** (the Ambrus et al. certificate audit) | `plans/PA-ambrus2023-audit.md`; clerk items 145–149, 153–154 | touches no M1 text (M1 cites no `[AmbrusEtAl2023]`): **listed for the front-page job** in stage 4, not drafted with M1's corrections |
| **Clerk 5's fold** (items 132–155) | commit 491161bb | dispositions in 3.11 |
| **The derivation file after the fold** | `plans/FS91-derivation.md` | 73 entries covering 141 theorem ids (the control `data/fs91/j23a/coverage.py`, extended with J13's and J09v's 19 ids, finds every one; its plant is reported missing and exits 1) |

#### 3.1 J01's stage 4, folded here (inventory item 19)

J01 left its stage 4 — the divergence table against the files fenced from it, and its C1 priors scored — to the close (`plans/FS91-S0V-band-to-nine.md`
stage 3b, "Left for a successor"). Done here, reading the fenced files now.

| # | point | FS-89's text (fenced from J01) | J01 (blind) | kind |
|---|---|---|---|---|
| 1 | PA-B2's route | `plans/FS89-derivation.md:349`, FS89-PA-B2: "case 2 by D1-L2; case 1 gives `M − M = R̂_S` by D1-L3, hence `M = R̂_S` by `[Berend1984]` Thm I.2 with Prop. II.6" | the same chain, with Berend's hypotheses (1)–(3) checked for this action (J01-1, stage 2 §2.3) | **agree**; J01's is the checked form |
| 2 | the truncated quotation (C0 Q2) | `plans/FS89-PA-berend1984.md:270`: "So `MS_k(S)` holds at every band `k` and every `|S| ≥ 2`, and D1-L4 and D5-L1 are not needed for it."; `plans/FS89-derivation.md:349`: "… at every band `k`, and D1-L4 and D5-L1 are not needed for it." | verified the words as quoted | **the continuation narrows nothing**: `|S| ≥ 2` is already PA-B2's hypothesis. Item 4's truncation is harmless |
| 3 | where PA-B3's band enters | `plans/FS89-derivation.md:364`, the close planner's reading: "its band restriction sits only in Lemma SW … and in the parity line (`x, x + ½ ∈ B_k` ⟹ `2x ∈ B_{k/2}`, i.e. `Θ₃` at `k = 6`, `Θ₄` at `k = 8`, both rigid)" | the only `k`-reading line is Lemma SW's arc line (J01 §3.6, stage-3 summary); the parity line is not in the chain once PA-B2 is band-free — J01 uses doubling only in its own second route (J01-3) | **route**: FS-89's reading over-counted the band steps by one; no divergence of truth (that reading was "unchecked") |
| 4 | PA-B3's range | `plans/FS89-PA-berend1984.md:374`: "`RS_k(S)` for `k < 2·min S` … `RQ_k` for `k ≤ 9`" | J01-4: SW as written holds exactly for `k < 2p`, sharp at `k = 10`, `p = 5`; J01-5 (SW-m) removes the limit | **agree, sharpened** |
| 5 | the stub's independence caveat | `plans/STUB-band-rigidity-six.md` Q1: "The same observation twice, not independent evidence, and unverified" | J01 verified it blind; J03a gave a second blind reading of the all-band step | **caveat discharged** (FS91-J01-5, J01-7: two blind readings) |
| 6 | the question itself | `plans/FRONTIER-STUBS.md` row 2: "Does row 95's route reach band 1/6 and 1/8?" | yes at every band, on characters (J01-7) | **answered**; the stub's re-aim is stage 4's |

**J01's C1, scored** (`plans/FS91-S0V-band-to-nine.md` §C1; priors registered before stage 2):

| claim | prior TRUE | outcome |
|---|---|---|
| PA-B2 (minimal sets, band-free, `|S| ≥ 2`) | 0.55 | TRUE (J01 stage 2; case 1 a second time by J03a-4) |
| "So `MS_k(S)` at every band `k`" | 0.55 | TRUE |
| `RS_k({5, 13})` / `RQ_k` at `k = 6, 7, 8, 9` | 0.45, 0.40, 0.38, 0.35 | TRUE at each (J01-6) |
| layering and gluing (VB3, VB4, D2-L1) `k`-free | 0.75 | TRUE (J01-8; J03a-2, with J03a's over-count corrected) |

Every prior was under 0.8 and every outcome TRUE: J01 was underconfident, and the expected `k`-dependence (Berend's transfer, the parity
line, the point step) located the band in the wrong places except Lemma SW.

#### 3.2 The §G re-read (the bearings extracted at the opening, against what happened)

**Which extractions paid** (the plan's §G.1 "bears" lines; inventory items 33–58):

| entry | extracted as | what happened |
|---|---|---|
| G1 | wall-standing fields trivial at `k ≥ 4` | **paid**: J07's `θ₂` control on a wall-standing field (FS91-J07-15); CLG's dyadic case |
| G7 | the type-M relation supplies `1/3` for FS-82 | **did not pay**: no three-colour route used `1/3` — S1's criterion is a stable prime above 3 of residue field `𝔽₃`; `1/3 ∉ R_F` only says some prime above 3 has odd residue degree (J09v §3.1) |
| G21 | J08's list states its generator's image and runs row 69's known positive | **paid, and the control failed for a stated reason**: at 43 row 69's eight-colour ceiling is a line-periodic circulant colouring, not a character colouring (FS91-J08-3; J11 independently) |
| G30 | derivation only; inhabitants; the discipline ladder | **paid**: two counterexamples filed as theorems (FS91-J03a-9, the J09v-7 field); the ladder's rungs did not include the third literature the close gate found (combinatorial geometry's pyjama problem) |
| G35 | the dyadic trichotomy is CLG's dyadic case | **paid**: FS91-J07-9 (inert dyadic, `U_Q`), J07-15 (ramified, `θ₂`), J09v-2 ((H) ⟺ non-bipartite) |
| G38 | `[Fischer1990]` Ex. 4 as J08's free control | **paid**: FS91-J08-8 ("no additive `k < 11` over ℚ(√167)" consistent with orders 23, 43, …) |
| G41 | `[Fischer1994]` on K as the dyadic control | **paid**: reproduced at level 3 by the existing checker (J07-15); "not an independent confirmation" (J10) |
| G43 | targets are the usable planes plus `U_Q`; no integrality gap for characters | **paid**: CLG's `χ_char(F²) = min` over targets (FS91-J07-7) |
| G44 | the level-one question is a Weil-bounded character sum | **paid**: the Weil threshold, two derivations (FS91-J08-4) |
| G46 | name the objects in their disciplines | **paid late**: the name of `χ_char` — `[BarajasSerra2008]`'s *regular chromatic number* — was found by the close gate, not the opening one |
| G48 | CLG is the conjecture for character colourings | **paid at existence scope**: CLG-g (FS91-J07-11). The §G.1 line's gloss "(every character colouring local at one prime after peeling)" is the stronger, classification form CLG does not state (3.8, the owner's scope note) |
| G49, G50 | the gate in the discipline's words; `[Zhu2011]` avoided; the Johnson debts | **paid**, with G49's pattern once more: the opening gate missed `[Manners2015]` (a third literature); the close gate reached it through the citers of a dynamics paper. The Johnson debts stand |
| G51 | the seventh run's shape: one deriver, one blind verifier on a fixed list, the lemma-statement fallback | **paid**: every GAP and every corrected scope was found by a verifier (J10: (g3); J11: SIX-e's hypotheses and `≤ 7`; J09: J02 §2.10; J09v: J09 §2.6; J13: J12's overlap sentence); the fallback phase was used by J10, J11, J13 |
| G54 | Hoffman certificates refuse band 6-characters at `q ≥ 59` for free | **not needed**: the Weil threshold (J08-4) and Lemma AV (J07-10) did the work; J10-L8 extended G54's all-levels ratio to every inert tower |
| G55 | `R_F` is the ring integral at every stable prime; torsion factors locally | **paid and extended**: Lemma C/C′ remove FS86-B1-LR's Galois hypothesis, three derivations (FS91-J07-3, J07-4) |
| G56 | a band six-character at 23 or 43 would six-colour a window member (P-W6) | **the event did not occur**: no band six- or seven-character on any window plane; `Γ₂₇` has none at all (FS91-J08-5, J08-R) |
| G58 | every band-character colouring is antipodal; J08's controls are G58 instances | **unused**: no job record cites it |
| G59 | the fractional wall bounds character colourings (`α ≥ q²/k`) | **paid**: Lemma AV (FS91-J07-10) |
| G61 | FS-82 via S0, consumed as a hypothesis | **paid and superseded**: S1–S3 (FS91-J02-T2, T3, C1), three derivations each for S1 and S3 |
| G63 | state for number fields; finitely generated `F` is FS-39's gap | **paid**: S1 extended to algebraic and purely transcendental `F` (FS91-J09-J4-A, two derivations, corrected); general `F` stays FS-39's gap |
| G64 | "six hides only in a non-character colouring"; J08 decides characters at 167 | **paid**: `χ_char(ℚ(√167)²) = 8` given CLG_7 (FS91-J08-8) |
| G66 | level collapse as a lemma (`p > k/2`); all-levels `L` | **paid**: four derivations of level collapse (FS91-J07-9), plus J09v-3 at `k = 3`; J10-L8 |
| G67, G72 | close form of any new grokking; §IQ | **paid**: 3.4 below; stage 4's grokking drafts carry the Do/Killing form |
| G71 | scope lines, characters only | **paid at the character/colouring cut, missed one level finer** (existence against classification; below) |
| G74 | the layer gluing; J01 decided its reading at 1/6–1/9 | **paid**; its killing-test reading ("disc plus finitely many torsion points") fires at one prime for minimal sets too (FS91-J12-MS, two routes) |
| G76 | primes counted first; one prime is not enough | **paid**: one prime fails for `RS`, `MS` and torsion orders, at every `p ≡ 1 (mod 4)` (§6) |

**Entries that should have borne and were not used** (each drafted in G67's form in stage 4):
1. **G21, applied to the control, not only the instrument.** The planner named row 69's eight-colour ceilings as J08's known positive without
   asking what shape those colourings have; they are line-periodic, a wider class than characters, so the control could fail at 43 and did.
   The rule is in `CLAUDE.md` § The gate ("A positive control proves an instrument finds things OF THE SHAPE ITS GENERATOR CAN REPRESENT");
   it is not in G21's *Do* line, where a re-grokking reads.
2. **G71's scope cut, one level finer: existence against classification.** §G.1 extracted G71 as "every M1 statement is about characters
   only" and held that cut; but the plan's own §0 item 1 ("a character colouring of any real number field's plane comes from one residue
   target") and §G.1's G48 line state CLG as a classification of every character colouring, which CLG_k's statement (§S, J07 §3.1) does not
   give. The stronger form then travelled to the owner's reports and J29's brief (the owner's note) and to this close's own §4 heading of
   the derivation file (J23a stage 2; fixed at stage 3). G72's two forms name the same cut — the structural form asks about every solution,
   and §IQ's structural form was answered with "some", not "one".
3. **G62 and FS-63's vocabulary (aperiodic order) bore on §6 and was marked silent.** J12's coding of the one-prime minimal set is an S-adic
   subshift (J12-W, J12-Ω), which is aperiodic order's vocabulary; neither the planner nor the close gate searched it there (the close gate
   searched the piecewise-rotation neighbourhood J12 named). A reading, not a demonstrated miss: nothing has been found there yet.
4. **G7's and G61's `1/3` extraction** was the wrong invariant for number fields (above); J09v's refinement of G74 ("`1/3 ∉ R_F` asks for an
   odd-degree prime above 3, and three colours ask for degree one") is the correction, drafted in stage 4.

#### 3.3 The §PA sweep: what M1 learned about what its object is

| # | the recognition | source | promoted to (drafted in stage 4) |
|---|---|---|---|
| R1 | **The band condition is the pyjama problem's condition.** Band rigidity at two primes is `[Manners2015]` Lemma 5.3's statement on the half ring `ℤ[i][1/P₅, 1/P₁₃]`; `[MalikiosisMatolcsiRuzsa2013]`'s "rational obstructions" are the torsion band characters; the solenoid form of `[Wang2012]` Thm 1.10 is stated unwritten by `[EinsiedlerLindenstrauss2022]`; `[KravitzLeng2025]` makes `N_k` effective on the half ring | J23p §1.3, §C.3 | a line in G76; row 95's and item 25's "Not ours"; the stub "does `R_S`'s rigidity follow from Manners on `A` and `Ā` by one gluing step?" (J23p §C.5) |
| R2 | **`χ_char` has a name in print:** the *regular chromatic number* of `[BarajasSerra2008]` (circulant graphs), with `κ` the lonely-runner / view-obstruction parameter | J23p §2.3 | a line in the new grokking on character colourings (G77, drafted) and in G46's instances |
| R3 | **A character colouring of a finite plane is a regular (interval) colouring of a circulant, strictly weaker than a colouring and than a line-periodic colouring**: `χ_char(Γ₁₁) = 6 > χ(Γ₁₁) = 5`; `χ_char(Γ₄₃) = 9 >` the line-periodic ceiling 8; `χ_char(Γ_q) > 1 + √q/2` (Weil) | FS91-J11-W3, J08-3, J08-4 | G56/G59 lines (the window is closed to characters; characters grow like `√q`) |
| R4 | **The three-colour question over a number field is residue degree one at 3, not `1/3`**: every circular three-colouring of a non-bipartite real number field's plane is a residue colouring at a prime of norm 3 (J4, two derivations) | FS91-J09-J4; J09v §3.1 | G74 and G61 edits |
| R5 | **The unit-vector ring is the ring integral at the stable primes, with no Galois hypothesis** (the rational points of the norm-one torus generate the stable semi-local order, except possibly at a ramified stable dyadic place) | FS91-J07-3, J07-4 | G55 edit; FS-47's statement |
| R6 | **The one-prime band set is a piecewise isometry — a rotation of `Q₀` about nine centres, or a correspondence with two choices per block — whose minimal sets carry S-adic, aperiodic codings**; `T + A` is exactly the periodic codings | FS91-J12-B1, B2, W, Ω; J13-T1, T3, T6 | G76 edit; the stub of inventory item 123 (minimal sets of `Θ₄(R_p)`) |
| R7 | **CLG is existential**: the peel proves "some summand is band", never "one"; a classification of every character colouring holds at `k = 3` (J4) and at HD1's three fields (Lemma D), not in general | J07 §5.1 (iv); the owner's note | G48 and G71 edits; the new grokking G77 |

#### 3.4 The §IQ re-read, and G72's count

- **The structural form** ("classify every character `χ = Σ_v χ_v` with `Σ_v χ_v(S_v) ⊆ B`: must some single `χ_v(S_v)` lie in `B`, and what may
  the others contribute?") **was answered**: some summand is band (the peeling lemma, FS91-J07-2, three derivations), never "one"; the
  archimedean summands vanish at complex places and are intervals about 0 at real ones (CLG-d, FS91-J07-6); at HD1's fields the others vanish
  (FS91-J07-12, through Lemma AV and Lemma D).
- **The invariant it forced** — the value-set profile — is exactly what CLG's proof peels; per target it is the trace set `V_c` (FS91-J08-1,
  three derivations); at one prime the leaf itinerary became J12's centre sequence and J13's digit sequence, with `T + A` ⟺ periodic
  (FS91-J12-B2 = J13-T3).
- **The open instances it named, decided for characters:** the `L = 5` fields (ℚ(√47), ℚ(√143), ℚ(√311), ℚ(√335), ℚ(√3,√5)) have no
  character four-colouring — ℚ(√47) computed (C-47, FS91-J07-13), the others by CLG-g's (g1) ("no exception at `k ≤ 5`"), not computed per
  field; ℚ(√167): `χ_char = 8` given CLG_7; `K(√7)`: 17, de Grey's field: 22, given CLG_16, CLG_21; ℚ(α,√7) at `k = 3`: `χ = 4`. The controls
  fell out (FS91-J07-15; HD1 from CLG's proof with Lemma D, not its statement).
- **G72's count: seven of seven** (FS-73, FS-79, FS-81, FS-85, FS-86, FS-89, FS-91): the class theorem came through the structural question —
  J07's route and J10's blind route are both the peel on the value-set profile — and so did J4's classification at `k = 3`. **The split, as
  FS-79's count made it:** band rigidity at every band came from verifying and extending a known tool (Lemma SW to SW-m); the instance results
  (J08's `χ_char` values; J12's constructions) came from the existence form with derivation-fixed exact lists. Kooshi's rule stands: no-gos
  count.

#### 3.5 The predictions, scored once (the plan's §P and every job's C0)

| registered by | id | statement | p | outcome |
|---|---|---|---|---|
| plan §P.1 | **O1** | CLG proved and blind-verified at every `k`, controls reproduced, `χ_char(ℚ(√167)²)` pinned | 0.30 | **occurred** (the highest rung); CLG at existence scope, given `H_k` (two blind readings); `χ_char = 8` given CLG_7; a GAP in the corollary (g3) at `k = 7` only |
| plan §P.1 | O2–O5 | lower rungs; O5 a counterexample | 0.25, 0.22, 0.18, 0.05 | did not occur |
| plan §P.2 | P-J03a | SW-m TRUE at every `k ≥ 3` | 0.80 | met (J03a-1, at every `k ≥ 2`) |
| plan §P.2 | P-W6 | a band six-character at level one of Γ₂₃ or Γ₄₃ | 0.15 | did not occur |
| plan §P.2 | P-167 | `χ_char(ℚ(√167)²) ≥ 7` given CLG | 0.80 | met |
| plan §P.2 | P-167-8 | `= 8` exactly given CLG | 0.45 | met |
| plan §P.2 | P-CM | CLG-d with complex places | 0.60 | met |
| plan §P.2 | P-U3 | ONE-a at every `p` | 0.75 | met (J12; J13, same route) |
| plan §P.2 | P-MS5 | ONE-b "no" | 0.60 | met (J12; J13 by an independent route) |
| plan §P.2 | P-U5 | ONE-c "unbounded" by a derived family | 0.35 | met (two families: J12's, J13's) |
| plan §P.2 | P-log | every M1 job's log non-empty and no search run | 0.85 | met for J01–J13 and J09v (3.9); J23p's log is empty, and J23p was not an M1 job at registration |
| J01 C1 | — | seven priors, 0.35–0.75 | — | all TRUE (3.1) |
| J02 C0 | S1, S2, S3 | TRUE | 0.85, 0.83, 0.83 | TRUE each; written after the route formed, calibration low (item 116) |
| J03a C0 | C1, C2a, C2b, C2c | TRUE (C2c on the wide `A`) | 0.95, 0.85, 0.85, 0.75 | TRUE each; the narrow reading's failure predicted in words and confirmed by a counterexample |
| J07 C0 | CLG_k (`k ≤ 9`, Lemma R scope; every `k`); CLG-c; CLG-d; CLG-e (odd / dyadic); CLG-g (exception empty at `k ≤ 5`); CL3–CL5 | — | 0.90, 0.75; 0.75; 0.85; 0.90 / 0.6; 0.80 (0.6); 0.85 each | TRUE each, CLG-c in its corrected form; (g3) at `k = 7` later a GAP (J10) |
| J08 C0 | C0-a; C0-23; C0-43; C0-167 | SIX-a; a band six at 23; at 43; `χ_char` at 167 | 0.97; 0.10 (contaminated), heuristic 0.77; 0.12; `= 8` at 0.50 | held; did not occur; did not occur; 8 |
| J09 C0 | S1 number fields; algebraic; every subfield GAP; S2; S3; a falsifier | — | 0.75; 0.65; 0.6; 0.75; 0.8; 0.1 | won each; no falsifier; **its route lost at exactly its named risk** (K1 false at `q = 27`) |
| J10 C0 | V1, V2, V3, V4 | — | 0.85, 0.85, 0.75, 0.55 | V1–V3 TRUE; V4's HD1 a GAP as a consequence of V1's statement, TRUE from its proof with Lemma D — the risk J10's C0 named. J10 did not score its own C0; scored here |
| J11 C0 | W1; W2; W3; W4 TRUE/GAP/FALSE; band six at 23 or 43; band seven; band eight at 23 / 43; `χ_char(Γ₂₃) = 8`; `χ_char(Γ₄₃) ∈ {8, 9}` | — | 0.97; 0.80; 0.75; 0.55/0.40/0.05; 0.04; 0.05; 0.88 / 0.50; 0.80; 0.70 | held; held; held; GAP fired as the brief quoted it (CLG_6, CLG_7), TRUE given CLG_16, CLG_21; did not occur; did not occur; held / none at 43; held; 9 |
| J12 C0 | C0-a; C0-b; C0-b′; C0-b″; C0-c; C0-c′ | — | 0.93; 0.55; 0.25; 0.30; 0.80; 0.35 | met; met; decided; lost (the reduction did not survive); met; met in the primes, not the family |
| J13 C0 | X1; X2 "no" / "yes" / GAP; X3 | — | 0.93; 0.35 / 0.15 / 0.50; 0.80 | met; "no" (against its own GAP-favouring prior; the planner's leaked P-MS5, 0.60, was nearer); met. Not blind to the planner's priors (J13's fence slip) |
| J09v C0 | J4; J4-C; J4-A | TRUE as stated | 0.85; 0.85; 0.60 | TRUE; TRUE given FS81-T2; TRUE with `L` over all stable valuation rings, FALSE (bipartite only) under J09's stated reading |
| FS-89's D | — | `MS₄({5})` false | 0.75 | met, by a different mechanism (a closing-lemma hierarchy; entropy compression), not Berend's Lemma 3.3 |

**What the table says.** Every registered theorem-level prior at or above 0.55 was met; the three events priced low (P-W6, C0-43, J11's
band six/seven) did not occur. The two recorded route-level losses — J09's C0 route (K1 false at 27) and J12's C0-b″ (the plan's §M.2
reduction) — were each named as the risk in advance. Calibration is weak evidence here: four jobs (J02, J07, J09, J10) wrote C0 after a
route had formed, and two (J08, J13) saw the planner's priors through a fence leak.

#### 3.6 The verdict, in four parts

- **The choice:** **Paid (theorem)** — outcome **O1**, registered at 0.30. The class theorem CLG holds at existence scope for every real number
  field and every band, given band rigidity `H_k`, which itself now holds at every band (two blind readings); every character chromatic number
  the milestone asked for is pinned at the exposed fields given CLG; three colours are closed over every real number field (with `χ`, not only
  characters); one prime is shown insufficient three ways, each by two derivations.
- **The alternative weighed:** **Paid in part (O2 or O3)** — on three grounds: CLG rests on `H_k`, whose finite-order bound `N_k` is not
  effective and whose minimal-set step rests on `[Berend1984]`; corollary (g3) of CLG-g has a GAP at `k = 7`; and band rigidity is partly in
  print (`[Manners2015]` Lemma 5.3).
- **Why O1 won:** O1's definition names CLG, its blind verification at every `k`, the controls, and the pin — all met; (g3) is a corollary of
  CLG-g at one band, not CLG; `H_k`'s dependence on Berend is a stated input, as FS-89's was; and a verdict label scores the experiment, not the
  novelty (Kooshi: "All novel knowledge is a success") — the prior-art position is recorded separately (3.7) and moves no label.
- **Confidence: high** on the label. **Medium** on the novelty of the headline results, which the close gate left undecided on named papers
  (`[Johnson2000]`, `[Johnson2006]`, Muchnik 2005, Shimura 1964, Bosio–Vivaldi 2000, Vivaldi 2006); reading those is the one fact that would
  change it.

#### 3.7 The prior-art position of each headline result (J23p's verdicts, `plans/FS91-PA-close.md` §C.1; final at this close)

| headline result | position | still undecided on |
|---|---|---|
| band rigidity at every band (FS91-J01-7) | **partly in print**: `[Manners2015]` Lemma 5.3 on `ℤ[i][1/P₅, 1/P₁₃]` (one Gaussian prime above each of 5, 13); the solenoid form of `[Wang2012]` Thm 1.10 stated unwritten (`[EinsiedlerLindenstrauss2022]` p. 3). **Not found:** `R_S` with both primes and the group `U_S`, other `S`, the field clause with the wide `A` | Muchnik 2005 |
| CLG (FS91-J07-7, J07-11) | **not found**; the invariant is `[BarajasSerra2008]`'s regular chromatic number (cyclic groups) | `[Johnson2000]`, `[Johnson2006]` |
| three colours over every real number field (FS91-J02-T2, T3, C1; J09-J4) | **not found**; the question is posed verbatim by `[Fischer1990]` §1 (a `CLOSED-QUESTIONS.md` candidate, answered in part); J4's classification in the literature's words is unsearched (inventory item 138) | `[Johnson2000]`, `[Johnson2006]` |
| Lemma C / C′ (FS91-J07-3, J07-4) | **partly in print**: `[Fischer1990b]`'s quadratic and multiquadratic cases; the general form not found | Shimura 1964 |
| the peeling lemma (FS91-J07-2) | **not found**; folklore-grade | the Borel product literature |
| one prime (§6) | **not found as stated**; `[Manners2015]` §5.5 asserts the one-prime failure without proof; J13-L1's method is `[GrytczukKozikMicek2013]`'s, cited from memory | Bosio–Vivaldi 2000, Vivaldi 2006, Adler–Kitchens–Tresser 2001 |
| `χ_char` of the finite planes (§5) | **not found** | — |

"Not found" measures the queries' words (G21); nothing here is called new.

#### 3.8 The honesty tally (every owner error and agent slip recorded for M1)

**Owner slips** (the product owner's briefs, forwards and reports):

| # | slip | address | effect |
|---|---|---|---|
| O1 | J01's brief: two address slips (PA-B2's parenthesis and PA-B3's row attributed to `plans/FS89-derivation.md`; both at `plans/FS89-PA-berend1984.md:373–374`) and one truncation | item 4; 3.1 row 2 | harmless (resolved in 3.1) |
| O2 | J03's brief: two advisor quotations not verbatim | items 20, 27 | meaning kept |
| O3 | J03a's brief: "FS-89 proved five colours for every `|S| ≥ 2`" (FS89-S1VB-14 has `S ∋ 5`) | item 64 | harmless once C2a holds |
| O4 | J08's brief attributes row 68's sentence to row 53 | item 84 | none |
| O5 | J10's brief: V4 dropped J02-T1 and turned "fall out" (of CLG-a–g) into "consequences of V1" | item 90 | J10 scored HD1 a GAP "as a consequence of V1" — the paraphrase's gap; TRUE from the proof |
| O6 | J09v's brief omitted FS81-T2 from J4-C's inputs | item 150 | J09v named and used it |
| O7 | the forward of J23p's first verdict abridged Manners §5.5 | items 140, 151 | meaning kept |
| O8 | **CLG paraphrased in the stronger, classification form** ("every character colouring … pulled back from one stable place") in the owner's reports to Kooshi and in J29's brief (`plans/FS84-five-colours-47.md` §1.1 Q5) | item 163; the owner's note | the owner caught it; **its source is in the plan**: §0 item 1 and §G.1's G48 line (the planner, J03); it also reached this close's derivation-file heading (J23a, below) |

**Planner slips** (J03): SIX-e under-named its hypotheses (CLG_6, CLG_7 for CLG_16, CLG_21; item 110); §M.2's ONE-b reduction — clause 2 a GAP,
the obligation non-deciding (item 119); LEDGER § B read by structure only (item 28); §G.1 names registrations "P-CLG" (G48) and "P-G74" (G74)
that §P does not carry (P-G74 withdrawn in §P's footnote, P-CLG folded into O1–O5) — found here; the stronger CLG paraphrase (O8's source).

**Agent slips and errors in records** (each found, and by whom):

| # | slip | found by | flatters the work? |
|---|---|---|---|
| A1 | J07-11's (g3) at `k = 7` "`e(𝔭|3) = 1`, exact level 3" | J10 (J10-T8) | yes |
| A2 | J08-8's "`4 ≤ χ ≤ 8`" (`≤ 7` known) | J11 | no |
| A3 | J02 §2.6 Remark 2 ("Mixed types are real"); §2.10 ("ramified or inert") | J09, J09v | no (both made the problem look harder) |
| A4 | J09 §2.6's finite-residue reading of `L(F)` | J09v | yes (widened S1) |
| A5 | J12's "no overlap with S0B-L4" sentence | J13 | no |
| A6 | J03a's over-count of its own `k`-lines | J03a's own §5, from J01's record | no |
| A7 | J23a (stage 2): `plans/FS91-derivation.md` §4's heading stated CLG in the classification form | the owner's note; fixed at stage 3 | yes |
| A8 | J09v's own stage-3 wording ("whenever a field realising it exists") | J09v, at its stage 4 | yes |
| A9 | J08-9's wrong first idea for the anti-band case | J08's tool, before recording (item 115) | — |
| A10 | fence leaks: J08's grep printed the plan's J03-3 row; J13's grep printed the planner's priors (l. 423, 503–505, 560–561) | self-disclosed | the leaked content agreed with, or preceded, independent results |

**Tool defects:** J11's two unreachable plants, kept and labelled (item 112); J13's phase-2 plant (`w̄` for `ω`) could not fire, replaced by the
53° rotation, which fires (J13 stage 3); no defect in J02's tools (item 10).

**G21's selection check.** Of the errors of truth or scope, the flattering ones (A1, A4, A7, A8, and O8 at four addresses) were each caught by
someone other than the sentence's author, except A8; the unflattering ones (A2, A3, A5) were caught by blind verifiers too. The verifiers
audited both directions at the same rate; no author caught a flattering error of their own except J09v.

#### 3.9 The would-have-searched log across M1, and every note at the ban's edge

| job | entries | at the ban's edge (complete exact enumerations of derivation-fixed sets, logged) |
|---|---|---|
| J03 (planner) | 3 (§X) | §P.basis: the four quadratic-residue conditions for the 11 non-squares at `q = 23`, by hand |
| J01 | 3 | the sweep's arithmetic, cosets of `(1/5^m)ℤ/ℤ`, `m ≤ 3`, `k ≤ 60` (`tools/crunch_j01_sweep_check.py`) |
| J02 | 3 | all 728 functionals of `𝔽₇₂₉` (and all 59,048 at `q = 243`), a control; the proof is Weil's |
| J03a | 2 | none (the sweep is a formula) |
| J07 | 5 | checks A, B, D: all characters of `ℤ[i]/3⁴`, `ℤ[i]/7³`, of `Γ_q` for the listed `q`; all symmetric subsets of `ℤ/12`, `ℤ/13`. Declined: the level-2 target at `q = 27` (`3¹²`) |
| J08 | 4 | every `c ∈ 𝔽_q^×` at 23, 43 (22, 42 values); every prime below `Q_k`; the product over value-set classes at the places `{2, 3, 7, 11, 19}` (273,581 tuples, 2.6 s) |
| J09 | 3 | `𝔽₇₂₉^* × μ₂₈` and the 242 norm classes at `q = 243` (it found K1 false) |
| J10 | 9 | every character of `ℤ[i]/p²`, `p = 3, 7, 11`, `k ≤ 9`; sampled unit vectors ranked mod `p` at seven pairs fixed in advance; every character of four towers. Declined twice: the `729⁵` tower (a GAP recorded instead) |
| J11 | 5 | every `c` at 23, 43; the enumeration to 199 (a check of the derived inequality); every character of `Γ_q`, `q ≤ 139`, a control; the range to 2000; 728 characters at 27 |
| J12 | 7 | the complete boxes `2 ≤ a, b ≤ 12` (level 2), `2 ≤ a, b ≤ 6` (level 3), `1 ≤ a, b ≤ 10` (the family) |
| J13 | 5 | Part C: `p ≤ 40` at 5, `p ≤ 20` at 13, 17; Part D: 200 random exact states in `Ω`, a sanity check of a derived inequality (sampled, not a witness search) |
| J09v | 3 | every character of `∏ O_𝔓/N` at `N ≤ 36` |
| J23p, J23a | 0, 0 | — |

**52 entries across 12 jobs (the planner and 11 derivation and verification jobs); no search was run.** Every enumeration was over a set a derivation fixed first. The one
sampled check (J13's Part D) tests a proved inequality, and its proof does not rest on it.

#### 3.10 Agent token counts (items 22, 71, 94, 127, 152; the reports)

| job | harness | own | own ÷ harness |
|---|---|---|---|
| J01 | 341k (item 22; its report says 335k) | — | — |
| J02 | 395k | 230k | 0.58 |
| J03 | 500k | 320k | 0.64 |
| J03a | 324k | 135k | 0.42 |
| J07 | 270k (its report; item 94 "TBD") | — | — |
| J08 | 384k | 185k | 0.48 |
| J09 | 417k | 255k | 0.61 |
| J10 / J10b | 311k / 361k | — | — |
| J11 | 319k | 120k | 0.38 |
| J12 | not reported | 200k | — |
| J13 | not reported | 130k | — |
| J09v | 210k (its report) | — | — |
| J23p | 395k (item 152) | — | — |
| J23a (first agent) | 421k (item 152; stopped at stage 2) | 155k | 0.37 |

Own counts ran at 37–64 % of the harness's. J03 (500k) reached the replace-not-reuse line; J23a's first agent stopped at 421k, one past its
hand-back line, and was replaced, not reused.

#### 3.11 The inventory at stage 3

Every item routed to stage 3 is ticked "done (J23a stage 3)" with its address in this section; J13's six report lines, the owner's J13 ruling,
the owner's CLG scope slip and J23a's heading slip are added as items 156–165; clerk 5's items 132–155 are dispositioned (M1 results filed;
crunch-wide items declined for M1 with the lane named; items bearing on M1's drafts routed to stage 4). The map is
`data/fs91/j23a/stage3-ticks.json`.

**Would have searched here (stage 3):** none — reading and filing only.
