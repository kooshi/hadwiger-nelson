#!/usr/bin/env bash
# FS131-LN1: the linters' negative control, end to end, with the restore on every exit path.
#
#   plant -> build -> lint (tag `plant`) -> restore -> build -> lint (tag `restored`)
#
# Run from the worktree's root, from a snapshot copy (a running script is never edited).
# Every step's exit status is read from the tool and written to data/fs131/ln/control.log; nothing is piped.
# A slot refusal (exit 75) is retried after ten minutes, three times at most (standing rule 9).
# The restore runs from an EXIT trap as well, so no exit of this script leaves the plant in the source file.
set -u
D=data/fs131/ln
LOG="${D}/control.log"
SLOT=/home/kooshi/source/lean-dir/scripts/slot.py
say() { echo "$(date -u +%FT%TZ) $*" >> "${LOG}"; }
restored=0
restore() {
  if [[ "${restored}" -eq 0 ]]; then
    "${D}/plant.sh" restore >> "${LOG}" 2>&1; rc=$?
    say "restore: exit ${rc}"
    restored=1
  fi
}
trap restore EXIT

build() {   # build <tag>: scripts/build.sh under the slot; its output and exit status kept
  local tag="$1" rc try
  for try in 1 2 3; do
    "${SLOT}" --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh > "${D}/build-${tag}.out" 2>&1; rc=$?
    echo "${rc}" > "${D}/build-${tag}.exit"
    say "build ${tag}: try ${try}, exit ${rc}"
    [[ "${rc}" -ne 75 ]] && break
    sleep 600
  done
  local gl; gl="$(readlink -f build/gate/build/latest 2>/dev/null)"
  [[ -f "${gl}" ]] && cp "${gl}" "${D}/build-${tag}.gate.log"
  return "${rc}"
}

lint() {    # lint <tag>: one guarded run; a slot refusal is retried under a new tag suffix
  local tag="$1" rc try t
  for try in 1 2 3; do
    t="${tag}"; [[ "${try}" -gt 1 ]] && t="${tag}-try${try}"
    "${D}/run-lint.sh" "${t}" >> "${LOG}" 2>&1
    rc="$(cat "${D}/lint-${t}.exit" 2>/dev/null || echo missing)"
    say "lint ${t}: exit ${rc}"
    [[ "${rc}" != "75" ]] && break
    sleep 600
  done
  echo "${t}" > "${D}/lint-${tag}.final-tag"
}

say "control: start, pid $$"
"${D}/plant.sh" plant >> "${LOG}" 2>&1; rc=$?
say "plant: exit ${rc}"
if [[ "${rc}" -ne 0 ]]; then say "control: STOP, the plant was refused"; exit 1; fi

if build plant; then
  lint plant
else
  say "control: the planted build did not exit 0; no planted lint run"
fi

restore
build restored; rc=$?
if [[ "${rc}" -eq 0 ]]; then lint restored; else say "control: the restored build did not exit 0"; fi
git status --short -- Proofs/ Proofs.lean scripts/ lakefile.toml > "${D}/control.git-status" 2>&1
say "control: git status over Proofs/, Proofs.lean, scripts/, lakefile.toml has $(wc -l < "${D}/control.git-status") line(s)"
say "control: end"
