# FS-74 — the algebraic explanation: why is every four-colouring of de Grey's lattice `8Λ`-periodic? (stub)

*Minted 2026-09-23 at FS-73's close, at Kooshi's request: he declined a kernel proof of the 2,044-point certificate in favour of
"an attempt at an algebraic explanation in a separate milestone rather than formalizing a big graph" (`plans/FS73-derivation.md`
T6, kernel decision). Rank 1: mechanism, no compute to speak of, Kooshi's own milestone, and now sharply aimed by Hubai's 2018 description (lead 1).*

> **Re-aimed at FS-79's close (2026-09-24).** De Grey's rigidity is **not an edge-local height**, even on its own language: every
> edge-local cocycle of its colouring shift is trivial, exactly on all 9,120 colourings (`plans/FS79-derivation.md` T23). And each of its
> 48 non-Eisenstein unit vectors lies alone in its coset of the Eisenstein sublattice, so the cosets — each carrying a triangular-lattice
> colouring with its own Moore–Newman height — are coupled only by single matchings (T37): the stripes and `F = 8Λ` are a **many-layer
> effect**, not a two-layer rule. The only edge-local four-colour heights are Moore–Newman's on sum-closed halves (T21), so lead 4's
> height lives on each coset and does not globalise. Two readings join the leads (FS79 §6 R5–R6): `K₄`'s clique complex with unit
> triangles is the flat orbifold `ℝ²/p2`, whose developing map is Moore–Newman's height; and on one hexagon system the triangle-orientation
> density equals the slope's determinant for every ergodic measure — a non-convex admissible set. An explanation of `8Λ` must read windows
> wider than one square (G73).

## Mission, in plain language

FS-73 proved that on de Grey's lattice over K = ℚ(√3,√11) — the 54 unit vectors of the Moser construction and every integer
combination of them — **every proper four-colouring repeats with period `8Λ`**: the forced group `F` (differences every
four-colouring identifies) equals the periodic one `P`, and both are `8Λ` (`LEDGER.md` row 78; T7). The proof is a certificate, not
an explanation — and its count is not new: Tamás Hubai found the same 9,120 colourings (380 with a triangle fixed), all 8-periodic, on
the Moser ring in 2018 by computer search (`[Hubai2018]`; lead 1). One direction is cheap — three exhibited `8Λ`-periodic colourings separate everything outside `8Λ`, so `P ⊆ 8Λ`.
The other is a single solver refusal: a 2,044-point graph plus the edge `{0, v}`, `v = −(4/9)(1+√−11)`, is not four-colourable
(a 56.5 MB LRAT), and `v`'s orbit under the order-24 point group spans `8Λ` (T6). Nothing says *why* the answer is `8Λ`, why it is a
power of 2 only, or why the lattice is rigid at all when every other rank-4 CM lattice in FS-73's table is loose.

**The three-colour half is already explained.** At ℚ(√11)'s `Λ₁₀` the same shape of answer, `F = P = 3Λ` at three colours, fell out
of the three-colour theorem with no forcer and no solver: the rotation set `Θ₃` is exactly 16 isolated points of order 3, so every
three-colouring is affine and `F` is the common kernel of the 16 functionals (T25; G71). **This milestone is the four-colour half,
and G71 says the three-colour mechanism cannot be it**: a four-colouring carries no height and no slope (`K₄`'s square complex is
`ℝP²`), so whatever makes de Grey's lattice rigid is something else.

## What is known (every number from its record)

- `Λ = (1/9)·O_E`, `E = ℚ(√−3,√−11)`, `O_E = ℤ[ζ₆, w]`, `w = (1+√−11)/2`; `v = −(8/9)w` and `8/9 = −(v + v̄)` (T5, Poros).
- 2 splits in `E` into two primes of residue field `𝔽₄` (inert in ℚ(√−3) and ℚ(√−11), split in ℚ(√33)); so
  `Λ/8Λ ≅ O_E/8O_E` is the product of the level-3 quotients at the two primes above 2, and `8Λ` is exactly depth ≥ 3 at both (T4).
- The colouring space is finite and fully listed: 380 pinned colourings of `Cay(Λ/8Λ, U mod 8)`, 9,120 in all, **12 classes**
  (sizes 48 ×6, 24 ×3, 12, 6, 2; `data/fs73/census/K-8Lambda-classes.json`, regenerable in under a minute by
  `tools/fs73_classify.py classify`). Exactly one class is √3-clean — Theorem B's two residue colourings, period `2Λ` — as G70
  requires; the other 11 each carry a monochromatic √3-pair (T8).
- Colourings at period `2^a·m` are `2^min(a,3)`-periodic; periods 15 and 21 have none (T7).
- The spectrum (`plans/FS73-rigidity-dichotomy.md` §R0, floats): the lattice graph is **slack** at four colours (the continuous
  minimum of `Σ_u cos 2πθ·u` is −22.41 against `−d/3 = −18`); the quotients at `N = 2, 4, 6` are **tight** (−18); `N = 8` is already
  slack (−18.142 ≈ −4 − 10√2). So Hoffman tightness alone (G54's D2-A) cannot be the whole reason `F` stops at level 3.
- Harder's `8/3` (Polymath16, 2018), Parts's `8/9` (Polymath16, 2021) and FS-73's `v` all lie in `F`; `P-D3` (row 67) is refuted — `G ∪ (G + 8/3)` forces
  `16/3` (T3).

## Leads, each a question

1. **Hubai's structure description** (`[Hubai2018]`, Polymath16 fourth thread, 9 May 2018 — the ring form of this milestone's result,
   found at FS-73's close). On the Moser ring `R₂` (closed under rotation by `η = ω₃^{1/2}`; de Grey's lattice `Λ` is not) he found by
   computer search exactly 9,120 four-colourings, 380 with a triangle fixed — the numbers FS-73 reached independently on `Λ` — and
   described them: **restricted to the Eisenstein sublattice every colouring is stripes of two colours with period 2 in one direction; any
   stripe pattern periodic by 8 extends, in exactly two ways — rotation by `k·arccos(5/6)` acts on colours as rotation by `+k·2π/3` or by
   `−k·2π/3` for all `k`, the same direction about every vertex.** That is a structure theorem in all but proof: a two-colour stripe
   pattern (the 2-adic residue, level 1) plus a chirality (a character of the rotation by `ω₃`, which reduces to a cube root of unity at the
   primes above 2). **The first task: prove his description on `Λ`** — every four-colouring of `Cay(Λ, U)` restricts to stripes on
   `ℤ[ζ₆]` and is determined by its stripes and a chirality — and read `8Λ` off it. On the ring, 8-periodicity follows from Harder's `8/3`
   by transport (he says so); on `Λ` it does not, which is where the lattice form needs its own reason.
2. **Implementer B's tight-prime reading** (G54, restated at FS-73's close): a full-rank `F` appears where the lattice is integral at
   a prime whose target is Hoffman-tight at `k` and no other prime's quotient has a gap — K at 2 with `U₂ × U₂ = K₄ × K₄` (G70),
   tight at 4. At ℚ(√11) the prime above 3 is split in ℚ(√11, i), not conjugation-fixed (Poros), and `Θ₃` explained that instance
   anyway. **Is `F = 8Λ` a level of the 2-adic tower of the lattice's own completion, `O_E ⊗ ℤ₂ ≅ W(𝔽₄) × W(𝔽₄)`, restricted to the
   54 generators?** Compare row 67, the local plane of K(i) above 2 at four colours, which forces exactly `𝔓⁴` (`𝔓² = (2)`) and
   stabilises at level 4: a different graph (the full local norm-one group, not 54 vectors) with a forcing depth by a lattice
   certificate (four units whose `t − 1` span has 2-adic elementary divisors 1, 2, 4, 4). The same certificate shape on the 54
   generators is the first computation.
3. **The √3 dichotomy** (G70): a √3-clean colouring *is* the residue colouring. Eleven of the twelve classes are √3-dirty. Is there a
   finite list of ways a colouring can be dirty, each of which propagates periodically — a structure theorem over the 11 classes?
4. **Baxter's height on hexagonal fabric** (Coxeter, `plans/FS73-C3-Coxeter.md` §6; `[MooreNewman2000]`): on a lattice containing
   `ζ₆`, every triangle of a four-colouring has three distinct `V₄`-labels, so each triangular coset carries a proper 3-edge-colouring
   of the dual honeycomb, which has a two-dimensional height (Kondev–Henley). **Do the other 48 unit vectors act on that height by
   translations?** If yes, a slope theory — and a `Θ`-type certificate — exists at K after all, and G71's "four colours are not
   linear" has an exception on hexagonal fabric; if no, the obstruction is the answer to "why not three-colour-like".
5. **The ℚ(√11) template** (T23–T25): isolated order-3 points of `Θ₃` ⟹ affine colourings ⟹ `F = ⋂ ker φ`. The four-colour
   analogue would be a finite set of "phases" (the 12 classes) each rigid, with no walls between them — the rank-1 lab's wall
   criterion (T30) is the nearest tool.

## What it produces

A proof of `F ⊇ 8Λ` — equivalently, that `(0, v)` is forced — that a person can read and the kernel could check without the
56.5 MB LRAT: a finite structure theorem on `Λ/8Λ` plus the reason every four-colouring of `Λ` is periodic at all. Or a stated
reason no such argument exists short of a search (which is itself an answer to Kooshi's question about four-colour certificates,
FS-76). The ℚ(√11) half is done (T25) and is written into the same statement as its three-colour instance.

## Provisional bearings (WORKFLOW 2.0 step 2)

G71 (the three-colour mechanism, and why it cannot be this one), G70 (the √3 dichotomy; held on all 12 classes), G54 (tight or
slack; B's reading and its killing test), G69 (rigidity decided on the quotient; K dense and rigid), G41 (the ℤ/4 colouring is
local at 2 — an additive shadow of the 2-adic structure), G27 (the Galois point group; the order-24 group gave `v`'s orbit its
rank), G62 (the lattice as a coincidence module). Rows 57, 59, 67, 78, 79. Theorems: FS73-T4–T8, T23–T25, T29–T30, FS38-D2-A/B,
MASCOT-T6–T11.

## Bearing on χ ≥ 6

None directly; high on the programme — it is the first attempt to replace a five-forcer-grade certificate with its derivation,
which is exactly what the programme asks of every object (Kooshi, 2026-09-06: *"the derivations are an order of magnitude more
important than individual objects"*), and the four-colour rigidity it explains is the kind every five-colour forced pair over a
6-open field will need.
