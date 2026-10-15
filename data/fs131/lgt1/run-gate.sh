#!/usr/bin/env bash
# FS131-LGT1 (after FS131-LDB1's data/fs131/ldb1/run-gate.sh): one whole pass of the gate on one commit, on the laptop,
# under the slot with this machine's budget, one step at a time, each to its own log under data/fs131/lgt1/gate/ with its
# exit status on the log's last line and in data/fs131/lgt1/gate/run-pass-<tag>.out; every step's wall time and memory
# (data/fs131/lj1/in-scope.sh, run unchanged by path) in data/fs131/lgt1/gate/measure-<tag>.txt.  The commit under test
# and every tracked file modified are written first.
#
# Order (LEAN.md § The gate; the brief's item 3): the build (BATCH=8 at 10 GiB: the stale set is the lint control's
# module and the root, neither the density bound's cells nor the p = 19 checks); `lake build --no-build`; the kernel's
# count of declarations; the sorry scans and the line-initial `axiom` lines; the doubled-name check and its self-test
# BEFORE the axiom audit; the audit and its self-test; the kernel's print of every record of the 148 landed modules,
# against the print the block was generated from; the coverage (data/fs131/lgt1/lean/Coverage.lean) and the records check
# (tools/fs131_lgt1_records.py) with its plants; the generators on main's generated modules as FS131-LDB1 ran them, and
# the dyadic certificates' check with its planted fault; the vacuity scan, its self-test, and the scan against
# FS131-LDB1's row for row (tools/fs131_l5_vacdiff.py) with its plants; the assumptions step and its self-test; the
# architecture check; the guarded lint; the notes check and its self-test; the stored statements (FS131-LCH1's dump and
# term surgery on this build, its comparison against the lander's dumps made before any edit, with its five plants —
# the raw dumps' sha256 checked against the committed sums and their indexes re-split and compared with the committed
# ones); the baseline's entries and the scans' sources against main's; the three digests against FS131-LDB1's receipts.
# Usage (launched from a snapshot copy): LGT1_ROOT=<worktree> run-gate.sh <tag> <main's hash as merged> [BATCH, default 8]
cd "${LGT1_ROOT:-$(dirname "$0")/../../..}" || exit 2
[ -f scripts/build.sh ] && [ -d data/fs131/lgt1 ] || { echo "not the worktree's root: $PWD"; exit 2; }
tag="$1"; MAIN="$2"; batch="${3:-8}"; L=data/fs131/lgt1; d=$L/gate; C=data/fs131/lch1
[ -n "$tag" ] && [ -n "$MAIN" ] || { echo "usage: run-gate.sh <tag> <main's hash> [BATCH]"; exit 2; }
git cat-file -e "$MAIN^{commit}" || { echo "no such commit: $MAIN"; exit 2; }
mkdir -p "$d"
export SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6
S=/home/kooshi/source/lean-dir/scripts/slot.py
IS=data/fs131/lj1/in-scope.sh
M=/home/kooshi/source/lean-dir/data/fs131/ldb1/gate   # the previous landing's gated receipts: FS131-LDB1's final pass
MODS31=$(tr -d "\n " < data/fs131/ipd1/order31.txt)
out="$d/run-pass-$tag.out"; meas="$d/measure-$tag.txt"; : > "$meas"
{ echo "HEAD=$(git rev-parse HEAD)  $(date -u +%Y-%m-%dT%H:%M:%SZ)  host=$(hostname) cores=$(nproc) mem=$(awk '/MemTotal/ {printf "%.0f GiB", $2/1048576}' /proc/meminfo)"
  echo "status (tracked files modified, and untracked outside data/ and plans/):"
  git status --short | grep -v '^?? data/\|^?? plans/'; echo "--"
  echo "main ($MAIN) against this commit, paths that differ under Proofs/ Proofs.lean scripts/ tools/ ARCHITECTURE.md:"
  git diff --name-only "$MAIN" HEAD -- Proofs Proofs.lean scripts tools ARCHITECTURE.md lakefile.toml lean-toolchain lake-manifest.json | grep -c . | sed 's/^/paths: /'
  echo "of them outside Proofs/: $(git diff --name-only "$MAIN" HEAD -- scripts tools ARCHITECTURE.md lakefile.toml lean-toolchain lake-manifest.json | tr '\n' ' ')"; echo "--"; } > "$d/run-gate-$tag.head"
run() { local name="$1" mem="$2" cpus="$3"; shift 3; local tmp="$d/.m-$name-$tag"
  "$S" --mem "$mem" --cpus "$cpus" --wait 7200 --name "lgt1-$name" -- "$PWD/$IS" "$PWD/$tmp" "$@" > "$d/$name-$tag.log" 2>&1; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.log"
  if [ -f "$tmp" ]; then sed "s/^MEASURE /MEASURE $name mem-cap=${mem}G cpus=$cpus /" "$tmp" >> "$meas"; rm -f "$tmp"
  else echo "MEASURE $name mem-cap=${mem}G cpus=$cpus exit=$st NOT-MEASURED (refused, or killed before its end)" >> "$meas"; fi
  echo "$name exit=$st"; }
lean1() { local name="$1" mem="$2" file="$3"; shift 3; local tmp="$d/.m-$name-$tag"
  "$S" --mem "$mem" --cpus 2 --wait 7200 --name "lgt1-$name" -- "$PWD/$IS" "$PWD/$tmp" lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$@" "$file" > "$d/$name-$tag.out" 2> "$d/$name-$tag.err"; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.err"
  if [ -f "$tmp" ]; then sed "s/^MEASURE /MEASURE $name mem-cap=${mem}G cpus=2 /" "$tmp" >> "$meas"; rm -f "$tmp"; fi
  echo "$name exit=$st"; }
plain() { local name="$1"; shift; local t0=$(date +%s.%N); "$@" > "$d/$name-$tag.txt" 2>&1; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.txt"
  awk -v a="$t0" -v b="$(date +%s.%N)" -v n="$name" -v st="$st" 'BEGIN { printf "MEASURE %s (no slot: a script) exit=%d wall=%.1fs\n", n, st, b - a }' >> "$meas"
  echo "$name exit=$st"; }
{
  t0=$(date +%s)
  "$S" --mem 10 --cpus 4 --wait 7200 --name lgt1-build -- /usr/bin/time -f "MAXRSS-KB %M" env MEMMAX=10G BATCH="$batch" ./scripts/build.sh > "$d/build-$tag.log" 2>&1; st=$?
  t1=$(date +%s); echo "exit=$st" >> "$d/build-$tag.log"; echo "build exit=$st"
  echo "MEASURE build mem-cap=10G cpus=4 BATCH=$batch exit=$st wall=$((t1 - t0))s (slot wait included; build.sh's batches are sibling scopes, each capped at MEMMAX)" >> "$meas"
  grep -c 'warning' "$d/build-$tag.log" | sed 's/^/build log lines holding "warning": /'
  f="$(readlink -f build/gate/build/latest 2>/dev/null)"; [ -f "$f" ] && { cp "$f" "$d/receipt-build-$tag.log"; grep -c 'warning' "$f" | sed 's/^/lake full log lines holding "warning": /'; }
  run uptodate 4 2 lake build --no-build Proofs
  lean1 count-modules 8 data/fs131/l5/count-modules.lean
  grep -rnP '^\s*sorry\s*$|:= sorry|by sorry' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-narrow-$tag.txt"; echo "sorry (narrow) lines=$(wc -l < "$d/sorry-narrow-$tag.txt")"
  grep -rnP '\bsorry\b' --include='*.lean' Proofs/ Proofs.lean > "$d/sorry-wide-$tag.txt"; echo "sorry (wide) lines=$(wc -l < "$d/sorry-wide-$tag.txt")"
  grep -rnP '^\s*(private |protected |noncomputable )*axiom\s' --include='*.lean' Proofs/ Proofs.lean > "$d/axiom-lines-$tag.txt"; echo "line-initial axiom declarations in Proofs/=$(wc -l < "$d/axiom-lines-$tag.txt")"
  { while read -r m; do f="${m//.//}.lean"; grep -l 'native_decide' "$f" 2>/dev/null; done < $L/modules.txt; } > "$d/native-landed-$tag.txt"; echo "landed modules naming native_decide=$(wc -l < "$d/native-landed-$tag.txt")"
  run dupnames 8 4 ./scripts/dupnames.sh
  run dupnames-selftest 4 4 ./scripts/dupnames.sh --self-test
  run axioms 8 4 ./scripts/axioms.sh
  run axioms-selftest 8 4 ./scripts/axioms.sh --self-test
  for g in dupnames dupnames-self-test axioms axioms-self-test; do
    f="$(readlink -f build/gate/$g/latest 2>/dev/null)"; echo "$g latest: $f" >> "$d/run-gate-$tag.head"
    [ -f "$f" ] && cp "$f" "$d/receipt-$g-$tag.log"
  done
  lean1 axioms-all 8 $L/lean/AxiomsAll.lean
  { if cmp -s "$d/axioms-all-$tag.out" $L/axioms-all.txt; then echo "axioms-all: IDENTICAL to the print the block was generated from ($(grep -c '^AXIOMS ' $L/axioms-all.txt) records)"; else echo "axioms-all: DIFFERS"; diff $L/axioms-all.txt "$d/axioms-all-$tag.out" | head -20; fi; } > "$d/axioms-all-cmp-$tag.txt"; echo "$(head -1 "$d/axioms-all-cmp-$tag.txt")"
  lean1 coverage 8 $L/lean/Coverage.lean
  plain records python3 tools/fs131_lgt1_records.py "$d/receipt-axioms-$tag.log" --coverage "$d/coverage-$tag.out"
  plain records-plant python3 tools/fs131_lgt1_records.py "$d/receipt-axioms-$tag.log" --coverage "$d/coverage-$tag.out" --plant
  plain gen-check python3 tools/fs131_ko1_port.py --check --modules $MODS31
  plain gen-cells-chain python3 tools/fs131_idb1_cells.py chain
  plain gen-cells-modules python3 tools/fs131_idb1_cells.py modules
  plain gen-x23 python3 tools/fs131_kdb1_x23.py --write
  plain gen-dyadic python3 tools/fs131_icm4_certs.py --check
  plain gen-dyadic-fault python3 tools/fs131_icm4_certs.py --check --fault
  { echo "tracked files the generators rewrote with other bytes (git status --porcelain, untracked hidden):"
    git status --porcelain --untracked-files=no -- Proofs/HadwigerNelson/Plane/DensityBound data/fs131/idb1/gen data/fs131/idb3/gen Proofs/HadwigerNelson/Arith/DyadicCerts.lean
    echo "count=$(git status --porcelain --untracked-files=no -- Proofs/HadwigerNelson/Plane/DensityBound data/fs131/idb1/gen data/fs131/idb3/gen Proofs/HadwigerNelson/Arith/DyadicCerts.lean | wc -l)"; } > "$d/gen-identical-$tag.txt" 2>&1
  echo "generators: $(tail -1 "$d/gen-identical-$tag.txt")"
  run vacuity 8 4 ./scripts/vacuity.sh
  run vacuity-selftest 8 4 ./scripts/vacuity.sh --self-test
  for g in vacuity vacuity-self-test; do
    f="$(readlink -f build/gate/$g/latest 2>/dev/null)"; echo "$g latest: $f" >> "$d/run-gate-$tag.head"
    [ -f "$f" ] && cp "$f" "$d/receipt-$g-$tag.log"
  done
  plain vacdiff python3 tools/fs131_l5_vacdiff.py "$M/receipt-vacuity-final.log" "$d/receipt-vacuity-$tag.log" "$M/count-modules-final.out" "$d/count-modules-$tag.out" --rows
  plain vacdiff-plant python3 tools/fs131_l5_vacdiff.py "$M/receipt-vacuity-final.log" "$d/receipt-vacuity-$tag.log" "$M/count-modules-final.out" "$d/count-modules-$tag.out" --plant
  run assumptions 8 4 ./scripts/assumptions.sh
  run assumptions-selftest 8 4 ./scripts/assumptions.sh --self-test
  for g in assumptions assumptions-self-test; do
    f="$(readlink -f build/gate/$g/latest 2>/dev/null)"; echo "$g latest: $f" >> "$d/run-gate-$tag.head"
    [ -f "$f" ] && cp "$f" "$d/receipt-$g-$tag.log"
  done
  plain arch python3 tools/check_architecture.py
  run lint 8 4 lake lint --no-build -- --no-build --trace
  plain notes-l5 python3 tools/fs131_l5_notes.py --only-flagged
  plain notes-qa4-selftest python3 tools/fs131_qa4_notes.py --self-test
  # the stored statements: FS131-LCH1's dump and term surgery on this build, against the lander's dumps
  plain raw-dumps-sha256 bash -c "cd $C && sha256sum -c statements-before.sha256 && sha256sum -c statements-after-5.sha256"
  plain resplit-before bash -c "python3 $C/split_dump.py $C/statements-before-chain.txt $d/resplit-chain && python3 $C/split_dump.py $C/statements-before-main.txt $d/resplit-main && xz -dc $C/statements-before-chain.index.tsv.xz | cmp - $d/resplit-chain.index.tsv && xz -dc $C/statements-before-main.index.tsv.xz | cmp - $d/resplit-main.index.tsv && echo 'RESPLIT: both indexes byte-identical to the committed ones'"
  rm -f "$d"/resplit-*.full.txt
  "$S" --mem 8 --cpus 2 --wait 7200 --name lgt1-statements -- env LCH1_OUT="$PWD/$d/statements-$tag.txt" LCH1_FULL=Proofs.HadwigerNelson.Rigidity.,Proofs.HadwigerNelson.Plane.WindowDensity,Proofs.HadwigerNelson.Plane.OneAvoidingDensity,Proofs.HadwigerNelson.Instances.SqrtFortySeven,Proofs.HadwigerNelson.Instances.SqrtClassValues,Proofs.HadwigerNelson.Outside.OAI015,Proofs.HadwigerNelson.Arith.UpperHalf,Proofs.HadwigerNelson.SpectralChain,Proofs.HadwigerNelson.Plane.OneClass.,Proofs.HadwigerNelson.Arith.ThreeFourColours,Proofs.HadwigerNelson.Plane.DensityBound.Theorem,Proofs.HadwigerNelson.Plane.MOneBound,Proofs.HadwigerNelson.Arith.CircleCos lake env lean $C/lean/StatementDump.lean > "$d/statements-dump-$tag.log" 2>&1; st=$?; echo "exit=$st" >> "$d/statements-dump-$tag.log"; echo "statements-dump exit=$st"
  lean1 readd 6 $C/lean/ReAdd.lean
  plain split-after python3 $C/split_dump.py "$d/statements-$tag.txt" "$d/statements-$tag"
  xz -dc data/fs131/icm4/statements-after2.txt.xz > "$d/m13-icm4-after2.txt"
  plain statements-compare python3 tools/fs131_lch1_statements.py $d/resplit-chain.index.tsv $d/resplit-main.index.tsv "$d/m13-icm4-after2.txt" "$d/statements-$tag.index.tsv" "$d/readd-$tag.out"
  plain statements-plant python3 tools/fs131_lch1_statements.py $d/resplit-chain.index.tsv $d/resplit-main.index.tsv "$d/m13-icm4-after2.txt" "$d/statements-$tag.index.tsv" "$d/readd-$tag.out" --plant
  { if cmp -s "$d/statements-$tag.txt" $C/statements-after-5.txt; then echo "dump: byte-identical to the lander's build-5 dump (statements-after-5.txt)"; else echo "dump: differs from the lander's build-5 dump"; fi; } > "$d/statements-vs-5-$tag.txt"; cat "$d/statements-vs-5-$tag.txt"
  [ -f "$d/statements-$tag.txt" ] && { sha256sum "$d/statements-$tag.txt" > "$d/statements-$tag.sha256"; xz -T2 -f "$d/statements-$tag.index.tsv"; xz -T2 -f "$d/statements-$tag.full.txt"; rm -f "$d/statements-$tag.txt" "$d/m13-icm4-after2.txt" "$d"/resplit-*.index.tsv; }
  { diff <(git show $MAIN:scripts/vacuity-baseline.txt | grep -E '^UNKNOWN ') <(grep -E '^UNKNOWN ' scripts/vacuity-baseline.txt) && echo "baseline entries: unchanged from main's ($(grep -cE '^UNKNOWN ' scripts/vacuity-baseline.txt))"
    for f in scripts/Vacuity.lean scripts/Assumptions.lean scripts/Axioms.lean scripts/axioms-controls.txt scripts/assumptions-controls.txt scripts/assumptions-ledger.txt scripts/vacuity-baseline.txt scripts/vacuity-controls.lean scripts/DupNames.lean scripts/dupnames-controls.txt scripts/gate_report.py scripts/axioms.sh scripts/vacuity.sh scripts/assumptions.sh scripts/dupnames.sh scripts/build.sh; do
      echo "lines of $f that differ from main's: $(diff <(git show $MAIN:$f) $f | grep -c '^[<>]')"; done; } > "$d/baseline-$tag.txt" 2>&1; echo "baseline-check exit=$?"
  plain digest-axioms python3 scripts/gate_report.py axioms "$d/receipt-axioms-$tag.log" "$M/receipt-axioms-final.log" CLAUDE.md
  plain digest-vacuity python3 scripts/gate_report.py vacuity "$d/receipt-vacuity-$tag.log" "$M/receipt-vacuity-final.log" scripts/vacuity-baseline.txt CLAUDE.md
  plain digest-assumptions python3 scripts/gate_report.py assumptions "$d/receipt-assumptions-$tag.log" "$M/receipt-assumptions-final.log" scripts/assumptions-ledger.txt CLAUDE.md
  echo "tracked files modified after the pass: $(git status --porcelain --untracked-files=no | wc -l)"
  echo "pass-exit=done"
} > "$out" 2>&1
