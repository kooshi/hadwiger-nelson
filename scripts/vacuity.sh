#!/usr/bin/env bash
# The vacuity gate — a theorem can pass every other check here and still say nothing.
#
# `scripts/Vacuity.lean` scans the library and prints one line per (declaration, carrier type)
# with one of three verdicts. This script turns that into a pass/fail, against a baseline.
#
# WHY A BASELINE. Deciding vacuity is undecidable, so most carriers come back UNKNOWN — 238 of
# 249 on the first run, because a carrier is only WITNESSED when the library proves it inhabited
# unconditionally. Demanding a witness for all of them today would be a 238-site change. So the
# gate is a RATCHET: everything currently unresolved is grandfathered in the baseline, and the
# check fails on anything NEW. New code must carry its evidence; old code is burned down over
# time by deleting baseline lines. The baseline only ever shrinks.
#
# WHY IT FAILS LOUD. This repository has twice shipped a gate that failed OPEN — the M03 ledger
# comparison that did not exist, and the M04 `set -e` abort inside a command substitution that
# produced no output and read as a pass when piped. So: the Lean status is captured explicitly and
# never through a pipe, a run that does not elaborate is a FAILURE and not an empty result, and a
# missing baseline is a failure rather than a free pass.
set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${REPO}"
source "${REPO}/scripts/dev-env.sh"
BASELINE="${REPO}/scripts/vacuity-baseline.txt"

if ! RAW="$(lake env lean scripts/Vacuity.lean 2>&1)"; then
  echo "${RAW}"
  echo "==> vacuity: FAIL — scripts/Vacuity.lean did not elaborate (above)."
  echo "    A scan that cannot run is not a clean scan. This is the M04 failure mode."
  exit 1
fi
echo "${RAW}" | grep -E '^evidence:|^=== TOTALS' | sed 's/^/    /'

if [[ "${1:-}" == "--baseline" ]]; then
  { echo "# Vacuity baseline — every (verdict, declaration) not yet resolved."
    echo "# The gate fails on anything NOT listed here. This file only ever SHRINKS."
    echo "# A VACUOUS line needs a reason: some are deliberate (a theorem that assumes a"
    echo "# structure in order to REFUTE it cannot be damaged by that structure being empty)."
    echo "# Regenerate deliberately: scripts/vacuity.sh --baseline"
    echo "${RAW}" | grep -E '^(VACUOUS|UNKNOWN) ' | sort -u
  } > "${BASELINE}"
  echo "==> vacuity: baseline written ($(grep -cE '^(VACUOUS|UNKNOWN) ' "${BASELINE}") entries)"
  exit 0
fi

if [[ ! -f "${BASELINE}" ]]; then
  echo "==> vacuity: FAIL — no baseline at ${BASELINE}."
  echo "    Refusing to pass with nothing to compare against; run: scripts/vacuity.sh --baseline"
  exit 1
fi

CUR="$(echo "${RAW}" | grep -E '^(VACUOUS|UNKNOWN) ' | sort -u)"
NEW="$(comm -13 <(grep -E '^(VACUOUS|UNKNOWN) ' "${BASELINE}" | sort -u) <(echo "${CUR}"))"

if [[ -n "${NEW}" ]]; then
  echo "==> vacuity: FAIL — $(echo "${NEW}" | wc -l) site(s) not in the baseline:"
  echo "${NEW}" | sed 's/^/      /'
  echo
  echo "    VACUOUS: the statement is true and says nothing — its hypothesis type is provably"
  echo "             empty. Either fix the statement, or add it to the baseline WITH THE REASON"
  echo "             if the emptiness is the conclusion rather than a hidden hypothesis."
  echo "    UNKNOWN: no unconditional inhabitant is proved for the carrier. Ship one — the rule"
  echo "             is CLAUDE.md G30's fifth failure mode: every theorem whose hypothesis is a"
  echo "             structure ships with a named inhabitant, or a note naming what supplies one."
  exit 1
fi

RESOLVED="$(comm -23 <(grep -E '^(VACUOUS|UNKNOWN) ' "${BASELINE}" | sort -u) <(echo "${CUR}") | wc -l)"
if [[ "${RESOLVED}" -gt 0 ]]; then
  echo "==> vacuity: OK — and ${RESOLVED} baseline entr(ies) are now resolved."
  echo "    The baseline only shrinks: scripts/vacuity.sh --baseline"
else
  echo "==> vacuity: OK"
fi
