# Brief FS131-IT1 — T-GRAPH: Thomassen's reduction as pure graph theory, in a module of its own, on branch `fs131-w5t`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IT1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: move `MapGraph`'s `namespace HadwigerNelson.Thomassen` block verbatim into its own module, prove its inhabitant `triLattice_planarLike` and its leaf `reduced_props_of_planarLike` (T-GRAPH) under their exact statements, on branch `fs131-w5t`
  launch: now, beside FS131-G4 (wave 4's landing, on `fs131-w4`), FS131-I5e (wave 5, on `fs131-w5`) and FS131-IP3 (the planar chain, on `fs131-w5p`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job if `PlanarLike` turns out to need one more field (before changing it), if a statement looks false, or for a question you cannot work around; the report goes to `data/fs131/reports/FS131-IT1.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IT1-thomassen.md` (new, on branch `fs131-w5t`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5t` (branch `fs131-w5t`): a new module of your choosing for the block (recorded; it imports only Mathlib if the block allows), `Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean` only to delete the moved block and add the import, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your own block, headed "FS131-IT1", above the `=== PURCHASED ===` banner), `plans/FS131-IT1-thomassen.md`, `tools/fs131_it_*.py`, `data/fs131/it/`, `data/fs131/reports/FS131-IT1.md`; nothing else in `Plane/ValidMap/` (FS131-IP3's, on `fs131-w5p`)
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are taking the pure graph theory off the planar chain of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–3 are on `main`, wave 4 is landing, and wave 5 (termination and density) waits on seven planar leaves planned by FS131-KP on
`fs131-w5p`. One of them, `cvb_thom_reduced` — Thomassen's steps other than the rainbow step hold for every valid map — is `reduced_props_of_planarLike`
applied to the filled map graph. The map side (`filledGraph_planarLike`'s five fields) is FS131-IP3's; the graph side, which reads no geometry at all, is
yours. Thomassen's Lemma 1 (`lemma1`) is already proved in the same block. Your branch starts from `fs131-w5p` at `02e85433`.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5 cannot
land with this open. The rulings that split it off and queued it:

> 293. **Rulings on IP1's held items, and its slot.** (a) The last exit's `hK`, `hR` → `_hK`, `_hR` **accepted** (rulings 185, 281 (a): a binder name is not part
> — source: plans/FS131-close-inventory.md

(its part (d): your first act is the move, so IP3 and you never share a hunk).

> 299. **Rulings on I5d's held items, and its slot.** (a) **`rot_noThird`'s block**: wave 5's next implementer moves `cor3` — statement, docstring and proof (a
> — source: plans/FS131-close-inventory.md

(its part (e): the slot order), and the slot:

> 303. **Rulings on IX1's held items.** (a) The generalization, the rewritten docstring and `ARCHITECTURE.md`'s `Plane/PlaneTopology` row **accepted**. (b) **The
> — source: plans/FS131-close-inventory.md

Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

The block's definitions and the leaf, at `02e85433` (the proof's planned route is in the leaf's docstring):

> /-- **Locally Hamiltonian** (`[Thomassen1999]` p. 850): for each vertex `x`, `G` has a cycle whose vertex set is the neighbourhood
> `D₁(x)`. -/
> def LocallyHamiltonian : Prop :=
>   ∀ x, ∃ (a : V) (p : G.Walk a a), p.IsCycle ∧ ∀ y, y ∈ p.support ↔ G.Adj x y
>
> /-- The vertices other than `x` and `y`. -/
> def offTwo (x y : V) : Set V := {v | v ≠ x ∧ v ≠ y}
>
> /-- **`int(G, x, y)`** (CVB B2 step 2, in place of Thomassen's curve `R`): the vertices of the finite connected components of `G − x − y`. -/
> def twoSepInterior (x y : V) : Set V :=
>   {v | ∃ hv : v ∈ offTwo x y, ((G.induce (offTwo x y)).connectedComponentMk ⟨v, hv⟩).supp.Finite}
>
> /-- **A 2-separator** `{x, y}`: two distinct vertices whose removal leaves a finite component. -/
> def IsTwoSep (x y : V) : Prop := x ≠ y ∧ (twoSepInterior G x y).Nonempty
>
> /-- **A maximal 2-separator** (`[Thomassen1999]` p. 852): a 2-separator `{x, y}` such that no 2-separator `{u, v}` has `x` or `y` in its
> interior. -/
> def IsMaximalTwoSep (x y : V) : Prop :=
>   IsTwoSep G x y ∧ ∀ u v, IsTwoSep G u v → x ∉ twoSepInterior G u v ∧ y ∉ twoSepInterior G u v
>
> /-- The vertices of **`H`**: those in the interior of no maximal 2-separator. -/
> def reducedVerts : Set V := {v | ∀ x y, IsMaximalTwoSep G x y → v ∉ twoSepInterior G x y}
>
> /-- **`H`** (`[Thomassen1999]` p. 852): `G` with the interior of every maximal 2-separator deleted. -/
> def reduced : SimpleGraph (reducedVerts G) := G.induce (reducedVerts G)
>
> /-- **A ring at `x`** (the combinatorial shadow of `x`'s boundary walk, CVB B2 step 2 over `[Thomassen1999]` p. 851; FS131-KP plan § 4): a list
> `r` whose entries are exactly `x`'s neighbours, cyclically consecutive entries equal or adjacent, and in which any two appearances of a vertex
> `y` separate: an entry strictly between them and one strictly outside, both other than `y`, lie in different components of `G − x − y`.
> (The planar ring lists each repeated neighbour only at its edge contacts — Thomassen's rule — since at a vertex contact the tiles on both
> sides are adjacent and the separation fails.) -/
> def IsRing (x : V) (r : List V) : Prop :=
>   (∀ y, y ∈ r ↔ G.Adj x y) ∧ (∀ (i : ℕ) (a b : V), r[i]? = some a → r[(i + 1) % r.length]? = some b → a = b ∨ G.Adj a b) ∧
>     ∀ (y : V) (i j : ℕ), i < j → r[i]? = some y → r[j]? = some y → ∀ (m n : ℕ) (a b : V), i < m → m < j → (n < i ∨ j < n) →
>       r[m]? = some a → r[n]? = some b → ∀ (ha : a ∈ offTwo x y) (hb : b ∈ offTwo x y),
>         ¬ (G.induce (offTwo x y)).Reachable ⟨a, ha⟩ ⟨b, hb⟩
>
> /-- `y` appears at two positions of `r` that are not cyclically consecutive (`[Thomassen1999]` p. 851: "`y = xᵢ = xⱼ` for `1 ≤ i < j − 1 <
> k − 1`"). -/
> def TwiceApart (r : List V) (y : V) : Prop :=
>   ∃ i j : ℕ, i + 1 < j ∧ ¬ (i = 0 ∧ j + 1 = r.length) ∧ r[i]? = some y ∧ r[j]? = some y
>
> /-- **The planar properties Thomassen's reduction reads** (FS131-KP plan § 4; CVB B2 steps 1–3): locally finite, connected, infinite; a ring
> at every vertex, with `G − x − y` connected unless `y` appears twice apart in `x`'s ring; and for every pair exactly one infinite component of
> `G − x − y` (CVB step 2: "the complement of the compact connected `cl x̂ ∪ cl ŷ` has one unbounded component and every other component of
> `M − x − y` is finite"). The filled map graph of a valid plane map has them (`ArcMap.filledGraph_planarLike`); the reduction is
> `reduced_props_of_planarLike`. -/
> structure PlanarLike : Prop where
>   /-- Locally finite. -/
>   locFin : ∀ x, (G.neighborSet x).Finite
>   /-- Connected. -/
>   conn : G.Connected
>   /-- Infinite. -/
>   inf : Infinite V
>   /-- A ring at every vertex, `G − x − y` connected unless `y` appears twice apart. -/
>   ring : ∀ x, ∃ r, IsRing G x r ∧ ∀ y, y ≠ x → ¬ TwiceApart r y → (G.induce (offTwo x y)).Connected
>   /-- Exactly one infinite component of `G − x − y`. -/
>   oneInf : ∀ x y, x ≠ y → ∃ c : (G.induce (offTwo x y)).ConnectedComponent, ¬ c.supp.Finite ∧ ∀ c', ¬ c'.supp.Finite → c' = c
>
> /-- **Thomassen's reduction, as pure graph theory** (`[Thomassen1999]` pp. 851–852 with CVB B2 step 3's replacement of the count by
> finiteness): for a graph with the planar properties, `H = reduced G` is connected, locally finite, locally Hamiltonian and infinite. The
> proof (plan § 4, leaf T-GRAPH): 2-separators are pairs with finite components; interiors nest (Thomassen: "`int(M, x, y) ⊆ int(M, u, v)`" when
> `x` or `y` lies in `int(M, u, v)`, from the rings' separation); a maximal 2-separator exists above every 2-separator (a strictly increasing
> chain of finite interiors containing a fixed vertex's neighbourhood is finite, by local finiteness and `oneInf`); `H` connected (a shortest
> path never enters an interior), locally finite (an induced subgraph); locally Hamiltonian (delete from `x`'s ring the vertices in interiors
> of 2-separators through `x`; the reduced cyclic sequence has no repetition and at least three entries, else `G` is finite by `oneInf`); infinite
> (every interior is finite and the maximal 2-separators' crucial edges are locally finite in number). -/
> theorem reduced_props_of_planarLike (h : PlanarLike G) :
>     (reduced G).Connected ∧ (∀ x, ((reduced G).neighborSet x).Finite) ∧ LocallyHamiltonian (reduced G) ∧ Infinite (reducedVerts G) := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5t/Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean

The owed inhabitant (state it as `triLattice_planarLike : PlanarLike triLattice`, a child; `triLattice` and `triLattice_hyps` are already in the block):

> **an inhabitant is owed** — the triangular lattice (`triLattice`: rings the six-cycles, no repeats; `G − x − y` connected; one infinite
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5t/plans/FS131-planar-kernel-plan.md 4.3 Inhabitants and vacuity

The planner's recorded risk, which is why you message before changing `PlanarLike`:

> | `cvb_thom_reduced` | derives over `PlanarLike` | `= reduced_props_of_planarLike (filledGraph_planarLike hF hP)`, proved. Children F-LOC, F-CONN, F-INF, F-ONE (**M** each, `MapTopology` § A–B kind), F-RING (**H**, boundary walks over BG; separation only at edge contacts — Thomassen's rule), T-GRAPH (**H**, pure graph theory). **Risk recorded:** `PlanarLike` is this planner's reading of what Thomassen's pp. 851–852 use ("we use the properties of `M` established previously and forget about `S`"); if T-GRAPH needs one more planar property, `PlanarLike` gains a field and F-RING or F-ONE a clause — a statement change inside this job's vocabulary, no row statement moves |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5t/plans/FS131-planar-kernel-plan.md 4.1 What the pass decided (statement by statement)

What the planar job may change, which binds you too:

> **May:** add children (with spec examples; shared ones in `PlaneTopology` / `MapTopology`), change imports (updating `ARCHITECTURE.md`'s
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5t/plans/FS131-planar-kernel-plan.md 5.2 What the implementer may and may not change

## Done means

1. **Your readback first**: check every quotation above against its source; read KP's plan §§ 3–5 on T-GRAPH and the block in full; build the branch once as
   given (`02e85433`) before editing anything; open your record with what you may and may not change. Commit and push.
2. **The move**: the `namespace HadwigerNelson.Thomassen` … `end HadwigerNelson.Thomassen` block into its own module, byte-identical (checked by a script of yours,
   with a planted control watched red), `MapGraph` importing it, `Proofs.lean`, `ARCHITECTURE.md` (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean`
   updated; build. Commit.
3. **`triLattice_planarLike`**, exercising every field of `PlanarLike`; then **`reduced_props_of_planarLike`**, saving after each child; re-price from the first two.
   No statement changed, no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. If `PlanarLike` needs one more field, stop that leaf and
   message me with the field and the step that reads it (it would add a clause to one of IP3's leaves, so I rule it).
4. **The handover**: your record's last stage says what is proved and what is left, with the build log (last line, warnings other than `sorry`) and an axioms
   print against that build's oleans, including a partner that must show `sorryAx`. You do not merge into `fs131-w5p` or `fs131-w5`, run the gate, or touch
   `main`; the merge happens on my word.
5. **Your record**, stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage with leaves
   left, named, is a good report; so is a generalization found on the way.

## What is yours to decide

The module's path and name, the proofs, their children and where they live (in the new module), and the order of the two leaves. If a statement cannot be
proved as written, stop it, message me at once with the declaration, the reason, and the smallest counterexample or the missing hypothesis. Three failed
attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one
level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; four agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) under a small slot is for iteration only, never
evidence. The worktree's `.lake/build` is its own copy (from `fs131-w5x`; the first build rebuilds what differs); never replace it with a symlink. Nothing with
a `sorry` reaches `main`.

## Amendment, 2026-10-05 — `PlanarLike` gains `finSep` (inventory items 308–309)

Your statement defect is logged as item 308 (with credit) and ruled:

> 309. **Ruling on item 308: `PlanarLike` gains the field `finSep`, as proposed.** Choice: (a) the field added to `PlanarLike` (KP's foreseen shape: "if T-GRAPH
> — source: plans/FS131-close-inventory.md

(the ruling continues there). For you: add the field `finSep` to `PlanarLike` as you proposed, rewrite the two docstrings, state `filledGraph_finSep` in
`MapGraph` beside `filledGraph_oneInf` (with `sorry`) and add it to `filledGraph_planarLike`'s constructor; then your order is unchanged (the move,
`triLattice_planarLike`, `reduced_props_of_planarLike`), and after them the ladder adversary if it is cheap, and `filledGraph_finSep`'s proof if budget
remains. Your touches extend to those `MapGraph` lines (the new theorem and the constructor) and to the ladder in your new module. You start no agents of your
own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
