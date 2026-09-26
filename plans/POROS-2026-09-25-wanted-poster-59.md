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

## Stage 2 — SAVED: quotation check, the control check, and the inventory (read against Stage 1)

### 2.1 Quotation check (standing rule 5)

| # | the brief or the launch message says | the source says | verdict |
|---|---|---|---|
| Q1 | "The counterexample is a four-colouring that is not a pullback from the dyadic place, which would show that `(0, 4)` is not forced." (brief, J38) | `plans/R88-derivation.md` head: "Row 88 asks whether `(0, 4)` is forced … equivalently, whether every four-colouring of the plane is a pullback from the tight dyadic place"; R88-TA2: "A FALSE for T-B1 or for T-B2 exhibits a four-colouring outside Pull, so `F(R) = 0`" | agrees; the unit is one `R`-coset (Pull is defined on `Cay(R, U)`) |
| Q2 | "no finite defects; bounded defect chains are thin; a defect set of density zero makes the colouring transient" (brief) | R88-B2-1 "no colouring differs from a pullback on a finite non-empty set"; R88-B2-2 "every archimedean-bounded subset of `R` has upper Banach density 0 … bounded propagation chains are thin"; R88-B2-3 "if `d*({c ≠ p}) = 0` for some `p ∈ Pull` and `c ≠ p`, then `c ∉ Pull` and `c` is transient" | agrees; "density" is **upper Banach** density in `R` |
| Q3 | J45: "carries ⟹ equality is GAP … equivalent to 'every four-colouring has equality' over a field like ℚ(√11)"; "At type (B): equality ⟺ Pull ⟺ spectrum on `E_S`" (launch) | J45 §5.1: "over a (G2) field, ℚ(√11) among them, equivalent to 'every four-colouring has equality at `S`' (SI-5)"; Stage 3: "given T-C, at type (B): equality for every `u` ⟺ carried by Pull ⟺ spectral measure on `E_S`" | agrees, with three qualifiers the launch drops: "(G2)", "at `S`", "given T-C … for every `u`". **(G2) is a gapped-vertex condition, and it fails at type (B)** (`P₄` is gap-free), so SI-5 does not transfer — used in §3.3 |
| Q4 | J37's class: "invariant four-colourings with no proper factor colouring continuous at finitely many places" (launch) | J37 §3.3 (b): "the translation-invariant random four-colourings of `Cay(R, U)` with no proper factor colouring continuous at finitely many places" | agrees; "invariant" = translation-invariant random |
| Q5 | "is there a four-colourable unit-distance lattice with `Θ₄ = ∅`?" (launch) | `plans/FS84-S1V-verification.md` V3 (ii): "GAP in the stated class … no f.g. `Λ ⊆ ℤ[U_F]` with `Θ₄(Λ) = ∅` and a four-colouring is exhibited"; S1V-7 is the abstract-class instance | agrees |
| Q6 | G76 (brief: "rows 88–94 and 96, and G76") | `CLAUDE.md` G76: "A 'no' must disagree with every pullback in every archimedean direction, patch no two pullbacks, and read infinitely many split places (rows 91–92)" | read at that scope; "read infinitely many split places" is for window/character constructions, not a theorem about every colouring (§3.2) |

### 2.2 The control (owner item 3): ℚ(√59)'s ring is not one — an exact check

`tools/crunch_j38_band.py` (output `data/crunch-2026-09-25/j38-band.out`; plant `j38-band-plant.out`). At the tight place of every type-(B)
field, `L_𝔓 = ℚ₂(ζ₁₂)` over `F_𝔭 = ℚ₂(√3)` (unramified), `O = ℤ₂[x]/(x⁴ − x² + 1)`, `𝔓⁴ = 4O`; the norm-one circle mod `N` is
`{w/w̄ mod N}` (Hilbert 90 for units, unramified). A complete enumeration of the `N⁴` characters of `O/NO` against the circle, `N = 2, 4, 8`:

| level | `\|S_N\|` | band-4 characters | orders |
|---|---|---|---|
| `O/2O = O/𝔓²` (its quotient `O/𝔓 = 𝔽₄` is `U₂ = K₄`) | 6 | **0** (the parity control) | — |
| `O/4O = O/𝔓⁴` | **24** (row 111's "8 of the 24 residue classes", reproduced) | **12** | all 4 |
| `O/8O = O/𝔓⁶` | 96 | 12 | all 4 (nothing new above `𝔓⁴`) |

Plant: `0` put into `S₄` kills every band character (fires). **So `Θ₄(R_F) ⊇ {θ ∘ π₄}` has 12 points for ℚ(√59), ℚ(√83), ℚ(√131)** — the
dyadic `ℤ/4` colourings (G41; FS86-C-deBruijn §7.2's inhabitant), exactly FS86-dB-HDfin's "pullback characters … vanishing on `R ∩ 𝔓⁴`".
By HD1 (row 96) they are all of `Θ₄(R_F)`. Every finitely generated `Λ ⊆ R_F` has `Θ₄(Λ) ≠ ∅` (restriction), so **no lattice in a type-(B)
ring is the control.** [tools exact; plant fires]

**What the check adds for the control hunt (a surprise against J36 §4.1).** J36 took "`U₄` has no band-4 character at level one" as
evidence for the inert dyadic towers as control sites. The type-(B) tower (inert, `Q = 2`) has **none at level one and twelve at level
`𝔓⁴`**. So level one decides nothing at a dyadic place; a control at `Q ∈ {4, 8, 16, 32}` needs the count at the level where band
characters of that tower must already live (card in §4.4).

### 2.3 Evidence inventory

- **J28D's reading in `plans/R88-derivation.md` §G (T-C′):** "even a full classification of `U`-invariant measures would leave Q-μ open without T-B1-type isolation (the weak-* limit of `U`-averages can move mass onto Pull)" — read against: E3 — surprised: no, and it sharpens attribution: the dependency on isolation was named by J28D; what §3.4 adds is that isolation is **all** that is missing between row 88 and J45's SP.
- **J45 SI-5 and (G2)** (`plans/FS84-SI-D-derivation.md` §2.2, §5.1) — read against: E2 (ii) — surprised: yes. SI-5 reduces "carries ⟹ equality" to "every μ has equality" **only under (G2)**, a gap condition; type (B) has no gaps. So at type (B) the defect-process question is not SI-5's and is its own lemma (§3.3, DP).
- **J45 B⁺ remark (ii)** ("every μ over a type-(B) field is carried by Pull or strictly anticorrelated off every `E_S` at some unit vector") — read against: E1 — surprised: no.
- **Row 90's extension form** ("`F(R) ≠ 0` iff every four-colouring of the field plane extends to the local plane, per coset"; the local plane over `ℚ₂(√3)` is rigid) — read against: E1 — surprised: no; a poster line.
- **Row 91's H** ("a colouring agreeing with a gap-free periodic one on an additive half-space equals it … every number field, any number of colours") — read against: E6's closed-set shadow — surprised: yes, it is stronger than I had it: any number of colours, every number field, so it holds at ℚ(√11) too; it is a **closed-set isolation theorem for half-spaces**, and T-B1 is its finite-window form.
- **Row 94's ℚ(√−709)** (Theorem C under H*, "Q-tr there") — read against: controls — surprised: no; a second field with the same transience question and no real place (so G76's reading "the obstruction is the real place" is testable there, FS-98).
- **Row 93** (ℚ(√2,√3) rigid given T721; "tightness does not propagate", `Λ₅₁₀`'s quotients tight at 14, slack at 24) — read against: controls — surprised: no. The one field of the frame where `F(R) ≠ 0` is known (conditionally): a positive control **with triangles**.
- **E7 (b), V3's certificate dependence** — read against: row 88's grade line "V3 given FS-66's certificates at 11 (and 19 for 83, 131) and `[Zhang2012]` Thm 1.8(i)" — surprised: no. "Not periodic" rests on FS-66 here, unlike ℚ(√47)'s S1a.
- **The last reading's conditions:** J37 read its poster before J45 landed and wrote its gap with Lemma SI's iff (J37 §3.3 (b): "By J36's Lemma SI (one mind), this is the same as saying …"); J45 correction 1 makes that one direction only — read against: my use of J37's class — surprised: no; §3.3 uses J37's class by its factor definition, not by the spectral iff.

### 2.4 Would-have-searched-here log (Stages 1–2)

- Would have searched finitely generated lattices in `R_{ℚ(√59)}` for one with `Θ₄ = ∅`. Instead: a derivation-fixed exact enumeration of
  the local dyadic characters (§2.2), which decides every such lattice at once (restriction), in 0.2 s.
