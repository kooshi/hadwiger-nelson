#!/usr/bin/env bash
# The vacuity gate — a theorem can pass every other check here and still say nothing.
#
# `scripts/Vacuity.lean` scans the library and prints one line per (declaration, carrier type)
# with one of six verdicts. This script turns that into a pass/fail, against a baseline.
#
# WHY A BASELINE, AND WHAT IT MAY HOLD. Deciding vacuity is undecidable, so a carrier is only
# WITNESSED when the library proves it inhabited unconditionally, and unresolved sites have to be
# grandfathered: the gate is a RATCHET — it fails on anything new, and the baseline only ever
# shrinks. It held 15 entries at introduction and holds 4 today, all four principled.
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
#   DECLARED - provably empty AND the declaration says so with a reason, in its docstring, which
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

# ---------------------------------------------------------------------------------------------
# --self-test — break the check on purpose and watch it fail.
#
# `CLAUDE.md` § "Make the gate fail, and watch it fail": a check is not known to work until it has
# been seen to fail, and this repository has twice shipped a gate that failed OPEN. Until
# 2026-09-09 this gate's controls could not be run at all — `scripts/Vacuity.lean`'s header says
# how — so they are now a flag rather than a memory.
#
# Seven planted declarations, in `scripts/vacuity-controls.lean`, spliced into a COPY of the audit
# (never the file itself, which must stay editable while a run is in flight).
# ---------------------------------------------------------------------------------------------
if [[ "${1:-}" == "--self-test" ]]; then
  TMP="$(mktemp -d)"
  awk 'BEGIN{ins=0} /^namespace VacuityAudit$/ && !ins {while((getline l < "'"${REPO}"'/scripts/vacuity-controls.lean")>0) print l; ins=1} {print}' \
    "${REPO}/scripts/Vacuity.lean" > "${TMP}/Vacuity.lean"

  if ! OUT="$(lake env lean "${TMP}/Vacuity.lean" 2>&1)"; then
    echo "${OUT}"
    echo "==> vacuity self-test: FAIL — the control run did not elaborate (above)."
    rm -rf "${TMP}"; exit 1
  fi
  rm -rf "${TMP}"

  fails=0
  expect() {  # expect <verdict> <declaration> <what it proves>
    if echo "${OUT}" | grep -qE "^$1 HadwigerNelson\.$2\$"; then
      echo "    ok    $1 $2 — $3"
    else
      echo "    FAIL  expected '$1 $2' and it is absent — $3"
      echo "${OUT}" | grep -E "HadwigerNelson\.$2\$" | sed 's/^/            got: /'
      fails=$((fails+1))
    fi
  }
  silent() {  # silent <declaration> <what it proves>
    if echo "${OUT}" | grep -qE "^[A-Z]+ HadwigerNelson\.$1\$"; then
      echo "    FAIL  $1 produced a row and must produce none — $2"
      fails=$((fails+1))
    else
      echo "    ok    (no row) $1 — $2"
    fi
  }

  echo "==> vacuity self-test: seven planted defects, each watched to fire"
  expect VACUOUS planted_vacuous_coloring "the core9_plane shape: a colouring type the library proves empty"
  expect VACUOUS planted_vacuous_prop     "a tracked Prop hypothesis the library refutes"
  expect VACUOUS planted_vacuous_forces   "a Forces hypothesis refuted by a theorem in the same run"
  expect UNKNOWN planted_unknown_prop     "THE LOAD-BEARING ONE: same family, an instantiation nothing refutes"
  expect STALE   planted_stale            "a VACUITY DECLARED: annotation whose claim is false"
  silent planted_refutation               "a refutation's binders are meant to be empty"
  silent planted_not_forces               "the evidence itself is never audited against the emptiness it proves"

  if [[ "${fails}" -gt 0 ]]; then
    echo "==> vacuity self-test: FAIL — ${fails} control(s) did not behave as designed."
    echo "    The gate cannot be trusted until every one of these fires. Do not baseline around it."
    exit 1
  fi
  echo "==> vacuity self-test: OK — every control fired, and the two silent ones stayed silent."
  exit 0
fi

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
