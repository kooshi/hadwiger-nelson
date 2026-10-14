#!/usr/bin/env python3
"""FS131-KN9: the coordinator's ruling of 2026-10-14 applied to Rigidity/PositiveEntropy.lean — the binder [PolishSpace X]
of haar_or_zero_entropy removed, its docstring paragraph rewritten. Exits 1 unless each anchor occurs exactly once."""
import sys
p = sys.argv[1]
s = open(p).read()
edits = [
("""theorem haar_or_zero_entropy {X : Type*} [AddCommGroup X] [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X]
    [PolishSpace X] (hX : IsSolenoid X) {d : ℕ}""",
"""theorem haar_or_zero_entropy {X : Type*} [AddCommGroup X] [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X]
    (hX : IsSolenoid X) {d : ℕ}"""),
("""step 0 by FS105-NVC, the declared theorem in its Polish form, step 1 inline,""",
 """step 0 by FS105-NVC, the declared theorem as stated, step 1 inline,"""),
]
for old, new in edits:
    if s.count(old) != 1:
        print("FAIL anchor count", s.count(old), repr(old[:60])); sys.exit(1)
    s = s.replace(old, new)
i = s.index("**`[PolishSpace X]`** (FS131-KN8, on the coordinator's standing word")
j = s.index("**Its proof's children**")
s = s[:i] + """**No `PolishSpace`** (FS131-KN9, the coordinator's ruling of 2026-10-14; the binder FS131-KN8 added is gone): the
finite-fibred step holds over the Borel σ-algebra of `X ⧸ G j` that clause (4) of the declared theorem states, for every
compact T1 group (`Rigidity.ksEntropy_eq_zero_iff_of_finite`: the projection is an open embedding on each translate of a
small open set, so no Lusin–Souslin is read), and Haar uniqueness asks local compactness only. So the proof reads
`positive_entropy_rigidity` as declared.

""" + s[j:]
open(p, "w").write(s)
print("OK")
