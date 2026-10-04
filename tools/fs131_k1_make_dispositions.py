#!/usr/bin/env python3
"""FS131-K1: write data/fs131/k1/dispositions.csv from the decisions below.

Every disposition that is not the default (*formalize*, in the row's merged or errata-governed form) is a line of
OVERRIDES with its reason and the address of that reason. Waves are a home wave per row (WAVE_OF, by family and
topic), raised where an upstream row sits later, and every raise is printed so that it is a decision, not an accident.
The checker is tools/fs131_k1_dispositions.py; this script only writes.

  python3 tools/fs131_k1_make_dispositions.py          # write the CSV, print raises and counts
"""
import csv
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
ROWS = ROOT / "data" / "fs131" / "k1" / "rows.json"
OUT = ROOT / "data" / "fs131" / "k1" / "dispositions.csv"

SR1 = "plans/FS129-SR1-audit.md"
SR2 = "plans/FS129-SR2-audit.md"
SR3 = "plans/FS129-SR3-audit.md"
SA1 = "plans/FS129-SA1-audit.md"
PLAN = "plans/FS131-kernel-plan.md"

# ---------------------------------------------------------------------------------------------------------------
# Waves (the plan's § 7): 1 the plane, sets with null unit pairs, finite graphs; 2 measurable colourings, covers,
# slack suprema, place homomorphisms; 3 arc maps and fragments, Siamese allowed; 4 valid maps: contact and unit-arc
# calculus, S–V maps; 5 termination, the base, density; 6 saturated colourings; 7 four-colour vertices and route T;
# 8 the ring calculus, non-Siamese; 9 the reductions and the class statements; 10 arithmetic II.
# ---------------------------------------------------------------------------------------------------------------
W = {}
def put(wave, module, *ids):
    for i in ids:
        assert i not in W, i
        W[i] = (wave, module)

P = "Proofs/HadwigerNelson/Plane/"
A = "Proofs/HadwigerNelson/Arith/"
# wave 1
put(1, P + "Diameter", "FS106-DIAM", "FS106-TS-C")
put(1, P + "Closure", "FS129-SR2-CLOSURE")
put(1, P + "DensityPoints", "FS111-V0-ID1", "FS129-SR2-HULLSET", "FS111-M-HULL2", "FS111-M2-INT")
put(1, P + "UnitAvoiding", "FS111-M2-ZERO")
put(1, P + "Chord", "FS116-V4-CHORD", "FS129-SR1-TWOCIRC", "FS121-D1-XCORNER")
put(1, A + "NoAffine", "FS129-SA1-NOAFF-K")
put(1, A + "FalconerFan", "FS129-SA1-FALC-FAN", "FS129-SA1-FALC-DICHO-K")
# wave 2
put(2, P + "MaximalCover", "FS111-C-FILL", "FS111-M-SATC", "FS111-M2-COV", "FS111-M2-FIX", "FS111-M-COVER-SC",
    "FS121-D3-GRUNDY")
put(2, P + "Slack", "FS111-V0-RESCALE", "FS129-SR2-SUPK", "FS106-EQ", "FS106-COMP", "FS106-REM", "FS121-D4-FACE",
    "FS121-V5-FACE-SHARP")
put(2, P + "CoverExamples", "FS111-M-R7", "FS111-W-SQ9", "FS111-M2-DISC7", "FS111-M3-BAND", "FS111-M3-FIXCONV",
    "FS111-M3-HC", "FS111-M3-IRREG")
put(2, P + "Stationary", "FS129-OA1-NOPERLAW")
put(2, P + "FalconerReduction", "FS129-SA1-FALC-RED")
put(2, A + "PlaceHom", "FS129-SA1-PLACE-HOM", "FS129-SA1-NOAFF-FIELDS")
put(2, A + "FalconerField", "FS129-SA1-FALC-RES", "FS129-MA2-FALC-HOSTS")
put(2, A + "Dyadic", "FS129-SA1-SQRT3-LOCAL")
# FS116-O1-YESLIM moved from wave 3 to wave 2 (plans/FS131-close-inventory.md ruling 6; FS131-K2): it rests only on wave-2 rows
# (FS106-EQ; FS106-COMP through its merged FS129-SR2-YESLIM-EQ) and on N-EASY, and nothing rests on it.
put(2, P + "YesLimit", "FS116-O1-YESLIM")
# wave 3
put(3, P + "Tiles", "FS116-V5-NE1", "FS116-V4-DICHOTOMY", "FS116-V4-MEET", "FS116-V4-TWIST", "FS116-S1-CLUSTER",
    "FS129-OR1-WHOLE")
put(3, P + "Lens", "FS116-S1-EXIT")
put(3, P + "RingBand", "FS129-SR1-RINGBAND")
put(3, P + "RingGerm", "FS116-N1-TWIST-D", "FS116-N1-GERM-R", "FS116-N1-ECHO", "FS116-N1-GERM-S", "FS116-N1-QFREE4",
    "FS129-SR2-TOUCHW", "FS116-RING-Q-PRIME-S", "FS116-N2-FIVERING", "FS129-SR1-SIXQ", "FS116-V5-U1",
    "FS116-Y4-FLANK")
put(3, P + "SixFragment", "FS116-Y2-SIXFRAG")
# wave 4
put(4, P + "ValidMap/Contact", "FS110-N3-CONF", "FS110-N3-DEG", "FS110-W-MERGE", "FS110-N4-SHADOW",
    "FS110-N4-SHAVE", "FS110-N4-STUCK")
put(4, P + "ValidMap/UnitArc", "FS112-U1", "FS112-LOCK", "FS112-ISO", "FS112-FLANK", "FS112-N2-FLANK-Q",
    "FS112-N2-RAY", "FS112-A4SIX", "FS112-NB4P", "FS112-N2-BENDS", "FS114-L60-LE")
put(4, P + "ValidMap/BaseSteps", "FS112-N3-ANTI", "FS112-N3-FAIL", "FS112-N3-NOBOTH", "FS112-N3-PAIRS",
    "FS112-N3-END", "FS112-C-DOUBLE", "FS112-BOWTIE")
put(4, P + "StuckChain", "FS110-N4-FIN")
put(4, P + "SVMap", "FS106-L", "FS106-TS-T", "FS106-WO", "FS106-TW", "FS106-AE-MAP6")
# wave 5
put(5, P + "ValidMap/Terminal", "FS112-N2-TERM", "FS112-C-ENDS", "FS114-CV-HD")
put(5, P + "ValidMap/Dense", "FS112-N3-COR3", "FS112-ROTHEX", "FS112-N3-BASE", "FS112-N3-DENSE3", "FS114-BV-HEX",
    "FS114-CVB-THOM", "FS114-CV-EXISTS", "FS129-SR2-DISC1TS", "FS129-OR1-LOCALDENSE")
# wave 6
put(6, P + "Saturated/Pinch", "FS111-M-HALF", "FS111-M-PINCH", "FS111-M-C11", "FS111-W-KB-DIR", "FS111-W-NOBEND",
    "FS111-M2-INTRAD", "FS121-D3-FALLSAT", "FS121-V2-EROSION-DIAM", "FS111-M2-HULLC")
put(6, P + "Saturated/Ladder", "FS121-D2-EXT", "FS121-D2-THIN", "FS121-DB1-L3", "FS121-O1-ENDS", "FS121-O1-OUT",
    "FS121-V2-SECTOR", "FS121-V2-VT-W", "FS121-D1-EROSION", "FS121-V5-LOC", "FS121-V5-RAY", "FS121-D2-SYM",
    "FS121-DB1-L6", "FS121-DB1-L7", "FS121-V3-CPI", "FS121-D1-PENCILWIN", "FS121-D2-PERFIN", "FS121-D4-HOLE")
put(6, P + "Saturated/MapColouring", "FS121-C1-BOUND", "FS121-C1-SAT", "FS121-C1-GMAP")
put(6, P + "Saturated/Fragment", "FS116-O1-SATPIN", "FS116-N1-AXIS", "FS116-S1-RUNG", "FS116-V4-PARTNER",
    "FS116-S1-KAPPA", "FS116-S1-PAIR")
# wave 7
put(7, P + "FourColour/Bowtie", "FS114-N3-LOCAL", "FS114-N4-LEMMAS", "FS114-N5-GRING", "FS114-Y2-BOWTIE",
    "FS114-Y3-RSTOP", "FS114-Y4-LUNE", "FS114-Y4-RSTOPALL", "FS114-Y6-HALF")
put(7, P + "FourColour/Pinwheel", "FS114-N6-NOQ", "FS114-N7-QOPP", "FS114-Y5-PINALL", "FS114-Y6-E2RED",
    "FS129-SR3-E2ONE")
put(7, P + "RouteT", "FS114-N114-RD", "FS114-N114-EULER", "FS114-N2-FIVE", "FS114-N114-ROOM", "FS114-N2-ENDS",
    "FS114-N3-JOINT", "FS114-Y-EDGE")
# wave 8
put(8, P + "RingCalculus/Star", "FS116-RING-GERM", "FS116-N2-STAR", "FS116-N2-ANTI", "FS116-N2-RECIP",
    "FS116-N2-SIXRING", "FS116-RING-TWIST-C")
put(8, P + "RingCalculus/SemiHub", "FS116-N3-PAIR", "FS116-N3-STAR2", "FS116-N3-CONE", "FS116-N3-CROSS",
    "FS116-N3-SEMI", "FS116-RING-TRANSFER-QC", "FS116-V5-QCOL", "FS116-V5-OUT2", "FS116-V5-DICHO")
put(8, P + "RingCalculus/Empty", "FS116-V6-HUBS", "FS116-V6-ANTI", "FS116-V6-HUG", "FS116-V6-COUNT",
    "FS129-SR3-EMPTY-NS", "FS129-MR1-DOUBLETIP", "FS129-SR3-OUTERADJ")
# wave 9
put(9, P + "Reduction", "FS111-C-SIX-M", "FS111-M2-REDUCE-C", "FS129-OR1-TOP5", "FS111-V0-CLEAN",
    "FS111-C1-UNIF", "FS111-C1-PW")
put(9, P + "Classes", "FS129-SR1-BENDANY", "FS129-SR1-BENDLE3", "FS129-OR1-QFREE-CLASS", "FS129-SR3-QFREE-NS",
    "FS129-OR1-DISCF-NS")
# wave 10
put(10, A + "StandingFive", "TC1-STANDING-FIVE")
put(10, A + "CharacterColouring", "FS89-S0A-2", "FS89-S0A-10", "FS89-CL2")
put(10, A + "StationaryRatio", "X25B-L1", "X25B-PZ")
put(10, A + "SpectralInputs", "J45-N1", "J45-N2", "J45-SI-4", "J45-SI-5", "J45-SI-C", "J45-SI-J", "J45-SP-if",
    "J45-SP-oi")

# ---------------------------------------------------------------------------------------------------------------
# Non-default dispositions: id -> (disposition, merged_into or replacement, reason, address, ruling?)
# disposition in {merged, excluded, outside}; for merged the second field is the target (';' for two), for excluded
# it is the corrected form (a row) or ''.
# ---------------------------------------------------------------------------------------------------------------
O = {}
def merged(i, tgt, reason, addr, ruling=False):
    O[i] = ("merged into", tgt, reason, addr, ruling)
def excluded(i, repl, reason, addr, ruling=False):
    O[i] = ("excluded", repl, reason, addr, ruling)

merged("FS111-V0-CLOSE", "FS129-SR2-CLOSURE", "SR2 item 9: CLOSURE in place of V0-CLOSE (CLOSURE applied to the union of the colour-j regions)", SR2 + ":467")
merged("FS111-C-HULL", "FS129-SR2-HULLSET", "SR2 item 10", SR2 + ":470")
merged("FS106-SUP", "FS129-SR2-SUPK", "SR2 item 11", SR2 + ":472")
merged("FS112-DISC1", "FS129-SR2-DISC1TS", "SR2 item 12 names TS-T in place of DISC1 through FS129-SR2-DISC1TS; DISC1TS is DISC1's statement as TS-T's corollary, so DISC1 merges into DISC1TS (its consumers LOCALDENSE, N3-DENSE3 cite it)", SR2 + ":474")
merged("FS112-BEND", "FS112-N2-BENDS", "SR2 item 13", SR2 + ":475")
merged("FS112-N2-RED", "FS112-N2-TERM", "SR2 item 13 (RED's procedure as TERM's lemma)", SR2 + ":475")
merged("FS114-N4-D", "FS114-Y4-RSTOPALL", "SR2 item 16 (N4-D a second route)", SR2 + ":478")
merged("FS114-N3-DR", "FS114-Y4-RSTOPALL", "SR2 item 16", SR2 + ":478")
merged("FS116-N1-TOUCH", "FS129-SR2-TOUCHW", "SR2 item 20 (idle hypothesis dropped)", SR2 + ":484")
merged("FS116-RING-Q-PRIME", "FS116-RING-Q-PRIME-S", "SR2 item 21", SR2 + ":485")
merged("FS111-W-NOREP", "FS121-DB1-L3", "SR2 item 22", SR2 + ":487")
merged("FS112-SIX", "FS116-N2-FIVERING;FS129-SR1-SIXQ", "SR1 item 3: FIVERING (five colours) and SIXQ (six) in place of FS112-SIX", SR1 + ":540")
merged("FS121-D1-VT", "FS121-V2-VT-W", "SR1 item 7, conditional on VT-W's corner case being consumed: wave 6's planner confirms it; if not, D1-VT returns to formalize", SR1 + ":548")
merged("FS110-N2-RING", "FS129-SR1-RINGBAND", "SR1 item 8", SR1 + ":550")
merged("FS110-Y3-GP", "FS129-SR1-RINGBAND", "SR1 item 8", SR1 + ":550")
merged("FS116-V6-ADJ", "FS129-SR3-OUTERADJ", "SR3 item 26 (OUTERADJ in place of V6-ADJ; V6-ADJ's argument its last step, class-free); SR1's DNF list also names V6-ADJ", SR3)
merged("FS116-Y4-EMPTY", "FS129-SR3-EMPTY-NS", "SR3 item 24", SR3)
merged("FS116-Y4-OBST", "FS129-SR3-EMPTY-NS", "SR3 item 24: OBST follows from EMPTY-NS (the HEX3 class lies in the Gamma-free non-Siamese class)", SR3)
merged("FS116-S1-QF", "FS129-SR3-QFREE-NS", "SR3 item 23", SR3)
merged("FS129-SR2-QFCASE", "FS129-SR3-QFREE-NS", "SR3 item 23: S1-QF (QFCASE's statement) is QFREE-NS's direct case, so QFCASE is a one-line corollary carried inside QFREE-NS's module", SR3, True)
merged("FS84-S1-S1e", "FS129-SA1-NOAFF-K", "SA1 item 1", SA1)
merged("TC1-SQRT3-DYADIC", "FS129-SA1-SQRT3-LOCAL", "SA1 item 7 (the general local form; a conditional seed, caution C13)", SA1)
merged("FS129-SR2-YESLIM-EQ", "FS116-O1-YESLIM", "SR2 item 18: YESLIM is formalized by YESLIM-EQ's route (FS106-EQ's (c) => (a), then Lemma P), so YESLIM-EQ is the proof of YESLIM's first clause, not a second declaration", SR2 + ":481", True)
merged("FS116-RING-TRANSFER-C", "FS116-N2-FIVERING;FS116-N2-SIXRING", "SR1's DNF list excludes its four-colour clause (empty); what remains, five- and six-colour rings, is FIVERING's and SIXRING's content", SR1 + ":552", True)
merged("FS114-L60-WALK", "FS114-L60-LE", "a statement about proofs (no step of RED, COR3, BASE, DENSE3, CV-EXISTS needs the strict bound): its content is checked by the kernel when those rows are formalized over L60-LE's non-strict bound, which this plan requires (§ 4.3)", PLAN, True)
excluded("FS112-L60", "FS114-L60-LE", "false at exactly 60 degrees (its erratum); SR2 item 14 and SR2's DNF list", SR2 + ":476")
excluded("FS112-BUDGET2", "", "SR2's DNF list: FALSE as stated; in the order only through false edges", SR2)
excluded("FS111-C-HULL-SO", "", "SR2's DNF list: refuted; in the order only through false edges", SR2)
for i in ["FS116-Y3-NOQ", "FS116-Y3-TIGHT", "FS116-Y3-HUBCOL", "FS116-Y3-LENS", "FS116-Y3-NBTIP", "FS116-Y3-TIGHTLENS",
          "FS116-Y3-STARFORCE", "FS116-Y4-SYM", "FS116-Y4-SPOKE", "FS116-Y4-Q1", "FS116-V1-FRAME", "FS116-N2-HEX6",
          "FS116-N2-HEX3"]:
    excluded(i, "", "SR1's DNF list: the class is empty (Gamma-free ring, non-Siamese simple; empty by FS129-SR3-EMPTY-NS)", SR1 + ":552")
excluded("FS114-N7-HUB", "", "SR1's DNF list: empty given FS129-OR1-QFREE (now FS129-SR3-QFREE-NS)", SR1 + ":552")
excluded("FS114-N7-3T", "", "SR1's DNF list: with N7-HUB", SR1 + ":552")
excluded("ASTRA-2026-09-14-T10", "", "SA1 item 8: hypothesis empty over every F containing K with a usable prime of residue field F_11 or chi <= 4; its sentence is weaker than the Separated it means and false as read; FS-49 is not formalized here", SA1)
excluded("FS114-K1", "", "not a held result: its entry's verdict is 'gap' (plans/FS114-derivation.md:810, FS114-K1: the cases no entry excludes); it is FS-114's open local question, with no grade and no handoff, and its 'explicit radius' is unspecified", "plans/FS114-derivation.md:810", True)
excluded("FS116-S1-LENS", "", "its class (non-Siamese valid six-coloured fragment, four-colour vertex, (Q)-free ring) is empty by FS129-SR3-QFREE-NS; it serves only S1-QF's second route (SR3 item 23), so formalizing it would add a declaration over an empty domain with no consumer", SR3, True)
excluded("FS116-V4-OUTER", "", "as FS116-S1-LENS: empty class by FS129-SR3-QFREE-NS; its one consumer, S1-KAPPA's last clause, is excluded by SR3's DNF-2", SR3, True)
for i in ["FS116-Y3-SIX", "FS116-Y3-TIPS", "FS116-V5-RING", "FS116-V5-OUT", "FS116-V5-GERM", "FS116-V5-TIPSET", "FS116-V5-LENS"]:
    excluded(i, "", "its class (non-Siamese six-coloured fragment whose ring carries no arc of Gamma, at a vertex of at least four colours) is empty by FS129-SR3-EMPTY-NS; it lies on Y4-EMPTY's first route only (its consumers are Y4-EMPTY, the DNF rows and each other), while SR3 item 24 proves EMPTY-NS on FS116-V6's route; V5-RING's first two clauses are carried by FS116-N1-TWIST-D (SR2 item 21)", SR3, True)

# Partial forms and statement notes on formalize rows (reason column only; disposition stays formalize).
NOTE = {
    "FS106-DIAM": ("clauses (i) and (ii); clause (iii) is FS129-SR2-CLOSURE's corollary (SR2 item 9)", SR2 + ":467", False),
    "FS116-V5-NE1": ("first clause as FS129-SR2-CLOSURE's corollary (SR2 item 9)", SR2 + ":467", False),
    "FS116-V4-DICHOTOMY": ("first clause as FS111-M-HULL2's case for two open tiles (SR2 item 10)", SR2 + ":470", False),
    "FS106-COMP": ("second clause only (the equivalence with [Voronov2023] Thm 1.1 named as a Prop); its first clause is FS106-EQ's (c) => (a) (SR2 item 11)", SR2 + ":472", False),
    "FS111-M2-HULLC": ("without its semiconcave clause, which FS111-M-COVER-SC carries (SR2 item 17)", SR2 + ":479", False),
    "FS114-N3-JOINT": ("with its errata (caution C116); its first clause is FS114-N2-ENDS's (SR2 item 15)", SR2 + ":477", False),
    "FS112-U1": ("its shadow clause, as a corollary of FS116-V5-U1, whose first three clauses replace U1's (SR1 item 4)", SR1 + ":541", False),
    "FS129-MA2-FALC-HOSTS": ("clauses (ii)-(iv); clause (i) is FS129-SA1-FALC-RES's (SA1 item 5)", SA1, False),
    "FS121-D4-FACE": ("with FS121-V5-FACE-SHARP's hypothesis rho^2 >= 2g - g^2 in place of 2g < rho^2 (SR1 item 6)", SR1 + ":546", False),
    "FS114-Y5-PINALL": ("with the exception 'E1, or E2 at two or more blades' (SR3 item 27); PINALL as filed is a lemma of FS129-SR3-E2ONE inside the same module", SR3, False),
    "FS114-Y6-E2RED": ("its chain clause only; the survivor clause read as 'no survivor at a single blade' (SR3 item 27, DNF-1)", SR3, False),
    "FS116-S1-KAPPA": ("without its last clause (SR3 DNF-2); drops FS116-V4-OUTER with it", SR3, False),
    "FS89-S0A-2": ("with A(R_F) = Hom_Q(F(i), R) mod 1 in place of the Notation's A (caution C109, SA1 item 9): false as written", SA1, False),
    "FS89-S0A-10": ("with the corrected A, as FS89-S0A-2", SA1, False),
    "FS89-CL2": ("with the corrected A, as FS89-S0A-2", SA1, False),
    "FS112-C-ENDS": ("in its erratum's form (residue deleted), caution C116", SR2, False),
    "FS112-C-DOUBLE": ("with its errata, caution C116", SR2, False),
    "FS112-N3-BASE": ("with its errata, caution C116; row 134's base enters as the named hypothesis Row134Base (outside the backlog, plan § 3.3)", SR2, False),
    "FS114-N2-ENDS": ("with its errata, caution C116", SR2, False),
    "FS116-V6-HUG": ("with its own colour step (V6-GERM), not DOUBLETIP's (cautions C126, C131); stated in the non-Siamese class without 'simple', as SR3 item 24's route for EMPTY-NS needs", SR3, True),
    "FS116-V6-HUBS": ("stated in the non-Siamese class without 'simple' (SR3 item 24's route for EMPTY-NS); a step of EMPTY-NS's proof, VACUITY DECLARED (its class is empty by EMPTY-NS)", SR3, True),
    "FS116-V6-ANTI": ("as FS116-V6-HUBS", SR3, True),
    "FS116-V6-COUNT": ("as FS116-V6-HUBS, with its last step in its sector form (SR3 § 2.1: the two tippers of y_k and of y_(k+3)), the step SR3 found needs no simplicity (ruling R4's condition, inventory item 5-9)", SR3, True),
    "FS116-V5-OUT2": ("in V5-QCOL's setting only (V5-RING's is excluded)", PLAN, False),
    "FS106-WO": ("its mathematical content only: Woodall's Thm 6 as repaired by Townsend's 1/3-pi lemma, and the step-4 lemma for arcs longer than 2pi/3; 'step 6 is a GAP' is a verdict on a printed text, not a statement the kernel checks", PLAN, True),
    "FS106-TW": ("its mathematical content only: Townsend's pi/3 lemma (TRUE); the bibliographic clauses are not statements", PLAN, True),
    "FS114-CVB-THOM": ("as the list of [Thomassen1999]'s steps other than the rainbow step, each stated for valid maps with Siamese pairs allowed (wave 5's planner reads CVB's record)", PLAN, True),
    "FS112-N2-RAY": ("its mathematical content: the one-sided chain lambda_k = -1/(k+1), upsilon_k = 0 satisfies N4-FIN's one-sided inequalities, and N4-CONE's step fails there; 'is a GAP' is a verdict", PLAN, True),
    "TC1-STANDING-FIVE": ("conditional seed (C13): its unconditional clauses (the field, its places above 2, no usable residue field of size <= 47, so L(F) >= 7) in wave 10; 'given MR, chi(F^2) >= 5' as an implication from row 123's chain, taken as the named hypothesis Row123Chain from outside the backlog (FS-101's slot; ruling R10's condition)", PLAN, True),
    "FS129-OR1-TOP5": ("FS111-M-REDUCE-I, which it uses, is not a backlog row: formalized beside it in wave 9 as a supporting lemma (finding sent to Keryx)", PLAN, True),
    "FS129-SR3-EMPTY-NS": ("proved on FS116-V6's route (SR3 item 24); carries FS116-Y4-EMPTY and FS116-Y4-OBST", SR3, False),
    "FS129-SR3-QFREE-NS": ("carries FS116-S1-QF and FS129-SR2-QFCASE (SR3 item 23)", SR3, False),
    "FS116-O1-YESLIM": ("its first clause by FS129-SR2-YESLIM-EQ's route (SR2 item 18); its k = 6 clause needs chi(R^2) <= chi_m0(R^2) (row 130's free half, FS-103's N-EASY), formalized in wave 2 as a supporting lemma; moved from wave 3 to wave 2 by ruling 6", SR2 + ":481", False),
}

# Upstream edges the backlog does not record (rows outside § The order carry no 'needs'), and edge notes.
EXTRA_UP = {
    "FS111-M-HULL2": ["FS129-SR2-HULLSET"],
    "FS106-EQ": ["FS129-SR2-SUPK"],
    "FS106-COMP": ["FS106-EQ"],
    "FS114-N3-JOINT": ["FS114-N2-ENDS"],
    "FS114-Y5-PINALL": ["FS129-SR3-E2ONE"],
    "FS111-M-COVER-SC": ["FS111-M-SATC"],
    "FS111-V0-CLEAN": ["FS106-DIAM"],
    "FS129-SR3-EMPTY-NS": ["FS116-V6-HUBS", "FS116-V6-HUG", "FS116-V6-ANTI", "FS116-V6-COUNT", "FS116-RING-GERM", "FS116-Y4-FLANK"],
    "FS116-O1-YESLIM": ["FS106-EQ"],
    "FS129-SR3-QFREE-NS": ["FS129-SR3-EMPTY-NS"],
    "FS121-D4-FACE": ["FS121-V5-FACE-SHARP"],
}
OUTSIDE_BACKLOG = {"FS129-OR1-TOP5": "FS111-M-REDUCE-I"}


def main():
    d = json.loads(ROWS.read_text())
    rows, order = d["rows"], d["order"]
    disp, tgt, wave, module, reason, addr, ruling = {}, {}, {}, {}, {}, {}, {}
    for i in order:
        if i in O:
            dd, t, rs, ad, ru = O[i]
            disp[i], tgt[i], reason[i], addr[i], ruling[i] = dd, t, rs, ad, ru
        else:
            disp[i], tgt[i] = "formalize", ""
            n = NOTE.get(i)
            reason[i], addr[i], ruling[i] = (n[0], n[1], n[2]) if n else ("", "", False)
            if i not in W:
                raise SystemExit(f"formalize row {i} has no wave")
            wave[i], module[i] = W[i]
    for i in order:
        if disp[i] == "formalize":
            continue
        if i in W:
            raise SystemExit(f"{i} is {disp[i]} but has a wave entry")
    # merged rows take their (first) target's wave/module
    for i in order:
        if disp[i] == "merged into":
            t0 = tgt[i].split(";")[0]
            wave[i], module[i] = W[t0]
        elif disp[i] == "excluded":
            wave[i], module[i] = "", ""
    # propagate: a formalize row sits at or after each resolved upstream
    def resolve(u):
        if u not in disp:
            return []
        if disp[u] == "formalize":
            return [u]
        if disp[u] == "merged into":
            return [t for t in tgt[u].split(";") if t != u]
        if disp[u] == "excluded":
            return [tgt[u]] if tgt[u] else []
        return []
    changed = True
    raises = []
    while changed:
        changed = False
        for i in order:
            if disp[i] != "formalize":
                continue
            ups = rows[i]["upstream"] + EXTRA_UP.get(i, [])
            for u in ups:
                for r in resolve(u):
                    if r == i or disp.get(r) != "formalize":
                        continue
                    if wave[r] > wave[i]:
                        raises.append((i, wave[i], wave[r], u))
                        wave[i] = wave[r]
                        changed = True
    for i in order:
        if disp[i] == "merged into":
            t0 = tgt[i].split(";")[0]
            wave[i] = wave[t0]
    with OUT.open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["id", "section", "disposition", "merged_into", "replacement", "wave", "module", "extra_upstream",
                    "outside_backlog", "ruling", "reason", "address"])
        for i in order:
            w.writerow([i, rows[i]["section"], disp[i], tgt[i] if disp[i] == "merged into" else "",
                        tgt[i] if disp[i] == "excluded" else "", wave[i], module[i],
                        ";".join(EXTRA_UP.get(i, [])), OUTSIDE_BACKLOG.get(i, ""), "Y" if ruling[i] else "",
                        reason[i], addr[i]])
    from collections import Counter
    print("raises:", raises)
    print(Counter(disp.values()))
    print(sorted(Counter(wave[i] for i in order if disp[i] == "formalize").items()))
    print("rulings:", [i for i in order if ruling[i]])


if __name__ == "__main__":
    main()
