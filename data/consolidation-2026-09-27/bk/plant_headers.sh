#!/usr/bin/env bash
# BK stage 2: plant one header of each formerly silent shape in a scratch copy of the derivation files and watch
# tools/fs71_ledger_b_check.py --strict fail for each shape's own reason, naming the header; run the checker as it stood at
# a5fe409d on the same planted tree to show the shapes were silent there (the pair: the new red comes from the new code).
# Usage: data/consolidation-2026-09-27/bk/plant_headers.sh <scratch dir>   (run from the repository root)
set -u
S="${1:?scratch dir}"
rm -rf "$S"; mkdir -p "$S/new/tools" "$S/new/plans" "$S/old/tools" "$S/old/plans"
for d in new old; do cp plans/*-derivation.md "$S/$d/plans/"; cp LEDGER.md "$S/$d/"; done
cp tools/fs71_ledger_b_check.py "$S/new/tools/"
git show a5fe409d:tools/fs71_ledger_b_check.py > "$S/old/tools/fs71_ledger_b_check.py"
for d in new old; do cat >> "$S/$d/plans/FS110-derivation.md" <<'PLANT'

**FS110-PLANTA — Planted: nested brackets in the grade. [hand; over Parts [external]]**
*Proof:* p. *Proof verdict:* v. *Rests on it:* r. *Prior art:* a. *Kernel:* k.

**FS110-PLANTÉ — Planted: a non-ASCII id. [hand; one mind: BK]**
*Proof:* p. *Proof verdict:* v. *Rests on it:* r. *Prior art:* a. *Kernel:* k.

**FS110-PLANTC (the planted one) — Planted: a parenthetical before the dash. [hand; one mind: BK]**
*Proof:* p. *Proof verdict:* v. *Rests on it:* r. *Prior art:* a. *Kernel:* k.

**FS110-PLANTD — Planted: the window `R_y = [a, b)` in the title. [hand; one mind: BK]**
*Proof:* p. *Proof verdict:* v. *Rests on it:* r. *Prior art:* a. *Kernel:* k.
PLANT
done
echo "== new checker on the planted tree (must FAIL, four lines naming the four headers) =="
python3 "$S/new/tools/fs71_ledger_b_check.py" --strict > "$S/new.out"; echo "exit=$?"; grep -v '^census' "$S/new.out"
echo "== old checker (a5fe409d) on the same planted tree =="
python3 "$S/old/tools/fs71_ledger_b_check.py" --strict > "$S/old.out"; echo "exit=$?"; grep -v '^census' "$S/old.out"
