#!/usr/bin/env python3
"""FS131-RP1 — FS131-QA4's notes check (`tools/fs131_qa4_notes.py`, on `main`), run over a working tree.

QA4's tool reads fixed commits with `git show`.  This wrapper imports it unchanged (from --qa4, default the main
checkout) and hands it the same audited paths read from a working tree (--tree, default the current directory), plus the
wave-5 modules written since the audit (`EXTRA`).  It prints QA4's rows and a count per verdict; exit 1 if any row is a
CONFLICT, or if no row was read.

  fs131_rp_notes.py [--tree DIR] [--qa4 DIR] [--only-flagged]
  fs131_rp_notes.py --self-test     QA4's own self-test, then two plants here: a conflicting note appended to a copy of
                                    one audited source must raise the CONFLICT count by one, and an unreadable tree must
                                    exit 1 rather than pass empty
"""
import importlib.util
import os
import sys
from collections import Counter

V = "Proofs/HadwigerNelson/Plane/ValidMap/"
EXTRA = [V + "ArcStep.lean"]   # written after the audit; the outward bend's seven modules are not this job's to read


def load_tool(qa4_dir):
    path = os.path.join(qa4_dir, "tools", "fs131_qa4_notes.py")
    spec = importlib.util.spec_from_file_location("qa4notes", path)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


def sources(mod, tree, plant=None):
    census = mod.census
    audited = list(census.AUDITED) + [("w5c", "worktree", p) for p in EXTRA]
    census.AUDITED = audited
    src = {}
    missing = []
    for body, _, path in audited:
        full = os.path.join(tree, path)
        if os.path.isfile(full):
            src[(body, path)] = open(full, encoding="utf-8").read()
        else:
            missing.append(path)
    if plant is not None:
        key = next(k for k in src if k[1].endswith("FlankUA.lean"))
        src[key] = src[key] + plant
    return src, missing


def run(mod, tree, plant=None):
    src, missing = sources(mod, tree, plant)
    rows = mod.rows(mod.census.load(src))
    return rows, missing


def main(argv):
    tree = argv[argv.index("--tree") + 1] if "--tree" in argv else os.getcwd()
    qa4 = argv[argv.index("--qa4") + 1] if "--qa4" in argv else "/home/kooshi/source/lean-dir"
    mod = load_tool(qa4)
    if "--self-test" in argv:
        if mod.self_test() != 0:
            print("SELF-TEST FAILED: QA4's own controls")
            return 1
        base, missing = run(mod, tree)
        n0 = sum(1 for r in base if r[6].startswith("CONFLICT"))
        plant = ("\n/-- Planted. Inhabitant of the hypotheses: `bowtie` at `0`. -/\n"
                 "theorem rp_planted (hv : F.Covers v 1) (h : F.IsStuck v) : True := trivial\n")
        mod2 = load_tool(qa4)
        planted, _ = run(mod2, tree, plant)
        n1 = sum(1 for r in planted if r[6].startswith("CONFLICT"))
        ok = True
        print(f"plant 'a conflicting note': CONFLICT count {n0} -> {n1} ({'FIRED' if n1 == n0 + 1 else 'SILENT'})")
        ok = ok and n1 == n0 + 1
        mod3 = load_tool(qa4)
        empty, miss = run(mod3, "/nonexistent-tree")
        fired = (not empty) and len(miss) > 0
        print(f"plant 'an unreadable tree': rows {len(empty)}, missing {len(miss)} ({'FIRED' if fired else 'SILENT'})")
        ok = ok and fired
        print("SELF-TEST", "OK" if ok and base else "FAILED", f"({len(base)} notes read unplanted)")
        return 0 if ok and base else 1
    rows, missing = run(mod, tree)
    for m in missing:
        print("MISSING\t" + m)
    cnt = Counter((r[6].split(":")[0] or "no-conflict") for r in rows)
    for r in rows:
        if "--only-flagged" in argv and not (r[6].startswith("CONFLICT") or r[6].startswith("LOCAL-SAID")):
            continue
        print("\t".join(str(y) for y in r))
    print("notes read:", len(rows), " ".join(f"{k}={v}" for k, v in sorted(cnt.items())))
    if not rows or missing:
        print("NOTHING READ, or an audited file is missing — a failure, not a pass")
        return 1
    return 1 if cnt.get("CONFLICT") else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
