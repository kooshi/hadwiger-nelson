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
#
# WHAT IT PRINTS, AND WHAT IT KEEPS. A scan takes minutes, and this file used to keep three lines of
# it, so the declaration count, or the names of two new sites, meant scanning again. The scan's complete
# output is now saved under `build/gate/vacuity/` (`scripts/gate-log.sh`), and `scripts/gate_report.py`
# prints the digest from that file: every count the scan computed and whether it still matches the counts
# recorded in the baseline's header and in `CLAUDE.md` § The gate (each read, and each reported on its own
# line; an unreadable one fails the digest, exit 3), the witnessed sites with the evidence behind each, and every site or
# evidence row that changed since the previous complete run. The rows the gate decides on — declared,
# vacuous, stale, unknown — follow in full, never cut at a column.
set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${REPO}"
source "${REPO}/scripts/dev-env.sh"
source "${REPO}/scripts/gate-log.sh"
BASELINE="${REPO}/scripts/vacuity-baseline.txt"

# The non-empty lines of $1, and how many — so an empty list is zero rows, never one blank one.
rows() { printf '%s\n' "$1" | sed '/^$/d'; }
count() { rows "$1" | grep -c . || true; }
kept() { echo "    full output: ${GATE_LOG#"${REPO}"/}"; }

# ---------------------------------------------------------------------------------------------
# --self-test — break the check on purpose and watch it fail.
#
# `RUNNING.md` § "Make the gate fail, and watch it fail": a check is not known to work until it has
# been seen to fail, and this repository has twice shipped a gate that failed OPEN. Until
# 2026-09-09 this gate's controls could not be run at all — `scripts/Vacuity.lean`'s header says
# how — so they are now a flag rather than a memory.
#
# The planted declarations, in `scripts/vacuity-controls.lean`, spliced into a COPY of the audit
# (never the file itself, which must stay editable while a run is in flight).
# ---------------------------------------------------------------------------------------------
if [[ "${1:-}" == "--self-test" ]]; then
  gate_log_open vacuity-self-test
  TMP="$(mktemp -d)"
  awk 'BEGIN{ins=0} /^namespace VacuityAudit$/ && !ins {while((getline l < "'"${REPO}"'/scripts/vacuity-controls.lean")>0) print l; ins=1} {print}' \
    "${REPO}/scripts/Vacuity.lean" > "${TMP}/Vacuity.lean"

  if ! OUT="$(lake env lean "${TMP}/Vacuity.lean" 2>&1)"; then
    printf '%s\n' "${OUT}" > "${GATE_LOG}"
    echo "${OUT}"
    echo "==> vacuity self-test: FAIL — the control run did not elaborate (above)."
    rm -rf "${TMP}"; exit 1
  fi
  rm -rf "${TMP}"
  printf '%s\n' "${OUT}" > "${GATE_LOG}"
  gate_log_complete
  grep -E '^=== (SCANNED|TOTALS) ===' <<< "${OUT}" | sed 's/^/    control run: /'

  fails=0
  ran=0
  # Here-strings, never `echo | grep -q`: under `pipefail` a `grep -q` that stops at its first match
  # SIGPIPEs the writer once the text outgrows the pipe buffer, and a control that fired reads as
  # absent (`axioms.sh` found this at M26). The per-site rows made this output large enough to hit it.
  expect() {  # expect <verdict> <declaration> <what it proves>
    ran=$((ran+1))
    if grep -qE "^$1 HadwigerNelson\.$2\$" <<< "${OUT}"; then
      echo "    ok    $1 $2 — $3"
    else
      echo "    FAIL  expected '$1 $2' and it is absent — $3"
      grep -E "^(SITE )?[A-Z]+ HadwigerNelson\.$2( |\$)" <<< "${OUT}" | sed 's/^/            got: /'
      fails=$((fails+1))
    fi
  }
  # `GENERIC` is never in the FLAGGED list (nobody can discharge it), so it is read from the SITE rows.
  expect_site() {  # expect_site <verdict> <declaration> <what it proves>
    ran=$((ran+1))
    if grep -qE "^SITE $1 HadwigerNelson\.$2 ::" <<< "${OUT}"; then
      echo "    ok    SITE $1 $2 — $3"
    else
      echo "    FAIL  expected 'SITE $1 $2' and it is absent — $3"
      grep -E "^(SITE )?[A-Z]+ HadwigerNelson\.$2( |\$)" <<< "${OUT}" | sed 's/^/            got: /'
      fails=$((fails+1))
    fi
  }
  # Any verdict row counts, the per-site `SITE` rows included: a planted refutation that produced even
  # a `GENERIC` row has been audited against the emptiness it proves.
  silent() {  # silent <declaration> <what it proves>
    ran=$((ran+1))
    if grep -qE "^(SITE )?[A-Z]+ HadwigerNelson\.$1( |\$)" <<< "${OUT}"; then
      echo "    FAIL  $1 produced a row and must produce none — $2"
      grep -E "^(SITE )?[A-Z]+ HadwigerNelson\.$1( |\$)" <<< "${OUT}" | sed 's/^/            got: /'
      fails=$((fails+1))
    else
      echo "    ok    (no row) $1 — $2"
    fi
  }

  echo "==> vacuity self-test: the planted controls, each watched to fire (the count is printed at the end)"
  expect VACUOUS planted_vacuous_coloring "the core9_plane shape: a colouring type the library proves empty"
  expect VACUOUS planted_vacuous_prop     "a tracked Prop hypothesis the library refutes"
  expect VACUOUS planted_vacuous_forces   "a Forces hypothesis refuted by a theorem in the same run"
  expect UNKNOWN planted_unknown_prop     "THE LOAD-BEARING ONE: same family, an instantiation nothing refutes"
  expect VACUOUS planted_vacuous_ae       "AeColouring 1: a structure whose emptiness is a theorem (FS131-T1's defect)"
  expect_site GENERIC planted_generic_ae     "AeColouring k at a variable k: parametric"
  expect UNKNOWN planted_unknown_ae       "AeColouring at a k nothing refutes: the load-bearing half for the new family"
  expect VACUOUS planted_vacuous_valid    "ArcMap.Valid at a concrete map the library refutes"
  expect_site GENERIC planted_generic_valid   "ArcMap.Valid at a variable map: parametric"
  expect UNKNOWN planted_ae_def           "a user-written def concluding a tracked structure is still audited (the generated-API filter is narrow)"
  silent planted_not_valid                "the ArcMap refutation is never audited against the emptiness it proves"
  expect STALE   planted_stale            "a VACUITY DECLARED: annotation whose claim is false"
  silent planted_refutation               "a refutation's binders are meant to be empty"
  silent planted_not_forces               "the evidence itself is never audited against the emptiness it proves"
  expect VACUOUS planted_vacuous_ne       "a conclusion x ≠ y over AeColouring 1: a stated negation is not a refutation (FS131-T2's defect)"
  expect VACUOUS planted_vacuous_not      "a conclusion ¬ P over AeColouring 1: the same"
  expect_site GENERIC planted_generic_ne  "the ≠ shape at a variable k: parametric"
  expect_site GENERIC planted_generic_not "the ¬ shape at a variable k: parametric"
  expect UNKNOWN planted_unknown_ne       "the ≠ shape at a k nothing refutes: the load-bearing half"
  expect VACUOUS planted_vacuous_ringArc  "IsRingArc at halfPlane2's ring, which carries no arc of Γ (wave 3, FS131-I3h)"
  expect_site GENERIC planted_generic_ringArc "IsRingArc at a variable map: parametric"
  expect UNKNOWN planted_unknown_ringArc  "IsRingArc at a sixFrag instance nothing decides: the load-bearing half"
  expect VACUOUS planted_vacuous_qArc     "IsQArc at halfPlane2's ring (no ring arc, so no (Q) arc)"
  expect_site GENERIC planted_generic_qArc "IsQArc at a variable map: parametric"
  expect UNKNOWN planted_unknown_qArc     "IsQArc at a sixFrag instance nothing decides: the load-bearing half"
  expect VACUOUS planted_vacuous_changePoint "IsChangePoint at r(90°) = i, off halfPlane2's Γ"
  expect_site GENERIC planted_generic_changePoint "IsChangePoint at a variable map: parametric"
  expect UNKNOWN planted_unknown_changePoint "IsChangePoint at a sixFrag instance nothing decides: the load-bearing half"
  expect VACUOUS planted_vacuous_hub      "IsHub at r(90°) = i: no change point there"
  expect_site GENERIC planted_generic_hub "IsHub at a variable map: parametric"
  expect UNKNOWN planted_unknown_hub      "IsHub at a sixFrag instance nothing decides: the load-bearing half"
  expect VACUOUS planted_vacuous_cp       "CPColouring 1: emptiness by an instance, the adversary (wave 2, FS131-I2n)"
  expect_site GENERIC planted_generic_cp  "CPColouring k at a variable k: parametric"
  expect UNKNOWN planted_unknown_cp       "CPColouring at a k nothing refutes: the load-bearing half"
  expect VACUOUS planted_vacuous_semiconcave "SemiconcaveWith at the lower unit arc, which not_semiconcaveWith_one_lowerArc refutes"
  expect_site GENERIC planted_generic_semiconcave "SemiconcaveWith at variable arguments: parametric"
  expect UNKNOWN planted_unknown_semiconcave "SemiconcaveWith at a concrete instance nothing decides: the load-bearing half"
  expect VACUOUS planted_vacuous_horn     "IsHorn at i, which bowtie_not_isHorn_I_axis refutes (wave 4, FS131-G4)"
  expect_site GENERIC planted_generic_horn "IsHorn at a variable map: parametric"
  expect UNKNOWN planted_unknown_horn     "IsHorn at -i, which no closed theorem refutes: the load-bearing half"
  expect VACUOUS planted_vacuous_stuck    "IsStuck at i, which bowtie_not_isStuck_I refutes"
  expect_site GENERIC planted_generic_stuck "IsStuck at a variable map: parametric"
  expect UNKNOWN planted_unknown_stuck    "IsStuck at -i, which no closed theorem refutes: the load-bearing half"
  expect VACUOUS planted_vacuous_condition5 "Condition5 at unitArcPlane, which unitArcPlane_not_condition5 refutes"
  expect_site GENERIC planted_generic_condition5 "Condition5 at a variable map: parametric"
  expect UNKNOWN planted_unknown_condition5 "Condition5 at segPlane, true but proved nowhere: the load-bearing half"
  expect VACUOUS planted_vacuous_aeRegions "AeProperRegions 1: emptiness by an instance, the adversary"
  expect_site GENERIC planted_generic_aeRegions "AeProperRegions k at a variable k: parametric"
  expect UNKNOWN planted_unknown_aeRegions "AeProperRegions at a k nothing refutes: the load-bearing half"
  silent planted_arrow_false              "a genuine refutation P → False over the empty carrier stays skipped"

  if [[ "${fails}" -gt 0 ]]; then
    echo "==> vacuity self-test: FAIL — ${fails} of ${ran} control(s) did not behave as designed."
    echo "    The gate cannot be trusted until every one of these fires. Do not baseline around it."
    kept
    exit 1
  fi
  echo "==> vacuity self-test: OK — all ${ran} controls behaved: every one fired, and the silent ones stayed silent."
  kept
  exit 0
fi

gate_log_open vacuity
if ! RAW="$(lake env lean scripts/Vacuity.lean 2>&1)"; then
  printf '%s\n' "${RAW}" > "${GATE_LOG}"
  echo "${RAW}"
  echo "==> vacuity: FAIL — scripts/Vacuity.lean did not elaborate (above)."
  echo "    A scan that cannot run is not a clean scan. This is the M04 failure mode."
  exit 1
fi
printf '%s\n' "${RAW}" > "${GATE_LOG}"
PREV="${GATE_PREV}"
gate_log_complete

# The digest: every count, the recorded counts, the witnessed sites, and what changed since the last run.
# Its exit status says which failure it is (read here directly, never through a pipe): 2, the scan's output
# is not the shape the digest reads; 3, the digest is complete but a recorded count could not be read, so
# the comparison with it did not run (J32, 2026-09-25).
python3 "${REPO}/scripts/gate_report.py" vacuity "${GATE_LOG}" "${PREV}" "${BASELINE}" "${REPO}/CLAUDE.md"
DIGEST=$?
if [[ "${DIGEST}" -eq 3 ]]; then
  echo "==> vacuity: FAIL — a recorded count could not be read (above), so the comparison with it did not run."
  echo "    The scan itself is fine and its digest above is complete. The nine counts belong in the baseline's"
  echo "    header and in CLAUDE.md § The gate; this run's, in the header's form:"
  python3 "${REPO}/scripts/gate_report.py" header "${GATE_LOG}" | sed 's/^/      /'
  kept
  exit 1
elif [[ "${DIGEST}" -ne 0 ]]; then
  echo "==> vacuity: FAIL — no digest could be built from this run's output (above). The scan's output"
  echo "    format is a contract, and a digest that silently printed less would be this gate failing open."
  kept
  exit 1
fi

# The declared-emptiness ledger, printed every run and in full — never hidden in a file nobody opens,
# and never cut at a column: a reason nobody can read whole is a reason nobody can challenge.
DECL="$(grep -E '^DECLARED ' <<< "${RAW}" || true)"
if [[ -n "${DECL}" ]]; then
  echo "    --- declared empty, by design ($(count "${DECL}")) ---"
  rows "${DECL}" | sed 's/^/    /'
fi

# A declaration the scanner could not telescope was not classified at all; the scan reports how many.
# Zero is the only acceptable count — anything else is a check that could not run (review 2026-09-13).
UNTEL="$(grep -oE 'untelescoped=[0-9]+' <<< "${RAW}" | tail -1 | cut -d= -f2)"
if [[ -z "${UNTEL}" || "${UNTEL}" != "0" ]]; then
  echo "==> vacuity: FAIL — ${UNTEL:-no} declaration(s) could not be telescoped and were not classified:"
  grep -E '^UNTELESCOPED ' <<< "${RAW}" | sed 's/^/      /' || true
  kept
  exit 1
fi

# VACUOUS and STALE are unconditional failures and are checked BEFORE the baseline, so no
# baseline entry can ever suppress them.
HARD="$(grep -E '^(VACUOUS|STALE) ' <<< "${RAW}" || true)"
if [[ -n "${HARD}" ]]; then
  echo "==> vacuity: FAIL — $(count "${HARD}") site(s) that no baseline can excuse:"
  rows "${HARD}" | sed 's/^/      /'
  echo
  echo "    VACUOUS: true, kernel-checked, and says NOTHING — its hypothesis type is provably"
  echo "             empty. Either fix the statement, or, if the emptiness is the conclusion"
  echo "             rather than a hidden hypothesis, say so in the declaration's DOCSTRING:"
  echo "               VACUITY DECLARED: <why emptiness is the point here>"
  echo "    STALE:   a docstring declares emptiness that is not proved. The declaration outlived"
  echo "             its truth — remove it, or prove the emptiness it claims."
  kept
  exit 1
fi

if [[ "${1:-}" == "--baseline" ]]; then
  # The baseline may only SHRINK (review 2026-09-13): regenerating it must never absorb a new UNKNOWN.
  # Anything not already listed is a regression to fix or to declare, not to baseline.
  if [[ -f "${BASELINE}" ]]; then
    NEW="$(comm -23 <(grep -E '^UNKNOWN ' <<< "${RAW}" | sort -u) <(grep -E '^UNKNOWN ' "${BASELINE}" | sort -u) || true)"
    if [[ -n "${NEW}" ]]; then
      echo "==> vacuity: FAIL — --baseline refused: $(count "${NEW}") UNKNOWN site(s) are not in the current baseline,"
      echo "    and a baseline only ever shrinks. Fix the statement or declare the emptiness in its docstring:"
      rows "${NEW}" | sed 's/^/      /'
      kept
      exit 1
    fi
  fi
  # The header records this run's nine counts, which every later run's digest compares against; a
  # baseline written without them made the next run's comparison impossible (J32, 2026-09-25).
  if ! COUNTS="$(python3 "${REPO}/scripts/gate_report.py" header "${GATE_LOG}")"; then
    echo "${COUNTS}"
    echo "==> vacuity: FAIL — --baseline refused: this run's counts could not be read for the new header (above)."
    kept
    exit 1
  fi
  { echo "# Vacuity baseline — every (verdict, declaration) not yet resolved."
    echo "# The gate fails on any UNKNOWN not listed here. This file only ever SHRINKS,"
    echo "# and its target is EMPTY. VACUOUS and STALE can never appear here by construction:"
    echo "# they fail the gate outright, and deliberate emptiness is declared in the"
    echo "# declaration's own docstring (VACUITY DECLARED:) rather than suppressed in this file."
    echo "# Regenerate deliberately: scripts/vacuity.sh --baseline"
    echo "#"
    echo "# Counts to hold, because a silent change in them is this gate's own failure mode; written from"
    echo "# this run's scan, and compared with every later run by scripts/gate_report.py:"
    printf '%s\n' "${COUNTS}"
    grep -E '^UNKNOWN ' <<< "${RAW}" | sort -u
  } > "${BASELINE}"
  echo "==> vacuity: baseline written ($(grep -cE '^UNKNOWN ' "${BASELINE}") entries, UNKNOWN only)"
  kept
  exit 0
fi

if [[ ! -f "${BASELINE}" ]]; then
  echo "==> vacuity: FAIL — no baseline at ${BASELINE}."
  echo "    Refusing to pass with nothing to compare against; run: scripts/vacuity.sh --baseline"
  kept
  exit 1
fi

CUR="$(grep -E '^UNKNOWN ' <<< "${RAW}" | sort -u)"
BASE="$(grep -E '^UNKNOWN ' "${BASELINE}" | sort -u)"
NEW="$(comm -13 <(rows "${BASE}") <(rows "${CUR}"))"
HELD="$(comm -12 <(rows "${BASE}") <(rows "${CUR}"))"
RESOLVED="$(comm -23 <(rows "${BASE}") <(rows "${CUR}"))"

if [[ -n "${HELD}" ]]; then
  echo "    --- unknown, held by the baseline ($(count "${HELD}")) ---"
  rows "${HELD}" | sed 's/^/    /'
fi

if [[ -n "${NEW}" ]]; then
  echo "==> vacuity: FAIL — $(count "${NEW}") site(s) not in the baseline:"
  rows "${NEW}" | sed 's/^/      /'
  echo
  echo "    UNKNOWN: no unconditional inhabitant is proved for the carrier. Ship one — the rule"
  echo "             is G30's fifth failure mode (plans/GROKKINGS-RETIRED.md): every theorem whose hypothesis is a"
  echo "             structure ships with a named inhabitant, or a note naming what supplies one."
  kept
  exit 1
fi

if [[ -n "${RESOLVED}" ]]; then
  echo "==> vacuity: OK — and $(count "${RESOLVED}") baseline entr(ies) are now resolved:"
  rows "${RESOLVED}" | sed 's/^/      /'
  echo "    The baseline only shrinks: scripts/vacuity.sh --baseline"
else
  echo "==> vacuity: OK"
fi
kept
