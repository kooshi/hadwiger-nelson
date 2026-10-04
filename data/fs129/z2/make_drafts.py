#!/usr/bin/env python3
"""FS129-Z2 working file: builds the ledger-row and Proof Atlas drafts with every FS-129 statement quoted verbatim from the reader's record
(through tools/fs129_z2_stubs.py's stmt()), and writes data/fs129/z2/drafts-rows.md. Run from the repository root."""
import importlib.util
from pathlib import Path
spec = importlib.util.spec_from_file_location("s", "tools/fs129_z2_stubs.py"); s = importlib.util.module_from_spec(spec); spec.loader.exec_module(s)
S = s.stmt
W = "FS-129 (2026-10-03)"
rows = {
149: (f"**In non-Siamese valid six-coloured fragments, simple or not, a vertex of at least four colours whose unit circle carries no (Q) arc — no arc of "
      f"the boundary whose two side colours the vertex carries — exists on no disc of radius above 1 about it:** \"{S('FS129-SR3-QFREE-NS')}\" "
      "(FS129-SR3-QFREE-NS). The step is FS-112's bends read on a fragment: on the whole-tile restriction of radius at most `√3` — the tiles meeting the open "
      f"disc, each with its whole closure — \"{S('FS129-SR1-BENDANY')}\" (FS129-SR1-BENDANY, at any `k`; FS129-OR1-WHOLE), while a round restriction can cut one "
      "tile into a Siamese pair; so in each class the exclusion of rings with no arc of the boundary gives the (Q)-free one (FS129-OR1-QFREE-CLASS), and row "
      "148's exclusion holds without simplicity, since FS116-V6's route never reads it (FS129-SR3-EMPTY-NS). FS-123's first question is answered yes; the "
      "classes of FS114-N7-3T, -N7-HUB and -N6-RING60 are empty there; FS116-S1-QF, the saturated straight cross of row 146, is a case (FS129-SR2-QFCASE). "
      "[hand], one mind, kernel pending (FS129-SR1's attacks on the chain's two named steps found no gap — checking readings, not second minds). "
      "**Not claimed:** the Siamese class (FS-123's question now); rings carrying a (Q) arc (FS-124); anything at seven colours or more. **Prior art:** "
      "owed; the bends are FS-112's moves (FS112-N2-RED, on maps), their reading on a fragment not searched.",
      "`plans/FS129-derivation.md` (FS129-SR3-QFREE-NS, -EMPTY-NS; FS129-OR1-QFREE-CLASS, -WHOLE, -QFREE; FS129-SR1-BENDANY; FS129-SR2-QFCASE); "
      "`plans/FS129-OR1-audit.md` § J1; `plans/FS129-SR3-audit.md` § 2; `tools/fs129_or1_lens.py`, `tools/fs129_sr3_simple.py`"),
150: (f"**The (Q)-ring case list, pruned: two change points 60° apart on a four-colour vertex's ring whose far germs lie off (Q) arcs share neither a sole tip "
      f"nor a sole outer colour, and one pinwheel residue is empty.** \"{S('FS129-MR1-DOUBLETIP')}\" (FS129-MR1-DOUBLETIP); \"{S('FS129-SR3-OUTERADJ')}\" "
      f"(FS129-SR3-OUTERADJ, no simplicity); \"{S('FS129-SR3-E2ONE')}\" (FS129-SR3-E2ONE). Behind them, and behind FS114-Y5-PXKILL, FS116-V6-HUG, -V6-ADJ and "
      "FS116-Y4-FLANK, one identity: `|a(s) − b(t)|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2) = 2(1 − cos s)(1 − cos t) − 2 sin s sin t` for the points "
      "reached by turning about two unit-distance centres toward a common unit neighbour (FS129-SR1-TWOCIRC). [hand], one mind each, kernel pending. "
      "**Not claimed:** SEMI-PAR3; germs on (Q) arcs; the Siamese class; E2 at two or more blades and E1's residues. **Prior art:** owed; the identity is "
      "held in-house since FS-114 (FS114-YB4-2ND).",
      "`plans/FS129-derivation.md` (FS129-MR1-DOUBLETIP, FS129-SR3-OUTERADJ, -E2ONE, FS129-SR1-TWOCIRC); `plans/FS129-MR1-audit.md` § Stage 2; "
      "`plans/FS129-SR3-audit.md` §§ 1.3, 3.1; `tools/fs129_mr1_doubletip.py`, `tools/fs129_sr3_outeradj.py`, `tools/fs129_sr3_e2one.py`, `tools/fs129_sr1_twocirc.py`"),
151: (f"**A slack residue target kills every linear identity on a colouring, at every number of colours:** \"{S('FS129-SA1-NOAFF-K')}\" (FS129-SA1-NOAFF-K, "
      f"row 66's single-vertex repaint at any target). Over fields: \"{S('FS129-SA1-NOAFF-FIELDS')}\" (FS129-SA1-NOAFF-FIELDS, through G63's place `t ↦ 0` "
      "with the residue map, FS129-SA1-PLACE-HOM). So FS-104 route (c)'s linear-identity format (G75's annihilator) is empty over those fields. [hand], one "
      "mind, kernel pending. **Not claimed:** inequalities (three- and four-point positivity); identities of degree two or more; fields with no such prime "
      "and `χ(F²) ≥ k`. **Prior art:** partly — the four-colour form is FS84-S1e (2026-09-25, in-house); a gapped vertex is a non-frozen one "
      "(`[BrewsterEtAl2020]`); the field form owed.",
      "`plans/FS129-derivation.md` (FS129-SA1-NOAFF-K, -NOAFF-FIELDS, -PLACE-HOM; superseded FS129-OA1-NOLIN5, FS129-MA1-NOAFF5); `plans/FS129-SA1-audit.md` § 2; "
      "`tools/fs129_sa1_family.py`, `tools/fs129_ma1_noaff.py`"),
152: (f"**Falconer's fan, at every number of colours, and where a five-colour fan can live; route (b)'s literal reading is empty.** \"{S('FS129-SA1-FALC-RED')}\" "
      f"(FS129-SA1-FALC-RED; `[Falconer1981]` Lemmas 1–4 checked against the paper). \"{S('FS129-SA1-FALC-RES')}\" (FS129-SA1-FALC-RES; with "
      "FS129-SA1-FALC-FAN and -FALC-DICHO-K: a fan at `k` colours has `χ(H) ≥ k − 1`, and at `χ(H) = k − 1` gives apex and tip one colour). Over ℚ(√59), "
      "ℚ(√83), ℚ(√131) a five-colour fan forces `t − a ∈ R ∩ 𝔓⁴` and every four-colouring of the plane periodic (FS129-MA2-FALC-HOSTS (iv)), so one such "
      f"fan would settle row 88's question. And \"{S('FS129-OA1-NOPERLAW')}\" (FS129-OA1-NOPERLAW). [hand], one mind each, kernel pending. **Not claimed:** "
      "that any Falconer fan at five colours exists; the almost-everywhere form (it needs a positive-measure set of translations, which the 1981 text does "
      "not supply); anything for `χ(ℝ²)` without MR. **Prior art:** `[Falconer1981]` for the mechanism; the fan family and NOPERLAW owed.",
      "`plans/FS129-derivation.md` (FS129-SA1-FALC-RED, -FALC-FAN, -FALC-DICHO-K, -FALC-RES, FS129-MA2-FALC-HOSTS, FS129-OA1-NOPERLAW); "
      "`plans/FS129-MA1-audit.md` § 2; `plans/FS129-OA1-audit.md` § 2.3; `tools/fs129_oa1_falconer_fan.py`, `tools/fs129_ma1_falcfan.py`, `tools/fs129_ma2_fangap.py`"),
153: (f"**A local density lemma for fragments, and DISC-F from the local exclusion in the non-Siamese simple class:** \"{S('FS129-OR1-LOCALDENSE')}\" "
      f"(FS129-OR1-LOCALDENSE, FS112-N3-DENSE3 read on a fragment; possibly vacuous — no fragment on a disc of radius 3 is held); \"{S('FS129-OR1-DISCF-NS')}\" "
      "(FS129-OR1-DISCF-NS). [hand], one mind, kernel pending. **Not claimed:** the Siamese or non-simple form (there the repeated-colour alternative is "
      "not covered by C114-LOCAL-F and needs GS-4's density form, FS-115); that the vertex found has four colours. **Prior art:** owed.",
      "`plans/FS129-derivation.md` (FS129-OR1-LOCALDENSE, -DISCF-NS); `plans/FS129-OR1-audit.md` § J19"),
154: (f"**The map step at five, as an equivalence:** \"{S('FS129-OR1-TOP5')}\" (FS129-OR1-TOP5). [hand], one mind, kernel pending. **Not claimed:** REG-J′₅ "
      "(FS-127); the honest existence form at five; anything at six. **Prior art:** owed. Which stub carries the map step at five is the re-rank's.",
      "`plans/FS129-derivation.md` (FS129-OR1-TOP5); `plans/FS129-OR1-audit.md` § J10"),
}
out = ["| # | Result | Where | When |", "|---|---|---|---|"]
for n, (res, where) in rows.items():
    out.append(f"| {n} | {res} | {where} | {W} |")
Path("data/fs129/z2/drafts-rows.md").write_text("\n".join(out) + "\n", encoding="utf-8")
print("rows", len(rows))
