*Instance block for job **FS110-NB** (brief `data/fs110/briefs/NB110-verify-proof.md`; this file is part of your brief, and not fenced). Filled in by the
product owner on 2026-09-27, when the proof side handed back.*

## Scope

- **The side verified:** the proof side, which is FS110-N (stages 1–3) with its successor FS110-N2 (stages 4–6). The brief's "FS110-N's record" means the
  whole of `plans/FS110-N-proof.md`, including its section "§ Continuation — FS110-N2". It stays fenced until your stage 3 is committed.

- **Priority:** the side recommends a blind check of its §4.3 and §6 first. So derive items 1–5 first, then items 6–10.
- **The side's claimed verdicts on the claims:** C-ACT1 is a GAP. Act One holds under Condition 5 at four-colour vertices, at trivalent vertices
  whose ring has a swap, and at tiles with an odd number of same-type steps; the open case is where every trivalent ring winds `|W| ≥ 2`. C-CUSP-K is
  TRUE. C-TAN-POS is TRUE at a non-vertex `w₀` and a GAP at a vertex `w₀`. C-SEAMLIST is MISSTATED. C-T2 (ii), C-BOW-K (ii) and S2 with unit arcs are
  GAPs.

## The statements, quoted verbatim from the side's theorem tables and sections, in priority order

The ids, statements and grades are the side's.

1. | N2-RING | ring winding: at a vertex `u`, `\|P_cl(u)\| = 3`, `ω(u)` carrying no arc of `Γ`, the ring colouring by `P_cl(u)^c` has a winding number `W(u)`; if it has no swap point then `\|W(u)\| ≥ 2`; so `W(u) = 0` ⟹ a swap | [hand, one mind; exact check on five named rings, `tools/fs110_n_ring.py`] | §4.3 |
2. | N2-SWAP | at a swap point `x ∈ ω(u)`: a covering pair at distance 1 (`(u, x)`, or `(x, y)` with `y ∈ ω(x)`), unless `Γ` carries an arc of `ω(σx)` at `x` or an arc of `ω(x)` | [hand, one mind] | §4.3 |
3. | N2-ACT1-W0 | Act One holds in every tight six-map having a vertex of four colours or a trivalent vertex with a swap (in particular with `W = 0`), bar the named unit arcs; under Condition 5 unconditionally | [hand, one mind] | §4.4 |
4. | N2-TRANS | along an edge `uu′` (common colours `a, b`) of an Act-One-free map without unit arcs, `W(u)` on the ring oriented `(d, e, f)` equals `W(u′)` on `(c, e, f)` — `u′`'s third colour `d` replaced by `u`'s third colour `c` | [hand, one mind, a sketch at the nerve step] | stage 6, §6.1 |
5. | N2-FLIP | around a tile the transported ring orientation returns reversed iff an odd number of consecutive boundary vertices share a type; such a tile forces `W = 0`, hence Act One (N2-RING, N2-SWAP), under Condition 5 | [hand, one mind; parity checked on five named faces, `tools/fs110_n_face.py`] | §6.2 |
6. | N2-V4 | a vertex `v` with `ω(v)` carrying no arc of `Γ` has `\|P_cl(v)\| ≤ 4`, and at `\|P_cl(v)\| = 4` some `y ∈ ω(v)` makes `(v, y)` a covering pair at distance 1; with arcs of `Γ` on `ω(v)` both steps are a GAP | [hand, trivial; A2-V56 and N's stage-2 note, checked here; the proviso mine, reached independently of A3's card 2] | stage 4, §4.2 |
7. | N-SEAM | seam-point lemma: for `P_cl(u) ∪ P_cl(v) = [6]`, `\|u − v\| < 2`, each common unit point `w₀` lies on `Γ`; every tile at `w₀` lies on one side of `ω(x)` for each `x ∈ {u, v}` holding its colour; if `w₀` is not a vertex, the arc through it is an arc of `ω(x)` for one `x`, both side colours are `x`'s, and colours of `x`'s type other than those two fill both side cones (TS-U) — one colour in two sectors (a strong escape) when `\|P_cl(x)\| = 3`, possibly two colours when `\|P_cl(x)\| ≥ 4` (corrected stage 3) | [hand, one mind] | §1.4 |
8. | N2-S1 | at a non-vertex seam point `w₀` on a unit arc of `ω(u)` (the (S1) seam), with `(u, v)` a disjoint (3,3) covering pair, `\|u − v\| ∉ {1, √3}`, and `ω(v)` free of `Γ`-arcs at `σ_v^{±1}w₀`: `v`'s ring changes freely at `w₀`, and both hexagon neighbours `σ_v^{±1}w₀` carry `u`'s bowtie colour `γ` on both sides along `ω(v)` | [hand, one mind; the exceptional distances located numerically, §5.1] | stage 5, §5.1 |
9. | N2-HEX | a purely rotating ring (six 60° arcs, `W = ±2`) forces `u` regular: three sectors of exactly 120°, each facing away from two consecutive rotation points | [hand, one mind] | §4.4 |
10. | N2-ROT | at a ring change point with pattern (A+, A−) one colour `g ∈ P_cl(u)` fills the outward 60° cone at `x`, and `u`'s `g`-sector lies in the closed half-plane away from `x`; with (B+, B−) the inward cone and the half-plane toward `x`; no other pattern forces a colour at `x` | [hand, one mind; table checked on named rings] | §4.3 |
11. | N-E2 | contact lemma: two same-colour tiles touching `u`, `u′` with `\|u − u′\| = 1` are Siamese (`T ⊆ B̄(u′,1)`, `T′ ⊆ B̄(u,1)`) or outer (`T ∩ B(u′,1) = ∅ = T′ ∩ B(u,1)`) — exact, whole tiles | [hand, one mind] | §1.4 |

12. **N-HORN** (the side's §2.1, quoted verbatim), which gives C-CUSP-K:

```
### 2.1 N-HORN: a cusp horn is seen like a ray [hand, one mind]

*Setting:* `u` a vertex, `w₀` a unit point of `u`, `e = w₀ − u`. A cusp horn of colour `c` at `u` leaves `u` in direction `ψ` between two arcs with
curvatures `κ₁ < κ₂` (measured toward `+e`; `κ₁ ≠ κ₂` in `𝓜_K`, N-TYPE). For `z` near `w₀` write `t = |z − u| − 1`; near `u`, `ω(z)` is the circle of
curvature 1 bending toward `z` at distance `|t|` from `u` (R §3.2, Claim 1's ray–circle quadratic, exactly).
- **(i) transversal horn** (`e_ψ · e ≠ 0`): every `ω(z)` with `sign t = sign(e_ψ · e)`, `|t|` small, crosses the direction `ψ` transversally at radius
  `ρ ≍ |t|` (Claim 1's formula), where the horn has width `≍ (κ₂ − κ₁)ρ² > 0`; it enters the horn. So in R's blocking condition a horn counts as a
  zero-length arc `I_c = {ψ}`, and Claim 1 (hence R-CP's Claim 2 and C-T-TAN's cone kill, in the sight form N-E0) holds with closure types.
- **(ii) tangent horn** (`ψ ⊥ e`): in the frame `x = ` tangential coordinate, the horn is `κ₁x²/2 < y < κ₂x²/2` (`x > 0`, to second order) and
  `ω(z)` is `y = t + x²/2` (tilt `α` adds `αx`). A `t > 0` circle enters the horn iff `κ₂ > 1` (at `x ≍ √(t/(κ₂ − 1))`, with tilt tolerance
  `≍ (κ₂ − 1)·(horn length)`); a `t < 0` circle enters it iff `κ₁ < 1`. **Missed from both sides iff `κ₂ ≤ 1 ≤ κ₁`, which `κ₁ < κ₂` forbids.**
```

13. **N-X** (the side's statement, quoted verbatim; its parts (a)–(d)):

```
**N-X.** *In (S2), suppose none of the four unit directions at `w₀` starts an arc of `Γ` (no unit-arc seam at `w₀`), and the types are disjoint. Then:*
- *(a) `w₀` carries at least four colours: at least two of `u`'s and two of `v`'s, in the pattern `v, u, v, u` around `w₀` (a tile of `v`'s colour
  around each tangent of `ω(u)`, and of `u`'s around each tangent of `ω(v)`);*
- *(b) the two `u`-colours `a, b` around the tangents of `ω(v)` lie on opposite sides of `ω(u)` and are distinct, and at `u` their tiles lie on opposite
  sides of `ω(w₀)`; likewise for `v`;*
- *(c) if `|P_cl(u)| = 3` and exactly two of `u`'s colours are at `w₀`, then at `u` each tangent direction of `ω(w₀)` either starts an arc of `ω(w₀)` in `Γ` or lies inside
  a tile of `u`'s third colour `a′`; if no arc of `ω(w₀)` leaves `u`, then `a′` owns two sectors at `u` straddling the tangent line of `ω(w₀)` — a strong
  escape (a bowtie in `a′`) at `u`; likewise at `v` with its third colour `c′`;*
- *(d) `ω(w₀)` meets tiles of at most the two colours outside `P_cl(w₀)`; with `|P_cl(w₀)| = 4` these are `a′` and `c′`, alternating along
```

**The killing tests** are your brief's stage 2: the seven-colour controls, Townsend's ⅔π sector, and §4's strip, pinhole and Parts tests. Check that
Act One is proved apart from the kills.
