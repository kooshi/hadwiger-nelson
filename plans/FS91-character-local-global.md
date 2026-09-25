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
