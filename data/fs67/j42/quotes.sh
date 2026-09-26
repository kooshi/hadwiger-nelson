#!/usr/bin/env bash
# J42 stage 1: every quoted fragment of the brief (and of its template J23a's Kooshi quotes) must occur verbatim (grep -F) in its source.
# PLANT=1 swaps one fragment for a spelling that does not occur; the run must then exit 1.
set -u
cd "$(dirname "$0")/../../.."
fail=0
chk() { # fragment source...
  local frag="$1"; shift
  if grep -qF -- "$frag" "$@" 2>/dev/null; then echo "FOUND   | $frag | $*"; else echo "MISSING | $frag | $*"; fail=1; fi
}
chk 'D_C = −6w₂^c' plans/FS67-J27V-verification.md
chk 'match J27D'"'"'s table to every' plans/FS67-J27V-verification.md
chk 'the gap-free form fails at every `k ≥ 4`' plans/FS67-J27D-derivation.md
chk 'That ask is not in the brief and I did not verify it; J27D records it as GAP' plans/FS67-J27V-verification.md
chk 'B(3) in DSW'"'"'s words, generalised to gap-free' plans/FS67-J27D-derivation.md
chk 'a regular Hoffman-fat Hedetniemi factor' plans/FS67-J27V-verification.md
chk 'So **J27D'"'"'s post-ban PB-1 cannot refuse at `C₅`**' plans/FS67-J27V-verification.md
chk 'No verdict diverges from J27D' data/crunch-2026-09-25/reports/J27V.md
chk 'for which `G` does FS67(G, k) hold' plans/FS67-tight-products.md
if [ "${PLANT:-0}" = 1 ]; then chk 'D_C = +6w₂^c' plans/FS67-J27V-verification.md; fi
chk 'All novel knowledge is a success' CLAUDE.md
exit $fail
