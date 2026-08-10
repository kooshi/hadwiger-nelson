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

# Capture the status explicitly. Under `set -e` a failing command substitution aborts the script
# with no output at all, so an audit file that stops elaborating — a declaration renamed or removed
# without updating it, which is exactly what this gate exists to catch — would look like a silent
# pass to anyone who piped the output. Found the hard way at M04.
if ! RAW="$(cd "${REPO}" && lake env lean scripts/Axioms.lean 2>&1)"; then
  echo "${RAW}"
  echo "==> axioms: FAIL — scripts/Axioms.lean did not elaborate (above)."
  echo "    A missing constant here means the audit is no longer auditing what it names."
  exit 1
fi
echo "${RAW}"
echo

# `#print axioms` wraps long axiom lists across lines, so a line-oriented grep would both miss
# records and mis-report them. Rejoin each record onto one line first.
NORM="$(echo "${RAW}" | awk '
  /^=== / { if (buf != "") { print buf; buf = "" }; print; next }
  { buf = (buf == "" ? $0 : buf " " $0); if (index($0, "]") > 0) { print buf; buf = "" } }
  END { if (buf != "") print buf }
' | sed 's/[[:space:]]\+/ /g')"

# Here-strings, not pipes: under `pipefail` a `grep -q` that exits on its first match
# SIGPIPEs the `echo` once the text outgrows the 64 KB pipe buffer, and the check
# reports "banners missing" on output that carries both banners. Found the hard way
# when the M26 audit lines pushed the receipt past 64 KB.
if ! grep -q '^=== CLEAN ===$' <<< "${NORM}" || ! grep -q '^=== PURCHASED ===$' <<< "${NORM}"; then
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

# The two ledgers must agree. `Sat/Lrat.lean` establishes the convention that every declaration
# whose proof evaluates a certificate opens its docstring with "**Trust purchase: native
# evaluation.**", so the *source* enumerates the purchases; the PURCHASED banner enumerates them
# from the *environment*. A declaration in one and not the other is the failure this whole gate
# exists to catch: a native purchase nobody wrote down, or a docstring warning about a purchase that
# is no longer made.
# Matches `/-- **Trust purchase:` specifically — the convention is that the phrase *opens the
# declaration's docstring*, so prose that merely discusses the convention (as `Sat/Lrat.lean`'s
# module docstring does, where it is a blockquote) is correctly not a ledger entry.
SRC_LEDGER="$(awk '
  /^\/-- \*\*Trust purchase:/ { pending = 1; next }
  pending && /^(theorem|def|abbrev|instance) / {
    name = $2; sub(/[^A-Za-z0-9_'"'"'.]+$/, "", name); print name; pending = 0
  }
' $(git -C "${REPO}" ls-files 'Proofs/**/*.lean' | sed "s|^|${REPO}/|") | sort -u)"

ENV_LEDGER="$(echo "${PURCHASED}" | sed -n "s/^'[^']*\.\([^'.]*\)' depends on axioms.*/\1/p" | sort -u)"

if ! DIFF="$(diff <(echo "${SRC_LEDGER}") <(echo "${ENV_LEDGER}"))"; then
  echo "==> FAIL: the source ledger and the environment ledger disagree"
  echo "    '<' = docstring says 'Trust purchase' but scripts/Axioms.lean never audits it"
  echo "    '>' = audited as PURCHASED but the docstring does not warn the reader"
  echo "${DIFF}"
  BAD=1
fi

if [[ "${BAD}" -ne 0 ]]; then
  echo "==> axioms: FAIL"
  exit 1
fi

N=$(echo "${PURCHASED}" | grep -c 'depends on axioms' || true)
echo "==> axioms: OK — $(echo "${CLEAN}" | grep -c 'depends on axioms') clean, ${N} declared purchase(s)"
