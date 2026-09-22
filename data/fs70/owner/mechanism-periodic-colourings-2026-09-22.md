# FS-70 — periodic four-colourings are residue colourings, and rigidity is decided prime by prime (owner, 2026-09-22, ~09:00; written BEFORE phase 1e reports, with a registered prediction)

*Phase 1d's §8 item 3 asks what separates the lattices whose quotient four-colourings are all gap-free (de Grey's K-lattice,
which has a forced pair in print; the rank-6 L3) from those with a gapped one (Λ′, L6, L2, L1, `zeta12+rho15`), and notes it is
not the 2-adic wall. The record's own table answers it, once read by the prime dividing N.*

## 1. The observation

Every gapped quotient colouring in phase 1d's table has **odd** N (5, 7, 3); every even-N colouring found is gap-free
(L1 at 2, 4, 6; L6 at 8; L2 at 4; L3 at 2, 4, 6; de Grey's at 2, 4, 6, 8, 10, 12). de Grey's lattice has **no** four-colouring
at any odd N tried (5, 7, 11, 13 all UNSAT); the rank-6 L3 has none at 5 (7 undecided at 300 s).

## 2. The mechanism, for a rank-4 lattice (a lattice whose ℚ-span is a CM field E, with E⁺ its real subfield)

A period-N colouring is a colouring of `Cay(Λ/NΛ, U mod N)`. For N = p an odd prime not dividing the lattice's denominators,
`Λ/pΛ ≅ O_E/pO_E` (the lattice is the maximal order locally at p), which the primes of E above p decompose; unit vectors are
norm-one elements, and their residues lie in the **norm-one group of the residue ring**. So **a period-p four-colouring is a
residue colouring at p — Theorem A at an odd prime, on the target the lattice's field supplies there** (the plan's §3.1 planes
at 5, 7 were exactly this for the *whole* field; here the target is the CM subfield's, which is smaller and can differ in kind):

| prime of E⁺ above p, in E | residue ring | the unit vectors' target | shape |
|---|---|---|---|
| **split** (𝔓 ≠ 𝔓̄, swapped by conjugation) | 𝔽_q × 𝔽_q | `{(t, t⁻¹)}` — the split torus | the **residue plane** `UD(𝔽_q, 2)` with q ≡ 1 (mod 4), or a subgraph of it |
| **inert** (𝔓 = 𝔓̄, conjugation = Frobenius of 𝔽_{q²}/𝔽_q) | 𝔽_{q²} | `μ_{q+1}` — the norm-one group | `Cay(𝔽_{q²}, μ_{q+1})`, degree q + 1 (the `U_Q` shape of G56, at an odd prime) |
| **ramified** in E/E⁺ | a local ring with 𝔓² ∣ p | `{t : t t̄ ≡ 1}` at level 2 | small |

**de Grey's lattice over K** (E = ℚ(√−3,√−11), E⁺ = ℚ(√33)): at 5, 7, 13 the prime of E⁺ is inert with residue 𝔽₂₅, 𝔽₄₉, 𝔽₁₆₉
and **splits** in E — the target is the split residue plane `UD(𝔽_q, 2)` at q = 25, 49, 169, which **refuses four colours** (phase 0
at 25 and 49; Hoffman's floor ≥ 8 at 169); at 11 it is ramified. So de Grey's lattice has no period-p four-colouring at any odd
prime tried, its four-colourings are all 2-adic (the residue colouring at 2 and what Kempe leaves of it — Polymath's "Coloring R_2"
Cor. 9, `[Polymath16wikiR2]`), and it is **rigid**: Harder's forced pair. **The rigidity is the arithmetic of the odd primes.**

**Checked (owner, on my own K-lattice):** the 54 unit vectors reduce mod 5 onto **exactly 24** residues — the whole split torus
`𝔽₂₅^×` — so the N = 5 quotient *is* `UD(𝔽₂₅, 2)`, and mod 7 onto **exactly 48** — all of `𝔽₄₉^×` — so the N = 7 quotient *is*
`UD(𝔽₄₉, 2)`; both refuse four colours by phase 0's computation, which is why de Grey's N = 5 and N = 7 rows are UNSAT. Mod 11 and
13 the 54 residues are distinct, a proper subgraph of the targets (`|𝔽₁₆₉^×| = 168`), still refusing.

At 11 (ramified over ℚ, inert over E⁺) the target is the level-2 norm-one Cayley graph on 11⁴ vertices, and it refuses too
(N = 11 UNSAT) — so the splitting type names the *shape* of the target, and its four-colourability is computed, not read off.

**L1 over ℚ(√3,√5)** (E₀ = ℚ(√−3,√−5), E⁺ = ℚ(√15)): at 5 the prime of E⁺ is ramified over ℚ and **inert** in E₀ (−3 is a non-square
mod 5), so the target is the level-2 lift of `Cay(𝔽₂₅, μ₆)` (level 1 has degree 6, its neighbourhoods 6-cycles) — four-colourable
with 50 gapped vertices (phase 1d); at 7 the prime splits completely — two split tori over 𝔽₇ — four-colourable, 193 gapped. **Λ′**
(E′ = ℚ(√3,√−5), E⁺ = ℚ(√3)): at 5, E⁺'s prime is inert (𝔽₂₅) and E′/E⁺ is **ramified** there — the level-2 target four-colours
with 597 of 625 vertices gapped. Those are the lattices phase 1d closed.

**The dichotomy in one sentence:** *a rank-4 lattice is rigid — the chain route's fabric — exactly when every odd prime's residue
target refuses four colours; a prime of E⁺ that splits in E supplies the residue plane `UD(𝔽_q, 2)`, which refuses from q = 25 up
(phase 0; Hoffman), while an inert or ramified one supplies a norm-one Cayley graph whose four-colourability is a computation —
loose at 5 and 7 for E₀ and E′, refusing at 11 for K's E.* Over K the CM field of the hexagonal fabric meets refusing targets at
5, 7, 11 and 13; over ℚ(√3,√5) the CM field of the hexagonal fabric meets four-colourable, gapped ones at 5 and at 7. **That is why
Harder's construction transposes as a lattice and not as a forcer.**

Rank 6 (L2, L3, L6): the ℚ-span is not a field, and `Λ/pΛ` is a rank-6 module over the residue rings of F(i) at p — the
same reading applies prime by prime but the target is a subgraph of a product; L2 (with v) is loose at 5 and L3 (with w) is not,
so the two wall-breakers differ 5-adically. Not derived here.

## 3. Registered prediction (before phase 1e's report)

**P-M1.** On the rank-6 L3, the gap-aimed finder returns no gapped colouring at any odd N ≤ 12 and the even-N colourings stay
gap-free; the periodic Kempe screen on the N = 2 colouring reads **rigid** at `2` and at `8/3` for every b (the 2-adic colouring
space of L3 behaves like de Grey's). Confidence medium-low. If it reads escape at some target, the mechanism above is incomplete
for rank 6 and the escape names the missing piece. **P-M2.** The rich 2-unit lattices (rank 8, in the CM field E₀ at 2-units? —
no: they span all of F(i)) admit a gapped colouring at N = 3 or N = 5. Confidence medium.

## 4. What it would make you do (the grokking's form, if it survives phase 1e)

*Do: before building any fabric over a field, take the CM field E of the fabric's ℚ-span and, for each odd prime p up to ~13,
classify the primes of E⁺ above p in E (split / inert / ramified) and the residue target's four-colourability; a split prime with
q ≥ 25 refuses and makes the lattice rigid there, an inert or ramified one with a small norm-one group supplies a period-p
four-colouring — likely gapped — that closes `Forces` on the lattice by rows 56 + 66 without a solver. Killing test: a rank-4
lattice with an odd-p residue target that four-colours with a gap and nevertheless carries a four-colour forced pair (impossible by
row 66, so the test is of the residue identification: a period-p colouring that is NOT a residue colouring at p).*
