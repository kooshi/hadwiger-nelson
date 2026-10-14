#!/usr/bin/env python3
"""FS131-ICM4: each certificate of `Arith/DyadicCerts` refuses a planted corrupted entry, one plant per run.

For each plant, a copy of the module with one literal of the certificate block changed is elaborated (through
`data/fs131/icm4/farm1.sh`, against the farm in which `Arith/BinaryField` is compiled), and the run must FAIL with an
error at the line of the theorem the entry feeds (`decide` refusing the check). The unplanted module must elaborate with
no error (the partner). Logs: `data/fs131/icm4/plant/<name>.log`. Exit 1 unless every plant fired where expected and the
partner passed.
"""
import pathlib
import re
import subprocess
import sys

W = pathlib.Path("/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch")
SRC = W / "Proofs/HadwigerNelson/Arith/DyadicCerts.lean"
OUT = W / "data/fs131/icm4/plant"

PLANTS = [  # name, old line, new line, the theorem whose check must refuse it
    ("P4", "def P4 : ℕ := 19", "def P4 : ℕ := 31", "prim4"),
    ("P12", "def P12 : ℕ := 4179", "def P12 : ℕ := 4097", "prim12"),
    ("E4", "def E4 : ℕ × ℕ := (0, 1)", "def E4 : ℕ × ℕ := (0, 0)", "colour4"),
    ("E8", "def E8 : ℕ × ℕ := (2, 16)", "def E8 : ℕ × ℕ := (2, 2)", "colour8"),
    ("E16", "def E16 : ℕ × ℕ := (0, 28)", "def E16 : ℕ × ℕ := (0, 0)", "colour16"),
    ("E32", "def E32 : ℕ × ℕ := (3, 344)", "def E32 : ℕ × ℕ := (3, 3)", "colour32"),
    ("B64", "def B64 : ℕ := 40", "def B64 : ℕ := 39", "counts64_ok"),
]


def run(name, text):
    path = OUT / f"DyadicCerts_{name}.lean"
    path.write_text(text)
    log = OUT / f"{name}.log"
    with open(log, "w") as f:
        rc = subprocess.run([str(W / "data/fs131/icm4/farm1.sh"), str(path.with_suffix(""))], stdout=f,
                            stderr=subprocess.STDOUT, cwd=W).returncode
    errs = [int(m.group(1)) for m in re.finditer(r"\.lean:(\d+):\d+: error", log.read_text())]
    return rc, errs, text.splitlines()


def main():
    src = SRC.read_text()
    bad = 0
    rc, errs, _ = run("partner", src)
    ok = rc == 0 and not errs
    print(f"partner (unplanted): rc={rc} errors={len(errs)} {'PASS' if ok else 'FAIL'}")
    bad += not ok
    for name, old, new, thm in PLANTS:
        if src.count(old) != 1:
            print(f"{name}: the line to plant is not in the module once — FAIL")
            bad += 1
            continue
        rc, errs, lines = run(name, src.replace(old, new))
        tline = next(i + 1 for i, l in enumerate(lines) if l.startswith(f"theorem {thm} "))
        fired = rc != 0 and tline in errs
        print(f"{name}: {old!r} -> {new!r}: rc={rc}, errors at lines {errs}; {thm} (line {tline}) "
              f"{'REFUSED (fired)' if fired else 'NOT REFUSED'}")
        bad += not fired
    print("ALL PLANTS FIRED" if not bad else f"FAILED ({bad})")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
