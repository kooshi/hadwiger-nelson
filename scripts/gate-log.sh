# Sourced by the gate scripts; never run directly. Keeps what a gate run computed.
#
# A gate run is expensive — minutes for the audits, hours for an independent-kernel replay — and every
# gate here used to keep its tool's output only in a shell variable, a pipe, or a temp directory deleted
# at exit, then print a filtered slice of it. So a question the run had already answered needed a second
# run: the vacuity scan computes every declaration count and per-site verdict and printed three lines of
# them; the build printed twenty matching lines per batch and let a retry overwrite the attempt that
# failed; the replay deleted every slice's output. Now every run writes its complete, unfiltered output
# under `build/gate/<gate>/` (gitignored: local provenance, never a certificate) and prints the path, and
# the terminal gets a digest that leaves nothing out but bulk.
#
#   gate_log_open <gate>  sets GATE_DIR, GATE_LOG (this run's file, created empty) and GATE_PREV (the last
#                         COMPLETE run's file, or empty), and prints GATE_LOG's path.
#   gate_log_complete     marks this run complete, so the next run compares itself against it. Call it
#                         once the tool's output is whole, whatever the verdict — and never for a run that
#                         died part-way, whose truncated output would read as mass disappearance.
#
# Runs are kept, not rotated; `build/gate/` can be deleted at any time.

gate_log_open() {
  GATE_DIR="${REPO}/build/gate/$1"
  mkdir -p "${GATE_DIR}"
  GATE_PREV=""
  if [[ -L "${GATE_DIR}/latest" && -e "${GATE_DIR}/latest" ]]; then
    GATE_PREV="$(readlink -f "${GATE_DIR}/latest")"
  fi
  GATE_LOG="${GATE_DIR}/$(date -u +%Y%m%dT%H%M%SZ)-$$.log"
  : > "${GATE_LOG}"
  echo "==> $1: this run's full output: ${GATE_LOG#"${REPO}"/}"
}

gate_log_complete() {
  ln -sfn "$(basename "${GATE_LOG}")" "${GATE_DIR}/latest"
}
