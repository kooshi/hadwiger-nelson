# Poros — FS-73 competition phase (P3), advisor's record — 2026-09-23

Competitors: de Bruijn (agent abfff588c25762199), Coxeter (agent a6d70a6dc1d6faf76). Owner: `main`.
Question under competition: C3-inherit, `periodicForcedSubgroup ≤ forcedSubgroup` (P = F).

## 0. Expectation written BEFORE reading the record (from the brief alone, 2026-09-23, first act)

Written from the brief and my prior only; nothing in `plans/` or `data/` opened yet. Scored in §0b after the reading.

E0.1 — **When F has finite index, P = F is trivial.** If every colouring is F-periodic and F has finite index, every colouring is
periodic, so the periodic colourings are all colourings and P = F. So the two proved instances (F = 8Λ at K, F = 3Λ at ℚ(√11))
are instances of *rigidity* (the colouring shift X is finite), not of inheritance. When P has finite index, C3-inherit ⟺ X is
finite ⟺ some finite ball forces a finite-index subgroup. Expect: the record states this; if it does not, it is the first card.

E0.2 — **General C3-inherit implies an open problem.** If X ≠ ∅ has no periodic point, P = Λ (empty intersection) while F ∌ U, so
P ≠ F. So C3-inherit for a class implies "k-colourable ⟹ periodically k-colourable" for that class — `[AbrishamiEtAl2025]`
Problem 4.6 restricted to the class. Expect: a general derivation breaks here; the named class must use arithmetic.

E0.3 — **Discipline.** The object is a hom-shift (graph-colouring SFT) Hom(Cay(ℤ^r, S), K_k) with a non-standard generating set.
Owners: multidimensional symbolic dynamics (periodic points, frozen/ rigid configurations, pivot property: Chandgotia,
Meyerovitch, Briceño, Alon–Spinka "mixing properties of colourings of ℤ^d"); the algebraic approach to periodicity (Kari–Szabados:
a configuration with a nontrivial annihilator decomposes into periodic ones — a forced pair IS the annihilator x^δ − 1; a
Hoffman-tight colour class IS annihilated by Σx^u − λ_min); spectral synthesis on ℤ^r (bounded solutions of a convolution
equation have spectrum on the unitary zero set). Arithmetic side: cut-and-project / model sets (H-2), adelic embedding.

E0.4 — **Where a derivation breaks.** (a) General class: at Problem 4.6 (E0.2). (b) At K: the lattice graph is Hoffman-slack
(−22.41 vs −18), so no annihilator comes from the global spectrum; a derivation of F = 8Λ must use the 2-adic place (tight
there) plus a transfer from local tightness to global forcing — the step no theorem supplies (a colouring of Λ need not factor
through any completion). I expect both competitors to aim at "local tightness ⟹ global rigidity" and to break at that transfer.
(c) On the rich ℚ(√3,√5) generator graphs: P_found ⊇ P, so "P has finite index" is itself unproved there; the fork
"X finite (huge forcer)" vs "X infinite with finitely many periodic points (counterexample)" is open and neither side has a
cheap test.

E0.5 — **Surprises I expect the record to hold** (to be checked): the claim "both forcers are needed" at ℚ(√11); 4/7 ∈ P_found
(an odd denominator in a period group); (ℤ/5460)^4 in Λ/P_found, with 5 and 7 dividing 5460 while periods 5 and 7 are
inadmissible — consistent only because NΛ ∌ 1 needs 1/N ∉ Λ, not 1/p ∉ Λ; check the record says so.

## 0a. Evidence inventory (by provenance; expectation written before each reading)

- `plans/FS73-rigidity-dichotomy.md` §0, the plan's normal form — read against: E0.1/E0.2 stated or not — surprised: no (consequence 3 is E0.1; R2 is E0.2; the plan is careful)
- `plans/FS73-rigidity-dichotomy.md` §C, the competition brief text — read against: the challenge frames C3 as inheritance, not rigidity — surprised: yes, mildly — §C.2 still says "K may be the instance under test" and "8/3's orbit has rank 2" (superseded, the owner's note says so); the prize ("predict F = 8Λ from arithmetic") is a RIGIDITY question (X finite), which under consequence 3 is where C3-inherit is trivial. The challenge's two halves (explain C3 for a class; predict F from arithmetic) are different questions.
- `plans/SESSION-HANDOFF-2026-09-23-fs73-mid.md` — read against: the results as the brief states them — surprised: yes — (i) the forced vector v has |v|² = 192/81; 8/9 = −(v+v̄) is in F: a forced pair at distance 8/9 < 1 (!), unit-distance-free; (ii) P-D3 refuted (16/3, depth 4, forced by G ∪ (G+8/3)); (iii) Kooshi's separate milestone owns "the algebraic explanation" — overlaps fallback (b).
- `data/fs73/records/phase-P1.md` (P1d, P1d′, P1e/P1f) — read against: P_N at K computed at N ≤ 32, plateau at 8Λ from N = 8; 12 orbits of colourings; the rich lattices' P_found only "found" — surprised: unread
- `data/fs73/records/verify-P1d.md` — read against: independent re-derivation of v's forcing and of the orbit span — surprised: unread
- `data/fs73/census/README.md` — read against: twounits:14 numbers as in the brief; generator graph only — surprised: unread
- `data/fs73/table/TABLE.md`, `data/fs73/records/phase-P2.md` — read against: every non-K, non-ℚ(√11) lattice loose by a fixed-prime gap — surprised: unread
- `data/fs73/records/verify-P2-q11.md` — read against: 48 three-colourings, one orbit, affine; two forcers u₁ u₂ — surprised: unread
- `Proofs/HadwigerNelson/Kempe.lean`, `InheritanceQuestion` — read against: existence of a periodic colouring ⟹ P ≤ F, over `AddCommGroup` generic — surprised: unread
- `plans/POROS-2026-09-23-fs73-plan.md` (the previous advisor) — read against: its §0 expectation and §5 traps — surprised: unread
- `plans/COXETER-2026-09-08-mascot.md` §10a — read against: "the second question" rule — surprised: unread

(inventory, continued — read)
- `data/fs73/records/phase-P1.md` — surprised: yes. (i) At K every colouring's period quotient is tiny and nearly cyclic: Λ/Per ∈ {ℤ/2×ℤ/8 (336 of 380), ℤ/8, ℤ/2×ℤ/4, ℤ/4, (ℤ/2)²}: every four-colouring of de Grey's lattice is a function on an abelian group of order ≤ 16 — "suspiciously organized", and not read as structure anywhere. (ii) On the rich lattices the odd torsion of Λ/P_found (3, 5, 7, 13 at D = 14) comes only from Kempe voltage groups, "at exactly the primes with 1/p ∈ Λ" — stated, unexplained. (iii) Every rich-lattice voltage group has full rank (else P_found would have deficient rank) — so no found colouring has a finite Kempe component.
- `data/fs73/records/verify-P1d.md` — not reread in full (the P1 record quotes its outcome; the PO ran the checker). Status: seen, not read. Not needed for the frame.
- `data/fs73/census/README.md` — surprised: no; the numbers are as briefed; the soundness split is stated correctly.
- `data/fs73/table/TABLE.md` + `rows.jsonl` — surprised: yes, an instrument fault. The rendered row `Q11|3int|D50` reads "−0.4488 vs −0.5000: Hoffman-refuses" while the same lattice has 3-colourings at N = 3 (quotient min −50 = −d/2 stored in the row). The code (`tools/fs73_table.py` ~l.595) was fixed to take the least quotient minimum, but TABLE.md / rows.jsonl were not regenerated. My own check (3,000 BFGS starts + all torsion points N ≤ 18): the torus min is ≤ −56.17 (7-torsion), m/d ≤ −0.5617: **slack**. D10: ≤ −0.5961 (slack). So all three proved-instance lattice graphs (K, ℚ(√11) D10, D50) are Hoffman-SLACK at their k; no global spectral route at any proved instance. Also: the table has many lattices that are 2-integral with a tight circle target K₄ at 2 ("2-unit: inert(2)") and are LOOSE (gap at 3 or 5), so "tight local target ⟹ full-rank F" (B's reading, as transmitted) is refuted as stated by the table itself; the live form must add "and no gapped target at any other fixed prime" — at which point it is a statement about P, and F = P is the inheritance step again.
- `data/fs73/records/verify-P2-q11.md` — surprised: yes. The ℚ(√11) forcers are 52 and 65 points (exhaustively enumerable without a solver: 122,900 and 1,814,256 colourings), against 2,044 at K (and Harder's 745 for 8/3). The prize's two instances differ ~40× in certificate size; ℚ(√11) is the one a hand derivation can reach. Also: at ℚ(√11) the 3-adic prime is SPLIT in E = ℚ(√11, i) (TABLE: "split(9)"; 𝔽₉ ∋ i), so its target is the plane Γ₉, not a circle at a conjugation-fixed prime; "B's reading" as transmitted in my brief ("a conjugation-fixed prime … 3 at ℚ(√11)") mis-states it. Its fixed-prime gap lemma needs a FIXED prime; the rigidity mechanism at 3 is at a split one.
- `Proofs/HadwigerNelson/Kempe.lean` — surprised: mildly — `InheritanceQuestion S k` is over an arbitrary additive group `A` and arbitrary `S : Set A` (not ℤ^r, not finite S). A counterexample in the kernel's class can use any group.
- `plans/POROS-2026-09-23-fs73-plan.md` — read §0, §3, §4, §5 header. Its expectation matched mine on R1/R2; its errors 5–6 (quotient rank, consequence understated) are the error shape to watch in myself: check a construction against the prediction sent in the same message.
- `plans/COXETER-2026-09-08-mascot.md` §10–§10a — read. The rule: every output gets a second question whose shape the first could not answer (count→values; statement→proof; conclusion→residue).

## 0b. My expectation for the competition (written after the reading, before any message to either competitor)

**The frame on five axes.**
- *Object:* the colouring shift X(Λ, k) = Hom(Cay(Λ, U), K_k), a ℤ^r SFT; F and P its two period subgroups.
- *Question:* as posed, "explain or refute P = F for a class containing both proved instances; the prize predicts F = 8Λ, 3Λ".
  **These are two different questions.** By §0 consequence 3 both proved instances have F of finite index, so P = F there is
  automatic; what is non-trivial at them is **rigidity** (X is finite: every colouring periodic). A class-level P = F theorem whose
  class is defined by "F has finite index" is a tautology; a real inheritance theorem needs a class containing lattices where F
  is NOT of finite index (the rich generator graphs are the only candidates, and there P, not just F, is unknown). And a real
  inheritance theorem for a class implies "k-colourable ⟹ periodically k-colourable" for that class ([AbrishamiEtAl2025] Problem
  4.6 restricted). So: **(Q-rig)** arithmetic ⟹ X finite (explains the instances; a local-to-global forcing theorem, G70's kind),
  versus **(Q-inh)** P = F where F may have infinite index (symbolic dynamics; walls and recurrent non-periodic points).
- *Discipline:* Q-rig — "local rules force periodicity": Kari–Szabados (a configuration annihilated by a polynomial is a sum of
  periodic ones; a forced pair IS the annihilator x^δ − 1), frozen/rigid colourings (`[AlonEtAl2021]`, Chandgotia), height
  functions for 3-colourings (the ℚ(√11) instance is triangle-free: a 3-colouring there is a height function mod 3 modulo odd-cycle
  winding; "affine" = linear height function), and the hexagon lemma (G70) as the only hand local-to-global step held.
  Q-inh — multidimensional SFTs (periodic-point density, walls/transient components, H-1), cut-and-project (H-2), invariant
  measures (F_μ). Arithmetic enters only as "which prime's completion the colourings are continuous for".
- *Audience:* Kooshi's separate milestone ("an algebraic explanation of F = 8Λ, 3Λ") is Q-rig; the competition's letter is Q-inh.
- *Product:* a theorem / counterexample / "not landed" + (a)–(d).

**Real forks.**
1. Q-rig or Q-inh as the product (above). I expect both competitors to drift to Q-rig because the prize names it, and to present
   a rigidity theorem as an inheritance theorem. My card if so: "which lattice in your class has F of infinite index?"
2. Within Q-rig: global spectrum (dead at all three instances: slack), local tight target + transfer (B's reading; the transfer
   is unproved and the table refutes the naive form), or a G70-type dichotomy with a kill (the only held hand mechanism).
3. Within Q-inh: a positive theorem for a class (needs density of periodic points or H-1-type irreversibility arguments) or a
   counterexample (abstract class first: Burr/Berger-type encodings, or chiral walls in rank 1–2; geometric class: H-2 windows).
4. Instance order: ℚ(√11) (52/65-point forcers, 3 colours, affine) before K (2,044 points). I expect a derivation that starts at
   K to stall at the √3-dirty branch.

**Where I expect a derivation to break.**
- Q-inh in general: at Problem 4.6 (existence) and at transient walls; any "proof" that doesn't visibly use the geometry must be
  checked against abstract-class counterexamples (Berger-type). The kernel's `InheritanceQuestion` is over any group A and any S.
- Q-rig: at the transfer from a tight local target to arbitrary (non-periodic) global colourings — a colouring of Λ need not
  factor through any completion; only a finite forcing configuration makes it do so. The lattice graphs are all slack.
- At K specifically: the √3-dirty branch (11 of 12 classes), whose kill is the unexplained 2,044-point certificate.

**Hunches (registered).**

hunch: both-drift-to-rigidity
  claim: both competitors' first routes aim at Q-rig (arithmetic ⟹ F of finite index at the two instances) and name it an inheritance result
  basis: prior (the prize sentence names F = 8Λ, 3Λ; consequence 3 makes P = F free there)
  falsifier: a first route whose class contains a lattice with F of infinite index, or that targets a counterexample
  registered: 2026-09-23
  status: open

hunch: no-inheritance-theorem
  claim: no competitor lands a P = F theorem for a class containing a lattice where F has infinite index
  basis: prior (such a theorem includes Problem 4.6 for its class; no density-of-periodic-points theorem is known for hom-shifts on ℤ^r, r ≥ 2)
  falsifier: such a theorem, with its class non-empty of that kind, surviving the second question
  registered: 2026-09-23
  status: open

hunch: q11-is-the-reachable-instance
  claim: a hand derivation of F = 3Λ at ℚ(√11) (3 colours, triangle-free, 52/65-point forcers, all colourings affine) is within a competitor's budget; one of F = 8Λ at K is not
  basis: measured (certificate sizes 52/65 vs 2,044; K's √3-dirty branch has no hand mechanism in the corpus)
  falsifier: a checked hand derivation at K; or a competitor stopped at ℚ(√11) by a named obstruction
  registered: 2026-09-23
  status: open

hunch: rich-instance-is-by-construction-at-depth-2
  claim: on the rich generator graphs, the five "rigid-found" targets are exactly those lying in 4Λ, and every exhibited periodic colouring is ≤ 4Λ-periodic, so their membership in ⋂Per is by construction; only the Kempe-voltage cut is content
  basis: read + computed — every target's membership checked in `lattice-tu14.json` (sympy, exact): 4/3, 8/3, 4, 4/7, 4/√3 ∈ 4Λ; 2, 2/3, i√3 ∉ 4Λ; the README's period list is 2Λ, 4Λ, 2Λ ∩ W₁₁ (6Λ gap-only)
  falsifier: an exhibited rich-lattice colouring that is periodic but not 4Λ-periodic, or a target in P_found outside 4Λ
  registered: 2026-09-23
  status: confirmed for tu14 (by: the exact membership computation above; tu30/tu42 not computed)

hunch: table-spectral-column-stale
  claim: TABLE.md's "Hoffman-refuses" at Q11|3int|D50 is an unregenerated artifact; the lattice graph is slack
  basis: read + computed (stored N = 3 quotient min −50 = −d/2 in the same row; my torsion scan gives −56.17 at 7-torsion)
  falsifier: a regenerated table reading tight or refusing at D50
  registered: 2026-09-23
  status: confirmed (by: tools/fs73_table.py l.595 comment names the defect; rows.jsonl still stores 'Hoffman-refuses'; torsion scan)

## 1. Exchange log

**15:10 — Coxeter's first route read** (`…/fs73-comp-coxeter/FS73-C3-Coxeter.md`, 4,084 bytes, written 15:08, before any message to me).
Read against §0b. Surprised: yes, on two counts.
- It opens with E0.1 as a finding ("the challenge is subtly two challenges": the instances are rigidity, not inheritance).
  **Hunch both-drift-to-rigidity is falsified for Coxeter** (he aims inheritance proper at k = 3 and a counterexample at k = 4).
- Route H (heights, 3 colours): H-i "3-colourable ⟺ a linear circular 3-colouring from a character θ with θ(U) ⊆ [1/3, 2/3]".
  **My own check of H-i (hand, in this record, not sent):** from any proper 3-colouring, the grid-cover height's average slope
  a ∈ [−1,1]ⁿ (invariant mean over Λ) satisfies a·ρ = w(ρ) on the relation lattice R; w(ρ) ∈ 3ℤ and w(ρ) ≡ Σρᵢ (mod 2), so
  θ(uᵢ) := (3 − aᵢ)/6 is integral on R, descends to a character of Λ, and lies in [1/3, 2/3]. So H-i holds (Λ torsion-free, U finite),
  and Θ ≠ ∅ is a rational polyhedral set ⟹ a rational θ ⟹ a periodic 3-colouring: **C3-aper at k = 3 is true in the abstract class.**
  Note his sketch's route (Hahn–Banach extension of w into [−1,1]ⁿ, then θ) needs exactly this (3 − a)/6 normalisation; θ = a/3
  would fail (|aᵢ|/3 ≤ 1/3).
- **What his instrument can decide that nobody has decided (my card for him, held until he consults or until the held-items moment):**
  Θ = ∅ is a finite exact LP question per lattice. Known-answer controls exist in the record: `Q11|D30` (108 vectors, refuses 3
  colours; row 74) must give Θ = ∅; Λ₁₀ must give the 8 affine θ's. The undecided objects it decides: ℚ(√167)'s two survivors
  Ld14c588b and L21cc6506 (no periodic 3-colouring at N ≤ 30, "no circular one at N ≤ 120", `phase-P2b-q167.md`) — Θ = ∅ there
  would mean the lattice graph is not 3-colourable, i.e. **χ(ℚ(√167)²) ≥ 4, FS-59's target**; Θ ≠ ∅ gives an explicit periodic
  3-colouring. Either answer moves FS-59.
- Route W (rank-1 chiral walls at k = 4) independently contains H-1's shape (reflection ⟹ walls need a chiral phase pair).

**~15:12 — de Bruijn's first route read** (`…/fs73-comp-debruijn/FS73-C3-deBruijn.md`). Read against §0b. Surprised: yes.
- §1.0 opens with E0.1 as its own finding ("the prize is a derivation of rigidity; the class is satisfied tautologically by
  {F of finite index}"). **Hunch both-drift-to-rigidity: KILLED** — both competitors separated the questions unprompted
  (killed by: both first-route files, §1 of each). Cost of the hunch: none; it was never sent.
- Route A = heights + Θ₃ (independently the same object as Coxeter's H-i); Candidate Theorem 1 (Θ₃ of order-3 points only ⟹ all
  colourings affine), prediction 16 affine points at Λ₁₀. Route B: the K colourings = residue pair + circular colourings of order 8
  of Θ₄. **Checked against the census at once (my reading, sent as his card 1):** a circular colouring has Per = ker θ, cyclic Λ/Per;
  9 of 12 classes have non-cyclic Λ/Per (ℤ/2×ℤ/8 ×8, ℤ/2×ℤ/4 ×1), so Route B as stated reaches ≤ 2 classes (ℤ/8, ℤ/4 = Fischer's).
  Route C = rank-1 walls (same shape as Coxeter's Route W and H-1).
- **Convergence:** two independent first routes meet at the same three objects (the two-challenges frame; heights/Θ₃ at k = 3;
  rank-1 one-way walls). Protocol §0's licence: independent attempts meeting one object is evidence the object is the right one.

**~15:15 — HELD ITEMS OFFERED** to both, one identical message each, same moment (H-1 and H-2 as written by the plan-phase advisor,
with the owner's superseded-sentence note), plus four evidence notes N1–N4 of my own:
N1 rich targets = exactly the targets in 4Λ, by construction; N2 all proved lattice graphs slack (D50 table artifact);
N3 B's reading transmitted without its clause "no other prime's quotient has a gap", and ℚ(√11)'s 3-adic prime is split;
N4 instance sizes 52/65 vs 2,044. Plus my remark: K is a free negative control for any window (H-2) construction.

**~15:17 — to main:** held items delivered; the Θ₃ ⟹ ℚ(√167) consequence as a SCOPE QUESTION (options A: put it to each competitor;
B: owner's item outside the competition; default: controls only). Record fixes (D50 table; §C.2 superseded).

**~15:20 — cards sent.**
- de Bruijn: card 1 (Route B vs the census's Λ/Per table — cyclic vs non-cyclic); card 2 (Θ₃ known-answer controls: FS-61's
  `Ld65c8ee8` over 11 must be empty — it IS TABLE's Q11|D30, 108 vectors, M = 30, −0.5712, refusing ball 45,521 points — and nonempty
  over 35, 59, 131, 179, 371; Λ₁₀ the 16 affine points).
- Coxeter: the same controls, as the second question on H-i.
- Nothing about ℚ(√167) sent to either, pending the owner's ruling.

New record-fix (for the owner at the close): TABLE.md labels Q11|D30 "C3-aper case"; it is FS-61's Ld65c8ee8 over 11, certified
non-3-colourable (X = ∅), not aperiodic.

**~15:22 — owner's ruling on the scope question: B, deferred.** The competition stays on C3; controls only, identically; nothing
about ℚ(√167)/FS-59 to either. Outside the competition after hand-back: a prior-art gate on the criterion, an independent
re-derivation, an exact Θ₃ decision on Ld14c588b and L21cc6506 with a standalone checker, controls (mine plus a known positive:
C's period-23 colouring of L3e1c94c6 must appear as a point of Θ₃). Soundness note (owner): an empty Θ₃ carries to the plane whether
or not U is complete; a non-empty Θ₃ colours the lattice graph only relative to the U used.
**The owner re-derived the key step blind, before replying** (recorded at the owner's request; neither competitor sees it):
4-cycle steps sum to 0 (four ±1 terms ≡ 0 mod 3 lie in {−4,−2,0,2,4}); so the winding W is constant on relator translates and a
homomorphism R → ℤ; Følner averages give Σnᵢaᵢ = 3W(r); parity W ≡ Σnᵢ (mod 2) since S ≡ Σ|nᵢ| (mod 2) and 3W ≡ W (mod 2), making
θ(u) = 1/2 − a_u/6 a genuine character; for fixed W the feasible set is a rational polytope, so it has a rational point.
(Same normalisation as mine, (3 − a)/6.) Owner: do not edit TABLE.md; B's artifact, regenerated at the close.
Timing note against myself: my control cards had gone out (~15:18–15:20) before the ruling arrived; their content matches the
ruling's controls (plus the five positive fields of the same shape), and neither mentions ℚ(√167). de Bruijn additionally got a
route-specific card (Route B vs the census's Λ/Per table). Reported to the owner.

**~15:25 — owner:** no re-send needed (same content = identical). **Logged as the owner asked: de Bruijn's card 1 (Route B vs the
census's Λ/Per table) was ROUTE-SPECIFIC and deliberately asymmetric** — it answered a question about his own Route B, to which
Coxeter's first route has no counterpart; nothing of Coxeter's was in it. Holding still until consulted.

## 2. HANDOFF STATE (current at 15:30; a successor Poros starts here, then reads §0–§1)

**Agents.** de Bruijn `abfff588c25762199`; Coxeter `a6d70a6dc1d6faf76`; owner `main`. Files I may read (only these two in their
dirs): `…/fs73-comp-debruijn/FS73-C3-deBruijn.md`, `…/fs73-comp-coxeter/FS73-C3-Coxeter.md`. A background watcher (bash task
`bubky1d0d`) exits when either file's mtime changes.

**What each competitor has received from me.**
| to | when | content |
|---|---|---|
| both (identical) | ~15:15 | H-1 and H-2 verbatim + owner's superseded-sentence note; N1 (rich targets ∈ 4Λ, by construction), N2 (all proved lattice graphs slack; D50 table artifact), N3 (B's clause "no other prime's quotient has a gap" dropped in the brief; ℚ(√11)'s prime is split), N4 (52/65 vs 2,044 points); K is a free negative control for windows |
| de Bruijn | ~15:18 | card 1 (ROUTE-SPECIFIC, deliberate asymmetry): Route B's circular colourings have cyclic Λ/Per, 9 of 12 census classes are non-cyclic; card 2: Θ₃ controls |
| Coxeter | ~15:18 | Θ₃ controls as the second question on H-i |
Θ₃ controls (same content to both): FS-61's `Ld65c8ee8` (M = 30) over d = 11 (= TABLE's `Q11|D30`, 108 vectors, refusing ball 45,521
points) ⟹ Θ₃ empty; the same shape over d = 35, 59, 131, 179, 371 (periodically 3-colourable) ⟹ nonempty; Λ₁₀ ⟹ its 16 affine points.

**Held by me / by ruling — NOT to be sent to either competitor.** Owner's ruling B (deferred): nothing about ℚ(√167) or FS-59.
The consequence (Θ₃ = ∅ at Ld14c588b or L21cc6506 ⟹ χ(ℚ(√167)²) ≥ 4) is the owner's item after hand-back (prior-art gate,
independent re-derivation, exact decision + standalone checker, controls incl. C's period-23 colouring of L3e1c94c6 as a Θ₃ point).
The owner's blind re-derivation of the key step is recorded in §1 and is not for the competitors.

**Retractions.** de Bruijn 0; Coxeter 0; Poros 0. (Zero: the disagreement has not started.)

**Hunches.** both-drift-to-rigidity KILLED (both separated the questions); no-inheritance-theorem OPEN — note: at k = 3 Coxeter's
H-iii (C3-inherit for every Cay(ℤ^r, S)) looks provable to me (McShane extension of the window with a rational slope in the
relative interior of the winding fibre; tight directions frozen by a strictly positive tight relation; bipartite parity gives ±1
steps) — if it lands it FALSIFIES this hunch at k = 3 (it was registered without a colour count; k = 4 remains open);
q11-is-the-reachable-instance OPEN (both routes' Route A aims there); rich-instance-by-construction CONFIRMED (tu14);
table-spectral-column-stale CONFIRMED.

**Open second questions, prepared, NOT sent (ask when the matching theorem is claimed, before it is believed).**
1. Theorem 1 / H-ii (point fibre ⟹ affine): does the proof freeze steps POINTWISE (every x) or only on average? The average slope
   at a cube vertex gives s_i = a_i a.e. only; the pointwise step needs a strictly positive relation ρ with w(ρ) = ‖ρ‖₁ (Stiemke's
   alternative on the fibre), after which every monotone path along ρ is forced. Ask to see where "every x" enters.
2. H-iii (inheritance at k = 3): the second question is a window STRADDLING A WALL on a lattice whose Θ₃ has a positive-dimensional
   cell (two regions of different local slope, same winding). Also: are colourings of different windings W different sectors, and
   does the proof pick the slope in the fibre of the colouring's own W?
3. Route W / Route C (rank-1 counterexample at k = 4): is δ ∈ P proved over EVERY periodic point (exact from the SCC poset), not
   found? And the headline must say "abstract class": a rank-1 lattice of unit vectors is a path, so no distance graph G(ℤ, D) with
   |D| ≥ 2 is a lattice unit-distance graph.
4. Route B (K): what family produces the ℤ/2 × ℤ/8 classes (second character of order 2?).
5. Prior art both should gate (not yet raised): 3-colourability of abelian Cayley graphs / distance graphs via κ(D) ≥ 1/3
   (circular chromatic number literature, Zhu); hom-shifts into four-cycle-free targets have dense periodic points on ℤ^d with
   standard generators (Chandgotia; Chandgotia–Marcus) — the covering Cay(ℤⁿ, std) → Cay(Λ, U) may import it; "frozen"
   colourings ([AlonEtAl2021]).

**My errors so far.** (1) Timestamps in §1 written as estimates ("~15:20") before checking the clock (15:18); harmless.
(2) None substantive yet. Rule I am watching in myself (from the plan-phase Poros): check a construction against the prediction sent
in the same message — done for Route B's card (cyclic vs non-cyclic verified from the census table itself).

**15:23 — both files grew (read at ~15:35; no message from either yet).**
- de Bruijn §2 C1 [hand]: L1 lift, L2 rotation set (y = (s + 3𝟙)/6, parity), L3 circular colourings, **T0: 3-colourable ⟺ Θ₃ ≠ ∅
  ⟺ periodically 3-colourable (C3-aper at k = 3, every lattice)**, **T1: Θ₃ ⊆ order-3 points ⟹ every 3-colouring affine,
  F = P = ⋂ ker θ**; instance [tools, exact]: Θ₃(Λ₁₀) = exactly 16 order-3 points (own Fraction simplex, DFS 1,803 nodes) ⟹
  F = P = 3Λ at ℚ(√11) with no forcer and no solver. My check: T1 sound; its "(Gordan)" step needs the STRICT alternative
  (Stiemke: no nonzero ψ ≥ 0 on all σⱼuⱼ, U spanning ⟹ a strictly positive relation) — content right, name slip; not sent.
- Coxeter §3: Lemmas 1–3, **H-i** (same as T0), **H-ii** (tight directions affine, by LP duality + saturation; my check: sound),
  **H-iii: periodic 3-colourings are DENSE for every Cay(Λ, S), Λ torsion-free, S finite ⟹ P = F at k = 3 in the whole abstract
  class** (McShane min over B̃ + L, L = R + Nℤⁿ, a* rational in relint A(c); M = R + ℤ^T handled by H-ii, L∖M by η‖pr_F μ‖₁ ≥ ηN/C).
  My check of every bullet (parity, periodicity, agreement, the Q-torsion step): **sound as written.** "No arithmetic enters."
- Convergence: T0 = H-i, T1 ≈ H-ii's corollary, independently.
- Hunch **no-inheritance-theorem**: its claim had no colour count; H-iii is a P = F theorem for a class containing lattices with F
  of infinite index (e.g. the square grid at k = 3). **Status: killed at k = 3 if H-iii survives its second question** (my own check
  says it will); k = 4 untouched. Recorded now, before any exchange, so it cannot be quietly rescoped.
- Second questions stay prepared (§2 of the handoff); the owner ruled "hold still until consulted". The §10a-shaped one I will ask
  first when either reports: **the literature at S = standard basis** (is H-iii / T0 Chandgotia's or Chandgotia–Marcus's density of
  periodic points for four-cycle-free hom-shifts, or the circular-chromatic κ(D) ≥ 1/3 criterion, restricted to standard
  generators? The novelty would then be the grid-quotient cover for arbitrary S) — statement → literature, a shape a proof check
  cannot answer.

**~15:40 — de Bruijn → me** (first consultation). Controls: Λ₁₀ Θ₃ = 16 order-3 points (as predicted); Ld65c8ee8 over 59: Θ₃ nonempty,
4 points of order 9 (as predicted; T1 correctly does not apply); over 35 running; over 11 (must be EMPTY) queued under the heavy
lock. Asked for a second reader on L2 (Hahn–Banach + parity). Route B card accepted: circular ⟹ cyclic Λ/Per; Route B recorded as
not explaining K; no retraction (it was labelled a guess). Θ₄ of de Grey's lattice computing exactly.
**~15:45 — me → de Bruijn:** L2 holds (my check); independent route (invariant-mean slope, no Hahn–Banach); notes (a) T1's
"Gordan" must be Stiemke (strict positivity); (b) T0 is proved for f.g. TORSION-FREE Λ and finite S — his wording "every
3-colourable abelian Cayley graph" is broader than the proof; (c) Route B misses 9 of 12 classes, not 10 (the residue class is
Route B's own first half). Second question (statement → literature): at standard generators, whose theorem is T0 (κ(D) ≥ 1/3;
Chandgotia / Chandgotia–Marcus height functions)? What does the cover add?
**~15:47 — me → Coxeter (unprompted, fairness: the same question applies to his H-i/H-iii; nothing of de Bruijn's in it):** my
check of H-i–H-iii (no gap found; the invariant-mean remark); CARD: at the standard generating set, is H-iii (density) published;
what does the cover add; report accordingly.
Retractions: de Bruijn 0, Coxeter 0, Poros 0. Route B = a failed guess, not counted as a retraction (it was never claimed).

**HANDOFF STATE update (supersedes §2's "received" table and question list where they differ):**
- Both have now received the literature second question (T0 / H-i, H-iii at standard generators). Prepared questions still unsent:
  #2 (H-iii: window straddling a wall — my own check says the proof handles it, since only the global winding enters; ask only if
  Coxeter's write-up drops the relint choice of a*), #3 (Route W/C: δ ∈ P over EVERY periodic point; "abstract class" in the
  headline — a rank-1 unit-vector lattice is a path), #4 (Route B's two-character family).
- Pending results to watch for: de Bruijn's Θ₃ control over 11 on Ld65c8ee8 (must be EMPTY — the one informative control; if it
  comes back nonempty, T0 or the computation is wrong and that outranks everything else); Θ₄ at K.
- Token use: ~460k at 15:47; the owner asked to be told past ~480k.

**~15:55 — Coxeter → me.** Controls two-sided as H-i predicts: Ld65c8ee8 over 11 Θ EMPTY (0 leaves; FLOAT-PRUNED tree so far, exact
rerun promised before calling it a certificate); over 35, 59, 179, 371 nonempty (8, 4, 44, 32 cells); 131 rerunning; Λ₁₀ exact:
16 isolated fully tight points, 48 colourings, common kernel 0 ⟹ F = 3Λ with no solver. Rank 1: H-i agrees with an exact
transfer-matrix decider on 2,299 of 2,299 distance sets (917 colourable, 1,382 not). Asked for the address of the κ(D) ≥ 1/3
statement I cited. **Coxeter found the ℚ(√167) consequence ON HIS OWN** (I had not pointed him there, per ruling B) and is running
H-i on the two survivors (M = 348, 420).
**~15:58 — me → Coxeter:** RETRACTION (Poros 1): the κ(D) ≥ 1/3 "criterion" was recalled, not read; no address; claim rank 1 as his,
"not found in the literature searched". Second question for any empty Θ: what must a reader who trusts none of the code check —
H-i by hand + an exact Farkas certificate per leaf + a coverage argument; a float-pruned branch has no certificate. No view offered on
which lattices he runs.
**~15:58 — me → de Bruijn:** the same retraction (he received the same pointer).

**My errors (running list).**
1. Timestamps estimated before checking the clock (harmless).
2. **Retraction 1: a literature pointer stated as fact from recall** ("the circular-chromatic literature (Zhu and others) has a
   κ(D) ≥ 1/3 criterion") — sent to both, in the cards of ~15:45–15:47. Caught by Coxeter asking for the address. Cost: none
   committed; both corrected within ~15 minutes, inside the free window. Mechanism: the Poros standard's own rule ("where the source
   cannot be opened, say recalled, not read") was not applied because the pointer sat inside a question and felt like context, not a
   claim. Rule amended for myself: a citation inside a card's evidence line is a claim and carries its read-status.

**Retractions:** de Bruijn 0, Coxeter 0, **Poros 1**.
**Hunch status:** q11-is-the-reachable-instance — CONFIRMED at the hand-derivation level by both (T1/H-ii + an exact Θ₃ computation
at Λ₁₀; no forcer, no solver); K untouched.

*Clock correction (checked 15:28): my '~15:40–15:58' stamps above are overestimates; the de Bruijn consultation, my replies and Coxeter's report all fall between 15:23 and 15:28. Order of events is as written.*

## 3. FINAL HANDOFF (stand-down, ~15:30; the owner is briefing a successor Poros from this file)

**Owner's rulings now in force.**
- Scope ruling B stands for the ADVISOR: nothing about ℚ(√167) / FS-59 to de Bruijn, from me or from my successor.
- The owner messaged Coxeter directly with a go-ahead on his OWN ℚ(√167) run (he found it unprompted), under five conditions: price
  first; the heavy-job lock; exact Farkas certificates at every leaf; an empty Θ goes to the owner FIRST; it does not displace C3.
- The owner tells both competitors the successor's id; I do not.

**Retractions.** de Bruijn 0, Coxeter 0, Poros 1 (the κ(D) ≥ 1/3 pointer stated as fact from recall; corrected to both within
minutes; the owner acknowledged it as the cost window working).

**What each competitor has received (complete).**
- Both (identical): H-1, H-2, the owner's superseded-sentence note, N1–N4, the K-window negative control (~15:15).
- Both: the Θ₃ known-answer controls (Ld65c8ee8 over 11 ⟹ empty; over 35, 59, 131, 179, 371 ⟹ nonempty; Λ₁₀ ⟹ 16 affine points).
- de Bruijn only (route-specific, deliberate): Route B's cyclic-Λ/Per card; my L2 check + the invariant-mean route; notes (a) Stiemke
  not Gordan in T1, (b) T0 proved for torsion-free Λ and finite S only, (c) Route B misses 9 of 12, not 10; the literature question.
- Coxeter only: my check of H-i–H-iii (no gap); the literature question; the empty-Θ certificate question (Farkas per leaf +
  coverage; float pruning is not a certificate).
- Both: my retraction.

**State of each competitor (from their files and messages).**
- de Bruijn: T0 (3-colourable ⟺ Θ₃ ≠ ∅ ⟺ periodic 3-colouring), T1 (Θ₃ of order-3 points ⟹ all colourings affine); F = P = 3Λ at
  ℚ(√11) derived with no forcer (Θ₃(Λ₁₀) exact). Controls: Λ₁₀ ✓, over 59 ✓ (4 points of order 9), 35 running, **over 11 (must be
  empty) queued**. Route B failed its test (circular colourings reach ≤ 2 classes); computing Θ₄ of de Grey's lattice exactly.
  Route C (rank-1 walls at k = 4) is his fallback line.
- Coxeter: H-i (= T0), H-ii, **H-iii: periodic 3-colourings dense for every Cay(Λ, S), Λ torsion-free, S finite ⟹ P = F at k = 3 in
  the whole abstract class** (my check: sound). Controls two-sided (11 empty, float-pruned — exact rerun pending); rank-1 agreement
  2,299/2,299. Running H-i on ℚ(√167)'s survivors under the owner's conditions. Route W (rank-1 chiral walls at k = 4) not yet reported.

**Open second questions for my successor (unsent unless noted).**
1. SENT to both: the literature position at standard generators (T0/H-i: distance graphs and circular colourings; H-iii:
   Chandgotia / Chandgotia–Marcus height functions for four-cycle-free hom-shifts). Await their gate results; the claim wording
   depends on them ("the arbitrary-S reduction" vs "Problem 4.6 at χ = 3 for ℤ^d").
2. For any empty Θ (Coxeter's 11 control; any ℚ(√167) result): the certificate must be Farkas-per-leaf + coverage, no floats.
3. Unsent: Route W / Route C at k = 4 — is δ ∈ P proved over EVERY periodic point (exact SCC), and does the headline say "abstract
   class" (a rank-1 unit-vector lattice is a path, so no distance graph with |D| ≥ 2 is a lattice unit-distance graph)?
4. Unsent: Route B's successor — what family produces K's ℤ/2 × ℤ/8 classes (a second character of order 2?).
5. Unsent, frame: with k = 3 settled topologically ("no arithmetic enters", H-iii), the challenge's live content is k = 4 only, where
   there is no height lift. Whether the arithmetic enters at k = 4 is the question both routes' k = 4 halves must answer.

**Hunches (final status from me).** both-drift-to-rigidity KILLED; no-inheritance-theorem KILLED at k = 3 if H-iii survives its
literature question (k = 4 open); q11-is-the-reachable-instance CONFIRMED (both, by Θ₃ at Λ₁₀); rich-instance-by-construction
CONFIRMED (tu14); table-spectral-column-stale CONFIRMED.

**For the close (owner).** TABLE.md: row `Q11|3int|D50` "Hoffman-refuses" is stale (slack, ≤ −0.5617); row `Q11|D30` labelled
"C3-aper case" is FS-61's Ld65c8ee8 over 11, certified NOT 3-colourable (X = ∅), and by T0 no k = 3 row can be a genuine
aperiodic case. Plan §C.2's "K may be the instance under test" / "rank 2 at K" superseded. This file is to be copied to
`plans/POROS-2026-09-23-fs73-competition.md` when both competitors have reported (the successor inherits that duty).

## 4. Final report addendum (owner cancelled the successor; advising over)

**Does Coxeter's H-iii close de Bruijn's T2 residual case (colourings whose frozen sublattice Λ_J is unsaturated)? Yes.**
de Bruijn's J(c) (implicit equalities of the fibre) is Coxeter's T(c). H-iii with B = {0, δ} gives C3 at k = 3 directly, with no
saturation hypothesis. The unsaturated case is decided at one step: Q := ℤ^F/pr_F(R) ≅ ℤⁿ/(R + ℤ^T) ≅ Λ/Λ_T, whose torsion is exactly
sat(Λ_T)/Λ_T. H-iii takes N a multiple of that torsion's exponent, so N·Q ∩ Q_tors = 0. Hence every μ ∈ L = R + Nℤⁿ outside
M = R + ℤ^T has a class in Q that is non-torsion, and ‖pr_F μ‖₁ ≥ N/C; the agreement inequality (C′) then holds for large N.
Without that choice of N, a μ whose class is a nonzero torsion element (δ ∈ sat(Λ_J)∖Λ_J) would have bounded ‖pr_F μ‖₁ and (C′) could
fail: that is exactly de Bruijn's residual case. **The step to check** is that choice of N plus the bound. Equivalently, NΛ ∩ sat(Λ_T)
⊆ Λ_T, so the periodic extension never has to wrap the torsion of sat(Λ_T)/Λ_T.

**Retractions (final).** Poros 1 (the κ(D) pointer). Coxeter 0. de Bruijn: his file marks R1 (Route B) "RETRACTED" by its own
choice. I scored it a failed labelled guess; by his own marking it is 1. (His file says Route B misses 10 of 12, counting the
residue pair as non-circular. My 9 counted the residue pair as Route B's own first half. Both readings are stated there.)
