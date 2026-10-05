**The route for `exists_sectorsAt`** (the clause-5 replacement makes it a statement about cones only; no `localSectors` needed; every named lemma is
wave 3's, proved on `fs131-w3`, public at the end of `Plane/LocalStructure`):
1. *Bad directions.* `GoodAt v ρ₀` (`exists_goodAt`); `𝒜` the finitely many arcs meeting `ball v ρ₀`, all through `v`. For an arc with `b = (a.curveData v).2 ≠ 0`,
   `Arc.Tang v (e β) a` is `(b * conj (e β)).re = 0`, i.e. `|b| cos (arg b − β) = 0`, i.e. `β ∈ arg b + π/2 + πℤ`. Let `T` be the finset `{arg b_a + π/2}` and
   `Bad β := ∃ t ∈ T, ∃ m : ℤ, β = t + π m`. Then `¬ Bad β` means no arc of `𝒜` is tangent to `e β`, and `Bad` meets any bounded window in a finite set.
2. *A good direction has one colour, locally.* For `¬ Bad β`: `GoodAt.exists_wedge` (with `u = e β`) gives `m`, `N₀`; with `N = max N₀ 1` the wedge
   `W = Rgn v (e β) N m` lies in the interior points (every arc meeting it is tangent to `e β`, and none is). `W` is preconnected (`isPreconnected_Rgn_lev`, `I = univ`),
   so it lies in one class, of colour `a β`. (U) every colour whose cone holds `β` is `a β`: by `exists_mem_Rgn_of_mem_coneAt`, its class meets `W`.
   (N) there is `ε > 0` with `Ioo (β − ε) (β + ε) ⊆ coneAt (region (a β)) v`: `ray_mem_Rgn` (with `u₀ < min (m/4) (1/2)`) puts the rays at `β ± u₀`, and the ray at
   `β` itself, into `W` for small radius, and a ray inside a set approaches along its own direction (a three-line child). Define `a β` as `Classical.choose
   (exists_mem_coneAt_region hv β)`; by (U) it is the wedge's colour.
3. *Constant between bad directions.* (N) at `β` with (U) at `β'` gives `a β' = a β` for nearby good `β'`; on an open interval with no bad direction, `a` is
   locally constant, hence constant (`isPreconnected_Ioo.constant`, continuity from local constancy as in `continuousOn_col`).
4. *A pre-picture with uniform slots.* Choose a good `θ₀` (the bad directions in `[0, 1]` are finite). Let `p : Fin r → ℝ` be the sorted bad directions in
   `(θ₀, θ₀ + 2π)` (`Finset.orderEmbOfFin`). If `r = 0`: `n = 1`, `d = (θ₀, θ₀ + 2π)`, `c = a θ₀`. If `r ≥ 1`, give each breakpoint `k + 1` slots:
   `n = r (k + 1)`; slot `(l, s)` (index `l (k + 1) + s`) starts at `d = p l`; for `s < k` it is a horn of colour `if s ∈ H l then s else a_l`, where
   `H l = {j | p l ∈ coneAt (region j) v}`; for `s = k` it is the interval `[p l, p (l + 1)]` (`p r := p 0 + 2π`) of colour `a_l = a ((p l + p (l + 1))/2)`;
   `d n = p 0 + 2π`. A horn coloured `a_l` is harmless: `p l` lies in the closed interval of that colour. The cone clause: `⊆` from (U) off `Bad`, and from
   `H l` at a breakpoint (shifted into the window by periodicity, `mem_coneAt_add_two_pi`); `⊇` from (N) on each open interval, closedness of the cone
   (`isClosed_coneAt`) at its ends and at the interior points that are not true breakpoints, and the definition of `H l` for the horns.
5. *Merge.* `PreSectorsAt` := `SectorsAt` without clause 4. Strong induction on `n`: if `n = 1` or every adjacent pair differs, done. Else merge a pair
   `(i, i + 1)` of one colour with `i + 1 < n` by `Fin.removeNth (i + 1)` on `d` and `c` (cone clause: `angleIcc a b ∪ angleIcc b c' = angleIcc a c'` for
   `a ≤ b ≤ c'`). A wrap pair `(n − 1, 0)` is first rotated (`d' k = d (k + 1)` for `k < n`, `d' n = d 1 + 2π`, `c' = c ∘ finRotate n`; the cone clause
   holds by `2π`-periodicity of `angleIcc`), which makes it the pair `(n − 2, n − 1)`.
Price: H, about 600–800 lines (step 4's index arithmetic and step 5's `Fin.removeNth` are most of it). Its axioms will be wave 3's.
