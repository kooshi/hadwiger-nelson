#!/usr/bin/env bash
# FS131-IFR2: copy main's gated build (FS131-ICS1's, of 960882257) into this worktree's .lake/build by checksum, no --delete
# (LEAN.md § Building, FS131-LU1's rule). Usage: copy_build.sh dry | real
# dry:  the itemized list of what would change -> copy-dryrun.txt; the list of files -> copy-list.txt
# real: SHA-256 of every listed file in the source before, the copy itself (itemized), the source again after, the destination
#       after; prints whether source-before = source-after = destination.
set -u
SRC=/home/kooshi/source/lean-dir/.lake/build/
DST=/home/kooshi/source/lean-dir/.claude/worktrees/kcl1/.lake/build/
D=/home/kooshi/source/lean-dir/.claude/worktrees/kcl1/data/fs131/ifr2
case "${1:-}" in
  dry)
    rsync -a --checksum --dry-run --itemize-changes "$SRC" "$DST" > "$D/copy-dryrun.txt"; st=$?
    echo "rsync dry exit=$st"
    grep '^>f' "$D/copy-dryrun.txt" | cut -c13- > "$D/copy-list.txt"
    echo "files to copy: $(wc -l < "$D/copy-list.txt")  (new: $(grep -c '^>f+++++++' "$D/copy-dryrun.txt"), changed: $(grep '^>f' "$D/copy-dryrun.txt" | grep -vc '^>f+++++++'))"
    echo "other lines: $(grep -vc '^>f' "$D/copy-dryrun.txt")"
    exit $st ;;
  real)
    [ -s "$D/copy-list.txt" ] || { echo "no copy-list.txt: run dry first"; exit 2; }
    (cd "$SRC" && tr '\n' '\0' < "$D/copy-list.txt" | xargs -0 sha256sum) > "$D/copy-src-before.sha"; s1=$?
    rsync -a --checksum --itemize-changes "$SRC" "$DST" > "$D/copy-rsync.txt"; st=$?
    echo "rsync real exit=$st"
    (cd "$SRC" && tr '\n' '\0' < "$D/copy-list.txt" | xargs -0 sha256sum) > "$D/copy-src-after.sha"; s2=$?
    (cd "$DST" && tr '\n' '\0' < "$D/copy-list.txt" | xargs -0 sha256sum) > "$D/copy-dst.sha"; s3=$?
    echo "sha exits: $s1 $s2 $s3"
    if cmp -s "$D/copy-src-before.sha" "$D/copy-src-after.sha"; then echo "source unchanged during the copy: YES"; else echo "source unchanged during the copy: NO"; fi
    if cmp -s "$D/copy-src-after.sha" "$D/copy-dst.sha"; then echo "destination equals source: YES"; else echo "destination equals source: NO"; fi
    echo "itemized lines in the real copy: $(grep -c '^>f' "$D/copy-rsync.txt") (dry run: $(wc -l < "$D/copy-list.txt"))"
    exit $st ;;
  *) echo "usage: $0 dry|real"; exit 2 ;;
esac
