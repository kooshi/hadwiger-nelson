#!/usr/bin/env python3
"""FS131-IV1 — the audit block for the module's three files, and the check file that prints the same records' axioms.

Reads a dump of the three compiled modules (data/fs131/iv1/lean/StatementDump.lean's format, raw or compact) for the
kernel's list of named constants per module, and each module's source for the order in which a person typed its public
declarations; writes

  data/fs131/iv1/audit-block.txt   — the block for `scripts/Axioms.lean` (one `#print axioms` per public declaration)
  data/fs131/iv1/lean/Axioms.lean  — the same lines under the module's import, run after the build

and fails if a public declaration written in a source is not exactly one named constant of its module's dump, or a
dump holds a named constant its source does not write (so the block is the kernel's list and the files' list at once).
It also compares its lists for `Arith/UpperHalf` and `Arith/QuadraticPrime` with the two implementers' own blocks
(data/fs131/iu1/audit-block.txt, data/fs131/iq1/audit-block.lean): the same names in the same order, or it fails.
Usage: make_audit.py <dump.txt>
"""
import re, sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
MODS = [  # (module, source, who proved the leaves, how many leaves)
    ("Proofs.HadwigerNelson.Arith.UpperHalf", "Proofs/HadwigerNelson/Arith/UpperHalf.lean", "FS131-IU1", "twelve"),
    ("Proofs.HadwigerNelson.Arith.QuadraticPrime", "Proofs/HadwigerNelson/Arith/QuadraticPrime.lean", "FS131-IQ1", "nine"),
    ("Proofs.HadwigerNelson.Instances.UpperHalfValues", "Proofs/HadwigerNelson/Instances/UpperHalfValues.lean", "FS131-IV1", "three"),
]
DECL = r"^(private )?(?:noncomputable )?(?:@\[[^\]]*\] )?(?:theorem|def|abbrev|instance) ([A-Za-z0-9_.]+)"

named, mod = {}, None
for ln in pathlib.Path(sys.argv[1]).read_text().splitlines():
    if ln.startswith("## MODULE "):
        mod = ln.split(" ")[2]; named[mod] = {}
    elif ln.startswith("@@ ") and not ln.endswith(" INTERNAL"):
        _, kind, name = ln.split(" ", 2)
        named[mod][name] = kind

blocks, fail, total = [], [], 0
for module, src, who, leaves in MODS:
    if module not in named:
        print(f"FAIL: the dump holds no section for {module}"); sys.exit(1)
    text = re.sub(r"/-.*?-/", "", (ROOT / src).read_text(), flags=re.S)
    written = re.findall(DECL, text, flags=re.M)
    public = [w.removeprefix("_root_.") for priv, w in written if not priv]
    private = [w for priv, w in written if priv]
    order = []
    for w in public:
        cands = [n for n in named[module] if n == w or n.endswith("." + w)]
        if len(cands) != 1:
            fail.append(f"{src}: written `{w}` matches {len(cands)} named constants of the dump: {cands}"); continue
        order.append(cands[0])
    extra = sorted(set(named[module]) - set(order))
    if extra:
        fail.append(f"{src}: named in the dump but not written: {extra}")
    nthm = sum(named[module][n] == "THM" for n in order); ndef = sum(named[module][n] == "DEF" for n in order)
    short = src.removeprefix("Proofs/HadwigerNelson/").removesuffix(".lean")
    blocks.append((short, who, leaves, order, nthm, ndef, private))
    total += len(order)

# the two implementers' own blocks: the same names, the same order
def listed(path):
    return re.findall(r"^#print axioms (\S+)", (ROOT / path).read_text(), flags=re.M)
theirs = {"Arith/UpperHalf": listed("data/fs131/iu1/audit-block.txt"),
          "Arith/QuadraticPrime": ["HadwigerNelson." + n for n in listed("data/fs131/iq1/audit-block.lean")]}
for short, who, leaves, order, *_ in blocks:
    if short in theirs and theirs[short] != order:
        fail.append(f"{short}: this list differs from {who}'s own block ({len(order)} here, {len(theirs[short])} there)")
if fail:
    print("FAIL:"); [print("  " + f) for f in fail]; sys.exit(1)

head = ("/-! ## FS131-IV1 — FS-131, NF1: the residue upper half and the values it closes (statements FS131-KN2's): `Arith/UpperHalf`\n"
        "(leaves FS131-IU1's), `Arith/QuadraticPrime` (leaves FS131-IQ1's), `Instances/UpperHalfValues` (leaves FS131-IV1's).\n"
        f"{total} records: every public declaration a person typed in the three files, in each file's order — the kernel's list\n"
        "(data/fs131/iv1/statements-after.txt) through data/fs131/iv1/make_audit.py.  The files' private helpers (6, 8 and 2) are\n"
        "not nameable here; each is read by a record below.  Every record CLEAN: none of the three modules reads a declared\n"
        "outside theorem, and no theorem of them takes a declared hypothesis but `chromaticNumber_eq_localBound_of_chain`\n"
        "(the chain's headline with `hUpper` discharged; its other hypotheses are the assumptions step's). -/\n")
body = ""
for short, who, leaves, order, nthm, ndef, private in blocks:
    kinds = f"{nthm} theorems" + (f", {ndef} definitions" if ndef else "")
    body += f"-- FS131-IV1: {short} ({len(order)}: {kinds}; the {leaves} leaves' proofs {who}'s)\n"
    body += "".join(f"#print axioms {n}\n" for n in order)
body += "-- FS131-IV1 block end\n"
(ROOT / "data/fs131/iv1/audit-block.txt").write_text(head + body)
(ROOT / "data/fs131/iv1/lean/Axioms.lean").write_text(
    "import Proofs.HadwigerNelson.Instances.UpperHalfValues\n"
    "/-! FS131-IV1 — the axioms of every public declaration of `Arith/UpperHalf`, `Arith/QuadraticPrime` and\n"
    "`Instances/UpperHalfValues`, from the compiled modules (run after the build):\n"
    "`data/fs131/iv1/lean1.sh data/fs131/iv1/lean/Axioms.lean`. Generated by `data/fs131/iv1/make_audit.py`. -/\n"
    "set_option pp.fullNames true\n" + "".join(l + "\n" for l in body.splitlines() if l.startswith("#print")))
for short, who, leaves, order, nthm, ndef, private in blocks:
    print(f"{short}: {len(order)} records ({nthm} theorems, {ndef} definitions); private helpers in the source: {len(private)}: {private}")
print(f"wrote {total} records; the lists for Arith/UpperHalf and Arith/QuadraticPrime are the two implementers' own, name for name")
