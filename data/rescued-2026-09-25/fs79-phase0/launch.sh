#!/bin/bash
# usage: launch.sh <tag> <args to tools/fs79_p0.py ...>   -- setsid + flock on the heavy lock; pgid in $SCR/<tag>.pgid; log in $SCR/<tag>.log
SCR=/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-phase0
LOCK=/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock
tag=$1; shift
cd /home/kooshi/source/lean-dir
setsid bash -c "echo \$\$ > $SCR/$tag.pgid; exec flock -w 1800 $LOCK python3 tools/fs79_p0.py $*" > $SCR/$tag.log 2>&1 < /dev/null &
sleep 1; echo "pgid $(cat $SCR/$tag.pgid)"
