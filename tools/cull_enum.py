#!/usr/bin/env python3
"""cull_enum — the cull by ENUMERATION, one batch (M52 D1′: the exact-within-batch CONTROL; the
campaign's workhorse is the Rust culler, WO-14).

    python3 tools/cull_enum.py --object <label> --classes <classes.jsonl from descent enumerate> [--cap 3600]
    python3 tools/cull_enum.py --self-test

The claim (M52 §Bʺ): for a batch B of standing cheats and the enumerator's EXACT class list S(B)
(separating colourings of the object with B absent, projected to the seed block), a subset K ⊆ B
keeps the object forcing iff every class violates some cheat of K, where a class violates a cheat
when it colours both endpoints alike. So the exact optimal kept subset of B is a MINIMUM hitting
set over the classes' violated sets. Steps: (1) read the list and REFUSE it unless its header says
the enumeration is complete (`claim` exact — a capped list would make K too small, and the certify
would catch it, but a wasted refutation is still a waste); (2) the violated set per class, deduped
(distinct masks are few); (3) a minimum hitting set by MILP (scipy), or greedy when the MILP is
unavailable, then a numpy RE-SCAN of every class against K (never trust the optimizer);
(4) per kept cheat e, the witness class s with V(s) ∩ K = {e} (exists for an inclusion-minimal K;
e is individually necessary forever); (5) the certify ask: unit ∪ (standing ∖ (B ∖ K)) forces at
five colours, one-hot at the cap — SAT = REFUSED (the list was incomplete; investigate), unknown =
held. Output: a row per batch in `build/m52-cull-<label>.jsonl` with B, K, dropped, witnesses, the
verdict, fingerprints; and the headline with its population in one sentence. Nothing is written to
the object file — the composition's kept set is the milestone's reading, and any commit goes
through the certify path. UNTRUSTED like all of tools/."""
from __future__ import annotations
import argparse, json, sys, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import numpy as np
import batchkill as B
import coloring, forcer, rigidity
import twodist as T

K5 = 5


def read_classes(path):
    lines = Path(path).read_text().splitlines()
    head = json.loads(lines[0]); assert head.get("kind") == "enumeration-header", "not a class list"
    body = [json.loads(l) for l in lines[1:]]
    body = [s for s in body if isinstance(s, str)]
    return head, body


def hitting_set(masks, ncols):
    """masks: list of frozensets of cheat indices (each nonempty). Minimum hitting set by MILP,
    greedy fallback; returns (K, method)."""
    try:
        from scipy.optimize import milp, LinearConstraint, Bounds
        A = np.zeros((len(masks), ncols));
        for r, m in enumerate(masks):
            for j in m: A[r, j] = 1
        res = milp(c=np.ones(ncols), constraints=LinearConstraint(A, lb=np.ones(len(masks))),
                   integrality=np.ones(ncols), bounds=Bounds(0, 1))
        if res.success:
            return sorted(int(j) for j in range(ncols) if res.x[j] > 0.5), "milp"
    except Exception as e:  # noqa: BLE001
        print(f"[cull] MILP unavailable ({e}); greedy", flush=True)
    K = []; left = list(masks)
    while left:
        cnt = np.zeros(ncols)
        for m in left:
            for j in m: cnt[j] += 1
        j = int(cnt.argmax()); K.append(j); left = [m for m in left if j not in m]
    # make greedy inclusion-minimal
    for j in list(K):
        if all(any(x in m for x in K if x != j) for m in masks): K.remove(j)
    return sorted(K), "greedy"


def certify(obj, standing_after, cap):
    n = obj.n; ue = obj.unit_edges()
    cls = coloring.base_clauses(n, ue, K5) + rigidity.amo_clauses(n, K5) + T._brk_full(n, K5, T._degree_order(n, ue))
    cls += [[-coloring.var(obj.A, c, K5), -coloring.var(obj.B, c, K5)] for c in range(K5)]
    for u, v in standing_after:
        cls += [[-coloring.var(u, c, K5), -coloring.var(v, c, K5)] for c in range(K5)]
    t0 = time.time(); st, _ = forcer._solve(cls, n * K5, cap)
    return st, round(time.time() - t0, 1)


def run(label, classes_path, cap, out=None):
    t0 = time.time()
    obj, removed = B.load_object(label)
    standing = [tuple(e) for e in obj.cheats if tuple(e) not in set(map(tuple, removed))]
    head, body = read_classes(classes_path)
    batch = [tuple(e) for e in head["batch"] if tuple(e) in set(standing)]     # the NEW cheats this list spends
    assert batch, "the list's batch holds no standing cheat of this object"
    complete = head.get("claim") in ("exact", "complete") or head.get("complete") is True
    if not complete:
        raise SystemExit(f"[cull {label}] REFUSED: the class list is not EXACT (claim {head.get('claim')!r}) — a capped list would make the kept set too small; shrink the batch or raise the budget. Nothing dropped.")
    masks = []
    for s in body:
        v = frozenset(j for j, (a, b) in enumerate(batch) if s[a] == s[b])
        assert v, f"a class violates NO cheat of the batch — it would be a separating colouring of the object with all of B present; the list does not belong to this stage"
        masks.append(v)
    distinct = sorted(set(masks), key=lambda m: (len(m), sorted(m)))
    K, method = hitting_set(distinct, len(batch))
    assert all(any(j in m for j in K) for m in masks), "re-scan FAILED: the hitting set misses a class"
    dropped = [batch[j] for j in range(len(batch)) if j not in K]; kept = [batch[j] for j in K]
    witnesses = {}
    for j in K:
        w = next((i for i, m in enumerate(masks) if m & set(K) == {j}), None)
        witnesses[f"{batch[j][0]}-{batch[j][1]}"] = w
    standing_after = [e for e in standing if e not in set(dropped)]
    st, secs = certify(obj, standing_after, cap)
    verdict = {"unsat": "DROPPED", "sat": "REFUSED", "unknown": "HELD"}[st]
    row = dict(kind="cull-enum-batch", label=label, classes=classes_path, stage_fingerprint=head.get("stage_fingerprint"),
               batch=[list(e) for e in batch], classes_n=len(body), distinct_masks=len(distinct), kept=[list(e) for e in kept],
               dropped=[list(e) for e in dropped], method=method, witnesses=witnesses, certify=dict(outcome=st, secs=secs, cap=cap),
               verdict=verdict, standing_before=len(standing), standing_after=len(standing_after) if st == "unsat" else len(standing),
               seconds=round(time.time() - t0, 1))
    outp = Path(out) if out else (B.BUILD / f"m52-cull-{label}.jsonl")
    with outp.open("a") as f: f.write(json.dumps(row) + "\n")
    print(f"[cull {label}] batch B = {len(batch)} | S = {len(body)} classes (EXACT) | {len(distinct)} distinct violated-sets | "
          f"K = {len(K)} ({method}; re-scan OK; every kept cheat witnessed: {all(w is not None for w in witnesses.values())}) | "
          f"dropped {len(dropped)} | certify {st.upper()} {secs}s → {verdict}: standing {len(standing)} → {row['standing_after']}", flush=True)
    if st == "sat":
        print(f"[cull {label}] REFUSED: the kept set admits a separating colouring — the list was incomplete for stage {head.get('stage_fingerprint')}; nothing committed; INVESTIGATE, never retry", flush=True)
    return row


def self_test():
    """A planted list on the bare seed: three synthetic classes over a 4-cheat batch whose minimum
    hitting set is known (size 2), and a class violating nothing must be refused."""
    obj = B.Obj()
    standing = [tuple(e) for e in obj.cheats]
    batch = []; used = set()
    for e in standing:                                   # four pairwise vertex-disjoint cheats
        if e[0] not in used and e[1] not in used:
            batch.append(e); used |= set(e)
        if len(batch) == 4: break
    def line(pairs_equal):
        s = ["0"] * 214
        c = 1
        for (a, b) in pairs_equal:
            s[a] = s[b] = str(c); c = c % 4 + 1
        return "".join(s)
    body = [line([batch[0]]), line([batch[1], batch[2]]), line([batch[2], batch[3]])]
    masks = [frozenset(j for j, (a, b) in enumerate(batch) if s[a] == s[b]) for s in body]
    assert masks[0] >= {0} and 1 in masks[1] and 2 in masks[1] and 2 in masks[2]
    K, m = hitting_set(sorted(set(masks), key=len), 4)
    assert len(K) == 2 and 0 in K, ("planted minimum hitting set is {0, 2}", K)
    print(f"[self-test] green: planted hitting set {K} by {m}")
    bad = "0" * 214
    try:
        v = frozenset(j for j, (a, b) in enumerate(batch) if bad[a] == bad[b]); assert v
        raise SystemExit("red FAILED")
    except AssertionError:
        print("[self-test] red seen: a class violating nothing is refused")
    print("[self-test] PASS")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--object"); ap.add_argument("--classes"); ap.add_argument("--cap", type=float, default=3600.0)
    ap.add_argument("--out", default=None); ap.add_argument("--self-test", action="store_true")
    a = ap.parse_args()
    if a.self_test:
        return self_test()
    run(a.object, a.classes, a.cap, a.out)


if __name__ == "__main__":
    main()
