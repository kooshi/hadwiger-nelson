exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# Appends a dated Amendment 1 to FS131-K8b's brief at its launch (run once): its branch fast-forwarded onto the first
# implementer's saved stage; three findings routed to it (inventory items 563, 564, 566, 567).
B=ROOT+"data/fs131/briefs/FS131-K8b-wave8-second.md"
T=WT+"fs131-w8/Proofs/HadwigerNelson/Plane/RingCalculus/"
s=open(B).read()
assert "## Amendment 1" not in s
a=f'''

## Amendment 1 (2026-10-06, at launch) — your branch now holds the empty class, proved; three findings are routed to you

Nothing above is withdrawn but where an item below says so.

1. **Your branch was fast-forwarded** from `f1c13612` to `368a2c1a`, a saved stage of the wave's first implementer (FS131-I8A, still
   running on its own branch; inventory item 567). Your tree was untouched. It now holds `emptyNS` and its six leaves proved, four new
   modules of the implementer's beside the two you were given, and **three** `sorry` leaves, not ten: `outerAdj` in `Empty`, and
   `star_anti` and `star_recip` in `Star` (the implementer is closing `star_recip` now; neither is yours to prove). Your statement
   checks are against `368a2c1a`. Your tree's build predates those six modules: the first build compiles them. "New modules only"
   stands — the implementer's modules are not yours to edit.
2. **`doubleTip` is proved, and by more than its statement** (items 563, 567). It and `v6_hug` are one-line consequences of a lemma
   the implementer found, which reads no Γ-free ring, no simplicity and no condition on the far germs:

{Q(T+"SoleTip.lean","theorem not_sole_tip_of_adjacent_changePoints ")}
   So items 2 and 6 above change for `doubleTip` (not for `outerAdj`, which stays as written): there is no plan to make. Instead,
   **read that proof against the entries** (`plans/FS129-MR1-audit.md`, and FS116-V6-HUG's): why did they ask for simplicity, the two
   far germs and the Γ-free ring — a route that read more than the statement needs, or a case the Lean hypotheses exclude in another
   way? The implementer's own caution, in its record's Stage 4: two change points 60° apart are held by no fragment, so the lemma's
   hypotheses are not known to be jointly satisfiable. Say what you find, and recommend whether the two rows are restated at the wider
   class; the statements themselves are decided at the wave's landing, not by you or by it.
3. **A gap at one step of `star_anti`, for you to classify** (item 567, quoted below; read it whole): the plan's step "t⁺ ≠ t⁻ by the
   interval argument" does not close when the shared tile's cone at the vertex is the whole circle. Read the argument
   (`plans/FS116-N2-proof.md`, about ll. 220–222) and the Lean lemma it leans on, and say which it is: a statement that needs a
   hypothesis its entry lacks (then say the hypothesis and message me at once), a missing lemma (the full-circle case cannot occur
   between two antipodal hubs — then state it as a leaf with its plan), or a question for a deriver (then draft the question).

{item(567)}
4. **State every leaf so that the kernel's statement is the row's** (inventory items 556, 564; `LEAN.md` § Searching — Lean, last
   bullet). A section `variable` enters a theorem only if its statement mentions it. Today an implementer found four leaves of another
   wave's skeleton false for that reason alone — their hypothesis was a section variable the statements never named, and each was
   refuted by a kernel-checked counterexample before it could be proved. After you state a leaf, `#check` it and read the binders the
   kernel shows; where a hypothesis is carried by a section variable the statement does not mention, write `include … in` above the
   leaf. A check that compares elaborated signatures, with controls, is on that implementer's branch, to read or use:
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/tools/fs131_i7a_stmt_check.py`.
5. **Names taken on another branch — restate none of them.** Wave 6's fourth planner found that two of its rows are ring-calculus
   facts and stated them, with helpers, in a module of wave 6 (`Plane/Saturated/Fragment`, on `fs131-w6`): `exists_absent_pair`,
   `kappaChange_comm`, `pair_param`, and under `ArcMap.Valid` the names `kappa`, `rung`, `contact_eq_of_sideDisc`,
   `not_mem_closure_of_germs`, with the definition `KappaChange`. If a row of yours reads one of those facts, take it as a hypothesis
   under a name of your own and tell me — the answer is a merge, which I will ask of you then. It also settled a reading you may
   meet: "saturated on a disc", for a map, is `SaturatedOn F.region U`, never the pointwise `SaturatedAt` at every point, which is
   false at every interior point of a tile of a valid map.
'''
open(B,"w").write(s.rstrip("\n")+a)
print("amended K8b")
