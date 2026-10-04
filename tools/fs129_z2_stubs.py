#!/usr/bin/env python3
"""FS129-Z2 — FS-129's lines in open stubs, and the stub it mints (FS-129 inventory items 28, 42, 58, 60, 80, 82, 87, 101, 117, 120, 129, 133).

Every edit is an insertion; no line of an open stub is changed or removed. In an open stub only three places are written (the brief's
`touches:`): the end of its "Bearing on the answer" section, its provisional-bearings line (a sentence appended after it), and a closing
section "## Dated correction notes (FS129-Z2, 2026-10-03)" whose notes name the line they correct and leave it standing. Poros's question
sections and every banner are untouched. Each FS-129 statement quoted is read here from the reader's record where it was derived
(`stmt()`), so the quotation is verbatim by construction.

    python3 tools/fs129_z2_stubs.py --apply   # insert (once; refuses if any insertion is already present)
    python3 tools/fs129_z2_stubs.py --check   # each insertion present exactly once; `git diff` deletes no line of these stubs (exit 1 on a problem)
    python3 tools/fs129_z2_stubs.py --check --fault   # plant a fault in memory (one insertion's text altered); the check must fail — it fires
"""
from __future__ import annotations

import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
JOBS = ["OA1", "OR1", "MA1", "MA2", "MR1", "SA1", "SR1", "SR2", "SR3"]
TAG = "FS129-Z2, 2026-10-03"


def stmt(name: str) -> str:
    for j in JOBS:
        L = (ROOT / "plans" / f"FS129-{j}-audit.md").read_text(encoding="utf-8").splitlines()
        for k, ln in enumerate(L):
            if ln == f"derivation: {name}":
                out, on = [], False
                for x in L[k + 1:]:
                    if not x.strip():
                        break
                    if x.startswith("  statement:"):
                        on = True
                        out.append(x.split("statement:", 1)[1].strip())
                    elif on and re.match(r"^\s{4,}\S", x):
                        out.append(x.strip())
                    elif on:
                        break
                return " ".join(out)
    raise SystemExit(f"no entry {name}")


def q(name: str) -> str:
    return f"**{name}**: \"{stmt(name)}\""


def edits() -> list[tuple[str, str, str]]:
    """(stub file, place, text); place is 'bearing:<heading>', 'prov-section:<heading>', 'prov-para:<prefix>' or 'notes'."""
    E: list[tuple[str, str, str]] = []
    A = f"*At FS-129's audit ({TAG}; from the readers' records, each FS-129 result derived, one mind, kernel pending, prior art owed unless named).*"
    # ---------------------------------------------------------------- FS-123
    E.append(("plans/STUB-qfree-ring.md", "bearing:## Bearing on the answer", f"""{A} **Question 1 is answered yes, with the restriction
repaired.** Bending keeps a fragment in FS116-Y4-EMPTY's class when the bends run on a whole-tile restriction of radius at most `√3` (FS129-OR1-WHOLE;
FS129-OR1-BENDFRAG, widened to any `k` and any centre as FS129-SR1-BENDANY) — not on the round neighbourhood side 1 names, which can cut a tile into a
Siamese pair (`plans/FS129-OR1-audit.md` § J1; `plans/FS129-SR1-audit.md` § 2.3). With FS129-OR1-QFREE-CLASS (in each class, the Γ-free exclusion gives
the (Q)-free one) this is {q("FS129-OR1-QFREE")}; and on FS116-V6's route the chain never uses simplicity (`plans/FS129-SR3-audit.md` § 2), so
{q("FS129-SR3-QFREE-NS")}, with FS129-SR3-EMPTY-NS (EMPTY without "simple"). So in the non-Siamese class, simple or not, no vertex of at least four colours
whose ring carries no (Q) arc survives past `1 + ε`: question 2 is moot; the classes of FS114-N7-3T, FS114-N7-HUB and FS114-N6-RING60, and OC, are empty
there; the first construction target below does not exist there. **What is left of this stub is question 3's Siamese half, now its main question.**
FS129-OR1-QFREE-CLASS reduces it to EMPTY's Siamese form (a Γ-free Siamese exclusion gives the (Q)-free one at no cost); the V5-RING family holds without
simplicity (`plans/FS129-SR1-audit.md` § Stage 3, group 3; inventory item 101) — a lead, not derived; G83's straddle in the Siamese class is a near miss
("the last step survives; 'one tile per colour at a change point' fails", `plans/FS129-MR1-audit.md` § Table of misses). For FS-124 the bends give less
than R2's card hoped: below `√3` about `p` a step may assume that `p`'s ring carries only its (Q) arcs and finitely many points (FS129-OR1-BENDFRAG), and
no further — a step reading radius above 2, or a ring point's own ring, may not (`plans/FS129-OR1-audit.md` § J1). For FS-117: K1 on (Q)-free rings has no
instance in the non-Siamese class, so route T's K1′ is owed only on (Q) rings (§ J24).
"""))
    E.append(("plans/STUB-qfree-ring.md", "prov-section:## Provisional bearings", f"""*At FS-129's audit ({TAG}):* FS129-OR1-WHOLE, -BENDFRAG,
-QFREE-CLASS, -QFREE, FS129-SR1-BENDANY, FS129-SR3-EMPTY-NS, -QFREE-NS (`plans/FS129-derivation.md`); for question 3, FS129-SR1's group 3 (FS112-U1 =
FS116-V5-U1 in its first three clauses) and the V5-RING family without simplicity; G83's straddle (a near miss in the Siamese class).
"""))
    E.append(("plans/STUB-qfree-ring.md", "notes", """- **§ The invention signal on the bends — settled; both sides stand.** The sides are about a map and a fragment and do not contradict: side 1's three
  remarks hold for the whole-tile restriction of radius at most `√3`, not the round neighbourhood they name, which can cut a tile into a Siamese pair
  (`plans/FS129-SR1-audit.md` § 2.3; `plans/FS129-OR1-audit.md` § J1; FS-129 inventory items 59, 96). A dated note says so under each remark
  (`plans/FS114-NB5-verification.md` § 1b.3, `plans/FS114-NB6-verification.md` § 1b.0, `plans/FS114-N7-proof.md` ll. 88–89).
- **§ Construction targets, first bullet** ("A valid fragment by formula about a vertex of at least four colours whose ring carries (R2) arcs and no (Q)
  arc, on a disc of radius above 1"): none exists in the non-Siamese class (FS129-SR3-QFREE-NS, one mind); the target survives only with Siamese pairs.
- **§ What FS-116 established, the FS114-N7-3T line**: its class is empty at `1 + ε` in the non-Siamese class (FS129-SR3-QFREE-NS), so its per-pattern
  kills and FS114-N7-HUB on rings with (R2) arcs are owed only where Siamese pairs are allowed.
- **§ Carried card, its hunches**: `bends-keep-the-class` (0.6) — they do, for the whole-tile restriction of radius at most `√3`;
  `qfree-class-is-empty` (0.65) — it is, in the non-Siamese class. Scored at the opening, not here.
"""))
    # ---------------------------------------------------------------- FS-124
    E.append(("plans/STUB-q-ring.md", "bearing:## Bearing on the answer", f"""{A}
- *Two pruning rules for ring types*, for case 5 (the recurrence) and at hubs and kind-T semi-hubs in case 1: {q("FS129-MR1-DOUBLETIP")} — the double-tip
  kill of FS116-V6-HUG and FS116-Y4-EMPTY carried to every ring whose outer germs lie off (Q) arcs (its `uses only:` without FS116-N2-STAR,
  `plans/FS129-SR1-audit.md` § 2.2) — and its outer twin {q("FS129-SR3-OUTERADJ")} (non-Siamese, no simplicity). Neither reaches SEMI-PAR3. Caution for
  the Lean list: DOUBLETIP cannot stand in for FS116-V6-HUG's colour step without losing FS129-SR3-EMPTY-NS, since DOUBLETIP's step 3 uses one cone per
  tile at the hubs (FS-129 items 126, 131). The four uses of the two-circle identity (FS116-V6-HUG, FS114-Y5-PXKILL, FS116-V6-ADJ, FS116-Y4-FLANK's
  least-curved case) are one lemma, FS129-SR1-TWOCIRC.
- *The bends* (FS129-OR1-BENDFRAG; FS129-SR1-BENDANY at any `k`): below `√3` about `p` a step may assume `p`'s ring carries only its (Q) arcs and finitely
  many points; a step reading radius above 2, or a ring point's own ring, may not (`plans/FS129-OR1-audit.md` § J1). At a vertex of exactly three colours
  the whole ring is freed (FS129-SR1-BENDLE3), so case 1's reading of `y`'s own ring can start from a ring with no arc of `Γ` — the object of FS110-N2-RING
  and FS110-Y3-GP, whose winding is the height lane A's question sought (their one lemma is FS129-SR1-RINGBAND), provided the bends at `y` are pinned at
  `p`'s germs `r(ψ ± 60°)` (`plans/FS129-OR1-audit.md` § J2, its caveat). Case 1 shortened, not closed.
- *SEMI-PAR3's winding, explored, not derived* (`plans/FS129-MR1-audit.md` § Stage 3, (d); `data/fs129/mr1/jump_explore.py`, an exploration, not a
  control): when each (Q) arc's own side tiles hold `ω(y)`'s germs at its end, "the jump is 0 in all 8 consistent assignments, and `ω(y)` is forced to carry
  `f`, `t_front`'s colour, at both `y + e(60°)` and `y + e(300°)`"; a jump of `±2` needs an `f`-coloured tile at `u` or `v`; then `t_front` can approach
  `y` only inside the tip cone `(150°, 210°)` — a reading at radius `√3 + ε` about `p`, resting on a germ assignment not derived.
- *Case 6*: {q("FS129-SR3-E2ONE")}. So FS114-Y5-PINALL's exception narrows to "E1, or E2 at two or more blades", FS114-Y5-PIN120's to E2 with E1 or a
  second E2, and FS114-K1's list drops S6 (FS-129 item 130). Every Reuleaux `(2, 1, 1, 0)` in FS114-Y6-HALF's class carries a (Q) arc, so the Reuleaux
  residue "on rings with (Q) arcs" is the whole HALF class, not killed past `√3` (`plans/FS129-SR3-audit.md` § 1.3). An open line unplaced between this
  case and FS-117: FS114-Y3-RSTOP's "Y3-D2 without reading R-T" (a Reuleaux bowtie with a non-tactic edge, which no held result reads); whether FS-112's
  bends remove it first is not read (`plans/FS129-SR3-audit.md` § 4.1).
- *Case 4*: FS112-SIX is subsumed — its five-colour clause by FS116-N2-FIVERING, its six-colour clause by FS129-SR1-SIXQ (`plans/FS129-SR1-audit.md`
  § Stage 3, group 2). FS112-SIX's covering-step GAP is answered in the non-Siamese class (FS116-V4-DICHOTOMY with FS116-N2-SIXRING) and open in the
  Siamese class, case 7 (`plans/FS129-SR3-audit.md` § 4.1).
- *Case 8*: {q("FS129-OR1-LOCALDENSE")} (possibly vacuous: no valid fragment on a disc of radius 3 is held) and {q("FS129-OR1-DISCF-NS")}. So DISC-F
  follows from C114-LOCAL-F in the non-Siamese simple class; in the Siamese or non-simple class it needs, besides, an exclusion about repeated-colour
  vertices or GS-4's density form (FS-115; `plans/FS129-OR1-audit.md` § J19). `plans/FS116-local-exclusion.md` § 3.6's "one question" holds in the
  non-Siamese simple class only (a dated note there).
- *Route R meets this case list*: in a valid map both common unit points of a cubic trichromatic complementary pair are vertices of at least four colours
  whose rings carry (Q) arcs (FS112-N3-COR3), so an exclusion here leaves no such pair in any valid map (`plans/FS129-OR1-audit.md` § J15).
"""))
    E.append(("plans/STUB-q-ring.md", "prov-section:## Provisional bearings", f"""*At FS-129's audit ({TAG}):* FS129-MR1-DOUBLETIP, FS129-SR3-OUTERADJ,
-E2ONE, FS129-SR1-TWOCIRC, -BENDANY, -BENDLE3, -RINGBAND, -SIXQ, FS129-OR1-BENDFRAG, -LOCALDENSE, -DISCF-NS; G71's height on a curve (FS110's winding)
for case 1.
"""))
    # ---------------------------------------------------------------- FS-125
    E.append(("plans/STUB-saturated-local.md", "bearing:## Bearing on the answer", f"""{A} Case 2 (SAT-QFREE's touch point) and case 1's G3
(crosses not at right angles) concern fragments whose ring carries no (Q) arc, so FS129-OR1-QFREE closes both in the non-Siamese simple class, saturated
or not, at any crossing angles (`plans/FS129-OR1-audit.md` § J3), and FS129-SR3-QFREE-NS without simplicity: **what is left of G3 and SAT-QFREE is their
Siamese part, with G2**; G1 (the strip-like class) and question 3 are untouched. **FS116-S1-QF is a case of QFREE** — {q("FS129-SR2-QFCASE")}, read as
citing FS129-SR3-QFREE-NS (`plans/FS129-SR3-audit.md` § 2.3) — so the saturated cross whose ring carries no (Q) arc is closed in S1-QF's whole class: a
second route to S1-QF, at one mind; question 0, S1-QF's own blind second mind, stays as Kooshi ruled it. FS116-S1-KAPPA's last clause is over a class
empty by QFREE-NS (`plans/FS129-SR3-audit.md` § 4.1). Two questions for the opening, from FS129-MR1 (`plans/FS129-MR1-audit.md` § Stage 4, G84 and G85;
neither derived): **which side's binding each kill reads** — FS116-S1-QF, -SAT-STRIP and -S1-RUNG assume each side colour bound at each edge point, while
FS121-D3-GRUNDY makes every colour but the largest bound for free, so a kill reading only the lower colour's binding would hold for Grundy fragments and,
by FS121-D3-EQ, bypass TOP₆; and **whether FS111-M2-INTRAD's one-step argument makes FS116-O1-SATPIN's tangent edges segments or arcs of integer
radius**, given saturation one unit beyond toward the centre (a reading radius of about `R ≥ 3`).
"""))
    E.append(("plans/STUB-saturated-local.md", "prov-section:## Provisional bearings", f"""*At FS-129's audit ({TAG}):* FS129-OR1-QFREE,
FS129-SR3-QFREE-NS, FS129-SR2-QFCASE, -TOUCHW (FS116-N1-TOUCH without its idle hypothesis); G84 with G89 (the binding question), G85 (INTRAD at a vertex).
"""))
    # ---------------------------------------------------------------- FS-104
    E.append(("plans/STUB-cp-plane-six.md", "bearing:## Bearing on χ ≥ 6", f"""{A} The arithmetic era bears on this stub's routes — the audit's
one cross-era hit (its decision 4; `plans/FS129-OA1-audit.md` §§ 2.2–2.3, `plans/FS129-MA1-audit.md` § 3, `plans/FS129-MA2-audit.md` § 2,
`plans/FS129-SA1-audit.md` § 2):
- *Route (c)*: G75's annihilator format is empty wherever a residue target is slack — {q("FS129-SA1-NOAFF-FIELDS")} (from FS129-SA1-NOAFF-K, row 66's
  single-vertex repaint at any target). Route (c)'s linear-identity format dies over those fields; the route, and the format over the other fields, stand.
- *Route (0)*: `[Falconer1981]` is held and read, its Lemmas 1–4 checked against the paper (`plans/FS129-MA1-audit.md` § 2.1); its mechanism, as a
  statement: {q("FS129-SA1-FALC-RED")}.
- *Route (b)*: its literal reading is empty (`plans/FS129-OA1-audit.md` § 2.3) — {q("FS129-OA1-NOPERLAW")}. What remains is Falconer's fan, and the fan
  family says where a five-colour fan can live: {q("FS129-SA1-FALC-RES")} (with FS129-SA1-FALC-FAN and FS129-SA1-FALC-DICHO-K: a five-colour fan has
  `χ(H) ≥ 4`, and at `χ(H) = 4` every four-colouring gives apex and tip one colour). Over ℚ(√59), ℚ(√83) and ℚ(√131) a fan forces `t − a ∈ R ∩ 𝔓⁴`
  and periodicity of every four-colouring (FS129-MA2-FALC-HOSTS (iv)), so one Falconer fan at five colours there would settle row 88's question, and a
  non-periodic four-colouring there would rule such fans out (FS-129 item 87).
- *The map step at five*: {q("FS129-OR1-TOP5")} — the honest five-colour route to this stub's YES. Which stub carries it is the re-rank's call (FS-129
  item 26); of its pieces MUA-FIN is FS-120's and REG-J′₅ FS-127's (`plans/FS129-OR1-audit.md` § J10).
"""))
    E.append(("plans/STUB-cp-plane-six.md", "prov-section:## Provisional bearings", f"""*At FS-129's audit ({TAG}):* row 66 (the slack residue
plane Γ₁₁ and the single-vertex repaint — one mechanism under G13, G26, G31 and G48), G75 (route (c)'s format), G55 with row 111 (route (b)'s literal
reading), G43, G48, G54, G68, G69, G76 (the fan's hosts), G63 (the place `t ↦ 0`); FS129-SA1-NOAFF-K, -NOAFF-FIELDS, -PLACE-HOM, -FALC-FAN,
-FALC-DICHO-K, -FALC-RES, -FALC-RED, FS129-OA1-NOPERLAW, FS129-MA2-FALC-HOSTS, FS129-OR1-TOP5.
"""))
    E.append(("plans/STUB-cp-plane-six.md", "notes", """- **§ The question, "given FS-103's F1 (a candidate, not held)"** (line 53): F1 is held, given MR — `LEDGER.md` row 128, "The collapse: given MR, the
  plane's number is a field's", with `χ(F²) = χ(ℝ²) = χ_CP(ℝ²)` at every totally real field whose stable places are all 6-thick, at [hand + tools exact];
  row 130 adds `χ_CP(ℝ²) = χ_m⁰(ℝ²)` with no MR. So, given MR, this stub's question is rung D (FS-129 item 28; `data/fs129/reports/FS129-Q1.md`).
- **§ The question, "`[Falconer1981]`, **not held**"** (line 55), and **§ Provisional bearings, "G49/G50 (Falconer not held)"** (line 87): held and read
  in full (`BIBLIOGRAPHY.md` `[Falconer1981]` and its copy row); Lemmas 1–4 checked against pp. 185–187 (`plans/FS129-MA1-audit.md` § 2.1). Route (0)'s
  reading is done (FS-129 items 38, 42, 67).
"""))
    # ---------------------------------------------------------------- FS-122
    E.append(("plans/STUB-forced-pair.md", "bearing:## Bearing on the answer", f"""{A} Poros's invention signal on this route (FS-129
inventory item 27) does not stand — no two held results contradict (`plans/FS129-OR1-audit.md` § J15). Side 1's reason, row 134, is a Condition-5
theorem; with unit arcs routes R and M meet at the pinned corner (FS112-STOP, FS112-Y3-R3, FS112-N3-COR3). In its exact-map form: in a valid map both
common unit points of a cubic trichromatic complementary pair are vertices of at least four colours whose rings carry (Q) arcs (FS112-N3-COR3), so they
are FS-124's class, and a local exclusion of four-colour vertices with (Q) rings leaves no such pair in any valid map. At `ε > 0` the bearing on this route
needs a band-stable four-colour kill: the question reduces to the carried card `do-fs114-kills-survive-a-band` (J16). Not covered: route R's fat
junctions of higher degree (COR3 is for cubic trichromatic vertices). The bicycle — Voronov's Lemma 6.1 branch (i) — has a stub of its own, FS-130
(`plans/STUB-bicycle-windings.md`).
"""))
    E.append(("plans/STUB-forced-pair.md", "notes", """- **§ Bearing on the answer, "so this route and FS-121's meet nowhere below the answer"** (line 37): true under Condition 5 only; with unit arcs the two
  routes meet at the pinned corner (the paragraph "At FS-129's audit" above; `plans/FS129-OR1-audit.md` § J15; FS-129 item 58). `plans/FRONTIER-STUBS.md`
  rank 5's line says the same and is the re-rank's.
"""))
    # ---------------------------------------------------------------- FS-115
    E.append(("plans/STUB-stuck-ray.md", "bearing:## Bearing on the answer", f"""{A} Two bearings this stub did not carry.
- *DISC-F in the Siamese and non-simple classes* (`plans/FS129-OR1-audit.md` § J19). With FS129-OR1-LOCALDENSE, DISC-F follows from C114-LOCAL-F in the
  non-Siamese simple class (FS129-OR1-DISCF-NS), where no vertex has a repeated colour; in the Siamese or non-simple class it needs, besides, the same
  exclusion about repeated-colour vertices or four-colour vertices within a bounded distance of every repeated-colour vertex — FS114-CV-EXISTS's *not
  claimed* ("GS-4's density form, which still needs FS-115's (b′) and (b″) for aperiodic maps"). So (b′) and (b″) bear on DISC-F there, against
  `data/fs129/demand-judged.md` § 5 ("no bearing on the NO since FS114-CV-EXISTS").
- *A new path, placed here: an analogue of FS121-O1-OUT for valid maps* (FS-129 items 101, 120). FS121-D2-SYM excludes LRA by a window bound on
  radius-`r` arcs; moving that hypothesis to FS112-N3-PER, toward its GAP N3-ALPH — (b″)'s sub-question — **stalls**, in FS129-SR1's words
  (`plans/FS129-SR1-audit.md` § Stage 3, group 5): "D2-SYM's kill uses that a tangent arc of radius `n` continues to `n + 1, n + 2, …` over one angular
  window, so windows stay fixed while radii grow; FS-112's pencil arcs bound horns near `P_k` and nothing makes a valid map continue them along a window,
  so their angular windows about `P_{{−1}}` need not be bounded below". The saturated continuation is FS121-DB1-L7 (INTRAD's outward step); a valid map has
  no saturation, so the analogue must come from the map's own stuck chains, FS112-N2-RAY's pencil (`plans/FS129-SR2-audit.md` § 4.2). **The smallest open
  form:** does a valid map with unit arcs continue a stuck chain's pencil arcs along one angular window — an O1-OUT for valid maps — or does some valid-map
  pencil have windows that shrink? The first is what the transfer of D2-SYM's window hypothesis to N3-PER needs; the second shows it cannot run this way.
  FS129-SR2 registered the first at 0.15 and the second at 0.15 (its § 1). **Why here and not a stub of its own**: its object is this stub's (the stuck
  chains' pencil), its use is this stub's sub-question N3-ALPH, and its bearing is this stub's; a separate stub would split one object across two files.
  FS-126 holds the saturated side, where O1-OUT is held.
"""))
    E.append(("plans/STUB-stuck-ray.md", "prov-para:**Provisional bearings**", f"""*At FS-129's audit ({TAG}):* FS129-OR1-LOCALDENSE, -DISCF-NS;
FS121-O1-OUT, -D2-SYM, -DB1-L7 (the saturated continuation); G85.
"""))
    # ---------------------------------------------------------------- FS-120
    E.append(("plans/STUB-pinch-at-junction.md", "bearing:## Bearing on the answer", f"""{A} FS111-M2-INT's GAP ("the same for the interior of
the support F of a set with null unit pairs (a GAP under the topological reading of 'regular', VM2 (O2))") is open, and FS111-M3-IRREG does not refute
it: the set maximality must add is nowhere dense, so it adds nothing to the interior of the support (`plans/FS129-SR3-audit.md` § 4.1); its maximal-set
form is this stub's question 3. The map step at five's MUA-FIN is this stub's (`plans/FS129-OR1-audit.md` § J10), so FS129-OR1-TOP5 — with REG-J′₅,
the honest existence form of C-SAT-T at five holds if and only if `χ_m⁰(ℝ²) ≥ 6` — bears on its rungs, as does FS129-SR2-HULLSET (FS111-C-HULL for one
measurable set with null unit pairs, so FS111-M-PINCH and FS111-M-HULL2 need no colouring for that step; `plans/FS129-SR2-audit.md` § 2.1, row 24). No
held result closes the pinch (`plans/FS129-OR1-audit.md` § J11).
"""))
    E.append(("plans/STUB-pinch-at-junction.md", "prov-section:## Provisional bearings", f"""*At FS-129's audit ({TAG}):* FS129-SR2-HULLSET,
-CLOSURE (FS106-DIAM (iii), FS111-V0-CLOSE and FS116-V5-NE1's first clause, one lemma), FS129-OR1-TOP5.
"""))
    # ---------------------------------------------------------------- FS-117
    E.append(("plans/STUB-route-t-count.md", "bearing:## Bearing on the answer", f"""{A} K1's (Q)-free case has no instance in the non-Siamese
class: FS129-OR1-QFREE (simple) and FS129-SR3-QFREE-NS (without simplicity) exclude at `1 + ε` every vertex of at least four colours whose ring carries no
(Q) arc, so route T's K1′ is owed only on (Q) rings (`plans/FS129-OR1-audit.md` § J24). An open line unplaced between this stub and FS-124's case 6:
FS114-Y3-RSTOP's "Y3-D2 without reading R-T" — a Reuleaux bowtie with a non-tactic edge, which no held result reads; this stub's if the count pays it
(`plans/FS129-SR3-audit.md` § 4.1). FS114-Y3-RSTOP is a member of FS114-Y4-RSTOPALL only on the non-Siamese simple part (FS-129 item 117; the erratum
under FS114-Y3-RSTOP in `plans/FS114-derivation.md`).
"""))
    E.append(("plans/STUB-route-t-count.md", "prov-para:**Provisional bearings:**", f"""*At FS-129's audit ({TAG}):* FS129-OR1-QFREE, FS129-SR3-QFREE-NS
(K1 on (Q)-free rings has no instance).
"""))
    # ---------------------------------------------------------------- FS-126
    E.append(("plans/STUB-curved-pencils.md", "bearing:## Bearing on the answer", f"""{A} FS-112's stuck ray and this stub's tangent pencil are
one picture in two settings, not one statement (`plans/FS129-SR1-audit.md` § Stage 3, group 5); the valid-map side, an analogue of FS121-O1-OUT for valid
maps, is carried in FS-115's bearing. FS111-M2-INTRAD's one-step argument, read at a vertex of a saturated fragment, would put FS-125's tangent edges in
this stub's class (arcs of integer radius at least 2) given saturation one unit beyond (`plans/FS129-MR1-audit.md` § G85; not derived).
"""))
    return E


NEW_STUB = "plans/STUB-bicycle-windings.md"


def new_stub_text() -> str:
    return f"""# FS-130 — the bicycle's windings: can two unit circles whose centres are between 1 and 2 apart be three-coloured by finitely many arcs, with no two points at distance 1 of one colour? (stub)

*Minted {TAG.split(', ')[1]} by FS-129's record job, part 2 (FS129-Z2; `plans/FS129-Z2-record.md` stage 4), from FS-129 inventory items 81 and 120: a
new derivation the audit's readers named and did not attempt — "a coupling of the two circles' windings across the cross curve is missing"
(`plans/FS129-MR1-audit.md` § Table of misses; `plans/FS129-MA1-audit.md` § 5.1; `plans/FS129-SR2-audit.md` § 4.2). Not ranked: Poros writes its
question section, its bearing on the answer and its rank (FS129-P1); everything below is the context a fresh mind needs. **Solver column: in-ban** —
derivation, and colourings given by formula with exact checks; a scan over arc offsets is a search, the Searcher's (`plans/STANDING-RULES.md` rule 5).
Read first: `CLAUDE.md` § The aim and § Counter-priors; `plans/FS106-TS-derivation.md` § Stage 4 (C-T-BIKE); `plans/FS110-derivation.md` FS110-N2-RING,
FS110-Y3-GP, FS110-Y-BIKE-3C; `plans/FS107-R-stability.md` §§ 3.4, 3.6; `plans/FS129-derivation.md` FS129-SR1-RINGBAND.*

## The object, in plain language

Take two points `u`, `v` of the plane at distance `d`, `1 < d < 2`, and the two unit circles `T₁(u)` and `T₁(v)` about them — **the bicycle**. Join two
points of the union when they are exactly 1 apart. Points of one circle are 1 apart when they are 60° apart on it; a point of `T₁(u)` is 1 from the two
points where the unit circle about it crosses `T₁(v)`, and those cross pairs, as the point moves, trace the **cross curve**. The question C-T-BIKE asks
(`plans/FS106-TS-derivation.md` § Stage 4, verbatim): "an explicit proper 3-colouring of `T₁(u) ∪ T₁(v)` by finitely many arcs (or a proof none exists),
for each `d = |u − v| ∈ (1, 2)`".

What is held:
- **Three colours are needed** at every `d ∈ (1, 2)` — FS106-BIKE ([hand; one mind: TS]): "The bicycle T₁(u) ∪ T₁(v), 1 < |u − v| < 2, with the single
  distance 1 needs three colours (a triangle at |x − v| = √3); whether three suffice by finitely many arcs is open."
- **Each circle alone has a winding.** A three-colouring of one circle by arcs, proper at 60°, lifts to a winding `W`: FS110-N2-RING ("At a three-colour
  vertex whose unit circle carries no arc of `Γ` the ring has a winding `W`; `|W| ≤ 1` forces a swap point", two minds) and FS110-Y3-GP ("A ring with no
  two change points exactly 60° apart winds `W ≡ 3 (mod 6)`; so `|W| ≤ 2` needs two change points at distance exactly 1", two minds); FS129-SR1-RINGBAND
  (derived, one mind) is their one lemma: with no swap point `W = 6M + 3` unless the change set is 60°-invariant (FS-129 item 97).
- **One family fails off grid corners** — FS110-Y-BIKE-3C ([hand; two minds, one blind; GAP at grid-corner passages]): "No six-arc three-cycle colouring of
  each circle colours the bicycle at any `d` in `(1, 2)` whose cross curve meets no grid vertex."
- **One ansatz fails narrowly**: the pure `π/3`-arc shared-colour ansatz at `d = 1.9`, two windows by hand, branch gap 58.4° and 59.3° against the 60° it
  needs (`plans/FS107-R-stability.md` § 3.6; "hand arithmetic, not a claim about C-T-BIKE").
- **A near miss**: row 1's two-circle theorem needs two concentric circles; the bicycle's are not (`plans/FS129-MA1-audit.md` § 5.1).

**What is missing** (the audit's finding): an invariant that couples the two circles' windings across the cross curve — "an invariant for a
three-colouring of two hexagon rings coupled by cross edges" (`plans/FS129-MA1-audit.md` § 5.1). With it, a three-colouring by arcs either exists for a
named `d` (and is written by formula) or is excluded at every `d`.

## Why it was asked, and where it stands now

The bicycle is the configuration at the end of branch (i) of Voronov's Lemma 6.1 (`[Voronov2023]` Thm 1.2, the band form; FS106-BIKE's prior art);
FS-106 named C-T-BIKE as a step of route (R-S) on the limit object, and FS-107 read branch (i) as "escapable as a graph" — the index's only band step is to
exclude a simultaneous swap (`plans/FS107-R-stability.md` § 3.4; `plans/FS106-TS-derivation.md` C-T-BIKE (ii)). FS-107's R-S route is closed (row 133), so
C-T-BIKE has had no consumer since; FS129-MA1 recorded the winding route "not derived — the route it served (FS-107's R-S) is closed (row 133)". Route R's
live stub is FS-122 (`plans/STUB-forced-pair.md`), whose progress is measured by a robust Lemma 6.1 count.

## Bearing on the answer (provisional, FS129-Z2's; Poros replaces it)

**None known.** Whether the bicycle's three-colourability by arcs bears on a robust Lemma 6.1 count (FS-122) is this stub's first question for Poros. A
coupling invariant would be new structure on the unit-distance graph of two circles, whatever its bearing.

## Registered expectations

None registered here (Poros's card and the opening register them).

## Failure clauses

A NO says which arcs it excludes (finitely many; unit arcs or not) and at which `d`; a YES is a colouring by formula with an exact check whose planted
fault fires; choosing an offset by scanning is a search request, never a step (FS106-TS: "choosing `φ` by a scan is a search (the ban)").

## Deliverables

The plan (the reframe first); a derivation file in the Ephodos grammar; any colouring by formula with an exact check.

## Provisional bearings

G71 (the height: a three-colouring of a circle has a winding), G13 (row 1's two-circle theorem, a near miss), G21 (no held inhabitant), G40, G79; rows 1,
131–134; stubs FS-122 (route R), FS-123 and FS-124 (the same winding on a ring, through FS-110's winding at a three-colour point).
"""


def insert(text_by_file: dict[str, str], f: str, place: str, body: str) -> str:
    t = text_by_file[f]
    L = t.split("\n")
    if place == "notes":
        head = f"## Dated correction notes ({TAG})"
        if head not in t:
            t = t.rstrip("\n") + f"\n\n{head}\n\n" + body
        else:
            t = t.rstrip("\n") + "\n" + body
        return t
    kind, anchor = place.split(":", 1)
    if kind in ("bearing", "prov-section"):
        k = next(i for i, ln in enumerate(L) if ln.strip() == anchor or ln.startswith(anchor))
        end = next((j for j in range(k + 1, len(L)) if L[j].startswith("## ")), len(L))
        while end > k + 1 and not L[end - 1].strip():
            end -= 1
        L[end:end] = [""] + body.rstrip("\n").split("\n")
        return "\n".join(L)
    if kind == "prov-para":
        k = next(i for i, ln in enumerate(L) if ln.startswith(anchor))
        end = next((j for j in range(k + 1, len(L)) if not L[j].strip()), len(L))
        L[end:end] = [""] + body.rstrip("\n").split("\n")
        return "\n".join(L)
    raise ValueError(place)


def check(fault: bool) -> int:
    problems = []
    E = edits()
    if fault:
        f0, p0, b0 = E[0]
        E[0] = (f0, p0, b0.replace("whole-tile", "round"))
    for f, place, body in E:
        t = (ROOT / f).read_text(encoding="utf-8")
        n = t.count(body.rstrip("\n"))
        if n != 1:
            problems.append(f"{f} {place}: insertion present {n} times")
    if not (ROOT / NEW_STUB).exists() or (ROOT / NEW_STUB).read_text(encoding="utf-8") != new_stub_text():
        problems.append(f"{NEW_STUB}: missing or differs from the text in this tool")
    files = sorted({f for f, _, _ in E})
    d = subprocess.run(["git", "diff", "--numstat", "HEAD", "--"] + files, cwd=ROOT, capture_output=True, text=True).stdout
    for ln in d.splitlines():
        a, r, f = ln.split("\t")
        if r != "0":
            problems.append(f"{f}: git diff deletes {r} lines")
    print(f"stubs check: {len(E)} insertions in {len(files)} open stubs, new stub {NEW_STUB}, {len(problems)} problems")
    for p in problems:
        print("  ", p)
    if fault:
        print("(--fault: one insertion altered in memory)", "— it fires" if problems else "— IT DID NOT FIRE")
        return 0 if problems else 1
    return 1 if problems else 0


def apply() -> int:
    E = edits()
    files = sorted({f for f, _, _ in E})
    texts = {f: (ROOT / f).read_text(encoding="utf-8") for f in files}
    for f, place, body in E:
        if body.rstrip("\n") in texts[f]:
            raise SystemExit(f"already applied: {f} {place}")
    for f, place, body in E:
        texts[f] = insert(texts, f, place, body)
    for f in files:
        (ROOT / f).write_text(texts[f].rstrip("\n") + "\n", encoding="utf-8")
    if (ROOT / NEW_STUB).exists():
        raise SystemExit(f"{NEW_STUB} exists")
    (ROOT / NEW_STUB).write_text(new_stub_text(), encoding="utf-8")
    print(f"applied {len(E)} insertions to {len(files)} stubs; wrote {NEW_STUB}")
    return 0


if __name__ == "__main__":
    if "--apply" in sys.argv:
        sys.exit(apply())
    sys.exit(check("--fault" in sys.argv))
