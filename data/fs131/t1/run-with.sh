#!/usr/bin/env bash
# usage: run-with.sh <plant.lean> <out>   splice a plant file into a copy of scripts/Vacuity.lean and scan
set -u
REPO=/home/kooshi/source/lean-dir; cd $REPO; source scripts/dev-env.sh
T=$(mktemp -d)
awk 'BEGIN{ins=0} /^namespace VacuityAudit$/ && !ins {while((getline l < "'"$1"'")>0) print l; ins=1} {print}' scripts/Vacuity.lean > $T/Vacuity.lean
lake env lean $T/Vacuity.lean > "$2" 2>&1; echo "lean exit $?"
rm -rf $T
