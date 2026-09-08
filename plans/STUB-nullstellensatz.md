# FS-10 — Nullstellensatz certificates: a kernel-checkable certificate genre that sees integrality (STUB, 2026-09-06)

> **Build triage 2026-09-08 (for Opus 5, `plans/BACKLOG-FOR-OPUS.md` LEAVE (reading room)):** see that file for the spec, the acceptance gate and the stop rule before starting; results go into a `## §B. Built` section here.

*Minted while mining Kooshi's web-Claude analysis (`reference/Chat-analysis/analysis.txt`, "Nullstellensatz certificates"),
on his direction to mine it fully. A room the project has not entered: commutative algebra as a certificate language. Read
beside this: `CLAUDE.md` G18 (composition sees what search cannot; LRAT is the standing certificate genre), G24 ("a polynomial
certificate matching the ball refutations would be a new lower-bound instrument"), G43; `plans/spike-kernel-lrat.md` (what
an LRAT costs the kernel); `BIBLIOGRAPHY.md` [DeLoera2008], [AlonTarsi1992] (second-hand at minting).*

## 1. Mission context, in plain language

Every refutation this repository has certified is an LRAT proof replayed by the kernel — sound, and opaque: it says a
formula is unsatisfiable and nothing about why, and its size (7,892 lines for the 122-core, 63× that for one 1/7 cube) is
the price of every new object. There is a second certificate language for "no k-colouring exists": k-colourability is the
solvability of a polynomial system (x_v^k = 1 for each vertex, Σ_{i<k} x_u^i x_v^{k−1−i} = 0 for each edge, over a field
containing the k-th roots of unity), and by Hilbert's Nullstellensatz the system is infeasible iff 1 = Σ β_v (x_v^k − 1) +
Σ β_e (edge polynomial) for some polynomial multipliers β — a CERTIFICATE that is a polynomial identity, found by linear
algebra once the multipliers' degree d is fixed (De Loera–Lee–Malkin–Margulies), and checked by expanding both sides. The
kernel checks a polynomial identity by `ring`/`linear_combination` — the M32 method (sympy-derived witnesses verified to
zero residual, then stated) applied to colourability. The degree d is a dial (the "Nullstellensatz degree" of the graph),
and the certificate is integrality-sensitive by construction — G24's asked-for instrument. Alon–Tarsi's graph polynomial
(orientations, the polynomial method) is the same room's other door.

## 2. What we know

| fact | where |
|---|---|
| the kernel already checks polynomial identities over the radical tower at M32 scale (`Quadrature.lean`: sympy-derived `linear_combination` witnesses) | M32 |
| the kernel-certified refutations are LRAT: the spindle (M05), the 1581 and Heule's (M06–M09), the 9-core and 122-core (M34), the 23-core at six colours (M42: 219 derived clauses) | the instances |
| NulLA (De Loera et al.): many non-3-colourable graphs have degree-1 certificates over 𝔽₂; the degree grows on hard instances; the linear system has C(n + d, d) unknowns per multiplier — the size wall | second-hand |
| over 𝔽₁₆ the fifth roots of unity are native (𝔽₁₆× has order 15); over 𝔽₄ the cube roots; 𝔽₅ has the fourth roots | fact |

## 3. Derivations first

**D1 — the smallest instance.** The Moser spindle at 3 colours over 𝔽₄ (cube roots of unity): find the minimal degree d
and the certificate; check it by hand-expansion; state it in Lean as a `linear_combination` over `ZMod`… (𝔽₄ is not a
`ZMod`; use `GaloisField 2 2` or work over ℚ(ω) — decide which the kernel handles cheaply). The kernel's second proof of the
spindle's non-3-colourability (after `decide` and LRAT): a third, algebraic one.

**D2 — the degree dial on the certified cores.** The 9-core at 4 colours (𝔽₅), the 23-core at 6 colours (𝔽₇), the 122-core
at 4: the minimal Nullstellensatz degree of each, found by NulLA (linear algebra over the finite field, sizes C(n+d, d)):
n = 23, d ≤ 3: 2,600 monomials per multiplier × 166 constraints — trivial; n = 122, d = 2: 7,626 × 543 — fine; d = 3:
317k × 543 — a large sparse system, feasible. Read the degrees; the analysis's claim is that the degree tracks
integrality (G24's gap). Register: the 23-core (χ = 7, ω = 4, the certified χ ≥ ω + 3 object) needs degree ≥ 3.

**D3 — the certificate's kernel cost.** A degree-d certificate on n vertices is a sum of ≤ (n + m) products of a multiplier
(≤ C(n+d, d) terms) by a constraint; the identity check expands to a polynomial in n variables of degree d + k — the
kernel's `ring` normalizes it; estimate the cost against the LRAT replay for the same object (the 122-core's 7,892 lines
replayed in minutes) — measure before believing either way.

## 4. Phases

| phase | what | cost |
|---|---|---|
| 0 | D1 by hand and sympy; D3 priced on the spindle | a day |
| A | NulLA in `tools/nulla.py` (sparse linear algebra over 𝔽_q; the degree ladder; the certificate written out and re-verified by independent expansion) on the spindle, K₄ − e, the 9-core, the 23-core, the 122-core | a day |
| B | the spindle's algebraic refutation in the kernel (the third proof); the 23-core's if its degree is ≤ 3 | a day |

## 5. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | the Moser spindle has a degree-1 Nullstellensatz certificate at 3 colours over 𝔽₄ | medium |
| P2 | the 23-core at six colours needs degree ≥ 3 (χ = ω + 3: the integrality gap shows in the degree) | medium-low |
| P3 | the kernel cost of a degree-≤ 2 certificate is below the LRAT replay's for the same object | low |

## 6. Failure clauses

P3 refuted (the algebraic check is slower): the genre is a second proof, not a cheaper one — kept for the objects whose
degree is small. Degrees above 4 on the cores: the genre does not scale here; record and close.

## 7. Bearing on 6, honestly

Low-medium. A certificate language, not an object. Its value: a second, independent kernel route for every refutation
(the standard of evidence above rung B asks for exactly that), and a degree dial that may read the integrality gap the
relaxations cannot. Cheap to price.

## 8. Addresses

`Proofs/HadwigerNelson/Quadrature.lean` (the `linear_combination` method), `Instances/Core23/`, `Instances/Core9.lean`,
`Instances/Core122/`, `tools/` (new: `nulla.py`), `BIBLIOGRAPHY.md`.
