# FS-70 — the six CM subfields of F(i), and the one lattice no phase built (owner, 2026-09-22, after phase 1c)

*Phase 1c proved that every unit vector of `E₀ = ℚ(√−3,√−5)` — the ℚ-span of its CM base `⟨ζ₆^m u^n⟩` — is a 2-unit, because
`E₀` has one prime above 2, inert over its real subfield `ℚ(√15)`, fixed by conjugation. That is one case of six. The argument
is general: in a CM field `E` with real subfield `E⁺`, a prime of `E` above `p` that conjugation fixes makes every norm-one
element a `p`-unit (`v(ψ) + v(ψ̄) = 0` with `v(ψ̄) = v(ψ)`); a split pair `𝔓 ≠ 𝔓̄` lets norm-one elements have poles
(`v_𝔓(ψ) = −v_𝔓̄(ψ)`). Run at 2 (the wall) and at 3 (the 3-adic gate) over the six quartic CM subfields of
`F(i) = ℚ(√3,√5,i)` — two over each real quadratic subfield, the third intermediate field of `F(i)/E⁺` being `F` itself.*

## 1. The table (by hand; confirmed on the atlas to denominator 42 and by `po_cm_subfield.py` to denominator 24)

| `E` | `E⁺` | 2 over `E⁺` | 3 over `E⁺` | unit vectors (den ≤ 24) | wall-breaking | 3-adic pole | both | verdict |
|---|---|---|---|---|---|---|---|---|
| `ℚ(√3, i)` | `ℚ(√3)` | inert (`i ∉ ℚ₂(√3)`; `ℚ₂(√3,i) ∋ √−3` unramified) | inert | 12 | 0 | 0 | 0 | all 2-units: dead by the residue map |
| **`ℚ(√3, √−5)`** | `ℚ(√3)` | **split** (`−15 ≡ 1 (mod 8)`, so `√−5 = √−15/√3 ∈ ℚ₂(√3)`) | **split** (`−5 ≡ 1 (mod 3)`) | 46 | 40 | 36 | 32 | **the one: wall broken, gate passed, rank 4** |
| `ℚ(√5, i)` | `ℚ(√5)` | ramified | split (3 is inert in `ℚ(√5)`, and −1 is a square in `𝔽₉`) — *corrected at FS-73's close from "inert then ramified: one prime"; FS-73 phase P2 found it by PARI, and the column's count of 8 poles is the split's* | 12 | 0 | 8 | 0 | 2-units: dead |
| `ℚ(√5, √−3)` | `ℚ(√5)` | split (`ℚ₂(√5) = ℚ₂(√−3)`) | one prime (3 inert in `ℚ(√5)`, then ramified) | 22 | 16 | 0 | 0 | 3-integral: dead by the 3-adic gate |
| `ℚ(√15, i)` | `ℚ(√15)` | split (`−15 ≡ 1 (mod 8)`) | one prime (3 ramified, then `𝔽₃ → 𝔽₉` inert) | 20 | 16 | 0 | 0 | 3-integral: dead by the 3-adic gate |
| `E₀ = ℚ(√15, √−3)` | `ℚ(√15)` | inert (phase 1c) | split | 18 | 0 | 12 | 0 | 2-units: dead (phase 1c's theorem) |

The atlas (denominator ≤ 42) reads the same pattern: `ℚ(√3,√−5)` 126 members, 72 wall-breaking, 68 with 3 in a denominator,
48 both; the other five have either no wall-breaker or no 3-adic pole.

## 2. What it says

**`E′ = ℚ(√3, √−5)` is the unique quartic CM subfield of `F(i)` in which both primes split over the real subfield** — the two
conditions the milestone's gates impose (the wall broken; a direction with 3 in a denominator) met inside one rank-4 field. It
is the field of `u = (−2+i√5)/3`, `v = (1+i√15)/4`, `ρ₁₅ = (7+i√15)/8 = −v̄²` and `2/3`'s closers — and **not** of `ζ₆` or `ζ₁₂`
(its roots of unity are `±1`). Every lattice this milestone built carried a `ζ₁₂`- or `ζ₆`-orbit (the fabric tool's generator
grammar closes every family under `ζ₁₂`; the `ζ₆` grammar was added for the CM transposition) and so had rank 8 or 6, with the
wall-breakers a thin admixture. **Λ′**, the ℤ-span of `E′`'s unit vectors to denominator 24: rank 4, HNF rows
`[[−1,50,10,−23],[0,5,−21,4],[0,0,2,20],[0,0,0,2]]` over 24 in the coordinates `(x₀, x₁, y₂, y₃)` of `x = x₀ + x₁√3`,
`y = √5(y₂ + y₃√3)`; contains `1/2, 1/3, 1/4`; contains the targets `2, 4/3, 8/3, 4, 2/3` (not `4/7`, not `4/√3` at this
denominator); no additive colouring (`1/2 ∈ Λ′`); the 3-adic gate passed (`u ∈ Λ′`).

**Every rotation `ψ ∈ E′` of norm one is commensurate with Λ′.** On the `E₀` base phase 1c found the two properties a forcer
needs pulling in opposite directions — coupling only on 2-unit rotations, the wall only on incommensurate ones. On Λ′ they do
not pull apart: a base plus its rotated copy is a larger piece of the same rank-4 lattice, and the object to ask is the lattice's
own graph (G66: the whole graph, clique-pinned), on a **Minkowski ball** — both complex embeddings bounded — which rank 4 makes
affordable where the rank-8 lattices were not (phase 1). Estimated from the HNF (covolume `20/24⁴`, embedding Jacobian 60):
≈ 2,700 points at radius 1, 14,000 at 1.5, 44,000 at 2, 220,000 at 3, with degree `g·φ(R)²` (G65) ≈ 16–30 for `g = 46` —
past the hardness peak. No residue plane four-colours it (the planes at 5, 7 and 11 refuse four colours; at 13 the Hoffman floor
of the split plane is ≥ 8). Sent to the phase-1d implementer as item 7 (build; control at four colours at rising radius; then
`forces`/`separated` at the five targets; the lens; the quotient sweep at `N⁴`).

**Why nobody built it:** G3's *"the hexagonal fabric's form"* and every known forcer's `ζ₆`-symmetry put a root of unity in every
base. Over `K` that costs nothing: the Moser lattice's CM field `ℚ(√−3,√−11)` has its two primes above 2 inert over `ℚ(√33)`, so
Harder's fabric is 2-integral by construction — the residue colouring is rigid there, forces the `8/3` pair, and the closing
spindle (`√247`) breaks the wall from outside. Over `ℚ(√3,√5)` that route died in phase 1 (the residue colouring has Kempe
escapes on every 2-unit lattice tried), so the fabric itself must break the wall — and the CM field holding `ζ₆` and a 3-adic
pole is `E₀`, which cannot, while the CM field that can do both has no `ζ₆`. Row 65's move — drop the shape — in the other
direction: drop the hexagon.

## 3. Prior art to check at the close

The "doubly split CM subfield" is a one-line computation of decomposition groups; the vocabulary is that of CM fields and the
Shimura–Taniyama reflex, and the object (unit-norm elements with prescribed valuations at split primes) is the `S`-unit group of
the norm-one torus — `[Fischer1990b]`'s `Σ₀` for a CM quartic field. Nothing to search until phase 1d says whether Λ′ colours.
