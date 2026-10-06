#!/usr/bin/env bash
# FS131-MC1: the final pass on one commit — the build (must read "already up to date"), then data/fs131/mc/run-pass.sh final.
cd "$(dirname "$0")/../../.."
./data/fs131/mc/run-build.sh final > /dev/null 2>&1; echo "build exit=$?" > data/fs131/mc/run-final.out
./data/fs131/mc/run-pass.sh final; echo "final-exit=done" >> data/fs131/mc/run-final.out
