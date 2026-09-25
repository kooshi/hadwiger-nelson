# FS-90 — two hours of sanctioned search: FS-86's finite-witness questions, priced side by side (stub)

*Minted 2026-09-25 at FS-86's close for the post-close advisor and Kooshi, whose grant it is ("2 hours of sanctioned search time"). Rank 3 in
`plans/FRONTIER-STUBS.md`. Outside a grant, everything below waits for the ban's end on 2026-10-01 (`CLAUDE.md` § Toolchain). Every price here is
an estimate from held records; **nothing was run to price it**, because a pricing run is itself a search.*

## The candidates

| # | question | what two hours can show | what they cannot show | price, from the records | bearing |
|---|---|---|---|---|---|
| a | **HD1-cert's certificate** (FS86-dB-HDcert): some finitely generated `Λ₁ ∋ 1` over ℚ(√59) with `θ(1) ∈ {1/4, 1/2, 3/4}` on every point of `Θ₄(Λ₁)` — the exact `Θ₄` relation tree on `Λ₅₁₀` (324 unit vectors, rank 4) and saturations of it | **HD1 true**, if the tree closes: then no character colouring of ℚ(√59)'s plane is non-periodic (and for 83, 131 by the same run) | **HD1 false** — the certificate is semi-decidable with no size bound, so a timeout means nothing (G21); and nothing about `F(R)` itself | unpriced. Calibrations: FS-81's three-colour relation tree left Λ₂₆ over ℚ(√3) undecided at 171,657 nodes and 312 s, and FS-79's `Θ₄` cells on `L21cc6506` were found in minutes. Also needed: `Λ₅₁₀` must be rich in the isolation sense (positive spanning; D's D3), a separate exact check to run first | confirms HD1 or says nothing |
| b | **Is `√3` a four-colour virtual edge in ℚ(√2,√3)'s plane?** (FS86-Cx-C13) | **Answered at the close, given external input** (FS86-CL3): Heule's T721 (721 vertices, 3,948 edges, in ℚ(√2,√3)², a distance-2 pair monochromatic in every four-colouring; `[Soifer2024]` ch. 54, from Heule's Geombinatorics 2021 paper) forces `(0, 2)`, so `F(R) ≠ 0` there and every `√3`-pair is a virtual edge. **So the useful two-hour job is the audit of T721**: obtain the graph (Heule's files, or rebuild it from the paper), check that every coordinate lies in ℚ(√2,√3) and every edge is a unit edge (exact arithmetic), and refute the four-colourings that separate the pair with an LRAT certificate (CaDiCaL plus a verified checker) | the same fact without Heule's word; nothing about ℚ(√59) | minutes once the graph is held (721 vertices; FS-85's audit of Parts's trees is the model) | upgrades row 93's positive control from external to certified |
| c | **A triangle-free forcer of `(0, 4)` in a number field inside `ℚ₂(√3)`** (`4 ∈ F_tf`, FS86-dB-Atf, T1) | a yes answers Soifer 55.1 (row 86) | a no: no finite search refutes `4 ∈ F_tf` | unpriced; FS-85's Route 1 and FS-61's degree law (G65) are the calibrations; the dimension count (de Bruijn's log line 5) says any realisation is an arithmetic coincidence | the only candidate that could reach six (through Soifer) |
| d | **`Λ₅₁₀`'s route 4** (composite quotients `Λ/NΛ`, `N` odd times a power of 2) **and 29's certificate** for (R4) | lattice facts: a gapped quotient colouring gives `P(Λ₅₁₀) = 0` (a lattice "no", not a field one); an LRAT refusal of `UD(𝔽₂₉, 2)` at four colours makes (R4) a theorem at 29 | anything at the field level (row 88 decides `P(R)` there already) | minutes each (29's plane has 841 vertices; FS-62's measured run was 90 s) | none; bookkeeping for "rich" |

**The close planner's recommendation, for the advisor to weigh:** (b) first, because it is certain to finish and turns a result that rests
on Heule's word into a certified one; then (a) for the remaining time, reported as "HD1 confirmed" or "no information". (c) is the only
candidate with a bearing on six, and the least likely to finish.

## Provisional bearings

G21 (a timeout on a semi-decidable certificate measures its range), G65 (the degree law aims a ball; the four-colour band), G54 and G68
(read a quotient colouring for a gap), G76, G51 (an audit as a fixed certificate; FS-85's input audit is the model).
