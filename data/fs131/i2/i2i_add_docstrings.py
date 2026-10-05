#!/usr/bin/env python3
"""FS131-I2i: insert the docstrings owed by inventory item 144 (d), one per undocumented wave-2 theorem.

Reads the list `tools/fs131_i2_docs.py` printed (data/fs131/i2/i2i-docs-before.txt), inserts `/-- … -/` above each theorem
(above its attribute or `open … in` lines), bottom-up per file. Refuses (exit 1) if a listed theorem has no text here or a
line no longer names its theorem.
"""
import collections, re, sys
D = {
 "dist_frame": "Distance in a rotated frame: `(s, t) ↦ z₀ + e θ (s + t i)` is an isometry from `ℝ²`.",
 "exists_frame_coords": "Every point has coordinates in the rotated frame at `z₀` with angle `θ`.",
 "le_zero_of_forall_small": "A continuous function nonpositive on `(0, η₀)` is nonpositive at `0`.",
 "ge_zero_of_forall_small": "A continuous function nonnegative on `(0, η₀)` is nonnegative at `0`.",
 "continuous_frameMap": "The frame map is jointly continuous in its two coordinates.",
 "isMaxIn_maxIn": "`maxIn T S` satisfies `IsMaxIn T S` (the choice `exists_isMaxIn` provides).",
 "measurableSet_grundyS": "The `m`-th Grundy candidate set is measurable.",
 "unitPairsNull_grundyS": "The `m`-th Grundy candidate set has null unit pairs.",
 "measurableSet_grundyTaken": "The points taken by the first `m` Grundy steps form a measurable set.",
 "grundyTaken_eq": "The points taken by the first `m` Grundy steps are the union of the first `m` Grundy classes.",
 "bandNull_iff_iccPairNull": "`BandNull A ε` is `IccPairNull` on the radius band `[1 − ε, 1 + ε]` (by definition).",
 "IccPairNull.mono": "Null pairs on a radius band are null on every sub-band.",
 "IccPairNull.union": "Null pairs on two adjacent radius bands are null on their union.",
 "unitPairsNull_iff_pairMass": "Null unit pairs is the vanishing of the unit-radius pair mass over every disc about the origin.",
 "mu_le_muZero": "`µ_k(ε) ≤ µ_k⁰` for `0 < ε < 1`: a band-null family has null unit pairs (`bandNull_unitPairsNull`).",
 "muTile_le_mu": "`µ_k^tile(ε) ≤ µ_k(ε)`: band-free classes are band-null.",
 "muPer_le_muTile": "`µ_k^per(ε) ≤ µ_k^tile(ε)`: a periodic tiled family is a tiled family.",
 "isPeriodicSet_periodize": "A periodized set is periodic with its period.",
 "measurableSet_periodize": "Periodizing a measurable set gives a measurable set (a countable union of translates).",
 "shift_re": "The real part of the lattice shift `mL + (nL) i`.",
 "shift_im": "The imaginary part of the lattice shift `mL + (nL) i`.",
 "isGridUnion_periodize": "Periodizing a union of `h`-grid cells at a period `N h` keeps it a union of `h`-grid cells.",
 "disjoint_periodize": "Disjoint sets inside one window of side `ℓ` stay disjoint when periodized at period `ℓ + 2`.",
 "iUnion_periodize": "Periodization commutes with unions.",
 "upperDensity_periodize": "A set inside a window of side `ℓ`, periodized at `ℓ + 2`, has upper density its area over `(ℓ + 2)²`.",
 "dist_gridPoint_lt": "The grid point of `x` at mesh `h` lies within `2h` of `x`.",
 "bandNull_preimage_add": "Band-nullity is invariant under translation.",
 "unitPairsNull_preimage_add": "Null unit pairs is invariant under translation.",
 "e_mul_e_neg": "`e θ · e (−θ) = 1`.",
 "convex_combo_mem": "A convex combination of two numbers in `[lo, hi]` lies in `[lo, hi]`.",
 "exists_frame_sides": "For a unit vector `(a, b) ≠ (1, 0)`, the box `(0, ε) × (−ε, ε)` meets both sides of the unit circle about `(−a, b)`.",
 "exists_far_point": "Under `2g − g² ≤ ρ²` the box `(g, g + ε′) × (−ρ, ρ)` meets the unit circle about `(1 + u, v)` (`0 ≤ u < g`, `|v| < ρ`, `(u, v) ≠ 0`).",
 "exists_phi_of_dist_eq_one": "A point at distance `1` from `y′` is `y′ + e φ` for some angle `φ`.",
 "norm_sq_re_im": "`‖a + b i‖² = a² + b²`.",
 "dist_framePt_sq": "The squared distance from `framePt x θ s t` to `x + e θ (a + b i)` is `(s + a)² + (t − b)²`.",
 "isOpen_halfBox": "The half-box is open.",
 "isOpen_farBox": "The far box is open.",
 "sq_lt_of_abs_lt'": "`|a| < b` gives `a² < b²`.",
 "abs_sub_lt_of_abs_lt": "`|a| < c` and `|b| < d` give `|a − b| < c + d`.",
 "real_no_unit": "Under the stated margins no two points of the face-failure pieces `H`, `F`, `Q` are at distance `1` (frame coordinates).",
 "frame_dist_sq": "Squared distance in a rotated frame is the squared distance of the frame coordinates.",
 "mem_faceFailClass_iff": "A point of the face-failure class has frame coordinates in one of its pieces `H`, `F`, `Q`.",
 "measurableSet_faceFailClass": "The face-failure class is measurable (it is open).",
 "sq9Index_periodic": "`sq9Index` is periodic with period `3/2`.",
 "cIdx_coe": "`cIdx` on the circle `ℝ/(3/2)ℤ` reads `sq9Index` at a representative.",
 "torPt_add": "`torPt` is additive.",
 "torCol_coe": "The torus colouring at the image of `(a, b)` is `sq9Col (a + b i)`.",
 "torCol_pt_add": "The torus colouring moved by `torPt z` is `sq9Col` moved by `z`.",
 "exists_coe_eq": "Every point of the torus is the image of a pair of reals.",
 "measurable_cIdx": "`cIdx` is measurable.",
 "measurable_torCol": "The torus colouring is measurable.",
 "measurable_torField": "The family of plane colourings indexed by the torus is measurable.",
 "torField_shift": "Shifting the colouring at `t` by `x` gives the colouring at `t + torPt x`.",
 "volume_tor_univ": "The torus `(ℝ/(3/2)ℤ)²` has area `(3/2)²`.",
 "cpLaw_apply": "The stationary law of `sq9` is the normalized torus measure pulled back through `torField`.",
 "cpLaw_map_shift": "The stationary law of `sq9` is invariant under every translation.",
 "vol_tor_shift": "Area on the torus is invariant under translation.",
 "volume_halfPts": "The countable set `halfPts` of the circle `ℝ/(3/2)ℤ` is null.",
 "sq9Index_eventually": "Off the half-integers, `sq9Index` is locally constant.",
 "isProbabilityMeasure_cpLaw": "The stationary law of `sq9` is a probability measure.",
 "torField_eq": "The colouring at the image of `(a, b)` is `sq9Col` moved by `a + b i`.",
 "cpLaw_proper": "The stationary law of `sq9` is proper at every unit pair.",
 "measurableSet_torChange": "The torus points whose colour changes under a shift by `d` form a measurable set.",
 "tendsto_volume_torChange": "The area of the torus points whose colour changes under a shift by `d` tends to `0` with `d`.",
 "cpLaw_tendsto": "The stationary law of `sq9` is continuous in probability.",
 "CPColouring.measurableSet_eq": "`{f | f x = f y}` is measurable.",
 "CPColouring.law_ne_eq": "`P(f x ≠ f y) = 1 − P(f x = f y)`.",
 "CPColouring.isClosed_forcedSet": "The forced set of a CP colouring is closed.",
 "CPColouring.law_eq_one_iff": "`P(f a = f b) = 1` exactly when `f a = f b` almost surely.",
 "e_pi_div_three": "`e (π/3) = 1/2 + (√3/2) i`.",
 "measurable_r7Col": "R7 is measurable (floors into a countable type and three quadratic tests).",
 "triCoord_frame": "The lattice coordinates of the frame point `e (π/6) + e (2π/3)(s + t i)`.",
 "r7ColTri_four": "In the open cell `(0, 0)`, outside the unit discs about `0`, `2`, `2ω` (lattice norm), R7 has the down colour `4`.",
 "triQ_far_gt": "Points of the box `(0.35, 0.51) × (0.65, 0.81)` are at lattice norm more than `1` from `2` and from `2ω`.",
 "triQ_frame": "The lattice norm along the frame: `triQ (r − s) (r + s) = ρ² + s²` when `r = ρ/√3`.",
 "measurableSet_disc7": "DISC7's classes are measurable.",
 "AeColouring.measurableSet_cls": "The classes of an a.e.-colouring are measurable.",
 "AeColouring.iUnion_cls": "The classes of an a.e.-colouring cover the plane.",
 "AeColouring.pairwise_disjoint_cls": "The classes of an a.e.-colouring are pairwise disjoint.",
 "measurable_sq9Col": "`sq9Col` is measurable.",
 "volume_ball_ne_zero": "A disc of positive radius has nonzero area.",
 "upperDensity_univ": "The plane has upper density `1`.",
 "upperDensity_empty": "The empty set has upper density `0`.",
 "measurable_shiftCol": "Shifting a colouring is measurable.",
 "measurable_rotCol": "Rotating a colouring is measurable.",
 "chiCP_le": "A CP `k`-colouring gives `χ_CP ≤ k`.",
}
todo = collections.defaultdict(list)
for ln in open(sys.argv[1]):
    if ln.startswith("=="):
        continue
    loc, name = ln.split()
    path, line = loc.rsplit(":", 1)
    todo[path].append((int(line), name))
bad = 0
for path, items in todo.items():
    lines = open(path).read().split("\n")
    for line, name in sorted(items, reverse=True):
        i = line - 1
        if name.split(".")[-1] not in lines[i] and name not in lines[i]:
            print(f"REFUSED: {path}:{line} does not name {name}"); bad += 1; continue
        if name not in D:
            print(f"REFUSED: no docstring for {name}"); bad += 1; continue
        j = i
        while j > 0 and (lines[j - 1].startswith("@[") or re.match(r"^open .* in$", lines[j - 1])):
            j -= 1
        lines.insert(j, f"/-- {D[name]} -/")
    open(path, "w").write("\n".join(lines))
print("refused:", bad)
sys.exit(1 if bad else 0)
