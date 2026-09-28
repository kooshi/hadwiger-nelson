#!/usr/bin/env python3
"""FS112-C2 stage 3: the stage-1b edits to plans/FS112-unit-arc-half.md §R-close, as exact (old, new) replacements, each asserted to occur once
and to lie inside §R-close (the plan above it is never touched)."""
import pathlib, sys
P = pathlib.Path('/home/kooshi/source/lean-dir/plans/FS112-unit-arc-half.md')
t = P.read_text()
start = t.index("## §R-close")
E = []
def rep(o, n): E.append((o, n))

rep("ad4b0be1; stage 1b, Y3 against FS112-YB3, when the owner's message comes); stage 2 is `plans/FS112-derivation.md` (53 entries; § B draft\n"
    "`data/fs112/fs112-c/ledger-b-draft.md`; `tools/fs71_ledger_b_check.py --strict` PASS on a scratch copy of `LEDGER.md` with the draft appended, 1,000\n"
    "theorems; the live checker fails until the front-page job writes the § B lines, 49748392).*",
    "ad4b0be1; stage 1b, Y3 against FS112-YB3, §1.8–1.11 by FS112-C2, ba86ef06); stage 2 is `plans/FS112-derivation.md` (56 entries; § B draft\n"
    "`data/fs112/fs112-c/ledger-b-draft.md`; `tools/fs71_ledger_b_check.py --strict` PASS on a scratch copy of `LEDGER.md` with the draft appended, 1,003\n"
    "theorems, `data/fs112/fs112-c2/ledger-strict.out`; the live checker fails until the front-page job writes the § B lines).*")

rep("the non-periodic stuck ray, **and (b″)**, a uniform bound on finite stuck chains — a third GAP, named here.",
    "the non-periodic stuck ray, **and (b″)**, a uniform bound on finite stuck chains — a third GAP, named here. Round 3's last verifier (FS112-YB3)\n"
    "  refuted Y3-END-NEEDS as stated with an exact, locally terminal stuck vertex between two unit circles (FS112-BOWTIE, one fragment) — the proof side's\n"
    "  doubly bounded one-vertex chain, built blind; corrected (its levels two minds, one blind), a horn bound `±1` on both horns of a terminal map's stuck\n"
    "  vertex occurs only at such a one-vertex chain (FS112-C-HORNEND, one mind: FS112-C2). That narrows (b′) and (b″) and leaves the composition unchanged\n"
    "  but for one named residue of FS112-C-ENDS.")

rep("fail one ring further out (FS112-Y3-PIN, one mind, YB3 pending).",
    "fail one ring further out (FS112-Y3-PIN, two minds, one blind).")

rep("**extraction 11** (staffing; G51): the divergences of truth came from verifiers (NB #4 in round 1, YB2 D1 in round 2);",
    "**extraction 11** (staffing; G51): the divergences of truth came from verifiers (NB #4 in round 1, YB2 D1 in round 2, YB3 D1 in round 3);")

rep("arc forces a further unit arc\" holds at chain ends in that form.",
    "arc forces a further unit arc\" holds at chain ends in that form — and with the corrected Y3-END-NEEDS such an end, both horns bounded, has no terminal\n"
    "instance past a one-vertex chain (FS112-C-HORNEND).")

rep("Y3-END-NEEDS\n(what a terminal chain end must carry: a seventh colour), the pinned corner",
    "Y3-END-NEEDS\n(what a terminal chain end must carry: a seventh colour — broken as stated by an example, FS112-BOWTIE, which YB3 built by asking what\n"
    "configuration its own Step 2's exception names), the pinned corner")

rep("| E16 a blind verifier finds a divergence of truth | 0.4 | **met** in round 1 (NB #4) and round 2 (YB2 D1, a quantity); round 3: NB3 none of truth; YB3 pending |",
    "| E16 a blind verifier finds a divergence of truth | 0.4 | **met in every round**: round 1 (NB #4), round 2 (YB2 D1, a quantity), round 3 (YB3 D1: Y3-END-NEEDS FALSE as stated, by an exact fragment; NB3 none of truth) |")

rep("P5 (0.85) **pending** YB3 (Y3's fragments are not terminal at `N`; Y3 derives no terminal completion exists).",
    "P5 (0.85) **not met as registered, N3-END not refuted**: the one locally terminal fragment held with a horn bound `−1`, FS112-BOWTIE, has four colours at\n"
    "`P_{−1}` and no arc at `P_{−2}` — N3-END's own second disjunct, which the registered falsifier (\"no arc at `P_{−2}`\") omitted; Y3's fragments are not\n"
    "terminal at `N` (reconciliation §1.10).")

rep("**Y3:** two tool expectations",
    "**YB3:** every registration met, one after a reporting defect of its tool was fixed (a wrong-reason miss at `N`'s colours, disclosed). **Y3:** two tool expectations")

rep("(item 59); Y3's grades set at stage 1b when FS112-YB3 reports.",
    "(item 59); Y3's grades set at stage 1b (FS112-C2): eight of Y3's nine claims two minds, one blind; Y3-END-NEEDS FALSE as stated, TRUE as corrected.")

rep("- **Confidence: high** that the reduction holds as graded (every link two minds, one blind; no divergence of truth in round 3); **medium** on the\n"
    "  composition's assembly (FS112-C-ENDS rests on N2's exception list for N4-STUCK (iii)–(iv) and on NB's one-mind count at an arc through `N`). It\n"
    "  changes if YB3 refutes Y3-END-NEEDS's third level (then horn-bound chain ends stay live inside FS-115; FS-114 unchanged), or if a step of row 134's\n"
    "  base is found failing (then N3-BASE's residue opens, and FS-114's statement with it).",
    "- **Confidence: high** that the reduction holds as graded (every link two minds, one blind; no divergence of truth on the proof side in round 3);\n"
    "  **medium** on the composition's assembly (FS112-C-ENDS rests on N2's exception list for N4-STUCK (iii)–(iv), on NB's one-mind count at an arc through\n"
    "  `N`, and at one-vertex chains on FS112-C-DOUBLE's sketch, with one residue named). YB3 confirmed Y3-END-NEEDS's levels and refuted its first\n"
    "  requirement at a one-vertex chain: horn-bound ends live on only as one-vertex bowties (FS112-C-HORNEND), inside FS-115; FS-114 unchanged. It changes\n"
    "  if a step of row 134's base is found failing (then N3-BASE's residue opens, and FS-114's statement with it).")

rep("with equality; the exact rim classification); this close — none (the composition derived; the ledger checker run on a scratch copy).",
    "with equality; the exact rim classification); YB3 — search configurations for a stuck vertex with no `h` at `N` (Step 2's exception named one, built\n"
    "once), sample the regions (named points by formula); this close — none (the composition derived; the ledger checker run on a scratch copy); its stage 1b\n"
    "(FS112-C2) — vary BOWTIE's parameters, build an (R2)-bounded doubly bounded end (FS112-C-DOUBLE's sketch derives both instead).")

rep("is what the successors are aimed by. **Row 136's grade clause carries a placeholder `FORM-1B:`** for FS112-YB3's verdict on Y3 (stage 1b sets it; until\n"
    "then it reads \"one mind (Y3), FS112-YB3 pending\").",
    "is what the successors are aimed by. **Row 136's grade clause is set from FS112-YB3's verdicts** (stage 1b, FS112-C2), and row 135 carries the corrected\n"
    "chain end (FS112-C-HORNEND, FS112-BOWTIE).")

# row 135
rep("doubly periodic maps have none, and an end at a horn bound `±1` has a four-colour vertex one step beyond (every finite end, by the close's assembly, one mind).",
    "doubly periodic maps have none; a horn bound `±1` on both horns of a stuck vertex of a terminal map occurs only at a single vertex bounded by unit arcs on both sides, a configuration realised locally and exactly, and every finite end has a four-colour vertex one step beyond (the close's assembly, one mind, bar one named residue at such single vertices).")
rep("N3-PER, N3-END, C-COMPOSE and the rest of § B). **[hand;",
    "N3-PER, N3-END, C-COMPOSE, C-HORNEND, BOWTIE and the rest of § B). **[hand;")
rep("the composition, C-ENDS and C-PARTNERS one mind (FS112-C)]**",
    "the composition, C-ENDS and C-PARTNERS one mind (FS112-C); Y3-END-NEEDS's levels two minds, one blind (Y3; YB3), its scope and the single-vertex fragment BOWTIE one mind (YB3); C-HORNEND and C-DOUBLE one mind (FS112-C2)]**")
rep("an explicit radius for a NO (C-LOCAL). **Prior art:** not found in print (FS-112's gate;",
    "an explicit radius for a NO (C-LOCAL); whether a single vertex bounded by unit arcs on both sides lives in a valid map; a chain end at a unit arc bounding one horn only. **Prior art:** not found in print (FS-112's gate;")
rep("| `plans/FS112-derivation.md` §§1–3; `plans/FS112-N-proof.md`;",
    "| `plans/FS112-derivation.md` §§1–3, §4 (FS112-BOWTIE); `plans/FS112-N-proof.md`; `plans/FS112-YB3-verification.md`;")
rep("`tools/fs112_nb3_checks.py` | FS-112 (2026-09-27) |",
    "`tools/fs112_nb3_checks.py`, `tools/fs112_yb3_frags.py` | FS-112 (2026-09-27) |")
# row 136
rep("Y3's obstructions and chain-end analysis one mind (Y3), FORM-1B: FS112-YB3's grade]**",
    "Y3's obstructions, chain-end fragments, R3 and T2 budget two minds, one blind (Y3; YB3), the obstructions' colour-free extent one mind (YB3)]**")
rep("**Not claimed:** a YES; any region larger than print; Y3-END-NEEDS (no stuck chain of a terminal map ends at a unit arc while its end vertex has three colours) beyond one mind.",
    "**Not claimed:** a YES; any region larger than print; Y3-END-NEEDS as Y3 stated it (FALSE at a single vertex bounded by unit arcs on both sides; its corrected form is row 135's).")
rep("`plans/FS112-YB-verification.md`; `plans/FS112-YB2-verification.md`; `tools/fs112_y_check.py`,",
    "`plans/FS112-YB-verification.md`; `plans/FS112-YB2-verification.md`; `plans/FS112-YB3-verification.md`; `tools/fs112_y_check.py`,")
rep("`tools/fs112_y3_chainend.py`, `tools/fs112_yb2_edgecheck.py` | FS-112 (2026-09-27) |",
    "`tools/fs112_y3_chainend.py`, `tools/fs112_yb2_edgecheck.py`, `tools/fs112_yb3_pins.py`, `tools/fs112_yb3_r3.py` | FS-112 (2026-09-27) |")

rep("**§ B:** the 53 lines of `data/fs112/fs112-c/ledger-b-draft.md`, after FS-110's (`--strict` PASS on a scratch copy, 1,000 theorems; grade cells in\n"
    "FS110-X's compact form). Stage 1b updates the grade cells of FS112-Y3-PIN, -END-AB, -END-NEEDS, -R1, -R3, -T2-BUDGET.",
    "**§ B:** the 56 lines of `data/fs112/fs112-c/ledger-b-draft.md`, after FS-110's (`--strict` PASS on a scratch copy, 1,003 theorems; grade cells in\n"
    "FS110-X's compact form). Stage 1b (FS112-C2) set the grade cells of FS112-Y3-PIN, -END-AB, -END-NEEDS, -R1, -R3, -T2-BUDGET, restated -END-NEEDS, and\n"
    "added FS112-BOWTIE, FS112-C-HORNEND and FS112-C-DOUBLE (row 135) and C-ENDS's residue.")

# bibliography
rep("pp. 194–195, 197–200 read by FS112-YB (inventory item 55)\".",
    "pp. 194–195, 197–200 read by FS112-YB (inventory item 55), pp. 194, 197–200 re-read by FS112-YB3\".")
rep("colour pattern (FS112-P, Y, YB, YB2); the strip rebuilt",
    "colour pattern (FS112-P, Y, YB, YB2; p. 8 re-read by YB3); the strip rebuilt")

# FRONTIER-STUBS row 2
rep("(b″) are finite stuck chains bounded in length? N3-ALPH; candidate route FS112-N3-END (each finite end anchored at a four-colour vertex) with FS112-Y3-END-NEEDS |",
    "(b″) are finite stuck chains bounded in length? N3-ALPH; and the single-vertex end bounded by unit arcs on both sides, realised locally (FS112-BOWTIE): does it live in a valid map? Candidate route FS112-C-HORNEND (a horn bound `±1` on both horns only at such a single vertex; FS112-Y3-END-NEEDS as corrected) with FS112-N3-END and FS112-C-DOUBLE |")

# instances
rep("strip's colourless cone), none in round 3 on the proof side.",
    "strip's colourless cone), in round 3 none on the proof side and one on the construction side (YB3's D1: Y3-END-NEEDS FALSE as stated, by an exact\n"
    "  fragment).")
rep("The two sides met at one object without\n"
    "  contact — N3-COR3 is the positives' stop — and the combination (C-PARTNERS) was the close's.\"",
    "The two sides met twice without\n"
    "  contact — N3-COR3 is the positives' stop, and YB3's BOWTIE, built blind against Y3, is N3-END's doubly bounded one-vertex chain in N3's first\n"
    "  description — and the combinations (C-PARTNERS; C-HORNEND, C-DOUBLE) were the close's. The close planner was replaced at about 799k before YB3\n"
    "  reported; its successor (FS112-C2) folded YB3 in as stage 1b.\"")
rep("the stuck ray, Y3-END-NEEDS, the pinned corner and BUDGET2 counterexample invariants. Two flips: the\n"
    "  chain's end read as what every end carries (N3-END), and the pinned corner read as what every valid map carries at both corners (C-PARTNERS).\"",
    "the stuck ray, Y3-END-NEEDS, the pinned corner and BUDGET2 counterexample invariants. Two flips: the\n"
    "  chain's end read as what every end carries (N3-END), and the pinned corner read as what every valid map carries at both corners (C-PARTNERS).\n"
    "  A wall broken by an example: Y3-END-NEEDS (what a terminal chain end must carry) fell to FS112-BOWTIE, which its blind verifier built by asking what\n"
    "  configuration its own derivation's exception names.\"\n"
    "- *§ Building (the slot line):* \"FS-112's round 3: Y3 and YB3 each started one run past two minutes without `scripts/slot.py` (Y3 §4.3 (1); YB3 stage 5\n"
    "  (1)); each was stopped by its id within minutes, confirmed gone, nothing written, and every later run was slotted.\"")

# protocol rule 14
rep("a verifier still running is folded in at a stage of its own, and its record stays unopened until the owner's message.\"",
    "a verifier still running is folded in at a stage of its own, and its record stays unopened until the owner's message; if the close planner is\n"
    "  replaced before it reports, a successor does that stage from the reconciliation (FS-112: FS112-C2).\"")

for o, n in E:
    c = t.count(o)
    if c != 1:
        print('COUNT', c, 'for:', o[:140]); sys.exit(1)
    if t.index(o) < start:
        print('OUTSIDE §R-close:', o[:100]); sys.exit(1)
    t = t.replace(o, n)
P.write_text(t)
print('applied', len(E))
