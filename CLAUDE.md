# Engineering standard
@DEBRUIJN.md

# Workflow
@WORKFLOW.md

# This workspace — lean-dir

A Lean 4 proof workspace. We write theorems, programs, and tactics to the **de Bruijn** standard
(above) and work milestone-by-milestone through WORKFLOW. Everything reduces to what the kernel
checked plus what we explicitly chose to trust.

## Toolchain
The toolchain is managed by **elan** (the Lean version manager, the rustup analog) and pinned by
`lean-toolchain` (currently `leanprover/lean4:v4.32.0`). If `lean` / `lake` are missing, run
`./install-toolchain.sh` — it installs elan from the AUR, then the pinned toolchain (elan brings
`lean`, `lake`, and per-project pinning). Toolchain and any Mathlib pin move as one unit.

## Standing up a package
There is no Lake package here yet. When we start one, do it deliberately through the **`debruijn-init`**
skill (package/module layout, lakefile options with `autoImplicit` off and the linter set, Mathlib
plus its cache, the CI gate) — freshly invoked, per WORKFLOW's fresh-invocation rule. Do not scaffold
by habit.

## The gate
Elaboration is the floor of the test suite: `lake build` green, zero `sorry`, `#print axioms` clean on
the public surface, linters silent, spec examples passing. The InfoView is continuous testimony at
zero cost — save and read the goal state after every step rather than debugging by guess.
