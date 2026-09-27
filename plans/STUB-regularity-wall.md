# FS-106 and FS-107 — the regularity wall, and its stability form: can vanishing holes save a colour? (stub; the program Kooshi adopted)

> **Banner (FS107-C, 2026-09-27).** **FS-107 is closed** (`plans/FS107-stability.md` §R-close; `plans/FS107-derivation.md`; `LEDGER.md` row 133 as
> drafted): both claims GAP; R's reduction (a forced complementary pair plus a cone-scale bound) and W's equivalence (vanishing holes at bounded
> complexity ⟺ a tight six-map) meet at one question. Its successors: **FS-110, the tangency seam** (`plans/STUB-tangency-seam.md`; SWAP-PRICE folded
> in), **FS-111, the cone scale** (`plans/STUB-reg-scale.md`), and C-VOID's thin-hole test folded into FS-109. The FS-107 section below is kept as it
> was re-aimed at FS-106's close.

> **Banner (FS106-C, 2026-09-27).** **FS-106 is closed** (`plans/FS106-regular-half.md` §R-close; `plans/FS106-derivation.md`; `LEDGER.md`
> rows 131–132): the regular half verified and transferred almost everywhere bar named steps, and the measurable question restated exactly as
> stability — with no MR, `χ_m⁰(ℝ²) ≥ 7 ⟺ lim_{ε→0} µ₆(ε) < 1` (row 131). **FS-107 is renamed "stability: can vanishing holes save a colour?"**
> (the owner's ruling, 2026-09-27, `plans/FS106-close-inventory.md` item 77) and re-aimed below from the advisor's design
> (`plans/POROS-2026-09-27-fs106-close-and-fs107.md` §3). The FS-106 section is kept as it was minted, under its own banner. Residuals: FS-108
> (`plans/STUB-regular-half-residuals.md`); the post-ban dial: FS-109 (`plans/STUB-hole-dial.md`).

*Minted 2026-09-26 by the product owner (the top-level session), from its own reading after FS-103 and FS-105 and Kooshi's rulings the same
evening. Ranks 1–2 in `plans/FRONTIER-STUBS.md`. **Solver column: none** — reading, derivation and Lean; no finite-witness search (Kooshi:
*"search for a finite graph is out. It would be huge, not feasible."*). Written for a session with zero conversation memory; read
`CLAUDE.md` § The aim and § Counter-priors first — they are this stub's frame, and their rules bind every job under it.*

## Kooshi's words (2026-09-26, verbatim)

- *"My goal is to fully solve, and then verify in Lean, HN. Then we publish. (Anything we do must be formalized in Lean before publishing,
  that's the bar for AI found proofs, and I think we can go all the way to an HN solution)"*
- *"Let's see some ambition. I know we can do it. Look at what you've done in just the last couple days, and we've already reduced it to a
  single set of fields!"*
- *"From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. You are capable, and you will
  surprise yourself."*
- *"Do not consider Lean formalization a cost."* — and no declared purchases in the final formalization.

## The reduction (each link at its grade; `CLAUDE.md` § The aim is the one home — this is its working copy for a fresh session)

1. Given MR (`LEDGER.md` row 120), `χ(ℝ²) = χ_CP(ℝ²) = χ_m⁰(ℝ²) = χ(F²)` at every totally real `F` whose stable places all mix at six
   colours — ℚ(√635087), de Grey's field (rows 128, 130) [hand, two minds each].
2. `χ(ℝ²) ≤ χ_m⁰(ℝ²)` with no MR (random rigid motion + de Bruijn–Erdős) [hand, two minds: FS103-N N-EASY; PA1 (E)].
3. Row 129: one colour class at a time never gives six.
4. Regular classes need seven, verified at FS-106 and almost everywhere (row 132): closed classes (`[Voronov2023]` Thm 1.3, closedness
   entering once as compactness giving a band) and band-avoiding colourings (Thm 1.1), the proofs repaired locally (two minds, one blind; an
   unrefereed preprint); almost everywhere, slack needs seven (the supports avoid the band), polygons and locally finite convex tilings need
   seven bar one edge case (`d = 2`), nice maps need seven; maps need six by `[Woodall1973]` Thm 6 and Townsend's 1979 manuscript, each
   repairing the other (`[Townsend1981]` prints no proof); `[Coulson2004]`'s six is for tiles with an area bound. FS103-M's D5 cited
   `[CurrieEggleton2016]`'s six for slack colourings; Voronov's seven supersedes it (a G50 instance: held, its bearing not drawn).
5. **The question, in its stability form (row 131):** with no MR, `χ_m⁰(ℝ²) ≥ 7` iff six classes free of monochromatic pairs at distances in
   `[1−ε, 1+ε]` cannot cover the plane up to holes of vanishing density as `ε → 0` (`lim µ₆(ε) < 1`; `[SokolovVoronov2025]` §9's hypothesis).
   A refutation is a sequence of periodic grid-square colourings with vanishing holes; the wild set exists only in the limit, whose normal form
   is held (density-open classes avoiding distance 1 at every point, covering off a null set `E`, every point of `E` seeing two colours of
   positive upper density; FS-103's V1 and FS103-M's D1–D5).
6. **Both answers decide Hadwiger–Nelson.** No (Voronov's contradiction survives a free colour of vanishing density) → `χ_m⁰ = 7` → given
   MR, `χ(ℝ²) = 7`. Yes (such a sequence, with five or six colours) → `χ(ℝ²) ≤ 6` or `= 5`, with no MR.

## FS-106 — the regular half (first) — CLOSED 2026-09-27

*Banner: closed; its record `plans/FS106-regular-half.md` §R-close; the text below is the stub as minted.*

**Question.** Exactly which regular classes of colourings need seven (or six) when properness is only required almost everywhere, and does
Voronov's circle-colouring method run on the normal form of link 5?

1. **Read and verify first-hand**, proof by proof, in the almost-everywhere setting (boundaries free, null sets ignored):
   - `[Voronov2023]` Thms 1.1 and 1.3 (held, arXiv:2304.10163);
   - `[Thomassen1999]` and `[Townsend1981]` (unheld: Kooshi fetching);
   - `[Townsend2005]` (unheld: Geombinatorics; Kooshi's archive request);
   - `[Coulson2004]` and `[Woodall1973]` (held);
   - `[SokolovVoronov2025]` and `[Manta2021]` (held, read at FS-18 for another question).

   For each theorem: its hypotheses on the classes, the step that uses them, and whether that step survives when a class is only
   density-open and 1-avoiding at every point.
2. **Derive the almost-everywhere forms** that survive, at [hand] with a blind second mind. The slack case (link 4) is the first: it is a
   short consequence of Thm 1.1 once Thm 1.1 is verified.
3. **Push Voronov's method** to the normal form: for almost every `x`, the colouring restricted to the unit circle `S(x, 1)` is measurable,
   omits `c(x)`, and is proper at the chords of length 1. Say which topological fact Voronov uses about a closed colouring of a circle, and
   what its measurable replacement would need (approximate continuity; the density topology; the 1-dimensional traces of density-open
   sets).

**Outcomes, each reachable.** The almost-everywhere forms hold, and the method's one closed-set step is named: FS-107's target is that
step. Or some regular class admits an almost-everywhere-proper six-colouring the everywhere-proper theorems exclude: `χ(ℝ²) ≤ 6` with no
MR, and FS-107 becomes its verification. Or a theorem in print fails on reading: a correction, with its consequence for the reduction.

## FS-107 — stability: can vanishing holes save a colour? (second; the competitor protocol) — CLOSED 2026-09-27

*Renamed and re-aimed 2026-09-27 (the owner's ruling, item 77; the advisor's design, A2 = `plans/POROS-2026-09-27-fs106-close-and-fs107.md` §3).
Minted 2026-09-26 as "regularity against pathology"; row 131 removed that frame: a refutation never needs a wild set (TQ §3.5: "A refutation
never needs a wild set. By (e) it is a sequence of *periodic polygonal colourings with slack*, whose uncovered density tends to 0; the wildness
exists only in the limit that Route II takes."). The contest is stability, not regularity.*

**Two competitors and an advisor** (`plans/PROTOCOL-competitor-and-advisor.md`, §1 as it stands, with the fence rule 13: transcripts,
`chats-bak/`, the shared scratchpad by path). Each brief names its object — **the sequence** (periodic grid-square partial six-colourings with
slack `ε_n → 0` and holes `δ_n → 0`; its only gap is the hole gap) or **the limit** (a tight a.e.-proper six-colouring in the normal form; there
FS-106's structural gaps are the content) — and labels the other record's material "applies to the limit object" or "to the sequence object".

- **Competitor R (stability).** Prove C-Q-STAB in its exact disc form (TQ §4.5 item 2, "for some radius `R`"): for some `R` and `δ₀ > 0` and
  every `ε > 0`, every partial six-colouring of `U_R(0)` with no monochromatic pair at distance in `[1 − ε, 1 + ε]` leaves at least `δ₀|U_R|`
  uncovered. With row 131 this is `χ_m⁰(ℝ²) ≥ 7`, and given MR `χ(ℝ²) = 7`. The mechanism R must supply, TQ §4.5 item 5 verbatim: *"a mechanism
  forcing holes of `ε`-independent total measure — a Voronov-type contradiction robust to a free colour on any set that is thin at scale `ρ₀`,
  for every band `ε ≪ ρ₀`."* (TQ never defines "thin at a scale `ρ₀`", A2 §0; the disc form above is the exact question.) Routes: (R-Q) on the
  sequence object; (R-S) on the limit object, through FS-106's named steps — C-AE-Q2's [G1]–[G4] (the no-swap lemma first: the index method
  dies at a unit-arc interface facing a bowtie, row 132), C-T-L1b's two steps, C-T-TRIb's hull step, C-T-BIKE. The pair form (PD-EQ, A2 §2.2, a
  sketch: a band-pair defect uniform in `ε`) is the decisive quantity a stability proof may count.
- **Competitor W (near-colourings).** Row 131's (e), TQ-EQ verbatim: *"for every `δ > 0` there are `ε > 0` and a **periodic** partial
  6-colouring by half-open grid squares, with no monochromatic pair at any distance in `[1 − ε, 1 + ε]`, leaving density `≤ δ` uncovered"* — or
  equivalently `µ₆⁰ = 1`; tight polygonal tilings in `[Parts2020c]`'s framework with voids tending to 0 suffice (TQ-SUP). Success gives
  `χ_m⁰ ≤ 6` and `χ(ℝ²) ≤ 6` **with no MR**; it rests on the easy direction of row 131. W's families are given by formula, with rational data,
  and checked exactly (allowed under the ban: a check of a given object).
- **The advisor** reads both, holds the shared constraints and the break table, and asks each side before round 1 to name the step of the
  other's programme it expects to fail (G51: zero retractions means the disagreement has not started).

**Shared constraints** (A2 §3.4; every one held, both sides get the list verbatim; row 131's constants carried): the floor
`1 − µ₆(ε) ≥ ε²/(6+ε)²` (given V-1.3; A2's table has TQ's weaker `ε²/78`); the ceiling `1 − µ₆⁰ ≤ δ₆ = 1.430172·10⁻⁴`, `1 − µ₆(ε) ≤ δ₆ + O(ε)`;
each class of density `≤ m₁(ℝ²) ≤ 0.2470`; one-class-at-a-time arguments stop below 4.37 (row 129); thin holes fill (HOLE-t); no multichromatic
coloured point, WLOG (the pixel lemma); not hitting form (strips of density `ε`, TQ-HIT with QB's cap); the limit is tight (C-AE-SLACK), not
polygonal bar `d = 2`, not a nice map; islands of one colour have diameter `≤ 1 − ε` (TS-C, TS-C′); the limit's exceptional set (C-T-TAN's
cones, cusps, weak-* limits); the ban to 2026-10-01.

**Killing tests** (A2 §3.5). R's: the Parts calibration (an argument forcing more than `δ₆ + O(ε)` of holes on eroded Parts tilings is wrong);
the seven-colour control (it must fail on the slack hexagonal 7-colouring and name where "six" is spent); the strip test (if every step survives
TQ-HIT's strips, it is hitting form, capped at `O(ε)`); normalisation (uncovered area over plane area, never pairs over band). W's: the exact
check (a monochromatic pair of squares whose distance interval meets the band refutes a member); the floor; the class density; a driving
parameter that sends `δ → 0` (Parts's own family has none). **The joint dial** is FS-109 (post-ban). **The break table** is A2 §3.6.

**Outcomes:** R's theorem (seven, given MR); W's sequence (at most six, with no MR); or a named obstruction on each side, itself a result:
*"All novel knowledge is a success."* A rung for R, not decisive: improve the floor's `ε²` toward `ε`, the most a hitting-form argument can give.

## Lean (throughout, never a cost)

MR in full (`[EinsiedlerLindenstrauss2022]` Thm 1.3 and the deduction FS105-DED; `[EinsiedlerFish2010]`'s transfer), the collapse
(row 128), the measurable chain (row 130, link 2), and whichever half of FS-107 lands. FS-101 is the lane; no declared purchases in the
final form.

## Provisional bearings (replaced by the re-grokking at the opening)

For FS-107, added at FS-106's close: G82 (stability; row 131), G71 with its index sentence (row 132), G21 (lists of exceptions measure their class), G51 (a construction against a proof is where contest is possible).

G30 (the discipline ladder: geometric measure theory and circle topology are the next room), G46 (recognize the classical theory:
Voronov's method is the nearest technology), G79 (the example invariant every tight colouring carries), G72 (the structural form: a
question about every measurable colouring), G13 and G16 (fans and the measurable fan: the colour of a density point is excluded from a
unit annulus around it), G20 and G22 (brick and polygonal colourings), G24 and G29 (integrality; the cell family closed), G60 (density
caps), G21 (audit a result you like), G51 (the competition), G80 and G81. Stubs: FS-104 (re-aimed: its null-set step is one sub-question of
FS-107; its other items stand), FS-101 (Lean), FS-102 (the write-up, after Lean), FS-62 (six as a value of fields).

## Bearing on the answer

Decisive both ways, given MR for the lower half: this is Hadwiger–Nelson in its measurable form.

*Would have searched here:* nothing.
