#!/usr/bin/env python3
"""FS131-LGT1: place the three generated blocks (tools/fs131_lgt1_audit_block.py's <prefix>.imported-pe.lean,
.imported-kb.lean, .clean.lean) in scripts/Axioms.lean, each at one anchor that must occur exactly once:
  IMPORTED pe  after the last record under `declareImport ``…positive_entropy_rigidity` (the line before the CLEAN banner);
  IMPORTED kb  after the last record under `declareImport ``…kloosterman_bound` (the line before the next declareImport);
  CLEAN        after `-- FS131-LCH1 block end`, as one section ending `-- FS131-LGT1 block end`.
Refuses (exit 1) if any anchor is not found exactly once or if the file already holds an FS131-LGT1 block.
Usage: insert_blocks.py <prefix> <scripts/Axioms.lean>"""
import sys

pre, path = sys.argv[1], sys.argv[2]
s = open(path, encoding="utf-8").read()
if "FS131-LGT1" in s:
    print("REFUSED: the file already holds an FS131-LGT1 block"); sys.exit(1)
pe = open(pre + ".imported-pe.lean", encoding="utf-8").read()
kb = open(pre + ".imported-kb.lean", encoding="utf-8").read()
cl = open(pre + ".clean.lean", encoding="utf-8").read()
A_PE = "#print axioms HadwigerNelson.Rigidity.min_localBound_five_le_chromaticNumber_closed\n"
A_KB = "#print axioms HadwigerNelson.ThreeFourColours.localBound_le_chromaticNumber_or_four_le\n"
A_CL = "-- FS131-LCH1 block end\n"
for a in (A_PE, A_KB, A_CL):
    if s.count(a) != 1:
        print(f"REFUSED: anchor found {s.count(a)} times: {a.strip()}"); sys.exit(1)
if not s.split(A_PE, 1)[1].lstrip("\n").startswith('#eval IO.println "=== CLEAN ==="'):
    print("REFUSED: the positive_entropy_rigidity anchor is not the IMPORTED section's last record"); sys.exit(1)
if not s.split(A_KB, 1)[1].lstrip("\n").startswith("#eval AxiomAudit.declareImport ``HadwigerNelson.Outside.OAI158"):
    print("REFUSED: the kloosterman_bound anchor is not that import's last record"); sys.exit(1)
head = ("\n/-! ## FS131-LGT1 — the five-colour chain's landing, part 3: every public theorem and definition of the 148 modules\n"
        "the landing brings or changes that no block above holds, classed from the kernel's print\n"
        "(`data/fs131/lgt1/axioms-all.txt`, by `tools/fs131_lgt1_audit_block.py`): the chain (FS131-KN3 … FS131-IJN1, joined\n"
        "by FS131-LCH1), the certificate link (FS131-IKL1), M13's dyadic line (FS131-ICM3, FS131-ICM4), the bound at p = 11\n"
        "and p = 19 (FS131-IKC1 … FS131-IKC4), and the records of main's four changed modules that no landing had listed\n"
        "(`Instances/SqrtFortySeven`'s field, coordinates and reduction). The records on a declared import are under\n"
        "IMPORTED. -/\n\n")
s = s.replace(A_PE, A_PE + pe, 1)
s = s.replace(A_KB, A_KB + kb, 1)
s = s.replace(A_CL, A_CL + head + cl + "-- FS131-LGT1 block end\n", 1)
open(path, "w", encoding="utf-8").write(s)
n = sum(1 for t in (pe, kb, cl) for ln in t.splitlines() if ln.startswith("#print axioms "))
print(f"placed {n} records: pe {pe.count('#print axioms ')}, kb {kb.count('#print axioms ')}, clean {cl.count('#print axioms ')}")
