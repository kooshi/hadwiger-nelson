#!/usr/bin/env bash
# FS131-L10B (FS131-L6A's runner, with main's gated receipts now that landing's): one whole pass on one commit — the build (which must read "already up to date" on the gated commit), the kernel's own
# list of the library's declarations, the gate's steps (data/fs131/l10b/run-gate.sh), then the two reconciliations against main's
# gated receipts — FS131-L6A's, `data/fs131/l6a/*-first.*` (the records check and the scan's row check). usage: data/fs131/l10b/run-pass.sh <tag>
# The last line of data/fs131/l10b/run-pass-<tag>.out is `pass-exit=done`; every step's own exit status is on its own line above.
cd "$(dirname "$0")/../../.."
tag="$1"; d=data/fs131/l10b
[ -n "$tag" ] || { echo "usage: run-pass.sh <tag>"; exit 2; }
{
  ./data/fs131/l10b/run-build.sh "$tag" > /dev/null 2>&1; echo "build exit=$?"
  tail -4 "$d/build-$tag.log" | head -2
  /home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 4 --wait 3600 -- lake env lean data/fs131/l5/count-modules.lean \
    > "$d/count-modules-$tag.out" 2> "$d/count-modules-$tag.err"; echo "count-modules exit=$?"
  ./data/fs131/l10b/run-gate.sh "$tag"; echo "run-gate exit=$?"
  python3 tools/fs131_l10b_records.py data/fs131/l6a/count-modules-first.out "$d/count-modules-$tag.out" "$d/receipt-axioms-$tag.log" \
    --heads "$(tr '\n' ',' < data/fs131/l10b/heads.txt | sed 's/,$//')" \
    --import-heads "$(tr '\n' ',' < data/fs131/l10b/import-heads.txt | sed 's/,$//')" > "$d/records-$tag.txt" 2>&1; echo "records exit=$?"
  /home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 4 --wait 3600 -- lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false \
    data/fs131/l10b/kernel-sigs.lean > "$d/kernel-sigs-$tag.out" 2> "$d/kernel-sigs-$tag.err"; echo "kernel-sigs exit=$?"
  python3 tools/fs131_l10b_kernelsig.py read "$d/kernel-sigs-$tag.out" --reviewed "$d/kernel-sigs-reviewed.txt" --heads "$d/heads-all.txt" \
    --table "$d/kernel-sigs-$tag-table.txt" > "$d/kernel-sigs-$tag-read.txt" 2>&1; echo "kernel-sigs read exit=$?"
  python3 tools/fs131_l5_vacdiff.py data/fs131/l6a/receipt-vacuity-first.log "$d/receipt-vacuity-$tag.log" \
    data/fs131/l6a/count-modules-first.out "$d/count-modules-$tag.out"\
    > "$d/vacdiff-$tag.txt" 2>&1; echo "vacdiff exit=$?"
  python3 scripts/gate_report.py axioms "$d/receipt-axioms-$tag.log" data/fs131/l6a/receipt-axioms-first.log CLAUDE.md \
    > "$d/digest-axioms-$tag.txt" 2>&1; echo "digest-axioms exit=$?"
  python3 scripts/gate_report.py vacuity "$d/receipt-vacuity-$tag.log" data/fs131/l6a/receipt-vacuity-first.log \
    scripts/vacuity-baseline.txt CLAUDE.md > "$d/digest-vacuity-$tag.txt" 2>&1; echo "digest-vacuity exit=$?"
  echo "pass-exit=done"
} > "$d/run-pass-$tag.out" 2>&1
