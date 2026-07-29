#!/usr/bin/env bash
# The untrusted half of the pipeline: DIMACS in, LRAT certificate out.
#
#   scripts/Dimacs.lean  ->  *.cnf  ->  [ this script ]  ->  *.lrat  ->  scripts/EmitLrat.lean
#
# CaDiCaL is an oracle with no standing. It proposes a certificate; Lean's *verified* checker
# (`LRAT.check` + `check_sound`, both shipped in core) decides whether to believe it. A wrong
# certificate cannot pass, and a satisfiable formula has none — so a bug in this script, in CaDiCaL,
# or in the files on disk can only ever cost us a theorem, never buy us a false one.
#
# CaDiCaL ships with the toolchain; nothing needs installing.
#
# Usage:
#   ./tools/solve.sh            # emit DIMACS, then solve everything
#   ./tools/solve.sh --no-emit  # solve the .cnf files already on disk
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${REPO}/scripts/dev-env.sh"

CADICAL="${CADICAL:-$(lean --print-prefix)/bin/cadical}"
SATDIR="${REPO}/build/sat"

if [[ "${1:-}" != "--no-emit" ]]; then
  echo "==> emitting DIMACS from the Lean encoding"
  (cd "${REPO}" && lake env lean scripts/Dimacs.lean)
  echo
fi

[[ -x "${CADICAL}" ]] || { echo "cadical not found at ${CADICAL}" >&2; exit 1; }

echo "==> solving ($(basename "${CADICAL}"): $("${CADICAL}" --version))"
FAIL=0
for cnf in "${SATDIR}"/*.cnf; do
  base="${cnf%.cnf}"
  name="$(basename "${base}")"
  # `--lrat --no-binary`: emit a textual LRAT certificate. Textual because `EmitLrat.lean` renders
  # it into Lean source, and a diffable intermediate is worth the bytes at this scale. (M05 will
  # want `--binary`; `loadLRATProof` reads both, sniffing the first byte.)
  set +e
  "${CADICAL}" --lrat --no-binary "${cnf}" "${base}.lrat" > "${base}.log" 2>&1
  rc=$?
  set -e
  case "${rc}" in
    20) printf '  %-20s UNSAT   %6s bytes  %s actions\n' "${name}" \
          "$(stat -c%s "${base}.lrat")" "$(grep -c . "${base}.lrat")" ;;
    10) echo "  ${name}  SATISFIABLE — no certificate exists. The formula is not what you think:"
        echo "      a satisfiable encoding means the graph IS colourable at this k, or the"
        echo "      encoding dropped clauses. Check scripts/Dimacs.lean's output against"
        echo "      '#eval CNF.dimacs (coloringCNF ...)' before suspecting the solver."
        FAIL=1 ;;
    *)  echo "  ${name}  cadical exited ${rc} — see ${base}.log"; FAIL=1 ;;
  esac
done

if [[ "${FAIL}" -ne 0 ]]; then
  echo "==> solve: FAIL"
  exit 1
fi

echo
echo "==> solve: OK — now render the certificates into Lean (the script writes the module itself;"
echo "    do not redirect its output, which is progress reporting):"
echo "      lake env lean scripts/EmitLrat.lean"
