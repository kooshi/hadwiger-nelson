# FS-132 — the kernel plan (FS132-K1): seven statements about measurable six-colourings, planned blind, then open

*The planner's record (de Bruijn, branch `fs132-wk1`, worktree `.claude/worktrees/fs132-wk1`). Brief:
`data/fs132/briefs/FS132-K1-kernel-plan.md` (on `main` at `e49499f57`). Claim list: `data/fs132/claims-K1.md` (on `main`; the
worktree was cut at `808ef9bf2`, one commit before it, so the list is read from the main tree). Current state only per stage;
each stage is saved before the next starts.*

## Theorems this phase proved

None in the kernel: a planning job. What it states is the skeleton (stage 3 onward); what it derived by hand, blind, is in the
stages below, each at grade [hand, one mind — the planner's, blind of the derivers'].

## Stage 1 — SAVED (FS132-K1): the readback

**Quotations.** By script (the brief's seven `> **C132-…` lines against the claim list's lines of the same key, character for
character): 7 of 7 MATCH. Kooshi's two quotations: both found verbatim at their sources (`data/external/EXT-OAI1-request.md`;
`CLAUDE.md` § Counter-priors). No mismatch to report.

**Read in full**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail (to its line
255); the claim list; the import module `Proofs/HadwigerNelson/Outside/OAI158.lean`; the release's manuscript sections
`introduction.tex`, `palettes.tex`, `transitions.tex`, `interfaces.tex`, `angular.tex` (whole, TeX source); `plans/EXT-OAI1-audit.md`
stages 6 and 8. **Read in part** (definitions and statements, not proofs): the release's Lean `Coloring.lean` (whole),
`Palettes.lean` (whole), `Compactness.lean` 75–300, `Transitions.lean` 1–40, `WeakColoring.lean` 110–176,
`AngularBoundary.lean` 140–335, `Interfaces.lean` 1–135 and its declaration list with `no_four_interfaces`.

**The fence.** Not read: the three derivations, the milestone's plan, the inventories, `data/fs132/claims.md`, the Poros and
handoff records, `data/fs132/{e1,e2,e3,p2,reports}`, the other briefs. One disclosed contact, names only: an `ls plans/FS132*`
in the worktree printed the eight file names (`FS132-close-inventory.md`, `FS132-E1…E4-derivation.md`,
`FS132-I1-implementation.md`, `FS132-L1-landing.md`, `FS132-six-by-the-nerve.md`); no content was shown. The milestone's plan's
file name carries the words "six by the nerve", which is a hint of a route (a nerve/covering argument) and is disclosed as such.

**The dictionary the statements are over** (the manuscript's numbering: §1 introduction, §2 transfer, §3 spectral, §4 rigidity,
§5 palettes, §6 transitions, §7 interfaces, §8 angular):

| the claim list's term | the manuscript | the release's Lean (all for a colouring of the whole plane) | general in `k`? |
|---|---|---|---|
| weak measurable `k`-colouring | Def. 1.2 | `WeakColoring k c` (`Coloring.lean:27`) — copied in `Outside.OAI158` | yes |
| typical point; typical circle sampling | §5.1 | `Typical`, `TypicalSampling` (`Compactness.lean:83–85`) | yes |
| trace family `𝒲_x`; palette `P_x(e)` | Def. 5.1 | `IsTrace c hc x b`; `paletteSet`, `palette c hc x t : Finset (Fin k)` (`Palettes.lean`) | yes |
| closed essential support `H_a` | §5.1 | `spatialSupport c i := (volume.restrict {z | c z = i}).support` (`AngularBoundary.lean:308`) | yes |
| straddle set `Δ(K)` | (7.1), eq. source-24 | `Straddle K := {z | ∃ p ∈ K, ∃ q ∈ K, dist z p < 1 ∧ 1 < dist z q}` (`:147`) | no colouring |
| limiting direction of `K` at `x` | Prop. 7.1 (2) | `ApproachingContinuum x K v` (`:235`) | no colouring |
| transition graph `Γ_x`; cyclic centre | Def. 6.1; (6.6) | `TransitionEdge c i j x` (general `k`); `transitionGraph`, `CyclicCore` (`CyclicCore.lean:213–218`, **`Fin 5` only**) | edge yes, graph no |
| sixty-degree exclusion | Cor. 5.3 | `palette_sixty_disjoint` | to be checked (stage 4) |
| palette cardinality `≤ 2` | Prop. 5.5 | `palette_cardinality` (**`Fin 5` only**) | no |
| the four-cycle exclusion | Prop. 8.5 | `no_four_interfaces` (**`Fin 5` only**, `Interfaces.lean:516`) | no |

Two facts the claims force on the definitions, seen at the readback and carried into stage 2:

1. **The claims' colourings live on an open set `U ⊇ B̄(p, 1)`; every definition of the release and of the import is for the
   whole plane.** A palette "read at the centre `p` with samplings inside `U`" is a new definition here, not a copy.
2. **The claims are at six labels; the release's palette-size bound (Prop. 5.5) and its four-cycle argument are proved at
   five**, and the claim list's own not-claimed lines say which steps spend the count ("M2 and M9 spend six").
