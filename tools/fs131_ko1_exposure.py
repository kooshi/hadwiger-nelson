#!/usr/bin/env python3
"""FS131-KO1 stage 3: the exposure test — does a stored statement of ours move when its module sees the port's
import closure?

For each target module (a module of `main` in this tree, or of the density equality's branch `fs133-wb1` read from
its own tree's compiled library by `LEAN_PATH`, never written), two scratch copies are elaborated at this pin with the
lakefile's options by flag, under the module's own name (`--root`), each with the footer
`data/fs131/ko1/lean/DumpFooter.lean.inc` appended (every named constant the file declares, in two prints: full, and
with every instance and proof argument erased):
  base     — the module's text as it stands;
  variant  — the same text with one block of `import` lines added after its last import: the union of the Mathlib
             modules the 31 ported modules import (`data/fs131/ko1/cone/ImportsDumpWhole.out`) and those of
             `Outside/OAI158Palette`, which the ported transfer imports.
Exactly one thing differs between the two runs: the import block.  The reader classes each constant
IDENTICAL (full prints agree), INSTANCES-ONLY (full prints differ, erased prints agree), DIFFERENT (erased prints
differ), or MISSING (in one run only).

Usage:
  fs131_ko1_exposure.py run <label> [...]    elaborate the named targets (both copies), under the slot
  fs131_ko1_exposure.py compare [<label> ...] read the dumps and class every constant (exit 1 on DIFFERENT or MISSING)
  fs131_ko1_exposure.py --control            plant an instance-only move, a real move and a missing constant in a copy
                                            of one base dump; each must be classed as planted
"""
import lzma
import pathlib
import re
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
D = ROOT / "data/fs131/ko1"
SCR = ROOT / "build/ko1-exp"
OUT = D / "exposure"
FOOTER = D / "lean/DumpFooter.lean.inc"
HERE = ROOT
DENSITY = pathlib.Path("/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1")
LP = {"main": D / "lean/leanpath-here.txt", "fs133-wb1": D / "lean/leanpath-fs133wb1.txt"}
TREE = {"main": HERE, "fs133-wb1": DENSITY}
TARGETS = {
    "OAI158": ("main", "Proofs/HadwigerNelson/Outside/OAI158.lean"),
    "RadiusOutside": ("main", "Proofs/HadwigerNelson/Plane/RadiusOutside.lean"),
    "LebesgueNumber": ("main", "Proofs/HadwigerNelson/Plane/LebesgueNumber.lean"),
    "Rigidity": ("fs133-wb1", "Proofs/HadwigerNelson/Outside/OAI158Rigidity.lean"),
    "SectionDensity": ("fs133-wb1", "Proofs/HadwigerNelson/Plane/OneClass/SectionDensity.lean"),
    "Defs": ("fs133-wb1", "Proofs/HadwigerNelson/Plane/OneClass/Defs.lean"),
    "Field": ("fs133-wb1", "Proofs/HadwigerNelson/Plane/OneClass/Field.lean"),
    "InvariantLaw": ("fs133-wb1", "Proofs/HadwigerNelson/Plane/OneClass/InvariantLaw.lean"),
    "Algebraic": ("fs133-wb1", "Proofs/HadwigerNelson/Plane/OneClass/Algebraic.lean"),
    "Fractional": ("fs133-wb1", "Proofs/HadwigerNelson/Plane/OneClass/Fractional.lean"),
    "Pair": ("fs133-wb1", "Proofs/HadwigerNelson/Plane/OneClass/Pair.lean"),
}
# the second variant: the same union less the modules named here (each target name + "-noCPO" runs it)
DROP = {"noCPO": {"Mathlib.Order.CompletePartialOrder"}}
for _t in list(TARGETS):
    TARGETS[_t + "-noCPO"] = TARGETS[_t]


def extra_imports():
    got = set()
    for ln in (D / "cone/ImportsDumpWhole.out").read_text().splitlines():
        f = ln.split("\t")
        if len(f) == 3 and f[0] == "IMPORT":
            got.add(f[2])
    pal = (HERE / "Proofs/HadwigerNelson/Outside/OAI158Palette.lean").read_text()
    got |= set(re.findall(r"^import (Mathlib\S*)$", pal, flags=re.M))
    if not got:
        raise SystemExit("no import to add: the dump is empty")
    return sorted(got)


def variant_text(src, imports):
    lines = src.split("\n")
    last = max(i for i, l in enumerate(lines) if l.startswith("import "))
    block = ["-- FS131-KO1 exposure test: the port's import closure"] + [f"import {m}" for m in imports]
    return "\n".join(lines[:last + 1] + block + lines[last + 1:])


def run(label):
    tree, rel = TARGETS[label]
    src = (TREE[tree] / rel).read_text()
    footer = FOOTER.read_text()
    lp = LP[tree].read_text().strip()
    OUT.mkdir(parents=True, exist_ok=True)
    rcs = {}
    drop = DROP.get(label.split("-")[-1], set()) if "-" in label else set()
    for kind, text in (("base", src), ("variant", variant_text(src, [m for m in extra_imports() if m not in drop]))):
        root = SCR / label / kind
        f = root / rel
        f.parent.mkdir(parents=True, exist_ok=True)
        f.write_text(text + "\n" + footer)
        out = OUT / f"{label}-{kind}.out"
        cmd = ["env", "SLOT_BUDGET_GB=22", "SLOT_RESERVE_GB=6", "python3",
               "/home/kooshi/source/lean-dir/scripts/slot.py", "--mem", "8", "--cpus", "2", "--wait", "7200",
               "--name", "ko1", "--", "env", f"LEAN_PATH={lp}",
               "/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean", f"--root={root}",
               "-DautoImplicit=false", "-DrelaxedAutoImplicit=false", str(f)]
        with open(out, "w") as fo, open(OUT / f"{label}-{kind}.err", "w") as fe:
            rc = subprocess.run(cmd, stdout=fo, stderr=fe).returncode
        rcs[kind] = rc
        (OUT / f"{label}-{kind}.exit").write_text(f"exit={rc}\n")
    print(label, rcs)
    return 0 if all(v == 0 for v in rcs.values()) else 1


def parse_dump(text):
    """-> {name: {'kind', 'type', 'etype', 'value', 'evalue'}}, and whether the dump finished."""
    out, cur, done = {}, None, False
    for ln in text.splitlines():
        m = re.match(r"^DUMP (\S+) : (.*)$", ln)
        if m and not ln.startswith("DUMP   "):
            cur = m.group(1)
            out[cur] = {"kind": m.group(2)}
            continue
        m = re.match(r"^DUMP   (type|etype|value|evalue)\s*= (.*)$", ln)
        if m and cur:
            out[cur][m.group(1)] = m.group(2)
        if re.match(r"^DONE \d+$", ln):
            done = True
    return out, done


def classify(a, b):
    res = {}
    for n in sorted(set(a) | set(b)):
        if n not in a or n not in b:
            res[n] = "MISSING"
            continue
        x, y = a[n], b[n]
        full = (x.get("kind"), x.get("type"), x.get("value")) == (y.get("kind"), y.get("type"), y.get("value"))
        er = (x.get("kind"), x.get("etype"), x.get("evalue")) == (y.get("kind"), y.get("etype"), y.get("evalue"))
        res[n] = "IDENTICAL" if full else ("INSTANCES-ONLY" if er else "DIFFERENT")
    return res


def rd(path):
    """A dump, uncompressed or as committed (`.xz`)."""
    path = pathlib.Path(path)
    if path.exists():
        return path.read_text()
    return lzma.open(str(path) + ".xz", "rt").read()


def compare(labels):
    bad = 0
    for label in labels:
        try:
            a, da = parse_dump(rd(OUT / f"{label}-base.out"))
            b, db = parse_dump(rd(OUT / f"{label}-variant.out"))
        except (FileNotFoundError, OSError):
            print(f"{label}: NOT RUN")
            bad += 1
            continue
        errs = [p for p in (OUT / f"{label}-base.out", OUT / f"{label}-variant.out")
                if re.search(r": error", rd(p))]
        if not (da and db) or errs:
            print(f"{label}: INCOMPLETE (a dump did not finish, or the file has an error: {[p.name for p in errs]})")
            bad += 1
            continue
        res = classify(a, b)
        cnt = {k: sum(1 for v in res.values() if v == k) for k in ("IDENTICAL", "INSTANCES-ONLY", "DIFFERENT", "MISSING")}
        print(f"{label}: {len(res)} constants — " + ", ".join(f"{k} {v}" for k, v in cnt.items()))
        for n, v in res.items():
            if v != "IDENTICAL":
                print(f"    {v}\t{n}")
        bad += cnt["DIFFERENT"] + cnt["MISSING"]
    return 1 if bad else 0


def control():
    label = next(l for l in TARGETS if (OUT / f"{l}-base.out").exists() or (OUT / f"{l}-base.out.xz").exists())
    a, _ = parse_dump(rd(OUT / f"{label}-base.out"))
    names = [n for n in a if "type" in a[n]]
    assert len(names) >= 3, "the control needs three constants"
    b = {n: dict(v) for n, v in a.items()}
    b[names[0]]["type"] += " (c planted [])"          # a full print changed, the erased one not
    b[names[1]]["type"] += " x"
    b[names[1]]["etype"] += " x"                     # both changed
    del b[names[2]]
    res = classify(a, b)
    want = {names[0]: "INSTANCES-ONLY", names[1]: "DIFFERENT", names[2]: "MISSING"}
    ok = all(res[n] == v for n, v in want.items()) and all(res[n] == "IDENTICAL" for n in res if n not in want)
    for n, v in want.items():
        print(f"plant {v}: classed {res[n]}")
    print("CONTROL OK" if ok else "CONTROL FAILED")
    return 0 if ok else 1


def main():
    if len(sys.argv) > 1 and sys.argv[1] == "run":
        return max(run(l) for l in sys.argv[2:])
    if len(sys.argv) > 1 and sys.argv[1] == "compare":
        return compare(sys.argv[2:] or list(TARGETS))
    if "--control" in sys.argv:
        return control()
    print(__doc__)
    return 1


if __name__ == "__main__":
    sys.exit(main())
