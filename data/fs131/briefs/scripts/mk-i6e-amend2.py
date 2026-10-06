exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# Appends Amendment 2 to FS131-I6E's brief: the other half of its file is proved on another branch (run once).
B=ROOT+"data/fs131/briefs/FS131-I6E-wave6-bridge.md"
P=WT+"fs131-w6f/Proofs/HadwigerNelson/Plane/Saturated/"
s=open(B).read()
assert "## Amendment 2" not in s
a=f'''

## Amendment 2 (2026-10-06, mid-job) — the other half of your file is proved; a merge you may make

Nothing above is withdrawn. The implementer of `FanBridge`'s existence half (FS131-I6D, inventory item 540) has handed back on
`origin/fs131-w6f` at `8e81fedd`: its seven leaves are proved with no statement changed, in four new modules beside your file and seven
proof bodies inside it; your five leaves are untouched there.

1. **Names proved on that branch — never declare one of them again**: `isOpen_polarRegion`, `isPreconnected_polarRegion`,
   `polarRegion_nonempty`, `isPreconnected_polarGraph`, `polarPt_norm_arg`, `polarPt_eq_polarPt`, `polarPt_add_int`, `polarGraph_sub_int`,
   `polarRegion_disjoint_polarGraph`, `IsUnitCurve.affine`, `IsUnitCurve.sin_le_dist`, `IsUnitCurve.sin_abs_le_dist`, `IsUnitCurve.dist_le`,
   `IsUnitCurve.injOn_of_abs_le`, `IsUnitCurve.continuousOn`, `IsUnitCurve.abs_angle_sub_le`, `IsUnitCurve.reparam`, `angleCurve`,
   `AeColouring.arcSetting_of_isolated`, `AeColouring.exists_arc_of_isolated`, `AeColouring.polarGraph_of_curve_from_center`. If you have
   already declared one of these names, rename yours before your next push and say so.
2. **Its author's note for your line**: `Fan.branch_outside_discs` and `Fan.branch_contacts` want exactly the last three —

{Q(P+"FanArcs.lean","theorem arcSetting_of_isolated ")}
{Q(P+"FanArcs.lean","theorem exists_arc_of_isolated ")}
{Q(P+"FanArcs.lean","theorem polarGraph_of_curve_from_center ")}
3. **A merge you may make, at a saved stage of your choosing**: `git merge --no-edit 8e81fedd` into your branch — the one merge this brief
   allows beyond its fast-forward. It adds the four modules, edits the other half of the file you prove in (your five leaves are in
   regions it does not touch), the module of the fan's examples, and the three registry files (keep both sides where they meet your block). After it:
   the build, `./scripts/dupnames.sh`, your statement check. **It is yours to decide**: if you are past the two leaves that want these
   facts, or close to done, do not merge — take the facts you need as hypotheses under names of your own, or cite nothing — and say which
   you did in your report. Either way the wave's join makes one declaration of each.
'''
open(B,"w").write(s.rstrip("\n")+a)
print("amended")
