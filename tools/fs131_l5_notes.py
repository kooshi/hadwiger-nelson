#!/usr/bin/env python3
"""FS131-L5 — FS131-QA4's notes check (`tools/fs131_qa4_notes.py`) over the landing tree, the outward bend's modules included.

FS131-RP1's wrapper (`tools/fs131_rp_notes.py`, imported unchanged) hands QA4's tool the audited paths read from a working tree,
plus an `EXTRA` list that held `ArcStep` alone: the outward bend's seven modules were not that job's to read. This wrapper sets
`EXTRA` to `ArcStep`, `BendStep` and the six bend modules and runs RP1's `main`; `--qa4` defaults to THIS tree once the merge of
`main` has brought QA4's tool into it (the copy that lands), else to the main checkout.

  fs131_l5_notes.py [--tree DIR] [--qa4 DIR] [--only-flagged]     exit 1 on a CONFLICT, or if nothing was read
  fs131_l5_notes.py --self-test    RP1's self-test (QA4's own controls; a conflicting note planted in `FlankUA`; an unreadable
                                   tree), then one plant of this wrapper's own: a conflicting note appended to `BendGap`, one of
                                   the added modules, must raise the CONFLICT count by one — the added modules are read
"""
import importlib.util
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
TREE = os.path.dirname(HERE)


def load_rp():
    spec = importlib.util.spec_from_file_location("rpnotes", os.path.join(HERE, "fs131_rp_notes.py"))
    rp = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(rp)
    rp.EXTRA = [rp.V + n + ".lean" for n in
                ("ArcStep", "BendStep", "BendAway", "LensOut", "CollarMapOut", "HornChart", "R2Cap", "BendGap")]
    return rp


def main(argv):
    argv = list(argv)
    if "--qa4" not in argv:
        here = os.path.isfile(os.path.join(TREE, "tools", "fs131_qa4_notes.py"))
        argv += ["--qa4", TREE if here else "/home/kooshi/source/lean-dir"]
    qa4 = argv[argv.index("--qa4") + 1]
    tree = argv[argv.index("--tree") + 1] if "--tree" in argv else os.getcwd()
    print(f"QA4's tool read from {qa4}; sources from {tree}")
    rp = load_rp()
    if "--self-test" not in argv:
        return rp.main(argv)
    rc = rp.main(argv)
    if rc != 0:
        print("SELF-TEST FAILED: RP1's controls")
        return 1
    base, _ = rp.run(rp.load_tool(qa4), tree)
    n0 = sum(1 for r in base if r[6].startswith("CONFLICT"))
    orig = rp.sources

    def planted_sources(mod, tree_, plant=None):
        src, missing = orig(mod, tree_, plant)
        key = next(k for k in src if k[1].endswith("BendGap.lean"))
        src[key] += ("\n/-- Planted. Inhabitant of the hypotheses: `bowtie` at `0`. -/\n"
                     "theorem l5_planted (hv : F.Covers v 1) (h : F.IsStuck v) : True := trivial\n")
        return src, missing

    rp.sources = planted_sources
    planted, _ = rp.run(rp.load_tool(qa4), tree)
    rp.sources = orig
    n1 = sum(1 for r in planted if r[6].startswith("CONFLICT"))
    fired = n1 == n0 + 1
    print(f"plant 'a conflicting note in BendGap (an added module)': CONFLICT count {n0} -> {n1} ({'FIRED' if fired else 'SILENT'})")
    print("L5 SELF-TEST", "OK" if fired else "FAILED")
    return 0 if fired else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv))
