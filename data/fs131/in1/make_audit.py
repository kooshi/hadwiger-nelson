#!/usr/bin/env python3
"""FS131-IN1 — the audit block for `scripts/Axioms.lean`: one `#print axioms` line per public declaration of
`Arith/ThreeColourCriterion` a person typed, in the file's order, filed CLEAN or IMPORTED.

Reads the module's SOURCE for the public declarations (theorem / def, `private` left out), a statement dump
(statement_diff.py's format) for the constants the kernel holds, and an axioms print (lean/AxiomsCore.lean) for
where each belongs.  Fails if the source writes a public declaration the dump does not hold, if the dump holds a named
constant the source does not write, or if a record has no line in the axioms print.
Usage: make_audit.py <dump.txt> <axioms-print.txt> <out.txt>
"""
import re, sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
NS = "HadwigerNelson.ThreeColourCriterion."
KLO = "HadwigerNelson.StandingFive.kloosterman_bound"
src = (ROOT / "Proofs/HadwigerNelson/Arith/ThreeColourCriterion.lean").read_text()
src = re.sub(r"/-.*?-/", "", src, flags=re.S)
written = re.findall(r"^(?:noncomputable )?(?:@\[simp\] )?(?:theorem|def|abbrev) ([A-Za-z0-9_.']+)", src, flags=re.M)
private = re.findall(r"^private (?:noncomputable )?(?:theorem|def|abbrev) ([A-Za-z0-9_.']+)", src, flags=re.M)
dump = [ln.split(" ")[2] for ln in pathlib.Path(sys.argv[1]).read_text().splitlines()
        if ln.startswith("@@ ") and not ln.endswith(" INTERNAL")]
ax = {m.group(2): m.group(3) for m in re.finditer(r"^AXIOMS (public|private) (\S+) : \[(.*)\]$", pathlib.Path(sys.argv[2]).read_text(), flags=re.M)}
full = [NS + w for w in written]
missing = [f for f in full if f not in dump]; extra = [d for d in dump if d not in full]; noax = [f for f in full if f not in ax]
if missing or extra or noax or not written:
    sys.exit(f"MISMATCH: written and not in the dump {missing}; in the dump and not written {extra}; no axioms record {noax}")
clean = [f for f in full if KLO not in ax[f]]; imp = [f for f in full if KLO in ax[f]]
out = [f"-- FS131-IN1: Arith/ThreeColourCriterion ({len(full)} public declarations a person typed: {len(full) - 1} theorems, 1 definition; in the",
       f"-- file's order; the {len(private)} private helpers are not nameable here, and each is read by a record below).",
       f"-- Statements FS131-KN4's and FS131-KN5's, three of them widened by ruling (FS131-IN1, Amendments 1 and 2); the proofs FS131-IN1's.",
       f"-- CLEAN ({len(clean)}): for the landing's CLEAN block."]
out += [f"#print axioms {f}" for f in clean]
out += [f"-- IMPORTED ({len(imp)}): for the IMPORTED section, under `declareImport ``{KLO}` (Weil's bound, [Weil1948] p. 207)."]
out += [f"#print axioms {f}" for f in imp]
pathlib.Path(sys.argv[3]).write_text("\n".join(out) + "\n")
print(f"audit block: {len(full)} records ({len(clean)} CLEAN, {len(imp)} IMPORTED), {len(private)} private helpers not listed -> {sys.argv[3]}")
