#!/usr/bin/env bash
# Every generated Lean module, regenerated from its committed inputs and compared byte for byte.
#
# `tools/` is untrusted, so this proves nothing about whether the data is *right* — Lean does that,
# and refuses to certify data that is wrong. What this proves is that the data on disk is the data
# the generators produce, which is a different and narrower claim with two uses:
#
#   * **it is the answer to "did a bit flip land in the artifact".** This machine has a history of
#     faulty hardware ; a flipped byte in a 13 MB literal is exactly the
#     kind of thing that hides. It cannot hide from this.
#   * **it makes the artifact reproducible rather than merely re-derivable.** A reviewer regenerates
#     every generated line from six committed files and gets the same bytes — including the LRAT
#     certificate, since CaDiCaL at a fixed seed on one thread is deterministic here.
#
# Nothing here writes into the repository: everything is regenerated into a scratch directory.
#
# Usage:  scripts/regen-check.sh [scratch-dir]
set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${REPO}"
source "${REPO}/scripts/dev-env.sh"

V="${1:-$(mktemp -d)}"
mkdir -p "${V}"
CADICAL="${CADICAL:-$(lean --print-prefix)/bin/cadical}"
FAIL=0

# witness  n    triangle          cadical-seed  chunk  edges-name
WITNESSES=(
  "heule510 510 [(0,0),(27,1),(28,2)] 2 179 heule510.edges"
  "heule553 553 [(0,0),(9,1),(10,2)]  3 171 heule553.edges"
)

for w in "${WITNESSES[@]}"; do
  read -r NAME N PINS SEED CHUNK EDGES <<< "${w}"
  SIZE="${N}"
  echo "==> ${NAME}"

  # 1. exact coordinates, from the vendored vertex/edge lists
  python3 tools/heule.py "tools/heule/${SIZE}.vtx" "tools/heule/${SIZE}.edge" -o "${V}/${NAME}.json" \
    > /dev/null 2>&1 || { echo "    FAIL: geometry did not re-derive"; FAIL=1; continue; }
  if ! cmp -s "${V}/${NAME}.json" "tools/${NAME}.json"; then
    echo "    FAIL: ${NAME}.json differs from the committed inputs"; FAIL=1; continue
  fi

  # 2. the formula, and the certificate the solver produces for it
  python3 - "${V}" "${NAME}" "${N}" "${PINS}" <<'PY'
import json, sys
sys.path.insert(0, 'tools')
from coloring import write_cnf
from pathlib import Path
V, name, n, pins = sys.argv[1], sys.argv[2], int(sys.argv[3]), eval(sys.argv[4])
g = json.load(open(f'tools/{name}.json'))
write_cnf(Path(f'{V}/{name}.cnf'), n, [tuple(e) for e in g['edges']], pins)
PY
  "${CADICAL}" -q --lrat --no-binary --unsat "--seed=${SEED}" \
    "${V}/${NAME}.cnf" "${V}/${NAME}.lrat" > /dev/null 2>&1
  [[ "$?" -eq 20 ]] || { echo "    FAIL: the formula did not refute"; FAIL=1; continue; }

  # 3. the modules, into a scratch tree, then compared ignoring only the import prefix that the
  #    emitter derives from its own output path
  D="Proofs/HadwigerNelson/Instances/$(tr '[:lower:]' '[:upper:]' <<< "${NAME:0:1}")${NAME:1}"
  MOD="Proofs.HadwigerNelson.Instances.$(tr '[:lower:]' '[:upper:]' <<< "${NAME:0:1}")${NAME:1}"
  mkdir -p "${V}/${NAME}/Cnf"
  python3 tools/emit_cert.py "tools/${NAME}.json" "${NAME}" --dir "${V}/${NAME}" \
    --chunk "${CHUNK}" --per-module 2 > /dev/null 2>&1
  python3 tools/emit_diffs.py "tools/${NAME}.json" "${NAME}" --dir "${V}/${NAME}" \
    --module "${MOD}" > /dev/null 2>&1
  # The certificate imports the *edge list*, never the geometry: that is what keeps a change to the
  # geometry from re-checking every segment module beneath it (plans/M08 § 0(f)).
  python3 tools/emit_mask.py --edges "tools/${NAME}.json" --n "${N}" --edges-name "${EDGES}" \
    --import "${MOD}.Edges" \
    --pins "${PINS}" --lrat "${V}/${NAME}.lrat" --name "${NAME}" --out "${V}/${NAME}/Cnf" \
    --module "${MOD}.Cnf" \
    --segments 82 --table-modules 4 > /dev/null 2>&1

  N_OK=0
  while IFS= read -r f; do
    a="${V}/${NAME}/${f}"; b="${D}/${f}"
    [[ -f "${a}" ]] || { echo "    FAIL: ${f} was not regenerated"; FAIL=1; continue; }
    if ! diff -q <(grep -v '^import ' "${a}") <(grep -v '^import ' "${b}") > /dev/null; then
      echo "    FAIL: ${f} differs in content"; FAIL=1; continue
    fi
    N_OK=$((N_OK + 1))
    # `Critical.lean` and `Critical/` come from a different emitter and are checked below, on their
    # own terms -- their evidence is colourings rather than a refutation.
  done < <(cd "${D}" && find . -name '*.lean' ! -name Bound.lean ! -name Critical.lean \
             ! -path './Critical/*' -printf '%P\n' | sort)
  echo "    ${N_OK} generated modules identical, certificate reproduced bit for bit"
done

# de Grey's geometry, which has no vendored input of its own: `tools/degrey.py` *constructs* the
# point set, and `degrey_cert.json` is that construction's committed output. The certificate is 397 MB
# and is not regenerated here; the geometry is, because it is the part M08 rewrote.
echo "==> deGrey (geometry only)"
DG="Proofs/HadwigerNelson/Instances/DeGrey"
mkdir -p "${V}/deGrey"
python3 tools/emit_diffs.py tools/degrey_cert.json deGrey --dir "${V}/deGrey" \
  --module Proofs.HadwigerNelson.Instances.DeGrey > /dev/null 2>&1 \
  || { echo "    FAIL: the difference witness did not re-derive"; FAIL=1; }
for f in Diffs.lean Valid.lean; do
  if ! diff -q <(grep -v '^import ' "${V}/deGrey/${f}") <(grep -v '^import ' "${DG}/${f}") > /dev/null
  then echo "    FAIL: ${f} differs in content"; FAIL=1
  fi
done
[[ "${FAIL}" -eq 0 ]] && echo "    2 generated modules identical"

# The core-and-spindle witness has no vendored input at all: `tools/corespindle.py` *constructs* the
# graph from the row spec and then solves the dual linear program for the weights, so this block
# re-derives the mathematics as well as the formatting. The linear program is seeded and HiGHS is
# deterministic, so the weights reproduce exactly; if they ever stop doing so, the bound is still
# whatever the kernel certified — this check is about the bytes, not the theorem.
echo "==> coreSpindle"
CS="Proofs/HadwigerNelson/Instances/CoreSpindle"
python3 tools/corespindle.py --rows 6 5 4 --out "${V}/corespindle63.json" \
  --lean "${V}/Weights.lean" > /dev/null 2>&1 \
  || { echo "    FAIL: the generator did not re-run"; FAIL=1; }
cmp -s "${V}/corespindle63.json" tools/corespindle63.json \
  || { echo "    FAIL: corespindle63.json differs from what the construction produces"; FAIL=1; }
python3 tools/emit_cert.py "${V}/corespindle63.json" coreSpindle --out "${V}/Cert.lean" \
  > /dev/null 2>&1 || { echo "    FAIL: the certificate did not re-emit"; FAIL=1; }
for f in Cert.lean Weights.lean; do
  cmp -s "${V}/${f}" "${CS}/${f}" || { echo "    FAIL: ${f} differs"; FAIL=1; }
done
[[ "${FAIL}" -eq 0 ]] && echo "    2 generated modules identical, weights re-derived from the LP"

# ---------------------------------------------------------------------------------------------
# The search instrument's own controls (M11).
#
# The three tools added at M11 generate nothing committed, so nothing above touches them — and a
# tool nobody exercises is a tool nobody has checked. Each carries `--self-test`: a pair of
# questions with *opposite* expected answers, so a tool that always says "refuted", always says
# "achieved", or always reports the identity fails rather than passing quietly. Both have been
# watched to go red (`plans/M11-search-instrument.md` § 4).
echo "==> search instrument"
if ! python3 tools/field.py > "${V}/field.log" 2>&1; then
  sed 's/^/    /' "${V}/field.log"; echo "    FAIL: tools/field.py"; FAIL=1
else
  echo "    field.py: $(grep -c '^  ok' "${V}/field.log") controls, one implementation for five tools"
fi
if ! python3 tools/construct.py --self-test > "${V}/construct.log" 2>&1; then
  sed 's/^/    /' "${V}/construct.log"; echo "    FAIL: tools/construct.py"; FAIL=1
else
  echo "    construct.py: $(grep -c '^  ok' "${V}/construct.log") controls, including rebuilding the Moser spindle"
fi
if ! python3 tools/forcer.py --self-test > "${V}/forcer.log" 2>&1; then
  sed 's/^/    /' "${V}/forcer.log"; echo "    FAIL: tools/forcer.py"; FAIL=1
else
  echo "    forcer.py: $(grep -c '^  ok' "${V}/forcer.log") controls, the search's win condition"
fi

# **de Grey's committed coordinates, DERIVED.** The 1581-point table is rebuilt from his 39 seed
# points by four primitive moves -- orbit, spindle, delete, spindle -- and compared point for point
# in the exact field. This is what makes the committed table derived data rather than transcribed
# data: a reader who does not trust the JSON can watch it be constructed. ~14 s.
if ! python3 -c "
import sys; sys.path.insert(0, 'tools')
import construct as C
g = C.degrey_from_primitives()
assert len(g) == 1581, f'built {len(g)} points, wanted 1581'
assert C.degrey_matches_committed(), 'the primitive build does not match the committed table'
print(f'  ok  de Grey rebuilt from 39 seeds by 4 moves: {len(g)} points, exact match')
" > "${V}/degrey-primitives.log" 2>&1; then
  sed 's/^/    /' "${V}/degrey-primitives.log"; echo "    FAIL: de Grey from primitives"; FAIL=1
else
  echo "    de Grey's 1581 points rebuilt from 39 seeds by orbit+spindle+delete+spindle, exact"
fi

if ! python3 tools/profile.py --self-test > "${V}/profile.log" 2>&1; then
  sed 's/^/    /' "${V}/profile.log"; echo "    FAIL: tools/profile.py"; FAIL=1
else
  echo "    profile.py: $(grep -c '^  ok' "${V}/profile.log") controls"
fi
if ! python3 tools/scan.py --self-test > "${V}/scan.log" 2>&1; then
  sed 's/^/    /' "${V}/scan.log"; echo "    FAIL: tools/scan.py"; FAIL=1
else
  echo "    scan.py: $(grep -c '^  ok' "${V}/scan.log") controls, including de Grey's 791-point split"
fi
# minimise.py has no self-test of its own; it is exercised end to end, because a shrinker that
# preserved nothing would return the empty graph and a shrinker that preserved everything would
# return the input. The rhombus does neither: all four of its vertices are needed.
echo '{"n": 4, "edges": [[0,1],[0,2],[1,2],[1,3],[2,3]]}' > "${V}/rhombus.json"
python3 tools/profile.py --graph "${V}/rhombus.json" --ports 0 3 --colours 3 \
  --out "${V}/rh.json" > "${V}/rh.log" 2>&1
# Written to a file and grepped afterwards, never piped: `grep -q` exits at the first match and
# SIGPIPEs the writer, which under `set -o pipefail` turns a *successful* check into a failed one.
python3 tools/minimise.py --profile "${V}/rh.json" --jobs 2 --rounds 3 > "${V}/min.log" 2>&1
if grep -q "4 vertices, 5 edges$" "${V}/min.log"; then
  echo "    minimise.py: the rhombus does not shrink — every vertex carries the property"
else
  sed 's/^/    /' "${V}/min.log"
  echo "    FAIL: tools/minimise.py shrank a graph that has nothing to spare"; FAIL=1
fi

# The criticality certificates: one four-colouring per deleted vertex, {510, 553} rows each. These
# are the evidence behind M15's negative -- "no five-colour fan sits anywhere in this graph" -- so
# they get the same treatment as the refutation certificates: regenerate and compare byte for byte.
# cadical is deterministic on a fixed input, so a satisfying assignment is reproducible even though
# nothing about SAT requires it to be; that is checked here rather than assumed.
#
# The emitter also REFUSES to write anything when a pivot is unsettled or a vertex is removable, so
# a green line here means both that the bytes match and that every one of the 1063 pivots settled.
echo "==> criticality certificates"
for W in heule510 heule553; do
  CAP="$(tr '[:lower:]' '[:upper:]' <<< "${W:0:1}")${W:1}"
  DIR="Proofs/HadwigerNelson/Instances/${CAP}/Critical"
  cp -r "${DIR}" "${V}/${W}-crit-before"
  if ! python3 tools/emit_critical.py "${W}" --colours 4 --rows 64 > "${V}/${W}-crit.log" 2>&1; then
    sed 's/^/    /' "${V}/${W}-crit.log"
    echo "    FAIL: tools/emit_critical.py refused to emit ${W}"; FAIL=1
  elif ! diff -r -q "${V}/${W}-crit-before" "${DIR}" > /dev/null; then
    echo "    FAIL: ${W}'s criticality certificate is not what the emitter produces"; FAIL=1
  else
    echo "    ${W}: $(ls "${DIR}" | wc -l) chunks identical, every pivot settled, 0 removable"
  fi
done

if [[ "${FAIL}" -ne 0 ]]; then
  echo "==> regen-check: FAIL — the tree does not match what the generators produce"
  exit 1
fi
echo "==> regen-check: OK"
