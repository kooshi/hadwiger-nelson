#!/usr/bin/env python3
"""FS131-L6A: the receipt that wave 6's first half is whole — every theorem of the fourteen modules, and every
declaration the five implementers' and the planners' reports name, on the standard three or a subset.

  tools/fs131_l6a_leaves.py gen <count-modules.out> <skeleton-ref> <out.lean>
      Three lists, each written to <out.lean>.names as `<source>\\t<name>` lines:
        kernel    every `DECL THM` of a module `Proofs.HadwigerNelson.Plane.Saturated.*` in the output of
                  `data/fs131/l5/count-modules.lean` on the joined library (the kernel's own list of theorems);
        leaf      every declaration of the wave's files at <skeleton-ref> (the second planner's tip) whose text
                  holds `sorry`: the skeleton's leaves;
        block:<job>   every `#print axioms` name of the wave's blocks of `scripts/Axioms.lean` (headings
                  `/-! ## FS131-K6`, `-K6b`, `-I6A` … `-I6E`);
        wired:<job>   the names the reports list as proved over another line's leaf: the `=== WIRED` section of
                  `data/fs131/i6e/I6eAxioms.lean` (FS131-I6E, 14), the six of FS131-I6C's Drafts item 1, and the
                  planners' compositions over leaves.
      Writes a Lean file that imports the fourteen modules, prints the axioms of every name of the union, and
      ends with a planted control: a theorem of that file proved by `sorry`, whose print must show `sorryAx`.

  tools/fs131_l6a_leaves.py read <out.lean>.names <log>
      PASS iff every listed name has a print, each on a subset of [propext, Classical.choice, Quot.sound]; every
      `leaf`, `block` and `wired` name that is a theorem is in the kernel's list (NOT-IN-KERNEL-LIST: a name a
      report gives that the library does not hold as a theorem and that has no print either); and the control's
      print holds `sorryAx` (a print that could not show a `sorry` proves nothing).

  tools/fs131_l6a_leaves.py --self-test <out.lean>.names <log>
      `read` must pass; then three plants on a copy of the log, each of which must fail with its own word: a
      leaf's print given `sorryAx` (BAD-AXIOM), a leaf's print dropped (NO-PRINT), the control's print made
      clean (CONTROL).
"""
import collections
import importlib.util
import os
import re
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location("stm", os.path.join(HERE, "fs131_l6a_statements.py"))
stm = importlib.util.module_from_spec(spec)
spec.loader.exec_module(stm)

DIR = "Proofs/HadwigerNelson/Plane/Saturated"
MODPREFIX = "Proofs.HadwigerNelson.Plane.Saturated."
STD = {"propext", "Classical.choice", "Quot.sound"}
CONTROL = "HadwigerNelson.fs131_l6a_control"
P = "HadwigerNelson.Plane."
I6C_WIRED = [P + n for n in ("HasTwoDiscsAt.one_le_norm_sub", "HasTwoDiscsAt.norm_sub_le", "HasTwoDiscsAt.normal_unique",
                             "local_graph", "AeColouring.local_graph", "sq9_exists_isInterfaceChart")]
PLANNER_WIRED = [P + n for n in ("TwoColourNhd.mem_essBoundary", "pinch_interface", "c11_discs_interface", "sat_noPar",
                                 "AeColouring.regJFan_of_saturated", "AeColouring.regJFan_iff_singLocallyFinite",
                                 "AeColouring.Fan.sector_unique", "sq9_regJFan")]
BLOCK = re.compile(r"^/-! ## (FS131-(?:K6b?|I6[A-E]))\b")


def gen(count_out, ref, out):
    rows = []                                    # (source, name)
    mods = set()
    for ln in open(count_out, encoding="utf-8"):
        p = ln.split()
        if ln.startswith("DECL THM ") and len(p) >= 4 and p[2].startswith(MODPREFIX):
            rows.append(("kernel", p[3]))
            mods.add(p[2])
    files = subprocess.run(["git", "ls-tree", "--name-only", ref, DIR + "/"], check=True, capture_output=True,
                           text=True).stdout.split()
    for path in files:
        text = subprocess.run(["git", "show", f"{ref}:{path}"], check=True, capture_output=True, text=True).stdout
        for qual, kind, doc, stmt, short in stm.chunks(text):
            if kind not in ("theorem", "lemma"):
                continue
            start = text.find(stmt)
            end = text.find("\n\n", start)
            if re.search(r"\bsorry\b", text[start:end if end >= 0 else len(text)]):
                rows.append(("leaf", qual))
    job = None
    for ln in open("scripts/Axioms.lean", encoding="utf-8"):
        if ln.startswith("/-! ## ") or ln.startswith("#eval IO.println"):
            m = BLOCK.match(ln)
            job = m.group(1) if m else None
        elif job and ln.startswith("#print axioms "):
            rows.append((f"block:{job}", ln.split()[2]))
    wired, on = [], False
    for ln in open("data/fs131/i6e/I6eAxioms.lean", encoding="utf-8"):
        if ln.startswith("#eval IO.println"):
            on = "WIRED" in ln
        elif on and ln.startswith("#print axioms "):
            wired.append(ln.split()[2])
    rows += [("wired:FS131-I6E", n) for n in wired] + [("wired:FS131-I6C", n) for n in I6C_WIRED]
    rows += [("wired:planners", n) for n in PLANNER_WIRED]
    names = list(dict.fromkeys(n for _, n in rows))
    with open(out, "w", encoding="utf-8") as fh:
        for m in sorted(mods):
            fh.write(f"import {m}\n")
        fh.write("\nset_option pp.fullNames true\n\n")
        for nm in names:
            fh.write(f"#print axioms {nm}\n")
        fh.write(f"\n-- the control: a `sorry` this print must show\n"
                 f"theorem {CONTROL} : (1 : Nat) = 1 := by sorry\n#print axioms {CONTROL}\n")
    with open(out + ".names", "w", encoding="utf-8") as fh:
        for s, n in rows:
            fh.write(f"{s}\t{n}\n")
    by = collections.Counter(s for s, _ in rows)
    print(f"{len(mods)} modules; {len(names)} distinct names; by source: "
          + ", ".join(f"{k} {v}" for k, v in sorted(by.items())) + f"; wrote {out}")


def parse(log):
    out = {}
    text = open(log, encoding="utf-8").read()
    for m in re.finditer(r"'([^']+)' depends on axioms: \[([^\]]*)\]", text, re.S):
        out[m.group(1)] = {a.strip() for a in m.group(2).replace("\n", " ").split(",") if a.strip()}
    for m in re.finditer(r"'([^']+)' does not depend on any axioms", text):
        out[m.group(1)] = set()
    return out


def read(names_file, log, label="read"):
    rows = [tuple(l.split("\t")) for l in open(names_file, encoding="utf-8").read().split("\n") if l]
    got = parse(log)
    kernel = {n for s, n in rows if s == "kernel"}
    faults, tally = [], collections.defaultdict(collections.Counter)
    seen = set()
    for s, nm in rows:
        if nm not in got:
            if (s, nm) not in seen:
                faults.append(f"NO-PRINT {nm} ({s})")
        elif not got[nm] <= STD:
            if nm not in seen:
                faults.append(f"BAD-AXIOM {nm} ({s}): {sorted(got[nm] - STD)}")
        else:
            tally[s]["exact" if got[nm] == STD else "subset"] += 1
        if s != "kernel" and nm not in kernel:
            tally[s]["not a theorem of the kernel's list (a definition carrying a proof)"] += 1
        seen.add(nm)
        seen.add((s, nm))
    if CONTROL not in got or "sorryAx" not in got[CONTROL]:
        faults.append(f"CONTROL {CONTROL}: its print does not show sorryAx ({sorted(got.get(CONTROL, []))})")
    names = {n for _, n in rows}
    ex = sum(1 for n in names if got.get(n) == STD)
    sub = sum(1 for n in names if n in got and got[n] < STD)
    print(f"{label}: {len(names)} distinct names; {ex} on exactly the standard three, {sub} on a proper subset; "
          f"control {'shows sorryAx' if not any(f.startswith('CONTROL') for f in faults) else 'SILENT'}; faults {len(faults)}")
    for s in sorted(tally):
        print(f"  {s}: " + ", ".join(f"{k} {v}" for k, v in sorted(tally[s].items())))
    for n in sorted(names):
        if n in got and got[n] < STD:
            print(f"  subset: {n} {sorted(got[n])}")
    for f in faults[:40]:
        print("  " + f)
    return faults


def main(argv):
    if len(argv) == 4 and argv[0] == "gen":
        gen(argv[1], argv[2], argv[3])
        return 0
    if len(argv) == 3 and argv[0] == "read":
        faults = read(argv[1], argv[2])
        print("leaves: PASS" if not faults else "leaves: FAIL")
        return 1 if faults else 0
    if len(argv) == 3 and argv[0] == "--self-test":
        names_file, log = argv[1], argv[2]
        ok = not read(names_file, log, "faithful")
        text = open(log, encoding="utf-8").read()
        first = next(l.split("\t")[1] for l in open(names_file, encoding="utf-8") if l.startswith("leaf\t")).strip()
        m = re.search(r"'" + re.escape(first) + r"' depends on axioms: \[[^\]]*\]", text, re.S)
        mc = re.search(r"'" + re.escape(CONTROL) + r"' depends on axioms: \[[^\]]*\]", text, re.S)
        if not m or not mc:
            print("self-test: the first leaf or the control has no print to plant on")
            return 1
        plants = [
            ("BAD-AXIOM", text.replace(m.group(0), m.group(0)[:-1] + ", sorryAx]", 1)),
            ("NO-PRINT", text.replace(m.group(0), "", 1)),
            ("CONTROL", text.replace(mc.group(0), mc.group(0).replace("sorryAx", "propext"), 1)),
        ]
        for word, planted in plants:
            with tempfile.NamedTemporaryFile("w", suffix=".log", delete=False, encoding="utf-8") as fh:
                fh.write(planted)
            faults = read(names_file, fh.name, f"plant {word}")
            fired = any(f.startswith(word) for f in faults)
            print(f"  -> {'fired' if fired else 'DID NOT FIRE'} ({word})")
            ok = ok and fired
        print("self-test: PASS" if ok else "self-test: FAIL")
        return 0 if ok else 1
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
