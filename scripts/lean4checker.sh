#!/usr/bin/env bash
# The de Bruijn criterion, made executable: replay every declaration in `Proofs` through an
# *independent* kernel. `lake build` proves the elaborator accepted our terms; this proves a
# separately-written type checker accepts them too, so a bug in Lean's own elaborator-side caching
# or environment handling cannot hide inside our .oleans.
#
# It matters most for the certificate modules, whose truth rests on kernel *reduction*
# (`by decide` over the Q4 tower) rather than on a written proof term.
#
# lean4checker is not a package dependency — it pins its own toolchain and would drag the project's
# pin around. It is cloned and built on demand here, into the directory given by $CHECKER_DIR
# (default: a sibling of the repo), with our `lean-toolchain` forced on it.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CHECKER_DIR="${CHECKER_DIR:-${REPO}/.lake/lean4checker}"
TARGET="${1:-Proofs}"

source "${REPO}/scripts/dev-env.sh"

if [[ ! -x "${CHECKER_DIR}/.lake/build/bin/lean4checker" ]]; then
  echo "==> building lean4checker in ${CHECKER_DIR}"
  rm -rf "${CHECKER_DIR}"
  git clone -q --depth 1 https://github.com/leanprover/lean4checker.git "${CHECKER_DIR}"
  cp "${REPO}/lean-toolchain" "${CHECKER_DIR}/lean-toolchain"
  (cd "${CHECKER_DIR}" && lake build)
fi

# lean4checker is a bare executable: it needs LEAN_PATH pointing at every built library.
LEAN_PATH="${REPO}/.lake/build/lib/lean"
for pkg in "${REPO}"/.lake/packages/*/; do
  [[ -d "${pkg}.lake/build/lib/lean" ]] && LEAN_PATH="${LEAN_PATH}:${pkg}.lake/build/lib/lean"
done
export LEAN_PATH

# lean4checker walks the *compiled* tree, not the module graph, so an .olean whose source has been
# deleted is still replayed. M06 hit this: renaming the geometry layout from 16 modules to 9 left seven
# stale oleans referring to constants that no longer exist, and the replay failed on a file that was
# not part of the library. Worse than the noise is the other direction — a stale olean that *passes*
# would make this script's OK a claim about a file nobody builds.
#
# So: fail loudly on an orphan, and name it. `lake build` does not clean these up.
echo "==> checking for compiled modules whose source is gone"
ORPHANS=0
while IFS= read -r olean; do
  src="${olean#.lake/build/lib/lean/}"
  src="${src%.olean}.lean"
  if [[ ! -f "${REPO}/${src}" ]]; then
    echo "    ORPHAN: ${olean} (no ${src})"
    ORPHANS=$((ORPHANS + 1))
  fi
done < <(cd "${REPO}" && find .lake/build/lib/lean/Proofs -name '*.olean' -print)
if [[ "${ORPHANS}" -ne 0 ]]; then
  echo "==> lean4checker: FAIL — ${ORPHANS} stale .olean(s); the replay would cover files the library"
  echo "    no longer contains. Remove them (and their .ilean/.trace siblings) and re-run."
  exit 1
fi
echo "    none"

echo "==> replaying ${TARGET} through the independent kernel"
"${CHECKER_DIR}/.lake/build/bin/lean4checker" "${TARGET}"
echo "==> lean4checker: OK"
