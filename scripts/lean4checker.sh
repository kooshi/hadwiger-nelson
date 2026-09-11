#!/usr/bin/env bash
# The de Bruijn criterion, made executable: replay every declaration in `Proofs` through an
# *independent* kernel. `lake build` proves the elaborator accepted our terms; this proves a
# separately-written type checker accepts them too, so a bug in Lean's own elaborator-side caching
# or environment handling cannot hide inside our .oleans.
#
# It matters most for the certificate modules, whose truth rests on kernel *reduction*
# (`by decide` over the Q4 tower) rather than on a written proof term.
#
# lean4checker is not a package dependency — it pins its own toolchain and would drag the project's
# pin around. It is cloned and built on demand here, into the directory given by $CHECKER_DIR
# (default: a sibling of the repo), with our `lean-toolchain` forced on it.
#
# A full replay runs for many hours, so nothing it prints is thrown away: each slice's module list,
# output, exit status and time are kept under `build/gate/lean4checker/<run>/` (`scripts/gate-log.sh`),
# every slice is summarized on the terminal, and on a failure every rejecting slice's output is printed
# whole. The first version deleted all of it at exit and printed six lines of the first failure.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CHECKER_DIR="${CHECKER_DIR:-${REPO}/.lake/lean4checker}"
TARGET="${1:-Proofs}"

source "${REPO}/scripts/dev-env.sh"
source "${REPO}/scripts/gate-log.sh"

if [[ ! -x "${CHECKER_DIR}/.lake/build/bin/lean4checker" ]]; then
  echo "==> building lean4checker in ${CHECKER_DIR}"
  rm -rf "${CHECKER_DIR}"
  git clone -q --depth 1 https://github.com/leanprover/lean4checker.git "${CHECKER_DIR}"
  cp "${REPO}/lean-toolchain" "${CHECKER_DIR}/lean-toolchain"
  (cd "${CHECKER_DIR}" && lake build)
fi

# lean4checker is a bare executable: it needs LEAN_PATH pointing at every built library.
LEAN_PATH="${REPO}/.lake/build/lib/lean"
for pkg in "${REPO}"/.lake/packages/*/; do
  [[ -d "${pkg}.lake/build/lib/lean" ]] && LEAN_PATH="${LEAN_PATH}:${pkg}.lake/build/lib/lean"
done
export LEAN_PATH

# lean4checker walks the *compiled* tree, not the module graph, so an .olean whose source has been
# deleted is still replayed. M06 hit this: renaming the geometry layout from 16 modules to 9 left seven
# stale oleans referring to constants that no longer exist, and the replay failed on a file that was
# not part of the library. Worse than the noise is the other direction — a stale olean that *passes*
# would make this script's OK a claim about a file nobody builds.
#
# So: fail loudly on an orphan, and name it. `lake build` does not clean these up.
echo "==> checking for compiled modules whose source is gone"
ORPHANS=0
while IFS= read -r olean; do
  src="${olean#.lake/build/lib/lean/}"
  src="${src%.olean}.lean"
  if [[ ! -f "${REPO}/${src}" ]]; then
    echo "    ORPHAN: ${olean} (no ${src})"
    ORPHANS=$((ORPHANS + 1))
  fi
done < <(cd "${REPO}" && find .lake/build/lib/lean/Proofs -name '*.olean' -print)
if [[ "${ORPHANS}" -ne 0 ]]; then
  echo "==> lean4checker: FAIL — ${ORPHANS} stale .olean(s); the replay would cover files the library"
  echo "    no longer contains. Remove them (and their .ilean/.trace siblings) and re-run."
  exit 1
fi
echo "    none"

# **lean4checker's own parallelism is broken on this workspace, and the failure looks like
# corruption.** With its default `--num-workers=8` it dies, reproducibly, at ten modules or a hundred:
#
#   uncaught exception: failed to read '.../Mathlib/Topology/Instances/EReal/Lemmas.olean.private':
#   'unreachable' code was reached
#
# That Mathlib file is fine — Lean imports it without complaint, and it predates this checkout — so
# the fault is a race in the checker's parallel module loader, not a bad olean. Worth stating loudly
# because on a machine with a history of bad memory, "failed to read" is exactly the message one
# would misread as a bit flip and go hunting for.
#
# `--num-workers=1` is correct and slow. Parallelism therefore comes from running several *processes*,
# each single-worker, over disjoint slices — bounded, because each one loads Mathlib.
JOBS="${JOBS:-8}"
CHECK="${CHECKER_DIR}/.lake/build/bin/lean4checker"

mapfile -t MODULES < <(
  cd "${REPO}" && find Proofs -name '*.lean' -printf '%P\n' 2>/dev/null |
    sed 's#\.lean$##; s#/#.#g; s#^#Proofs.#' | sort
)
[[ "${TARGET}" == "Proofs" ]] && MODULES+=("Proofs")
mapfile -t MODULES < <(printf '%s\n' "${MODULES[@]}" | grep -E "^${TARGET//./\\.}(\\.|\$)" | sort -u)

if [[ "${#MODULES[@]}" -eq 0 ]]; then
  echo "==> lean4checker: FAIL — no modules match ${TARGET}"; exit 1
fi

# **A known inefficiency, not a fix.** Every argument is treated as a *prefix*, so a module whose name
# is a prefix of others — `…Instances.Heule510`, with `…Heule510.Cnf.*` beneath it — expands to its
# whole subtree, and the slice holding it re-does every other slice's work sequentially. There is no
# flag for exact matching, so the redundancy cannot be removed, only overlapped: such modules are
# scheduled first, so they run alongside the leaf slices instead of trailing them.
#
# Measured: it is the difference between an 8-minute run and a 24-minute one for a 100-module witness.
# It has not been paid at full-library scale, where it would be much worse, because the full-library
# replay is dominated by M06's 28-hour certificate anyway. Revisit if that ever changes.
PREFIXES=()
LEAVES=()
for m in "${MODULES[@]}"; do
  if printf '%s\n' "${MODULES[@]}" | grep -qE "^${m//./\\.}\\."; then PREFIXES+=("${m}"); else LEAVES+=("${m}"); fi
done

echo "==> replaying ${#MODULES[@]} modules matching ${TARGET} through the independent kernel"
echo "    (${#PREFIXES[@]} of them expand to a subtree and are checked first, alone)"
echo "    ${JOBS} processes, one worker each"
gate_log_open lean4checker
WORK="${GATE_LOG%.log}"
mkdir -p "${WORK}"
echo "    each slice's module list, output and status: ${WORK#"${REPO}"/}/"
MODULES=("${PREFIXES[@]}" "${LEAVES[@]}")
N=${#MODULES[@]}
for ((j = 0; j < JOBS; j++)); do
  : > "${WORK}/slice${j}"
done
for ((k = 0; k < N; k++)); do
  echo "${MODULES[$k]}" >> "${WORK}/slice$((k % JOBS))"
done

START="$(date +%s)"
PIDS=()
for ((j = 0; j < JOBS; j++)); do
  [[ -s "${WORK}/slice${j}" ]] || continue
  # The status is written whatever the checker returns, so a slice with no status file is one whose
  # process died — reported below as exactly that, never read as a pass.
  ( mapfile -t SLICE < "${WORK}/slice${j}"
    t0="$(date +%s)"
    rc=0
    "${CHECK}" --num-workers=1 "${SLICE[@]}" > "${WORK}/out${j}" 2>&1 || rc=$?
    echo "${rc} $(( $(date +%s) - t0 ))" > "${WORK}/status${j}" ) &
  PIDS+=($!)
done
wait "${PIDS[@]}" 2>/dev/null || true
ELAPSED=$(( $(date +%s) - START ))

FAILED=()
for ((j = 0; j < JOBS; j++)); do
  [[ -s "${WORK}/slice${j}" ]] || continue
  n_mod="$(wc -l < "${WORK}/slice${j}")"
  if [[ ! -s "${WORK}/status${j}" ]]; then
    line="slice ${j}: ${n_mod} modules — NO STATUS: its process died before the checker returned"
    FAILED+=("${j}")
  else
    read -r rc secs < "${WORK}/status${j}"
    line="slice ${j}: ${n_mod} modules, exit ${rc}, $((secs / 60))m$((secs % 60))s"
    [[ "${rc}" -eq 0 ]] || FAILED+=("${j}")
  fi
  echo "    ${line}"
  echo "${line}" >> "${GATE_LOG}"
done
gate_log_complete

if [[ "${#FAILED[@]}" -ne 0 ]]; then
  echo "==> lean4checker: FAIL — ${#FAILED[@]} slice(s) rejected or died. Each one's output, whole:"
  for j in "${FAILED[@]}"; do
    echo "    --- slice ${j} (its modules: ${WORK#"${REPO}"/}/slice${j})"
    if [[ -f "${WORK}/out${j}" ]]; then
      grep -Ev "^Searching|^Found" "${WORK}/out${j}" | sed 's/^/    /' || true
    else
      echo "    (no output file)"
    fi
  done
  echo "    everything, the passing slices included: ${WORK#"${REPO}"/}/"
  exit 1
fi
echo "==> lean4checker: OK — ${#MODULES[@]} modules replayed by a separately written kernel, in $((ELAPSED / 60))m$((ELAPSED % 60))s"
echo "    kept: ${WORK#"${REPO}"/}/"
