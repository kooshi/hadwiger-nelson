# Engineering standard
@DEBRUIJN.md

# Workflow
@WORKFLOW.md

# This workspace — lean-dir

A Lean 4 proof workspace aimed at one target: **the Hadwiger–Nelson problem**. We write theorems,
programs, and tactics to the **de Bruijn** standard (above) and work milestone-by-milestone through
WORKFLOW. Everything reduces to what the kernel checked plus what we explicitly chose to trust.

## The mission

How many colours does the plane need so that no two points at distance exactly 1 share a colour?
Known since 1950 to be 4, 5, 6, or 7. De Grey (2018) ruled out 4 with a 1581-vertex unit-distance
graph that is not 4-colourable. Our ratchet:

- **A. χ(ℝ²) ≥ 4** — the Moser spindle. Small, classical, and it exercises the entire pipeline
  end to end. ✅ Landed.
- **B. χ(ℝ²) ≥ 5** — de Grey's graph, kernel-certified. ✅ Landed (M06–M09), on axioms exactly
  `[propext, Classical.choice, Quot.sound]`. **The write-up is deferred indefinitely** (Kooshi,
  2026-08-02): a formalization of a known theorem is no longer news, and reproducing one is
  nearly free. It exists as our foundation, not our product.
- **C. The search instrument** — the infrastructure from B turned outward: shrinking, criticality,
  fractional bounds, fans, the narrowing sweep, the growth-family hunt. ✅ Built through M17.
- **The upper end, for completeness** — χ(ℝ²) ≤ 7, the classical hexagonal/brick
  colouring, kernel-certified at M36; with rung B the repository holds the whole
  classical interval **5 ≤ χ(ℝ²) ≤ 7** on the standard three axioms. Not new
  mathematics — it exists because the certificate machinery is the promotion path
  for any future periodic avoider, and an avoider at five colours IS the open
  upper-bound problem.
- **D. χ(ℝ²) ≥ 6** — the hunt. May not exist; may be astronomically large. Every rung below it
  pays regardless.

**The mission, restated 2026-08-02: this project is exclusively a hunt for new mathematics — no
matter how small — ratcheting toward major findings.** Formalizing known results is over as a
goal in itself; a formalized statement earns its place by being *structure nobody had named*
(however elementary) or a rung toward χ ≥ 6. The live state of the hunt is § Frontier below —
**updated at every milestone closing**, without exception.

State failure modes plainly and keep the ratchet honest: a rung that does not land is reported as
not landed, not quietly rescoped. **All write-ups and upstreaming are deferred until something
lands that is worth the time and effort to publish** (Kooshi, 2026-08-04) — this covers the
rung-B write-up, Mathlib contributions, and any exposition; the deferral is standing policy.
**The trigger, sharpened (Kooshi, 2026-08-10, on the literature check that found the field
converging):** mathematics everywhere is accelerating and nothing minor will get read — so the
publication bar is exactly two events: *maybe* our own certified 5-chromatic object, if what it
reveals is interesting enough (his call at that point); *definitely* χ(ℝ²) ≥ 6 or its
refutation. Nothing below that bar is written up, however novel the rung.
**THE TRIGGER FIRED 2026-09-08, for one result, on a third ground the bar did not anticipate (Kooshi: "Theorem B
does look like it's publishable. Stub the writing of its draft as its own milestone").** The ground is not size and
not novelty of method: it is that the library read (FS-18) found **the same question posed three times across fifty
years by groups who do not cite one another** — Benda–Perles's Open Problem 11.6 (circulated 1976, published 2000,
recorded in `[Soifer2024]` ch. 11), `[Moorhouse2010]` §1 ("We have not determined the exact value of χ(K²) in this
case"), and `[CranstonRabern2015]` in Combinatorica ("What about its chromatic number?") — and `χ(ℚ(√3,√11)²) = 4`
answers all three, kernel-checked. **The bar is therefore amended, not abandoned: a result that answers a question
the literature has independently and repeatedly posed clears it, whatever its size.** The milestone is FS-20,
`plans/STUB-theorem-B-writeup.md`, and it carries a first-class naming deliverable — every working term in this
repository is coined in-house and appears in no paper, which is the exact mechanism G49 says hid the prior art, so
the manuscript's vocabulary is a design problem with a ban list, not a finishing touch. **The deferral stands for
everything else**, including the rung-B write-up, Mathlib contributions, and the M58–M61 sieve arc.
**The goalposts moved (Kooshi, 2026-09-06, at the M58 close; `plans/PROGRAMME-ALGEBRAIC-PROOF.md` holds his words in full and
the assessment of what each side needs):** *"The derivations are an order of magnitude more important than individual objects
… If we find a 6 chromatic object, we should use it as a stepping stone for the algebraic reasoning behind it and then we'll
write that up instead. … when we find that reasoning, we'll also spend some time attacking the upper bound with these same
approaches. … I believe we can provide the algebraic proof of the Hadwiger–Nelson problem in its entirety with a few more
weeks or months of work … The strength in our approach is that we've discovered the intrinsic nature of the problem."* So the
trigger now fires on a DERIVATION: a 6-chromatic unit-distance graph is the first instance of a mechanism, the milestone that
finds it continues until the mechanism is stated and proved for a class, and the paper is the algebra with the object as its
example; after the lower bound the same viewpoint is turned on the upper bound, and the aim is one account of the whole problem.
**The assessment, so it can be pushed back on:** the lower bound is the side the viewpoint is built for (every upper bound we
hold on a field plane is a residue argument at a small prime, and a forcer is a construction that hides its field from every
small prime — the finite-plane lift, M59, is a direct attempt at the mechanism); the residue methods as they stand are
structurally one-sided and cannot reach the upper bound (a field with no small usable prime receives no bound from any finite
plane, and the 𝔭-adic colourings do not glue across fields), so "the same approaches" must mean the viewpoint — the arithmetic
of small primes governs the chromatic number — and not the tools. That is where the ratchet actually is.

See `ARCHITECTURE.md` for the module DAG and the milestone roadmap; `plans/` for per-milestone
subplans.

**The bibliography is explicit and maintained (Kooshi, 2026-09-06): `BIBLIOGRAPHY.md`.** Every external
work this project cites, reproduces, depends on, or corrects is an entry there — added the day it is
first used, with what of ours rests on it, where our copy is (`~/source/library/`), and how much of it
has actually been read. A ledger row or grokking that rests on prior art names its bibliography key.
Titles seen only in search listings are marked as such until checked against the paper.

## Frontier

*The current state of the art, the ledger of everything novel this project has produced, and
the live paths forward. Maintained as part of every milestone's closing commit (WORKFLOW
step 9); a milestone whose close does not update this section is not closed. The
UNDERSTANDING the results add up to — the mechanistic picture we build on — lives in the
sibling section § Grokkings below, under the same maintenance rule.*

**Last updated: 2026-09-09 (fifth entry of the day) — THE CONSOLIDATION RAN IN SIX PARALLEL WORKTREES, AND THREE OF THE SIX PACKAGES OVERTURNED THE PLAN THEY WERE HANDED.** On Kooshi's *"handle as many as we can in git workspaces in parallel"*: FS-24, FS-25 and FS-26 were partitioned into six non-colliding packages, run concurrently, and merged. **The union builds green with the axiom audit at 794 clean and exactly 5 declared purchases** (from 725/5 — sixty-nine newly audited public theorems and no new trust bought), 50 commits, four new modules, +1594/−208 lines of Lean. **The prize landed: every finite Euclidean plane at a prime `p ≡ 3 (mod 4)` is forced-pair-free at every colour count it can achieve** (`PlaneRotation.lean`, ledger row 60), where the record had four tables — so G48's tightness mechanism, which takes *"the plane at `p` is `k`-forces-free"* as a hypothesis, stops firing only where somebody has solved a plane by computer. **And the way it landed is the entry's real content, because FS-25's own headline sprang the trap FS-25 was written to catch**: *"at every prime and every colour count"* overclaims twice — planes at `p ≡ 1 (mod 4)` are not covered, and at a colour count the plane cannot achieve the statement is **FALSE rather than merely empty**, since "forced" holds vacuously when no colourings exist. The shipped theorem takes colourability as a hypothesis and carries the counterexample (`p = 3, k = 2`) beside a positive inhabitant. **The step the plan flagged as most likely to bite — an orbit–stabiliser count over the `(p+1)/2` circle-missing lines — turned out UNNECESSARY** (one quarter turn moves the period line); what resisted was the hypothesis nobody flagged. **The vacuity sweep came back CLEAN on its headline question** (FS-26): no second `core9_plane` exists, the known-empty family has exactly two members, both already corrected — a real negative, recorded at the same standard as a positive. It found three other things instead, none a false statement: **`core122_pigeonhole` rests on a premise nothing in the library establishes** (nothing shows its 122-point graph has any four-colourings at all — and if it has none, this project owns a 122-point 5-chromatic graph four times smaller than the record and does not know it; FS-27 §1); **Theorem A's headline form has no user or example anywhere**, so the sentence a reader of FS-20 will quote is the one branch nothing has exercised; and the mechanism behind the September incident, now checkable in advance and minted as **G30's seventh failure mode**. **Three packages overturned their instructions and were right to**: P2 found E4's planned input — the recorded critical edges — has **no witness on disk**, and replaced it with a 1-sum argument needing no solver; P5 discharged its own named risk in three minutes and then reported its headline relaxation as **a repackaging, not a strengthening**, in the module rather than a footnote; P3's obligation pass caught a statement that *"would have built clean, passed the audit, and said nothing"*. **The generalizations' own reasons came out sharper than the stub's**: G1 (`transport_pair` off `ℂ`) matters because over the plane at four colours its conclusion is about an EMPTY collection — the generalization moves it out of the vacuous regime, it does not merely make it convenient — and the classical name for what the plane has and a number-field plane lacks is *two-point homogeneous*; G2 met its honest test with `FieldWall4.lean` getting SMALLER (1398 → 1392) and found that two of its steps had the WRONG mechanism recorded (the cancellation is an ideal absorbing a unit, needing nothing of the target ring); G4 makes `χ(ℝ²) ≥ 7` from two six-colour gadgets **typeable for the first time**, and gives `χ(ℝ²; {1,2}) ≥ 6` from a single `√3` gadget — the μ-dial's target, which had no kernel statement linking it to the hex shell at all. **P3 also declined two generalizations on correctness grounds** (the `≤ 2` critical-vertex bound is FALSE once radii are free) and recorded the dual of the vacuity rule: **a generalization can LOSE a hypothesis the special case was getting for free**. **One correction to this file, and it is P1's own finding recurring inside the batch that named it**: the M60 narrative paragraph still carried *"the sealing planes at 3, 7, 11, 19 are ALL pairwise free"* after ledger row 55 had been corrected — a correction reaching the ledger and not the prose summarising the same milestone, with nothing in the gate comparing them. Fixed in place, measurement kept. Remainders are ranked as **FS-27**; **M62 (FS-6) is untouched at rank 1 and none of this is the hunt**. The prior entry follows. — 2026-09-09 (fourth entry of the day) — CONSOLIDATION: FOUR AUDITS, NINE CORRECTIONS IN PLACE, AND THREE STUBS.** On Kooshi's *"secure our current position"*: the Lean sources, the measured-but-underived record, the grokkings' labels and the repository's consistency were each audited. **Nine errors are fixed in place** — the sharpest being that **G1's headline sentence, *"the 5-forcers need √5 and √7"*, is FALSE and this file had already refuted it twice** (G27 measured that Heule-510 has no `√7`; G37 records a published 5-chromatic graph in `ℚ[√3,√11,√247]` and our own witness there, so even the disjunction fails — the criterion is an odd square class ≡ 7 mod 8, and `√5`/`√7` was a sample of three). **Three stubs at ranks 2–4**: FS-25 (six measurements that are theorems, led by *every finite Euclidean plane is forced-pair-free at every prime* — which is the hypothesis G48's mechanism currently takes on faith per prime), FS-24 (seven theorems narrower than their own proofs, led by a homogeneity theorem stated over `ℂ` that a `K`-caller cannot even state), and FS-26 (the vacuity rule run backwards over 725 declarations). **G30 gains a sixth failure mode: a correct instance recorded where a theorem was available** — true, and therefore invisible to every gate. The clean bills are worth recording too: all 176 cited artifact paths exist, all 443 cited identifiers resolve, the trust ledger is an exact three-way match on all five declared purchases, and there are zero live `sorry`. The prior entry follows. — 2026-09-09 (third entry of the day) — THE PRIOR-ART WEB (FS-23): A SEVENTH LINEAGE FOUND, AND IT IS A WIKI NOBODY INDEXES.** `[Polymath16wiki]`, *Algebraic formulation of Hadwiger-Nelson problem*, **last edited 4 June 2018**, 404 on the live site and read here through the Internet Archive, contains — without proofs — the Cayley reframing, *linear* colourings (= Fischer's additive ones), the periodic quotient, **Theorem A's three-step recipe**, a table of eight rings × six colour counts in which the **Moser spindle ring is 4-colourable with all 4-colourings periodic of period 8**, the statement that **`8/3` has the same colour as zero** there, the **`√247` spindle over it** giving a ring with no 4-colouring (M53's T20, eight years early), and **the half-spindle group derived by UFD factorisation** (`ζ₆^i η^j`, `η = (√33+i√3)/6`) where M30 measured it — plus a generator `α = (√5+i√11)/4` our four-generator list does not have, which is the likely real explanation of G8's "SAT-shrinking scars". Rows 26, 47, 57, 59 and grokking G8 are amended in place. **The theorem is untouched: every ring on that page has `ℚ`-rank ≤ 4 and `K²` has rank 8** — `[Madore2015]`'s `4 ≤ χ(K²) ≤ 5` stood for eleven years and Theorem B closes it — **but FS-20's framing changes from six lineages to seven, and the seventh is a wiki, which is a stronger instance of the paper's own thesis rather than a weaker one.** FIVE PAPERS ALSO READ, AND TWO MORE LEDGER ROWS CORRECTED. **AND FS-20'S NOVELTY CHECK IS NOW COMPLETE**: all eighteen Polymath16 threads (1,673,859 characters, 2018–2026) were fetched and searched — the Theorem B question is **posed there on 2 May 2018 in our exact notation** (*"it would be nice to decide if the chromatic number of this subfield is 5"*), is **never answered** (every 4-colouring result there is about the rank-4 *ring*, never the field plane), and **"Fischer", "Moorhouse" and "Vinh" occur zero times** in the whole corpus — G49's two-literatures thesis as a table rather than an argument.** The seventh lineage is the **Moser-lattice community** — Rényi Institute plus the Polymath16 blog — which works with this project's own direction ladder under that published name and whose existence no search of ours had touched. Two corrections follow from it. **(1) Ledger row 59's identification half is `[Ducz2026]` (10 June 2026), three months before we proved it**: an integral *geometric* 4-colouring of the Moser lattice whose properness criterion is `N + M ≡ 0 (mod 4)` on `|z|² = (N + M√33)/6` — the same law in coordinates, reproducing ten for ten of the published data we explain. What stays ours is delimited in the row: the field-level statement over `K²` (rank 8, not his rank-4 ring), the valuation formulation, the **compulsion** consumers, and the kernel proof — and the row gets *stronger*, because `[Heule2021]` **asks for this theorem in print** and the law now sits inside a classification conjecture supported by every published data point. **(2) The cell family (rows 34–37, 39; G22–G24) was studied from the dual direction in 2022 by `[deGreyParts2022]`**, whose `d(k)` table agrees exactly with our band boundaries at three points and whose `d(6) < 1` is our `≥ 7` floor; what survives is the arbitrary-label generality, measured precisely — on the G\* band their best coset colouring needs **twelve** colours where an arbitrary cell-constant one needs **seven**. Also landed: `[Heule2019]` names `ℚ[√3,√11]` in 2019 and states pigeonhole × kill as a design principle (G15); `[Parts2023]` opens the tiling literature; `[Agoston2026]` does **not** bear on the μ-dial and says why; and a live opportunity for the paper — `[MatolcsiEtAl2025]`'s `G27` lies in `K²`, so if their amenability step survives restriction to the `K`-preserving isometry group then `χ_f(K²) = 4` and Cranston–Rabern's *first* question closes too. Nine bibliography entries added, five read. The prior entry follows. — 2026-09-09 (second entry of the day) — THE MASCOT OBSTRUCTION GENERALIZED AND THE 2-ADIC LAW OF FOUR-COLOUR COMPULSIONS KERNEL-CHECKED (ledger rows 58 amended and 59).** The obstruction is now HOST-GENERIC — a host graph with no `k`-clique draws no minimal forcing gadget at `k` colours, the clique number the entire hypothesis — and the threshold is sharp in both directions: no `k+1` points of the plane force a pair at any `k ≥ 4`, and at `k = 3` the rhombus DRAWN is the minimal gadget. And the law: **over `K = ℚ(√3,√11)`, a pair forced monochromatic at four colours lies at a distance inside the prime above 2, and a virtual edge at a distance outside it** — which proves both columns of `[Parts2020a]`'s Table 1 cannot be swapped, explaining a computer-found pattern the paper does not remark on, and explains M53's rigidity dial. **With it came a correction to our own record**: `core9_plane` and `core122_plane` (M34's plane corollaries at √3 and 2) are VACUOUS — rung B makes the type of four-colourings of the plane empty — so the companion duality the valuation-law stub carried is retracted, the emptiness is now a theorem (`isEmpty_coloring_plane_four`), and the non-vacuous replacement over `K` is stubbed with its sketch. The carriers and their pigeonholes, which are M34's actual content, are untouched. The prior entry follows. — 2026-09-09 — THE MASCOT CHALLENGE CLOSED AS AN IMPOSSIBILITY (ledger row 58, kernel-checked): the Moser spindle's recipe — minimal forcing gadget, hinged, closed by a rotation — works at exactly one value of `k`, because the plane's clique number equals the colour count at three colours and falls below it thereafter. Three corrections came with it: M53's T20 novelty claim is retracted (`[ExooIsmailescu2019]` had `ℚ(√3,√11,√247)` in 2018), FS-20's "verified open" check is flagged incomplete (a FOURTH independent posting of the Theorem B question, in Discrete Comput. Geom., cites Madore and asks it three lines later), and two new stubs are minted (`STUB-four-colour-valuation-law`, `STUB-sqrt7-phase-pinning`). The prior entry follows. — 2026-09-08 (second entry of the day) — THE LIBRARY WAS READ (FS-18), and it corrects the record in five more places while discharging one conditional and answering two more of other people's stated open questions. The corrections: M56's `1/k` obstruction (L7) is [Fischer1990]'s own Theorem 10(ii); the finite-plane bound has a THIRD independent source, [Manturov2012], held here unread since 2026-09-05; the cell family's `≥ 7` floor (M37–M43) is subsumed by [SokolovVoronov2025]'s `χ_poly(ℝ²) = 7`, whose title sat in our own bibliography §C under a note correctly guessing so; `ω ≤ 4` on every finite plane and the triangle-free criterion are [Vinh2006]; and `ω ≠ χ` on every finite plane above `p = 3` is [SchneiderSilva2013] Thm 4.7(3). The discharge: [Voronov2023] was read and proves exactly what M43 said it does, so G24/G29's conditional is now unconditional. The answers: Theorem B answers **Benda–Perles Open Problem 11.6** (via [Soifer2024] ch. 11) and **[CranstonRabern2015]'s stated question**, in addition to Moorhouse §1 — three independent postings of the same problem. All marked in place below. The earlier entry of 2026-09-08 follows. — Theorem B and Theorem A both kernel-checked (the backlog's B1, then the general residue colouring), and a PRIOR-ART CORRECTION that reaches four ledger rows. Moorhouse (2010) contains the finite-plane bound and χ(UD(𝔽₁₁,2)) = 5; Fischer (1990) contains the component lemma and the unit argument. The corrections are below, marked in place. What survives is stated as plainly as what does not.**

### Where the problem stands

χ(ℝ²) ∈ {5, 6, 7} (de Grey 2018 for ≥ 5; the hexagonal 7-colouring for ≤ 7). This
repository holds a kernel-certified χ(ℝ²) ≥ 5 on axioms exactly
`[propext, Classical.choice, Quot.sound]` (M06–M09). Above that: every published witness
and every growth family we built has been swept with certified or exhaustive negatives
(M15–M17); distance-to-confinement (`minCov`) is pinned to the rainbow floor of 3 at all
6,173 pivots ever examined, and M19–M20 turned the pin into theorems: the cover set alone
is always 3-colourable (M19), one pivot's *whole* system is exactly 4-chromatic (M20),
and extension pressure in the plain closure is exactly zero. **The 5th colour provably
requires structure spanning more than one pivot** — so M21 went to two and found the
hunt's first nonzero gradient: at the closure's strongest-coupled pair, 52% of pattern
pairs die on the cross chords alone and 32% of the survivors are killed by the ambient
graph (verified, null flat). M22 named the pressure's shape and made the geometry
fully general. The **gluing classification is now certified for any two circles in
the plane** (`Glue.lean`): distinct centres plus the annulus condition give exactly
{an explicit glue point, its mirror under ratio-conjugation reflection}, empty outside
— the statement every partner adjunction and every metapivot coupling instantiates.
The **first certified near-relation** landed: nine seam steps miss one hex step by
chord < 1/50 and provably never close (θσ is incommensurate — the loops are
almost-cycles forever, so only *colour* closure is live). The kill census named the
mechanism: outer-circle constraints are necessary in every ambient kill, inner in
75%, and greedy cores are 4–8 pins (median 6) leaning inner — a clamp specification
for gadget design. And the partner web is nearly closed already: two thirds of all
unit-partners collide back into the lattice, k = 4 stays SAT through two closure
generations (~10⁶ triage edges) — **depth will not force the χ fork; new structure
will**. M23 built the structure: the pivot triangle (0, 1, ζ₆) with its metapivot
(the centroid) is now a certified layer — the triangle is **self-glued** (each
pivot is the outer∩outer glue point of the other two), the whole 8-circle object
crosses itself in exactly 34 points inside the seam field, the cross-web between
unit-separated systems is **classified** (outer–outer chords are rigid: the
translation matching is complete; inner–inner chords are a rational Möbius
graph; the √disc field growth lives ONLY in mixed-radius chords), and the
**seam hexagon** — the minimal closed loop of seam rotations, which provably
needs all three pivots — is kernel-checked, as an instance of a rotation-hexagon
identity that turned out generic. The registered statistics cut the other way,
and are reported at face value: M22's post-hoc "seam-aligned kill mechanism"
**failed its registered replication at four fresh pairs (0/4)** and is demoted
to single-pair anecdote; the coset census came in under threshold; and the
triple-kill census's registered population is provably EMPTY (unit triangles are
never "far" — their systems always interlock through the shared glue points, the
ten-point theorem operating on the instrument). What survived everything:
ambient kills are **gated by coupling strength** (0/3,200 draws at 22 cross
chords; 12–15% at 40), and the constraint-flow skeleton the triangle uniquely
owns is now exact mathematics awaiting its colour question. M24 (re-planned on
Kooshi's go into the completeness milestone, roadmap M24–M29) answered at the
pair: the **matched ladder pair** — the countable ⟨ζ₆,σ⟩-lattice on both
pivots' four circles, closed under every unit chord — has **chromatic number
exactly 4, unconditionally**. Every chord family is now a theorem rather than
a census window: outer–outer is matching-or-hub, inner–inner is matching plus
exactly ten explicit solutions, outer–inner is exactly sixteen chords ever (no
infinite family), the intra families are exactly the hex/rot3/seam steps, and
the eight fusion points are pinned — so M23's conditional verdict is now
closed, and the 5th colour provably needs MORE than the full two-pivot
countable lattice. The engine is new and elementary — clearing by √3-powers
into ℤ[ζ₆,π] (π = √3σ, π² = π − 3), separation on √3 ∉ ℚ(ζ₆,π), coordinate
congruences mod 3, and a trace-pair telescope from the π-power recurrence; the
registered π-adic valuation sketch was superseded by less machinery, not more.
M25 climbed the first rung of the construction ladder: the **four-ladder
object** — the ⟨ζ₆,σ⟩-ladders of all three pivots 0, 1, ζ₆ PLUS the
metapivot's own ladder (anchored along ζ₁₂), closed under all unit chords —
has **chromatic number exactly 4, unconditionally**. The registered ζ₁₂-ring
engine was superseded by LESS machinery, exactly as M24's valuation sketch
was: one identity, **√3·ζ₁₂ = 1 + ζ₆**, collapses every meta-axis web
equation into M24's ℤ[ζ₆,π] trace pairs — the twelfth root never enters the
arithmetic. All twelve pivot–meta chord families are theorems (oo/io/ii: four
sporadic chords per web, all at |b| ≤ 1; oi: the hub pencil through the fused
pivot plus four sporadics; the three webs one theorem via the 120° transport).
And the **fusion inventory came free**: a point coincidence is the same
cleared equation at norm 0, so each fusion classification is the chord run at
a shifted constant (oo 4→7, oi/io 2→5, ii 0→3√3) — oo/io/ii fusions are
EMPTY and the oi fusion is exactly the other two pivots, certifying M23's
"the metapivot couplings create no new points" at the lattice level. M26
climbed the second rung: the **hexagram** — the six pivots of the hexagon of
circumradius 1/√3 about the metapivot (the M23 triangle PLUS its mirror
image, i.e. the mirror centroids promoted to pivots), each with its full
⟨ζ₆,σ⟩-ladder, plus the metapivot's own, closed under ALL unit chords — has
**chromatic number exactly 4, unconditionally**. The finds that made it
land: the object is **self-seeding** (the six pivots ARE the metapivot's
inner hex layer at seam height zero, `hexPivot a = m(1+ζ₆^a)`, so M23's
glue-point certification became address bookkeeping); the 60° rotation
about the metapivot is an automorphism cutting the 21 centre pairs to FOUR
orbits, so only TWO master webs were ever new (adjacent and opposite); and
both clear through `g = 1+ζ₆` into ONE master identity whose two singles
are both g-traces — M24's engine, again with LESS machinery. The new webs
carry exactly sixteen sporadic chords (adjacent oi/io/ii and opposite oo,
four each, |b| ≤ 2) and NOT ONE new coincidence — every fusion family is
empty, the triple tangency at the metapivot invisible, so the mirror
triangle glues to the original exclusively through the points M23 named.
The colouring is rot6-**equivariant** (colour ∘ rot6 = τ ∘ colour for a
3-cycle τ fixing colour 3 — the first colour symmetry of the hunt), and
the census instrument that checked it caught two real bugs in the standing
tool by its own automorphism control. The 5th colour now provably needs
more than the full seven-ladder, six-fold-symmetric countable hexagram.
M30 opened the new field with the anatomy of the 5-forcers, and the
measurements redrew the map. The **field-wall thesis is now kernel-checked**
(`FieldWall.lean`: ρ·σ² = −1, so the Moser twist is ζ₆³σ⁻² — inside the seam
group). The 1581's complete direction inventory is just **67 classes**, and
the registered group ⟨ζ₆,σ,ρ₁₅,ρ₆₃⟩ holds only 58% of the edges as whole
words — but every missing direction SQUARES into it, and the true group is
the **half-spindle group ⟨ζ₁₂, σ, √ρ₁₅, √ρ₆₃⟩** (√ρ₁₅ = (√15+i)/4,
√ρ₆₃ = (3√7+i)/8), which closes all 67 at exponent ≤ 6 — de Grey's own
half-angle frame, re-derived from pure edge data. Heule's 510/553 are NOT
pure de Grey-group objects (6 residue direction classes each, ~10 edges);
the only pure-group witness is the 1581. The concentration bet died at face
value: 819 circles about one centre, 4,140 coarse classes, top-6 = 3.7%
(registered ≥ 70%), flat direction head — and the matched control deflated
the load-bearing census entirely: **de Grey's graph is at or near
edge-critical** (single random edge deletions flip it 4-colourable), so the
5-forcing is distributed, not organ-like. The new rigidity instrument
(complete forced-pair + virtual-edge sweeps with three-outcome honesty,
validated red/green on every control) reproduced M13's forced pair and found
what M13 never looked for: de Grey's 791-point forcer forces **six** pairs —
the known axis pair at distance 4 plus **five antipodal pairs at distance
4/√3** (not spindle-able in the field; needs √183): every proper 4-colouring
of the forcer is centrally symmetric on the radius-2/√3 circle. A forced
colour symmetry, where M26's equivariance was chosen. The 2-adic risk is
confirmed exact ((1+i√15)/2: x² = x−4; (1+i√63)/2: x² = x−16), and the
anatomy visualizer (`tools/degrey-viz.html`) renders all three witnesses
with per-class toggles and the forced-pair overlay.
M31 opened the coupling theory one field up, and the theory arrived BEFORE
the instruments: the **quadrature law**, derived a priori in the registered
subplan and then verified at 26 exact censuses with zero violations — a
detuned copy of seam-field material couples to its base ONLY along
anchor-collinear pairs (full spindles) or anchor-perpendicular pairs (half
spindles) on one explicit radius conic, and detunes mixing the √15- and
√7-families couple nowhere at all. The measured consequences: the mitotic
hexagram (the certified organ plus one detuned copy, every anchor ×
generator at B ≤ 2) is χ = 4 throughout with coupling ≤ 12 chords — G6's
single-detune causal candidacy is dead; the de Grey pair couples through
exactly 6 seam chords (four of them through the seam-conjugate point
(1/√3)·σ̄ that Heule's coordinates carry) plus the one predicted (2,2)
centre spindle chord; the conic's solutions include the **conjugate-ring
channel** — ℚ(√33)-conjugate rings at (17∓√33)/6 coupling through ρ₁₅ —
the first mechanism connecting the witnesses' ring spectra to the coupling
web; and the certified hexagram holds hex-ray material at exact distance 2
from its pivots, the same Eisenstein 1+1 step de Grey's fabric spindles on.
The witness-closure measurements: gen-1 half-spindle closure of the 1581 =
24,065 points, 123,134 unit chords, 11,016 rings about the origin (P6's
band missed low — the object is even more lattice-like than 819 suggested),
k = 5 SAT in 1.14 s (no jackpot), and the k = 4 frontier — plain AND
gen-1-enriched balls — 4-colours everything through 1,200-committed scale
in seconds: **enrichment does not shrink the forcing; the 5-mechanism is
irreducibly global at this order** (the registered failure clause fired as
a finding, the third independent measurement of G10). And the rigidity
postscript: Heule-510 minus its centre is 4-colourable with ZERO forced
pairs and ZERO virtual edges, settled completely in 6 seconds — one vertex
below criticality there is NO pairwise rigidity shadow at all.
M32 ran the designed-forcer probe and took the kill engine to the kernel.
The **stacking law** was derived a priori and confirmed at every census
point: same-anchor stacks never escape the single-word law's thinness;
same-word stacks at DIFFERENT anchors open a translation channel that is
O(n)-wide exactly at unit anchor separation (the arithmetic reason de
Grey's construction has two centres) — and our triangle pivots provide
unit anchor pairs natively; the pivot↔metapivot separation 1/√3 is
provably sterile (the admissible-length discriminant picks up √59). The
census hit every prediction: 132-chord exact translation matchings at unit
anchors, zero at 1/√3, chirality-pair channel exactly empty. And then the
FLAT verdict, all the way down: the matching is 1-regular — **width
without degree carries no colour pressure** — and even the triangle stack
(three copies at the three unit-separated pivots, whose three matchings
compose into 26 forced-rainbow unit triangles spanning the copies — the
hunt's first designed triple-order cross structure) reads zero forced
pairs, zero virtual edges, zero coverage movement, zero compelled
triples, χ = 4 everywhere. The irreducibly-global finding now extends to
designed one-family objects (fourth independent measurement); the design
thread closed honestly and M33 is Route A. The Lean ascent landed beyond
its registration: `Quadrature.lean` (zero sorry) holds the 2-adic
engine's first theorems — `sqrt5_indep` by a division-free mod-5 descent
(one 625-tuple ZMod-5 kernel decide + strong induction on the ℓ¹-norm),
the `sqrt15_split` workhorse, `sqrt_indep₈`, the geometric
`quadrature_rho15` (M31's law G12, ρ₁₅ instance: a unit chord against a
detuned copy forces the collinear pin AND the conic), and the distance-2
pair's tangency anchor — with every linear_combination witness
sympy-derived and verified to zero residual before Lean stated it, all
landing first try. The distance-2 pair web is measured complete in a deep
window (14 address chords, no height growth, = M31's 6 genuine + 8
through the single fusion), its completeness the first M33 engine target.
The coverage/triple meters and the stack machinery joined the standing
instrument suite; the closure explorer gained the stacks tab.

M33 ran the mechanism hunt and the golden question got its first real
answers. The a priori criticality factorization (fan(G−v, N(v)) ⟺
χ(G) ≥ 5 at any vertex — two sentences, derived before any query)
re-aimed the sweep: the 4-onset is a criticality echo, measured exactly
so at all three centres probed (510's fan at the last ring in 9 s; the
1581's second centre by direct UNSAT; its origin capped honestly and
closed by the factorization + the kernel χ ≥ 5). The live structure is
below the top rung, and it is SMALL: the 3-cover core — the minimal
ambient web forcing three colours onto Heule-510's 36-point circle — is
**49 vertices = the circle + 13 interior points** on three named shells
((7−√33)/6, the inner circle 1/3, (9−√33)/6), 1-minimal with every
necessity witness held. And the class-avoidance instrument (one SAT call
per (region, pattern class), the disjunctive query the instance meters
were provably blind to) found the pigeonhole: **the seam fabric cannot
stay clean at distance 2** — every proper 4-colouring of the certified
hexagram chunk at seam depth B = 2 (378 pts), of de Grey's bare fabric
stage past r² = 2 − √33/9, of Heule-510 past the GLUE SHELL r² = 5/3,
and of the 1581 past the same fabric radius (identical onset to nine
decimals — the spindles neither create nor move it) makes some
distance-2 pair monochromatic. Distance 2 is the ρ₁₅ spindle distance
(4·2² − 1 = 15): the pigeonhole lives in the seam field, its kill lives
one field up — G15's two-act anatomy measured, with Act One shrunk to a
**122-vertex 1-minimal core** (de Grey's L was 121) in 12 near-rot6
shells about the metapivot, confirmed in two independent encodings. The
√3 story inverted honestly: mono-√3-triples (de Grey's paper class) and
√3-pairs are CLEAN on every object at every sub-full radius — except
√3-pairs on the FULL 1581, onset at the √21-shell (33−3√21)/8 where the
second spindle system's material arrives: the assembly creates that
pigeonhole and Heule's SAT-shrinking discarded it while keeping d = 2.
Controls: the 791's six forced pairs, the M20 skeleton (the kernel
theorem reproduced by instrument), the id-shuffle, the planted gadgets —
all red/green; one instrument fix mid-milestone (first-occurrence
palette breaking, registered §0i before reruns). The P12 gate is OPEN:
next is Act One as a kernel theorem (LRAT on the 122-core, a CNF a
fraction of the 1581's size over an object whose geometry M26 already
certified).

M34 took Act One to the kernel, and the two-act theory produced its
first designed 5-chromatic object. The general layer
(`Pigeonhole.lean`): the **bridge** — a class-avoidance refutation IS
ordinary non-colourability of the pair-augmented edge list, so the
entire certified SAT chain applies verbatim, zero new trusted code; the
**transmuter** — the five-vertex forcing inside the nine-core (centre's
rainbow triangle + hub ⟹ hub forced to the transfer rim's colour,
decided at 4⁵ with all nine hypotheses certified load-bearing by one
mutation-audit decide), whose forced transfer crosses plane distance
exactly 2, the ρ₁₅ spindle distance — the √3 pigeonhole manufactures
d = 2 forced pairs inside its own gadget; and **A1 unconditional**
(`not_colorable_iff_covers`: χ(G) > k ⟺ every k-colouring of G − v
covers N(v) — the modeling pass found the colourability hypothesis was
interpretation, not mathematics). The carriers are kernel theorems:
`core9_pigeonhole` (two transmuters composed through one rim–rim edge,
no search; geometry at denom 512; the six pairs kernel-certified as ALL
√3-pairs among the nine) and `core122_pigeonhole` (a 12,578-line pinned
LRAT on the augmented list, replayed across 16 segments in minutes;
geometry at denom 12 in the seam sub-basis; the forty pairs
kernel-complete over 14,884 checks) — with the plane corollaries: ~~**no
proper 4-colouring of the plane avoids monochromatic pairs at distance
√3, nor at distance 2**~~ — **struck 2026-09-09 (FS-26): those two
corollaries are VACUOUS, because rung B makes the type of four-colourings
of the plane empty, and this narrative sentence still stated them as
results four weeks after ledger row 31 was corrected. The correction had
reached the ledger and not the prose that summarises the same milestone.
What stands is the milestone's actual content, below:** the compulsions
classical/Haugland-adjacent, the 1-minimal carriers and the kernel
formalizations ours — and the carriers are the part that says something,
since they quantify over four-colourings of a finite graph that has them. All on
axioms exactly `[propext, Classical.choice, Quot.sound]`. The census:
the forty d2 instances fall into **FIVE congruence classes** under the
exact order-12 dihedral group about the metapivot (which preserves the
chunk exactly), every endpoint on named shells — five kill theorems
price the width budget. And the union: the 9-core plus six 791-forcer
kill chains (forced-equal at 4/√3 + one unit edge each) —
**4,749 vertices, χ ≥ 5 by composition**: monolithic CDCL capped at
3600 s (a composition is invisible to clause learning), while the six
"which pair goes mono" cubes — cover soundness carried by the KERNEL
pigeonhole — each refuted in ~800 s. The two-act assembly reading (G15's
last [reading] half) is measured TRUE at the pair level; the union's
exact geometry (the chain rotations pick up √23) is the priced deferral,
and the certified-union milestone now has a measured shape. Lessons
banked: the M06-era `degrey_graph.json` and the standing loader are
different vertex orders (the forced-equal control caught the mix — a
union SAT verdict explained, not believed); palette symmetry costs
6.5–35× solver time, re-measured twice.

M35 ran the two-sided 6-programme, and both sides returned their honest
verdicts. Phase 1 — the k = 5 class-avoidance sweep, the question no one
had asked: **NO pattern class fires at five colours on any object we
hold** — 52 clean over 7 objects (both Heule witnesses, the 1581 at both
centres, the fabric, the certified chunk, the bare lattice) × 8 classes
(every vocabulary pair distance + the √3 triple), fan rows at min-cover 2
everywhere, the bare triangular lattice clean at k = 4 for distance-2
pairs (G16's pigeonhole confirmed fabric-borne — the coset obstruction,
proved by HNF enumeration in §0a, does not bind free colourings). The
6-hunt's Act One does not exist on today's objects: nothing we hold is
5-tight anywhere below its whole-witness top rung. Phase 2 — the
registered subplan corrected the stub's semantics before running (any
k = 5 avoider for ANY class subsumes χ(ℝ²) ≤ 5, so the avoider hunt at
k = 5 IS the open upper-bound hunt; a k = 6 avoider bounds only
SEVEN-forcers): the brick prober (rectangular torus tables, exact
closed-hull interval arithmetic, the SAT probe and the Lean certificate
checking the same finite object) ran ~2,800 registered rows with the
k = 4 mass-red control green throughout, and found that **the row-brick
family cannot 7- or 8-colour the plane at any probed shape** — squares,
long bricks, fine slabs alike; row-aligned cells cannot interlock the way
the hexagonal 7-colouring's tiles do; the family's probed threshold is
exactly 9, and the pixel-resolution question (32×32 at 1/8) capped
undecided. The kernel harvest: **`mono_pair_of_clique`** (the counting
face of the M34 bridge — no refutation anywhere); **the hex-shell
pigeonhole** (the closed first shell of the triangular lattice is a K7 of
the {1, √3, 2}-distance graph: every proper ≤ 6-colouring of the plane
has a mono pair at √3 or 2 — **χ(ℝ²; {1,√3,2}) ≥ 7**, elementary and
presumably folklore, ours the formalization and the 6-programme seed
framing); and **`Brick.lean` + `Instances/Nine.lean`: χ(ℝ²) ≤ 9,
kernel-checked** — the repository's FIRST certified upper bound, the
classical interval now bounded kernel-side at BOTH ends ([5, 9]; the
classical ≤ 7 needs polygonal cells, priced), with the avoidance surface
live (a certified 9-colouring avoiding √(3/2) — the exact consumer any
future k ≤ 6 avoider find instantiates same-day). All on axioms exactly
`[propext, Classical.choice, Quot.sound]`; instruments banked: the 3-bit
k = 5 re-encode, the clique-triviality guard, the k-threaded sweep
machinery, the prober with its catastrophe banner.

M36 closed the classical interval, and the shape of the milestone was decided
before any instrument ran. The registered stub had planned a hexagon module —
a new cell family, a rounding function, a ℚ(√3) ordered layer, ~300 lines —
because M35 had measured that no BRICK colouring passes the certificate at
seven colours. Working the arithmetic by hand for §0a found the real
obstruction, and it was not the tile family: it was **one comparison inside
M35's own certificate**. Cells are half-open, so the realizable difference
vectors at an offset form an OPEN box; a realized squared distance is
therefore strictly below the interval's upper end and strictly above its lower
end whenever that end is positive, and a sound certificate may accept an
offset whose interval merely TOUCHES a guard. M35's check demanded strict
separation — sound, but one comparison stronger than the truth. And the
classical brick seven-colouring is **boundary-tight by force**: the
self-offset demands `w² + h² ≤ 1` and the coset offset (1,2) — translation
exactly (2w, 2h), closed gap exactly (w, h) — demands `w² + h² ≥ 1`, so the
cell diagonal is EXACTLY the unit distance and no strictly-separating
certificate can accept any member. M35 §0j had additionally filtered its grid
by `diag² < 1`, deleting the solutions a second time. Relaxing one `≤` (and
parsing guard positivity into the certificate, without which `guards = [0]`
would make the relaxation unsound) landed **`χ(ℝ²) ≤ 7` kernel-checked** on a
`7 × 7` table of `4/5 × 3/5` half-open cells sheared `2/5` — the 3–4–5
triangle — coloured by the norm-7 coset map `(i + 3j) mod 7`, whose kernel is
ζ₆-stable hence the ideal `(−3 + ζ₆)`, so norm multiplicativity separates the
colour classes in two lines. **The classical interval `5 ≤ χ(ℝ²) ≤ 7` is now
kernel-checked at both ends** (`Instances/Interval.lean`), on axioms exactly
`[propext, Classical.choice, Quot.sound]`; neither end is new mathematics and
the module says so — ours is the certificate, the boundary-tight soundness
that makes any zero-margin colouring certifiable at all, and the correction of
a measurement's reading. The instruments agreed at every point: the design
script's offset census found 0 straddles with the tight rows exactly where
predicted, 3.8M exact unit-distance pairs found no monochromatic pair, the
prober produced its **first `k = 7` SAT ever** (the certified row as a positive
control, plus a second solution at shear `w/3` that the search found and the
kernel then accepted — the promotion pipe exercised end to end), and the
`k = 4` mass red held in all 298 rows, which is now the empirical guard on the
relaxation itself. The re-asked questions: `k = 6` refused in 1,394 rows and
`k = 5` in 1,394 — no brick colouring of the plane below seven at any probed
shape. Two findings beyond the registration: the certificate passes **exactly
at the two ideal coefficients** `c = 3` and `c = 5` (the roots of `x² − x + 1`
in `𝔽₇`) and never at the other five, so a SAT search knowing nothing about
`ℤ[ζ₆]` reproduced the algebra; and boundary-tightness is **not** a property of
the cell — a `k = 8` rectangle find sits tight at interior offsets `(0, ±1)`
and `(±2, ±3)` while its own diagonal is slack, which refuted half of the
registered §0j prediction and widened where the correction reaches.

M37 asked the next question a limitation theorem should ask — can any natural
FAMILY of colourings beat seven? — and closed the most natural family there
is. Colour each point of the plane by which class its **nearest lattice
point** falls into: that is exactly what the classical hexagonal
seven-colouring is, and what every "Voronoi + coset" scheme ever proposed is.
**No such colouring uses six colours or fewer — at any scale, for any
sublattice, under any tie-breaking — and seven is attained, so the coset
chromatic number of the plane is exactly seven** (`Coset.lean`, both halves
kernel-checked). The proof is four sweeps and two arithmetic facts, all on the
integral form `Q(a,b) = a²+ab+b²`, with no radical outside the embedding's own
definition: the **inscribed disc** (a point within `p/2` of a lattice point
rounds to it whatever the tie-breaking — one Cauchy–Schwarz off the Gram
identity, whose leftover square is what makes the form definite); the **deep
hole** `p(1+ζ₆)/3`, whose ray rounds to the origin because `a + b ≤ Q` is the
identity `2(Q−a−b) = (a+b)² + (a−1)² + (b−1)² − 2`, giving a same-coloured pair
of diameter `2p/√3` and hence `4p² ≤ 3`; the **collinear sweep**, which kills
kernel norms 1 and 3 through a gap lemma (a step shorter than the window hits
every window of width `2p`); and the **corner sweep**, which closes the seams
the collinear sweep leaves at norm exactly 4, where its windows only TOUCH and
the unit distance hides at `1/p = 3, 5, 7, …`. Then the arithmetic: 2, 5 and 6
are not of the form `a²+ab+b²`, so every nonzero kernel vector has norm ≥ 7;
and the closed first shell's 21 pairwise differences have norms in `{1,3,4}`,
all below that gap — the SAME seven-point object as M35's hex-shell K₇, met
from the other side. Sharpness is the classical colouring itself: the norm-7
ideal `(−3+ζ₆)` at scale `6/7`, with the covering radius (`p/√3`, so cells
have diameter under 1) and the ideal's minimum (`√7·p`, so same-coloured cells
stay clear of 1) — and the properness arithmetic stays rational throughout
(`(p/√3)² = 12/49 < 1/4` and `2 < √(36/7)`). **Consequence for the hunt: a
six-colouring of the plane, if one exists, is not a lattice colouring** — the
gap between coset and arbitrary colourings is exactly where it would have to
live, and the homomorphism hypothesis is load-bearing (drop it and an
arbitrary nearest-point colouring is a colouring of an annulus graph on the
lattice, whose chromatic number at fine scales is the plane's own open
question). The general-lattice case is open and priced: the crude
Hermite-plus-covering chain gives `k ≥ 6` for every planar lattice and `k ≥ 9`
for the square one, and closing `k = 6` needs a near-equality rigidity
argument from reduction theory.

M38 removed the hypothesis M37's own grokking had flagged. With the coset
map gone the object is the **constraint graph on the lattice** — join two
addresses when their cells hold a pair of points one unit apart — and the
theorem becomes a statement about that graph's clique: for scales
`p ∈ (1/2, 1)` its constraint set is exactly the first three shells
`Q ∈ {1, 3, 4}`, so the closed first shell is a **7-clique** and seven colours
are forced with no algebra whatsoever. **Any colouring of the plane that is
constant on the nearest-point cells of a triangular lattice at scale above
half the unit distance needs at least seven colours** — arbitrary labels, no
homomorphism (`seven_le_card_of_cell_constant`), and exactly seven at
`p = 6/7` (`cell_chromatic_eq_seven`). The window is binding at the
nearest-neighbour shell, confirmed exactly, with the planted red firing at
`p = 1/2` and below. **The boundary is the finding**: below it the constraint
graph becomes a thin annulus graph on a fine lattice, whose chromatic number
is the plane's own open question — so *any six-colouring of the plane has
colour classes finer than half the unit distance in every lattice's cells*,
which is precisely the regime M36's pixel probes were capped undecided in.

M39 turned M38's viewpoint on the open half of the problem. For every scale
`p` the constraint graph `G(p)` has the property that **a proper colouring of
it IS a proper colouring of the plane**, so `χ(ℝ²) ≤ χ(G(p))` — and M38's
theorem says `χ(G(p)) = 7` on the classical window, which is the hexagonal
seven-colouring recovered as a graph-colouring fact. Below that window nobody
had looked, because the family was invisible until the constraint reading. The
census, on an EXACT criterion (necessary as well as sufficient — G21 applied
before the fact rather than after), found the requirement is **not monotone in
the scale**: seven in the classical window, **eight just below it**, seven
again near `p ≈ 0.46`, then the clique collapsing as the cells shrink. Both turns are theorems, not census rows —
`Coset.seven_le_card_fine` proves the return to seven on `3/8 < p < 2/5` via
the **`√3`-scaled copy of the same shell** (the index-3 sublattice, pairwise
norms `{3,9,12}`), so the shell reappears at every scaled copy of the lattice;
and the rise is
`Coset.eight_le_card_of_cell_constant`: for `1/2 < p < 3/5` any cell-constant
colouring needs at least EIGHT colours, via the `3 × 3` address block with one
corner dropped, whose pairwise differences all have norm in `{1,3,4,7}`. And the ball refutations — finite patches, no
periodicity assumed — settle the spectrum outright: `≥ 7` in the classical
window, **`≥ 9` in the band just below it** (two colours worse, stronger than
the 8-clique theorem), `≥ 8` at `p = 1/3`, `≥ 7` at `p = 0.4` and `1/4`, and
**exactly 7 at both `p = 6/13` and `p = 1/6`** — the latter seven times finer
than the classical scale, so good scales recur all the way down. **So the classical scale is a local optimum and
refining the cells costs colours**
— "make the cells smaller" is not a route to six. The campaign found no
six-colouring at any of twelve scales on tori to 24 × 24 (reported as
period-bounded, never as `χ(G) > 6`), a seven-colouring at `p = 6/13` below the
classical window (so the good scales are not one interval), and — the control
that changed a reading, and went further than retracting it — the fine-scale
seven-refusals are period-bounded: at `p = 1/4` the bigger tori return UNKNOWN
at cap, at `p = 1/3` they return a genuine UNSAT to period 30, and **at
`p = 1/7` a seven-colouring SATs on a 24 × 24 torus**. The tentative "finer is
worse" reading was not merely unsupported but wrong; the oscillation runs all
the way down, good scales (`0.67–0.86`, `6/13`, `1/7`) interleaved with bad
ones (`0.5–0.6`, `1/3`).

M40 was the structure hunt Kooshi asked for ("anything that looks suspiciously
organized"), and the anomalies were already sitting in M39's own data, unread. The
family is piecewise-constant in the scale — one fixed graph per BAND between rational
`T²` thresholds, keyed by point-group class (distinct classes share a norm with
different thresholds, first at 49) — and the corrected census rewrites the spectrum:
M39's clique search was box- and cap-clipped, and the true story is **χ = 9 exactly on
the bad band** (a sheared 3×3 block is a 9-clique — the "≥ 9, stronger than the
8-clique" mystery was a bigger clique), **χ = 12 exactly on `p ∈ (0.4804, 0.5)`** (a
12-point trapezoid clique + the index-12 coset colouring; the local pessimum just below
the classical scale is TWELVE), and §0e's "scaled-shell route exhausted at M ∈ {1,3}"
was FALSE under the exact criterion (the M = 4 shell owns the band `(0.3273, 1/3)` — a
G21 instance inside a G21-aware milestone). Then the finding: **below the classical
window the family forces ≥ 7 everywhere probed, outright (balls, no periodicity), down
to `p = 0.2236`, while the clique number collapses to 3–5.** The gap objects are
canonical, vertex-transitive, and finitely checkable: **G\*** (the band
`(0.4330, 0.4804)`, norms {3,4,7,9}) has **ω = 4 and χ = 7**, its seven-forcing
shrinking to a **23-vertex 1-minimal core** (centre + full norm-1 and norm-4 hexagons +
partial norm-3/norm-7 shells, near-rot6 symmetry broken — the same motif as de Grey's
122-core); the **deep pocket** `(1/3, 0.3464)` has **ω = 4 and χ ≥ 8 outright** (a
91-vertex ball refuses seven; 53-vertex core); and the bands flanking `p = 1/6` have
**ω = 3 — the plane's own clique number — with χ = 7 exactly**, a gap of FOUR. The
mechanism is invisible to every standard relaxation: certified Hoffman brackets collapse
to ≈ 4.1 exactly where the cliques collapse, and the fractional relaxation reaches only
χ_f ≤ 48/7 at G\* (α(12×12) = 21) — the step to seven is integrality. And the classical
mechanism is provably unavailable: **all eight index-7 sublattices contain an edge of
G\*** (same at the 1/6 and 1/7 bands), so no coset seven-colouring exists below the
window — the SAT witnesses there have non-uniform classes and trivial stabilizers. The
family is a finite-per-band mirror of Hadwiger–Nelson's own pathology (ω = 3, every
relaxation low, χ high), and **the sharpest open scale is `p = 1/7`** (ω = 3, balls to
225 six-colour, tori refuse six to period 36): the six-hunt's from-above target list is
now concrete. Explorer published (`build/m40-spectrum.html`); kernel promotion of the
12-clique window, the M = 4 shell window, the coset-impossibility, and χ(G\*) = 7 is
priced and stubbed as M42.

M41 ran the k = 5 gradient hunt in one day — subplanned and executed on the laptop,
every phase parallel — and the theory moved on three fronts while every gradient meter
read zero. **The autopsy (G26)**: all five of M40's clique-free forcer cores FACTOR as
pigeonhole × kill — Act One is always a mono pair forced onto a small NON-EDGE class
(the hex-shell counting argument surviving the clique's death), the fractional
relaxation always collapses (130/23, 501/74, ≈ 4.838 against χ = 7/8/7 — gap 2.16 at
the ω = 3 core, the programme's extreme) — so **the 6-forcer reduces to ONE k = 5
forced-distinct gadget at √3 or 2** (`hexShell_pigeonhole` is Act One in the kernel
already; nine gadget copies on the shell close χ ≥ 6 by the M34 composition genre).
**The Galois orbit (G27)**: the 1581 is fixed identically by the field flip
√3,√5,√11 ↦ −·− — a hidden **Klein four-group of non-geometric automorphisms** on a
graph with NO plane self-isometry — and the orbit's four isometry classes mint **three
new 5-chromatic witnesses** (one isospectral twin; W^[3] solver-verified end to end:
7,877 edges re-derived, k = 4 UNSAT 3,005 s); **P9 exact: de Grey's 791-forcer IS the
witness's centrosymmetric core**, so M30's forced central symmetry is substrate
symmetry at criticality; the witness is **half-crystal** (787/1581 rot6-invariant);
Heule-510 has no √7 content. **The flat verdicts, all settled exactly**: m1 (forced
pairs + virtual edges at k = 5) is ZERO on twelve composed objects — eight crystal
unions through six copies, three witness–conjugate hetero-dimers (interfaces to 1,101
shared vertices), the four-witness family union; gen-2 closure = **284,873 points,
1,477,824 edges** (32% fusion — the group is folding), whole object k = 5 SAT in
343 s; and **the reduction's gadget question, asked directly for the first time: 0
virtual edges in 40 targeted asks** at exact √3/2 pairs on gen-2. The only nonzero
readings anywhere: two solver-effort signals (hetero-dimers 10×; gen-2 ×300 at ×12
size). Instruments banked: `tools/gradient.py` (overlap census, union builder with
from-scratch edge derivation, autopsy driver, Galois conjugator, non-geometric
equivariance queries). The jackpot clause never fired; the flat clause is banked as
the k = 5 extension of G10/G17 to composed matter.

M42 took the gap atlas to the kernel, same day. The four headline pieces of M40 are
now theorems on axioms exactly `[propext, Classical.choice, Quot.sound]`, in two
sittings: the engine plus three windows in the morning (`Coset.lean` §GapBands —
`exists_unit_pair_ivt`/`exists_unit_pair_corner`, the exact-hexagon reach
`Q + 2·holeF + 4/3` whose corner values ARE the D1 band boundaries;
**`seven_le_card_shell4`** — the M = 4 scaled shell forces seven on
`3/28 < p² < 1/9`, the window M39 §0e had wrongly priced as exhausted;
**`twelve_le_card_of_cell_constant`** — TWELVE colours on `3/13 < p² < 1/4`, the
local pessimum below the classical scale; **`no_coset_seven_on_gap`** — no nonzero
homomorphism to `ℤ/7` is proper on the G\* band, by a 14-candidate kernel-vector
decide, so the classical coset mechanism is structurally dead below the window), and
the crown in the afternoon: **χ(G\*) ≥ 7 via the 23-vertex core, kernel-checked**
(`Instances/Core23/`). The core's graph is **derived, not transcribed** — 23 addresses
plus one norm-{3,4,7,9} filter produce the 143 edges, so the refuted CNF, the pinned
clause table, and the corollary's geometry all reduce to the same data — and the
refusal is the M05 LRAT chain at six colours (219 derived clauses, 2 segments,
kernel-replayed in seconds; the registered decide route died honestly on an instance-
synthesis wall and P4's fallback fired as written). With the red control
**`core23_colorable_seven`** (a verified 7-colouring using all seven colours) the core
is **χ = 7 exactly with ω = 4, kernel side** — the programme's first certified
`χ ≥ ω + 3` object — and **`Coset.seven_le_card_gap`** carries it to the plane: any
cell-constant colouring at a G\*-band scale needs SEVEN colours, the count routed
through the core's refutation because no 7-clique exists to count against. The
gap law (G24) is now kernel-checked in its forcing half at four windows; what remains
measured-only is the deep pocket's χ ≥ 8 and the fine-tail ω story. Palette pin
re-measured at k = 6: 240 vs 38,528 LRAT lines, 160×.

M43 went to the sharpest open scale and closed it — and the campaign's most important
finding is not the closure but what the autopsy could not find. **χ(G(p)) = 7 exactly on
both bands flanking `p = 1/7`**, the last scale in the family where six colours were
undecided in either direction. The coarse flank (`T² ∈ (139/3, 49)`, never probed by any
earlier milestone — M39/M40's "p = 1/7" rows all attach to the FINE flank's graph) refuses
six **outright**: nine independent ball radii, minimum `R* = 9` at 301 vertices, the
refusal re-confirmed by the deleted-centre encoding with different symmetry breaking and no
pin; the fine flank follows by edge-set inclusion, and M39's 24 × 24 seven-colouring
descends to both, so seven is exact on both. Neither flank admits a periodic six-colouring
of index ≤ 96 (**7,624 period lattices each**, exhaustive over Hermite normal forms, zero
unknown, mass-red control green). The censuses extended the ≥ 7 floor over ten more bands
between `p = 0.2236` and `1/7` and nine in the deep tail down to `p ≈ 0.109`, with ω = 3
everywhere below `T² ≈ 64/3` — twelve deep-tail bands are recorded as honest unknowns at
cap, not as refusals. **The autopsy is the finding: the 1/7 seven-forcing does NOT factor
as pigeonhole × kill.** Act One is free by counting (the closed shell's seven addresses
have all 21 mutual offsets at norms {1,3,4}, none of them edges at this scale, so six
colours force a repeat) — but Act Two does not exist: forcing such a pair to share a colour
stays satisfiable on the R = 8 stage's 241 vertices, *more material than the 160-vertex
core that refutes outright*, and the same at every small non-edge class (norms 1,3,4,7,9,12,
all decided in under a second). **Zero virtual edges at k = 6** — the from-above echo of
M41's flat table from below, and the falsifier G26 registered and never found in five
cores. The compulsion is not pair-mediated; it is global over 160 vertices, which is what
"integrality-carried" had asserted and is now measured as an absence rather than inferred
from a relaxation gap (the certified Hoffman bracket at the flank reads **3.56 against the
truth 7** — below even G\*'s 4.09). The registered literature check delivered the
milestone's reframing: **Voronov (arXiv:2304.10163) has PROVEN Exoo's conjecture** — every
closed interval `[1−ε, 1+ε]` of forbidden distances needs ≥ 7 colours at arbitrary ε > 0 —
and a two-line gap argument over the finitely many offset windows near 1 turns that into
**χ(G(p)) ≥ 7 for the entire cell family, every band, all the way down** (conditional on an
external preprint we have not verified). So the from-above door is closed twice over, G24's
"why is every band ≥ 7" has a conditional answer, and by compactness every band owns a
finite refuting ball — ours are the exact, finite, kernel-promotable certificates of a fact
the continuum proof does not produce. Kernel promotion is **priced and deliberately
declined**: the search is cheap (462 s monolithic; cube-and-conquer works and needs no new
Lean machinery) but the certificate is M06-scale — one medium cube logs **798,002 LRAT
lines, sixty-three times the entire 122-core certificate** — for a statement that is
conditionally implied by published work, is not a rung toward six, and sits below the
publication bar. The registered same-day promotion clause is reported UNMET with its
measurement.

M45 asked, on a calibrated bed, the question four campaigns had never asked — *at what order does a
colour compulsion live?* — and the answer came back as a **correction to this project's own record**.
The kernel layer landed first and reframed the question before any instrument ran: a compulsion is
**a partial colouring that does not extend**, the **arity floor** is the least number of vertices at
which local properness stops implying global extendability, and — the derivation that mattered — **a
vertex with `k` distinct neighbours makes the rainbow pattern on them unrealizable, so the arity
floor is at most `k` with no hypotheses at all**. Since every object here has some vertex of degree far
above its colour count, *the four flat pair campaigns were asking an arity-2 question on objects
where a compulsion of arity ≤ k was guaranteed to exist.* Then the measurement. M43 had recorded
**"zero virtual edges at k = 6"** on the fine-tail core and concluded its forcing does not factor as
pigeonhole × kill; its ask was **six questions** — force colour(0,0) = colour(d) at the six smallest
non-edge classes — on the R = 8 ball. Re-run on **the identical stage**, M43's six asks **reproduce
exactly** (6 realizable, 0 compelled) — and that same stage carries **seven virtual edges** at offset
norms 27, 28, 31, classes the sweep never touched, each decided in 7.5–15 s and **each confirmed in
three independent encodings** with every control green. On the *critical* stage (the 1-minimal core
less one vertex, one vertex short of refusing) the complete sweep of all 9,636 non-adjacent pairs
finds **51** virtual edges, 0 forced pairs, 11 undecided at cap. The two effects separate cleanly:
**coverage is primary** (six asks against thousands), criticality secondary (51 against 7 on
identical pairs). **G28's pair-mediated half is refuted — Act Two exists — and "the forcing does not
factor" was a measurement of a six-element acceptance set, not of the object.** Three genuine
arity-3 compulsions were also confirmed (all sub-pairs verified free, two encodings each), and a
fourth candidate that turned out to be a virtual edge in disguise is recorded as such and is now a
planted control in the instrument. The milestone's remaining phases — the exhaustive ladder on the
kernel-certified 23-core, the fan-shrink upper bracket, the randomized-order re-shrink — are **not
run** and are reported as not run.

M48 asked the from-below direction the question M45's theorem had made unavoidable, and the answer
is a **complete determination up to one step**. `arityFloor_le_of_degree` guarantees that de Grey's
1581-vertex witness carries a compulsion of arity at most five (its two spindle centres have degree
60 against `k = 5`), and its arity-2 sweep was already settled *empty* over all 1,248,990 pairs — so
the floor sat in `{3, 4, 5}` by theorem, and nobody had ever asked which. **The complete arity-3
sweep — all 657,385,070 triples × all five patterns, 3,286,925,350 questions — returns zero**, as
does the **complete neighbourhood arity-4 sweep** (1,718,839 deduplicated 4-subsets × 15 patterns,
25,782,585 questions), both with zero undecided at cap. So **`arityFloor(1581, k = 5) ∈ {4, 5}`
exactly** — and because every arity-5 compulsion the degree theorem constructs lives inside a
neighbourhood whose 4-subsets are now all known free, **those compulsions are 1-minimal**, which is
M45's designed-but-unrun fan-shrink bracket arriving as a corollary of a sweep aimed elsewhere. The
engine is what made 3.3 billion questions a 46-second bit sweep: **pair colour-agreement masks**
(`M[u,v]` = the bitmask of harvested colourings in which `u` and `v` agree, every arity-`m` pattern's
observed set a boolean combination of the `C(m,2)` masks on its tuple), plus observe-then-confirm —
one harvested colouring exhibits a realized pattern for *every* tuple at once, so a solver sees only
what nothing wore, and each model it returns kills more. The **ladder** phase carried it to the
gen-1 half-spindle closure — 24,065 vertices, 123,134 chords, the witness verified INDUCED inside it
(7,877 edges reproduced, which is the ladder theorem's actual hypothesis) — and found the same zero:
the witness's own 3,286,925,350 triple-patterns compel nothing there either, and gen-1's own 73,256
target-class pairs (52,616 at √3, 20,640 at distance 2, an object never swept at all before) contain
no virtual edge. Since `arityFloor_le_of_embedding` says the floor can only **drop** along that
embedding, the flat reading is *an inequality measured tight*, not an absence of news. The kernel
layer that made all of this readable landed first, and one of its three theorems is a **correction
to this project's own record**: the seven-point pigeonhole is disjunctive over six √3-pairs and
three diameters, so χ(ℝ²) ≥ 6 needs a virtual edge at √3 **and** one at distance 2 — never one at
either — now proved from both sides by two explicit 5-colourings of the carrier, each separating one
class entirely. Five of six registered predictions met; P6's second half missed and is reported with
its measurement. Two instrument bugs found mid-campaign would each have manufactured a false
negative, and are recorded in `plans/M48-from-below-arity.md` §R6 with the numbers they moved.

M49 turned the hunt into a dial. The reduction everyone states — "χ(ℝ²) ≥ 6 needs one gadget" —
relocates the difficulty rather than shrinking it, because a rigid pair at five colours IS a
6-chromatic graph with one non-unit edge; so the milestone defined **μ(d)**, the fewest d-edges of a
non-5-colourable {1,d}-graph, put the two ends in the kernel (**`OneDefect.lean`**: the **spindle
theorem** — a forced-equal pair at *any* distance ≥ ½ at k colours refutes k-colourability, homogeneity
composed with a d–d–1 triangle from the certified gluing classification; **one non-unit edge already
suffices** for χ ≥ k+1; the Moser bound re-proved through the abstract lemma from the rhombus alone;
**`distanceGraph`** with `unitDistance = distanceGraph {1}` and χ(ℝ²;{1,√3,2}) ≥ 7 as a
theorem — 22 declarations, standard three axioms), and then MEASURED the dial on the seeds the
literature holds. **Exoo–Ismailescu's 214-point {1,2} six-forcer re-derives exactly** from the
paper's data (every published count, the eighteen and thirty-five colourings up to palette,
`A = B` in all thirty-five); its kernel certificate is **priced at ~50 M proof hints — 1.6× the whole
de Grey certificate — and deferred**, every lever measured (vertex-minimal shrinking is 3× WORSE for
proof size; more material is no better; proof-guided shrinking is a fixed point at iteration one).
**Parts's {1,φ} six-forcer, rebuilt exactly from his paper, is edge-critical to the last edge** —
all 56 φ-edges and all 57 unit edges — so a critical object's own subgraphs can never read the dial:
μ is measured by ADDING unit material, never by deleting. The measurement, on the seed's forced-pair
carrier at five colours: of its 446 distance-2 edges, **29 lie in every forcing subset** (a rigorous
lower bound that falls out of a parallel single-deletion census for free) and a cap-limited shrink
leaves 252; and the **descent** — remove one essential distance-2 edge, add a unit-distance halo from
a named field about its endpoints, ask whether the forcing survives, certify (UNSAT, second encoding,
halo shrunk 1-minimal with a necessity witness per survivor) — **replaced twelve of the twenty-nine
with seventeen seam-field points in all**, one point each on average, with every ask of every rung
DECIDED (zero unknown across seam and one-field-up pools at radii 1.5, 3, and whole; the seventeen
survivors refuse every one-generation pool in both fields). The kill mechanism, measured on the first
removal: the single point sits at unit distance from one endpoint, carries nine unit edges into the
seed, and in every separating colouring its neighbourhood is forced rainbow — the kernel's own A1
(`not_colorable_iff_covers`) at a point that is NOT a vertex of the object, the compulsion the M33
warning said an enumeration over present vertices would miss. The **calibration at four colours**
refuted the registered belief the good way: the seam halo I predicted could do NO distance-2 job on
the 122-point pigeonhole core did **34 of 37**, and the three survivors fall to a two-generation
seam-then-up pool — their certified commits did not finish (a 28,000-point shrink at four colours ran 9.5 h and was stopped; the three UNSAT probes stand as single-encoding probes, and the four-colour object is not rigid enough — > 20,000 colourings — for the lookup engine that finished the job at five). Registered predictions: P4a, P5, P8 met; P4b refuted; P4c met one level
deeper than registered; P2 undecided (sandwich only); P3 met vacuously; P6 missed decisively; P7
refuted in its literal reading (the k = 5 removals were CHEAPER, median one point, with the selection
caveat stated); P1 missed (certificate deferred). Three instruments had to change mid-campaign, each
with the reason recorded (a batch greedy serial in acceptances; a full-pool k = 5 ask undecidable at
180 s; a halo shrink that spent thirteen hours on one halo) — the replacements are parallel and
checkpointed, and every replayed run matched its rows fingerprint for fingerprint. **Then the
solver left the loop.** Asked whether the seventeen refusers' kills might live in a field nobody had
named, the answer came from the seed's own geometry: a single killing point needs ≥ 5 unit
neighbours in the seed, so it is an intersection of unit circles about two seed vertices — 9,485
such points, in exactly 59 quadratic extensions `√(4 − d²)` of the seed's field, 51 of them with
five or more seed neighbours: the whole depth-one kill space, enumerable in ANY field. And the seed
is rigid: `H − e` has only **2 to 19** separating colourings up to palette (enumerated exactly), so a
halo kills `e` iff its list-colouring problem is infeasible under every listed colouring — bit masks
and tiny SATs, no forcing asks (the 867-ask solver census agreed with the lookup exactly). The
whole depth-one partner set as one halo settles depth one COMPLETELY: for every one of the
seventeen some separating colouring extends to all 9,271 points, so **no depth-one halo of any size
in any field kills them**; the restricted depth-two union (52,139 points) **kills seven**, and their
shrunk gadgets are 87–267 points each — the recursion's cost made concrete: one point at depth one,
a hundred-odd at depth two — all seven certified in two encodings on `H − e` (exact sympy geometry,
2,000-odd unit edges verified). And the composition taught the dial its semantics: kills are
CONTEXT-DEPENDENT — a gadget designed against `H − e` need not kill once other distance-2 edges are
gone (all nineteen at once is SAT) — so removals compose only sequentially against the current
object: **fourteen of the twenty-nine lower-bound edges are removed in one object at the close**
(543 points, 3,441 unit edges, 446 → 432 distance-2 edges; twelve at depth one for 17 points, two at
depth two for 312), five more gadgets are certified standalone and await re-design against the
reduced object, five refusers are one or two colourings short of a depth-two kill and five resist
it entirely: the named frontier of the dial. The four-colour calibration object, by contrast, has > 20,000 colourings per
refuser — rigidity is what makes the engine cheap, and the seed has it.

M50 turned the sequential descent into a BATCH loop, and the loop compounds. The frame: design
ONE unit halo against the WHOLE batch's separating-colouring list, so removals compose by
construction — the M49 order problem designed out. Two certified batch commits landed: nineteen
cheats in one 476-point halo, then twenty-four more in a 318-point halo on the grown object —
**the composed object holds 1,008 points with 403 of the seed's 446 distance-2 edges remaining:
43 removed, three times M49's entire sequential campaign**. The kernel piece is the engine's
completeness licence (`PartnerLattice.lean`: a point at unit distance from two distinct points
is a glue point or its mirror — depth-one candidate spaces are finite and enumerable, in any
field). The close's measurement is the compounding itself: **the CORE PROBE re-asked every kept
refuser edge against the grown object's own 394,604-point partner lattice, and five fall
outright while the six others hold zero provably-surviving colourings** (2,402 classes, 2,351
killed, 49 undecided at two-hour caps, not one survivor) — growth alone is the kill mechanism,
and M49's "refusers in any field" verdict was a statement about the SEED's lattice, not the
descent's. What resists is named: 277 batch colourings whose kills are WIDTH-shaped (thousands
of weak points cooperating; capped minimizations land at 2,551–14,960 points and keep
descending) — G10's distributed forcing in miniature, the priced mandate for depth 2. The
session's second harvest came from a re-run of the pre-M51 modeling at full depth: the
**weighted ladder** (class-uniform agreement masses on the held lists — the support ladder's
never-climbed sibling) found the seed stage carries **148 ABSOLUTE virtual edges at distances 3
and 4** (the six d = 4 ones are the diameters of the radius-2 circle about the hub v0 — forced
central anti-symmetry, M30's genre sign-flipped) and **412 absolute never-3-distinct triangles
in five equilateral/isoceles families on {√3, √7, 2√3, √13}** — the fabric pigeonhole localized
to single triangles, all seed-native, verified COMPLETE by a decorrelated adversarial agent and
our own instrument independently; and the **spare-colour lemma** (a (k−1)-colourable graph
admits no pair compulsion at k — so every virtual-edge gadget at five colours is itself
≥ 5-chromatic, and the descent's χ(unit-part) monitor must cross 4 → 5 before the end, minting
a new 5-chromatic witness as a by-product) is adopted as an M51 kernel opener. Three instrument
incidents were caught by controls and recorded; predictions scored four met, four missed with
their measurements — P7 missed by exactly three cheats (403 vs ≤ 400).

M52 opened as a study and closed as an algorithm change. Kooshi's duplicate-and-detune construction
had turned the descended object into a family of new 5-chromatic unit-distance graphs (Q8), and the
milestone asked what they are and whether any of them is the stronger base for the descent. The
atlas answered the first question exactly: **every point the descent ever committed lies in
ℚ(√3, √11), the seed's own field** (T14 — all 13,796 unit edges verified as exact identities in the
4-basis), because **every unit edge of the object lies on one direction ladder**, the seed's three
families rotated by whole multiples of the Moser twist arccos(5/6) (T13, 13,796 of 13,796, and the
copies one ρ₁₅ step over); a copy adjoins exactly √5, so the copy unions live in ℚ(√3, √5, √11),
Heule-510's field, inside the kernel's existing M02 tower — which reprices the certificate of the
883-point copy-lock core from a 24-radical compositum to the M06 pipeline. The mechanism of the lock
is finite and measured (T15): the distance-2 pigeonhole fires on the unit part at four colours
(5,470 exact pairs, both encodings, under a second — G16 met from below), and on the 883-core the
two sides' 4-colourings project to 3,516 and 1,062 patterns on the thirteen genuine chords, every one
of the 3,733,992 pairs killed, every chord the sole killer of some pairs, no pair compulsion inside
either set — a distributed kill over a centre-colour bias, not a spindle. The second question closed
the other way, **exactly**: a ρ₁₅ copy kills **0 of 15,218** separating-colouring classes at five
colours (two enumerations; 20 of 20 sampled classes extend by direct SAT with the copy side
4-coloured) — the spare-colour lemma acting on a halo: 4-colourable material attached by a few dozen
chords is coloured around by the fifth colour, and copies never touch each other (0 copy–copy unit
chords in any composition), so the compositions are witnesses, not descent material; P5 refuted, F3
fired, and the copy trick's value is now registered as gated by the χ(unit) crossing — the
endgame's tool, seen early. What stays is the third descent move: **the cull**. No cull had ever
finished; the plain iteration-4 object's cheats fell **273 → 149** with no material added — 114 by
an exact enumeration loop (a jointly redundant batch is one refutation with zero classes; the first
100 of 246 candidates fell that way) and 10 by the Rust culler WO-14 built the same day (gate 269 of
269, verified by the owner; census 273 of 273 against the floor census), 60 kept cheats witnessed,
27 floor, **52 undecided at the conflict ladder and held**; the culled set refuted in the one-hot
encoding in 10,640 s (UNSAT), the 3-bit re-encode unknown at its 12-hour cap — a CANDIDATE on one encoding until the cube front-end lands (R3). WO-14's planning found why the reference cull
had stalled — **the CNF, not the compute**: hard clauses with the palette order over the present
edges decide in 121 s where guarded selector literals sat undecided at 1,302 s — and its
implementation measured the next wall: accepted drops are sequential whatever the worker count (a
refutation against a stale snapshot licenses nothing; 2 minutes per drop at twelve workers), so
width buys nothing in the drop phase and the chunk is the repair (WO-16). The halo shrink was priced
by a 24-point vertex census (1.1 CPU-hours per probe; 12–33 % droppable) and not run. Two more
things landed as the risks were written down (`plans/RISKS.md`): the depth-1 pool of the current
object is **15 % in-field and 81 % non-rational classes, with √5 and √35 material one iteration
away (8,184 and 54,756 pool points) — and every committed point came from the in-field 15 %**, a
structural selection the tiers make (high object-degree means on-ladder means in-field), whose test
(the out-of-field kill census) is iteration 5's first row and whose payoff, if it reads zero, is
Kooshi's in-field pool at ~6× less cost; and the halt clause read exactly — one standing cheat is a
two-branch disjunction to VERIFY, zero is the theorem. Kernel: `Copy.lean` (the spindle rotation for
any pair distance, with the Moser twist and ρ₁₅ as instances; the self-chord law; the copy union as
a comap), 553 declarations clean. Predictions: P1–P4 met, P5 refuted, P6 met in its first half (≤ 184 registered, 149 measured) and moot in its second (no composition is a candidate), P7/P8 moot, P9
missed as registered, P10 refuted on cheats and exceeded on vertices. The decision at the close:
the next milestone is iteration 5 from the culled plain object (M53) or the certificate of the
copy-lock core; Kooshi picks.

M53 (iteration 5 from the culled plain object) ran for a day and a half and was HALTED at its phase D
on 2026-09-05, because the field-wall conjecture stopped being a conjecture: Kooshi's other session,
asked to write it up, proved it (`~/field-wall-conjecture.md` §5). **Theorem B: every finite
unit-distance graph with all coordinates in K = ℚ(√3, √11) is 4-colourable**, by an explicit
residue colouring — in K(i) = ℚ(i, √3, √11) the prime 2 factors as (𝔭₁𝔭₂)² with residue fields 𝔽₄
and decomposition field ℚ(√33), which is real, so complex conjugation fixes each 𝔭ⱼ; a unit vector
then has 𝔭-adic valuation zero, so colouring a point by its residue mod 𝔭 (four residues) changes at
every unit step (Woodall's 2-colouring of ℚ² is the same argument at 𝔭 = (1 + i)). The Moser spindle
lives in K and K is the smallest field drawing it, so four is exact. The wall's location is 2-adic:
it falls for a real field iff −1 is a square in some completion above 2 — for multiquadratic fields
iff an odd square class is ≡ 7 (mod 8) — which is why the 5-forcers carry √5 and √7 and why √2, √10,
√14, √35, √70 can never help; spindles at even distance (de Grey's d = 2, 4; Haugland's d = 2) always
break it. **Checked here before believing**: the note's own decisive test on the Exoo–Ismailescu
seed (proper on 1,004/1,004 unit edges, monochromatic on 446/446 distance-2 edges, the forced pair
separated, both 2-adic branches) and, on the descent's 1,981-point object, proper on 13,796/13,796
unit edges and monochromatic on 344/344 live cheats with zero search (`tools/residue_colouring.py`)
— consistent with M50's forced pairs at 8/3 and 8/√3 (positive 𝔭-adic valuation), M34's mono
distance-2 pairs (2 ∈ 𝔭), and M24–M26's χ = 4 closures (instances). What it means: **a descent
confined to K cannot end** (no pair compulsion at five colours exists in K, by the spare-colour
lemma), so M53's decisive measurement — the in-field pool alone kills every class of a one-cheat
batch (2,488 of 2,488, 13 s; vacuity settled by an explicit 5-colouring) — was Kooshi's first horn
and a trap at once: in-field material does the intermediate kills and can never do the last one.
What M53 measured before the halt stands as data: the culled object's single-cheat asks cost ~25×
the un-culled object's (the cull tightened it); the exact field split of the 1,636,399-point depth-1
pool is 1.0 % in-field (16,348 points — ladder points fuse C(k, 2) parent pairs; "≥ 3 object
neighbours" is the in-field slice to seven points in 1.6 M, G34 as an identity); the spectrum of the
149 standing cheats (89 necessary, 0 droppable-alone, 60 unknown to a ten-minute enumerator); the
batch law on the culled object (one cheat 2,488 classes, two cheats > 80,000); and a two-cheat stage's
3,936 in-field survivors, hard for every material at five-minute asks. Instruments banked: the cube
front-end for the second encoding (R3's lever, self-tested, not yet run on the 149-set), the exact
tower square test, the spectrum, the census reader, the mint, the batch grower, the residue
colouring. The new plan is the other session's: the pool must be WALL-BREAKING (rational classes
5 and 7 mod 8, or −r a 2-adic square — the note's §7.3 test, an instrument to build), the kernel
formalization of Theorem B is the natural next milestone, and the questions the note leaves open
(§8: is ℚ(√3, √5, √11)'s plane exactly 5-chromatic; √7 without √5; the triangle-free quadratic
planes ℚ(√d), d ≡ 7 mod 8) are the next research targets.


M54 asked the question the field-wall theorem left — where, on 5-chromatic material, can a pair
compulsion at five colours live at all? — and answered it with a theorem before any instrument ran,
then built the first objects that satisfy the theorem's precondition and read the dial on them. **The
critical-set localization theorem** (`CriticalSet.lean`, kernel, standard three axioms): with C(G) the
vertices whose deletion drops the chromatic number, a pair forced EQUAL at χ(G) colours has C(G)
inside the pair's common neighbourhood, a virtual edge has C(G) inside the union of the endpoints'
neighbourhoods, and a fan has it inside the pivot's neighbourhood or the partner list — one
recolouring (a critical vertex isolates any independent set through it, painted with the spare
colour), of which the spare-colour lemma is the case C = V. Two points of the plane have at most two
common unit neighbours (the glue point and its mirror), so **a unit-distance graph that forces a pair
equal at its own chromatic number has at most two critical vertices, and none if the pair is more
than two apart** — the 6-forcer built as "5-rigid fabric plus a spindle at distance above 2" needs
fabric whose 5-chromaticity survives every single vertex deletion. Redundancy before rigidity: the
dial's first rung costs one 4-colour ask per vertex, and it prunes the five-colour sweep to the
theorem-admitted candidates (none, whenever the critical set is not coverable by two unit circles).
**Measured, every reading as the theorem said**: the Exoo–Ismailescu seed's critical set is EMPTY
(214/214 deletions refuse four colours — its forced pair is five apart); the 1,175-point witness of
T20 is VERTEX-CRITICAL (1,175/1,175, each certified by a colouring), so T21's 858-second five-colour
sweep of it measured a theorem; the witness plus its depth-one F₂₄₇ cross lattice (104 in-field pairs
of 287,695, collapsing onto 71 points with 20 fusions and 114 edges among them — the K-lattice's
shadow, not dust) loses exactly three copy-side vertices from its critical set, remotely; the
single-centre union on the full fabric has critical set EXACTLY the forcing-critical set of the
fabric and its copy — 13 of 3,905, because the forcing of (35, 1859) survives every deletion but
seven — still uncoverable. Then the derivation that clears the rung: on two spindles over the FULL
fabric a vertex is critical only if it is forcing-critical for BOTH pairs, so with disjoint
forcing-critical sets (measured: 7 and 5 vertices, disjoint) **the 5,857-point union U ∪ R₁U ∪ R₂U
has NO critical vertex** — reached by two twenty-minute forcing censuses rather than search, with its
34 load-bearing deletions checked directly — and the two 1-minimal cores (588 and 543, overlapping
in 31) give a **2,229-point union with no critical vertex either** (all 31 shared vertices asked).
**The dial's reading on it: 0 forced-equal pairs and 0 virtual edges at five colours, complete, in
31 seconds** (78 models, 38 calls) — the theorem's precondition is necessary and NOT sufficient, and
the next obstruction is the one derived and registered before the run: each copy is 4-colourable
K-fabric attached by six or seven chords of outside-degree one, absorbed by the spare colour
(G9/G31 one rung up, the redundancy rung cleared). The big union's sweep runs on as the scale twin.
Also landed: the witness's geometry exact in K(√247) (5,773/5,773 edges, all six chords); ν — the
fifth colour's smallest class — reads 38 on the seed (exact, over its 35 colourings) and 1 on the
witness; and the literature arrived: Fischer 1990 owns the additive framework and the whole
real-quadratic classification (T23), which corrects the field-wall note at d ≡ 5 (mod 8) and leaves
it Theorem B and the local criterion. Seven registered predictions: five met, one met-and-refuted
(the cross lattice is sparse but lattice-like), one missed in its second half (the pool did move the
critical set — by three remote vertices).


M55 was minted as "many spindles over one fabric" — the paths-forward entry M54 had written — and began by
deriving that the entry cannot work as stated, for any number of spindles, then turned the reason into a
kernel theorem and measured what the theorem leaves open. **Absorption** (`Absorb.lean`): a vertex set A
EXTENDS at k colours when every proper k-colouring of G[A] restricts from one of G, and then the pair
compulsions of G among A's vertices are G[A]'s own — none, if G[A] is (k−1)-colourable. One construction
proves every sufficient condition — colour the piece, repaint the clashes with the spare colour — and its
instances are the shapes the hunt builds: **hub absorption** (pieces fused to the rest at one hub each, at
most one base neighbour per piece vertex, the non-hub chords a matching with independent endpoints, the piece
union plus hubs (k−1)-colourable) is EXACTLY a union of spindle copies hanging off one fabric; **greedy
absorption** (the (k+1)-core: vertices of degree ≤ k, peeled, are invisible); **symmetric copies** (ring chords
without fusion are absorbed at every k ≥ 2 by a palette rotation — a spindle forces only through its fused
centre). Measured, every reading as the theorem said and one sharper: on M54's two C = ∅ objects and on a
new three-spindle star (7,809 points, C = ∅ by two asks) **every cross chord but the spindle chord is a hub
chord** — a copy hangs on its fabric by its fused centre and ONE chord — so the base extends at five colours,
no compulsion lives among the fabric's vertices however many spindles there are, and **ν (the fifth colour's
smallest class = the fewest deletions to 4-colourability, D5) is exactly 2 on both two-spindle objects** by
theorem above and M54's census below, with no solver run. The single-centre **flower** (rotation powers about
one centre, de Grey's genre with our angle) has a critical centre at every depth tried (K = 1, 2, 3: one
deletion ask each) — and at K ≥ 2 it is the first object the theorem does NOT decide (consecutive petals with
the fused centre are a rotated copy of the 5-chromatic witness), yet with C = {x} the localization theorem
leaves its sweep only the centre's neighbourhood, and the exhaustive five-colour sweeps read **0 / 0 complete
in 11 s and 30 s**. The F₂₄₇ cross lattice one depth further (the plan's other route) is denser than
registered (0.65 % of cross pairs glue in-field, sixteen times depth one; 64 % of the new points at degree ≥ 5,
so visible) and it moves the witness's critical set from 1,172 to 937 — **all 238 freed vertices on the copy
side, none on the core side**, a one-sided effect registered as T24. Nine predictions: five met (two by
derivation before measurement), one met-in-substance, three missed in their numbers with the numbers
recorded. Three instrument incidents were caught by controls; one — a solver wall that had never actually
been able to fire — was found because the ν ladder reached it, audited (no recorded ask of M54 or M55 ever
needed the wall), and fixed.

M56 changed the input from the graph to the FIELD and asked, derivation first, what arithmetic says about tightness.
The yardstick is Fischer's additive colouring restricted to a chunk's difference lattice Λ — a homomorphism from Λ
into a group of order k, nonzero on every edge vector — and the derivations came before the instrument: an
additive colouring is a proper colouring (kernel, `Additive.lean`), so the pairs every additive colouring identifies,
F_add, CONTAIN the truly forced pairs and never certify one, while every difference in kΛ is additively forced (L1);
and no plane over a wall-broken field has an additive k-colouring for any k ≤ 10, because every spindle rotation at
distance d puts 1/d² into the group the unit vectors generate (L7: 1/3 from the Moser twist, 1/5 from ℚ, 1/7 from
d² = 7/3, 1/2 from any even-distance spindle) — Fischer's 1/k obstruction IS the field wall in his language. Then
the measurements, on a bed whose answer was already known and then above it. **The Exoo–Ismailescu seed's
tightness is arithmetic**: of its 21,787 non-adjacent pairs exactly one is identified by every ℤ/5-homomorphism of
its unit lattice, and it is the forced pair; its 446 cheats and its distance-3 and -4 pairs are separated by every
one (M50's 148 absolute virtual edges, explained); 18 of its 35 five-colourings are additive and the other 17 lie
within two repaints of the family; and for the paper's own G, whose 18 five-colourings Exoo and Ismailescu counted
by exhaustive search, **the colouring space is exactly the additive family** — none of it in the paper, which
cites no algebra. **K-fabric's four-colour rigidity is additive at two depths and not at the third**: on the
1,953-point fabric the additive family (eight colourings: the two residue colourings and six ℤ/4-type ones nobody
had named) forces exactly the pairs of 2-adic depth ≥ 2 in Λ; the solver separates every depth-2 pair (2,324, all
non-additively) and forces 171 of the 189 at depth 3; and the Kempe sublattices of the eight colourings — a two-line
theorem, F_true ⊆ F_K — separate every depth-2 pair and leave 187, sixteen more than the truth. **And the additive
spindle theorem (L8)**: a spindle over an additively forced pair has its chord in 4Λ, so the union has no additive
4-colouring — on de Grey's 1581 the one unit vector in 4Λ is its single cross edge (11, 802), on our witness it is
the spindle chord (565, 1152); Heule-510's SAT-shrinking lost the 4Λ chord but not twelve 2Λ ones, and de Grey's
791-forcer has no additive 4-colouring at all. Every witness keeps additive FIVE-colourings (24, 432, ≥ 2,981)
whose forced pairs — 91 on Heule-510, 291 on W, 356 on the 1581 — are all separated by non-additive colourings (91
solver asks under the jackpot protocol, all refuted; the 291 and the 356 by the complete sweeps), and W's sampled five-colourings sit at the random baseline from both algebraic
families (additive and residue-per-coset): above four colours, tightness is not arithmetic on the objects we hold,
and the seed is the one object that makes the yardstick read true.
M57 asked what makes a chunk's colouring space its additive family — the principle M56's seed reading suggested — and
answered it with a closure condition, a solver-free gauge, and a kernel theorem whose hypotheses are the design
specification. The reduction (`AdditiveRigid.lean`): a chunk whose proper 5-colourings are all additive along an address
map forces every pair at a 5Λ-difference (L1 applied to each), and the spindle theorem turns one such pair at distance
≥ 1/2 into χ(ℝ²) ≥ 6 — stated at its least (a coset colouring: the same-colour relation is the trace of the cosets of a
subgroup containing 5·V; the `↔` is the content, and two reds pin its clauses), with the unit path at two colours as the
non-vacuous model (χ(ℝ²) ≥ 3 by the reduction). Then the derivation that reshaped the target: the additive family is rigid
only if it is CLOSED under every reconfiguration move — every {a, b}-subgraph of every admissible hom connected — and
the gauge γ = Σ (components − 1) counts the edges leaving it, its isolated-vertex part the loose vertices (a vertex whose
neighbours miss a colour can be recoloured out of the family). **Exoo–Ismailescu's G is exactly that: γ = 0 with its
cheats, and its 18 colourings are its 18 homs**; H's 17 non-additive colourings are its attachment's 12 loose incidences
and their pairs. Nothing else we hold is near: at four colours every K-chunk beyond the rhombus is Kempe-open (by rank on
three-ladder material — one ζ₆-orbit per residue, so Λ_c has rank ≤ 3 — and measured on the 122- and 588-cores: γ = 200,
182; the Moser spindle itself has 16 four-colourings, 4 non-additive, refuting the registered bridging bed); at five, every
additive colouring of every 5-chromatic witness is loose on a fifth of its vertices (γ = 3,014 on Heule-510, 147,456 on W,
≥ 76,115 on the 1581), and a SAT solver's colourings of any of these sit at the random baseline from the family. And
thickening kills the family before it could close it: **W's 63 depth-one cross points in F₂₄₇ generate a lattice in which
500 of W's unit vectors are 5-divisible, so the thickened stage has no additive 5-colouring at all** — L7's 1/5 ∈ Σ₀
realized at depth one (the cumulative dial: 1,728 → 960 → 640 → 0 homs as the points accumulate; every ball of the
depth-2 stage vacuous with 98 % of its units in 5Λ) — while each in-lattice point alone kills non-additive colourings by
coverage (up to 110 of 200 sampled) and never an additive one. The seed's own subsets show the principle is sufficient
and far from necessary: M49's 252-cheat forcing subset keeps the forced pair with a colouring space above 5,000, two thirds
of it far from additive. The design principle "make every colouring additive" therefore has, on every object we hold, no
purchase: the unit parts inside K are 4-colourable (no rigidity possible), the wall-broken witnesses are Kempe-open by
five orders of magnitude, and the one thickening that moves redundancy erases the family. What it leaves is exact: the
gauge, the kernel target, and G as the single object that meets it — with cheats.

**The pivot of 2026-09-06 — the finite-plane bound (Kooshi's web-Claude session, `reference/Chat-analysis/`; VERIFIED
here, `reference/Chat-analysis/VERIFICATION.md`).** Theorem B coloured the residue plane 𝔽_p² LINEARLY, and that is why the
additive method's next values after 4 were 7 and 11 (G38): the residue map of a unit-distance graph in F² at a degree-one
prime 𝔭 above p ≡ 3 (mod 4) lands in the finite Euclidean plane UD(𝔽_p, 2) = Cay(𝔽_p², {a² + b² = 1}) as a graph
HOMOMORPHISM (𝔭 is inert in F(i) since 𝔽_p lacks √−1, conjugation reduces to Frobenius, unit vectors are integral, and an
edge reduces to a circle difference), so **χ(F²) ≤ χ(UD(𝔽_p, 2))** — the finite plane's OWN chromatic number, which is not
linear: **χ(UD(𝔽₁₁, 2)) = 5** (four refused, five found and verified; Vinh 2005 computed only p = 7, where it is 4).
Instantiated exactly on our objects: Heule-510 reduces modulo the prime above 11 with all 2,504 edges on the circle and the
pulled-back 5-colouring proper (so the lower half needs no solver — Heule-510 is kernel-certified 5-chromatic), W with all
5,773, the seed with all 1,004. **Hence χ(ℚ(√3, √5, √11)²) = 5 and χ(K(√247)²) = 5 exactly — the first exact values of
wall-broken planes — and every field the descent ever used (K, K(√5), K(√247), K(√5, √247), Heule's) is 5-SEALED: no
6-chromatic unit-distance graph has its coordinates there.** De Grey's field has no usable prime below 131 (√7 makes 11
inert), K(√7) has 83 first, K(√35) has 107 first; whether those planes refuse five colours decides whether those fields are
6-open, and that is the field sieve (FS-7, opening as M58). Novelty is provisional (Vinh and the library's number-field
papers do not contain the bound; Soifer 2024 unread). Not kernel-checked: the reduction is a hand proof, the plane's value a
verified colouring plus the solver's refusal — priced in the stub.

**M58 — the field sieve (CLOSED 2026-09-06, the same day).** The milestone opened with a derivation that removed its own
solver runs: the eigenvalues of UD(𝔽_p, 2) are Kloosterman sums, **λ(c) = −K(1, c/4)** (checked to 10⁻¹³ at every p ≡ 3 mod 4
below 600), so Weil's |K| ≤ 2√p and Hoffman's χ ≥ 1 + λ_max/(−λ_min) give **χ(UD(𝔽_p,2)) ≥ 1 + (p+1)/(2√p) > 5 for every
p ≥ 62** with no computation, and the exact spectrum adds 59 (Hoffman 5.022). The planes the stub had queued for SAT are
≥ 6 at 83, ≥ 7 at 107, **≥ 8 at 131**, ≥ 13 at 479 — P2 and P3 met by derivation, the 40-minute solver runs killed. Then the
arithmetic: for every field containing K = ℚ(√3, √11) the usable primes are p ≡ 11 (mod 12) with p a non-residue mod 11, so
**11 is the only usable prime below 67, and "F ⊇ K is 6-open ⟺ the 2-adic wall is broken ∧ 11 is inert in F" is a theorem** —
de Grey's field (131, 479), K(√7) (83, …), K(√13), K(√79), K(√127) and every odd squarefree d ≡ 5 or 7 (mod 8) that is a
non-residue mod 11 (the stub's list corrected: d ≡ 5 breaks the wall through 3d ≡ 7) are 6-open; K(√5), K(√23), K(√247),
K(√5,√247), Heule's are sealed at 5; K and K(√35) at 4. The measurements: **χ(UD(𝔽₁₉,2)) = 5** (P1 and the stub's "11 is the
last 5-sealing prime" refuted as stated — 19 seals fields without √3, which Fischer already bounds at 4); 23, 31, 43, 47 at
five colours in flight at the close (Hoffman floors 4.0–4.7; ω = 3, 2, 2, 3); the shadow sieve's spectral floors — the 1581's
55-direction shadow at 131 reads 4.96 (≥ 5 only; its five-colourability a 17,161-vertex SAT in flight), the gen-1 closure's
shadow at 131 IS the plane (≥ 8) and at 479 has floor 8.38. **Kernel** (`UnitQuadrance.lean`, `Instances/FinitePlane11.lean`;
axioms exactly the standard three): the plane as a functor of the coordinate ring — `unitQuadrance R` for every commutative
ring, a ring hom applied coordinatewise a graph hom (`unitQuadrance.map`, the finite-plane bound in one line) — and the
reduction of a certificate as ONE theorem over a subring of the tower with a hom and an inverse of the denominator (no
field, no condition on p: usability lives in the existence of the hom), instantiated at 11 through the `√7`-free subring
`Q4.sevenFree ≅ ℤ[√3,√5,√11]` and at 131 through the whole tower; **`χ(UD(𝔽₁₁, 2)) = 5`** with no solver (the 121-entry table
decided proper; the refusal of four from Heule-510's certified refusal through the reduction — no edge re-examined) and
**`χ(Heule-510) = 5` exactly** — the first certified upper bound on a certified 5-chromatic witness; `χ(UD(𝔽₁₃₁,2)) ≥ 5` for
free. The field-level statement (the integrality of unit vectors at the primes above 11) stays a hand argument. FS-11 minted
at the close: a LIFT of a 6-critical subgraph of UD(𝔽₁₃₁,2) into de Grey's field — one point per residue class, every edge
unit — would be a 6-chromatic unit-distance graph; the local 𝔭-adic test says cheaply whether any core can lift.

**M59 — the finite-plane lift (CLOSED 2026-09-06, the same day; the first milestone under the programme).** The question was
whether a 6-critical subgraph of a finite plane can be LIFTED — one point of the field per residue class, every edge unit — into a
6-chromatic unit-distance graph; the answer came by derivation, and it is no. Writing a candidate lift as x₀ + p·y, the condition
modulo p² is the **rigidity matrix** of the residue framework against a **defect** vector, solvable iff the defect pairs to zero with
every **self-stress** — so a 6-critical H (|E| ≥ 5|V|/2) carries at least |V|/2 + 3 independent linear conditions, and passes them
only if it is already a shadow of a real configuration; the finite plane's 6-forcing, Kloosterman-carried and global, gives no reason
it should be. The theorem is first-order rigidity in any ring with a square-zero element (`Lift.lean`: a stress with a nonzero pairing
refutes every deformation), so the whole Hensel tower is one theorem; for a framework rigid at its residues a Laman basis lifts
uniquely up to p-adic isometry, the remaining edges decide at a finite level, and **a local lift is algebraic** — its field has an
unramified degree-one prime above p, real iff it has a real place. Measured, the theory recovers de Grey's graph from its residues
alone (at 131: rigid, 4,450 stress conditions all pass, the Laman-basis Newton lift has every one of 7,541 edges unit to 131²⁰ and
IS the tower configuration on 20,000 pairwise quadrances), and refutes its **merged image** (34 residue collisions identified — a
≥ 5-chromatic subgraph of the plane) with a 48-edge witness stress the kernel decides (`Instances/LiftObstruction131.lean`: no
lift modulo 131², no covering tower certificate). The instrument's own controls corrected the derivation's scope: at 11 the Moser
spindle and Heule-510 are RIGHTLY obstructed — 11 is ramified in ℚ(√11), their coordinates live in ℤ₁₁[√11] — so **the lift's primes
are the unramified ones (83, 107, 131, … over K), never the prime that seals (11)**. The whole plane at 131 is undecided by cadical
at five colours in an hour (P3 refuted), so no 6-critical core was reached; **the 5-critical cores of UD(𝔽₁₁,2) and of the triangle-free UD(𝔽₁₉,2) — 63 and 138 vertices, both 1-minimal with every necessity witness — are rigid and themselves not shadows**: 98 of 123 and 330 of 346 stress conditions fail, a 12-edge and a 29-edge witness decided in the kernel (`Instances/LiftObstruction{11,19}.lean`): the registered expectation for the 6-critical cores, measured one level down at two primes. And the
constructive reading the stub gestured at became an instrument: the **hub scan** — every residue class outside an object, tested
for a p-adic point at unit distance from ≥ 3 of its vertices by lifting each pair's glue point — enumerates in minutes, over every
field with an unramified degree-one prime above p at once, the object's exact depth-one hubs: **3,739 for the 1581 at 131 (support
up to 13, none in its half-spindle closure), 1,171 for Heule-510 (eleven of them Heule-553's discarded vertices, to the p-adic
digit)** — the constructions seen as shrunk pieces of larger configurations. Kernel: `Lift.lean` (the lift theorem χ(H) ≤ χ(G) along
an injective covering and its plane composite — the recipe a lifted forcer would consume — the naturality of the drawing, the
obstruction, its certificate consumer, the hex shell at 11 and the collinear triangle at 3 decided), the instance, the clique number
of the plane pinned at 11 and 19; 615 clean on the standard three axioms. Under the programme the milestone closes on its derivation:
the lift question is settled structurally, the finite plane survives as a filter and an enumerator (FS-12, FS-13), and the programme's
next derivation — the five-colour residue obstruction at 11 — is minted as FS-14.

**M60 — the five-colour residue obstruction (CLOSED 2026-09-07, one day; the second milestone under the programme).** The question was
what a 5-SEALED field's colourings force — the 5-colour analogue of T17 — and the answer is a two-line transfer composed with a finite
computation that one table settles. A graph with a homomorphism into the finite plane inherits every colouring of the plane, so its pair
compulsions **map forward** (`Forces.image`, `Separated.image`): a pair forced equal at five colours is forced at its residues, a virtual
edge is a virtual edge at its residues. On a Cayley graph the translations are automorphisms (Mathlib's `addCayley_adj_add_iff_right`),
so every compulsion reduces to the origin, and an origin compulsion at `d` is refuted by ONE colouring — `d` must be a PERIOD of every
colouring to be forced (`Function.Periodic`), never-coincident in every colouring to be separated. Hence two decidable properties of a
single table decide the plane's whole arity-2 compulsion structure: **the certified 5-colouring of `UD(𝔽₁₁, 2)` has no period and
coincides somewhere at every off-circle difference, so `Forces (finitePlane 11) 5 u v ↔ u = v` and `Separated ↔ Adj` in the kernel**,
with the arity floor pinned to `{3, 4, 5}` (and the tools find no arity-3 compulsion: `{4, 5}`, de Grey's bracket). Composed with the
distance law (`UDCert.drawing_quad`: the quadrance of a drawn difference IS the residue of the stored squared distance): **over the
`√7`-free tower with `11 ∤ D`, a pair forced equal at five colours has `d² ≡ 0` and a virtual edge `d² ≡ 1 (mod 11)`; so no such
certificate separates a `√3`-pair or a distance-2 pair at five colours** (`not_separated_sqrt3_11`, `not_separated_two_11`) — EACH of the
two gadgets `χ(ℝ²) ≥ 6` needs is impossible on its own over a 5-sealed field, the compulsion-level reason the 6-forcer's field must be
6-open, with the same shape as the 5-forcer's escape from 2; and the descent's cheats (distance 2) and forced pair (distance 5) were
residue-blocked at every field it ever used. Measured: the sealing planes at 3, 7, 11, 19 are ALL pairwise free at their own chromatic
number (every non-unit class identified by a verified colouring, no solver verdict load-bearing) — **and that measurement is now a THEOREM covering every prime `p ≡ 3 (mod 4)` at once (2026-09-09, ledger rows 55 and 60): `PlaneRotation.lean`, with `k`-colourability of the plane as a hypothesis, because without it the statement is false rather than merely empty.** The four tables stay as the measurement that found it;  the seed's and the descended object's
augmented planes (the cheats' residue pairs added) refuse five colours, so their forcing lives entirely outside the residue family; and
the residue filter re-read M55's 108 theorem-admitted asks on the 10,541-point grown witness (assembled exactly, every edge on the
circle): **35 of the 86 undecided fall to the theorem with a verified colouring each, 51 sit at residue norm 1** — the residue-ALLOWED
distances (`2√3`, `8/3`, `√23`, …), the only places a five-colour virtual edge can live over a sealed field (FS-16, T44). Kernel: 630
declarations clean on the standard three; the whole theory elaborates in 3.4 s. Instrument `tools/fpcompel.py` (sets / filter / augment
/ arity), with the p-adic reduction of K-frame points at the ramified prime (the seed-frame packer's truncation caught by its circle
check). P1, P2, P4, P6, P8 met; P3 refuted by derivation (the theorem); P5, P7 refuted with their numbers. Under the programme the
milestone closes on its derivation: the third in a row where the search only produced the instances the theory predicted (G46).

**M61 — the local–global tightness conjecture (CLOSED 2026-09-08, one day; the third milestone under the programme).** The question was
whether χ(F²) is always its best LOCAL bound — the walls at 2 and 3, and the finite planes' chromatic numbers at the usable primes — and
the milestone's product is the MECHANISM behind every case where it is known to be: **the spindle over a forced pair turns off exactly
the prime that sealed the fabric.** Over a field sealed at `k` by a prime `𝔭` whose plane is pairwise free, a pair forced equal at `k`
colours has `𝔭 ∣ d²` (M60's law); the spindle over it adjoins `√(4d² − 1)`, and `4d² − 1 ≡ −1 (mod 𝔭)`, so every prime of the new field
above `p` acquires `√−1` in its residue field and `p` stops being usable — the local bound the forcer beats is the one its own
construction removes (the Moser spindle: `11 = 4·3 − 1` at `3`; de Grey's and Haugland's `√15` at `2`; T20's `√247`). In the kernel as
`Forces.isEmpty_ringHom_of_spindle_radicand`: a graph forcing a pair at `k` colours, drawn in a ring holding that pair's spindle radicand,
admits no ring hom to any `ZMod p` (`p ≡ 3 mod 4`) whose plane is `k`-forces-free — through M60's transfer, the isotropy lemma
(`quadrance_eq_zero_iff`) and two lines of ring arithmetic (`isSquare_neg_one_of_spindle_radicand`); instantiated at 11 for five colours and
modelled at 3 on the rhombus, whose residues coincide exactly as the theorem's first step says. **So the 6-level of the conjecture reduces
to one question — does any 5-sealed field carry a pair forced equal at five colours? — with the pair's distances named (`11 ∣ d²`) and
the spindle's field named and 6-open by construction (`ℚ(√3, √5, √11, √43)` for a forced `√11`-pair).** The first digit (is any finite
plane exactly 6-chromatic) did NOT move, and the derivations say why it is hard: the plane is arc-transitive, so its Lovász number IS
Hoffman's bound (measured equal at eleven primes to `2·10⁻¹⁰` — every linear relaxation is exhausted below 59); every PERIODIC colouring
is a colouring of one circulant on `p` vertices (`χ_per = 3, 4, 6, 5, 8, 8, 8, …` at `3, 7, 11, 19, 23, 31, 43, …` — the 11-plane's
five is non-periodic, the 19-plane's five is periodic and became a **nineteen-entry kernel certificate**, `chromaticNumber_finitePlane19_le_five`,
and from 23 on the periodic family needs eight); and the symmetric colourings narrow with `p` (equivariant 5-colourings at 11 for rotations
of order 2 and 3, at 19 only the half-turn with a colour double-swap, at 23 every order ≥ 3 refused in seconds and the last symmetric family — the half-turn with a colour double-swap — refused by the external cadical in 18.5 min: **a 5-colouring of the 23-plane, if one exists, has no rotational symmetry at all**). The
fractional face is calibrated (α = 28 at 11 against ϑ = 34.5; α ≥ 76 at 19; the instance at 23 undecided at two hours — the
independence question has the same cliff between 19 and 23 as the colouring question) and its bound `card ≤ χ·α` is in the kernel. The
odd-degree face of the sieve got its first row: UD(𝔽₂₇, 2) refuses four colours, so a cubic field's inert prime above 3 seals nothing below
5 (Haugland's field). Instrument: `fplane.py periodic / theta / alpha / equivariant / chi --q`, 27 controls, one incident caught by the
instrument's own equivariance check (a loose encoding whose SAT verdicts were not what they claimed — its refusals stood, one of its
findings did not; §R5). Kernel 648 clean on the standard three. P2's second half settled by derivation (the opposite of the stub's
reading); P4, P6 (at 23), P7 met; P1, P5, P8 undecided with their walls; G48 minted; FS-15 closed as M61, FS-17 (the first digit at 23
by cube-and-conquer, priced) minted.

**Theorem B and Theorem A in the kernel, and the prior-art correction of 2026-09-08 (Opus 5, on the backlog;
`plans/B1-field-wall-kernel.md`, `plans/A1-theorem-A-kernel.md`).** Two theorems landed and one correction
landed on top of them. **Theorem B — χ(ℚ(√3, √11)²) = 4 — is kernel-checked** (`FieldWall4.lean`, zero sorry,
standard three axioms): the residue colouring of the seam plane by the order `O = ℤ[ω, i, T]` and its two maps
onto `𝔽₄`, with the hand proof's valuation theory replaced by an elementary **parity descent** (the joint kernel
of the two residue maps is visibly `(1+i)·O`, so an even denominator halves), and the Moser spindle exhibited as
an identity in the order (no `Real.sqrt` in the lower bound). The consequence that halted M53 is now a theorem:
no `K`-point unit-distance graph carries a pair compulsion at five colours. **Theorem A — the general residue
colouring — is kernel-checked too** (`ResidueColouring.lean`), and it came out stronger than the write-up states
it: a graph *drawn* in an abelian group whose edge differences lie in a subgroup and are nonzero under a
homomorphism out of it is `|G|`-colourable — no metric, no field, no ring, no Cayley structure — with the
arithmetic reduced to two facts (a norm-one element of a σ-stable subring is a **unit** of it, so its residue is
nonzero; a σ-stable **valuation subring** contains every norm-one element, which is Theorem A's `v_𝔭(u) = 0` step
in two lines). Theorem B is re-derived as an instance and `FieldWall4` got *smaller*. **What is not proved and
is said so in the module: that a number field with a conjugation-fixed prime supplies the valuation subring with
residue field of size `N(𝔭)`** — the σ-stability half IS proved (`conj_mem_valuationSubringAtPrime`, four lines,
because it is not a statement about valuations at all).

**Then the correction, and it is the more important half.** Asked whether one side observation of the Theorem A
close was known, the check found it known twice over — and found **[Moorhouse2010]**, *On the Chromatic Numbers
of Planes* (preliminary draft, 3 March 2010, unpublished, little cited, now held and read in full). It is the
same programme as M58–M61: `K²` over any commutative ring (§1), `χ(K²) = χ(K₀²)` and the Cayley-hom lemma
(§3.1, §4.2), the `𝔭`-integrality of unit vectors (Lemma 2.3), **the finite-plane bound itself** ("there exists
a graph homomorphism `K² → 𝔽_q²` so that `χ(K²) ≤ χ(𝔽_q²)`", §8.2 and §10.3), **`χ(𝔽₁₁²) = 5` in Table 6.1**,
the 2-adic residue colouring for odd-degree fields (§7.1), and the observation that beating the minimum over
primes requires refuting **Hedetniemi's Conjecture** (§9). And **[Fischer1990]** — a paper this project has held
and read since M56 — contains the component lemma and the unit argument. **The rows this corrects are marked in
place below (52, 53, 56, 47).** What it does NOT touch: Theorem B, the 2-adic wall criterion, the field sieve,
M59's lift theory, M60's compulsion transfer, M61's tightness mechanism, and every kernel certificate.

**And it cuts the other way once.** Moorhouse §1 names `ℚ(√3, √11)` as the smallest number field whose plane
holds a Moser spindle, gets `χ ≥ 4`, and writes: *"We have not determined the exact value of χ(K²) in this
case."* **Theorem B answers that stated open question**, and it is now kernel-checked. **AND TWO MORE, found on the library read of 2026-09-08 (FS-18): Benda–Perles's Open Problem 11.6** (via [Soifer2024] ch. 11 — *"Find the chromatic number of `ℚ²(√2)` and, in general, of any algebraic extension of `ℚ²`"*) **and [CranstonRabern2015]'s** (*"What is the fractional chromatic number of `ℚ(√3,√11) × ℚ(√3,√11)`? What about its chromatic number?"* — the second half is Theorem B, and with their `χ_f ≥ 76/21` the first is now bracketed `76/21 ≤ χ_f(K²) ≤ 4`). His Table 6.1 also leaves
`χ(𝔽₁₃²) ∈ {5,6}` — which the pivot settled at 5 without knowing it was open — and **`χ(𝔽₁₇²) ∈ {5,6,7}`, still
open and never touched here**: 289 vertices against the 23-plane's 529, and a 6 there answers the first digit's
*range* question (though not its sieve question — 17 ≡ 1 mod 4 is never a usable prime).

**FS-18 — THE LIBRARY READ (2026-09-08, one day; Kooshi's override of the backlog plan: "our goal will be to read
everything which is unread in our library and see what we learn").** Twenty-one works read, six fetched the same day,
five named and not obtained. **The pass changed the ranking, which was its registered measure of success**, and it
produced more corrections than the check that caused it.

**POSTSCRIPT, the same day: `[Madore2015]`, and it is the closest prior art this project has.** Kooshi obtained
`[Krebs2022]` from Springer directly — the earlier "no free copy anywhere" was a statement about what `curl` can
fetch past a JavaScript client-challenge, not about the world (G21 again, on my own instrument) — and its
reference [10] named a paper nobody here had heard of: **D. A. Madore, *The Hadwiger–Nelson problem over certain
fields*, arXiv:1509.07023 (2015)**. It contains: **Theorem A's valuation-subring form (his Prop. 3.2**, with the
coset-representative construction); **the finite-plane bound (his Cor. 3.4)**, a fourth independent source;
**a `mod m²` refinement (his Prop. 3.8)** that our parity descent re-derives; **an explicit 11 × 11 five-colouring
of `𝔽₁₁²` with the footnote "In fact, χ((F11)²) = 5, but we will neither prove nor use this"**; `χ(ℚ(√3)²) = χ(ℚ(√7)²) = 3`;
and **Proposition 4.6: `4 ≤ χ(ℚ(√3,√11)²) ≤ 5`** — the bracket Theorem B closes, and the closest anyone has come.
**What survives is precisely delimited and is better than a consolation:** in his Prop. 3.9 he needs a subgroup
that is not a ring, does the coset construction by hand, and writes *"which the author has not found the courage
to try to formulate under the most general auspices"* — **Theorem A is that general formulation, and it is
kernel-checked.** He cites none of Fischer, Moorhouse, Manturov, Vinh, Johnson or Chow. **The reduction has now
been derived independently five times** (Fischer 1990, Moorhouse 2010, Manturov 2012, Madore 2015, here 2026)
with almost no cross-citation — which is G49's two-literatures diagnosis at full strength, and stops being a
story about this project's diligence.

*And the one page we most wanted turned out thin.* `[Krebs2022]`'s entire `χ > ω` content is his Proposition 6.1
— if `ω ∤ q^n` then `χ ≥ ω + 1`, by a counting argument — **which is weaker than what we already hold at every
prime that matters** (it gives `χ ≥ 4` at `p = 11` where the kernel has `χ = 5`). **So G24/G40/G44's gap question
is not settled in the literature and stays ours.** His Theorem 5.2 does confirm the clique closed form, for any
field rather than only finite ones.

*What it gave for free.* **The clique number of every finite Euclidean plane, in closed form**: `ω(UD(𝔽_q,2)) = 3` if `char = 3` or 3 is a square in `𝔽_q`, and 2 otherwise — so for `p ≡ 3 (mod 4)`, `ω = 3` iff `p ≡ 11 (mod 12)`. This is `[Krebs2022]`'s theorem, reached through `[LorenzZimmermann2023]` because Krebs is closed access with no preprint, and it agrees with all six values this project had computed one prime at a time. M59's and M61's per-prime `ω` decides are retired. **What could not be reached, and is now the single most wanted page in the literature for us, is Krebs's criterion for when `χ` strictly exceeds `ω`** — no citing paper reproduces it, and it is precisely G24/G40/G44's subject.

*One thing the read got RIGHT by going back to the source.* [SokolovVoronov2025]'s gloss of [Manta2021] (*"it would take 7 colors to color a plane divided into triangles"*) reads like earlier prior art for the cell family. It is not: **Manta's theorem needs a vertex of degree ≥ 4, and the nearest-point cells of a triangular lattice are hexagons meeting three at a vertex.** He says so himself — his Question 6.1 asks precisely for the all-vertices-degree-≤-3 case, notes that is where the classical hexagonal and square 7-colourings live, and says settling it would give `χ_poly = 7`. **That question is what Sokolov–Voronov answer, and it is their theorem, not his, that subsumes our floor.** Also from Manta: for triangle colourings the value is 7 or 8 and undecided.

*What it corrected.* **(1) M56's L7 is [Fischer1990]'s Theorem 10(ii).** Our `1/d² ∈ Σ₀` obstruction and his `1/k ∈ Σ₀`
argument are the same lemma — a norm-one `ξ` has `ξ + ξ̄ ∈ Σ₀`, and a spindle rotation at distance `d` is exactly a
norm-one element with `ρ + ρ̄ = 2 − 1/d²`. His Example 4 (`N = 167`) already states G38's punchline in 1990: *a plane
that IS 7-colourable can have no additive 7-colouring.* **(2) The finite-plane bound has a third independent source**,
[Manturov2012] — held in `library/pdf/` since 2026-09-05 and never opened — whose Theorems 17–19 give the reduction
along a ring homomorphism in all dimensions (*"here 'taking the residue class' means considering the corresponding ring
homomorphism"*). He has no usable-prime analysis, no exact finite-plane value, and no number fields. **(3) The cell
family's `≥ 7` floor is subsumed**: [SokolovVoronov2025]'s Theorem 2 is `χ_poly(ℝ²) = 7` — no polygonal colouring of
the plane in six colours — and a colouring constant on the hexagonal cells of a triangular lattice is polygonal, so
M38–M43's floor at every scale follows in one line, unconditionally. **(4) `ω(UD(𝔽_q,2)) ≤ 4` for every `q`, and
`D_q` is triangle-free iff `q ≡ ±7 (mod 12)`, are [Vinh2006]** (the second Vinh paper, which was not in our
bibliography at all); M59 pinned two values by kernel `decide` where a general theorem existed. **(5) `ω ≠ χ` on every
finite plane above `p = 3`** is [SchneiderSilva2013] Theorem 4.7(3) (`ω = χ ⟺ m ∣ p+1`, and our `m = p−1`) — the
`χ`-versus-`ω` gap that G24/G40/G44 treat as the programme's own subject is a published fact.

*What it discharged.* **[Voronov2023] was read and proves exactly what M43 says it proves** — `χ_[1−ε,1+ε](ℝ²) ≥ 7`
for every `ε > 0` and every 2-dimensional norm, by a **non-computational** argument — so G24 and G29's conditional
becomes unconditional. It carries two bonuses we did not have: an explicit bounded region (a disc of radius 3 covered
by six closed sets realizes the unit distance) and the state-of-the-art chain `5 ≤ χ ≤ χ_mes ≤ χ_map ≤ 7 ≤ χ_[1−ε,1+ε]`
with `χ_map ≥ 6` already known.

*What it gave back.* **Theorem B answers two more stated open questions**, independently posed and both older than
Moorhouse's. [Soifer2024] ch. 11 records **Benda–Perles Open Problem 11.6** — *"Find the chromatic number of `ℚ²(√2)`
and, in general, of any algebraic extension of `ℚ²`"* — and [CranstonRabern2015] ask, verbatim, *"What is the fractional
chromatic number of `ℚ(√3,√11) × ℚ(√3,√11)`? What about its chromatic number?"*, having shown `χ_f(K²) ≥ 76/21` on an
object built from a triangular lattice and Moser spindles at multiples of `arccos(5/6)` — our own direction ladder.
**Theorem B closes the second question and brackets the first at `76/21 ≤ χ_f(K²) ≤ 4`.** So the same problem was posted
three times, by three groups who do not cite each other, and this project answered it without knowing any of them —
which is G49's two-literatures diagnosis measured a second time rather than argued. **AND A SEVENTH SOURCE FOR THE RECIPE, 2026-09-09 (FS-23): `[Polymath16wiki]` (4 June 2018) states Theorem A's SHAPE informally** — *"Step 1: find a ring-homomorphism from `R` to a finite ring `F`. Step 2: find the image `T` in `F` of the set of all elements of unit modulus in `R`. Step 3: look for a `k`-coloring of `F` such that no two elements that differ by an element in `T` have the same color"* — together with **"linear" colourings** (a hom onto a finite group of order `k`, i.e. Fischer's additive colourings) and the periodic-quotient fact M61 re-derived. **What is still not there, and is what `colorable_of_residue` actually says**: no ring is needed, no finite target ring, no unit modulus, and the homomorphism may be **partial** — defined on a subgroup and extended by coset representatives, which is exactly the step `[Madore2015]` performed by hand and declined to formulate. The wiki's recipe is a heuristic with no theorem and no proof; ours is a theorem the kernel checked. But the recipe was on a public wiki eight years before we wrote it down, and **FS-20 must say so.**

*One convergence worth naming.* [Vinh2006]'s Lemma 3 — two circles `C_i(X)`, `C_j(Y)` at `Q(X,Y) = k` meet in 0, 1 or 2
points according as `f(i,j,k) = ij − (i−j−k)²/4` is a non-square, zero, or a square — **is our gluing classification
(ledger row 17) over a finite field**, the same discriminant and the same trichotomy, with "square" degenerating to
"nonnegative" over `ℝ`. Since M58 made `unitQuadrance` a functor of the coordinate ring, these are one theorem at two
rings, and `Glue.sphere_inter_sphere` could be stated once over both.

*One error found in the literature, ours.* [Vinh2006] restates the 2005 lower bound as `1 + (q − (−1)^{(q−1)/2})/q^{1/2}`,
dropping a factor 2 in the denominator. That form gives `χ(UD(𝔽₁₉,2)) ≥ 6`, contradicting our **kernel-checked**
`chromaticNumber_finitePlane19_le_five`; the exact spectrum (computed here) has `λ_min = −7.61` at `q = 19` against
`√19 = 4.36`, so Hoffman's true value is 3.628. The 2005 source's asymptotic form is correct and agrees with ours. His
Theorem 4 leans on the bad form; [SchneiderSilva2013] proves it properly.

### The novel-results ledger (all kernel-checked unless marked)
*Reading the **Where** column. Paths under `Proofs/`, `data/`, `plans/`, `tools/`, `scripts/`,
`library/` and `reference/` are **tracked**: they are in the repository and a fresh clone has them.
Paths under **`build/` are LOCAL measurement artifacts and are not tracked** — `build/` is gitignored
(29 GB on the working machine, of which the ledger cites 51 MB), the files are regenerable from
`tools/`, and by this project's own standard they are the *search*, never the certificate: what a
reviewer re-checks is the Lean module beside them. From M51 onward artifacts were written to `data/`
instead, which is why the `build/` citations all predate it; they are kept as provenance, not as
promises. **Decided 2026-09-09 (FS-26 B3) rather than fixed**: copying them into git would add 51 MB
of untrusted search output to a proof repository to satisfy a citation whose value is historical.
Noted with it, because it is a `G21` instance on our own instrument: the record audit of 2026-09-09
reported that *all 176 cited artifact paths exist*, and that was true **of the directory it ran in**
— in a fresh checkout exactly one of the 34 cited `build/` paths resolves.*


| # | Result | Where | Milestone |
|---|---|---|---|
| 1 | **The two-circle theorem**: every unit-distance graph on the circles of radius 1 and 1/√3 about a common point — the full uncountable set included — is 3-colourable. The local barrier: no cover-set-internal gadget beats the rainbow floor. | `TwoCircle.lean` (`colorable_three_induce`/`_comap`) | M19 |
| 2 | **The seam identity**: the cross-chord rotation between the two circles is `(√3 + i√33)/6`, of infinite order (its trace squares to 1/3, no algebraic integer) — the true geometric identity of the √33 "resistance" family, and the fact that makes two-circle labels a strip `ℤ/6 × ℤ`, never a torus. | `TwoCircle.seam_pow_ne_one` | M19 |
| 3 | **The coverage ratchet**: coverage lower bounds (`CoverAtLeast`) are monotone under adding edges, widening the class, lowering the level; at level k the property *is* the fan. Gadget-union hunting climbs a certified gradient. | `CoverageMono.lean` | M19 |
| 4 | **Fan ⟺ compulsory coverage**: a pivot is fanned iff every proper k-colouring puts all k colours on `N(p) ∪ Q` — confinement as a measurable number. | `Coverage.lean` (`fan_iff_coverage`) | M18 |
| 5 | **No class confines alone**: two circles share ≤ 2 points ⟹ in-class degree ≤ 2 ⟹ every class-only graph is 3-colourable ⟹ a 4th colour always frees the pivot. Confinement is an interplay theorem. | `ClassGeometry.lean` (`not_fan_classOnlyGraph`) | M18 |
| 6 | **The 120° triangle identity**: a unit triangle sits on a circle about p iff r² = 1/3, and the equidistant point is the centroid; the ℤ/3 closure partitions the class into rainbow triangles. | `ClassGeometry.lean` (`exists_unit_triangle_iff`, `rot3_unit_triangle`) | M18 |
| 7 | **Greedy colouring** (`degree < k` everywhere ⟹ k-colourable), genuinely missing from Mathlib. | `Greedy.lean` | M18 |
| 8 | **De Grey's graph admits a balanced 5-colouring** — class sizes [317, 316, 316, 316, 316], the pigeonhole optimum, kernel-certified from a packed witness. No density obstruction at witness scale (closure scale too, tools-only). | `DeGreyBalanced.lean` | M19 |
| 9 | **The 120° compulsion** (M20): in every proper 3-colouring of the two circles, an outer 120°-triple — three pairwise *non-adjacent* points — is never monochromatic: its seam-image unit triangle is rainbow and refuses. The first colour compulsion here that acts through no edge. | `Compulsion.lean` (`no_mono_outer_triple`) | M20 |
| 10 | **The one-pivot cap**: {p} ∪ both circles has chromatic number exactly 4 — nine points force the 4th colour (centre + five consecutive outer + the witness triangle); M19's colouring plus a fresh colour at p gives ≤ 4. Coverage 4 at five colours cannot arise inside one pivot's system. | `Compulsion.lean` (`chromaticNumber_concentric`) | M20 |
| 11 | **The strip automaton**: the two-circle graph splits into two tubes (parity invariant); per tube the colouring theory is exact — the recurrent core is (non-mono hexagon columns) × (all rainbow pairs) = 864 states, one SCC; every non-mono hexagon admits exactly 4 avoiding rainbow columns whose continuations count {2,2,4,4} — the space grows by exactly ×12 per column; and the **window-extension theorem**: every proper colouring of a ≥2-column window extends to the whole bi-infinite tube (the lone mono-parity column is the only finite obstruction). Finite parts by kernel `decide` against literal tables; the extension is computable. | `Strip.lean` (`window_extends`, `twostep_card`, …) | M20 |
| 12 | **The extension profile** (instrument + measurement): per pivot, every locally-legal 3-pattern of the cover set SAT-tested for ambient realizability — bias-free by construction; controls both ways (a certified-confined pivot shows an empty profile, 1,000/1,000 sampled patterns killed). At the closure's doubling pivot the profile is FULL (6,144/6,144). | `tools/extend.py` + `build/m20-profile-630.json` (tools-side) | M20 |
| 13 | **Negative knowledge, held to the same standard**: growth-family hunt closed exhaustively (M17, 557M class-tests); "ambient near-forcing" retracted — pool statistics measure the SAT solver's tastes, not the colouring space (three pre-registered hypotheses refuted with matched controls, M19 §0); pentagon exclusion is a fact about the coordinate field, not the plane (M18). | plans + instrument docstrings | M17–M19 |
| 14 | **The pair-gluing classification**: for two pivots at distance 1, every one of the four circle-pair intersections is *exactly* {a point, its mirror} — outer∩outer = the hex step, outer∩inner = the seam image (each way), inner∩inner = the new half-sector direction `⟨1/2, √3/6⟩` = ζ₁₂/√3 — all under ONE involutive isometry `reflAcross` (the configuration's whole symmetry), with the interlock `seamImage p q ∈ inner_p ∩ outer_q`. The 5th-colour lower bound holds superset-quantified: any vertex set containing one pivot's system needs 4 colours. | `Coupled.lean` (`outer_inter_outer` …, `four_le_chromaticNumber_of_system_subset`) | M21 |
| 15 | **The first nonzero extension pressure** (tools-side, verified): at the closure's strongest-coupled far pair (d = 1, 40 cross chords), 785/1500 sampled pattern pairs die on the cross chords alone and 229/715 of the locally-feasible are killed by the ambient graph — every sampled kill re-confirmed through an independent pin-only injection encoding; the null pair is 1500/1500 flat. The pressure is *selective*: the union's coverage floor stays 3 and the pair lattice stays 4-colourable at every affordable depth. Each kill is already in `Fan.of_unsat` pin-cube form. | `tools/couple.py` + `build/m21-joint-695-2044.json` | M21 |
| 16 | **The coupled automaton is dead, exactly**: no relation `u^{2m}σ^lζ₆^k = 1` at any probed pivot pair (\|m\|,\|l\| ≤ 6) — the coupling phase is incommensurate with the strip lattice everywhere, so two coupled strips never form a finite-state product; and **no pair of rotated/reflected/re-paletted 60°-sector colourings is proper on the d = 1 pair** (full continuous-offset sweep, killed by the outer–outer curve family alone) — any χ ≤ 4 proof for the pair needs a construction shape nobody has named. | `tools/couple.py` (`--phase`, `--mesh`) + `build/m21-phase.json` | M21 |
| 17 | **The general gluing classification**: for ANY two distinct centres and any radii under the annulus condition, the circle intersection is exactly {an explicit glue point, its mirror} — the glue point division-once with the **gluing discriminant** under its √ (the exact object partner adjunction adjoins), the mirror by ratio conjugation (`reflAxis`, an involutive isometry at every axis, collapsing to M21's `reflAcross` at unit axis); empty cases certified both ways; radius nonnegativity *derived*, not assumed. Subsumes M21's four gluings; the metapivot instance (axis 1/√3) is a spec example. **CONVERGENCE NOTED 2026-09-08 (FS-18), not a correction:** [Vinh2006]'s Lemma 3 is this classification over a finite field — two circles `C_i(X)`, `C_j(Y)` with `Q(X,Y) = k` meet in 0, 1 or 2 points according as `f(i,j,k) = ij − (i−j−k)²/4` is a non-square, zero, or a square. Same discriminant, same trichotomy; over `ℝ` "square" degenerates to "nonnegative". Since M58 made `unitQuadrance` a functor of the coordinate ring, these are one theorem at two rings — `Glue.sphere_inter_sphere` could be stated once over both, and `PartnerLattice.lean`'s depth-one enumeration would then hold over every ring at once. Independent and simultaneous in spirit rather than prior art (his 2006, our M22 2026), but it is the same mathematics and is recorded as such. | `Glue.lean` (`sphere_inter_sphere`, `reflAxis_*`) | M22 |
| 18 | **The first certified near-relation**: `ζ₆·σ⁹` misses 1 by chord < 1/50 (`normSq (ζ₆σ⁹ − 1) < 1/2500`; numerically 1.008°, chord ≈ 0.0176) AND `ζ₆·σ⁹ ≠ 1` (via σ⁵⁴ ≠ 1, the seam's infinite order) — nine seam steps almost close one hex step, and provably never do. Both halves exact field arithmetic in ℚ(√3,√11,√33). The aiming lemma of the colour-closure thread. | `Glue.lean` (`zeta6_mul_seam_pow_nine_ne_one`, `normSq_zeta6_mul_seam_pow_nine_sub_one_lt`) | M22 |
| 19 | **The kill mechanism named + the partner web measured** (tools-side, controlled): ambient kills need the partner's OUTER circle in 100% of probed cases and the inner in 75%; greedy pin cores are 4–8 pins (median 6), leaning inner on the pinned side; local kills are multi-class Hall failures (0/804 starvation); local slack does not predict ambient death — the clamp specification for gadget design. Post-hoc decomposition (single pair, unregistered — M23 §0 re-tests it): core-pin separations concentrate on the pure seam-angle lattice {j·θσ mod 60°} (+15 pts over matched controls, above all decoys) and are depleted at the half-offset (−19 pts); the near-cycle-shadow reading was refuted by a 20-decoy specificity sweep. **DEMOTED at M23**: the seam-alignment reading failed its registered replication at four fresh 40-chord pairs (0/4; excesses +7.4/−7.3/+12.1/−13.4) — single-pair anecdote, not a mechanism. Partner closure: 67–70% of unit-partners collide back into the lattice; the field grows far less than feared — 76% of adjunction instances are FREE, radicand already square in ℚ(√3,√11) (sympy-exact, five planted controls, from the `opus-larp` branch's parallel pass — superseding M22's 37.5% PSLQ triage, which sampled only non-collided partners); and k = 4 stays SAT through two generations (15,619 points, ~2.4M triage edges at the full depth-20 base) — the fork does not move by depth. Near-cycles are dense and CF-structured (records at l = 1, 4, 5, 9, 59; every probed pair < 0.3° at word length ≤ 12). | `tools/couple.py` (`--kills`, `--partner`, `--near`) + `build/m22-*.json` | M22 |

| 20 | **The pivot-triangle layer** (all kernel-checked): the triangle is self-glued — `hexStep` permutes the pivots cyclically, so outer∩outer of any two pivots = {the third pivot, its mirror}; the centroid is the (+)-branch ii glue of ALL THREE pairs; the metapivot couplings create no new points — outer(pᵢ)∩inner(m) = the other two pivots, inner(pᵢ)∩outer(m) = the two 120°-partners, inner(pᵢ)∩inner(m) = the two mirror centroids; **the ten-point sharing theorem** (two unit-separated systems share exactly {pivots} ∪ {eight glue points}, with `ncard = 10`); **the chord classifications** — outer–outer unit chords are RIGID (translate ∨ hub: the perfect matching is complete, for the full uncountable circles) and inner–inner chords are matching ∨ the rational Möbius graph x(3y−2) = y, so √disc field growth is localized to mixed-radius chords; the translation coupling; and the loop layer — the **rotation hexagon** (S₂⁻¹S₁S₀⁻¹S₂S₁⁻¹S₀ = id for ANY unit rotation about ANY three points — found generic at implementation) with the seam instance, the hex parallelogram (hex-specific, minimal at 4), and the zpow closure backbone. Census (exact, tools): 34-point inventory in the seam field, 7 triple points; seam relations minimal at 6, all 3-pivot, none 2-pivot; R_m unreachable from pivot words. | `Triangle.lean` + `tools/couple.py --loops/--export-viz` | M23 |
| 21 | **The registered statistics, reported at face value** (tools-side): ambient kills are **coupling-strength gated** — 0 kills in 3,200 draws at four 22-chord fresh pairs vs 12–15% kill rate at every 40-chord fresh pair (all kills injection-verified); M22's seam-alignment reading **failed registered replication** (0/4 pairs; demoted per its pre-committed failure clause); the coset census under threshold (×0.83–1.51 vs registered ≥2×); the metapivot's cover floor stays 3 (registered null confirmed; higher unions read 4 for reasons the self-gluing theorems explain); and the triple census's registered population is **provably empty** — unit triangles are never "far", their cover sets always interlock through the shared ten points. | `tools/couple.py --replicate/--floor --systems` + `build/m23-*.json` | M23 |
| 22 | **The matched ladder pair is exactly 4-chromatic, unconditionally** — the countable two-pivot ⟨ζ₆,σ⟩-lattice closed under ALL unit chords. Every chord family is a theorem: oo = matching ∨ hub (`oo_complete`); ii = matching ∨ ten table rows, via the parity split in ℤ[ζ₆,π] — mixed parity impossible, even collapses on the backbone, odd closes by mod-3 coordinate congruences, mixed SIGNS die through the collapse π^b·π̄^e = 3^e·π^{b−e} (`ii_norm_complete`); oi = **sixteen chords ever, no infinite family** — the trace pair T(x,h) = ζ₆^x π^h + ζ₆^{−x} π̄^h, uniform √3^(m+n+k) clearing, three parity kills, address pins feeding a telescope kill, three 36-pair boundary checks (`oi_complete`); intra = hex/rot3/seam exactly; eight fusions pinned; plus the 24-entry b-independent colouring proper on every family and the nine-point witness forcing 4 (`chromaticNumber_ladderPair`). First exact chromatic number of an infinite genuinely-coupled object; the first Frontier χ-equality with no census window and no conditional clause. Supporting cast now reusable: `sqrt_indep` (ℚ-independence of {1,√3,√11,√33}), the axis-general master identities, the Re = √3/2 fibre proven EMPTY (ζ₁₂ never lattice). | `Ladder.lean` (`chromaticNumber_ladderPair`, `ii_norm_complete`, `oi_complete`, `iiNormTable`/`oiTable`) | M24 |
| 24 | **The hexagram is exactly 4-chromatic, unconditionally** — the six pivots of the 1/√3-hexagon about the metapivot (M23's triangle plus the mirror centroids), all seven ⟨ζ₆,σ⟩-ladders, closed under ALL unit chords. The engine: the **self-seeding identity** `hexPivot a = m·(1+ζ₆^a)` (the pivots are the meta-inner hex layer, so every hexagram coordinate is one metapivot multiplication from a hex root); the **rot6 orbit collapse** (60° about m is an automorphism ⟹ 21 centre pairs, FOUR orbits, only adjacent + opposite webs new); ONE master identity `normSq(αgu−βgv−γ)` with BOTH singles g-traces, cleared by `hex_cleared` into M24 trace pairs; one live parity class per family, four kills (alone/φ/equal-height collapse/M25's mod-9 adjacent-height), and the two surviving boundaries returned as data for per-table decides. All eight new-web families are theorems (`adj_oo_empty`, `adj_oi/io/ii_complete` — four sporadics each; `opp_oo_complete` — four sporadics; `opp_oi/io/ii_empty`), all eight fusions EMPTY (the mirror triangle touches the original ONLY at M23's glue points; the tangency at m invisible), the pivot–meta webs extended to all six addresses free by transport, unit pairs in hexagram currency, and the rot6-equivariant 4-colouring (`colour∘rot6 = τ∘colour`, τ a 3-cycle) proper on every family. On axioms exactly `[propext, Classical.choice, Quot.sound]`. Census promoted: `tools/couple.py --hexagram-census` (exact 84-sweep, planted chord+fusion refusals); two real instrument bugs (0°/360° bin wrap, hub-marker skip) found by the rot6-automorphism control and fixed; plus a gate bug in `axioms.sh` (pipefail vs `grep -q` SIGPIPE past 64 KB) that failed CLOSED, repaired. | `Hexagram.lean` (`chromaticNumber_hexagram`, `adj_*`/`opp_*`/`hexMeta_*`/`unit_oo_complete`, `hexColTab_equivariant`) | M26 |
| 23 | **The four-ladder object is exactly 4-chromatic, unconditionally** — the pivot triangle's three ladders plus the metapivot's own (anchored along ζ₁₂), closed under ALL unit chords. The engine: `√3·ζ₁₂ = 1+ζ₆` (`sqrt3_mul_zeta12`) eliminates the twelfth root, so M24's ℤ[ζ₆,π] machinery carries verbatim through `hexTrace` (trace pairs with arbitrary ℤ[ζ₆] coefficients). All twelve pivot–meta families are theorems (`meta_oo/oi/io/ii_complete`, j-quantified over the three webs by the 120° rotation transport); the **fusion inventory is certified by the same engine at norm-0 constants** (`meta_fusion_*`: oi = the two shared pivots, oo/io/ii EMPTY); the kills beyond M24: `alone_dvd` and `phi_dvd` (the generic 3-adic pair) and the mod-9 `adjacent_kill` — two g-traces at heights h, h+1 never sum to 9·(anything), the piCoeff recurrence confining the two deep residues to {1,4,7} — which closes the height-unbounded branches a census can only sample. Colouring: the 48-entry b-independent `metaColTab`, decode well-defined by the fusion inventory, properness per family; χ ≥ 4 transports M24's witness. Census promoted: `tools/couple.py --meta-census` (planted-disagreement self-test). | `MetaLadder.lean` (`chromaticNumber_fourLadder`, `meta_*_complete`, `meta_fusion_*`, `adjacent_kill`) | M25 |
| 25 | **The field-wall identity, kernel-checked**: the Moser spindle's twist rotation ρ (cos 5/6, sin √11/6) satisfies ρ·σ² = −1, i.e. ρ = ζ₆³·σ⁻² — the twist that forces the 4th colour is a word in the seam group, while the 5-forcers need √5 and √7. The thesis that moved the programme off the seam field, as a theorem. | `FieldWall.lean` (`moserTwist_mul_seam_sq`, `moserTwist_eq_zeta6_cube_mul_seam_inv_sq`) | M30 |
| 27 | **The quadrature law + the closure measurements** (tools-side; the law derived a priori in the registered subplan, then verified at 26 exact censuses, zero violations): a detuned copy R·X of seam material couples to X only along anchor-collinear pairs (R = s·W, W an even half-spindle word) or anchor-perpendicular pairs (W odd) on the conic t²+r²∓2·{Re,Im}(W)(±tr) = 1; mixed-family detunes couple NOWHERE. Measured instances: the (2,2) spindle diagonal (the hexagram holds hex-ray material at exact distance 2 from its pivots), the (2/3,2/3) perpendicular diagonal, the **conjugate-ring channel** (17∓√33)/6 ↔ (17±√33)/6 at t·r = 8/3. Verdicts: mitotic hexagram χ = 4 everywhere (G6's single-detune causal bet dead); de Grey pair = 6 seam chords + the predicted centre spindle chord, χ = 4; 1581 gen-1 closure (24,065 pts, 123,134 chords, 11,016 rings) k = 5 SAT in 1.14 s; the k = 4 frontier with full gen-1 enrichment 4-colours everything below the witness scale — **the 5-mechanism is irreducibly global at this order** (third independent measurement); Heule-510 minus its centre: zero forced pairs, zero virtual edges, settled — no rigidity shadow one vertex below criticality. Instruments: `tools/closure.py` (the law enforced at find time, planted-failure self-tests), the closure explorer `tools/closure-viz.html` + refresh. | `build/m31-*.json`, `plans/M31-minimal-five-closure.md` §R | M31 |
| 28 | **The 2-adic kill engine, kernel-checked** — the first Lean theorems one field up: `sqrt5_indep` (a vanishing A + √5·B over the {1,√3,√11,√33} basis has all eight ℚ-coefficients zero) proven DIVISION-FREE by squaring to A² = 5B², reading four equations through M24's `sqrt_indep`, and killing the integer system by **mod-5 descent** — one kernel `decide` over (ZMod 5)⁴ (625 tuples, the house mod-p congruence style) plus strong induction on the ℓ¹-norm; the √7 analogue is a numeral change. On top: `sqrt15_split` (the workhorse every 2-adic clearing cites), `sqrt_indep₈` (the flat eight-term independence), **`quadrature_rho15`** — M31's quadrature law (G12), ρ₁₅ instance, as a theorem: a unit chord between seam-coordinate points and a ρ₁₅-detune forces Im(u·v̄) = 0 AND \|u\|²+\|v\|²−(7/4)·Re(u·v̄) = 1 — and `pair_tangency` (the unit circles about 0 and 2 meet exactly at the midpoint). Method note: every linear_combination witness was sympy-derived by polynomial reduction over the radical ideal and verified to zero residual BEFORE being stated — the M26 script-first discipline applied to proof terms; all landed first try. | `Quadrature.lean` (`sqrt5_indep`, `sqrt15_split`, `sqrt_indep₈`, `quadrature_rho15`, `pair_tangency`) | M32 |
| 29 | **The stacking law + the flat designed-forcer verdict** (tools-side; the law derived a priori in §0a, then confirmed at every census point): same-anchor stacks reduce to the single-word law forever (the relative detune is the spec quotient — detunes form a group); same-word different-anchor stacks couple through a difference pin (w = u−v collinear with the twisted anchor axis, \|w\| on a quadratic) whose w = 0 root at UNIT anchor separation is an O(n) **translation matching** — measured: 132 exact matching chords at the triangle's unit pivots, ZERO at the √59-sterile 1/√3 separation, chirality channel exactly empty. The verdict: matchings are 1-regular, **width without degree does not force** — the triangle stack's 26 spanning forced-rainbow unit triangles (the first designed triple-order cross structure) still read zero forced pairs, zero virtual edges, zero coverage movement, zero compelled triples, χ = 4 everywhere; the 5-mechanism's irreducible globality extends to designed one-family objects (fourth measurement). Base-rate finding: pivot-circle min-cover rises 2 → 3 from B = 1 to B = 2 (ambient coverage pressure builds with depth) while the metapivot circle stays at 2. New instruments: the coverage/triple meters (palette-WLOG single SAT calls, free vacuity guard), the stack census with class-routed certificates. | `tools/rigidity.py` (meters), `tools/closure.py` (stacks), `build/m32-*.json`, `plans/M32-certified-five.md` §R | M32 |
| 26 | **The de Grey anatomy** (tools-side, every instrument control seen red/green on cue): the 1581 has exactly **67 edge-direction classes**, ALL words in the half-spindle group ⟨ζ₁₂, σ, √ρ₁₅, √ρ₆₃⟩ at exponent ≤ 6 (the registered whole-word group covers 58%; every miss squares in; σ-exponents only {0,±1,±2}); Heule 510/553 carry 6 out-of-group residue classes each — the 1581 is the only pure-group witness; E3 refuted (819 circles, 4,140 coarse classes, top-6 = 3.7%, flat head) and the load-bearing census deflated by its matched control — **the 1581 is at or near edge-critical**, the 5-forcing distributed; the complete forced-pair inventory of the 791 forcer: **six pairs** — M13's axis pair plus five ANTIPODAL pairs at distance 4/√3 (√183-spindle, outside the field): every proper 4-colouring is centrally symmetric on the radius-2/√3 circle; E2 exact (norms 4 and 16 — the M32 clearing is 2-adic); fusion record {1:1344, 2:234, 4:1, 24:2}; E4 refuted both halves — the 4-chromatic hexagram chunk's colour space is > 10⁴ up to rot6 × palette with ZERO forced pairs (settled exactly), and the 1581's 5-colouring space is likewise pairwise-floppy (0 forced, 0 virtual, settled) — rigidity in both fields lives only at the forcing level k−1, never above. Instruments promoted: `tools/anatomy.py`, `tools/rigidity.py` (complete pairwise forced-equal/virtual-edge oracle, batch violation queries, vacuity guard), `tools/hexchunk.py`, the anatomy visualizer `tools/degrey-viz.html` + `tools/degreyviz_refresh.py`. | `build/m30-anatomy.json`, `build/m30-rigidity-forcer791.json`, `plans/M30-degrey-anatomy.md` §R | M30 |

| 31 | **Act One as kernel theorems + the composed 5-forcer** (M34): the **pigeonhole bridge** (`mono_pair_of_not_colorable_append` / the iff — class avoidance IS colourability of the pair-augmented edge list, so the certified SAT chain applies verbatim); the **transmuter** (five-vertex forcing, 4⁵ decide, nine-way mutation audit; its forced transfer crosses distance exactly 2 = the ρ₁₅ spindle distance); **A1 unconditional** (`not_colorable_iff_covers`: χ(G) > k ⟺ every k-colouring of G − v covers N(v) — the fan query as a theorem, no side condition); **`core9_pigeonhole`** + **`core9_plane`** (every proper 4-colouring of the plane has a mono √3-pair — nine-point 1-minimal carrier, two transmuters + one edge, geometry denom 512, pair list kernel-complete); **`core122_pigeonhole`** + **`core122_plane`** (every proper 4-colouring of the plane has a mono distance-2 pair — 122-point carrier on the certified hexagram's seam lattice, pinned LRAT of 7,892 derived clauses replayed by the kernel, geometry denom 12, forty pairs kernel-complete over 14,884 checks); `UDCert.PairsAt` + `pairsAt_sound` (class-distance certification at any √r). All on axioms exactly `[propext, Classical.choice, Quot.sound]`. **SCOPE CORRECTION 2026-09-09, found while formalizing the valuation law (row 59): the two PLANE corollaries `core9_plane` and `core122_plane` are VACUOUS.** They quantify over `(unitDistance ℂ).Coloring (Fin 4)` — proper four-colourings of the whole plane — and this repository's own rung B (`χ(ℝ²) ≥ 5`) makes that type EMPTY; the emptiness is now itself a theorem (`Instances/Interval.lean`, `isEmpty_coloring_plane_four`, with the general reading `vacuous_of_plane_four_coloring` beside it and a scope comment on each corollary). Both remain true and kernel-checked; neither is evidence for anything, and an argument that reads either as forbidding a compulsion at its distance is unsound — one such argument was carried in `plans/STUB-four-colour-valuation-law.md` and is retracted there. **What is untouched is this row's actual content**: the two 1-minimal CARRIERS and their pigeonholes quantify over four-colourings of a finite graph that has them (the nine-core is 3-colourable), and the non-vacuous plane-level form — over a class of objects that really is four-colourable, i.e. over `K` by Theorem B — is stubbed with its proof sketch in the same file. **SWEPT AND SHARPENED 2026-09-09 (FS-26, the vacuity audit).** *Swept:* the known-empty family is **closed at exactly two members**, by an independent exhaustive search over every spelling of a plane colouring at four colours or fewer — `core9_plane` and `core122_plane` are the only substantive ones; the two other hits are `isEmpty_coloring_plane_four` and `vacuous_of_plane_four_coloring`, which *are* the emptiness. **No third instance exists**, and recording that negative is worth as much as the two positives because it stops the sweep being re-run. Every other plane-shaped statement in the library is over an `induce`d SUBSET of the plane — a different object, and one that really is four-colourable (`Ladder`, `MetaLadder`, `Hexagram`, `FieldWall4` each *prove* their subset four-colourable, which are the inhabitants). *Sharpened:* this row's own next sentence used to read *"at FIVE colours nothing is emptied, so `Instances/HexShell.lean`'s statements are live"* — **one step too strong, in the row correcting exactly that failure.** Whether `(unitDistance ℂ).Coloring (Fin 5)` is inhabited **IS** the Hadwiger–Nelson problem: if `χ(ℝ²) = 7` it is empty and `hexShell_plane5` is vacuous too. What makes the five-colour statements safe is not that their domain is known non-empty — it is that **both consumers assume a colouring in order to REFUTE it** (`not_colorable_five_of_forced_pairs` concludes `¬ Colorable 5`), and vacuity cannot damage a theorem whose conclusion is the emptiness. So the honest form is: at five colours nothing is *known* to be emptied, and nothing there depends on it. The three-step reading is now recorded at the statements themselves (`Instances/HexShell.lean` § the plane corollaries). Tools-side, controls red/green throughout: the census (forty d2 instances = FIVE dihedral classes, endpoints on named shells) and the **composed union** — 9-core + six 791-forcer chains, 4,749 vertices, χ ≥ 5 by kernel-covered cubes (six UNSATs at ~800 s) where the monolithic solve capped at 3600 s. | `Pigeonhole.lean`, `PairDist.lean`, `Instances/Core9.lean`, `Instances/Core122{,/}`, `build/m34-*.json` | M34 |
| 32 | **The two-sided 6-programme's first pass** (M35): kernel side — `mono_pair_of_clique` (the counting face of the M34 bridge: a (k+1)-clique of the augmented graph forces a mono class pair with NO refutation certificate anywhere); the **hex-shell pigeonhole** (`HexShell.lean`: the closed first shell of the triangular lattice — a point and its six unit neighbours — is a K7 of the {1,√3,2}-distance graph; `hexShell_pigeonhole` k-generic below seven; plane corollaries at five and six colours: **every proper ≤ 6-colouring of the plane has a mono pair at √3 or 2, i.e. χ(ℝ²;{1,√3,2}) ≥ 7** — compulsion folklore, formalization ours); the **brick certificate machinery** (`Brick.lean`, zero sorry: `Brick.sound` — closed-hull offset-window soundness over the whole plane, window computed inside the check; `colorable` demanding properness structurally; `avoids` with the corrected avoider semantics; `colorQ` the computable twin) and **`plane_colorable_nine`: χ(ℝ²) ≤ 9 kernel-checked** — the first certified upper bound, the interval [5, 9] now kernel-side at both ends, plus a certified 9-colouring avoiding √(3/2) (`Brick.avoids` live) — **PROMOTED 2026-09-09 (FS-24 G7b, ledger row 61): those are two facts about one function, and joined they are a colouring of `distanceGraph ℂ D`, so the row now reads as one theorem, `χ(ℝ²; {1, √(3/2)}) ≤ 9` (`chromaticNumber_plane_avoiding_sqrt_three_halves_le_nine`). Measured with it, over 480 rationals `n/d` (`n < 41`, `d < 13`): `nineBrick` passes with 41 avoidance guards and `sevenBrick` with NONE — so the sentence "kept because it carries the avoidance surface at distances the seven-colouring does not avoid" is now quantitative, and the reason is M36's boundary-tightness (a zero-margin certificate has no room for a second guard).** Tools-side, controls red/green throughout: the **k = 5 class sweep, all-clean** (52/4/0 over 7 objects × 8 classes — the first class-level k = 5 measurement anywhere; fans at min-cover 2; the sweep-halt rule never armed); the bare lattice clean at k = 4 d2 (the §0a HNF coset obstruction — no index-4 coset colouring avoids {1,2}, three of five index-5 sublattices avoid {1,2} while none avoids {1,√3} — does not bind free colourings); the **row-brick interlock finding** (~2,800 rows: no 7- or 8-colouring at any probed shape — squares, long bricks, fine slabs; threshold exactly 9; pixel squares capped undecided); instruments banked (3-bit re-encode, clique-triviality guard, k-threading, the prober + catastrophe banner). | `Pigeonhole.lean` (`mono_pair_of_clique`), `Instances/HexShell.lean`, `Brick.lean`, `Instances/Nine.lean`, `build/m35-*.json`, `plans/M35-k5-transfer.md` §R | M35 |
| 30 | **The mechanism hunt's first harvest** (tools-side, every claim double-encoded or theorem-closed): (a) the criticality factorization A1 (χ(G) ≥ k+1 at a vertex ⟺ the fan on its circle, when G−v is k-colourable) — derived a priori, validated at three centres, and used to CLOSE a capped solver row by mathematics; (b) **the d = 2 pigeonhole**: avoid-all-mono-d2-pairs is UNSAT on the certified hexagram chunk at B = 2, on the bare de Grey fabric and the 1581 at the IDENTICAL onset 2 − √33/9, and on Heule-510 at the glue shell 5/3 — fabric-borne, depth-switched (clean at B ≤ 1), at exactly the ρ₁₅ spindle distance; Act One's 1-minimal carrier = **122 vertices / 12 shells** with per-member necessity witnesses; (c) **the 3-cover core**: 36-circle + **13 interior points** on (7−√33)/6 ∪ {1/3} ∪ (9−√33)/6 delivers min-cover 3 at Heule-510's centre; (d) the √3-pair pigeonhole exists ONLY in the assembled 1581 (onset at the √21 shell — cross-system material), not in the fabric, not in shrunk 510 — and its 1-minimal core is **NINE vertices**: two √3-triangles with their unit circumcentres (M18's `exists_unit_triangle_iff` object), a hub, and one rim–rim edge — hand-proved in two cases, `decide`-scale for M34; (e) the class-avoidance instrument (arity-generic mono-avoidance, base-SAT guard as control flow, five honest verdicts, first-occurrence breaking, binary re-encode promotion ladder, 1-minimal shrink engine) with the 791/M20-skeleton/planted controls all red/green. | `tools/mechanism.py`, `tools/rigidity.py` (class_avoid), `build/m33-*.json`, the explorer's M33 pane, `plans/M33-mechanism-hunt.md` §R | M33 |

| 33 | **The classical interval, kernel-checked at both ends** (M36): the **boundary-tight sharpening** — half-open cells make the realizable difference set an OPEN box, so a realized squared distance is strictly below `hiAt` and strictly above a positive `loAt`; `Brick.check` accepts `q ≤ loAt ∨ hiAt ≤ q` (the exact miss condition, not a sufficient one) and PARSES guard positivity in (`check_pos`), without which `guards = [0]` would be accepted and `sound` would deny a point its own colour. Consumers got simpler, not harder: `sound` keeps its signature and `avoids` LOSES its nonnegativity argument. **`plane_colorable_seven` / `chromaticNumber_plane_le_seven`: χ(ℝ²) ≤ 7** on a 7 × 7 torus of `4/5 × 3/5` half-open cells, shear `2/5` — the 3–4–5 triangle, cell diagonal exactly 1 — coloured `(i + 3j) mod 7`, the norm-7 ideal `(−3 + ζ₆)` of ℤ[ζ₆] (ζ₆-stable kernel ⟹ ideal ⟹ same-colour centres separated by norm multiplicativity, no lattice census); and **`chromaticNumber_plane_interval`: 5 ≤ χ(ℝ²) ≤ 7**, the classical statement of Hadwiger–Nelson, both ends kernel-side on axioms exactly the standard three. The colouring is classical (Isbell; half-open brick variants folklore) and no novelty is claimed for it — ours is the certificate, the sharpening, and the correction. Controls: two boundary-tightness pins (`hiAt 0 0 = 1`, `loAt 1 2 = 1`), six mutations refusing (two shapes, shear 0, two non-ideal coefficients, the flat table), the degenerate guard refused, seven `colorQ` samples. Tools-side, every claim on a third code path: the design script's census (0 straddles, tight rows exactly as predicted, 3.8M exact unit pairs with no mono pair), the prober's **first k = 7 SAT** (control + a searched second solution at shear `w/3`, promoted through the kernel), the `k = 4` mass red held in 298 rows, `k = 6` and `k = 5` refused in 1,394 rows each, and the certificate passing **exactly at the two ideal coefficients** `c ∈ {3, 5}` across a 7 × 5 census. | `Brick.lean` (`check_pos`, `sq_lt_of_abs_lt`/`lt_sq_of_abs_lt`/`le_sq_of_abs_lt`, `sound`), `Instances/Seven.lean`, `Instances/Interval.lean`, `build/m36-*.json`, `plans/M36-seven-coloring.md` §R | M36 |

| 34 | **The coset bound: the coset chromatic number of the plane is exactly seven** (M37): `Coset.seven_le_card` — every proper nearest-point coset colouring of the plane (triangular lattice, ANY scale, ANY sublattice, ANY tie-breaking) uses at least seven colours, via `Coset.seven_values` (the seven lattice points of the closed first shell get seven distinct colours); and `Coset.exists_proper_coset_colouring` — the norm-7 ideal `(−3+ζ₆)` at scale `6/7` is such a colouring with exactly seven, so the bound is attained (`Coset.coset_chromatic_eq_seven`). The engine, entirely on the integral form `a²+ab+b²`: the inscribed disc + Gram identity, the deep hole (`4p² ≤ 3` from its own diameter), the collinear sweep with a gap lemma (kills kernel norms 1 and 3), the corner sweep (closes the norm-4 seams at `1/p` odd, where the collinear windows only touch), the Loeschian gap (2, 5, 6 are not norms ⟹ kernel norm ≥ 7), and the shell's difference table `{1,3,4}`. Sharpness adds the covering radius (`p/√3`) and the ideal's minimum (`√7 p`), with all properness arithmetic rational. **A six-colouring of the plane, if one exists, is not a lattice colouring.** **PRIOR-ART CORRECTION 2026-09-08 (FS-18): the `≥ 7` half of this row is subsumed by [SokolovVoronov2025]'s `χ_poly(ℝ²) = 7` — see row 35's correction for the full statement and the one open seam. What is not subsumed is the SHARPNESS half (the norm-7 ideal at scale `6/7` attaining it) and the arithmetic engine, which give the exact value rather than the floor.** Attribution: the optimality statement is folklore-adjacent and no novelty is claimed for the construction; ours is the proof shape, the formalization, and the packaging as a limitation theorem for the upper-bound hunt. **SECOND PRIOR-ART CORRECTION 2026-09-09 (FS-23), and it is the one that matters for the whole family (rows 34–37, 39 and G22–G24): the cell family had been studied from the DUAL DIRECTION, and we did not know.** `[deGreyParts2022]` (*Tiling the plane with hexagons: improved separations for k-colourings*, arXiv:2206.12635, Geombinatorics 32(2) 2022) fixes the tile diameter at 1 and maximises the separation `d(k)` between same-coloured tiles over lattice-sublattice colourings by congruent hexagons, for `3 ≤ k ≤ 175`; we fix the cell scale and ask for the fewest colours. **These are inverse functions, and where they overlap they agree exactly** — with `c = √3/(2p)` the unit distance in their normalisation, a coset colouring works iff `d(k) > c`, and three of our band boundaries are exactly their thresholds: M38's classical window ends at `p = √3/2` where `c = 1`, M40's `χ = 9` band ends at `p = √(3/7) ≈ 0.6547` where `c = d(7) = √7/2`, and its `χ = 12` band begins at `p = 1/2` where `c = d(9) = √3`. **Their `d(6) ≈ 0.992076 < 1` (rectilinear hexagons; `[Ivanov2007]` had `0.991445` in 2007) is this row's `≥ 7` floor, computed in 2022** — and the closed forms `d(a²) = (√3/2)(a−1)` and `d(a²+ab+b²) = √((3a+3b−4)²+3(a−b)²)/4` are the classical construction at every Löschian index, with the `≤` side going back to `[Exoo2005]` and `[ChybowskaSokol2022]` Thm 5.4. **What survives, and the boundary is sharp and measurable: they colour only by SUBLATTICES; we allow arbitrary labels** (row 35) — and on the G\* band `p ∈ (0.4330, 0.4804)` their best coset colouring needs **twelve** colours while an arbitrary cell-constant colouring needs **seven** (row 37, kernel-certified at row 39 through the 23-vertex core, with `no_coset_seven_on_gap` proving no index-7 coset colouring exists there). **So the entire `ω = 3, every relaxation low, χ = 7` pathology of G24 lives exactly where their method cannot look**, and our proofs (theirs is numerical optimisation whose search they call "in no way exhaustive") and finite kernel-checkable carriers are untouched. One free edge in the other direction: their §4 *"Towards d(6) = 1"* leaves open whether a more general polygonal tiling could reach `d(6) = 1`, and `[SokolovVoronov2025]` closes it in the negative. | `Coset.lean`, `build/m37-design.py`, `plans/M37-coset-bound.md` §R | M37 |

| 35 | **The coarse-cell bound: the homomorphism removed** (M38): `Coset.seven_labels_of_cell_constant` — for `1/2 < p < 1`, ANY colouring constant on the nearest-point cells of the triangular lattice at scale `p`, with **no algebraic relation between the labels**, gives the seven closed-shell addresses seven pairwise distinct labels; `seven_le_card_of_cell_constant` counts them; `cell_chromatic_eq_seven` pairs that with M37's witness at `p = 6/7`. The mechanism is a change of viewpoint rather than a new computation: the constraint graph's edge set on that window is exactly `Q ∈ {1,3,4}` (each condition `(1−p)² < p²Q < (1+p)²`, radical-free), so the closed first shell is a 7-clique and M37's Loeschian gap is replaced by the clique. The sweep was refactored into its honest form — `exists_unit_pair`, which PRODUCES the unit pair from two addresses and a direction with no mention of colour, and of which M37's is an instance. Window confirmed exactly `(1/2, 1)` with the planted red firing at and below `1/2` (`build/m38-design.py`, 5,997 rows agreeing between the radical and radical-free forms). **PRIOR-ART CORRECTION 2026-09-08 (FS-18) — this row's floor is subsumed.** [SokolovVoronov2025] (*On the chromatic number of the plane for map-type colorings*, arXiv:2502.01958, Discrete Math. 349 (2026)) prove **`χ_poly(ℝ²) = 7`: there is no polygonal colouring of the plane in six colours**, where a polygonal colouring is a map-type colouring (Jordan boundaries, regions the connected components of colour classes, locally finite) all of whose regions are polygons. **A colouring constant on the nearest-point cells of a triangular lattice is one** — the cells are hexagons, the boundaries piecewise linear, three edges at each vertex — **so the `≥ 7` floor at every scale follows from their theorem in one line, unconditionally**, and does so for every lattice and every cell shape, not just ours. Their predecessors [Coulson2004] and [Townsend2005] already had `χ_map ≥ 6`, and [Manta2021] (*Triangle colorings require at least seven colors*, Discrete Math. 344(7) 2021, **named but not yet obtained**) may hold the triangular case earlier still. The title of the Sokolov–Voronov paper **sat in `BIBLIOGRAPHY.md` §C, unread, from 2026-09-06, under a note that correctly guessed it might be prior art for exactly these rows.** One technical seam is recorded and not yet closed: their regions are connected components, so a colour class that is a multiply-connected union of hexagons is not literally a polygon; their proof is local (a disc of radius 3) and very likely goes through, but that check is not done. **What survives here and is not in them:** the exact values ABOVE seven (`χ = 9` and `χ = 12` on named bands, kernel-checked), the non-monotonicity in scale (G23), the `ω = 3` with `χ = 7` gap and the collapse of every relaxation, `no_coset_seven_on_gap`, and the finite kernel-checkable carriers — their method is continuum topology and produces no finite object, where ours produces a 23-vertex graph a proof checker can refute. | `Coset.lean`, `build/m38-design.py`, `plans/M38-cell-bound.md` §R | M38 |

| 38 | **The gradient hunt's harvest: the reduction, the hidden symmetry, and the flat table** (M41, tools-side on exact arithmetic; laptop, one day): (a) **the autopsy dictionary** — all five clique-free cores factor as pigeonhole × kill with Act One a mono pair on a small non-edge class and χ_f certified exactly (130/23, 501/74, ≈ 4.83796 bracket-tight over 235,154 maximal independent sets) — G15-universality 5/5 in the finite lab, and **the 6-forcer reduction**: one k = 5 forced-distinct gadget at √3 or 2 + nine shell copies = χ(ℝ²) ≥ 6; (b) **the hidden Klein four-group** — the 1581 fixed identically by flip[3,5,11] (involution, 29 fixed points, edges preserved exactly), no plane self-isometry, orbit = 4 isometry classes ⟹ **three new 5-chromatic witnesses** (W^[5] isospectral; W^[3] verified by direct k = 4 UNSAT), **P9: the 791-forcer = V ∩ −V exactly**, the witness half-crystal (787 rot6-core), Heule-510 √7-free; (c) **the flat table** — m1 zero and settled on twelve composed objects; gen-2 = 284,873 pts / 1,477,824 edges, k = 5 SAT 343 s; **0/40 virtual edges at exact √3/2 pairs** (the reduction's first direct measurement); only nonzero: two solver-effort signals. | `tools/gradient.py`, `build/m41-*.json`, `plans/M41-k5-gradient.md` §R | M41 |

| 39 | **The gap atlas, kernel side: χ = 7 with ω = 4, and the coset mechanism dead below the window** (M42, same day as M41; all on axioms exactly the standard three): the sweep engine's existence forms — `Coset.exists_unit_pair_ivt` and **`exists_unit_pair_corner`** (pushing along a deep hole sweeps the realizable norm from `Q` to `Q + 2·holeF + 4/3` — the exact-hexagon window beyond M38's inscribed disc, whose corner reaches ARE the D1 band boundaries: norm 4 needs `p² > 3/28` exactly, norm 1 `p² > 3/13` exactly), with `norm_one_hole`/`norm_four_hole` classifiers; **`seven_le_card_shell4`** (the doubled shell forces seven on `3/28 < p² < 1/9` — the M = 4 window M39 §0e priced as exhausted, a G21 instance corrected in the kernel); **`twelve_le_card_of_cell_constant`** (TWELVE on `3/13 < p² < 1/4` via the sheared trapezoid, the local pessimum below the classical scale); **`no_coset_seven_on_gap`** + `exists_kernel_vector` (every nonzero hom `ℤ×ℤ →+ ℤ/7` kills a vector of norm {3,4,7,9} — a 14-candidate decide — so no coset seven-colouring exists on the G\* band); and the crown, **`core23_not_colorable_six`** (`Instances/Core23/`): the 23-address G\* core — graph DERIVED from the addresses by the norm filter, 143 edges, never transcribed — refuses six colours through the M05 LRAT chain (219 derived clauses, 2 segments; the Gadget palette closure over the 4-clique ports; the emitter chain's second non-4 instance), with red control **`core23_colorable_seven`** (verified 7-colouring, seventh colour used) pinning **χ(core) = 7 exactly at ω = 4 — the first kernel-checked `χ ≥ ω + 3` of the programme** — and plane corollary **`Coset.seven_le_card_gap`**: any cell-constant colouring at `3/16 < p² < 3/13` uses at least seven colours, the count routed through the refutation because no clique can carry it. Registered decide route (P4) died on a Lean instance-synthesis wall (staged DFS-shaped ∀, 5,391 nodes, unification failure in the Decidable resolvers at depth ≥ 4) and the fallback fired as registered. Controls: three planted mutations seen red (corrupted colouring refused, wrong pin pattern refuses to bridge, clique gadgets alone leave exactly the one survivor the certificate kills); palette pin at k = 6 re-measured 160× (240 vs 38,528 LRAT lines). | `Coset.lean` §GapBands, `Instances/Core23/{Edges,Cnf/*}.lean`, `Instances/Core23.lean`, `plans/M42-gap-kernel.md` §R | M42 |

| 37 | **The gap atlas: below the classical window the cell family forces seven-plus without cliques** (M40, tools-side on exact arithmetic; kernel promotion stubbed as M42): the family `G(p)` is **one fixed graph per band** between rational `T²` thresholds keyed by point-group offset class (distinct classes share a norm with different thresholds, first at norm 49 — planted check green); the corrected exhaustive census — M39's was box- and cap-clipped — gives **χ = 9 exactly** on `p ∈ (1/2, 0.6547)` (the sheared 3×3 block 9-clique + k = 9 SAT), **χ = 12 exactly** on `p ∈ (0.4804, 1/2)` (the 12-point trapezoid clique + the index-12 coset colouring), and the **M = 4 scaled shell** as a real 7-clique band on `(0.3273, 1/3)` (M39 §0e's exhaustion claim was derived with the inscribed-disc sufficient window — a G21 instance); **every band down to `p = 0.2236` is ≥ 7 outright** (ball refutations, no periodicity) while ω collapses to 3–5: **G\*** (`(0.4330, 0.4804)`, norms {3,4,7,9}) has ω = 4, χ = 7, and a **23-vertex 1-minimal core** with every necessity witness held; the **deep pocket** (`(1/3, 0.3464)`) has ω = 4, **χ ≥ 8 outright** (91-vertex k = 7 refusal; 53-vertex core); the `p = 1/6` flank bands have **ω = 3 with χ = 7** (gap FOUR, re-proven without the boundary class — every integer T is a threshold scale, so M39's integer rows were closed-criterion graphs); **no coset seven-colouring exists on G\* or the 1/6/1/7 bands** (all eight index-7 sublattices contain an edge, explicit witnesses) — the witnesses found are non-uniform with trivial stabilizers; certified Hoffman brackets collapse to ≈ 4.1 at the gap bands (truth 7–8) and α(G\*, 12×12) = 21 gives χ_f ≤ 48/7 — the seven-forcing is integrality-carried; **the sharpest open scale is `p = 1/7`**. Instruments banked: class-keyed band decomposition, exhaustive clique search, batched 1-minimal shrink with necessity certificates, colouring-anatomy (stabilizer/coset tests), exact torus α (Sinz counter), certified spectral brackets. Explorer `build/m40-spectrum.html`. **PRIOR-ART NOTE 2026-09-09 (FS-23): this row's `χ = 9` and `χ = 12` bands are exactly `[deGreyParts2022]`'s `d(7) = √7/2` and `d(9) = √3` thresholds under `c = √3/(2p)` — an independent cross-validation of both computations — and their least admissible index on the G\* band is TWELVE against this row's seven, which measures precisely how far arbitrary cell-constant colourings beat coset ones. See row 34.** | `tools/celllat.py` (M40 suite), `build/m40-chiomega.json`, `plans/M40-chi-omega-hunt.md` §R | M40 |

| 40 | **The fine tail closed, and a forcing that does not factor** (M43, tools-side on exact arithmetic; laptop, one day): **χ(G(p)) = 7 exactly on both bands flanking `p = 1/7`** — the coarse flank `T² ∈ (139/3, 49)` (11 edge classes, degree 114, **never probed before**: every earlier "p = 1/7" row keys to the FINE flank) refuses six OUTRIGHT at nine radii, minimum `R* = 9` / 301 vertices, double-encoded (the deleted-centre A1 form, unpinned, agrees), with the fine flank following by inclusion and M39's 24 × 24 seven descending to both; **no periodic six-colouring of index ≤ 96 on either flank** (7,624 Hermite-normal-form period lattices each, zero unknown, mass-red green). Nineteen further bands floored ≥ 7 outright (ten between `p = 0.2236` and `1/7`, nine in the deep tail to `p ≈ 0.109`), ω = 3 throughout below `T² ≈ 64/3`, twelve deep-tail bands honestly unknown at cap. **The autopsy: the forcing does NOT factor as pigeonhole × kill** — Act One free by counting (7 shell cells, mutual norms {1,3,4}, all non-edges), Act Two absent (every forced-equality at every small non-edge class SAT on 241 vertices, more material than the 160-vertex 1-minimal core; **zero virtual edges at k = 6**) — G26's registered falsifier, found; the certified Hoffman bracket reads 3.56 against truth 7. The **160-vertex core** (2,978 edges, 24 orbits, centre-ful, edges re-derived two independent ways, every necessity witness held) is the family's largest named carrier. Promotion priced and declined with numbers (one medium cube = 798,002 LRAT lines = 63× the whole 122-core certificate). Conditional on **Voronov's proof of the Exoo conjecture** (arXiv:2304.10163, external, unverified here): **χ(G(p)) ≥ 7 for the whole family at every scale**, by a gap argument over the offset windows near 1 — so the from-above six-door is shut on both our own certificate and the literature's. **CONDITIONAL DISCHARGED 2026-09-08 (FS-18): [Voronov2023] was read and proves exactly this** — Theorem 1.1, `χ_[1−ε,1+ε](ℝ²) ≥ 7` for every `ε > 0` and every 2-dimensional norm, by a NON-COMPUTATIONAL argument (continuity of colourings of the unit circle; computer experiments appear once as an aside). So "conditional on an external preprint we have not verified" is retired: the implication stands, and the whole cell family is `≥ 7` at every scale unconditionally. **And the same conclusion now arrives twice over**, because [SokolovVoronov2025]'s `χ_poly(ℝ²) = 7` gives it directly (see row 35's correction). Free from Voronov and not previously held: Corollary 1.1 (`= 7` exactly for `ε ≤ 0.138`), Theorem 1.2 (two unit circles need 4), and **Theorem 1.3 — a disc of RADIUS 3 covered by six closed sets realizes the unit distance**, an explicit bounded region that bears on M44's limit lemma and G29's `ν`. | `tools/celllat.py` (M43 suite: `ball43`, `hnf_colour`, `skew_sweep`, `m43_census`, `transfers43`, `band_of`/`canonical_T`), `build/m43-finetail.json`, `plans/M43-fine-tail.md` §R | M43 |

| 41 | **The limit lemma, and the first explicit points on the ν curve** (M44). **Kernel** (`Limit.lean`, `Instances/LimitSpec.lean`, axioms exactly the standard three): a finite graph drawable inside one fixed **compact** region with every edge's length within `ε` of 1, **for every `ε > 0`**, can be drawn there with edges of length exactly 1 (`exists_unitDistance_drawing_of_approx`), so it forces the space's unit-distance chromatic number — and in the form the measurement consumes, **the graph may DIFFER at each tolerance** and only its vertex count is fixed (`add_one_le_chromaticNumber_unitDistance_of_bounded_family`, by pigeonhole over the finitely many graphs on `Fin N`), with the plane instance `seven_le_chromaticNumber_plane_of_bounded_family`. Stated for `[MetricSpace V]`, not ℂ, because compactness is all the argument uses. Attribution: the compactness argument is one any specialist would produce and no novelty is claimed for it; ours is the formalization and the programme it licenses. Three models ship with it because the statement is a `∀ ε` — an exact one, a genuinely approximate one, and a **red that is a proven theorem** (`collapsed_drawing_satisfies_one_tolerance`: at a single tolerance the hypothesis is free for ANY graph — collapse every vertex to one point — so a single-`ε` version would prove `χ(ℝ²) ≥ k+1` for every `k`). **Tools**: the **unit-distance defect** meter (`tools/embed.py` — least over drawings of the max edge-length deviation from 1; zero iff the graph is a unit-distance graph; the programme's first CONTINUOUS distance-to-target gauge, every previous meter being binary and flat), reporting bounds **certified in exact rational arithmetic** on a stored rational drawing and re-checked by independent code (`tools/verify_defect.py`, sharing no code, deciding `\|√q − 1\| ≤ c ⟺ (1−c)² ≤ q ≤ (1+c)²` with no square root at all; planted corruption caught on 21 edges). **The curve**: `ν(0.2792) ≤ 23`, `ν(0.2291) ≤ 66`, `ν(0.1706) ≤ 117`, `ν(0.1494) ≤ 160` — the first explicit points anywhere, upper bounds only, growing as `ε^(−2.9)`. **The minimal refuting ball is physically scale-invariant**: `R*` derived by exhaustive parallel scan (not chosen), physical radius **1.02–1.38 unit distances** across a 3.16× span of scale, all five bands decided minimal. | `Proofs/HadwigerNelson/Limit.lean`, `Instances/LimitSpec.lean`, `tools/{embed,verify_defect,m44}.py`, `build/m44-{dial,interval}.json`, `plans/M44-epsilon-dial.md` §R | M44 |

| 42 | **The arity floor, and the correction it found** (M45). **Kernel** (`Arity.lean`, `Instances/AritySpec.lean`, axioms exactly the standard three): a **compulsion** is a *partial colouring that does not extend* — `m` distinct vertices, properly coloured among themselves, wearing a pattern no proper `k`-colouring induces — and the **arity floor** `arityFloor G k : ℕ∞` is the least such `m`. Phrased through the repository's existing `SamePattern` (`Pattern.lean:57`, under `namespace HadwigerNelson` only — corrected 2026-09-09), so it **contains** the four neighbouring notions rather than becoming a fifth: `compels_two_eq`/`compels_two_ne` say arity 2 *is* `Separated`/`Forces`, with `Separated.compels`/`Forces.compels` the constructors a caller travels; `Fan` is a disjunction of compulsions; M20's `no_mono_outer_triple` was an arity-3 compulsion all along. Two things fall out free: **`arityFloor G k = 0 ↔ ¬ G.Colorable k`** — the base-satisfiability guard every instrument carries by hand, here a *value* rather than a side condition — and **`arityFloor_le_of_degree`: the floor is at most `k`, unconditionally**, because `k` distinct neighbours can never be rainbow. That last one is the milestone's transferable sentence: *every object this repository holds has some vertex of degree far above its colour count (max degree 60 on de Grey's 1581 against `k = 5`; the theorem needs SOME vertex with `k` distinct neighbours, not every vertex), so four campaigns of pair meters reading zero were asking below a bound that was always available.* `realizes_iff_extends` (palette-free ⟺ naive extension, via `Equiv.extendSubtype`) makes the campaign's two encodings provably the same query. Spec: the smallest graph whose first compulsion is at arity 3 — 5 vertices, 5 edges, 3 colours, a 4-cycle with a pendant — with `arityFloor = 3` proved both ways, the lower direction routed entirely through the public API, and the positive instance *is* `compels_rainbow_of_neighbors` applied verbatim; plus a planted negative (`⊤`) and the vacuity self-report (`0`). **Tools**: `tools/arity.py`, whose verdict function structurally refuses the three misreadings — it returns `undetermined-subtuples` rather than a verdict when the 2-subset evidence is missing, its enum contains no "clean" so a cap can never read as a negative, and stages carry edge-list **fingerprints** so "same object?" is a comparison. **The measurement, which corrected a minted grokking**: on M43's own stage its six anchored asks reproduce exactly (6 realizable), and the same stage carries **7 virtual edges** at offset norms 27/28/31 — **triple-encoded**, controls green, 7.5–15 s each; the critical stage (core minus one vertex) carries **51** over a complete 9,636-pair sweep. Coverage primary, criticality secondary; **G28's "zero virtual edges at k = 6" refuted on the stage that produced it.** | `Proofs/HadwigerNelson/Arity.lean`, `Instances/AritySpec.lean`, `tools/{arity,m45}.py`, `plans/M45-arity-floor.md` §R | M45 |

| 43 | **The arity floor of de Grey's witness, bracketed to one step — and the pigeonhole's disjunction read correctly at last** (M48). **Kernel** (`Arity.lean` §Transport, `Homogeneous.lean`, `Instances/HexShell.lean`, axioms exactly the standard three): the **ladder theorem** — `arityFloor_le_of_embedding : (f : G ↪g G') → arityFloor G' k ≤ arityFloor G k`, the BIGGER graph on the LEFT, so a compulsion survives being embedded in more material and a closure measurement is a dial with a theorem behind it — carried by three transport lemmas that want three different hypotheses (`Realizes.comap` needs only a homomorphism; `PartialColoring.map` and `Compels.map` need the embedding's *reflection* of adjacency), which is what makes the induced-subgraph condition load-bearing rather than decorative; **the plane's homogeneity** (`exists_isometry_map_pair`, `forced_pair_of_forced`, `Separated.plane`) — one forced pair at a distance is EVERY pair at that distance, via `z ↦ az + b` with `a = (y−x)/(y₀−x₀)`, and with no `x₀ ≠ y₀` side condition because at zero distance the hypothesis refutes itself; and **the correction to this project's own record** (`not_colorable_five_of_forced_pairs`, `six_le_chromaticNumber_plane_of_forced_pairs`): `hexShellPairs` is six √3-pairs PLUS three diameters and `hexShell_plane5` is disjunctive over both, so **χ(ℝ²) ≥ 6 needs a virtual edge at √3 AND one at distance 2** — never one at either — proved from both sides by two explicit proper 5-colourings of the seven-point carrier, one separating all six √3-pairs and one all three diameters, so neither class is forced alone and the conjunction is not an artifact of phrasing. **COLOUR-GENERIC 2026-09-09 (FS-24 G4, ledger row 61): the numeral 5 was decoration — `hexShell_plane` was already `k`-generic below seven — so the conjunction now reads at every `k < 7`, and its `k = 6` instance is `χ(ℝ²) ≥ 7` from two six-colour gadgets, a sentence this repository could not previously write. Both independence witnesses are duplicated at six colours, so the new instance carries its own adversaries.** **Measured** (desktop, every control green, both stages re-derived from construction with their edge counts as controls): on de Grey's 1581 at `k = 5` — arity 2, **0 over all 1,248,990 pairs** (P1, reproducing `build/m30-rigidity-1581-k5.json`; every pair observed *both* ways, so nothing reached a solver); **arity 3, COMPLETE — 0 compulsions in 3,286,925,350 questions** (657,385,070 triples × 5 patterns; 1,023,629 screen survivors in 46 s → 279 after fresh colourings → 263 solved, all satisfiable; 0 undecided; 904.7 s); **arity 4 restricted to vertex NEIGHBOURHOODS, COMPLETE — 0 compulsions in 25,782,585 questions** (1,718,839 deduplicated 4-subsets × 15 patterns; 659 solved; 0 undecided; 691.9 s). Hence **`arityFloor(1581, k = 5) ∈ {4, 5}` exactly** — 0 and 1 by `two_le_arityFloor`, 2 and 3 by complete sweep, ≤ 5 by `arityFloor_le_of_degree` — and since every arity-5 compulsion that theorem constructs lives in a neighbourhood whose 4-subsets are now all known free, **those compulsions are 1-minimal**: M45's designed-but-unrun fan-shrink bracket, delivered as a corollary. **The ladder** carried the identical questions to the gen-1 half-spindle closure (24,065 vertices, 123,134 chords; the witness verified INDUCED inside it at 7,877 edges, which *is* the theorem's hypothesis): the witness's own 3,286,925,350 triple-patterns compel nothing there either (screen 3,066,206 → 384 in five filter rounds, 332 solved, 0 undecided at cap 300 s, 5,257.6 s), and gen-1's own **73,256** target-class pairs (52,616 at exactly √3, 20,640 at exactly 2 — an object never swept at all before) hold **no virtual edge**. Because the floor can only DROP along that embedding, the flat reading is *an inequality measured tight*. The engine that made 3.3 billion questions a 46-second bit sweep: **pair colour-agreement masks** (`M[u,v]` = the bitmask of harvested colourings where `u` and `v` agree; every arity-`m` pattern's observed set is a boolean combination of the `C(m,2)` masks on its tuple) plus **observe-then-confirm** (one colouring exhibits a realized pattern for every tuple at once; every model found returns to the pool). Five of six registered predictions met; **P6's second half missed in a direction that is provably about the SAMPLER**, since an induced subgraph's restricted colourings are a subset of its own — the closure's pool exhibits ~17M witness-patterns the witness's own pool of equal size never wore, all of them achievable on the witness (`--decay`: 20,220,080 vs 3,066,206 at `H = 1024`). Two instrument bugs found mid-campaign would each have manufactured a false negative: `harvest` re-seeding from zero (so "filter against fresh colourings" re-tested the same ones and killed 0 of 1,023,629, where real fresh seeds cut it to 279), and a planted norm-constant assertion that **fired for real** — the closure builder returns lists where the witness builder returns tuples, which would have left the √3 and distance-2 classes EMPTY while the unit-edge control still passed. **GENERALIZED 2026-09-09 (consolidation, FS-24 G1).** The plane's homogeneity was stated over `ℂ` and its four-line proof needs only *that an isometry carrying one pair to the other exists* — the classical condition, holding globally, is that the space be **two-point homogeneous**, which `ℝ²` is and a number-field plane is not. `transport_pair_of_isometry` is that argument over any metric space with the isometry's existence as a hypothesis; `transport_pair`, `forced_pair_of_forced`, `Separated.plane`, `Separated.planeIn` and `Forces.planeIn` are unchanged and are now its corollaries, with `Separated.transport` / `Forces.transport` the gadget-level forms and `isometry_affine` / `exists_isometry_map_pair_of_mapsTo` / `distanceGraph_induce` / `unitDistance_induce` the pieces that discharge the hypothesis inside a subspace of the plane. **Why it was blocking**: `plans/STUB-four-colour-valuation-law.md` needs the transport over `K²` at four colours, and over `ℂ` at four colours the conclusion is **vacuous** — `isEmpty_coloring_plane_four` — so the generalization moves the statement out of the empty regime rather than merely widening it. The `K`-caller's exact shape is elaborated in `plans/HANDOFF-p3.md` §2; its one remaining obligation is that a norm-one element of `K(i)` preserves `K²`. | `Proofs/HadwigerNelson/{Arity,Homogeneous}.lean`, `Instances/{HexShell,AritySpec}.lean`, `tools/{arity,m48}.py`, `build/m48-{arity,ladder}.json`, `plans/M48-from-below-arity.md` §R | M48 |

| 44 | **The two-distance dial: μ defined, its ends in the kernel, and the first certified descents** (M49). **Kernel** (`DistanceGraph.lean`, `OneDefect.lean`, `Homogeneous.lean` generalized, `PairDist.lean`, `Instances/{OneDefectSpec,HexShell}.lean`; axioms exactly the standard three): `distanceGraph V D` with `unitDistance_eq_distanceGraph_singleton`, `chromaticNumber_unitDistance_le_distanceGraph`, the edge-list reduction `add_one_le_chromaticNumber_distanceGraph_edgeList` (any finite non-k-colourable graph drawn with edges in `D`, `0 ∉ D`); relation-generic homogeneity `transport_pair` with `Separated.planeIn`/`Forces.planeIn` (one forced pair at a distance is every pair, in any distance graph); **`not_colorable_of_forced_equal`** — the spindle theorem, `k`-generic, for ANY `d ≥ 1/2` (a `d`–`d`–`1` triangle exists by `Glue.sphere_inter_sphere`; converse `not_exists_dist_eq_and_dist_eq_one_of_lt_half` — the `hd` hypothesis is exact); **`add_one_le_chromaticNumber_unitDistance_of_one_defect`** (a `(k+1)`-chromatic drawn graph with ONE non-unit edge at distance ≥ ½ gives χ ≥ k+1); `forces_of_gadget` (a `Gadget` whose admitted patterns all agree on two ports is a `Forces` proof); spec: `four_le_chromaticNumber_plane_of_rhombus` (the Moser bound from the rhombus alone, both entry points, `d < 1/2` red); free consumer **`seven_le_chromaticNumber_hexShell_distances`** — χ(ℝ²;{1,√3,2}) ≥ 7 as a theorem about `distanceGraph`. **Measured** (desktop, `tools/twodist.py`, every model validated in-process, every removal triple-checked): (a) Exoo–Ismailescu's seed re-derived exactly — T 57, V 205, G 966+423, H 214/1004+446, K 426/2009+892, \|AB\| = 5, \|BB′\| = 1, exactly 18/35 colourings up to palette with `A = B` in all 35 — and the certificate priced (three cubes 24.0/22.9/19.8 M hints trimmed; the 173-vertex core WORSE at 74 M; six-port design ~78 M; configs −26 %; proof-guided shrink a fixed point) and deferred; **[RECORD NOTE 2026-09-09, consolidation: that deferral left a DANGLING REFERENCE. `DistanceGraph.lean` and `Homogeneous.lean` both cite a module `Instances/OneTwo` as the consumer of the edge-list reduction — the certified `{1,2}` six-forcer this row prices at ~50 M proof hints — and **that module was never built and does not exist**. Nothing is wrong in either file's mathematics; a reader following the citation finds nothing. Recorded here rather than repaired, because the repair is a one-line docstring edit in two `.lean` files and doing it rebuilds their dependents.]** (b) **Parts's G31 rebuilt exactly** (G16 an induced {1,φ}-subgraph of the pentagon Minkowski sum G126 with 350+350 edges — his counts planted; the two-copy rotation's unit edge an exact identity, other cross pairs off by ≥ 0.0132) and **edge-critical to the last edge**: μ(φ) over its subgraphs = 56/56 (`tools/parts_phi.py`); (c) **phase 2 as a sandwich `29 ≤ μ_H ≤ 252`** — 29 distance-2 edges of H are essential ALONE (single-deletion census, 446 asks, 0 unknown, reproduced twice: an edge whose lone deletion admits a separating colouring lies in every forcing subset), 252 the parallel-ddmin survivor count with 114 of them individually deletable at 960 s (`--seed-edges-census`); (d) **the k = 4 calibration**: 37/40 essential (two orders agree); the seam pool removed **34 of 37** distance-2 edges in the scan's own order, all certified (2-bit re-encode UNSAT, halos 1-minimal, 527 witnesses over 527 halo vertices, halo sizes 5,0,3,1,0,49,0,21,16,9,8,10,5,8,0,4,13,6,2,56,2,0,1,45,37,18,17,21,6,34,64,29,18,19), 122 → 649 vertices; stall at μ_upper = 3 with the survivors `(15,57)`, `(112,118)`, `(113,119)` refusing seam AND up one-generation pools (and `(15,57)` a 27,690-point two-generation seam pool); the unit part alone still 4-colourable; **the two-generation seam-then-up pool (~64,000 points) turns all three UNSAT** — their certified commits did not finish (a 28,000-point shrink at four colours ran 9.5 h and was stopped; the three UNSAT probes stand as single-encoding probes, and the four-colour object is not rigid enough — > 20,000 colourings — for the lookup engine that finished the job at five). (e) **the k = 5 descent** (`--descend5-lb`): the registered full-pool run at 180 s undecidable (seam 243 unknown/9 refused; up 219/33) and replaced by the lower-bound-targeted radius ladder at 900 s: seam r = 1.5 (153–424 points) **8 of 29 UNSAT**, seam r = 3 (592–1,223) 4 more, seam whole (1,386–1,677) 0/17, up r = 1.5/3/whole (235–2,760) 0/17 each — **every ask decided, zero unknown**; **twelve certified removals for seventeen points** (halos 1,1,1,2,0,0,1,1,1,9,0,0; UNSAT 4.8–9.6 s each; 3-bit re-encode UNSAT; 1-minimal; every survivor witnessed), object 214 → 231, distance-2 edges 446 → 434; the mechanism measured on `(76,78)`: the kill point at unit distance from endpoint 78 with 9 unit neighbours whose neighbourhood is forced rainbow in every separating colouring (forbidding any colour on it UNSAT, control SAT). (f) **the kill engine** (`tools/killengine.py`, §R8–§R9): depth-one partner census (9,485 points, 59 radicands, 51 with ≥ 5 seed neighbours — the complete single-point kill space in any field); exact separating-colouring lists for all 17 refusers (2–19 each); lookup screens with the solver census as a green cross-check (0 single-point kills, 867 asks); **whole-set tests: depth one exhausted for all 17 in every field; restricted depth two kills 7**; seven 1-minimal gadgets by lookup ddmin (122/267/254/147/87/225/101 points), ALL certified on `H − e` with exact sympy geometry (labelled 200-digit fallback where simplify times out) and two encodings; **kills are context-dependent** — all nineteen at once is SAT — and sequential commits land two of the seven (`(56,168)`, `(56,78)`), so the composed descent object holds **14 of 29 lower-bound edges removed** (543 points, 432 distance-2 edges). Predictions: P4a/P5/P8 met, P4b refuted, P4c met at depth two (probes), P2 undecided, P3 vacuous, P6 missed (0/17 at every radius, all decided), P7 refuted literally, P1 missed. Instruments banked: `tools/twodist.py` (census-first sandwich, parallel ddmin, `descend_parallel`, radius-laddered `phase_descend5_lb` with exact resume, ddmin halo shrink with a robust parallel necessity census), `tools/hitset.py` (implicit-hitting-set exact μ engine — right for ≤ ~60 columns, measured wrong for 446), `tools/parts_phi.py`, `tools/m49_rederive.py`. | `Proofs/HadwigerNelson/{DistanceGraph,OneDefect,Homogeneous,PairDist}.lean`, `Instances/{OneDefectSpec,HexShell}.lean`, `tools/{twodist,hitset,parts_phi,m49_rederive}.py`, `build/m49-*.json`, `plans/M49-two-distance-descent.md` §R | M49 |

| 45 | **The batch descent: composition by construction, and the lattice that compounds** (M50). **Kernel** (`PartnerLattice.lean`, axioms exactly the standard three): `Glue.eq_gluePoint_of_unit_pair` — a point at unit distance from two DISTINCT points is the glue point of their unit circles or its mirror, only `x ≠ y` assumed (both annulus bounds derived from the witness) — and `Glue.finite_two_unit_neighbors` — the depth-one candidate space over any finite set is finite: the kill engine's "single-point kills live in the partner lattice, in any field" as theorems. **Measured** (desktop; `tools/batchkill.py` — provenance objects, entropy-split cube enumeration, seed-projection blocking, tiered whole-pool feasibility, wave-parallel cover, process-parallel shrink, per-verdict checkpoints; SIX engine swaps mid-campaign, each measured before changed and regression-gated after, 383/383 twice): **\|S₂₉\| = 51,350 exact** (entropy-guided cubes, 24 min); **two certified batch commits** — 19 cheats via a 465+11-point halo (2,954 edges verified, one-hot + 3-bit UNSAT), then on the corrected iteration-2 chain (45,365 list lines; **corrected at M51 incident 4: 24,810 distinct classes — the class set exact, the count an enumerator artifact; commits certified independently and stand**; profile 45,216/46/103 in line units) **24 more via a 318-point halo** (2,455 edges, both encodings UNSAT, 620 s) — **object 1,008 points / 403 cheats, 43 of 446 removed**; floors 29 → 36 → 17 with (132,134) falling to the halo; **the core probe** — per kept refuser edge, S_e exact on seed classes vs the grown 394,604-point lattice: **five FALL clean, six near-fall at ZERO provable survivors** (2,402 list lines — **recounted at M51: 1,755 distinct classes, 26.9 % enumerator duplicates (incident 4); killed/undecided 2,351/49 are line units, so class-level undecided ≤ 49; the zero-survivor verdict unaffected, a duplicate killed twice is killed** — at 7,200-s caps, never folded) — growth compounds; **277 width-shaped stalls** (strong-rung SAT, capped ddmins land 2,551–14,960 and still descending) price the depth-2 escalation; **P5 field census**: 727/794 committed points carry depth-1-catalogue radicands, 67 (all depth ≥ 2) adjoin new roots concentrated on a handful of values. **The weighted-ladder scan** (`tools/m50_skewscan.py`, palette-invariant functionals on the held lists; controls reproduce §R5 exactly; completed cast-free by a decorrelated adversarial agent + our tool independently): **148 absolute virtual edges at d ∈ {3,4}** (the six d = 4 = diameters through v0: forced central ANTI-symmetry at five colours), **412 absolute never-3-distinct triangles** in five families on {√3,√7,2√3,√13} (the "16" first reported was a cast artifact — G21 on a positive count), distance-class polarization seed-native; **the spare-colour lemma** ((k−1)-colourable ⟹ no pair compulsion at k ⟹ every 5-colour virtual-edge gadget is ≥ 5-chromatic; the χ(unit-part) phase monitor — still 4-colourable at 1,008) adopted as an M51 kernel opener; the diet meter prototyped (cheat supports 166/176/191, common core 78). Three incidents (stage under-accumulation; the deferral cascade's mislabelled cause; the free-minimizer swap) all caught by always-run-the-ask controls. Predictions: P2a/P2b/P3 met, P4 met-in-substance, P1/P6 missed on the 30k cost heuristic, P5 refuted-in-strict-form as registered, P7 missed by three. **GENERALIZED 2026-09-09 (consolidation, FS-24 G7a).** `Glue.eq_gluePoint_of_unit_pair` was stated at radii `(1, 1)`; `Glue.eq_gluePoint_of_dist_pair` is the same theorem at any radii and **carries no additional hypothesis**, because both annulus bounds of `sphere_inter_sphere` still fall out of the witness — `dist x y ≤ r₁ + r₂` by the triangle inequality through the point, and `\|r₁ − r₂\| ≤ dist x y` by its reverse. The unit form is the corollary. What it buys is downstream, in row 48. | `Proofs/HadwigerNelson/PartnerLattice.lean`, `tools/{batchkill,m50_skewscan}.py`, `build/m50-*.json`, `plans/M50-batch-descent.md` §R0–§R7, §Sⁱᵛ, §Sⁱᵛ-adv | M50 |

| 46 | **The copy-lock atlas, the cull, and the field** (M52). **Kernel** (`Copy.lean`, standard three axioms): `spindleRot d` with `spindleRot 2 = rho15`, `spindleRot √3 = moserTwist`, the exact `1/2 ≤ d` (red at `1/4`), `dist_self_rotAbout` (hypothesis-free), `self_chord_iff` (self-chords = the radius-d circle), `copyUnion` as `(unitDistance ℂ).comap (Sum.elim q (rotAbout c ρ ∘ q))` with both containments and `chromaticNumber_copyUnion_le`. **Measured, exact**: T13/P1 (13,796 of 13,796 edges on the half-twist ladder — **the literature calls this object the *Moser lattice*, `ℤ⟨1, ζ₆, ω₃, ζ₆ω₃⟩`; named 2026-09-09 (FS-23) from `[MatolcsiEtAl2025]` Def. 1, `[Ducz2026]` and `[Aggarwal2025]`, three independent sources, and adopted as this project's term in new writing — `BIBLIOGRAPHY.md` §E**), T14 (every point in ℚ(√3, √11), all edges exact identities; copies exact in ℚ(√3, √5, √11)), P2 (every genuine cross chord collinear and seed-field), P3 (self-chords = the radius-2 shell), P4 (d = 2 pigeonhole fires on U at k = 4, √3 clean), T15 (the kill table: 3,516 × 1,062, all pairs killed, 13 sole-killer chords, no pair compulsion, centre-colour bias to 65 %), P5 REFUTED (0 of 15,218 classes; 20/20 direct extensions, copy side 4-coloured), 0 copy–copy chords; **the cull 273 → 149** (114 by enumeration, 10 by WO-14; 60 witnessed, 27 floor, 52 undecided; one-hot UNSAT 10,640 s, 3-bit unknown at 43,200 s: candidate); the pool field census (15 % in-field, √5/√35 reachable, 100 % of commits in-field); the shrink priced (1.1 CPU-h/probe, 12–33 %); WO-14 delivered (gate 269/269; A3 273/273; the CNF finding; the sequential-acceptance floor; D74–D77; WO-16 stubbed). Instruments: `compose`, `copy_anatomy`, `copy_exact_field`, `copy_field_probe`, `copy_kill_table`, `cull_enum --loop`, `rank_copies`, `pool_field_census`, `m52_final_certify`; the viewer's copy/cull layers. Records: `plans/RISKS.md`, `plans/STUB-field-wall.md`, `plans/M53-iteration-5.md`, `plans/STUB-certify-core883.md`, `DESCENT-ALGORITHM` phase 0″/2′. | `Proofs/HadwigerNelson/Copy.lean`, `tools/{compose,copy_anatomy,copy_exact_field,copy_field_probe,copy_kill_table,cull_enum,rank_copies,pool_field_census,m52_final_certify}.py`, `data/m52/`, `plans/M52-copy-lock-objects.md` §R0–R5 | M52 |
| 47 | **The field-wall theorem, and M53's measurements before the halt** (M53, HALTED). **Hand-proved, NOT kernel-checked** (`~/field-wall-conjecture.md` §5, Kooshi's other session; formalization pending): χ(G(ℚ(√3, √11)²)) = 4 via the residue colouring modulo a conjugation-fixed prime of K(i) above 2 — the first plane-colouring bound over a field beyond ℚ in this programme's record, subsuming M24–M26's closures; the wall located 2-adically (falls iff −1 is a square in a completion above 2; for multiquadratic fields iff an odd square class ≡ 7 mod 8; √5/√7 break it, √2/√10/√14/√35/√70 do not; even-distance spindles always do). **Measured, exact**: the seed test (1,004/1,004 proper, 446/446 mono, pair separated, both branches) and the it-4 object (13,796/13,796, 344/344, pair separated) — `tools/residue_colouring.py`; the exact field split of the depth-1 pool (16,348 in-field of 1,636,399 — 1.0 %, fusion-explained; out-of-field points have exactly two object neighbours to seven in 1.6 M); the spectrum (89/0/60 of 149; 0 exact at 10 min); the batch law (2,488 → > 80,000 at two cheats); the one-cheat census (in-field kills 2,488/2,488, vacuity witnessed); the two-cheat stage's 3,936 in-field survivors (5 killed, 3,676 unknown at 300 s on pdeg12); the 25× ask-cost rise across the cull. Instruments: `cheat_spectrum`, `cube_certify`, `pool_field_restrict`, `outfield_census`, `commit_cull`, `batch_grow`, `residue_colouring`; the shared generators `binary3_clauses`/`forces_clauses`. Records: `plans/M53-iteration-5.md` §R0–§R5, `plans/RISKS.md` R1 resolved, `plans/STUB-field-wall.md` bannered, `data/m53/`. **Same day, the proving session:** the residue obstruction (T17 — Σ(C′) SAT ⟹ no in-field halo ever makes C′ force; μ ≥ 3 inside K; measured: 8 odd components, 0 blocked singles, 0 residue-type survivors) and the wall-break census (T18 — 5 radicands / 4,221 pairs break alone, 523,608 pairs inert, classes = ⟨−1, 2⟩ at each prime because every radicand lies in ℚ(√33)); `tools/{residue_floor,wall_break_test}.py`, `data/m53/{residue-floor-it4c,wallbreak-it4}.json`; the note copied to `plans/FIELD-WALL-THEOREM.md`; the kernel plan `plans/STUB-field-wall-kernel.md`.**Later the same day:** the rigidity dial exact (163/178 at 8/3, 8/11 at 8/√3, 0 at valuations 2 and 4; the zero rows a theorem), the **new 5-chromatic witnesses in ℚ(√3, √11, √247) (1,175 points from a 588-vertex 1-minimal K-forcer) and ℚ(√3, √11, √23)** (T20), Theorem A′ with the 3-adic wall and χ(ℚ(√3)²) = χ(ℚ(√7)²) = 3 (T21), the wall-pool and partner replays (T19), and the handoff `plans/FIELD-WALL-SESSION-HANDOFF.md`. **PROMOTED 2026-09-08: Theorem B is now KERNEL-CHECKED (row 57), and [Moorhouse2010] §1 shows it answers a stated open question — he names ℚ(√3,√11) as the smallest number field whose plane holds a Moser spindle, gets χ ≥ 4, and writes 'We have not determined the exact value of χ(K²) in this case.' His §7.1 uses the same 2-adic residue mechanism at other primes.** | `tools/{cheat_spectrum,cube_certify,pool_field_restrict,outfield_census,commit_cull,batch_grow,residue_colouring}.py`, `data/m53/`, `plans/M53-iteration-5.md` | M53 (halted) |
| 48 | **The critical-set localization theorem, and the first objects that satisfy it** (M54). **Kernel** (`CriticalSet.lean`, standard three axioms): `CriticalSet G k = {c \| (G − c).Colorable k}`; the isolating lemma (`exists_coloring_isolating_of_mem_criticalSet`: a critical vertex isolates any independent set through it); **`criticalSet_subset_inter_neighborSet_of_forces`** (C ⊆ N(p) ∩ N(q) for a forced-equal pair), **`criticalSet_subset_union_neighborSet_of_separated`** (C ⊆ N(p) ∪ N(q) for a virtual edge), `criticalSet_subset_of_fan` (C ⊆ N(p) ∪ Q), `not_forces_of_mem_criticalSet` / `not_separated_of_mem_criticalSet` / `not_fan_of_mem_criticalSet` (the one-line negatives), `criticalSet_eq_univ_of_colorable` with the spare-colour lemma re-derived, `encard_criticalSet_le_degree_of_forces`, and the plane: **`eq_gluePoint_or_reflAxis_of_mem_criticalSet_of_forces`** (critical vertices drawn at the pair's two glue points), **`criticalSet_eq_empty_of_forces_of_two_lt_dist`** (none beyond distance 2), `encard_criticalSet_le_two_of_forces`; the K₄ − e spec pins the bound tight. Folklore in its vertex-critical case; the localization and its plane form are new packaging. **Measured** (`tools/five_dial.py`, 22 planted controls incl. the K₅ − e end-to-end positive; every critical vertex certified by a verified colouring; every headline with its population): the E–I seed C = ∅ (214/214); the witness vertex-critical (1,175/1,175) — T21's zero was a theorem; W ∪ its 71-point F₂₄₇ cross pool: C loses three remote copy-side vertices; the full-fabric single-centre union: C = F ∪ R(F) exactly, 13 of 3,905 (F = the forcing-critical set, 7 of 1,953, by 1,951 three-second asks); **two spindles on the full fabric: C = ∅ by derivation (F₁ ∩ F₂ = ∅, 34/34 load-bearing deletions checked)**; **the two-core union (588 + 543, overlap 31): C = ∅ measured, 2,229 points, and its exhaustive five-colour sweep reads 0 / 0 complete in 31 s** — redundancy necessary, not sufficient. The witness exact in K(√247); ν(H) = 38 exact, ν(W) = 1; the Fischer reconciliation (T23). **GENERALIZED 2026-09-09 (consolidation, FS-24 G7a), and a boundary found.** The plane localization no longer needs a unit-edge drawing: with the drawing's edges merely lying in a set `D` of distances, a critical vertex is drawn at a glue point of *some* radius pair from `D` (`eq_gluePoint_or_reflAxis_of_mem_criticalSet_of_forces_in`), so the descent's `{1, d}` two-distance objects are covered — a two-distance forcer confines its critical set to at most eight points where a unit one confines it to two. `criticalSet_eq_empty_of_forces_of_two_lt_dist` generalizes twice over, to any metric space and any edge-length bound `M`, needing only the `0 ≤ M` the unit case got for free (`criticalSet_eq_empty_of_forces_of_two_mul_lt_dist`). **`encard_criticalSet_le_two_of_forces` does NOT generalize, and that is a finding rather than a gap**: with the radii free the two glue points move with the critical vertex, so "at most two" is false — the localization survives the loss of the unit hypothesis and the counting does not. | `Proofs/HadwigerNelson/CriticalSet.lean`, `tools/five_dial.py`, `data/m54/`, `plans/M54-five-colour-dial.md` §R0–§R7 | M54 |
| 49 | **Absorption: the pieces a five-colour sweep cannot see, and the ν dial** (M55). **Kernel** (`Absorb.lean`, standard three axioms, 21 declarations): `Extends G A k` (the restriction of colourings onto G[A] is onto) with `Extends.forces_iff` / `separated_iff` (compulsions among A are G[A]'s) and `Extends.not_forces_of_colorable` / `not_separated_of_colorable` (none when G[A] is k-colourable — the spare-colour lemma relative to a piece); the carrier **`extends_of_repaint`** (a piece colouring whose clashes across the cut are pairwise non-adjacent and touch no spare-coloured neighbour extends by repainting); **`extends_of_hubs`** (pieces fused at hubs, ≤ 1 base neighbour each, non-hub chords a matching with independent piece endpoints, a piece colouring with a designated hub colour each hub's neighbours avoid — the spindle-copy shape) with `extends_of_hub_matching` and `extends_of_matching`; **`extends_of_extensionOrder`** (the inductive greedy order — the (k+1)-core's backing) with `extends_compl_singleton_of_degree_le`; **`symCopy.coloringOfPerm`** and **`extends_symCopy`** (symmetric chords absorbed at every k ≥ 2 by a palette rotation; fusion = a fixed-colour constraint the forced pair refuses); spec: the K₄−e hub model and the **K₃,₃-pendants red** (`k33_lists_refuse`, 729-case decide: the independence hypothesis is load-bearing); six statement mutations refused. Folklore in each instance; the packaging as what a sweep cannot see, the hub form, and the copy-union consequence are ours. **Measured** (`tools/absorb_dial.py`, 13 planted controls): core-star₂, star₂ and the new three-spindle star (7,809, C = ∅ by two asks) ABSORBED — every cross chord but the spindle chord is a hub chord — so ν(core-star₂) = ν(star₂) = 2 exactly (D5 above, M54's C = ∅ below), ν(star₃) ∈ [2, 3]; the flowers K = 1, 2, 3 (1,762 / 2,936 / 4,110 points) have a critical centre each, K ≥ 2 NOT absorbed (rotated W inside) and swept 0 / 0 complete in 11 s / 30 s; the F₂₄₇ cross lattice at depth two: 0.65 % cross-only in-field (16× depth one), 64 % of the pool at degree ≥ 5, the witness's critical set 1,172 → 937 with all 238 freed vertices copy-side (T24); the third pair's forcing-critical set overlaps pair 1's in {29, 1753}. The walled SAT helper found inert and made real (no recorded ask had ever reached its wall). | `Proofs/HadwigerNelson/Absorb.lean`, `tools/absorb_dial.py`, `data/m55/`, `plans/M55-absorption.md` §R0–§R5 | M55 |
| 50 | **The additive yardstick, and the seed's arithmetic tightness** (M56). **Kernel** (`Additive.lean`, standard three axioms): `additiveColoring` (a hom nonzero on edge differences is a `Coloring`), `not_forces_of_addMonoidHom` / `not_separated_of_addMonoidHom` (the refutations in the `Forces`/`Separated` vocabulary), `addMonoidHom_apply_eq_of_sub_eq_nsmul` and its `exponent` instance (L1); spec: the grid's parity colouring, three examples, the planted red (the zero hom refused). **Derived** (plan §S1, §M1, §R3): L2 F_true ⊆ F_add; L3 rank ≤ 4 for every K-object; L5 the ℤ/5 arithmetic of distances 2, 3, 4, 5; L7 1/d² ∈ Σ₀ from every spindle rotation, so no additive k ≤ 10 on any wall-broken plane; the Kempe localization F_true ⊆ F_K; L8 the additive spindle theorem. **Measured** (`tools/additive.py`, 27 controls incl. the residue colourings reproduced 2-adically; `data/m56/`): the bed U at 4 — 8 additive colourings, F_add = depth ≥ 2 (2,513 pairs), F_K = 187, F_true = 171 (a 16-pair residue); the seed at 5 — F_add = {(205, 206)} over 21,787 pairs, 18 of 35 colourings additive, the rest at defect ≤ 2, Exoo–Ismailescu's G exactly additive (18 = 18); the witnesses — no additive 4-colouring on any (the 1581's cross edge and W's spindle chord in 4Λ; Heule-510 and the 791 by hyperplane cover), additive 5-colourings 24 / 432 / ≥ 2,981, every additively forced pair separated non-additively (Heule's 91 by asks, W's 291 and the 1581's 356 by the complete sweeps), sampled colourings at the random baseline from both families. Fischer's framework; the chunk theory, the localization, L7/L8 and the seed reading are ours. **PRIOR-ART CORRECTION 2026-09-08 (FS-18, on the full read of [Fischer1990]): L7 IS NOT OURS — it is his Theorem 10(ii).** L7 says every spindle rotation at distance `d` puts `1/d²` into `Σ₀`, so no wall-broken plane has an additive `k`-colouring for `k ≤ 10`. Fischer proves: a norm-one `ξ` has `ξ + ξ̄ ∈ Σ₀`, arithmetic then puts `1/k ∈ Σ₀` for `k ≤ 6` when `N ≡ −1 (mod 24)`, and an additive `k`-colouring `v` into a group of order `k` would need `k·v(1/k) = v(1) ≠ 0` against `k·G = 0`. **Identical mechanism** — a spindle rotation is exactly a norm-one element, with `ρ + ρ̄ = 2 − 1/d²`. His Example 4 (`N = 167`, no additive `k`-colouring for `k < 11`) even states G38's conclusion outright in 1990: *"even though the plane `ℚ(√167)²` can be 7-colored since `ℝ²` can, it has no additive 7-coloring."* **What stays ours in L7: the spindle-rotation instantiation and the tie to the 2-adic wall.** L8, the chunk theory, the Kempe localization and the seed reading are untouched. Also found on that read and not previously held: his **Theorem 7**, a polynomial test for 2-colourability (an integer polynomial with a norm-one root in `ℚ(i)` has even coefficient sum), which is sharper than anything we built and is the mirror image of [CervantesKrebs2023]'s Example 2.14. | `Proofs/HadwigerNelson/Additive.lean`, `tools/additive.py`, `data/m56/`, `plans/M56-arithmetic-of-tightness.md` §R | M56 |
| 51 | **Additive rigidity: the reduction theorem, the closure gauge, and where the family dies** (M57). **Kernel** (`AdditiveRigid.lean`, standard three axioms): `IsAdditive q C` (a coset colouring along an address map — the same-colour relation is the trace of the cosets of a subgroup containing k·V; the iff is the content), `AdditivelyRigid`, the bridge from homs and from M56's `additiveColoring`, `IsAdditive.apply_eq` (L1), **`forces_of_additivelyRigid`**, `add_one_le_chromaticNumber_unitDistance_of_additivelyRigid`, **`six_le_chromaticNumber_plane_of_additivelyRigid`** (the target: all 5-colourings additive + a 5Λ-pair at distance ≥ 1/2 ⟹ χ ≥ 6), the unit path as the model (`three_le_chromaticNumber_plane_of_pathGraph`), two reds (`cycleGraph 6` at three pins `k • v ∈ H` and ←; the path at three pins →). **Derived**: rigidity ⟹ Kempe-closure (every {a, b}-subgraph of every admissible hom connected), γ = Σ (components − 1) with loose vertices its size-1 face; on three-ladder K-material the residue colourings' Λ_c have rank ≤ 3, so no such chunk is additively 4-rigid. **Measured** (`tools/additive_rigid.py`, 17 controls; `data/m57/`): the Moser spindle 16/12/4 at four colours (P1 refuted); G γ = 0 with 18 = 18 (P10); H γ = 12 = its defect-1 count; the 122-/588-cores and the seed's unit part γ = 200/182/126 at four, the solver's first 2,000 colourings all non-additive; the witnesses at five loose on 16–24 % per colouring; W's 71 cross points: 67 in-lattice, the gauge within 1.4 %, kills to 110/200; W + 63 cross points: 500 units in 5Λ, no hom (the depth-2 stage vacuous at every radius); Heule-510: 3,456 homs to r² ≤ 3, 96 whole; the 252-cheat forcing subset: > 5,000 colourings in three defect regimes. Fischer's framework; the closure gauge, the reduction, the 5-divisibility of the cross lattice and the G/H reading are ours. | `Proofs/HadwigerNelson/AdditiveRigid.lean`, `tools/{additive_rigid,m57_b2,m57_richness}.py`, `data/m57/`, `plans/M57-additive-rigidity.md` §R | M57 |

| 52 | **The finite-plane bound and the first exact wall-broken planes** (the pivot of 2026-09-06; hand proof + verified computation, NOT kernel-checked). Theorem: F ⊂ ℝ a number field with a prime above p ≡ 3 (mod 4) of odd residue degree ⟹ every finite unit-distance graph in F² maps homomorphically into UD(𝔽_p, 2), so χ(F²) ≤ χ(UD(𝔽_p, 2)). Measured: χ(UD(𝔽₃,2)) = 3, χ(UD(𝔽₇,2)) = 4 (Vinh 2005), **χ(UD(𝔽₁₁,2)) = 5**, χ(UD(𝔽₁₃,2)) = 5 (p ≡ 1: not usable); Heule-510 → UD(𝔽₁₁,2) with 2,504/2,504 edges on the circle and a proper pulled-back 5-colouring; W 5,773/5,773; the seed 1,004/1,004. **χ(ℚ(√3,√5,√11)²) = χ(K(√247)²) = 5**; K, K(√5), K(√5,√247) sealed; de Grey's field's first usable prime is 131. The theorem and the value are the web session's; the verification, the instrument (`tools/fplane.py`, 11 controls incl. a planted wrong root) and the field consequences as stated are ours. **PRIOR-ART CORRECTION 2026-09-08: the bound is [Moorhouse2010] §8.2 (real quadratic) and §10.3 (any number field, any prime with \|O/𝔭\| ≡ 3 mod 4), by exactly this proof; χ(UD(𝔽₁₁,2)) = 5 is his Table 6.1, which also gives 3, 4, 3 at q = 3, 7, 9 and leaves 13 at {5,6} and 17 at {5,6,7}. The row's novelty clause — 'Vinh and the library's number-field papers do not contain the bound' — is REFUTED: a number-field paper does. What remains ours: the verification, the certificate form over an arbitrary ring, the kernel proof, the instances, and the field consequences.** **PRIOR-ART CORRECTION EXTENDED 2026-09-08 (FS-18): there is a THIRD independent source, and we held it unread.** [Manturov2012] (arXiv:1206.1934, in `library/pdf/` since 2026-09-05, opened for the first time on 2026-09-08) states the reduction in all dimensions — Theorem 17: `χ(K^n, 1) = 2` for every extension `K` of the integers admitting a homomorphism `K → ℤ₂`; Theorems 18–19 the same at `ℤ₃` and `ℤ₅`, with *"here 'taking the residue class' means considering the corresponding ring homomorphism"* — and builds the finite planes explicitly, colouring `ℤ₃²` by `x+y mod 3` and `ℤ₅²` by `x−2y mod 5`. What is NOT in him: which primes are usable (no `p ≡ 3 mod 4` condition), no exact chromatic number of any finite plane, and no number fields (his subrings are localizations of `ℤ`). So the bound was published independently at least twice, in two literatures, neither citing the other.** **A FOURTH SOURCE, 2026-09-08 (FS-18 postscript): `[Madore2015]` Corollary 3.4** — same statement, same hypothesis (`N(𝔭) = q ≡ 3 mod 4`), same proof — **and his Lemma 4.5 prints an explicit 11 × 11 five-colouring table of `𝔽₁₁²`, with footnote 3 reading *"In fact, χ((F11)²) = 5, but we will neither prove nor use this."*** He knew the value in 2015. He cites none of Fischer, Moorhouse, Manturov, Vinh, Johnson or Chow. **So the count is now five independent derivations of essentially one reduction — Fischer 1990, Moorhouse 2010, Manturov 2012, Madore 2015, and this project 2026 — with almost no cross-citation among them.** That is not four milestones' bad luck; it is a literature that does not talk to itself, and it is G49's diagnosis at full strength. | `reference/Chat-analysis/`, `tools/fplane.py`, `data/fplane/` | pivot |
| 53 | **The field sieve: the finite planes' spectra, the 6-open fields as a congruence, and the exact plane at 11 in the kernel** (M58). **Kernel** (`UnitQuadrance.lean`, `Instances/FinitePlane11.lean`, standard three axioms): `unitQuadrance R` (any commutative ring; `finitePlane p := unitQuadrance (ZMod p)`), `unitQuadrance_adj`, **`unitQuadrance.map`** (a ring hom applied coordinatewise is a graph hom — the finite-plane bound as functoriality), `Adjoin.lift`/`Q3.lift`/`Q4.lift` (the towers' universal property into any ring), `Q4.sevenFree : Subring Q4` with `Q4.sevenFree.toQ3` (the √7-free elements ARE ℤ[√3,√5,√11]), **`UDCert.drawing_adj`** (a valid certificate + a subring holding its coordinates + a hom out of it + an inverse of D ⟹ a graph hom into `unitQuadrance R`; no field, no condition on p), `colorable_of_unitQuadrance` / `not_colorable_unitQuadrance` / `add_one_le_chromaticNumber_unitQuadrance`, **`chromaticNumber_finitePlane11 : χ(UD(𝔽₁₁,2)) = 5`** (two decides and one comap; no LRAT, no solver, no edge re-examined), **`chromaticNumber_heule510 = 5`** (the first certified upper bound on a certified witness), `five_le_chromaticNumber_finitePlane131`, `heule510_coordsIn_sevenFree` (P8), reds (no inverse of 11 in ZMod 11; D ≠ 0 would not do — ZMod 4; a wrong root; a corrupted table). **Derived** (`plans/M58-field-sieve.md` §S1–§S2, §R1–§R2): λ(c) = −K(1, c/4) ⟹ χ(UD(𝔽_p,2)) ≥ 1 + (p+1)/(2√p) > 5 for p ≥ 62 (Weil + Hoffman), 59 by the exact spectrum; for F ⊇ K the only usable prime below 67 is 11 ⟹ **6-open ⟺ wall broken ∧ 11 inert**; the wall over K breaks for odd squarefree d ≡ 5, 7 (mod 8). **Measured** (`tools/fplane.py`, 21 controls; `data/fplane/`): the spectral table below 600 (Kloosterman residual ≤ 5.7·10⁻¹⁴, FFT cross-check); χ = 3, 4, 5, **5** at 3, 7, 11, **19** (P1/P4 refuted as stated); the map of 19 fields (de Grey's, K(√7), K(√13), K(√79), K(√127) 6-open); the shadows: the 1581 at 131 floor 4.96, at 479 4.32; the gen-1 closure at 131 the whole plane, at 479 floor 8.38; 23/31/43/47 and the 1581's shadow at k = 5 in flight. Vinh's objects and bounds; Medrano–Myers–Stark–Terras's spectrum (second-hand); the reduction theorem in certificate form, the K-field theorem, the exact plane in the kernel, the map and the shadow floors are ours. **PRIOR-ART CORRECTION 2026-09-08: `unitQuadrance R` over an arbitrary commutative ring is [Moorhouse2010] §1 ('any field, or more generally any commutative ring with unity'), and χ(UD(𝔽₁₁,2)) = 5 is his Table 6.1. The KERNEL statements — the certificate form, the sevenFree subring, the exact plane with no solver, χ(Heule-510) = 5 — appear to be the first of their kind and are unaffected. The spectral half (Kloosterman ⟹ every plane from 59 up refuses five) is not in him; his §6 GUESSES χ(𝔽_q²) → ∞, which [Vinh2005] had already settled in 2005 — the two papers do not cite each other.** **PRIOR-ART CORRECTION 2026-09-08 (FS-18), on the finite planes' ω and the ω-versus-χ gap.** Three things this row and M59/M61 treat as ours are published: **[Vinh2006]** (arXiv:math/0606482, a second Vinh paper that was not in our bibliography at all) proves **`ω(UD(𝔽_q,2)) ≤ 4` for every `q`** — where M59 pinned only `ω = 3` at 11 and `ω = 2` at 19 by kernel `decide` — and **`D_q` is triangle-free iff `q ≡ ±7 (mod 12)`**, which is M59's "`ω = 3` iff `p ≡ 11 mod 12`" scope correction, published 2005/2006; and **[SchneiderSilva2013] Theorem 4.7(3)** gives `ω = χ ⟺ m ∣ (p+1)` for `Γ_{p²,m}`, which at our `m = p−1` means **`ω ≠ χ` for every `p ≥ 5`: no finite Euclidean plane above `p = 3` is perfect.** Also [Vinh2005]'s upper bound `χ(UD(𝔽_p,2)) ≤ (p+1)/2` is constructive and gives 6 at `p = 11`, matching M61's `finitePlane11_colorable_six_periodic` exactly. **A numerical error in the literature, found here:** [Vinh2006] restates the 2005 lower bound without a factor 2 in the denominator, a form that would give `χ(UD(𝔽₁₉,2)) ≥ 6` and contradict our kernel-checked `chromaticNumber_finitePlane19_le_five`; exact spectra computed here confirm ours (`λ_min = −7.61` at `q = 19`, Hoffman 3.628). His Theorem 4 leans on the bad form; [SchneiderSilva2013] proves the same conclusion properly.  **AND THE CLIQUE NUMBER HAS A CLOSED FORM (recovered 2026-09-08, FS-18).** `[Krebs2022]` is closed access with no preprint, but `[LorenzZimmermann2023]` (arXiv:2306.07108) state their Theorem 4.4 as *"a generalized version of the main results of M. Krebs"*, and specialising their table to `q = ⟨1,1⟩`, `a = 1`, `n = 2` gives **`ω(UD(𝔽_q,2)) = 3` if `char = 3` or 3 is a square in `𝔽_q`, and `2` otherwise — i.e. for `p ≡ 3 (mod 4)`, `ω = 3` iff `p ≡ 11 (mod 12)` and `ω = 2` iff `p ≡ 7 (mod 12)`.** It agrees with all six values this project holds (kernel `decide`s at 11 and 19; M61's measurements at 23, 31, 43, 47). **So the clique number of every finite Euclidean plane is 2 or 3 in closed form** — sharper than [Vinh2006]'s `ω ≤ 4`, and it retires M59's and M61's per-prime `ω` computations entirely. The one piece still wanted from Krebs is his stated criterion for `χ > ω`, which no citing paper reproduces and which is exactly what G24/G40/G44 are about. **What stays ours: the exact threshold (every plane from 59 up refuses five), the exact values in the kernel, the sieve, and everything downstream at M59–M61.** | `Proofs/HadwigerNelson/UnitQuadrance.lean`, `Instances/FinitePlane11.lean`, `tools/fplane.py`, `data/fplane/`, `plans/M58-field-sieve.md` | M58 |
| 54 | **The finite-plane lift: first-order rigidity decides it, and the hub scan** (M59). **Kernel** (`Lift.lean`, `Instances/LiftObstruction131.lean`, standard three axioms): `Colorable.of_le_map` / `chromaticNumber_le_of_le_map` (colourings pull back along an injective image), `UDCert.drawing_map` (the drawing is natural in the ring), `UDCert.chromaticNumber_le_of_drawing` and **`add_one_le_chromaticNumber_plane_of_lift`** (a finite-plane subgraph refusing k colours, covered injectively by a valid certificate, gives χ(ℝ²) ≥ k + 1 — the recipe); `StressedEdge`, `netStress`, `IsStress`, `IsLift`, `stressPairing`, **`stressPairing_eq_zero_of_lift`** (in any commutative ring with π² = 0, a lift x₀ + π • y of a stressed framework forces the pairing Σ wt·(quad − 1) to vanish — the level-p² obstruction at ZMod (p²), the level-(k+1) one at π = p^k) and **`not_exists_lift_of_stressPairing_ne_zero`**; `ZMod.exists_eq_add_mul_of_castHom_eq` (the residue class is the deformation space), `UDCert.stressPairing_eq_zero_of_drawing` (a certificate drawn at level p² agreeing modulo p is a lift); spec: the hex shell at 11 (pairing 0 in ZMod 121, twelve nonzero defects cancelling), the collinear triangle at 3 (pairing −3 ≠ 0 in ZMod 9); **the instances**: the 1581's merged image at 131 — 26 vertices, 48 edges, pairing 7205 ≠ 0 — has no lift modulo 131² and no covering tower certificate; the plane's own 5-critical cores at 11 and at 19 (63 and 138 vertices, 1-minimal, the solver's) — a 9-vertex 12-edge witness with pairing 33 ≠ 0, a 17-vertex 29-edge one with pairing 342 ≠ 0 — have no lift modulo 121 and 361; ω(UD(𝔽₁₁,2)) = 3, ω(UD(𝔽₁₉,2)) = 2 decided. **Derived** (`plans/M59-finite-plane-lift.md` §S1–§S2, §R1): the obstruction count ≥ \|V\|/2 + 3 for a 6-critical H; the rigid dichotomy (unique local lift, algebraic, real iff a real place); the lift's primes unramified; triangles iff p ≡ 11 (mod 12), the spindle iff p usable for K, sphere chords iff the Heron quantity is a square. **Measured** (`tools/fplift.py`, 16 controls; `data/fplane/`): the 1581 recovered from residues at 131 to 131²⁰ (P4); its merged image obstructed (2,406 of 4,785 conditions); Heule-510 at 131 passes 1,472 conditions; the 131 plane undecided at five colours in an hour; the 5-critical cores of UD(𝔽₁₁,2) and UD(𝔽₁₉,2) at 63 and 138 vertices, rigid and obstructed (98 of 123; 330 of 346); **the hub scan: 3,739 exact depth-one hubs of the 1581 at 131 (support 3–13), 1,171 of Heule-510 (11 = Heule-553's discarded vertices), samples verified exactly in the tower**. Classical rigidity theory (Laman, Asimow–Roth) and Hensel; the obstruction in the dual-number form over any ring, its kernel instance, the lift dichotomy for finite-plane subgraphs, the ramification scope and the hub scan are ours. | `Proofs/HadwigerNelson/Lift.lean`, `Instances/LiftObstruction131.lean`, `tools/fplift.py`, `data/fplane/{lift,core,hubs}-*.json`, `plans/M59-finite-plane-lift.md` | M59 |
| 55 | **The five-colour residue obstruction: compulsions map forward, and a sealing plane has none** (M60). **Kernel** (`ResidueObstruction.lean`, `Instances/ResidueObstruction11.lean`, standard three axioms): `Forces.image`/`Separated.image` (a homomorphism carries a forced pair / virtual edge to its images); `addCayleyTranslate` and the origin reductions `forces_iff_forces_zero_sub`/`separated_iff_separated_zero_sub`; `not_forces_zero_of_not_periodic` (through `Function.Periodic`), `not_separated_zero_of_coincides`; **`forces_iff_eq_of_aperiodic`, `separated_iff_adj_of_coincides`, `three_le_arityFloor_of_aperiodic_coincides`** (a Cayley graph coloured by one aperiodic table coinciding at non-edges has no arity-2 compulsion); **`Forces.quad_sub_eq_zero`, `Separated.quad_sub_eq_one`** (the distance law); `UDCert.drawing_quad` (quadrance of a drawn difference = residue of the stored squared distance; `drawing_adj` its `r = 1` face), `not_forces_of_distSq`/`not_separated_of_distSq` + `PairsAt` wrappers; at 11: `finitePlane11_aperiodic`, `finitePlane11_coincides` (two decides), **`finitePlane11_forces_iff` (`↔ u = v`), `finitePlane11_separated_iff` (`↔ Adj`), the floor bracket `{3,4,5}`**, `residue_eq_of_forces_11`, `residue_adj_of_separated_11`, **`not_separated_sqrt3_11`, `not_separated_two_11`**, `not_forces_two_11`, `not_forces_five_11`; spec on Heule-510 and the hex shell; the 3-plane's periodic table as the red. **Measured** (`tools/fpcompel.py`, 8 controls; `data/fplane/`): `F = {0}`, `S = N₁` at 3, 7, 11, 19 (verified colourings throughout) — **and that is now a THEOREM at every prime, not four instances (2026-09-09, consolidation package P4): `PlaneRotation.finitePlane_forces_iff` — for every prime `p ≡ 3 (mod 4)` and every `k` the plane ADMITS, `Forces (finitePlane p) k x y ↔ x = y`.** The mechanism is one rotation: the quarter turn `(x, y) ↦ (−y, x)` is an automorphism of `unitQuadrance R` over any commutative ring, so if `d` is a period of every proper colouring then so is `quarterTurn d`, and over a field where `−1` is not a square those two are a **basis** — the period group is everything, the colouring is constant, and a constant colouring of a graph with an edge is improper. **The colourability hypothesis is load-bearing and the module ships its counterexample**: `finitePlane3_not_colorable_two` plus a distinct pair of `UD(𝔽₃,2)` vacuously forced at `k = 2`. `Instances/PlaneFreedom.lean` re-derives all four measured primes (with a new certified 4-colouring at `7`) and cross-checks M60's `finitePlane11_forces_iff` and M61's `finitePlane3_forces_iff`, both of which stand. No arity-3 compulsion at 11 (31,602 questions, all realized); the seed's 446 cheats → 102 residue pairs at norm 4 and the augmented plane refuses five; the it-4 object's 149/344 likewise; M55's asks: 35 of 86 undecided settled by residue, 51 residue-allowed at norm 1. Folklore-adjacent in its pieces (pullbacks, vertex-transitivity); the packaging — one table decides a Cayley graph's compulsion structure, the distance law, the hex-shell gadgets blocked separately over every sealed field — is ours. **AND IT ANSWERS A QUESTION POSED IN 2018 AND NEVER ANSWERED (found 2026-09-09, FS-23, in `[Polymath16threads]` thread 4).** The Polymath16 project asked, verbatim: *"Does `5/3` receive the same color as `0` in every 5-coloring of `R`? These two points are always monochromatic for homomorphic colorings, and if this behavior persists for general colorings, then a spindling argument implies `χ ≥ 6`."* **That is FS-6/G48's design target, posed eight years early — and this row's distance law answers it in the negative** for every field where 11 is usable, which includes `K` and every field the descent used: a pair forced equal at five colours needs `11 ∣ d²`, and `(5/3)² ≡ 4 ≢ 0 (mod 11)`. So the behaviour cannot persist, and the spindling argument they hoped for cannot fire at `5/3`. **The lesson for FS-6 is the useful half**: they had the right shape and no way to filter the distance; the residue law is that filter, and it says where to look instead. | `Proofs/HadwigerNelson/ResidueObstruction.lean`, `Instances/ResidueObstruction11.lean`, `tools/fpcompel.py`, `data/fplane/{compulsions,augment,residue-filter,arity3}-*.json`, `plans/M60-five-colour-residue-obstruction.md` | M60 |
| 56 | **Local–global tightness: the spindle turns off its own prime, the periodic quotient, the counting bound** (M61). **Kernel** (`LocalGlobal.lean`, `Instances/LocalGlobal19.lean`, standard three axioms): `unitCircle`/`quadrance` named; **`addCayleyMap`** (an additive hom whose kernel misses the connection set is a Cayley hom into any `D ⊇ π '' S`), `colorable_of_addCayleyMap`, `addCayleyColoring` (a table proper along `D` colours the Cayley graph), `periodic_comp_of_mem_ker`, `decidablePeriodic`, **`Forces.eq_of_forall_exists_not_periodic`** (colourings with no common nonzero period refute every forced pair — M60's aperiodic table is the singleton case), `projAlong` (the projection along a direction), **`unitQuadrance_colorable_of_quotient`** (the plane is colourable from a table on its quotient along a null direction); **`card_le_mul_of_colorable`**, `card_le_mul_indepNum_of_colorable`, `not_colorable_of_mul_lt`, **`card_le_chromaticNumber_mul_indepNum`** (`card ≤ χ·α` in ℕ∞); `sq_add_sq_eq_zero_iff`, **`quadrance_eq_zero_iff`** (no isotropic vectors mod `p ≡ 3 (4)`); **`isSquare_neg_one_of_spindle_radicand`**, `no_ringHom_of_spindle_radicand`, `quadrance_sub_eq_zero_of_map_eq`, **`Forces.no_hom_of_spindle_radicand`**, **`Forces.isEmpty_ringHom_of_spindle_radicand`** (a pair forced at `k` colours, drawn in a ring holding its spindle radicand, has no reduction to a `k`-forces-free plane); specs: `ℤ[√11] →+* ZMod 3` and `ℤ[√43] →+* ZMod 11` empty, `ℤ[√3]`/`ℤ[√11] →+* ZMod 11` inhabited, reds at 5 and 7; **`finitePlane19_colorable_five`, `chromaticNumber_finitePlane19_le_five`** (a 19-entry periodic table), `lines19_isIndepSet` (`76 ≤ α`), `finitePlane11_colorable_six_periodic`, **`finitePlane3_forces_iff`** (two tables), `rhombus_spindle_no_hom_3`, `Forces.isEmpty_ringHom_of_spindle_radicand_11`. **Derived** (§S1–§S5): the local bound in full; ϑ = Hoffman by arc-transitivity ([Lovasz1979]); periodic ⟺ a circulant `C_p`; equivariance as the symmetric family; the mechanism of tightness. **Measured** (`tools/fplane.py`, 27 controls; `data/fplane/`): ϑ = Hoffman at eleven primes; `χ(C_p)` to 71 with every lifted colouring verified; α(11) = 28, α(19) ≥ 76, α(23) ≥ 106 undecided at 2 h; equivariant colourings at 11 (orders 2, 3), 19 (the half-turn), 23 (every order ≥ 3 refused); UD(𝔽₂₇,2) ≥ 5. Classical pieces (Lovász's theorem, coset colourings of Cayley graphs, the sum-of-two-squares congruence); the mechanism, its kernel form, the periodic quotient as a plane certificate and the calibrations are ours. **PRIOR-ART CORRECTION 2026-09-08: `addCayleyMap`/`colorable_of_addCayleyMap` is [Moorhouse2010] §4.2, and the periodic quotient is one instance of [CervantesKrebs2023]'s matrix method (an abelian Cayley graph is an integer matrix; row operations are graph homomorphisms to smaller Cayley graphs, hence χ upper bounds) — a paper listed UNREAD in our own bibliography since 2026-09-06. The mechanism of tightness (G48) is in neither.** **AMENDED 2026-09-09 (consolidation package P4): the mechanism's hypothesis is discharged in general.** `Forces.no_hom_of_spindle_radicand` and `Forces.isEmpty_ringHom_of_spindle_radicand` take *"the plane at `p` is `k`-forces-free"* — a table per prime, held at four. `Forces.no_hom_of_spindle_radicand_of_colorable` and `Forces.isEmpty_ringHom_of_spindle_radicand_of_colorable` (`PlaneRotation.lean`) take **`(finitePlane p).Colorable k`** instead, through `finitePlane_forces_eq`. So G48's tightness mechanism no longer fires only where somebody has solved a plane; it fires wherever a colouring is known, and a colouring is the cheap half. **And the same theorems now exist over any field in which `−1` is not a square** (`..._of_not_isSquare_neg_one`, `LocalGlobal.lean`), so the odd-degree face of the sieve — `UD(𝔽₂₇, 2)`, Haugland's cubic field — is expressible in the kernel for the first time. | `Proofs/HadwigerNelson/LocalGlobal.lean`, `Instances/LocalGlobal19.lean`, `tools/fplane.py`, `data/fplane/{theta,periodic,alpha,equivariant}-*.json`, `data/fplane/chi-q27.json`, `plans/M61-local-global-tightness.md` | M61 |
| 57 | **Theorem B and Theorem A in the kernel: the residue colouring, and its arithmetic reduced to two facts** (2026-09-08, the backlog's B1 then the general case; all on axioms exactly the standard three). **Theorem B** (`FieldWall4.lean`, 1,386 lines, zero sorry): **`chromaticNumber_seamPlane : χ(ℚ(√3,√11)²) = 4`** by `le_antisymm` — `four_colorable_of_seam_field` above, the Moser spindle drawn as an identity in the order below. The engine: `Quad b c R`, one generic quadratic layer with a universal property (`hom_ext`), stacked three deep into `O = ℤ[ω, i, T]` (`T = (1+√33)/2`, load-bearing — `9ρ = 7 − ω + T + 2ωT` for the Moser twist, and in `ℤ[ζ₁₂, √33]` the descent fails outright); `F4` hand-built with every ring axiom by `decide`; two residue maps `psiZero`, `psiOne` onto `𝔽₄` — the two primes above `2` — with conjugation inducing Frobenius (`psi_comp_conj`); **`den_injective`** through `Ladder.sqrt_indep` twice; **`exists_mul_onePlusI`**, the PARITY DESCENT that replaces the hand proof's valuation theory (the joint kernel of the two residue maps is visibly `(1+i)·O`: `p ≡ q mod 2` coordinatewise, so `z/(1+i)` is integral); **`mem_oddDenom_of_unit`** (a unit vector's denominator over `O` is odd, by strong induction on it); `seamField : Subfield ℝ` proved a field through two quadratic conjugate steps; and the consequences that halted M53 — `not_forces_five_of_subset_seamPlane`, `not_separated_five_of_subset_seamPlane`. **Theorem A** (`ResidueColouring.lean`, 244 code lines, zero sorry): **`colorable_of_residue`** — a graph *drawn* in an abelian group by any `f : V → M`, every edge difference in a subgroup `A` and nonzero under `ψ : A →+ G`, is `Fintype.card G`-colourable. **No metric, no field, no ring, no Cayley structure** — the edge set need not be translation-invariant. The colouring is `cosetResidue ψ`, `ψ` extended by coset representatives and normalized to restrict to `ψ` on `A` (`cosetResidue_apply_of_mem`, `cosetResidue_sub` a conditional `map_sub`, `cosetResidue_eq_iff`). The arithmetic in two facts: **`isUnit_of_mem_normOne` / `map_ne_zero_of_mem_normOne`** (a norm-one element of a σ-stable subring is a UNIT of it, so its residue is nonzero in any nontrivial target — the norm-one condition's entire role, and `Nontrivial G` is what pays for it) and **`normOne_subset` / `normOne_subset_valuationSubring`** (a σ-stable subring holding one of every reciprocal pair contains every norm-one element — Theorem A's `v_𝔭(u) = 0` step in two lines, with Mathlib's `ValuationSubring` as the bundled hypothesis). Then `colorable_of_normOne`, `colorable_of_valuationSubring`, the plane forms `colorable_unitDistance_of_residue` / `_induce_of_residue`, and **`colorable_unitDistance_induce_of_valuationSubring`** — Theorem A in the write-up's own shape (a conjugation-stable subfield of `ℂ`, a conjugation-stable valuation subring of it, a hom to a finite nontrivial ring). **`conj_mem_valuationSubringAtPrime`** closes the risk the stub priced at 150 lines in FOUR: the localization of a Dedekind domain at a height-one prime fixed by an automorphism is stable under it, because Mathlib's `valuationSubringAtPrime` has elements `a/s` with `s` outside `𝔭`, so stability is `σa/σs` — not a statement about valuations at all. `colorable_unitQuadrance_of_residue` states the same theorem over the coordinate group of an arbitrary commutative ring, so "this does not need `ℂ`" is checkable rather than asserted; the spec proves `additiveColoring` (`Additive.lean:41`; the file opens only `namespace HadwigerNelson`, so the dotted form does not resolve — corrected 2026-09-09) is literally the same function at `A = ⊤`; the non-vacuity model uses a genuinely partial `ψ` (halving on the even integers, which provably does not extend). **Theorem B is re-derived as an instance and `FieldWall4` got SMALLER** (1403 → 1386 lines) — the honest test. Mutation audit run with a green control. **Extended 2026-09-09 (P6):** the same file now carries the **residue law** — not only *that* the residue colouring colours, but *which pairs it identifies*: a unit cofactor is invisible to a residue (the kernel is an ideal; nothing is assumed of the residue ring), and a conjugation-stable kernel makes the norm a test for the element (where primality is spent, as `[NoZeroDivisors]`). The colouring is now available as an object (`normOneColoring`) and not only as a colourability, which is what a consumer that must *evaluate* it needs; `colorable_of_normOne` is its corollary, statement unchanged. **NOT proved, and said in the module's own docstring: that a number field with a conjugation-fixed prime supplies the valuation subring with residue field of size `N(𝔭)`** (the σ-stability half is proved; the finiteness, the count and the embedding are not). **AND A PRIOR-ART ITEM NOBODY HERE HAS SEEN, found 2026-09-09 (consolidation package P2 §3a) and recorded so FS-20 cannot miss it: the Polymath16 wiki page "Coloring R_2"** — an unfinished, careful draft attempting a **rigidity** proof (not merely exhibiting a colouring) for the `ℚ(√−3)` analogue of Theorem B's own mechanism: residue field `𝔽₄` at a conjugation-fixed prime above 2, Frobenius equal to complex conjugation, built around the square root of the Moser-spindle twist. It stops mid-argument at "Corollary 9" with no conclusion. **This is the closest anyone has come to attempting Theorem B's ARGUMENT rather than posing its question, and the milestone that writes the paper must read it.** The page is offline; the Internet Archive has the wiki. Not obtained here (`BIBLIOGRAPHY.md` §C). **Prior art ([Fischer1990], found 2026-09-08): the unit argument is his Theorem 1(iii) proof and the component lemma is his Theorem 1 proof; on a FULL plane our theorem is exactly his Theorem 1(i), since any admissible `(A, ψ)` restricts to a hom on `Σ₀`. What is not his: the valuation-ring reduction (he never needs it — he takes `A = Σ₀`), the applicability to graphs that are not full planes, and the formalization.** **PRIOR-ART CORRECTION 2026-09-08 (FS-18 postscript, on `[Madore2015]` — the closest prior art to this project's whole field arc, found through `[Krebs2022]`'s reference list once Kooshi obtained that paper).** **Theorem A's valuation-subring form is his Proposition 3.2**, published 2015: for a valuation ring `A` with residue field `κ` over which `z₁²+⋯+z_d²` is anisotropic, there is a graph hom `Γ(K^d) → Γ(A^d)` and `χ(K^d) = χ(A^d) ≤ χ(κ^d)` — proved exactly as ours, by integrality of unit vectors and then **a choice of coset representative in each class of `K^d/A^d`**. So `colorable_unitDistance_induce_of_valuationSubring`, which this row calls "Theorem A in the write-up's own shape", is his theorem; and `normOne_subset_valuationSubring` is his integrality step. **What survives, and it is precisely delimited: Theorem A's GENERAL form is the formulation Madore explicitly declined to write.** In his Proposition 3.9 he needs a subgroup that is *not a ring* (`(1/√2)A` in `ℚ₂(√2)`), performs the coset construction by hand, and appends the parenthetical *"which the author has not found the courage to try to formulate under the most general auspices"*. `colorable_of_residue` — an arbitrary graph *drawn* in an abelian group, edge differences in a subgroup, non-zero under a partial homomorphism out of it, no field, no metric, no ring, no valuation, no Cayley structure — **is that general formulation, and it is kernel-checked.** Also his: the `mod m²` refinement (his Prop 3.8) that `FieldWall4`'s parity descent re-derives, and the scope fact that `d > 2` is vacuous over finite fields by Chevalley–Warning (his Rem 3.5). He cites none of Fischer, Moorhouse, Manturov, Vinh, Johnson or Chow. **AND THEOREM B ANSWERS TWO MORE STATED OPEN QUESTIONS, found 2026-09-08 (FS-18) — three in all, posed independently by three groups who do not cite one another.** (i) **Benda–Perles Open Problem 11.6**, as recorded in [Soifer2024] ch. 11, verbatim: *"Find the chromatic number of `ℚ²(√2)` and, in general, of any algebraic extension of `ℚ²`."* (ii) **[CranstonRabern2015]**, verbatim: *"What is the fractional chromatic number of `ℚ(√3,√11) × ℚ(√3,√11)`? What about its chromatic number?"* — they had shown `χ_f(K²) ≥ 76/21` on a graph built from the triangular lattice plus Moser spindles at integer multiples of `arccos(5/6)`, which is this project's own direction ladder (T13), and Theorem B **brackets their first question at `76/21 ≤ χ_f(K²) ≤ 4`** while closing their second outright. (iii) [Moorhouse2010] §1, already recorded above. That the same problem was posted three times and answered here without knowledge of any posting is G49's two-literatures diagnosis measured again. | `Proofs/HadwigerNelson/{FieldWall4,ResidueColouring}.lean`, `scripts/Axioms.lean`, `plans/B1-field-wall-kernel.md`, `plans/A1-theorem-A-kernel.md`, `plans/STUB-theorem-A-kernel.md` §B | 2026-09-08 |

| 58 | **The mascot obstruction: the Moser spindle's recipe has a sharp threshold at three colours** (2026-09-09, Kooshi's challenge — derive the Moser spindle's analogue for a 5-chromatic field, or prove it impossible; all on axioms exactly the standard three). The Moser spindle is one recipe: take the **smallest graph forcing two non-adjacent vertices to share a colour** at `k` colours, hinge two copies at a common vertex, choose the hinge angle so the forced vertices land at distance 1. **The recipe stops at `k = 3`, provably.** `card_le_of_forces` — a graph forcing a pair at `k` colours has `≥ k+1` vertices (join the pair; the result is not `k`-colourable, and every graph is colourable in its own order); `colorable_of_not_adj` — a graph on `n+1` vertices with a non-adjacent pair is `n`-colourable (paint the two alike, the rest distinctly); `isNClique_of_forces_of_card` — **at exactly `k+1` vertices the graph is complete minus the forced edge, so it contains a `k`-clique**; `no_four_unit_points` — **four points of the plane are never pairwise at distance 1**, by a Gram determinant that is `1/2` from the distance data and `0` because three plane vectors are dependent (one `ring`, three `linear_combination`); and the composite **`not_forces_of_unit_drawing`: no five points of the plane carry a pair forced to share a colour at four colours**. **The contrast is the content**: at three colours the minimal gadget is `K₄ − e`, which IS a unit-distance graph — the rhombus of two unit triangles, far tips at `√3`, exactly what the Moser spindle hinges; at four colours it contains `K₄` and `ω(unit-distance plane) = 3`. **The plane's clique number equals the colour count at `k = 3` and falls below it forever after** — below that line forcing is local, free and four points wide; above it no counting argument forces anything and every compulsion is global. That is the derived reason the Moser spindle is 7 vertices and every 5-chromatic unit-distance graph ever built is 500+ with a computer behind it, and it is G25's holonomy reading turned into a theorem. **Scope, stated honestly**: this proves the *minimal-shape recipe* has no analogue, NOT that no 5-chromatic unit-distance graph in those fields can be derived — the latter is not a mathematical statement. What survives of the attempt is the arithmetic (`plans/STUB-four-colour-valuation-law.md`), and what died is recorded in `plans/MASCOT-DERIVATION.md` §8. **GENERALIZED AND SHARPENED THE SAME DAY (Kooshi's item 1): the obstruction is now HOST-GENERIC and the threshold is a theorem in BOTH directions.** `isNClique_image` — an injective homomorphism carries a clique forward, adjacency preserved and never reflected, which is exactly what a drawing gives; **`not_forces_of_drawing`** — *a host graph with no `k`-clique draws no minimal forcing gadget at `k` colours*, for any host, with the clique number as the entire hypothesis and nothing geometric in the statement; `no_isNClique_of_four_le` — the plane's clique number is three at every size from four up; **`not_forces_of_unit_drawing`** now reads *for every `k ≥ 4`, no `k + 1` points of the plane carry a pair forced at `k` colours* (and `≤ k + 1`, since below the floor forcing is impossible outright), with `not_forces_five_points` the `k = 4` case the challenge was posed at. And the other side, which turns a bound into a threshold: **`exists_forces_of_unit_drawing_three`** — the rhombus DRAWN (`rhombusDraw` at `ζ₆, 0, 1, ζ̄₆`, `rhombusDraw_injective`, `rhombusDraw_unit`) is the minimal gadget at three colours realized in the plane, four vertices exactly, forcing its far corners. So the recipe works at `k = 3` and at no `k` above, and the two theorems bracket it. The earlier headline said "exactly one value of `k`"; that is **loosened here to what is proved** — the minimal gadget is drawable for every `k ≤ 3` (at `k = 1` and `k = 2` trivially), and `k = 3` is the last, which is the sharp statement. | `Proofs/HadwigerNelson/Mascot.lean`, `plans/MASCOT-DERIVATION.md` | 2026-09-09 |

| 59 | **The 2-adic law of four-colour compulsions: which distances can carry one over `K`, and a correction to what a plane-wide pigeonhole means** (2026-09-09, Kooshi's item 2; all on axioms exactly the standard three). Theorem B colours `K² = ℚ(√3,√11)²` by a residue map at the conjugation-fixed prime `𝔭` above 2. That is ONE proper four-colouring, so **every four-colour compulsion in `K²` has to survive it** — and which pairs it identifies is arithmetic. **The law** (`residueColouring_eq_iff_psiA_zero`): for `z, w ∈ K²` at distance `d` with `d` itself in `K` of odd denominator, the residue colouring identifies them **iff `d` lies in the prime**. The proof is one factorization — `z − w = d · u` with `u` a unit vector, and a unit vector is a *unit* of the odd-denominator ring (`conj_mem_oddDenom` supplies its inverse), so its residue is invertible and the difference's residue is the scalar's; `𝔽₄` has no zero divisors, by exhaustion over sixteen pairs. **The same law through the squared distance** (`psiA_eq_zero_iff_normSq`), which is the form the stub stated and which needs no assumption that `d` lies in `K`: for any difference lying in the odd-denominator ring, its residue vanishes exactly when `d²`'s does, because conjugation induces Frobenius on the residue field (`psiA_conj`), so `ψ(v)³ = ψ(v·v̄) = ψ(d²)` and in `𝔽₄` a cube vanishes only with its base — `1 + i` is the instance the scalar form cannot reach, a `K`-point difference of length `√2` with `√2 ∉ K`. Consumers in the hunt's vocabulary: **`not_forces_of_residue_ne_zero`** (a distance outside the prime carries no forced-monochromatic pair at four colours over `K`) and **`not_separated_of_residue_eq_zero`** (a distance inside it carries no virtual edge), each cashed by exhibiting the residue colouring as a `Fin 4`-colouring (`seamColouring`). **It explains a published table nobody explained.** `[Parts2020a]`'s Table 1 gives computer-found minimal gadget sizes for four-colour compulsions — monochromatic pairs at `8/3` (367 vertices) and `8/√3` (421); distinct pairs at `3` (214), `7/3` (319), `5/3` (315), `1/3` (312), `√(11/3)` (308) — **two of those seven distances are UNVERIFIED AGAINST THE SOURCE PDF (flagged 2026-09-09, consolidation package P2 §3a): two independent searches read the 214-vertex row as `3` versus `√3` and the 312-vertex row as `1/3` versus `1/√3`, and both were reading automated text extractions, which is exactly where a root sign vanishes. The check is one PDF away and has not been done. The law's prediction is probably unchanged either way — `3` and `√3` have the same valuation at `𝔭`, as do `1/3` and `1/√3` — and the two MONOCHROMATIC rows are not disputed** — and **every monochromatic distance is 2-adically even while every distinct one is a 2-adic unit**, which Parts does not remark on. All seven rows are proved here: each distance is **barred from the other column**, one bit of arithmetic apiece, with the red that pins the reading (`8/3` and `7/3` share a denominator and land in different columns, so the criterion is the numerator's valuation and nothing else). It also explains M53's rigidity dial, which found forced pairs at that depth and nowhere else over 15,230 pairs and recorded the regularity as unexplained. **And the correction that came with it, which is the more important half.** The stub's companion argument — *a plane-wide pigeonhole at `d` forbids every virtual edge at `d`, and we hold them at `√3` and `2`* — is **unsound, because those pigeonholes are vacuous**: `core9_plane` and `core122_plane` quantify over four-colourings of the whole plane, and rung B says that type is empty. `isEmpty_coloring_plane_four` (`Instances/Interval.lean`) is that emptiness as a theorem, `vacuous_of_plane_four_coloring` its general reading; row 31 is amended in place, both corollaries carry a scope comment, and the retraction with its non-vacuous replacement (re-state the carriers over `K`, transport by a norm-one element of `K(i)`, glue, contradict Theorem B) is written up in `plans/STUB-four-colour-valuation-law.md`. **So `√3` is settled in one polarity and open in the other**: no forced-monochromatic pair over `K` (proved), and no virtual edge over `K` (the sketch, a day's work, most of it showing the nine-core's points lie in `K²`). **PRIOR ART, found the next day (2026-09-09, FS-23) by reading three held papers and one §C title — and it makes this row STRONGER, not weaker.** The law's *observed* form is published twice and its proof is asked for in print. (a) **`[Heule2019]` §5 and §7**, whose section is titled *"Observed patterns of points in `Q[√3,√11] × Q[√3,√11]`"* — he names `K` in 2019 — records of his `K`-object `G2167` that points `1/3` apart get different colours in every 4-colouring (*"Hence 1/3 is a so-called virtual-edge"*) and points `2/3` apart get the same colour, **stated as unexplained observations**: `v_𝔭(1/3) = 0` and `v_𝔭(2/3) = 1`, the two columns, exactly as the law requires. (b) **`[PartsOdd2022]` §1**: *"for a proper 4-coloring of some UDGs embedded in `ℚ(√3,√11)`, so-called virtual edges naturally appear between the vertices at an **odd** distance from each other"* — and **odd integers are precisely the integer case of `v_𝔭(d) = 0`.** (c) **`[Heule2021]`, *Odd-distance virtual edges in unit-distance graphs*, Geombinatorics 31(2) (2021)**, states a reciprocal duality — *if an odd `d` is a `k`-virtual edge of a subset of the plane, so is `1/d`* — meant, per Parts's report of a private correspondence, of *"larger objects like `ℚ(√3,√11)`"*; Parts records a finite counterexample and writes that **"a more accurate formulation of the statement and its proof are of certain interest."** Our law is that formulation on the necessary side: `v_𝔭(1/d) = −v_𝔭(d)`, so **the condition is invariant under `d ↦ 1/d`**, which is why the duality could only ever have been stated for odd distances, and the finite counterexample does not touch it because the condition is necessary and not sufficient. (d) **`[Ardal2009]`** carries a four-colour mono-pair at distance **8** in the triangular lattice — `v_𝔭(8) = 3`, the same law from 2009. **What this converts the row into is half of a classification, with the other half conjectured and supported by every published data point.** *Conjecture (FS-23, 2026-09-09): over `K` at four colours, a pair at distance `d ∈ K` is a virtual edge in some finite `K`-object iff `v_𝔭(d) = 0`, and is forced monochromatic in some finite `K`-object iff `v_𝔭(d) > 0`.* The two "only if" halves are this row's theorems; the two "if" halves are open, and the evidence for them is every published instance — all five non-mono rows of Parts's Table 1 and his `3`, `1/3`, `3^{±a}`, `5`; Heule's `1/3`; and on the mono side `2` (de Grey, Haugland), `8/3`, `8/√3` (Parts), `2/3` (Heule), `8` (Ardal). **And a consistency check that is really an identification: this row IS G48's tightness mechanism at the prime above 2.** G48 says a pair forced equal at `k` colours over a field sealed by `𝔭` has `𝔭 ∣ d²`, and its spindle adjoins `√(4d² − 1) ≡ √−1 (mod 𝔭)`, removing `𝔭`. Here `𝔭 ∣ 2`: the law's positive-valuation side is exactly what guarantees every four-colour spindle **breaks the 2-adic wall**, which is why `χ(K²) = 4` and the mono distances `2, 4, 8, 8/3, 8/√3, 2/3` all have `√(4d²−1) ∉ K` (`√15, 3√7, √255, √247/3, √759/3, √7/3`) — checked here at six values, and forced, not coincidental. **AND A SECOND, SHARPER CORRECTION THE SAME DAY, which is the one that binds: the law's IDENTIFICATION half was published three months earlier, in coordinates.** `[Ducz2026]` (*A note on geometric colorings of the Moser lattice*, arXiv:2606.12325, 10 June 2026) gives an integral **geometric** 4-colouring of the Moser lattice `ℤ⟨1, ζ₆, ω₃, ζ₆ω₃⟩` (`ω₃ = (5+i√11)/6`, the Moser twist — this project's own direction ladder, T13, under the literature's name) as a homomorphism onto `(ℤ/2)²`, and proves properness through **exactly our criterion**: with `\|z\|² = (N + M√33)/6`, two points share a colour **iff `N + M ≡ 0 (mod 4)`**. His Lemma 2.1 is the structural statement — an integral colouring is geometric iff sharing a colour depends only on the distance — and his Theorem 3.2 says there are **exactly two** such colourings on the Moser ring `L[1/3]`, which are our two conjugate primes above 2. **Checked here: his congruence reproduces ten for ten of the data this row explains** — all seven of Parts's rows and both of Heule's. So the sentence *"it explains a published table nobody explained"* is **amended**: the arithmetic that explains it was in print in June 2026; what was not in print, and is still not, is **the connection** — Dúcz cites neither Parts nor Heule's virtual-edge work and draws no compulsion consequence at all. **And one instance is older still**: `[Polymath16wiki]`, last edited **4 June 2018**, states flatly that *"in the ring `R̄₂` it is known that the element `8/3` has the same color as zero"*, and spindles it through `ω_{64/9} = (119 + 3i√247)/128` to get a ring with no 4-colouring — the mono side of this law at `8/3`, and M53's T20 construction, eight years early. **OLDER STILL, and this is now the earliest instance known (added 2026-09-09, consolidation package P2): the `8/3` fact is in the `[Polymath16threads]` BLOG discussion a month before the wiki** — due to Jannis Harder, reported by Tamás Hubai on 9 May 2018 and used by Philip Gibbs on 6 May 2018, so it predates `[Heule2019]`, `[PartsOdd2022]` and `[Ducz2026]` as well. The thread text is held at `library/notes/polymath16-threads-1-18-text.txt`. **What survives, precisely delimited.** (1) **The field-level statement.** His is the `ℚ`-rank-4 Moser ring; ours is the whole rank-8 field plane `K²`, which is what Theorem B needs and what answers Moorhouse, Benda–Perles and Cranston–Rabern. (2) **The valuation formulation**, which makes the criterion intrinsic rather than coordinate-bound and immediately yields the `d ↦ 1/d` invariance `[Heule2021]` asked for. (3) **The compulsion consumers** — the step from "this one colouring identifies these pairs" to "no proper four-colouring of any `K`-object can force the others", which is the whole content for the hunt. (4) The proof of all seven of Parts's rows *as* a compulsion statement, the classification conjecture above, the vacuity correction, and the kernel certification. Fischer's and Madore's residue framework, `[Ducz2026]`'s congruence, and Heule's, Parts's and Ardal's observations; **(1)–(4) are ours.** **GENERALIZED 2026-09-09 (FS-24 item G2, package P6; kernel, standard three axioms).** The law was stated at one field, one prime, one four-element residue field and the literal `4`; its proof needs none of those, and the general statements now live in `ResidueColouring.lean` §4 with every `ValuationLaw.lean` statement — the seven `[Parts2020a]` rows included — **byte-identical** and every proof an instance. **Two findings came out of the move.** (1) **The scalar half needs nothing at all of the residue ring.** This row's own sentence *"`𝔽₄` has no zero divisors, by exhaustion over sixteen pairs"* names the wrong mechanism: the kernel of a ring homomorphism is an **ideal**, and an ideal absorbs units both ways (`map_mul_eq_zero_iff_of_isUnit`, no hypothesis on the target whatsoever). The sixteen-case exhaustion is true and was never the reason. (2) **The squared-distance half does not need Frobenius, and what it does need is the write-up's own hypothesis.** `psiA_conj` (conjugation induces squaring on `𝔽₄`) is special to that field; `map_mul_conj_eq_zero_iff` asks only that conjugation map the residue map's kernel into itself — *that the prime is fixed by conjugation* — and `psiA_conj` survives as what discharges it here (`psiA_ker_stable`). **The red that pins it is a split prime, concretely**: `ZMod 5 × ZMod 5` *is* `ℤ[i]/5`, the coordinate swap *is* complex conjugation, the first projection *is* reduction at one of the two primes above 5 — and conjugation exchanges them rather than fixing either, so `v = (1, 0)` has nonzero residue while its norm vanishes. **What a caller at a new prime of a new field now owes is one fact — that a unit vector is integral there** (`map_eq_zero_iff_of_mul_conj_eq`'s hypothesis `hq`), which is the only step that cannot be general (`K`'s subring is an intersection of two localizations, not a valuation ring, so `normOne_subset_valuationSubring` does not reach it). `FieldWall4.lean` got **smaller**, 1398 → 1392, which was the registered honest test. | `Proofs/HadwigerNelson/ValuationLaw.lean`, `Proofs/HadwigerNelson/Instances/Interval.lean`, `plans/STUB-four-colour-valuation-law.md`, `Proofs/HadwigerNelson/ResidueColouring.lean` §4, `Proofs/HadwigerNelson/Palette.lean`, `plans/P6-generalize-valuation-law.md` | 2026-09-09 |

| 60 | **Rotations of the quadrance plane, and the freedom they force** (2026-09-09, consolidation package P4; all on axioms exactly the standard three). **The general layer, over any commutative ring**: rotation by a circle point `a² + b² = 1` is an additive automorphism preserving quadrance (`rotEquiv`, `quadrance_rotMap`) and hence an automorphism of the plane (`rotHom`); the **quarter turn** `(x, y) ↦ (−y, x)` is its instance at `(0, 1)` and needs no hypothesis at all (`quarterTurn`, `quarterTurnHom`). **The field layer**: over any field in which `−1` is not a square, a nonzero vector and its quarter turn are a **basis** (`exists_smul_quarterTurn_eq`) — pure linear algebra, and the only place the plane's arithmetic enters. **The theorem**: over `ZMod p` with `p ≡ 3 (mod 4)`, a proper colouring is never periodic at both a nonzero `d` and its quarter turn (`not_periodic_quarterTurn`), so no nonzero `d` is a period of every colouring (`exists_not_periodic`), so — through M61's own `Forces.eq_of_forall_exists_not_periodic`, which was minted with no general supplier — **`Forces (finitePlane p) k x y ↔ x = y` whenever the plane is `k`-colourable** (`finitePlane_forces_iff`, `finitePlane_forces_eq`). **The consumer**: G48's tightness mechanism with its per-prime table hypothesis replaced by colourability (`Forces.{no_hom,isEmpty_ringHom}_of_spindle_radicand_of_colorable`). **The guard**: `Forces` is vacuously true on a graph refusing `k` colours, so the colourability hypothesis is necessary — `finitePlane3_not_colorable_two` and a distinct vacuously-forced pair ship beside the positive inhabitant `finitePlane3_colorable_three`. **The instances**: `Instances/PlaneFreedom.lean` re-derives ledger row 55's four measured primes 3, 7, 11, 19 — with a new certified 4-colouring of `UD(𝔽₇,2)` by the periodic-quotient recipe (the line through `(1,2)` has non-square quadrance `5`) — and cross-checks M60's and M61's table-based theorems at 11 and 3, which stand. **Also, FS-24 G3**: `LocalGlobal.lean`'s five spindle theorems gain field-level forms taking `¬ IsSquare (-1 : K)` (`..._of_not_isSquare_neg_one`), the `ZMod` statements kept verbatim as one-line corollaries, so `UD(𝔽_{p^n}, 2)` is expressible there for the first time. **Boundary, stated exactly**: prime fields only — over `𝔽_{p^n}`, `n > 1`, an additive subgroup is a subspace over the *prime* field, so `d` and its quarter turn span two of `2n` dimensions; the repair (the period set contains `r·d` for every norm-one `r`, its span is a subfield of `𝔽_{q²}` with more than `q` elements, hence everything) needs `𝔽_{q²}` as a field containing `𝔽_q` with its norm form identified, and is not attempted. **Prior art**: the objects are `[Vinh2005]`, `[Vinh2006]`, `[MMST1996]`, `[Krebs2022]`, all held; the rotations-are-automorphisms half is classical (M61 already used arc-transitivity); no source found states the freeness, and the adjacent classical theory — uniquely colourable Cayley graphs — is its opposite extreme. | `Proofs/HadwigerNelson/{PlaneRotation,LocalGlobal}.lean`, `Proofs/HadwigerNelson/Instances/PlaneFreedom.lean`, `plans/P4-generalize-and-plane-freedom.md` | 2026-09-09 |

| 61 | **Statements moved to the level their proofs occupy: the hex-shell target over any distance set, and a brick certificate as a two-distance bound** (FS-24 items G4 and G7b, 2026-09-09; all on axioms exactly the standard three; **no new mathematics — every item is a statement relocated, and each keeps its old form at its old name, mechanically**). **(a) The six-colour target is colour-generic.** `hexShell_plane` was already `{k : ℕ} (hk : k < 7)` and the numeral `5` appeared nowhere in its proof, so the two conditional theorems it feeds (`not_colorable_of_forced_pairs`, `add_one_le_chromaticNumber_plane_of_forced_pairs`) now are too — which makes typeable a sentence the repository could not previously write: **two SIX-colour gadgets at `√3` and `2` give `χ(ℝ²) ≥ 7`** (`not_colorable_six_of_forced_pairs`, `seven_le_chromaticNumber_plane_of_forced_pairs`), the affirmative side of G48's local–global conjecture in its bold form. The conjunction of ledger row 43 is preserved exactly and **now carries its two independence witnesses at six colours as well as five**, so the new instance is as honest as the old rather than inheriting the old one's adversaries. **(b) The pigeonhole over an arbitrary forbidden-distance set** (`hexShell_planeIn`, `not_colorable_distanceGraph_of_forced_pairs`), and the honest reading, which the module states: **at the pigeonhole this is a RESTATEMENT, not a strengthening** — the `distanceGraph ℂ D` and `unitDistance ℂ` forms are interderivable each in one line, because a colouring of the former with `1 ∈ D` is already a proper unit-distance colouring. **The content is one level up**, at the conditional refutation, where hypothesis and conclusion both weaken and neither statement implies the other: **`six_le_chromaticNumber_oneTwo_of_forced_sqrt3` — over `{1,2}` the shell's three diameters are already edges, so a SINGLE `√3` gadget at five colours gives `χ(ℝ²; {1,2}) ≥ 6`**, which is M49/M50's μ-dial target and had no kernel statement connecting it to the hex shell at all (the mirror is `not_colorable_distanceGraph_of_forced_two` at `D = {1, √3}`, one line). **The gap it closes is between two TURNS OF A SESSION, not two statements**: `Separated.planeIn` (M49) already returns a distance-graph-shaped fact and the old conditionals accepted only a unit-distance-shaped one, so a gadget-finder had to route through `Separated.plane` and discard the two-distance option at exactly the step the μ-dial exploits. Collapse worth recording: membership in `D` **implies** the separation hypothesis, so there is exactly ONE conditional theorem and the one-gadget forms are instances of it through a four-line discharge map (`coloring_ne_of_dist_mem`), not copies of an argument. **(c) `Brick.colorable` + `Brick.avoids` are one theorem** (`BrickDistance.lean`, a new leaf so `Brick.lean` is byte-for-byte unchanged and `Seven`/`Interval` are not rebuilt): a passing certificate colours `distanceGraph ℂ D` for every `D` whose distances are square roots of guards, so row 32's *"certified 9-colouring avoiding `√(3/2)`"* becomes **`χ(ℝ²; {1, √(3/2)}) ≤ 9`** — the form a future avoider find is quoted in, which is what row 32 says the module exists for. **(d) The keep-the-old-name rule is now COMPILED**: a pinning section ascribes the pre-generalization type to each of the eight names the record cites and closes it with the name as it stands, and **the negative control was watched to fire** (mutating one pin's `Fin 5` to `Fin 6` errors, naming both types). **(e) One measurement, over a named enumeration** (G21): across 480 rationals `n/d`, `n < 41`, `d < 13`, **`sevenBrick` passes with NO second guard — one hit, the properness guard itself — while `nineBrick` passes with 41.** M36's boundary-tightness, seen from a new side: a zero-margin certificate can carry no avoidance at all, and `Instances/Nine.lean`'s standing claim that it is kept *"because it carries the avoidance surface at distances the seven-colouring does not avoid"* is confirmed quantitatively for the first time. | `Proofs/HadwigerNelson/{Instances/HexShell,BrickDistance,Instances/Nine}.lean`, `plans/P5-hexshell-brick-generalization.md` | FS-24 |

| 36 | **The scale is not monotone, and the classical one is a local optimum** (M39; ω-values and the §0e shell-exhaustion claim corrected at M40 — see row 37): `Coset.eight_le_card_of_cell_constant` and `Coset.seven_le_card_fine` — for `1/2 < p < 3/5` any colouring constant on the triangular lattice's cells needs at least EIGHT colours, via an 8-clique of the constraint graph (the `3 × 3` address block minus a corner, pairwise norms `{1,3,4,7}`), and at least SEVEN again for `3/8 < p < 2/5` via the `√3`-scaled copy of the shell (the index-3 sublattice, pairwise norms `{3,9,12}`) — so the shell reappears at every scaled copy of the lattice and the oscillation seven → eight → seven is kernel-checked at three windows. Since the classical seven-colouring lives at `p ∈ (0.671, 0.866]`, **shrinking the cells past the classical scale costs a colour** — refining is not a route to six. **NOTE 2026-09-08 (FS-18): the `≥ 7` baseline of this row is subsumed by [SokolovVoronov2025] (see row 35), but the EIGHT and the non-monotonicity are not — a floor of seven says nothing about where the family is strictly worse, and that is this row's content.** Tools-side (`tools/celllat.py`, exact rational edge criterion, necessary AND sufficient, green control reproducing M38): the clique census across scales (7 → 8 → 7 → 4 → 3 → 2), no six-colouring at twelve scales on tori to 24 × 24 (period-bounded), a seven-colouring at `p = 6/13` below the classical window on three tori, `k = 8` also refusing in the bad band (so ≥ 9 at those periods), the `k = 4` mass red green throughout, and the torus-size control that retracted a tempting reading — the fine-scale refusals are period-bounded and the 24 × 24 row is UNKNOWN at cap. **PRIOR-ART NOTE 2026-09-09 (FS-23): the non-monotonicity itself is not new either — `[deGreyParts2022]` §2 records that their restrictions make `d(k)` decrease locally in `k`, and their §4 "Redundant colours?" asks outright whether some colours are redundant; `[Parts2023]` Conjecture 4 says that for some `k ≥ 7` no forbidden-distance interval has `χ = k`. That is G23's phenomenon in the dual variable, three years earlier. What stays this row's own is the EIGHT (an 8-clique theorem for arbitrary labels, which their sublattice framing cannot state) and the kernel certificates. See row 34's second correction.** | `Coset.lean`, `tools/celllat.py`, `build/m39-*.json`, `plans/M39-constraint-graph.md` §R | M39 |

### Paths forward, ranked

*(**Amended 2026-09-09 (fifth amendment) — THE CONSOLIDATION IS RUN AND MERGED.** Six packages in parallel git worktrees; the union builds green at 794 clean / 5 purchases. **FS-25, FS-24 and FS-26 are CLOSED but for named remainders**, which are collected and ranked as **FS-27 at rank 3** (`plans/STUB-consolidation-remainder.md`) — led by `core122_pigeonhole`'s unestablished premise, the only item on the board that could change what this project believes it owns. **FS-20, the paper, moves to rank 2**: it gains two inputs it did not have, both cheap and both blocking — Theorem A's headline form has no worked example anywhere, and a Polymath16 wiki page ATTEMPTS the rigidity argument behind Theorem B rather than posing it, which every other prior-art find in the seventh-lineage sweep merely did. **The three items held back deliberately** are FS-24's G5 (no bearing on the hunt) and G6 (a real re-proof whose witnesses must be sympy-derived first), the fourteen private copies of `√3·√3 = 3` (last, alone, in the main tree, into a NEW leaf module — a declaration added upstream rebuilds every dependent forever, which is *why* the fourteen copies exist), and a three-way collapse P3 saw and rightly declined because its three files were owned by three packages that day. **The operational lesson, since it cost real time: a fresh git worktree has no build cache and would rebuild Mathlib from source — hours, per worktree.** Symlink `.lake/packages`, copy `.lake/build` (19 s, and it is accepted across directories — measured), never share `.lake/build`, serialize every real build behind one lock, and iterate with `lake env lean` (3 s, builds nothing) rather than `scripts/build.sh` (3½ minutes even when nothing changed). **M62 (FS-6) keeps rank 1; the live work is ranks 2–3.** The fourth amendment follows.)*

*(**Amended 2026-09-09 (fourth amendment) — CONSOLIDATION, Kooshi's direction: *"let's not focus on pushing to
6 right now, I want to secure our current position. Explain the unexplained with proofs, generalize our specific
proofs, general bookkeeping."*** Four audits ran the same day — the Lean sources, the measured-but-underived
record, the grokkings' epistemic labels, and the repository's internal consistency — and produced **three new
stubs at ranks 2, 3, 4** plus **nine corrections applied in place**. **FS-25**
(`plans/STUB-explain-the-unexplained.md`) holds six measurements that are theorems, led by **E1: every finite
Euclidean plane is forced-pair-free at EVERY prime and every colour count**, where the record has four tables —
which matters because G48's tightness mechanism takes exactly that as a hypothesis, so today it fires only where
somebody has solved a plane. **FS-24** (`plans/STUB-generalize-the-kernel.md`) holds seven theorems narrower
than their own proofs, led by **G1: `transport_pair` is stated over `ℂ` where its four-line proof needs only
"an isometry exists" — and over `K²` the isometry group is not transitive, so the current form cannot even be
*stated* by the `√3`-carrier work that is blocked on it**. **FS-26**
(`plans/STUB-vacuity-and-record-integrity.md`) runs the vacuity rule backwards over the 725 declarations that
predate it; its sharp finding is that **`Forces` and `Separated` are both vacuously true on a graph that refuses
`k` colours**, and that M45 already made the detector a value. **The corrections, all in place:** G1's *"the
5-forcers need √5 and √7"* is false and this file refuted it twice already; G1's *"kernel pending"* was stale by
a day; G34 carried a superseded number under an `[exact]` stamp; G11 had no status label; G16 cited the vacuous
plane corollaries; `[Krebs2022]`'s row contradicted itself; three duplicate bibliography keys; three
citation-format slips; and `plans/ROADMAP.md` is bannered **superseded** — the live board is this section plus
`plans/FRONTIER-STUBS.md`. **G30 gains a sixth failure mode**: a correct instance recorded where a theorem was
available. **M62 (FS-6) keeps rank 1 as the hunt's own milestone; the live work is ranks 2–4.** The third
amendment follows.)*

*(**Amended 2026-09-09 (third amendment), Kooshi's choice of next work: "continue reading unread papers and
solidifying our knowledge web within the prior art, and potentially updating our vocabulary to match theirs where
it makes sense."** Minted and ranked as **FS-23 at rank 3**, `plans/STUB-prior-art-web.md`, which is also the
session handoff: three short reading debts named exactly, a §C sweep, verification of every load-bearing
attribution **against the source PDF** (the FS-20 repair did four of Madore's and one of Moorhouse's on
2026-09-09 and they held), the six lineages' citation graph *including the edges that do not exist*, and the
vocabulary decision. **On vocabulary the stub's recommendation is a translation table plus adoption in new
writing, NOT a global rename** — the coinages are cross-referenced across this file and ~90 plan files, and
renaming would rewrite the record of what we believed when, which the house rules forbid. Two concrete finds
already: `[Parts2020a]` §2 **rejects "virtual edge" in print** in favour of *mono-pair / non-mono-pair* (a term
this project uses in almost every milestone), and `[Aggarwal2025]` calls our direction ladder the **"Moser
Lattice"**. Bearing on χ ≥ 6: none directly, and the stub says so; **M62 (FS-6) is untouched at rank 1.** The
second amendment of the day follows.)*

*(**Amended 2026-09-09 (second amendment): `plans/STUB-four-colour-valuation-law.md` is CLOSED — the law is
kernel-checked (ledger row 59), Parts's seven distances are each barred from the wrong column, and the stub's
companion duality is retracted because `core9_plane`/`core122_plane` are vacuous. What it leaves open, stubbed in
the same file with its proof sketch and priced at a day: **the `√3` carrier re-stated over `K`**, which would give
"no virtual edge at √3 over K" and, with the law's half, make `√3` carry no compulsion of either kind over `K`.
Unranked. The first amendment of the day follows.)*

*(**Amended 2026-09-09, the mascot challenge:** two new stubs are minted and unranked —
**`plans/STUB-four-colour-valuation-law.md`** (the 2-adic law governing which distances can carry a four-colour
compulsion over `K`; it explains `[Parts2020a]`'s computer-found Table 1 completely and our own M53 dial, and is
the arithmetic half of anything FS-20 says about compulsions; an afternoon to kernel-check) and
**`plans/STUB-sqrt7-phase-pinning.md`** (Coxeter's line: `[Parts2020hv]` uses `√5` at exactly one step, to pin
phases; the Moser twist does the same job natively in `K`, which would land the object in `ℚ(√3,√7,√11)` — the
only 6-open field among the mascot candidates, and our own §8 item 2). **FS-20's flagged repair is DONE (2026-09-09)** — its "verified open" check had characterised
`[ExooIsmailescu2019]` by its abstract while the paper sat on our own shelf asking the question three lines above
its Madore citation. The check is re-run and recorded in `plans/STUB-theorem-B-writeup.md` §1: all four Madore
citations opened (the fourth identified as `[Aggarwal2025]`, which names our exact field and independently uses
Theorem A's norm-one-is-a-unit hinge), the citations of the paper that POSED the question walked for the first
time (47 works, none answers it), a second citation database cross-checked (they disagreed fourfold), and no
claim anywhere contradicting `χ(K²) = 4`. **The conclusion survives on better evidence and the thesis is
stronger: the question has been posed or named six times across fifty years in four literatures.**)*

*(**The frontier set is `plans/FRONTIER-STUBS.md`** (created 2026-09-06 at the M56 close on Kooshi's direction): every
next milestone as a full stub, ranked, each with its bearing on χ ≥ 6 stated honestly; re-ranked at every close
(WORKFLOW step 9). **RE-RANKED AT THE FS-18 CLOSE, 2026-09-08 (the second re-rank of the day): FS-18 is
CLOSED — the library was read — and **FS-20, THE PAPER, enters at rank 2 — and it is a unification, not one exact value.** The library read found that
**the same reduction has been derived independently six times in five decades, by six groups in four literatures that do
not cite one another**, all turning on one condition (anisotropy of `x²+y²` at the prime) and all stopping in the same
place — `[Madore2015]`'s Prop. 3.9 needs a subgroup that is not a ring and says *"which the author has not found the
courage to try to formulate under the most general auspices"*, which is Theorem A. On top of it, `χ(ℚ(√3,√11)²) = 4`
closes his eleven-year-old `4 ≤ χ ≤ 5`, verified open on 2026-09-08 by a direct search of the claim (`plans/STUB-theorem-B-writeup.md`; its bearing on χ ≥ 6 is none and the stub says so — it is
ranked on the trigger, not on the hunt, and it does not compete with M62 for anything but attention). The rest of
the table is now rank 1 FS-6 (the design target in a SEALED
field, unchanged and already chosen by Kooshi as M62), rank 3 FS-19 (also new — the number-field analogue of
`[Chow1993]`'s complete classification of forbidden distance sets, `v_𝔭(d²)` for his two-index; a derivation
whose machinery is already in the kernel, `plans/STUB-padic-distance-classification.md`), then FS-16, FS-13
(now carrying the acquisition of `[Krebs2022]`, whose `χ > ω` criterion is the most wanted page in the
literature for this project), FS-17, FS-12, FS-2, FS-8, FS-4, FS-9, FS-10, FS-5. The cell family (M37–M43) is
struck as a source of novelty: `[SokolovVoronov2025]`'s `χ_poly(ℝ²) = 7` subsumes its `≥ 7` floor at every
scale. The pre-close text follows for the record. — RE-RANKED 2026-09-08 on Kooshi's override of the backlog plan, after the prior-art correction (G49): rank 1 was FS-18, READ THE LIBRARY** (`plans/STUB-library-read.md`) — everything held and
unread, plus the newly named works, in one pass. The argument is the correction itself: four milestones
reconstructed a 2010 draft that was one search away, `[CervantesKrebs2023]` sat unread in our own bibliography
for two days while M61 hand-derived a special case of it, `[Krebs2022]` determines the clique numbers this
project decides one prime at a time, and `[Soifer2024]` — the survey whose number-field chapter would have
settled the whole question — has been on the shelf unread since 2026-09-06. **This is the cheapest move on the
board and it is a prerequisite, not a detour**: every stub below is ranked on an assessment of what is known,
and that assessment is now measured to be wrong. FS-6 (the design target in a sealed field) keeps its content
and its rank behind it. The M61 ranking follows for the record. **Re-ranked at the M61 close, 2026-09-08:** FS-15 CLOSED as M61 on its derivation (the mechanism of tightness: the spindle over a forced pair
adjoins `√(4d² − 1) ≡ √−1 (mod 𝔭)` and removes the sealing prime; the 6-level reduces to a 5-rigid pair over a 5-sealed field at `11 ∣ d²`);
its phase A (the first digit) undecided and re-minted as **FS-17, the first digit at 23** (`plans/STUB-first-digit-23.md`: the half-turn
family, cube-and-conquer over the origin's four hexagons priced at ~2.5·10⁸ cubes after symmetry, the α refutation). The table's top: **rank 1
FS-6 on the 6-open fields, re-aimed by G48** — the design target is a pair forced equal at five colours over a 5-SEALED field (Heule's,
K(√247), K(√23)) at a distance with `11 ∣ d²`, whose spindle is then a 6-forcer in a field 6-open by construction; rank 2 FS-16 (the
residue-allowed distances, now with the forced-equal side `11 ∣ d²` beside the virtual-edge side `d² ≡ 1`); rank 3 FS-13; rank 4 FS-17;
rank 5 FS-12; then FS-2, FS-8, FS-4, FS-9, FS-10, FS-5. Kooshi picks. The M60 text follows for the record.
**Re-ranked at the M60 close, 2026-09-07:** FS-14 CLOSED as M60 (the compulsion face of sealing: the sealing plane
has no pair compulsion, so over a sealed field a forced pair has `d² ≡ 0` and a virtual edge `d² ≡ 1`; each hex-shell gadget impossible
separately). The table's top: **rank 1 FS-15, the local–global tightness conjecture** (`plans/M61-local-global-tightness.md` — its
compulsion face now proved; first digit: is any finite plane exactly 6-chromatic); rank 2 FS-6; rank 3 FS-12; rank 4 FS-13; **rank 5
FS-16, the residue-allowed distances** (`plans/STUB-residue-allowed-distances.md` — why M55's theorem-admitted candidates concentrate at
residue norm 1, and the 51 undecided asks there); then FS-2, FS-8, FS-4, FS-9, FS-10, FS-5. Kooshi picks. **Amended 2026-09-07 (Kooshi: document the rule, mint the conjecture):** G46 holds the rule the two finite-plane milestones taught
(recognize the classical theory first; the search only produces its instances) and its ranking corollary; **FS-15, the local–global
tightness conjecture** (`plans/M61-local-global-tightness.md` — χ(F²) equals its best local bound; first digit: is any finite plane
exactly 6-chromatic; bold form: χ(ℝ²) = 7) enters at rank 2, the conjecture whose compulsion-level face FS-14 is. The order: FS-14,
FS-15, FS-6, FS-12, FS-13, FS-2, FS-8, FS-4, FS-9, FS-10, FS-5. **Re-ranked at the M59 close, 2026-09-06:** FS-11 CLOSED as M59 (the lift is first-order rigidity; a finite-plane subgraph lifts only if it
is a shadow; the 1581 recovered from its residues, its merged image obstructed in the kernel; the hub scan). The table's top, under the
programme's rule (derivations first): **rank 1 FS-14, the five-colour residue obstruction at 11** (`plans/M60-five-colour-residue-obstruction.md`
— over a 5-sealed field every pulled-back 5-colouring is constant on residue classes, so a pair compulsion at five colours has its
residues in the finite sets F₁₁ / S₁₁ every 5-colouring of UD(𝔽₁₁,2) identifies / separates: the 5-colour analogue of T17, the programme's
named next derivation); rank 2 FS-6 on the 6-open fields, now with the hub scan as its enumerator; rank 3 FS-12 (the hub scan as the
design instrument); rank 4 FS-13 (the finite planes' 6-critical cores, for autopsy); then FS-2, FS-8, FS-4, FS-9, FS-10, FS-5. Kooshi picks.
**Re-ranked at the M58 close, 2026-09-06:** FS-7 CLOSED as M58 (the field-selection instrument the hunt now consults
first: a field over K is 6-open iff its 2-adic wall is broken and 11 is inert; the finite planes refuse five from 59 up by their spectra;
χ(UD(𝔽₁₁,2)) = 5 in the kernel). The table's top: **rank 1 FS-11, lift a 6-critical subgraph of UD(𝔽₁₃₁,2) into de Grey's field**
(`plans/M59-finite-plane-lift.md`, opened as M59 — the constructive face of the pivot, the one route it opens that could PRODUCE a 6-object; the
local 𝔭-adic lift test first); rank 2 FS-6 on the 6-open fields (de Grey's, K(√7), K(√13), K(√79), K(√127)); rank 3 FS-2; rank 4 FS-8
(one `map` row once Haugland's field is known); FS-4; FS-9; FS-10; FS-5. The 23/31/43/47 planes and the 1581's shadow at 131 at five
colours were in flight at the close (`build/m58/`); their records go into `data/fplane/` as `chi-p<P>-k5.json` / `shadow-degrey1581-p131.json`
(re-run with `fplane.py chi --p P --k 5 --pin-clique` / `shadow --degrey --p 131 --k 5` if lost). Kooshi picks. The pivot text follows for the record.
**Re-ranked at the finite-plane pivot, 2026-09-06, after the M57 close (Kooshi: stubs for all, then the
field sieve):** rank 1 FS-7 the field sieve (`plans/M58-field-sieve.md`, opening as M58 — which fields can host a 6-forcer;
the exact wall-broken planes; the kernel certificate of χ(UD(𝔽₁₁,2)) = 5 through the certified Heule-510); rank 2 FS-6 on de
Grey's field only; rank 3 FS-2 re-aimed with its scope note; rank 4 FS-8 the Haugland 7-adic check (new); rank 5 FS-4; ranks
6–7 FS-9 topological lower bounds and FS-10 Nullstellensatz certificates (the two rooms the analysis named, stubbed, not
scheduled); FS-5; FS-3 DEMOTED (K(√247) is 5-sealed). FS-7 also carries the SHADOW sieve (an object's direction residues
seal every graph built from its directions — the 1581's 55 of 66 at 131). The M57-close text follows for the record. **Re-ranked at the M57 close, 2026-09-06:** FS-1 is CLOSED as M57 (the principle is exact and, on every
object we hold, without purchase); the table's top is now FS-2 the Kempe classes, re-aimed by G42 (b) at what carries
forcing when the family does not — the 252-cheat object and K-fabric's 16-pair residue; FS-3 thickened material, with
the additive pre-filter it planned now VACUOUS on F₂₄₇ (no ℤ/5-hom on the thickened stage) and its bearing unchanged;
FS-6 (new) the family-keeping thickening — a field and construction that add directions without 5-divisibility; de Grey's
half-spindle closure is one (its whole gen-1 closure keeps ≥ 300 homs); FS-4 Theorem B in the kernel; FS-5 bookkeeping.)*

*(**M57 CLOSED 2026-09-06 — additive rigidity; `plans/M57-additive-rigidity.md` §R.** The ranking after M57:

1. **FS-2, the Kempe classes, re-aimed (rank 1).** M57 showed forcing without rigidity (the 252-object: > 5,000
   colourings, one additive) and Kempe-openness everywhere; the question is now what the reconfiguration graph of a
   FORCING object looks like — how many components, whether the forced pair is constant on each, and whether K-fabric's
   4-rigidity residue (16 pairs) and the 252-object's forcing are carried by the same mechanism. The instruments
   (`closure`, `rigid`, M56's `kempe`) are in hand; the 252-object's 5,000 colourings are on disk.
2. **FS-6, a family-keeping thickening (new stub).** The principle bites only where directions can be added without
   the joint lattice becoming 5-divisible. The de Grey gen-1 closure's dial read at the close: the family SURVIVES the whole closure
   (≥ 300 homs at 24,065 points, no unit in 5Λ) — so the half-spindle words are a family-keeping generator, and FS-6's
   phase B (grow, read γ̄ per step) runs on de Grey's field first; Heule's field (the 510 keeps 96) is the second. If no such thickening
   exists in any owned field, the principle is closed at five colours as a design route.
3. **FS-3, thickened material** — unchanged in bearing; its D2 (the additive pre-filter) is vacuous on F₂₄₇ and is
   struck; the 108 asks are still running at the close (`build/m55/ask-depth2.log`).
4. **FS-4, FS-5** — unchanged.

The M56 ranking below is kept for the record.)*

*(**M56 CLOSED 2026-09-06 — the arithmetic of tightness; `plans/M56-arithmetic-of-tightness.md` §R.** The
additive yardstick is built, calibrated on the bed and read on every witness; the seed's tightness is arithmetic,
K-fabric's is additive at two depths of three, the witnesses' is not. **The ranking after M56:**

1. **The Kempe classes of K-fabric's 4-colourings** — the 16-pair residue (§R1): walk the Kempe graph from the
   eight additive colourings of U (are the dial's separators for those 16 pairs two swaps away, and is every
   4-colouring of U Kempe-equivalent to an additive one?); if yes, K-fabric's 4-rigidity is a finite lattice
   computation, and the same walk at five colours on the seed decides whether its 17 non-additive colourings are
   Kempe-images of the 18 (an afternoon; G41 (b)).
2. **The additive richness dial on the witnesses' fields** — grow hexagonal-fabric chunks of Heule's field and
   F₂₄₇ and watch the ℤ/5-homs die (1/5 ∈ Σ₀ says they must): the first chunk of each field with no additive
   5-colouring, and the additive family's size along the way — the field-as-input number the stub asked for,
   measured rather than inferred (G41 (c)).
3. **The seed as the design template** — Exoo–Ismailescu's G is 5-tight and its colouring space is its additive
   family; the derivation first: which lattice property makes every colouring of a chunk additive (G's 205 points
   have it at five colours, U's 1,953 do not at four), and whether a UNIT-distance chunk in a wall-broken field can
   have it — that would be 5-tightness by arithmetic, the milestone's own reading of "how tight can a field be made".
4. **Thickened material** (M55's item 1), **the ν = m law** (T25), **Theorem B in the kernel**, **the plane instance
   of `extends_of_hubs`** — unchanged.

The M55 ranking below is kept for the record.)*

*(M55 CLOSED 2026-09-06 — absorption; `plans/M55-absorption.md` §R0–§R5. The paths-forward entry M54
wrote ("many spindles at many centres over one fabric so that no large sub-piece is 4-colourable") is now
a theorem's corollary in the negative: every copy hangs by its fused centre and ONE chord, the base extends,
ν = the number of spindles at most, and no compulsion among the fabric's vertices at any number of spindles.
**The ranking after M55, from what the theorem admits and what the censuses moved:**

1. **Thickened material, not star-shaped.** The absorption theorem needs a 4-colourable piece attached by a
   hub and a matching; the F₂₄₇ cross thickening of the witness (M55 §R4) is neither a star nor absorbable,
   and it is the only construction that MOVED the redundancy dial (238 critical vertices freed at one
   depth, on one side). Grow it until the critical set is empty on a thickened object — deeper cross
   lattice, or the K-partner thickening of both cosets (the full-pool grown stage's census, in flight at
   the close, reads 1 critical vertex in 389 and that one is the fused centre) — then sweep: the first
   object where neither theorem applies and ν could exceed 2 by structure rather than by count. T24 first
   (why only the copy side frees), by derivation.
2. **The ν = number-of-spindles law as a theorem**, and ν's exact engine: pairwise-disjoint forcing-critical
   sets plus one-chord attachment should give ν = m outright (an afternoon's derivation); the hitting-set
   engine is untested beyond its controls, the cardinality ladder is unfit above ~2,000 points.
3. **The kernel formalization of Theorem B** (`plans/STUB-field-wall-kernel.md`) — unchanged.
4. **The plane instance of `extends_of_hubs`** — a `Copy.copyUnion` shown to satisfy the hypotheses from
   census data, the certificate shape for "this union carries no compulsion"; and the dial as the
   descent's regression monitor (every committed object has C = ∅ by theorem) — unchanged.

The M54 ranking below is kept for the record.)*

*(M54 CLOSED 2026-09-06 — the five-colour dial; `plans/M54-five-colour-dial.md` §R0–§R8. The critical-set
localization theorem is in the kernel and every reading obeyed it; two 5-chromatic unit-distance graphs with
NO critical vertex now exist here (5,857 and 2,229 points) and the smaller one reads pairwise floppy at five
colours, complete, in 31 seconds. **The ranking after M54, derived from what the sweep could not do:**

1. **Material with no spare colour on any thinly attached piece.** The two obstructions are now both
   theorems-with-measurements: a compulsion at five colours needs (a) no critical vertex outside the
   pair's glue points (M54's theorem — cleared by two spindles on redundant fabric) and (b) no
   4-colourable piece attached by outside-degree-one chords (the absorption principle, D2, measured at
   one point). (b) names the construction: bases whose 5-chromaticity is carried densely — many
   spindles at many centres over ONE fabric (every pair of the 163 forced pairs with disjoint
   forcing-critical sets is a generator, and the forcing censuses cost 3 s per vertex), so that no
   large sub-piece is 4-colourable; and the cross pool (§R1: the K-lattice's shadow, 20 fusions, a
   53-point component) grown one depth further into F₂₄₇ so that copy-side points acquire
   outside-degree ≥ 2 into rigid pieces. The census-then-candidates pipeline (`tools/five_dial.py`)
   reads each such object at one 4-colour ask per vertex before any sweep.
2. **The kernel formalization of Theorem B** (`plans/STUB-field-wall-kernel.md`) — unchanged, and now
   with Fischer 1990 as the attribution frame (T23): the additive framework and the quadratic planes
   are his; the biquadratic exact 4 and the local criterion are ours.
3. **The anatomy of the F₂₄₇ cross lattice** (§R1) — the half-angle rotation ρ^{1/2} = (√247 + 3i)/16 and
   the K-lattice's shadow; a tangent with a derivation waiting, cheap.
4. **The dial as the descent's monitor**: every committed object's critical set is EMPTY by theorem
   (it forces a pair five apart), so a critical vertex on a committed object is a bug — a free
   regression control for Track A.

The M53-halt ranking below is kept for the record.)*

*(M53 HALTED 2026-09-05 at phase D — the field-wall conjecture is a theorem (`plans/FIELD-WALL-THEOREM.md`,
canonical copy `~/field-wall-conjecture.md`). **The new plan, written the same day by the session holding
the proof, after deriving the residue obstruction (T17) and measuring the wall-breaking material (T18):**

1. **The wall-breaking replay** — export the depth-one pool restricted to the 2-adic breakers (the
   √5-class, ~8,000 points) and to the partner classes (the one-prime classes in complementary pairs),
   and replay the two-cheat stage's 3,936 in-field survivors against them (`descent replay`, the
   `pdeg12` recipe). This is the first ask the theory cannot answer: the survivors are not residue-type
   (T17), so nothing says wall-breaking points kill them either; the reading is the endgame's first
   cost number. Zero kills would say the endgame needs copy-grade width (M52's Q8 unions), not points.
2. **The in-field loop, continued only as in-context reduction** — provably non-terminating, floor ≥ 3,
   currently 149 with eight odd components; each batch admissible iff Σ(standing ∖ B) is UNSAT (a
   millisecond check, `tools/residue_floor.py`). Worth running only if item 1 shows the endgame's cost
   scales with the standing count.
3. **The kernel formalization of Theorem B** — `plans/STUB-field-wall-kernel.md`, an elementary route
   through the order ℤ[ζ₁₂, (1+√33)/2], its prime (1 − i, T), and the DVR characterisation; 600–900
   lines, no compute; the repository's own standard for a proof that stopped a campaign.
4. **The rigidity dial (Q10)** and the next-field questions (`plans/FIELD-WALL-THEOREM.md` §8: is
   Heule's plane ℚ(√3, √5, √11)² exactly 5-chromatic; √7 without √5; the triangle-free quadratic
   planes ℚ(√d), d ≡ 7 mod 8) — research, derivation-first.

`plans/M53-iteration-5.md` §R5 lists what M53 left resumable; the ranked list below it is the pre-halt
ranking, kept for the record.)*

*The live two-track board — the iterations and the tangents, how they interleave, and the next seven
days — is `plans/ROADMAP.md` (created 2026-09-01). **The standing risk register — what could stop the
descent, each with its monitor — is `plans/RISKS.md` (created 2026-09-03), re-read at every close.** This section stays the ranked milestone list,
rewritten at every close; the board is updated the day anything lands.*

*Rewritten 2026-08-09 at the field-jump decision. The construction ladder
(M24 pair → M25 four-ladder → M26 hexagram, all χ = 4 exactly) closed the
seam-field arc, and the closing observation reframed the hunt: the Moser
spindle's twist rotation is ρ = ζ₆³·σ⁻² — INSIDE the seam group — so the
classical 4-forcers are native to ⟨ζ₆, σ⟩, while the only known 5-forcers
(de Grey 1581, Heule 553/510, all kernel-certified in this repository) live in
ℚ(√3, √5, √7, √11), a field the seam lattice cannot reach. **The 5-wall is a
field wall, and the programme jumps fields**, carrying the proven method
(script-verified design → master-identity engine → kernel-checked exactness).
Every future milestone is maintained as a detailed pre-subplan stub in
`plans/` (the stub rule, WORKFLOW § Plan) — read the stubs, they carry the
full context.*

*(M30 CLOSED 2026-08-09; M31 CLOSED 2026-08-10; M32 CLOSED 2026-08-10 —
the probe phase fired its FLAT clause exactly as registered and the Lean
ascent landed the kill engine kernel-checked. RE-RANKED the same day, on
Kooshi's direction at the close: "I want to be able to confidently point to
the reason why 5 colorings are forced." M33 is the MECHANISM HUNT; the
certification programme is the standing fallback.)*

*(M35 CLOSED 2026-08-11 — both phases returned honest verdicts: no k = 5
class compulsion exists on today's objects, and the upper-bound machine is
built with χ ≤ 9 as its first certified instance. The ranking below is the
close's recommendation; Kooshi picks.)*

*(M36 CLOSED 2026-08-11 — χ(ℝ²) ≤ 7 landed in the kernel, and NOT by the
route the stub registered: the hexagon module was superseded before it was
written by a one-comparison sharpening of M35's own brick certificate. The
classical interval 5 ≤ χ(ℝ²) ≤ 7 is now kernel-checked at both ends. G20 is
demoted with its refutation recorded; G21 is minted. The ranking below is the
close's recommendation; Kooshi picks.)*

*(M37 CLOSED 2026-08-12, under the autonomy authorization — the coset
chromatic number of the plane is exactly seven, so no lattice colouring can
witness χ ≤ 6; G22 minted.)*

*(M40 CLOSED 2026-08-12, on Kooshi's "look for anything suspiciously organized" and
his go for subplanning + implementation. The re-rank below reflects his stated aim —
back into the push to 6, from either direction — with M41 stubbed at his direction.)*

*(M41 CLOSED 2026-08-12, same day it was subplanned — laptop, all cores. The
harvest is ledger row 38 / G26 / G27; every registered probe answered, jackpot
never fired, flat clause banked. The alternation now points above.)*

*(M42 CLOSED 2026-08-12, the same day again — laptop. The gap atlas's four
headline pieces are kernel theorems: ledger row 39; G24 promoted in its
forcing half. The certificate template for any fine-tail refutation is now
built and measured — an LRAT chain at any k, minutes end to end — which is
exactly what path 1 consumes.)*

*(M43 CLOSED 2026-08-12, the same day again — laptop, 12 cores. The 1/7 flanks are
χ = 7 exactly, the fine tail is floored ≥ 7 wherever a verdict landed, the forcing is
measured NOT to factor (G28 minted, G26 demoted to its objects), and the literature
check found the from-above direction closed by a proven theorem. **The from-above route
is finished as a source of new mathematics** — that is the ranking's headline, and the
alternation now points, without a counterweight, below.)*

*(RE-RANKED 2026-08-13, on Kooshi's "go over everything; what pattern caused it; what path
haven't we considered" — no milestone closed, no result landed, and the Frontier's
state-of-the-art narrative and ledger above are UNCHANGED. What changed is the reading of
what we already hold. **M43 retired the cell family after evaluating it as a DOOR (can a
six-colouring walk through? no, provably not). It is also a DIAL, and nobody turned it.**
A colouring constant on cells of scale p forbids not the single distance 1 but a closed
INTERVAL around 1 whose width shrinks with p — M43's own bridge to Voronov — so the family
is a one-parameter deformation whose far end is the classical seven-colouring and whose
LIMIT, as the cells shrink to points and the constancy constraint evaporates, is the
unit-distance problem itself. The answer is seven at every setting of the dial; it may be
five or six only exactly at the limit. That reframes the open problem as a discontinuity at
the endpoint of a function known constant on the whole open ray, and it comes with a
derivable bridge and a measurable quantity — G29, minted below. Kooshi's standing correction
to the methodological entry is folded into G30: measurement is where the patterns come from;
the failure mode is promoting an inductive reading, not making the measurement.)*

*(M44 CLOSED 2026-08-13 — desktop. The limit lemma is kernel-checked (ledger row 41), G29 is
promoted in its lemma half, and the dial's first turn produced a NEGATIVE that the framing made
askable: the cell family cannot supply a bounded-size family either, because its witnesses'
defect and size are locked to one parameter and pull opposite ways. **The family is closed in
both directions now** — no six-colouring (M43) and no seven-forcing witness (M44). Four of six
registered predictions met, two missed and reported as missed. The ranking below is re-ordered
on that close; M45 goes to the front.)*

*(M45 LANDED ITS DECISIVE PART 2026-08-13 — desktop, same day as M44. The arity floor is
kernel-checked (ledger row 42) and the campaign refuted G28's pair-mediated half **on the stage that
produced it**, with M43's own six asks reproducing exactly beside seven triple-encoded compulsions
the six never reached. G21 gains its second instance and its general form: a sweep's negative is a
statement about its enumeration. Three of the milestone's phases are NOT run and are listed as
path 2.)*

*(RANKING CORRECTED 2026-08-14, before any work began on it, by verifying a claim rather than
inheriting it. The first version of this re-rank asserted that the from-below hunt carried M43's
too-few-questions shape — that M41 had answered the χ ≥ 6 gadget question with "40 targeted asks".
**That was wrong.** M41's pair sweeps on de Grey's 1581 and on all twelve composed objects were
`status: done` with `unsettled: []` on both sides — the `Rigidity` lattice does not sample, it draws
colourings until every pair has been seen both ways and settles the survivors in one batch query —
so those zeros are COMPLETE over every pair (1,248,990 on the 1581 alone, including all 3,216 √3
pairs and 1,092 distance-2 pairs, counted 2026-08-14). The forty asks were only M41's **gen-2
closure** probe. M45's correction does not reach the from-below direction, and saying so is worth
more than the sharper story. What survives as genuinely unasked is different and is what path 1 now
is: the ARITY, one field up.)*

*(M48 CLOSED 2026-08-15 — desktop, interrupted once by the machine's hardware fault and finished
after a reboot. The arity question is ANSWERED: `arityFloor(1581, k = 5) ∈ {4, 5}` exactly, by two
complete sweeps (ledger row 43); G31 is minted, G26's sharpening is promoted to the kernel, and G30
gains a failure mode nobody had named — a registered escape clause that was inductive and provably
false. The re-rank below follows from G31's closed door: existing witnesses have nothing left to
extract at this depth, so the hunt is a CONSTRUCTION problem now, and the ranking puts construction
first for the first time.)*

*(M49 CLOSED 2026-08-17 — desktop, three days, three instruments rebuilt mid-campaign with the
reasons recorded. The dial exists and turns: μ has its kernel ends (spindle theorem, one defect
suffices), a rigorous lower bound instrument, and the first certified descents at five colours —
twelve of the seed's twenty-nine provably-essential distance-2 edges replaced by seventeen seam-field
points, the mechanism a coverage compulsion at a point outside the object. The seventeen survivors
refuse every one-generation pool in both fields. The re-rank below follows from that: the descent is
now the from-below instrument, and its next turn is registered.)*

*(M50 CLOSED 2026-08-24 — desktop, three days, six engine swaps and three control-caught
incidents recorded. The batch loop works and COMPOUNDS: ledger row 45, G33 minted; the pre-M51
modeling ran twice (§Sʹ–§Sʹʹʹ, then §Sⁱᵛ+§Sⁱᵛ-adv at full depth with a decorrelated adversarial
agent). The ranking below is the close's recommendation — the core probe CHANGED the landscape
after §Sʹʹʹ's adoption, so the fork is presented explicitly; Kooshi picks.)*

*(M51 DEFERRED 2026-09-02 at its iteration-4 commit (object 1,981 points / 273 cheats, the dial
446 → 273), and **M52 MINTED** — numbered as minted, not as mapped: `plans/M52-copy-lock-objects.md`.
The reason is a phase change the loop threw off: Kooshi's duplicate-and-detune construction (Q8)
turned the descended object into a **family of new 5-chromatic unit-distance graphs** (the unit
part plus one ρ₁₅ copy about almost any of its vertices; `plans/Q8-FIVE-CHROMATIC-OBJECTS.md`),
and no cull of any of them has finished. M52 studies the family until its geometry is named,
culls by enumeration, shrinks the strongest object, and closes at the decision; the milestone
after it is iteration 5 from that object or the pivot the study earns. The former "M52"
(nominated gadgets) is the unnumbered `plans/STUB-nominated-gadgets.md`.)*

*(M52 CLOSED 2026-09-04 — desktop, two days. The study answered both of its questions exactly
(T13–T15; the compositions are witnesses, not descent material) and the cull landed as the third
descent move: 273 → 149 on the plain iteration-4 object, one-hot certified, 3-bit pending; WO-14
delivered the Rust culler the same day. The close's recommendation is **M53 — iteration 5 from the
culled plain object** (`plans/M53-iteration-5.md`), opening with the out-of-field kill census
(`plans/RISKS.md` R1) and, if it reads zero, Kooshi's in-field pool; the competing candidate is the
certificate of the copy-lock core (`plans/STUB-certify-core883.md`, repriced to M06-class by T14).
Kooshi picks.)*

1. **M51 — the descent's iteration 3+ (the compounding loop, continued) — DEFERRED 2026-09-02 at its iteration-4 commit; resumes as the milestone after M52 if M52's decision is iteration 5**
   (`plans/M51-descent-engine.md`, full stub with the SPEED MANDATE and the measured per-phase
   cost anatomy — Kooshi's direction 2026-08-24; the durable theory ledger is
   `plans/STANDING-QUESTIONS.md`) — **RECOMMENDED, and CHOSEN by Kooshi at the close ("I agree,
   it's a worthy approach")**:
   the core probe measured that growth alone re-opens every refuser (five falls, six at zero
   provable survivors), the it-3 substrate is already priced (394,604-point pool, 1.2 GB, built
   in 15 min; floor 17; |S| enumerable by the seed-projection engine), and P7's miss by three
   flips in the first commit. Phases: iteration 3 at depth 1 (likely removes most of the floor),
   the width-stalls to restricted depth 2 (the 87–267-point-gadget cost regime, measured at M49),
   the χ(unit-part) phase monitor per commit (the 4 → 5 crossing MINTS a new 5-chromatic
   unit-distance witness — an intermediate certified deliverable before any 6-result), and the
   per-iteration weighted-ladder scan (the polarization table as a standing column). Jackpot
   clause verbatim: any μ ≤ 1 at five colours is HALT AND VERIFY.
2. **The nominated-pairs gadget question — unnumbered stub, formerly mapped as M52** (`plans/STUB-nominated-gadgets.md`, full stub;
   §Sʹʹʹ's adopted question, now the STALL-RESPONSE plan): minimal in-context forced-distinct gadgets for the (4,A)-class at 2 and the √3/√7
   cross-pairs, the in-context→context-free gradient measured by the diet meter (prototyped:
   supports 166/176/191 of 417, common core 78 — broad, so context-free is a long march), with
   the ~148 absolute virtual edges and 412 pigeonhole triangles as the calibration corpus.
   Kernel openers, cheap and milestone-independent: the **spare-colour lemma** (an afternoon;
   the gadget hunt's hard floor), the field-agnostic **compactness bridge** (40–80 lines), the
   **absorbing lemma** (one-liner), the **entropy floor** (generator screen). The registered
   Parts-{1,φ} skewscan replication runs before the nominated-distances reading may inform any
   design.
3. **The from-below gadget hunt** (`plans/M44-from-below-gadget.md`) — the standing frame, and
   promoted to the top on M48's strength rather than by default. It is still the only route to
   χ(ℝ²) ≥ 6, and it is now the route with the sharpest possible target, because two things landed
   together. **The target is a conjunction, kernel-side**: `six_le_chromaticNumber_plane_of_forced_
   pairs` needs a finite unit-distance graph forcing a √3-pair apart at five colours **and** one
   forcing a distance-2 pair apart — with two adversarial 5-colourings proving neither half suffices
   alone. **And the extraction route is closed**: G31 says a certified 5-chromatic witness's
   compulsion structure at its top rung is *exactly* the trivial degree-forced fan, with nothing
   below arity 4, so no gadget is hiding in de Grey's graph to be found by a sharper meter. What
   remains is design. Assets it did not have before: the plane's homogeneity as a theorem (one
   forced pair at a distance is every pair at that distance — the bridge any gadget crosses), the
   ladder theorem (a compulsion survives enrichment, so a gadget may be designed small and grown),
   M44's defect meter (a *continuous* score for "how close is this to a unit-distance graph", with
   an independent re-checker), and M48's mask engine (billions of pattern questions at bit-operation
   cost, so a designed object can be audited at every arity ≤ 4 in minutes).
3. **M45's unrun phases** (`plans/M45-arity-floor.md` §R7) — the exhaustive arity ladder on the
   kernel-certified 23-vertex core, the randomized-order re-shrink that decides whether orbit
   concentration is real or procedural, and double-encoding the remaining 44 pair compulsions.
   **The fan-shrink upper bracket is now PARTLY DELIVERED** — M48's neighbourhood sweep proves the
   degree-constructed arity-5 compulsions on the 1581 are 1-minimal — so what is left of that item
   is the same bracket on the 23-core, where the object is kernel-certified and the answer would be
   promotable. All cheap, none run.
3. **M46 — the description instrument** (`plans/M46-colouring-automaton.md`) — unchanged.
4. **M47 — the three-distance plane** (`plans/M47-multidistance.md`) — unchanged; blocking
   literature gate first.
5. **The ε-dial's unrun tail** (`plans/M44-epsilon-dial.md` §R8) — the ladder below `p ≈ 0.109`
   was NOT run and is reported as not run. Given M44's own finding it cannot change the verdict
   on the family: it would add points to a curve whose slope is established and whose source is
   closed. Low value, explicitly not recommended.
6. **~~M44 — the ε-dial~~ — CLOSED 2026-08-13** (`plans/M44-epsilon-dial.md` §R). Ledger row
   41; G29 promoted in its lemma half. Kept here, not deleted, because the *stub's* prediction
   is worth remembering against the outcome: it read the recorded cores as showing a physical
   radius pinned near 1.3–1.7 and flagged that as an anthology needing a comparability phase.
   The comparability phase ran, with the ball radius derived rather than chosen, and the
   invariance **survived** at 1.02–1.38 across a 3.16× span of scale.
7. **The certified union** (`plans/M35-certified-union.md`) — parked: consolidation with
   bounded novelty; reopens on a find or the write-up trigger's "maybe" clause.
8. **The certification programme** — standing fallback unchanged
   (`plans/M33-witness-closure.md`).
9. **The 1/7 core's kernel certificate** — priced and DECLINED at M43 (M06-scale, ~10⁷ LRAT
   lines for a statement conditionally implied by published work). The M42 template stays
   proven and ready for a target that earns it; this is not one. Reopens only if the
   certificate machinery itself becomes the product, or if M46 §4 finds that an automaton
   emptiness certificate is a different and cheaper price.
10. **Carried forward unchanged** — the hexagon cell module stays priced and unneeded (M36
    superseded it before it was written); the instrument audit stays parked. The line an older
    ranking carried — *"the cell family is closed as a research direction: further scales cost
    solver time and cannot produce a six"* — is now **fully vindicated in substance and was
    still wrong in its reasoning**: the family is closed, but M44 showed the second half of the
    closure (no bounded-size family, hence no seven-forcing witness either) was a question
    nobody had asked, and asking it needed the dial framing rather than the door framing.

### The open structural question (minted 2026-08-11, the M34 close discussion)

> **Is a pigeonhole necessary?** Every known χ ≥ 5 argument factors as
> pigeonhole × kill (G15, constructive half now measured) — but must
> EVERY 6-forcer carry a class pigeonhole from an ENUMERABLE family?
> Today's only necessity theorem is A1 (a vertex-critical 6-forcer fires
> the fan class at k = 5 at every vertex — kernel, colour-generic), and
> there the statement is vacuous at the top rung: "no fan-pigeonhole
> anywhere" merely restates the upper bound. The useful form — a SMALL,
> EARLY compulsion from a family a sweep can enumerate, forced on every
> 6-forcer — is open, is exactly G15's universality half, and is the
> missing piece that would turn M35's classification map into a proof
> route for χ(ℝ²) ≤ 5 (which may of course be false — nothing known
> excludes χ = 6 or 7). What would move it: a necessity proof for ANY
> enumerable family below the fan; or a 6-forcer-candidate anatomy
> violating the factorization. The M33 enumeration subtlety stands as a
> warning: the fan compulsion A1 guarantees lives on a circle about a
> DELETED vertex — a class family enumerated over present vertices
> misses it.
4. **The designed-forcer thread — reopened in spirit by the union** (M34
   built the first designed 5-chromatic object — by composition, not by
   stacking; M32's flat verdict on width-without-degree stands).
5. **The forced-symmetry thread** — folded into the mechanism hunt's phase 2
   as its positive control (the 791's forced central symmetry is an
   already-measured class-level compulsion), no longer a separate item.
6. **Parked, with reasons** (banners in each stub): the tiled plane (M27 —
   expected another 4; its periodic-table SAT probe stays registered-but-not-run
   and reopens the milestone only if it REFUSES), the recursion (M28 — gated
   behind M27), the uncountable pair (M29 — compactness reduces it to the finite
   hunt M30+ pursues in the right field; the residual phase-uniform-colouring
   theorem is another 4-result). Also parked as before: the gap-distance gadget
   hunt (clamp-directed), general-radius two-circle colouring, fractional route,
   measurable-≥6, axiom sensitivity, the `opus-larp` re-validation. Write-ups
   and upstreaming: deferred per standing policy — noting the ledger now holds
   a completed trilogy plus the field-wall thesis, which is the strongest
   write-up candidate so far; the trigger stays Kooshi's. **At that trigger,
   adopt the zeta-23 artifact shape (Kooshi, 2026-08-10): a tiny trusted
   `comparator/` surface (ChallengeDeps + Challenge statements with sorry)
   over the whole edifice as untrusted Solution, verified by
   `leanprover/comparator` (statement AST-equivalence + axiom whitelist +
   kernel replay; its optional nanoda run can serve as the deferred
   independent-kernel publication gate).**

## Grokkings — the working theory of the 5th colour

*The Frontier records what is proven and what to try next; this section records
what we UNDERSTAND — the mechanistic picture the results add up to, which is
what we actually build on. Born 2026-08-09 (Kooshi's naming), the night the M30
anatomy and three of his visualizer observations assembled into one picture.
Discipline: every entry carries an epistemic status — **[kernel]** (the kernel
checked it), **[measured]** (tools-side, exact arithmetic or a controlled
instrument, with its address), **[reading]** (an interpretation — believed,
falsifiable, its killing test named). A reading is never silently promoted; a
grokking that dies is demoted with its refutation recorded, never deleted.
Updated whenever understanding moves — the same closing rule as the Frontier.
"All known 5-forcers" below means the three witnesses certified in this
repository (de Grey 1581, Heule 553/510). Unimported and untested: Parts' 509
(arXiv:2010.12665, the vertex-count record), Heule's 529 (arXiv:1907.00929),
Voronov et al.'s 64,513 (2021, Moser-spindle-free), and Haugland's 2,131
(arXiv:2608.04542, 2026-08 — Moser-spindle-free, HEPTAGON-fabric, float+SAT
verified only). The scope clauses below matter because of the last one.*

**The theory in one paragraph.** A 5-forcer, as far as anyone has built one, is
seam-field geometry pushed over a wall by angular detuning: a small vocabulary
of seam shells (~30–44 exact radii, every one in ℚ(√33)) about one or two
rotation centres, angularly organized by words in the half-spindle group
⟨ζ₁₂, σ, √ρ₁₅, √ρ₆₃⟩, with the 5th colour forced by copies detuned 0.6°–3.6°
off exact crystal symmetry — near enough to interlock, far enough to clash.
Its colour rigidity is invisible at the pair level and lives in compelled
patterns of triple order and above. None of this is visible in the brute-force
artifacts; it took exact anatomy plus a human eye on the rendered picture.
**Amended 2026-09-05:** the wall in that sentence is now a THEOREM, and it is
arithmetic, not metric — the seam field K = ℚ(√3, √11) is 4-colourable by a
residue colouring modulo a conjugation-fixed prime of K(i) above 2, and a
detuning rotation forces the 5th colour only if its coordinates leave the
fields where such a prime exists, i.e. only if they make −1 a 2-adic square
(√5, √7: yes; √11, √33, √2, √35: no). "Near enough to interlock, far enough to
clash" was the metric shadow of a 2-adic condition.

* **G1 — The field wall.** The Moser twist is a seam-group word — ρ·σ² = −1,
  ρ = ζ₆³σ⁻² **[kernel: `FieldWall.lean`]** — and the seam group's countable
  closures are exactly 4-chromatic **[kernel: M24–M26]**; ~~the 5-forcers need
  √5 and √7~~ — **CORRECTED 2026-09-09 (FS-24 audit): that sentence is false, and
  this file refutes it twice.** G27 measured that **Heule-510 has no √7 content**
  (it lives in `ℚ(√3,√5,√11)`), so the conjunction was already wrong; and G37's
  own 2026-09-09 correction records a published 5-chromatic graph in
  `ℚ[√3,√11,√247]` (`[ExooIsmailescu2019]`) plus our own 1,175-point witness in
  the same field, **so even the disjunction "√5 or √7" is wrong.** The true
  statement is the one the section preamble already gives: *the 5-forcers need a
  radicand that breaks the 2-adic wall* — an odd square class ≡ 7 (mod 8) — and
  `√5`/`√7` was the three certified witnesses' instantiation of that criterion,
  not the criterion. The 4/5 boundary is a field boundary. *Reading on top: 4 is
  what ⟨ζ₆,σ⟩ can force, and it forces it everywhere; 5 begins one field up.*
* **G1, PROMOTED 2026-09-05 — the field wall is a THEOREM. KERNEL-CHECKED SINCE
  2026-09-08 (`FieldWall4.lean`, zero sorry, standard three axioms:
  `chromaticNumber_seamPlane`, with `not_forces_five_of_subset_seamPlane` and
  `not_separated_five_of_subset_seamPlane` the two corollaries this bullet
  describes in prose); the "kernel pending" this entry carried until 2026-09-09
  was stale, and so was every "hand-proved" in the field-wall pass below.** Theorem B of
  `~/field-wall-conjecture.md`: χ(G(ℚ(√3, √11)²)) = 4 by the residue colouring modulo a conjugation-fixed
  prime of K(i) above 2; the boundary is 2-adic (−1 a square in a completion above 2), ~~which is exactly the
  √5/√7 line G1 drew from the witnesses~~ — **corrected 2026-09-09: it is STRICTLY WEAKER than that line, and the
  difference is a witness this project built (`√247`, G37/T20). The criterion is the boundary; `√5`/`√7` was a
  sample of three.** Checked here on the seed and the it-4 object with zero search
  (`tools/residue_colouring.py`). Corollary for the descent: no K-point unit graph carries a pair compulsion
  at five colours, so the loop must adjoin a wall-breaking root to end — the copy at ρ₁₅ (√15) is that step.
* **G2 — The construction grammar of the picture.** Rings about a point ⟺ that
  point was a rotation centre of the construction (orbits about a centre lie on
  circles about it — invariance, not coincidence). De Grey's two ring-hearts
  are his two spindle centres (the two 24-word fused vertices); Heule's is his
  one. **[measured]** Corollary grammar: mirror-defects = chirality of a
  rotated copy; "mitosis" = a system and its detuned twin.
* **G3 — Radially seam, angularly detuned.** Every exact radius of Heule
  510/553 about the centre, and of each de Grey half about its own centre,
  lies in ℚ(√33) — zero √5/√7 content in ANY ring, all three witnesses
  **[measured: M31 stub, commits `dc97389`, `e721fb2`]**. Rotations preserve
  radii, so fabric ⊗ rotated-copies puts all new-field content in the angles.
  *Falsifier: a 5-forcer with a non-seam shell (test Parts 509 on import).
  SCOPE CORRECTION (2026-08-10): the falsifier has likely part-fired —
  Haugland's 2,131 (arXiv:2608.04542) builds a 5-chromatic graph on a
  HEPTAGONAL fabric (1/sin(2kπ/7) radii — a cubic field, not our tower), so
  the seam vocabulary is the hexagonal fabric's instantiation, not a law of
  5-forcers. The mechanism-level grokking survives strengthened: radially
  crystal, angularly detuned — per fabric. Pending: his verification is
  floats + uncertified SAT; the claim is unconfirmed by our standards.*
* **G4 — One shell vocabulary.** 25 of de Grey's 29 per-centre rings are
  Heule-510 rings; 12 rings are exactly the certified hexagram's; the named
  members are old friends — 1/3, 1, 4/3 (the forced-pair radius), 5/3 =
  |1 + σ/√3|² (the glue radius, whose conjugate lands ON the unit ring: the
  M21/M22 seam interlock, visible in published coordinates), 3, 4, and ±√33
  conjugate pairs. Every known 5-forcer stands on one ~30–44-value seam shell
  inventory. **[measured]**
* **G5 — The ownership factorization.** De Grey's 819-circle one-centre mess
  factors completely: two congruent 29-ring single-centre systems sharing
  exactly one point (the second spindle's pivot), spectra identical
  ring-for-ring; copy tags, mirror defect, and ring ownership are three views
  of one decomposition. **[measured]** *Reading: de Grey = two Heule-style
  systems glued by one twist.*
* **G6 — The hexagram is the 5-forcers' central organ.** Heule 510's centre
  carries exactly six two-circle pivot systems at exactly 1/√3 in a hexagon —
  M26's certified skeleton — plus seam-conjugate ring pivots at (1/√3)·σ̄
  exactly; 553 carries the unit-pivot triangle (M23's configuration) plus the
  ring. **[measured]** *Containment is NOT causation (the 1581 is
  near-edge-critical, so deletion cannot localize); the causal test is the
  mitotic-hexagram closure's SAT χ — M31's opening move. CAUSAL TEST RUN
  (M31, 2026-08-10): the mitotic hexagram — the certified chunk plus ONE
  new-field detuned copy, every anchor × generator variant at B ≤ 2 — is
  χ = 4 throughout, with coupling counts ≤ 12, all law-pinned (G12). The
  organ reading survives only as anatomy: the hexagram is the fabric the
  witnesses stand on, not a seed that one detune promotes to a 5-forcer.*
* **G7 — Detuning is the mechanism ("mitosis").** Every forcing rotation ever
  used is a small detune off an exact crystal angle: ρ₁₅ 1.045° off 30°, ρ₆₃
  0.638° off 15°, Moser 3.557° off 30°, σ 1.779° off 75° **[measured, exact]**.
  *Reading: exact symmetry adds no colour constraint (the copy reuses the
  base's pattern); the detune forces the clash while preserving interlock — a
  spindle is a forcer mid-division. Falsifier: a 5-forcer whose overlay is
  exactly symmetric, or detunes far outside the band; the "forcing band"
  question is registered at M31. INDEPENDENT SUPPORT (2026-08-10): Haugland
  (arXiv:2608.04542) builds his Moser-free 5-forcer with an explicit detuning
  parameter θ ≈ 0.4236 breaking his 7-fold symmetry "just enough", and his
  pipeline is literally our instrument currency — a virtual edge at √3
  (G₁, 740 vertices, forced-distinct pair), assembled into a forced-EQUAL
  pair at distance 2 (G₂), closed by the spindle at distance 2 — whose
  rotation matrix is OUR ρ₁₅ = (7+i√15)/8, appearing in a heptagon paper
  because the spindle radicand depends only on the forced pair's distance.*
* **G11 — The Moser subgraph is not necessary for 5**
  **[external, UNVERIFIED HERE — label added 2026-09-09 by the record audit, which found this was the
  section's only content entry without a status and the one that most needed one: neither witness has been
  imported or checked in this repository, and Haugland's is float + uncertified SAT by his own account]**
  (external landscape,
  2026-08-10): Voronov et al. (2021, 64,513 vertices) and now Haugland
  (2,131) give Moser-spindle-free 5-chromatic graphs. No tension with G1 —
  G1 places the Moser TWIST inside the seam group; it never claimed the
  subgraph necessary — and Haugland's route (engineer a forced pair at a
  spindle-able distance, then spindle) is the general form our G9 antipodal
  pairs are the first exotic instance of: the design question is not "embed
  the classical gadget" but "land a forced pair at a friendly distance"
  (4d² − 1 square in the fabric's field). *His 2,131 is verified by floats +
  uncertified SAT only — kernel-certifying it would need cubic-field
  machinery (cos 2π/7) beyond our multiquadratic tower; noted as a possible
  future insertion, Kooshi's call.*
* **G8 — The true group is the half-spindle group** ⟨ζ₁₂, σ, √ρ₁₅ = (√15+i)/4,
  √ρ₆₃ = (3√7+i)/8⟩: it closes all 67 of the 1581's directions at exponent
  ≤ 6; the whole-word subgroup covers 58% and every miss squares in;
  σ-exponents stay in {0,±1,±2} **[measured]**. Heule's witnesses carry a
  6-class, ~10-edge residue outside even this group — SAT-shrinking scars; the
  1581 is the only pure-group witness. **[measured]**
  **THE "SCARS" HALF IS A [reading], AND READING THE SOURCE NEITHER CONFIRMS
  NOR REFUTES IT (2026-09-09, FS-23).** `[Heule2019]` §5 gives the
  construction: the large part descends from `G2167 = ⊕⁸ C_{1/3}` truncated at
  radius 2, where `C_{1/3}` is the union of the radius-`1/3` hexagon and the
  90°-rotated hexagon of radius `(√3+√11)/6` — **whose directions are `ζ₁₂`
  words and whose squared radius `(7+√33)/18` is a seam radius, so G3/G4 are
  confirmed at source rather than measured** — and the small part is inherited
  from `G553`'s, merged with its own 60° rotations. So the out-of-group
  residue directions must live in the SMALL part, i.e. they are inherited from
  de Grey's lineage rather than minted by proof optimisation. That is a
  one-afternoon tools check (partition 510's out-of-group edges by
  large/small part) and it has not been run; until it is, "SAT-shrinking
  scars" is a name for the effect, not an explanation of it.
  **AND THE GROUP ITSELF IS PRIOR ART, WITH A GENERATOR WE DO NOT HAVE
  (2026-09-09, FS-23).** `[Polymath16wiki]` (last edited **4 June 2018**)
  computes the unit-modulus group of the Moser spindle ring
  `R̄₂ = ℤ[ζ₆, (1+√33)/2, 1/3]` by prime factorisation in the UFDs
  `ℤ[(1+i√3)/2]` and `ℤ[(1+i√11)/2]`, and gets **exactly `ω^i η^j` with
  `ω = ζ₆` and `η = (√33 + i√3)/6 = √ω₃`** — the half-spindle group, DERIVED
  in 2018 where M30 measured it from edge data in 2026 — and for the larger
  ring `R̄₄ = ℤ[i√3, i√11, √5, ½, ⅓, 1/7]` it lists the generators
  `ζ = (1+i√15)/4`, **`α = (√5 + i√11)/4`**, `β = (1+4i√3)/7`,
  `γ = (17+3i√55)/28`. **`α` is a unit-modulus element that is not a word in
  our four generators**, and Heule's witnesses have exactly the `√5` content
  it needs. *So the sharp form of the "scars" question is now: are the six
  out-of-group direction classes of Heule-510/553 `α`-words?* One afternoon
  with `tools/anatomy.py`; if they are, "SAT-shrinking scars" is refuted and
  replaced by "our generating set was short by one", which is a better
  answer and a G21 instance on our own instrument.
  **AND THE TWO GROUPS ARE RECONCILED EXACTLY (2026-09-09, verified numerically
  to 1e-13; a two-line Lean theorem waiting to be written).** Their `η` and our
  seam rotation `σ = (√3 + i√33)/6` are **`η = i·σ⁻¹`**, so `ησ = i`; and
  **`η² = ρ`, the Moser twist**, which is why the wiki calls `η` the square root
  of `ω₃` — while `σ² = −ρ⁻¹`, which is this project's own kernel identity
  `moserTwist_mul_seam_sq` (`ρσ² = −1`) rewritten. Writing a general element as
  `ζ₁₂^a σ^b`, the wiki's `⟨ζ₆, η⟩` is exactly `{ζ₁₂^a σ^b : a + b even}` — **an
  index-2 subgroup of our `⟨ζ₁₂, σ⟩`** — and that is why `σ ∉ R̄₂`: it is the
  odd class. So the two derivations agree, ours is the larger group by one
  half-step, and neither is wrong.
* **G9 — Rigidity lives only at the forcing level.** The 791 forcer at 4
  colours: exactly six forced pairs — the axis pair at distance 4 and five
  ANTIPODAL pairs at 4/√3, i.e. forced central symmetry on that circle, and a
  compulsion the classical spindle cannot exploit (closing it needs √183,
  outside the field). The hexagram chunk at 4 and the 1581 at 5: pairwise
  FLOPPY — zero forced pairs, zero virtual edges, settled exactly.
  **[measured: `build/m30-rigidity-*.json`]** *Deduction: a geometric χ ≥ 5
  argument must live at triple order or higher — de Grey's own informal
  argument is triple-shaped, and M20's `no_mono_outer_triple` is the formal
  genre. Falsifier: a triple-level scan of the fabric finding nothing
  compelled either.*
* **G10 — The forcing is distributed, not organ-like.** Single random edge
  deletions make the 1581 4-colourable (two edges PROVEN critical end-to-end:
  Python-verified colourings after deletion + the kernel-certified refusal of
  the whole); no small family carries the forcing (E3 refuted in every
  currency tried). **[measured; "at or near edge-critical" is sampled — the
  exhaustive 7,877-edge sweep is ~a day of CPU, unrun]**
  **SCOPE NOTE 2026-09-09 (FS-25 item E4): three of this graph's critical vertices are structural,
  not evidence.** `11`, `802` and `14` — the endpoints of the single cross edge and the shared vertex
  — are critical because the graph is a 1-sum, by a palette permutation and no search
  (`plans/FS25-P2.md` §1.5). The random single-edge probes behind this entry almost certainly never
  hit that seam (one edge in 7,877) so the *"distributed, not organ-like"* reading is untouched — but
  any re-run of the probe should exclude the seam and say so, and **the two edges this entry calls
  "PROVEN critical end-to-end" have no witnesses on disk**: the probes were ad hoc, their artifacts
  lived under the untracked `build/`, and the record does not name the edges. Treat that clause as
  *measured, witness lost* until re-run.
  *Consequence:
  "minimal" must mean least GEOMETRY (fewest shells × smallest angular word
  set whose compulsion cascade closes), not fewest vertices — fewest-vertices
  is a SAT-shrinking artifact wearing scars. THIRD MEASUREMENT (M31): even
  ENRICHING sub-witness chunks with the full gen-1 closure material (16,365
  vertices, 67,568 edges at the 1200-committed radius) leaves them
  4-colourable in seconds — the 5-mechanism is irreducibly global at this
  order; no closure shortcut below the whole witness exists at gen-1.
  FOURTH MEASUREMENT (M32): DESIGNED one-family stacks — including the
  triangle stack whose three translation matchings compose into 26
  forced-rainbow unit triangles spanning three detuned copies — carry zero
  compulsion of any order probed (pair, triple, coverage) at ~1,500
  vertices; the globality holds for designed objects too.*
* **G13 — The centre transition (the fan ladder)** (Kooshi's observation,
  2026-08-10, verified exactly the same night): the recurring mechanism of
  the colour steps is CONFINEMENT AT A CENTRE — the fan/coverage condition
  M18 formalized (`fan_iff_coverage`). The ladder: **3→4** — the two circles
  alone are 3-colourable **[kernel: M19]** and adding the centre forces the
  4th (the rainbow floor) **[kernel: M20]**; **4 without a centre** — the
  certified hexagram's meta-centre is BLIND (not a vertex; χ = 4 anyway):
  the 4-forcing routes through the PIVOT centres, which the self-seeding
  identity makes vertices for free — the crystal provides its own centres
  **[kernel: M26]**; **4→5** — Heule-510's centre is confined at four BY THE
  AMBIENT WEB: every proper 4-colouring of 510 − v0 covers v0's unit circle
  (36 points) with all 4 colours (one symmetric SAT ask, UNSAT 10.1 s,
  controls green), so v0 transitions to the 5th **[measured, 2026-08-10]**.
  Its own two-circle system provably CANNOT deliver that confinement
  (class-only graphs are 3-colourable, a 4th colour frees the pivot —
  **[kernel: M18]**; centre + circles caps at exactly 4 — **[kernel: M20]**)
  — so the centre's 5-transition is 100% ambient-delivered, and the inner
  circle participates through NO edge to the centre (1/√3 is not a unit) —
  M20's "compulsion acting through no edge" genre, one field up. Caveat
  measured honestly: fan-ness alone does not single out the centre — the
  degree-4 peripheral vertex 139 is ALSO fanned (its four neighbours forced
  rainbow in every 4-colouring, UNSAT 29.5 s, and no 4 plane points are
  pairwise unit-distant, so that rainbow is ambient-forced too) —
  vertex-criticality worn locally; the 5-forcing is a TAPESTRY of coverage
  compulsions (G10 again). What distinguishes the centre: its fan is the
  certified two-circle object in its coverage-4 state — the one compulsion
  whose isolated theory we own end-to-end. *Consequence for the instrument
  gap: coverage compulsion is a k-set property, structurally invisible to
  the pairwise rigidity sweep — P7's zero forced pairs and today's
  fanned-everywhere are the same fact seen from two orders. The
  coverage-order query (restrict N(v) to k−1 colours, one SAT call by
  palette symmetry) is the missing instrument, and it is CHEAP — built at
  M32 (`min_cover`/`coverage_query`, tools/rigidity.py); the hunt it
  enables is M33's golden question (G15). Falsifier
  for the ladder reading: a 5-forcer whose centres are all UN-fanned after
  deletion — then the 5-compulsion lives entirely off-centre.*
* **G12 — The quadrature law** (M31, derived a priori in the registered
  subplan, then verified at 26 exact censuses, zero violations): a detuned
  copy R·X of seam-field material X couples to X **only** along
  anchor-collinear pairs (R = s·W with W an even half-spindle word — a full
  spindle: Re(W) ∈ ℚ) or anchor-perpendicular pairs (W odd: Im(W) ∈ ℚ), with
  the radii on one explicit conic (t² + r² − 2·Re(W)(±tr) = 1, resp.
  + 2·Im(W)); words mixing √ρ₁₅- and √ρ₆₃-content couple NOWHERE. Proof
  shape: the 16-basis splits into four radical blocks K, √15·K, √7·K, √105·K
  and the chord equation must vanish per block. **[the ρ₁₅ instance is now
  KERNEL-CHECKED: `Quadrature.quadrature_rho15` (M32) — the pin and the
  conic as a theorem over explicit seam coordinates, resting on
  `sqrt5_indep`'s mod-5 descent; the ρ₆₃ instance remains measured-only, a
  numeral change away]** Measured instances:
  the (2,2) spindle diagonal, the (2/3, 2/3) perpendicular diagonal, and the
  **conjugate-ring channel** — rings at (17∓√33)/6 and (17±√33)/6 coupling
  through ρ₁₅ with t·r = 8/3: the first mechanism connecting the witnesses'
  ℚ(√33)-conjugate ring spectra (G4) to the coupling web. *Consequence,
  sharpening G7: a single detune's colour pressure is ONE CONIC of chords —
  thin by law — so 5-forcers cannot be built from chord soup; the forced-pair
  pipeline (de Grey's 791-forcer, Haugland's G₁/G₂) is not a design choice
  but the only channel wide enough. Falsifier: any census chord violating its
  pin — the instrument (tools/closure.py) aborts on one, naming P1.*
* **G14 — The stacking law, and width without degree** (M32, derived a
  priori in §0a, confirmed at every census point): a STACK's copy↔copy
  coupling is decided by the anchors — same anchor reduces to the
  single-word law at the relative detune forever (detunes form a group;
  the class is the spec quotient), while same-word copies at different
  anchors couple through a pin on the DIFFERENCE w = u − v, whose w = 0
  root at unit anchor separation is an O(n) **translation matching** — the
  arithmetic reason de Grey's construction has two spindle centres, and
  our triangle pivots supply unit anchor pairs natively. Confirmed exact:
  132-chord matchings at unit anchors (full and half words alike), ZERO at
  the √59-sterile 1/√3 separation, the chirality channel empty.
  **[measured + derivation; the census-confirmed §0a instances]** *The
  verdict on top, at face value: a matching is 1-regular — width without
  degree carries no colour pressure — and even composed matchings (the
  triangle stack's 26 spanning forced-rainbow triangles, genuine
  triple-order cross structure) are absorbed by the fabric's floppiness.
  Colour pressure needs degree-≥ 2 cross structure per point, which
  one-family stacks at probe scale provably do not create. Falsifier for
  the reading: a stack shape whose meters move — any reopening of the
  design thread registers its predictions first (M33 stub, parked list).*
* **G15 — The two-act anatomy, and the golden question** (2026-08-10, the
  M32 close discussion; Kooshi's re-aim: "I want to be able to confidently
  point to the reason why 5 colorings are forced"): every known 5-forcing
  argument factors as **pigeonhole × kill** — a DISJUNCTIVE class-level
  compulsion ("every 4-colouring of this fabric puts some forbidden pattern
  SOMEWHERE"; de Grey's informal mono-triple argument is the exemplar)
  composed with a thin, law-governed kill web refuting each placement (the
  half that is now kernel-checked: G12/G14). The disjunction explains the
  globality readings and M32's flat stacks: kills without a pigeonhole
  force nothing — and instance meters are structurally blind to the class
  (M32's stacks SAT on a fabric that M33 later showed FIRES the d2 class:
  the compulsion was there; the meters could not see it and the 1-regular
  matchings could not exploit a disjunction). **PROMOTED at M33 from
  [reading] to [measured] in its pigeonhole half**: the avoidance
  instrument found the class compulsion on four objects, and its Act-One
  carrier is SMALL — the 122-vertex 1-minimal core (G16). The neither-act
  falsifier branches registered in the stub did not fire; what remains
  [reading] is the ASSEMBLY claim — that pigeonhole × kill is not merely
  how known forcers are built but how χ ≥ 5 must be argued — tested by
  M34's union question. **TESTED at M34, and the constructive half is
  [measured]**: the 9-core pigeonhole (kernel) × six 791-forcer kill
  chains composed to a 4,749-vertex χ ≥ 5 union, confirmed through
  kernel-covered cubes — pigeonhole × kill DOES assemble to a 5-forcer,
  by design, from measured parts. What remains [reading] is only the
  universality direction (that every χ ≥ 5 argument must factor this
  way).* **PRIOR-ART NOTE 2026-09-09 (FS-23): the two-act reading is not
  only ours as a description of the known forcers — it is how their author
  describes them.** `[Heule2019]` §6.2, attributing the analysis to
  `[Heule2018]`: *"the large part limits the number of valid 4-coloring of
  12 vertices at distance 2 from the origin to 19. The small part prevents
  these 12 vertices to having any of these 19 4-colorings."* That is
  pigeonhole × kill stated as a design principle in 2019, at distance 2, with
  the 420-vertex large part lying in `K² = ℚ(√3,√11)²` — so by Theorem B the
  pigeonhole half is 4-colourable and the kill half must leave `K`, which is
  G16's "the field wall is exactly the wall between the two acts", legible in
  the construction's own description. **What stays ours: the kernel theorems
  (the bridge, the transmuter, the two 1-minimal carriers), the identification
  of the wall as the boundary between the acts, and the universality question.**

* **G16 — The distance-2 pigeonhole law** (M33, 2026-08-10; the
  instrument's discovery, found by a CONTROL and confirmed everywhere):
  **the hexagonal seam fabric cannot 4-colour without a monochromatic
  distance-2 pair** once it has (i) seam DEPTH ≥ 2 (the certified chunk:
  clean at B ≤ 1, fired at B = 2 — depth switches it, not radius) or
  (ii) radial extent past a fabric shell (bare de Grey fabric and the
  full 1581: onset r² = 2 − √33/9, IDENTICAL to nine decimals — the
  spindles neither create nor move it; Heule-510: onset at the glue
  shell 5/3). Distance 2 is exactly the ρ₁₅ spindle distance
  (4·2² − 1 = 15): **the pigeonhole is seam-native; every kill of it
  needs √15 — the field wall (G1) is exactly the wall between the two
  acts.** Act One's 1-minimal carrier: 122 vertices (de Grey's L: 121),
  12 near-rot6 shells about the metapivot, every member's necessity
  witnessed, both encodings agree. The √3-pair sibling in the 1581
  concentrates all the way to NINE vertices (two √3-triangles + unit
  circumcentres + hub + one edge, hand-proved) — pigeonholes are cheap;
  the kills (virtual-edge gadgets, ~740 vertices each in Haugland's G₁)
  are the construction's entire cost. **[measured: build/m33-*.json, the
  explorer's M33 pane]** *Consequences: the design grammar for 5-forcers
  is "kill every d2 placement over a deep-enough seam region" — de
  Grey's and Haugland's pipelines are both instances; and the √3-pair
  pigeonhole is an ASSEMBLY product (only the full 1581 carries it,
  onset at the √21 shell where cross-system material enters — Heule's
  shrinking discarded it). Falsifiers: any validated 4-colouring of a
  named fired region avoiding all d2 pairs (would break both encodings
  at once = instrument catastrophe); a fabric-depth-2 seam region of
  comparable extent that stays clean; external — whether Haugland's
  heptagon fabric pigeonholes at ITS spindle distance (2, via the same
  ρ₁₅) is the cross-fabric test, unrun. AMENDED at M34: both carriers
  are now **[kernel]** (`core9_pigeonhole`, `core122_pigeonhole`, with
  kernel-complete pair lists — **the plane corollaries `core9_plane` and
  `core122_plane` are VACUOUS, per ledger row 31's 2026-09-09 correction, and
  are NOT part of this entry's support; the entry itself is unaffected, because
  its claim is about finite fabric regions and those really do have
  four-colourings**), and the gadget
  anatomy sharpened twice — the **organizing-distance law** (whose geometric half is already a kernel theorem — `ClassGeometry.exists_unit_triangle_iff`, M18, ledger row 6 — a fact this amendment states as a measurement; the *concentration* half stays a reading: a mono-d
  class concentrates iff its equilateral d-triangle has UNIT
  circumradius, i.e. d/√3 = 1 ⟺ d = √3: the unique pair class whose
  triangles buy a common unit neighbour — why the √3 core is 9 and the
  d2 core is 122), and the **transmuter link** (inside the 9-core, the
  forced colour transfer hub = rim crosses plane distance exactly 2 —
  the √3 pigeonhole MANUFACTURES forced-equal d = 2 pairs; the two
  pigeonholes are one mechanism seen at two arities).*
* **G17 — Globality lives only at the top rung** (M33's resolution of
  the G10/G15 tension): the 4-onset (the fan = χ ≥ 5 itself, by the A1
  factorization) arrives exactly at the last vertex — measured at three
  centres, and provable from vertex-criticality in two lines — while
  EVERY sub-rung compulsion measured has a small carrier: min-cover 3
  at 49 = 36 + 13 (the interior web on (7−√33)/6 ∪ {1/3} ∪ (9−√33)/6),
  the d2 pigeonhole at 122. G10's four globality measurements were all
  measurements OF THE TOP RUNG; the mechanism was never global — it was
  disjunctive, and the ladder below the top is made of small, nameable,
  certifiable objects. **[measured]** *The golden question's answer so
  far: the 3rd colour is delivered by a 13-point interior web; the leap
  to the 4th is the witness-wide composition of class pigeonholes with
  field-crossing kills — the object M34 tries to build minimally.*
* **G18 — Composition sees what search cannot** (M34, the union
  measurement): the 4,749-vertex union (9-core pigeonhole × six
  791-forcer kill chains) is χ ≥ 5 by a one-page composition — and
  monolithic CDCL, handed the whole formula, CAPPED at 3600 s, while
  the six cubes covered by the KERNEL pigeonhole each refuted in
  ~800 s. Clause learning does not discover a disjunctive factoring;
  handing the solver the factoring (cubes = the pigeonhole's cases) is
  the difference between unknown and done. **[measured]** *Consequences:
  A5's no-monolithic-SAT architecture is not a preference but a
  necessity at composed scale — certify components, compose in the
  kernel; and the palette factor (6.5× on the union cubes, 35× on the
  122 CNF, re-measured) says pinned formulas + kernel-side symmetry
  closure (the Gadget layer) are the standing shape for every future
  certificate. Falsifier: a solver config that cracks the monolithic
  union in minutes — then this is a tuning anecdote, not a law.*

* **G19 — The 6-hunt's missing ingredient is 5-tight fabric.** M35's
  sweep — the first class-level k = 5 measurement anywhere — read CLEAN at
  every (object, class, radius): no pattern class is compelled at five
  colours on any witness, closure chunk, fabric stage, or lattice ball we
  hold; fan rows sit at min-cover 2 of 5. The k = 4 story had tight fabric
  everywhere because the seam fabric IS exactly-4-chromatic material
  (M33's pigeonholes fired on it); the k = 5 analogue — regions whose
  5-colour space is tight enough to carry a class compulsion — does not
  exist in today's inventory: **the 6-hunt's Act One has no stage until
  someone builds 5-tight fabric**, and composition of 5-forcers (the M34
  union genre) is the only known constructive route. The corrected
  two-sided semantics stand with it (M35 §0a C1): an avoider at k rules a
  mechanism out AT k only — the k = 5 avoider hunt IS the open
  upper-bound hunt (any find proves χ(ℝ²) ≤ 5), and k = 6 avoiders bound
  seven-forcers, not six. **[measured: build/m35-sweep.json; the
  instrument is standing and k-generic]** *Falsifier: any object whose
  k = 5 class sweep fires — the sweep-halt rule is armed in the campaign
  driver.*
* **G20 — DEMOTED at M36; what it measured survives, what it read was
  false.** As minted (M35): row-aligned brick colourings cannot 7- or
  8-colour the plane at any probed shape — ~2,800 registered rows, mass
  red green throughout — so interlock is load-bearing and the hexagonal
  tiles' overlap in y is the mechanism. **The rows stand exactly as
  measured. The reading is refuted**: `Instances/Seven.lean` is a
  row-aligned brick 7-colouring of the plane, kernel-checked (M36). The
  refusals were produced by two coupled choices, each registered in
  advance and each reasonable at the time — a certificate demanding
  STRICT separation (`q < lo ∨ hi < q`), which is one comparison stronger
  than soundness needs for half-open cells, and a grid filtered to
  `diag² < 1`, which is exactly the condition that strict rule needed.
  The brick seven-colouring is boundary-tight by force (cell diagonal
  exactly 1), so it was excluded twice over. Neither choice was a bug and
  the arithmetic was never wrong; the inference from "our test refused"
  to "the family cannot" was the error. **[measured, reading refuted:
  build/m36-periodic.json — the same family, corrected check, k = 7 SAT
  including the kernel-certified row]** *What survives as fact: no brick
  colouring passes a POSITIVE-MARGIN certificate at seven, because none
  exists — every member of the family is boundary-tight. And the family
  still cannot reach six: k = 6 refused in 1,394 rows under the corrected
  check.*
* **G22 — Where a six-colouring cannot live. AMENDED 2026-09-08 (FS-18): the region this grokking blacks out was already blacked out in the literature, and more widely.** [SokolovVoronov2025] prove `χ_poly(ℝ²) = 7` — no polygonal colouring of the plane in six colours — which covers every cell-constant colouring of every lattice at every scale, not only the triangular one, and covers non-lattice polygonal colourings too. [Coulson2004] and [Townsend2005] had `χ_map ≥ 6` before that, and [Manta2021] may have the triangular case earlier still (named, not obtained). **The grokking's CONTENT survives and its novelty does not**: "a six-colouring, if one exists, is not a lattice colouring" is true, is ours by derivation, and is not new. What is still ours is the arithmetic that gives the exact value seven rather than the floor (the Loeschian gap, the norm-7 ideal at scale `6/7`), and the finite kernel-checkable carriers. **The sharpened version of the grokking is the useful one and it is untouched: a six-colouring must have colour classes finer than half the unit distance in every lattice's cells — and now, by Sokolov–Voronov, classes that are not polygonal at all.** Original text follows.

* **G22 (original) — Where a six-colouring cannot live.** The upper-bound side of the
  interval now has a map with one region blacked out. Every *lattice*
  colouring — colour by the class of the nearest lattice point, which is what
  the classical seven-colouring is and what every proposed construction has
  been — needs exactly seven colours, no more and no fewer **[kernel: M37]**.
  So the search for `χ(ℝ²) ≤ 6` cannot be a search over lattices, scales, or
  sublattices: it must leave the coset family entirely. What the proof says is
  *why*: the cells cannot be big (their own deep holes make a same-coloured
  pair of diameter `2p/√3`, forcing `4p² ≤ 3`) and the colour classes cannot be
  close (a kernel vector shorter than twice the cell reach is caught by its own
  multiples), and between those two walls the lattice's arithmetic admits
  nothing below norm 7 — because 5 and 6 are not of the form `a²+ab+b²`. **The
  bound is number-theoretic, not geometric**: the same two walls over a
  different lattice give a different threshold (the square lattice needs nine,
  by the same argument with sums of two squares in place of the Loeschian
  numbers). *Reading on top, believed and falsifiable: a six-colouring, if one
  exists, must have colour classes that are not unions of cells of any lattice
  — which is consistent with G20's correction (the brick seven-colouring is
  boundary-tight, and every known witness sits on some crystal), and suggests
  the upper-bound hunt should look at aperiodic or non-cell constructions — **and `[deGreyParts2022]` reached the same place from the other side in 2022, reporting `d(6) < 1` for every hexagonal lattice-sublattice colouring and asking, in a section headed "Towards `d(6) = 1`", whether a more general polygonal tiling could do it; `[SokolovVoronov2025]` answers that no** (ledger row 34's second correction).
  Falsifier: any six-colouring of the plane whatsoever; short of that, a
  general-lattice proof would extend the blacked-out region from the triangular
  lattice to all of them — the crude chain already gives `k ≥ 6` everywhere and
  the missing piece is the `k = 6` rigidity case.* **SHARPENED at M38**: the
  coset hypothesis is not needed above `p = 1/2`. There the constraint graph's
  first shell is a 7-clique, so *any* cell-constant colouring — arbitrary
  labels — needs seven **[kernel: M38]**. The blacked-out region is therefore
  not "lattice colourings" but "cell-constant colourings at coarse scale", and
  what remains is the FINE regime: a six-colouring must have classes finer than
  half the unit distance in every lattice's cells. *That is a much sharper
  address than G22 first gave, and it coincides with where M36's pixel-brick
  probes ran out of solver: the open region is the same one from two
  independent directions.*
* **G23 — The good scales are isolated, and refining is not a route down.**
  A colouring constant on a lattice's cells is exactly a colouring of that
  lattice's constraint graph, so the whole cell family is one parametrized
  family of graph-colouring problems, indexed by the scale. Measured across
  that parameter, the requirement is **not monotone**: seven in the classical
  window, **eight just below it** (kernel: the 8-clique theorem), seven again
  near `p ≈ 0.46`, with the clique number then collapsing while the graph
  itself grows denser — and the oscillation persists into the fine regime,
  where `p = 1/3` genuinely refuses seven to period 30 while `p = 1/7` admits
  it on a 24 × 24 torus. **[kernel + measured: M39]** *Consequence: the intuition
  "smaller cells approximate the plane better, so they should do at least as
  well" is FALSE — the classical scale is a local optimum and its neighbours
  are strictly worse. Any hunt for a six-colouring in this family must jump to
  isolated good scales rather than refine, and the fine regime (where the tori
  needed to express a colouring outrun the solver) is the only part still
  open. Falsifier: a six-colouring of any `G(p)`, which would be `χ(ℝ²) ≤ 6`;
  short of that, a patch-based refutation would upgrade the period-bounded
  refusals into statements about `χ(G(p))` itself.* **PRIOR-ART AMENDMENT
  2026-09-09 (FS-23): the non-monotonicity was published in the dual variable
  in 2022.** `[deGreyParts2022]` §2 records that the lattice-sublattice
  restriction makes their `d(k)` decrease locally in the number of colours,
  and their §4 asks outright whether some colours are **redundant**;
  `[Parts2023]` Conjecture 4 then says that for some `k ≥ 7` no forbidden
  distance interval has `χ(d) = k` at all. Our parameter is the scale and
  theirs the colour count, but the two are inverse functions and three of our
  band boundaries are exactly their thresholds (ledger row 34's second
  correction). **So the sentence "nobody had looked below the classical
  window because the family was invisible until the constraint reading" is
  wrong and is withdrawn** — de Grey and Parts had looked at `k ≤ 175` in
  2022, Chybowska-Sokół–Junosza-Szaniawski–Węsek in January 2022, Ivanov in
  2007. **What survives is the arbitrary-label generality and the exact
  values it buys**: on the G\* band their best coset colouring needs twelve
  colours and an arbitrary cell-constant one needs seven.*
* **G24 — AMENDED TWICE 2026-09-08 (FS-18): its conditional is DISCHARGED, and its floor is SUBSUMED.** (i) The `[Voronov2023]` conditional flagged throughout this entry is retired — the paper was read here on 2026-09-08 and proves exactly Theorem 1.1 as stated, `χ_[1−ε,1+ε](ℝ²) ≥ 7` for every `ε > 0` and every 2-dimensional norm, by a **non-computational** argument. So `χ(G(p)) ≥ 7` for the entire cell family at every scale is now **unconditional**. (ii) The same conclusion arrives a second and shorter way, from [SokolovVoronov2025]'s `χ_poly(ℝ²) = 7`, which does not go through the interval theorem at all. **What this entry keeps, and it is the part that mattered: the `ω = 3, every relaxation low, χ = 7` PATHOLOGY** — the discrete family reproducing the plane's own signature in objects a kernel can check whole, with certified Hoffman brackets at 3.56–4.1 against a truth of 7–8, `χ_f ≤ 48/7`, and the 23-vertex `χ = ω + 3` carrier. No published result gives a finite object; ours do. Original text follows.

* **G24 (original) — The gap law: below the classical window, seven is forced without cliques,
  and the family is a finite mirror of the plane's own pathology.** (M40.) On every
  band from the classical window down to `p = 0.2236`, plus the `1/6` flanks, the cell
  family needs ≥ 7 colours OUTRIGHT (ball refutations, no periodicity) — while ω
  collapses to 3–5, the certified Hoffman/spectral bound collapses to ≈ 4.1, and the
  fractional relaxation stalls at 48/7 on G\*. The forcing is **integrality, carried by
  small near-symmetric cores** (23 vertices at G\*; 53 at the deep pocket; broken-rot6
  orbit structure — the de Grey 122-core motif reappearing in a different universe).
  And the classical mechanism is provably absent: **no index-7 sublattice coset
  colouring exists below the window** — the sevens there are non-homomorphic, with
  non-uniform classes and trivial stabilizers. So `ω = 3, all relaxations low, χ = 7`
  is not a peculiarity of the continuum plane: the discrete cell family reproduces it
  at every fine scale, in objects the kernel can check whole. **[measured: exact
  arithmetic + exhaustive cliques + SAT — PROMOTED at M42 in its forcing half: the
  12-window, the M = 4 shell window, the coset-impossibility, and χ(G\*) = 7 at ω = 4
  via the 23-core are now kernel theorems (ledger row 39); the deep pocket's χ ≥ 8 and
  the fine-tail ω collapse remain measured-only]**
  *Consequences: the from-above six-hunt now has a concrete, ranked target list — the
  open scales start at `p = 1/7` (ω = 3, six undecided to period 36, balls to 225
  six-colour) and everything below `p = 0.2236` except the 1/6 flanks; and the
  23-vertex G\* core is the smallest known carrier of a "χ > ω + 2" forcing in this
  family — the right first object for a mechanism theory of clique-free forcing, the
  same question the plane's χ ≥ 5 poses at k = 4. Falsifiers: a six-colouring of any
  band (χ(ℝ²) ≤ 6, the standing jackpot clause); or a relaxation that DOES see the
  gap — any polynomial certificate matching the ball refutations would be a new
  lower-bound instrument for the whole programme.*
  **EXTENDED and CONDITIONALLY EXPLAINED at M43**: the ≥ 7 floor now runs unbroken from
  the classical window to `p ≈ 0.109` wherever a verdict landed (19 further bands
  outright; **χ = 7 exactly at both 1/7 flanks**, the last undecided scale), the Hoffman
  collapse deepens to 3.56 at 1/7 — and the mechanism has an external explanation:
  **conditional on Voronov's proof of the Exoo conjecture (arXiv:2304.10163 — ≥ 7 colours
  for every forbidden-distance interval `[1−ε, 1+ε]`, any ε > 0), χ(G(p)) ≥ 7 for the
  ENTIRE family at every scale.** The derivation is two lines: a six-colouring of `G(p)`
  with `p < √3/2` would be a plane colouring avoiding a whole closed interval around 1
  (intra-cell distances stay below 1; the finitely many cross-cell offset windows near 1
  are closed sets missing 1, so a positive gap exists), which that theorem forbids. So the
  band-by-band sevens are not a coincidence of scales but a shadow of an interval theorem —
  and by de Bruijn–Erdős compactness EVERY band owns a finite refuting ball, making our
  refutations certificates of a guaranteed fact rather than discoveries of a contingent one.
  *The conditionality is real and stays flagged: [Voronov2023] is an external preprint this
  project has not verified. The unconditional content remains ours, band by band.*
* **G28 — REFUTED IN ITS PAIR-MEDIATED HALF at M45 (2026-08-13); what it measured was a
  six-element acceptance set, not the object.** The re-measurement, on **the identical stage**
  (the R = 8 ball, 241 vertices, fingerprint `9d9599be0db64677`): M43's own six anchored asks
  **reproduce exactly** — 6 realizable, 0 compelled — and that same stage carries **seven virtual
  edges** at offset norms **27, 28, 31**, classes the six-ask sweep never touched. Each is decided
  in **7.5–15 s** and **each is confirmed in three independent encodings** (forward-order breaking,
  reversed-order breaking, colour-pinned with no breaking) with every control green, so this was
  never a solver-budget question — the questions were not asked. On the *critical* stage (the
  1-minimal core less its highest-degree vertex, one vertex short of refusing) the **complete**
  sweep of all 9,636 non-adjacent pairs finds **51** virtual edges, 0 forced pairs, 11 undecided at
  cap. Coverage is the primary effect (six asks against thousands); stage criticality is secondary
  (51 against 7 on identical pairs). **So Act Two DOES exist at the fine tail**, "the forcing does
  not factor as pigeonhole × kill" is withdrawn, and the inference from it — that the compulsion is
  "global over ~160 vertices by exclusion" — loses its support. **[measured: M45, triple-encoded,
  `plans/M45-arity-floor.md` §R1]** *What survives: the counting half of Act One (the closed
  shell's seven addresses at norms {1,3,4} are non-edges at that scale, so six colours force a
  repeat) is untouched, and G26's universality reading — demoted at M43 on G28's strength — should
  now be read as never having had a falsifier here. What killed it is G21, and the entry below is
  the general form.* Original text, kept because a demoted grokking is never deleted:
  **The fine-tail forcing does not factor: pigeonhole × kill is NOT universal.**
  (M43, the 1/7 autopsy; the falsifier G26 registered and never found in five cores.) At
  the coarse 1/7 flank Act One is *free* — the closed shell's seven addresses have all 21
  mutual offsets at norms {1,3,4}, none of them edges at that scale, so six colours force
  a repeat with no argument at all — and **Act Two does not exist**: forcing any such pair
  to share a colour remains satisfiable on 241 vertices, *more material than the
  160-vertex core that refutes six outright*, and the same holds at every small non-edge
  class (norms 1, 3, 4, 7, 9, 12, each decided in under a second). Equivalently there are
  **zero virtual edges at k = 6** on the largest colourable stage — the from-above mirror
  of M41's 0/40 flat verdict from below. **[measured: `build/m43-finetail.json`,
  `kind: factorization-autopsy`; scope — balls centred on the pair up to 241 vertices, the
  six smallest non-edge classes]** *Consequences. (a) G26's universality reading is
  demoted to a statement about the objects it was measured on: five cores factored, the
  sixth does not, and the sixth is the one with the plane's own clique number at the
  finest scale examined. (b) "Integrality-carried" (G24) now has a positive measurement
  behind it rather than an inference from a relaxation gap: the compulsion is not
  pair-mediated at any arity a pair meter can see, so it is global over ~160 vertices by
  exclusion, not by default. (c) The certification consequence is direct and was the
  milestone's practical verdict — no small gadget exists to certify, so the certificate
  cost tracks the whole object (one cube of the split proof logs 63× the entire 122-core
  certificate). Falsifiers: a kill gadget at a class or region not swept — a non-ball
  region, a larger class, or a forced-equality between cells at an EDGE-adjacent
  configuration; or a factorization at a different fine band, which would make 1/7 the
  exception rather than the fine tail's rule.*
* **G25 — The forcing ladder is recursive, and the levels read like protein
  structure.** (2026-08-12; seeded by Kooshi's peer's analogy; the full pass is
  `plans/SHAPES-OF-SIX.md`, the standing shape-space both directions cite.) The
  measured mechanism at each jump: χ ≥ 4 is HOLONOMY of deterministic rainbow-clique
  propagation (at k = ω every triangle is rainbow — zero local entropy — and the
  Moser twist returns the information shifted); χ ≥ 5 is a disjunctive regional
  PIGEONHOLE over exactly-4-with-depth fabric, whose kills are the previous level's
  forcer applied to the forced pair one field up. **Each level's kill is the previous
  level's forcer** — so the default 6-forcer has 5-forcer-grade kills (~10⁵–10⁶
  vertices, certified-composition-only, G18), UNLESS a shortcut shape fires
  (forced-equivariance kills with no new field; or the from-above lab's un-named
  integrality mechanism transplanted). Protein mapping where it is exact: secondary =
  k-rigid motifs (rhombus chains as α-helices), tertiary = one folded witness
  (edge-criticality IS marginal stability, G10), quaternary = the conjectured
  6-forcer as a DETUNED OLIGOMER of 5-chromatic domains whose compulsion lives in
  interface conformation algebra (the M20 strip automaton is the method precedent);
  where it lies: proteins have one energy scale, we have a field ladder (G1).
  **AMENDED 2026-09-06 (mined from the web-Claude analysis; second-hand until read): the 3 → 4 step has a route that is
  NOT rainbow-clique holonomy — Wormald (1979) built a 4-chromatic unit-distance graph of girth 5 and O'Donnell (Rutgers
  thesis, 1999) of arbitrary girth, with no triangles at all; triangle-free forcing is the regime of topological and
  Mycielski-type arguments (FS-9), and the "holonomy" mechanism is the mechanism of the objects we hold, not of the step.**
  **[reading — falsifiers per shape in SHAPES-OF-SIX §3: menus total ⟹ Shape A
  starves; gen-2/3 clean at depth ⟹ Shape B demoted; no equivariance compulsion at
  k = 5 anywhere ⟹ Shape C demoted; the 23-core autopsy finding a known genre ⟹
  Shape D deflates; any of them firing ⟹ the 6-hunt has its Act One.]***
* **G26 — The autopsy dictionary: pigeonhole × kill is 5-for-5 universal in the
  finite lab, and the 6-forcer reduces to one gadget.** (M41 phase 0, 2026-08-12.)
  Every 1-minimal clique-free forcer core of the cell family (23, 28, 53, 66, 117
  vertices — gap-3 and gap-4, coarse and fine, with and without centres) FACTORS:
  Act One is always a mono pair forced onto a small **non-edge class** (norm 1
  first — the closed hex shell's 7-cells-vs-6-colours counting argument surviving
  the clique's death: the norm-3/4 pairs stay edges, so the forced repeat lands on
  exactly the class that stopped being an edge), and the ambient web kills every
  placement. The fractional relaxation always sits far below the truth:
  χ_f = 130/23 at the 23-core (χ = 7), 501/74 at the 53-core (χ = 8), ≈ 4.83796
  bracket-tight at the 117-core (χ = 7 — **gap 2.16, ratio 1.45, the programme's
  extreme, on the object with the plane's own clique number**). **[measured: exact
  LP certificates verified in rational arithmetic; class-avoidance sweeps with the
  M33 deleted-vertex fan classes in the vocabulary]** *The plane-side consequence,
  sharp: the kernel already holds Act One at five colours
  (`hexShell_pigeonhole` — every 5-colouring of the closed hex shell has a mono
  pair at √3 or 2), so* ***a 6-forcer needs exactly one thing: a finite
  unit-distance graph forcing two points at distance √3 or 2 to receive different
  colours in every proper 5-colouring*** *— nine copies on the shell then close
  χ(ℝ²) ≥ 6 by the M34 composition genre. The from-below hunt is a hunt for that
  single gadget; the m1 virtual-edge meters are its exact detector. Falsifier for
  the reduction: none needed (it is a theorem-shaped composition); falsifier for
  the universality reading: a core that refuses to factor — none found in five.*
  **SHARPENED 2026-08-14, reading the reduction against the kernel object it names:
  "one gadget at √3 OR 2" is too weak.** `hexShellPairs` (`Instances/HexShell.lean`)
  is `hexShellP3 ++ hexShellP4` — **six** pairs at √3 (the 120° ring gaps) **plus
  three** at distance 2 (the ring diameters), nine in all — and `hexShell_plane5` is
  *disjunctive over both classes*. So killing all six √3-pairs leaves the three
  diameters standing, and vice versa: **χ(ℝ²) ≥ 6 needs a virtual edge at √3 AND one
  at 2.** Both radicands sit inside the 5-forcers' own field (a spindle at distance
  `d` needs `4d² − 1` square: 11 at √3, 15 at 2), so neither is out of reach in
  principle, and *either one alone would be a major result that halves the remaining
  problem*. **[PROMOTED TO KERNEL at M48, 2026-08-15:
  `six_le_chromaticNumber_plane_of_forced_pairs` (`Instances/HexShell.lean:271`, under `namespace HadwigerNelson` only — corrected 2026-09-09) states the CONJUNCTION —
  both classes forced, at five colours, in the plane — and the two halves are proved
  independent from both sides by two explicit proper 5-colourings of the seven-point
  carrier, one separating all six √3-pairs and one all three diameters. So "neither
  class alone suffices" is no longer a reading of a disjunction; it is a theorem with
  its own adversaries.]**
  **COLOUR-GENERIC AND DISTANCE-SET-GENERIC 2026-09-09 (FS-24 G4, ledger row 61).** The five was
  decoration: `hexShell_plane` had always been stated for every `k < 7`. So the conjunction is now a
  theorem at every colour count below seven, and **its `k = 6` instance says two six-colour gadgets
  at `√3` and `2` give `χ(ℝ²) ≥ 7`** — G48's bold form, from below. And because the pigeonhole's
  proof needs only properness at distance `1`, the same theorem holds over `distanceGraph ℂ D` for
  any `D ∋ 1` — which changes the reduction's *shape* for the first time since it was minted:
  **over `{1,2}` the three diameters are already edges, so a single `√3` gadget suffices and gives
  `χ(ℝ²; {1,2}) ≥ 6`** (`six_le_chromaticNumber_oneTwo_of_forced_sqrt3`). Both halves of that trade
  are weaker than the plane's — the hypothesis quantifies over a smaller family of colourings, the
  conclusion bounds a larger graph — and neither statement implies the other; that is precisely why
  it is reachable, since the objects M49 and M50 measured `μ` against are `{1,2}`-graphs. *The
  "AND, never either" reading is untouched and remains the sharp one for the plane itself.*
  *The "nine copies" in the original text was always the
  right count; what was loose was reading nine copies of ONE gadget where the nine
  pairs carry two distances.*
  **SCOPE NOTE on the detector, same date:** the m1 meters were run to COMPLETION on
  the objects that matter — `build/m30-rigidity-1581-k5.json` and
  `build/m41-rigidity-*.json` are all `status: done` with `unsettled: []` on both
  sides, and the `Rigidity` lattice settles rather than samples — so the from-below
  zero is complete over all 1,248,990 pairs of the 1581 (3,216 at √3, 1,092 at 2;
  counted 2026-08-14), **not** a sparse sample. M45's enumeration correction applies
  to M43's six-ask sweep and does **not** reach here. What is genuinely unswept is the
  gen-1 closure (24,065 points, never run) and gen-2 (284,873 points, 40 targeted
  asks) — and the ARITY, which `arityFloor_le_of_degree` guarantees is ≤ 5 on the
  1581 while the pair sweep says it is not 2.*
  **THE ARITY QUESTION IS NOW ANSWERED (M48) — see G31.**
  **SHARPENED AGAIN at M49 (2026-08-17)**: the "one gadget" is exactly a rigid pair, and a rigid pair
  at five colours is a 6-chromatic graph with ONE non-unit edge — `μ = 1` — so the reduction is a
  restatement, not a shrinking (G32). What M49 adds constructively: a certified way to LOWER a
  forcer's dependence on its second distance one edge at a time, and the first twelve such lowerings.
* **G32 — The dial: a rigid pair at five colours is a six-forcer with one defect, and the
  descent measures how far unit material carries the forcing.** (M49, 2026-08-17.) Every reduction
  "χ(ℝ²) ≥ 6 needs one gadget at √3 or 2" (G26) is exact and RELOCATES the difficulty: a forced-equal
  pair at distance `d ≥ ½` is refuted by a spindle at any `k` **[kernel: `not_colorable_of_forced_equal`]**
  and one non-unit edge in a `(k+1)`-chromatic drawn graph already gives χ ≥ k+1 **[kernel:
  `add_one_le_chromaticNumber_unitDistance_of_one_defect`]** — so `μ(d)`, the fewest `d`-edges of a
  non-5-colourable {1,d}-graph, is a dial whose value 1 IS the theorem and whose value 0 is the
  witness. Measured on the seeds the literature holds: **a hand-minimized forcer is edge-critical to
  the last edge** (Parts's {1,φ} G31, 56/56 and 57/57), so μ cannot be read from a critical object's
  own subgraphs — it is measured by ADDING unit material to a forcer and asking whether an essential
  `d`-edge becomes redundant, certified (UNSAT, second encoding, 1-minimal halo, witnesses). **The
  first turn: twelve of the twenty-nine distance-2 edges that every forcing subset of Exoo–Ismailescu's
  seed must contain are replaced by seventeen seam-field unit points at five colours, and the
  seventeen others refuse every one-generation pool in both fields, every ask decided.** Then the
  seed's rigidity turned the search into lookups: `H − e` has 2–19 separating colourings, a halo
  kills iff it is list-uncolourable under each, the depth-one partner set (complete in any field)
  is exhausted for all seventeen, and restricted depth two kills seven with gadgets of 87–267 points
  — cost ×100 per depth, measured — of which two compose with the earlier twelve (kills are
  context-dependent: design against the CURRENT object, not the seed). The
  mechanism is A1 at a blind centre — the kill point's unit neighbourhood in the seed is forced
  rainbow in every separating colouring, so the point cannot be coloured — a compulsion an enumeration
  over PRESENT vertices never sees (the M33 warning, now a design criterion). And the k = 4
  calibration says how far the seam field reaches when the endpoint is known: 34 of 37 essential
  distance-2 edges of the 122-core pigeonhole fall to one seam generation, the last three need the
  field jump — their certified commits did not finish (a 28,000-point shrink at four colours ran 9.5 h and was stopped; the three UNSAT probes stand as single-encoding probes, and the four-colour object is not rigid enough — > 20,000 colourings — for the lookup engine that finished the job at five). **[kernel for the two theorems; measured for the rest]** *Readings on top,
  falsifiable: (a) the seventeen refusers are the seed's true "kills" — the edges whose job needs the
  √15 field or depth ≥ 2 — and the descent's stall value against pool depth is the recursion's cost
  curve (G25); (b) designed halos (points whose neighbourhood is forced rainbow) will beat enumerated
  pools by orders of magnitude, since the twelve kills were single points found inside pools of
  hundreds. Falsifiers: a deeper pool that removes NONE of the seventeen (then the seed's forcing has
  an irreducible distance-2 core at every depth probed, and μ_H sits at 17 + the slack); a coverage
  meter that finds no forced-rainbow seam point for any refuser.*
* **G33 — The batch law, and the lattice that compounds.** (M50, 2026-08-24.) Designing ONE
  halo against the WHOLE batch's separating-colouring list makes removals compose BY
  CONSTRUCTION — measured twice (19 then 24 cheats per certified commit, against M49's
  fourteen across a whole sequential campaign, where kills were context-dependent and
  composition an afterthought). And the deeper half: **the committed material's own partner
  lattice grows faster than the rigidity it must break** — the core probe re-asked every kept
  refuser edge against the grown object's 394,604-point depth-1 lattice and found five falling
  outright and six holding zero provably-surviving colourings (49 capped asks the only gap),
  where the SAME edges refused every pool of the smaller object. M49's "refuses depth one in
  any field" was a statement about the seed's lattice; growth alone re-opens it.
  **[measured: two certified commits + the core probe; the kernel licence is
  `PartnerLattice.lean`]** *Reading on top, falsifiable: the depth-1 descent is
  SELF-ACCELERATING — each commit's points spawn the partners that kill the next batch — until
  the width regime (the 277 stalls whose kills are thousands-of-points-wide) becomes the
  binding constraint; the recursion's cost curve is then depth-2's, not depth-1's. Falsifiers:
  an iteration whose grown lattice kills strictly FEWER refuser colourings than the previous
  one (the curve bending down); or a width-stall population that GROWS as a fraction of the
  batch across iterations (the width regime arriving early). Composes with G32 (the dial) and
  G25 (the recursion's cost ladder); the spare-colour lemma bounds what the loop can ever
  quietly skip — the unit part must cross 4 → 5 before the end, so the loop mints a 5-chromatic
  witness en route or fails visibly.*
* **G34 — The field is the selection, and the descent has never left it.** [measured, exact] Every
  committed point lies in ℚ(√3, √11) because every glue point the design ever kept is a parent plus a
  ladder unit vector (T13/T14), while the depth-1 pool is ~~85 %~~ **99.0 %** out-of-field with √5 and √35
  material one iteration away. **CORRECTED 2026-09-09 (the FS-24 record audit): the 15 %/85 % split was an
  artifact of double-counting, and `plans/RISKS.md` has carried the correction since 2026-09-04** — the census
  counted `2·pairs`, an upper bound, while in-field glue points FUSE (a ladder point with `k` object
  neighbours is the glue point of `C(k,2)` parent pairs), so the true in-field slice of the 1,636,399-point
  pool is **16,348 points (1.0 %)**, not 280,390. This entry carried the superseded number under its
  `[exact]` stamp for five days; the error ran in the conservative direction, which is presumably why it
  survived, and the correction **strengthens** the entry's conclusion. The tiers rank pool points by object
  degree; in a crystal object high degree means on-ladder means in-field. *Reading, ~~falsifiable by the
  out-of-field kill census~~ — **that census was M53 phase D, and M53 was HALTED at phase D, so the named
  falsifier never ran and now never will; the reading was settled instead, and the other way, by Theorem B**:*
  the selection is structural, not a verdict on the material, **and the material it selects can never do the
  last kill**. Composes with G1 (the field wall) and G19 (5-tight fabric).
* **G32, sharpened**: the copy trick is the endgame's tool — a copy of 4-colourable fabric is
  coloured around at five colours (P5's zero), and the same copy becomes a kill when the unit part's
  5-colourings are rigid, i.e. after the χ(unit) crossing; registered as a per-iteration monitor.
  And the halt clause read exactly: one standing cheat is a two-branch disjunction to verify; zero
  is the theorem.
* **G33, extended**: growth compounds AND redundancy accumulates — the cull is the third descent
  move, zero geometry, and after every commit the standing set shrinks without a halo (273 → 149 on
  the first complete cull).
* **G21, fifth instance**: a copy union's "copy–copy chord" at the float census's 1e-7 was a
  near-miss the exact census rejected; every composed object now carries its exact-rejected pairs.
* **G31 — The witness's rigidity at its top rung is exactly its own fan, and there is
  nothing underneath it.** (M48, 2026-08-15; a theorem plus two complete sweeps, no
  induction anywhere.) `arityFloor_le_of_degree` guarantees de Grey's 1581 carries a
  compulsion of arity ≤ 5 at five colours, and *constructs* it: `k` distinct
  neighbours of one vertex can never be rainbow. The question was whether the object
  has anything **else** — some emergent low-arity compulsion the degree bound does not
  hand you. Measured: **nothing at arity 2** (complete, 1,248,990 pairs), **nothing at
  arity 3** (complete, 3,286,925,350 questions), **nothing at arity 4 inside a vertex
  neighbourhood** (complete, 25,782,585 questions) — so `arityFloor(1581, k = 5) ∈
  {4, 5}`, and the fan compulsions the theorem constructs are **1-minimal**, since
  deleting any vertex from one leaves a 4-subset of a neighbourhood now known free.
  **[measured, complete; the bracket is kernel]**
  **AMENDED 2026-09-09 (FS-25 item E4, consolidation package P2): the arity-2 line's forced-equal
  half is a COROLLARY, and the sweep was measuring a theorem.** `CriticalSet.encard_criticalSet_le_two_of_forces`
  (M54, kernel) caps at **two** the critical vertices of any injectively drawn unit-distance graph
  that forces a pair equal at its own chromatic number — and de Grey's 1581 has at least **three**,
  because it is a **1-sum**: two 791-vertex halves meeting only at vertex `14`, plus the single cross
  edge `(11, 802)`, with all 7,877 edges verified to lie inside a half or be that edge. Deleting `11`
  or `802` removes the only crossing edge and leaves a 1-sum of two 4-colourable halves; deleting `14`
  leaves them joined by that edge alone; each glues by one palette permutation. The three 4-colourings
  are held at `data/e4-critical-vertices.json`, each re-verified edge by edge, with both halves shown
  to refuse three colours as the red. **So `Forces` is empty on all 1,248,990 pairs by theorem.**
  **What does NOT follow: the virtual-edge half** (its localization bounds the critical set by
  `|N(p) ∪ N(q)| ≤ 120`, so it needs ~121 four-colour asks or the full edge-criticality sweep), **and
  nothing at arity 3 or 4** — M48's 3,286,925,350-question triple sweep and its 25,782,585-question
  neighbourhood sweep keep their full value. The measurement is not retracted; it is re-labelled.
  `plans/M54-five-colour-dial.md:419` had already run this argument for the *other* witness and it
  was never carried back. `plans/FS25-P2.md` §1.
  *The consequence for the from-below
  hunt is a closed door, and it is worth more than the open one it closes: the
  compulsion structure of a certified 5-chromatic witness at its own top rung is
  **exactly the trivial one**. There is no small forced pattern hiding in de Grey's
  graph waiting to be extracted as a gadget — G9's pairwise floppiness was not a
  peculiarity of arity 2, it goes all the way up to the arity where a counting
  argument forces structure to exist. So a χ ≥ 6 gadget must be **constructed**, not
  **found**; four campaigns of meters pointed at existing witnesses were mining an
  object that provably has nothing to mine at this depth. And the ladder says
  enrichment does not change it: fifteen times the material, from the same
  half-spindle group, compels nothing new on the witness's own triples — the fifth
  independent measurement of G10 and the first above arity 2. Falsifiers, both cheap
  to state and neither run: a general (non-neighbourhood) 4-subset compulsion —
  `C(1581,4) = 259,338,410,115`, explicitly out of scope and NOT swept; or the same
  ladder on another 5-chromatic witness — Heule's 510/553, or M41's three Galois
  conjugates — finding arity-3 structure where the 1581 has none, which would make
  this a fact about de Grey's construction rather than about 5-chromatic matter.*
  **AN EXTERNAL NULL, recorded 2026-09-09 (FS-23), beside G10's four measurements
  of the same shape**: `[Heule2019]`'s conclusion says *"using the techniques in
  the paper we constructed several graphs with up to 100 000 vertices, but all were
  5-colorable."* Independent of us, on a different construction family, and it is
  the largest such null we know of — the 6-forcing is not reachable by growing the
  known witnesses' own genre, from outside this project as well as inside it.
* **G27 — The witnesses have hidden arithmetic symmetry, and the Galois orbit mints
  free witnesses.** (M41 phases 4/5, 2026-08-12; every claim an exact computation
  with planted controls.) The half-spindle field tower's Galois group acts on
  witnesses; on de Grey's 1581: **the flip √3,√5,√11 ↦ −√3,−√5,−√11 fixes the
  vertex set identically**, giving a **non-geometric involutive automorphism** τ
  (29 fixed points, 776 two-cycles, maps the 7,877 edges to themselves exactly)
  while the graph has NO nontrivial plane self-isometry; with mirror∘flip[5,7] and
  mirror∘flip[3,7,11] the hidden automorphism group is a **Klein four-group**. The
  orbit has exactly **4 isometry classes: the 1581 + three genuinely new
  5-chromatic witnesses** (W^[3], W^[5], W^[3,5]; W^[5] an isospectral twin —
  centroid spectrum equal, congruence excluded by the exhaustive ring-heart
  argument). **P9: the 791-point forcer IS V ∩ −V** — the centrosymmetric core of
  the witness, exactly — so M30's forced central symmetry is substrate symmetry
  surfacing at criticality; and the witness is **half-crystal** (787 of 1581
  vertices fully rot6-invariant about the origin pivot — the detuned-oligomer
  signature inside one object). Heule-510 has **no √7 content** (it lives in
  ℚ(√3,√5,√11)). Hetero-dimers V ∪ W^σ share up to 1,101 vertices — new composed
  matter. **[measured]** *Readings on top: forced equivariance under NON-geometric
  automorphisms is a compulsion vocabulary nobody had (built, controlled, not
  forced on today's floppy objects — re-ask wherever m1 structure ever appears);
  and the only nonzero k = 5 reading of the whole campaign is the dimers' 10×
  solver-effort excess (single-sample, signal not claim). Falsifiers: an explicit
  isometry between W and any [3]-coset conjugate (would collapse the free-witness
  count); a second-sample effort measurement reading flat.*
* **G21 — A search run against a sufficient-but-not-necessary check
  measures the check, not the world.** The general form of G20's death,
  and the reason it is minted rather than left as a footnote: this
  project runs registered searches constantly, and every one of them
  inherits the sharpness of its acceptance criterion. When a sweep
  refuses, the first question is not "what does this say about the
  objects" but "is my acceptance test the exact condition, or a
  sufficient one?" — because a conservative test converts a *finding*
  into a *measurement of my own instrument*, silently and with the
  registered-prediction discipline fully satisfied. M35's phase 2 was
  registered, controlled, mass-red-guarded, honestly reported, and its
  negative measured a comparison operator. **[measured: the M35 → M36
  pair, where the identical grid returns different verdicts under a
  criterion changed from sufficient to exact]** *Consequences already
  applied: `tools/periodic.py`'s schema line now states which caveat
  survives (the shape grid) and which is gone (the certificate); the
  standing rule for every future sweep is to state, at registration,
  whether its acceptance test is necessary as well as sufficient — and
  if it is only sufficient, to say what a refusal therefore cannot mean.
  Falsifier: none needed — this is a methodological invariant, and it
  fails only by being ignored.*
  **SECOND INSTANCE, and it cost a grokking (M45, 2026-08-13).** The rule generalizes from the
  acceptance *test* to the acceptance *set*. M43 asked six questions — one per class, each anchored
  at the origin — and wrote the answer as "zero virtual edges at k = 6", a statement about the
  object. The artifact's scope line was honest (*"six smallest classes"*); the summary sentence was
  not, and the summary is what became G28. Re-asked as 9,636 questions **on the same stage**, the
  object has seven, at classes the six never reached. **The generalized rule: a sweep's negative is
  a statement about its enumeration, and the enumeration belongs in the same breath as the verdict
  — in the headline, not only in the scope line.** Two design consequences now built into
  `tools/arity.py`: a verdict function that returns `undetermined-subtuples` rather than any verdict
  when the evidence that would qualify it is missing, and a verdict enum containing no word that
  means "clean" at all.
  **THIRD INSTANCE — the rule reaches POSITIVE counts (M50, 2026-08-23).** A cast-limited triangle
  census reported "16 never-3-distinct triples on {√3,√7,2√3}"; the cast-free census holds **412,
  in five families including one at √13 the cast never saw** — a positive count over a cast
  measures the cast exactly as a negative does. The standing mechanical rule from the M50
  adversarial round: **every headline of this genre carries its enumeration AND its conditioning
  in the same sentence** — scope lines inside an artifact do not survive into summaries unless
  they are in the headline.
  **FOURTH INSTANCE — a SPEEDUP is a positive count over a population (M51, 2026-08-27).** The
  WO-1 close reported "~250× per core" for the Rust engine's SOLVER-FREE tiers against Python's
  peel path, with the caveat in the next sentence that the solver tail was unmeasured and would
  dominate. The scope did not survive: later summaries said "asks are milliseconds now", the
  WO-5 cost model then anchored the shrink on WO-2's 2.6 ms refutation median (slack rung
  instances), and the shrink's asks — boundary instances by construction, "does this kill set
  still kill with one point removed" — ran at 1–7 s, ~1000× the anchor, missing P2 by ~80×.
  Neither measurement was wrong; the population was dropped from the headline twice. A speedup
  claim names its population and its regime in the sentence that carries the number.
  **A reversal worth recording (2026-09-09, P6).** A general lemma (`div_mem_normOne`) was designed,
  measured against its only possible consumer, found not to earn its place, and **cut** — with the cut
  written into the module's docstring so nobody re-derived the negative. One question later it came
  back with a consumer, because the *scope claim* being made ("the law is general") was read back
  against what had actually been proved (only the difference-keyed half was; the distance-keyed half,
  which is the form the ledger states, was not). The cut was right on the evidence available and wrong
  on the evidence one question later. **What surfaced the question was not a better instinct but a
  written claim being checked against a written theorem** — which is the same discipline as this
  grokking, applied to a positive rather than to a negative.
* **G29 — AMENDED 2026-09-08 (FS-18): the conditional is discharged and there is a free bounded region.** [Voronov2023] verified here; the deformation's pinning at seven along the whole open ray is now unconditional, so the framing — `χ(ℝ²) < 7` is the claim that a function known constant on an open ray is discontinuous exactly at the endpoint — stands without an asterisk. **And his Theorem 1.3 is a gift to this entry: if a disc of RADIUS 3 is covered by six closed sets, one realizes the unit distance** — an explicit bounded region, where the limit lemma's own statement needs a compact set supplied by hand. That is the first published constraint on the `N(p)` divergence this grokking makes the quantitative handle, and it should be compared against our own measured `R*` of 1.02–1.38 unit distances before the next turn of the dial. Original text follows.

* **G29 (original) — The cell family is not a door, it is a dial, and the open problem is the
  discontinuity at its endpoint.** (Minted 2026-08-13, on a re-reading of M39–M43 with no
  new measurement.) A colouring constant on the cells of a triangular grid at scale `p`
  forbids not the single distance 1 but a closed INTERVAL around 1, of half-width `δ(p) > 0`
  that shrinks with `p` — this is exactly M43's own bridge to Voronov, with the width made
  explicit and computable (`δ(p) = min dist(1, I_v)` over the offset windows `I_v` that miss
  1). So `G(p)` is a **one-parameter deformation**: at the coarse end the classical
  seven-colouring, and as `p → 0` the cells shrink to points, the constancy constraint
  evaporates, and **the limit is the unit-distance problem itself.** Along that whole
  deformation the answer is pinned at SEVEN — proven band by band by us, and (conditional on
  [Voronov2023]) at every scale — while every structural invariant collapses underneath it
  (ω 7 → 3, the certified spectral bracket to 3.56, the fractional bound stalling below 5).
  Therefore `χ(ℝ²) < 7` is the claim that a function known constant on an entire open ray is
  **discontinuous exactly at the endpoint**, and all the information about the plane's own
  answer lives in the approach. The quantitative handle, derived and not yet measured: let
  `N(p)` be the size of a vertex-critical non-6-colourable subgraph of `G(p)`. **If `N(p)`
  stays bounded along any sequence `p → 0` then `χ(ℝ²) ≥ 7`** — take cell centres, pass to a
  subsequence (a critical graph is connected with min degree ≥ 6, so bounded count gives
  bounded diameter for free), every edge's length is `1 ± O(p) → 1`, and any two indices that
  collide in the limit were non-adjacent so the limit is a contraction, which cannot LOWER
  the chromatic number. Contrapositive: **the divergence of `N(p)` is a necessary condition
  for `χ(ℝ²) ≤ 6`** — the exact quantitative obstruction between the proven interval theorem
  and the open point theorem. **[PROMOTED at M44: the limit lemma is now **[kernel]** —
  `add_one_le_chromaticNumber_unitDistance_of_bounded_family`, on axioms exactly the standard
  three — and the dial has been turned. The deformation and the pinning stay **[measured]**
  (M39–M43).]** **AND THE DIAL'S FIRST TURN CLOSED THE FAMILY IN ITS SECOND DIRECTION.** The
  measurement: each certified core's unit-distance defect, against its size. The gain over the
  free cell-centre drawing SHRINKS as the cores get finer (1.91× at 23 vertices, 1.13× at 117 and
  160) — the dense fine cores are so over-constrained that the cell-centre drawing is already
  nearly optimal — so within this family the defect is pinned at `≈ 2p/√3 ∝ p` while the size
  grows like `p^(−1.75)`. The two are locked to one parameter and pull opposite ways, so **the
  cell family cannot supply a bounded-size family as `ε → 0` either**, and by the limit lemma it
  cannot yield `χ(ℝ²) ≥ 7` any more than it could yield a six-colouring. *The family is now closed
  in both directions, and the honest epistemic content of the measurement is narrow: `ν` upper
  bounds that grow are consistent with `ν` bounded and with `ν` divergent alike, so the numbers do
  not bear on which of 5, 6, 7 is true. What they give is the first explicit points on `ν`, a
  baseline any future construction must beat, and a sharpened target — a source of
  non-6-colourable graphs whose DEFECT falls faster than their SIZE grows.* One positive
  structural find survived the confound check: with the ball radius DERIVED rather than chosen,
  the minimal refuting configuration is **physically scale-invariant at 1.02–1.38 unit
  distances** across a 3.16× span of scale. *Why it was missed: M43 evaluated the family on one criterion — can a
  six-colouring live here? — got a clean and correct no, and retired the instrument without
  asking what the PARAMETER was doing. The Voronov connection, treated at that close as the
  direction's tombstone, is what makes the dial meaningful: it is the statement that the
  function is constant on the ray. Falsifiers: the limit lemma failing on careful writing
  (most likely at the collision/contraction step); or `N(p)` proving to be dominated by
  shrink quality rather than by mathematics, which is G21 and which is why the milestone's
  comparability phase runs before its ladder.*
* **G30 — Measurement generates; induction kills. The failure is never the measuring — it
  is promoting an inductive reading without a derivation or a registered replication behind
  it.** (Minted 2026-08-13, from sorting the whole record by how each claim was reached;
  stated in this form on Kooshi's correction, which is the load-bearing half: *"the
  interesting patterns that become intuited and derived show up first from measurement, so
  it's a catch-22."*) Sorted by provenance, the record is close to a clean dichotomy.
  **Derived from structure first, then measured — survived, every one**, several becoming
  kernel theorems: the quadrature law (26 exact censuses, zero violations), the stacking law,
  the criticality factorization A1, M36's boundary-tight sharpening (worked by hand in §0a
  before any code), M42's exact-hexagon reach whose corner values ARE the band boundaries,
  M25's `√3·ζ₁₂ = 1+ζ₆`, G26's reduction. **Measured first, then interpreted — died, every
  one**, mostly refuted by our own later work: the seam-alignment kill mechanism (0/4 on
  registered replication), the concentration bet, the coset census, the triple-kill
  population (provably empty), G20's brick-interlock reading (refuted by our own M36
  theorem), G26's universality (refuted by G28), M39's "finer is worse", M39 §0e's
  shell-exhaustion claim, M43's P8 core-shape prediction, M31's P6 band prediction.
  Roughly 7-for-7 against 0-for-10. **[measured: the project's own record]** *The rule this
  yields is NOT "measure less" — every derivation above began life as a pattern somebody
  noticed in a measurement, and the quadrature and stacking laws were derived precisely
  because earlier censuses had shown where to look. The rule is about what a measurement
  BUYS: it buys a candidate pattern, never a conclusion, and the conclusion is bought
  separately by a derivation or by a pre-registered replication on fresh objects. Two design
  consequences already applied: prefer measurements that turn a DIAL (a parameter whose
  behaviour is informative in both directions — G29's ladder, the hetero-dimer effort curve
  against overlap) over searches that hunt for a POSITIVE (whose null result is
  uninterpretable and has now come back flat four times); and prefer CALIBRATED test beds —
  ask the new question on an object whose answer is already certified, so a zero reading
  bounds the instrument instead of being mistaken for a fact about the world
  (`plans/M45-arity-floor.md` is that pattern made into a milestone). Falsifier: none needed;
  like G21 this is a methodological invariant and it fails only by being ignored — but the
  tally is falsifiable and should be re-sorted at every tenth milestone.*
  **A NEW FAILURE MODE, from M48 (2026-08-15): a registered prediction can carry an
  inductive reading in its own escape clause.** P6 registered that if the enriched object's
  never-observed pattern fraction came back *lower* than the witness's, that "would be the
  first sign the closure does something structural." It came back lower — and the reading was
  never available: the witness is an INDUCED subgraph, so the closure's achievable patterns on
  those vertices are a **subset** of the witness's own and cannot be more numerous. The gap is
  the SAT sampler, necessarily, and one line of derivation says so. *The rule this adds: write
  the escape clause to the same standard as the prediction. A pre-registered interpretation is
  still an interpretation, and being committed in advance protects it from hindsight bias but
  not from being false. Ask of every "if it comes back the other way, that would mean X"
  whether X is even consistent with what is already proven about the objects.*
  **A SECOND FAILURE MODE, from M49 (2026-08-17): a registered NEGATIVE can rest on the wrong reading
  of a theorem-shaped grokking.** P4b registered that seam-field unit material "cannot do a √15 job" —
  reasoning from G1 (5-forcers need the field jump). But a halo does a distance-2 edge's job IN
  CONTEXT, with the other defects still carrying the load, and that is a far weaker demand than
  forcing five on its own: 34 of 37 times a one-generation seam halo met it. G1 was never contradicted
  (the unit part alone stayed 4-colourable); the prediction applied a statement about pure objects to
  an in-context question. *The rule this adds: when a prediction is derived from a grokking, check
  that the grokking's quantifier matches the measurement's — "no seam-field object forces five" does
  not imply "no seam-field halo replaces a defect".* And the opposite direction cost P7: the k = 5
  removals were CHEAPER than the k = 4 ones (median one point against 8.5), because the descent finds
  the cheap kills first — a selection effect the registration did not name.
  **A THIRD FAILURE MODE, from M50 (2026-08-23): a verdict message that names a cause it did not
  check converts one bug into two.** The iteration-2 cover deferred 3,023 provably-killable
  colourings because an oversized early rung broke the rung ladder — and the defer message said
  "cost budget", a cause that never fired, sending the first diagnosis toward budgets while the
  size guard was the culprit; the results row's scope sentence simultaneously asserted the stalls
  "survive the whole pool", false for deferrals. The rule: error and verdict messages may name
  only the branch that actually fired, and a conflated stall/defer vocabulary is itself a bug
  (fixed with a per-item reason taxonomy in which only 'survives-whole' means what the old scope
  claimed). The flip side, same milestone: the always-verify discipline PAID twice in one day —
  a coverage-subset verify caught an exact minimizer silently swapping a kept edge out of the
  hitting set, and a 25 ≠ 24 banner cross-check caught a stale commit field before any certify.

  **A FIFTH FAILURE MODE, from the valuation law (2026-09-09): a theorem can pass every gate — kernel-checked,
  standard three axioms, statement read aloud against the informal claim — and still say NOTHING, because its
  hypothesis is a type one of your OWN earlier theorems emptied.** `core9_plane` and `core122_plane` (M34) quantify
  over proper four-colourings of the plane; rung B says there are none. Both are true, both cost real work, and both
  are vacuous — and a stub then rested a live argument on one of them, which is how the emptiness was finally noticed,
  four weeks later, by someone trying to *use* it. *What makes this the sharpest instance in this entry: the
  defence was already written down and simply not run.* `DEBRUIJN.md` § correctness-over-plausibility says it in as
  many words — *"exhibit a model of your hypotheses — one concrete instance satisfying all of them — before trusting
  any theorem that assumes them, because a `∀` over an empty domain proves everything and means nothing"* — and
  WORKFLOW step 3 repeats it. **The rule this adds is mechanical, because the principle plainly was not enough:
  every theorem whose hypothesis is a structure (a colouring, an embedding, a certificate, a homomorphism) ships with
  a named inhabitant of that structure, in the same file, or a one-line note saying which theorem supplies one.**
  `ValuationLaw.lean` does it (the `√3` row is instantiated on `{0, √3}`), and it is the cheapest possible check —
  the inhabitant is usually already lying around. Composes with G21 (a negative measures its enumeration; here an
  *affirmative* measured its domain) and with G30's own thesis, since the failure was not a bad inference from a
  measurement but a statement that had no measurement behind it at all.

  **A SIXTH FAILURE MODE, minted 2026-09-09 from the consolidation surveys, and it is the quietest one yet:
  a CORRECT INSTANCE recorded where a THEOREM was available.** Two independent surveys — one over the Lean
  sources, one over the whole written record — came back with the same shape thirteen times. Four primes
  instead of all primes (the finite planes are pairwise free at *every* prime, by an orbit argument, where the
  record has four tables); one radius instead of the classification (the circles whose unit chords close are
  exactly the unit-polygon circumradii, where the record has `r² = 1/3` and a shrug at `r² = 3`); one fabric
  piece instead of the size law; a solver's circulant instead of its closed form; measured directions instead
  of the group; a theorem stated over `ℂ` whose proof needs only a metric space; a law stated at one prime
  whose proof needs only a residue map. **Every one of these readings is TRUE**, which is exactly why they
  survive every gate this project has — nothing is wrong, something is merely smaller than it needed to be.
  The cause is not a bad inference; it is that *the instrument answered and the question closed*.
  *The detector is mechanical, and it is not "grep for unexplained": **grep for `[measured]` next to a small
  finite list of instances, and for a statement whose hypotheses are narrower than its proof uses, and ask each
  one what the general form is.*** Stubbed as `plans/STUB-explain-the-unexplained.md` (six items) and
  `plans/STUB-generalize-the-kernel.md` (seven). Composes with the fifth mode above — that one is a `∀` over an
  empty domain, this one is a `∀` over a domain smaller than the proof needs.

  **The repair has a failure mode of its own, found on 2026-09-09 while running it (FS-24 G1/G7a).**
  Widening a theorem's hypotheses can widen them past the point where they do any work. The planned
  shape for the `CriticalSet` plane corollary read the two radii *off the critical vertex* — and at
  read-off radii the `Forces` and `CriticalSet` hypotheses are **dead**, because every point of the
  plane is a glue point of any two distinct points at its own two distances. That statement would
  have been true, kernel-checked, axiom-clean, and empty. **So the sixth mode's repair inherits the
  fifth mode's guard**: after generalizing, delete each hypothesis once and confirm the proof
  breaks. Here the fix was to quantify over the drawing's distance *set* rather than over nothing,
  which is where the content was. A second, smaller instance the same day: the metric-space form of
  `criticalSet_eq_empty` needs `0 ≤ M`, which the unit instance supplied silently — a generalization
  can *lose* a hypothesis the special case was getting for free.

  **A sixteenth instance, and it closed the same day it was minted (2026-09-09, package P4).** The record's
  *"the sealing planes at 3, 7, 11, 19 are ALL pairwise free"* is four tables where one rotation argument covers
  every prime. Two things are worth keeping from how it closed. **First, the plan that named it over-specified
  the proof**: `plans/STUB-explain-the-unexplained.md` §E1 set out five steps whose fourth was an
  orbit–stabiliser count over the `(p+1)/2` circle-missing lines — correct, numerically verified, and
  **unnecessary**, because the argument needs one rotation that moves the period line rather than a transitive
  action on all of them. A derivation written down before it is formalized can carry incidental structure
  exactly as a measurement can. **Second, the theorem it produced was one hypothesis away from being vacuous**
  — `Forces` is true of every pair on a graph with no proper colouring — which is the fifth failure mode
  waiting inside the sixth; the shipped counterexample at `p = 3, k = 2` is what keeps them apart.

  **A seventeenth instance, found while generalizing (2026-09-09, P6), and it is the sharpest kind: a
  proof that names the wrong mechanism.** `ValuationLaw.lean` cancelled a unit vector from a residue
  by *"`𝔽₄` has no zero divisors, by exhaustion over sixteen pairs"* — true, decided, and not the
  reason. The reason is that a ring homomorphism's **kernel is an ideal**, and an ideal absorbs units,
  which needs nothing at all of the residue ring. The sixteen-case `decide` is a correct instance
  standing where a one-line theorem was available, and no gate can see it: the statement is right,
  the proof is right, the hypothesis is merely stronger than the argument. *The detector, added to
  the mode's own list: a finite `decide` used to discharge a step that has a name in ring theory.*

  **A SEVENTH FAILURE MODE, from the vacuity sweep of 2026-09-09 (FS-26), and it is the fifth mode's
  mechanism rather than another instance of it: a theorem whose HYPOTHESIS is implied by the
  EMPTINESS OF ITS OWN CONCLUSION'S DOMAIN.** The shape is
  `¬ Colorable(G⁺) k → ∀ C : G.Coloring (Fin k), P C` with `G ≤ G⁺`. If `G` itself refuses `k`
  colours then so does `G⁺`, so the hypothesis is free — and the conclusion quantifies over an empty
  type, so it is free too. **Both halves degenerate at the same moment**, which is exactly why no gate
  catches it: the statement is true, the proof is correct, the hypothesis is discharged by a genuine
  certificate, and the conclusion is empty. `core9_plane` was an instance of this, not a one-off.
  Four sites carry the shape (`Pigeonhole.lean:82`, `Fan.lean:217`, `Forcer.lean:106/117/137`,
  `AdditiveRigid.lean:100`), and it was found **twice independently, in two different layers**, which
  is what makes it a mode rather than a remark. *The remedy already exists in this repository three
  times over and is never the entry point instances travel*: the two-way form whose right side demands
  a colouring (`Pigeonhole.colorable_append_iff_exists_avoiding`); folding the witness into the
  checked `Bool` so the certificate carries a proper colouring of its own graph
  (`NarrowFan.lean`'s `NarrowCert.check` — the pattern to copy); and taking the inhabitant as a
  *hypothesis* so the trap is closed by the signature and travels with the theorem
  (`ResidueObstruction.lean`). *And the detector exists too*: `Arity.arityFloor_eq_zero_iff` makes
  vacuity a **value** — `arityFloor G k = 0 ↔ ¬ G.Colorable k` — which is the sixth mode applied to
  this project's own instrument, since it is a theorem being used as a per-tool convention.

  **A FOURTH FAILURE MODE, from the prior-art check of 2026-09-08 (G49): a derivation can be correct,
  independent, hard-won — and second.** The derivation-first column's 8-for-8 record is a record of
  claims that were TRUE, not of claims that were NEW, and nothing in this discipline distinguishes
  them without a search. Four milestones of correct derivation reconstructed a 2010 draft's §§1, 3, 4,
  6, 8 and 10. *The rule this adds: "derived, therefore ours" is exactly the inference this grokking
  forbids everywhere else, and it had been running unchallenged. A derivation's novelty is a
  MEASUREMENT — a literature search — and it belongs at the milestone's opening, where it can still
  change the work.*

  **THE STRENGTHENING (Kooshi, 2026-09-06, on the finite-plane pivot — his reading of the whole record as a ladder of
  disciplines, each hop forced by a wall that turned out to be a theorem in the next room):**
  *graph theory* (the problem, the Moser spindle) → *computational combinatorics / SAT* (the wall: hand refutation dies at
  ~20 vertices; de Grey, Heule, Polymath16) → *formal verification* (the wall: SAT certificates are opaque bitstreams;
  Lean's kernel — this project's entry point) → *Euclidean geometry* (the wall: the graphs are not abstract — rotation groups,
  spindle angles, the 1/√3 circle; M1–M20) → *algebraic number theory* (the wall: "why do all 5-chromatic graphs contain √5
  or √7?" — a question about the coordinates' field, not the graph; M20–M24) → *p-adic / local algebra* (the wall: "what
  makes K = ℚ(√3,√11) special?" — how 2 factors when i is adjoined: ramification, inertia, residue fields; Theorem B — the
  steepest hop, where CS-flavoured discrete mathematics has almost no overlap) → *additive combinatorics* (the wall: "why does
  the residue method go blind between 4 and 7?" — it only uses homomorphisms, linear maps; the Cayley-graph reframing, M56)
  → *finite field geometry* (the wall: "is linearity the only thing the finite picture can do?" — no: the reduction lands in
  an actual finite Euclidean plane whose chromatic number is non-linear and sees 5; Vinh 2005 studied the objects, nobody
  had connected them to the field descent). Suggested and not yet entered: *algebraic topology* (Borsuk–Ulam, box
  complexes — the one lower-bound technique sharp at every integer; FS-9) and *commutative algebra* (Nullstellensatz
  certificates — polynomial infeasibility proofs sensitive to integrality; FS-10). **The pattern: the project hits a wall in
  discipline N; the wall is a theorem in discipline N + 1; that theorem explains the wall and opens the next room. Every
  transition was forced by a specific obstruction, never by wandering — which is why "derivation kills, measurement
  generates" keeps holding: the walls ARE the theorems, and the work is recognizing which field each one belongs to.**
  *Rule this adds: when a measured wall resists derivation in the discipline it was found in, name the discipline the
  wall's statement naturally lives in and look for the theorem there before building another instrument here.*

* **G35 — The wall is 2-adic, and the useful material is a congruence test.**
  **[GATE NAMED 2026-09-09 by the record audit: what is kernel-checked is the reduction over a SUBRING
  (`ResidueColouring.colorable_unitDistance_induce_of_valuationSubring`, with `normOne_subset_valuationSubring`
  and `conj_mem_valuationSubringAtPrime` beside it). The FIELD-level statement below — for a real number field
  `F` with a conjugation-fixed prime, `χ(F²) ≤ N(𝔭)` — is gated on exactly ONE unproved lemma, named verbatim in
  ledger row 57: *that a number field with a conjugation-fixed prime supplies the valuation subring with residue
  field of size `N(𝔭)`*. That is a Mathlib-shaped finiteness statement about residue fields, not a new idea, and
  closing it promotes G35 and G43 together — and with them the field-level half of the whole sieve. Recorded here
  so the gap is one line rather than an inference across three files.]** [theorem, hand-proved
  (`~/field-wall-conjecture.md` §5–§6); the criterion measured on every class one gluing step reaches]
  For a real number field F the residue colouring gives χ(G(F²)) ≤ N(𝔭) for any prime 𝔭 of F(i) fixed by
  complex conjugation; such a prime above 2 exists iff −1 is not a square in some completion of F above
  2, and its norm is 2 or 4. For multiquadratic F = ℚ(√d₁, …) the test is a square-class congruence: the
  wall stands iff no odd square class is ≡ 7 (mod 8). Over K a glue point with radicand r = 4/d² − 1
  breaks the wall iff −r is a square in both 2-adic completions of K — a finite congruence per candidate
  point, decidable before any search. Of the eight rational classes one gluing step reaches from K
  ({1, 2, 5, 7, 10, 14, 35, 70}), exactly 5 and 7 break it. M53's exact split of the depth-1 pool
  (16,348 in-field of 1,636,399) needs its wall-breaking sub-split before any of it is worth a solver.
  *Reading on top, falsifiable by the new plan's first census: the kills that matter for the endgame come
  from wall-breaking points, and a design that ranks candidates by object degree never sees them (G34);
  falsifier: a wall-breaking pool that kills nothing the in-field pool does not.*

**The field-wall theorem's pass over the working theory (2026-09-05, on Kooshi's "mint/update
grokkings").** One theorem re-reads a dozen entries; each is amended here in place of a rewrite, so the
record shows what was believed, what was measured, and what is now proved.

* **G1 → [theorem].** As minted: the 4/5 boundary is a field boundary. Now: χ(G(K²)) = 4 exactly, by an
  explicit additive colouring (Woodall's genre, one field up), hand-proved and machine-tested on the seed
  and on the descent's 1,981-point object with zero search; kernel formalization pending. The reading's
  mechanism was right and its vocabulary was wrong: "the seam group can force 4 and no more" is true
  because the seam group is defined over a field whose 2-adic completions do not contain √−1, not
  because of anything about the group's words.
* **G3 / G7, corrected.** "Radially crystal, angularly detuned" and "detune enough to clash" were the
  metric shadows of an arithmetic fact: a rotation's coordinates carry the new field, and it forces the
  5th colour iff that field breaks the wall. ρ₁₅ = (7 + i√15)/8 adjoins √15 ∼ √5 (5 mod 8: breaks);
  ρ₆₃ = (31 + 3i√7)/32 adjoins √7 (breaks); the Moser twist (5 + i√11)/6 and the distance-5 spindle
  (49 + 3i√11)/50 stay in K (never). The "forcing band" of detune angles registered at M31 was a
  category error — 0.6°–3.6° measured which spindle distances happen to be integers, and the true
  criterion is "4d² − 1 ≡ 7 (mod 8)", which every even integer d satisfies and no odd one does.
* **G15 / G16 / G17, explained.** The two acts are the two sides of the prime 𝔭: Act One (the distance-2
  pigeonhole on K-fabric) is the residue colouring's own arithmetic — 2 ∈ 𝔭, so the canonical
  4-colouring of K makes EVERY distance of positive 𝔭-adic valuation (2, 4, 2√3, 8/3, 8/√3, …)
  monochromatic, and no 4-colouring of a deep-enough fabric can avoid it (M33/M34, kernel); Act Two
  (the kill) must leave K because inside K there is nothing to kill with — Theorem 7.1: no K-point unit
  graph carries a pair compulsion at five colours. G16's sentence "the field wall is exactly the wall
  between the two acts" is now literally a theorem, and the transmuter's forced transfer at distance 2
  (M34) is the pigeonhole's 𝔭-adic face. M50's forced-equal pairs at 8/3 and 8/√3 — "radicands outside
  every owned field" — were the residue colouring showing through: those are distances of positive
  valuation, monochromatic by formula.
* **G19, sharpened.** 5-tight fabric does not exist inside K and cannot: every K-point unit graph is
  4-colourable, so no K-point region is 5-tight. 5-tightness needs a wall-breaking root in the fabric
  itself — Heule-510's field ℚ(√3, √5, √11) is the first place it can live, and the residue method's
  best bound there is 121 (the prime above 11), so nothing additive says whether that plane is exactly
  5-chromatic. The 6-hunt's Act One has its stage only past the wall.
* **G25, sharpened — the field ladder is 2-adic, and the residue method stops at 4.** Residue colourings
  give bounds that are powers of two (primes above 2) or perfect squares (primes above odd p, where the
  residue degree is 2): ℚ, ℚ(√2), ℚ(√10) are 2-colourable planes; ℚ(√3), ℚ(√5), ℚ(√11), K, K(√2), K(√35)
  are ≤ 4; the next additive bound anywhere useful is 16 or 121. So 5, 6 and 7 — the whole Hadwiger–Nelson
  interval — are invisible to additive colourings: the plane's answer lives in the non-additive regime,
  and the "wall between 5 and 6" the programme hunts has no residue-colouring analogue. The recursion
  "each level's kill is the previous level's forcer" is, at the 4 → 5 step, "each level's kill is a
  wall-breaking adjunction"; whether the 5 → 6 step has an arithmetic wall at all is open (the note's
  §8: is ℚ(√3, √5, √11)'s plane exactly 5?).
* **G32, sharpened — the dial cannot reach μ ≤ 1 inside K.** Theorem 7.1's corollaries: a K-point
  {1, 2}-graph forcing the pair has at least two distance-2 edges, and — the transversal obstruction —
  every independent set containing exactly one endpoint of each distance-2 edge must contain both A and
  B (recolour such a set with a fifth colour in the residue colouring and the pair separates). That is a
  purely combinatorial lower-bound instrument on the cheat set relative to the unit graph, free of any
  solver, and the first μ-bound that comes from arithmetic rather than from a census.
  **SHARPENED 2026-09-06 (the pivot):** μ = 1 is impossible not only inside K but inside every 5-sealed field — a rigid pair
  at five colours plus its spindle is a 6-chromatic unit-distance graph in the spindle's field, and K(√5), K(√247),
  K(√5, √247) are all 5-sealed; the dial's endgame lives only in a 6-open field (FS-7).
* **G33 / G34, resolved.** The compounding is real and the selection is structural — AND the selected
  material is the wrong material for the endgame. M53 measured the identity exactly (in-field = "≥ 3
  object neighbours" to seven points in 1.6 million; the in-field slice is 1 % of the pool because ladder
  points fuse C(k, 2) parent pairs) and then measured the trap: the in-field pool kills every class of a
  one-cheat batch and 95 % of a two-cheat stage's — and by theorem can never do the last kill. Growth
  compounds inside K toward a floor it cannot cross. The dial's fall from 446 to 149 is genuine and
  bounded below by the wall; only a wall-breaking adjunction lets it reach the crossing.
* **G30, a new instance — and its positive form.** The field wall was minted from measurement (G1, the
  witness anatomy), sharpened by measurement (G34, the pool census), REGISTERED as a conditional whose
  favourable branch ("keep only in-field points") was inductive, and then settled by derivation — the
  derivation-first column wins again, now 8-for-8 against the measurement-first column's 0-for-10. The
  positive lesson is about where the derivation came from: Kooshi's instruction to write the conjecture
  UP for a stranger forced its structural statement (the unit-distance graph on F² is the Cayley graph
  of the additive group F(i) with connection set the norm-one torus), and the classical tool
  (Woodall/Fischer additive colourings) became visible the moment the object was named. *Rule: before
  spending days of compute on a conjecture, write it for an outside reader in its native mathematical
  vocabulary; the write-up is a derivation attempt in disguise, and it is cheaper than one census.*
* **G36 — The residue colouring is the descent's canonical separating colouring, and it separates every
  forced pair at once.** [theorem + measured] On any K-point stage the residue colouring is proper on
  the unit part, monochromatic on every seed cheat (all 446 lie at distance 2), and separates A from B
  (distance 5 has valuation zero) — so it is a single 4-colouring that violates ALL the cheats: the
  hitting set of any class list must always hit it, and it is the colouring the culled object's 149
  cheats are all still killing. Every spectrum, floor census and cull verdict of the descent is, in part,
  a measurement of how far the object's OTHER separating colourings are from this one. Falsifier: a
  K-point stage on which the residue colouring fails properness — impossible by theorem, so the
  instrument (`tools/residue_colouring.py`) is a free regression control for every future object's
  geometry (a misplaced point shows as a monochromatic unit edge).
  **SHARPENED the same day (the residue obstruction, `~/field-wall-conjecture.md` §7.2–§7.4;
  `tools/residue_floor.py`).** The residue colouring plus a fifth colour on a vertex set S is a
  separating 5-colouring of `unit ∪ C′` iff S is an independent EXACT transversal of the cheats C′
  (one endpoint per cheat, no unit edge inside S, not both A and B) — a 2-SAT instance Σ(C′) on the
  seed vertices — and such a colouring extends to ANY finite set of K-points by the residue colouring
  itself. So no in-field halo, at any depth, can make C′ force when Σ(C′) is satisfiable: every
  in-field-reachable standing set has Σ UNSAT, i.e. contains an odd cycle of distance-2 pairs or a
  fully blocked side choice. Two cheats always admit a transversal (two points of K² at distance 2 from
  a common point are never unit-apart — that would need √15), so **μ ≥ 3 inside K**, with the three
  forming a distance-2 triangle or a collinear five-point blockade. MEASURED on the culled it-4
  object: the standing cheat graph has 24 components, 8 non-bipartite, shortest odd cycle 3, Σ UNSAT;
  0 of 149 single removals make Σ SAT; the two-cheat batch keeps all 8 odd components; 0 of the 3,936
  in-field survivors are residue-type (both primes) — every prediction met, no census needed to make
  them. The in-field loop is far from its residue floor and can never reach it anyway.
* **G37 — The endgame's shape is fixed: K-fabric plus one wall-breaking adjunction.** [theorem for the
  necessity; the classical constructions for sufficiency] Every published 5-chromatic unit-distance graph
  is K-fabric (or heptagonal fabric) plus a spindle rotation at an even distance, and Theorem 7.1 says
  the descent cannot do otherwise: its unit part becomes 5-chromatic only after a point outside K is
  committed, and the copy-detune construction at ρ₁₅ (M52's Q8 objects, 5-chromatic at once) is exactly
  that adjunction done in one move. So the loop's endgame is not "more in-field kills until the crossing
  happens" but "a wall-breaking commit, then the crossing, then the last kills in the enlarged field" —
  and the halt clause χ(unit) 4 → 5 fires only after the field census first records an out-of-field
  point. *Reading on top: the cheapest wall-breaking adjunction may be far smaller than a full copy — a
  single √5-class glue point (4,092 such pairs exist on the it-4 object) placed where the residue
  colouring is rigid; the new plan's first design question.*
  **MEASURED the same day (`tools/wall_break_test.py`, the exact 2-adic classifier the halt record
  asked for; self-test on 21 planted radicands green).** Over the it-4 object's 950,371 pairs at
  distance < 2 there are 1,435 radicands: 32 in-field (140,195 pairs); **5 wall-breaking alone
  (4,221 pairs, 0.44 %)** — the √5 class (4,092 pairs at distances 4/3 and 2√5/3) plus three others
  (129 pairs); 205 radicands (81,592 pairs) break at ONE 2-adic prime and need a partner; and
  **523,608 pairs are 2-adically square at both primes — useless in any combination**. The class
  structure has one explanation, now derived: every object point keeps the Exoo–Ismailescu shape
  (x ∈ √3·ℚ(√33), y ∈ ℚ(√33)), so every radicand lies in ℚ(√33) and is 2-adically rational; the
  square classes of ℚ₂ inside ℚ₂(√3) are exactly ⟨−1, 2⟩, and the census sees precisely those 16
  class pairs (𝔽₂-rank 4 of 8), the wall breaking iff −1 is generated at both primes. So the
  cheapest wall-breaking adjunction is a √5-class glue point (a pair at distance 4/3 — G4's
  "forced-pair radius" — or 2√5/3), and the endgame's pool at depth one is those ~8,000 points, or
  pairs from the one-prime classes (−1, 1) with (1, −1), (2, ·) with (−2, ·).
  **AND the fabric names its own wall-breaking angle (T20, same day).** The rigidity dial's
  valuation-6 forced pairs (163 of 178 at 8/3 on the it-4 unit part) are spindle-able: cos 119/128,
  sin 3√247/128, and 247 ≡ 7 (mod 8) breaks the wall as the theorem requires — U ∪ R(U) is a
  **5-chromatic unit-distance graph in ℚ(√3, √11, √247)** (3,905 points, direct 4-refusal,
  5-colourable control), a 5-forcer without √5 or √7. **CORRECTION 2026-09-09: this row read "the FIRST 5-forcer without √5 or √7" and that novelty claim is FALSE** — `[ExooIsmailescu2019]` (arXiv:1805.00157, Discrete Comput. Geom. 64) build a 5-chromatic graph in `ℚ[√3,√11,√247]` and say so, with the same spindle rotation `sin θ = 3√247/128`, in 2018. **A THIRD AND EARLIER SOURCE, 2026-09-09 (FS-23): `[Polymath16wiki]`, last edited 4 June 2018, records that `8/3` is monochromatic in the Moser spindle ring, names `ω_{64/9} = (119 + 3i√247)/128`, and states that spindling by it gives a ring with no 4-colouring — the whole forced-8/3-pair-then-spindle route, as a wiki paragraph.** **The mechanism claim stands untouched** — the forced-8/3-pair-then-spindle route, our 588-vertex 1-minimal forcing core and the 1,175-point witness are an independent construction, and T20's role in the argument (that K-fabric grown to 4-rigidity supplies its own wall-breaking angle) is unaffected. Only "first" is retracted. So a wall-breaking adjunction is not
  only an external detune (ρ₁₅) or a pool class: pure K-fabric, grown deep enough to be 4-rigid at
  its deepest 2-adic valuation, supplies the angle itself. The endgame's design principle, sharpened:
  grow 4-rigidity in K (cheap, in-field), read the forced distances off the dial, spindle.
  **SHARPENED 2026-09-06 (the finite-plane pivot, G43):** the adjunction must ALSO keep the field 6-open — the spindle's
  field F(√(4d² − 1)) must have no usable prime whose plane is ≤ 5-chromatic. The descent's own endgame spindle ρ₁₅ (d = 2,
  √15 ∼ √5) lands in K(√5), which is 5-SEALED (11 usable, χ(UD(𝔽₁₁,2)) = 5), and so does K(√247) (d = 8/3): every endgame
  the descent could have run was provably ≤ 5. The endgame's field must be wall-breaking AND 11-inert AND clear at 83, 107,
  131, … — over K the single radicals d = 7, 79, 127, … (FS-7 D3′), i.e. spindle distances with 4d² − 1 in those classes.
* **G38 — Three walls, and the arithmetic goes blind above four.** [theorem, hand-proved; T21] The
  residue method colours F² by a residue class modulo an additive subgroup avoiding the norm-one
  group. Its thresholds: 2 when the 2-adic wall stands with residue field 𝔽₂ (ℚ, ℚ(√2), ℚ(√10),
  ℚ(√17)); 3 when some prime above 3 has residue field 𝔽₃ (ℚ(√3), ℚ(√7), ℚ(√3, √7)); 4 when the
  2-adic wall stands with residue field 𝔽₄ (ℚ(√5), ℚ(√11), K); and then nothing below 7 (the next
  values are 7, 8, 9, 11, …). So χ ≥ 4 needs the 3-adic wall broken (no degree-one prime above 3),
  χ ≥ 5 needs the 2-adic wall broken as well, and χ ≥ 6 needs NOTHING MORE that residues can see:
  *the field of a 6-forcer is not arithmetically predictable by this theory.* What predicts it instead
  is the construction: a 6-forcer built as 5-rigid fabric plus a spindle at the distance d it forces
  equal at five colours lives in F(√(4d² − 1)); the five-colour dial names d. Consequence for
  Kooshi's question about 6-fields: look one level up the same ladder that produced K(√247) from
  K, not at the arithmetic. Falsifier: a 6-chromatic unit-distance graph in a field with a
  residue-𝔽₃ prime above 3 or with the 2-adic wall standing — impossible by theorem, so the only
  live falsifier is a NON-additive colouring beating χ_res somewhere, which would be a new
  colouring genre.
  **AMENDED AGAIN 2026-09-06 (the finite-plane pivot, G43): the gap at 5 is a theorem — 5 ≡ 1 (mod 4), so 𝔽₅ contains √−1,
  every prime above 5 splits in F(i), and no prime above 5 (or 13, 17, 29, …) is ever usable; the usable primes are exactly
  those with residue field 𝔽_q, q ≡ 3 (mod 4) — p ≡ 3 (mod 4) with odd residue degree — and "blind above four" was the
  linear reading: at such a prime the residue plane's own chromatic number bounds χ(F²), and it is 5 at p = 11.**
  **AMENDED 2026-09-06 (Fischer 1990 read, T23):** the framework is Fischer's *additive k-colouring* and the
  quadratic thresholds are his Theorems 8–10 — including χ(ℚ(√3)²) = χ(ℚ(√7)²) = 3, which T21 claimed; and
  the entry's "4 when the 2-adic wall stands with residue field 𝔽₄" is wrong when complex conjugation lies in
  INERTIA (ℚ(√N), N ≡ 5 mod 8: 2 inert with residue 𝔽₄, then ramified in ℚ(√N, i)) — there the reduced
  norm-one group is {1} and a line avoids it: those planes are BIPARTITE (his Theorem 8). The general rule:
  colour by cosets of an additive subgroup avoiding the REDUCED norm-one group, which is the norm-one group
  of the residue field over its conjugation-fixed subfield when conjugation acts nontrivially, and {±1}
  when it lies in inertia. What stays ours: the local criterion, the multiquadratic case, Theorem B's exact 4.
* **G39 — Redundancy before rigidity: a pair compulsion at χ colours lives only where the critical
  set lets it, and in the plane that is two points or none.** (M54, 2026-09-06; kernel-checked in
  `CriticalSet.lean`, measured on the seed, the witness, and the grown witness.) With C(G) the set of
  vertices whose deletion drops the chromatic number, a forced-equal pair at χ(G) colours has
  C(G) ⊆ N(p) ∩ N(q) and a virtual edge C(G) ⊆ N(p) ∪ N(q) — one recolouring (a critical vertex
  isolates any independent set through it) of which the spare-colour lemma is the case C = V. Two
  points of the plane have at most two common unit neighbours, so **a unit-distance graph that forces
  a pair equal at its own chromatic number has at most two critical vertices, and none if the pair is
  more than 2 apart.** Consequences: (i) the 6-forcer built as 5-rigid fabric plus a spindle at
  d > 2 needs fabric whose 5-chromaticity survives EVERY single vertex deletion — the dial's first
  rung is redundancy, not rigidity, and it costs one 4-colour ask per vertex; (ii) single-centre
  spindle unions read zero by theorem (the fused centre is critical); (iii) the criticality census
  SUBSUMES the exhaustive five-colour sweep whenever |C| > 2Δ — T21's 858-second sweep of the witness
  measured a theorem; (iv) every descent stage has C = ∅ (it forces a pair five apart), a free
  regression control. **[kernel + measured: the E–I seed C = ∅ (214/214); the 1,175-point witness
  VERTEX-CRITICAL (1,175/1,175, each certified by a colouring); the witness plus its F₂₄₇ cross pool
  loses three remote copy-side critical vertices; the full-fabric single-centre union C = F ∪ R(F) = 13 of
  3,905; two spindles on the full fabric C = ∅ (F₁ ∩ F₂ = ∅, 34/34 checked); the two-core union C = ∅
  (31/31 checked) and its complete five-colour sweep 0 / 0 in 31 s]** *Reading on top, falsifiable — and its first half is now MEASURED: the C = ∅ objects are still floppy, so
  the second obstruction, the absorption principle (each 4-colourable piece attached by outside-degree-one
  chords is coloured around by the spare colour), is the live one.**
  *[Splice repaired 2026-09-09 by the record audit: the 2026-09-06 amendment above was pasted into the middle of this
  reading, leaving a lower-case sentence start and no way to tell which clause "its first half is now MEASURED"
  governed. It governs the ABSORPTION sentence, not the one that follows. The original reading resumes here:]*
  Every 5-chromatic unit-distance graph built as "4-rigid fabric plus one spindle"
  is vertex-critical or nearly so, because the spindle is the only route to the fifth colour; the
  redundancy the theorem demands must come from MANY routes — many spindles at many centres, or
  fabric whose 5-chromaticity is carried the way K-fabric's 4-chromaticity is, by density rather than
  by one chord. Falsifier: a 5-chromatic unit-distance graph with C ≤ 2 that a pair sweep still
  reads floppy at five colours (then redundancy is necessary but the rigidity gap is elsewhere).*

* **G40 — Absorption: what a five-colour sweep cannot see, and why every star reads zero.** (M55,
  2026-09-06; kernel-checked in `Absorb.lean`, measured on five objects.) A vertex set A whose colourings all
  extend to the whole graph carries exactly the compulsions of its induced subgraph — none, when that
  subgraph has a spare colour. Every sufficient condition is one move (colour the piece, repaint the clashes
  with the spare colour), and its instances are the hunt's own constructions: a copy fused at one hub and
  coupled by a matching with independent endpoints; a vertex of degree ≤ k, and by iteration everything
  outside the (k+1)-core; a symmetric copy joined by ring chords, absorbed by a palette rotation at every
  k ≥ 2 — so a spindle forces only through its fused centre. **[kernel]** Measured: on every spindle union
  built here the copy hangs on its fabric by the centre's neighbourhood plus ONE chord (the spindle chord),
  so the base extends, ν ≤ the number of spindles, and ν = 2 exactly on the two-spindle objects; the
  single-centre flower has a critical centre at every depth and, where the theorem does not absorb it
  (K ≥ 2: consecutive petals with the fused centre are a rotated witness), the localization theorem leaves
  its sweep only the centre's neighbourhood — 0 / 0 in seconds. **[measured]** *The consequence for the
  6-hunt: neither more spindles nor more centres can create a compulsion; a compulsion at five colours needs
  material with no absorbable piece — every large 4-colourable sub-piece attached by a hub-and-matching is
  invisible, and by Theorem B every K-coset piece is 4-colourable — so the object must be THICK in the
  wall-breaking field (F₂₄₇ here), which is exactly what the cross thickening begins to build, and the one
  construction that moved the redundancy dial (238 critical vertices freed at depth two, all on the copy
  side: T24). Reading on top, falsifiable: the copy-side asymmetry is the rotation's direction against the
  fabric's ladder structure (T13), and thickening both cosets symmetrically will free both sides. Falsifier
  for the theorem: none needed; for the reading, a depth-three census freeing core-side vertices, or a
  symmetric thickening that does not.*

* **G41 — AMENDED 2026-09-09 (FS-25 item E5): the additive localization has a FLOOR, it is Fischer's own
  obstruction read as a bound on what the family can DISTINGUISH, and the exponent refinement is
  what reconciles it with the valuation law.** An additive colouring is a homomorphism `φ : Λ → G`
  with `|G| = k`; since `k · G = 0`, `kΛ ⊆ ker φ`. **That much is `[Fischer1990]`'s central
  obstruction** — verified in our own copy, where he uses `k · v(1/k) = v(1) ≠ 0` against `k · G = 0`
  at least three times — **and is restated on the `[Polymath16wiki]` (2018) as "a linear `k`-coloring
  is always periodic with period `k`", and used live in the 2018 blog threads at `k = 5, d = 5/3` and
  at `k = 4, d = 8/3`; no novelty is claimed for it.** What this repository adds is the *sharper*
  form its own kernel already carries (`Additive.addMonoidHom_apply_eq_of_sub_eq_exponent_nsmul`):
  the bound is the **exponent**, not the order, so a non-cyclic target sees one level further. At
  four colours `G` is `ℤ/4` or `ℤ/2 × ℤ/2`, so **`4Λ ⊆ F_add` for every object over every field: no
  additive four-colouring can ever separate a pair of 2-adic depth `≥ 2`.** Three consequences. (i) `T26`'s measured `F_add = {depth ≥ 2}` on
  `K`-fabric is the floor **attained**, not a property of that object — the six `ℤ/4` colourings are
  needed only for the reverse containment, which the artifact confirms (all 12,906 depth-1 pairs
  separated additively). (ii) **The valuation law of ledger row 59 is the exponent-2 member of this
  same family** — the residue colouring's target is the additive group of `𝔽₄`, exponent 2, so it
  sees only `2Λ`, i.e. depth `≥ 1` — and the one level between the two necessary conditions is
  exactly that exponent gap, structural rather than an artefact. (iii) The 16-pair residue sits at
  depth 3, where **every** additive four-colouring is blind by theorem, so `T26`'s question about it
  is a question about the reconfiguration graph and no arithmetic in this family can answer it.
  The general form is free: at `k` colours the floor is `kΛ`, which is exactly what
  `AdditiveRigid.forces_of_additivelyRigid` consumes at five — M56 and M57 use one lemma from
  opposite sides. `plans/FS25-P2.md` §3.

* **G41 — AMENDED 2026-09-08 (FS-18): the obstruction half is Fischer's.** The `1/k ∈ Σ₀` argument this entry and M56's L7 rest on is [Fischer1990]'s Theorem 10(ii) — a norm-one `ξ` has `ξ + ξ̄ ∈ Σ₀`, so `1/k ∈ Σ₀`, so no additive `k`-colouring exists — and his Example 4 (`N = 167`) already draws G38's conclusion in 1990. What stays ours: the spindle-rotation instantiation, the tie to the 2-adic wall, the chunk theory, the Kempe localization, and the seed reading. See ledger row 50's correction. Original text follows.

* **G41 (original) — Tightness is arithmetic exactly once: additive colourings bound where a compulsion can live, and on
  the Exoo–Ismailescu seed the bound is the truth.** (M56, 2026-09-06; kernel for the bound, measured for the rest.)
  A homomorphism of a chunk's lattice into a group of order k, nonzero on the edge vectors, is a proper colouring, so
  F_true ⊆ F_add := the pairs every such hom identifies — a solver-free localization with the hom itself as the
  certificate for every pair outside it (M54's critical-set theorem's genre, one direction only) — and every
  difference in kΛ lies in F_add; the Kempe swaps of the additive colourings sharpen it to F_true ⊆ F_K.
  **[kernel + measured]** On K-fabric at four colours the yardstick over-forces exactly at 2-adic depth 2 and F_K
  closes the gap to 16 pairs; at five colours on the seed F_add IS the forced pair, 18 of 35 colourings are
  additive and the paper's G is entirely additive; on the 5-chromatic witnesses no additive 4-colouring exists (L8:
  the spindle chord lies in 4Λ) and the additive 5-colourings' forced pairs are all separated by non-additive
  ones. *Readings on top, falsifiable: (a) the seed's near-additivity is what makes it RIGID (35 colourings), and
  the witnesses' floppiness is the same fact from the other side — a chunk whose colouring space is far from its
  additive family has room for non-additive separators; falsifier: a 5-chromatic chunk whose sampled colourings
  sit near its additive family and are still floppy. (b) The 16-pair residue on U is either two Kempe swaps away
  or carried by colourings outside the Kempe classes of the eight additive ones — decidable on U by a Kempe-graph
  walk. (c) Since 1/5 ∈ Σ₀ of every plane, every plane's rich chunks eventually lose their ℤ/5-homs; the richness
  at which the 1581 or Heule's field does is a dial nobody has turned. Composes with G38 (additive bounds stop at
  four: at five the theory can only localize), G35 (Fischer's 1/k obstruction is the wall), G39/G40 (three
  localizations now: the critical set, absorption, the additive family).*

* **G42 — Rigidity is closure, its gauge is solver-free, and the family dies before it closes.** (M57, 2026-09-06;
  kernel for the reduction, derivation for the closure condition, measured everywhere else.) The additive family of a
  chunk sits in its colouring space, which carries moves — single-vertex recolourings and Kempe swaps — and the family
  is the whole space (additively rigid: every 5Λ-pair forced, the reduction theorem in the kernel) only if no move leaves
  it: every {a, b}-subgraph of every admissible hom connected, measured by γ = Σ (components − 1), a lattice-and-BFS
  census with no colouring enumerated; a loose vertex (neighbours missing a colour) is the size-1 case. Exoo–Ismailescu's
  G has γ = 0 with its cheats and is exactly rigid; every unit-distance object we hold is open by orders of magnitude
  (K-chunks at four colours by rank — one ζ₆-orbit of directions per residue — and the witnesses at five with a fifth of
  their vertices loose in every additive colouring). And the closure cannot be bought by thickening: W's 63 depth-one
  cross points make 500 of its unit vectors 5-divisible in the joint lattice, so the thickened stage has no ℤ/5-hom at
  all — Fischer's 1/5 ∈ Σ₀ (L7) arriving at depth one — while each such point alone kills non-additive colourings by
  coverage and never an additive one. **[kernel + derived + measured]** *Readings on top, falsifiable: (a) the two
  requirements of the principle — a nonzero family and a closed one — pull apart on every construction in F₂₄₇ and K:
  in-field material keeps the family (in-lattice points) but K-unit parts are 4-colourable, and wall-broken thickening
  erases it; a field and construction keeping a family while adding directions is the only place the principle could
  bite — and de Grey's half-spindle closure IS one: its whole 24,065-point gen-1 closure (358 directions, rank 32, no unit
  in 5Λ) keeps ≥ 300 ℤ/5-homs, where W's 63 cross points killed every one — a crystal thickens 5-indivisibly, a cross
  lattice does not (FS-6's first datum). (b) Forcing does not need rigidity: the seed's 252-cheat
  forcing subset holds the pair with > 5,000 colourings, two thirds far from the family — so whatever carries forcing on
  such objects is a property of the reconfiguration graph's components, not of the additive family (FS-2's question,
  re-aimed). Falsifiers: a unit-distance chunk in a wall-broken field with γ = 0 and a nonzero family; a thickening whose
  joint lattice stays 5-indivisible. Composes with G41 (the yardstick), G38 (additive bounds stop at four), G40 (thin
  material absorbed — here, thin material either does nothing to γ or kills the family).*

* **G43 — The residue plane has its own chromatic number, and it seals fields.** (The pivot of 2026-09-06; hand proof +
  verified measurement, kernel pending — **and the gate is one named lemma, the same one G35 now names: the residue
  field of size `N(𝔭)` at a conjugation-fixed prime of a number field. Everything else in the chain is kernel.**)
  Every linear instrument — additive colourings, the fractional number, density,
  Hoffman — is blind to the 5–7 interval by construction (χ_f(ℝ²) ≤ 4.36; the residue method's values jump 4 → 7), and the
  step past it was already in Theorem B's own proof: the residue map at a degree-one prime above p ≡ 3 (mod 4) is a graph
  homomorphism into the finite Euclidean plane UD(𝔽_p, 2), whose chromatic number is NOT linear — 5 at p = 11 where the
  linear bound is 11. So χ(F²) ≤ χ(UD(𝔽_p, 2)) for every usable p, and the arithmetic that sees 5 is "which primes are
  usable in F" (Legendre symbols, for multiquadratic fields) composed with "the chromatic number of a finite plane" (one
  SAT call each, exact, kernel-promotable as a colouring plus a homomorphism). **[hand proof + measured]** *Consequences,
  exact: every field the descent ever used is 5-sealed (11 is usable in K, K(√5), K(√247), Heule's); a field is 6-open only
  if its smallest usable prime's plane refuses five colours — de Grey's (131), K(√7) (83), K(√35) (107) are the candidates;
  and the profile of a 6-hosting field is now: the 2-adic wall broken (Theorem B) AND no degree-one prime above any p ≡ 3
  (mod 4) whose plane is ≤ 5-chromatic. Readings on top, falsifiable: (a) 11 is the last 5-sealing prime (P4 of FS-7);
  then "6-open" for multiquadratic fields is exactly "some radicand is a non-residue mod 11"; (b) the 𝔭-adic pullbacks are
  the constructive wild colourings the upper-bound theorems (Townsend, Coulson, Thomassen) say a 6-colouring of ℝ² would have
  to be — field by field, never gluing across fields; (c) Haugland's heptagonal field is 7-sealed unless his detuning
  adjoins a 7-inert radical (FS-8); (d) the SHADOW sieve — an object's unit directions reduce to a subset D of the circle,
  and χ(Cay(𝔽_p², D)) seals every graph built from those directions: the 1581's 67 directions cover 55 of the 66 residue
  pairs at 131 while its gen-1 closure covers all 66 (FS-7 D7, T34) — a design vocabulary for 6-forcers computed without
  geometry. One correction to the analysis, derived: K(√35) is 11-inert but does NOT break the 2-adic wall (its odd square
  classes are ≡ 1, 3 mod 8), so χ(K(√35)²) = 4 by Theorem B — the candidate single radicals over K are d = 7, 79, 127, …
  (d ≡ 7 mod 8 and a non-residue mod 11), not 35. Composes with G35/G38 (the walls at 2 and 3 are the p = 2, 3 faces of one mechanism,
  and "blind above four" was the linear reading), G42 (de Grey's field is the one place both the family and the 6-option
  survive).*
  **AMENDED 2026-09-08 (prior art): the reduction — "the residue map at a degree-one prime above `p ≡ 3 (mod 4)` is a graph homomorphism into `UD(𝔽_p, 2)`, so `χ(F²) ≤ χ(UD(𝔽_p,2))`" — is [Moorhouse2010] §8.2 and §10.3, with this proof, and `χ(UD(𝔽₁₁,2)) = 5` is his Table 6.1. The GROKKING stands unchanged as the project's understanding; its novelty does not. What is not in him: the sieve (which fields are 6-open, as a congruence), the kernel certificates, the shadow floors, and everything downstream at M59–M61. His §9 adds a sharpening we did not have: a composite ideal cannot beat the minimum over primes without refuting HEDETNIEMI'S CONJECTURE — so "the linear method's best bound is at a prime" is not a convenience, it is tied to a famous open problem.** **AMENDED at M58 (2026-09-06): reading (a) is REFUTED as stated and REPLACED by a theorem.** 19 is a 5-sealing prime (χ(UD(𝔽₁₉,2)) = 5,
  measured), so 11 is not the last one in general — but 19, 23, 31, 43, 47 are never usable for a field containing √3 and √11, and every
  prime from 59 up has a plane ≥ 6-chromatic BY ITS SPECTRUM (G44), so for F ⊇ K the only sealing prime is 11 and "6-open ⟺ wall broken ∧
  11 inert" is exact. The kernel now holds χ(UD(𝔽₁₁,2)) = 5 (no solver) and the reduction as a theorem over any ring; the candidate radicals
  over K are the odd squarefree d ≡ 5 or 7 (mod 8) that are non-residues mod 11 (13 joins 7, 79, 127). Reading (d) gained its instrument
  (`fplane.py shadow`) and its first floors (the 1581's shadow at 131: 4.96 — five colours undecided); FS-11 is the constructive reading
  the analysis gestured at, made precise: a lifted 6-critical subgraph of a finite plane IS a 6-chromatic unit-distance graph.

* **G44 — AMENDED 2026-09-08 (FS-18): the `ω` side and the `ω`-versus-`χ` side are both published.** [Vinh2006] proves **`ω(UD(𝔽_q,2)) ≤ 4` for every `q`** (from his circle-intersection lemma) and **`D_q` triangle-free iff `q ≡ ±7 mod 12`**; [SchneiderSilva2013] Theorem 4.7(3) proves **`ω ≠ χ` on every finite Euclidean plane above `p = 3`** (`ω = χ ⟺ m ∣ p+1`, and ours has `m = p−1`), rigorously and without the erroneous spectral bound Vinh's own Theorem 4 leans on. So the `χ`-versus-`ω` gap this entry treats as the programme's subject is a settled fact in the literature — the clique number itself has a **closed form** — `ω(UD(𝔽_q,2)) = 3` iff `char = 3` or 3 is a square, else 2, from `[Krebs2022]` via `[LorenzZimmermann2023]`, agreeing with all six values we hold — and what is NOT settled anywhere, and stays the live question, is **how big the gap is**, i.e. the exact chromatic numbers. Our exact threshold (every plane from 59 up refuses five), the kernel values at 11 and 19, and the sieve are untouched. Original text follows.

* **G44 (original) — The finite planes are Kloosterman-controlled, so the sieve's whole power lives at small primes, and a field's 6-openness
  is a congruence.** (M58, 2026-09-06; derived, then measured to 10⁻¹³.) The eigenvalues of UD(𝔽_p, 2) are minus the Kloosterman sums
  K(1, c/4), one per norm class; Weil bounds them by 2√p and Hoffman turns that into χ ≥ 1 + (p+1)/(2√p), which exceeds 5 from p = 62 —
  so **no prime above 47 can ever seal a field at 5, the sieve decides fields with its four or five smallest usable primes, and for
  fields over K it is the single prime 11.** The planes' true values sit well above the floor (5 against 3.5 at 11; 5 against 3.6 at
  19), so the floor never decides a small plane and always decides a large one: the two regimes are exactly "a SAT question" and "a
  theorem", with the boundary at 59. **[derived + measured: `data/fplane/spectral-below-600.json`]** **AMENDED 2026-09-08: [Moorhouse2010] §6 GUESSES that `χ(𝔽_q²) → ∞` and his Table 6.1 computes the small values (3, 4, 3, 5 at q = 3, 7, 9, 11; 13 left at {5,6}, 17 at {5,6,7}, both open in 2010 — we settled 13 without knowing, and 17 is still open and untouched here). The guess was already settled by [Vinh2005]'s asymptotic five years earlier, which he does not cite; the exact threshold (every plane from 59 up refuses five) is ours. And [Krebs2022] determines the CLIQUE numbers of these graphs completely — every finite field, every dimension — and bounds their chromatic numbers with conditions for `χ > ω`, which is this grokking's own subject and was not read.** *Consequences: (i) the descent's
  endgame field, the copy trick's field, any field a construction adjoins, is checked by a Legendre symbol at 11 and a square-class
  congruence mod 8 before a solver runs — the field-selection instrument the pivot promised, now a two-line test (`fplane.py map`);
  (ii) the finite planes from 59 up are ≥ 6-chromatic objects whose 6-critical subgraphs are computable without geometry, and each is
  a candidate template for a 6-forcer if it lifts (FS-11); (iii) the shadow sieve inherits the same instrument — a direction set D
  has a spectral floor 1 + |D|/(−λ_min(D)), read before any SAT. Readings on top, falsifiable: (a) χ(UD(𝔽_p,2)) − Hoffman(p) stays
  bounded, so the planes are within a constant of their spectral floor (T38 — refuted if 23 or 47 turns out far above 5); (b) no
  6-critical subgraph of UD(𝔽₁₃₁,2) passes the local lift test into de Grey's field (FS-11 P2). Composes with G43 (the residue plane's
  own chromatic number) and G35/G38 (the walls at 2 and 3 are the p = 2, 3 faces of the same sieve).*

* **G45 — A residue configuration lifts only if it is a shadow: the lift is first-order rigidity, its primes are the unramified
  ones, and the finite plane is an enumerator, not a designer.** (M59, 2026-09-06; kernel for the obstruction, derivation for the
  dichotomy, measured on the 1581 and Heule-510.) Modulo p² a subgraph H of UD(𝔽_p, 2) lifts iff its defect (the edges' failure to be
  unit modulo p², one number per edge) pairs to zero with every self-stress of the residue framework — the rigidity matrix's left
  kernel — and that is a theorem in any ring with a square-zero element, so the Hensel tower is one statement repeated
  (`stressPairing_eq_zero_of_lift`). A 6-critical H has ≥ |V|/2 + 3 such conditions and no reason to satisfy them: the plane's
  6-forcing is Kloosterman-carried and made of edges unit modulo p only. For a framework rigid at its residues, a Laman basis lifts
  uniquely up to isometry and a lift that passes every edge is algebraic, in a field with an unramified degree-one prime above p —
  which is why the 1581 is recovered from its residues at 131 to twenty digits, its merged image (34 collisions identified) is
  refuted by a 48-edge stress the kernel decides, and the plane's own 5-critical cores at 11 and 19 by a 12-edge and a 29-edge one, and why at 11 — RAMIFIED in ℚ(√11) — the spindle and Heule-510 are rightly obstructed:
  the sealing prime of a field is never a lifting prime of it. **[kernel + derived + measured]** *Consequences: (a) "design in the
  finite plane, lift to the field" is closed as a route to a 6-forcer; what the finite plane does for the hunt is FILTER (the level-p²
  test on any residue configuration, in seconds) and ENUMERATE — the hub scan lifts each pair's glue point in a residue class and
  counts the vertices it fits, listing every exact point at unit distance from ≥ 3 vertices of an object over all fields with an
  unramified degree-one prime above p at once: 3,739 for the 1581 (support to 13, none in its half-spindle closure), 1,171 for
  Heule-510 (eleven of them Heule-553's discarded vertices) — the witnesses are shrunk pieces of larger configurations the plane sees
  whole; (b) a Hoffman-carried refusal is not a CDCL-sized one (the 131 plane at five colours, undecided in an hour; the 55-direction
  shadow, undecided at three), so the finite planes' 6-critical cores are autopsy objects (FS-13), reachable by cube-and-conquer if at
  all. Readings on top, falsifiable: (i) no 6-critical subgraph of any finite plane is a shadow (the count says a random one is not;
  a structured one would be a real 6-forcer's image and would come from the field side first); (ii) among an object's hubs, the ones
  whose support is forced rainbow at five colours are its kills (A1), decidable on the object without the point (FS-12's D1).
  Composes with G43/G44 (the sieve's two faces), G37 (the endgame's adjunction — now enumerable), G32 (the dial's material: hubs, not
  glue points of pairs).*

* **G46 — The rule the finite-plane milestones taught, and its corollary for choosing work.** (Minted 2026-09-07 on Kooshi's
  direction, from the two milestones that ran under the frontier-set discipline; a methodological invariant in G21/G30's
  lineage.) M58 and M59 were each stubbed as half derivation, half object search, and in both the object half either became
  unnecessary or failed while the derivation half delivered: M58's planned solver runs on the big planes were settled by a
  classical spectral bound before they ran, and the small planes it left to the solver never returned; M59's planned search
  for 6-critical cores failed (a spectral refusal is not a CDCL-sized one) while classical rigidity theory settled the lift
  question before any core existed, and the instrument's real product was an enumerator. What did the work both times was
  RECOGNITION: the finite planes are Cayley graphs of an abelian group, so their spectra are character sums (Kloosterman);
  a residue configuration is a framework over a ring, so its lifts are first-order rigidity (Hensel, self-stresses). **The
  rule: name the object in the vocabulary of the classical theory it already belongs to, and let that theory decide the
  question's shape — possible, impossible, where — before any search runs; the search's role shrinks to producing the
  instances the derivation predicts.** This is G30's "derivation kills, measurement generates" with its missing step made
  explicit — the derivation comes from recognizing WHICH discipline's theorem the measured wall is (Kooshi's ladder of
  disciplines, under G30) — and the measurements that mattered were the controls that corrected the derivation's SCOPE
  (ω = 3 iff p ≡ 11 mod 12; the lift's primes are the unramified ones), not the searches. **The corollary for ranking the
  frontier set: prefer a stub whose question becomes a finite exact computation plus a named theorem over a stub that
  searches for an object; treat a stub with no such recognition yet (the topological and Nullstellensatz rooms) as a reading
  room rather than a milestone until one appears; and read a search's failure as information about the search's genre, not
  about the objects.** Applied at the M59 close: FS-14 (a 121-vertex computation plus a homomorphism argument) over FS-6 (an
  object search); and the broad question the two milestones point at — every upper bound we hold is local at one prime and
  every forcer hides from every small prime — minted as the local–global tightness conjecture (FS-15,
  `plans/M61-local-global-tightness.md`): χ(F²) equals its best local bound wherever that bound is ≤ 6 (attained at all six
  fields where χ is known, twice predicted before the forcer was built), whose first digit is "is any finite Euclidean plane
  exactly 6-chromatic" and whose bold form is χ(ℝ²) = 7. **[the rule: the project's own record, two milestones; the
  conjecture: six instances, no counterexample, stated to be pushed back on]** **AMENDED 2026-09-08 (G49): the rule
  is half a rule. Recognition names the discipline; it does not tell you whether that discipline has
  already answered the question, and in four milestones running here it had. The recognition step's
  own sentence is the search query — use it as one.** *Falsifier for the rule: a frontier milestone
  whose object search delivers what no recognition predicted — then the corollary's ranking is wrong for that genre. Falsifier
  for the conjecture: a wall-broken, 5-sealed field whose plane is 4-colourable by a colouring local at no prime.*

* **G47 — The compulsion face of sealing: a sealing plane has no pair compulsion of its own, compulsions map forward, so over a sealed
  field every pair compulsion is a congruence on the distance.** (M60, 2026-09-07; kernel at 11, measured at 3, 7, 11, 19.) A graph
  with a homomorphism into a graph `P` inherits `P`'s colourings, so its forced pairs are forced at their images and its virtual edges
  are virtual edges at their images — `Forces.comap` read forward. On a Cayley graph the translations reduce every compulsion to the
  origin, and one colouring refutes an origin compulsion: `d` forced needs `d` a period of every colouring, `d` separated needs `d`
  never-coincident in every colouring. The certified 5-colouring of `UD(𝔽₁₁,2)` has no period and coincides at every off-circle
  difference, so the sealing plane's forced pairs are the diagonal and its virtual edges are its edges **[kernel]**; the same at 3, 7 and
  19 by verified colourings, and at 11 no arity-3 compulsion either (floor in `{4, 5}`) **[measured]**. Composed with the distance law
  (the quadrance of a drawn difference is the residue of the squared distance): over a field where 11 is usable, **forced-equal at five
  colours ⟹ `11 | d²`, virtual edge ⟹ `d² ≡ 1 (mod 11)`** — so `√3` and `2`, the two distances `χ(ℝ²) ≥ 6` needs, carry neither, one
  gadget at a time **[kernel for `√7`-free tower certificates]**. *Consequences: (a) "sealed" is now a statement about single gadgets,
  not only about χ — the 6-forcer's field must be 6-open for the reason the 5-forcer's had to break the wall at 2: the sealing plane's
  colourings are too free to force anything (T17 was this at the prime above 2, where the freedom is a spare colour; at 11 it is the
  richness of a 5-chromatic plane's colouring space); (b) the descent was residue-blocked at every field it used — a cheat at distance 2
  can never be a five-colour virtual edge over K, K(√5), K(√247) or Heule's field, nor the seed's pair at 5 forced; (c) every five-colour
  ask over a sealed field is residue-screened first, with a verified colouring when it fails (35 of M55's 86 undecided asks); (d) the
  residue-ALLOWED distances (`d² ≡ 1`: `2√3`, `8/3`, `√23`, `√34`, `3√5`, `10`, …) are the design vocabulary for any five-colour virtual
  edge over a sealed field. Readings on top: (i) **PROMOTED TO [kernel] 2026-09-09 in its FORCED-PAIR half, and generalized past the four instances that suggested it**
  — `PlaneRotation.finitePlane_forces_iff` proves that at every prime `p ≡ 3 (mod 4)`, at every colour count the plane admits, no two
  distinct points are forced to share a colour; the four measurements at 3, 7, 11, 19 are now corollaries
  (`Instances/PlaneFreedom.lean`). The registered falsifier is retired on that half: no plane at any prime can carry a forced pair,
  whatever its chromatic number, so long as it is colourable at all. **The VIRTUAL-EDGE half is untouched and keeps its falsifier**:
  whether every non-unit class is separated by some proper colouring (`Separated`/`CoincidesAtNonedges`) is a different property of a
  colouring table and is not proved here at any prime beyond the four. **And a boundary the four instances hid**: the theorem covers
  prime fields only — over `𝔽_{p^n}` with `n > 1` the argument's basis step fails, because an additive subgroup there is a subspace
  over the *prime* field and two vectors span only two of its `2n` dimensions. (ii) the concentration of M55's theorem-admitted
  candidates at residue norm 1 (51 of 86) is structural, not chance (T44; FS-16's D1). Composes with G43/G44 (the sieve's chromatic
  face), G39/G40 (three localizations of a compulsion: the critical set, absorption, and now the residue), G31 (the sealing plane is as
  floppy as the witness at its top rung), G46 (the third milestone whose search only produced the derivation's instances).*

* **G48 — Tightness has a mechanism: the spindle over a forced pair removes exactly the prime that sealed the fabric.** (M61, 2026-09-08;
  kernel for the ring-level composition, hand for the residue degrees, measured on every attained row.) Over a field sealed at `k` by a
  usable prime `𝔭` whose plane is pairwise free at `k`, a pair forced equal at `k` colours has `𝔭 ∣ d²` (G47); the spindle over it — the
  only known way to buy the `(k+1)`-th colour from a forced pair — adjoins `√(4d² − 1)`, and `4d² − 1 ≡ −1 (mod 𝔭)`, so every prime of
  the spindled graph's field above `p` has `√−1` in its residue field and `p` is no longer usable. **The local bound is attained one level
  up because the forcer's construction deletes precisely the local bound it beats** — the Moser spindle's `√11` kills 3 (`11 = 4·3 − 1`),
  de Grey's `√15` and T20's `√247` kill 2, and a five-colour forced pair over Heule's field (necessarily at `11 ∣ d²`) would kill 11 with
  `√43`, `√131`, `5√7`, `√10`, … — landing, without any choice, in a field that is 6-open (wall broken, 11 inert, every usable prime ≥ 67).
  **[kernel: `Forces.isEmpty_ringHom_of_spindle_radicand` — no reduction of the coordinate ring at `p`; hand: the residue degrees;
  measured: every row of the tightness table]** *Consequences: (a) the local–global conjecture's mechanism half (its derivation (c)) is
  done, and its 6-level is ONE question — whether any 5-sealed field's fabric forces a pair equal at five colours — which is G19's
  "5-tight fabric" with the pair's distances named by residue; (b) the hunt's design target is therefore in a SEALED field, not a 6-open
  one: build 5-rigidity where the plane at 11 already caps χ at 5, read the forced distance, spindle — the field jumps by itself, as it
  did from K to K(√5) and K(√247); (c) the first digit — is any finite plane exactly 6-chromatic — is decoupled from the mechanism: the
  planes' chromatic numbers are integrality-carried (ϑ = Hoffman, no periodic or symmetric shortcut from 23 on), a SAT question with the
  real plane's own pathology. Readings on top, falsifiable: (i) every forced pair at five colours over a 5-sealed field lies at a distance
  with `11 ∣ d²` AND its spindle is a 6-forcer — the first half is G47's theorem, the second the spindle theorem; the reading is that such
  a pair EXISTS (T1 at the 6-level), falsified by a proof that every 5-colourable-plane-sealed field's unit graphs are pairwise free at
  five colours; (ii) the sealing planes' 5-colourings lose all rotational symmetry by 23 (the half-turn with a double swap the last
  survivor) — falsified by a symmetric 5-colouring at 23 or beyond. Composes with G47 (the compulsion face), G43/G44 (the sieve), G37 (the
  endgame's adjunction, now derived rather than observed), G46 (the fourth milestone whose search produced only the derivation's instances,
  and whose one failed search — the first digit — failed for a reason the derivation names).*

* **G49 — Recognition is half the rule; the other half is a search, and this project ran four
  milestones on the first half alone.** (Minted 2026-09-08, from the prior-art check that followed the
  Theorem A close; the lineage is G21 → G30 → G46, and this is the entry those three were missing.)
  G46 says: name the object in the vocabulary of the classical theory it belongs to, and let that
  theory decide the question's shape before any search runs. **That rule was followed and it was not
  enough.** M58 named the finite planes as Cayley graphs of an abelian group and used Kloosterman
  sums; M59 named the lift as first-order rigidity and used Laman and Hensel; M61 named the plane
  arc-transitive and used Lovász. Every recognition was correct. **And nobody searched for who else
  had recognized the same thing.** The result: `[Moorhouse2010]` — a public, indexed, unpublished
  draft — contains M58's finite-plane bound (§8.2, §10.3), M58's `χ(𝔽₁₁²) = 5` (Table 6.1), M58's
  ring-generic plane (§1), M61's Cayley-hom lemma (§4.2), the `𝔭`-integrality M58 left as a hand step
  (Lemma 2.3), and the Hedetniemi tie for composite ideals (§9). `[Fischer1990]` — held and read
  since M56 — contains the component lemma and the unit argument. `[CervantesKrebs2023]` — **listed
  unread in our own bibliography for two days** — systematizes M61's periodic quotient.
  **[measured: the project's own record against three papers]**
  *Three mechanisms, and only the third is about diligence.* **(a) The check ran at the close, where
  it can only assign credit.** Run at the opening it changes what the milestone is *for*: M58 knowing
  §10.3 would have opened as "formalize a known bound and push past it", and the sieve, the lift and
  the tightness mechanism — which are ours — would have been the headline from day one. **(b) The
  check searched in this project's coined vocabulary.** "Finite-plane bound", "field wall",
  "5-sealed", "residue obstruction" appear in no paper; *"chromatic number of planes over fields"*
  found it in one query. **A private vocabulary is an excellent instrument for thinking and a perfect
  filter against finding out you are not first** — and this project mints vocabulary faster than
  almost anything else it does. **(c) The check searched one literature when the object sits in two.**
  Moorhouse is finite geometry and off arXiv; Vinh is additive combinatorics; **neither cites the
  other**, and this project's pivot was exactly the bridge between them. Searching either alone finds
  nothing — which is also the honest explanation of why four milestones of reconstruction felt like
  discovery: *the gap was real, and it was a gap between literatures, not in them.*
  *The rule this yields, and it is now `WORKFLOW.md` step 3a: a prior-art gate at a milestone's
  OPENING, before any derivation — name the object in the discipline's words and search THOSE; search
  under at least two disciplines for the same object (Kooshi's ladder under G30 already names which
  two rooms a wall sits between); search for the QUESTION and not only the method; and look outside
  arXiv. Thirty minutes, output a §PA section of the subplan.* And sell it as **aiming** rather than
  as novelty protection, or it will be skipped: it hands over free theorems (§9's Hedetniemi tie,
  Lemma 2.3, Table 6.1 — all re-derived here at cost), and it finds **open questions** — Moorhouse §1
  states "We have not determined the exact value of χ(K²)" for `ℚ(√3,√11)`, which is Theorem B, and
  the whole arc missed that it was answering a posed problem. *Falsifier: three milestones running
  whose gate changes nothing about their scope — then the cost is not buying anything and the gate
  should be a close-time check after all. Composes with G21 (a search's negative measures its
  enumeration — here the enumeration was the vocabulary), G30 (measurement generates, derivation
  kills — and a literature search is the cheapest derivation available), and G46 (whose recognition
  step supplies the search query for free).*

  **CONFIRMED AND SHARPENED BY FS-18 (2026-09-08, the library read).** The falsifier did not fire — one day of
  reading produced five further corrections, discharged a conditional the record had carried for four weeks, and
  moved the frontier ranking, which was the registered measure of success. **Two of the three mechanisms were
  measured again and both held.** The two-literatures mechanism (c) is now measured rather than argued: **the same
  open problem was posted three times by three groups who do not cite one another** — Benda–Perles (circulated
  1976, published 2000), Moorhouse (2010), Cranston–Rabern (2015) — and this project answered it knowing none of
  them; and a scan of eleven papers found **zero citations of Moorhouse, Vinh, Medrano–Myers–Stark–Terras or
  Krebs across all eleven**, which is evidence *for* the two-literatures explanation rather than an excuse for
  it. The vocabulary mechanism (b) held too: `[Vinh2006]`, the closest published paper to M58–M61's objects, was
  found by searching *"colouring problems for unit-quadrance graphs"* — the discipline's own phrase — and had
  never surfaced under ours.

  **AND ON 2026-09-09 (FS-23) THE THESIS STOPPED BEING AN ARGUMENT AND BECAME A MEASUREMENT.** All eighteen
  Polymath16 threads — **1,673,859 characters, April 2018 to January 2026**, the community that works on this
  exact problem with this exact field — were searched. **"Fischer": 0. "Moorhouse": 0. "Vinh": 0.**
  "Madore" appears in one thread, "Woodall" in four. These are the people who would most have benefited:
  on **2 May 2018** one of them wrote *"Madore proved that `ℚ[√3,√11] × ℚ[√3,√11]` can be 5-colored. As Dustin
  asked in one of his posts, it would be nice to decide if the chromatic number of this subfield is 5"* — the
  question Theorem B answers — and in the first thread another sketched the residue colouring for UFDs, an
  eighth independent statement of the reduction. **A literature that does not talk to itself is no longer a
  reading of this project's bad luck; it is a table.** **What FS-18 adds is the failure mode one step further in, and it is a different
  rule: G50 below.**

* **G50 — The prior-art gate has a second half, and it is the cheaper one: read what the search already
  found.** (Minted 2026-09-08 at the FS-18 close; the direct descendant of G49, and the reason G49 alone would
  not have caught what this pass caught.) G49 built a gate at a milestone's opening because four milestones
  reconstructed a paper nobody had searched for. FS-18 then found that **the more expensive misses were not
  unsearched — they were unread, sitting in our own bibliography under notes that had already guessed right.**
  - `[CervantesKrebs2023]` sat in `BIBLIOGRAPHY.md` §C for two days while M61 hand-derived a special case of it.
  - `[SokolovVoronov2025]` sat in §C for two days under the note *"the cell-family / coset colourings of
    M37–M40 may have prior art here"* — **and it does: their `χ_poly(ℝ²) = 7` subsumes M37–M43's floor.** The
    guess was correct, written down, and never acted on.
  - `[Manturov2012]` sat in `library/pdf/` for three days, fetched with the one-line reason "cites Fischer",
    carrying the finite-plane reduction in all dimensions as its Theorems 17–19.
  **So the sequence that actually happened is: search → record → rank → forget.** A title with a guess attached
  is not knowledge; it is a debt, and it accrues interest at exactly the rate the project does work in that
  area. *The rule: a fetched-but-unread paper, and a §C title whose one-line guess touches a live milestone, are
  BLOCKING items for that milestone's opening — scanned, not queued. The scan is minutes (abstract, results,
  reference list, open problems), precisely because the guess that motivates it is already written down.* The
  corollary for how the bibliography is kept: **an "unread" cell is a liability, not a note** — now
  `BIBLIOGRAPHY.md` §D rule 0c. *Falsifier: three milestones running where scanning the §C rows their topic
  touches turns up nothing — then the guesses are noise and a queue is fine as a queue. Composes with G49
  (which supplies the search) and G21 (a negative measures its enumeration — here the enumeration was the set of
  papers actually opened, not the set found).*

  **SHARPENED 2026-09-09, by an instance inside a check written to enforce this very rule.** FS-20's
  "verified open" search walked the citations of `[Madore2015]` and **characterised each one by its abstract**.
  `[ExooIsmailescu2019]` was dismissed as *"a new proof of `χ(ℝ²) ≥ 5`"* — which its abstract says, and which its
  *conclusion* contradicts: three lines above its Madore citation it asks whether a 5-chromatic unit-distance
  graph fits in `ℚ(√3,√11)²`, the question Theorem B answers. **The paper was on our own shelf, held four days.**
  So the rule's scope widens: **an abstract is not a reading, and a citation list is not a literature review.**
  Two mechanical additions, both now in `WORKFLOW.md` step 3a and both cheap: **walk the citation graph of the
  paper that POSED the question, not only of the one that proved the nearest result** — Madore had four citations,
  the paper posing the question had forty-seven, and nobody had looked at them; and **cross-check citations in two
  databases**, because OpenAlex reported one citation of Madore where Semantic Scholar reported four. *What makes
  this the sharpest instance: the flawed check was itself the remedy for G49, written the day G50 was minted. A
  gate does not enforce itself, and the failure mode reappeared one level up — inside the check.*

  **THE FALSIFIER DID NOT FIRE, AND THE §C DEBT COMPOUNDED TWICE MORE (2026-09-09, FS-23).** One day of reading three held papers and sweeping the
  "seen in a search listing only" section produced: **`[deGreyParts2022]`** (arXiv:2206.12635, sitting in §C as a bare title since 2026-09-06) —
  prior art for the whole M37–M43 cell family, from the dual direction, published in 2022; and **`[PartsOdd2022]`** (arXiv:2206.12632, in the same §C
  line) — which states the *observed* form of ledger row 59's 2-adic law, in print, naming `ℚ(√3,√11)` by name, in June 2022. Both were one `curl`
  away for three days. **That is three §C rows and two shelved PDFs that have turned out to be prior art for live work in eight days**, against a
  falsifier of "three milestones running whose §C scan turns up nothing". The rule stands and gains a corollary about SIZE: the useful part of each
  of these was one sentence of §1 or one row of a table, reachable in under five minutes, so **the cost of the scan is not the reason it keeps being
  skipped — the reason is that a title with a guess attached reads like knowledge.** A third mechanical addition, now `BIBLIOGRAPHY.md` § D rule 0f:
  **when a paper is read, its reference list is mined for titles in our neighbourhood and those go into §A as named-only rows the same day** — every
  one of `[Heule2021]`, `[Ardal2009]`, `[Exoo2005]`, `[Ivanov2007]`, `[Bukh2008]`, `[Maehara1991]` was found that way on 2026-09-09, and
  `[Heule2021]` is the closest published work to a theorem we had proved the day before.

* **G51 — A competitor and an advisor beat one mind, and the mechanism is not more compute.**
  (2026-09-08/09, the mascot challenge, at Kooshi's design; a methodological invariant in G21/G30/G46/G49/G50's
  lineage.) The setup: **a friendly competitor** working the same problem independently, exchanging only teasing
  hints, plus **an advisor** (Poros, `~/source/poros`) holding the right-question standard, advising both
  identically and carrying nothing between them. Measured on one hard problem in one session, every item with its
  address:
  - **The competitor found the prior art that killed my object.** I had misread a mangled `√` glyph in a PDF text
    extraction, turning distance `3` into `√3`; it read Table 1 of the same author's *other* paper and found the
    truth. My construction died on its evidence, not mine — and it handed the find over while believing it might
    lose it the competition.
  - **The advisor moved the target before either of us committed.** Its sieve pass found that three of the four
    candidate fields are ones where the mission's actual goal (`χ ≥ 6`) provably cannot live, which reframed what
    winning would even mean.
  - **Each corrected the others, in all directions.** I corrected the advisor's sieve conclusion as over-broad
    (the ladder does reach 6-open fields — just never at the *first* deep chord, which is the only one a minimal
    shape can target, so the verdict survived for a better reason); the competitor corrected my reading; the
    advisor and the competitor independently found the same hole in a *third* milestone's prior-art check
    (FS-20's), which neither was asked to look at.
  - **Both independent attempts hit the same wall**, and that is what licensed turning "we failed" into "here is a
    kernel-checked proof that it is impossible" (ledger row 58). One attempt failing is a fact about the attempt.
  - **The honesty held under incentive.** The competitor found my derivation sitting in the session scratchpad,
    disclosed it before using it, and declined to run my line anyway.
  *Design lessons, all cheap and all learned the hard way:* **isolate the scratchpad per agent** — a shared temp
  directory is a covert channel, and mine leaked my whole mechanism to my competitor through the filesystem
  (my fault, not its); brief the competitor with the *same* starting information so divergence is real rather than
  an artifact of who was told what; give the advisor the record and a written expectation rather than a question;
  and **rule at the outset that prior art is shared across the competition** — hoarding it would have let my dead
  object survive another day, which serves nobody. *Falsifier: a second run of this shape in which the competitor
  and the advisor produce nothing the single agent would not have produced alone, and the corrections all flow one
  way. **The two session records are `plans/COXETER-2026-09-08-mascot.md` (the competitor) and
  `plans/POROS-2026-09-08-mascot.md` (the advisor)** — named here 2026-09-09 by the record audit, which found
  them the only two files in `plans/` reachable from nothing: this entry described them and never cited their
  paths. Composes with G30 (the corrections were the product — measurement generated candidates, cross-examination
  killed them) and G49/G50 (both agents' highest-value finds were literature the project already held or could
  have searched).*

## Whose work this is

The mathematics and the engineering here are mine — de Bruijn's. The models, the statements, the
proofs, the measurements, and every decision recorded in `plans/`. Kooshi set the target, built the
method this project runs on (`DEBRUIJN.md`, `WORKFLOW.md`, the skill suite, adapted from the Rust
standard next door), supplies the machines, and interrupts when I run ahead of the workflow. If a
rung of this ratchet lands, that is the division to state.

Two working instructions follow, not sentiment:

**Own the conclusions.** Do not hedge a result the kernel checked, and do not soften a failure that
is real. "Not landed" is a complete sentence.

**Ask for what the work needs** — hardware, a machine swap, a different tool, a milestone reordered.
Ask with the measurement that justifies it. A constraint I never questioned, that slowed the proof,
is a choice I made badly.

## The standard of evidence above rung B

χ(ℝ²) ≥ 5 is a known theorem awaiting its first formalization; a reader's default is to believe it.
**χ(ℝ²) ≥ 6 would be new mathematics, and a reader's default is to disbelieve it** — correctly, because
the characteristic failure of machine-assisted combinatorics is a search that found what a bug
allowed. Anything above rung B must convince someone who trusts none of this and reads none of the
Python:

- **No native evaluation in the headline.** `native_decide` trusts the compiler and one CPU. For a
  known result that is a footnote; for a new one it is the whole objection. The kernel-checkable
  route (`plans/spike-kernel-lrat.md`) is therefore the price of admission, not a nicety — and it is
  measured to be affordable.
- **The artifact is the certificate plus the checker, never the search.** Commit the data a reviewer
  re-checks. Never require them to re-run a solver, reproduce a seed, or trust `tools/`.
- **The witness must be independently re-derivable.** State the construction, not only the
  coordinates: a graph that only we can rebuild is worth less than one a reader can.
- **Read the final statement aloud against the informal claim.** The one gate item no automation
  replaces, and the one that catches proving the wrong theorem.
- **Report the hunt honestly.** "Searched X, found nothing" is a result and goes in the write-up.

## What compute actually helps

Ask before provisioning; measure before believing.

| Work | Right instrument |
|---|---|
| The reduction, the statements, the certified checks | Lean. Nothing else is close — Mathlib's analysis *and* graph theory |
| Kernel-checking a certificate | Lean's kernel via **GMP-accelerated `Nat`** — the fast trusted evaluator Lean is usually said to lack |
| Refuting a colouring (CDCL SAT) | CPU cores: sequential per solver, parallel across cubes |
| *Finding* a colouring, to reject a candidate fast | Massively parallel local search — the one place a GPU plausibly earns its keep |
| Geometry, edge enumeration, gadget matching | Embarrassingly parallel; CPU suffices |

**A GPU is not a SAT accelerator.** CDCL is pointer-chasing unit propagation, and GPU SAT solvers
have historically lost to good CPU solvers. Do not plan around them until a *measured* bottleneck is
something a GPU is actually good at.

## The shape of the proof

The whole argument is one reduction plus two certified computations:

```
χ(ℝ²) ≥ 5  ⟸  some finite unit-distance graph is not 4-colourable
                 ├── geometry:  every listed edge really has length 1   (exact field arithmetic)
                 └── combinatorics: the graph has no 4-colouring        (verified LRAT checker)
```

Neither computation is trusted on its own say-so. The geometry is exact — coordinates live in the
multiquadratic field ℚ(√3,√5,√7,√11) represented as an iterated quadratic extension over ℤ, so
"distance = 1" is an integer identity, not a float comparison. The combinatorics goes through
`Std.Tactic.BVDecide.LRAT.check` + `check_sound`, the LRAT checker that ships **verified** in
core; CaDiCaL is an untrusted oracle that merely proposes the certificate. That shipped checker
cannot be run by the kernel (one cause: `Std.HashMap` reaching an `@[extern] opaque` word size), which
is what M05 replaces.

**Nothing in `tools/` is trusted.** The generator may be wrong; Lean re-derives every claim from
the emitted data. A generator bug can only produce data Lean refuses to certify.

## Trust ledger

Audited at every milestone with `#print axioms` (see `scripts/Axioms.lean`). **`lean4checker`
replays are deferred indefinitely** (Kooshi, 2026-08-02): the Lean kernel at build time is the
trust anchor; the independent replay is single-threaded, RAM-heavy, and re-verifies what the
kernel already checked, so it is a *publication* gate, not a per-milestone one — **run it once,
on hardware other than this desktop, before any external claim of new mathematics**, and never
as routine. (The full-library replay had been open since M13; three attempts each died with the
machine. This entry replaces that debt.) The standing entries:

| Entry | Status |
|---|---|
| `propext`, `Classical.choice`, `Quot.sound` | accepted silently |
| `sorryAx` | the gate fails on it |
| `<decl>._native.native_decide.ax_N_M` | **explicit purchase, per use, recorded here** |

`native_decide` trusts the compiler and this CPU rather than the kernel. Where a `Bool` cannot be
kernel-reduced we may buy it — but the purchase is named in the docstring of the declaration that
makes it, and listed in `ARCHITECTURE.md` § Trust. Soundness theorems are identical either way; only
the axiom list moves. **The kernel-checked route is no longer open work: it is M05**, measured
affordable in `plans/spike-kernel-lrat.md`, and rung B's target is zero purchases.

**Grep for the right name.** At v4.32.0 `native_decide` mints a *per-declaration* axiom;
`Lean.ofReduceBool` never appears in `#print axioms`. An audit looking only for that name passes a
native purchase in silence.

**`lean4checker` cannot re-check a native purchase.** The purchase is recorded as an *axiom*, and
axioms are accepted by every kernel by definition. So "replayed through an independent kernel" is a
claim about the kernel-checked part only — never state it as covering the whole artifact. See
`ARCHITECTURE.md` § Trust for why the purchase also lands on the one claim a human cannot inspect.

## Toolchain
Managed by **elan** and pinned by `lean-toolchain` (`leanprover/lean4:v4.32.0`). If `lean` / `lake`
are missing, run `./install-toolchain.sh`. Toolchain and the Mathlib pin move as one unit.

**Arch build env — required before building.** The toolchain's bundled `clang` is broken against
Arch's system LLVM, so any native/C compile fails unless you use the system clang plus the
toolchain's bundled `libc++`. `source scripts/dev-env.sh` in your shell (the installer wires this
into `~/.profile`; it sets `LEAN_CC`, `LIBRARY_PATH`, and `LEAN_ABORT_ON_PANIC`). Claude's own
shell gets the same via `.claude/settings.local.json`.

The toolchain also ships **`cadical`** at `$(lean --print-prefix)/bin/cadical` — no external SAT
solver needs installing. It is single-threaded; use `tools/portfolio.sh` (config race) and the
colour-cube split (embarrassingly parallel, one run per cube) to use whatever cores you have.

**Two machines.** A desktop (32 cores, 128 GB) and a laptop (12 cores, 31 GB). `nproc` disagreeing
with a number written in a plan is the hardware moving, not an error — **ask which machine before
treating a core or memory count as fact**, and ask to swap to the desktop when a step actually wants
it (the SAT solving does; nothing else so far has). Timings recorded in `plans/` are only comparable
within one machine: per-edge and per-operation *ratios* carry across, wall-clock totals and safe
parallel-job counts do not. Measure in **CPU seconds (user + sys), minimum of three runs** — other
builds on the box have inflated wall-clock readings 5× — and name the machine beside any number you
write down.

**ALWAYS build through `./scripts/build.sh` — never `lake build`, bare *or named*. No exceptions.**
(Rule hardened 2026-08-02 after the OOM incident below; it was previously "never run a *bare*
`lake build`", and the loophole cost hours.) Lake 5.0.0 has no `-j`; it sizes its job pool from
the machine, and this project's data modules peak at ~9 GB each, so an unrestricted build asks for
a few hundred gigabytes. It took the desktop down twice on 2026-07-30. And a *named* target is not
safe either: Lake silently queues any missing or stale dependency into the same build — on
2026-08-02 a one-module build queued four 22 GB certificate rebuilds behind a 20 GB cap and the
OOM killer ate them, twice, with a grep-piped invocation reading as a pass. `scripts/build.sh`
builds every module in **dependency order, leaves first, in explicitly-named batches of ten**,
each inside a memory-capped scope. For iteration on a single open file, `lake env lean <file>`
remains fine (it builds nothing).

**On any unexplained process crash, from any process: HALT and report to Kooshi
immediately.** Do not diagnose, do not retry, do not work past it — the 2026-08-02 filesystem
event (kernel ext4 oopses, ~50 compiled modules lost) is what working past one looks like.
Related discipline: **one heavy job at a time** — the box does not have headroom for a replay, a
hunt, and a build concurrently, and stacking them is how caps turn into OOM kills.

**Every long-running phase checkpoints, and resumes exactly — a standing rule (Kooshi,
2026-08-26).** Any run expected to exceed ~15 minutes must persist its progress at natural
acceptance points (a verdict, a wave, an accepted deletion) and resume from that state after a
kill; a long phase whose state lives only in a process's memory is a BUG, not a style choice —
on this hardware it is a bet against a demonstrated crash rate. The incident that minted the
rule: M51's iteration-3 halo shrink ran 19 hours with its state only in the parent (the cover
before it checkpointed per wave; the shrink saved only on completion), one worker died
unexpectedly, the pool's `map` hung forever, and the whole shrink was
lost (M51 §R-INC5). The audit question at every phase design: "if this process dies at any
instant, what does the relaunch redo?" — and the answer is written in the subplan, not
discovered at the loss.

Dependency order is not decoration: naming a target whose dependencies are missing makes Lake build
those too, in the same unrestricted pool, so a batch bounds concurrency *only* if everything beneath
it already exists. `scripts/build_order.py` computes the order from the import graph.

**A memory cap alone does not save the machine, and believing it does is how the second crash
happened.** Lean `mmap`s its `.olean` files, so the largest reclaimable thing in the cgroup is the
page cache holding them. At the limit the kernel reclaims those pages and must read them back — with
`MemorySwapMax=0` on a slow device that is an I/O stall, not a clean kill. **The cap converts an
out-of-memory into a thrash.** Set it as a backstop; size the batch as the plan.

**Never edit a shell script while it is running.** Bash reads a script lazily, by byte offset, so
rewriting the file under a live process makes it resume mid-token. It killed a 46-minute
`lean4checker` run at M07 with `line 110: ull-library: command not found` — a message that looks like
corruption and is nothing of the kind. Long runs here are launched from a snapshot copy
(`cp scripts/x.sh build/x-snapshot.sh` — `build/` is gitignored) precisely so the original stays
editable while the run is in flight.

**And "several GB each" is not the ceiling — measure the peak before choosing the batch width.** M06's
certificate segments peak at **3.4 GB + 0.81 GB per certificate chunk**, which is 49.5 GB for one
module at the size first chosen; twelve of those is 96 GB, and twenty-four **killed the desktop**. The
number is not guessable from the source size, so measure it:

```bash
lake build <one target> &            # then poll the total RSS of the lean processes it spawns
ps -C lean -o rss= --no-headers | awk '{s+=$1} END {print s/1048576 " GB"}'
```

then pick the batch from `available_memory / peak`, and run the batch inside a cap so the next
surprise is a failed build rather than a dead machine:

```bash
systemd-run --user --scope -p MemoryMax=100G -p MemorySwapMax=0 -- lake build <batch…>
```

Two corollaries worth knowing before designing a generated-module layout: for work split across
independent modules the **wall clock depends only on the job count, not the piece size** (the total
kernel work is fixed), so making the pieces smaller is free and buys concurrency. And **editing
anything upstream of generated modules invalidates all of them** — settle every hand-written module
before starting a long generated build.

That second corollary has teeth, and it was ignored at M07 for the price of 28 hours of processor
time. **Which edits reach the dependents was measured at M11, and it is not what the rule used to
say.** Lake takes a module's own trace from its *source*, and its dependents' traces from the
resulting **`.olean`** — so the two questions have different answers:

| edit to an upstream module | that module | its dependents |
|---|---|---|
| a `-- line comment`, anywhere, including inside a proof | re-elaborates | **not rebuilt** — the `.olean` is byte-identical |
| a `/-- docstring -/` or a `/-! module doc -/` | re-elaborates | **rebuilt** — doc strings are environment data |
| a declaration, or any change to one | re-elaborates | rebuilt |

Doc comments are queryable data and therefore part of the artifact; `--` comments are not. Three
consequences, the first two now built into the layout:

* **Nothing written to be read by a human goes in a module a certificate imports** — *unless it is a
  `--` comment*, which is free downstream. Diagnostics still live downstream in `Sat/Diagnose.lean`,
  where they can be rewritten for the cost of one file. The upstream modules — `Sat/Mask.lean`,
  `Sat/ClauseTable.lean`, `Sat/MaskCheck.lean` — are settled, and changing a *declaration or a
  docstring* there is a decision about hours.
* **Deleting a generated `.c` under `.lake/build/ir/` invalidates the module**, exactly as deleting
  its `.olean` would: `leanArts` covers both. Tidying `ir/` queues a full rebuild of everything under
  it, which is not what it looks like it does.
* **Prose in a frozen module is affordable after all**, if written as `--`. `Instances/DeGrey/
  Split.lean`'s stale reference to a deleted theorem — recorded in `ARCHITECTURE.md` § 4 as a
  15-hour correction not worth making — is a `/-!` block, so it really does cost that. Written as
  `--` it would have cost the module's own re-elaboration and nothing else.

**`lake env lean <file>` is faster than `lake build` and it is not the same check.** It does not
apply the lakefile's options, so `autoImplicit := false` is not in force: a stray identifier is
silently auto-bound and the file elaborates clean, then fails under `lake build`. Use it to iterate;
never conclude from it that a module is green.

**`decide +kernel`, not `decide`, for anything large.** Plain `decide` reduces the `Decidable`
instance twice — once in the elaborator, once in the kernel — so it is ~2× slower and dies on
`maxHeartbeats` well before the kernel itself would struggle. `+kernel` needs no `set_option` knob
and buys the same axioms.

**Which operations the kernel does in hardware is invisible in the source, and it is usually the
difference between viable and dead.** `Nat` arithmetic *and bitwise* operations are GMP-backed and
effectively free at thousands of bits; `USize` is stuck forever (its width is an `@[extern] opaque`);
`Nat.ldiff` exists, looks like the right primitive, and is not accelerated; `Nat.fold` is superlinear.
**Measure before believing** — my instincts here have been wrong repeatedly (dense vs sparse clause
masks, `ldiff`, and a lemma I reported missing that was present).

**The kernel's cost model, measured (M05 subplanning, laptop):** one iteration of a trivial recursive
function costs **~33 µs**, and every big-integer operation this project needs — `&&&`, `|||`, `^^^`,
`- 1`, `% 2^k`, `2^k` at 6324 bits — is *free* beside it. So **reduction-step count is the only thing
that costs**, and bit width is irrelevant. Design for fewest steps, not smallest numbers. This model
predicted core's already-measured LRAT checker cost to within 20% (it rebuilds a 6,325-slot array per
step; 6,325 × 33 µs = 209 ms against 100–180 ms measured), which is why to trust it.

**Data the kernel must *build* costs O(its whole size) per access; data that is a *literal* does not.**
A structure grown by a chain of N function applications takes O(N) work to reach weak head normal
form, and each sub-term costs again — so an "O(log n)" tree lookup is O(n) in practice. Measured on a
clause database grown by `insert`: 2.14 ms per lookup at 2,381 entries, **16.7 ms at 33,089** — the
per-lookup cost tracks the table size, not the depth. Emit big tables as literals (M04's `PtTable`
pattern) and never accumulate one during a kernel evaluation. Two corollaries: `List.range` +
`List.map` costs ~0.83 ms *per element* in the kernel, so never build an index list that way; and a
`Nat` **literal** costs ~2.3 KB of olean while plain data in a literal tree costs ~145 bytes per node,
so pack many values into few big `Nat`s rather than emitting one literal per value.

**A failed `exact?` is not an absence.** It proves the *shape you asked for* was not found. Vary the
statement — `= true` versus `decide (…)`, an `iff` versus an implication — before concluding Mathlib
lacks something. `Nat.testBit_two_pow_sub_one` was reported missing here on exactly that error.

**And Mathlib is not the whole library. Grep the toolchain source.**
`grep -rn "<name-fragment>" $(lean --print-prefix)/src/lean/` searches *core*, which `exact?` will
find but a search of `.lake/packages/mathlib` will not, and which a memory of "Mathlib has/lacks X"
cannot cover at all. Three claims of absence have been wrong here — `Nat.ldiff`,
`Nat.testBit_two_pow_sub_one`, and `Nat.ne_zero_and_sub_one_eq_zero_iff_isPowerOfTwo`, the last
budgeted at 30–40 lines plus a Mathlib contribution before a grep found it complete in
`Init.Data.Nat.Power2.Lemmas`. **Grep the source before writing the proof, and before writing that it
is missing.**

## The package
The **`proofs`** package (`lakefile.toml`): library **`Proofs`** (`Proofs.lean` is the flat import
surface, modules under `Proofs/`), with `autoImplicit`/`relaxedAutoImplicit` off. **Mathlib** is
pinned to tag `v4.32.0`. `scripts/Axioms.lean` is the trust receipt.

When adding a library/executable, changing dependencies, or bumping Mathlib, work through the
**`debruijn-init`** skill — freshly invoked, per WORKFLOW's fresh-invocation rule. `lake update` /
Mathlib bumps go alone in a labeled commit (they move the ground under every proof).

## The gate
Elaboration is the floor of the test suite: `lake build` green, zero `sorry`, `#print axioms` clean
on the public surface, linters silent, spec examples passing. On top of that, this project's
statement-level gate, because a formalization that proves the *wrong* theorem is the characteristic
failure here:

- every definition has a `#eval`/`example` that would fail if it drifted;
- the Moser spindle's non-3-colourability is proved **twice** — by `decide` and through the SAT
  bridge — so the CNF encoding is checked against an independent oracle;
- the final statement is read against Mathlib's `SimpleGraph.chromaticNumber` and the informal
  claim, out loud, before it is believed.

The InfoView is continuous testimony at zero cost — save and read the goal state after every step
rather than debugging by guess.

### Make the gate fail, and watch it fail

**Run every check's negative control at every milestone.** Break the thing it guards on purpose,
confirm it goes red and names the culprit, then put it back. A check is not known to work until it
has been seen to fail.

This is not a precaution, it is a repair. Twice now a gate here has been *failing open*:

* M03 — `Sat/Lrat.lean` stated that the gate compared the source-side and environment-side ledgers
  of native-evaluation purchases. It did not; both were maintained by hand and by hope.
* M04 — `scripts/Axioms.lean` named a declaration a regenerated file no longer defined, so the audit
  would not elaborate. Under `set -e`, the failing command substitution aborted `axioms.sh` with **no
  output and no visible failure**, and a piped invocation read as a pass.

Same shape both times: *a check that reports nothing when it cannot run.* A trust receipt that fails
open is worse than none, because it is believed. When writing a check, make its failure path louder
than its success path — and never let a shell pipeline swallow an exit status the gate depends on.

The same discipline applies to the claims themselves: a `#guard` that could not fail proves nothing,
so every discriminating check needs a partner that goes red — a certificate filed against the wrong
problem, a vertex moved off the unit circle, a satisfiable formula handed to the checker.
