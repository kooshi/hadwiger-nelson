#!/usr/bin/env python3
"""FS133-IA1 — no statement and no definition of this job's two hand-written modules changed while their proofs were
written (`Outside/OAI158Rigidity`, `Plane/OneClass/Field`; the third file, `Outside/OAI158Transfer`, is generated and
new, and its statements are compared with the release's by `tools/fs133_ia1_readback_port.py`).

Two comparisons, both must hold (exit 0), each with a planted fault that must be reported (`--control`):

1. The kernel's side.  `before` and `after` are two outputs of `data/fs133/ia1/lean/StatementDump.lean` (every
   constant stored in the compiled data of the two modules: kind, full name, stored type, and for a definition its
   stored value).  Every constant of `before` that is not INTERNAL (a name Lean generates inside a declaration) must be
   in `after` with the same kind, the same type and, for a definition, the same value, character for character.
   Constants only in `after` are listed as NEW: the helpers.  INTERNAL constants are counted, not compared: they move
   with a proof.  The declared `axiom` is named and required: it must be in both dumps, an AXIOM in both, with one
   type.

2. The file's side, for what the environment does not keep: an `example` is elaborated and discarded, so its statement
   is compared as text — each `example` head (from the keyword to its `:=`), whitespace-normalized: every head of the
   base commit's file (`git show <base>:<path>`) must be in the working file, in the base's order.  A head only in the
   working file is an example this job added; it is listed as NEW EXAMPLE.  (At the base the two files hold no
   example; the count is printed, so that "none" is a reading and not a silence.)

Usage:  fs133_ia1_statements.py <before.txt> <after.txt> <base-commit> [--control]
What this does not see: a change to a docstring or a comment (not a statement).
(FS124-I3's reader, `data/fs124/i3/statement_diff.py`, for this job's modules.)
"""
import lzma
import pathlib
import re
import subprocess
import sys

FILES = ["Proofs/HadwigerNelson/Outside/OAI158Rigidity.lean", "Proofs/HadwigerNelson/Plane/OneClass/Field.lean"]
ROOT = pathlib.Path(__file__).resolve().parents[1]
AXIOM = "HadwigerNelson.Outside.OAI158.Spectral.residual_fourier"
# the skeleton's leaves and the declared statements this job must leave as they are (each must be found in both dumps:
# a dump that lacks one is a broken dump, never a pass)
REQUIRED = [
    AXIOM,
    "HadwigerNelson.Outside.OAI158.Spectral.residual_fourier_cross",
    "HadwigerNelson.Outside.OAI158.Spectral.residual_fourier_model",
    "HadwigerNelson.OneClass.exists_field",
    "HadwigerNelson.Outside.OAI158.Spectral.E",
    "HadwigerNelson.Outside.OAI158.Spectral.K",
    "HadwigerNelson.Outside.OAI158.Spectral.DiscreteE",
    "HadwigerNelson.Outside.OAI158.Spectral.kCoeff",
    "HadwigerNelson.Outside.OAI158.ContinuousVectors.op",
    "HadwigerNelson.Outside.OAI158.ContinuousVectors.space",
]


def read_dump(path):
    out, cur = {}, None
    path = pathlib.Path(path)
    text = lzma.open(path, "rt", encoding="utf-8").read() if path.suffix == ".xz" else path.read_text()
    for ln in text.splitlines():
        if ln.startswith("@@ "):
            parts = ln.split(" ")
            cur = {"kind": parts[1], "internal": parts[-1] == "INTERNAL", "type": None, "value": None}
            name = " ".join(parts[2:-1] if cur["internal"] else parts[2:])
            if name in out:
                print(f"DUPLICATE NAME IN DUMP {path}: {name}")
                sys.exit(2)
            out[name] = cur
        elif ln.startswith("TYPE ") and cur is not None:
            cur["type"] = ln[5:]
        elif ln.startswith("VALUE ") and cur is not None:
            cur["value"] = ln[6:]
    if not out:
        print(f"EMPTY DUMP: {path} — the reader or the dumper is broken")
        sys.exit(2)
    return out


def example_heads(text):
    """every `example` head: from the keyword at the start of a line to the first ` :=` (the statement, as text)"""
    heads = []
    text = re.sub(r"/-.*?-/", lambda m: re.sub(r"[^\n]", " ", m.group(0)), text, flags=re.S)
    for m in re.finditer(r"^example\b", text, flags=re.M):
        j = text.index(":=", m.start())
        heads.append(re.sub(r"\s+", " ", text[m.start():j]).strip())
    return heads


def main():
    control = "--control" in sys.argv
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    before, after, base = read_dump(args[0]), read_dump(args[1]), args[2]
    bad = []

    for name in REQUIRED:
        for label, d in (("first", before), ("second", after)):
            if name not in d:
                print(f"BROKEN DUMP: {name} is not in the {label} dump")
                sys.exit(2)

    if control:
        # plant 1: one character of the field theorem's stored statement changed in `after`
        victim = "HadwigerNelson.OneClass.exists_field"
        t = after[victim]["type"]
        i = t.index("Measurable")
        after[victim]["type"] = t[:i] + "Measurible" + t[i + 10:]
        # plant 2: one definition's value changed in `after`
        vdef = "HadwigerNelson.Outside.OAI158.Spectral.kCoeff"
        after[vdef]["value"] = after[vdef]["value"] + " x"
        # plant 3: the declared axiom's statement changed by one character in `after`
        t = after[AXIOM]["type"]
        i = t.index("kCoeff")
        after[AXIOM]["type"] = t[:i] + "kCoefg" + t[i + 6:]
        # plant 4: the declared axiom become a theorem
        # (applied to a copy of the kind after plant 3 is counted: both are reported, as two lines)
        after[AXIOM]["kind"] = "THM"
        # plant 5: a leaf's statement gone from `after`
        del after["HadwigerNelson.Outside.OAI158.Spectral.residual_fourier_model"]

    n_cmp = 0
    for name, b in before.items():
        if b["internal"]:
            continue
        n_cmp += 1
        a = after.get(name)
        if a is None:
            bad.append(f"MISSING  {b['kind']} {name}: in the first dump, not in the second")
            continue
        if a["kind"] != b["kind"]:
            bad.append(f"KIND     {name}: {b['kind']} -> {a['kind']}")
        if a["type"] != b["type"]:
            bad.append(f"TYPE     {b['kind']} {name}: the stored statement differs")
        if b["kind"] == "DEF" and a["value"] != b["value"]:
            bad.append(f"VALUE    DEF {name}: the stored definition differs")
    if not control and (before[AXIOM]["kind"] != "AXIOM" or after[AXIOM]["kind"] != "AXIOM"):
        bad.append(f"AXIOM    {AXIOM}: not an axiom in both dumps")
    axioms_after = sorted(n for n, a in after.items() if a["kind"] == "AXIOM")
    axioms_before = sorted(n for n, b in before.items() if b["kind"] == "AXIOM")
    if not control and axioms_after != axioms_before:
        bad.append(f"AXIOMS   the modules' axioms moved: {axioms_before} -> {axioms_after}")
    new = sorted(n for n, a in after.items() if n not in before and not a["internal"])
    n_int_b = sum(1 for b in before.values() if b["internal"])
    n_int_a = sum(1 for a in after.values() if a["internal"])

    n_ex = 0
    added = []
    for f in FILES:
        old = subprocess.run(["git", "show", f"{base}:{f}"], cwd=ROOT, capture_output=True, text=True, check=True).stdout
        new_text = (ROOT / f).read_text()
        ho, hn = example_heads(old), example_heads(new_text)
        pos = 0
        for k, x in enumerate(ho):
            n_ex += 1
            try:
                pos = hn.index(x, pos) + 1
            except ValueError:
                bad.append(f"EXAMPLE  {f} #{k + 1}: its statement is not in the working file (in order)\n    was: {x[:160]}")
        for y in hn:
            if y not in ho:
                added.append(f"  NEW EXAMPLE {f}: {y[:150]}")

    print(f"compared: {n_cmp} named constants of the first dump (types; values of definitions), {n_ex} example heads "
          f"of the base files")
    print(f"axioms of the two modules: {axioms_before} before, {axioms_after} after")
    print(f"internal (not compared): {n_int_b} before, {n_int_a} after")
    print(f"new named constants in the second dump: {len(new)}")
    for n in new:
        print(f"  NEW {after[n]['kind']} {n}")
    print(f"examples in the working files that the base does not hold: {len(added)}")
    for a in added:
        print(a)
    for b in bad:
        print(b)
    if control:
        want = 5
        ok = len(bad) == want
        print(f"CONTROL: {len(bad)} of {want} planted faults reported — "
              f"{'the check can fail' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
        sys.exit(0 if ok else 1)
    print("PASS: no statement and no definition changed" if not bad else f"FAIL: {len(bad)} difference(s)")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
