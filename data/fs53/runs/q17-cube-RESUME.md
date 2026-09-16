# chi(UD(F_17,2)) exactly — resume command (written BEFORE launch, per CLAUDE.md)

Question: is UD(F_17,2) 5-colourable?  Moorhouse Table 6.1 has chi in {5,6,7}; FS-53 narrowed it to
{5,6} by exhibiting a 6-colouring.  SAT here => chi = 5 and the cell is closed; exhaustive UNSAT
=> chi = 6 exactly.

RESUME (identical command; the checkpoint is resumed from and appended to, and a checkpoint written
for a different vertex order is REFUSED by name rather than silently misread):
  cd /home/kooshi/source/lean-dir && setsid nohup nice -n 5 python3 tools/fplane_sat_cube.py run \
    --q 17 --k 5 --depth 8 --cap 30 --max-depth 24 --workers 8 \
    --scratch /home/kooshi/.claude/jobs/b1507518/tmp/cube17 \
    --ckpt data/fs53/ckpt/cube-q17-k5.jsonl \
    --out /home/kooshi/.claude/jobs/b1507518/tmp/cube17/record-q17-k5.json \
    >> /home/kooshi/.claude/jobs/b1507518/tmp/cube17/sweep.log 2>&1 &

VERIFY a SAT colouring independently, from the definition, with a tool sharing no code with this one:
  python3 tools/fplane_review_verify.py colour --q 17 --k 5 \
    --json /home/kooshi/.claude/jobs/b1507518/tmp/cube17/record-q17-k5.json --path colouring
