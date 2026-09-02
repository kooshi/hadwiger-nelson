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
# Usage:
#   scripts/build.sh              # the whole library
#   BATCH=4 scripts/build.sh      # smaller groups, if something else is using the machine
#   scripts/build.sh --plan       # print the batches and exit; builds nothing
set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${REPO}"
source "${REPO}/scripts/dev-env.sh"

# Measured on the desktop, 2026-07-30: a certificate segment peaks at 8.9 GB. Ten of those is ~89 GB,
# and M06 ran twelve concurrently on this machine without trouble — but leave room for the page cache,
# because the pages being evicted are the `.olean` files the build is reading. Raise it only with a
# measurement in hand; `CLAUDE.md` has the one-liner.
BATCH="${BATCH:-10}"
LOG="$(mktemp)"
trap 'rm -f "${LOG}"' EXIT
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

echo "==> ${#LAYERS[@]} batches of at most ${BATCH} modules, capped at ${MEMMAX}"
FAIL=0
RETRIED=0
for i in "${!LAYERS[@]}"; do
  read -ra BATCH_TARGETS <<< "${LAYERS[$i]}"
  printf '==> [%d/%d] %d modules  %s\n' "$((i + 1))" "${#LAYERS[@]}" "${#BATCH_TARGETS[@]}" "$(date +%T)"
  # No pipeline around `lake`: its exit status is the thing this gate is built on, and a pipe
  # reports the *last* command's status instead. M04 lost a whole audit to exactly that.
  systemd-run --user --scope -q -p "MemoryMax=${MEMMAX}" -p MemorySwapMax=0 -- \
    lake build "${BATCH_TARGETS[@]}" > "${LOG}" 2>&1
  RC=$?

  # One retry, and only one, and never a quiet one. Lean crashed (exit 139) once in a
  # three-hour run on this machine, at 1.1 s into a batch, and rebuilt cleanly on its own — a
  # transient, not a wrong proof. A real failure reproduces; that is what makes the retry safe.
  # It is announced because a build that silently retries is a build that hides how flaky it is.
  if [[ "${RC}" -ne 0 ]]; then
    echo "    !! batch failed with status ${RC} — retrying ONCE. If this line is common, the"
    echo "       machine is unwell and the build is not the thing to fix."
    RETRIED=$((RETRIED + 1))
    systemd-run --user --scope -q -p "MemoryMax=${MEMMAX}" -p MemorySwapMax=0 -- \
      lake build "${BATCH_TARGETS[@]}" > "${LOG}" 2>&1
    RC=$?
  fi

  grep -Ev '^trace:|^info: ' "${LOG}" | grep -E 'error|warning|sorry|✖' | head -20
  if [[ "${RC}" -ne 0 ]]; then
    echo "    BATCH FAILED — rerun just this one:  lake build ${BATCH_TARGETS[*]}"
    FAIL=1
    break
  fi
done

if [[ "${FAIL}" -ne 0 ]]; then
  echo "==> build: FAIL"
  exit 1
fi
if [[ "${RETRIED}" -ne 0 ]]; then
  echo "==> build: OK — but ${RETRIED} batch(es) needed a retry; see the !! lines above"
else
  echo "==> build: OK"
fi
