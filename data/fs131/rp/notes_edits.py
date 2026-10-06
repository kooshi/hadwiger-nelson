#!/usr/bin/env python3
"""FS131-RP1 — the docstring corrections (work list N1–N11), as data: every change is one entry below, applied to the
docstring of the named declaration only, and refused unless its old text is found exactly once there.

  notes_edits.py --dry    check every entry against the working tree, write nothing
  notes_edits.py          apply (refuses unless every entry matches)

`swap(file, decl, old, new)`  inside decl's docstring, `old` (whitespace-insensitive) → `new`
`add(file, decl, text)`       `text` appended to decl's docstring, on new lines, before its closing `-/`
`modline(file, old, new)`     inside the module docstring (the first `/-! … -/`), `old` → `new`
Drafted while Stage 3's build ran; applied only after it ended (no file is edited under a running build).
"""
import re
import sys
import textwrap
from pathlib import Path

ROOT = "Proofs/HadwigerNelson/Plane/"
V = ROOT + "ValidMap/"
W = ROOT + "Woodall/"
E7 = "`plans/FS131-E7-derivation.md`"
EDITS = []


KEEP = ("local hypotheses", "hypothesis by hypothesis", "a fragment")   # phrases FS131-QA4's notes check reads; never split by a line break


def wrap(s):
    s = " ".join(s.split())
    for k in KEEP:
        s = s.replace(k, k.replace(" ", "\u00a0"))
    return "\n".join(textwrap.wrap(s, width=138, break_long_words=False, break_on_hyphens=False)).replace("\u00a0", " ")


def swap(f, decl, old, new):
    EDITS.append(("swap", f, decl, old, new))


def add(f, decl, text):
    EDITS.append(("add", f, decl, None, text))


def modline(f, old, new):
    EDITS.append(("mod", f, None, old, new))


# ---------------------------------------------------------------------------------------------------------------- N1: FlankUA
def bow(params, thms, p5):
    return wrap(f"Inhabitant: no Lean model of all at once. `bowtie` at `0`{params} satisfies every hypothesis but `F.Covers 0 1` — the "
                f"local hypotheses ({thms}); `Covers` fails there by FS131-QA4's QA4-B1. At [hand] all hold on FS131-E7's `P₅` at its "
                f"stuck vertex{p5} (twelve colours; {E7} § 7): an open gate item until its Lean model lands.")


F = V + "FlankUA.lean"
swap(F, "not_outType_N_of_flankAbove_one",
     "Inhabitant of the hypotheses: `bowtie` at `0`, `α = 0` (`bowtie_flanks`, `bowtie_inType`: its `g` is in-type at `N = i`).",
     bow(", `α = 0`", "`bowtie_flanks`, `bowtie_inType`: its `g` is in-type at `N = i`", ", `α = 0`, `g = 7`"))
swap(F, "not_outType_S_of_flankBelow_neg_one",
     "Inhabitant of the hypotheses: `bowtie` at `0`, `α = 0` (`bowtie_flanks`, `bowtie_inType`: its `h` is in-type at `S′ = −i`).",
     bow(", `α = 0`", "`bowtie_flanks`, `bowtie_inType`: its `h` is in-type at `S′ = −i`", ", `α = 0`, `h = 8`"))
swap(F, "srcG_of_shadow",
     "Inhabitant of the hypotheses: `bowtie` at `0`, `α = 0` (`bowtie_flanks`; its tip is in the shadow of both flanks, `bowtie_doublyShadowed`).",
     bow(", `α = 0`, `κ₁ = −1`, `κ₂ = 1`", "`bowtie_flanks`; its tip is in the shadow of both flanks, `bowtie_doublyShadowed`",
         ", `α = 0`, `κ₁ = −1`, `κ₂ = 1`, `g = 7`"))
swap(F, "srcH_of_shadow",
     "Inhabitant of the hypotheses: `bowtie` at `0`, `α = 0` (`bowtie_flanks`, `bowtie_doublyShadowed`).",
     bow(", `α = 0`, `κ₁ = −1`, `κ₂ = 1`", "`bowtie_flanks`, `bowtie_doublyShadowed`", ", `α = 0`, `κ₁ = −1`, `κ₂ = 1`, `h = 8`"))
swap(F, "region_near_of_inType",
     "Inhabitant of the hypotheses: `bowtie` at `0` (`bowtie_inType`).",
     bow("", "`bowtie_inType`", ", `j = 7`, `w` its upper pole"))
swap(F, "flank_ne_of_shadows",
     "Inhabitant of the hypotheses: `bowtie` at `0`, `α = 0` (`bowtie_flanks`, `bowtie_doublyShadowed`; its flanks are `0` and `2`).",
     bow(", `α = 0`, `κ₁ = −1`, `κ₂ = 1`", "`bowtie_flanks`, `bowtie_doublyShadowed`; its flanks are `0` and `2`",
         ", `α = 0`, `κ₁ = −1`, `κ₂ = 1`, `g = 7`, `h = 8`"))
swap(F, "horn_poles_contact",
     "Inhabitant of the hypotheses: `bowtie` at `0` (`bowtie_not_merge_zero`, `bowtie_coloursAt_zero`, `bowtie_isHorn`).",
     bow("", "`bowtie_not_merge_zero`, `bowtie_coloursAt_zero`, `bowtie_isHorn`", ", `c = 9`, `m = 2`, `α = 0`, `κ₁ = −1`, `κ₂ = 1`"))
swap(F, "horn_bounds_of_noMerge",
     "Inhabitant of the hypotheses: `bowtie` at `0` (`bowtie_not_merge_zero`, `bowtie_isHorn`).",
     bow("", "`bowtie_not_merge_zero`, `bowtie_coloursAt_zero`, `bowtie_isHorn`", ", `c = 9`, `m = 2`, `α = 0`, `κ₁ = −1`, `κ₂ = 1`"))
swap(F, "horn_bounds_of_interior_empty",
     "that lemma's inhabitant, `bowtie` at `0`, satisfies these hypotheses too, by the example below.",
     wrap("that lemma's local hypotheses give these by the example below, so `bowtie` at `0` satisfies every hypothesis here but "
          f"`F.Covers 0 1` (FS131-QA4's QA4-B1): no Lean model of all at once. At [hand] all hold on FS131-E7's `P₅` at its stuck "
          f"vertex, `c = 9`, `α = 0`, `κ₁ = −1`, `κ₂ = 1` (the cone of `9` there lies in a line; twelve colours; {E7} § 7): an open "
          "gate item until its Lean model lands."))
swap(F, "hasSectors_one_of_contacts",
     "Inhabitant of the hypotheses: `bowtie` at `0` with `j = 0`, `u = i` (`bowtie_not_merge_zero`, `bowtie_inType`).",
     bow(" with `j = 0`, `u = i`", "`bowtie_not_merge_zero`, `bowtie_inType`; FS131-QA4 § 3.5's sample",
         ", `j = 7`, `u = i` (the one contact of `7` there is the upper pole, in-type)"))

# ---------------------------------------------------------------------------------------------------------------- N2: Terminal
T = V + "Terminal.lean"
swap(T, "stuck_flanks_ua",
     "Inhabitant of the hypotheses: `bowtie` at `0` (`bowtie_isStuck`, `bowtie_coloursAt_zero`), with the horns `stuck_horns_ua` gives there.",
     bow("", "`bowtie_isStuck`, `bowtie_coloursAt_zero`, with the horns `stuck_horns_ua` gives there",
         ", `α = 0`, `c = 9`, the four bounds `−1, 1, −1, 1`"))
swap(T, "stuck_structure_ua",
     "Inhabitant of the hypotheses: `bowtie` at `0` (`bowtie_isStuck`, `bowtie_coloursAt_zero`).",
     bow("", "`bowtie_isStuck`, `bowtie_coloursAt_zero`", ", `c = 9`, `m = 2`"))
swap(T, "chainVertex_antipodal",
     "Inhabitant of the hypotheses: `bowtie` at `0` (`bowtie_isStuck`, `bowtie_coloursAt_zero`).",
     bow("", "`bowtie_isStuck`, `bowtie_coloursAt_zero`", ""))
swap(T, "exists_horn_of_mem_coneAt_of_stuck",
     "Model of the hypotheses: `bowtie` at `0`, its colour `1`, `β = 0` (`bowtie_isStuck`, `bowtie_coloursAt_zero`, `bowtie_isHorn`).",
     bow(", its colour `1`, `β = 0`", "`bowtie_isStuck`, `bowtie_coloursAt_zero`, `bowtie_isHorn`",
         ", `g = 9`, `m = 2`, `β = 0` (the direction of its right horn)"))


def bowP(thms, p5):
    return wrap(f"Inhabitant: no Lean model of all at once. `bowtie` at `0` satisfies every hypothesis but `F.IsPlaneMap` — the local "
                f"hypotheses ({thms}); it is a fragment, not a map of the plane (FS131-QA4's QA4-B2). At [hand] all hold on FS131-E7's "
                f"`P₅` at its stuck vertex{p5} (twelve colours; {E7} § 7): an open gate item until its Lean model lands.")


swap(T, "upper_bounds_of_inType_N", "Inhabitant of the hypotheses: `bowtie` at `0`.",
     bowP("`bowtie_isStuck`, `bowtie_coloursAt_zero`, `bowtie_isHorn`, `bowtie_flanks`, `bowtie_inType`", ", `α = 0`, `c = 9`, `g = 7`"))
swap(T, "stuck_turned_frame", "Inhabitant of the hypotheses: `bowtie` at `0`.",
     bowP("`bowtie_isStuck`, `bowtie_coloursAt_zero`, `bowtie_isHorn`, `bowtie_flanks`", ", `α = 0`, `c = 9`, `g = 7`, `h = 8`"))
swap(T, "stuck_structure_at_axis", "Inhabitant of the hypotheses: `bowtie` at `0`.",
     bow("", "`bowtie_isStuck`, `bowtie_coloursAt_zero`, `bowtie_isHorn`", ", `c = 9`, `m = 2`, `α = 0`, `κ₁ = −1`, `κ₂ = 1`"))
swap(T, "horn_flanks_of_isChainVertex",
     "Inhabitant of the hypotheses: `bowtie` at `0` (`bowtie_isStuck`, `bowtie_coloursAt_zero`, `bowtie_isHorn`).",
     bow("", "`bowtie_isStuck`, `bowtie_coloursAt_zero`, `bowtie_isHorn`", ", `β = 0`, `a = −1`, `b = 1`, `d = 9`"))
swap(T, "horn_colour_eq_of_isChainVertex",
     "Inhabitant of the hypotheses: `bowtie` at `0` (`bowtie_isStuck`, `bowtie_coloursAt_zero`, `bowtie_isHorn`).",
     bow("", "`bowtie_isStuck`, `bowtie_coloursAt_zero`, `bowtie_isHorn`", ", its two horns (`β = 0`, `β' = π`, `d = d' = 9`)"))
swap(T, "eq_horn_colour_of_two_sectors",
     "Inhabitant of the hypotheses: `bowtie` at `0`, the horn's own colour.",
     bow(", the horn's own colour", "`bowtie_isStuck`, `bowtie_coloursAt_zero`, `bowtie_isHorn`", ", `d = j = 9`"))

# the stuck family's "no model … is known" (E7 § 7.5)
P5MAP = (f"FS131-E7's planted bowtie `P₅`, twelve colours ({E7} § 7) — a terminal valid map of the plane with one stuck vertex, of three "
         "colours")
swap(T, "cv_l0",
     "No model of a stuck vertex in a terminal valid plane map is known (`GENERIC`: FS-115's question); `bowtie` inhabits the local hypotheses on a fragment.",
     wrap(f"Inhabitant at [hand]: {P5MAP}; no Lean object yet (an open gate item). `bowtie` inhabits the local hypotheses on a "
          "fragment. At six colours the existence of one is FS-115's question, unchanged (`GENERIC`)."))
swap(T, "hornBoundsQR_of_isChainVertex",
     "No model of a chain vertex in a terminal valid plane map is known (`GENERIC`, FS-115); `bowtie` at `0` inhabits the local hypotheses on a fragment.",
     wrap(f"Inhabitant at [hand]: {P5MAP}, at that vertex and any `β`; no Lean object yet (an open gate item). `bowtie` at `0` "
          "inhabits the local hypotheses on a fragment. At six colours the existence of one is FS-115's question, unchanged "
          "(`GENERIC`)."))
add(T, "n3_end_chain",
    wrap(f"At [hand] every hypothesis holds on FS131-E7's `P₅` at its stuck vertex, `α = 0`, `c = 9`, `g = 7` (twelve colours; {E7} "
         "§ 7): no Lean object yet, an open gate item."))
for name in ("n3_end_four_colours", "n3_end_bothKind", "n3_end_of_not_inType"):
    swap(T, name, "A step inside a refutation-shaped row: no model expected.",
         wrap("A step inside a refutation-shaped row: no model expected. The hypotheses without `hno` hold at [hand] on FS131-E7's "
              f"`P₅` at its stuck vertex (`α = 0`, `κ₂ = 1`, `c = 9`; twelve colours; {E7} § 7.5), whose upper flank is in-type at the "
              "upper pole, so `hno` fails there."))
swap(T, "horn_upper_ne_one",
     "No model of two neighbouring chain vertices in a terminal valid plane map is known (`GENERIC`, FS-115).",
     wrap("No model of two neighbouring chain vertices in a terminal valid plane map is known (`GENERIC`, FS-115): FS131-E7's `P₅`, "
          f"a terminal valid twelve-colour map of the plane at [hand] ({E7} § 7), has one chain vertex only."))
swap(T, "horn_lower_ne_neg_one", "No model known (`GENERIC`, FS-115).",
     "No model known (`GENERIC`, FS-115): as `horn_upper_ne_one`, FS131-E7's `P₅` has one chain vertex only.")
for name in ("c_ends", "run_ends"):
    swap(T, name, "No model of a stuck chain in a terminal valid plane map is known (`GENERIC`, FS-115).",
         wrap("No model at six colours is known (a terminal valid six-map of the plane with a stuck vertex: `GENERIC`, FS-115). At "
              f"twelve colours FS131-E7's `P₅` is a terminal valid map of the plane with one stuck vertex, at [hand] ({E7} § 7); it "
              "is not six-coloured, so it is no inhabitant of this statement."))

# ---------------------------------------------------------------------------------------------------------------- N3: UnitArc
U = V + "UnitArc.lean"
add(U, "a4six",
    wrap("Inhabitant of the hypotheses at six colours, at [hand] — no Lean object yet, an open gate item: FS131-E7's four-petal flower "
         f"`F₀` at `0` with `a = 4`, `b = 5` ({E7} § 3): both absent colours are carried on `ω(0)` and no ring point carries both; its "
         "ring arcs total `240°`. `sixFrag` relabelled into eight colours satisfies the letter at `0` only degenerately: the classes "
         "of the two absent colours are empty there (§ 3.6)."))
add(U, "straddlers_third",
    wrap("Inhabitant of the hypotheses at six colours, at [hand] — no Lean object yet, an open gate item: FS131-E7's `F₁`, the "
         "four-petal flower `F₀` with the rectangle `19/20 < Re < 21/20`, `−1/20 < Im < 0` recoloured `5`, at `v = 0`, `θ = −π/3`, "
         f"`X = 4`, `X' = 5` ({E7} § 4); the conclusion holds there with `i = 3`, `o = 1`, and `ω(y′)` carries no arc of `Γ`."))

# ---------------------------------------------------------------------------------------------------------------- N4: Contact
C = V + "Contact.lean"
add(C, "flank_ne_of_doublyShadowed",
    wrap("Inhabitant of the hypotheses, at [hand] — no Lean object yet, an open gate item: FS131-E7's `P₄`, nine colours — the "
         "seven-colour brick map with a `g`-flank and a `g`-horn at the lower pole, an `h`-flank and an `h`-horn at the upper pole "
         f"planted in fresh colours ({E7} § 6) — with `κ₁ = −1/2`, `κ₂ = 1/2`, band `(−1/8, 1/8)`."))
MOVE_GATE = "an open gate item until FS131-KM1's planted pictures land (FS131-QA4 § 3.3)"
add(C, "exists_merge",
    wrap("Inhabitant: none in Lean of the hypotheses at once — they are inhabited hypothesis by hypothesis only: `bowtie` and "
         "`cuspFrag` at `0` fail `F.Covers 0 1` (FS131-QA4's QA4-B1, QA4-B3), `bowtie` also `hD` (`bowtie_not_merge_zero`), and "
         "`sevenBrickMap` has no colour with two sectors. At [hand]: two wedges of one fresh colour planted at a point of one brick "
         f"of the seven-colour brick map; {MOVE_GATE}."))
add(C, "exists_rayMerge",
    wrap("Inhabitant: none in Lean of the hypotheses at once — no named map has two horns of one colour along one ray (`bowtie`'s "
         "lie along `0` and `π`, and it fails `F.Covers 0 1`: hypothesis by hypothesis only). At [hand]: two horn sets "
         "`hornSet v 0 (−1) (−1/2) r`, `hornSet v 0 (1/2) 1 r` in one fresh colour planted in one brick of the seven-colour brick "
         f"map; {MOVE_GATE}."))
add(C, "exists_shave",
    wrap("Inhabitant: none in Lean of the hypotheses at once — hypothesis by hypothesis only: `cuspFrag` at `0` satisfies all but "
         "`F.Covers 0 1` (FS131-QA4's QA4-B3), and `bowtie` at `0` fails `hclear` (`bowtie_not_shave_zero`) and `Covers`. At [hand]: "
         f"one fresh-coloured horn planted in a brick of the seven-colour brick map, both flanks the brick's colour; {MOVE_GATE}."))

# ---------------------------------------------------------------------------------------------------------------- N5: Moves
M = V + "Moves.lean"
for aux, head in (("exists_merge_aux", "exists_merge"), ("exists_rayMerge_aux", "exists_rayMerge"), ("exists_shave_aux", "exists_shave")):
    add(M, aux, wrap(f"Inhabitant: as `{head}` (`Plane/ValidMap/Contact`), whose hypotheses these are — none in Lean at once; a hand "
                     "model in FS131-QA4 § 3.3, an open gate item until FS131-KM1's planted pictures land."))

# ---------------------------------------------------------------------------------------------------------------- N6: BaseSteps
B = V + "BaseSteps.lean"
ONE = ("`sevenBrick_corner_isCubicTrichromatic` (`Plane/SVMap`) inhabits `IsCubicTrichromatic` alone, on a valid map of the plane "
       "where the other hypotheses cannot hold with it: `sevenBrickMap` has no unit arc and no four-colour point, so this theorem's "
       "conclusion is false there (FS131-QA4 § 4.1). The set is satisfiable only on a map with a unit arc ending at a cubic vertex.")
swap(B, "pair_ii",
     "Inhabitant of `IsCubicTrichromatic` on a valid map of the plane: `sevenBrick_corner_isCubicTrichromatic` (`Plane/SVMap`).",
     wrap("Inhabitant: none named for the hypotheses at once. " + ONE))
swap(B, "fail_leavingCentre",
     "Inhabitant of `IsCubicTrichromatic` on a valid map of the plane: `sevenBrick_corner_isCubicTrichromatic` (`Plane/SVMap`).",
     wrap("Inhabitant: none named for the hypotheses at once. " + ONE))
add(B, "fail_colours", wrap("Inhabitant: none named for the hypotheses at once. " + ONE))

# ---------------------------------------------------------------------------------------------------------------- N7
OPEN_BASE = ("Inhabitant: none named, and none is claimed — the hypotheses on the map are among the base's (`BaseCtx`, "
             "`Plane/ValidMap/BaseWalk`), which `row134BaseUA` refutes whole at six colours; whether those assumed here hold together "
             "on some valid six-coloured fragment is open. At seven colours the base's hypotheses hold on `sevenBrickMap` at its "
             "corner (`not_row134BaseUA_seven`), which is not six-coloured.")
H = V + "HexRing.lean"
add(H, "rot_out", wrap(OPEN_BASE))
add(H, "rot_in", wrap(OPEN_BASE))
MT = V + "MapTopology.lean"
add(MT, "exists_eleventh_of", wrap(OPEN_BASE))
add(MT, "exists_far_end", wrap(OPEN_BASE))
BD = V + "BaseDense.lean"
SIX = ("Inhabitant of the hypotheses: none at six colours is known (a valid six-map of the plane is FS-114's open question, "
       "`GENERIC`); the statement's class at seven colours is inhabited by `sevenBrickMap`, which is not six-coloured.")
swap(BD, "dense3", "No valid six-map of the plane is known (`GENERIC`).", wrap(SIX))
swap(BD, "cv_exists", "No valid six-map of the plane is known (`GENERIC`).", wrap(SIX))

# ---------------------------------------------------------------------------------------------------------------- N8: Woodall
REF = ("A refutation step: no model of the hypotheses is expected. Its background (`Valid`, `IsPlaneMap`; the normal form where it "
       "is assumed) is inhabited at seven colours by `sevenBrickMap_woodallModel` (`Plane/Woodall/Steps`).")
REFC = ("A refutation step: no model of the hypotheses is expected. The chain it serves has its background inhabited at seven "
        "colours by `sevenBrickMap_woodallModel` (`Plane/Woodall/Steps`); `not_woodall_step4_two_thirds` is the collars' control.")
add(W + "NoFourFive.lean", "SectorsAt.false_of_ncard_le_two_on_arc", wrap(REF))
add(W + "Steps.lean", "false_of_four_le_sectors", wrap(REF))
add(W + "Collar.lean", "woodall_step4", wrap(REFC))
add(W + "Collar.lean", "townsend_lemma", wrap(REFC))

# ---------------------------------------------------------------------------------------------------------------- N9: Limit
swap(V + "Limit.lean", "const",
     "the inhabitant of `LocalSeq`, every clause exercised.",
     wrap("the inhabitant of `LocalSeq`, a degenerate one — every step is idle, on the empty set, so the clauses about a step's "
          "support hold vacuously (FS131-QA4 § 4.3). A sequence with live steps is `exists_terminalSeq`'s (`Plane/ValidMap/Procedure`)."))

# ---------------------------------------------------------------------------------------------------------------- N10: module lines
modline(ROOT + "SVMap.lean",
        "* **The inhabitant**: `sevenBrickMap`, the brick seven-colouring of `Instances/Seven` (M36) as an arc map of the plane, valid.\n-/",
        "* **The inhabitant**: `sevenBrickMap`, the brick seven-colouring of `Instances/Seven` (M36) as an arc map of the plane, valid.\n"
        "  It is the model of every theorem here that assumes only `Valid` and `IsPlaneMap` — TS-T (`ts_t`, `ts_t_trichromatic`,\n"
        "  `ts_t_degree_three`) among them: `sevenBrickMap_valid`, `sevenBrickMap_isPlaneMap`, three colours and degree `3` at its corner\n"
        "  (`sevenBrick_corner_coloursAt`, `sevenBrick_corner_hasDegree`) (FS131-QA4 § 4.1; inventory ruling 427 (d), F2).\n-/")
modline(U,
        "* **FS112-A4SIX** (`a4six`); **FS112-NB4P** (`nb4p`).\n-/",
        "* **FS112-A4SIX** (`a4six`); **FS112-NB4P** (`nb4p`).\n\n"
        "**The model of the ring-arc theorems** (those assuming only `F.Valid` and `F.IsRingArc P θ₁ θ₂ c c'`: LOCK, N2-SIGN, L60-LE/EQ,\n"
        "N2-ENV, U1, ISO): `l60Frag` — `l60_real`: valid, `IsRingArc 0 0 (π / 3) 0 1`, an arc of exactly `60°` (FS131-QA4 § 4.1; inventory\n"
        "ruling 427 (d), F2). Theorems with further hypotheses carry their own note.\n-/")
modline(V + "Cone.lean",
        "`tools/fs131_im_move_cone.py --check` holds the text byte-identical to its source lines in `Contact` at `d4f946ae`.\n-/",
        "`tools/fs131_im_move_cone.py --check` holds the text byte-identical to its source lines in `Contact` at `d4f946ae`.\n\n"
        "**The model of the contact lemmas** (those assuming only `F.Valid`, `F.Covers v 1`, a contact and its cone): `sevenBrickMap`\n"
        "(`Plane/SVMap`) — valid (`sevenBrickMap_valid`), covering every disc (`covers_of_isPlaneMap` at `sevenBrickMap_isPlaneMap`); a\n"
        "contact there, at [hand]: a corner and the corner at distance `1` from it (FS131-QA4 § 4.1; inventory ruling 427 (d), F2). The\n"
        "lemmas about a cone with empty interior, a horn or a stuck vertex are not covered by this line: no Lean object satisfies their\n"
        "hypotheses with `Covers` (FS131-QA4 § 3.5).\n-/")
modline(MT,
        "  `ringArc_cases` (two short arcs of one circle are disjoint, nested, interleaved, or abut).\n-/",
        "  `ringArc_cases` (two short arcs of one circle are disjoint, nested, interleaved, or abut).\n\n"
        "**The model of the tile theorems** (E4-OUTERMOST, E4-RIM: those assuming only `F.Valid`, tiles of `F` and `EnclosesTile`): they\n"
        "are universal over the tiles of a valid map, and `sevenBrickMap` (`Plane/SVMap`) is one, with `UnenclosedC` at every point\n"
        "(`sevenBrick_unenclosedC`, `Plane/ValidMap/BrickMap`) (FS131-QA4 § 4.2; inventory ruling 427 (d), F2). The two base lemmas,\n"
        "`exists_eleventh_of` and `exists_far_end`, carry their own note.\n-/")

# ---------------------------------------------------------------------------------------------------------------- N11: Procedure
swap(V + "Procedure.lean", "exists_arcStep",
     "Inhabitant: no Lean model on file; `l60Frag` cleaned, its whole arc, at [hand] (FS131-QA4 § 6.2, rank 7).",
     wrap("Inhabitant: no Lean model on file. `l60Frag` cleaned, at its whole arc `r([0, π/3])`, satisfies the local hypotheses at "
          "[hand] (FS131-QA4 § 4.3: maximal by `l60_le`, the inner colour `0` carried at the centre and the outer `1` not, so neither "
          "(Q) nor (R2)); it is a fragment, and `hP`, a map of the plane, is not among them. A model of all at once is not on "
          "file: the plane-map model owed for the outward bend (`awayModel`, FS131-KM1's; inventory ruling 455 (a)) is the "
          "candidate, unchecked against this statement."))


# ================================================================================================================== the engine
def doc_span(t, decl):
    ms = list(re.finditer(r"^(?:@\[[^\]]*\]\s*)?(?:noncomputable )?(?:theorem|lemma|def|structure|abbrev) " + re.escape(decl) + r"(?![\w.'])", t, re.M))
    if len(ms) != 1:
        raise SystemExit(f"{decl}: {len(ms)} declarations of that name")
    j = t.rfind("-/", 0, ms[0].start())
    i = t.rfind("/--", 0, j)
    if i < 0 or t[j + 2:ms[0].start()].strip():
        raise SystemExit(f"{decl}: no docstring directly above it")
    return i, j + 2


def flex(old):
    return re.compile(r"\s+".join(re.escape(w) for w in old.split()))


def apply(dry):
    texts, n = {}, 0
    for kind, f, decl, old, new in EDITS:
        t = texts.get(f) or Path(f).read_text(encoding="utf-8")
        if kind == "mod":
            i = t.index("/-!")
            j = t.index("-/", i) + 2
            seg = t[i:j]
            if seg.count(old) != 1:
                raise SystemExit(f"{f} module doc: {seg.count(old)} matches of {old[:50]!r}")
            seg = seg.replace(old, new)
        else:
            i, j = doc_span(t, decl)
            seg = t[i:j]
            if kind == "swap":
                ms = flex(old).findall(seg)
                if len(ms) != 1:
                    raise SystemExit(f"{f} {decl}: {len(ms)} matches of {old[:60]!r}")
                seg = flex(old).sub(lambda _m: new, seg)
            else:
                if not seg.rstrip().endswith("-/"):
                    raise SystemExit(f"{f} {decl}: docstring does not end in -/")
                body = seg.rstrip()[:-2].rstrip()
                seg = body + "\n" + new + " -/"
        if "-/" in seg[:-2] or seg.count("/-") != 1:
            raise SystemExit(f"{f} {decl}: the edit would break the comment")
        texts[f] = t[:i] + seg + t[j:]
        n += 1
    if not dry:
        for f, t in texts.items():
            Path(f).write_text(t, encoding="utf-8")
    print(f"{'checked' if dry else 'applied'}: {n} edits in {len(texts)} files")


if __name__ == "__main__":
    apply("--dry" in sys.argv)
