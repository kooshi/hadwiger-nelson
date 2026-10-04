#!/usr/bin/env python3
"""FS131-I3c: append `#print axioms` records for every wave-3 declaration `fs131_k3b_decls.py` lists that scripts/Axioms.lean lacks.

Inserted as one block headed with the job tag, right before the `=== PURCHASED ===` banner that ends the audit's clean section. Idempotent. Plant: `--plant`
pretends every name is missing (and the run must then report them) — use with `--dry`."""
import subprocess, sys, re
ax = open("scripts/Axioms.lean").read()
names = subprocess.run(["python3", "tools/fs131_k3b_decls.py"], capture_output=True, text=True, check=True).stdout.split("\n")
names = [l[len("#print axioms "):] for l in names if l.startswith("#print axioms ")]
missing = [n for n in names if (f"#print axioms {n}\n" not in ax) or "--plant" in sys.argv]
print(f"{len(names)} names, {len(missing)} missing")
if "--dry" in sys.argv or not missing: sys.exit(0)
hdr = "/-! ## FS-131 wave 3 (job FS131-I3c) — the implementer's added children and the rows' leaves -/\n\n"
start = ax.index("(job FS131-I3b)")
nxt = ax.index('\n#eval IO.println "=== PURCHASED ==="', start)
if hdr in ax:
    pos = ax.index(hdr) + len(hdr)
    ax = ax[:pos] + "".join(f"#print axioms {n}\n" for n in missing) + ax[pos:]
else:
    ax = ax[:nxt] + "\n" + hdr + "".join(f"#print axioms {n}\n" for n in missing) + ax[nxt:]
open("scripts/Axioms.lean", "w").write(ax)
