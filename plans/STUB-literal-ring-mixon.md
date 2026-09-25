# FS-88 — Mixon's follow-up: the literal ring `ℤ[ζ₆, ω₃]` — are its four-colourings periodic, and finitely many? (stub)

**Carried from FS-86 (B1's prior-art check, inventory item 34):** Speyer (Polymath16, 25 April 2018) identifies `ℤ[ω₁, ω₃]` with `O_E[1/3]`, which conflicts with FS85-V2-T8 (the literal ring is not conjugation-closed); not examined — settle it first here.

*Minted 2026-09-24 at FS-85's close, from `plans/FS85-derivation.md` FS85-V2-T8 and §7, and `CLOSED-QUESTIONS.md` §2.5. Rank 15.
Written for a session with zero conversation memory.*

## The question, at its exact scope

On Polymath16 (29 May 2018) Mixon asked: *"Is Tamas's result that every 4-coloring of ℤ[ω₁,ω₃] is 8-periodic human-provable?"* — Hubai's
computer result (`[Hubai2018]`). FS-85 answered it **at its exact scope** (`LEDGER.md` row 85): every four-colouring of de Grey's lattice
`Cay(Λ, U)` is `8Λ`-periodic by hand given Parts's checked trees, and since forcing is monotone upward the same holds for every point set
`X` with `X + Λ = X` whose unit vectors include `U` — the ring closed under rotation by `η^{±1}`, as Hubai's computation uses it.

**What that does not reach (V2-T8):** the literal ring `R₂ = ℤ[ω₁, ω₃] = ℤ[ζ₆, η²]` is not closed under conjugation — `ω₃ = (2 + w)/3`
with `(2 + w) = 𝔭₃²` for one prime above 3 of ℚ(√−11), so the ring is `𝔭₃`-integral and `ω̄₃ = ω₃⁻¹ ∉` it — it contains no odd family
`η^{odd}`, and it is not a union of `Λ`-cosets. So neither `Λ` nor the ring contains the other. **Mixon's follow-up** — that the ring has
finitely many four-colourings (up to its period) — is not answered either.

## Routes

1. **Reading first:** Hubai's 9 May and 3 June 2018 comments and Mixon's post (held, `[Polymath16threads]`): which ring the computation
   coloured, which unit vectors it used, and what "8-periodic" and "finitely many" mean there. Row 78's "the lattice statement implies the
   ring's 8-periodicity, coset by coset" (FS-73) and verifier 1's C3 remark (`1680Λ`-invariance on `R₂`) are to be re-read against it.
2. **Derivation:** the literal ring's unit vectors (which families `ζ₆^a η^{2b}` it holds, and which products), whether NT holds in enough
   families there (Parts's G481 needs families outside the ring's), and whether row 85's chain (C7 → C15 → C9) runs on the ring's own graph.
3. **Finitely many colourings:** a count modulo the period, derived as C9 derived 9,120 — no enumeration.

## Bearing on χ ≥ 6

None. It closes the literal form of a question posed in print in 2018 (`CLOSED-QUESTIONS.md` §2.5), which row 85 answered only at its
exact scope.

**Provisional bearings:** G70 (√3-clean is residue), G69 (rigidity prime by prime), G75 (the mechanism), G49/G50 (read the held threads
for the exact object first), G21 (a result's scope is its enumeration's); rows 78, 85.

**Solver:** none for routes 1–3; a periodic-colouring search on the ring would be SAT (after 2026-10-01). **Cost:** a day.
