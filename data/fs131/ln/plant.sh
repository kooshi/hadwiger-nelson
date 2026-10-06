#!/usr/bin/env bash
# FS131-LN1: the linters' negative control — plant one fault in one library file, and take it out again.
#
#   data/fs131/ln/plant.sh plant      append the plant to OpenMove.lean (refuses unless the file is HEAD's, byte for byte)
#   data/fs131/ln/plant.sh restore    write HEAD's bytes back, and prove it: sha256 equal to the one taken before, git diff empty
#   data/fs131/ln/plant.sh status     say which of the two states the file is in
#
# The plant is never committed. If a session ends between `plant` and `restore`, `git status` shows the file
# modified; `plant.sh restore` (or `git checkout HEAD -- <file>`) and a build through scripts/build.sh undo it.
set -u
F=Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean
D=data/fs131/ln
head_sha() { git show "HEAD:${F}" | sha256sum | cut -d' ' -f1; }
file_sha() { sha256sum "${F}" | cut -d' ' -f1; }
case "${1:-}" in
  plant)
    if [[ "$(file_sha)" != "$(head_sha)" ]]; then echo "REFUSED: ${F} is not HEAD's file"; exit 2; fi
    file_sha > "${D}/plant.sha256-before"
    wc -l < "${F}" > "${D}/plant.lines-before"
    if [[ -n "$(tail -c1 "${F}")" ]]; then echo "REFUSED: ${F} does not end in a newline"; exit 2; fi
    cat >> "${F}" <<'EOF'

/-- FS131-LN1's planted fault, for the linters' negative control: `m` is unused. Never committed. -/
def fs131LnLintPlant (n m : ℕ) : ℕ := n
EOF
    file_sha > "${D}/plant.sha256-planted"
    git diff -- "${F}" > "${D}/plant.diff"
    echo "planted: $(cat ${D}/plant.sha256-before) -> $(cat ${D}/plant.sha256-planted); the def is at line $(wc -l < "${F}")"
    ;;
  restore)
    git show "HEAD:${F}" > "${F}.fs131ln-restore" || { echo "FAILED: git show"; exit 2; }
    mv "${F}.fs131ln-restore" "${F}"
    file_sha > "${D}/plant.sha256-after"
    if [[ "$(cat ${D}/plant.sha256-after)" != "$(cat ${D}/plant.sha256-before)" ]]; then
      echo "FAILED: sha256 after $(cat ${D}/plant.sha256-after) is not the one before $(cat ${D}/plant.sha256-before)"; exit 1
    fi
    if ! git diff --quiet -- "${F}"; then echo "FAILED: git diff is not empty"; exit 1; fi
    if grep -q fs131LnLintPlant "${F}"; then echo "FAILED: the plant's name is still in the file"; exit 1; fi
    echo "restored: sha256 $(cat ${D}/plant.sha256-after) = before; git diff empty; the plant's name absent"
    ;;
  status)
    if [[ "$(file_sha)" == "$(head_sha)" ]]; then echo "clean: ${F} is HEAD's file ($(file_sha))"
    else echo "PLANTED or modified: ${F} is $(file_sha), HEAD's is $(head_sha)"; fi
    grep -c fs131LnLintPlant "${F}" | sed 's/^/occurrences of the plant name: /'
    ;;
  *) echo "usage: plant.sh plant|restore|status"; exit 2 ;;
esac
