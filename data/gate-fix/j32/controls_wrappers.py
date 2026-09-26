#!/usr/bin/env python3
"""J32's controls for the owner's ruling: `scripts/vacuity.sh --baseline` writes its counts, and both wrappers
say what the digest's exit 3 means.

Each control runs the REAL shell scripts end to end, on a copy of the repository's gate files in a temporary
tree, with a stub `lake` first on PATH that prints a saved Lean output (`fixture-vacuity-scan.log`,
`fixture-axioms-audit.log`) instead of elaborating anything. Every red must be red for its own reason, and is
bounded on both sides: the line the plant should cause is present, and the line a different failure would
cause is absent. The versions before the ruling (`git show 9f5eb1bb:…`) are run on the same plants, where
the controls must go red for the defect's own reason — so a pass is not a control that could never fail.

`axioms.sh` is checked through its digest step only: past it, the script reads the source's purchase ledger
with `git ls-files`, which the temporary tree does not have, so a faithful run ends at the ledger comparison;
the control asserts it got there.

    python3 data/gate-fix/j32/controls_wrappers.py     # exit 0: every control behaved; exit 1: one did not
"""
from __future__ import annotations

import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
REPO = HERE.parents[2]
SCAN = HERE / "fixture-vacuity-scan.log"
AUDIT = HERE / "fixture-axioms-audit.log"
BEFORE = "9f5eb1bb"  # J32's repaired digest, with the wrappers and the --baseline writer before the ruling
GATE_FILES = ("vacuity.sh", "axioms.sh", "gate_report.py", "dev-env.sh", "gate-log.sh")
KEYS = ("declarations", "refutations-skipped", "sites", "vacuous", "stale", "declared", "witnessed", "generic",
        "unknown")
TRUST = r"current audit reads \d+ clean and \d+ declared purchases"
HEADER_1 = re.compile(r"^#   declarations=\d+  refutations-skipped=\d+  sites=\d+$", re.M)
EXIT3_VAC = "==> vacuity: FAIL — a recorded count could not be read"
EXIT3_AX = "==> axioms: FAIL — the recorded count in CLAUDE.md § Trust ledger could not be read"
NO_DIGEST = "no digest could be built from this run's output"


class PlantRefused(Exception):
    pass


def sub_once(text: str, pattern: str, repl: str, start: str, end: str) -> str:
    if text.count(start) != 1:
        raise PlantRefused(f"{start!r} occurs {text.count(start)} times")
    i = text.index(start)
    j = text.index(end, i + len(start))
    body, n = re.subn(pattern, repl, text[i:j])
    if n != 1:
        raise PlantRefused(f"{pattern!r} matched {n} times")
    return text[:i] + body + text[j:]


GATE = ("\n## The gate\n", "\n### Make the gate fail")
LEDGER = ("\n## Trust ledger\n", "\n## Toolchain\n")


def fixture_counts() -> tuple[dict, int, int]:
    found = {}
    for line in SCAN.read_text().splitlines():
        if line.startswith(("=== SCANNED === ", "=== TOTALS === ")):
            found.update({k: int(v) for k, v in re.findall(r"([\w-]+)=(\d+)", line)})
    section, clean, purchased = None, 0, 0
    for line in AUDIT.read_text().splitlines():
        if line in ("=== CLEAN ===", "=== PURCHASED ==="):
            section = line
        elif line.startswith("'") and " depends on axioms: [" in line:
            clean += section == "=== CLEAN ==="
            purchased += section == "=== PURCHASED ==="
    return {k: found[k] for k in KEYS}, clean, purchased


def main() -> int:
    now, clean, purchased = fixture_counts()
    claude = (REPO / "CLAUDE.md").read_text(encoding="utf-8")
    for k in KEYS:
        claude = sub_once(claude, rf"(?<![\w-]){re.escape(k)}=\d+", f"{k}={now[k]}", *GATE)
    claude = sub_once(claude, TRUST, f"current audit reads {clean} clean and {purchased} declared purchases", *LEDGER)
    baseline = (REPO / "scripts/vacuity-baseline.txt").read_text(encoding="utf-8")
    for k in KEYS:
        baseline = sub_once(baseline, rf"(?<![\w-]){re.escape(k)}=\d+", f"{k}={now[k]}",
                            "# Counts to hold", "\n# The declaration count")

    tmp = Path(tempfile.mkdtemp(prefix="j32-wrappers-"))
    try:
        return controls(tmp, now, claude, baseline)
    finally:
        shutil.rmtree(tmp)  # /tmp is RAM on this machine


def controls(tmp: Path, now: dict, claude_ok: str, baseline_ok: str) -> int:
    bin_dir = tmp / "bin"
    bin_dir.mkdir()
    (bin_dir / "lake").write_text('#!/bin/bash\ncat "$J32_STUB_OUT"\n')
    (bin_dir / "lake").chmod(0o755)
    before = {}
    for name in GATE_FILES:
        shown = subprocess.run(["git", "-C", str(REPO), "show", f"{BEFORE}:scripts/{name}"],
                               capture_output=True, text=True)
        if shown.returncode != 0:
            print(f"==> J32 wrapper controls: FAIL — could not extract {BEFORE}:scripts/{name}")
            return 1
        before[name] = shown.stdout

    def tree(case: str, version: str, claude: str, baseline: str | None) -> Path:
        root = tmp / case
        (root / "scripts").mkdir(parents=True)
        for name in GATE_FILES:
            dst = root / "scripts" / name
            if version == "now":
                shutil.copy2(REPO / "scripts" / name, dst)
            else:
                dst.write_text(before[name])
                dst.chmod(0o755)
        (root / "CLAUDE.md").write_text(claude, encoding="utf-8")
        if baseline is not None:
            (root / "scripts/vacuity-baseline.txt").write_text(baseline, encoding="utf-8")
        return root

    def run(root: Path, script: str, stub: Path, *args) -> tuple[int, str]:
        env = {**os.environ, "PATH": f"{bin_dir}:{os.environ['PATH']}", "J32_STUB_OUT": str(stub)}
        done = subprocess.run(["bash", str(root / "scripts" / script), *args], env=env, cwd=root,
                              stdin=subprocess.DEVNULL, capture_output=True, text=True)
        return done.returncode, done.stdout + done.stderr

    results = []  # (name, problems, red_because or None, output)

    def expect(name, code, out, want_exit, present=(), absent=(), red_because=None):
        problems = [] if code == want_exit else [f"exit {code}, expected {want_exit}"]
        problems += [f"missing: {p!r}" for p in present if p not in out]
        problems += [f"present and must not be: {a!r}" for a in absent if a in out]
        results.append((name, problems, red_because, code, out))

    claude_no_unknown = sub_once(claude_ok, r" unknown=\d+", "", *GATE)
    claude_no_trust = sub_once(claude_ok, r"current audit reads", "current audit holds", *LEDGER)
    malformed = tmp / "scan-without-totals.log"
    malformed.write_text("\n".join(l for l in SCAN.read_text().splitlines() if not l.startswith("=== TOTALS ===")))
    base_match = "recorded counts in scripts/vacuity-baseline.txt's header: match (9 of 9 compared)"
    claude_match = "recorded counts in CLAUDE.md § The gate: match (9 of 9 compared)"
    no_decl = "could not read the counts in scripts/vacuity-baseline.txt's header: no declarations"

    for version in ("now", "before"):
        red = version == "before"
        # W1/W2: regenerate the baseline, then run the plain gate against what was written.
        root = tree(f"W1-{version}", version, claude_ok, baseline_ok)
        code, out = run(root, "vacuity.sh", SCAN, "--baseline")
        expect(f"W1-{version}-regenerate", code, out, 0, present=("==> vacuity: baseline written",))
        written = (root / "scripts/vacuity-baseline.txt").read_text()
        header_lines = HEADER_1.findall(written)
        code, out = run(root, "vacuity.sh", SCAN)
        if not red:
            expect("W1-now-header-then-plain-run", code, out, 0,
                   present=(base_match, claude_match, "==> vacuity: OK"), absent=(no_decl,))
            if len(header_lines) != 1:
                results[-1][1].append(f"{len(header_lines)} counts lines in the regenerated header, expected 1")
        else:
            expect("W2-before-header-then-plain-run", code, out, 0, present=(base_match,),
                   red_because=no_decl)  # the count-less header the old writer produced
        # W3: CLAUDE.md § The gate unreadable — the wrapper must name a recorded-count problem.
        root = tree(f"W3-{version}", version, claude_no_unknown, baseline_ok)
        code, out = run(root, "vacuity.sh", SCAN)
        if not red:
            expect("W3-now-exit3-message", code, out, 1,
                   present=(EXIT3_VAC, "could not read the counts in CLAUDE.md § The gate: no unknown", base_match,
                            "#   declarations=7051  refutations-skipped=304  sites=279"), absent=(NO_DIGEST,))
        else:
            expect("W3-before-exit3-message", code, out, 1, present=(EXIT3_VAC,), red_because=NO_DIGEST)
        # W5/W6: the same for axioms.sh and CLAUDE.md § Trust ledger.
        root = tree(f"W6-{version}", version, claude_no_trust, None)
        code, out = run(root, "axioms.sh", AUDIT)
        if not red:
            expect("W6-now-exit3-message", code, out, 1, present=(EXIT3_AX, "0 sentences reading"),
                   absent=(NO_DIGEST,))
        else:
            expect("W6-before-exit3-message", code, out, 1, present=(EXIT3_AX,), red_because=NO_DIGEST)

    # W4: a malformed scan (exit 2) still says no digest could be built, and never names a recorded count.
    root = tree("W4-now", "now", claude_ok, baseline_ok)
    code, out = run(root, "vacuity.sh", malformed)
    expect("W4-now-exit2-message", code, out, 1, present=(NO_DIGEST, "no '=== SCANNED ===' or '=== TOTALS ==="),
           absent=(EXIT3_VAC,))
    # W5: a faithful CLAUDE.md passes axioms.sh's digest step (it then stops at the ledger, which needs git).
    root = tree("W5-now", "now", claude_ok, None)
    code, out = run(root, "axioms.sh", AUDIT)
    expect("W5-now-faithful-digest-step", code, out, 1,
           present=("recorded count in CLAUDE.md § Trust ledger: match (clean and purchases compared)",
                    "==> FAIL: the source ledger and the environment ledger disagree"),
           absent=(EXIT3_AX, NO_DIGEST))

    failed = 0
    for name, problems, red_because, code, out in results:
        if red_because is not None:
            # RED, and for its own reason: the defect's line is there — not merely any failure.
            if problems and red_because in out:
                print(f"ok    {name}: RED on the pre-ruling version, for its own reason — {problems[0]}; "
                      f"it printed {red_because!r}")
            else:
                failed += 1
                print(f"FAIL  {name}: the pre-ruling version " + ("PASSED" if not problems else
                      f"went red for another reason ({problems})"))
        elif problems:
            failed += 1
            print(f"FAIL  {name}:")
            for p in problems:
                print(f"        {p}")
            print("        its output ended: " + " | ".join(out.strip().splitlines()[-4:]))
        else:
            print(f"ok    {name}")
    print(f"==> J32 wrapper controls: {len(results) - failed} of {len(results)} behaved"
          + (f"; {failed} DID NOT" if failed else ""))
    return 1 if failed else 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except PlantRefused as e:
        print(f"==> J32 wrapper controls: FAIL — a plant could not be applied, so nothing was tested: {e}")
        sys.exit(1)
