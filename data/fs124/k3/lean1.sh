#!/usr/bin/env bash
# iterate on one file against the worktree's build (never evidence): lean1.sh <file.lean>
cd "$(dirname "$0")/../../.." || exit 2
exec lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true "$@"
