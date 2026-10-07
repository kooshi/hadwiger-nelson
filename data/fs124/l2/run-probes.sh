#!/usr/bin/env bash
# FS124-L2: the probes of stages 3–5, one at a time under the slot, each to data/fs124/l2/probes/<name>.out with its
# exit status on the last line.  Not the gate: the gate is run-gate.sh, on one commit.
cd "$(dirname "$0")/../../.." || exit 2
p=data/fs124/l2/probes; S=/home/kooshi/source/lean-dir/scripts/slot.py; mkdir -p "$p"
run() { local name="$1" mem="$2" cpus="$3"; shift 3
  "$S" --mem "$mem" --cpus "$cpus" --wait 7200 -- "$@" > "$p/$name.out" 2>&1; local st=$?
  echo "exit=$st" >> "$p/$name.out"; echo "$name exit=$st"; }
run dupnames-probe 16 8 ./scripts/dupnames.sh
"$S" --mem 16 --cpus 4 --wait 7200 -- lake env lean data/fs124/l2/decls.lean > "$p/decls-probe.out" 2> "$p/decls-probe.err"; echo "decls exit=$?"
python3 tools/fs124_l2_records.py "$p/decls-probe.out" --unfiled scripts/Axioms.lean > "$p/unfiled-probe.txt" 2>&1; echo "unfiled exit=$?"
run axioms-probe 30 4 ./scripts/axioms.sh
cp "$(readlink -f build/gate/axioms/latest)" "$p/receipt-axioms-probe.log"
python3 tools/fs124_l2_records.py "$p/decls-probe.out" "$p/receipt-axioms-probe.log" > "$p/records-probe.txt" 2>&1; echo "records exit=$?"
python3 tools/fs124_l2_records.py "$p/decls-probe.out" "$p/receipt-axioms-probe.log" --plant > "$p/records-plant-probe.txt" 2>&1; echo "records-plant exit=$?"
run axioms-selftest-probe 30 4 ./scripts/axioms.sh --self-test
run assumptions-selftest-first 16 4 ./scripts/assumptions.sh --self-test
run assumptions-first 16 4 ./scripts/assumptions.sh
run vacuity-probe 30 4 ./scripts/vacuity.sh
echo "probes done"
