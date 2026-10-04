#!/usr/bin/env python3
"""FS131-I4: append `#print axioms` records to scripts/Axioms.lean for every theorem of wave 4's five skeleton modules
(`fs131_k4_decls.py`) and of the foundation `Plane/ValidMap/Basic` that the file lacks. Idempotent; the block is headed with the
job tag and inserted right before the `=== PURCHASED ===` banner that ends the audit's clean section.
`--dry` lists what is missing and writes nothing; `--plant` pretends every name is missing (use with `--dry`)."""
import subprocess, sys, re, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[1]
ax = (ROOT / "scripts/Axioms.lean").read_text()
out = subprocess.run(["python3", "tools/fs131_k4_decls.py"], capture_output=True, text=True, check=True, cwd=ROOT).stdout.split("\n")
names = [l[len("#print axioms "):] for l in out if l.startswith("#print axioms ")]
# Basic's theorems (namespace-tracked by hand: `ArcMap.` for those inside `namespace ArcMap`)
ns, basic = [], []
for line in (ROOT / "Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean").read_text().split("\n"):
    mo = re.match(r"namespace (\S+)", line)
    if mo: ns.append(mo.group(1)); continue
    mo = re.match(r"end (\S+)", line)
    if mo and ns and ns[-1] == mo.group(1): ns.pop(); continue
    mo = re.match(r"theorem (\S+)", line)
    if mo: basic.append(".".join([n for n in ns if n != "HadwigerNelson.Plane"] + [mo.group(1)]).replace("HadwigerNelson.Plane.", ""))
names += ["HadwigerNelson.Plane." + n if not n.startswith("HadwigerNelson.") else n for n in basic]
missing = [n for n in names if (f"#print axioms {n}\n" not in ax) or "--plant" in sys.argv]
print(f"{len(names)} names, {len(missing)} missing")
if "--dry" in sys.argv or not missing: sys.exit(0)
hdr = "/-! ## FS-131 wave 4 (job FS131-I4) — the implementer's added children and proved leaves -/\n\n"
nxt = ax.index('\n#eval IO.println "=== PURCHASED ==="')
if hdr in ax:
    pos = ax.index(hdr) + len(hdr)
    ax = ax[:pos] + "".join(f"#print axioms {n}\n" for n in missing) + ax[pos:]
else:
    ax = ax[:nxt] + "\n" + hdr + "".join(f"#print axioms {n}\n" for n in missing) + ax[nxt:]
(ROOT / "scripts/Axioms.lean").write_text(ax)
