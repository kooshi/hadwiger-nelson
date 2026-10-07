#!/usr/bin/env bash
# EXT-OAI1 stage 4, the control: a `sorry` planted in one lemma of the cone must show `sorryAx` at the headline.
# Makes a second tree (never the release's clone, never the main working copy): the 70 cone files, the reduced
# lakefile, .lake/packages symlinked, .lake/build copied; plants `sorry` in the last line of
# `OAI.EuclideanFiveColor.positiveSelect_pos` (BorelTransfer.lean), which the headline reaches through
# `sample_field` and `proper_to_borel_weak`; rebuilds the solution module; prints the axioms.
# Run inside a slot, with data/external/oai1/env.sh sourced.
set -u
WC="$HOME/.cache/ext-oai1/lean"; CT="$HOME/.cache/ext-oai1/control"; HERE="$(cd "$(dirname "$0")" && pwd)"
rm -rf "$CT"; mkdir -p "$CT/.lake" "$CT/Audit"
cp "$WC/lakefile.lean" "$WC/lean-toolchain" "$WC/lake-manifest.json" "$CT/"
while read -r f; do mkdir -p "$CT/$(dirname "$f")"; cp "$WC/$f" "$CT/$f"; done < "$HERE/cone-five-files.txt"
ln -s "$WC/.lake/packages" "$CT/.lake/packages"
cp -a "$WC/.lake/build" "$CT/.lake/build"
python3 - "$CT/OAI/Geometry/PlaneColoring/BorelTransfer.lean" <<'PY'
import sys
p = sys.argv[1]; s = open(p).read()
i = s.index('lemma positiveSelect_pos'); old = '  exact (Finset.mem_filter.mp hmem).2\n'
j = s.index(old, i)
s = s[:j] + '  sorry\n' + s[j + len(old):]
open(p, 'w').write(s); print('planted `sorry` at byte', j)
PY
diff <(cat "$WC/OAI/Geometry/PlaneColoring/BorelTransfer.lean") "$CT/OAI/Geometry/PlaneColoring/BorelTransfer.lean"
cp "$HERE/audit/Axioms.lean" "$CT/Audit/Axioms.lean"
cd "$CT" && lake build OAI.Geometry.PlaneColoring.Five; echo "control build exit=$?"
lake env lean Audit/Axioms.lean; echo "control axioms exit=$?"
