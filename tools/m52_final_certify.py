#!/usr/bin/env python3
"""m52_final_certify — the culled standing set re-refuted in TWO encodings (M52 phase 4's close).

    python3 tools/m52_final_certify.py --object <label> [--cap 14400]

Reads the cull loop's state (`build/m52-cull-<label>.state.json`: dropped, kept, held, batches),
forms the culled standing set = the object's standing cheats minus every dropped one, and asks
"unit ∪ standing ∪ {A ≠ B} at five colours" twice: one-hot with degree-order palette breaking (the
loop's own certify, re-run here from scratch) and the campaign's independent 3-bit re-encode
(`rigidity.reencode_confirm`, the certify's second half). Both UNSAT = the culled set FORCES the
pair — the object's dial reading, `standing_before → standing_after`, is then a certified upper
bound on μ for this object. A SAT anywhere is a REFUSAL (investigate, never retry); an unknown is
reported as unknown. Writes `data/m52/final-certify-<label>.json`. UNTRUSTED like all of tools/;
the kernel certificate of any object is a separate milestone."""
from __future__ import annotations
import argparse, json, sys, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import batchkill as B
import coloring, forcer, rigidity
import twodist as T

K = 5
OUT = Path(__file__).resolve().parent.parent / "data" / "m52"


def onehot(obj, standing, cap):
    n = obj.n; ue = obj.unit_edges()
    cls = coloring.base_clauses(n, ue, K) + rigidity.amo_clauses(n, K) + T._brk_full(n, K, T._degree_order(n, ue))
    cls += [[-coloring.var(obj.A, c, K), -coloring.var(obj.B, c, K)] for c in range(K)]
    for u, v in standing:
        cls += [[-coloring.var(u, c, K), -coloring.var(v, c, K)] for c in range(K)]
    t0 = time.time(); st, _ = forcer._solve(cls, n * K, cap)
    return st, round(time.time() - t0, 1)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--object", required=True); ap.add_argument("--cap", type=float, default=14400.0)
    a = ap.parse_args()
    t0 = time.time()
    obj, removed = B.load_object(a.object)
    standing0 = [tuple(e) for e in obj.cheats if tuple(e) not in set(map(tuple, removed))]
    st = json.loads((B.BUILD / f"m52-cull-{a.object}.state.json").read_text())
    dropped = set(tuple(e) for e in st["dropped"])
    standing = [e for e in standing0 if e not in dropped]
    print(f"[final] {a.object}: standing {len(standing0)} → {len(standing)} ({len(dropped)} dropped in {st['batches']} batches; "
          f"{len(st['kept'])} batch-kept, {len(st['held'])} held); asking both encodings at cap {a.cap}s …", flush=True)
    s1, t1 = onehot(obj, standing, a.cap)
    print(f"[final] one-hot: {s1.upper()} ({t1}s)", flush=True)
    ue = obj.unit_edges()
    r = rigidity.reencode_confirm(obj.n, ue, K, standing + [(obj.A, obj.B)], cap=a.cap)
    s2 = r["outcome"]; t2 = r.get("seconds")
    print(f"[final] 3-bit re-encode: {s2.upper()} ({t2}s)", flush=True)
    verdict = "CERTIFIED" if (s1, s2) == ("unsat", "unsat") else ("REFUSED" if "sat" in (s1, s2) else "UNKNOWN")
    row = dict(kind="m52-final-certify", label=a.object, fingerprint=obj.fingerprint(removed), standing_before=len(standing0),
               standing_after=len(standing), dropped=sorted(list(e) for e in dropped), kept_batch=st["kept"], held=st["held"],
               floor_never_batched=27, onehot=dict(outcome=s1, secs=t1), reencode=dict(outcome=s2, secs=t2), cap=a.cap,
               verdict=verdict, seconds=round(time.time() - t0, 1),
               claim_scope="the culled standing set forces A = B at five colours iff both encodings are UNSAT; a cap is not a verdict")
    OUT.mkdir(parents=True, exist_ok=True)
    (OUT / f"final-certify-{a.object}.json").write_text(json.dumps(row, indent=1))
    print(f"[final] {verdict}: standing {len(standing0)} → {len(standing)} on {a.object} (one-hot {s1}, 3-bit {s2}) [{time.time()-t0:.0f}s]", flush=True)
    if verdict == "REFUSED":
        print("[final] REFUSED — a separating colouring exists on the culled set: INVESTIGATE (an enumeration was incomplete), never retry", flush=True)


if __name__ == "__main__":
    main()
