# FS-31 — Is Parts's base vacuous under our cross-edge law, or is my reconstruction wrong?

> **PARTLY ANSWERED THE SAME NIGHT (2026-09-10). Reading (B) is REFUTED and reading (A) is
> CONFIRMED-AND-PARTLY-FIXED — see `plans/M62-evolutionary-type-m.md` §R18 for the measurements.**
> - **The cross-edge law is COMPLETE.** All 30 of Heule-510's cross edges are predicted (18 at
>   `cos = 7/8`, 12 centre-incident); no M62 arena is missing edges. Reading (B) is closed.
> - **Our base IS in his coordinate system** — all 5,401 points expressible as
>   `(a + b√33 + i(c√3 + d√11))/12`, all satisfying his congruence `a − b + c + d ≡ 0 (mod 4)`.
> - **It was NOT closed under his group**: of his four generators (120° rotation, both reflections,
>   conjugation by `√33`), three preserve our base and **conjugation moves 1,734 points out of it**.
>   Closing it gives **3,667 points / 650 orbits**, keeps all 126 cross edges, and still refuses four
>   colours in 12 s. A third smaller for free.
> - **`abcd = 0` is not the product of the coordinates.** As a product it breaks his own 120°
>   rotation (2,412 of 5,401) and makes the base vacuous. It is almost certainly a condition on the
>   orbit's *canonical representative*, which he sorts by number of nonzero entries. **Dead end
>   recorded so it is not re-derived.**
>
> **What is still open:** 650 orbits against his "about 400". The remaining factor is unexplained,
> and the untried lever is the representative reading of `abcd = 0`.

*Minted 2026-09-10 at Kooshi's direction. Read `plans/M62-evolutionary-type-m.md` §R14 (the
measurement) and §R3 (the cross-edge law and its confirmation) first.*

## The discrepancy, stated so it can be settled rather than argued

`[Parts2020a]` §2 gives his base graph in closed form — and M62's §PA re-read skipped §2, which is
its own recorded lesson (G50). Verbatim:

- `H = H⁰ = W₇`, the **7-vertex hexagonal wheel**: `(0,0)`, `(±1,0)`, `(±1/2, ±√3/2)`.
- `η = exp(i arccos 5/6)` — the **Moser twist**. `ρ = exp(i arccos 7/8)` — `ρ₁₅`, **in his notation
  line**, which is the constant M62 §M1.0 spent a whole modelling pass deriving.
- `H^m = ⋃_{a=−m..m} η^a H`; **`H² = V31`, de Grey's own 31-vertex piece**.
- Base `B = ⊕ⁿ H^m`; his working choice `⊕⁴H²` on a disk of radius 2.
- Coordinates `(a + b√33 + ic√3 + id√11)/(4·3^h)`, `a − b + c + d ∈ 4ℤ`, `h = ⌈m/2⌉`.
- Symmetry group **order 24** — dihedral plus conjugation by `√33`. Orbits of order 1, 6, 12, 24.
- §5.6: *"only about **400** such orbits, of which about **40** are included in R"*, and *"all useful
  orbits satisfy the relation `abcd = 0`"*.

**Reconstructed in `typem.parts_base` (M62 §R14). One control passed and one number is badly off:**

| | ours | his |
|---|---|---|
| `|H²|` | **31** ✓ (de Grey's V31) | 31 |
| points in `⊕⁴H²`, radius 2 | 13,063 | — |
| exact unit edges | 82,782 | — |
| **orbits** | **2,246** | **"about 400"** |
| cross edges at `ρ₁₅` | 186 | — |
| **`k = 4` on the full base** | **SAT — 4-colourable** | must be refutable, or his method cannot start |

> **A base whose full selection is 4-colourable admits no 5-chromatic selection at all** (a subgraph
> of a 4-colourable graph is 4-colourable). So under our cross-edge law his base is **vacuous**, and
> that cannot be what he is working with.

## The two readings, and how to separate them

**(A) The reconstruction is wrong.** The 2,246-against-400 orbit count says something is, by roughly
a factor of five. Candidates, in order of suspicion: the `h = ⌈m/2⌉` denominator (we assumed `h = 1`
throughout, which he states for "the graphs discussed below" and may not hold for the base); the
radius convention (`parts:footnote 2` says the radius is *"half the diameter, in both the
graph-theoretic and the Euclidean sense"*, which may not be the Euclidean disk we truncated by); and
whether `⊕ⁿ` means at most `n` summands or exactly `n`.

**(B) The cross-edge law does not describe his construction.** Our law (M62 §R3) says a cross edge
at `ρ₁₅` requires the two endpoints to be **collinear with the shared centre** before rotation —
derived from `Re(ρ · ū v) = k` splitting over `K(√15)`, and **confirmed on Heule-510 to nine
decimals: all 18 of its cross edges subtend exactly `arccos(7/8)`**. If his `L ∪ ρS` shares *more
than the centre*, or attaches by chords our law does not admit, the arena we build at his base is
missing edges his has.

## The cheapest experiments, in order

1. **Count his orbits properly.** Implement the order-24 group from his `τ₀…τ₅` matrices
   (`parts:180-195`, transcribed in §R14's source reading) acting on his `(a,b,c,d)` coordinates,
   and count orbits on the radius-2 disk. If it lands near 400, reading (A) is confirmed and the
   truncation is the bug. **Hours.**
2. **Apply his `abcd = 0` filter.** He says *all* useful orbits satisfy it. That is a strong,
   cheap, testable restriction we have not used at all, and it may be most of the factor of five.
3. **Test reading (B) directly on a known object.** Take Heule-510, compute *all* pairs at unit
   distance between its `L` side and its `ρS` side, and check that **every** one satisfies the
   collinearity law. §R3 confirmed this for the 18 cross edges we identified by angle; the test here
   is the converse — that there are no others. If extra cross edges exist, the law is incomplete and
   every arena in M62 is missing edges.

## Why this is ranked as blocking rather than curious

M62's working base is a **seam-lattice reconstruction of my own** that passes the gate and contains
all 375 of Heule-510's in-field points — but it is 5,401 points where Parts works with ~40 orbits of
~400, and his §5.11 caps his solver asks at *"about 1000"* vertices. **If reading (A) is right, his
base is five times smaller than my reconstruction and every solver call in the descent gets
correspondingly cheaper** — which is the difference between a search that converges overnight and one
that grinds. If reading (B) is right, the cross-edge law is incomplete and **every measurement M62
made at `ρ₁₅` is on an arena missing edges**, which would also explain why our objects are an order
of magnitude larger than the record.

Either way it is one of the two things that must be settled before more compute is spent (the other
is FS-29).
