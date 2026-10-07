#!/usr/bin/env python3
"""EXT-OAI3 — exact control of the entry `tile-colouring` in plans/EXT-OAI3-review.md.

Claim checked, on a finite set the derivation fixed: for A = Z/n (2 <= n <= N), every F in A containing 0 with
2 <= |F| <= K, and every subgroup P = dZ/n of A:
    [ Cay(A, (F - F) \\ {0}) has a proper P-invariant colouring with |F| colours ]
 == [ some P-invariant T in A has T (+) F = A ]
Both sides are decided by complete enumeration (every map A/P -> colours; every P-invariant subset T): this is a check
of a derived equivalence on small groups, not a search for anything.

--direction forward    prints the number of cases colourable and not tileable (the forward direction's failures);
--direction converse   prints the number tileable and not colourable (the converse's); with neither, all mismatches.
Expected: 0, with a positive count of cases where both sides hold.
Planted faults, one per direction:
--connection F       the connection set (F u -F) \\ {0} in place of (F - F) \\ {0}: a smaller graph, so colourings appear
                     with no tiling (the forward direction must fire);
--connection plus1   the connection set (F - F) \\ {0} with 1 and -1 added: a larger graph, so tilings remain with no
                     colouring (the converse must fire).
"""
import itertools, sys
N, K = 9, 4
conn = sys.argv[sys.argv.index("--connection") + 1] if "--connection" in sys.argv else "F-F"
direction = sys.argv[sys.argv.index("--direction") + 1] if "--direction" in sys.argv else "both"
assert conn in ("F-F", "F", "plus1") and direction in ("both", "forward", "converse")
mism = cases = both = fwd = cnv = 0
for n in range(2, N + 1):
    A = range(n)
    divisors = [d for d in range(1, n + 1) if n % d == 0]          # P = dZ/n, index d
    for k in range(2, K + 1):
        for rest in itertools.combinations(range(1, n), k - 1):
            F = (0,) + rest
            if conn == "F":
                S = {x % n for f in F for x in (f, -f)} - {0}
            else:
                S = {(f - g) % n for f in F for g in F} - {0}
                if conn == "plus1":
                    S |= {1 % n, (-1) % n}; S -= {0}
            for d in divisors:
                # P-invariant maps are functions of x mod d
                col = False
                for c in itertools.product(range(k), repeat=d):
                    if all(c[x % d] != c[(x + s) % d] for x in range(n) for s in S):
                        col = True; break
                til = False
                for bits in range(1, 2 ** d):
                    T = [x for x in A if (bits >> (x % d)) & 1]
                    if len(T) * k != n: continue
                    if len({(t + f) % n for t in T for f in F}) == n:
                        til = True; break
                cases += 1
                both += col and til
                mism += col != til
                fwd += col and not til
                cnv += til and not col
tail = f"in {cases} cases (n <= {N}, |F| <= {K}); both in {both}"
if direction == "forward": print(f"{fwd} colourable and not tileable {tail}")
elif direction == "converse": print(f"{cnv} tileable and not colourable {tail}")
else: print(f"{mism} mismatches {tail}")
