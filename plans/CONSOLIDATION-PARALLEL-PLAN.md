# The consolidation, partitioned for parallel worktrees

*Written 2026-09-09 by de Bruijn, immediately before a compaction, on Kooshi's plan: **"we'll compact, then
handle as many as we can in git workspaces in parallel."*** *This file exists so that a session with no memory
of the four audits can dispatch the work without re-deriving the partition — and so it does not walk into the
trap in §1.*

**The work itself is in three stubs**, and this file only says how to run them concurrently:
`plans/STUB-explain-the-unexplained.md` (FS-25, six items E1–E7),
`plans/STUB-generalize-the-kernel.md` (FS-24, seven items G1–G7 plus a consolidation section A–E), and
`plans/STUB-vacuity-and-record-integrity.md` (FS-26, phases A–C).

---

## 1. ⚠ The trap: a Lean worktree is not free, and the build is the binding constraint

**Measured here 2026-09-09.** `.lake/` is **13 GB** — 7.8 GB of packages (Mathlib) and 4.2 GB of our own build
— and it is **gitignored** (`.gitignore:2–3`). So:

* **A fresh `git worktree` has no `.lake` at all**, and `lake` will try to build Mathlib from source. That is
  hours per worktree, and it is the failure a parallel plan walks into on move one.
* **Symlink the packages, never the build.** `.lake/packages` is a pinned, read-only Mathlib and can be shared
  safely. `.lake/build` **must not** be shared: two worktrees compiling different edits race on the same
  `.olean` paths, and the corruption looks like a proof failure.
* Disk is fine: **629 GB free**, and a per-worktree `.lake/build` is ~4.2 GB.

```bash
# per worktree, once
git worktree add ../lean-wt-<name> -b consolidate/<name>
mkdir -p ../lean-wt-<name>/.lake
ln -s /home/kooshi/source/lean-dir/.lake/packages ../lean-wt-<name>/.lake/packages
cp /home/kooshi/source/lean-dir/lean-toolchain ../lean-wt-<name>/ 2>/dev/null || true
# then, in that worktree, ALWAYS:  ./scripts/build.sh    (never `lake build`, bare or named)
```

**And the constraint that actually shapes the plan:** `CLAUDE.md` requires **one heavy job at a time** — the
box does not have headroom for several builds at once, and an unrestricted `lake build` has taken the desktop
down twice. So:

> **Parallel worktrees buy EDITING parallelism, not VERIFICATION parallelism.** Several agents may write Lean
> at once; only one may build at a time. Plan the builds as a queue, cheapest first, and let the doc-only
> packages run genuinely concurrently because they never build at all.

## 2. The partition — six packages, chosen so no two touch the same file

| # | package | files it owns | builds? | depends on |
|---|---|---|---|---|
| **P1** | **FS-26 entirely** — the vacuity audit, the `\|`-escaping pass, the fresh-clone decision, `G30`'s sixth mode | `CLAUDE.md`, `BIBLIOGRAPHY.md`, `plans/*.md`, a new findings table | **no** | nothing |
| **P2** | **FS-25 E3, E4, E5** — the circulant's closed form, the 1581 corollary, the 16-pair size effect | analysis + `plans/*.md` + at most `tools/` | **no** | nothing |
| **P3** | **FS-24 G1 + G7a + G7c** — `transport_pair` relaxed; `eq_gluePoint` at general radii; the `of_equiv` helpers | `Homogeneous.lean`, `PartnerLattice.lean`, `Forcer.lean`, `Fan.lean` | yes, cheap | nothing |
| **P4** | **FS-24 G3 + FS-25 E1** — the `ZMod p` → any-field relaxation, then the forced-pair-free theorem on top of it | `LocalGlobal.lean`, `ResidueObstruction.lean` | yes, cheap | **G3 before E1** (same files, same package on purpose) |
| **P5** | **FS-24 G4 + G7b** — the `k`-generic `χ ≥ 6` target, the `distanceGraph` form, the `Brick` avoider | `Instances/HexShell.lean`, `Brick.lean`, `Instances/Nine.lean` | yes, medium | nothing |
| **P6** | **FS-24 G2** — the 2-adic law generalized | `ResidueColouring.lean`, `ValuationLaw.lean`, `FieldWall4.lean` | yes, **expensive** | **P3's `of_equiv` helpers** (`Forcer`/`Fan`) |

**Held back deliberately, and the reasons matter:**

* **FS-24 G5 (`Coset.lean`) and G6 (`Quadrature.lean`)** — independent and safe, but low value (G5 has no
  bearing on the hunt at all; G6 is a real re-proof whose witnesses must be sympy-derived first, per this
  project's own discipline). Add as P7/P8 only if there is spare capacity.
* **FS-25 E2** and **FS-24 consolidation item A** both touch `ClassGeometry.lean` / `Compulsion.lean`. **They
  collide.** Do E2 first (it is a theorem), then A (it is a refactor of the same rotation lemmas E2 will have
  touched).
* **FS-24 consolidation item D** (the fourteen private copies of `√3·√3 = 3` into a new `Field/Radicals.lean`)
  touches **fourteen files** and therefore collides with almost everything. **Run it last, alone, in the main
  tree.** Its own §3 note is the reason it is worth doing at all: a *new leaf module* costs one rebuild, where
  a declaration added to an existing upstream module rebuilds every dependent forever after.

## 3. Build cost, measured

Direct dependents, counted 2026-09-09 (`grep -rl "import Proofs.HadwigerNelson.<M>"`):
`Homogeneous` 2, `LocalGlobal` 1, `ResidueColouring` 1, `Coset` 1, `Quadrature` 1, `ClassGeometry` 1,
`Copy` 0. **The modules this milestone touches sit near the leaves of the DAG**, which is why P3–P5 are cheap.
`scripts/build_order.py` computes the true transitive order; use it before scheduling P6.

**Two rules from `CLAUDE.md` that bite here and are easy to forget in a worktree:**
* a `--` line comment leaves the `.olean` **byte-identical**, so it never rebuilds dependents; a **docstring**
  does. Prefer `--` for anything explanatory added to an upstream module.
* every generalized theorem **keeps its old form as a one-line corollary**, so no caller changes, no ledger
  row's cited name disappears, and the merge stays small.

## 4. Merge order and the gate

1. **P1 and P2 merge first** — no build, no conflict, and P1's `G30` edit is the one every later commit message
   will want to reference.
2. **P3, then P4, then P5** — each `./scripts/build.sh` then `./scripts/axioms.sh` in its own worktree, run
   one at a time, merged as each goes green.
3. **P6 last of the parallel set.** Its honest test is stated in FS-24: **`FieldWall4.lean` should get
   *smaller*** after the generalization, the way it did when Theorem A absorbed it.
4. **Then consolidation D alone in the main tree**, with a full build.

**Gate for every package, without exception:** `./scripts/build.sh` green, zero `sorry`, `./scripts/axioms.sh`
reporting **725+ clean and exactly 5 declared purchases** (that number is a 3-way match across the sources,
`ARCHITECTURE.md` § Trust and `scripts/Axioms.lean`, verified 2026-09-09 — if it moves, something is wrong),
linters silent.

**Closing rule, from `WORKFLOW.md` step 9:** whichever package lands last updates `CLAUDE.md` § Frontier and
re-ranks `plans/FRONTIER-STUBS.md`. Every package amends **in place** the ledger row or grokking its work
touches — and a derivation that erases the measurement which found it is a worse record than one carrying both.

## 5. What must not be lost if this file is all that survives

* **FS-25 E1 is the prize**, and its argument is written out in five steps in that stub with the pieces named.
  Its orbit step was verified here at `p = 7, 11, 19, 23, 31`. **Read its ⚠ note before writing it up**: the
  first sketch used "null line" to mean *isotropic*, which is false — over `p ≡ 3 (mod 4)` there are no
  isotropic vectors at all, and this repository proves it (`LocalGlobal.quadrance_eq_zero_iff`).
* **FS-24 G1 blocks stubbed work** (`plans/STUB-four-colour-valuation-law.md`'s replacement for the retracted
  duality), because over `K²` the isometry group is not transitive and the `ℂ`-shaped theorem cannot be stated
  there. It is under an hour. Do it early even if nothing else runs.
* **FS-26 is the only work on the board that could find another `core9_plane`** — a theorem that passes the
  build, the axiom audit, the sorry scan and a read-aloud, and still says nothing.
* **M62 (FS-6) keeps rank 1 as the hunt's own milestone.** None of this is the hunt, and every stub says so.
