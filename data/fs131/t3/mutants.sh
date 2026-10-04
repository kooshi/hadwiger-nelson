#!/usr/bin/env bash
# FS131-T3 — break the checker itself and watch `--self-test` see it.
#
# Each mutant is a copy of the working `scripts/axioms.sh` with one edit (asserted to have changed the file),
# REPO pinned to this repository so it reads the real audit and controls, run as `--self-test`. A mutant the
# self-test passes is a control that cannot see the fault it was written for.
#
#   A  the subset check off: an axiom that is neither standard, native, sorryAx nor declared raises nothing
#      (the gate as it was before FS131-T3)                          → clean/imported/purchased_undeclared FAIL
#   B  declared imports not recognized: the declared branch removed  → the PASS partner imported_declared FAILs
#   C  the constant: `propext` dropped from the standard three       → the PASS partner baseline FAILs
#   D  the library check off                                          → library_undeclared FAILs
#
# Usage: data/fs131/t3/mutants.sh [A B C D]   (each run is under a minute and a half)
set -uo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
WORK="${REPO}/build/t3-mutants"
mkdir -p "${WORK}/scripts"
declare -A EDIT=(
  [A]='s|^          fail("undeclared-in-" tolower(s),|          if (0) fail("undeclared-in-" tolower(s),|'
  [B]='s|^          if (x in declared) {$|          if (0) {|'
  [C]='s|std\["propext"\]; ||'
  [D]='s|^      for (x in library) if (!(x in declared)) fail|      for (x in library) if (0) fail|'
)
for m in "${@:-A B C D}"; do
  for one in ${m}; do
    out="${WORK}/scripts/axioms-${one}.sh"
    sed -e "s|^REPO=.*|REPO=\"${REPO}\"|" -e "${EDIT[$one]}" "${REPO}/scripts/axioms.sh" > "${out}"
    changed="$(diff "${REPO}/scripts/axioms.sh" "${out}" | grep -c '^>' || true)"
    if [[ "${changed}" -lt 2 ]]; then echo "mutant ${one}: the edit did not apply (${changed} changed line(s))"; exit 2; fi
    bash "${out}" --self-test > "${WORK}/mutant-${one}.log" 2>&1
    status=$?
    echo "mutant ${one}: --self-test exited ${status}; controls that saw it:"
    grep -E '^    FAIL  ' "${WORK}/mutant-${one}.log" | cut -c1-160 || echo "    (none — the controls are blind to mutant ${one})"
  done
done
