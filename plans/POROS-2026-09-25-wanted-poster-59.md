*Poros record, crunch job **J38**, 2026-09-25. The "wanted poster" of a counterexample at one of the conjecture's live walls:
**a four-colouring of the plane over ℚ(√59) (and ℚ(√83), ℚ(√131)) that is not a pullback from the tight dyadic place**, which would show
that `(0, 4)` is not forced (row 88). Brief: `data/crunch-2026-09-25/briefs/J37-39-poros-wanted-posters.md` (J38 block), with
`data/crunch-2026-09-25/briefs/STANDING-RULES.md` as part of it. Opus 5.5. No subagents; no finite-witness search (ban to 2026-10-01);
this record and my report file are the only files I edit (plus one exact check under `tools/crunch_j38_*.py`, standing rule 7).*

**Owner updates at launch, logged so a successor has them:**
1. Read first: the ℚ(√47) poster (`plans/POROS-2026-09-25-wanted-poster-47.md`, J37); J36's F2–F5 and §4.1–§4.4
   (`plans/POROS-2026-09-25-infinitely-many-primes.md`); J45's derivation (`plans/FS84-SI-D-derivation.md`). J45's verdicts are hand, one
   derivation, **blind check (J46) pending**: SI inequality TRUE; "equality ⟹ carries" TRUE; "carries ⟹ equality" GAP; A⁺ TRUE given T-C(A);
   B⁺ TRUE given T-C and D2-A ("at type (B): equality ⟺ Pull ⟺ spectrum on `E_S`"); R-U, SP (both directions) and the control TRUE.
2. J37 ended in a GAP: the class "invariant four-colourings with no proper factor colouring continuous at finitely many places" (EI-2's
   failure), a pure-point layer (rank one closed; rank ≥ 2 open, "Kronecker selection") and a continuous layer (Furstenberg). Say whether
   ℚ(√59)'s gap is the same class, the same missing lemma or the same shared input, and where it differs (Pull ≠ ∅ at type (B)).
3. A candidate control from FS-84's blind check: a four-colourable unit-distance lattice with `Θ₄ = ∅`. Check whether ℚ(√59)'s ring is one
   (route: a field with `χ ≤ 4` and `Θ₄(R_F) = ∅`, then compactness).
4. Row 88's close is filed (`plans/FS86-row88-rigidity.md` §R-close, `plans/R88-derivation.md`), with the transience partials; FS-98 carries
   the transience half.

## Stage 1 — SAVED: the expectation, written before assembling anything

*Read before writing this, in the owner's order: my identity files; the standing rules; the brief; J37's poster in full; J36 F2–F6 and
§4.1–§4.4; J45's theorem table, notation, Stage 3 (A⁺, B⁺) and §5.1–§5.2; `plans/R88-derivation.md` §1–§3 and §G; `LEDGER.md` rows 88–92, 94,
96, 97, 100, 101, 109, 111, 112, 114, 115; G76 in `CLAUDE.md`. Not yet read: the row-88 plan's §R-close body, its prior-art gate
`plans/FS86-row88-PA-close.md`, FS-86's C/D/V records beyond one section of `plans/FS86-C-deBruijn.md` (§7.2). So this expectation is not
blind to J37's shape; it is written to be scored against the composition I have not yet done.*

**E1 — what the poster lists.** Two bands where J37 had three:
- *No finite structure:* not periodic (row 88: every periodic colouring is a pullback); not a character colouring (row 96, HD1); not a
  measurable window over finitely many places (row 92); none of row 91's constructions (patchworks, half-space defects, walls, stripes,
  Kempe swaps, 2-adically continuous colourings); no finite defect against any pullback (R88-B2-1, "frozen"); does not extend to the rigid
  local plane over `ℚ₂(√3)` (row 90's extension form).
- *Invariant measures:* either transient (every invariant measure on its orbit closure carried by Pull), or its orbit closure carries a
  non-Pull measure whose spectrum lies on no `T + A + Fin_S` (Theorem C, row 112) and whose off-`E_S` part is strictly anticorrelated at some
  unit vector (B⁺'s dichotomy, J45).
- *Measured nulls:* few; the week searched nothing here.

**E2 — the gap is not J37's class, but contains it.** Confidence 0.7. At ℚ(√47) T-C(A) forbids every finite-place factor colouring, so
"no finite-place proper factor" describes every invariant measure there. At ℚ(√59) a pullback factor is allowed, so the gap has pieces
ℚ(√47) does not: (i) **transient colourings** (invisible to every measure, R88-B2-3); (ii) **non-Pull measures that do carry a pullback
factor** (a "defect process" over a pullback) — I expect this to be J45's GAP "carries ⟹ equality", which at type (B) becomes a named lemma
of its own; (iii) J37's class itself. *Surprise if:* (ii) is empty by a short argument from gap-freeness of `P₄`.

**E3 — the shared identity is the Furstenberg remainder, reached only through isolation.** Confidence 0.5. J28D's objection to rotation
averaging (a weak-* limit can carry mass onto Pull) is the one type-(B)-specific obstacle on the measure side; I expect it to be removed by
exactly the lemma that removes transience, T-B1 (isolation), because isolation makes Pull clopen. If so, **given T-B1 the ℚ(√59) poster's
measure remainder is J45's SP — the same colouring-free statement as ℚ(√47)'s** — and the two posters share one missing lemma (the
measure rigidity of `U` on `R̂` modulo `E`) plus one type-(B)-only lemma (T-B1). *Surprise if:* the averaging step needs more than T-B1.

**E4 — the control (owner item 3).** ℚ(√59)'s ring is **not** a four-colourable lattice with `Θ₄ = ∅`: FS86-C-deBruijn §7.2 names an
inhabitant of `Θ₄(R)`, the dyadic `ℤ/4` character (G41). I expect an exact check of seconds on `O/4O` to confirm it and to count the
pullback band characters. The live control sites are elsewhere (the inert dyadic towers of norm 4–32, J36 §4.1). *Surprise if:* the count
is zero.

**E5 — the discipline's name.** Symbolic dynamics on a non-finitely-generated abelian group: Pull is a finite set of *frozen* points of the
four-colour hom-shift (`[AlonEtAl2021]`); T-B1 asks whether they are *isolated*, i.e. whether the hom-shift is *expansive at Pull* in
Boyle–Lind's sense; transience is the *measure centre* lying in Pull. The pure-point layer is model sets, the continuous layer ×p×q.

**E6 — the example invariant.** Not EI-2 alone: at type (B) a colouring can carry a pullback factor and still not be one. I expect the right
flip to be a **closed-set** statement — every non-empty closed `Aff_F`-invariant set of colourings contains a colouring that reads finitely
many places — because the closed-set form is where this project's rigidity theorems have landed (rows 95, 98: Berend) while the measure
form is Furstenberg's wall. Its shadow on the poster: row 91's H and row 92. Confidence 0.4 that I keep it.

**E7 — killing test.** The cheapest ways the poster reads stronger than it is: (a) row 92, Theorem C and every measure line share
`[AmbrusEtAl2023]`'s `m₁ ≤ 0.2470` (J37's KT-1); (b) V3 (periodic ⟹ pullback) rests on FS-66's certificate at 11 (ℚ(√59)) and 19 (83, 131),
so "not periodic" is not free of certificates as it is at ℚ(√47); (c) B⁺ is one derivation.

**E8 — recommendation, before composing.** A derivation job on T-B1 is the natural default (it is FS-98's), but I expect to rank a
**reduction theorem** first — "T-B1 ∧ (measure rigidity of `U` on `R̂` mod `E`) ⟹ row 88 yes" — because it would make the two posters one
problem plus one local lemma.
