# FS-67 — 3-colourings of a tight graph times a non-3-colourable one: do they all come from the tight factor?

*Minted 2026-09-20 at FS-61's close; its own plan predicted the minting (`plans/FS61-quadratic-census.md` §M2: "proposed to the
owner as a stub at the close"), and both of its sweeps recommended it (`data/fs61/CLOSE-proposals.md` F.4). Written for a reader
with no conversation memory. Read beside: `CLAUDE.md` G54 (tight or slack), G61 (2), row 67 (the towers), row 72 (the 3-adic
barrier); `plans/FS58-four-colours.md` §0 O7 and D3.4; `plans/FS61-quadratic-census.md` §PA "Headline 3".*

## 1. The question, in plain language

Take two graphs. `G` is 3-colourable and **Hoffman-tight at three colours** — its least eigenvalue is exactly `−d/2`, so every
3-colouring of it is balanced and *gap-free*: every vertex sees both other colours (G54; the 3-adic plane `UD(𝔽₉, 2)` and every
level of its tower are like this, row 72). `H` is **not** 3-colourable (a residue plane at 7, 11, 19, 23). Their categorical product
`G × H` — pairs, adjacent when both coordinates are — is 3-colourable by pulling back a colouring of `G`.

> **Is every 3-colouring of `G × H` pulled back from `G`?**

FS-58 measured *yes* at `H = UD(𝔽₇, 2)` and `UD(𝔽₁₁, 2)` with `G` the 3-adic plane (§0 O7: "rigid tensored with any non-3-colourable
residue plane"), and **its plan leaned on it as if it were a theorem** (D3.4: the quotient screens are blind because periodic
colourings are affine). It is not a theorem anyone here has found.

## 2. What is known, and what is NOT

* **It is not `[ElZaharSauer1985]`, and not multiplicativity at all.** Multiplicativity says *which factor* of a product maps to
  `K₃`; it says nothing about what a colouring of the product looks like (`[Zhu2025]` Def. 3.1, Thms 4.1–4.5, via FS-61's sweep).
* **The nearest printed statement is `[GreenwellLovasz1974]`'s, second-hand from `[Tardif2008]` §4.2**: *if `G` is connected and
  `χ(G) > n` then `G × Kₙ` is uniquely `n`-colourable* — the colourable factor must be `Kₙ` itself. For a general *uniquely*
  3-colourable factor it is Duffus–Sands–Woodrow's statement B(n) (1985), conjectural. **None of the four originals has been read
  by anyone here** (all paywalled; `BIBLIOGRAPHY.md` § R.4) — every sentence in this bullet is a relay.
* **As FS-58's stub worded it, the statement is FALSE** [checked by FS-61's planner]: `G = C₅` coloured `(0,1,0,1,2)`, `H = K₄`.
  The vertex of `C₅` coloured 1 has both neighbours coloured 0, so recolouring the single vertex `(1, a)` of `C₅ × K₄` to colour 2
  is proper and does not factor through `C₅`. The obstruction is a **gap** — a vertex that does not see both other colours.
* **The repairing hypothesis is gap-freedom**, which a Hoffman-tight `G` has in *every* 3-colouring (Blokhuis–Brouwer–Haemers
  via `[AbiadEtAl2025]`; G54). So the conjecture is: **`G` Hoffman-tight at three colours (or merely: every 3-colouring of `G`
  gap-free), `H` connected with `χ(H) > 3` ⟹ every 3-colouring of `G × H` factors through `G`.**
* **An unverified sketch exists** (FS-61's prior-art sweep): an eigenvalue argument for tight `G` and `H` with `λ_min(H)/d(H) > −1/2`
  — by Weil, the residue planes from about `q = 17` up; the measured cases `q = 7, 11` are *outside* it. Nobody has checked it.
* **Where it bites beyond FS-58:** FS-61's phase A.7 found periodic 3-colourings of 3-non-integral lattices factoring through
  groups of order 27 … 4096, one through `(ℤ/8)⁴` — a pure 2-group — and **found no rule** for which quotients carry non-affine
  colourings. A quotient that is 3-colourable but *not* tight is exactly where colourings stop being pulled back; this stub's
  statement is the clean half of that missing rule. And FS-64's §3a (regular mixed colourings are colourings of a tensor
  product) lives in the same algebra from the other side.

## 3. Deliverables, cheapest first

| # | what | cost |
|---|---|---|
| D1 | **The prior-art gate, properly** (WORKFLOW 3.2, items 5–8): Greenwell–Lovász 1974, Duffus–Sands–Woodrow 1985, HHMN 1988, Tardif's survey — *read*, not relayed; zbMATH author listings for each; the reconfiguration literature's "frozen" colourings of products. If the tight case is printed, this stub closes as a citation | hours + the papers (§ R.4) |
| D2 | **Exhaustive small cases**: every Hoffman-tight 3-colourable Cayley graph on ≤ ~100 vertices against `K₄`, the Moser spindle, `UD(𝔽₇,2)`: count 3-colourings of the product against 3-colourings of `G`. One counterexample kills the conjecture as stated | an afternoon, SAT with model counting |
| D3 | **The proof or its obstruction**: check the sweep's eigenvalue sketch; the gap-free case without tightness (is gap-freedom in *every* colouring enough, or is the spectrum doing work?) | open |
| D4 | **The kernel form**, if D3 lands: `Coloring (G ×ˢ H) (Fin 3)` factors through `G` under `GapFree` — row 66's `FanGap` vocabulary already names the hypothesis's negation | days |

## 4. Bearing on χ(ℝ²) ≥ 6, stated honestly

None directly. It is mechanism: the justification under FS-58's blind-screen reading and FS-61's A.7, and the three-colour model of
a statement the programme wants at five colours — *when does a colouring of a product of local targets have to be local at one
place?* — which is the local–global conjecture's shape (G48) and FS-66's and FS-64's common ground.

## 5. Failure and jackpot clauses

* **Jackpot:** the theorem, with gap-freedom as the exact hypothesis — then "quotient screens are blind on tight pools" is derived,
  not measured, and A.7's missing rule has its first half.
* **Informative failure:** a tight `G` and a non-3-colourable `H` with a 3-colouring of `G × H` that is not pulled back. FS-58's
  D3.4 reading and G61 (2) would then be measurements of two planes and nothing more, and would be reworded.

**Provisional bearings, added 2026-09-23 (FS-73's close):** **G71** — on a lattice graph the three-colourings are governed by `Θ₃`, and at ℚ(√11)'s `Λ₁₀` "every colouring is affine" is now a theorem (16 isolated points of order 3; `plans/FS73-derivation.md` T25) — one of the two measured facts under G61 (2) that this stub was to justify, proved by a different route (the character torus, not the product). **A caution from FS-73's plan stage** (Poros, G59): a finite-`U` quotient `Cay(Λ/NΛ, U mod N)` is a *diagonal subgraph* of the product of its residue targets, not the product, so FS-58's tensor identification does not transfer to lattice quotients; this stub's question stays about the true categorical product.
