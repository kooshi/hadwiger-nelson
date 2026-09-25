*Brief for FS-84's stage **S1** (post-ban: runs from 2026-10-01), the derivation stage of "ℚ(√47): five colours". Opus 5.5. Written by J29
(FS-84's planner) from `plans/FS84-five-colours-47.md` §S, §M. Staffing and launch are the owner's.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **FS-84's deriver**, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`
from disk and **`data/crunch-2026-09-25/briefs/STANDING-RULES.md`, part of this brief**. Read the plan `plans/FS84-five-colours-47.md` in full
(you are not blind; your verifier is). **No subagents** — delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget
decision and the owner reviews only work it knows about; if the work outgrows you, stop at a saved stage and say what is left.

**Why.** ℚ(√47)'s plane needs four colours and at most five (rows 73, 82, 52). Five would answer Soifer's Open Problem 55.1 and Moorhouse's
ℚ(√47) question. Every periodic, character and measurable-window four-colouring is already excluded (rows 92, 96); this stage writes the
frame down at full rigour and aims the next stages. **Every outcome counts; do not lean toward a yes.** A GAP with the missing step named is
a result.

**Record:** `plans/FS84-S1-derivation.md` (stages `Stage n — SAVED`; heading "Theorems this phase proved"); tools `tools/fs84_s1_*.py`
(each with a plant that fires); data `data/fs84/s1/`. Commit by explicit path, subjects "FS84-S1: stage n", push, never force-push.

## Targets (verbatim from the plan §M; derive each, or name the step that fails)

- **S1a.** "`ρ_per(ℚ(√47)) < 1/4`", where "`ρ_per(F) = sup_L α(Cay(R/L, U+L)) / [R : L]` over finite-index `L ≤ R = ℤ[U_F]` with `U ∩ L = ∅`";
  corollary: no periodic four-colouring of ℚ(√47)'s plane. Obligations a1–a4 of plan §M.2; **do not use `[AmbrusEtAl2023]`**. State the
  ramified 47-place's all-levels ratio explicitly (Lemma P, Theorem E). Name the binding prime and its margin.
- **S1b.** "For a countable amenable group `G` acting on a graph `Γ` by automorphisms: `Γ` is `k`-colourable iff there is a `G`-invariant Borel
  probability measure on its proper `k`-colourings; hence … `k`-colourable ⟹ `ι_G(Γ) ≥ 1/k`." First read Johnson 1996 (Zbl 0856.05036),
  Johnson 2000 *surprises* (Zbl 0945.05021) and Johnson–Rodger 2005 (Zbl 1059.05050) as far as obtainable; record read status per section.
- **S1c.** For each of the ten minimal survivors (`data/fs81/phaseD/d47/survivors.md`), either a **rational** `θ` on a ℤ-basis of `Λ_M` with
  every `θ(u) mod 1 ∈ [1/4, 3/4]`, `u ∈ U_M`, checked in Fractions, or a named obstruction. The candidate set is the finite set of torsion-type
  assignments per layer that rows 95 and 97 allow — **fix it by derivation before any check**, and log the enumeration as the ban's edge.
  Note the confound (plan §M.1): only 1560 and 2040 have two primes ≡ 1 (mod 4) below 2,520; Λ₁₅₆₀ four-colours by a quotient.
- **S1d.** The shape of the four-class window LP (plan §IQ item 3, §M.1): the window `W` (radius ≥ 2, row 87), the symmetry quotient, the
  orbit-reduced variable and constraint counts, the dual's form as an identity, and a price. No LP runs here.
- **S1e.** Is there a local pattern forbidden in every four-colouring of a ℚ(√47) lattice that is linear on the tetrahedral embedding (G75,
  row 85's NT)? Derive one, or say why none is known (P-G75 predicts none).

## Stages (about 3 h, 350k harness tokens; hand back by 420k)

1. Quotation check of this brief against the plan and rows 75, 88, 92, 95–97; S1a. Save.
2. S1b (with the Johnson reading). Save.
3. S1c. Save.
4. S1d, S1e; the claim list's statements for the verifier, verbatim. Save and report.

**Allowed:** hand derivation; exact arithmetic of seconds (PARI, sympy, Fractions); existing checkers on existing certificates; the finite
enumeration S1c fixes. **Out:** SAT, MILP, `Θ` finders or trees, quotient searches. Keep a would-have-searched-here log. Machine: `scripts/slot.py`
for anything over 2 GiB or 2 minutes; halt on any unexplained crash.

**Report** in standing rule 9's form to `data/crunch-2026-09-25/reports/FS84-S1.md` and by SendMessage to the owner.
