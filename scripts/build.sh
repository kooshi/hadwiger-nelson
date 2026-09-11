#!/usr/bin/env bash
# The build, with a bound on how much memory it can ask for.
#
# **Never run a bare `lake build` in this repository.** Lake 5.0.0 has no `-j`; it sizes its job pool
# from the machine and this project has modules that peak at ~9 GB each, so an unrestricted build asks
# for a few hundred gigabytes. That is not a hypothetical: it took the desktop down twice, on
# 2026-07-30, and the second time the failure was watched — memory ramping up, falling back, ramping
# higher, until the machine stopped responding.
#
# Two things make an unrestricted build worse here than the arithmetic suggests:
#
#   * a `systemd` memory cap alone does **not** save the machine. Lean `mmap`s its `.olean` files, so
#     the largest reclaimable thing in the cgroup is the page cache holding them. At the limit the
#     kernel reclaims those pages and then has to read them back — and with `MemorySwapMax=0` on a
#     slow boot device that is an I/O stall, not a clean kill. The cap converts an out-of-memory into
#     a thrash. It is still worth setting, as a backstop; it is not a plan.
#   * deleting a generated `.c` under `.lake/build/ir/` invalidates the *`leanArts`* facet, so it
#     marks the module out of date exactly as deleting the `.olean` would. Clearing an `ir/` directory
#     to "clean up" therefore queues a full rebuild of everything under it.
#
# So the batch, not the cap, is the control. Modules are built in dependency order, leaves first, in
# groups of `BATCH`, and every group is named explicitly — which is the only way to know what a group
# will run, since naming a target whose dependencies are missing pulls those in too.
#
# **Nothing a batch prints is thrown away.** Every attempt's complete Lake output is appended, under a
# header, to this run's log in `build/gate/build/` (`scripts/gate-log.sh`) before anything reads it. The
# terminal gets each module that printed a warning or an error, with its messages; every line Lake prints
# outside a module; and which modules each batch actually rebuilt, with the time each took. The first
# version kept each batch in a temp file that the next batch overwrote and the exit deleted, showed at
# most twenty keyword-matching lines of it — without the messages under them — and let a retry overwrite
# the output of the attempt that had failed.
#
# Usage:
#   scripts/build.sh              # the whole library
#   BATCH=4 scripts/build.sh      # smaller groups, if something else is using the machine
#   scripts/build.sh --plan       # print the batches and exit; builds nothing
set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${REPO}"
source "${REPO}/scripts/dev-env.sh"
source "${REPO}/scripts/gate-log.sh"

# Measured on the desktop, 2026-07-30: a certificate segment peaks at 8.9 GB. Ten of those is ~89 GB,
# and M06 ran twelve concurrently on this machine without trouble — but leave room for the page cache,
# because the pages being evicted are the `.olean` files the build is reading. Raise it only with a
# measurement in hand; `CLAUDE.md` has the one-liner.
BATCH="${BATCH:-10}"
MEMMAX="${MEMMAX:-100G}"

mapfile -t LAYERS < <(python3 "${REPO}/scripts/build_order.py" "${BATCH}")
if [[ "${#LAYERS[@]}" -eq 0 ]]; then
  echo "==> build: FAIL — could not compute a build order"; exit 1
fi

if [[ "${1:-}" == "--plan" ]]; then
  printf '%s\n' "${LAYERS[@]}" | nl
  echo "==> ${#LAYERS[@]} batches of at most ${BATCH}"
  exit 0
fi

gate_log_open build
ATTEMPT="${GATE_LOG%.log}.attempt"
WARNED_MODULES="${GATE_LOG%.log}.warned"   # modules whose warnings this run has already shown
: > "${WARNED_MODULES}"
trap 'rm -f "${ATTEMPT}" "${WARNED_MODULES}"' EXIT

# One attempt at the current batch (`i`, `BATCH_TARGETS`). Its whole output is appended to the run's log
# before anything reads it, so no later step — a retry, a filter, an early exit — can lose it.
# No pipeline around `lake`: its exit status is the thing this gate is built on, and a pipe reports the
# *last* command's status instead. M04 lost a whole audit to exactly that.
run_attempt() {  # run_attempt <attempt number>
  local t0 rc
  t0="$(date +%s)"
  systemd-run --user --scope -q -p "MemoryMax=${MEMMAX}" -p MemorySwapMax=0 -- \
    lake build "${BATCH_TARGETS[@]}" > "${ATTEMPT}" 2>&1
  rc=$?
  { printf '### batch %d/%d, attempt %d: exit %d after %ds: %s\n' "$((i + 1))" "${#LAYERS[@]}" "$1" \
      "${rc}" "$(( $(date +%s) - t0 ))" "${BATCH_TARGETS[*]}"
    cat "${ATTEMPT}"
  } >> "${GATE_LOG}"
  return "${rc}"
}

# What a reader needs from one attempt: each module that printed an error, with its messages; each module
# that printed a warning, with its messages, the first time this run shows it; and everything Lake says
# outside a module — the failure summary among it. Left to the log alone: success lines; `trace:` lines (a
# failed module's whole command line); a module whose only output is `info` (`#eval` results); and a
# warning Lake replays from its cache each time a later batch depends on that module — measured
# 2026-09-11, when one planted warning was printed twice and counted twice.
# Lake's module lines are `<icon> [k/n] <verb> <module> (<time>)`, icons ✔ ℹ ⚠ ✖ (Lake/Build/Run.lean).
show_output() {
  awk -v seen="${WARNED_MODULES}" '
    BEGIN { while ((getline m < seen) > 0) shown[m] = 1; close(seen) }
    /^(✔|ℹ|⚠|✖) \[[0-9]+\/[0-9]+\] / {
      inmod = ($1 != "✔")
      show = ($1 == "✖") || ($1 == "⚠" && !($4 in shown))
      if ($1 == "⚠" && !($4 in shown)) { shown[$4] = 1; print $4 >> seen }
      if (show) print
      next
    }
    /^Build completed successfully/  { inmod = 0; next }
    /^Some required targets logged failures:/ { inmod = 0; print; next }
    /^trace: /                       { next }
    inmod                            { if (show) print; next }
    /^info: /                        { next }
    NF                               { print }
  ' "$1" | sed 's/^/    /'
}

# `<module>\t<time>` for every module an attempt actually built (not replayed from cache).
built_modules() {
  sed -nE 's/^(✔|ℹ|⚠|✖) \[[0-9]+\/[0-9]+\] Built ([^ ]+)( \(([^)]*)\))?$/\2\t\4/p' "$1"
}

# **Whether there is anything to do is asked once, not once per batch.** Walking the batches of an
# up-to-date library still starts Lake once per batch — measured 3m20s on the desktop, 2026-09-11, for a
# build that compiled nothing. So Lake is first asked about every module the batches would name, with
# `--no-build`: it compiles nothing, exits 0 when every target is up to date and 3 when any needs
# building (`noBuildCode`, Lake/Build/Run.lean). Only 0 skips the walk. Any other status — stale, broken,
# or the check itself failing — walks the batches exactly as before, so a check that cannot run can
# cost time but can never skip a build. It runs under the same memory cap as a batch. For a stale module
# Lake writes a `.nobuild` file beside its trace; it is removed when that module is next built, and is
# inert until then (Lake/Build/Common.lean, `buildAction`).
mapfile -t ALL_MODULES < <(printf '%s\n' "${LAYERS[@]}" | tr ' ' '\n' | sed '/^$/d')
CHECK_START="$(date +%s)"
systemd-run --user --scope -q -p "MemoryMax=${MEMMAX}" -p MemorySwapMax=0 -- \
  lake build --no-build "${ALL_MODULES[@]}" > "${ATTEMPT}" 2>&1
RC=$?
CHECK_SECS=$(( $(date +%s) - CHECK_START ))
{ printf '### up-to-date check, lake build --no-build over %d modules: exit %d after %ds\n' \
    "${#ALL_MODULES[@]}" "${RC}" "${CHECK_SECS}"
  cat "${ATTEMPT}"
} >> "${GATE_LOG}"
if [[ "${RC}" -eq 0 ]]; then
  show_output "${ATTEMPT}"
  WARNED="$(sort -u "${WARNED_MODULES}" | grep -c . || true)"
  gate_log_complete
  echo "==> build: OK — all ${#ALL_MODULES[@]} modules already up to date, nothing built, ${WARNED} module(s) with warnings, ${CHECK_SECS}s"
  echo "    full output: ${GATE_LOG#"${REPO}"/}"
  exit 0
fi
echo "==> up-to-date check: exit ${RC} after ${CHECK_SECS}s (3 means something needs building) — walking the batches"

START="$(date +%s)"
echo "==> ${#LAYERS[@]} batches of at most ${BATCH} modules, capped at ${MEMMAX}"
FAIL=0
RETRIED=0
REBUILT=0
for i in "${!LAYERS[@]}"; do
  read -ra BATCH_TARGETS <<< "${LAYERS[$i]}"
  printf '==> [%d/%d] %d modules  %s\n' "$((i + 1))" "${#LAYERS[@]}" "${#BATCH_TARGETS[@]}" "$(date +%T)"
  run_attempt 1
  RC=$?

  # One retry, and only one, and never a quiet one. Lean crashed (exit 139) once in a
  # three-hour run on this machine, at 1.1 s into a batch, and rebuilt cleanly on its own — a
  # transient, not a wrong proof. A real failure reproduces; that is what makes the retry safe.
  # It is announced, with what the failed attempt printed, because a build that silently retries is a
  # build that hides how flaky it is.
  if [[ "${RC}" -ne 0 ]]; then
    echo "    !! batch failed with status ${RC}. What it printed, before the retry:"
    show_output "${ATTEMPT}"
    echo "    !! retrying ONCE. If this line is common, the machine is unwell and the build is not the"
    echo "       thing to fix."
    RETRIED=$((RETRIED + 1))
    run_attempt 2
    RC=$?
  fi

  show_output "${ATTEMPT}"
  BUILT="$(built_modules "${ATTEMPT}")"
  if [[ -n "${BUILT}" ]]; then
    REBUILT=$((REBUILT + $(grep -c . <<< "${BUILT}")))
    echo "    rebuilt: $(awk -F'\t' '{ sub(/^Proofs\.HadwigerNelson\./, "", $1); printf "%s%s%s", (NR > 1 ? ", " : ""), $1, ($2 != "" ? " (" $2 ")" : "") }' <<< "${BUILT}")"
  fi
  if [[ "${RC}" -ne 0 ]]; then
    echo "    BATCH FAILED. Once it is fixed, rerun ./scripts/build.sh — modules that already built are"
    echo "    skipped. Never a bare or named lake build (CLAUDE.md § Building)."
    FAIL=1
    break
  fi
done

ELAPSED=$(( $(date +%s) - START ))
WARNED="$(sort -u "${WARNED_MODULES}" | grep -c . || true)"
SUMMARY="$((i + 1)) of ${#LAYERS[@]} batches, ${REBUILT} module(s) rebuilt, ${WARNED} module(s) with warnings, $((ELAPSED / 60))m$((ELAPSED % 60))s"
gate_log_complete
if [[ "${FAIL}" -ne 0 ]]; then
  echo "==> build: FAIL — ${SUMMARY}"
  echo "    full output: ${GATE_LOG#"${REPO}"/}"
  exit 1
fi
if [[ "${RETRIED}" -ne 0 ]]; then
  echo "==> build: OK — ${SUMMARY} — but ${RETRIED} batch(es) needed a retry; see the !! lines above"
else
  echo "==> build: OK — ${SUMMARY}"
fi
echo "    full output: ${GATE_LOG#"${REPO}"/}"
