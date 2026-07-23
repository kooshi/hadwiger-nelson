# scripts/dev-env.sh — source this before building Lean here on Arch Linux.
#
#   source scripts/dev-env.sh
#
# Why this exists (Arch-specific): the Lean toolchain ships its own `clang`, but on Arch that
# bundled clang dynamically resolves the *system* /usr/lib/libclang-cpp.so and dies with a
# symbol-lookup error, so any native/C compile (Mathlib's `cache` tool, executables, FFI) fails.
# The fix is two env vars:
#   - LEAN_CC=clang        → compile generated C with the system clang instead of the broken bundle.
#   - LIBRARY_PATH += <toolchain>/lib → the link uses `-Wl,-Bstatic -lc++ -lc++abi`; those static
#     libs are bundled in the toolchain's lib/ dir, which the bundled clang searches implicitly but
#     the system clang does not. Adding it to LIBRARY_PATH lets the linker find them.
# Paths are derived from the *active* toolchain, so this keeps working across `elan`/toolchain bumps.
#
# Also sets LEAN_ABORT_ON_PANIC=1 (de Bruijn core, totality_discipline): make `panic!` abort loudly
# instead of printing and returning a junk `default`.

export LEAN_CC="${LEAN_CC:-clang}"
export LEAN_ABORT_ON_PANIC=1

if command -v elan >/dev/null 2>&1; then
  _lean_lib="$(dirname "$(dirname "$(elan which lean 2>/dev/null)")")/lib"
  if [ -d "$_lean_lib" ]; then
    case ":${LIBRARY_PATH:-}:" in
      *":$_lean_lib:"*) ;;                                   # already present
      *) export LIBRARY_PATH="$_lean_lib${LIBRARY_PATH:+:$LIBRARY_PATH}" ;;
    esac
  fi
  unset _lean_lib
fi
