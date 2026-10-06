#!/usr/bin/env python3
"""FS131-I6D: the axioms of this job's records, read on this branch (iteration evidence; the gate's audit is
`scripts/axioms.sh`, run at the join).

    python3 tools/fs131_i6d_axioms.py [--out data/fs131/i6d/logs/axioms-N.txt]

Reads the job's block in `scripts/Axioms.lean` (between the heading "FS131-I6D" and the PURCHASED banner), prints
`#print axioms` for each record through `lake env lean` on a scratch file, and classifies:

  CLEAN     — a subset of propext / Classical.choice / Quot.sound;
  UPSTREAM  — those and `sorryAx`, and nothing else.

On this branch `Curve`'s and `LocalGraph`'s leaves are `sorry` (another line's), so a record that reads one prints
`sorryAx`; a record in the list EXPECT_CLEAN must be CLEAN, and none of this job's own modules may contain the token
`sorry` (so every `sorryAx` is an upstream leaf's). Any other axiom fails.

Controls, in the same run: `IsUnitCurve.chord` (an upstream `sorry` leaf) must read UPSTREAM — the sorry detector
fires; `norm_sub_le_of_discs` (proved upstream) must read CLEAN; and a record of a name that does not exist must be
reported as an error, never passed over in silence.
"""
import re
import subprocess
import sys
import tempfile

STD = {"propext", "Classical.choice", "Quot.sound"}
OWN_MODULES = [
    "Proofs/HadwigerNelson/Plane/Saturated/CurveArc.lean",
    "Proofs/HadwigerNelson/Plane/Saturated/ArcContinuation.lean",
    "Proofs/HadwigerNelson/Plane/Saturated/FanArcs.lean",
    "Proofs/HadwigerNelson/Plane/Saturated/FanBuild.lean",
]
EXPECT_CLEAN = {
    "HadwigerNelson.Plane.IsUnitCurve.affine",
    "HadwigerNelson.Plane.IsUnitCurve.dist_le",
    "HadwigerNelson.Plane.isUnitCurve_angleCurve",
    "HadwigerNelson.Plane.IsUnitCurve.eqOn_angleCurve",
    "HadwigerNelson.Plane.eq_affine_of_sin_bounds",
}
CONTROL_UPSTREAM = "HadwigerNelson.Plane.IsUnitCurve.chord"
CONTROL_CLEAN = "HadwigerNelson.Plane.norm_sub_le_of_discs"
CONTROL_MISSING = "HadwigerNelson.Plane.fs131_i6d_no_such_declaration"


def block_records():
    text = open("scripts/Axioms.lean").read()
    start = text.index("## FS131-I6D")
    end = text.index('#eval IO.println "=== PURCHASED ==="')
    return re.findall(r"^#print axioms (\S+)$", text[start:end], flags=re.M)


def run(names):
    src = "import Proofs\nset_option pp.fullNames true\n" + "".join(f"#print axioms {n}\n" for n in names)
    with tempfile.NamedTemporaryFile("w", suffix=".lean", delete=False) as f:
        f.write(src)
        path = f.name
    out = subprocess.run(["lake", "env", "lean", path], capture_output=True, text=True)
    return out.stdout + out.stderr


def parse(output):
    """name -> set of axioms, or None for 'does not depend on any axioms'; errors -> list."""
    res, errors = {}, []
    flat = re.sub(r"\n\s+", " ", output)
    for line in flat.split("\n"):
        m = re.match(r"'(\S+)' depends on axioms: \[(.*)\]", line)
        if m:
            res[m.group(1)] = {a.strip() for a in m.group(2).split(",")}
            continue
        m = re.match(r"'(\S+)' does not depend on any axioms", line)
        if m:
            res[m.group(1)] = set()
            continue
        if "error" in line:
            errors.append(line)
    return res, errors


def classify(axs):
    if axs <= STD:
        return "CLEAN"
    if axs <= STD | {"sorryAx"}:
        return "UPSTREAM"
    return "OTHER"


def main():
    out_path = sys.argv[sys.argv.index("--out") + 1] if "--out" in sys.argv else None
    names = block_records()
    res, errors = parse(run(names + [CONTROL_UPSTREAM, CONTROL_CLEAN, CONTROL_MISSING]))
    lines, fails = [], 0
    for path in OWN_MODULES:
        try:
            n = len(re.findall(r"\bsorry\b", open(path).read()))
        except FileNotFoundError:
            lines.append(f"note   {path}: not on disk yet")
            continue
        lines.append(f"{'ok  ' if n == 0 else 'FAIL'}   {path}: {n} `sorry` token(s)")
        fails += n != 0
    counts = {"CLEAN": 0, "UPSTREAM": 0}
    for n in names:
        if n not in res:
            lines.append(f"FAIL   {n}: no print (missing declaration?)")
            fails += 1
            continue
        cls = classify(res[n])
        if cls == "OTHER" or (n in EXPECT_CLEAN and cls != "CLEAN"):
            fails += 1
            lines.append(f"FAIL   {cls:8} {n}: {sorted(res[n])}")
        else:
            counts[cls] += 1
            lines.append(f"{cls:8} {n}: {sorted(res[n])}")
    c1 = res.get(CONTROL_UPSTREAM) is not None and classify(res[CONTROL_UPSTREAM]) == "UPSTREAM"
    c2 = res.get(CONTROL_CLEAN) is not None and classify(res[CONTROL_CLEAN]) == "CLEAN"
    c3 = CONTROL_MISSING not in res and any(CONTROL_MISSING.split(".")[-1] in e for e in errors)
    lines.append(f"control (an upstream sorry leaf reads sorryAx): {'fires' if c1 else 'DID NOT FIRE'}")
    lines.append(f"control (a proved upstream lemma reads clean): {'passes, as it must' if c2 else 'FAILED'}")
    lines.append(f"control (a missing declaration is an error): {'fires' if c3 else 'DID NOT FIRE'}")
    other_errors = [e for e in errors if CONTROL_MISSING.split(".")[-1] not in e]
    for e in other_errors:
        lines.append(f"FAIL   lean error: {e[:200]}")
    fails += (not c1) + (not c2) + (not c3) + len(other_errors)
    lines.append(f"records {len(names)}: clean {counts['CLEAN']}, resting on upstream sorry leaves {counts['UPSTREAM']}; "
                 + ("OK" if fails == 0 else f"{fails} FAILURE(S)"))
    text = "\n".join(lines)
    print(text)
    if out_path:
        open(out_path, "w").write(text + "\n")
    sys.exit(0 if fails == 0 else 1)


if __name__ == "__main__":
    main()
