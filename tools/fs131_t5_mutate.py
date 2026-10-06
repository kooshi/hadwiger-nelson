#!/usr/bin/env python3
"""FS131-T5: mutate the assumptions gate, and watch its own self-test go red.

`RUNNING.md` § Make the gate fail: a control whose failure mode is unreachable has not been tested by passing.
`./scripts/assumptions.sh --self-test` passing shows every planted fault fires on the shipped instrument; this
shows the converse, check by check — **with one decision of the instrument switched off, the self-test fails,
and names the control built for that decision.** A mutation the self-test survives is a control that tests
nothing.

No shipped file is edited: a Lean mutation is written to a scratch copy the gate is pointed at
(`ASSUMPTIONS_AUDIT`), a shell mutation to an untracked sibling of `scripts/assumptions.sh` that is removed
afterwards. The harness asserts each mutation's text occurs exactly once (a plant that lands nowhere would pass
for that reason), and at the end that the two shipped files are byte-identical to what it started from and that
the unmutated self-test still passes.

    tools/fs131_t5_mutate.py [--only <name>]      (from the worktree root; each run is one scan, about a minute)
"""
from __future__ import annotations

import hashlib
import os
import subprocess
import sys
import tempfile
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
LEAN = REPO / "scripts" / "Assumptions.lean"
SHELL = REPO / "scripts" / "assumptions.sh"

# (name, file, the text to replace, its replacement, a control the self-test must report as FAIL)
MUTATIONS = [
    ("closed-rule-off", "lean", "      else open_ := open_.push h\n", "      else nEstablished := nEstablished + 1\n",
     "closed_undeclared"),
    ("closure-unsound", "lean",
     "if !established.contains d.concl && d.hyps.all (fun h => established.contains h.type) then",
     "if !established.contains d.concl then", "closed_unestablished"),
    ("refutation-takes-any", "lean", "    | true, [h] =>\n", "    | true, h :: _ =>\n", "closed_refuted"),
    ("polarity-and-flipped", "lean", "    | some ``And | some ``Or => each pol\n",
     "    | some ``And | some ``Or => each pol.flip\n", "shapes"),
    ("antecedent-not-flipped", "lean", "if ← isProp ty then out := out ++ (← occs t ty pol.flip) else",
     "if ← isProp ty then out := out ++ (← occs t ty pol) else", "shapes"),
    ("wrappers-off", "lean", "        if declaredFormers.contains c && !ws.contains c then ws := ws.push c\n",
     "        if false && declaredFormers.contains c && !ws.contains c then ws := ws.push c\n", "shapes"),
    ("never-concluded-off", "lean", "      else if neverConcluded then\n", "      else if false && neverConcluded then\n",
     "never_concluded"),
    ("docstring-words-off", "lean",
     "    | none =>\n      if saysAssumption doc then\n", "    | none =>\n      if false && saysAssumption doc then\n",
     "by_docstring"),
    ("kind-check-off", "lean", "    if docSupports doc kind then pure ()\n", "    if true || docSupports doc kind then pure ()\n",
     "kind"),
    ("discharged-off", "lean", "  for (h, by_) in general do\n", "  for (h, by_) in general.extract 0 0 do\n", "discharged"),
    ("derived-constant", "lean", "def derivedFails : Bool := true", "def derivedFails : Bool := false", "derived_only"),
    ("stale-declaration-off", "lean", "    if consumersOf (toString h) == 0 then\n",
     "    if false && consumersOf (toString h) == 0 then\n", "stale_declaration"),
    ("axiom-rests-off", "lean", "        if libAxioms.contains a && a != d.name then rests := rests.push (a, d.name)",
     "        if false && libAxioms.contains a && a != d.name then rests := rests.push (a, d.name)", "axioms"),
    ("source-check-off", "lean", "    if source.trimAscii.copy.isEmpty then (#[s!\"FAIL no-source",
     "    if false && source.trimAscii.copy.isEmpty then (#[s!\"FAIL no-source", "sources"),
    ("resolution-off", "shell", '    resolves "${class}" "${tok}" || add "FAIL unresolved-source',
     '    true || add "FAIL unresolved-source', "sources"),
    ("ledger-unlisted-off", "shell", '      [[ -n "${line}" ]] && add "FAIL unlisted-consumer',
     '      [[ -n "${line}" ]] && : "FAIL unlisted-consumer', "ledger"),
    ("ledger-stale-off", "shell", '      [[ -n "${line}" ]] && add "FAIL stale-consumer',
     '      [[ -n "${line}" ]] && : "FAIL stale-consumer', "ledger"),
    ("accounting-off", "shell", '  if [[ "${nscanned}" != 1 || "${ntotals}" != 1 ]]; then',
     '  if false; then', "accounting: the TOTALS line dropped"),
]


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def self_test(env_extra: dict, script: Path) -> tuple[int, str]:
    env = dict(os.environ, **env_extra)
    r = subprocess.run([str(script), "--self-test"], cwd=REPO, env=env, capture_output=True, text=True)
    return r.returncode, r.stdout + r.stderr


def main(argv: list[str]) -> int:
    only = argv[argv.index("--only") + 1] if "--only" in argv else None
    before = (digest(LEAN), digest(SHELL))
    bad = 0
    code, out = self_test({}, SHELL)
    print(f"unmutated: exit {code} — {'OK' if code == 0 else 'FAIL'}", flush=True)
    if code != 0:
        print(out[-1500:])
        return 1
    with tempfile.TemporaryDirectory() as d:
        for name, which, old, new, control in MUTATIONS:
            if only and name != only:
                continue
            src = LEAN if which == "lean" else SHELL
            text = src.read_text(encoding="utf-8")
            if text.count(old) != 1:
                print(f"{name}: FAIL — the text to mutate occurs {text.count(old)} times in {src.name}, not once")
                bad += 1
                continue
            mutant_script = SHELL
            env_extra = {}
            try:
                if which == "lean":
                    mutant = Path(d) / f"Assumptions-{name}.lean"
                    mutant.write_text(text.replace(old, new), encoding="utf-8")
                    env_extra = {"ASSUMPTIONS_AUDIT": str(mutant)}
                else:
                    mutant_script = SHELL.with_name(f"assumptions-mutant-{os.getpid()}.sh")
                    mutant_script.write_text(text.replace(old, new), encoding="utf-8")
                    mutant_script.chmod(0o755)
                code, out = self_test(env_extra, mutant_script)
            finally:
                if mutant_script != SHELL and mutant_script.exists():
                    mutant_script.unlink()
            named = [l for l in out.splitlines() if l.startswith("    FAIL  ") and control in l]
            if code != 0 and named:
                print(f"{name}: caught — self-test exit {code}, and it names its control: {named[0][:150]}", flush=True)
            else:
                print(f"{name}: SURVIVED — self-test exit {code}; no 'FAIL  …{control}…' line. The control tests nothing.")
                print("\n".join(l for l in out.splitlines() if "FAIL" in l)[:1200], flush=True)
                bad += 1
    after = (digest(LEAN), digest(SHELL))
    leftovers = sorted(p.name for p in SHELL.parent.glob("assumptions-mutant-*.sh"))
    if after != before or leftovers:
        print(f"RESTORE: FAIL — shipped files changed ({after != before}) or mutants left behind ({leftovers})")
        bad += 1
    else:
        print("restore: the two shipped files are byte-identical to the start, and no mutant is left")
    if not only:
        code, _ = self_test({}, SHELL)
        print(f"unmutated, again: exit {code} — {'OK' if code == 0 else 'FAIL'}")
        bad += code != 0
    print(f"mutations={len([m for m in MUTATIONS if not only or m[0] == only])} survived-or-failed={bad}")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
