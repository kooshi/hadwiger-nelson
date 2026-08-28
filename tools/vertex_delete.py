#!/usr/bin/env python3
"""Compose the vertex-deletion census's candidates into a deletable SET (2026-08-28, Kooshi's
"shrink the entire graph"). Deletions compose only sequentially (context-dependence, M49), so:
(1) one ask with ALL candidates deleted — UNSAT settles it in one step; else (2) greedy sequential,
candidates ordered by the cheats they carry (desc), each accepted iff the object minus the accepted
set minus it still forces A = B (one-hot UNSAT at cap); (3) the accepted set is CONFIRMED in the
independent 3-bit encoding. Geometry is unchanged (no point is added). Checkpointed per accepted or
refused candidate to `build/m51-vdelete-{label}.jsonl`; a relaunch replays the accepted set and
re-asks only the rest. The row records the deleted set, the cheats it carries (each counted once),
and the live cheat count after — the dial by DELETION. UNTRUSTED like everything in tools/."""
import sys, json, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import batchkill as B
import coloring, rigidity, forcer
import twodist as T
K = B.K

def main(label: str, cap: float = 600.0, confirm_cap: float = 7200.0):
    t0 = time.time()
    obj, removed = B.load_object(label)
    tp = [tuple(e) for e in obj.cheats if tuple(e) not in set(removed)]
    ue = obj.unit_edges()
    fp = obj.fingerprint(removed)
    ck_census = B.BUILD / f"m51-vcensus-{label}-seed.jsonl"
    cands = {}
    for line in ck_census.read_text().splitlines():
        r = json.loads(line)
        if r["object_fingerprint"] == fp and r["st"] == "unsat":
            cands[r["v"]] = r["cheats_at"]
    assert obj.A not in cands and obj.B not in cands
    order = sorted(cands, key=lambda v: (-cands[v], v))
    print(f"[vdelete] object n={obj.n} unit {len(ue)} live cheats {len(tp)}; {len(order)} candidates "
          f"(carrying {sum(cands.values())} cheats singly-counted)", flush=True)
    ne = [[-coloring.var(obj.A, c, K), -coloring.var(obj.B, c, K)] for c in range(K)]

    def edges_minus(D):
        D = set(D)
        return [e for e in ue if e[0] not in D and e[1] not in D], \
               [e for e in tp if e[0] not in D and e[1] not in D]

    def forces_without(D, cap_):
        u, c = edges_minus(D)
        edges = u + c
        cls = coloring.base_clauses(obj.n, edges, K) + rigidity.amo_clauses(obj.n, K)
        cls += T._brk_full(obj.n, K, T._degree_order(obj.n, edges)) + ne
        st, _ = forcer._solve(cls, obj.n * K, cap_)
        return st

    ckp = B.BUILD / f"m51-vdelete-{label}.jsonl"
    accepted, refused, replay = [], [], {}
    if ckp.exists():
        for line in ckp.read_text().splitlines():
            r = json.loads(line)
            if r.get("object_fingerprint") == fp:
                replay[r["v"]] = r["st"]
        print(f"[vdelete] resumed: {len(replay)} verdicts replayed", flush=True)

    def log_verdict(v, st, dt, kind):
        with ckp.open("a") as f:
            f.write(json.dumps({"v": v, "st": st, "kind": kind, "seconds": round(dt, 1),
                                "accepted_before": list(accepted), "object_fingerprint": fp}) + "\n")

    # (1) all at once
    if "ALL" not in replay:
        t1 = time.time(); st = forces_without(order, cap); dt = time.time() - t1
        log_verdict("ALL", st, dt, "all-at-once")
        print(f"[vdelete] all {len(order)} at once: {st.upper()} ({dt:.0f}s)", flush=True)
        replay["ALL"] = st
    if replay["ALL"] == "unsat":
        accepted = list(order)
    else:
        # (2) greedy sequential (replayed verdicts are only valid with the same accepted prefix —
        # the checkpoint stores it; a prefix mismatch re-asks)
        for v in order:
            t1 = time.time()
            prev = None
            for line in ckp.read_text().splitlines():
                r = json.loads(line)
                if r.get("v") == v and r.get("object_fingerprint") == fp and r.get("kind") == "greedy" \
                        and r.get("accepted_before") == accepted:
                    prev = r["st"]
            st = prev if prev is not None else forces_without(accepted + [v], cap)
            dt = time.time() - t1
            if prev is None:
                log_verdict(v, st, dt, "greedy")
            if st == "unsat":
                accepted.append(v)
            else:
                refused.append((v, st))
            print(f"[vdelete] {v} (carries {cands[v]}): {st.upper()} {'ACCEPTED' if st == 'unsat' else 'refused'} "
                  f"-> accepted {len(accepted)} ({dt:.0f}s)", flush=True)
    u, c = edges_minus(accepted)
    freed = len(tp) - len(c)
    print(f"[vdelete] deleted set {len(accepted)} vertices, cheats freed {freed}: live cheats "
          f"{len(tp)} -> {len(c)}, unit edges {len(ue)} -> {len(u)}", flush=True)
    # (3) confirm: the final one-hot at the certify cap + the 3-bit re-encode
    t1 = time.time()
    st1 = forces_without(accepted, 3600.0)
    re = rigidity.reencode_confirm(obj.n, u, K, c + [(obj.A, obj.B)], cap=confirm_cap)["outcome"] \
        if st1 == "unsat" else "not-run"
    verdict = "confirmed" if st1 == "unsat" and re == "unsat" else ("candidate" if st1 == "unsat" else "REFUSED")
    print(f"[vdelete] confirm: one-hot {st1}, 3-bit {re} -> {verdict} ({time.time()-t1:.0f}s)", flush=True)
    row = {"kind": "vertex-deletion", "label": label, "object_fingerprint": fp,
           "candidates": order, "deleted": accepted, "refused": refused,
           "all_at_once": replay["ALL"], "cheats_before": len(tp), "cheats_after": len(c),
           "cheats_freed": freed, "unit_before": len(ue), "unit_after": len(u),
           "one_hot": st1, "reencode": re, "verdict": verdict, "cap": cap,
           "seconds": round(time.time() - t0, 1), "checkpoint": ckp.name,
           "claim_scope": "the committed object minus the deleted seed vertices (all their unit "
           "edges and remaining cheats) still forces A = B: UNSAT in the one-hot encoding and in "
           "the independent 3-bit encoding, no geometry added; the live cheat count after is an "
           "upper bound on mu by deletion; the object file is NOT rewritten by this tool (the "
           "vertex-deleted object model is a separate engineering step)"}
    T.record(B.BUILD / "m50-batch.json", row)
    print(f"[vdelete] recorded ({time.time()-t0:.0f}s)", flush=True)

if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "S29-depth2r-it2v2-depth1-it2v2-depth1")
