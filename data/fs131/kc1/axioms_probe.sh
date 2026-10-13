#!/usr/bin/env bash
# FS131-KC1: print the axioms of Plane/LebesgueNumber's public surface before the module is built.
# The module's text with axioms-probe-tail.lean appended is elaborated as one file (`lake env lean` builds nothing);
# the print goes to axioms-probe.out.  With --fault, the proof of `HasDensityOneAt.nonempty` is replaced by `sorry`
# in the copy first: `sorryAx` must then appear in the headline's list (the control; exit 0 only if it does).
# Run from the worktree root, under the slot:  scripts/slot.py --mem 4 --cpus 2 -- data/fs131/kc1/axioms_probe.sh
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"; root="$(cd "$here/../../.." && pwd)"
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
cat "$root/Proofs/HadwigerNelson/Plane/LebesgueNumber.lean" "$here/axioms-probe-tail.lean" > "$tmp/AxiomsProbe.lean"
if [ "${1:-}" = "--fault" ]; then
  python3 - "$tmp/AxiomsProbe.lean" <<'PY'
import sys, pathlib
p = pathlib.Path(sys.argv[1]); s = p.read_text()
a = s.index("theorem HasDensityOneAt.nonempty"); b = s.index(":= by", a) + len(":= by"); c = s.index("\n\n", b)
p.write_text(s[:b] + "\n  sorry" + s[c:])
PY
  cd "$root" && lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$tmp/AxiomsProbe.lean" > "$tmp/fault.out"
  n=$(grep -c sorryAx "$tmp/fault.out" || true)
  echo "fault: sorryAx appears in $n lines"; grep -A2 "chromaticNumber_plane_eq_chiLebesgue' depends" "$tmp/fault.out"
  [ "$n" -gt 0 ]
else
  cd "$root" && lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$tmp/AxiomsProbe.lean" > "$here/axioms-probe.out"
  echo "records: $(grep -c 'depends on axioms' "$here/axioms-probe.out"); sorryAx lines: $(grep -c sorryAx "$here/axioms-probe.out" || true)"
fi
