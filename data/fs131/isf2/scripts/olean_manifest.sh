#!/usr/bin/env bash
# FS131-ISF2: sha256 and mtime of every compiled .olean of the library in this worktree. Usage: olean_manifest.sh OUT
cd /home/kooshi/source/lean-dir/.claude/worktrees/kcs1/.lake/build/lib/lean || exit 2
find Proofs Proofs.olean -name '*.olean' -type f -printf '%T@ %p\n' 2>/dev/null | sort -k2 > "$1.mtime"
find Proofs Proofs.olean -name '*.olean' -type f 2>/dev/null | sort | xargs -P 8 -n 64 sha256sum | sort -k2 > "$1"
echo "$(wc -l < "$1") oleans"
