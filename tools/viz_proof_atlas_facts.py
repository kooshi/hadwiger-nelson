#!/usr/bin/env python3
"""Write the Proof Atlas's fact table, data/viz/proof-atlas/facts.json (job VIZ-ATLAS, 2026-09-27; FS-112's close folded in by VIZ-ATLAS-2).

Every node and edge is hand-authored here with a verbatim quote and the address it was read from; the grade shown on the page is the
source's own words (`grade`), folded to a page status by `viz_proof_atlas_common.fold` — this file never types a status the source's
words do not fold to (the builder recomputes it; `tools/viz_proof_atlas_check.py` re-reads every quote from its source).

  python3 tools/viz_proof_atlas_facts.py        # writes the table and prints a layout lint (label overlaps), then run the checker
"""
import json, math, pathlib, sys

ROOT = pathlib.Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
from viz_proof_atlas_common import fold, locate, address_str, norm, text  # noqa: E402

OUT = ROOT / "data/viz/proof-atlas/facts.json"

# ---------------------------------------------------------------- source addresses used more than once
L = lambda n: {"file": "LEDGER.md", "row": str(n)}                                            # noqa: E731
AIM = {"file": "CLAUDE.md", "section": "### The aim"}
STANDS = {"file": "CLAUDE.md", "section": "### Where the problem stands"}
MISSION = {"file": "CLAUDE.md", "section": "## The mission"}
NOTATION = {"file": "CLAUDE.md", "section": "## Notation"}
LGC = {"file": "CLAUDE.md", "section": "### The local–global conjecture"}
PRIORS = {"file": "CLAUDE.md", "section": "### Counter-priors — read before pricing anything"}
PF = lambda n: {"file": "CLAUDE.md", "section": "### Paths forward, ranked", "row": str(n)}  # noqa: E731
FSR = lambda n: {"file": "plans/FRONTIER-STUBS.md", "section": "## Ranked stubs", "row": str(n)}  # noqa: E731  CLAUDE.md keeps the top ten
INTERVAL = {"file": "Proofs/HadwigerNelson/Instances/Interval.lean"}
INV = lambda n: {"file": "plans/FS112-close-inventory.md", "row": str(n)}                    # noqa: E731
NTAB = lambda k: {"file": "plans/FS112-N-proof.md", "row": k}                                # noqa: E731
PLAN112 = lambda k: {"file": "plans/FS112-unit-arc-half.md", "row": k}                       # noqa: E731
STUB = lambda f: {"file": f"plans/{f}"}                                                      # noqa: E731
OPEN_WORDS = (INTERVAL, "the exact value inside it remains open")   # the bound is not held: the kernel's own docstring says so
BOTH_GAP = (STUB("STUB-regularity-wall.md"), "both claims GAP")      # FS-107's close: R's claim and W's claim, each a GAP
B = lambda k: {"file": "LEDGER.md", "row": k}                                                   # noqa: E731  a LEDGER.md § B line
GSTUB = STUB("STUB-global-step.md")
RSTUB = STUB("STUB-stuck-ray.md")
NIGHT = STUB("POROS-2026-09-27-night-aim.md")
NOT_THE_NO = (L(135), "Not claimed: the NO")
BASEV = ({"file": "plans/FRONTIER-STUBS.md", "section": "## Open milestones, in order"}, "with BASE-V beside them (row 134's base re-derived but for Lemma 4 at cusps)")

NODES, EDGES = [], []


def N(id, label, role, plain, src, quote, grade=None, *, at, sector, tier=2, **kw):
    """One node. `grade` is (address, verbatim words) — default: the quote's own address; '@lean' for a kernel declaration."""
    g_src, g_words = grade if isinstance(grade, tuple) else (src, grade)
    NODES.append(dict(id=id, label=label, role=role, plain=plain, src=src, quote=quote, grade_src=g_src, grade=g_words,
                      theta=at[0], r=at[1], sector=sector, tier=tier, **kw))


def E(a, b, kind, src, quote, **kw):
    EDGES.append(dict(source=a, target=b, kind=kind, src=src, quote=quote, **kw))


# ================================================================ the goal: three destinations, six half-answers
for aid, v, th in (("A7", 7, 0), ("A6", 6, 120), ("A5", 5, 240)):
    N(aid, f"χ(ℝ²) = {v}", "answer", f"The answer {v}: the plane needs exactly {v} colours. Decided only when both halves hold — "
      f"a lower bound of {v} and an upper bound of {v}.", STANDS, "χ(ℝ²) ∈ {6, 7}", (MISSION, "χ(ℝ²) decided | open"),
      at=(th, 62), sector="centre", tier=0, answer=v)

N("LB5", "χ(ℝ²) ≥ 5", "bound", "Five colours are needed. Held in the kernel: de Grey's graph cannot be four-coloured.",
  {"file": "Proofs/HadwigerNelson/Instances/Interval.lean", "decl": "chromaticNumber_plane_interval"},
  "5 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber", "@lean", at=(262, 140), sector="five", tier=0, answer=5,
  also=[(L(33), "chromaticNumber_plane_interval: 5 ≤ χ(ℝ²) ≤ 7")])
N("UB7", "χ(ℝ²) ≤ 7", "bound", "Seven colours always suffice. Held in the kernel: a brick colouring of the plane by seven colours.",
  {"file": "Proofs/HadwigerNelson/Instances/Interval.lean", "decl": "chromaticNumber_plane_interval"},
  "(unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber ≤ 7", "@lean", at=(338, 140), sector="seven", tier=0, answer=7,
  also=[(L(33), "chromaticNumber_plane_interval: 5 ≤ χ(ℝ²) ≤ 7")])
N("LB7", "χ(ℝ²) ≥ 7", "conclusion", "Seven colours are needed. Reached by the regularity wall: given measure rigidity, the plane's number "
  "is its measurable number, and the measurable number is seven if vanishing holes cannot save a colour.", AIM,
  "gives χ(ℝ²) = 7", OPEN_WORDS, at=(22, 140), sector="seven", tier=0, answer=7)
N("LB6", "χ(ℝ²) ≥ 6", "conclusion", "Six colours are needed — the $1,000 question Soifer prints as Graham's.", STUB("STUB-cp-plane-six.md"),
  "The Ronald L. Graham New $1,000 Problem. Prove or disprove the existence of a 6-chromatic unit-distance graph.", OPEN_WORDS,
  at=(100, 140), sector="six-low", tier=0, answer=6,
  posed=[dict(question="Graham's $1,000 problem: prove or disprove the existence of a 6-chromatic unit-distance graph", state="open",
              src=STUB("STUB-cp-plane-six.md"), quote="The Ronald L. Graham New $1,000 Problem.")])
N("UB6", "χ(ℝ²) ≤ 6", "conclusion", "Six colours suffice: the first move of the upper bound since 1950, and it would need no measure "
  "rigidity.", AIM, "Yes — such a sequence with six colours — gives χ(ℝ²) = 6", OPEN_WORDS,
  at=(140, 140), sector="six-up", tier=0, answer=6)
N("UB5", "χ(ℝ²) ≤ 5", "conclusion", "Five colours suffice — the answer five, with no measure rigidity.", AIM,
  "At five the answer is in: the holes stay of density bounded below", OPEN_WORDS,
  at=(220, 140), sector="five", tier=0, answer=5)

# ================================================================ the classical interval (kernel)
N("DEGREY", "de Grey's graph", "held", "De Grey's 1581-vertex unit-distance graph cannot be four-coloured; its geometry is exact and its "
  "refutation an LRAT certificate the kernel replays (M06–M09).", INTERVAL,
  "the lower end is chromaticNumber_plane_ge_five — de Grey's 1581-vertex unit-distance graph", "@lean", at=(274, 222), sector="five",
  lean={"file": "Proofs/HadwigerNelson/Instances/DeGrey/Bound.lean", "decl": "chromaticNumber_plane_ge_five"})
N("SEVEN", "the seven-colouring", "held", "A brick colouring of the plane by seven colours, checked by one kernel `decide` (M36). "
  "Classical; ours is the certificate.", INTERVAL, "the upper end is chromaticNumber_plane_le_seven — the 4/5 × 3/5 brick colouring",
  "@lean", at=(352, 212), sector="seven",
  lean={"file": "Proofs/HadwigerNelson/Instances/Seven.lean", "decl": "chromaticNumber_plane_le_seven"},
  also=[(L(33), "The colouring is classical; ours is the certificate.")])

# ================================================================ the measure-rigidity engine (upper left)
N("EL", "EL 2021, Thm 1.3", "external", "A published rigidity theorem for commuting automorphisms of solenoids (positive "
  "entropy). Measure rigidity uses it by statement; its cited machinery is unread here.", L(120),
  "the positive-entropy input [EinsiedlerLindenstrauss2022] Thm 1.3, from which its Thm 1.2 follows",
  "EL2021 Thm 1.3 (external, published)", at=(298, 520), sector="engine")
N("MR", "measure rigidity (MR)", "held", "Every measure on the dual of the unit-vector ring that the unit-vector group preserves, and that "
  "gives no mass to the archimedean part, is a multiple of Haar measure. The hinge of every result above four at a field, and of the "
  "collapse.", L(120), "every U_F-invariant finite positive measure on R̂ with τ(E) = 0 is a multiple of Haar measure (MR(F))",
  "PE-2 two derivations blind to each other (X02D, X02V)", at=(304, 440), sector="engine", tier=1)
N("R128", "the collapse", "held", "Given MR, at a totally real field whose every stable place mixes at six colours (ℚ(√635087), de "
  "Grey's field), the field's plane, the real plane and the stationary random colourings all need the same number of colours.",
  L(128), "The collapse: given MR, the plane's number is a field's.",
  "the load-bearing step two derivations blind to each other and to J39's and J48's proofs (V1; V2)", at=(316, 330), sector="engine",
  tier=1)
N("R130", "χ_CP = χ_m⁰", "held", "With no MR, the stationary number equals the measurable number: the fewest colours of a measurable "
  "colouring proper at almost every unit pair. Given MR, that is Hadwiger–Nelson itself.", L(130), "With no hypothesis ([OAIMath2026] Thm 1.3; χ_m⁰ ≤ χ kernel-checked there and audited here, EXT-OAI1): χ(ℝ²) = χ_m⁰(ℝ²)",
  "M1, M1b, M1c, M-FREE, M-AE3 and M-Q4 two derivations (FS103-M; FS103-N blind to M's record)", at=(331, 258), sector="engine",
  tier=1)

# ================================================================ the algebraic lower bound and the local–global structure (left)
N("R121", "χ(ℚ(√47)²) = 5", "held", "The plane over ℚ(√47) needs exactly five colours — the cheapest exposed five of the local–global "
  "conjecture, with no finite graph exhibited. Answers Moorhouse's named question (2010).", L(121),
  "χ(ℚ(√47)²) = 5: the local–global conjecture's cheapest exposed five-clause is met",
  "the headline rule met (every half two blind minds, SP-Cor checked blind)", at=(266, 300), sector="five", tier=1,
  posed=[dict(question="Moorhouse's named question (2010), and the existence half of Soifer's Open Problem 55.1 (2019) — given MR, at [hand]",
              state="answered", src=LGC, quote="χ(ℚ(√47)²) = 5 (row 121) answers Moorhouse's named question (2010) and the existence half of "
              "Soifer's Open Problem 55.1 (2019)")])
N("SUB", "a subfield's plane", "held", "The plane over any real subfield is a subgraph of the plane, so it needs no more colours: a field "
  "that needs five makes the plane need five.", {"file": "Proofs/HadwigerNelson/Bridge.lean", "decl": "chromaticNumber_planeOver_le_plane"},
  "The plane over any real subfield needs at most as many colours as the plane.", "@lean", at=(254, 215), sector="five",
  lean={"file": "Proofs/HadwigerNelson/Bridge.lean", "decl": "chromaticNumber_planeOver_le_plane"},
  also=[(STANDS, "a subfield's plane is a subgraph of ℝ²'s, so χ(ℚ(√47)²) = 5 (row 121) gives χ(ℝ²) ≥ 5")])
N("R123", "main clause through five", "held", "The local–global conjecture holds whenever its local bound is at most five: every real "
  "number field's plane needs min(L(F), 5) colours, and exactly L(F) when L(F) ≤ 5.", L(123),
  "for every real number field F, χ(F²) ≥ min(L(F), 5), so χ(F²) = L(F) whenever L(F) ≤ 5",
  "CLS three derivations — X23D and X26B blind to each other in full", at=(282, 330), sector="lg")
N("R99", "L ≤ 4: three and four", "held", "Three and four colours obey the local–global conjecture over every real number field.", L(99),
  "χ(F²) = L(F) whenever L(F) ≤ 4", "S1 three derivations (J02, J09, J09v), S2 and the torsion theorem two, S3 three",
  at=(272, 420), sector="lg")
N("R52", "the residue bound", "held", "A usable prime's finite plane colours the whole field's plane: χ(F²) ≤ χ(Γ_q). The upper half of "
  "the local–global conjecture; prior art (Moorhouse 2010, Manturov 2012, Madore 2015).", L(52), "has χ(F²) ≤ χ(Γ_q)", "[hand + tools]",
  at=(262, 420), sector="lg")
N("LG", "local–global conjecture", "belief", "χ(F²) = L(F) wherever L(F) ≤ 6; its bold form is χ(ℝ²) = 7. Kooshi holds it. A belief, "
  "drawn so it can be seen and never counted: no route's distance includes it.", LGC, "and its bold form is χ(ℝ²) = 7",
  (NOTATION, "The conjecture (local–global, G48): χ(F²) = L(F) wherever L(F) ≤ 6; its bold form is χ(ℝ²) = 7."),
  at=(250, 410), sector="lg")
N("R127", "main clause in Lean (conditional)", "lean-held", "The main clause through five, in the kernel, over named hypotheses "
  "(MR among them); χ(ℚ(√47)²) ≤ 5 unconditionally. The composition is the kernel's; every link it names stays [hand].", L(127),
  "The main clause through five in the kernel, conditional on named hypotheses",
  "[kernel; standard three axioms, no native purchase; the lower halves conditional on named propositions, not vacuous domains]",
  at=(284, 500), sector="lean")
N("FS101", "FS-101: the named hypotheses", "lean", "Discharge row 127's named hypotheses one at a time: Markov–Kakutani, the residue "
  "bound's valuation subring, Herglotz–Bochner.", STUB("STUB-main-clause-five-kernel.md"),
  "Next: InvariantMeasureOnClosed as Markov–Kakutani (~100–200k), then the upper half hUpper via row 57's gap (~40–80k), then "
  "Herglotz–Bochner (weeks)", (STUB("STUB-main-clause-five-kernel.md"),
  "FS-101 — the local–global conjecture's main clause through five, in the kernel (stub)"), at=(276, 575), sector="lean")
N("FS113", "FS-113: MR in Lean", "lean", "Measure rigidity in full in Lean, with no declared purchase — needed to publish every result "
  "through MR, and the answer seven through the collapse.", STUB("STUB-mr-in-lean.md"),
  "as a theorem in Proofs/, on the standard three axioms, with no declared purchase",
  (STUB("STUB-mr-in-lean.md"), "FS-113 — measure rigidity for the unit-vector group, in full, in Lean (stub)"),
  at=(310, 520), sector="lean")
N("LEANWALL", "Lean: the wall's chain", "lean", "The collapse, the measurable chain and the map argument, in Lean — the regularity "
  "wall's own formalization, owed before seven could be published.", STUB("STUB-regularity-wall.md"),
  "MR in full ([EinsiedlerLindenstrauss2022] Thm 1.3 and the deduction FS105-DED; [EinsiedlerFish2010]'s transfer), the collapse "
  "(row 128), the measurable chain (row 130, link 2), and whichever half of FS-107 lands.",
  (STUB("STUB-regularity-wall.md"), "FS-106 and FS-107 — the regularity wall, and its stability form: can vanishing holes save a "
   "colour? (stub; the program Kooshi adopted)"), at=(322, 560), sector="lean")

# ================================================================ toward seven: the regularity wall (top)
N("R131", "stability: the question", "held", "With no MR: the measurable number is at least seven exactly when six classes, each free of "
  "one-colour pairs at distances near 1, cannot cover the plane up to holes that vanish as the band narrows. At every k the same "
  "equivalence holds for k colours.", L(131), "At six, χ_m⁰(ℝ²) ≥ 7 ⟺ lim µ₆(ε) < 1",
  "EQ, SUP, EPS2 (given V-1.3), HIT, PIX, REM and COMP two derivations, the second blind", at=(0, 300), sector="seven", tier=1,
  also=[(L(131), "χ_m⁰(ℝ²) ≤ k ⟺ χ_CP(ℝ²) ≤ k ⟺ µ_k⁰ = 1 ⟺ lim_{ε→0} µ_k(ε) = 1")])
N("NG131", "hole-counting capped", "nogo", "Two proof shapes are closed: counting only the holes that unit circles meet proves at most "
  "holes of order ε, and trichromatic-point arguments cannot see partial colourings.", L(131),
  "an argument counting only holes met by unit circles or bicycles proves at most 1 − µ₆(ε) ≳ ε",
  "EQ, SUP, EPS2 (given V-1.3), HIT, PIX, REM and COMP two derivations, the second blind", at=(58, 200), sector="seven")
N("R132", "regular classes need seven", "nogo", "Almost everywhere: colourings with slack, polygons, locally finite convex tilings and nice "
  "maps all need seven (Voronov 2023 and Sokolov–Voronov 2025, repaired). So neither a YES nor a five can be regular.", L(132),
  "The regular half, verified and transferred almost everywhere.",
  "Voronov's theorems and the closed-set step two minds, one blind (V; VB)", at=(348, 450), sector="seven")
N("MAPS6", "maps need six", "nogo", "Any map colouring needs six colours (Woodall 1973, Townsend's manuscript, each repairing the other): "
  "a five-colouring of the plane cannot be a map.", L(132),
  "maps need six for arc maps (segments and circular arcs), by [Woodall1973]'s steps 1–6, step 6 repaired by Townsend's lemma",
  "maps-six for arc maps one mind (FS131-E1), Woodall's steps 1–3 in outline", at=(204, 320), sector="five")
N("RR", "R's reduction: (A) + (B)", "held", "Given the quantified cone lemma, seven follows from (A) a forced pair of fat junctions in "
  "every disc of every near-colouring and (B) a lower bound on their cone scale.", L(133),
  "given the quantified cone lemma, χ_m⁰(ℝ²) ≥ 7 (row 131's C-Q-STAB, disc form) follows from (A)",
  "RR after two repairs, CP by different routes, W-EQ-K, W-POLY, W-RATE, W-TAN and HX-STALL two minds, one blind",
  at=(20, 300), sector="seven")
N("WEQK", "W's equivalence", "held", "At bounded complexity, near-colourings with vanishing holes exist exactly when a tight six-map "
  "exists: a six-colouring by a map, proper almost everywhere. So door (A) at bounded complexity is one question about maps.", L(133),
  "at bounded arc complexity K, band-proper designs with vanishing holes exist iff a full tight a.e.-proper six-colouring by a map of "
  "complexity ≤ K exists", "RR after two repairs, CP by different routes, W-EQ-K, W-POLY, W-RATE, W-TAN and HX-STALL two minds, one blind",
  at=(50, 330), sector="seven", tier=1)
N("WPOLY", "polygons keep holes", "nogo", "Polygonal designs of bounded complexity keep holes bounded below: a YES cannot be polygonal.",
  L(133), "polygonal designs of bounded complexity keep holes ≥ δ₀(K), bar d = 2 (W-POLY)",
  "RR after two repairs, CP by different routes, W-EQ-K, W-POLY, W-RATE, W-TAN and HX-STALL two minds, one blind",
  at=(118, 280), sector="six-up")
N("R134", "Condition 5: no six-map", "held", "Under Condition 5 (no boundary arc of radius 1), no map by segments and circular arcs "
  "six-colours the plane almost everywhere — Sokolov–Voronov's Question 2, its Condition-5 half, answered yes.", L(134),
  "no locally finite map of the plane whose boundaries are segments and circular arcs, none of radius 1, carries a six-colouring in which "
  "no two interior points of one colour are at distance exactly 1", "the chain — NB-4, NB-5, W-MERGE and the cone removal — two minds, one blind",
  at=(4, 450), sector="seven", tier=1, also=[BASEV],
  posed=[dict(question="Sokolov–Voronov's Question 2, its Condition-5 half (\"Is it true that 7 colors are needed …?\")", state="answered",
              src=L(134), quote="So the Condition-5 half of [SokolovVoronov2025] Question 2 (\"Is it true that 7 colors are needed …?\") is "
              "answered yes")])
N("TSMNO", "no tight six-map (door A)", "conclusion", "At bounded complexity, no tight six-map exists. Under Condition 5 none does (row "
  "134); with unit arcs, FS-112 reduced it to one statement, the global step (FS-114), still open. This is door (A).", STANDS,
  "At bounded complexity that is whether a tight six-map exists (row 133): under Condition 5 none does (row 134); with unit arcs every one has a "
  "vertex of at least four colours (rows 135, 137)", NOT_THE_NO, at=(22, 375), sector="seven", tier=1)
N("M7", "χ_m⁰(ℝ²) ≥ 7", "conclusion", "Vanishing holes cannot save a colour: Voronov's contradiction survives a free colour of vanishing "
  "density. Given MR, this is χ(ℝ²) = 7.", AIM,
  "No — Voronov's contradiction survives a free colour of vanishing density — gives χ(ℝ²) = 7", BOTH_GAP, at=(18, 222),
  sector="seven", tier=1)
N("FS111", "(B) the cone scale — closed", "step", "Door (B), closed undecided at FS-111. Card 1, at two minds: the two doors are two routes, not "
  "halves; seven is the NO's hole bound made uniform in the complexity bound. Successors: the pinch at a junction (FS-120), the map step (FS-121), the "
  "forced pair (FS-122).", STUB("STUB-reg-scale.md"), "Not decisive jointly with FS-114's NO, as this stub once read.",
  (STUB("STUB-reg-scale.md"), "FS-111 — the cone scale (REG-SCALE): do near-optimal band-proper six-colourings keep their junctions fat? (stub)"), at=(65, 262),
  sector="seven", tier=1)

# ---- FS-112, the unit-arc half: closed undecided (rows 135–136); its gaps are FS-114 (the NO, the global step) and FS-115 (the stuck ray)
N("N3BASE", "N3-BASE", "held", "With unit arcs, row 134's base still refutes a map near any three-colour vertex whose closed disc of radius 2 "
  "holds no vertex of four colours and none with a repeated colour.", B("FS112-N3-BASE"),
  "row 134's base refutes a valid map near a cubic trichromatic u whose closed 2-disc has no four-colour or repeated-colour vertex",
  "hand; two minds: N3; NB3, blind; over row 134's base, re-derived by BASE-V but for Lemma 4 at cusps", at=(4, 600), sector="seven",
  also=[(L(135), "over row 134's base, re-derived by BASE-V at FS-114 but for Lemma 4 at cusps (CUSP-BASE's D5 items 1–4, 6, one mind), where a "
         "common error would now sit")],
  note="BASE-V re-derived row 134's print steps blind: every step but Lemma 4 at cusps upgraded.")
N("N3DENSE3", "N3-DENSE3", "held", "In every six-map with unit arcs, every closed disc of radius 3 holds a vertex of four or more colours or a "
  "vertex with a repeated colour. So the unit-arc half is a question about four-colour vertices: the NO is exactly the exclusion of such maps.",
  B("FS112-N3-DENSE3"), "in every valid map each closed disc of radius 3 contains a vertex of four colours or one with a repeated colour",
  "hand; two minds: N3; NB3, blind; over N3-BASE and DISC1", at=(20, 600), sector="seven",
  also=[({"file": ".claude/skills/grokkings/SKILL.md", "grok": "G83"}, "With unit arcs, the tight question lives at one four-colour vertex.")],
  posed=[dict(question="Sokolov–Voronov's Question 2, with unit arcs (\"Is it true that 7 colors are needed …?\")", state="reduced",
              src=L(135), quote="So S–V's Question 2 with unit arcs is reduced, not answered")])
N("COMPOSE", "the composition", "held", "FS-112's close: excluding the maps N3-DENSE3 describes is the NO for every map, periodic or not, with no "
  "step about stuck rays. One mind; its links two minds, one blind.", B("FS112-C-COMPOSE"),
  "the global step in DENSE3's form is the NO for all maps", "hand; one mind: FS112-C", at=(38, 545), sector="seven")
N("GSTEP", "the global step (NO)", "question", "Exclude every six-map with unit arcs — equivalently, every one whose four-colour or repeated-colour "
  "vertices come within 3 of every point. This is the whole remaining unit-arc question, not a small lemma: FS-112 restated the NO with the "
  "invariant every counterexample carries, and did not split it into smaller steps (FS-114, rank 1). FS-114 closed undecided: the global step is now the local exclusion (LOCALF).", {"file": "plans/STUB-global-step.md",
  "section": "## The question, in plain language"},
  "The global step in this form is the NO itself, for every valid map, periodic or not, with no step about stuck rays (FS112-C-COMPOSE, one mind).",
  (GSTUB, "FS-114 — the unit-arc question (its central statement, the global step): can a six-map with unit arcs have a vertex of four colours "
   "or a repeated colour within 3 of every point? (stub)"), at=(22, 525), sector="seven", tier=1,
  note="FS-114's stub registers 0.2 for the global step being decided at all, in either direction, within FS-114. That is a different event from "
       "this NO holding, so the page does not use it: the NO is priced like every other whole open question (the open-question default), so the "
       "bits do not make it look smaller than it is.")
N("UANO", "no six-map with unit arcs", "conclusion", "The unit-arc half's NO: no six-map with unit arcs colours the plane almost everywhere. "
  "With row 134 it answers Sokolov–Voronov's Question 2, and Polymath16's hope (p. 199) to do without the unit-radius tactic.", GSTUB,
  "A NO answers [SokolovVoronov2025] Question 2 (\"Is it true that 7 colors are needed …?\") yes for its unit-arc half", NOT_THE_NO,
  at=(40, 460), sector="seven", tier=1, answer=7)
N("FOURC", "the four-colour form", "question", "A weaker exclusion: no six-map whose four-colour vertices come within R of every point. It is the "
  "NO for doubly periodic maps alone; for other maps it becomes the NO only with the stuck ray excluded and stuck chains bounded (FS-115).",
  L(135), "for doubly periodic maps four-colour vertices alone suffice", NOT_THE_NO, at=(60, 455), sector="seven",
  words=(GSTUB, "a NO for doubly periodic maps (the four-colour form), one mind | 0.3"))
N("SRAY", "(b′) the stuck ray", "step", "Can a one-sided infinite chain of stuck vertices live in a six-map with unit arcs? Periodic maps have "
  "none. Needed only by the four-colour form, on maps that are not periodic (FS-115, rank 4: no bearing alone).", RSTUB,
  "In a valid map with unit arcs, reduced to a terminal modification, can a stuck chain be infinite in one direction?",
  (L(135), "Not claimed: the NO; FS-114's global step; (b′); (b″)"), at=(58, 530), sector="seven",
  registered=dict(p=0.35, src=RSTUB, quote="(b′) excluded at one mind within FS-115 | 0.35",
                  population="within FS-115: the stuck ray excluded, at one mind"))
N("CHAINB", "(b″) chains bounded", "step", "Is the length of finite stuck chains bounded uniformly over a map? Long chains are arithmetically "
  "free: a map with infinitely many arc radii can carry chains of every length. Named at FS-112's close (FS-115).", RSTUB,
  "Is the length of finite stuck chains bounded — uniformly over the map — or can a valid map carry finite chains of every length?",
  (L(135), "Not claimed: the NO; FS-114's global step; (b′); (b″)"), at=(68, 530), sector="seven",
  registered=dict(p=0.25, src=RSTUB, quote="(b″) bounded (a uniform bound on finite chains) | 0.25",
                  population="within FS-115: a uniform bound on finite chain length"))
N("N3PER", "N3-PER", "held", "A doubly periodic six-map has a periodic terminal modification: no stuck ray, bounded chains. So for periodic "
  "maps the four-colour form needs neither FS-115 step.", B("FS112-N3-PER"),
  "a doubly periodic valid map has a periodic terminal modification: no stuck ray, bounded chains", "hand; two minds: N3; NB3, blind",
  at=(46, 600), sector="seven")
N("N3END", "N3-END", "held", "A stuck chain's end at horn bound −1 has a four-colour vertex with a repeated colour one step beyond it: a ray's "
  "one end is anchored at a four-colour vertex.", B("FS112-N3-END"),
  "a stuck chain's end at horn bound −1 has a four-colour, repeated-colour vertex one step beyond", "hand; two minds: N3; NB3, blind",
  at=(56, 600), sector="seven")
N("Y3END", "Y3-END-NEEDS, corrected", "held", "A chain end of two or more vertices cannot stay terminal: it would need a seventh colour. As "
  "first stated — every three-colour end at a unit arc — it is false: the bowtie is a counterexample (FS112-YB3).", B("FS112-Y3-END-NEEDS"),
  "needs a seventh colour to be terminal; FALSE as stated (BOWTIE)", "the scope one mind: YB3", at=(65, 600), sector="seven",
  also=[(B("FS112-Y3-END-NEEDS"), "hand; levels two minds: Y3; YB3, blind")])
N("HORNEND", "C-HORNEND, C-DOUBLE", "held", "A stuck vertex whose two horns are both bounded by unit arcs on one side is bounded by a unit arc on the other "
  "side too, and is a one-vertex chain.", B("FS112-C-HORNEND"),
  "a stuck vertex of a terminal map with both horns bounded by unit arcs on one side has a unit-arc bound on the other side too and is a "
  "one-vertex chain", "hand; one mind: FS112-C2", at=(75, 600), sector="seven",
  also=[(B("FS112-C-DOUBLE"), "a stuck vertex with all four horn arcs unit arcs has in-type flank tiles at both neighbours, both (Q) centres "
         "with ≥ 4 colours"), (B("FS112-C-DOUBLE"), "hand; two minds: FS112-C2, a sketch; FS114-CV, blind")],
  note="Its companion C-DOUBLE (second quote above, two minds: FS112-C2, a sketch; FS114-CV, blind): when all four horn arcs are unit arcs, both neighbours are four-colour "
       "vertices, so the bowtie end sits within 1 of a four-colour vertex.")
N("BOWTIE", "the bowtie", "positive", "An exact local fragment: a three-colour stuck vertex between two unit circles, locally terminal. It "
  "refutes Y3-END-NEEDS as first stated, and is a local positive a YES could use; whether it lives in a whole six-map is FS-115's question (c).",
  B("FS112-BOWTIE"), "an exact valid fragment: a three-colour stuck vertex between two unit circles, in-type sectors at both neighbours, locally "
  "terminal", "tools, exact; one fragment: YB3; one checker", at=(75, 450), sector="seven")
# ---- FS-114, the unit-arc question: closed undecided (rows 137–138); successors FS-116 (the local exclusion) and FS-117 (route T's count)
LSTUB = STUB("STUB-local-exclusion.md")
TSTUB = STUB("STUB-route-t-count.md")
N("CVEXISTS", "CV-EXISTS", "held", "Every six-map with unit arcs has a vertex of at least four colours, in the map itself. So one local statement "
  "about one such vertex suffices for the unit-arc NO, Siamese pairs included, with no step about stuck rays.", B("FS114-CV-EXISTS"),
  "every valid map with unit arcs has a vertex of at least four colours, in the map itself",
  "hand; two minds, blind to each other: CV; CVB, by different routes; over FS112-N3-DENSE3, N2-TERM, N4-FIN", at=(14, 570), sector="seven",
  also=[({"file": ".claude/skills/grokkings/SKILL.md", "grok": "G83"}, "With unit arcs, the tight question lives at one four-colour vertex.")])
N("LOCALF", "the local exclusion (NO)", "question", "Exclude every six-map fragment on a disc of explicit radius about a four-colour vertex. With "
  "CV-EXISTS it gives the whole unit-arc NO; the capped strip puts the radius above φ²/√2 ≈ 1.8512. FS-116 closed undecided: one ring type removed, "
  "the rest is FS-123–FS-125.", L(137),
  "its NO follows from an explicit radius, uniform in the complexity, about a vertex of at least four colours within which no such map fragment exists",
  (L(137), "the NO; an explicit radius (C114-LOCAL-F, FS-116)"), at=(26, 465), sector="seven", tier=1)
N("GFREE", "the Γ-free vertex dies at 1 + ε", "nogo", "A four-colour vertex whose unit circle carries no boundary arc has no valid six-coloured "
  "fragment, non-Siamese and simple, on any disc of radius above 1: two routes, the second blind.", B("FS116-Y4-EMPTY"),
  "no non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a ring carrying no",
  "derived; held, two minds (the second blind)", at=(51, 495), sector="seven")
N("QFREE", "the (Q)-free vertex dies at 1 + ε", "nogo", "A four-colour vertex whose unit circle carries no (Q) arc has no valid six-coloured "
  "fragment, non-Siamese, simple or not, on any disc of radius above 1: FS-112's bends, read on a fragment, leave only (Q) arcs.", L(149),
  "no non-Siamese valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a ring carrying no (Q) arc",
  "[hand], one mind, kernel pending", at=(84, 520), sector="seven")
N("QPRUNE", "(Q) rings pruned", "held", "On a four-colour vertex's ring, two change points 60° apart whose far germs lie off (Q) arcs share no sole tip "
  "and no sole outer colour; one pinwheel residue is empty.", L(150),
  "The (Q)-ring case list, pruned", "[hand], one mind each, kernel pending", at=(80, 540), sector="seven")
N("MEXCL", "the (Q)-free exclusion, with no map", "nogo", "For every measurable six-colouring proper at almost every unit pair: where four labels meet in a witnessed cycle, the palettes on the point's unit circle cannot almost everywhere hold one of the two other labels. No map, no Siamese clause. Kernel-checked for the whole plane, over the release's lemmas ported with their proofs; the open-set form is by hand.", L(155), "the palettes on its unit circle cannot almost everywhere hold one of the two other labels", "[kernel] for a Borel colouring of the whole plane", at=(90, 520), sector="seven")
N("CENTRES", "cyclic centres exist at every k", "held", "Every closed disc of radius above 1 holds a point where classes meet in a cycle, at every number of colours, with no hypothesis; the data at a centre need the centres finite in a disc.", L(156), "every closed disc of radius greater than 1 contains a cyclic centre", "[hand] or derived from [hand] entries, one mind each, kernel pending", at=(60, 660), sector="seven")
N("COMPSHARP", "the complementary pair, in the exact class", "held", "Two triangle points on disjoint triples of six labels, less than 2 apart, force an edge set onto the unit circle about each common unit point. No cone scale.", L(157), "then one of the six sets K_0, K_1, K_2, K′_0, K′_1, K′_2 is contained in the unit circle about w", "[hand] or derived from [hand] entries, one mind each, kernel pending", at=(47, 650), sector="seven")
N("WIND6", "three outside labels wind", "held", "A loop among three labels with the 60° exclusion has degree 3 modulo 6: six is the one count at which the labels left for a ring can wind. The forcing of a centre that is not a triangle stalls at this circle.", L(158), "then the degree of φ, for the orientation a → b → c of Θ, is congruent to 3 modulo 6", "[hand] or derived from [hand] entries, one mind each, kernel pending", at=(53, 630), sector="seven")
N("PLACEDARC", "the turning ring places a unit-arc centre", "held", "In step form with witnesses near the centre, a turning ring forces a point with four labels present whose own unit circle runs along two unit arcs. No model is known.", L(159), "a measurable instance of FS-124's first question, every hypothesis derived from the seed's data", "[hand] or derived from [hand] entries, one mind each, kernel pending", at=(61, 630), sector="seven")
N("FLOWERS", "the turning ring in a finite family", "held", "In a family of seven flowers of wedges the three-label turning ring and the alternating ring do not exist; with four labels at alternate ring points the turning ring exists, in fragment T2's shape.", L(160), "no model has the turning ring `a, b, n, a, b, n` and at most three labels at every ring point", "[cert]", at=(78, 400), sector="seven")
N("TOP5", "the map step at five", "held", "Given REG-J′₅, the honest five-colour existence form is equivalent to χ_m⁰(ℝ²) ≥ 6.", L(154),
  "The map step at five, as an equivalence", "[hand], one mind, kernel pending", at=(162, 434), sector="six-up")
N("RINGRULE", "change points place four-colour vertices", "held", "On the unit circle of a four-colour vertex, every change point off (Q) arcs, and "
  "every semi-hub but one, places another vertex of at least four colours: they propagate until a (Q) arc intervenes.", B("FS116-RING-GERM"),
  "in a non-Siamese valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y be a change point of the ring",
  "derived; held, two minds (the second blind)", at=(4, 518), sector="seven")
N("YESLIM", "the YES needs no map", "held", "Valid six-coloured fragments on discs of every radius give χ(ℝ²) ≤ 6 with no MR: the local exclusion "
  "decides both ways.", B("FS116-O1-YESLIM"),
  "for every k ≥ 1, if for every R > 0 some closed disc of radius R carries a valid k-coloured fragment",
  "hand; held, two minds (the second blind)", at=(110, 430), sector="six-up")
N("FS123", "the Siamese class", "step", "Does a four-colour vertex whose ring carries no (Q) arc survive past 1 + ε? First: do a fragment's bends keep "
  "it in the class the Γ-free exclusion reads?", STUB("STUB-qfree-ring.md"),
  "the Siamese class: does any four-colour vertex whose ring carries no (Q) arc survive past radius 1 + ε, in any class?",
  (STUB("STUB-qfree-ring.md"), "A rung of route M's first half, smaller than the answer; possibly cheap."), at=(31, 377), sector="seven")
N("FS124", "the (Q) ring", "step", "The rest of the case list: rings with (Q) arcs (SEMI-PAR3, the disk's corner, crossed reciprocity) and vertices of "
  "five or six colours.", STUB("STUB-q-ring.md"),
  "the (Q) ring: does every vertex of at least four colours whose ring carries (Q) arcs, and every vertex of five or six colours, die within an explicit radius?",
  (STUB("STUB-q-ring.md"), "The main remaining case set of the six-map NO with unit arcs, and the YES side's home"), at=(16, 429), sector="seven")
N("FS125", "the saturated local exclusion", "step", "The same exclusion in the class route M's honest branch hands it: saturated fragments.",
  STUB("STUB-saturated-local.md"),
  "the saturated local exclusion: is there an explicit radius about a four-colour vertex within which no saturated valid six-coloured fragment exists?",
  (STUB("STUB-saturated-local.md"), "Route M's first half in the class route M needs, smaller than the answer alone."), at=(44, 394), sector="seven")
N("BOWSQ3", "the bowtie dies at √3", "nogo", "Two width-1 Reuleaux triangles corner to corner at a four-colour vertex fit a disc of radius "
  "3√3/5 exactly and no disc of radius √3: two independent derivations.", B("FS114-Y4-RSTOPALL"),
  "no non-Siamese simple valid fragment holding a Reuleaux bowtie at `p` contains neighbourhoods of `B̄(p, 1)` and of `r = q1 + q2`",
  "hand; three minds: Y4; YB3, blind; the proof side (N4, N5, NB5) blind to both, its last step one mind", at=(34, 575), sector="seven")
N("PINW", "the pinwheel dies at 1 + ε", "nogo", "Four unit-arc edges turning one way at a four-colour vertex die within 1 + ε of it, but for "
  "two named exceptions (an edge exactly 60° long; a blade's side a unit arc about its own edge's end).", B("FS114-Y5-PINALL"),
  "except under E1 (an edge of exactly 60°) or E2 (a blade's counter-clockwise side a unit arc about its clockwise edge end)",
  "hand; two minds: Y5; YB4, blind; tools exact at named values", at=(49, 555), sector="seven")
N("ROUTET", "route T, the count", "held", "Euler's formula on the map graph: a charge summing to zero, negative only where four-colour vertices "
  "carry three or four unit-arc edges; it reaches the non-Siamese part only (FS-117).", B("FS114-N2-ENDS"),
  "negative only at a degree-4 vertex with at least three tactic edges",
  "hand; one mind: N2; tools exact; its inequality form two minds (NB-ARCS, blind)", at=(61, 525), sector="seven",
  words=(TSTUB, "K2′ derived under K1 at one mind (0.35)"))
N("CAPSTRIP", "the capped strip", "positive", "The strip with each top tile capped by a unit arc holds every disc of radius below φ²/√2 about a "
  "four-colour vertex, and no extension does better.", B("FS114-Y-DIAL"),
  "the capped strip is a valid fragment holding every closed disc of radius below `φ²/√2 ≈ 1.8512` about a midline four-colour vertex",
  "tools, exact; two minds: Y; YB, blind", at=(123, 465), sector="six-up")
E("N3DENSE3", "CVEXISTS", "rests", B("FS114-CV-EXISTS"), "over FS112-N3-DENSE3, N2-TERM, N4-FIN")
E("CVEXISTS", "LOCALF", "rests", L(137), "its NO follows from an explicit radius, uniform in the complexity, about a vertex of at least four colours within which no such map fragment exists")
E("GFREE", "LOCALF", "context", B("FS116-Y4-EMPTY"), "has a ring carrying no", label="a ring type removed")
E("GFREE", "QFREE", "rests", L(149), "the exclusion of rings with no arc of the boundary gives the (Q)-free one", label="the bends")
E("QFREE", "LOCALF", "context", L(149), "FS-123's first question is answered yes", label="the (Q)-free half removed")
E("MEXCL", "QFREE", "context", L(155), "It is rows 148–149's exclusion in measure", label="the same exclusion, with no map")
E("PLACEDARC", "FLOWERS", "context", L(159), "the one model the day's search kept (row 160) is the other case", label="the kept model is the hard case")
E("QPRUNE", "LOCALF", "context", L(150), "The (Q)-ring case list, pruned", label="pruning rules")
E("RINGRULE", "LOCALF", "context", B("FS116-RING-GERM"), "let y be a change point of the ring", label="the placing rule")
E("YESLIM", "UB6", "rests", B("FS116-O1-YESLIM"), "some closed disc of radius R carries a valid k-coloured fragment", label="fragments on every disc")
E("FS123", "LOCALF", "rests", STUB("STUB-qfree-ring.md"), "the (Q)-free ring", label="its (Q)-free half")
E("FS124", "LOCALF", "rests", STUB("STUB-q-ring.md"), "the (Q) ring", label="its (Q) half")
E("FS125", "FS128", "context", STUB("STUB-saturated-local.md"), "the saturated local exclusion", label="route M's class")
E("LOCALF", "UANO", "rests", L(137), "So one local statement suffices for S–V's Question 2 with unit arcs")
E("BOWSQ3", "LOCALF", "context", L(138), "Where the count gives six room, the configurations die locally", label="a piece")
E("PINW", "LOCALF", "context", L(138), "Where the count gives six room, the configurations die locally", label="a piece")
E("ROUTET", "BOWSQ3", "context", B("FS114-N2-ENDS"), "negative only at a degree-4 vertex with at least three tactic edges", label="where six has room")
E("CAPSTRIP", "LOCALF", "blocks", B("FS114-Y-DIAL"), "no extension does better", label="R > φ²/√2")
N("MEET", "the doors are two routes", "reading-link", "Card 1, answered at two minds (one blind): FS-114's NO plus the cone scale gives seven only "
  "through a third statement — the map step on route M, the forced pair at every complexity on route R — and each is the answer restated.",
  {"file": "plans/FS111-derivation.md"}, "1 − lim_{ε→0} µ₆(ε) = inf_K δ₀(K); hence χ_m⁰(ℝ²) ≥ 7 ⟺ inf_K δ₀(K) > 0",
  (B("FS111-C1-UNIF"), "hand; two minds: P; V0, blind"), at=(41, 230),
  sector="seven", tier=1, also=[(L(133), "So stability at six has two routes, each needing a third statement")])
# ---- FS-111's successors (D9): the map step (FS-121), the pinch at a junction (FS-120), the forced pair (FS-122)
N("FS121", "the map step", "step", "Route M's third statement. Closed undecided (rows 142–144): honest saturated ladders end inward at (Q) or (R2) arcs and never outward; honesty is free (Grundy); symmetric and grid colourings are regular; open: curved tangent interfaces, lateral extent, the top colour at six.", STUB("STUB-map-step.md"),
  "the map step: can a tight colouring of the plane be replaced by a map", (STUB("STUB-map-step.md"),
  "Decisive at its top, and at its top the answer restated."), at=(57, 270), sector="seven", tier=1)
N("FS120", "the pinch at a junction, and the cover route at five", "step", "In a measurable fall colouring, a pinch climbs a short ladder of unit parallels; is its cascade "
  "absorbed where the ladder ends?", STUB("STUB-pinch-at-junction.md"),
  "the pinch at a junction: can a pinch in a measurable fall colouring of the plane be removed locally", (STUB("STUB-pinch-at-junction.md"),
  "None alone; it is a colour-generic rung of route M, smaller than the answer."), at=(66, 416), sector="seven")
N("FS122", "the forced pair", "step", "Route R's third statement: a close complementary pair of fat junctions in every near-colouring; "
  "equivalent to seven (FS111-W-NEG), so its smaller statements are B-RR and a robust junction count.", STUB("STUB-forced-pair.md"),
  "the forced pair at every complexity (route R's third statement)", (STUB("STUB-forced-pair.md"), "Decisive, and the answer restated:"),
  at=(29, 275), sector="seven")
N("FS126", "curved pencils", "step", "Does any honest saturated colouring have a curved tangent-type interface? A NO decides three of FS-121's open claims; under a cocompact symmetry there are none (one mind).",
  STUB("STUB-curved-pencils.md"),
  "can an honest saturated colouring of the plane, with any number of colours, have a curved tangent-type interface?", (STUB("STUB-curved-pencils.md"), "None alone; a colour-generic rung of route M's honest branch, smaller than the answer."), at=(58, 368), sector="seven")
N("FS127", "lateral extent", "step", "Is the singular set of every honest saturated colouring locally finite? Open at LAT, point-like accumulation; true on grids (two minds).",
  STUB("STUB-lateral-extent.md"),
  "is the singular set of every honest saturated colouring of the plane locally finite?", (STUB("STUB-lateral-extent.md"), "None alone; a colour-generic rung."), at=(52, 418), sector="seven")
N("FS128", "the top colour, at five and six", "step", "Binding the top colour of a Grundy six-colouring (TOP₆), and NO-PAR under Condition 5 (the parked cover route).",
  STUB("STUB-top-colour.md"),
  "can the top colour of a Grundy six-colouring be bound, and does NO-PAR hold under Condition 5?", (STUB("STUB-top-colour.md"), "At six, and next to the answer."), at=(61, 162), sector="seven")

# ================================================================ toward six from below (right)
N("FS104", "χ_CP(ℝ²) ≥ 6", "question", "Is the stationary (equivalently the measurable) chromatic number at least six? Two-sided: a "
  "YES gives χ(ℝ²) ≥ 6 given MR — a new lower bound, independent of the map line, leaving six against seven; a NO is a stationary "
  "five-colouring, which gives χ(ℝ²) = 5 with no MR. No held result decides it, and no one-point density bound can (FS-104).", STUB("STUB-cp-plane-six.md"),
  "Answered YES by citation, 2026-10-07: χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6", (STUB("STUB-cp-plane-six.md"), "Answered YES by citation, 2026-10-07: χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6"), at=(86, 222), sector="six-low",
  tier=1)
N("R129", "density cannot give six", "nogo", "One colour class at a time is capped below 4.37: the bound that gave five is a fractional "
  "bound rounded up, and that route never gives six. A proof of six must use how the classes fit together.", L(129),
  "1/α_loc ≤ 4.36: that route never gives six", "FRAC, TJ, ROUND, DV, TF, 47 two derivations (FS103-F; FS103-B blind to F's record)",
  at=(110, 205), sector="six-low",
  posed=[dict(question="the first clause of Ducz–Varga's Conjecture 1 (2026), and Matolcsi et al.'s equality question (2025, §2) — with no hypothesis, over "
              "[OAIMath2026]'s rigidity theorem, at [hand], one mind", state="answered", src=LGC, quote="row 129 (FS-133; one mind) answers the first clause of [DuczVarga2026]'s Conjecture 1 and "
              "[MatolcsiEtAl2025] §2's equality question")])
N("FS80", "window-frequency certificate", "question", "An averaged certificate at five colours on the real plane — the integrality "
  "shape a six certificate must take (FS-80).", FSR(19), "averaged certificates at five colours on the real plane — the integrality shape a six certificate must take",
  (STUB("STUB-window-frequency-certificate.md"), "FS-80 — a window-frequency certificate at four colours, kept small by the symmetry (stub)"),
  at=(80, 320), sector="six-low", words=(FSR(19), "soft as to success"))
N("R125", "ℚ(√167) at six = plane + PL", "held", "Given MR, six colours at ℚ(√167) is exactly χ_CP(ℝ²) ≥ 6 together with product "
  "locality at 23 and 43 — a reduction, not a bound.", L(125), "Y has none ⟺ χ_CP(ℝ²) ≥ 6 ∧ PL_∃(23, 43)",
  "B-1, B-2, the projection lemma and the density no-go two blind (X21D; X21V)", at=(92, 390), sector="six-low")
N("PL", "PL∃(23, 43)", "question", "Product locality at the places 23 and 43: the direction missing from χ_CP(ℝ²) ≥ 6 to six at "
  "ℚ(√167) (FS-96, FS-67).", L(125),
  "PL_∃(23, 43) is exactly the direction missing from χ_CP(ℝ²) ≥ 6 ⟹ χ(ℚ(√167)²) ≥ 6", (L(125), "Not claimed: anything about six."),
  at=(106, 390), sector="six-low")
N("FS59", "χ(ℚ(√167)²) ≥ 6", "conclusion", "Six at ℚ(√167), the conjecture's widest gap (≥ 6 predicted, 5 held at [hand], 4 in the "
  "kernel). Through the plane only: never cheaper than FS-104 (FS-59).", FSR(21),
  "six at ℚ(√167) is rung D plus PL_∃(23, 43)",
  (FSR(21), "the conjecture's widest gap — predicted ≥ 6 against a proven 5 at [hand] (4 in the kernel, row 119)"),
  at=(100, 300), sector="six-low")
N("R119", "χ(ℚ(√167)²) ≥ 4, kernel", "held", "Four colours at ℚ(√167), in the kernel with no finite graph — the kernel's lower end of "
  "the widest gap.", L(119), "χ(ℚ(√167)²) ≥ 4 in the kernel, with no finite graph",
  "[kernel; standard three axioms, no native purchase]", at=(104, 490), sector="six-low")

# ================================================================ the YES side: at most six, with no MR (bottom)
N("LINK2", "upper bounds need no MR", "held", "A measurable colouring proper at almost every unit pair, moved by a random rigid motion, "
  "colours every finite graph properly almost surely; de Bruijn–Erdős finishes. So χ(ℝ²) ≤ χ_m⁰(ℝ²) with no MR. Its argument is in print "
  "(Gwyn–Stavrianos 2022) under an invariant mean.", AIM,
  "Upper bounds need no MR. χ(ℝ²) ≤ χ_m⁰(ℝ²): move a measurable colouring by a random rigid motion",
  "[hand, two minds]: FS103-N's N-EASY, PA1's (E)", at=(186, 176), sector="six-up", tier=1,
  note="LEDGER.md row 130's grade bracket lists N-EASY at one mind; § The aim adds PA1's (E) as the second.")
N("HOLES6", "vanishing holes save a colour", "conclusion", "Six classes cover the plane up to holes of density tending to 0 as the band "
  "narrows: lim µ₆(ε) = 1. A refutation of seven needs no wild set — a sequence of periodic grid colourings, wild only in the limit.",
  L(131), "a refutation needs no wild set — it is a sequence of periodic grid colourings with vanishing holes, the wildness only in the limit",
  BOTH_GAP, at=(148, 215), sector="six-up", tier=1)
N("TSMYES", "a tight six-map (YES)", "step", "FS-114's other answer: a map by segments and circular arcs, unit arcs allowed, "
  "six-coloured with no two interior points of one colour at distance exactly 1. At bounded complexity it gives χ(ℝ²) ≤ 6 with no MR. By "
  "row 135 it must hold a four-colour or repeated-colour vertex within 3 of every point and, by row 137, a vertex of at least four colours.", GSTUB,
  "A YES gives χ(ℝ²) ≤ 6 with no MR", (GSTUB, "FS-114 — the unit-arc question (its central statement, the global step): can a six-map with "
  "unit arcs have a vertex of four colours or a repeated colour within 3 of every point? (stub)"), at=(128, 325), sector="six-up", tier=1)
N("UNB", "unbounded complexity", "question", "A family of near-colourings of unbounded complexity whose holes vanish "
  "while their junction scales shrink to 0 — W's claim itself, if FS-111 fails.", STUB("STUB-reg-scale.md"),
  "A family refuting (B) with holes → 0 is still W's claim itself: χ(ℝ²) ≤ 6 with no MR.", BOTH_GAP, at=(162, 300), sector="six-up")
N("STRIP", "the six-coloured strip", "positive", "Axenovich et al. 2014, Thm 4.2: a tight six-coloured strip of height √15/2 + √3 ≈ 3.668, "
  "its unit arcs all centred at four-colour vertices. Rebuilt three times from its words, accepted by three exact checkers (FS-112).",
  B("FS112-CAL-STRIP"), "Axenovich et al.'s strip, rebuilt from its words, is a valid six-colouring of height √15/2 + √3, tight; every unit arc "
  "both-kind at a four-colour vertex", "tools, exact; three rebuilds, two blind: Y; YB; YB2; three checkers", at=(119, 412), sector="six-up",
  also=[(STUB("STUB-unit-arc-half.md"), "One exact known positive: [AxenovichEtAl2014] Thm 4.2's six-coloured strip of height "
         "√15/2 + √3 (≈ 3.668)")])
N("DISK", "the six-tiled disk", "positive", "Polymath16's six-tiled disk (Fig. 10), transcribed and rebuilt exactly: 20 unit arcs, "
  "all centred at four-colour corners. No vertex-centred disc beyond radius φ fits in any valid extension, and φ is attained.",
  B("FS112-CAL-DISK"), "Polymath's Fig. 10 disk, transcribed by eye and solved exactly, reproduces r² = (25 + 9√5)/10 and is valid",
  "tools, exact; two rebuilds identical, one blind: Y2; YB2; two checkers", at=(140, 400), sector="six-up")
N("STOP", "both stop at a pinned corner", "nogo", "The strip and the disk stop for the same reason: a close complementary pair "
  "saved by a four-colour vertex at one common unit point is unsaved at the other — exactly where every six-map needs a second four-colour "
  "vertex (row 135's rhombus lemma).", B("FS112-STOP"),
  "the pinned corner: both positives end where a close complementary pair, saved by a four-colour centre at one common unit point, is unsaved "
  "at the other", "hand and tools; two minds: Y2; YB2, blind", at=(128, 480), sector="six-up")
N("Y3STOP", "pinned corners hold", "nogo", "Round 3: both ways past the pinned corners fail one ring further out — the strip's cut and "
  "the disk's blue triangle — confirmed by a blind verifier (FS112-YB3).", B("FS112-Y3-PIN"),
  "both pinned-corner escapes fail one ring further out", "tools, exact + hand; two minds: Y3; YB3, blind", at=(146, 470), sector="six-up")
N("COR3", "the rhombus lemma", "held", "A close complementary pair of three-colour vertices sits on a unit rhombus whose other two corners are "
  "four-colour vertices. So a three-colour vertex has at most three such partners — the design rule a YES must meet.", B("FS112-N3-COR3"),
  "close complementary cubic trichromatic pairs lie on unit rhombi whose other corners are four-colour double leaving centres (T2 forced)",
  "hand; two minds: N3; NB3, blind", at=(114, 500), sector="six-up",
  also=[(B("FS112-C-PARTNERS"), "a cubic trichromatic vertex's close complementary cubic partners are rhombus completions of its leaving "
         "centres: at most three")])
N("PARTS", "Parts's six-tiling", "positive", "The best printed six-tiling leaves holes of density 1.43·10⁻⁴ — small, but it has no "
  "parameter that drives them to 0.", L(131), "the upper from [Parts2020c]'s tiling (δ₆ = 1.430172·10⁻⁴)",
  (L(131), "LOCAL over Parts [external]"), at=(168, 390), sector="six-up")

# ================================================================ toward exactly five (lower left)
N("FS44", "a CP five-colouring", "question", "The shape of a stationary five-colouring of the plane — row 131 at five colours: "
  "lim µ₅(ε) = 1. Decisive if it lands: χ(ℝ²) = 5 with no MR (FS-44).", STUB("STUB-fifth-colour-structure.md"),
  "a CP five-colouring of the plane does not exist",
  (STUB("STUB-fifth-colour-structure.md"), "FS-44 — The fifth colour: what replaces residue rigidity for five-colourings over a 6-open "
   "field (STUB, 2026-09-13; minted by Kooshi in the FS-38 fork session)"), at=(216, 245), sector="five", tier=1,
  words=({"file": "plans/RERANK-2026-09-27.md"}, "the conjecture's bold form predicts no (G48)"))

# ================================================================ edges (premise → conclusion)
for b, a in (("LB7", "A7"), ("UB7", "A7"), ("LB6", "A6"), ("UB6", "A6"), ("LB5", "A5"), ("UB5", "A5")):
    E(b, a, "half", STANDS, "χ(ℝ²) ∈ {6, 7}")
E("DEGREY", "LB5", "rests", INTERVAL, "the lower end is chromaticNumber_plane_ge_five — de Grey's 1581-vertex unit-distance graph")
E("SEVEN", "UB7", "rests", INTERVAL, "the upper end is chromaticNumber_plane_le_seven — the 4/5 × 3/5 brick colouring")
# the engine
E("EL", "MR", "rests", L(120), "the positive-entropy input [EinsiedlerLindenstrauss2022] Thm 1.3")
E("MR", "R128", "rests", L(128), "The collapse: given MR, the plane's number is a field's.")
E("MR", "R121", "rests", L(121), "MR at ℚ(√47) (row 120) with J45's SP-Cor and T-C(A) at S = ∅ gives ≥ 5")
E("MR", "R123", "rests", L(123), "With MR (row 120) that gives five")
E("MR", "R125", "rests", L(125), "Given MR: χ(ℚ(√167)²) ≤ 5 ⟺ Y = UD(ℝ²) × G₂₃ × G₄₃ has a cut-and-project five-colouring", bus=True)
E("R128", "LB7", "rests", AIM, "gives χ(ℝ²) = 7")
E("R130", "LB7", "rests", L(130), "With no hypothesis ([OAIMath2026] Thm 1.3; χ_m⁰ ≤ χ kernel-checked there and audited here, EXT-OAI1): χ(ℝ²) = χ_m⁰(ℝ²)")
E("M7", "LB7", "rests", AIM, "gives χ(ℝ²) = 7")
E("R128", "LB6", "rests", STUB("STUB-cp-plane-six.md"), "Answered YES by citation, 2026-10-07: χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6", bus=True)
E("R130", "R131", "rests", L(131), "its first equivalence is row 130's")
# the algebraic lower bound and the local–global structure
E("R121", "LB5", "rests", STANDS, "a subfield's plane is a subgraph of ℝ²'s, so χ(ℚ(√47)²) = 5 (row 121) gives χ(ℝ²) ≥ 5")
E("SUB", "LB5", "rests", STANDS, "a subfield's plane is a subgraph of ℝ²'s, so χ(ℚ(√47)²) = 5 (row 121) gives χ(ℝ²) ≥ 5")
E("R99", "R123", "rests", L(123), "below five it is row 99")
E("R52", "R123", "rests", L(123), "the upper half is the residue map at the place realising L(F) (row 52)")
E("LG", "A7", "predicts", LGC, "and its bold form is χ(ℝ²) = 7")
E("R127", "R123", "formalizes", L(127), "min(L(F), 5) ≤ χ(F²) for every real number field (SpectralChain.min_localBound_five_le_chromaticNumber)")
E("FS101", "R127", "formalizes", STUB("STUB-main-clause-five-kernel.md"), "Status: first slot done (X11K3, 2026-09-26; LEDGER.md row 127")
E("FS113", "MR", "formalizes", STUB("STUB-mr-in-lean.md"), "MR(F) as LEDGER.md row 120 states it")
E("LEANWALL", "R128", "formalizes", STUB("STUB-regularity-wall.md"), "the collapse (row 128), the measurable chain (row 130, link 2)")
E("LEANWALL", "R131", "formalizes", STUB("STUB-regularity-wall.md"), "the collapse (row 128), the measurable chain (row 130, link 2)")
# toward seven
E("R131", "RR", "rests", L(133), "χ_m⁰(ℝ²) ≥ 7 (row 131's C-Q-STAB, disc form)")
E("RR", "M7", "rests", L(133), "given the quantified cone lemma, χ_m⁰(ℝ²) ≥ 7 (row 131's C-Q-STAB, disc form) follows from (A)")
E("TSMNO", "FS121", "rests", STUB("STUB-map-step.md"), "The frame (FS-111's card 1, two minds, one blind).", label="route M")
E("FS126", "FS121", "rests", STUB("STUB-curved-pencils.md"), "have a curved tangent-type interface", label="its ends")
E("FS127", "FS121", "rests", STUB("STUB-lateral-extent.md"), "is the singular set of every honest saturated colouring of the plane locally finite", label="its singular set")
E("FS128", "FS121", "rests", STUB("STUB-top-colour.md"), "can the top colour of a Grundy six-colouring be bound", label="its six-colour rungs")
E("FS120", "FS127", "rests", STUB("STUB-lateral-extent.md"), "A measurable fall colouring with a non-locally-finite Σ refutes the claim", label="a potential refutation")
E("FS120", "FS121", "rests", STUB("STUB-map-step.md"), "FS-120's rung", label="its finiteness rung")
E("FS121", "M7", "rests", {"file": "plans/FS111-derivation.md"}, "given Q-NO, REG-A₆ ⟺ χ_m⁰(ℝ²) ≥ 7", label="the answer restated")
E("RR", "FS122", "rests", STUB("STUB-forced-pair.md"), "FS-107's reduction", label="route R")
E("FS122", "M7", "rests", {"file": "plans/FS111-derivation.md"}, "A-ALL, read with its δ", label="the answer restated")
E("FS111", "MEET", "rests", {"file": "plans/FS111-derivation.md"}, "hence χ_m⁰(ℝ²) ≥ 7 ⟺ inf_K δ₀(K) > 0", label="card 1")
E("NG131", "M7", "blocks", L(131), "Two no-gos for proofs: an argument counting only holes met by unit circles or bicycles proves at most "
  "1 − µ₆(ε) ≳ ε", label="hole-counting proofs cannot reach it")
E("R134", "TSMNO", "rests", STANDS, "under Condition 5 none does (row 134)")
E("UANO", "TSMNO", "rests", STANDS, "with unit arcs every one has a vertex of at least four colours (rows 135, 137)")
E("R132", "R134", "rests", L(134), "S–V Cor. 1, almost everywhere for curved cubic maps with no d = 2 exception, refutes it")
E("R134", "N3BASE", "rests", B("FS112-N3-BASE"), "over row 134's base, re-derived by BASE-V but for Lemma 4 at cusps")
E("N3BASE", "N3DENSE3", "rests", B("FS112-N3-DENSE3"), "over N3-BASE and DISC1")
E("N3DENSE3", "GSTEP", "rests", L(135), "So S–V's Question 2 with unit arcs is reduced, not answered: its NO is exactly the exclusion of such maps.")
E("N3DENSE3", "COMPOSE", "rests", B("FS112-C-COMPOSE"), "the global step in DENSE3's form is the NO for all maps")
E("GSTEP", "UANO", "rests", L(135), "excluding maps with such vertices within 3 of every point is the NO, with no ray step")
E("COMPOSE", "UANO", "rests", L(135), "excluding maps with such vertices within 3 of every point is the NO, with no ray step",
  label="no ray step")
E("GSTEP", "TSMYES", "context", GSTUB, "Exclude it (the NO), or build one (the YES).", label="the same question's other answer", bus=True)
# the four-colour form, and FS-115 beneath it: needed only there, and only for maps that are not periodic
E("FOURC", "UANO", "context", L(135), "for aperiodic maps that four-colour form needs the stuck ray (b′) and a uniform bound on finite chains (b″) "
  "excluded", label="an alternative form of the NO")
E("SRAY", "FOURC", "context", L(135), "for aperiodic maps that four-colour form needs the stuck ray (b′) and a uniform bound on finite chains (b″) "
  "excluded", label="needed by this form, aperiodic maps only")
E("CHAINB", "FOURC", "context", L(135), "for aperiodic maps that four-colour form needs the stuck ray (b′) and a uniform bound on finite chains "
  "(b″) excluded", label="needed by this form, aperiodic maps only")
E("N3PER", "FOURC", "context", B("FS112-N3-PER"), "no stuck ray, bounded chains", label="periodic maps need neither")
E("N3END", "SRAY", "partial", RSTUB, "So a ray's one end is anchored at a four-colour vertex", label="a lemma toward it")
E("Y3END", "SRAY", "partial", RSTUB, "That covers every end of a chain of two or more vertices (FS112-END).", label="a lemma toward it")
E("HORNEND", "SRAY", "partial", RSTUB, "a horn bound ±1 on both horns of a stuck vertex of a terminal map occurs only at a one-vertex chain "
  "bounded by unit arcs on both sides", label="a lemma toward it")
E("BOWTIE", "Y3END", "context", B("FS112-Y3-END-NEEDS"), "FALSE as stated (BOWTIE)", label="refutes it as first stated")
E("BOWTIE", "TSMYES", "partial", {"file": "plans/FRONTIER-STUBS.md", "row": "16"}, "its fragments (the pencil, BOWTIE) stay local positives a YES could use",
  label="a local fragment, not a map")
# toward six from below
E("FS104", "LB6", "rests", STUB("STUB-cp-plane-six.md"), "Answered YES by citation, 2026-10-07: χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6", label="its YES, given MR")
E("FS104", "FS44", "context", STUB("STUB-fifth-colour-structure.md"), "a CP five-colouring of the plane does not exist", label="its NO is this")
E("FS80", "FS104", "rests", FSR(19), "a certificate gives χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6 (row 130), hence χ(ℝ²) ≥ 6 given MR (row 128)")
E("R129", "LB6", "blocks", L(129), "1/α_loc ≤ 4.36: that route never gives six", label="one class at a time never gives six")
E("R125", "FS59", "rests", L(125), "Y has none ⟺ χ_CP(ℝ²) ≥ 6 ∧ PL_∃(23, 43)")
E("FS104", "FS59", "rests", L(125), "Y has none ⟺ χ_CP(ℝ²) ≥ 6 ∧ PL_∃(23, 43)")
E("PL", "FS59", "rests", L(125), "PL_∃(23, 43) is exactly the direction missing from χ_CP(ℝ²) ≥ 6 ⟹ χ(ℚ(√167)²) ≥ 6")
E("FS59", "LB6", "rests", FSR(21), "on the answer only through the plane: six at ℚ(√167) gives χ(ℝ²) ≥ 6")
E("SUB", "LB6", "rests", {"file": "Proofs/HadwigerNelson/Bridge.lean", "decl": "chromaticNumber_planeOver_le_plane"},
  "The plane over any real subfield needs at most as many colours as the plane.", faint=True, bus=True)
E("R119", "FS59", "context", L(119), "The conjecture's widest gap has its kernel lower end here (four; five at [hand], row 123; at least six "
  "predicted; G59)", label="the gap's kernel floor")
# the YES side
E("LINK2", "UB6", "rests", AIM, "Upper bounds need no MR.")
E("LINK2", "UB5", "rests", AIM, "Upper bounds need no MR.")
E("R131", "UB6", "rests", L(131), "χ_m⁰(ℝ²) ≤ k ⟺ χ_CP(ℝ²) ≤ k ⟺ µ_k⁰ = 1 ⟺ lim_{ε→0} µ_k(ε) = 1", bus=True)
E("R131", "UB5", "rests", L(131), "χ_m⁰(ℝ²) ≤ k ⟺ χ_CP(ℝ²) ≤ k ⟺ µ_k⁰ = 1 ⟺ lim_{ε→0} µ_k(ε) = 1", bus=True)
E("HOLES6", "UB6", "rests", L(131), "The step from a refutation to χ(ℝ²) ≤ 6 is link 2's argument")
E("TSMYES", "HOLES6", "rests", L(133), "at bounded arc complexity K, band-proper designs with vanishing holes exist iff a full tight "
  "a.e.-proper six-colouring by a map of complexity ≤ K exists")
E("WEQK", "HOLES6", "rests", L(133), "at bounded arc complexity K, band-proper designs with vanishing holes exist iff a full tight "
  "a.e.-proper six-colouring by a map of complexity ≤ K exists", bus=True)
E("UNB", "HOLES6", "rests", STUB("STUB-reg-scale.md"), "A family refuting (B) with holes → 0 is still W's claim itself: χ(ℝ²) ≤ 6 with no MR.")
E("STRIP", "TSMYES", "partial", STUB("STUB-unit-arc-half.md"), "One exact known positive: [AxenovichEtAl2014] Thm 4.2's six-coloured "
  "strip of height √15/2 + √3 (≈ 3.668)", label="a tight fragment, not the plane")
E("DISK", "TSMYES", "partial", B("FS112-CAL-DISK"), "20 unit arcs, all both-kind at four-colour corners",
  label="a tight fragment, not the plane")
E("PARTS", "HOLES6", "partial", L(131), "the upper from [Parts2020c]'s tiling (δ₆ = 1.430172·10⁻⁴)", label="small holes, not vanishing")
E("COR3", "STOP", "rests", L(136), "With row 135's rhombus lemma the stop is where every valid map needs a second four-colour vertex")
E("STOP", "TSMYES", "blocks", B("FS112-STOP"), "the pinned corner: both positives end where a close complementary pair",
  label="the held positives stop at a pinned corner")
E("Y3STOP", "TSMYES", "blocks", B("FS112-Y3-PIN"), "both pinned-corner escapes fail one ring further out",
  label="no way past the pinned corners")
E("WPOLY", "TSMYES", "blocks", L(133), "polygonal designs of bounded complexity keep holes ≥ δ₀(K), bar d = 2 (W-POLY)",
  label="a YES cannot be polygonal")
E("R134", "TSMYES", "blocks", L(134), "no locally finite map of the plane whose boundaries are segments and circular arcs, none of radius 1, "
  "carries a six-colouring", label="a YES must use unit arcs", bus=True)
E("R132", "TSMYES", "blocks", L(132), "polygonal colourings need seven, and so do locally finite tilings by convex polygons",
  label="a YES cannot be regular", bus=True, faint=True)
# toward exactly five
E("FS44", "UB5", "rests", STUB("STUB-fifth-colour-structure.md"), "a CP five-colouring of the plane does not exist")
E("MAPS6", "FS44", "blocks", L(132), "maps need six for arc maps (segments and circular arcs)", label="a five cannot be a map")
E("R132", "FS44", "blocks", AIM, "Regular colourings need seven, verified and almost everywhere", label="a five cannot be regular",
  bus=True, faint=True)

# ================================================================ routes: a route is the set of links whose credences multiply
ROUTES = [
    dict(id="interval", name="The classical interval, in the kernel", answer="5–7", half="both",
         links=["DEGREY", "SEVEN", "LB5", "UB7"], reaches=["LB5", "UB7"],
         about="Both ends of 5 ≤ χ(ℝ²) ≤ 7, checked by Lean's kernel on the standard three axioms (row 33). Not new mathematics: the ground "
               "every route stands on."),
    dict(id="alg5", name="Five, algebraically, through measure rigidity", answer=5, half="lower",
         links=["EL", "MR", "R121", "SUB"], reaches=["LB5"],
         about="χ(ℚ(√47)²) = 5 gives χ(ℝ²) ≥ 5 with no witness object (rows 120–121). A second proof of a held bound — it moves no value, "
               "and its publication waits on MR in Lean."),
    dict(id="wall7", name="The regularity wall, toward seven", answer=7, half="lower",
         links=["EL", "MR", "R128", "R130", "R131", "RR", "WEQK", "MEET", "R132", "R134", "N3BASE", "N3DENSE3", "COMPOSE", "GSTEP", "GFREE", "FS123", "FS124", "FS125",
                "FS111", "FS121", "FS126", "FS127", "FS128", "FS120", "FS122", "SEVEN", "UB7"],
         reaches=["LB7", "UB7"],
         about="Given MR the plane's number is its measurable number (rows 128, 130); that is seven iff vanishing holes cannot save a colour "
               "(row 131). R's reduction splits it into door (A), no tight six-map, and door (B), the cone scale (FS-111). Door (A) is closed "
               "under Condition 5 (row 134); with unit arcs FS-112 reduced it to one statement, the global step (FS-114). "
               "Card 1 (FS-111, two minds) found the two doors are two routes, not halves: FS-114's NO reaches seven only through the map step (FS-121), or route R's forced pair (FS-122) with the NO idle — and each third statement is the answer restated; route M's rungs hold down to the pinch at a junction (FS-120)."),
    dict(id="yes6", name="The YES side: a tight six-map", answer=6, half="upper",
         links=["LINK2", "R131", "WEQK", "TSMYES"], reaches=["UB6"],
         about="A tight six-map at bounded complexity gives vanishing holes (W-EQ-K), hence χ(ℝ²) ≤ 6 with no MR. The held positives "
               "(the strip, the disk) are tight fragments that stop at a pinned corner."),
    dict(id="yes6b", name="The YES side at unbounded complexity", answer=6, half="upper",
         links=["LINK2", "R131", "UNB"], reaches=["UB6"],
         about="A family of near-colourings whose holes vanish while their junctions shrink — door (B)'s negation, W's claim itself."),
    dict(id="cp6", name="Six from below: χ_CP(ℝ²) ≥ 6", answer=6, half="lower",
         links=["EL", "MR", "R128", "FS104"], reaches=["LB6"],
         about="Given MR, χ(ℝ²) ≥ 6 is χ_CP(ℝ²) ≥ 6 (FS-104). One colour class at a time can never give it (row 129)."),
    dict(id="win6", name="Six from below by an averaged certificate", answer=6, half="lower",
         links=["EL", "MR", "R128", "FS80"], reaches=["LB6"],
         about="A window-frequency certificate at five colours on the real plane would give χ_CP(ℝ²) ≥ 6 (FS-80)."),
    dict(id="q167", name="Six from below through ℚ(√167)", answer=6, half="lower",
         links=["EL", "MR", "R125", "FS104", "PL", "SUB"], reaches=["LB6"],
         about="Six at ℚ(√167) gives χ(ℝ²) ≥ 6 with no MR, but given MR it contains χ_CP(ℝ²) ≥ 6 as a conjunct (row 125): never cheaper "
               "than FS-104."),
    dict(id="five", name="Exactly five: a stationary five-colouring", answer=5, half="upper",
         links=["LINK2", "R131", "FS44"], reaches=["UB5"],
         about="Row 131 at five colours: a CP five-colouring of the plane gives χ(ℝ²) = 5 with no MR (FS-44). It cannot be regular or a map."),
]

# ================================================================ the credence table: an instrument, never evidence
CREDENCE = [
    dict(status="kernel", p=1.0, why="Checked by Lean's kernel: zero bits. Distance to publication counts it as done.", src=None, quote=None),
    dict(status="cert", p=0.99, why="An exact object accepted by exact checkers: the strip and the disk rebuilt two or three times, one or two "
         "rebuilds blind; the bowtie once, one checker.", src=None, quote=None),
    dict(status="hand-2b", p=0.95, why="A hand proof checked by a second mind that did not see the first. The theorem audit found one hand proof "
         "wrong among 184, and grades under-stated four times for every over-statement — the measured record is better than this default.",
         src=L(77), quote="184 hand, 23 derived, 31 tools, 2 cert"),
    dict(status="hand-2", p=0.90, why="A hand proof checked by a second mind that saw it. Lower than blind: blind verifiers still find a "
         "divergence of truth in about 0.4 of milestones (FS-112's registration, from FS-110's rate).",
         src=PLAN112("E16"), quote="a blind verifier finds a divergence of truth"),
    dict(status="hand-1", p=0.80, why="One mind: among others FS-112's composition (C-COMPOSE) and the stuck-ray lemmas of its close.", src=None,
         quote=None),
    dict(status="external", p=0.90, why="Claimed in print and not re-checked here (Einsiedler–Lindenstrauss's Thm 1.3; Parts's tiling).",
         src=None, quote=None),
    dict(status="reading", p=0.50, why="Believed, with a killing test. The local–global conjecture is drawn but counted in no route; the "
         "meeting of the two doors (FS107-MEET) is a reading on the route to seven, and counts.", src=None, quote=None),
    dict(status="gap-step", p=0.30, why="A missing step that a reduction has named. Anchor: FS-112 registered a NO of its whole question "
         "within one phase at 0.3.", src=PLAN112("E14"), quote="a NO of Q-full at one mind with every GAP named, within P1"),
    dict(status="gap-question", p=0.03, why="An open question not split into named steps (FS-114's global step, FS-104, FS-80, FS-44, PL, "
         "door B's negation, the four-colour form). "
         "Anchored on the one registered credence for a question of the answer's size: FS-112's 0.03 for a YES by formula. Lower than "
         "a named step because it hides steps nobody has counted.",
         src=PLAN112("E5"), quote="the stub's \"a YES by formula (0.03)\", re-registered at 0.03 with its population stated"),
]

NOTES = [
    dict(id="instrument", text="A credence is an instrument, registered so it can be scored at the close — never a reason to shrink an aim or to stop.",
         src=PRIORS, quote="A registered probability is an instrument for G21, scored at the close. It is never a reason to shrink an aim or to stop."),
    dict(id="belief", text="A belief about the answer is not evidence for it. The conjecture's bold form predicts seven; the page draws it and counts it in no route.",
         src=LGC, quote="Believing the answer is seven is not evidence for seven; the value-skipping that motivated the belief was compatible with five until [OAIMath2026]"),
    dict(id="rank", text="Routes are ranked by bearing on the answer, never by difficulty, length or formalization effort.",
         src=PRIORS, quote="Rank a route by its bearing on the answer, never by its difficulty, its length or its formalization effort."),
    dict(id="publish", text="Nothing is published before it is formalized in Lean, in full.",
         src={"file": "CLAUDE.md", "section": "### The local–global conjecture"},
         quote="Nothing is published before it is formalized in Lean, in full."),
]


def build():
    for n in NODES:
        n["status"] = fold(n["grade"])
        n["line"] = locate(n["src"], n["quote"])
        n["address"] = address_str(n["src"], n["line"])
        n["grade_address"] = address_str(n["grade_src"], locate(n["grade_src"], n["grade"]) if n["grade"] != "@lean" else None) \
            if n["grade"] != "@lean" else address_str(n.get("lean", n["src"]))
        if n.get("registered"):
            reg = n["registered"]; reg["address"] = address_str(reg["src"], locate(reg["src"], reg["quote"]))
        if n.get("words"):
            wsrc, wq = n["words"]; n["words"] = dict(src=wsrc, quote=wq, address=address_str(wsrc, locate(wsrc, wq)))
        n["also"] = [dict(src=s, quote=q, address=address_str(s, locate(s, q))) for s, q in n.get("also", [])]
        for q in n.get("posed", []):
            q["address"] = address_str(q["src"], locate(q["src"], q["quote"]))
    for e in EDGES:
        e["address"] = address_str(e["src"], locate(e["src"], e["quote"]))
    for c in CREDENCE:
        if c["src"]:
            c["address"] = address_str(c["src"], locate(c["src"], c["quote"]))
    for t in NOTES:
        t["address"] = address_str(t["src"], locate(t["src"], t["quote"]))
    facts = dict(meta=dict(title="Proof Atlas", built="2026-10-07", job="FS132-L2", as_of="FS-132's first theorem through the gate (row 155, the whole plane)",
                           statuses={k: v for k, v in __import__("viz_proof_atlas_common").STATUS_WORDS.items()}),
                 nodes=NODES, edges=EDGES, routes=ROUTES, credence=CREDENCE, notes=NOTES)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(facts, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"wrote {OUT.relative_to(ROOT)}: {len(NODES)} nodes, {len(EDGES)} edges, {len(ROUTES)} routes")
    lint()


def wrap(label, width=16):
    """The page's label wrap: at most two lines of about `width` characters, broken at spaces (mirrored in page.tmpl.html)."""
    words, lines, cur = label.split(" "), [], ""
    for w in words:
        if cur and len(cur) + 1 + len(w) > width and len(lines) < 1:
            lines.append(cur); cur = w
        else:
            cur = (cur + " " + w).strip()
    return lines + [cur]


def label_box(n, fs):
    """The label's box in map units, as the page draws it: above the node in the top sector (|θ| < 60°), below it elsewhere."""
    th = math.radians(n["theta"]); x, y = n["r"] * math.sin(th), -n["r"] * math.cos(th)
    rad = {0: 17, 1: 13, 2: 10}[n["tier"]] if n["role"] != "answer" else 30
    lines = wrap(n["label"]); w = max(len(l) for l in lines) * fs * 0.55; h = len(lines) * fs * 1.15
    above = math.cos(th) > 0.5 and n["role"] != "answer"
    y0 = y - rad - 4 - h if above else y + rad + 4
    return (x - w / 2, y0, x + w / 2, y0 + h), (x, y, rad)


def lint():
    """Label and node overlaps at the two zoom levels the page draws: at rest (tiers 0–1 labelled, 16-unit type) and zoomed in
    (every label, 11.7-unit type). A layout aid, not a check."""
    bad = 0
    for tiers, fs, name in (((0, 1), 16, "at rest"), ((0, 1, 2), 11.7, "zoomed")):
        shown = [n for n in NODES if n["tier"] in tiers and n["role"] != "answer"]
        boxes = [(n["id"],) + label_box(n, fs) for n in shown]
        allnodes = [(n["id"],) + label_box(n, fs)[1] for n in NODES]
        for i in range(len(boxes)):
            a = boxes[i][1]
            for j in range(i + 1, len(boxes)):
                b = boxes[j][1]
                if a[0] < b[2] and b[0] < a[2] and a[1] < b[3] and b[1] < a[3]:
                    bad += 1; print(f"  [{name}] label overlap: {boxes[i][0]} / {boxes[j][0]}")
            for (nid, x, y, rad) in allnodes:
                if nid != boxes[i][0] and a[0] < x + rad and x - rad < a[2] and a[1] < y + rad and y - rad < a[3]:
                    bad += 1; print(f"  [{name}] label {boxes[i][0]} covers node {nid}")
    for i in range(len(NODES)):
        for j in range(i + 1, len(NODES)):
            (_, (x1, y1, r1)), (_, (x2, y2, r2)) = label_box(NODES[i], 12), label_box(NODES[j], 12)
            if math.hypot(x1 - x2, y1 - y2) < r1 + r2 + 8:
                bad += 1; print(f"  node overlap: {NODES[i]['id']} / {NODES[j]['id']}")
    print(f"layout lint: {bad} overlaps")


if __name__ == "__main__":
    build()
