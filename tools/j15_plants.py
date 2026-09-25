#!/usr/bin/env python3
"""J15 plants: watch `Proofs/HadwigerNelson/Transcendental.lean` go red for the right reason.

Each plant is one textual mutation of the module. The module is copied to `data/m2/j15/plants/`, mutated, and elaborated with
`lake env lean` under `scripts/slot.py` (the lakefile's options passed by hand). A plant PASSES (i.e. the check works) only if:
  * the faithful copy elaborates with no error (the pair's other half, run first: a red from the scaffolding shows up there);
  * the mutated copy fails to elaborate;
  * some error line falls inside the target declaration's line range in the mutated copy, and
  * that error's text contains the expected substring (the reason).
A plant whose mutation text is not found in the module is reported as UNREACHABLE and fails the run: a plant that cannot fire tests
nothing.

Usage: python3 tools/j15_plants.py              (exit 0 iff every plant passes)
       python3 tools/j15_plants.py --self-test  (the tool's own plant: a harmless mutation must NOT be scored red;
                                                 exit 0 iff the tool refuses to score it)
"""

import pathlib
import re
import shutil
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
MODULE = ROOT / "Proofs/HadwigerNelson/Transcendental.lean"
WORK = ROOT / "data/m2/j15/plants"
LEAN = ["scripts/slot.py", "--mem", "8", "--cpus", "4", "--", "lake", "env", "lean",
        "-Dlinter.missingDocs=true", "-DautoImplicit=false", "-DrelaxedAutoImplicit=false"]

# (name, target declaration name, old text, new text, expected substring in the error, why the red is the right one)
PLANTS = [
    ("PL1-formal-reality-removed",
     "chromaticNumber_unitQuadrance_ratFunc",
     "theorem chromaticNumber_unitQuadrance_ratFunc {F : Type*} [Field F] [IsFormallyReal F] :",
     "theorem chromaticNumber_unitQuadrance_ratFunc {F : Type*} [Field F] :",
     "IsFormallyReal",
     "the brief's plant: the one place formal reality enters is `1 + s² ≠ 0`, so without it the proof cannot be completed"),
    ("PL2-engine-hypothesis-vacuous",
     "chromaticNumber_unitQuadrance_ratFunc_of_one_add_sq_ne_zero",
     "    (hF : ∀ s : F, 1 + s ^ 2 ≠ 0) :\n    (unitQuadrance (RatFunc F)).chromaticNumber",
     "    (hF : ∀ s : F, 1 + s ^ 2 = 1 + s ^ 2) :\n    (unitQuadrance (RatFunc F)).chromaticNumber",
     "mismatch",
     "the engine's hypothesis replaced by a tautology: the valuation lemma's use of it must refuse"),
    ("PL3-hyperbola",
     "mem_valuationSubring_of_sq_add_sq_eq_one",
     "(hB : ∀ x ∈ B, 1 + x ^ 2 ∉ B.nonunits) {a b : K} (h : a ^ 2 + b ^ 2 = 1) : a ∈ B ∧ b ∈ B := by\n"
     "  have key : ∀ {a b : K}, a ^ 2 + b ^ 2 = 1 →",
     "(hB : ∀ x ∈ B, 1 + x ^ 2 ∉ B.nonunits) {a b : K} (h : a ^ 2 - b ^ 2 = 1) : a ∈ B ∧ b ∈ B := by\n"
     "  have key : ∀ {a b : K}, a ^ 2 - b ^ 2 = 1 →",
     "ring failed",
     "a² − b² = 1 has points with poles ((t + 1/t)/2, (t − 1/t)/2), so the planted statement is false; the red must come from the "
     "algebra step that used the circle, never from the scaffolding"),
    ("PL4-inverse-does-not-vanish",
     "inv_mem_zeroIntegral_of_not_mem",
     "    ∃ _ : f⁻¹ ∈ zeroIntegral F, RatFunc.eval (RingHom.id F) 0 f⁻¹ = 0 := by",
     "    ∃ _ : f⁻¹ ∈ zeroIntegral F, RatFunc.eval (RingHom.id F) 0 f⁻¹ = 1 := by",
     "unsolved goals",
     "false at f = 1/X (f⁻¹ = X vanishes at 0), so any proof must fail; the error must sit in the inverse lemma"),
]

ERR = re.compile(r"^[^:]+:(\d+):(\d+): error(.*)$")


def elaborate(path):
    rel = path.relative_to(ROOT)
    proc = subprocess.run(LEAN + [str(rel)], cwd=ROOT, capture_output=True, text=True)
    out = proc.stdout + proc.stderr
    if "slot: admitted" not in out:
        print(out)
        sys.exit("j15_plants: the slot did not admit the elaboration (exit %d); nothing was tested" % proc.returncode)
    errors = []
    lines = out.splitlines()
    for i, line in enumerate(lines):
        m = ERR.match(line)
        if m:
            text = "\n".join([line] + lines[i + 1:i + 6])
            errors.append((int(m.group(1)), text))
    return proc.returncode, errors, out


def decl_range(text, name):
    """1-based line range [start, end) of the declaration `name` in `text`."""
    lines = text.splitlines()
    start = None
    for i, line in enumerate(lines):
        if re.match(r"^(theorem|lemma|noncomputable def|def) " + re.escape(name) + r"\b", line):
            start = i + 1
            break
    if start is None:
        return None
    end = len(lines) + 1
    for j in range(start, len(lines)):
        if re.match(r"^(theorem|lemma|noncomputable def|def|/--|/-!|end |section|example)", lines[j]):
            end = j + 1
            break
    return (start, end)


HARMLESS = ("SELF-TEST-harmless",
            "chromaticNumber_unitQuadrance_ratFunc",
            "-- `F(t)` holds `F` and `t`.",
            "-- `F(t)` holds `F` and `t` (a harmless edit).",
            "IsFormallyReal",
            "a comment edit cannot make the module red; the tool must say so")


def main():
    global PLANTS
    self_test = "--self-test" in sys.argv[1:]
    if self_test:
        PLANTS = [HARMLESS]
    WORK.mkdir(parents=True, exist_ok=True)
    source = MODULE.read_text()
    faithful = WORK / "Faithful.lean"
    faithful.write_text(source)
    code, errors, out = elaborate(faithful)
    if code != 0 or errors:
        print(out)
        sys.exit("j15_plants: the FAITHFUL copy does not elaborate; every plant below would be red for the wrong reason")
    print("faithful copy: elaborates, no error")
    failures = 0
    for name, decl, old, new, expect, why in PLANTS:
        if source.count(old) != 1:
            print("%s: UNREACHABLE (mutation text found %d times)" % (name, source.count(old)))
            failures += 1
            continue
        mutated = source.replace(old, new)
        path = WORK / (name.replace("-", "_") + ".lean")
        path.write_text(mutated)
        rng = decl_range(mutated, decl)
        if rng is None:
            print("%s: UNREACHABLE (declaration %s not found)" % (name, decl))
            failures += 1
            continue
        code, errors, out = elaborate(path)
        inside = [(ln, t) for ln, t in errors if rng[0] <= ln < rng[1]]
        reasoned = [(ln, t) for ln, t in inside if expect in t]
        ok = code != 0 and bool(reasoned)
        status = "RED for the right reason" if ok else "NOT RED AS EXPECTED"
        print("%s: %s — %d error(s), %d inside %s (lines %d–%d), %d with %r" %
              (name, status, len(errors), len(inside), decl, rng[0], rng[1] - 1, len(reasoned), expect))
        if reasoned:
            print("    first: " + reasoned[0][1].splitlines()[0][:160])
        print("    why: " + why)
        if not ok:
            failures += 1
            print(out[:3000])
    shutil.rmtree(WORK)
    if self_test:
        if failures == 1:
            print("j15_plants --self-test: the harmless mutation was refused a red verdict, as it must be")
            return
        sys.exit("j15_plants --self-test: the tool scored a harmless mutation as red — it cannot tell")
    if failures:
        sys.exit("j15_plants: %d plant(s) did not go red for their reason" % failures)
    print("j15_plants: all %d plants red for their reason; faithful copy green" % len(PLANTS))


if __name__ == "__main__":
    main()
