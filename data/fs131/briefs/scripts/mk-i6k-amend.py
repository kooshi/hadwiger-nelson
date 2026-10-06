exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# Appends a dated Amendment 1 to the briefs of FS131-I6L, I6Z, I6K: their branches fast-forwarded to the fourth planner's
# merge of the landed main (inventory item 561). Run once: `mk-i6k-amend.py` amends all three.
NEW="4ae5bd36"; OLD="6fc27fa1"
JOBS={"L":("fs131-w6l","seventeen yours (four in `CoverHull`, thirteen in `Parallel`)"),
      "Z":("fs131-w6z","seven yours, in `Centre`"),
      "K":("fs131-w6k","ten yours, in `Accumulation`")}
S="Proofs/HadwigerNelson/Plane/Saturated/"
for j,(tree,mine) in JOBS.items():
    B=ROOT+f"data/fs131/briefs/FS131-I6{j}-wave6-third.md"
    T=WT+tree+"/"+S
    s=open(B).read()
    assert "## Amendment 1" not in s
    if j=="L":
        extra=f'''5. **Item 3 of "Done means" is superseded in one respect and sharpened in another.** `pinch` is no longer on another branch: it is
   proved in your own tree, and the cell where the planner suspected its proof reads more than the cover gives is this one:

{Q(T+"Pinch.lean","theorem hasTwoDiscsAt_of_out_out ")}
   The fourth planner has since read that cell (inventory item 561, quoted below; read it whole): it holds with the cover alone, and the
   kernel route it names is the landed lemma applied to `A \\ B` and `B`, then weakened. It is proving that under the name
   `hasTwoDiscsAt_of_out_out_of_cover` in a module of its own on another branch — an argument until it is built, in its own words.
   **Do not declare that name.** If I have sent you its commit by the time you reach `pinch_of_cover`, merge it and cite it; if not,
   prove the cell as a helper under a name of your own and say so in your report — the join folds the pair. Attack the argument before
   you lean on it: nobody but its author has checked it. You still do not edit the landed `Pinch` module.

{item(561)}'''
    elif j=="Z":
        extra=f'''5. **Item 3 of "Done means" is superseded: the three cell lemmas of a fan are in your tree, proved — cite them, declare none of them
   again, and take no hypothesis in their place** (they are the fifth implementer's, landed):

{Q(T+"FanBridge.lean","theorem isPreconnected_cell ")}
{Q(T+"FanBridge.lean","theorem cell_subset_densitySet ")}
{Q(T+"FanBridge.lean","theorem exists_ray_subset_cell ")}
   If one does not fit a leaf as stated, write a corollary under a name of your own and say so. Item 4 stands as written: the
   tangent-type fact is still the `Parallel` implementer's, a hypothesis under a name of your own unless I send its commit.'''
    else:
        extra='''5. **Nothing of your ten statements moved**, and the facts they read from the bridge — the fan at an isolated singular point, the
   local graph, the nine-colour map's locally finite singular set — are now theorems in your tree, on the standard three.'''
    a=f'''

## Amendment 1 (2026-10-06, at launch) — your branch now stands on wave 6's first half, landed and proved

Nothing above is withdrawn but where an item below says so; the base moved under you while this brief waited.

1. **Your branch was fast-forwarded** from `{OLD}` to `{NEW}`: the wave's fourth planner merged `main` into the wave's line after
   the wave's first half landed there (inventory items 558, 561). Your tree was untouched and unstarted, and the third pass's four
   modules are byte-identical to `{OLD}` (`git diff`, mine). Every "statement check against `{OLD}`" above now reads **against
   `{NEW}`**. The branch as given has **34** `sorry` leaves, not 65 — {mine}; the other thirty-one were proved by five implementers
   and passed the full gate. Your tree's build is a copy of the planner's at `{NEW}`, so the build as given should rebuild nothing.
2. **The fourteen modules beneath you are theorems now — cite them, re-declare nothing, edit none.** Two names changed at the landing,
   and the plan and records you read may still use the old ones: `polarRegion_isOpen` and `polarRegion_isPreconnected` were folded
   into these two, the same statements binder for binder:

{Q(T+"FanBuild.lean","theorem isOpen_polarRegion ")}
{Q(T+"FanBuild.lean","theorem isPreconnected_polarRegion ")}
3. **Your statement check reads the kernel's statements** (inventory item 556; `LEAN.md` § Searching — Lean, last bullet): a section
   `variable` enters a theorem only if its statement mentions it, so a leaf can lack a hypothesis its file shows, and a comparison of
   text cannot see it. `#check` each leaf before you prove it — with `lake env lean` under the slot, the output saved under your
   `data/` folder — and each head again at your last stage. A leaf whose kernel statement lacks a binder its row reads is a message to
   me before you prove it: proving the wider statement is not the job.
4. **The fourth planner is working on the wave's line now** — a fresh pass over the third pass's definitions and six more rows, in
   modules of its own. It does not edit your files. If its pass finds that a statement of yours should change, I send it to you as a
   second amendment; until then the statements stand as given.
{extra}
'''
    open(B,"w").write(s.rstrip("\n")+a)
    print("amended",j)
