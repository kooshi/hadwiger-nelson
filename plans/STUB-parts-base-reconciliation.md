# FS-31 — Is Parts's base vacuous under our cross-edge law, or is my reconstruction wrong?

> **CLOSED 2026-09-10. The reconstruction was wrong; the cross-edge law was right. The answer was
> `[Parts2020a]` §5.6, which states the base in closed form and which §PA had not read — `G50` a
> second time in one milestone. Full measurements in `plans/M62-evolutionary-type-m.md` §R19.**
>
> - **Reading (A) CONFIRMED and repaired.** His §5.6 relations
>   (`(a−b√33)² + (c√3−d√11)² ≤ (12r)²`, `a,b,c,d ∈ |2ℤ|`, `a−b+c+d ∈ 4ℤ`) describe a
>   **1,603-point, 92-orbit** lattice at `r = 2` whose type-M arena **refuses four colours in ten
>   seconds**. The base built from his §2 (`⊕⁴H²`) is 4-colourable — the vacuity was ours.
> - **Reading (B) stays REFUTED, now against his own object.** Our `ρ₁₅` law returns **both of his
>   named connecting orbits** — `(0,4,4,0)` at radius 2 (reference) and `(0,0,2,6)` at
>   `(17±√33)/6` (auxiliary) — **at twelve edges each, exactly his §3 counts**, and his two-orbit
>   subtype is non-vacuous on our base (11 s).
> - **"650 orbits" was half his group.** `arena_orbits` acts by `⟨rot₆, conj⟩`, order 12; his group
>   is order 24 = `⟨ζ₆⟩ ⋊ Gal(K/ℚ)`, where **complex conjugation is itself the Galois element
>   `√3,√11 ↦ −√3,−√11`** and the two extra elements are arithmetic with no geometric meaning.
>   Orbit sizes come out `{1, 6, 12, 24}` — his stated orders — on every base tried.
> - **`a,b,c,d ∈ |2ℤ|` and `abcd = 0` are both conditions on the canonical REPRESENTATIVE**, not on
>   every point: `ζ₆` sends `(a,b,c,d)` to `((a−3c)/2, (b−d)/2, (a+c)/2, (d+3b)/2)`, so all-even is
>   not stable. What is stable, derived rather than guessed, is `a ≡ b ≡ c ≡ d (mod 2)`. Control:
>   **all nineteen of his published orbit labels are all-even, non-negative, and have a zero
>   coordinate — and eighteen are canonical representatives of our orbits.** The nineteenth,
>   `(0,0,6,6)`, lies outside radius 2 and is admitted only by his "falls … partially" clause.
> - **What is NOT settled, and does not matter for the hunt:** whether his "about 400" counts orbits
>   *inside* the disk (ours: 92) or orbits *meeting* it (ours over `⊕⁸H¹`: 1,023, of which 515 also
>   satisfy `abcd = 0`). His text does not decide it. The question FS-31 was minted by — is the base
>   vacuous — is decided, in the negative.
> - **Our `H_m`/`parts_base` do not build his base graph**: `⊕⁴H²` untruncated misses eight of his
>   nineteen labels including both connecting orbits, while `⊕⁸H¹` contains all nineteen. The
>   functions are kept and marked; `typem.parts_lattice` is the §5.6 base and is what the descent
>   now runs on.

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
is FS-32).
