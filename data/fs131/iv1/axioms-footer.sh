#!/usr/bin/env bash
# FS131-IV1: the axioms of EVERY theorem and definition a person typed in the module's three files — the private
# helpers included, which no file outside can name.  Each file is copied to stmt/Copy.lean with lean/AxiomsFooter.lean
# appended (`collectAxioms` on every theorem and definition the file declares) and elaborated against the built
# library; the rows go to axioms-footer.txt.  PASS iff the row counts are the expected ones (36, 21, 11: public +
# private) and every row's axioms are a subset of the standard three.
# usage: data/fs131/iv1/axioms-footer.sh            the three working files
#        data/fs131/iv1/axioms-footer.sh --control  the instances file as the skeleton had it (git 223241b0a): its three
#                                                   leaves and what is proved from them must print sorryAx; exit 0 iff they do
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/iv1
CONTROL=0; [ "${1:-}" = --control ] && CONTROL=1
mkdir -p $D/stmt
out=$D/axioms-footer.txt; [ $CONTROL = 1 ] && out=$D/axioms-footer.control.txt
: > $out
files="Proofs/HadwigerNelson/Arith/UpperHalf.lean Proofs/HadwigerNelson/Arith/QuadraticPrime.lean Proofs/HadwigerNelson/Instances/UpperHalfValues.lean"
[ $CONTROL = 1 ] && files="Proofs/HadwigerNelson/Instances/UpperHalfValues.lean"
for f in $files; do
  if [ $CONTROL = 1 ]; then git show 223241b0a:$f > $D/stmt/Copy.lean || exit 2; else cat $f > $D/stmt/Copy.lean; fi
  cat $D/lean/AxiomsFooter.lean >> $D/stmt/Copy.lean
  env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name iv1 -- \
    lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false $D/stmt/Copy.lean > $D/stmt/footer.full.txt 2> $D/stmt/footer.err
  st=$?
  echo "## FILE $f lean-exit=$st errors=$(grep -c ': error' $D/stmt/footer.full.txt)" >> $out
  grep -E '^AXIOMS' $D/stmt/footer.full.txt >> $out
done
rm -f $D/stmt/Copy.lean $D/stmt/footer.full.txt
python3 - "$out" "$CONTROL" <<'PY'
import re, sys, pathlib
STD = {"propext", "Classical.choice", "Quot.sound"}
text = pathlib.Path(sys.argv[1]).read_text(); control = sys.argv[2] == "1"
want = {"UpperHalf.lean": 36, "QuadraticPrime.lean": 21, "UpperHalfValues.lean": 11}
ok, cur, counts, dirty, bad_exit = True, None, {}, [], []
for ln in text.splitlines():
    if ln.startswith("## FILE "):
        cur = ln.split()[2].split("/")[-1]; counts[cur] = [0, 0, None]
        if "lean-exit=0 errors=0" not in ln: bad_exit.append(ln)
    elif ln.startswith("AXIOMS-COUNT"):
        counts[cur][2] = int(ln.split()[1])
    elif ln.startswith("AXIOMS "):
        m = re.match(r"AXIOMS (public|private) (\S+) : \[(.*)\]", ln)
        axs = {a.strip() for a in m.group(3).split(",") if a.strip()}
        counts[cur][0 if m.group(1) == "public" else 1] += 1
        if axs - STD: dirty.append((m.group(2), sorted(axs - STD)))
for f, (pub, priv, n) in counts.items():
    print(f"{f}: {pub} public + {priv} private = {pub + priv} rows (the footer's own count {n})")
for n, extra in dirty: print(f"  NOT CLEAN {n}: {extra}")
if control:
    names = {n.split(".")[-1] for n, e in dirty if e == ["sorryAx"]}
    need = {"numberField_bot", "instNumberFieldBot", "two_le_chromaticNumber_planeOver", "exists_stablePrime_rat", "chromaticNumber_planeOver_rat"}
    fired = names == need
    print(f"CONTROL: sorryAx on {sorted(names)} — {'exactly the three leaves and the two theorems proved from them: the footer can fail' if fired else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
    sys.exit(0 if fired else 1)
good = not dirty and not bad_exit and all(counts.get(f, [0, 0, None])[0] + counts.get(f, [0, 0, None])[1] == w and counts[f][2] == w for f, w in want.items())
for b in bad_exit: print("  BAD RUN " + b)
print("PASS: every typed theorem and definition of the three files is on the standard three" if good else "FAIL")
sys.exit(0 if good else 1)
PY
