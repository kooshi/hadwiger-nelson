# FS-70 phase 1d — predictions, registered before the first computation

*Written by the phase-1d implementer (Opus 5) on 2026-09-22, before any tower level above one was built, before
any Kempe reach was computed and before any quotient was asked. Each names both outcomes and says which would
teach what (`CLAUDE.md` G21, and the rule that both outcomes must be reachable). Scored in `phase-1d.md`.*

| # | prediction | my confidence | the owner's | what the other outcome would mean |
|---|---|---|---|---|
| **P1** | the split tower `P_m = Cay((O/𝔭^m)², {(t,t⁻¹)})` is **Hoffman-tight at four colours at every level 1–5** | **medium-high** | tight | slack at some level ⟹ G54 says gaps are permitted there and the forcing mechanism dies at that level; it would also be a counterexample to reading G54's inert-tower constancy theorem across to a ramified-split tower |
| **P2** | `d₀`, the first 𝔭-depth at which a pair is forced, is **4** — the same as over K (row 67) | **low-medium** | ≥ 4, medium | `d₀ = 2` would make `δ = 2` (`v_𝔭 = 2`) live; `d₀ = 6` would kill everything except `8/3`; `d₀ = ∞` (no level forces) would kill the whole 2-unit route by theorem |
| **P2′** | the first level at which `H_min ≠ 0` is **level 5** (over K it was level 5) | **low** | — | a different level is the interesting number; the depth `d₀` is what the targets care about, the level is what the computation costs |
| **P3** | the quotient sweep on `L6` is **UNSAT at every `N ≤ 8` that is admissible** (no unit vector in `NΛ`, no loop) | **medium** | UNSAT at `N ≤ 8`, low confidence | a SAT at any `N` four-colours every graph on `L6` at once (row 56) and closes the milestone's live lattice by theorem — the finding |
| **P4** | the rich 2-unit lattices `twounits:14/30/42` are **Kempe-open (escapes exist) at every chainable target** | **medium-high** | same | a Kempe-rigid `(lattice, δ)` is where the tower's forcing would land and is phase 1e's first fabric |
| **P5** | **Harder's `V + V + H` over K refuses the `forces 8/3` ask** (UNSAT), in seconds | **high** | refuses | a SAT means either my K-arithmetic is wrong, or the fabric is not Harder's, or the `forces` encoding is wrong — in any case the milestone's whole null-so-far is unscored, because the instrument has never been seen to fire |
| **P6** | the **lens** `T_n(0 → 8/3)` on the same K-lattice **also forces 8/3**, at some `n ≤ 8`, at fewer points than 745 | **low** | — | if the lens never forces where `V+V+H` does, the shape phase 1e leads with is the wrong shape and 1e learns it before spending a budget |
| **P7** | Galois symmetry breaking on a 272,041-point arena gives **less than 2×** | **medium** | — | G27's own killing test is "a Galois-broken ask no faster than the unbroken one"; ≥ 2× and phase 1e carries the break |

**P2's reason, stated so the scoring is not retrofitted.** Over K the tower is inert and forcing starts at 2-adic
depth 4, from a lattice certificate: four norm-one units `≡ 1 (mod 𝔓)` whose `t − 1` span has elementary divisors
1, 2, 4, 4 (row 67). Here the local field is ramified (`e = 2`) as well as residually quadratic, and the torus is
**split** rather than inert, so the analogous span is over a different group and there is no reason the two depths
must agree; I predict 4 because `v_𝔭(2) = 2` in both normalisations and the mechanism is the same 2-adic one, and I
hold it low-medium because the group differs.

**P1's reason.** The level-one plane is four disjoint `K₄`s (the connection set plus 0 is a subgroup of `𝔽₄²`), so
`λ_min = −1 = −d/3`. Pulling back that eigenvector to level `m` gives an eigenvalue `−4^{m−1} = −d_m/3`, so the
tower is tight at level `m` **iff no new character beats it**. By the shape of G66's fibre-share argument the new
characters are Kloosterman sums over `O/𝔭^m` of size about `2·2^m` against `4^{m−1}` — smaller from `m = 4` up, but
**char 2 makes `t ↦ t²` inseparable, so the classical stationary-phase bound does not apply and the sums may be
larger**. That is the whole reason the levels are computed rather than quoted.

## Registered mid-phase, before the level-6 computation (2026-09-22)

**P8 — the closed form of `H_min`.** Levels 4 and 5 read `|H_min| = 4` and `64`, with the valuation pairs
`(3,3)` and `(3,3), (4,4), (4,5), (5,4)`. Both are exactly

    H_min(m)  =  { (a, b) in R_m x R_m :  v(a) >= 3,  v(b) >= 3,  a = b  (mod pi^4) }

(at level 4, `pi^4 R_4 = 0`, so the congruence is `a = b` and the order is `|pi^3 R_4| = 4`; at level 5 it is
`|pi^3 R_5| * |pi^4 R_5| = 16 * 4 = 64`).  **Prediction: at level 6 the same formula holds, so `|H_min(6)| =
|pi^3 R_6| * |pi^4 R_6| = 64 * 16 = 1024`, with valuation pairs `(3,3), (4,4), (5,5), (5,6), (6,5)` and no pair
`(3,4)` or `(4,3)`.**  Confidence **medium-high** — it fits two levels exactly and it is the only closed form I
can write that gives both orders.  A different order at level 6 means the formula is a coincidence of two small
levels and the tower's forced set has no uniform shape, which would be the more interesting outcome and would
stop me stating `d_0` as a single number.

Consequence if P8 holds, stated before it is tested: a **real** `delta` has `delta_P = delta_Pbar`, so the
congruence is free and the criterion collapses to `v_p(delta) >= 3` — `d_0 = 3`, and of the chainable targets
only `2` and `2/3` (both `v_p = 2`) are killed, while `4/3`, `4`, `4/7`, `4/sqrt3` (`v_p = 4`) and `8/3`
(`v_p = 6`) are **forced in the local plane** and therefore not killed by any residue argument at 2.

## Registered for item 7 (the owner's Λ′), before the first ask (2026-09-22)

**P9 — the control colours at every affordable radius (R ≤ 3).** Confidence **medium**, and lower than I would
hold it for any earlier fabric of this milestone, for a reason worth writing down: **Λ′ is the first fabric here
with no four-colouring from any structured source.** It has no additive four-colouring (`1/2 ∈ Λ′`, the plan's
§3.4 theorem); it has no residue four-colouring at 2 (the prime splits, which is the owner's whole point) nor at
3 (splits, the gate); the remaining primes of `ℚ(√3)` give residue graphs that themselves refuse four colours.
So the only thing standing between this fabric and a refusal is the solver. Against that: every wall-broken
lattice this milestone has asked has coloured, and `L(ℚ(√3,√5)) = 5` only *permits* five — it does not deliver it.
**A refusal is the milestone.**

**P10 — if the control colours, it colours in seconds, not at a budget.** By G65's degree law these balls sit at
average degree 16–30, far past the hardness peak at 4–6, where "almost everything decides in seconds, colourable
or not". So an `UNKNOWN` here would itself be information (it would put this fabric in a regime the degree law
says should not exist at that density). Confidence **high**.

**P11 — the quotient sweep on Λ′ (`N ≤ 30`, `N⁴` vertices) returns no SAT.** Confidence **medium-low**: `Λ′/NΛ′`
is a rank-4 quotient with 46 directions, far denser per vertex than `L6`'s rank-6 one, so the quotient graphs are
dense and a proper four-colouring is a strong demand; but a SAT at any admissible `N` four-colours the whole
lattice by row 56 and closes it by theorem, which is the outcome worth aiming at.
