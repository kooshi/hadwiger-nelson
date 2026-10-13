# FS133-IA1 — lane A of the one-class transfer's kernel module: the outside side

*de Bruijn, the implementer; job FS133-IA1 (brief: `data/fs133/briefs/FS133-IA1-lane-a.md`, committed on `main` at
`a2fac50e2`). Branch `fs133-wa1`, cut from `fe95f704d` (the planner's head) in the worktree
`.claude/worktrees/fs133-wk1`. The plan is `plans/FS133-kernel-plan.md` § 5.1. Working files: `data/fs133/ia1/`.
The outside release is `[OAIMath2026]` family 158 at commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a` of
`/home/kooshi/source/math` (read, never written), compiled at its own pin by the audit (`~/.cache/ext-oai1/lean`).*

## Theorems this phase proved

*(filled as the leaves close; one line per kernel theorem, with its declaration and its axioms)*

## Stage 1 — SAVED: the readback, the leaves restated, the statements as the kernel holds them before any proof

**1.1 The brief's quotations.** `tools/fs133_ia1_readback.py` (each quoted line a substring of its source, read in
the coordinator's tree, where the brief is committed): **4 matched, 0 mismatched**, exit 0
(`data/fs133/ia1/readback-brief.out`) — W2 against `data/fs131/REQUEST-2026-10-13.md`; K133-ALG, K133-NC-ALG and
K133-NC-ALL against `data/fs133/claims-K1.md`. With `--fault` (the last character of each quoted line changed):
0 matched, 4 mismatched, exit 1 (`readback-brief-fault.out`). No finding about the brief.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make
the gate fail; the plan whole (`plans/FS133-kernel-plan.md`, 600 lines) and the planner's report; the three files
of the lane's statements (`Outside/OAI158Rigidity.lean`, `Plane/OneClass/Field.lean`, and `IsPlaneSystem` in
`Plane/OneClass/Defs.lean`); the last port's generator whole (`tools/fs132_i2_port.py`); the release's
`Analysis/PlaneSpectrum/Representations.lean` and `Geometry/PlaneColoring/BorelTransfer.lean` whole, and
`Analysis/PlaneSpectrum/Basic.lean` ll. 1–70, 215–240.

**1.3 Each leaf, in one line, beside the plan's route.**

| leaf | the statement, in one line (the file's is the statement) | the plan's route (§ 5.1) |
|---|---|---|
| **P** | no statement of ours: twenty-five of the release's lemmas and definitions, with what their proofs name, in a generated module `Outside/OAI158Transfer` | the cone from the release's compiled constants; copy by line range with a generator that refuses a patch to a statement or a definition; the definitions `op` and `space` not repeated (they are upstream in `OAI158Rigidity`) |
| **F** `OneClass.exists_field` (`Plane/OneClass/Field.lean`) | for a plane system `(P, τ, ρ)` and finitely many measurable `[0, 1]`-valued `f i` each fixed by every `ρ u`: there are jointly measurable `H i : ℂ × Ω → ℝ` in `[0, 1]` with (a) `∫ H i (x, ·) = ∫ f i` at every `x`, (b) every almost-sure affine relation `∑ c i · f i = d` holding among the `H i (x, ·)` at every `x`, (c) if `f i · (f j ∘ τ z) = 0` almost surely at one `z ≠ 0` of the algebraic plane then `H i (x, ·) · H j (x + w, ·) = 0` almost surely at every `x` and every `w` with `‖w‖ = ‖z‖` | Koopman unitaries on `Lp ℂ 2 P`; the observables' vectors; their projections on the continuous vectors; **one use of the import** (`inner_proj_shift`, through X); the orbit extension to `ℂ`; the closed-circle induction, scaled; the constant vector; a jointly measurable version and `positive_orthogonal` |
| **X** `Spectral.residual_fourier_cross` (`Outside/OAI158Rigidity.lean`) | under the import's hypotheses on `U`, `W`: two `W`-fixed vectors `v`, `w` of `(space U)ᗮ` have `⟪v, op U z w⟫ = 0` at every `z ≠ 0` | polarisation (`inner_map_polarization`) of the import at `v ± w`, `v ± I • w` |
| **M** `Spectral.residual_fourier_model` (same file) | there are a Hilbert space `H : Type`, `U`, `W`, `v` with the import's three hypotheses, `v ≠ 0`, and the import's conclusion at every `z ≠ 0` | the regular representation on `ℓ²` of the algebraic plane; `v` the point mass at `0`; `v ⟂ space U` because a continuous vector's coordinate at `0` is a limit of coordinates along distinct points, which are square-summable; **its axioms must be the standard three** |

**1.4 The statements as the kernel holds them, before any proof of mine** (the build as the planner left it, for
`fe95f704d`; made before the first rebuild). `data/fs133/ia1/lean/StatementDump.lean` prints every constant stored
in the compiled data of `Outside/OAI158Rigidity` (37) and `Plane/OneClass/Field` (1):
`data/fs133/ia1/statements-before.txt` — 11 named constants (six definitions and the derived instance, the axiom,
the three leaves) and 27 internal ones. The reader, `tools/fs133_ia1_statements.py`, compared the dump with itself
(PASS, 11 compared) and, with `--control`, reported 5 of 5 planted faults (a character of `exists_field`'s stored
type; a definition's value; a character of the axiom's type; the axiom become a theorem; a leaf gone).
