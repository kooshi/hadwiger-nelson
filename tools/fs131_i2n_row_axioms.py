#!/usr/bin/env python3
"""FS131-I2n: read each wave-2 row's declarations' axioms from a saved `scripts/axioms.sh` log.

usage: fs131_i2n_row_axioms.py LOG            print one line per row: row, declaration, axioms
       fs131_i2n_row_axioms.py LOG --self-test plant an unaudited name and a sorryAx line; both must be reported

Fails (exit 1) when a declaration has no `#print axioms` line in the log (an unaudited row declaration), or when any line
names `sorryAx`. The row-to-declaration table is `plans/FS131-w2-kernel-plan.md` §§ 4.1 and 7.3.
"""
import re, sys

ROWS = [
 ("FS111-C-FILL", ["AeColouring.exists_fill"]),
 ("FS111-M-SATC", ["exists_isMaximalCover", "IsMaximalCover.interior_union_unitShadow", "IsAdmissible.exists_aeColouring"]),
 ("FS111-M2-COV", ["isMaximalCover_iff"]),
 ("FS111-M2-FIX", ["IsRegularMUA.interior_eq_compl_unitShadow", "IsRegularMUA.component_side"]),
 ("FS111-M-COVER-SC", ["enclosing_or_exterior", "curvatureLeOne", "semiconcaveWith", "not_forall_semiconcaveWith_one"]),
 ("FS121-D3-GRUNDY", ["exists_grundy"]),
 ("FS111-V0-RESCALE", ["AeColouring.exists_tight", "exists_tight_iff_chiM0_le"]),
 ("FS129-SR2-SUPK", ["tendsto_mu", "tendsto_muTile", "tendsto_muPer"]),
 ("FS106-EQ", ["chiM0_le_iff_muZero_eq_one", "chiM0_le_iff_chiCP_le", "muZero_eq_one_iff_tendsto", "chiM0_le_iff_periodic",
               "seven_le_chiM0_iff"]),
 ("FS106-COMP", ["forall_mu_six_lt_one_iff"]),
 ("FS106-REM", ["keptAt_band", "CPColouring.tendsto_not_kept", "exists_not_uniform_kept"]),
 ("FS121-D4-FACE", ["face", "face_densitySet"]),
 ("FS121-V5-FACE-SHARP", ["exists_face_fails"]),
 ("FS129-OA1-NOPERLAW", ["exists_discrete_forcedSet", "forcedSet_eq_zero"]),
 ("FS129-SA1-FALC-RED", ["falconer_reduction", "le_chiM_of_falconerFan"]),
 ("FS116-O1-YESLIM", ["chiM0_le_of_fragments", "chromaticNumber_plane_le_six_of_fragments", "chromaticNumber_plane_le_chiM0"]),
 ("FS129-SA1-PLACE-HOM", ["exists_placeHom"]),
 ("FS129-SA1-NOAFF-FIELDS", ["noAffine_fields"]),
 ("FS129-SA1-FALC-RES", ["falconerFan_five_field", "falconerFan_five_placeHom"]),
 ("FS129-MA2-FALC-HOSTS", ["not_falconerFan_five_of_fanGap", "falconerFan_five_mem_eight", "falconerFan_five_mem_P"]),
 ("FS129-SA1-SQRT3-LOCAL", ["sqrt3_local", "sqrt3_local_of_congr", "sqrt3_dyadic"]),
 ("FS111-W-SQ9", ["sq9_tight_saturated"]),
 ("FS111-M-R7", ["exists_r7", "r7_boundary"]),
 ("FS111-M2-DISC7", ["disc7_isMaximalCover", "disc7_isRegularMUA", "disc7_lens", "disc7_upperDensity", "disc7_sum_upperDensity"]),
 ("FS111-M3-BAND", ["IsMUA.add_normal_mem_essSupport", "band_excludes_horn", "le_one_of_band_unitFree", "vesica_apex",
                    "vesica_apex_exact"]),
 ("FS111-M3-HC", ["hc_isRegularMUA", "hc_band_components"]),
 ("FS111-M3-IRREG", ["hc_irreg", "not_forall_isRegularMUA"]),
 ("FS111-M3-FIXCONV", ["not_forall_fix_converse"]),
]

def axioms_of(text):
    out = {}
    for m in re.finditer(r"'([^']+)' (depends on axioms: \[([^\]]*)\]|does not depend on any axioms)", text):
        out[m.group(1)] = " ".join(m.group(3).split()) if m.group(3) is not None else ""
    return out

def report(text, rows):
    ax = axioms_of(text)
    bad = 0
    for row, decls in rows:
        for d in decls:
            hits = [n for n in ax if n == d or n.endswith('.' + d)]
            if len(hits) != 1:
                print(f"MISSING {row} {d}: {len(hits)} audited records match"); bad += 1; continue
            a = ax[hits[0]]
            if 'sorryAx' in a:
                print(f"SORRY {row} {hits[0]} [{a}]"); bad += 1; continue
            print(f"{row}  {hits[0]}  [{a}]")
    return bad

def main():
    text = open(sys.argv[1]).read()
    if len(sys.argv) > 2 and sys.argv[2] == '--self-test':
        planted = text + "\n'HadwigerNelson.Plane.fs131_i2n_planted' depends on axioms: [propext, sorryAx]\n"
        b1 = report(planted, [("PLANT-SORRY", ["fs131_i2n_planted"])])
        b2 = report(text, [("PLANT-MISSING", ["fs131_i2n_no_such_declaration"])])
        b3 = report(text, ROWS[:1])
        ok = b1 == 1 and b2 == 1 and b3 == 0
        print("SELF-TEST", "OK" if ok else "FAIL", f"(sorry plant {b1}, missing plant {b2}, faithful partner {b3})")
        sys.exit(0 if ok else 1)
    bad = report(text, ROWS)
    print("RESULT", "PASS" if bad == 0 else f"FAIL ({bad})")
    sys.exit(1 if bad else 0)

main()
