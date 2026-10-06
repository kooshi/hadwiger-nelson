p='Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean'
s=open(p).read()
def rep(a,b):
    global s
    assert s.count(a)==1, (s.count(a), a[:70])
    s=s.replace(a,b)
# inhabitant notes (LEAN.md § The gate): one line per theorem whose hypotheses no Lean object on file satisfies
rep("""only: `RayConfig.exists_merge`'s hypothesis `hfree` is not read, so the two given horns serve as they are. -/
theorem RayConfig.exists_step""",
"""only: `RayConfig.exists_merge`'s hypothesis `hfree` is not read, so the two given horns serve as they are. Inhabitant: none in
Lean (as `exists_rayStep`, which supplies the hypotheses from two horns of one colour along one ray). -/
theorem RayConfig.exists_step""")
rep("""does the sector before that one; the `σ`-arc ends at the rim, its continuation interior to the horn (`not_isSite_of_chart`). -/
theorem exists_shaveStep_aux""",
"""does the sector before that one; the `σ`-arc ends at the rim, its continuation interior to the horn (`not_isSite_of_chart`).
Inhabitant: none in Lean (as `exists_shaveStep`, which supplies the hypotheses from a horn with its two flanks). -/
theorem exists_shaveStep_aux""")
rep("""gap's first germ. Neither the gap's freedom from `c`-sectors nor `a + 1 < b` is read. -/
theorem exists_mergeStep_aux""",
"""gap's first germ. Neither the gap's freedom from `c`-sectors nor `a + 1 < b` is read. Inhabitant: none in Lean (as
`exists_mergeStep`, which supplies the hypotheses from `Near.exists_gap`). -/
theorem exists_mergeStep_aux""")
rep("""partial sector (`mem_open_interiorPts_of_mem`). -/
theorem exists_openStep_aux""",
"""partial sector (`mem_open_interiorPts_of_mem`). Inhabitant: none in Lean (as `exists_openStep`, which supplies the configuration
from `Near.exists_openConfig`). -/
theorem exists_openStep_aux""")
rep("""`IsModification`'s colour clause read off the disc by locality, at `v` by the surgery's clause, elsewhere in the disc by the bound
three. -/
theorem surgery_step""",
"""`IsModification`'s colour clause read off the disc by locality, at `v` by the surgery's clause, elsewhere in the disc by the bound
three. Inhabitants of the hypotheses: each of the four cases' constructions (`Near.RayConfig.exists_step`,
`Near.exists_shaveStep_aux`, `Near.exists_mergeStep_aux`, `Near.exists_openStep_aux`), on maps with no Lean model on file. -/
theorem surgery_step""")
rep("""circle or of that branch off the arcs lie arbitrarily near `x` (one of the junction's four branches is dead). Off the circle, or off
every branch, `x` lies on at most one curve (`not_isSite_of_curve`); at a junction, `not_isSite_of_rim_junction`. -/
theorem not_isSite_of_branches""",
"""circle or of that branch off the arcs lie arbitrarily near `x` (one of the junction's four branches is dead). Off the circle, or off
every branch, `x` lies on at most one curve (`not_isSite_of_curve`); at a junction, `not_isSite_of_rim_junction`. Inhabitants of the
hypotheses: the cleaned maps of the four cases (through `Near.not_isSite_of_chart`); no Lean model of such a map is on file. -/
theorem not_isSite_of_branches""")
open(p,'w').write(s)
print('doc notes written')
