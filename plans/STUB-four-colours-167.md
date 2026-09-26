# FS-59 — ℚ(√167): four colours proven; the next question is five (re-aimed at FS-79's close)

**Re-aimed at FS-91's close.** Given CLG_7, `χ_char(ℚ(√167)²) = 8` (row 101; unconditionally `6 ≤ χ_char ≤ 8`): no character colouring with five, six or seven colours exists, so any colouring of this plane with fewer than eight colours — and any falsifier of the prediction "≥ 6" — is one no character gives. The known bracket is `4 ≤ χ(ℚ(√167)²) ≤ 7`.

**At M3's close (2026-09-25):** FS-64's window format at five is reduced to nine places (row 110); a window falsifier of '≥ 6' must read a place above 43 or one of 2, 3, 5, 7, 23, 29, 61 with a real place.

**Provisional bearings, updated at row 88's and FS-67's closes (2026-09-25, J44):** G79 (the wanted-poster session J39 is its first test); G76's row-88 edit does not reach five colours here — the count needs every non-tight ratio below `1/5`, and the real place's `m₁ ≥ 0.229` exceeds it (row 92's "Not claimed"), so row 112 says nothing at ℚ(√167).

**Provisional bearings, updated at the 2026-09-25 crunch's close (M1–M3):** G77 (a character colouring here needs eight colours given CLG, row 101 — look for colourings no character gives) and G76 (the window format at five, row 110).

**At FS-89's close (2026-09-25):** no **character** five-colouring of ℚ(√167)'s plane exists (`LEDGER.md` row 96; `plans/FS89-derivation.md` CL5; hand + cert, given FS-53's and FS-66's certificates at 43 and 23). This stub's question — does ℚ(√167)² need five colours at all? — is untouched: a five-colouring that is no character is not excluded. It removes one kind of falsifier of the conjecture's widest prediction (FS-64's windowless case, FS-83).

**Re-aimed at FS-86's close (2026-09-25):** at four colours no measurable window colouring over finitely many places exists here (row 92, FS86-CL1, one mind); at five colours the window count fails at the real place (Croft's `m₁ ≥ 0.22936 > 1/5`), so the five-colour question is untouched.

> **Re-aimed at FS-85's close (2026-09-24).** ℚ(√167)'s plane is triangle-free (√3 ∉ F), so two FS-85 results bear. **FS85-dB4
> (row 86):** a four-colour forced pair in any triangle-free unit-distance graph gives a triangle-free five-chromatic one by a generic
> chain — Soifer's Open Problem 55.1 — so the chain route's input here (a four-colour forced pair on a lattice over ℚ(√167), chainable in
> the field since the wall is broken) is at least Soifer-strength; price it so. **Coxeter's R2.6 reading** (`plans/FS85-derivation.md`
> §7): in a triangle-free lattice the analogues of the hexagon circles are generically non-torsion, so the spectral mechanism that makes
> de Grey's lattice rigid (row 85, G75) predicts no rigidity here. ℚ(√167) is H6's type (A) — wall-broken with no small gapped plane;
> type (B) is FS-86. Five over ℚ(√167) by a route that needs no forced pair (FS-83, FS-80, a finite refusal after 2026-10-01) is unaffected.

## 00. After FS-81 (2026-09-24): four is a theorem of the family; a ball-and-solver refusal of five is priced out

- **The premise at four is now field-level** (`LEDGER.md` row 82): `χ(ℚ(√167)²) ≥ 4` follows from FS-81's theorem (167 ≡ 11 mod 12),
  besides row 79's certificate; the five listed layers `{vᵏ : |k| ≤ 2}·U^(5³)` carry an explicit structural certificate (row 83).
- **The four-colour hardness band is measured** (row 84), on de Grey's lattice with the certified forcing graph X_A: undecided at
  `d_ball` 8.3–14.7, a certified refusal at 16.6 (R = 1.4), 55 s quiet at 18.41. **A matched-control ask is infeasible**: at ℚ(√47) the
  cheapest survivor needs 1,284 times the control's points to reach that degree, and ℚ(√167)'s lattices are sparser still
  (`L21cc6506`: 2.3·10⁸ points at degree 14). So step 5 below (a ball) is priced out at matched density [reading], and the week after
  FS-81's close bans SAT solvers.
- **The solver-free routes, in order:** the exact `Θ₄` cells of the seven survivors (P3b's finder and FS-79's partial census; a
  full-dimensional cell makes a survivor loose); the chain route on any survivor that stays rigid; FS-80's averaged certificate; FS-83's
  field-level `Θ₅` (a point falsifies the conjecture, emptiness says a character colouring cannot).
- **FS-84** is this stub's sibling at ℚ(√47), where five would pin the value exactly.

## 0. After FS-79 (2026-09-24): `L21cc6506` is loose at four colours, and the instances are the chain's survivors

**What FS-79 settled** (`LEDGER.md` row 81; `plans/FS79-derivation.md` T1, T2, T8–T16, T38–T43):
- **`L21cc6506` is four-colourable** (8 additive colourings into ℤ/4 and a Θ₄ point of order 5,880; T8) **and loose at four colours:
  `F = P = 0`**, from a full-dimensional Θ₄ cell (T38–T40). No pair is forced there, so the chain route (§0′ route 2) has no input on
  this lattice. Its exact target elsewhere (T2): a forced δ that is a unit at every conjugation-stable prime; over ℚ(√167), 2, 3, 5 and 7
  are all invertible in `ℤ[U]`.
- **§0′'s route 1 was run** as FS-79's phase 0 (`data/fs79/records/phase-P0.md`): the circle mod 23 classified at four colours (T11);
  the saturated chain `Λ_M` swept on **a finite part** — every `M ≤ 2,520`, then the multiples of 420 and 2,520 to 30,240 (T13); 118 of
  130 screened lattices four-colourable, 39 loose by a gap (T15); **7 minimal survivors** — Λ₂₄₄₈, Λ₂₃₂₈, Λ₂₄₀₀, Λ₄₂₀₀, Λ₁₀₉₂₀, Λ₁₄₂₈₀,
  Λ₂₄₃₆₀ — **of capped screens, not refusals** (the survivor table in the record lists each one's screens and budgets). At the ramified
  prime 167 none coloured at 300 s; three have no gapped colouring there by one solver's unchecked UNSAT (T16).
- **P3b** (`data/fs79/records/phase-P3b-survivors.md`; FS79-T44–T49) aimed an exact Θ₄ finder at the seven — HiGHS proposing band
  vectors, each cell re-solved exactly, every witness certified by the phase-0 checker — and found **no point on any in 1,100 s**,
  calibrated by three known positives at the survivors' coefficient size (Λ₁₃₄₄, Λ₁₅₈₄, Λ₂₃₅₂), each found loose within 150 s. That
  is a finder's null, not an empty Θ₄: the exact emptiness tree was priced from a pilot at ≥ ~1.5·10⁷ nodes for Λ₂₄₄₈ (~2·10⁹ by
  determinant scaling; neither is a count) and not attempted. **No quotient colours any survivor**: refused at `N = 13` (Λ₂₄₄₈, Λ₂₄₀₀,
  Λ₄₂₀₀ and its five superlattices, Λ₁₄₂₈₀, Λ₂₄₃₆₀) and at `N = 14` (Λ₂₃₂₈ replicated; Λ₂₄₄₈, Λ₂₄₀₀ by one solver); undecided at
  Λ₂₃₂₈'s `N = 13` and Λ₂₄₄₈'s `N = 15`; Λ₁₀₉₂₀'s first admissible `N ≥ 13` is 16, unasked. Phase 0 had missed that Λ₂₄₄₈ is admissible
  at `N = 11`; it refuses there, replicated. Every quotient verdict is a solver's with no checked proof, and a quotient refusal is not a
  refusal of the lattice.
- **Prices, with their caveat:** every candidate's degree-18 ball holds ≥ 1.38·10⁸ points, the cheapest survivor's 1.57·10¹¹ (T13). Those
  are balls at G65's **three-colour** degree aim; the four-colour hardness band is unmeasured.

**What five here would and would not do** (FS-81's opening, 2026-09-24): the conjecture predicts at least six at ℚ(√167), so a five
confirms and **cannot falsify**; the prediction falls only to a colouring of the whole plane with ≤ 5 colours, local at no prime, which
only FS-64 aims at. §1's "a proof that three suffices kills the main clause" was two-sided when written and stopped being so when four
was proven (row 79). The long-run case is the advisor's six-arena reading [reading, Poros, 2026-09-24]: ℚ(√167) is the smallest 6-open
real field and every lattice over it has rank ≤ 4, so the conjecture predicts a six-chromatic unit-distance graph inside a Cayley graph
of ℤ⁴ there — the cheapest arena for six by rank. Where the conjecture predicts exactly five against a proven four (ℚ(√47) first) is
FS-81's last phase.

**Next, cheapest first** (the owed work from phase 0's trimming, close-inventory items 54, 60, 62, 98):
1. **Quotients at `N ≥ 16`** on all seven and `N = 15` on all but Λ₂₄₄₈ (P3b reached `N = 13–15`; the admissible `N ≤ 24` per lattice are
   listed in its record), longer asks at Λ₂₃₂₈'s `N = 13` and Λ₂₄₄₈'s `N = 15`; fix `quot_total` and P3b's cap, both checked only between
   asks.
2. **Longer residue asks** at 59, 67, 71, 79, 83 and 29 (phase 0 used 15–30 s), the seven undecided 43-sets at 300 s, and the
   classification at 43 (only the sets real lattices produce were asked).
3. **A real price of the exact Θ₄ tree** — one subtree of Λ₂₄₄₈ run to completion, then a sample — and a **second finder with a
   different search order** (P3b's HiGHS found nothing in 1,100 s): one full-dimensional cell makes a survivor loose (G73), and an
   exhausted tree would show it has no circular colouring (not that it refuses four).
4. **Kempe period groups** of every colouring found (G68), and the question P3 left at `L21cc6506`: do finitely many periodic
   colourings' Kempe groups already meet in 0 there, or does its looseness need infinitely many (FS79 §6 R7)?
5. **Route (ii)** on any survivor that stays rigid (a forced δ prime to 23, 43, 59, …; G55).
6. **Derive the `8 ∤ M` pattern** (FS79 §6 R1): along the multiples computed, ℤ/4-colourings appear exactly when `8 ∤ M` — a 2-adic
   statement beside `1/2 ∈ ℤ[U]` (G35, G41), an hour's derivation.
7. **A ball only after**, and only once the four-colour hardness band is measured on refusing controls (phase 0's encoder `refusal_ask`
   exists, untested; FS-73's 2,044-point graph and Heule-510 are the controls).

The obstruction route that needs no ball — a window-frequency certificate kept small by the symmetry — is FS-80
(`plans/STUB-window-frequency-certificate.md`), not this stub.

**Provisional bearings, updated at FS-79's close:** G73 (no cell-local certificate; one full-dimensional cell makes a lattice loose),
G68 (corrected: a gap or finitely many Kempe groups meeting in 0 is sufficient for looseness, not necessary), G21 (a one-period census,
and a finder that stops at its first point, measure themselves), G72's *Do* (aim every new exact tool at the survivors the day it
lands), G55 with FS79-T2, G65 (the four-colour band unmeasured).

## 0′. After FS-73 (2026-09-23): the first question is answered, and the stub's question is now five

**`χ(ℚ(√167)²) ≥ 4`** (`LEDGER.md` row 79; `plans/FS73-derivation.md` T39–T45). FS-61's lattice `L21cc6506` (60 unit vectors,
denominator 420) has an empty rotation set `Θ₃`, so it has no proper three-colouring — three independent exact certificates, four
checkers, and a half-page hand proof on 36 of its vectors (`{1, v, z}·U_R`, a minimal obstruction). No finite non-three-colourable
graph is exhibited; compactness guarantees one. The conjecture's prediction here (≥ 6) now stands against a proven **4**. Whether the
bound is in print: not found (zbMATH and the held Polymath16 threads, FS-73's close). The kernel route is FS-75
(`plans/STUB-three-colour-criterion-kernel.md`).

**How it was found — none of §3's routes.** FS-73's screen explained FS-61's null (row 79): 52 of FS-61's 57 lattices carry certified
gapped periodic three-colourings (`L3e1c94c6` at period 23, a residue colouring at `(23, √167 − 11)`), 3 are 3-integral, `Ld14c588b`
colours by a linear form of period index 1,080, and `L21cc6506` alone refuses — decided by the three-colour theorem (G71), not by a
ball. **Its structure is a twisted multilayer**: `U = {1, v, v̄, z, z̄}·U_R`, the 12 rational unit vectors in five rotations, and
`v = (83 + i√167)/84` is the type-M rotation at `n = 42` (G7, G62) — **the same unit vector `[Fischer1990]` Example 4 used in 1990 to
show this field has no additive `k`-colouring for `k < 11`** (§2 below). R9's chain route on Kooshi's triangle is superseded at three
colours: `Θ₃` decides three-colourability on any lattice, exactly, with no forcer.

**The question now: does ℚ(√167)² need five colours?** It is a **four-colour** question, and G71 says four colours have no height, no
slope and no `Θ`: a refusal is a finite graph again, and a forced pair is a four-colour compulsion. Routes, cheapest first:

1. **Implementer C's design rule, re-run at four colours** (the rule is colour-generic; `data/fs73/records/phase-P2b-q167.md`, "The
   residue-set rule for FS-59"). A lattice can refuse four colours, or carry a four-colour forced pair, only if **every** screen fails:
   at each prime of residue field `𝔽_q` (23, 29, 43, …) the unit vectors' residue set refuses four colours, no circular form and no
   quotient `Λ/NΛ` four-colours it (G68, the Kempe-period criterion where colourings are gap-free). Γ₂₃ refuses five (row 71), so it
   refuses four; **which residue sets at 23 and 43 refuse four colours** is the first table — minutes, like C's three-colour one
   (224 classes at 23). Screen `L21cc6506` first (its periodic four-colourings, gapped or not), then FS-61's richest lattices.
2. **The chain route at four colours** (G55): a four-colour forced pair at `δ` on a ℚ(√167) lattice with `1/δ` a sum of unit vectors
   gives `χ ≥ 5` in the field itself; `1/2, 1/3, 1/7 ∈ ℤ[U]` here (`[Fischer1990]` Ex. 4), so chainability is plentiful. The forced pair
   needs rigid fabric (G69): only a lattice passing route 1's screens can carry one.
3. **A ball and a solver**, aimed by G65 (degree ≥ 14; the cheapest three-colour candidate passing both screens already cost
   3.4·10⁷ points), only after 1–2 name a lattice.

**Registered expectation (candidate, for the subplan):** route 1 finds most of FS-61's lattices four-colourable with a gap at 23 or
43 (loose), as at three colours; if every lattice at `M ≤ 420` is loose at four, five over ℚ(√167) needs lattices beyond FS-61's
depth, and the stub is priced by that.

*Sections 1–5 below are the four-colour question's record (2026-09-17 to 2026-09-22), kept as written: the instruments they
describe (R5's degree law, R6's growth, R7's dial, R8's order parameter) carry over to four colours; the three-colour routes R1–R4
and R9 are answered by §0′.*

*Minted 2026-09-17 at FS-58's close. Written for a session with zero conversation memory. Read beside: `plans/FS58-four-colours.md`
(§2 D1–D3, §R-B2–B5, §C), `plans/FS58-prelude-seven-cycle-gadget.md`, `data/fs58/search-167/README.md`, `CLAUDE.md` G59, G60, G61.*

## 1. The question, in plain language

Colour the points of the plane whose coordinates lie in ℚ(√167) so that points at distance exactly 1 differ. Our local–global
conjecture predicts at least six colours are needed (no small residue plane bounds this field). **Nothing above three is proven.** FS-58
proved four for ℚ(√11), ℚ(√23), ℚ(√71), ℚ(√95), ℚ(√191) (four is exact there) and ℚ(√47) by finite certified graphs, and the same
instruments found nothing over ℚ(√167).

**Raised to rank 1 on 2026-09-17, and the reason changed the stub's purpose.** Kooshi adopted the local–global conjecture and set the
target at seven (`CLAUDE.md` § The mission). That makes this field the place to *attack* the belief rather than assume it: with G64,
the conjecture's proved range is L ≤ 3 generally, L ≤ 4 given √3 and L ≤ 5 for multiquadratic F ⊇ K; **L = 6 has no instance at all if
the wall holds; and L ≥ 7 is Hadwiger–Nelson itself.** So the cases between "proved" and "the whole problem" are nearly exhausted, and
**ℚ(√167) is the cheapest one left** — predicted ≥ 6, proven 3, with a three-colour gap at discriminant 668. A four here confirms the
level-4 clause at a field outside every proved class; **a proof that three suffices kills the conjecture's main clause outright**, which
is the single most valuable negative available to this project. Run it to find out which, not to confirm either.

## 2. What is known

* **The 3-adic barrier** [kernel, `ThreeAdicBarrier.lean`]: every unit-distance graph over ℚ(√167) whose edge directions have
  denominators prime to 3 is 3-colourable. A four-chromatic graph must use a direction with 3 in its denominator.
* **Two routes landed elsewhere** (FS-58 §R-B3, §R-B5): (a) a forced pair at `3u` in a thick piece of a 3-integral pool, then a
  four-copy chain (ℚ(√11)); (b) a ball in a *saturated 3-non-integral lattice* with short odd cycles refusing three colours outright
  (ℚ(√23), 47, 71, 95, 191). Every hit came from a lattice with covolume `≥ 10⁻⁴` and an odd cycle of length `≤ 9`.
* **ℚ(√167) at the height searched** [tools, `data/fs58/search-167/`]: 755 orbit classes to denominator 2520; no 3-non-integral
  saturated lattice of covolume `≥ 10⁻⁵` has an odd cycle within a 20,000-point cap; the coarse lattices with 7-cycles are 3-integral
  (3-colourable by the barrier). The quotient filter (a lattice with a 3-colourable finite quotient never refuses) kills 28 of 31
  candidates; of the three live, one is 3-colourable to 3,065,169 points, two are `Unknown` at 1,800 s (2.36M, 4.46M points).
* **`[Fischer1990]` singled this field out in 1990** (his Example 4, re-read 2026-09-20): 167 is the first `N ≡ −1 (mod 24)` that is also `≡ 6 (mod 7)`;
  with the unit vector `(83 + i√167)/84` he gets `1/2, 1/3, 1/7` in the unit-vector ring and concludes that ℚ(√167)² has **no additive `k`-colouring for
  `k < 11`** — *"even though the plane … can be 7-colored since ℝ² can, it has no additive 7-coloring."* That is the upper-bound side of this stub seen
  thirty-six years early: no additive (linear) colouring can bound this field below 11, so any ceiling under 7 must be non-additive (FS-64, FS-66).
* **FS-61's census (closed 2026-09-20) asked 167 under the same rules as thirty-nine other fields**: `data/fs61/aiming-167.md` lists its sixteen `Open` lattices at
  depth 420 with covolumes and the best degree each reaches under a 2,000,000-point cap (one reaches 8; it was asked at degree 14 and coloured in 3.66 s).
* **Periodic colourings of 3-integral pools are affine** (FS-58 R-B1) and tensor products of the 3-adic plane with non-3-colourable
  residue planes are rigid (§0 O7): the rigidity that made ℚ(√11) land is present; what ℚ(√167) lacks at low height is short odd cycles
  through coarse, 3-non-integral structure.

## 3. Routes, cheapest first

* **R1 — decide the two live balls** (`q1+132+396.2` at 2.36M points, `q1+324+1620` at 4.46M): a checkpointed long solve or
  cube-and-conquer (price cubes on a sample first; break symmetry). A refusal is the result, via extraction as in FS-58 B5.
* **R2 — search beyond denominator 2520** for a saturated 3-non-integral lattice with an odd cycle, running the quotient filter before
  any ball (the filter is minutes, a ball is hours).
* **R3 — the chain route on 3-integral pools with 7-cycles** (FS-58 D3): thick pieces of `W₁₄₀` (covolume `2.8·10⁻⁵`, coordinates to 49)
  need physical margins that cost `10⁷` points; design pieces from the forcer shape found over ℚ(√11) (the 52-point forcer runs along a
  rational direction) rather than boxes.
* **R4 — the theory:** is the infinite 3-integral graph rigid at three colours (FS-58 D3.5: a finite forcer exists iff it is)? A proof
  would settle ℚ(√167) without a search.

## 3a. Traverse, don't search — four instruments recorded 2026-09-20 (from a conversation with Kooshi during FS-61)

*Kooshi's question: balls with colourings decide quickly; is there a cliff between three-colourable and not, and can the search be
turned into a gradient or a bisection instead of a blind enumeration of balls? The answer was already in FS-61's records. Written
here for a reader with no conversation memory; the measurements are FS-61's (`plans/FS61-quadratic-census.md`, "The owner's re-plan
after phase B′", ruling 3a; raw data `data/fs61/fields/*/balls.jsonl`).*

**What the records show (the phase diagram).** Put every asked ball at its **average degree** `2·edges/points` (734 balls, all tiers
and fields of FS-61): under degree 4 every ball is three-colourable in a fraction of a second; **degree 4–6 is the hardness peak —
39 of the 70 `Unknown`s, and every decided ball there is colourable** (random graphs have their 3-colouring threshold at degree
≈ 4.7; 25 `Unknown`s sit on control planes that are 3-colourable by theorem); **no ball below degree 6.6 has ever refused**; from
degree 14 up **nothing is undecided** — among balls of ≥ 200,000 points, 28 colourable and 15 refused, slowest 259 s. On a fixed
refusing lattice the *smallest* refusing ball is the slow one and larger radii refuse in seconds (47: 104 s at `R = 1.2`, 0 s at 1.5;
119: 114 s → 1 s; 95: 32 s → 1 s). **So hardness is not the signal of having crossed to four colours — it is the signal of standing
near the threshold, from either side — and the move is away from it, toward higher degree, where both answers are cheap.** Size is
not the wall; degree is.

**R5 — aim every ask by degree (solver-free, the gradient itself).** `degree ≈ g·φ(R)²`, `g` the lattice's unit-vector count,
`φ(R) = [2R²·acos(1/(2R)) − ½√(4R² − 1)]/(πR²)` the overlap of a radius-`R` disc with its unit translate, squared because a ball is a
bidisc (observed / predicted over the 734 balls: median 1.000, range 0.715–1.184). **Figure of merit of a lattice:
`N₁₄ = π²·R₁₄⁴ / covolume`, the points needed to reach degree 14** (`R₁₄` solves `g·φ(R)² = 14`). Rank every 3-non-integral
saturated lattice by `N₁₄` before any ball is built; ask once, at `R₁₄`; **never step down in radius** (FS-61's tier-`1b` ladder
1.5 → 1.2 → 1.0 stepped down in degree, into the hard band, and 24 of its 37 asks came back undecided). This also re-aims **R2**:
the lattice search beyond denominator 2520 should *maximise `g` at given covolume*, not merely find an odd cycle. **At 167:** the
best lattices known have `g` = 20–36 against 108 for the lattice that landed 11 — that, in one number, is why 167 is hard. The
36-vector lattice (`120|1,1,1,3;0,2,0,2;0,0,2,2;0,0,0,4`) reaches degree 14 at `R ≈ 1.67`, about 1.5 M points (5–8 GB, one worker);
the 20-vector lattices cannot reach degree 8 under 2 M points. **FS-61's tier `1c` asked it (2026-09-20): degree 14.0 on 1,474,541 points, three-colourable in 3.66 s** — so the
best lattice known at 167 is, on this evidence, colourable at every radius; at `NMAX = 420` 167 has 16 `Open` lattices, and almost
none reaches degree 8 under 2,000,000 points. 167 needs lattices with more unit vectors, not deeper asks of these. **Check first:** at what degree did FS-58's two `Unknown` balls (2.36 M and 4.46 M points, R1 above) sit? If under ~8,
R1 as written is aimed at the hard band and should be re-aimed before any cube-and-conquer is priced.
*Monotone axes that make bisection sound:* radius (balls are nested, so refusal is upward-closed in `R`); lattice inclusion
(`Λ ⊂ Λ′` ⟹ refusal passes up, colourability passes down — **verify whether the census driver propagates verdicts along inclusion;
if not, some `Open` lattices are already decided for free**); colours `k`.

**R6 — counterexample-guided growth: build the core bottom-up, staying on the cheap side.** The certified cores are tiny — 131 to
1,190 points — yet they are found by refusing balls of 45,000–600,000 points and shrinking (assumption cores, then deletion: hours
at 95). Invert it. Start from a short odd cycle through a 3-non-integral direction (the barrier, row 72, says one is needed). Loop:
(1) find a 3-colouring `c` of the current piece `P` — cheap, `P` is small and colourable; (2) collect the **killers** of `c`: lattice
points within the allowed region whose neighbours in `P` already show all three colours under `c` (adding one makes `c`
inextensible — this project's *fan / coverage* compulsion, rows 3–4, G13); (3) add a small batch chosen to kill the most colourings
in a *sampled pool*, not just `c` (M50's batch-halo idea, G33: batches compose by construction); repeat. It ends when `P` refuses —
and `P` is near the true core's size, so the refutation and its LRAT are small and there is no deletion stage — or when some
colouring has no killer in the region, which is a verified colouring of that region (a `Colourable` record). **Progress is
measurable at every step** (pool colourings surviving; R7's dial on `P`), which is what a ball refusal never gives. The lattice is
translation-invariant, so the obstruction is everywhere and the seed's position is free. *Pitfalls:* greedy growth can bloat along
one direction (keep `P` inside a ball of radius ~1.5: every refusal on record fits in diameter ≤ 3.6); near the end `P` enters the
hard band, but at thousands of points, not hundreds of thousands; a sampled pool measures the solver (row 13), so diversify the
sampler. *Controls before believing anything:* on 47, 71 or 119 it must reach a refusing piece of the order of the known cores
(169, 131, 456 points) in minutes; on a control plane (ℚ(√2), ℚ(√7)) it must terminate with an extending colouring and never
refuse; a planted missing edge must turn a refusing piece colourable.

**R7 — the rigidity dial: how close is a colourable piece to the cliff?** Sample many 3-colourings of a colourable ball (random
phases and seeds, a local-search sampler beside CDCL), normalise by the pinned edge, and aggregate **by difference vector `δ`**
using translation invariance: `P_same(δ)` = the fraction of (colouring, position) samples with `c(x) = c(x + δ)`. A free system
reads 1/3; structure shows as `P_same(δ)` near 0 or 1; **a forced pair is `P_same(δ) = 1` over all colourings.** The dial is the
fraction of probed `δ` that never vary, tracked against `R` and across lattices: it should climb toward the refusal radius, so it
ranks lattices from the *colourable* side, where every ask is cheap. **And it feeds the chain route directly (R3/R4, G55):** a `δ`
that never varies is a *candidate* forced pair; confirm it with one pinned refusal (`c(x) ≠ c(x + δ)`) on a small piece; and at 167
the chain's arithmetic hypothesis is nearly free — no usable prime below 23 means 2, 3, 5, 7, 11, 13, 17, 19 are all invertible in
the unit-vector ring, so *any* forced pair at a `δ` built from those primes lands the next colour, at three colours and again at
four and five. *Caveat, from this project's own ledger (row 13): pool statistics measure the solver, not the colouring space — a
never-varying `δ` is a candidate until the pinned ask refuses, and the dial is for ranking, never for a claim.*

**R8 — the order parameter on the refusing side.** For a ball that may refuse but will not decide, give a *finder* four colours and
minimise the number of vertices using the fourth (local search; the GPU's kind of work). Zero is a 3-colouring. A density of
fourth-colour vertices that stays clearly positive across many restarts is evidence — never proof — that the lattice refuses, and
how deep; its reciprocal estimates the core's size, which prices R6's growth budget.

**R9 — Kooshi's triangle as the seed of a forcer: the chain route, re-priced** (recorded 2026-09-20; he raised the triangle again
the day the phase diagram was found, and the two fit). *The object* is recorded in full, with credit, in
`plans/FS58-prelude-seven-cycle-gadget.md`: ℚ(√167)'s shortest odd cycle is a 7-cycle drawn as a triangle — a **run of three
collinear unit edges** from `0` to `3w`, `w = (0, −1)`, closed by two legs, each the long diagonal of a unit diamond
(`cos θ = 24/25`), apex `(√167/10, −3/2)`; 9 points, 11 unit edges; the Moser spindle is the same family's run-of-one member. **All
of its directions have denominator 140 — no 3 — so by the kernel barrier (row 72) it can never refuse on its own**, and the prelude's
experiment (unions of rotated copies to 50,000 points, 3-colourable in 0.6 s) confirmed that. What that experiment never asked is
the question the triangle is shaped for:
* **Its base is the chain route's target pair.** The kernel proof at ℚ(√11) rests on a 52-point forcer that makes `c(0) = c(3u)`
  along a rational direction; in any affine (rigid) 3-colouring of 3-integral material `3w` is a period. So the base `(0, 3w)` is
  the natural candidate forced pair at 167 and the triangle the natural seed. **The ask: on a piece of the pure 3-integral pool
  `W₁₄₀` (where the 7-cycles live) containing the run, is there a 3-colouring with `c(0) ≠ c(3w)`?** `UNSAT` is a finite forcer.
  Use only 3-integral material: the prelude measured that mixing in 3-non-integral rotations kills every additive colouring (16 → 0)
  and with them the rigidity a forcer needs. Its `R = 140` control had 16 additive colourings; whether it had any *non*-additive one
  was not asked — that is this ask.
* **The chain is explicit and short** [exact arithmetic, checked 2026-09-20]: with `w₂₄ = ((11 + √167) + i(−11 + √167))/24` and its
  Galois conjugate `w₂₄′ = ((11 − √167) + i(−11 − √167))/24`, both unit vectors, `w₂₄ + w̄₂₄ + w₂₄′ + w̄₂₄′ = 11/6`, so
  **`1/6 = 1 + 1 − w₂₄ − w̄₂₄ − w₂₄′ − w̄₂₄′` and `1/3` is a sum of twelve unit vectors**: twelve transported copies of the forcer
  chain `0` to `1` by periods `3uᵢ`, and the unit edge `(0, 1)` closes it (G55; FS-58 did it with four at ℚ(√11)). The 3 in the
  denominator enters only through the transports, exactly as the barrier requires. A shorter representation of `1/3` may exist; this
  one suffices.
* **The route needs nothing that 167 was found to lack.** R5's finding is that 167's *3-non-integral* lattices hold too few unit
  vectors (20–36) to refuse. The chain route never refuses a 3-non-integral ball; it needs a finite forcer in the 3-integral pool,
  and the denominator-140 lattice is rich (the prelude's `R = 140` union shows 50 directions up to sign — about a hundred unit
  vectors; **check the count**) at covolume `2.8·10⁻⁵`.
* **Re-priced by the phase diagram.** FS-58 (D3) priced *box-shaped* thick pieces at `10⁷` points and stopped (R3 above). A capsule
  around the run `[0, 3w]`, or a ball of radius ≈ 1.6 about its midpoint, is of order one to two million points at an average degree
  in the thirties — the regime where every ask on FS-61's record decided in seconds to minutes, colourable or not. It is **one pinned
  ask**, memory measured first (edges, not points, set the footprint at that degree). `UNSAT` ⟹ extract the forcer's core ⟹ twelve
  copies and an edge ⟹ **χ(ℚ(√167)²) ≥ 4**, the jackpot of this stub, by the route the kernel already knows. `SAT` ⟹ a verified
  non-affine colouring of that piece: thicken, or run R6 seeded on the triangle with the pin `c(0) ≠ c(3w)` as its target and R7's
  `P_same(3w)` as its progress bar.
* *Before running:* read FS-58 §D3 and §R-B3 for what was actually asked of `W₁₄₀` (so this is not a repeat); confirm `g`; and keep
  the control — the same pinned ask on the ℚ(√11) pool must reproduce the known forcer.

**Order for the subplan:** **R9's one pinned ask is the cheapest decisive experiment in this stub and goes first**, after its
"before running" checks. R5 is free and comes with it (it is a table). R6 with its controls is the instrument to build. R7 is an
afternoon on top of any sampler and serves both R6 and the chain route. R8 only if R6 stalls. R1's long solves come after all of
them, re-aimed by R5.

## 4. Registered expectations (candidates, to be registered at the subplan)

* R1 refuses at least one of the two live balls (low, 0.25): nothing in the colourable neighbour suggests it.
* R2 finds a qualifying lattice below denominator 10,000 (medium, 0.4).

## 5. Failure and jackpot clauses

* **Jackpot:** `χ(ℚ(√167)²) ≥ 4` — the conjecture's lower levels at the field it predicts six for, and FS-56's carried target.
* **Informative failure:** a proof that every graph over ℚ(√167) up to some height is 3-colourable by an explicit non-residue rule.
* **Not a failure:** an `Unknown` at a budget.

**Bearing on χ(ℝ²) ≥ 6:** none directly; high for the conjecture's account of fields no residue plane bounds.

**Provisional bearings, updated 2026-09-22 (FS-70's close):** G68 (the quotient/fan-gap screen — at three colours a gapped periodic 3-colouring of the lattice R9 would build on kills its chain route by theorem; run it first, minutes), G69 (rigidity prime by prime: the CM field of the 7-cycle triangle's directions, its primes above 5, 7, 11, 13 classified, decides whether any lattice there can be rigid), G65 (the shell-indexed core ceiling on word balls), FS70-T10 (the periodic Kempe screen, `tools/fs70_periodic_kempe.py`, needs only a generator grammar for the field).

**Provisional bearings, updated 2026-09-23 (FS-73's close), for the five-colour question:** **G71** — four colours carry no height,
slope or `Θ`; decide nothing at four by a polytope, and expect a refusal to be a finite graph again. **G68 / G69** — at four colours the
screens are colour-generic: a gapped periodic four-colouring kills a lattice's forcing by theorem, and where every colouring is gap-free
compute the Kempe period groups (L3's lesson) before calling it rigid. **G62 / G7** — factor every lattice's unit vectors as rotations
times a base pattern before any tree: `L21cc6506` is a five-layer twist at `n = 42`. **G55** — the chain route, with `1/2, 1/3, 1/7 ∈
ℤ[U]`. **G21** — a periodic search measures its period cap (FS-73 twice). **G65** — aim balls by degree. Row 79; FS73-T17–T20 (C's
screen and design rule), T26–T28, T39–T45.

## Where the 2026-09-25 work on this lives

*Addresses and titles only, added by the 2026-09-25 crunch's bookkeeper (job J30). The index of that day's work, with its results, is `plans/CRUNCH-2026-09-25-INDEX.md`; a blind verifier does not open it.*

- `plans/FS91-S1D-six.md` stages 3–5 — job J08's record: character colourings at ℚ(√167) and the window members
- `plans/FS91-S1V-six.md` — job J11's record: its blind verification
- `plans/FS91-S1D-character.md` §4.4 and `plans/FS91-S1V-character.md` §2.3 — jobs J07 and J10 on C-167
- `plans/M3-S1D-windows-five.md` — job J21's record: measurable windows over ℚ(√167) at five colours
- `data/crunch-2026-09-25/reports/J08.md`, `J11.md`, `J21.md` — the job reports
- `plans/FS91-close-inventory.md` rows 81–85, 106–110 and `plans/M3-close-inventory.md` rows 16–26 — items for this stub (row 85 of the first: its re-aim)
