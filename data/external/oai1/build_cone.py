#!/usr/bin/env python3
"""EXT-OAI1 stage 4: build the cone of a module in the working copy, in dependency order, W modules at a time.

usage (inside a slot, from the working copy, with env.sh sourced):
    build_cone.py <cone.json> <W> <log>
Each batch is one `lake build <modules>` whose dependencies are already built, so Lake starts at most W Lean
processes.  CHECKPOINT: Lake's own artifacts (.lake/build/lib/lean/**/*.olean); a module whose olean exists and is
up to date is replayed in seconds.  RESUME: run the same command again.  Stops at the first failing batch, exit 1,
with the batch's full output in <log>.
"""
import json, subprocess, sys, time
cone = json.load(open(sys.argv[1])); W = int(sys.argv[2]); log = open(sys.argv[3], 'a')
deps = {m: [i for i in v['imports'] if i in cone['inside']] for m, v in cone['inside'].items()}
done, order = set(), []
def say(s):
    print(s, flush=True); log.write(s + '\n'); log.flush()
say(f"== build_cone start {time.strftime('%F %T')} modules={len(deps)} W={W}")
t0 = time.time(); k = 0
while len(done) < len(deps):
    ready = sorted(m for m in deps if m not in done and all(d in done for d in deps[m]))
    assert ready, "cycle"
    batch = ready[:W]; k += 1
    t = time.time()
    r = subprocess.run(['lake', 'build', *batch], capture_output=True, text=True)
    dt = time.time() - t
    say(f"-- batch {k}: {' '.join(batch)}  exit={r.returncode}  {dt:.0f}s  (built {len(done) + len(batch)}/{len(deps)}, total {time.time() - t0:.0f}s)")
    out = (r.stdout + r.stderr)
    for line in out.splitlines():
        if line.startswith(('✔', '✖', '⚠', 'error', 'warning')) or 'error' in line: log.write('   ' + line + '\n')
    log.flush()
    if r.returncode != 0:
        log.write('==== FAILING BATCH, FULL OUTPUT ====\n' + out + '\n'); log.flush()
        say(f"== build_cone FAILED at batch {k} {time.strftime('%F %T')}"); sys.exit(1)
    done.update(batch)
say(f"== build_cone DONE {time.strftime('%F %T')} modules={len(done)} total={time.time() - t0:.0f}s exit=0")
