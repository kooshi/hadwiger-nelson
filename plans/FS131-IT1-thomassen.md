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
