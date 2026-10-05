#!/usr/bin/env python3
"""FS131-I2i: list wave 2's public theorems with no docstring (inventory item 144 (d)).

Wave 2's files are its ten modules and three foundation modules as the brief's `touches:` names them (`WAVE2`); each file is read with `git show <ref>:<path>` and parsed by `fs131_qa1_decls.parse`
(not edited). A theorem or lemma that is not `private` and has no `/-- … -/` docstring is listed as `path:line name`.
Exit status: 0 when none is listed, 1 when some are (a gate a docstring pass must turn green), 2 on a broken read.

Usage: fs131_i2_docs.py [<ref>]        (default HEAD)
       fs131_i2_docs.py --self-test    a planted undocumented theorem must be listed, a documented one must not
"""
import importlib.util
import subprocess
import sys

HERE = __file__.rsplit("/", 1)[0]


def _load(name, fn):
    spec = importlib.util.spec_from_file_location(name, f"{HERE}/{fn}")
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m


D = _load("decls", "fs131_qa1_decls.py")

# Wave 2's modules and its foundation, as brief FS131-I2i's `touches:` names them.
WAVE2 = [f"Proofs/HadwigerNelson/{m}.lean" for m in (
    "Plane/MaximalCover", "Plane/Slack", "Plane/Stationary", "Plane/FalconerReduction", "Plane/YesLimit",
    "Plane/CoverExamples", "Arith/PlaceHom", "Arith/FalconerField", "Arith/Dyadic", "Instances/FalconerOrbit",
    "Plane/Cover", "Plane/Suprema", "Plane/CPColouring")]


def undocumented(text):
    out = []
    for d in D.parse(text):
        if d["kind"] in ("theorem", "lemma") and not d["has_doc"] and "private" not in d.get("sig", "").split(d["kind"])[0]:
            out.append((d["line"], d["name"]))
    return out


def report(ref):
    files = WAVE2
    if not files:
        print("BROKEN: no wave-2 files found — the diff read nothing")
        return 2
    total = 0
    for p in files:
        text = D.git_show(ref, p)
        if text is None:
            print(f"BROKEN: {p} unreadable at {ref}")
            return 2
        for line, name in undocumented(text):
            print(f"{p}:{line} {name}")
            total += 1
    print(f"== {total} undocumented wave-2 theorems in {len(files)} files at {ref}")
    return 1 if total else 0


def self_test():
    planted = "theorem planted_undoc (n : Nat) : n = n := rfl\n\n/-- Documented. -/\ntheorem planted_doc (n : Nat) : n = n := rfl\n"
    got = [n for _, n in undocumented(planted)]
    ok = got == ["planted_undoc"]
    print("self-test:", "PASS" if ok else f"FAIL (listed {got})")
    return 0 if ok else 1


if __name__ == "__main__":
    if sys.argv[1:] == ["--self-test"]:
        sys.exit(self_test())
    sys.exit(report(sys.argv[1] if len(sys.argv) > 1 else "HEAD"))
