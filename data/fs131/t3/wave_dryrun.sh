#!/usr/bin/env bash
# FS131-T3 — run main's new axiom gate over a wave's records, in that wave's worktree, before it lands.
#
# Builds a dry-run audit from the wave's own `scripts/Axioms.lean` (its records, as on its branch) with `main`'s
# instruments and IMPORTED section spliced in after `open HadwigerNelson`, declaring each named axiom, and
# `libraryAxioms` appended; elaborates it in the wave's worktree (`lake env lean`, which builds nothing and reads the worktree's
# oleans — build the worktree first); and judges it with `main`'s `check_receipt`. Its `import-in-clean` lines are
# exactly the records the landing must move under IMPORTED; `sorry` lines are the wave's open leaves.
#
#   data/fs131/t3/wave_dryrun.sh <worktree> <axiom full name>...
#   e.g. data/fs131/t3/wave_dryrun.sh .claude/worktrees/fs131-w2 HadwigerNelson.Plane.falconer_lemma2_nonempty
#
# Outputs under build/t3-dryrun/<branch>/: the audit, its raw output, the check. Nothing in the worktree is written.
set -uo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
TREE="$(cd "${1:?worktree}" && pwd)"; shift
[[ $# -gt 0 ]] || { echo "name at least one axiom to declare"; exit 2; }
BRANCH="$(git -C "${TREE}" rev-parse --abbrev-ref HEAD)"
OUT="${REPO}/build/t3-dryrun/${BRANCH}"
mkdir -p "${OUT}"

REPO="${REPO}" TREE="${TREE}" OUT="${OUT}" python3 - "$@" <<'EOF' || exit 2
import os, sys
repo, tree, out = os.environ["REPO"], os.environ["TREE"], os.environ["OUT"]
main = open(f"{repo}/scripts/Axioms.lean").read()
wave = open(f"{tree}/scripts/Axioms.lean").read()
OPEN, CLEAN, IMP, LIB = 'open HadwigerNelson\n', '#eval IO.println "=== CLEAN ==="', '#eval IO.println "=== IMPORTED ==="', '#eval AxiomAudit.libraryAxioms'
for name, text, marks in (("main", main, (OPEN, CLEAN, IMP, LIB)), ("the wave", wave, (OPEN, CLEAN))):
    for m in marks:
        if text.count(m) != 1:
            sys.exit(f"wave_dryrun: '{m.strip()}' occurs {text.count(m)} times in {name}'s scripts/Axioms.lean, not once")
if IMP in wave:
    sys.exit("wave_dryrun: the wave's audit already has an IMPORTED section; merge main and run its own ./scripts/axioms.sh")
# main's instruments and its IMPORTED section (banner and procedure) sit between `open HadwigerNelson` and the CLEAN banner
head = main[main.index(OPEN):main.index(CLEAN)]
decls = "".join(f"#eval AxiomAudit.declareImport ``{a}\n" for a in sys.argv[1:])
dry = wave[:wave.index(OPEN)] + head + decls + "\n" + wave[wave.index(CLEAN):].rstrip("\n") + "\n\n" + LIB + "\n"
open(f"{out}/Axioms-dryrun.lean", "w").write(dry)
EOF

sed -e "s|^REPO=.*|REPO=\"${REPO}\"|" -e '/^gate_log_open axioms$/,$d' "${REPO}/scripts/axioms.sh" > "${OUT}/check-only.sh"
cat >> "${OUT}/check-only.sh" <<'EOF'
check_receipt "$(normalize < "$1")" "$2"
printf '%s\n' "${CHECK_OUT}"
EOF

source "${REPO}/scripts/dev-env.sh"
( cd "${TREE}" && "${REPO}/scripts/slot.py" --mem 24 --cpus 4 -- lake env lean "${OUT}/Axioms-dryrun.lean" ) > "${OUT}/Axioms-dryrun.out" 2>&1
status=$?
if [[ "${status}" -ne 0 ]]; then
  grep -m5 error "${OUT}/Axioms-dryrun.out"
  echo "wave_dryrun: the dry-run audit did not elaborate in ${TREE} (exit ${status}); full output ${OUT#"${REPO}"/}/Axioms-dryrun.out"
  exit 1
fi
bash "${OUT}/check-only.sh" "${OUT}/Axioms-dryrun.out" "${TREE}/ARCHITECTURE.md" > "${OUT}/check.txt" 2>&1
echo "wave_dryrun: ${BRANCH} at $(git -C "${TREE}" rev-parse --short HEAD), declaring: $*"
grep '^COUNTS ' "${OUT}/check.txt"
echo "records the landing must move under IMPORTED:"
sed -n "s/^FAIL import-in-clean '\([^']*\)'.*/    \1/p" "${OUT}/check.txt"
echo "other failures, sorry apart ($(grep -c '^FAIL sorry ' "${OUT}/check.txt" || true) sorry record(s)):"
grep '^FAIL ' "${OUT}/check.txt" | grep -v '^FAIL sorry \|^FAIL import-in-clean ' | sed 's/^/    /' || echo "    none"
echo "full check: ${OUT#"${REPO}"/}/check.txt"
