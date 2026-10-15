#!/bin/bash
# FS131-LCH1: the gate's steps that read the joined tree (item 4 of the brief), one after another in one slot.
# Resume: rerun (each log is rewritten whole).
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1 || exit 2
D=data/fs131/lch1
./scripts/dupnames.sh > $D/dupnames-5.log 2>&1; echo "dupnames exit=$?" | tee -a $D/dupnames-5.log
./scripts/axioms.sh > $D/axioms-5.log 2>&1; echo "axioms exit=$?" | tee -a $D/axioms-5.log
lake lint --no-build -- --no-build --trace > $D/lint-5.log 2>&1; echo "lint exit=$?" | tee -a $D/lint-5.log
python3 tools/check_architecture.py > $D/arch-5.log 2>&1; echo "arch exit=$?" | tee -a $D/arch-5.log
