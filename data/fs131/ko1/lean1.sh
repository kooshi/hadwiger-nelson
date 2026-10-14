#!/bin/bash
# FS131-KO1: run one Lean file at THIS library's pin (v4.32.0) with a given search path, under a slot; no lake, nothing
# built.  $1 = the LEAN_PATH file (data/fs131/ko1/lean/leanpath-*.txt), the rest = lean's arguments.
LP=$(tr -d '\n' < "$1"); shift
exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem ${KO1_MEM:-7} --cpus 2 --wait 7200 --name ko1 -- env LEAN_PATH="$LP" /home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true "$@"
