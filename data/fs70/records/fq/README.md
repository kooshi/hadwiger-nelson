# The residue planes at the split primes — `fq-planes.json`

`fq-planes.json` holds, per prime power `q`, the plane `UD(𝔽_q²)`'s size, degree, circle, pinned clique, and one
row per colour count: the verdict, the seconds, the **sha256 of the exact DIMACS file that produced it**, and,
for a SAT verdict, whether the model was re-verified proper on every edge from the definition.

The DIMACS files themselves are not kept (the repository ignores `*.cnf`, and `q = 49` alone is 25 MB); the whole
run regenerates, byte for byte, in about one second. To re-derive and check a sha:

```
python3 tools/fs70_fq_plane.py run 9 25 49 5 --kmax 4 --budget 600 --out build/fs70/fq
sha256sum build/fs70/fq/q49/k4.cnf          # against fq-planes.json's "sha256" for q = 49, k = 4
```

The controls that make the verdicts evidence rather than noise: `k = 2` is refused at every `q` (so the encoding
can refuse at all), every SAT model is checked edge by edge (so a SAT verdict is never the exit code's word), and
`tools/fs70_fq_plane.py selftest` plants a fault in the circle enumeration and watches it fire.
