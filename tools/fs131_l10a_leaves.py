#!/usr/bin/env python3
"""FS131-L10A: the receipt that wave 10's first pass is whole — every skeleton leaf on the standard three.

  tools/fs131_l10a_leaves.py gen <skeleton-ref> <out.lean> [extra-name ...]
      Reads the four first-pass files at <skeleton-ref> (the planner's tip, where every leaf is a
      `sorry`), lists the declarations whose text holds `sorry` — the leaves — and writes a Lean file
      that imports the four modules, prints each leaf's axioms (and each extra name's), and ends with a
      planted control: a theorem of this file proved by `sorry`, whose print must show `sorryAx`.
      The list of names is written beside it as <out>.names.

  tools/fs131_l10a_leaves.py read <out.lean>.names <log>
      Parses the `#print axioms` output. PASS iff every listed name has a print, each on a subset of
      [propext, Classical.choice, Quot.sound], and the control's print holds `sorryAx` (a print that
      could not show a `sorry` proves nothing).

  tools/fs131_l10a_leaves.py --self-test <out.lean>.names <log>
      `read` must pass on the log; then three plants on a copy of the log, each of which must fail with
      its own word: a leaf's print given `sorryAx` (BAD-AXIOM), a leaf's print dropped (NO-PRINT), the
      control's print made clean (CONTROL).
"""
import importlib.util
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location("stm", os.path.join(HERE, "fs131_l10a_statements.py"))
stm = importlib.util.module_from_spec(spec)
spec.loader.exec_module(stm)

FILES = ["CharacterColouring", "SpectralInputs", "StationaryRatio", "StandingFive"]
STD = {"propext", "Classical.choice", "Quot.sound"}
CONTROL = "HadwigerNelson.fs131_l10a_control"


def gen(ref, out, extra):
    names = []
    for f in FILES:
        path = f"Proofs/HadwigerNelson/Arith/{f}.lean"
        text = subprocess.run(["git", "show", f"{ref}:{path}"], check=True, capture_output=True,
                              text=True).stdout
        lines = text.split("\n")
        # a declaration's text, proof included: from its first line to the next blank line before a
        # non-indented line (the statements tool's chunking, re-read with the proof kept)
        for qual, kind, doc, stmt, short in stm.chunks(text):
            if kind not in ("theorem", "lemma", "instance", "def"):
                continue
            start = text.find(stmt)
            end = text.find("\n\n", start)
            body = text[start:end if end >= 0 else len(text)]
            if re.search(r"\bsorry\b", body):
                names.append(qual)
    leaves = list(names)
    names += [e for e in extra if e not in names]
    with open(out, "w", encoding="utf-8") as fh:
        for f in FILES:
            fh.write(f"import Proofs.HadwigerNelson.Arith.{f}\n")
        fh.write("\nset_option pp.fullNames true\n\n")
        for nm in names:
            fh.write(f"#print axioms {nm}\n")
        fh.write(f"\n-- the control: a `sorry` this print must show\n"
                 f"theorem {CONTROL} : (1 : Nat) = 1 := by sorry\n#print axioms {CONTROL}\n")
    with open(out + ".names", "w", encoding="utf-8") as fh:
        fh.write("\n".join(names) + "\n")
    print(f"{len(leaves)} leaves at {ref} ({', '.join(f'{f} ' + str(sum(1 for n in leaves if '.' + f + '.' in n)) for f in FILES)}), "
          f"{len(names) - len(leaves)} extra name(s); wrote {out}")


def parse(log):
    """name -> set of axioms (empty set: no axioms)."""
    out = {}
    text = open(log, encoding="utf-8").read()
    for m in re.finditer(r"'([^']+)' depends on axioms: \[([^\]]*)\]", text, re.S):
        out[m.group(1)] = {a.strip() for a in m.group(2).replace("\n", " ").split(",") if a.strip()}
    for m in re.finditer(r"'([^']+)' does not depend on any axioms", text):
        out[m.group(1)] = set()
    return out


def read(names_file, log, label="read"):
    names = [n for n in open(names_file, encoding="utf-8").read().split("\n") if n]
    got = parse(log)
    faults = []
    exact = sub = 0
    for nm in names:
        if nm not in got:
            faults.append(f"NO-PRINT {nm}")
        elif not got[nm] <= STD:
            faults.append(f"BAD-AXIOM {nm}: {sorted(got[nm] - STD)}")
        elif got[nm] == STD:
            exact += 1
        else:
            sub += 1
    if CONTROL not in got or "sorryAx" not in got[CONTROL]:
        faults.append(f"CONTROL {CONTROL}: its print does not show sorryAx ({sorted(got.get(CONTROL, []))})")
    print(f"{label}: {len(names)} names; {exact} on exactly the standard three, {sub} on a proper subset; "
          f"control {'shows sorryAx' if not any(f.startswith('CONTROL') for f in faults) else 'SILENT'}; "
          f"faults {len(faults)}")
    for f in faults:
        print("  " + f)
    return faults


def main(argv):
    if len(argv) >= 3 and argv[0] == "gen":
        gen(argv[1], argv[2], argv[3:])
        return 0
    if len(argv) == 3 and argv[0] == "read":
        faults = read(argv[1], argv[2])
        print("leaves: PASS" if not faults else "leaves: FAIL")
        return 1 if faults else 0
    if len(argv) == 3 and argv[0] == "--self-test":
        names_file, log = argv[1], argv[2]
        ok = not read(names_file, log, "faithful")
        text = open(log, encoding="utf-8").read()
        first = open(names_file, encoding="utf-8").read().split("\n")[0]
        m = re.search(r"'" + re.escape(first) + r"' depends on axioms: \[[^\]]*\]", text, re.S)
        mc = re.search(r"'" + re.escape(CONTROL) + r"' depends on axioms: \[[^\]]*\]", text, re.S)
        plants = [
            ("BAD-AXIOM", text.replace(m.group(0), m.group(0)[:-1] + ", sorryAx]", 1)),
            ("NO-PRINT", text.replace(m.group(0), "", 1)),
            ("CONTROL", text.replace(mc.group(0), mc.group(0).replace("sorryAx", "propext"), 1)),
        ]
        import tempfile
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
