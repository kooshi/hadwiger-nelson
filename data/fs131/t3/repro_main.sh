#!/usr/bin/env bash
# FS131-T3 stage 1 — reproduce the axiom gate's defect on `main`, with the gate as committed.
#
# Takes `scripts/axioms.sh` and `scripts/Axioms.lean` from a git revision (default: the commit before
# FS131-T3 touched them, a48ca5bb), patches the script in exactly three places — REPO fixed to this
# repository, the Lean file it elaborates, the gate-log directory (`build/gate/axioms-t3-repro/`, so the
# real gate's `latest` is never moved) — plants records into a copy of the audit, and runs it.
#
#   repro_main.sh defect   a planted `axiom` and a CLEAN record that depends on it; today's gate PASSES (exit 0)
#   repro_main.sh native   the harness's live-check partner: an existing native purchase moved under CLEAN;
#                          today's gate must FAIL (exit 1), showing the harness checks what the gate checks
#
# Usage: data/fs131/t3/repro_main.sh <defect|native> [rev]
set -uo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
CASE="${1:?defect or native}"
REV="${2:-a48ca5bb}"
WORK="${REPO}/build/t3-repro"
mkdir -p "${WORK}"

git -C "${REPO}" show "${REV}:scripts/axioms.sh" \
  | sed -e "s|^REPO=.*|REPO=\"${REPO}\"|" \
        -e 's|lake env lean scripts/Axioms.lean|lake env lean "${T3_LEAN}"|' \
        -e 's|gate_log_open axioms$|gate_log_open axioms-t3-repro|' > "${WORK}/axioms.sh"
for pat in "REPO=\"${REPO}\"" 'lake env lean "${T3_LEAN}"' 'gate_log_open axioms-t3-repro'; do
  grep -qF "${pat}" "${WORK}/axioms.sh" || { echo "repro: the patch did not apply: ${pat}"; exit 2; }
done

case "${CASE}" in
  defect) PLANT='axiom t3_planted_axiom : True
theorem t3_planted_clean_user : True := t3_planted_axiom
#print axioms t3_planted_clean_user' ;;
  native) PLANT='#print axioms moserSpindle_cnf_unsat' ;;
  *) echo "repro: unknown case ${CASE}"; exit 2 ;;
esac
git -C "${REPO}" show "${REV}:scripts/Axioms.lean" \
  | awk -v plant="${PLANT}" '/^#eval IO.println "=== PURCHASED ==="$/ && !done { print plant; print ""; done = 1 } { print }' \
  > "${WORK}/Axioms-${CASE}.lean"
grep -qF "${PLANT%%$'\n'*}" "${WORK}/Axioms-${CASE}.lean" || { echo "repro: the plant did not land"; exit 2; }

T3_LEAN="${WORK}/Axioms-${CASE}.lean" bash "${WORK}/axioms.sh"
STATUS=$?
echo "repro(${CASE}, ${REV}): the committed gate exited ${STATUS}"
exit "${STATUS}"
