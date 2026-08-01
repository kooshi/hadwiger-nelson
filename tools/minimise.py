#!/usr/bin/env python3
"""Shrink a graph while it keeps a **port property** — not merely while it stays uncolourable.

UNTRUSTED. Every graph this proposes is re-certified in Lean from scratch: the geometry against exact
field arithmetic, each refuted pattern against a fresh certificate. A bug here can only cost a
theorem, never buy one.

## Why this is not `shrink.py`

`tools/shrink.py` shrinks against *one* UNSAT claim, which is what a whole-graph refutation is. A
**gadget** is a subgraph plus a tuple of ports plus a *set* of colour patterns it refutes, and the
property to preserve is the conjunction: every pattern that was impossible must stay impossible.
Shrink against one of them and the others quietly come back — which is a smaller graph that is a
different gadget.

So the property here is a list, the deletion sweep re-checks all of it, and a vertex is deletable
only if **no** pattern became achievable. The machinery underneath — the delta-debugging sweep, the
induced subgraph, the compaction — is `shrink.py`'s, imported rather than copied.

A smaller gadget is worth two things at once: a cheaper certificate, and a cheaper placement.

    # profile first, then shrink against everything the profile refuted
    python3 tools/profile.py --graph tools/spindle.json --ports 0 2 5 --colours 4 --out p.json
    python3 tools/minimise.py --profile p.json --out small.json
"""

from __future__ import annotations

import argparse
import json
import sys
from multiprocessing import Pool
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from shrink import compact, induced, refutes  # noqa: E402


def keeps_property(keep: set[int], edges, ports: list[int], patterns: list[list[int]],
                   k: int, timeout: float | None) -> bool:
    """Does the induced subgraph still refute **every** listed pattern?

    A solver that gives up counts as *not* refuting, so an unfinished search can only make this tool
    keep a vertex it might have deleted. The failure direction is the safe one, and it is the one
    that matters: the alternative — treating a timeout as a refutation — would hand back a graph that
    is not the gadget it claims to be.
    """
    for pat in patterns:
        pins = list(zip(ports, pat))
        m, e, p, _ = compact(keep, edges, pins)
        if refutes(m, e, p, timeout=timeout, k=k) is not True:
            return False
    return True


_STATE: dict = {}


def _init(keep, edges, ports, patterns, k, timeout) -> None:
    _STATE.update(keep=keep, edges=edges, ports=ports, patterns=patterns, k=k, timeout=timeout)


def _probe(v: int) -> tuple[int, bool]:
    return v, keeps_property(_STATE["keep"] - {v}, _STATE["edges"], _STATE["ports"],
                             _STATE["patterns"], _STATE["k"], _STATE["timeout"])


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--profile", type=Path, required=True,
                    help="output of tools/profile.py — the graph, the ports, and what they refute")
    ap.add_argument("--jobs", type=int, default=8)
    ap.add_argument("--rounds", type=int, default=20)
    ap.add_argument("--timeout", type=float, default=None)
    ap.add_argument("--out", type=Path)
    args = ap.parse_args()

    d = json.load(open(args.profile))
    edges = [(int(a), int(b)) for a, b in d["edges"]]
    ports, k = list(d["ports"]), int(d["colours"])
    patterns = [r["pattern"] for r in d["profile"] if r["status"] == "unsat"]
    stuck = [r for r in d["profile"] if r["status"] == "timeout"]
    if stuck:
        sys.exit(f"the profile has {len(stuck)} unresolved patterns; re-run tools/profile.py with a "
                 "larger --timeout. Shrinking against a property that was never established would "
                 "produce a graph whose gadget nobody has checked")
    if not patterns:
        sys.exit("the profile refutes nothing, so there is no property to preserve")

    keep = {v for e in edges for v in e} | set(ports)
    if not keeps_property(keep, edges, ports, patterns, k, args.timeout):
        sys.exit("the handed-in graph does not have the property the profile claims; nothing to do")
    print(f"start          {len(keep)} vertices, {len(induced(edges, keep))} edges, "
          f"{len(patterns)} refuted patterns at {k} colours", flush=True)

    for rnd in range(1, args.rounds + 1):
        cands = sorted(keep - set(ports))
        got = []
        with Pool(args.jobs, initializer=_init,
                  initargs=(set(keep), edges, ports, patterns, k, args.timeout)) as pool:
            for v, ok in pool.imap_unordered(_probe, cands, chunksize=1):
                if ok:
                    got.append(v)
        # Deletions interact — two vertices each individually removable need not be removable
        # together — so the sweep is parallel and the application is one at a time with a re-check.
        applied = 0
        for v in got:
            if keeps_property(keep - {v}, edges, ports, patterns, k, args.timeout):
                keep.discard(v)
                applied += 1
        print(f"round {rnd:>3}      swept {len(cands)}, deletable {len(got)}, applied {applied}"
              f"  ->  {len(keep)} vertices, {len(induced(edges, keep))} edges", flush=True)
        if args.out:
            json.dump({"keep": sorted(keep), "edges": induced(edges, keep),
                       "ports": ports, "colours": k, "patterns": patterns}, open(args.out, "w"))
        if applied == 0:
            print("fixed point     no single vertex can be removed")
            break


if __name__ == "__main__":
    main()
