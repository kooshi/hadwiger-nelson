#!/bin/bash
# F1 gates, exit statuses read directly
cd /home/kooshi/source/lean-dir
python3 tools/claude_md_fact_audit.py --base d03df9a8 > /tmp/claude-1000/f1_g_audit.txt 2>&1; a=$?
python3 tools/claude_md_fact_audit.py --dupes > /tmp/claude-1000/f1_g_dupes.txt 2>&1; d=$?
dn=$(head -1 /tmp/claude-1000/f1_g_dupes.txt | awk '{print $1}')
python3 tools/fs71_ledger_b_check.py --strict > /tmp/claude-1000/f1_g_lb.txt 2>&1; l=$?
python3 tools/bib_audit.py > /tmp/claude-1000/f1_g_bib.txt 2>&1; b=$?
python3 tools/check_architecture.py > /tmp/claude-1000/f1_g_arch.txt 2>&1; c=$?
sz=$(wc -c < CLAUDE.md)
echo "audit=$a dupes_exit=$d dupes=$dn ledgerB=$l bib=$b arch=$c CLAUDE.md=$sz GI=$(wc -c < plans/GROKKING-INSTANCES.md)"
[ $a -eq 0 ] && [ $d -eq 0 ] && [ "$dn" -le 10 ] && [ $l -eq 0 ] && [ $b -eq 0 ] && [ $c -eq 0 ] && [ $sz -lt 300000 ]
