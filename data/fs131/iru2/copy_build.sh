#!/usr/bin/env bash
# FS131-IRU2: bring main's gated build (FS131-IFR2's, of b8cef1f36, in the main tree) into this worktree's .lake/build by
# checksum, no --delete (LEAN.md § Building, FS131-LU1's rule), restricted to the files of the modules whose main build is
# right for the merged tree: in main's changed cone and outside the cone of what this branch changed (copy-modules.txt,
# from cone.py; LEAN.md § Building, FS131-ICS1's line). After FS131-IFR2's copy_build.sh.
# Usage: copy_build.sh dry-full | dry | real
#   dry-full: what an unrestricted copy would change -> copy-dryrun-full.txt (read, not run)
#   dry:      the restricted copy's itemized list -> copy-dryrun.txt; its files -> copy-list.txt
#   real:     SHA-256 of every listed file in the source before, the copy (itemized), the source after, the destination after
set -u
SRC=/home/kooshi/source/lean-dir/.lake/build/
DST=/home/kooshi/source/lean-dir/.claude/worktrees/il5/.lake/build/
D=/home/kooshi/source/lean-dir/.claude/worktrees/il5/data/fs131/iru2
files() {  # every build file of each listed module, relative to .lake/build, that exists in the source
  while read -r m; do [ -n "$m" ] || continue; p=${m//.//}
    for f in lib/lean/$p.olean lib/lean/$p.olean.hash lib/lean/$p.ilean lib/lean/$p.ilean.hash lib/lean/$p.trace \
             ir/$p.c ir/$p.c.hash ir/$p.setup.json; do [ -e "$SRC$f" ] && echo "$f"; done
  done < "$D/copy-modules.txt"; }
case "${1:-}" in
  dry-full)
    rsync -a --checksum --dry-run --itemize-changes "$SRC" "$DST" > "$D/copy-dryrun-full.txt"; st=$?
    echo "rsync dry-full exit=$st; files that would be written: $(grep -c '^>f' "$D/copy-dryrun-full.txt")"; exit $st ;;
  dry)
    files > "$D/copy-candidates.txt"; echo "candidate files: $(wc -l < "$D/copy-candidates.txt") for $(grep -c . "$D/copy-modules.txt") modules"
    rsync -a --checksum --dry-run --itemize-changes --files-from="$D/copy-candidates.txt" "$SRC" "$DST" > "$D/copy-dryrun.txt"; st=$?
    echo "rsync dry exit=$st"
    grep '^>f' "$D/copy-dryrun.txt" | cut -c13- > "$D/copy-list.txt"
    echo "files to copy: $(wc -l < "$D/copy-list.txt")  (new: $(grep -c '^>f+++++++' "$D/copy-dryrun.txt"), changed: $(grep '^>f' "$D/copy-dryrun.txt" | grep -vc '^>f+++++++'))"
    exit $st ;;
  real)
    [ -s "$D/copy-list.txt" ] || { echo "no copy-list.txt: run dry first"; exit 2; }
    (cd "$SRC" && tr '\n' '\0' < "$D/copy-list.txt" | xargs -0 sha256sum) > "$D/copy-src-before.sha"; s1=$?
    (cd "$DST" && tr '\n' '\0' < "$D/copy-list.txt" | xargs -0 sha256sum 2>/dev/null) > "$D/copy-dst-before.sha"
    rsync -a --checksum --itemize-changes --files-from="$D/copy-candidates.txt" "$SRC" "$DST" > "$D/copy-rsync.txt"; st=$?
    echo "rsync real exit=$st"
    (cd "$SRC" && tr '\n' '\0' < "$D/copy-list.txt" | xargs -0 sha256sum) > "$D/copy-src-after.sha"; s2=$?
    (cd "$DST" && tr '\n' '\0' < "$D/copy-list.txt" | xargs -0 sha256sum) > "$D/copy-dst.sha"; s3=$?
    echo "sha exits: $s1 $s2 $s3"
    if cmp -s "$D/copy-src-before.sha" "$D/copy-src-after.sha"; then echo "source unchanged during the copy: YES"; else echo "source unchanged during the copy: NO"; fi
    if cmp -s "$D/copy-src-after.sha" "$D/copy-dst.sha"; then echo "destination equals source: YES"; else echo "destination equals source: NO"; fi
    echo "itemized lines in the real copy: $(grep -c '^>f' "$D/copy-rsync.txt") (dry run: $(wc -l < "$D/copy-list.txt"))"
    exit $st ;;
  *) echo "usage: $0 dry-full|dry|real"; exit 2 ;;
esac
