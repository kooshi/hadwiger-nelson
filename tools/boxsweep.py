"""Parallel box sweep for the type-M descent (M62 §R21).

Plain subprocess fan-out -- no pool, no queue, no epoll -- because this project has one recorded
multiprocessing wedge (the parent asleep in do_epoll_wait for 96 minutes, `plans/RISKS.md`) and five
self-inflicted process kills. A worker prints one line and exits; the parent reads it and kills the
rest on the first survivor. There is nothing here that can wedge.

MEASURED 2026-09-10, 18,408 boxes on the S side of the Parts-lattice arena, while another job held a
core: sequential 116 s, parallel 28 s on 28 workers -- **4.1x, not 28x**, and the reason is worth
recording: the sequential sweep reuses ONE incremental solver across every box, so its learned
clauses accumulate (6.3 ms/box), while each worker starts cold (13 ms/box). Load and bootstrap are
free (0.05 s together). So the achievable speedup is capped near half the core count, and memory
bandwidth takes the rest.

Validated red/green against the sequential answer on both branches -- a case that blocks every box
and a case with a survivor -- before being used for any verdict.
"""
import os, sys, pickle, time, subprocess, tempfile

WORKER = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'boxsweep_worker.py')

def blocks_par(cnf, boxes, workers=28, tag="", log=None, chunk_min=200):
    """True iff every box's assumptions are UNSAT under `cnf`. Fans out over processes."""
    n = len(boxes)
    if n == 0: return True
    w = max(1, min(workers, (n + chunk_min - 1)//chunk_min))
    st = time.time()
    d = tempfile.mkdtemp(prefix='bs', dir=os.environ.get('BOXSWEEP_TMP','/tmp'))
    cp, bp = os.path.join(d,'cnf.pkl'), os.path.join(d,'boxes.pkl')
    pickle.dump(cnf, open(cp,'wb'), protocol=5)
    pickle.dump(boxes, open(bp,'wb'), protocol=5)
    step = (n + w - 1)//w
    procs = []
    try:
        for k in range(w):
            lo, hi = k*step, min((k+1)*step, n)
            if lo >= hi: break
            procs.append(subprocess.Popen([sys.executable, WORKER, cp, bp, str(lo), str(hi)],
                                          stdout=subprocess.PIPE, text=True))
        done = 0; blocked = 0
        while done < len(procs):
            time.sleep(0.05)
            for p in procs:
                if p.poll() is None or getattr(p,'_seen',False): continue
                p._seen = True; done += 1
                out = (p.stdout.read() or '').strip()
                if out.startswith('SURVIVOR'):
                    if log: log(f"      {tag}: survivor at box {out.split()[1]} of {n} "
                                f"[{time.time()-st:.0f}s, {w} workers]")
                    return False
                if out.startswith('BLOCKED'):
                    blocked += int(out.split()[1])
                else:
                    raise RuntimeError(f"box-sweep worker failed: rc={p.returncode} out={out!r}")
        if blocked != n:
            raise RuntimeError(f"box-sweep accounting: {blocked} of {n} boxes reported")
        if log: log(f"      {tag}: blocks all {n} boxes [{time.time()-st:.0f}s, {w} workers]")
        return True
    finally:
        for p in procs:
            if p.poll() is None:
                p.kill()
        for p in procs:
            try: p.wait(timeout=10)
            except Exception: pass
        for f in (cp,bp):
            try: os.unlink(f)
            except OSError: pass
        try: os.rmdir(d)
        except OSError: pass
