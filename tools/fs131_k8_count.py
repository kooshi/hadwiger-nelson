#!/usr/bin/env python3
"""FS131-K8: exact check of FS116-V6-COUNT as a finite statement (the form `v6_count` of
Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean states).

Four tiles, six hubs (Z/6). A tile's set of tipped hubs is empty, one hub, or two consecutive hubs
(V6-HUBS: 13 choices). Hypotheses: every hub has a tip (V6-TIP); no tile tips a and a+1 while being
the only tip at each (V6-HUG). Conclusion checked on every configuration meeting the hypotheses:
there is a hub a such that a and a+3 have exactly two tips each, the four tippers are the four
tiles, and every tile tips exactly two hubs.

--fault-hug drops the HUG hypothesis: the conclusion must then FAIL on some configuration
(the planted fault; exit status 1 with the count of counterexamples)."""
import itertools, sys

def main():
    drop_hug = "--fault-hug" in sys.argv
    opts = [frozenset()] + [frozenset({a}) for a in range(6)] + [frozenset({a, (a + 1) % 6}) for a in range(6)]
    models, bad = 0, 0
    for cfg in itertools.product(opts, repeat=4):
        tips = {a: [i for i in range(4) if a in cfg[i]] for a in range(6)}
        if any(len(tips[a]) == 0 for a in range(6)):
            continue
        if not drop_hug:
            hug = any(a in cfg[i] and (a + 1) % 6 in cfg[i] and tips[a] == [i] and tips[(a + 1) % 6] == [i]
                      for i in range(4) for a in range(6))
            if hug:
                continue
        models += 1
        ok = any(len(tips[a]) == 2 and len(tips[(a + 3) % 6]) == 2
                 and set(tips[a]) | set(tips[(a + 3) % 6]) == {0, 1, 2, 3}
                 and all(len(c) == 2 for c in cfg) for a in range(6))
        if not ok:
            bad += 1
    print(f"configurations meeting the hypotheses: {models}; violating the conclusion: {bad}")
    return 1 if bad else 0

if __name__ == "__main__":
    sys.exit(main())
