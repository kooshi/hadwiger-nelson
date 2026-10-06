#!/usr/bin/env bash
# FS131-LN1: one guarded run of the environment linters. Everything it prints is kept.
#
#   data/fs131/ln/run-lint.sh <tag>        from the worktree's root; writes data/fs131/ln/lint-<tag>.*
#
# The command is the brief's `lake lint` with three additions that change nothing that is linted:
#   lake's  --no-build  (before `--`): Lake exits instead of rebuilding the driver or a Batteries module;
#   driver's --no-build (after `--`):  runLinter exits 1 instead of spawning `lake build +Proofs`;
#   driver's --trace:                  one line per linter, "(2/2) Passed!" or "(2/2) Failed with n messages".
#
# Files written, all under data/fs131/ln/:
#   lint-<tag>.out             the tool's stdout, whole
#   lint-<tag>.err             its stderr, whole (the slot's admission lines are here)
#   lint-<tag>.exit            the exit status, read from the tool and never through a pipe
#   lint-<tag>.time            GNU time -v: wall clock and peak resident set
#   lint-<tag>.driver-before   sha256 of the driver's binary before the run
#   lint-<tag>.driver-after    and after: a changed binary is a rebuild that happened
#   lint-<tag>.newer-packages  every file under the shared .lake/packages modified during the run
#   lint-<tag>.newer-build     every file under this tree's .lake/build modified during the run
# The last two always exist after a run; empty means nothing was written, which is the pass.
set -u
tag="${1:?usage: run-lint.sh <tag>}"
out="data/fs131/ln/lint-${tag}"
if [[ -e "${out}.out" ]]; then echo "refusing to overwrite ${out}.out"; exit 2; fi
DRIVER=.lake/packages/batteries/.lake/build/bin/runLinter
[[ -x "${DRIVER}" ]] || { echo "the driver's binary is missing: ${DRIVER}"; exit 2; }
sha256sum "${DRIVER}" > "${out}.driver-before"
touch "${out}.marker"
sleep 1
date -u +%FT%TZ > "${out}.start"
/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- \
  /usr/bin/time -v -o "${out}.time" lake lint --no-build -- --no-build --trace \
  > "${out}.out" 2> "${out}.err"
status=$?
echo "${status}" > "${out}.exit"
date -u +%FT%TZ > "${out}.end"
sha256sum "${DRIVER}" > "${out}.driver-after"
find -L .lake/packages -type f -newer "${out}.marker" > "${out}.newer-packages" 2> "${out}.newer-packages.err"
find .lake/build -type f -newer "${out}.marker" > "${out}.newer-build" 2> "${out}.newer-build.err"
rm -f "${out}.marker"
echo "exit=${status}"
