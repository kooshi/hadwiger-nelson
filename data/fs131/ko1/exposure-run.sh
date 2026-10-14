#!/bin/bash
# FS131-KO1: the exposure test, every target in turn; a target whose two exit files exist is skipped (resume = rerun).
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1
for t in OAI158 RadiusOutside LebesgueNumber Rigidity SectionDensity Defs Field InvariantLaw Algebraic Fractional Pair; do
  if [ -e data/fs131/ko1/exposure/$t-base.exit ] && [ -e data/fs131/ko1/exposure/$t-variant.exit ]; then continue; fi
  python3 tools/fs131_ko1_exposure.py run $t
done
echo ALL-DONE > data/fs131/ko1/exposure/ALL-DONE
