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
  done < <(cd "${D}" && find . -name '*.lean' ! -name Bound.lean -printf '%P\n' | sort)
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

if [[ "${FAIL}" -ne 0 ]]; then
  echo "==> regen-check: FAIL — the tree does not match what the generators produce"
  exit 1
fi
echo "==> regen-check: OK"
