#!/usr/bin/env python3
"""FS131-MC1 — the docstring lines that name the example maps on the landed theorems they serve.

Each edit is (module under Plane/ValidMap, declaration, pattern, replacement): the pattern is matched inside that declaration's
docstring and nowhere else (spaces in it match any whitespace), exactly once, or the tool stops. Nothing outside a docstring is
touched: after writing, the tool re-reads every edited file with its docstrings blanked and compares with the original so blanked.

  fs131_mc_docs.py --check     report what would change, write nothing
  fs131_mc_docs.py --apply     write the edits
  fs131_mc_docs.py --self-test a pattern that matches twice, one that matches nowhere, and an edit outside a docstring are each refused
"""
import os, re, sys, textwrap

V = "Proofs/HadwigerNelson/Plane/ValidMap/"
APPL = "`Plane/Models/Applied`"

STUCK_E1 = (r"Inhabitant: no Lean model of all at once\. ",
            "Inhabitant: `stuckModel` at `plantPt` (`Plane/Models/Stuck`, `stuckModel_hyps`), a map of the plane; among the fragments, ")
STUCK_E2 = (r"At \[hand\] all hold on FS131-E7's `P₅` at its stuck vertex(?P<par>(?:(?!\(twelve|\(the cone).)*?) ?"
            r"\((?P<pre>(?:the cone of `9` there lies in a line; )?)twelve colours; `plans/FS131-E7-derivation\.md` § 7\): "
            r"an open gate item until its Lean model lands\.")


def stuck_e2(m):
    par = m.group("par").rstrip()
    pre = " (the cone of `9` there lies in a line: `stuckModel_interior_allowedCone`)" if m.group("pre") else ""
    return ("On `stuckModel`" + par + pre + ": " + APPL + " applies this theorem to it, every hypothesis a named fact about the map. "
            "The map is FS131-E7's `P₅` (twelve colours; `plans/FS131-E7-derivation.md` § 7) with squares for the "
            "discs at its poles.")


SERVED = [("FlankUA", n) for n in ("not_outType_N_of_flankAbove_one not_outType_S_of_flankBelow_neg_one srcG_of_shadow srcH_of_shadow "
                                   "region_near_of_inType flank_ne_of_shadows horn_poles_contact horn_bounds_of_noMerge").split()] + \
         [("Terminal", n) for n in ("stuck_flanks_ua stuck_structure_ua chainVertex_antipodal exists_horn_of_mem_coneAt_of_stuck "
                                    "upper_bounds_of_inType_N stuck_turned_frame stuck_structure_at_axis horn_flanks_of_isChainVertex "
                                    "horn_colour_eq_of_isChainVertex eq_horn_colour_of_two_sectors").split()]

EDITS = []
for mod, n in SERVED:
    EDITS.append((mod, n, STUCK_E1[0], STUCK_E1[1]))
    EDITS.append((mod, n, STUCK_E2, stuck_e2))
EDITS += [
    ("FlankUA", "horn_bounds_of_interior_empty", r"\(FS131-QA4's QA4-B1\): no Lean model of all at once\.",
     "(FS131-QA4's QA4-B1). Inhabitant: `stuckModel` at `plantPt` (`Plane/Models/Stuck`, `stuckModel_hyps`), a map of the plane."),
    ("FlankUA", "horn_bounds_of_interior_empty", STUCK_E2, stuck_e2),
    ("FlankUA", "hasSectors_one_of_contacts", STUCK_E2,
     lambda m: "At [hand] all hold on FS131-E7's `P₅` at its stuck vertex" + m.group("par").rstrip() +
     " (twelve colours; `plans/FS131-E7-derivation.md` § 7). In Lean that map is `stuckModel` (`Plane/Models/Stuck`), which meets every "
     "hypothesis but `hcont`: four of its contacts are stated (`stuckModel_contacts`), and that `7` has no other is not proved — an open "
     "gate item."),
    ("Terminal", "n3_end_chain",
     r"\(twelve colours; `plans/FS131-E7-derivation\.md` § 7\): no Lean object yet, an open gate item\.",
     "(twelve colours; `plans/FS131-E7-derivation.md` § 7). In Lean that map is `stuckModel` (`Plane/Models/Stuck`), which meets every "
     "hypothesis but `hT : F.Terminal` (`stuckModel_hyps`; checked by elaboration in " + APPL + "): `stuckModel.Terminal` is not proved "
     "— an open gate item."),
    ("Terminal", "cv_l0", r"; no Lean object yet \(an open gate item\)\.",
     ". In Lean that map is `stuckModel` (`Plane/Models/Stuck`), which meets every hypothesis but `hM : F.IsTerminalMap` "
     "(`stuckModel_hyps`, `stuckModel_ncard`; checked by elaboration in " + APPL + "): of its four clauses `Terminal` and `QROnly` are not "
     "proved for it — an open gate item."),
    ("Terminal", "hornBoundsQR_of_isChainVertex", r"; no Lean object yet \(an open gate item\)\.",
     ". In Lean that map is `stuckModel` (`Plane/Models/Stuck`), which meets every hypothesis but `hM : F.IsTerminalMap` "
     "(`stuckModel_isChainVertex`; checked by elaboration in " + APPL + "): of its four clauses `Terminal` and `QROnly` are not proved "
     "for it — an open gate item."),
    ("Contact", "exists_shave", r"Inhabitant: none in Lean of the hypotheses at once.*?\(FS131-QA4 § 3\.3\)\.",
     "Inhabitant: `hornModel` at `plantPt` (`Plane/Models/Moves`, `hornModel_shave`: this theorem applied) — a valid map of the plane with "
     "one horn of a spare colour in a brick of the seven-colour brick map. Both flanks are the brick's colour, so every split `σ` is "
     "admissible there, and the bounds `∓1/2` are strictly inside `(−1, 1)`: the unit-arc case is not exercised. Among the fragments, "
     "hypothesis by hypothesis only: `cuspFrag` at `0` satisfies all but `F.Covers 0 1` (FS131-QA4's QA4-B3), and `bowtie` at `0` fails "
     "`hclear` (`bowtie_not_shave_zero`) and `Covers`."),
    ("Contact", "exists_rayMerge", r"Inhabitant: none in Lean of the hypotheses at once.*?\(FS131-QA4 § 3\.3\)\.",
     "Inhabitant: `twoHornModel` at `plantPt` (`Plane/Models/Moves`, `twoHornModel_rayMerge`: this theorem applied): two horns of one "
     "spare colour along `e 0` in a brick of the seven-colour brick map, curvatures `−3/4, −1/2` and `1/2, 3/4`; the outer bounds are "
     "strictly inside `[−1, 1]`. Among the fragments none (`bowtie`'s horns lie along `0` and `π`, and it fails `F.Covers 0 1`: "
     "hypothesis by hypothesis only)."),
    ("Contact", "exists_merge", r"Inhabitant: none in Lean of the hypotheses at once.*?\(FS131-QA4 § 3\.3\)\.",
     "Inhabitant: `twoHornModel` at `plantPt` (`Plane/Models/Moves`, `twoHornModel_merge`: this theorem applied), `n = 1`: the colour's "
     "two sectors are horns and its cone a half-plane (`twoHornModel_allowedCone`); a model whose two sectors are wedges of positive "
     "angle is not written. Among the fragments, hypothesis by hypothesis only: `bowtie` and `cuspFrag` at `0` fail `F.Covers 0 1` "
     "(FS131-QA4's QA4-B1, QA4-B3), `bowtie` also `hD` (`bowtie_not_merge_zero`), and `sevenBrickMap` has no colour with two sectors."),
    ("Contact", "flank_ne_of_doublyShadowed", r"Inhabitant of the hypotheses, at \[hand\] — no Lean object yet, an open gate item:.*?band `\(−1/8, 1/8\)`\.",
     "Inhabitant of the hypotheses: `shadowModel` (`Plane/Models/Stuck`, `shadowModel_flank_ne`: this theorem applied) — the brick map in "
     "nine colours with a flank of `7` above and of `8` below a band at `plantPt`, a horn of `7` at the lower pole and of `8` at the upper "
     "(FS131-E7's `P₄`, `plans/FS131-E7-derivation.md` § 6), `κ₁ = −1/2`, `κ₂ = 1/2`, band `(−1/8, 1/8)`: every hypothesis holds on it at "
     "once, each shadow from a live class (`shadowModel_shadow`)."),
    ("Moves", "exists_shave_aux", r"— none in Lean at once; a hand model in FS131-QA4 § 3\.3, an open gate item until FS131-KM1's planted pictures land\.",
     ": `hornModel` at `plantPt` (`Plane/Models/Moves`; this form applied to it in " + APPL + ")."),
    ("Moves", "exists_rayMerge_aux", r"— none in Lean at once; a hand model in FS131-QA4 § 3\.3, an open gate item until FS131-KM1's planted pictures land\.",
     ": `twoHornModel` at `plantPt` (`Plane/Models/Moves`; this form applied to it in " + APPL + ")."),
    ("Moves", "exists_merge_aux", r"— none in Lean at once; a hand model in FS131-QA4 § 3\.3, an open gate item until FS131-KM1's planted pictures land\.",
     ": `twoHornModel` at `plantPt` (`Plane/Models/Moves`; this form applied to it in " + APPL + ")."),
    ("OpenMove", "exists_open", r"none in Lean yet\. FS131-E6's model \(`plans/FS131-E6-derivation\.md` § 3\.1–3\.3: a valid plane map in twelve colours.*?and is not formalized\.",
     "`hornModel` at `plantPt` (`Plane/Models/Moves`, `hornModel_open`: this theorem applied): a lone horn of colour `7`, `D₇` the closed "
     "half-plane of its one in-type contact (`hornModel_contact`, the cone itself `hornModel_allowedCone`), degree `2`, one horn. "
     "FS131-E6's twelve-colour map (`plans/FS131-E6-derivation.md` §§ 3.1–3.3: `IsHorn 0 0 0 2 c`, degree `3`, one horn) is the hand model "
     "in which SHAVE has only the unit split; it is not formalized."),
    ("BendStep", "bend_away_part", r"Model of the hypotheses: none in Lean yet;.*?\(open gate item, ruling 419 \(d\)\)\.",
     "Model of the hypotheses: `awayModel` (`Plane/Models/Bends`, `awayModel_hyps`: the five at once, `P = awayP`, `c = 7`, `c' = 0`; this "
     "theorem applied to it: " + APPL + ", `awayModel_bend_away_part`), a map of the plane whose radius-2 contacts are the interval "
     "`[−arcsin (3/20), arcsin (3/20)]` strictly inside the arc's angles (`awayModel_r2Contacts`): two gaps and a contact piece. An "
     "isolated contact is not exercised (`isoFrag`, FS112-ISO, a fragment, is the hand model of one)."),
    ("BendStep", "bend_away_subdiv", r"Inhabitant of the hypotheses: owed with `bend_away_part`'s model \(`plans/FS131-bendaway-kernel-plan\.md` § 5\)\.",
     "Inhabitant of the hypotheses: `awayModel` with the subdivision of its arc that `exists_r2Subdiv` gives (" + APPL +
     " applies this theorem to them)."),
    ("BendGap", "bend_away_gap", r"Inhabitant of the hypotheses: owed with the away bend's model \(plan § 5; on a fragment,",
     "Inhabitant of the hypotheses: `awayModel` on the sub-arc `[1/5, 3/10]`, inside a gap of its radius-2 contacts (" + APPL +
     ": `awayModel_gap`, `awayModel_isRingArc_gap`, this theorem applied; on a fragment,"),
    ("BendGap", "exists_lensOut_clear", r"Inhabitant of the hypotheses: owed with the away bend's model \(plan § 5\)\.",
     "Inhabitant of the hypotheses: `awayModel` on the sub-arc `[1/5, 3/10]`, inside a gap of its radius-2 contacts (" + APPL +
     ": `awayModel_gap`, this theorem applied)."),
    ("R2Cap", "r2_side_dichotomy", r"Inhabitant of the hypotheses: owed with the away bend's model \(plan § 5\)\.",
     "Inhabitant of the hypotheses: `awayModel` on its arc of `ω(awayP)`, at the angle `0` (`Plane/Models/Bends`, `awayModel_hyps`; this "
     "theorem applied to it in " + APPL + ")."),
    ("R2Cap", "exists_r2Subdiv", r"Inhabitant of the hypotheses: owed with the away bend's model\.",
     "Inhabitant of the hypotheses: `awayModel` on its arc of `ω(awayP)` (`Plane/Models/Bends`, `awayModel_hyps`; this theorem applied "
     "to it in " + APPL + ")."),
    ("Procedure", "exists_vertexStep",
     r"FS131-E6's twelve-colour map \(derivation §§ 3\.1–3\.3\) satisfies them at \[hand\] grade, as `exists_open`'s note says\.",
     "`hornModel` at `plantPt` (`Plane/Models/Moves`) meets every one but `hc` — `IsClean` is not proved for it (checked by elaboration "
     "in " + APPL + "); FS131-E6's twelve-colour map (derivation §§ 3.1–3.3) satisfies them at [hand] grade, as `exists_open`'s note says."),
    ("MapGraph", "cvb_hole_disconnected",
     r"Whether a valid plane map with a holed tile exists is not claimed \(the row: \"every valid map cannot be refuted by an object\"\); the local configuration is `exists_holed_valid_fragment`\. `GENERIC` on plane maps\.",
     "The row does not claim that a valid plane map with a holed tile exists (\"every valid map cannot be refuted by an object\"); the "
     "local configuration is `exists_holed_valid_fragment`. `GENERIC` on plane maps. Inhabitant of the hypotheses, at eight colours: "
     "`hornModel` with its tile `holedTile` and the hole `tangentDisc` (`Plane/Models/Moves`, `hornModel_holedTile`; this theorem applied "
     "to it: " + APPL + ", `hornModel_hole_disconnected`)."),
    ("UnitArc", "bend_away_whole", r"from the compact `R₂\(ᾱ\)`\.",
     "from the compact `R₂(ᾱ)`. **Inhabitant**: on a map of the plane, `awayModel`'s sub-arc over `[1/5, 3/10]`, in a gap of its radius-2 "
     "contacts (" + APPL + ", `awayModel_bend_away_whole`: this theorem applied); on a fragment, `cuspFrag`'s arc of `ω(i)` "
     "(`Plane/Models/Bends`, `cuspFrag_bend_away`), whose centre is off the fragment and carries no colour — a model of the hypotheses' "
     "letter."),
    ("UnitArc", "bend_toward", r"and the outer one only inside `B̄\(P, 1\)` near the arc\.",
     "and the outer one only inside `B̄(P, 1)` near the arc. **Inhabitant**: on a map of the plane, `awayModel`'s arc "
     "(`Plane/Models/Bends`, `awayModel_bend_toward`: this theorem applied), whose centre carries `6` and neither side colour "
     "(`awayModel_coloursAt`); on a fragment, `cuspFrag`'s arc of `ω(i)` (`cuspFrag_bend_toward`), whose centre carries no colour."),
]

DOC = re.compile(r"/--.*?-/", re.S)


def blank(src):
    return DOC.sub("/-- -/", src)


def flex(pat):
    return re.compile(pat.replace(" ", r"\s+"), re.S)


def apply_one(src, name, pat, rep):
    m = re.search(r"^(?:theorem|def|structure) " + re.escape(name) + r"(?![\w.'])", src, re.M)
    if not m:
        raise SystemExit(f"NOT FOUND declaration {name}")
    end = src.rfind("-/", 0, m.start()) + 2
    start = src.rfind("/--", 0, end)
    if src[end:m.start()].strip():
        raise SystemExit(f"no docstring directly above {name}")
    doc = src[start:end]
    ms = list(flex(pat).finditer(doc))
    if len(ms) != 1:
        raise SystemExit(f"pattern matches {len(ms)} times in the docstring of {name}: {pat[:60]}")
    k = ms[0]
    new = rep(k) if callable(rep) else rep
    # the replacement starts a line of its own when it is long, wrapped at 138 columns; what followed the match stays after it
    col = k.start() - (doc.rfind("\n", 0, k.start()) + 1)
    body = textwrap.fill(new, 138, initial_indent=" " * col, break_long_words=False, break_on_hyphens=False)[col:]
    doc2 = doc[:k.start()] + body + doc[k.end():]
    return src[:start] + doc2 + src[end:]


def run(write, edits=EDITS, root="."):
    files = {}
    for mod, name, pat, rep in edits:
        p = os.path.join(root, V + mod + ".lean")
        if p not in files:
            files[p] = [open(p).read(), None]
            files[p][1] = files[p][0]
        files[p][1] = apply_one(files[p][1], name, pat, rep)
    for p, (old, new) in files.items():
        if blank(old) != blank(new):
            raise SystemExit(f"an edit left a docstring in {p}")
        print(f"{p}: {'changed' if old != new else 'unchanged'}")
        if write and old != new:
            open(p, "w").write(new)
    print(f"{len(edits)} edits in {len(files)} files" + (" written" if write else " (check only)"))


def self_test():
    src = "/-- alpha beta. beta. -/\ntheorem t : True := trivial\n\n/-- gamma. -/\ntheorem u : True := trivial\n"
    out = []
    for nm, pat in (("t", r"beta\."), ("t", r"delta"), ("u", r"alpha")):
        try:
            apply_one(src, nm, pat, "x"); out.append("ACCEPTED")
        except SystemExit as ex:
            out.append("refused")
    ok1 = out == ["refused", "refused", "refused"]
    good = apply_one(src, "u", r"gamma\.", "eta.")
    ok2 = blank(good) == blank(src) and "eta." in good
    ok3 = blank(src.replace("True := trivial", "False := trivial", 1)) != blank(src)
    print("twice / nowhere / another declaration's text:", out, "| faithful edit kept:", ok2, "| an edit outside a docstring is seen:", ok3)
    print("self-test:", "OK" if ok1 and ok2 and ok3 else "FAIL")
    return 0 if ok1 and ok2 and ok3 else 1


if __name__ == "__main__":
    if "--self-test" in sys.argv:
        sys.exit(self_test())
    run("--apply" in sys.argv)
