#!/usr/bin/env python3
"""FS131-T4: the doubled-name gate with the check itself broken — each fault planted in a COPY of the tool, and watched to be caught
by the gate's own controls (`./scripts/dupnames.sh --self-test`, `scripts/dupnames-controls.txt`).

`RUNNING.md` § Make the gate fail, and watch it fail: a control that passes whatever the tool does has not tested the tool. Each
mutation below changes one line — of the scan `scripts/DupNames.lean`, or of the wrapper `scripts/dupnames.sh` — in the direction
that makes the gate PASS where it must fail, runs the self-test on the mutant, and requires that

  * the self-test exits non-zero, and
  * the controls named for the mutation are among those it reports `FAIL` (the fault is caught by the control written for it), and
  * `baseline`, the faithful partner, still passes unless the mutation names it (the red comes from the fault, not the scaffolding).

Every control the mutant turns red is printed, named or not. The shipped files are never edited: a mutant scan is a file in a
temporary directory handed to `--self-test --scan`; a mutant wrapper is a copy beside the shipped one (so that it finds the
repository), removed when its run ends. At the end the shipped files' digests are compared with those taken at the start, no mutant
file may remain, and the shipped self-test is run once more and must pass — the restore, verified.

Usage: scripts/slot.py --mem 4 --cpus 4 -- python3 tools/fs131_t4_mutate.py       exit 0 iff every mutation is caught
"""
import hashlib
import os
import pathlib
import re
import subprocess
import sys
import tempfile

REPO = pathlib.Path(__file__).resolve().parent.parent
SCAN = REPO / "scripts/DupNames.lean"
WRAP = REPO / "scripts/dupnames.sh"

# (name, which file, the one line to change — matched whole, after stripping — and its replacement, the controls that must go red,
#  whether `baseline` may go red too)
MUTATIONS = [
    ("scan forgets a second declaring module", "scan",
     "| some a => some (a.push i)", "| some a => some a",
     ["doubled_theorem", "doubled_prop_instance"], False),
    ("scan calls every pair of theorems of one type generated", "scan",
     "let isGen := isReservedName env n && allThm && oneType", "let isGen := allThm && oneType",
     ["doubled_theorem", "doubled_prop_instance"], False),
    ("scan does not look in the dependencies' modules", "scan",
     "if decl.contains n then decl := decl.modify n (·.push i)", "if false then decl := decl.modify n (·.push i)",
     ["shared_with_dependency"], False),
    ("scan reports a constant count of package modules", "scan",
     'logInfo s!"SCANNED modules={mods.size} package-modules={pkgMods} package-constants={pkgConsts} other-constants={otherConsts}"',
     'logInfo s!"SCANNED modules={mods.size} package-modules=3 package-constants={pkgConsts} other-constants={otherConsts}"',
     ["module_not_imported"], True),
    ("wrapper does not fail on a DOUBLED line", "wrapper",
     'fail("doubled", name[k] " is declared by " attr[k, "modules"] " modules (types=" attr[k, "types"] " axioms=" attr[k, "axioms"] "): " copies[k])',
     'nd += 0',
     ["doubled_theorem", "doubled_axioms_differ", "doubled_axiom_theorem", "doubled_prop_instance", "shared_with_dependency"], False),
    ("wrapper does not compare the modules read with the source files", "wrapper",
     'else if (sc["package-modules"] != sources)', 'else if (0)',
     ["module_not_imported"], False),
    ("wrapper does not compare TOTALS with the lines read", "wrapper",
     'else if (tot["doubled"] + 0 != nd + 0 || tot["generated"] + 0 != ng + 0 || tot["generated-axioms-differ"] + 0 != ngd + 0)',
     'else if (0)',
     ["lost_doubled_line"], False),
    ("wrapper does not require the END banner", "wrapper",
     'if (nend != 1) fail("banners", "=== END === printed " (nend + 0) " time(s), not once: the scan did not run to its end")',
     'if (0) fail("banners", "never")',
     ["scan_cut_short"], False),
]


def digest(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def mutate(text, old, new, what):
    lines = text.split("\n")
    hits = [i for i, ln in enumerate(lines) if ln.strip() == old]
    if len(hits) != 1:
        raise SystemExit(f"MUTATION ANCHOR: '{old[:70]}…' is a whole line {len(hits)} times, not once ({what})")
    i = hits[0]
    lines[i] = lines[i][:len(lines[i]) - len(lines[i].lstrip())] + new
    return "\n".join(lines)


def self_test(args):
    """(exit status, output, the set of controls reported FAIL, the set reported ok)."""
    r = subprocess.run(args, cwd=REPO, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    red = set(re.findall(r"^    FAIL  (\S+) ", r.stdout, re.M))
    ok = set(re.findall(r"^    ok    (\S+) ", r.stdout, re.M))
    return r.returncode, r.stdout, red, ok


def main():
    before = {p: digest(p) for p in (SCAN, WRAP)}
    logdir = REPO / "data/fs131/t4/logs/mutations"
    logdir.mkdir(parents=True, exist_ok=True)
    allok = True
    with tempfile.TemporaryDirectory() as tmp:
        for k, (what, which, old, new, named, baseline_may) in enumerate(MUTATIONS, 1):
            mutant = None
            try:
                if which == "scan":
                    f = pathlib.Path(tmp) / f"DupNames-mutant-{k}.lean"
                    f.write_text(mutate(SCAN.read_text(), old, new, what))
                    rc, out, red, ok = self_test([str(WRAP), "--self-test", "--scan", str(f)])
                else:
                    mutant = WRAP.with_name(f"dupnames-mutant-{os.getpid()}-{k}.sh")
                    mutant.write_text(mutate(WRAP.read_text(), old, new, what))
                    mutant.chmod(0o755)
                    rc, out, red, ok = self_test([str(mutant), "--self-test"])
            finally:
                if mutant is not None and mutant.exists():
                    mutant.unlink()
            (logdir / f"mutation-{k}.out").write_text(f"mutation {k}: {what}\nexit {rc}\n" + re.sub(r"/tmp/\S+", "<tmp>", out).replace(
                str(os.getpid()), "<pid>").replace(str(REPO) + "/", ""))
            problems = []
            if rc == 0:
                problems.append("the self-test PASSED on the mutant")
            if not red and not ok:
                problems.append("no control was run (the mutant did not get as far as its controls)")
            for c in named:
                if c not in red:
                    problems.append(f"control {c} did not go red")
            if "baseline" in red and not baseline_may:
                problems.append("the faithful partner `baseline` went red: the red may come from the scaffolding")
            verdict = "CAUGHT" if not problems else "NOT CAUGHT — " + "; ".join(problems)
            print(f"mutation {k} ({which}: {what}): {verdict}")
            print(f"    exit {rc}; red: {', '.join(sorted(red)) or '—'}")
            allok = allok and not problems

    # the restore, verified
    left = sorted(p.name for p in WRAP.parent.glob("dupnames-mutant-*"))
    same = all(digest(p) == h for p, h in before.items())
    rc, out, red, ok = self_test([str(WRAP), "--self-test"])
    print(f"after the mutations: shipped files unchanged: {same}; mutant files left in scripts/: {left or 'none'}; "
          f"the shipped self-test: exit {rc}, {len(ok)} ok, {len(red)} FAIL")
    allok = allok and same and not left and rc == 0 and not red and len(ok) > 0
    print(f"mutations: {len(MUTATIONS)}; " + ("every one caught by a control written for it" if allok else "NOT ALL CAUGHT"))
    sys.exit(0 if allok else 1)


if __name__ == "__main__":
    main()
