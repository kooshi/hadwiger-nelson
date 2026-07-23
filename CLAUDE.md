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
`lean-toolchain` (`leanprover/lean4:v4.32.0`). If `lean` / `lake` are missing, run
`./install-toolchain.sh` — it installs elan from the AUR, then the pinned toolchain. Toolchain and
the Mathlib pin move as one unit.

**Arch build env — required before building.** The toolchain's bundled `clang` is broken against
Arch's system LLVM, so any native/C compile (Mathlib's `cache` tool, executables, FFI) fails unless
you use the system clang plus the toolchain's bundled `libc++`. `source scripts/dev-env.sh` in your
shell (the installer wires this into `~/.profile`; it sets `LEAN_CC`, `LIBRARY_PATH`, and
`LEAN_ABORT_ON_PANIC`). Claude's own shell gets the same via `.claude/settings.local.json`.

## The package
This is the **`proofs`** package (`lakefile.toml`): library **`Proofs`** (`Proofs.lean` is the flat
import surface, modules under `Proofs/`), with `autoImplicit`/`relaxedAutoImplicit` off. **Mathlib**
is pinned to tag `v4.32.0` (matches `lean-toolchain`, so `lake exe cache get` restores prebuilt
oleans instead of a multi-hour source build). `scripts/Axioms.lean` is the day-one trust receipt.

When adding a library/executable, changing dependencies, or bumping Mathlib, work through the
**`debruijn-init`** skill — freshly invoked, per WORKFLOW's fresh-invocation rule. `lake update` /
Mathlib bumps go alone in a labeled commit (they move the ground under every proof).

## The gate
Elaboration is the floor of the test suite: `lake build` green, zero `sorry`, `#print axioms` clean on
the public surface, linters silent, spec examples passing. The InfoView is continuous testimony at
zero cost — save and read the goal state after every step rather than debugging by guess.
