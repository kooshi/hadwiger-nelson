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

## Stage 3 — SAVED: the poster, its composition, and the shared identity with ℚ(√47)

*Notation (row-88 records, J45): `F` of type (B) (ℚ(√59), ℚ(√83), ℚ(√131)); `R = ℤ[U]`; `X₄(F)` the proper four-colourings of `Cay(R, U)`
(one `R`-coset); **Pull** the 1,179,936 pullbacks `γ ∘ π₄` from row 67's `P₄`; `E_S = T + A + Fin_S`, `E = ⋃_S E_S`; `σ_μ` the trace spectral
measure of the tetrahedral embedding; `X′ := X₄(F) ∖ Pull`, the counterexamples.*

### 3.1 The poster — theorems (one row per constraint on a counterexample `c ∈ X′`)

| # | the constraint, verbatim | scope | grade | address | instrument |
|---|---|---|---|---|---|
| P1 | "every periodic one is local at the dyadic place (`P(R) = R ∩ 𝔓⁴`)" | every finite-index period | [hand, two derivations]; V3 given FS-66's certificates at 11 (19 for 83, 131) and `[Zhang2012]` Thm 1.8(i) | row 88 | Zhang's MIS-normality over the stable towers |
| P2 | "HD1 holds for ℚ(√59), ℚ(√83), ℚ(√131) (every four-colour band character is a dyadic pullback, so no character colouring of those planes is non-periodic)"; `Θ₄(R)` is the 12 order-4 characters of `O/𝔓⁴` | every `θ ∈ R̂`, `x ↦ ⌊4θ(x)⌋` | [hand, compositions of row 95; re-proved through CLG with no FS-66, no Zhang, no Lemma R]; the count [tools exact] | rows 96, 100; §2.2 | Berend-type closed-set rigidity (rows 95, 98) |
| P3 | "a four-colouring read off finitely many local coordinates through measurable windows is one pullback at the tight place, hence periodic" | measurable windows over finitely many places; proper off a null set gives this for a.e. placement (C14′) | [hand, two derivations]; rests on `[AmbrusEtAl2023]` | row 92 | a measurable Zhang product rule |
| P4 | **T-J38-1** (§3.4): no one-character measurable window `x ↦ W(θ(x) + t)`, proper for a.e. `t`, is outside Pull for a positive measure of `t` | one character of any type, any measurable circle window | [hand, one mind; composition of Steinhaus, row 98, Theorem C at `S = ∅`] | §3.4 | band rigidity at every band |
| P5 | row 91's list, verbatim in part: "two-pullback patchworks, one pullback with any residue alternative, defects confined to a half-space, threshold walls, stripes, 2-adically continuous colourings, Kempe swaps, gapped targets of any extension, character colourings of finite type"; H: "a colouring agreeing with a gap-free periodic one on an additive half-space equals it … a non-periodic four-colouring disagrees with every pullback in every archimedean direction" | the named constructions; H for every number field, any number of colours | [hand; two derivations where marked, each with a blind verifier] | row 91 | FS-86's no-go family |
| P6 | "`F(R) ≠ 0` iff every four-colouring of the field plane extends to the local plane, per coset"; the local plane over `ℚ₂(√3)` "is four-colour rigid"; "`4 ∈ F_tf` iff some number field inside `ℚ₂(√3)` carries a finite triangle-free forcer of `(0, 4)`" | the counterexample does not extend to the local plane; ℚ(√59)² carries no finite forcer of `(0, 4)` | [hand + certificate, or given Parts's trees; two derivations] | row 90 | local rigidity (row 78's forced `v`, D2-B) |
| P7 | "no colouring differs from a pullback on a finite non-empty set"; "a defect set against a pullback lies in no finite union of cosets of any finitely generated subgroup of `R`" | against every `p ∈ Pull` | [hand, two derivations]; the second [one mind] | R88-B2-1, R88-J28V-8d | propagation along the 8 of 24 residue classes |
| P8 | "`c ∉ Pull` is transient iff, for every finite `B ⊂ R`, `{t : (t·c)\|_B ∉ Pull\|_B}` has upper Banach density 0"; "a sparse defect is transient"; so `c` is **either transient or its orbit closure carries a translation-invariant `μ` with `μ(Pull) = 0`** | every `c ∈ X′` | [hand, two derivations]; the correspondence in print (`[BergelsonMoragues2021]`) | R88-TA (v), R88-B2-3, R88-CL | the clopen correspondence |
| P9 | **Theorem C:** "every translation-invariant Borel probability measure on `X₄(F)` whose spectral measure is carried by `T + A + Fin_S`, for a finite set `S` of split places, is carried by Pull" | invariant measures, each finite `S` | [hand, two derivations over the three type-(B) fields]; `[AmbrusEtAl2023]`, FS-66 at 11 and 19, C14, Lemmas D and P | row 112, R88-TC | the stationary Zhang count |
| P10 | **B⁺'s dichotomy:** "every `μ` over a type-(B) field is carried by Pull or strictly anticorrelated off every `E_S` at some unit vector" | invariant measures | [hand, one derivation (J45); blind check J46 pending]; given T-C and FS38-D2-A | J45 Stage 3, remark (ii) | SI-3's relatively independent self-joining; gap-freeness of `P₄` |

*Context, not constraints:* `χ(F²) = 4` (Pull ≠ ∅; four needed since `d ≡ 11 (mod 12)`, row 82); the plane is triangle-free (`√3 ∉ F`, G57).

### 3.2 Kept apart — nulls, readings, and a method no-go (these constrain nothing about `c`)

| # | item | kind | address |
|---|---|---|---|
| N1 | no finite triangle-free forcer of `(0, 4)` is known — never searched (FS-90 (c), dated from 2026-10-01) | an absence, not a null | row 90; `plans/FRONTIER-STUBS.md` rank 2 |
| N2 | HD1's finite certificate exists on some lattice; `Λ₅₁₀` not known to carry it | existence only | row 96 |
| Rd1 | "for all colourings the obstruction is the real place (non-real analogues are pinned on `T + A + Fin`)"; killing test "a non-periodic four-colouring of ℚ(√−709)'s plane" | [reading] | G76, row 94 |
| Rd2 | expansiveness at Pull (Boyle–Lind; Einsiedler–Lind–Miles's amoebas) as T-B1's frame | [reading] | R88 §G (J35) |
| Rd3 | "no mechanism forcing positive entropy for the `U`-action on `R̂`" | [reading] | R88 §G (J28D) |
| M1 | "unit-distance pair correlations on any real field admit a purely archimedean spectrum" (C0): any proof must use more than second moments | a no-go about proofs | row 91 |

### 3.3 Composition

**(a) What the theorem rows add up to.**

> *A counterexample `c ∈ X′` is not periodic, not a character colouring, not a finite-place or one-character measurable window (for
> almost every placement), none of row 91's constructions, does not extend to the rigid local plane, and differs from every pullback on
> an infinite set in no finite union of cosets of a finitely generated subgroup. And either (T) `c` is **transient**, or (M) its orbit
> closure carries an invariant `μ` with `μ(Pull) = 0`, and every such `μ` has spectrum on no `T + A + Fin_S` and is strictly
> anticorrelated off every `E_S` at some unit vector.*

Grade: [hand, two derivations] except P4 (one mind) and P10 (one derivation, blind check pending). It does not decide row 88.

**(b) The gap, named — three pieces, two of them type-(B)-only.**
- **G-tr, the transient colourings** (branch (T)). Invisible to every invariant measure (R88-B2-3). Stopped at T-B1 (isolation) and T-B2
  (defect growth), each at one named step in both records. **Empty at ℚ(√47)**, where Pull = ∅ and every `c` has a non-Pull measure.
- **G-f, defect processes over a pullback** (branch (M), with a factor). Measures `μ` with `μ(Pull) = 0` that carry a proper factor
  colouring continuous in probability at finitely many places. Theorem C makes that factor a pullback, so `μ` is a pullback plus a
  stationary defect set of positive density, closed under R88-B2-1's propagation. The lemma that empties it:
  > **DP.** "Over a type-(B) field, a translation-invariant random four-colouring that carries a proper factor colouring continuous in
  > probability at finitely many places is carried by Pull."

  By B⁺ (equality ⟺ Pull), **DP is SI's GAP "carries ⟹ equality" at type (B)**. J45's SI-5 does not reach it: SI-5 needs (G2), a gapped
  vertex, and `P₄` is gap-free. The control is on the other side of that line: J36 F2's noise over ℚ(√11) is a G-f measure that uses the
  gaps of `Γ₇` (J45-SI-C). **Empty at ℚ(√47)** by T-C(A) (no finite-place factor colouring exists there at all).
- **G-n, no finite-place factor** (branch (M), without one). **Exactly J37's class**, by the same definition. It keeps J37's two layers:
  the pure-point layer (Kronecker selection, J37's J1) and the continuous layer (Furstenberg). One difference in the pure-point layer:
  at ℚ(√47) selection's output — a proper window on the `T + A` coordinates — is already a contradiction, while at type (B) it is only a
  factor colouring, a pullback. So at type (B) selection lands the measure in G-f, and needs DP to finish (or a stronger "Kronecker
  rigidity": the window itself reads only the `T + A` coordinates).

**(c) Controls — is each piece known to be non-empty somewhere?**
- G-tr: only in the abstract class. Rank-one distance graphs have transient walls between rigid phases (row 80's T35, cited by §IQ). No
  field.
- G-f: yes, at a slack field. ℚ(√11)'s noisy colourings (J36 F2; J45-SI-C) are non-pullback measures with a finite-place factor. Their
  mechanism, recolouring gapped vertices, is exactly what gap-freeness forbids pointwise; DP asks whether it is forbidden stationarily.
  None at a tight place.
- G-n: none anywhere (J37 §3.3 (c), unchanged).
- Lattice control for EI-1 (owner item 3): not in a type-(B) ring (§2.2).

**(d) Redundancy, and where constraints almost meet.**
- Logically P1 ⊂ P3 ⊂ P9 (a periodic colouring is a finite-place window, and a window's random placement has spectrum in some `E_S`), and
  P2 ⊂ P4 ⊂ P9 once row 98 puts `θ` in `T + A`. P6's first clause is the goal restated locally (the local plane is rigid, so extending
  and being a pullback are one thing); its content is the triangle-free forcer framing.
- Evidentially: P1 rests on FS-66 and Zhang; P2 through CLG rests on neither; P5 (H and the constructions) and P7, P8 rest on no external
  input. P3, P4, P9, P10 rest on `[AmbrusEtAl2023]` (and P9, P10 also on FS-66 at 11 and 19). If that input failed, the poster keeps P1,
  P2, P5–P8 and loses every spectral line.
- **J1 (P5's H and T-B1).** H is isolation from an archimedean half-space; T-B1 is isolation from a finite window. The step between them
  is the records' named step: "unique continuation from a region that is no archimedean half-space".
- **J2 (P8 and P10 meet at T-B1).** Branch (T) is closed by T-B1 (R88-TA (vi)). §3.5 shows that T-B1 also turns branch (M) into
  ℚ(√47)'s remainder.

### 3.4 T-J38-1, with its proof [hand, one mind; a composition]

> **T-J38-1.** Over ℚ(√59), ℚ(√83), ℚ(√131), if `θ ∈ R̂`, `W : ℝ/ℤ → {0,1,2,3}` is Lebesgue measurable and `c_t(x) = W(θ(x) + t)` is
> proper for almost every `t ∈ ℝ/ℤ`, then `c_t ∈ Pull` for almost every `t`.

*Proof.* Steps 1–3 are T-J37-1's (`plans/POROS-2026-09-25-wanted-poster-47.md` §3.4). Steinhaus on a colour class of measure `≥ 1/4` gives
`θ(U) ⊆ [δ, 1 − δ] + ℤ`, so `θ ∈ Θ_k(R_F)` for `k ≥ 1/δ` and, by row 98, `θ ∈ T + A = E_∅`. The Haar placement of `t` is a
translation-invariant probability on `X₄(F)` with spectral measure on `ℤθ ⊆ E_∅`. Theorem C at `S = ∅` (row 112) carries it by Pull. ∎

*Inputs:* row 98 (two blind readings); Theorem C (two derivations; `[AmbrusEtAl2023]` when `θ` has an archimedean part — when `θ` is
torsion, `c_t` is periodic and P1 suffices). *Consequence:* row 96's HD1 (windowless characters) extends to measurable one-character
windows, so FS-64's one-character windowed case at four colours cannot give `F(R) = 0`. *Not claimed:* rank ≥ 2.

### 3.5 T-J38-2 — given isolation, the type-(B) question is the type-(A) question on `X′` [hand, one mind; a composition]

> **T-J38-2.** Let `F` be of type (B), and assume **T-B1** ("every point of Pull is isolated in `X₄(F)`", R88 §G). Then:
> (i) `X′ = X₄(F) ∖ Pull` is closed and `Aff_F`-invariant, and **no translation-invariant Borel probability on `X′` has spectral measure
> carried by `T + A + Fin_S`** for any finite `S` — T-C(A)'s statement, with `X′` in place of `X₄`;
> (ii) if `X′ ≠ ∅`, there is a `U`-invariant finite positive measure `τ` on `R̂` with `τ(E) = 0` and `∫ Re χ(1) dτ(χ) < 0` — a witness
> of J45's SP, hence a `U`-invariant `E`-null measure that is not a multiple of Haar measure;
> (iii) so **MR(F) ∧ T-B1 ⟹ `F(R) ≠ 0`**, where **MR(F)** is "every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a
> multiple of Haar measure" (J45: MR(F) ⟺ no SP witness). Since `F(R) ≠ 0` gives `X₄ = Pull`, finite, hence T-B1: **given MR(F), row 88 is
> equivalent to T-B1.**

*Proof.*
1. T-B1 makes each `{p}`, `p ∈ Pull`, a cylinder set, so Pull (finite) is clopen and `X′` is closed. Pull is `Aff_F`-invariant (R88-TA (i)),
   so `X′` is.
2. (i): a translation-invariant `μ` on `X′` is one on `X₄` with `μ(Pull) = 0`. Theorem C would carry it by Pull if its spectrum lay on
   some `E_S`.
3. (ii): `X′` is a non-empty compact space with a continuous action of the amenable group `R ⋊ U`, so it carries an `R ⋊ U`-invariant
   probability `ν` (Følner averaging; S1b-i's route). `ν(Pull) = 0`. By B⁺, for every finite `S` some `u ∈ U` has
   `∫_{R̂∖E_S} Re χ(u) dσ_ν < 0`. Rotation about 0 fixes the origin's colour, so `σ_ν` is `U`-invariant; `E_S` is `U`-invariant (J45-N1); so
   the integral does not depend on `u` (J45's A⁺ remark (ii)), and is negative at `u = 1`. Take `S = ∅`. By R-U,
   `σ_ν(E ∖ (T + A)) = 0`, so `τ := σ_ν|_{R̂∖E}` has `∫ Re χ(1) dτ < 0`. `τ` is `U`-invariant, finite, positive and `E`-null. Haar measure's
   coefficient at `1 ≠ 0` is 0, so `τ` is no multiple of it (J45's SP "only if", the trivial direction).
4. (iii): MR(F) forbids `τ`, so `X′ = ∅`, `X₄ = Pull`, every colouring is `R ∩ 𝔓⁴`-periodic and `F(R) ⊇ R ∩ 𝔓⁴ ≠ 0`. Conversely `F(R) ≠ 0`
   makes `X₄ = Pull` finite, so every point is isolated. ∎

*Inputs:* T-B1 (**GAP**, both records); Theorem C (two derivations); B⁺, R-U, N1 (J45, one derivation, blind check pending); Følner/Markov–
Kakutani. **Not used:** SP's non-trivial direction, Lemma R, C14.2 (c). *The point J28D already made* (R88 §G: "a full classification of
`U`-invariant measures would leave Q-μ open without T-B1-type isolation"): T-J38-2 says isolation is the **only** thing missing between
the two, and that it closes transience in the same stroke. *Scope:* type (B); it transfers verbatim to every field in Theorem C's class
where B⁺ holds (J45: "every field in T-C's class, `P₄` being that class's tight level").

### 3.6 Owner item 2 — the shared identities with ℚ(√47), stated

| question | answer | where |
|---|---|---|
| **The same class?** | **It contains J37's class and two more.** G-n is J37's class by definition. G-tr and G-f are type-(B)-only: both are empty at ℚ(√47) (no Pull, so no transience; T-C(A) forbids every finite-place factor). | §3.3 (b) |
| **The same missing lemma?** | **Yes, given one type-(B) lemma.** Given T-B1, the ℚ(√59) question is ℚ(√47)'s question on the subshift `X′`, with T-C(A)'s hypothesis supplied by Theorem C (T-J38-2 (i)). Both reduce to the same colouring-free statement, **MR(F)** — J45's SP-Cor at ℚ(√47), T-J38-2 (iii) here. The pure-point route (Kronecker selection) is shared, but at type (B) it needs DP as well. | §3.5; J45-SP-Cor |
| **The same shared input?** | **Yes.** `[AmbrusEtAl2023]`'s `m₁ ≤ 0.2470` (T-C and T-C(A)), FS-66's certificates at 11 and 19 (both), Coxeter's C14 window lemmas (both), J45's SI machinery (both). | R88-TC, R88-TCA |
| **Where it differs** | (1) **T-B1**, a topological finite-window statement with no type-(A) analogue; it closes transience and makes rotation averaging safe. (2) **DP**, needed only by MR-free routes. (3) "Not periodic" rests on FS-66 at type (B) (V3), not at ℚ(√47) (S1a). (4) **Averaging:** at ℚ(√47) Pull = ∅, so averaging over `U` costs nothing (J36 F4); at type (B) a weak-* limit can land on Pull unless Pull is clopen, which is T-B1. | §3.3, §3.5 |

**The difference in kind.** ℚ(√47)'s remainder is MR alone, a measure-rigidity wall (J36 F5: zero entropy is open, as for ×2×3). ℚ(√59)'s
remainder is MR plus T-B1. T-B1 is a **closed-set, finite-window** statement: the kind of statement rows 91 (H) and 95 (Berend) proved.
Under MR, row 88 **is** T-B1.

### 3.7 Would-have-searched-here log (Stage 3)

- Would have hunted a stationary defect process over a pullback (a G-f witness) on a finite quotient. Instead: named DP and located it at
  J45's GAP (§3.3 (b)).

## Stage 4 — SAVED: the name, the killing test, the example invariant, the recommendation, the ledgers

### 4.1 In its discipline's words, and the queries a prior-art job should run (not run here)

**The object.** `X₄(F)` is the four-colour **hom-shift** on the countable, non-finitely-generated abelian group `R`, with the affine group
`R ⋊ U` acting. Pull is a finite set of **frozen** points (`[AlonEtAl2021]`'s word, R88-B2-1). The three pieces of the gap:
- **G-tr**: T-B1 asks whether the frozen points are **isolated**, i.e. whether the hom-shift is **expansive at Pull** (Boyle–Lind's
  expansive subdynamics, J35's reading). Transience is the **measure centre** of an orbit closure lying in Pull (`[ChenDai2017]`).
- **G-f**: a stationary **defect process over a frozen configuration**: an invariant measure that is a **non-trivial extension of a
  periodic factor** (a finite rotation) inside a hom-shift. In probability: can a proper colouring with a *gap-free* periodic factor carry
  independent-looking randomness? The control uses gaps (F2's noise).
- **G-n**: J37's §4.1 names, unchanged (model sets over `S`-adic internal spaces; ×p×q on an `S`-adic solenoid).

**For a stranger.** *In a four-colour hom-shift over the ring `R`, the frozen periodic points are known to be determined by their
complement of any finite set, and by any half-space. Are they determined by one finite window (isolated)? And if so, is every
non-empty closed invariant subset disjoint from them forced to carry a non-Haar invariant measure of the rotation group on the dual —
a Furstenberg-type object?*

**Queries**, each tagged with its discipline:
1. *Symbolic dynamics:* "frozen" & "isolated" & "proper colorings" (or "hom-shift") — does "frozen ⟹ isolated" fail or hold anywhere,
   and under what mixing hypotheses; "expansive subdynamics" & "isolated points"; "strongly irreducible" & "frozen".
2. *Unique continuation for colourings:* "unique continuation" & ("coloring" | "subshift") & "half-space" (H's route); Kari–Szabados
   "forced periodicity" at infinite degree.
3. *Topological dynamics of algebraic actions:* Einsiedler–Lind–Miles–Ward "expansive subdynamics for algebraic ℤ^d-actions" and the
   `S`-adic / non-finitely-generated case (Lind–Schmidt on `S`-integer dynamics).
4. *Invariant measures on hom-shifts:* "invariant measures" & "frozen" & "measure centre"; "periodic factor" & "extension" & "proper
   coloring" & "stationary".
5. *Shared with J37:* its queries 1, 4 (model sets; ×p×q on `S`-adic solenoids) — the MR side is the same for both posters.

### 4.2 The killing test

**KT-1, cheapest and sharpest — the grade of B⁺.** T-J38-2 (ii) and the shared-identity table rest on J45's B⁺, which is one derivation
with J46's blind check pending. *The test:* J46's verdict on B⁺ and on SI-3/SI-4 (the selection step). If B⁺ fails, (i) stands (it needs
only Theorem C), but (ii)–(iii) fall and the two posters are no longer shown to share MR. Cost: already running.

**KT-2 — the shared external input.** J37's KT-1 (`[AmbrusEtAl2023]`'s H4 in ball arithmetic) is this poster's too: P3, P4, P9, P10 and
T-J38-2 all rest on it through Theorem C. Cost: minutes (a tools job, in-ban).

**KT-3 — scope.** T-J38-2 needs B⁺ to hold on the averaged measure `ν`, which is translation-invariant but not ergodic. B⁺ is stated for
every translation-invariant `μ` (J45 Stage 3), so this holds as written. A verifier should read that line against J45's proof, whose
selection is `𝒜_S`-measurable for any `μ`.

### 4.3 Flip the poster: the example invariant

**(a) The candidate: finite-window determinacy of the gap-free periodic colourings — a ladder, two rungs proved.** For a gap-free
periodic colouring `p` (the pullbacks at type (B)), ask how small a region determines `p` among all four-colourings:

| rung | statement | status |
|---|---|---|
| co-finite | agreeing with `p` off a finite set ⟹ equal to `p` ("frozen") | proved, two derivations (R88-B2-1) |
| half-space | agreeing with `p` on an additive half-space ⟹ equal to `p` | proved, every number field, any number of colours (row 91's H) |
| finite window | agreeing with `p` on some finite `B` ⟹ equal to `p` (isolation) | **T-B1, GAP**, the same step in both records |

- *Every colouring we can prove exists carries the property that matters:* at K and at ℚ(√2,√3) (given T721) `X₄` is finite per coset,
  so every point is isolated. At ℚ(√11) the gapped periodic colourings are limits of C9's non-periodic ones (shrink the archimedean
  term), so **gaps break isolation**. The candidate is therefore stated for gap-free colourings only, which is where FS38-D2-A puts the
  tight pullbacks.
- *Held by all, it empties the class, given MR:* T-J38-2 (iii). Without MR it empties G-tr alone, and reduces the rest to ℚ(√47)'s form on
  `X′`.
- *Its shadows on the poster:* P7 (the co-finite rung) and P5's H (the half-space rung).
- *Does §IQ name it?* **Half.** The row-88 §IQ names "transience (the upper Banach density of the places where it is not locally a
  pullback)" as the invariant — the **measure** reading of the same property. It does not name determinacy or isolation, the **closed-set**
  reading. T-B1 appears in §S.1 as a target, not as the invariant.
- *Its killing test, in the abstract class:* row 80's T35 — transient walls between rigid phases in rank-one distance graphs. If those
  phases are gap-free, finite-window determinacy fails without arithmetic, and the candidate needs §IQ's "two or more primes" as band
  rigidity did (row 97). Reading T35's phases for gaps is a record read, not a search.

**(b) EI-2 (J36, J37) at type (B): insufficient alone.** It empties G-n only. With DP it empties G-f as well, and with T-B1 all three. Its
shadow here is P10 (B⁺).

**(c) Does looking for the example invariant beat closing the gap directly?** **Yes, for T-B1, and T-J38-2 is the reason.**
- Closing the gap directly means MR, J36 F5's Furstenberg wall, shared with ℚ(√47).
- The type-(B)-specific content is T-B1 alone: a closed-set, finite-window statement of the kind rows 91 (H) and 95 (Berend) proved. Given
  MR, row 88 **is** T-B1. So T-B1 is the part of row 88 that does not wait on Furstenberg, and its two lower rungs are proved.
- **The unified statement both posters now share** (§4.7): for every real field in T-C(A)'s class or Theorem C's, "MR(F) ∧ Iso(F) ⟹ every
  four-colouring of `F²` is a pullback from a tight place". Iso is vacuous where there is no tight place. At ℚ(√47) it reads `χ ≥ 5`, at
  type (B) row 88.
- Confidence: medium that T-B1 is the better next derivation. It would change on a proof that T-B1 needs a measure input: for instance,
  that the split-dominated re-centring (R88 §G) cannot be closed without an equidistribution statement for `U`.

### 4.4 The cards

question: is-isolation-all-row-88-lacks
  evidence: this record §3.5 T-J38-2 (given MR(F), row 88 ⟺ T-B1; one mind); `plans/R88-derivation.md` §G (T-B1 GAP at "unique continuation from a region that is no archimedean half-space", both records); row 91 H (half-space rung proved); R88-B2-1 (co-finite rung)
  expected: finite-window isolation of gap-free pullbacks follows from the half-space rung plus band-type rigidity at two split primes
  ask: over a type-(B) field, is every pullback determined among all four-colourings by its values on one finite window?
  if yes: T-B1 lands; transience is closed (Q-tr), and row 88 reduces exactly to MR(F), the Furstenberg-type lemma it shares with ℚ(√47)
  if no: the failing colouring is a non-pullback (R88-TA2) and row 88 is answered "no" by the witness
  answered by: derivation
  cost: one derivation job and a blind verifier, solver-free (FS-98 re-aimed)
  hunch: yes, by an ultrametric unique-continuation lemma using two split primes' dense rotations, as row 95 used them for characters
  falsifier: a gap-free periodic colouring of some real field's plane, with two split primes, that is a limit of other colourings
  rank: 1

question: does-an-inert-dyadic-tower-carry-no-band-character
  evidence: §2.2 (the type-(B) tower, `Q = 2`, has no band-4 character at `O/𝔓²` and twelve at `O/𝔓⁴`); J36 §4.1 ("`U₄` has no band-4 character at level one"); CLG (row 100); S1V V3 (ii) GAP
  expected: an inert dyadic tower of norm 4–32 gains band-4 characters at the level where `4O` is reached, as the type-(B) tower does
  ask: for an inert dyadic place of norm Q ∈ {4, 8, 16, 32}, does O/4O carry a character nonzero-band on every norm-one unit?
  if yes: the EI-1 control is not at the dyadic towers; S1V's GAP has no known site left
  if no: a real field whose four-colourable targets are only such places has χ ≤ 4 and Θ₄ = ∅ (CLG), and compactness gives the control
  answered by: run
  cost: an exact enumeration of seconds per local field once a derivation fixes O and the level; the field realisation is a PARI query
  hunch: yes at every Q
  falsifier: a zero count at O/4O for some Q
  rank: 2

### 4.5 Recommendations (ranked, with the default)

| rank | recommendation | alternative weighed | why this one | confidence |
|---|---|---|---|---|
| R1 | **Re-aim FS-98 to T-B1 alone, recorded with T-J38-2.** Statement verbatim for a brief: "Over ℚ(√59), ℚ(√83), ℚ(√131): for each `p ∈ Pull` there is a finite `B ⊂ R` such that every `c ∈ X₄(F)` with `c\|_B = p\|_B` equals `p`. Route through the determinacy ladder (co-finite: R88-B2-1; half-space: FS86-dB-H); the named step is the split-dominated re-centring. Control: at ℚ(√11) a gapped periodic colouring is not isolated (C9 with a shrinking archimedean term), so the proof must use gap-freeness." T-B2 is demoted: T-B1 ⟹ Q-tr ⟹ T-B2 | keep T-B1 and T-B2 co-equal in FS-98 | given MR, row 88 is T-B1 (T-J38-2); T-B2 is implied by T-B1 and is Q-tr's weakest case | medium-high on the re-aim; about 0.5 that T-B1 is true and provable by a closed-set method |
| R2 | **A blind check of T-J38-1 and T-J38-2**, added to J46's list or the next verifier (with J37's T-J37-1) | leave them at one mind | cheap (four and six steps); T-J38-2 is the shared identity the owner asked for | high that both are true given B⁺ |
| R3 | **Record the unified statement** "MR(F) ∧ Iso(F) ⟹ `X₄(F)` = Pull(F)" (§4.7) as the posters' common form in FS-97's stub (spectra reading infinitely many places), so MR has one home for both fields | two stubs, one per field | one missing lemma, one home (the header's rule) | high |
| R4 | **The control card (§4.4, rank 2)** as an in-ban exact job, after a derivation fixes each inert dyadic `O` of norm 4–32 | leave the EI-1 control hunt to after 2026-10-01 | seconds per field; it decides whether S1V's GAP has any site | medium |
| R5 | **DP as a named lemma** on FS-97's line: "over a type-(B) field, a translation-invariant random four-colouring with a finite-place proper factor colouring is carried by Pull" | fold it into MR | it is the MR-free route for G-f and for the pure-point layer at type (B), and it is J45's GAP at the tight level, where SI-5 does not apply | medium-low on its value; its truth is open |
| R6 | **Reading debt:** §4.1's queries 1–3 (frozen vs isolated; unique continuation; expansive subdynamics for `S`-adic actions) | skip | T-B1 may be a known "frozen ⟹ isolated under mixing" statement | medium |

**If Kooshi does nothing:** FS-98 stays with T-B1 and T-B2 co-equal; T-J38-1 and T-J38-2 stay in this record at one mind; the two posters
are carried as separate problems; the EI-1 control hunt waits for 2026-10-01.

### 4.6 Evidence inventory (Stage 1 re-read) and the hunch ledger

- `Stage 1 E2`, the gap contains J37's class plus transience and defect processes — read against: §3.3 (b) — surprised: no (DP located at J45's GAP; SI-5 does not reach it)
- `Stage 1 E3`, isolation is the one type-(B) lemma — read against: §3.5 — surprised: yes (stronger than expected: given MR, row 88 is *equivalent* to T-B1, and J28D had named the dependency)
- `Stage 1 E4`, ℚ(√59) is not the control — read against: §2.2 — surprised: yes (in the residue: level one of the tight tower has no band character, so J36's level-one evidence for the dyadic control sites decides nothing)
- `Stage 1 E6`, a closed-set example invariant — read against: §4.3 — surprised: no (it is finite-window determinacy, a ladder with two rungs proved)

hunch: isolation-is-the-type-b-content
  claim: given MR(F), four-colour rigidity over a type-(B) field is equivalent to isolation of the pullbacks (T-B1)
  basis: derived
  falsifier: a defect in T-J38-2's steps 1–4, or B⁺ failing J46's blind check
  registered: 2026-09-25
  status: open (derived at one mind; confirmation needs a second derivation)

hunch: t-b1-true-by-closed-set-method
  claim: every pullback over a type-(B) field is isolated, provably by an ultrametric unique-continuation lemma using two split primes
  basis: analogy
  falsifier: a gap-free periodic colouring of a real field's plane with two split primes that is a limit of other colourings
  registered: 2026-09-25
  status: open

hunch: level-one-decides-dyadic-band-characters
  claim: a dyadic tower with no band-4 character at level one has none at any level
  basis: prior
  falsifier: a dyadic tower with none at level one and some higher up
  registered: 2026-09-25
  status: killed (by: `data/crunch-2026-09-25/j38-band.out` — the type-(B) tower has 0 at `O/2O` and 12 at `O/4O`)

hunch: dp-open
  claim: a stationary defect process over a gap-free pullback is not excluded by any record
  basis: read
  falsifier: a record proving "finite-place factor ⟹ Pull" at a tight place
  registered: 2026-09-25
  status: confirmed (by: J45 §5.1, "carries ⟹ equality" GAP; SI-5 needs (G2), which type (B) lacks)

**Scored against Stage 1:** E1 confirmed, with the extension form and P4 added; E2 confirmed; E3 confirmed and sharpened; E4 confirmed,
and the level-one residue added; E5 confirmed; E6 moved from "every closed set contains a finite-place colouring" to finite-window
determinacy of the tight pullbacks; E7 (a) and (b) confirmed, (c) became KT-1; E8 confirmed: the reduction is T-J38-2, and the
recommendation is R1.

### 4.7 What the posters share (J37's record exists; J39's does not yet)

- **One skeleton.** (1) Finite-structure exclusions: residue, periodic, character, finite-place window, one-character window (J37 P1–P5;
  here P1–P4). (2) A spectral exclusion on every `E_S`: T-C(A) there, Theorem C here, the same stationary Zhang count. (3) One
  colouring-free remainder, **MR(F)**: "every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar
  measure". J45-SP-Cor reaches it at ℚ(√47); T-J38-2 reaches it at type (B), given T-B1.
- **One unified statement** (a composition of J45-SP-Cor and T-J38-2; one mind): *for every real field `F` in T-C(A)'s class or in
  Theorem C's class S2, MR(F) ∧ Iso(F) ⟹ every four-colouring of `F²` is a pullback from a tight place.* Here Iso(F) is T-B1, vacuous when
  there is no tight place. With Pull = ∅ this is `χ(F²) ≥ 5`; with one tight place it is `F(R) ≠ 0`. In G48's language, it is the
  conjecture's four-colour clause on these classes, modulo MR and Iso.
- **Shared inputs:** `[AmbrusEtAl2023]`; FS-66 at 11 and 19; C14; J45's SI, B⁺, R-U; row 98.
- **Not shared:** Iso and DP exist only where Pull ≠ ∅. Kronecker selection finishes the pure-point layer at ℚ(√47) but only reaches DP
  at type (B).
- **For J39 (ℚ(√167), five colours), a prediction:** its skeleton breaks at step (2). J36 F7 ("a ratio count cannot refuse `k ≥ 5` for
  finite-place colourings"; `m₁ ≥ 0.2293 > 1/5`) says there is no T-C(A) at five colours, so the unified statement has no five-colour
  analogue by this route. The shared identity should be expected at four colours only.

### 4.8 Would-have-searched-here log (Stage 4)

- Would have searched finite quotients for a gap-free periodic colouring that fails isolation (the T-B1 falsifier). Instead: stated it as
  a card and pointed to a record read (row 80's T35 phases, for gaps).
- Would have enumerated inert dyadic local fields of norm 4–32 for band characters. Instead: a card, since a derivation must first fix
  each `O` and the level.

## Theorems this phase proved

| id | statement | grade | address |
|---|---|---|---|
| T-J38-1 | over ℚ(√59), ℚ(√83), ℚ(√131), a one-character measurable window `W(θ(x) + t)`, proper for a.e. `t`, is a pullback for a.e. `t` | hand, one mind; composition of Steinhaus, row 98, Theorem C at `S = ∅` | §3.4 |
| T-J38-2 | given T-B1: `X′ = X₄ ∖ Pull` is closed and satisfies T-C(A)'s statement; `X′ ≠ ∅` yields a `U`-invariant, `E`-null, non-Haar `τ` on `R̂` with negative mean at 1; so MR(F) ∧ T-B1 ⟹ `F(R) ≠ 0`, and given MR(F), row 88 ⟺ T-B1 | hand, one mind; composition of T-A (i), Theorem C, J45 B⁺, R-U, N1 | §3.5 |
| T-J38-3 | for `F` in T-C(A)'s class or in S2: MR(F) ∧ Iso(F) ⟹ every four-colouring of `F²` is a pullback from a tight place | hand, one mind; J45-SP-Cor with T-J38-2 | §4.7 |
| T-J38-4 | at the tight place of every type-(B) field, `\|S₄\| = 24`, `O/4O` carries exactly 12 band-4 characters (all of order 4), `O/8O` no others, `O/2O` none; so `Θ₄(R_F) ≠ ∅` and no lattice in a type-(B) ring is a four-colourable lattice with `Θ₄ = ∅` | tools exact (plant fires) + hand (restriction; HD1 for "all of `Θ₄`") | §2.2, `tools/crunch_j38_band.py` |
| T-J38-5 | at type (B), DP ⟺ SI's "carries ⟹ equality" (for `S` fixed), and the G-f piece of the gap is non-empty at ℚ(√11) (F2) but uses its gaps | hand, one mind; B⁺ and Theorem C | §3.3 (b) |
