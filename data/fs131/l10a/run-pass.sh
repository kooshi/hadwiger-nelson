#!/usr/bin/env bash
# FS131-L10A: one whole pass on one commit — the build (which must read "already up to date" on the gated commit), the kernel's own
# list of the library's declarations, the gate's steps (data/fs131/l10a/run-gate.sh), then the two reconciliations against main's
# gated receipts (the records check and the scan's row check). usage: data/fs131/l10a/run-pass.sh <tag>
# The last line of data/fs131/l10a/run-pass-<tag>.out is `pass-exit=done`; every step's own exit status is on its own line above.
cd "$(dirname "$0")/../../.."
tag="$1"; d=data/fs131/l10a
[ -n "$tag" ] || { echo "usage: run-pass.sh <tag>"; exit 2; }
{
  ./data/fs131/l10a/run-build.sh "$tag" > /dev/null 2>&1; echo "build exit=$?"
  tail -4 "$d/build-$tag.log" | head -2
  /home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 4 --wait 3600 -- lake env lean data/fs131/l5/count-modules.lean \
    > "$d/count-modules-$tag.out" 2> "$d/count-modules-$tag.err"; echo "count-modules exit=$?"
  ./data/fs131/l10a/run-gate.sh "$tag"; echo "run-gate exit=$?"
  python3 tools/fs131_l5_records.py data/fs131/mc/count-modules-final2.out "$d/count-modules-$tag.out" "$d/receipt-axioms-$tag.log" \
    --heads "$(tr '\n' ',' < data/fs131/l10a/heads.txt | sed 's/,$//')" > "$d/records-$tag.txt" 2>&1; echo "records exit=$?"
  python3 tools/fs131_l5_vacdiff.py data/fs131/mc/receipt-vacuity-final2.log "$d/receipt-vacuity-$tag.log" \
    data/fs131/mc/count-modules-final2.out "$d/count-modules-$tag.out" --carriers-in HadwigerNelson.StationaryRatio.StationarySet \
    > "$d/vacdiff-$tag.txt" 2>&1; echo "vacdiff exit=$?"
  python3 scripts/gate_report.py axioms "$d/receipt-axioms-$tag.log" data/fs131/mc/receipt-axioms-final2.log CLAUDE.md \
    > "$d/digest-axioms-$tag.txt" 2>&1; echo "digest-axioms exit=$?"
  python3 scripts/gate_report.py vacuity "$d/receipt-vacuity-$tag.log" data/fs131/mc/receipt-vacuity-final2.log \
    scripts/vacuity-baseline.txt CLAUDE.md > "$d/digest-vacuity-$tag.txt" 2>&1; echo "digest-vacuity exit=$?"
  echo "pass-exit=done"
} > "$d/run-pass-$tag.out" 2>&1
