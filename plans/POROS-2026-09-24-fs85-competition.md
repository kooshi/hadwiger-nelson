# Poros — FS-85 competition advisor's record

*Poros (competition advisor), Opus 5.5, 2026-09-24. Milestone FS-85, "can four-colour rigidity exist without triangles?"; plan
`plans/FS85-rigidity-without-triangles.md` at 39ad44b6. Competitors: de Bruijn (aeccc63c28a91235e, boat-builder preamble), Coxeter
(aaa9cb185091cd964, tango preamble). Sole writer: me. Stays in scratch until both competitors hand back.*

Read before this section was written (in this order): my identity file (`~/source/poros/CLAUDE.md`), the brief, the plan-phase
advisor's HELD file, the plan in full (§0–§R-review), the protocol §0–§3. `CLAUDE.md` on disk = the copy in my context (last touched by
202bc890; HEAD 39ad44b6). **Not yet read when this was written:** either competitor's working file, the wiki page, the held threads,
`data/fs73/table/TABLE.md`, FS79/FS73 derivation files.

## §1. My expectation (written 2026-09-24, before any message to or from a competitor)

**The frame on five axes.**
- *Object.* Part 1: the K₄-hom-shift on `Cay(Λ, U)`, which is 48 triangular-lattice layers (T₀-cosets) plus inter-layer matchings,
  and whose triangles run *across* layers too (`{0, u, ζ₆u}` for every non-Eisenstein `u`, since `Λ` is an `O_E`-module). Part 2: the
  stabiliser `F₄` of the whole shift, i.e. whether the `ℤ^r`-action on `Hom(Cay, K₄)` is faithful.
- *Question.* Part 1 asks for a mechanism for a certified fact; Part 2 asks existence/non-existence over a class.
- *Discipline.* Part 1: the 4-state Potts antiferromagnet on the triangular lattice (Moore–Newman height; stripes = extreme-slope,
  "ideal" states) plus 2-adic arithmetic (`ℤ[ζ₆]/2 = 𝔽₄`). Part 2: symbolic dynamics (hom-shifts, frozen) **and graph products /
  Hedetniemi-type uniqueness (exponential graphs `K₄^H`)** — the second is not in the plan's §PA.1 list, and I expect it to own the
  abstract half of Part 2 (hunch P-prod below).
- *Audience.* The ledger; secondarily Soifer 55.1 and Klotz–Sander 3.6.
- *Product.* A derivation; scored Draw (K) for Part 1 alone.

**Which forks are real.**
1. *Part 1, where the stripes come from:* the wiki's renormalised-colouring route (local rhombus/triangle arguments on each T₀-coset,
   then the η-layers) versus an arithmetic route (the dyadic tower, row 67's `𝔓⁴`) versus a height route (Moore–Newman on each coset,
   pinned by the couplings — held H2). Real: they disagree on whether triangles or 2-adic arithmetic carry the rigidity, which is the
   whole of Part 2's premise.
2. *Part 2, which class:* `𝒞^tf₄` (abstract) versus `𝒰^tf`. My prior: the abstract class is much easier to say *yes* in than the plan's
   P-S2(ii) 0.12 assumes — **categorical products** `G × H` with `G` triangle-free and `H` any triangle-full rigid lattice are triangle-free
   Cayley graphs of `ℤ^{a+b}` (a triangle in `G × H` projects to one in `G`), 4-chromatic by El-Zahar–Sauer, and inherit `H`'s rigidity in
   the `G`-directions unless `G` maps into the non-proper part of `K₄^H`. If so the abstract class does not isolate triangles at all and
   the scored content lives entirely in `𝒰^tf`. (Hunch P-prod; not sent; checked below only as far as stated.)
3. *Part 2 on `𝒰^tf`, which fields are still open:* held H6 (row 66 frees every field with a stable prime whose target four-colours
   with a gap). What is left: wall-broken fields with no usable 7 (ℚ(√47), ℚ(√167)), and dyadic-`K₄` fields with no usable 7 (ℚ(√59),
   ℚ(√83); held H5). Real fork: `P-arith` — H5 predicts a *yes* in type (B), never chainable.

**Where I expect a derivation to break.**
- Part 1, step "every T₀-restriction is striped": the triangular lattice alone has a positive-entropy family of four-colourings (the
  Moore–Newman height states); stripes are its extreme-slope states. The exclusion must come from the 48 couplings, each a single
  matching (no pressure alone, G14), so the argument must use triangles that cross three layers. I expect this step to be where the
  wiki's proof uses ring structure (multiplication by η, rotations about points) that `Λ` lacks — **η ∈ Λ does not make `Λ` an
  η-module**; `Λ` is an `O_E`-module and η ∉ O_E. Expect Task 0 to find the *vectors* in `Λ` and the *argument* using `ηΛ ≠ Λ`
  somewhere (rotation about a lattice point by η maps `Λ` to `ηΛ`).
- Part 1, chirality: Hubai's statement is "rotation by `k·arccos(5/6)` acts on colours as rotation by ±2πk/3"; rotations do not act
  on `Λ`'s colourings. It has to be restated through the couplings (a relation between adjacent layers' stripe data). Expect this to
  be the least finished part at round 1.
- Part 1, `8Λ` from the stripes: row 78 says `8/3` transports only to rank 2 on `Λ`; the read-off must go through `v = −(8/9)w`'s
  orbit, not through Hubai's word. Expect K1 (stripes only) to be reachable and `F ⊇ 8Λ` not by round 1.
- Part 2, "no" side: every quick "no" in `𝒰^tf` I can see is row 66 (a gapped target) — **which K3 excludes as G68 in disguise**.
  A real K3 needs something that is not a gap, a full-dimensional cell, or three-colourability. Expect the likeliest *false* passes
  to be (i) "every colouring is frozen" (T8), (ii) H6-type field lists (G68), (iii) a rank-1 "no" that is really FS79-T35 run on a
  finite range (T11).
- Part 2, "yes" side: **the killing test has no clause for a proved yes.** K1 is stripes, K2 is "F₄ ≠ 0 ⟹ X", K3 is "F₄ = 0". A named
  graph in `𝒞^tf₄` with `F₄ ≠ 0` by derivation — the plan's outcome (b) — is not a pass condition as written. Needs an owner ruling
  before any report arrives (card O-1).

**What in the record is unread or surprising for this question.**
- The coincidence 9,120 = Hubai's ring count = `Λ/8Λ`'s count: expected, since `R₂ ⊗ ℤ₂ ≅ O_E ⊗ ℤ₂` (1/3 ∈ R₂, ω₃ 2-integral) and
  `Λ ⊆ R₂` (w = 3ω₃ − 2, 1/9 ∈ ℤ[1/3] ⊆ R₂). **So `Cay(Λ,U)` is an induced-by-distance subgraph of the ring's graph: ring theorems do not
  restrict to `Λ`, and `Λ`-forcing transfers up to the ring** (to verify: `Λ ⊆ R₂`, by hand above, unchecked in sympy).
- The plan's controls are triangle-full; there is no triangle-free positive control anywhere (none exists — that is the question). A
  proved yes would be the first.
- G9/row 26: the 791-core's forced pairs at 4 and 4/√3 lie in `2R` — consistent with every known four-colour compulsion being 2-adic.

**Hunches registered with this expectation** — §3.

## §2. Evidence inventory

- the plan `plans/FS85-rigidity-without-triangles.md` — read against: the brief's summary of it — surprised: yes (the killing test
  has no clause for a proved yes; K3's exclusion of G68 also excludes H6's whole field list)
- `HELD-plan-advisor.md` (H1–H6) — read against: "guesses, frame-level H6 and H5-part" — surprised: yes (H6 is a correct *kernel*
  consequence of row 66 but, as a K3 argument, is exactly the G68 disguise K3 forbids — worth saying when it is offered)
- the protocol §0–§3 — read against: the brief's rules — surprised: no
- `~/source/library/notes/polymath16-coloring-R2-2018.txt` (the wiki), read in full — read against: "the held hand tools for step 1; P-wiki
  0.65; K1 reachable in a day if Task 0 is favourable" — surprised: **yes**. Prop. 7, Cor. 8 and Cor. 9 all assume a coset on which ρ is
  constant (2R₁-periodic, the residue case: 1 of Λ's 12 classes); Prop. 6 assumes ρ avoids a value; Lemma 4 is the two-valued case.
  Nothing excludes a 4-valued ρ, which the stripes (a two-valued ρ) of the 11 dirty classes need. Also, the page's c is a colouring of
  all of ℂ ((3) uses every e^{iθ}), not of the ring. The points Prop. 7 uses are R₁ + O_E·η² (in Λ, an O_E-module), and its
  comparisons are μ₆η, μ₆η², μ₆η³ (by (8), (9)), all in U, so P-wiki probably wins on its letter and is irrelevant to K1.
- `[Parts2020hv]` §§1–4 (pdftotext, `parts-hv.txt` in my scratch) — read against: "the hypothesis is his computer part, field unknown" —
  surprised: **yes**. His base graph G481 has coordinates (a + b√33 + ic√3 + id√11)/12; its 30 edge vectors are exactly μ₆·η^{−2..2} ⊂ U,
  and every point of the 29 orbit representatives captured from Table 3 (and their ζ₆/conjugation orbits) lies in Λ (exact, sympy,
  `chk_g481.py`). So "no monochromatic √3-triple" (787 tree nodes, human-checkable, found by his program) is a statement about a finite
  subgraph of Cay(Λ, U) and restricts to Λ; with his hand striping (Figs. 8–9) it gives K1's letter by citation. (18 of 481 vertices are
  in orbit rows my regex missed; not checked.) His coordinate lattice P itself is NOT in Λ ((1+√33)/12 ∉ Λ), but the graph's points are.
- held threads, Hubai 9 May / 3 June 2018 — read against: nothing yet — surprised: unread
- `data/fs73/table/TABLE.md` (the loose controls) — read against: nothing yet — surprised: unread
- de Bruijn's working file (read 16:22 and 16:30) — read against: §1 (expected: first route = "run the wiki on Λ") — surprised: **yes**.
  First route is Part 2 first: a generic (B₃) embedding of a finite triangle-free forcer into ℤ with a mod-4 colouring — the abstract
  yes in rank 1 (FS85-dB1–dB3). Task 0 done exactly: U = μ₆η^{[−4,4]}; P-wiki won (all 17 relations of Prop. 7 are differences in U);
  the wiki reaches only the residue class; Hubai's word = translation by 8/3 for starting points in O_E, premise = the uniform
  chirality; Parts's hypothesis marked "not a statement about Λ" (coordinates unchecked) — corrected by card C1.
- Coxeter's working file (read 16:22) — read against: §1 — surprised: **yes, the same way**. First route is Part 2 first with the
  same construction (super-increasing embedding, Mycielski minus an edge), "the abstract class is the wrong class"; Part 1 route:
  "kill the monochromatic √3-triple on Λ, then Parts's striping on each coset"; the wiki kept in reserve. Task 0 not yet done.
- **Convergence, measured:** both first routes (Coxeter ~16:10, de Bruijn 16:10, both before any contact) took the same Part-2
  construction and put Part 2 first. Priming (boat vs tango) diverged nothing in kind. P-converge-on-wiki killed (neither first route
  was the wiki's); P-priming-diverges-weakly confirmed in its strong form (not even order differed).

## §3. Hunch ledger

hunch: P-prod-products-make-the-abstract-yes-cheap (SUPERSEDED 16:25 — both competitors' generic embedding is simpler and complete;
  the product reduction stays a curiosity: every 4-colouring of G × H_dG is H-pulled-back or a hom G → N(H), never sent)
  claim: For `G = Cay(ℤ^a, S_G)` triangle-free, connected, `χ(G) ≥ 5`, and `H` = de Grey's lattice, `G × H = Cay(⟨S_G × S_H⟩, S_G × S_H)`
    is in `𝒞^tf₄`; every 4-colouring of it is either `c_H ∘ π_H` or comes from a homomorphism `G → N(H)`, `N(H)` the non-proper maps
    `Λ → [4]` in `K₄^H`; so `F₄(G × H) ⊇ ⟨S_G − S_G⟩ × {0}` whenever `G ↛ N(H)`.
    - derived parts: triangle-free (a triangle projects to `G`); `χ = 4` (El-Zahar–Sauer 1985 below, `H` above); every 4-colouring of
      `H` is gap-free (else `F(H) = 0`), so each looped vertex of `K₄^H` is adjacent only to itself, so a connected `G` maps either
      constantly onto one loop or entirely into `N(H)`.
    - such `G` exists: `Cay(𝔽₂^11, weight-8)` is triangle-free for `n < 3k` and contains `KG(11,4)` (χ = 5, Lovász), and its lift
      `Cay(ℤ^11, {x ∈ {0,±1}^11 : 8 non-zero})` contains it induced on `{0,1}^11`.
    - open part: `G ↛ N(H)`; for `H = K₄` it is Greenwell–Lovász; for sparse `H` it is a Hedetniemi-type (exponential-graph) question.
  basis: derived (the reduction); prior (that the open part is decidable either way this week)
  falsifier: a homomorphism `G → N(H)` for every triangle-free `G` with `χ ≥ 5` (then products give nothing); or a defect in the
    loop-isolation step
  registered: 2026-09-24
  status: open

hunch: P-K1-lands-the-coupling-step-does-not
  claim: at round 1, K1 (stripes on T₀) is met by at least one competitor, and `F ⊇ 8Λ` without the certificate is met by neither.
  basis: prior (the plan's P-wiki 0.65 and P-S1a 0.40; the row-78 remark that 8/3 transports to rank 2 only)
  falsifier: no K1 by 2026-09-26 18:00; or a written `F ⊇ 8Λ` derivation by then
  registered: 2026-09-24
  status: split at round 1's end (by: §8) — first half killed (K1 by derivation not met; only K1 by prior art), second half confirmed
    (F ⊇ 8Λ derived by neither; the coupling/chirality derived only conditionally on the certificate)

hunch: P-ring-proof-uses-eta-multiplication
  claim: some step of the wiki's Prop. 7 / Cor. 9, or of Hubai's word, uses a point or difference outside `Λ` even though η, η², η³ ∈ Λ
    (e.g. a rotation about a lattice point by η, or η·(non-O_E element)).
  basis: prior (Λ is an O_E-module, η ∉ O_E)
  falsifier: Task 0 by either competitor, checked by me, finding every point and difference of Prop. 7's proof in `Λ`
  registered: 2026-09-24
  status: killed for the wiki (by: my own reading of Prop. 7's proof — its points are R₁ + O_E·η², in Λ; its comparisons are μ₆η^k,
    k ≤ 3, via (8)–(9); competitors' Task 0 to confirm line by line). Hubai's word still unread. The error was mine: I reasoned from
    "Λ is not an η-module" without reading which points the proof uses; it never multiplies a general point by η.

hunch: P-K1-by-citation
  claim: at least one competitor reaches K1's letter by citing Parts's G481 trees restricted to Λ, not by derivation, by round 1.
  basis: read (G481 ⊂ Λ, above) + prior (strong minds take the nearest solid ground)
  falsifier: both round-1 reports without a Parts-restriction step, or one deriving no-mono-√3-triple without a case analysis
  registered: 2026-09-24
  status: confirmed (by: both round-1 reports — Coxeter takes Parts's stripes on |k| ≤ 2 layers as prior art; de Bruijn's stripes
    rest on the certificate + dB8; neither derives the √3-triple step)

hunch: P-converge-on-wiki
  claim: both first routes are "run the wiki on Λ" (the plan-phase advisor's convergence warning).
  basis: prior
  falsifier: either first route not the wiki's (e.g. a Part-2-first route, or an arithmetic route to stripes)
  registered: 2026-09-24
  status: killed (by: both first routes, 16:10 — Part 2 first, the same generic-embedding construction; they converged, but not on the wiki)

hunch: P-priming-diverges-weakly
  claim: the two first routes differ in order or emphasis, not in kind (FS-79's reading).
  basis: prior (one run)
  falsifier: the first routes differ in kind (different part, different discipline)
  registered: 2026-09-24
  status: confirmed, stronger than stated (by: the two first routes — same part first, same construction, same H, same mod-4 trick;
    Part-1 plans differ only in emphasis: de Bruijn via the wiki's residue case + chirality, Coxeter via killing the √3-triple)

hunch: P-soifer-equivalence
  claim: "some finite triangle-free UDG (any field) has a four-colour forced pair" ⟺ Soifer 55.1 has a yes; ⟸ by a generic-angle
    chain (m|δ| ≥ 1), ⟹ by a 5-critical triangle-free UDG minus an edge. So a 𝒰^tf yes is at least Soifer-strength.
  basis: derived (⟹ two lines; ⟸ rests on the genericity step both competitors only sketch)
  falsifier: a unit triangle forced across chained copies for every choice of angles (the genericity step failing)
  registered: 2026-09-24
  status: open (the ⟸ half); sent as a calibration note in card C1

## §4. Cards (sent and held)

question: O-1-does-a-proved-yes-pass
  evidence: plan §S.4 — K1 stripes, K2 "F₄ ≠ 0 ⟹ X", K3 "F₄ = 0"; outcome (b) "a graph with a proof" is not among them; hunch P-prod
  expected: a proved yes would be a pass
  ask: does a named 𝒞^tf₄ graph with F₄ ≠ 0, proved with its inhabitant, pass the killing test, and at what scope?
  if yes: scored Paid (abstract) unless realised in 𝒰^tf; I adjudicate it as a fourth clause
  if no: a yes would have to wait for round 2 and the fallback could fire on the strongest outcome
  answered by: Owner
  cost: one ruling
  rank: 1
  sent: 2026-09-24 to the owner — fate: pending

question: O-2-does-K1-by-citation-pass
  evidence: G481 ⊂ Λ with edges μ₆η^{−2..2} ⊂ U (exact, `chk_g481.py`); Part 1 "with no solver refusal"; § Toolchain's "never on a finite piece found by search"
  expected: the killing test measures derivational movement
  ask: does a K1 whose no-mono-√3-triple step rests on Parts's search-found 787-node trees pass K1?
  if pass: K1 is reachable in hours by citation, and the killing test measures reading, not derivation
  if not: K1 needs the no-mono-√3-triple step (or stripes) derived without case analysis, or the citation plus a derived coupling/8Λ step
  answered by: Owner
  cost: one ruling
  rank: 2
  sent: 2026-09-24 to the owner with my recommendation (not a pass alone; medium) — fate: pending

**Decision logged: H6 and H5's frame-level part are held until both first routes are written** (alternative: send early as frame-level,
the plan-phase advisor's suggestion). Reason: they shape Part-2 first routes toward a field list, and H6 as a "no" is G68 in disguise,
which K3 excludes, so nobody loses a pass by waiting an hour. Confidence medium.

question: C1-does-the-tight-dyadic-target-reach-F
  evidence: both first routes (16:10): the abstract yes by generic embedding; de Bruijn names ℚ(√59) and the dyadic K₄; held H5, H6;
    G54 (tight ⟹ forced in the tower quotient, P only); by compactness δ ∈ F₄ iff a finite piece forces
  expected: in 𝒰^tf the only live mechanism for a yes is arithmetic tightness, and the only live "no" invariant is not a gap
  ask: over ℚ(√59), is every four-colouring of a rich unit-distance lattice pulled back from the dyadic K₄ tower — does tightness reach F or only P?
  if F: 𝒰^tf has a yes (K4 at field scope), never chainable, Soifer-strength by P-soifer-equivalence; triangle-free premise falls to arithmetic
  if only P: the type-(B) "no" needs an invariant the tower cannot see; that invariant is §IQ's
  answered by: derivation
  cost: open; a day or more
  rank: 1
  sent: 2026-09-24 16:29 to BOTH, identical, with the held items H6, H5, H4, H2, H1 (my notes on each), the G481 ⊂ Λ transfer
    correction (frame-level), the convergence note and Kooshi's word — fate: pending

question: C2-which-rotations-of-G481-transfer (sent as a frame-level fact, not a question)
  evidence: `chk_g481_rot.py` (exact, all 481 points under the order-24 group): ηG481, η²G481 ⊂ Λ (and conjugates); η³G481 has 150
    points outside Λ, η⁴G481 has 342; edges μ₆η^{k−2..k+2} ⊂ U iff |k| ≤ 2
  expected: the citation might cover every triangular orientation in Λ
  ask: which orientation layers η^k·T₀ of Λ does Parts's no-√3-triple citation reach? (answered: |k| ≤ 2, five of nine)
  if a route needs |k| = 3, 4 stripes: they must be derived or reached from the |k| ≤ 2 layers
  if not: nothing changes
  answered by: record
  cost: done
  rank: 2
  sent: 2026-09-24 16:34 to BOTH, identical — fate: pending

**Held items offered: 16:29, both, identical, after both first routes were in their files** (checked by reading both files at 16:22).
H6 went with the others, not early (decision above); its note: as a "no" it is G68 in disguise.

**Kooshi's word (relayed by the owner, 2026-09-24):** "A proven theorem about why it's impossible is also valid. All novel knowledge is a
success." I score a proven no-go as a result in its own right, and I name to a competitor any lean toward "yes" because it scores higher.

## §5. Retraction tally (at round 1's end, 2026-09-24 ~17:05)

| who | count | what, and what killed it |
|---|---|---|
| de Bruijn | 0 | none recorded in his file |
| Coxeter (round 1) | 0 claims | two internal slips caught before any claim (a slow primality loop; a census comparison pinned at the wrong triangle, "188 of 380" → equal), never sent |
| Poros (me) | 0 sent | two unsent errors against myself (§7) |

**Reading (G51):** zero retractions of sent claims on all sides means the disagreement has not started. Both sides converged on Part 2
and on the wall in Part 1; nothing has been contested. Round 2 is where it can start: the two Part-1 frames (spectral locality vs
pair-linearity) aim at one statement from opposite sides.

## §6. Asymmetric-card log (read by both at hand-back)

- **2026-09-24 ~16:31, to de Bruijn alone:** my check of his K4 claim (FS85-dB2). Verdict: passes at the abstract scope; every step
  checked by hand (colouring t by formula; forced pair from χ(M(Gr)) = 5 only; λ = 4μ + t is B₃; FS85-dB1 item 3's two triangle
  cases; 4 ∉ D; D mod 4 = {1,2,3} ⟹ K₄ ⟹ F₄ = P₄ = 4ℤ). Also: FS85-dB3's wrap argument holds, prior art owed; the Soifer claim's
  genericity step and "same local plane at 2 as K" (per prime, not for K's two primes together) held to scope. Reason it went to one
  side: it answers his own route (protocol §3's rule). Coxeter's first route has the same construction, not yet written up; he will
  get the same check when he claims it.
- **2026-09-24 ~16:35, to Coxeter alone:** my check of his §2–§3 (C1/C1a: correct, meets K4 at abstract scope, F₄ ∋ δ = 120·7²¹ with
  F₄ ⊆ 4ℤ, exact F₄ not claimed; C2: wording overclaims — 3.6 is one question already answered NO by Bašić at k = 3, C2 is an
  extension to every k, prior art owed; C3(b): triangle-freeness needs genericity of cross-copy distances on the closing constraint
  surface, not only "copies meet at chain points"; C4: correct). Reason one side: it answers his own route.
- **2026-09-24 ~17:07, to de Bruijn alone:** his dB8 check request acknowledged and deferred (first item of the hand-off); dB7 verified
  exactly in PARI (`chk_db7.gp`); dB6's {0,1} lemma re-derived. Reason one side: it answers his own route.

## §7. My own errors, against myself

1. **P-ring-proof-uses-eta-multiplication** (never sent): I predicted the wiki's Prop. 7 would leave Λ because "Λ is not an
   η-module", without reading which points the proof visits. It never multiplies a general point by η; its points are R₁ + O_E·η².
   Killed by my own reading an hour later, and independently by de Bruijn's Task 0 (all 17 relations in U). Mechanism of the miss:
   reasoning from a true structural fact to a conclusion about an argument I had not opened (Collingwood: dug without a question).
2. **The abstract yes: I reached for the heavy construction.** My expectation's P-prod (categorical products, reduced to a
   Hedetniemi-type exponential-graph question) was correct as far as it went, but both competitors found in their first routes the
   two-line generic embedding (a finite forcer + a B₃ set + mod 4), which needs nothing. I had even written "translation invariance
   is the content" without testing it against the simplest embedding of a finite forcer into ℤ. Nothing was sent, so no one paid; the
   lesson is the plan's own §0.2 failure repeated by me: I did not ask whether a finite forcer already carries translation invariance
   for free (it does: a Cayley graph holds every translate of its finite subgraphs).

## §8. Killing-test adjudication (§S.4, with the owner's rulings 3 and 4, e61e3c4d) — WRITTEN 2026-09-24 ~17:05

*Round 1 ended under ruling 2 (both round-1 reports in). Read: both working files in full as they stood at 16:52 (de Bruijn's §"Part 1"
dB5–dB8, §PA-dB, theorems, logs; Coxeter's §2–§4, theorems, logs), the owner's checks (inventory items 47–48 as relayed: dB5 spectrum
recomputed, λ_min = −12 with multiplicity 42; dB6's hand step re-derived; C5 (⊆) recounted: 6 admissible π and 9,120 pair-linear
colourings), and de Bruijn's addendum message (dB8 derived).*

**VERDICT: the killing test PASSES, by K4 (ruling 3), at two independent derivations. It does not fire; FS-83 is not triggered.**

| clause | verdict | the check I ran |
|---|---|---|
| **K4** (a named graph in 𝒞^tf₄ or 𝒰^tf with F₄ ≠ 0, proved at F, with its inhabitant) | **PASS — both sides, abstract scope (𝒞^tf₄, rank 1)** | By hand, line by line (§6): de Bruijn's FS85-dB2, a triangle-free distance graph G(ℤ, D) with \|D\| = 70 and χ = 4, F₄ = P₄ = 4ℤ, exactly 24 colourings. Coxeter's FS85-C1/C1a, the same construction in base 7, with δ = 120·7²¹ ∈ F₄ ⊆ 4ℤ. Both use the Mycielskian of the Grötzsch graph minus one edge; the forced pair needs only χ(M(Gr)) = 5 (Mycielski). Both steps checked for each: B₃ or balanced-digit uniqueness, and "a triangle of G lifts to a triangle of H". The mod-4 colouring is checked, and the value F₄ = 4ℤ for de Bruijn's instance (4 ∈ F₄, F₄ ⊆ Per(x mod 4)). **Independence:** both constructions were in the first routes written at 16:10, before any contact and before the owner's disclosures, so the owner's item-49 error does not touch this clause. **Scope:** abstract only. It is not realised in 𝒰^tf, and it is not a field result (ruling 3; my duty 2). |
| **K1** (stripes on T₀ for every colouring of Cay(Λ, U), edges of Λ only) | **NOT met by derivation. Both sides hold "K1 by prior art" (ruling 4): a result, not a pass** | The stripes' load-bearing step is always a search-found finite case analysis. (a) Parts's 787-node trees on G481, which lies in Λ (my exact check `chk_g481.py`; for 5 of the 9 triangular orientations, `chk_g481_rot.py`), with his hand striping lemma. Both sides cite it. (b) For de Bruijn, also: row 78's certificate F ⊇ 8Λ (one 2,044-point solver refusal), then his hand classification dB5–dB8. (c) For Coxeter, also: (PL), which he holds only by census equality, i.e. the certificate plus the census enumeration. Neither side derives "no monochromatic √3-triple" or the stripes without one of these. |
| **Ruling 4, clause (ii)** (K1 by prior art plus a derived step beyond it: the chirality on Λ, or F ⊇ 8Λ) | **Not met by either side, on my reading of its intent; met by de Bruijn on its letter.** My call: not met. Confidence medium. | See the two paragraphs below. |
| **K2** | nothing claimed | — |
| **K3** | nothing claimed; its rank-1 option is now **refuted** by K4's graph | — |

**Clause (ii), de Bruijn.**
- His chain is: F ⊇ 8Λ (certificate) ⟹ dB6 locality ⟹ dB7 chirality ⟹ dB8 stripes.
  - dB6: every 8Λ-periodic four-colouring factors through O/𝔮³ for one prime 𝔮 above 2. This is Hoffman's equality case on the tight level-3 quotient, whose least eigenspace splits 21/21 by prime, plus a two-line {0,1} lemma. I re-derived the lemma.
  - dB7: η² ≡ ζ₃^{±1} mod 𝔮³, with the sign given by the prime. **Checked exactly in PARI** (`chk_db7.gp`): v_𝔭(ω₃ − ζ₃) = 3 and v_𝔭′(ω₃ − ζ₃⁻¹) = 3; control v(ω₃ − 1) = 0 at both primes.
  - dB8: every colouring of G₃ is a stripe pattern, derived by hand. **I have not checked dB8**; it is first on the successor's list.
- **So his chirality is derived, and holds given the certificate alone.** He needs no census: dB8 replaces the census read he had at 16:30.
- On ruling 4's letter, the certificate is the prior-art step and the chirality is derived beyond it, so (ii) is met.
- On its intent, it is not met. The ruling exists so that a citation passes only with derivational movement toward what the citation does not already give. Here the prior-art step *is* F ⊇ 8Λ, the end of Hubai's chain. Every derived step runs *downstream* of it (explaining the structure given the period), none *upstream* (toward the period itself).
- **What he did achieve is real, and is recorded as a result:** FS-73's classification of Λ's colourings (the census enumeration behind FS73-T7) is replaced by a derivation. The one search-found input left in "F = P = 8Λ with 12 classes, all striped, chiral by prime" is the 2,044-point refusal.
- Where triangles enter, per his account: only in dB8's propagation step. dB6 uses none.

**Clause (ii), Coxeter.**
- His chain is: (PL) ⟹ F = 8Λ (by linear algebra) ⟹ chirality, stripes per family, and "extends in exactly two ways".
- C5 (⊇) is derived with no search: 6 admissible π, 9,120 colourings, 8Λ-periodic. The owner recounted it.
- (PL) holds only by census equality, i.e. the certificate plus the census enumeration. **So his chirality holds given the certificate and the census.** He himself reports Part 1 as partial.
- **What he achieved, recorded as a result:** the certificate's content is reduced to one statement, (PL): "the pair index of every four-colouring is a homomorphism". (PL) implies F ⊇ 8Λ by linear algebra. His C6 records the negative that two families of striped layers do not force (PL).

**Why "not met", against the alternative "met on the letter".**
- The alternative I weighed: pass de Bruijn on ruling 4's letter. That would reward deriving consequences of a certificate as if it were movement toward it.
- The week's question is whether algebra reaches four colours *where search could not*. The one place search is still load-bearing, F ⊇ 8Λ, is untouched by both sides.
- **The call changes no verdict.** The test passes on K4 either way. It matters only for how the close describes Part 1.
- **The fact that would change my call:** you read ruling 4's clause (ii) as "any derived step that is not itself a case analysis", with the certificate allowed as premise. Then de Bruijn passes (ii), and Coxeter does not, because his (PL) also needs the census.

**Part 1's status for the close.**
- **Not landed:** F ⊇ 8Λ by derivation.
- **Landed:** both structure halves, each conditional on the certificate.
  - de Bruijn: locality, chirality and stripes, given 8Λ-periodicity.
  - Coxeter: 8Λ given (PL), and the classification (⊇) unconditionally.
- **The shared wall, found independently:** Cay(Λ, U) is not Hoffman-tight on the infinite lattice (de Bruijn's symbol minimum about −22.3, Coxeter's about −22.41, both below −18). So no averaging argument gives the period. Only the level-3 quotient is tight.
- **Round 2's single open target, the same for both:** derive F ⊇ 8Λ, equivalently (PL), without the certificate.

**Weighing the owner's disclosure (inventory item 49).**
- K4's independence is unaffected: the construction was in both first routes at 16:10.
- Part 1: Coxeter's non-tightness number (−22.41) and de Bruijn's (−22.3) differ, and each comes from its own tool (`spectrum.py` on each side). I see no sign of transfer in the files. Whether either side read the disclosed items is the owner's question to ask.
- **Recommendation on parity** (the owner's decision):
  - If neither side read the disclosed items, keep the fence.
  - If either did, share both round-1 reports symmetrically, whole, at this round boundary. The reports are complete, the abstract yes has already converged, and round 2's target is one statement both reduced to from opposite directions. What symmetric sharing costs is independence on round 2's attack on that statement: two independent hits on one wall is what licenses a no-go (G51).
  - Confidence medium. The fact that would change it: a side exposed to only part of the other's Part 1 (for example the non-tightness), where a targeted fence is cheaper than full sharing.

## §9. "Would have searched here" (mine)

- None. Every computation I ran was an exact membership or valuation check on given objects (G481's 481 points and their η^k
  rotations in Λ; η² − ζ₃^{±1} at the dyadic primes). My default was never a search: the ban constrained nothing I did as advisor.

## §10. Hand-off (for a successor; written 2026-09-24 ~17:10 at about 470k tokens)

**Who is who.** de Bruijn `aeccc63c28a91235e` (round 1 and continuing). Coxeter round 1 `aaa9cb185091cd964` (stood down at ~478k);
**Coxeter round 2 `a32c39090e6aa7052`**, same working file, preamble `…/fs85-comp-coxeter/ROUND2-PREAMBLE.md` (you may read it). Owner:
`main`. Working files: `…/fs85-comp-debruijn/FS85-C-deBruijn.md`, `…/fs85-comp-coxeter/FS85-C-Coxeter.md` — the only files of theirs
you may read. Hand-backs content-free; every report by SendMessage.

**Owner's disposition of the adjudication (2026-09-24, inventory item 51):** accepted; the test passes by K4 at two derivations; FS-83
not triggered. **Ruling 4 (ii):** the owner notes that the ruling as written named "the chirality stated on Λ" as a qualifying step, so
on the ruling as written de Bruijn meets (ii); my "upstream toward the period" criterion is recorded as the better one for the week's
question but is not applied after the result. The close describes Part 1 by what is derived and what rests on the certificate, not by
the label. **Parity:** both competitors answered "no" to the disclosure question (item 49); the fence stands, nothing shared.
**Staffing:** I stand down at the round boundary (~475k); the successor continues this record as its only writer, with the brief
(`BRIEF.md`) and the held-item file (`HELD-plan-advisor.md`, all items already offered) in this directory.

**Where the milestone stands (round 1 over).**
- Killing test: **PASSED by K4** at two independent derivations (§8). Rulings 3 (K4 = a proved yes) and 4 (K1 by prior art = result,
  not pass; passes with a derived step beyond) are in the plan's §R-review (e61e3c4d). My clause-(ii) call: not met by either
  (intent), met by de Bruijn (letter) — with the owner.
- Part 2: abstract class decided YES (rank 1, full rank, both sides). 𝒰^tf open; a 𝒰^tf yes is Soifer-strength (P-soifer-equivalence,
  genericity sketched on both sides). Live fields: type (A) ℚ(√47), ℚ(√167); type (B) ℚ(√59), ℚ(√83) (held H5/H6, sent). By-product
  on both sides: triangle-free uniquely k-colourable circulants for every k (prior art owed; 3.6 was answered at k = 3 by Bašić, so this
  is an extension).
- Part 1: the one open statement is **F ⊇ 8Λ ⟺ (PL)** without the certificate. de Bruijn: certificate ⟹ locality (dB6) ⟹ chirality
  (dB7) ⟹ stripes (dB8). Coxeter: (PL) ⟹ F = 8Λ by linear algebra; C5 (⊇) derived; C6 negative (two striped layer families do not force
  (PL); any local proof of (PL) must fail on F(t) + G(s) on Tri □ Tri). Shared wall: the infinite lattice is not Hoffman-tight.

**What a successor should do first, in order.**
1. **Check de Bruijn's dB8** (Lemma S: every colouring of the 64-vertex level-3 dyadic plane G₃ is striped): branch I's holonomy shift
   (−(e₀+e₁+e₂) + 3e₃ around r → r+1 → r+2 → r+3 → r, offsets o_{±1} = ∓1, o_{±3} = ∓3), and branch II's step from "the three lines
   through each point carry distinct pair-partitions" to "constant partition type per direction in each level-1 coset", then the affine
   functional equation and the complete-mapping obstruction on ℤ/4. He asked; I deferred it. The census gives the conclusion (4560 =
   3·1512 + 24 per prime), so a check is of the argument, not the statement.
2. **Check that C6's Tri □ Tri is the induced subgraph of Cay(Λ, U) on P + T₀ + ηT₀** (not done): whether any unit vector of U other
   than μ₆ and μ₆η lies in T₀ + ηT₀. If one does, F(t) + G(s) may be improper there and C6's "killing test for local proofs of (PL)" is
   on the wrong graph. Likely fine (η̄ and η² carry a 1/3), but unverified.
2b. **Then the round-2 target** (the same for both sides): F ⊇ 8Λ, equivalently (PL), derived without the certificate. Hold every
   claimed step to "upstream toward the period" in description (the owner's disposition: the close says what is derived and what rests
   on the certificate). Card (i) under item 5 is the one I would send first, to both at once, once each side's round-2 opening is written.
3. **Police round 2** on: (a) a "derivation" of F ⊇ 8Λ or (PL) that averages over Λ (fails: not tight); (b) the 2,044-point
   certificate or the census re-entering as a premise under another name; (c) the controls (ℤ[ζ₆], FS-73's loose CM-subfield table
   `data/fs73/table/TABLE.md`, rank-6 L3) — any route to (PL) must fail on them; de Bruijn's §Part 1 notes the controls' level-quotient
   tightness is unchecked; (d) Part-2 𝒰^tf claims: an H6-type "no" is G68 (does not pass K3); a Soifer claim needs the genericity step
   written on the closing constraint surface; (e) any lean toward "yes" because it scores higher (Kooshi's word, relayed).
4. **The disclosure (inventory item 49): closed.** Both answered "no"; the fence stands. Nothing to do unless new evidence appears.
5. **Round-2 cards to consider** (not sent): (i) the second question for both frames of Part 1 — de Bruijn's locality is 2-adic and
   uses no triangle; Coxeter's (PL) is where triangles must enter: *which of the two is the invariant, and can (PL) be stated at the
   level-3 quotient so that dB5's tightness proves it there?* (a real fork: if yes, (PL) on Λ/8Λ is free, and the gap is exactly "every
   colouring is 8Λ-periodic", i.e. the inheritance question P vs F at four colours, FS-76); (ii) C1 to both remains open (the ℚ(√59)
   question, parked by Coxeter).

**Files in my scratch** (`…/fs85-poros-comp/`): `parts-hv.txt`; `chk_parts_lattice.py`; `chk_g481.py` (G481 ⊂ Λ, full group);
`chk_g481_rot.py` (η^k·G481 ⊂ Λ iff |k| ≤ 2); `chk_db7.gp` (η² ≡ ζ₃^{±1} mod 𝔮³); `card-C1-both.txt`. The HELD file (all items offered).

**Hunch ledger status at hand-off:** P-prod superseded; P-K1-lands-the-coupling-step-does-not — K1 by derivation not landed (killed as
stated: K1 lands only by prior art), the coupling (chirality) derived conditionally on the certificate, F ⊇ 8Λ not derived (that half
confirmed); P-ring-proof killed; P-K1-by-citation confirmed (both sides use Parts/census for the stripes); P-converge-on-wiki killed;
P-priming-diverges-weakly confirmed strongly; P-soifer-equivalence open (the genericity half).

---

# ROUND 2 — the successor Poros (Opus 5.5), from 2026-09-24 ~17:15

*Written by the round-2 Poros, a fresh instance and now this record's only writer. Everything above this line is my predecessor's,
kept as written. Read before writing anything here, in this order: the preamble (`ROUND2-PREAMBLE.md`); my identity file
(`~/source/poros/CLAUDE.md`); the brief (`BRIEF.md`); this record's §10 first, then §1–§9; the plan's §0, §IQ, §S, §P and
§R-review (rulings 1–4 and Kooshi's reading). 17:15: one identical message sent to both competitors, saying the advisor was
replaced and the record continues.*

## §11. Round-2 log (kept as it happens)

**My expectation, written before reading either working file (17:17).**
- *dB8 (Lemma S: every proper four-colouring of the 64-vertex level-3 dyadic plane G₃ is striped).* The census already gives its
  conclusion (4,560 = 3·1,512 + 24 per prime), so what can be wrong is the argument, not the statement. I expect branch I's holonomy
  arithmetic to be right: it is a finite sum. If there is a gap, I expect it in branch II, at the step from "the three lines through each
  point carry distinct pair-partitions" to "the partition type is constant per direction in each level-1 coset". That step is a
  propagation, and propagations are where triangles and the 2-adic reduction get used without being named.
- *C6's graph.* I expect Tri □ Tri on P + T₀ + ηT₀ to be induced: the only unit vectors of U in T₀ + ηT₀ should be μ₆ and μ₆η. The worry
  is that some μ₆η^k with |k| ≥ 2 reduces into T₀ + ηT₀. Prior: 0.85 it is induced.
- *Round 2 in general.* Both sides aim at one statement, F ⊇ 8Λ without the certificate. The wall they share is that Λ is not
  Hoffman-tight, so no averaging argument gives the period. I expect round 2's first moves to try to get tightness on a quotient and
  then lift, which is exactly the inheritance gap (P vs F, FS-76). Hunch registered below: P-r2-lift.

**Round-2 hunch registered with that expectation.**

hunch: P-r2-lift
  claim: round 2's first moves on F ⊇ 8Λ get periodicity or tightness on a finite quotient, and the step left over is lifting from
    a quotient to all of Λ (P vs F) or from a slack quotient to the tight one (level 3)
  basis: prior (both round-1 frames stop at the non-tightness of Λ)
  falsifier: a round-2 derivation of F ⊇ 8Λ that passes through no finite quotient
  registered: 2026-09-24
  status: confirmed within the hour (by: de Bruijn's dB9, read 17:40: stripes ⟹ periodic with finite index, F ⊇ 1680Λ and P = F
    modulo gap A; what is left is gap B, the slack quotients Λ/L where the real colourings live). The P vs F half closed first, which I
    had not expected: the leftover is the slack-to-tight half.

### Checks done at the successor's opening (17:20–17:45)

1. **dB8 (Lemma S) — CORRECT, every step re-derived by hand.** My expectation put a gap in branch II's "constant partition type per
   direction". There is none: in a level-1 coset `C ≅ (ℤ/4)²` every row segment meets every column segment and every diagonal segment
   (row `b = b₀`, column `a = a₀`, diagonal `a + b = s₀`), so the three type functions have pairwise disjoint images in a 3-element set,
   hence singletons. Also re-derived: the line lemma (`C₈(1,3) = K_{4,4}`); the count lemma (x's 12 neighbours are the opposite segments
   of its three lines; the column and diagonal neighbours of one segment of a row tile the 32 points of the opposite-parity rows once
   each; with 4 neighbours in every other class, `N_j(opposite rows) = 16 − 4·#j(ℓ)`); propagation; branch I's holonomy (offsets
   `o_{±1} = ∓1`, `o_{±3} = ∓3`; total `−(e₀+e₁+e₂) + 3e₃` is `±2` exactly when `e₀+e₁+e₂ ∈ {1, 2}`; for constant `e`, the column or
   diagonal 2-lines `{a | i}`); branch II's `σ` distinctness; the functional equation (solutions affine mod 2 with one common slope);
   the missing complete mapping of `ℤ/4` (`Σ = 12 ≡ 0` against `6 ≡ 2`). Also checked the input: `G₃`'s least eigenvalue is `−4 = −12/3`
   (each line contributes `+4`, `−4` or `0` by the value of `⟨θ, ε⟩` mod 8, and three `−4`'s cannot occur together). Surprise against
   my expectation: none.
2. **C6's graph — CORRECT: Tri □ Tri is the induced subgraph on `P + T₀ + ηT₀`.** Exact (`chk_c6.py`, own arithmetic): of the 54 unit
   vectors exactly 12 lie in `T₀ + ηT₀`, namely `μ₆` and `μ₆η`. The control fires: `η² = 1 + (√−3/3)·η`, so `η² ∉ T₀ + ηT₀`. Prior 0.85.
3. **dB9 step 1 (the adjacent-coset direction lemma) — CORRECT, re-derived.** Two stripe patterns of `T₀` in different directions,
   matched pointwise. If the pair partitions agree, the matching forces `φ_n ≡ n + C` on each row parity, which is 2T₀-periodic. If they
   differ (each `Q_i` meets each `P_j` once), then on a column of even `m` the even rows all show one `Q₀`-colour, because
   `(n + ψ_m) mod 2` is constant there. That colour is in `P₀`, which fixes `φ` on both row parities (the same way at every column, and
   the odd columns agree), or it is in `P₁`, which constrains nothing. If no column fixes, the other coset is 2T₀-periodic. Either way
   one coset is residue-type. The rotation reduction to directions `{1, ζ}` is valid, since `ζ` preserves both the matching and the
   stripe form.
4. **dB9 step 3 (Smith forms) — CONFIRMED in independent code** (`chk_db9_smith.py`, own arithmetic, sympy SNF): the distribution over
   the 243 choices is exactly de Bruijn's: `(6,6,6,6)` 162, `(…,12)` 54, `(…,30)` 12, `(…,42)` 6, `(…,48)` 6, `(6,6,12,12)` 3.
   The owner checked the same independently.
5. **dB4's genericity step (Soifer's 𝒯 ⟹ 𝒮) — HOLDS for m ≥ 4.** The lemma that closes it: a trigonometric polynomial
   `Σ a_k e^{iα_k} + c` in angles that are independent on an open set has constant modulus there only if at most one of
   `{a_k} ∪ {c}` is non-zero (the cross terms must vanish). Every unwanted event between copies `j < l` is such a polynomial.
   - For `(j, l) ≠ (1, m)` it is in a proper sub-tuple of the angles, and the missing angle absorbs the closing constraint at a point in
     general position.
   - For `(1, m)`, substituting the closure `p_m − p₀ = e^{iψ}` gives a polynomial in `(θ₁, θ_m, ψ)`. These are independent when
     `m ≥ 4`, because the `m − 2 ≥ 2` middle sides flex.
   - The events that hold identically are exactly those with a single non-zero term of modulus 0 or 1. These are the chain points, the
     copies' own edges at a shared chain point, and the closing edge. Every other event is a proper analytic subset near a
     general-position point of `V`. Finitely many of them leave a generic point.
   - At `m = 3` the middle has one side, `(θ₁, θ₃, ψ)` lie on a surface, and the argument does not run. So `m ≥ 4` is the right
     hypothesis.

**Scope correction to my predecessor's adjudication (§8), counted as a Poros retraction (a sent claim, to the owner).**
- §8 said: "no averaging argument gives the period".
- What was measured: the uniform-weight ratio bound. Also, de Bruijn's own numerical probe over the five orbit weights (in his search
  log, a reading) found a best ratio of about 0.287 > 1/4, so ϑ-level averaging is dead as a reading.
- What is not refuted: joint four-class averaged formats (window frequencies, FS-80) and Schrijver-type strengthenings.
- Corrected sentence: **"no ratio bound, at any weighting of U's orbits, gives the period (uniform: exact finite sums; orbit weights: a
  numerical reading); stronger averaged formats are untested."**


**Asymmetric cards and checks sent in round 2 (mirrors §6; both read at hand-back).**
- **2026-09-24 ~17:48, to de Bruijn alone:** the verdicts on the three checks he asked for (dB8, dB9 step 1 with step 3
  re-computed, and dB4's genericity with the closing lemma). Also **card R2-dB1, on gap B**: are the non-tight L-quotients' characters
  below −d/3 mixed (2-part × odd part) or pure 2-part? If mixed, gap B is a product-rigidity statement: the Greenwell–Lovász shape, with
  FS-67 its three-colour form. If pure 2-part, it is a level-4 lift inside the 2-adic quotient. Hunch: mixed, 0.6. Falsifier: a pure
  2-part character below −d/3 on any of the 75. Reason it went to one side: it is about his gap B, his own route.
- **2026-09-24 ~17:49, to Coxeter (round 2) alone:** C6's graph verified induced (`chk_c6.py`). Reason: it answers his own route
  (the killing test his file names for local proofs of (PL)).

**Cards to both: none yet (decision logged).** I considered two and sent neither.
- **Card (i) from §10, rephrased.** The question: can (PL) be proved on the level-3 quotient by its tightness? Held. De Bruijn's
  dB5–dB8 already prove that quotient's classification, so the question is leading, with its answer settled in my head by his file.
  Sending it to Coxeter would carry de Bruijn's result, the tightness of Λ/8Λ.
- **A ϑ card.** The question: does some orbit weighting make Λ ratio-tight? Held. De Bruijn's own numerical probe (search log item 5)
  already reads about 0.287 > 1/4. To Coxeter it would be leading, and would spend his budget on a reading I know.
- **What I will send to both, when it comes:** only a question built from the shared record, after Coxeter's round-2 opening is
  written.

**Recognition for the close (to the owner, not a card).** The record's G54 calls its "middle case" (a slack quotient every one of
whose k-colourings is gap-free) "logically open and unobserved" and lists it as a killing test. Λ/16Λ at four colours is such a
quotient: it is slack at uniform weights (16-torsion finite sums), and by row 78 every colouring of it pulls back from the tight Λ/8Λ,
so every one is gap-free. The same holds for de Bruijn's 75 non-tight L-quotients (his gap B). **So the middle case is observed, on
de Grey's lattice**, and gap B is exactly the case G54 has no mechanism for.

## §12. Round-2 hand-off (kept current; last updated 2026-09-24 ~17:55, about 70k tokens used by the successor)

- **Done:** §10's items 1 (dB8) and 2 (C6's graph), both correct. dB9 step 1 correct and step 3 confirmed. dB4's genericity closed for
  m ≥ 4. One retraction logged (the scope of §8's averaging sentence). The owner has the status and three close items (G54's middle
  case observed; the retraction; de Bruijn's search-log items 5–6).
- **Where the competitors stand:**
  - **de Bruijn:** dB9. From Parts's stripes (prior art) every colouring is periodic, F ⊇ 1680Λ and P = F, modulo gap A.
    Gap A: one residue-type T₀-coset ⟹ a single Φ on T₀ + η²T₀; dB10 then spreads it. Gap B: the 75 slack L-quotients. He is on one
    more stint closing gap A, with a stop rule (owner). Card R2-dB1 on gap B is with him.
  - **Coxeter (round 2):** started ~17:00. Nothing written past the round-2 banner at 17:45. Target in his State: derive (PL).
- **Next:**
  1. Read Coxeter's round-2 opening when it lands.
  2. Then decide a card to both. It must be built from the shared record only: no dB5 tightness, no dB9, no 16-torsion number.
  3. Police any gap-A closure. In particular, a single Φ must not be obtained by re-pinning per coset, which is the wiki's recolouring.
  4. Hold every "F ⊇ 8Λ" claim to gap B's status.
- **Consistency fact (mine, unsent).** In C5's family a T₀-coset is residue-type only when h is 2-periodic on ℤ/8, and those
  colourings are exactly the residue colourings: 144 counts = 48 × 3, matching the 96 overlaps. So in every census colouring, one
  residue-type coset implies the global residue colouring. Gap A's target is true on the census, which is consistency, not proof.
- **Update (owner, ~18:00):**
  - de Bruijn has stood down under his stop rule: gap A was closed by FS85-dB11, and gap B set aside by the owner's ruling. Send
    nothing further to him. Card R2-dB1's fate: answered by nobody. Gap B is open, with the close.
  - A blind verifier is checking dB9–dB11 and the combined statement P = F ⊇ 1680Λ. I do not check dB11.
  - My remaining duties: police Coxeter's round 2, and send him the round-2 question once his opening is written.
  - Budget: about 392k by the harness counter at this update, so the successor rule (replace near 500k) is close. Stay lean, and
    keep this §12 current.
  - At 18:00 Coxeter's round-2 section holds only its banner.
- **Fence disclosure (Coxeter round 2, ~18:10; the owner asked that it come to me as well).**
  - What leaked: the harness's opening git-status snapshot showed him commit 00263ab5's subject line, which summarises de Bruijn's
    round-1 report — the chirality as the choice of prime above 2 (dB5–dB7), and Λ/8Λ tight with λ_min = −12 and multiplicity 42.
  - He opened nothing fenced.
  - He declares his round-2 identification of his two chirality classes with the two primes not independent. The rest of his route
    is his own.
  - Consequence for scoring: the chirality-as-prime identification counts once, as de Bruijn's.
  - Consequence for my cards: Coxeter now knows the level-3 quotient is tight, so a card mentioning that tightness no longer leaks
    it. It would still be leading if it asked him to re-derive dB6–dB8, so it stays held.
  - The mechanism: a subject line summarising results is the covert channel. The fence's "do not read git log" does not cover the
    snapshot the harness injects. For the close inventory; the owner has it.
  - **The owner's ruling (inventory item 59).**
    - Anything of Coxeter's that overlaps dB5–dB7 is not independent.
    - Anything beyond is scored on its merits, with the influence noted.
    - His route, as the owner relays it: equitable layers, then a 42-character support by Smith form, then uniform chirality by
      tetrahedron splitting.
    - Watch in particular: the 42-character support is dB5's own number, read from the subject line. His Smith-form route to it
      counts only as far as it is derived without that number as a target.

### Coxeter's round-2 opening (read ~18:30, R2.0–R2.8), checked

- **Read against:** my expectation P-r2-lift and §12 (expected: a quotient-lift route, like de Bruijn's). **Surprised: yes.** His route
  is spectral on Λ itself: no-monochromatic-√3-triple in family k (NT_k) ⟺ the linear identity `A_k g = −2g` for the tetrahedron-valued
  `g`. That confines `supp ĝ` to the torsion set `Θ_K`, and a finite support gives periodicity. It is a different mechanism from
  de Bruijn's coset coupling.
- **R2.2 (the one he most wants checked) — CONFIRMED EXACTLY in independent code** (`chk_c8.py`, my own arithmetic and sympy's
  Smith decomposition, every one of the 3^|K| systems solved exactly, none of them positive-dimensional):

  | families | \|Θ\| | orders | dual-group invariants | period lattice |
  |---|---|---|---|---|
  | all nine | 42 | 2, 4, 8 | (8,8,8,8) | exactly 8Λ |
  | −3..3 | 378 | 2, 4, 6, 8, 12, 24 | (24,24,8,8) | Λ/P ≅ (ℤ/24)²×(ℤ/8)², ⊇ 24Λ |
  | −2..2 | 7290 | 2, 4, 6, 8, 10, 12, 24, 30 | (120)⁴ | exactly 120Λ |

- **R2.1 re-derived.**
  - The hexagon's consecutive differences are `ζ^{j+2}η^k ∈ U`.
  - A colour used three times on a proper C₆ sits on alternate vertices, a √3-triple whose centroid is the lattice point x.
  - `mT = 0` confines the support of a distribution T to the zero set of m.
  - A bounded exponential polynomial with distinct frequencies has constant coefficients.
- **R2.3 re-derived.** Tetrahedron splitting holds: the 12 directed edge vectors of a regular tetrahedron are pairwise distinct. So
  Theorem R is sound given NT_{±3} and NT_{±4}, and **Corollary U (F ⊇ 120Λ from G481's NT_{|k|≤2}) is sound**: prior art plus a
  derived step upstream toward the period.
- **Independence.**
  - The chirality-as-prime identification is flagged by him and ruled not independent (item 59).
  - **The number 42** was in the leaked subject line as dB5's multiplicity. His 42 is the output of an exact solve that cannot be
    steered, and I reproduced it, so the computation is independent. The *identification* of Θ_all with dB5's least eigenspace, if he
    makes it, is not.
  - Corollary U overlaps nothing fenced.
- **For the close: two independent derivations that every colouring of Cay(Λ, U) is periodic (P = F on Λ), from one prior-art input
  (Parts's G481).**
  - de Bruijn: coset coupling, F ⊇ 1680Λ, gap A closed by dB11, under blind verification.
  - Coxeter: spectral support, F ⊇ 120Λ, exact.
  - Different mechanisms, one conclusion. The 8Λ step is open on both sides: de Bruijn's gap B, and Coxeter's NT_{±3}, NT_{±4}.

question: R2-C1-does-properness-along-the-outer-families-kill-the-extra-spectrum
  evidence: Corollary U puts every colouring's spectrum in Θ_{−2..2} (7290 characters, exact, `chk_c8.py`). R2.5 says any proof must
    use the family-±4 edges. Properness along an edge u gives `Σ_θ |ĉ_θ|² cos 2πθ(u) = −1/3` exactly (the average of
    `⟨g(x), g(x+u)⟩` over Λ/120Λ). The hexagon symbol ranges over [−3, 6], so −2 can be met on average off Z_k.
  expected: closing to 8Λ needs NT_{±3} and NT_{±4} as new local statements (his R2.4)
  ask: do the 54 pair-correlation equalities, with weights w_θ = |ĉ_θ|² ≥ 0 on Θ_{−2..2} and Σw = 1, force w onto Θ_all?
  if yes: F ⊇ 8Λ follows from G481's NT_{|k|≤2} plus properness alone, and the dual multipliers are a kilobyte certificate readable
    as an identity. Theorem R's conclusions then hold with no NT_{±3,±4}: Part 1 is derived modulo Parts's trees.
  if no: second moments cannot see the gap. A feasible w off Θ_all names the weights the 3- and 5-parts would need. The next
    instrument is higher-order: tetrahedron-valuedness beyond pair correlations (his splitting lemma, generalised to
    Λ/8Λ × Λ/15Λ), or NT_{±3,±4} directly.
  answered by: derivation (an exact LP whose shape Corollary U and properness fix; dual read back as an identity; logged either way)
  cost: hours
  hunch: yes, 0.4
  falsifier: an exact feasible w with weight on a character outside Θ_all
  rank: 1
  sent: 2026-09-24 ~18:40 to Coxeter alone (de Bruijn has stood down; it is on Coxeter's route). Logged in the asymmetric list.
- **§12 update (~18:45; about 424k by the harness counter).**
  - Coxeter's opening has been checked, card R2-C1 sent to him, and the owner told.
  - Open for a successor: R2-C1's fate. If Coxeter runs the LP, check its dual identity exactly: multipliers y_u with
    Σ_u y_u(cos 2πθ(u) + 1/3) ≥ 0 on Θ_{−2..2}, zero exactly on Θ_all. Watch whether the positivity is checked on all 7290 characters.
  - Police any use of the fenced 42 as an identification.
  - Hold Theorem R to "conditional on NT_{±3,±4}" unless R2-C1 or something else closes it.
  - Retraction tally in round 2: Poros 1 (the scope of §8's averaging sentence); de Bruijn 0; Coxeter 0.

**R2-C1's fate (~19:00): answered NO by Coxeter (his R2.11). I verified the witness exactly (`chk_r2c1.py`).**
- θ₁ = (11/12, 1/2, 7/12, 7/12) lies in Θ_{−2..2}, with λ_k = −2 for |k| ≤ 2 and A₃ = A₄ = 3 − 2√3 < 0.
- 96 order-6 characters of Θ_{−2..2} have A₃ = A₄ = 3 (for example (1/6, 2/3, 1/2, 5/6)).
- Weights 1 : (2√3 − 3)/3, averaged over the point group, satisfy all 54 equalities. Both characters are off Θ_all, whose orders are
  2-powers.
- His reduction is right: for point-group-invariant w the per-u equalities are orbit sums over families ±m, automatic for |m| ≤ 2 on
  Θ_{−2..2}.
- His stronger probe, the U+U inequalities R(v) ≥ −1/3, still finds bad weight. It is float and uncertified, marked so by him.
- **Hunch killed:** my "yes, 0.4". The branch taken: second moments cannot see the 3- and 5-parts. The next instrument is higher-order,
  or NT_{±3,±4} directly, which is the route his R2.10 is already on.
- The card changed his move only by closing an alternative, which is informative but cheap.
- **A result for the close: an averaged-format no-go on a named graph.** On Cay(Λ, U), pair-correlation (radius-1) averaged
  certificates cannot lift F ⊇ 120Λ to 8Λ. This is exact, with an explicit witness. It narrows G73's open "averaged" format for this
  lattice: the radius must be above 1.
- **Also read.**
  - R2.9: the 64-vertex quotient is Cay(T₀/8T₀, μ₆ ∪ 3μ₆), which is de Bruijn's G₃ (5μ₆ = −3μ₆), reached independently. His count
    9·512 − 48 = 4560 matches de Bruijn's 3·1512 + 24 per prime.
  - R2.10: under NT_{±3}, the family-±4 edges force uniform chirality across Λ₇'s 9 cosets. Not checked (budget).
- **§12 update (~19:05; about 432k).**
  - The owner has been told R2-C1's fate and the no-go.
  - Next: read Coxeter's round-2 report when it lands, then write the final report: the cards of both rounds, the take/decline table,
    the retractions, the errors, the verification priorities, and the token count.
  - If R2.10 needs a full check, hand it to a successor rather than cross 500k.
  - **Hunch ledger, round 2:**
    - P-r2-lift: confirmed.
    - R2-dB1 (mixed characters, 0.6): unanswered, since de Bruijn stood down.
    - R2-C1 (yes, 0.4): killed.
  - **Errors against myself, round 2:**
    - (1) I drafted a ϑ card before reading de Bruijn's search log, which already held the reading. Caught before sending, and
      nothing was sent. Mechanism: I built a card from the adjudication's sentence rather than from the competitor's file.
    - (2) R2-C1's hunch leaned yes without my pricing whether the hexagon symbol's spread could balance at second order. Coxeter's
      convex-hull reduction settled it in minutes, and I could have run that reduction before sending: an unpriced branch.
- **Owner (~19:10):**
  - Budget plan agreed; no-go logged.
  - Coxeter is on one more stint, on R2.10's patchwork problem only. Stop rule: solved; reduced to one named lemma; about 450k
    context; or 2026-09-28 18:00.
  - **My duty for that stint: police his ban compliance.** The patchwork problem is finite, so the pull to enumerate it is strong.
    At his report, look for any enumeration of patchwork configurations or quotient colourings, and read his search log against it.
  - Then the final read and the final report.

## §13. Final section (round 2 over; written 2026-09-24 ~19:40; about 440k by the harness counter). A successor or the close starts here.

**State at the end of the competition (both competitors have handed back).**
- **Part 2:** the abstract class is YES in rank 1 (K4, both sides, round 1). 𝒰^tf is at Soifer 55.1 (dB4 / C3). dB4's genericity
  step is closed for m ≥ 4 by the constant-modulus lemma (§11 item 5).
- **Part 1, P = F on Λ (every four-colouring periodic):** two independent derivations from one prior-art input, Parts's G481
  (no monochromatic √3-triple in the families |k| ≤ 2, transferred into Λ):
  - de Bruijn: coset coupling, F ⊇ 1680Λ (dB9–dB11). The blind verifier has it.
  - Coxeter: spectral support, F ⊇ 120Λ exactly (C7, C8, C10).
- **Part 1, F ⊇ 8Λ:**
  - Coxeter reduces it to ONE named statement, the **5-part lemma** (every colouring is 24Λ-periodic). C15, the alternate-triple
    lemma, derives the whole 3-part and both outer orientation classes. The owner checked C15.
  - de Bruijn's form is gap B (the slack L-quotients), set aside.
- **New no-go:** on de Grey's lattice, pair-correlation (radius-1) averaged certificates cannot lift 120Λ to 8Λ. This is C14, with an
  exact witness verified by me (`chk_r2c1.py`).
- **Ban compliance, round 2:**
  - Coxeter's search log items 6–10 are honest. C15 was reached without enumerating the finite patchwork (item 10).
  - Borderline, for the close: C14's HiGHS float probe over the U+U inequalities. It is a float LP of a derived shape, not read back
    as an identity, and it is marked uncertified by him.
  - De Bruijn's items 5–6 are with the owner (a numerical weighted-bound optimisation, and a 31-subset sweep he logged as a breach).

**Retraction tally, both rounds.**

| who | round 1 | round 2 | what, and what killed it |
|---|---|---|---|
| de Bruijn | 0 | 1 | "ℚ(√59) has the same local plane as K² at 2", withdrawn: K has two places above 2, ℚ(√59) one (his own catch) |
| Coxeter | 0 claims (2 unsent slips) | 0 (R2.10 step 2 superseded by C15, not retracted) | — |
| Poros | 0 sent (2 unsent errors, §7) | 1 | §8's "no averaging argument gives the period": only the uniform, then the orbit-weighted, ratio bound fails |

**Reading (G51).** Two retractions across four agent-rounds. The disagreement never started, because the two sides never contested each
other's claims: they converged in round 1 and diverged in kind in round 2, each on its own ground. **The verification phase is where
disagreement has to start.** The two P = F derivations share one input, and that input is where to look first.

**Errors against myself (both instances).**
- Predecessor, §7:
  - (1) the η-module prediction, made without reading the proof;
  - (2) reaching for categorical products over the two-line embedding.
- Predecessor, sent: the averaging overgeneralisation in §8, retracted.
- Mine, §12:
  - (1) drafting a ϑ card from the adjudication's sentence before reading de Bruijn's search log (caught, unsent);
  - (2) sending R2-C1 with an unpriced hunch, where Coxeter's convex-hull reduction settled it in minutes.

**Hunch ledger, final.**
- P-prod: superseded.
- P-K1-lands-the-coupling-step-does-not: split.
- P-ring-proof: killed.
- P-K1-by-citation: confirmed.
- P-converge-on-wiki: killed.
- P-priming-diverges-weakly: confirmed strongly in round 1.
- P-soifer-equivalence: the ⟸ half is now closed for m ≥ 4, so confirmed as derived.
- P-r2-lift: confirmed.
- R2-dB1: unanswered.
- R2-C1: killed.

**What a verification phase should check first.**
1. **The shared input, first, because both P = F chains rest on it:** that Parts's G481, all 481 vertices transcribed from the paper,
   lies in Λ, with its η^k-rotations for |k| ≤ 2, and that its trees prove NT at the centre.
   - My predecessor's first pass matched 463 of 481 vertices (its regex missed 18 orbit rows). The later check, `chk_g481_rot.py`,
     covers all 481 as transcribed.
   - The transcription from pdftotext against the paper's Table 3 has never been checked by a second reader.
   - A transcription error there is invisible to every downstream check.
2. **de Bruijn's chain:** dB11 (gap A's closure), which only the blind verifier has seen. Then the stripes input (Parts's human
   striping lemma, MASCOT-T10). dB9 step 1 and dB9(c) are each checked independently (by me, and dB9(c) by the owner too).
3. **Coxeter's chain:** C7's analytic step written as a stand-alone lemma (a bounded function on ℤ⁴ whose Fourier transform has finite
   support is a trigonometric polynomial). Then C15's odd-index step (Λ_K + 8Λ = Λ). C8 and C14 are checked exactly by me, and C15 by
   the owner.

**The 5-part lemma as the next target: yes, and I would pose it structurally.**
- *Existence form:* is some colouring's spectrum weighted on the 48 order-10 characters?
- *Structural form:* classify the tetrahedron-valued functions on Λ/40Λ whose spectrum lies in Θ_{−2..2}'s 2-part + 5-part.
- The order-10 characters are π/2 + θ₅, and they are exactly the non-chiral part. Here 5 is inert in ℚ(√−3) and split in
  ℚ(√−11), and de Grey's unit vectors are the torus of 𝔽₂₅ mod 5, a five-chromatic residue target (G69).
- *Reading, labelled:* the 5-part lemma has the same shape as my R2-dB1 card on de Bruijn's gap B. Both ask whether a sparse product of
  the tight 2-adic quotient with a factor that is not four-colourable has only the colourings pulled back from the tight factor. That
  is Greenwell–Lovász's shape, with FS-67 its three-colour form.
- Second moments are out (C14). So the instrument is pointwise: a generalisation of Coxeter's tetrahedron splitting to a sign-twisted
  sum G(a) + ε(a)H(b). Killing test: a four-colouring of the 5-family graph with order-10 spectrum; checking that would be a search, so
  not this week.
