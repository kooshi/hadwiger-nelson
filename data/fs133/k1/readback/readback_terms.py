#!/usr/bin/env python3
"""FS133-K1 — the read-back of `Outside/OAI158Rigidity`, symbol against symbol, across the two pins.

A wrapper over `tools/fs132_i1_readback.py` (FS132-I1's comparator, unchanged and imported as a module): the same
comparison of the kernel's stored terms — kind, universe parameters, type, value, constants named — with this job's
table of declarations and both of the release's namespaces mapped:

    OAI.PlaneFiveColor.Spectral.            <->  HadwigerNelson.Outside.OAI158.Spectral.            (written §S.)
    OAI.EuclideanFiveColor.                 <->  HadwigerNelson.Outside.OAI158.                     (written §.)

and with the Mathlib renames between the pins that `LEAN.md` records (v4.34.1 there, v4.32.0 here), applied to the
RELEASE's print only and listed in RENAMES below: nothing else is normalised.

  readback_terms.py RELEASE.out OURS.out            exit 0 only if all eight are IDENTICAL
  readback_terms.py RELEASE.out OURS.out --control  plants four faults in copies of OURS.out (a binder kind in the
        axiom, a dropped instance binder, a changed constant in a definition, a missing declaration) and requires
        each refused; exit 0 only if every plant is refused and the unplanted pair passes.
"""
import importlib.util
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parents[4]
spec = importlib.util.spec_from_file_location("rb", ROOT / "tools/fs132_i1_readback.py")
rb = importlib.util.module_from_spec(spec)
spec.loader.exec_module(rb)

PAIRS = [("OAI.PlaneFiveColor.Spectral.", "HadwigerNelson.Outside.OAI158.Spectral.", "§.Spectral."),
         ("OAI.EuclideanFiveColor.", "HadwigerNelson.Outside.OAI158.", "§.")]
# (name at the release's pin, name at this pin): Mathlib's renames between the pins, `LEAN.md` § Searching — Lean.
RENAMES = [("Set.ofPred", "setOf")]

rb.EXPECT = {
    "Spectral.E": ("def", "def"),
    "Spectral.K": ("def", "def"),
    "Spectral.DiscreteE": ("def", "def"),
    "Spectral.instCommGroupDiscreteE": ("def", "def"),
    "Spectral.kCoeff": ("def", "def"),
    "ContinuousVectors.op": ("def", "def"),
    "ContinuousVectors.space": ("def", "def"),
    "Spectral.residual_fourier": ("theorem", "axiom"),
}


def normalise(s: str) -> str:
    for a, b, to in PAIRS:
        s = s.replace(a, to).replace(b, to)
    return s


rb.normalise = normalise


def release_text(path):
    t = pathlib.Path(path).read_text()
    for there, here in RENAMES:
        t = re.sub(r"(?<![\w.])" + re.escape(there) + r"(?![\w.])", here, t)
    return t


def main():
    args = [a for a in sys.argv[1:] if a != "--control"]
    rel, our = release_text(args[0]), pathlib.Path(args[1]).read_text()
    if "--control" not in sys.argv:
        return rb.run_decls(rel, our, None)
    ax = "DUMP HadwigerNelson.Outside.OAI158.Spectral.residual_fourier"
    i = our.index(ax)
    head, tail = our[:i], our[i:]
    plants = {
        "the axiom's first explicit binder made implicit": head + tail.replace("(pi.d U ", "(pi.i U ", 1),
        "the axiom's first instance binder made explicit": head + tail.replace("(pi.c inst ", "(pi.d inst ", 1),
        "a constant changed in a definition (Circle for its unit sphere)": our.replace(
            "Submonoid.unitSphere", "Submonoid.unitBall", 1),
        "a declaration missing": our.replace("DUMP HadwigerNelson.Outside.OAI158.Spectral.kCoeff :",
                                             "DUMP HadwigerNelson.Outside.OAI158.Spectral.kCoeffX :", 1),
    }
    bad = 0
    for what, text in plants.items():
        if text == our:
            print(f"CONTROL NOT PLANTED: {what}"); bad += 1; continue
        rows, different, fatal = rb.compare_decls(rel, text)
        refused = bool(different or fatal)
        print(f"CONTROL {'refused' if refused else 'PASSED — A FAILURE'}: {what}: different={different} fatal={len(fatal)}")
        bad += 0 if refused else 1
    print("--- the unplanted pair:")
    rc = rb.run_decls(rel, our, None)
    return 1 if (bad or rc) else 0


sys.exit(main())
