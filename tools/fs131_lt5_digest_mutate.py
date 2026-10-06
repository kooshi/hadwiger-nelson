#!/usr/bin/env python3
"""FS131-LT5: mutate the assumptions digest's decisions about the recorded counts, and watch the self-test go red.

The assumptions gate records its nine counts in `CLAUDE.md` § Trust ledger, and `scripts/gate_report.py` refuses
(exit 3) when that record is absent, partial or doubled — a recorded count whose deletion passes is no record
(inventory item 562 (d)). `./scripts/assumptions.sh --self-test` plants each of those against a one-section copy
of `CLAUDE.md` and has a partner that passes (`digest match`: the same section with the sentence in it).

`RUNNING.md` § Make the gate fail: a control whose failure mode is unreachable has not been tested by passing.
So this switches each decision off in a copy of the digest script and requires the self-test to fail **and to
name the control built for that decision**. `tools/fs131_t5_mutate.py` does the same for the scan and the
shell; it has no mutation of the digest, and is another job's tool.

No shipped file is edited: each mutant is an untracked sibling of `scripts/gate_report.py` (so that its
`REPO` is the repository), handed to the gate by `ASSUMPTIONS_GATE_REPORT` and removed afterwards. The tool
asserts each mutation's text occurs exactly once, that the shipped script is byte-identical at the end, that no
mutant is left, and that the unmutated self-test passes before and after.

    tools/fs131_lt5_digest_mutate.py [--only <name>]     (from the worktree root; each run is one scan: use the slot)
"""
from __future__ import annotations

import hashlib
import os
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
DIGEST = REPO / "scripts" / "gate_report.py"
SHELL = REPO / "scripts" / "assumptions.sh"

# (name, the text to replace, its replacement, the control the self-test must report as FAIL)
MUTATIONS = [
    ("absence-passes",
     "            unreadable.append(f\"{label} records none of the assumptions scan's nine counts, so there is nothing to \"\n",
     "            (lambda *_: None)(f\"{label} records none of the assumptions scan's nine counts, so there is nothing to \"\n",
     "digest absent "),
    ("absence-says-nothing",
     "f\"compare this run with. Add the sentence that holds them: `{sentence}`\")",
     "f\"compare this run with.\")",
     "digest absent-says-what-to-add"),
    ("doubled-passes",
     "    missing = [k for k in A_COUNTS if k not in seen]\n    doubled = sorted(k for k, n in seen.items() if n > 1)\n",
     "    missing = [k for k in A_COUNTS if k not in seen]\n    doubled = []\n", "digest doubled"),
    ("partial-reads-as-absent", "    if absent_ok and not seen:\n", "    if absent_ok and len(seen) < len(A_COUNTS):\n",
     "digest partial"),
]


def sha(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def self_test(env_extra: dict) -> tuple[int, str]:
    r = subprocess.run([str(SHELL), "--self-test"], cwd=REPO, env=dict(os.environ, **env_extra),
                       capture_output=True, text=True)
    return r.returncode, r.stdout + r.stderr


def main(argv: list[str]) -> int:
    only = argv[argv.index("--only") + 1] if "--only" in argv else None
    before = sha(DIGEST)
    bad = 0
    code, out = self_test({})
    print(f"unmutated: exit {code} — {'OK' if code == 0 else 'FAIL'}", flush=True)
    if code != 0:
        print(out[-1500:])
        return 1
    text = DIGEST.read_text(encoding="utf-8")
    ran = 0
    for name, old, new, control in MUTATIONS:
        if only and name != only:
            continue
        ran += 1
        if text.count(old) != 1:
            print(f"{name}: FAIL — the text to mutate occurs {text.count(old)} times in {DIGEST.name}, not once")
            bad += 1
            continue
        mutant = DIGEST.with_name(f"gate_report-mutant-{os.getpid()}.py")
        try:
            mutant.write_text(text.replace(old, new), encoding="utf-8")
            code, out = self_test({"ASSUMPTIONS_GATE_REPORT": str(mutant)})
        finally:
            if mutant.exists():
                mutant.unlink()
        named = [ln for ln in out.splitlines() if ln.startswith("    FAIL  ") and control in ln]
        if code != 0 and named:
            print(f"{name}: caught — self-test exit {code}, and it names its control: {named[0][:150]}", flush=True)
        else:
            print(f"{name}: SURVIVED — self-test exit {code}; no 'FAIL  …{control}…' line. The control tests nothing.")
            print("\n".join(ln for ln in out.splitlines() if "FAIL" in ln)[:1200], flush=True)
            bad += 1
    leftovers = sorted(p.name for p in DIGEST.parent.glob("gate_report-mutant-*.py"))
    if sha(DIGEST) != before or leftovers:
        print(f"RESTORE: FAIL — the shipped digest changed ({sha(DIGEST) != before}) or mutants are left ({leftovers})")
        bad += 1
    else:
        print("restore: scripts/gate_report.py is byte-identical to the start, and no mutant is left")
    if not only:
        code, _ = self_test({})
        print(f"unmutated, again: exit {code} — {'OK' if code == 0 else 'FAIL'}")
        bad += code != 0
    print(f"mutations={ran} survived-or-failed={bad}")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
