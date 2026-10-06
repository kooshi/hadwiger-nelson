exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# Writes the dated Amendment 1 of the briefs of FS131-I6L, I6Z, I6K (unlaunched): their branches fast-forwarded twice — to the
# fourth planner's merge of the landed main (inventory item 561), then to its final tip (item 566). Re-runnable: it replaces an
# existing Amendment 1 (allowed only while the job has not launched).
NEW="2aa3f720"; OLD="6fc27fa1"
JOBS={"L":("fs131-w6l","seventeen yours (four in `CoverHull`, thirteen in `Parallel`)"),
      "Z":("fs131-w6z","seven yours, in `Centre`"),
      "K":("fs131-w6k","ten yours, in `Accumulation`")}
S="Proofs/HadwigerNelson/Plane/Saturated/"
import sys
only=sys.argv[1:] or list(JOBS)
for j in only:
    tree,mine=JOBS[j]
    B=ROOT+f"data/fs131/briefs/FS131-I6{j}-wave6-third.md"
    T=WT+tree+"/"+S
    s=open(B).read()
    k=s.find("\n\n## Amendment 1")
    if k>=0: s=s[:k]
    if j=="L":
        extra=f'''6. **Item 3 of "Done means" is superseded in one respect and sharpened in another.** `pinch` is no longer on another branch: it is
   proved in your own tree, and the cell where the third planner suspected its proof reads more than the cover gives is this one:

{Q(T+"Pinch.lean","theorem hasTwoDiscsAt_of_out_out ")}
   The fourth planner has since settled it in the kernel (inventory items 561 and 566): the cell holds with the cover alone, by the
   landed lemma applied to `A \\ B` and `B` — proved, on the standard three, in a module of its own:

{Q(T+"CoverDiscs.lean","theorem hasTwoDiscsAt_of_out_out_of_cover ")}
   That module imports yours, so `CoverHull` cannot import it. **You may move that one lemma into `CoverHull`** — the same name,
   statement and proof, deleted from the planner's module, which keeps its other theorem (`c11_discs_of_cover`, proved from your leaf
   `pinch_of_cover`) — and that deletion is the only edit of that module you may make. One declaration, one name; say in your report
   that you moved it. You still do not edit the landed `Pinch` module.'''
    elif j=="Z":
        extra=f'''6. **Item 3 of "Done means" is superseded: the three cell lemmas of a fan are in your tree, proved — cite them, declare none of them
   again, and take no hypothesis in their place** (they are the fifth implementer's, landed):

{Q(T+"FanBridge.lean","theorem isPreconnected_cell ")}
{Q(T+"FanBridge.lean","theorem cell_subset_densitySet ")}
{Q(T+"FanBridge.lean","theorem exists_ray_subset_cell ")}
   If one does not fit a leaf as stated, write a corollary under a name of your own and say so. Item 4 stands as written: the
   tangent-type fact is still the `Parallel` implementer's, a hypothesis under a name of your own unless I send its commit.'''
    else:
        extra='''6. **Nothing of your ten statements moved**, and the facts they read from the bridge — the fan at an isolated singular point, the
   local graph, the nine-colour map's locally finite singular set — are now theorems in your tree, on the standard three. The fourth
   planner's module of owed inhabitants imports yours and proves that a pointwise period is a period: read it before your
   periodicity leaves, and cite it if it serves.'''
    a=f'''

## Amendment 1 (2026-10-06, at launch) — your branch now stands on wave 6's first half, landed and proved, and on the fourth planner's pass

Nothing above is withdrawn but where an item below says so; the base moved under you twice while this brief waited.

1. **Your branch was fast-forwarded** from `{OLD}` to `{NEW}`: the wave's fourth planner merged `main` into the wave's line after
   the wave's first half landed there, then added four modules of its own and handed back (inventory items 558, 561, 566). Your tree
   was untouched and unstarted, and the third pass's four modules are byte-identical to `{OLD}` (`git diff`, mine). Every "statement
   check against `{OLD}`" above now reads **against `{NEW}`**. The branch as given has **62** `sorry` leaves, not 65 — {mine};
   of the rest, twenty-eight are the fourth planner's in its new modules and not yours, and the thirty-one of the first two passes
   were proved by five implementers and passed the full gate. Your tree's build is a copy of the planner's at `{NEW}`, so the build
   as given should rebuild nothing.
2. **The fourteen modules beneath you are theorems now — cite them, re-declare nothing, edit none.** Two names changed at the landing,
   and the plan and records you read may still use the old ones: `polarRegion_isOpen` and `polarRegion_isPreconnected` were folded
   into these two, the same statements binder for binder:

{Q(T+"FanBuild.lean","theorem isOpen_polarRegion ")}
{Q(T+"FanBuild.lean","theorem isPreconnected_polarRegion ")}
3. **Your statement check reads the kernel's statements** (inventory item 556; `LEAN.md` § Searching — Lean, last bullet): a section
   `variable` enters a theorem only if its statement mentions it, so a leaf can lack a hypothesis its file shows, and a comparison of
   text cannot see it. `#check` each leaf before you prove it — with `lake env lean` under the slot, the output saved under your
   `data/` folder — and each head again at your last stage. A leaf whose kernel statement lacks a binder its row reads is a message to
   me before you prove it: proving the wider statement is not the job. Another implementer of this milestone found four leaves false
   for exactly this reason today (item 564) and built a check that compares elaborated signatures, with controls; you may read it
   and use it: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/tools/fs131_i7a_stmt_check.py`.
4. **The fourth planner's pass over the third pass's definitions found none of them wrong** (its record's Stages 17–25, in your tree's
   copy of the plan). Its four new modules — the fragment's six rows, the cover's two lemmas, a reduction, and owed inhabitants with
   two bridges between this pass's notions — are not yours: do not prove their leaves, and do not edit them but as item 6 says.
5. **A reading it settled, which you should hold too**: "saturated on a disc", for a map, is `SaturatedOn F.region U` and never wave
   3's pointwise `SaturatedAt` at every point of the disc — that is false at every interior point of a tile of a valid map, so a
   helper that assumes it is true of nothing.
{extra}
'''
    open(B,"w").write(s.rstrip("\n")+a)
    print("amended",j)
