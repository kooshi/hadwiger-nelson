# FS-27 §1 — The two pigeonhole carriers get their inhabitants

*Subplan written 2026-09-09 by de Bruijn, on Kooshi's go. The stub is
`plans/STUB-consolidation-remainder.md` §1; the two sites are the last dischargeable entries in
`scripts/vacuity-baseline.txt`.*

---

## 0. What this is for, in plain terms

Two theorems in this repository say *"every proper 4-colouring of these points makes some listed
pair monochromatic."* **Nothing here shows either set of points has a 4-colouring at all.** If one
of them had none, this project would own a graph needing five colours far smaller than the record
and not know it. That is almost certainly false — but *"somebody would have noticed"* is a social
argument, and the kernel is what replaces those.

## 1. The measurement that settles it, taken before any Lean was written

**The coordinate field of each carrier, read out of the data rather than the docstring** (the
tower has sixteen basis slots — `1, √3, √5, √15, √7, √21, √35, √105, √11, √33, …` — and a point is
in `K = ℚ(√3,√11)` exactly when only slots `1, √3, √11, √33` are used):

| carrier | denominator | slots used | field |
|---|---|---|---|
| `core122` (122 pts) | 12 | `1, √3, √11, √33` — **zero `√5`/`√7` leaves** | **`K = ℚ(√3, √11)`** |
| `core9` (9 pts) | 512 | `1, √3, √5, √15, √7, √21, √35, √105` — **no `√11`** | `ℚ(√3, √5, √7)` |

**So the two are not the same repair, and the baseline's shared note is wrong about that.**
`core122` sits in Theorem B's own field; `core9` is wall-broken and Theorem B cannot reach it.

**Both are 4-colourable, measured** (cadical, models re-verified against the edge lists outside
the solver): `core122` at 4 colours with class sizes `[26, 27, 34, 35]`, all 421 unit edges proper;
`core9` at **3** colours on its 13 unit edges. *So there is no hidden 5-chromatic carrier, and the
kernel work below is to say so rather than to find it out.*

*(One instrument note, because it nearly produced a false alarm: a first pass at `core9` parsed
`core9Edges` by a fixed byte window and swept in `core9Pairs`, the six `√3`-pairs — the augmented
graph, which of course refuses four colours. That is the theorem, not a finding. Delimit the list
by its next declaration, not by a window.)*

## 2. The two shapes

### 2.1 `core9` — `decide`-scale, and it belongs beside its theorem

`(edgeGraph 9 core9Edges).Colorable 3` by exhibiting `![0,1,0,2,2,1,2,2,2]` and deciding
properness; `Colorable 4` follows by `Colorable.mono`. **`Instances/Core9.lean` has zero
dependents**, so this goes in the same file as `core9_pigeonhole` — G30's fifth failure mode
asks exactly that, and here it is free.

### 2.2 `core122` — Theorem B, through a bridge that does not yet exist

The chain, every link already present except the third:

1. `core122.point i = ⟨Q4.eval (verts i).x / 12, Q4.eval (verts i).y / 12⟩` (`Pt.toPlane`);
2. `colorable_four_of_subset_seamPlane : S ⊆ seamPlane → ((unitDistance ℂ).induce S).Colorable 4`
   — **Theorem B**, and `residueColouring_ne_of_dist_one` is its pointwise form;
3. **missing:** that those points lie in `seamPlane`;
4. `core122.valid_sound` already gives `dist (point i) (point j) = 1` on every listed edge.

**The missing link, at the generality its proof actually has** — this is the modeling decision and
it is not about `core122`:

```lean
/-- The `√5`- and `√7`-free subring of the tower: `ℤ[√3, √11]`. -/
def Q4.seamFree : Subring Q4                        -- + DecidablePred membership
theorem Q4.eval_mem_seamField {x : Q4} (h : x ∈ Q4.seamFree) : Q4.eval x ∈ seamField
theorem UDCert.point_mem_seamPlane (c : UDCert n) (hS : c.CoordsIn Q4.seamFree) (i) :
    c.point i ∈ seamPlane
theorem UDCert.colorable_four_of_seamFree (c : UDCert n) (hd : c.denom ≠ 0)
    (hv : c.Valid = true) (hS : c.CoordsIn Q4.seamFree) :
    (edgeGraph n c.edges).Colorable 4
```

**`Q4.seamFree` is `Q4.sevenFree` one level deeper and is written to match it** — same carrier
shape (`Set.mem_setOf` conditions on `.im` components), same closure argument (the cross terms
vanish when both factors have none), same `DecidablePred` instance, so `CoordsIn` decides. That
symmetry is the reason to build the subring rather than prove the membership pointwise:
**`CoordsIn` is stated over a `Subring Q4` and decides by `decide`**, which is what makes the
instance a one-liner and what makes the next `K`-certificate free.

The last theorem is the one worth having: **any certificate whose coordinates avoid `√5` and `√7`
is 4-colourable**, with no mention of `core122`. Every future `K`-object gets it by `decide`.

## 3. Where it lives, and why not where it belongs

`Q4.sevenFree` lives in `UnitQuadrance.lean`, which is `seamFree`'s natural home. **It is not going
there.** Measured transitive dependents:

| module | transitive dependents |
|---|---|
| `Field/Quadratic.lean` | **1,498** |
| `Certificate.lean` | **1,496** |
| `UnitQuadrance.lean` | 14 |
| `FieldWall4.lean` | 1 |
| `Instances/Core9.lean`, `Instances/Core122.lean` | **0** |

So: **a new leaf module `Proofs/HadwigerNelson/SeamCert.lean`** holding §2.2's general layer,
importing `FieldWall4` and `UnitQuadrance`; the two instances go in their own (zero-dependent)
files, with `Core122.lean` gaining an import of the leaf. A `--` line comment pointing from
`Q4.sevenFree` to its sibling costs nothing downstream (`CLAUDE.md` § Toolchain: a `--` comment
leaves the `.olean` byte-identical; a docstring does not).

## 4. Acceptance

1. `./scripts/build.sh` green; zero `sorry`; `./scripts/axioms.sh` at **794 clean / 5 declared
   purchases** — the count must not move, since nothing here buys trust;
2. `lake lint` silent;
3. **`./scripts/vacuity.sh` baseline down to two entries** — `hexShell_plane5` and
   `hexShell_plane6`, the two that are the open problem — and `--self-test` still green;
4. the general theorem is stated with **no reference to `core122`**, and the instance is one line.

**Cost:** an afternoon. **No compute. Bearing on χ(ℝ²) ≥ 6: none** — but §1's worry ("this project
may own a 122-point 5-chromatic graph and not know it") is closed in the negative, in the kernel.
