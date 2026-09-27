# FS-106 and FS-107 — the regularity wall: can a tight, non-closed measurable colouring save a colour? (stub; the program Kooshi adopted)

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
4. Regular classes need seven in print: closed classes (`[Voronov2023]` Thm 1.3), band-avoiding colourings (Thm 1.1, every `ε > 0`),
   nice maps (`[Thomassen1999]`), polygons (`[SokolovVoronov2025]`); maps need six (`[Townsend1981]`, `[Townsend2005]`, `[Coulson2004]`).
   Hence an almost-everywhere-proper colouring with slack needs seven (random rigid motion + Thm 1.1). **Unverified here in every
   almost-everywhere form; `[Voronov2023]` is an unrefereed preprint; Thomassen and Townsend are unheld.** FS103-M's D5 cited
   `[CurrieEggleton2016]`'s six for slack colourings; Voronov's seven supersedes it (a G50 instance: held, its bearing not drawn).
5. **The question:** can a colouring that is Lebesgue-measurable, proper at almost every unit pair, **tight** (no band avoided) and **not
   closed** save a colour that closed ones cannot? Normal form, held: classes `D_j` density-open, avoiding distance 1 at every point, covering
   the plane off a null set `E`, every point of `E` seeing at least two colours of positive upper density (FS-103: V1's density-point lemma,
   FS103-M's D1–D5).
6. **Both answers decide Hadwiger–Nelson.** No → `χ_m⁰ = 7` → given MR, `χ(ℝ²) = 7`. Yes (a tight wild colouring with five or six colours)
   → `χ(ℝ²) ≤ 6` or `= 5`, with no MR.

## FS-106 — the regular half (first)

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

## FS-107 — regularity against pathology (second; the competitor protocol)

Two competitors and an advisor (`plans/PROTOCOL-competitor-and-advisor.md`, with its 2026-09-26 fence fix: transcripts, `chats-bak/`,
and the shared scratchpad fenced by name).
- **Competitor R (regularity):** wildness cannot save a colour. Candidate routes:
  - Voronov's argument run on density-open classes (FS-106 item 3);
  - an excision: show that the wild part of an optimal colouring can be removed;
  - a Lipschitz-in-probability bound for some optimal CP colouring (finite perimeter), then De Giorgi;
  - the pointwise identity `1_{D_j}·(1_{D_j} * σ) = 0` with the half-derivative smoothing of circle averages: the colour at `x` is a
    zero of the smoother vector `(1_{D_j} * σ)(x)`.
- **Competitor W (pathology):** build a tight, wild, almost-everywhere-proper five- or six-colouring. The constraints it must meet, held:
  - each class density at most `m₁(ℝ²) ≤ 0.2470`, so at least `1 − (k−1)·0.2470`;
  - tight everywhere, since slack needs seven (link 4);
  - not closed, not a nice map, not polygonal.

  Candidate material: fat Cantor sets, self-similar and random constructions, Pritikin's six-colouring of almost all the plane
  (`[Pritikin1998]`, unheld).
- **The advisor** reads both and names where each would have to break the other.

**Outcomes:** a regularity theorem (seven, given MR); a wild colouring (at most six, with no MR); or a named obstruction on each side,
itself a result: *"All novel knowledge is a success."*

## Lean (throughout, never a cost)

MR in full (`[EinsiedlerLindenstrauss2022]` Thm 1.3 and the deduction FS105-DED; `[EinsiedlerFish2010]`'s transfer), the collapse
(row 128), the measurable chain (row 130, link 2), and whichever half of FS-107 lands. FS-101 is the lane; no declared purchases in the
final form.

## Provisional bearings (replaced by the re-grokking at the opening)

G30 (the discipline ladder: geometric measure theory and circle topology are the next room), G46 (recognize the classical theory:
Voronov's method is the nearest technology), G79 (the example invariant every tight colouring carries), G72 (the structural form: a
question about every measurable colouring), G13 and G16 (fans and the measurable fan: the colour of a density point is excluded from a
unit annulus around it), G20 and G22 (brick and polygonal colourings), G24 and G29 (integrality; the cell family closed), G60 (density
caps), G21 (audit a result you like), G51 (the competition), G80 and G81. Stubs: FS-104 (absorbed: the null-set step is one sub-question of
FS-107), FS-101 (Lean), FS-102 (the write-up, after Lean), FS-62 (six as a value of fields).

## Bearing on the answer

Decisive both ways, given MR for the lower half: this is Hadwiger–Nelson in its measurable form.

*Would have searched here:* nothing.
