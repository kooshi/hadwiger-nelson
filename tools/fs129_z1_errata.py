#!/usr/bin/env python3
"""FS129-Z1: the dated errata the record job files under earlier milestones' derivation entries.

Each erratum is a paragraph inserted directly under the text it corrects (after an anchor line, or before the next entry's header), the
original text left standing. --apply inserts each erratum once (it refuses if the text is already there); --check verifies that every
erratum is present exactly once and that its anchor line still stands; --check --fault drops one erratum from the expected set's text in
memory and must fail.

  python3 tools/fs129_z1_errata.py --apply
  python3 tools/fs129_z1_errata.py --check            expect "errata check: 10 errata, 0 problems"
  python3 tools/fs129_z1_errata.py --check --fault    must report a problem and exit 1
"""
import sys
from pathlib import Path

PLANS = Path(__file__).resolve().parent.parent / "plans"
Z = "*Erratum (2026-10-03, FS129-Z1"

# (file, entry header prefix, mode, anchor prefix, text); mode "after" inserts after the first line (at or below the entry header) that starts
# with the anchor; mode "before" inserts before the first line below the entry header that starts with the anchor.
ERRATA = [
("FS89", "**Notation, fixed once**", "after", "**MS_k(S)**:",
 "*Erratum (2026-10-03, FS129-SA1, from FS91-J03a-9 and FS91-J07-14; `plans/FS91-close-inventory.md` rows 61, 69, 78):* over `R_F` with `F ≠ ℚ`, "
 "read `A` as `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`, the archimedean characters of every place of `F(i)`; `λ_e(x) = Re(ē x)` at one embedding is its case "
 "`F = ℚ`. With the one-embedding reading FS89-S0A-2, FS89-S0A-10 and FS89-CL2 are false (ℚ(√3), band 1/4: `τ + Re(ē σ₂(·))`); with `A(R_F)` they "
 "hold, and every proof step in this file already reads every real place (FS91-J07-14). *(Filed 2026-10-03 by FS129-Z1, verbatim from "
 "`plans/FS129-SA1-audit.md` § 3.1's draft; `plans/FS129-close-inventory.md` item 108. The Notation above stands as written.)*"),
("FS89", "**FS89-CL2 —", "after", "*Kernel:* declined.",
 Z + ", from `plans/FS129-SA1-audit.md` § 3.1; `plans/FS129-close-inventory.md` item 108):* the correction banner above this entry covers "
 "FS89-S0A-2 and FS89-S0A-10 as well: they state the field clause with the same Notation's `A`, and are false as written for the same reason "
 "(ℚ(√3), band 1/4). The repair is the one line filed under the Notation (`A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`), and it makes all three true. Nothing "
 "downstream inherits the falsity: CL3–CL5 read both real places (`plans/FS91-S1D-character.md` § 4.4). For the Lean backlog: S0A-2's kernel line "
 "names it a candidate for FS-87's list; formalized from the Notation as written it is unprovable (inventory item 109)."),
("ASTRA-2026-09-14", "**T10 — The distance-2 host sentence.", "after", "**T10 — The distance-2 host sentence.",
 "*Erratum (2026-10-03, FS129-SA1; `plans/FS129-close-inventory.md` item 69):* read the hypothesis as \"two points at distance 2 that receive "
 "different colours in every proper five-colouring of the graph (`Separated` at distance 2, five colours)\". The hypothesis is empty over every "
 "`F ⊇ K` with a usable prime of residue field `𝔽₁₁` (row 66, `Separated ↔ Adj`) and over every `F` with `χ(F²) ≤ 4`; the sentence has content only "
 "over fields with `χ(F²) ≥ 5` and no such prime — K(√7) the first. *(Filed 2026-10-03 by FS129-Z1, verbatim from `plans/FS129-SA1-audit.md` "
 "§ 3.2's draft; inventory item 108. T10's text above stands as written; if FS-49 is formalized, its hypothesis is `Separated`, every colouring.)*"),
("FS100", "**FS100-T1 —", "before", "**FS100-",
 Z + ", from `plans/FS129-SA1-audit.md` § 4.2, row X25B-T1; `plans/FS129-close-inventory.md` item 108):* the grade above counts \"one mind "
 "(J51)\". X25B-T1 (`plans/FS100-X25B-derivation.md` § Theorems this phase proved) is a second derivation of all three equivalences, blind to the "
 "proofs though not to the outline (its fence log), and `LEDGER.md` row 117 counts it (\"two derivations (J51; X25B, blind)\"). Read the grade as "
 "gaining \"X25B-T1, blind to the proofs (not the outline; owner's ruling as for X25B-T)\". No statement changes."),
("FS106", "**FS106-EQ —", "before", "**FS106-",
 Z + ", from `plans/FS129-SR2-audit.md` § 2.1 row 5 and § 2.2.3; `plans/FS129-close-inventory.md` item 117):* this entry is stated \"for "
 "every k\", and its periodic grid-square clause rests on FS106-SUP, which is stated at six only. The input at every k is FS129-SR2-SUPK "
 "(`plans/FS129-derivation.md`: FS106-SUP's argument, which reads no number of classes, at every k; derived, one mind). Read EQ's every-k form as "
 "citing SUPK; EQ's (c) ⟺ (d) is SUPK read at the value 1. No statement changes."),
("FS110", "**FS110-A3-HOLE —", "after", "*Kernel:* declined — off the headline's path.",
 Z + ", from `plans/FS129-MR1-audit.md` § The leads of pass 1, lead (a), and § Lead (a), completed; `plans/FS129-close-inventory.md` item "
 "78):* this entry's GAP — both steps when the vertex's unit circle carries an arc of `Γ` — was answered later without a link back. Its first step "
 "is held, stronger, as FS116-N1-QFREE4 (\"if the ring carries no (Q) arc then `p` has four colours and no more\", Siamese pairs allowed), so the "
 "GAP branch is exactly the rings carrying a (Q) arc, and there the step is false on fragments: FS116-Y2-SIXFRAG holds a six-colour vertex on every "
 "disc of radius below 3/2. Its second step is FS112-A4SIX's branch (a four-colour vertex with no covering pair on its unit circle has on that circle "
 "arcs of `Γ` centred at it of total length at least 60°, or at least six, one in each of six consecutive 60° windows), or else a change point of "
 "exactly two colours (FS116-N2-STAR gives `C(y) = A(p) ⊔ T_y ⊔ O_y`; FS116-N1-QDISK's corner change point is one). A miss of citation, not of work."),
("FS111", "derivation: FS111-M-COVER-SC", "after", "Rests on it: FS111-M2-HULLC.",
 Z + ", from `plans/FS129-SR2-audit.md` § 2.1, rows 25 and 37; `plans/FS129-close-inventory.md` item 117):* the handoff's \"superseded by "
 "FS111-M2-HULLC's fuller form\" is wrong: HULLC adds \"with regular classes\", while this entry's semiconcavity holds on every maximal cover (it "
 "uses FS111-M-SATC and C-HULL only). Formalize this entry's semiconcavity in place of HULLC's semiconcave clause (SR2 § 4.3 item 17); the edge "
 "from this entry into HULLC is not a use. C-HULL is itself a case of FS129-SR2-HULLSET (`plans/FS129-derivation.md`)."),
("FS111", "derivation: FS111-W-NOREP", "after", "*Correction (2026-10-03, FS-121's close; FS121-DB1 § 3.3 item 2",
 Z + ", from `plans/FS129-SR2-audit.md` § 4.1, row 43; `plans/FS129-close-inventory.md` item 117):* the not-claimed line's GAP (\"the same "
 "for general saturated colourings (GAP: (H2) at the partners is not among C11's hypotheses there)\") is answered for honest saturated colourings "
 "in D-NF satisfying REG-J′ by FS121-DB1-L3 (\"at every point of Σ no colour occupies two sectors of positive angle, whatever cusps are present at "
 "the point or elsewhere\", two minds); what is left open is saturated colourings that are not honest or do not satisfy REG-J′. FS121-DB1-L3 is "
 "formalized in this entry's place (SR2 § 4.3 item 22)."),
("FS114", "derivation: FS114-Y3-RSTOP", "after", "Rests on it: FS114-Y4-RSTOPALL's first member",
 Z + ", from `plans/FS129-SR2-audit.md` § 2.1, row 95; `plans/FS129-close-inventory.md` item 117):* the handoff's \"a member of "
 "FS114-Y4-RSTOPALL\" holds only on the non-Siamese simple part: this entry allows Siamese pairs (its own statement, for FS114-Y2-BOWTIE), so it is "
 "not a case of RSTOPALL, which uses its lemma Y3-R. It stays a separate statement for the Lean backlog (SR2 § 4.3 item 16)."),
("FS116", "derivation: FS116-Y4-EMPTY", "before", "derivation: ",
 Z + ", from `plans/FS129-SR1-audit.md` § 2.3; `plans/FS129-close-inventory.md` item 96):* the not-claimed line's \"rings carrying an arc of "
 "Γ that is not a (Q) arc (the (Q)-free rings of FS114-N6-RING60 after the bends, with (R2) arcs)\" are now reached in the non-Siamese simple class by "
 "FS129-OR1-QFREE (derived, one mind; `plans/FS129-derivation.md`): no non-Siamese simple valid six-coloured fragment on a closed disc of radius "
 "above 1 about a vertex of at least four colours has a ring carrying no (Q) arc. FS129-SR3 (`plans/FS129-SR3-audit.md` § Stage 2 — SAVED: item (d); "
 "derived, one mind; FS129-Z2 files its entries) derives this entry and QFREE with \"simple\" dropped on FS116-V6's route (FS129-SR3-EMPTY-NS, "
 "FS129-SR3-QFREE-NS), which reaches the not-claimed line's non-simple class as well; FS116-Y4's own route uses simplicity."),
]


def locate(lines, header, mode, anchor):
    h = next(i for i, ln in enumerate(lines) if ln.startswith(header))
    if mode == "after":
        a = next(i for i in range(h, len(lines)) if lines[i].startswith(anchor))
        return a + 1, ["", None]
    a = next(i for i in range(h + 1, len(lines)) if lines[i].startswith(anchor))
    return a, [None, ""]


def apply():
    for f, header, mode, anchor, text in ERRATA:
        p = PLANS / f"{f}-derivation.md"
        s = p.read_text()
        assert text not in s, f"{f}: already filed"
        lines = s.split("\n")
        at, shape = locate(lines, header, mode, anchor)
        ins = [text if x is None else x for x in shape]
        if mode == "before" and lines[at - 1].strip():
            ins = [""] + ins
        lines[at:at] = ins
        p.write_text("\n".join(lines))


def check(fault=False):
    bad = 0
    for k, (f, header, mode, anchor, text) in enumerate(ERRATA):
        s = (PLANS / f"{f}-derivation.md").read_text()
        want = text + (" (planted)" if fault and k == 0 else "")
        if s.count(want) != 1:
            print(f"ERRATUM NOT PRESENT ONCE in {f}: {text[:70]}"); bad += 1
        lines = s.split("\n")
        try:
            locate(lines, header, mode, anchor)
        except StopIteration:
            print(f"ANCHOR GONE in {f}: {header} / {anchor}"); bad += 1
    print(f"errata check: {len(ERRATA)} errata, {bad} problems" + (" (fault planted)" if fault else ""))
    return bad


if __name__ == "__main__":
    a = sys.argv[1:]
    if "--apply" in a:
        apply()
    sys.exit(1 if check(fault="--fault" in a) else 0)
