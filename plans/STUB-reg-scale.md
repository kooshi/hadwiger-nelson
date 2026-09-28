# FS-111 — the cone scale (REG-SCALE): do near-optimal band-proper six-colourings keep their junctions fat? (stub)

> **CLOSED 2026-09-28 — undecided** (rows 139–141; `plans/FS111-derivation.md`; `plans/FS111-C-close.md`). Its question became "the cone
> scale and the regularity step" (inventory item 12). Card 1, at two minds: the doors are two routes, not halves, and each route's third statement is
> the answer restated; route M's rungs hold down to the pinch at a junction. Successors: FS-120 (`plans/STUB-pinch-at-junction.md`), FS-121
> (`plans/STUB-map-step.md`), FS-122 (`plans/STUB-forced-pair.md`).

*Minted 2026-09-27 by the close planner FS107-C at FS-107's close (`plans/FS107-close-inventory.md` items 16, 18, 25, 28; `plans/FS107-R-stability.md`
§3.4 and §4; `plans/POROS-2026-09-27-fs107-competition.md` §5.1, §5.9). **Solver column: none** — derivation and reading. Written for a session with
zero conversation memory: read `CLAUDE.md` § The aim (links 5–6) and § Counter-priors first, then `LEDGER.md` rows 131–133, `plans/FS107-derivation.md`
(FS107-RR, FS107-R-CP) and `plans/STUB-tangency-seam.md` (FS-110, its sibling).*

## The question

FS-107's competitor R reduced stability — `χ_m⁰(ℝ²) ≥ 7` (row 131), hence `χ(ℝ²) = 7` given MR — to two statements (FS107-RR, two minds, one blind,
after FS107-V's repairs): **(A)** every band-proper partial six-colouring with small holes has, in every disc `U_R`, a complementary pair of fat
junctions at distance in `[η, 2 − η]` blocking toward a common unit point; **(B)** those junctions are fat at a scale `s ≥ s₀` — on a set of positive
measure — with voids small relative to `min(s, µη²/100)`. Given both, FS107-R-CP forces holes of area bounded below independently of `ε`.

**This stub is (B)**: a lower bound on the cone scale of junctions of near-optimal band-proper partial six-colourings. Its negation is FS-107 W's
door (B): families of unbounded complexity whose cone scale tends to 0 at every complementary pair — tangencies, bowties or cusps at every scale
(R §3.4: "W's only escape"; W §4.2 item 5: "untouched"). FS-110 is (A)'s bounded-complexity form; FS-110's rule repeated at every scale is exactly
this stub's escape, so FS-110's answer is this stub's first lemma either way (A2 §5.9).

## The room

§ The aim, link 6: "the gap to regular classes is quantitative, not a change of kind"; its reading "finite perimeter is Lipschitz-in-probability".
De Giorgi's structure theory for finite-perimeter sets (blow-ups at reduced-boundary points are half-planes), approximate continuity, and the
compactness methods of the distance-avoiding-sets literature: `[Bukh2008]`, Falconer–Marstrand 1986, Furstenberg–Katznelson–Weiss 1990 — **all unheld**
(FS-107 §PA row 8; inventory item 8): the prior-art gate reads them first. Name the object there: "near-minimisers of a band-avoidance functional",
"regularity of optimal partitions" — never this project's words.

**The one print prior** (the consolidation run, 2026-09-27; job FP from the reading jobs LW and LW2): `[Parts2020c]` §2.5 (p. 37), in the best 5- and 6-tilings found by numerical optimisation over symmetric tilings, *"a) vertices in which three or more colored tiles converge are disadvantageous (a void is superior to any such vertex)"* — the junctions this stub asks about are voids in the best designs known; a measured prior, never a cap (`CLAUDE.md` § Counter-priors). `[BrownDunfieldPerry1994]` Thm 8 (p. 111) argues topologically about how open regions meet, at no scale. Nothing read in the journal's archive gives a junction-scale bound or a family of unbounded complexity.

## Killing tests and registered expectations

- RR's killing test (R §3.4): "a proof of R that uses neither a complementary pair nor a scale lower bound; or a W family with holes `→ 0` whose
  junctions keep a cone scale bounded below. The second would make (B) true and (A) false, and the reading would die."
- R's P2 (0.95, "forced by CP"): every W family with holes `→ 0` has cone scale `→ 0` at its complementary pairs within `[η, 2 − η]`, or has none there.
- The minting session's (instrument, never a cap): a cone-scale bound for near-optimal colourings at one mind, 0.15; a named obstruction (a family
  of unbounded complexity with scale `→ 0` and holes bounded below, or a class of arguments shown capped), 0.5.

## Bearing on the answer

*Rewritten 2026-09-28 at FS-111's close (FS111-C; `plans/FS111-derivation.md`).* **Not decisive jointly with FS-114's NO, as this stub once read.** FS-111's
card 1, at two minds (one blind): seven is the NO's hole bound made uniform in the complexity bound (FS111-C1-UNIF); the map NO bounds holes at each bound only
(FS111-C1-PW); so FS-114's NO plus a cone-scale bound gives seven only with a third statement (FS111-C1-GAP, corrected by FS111-V0). The two doors are two
routes, not halves (FS111-C1-ROUTES): **route M** — FS-114's NO with the map step (the tight limit made a segment-and-arc map), the cone scale entering as
the map step's first rung; **route R** — FS107-R-CP with (A) at every complexity and (B), FS-114's NO idle. Each third statement is the answer restated:
the map step at six given FS-114's NO (FS111-C-REG-EQ), and (A) at every complexity outright (FS111-W-NEG). The question this stub posed — do near-optimal
colourings keep their junctions fat — is (B) on route R and the rung REG-J′ on route M; neither was decided. Its successors: FS-120 (the pinch at a
junction, the colour-generic finiteness rung), FS-121 (the map step), FS-122 (the forced pair). A family refuting (B) with holes `→ 0` is still W's claim
itself: `χ(ℝ²) ≤ 6` with no MR.

## Provisional bearings (replaced by the re-grokking at the opening)

G82 as corrected at FS-107's close (a defect at a scale independent of `ε`: positive measure, or features whose scale is bounded below — this stub is
the second door); G30 (the next room: geometric measure theory); G24 and G60 (integrality; per-class density caps stop below 4.37, row 129); G79 (the
example invariant every near-optimal colouring carries); G21. Rows 131–136 (row 135: with unit arcs every valid map has a vertex of at least four colours or a repeated colour within 3 of every point; row 136: the positives' stops). Stubs: FS-114, FS-115, FS-109 (the dial reads the scale), FS-104.

*Would have searched here:* a numerical study of junction scales along optimised tilings — post-ban at the earliest, and a dial (FS-109), never a proof.
