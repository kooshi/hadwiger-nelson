#!/usr/bin/env bash
# The vacuity gate — a theorem can pass every other check here and still say nothing.
#
# `scripts/Vacuity.lean` scans the library and prints one line per (declaration, carrier type)
# with one of three verdicts. This script turns that into a pass/fail, against a baseline.
#
# WHY A BASELINE, AND WHAT IT MAY HOLD. Deciding vacuity is undecidable, so most carriers come
# back UNKNOWN — 238 of 249, because a carrier is only WITNESSED when the library proves it
# inhabited unconditionally. Demanding a witness for all of them today would be a 238-site change,
# so the gate is a RATCHET: unresolved sites are grandfathered, the check fails on anything new,
# and the baseline only ever shrinks.
#
# **The baseline holds UNKNOWN and nothing else**, and that is a correction to this file's first
# version, which also let VACUOUS in. Those two have OPPOSITE lifecycles: the UNKNOWNs should
# ratchet to zero, while a deliberately-empty statement should never leave — one of them is the
# detector itself, whose whole content is that a domain is empty. Putting both in one shrink-only
# list made the list's own goal incoherent for its own entries, and made a real defect
# indistinguishable from unfinished work. So:
#
#   VACUOUS  — provably empty, UNDECLARED. Always fails. Can never be baselined; a suppression
#              list able to hide this is exactly what this gate exists to prevent.
#   STALE    — a docstring claims emptiness that is NOT proved. Always fails. This is what makes
#              the annotation a claim rather than a `# noqa`.
#   DECLARED — provably empty AND the declaration says so with a reason, in its docstring, which
#              is where CLAUDE.md already requires a `native_decide` purchase to be named. Passes,
#              and is PRINTED with its reason on every run so every deliberate case stays readable
#              in one place and challengeable — the `PURCHASED` banner of `axioms.sh`.
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

# The declared-emptiness ledger, printed every run — never hidden in a file nobody opens.
DECL="$(echo "${RAW}" | grep -E '^DECLARED ' || true)"
if [[ -n "${DECL}" ]]; then
  echo "    --- declared empty, by design ($(echo "${DECL}" | wc -l)) ---"
  echo "${DECL}" | sed 's/^/    /' | cut -c1-160
fi

# VACUOUS and STALE are unconditional failures and are checked BEFORE the baseline, so no
# baseline entry can ever suppress them.
HARD="$(echo "${RAW}" | grep -E '^(VACUOUS|STALE) ' || true)"
if [[ -n "${HARD}" ]]; then
  echo "==> vacuity: FAIL — $(echo "${HARD}" | wc -l) site(s) that no baseline can excuse:"
  echo "${HARD}" | sed 's/^/      /'
  echo
  echo "    VACUOUS: true, kernel-checked, and says NOTHING — its hypothesis type is provably"
  echo "             empty. Either fix the statement, or, if the emptiness is the conclusion"
  echo "             rather than a hidden hypothesis, say so in the declaration's DOCSTRING:"
  echo "               VACUITY DECLARED: <why emptiness is the point here>"
  echo "    STALE:   a docstring declares emptiness that is not proved. The declaration outlived"
  echo "             its truth — remove it, or prove the emptiness it claims."
  exit 1
fi

if [[ "${1:-}" == "--baseline" ]]; then
  { echo "# Vacuity baseline — every (verdict, declaration) not yet resolved."
    echo "# The gate fails on any UNKNOWN not listed here. This file only ever SHRINKS,"
    echo "# and its target is EMPTY. VACUOUS and STALE can never appear here by construction:"
    echo "# they fail the gate outright, and deliberate emptiness is declared in the"
    echo "# declaration's own docstring (VACUITY DECLARED:) rather than suppressed in this file."
    echo "# Regenerate deliberately: scripts/vacuity.sh --baseline"
    echo "${RAW}" | grep -E '^UNKNOWN ' | sort -u
  } > "${BASELINE}"
  echo "==> vacuity: baseline written ($(grep -cE '^UNKNOWN ' "${BASELINE}") entries, UNKNOWN only)"
  exit 0
fi

if [[ ! -f "${BASELINE}" ]]; then
  echo "==> vacuity: FAIL — no baseline at ${BASELINE}."
  echo "    Refusing to pass with nothing to compare against; run: scripts/vacuity.sh --baseline"
  exit 1
fi

CUR="$(echo "${RAW}" | grep -E '^UNKNOWN ' | sort -u)"
NEW="$(comm -13 <(grep -E '^UNKNOWN ' "${BASELINE}" | sort -u) <(echo "${CUR}"))"

if [[ -n "${NEW}" ]]; then
  echo "==> vacuity: FAIL — $(echo "${NEW}" | wc -l) site(s) not in the baseline:"
  echo "${NEW}" | sed 's/^/      /'
  echo
  echo "    UNKNOWN: no unconditional inhabitant is proved for the carrier. Ship one — the rule"
  echo "             is CLAUDE.md G30's fifth failure mode: every theorem whose hypothesis is a"
  echo "             structure ships with a named inhabitant, or a note naming what supplies one."
  exit 1
fi

RESOLVED="$(comm -23 <(grep -E '^UNKNOWN ' "${BASELINE}" | sort -u) <(echo "${CUR}") | wc -l)"
if [[ "${RESOLVED}" -gt 0 ]]; then
  echo "==> vacuity: OK — and ${RESOLVED} baseline entr(ies) are now resolved."
  echo "    The baseline only shrinks: scripts/vacuity.sh --baseline"
else
  echo "==> vacuity: OK"
fi
