#!/usr/bin/env bash
# FS131-ISF1: elaborate one Lean file under /usr/bin/time and record wall time, peak memory, exit (iteration and
# measurement only -- the build is the check). With -o, write the .olean of a new module into this tree's build.
# usage (from the worktree root): data/fs131/isf1/probe.sh <tag> <file.lean> [<out.olean>]
# log: data/fs131/isf1/probes/logs/<tag>.log, ending with the time report and "exit=<n>".
set -u
tag="$1"; f="$2"; o="${3:-}"
mkdir -p data/fs131/isf1/probes/logs
log="data/fs131/isf1/probes/logs/$tag.log"
if [ -n "$o" ]; then
  mkdir -p "$(dirname "$o")"
  /usr/bin/time -v lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o "$o" "$f" > "$log" 2>&1
else
  /usr/bin/time -v lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$f" > "$log" 2>&1
fi
echo "exit=$?" >> "$log"
grep -E "Elapsed|Maximum resident|^exit=" "$log"
