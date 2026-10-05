#!/usr/bin/env python3
"""FS131-IC5 (from FS131-IC4's tool, its own block): append `#print axioms` records to scripts/Axioms.lean for every theorem of `Plane/ValidMap/Contact` (wave 4's
`Contact`, worked on branch `fs131-w4c`) that the file lacks. Namespaces are tracked from `namespace`/`end` lines. Idempotent; the
block is headed "FS131-IC5" and inserted right before the `=== PURCHASED ===` banner that ends the audit's clean section.
`--dry` lists what is missing and writes nothing; `--check` exits 1 if any record is missing (printing each); `--plant` pretends every
name is missing (with `--check`: the negative control, must exit 1)."""
import sys, re, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[1]
AX = ROOT / "scripts/Axioms.lean"
MODS = ["Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean"]
ax = AX.read_text()
names = []
for mod in MODS:
    ns = []
    for line in (ROOT / mod).read_text().split("\n"):
        mo = re.match(r"namespace (\S+)", line)
        if mo: ns.append(mo.group(1)); continue
        mo = re.match(r"end (\S+)", line)
        if mo and ns and ns[-1] == mo.group(1): ns.pop(); continue
        mo = re.match(r"(?:private )?theorem (\S+)", line)
        if mo: names.append(mo.group(1)[len("_root_."):] if mo.group(1).startswith("_root_.") else ".".join(ns + [mo.group(1)]))
if not names:
    print("NO NAMES PARSED — the parser read nothing; refusing to report a clean check"); sys.exit(2)
missing = [n for n in names if (f"#print axioms {n}\n" not in ax) or "--plant" in sys.argv]
print(f"{len(names)} names, {len(missing)} missing")
if "--check" in sys.argv:
    for n in missing: print("MISSING", n)
    sys.exit(1 if missing else 0)
if "--dry" in sys.argv or not missing:
    for n in missing: print("MISSING", n)
    sys.exit(0)
hdr = "/-! ## FS-131 wave 4, `Contact` (job FS131-IC5) — the fifth implementer's added children and proved leaves -/\n\n"
if hdr in ax:
    pos = ax.index(hdr) + len(hdr)
    ax = ax[:pos] + "".join(f"#print axioms {n}\n" for n in missing) + ax[pos:]
else:
    nxt = ax.index('\n#eval IO.println "=== PURCHASED ==="')
    ax = ax[:nxt] + "\n" + hdr + "".join(f"#print axioms {n}\n" for n in missing) + ax[nxt:]
AX.write_text(ax)
print(f"wrote {len(missing)} records")
