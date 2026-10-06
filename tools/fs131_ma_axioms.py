#!/usr/bin/env python3
"""FS131-MA1: the axioms print of this job's records, read by script.

`data/fs131/ma/MAAxioms.lean` lists `#print axioms` lines in two parts: the records this job claims (everything above the line
`-- CONTROL`), each of which must rest on a subset of the standard three axioms; and the controls below it — declarations
of the same lane that still stand on an open leaf — each of which must be reported with `sorryAx`. The tool runs
`lake env lean` on the file (iteration-grade: the build is the evidence that the modules compile; this reads their axioms),
parses every answer, and fails if

  * a claimed record carries any axiom outside the standard three (it names the axiom),
  * a control does not carry `sorryAx` (the instrument could not see an open leaf),
  * the number of answers differs from the number of `#print axioms` lines, or Lean printed an error (a misspelt name must
    not read as a pass).

Exit 0 iff none of these. Output: one line per record, then the counts. `--self-test` plants three faults in copies of the
list (an open record listed as claimed, a clean record listed as a control, a misspelt name) and requires each to fail with
its own message.
"""
import os, re, subprocess, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(ROOT, "data/fs131/ma/MAAxioms.lean")
STANDARD = {"propext", "Classical.choice", "Quot.sound"}


def split_at_control(text):
    """The text above and from the one line that begins `-- CONTROL` (a mention of the marker inside a sentence is not it)."""
    marks = [m.start() for m in re.finditer(r"^-- CONTROL", text, flags=re.M)]
    if len(marks) != 1:
        raise SystemExit(f"FAIL: {len(marks)} lines begin `-- CONTROL` in the list; exactly one must")
    return text[:marks[0]], text[marks[0]:]


def check(src, say=print):
    text = open(src).read()
    head, tail = split_at_control(text)
    claimed = re.findall(r"^#print axioms (\S+)", head, flags=re.M)
    controls = re.findall(r"^#print axioms (\S+)", tail, flags=re.M)
    proc = subprocess.run(["lake", "env", "lean", "-DautoImplicit=false", "-DrelaxedAutoImplicit=false", src],
                          cwd=ROOT, capture_output=True, text=True)
    out = proc.stdout + proc.stderr
    answers = {}
    for m in re.finditer(r"'([^']+)' depends on axioms: \[([^\]]*)\]", out):
        answers[m.group(1)] = {a.strip() for a in m.group(2).replace("\n", " ").split(",") if a.strip()}
    for m in re.finditer(r"'([^']+)' does not depend on any axioms", out):
        answers[m.group(1)] = set()
    bad = 0
    errors = [l for l in out.split("\n") if "error" in l]
    for l in errors:
        say(f"LEAN ERROR: {l}")
    bad += len(errors)
    clean = 0
    for name in claimed:
        if name not in answers:
            say(f"MISSING  {name}: no answer")
            bad += 1
            continue
        extra = answers[name] - STANDARD
        if extra:
            say(f"NOT CLEAN  {name}: {sorted(extra)}")
            bad += 1
        else:
            clean += 1
            say(f"clean  {name}: {sorted(answers[name])}")
    fired = 0
    for name in controls:
        if name in answers and "sorryAx" in answers[name]:
            fired += 1
            say(f"control fires  {name}: sorryAx seen")
        else:
            say(f"CONTROL SILENT  {name}: {sorted(answers.get(name, ['no answer']))}")
            bad += 1
    if len(answers) != len(set(claimed) | set(controls)):
        say(f"COUNT MISMATCH: {len(answers)} answers for {len(set(claimed) | set(controls))} distinct names")
        bad += 1
    if len(set(claimed)) != len(claimed):
        say("A NAME IS LISTED TWICE among the claimed records")
        bad += 1
    if not controls:
        say("NO CONTROL LISTED: the print has nothing that must go red")
        bad += 1
    say(f"RESULT: {clean} of {len(claimed)} claimed records on the standard three; {fired} of {len(controls)} controls fire; "
          f"{bad} problem(s) -> {'PASS' if not bad else 'FAIL'}")
    return bad


def self_test():
    """Three planted faults, each in a copy of the list: a record resting on an open leaf listed as claimed; a clean record
    listed as a control; a misspelt name. Each must fail, with its own message."""
    import tempfile
    text = open(SRC).read()
    head, tail = split_at_control(text)
    sep = ""
    control = re.findall(r"^#print axioms (\S+)", tail, flags=re.M)[0]
    claimed = re.findall(r"^#print axioms (\S+)", head, flags=re.M)[0]
    plants = [
        ("an open record listed as claimed", head + f"#print axioms {control}\n" + sep + tail.replace(f"#print axioms {control}\n", "", 1), "NOT CLEAN"),
        ("a clean record listed as a control", head.replace(f"#print axioms {claimed}\n", "", 1) + sep + tail + f"#print axioms {claimed}\n", "CONTROL SILENT"),
        ("a misspelt name", head + "#print axioms HadwigerNelson.Plane.no_such_declaration_ma1\n" + sep + tail, "LEAN ERROR"),
    ]
    ok = True
    for what, planted, needle in plants:
        with tempfile.NamedTemporaryFile("w", suffix=".lean", dir=os.path.dirname(SRC), delete=False) as f:
            f.write(planted)
            tmp = f.name
        lines = []
        try:
            bad = check(tmp, say=lines.append)
        finally:
            os.unlink(tmp)
        fired = bad > 0 and any(needle in l for l in lines)
        print(f"self-test: {what}: {'fired' if fired else 'DID NOT FIRE'} ({needle})")
        ok = ok and fired
    print("self-test:", "OK" if ok else "FAIL")
    return ok


def main():
    if "--self-test" in sys.argv:
        sys.exit(0 if self_test() else 1)
    sys.exit(1 if check(SRC) else 0)




if __name__ == "__main__":
    main()
