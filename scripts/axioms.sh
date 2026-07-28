#!/usr/bin/env bash
# The trust receipt, checked rather than eyeballed.
#
# `scripts/Axioms.lean` prints one `#print axioms` line per public theorem, split by two printed
# banners. This script enforces the rule the banners encode:
#
#   CLEAN      — nothing but propext / Classical.choice / Quot.sound. A native purchase or a
#                leftover `sorry` here fails the build.
#   PURCHASED  — a native-evaluation axiom is expected, by design. `sorryAx` still fails, and a
#                *missing* purchase fails too: a stale ledger entry means a declaration was cleaned
#                up and the audit was never told.
#
# Why a script and not a reading: at toolchain v4.32.0 `native_decide` mints a *per-declaration*
# axiom (`foo._native.native_decide.ax_1_1`) and `Lean.ofReduceBool` never appears. That difference
# is one long name in a wall of text, and this project's whole trust story rests on someone noticing
# it. So nobody has to.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${REPO}/scripts/dev-env.sh"

RAW="$(cd "${REPO}" && lake env lean scripts/Axioms.lean)"
echo "${RAW}"
echo

# `#print axioms` wraps long axiom lists across lines, so a line-oriented grep would both miss
# records and mis-report them. Rejoin each record onto one line first.
NORM="$(echo "${RAW}" | awk '
  /^=== / { if (buf != "") { print buf; buf = "" }; print; next }
  { buf = (buf == "" ? $0 : buf " " $0); if (index($0, "]") > 0) { print buf; buf = "" } }
  END { if (buf != "") print buf }
' | sed 's/[[:space:]]\+/ /g')"

if ! echo "${NORM}" | grep -q '^=== CLEAN ===$' || ! echo "${NORM}" | grep -q '^=== PURCHASED ===$'; then
  echo "==> axioms: FAIL — banners missing; scripts/Axioms.lean did not run to completion"
  exit 1
fi

CLEAN="$(echo "${NORM}" | sed -n '/^=== CLEAN ===$/,/^=== PURCHASED ===$/p' | grep 'depends on axioms' || true)"
PURCHASED="$(echo "${NORM}" | sed -n '/^=== PURCHASED ===$/,$p' | grep 'depends on axioms' || true)"

BAD=0

if echo "${CLEAN}" | grep -nE 'native_decide|ofReduceBool'; then
  echo "==> FAIL: a native purchase appears in the CLEAN section (above)"
  BAD=1
fi

if echo "${NORM}" | grep -nE 'sorryAx'; then
  echo "==> FAIL: sorryAx on the audited surface (above)"
  BAD=1
fi

if [[ -n "${PURCHASED}" ]] && echo "${PURCHASED}" | grep -v 'native_decide' | grep 'depends on axioms'; then
  echo "==> FAIL: declared purchases that carry no native axiom — stale ledger entry (above)"
  BAD=1
fi

if [[ "${BAD}" -ne 0 ]]; then
  echo "==> axioms: FAIL"
  exit 1
fi

N=$(echo "${PURCHASED}" | grep -c 'depends on axioms' || true)
echo "==> axioms: OK — $(echo "${CLEAN}" | grep -c 'depends on axioms') clean, ${N} declared purchase(s)"
