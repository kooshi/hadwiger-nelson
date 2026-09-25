# FS-85: can four-colour rigidity exist without triangles? The plan

*Opened 2026-09-24 by the stage-A planner (de Bruijn, Opus 5.5), advised by a plan-phase Poros. It follows WORKFLOW 2.0 steps 3–5:
- §G, the re-grokking;
- §PA, the prior-art gate;
- §IQ, the invariant question;
- the subplan (§S), with the competition's brief text in §C;
- the predictions in §P;
- the modeling decision in §M;
- the search log in §X;
- the exchange with the advisor in §Y.

The stub is `plans/STUB-four-colour-rigidity-without-triangles.md`. The close inventory is `plans/FS85-close-inventory.md`, which only
the coordinator writes. It runs in **the finite-witness-free week, 2026-09-24 to 2026-10-01** (`CLAUDE.md` § Toolchain).*

## §0. The milestone after the reframe (read this first)

1. **Step 1 is not unworked ground, and the milestone's own leads never cited the ground that is worked.** Three held sources already
   hold hand pieces of Hubai's structure. None of them is stated on de Grey's lattice `Λ`:
   - **`[Polymath16wikiR2]`, "Coloring R_2"** (held, read in full at FS-70):
     - the renormalised colouring `ρ_z(a) = c(z + a) + a` into `𝔽₄ = ℤ[ζ₆]/2`;
     - the convexity lemma;
     - two-valued `ρ` is periodic, and three-valued `ρ` is periodic or a tri-sector (Prop. 6);
     - Prop. 7 / Cor. 9: `2R₁`-periodicity on `R₁` spreads to `R₁ + η²R₁`.
   - **Hubai's comment of 3 June 2018** (held threads): a five-rotation word that makes the chirality give a period of `8/3`, on the ring.
   - **`[Parts2020hv]`'s lemma** (MASCOT-T10): no monochromatic `√3`-triple implies every four-colouring of `ℤ[ζ₆]` is striped. The
     hypothesis is his computer part.

   The FS-74 stub's leads cite none of the three (a G50 instance, §PA.4). **Forcing is monotone upward** (`Forcer.Forces.mono`). So a
   theorem about every colouring of a *larger* graph (the ring `R₂`) does not restrict to `Λ`. One about a *smaller* graph (`ℤ[ζ₆]`,
   one coset) does. Every held piece must be checked edge by edge against `Λ` before it is used (the advisor's point 2, §Y).
   **One check is done, and it corrects the record** (§PA.6):
   - `η = (√33 + i√3)/6` (so `η² = ω₃`, the Moser twist) and `η^{±3}` all lie in `Λ = (1/9)·O_E`. The coordinates of 9η, 9η² and 9η³
     in the basis `1, ζ₆, w, ζ₆w` are `(−3, 6, 3, −6)`, `(6, 0, 3, 0)` and `(−5, 10, 2, −4)`.
   - So row 78's and FS73-T6's "reached through `η^{±3} ∉ Λ`" is false as written. That `Λ` is not closed under *multiplication* by
     `η` is a different statement, which this check leaves alone.
   - The wiki's identities (8)–(9) hold exactly with `ω = ζ₆ = e^{iπ/3}`, not with the page's stated `ω = e^{2πi/3}`.
   - Whether the wiki's Prop. 7 / Cor. 9 then runs on `Cay(Λ, U)` step by step is Task 0 (§C).
2. **Step 2, as the stub poses it, is trivially yes, and its content is translation invariance, then realisability.**
   - A triangle-free 5-critical graph minus an edge carries a four-colour forced pair: the Mycielskian of the Grötzsch graph, or de
     Grey's 61-vertex girth-4 graph in ℝ³ (`[deGrey2026]`).
   - In finite abelian Cayley graphs the question is posed in print. Klotz–Sander 2017, Problem 3.6, asks whether a uniquely colourable
     circulant must have χ = ω. It is answered *no* at three colours by a triangle-free uniquely 3-colourable circulant family
     (`[Basic2026]`, arXiv, September 2026). At four colours: not found.
   - So step 2 is posed on the class `𝒞^tf₄` of triangle-free Cayley graphs of `ℤ^r` with χ = 4 exactly (FS79-T1 frees every
     three-colourable one). The target that matters is the **unit-distance subclass `𝒰^tf`**, the lattices of real fields without √3.
     It adds the rhombus lemma (FS79-T28), point-group invariance and K₂,₃-freeness.
   - **An abstract "yes" reaches no field and answers nothing about Soifer 55.1. An abstract "no" covers every field.** §P scores the
     two at different scopes.
3. **The only exhaustive four-colour record we hold points one way** (close inventory item 11; FS79-T36's committed scan, read, not
   re-run). In rank 1, `11 ≤ max D ≤ 14`, `|D| ≤ 5`:
   - 377 sets have every phase rigid, and none is triangle-free;
   - of 600 triangle-free sets, 550 are three-colourable, and the 50 exactly four-chromatic ones are loose;
   - 27 of those 50 have a rigid phase beside a loose one.

   A rank-1 "no" is a theorem candidate, and a measurement of its range until proved (G21).
4. **The stub's day-2 killing test could not fire** (the advisor's point; inventory item 12). Its second clause is met by trivial
   necessary conditions. §S.4 replaces it with one that can fire, against a named list of trivial conditions.
5. **The controls were mis-levelled** (the advisor's point 4). `Λ₁₀` at three colours is triangle-free, but its missing clique is `K₃ =
   K_k`. At four colours no unit-distance graph has `K₄`, de Grey's lattice included. The controls that test where triangles enter are
   the **triangle-full loose** ones:
   - `ℤ[ζ₆]` at four colours;
   - FS-73's table (every CM-subfield lattice of ℚ(√3,√5), and K's other subfields, loose by a gapped periodic colouring);
   - rank-6 L3, loose with no gap.

   A step-1 mechanism that also "proves" rigidity on one of these proves too much.

**The shape.** A one-day stage A (this plan). Then a competition (stage C) on **one challenge in two parts**, open to both competitors in
either order, with an advisor. The killing test runs at the end of round 1 (about 2026-09-26). The fallback is FS-83 (§S.5). There is
no measurement phase. §M folds in a light domain pass.

## §G. The re-grokking (WORKFLOW 3.1)

*Walked with `CLAUDE.md` (from disk at `202bc890`), `LEDGER.md` and the nearest derivation files open. Each entry gets one line and a
verdict:*
- **B**, bears (and which phase it changes);
- **S**, silent (and why);
- **F**, falsifiable here (registered in §P).

*"→ C" means the bearing is written into §C's brief text; "→ S.4" into the killing test; "→ T" into the trivial-conditions list (§S.4);
"→ IQ" into §IQ.*

### G.1 The grokkings

| id | v | reason, and where it lands |
|---|---|---|
| G1 | B | Every known four-colour compulsion over K is 2-adic; `8Λ` is depth ≥ 3 at both primes above 2 (FS73-T4). → C (step 1 reads `8Λ` 2-adically), §P P-2adic |
| G2 | S | the grammar of built objects; nothing is built |
| G3 | S | witness geometry (radii) |
| G4 | S | shell inventory of five-forcers |
| G5 | S | the 1581's 1-sum |
| G6 | S | the hexagram as fabric |
| G7 | B | The type-M rotations are the layers of both kinds of lattice: de Grey's non-Eisenstein vectors come from `n = 3`, and every triangle-free quadratic field's layers are `{vᵏ}·U₅` (G74). → C (step 2's vocabulary on `𝒰^tf`) |
| G8 | B | A lookup only: name `Λ`'s 54 unit vectors as `ζ₆`-orbits of a few generators. → C (addresses) |
| G9 | B | *(corrected on the advisor's review; first marked S)* the 791-point core's six four-colour forced pairs (one at 4, five antipodal at 4/√3) are triangle-full forced pairs missing from the stub's list; both distances lie in `2R` (G70's list). They bear on the premise (every known four-colour forced pair uses triangles) and support P-2adic → §0, §C item 1 |
| G10 | S | a sampled criticality claim; no search this week |
| G11 | B | Moser-free five-forcers exist, all with triangles. Step 2 is strictly stronger than Moser-freeness. → IQ item 5 |
| G12 | B | One detuned copy couples along one thin conic; with FS79-T37 (single matchings) it says no pair of cosets presses alone. → C (step 1 is many-layer) |
| G13 | B | A fan gap frees every pair above it. Hence `F ≠ 0` forces every colouring to be gap-free at every vertex, a trivial condition. → T |
| G14 | B | A matching carries no pressure (T37's couplings are matchings). → C |
| G15 | B | Pigeonhole × kill is the construction frame for a step-2 "yes"; it is silent on the structural form. → C (what is yours to decide) |
| G16 | B | On K-fabric the residue colouring identifies every positive-valuation pair; √3-clean means residue (MASCOT-T6); Hubai's stripes are √3-*dirty*. → C |
| G17 | S | top-rung globality; no top rung is asked |
| G18 | S | composition of certified components; no certification this week |
| G19 | S | five-colour class sweeps |
| G20 | S | brick colourings |
| G21 | B | *(method)* A null measures its enumeration. The rank-1 record read is typed (§0.3), and every control is run at the scale of the question. → S (acceptance), §X |
| G22 | S | six-colourings of the plane |
| G23 | S | the cell family |
| G24 | S | the gap law |
| G25 | B | *(reading)* `χ ≥ 4` is holonomy of rainbow-clique propagation, and triangle-free routes exist at three colours (Wormald, O'Donnell). Step 2 asks whether four-colour *rigidity* has a triangle-free route. → IQ item 3 |
| G26 | S | the six-target |
| G27 | B | Galois flips are automorphisms. `Λ`'s order-24 point group gave `v`'s orbit its rank (T6); in `𝒰^tf` the point group acts on `S`. → C (use the symmetry) |
| G28 | S | the fine tail |
| G29 | S | the cell family |
| G30 | B | *(method)* Measurement generates, derivation kills. Failure mode 5: a theorem "every rigid triangle-free …" ships an inhabitant or says it is vacuous. The discipline ladder names symbolic dynamics, reconfiguration and algebraic graph theory. → §PA, C |
| G31 | B | Compulsions live one rung below the top. Step 2 asks for exactly that rung (four colours) in triangle-free material. → IQ |
| G32 | B | `μ(d) = 1` is a forced pair. In a triangle-free field the spindle adjoins `√(4δ² − 1)`, which may bring √3 back, so Soifer 55.1 needs the in-field chain (G55), not the spindle. → IQ item 5 |
| G33 | S | batch descent |
| G34 | S | in-field descent |
| G35 | B | The chain needs `1/δ ∈ ℤ[U_F]`, and ℚ(√47) and ℚ(√167) are wall-broken (47 and 167 are ≡ 7 mod 8). A chainable δ is a unit at every stable prime (FS79-T2). → IQ item 5, C |
| G36 | B | The residue colouring is the canonical separator, and it is the wiki's renormalisation base (`ρ_z = c + a`). → C (step 1's coordinates) |
| G37 | S | the descent endgame |
| G38 | B | Additive colourings bound `F` from above (`F ⊆ ⋂ ker φ`). FS81-T22: an additive four-colouring of a non-bipartite lattice is gap-free, so it never supplies a gap. → T |
| G39 | S | critical sets of finite forcers; the lattices are vertex-transitive and infinite |
| G40 | B | Absorption: a piece whose colourings all extend carries only its own compulsions, so a 3-colourable extending piece carries none. → T (χ = 4 exactly) |
| G41 | B | The additive family is one-sided. On `Λ` both Fischer's ℤ/4 colouring and the residue colouring exist, so a step-1 account must be consistent with them (`8Λ ⊆` their kernels). → C (control) |
| G42 | B | Kempe gauge γ. Every unit-distance object held is Kempe-open, and de Grey's lattice is the Kempe-rigid exception (FS-73). → C |
| G43 | S | five-colour sealing |
| G44 | S | Kloosterman spectra |
| G45 | S | lifting |
| G46 | B | *(method)* Name the classical theory. The object is a hom-shift into `K₄` on `ℤ^r` with a frozen pair (`[AlonEtAl2021]`), and the finite analogue is a uniquely colourable Cayley graph. Read the construction's data layout (T37's coset table). → §PA, C |
| G47 | S | sealed-field compulsions at five |
| G48 | B | The chain and spindle arithmetic. A five over ℚ(√47) *confirms* the conjecture and cannot falsify it. → IQ item 5 (the bearing on six and Soifer) |
| G49 | B | *(method)* The gate, including the held-threads grep, was run in the discipline's words (§PA). → §PA |
| G50 | B | *(method)* Read what the search found. The wiki page and `[Parts2020hv]` were held and read, and never reached FS-74's leads. An instance. → §PA.4, inventory |
| G51 | B | The design of stage C: cost window, retractions counted, content-free hand-backs, isolated scratch. → S.3, C |
| G52 | S | the σ-criterion for rotations |
| G53 | B | A counting compulsion ("at least L of n points share a colour") is a rigidity shape weaker than a pair. A step-2 "no" for pairs is not a "no" for counting compulsions. → IQ (scope of a no) |
| G54 | B, F | The tight-prime reading. B's is that full-rank `F` appears where the lattice is integral at a Hoffman-tight prime. FS81-T25: no usable prime of ℚ(√47) or ℚ(√167) is four-tight. Stripping the arithmetic (G72) is a bet. → IQ item 2, §P P-arith |
| G55 | B | The chain theorem is what a four-colour forced pair buys; FS79-T2 gives its exact target. → IQ item 5, C |
| G56 | S | the window for six |
| G57 | B | ω = 3 iff √3 ∈ F, which defines `𝒰^tf`. → IQ, C |
| G58 | S | antipodal colourings |
| G59 | S | the wall at six |
| G60 | B | *(corrected; first marked S by reading the title, not the addendum: a G67 instance of the planner's own)* its FS-73 addendum gives `F ⊆ F_μ ⊆ P` (`F_μ`: the differences no shift-invariant measure separates), so S2 has strengths, and `F ⊆ F_μ` is a trivial condition → IQ item 2, T |
| G61 | B | Three-colour triangle-free rigidity (`Λ₁₀`) is arithmetic at 1/3 and levelled at `K₃ = K_k`, so it is a mis-levelled control for four (§0.5). → C (stated as such) |
| G62 | B | Lattices are multilayers. De Grey's is Eisenstein cosets coupled by matchings, and `L21cc6506` is `{1, v, v̄, z, z̄}·U_R`. → C |
| G63 | S | transcendence |
| G64 | S | six as a value |
| G65 | S | no solver; the four-colour band is noted only as why finite witnesses are priced out |
| G66 | B | *(corrected, as G60)* its FS-73 addendum: periodic colourings are the continuous colourings of the odometer, so `P = F_clopen` and `F ⊆ F_μ ⊆ F_meas ⊆ P` → IQ item 2 |
| G67 | B | *(method)* This walk reads the *Do* lines. → §G's form |
| G68 | B | A gapped periodic colouring, or a full-dimensional `Θ_k` cell, makes a lattice loose. A gap is sufficient, not necessary. → T |
| G69 | B, F | "Rigidity is arithmetic, decided on the quotient; over K dense and rigid", which is the bet §IQ strips. → IQ, §P P-arith |
| G70 | B | The √3 dichotomy on the Moser lattice (MASCOT-T6): clean means residue, and the other 11 of 12 classes are dirty. Stripes live on the dirty side. → C (step 1) |
| G71 | B, F | Three colours are linear and four are not; `K₄`'s square complex is `ℝP²`. Its killing test is a four-colour rigidity theorem over a class with no arithmetic (P-G71, not met at FS-79). → §P P-G71′ |
| G72 | B | *(method)* The invariant question. → §IQ, and the close's count |
| G73 | B | The four no-gos by format. The one edge-local height lives on sum-closed halves (triangles), so step 2 asks whether *every* four-colour rigidity is carried by sum-closed triples. A full-dimensional `Θ₄` cell means loose. → IQ, C, T |
| G74 | B | The layer method. The layers of `𝒰^tf` over quadratic fields are rational-pattern copies, and at four colours a layer argument is one-sided. → C (step 2 on `𝒰^tf`) |

### G.2 The ledger rows (mechanism, one line each)

| row | v | mechanism, and the reason |
|---|---|---|
| 1 | S | two circles are 3-colourable; no lattice |
| 2 | S | the seam rotation σ |
| 3 | S | the coverage ratchet at a pivot |
| 4 | B | fan ⟺ compulsory coverage: `F ≠ 0` needs every vertex fanned in every colouring → T item 2 |
| 5 | S | class-only graphs; a pivot construction |
| 6 | S | the 120° identity |
| 7 | S | greedy colouring |
| 8 | S | a balanced five-colouring |
| 9 | S | a three-colour compulsion on two circles |
| 10 | S | the one-pivot cap |
| 11 | S | a three-colour tube automaton |
| 12 | S | an extension-profile tool |
| 13 | S | M17–M19 negative knowledge |
| 14 | S | pair-gluing of pivots |
| 15 | S | extension pressure (tools) |
| 16 | S | the coupled automaton |
| 17 | S | circle–circle gluing |
| 18 | S | a certified near-relation |
| 19 | S | the partner web |
| 20 | S | the pivot-triangle layer |
| 21 | S | registered statistics of M23 |
| 22 | S | the matched ladder is 4-chromatic (colourable, not rigid) |
| 23 | S | the four-ladder object |
| 24 | S | the hexagram |
| 25 | S | ρσ² = −1 |
| 26 | B | *(corrected with G9)* the 791-core's six forced pairs at 4 and 4/√3, triangle-full and 2-adic → §0, P-2adic |
| 27 | S | the quadrature law measured; G12 carries its bearing |
| 28 | S | the 2-adic kill engine |
| 29 | S | the stacking law; G14 carries its bearing |
| 30 | S | the mechanism hunt on the 1581 |
| 31 | S | Act One carriers (five colours) |
| 32 | S | the hex-shell six-programme |
| 33 | S | 5 ≤ χ(ℝ²) ≤ 7 |
| 34 | S | coset colourings need seven |
| 35 | S | coarse cells need seven |
| 36 | S | scale is not monotone |
| 37 | S | the gap atlas |
| 38 | S | the gradient hunt |
| 39 | S | the gap atlas, kernel side |
| 40 | S | the fine tail |
| 41 | S | the limit lemma |
| 42 | B | the arity floor; `Forces`/`Separated` as definitions → §M |
| 43 | B | homogeneity: forced pairs transport by isometries, so `F` is a group → §M |
| 44 | B | the spindle theorem: what a forced pair buys → IQ item 5 |
| 45 | S | batch descent |
| 46 | S | copy unions |
| 47 | S | M53 witnesses |
| 48 | S | critical sets of finite forcers |
| 49 | B | absorption → T |
| 50 | B | the additive yardstick `F ⊆ F_add` → T |
| 51 | B | additive rigidity is Kempe closure → C |
| 52 | S | the finite-plane bound (five colours) |
| 53 | S | the field sieve |
| 54 | S | the lift |
| 55 | B | `Forces.image`: compulsions map forward along homomorphisms (the transfer direction, §0.1) → C |
| 56 | S | local–global tightness at five |
| 57 | B | Theorems A and B: `Λ`’s residue colouring at the two primes above 2 → C |
| 58 | B | **the Moser recipe’s sharp threshold**: no k-clique host draws a *minimal* forcing gadget, and no k + 1 plane points carry a four-colour forced pair; step 2 asks for the non-minimal kind → IQ, C |
| 59 | B | the 2-adic law of four-colour compulsions over K (`v_𝔭(d) > 0`) → C (step 1) |
| 60 | B | **plane freedom**: rotations and the quarter turn make `F` trivial on every k-colourable finite plane at p ≡ 3 (mod 4) — a held "F = 0 by symmetry" mechanism, a candidate tool for a step-2 "no" on `𝒰^tf` → C |
| 61 | S | the six-target statements |
| 62 | S | orbit closure in reductions |
| 63 | S | two colours from inertia |
| 64 | S | the type-M arena (five colours) |
| 65 | S | Parts’s coordinate shape |
| 66 | B | the fan gap frees every pair above it → T |
| 67 | B | the 2-adic tower of K(i) forces exactly `𝔓⁴` at four colours — an arithmetic source of rigidity, with triangles (FS-74 lead 2) → C, P-arith |
| 68 | S | six refused at 83 |
| 69 | S | the window for six |
| 70 | S | five refused at 27 |
| 71 | S | five refused at 23; `χ_f(K²) = 4` |
| 72 | S | the 3-adic barrier (three colours) |
| 73 | B | ℚ(√11) needs four: a triangle-free field → C (the fields `𝒰^tf` lives in) |
| 74 | B | the census of triangle-free quadratic fields at four → C |
| 75 | S | the odd-prime tower |
| 76 | B | ℚ(√3,√5): triangle-full lattices loose by theorem — a loose control → C |
| 77 | S | the theorem audit |
| 78 | B | `F = P = 8Λ`, 12 classes; the fixed-prime gap lemma; L3 loose with no gap; KR6 → C (the known positive, the controls) |
| 79 | B | three colours linear; `Λ₁₀`; `L21cc6506`’s `Θ₃ = ∅` → C (a mis-levelled control, §0.5) |
| 80 | B | the four no-gos by format; rank-1 one-way walls; T37’s single matchings → C, T |
| 81 | B | `L21cc6506` loose at four (full-dimensional `Θ₄` cell); 7 survivors at ℚ(√167) → C, IQ item 5 |
| 82 | B | the layer method at three colours → C (the layer vocabulary) |
| 83 | B | the census completed by structural certificates → C (layers) |
| 84 | B | ℚ(√47): 102 of 127 four-colourable, 25 survivors, a matched finite refusal priced ≥ 1,284× → IQ item 5, C (why no finite witness) |

### G.3 The method rules (`CLAUDE.md` § Grokkings [method], § Toolchain, § Building, § The gate, the standard of evidence)

| rule | v | reason |
|---|---|---|
| the finite-witness-free week (§ Toolchain) | B | it defines the admissible instruments; §X and every brief |
| the RAM rule and `scripts/slot.py` | B | any exact check over 2 GiB or 2 minutes runs under a slot; none is planned |
| symmetry breaking before SAT | S | no SAT |
| value precedence over the unpinned colours only | S | no SAT |
| pysat CaDiCaL interrupt | S | no SAT |
| Python 3.14 forkserver | S | no pool jobs planned |
| checkpoint and resume (PROTECTED) | B | derivation phases checkpoint in their working files (§S.2) |
| a blocking run is presumed killable (PROTECTED) | S | no long runs |
| kill by PID or process group, verified by effect | S | no background jobs planned |
| a pipe can kill the producer and hide it | S | no pipelines whose cleanup matters |
| a waiter's condition must be false when armed, and never a self-matching pattern | S | no waiters planned |
| never edit a running script | S | no long runs |
| generated modules and invalidation | S | no Lean this week (§M) |
| the kernel's cost model | S | no Lean this week (§M) |
| searching (ugrep alternation, `exact?`) | B | the gate's greps used `python`/`grep -o` |
| the gate (vacuity; negative controls) | B | a hand theorem over a class states its inhabitant (G30 mode 5), and every proposed mechanism meets its loose controls (§0.5) |
| "every check needs a positive signal for the thing that did not happen" | B | the killing test must be able to fire (§S.4) |
| "state the uninformative outcome and confirm it reachable" | B | §P |
| "exactly one thing may differ between compared numbers" | S | no measurements |
| "a measured half and a derived half fail in opposite directions" | B | a claimed *yes* (an invented compulsion) is the suspect verdict in a derivation; the killing test's adjudicator checks it on the loose controls |
| "a positive control proves shapes its generator can represent" | B | a step-1 mechanism validated only on `Λ` says nothing about triangle-free shapes |
| "a TRUE explanation stops you looking for a second" | B | "the triangles did it" must be tested against the triangle-full *loose* controls |
| "a caveat you write and step over" | B | scope sentences (abstract vs unit-distance) are re-read against every headline (§P) |
| the standard of evidence above rung B | S | nothing new at χ ≥ 6 is expected |
| delegation one level deep | B | every brief carries it |
| content-free hand-backs; reports by SendMessage | B | every brief carries it |

### G.4 The nearest derivations, individually

| theorem | v | reason |
|---|---|---|
| FS73-T1 (Kempe period group) | B | `KPer` computes what a colouring pins; for step 1, `F = ⋂ KPer` (T36) → C |
| FS73-T2 (re-periodised period) | S | Smith-form bookkeeping for separators |
| FS73-T3 (forced differences compose) | B | `F` is a group; `8/3 → 16/3` → §M |
| FS73-T4 (depth ≥ 3) | B | the 2-adic reading of `8Λ` → C |
| FS73-T5 (`Λ = (1/9)O_E`, `8/9 = −(v + v̄)`) | B | the coordinates of step 1 → C |
| FS73-T6 (the `(0, v)` certificate; orbit spans `8Λ`) | B | the certificate step 1 replaces; `v` alone plus the point group suffices for `F ⊇ 8Λ` → C |
| FS73-T7 (`F = P = 8Λ`, 12 classes) | B | step 1's target, and Hubai's count on the ring → C |
| FS73-T21 (height lift) | B | why three colours are linear, so step 1 cannot be a height → C |
| FS73-T22 (three-colour criterion) | S | three colours |
| FS73-T23 (tight means affine) | B | the three-colour rigidity mechanism (isolated order-3 points), whose four-colour analogue step 2 asks for → IQ |
| FS73-T24 (density; dichotomy) | B | rigidity ⟺ finitely many colourings ⟺ every cell a point, at three colours; the analogue at four is open → IQ |
| FS79-T17 (winding is parity) | B | no loop invariant → C (the no-gos) |
| FS79-T18–T20 (Lemmas D, S; `𝒢_S`) | B | the non-triangle graph `𝒢_S` is the combinatorial object where triangles enter; `abcb` needs a fourth colour → IQ item 3 |
| FS79-T21 (edge-local heights iff sum-closed half) | B | the one format where triangles carry a height; step 2 asks whether triangles carry *all* rigidity → IQ |
| FS79-T22 (Kneser at k ≥ 5) | B | `K₄`'s three perfect matchings `V₄`: the four-colour-specific structure (stripes pair the colours) → C |
| FS79-T23 (de Grey's language: no edge-local height) | B | step 1 is not an edge-local height → C |
| FS79-T24 (square lemma) | B | triangle-free with two ± pairs: edge-local trivial → C |
| FS79-T25 (C7 on `L21cc6506`) | S | an instance of T23's form |
| FS79-T26 (coindex ≤ 4) | S | topological bounds certify colourability limits, not pairs |
| FS79-T27 (cube lemma) | S | face-local 2-forms |
| FS79-T28 (rhombus lemma) | B | what `𝒰^tf` adds to sum-free: every length-4 zero sum is two opposite pairs (the advisor's point 1) → IQ, C |
| FS79-T29–T30 (face flux; slaved) | S | face-local formats |
| FS79-T31 (Kempe period of an additive colouring) | B | `KPer(φ) = ⟨U₂⟩ ∩ ⟨U₁ − U₁⟩`, a formula-level tool for step 2's looseness proofs → C |
| FS79-T32 (4,490 Kempe-rigid orbits, yet loose) | B | a one-period census cannot see looseness, and rigidity at one period is not rigidity (G21) → C |
| FS79-T33 (a 2-cell with constant set `U_R`) | B | the full-dimensional-cell route to looseness → T |
| FS79-T34 (two rigid ends, one chiral) | B | chirality is where rank-1 walls live; Hubai's chirality is a four-colour chirality → C |
| FS79-T35 (exact rank-1 criterion) | B | the rank-1 case of step 2 is decidable phase by phase → C (a rank-1 route) |
| FS79-T36 (rank-1 scan) | B, F | read for triangles (§0.3; inventory item 11) → §P P-rank1 |
| FS79-T37 (single matchings) | B | step 1 is many-layer → C |

### G.5 `LEDGER.md` § B, by block

Silent blocks (reason):
- M18, M31, M32, M35, M36, M39–M43, M45, M48–M52, M54, M58, M59, M61–M64, FS-25, FS-32, FS-36, FS-50, FS-53, FS-54, FS-56, FS-58, FS-39,
  FS-61, FS-62, FS-66, Q8 (M51/M52), R52 (2026-09-06), M63 (42 entries, the rotation screens): five- and six-colour, residue-plane,
  cell-family, rotation-screen and reduction theorems, with no four-colour compulsion on a lattice.

Bearing blocks, with the lines that bear:
- **M53** (T1–T3, Theorems A/B; T11, no K-point graph forces a pair at five) → C.
- **R59 (2026-09-09)** (T1, the valuation law is `d ↦ 1/d`-invariant over K; T2, `[Parts2020a]`'s Table 1 matches it) → C (step 1: the
  2-adic law every four-colour compulsion over K obeys).
- **M55** (T1–T5, absorption) → T.
- **M56** (T1 exponent homs identify `eΛ`; T7 the additive spindle) → T.
- **M57** (T3 Kempe gauge; T6 the four-colour bed is Kempe-open) → C.
- **M60** (T1 compulsion sets are unions of norm classes, by rotation transitivity) → C, as a "no" mechanism.
- **MASCOT**:
  - T5, the sharp threshold → IQ;
  - T6, √3-clean ⟹ residue → C;
  - T10, the striped dichotomy under Parts's lemma → C, the key held step-1 piece;
  - T11, no √3-triangle in one row class → C.
- **FS-38**:
  - D2-A, tight ⟹ balanced, gap-free, periodic;
  - D2-B and L3, the 2-adic tower forces exactly `𝔓⁴`.

  Both go to C, step 1 lead 2, and P-arith.
- **ASTRA** (T5, the chain; T6, the 18-vertex ℚ(√2,√3) graph) → IQ item 5.
- **FS-70**:
  - T1, the triangle lemma (an additive ℤ/4 colouring identifies `0, i√3` iff `φ(1) = 2`): triangles in additive form;
  - T2 and T10, the Kempe screens;
  - T7, the split-prime tower forces from depth 3.

  All go to C.
- **FS-73**: individually in G.4.
- **FS-79**:
  - T1 (three-colourable ⟹ loose at four) → T;
  - T2 (chainable δ is a unit at every stable prime) → IQ;
  - T3 (one-way walls) → C;
  - T6 (canonical form) → §M;
  - T21–T37, individually in G.4.
- **FS-81**:
  - T3–T5, the layer method → C;
  - T22, additive ⟹ gap-free → T;
  - T25, the four-colour signs → P-arith.

**The re-grokking's test (it must change the plan), met.**
1. The held step-1 tools (§0.1) go into §C as starting material, with a transfer-direction check as every competitor's first act.
2. Step 2 is re-posed on `𝒞^tf₄`, with `𝒰^tf` as the scored target.
3. The killing test is rewritten against a trivial-conditions list T (§S.4).
4. The controls are re-levelled (§0.5).
5. Two arithmetic bets are registered (P-arith, P-2adic).
6. A rank-1 route is named (FS79-T35).

## §PA. The prior-art gate (WORKFLOW 3.2)

**§PA.1 The object, named in its disciplines' words** (question 1). The object:
- **symbolic dynamics**: a *hom-shift* `X = Hom(Cay(ℤ^r, S), K₄)` and its *frozen* coordinate pairs (`[AlonEtAl2021]`'s "frozen";
  `[PeledSpinka2023]`'s "rigidity" is another notion);
- **algebraic graph theory**: a *uniquely colourable* or *forced-vertex* structure of an *abelian Cayley* (circulant, on finite
  quotients) graph;
- **reconfiguration**: *frozen H-colourings*, Kempe classes;
- **statistical physics**: the four-state antiferromagnetic Potts model on the triangular lattice (`[MooreNewman2000]`), and colour
  chirality on hexagonal lattices (`[Cepas2016]`);
- **Euclidean Ramsey / chromatic geometry**: triangle-free unit-distance graphs (Soifer Open Problem 55.1).

**§PA.2 Queries** (zbMATH Open API unless marked; hit counts as returned 2026-09-24; each hit's text type is an author's **summary** (a
claim), a reviewer's **review**, or an **editorial** proceedings record):

| # | query | hits | what they were |
|---|---|---|---|
| 1 | `ab:"triangle-free" & ab:"unit distance"` | 3 | Exoo–Ismailescu 2016 (review: small triangle-free 4-chromatic UDGs); a 2026 arXiv on EI17/EI19 coordinate fields (summary); EuroComb 2013 (editorial) |
| 2 | `au:"de Grey, Aubrey"` | 9 | **`[deGrey2026]`** (summary: "a 61-vertex, 5-chromatic graph of girth 4 in ℝ³ … motivation to seek 5-chromatic cases with larger girth"); de Grey–Haugstrup 2022 (6-chromatic ℝ³) |
| 3 | `au:"Hubai, Tamas"` | 10 | no paper on this question; Frankl–Hubai–Pálvölgyi 2023, *Almost-monochromatic sets and the chromatic number of the plane* (DCG 70), listing only |
| 4 | `au:"Haugstrup, Asger"` | 2 | **`[Haugstrup2026]`** (summary: a 21,217-vertex tetrahedron-free 6-chromatic UDG in ℝ³); de Grey–Haugstrup 2022 |
| 5 | `ab:"frozen" & ab:"colorings" & ab:"Z^d"` | 1 | STOC '21 proceedings (editorial) |
| 6 | `ab:"frozen" & ab:"coloring" & ab:"shift"` | 1 | SODA 2013 proceedings (editorial) |
| 7 | `ab:"frozen" & ab:"colorings"` | 8 | Culberson–Gent 2001; **`[BrewsterEtAl2020]`, *Graph homomorphism reconfiguration and frozen H-colorings*** (summary; already held as a listing since FS-38); Silva 2022, *Subshifts and colorings on ascending HNN-extensions of f.g. abelian groups* (summary); Glauber-dynamics papers |
| 8 | `ab:"uniquely colorable" & ab:"Cayley"` | 2 | **Klotz–Sander 2017, *Uniquely colorable Cayley graphs*** (Ars Math. Contemp. 12; summary: χ divides \|Γ\|, colour classes are cosets, sharp edge bound for abelian Γ); **Bašić 2026, arXiv:2609.03184** (summary: an infinite family of uniquely 3-colourable integral circulants with ω = 2, answering Klotz–Sander Problem 3.6 negatively) |
| 9 | `ab:"circulant" & ab:"uniquely colorable"` | 1 | Bašić 2026 again |
| 10 | `ti:"uniquely" & ti:"colorable" & ab:"triangle-free"` | 5 | **Nešetřil 1973**, *On uniquely colorable graphs without short cycles* (no text); Zhu 1999, uniquely H-colourable graphs (review); Chao–Chen 1998; two edge-colouring papers |
| 11 | `ab:"triangle-free" & ab:"distance graph" & ab:"chromatic number"` | 1 | Noble 2016, 4-chromatic subgraphs of `G(ℚ³, d)` |
| 12 | `ab:"distance graph" & ab:"triangle-free"` | 2 | Noble 2016; a hypercube paper |
| 13 | `ab:"triangle-free" & ab:"Cayley graph" & ab:"chromatic number" & ab:"abelian"` | 0 | — |
| 14 | `ab:"Kempe" & ab:"triangular lattice"` | 1 | SODA 2005 proceedings (editorial) |
| 15 | `ab:"4-colorings" & ab:"triangular lattice"` | 0 | — |
| 16 | web: "Heule T721 721-vertex forcing … Moser-spindle-free" | — | MathWorld "Heule Spindle"; a snippet attributing to arXiv:2608.04542 (html) a 718-vertex virtual-edge gadget from T721; the held v3 PDF of `[Haugland2026]` has no "T721" — **unchecked** |
| 17 | held threads (`grep`, python): "stripe", "triangle-free", "pseudo-edge", "Haugstrup", "Hubai" | 23 / 17 / 2 / 56 / many | Hubai's 9 May and 3 June 2018 comments; Gibbs 3–4 June 2018; Voronov 2021 ("without triangles … computationally very hard"); Haugstrup Dec 2025; de Grey Jan 2026's simplex conjecture |

**§PA.3 The questions** (WORKFLOW 3.2's eight):
1. Named in the disciplines' words (§PA.1).
2. **Two disciplines at least**: symbolic dynamics, algebraic graph theory, reconfiguration and chromatic geometry.
3. **The question as well as the method.**
   - Klotz–Sander's Problem 3.6 is step 2's finite-abelian form, answered at three colours (Bašić 2026).
   - `[Ellenberg2018]` / `[AbrishamiEtAl2025]` 4.6 is the inheritance question; FS-76 carries it.
   - Soifer 55.1 is the chromatic-geometry form.
   - De Grey's January 2026 conjecture (held threads) asks, in the plane, only for a *four*-chromatic triangle-free UDG (`d + n − 1` at
     `d = 2`, `n = 3`), which is known. **So the published conjecture does not predict a triangle-free five in the plane.**
4. **Outside arXiv**: the held Polymath16 threads and wiki, and Geombinatorics listings.
5. **The citation graph of the posing paper.** Soifer's chapter 55 and its "[Soi46]" were not walked this stage: a debt, carried to the
   competition's gate (C).
6. **Citing works opened, not abstracts**: Bašić 2026 was read (§1–§3.1, §PA.5) before §C was written, on the owner's question.
   Klotz–Sander: summary only, still a debt.
7. **Two databases**: zbMATH only this stage. The OpenAlex cross-check of Klotz–Sander's citing works is a debt, and the most promising
   one (what else answers Problem 3.6).
8. **Complete author listings**: de Grey (9), Hubai (10), Haugstrup (2), in zbMATH, above.

**§PA.4 What the gate taught about the object** (swept for grokkings at the close):
- **(a) Step 1's first half has hand tools in the held record**, all on the ring or on `ℤ[ζ₆]`:
  - the wiki's renormalisation, convexity and Prop. 6–7;
  - Parts's striping under "no monochromatic √3-triple";
  - Hubai's rotation word for the `8/3` period;
  - Gibbs's June 2018 programme ("period 2 in one direction; monochromatic vertices never an odd number of links apart in any of the
    three directions").

  A **G50 instance**: FS-74's leads were written without them. Transfer to `Λ` is the open work (§0.1).
- **(b) The four-colour structure of the triangular lattice is residue-based.**
  - The wiki's Lemma 1 uses exactly that the three unit vectors of a triangle reduce to the three non-zero classes of `𝔽₄ = ℤ[ζ₆]/2`.
  - Triangles and the inert prime above 2 in ℚ(√−3) enter together.
  - This is the concrete form of the advisor's arithmetic bet (P-2adic).
- **(c) Triangle-free rigidity exists in finite abelian Cayley graphs at three colours** (Bašić 2026). The mechanism is extremal, not
  spectral: α = n/χ, and the only maximum independent sets are the colour classes of an additive colouring (mod 3). The Hoffman bound
  is loose there. The finite question at four
  colours is open as far as found. Finite-quotient rigidity bears on `P`, not on `F` (a periodic colouring is a quotient colouring):
  G21's "a periodic search measures its period" in theorem form.
- **(d) In abstract graphs triangle-free forced pairs are classical** (Nešetřil 1973: uniquely colourable graphs of any girth). The
  question's content is translation invariance, then realisability (§0.2).
- **(e) Every triangle-free five-forcer known is in ℝ³ or ℝ⁴** and uses spheres of radius below `1/√3`, where unit triangles cannot
  exist (de Grey, Jan 2026, held threads).

**§PA.5 Reading status** (bibliography entries updated the same day, `BIBLIOGRAPHY.md`):
- **`[Hubai2018]`**: read (9 May, 3 June 2018, and the follow-ups).
- **`[Polymath16wikiR2]`**: read in full (FS-70); re-read for FS-85.
- **`[Parts2020hv]`**: §§1–3 read at M53. The striping lemma is known through MASCOT-T10. Its §4 onwards is a debt for the competitors.
- **`[deGrey2026]`**: author's summary only; not held.
- **`[Haugstrup2026]`**: author's summary only; not held (new entry).
- **`[KlotzSander2017]`** and **`[Basic2026]`**: summaries only. **Both were already in the bibliography's § C since FS-38 (2026-09-13)**,
  Bašić with the verdict "nothing of ours rests on it", and neither was connected to FS-85 when it was minted: a second G50 instance.
  They are re-verdicted today.
- **The owner's question (a) or (b) on Bašić, decided (a):** read before §C, because G50 blocks an opening on a held-but-unread paper
  that touches the milestone. It is also shared reading in §C for both competitors at once, marked with its read status, because it may be
  a route and not only background. Read: abstract, §1, §3 up to Theorem 3.1 with Lemmas 3.1–3.2 in full, and Lemma 3.3's statement and
  the start of its proof. §4 was read as a statement only. The PDF is now in the library.
- **`[BrewsterEtAl2020]`** (existing, FS-38) and **Nešetřil 1973** (new listing row): listings.
- **T721**: unchecked (§PA.2 #16).

**§PA.6 A record correction found by the gate's transfer check** (exact, the planner, 2026-09-24):
- `η = (√33 + i√3)/6 ∈ Λ`, and `η^{±3} ∈ Λ`. Floating linear solves give integer coordinates to six decimals.
- So the clause in row 78 and FS73-T6 ("`(8/9)√−3·ζ₆^m` … reached through `η^{±3} ∉ Λ`") is false as written.
- **Proposed to the owner** (the planner does not edit `LEDGER.md`): re-read Parts's orbit and `v`'s orbit claim with `η³ ∈ Λ`. The claim
  that `v`'s orbit is not among Parts's forced vertices is separate, and it is unaffected.
- The wiki's identities (8)–(9) hold with `ω = ζ₆`, a notational slip on the page.

## §IQ. The invariant question (WORKFLOW 3.3)

1. **The existence form.** Is there a triangle-free abelian Cayley graph `Cay(ℤ^r, S)` with a non-zero forced group at four colours?
   Is there one in `𝒰^tf`, the unit-distance lattices of a real field without √3? And one with a chainable δ, that is, with `1/δ ∈
   ℤ[U_F]` and δ a unit at every conjugation-stable prime?
2. **The structural form, in two parts, both about every four-colouring.**
   - **(S1) Step 1.** Classify every proper four-colouring of `Cay(Λ, U)`, de Grey's lattice with its 54 unit vectors:
     - its restriction to every coset of the Eisenstein sublattice `T₀ = ℤ[ζ₆]` (Hubai's stripes, in MASCOT-T10's pinned form, §M);
     - how the cosets' stripe data are coupled (Hubai's chirality, stated on `Λ`);
     - `8Λ` read off from that classification.

     State exactly which steps use a unit triangle, and which use the reduction `ℤ[ζ₆] → 𝔽₄`.
   - **(S2) Step 2.** For every Cayley graph in `𝒞^tf₄`: is every difference δ ≠ 0 separated by some four-colouring, that is, `F₄ = 0`?
     Equivalently, is every frozen pair of a `K₄`-hom-shift on `ℤ^r` carried by sum-closed triples?
     - It is posed with the lattice's arithmetic stripped (G72 item 2). **Stripping is a bet** (P-arith): if four-colour rigidity is
       arithmetic (G54, G69), the abstract class and `𝒰^tf` may answer differently.
     - So S2 is asked twice: on `𝒞^tf₄` (arithmetic-free), and on `𝒰^tf` (the rhombus lemma, point-group invariance, K₂,₃-free).
     - **S2 is about every colouring, and it separates two statements the rank-1 record separates** (the advisor's second card):
       "*some* four-colouring is frozen" (a rigid phase, an isolated periodic colouring) happens without triangles — 27 of rank 1's 50
       four-chromatic triangle-free sets have a rigid phase beside a loose one (inventory item 11) — while "*every* four-colouring is
       frozen along δ" (`δ ∈ F₄`) never appears there. A frozen colouring that forces nothing answers S2 with nothing.
     - **S2 has strengths** (G60, G66): `F ⊆ F_μ ⊆ F_meas ⊆ P = F_clopen`. A "no" proved at `P` or at `F_μ` implies `F₄ = 0`, and a
       "yes" must be proved at `F` itself.
3. **The invariant it forces.**
   - **(S1)** *The planner's hypothesis, not a prescription (the competitors are pointed to items 1, 2, 4 and 5 only):* a per-coset finite-valued invariant: the *type* of the renormalised colouring `ρ_z` on `z + T₀` (constant, two-valued
     periodic in a direction `ω^j`, three-valued, tri-sector; the wiki's classification). Plus a global sign, the chirality. The
     coupling between cosets lives in the 48 non-Eisenstein unit vectors, one per coset (FS79-T37).
   - **(S2)** **None known**, and finding one, or proving there is none in a class, is the milestone.
     - Every invariant a four-colour rigidity has been seen to use rests on sum-closed triples: Moore–Newman's height (FS79-T21), the
       stripes (the wiki's Lemma 1 is a rhombus argument), and the minimal forcing gadget (row 58).
     - The formats G73 leaves open are the averaged (window frequencies), the non-local (radius-2 cocycles) and the structure-derived
       (group ring, counting).
     - An S2 "yes" must carry one of them. An S2 "no" must show that none of them can be non-trivial without a sum-closed triple.
4. **The route.** Derivation only.
   - An exact computer-algebra check may test a derived claim: membership in `Λ`, an exact rank, a character sum, a cell list whose
     shape a derivation fixed.
   - An exact LP is admissible only in the derived-shape form (§ Toolchain).
   - No enumeration of colourings, graphs or lattices answers S1 or S2.
5. **The open instances it would decide.**
   - De Grey's lattice (S1: `F ⊇ 8Λ` without the 2,044-point certificate), and KR6 (`F ⊇ 8Λ_dG`, four-colourability open).
   - ℚ(√47)'s 25 survivors and ℚ(√167)'s 7 (an S2 "no" on `𝒰^tf` makes every one loose, if four-colourable).
   - The chain route in every triangle-free field: dead on an S2 "no" in `𝒰^tf`; alive, and five for that field, on a chainable
     "yes".
   - Soifer 55.1 in the plane, answered *yes* by a chainable `𝒰^tf` instance in a wall-broken field. A "no" leaves it open, needing a
     refusal with no forced pair inside it.
   - Klotz–Sander 3.6 at four colours (its finite form bears on `P`).
   - FS-59's five-colour version at ℚ(√167), the six-template.
   - The rank-1 case of S2 (FS79-T35 makes it phase-by-phase decidable).

## §S. The subplan (WORKFLOW 4)

### S.1 Stages, and the three-agent cap

| stage | agents (≤ 3 at once) | dates (target) | what |
|---|---|---|---|
| A | planner + plan-phase Poros | 2026-09-24 | this plan (committed); then both stand down. The plan-phase Poros's held items go by file to the competition advisor |
| C | two competitors (de Bruijn, Coxeter) + one competition advisor (fresh Poros) | 2026-09-25 to 09-28 | the challenge (§C); round 1 ends at the killing test (about 09-26 evening), round 2 to 09-28 |
| V | at most two: a blind verifier (V2 pattern) per landed claim that only one competitor derived, or the two competitors cross-reading | 09-28 to 09-30 | any result the team likes gets an independent derivation before a ledger row (FS-81 lesson 1) |
| F (fallback) | one derivation agent + one blind verifier | from the killing test's firing | FS-83 (§S.5) |
| E | a fresh close planner | by 10-01 | WORKFLOW 9 from the inventory, with the week's verdict and the search-log count |

**Why a competition, not a blind verifier** (the protocol §3's rule): step 2 has no statement yet, and step 1's lattice form has no
proof. A blind verifier checks a fixed statement and cannot supply a route.

### S.2 Every phase's budget, stop rule, checkpoint, kill cost and acceptance

| phase | budget | stop rule | checkpoint and resume | what a kill redoes | acceptance checklist |
|---|---|---|---|---|---|
| C round 1 (each competitor) | 250k working tokens | the killing-test report (§S.4) is due by 2026-09-26 18:00, whatever the state | the working file in the competitor's own scratch directory, saved after every result; heading "Theorems this phase proved" kept current. Resume: a fresh agent reads that file and its §"state" section | only the derivation in flight since the last save | first route written before the held items are offered; the transfer check (§C task 0) recorded; every claim graded; the trivial-conditions list applied to any step-2 claim; the search log current |
| C round 2 (each) | to 400k working tokens (replace at 500k) | 2026-09-28 18:00, or both hand back | as round 1 | as round 1 | the above, plus every claimed theorem stated at its exact class (`𝒞^tf₄` or `𝒰^tf`) and checked on the loose controls |
| C advisor | 400k | stood down when advising ends (protocol §3) | its record in its scratch directory; a hand-off section kept current | the advice in flight | expectation written before its first reply; the killing-test adjudication written with its reasons; retractions counted |
| V (per claim) | 300k | a verdict on every lemma, or 200k with none (the stall criterion, protocol §3) | the verifier's record, predictions committed first | the lemma in flight | predictions committed before reading; derivation before reading the sketch; divergences listed |
| F (fallback) | derivation 300k, verifier 400k | FS-83's own killing test (the rational layer at k = 4 has a cell that is neither torsion nor archimedean) | as C and V | as C and V | P-W1 and P-W2 scored; the cell list on a second code path, with planted faults that fire |
| E | 350k | the inventory ticked | the inventory | the item in flight | WORKFLOW 9, including G72's count and the search log's count |

No phase runs a job over 2 GiB or 2 minutes. If one is needed, it goes through `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`, with
its output on disk, never in /tmp.

### S.3 One challenge, two parts: the ordering decision

- **The choice:** steps 1 and 2 are posed as one challenge. Each competitor chooses its order, and each first route is written before
  any held item is offered.
- **The alternative weighed:** strictly ordered (both on step 1, then both on step 2). It buys a shared mechanism before step 2 starts.
- **Why this won:**
  - ordering puts step 2 at day 3 or later of a seven-day week;
  - it makes both competitors start from the same held wiki tools, and FS-79's run shows convergence of first routes is the default,
    not the risk;
  - and the killing test accepts progress on either part.
- **Confidence: medium.** It drops if both competitors choose step 1 and take the same route, which the advisor watches for and may
  break by a card to both.

### S.4 The killing test (replaces the stub's), and the trivial conditions T

**At 2026-09-26 18:00 (end of round 1) the advisor adjudicates, in writing, with reasons.** The test **passes** if at least one competitor
has one of these, each checked by the advisor:
- **(K1)** a written derivation that every proper four-colouring of `Cay(Λ, U)` restricts, on `T₀` itself, to a stripe pattern in the
  pinned form (§M), using only edges of `Λ` (the transfer check done);
- **(K2)** a proved statement "if `Cay(ℤ^r, S) ∈ 𝒞^tf₄` (or `𝒰^tf`) has `F₄ ≠ 0`, then X", where X is **not implied by T**, and X is
  shown to fail on at least one named graph of the class on which **every item of T holds or is undecided**, so that X does work T
  cannot (the advisor's fix: "not already known loose" is met by any graph nobody has examined);
- **(K3)** a proved `F₄ = 0` theorem for a named class containing all of rank-1 `𝒞^tf₄`, or `𝒰^tf`, or a lattice family **named by
  a property of `S`** (rank, point group, field), never of its colourings. The proof must not reduce to G68 (a gapped colouring),
  FS79-T39 (a full-dimensional `Θ₄` cell) or FS79-T1 (three-colourability): a family defined by a held sufficient condition is that
  condition in disguise.

**Otherwise it fires**: stand the competition down and run FS-83 (§S.5).

**T, the trivial conditions** (necessary for `F₄ ≠ 0`, each already a theorem; a K2 condition implied by them does not count):
1. `χ = 4` exactly (FS79-T1);
2. every four-colouring is gap-free at every vertex (G13, row 66);
3. no gapped periodic colouring and no full-dimensional `Θ₄` cell (G68, FS79-T33);
4. `F ⊆ P ⊆ ⋂ ker φ` over the additive four-colourings (G41, row 50);
5. zero topological entropy along any direction in `F`, since a δ-periodic shift has none (the advisor's point);
6. finitely many colourings modulo `F` when `F` has finite index (FS73-T24's analogue, T37 consequence 3);
7. a chainable δ is a unit at every conjugation-stable prime (FS79-T2);
8. every four-colouring is **frozen**: no non-trivial finitely supported modification, so no finite Kempe component (it follows from
   δ-periodicity, and it is the most likely thing to be "proved");
9. `F ⊆ ⋂ KPer(c)` over the periodic colourings (FS70-T10, FS73-T1), stronger than item 4;
10. `F ⊆ F_μ` (G60's addendum);
11. in rank 1, FS79-T35 itself, so K2 is empty in rank 1, correctly, since rank 1 is decidable instance by instance;
12. the quotient restatement: the colourings are exactly those of `Cay(Λ/⟨δ⟩, S̄)`.

*T items 8–12 were added on the plan-phase advisor's review.*

It can fire: at FS-79 neither competitor proved K1-type structure on `Λ` in a day, and its no-gos would not have passed K2 (they
exclude formats, not graphs). It can pass: the held wiki tools make K1 reachable in a day if the transfer check succeeds.
*[Corrected at the close (close-inventory item 34, the competition advisor's catch): this does not follow. The wiki's Prop. 7 and
Cor. 8–9 treat only a coset on which the renormalised colouring is constant (the residue case, one of `Λ`'s 12 classes) and Prop. 6 a
three-valued one; nothing in the page treats the four-valued colourings the stripes need on the eleven √3-dirty classes. So P-wiki could
win on its letter while "K1 reachable in a day" did not follow; the plan-phase advisor's note repeated it. K1's load-bearing step was
Parts's no-monochromatic-√3-triple (S), and it was not met by derivation in round 1 (§R-close).]*

### S.5 The fallback, FS-83 (sketch, enough to brief from)

**The question** (`plans/STUB-layer-method-five-colours.md`): which real fields F have a character θ of `ℤ[U_F]` with `θ(U_F) ⊆
[1/k, 1 − 1/k] + ℤ`, at k = 4 and 5? At ℚ(√47) (k = 4) or ℚ(√167) (k = 5) a yes colours the whole plane below L, local at no prime.

**Shape.**
1. **Hour one:** the rational pattern's rotation set at the band `[1/4, 3/4]`, `Θ(U₅)` as in FS81-T3. This is an exact enumeration of
   the cells of one fixed 2-D rotation set, derived shape first. It is not a tree over a lattice, and it is in scope.
2. **Its killing test:** a cell that is neither torsion nor archimedean stops the candidate.
3. **If none:** the L3–L4′ chain with `6` in place of `3` (`1/2, 1/3 ∈ ℤ[U_F]` at both fields), by one derivation agent, then a blind
   verifier in the V2 pattern.

**Predictions** P-W1 (0.75) and P-W2 (0.65) carried. **Staff:** one derivation agent (300k) and one verifier (400k). **Brief slots:**
FS81-T2–T5 (the layer method), FS73-T40 (the rational pattern's cells), G71 and G73 (emptiness is one-sided from four colours up), the
ban and the search log.

### S.6 Records every phase writes

Every record carries a heading **"Theorems this phase proved"**: each theorem in one line, with its grade and where its proof lives.
Every record also carries the **"would have searched here" log**.

## §C. The competition's brief text (ready to paste; identical for both competitors except the name and an optional persona preamble)

*Slots filled per `plans/PROTOCOL-competitor-and-advisor.md` §4. The owner adds the agent ids and, optionally, a persona preamble per
competitor (protocol rule 2), telling the advisor of the difference.*

```
You are **<Coxeter | de Bruijn>**, and you have a genuine, friendly competitor, **<de Bruijn | Coxeter>**, working the same problem
independently. Kooshi (the human whose project this is) set it up this way on purpose: two independent shots at a derivation are better
than one, and it should be fun. Neither of you grades the other. The product owner coordinates; an advisor, **Poros**, advises you both.

Read `/home/kooshi/source/lean-dir/CLAUDE.md`, `DEBRUIJN.md` and `WORKFLOW.md` from disk first; they bind you. Then read this milestone's
plan, `plans/FS85-rigidity-without-triangles.md`, §0, §IQ items 1, 2, 4 and 5, §S.4 and §M (the pinned definitions). §IQ item 3 is the
planner's hypothesis, not a prescription; ignore it if you like. Its §G and §PA are the record's
background; everything you need from them is restated below.

## The mathematics you are standing on (with addresses)

1. **De Grey's lattice** `Λ = (1/9)·O_E`, `E = ℚ(√−3, √−11)`, `O_E = ℤ[ζ₆, w]`, `w = (1+√−11)/2`; rank 4; its 54 unit vectors `U`;
   `8/9 = −(v + v̄)` with `v = −(8/9)w` (`plans/FS73-derivation.md` T5). **Every proper four-colouring of `Cay(Λ, U)` is `8Λ`-periodic**:
   `F = P = 8Λ`, 380 colourings of `Λ/8Λ` under the pins (9,120 in all), 12 classes (`LEDGER.md` row 78; FS73-T6, T7;
   `data/fs73/census/K-8Lambda-classes.json`). The inclusion `F ⊇ 8Λ` rests on ONE solver refusal (a 2,044-point graph plus the edge
   `{0, v}`, 56.5 MB LRAT) and `v`'s orbit under the order-24 point group spanning `8Λ`. Nothing explains it. `8Λ` is exactly 2-adic depth
   ≥ 3 at both primes above 2 (T4). Exactly one class is √3-clean — Theorem B's residue colouring (G70; MASCOT-T6).
2. **Its structure** (`LEDGER.md` row 80; `plans/FS79-derivation.md` T23, T37): de Grey's rigidity is not an edge-local height, even on its
   own language; each of the 48 non-Eisenstein unit vectors lies alone in its coset of the Eisenstein sublattice `T₀ = ℤ[ζ₆]`, so the
   cosets (each a triangular lattice) are coupled only by single matchings — a many-layer effect.
3. **Hubai's description, on the Moser ring `R₂`** (`[Hubai2018]`, held: `~/source/library/notes/polymath16-threads-1-18-text.txt`,
   comments of 9 May 2018 08:41 and 3 June 2018 19:12, and Gibbs's of 3–4 June): by computer search, the ring has 9,120 four-colourings;
   restricted to `R₁ = ℤ[ζ₆]` each is "periodic by 2 in one direction ... alternating stripes of two colours each", the only freedom the
   shifts of the stripes; any stripe pattern periodic by 8 extends, in exactly two ways — rotation by `k·arccos(5/6)` acts on colours as
   rotation by `+k·2π/3` or by `−k·2π/3`, the same direction about every vertex; and (3 June) a five-rotation word — `ω₁²` about 0,
   `ω₁^{−2}ω₃` about (1,0), `ω₁^{−2}ω₃^{−1}` about 0, `ω₁²ω₃^{−1}` about (1,0), `ω₃` about 0 — equals a shift by 8/3 and cancels under
   either chirality. `Λ` is NOT closed under the rotations the ring uses (row 78: `8/3` transports only to rank 2 on `Λ`).
4. **Held hand tools for step 1, on the ring or on `ℤ[ζ₆]`**:
   - `[Polymath16wikiR2]` "Coloring R_2", `~/source/library/notes/polymath16-coloring-R2-2018.txt` (read it in full; 21 kB): colours in
     `𝔽₄ = R₁/2R₁`; the renormalised colouring `ρ_z(a) = c(z+a) + a`; Lemma 1 (convexity: a rhombus's long diagonal and one vertex force
     the fourth); Lemma 4 (two-valued ⟹ periodic); Prop. 6 (three-valued ⟹ periodic or tri-sector); Prop. 7 / Cor. 9 (`2R₁`-periodic on
     `R₁` ⟹ on `R₁ + η²R₁`), using the unit vectors `ω^j, η, η², η³, (2/3)(1+ω)η²`.
   - `[Parts2020hv]` (`~/source/library/pdf/arXiv-2010.12661-parts-human-verifiable.pdf`), as recorded in MASCOT-T10–T11
     (`plans/MASCOT-derivation.md`): under "no monochromatic √3-triple" (his computer part), every four-colouring of `ℤ[ζ₆]` is striped,
     `c(m + nζ₆) = P_{n mod 2}[(m + φ_n) mod 2]`; the dichotomy phase-wall / no wall.
5. **Four colours have no local certificate** (G71, G73; row 80): no height, the loop winding is the relation's parity, edge-local heights
   exist iff `S` has a sum-closed half (`±{a}`, `±{a,2a}`, `±{a,b,a+b}`; Moore–Newman's triangular-lattice height), parity-free face fluxes
   are trivial wherever three directions span cubes, coindex bounds stop at four. Open formats: window frequencies (averaged), cocycles of
   radius ≥ 2 (`[CGHO2025coh]` Thm 5.8), structure-derived (group ring, counting).
6. **Three colours are linear** (row 79; FS73-T21–T24): `Θ₃`, density of periodic colourings, `F` of finite index iff every cell of `Θ₃` is a
   point — no arithmetic of the lattice enters. At four colours none of this survives (T29, FS79-T17).
7. **The normal form** `F = ⋂_c Per(c) = ⋂_c KPer(c)`, `F ⊆ P` (FS73-T36), Kempe period groups (FS73-T1; FS79-T31 for additive
   colourings); `Forces` is monotone upward in the graph (`Forcer.Forces.mono`), and compulsions map forward along homomorphisms
   (`Forces.image`, row 55); a pair forced at `δ` with `1/δ ∈ ℤ[U_F]` gives `χ(F²) ≥ 5` by a chain in `F` itself (G55), and such a δ is a
   unit at every conjugation-stable prime (FS79-T2).
8. **Rank 1** (FS79-T34–T36; FS73-T30): the exact rank-1 criterion (`P ≠ F` iff every cyclic phase is a single cycle and a wall exists);
   chirality of rigid ends. The committed scan `data/fs79/comp-debruijn/runs/rank1_scan.jsonl`, read for triangles (not re-run): in
   `11 ≤ max D ≤ 14`, `|D| ≤ 5`, the 377 sets with every phase rigid include no triangle-free set; of 600 triangle-free sets, 550 are
   three-colourable and the 50 four-chromatic ones are loose, 27 of them with a rigid phase beside a loose one — a measurement of its range.
9. **Triangle-free fields** (G57; rows 73–74, 81–84): `ω = 3` iff `√3 ∈ F`; every real quadratic field that can need four colours is
   triangle-free; `L21cc6506` over ℚ(√167) is four-colourable and loose at four (full-dimensional `Θ₄` cell, row 81); ℚ(√47): 102 of
   127 lattices four-colour (49 by a gapped colouring), 25 survive capped screens, none called rigid (row 84). In a triangle-free
   unit-distance lattice every zero-sum of four unit vectors is two opposite pairs (the rhombus lemma, FS79-T28). Lattices over
   quadratic fields are layers `{vᵏ}·U₅` of the rational pattern (G74; FS81-T3–T5).

## The challenge (one challenge, two parts; choose your order)

The class `𝒞`: Cayley graphs `Cay(Λ, S)`, `Λ` finitely generated torsion-free abelian, `S = −S` finite, `0 ∉ S`, `Λ = ⟨S⟩`. The forced
group at four colours `F₄ = {δ : c(x+δ) = c(x) for every proper four-colouring c and every x}`. Triangle-free: no `s, t ∈ S` with
`s + t ∈ S`. `𝒞^tf₄`: triangle-free members with χ = 4 exactly. `𝒰^tf`: unit-distance lattices over real fields without √3 (`S` a
finite symmetric set of unit vectors of `F²` spanning `Λ`).

**Part 1 — why is de Grey's lattice rigid?** Prove, on `Cay(Λ, U)` itself, Hubai's description: every proper four-colouring restricts to
every coset of `T₀` as a stripe pattern (the pinned form in the plan's §M), the cosets are coupled by a chirality you state on `Λ`, and
read `F ⊇ 8Λ` off it — with no solver refusal. **Record exactly which steps use a unit triangle and which use the reduction `ℤ[ζ₆] →
𝔽₄`.** Your account must FAIL on the triangle-full loose controls: `ℤ[ζ₆]` alone at four colours, FS-73's loose CM-subfield lattices
(`data/fs73/table/TABLE.md`), rank-6 L3 (loose with no gap). An account that also proves rigidity there proves too much.

**Part 2 — can four-colour rigidity exist without triangles?** For every graph in `𝒞^tf₄`: is `F₄ = 0`? Decide it in a named class, or
exhibit a graph with `F₄ ≠ 0`, by derivation. **Scope is scored**: a "no" in a class containing `𝒰^tf` (or with its gap to `𝒰^tf`
named) covers every triangle-free field; a "yes" counts for the fields only if realised in `𝒰^tf`, and for five colours only if the
forced δ is chainable (`1/δ ∈ ℤ[U_F]`) in a wall-broken field. An abstract "yes" is a result about `𝒞^tf₄`, stated as such.
A "yes" means `F₄ ≠ 0` — *every* colouring identifies the pair. A single frozen or rigid colouring (an isolated phase) is not one: in
rank 1, 27 of the 50 four-chromatic triangle-free sets in the committed scan have a rigid phase beside a loose one, and none has a
forced pair.

**Task 0, for both of you, before anything else:** for each held step-1 piece (the wiki's Props 6–7 and Cor. 9, Hubai's five-rotation
word, Parts's striping lemma), list the difference vectors it uses and check exactly whether each lies in `Λ` (exact arithmetic, a few
lines of sympy). A piece using a vector outside `Λ` proves a statement about a larger graph, which does NOT restrict to `Λ`.

The planner has already checked one fact, which corrects the record. `η = (√33 + i√3)/6`, `η² = ω₃` and `η^{±3}` all lie in `Λ` (the
coordinates of 9η, 9η², 9η³ in the basis `1, ζ₆, w, ζ₆w` are `(−3,6,3,−6)`, `(6,0,3,0)`, `(−5,10,2,−4)`), so row 78's "`η^{±3} ∉ Λ`" is
false as written. The wiki's identities (8)–(9) hold with `ω = ζ₆ = e^{iπ/3}`, not with the page's stated `e^{2πi/3}`. Re-verify both, then
check whether every step of the wiki's Prop. 7 uses only points and differences of `Λ`.

**What outcome (a) or (b) would look like.** (a) Part 1 landed: a readable derivation of the stripes on `Λ` and `F ⊇ 8Λ`, triangles' role
stated, controls failing. (b) Part 2 decided in a named class: a theorem with its inhabitant (G30 mode 5), or a graph with a proof.

**The killing test (end of round 1, 2026-09-26 18:00)** is the plan's §S.4: K1, K2 or K3, adjudicated by Poros. A necessary condition
implied by the plan's list T does not count. Send your round-1 report to the owner by then.

**What the prior-art gate found, shared (prior art is never a competitive advantage):** the items in 3–4 above; Klotz–Sander 2017
(*Uniquely colorable Cayley graphs*, Problem 3.6: must a uniquely colourable circulant have χ = ω?) answered NO at three colours by a
triangle-free uniquely 3-colourable circulant family (Bašić, arXiv:2609.03184, 2026; held at
`~/source/library/pdf/arXiv-2609.03184-basic-uniquely-colorable-cayley.pdf`, **shared reading for both of you**, §1–§3.1 read by the planner).
Its mechanism: `G_p = ICG_{12p}({2, p})`, the Cayley graph of ℤ/12p on the x with gcd(x, 12p) ∈ {2, p}, is triangle-free, coloured by
x mod 3, and uniquely 3-colourable because α = n/3 and the only maximum independent sets are the three classes mod 3 (a combinatorial
layer count on ℤ/4 × ℤ/p; the Hoffman bound is not tight there). A finite-quotient result bears on `P`, not `F`;
triangle-free uniquely colourable graphs of any girth are classical (Nešetřil 1973), so the content of Part 2 is translation invariance;
de Grey 2026 (a 61-vertex girth-4 five-chromatic UDG in ℝ³) and Haugstrup 2026 (tetrahedron-free six-chromatic in ℝ³) use spheres of
radius below `1/√3`; `[BrewsterEtAl2020]` (frozen H-colourings: one colouring that reconfigures to no other); `[AlonEtAl2021]`'s "frozen". Unread and owed: Soifer ch. 55's
"[Soi46]", `[Parts2020hv]` §4 on, Bašić 2026 §3.1's case analysis and §4, the OpenAlex citing works of Klotz–Sander.

## The ban, and the search log

This week (2026-09-24 to 2026-10-01) no search for a finite witness of any kind (`CLAUDE.md` § Toolchain): no SAT/MaxSAT/#SAT, no
MILP/CP or local-search colourers, no Θ relation trees or float Θ₄ finders, no quotient-colouring searches, no sweeps over lattices or
sets. In: hand derivation, computer algebra (PARI, GAP, sympy), colourings given by formula, the Lean kernel, existing checkers on
existing certificates, reading committed records, and an exact LP only when a derivation fixed its shape first and its dual is read back
as an identity. **Keep a "would have searched here" log in your working file**: one line each time your default next move would have been
a search, and what you did instead. It is read at the close; an empty log means the ban constrained nothing.

## The competition, and the protocol

We trade **teasing hints only** — enough to show movement, never the mechanism or a coordinate. Write to your competitor with
SendMessage by its name; to the owner with SendMessage to `main`; to Poros by its id `<id>`. **Your working directory is
`<scratch>/fs85-C-<name>/`; do not open the other competitor's directory or file until you have handed back.** Your hand-back is exactly
"<name> idle; no content in this hand-back; my reports go to the owner by SendMessage" — every report goes by SendMessage. Record every
retraction (what was withdrawn, what killed it). The advisor may offer held items to both of you at once after both first routes are
written. **Do not spawn subagents, forks or workflows**: delegation here is one level deep, because staffing is Kooshi's budget decision
and the owner can only review work it knows about; if the work outgrows your context, stop at a saved boundary and tell the owner what is
left. Budget: about 400k working tokens; the owner replaces an agent above 500k. Any job over 2 GiB or 2 minutes runs under
`scripts/slot.py`; nothing large goes to /tmp. Keep a heading "Theorems this phase proved" in your working file, each theorem with its
grade (`CLAUDE.md` § Notation) and where its proof lives.

## What is yours to decide

Everything about the mathematics: the order of the parts; whether the stripes are the right object on `Λ`; whether the class `𝒞^tf₄`
is the right one or the arithmetic must enter (the plan registers stripping it as a bet); whether "forced pair" is the right compulsion
(counting compulsions, G53, are weaker). If the challenge as posed is subtly the wrong challenge, say so — that is a finding, not a
refusal. Two standing obligations bind you: the **prior-art gate** (`WORKFLOW.md` 3.2: name the object in its discipline's words, two
disciplines, the question as well as the method; the zbMATH API is in 3.2 item 8) and **honest reporting** (a line that does not land is
reported as not landing). Take your time; a clean two-page argument beats a big object.
```

### C.2 The advisor's slots (protocol §5)

*The template's "What I want from you" stays as written. The slots are filled below.*

```
## The situation
[as §C items 1–9 above, verbatim]

## The challenge
[as §C "The challenge" above, verbatim, with Task 0]

## Your specific duties this run, beyond the template
1. Adjudicate the killing test at 2026-09-26 18:00 in writing: K1, K2 or K3 (plan §S.4), each with the check you ran; police the list T
   (a K2 condition implied by T does not count) and say which item of T a rejected condition reduces to.
2. Police scope: every Part-2 claim stated at `𝒞^tf₄` or `𝒰^tf`; an abstract "yes" is never scored as a field result.
3. Police transfer direction: `Forces` is monotone upward — a theorem on the ring `R₂` or on a supergraph does not restrict to `Λ`;
   Task 0's membership list is checked before any held piece is used.
4. Police the controls: any Part-1 mechanism is checked against the triangle-full loose controls (`ℤ[ζ₆]`, FS-73's loose table, L3).
5. The held items from the plan-phase advisor (labels in its hand-off; contents in its HELD file only) are offered to both competitors
   at once, after both first routes are written (the owner's ruling R1 at FS-73).
6. Count retractions (yours included) and keep an asymmetric-card log where both competitors read it at hand-back.
```

## §P. Registered predictions (probabilities; both outcomes reachable)

| id | prediction | p | the uninformative outcome, and whether it is reachable |
|---|---|---|---|
| P-K | the killing test fires at 2026-09-26 | 0.35 | reachable both ways (§S.4) |
| P-S1a | K1 met by round 1: stripes on `T₀` for every four-colouring of `Cay(Λ, U)`, by derivation | 0.40 | not met: reachable |
| P-S1b | `F ⊇ 8Λ` derived with no certificate, at two independent derivations, by the close | 0.25 | not derived: reachable |
| P-W3 | (the algebra-week advisor's) the first round proves Hubai's stripes on de Grey's lattice | 0.35 | carried |
| P-task0 | *(registered, then decided in stage A)* at least one of the wiki's Prop. 7 difference vectors lies outside `Λ` | 0.55 | **lost in stage A**: `η, η², η³ ∈ Λ` (§PA.6). The advisor had read it as decided the other way by row 78, whose clause is itself the error |
| P-wiki | the wiki's Prop. 7 / Cor. 9 runs on `Cay(Λ, U)` step by step, with `ω` read as `ζ₆` (every translate and difference it uses lies in `Λ`) | 0.65 | reachable both ways, decided by Task 0 on day 1 |
| P-K1held | the held pieces that survive Task 0 suffice for K1 with at most one new lemma | 0.35 | reachable both ways |
| P-2adic | a landed step-1 derivation uses `ℤ[ζ₆] → 𝔽₄` essentially (the three unit vectors of a triangle hit the three non-zero classes) | 0.70 | falsifier: a step-1 derivation valid for any abstract `S` with the same combinatorics and no residue map; reachable if step 1 lands |
| P-arith | the answer to S2 on `𝒞^tf₄` (arithmetic stripped) differs from its answer on `𝒰^tf`, or a landed Part-2 result needs the lattice's arithmetic | 0.30 | falsifier: one arithmetic-free proof covering `𝒰^tf`; reachable both ways only if Part 2 lands |
| P-S2 | Part 2 at the close, a partition: (i) a yes realised in `𝒰^tf` 0.03; (ii) a yes in `𝒞^tf₄` only 0.12; (iii) a no in a class ⊇ `𝒰^tf` 0.10; (iv) a no in rank 1 or another class ⊉ `𝒰^tf` only 0.15; (v) not landed 0.60 | — | (v) is the uninformative one, reachable |
| P-rank1 | a rank-1 "no" (every rank-1 `𝒞^tf₄` has `F₄ = 0`) proved by the close | 0.20 | not proved: reachable; the committed scan cannot decide it (a range) |
| P-G71′ | a four-colour rigidity theorem over a class, with no arithmetic of the lattice (G71's killing test) | 0.15 | not met: reachable |
| P-W4 | (carried) the week proves some triangle-free field needs five | 0.05 | carried |
| P-W5 | (carried) at least one four-colour result about every colouring, outside K | 0.55 | carried |
| P-V | the week's verdict at two scopes: **Paid** (a four-colour result at two derivations for a class containing `𝒰^tf`) 0.20; **Paid (abstract)** (for `𝒞^tf₄`, rank 1, or any class narrower than `𝒰^tf`, including a step-1 result stated as a class theorem) 0.25; Draw 0.10; Null 0.45 | — | all reachable; step 1 alone is inside K. Rank 1 is decidable instance by instance (FS79-T35), so a rank-1-only result is Paid (abstract), never Paid (the advisor's pre-mortem item 4) |
| P-log | the planner's own search log has ≥ 3 lines, and each competitor's ≥ 2 by round 1 | 0.70 | zero lines (the ban constrained nothing): reachable |

Note on Paid (a scope the stub left implicit): step 1 is a result *inside* K, so a Paid verdict needs Part 2 (a triangle-free class)
or a Part-1 result stated for a class beyond `Λ`. Registered before the competition, so it cannot be tuned.

## §M. The modeling passes (WORKFLOW 6): a light domain pass folded in; the other two declined, with reasons

- **The domain pass, folded here** (the week is short, and no Lean is written): the pinned definitions every brief uses.
  - `𝒞`, `F₄`, `P₄`, triangle-free, `𝒞^tf₄`, `𝒰^tf`: as in §C "The challenge". `F₄` is a subgroup (row 43, FS73-T3); taking
    `Λ = ⟨S⟩` loses nothing (FS79-T6).
  - **Stripe pattern on a coset** `z + T₀`, `T₀ = ℤ[ζ₆]`, in coordinates `m + nζ₆` along a chosen direction (MASCOT-T10's form,
    rotated by `ζ₆^j` if needed): `c(z + m + nζ₆) = P_{n mod 2}[(m + φ_n) mod 2]`, where `{P₀, P₁}` is a partition of the four colours
    into two pairs (each an ordered pair) and `φ : ℤ → {0,1}` a phase sequence. Hubai's "periodic by 2 in one direction" is this with
    the direction free.
  - **Chirality** on `Λ` is left for the competitors to state (it is part of the answer).
  - **Chainable:** δ ∈ `F₄` with `1/δ ∈ ℤ[U_F]` (as complex numbers), hence a unit at every conjugation-stable prime (FS79-T2).
- **Obligation pass: declined as a stage.** The proofs are the competitors'; a planner's decomposition would be the head start the
  brief forbids. Each competitor runs `debruijn-obligation-modeling` freshly on its own route if a proof resists (DEBRUIJN error_reflexes).
- **Experience pass: not applicable.** No consumer surface (no Lean API, no tool output) is produced this week.
- **Kernel:** none planned. A landed hand theorem gets a kernel decision at the close (WORKFLOW 9).

## §X. The planner's "would have searched here" log

1. **Would have run a new rank-1 scan** for triangle-free sets with a non-zero four-colour forced group. Instead I read FS79-T36's
   committed scan and filtered it for sum-free sets: 0 of 377, a record read with no solver and no new enumeration. This is a borderline
   use of the ban, logged so the close can judge it. The advisor typed it independently and the owner checked it (inventory item 11).
2. **Would have asked a solver whether one of ℚ(√47)'s 25 survivors has a four-colour forced pair** (a pinned refusal plus an edge).
   Instead S2 is posed on the class, and the survivors are listed as open instances (§IQ item 5).
3. **Would have searched small circulants for a triangle-free uniquely four-colourable one** (Klotz–Sander 3.6 at four colours). Instead
   it is recorded as prior art and a question for derivation (§PA.4(c)). A finite quotient bears on `P` only, which is why it is not the
   milestone's instrument.
4. **Membership of the wiki's unit vectors in `Λ`: at first left for Task 0, then computed.** This is not a search. It was computed
   because the advisor's review read row 78 as settling it, and the planner's one-line reading of the wiki's identity (9) contradicted
   row 78. The check found a record error (§PA.6). The fact is shared with both competitors identically in §C, so their start stays
   identical. The step-by-step transfer of Prop. 7 stays Task 0.

## §Y. The exchange with the plan-phase Poros, and its dispositions

| # | the advisor's point | disposition |
|---|---|---|
| 1 | FS79-T28 (the rhombus lemma) bears, and §IQ must name what `𝒰^tf` adds to "sum-free" and which way each outcome crosses | **adopted**: §0.2, §IQ items 1–2, the scope rule in §C and §P |
| 2 | the transfer direction of the held step-1 tools (monotone upward) | **adopted**: §0.1, §C Task 0, the advisor's duty 3 |
| 3 | type the rank-1 null: 550 of 600 are three-colourable, the informative 50 none rigid; step 2 is limited to χ = 4 exactly | **adopted** (T item 1; §0.3; `𝒞^tf₄`). The 550 / 50 split is the advisor's endpoint `Θ₃` test, replicated by the owner (inventory item 11), not by me |
| 4 | the controls are mis-levelled; use the triangle-full loose ones | **adopted**: §0.5, §C Part 1 |
| 5 | stripping the arithmetic is an unpriced bet; register it with its falsifier | **adopted**: P-arith, P-2adic, P-G71′ |
| 6 | the stub's killing test cannot fire | **adopted**: §S.4 with the list T |
| 8 | (review) G60, G66 bear through their addenda; G9 and row 26 bear on the premise | **adopted**, the planner's verdicts corrected (two planner retractions) |
| 9 | (review) K2's and K3's gameable clauses; T items 8–12 | **adopted**: §S.4 |
| 10 | (review) P-task0 already decided by row 78 | **partly**: decided, but the other way. The planner's exact check found row 78's clause false (§PA.6); P-task0 is scored lost, and P-wiki and P-K1held are registered in its place |
| 11 | (review) Paid at two scopes | **adopted**: P-V |
| 12 | (review) §IQ item 3 is a route handed to both | **adopted**: labelled the planner's hypothesis; §C points to items 1, 2, 4, 5 |
| 7 | (second card) S2 must separate "some colouring frozen" from "every colouring frozen"; the owner's recount: 27 of the 50 have a rigid phase beside a loose one | **adopted**: §IQ item 2, §C Part 2 |

Retractions in stage A: **planner 2** (the silent verdicts on G60/G66 and on G9/row 26, both corrected), **advisor 0**. The advisor's
P-task0 point rested on a ledger clause that turned out false, which counts against the record, not the advisor. The advisor stood down
at about 468k tokens after its review (it held its items for the competition advisor).

## Phase records (filled as phases run)

### Stage A — Theorems this phase proved

- **FS85-A1.** `η = (√33 + i√3)/6`, `η² = ω₃` and `η^{±3}` lie in de Grey's lattice `Λ = (1/9)·O_E`. The coordinates of 9η, 9η², 9η³
  and 9η̄³ in the basis `1, ζ₆, w, ζ₆w` are `(−3,6,3,−6)`, `(6,0,3,0)`, `(−5,10,2,−4)` and `(3,−6,2,−4)`.
  - **Grade:** [tools: a floating linear solve with integer results to six decimals; exact re-verification is Task 0's].
  - **Where:** §PA.6.
  - **Rests on it:** the correction of row 78's and FS73-T6's clause "`η^{±3} ∉ Λ`".
- **FS85-A2.** The wiki's identities (8) `η = (ω⁴+ω⁵)η² + (ω+ω²)` and (9) `η³ = (2/3)(ω⁴+ω⁵)η² + (ω+ω²)` hold with `ω = ζ₆`. With the
  page's stated `ω = e^{2πi/3}` they fail.
  - **Grade:** [tools, float]: residuals `10⁻¹⁵` against 2.9 and 2.5.
  - **Where:** §PA.6.

Stated and not proved:
- the record reads in §0.3, a measurement of FS79-T36's range, owner-checked;
- §PA.4(b), a reading of the wiki's Lemma 1: a triangle's three unit vectors reduce to the three non-zero classes of `𝔽₄`;
- §PA.4(c), a reading of `[Basic2026]` §3.

## §R-review. The owner's scoring of the plan (2026-09-24, at stage A's hand-back)

*Written by the product owner, who scores and does not contribute mathematics. The plan above is the planner's; this section records
the score, one owner check and two rulings. Everything here is logged in `plans/FS85-close-inventory.md`.*

**Scores.**

| part | score | reason |
|---|---|---|
| §G | **pass** | every grokking G1–G74, every ledger row 1–84, the method rules and the nearest derivations walked one line each, with a reason; two silent verdicts corrected on the advisor's review (G60/G66 by their addenda, G9/row 26), both counted as planner retractions; the test "it must change the plan" is met six ways (§G.5's last paragraph) |
| §PA | **pass, with debts** | 17 queries in four disciplines' words, the question searched as well as the method, zbMATH author listings, the held threads grepped; it found the G50 instances (the wiki page, Parts's lemma, Bašić) and a record error. Debts carried to the competitors' gate, named in §C: Soifer ch. 55's "[Soi46]", the OpenAlex cross-check of Klotz–Sander's citing works, Klotz–Sander's full text, Bašić §3.1's case analysis and §4, `[Parts2020hv]` §4 on, T721 unchecked |
| §IQ | **pass** | S1 classifies *every* four-colouring of `Cay(Λ, U)`; S2 asks `F₄ = 0` for every member of a class, separates "some colouring frozen" from "every colouring frozen", and names its strengths (`F ⊆ F_μ ⊆ P`). Neither is the existence form reworded. Item 3 is labelled the planner's hypothesis and kept out of §C |
| §S.4 | **pass** | the replacement killing test can fire (K1–K3 each need a proof no held result supplies; T's twelve items police K2) and can pass (K1 is reachable in a day if Task 0 succeeds) |
| §C | **pass** | identical for both competitors; shared prior art stated as such; no route from §IQ item 3; the ban and the log; the protocol's rules (content-free hand-backs, no subagents with the reason, retractions counted) |

**The owner's check of one step** (the rule: one step of every key claim). FS85-A1 re-verified **exactly** in sympy: 9η, 9η², 9η³, 9η̄³
have integer coordinates `(−3,6,3,−6)`, `(6,0,3,0)`, `(−5,10,2,−4)`, `(3,−6,2,−4)` in the basis `1, ζ₆, w, ζ₆w` of `O_E`, so each lies in
`Λ = (1/9)·O_E`. The control that must land outside does: 9η⁶ has coordinates `(−13/3, 0, 16/3, 0)`. My first control, η/3, came back
integral (3η ∈ O_E), so it was a control that could not fail; η⁶ replaced it. **FS85-A1's grade is therefore [tools exact]**, and Task 0
remains an independent re-verification. Row 78's and FS73-T6's clause "`η^{±3} ∉ Λ`" is false as written, by row 78's own definition of
`Λ`; the correction is owed at the close (inventory).

**Ruling 1: a verdict the registration left unassigned.** P-V's four verdicts do not cover "a four-colour result on `Λ` only" (Part 1
landed, nothing outside K): it is not Paid or Paid (abstract) (the note after P-V), not Draw as defined ("only three-colour results")
and not Null ("nothing at four colours"). **Ruled, before the competition starts: it scores as "Draw (K)"** — algebra matched a search
certificate inside K and reached nothing new outside it. The alternative weighed was a separate verdict ("Explained"), which would
reward replacing a known certificate as if it were a new result; the week's question is whether algebra reaches four colours *where
search could not*, and inside K search already could. P-V's registered probabilities are left as registered; at the close, this outcome
is scored as Draw.

**Ruling 2: round 1's end.** The killing test is adjudicated when both competitors have sent their round-1 reports **or** at 2026-09-26
18:00, whichever comes first (the agents run continuously; a wall-clock deadline alone would leave the adjudication waiting on an idle
day).

**Kooshi's reading of the verdicts (2026-09-24, after the rulings above):** *"The week has barely begun. If it doesn't pay off in one
milestone, that's fine. A proven theorem about why its impossible is also valid. All novel knowledge is a success."* So Paid, Draw (K),
Draw and Null measure only the week's narrow experiment (whether algebra reaches four colours outside K where search could not); they are
not the milestone's worth. Every proven new theorem — a "no" in a named class, a no-go of a named format, or a derivation of `8Λ` inside
K — is a success of the milestone and is reported as one. Nothing registered above changes.

**Ruling 3 (2026-09-24, on the competition advisor's question, before any round-1 report): a proved "yes" passes the killing test.**
§S.4's K1–K3 had no clause for the plan's own outcome (b) as a "yes": a named graph with `F₄ ≠ 0`. **Ruled: a named Cayley graph in
`𝒞^tf₄` (or in `𝒰^tf`) with `F₄ ≠ 0`, proved by derivation at `F` itself (not at `P` or `F_μ`; §IQ item 2's strengths) and shipped with its
inhabitant (G30 mode 5), passes as K4**, scored at its scope: Paid (abstract) unless realised in `𝒰^tf`, and for five colours only if
chainable in a wall-broken field. The alternative weighed was requiring it as K2; a "yes" is not a necessary condition, so it cannot be
stated in K2's form. Confidence high.

**Ruling 4 (the same day): a K1 whose load-bearing step is a finite case analysis found by search passes only with a derived step
beyond it.** A K1 whose load-bearing step rests on a finite case analysis found by search — one's own this week (banned) or one in the
literature — is recorded as **"K1 by prior art"**, and it is a result (it establishes the stripes on `Λ`, and establishing a known
argument on a new object is new knowledge). **It does not pass the killing test on its own.** It passes if either (i) that step, or the
stripes themselves, is derived with no finite case analysis, or (ii) it comes with a derived step beyond it: the coupling between cosets
(the chirality stated on `Λ`), or `F ⊇ 8Λ`. The alternative weighed was passing on the letter, since a published human-checkable case
analysis is mathematics and existing certificates are in scope this week. It lost because the test exists to detect movement by
derivation in this week, and Part 1 asks for `8Λ` "with no solver refusal". Confidence medium: it would change if Kooshi reads K1 as "is
step 1's first half established on `Λ`" rather than "did the competition derive it".

