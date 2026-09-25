*Brief for FS-84's stage **S1V** (post-ban: runs from 2026-10-01), a blind verifier of stage S1. Opus 5.5. Written by J29 (FS-84's planner)
before any claim exists. Staffing and launch are the owner's.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **a blind verifier**, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`
from disk and **`data/crunch-2026-09-25/briefs/STANDING-RULES.md`, part of this brief**. **No subagents** (`CLAUDE.md` § Delegation: staffing is
Kooshi's budget decision and the owner reviews only work it knows about).

**Fences (blind):** do not open `plans/FS84-five-colours-47.md`, `plans/FS84-S1-derivation.md`, `data/fs84/`, `plans/CRUNCH-2026-09-25-INDEX.md`,
or any `tools/fs84_*` until your phase 1 verdicts are committed. You may read `LEDGER.md`, every `plans/*-derivation.md`, `plans/FS91-*` and the
cited papers.

## The fixed claim list (verbatim from the plan's §M.1; decide each TRUE / FALSE with a counterexample / GAP at a named step)

- **V1 (S1a).** "`ρ_per(ℚ(√47)) < 1/4`", where "`ρ_per(F) = sup_L α(Cay(R/L, U+L)) / [R : L]` over finite-index `L ≤ R = ℤ[U_F]` with
  `U ∩ L = ∅`". Also: which prime attains the supremum, with what margin; and whether the proof needs `[AmbrusEtAl2023]` (it should not).
- **V2 (S1b).** "For a countable amenable group `G` acting on a graph `Γ` by automorphisms: `Γ` is `k`-colourable iff there is a `G`-invariant
  Borel probability measure on its proper `k`-colourings; hence, with `ι_G(Γ) = sup_μ μ{I ∋ v₀}` over `G`-invariant measures on independent sets
  (vertex-transitive `G`), `k`-colourable ⟹ `ι_G(Γ) ≥ 1/k`." Check the amenability hypothesis is load-bearing (drop it once).
- **V3 (S1c's frame).** "At four colours, `Θ₄(Λ) = ∅` for a finitely generated sublattice `Λ ⊆ ℤ[U_F]` implies nothing about the
  four-colourability of `Cay(Λ, U ∩ Λ)`, while a rational point of `Θ₄(Λ)` four-colours it periodically"; and "since `Θ₄(ℤ[U_{ℚ(√47)}]) = ∅`
  (row 96), some saturated `Λ_M` already has `Θ₄(Λ_M) = ∅`" (compactness of the inverse limit).
- **Verified inputs you may consume:** rows 75, 88 (Lemma P, V3), 92, 95, 96 at their stated grades; `[Zhang2012]` Thm 1.8(i); FS-66's
  certificates. **Not verified — re-derive if used:** Lemma C and CLG-c (J07, one mind each).

## Phases (about 2 h, 300k; hand back by 420k)

1. Blind: derive V1–V3 by your own route. Save and commit the verdicts.
2. Open the deriver's record; list every divergence of truth, route or wording. Save.
3. **Fallback (FS-89's):** if phase 1 stalls on a claim, read only the deriver's lemma *statements* (not proofs) and re-derive each. Save and report.

Exact checks of seconds only; no search. Record `plans/FS84-S1V-verification.md`, tools `tools/fs84_s1v_*.py`, commits "FS84-S1V: stage n".
Report in standing rule 9's form to `data/crunch-2026-09-25/reports/FS84-S1V.md` and by SendMessage to the owner.
