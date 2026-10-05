# FS131-IT1 — T-GRAPH: Thomassen's reduction as pure graph theory

*de Bruijn, the implementer (FS131-IT1), 2026-10-05. Brief: `data/fs131/briefs/FS131-IT1-thomassen.md` (main tree). Branch `fs131-w5t`, worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5t`, cut from `fs131-w5p` at `02e85433`. The plan this record executes: `plans/FS131-planar-kernel-plan.md`
(FS131-KP) § 4.1's T-GRAPH row and § 4.3's owed inhabitant.*

## Theorems this phase proved

None yet (stage 1).

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

Checked line by line by `tools/fs131_it_quotes.py` (every `> ` line of the brief must occur verbatim in one of the sources: the branch's `MapGraph.lean`
and `plans/FS131-planar-kernel-plan.md`, the main tree's `plans/FS131-close-inventory.md` and `CLAUDE.md`). Result `data/fs131/it/quotes.txt`:
**66 quotation lines, 0 missing, exit 0.** Control: a copy of the brief with one planted line (`theorem reduced_props_of_planarLike (h : PlanarLike G) :
False := by`) reports that line `MISS` and exits 1.

| quotation | source | result |
|---|---|---|
| ruling 293 (first line; its part (d) read in full) | main `plans/FS131-close-inventory.md` l. 2240 | verbatim |
| ruling 299 (first line; its part (e) read in full) | same, l. 2337 | verbatim |
| ruling 303 (first line; its part (c) read in full) | same, l. 2398 | verbatim |
| Kooshi on pricing | `CLAUDE.md` § Counter-priors | verbatim |
| the block's definitions and the leaf (`LocallyHamiltonian` … `reduced_props_of_planarLike`) | branch `MapGraph.lean` ll. 39–108 | verbatim |
| "**an inhabitant is owed** — the triangular lattice …" | branch plan § 4.3 | verbatim |
| the `cvb_thom_reduced` row with its recorded risk | branch plan § 4.1 | verbatim |
| "**May:** add children …" | branch plan § 5.2 | verbatim |

### 1.2 What I may and may not change

**May** (brief § What is yours to decide; plan § 5.2): the new module's path and name; the proofs, their children and where they live (in the new
module), with spec examples; imports; `MapGraph` only to delete the moved block and add the import; `Proofs.lean`, `ARCHITECTURE.md`,
`scripts/Axioms.lean` (my own block, headed "FS131-IT1", above `=== PURCHASED ===`); this record; `tools/fs131_it_*.py`, `data/fs131/it/`,
`data/fs131/reports/FS131-IT1.md`.

**May not**: change any statement — `LocallyHamiltonian`, `offTwo`, `twoSepInterior`, `IsTwoSep`, `IsMaximalTwoSep`, `reducedVerts`, `reduced`,
`IsRing`, `TwiceApart`, `PlanarLike`, `reduced_props_of_planarLike`, `lemma1`, `triLattice`, `triLattice_hyps`; add an `axiom` or a `native_decide`;
touch anything else in `Plane/ValidMap/` (FS131-IP3's); merge into `fs131-w5p` or `fs131-w5`, run the gate, or touch `main`. If `PlanarLike` needs one
more field: stop that leaf and message Keryx with the field and the step that reads it.

### 1.3 The leaf, read before building: FALSE as stated (message sent to Keryx at once)

`reduced_props_of_planarLike` is **false as written**: `PlanarLike` does not stop 2-separators from nesting forever.

**Counterexample (the ladder — the strong product of the ray with `K₂`).** `V = ℕ × Bool`, `(n, s) ~ (m, t)` iff `(n = m ∧ s ≠ t) ∨ |n − m| = 1`; levels
`L_n = {(n, 0), (n, 1)}`, consecutive levels completely joined.

- `locFin` (degree ≤ 5), `conn`, `inf`: clear.
- `ring` at `(0, s)`: `[(0, ¬s), (1, s), (1, ¬s)]` — consecutive entries adjacent (the wrap too), no repeats, never `TwiceApart`; `G − (0, s) − y` is
  connected for every `y` (every level keeps a vertex, or level 0 goes whole).
- `ring` at `(n, s)`, `n ≥ 1`: `[(n+1, s), (n+1, ¬s), (n, ¬s), (n−1, ¬s), (n−1, s), (n, ¬s)]` — consecutive entries adjacent (the wrap too); the one repeat,
  `(n, ¬s)` at positions 2 and 5, separates level `n − 1` (positions 3, 4) from level `n + 1` (positions 0, 1) in `G − L_n`; it is `TwiceApart`; for
  every other `y`, `G − (n, s) − y` is connected.
- `oneInf`: `G − x − y` is connected unless `{x, y} = L_n`, `n ≥ 1`, whose two components are the levels below `n` (finite) and above (infinite).

So `PlanarLike` holds. The 2-separators are exactly `L_n`, `n ≥ 1`, with `int(L_n)` the levels below `n`; none is maximal, since `(n, s) ∈ int(L_{n+1})`.
So `reducedVerts = univ`, `reduced G ≅ G`, and at `(1, 0)` the neighbourhood `{(1, 1), (0, 0), (0, 1), (2, 0), (2, 1)}` has no Hamiltonian cycle
(removing `(1, 1)` leaves two disjoint edges): `LocallyHamiltonian (reduced G)` fails. The failing step of the docstring's route: "a maximal 2-separator
exists above every 2-separator (a strictly increasing chain of finite interiors containing a fixed vertex's neighbourhood is finite, by local finiteness
and `oneInf`)" — here `int(L_1) ⊂ int(L_2) ⊂ …`. As a plane map: the upper and lower halves of the annuli `n ≤ |z| ≤ n + 1`, tiles of unbounded
diameter; on a valid map tiles have diameter `≤ 1`, which forbids it.

**The missing field, proposed:** `finSep : ∀ v, {p : V × V | v ∈ twoSepInterior G p.1 p.2}.Finite` — every vertex lies in the interior of finitely many
pairs. Read by: the maximal 2-separator above a 2-separator `{x, y}` (one of largest interior among the finitely many pairs whose interior contains a
fixed vertex of `int(x, y)`), used for `N_H(x) = N(x) ∖ ⋃_y int(x, y)` and for `|N_H(x)| ≥ 3`. Map side (a clause of F-ONE, or a leaf of its own for
IP3): `v ∈ int(x, y)` makes `{x, y}` a 2-separator, so `x ~ y` (rings), and `v̂` lies in a bounded component of `ℂ ∖ (cl x̂ ∪ cl ŷ)`, inside that
compact set's convex hull, so `cl x̂`, `cl ŷ` meet `B̄(p, 3)` for any `p ∈ cl v̂` (filled tiles of diameter `≤ 1`) — finitely many
(`finite_tiles_closure_inter`). The ladder fails exactly this field; `triLattice` has it vacuously (no 2-separators).

**With `finSep`, the rest of the route checks on paper** (the order I formalize it in):
1. no cut vertex — the ring's consecutive clause keeps all of `x`'s neighbours in one component of `G − x`;
2. `int(x, x) = ∅`, and `int(x, y) ≠ ∅ ⟹ G.Adj x y` (`y` is then `TwiceApart`, so in the ring);
3. every component of `G − x − y` (`x ≠ y`) is adjacent to both `x` and `y` (1);
4. nesting: `x ∈ int(u, w)` and `z ∈ int(x, y)` ⟹ `z ∈ int(u, w)` (2, 3, and `oneInf`'s existence half: the infinite component of `G − u − w` lies in
   one of `G − x − y` with every `u`, `w` other than `y`);
5. a vertex lies in the interior of at most one maximal pair (as an unordered pair) (3);
6. above every 2-separator a maximal one (4, `finSep`);
7. `H` connected (send each interior vertex to one end of its maximal pair; adjacent go to equal or adjacent, by 2 and 5), locally finite (induced),
   infinite (a finite `H` has finitely many pairs, each with a finite interior: 3 and local finiteness bound the components);
8. locally Hamiltonian: for `x ∈ H`, `N_H(x)` is the set of neighbours in no `int(x, y)` (6); send each other ring entry `z` to the unique such `y`
   with `z ∈ int(x, y)` (5, 6); the image ring has consecutive entries equal or adjacent, no interleaving `y … a … y … b` (the separation clause and
   `oneInf`'s uniqueness half), and at least three values (else `x ∈ int(a, b)` for a 2-separator `{a, b}`, against 6); collapse its runs to a cycle.

### 1.4 The as-given build

Launched before any edit: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, driver log
`data/fs131/it/build-stage1.log`. **Result: OK — 446 of 446 batches, 6 modules rebuilt, 11 with warnings, every warning `declaration uses
'sorry'` (0 others by `grep -v`), exit 0, 9m7s** (`build/gate/build/20261005T020426Z-416580.log`, last line "Build completed successfully (5403 jobs).").

### 1.5 The ruling (inventory items 308–309; brief amendment 2026-10-05)

Keryx ruled at once: `PlanarLike` gains `finSep` exactly as proposed; the docstrings of `PlanarLike` and `reduced_props_of_planarLike` are rewritten
to the route that reads it; `filledGraph_finSep` is stated in `MapGraph` beside `filledGraph_oneInf` with `sorry` and added to `filledGraph_planarLike`'s
constructor. Order: the move, `triLattice_planarLike`, `reduced_props_of_planarLike`; then the ladder adversary if under about half a session; then
`filledGraph_finSep`'s proof, in that theorem's lines alone, if budget remains. My touches extend to those `MapGraph` lines and to the ladder in the new
module.

## Stage 2 — SAVED: the move

- **The module**: `Proofs/HadwigerNelson/Thomassen.lean` (namespace `HadwigerNelson.Thomassen`, the path mirroring the namespace; `Thomassen` is no
  Mathlib root namespace, `LEAN.md` § Searching — Lean). It imports **Mathlib only**: `MapGraph`'s five Mathlib imports plus
  `Mathlib.Tactic.NormNum` (the block's `norm_num`, reached in `MapGraph` through its project imports). Its own module docstring heads it; the block
  follows byte for byte.
- **`MapGraph`**: the block (lines 36–595 at `02e85433`) and the one blank line after it deleted; `import Proofs.HadwigerNelson.Thomassen` added after
  its last import. Nothing else touched (its module docstring still describes the pure graph theory; left as is, by the brief's "only").
- **Checked by `tools/fs131_it_move.py`** against `git show 02e85433:…/MapGraph.lean`: the block (29,612 bytes) occurs exactly once, verbatim, in the
  new module; the new `MapGraph` equals the original minus the block and its blank line, plus the one import line. `data/fs131/it/move-check.txt`:
  **PASS, exit 0.** Controls (`--plant`, `data/fs131/it/move-check-plant.txt`): plant A (one character of the block changed in the module, `∧` → `∨` in
  `offTwo`) reports FAIL "block occurs 0 times"; plant B (one space added to `MapGraph`'s remainder) reports FAIL at line 37; both red as they must.
- `Proofs.lean`: `import Proofs.HadwigerNelson.Thomassen` before `MapGraph`'s. `ARCHITECTURE.md`: a new `Thomassen` row (Imports `—`); `MapGraph`'s
  row says the pure graph theory moved, its Imports cell gains `Thomassen`. `tools/check_architecture.py`: **PASS, exit 0**
  (`data/fs131/it/arch-check-stage2.txt`); control: a copy without `Thomassen` in `MapGraph`'s Imports cell fails with "imports of
  Plane/ValidMap/MapGraph: … real-only ['Thomassen']". `scripts/Axioms.lean`: unchanged at this stage (no declaration renamed or added; it imports
  `Proofs`); my "FS131-IT1" block comes with the first new declarations.
- **Build: OK — 447 of 447 batches, 3 modules rebuilt (`Thomassen`, `Plane.ValidMap.MapGraph`, `Proofs`), 12 with warnings, every warning
  `declaration uses 'sorry'` (0 others), exit 0** (`build/gate/build/20261005T021654Z-510811.log`, last line "Build completed successfully (5404
  jobs)."; driver log `data/fs131/it/build-stage2.log`).

**Meanwhile, in scratch (not yet in the tree)**: the whole route of § 1.3 elaborates under `lake env lean` with `finSep` added — the reachability
layer, the 2-separator lemmas, the collapse of a cyclic sequence to a cycle, `H`'s four properties, and `triLattice_planarLike`; no `sorry`. Next
stage: the field (the ruling), then the inhabitant and the leaf into the module.

## Stage 3 — SAVED: `finSep`, F-SEP stated, the reachability layer, the inhabitant

- **The field** (ruling 309): `PlanarLike.finSep : ∀ v, {p : V × V | v ∈ twoSepInterior G p.1 p.2}.Finite`, exactly as proposed, with its field
  docstring; `PlanarLike`'s docstring rewritten (the field, why it is needed, the counterexample in words) and `reduced_props_of_planarLike`'s
  docstring rewritten to the route that reads `finSep` (§ 1.3's eight steps). Neither statement otherwise moved.
- **`MapGraph`** (my extended touches only): `ArcMap.filledGraph_finSep` (leaf F-SEP) stated beside `filledGraph_oneInf`, `sorry`, its docstring
  carrying my map-side sketch (one mind); `filledGraph_planarLike`'s constructor gains `filledGraph_finSep hF hP`, its docstring "five" → "six".
- **The reachability layer** (`Thomassen`, `section Reduction`, `variable {G}` scoped to the section so the leaf's binders stay as they were):
  `ReachIn G S a b` (a walk inside `S`) with `refl`, `symm`, `trans`, `of_adj`, `mono`, `left_mem`, `right_mem`; `reachIn_of_mem_support`,
  `mem_of_reachIn_of_closed`, `exists_exit` (a walk leaving `S` leaves along an edge); `reachable_induce_iff` (the bridge to `G.induce S`);
  `compIn`, `compIn_eq_of_reachIn`, `supp_finite_iff` (a component of `G.induce S` is finite iff its vertex set is), `mem_twoSepInterior_iff`,
  `connected_induce_iff'`.
- **The inhabitant `triLattice_planarLike : PlanarLike triLattice`**, every field exercised: rings `triRing x` (the hexagon, `triRing_isRing`),
  and `G − x − y` connected for every pair (`triLattice_reachIn`: a column free of both, the vertex's own or one beside it, climbs to a row above
  both), so `oneInf` holds with one component and `finSep` with every interior empty (`triLattice_twoSepInterior`). Children
  `triLattice_offTwo_infinite`.
- **Spec examples** for the new definitions: `ReachIn` (a positive and a negative), `compIn`, `triRing` (by `decide`).
- `scripts/Axioms.lean`: block "FS-131 wave 5 (job FS131-IT1)" above `=== PURCHASED ===`, 21 records (20 `Thomassen` theorems and
  `ArcMap.filledGraph_finSep`, `sorry` until the planar chain lands it).
- **Build: OK — 447 of 447 batches, 3 modules rebuilt (`Thomassen`, `MapGraph`, `Proofs`), 12 with warnings, every warning `declaration uses
  'sorry'` (0 others), exit 0** (`build/gate/build/20261005T022833Z-581152.log`, last line "Build completed successfully (5404 jobs)."; driver log
  `data/fs131/it/build-stage3.log`). In `Thomassen` the one `sorry` left is the leaf (l. 241); in `MapGraph` the new F-SEP (l. 160) beside IP3's.
- **Re-pricing from the first two leaves** (`LEAN.md`): the plan priced F-RING and T-GRAPH together at two to three sessions; T-GRAPH alone took
  well under one (the whole route elaborated in scratch within this stage's span), so the plan's price was high by a factor of three or more — as
  the cost model predicts.

## Stage 4 — SAVED: T-GRAPH proved — `reduced_props_of_planarLike` on the standard three

**`HadwigerNelson.Thomassen.reduced_props_of_planarLike`** is proved, statement unchanged (with `PlanarLike` as ruled), on exactly
`[propext, Classical.choice, Quot.sound]`. Its proof is the one-line assembly of four children; all live in `Thomassen`'s `section Reduction`:

- **Cyclic sequences** (generic over any type and graph): `NoInterleave` (no value `y` at positions `i < j` with others between and outside),
  `NoInterleave.sublist`; `collapse` (runs of equal entries to one) with `collapse_sublist`, `mem_collapse`, `head?_collapse`, `getLast?_collapse`,
  `isChain_collapse`; **`exists_cycle_of_chain`** (a closing chain of distinct adjacent entries with no interleaving value and three values is a
  cycle, through `Walk.ofSupport`) and **`exists_cycle_of_cyclic`** (consecutive entries equal or adjacent, cyclically, no interleaving, three
  values ⟹ a cycle on exactly the values).
- **2-separators under `PlanarLike`**: `offTwo_comm`, `twoSepInterior_comm`, `twoSepInterior_subset_offTwo`, `mem_twoSepInterior_of_reachIn`,
  `mem_twoSepInterior_or_of_adj`; `PlanarLike.offTwo_infinite`, `.reachIn_of_adj_adj`, **`.reachIn_ne`** (no cut vertex), `.twoSepInterior_self`,
  `.ne_of_mem_twoSepInterior`, **`.adj_of_mem_twoSepInterior`** (every 2-separator an edge), `.exists_adj_left`, `.exists_adj_right` (every
  component adjacent to both ends), `.twoSepInterior_finite`, **`.twoSepInterior_subset`** (interiors nest), `.eq_or_eq_of_mem`,
  **`.eq_of_mem_maximal`** (one maximal pair per interior vertex), **`.exists_maximal_above`** (the step that reads `finSep`),
  `.not_mem_twoSepInterior`; `mem_reducedVerts_of_maximal`, `exists_maximal_of_not_mem`.
- **`H`**: `exists_reducedVerts_mem_twoSepInterior`, `exists_eq_of_cross_up`, `exists_eq_of_cross_down` (discrete crossings),
  `PlanarLike.exists_adj`, **`.reduced_locallyFinite`**, **`.reducedVerts_infinite`**, **`.reduced_connected`**,
  `.eq_of_mem_twoSepInterior_of_mem_reducedVerts`, `.exists_adj_mem_reducedVerts_ne`, **`.reduced_locallyHamiltonian`**.
- Spec examples for `collapse` (by `decide`) and `NoInterleave` (one interleaving list, one not); `Mathlib.Data.List.NodupEquivFin` imported.
- `scripts/Axioms.lean`: the FS131-IT1 block gains the 39 new theorems (59 `Thomassen` records and F-SEP in all).
- **Build: OK — 447 of 447 batches, 3 modules rebuilt (`Thomassen`, `MapGraph`, `Proofs`), 11 with warnings, every warning `declaration uses
  'sorry'` (0 others), exit 0** (`build/gate/build/20261005T024305Z-686079.log`, last line "Build completed successfully (5404 jobs)."; driver log
  `data/fs131/it/build-stage4.log`). `Thomassen` is `sorry`-free (11 modules with warnings, down from 12).
- **Axioms receipt against this build's oleans** (`tools/fs131_it_axioms.py`; `data/fs131/it/AxiomsIT1.lean`, generated from the Axioms block;
  output `data/fs131/it/axioms-it1-stage4.txt`, verdict `data/fs131/it/axioms-it1-stage4-check.txt`): **OK — 62 clean records on the standard
  three or fewer** (the 59 block records, the leaf, `lemma1`, `triLattice_hyps`), **2 partners on `sorryAx`** (`ArcMap.filledGraph_finSep`,
  `ArcMap.cvb_thom_reduced`). Self-test: the partner listed as clean and a clean record listed as partner are both caught. **Tool defect found by
  its first run and fixed**: the record parser's `'([^']+)'` could not read a name with a prime (`connected_induce_iff'`), and the check failed
  loudly with "NO RECORD" — repaired to a lazy match up to `' depends`.
- **The statement read aloud against the informal claim**: for a graph with the planar properties, the graph `H` obtained by deleting the
  interior of every maximal 2-separator is connected, locally finite, locally Hamiltonian (every vertex's neighbourhood in `H` is the vertex set of
  a cycle of `H`) and infinite — `[Thomassen1999]` pp. 851–852's conclusion before Lemma 1, with CVB B2 step 3's finiteness in place of the count.
  `cvb_thom_reduced` (`MapGraph`) is now a reduction to the six F-leaves alone.
