#!/usr/bin/env python3
"""FS131-KN7 (the method of FS131-KN6, inventory item 717): scratch copies of files of the outside release for a trial elaboration at this
library's pin, and the scan that must pass before a copy is elaborated.

  make <release lean root> <outdir>      write <outdir>/<bundle>.lean for every bundle below: the named source files (or
                                         line ranges of them), their `import` lines removed, concatenated under one
                                         `import Mathlib`; then the patches of PATCHES for that bundle, each of which must
                                         match.  Prints, per bundle, its sources, line count and the patches applied by kind.
  scan <copy.lean> [--plant]             search the copy for anything that runs code while a file elaborates — `#eval`,
                                         `run_cmd`, `run_elab`, `run_meta`, `initialize`, `unsafe`, `IO.`, and a `macro`,
                                         `elab`, `syntax`, `macro_rules` or `elab_rules` declaration — and for any `import`
                                         other than the first line's `import Mathlib`.  Prints each hit with its line number
                                         and `hits=<n>`; exit 0 only when n = 0.  `--plant` appends `#eval (1 : Nat)` and a
                                         second import in memory and requires both to be reported (exit 0 iff both are).

The copies are NOT committed (the release's text travels with its licence only inside a port): <outdir> is under the
tree's ignored `build/`.  Nothing is written or run in the release's tree; run with `python3 -I`."""
import pathlib
import re
import sys

NT = "OAI/NumberTheory/"
WRAP_OPEN = ("namespace OAI\nnoncomputable section\nopen MeasureTheory Filter Set\n"
             "open scoped BigOperators Topology ENNReal Classical\nnamespace PrimeDegreePackets\n")
WRAP_CLOSE = "end PrimeDegreePackets\nend\nend OAI\n"
# bundle -> list of (path under the root, None | [(first, last)] 1-based inclusive, wrapper or None)
PP = NT + "PrimePackets/"
BUNDLES = {
    # the ergodic decomposition in canonical form (`action_ergodic_decomposition`, ll. 127-177 of its file) and what it
    # reads in KernelEntropy (ll. 223-554: convex orbit approximants, the invariant sigma-algebra, the orbit average
    # limit, ergodicity from indicator limits); KernelEntropy ll. 48-219 (entropy of kernels) and ErgodicDecomposition
    # ll. 180-509 (the packet applications) are left out on purpose: the trial says whether that cut is enough.
    "ErgDecomp": [(PP + "KernelEntropy.lean", [(4, 47), (220, 558)], None),
                  (PP + "ErgodicDecomposition.lean", [(4, 179)], ("", "end\nend\n\nend OAI\n"))],
    # the entropy along a generating sequence (`measureEntropy_eq_iSup_generating`) with its whole declared cone, in
    # import order: eleven files, the first two of which are lane P's port
    "Generating": [(PP + f + ".lean", None, None) for f in [
        "ShannonEntropy", "EntropyMixtures", "ConditionalShannon", "ConditionalObservations", "ObservationRefinement",
        "ConditionalOrbitEntropy", "ObservationConditionalProbability", "ObservationSigmaAlgebra",
        "ConditionalProbabilityExpectation", "GeneratingObservationEntropy", "EntropyGeneratingSupremum"]],
}
# (bundle or "*", old, new, kind) — applied in order to the bundle's text; `old` must occur.
PATCHES = [
    ("*", "Set.ofPred_and", "Set.setOf_and", "a Mathlib rename between the pins (setOf became Set.ofPred, 2026-07-09)"),
    ("*", "Set.ofPred_mem_eq", "Set.setOf_mem_eq", "a Mathlib rename between the pins (setOf became Set.ofPred, 2026-07-09)"),
    ("*", "ite_eq_right ", "if_neg ", "a core rename between the pins (if_neg became ite_eq_right, 2026-07-21)"),
    ("*", "ite_eq_left ", "if_pos ", "a core rename between the pins (if_pos became ite_eq_left)"),
    ("*", "birkhoffSum_succ_apply'", "birkhoffSum_succ'", "a Mathlib rename between the pins (the pointwise lemma is birkhoffSum_succ' here)"),
    # FS131-KN7, trial 1 of ErgDecomp (each inside a proof, none in a statement):
    ("ErgDecomp", "Set.ofPred_forall", "Set.setOf_forall", "a Mathlib rename between the pins (setOf became Set.ofPred, 2026-07-09)"),
    ("ErgDecomp", "eventuallyEmptyOrUniv_iff", "eventuallyConst_set", "a Mathlib lemma of the later pin; here the set form of EventuallyConst, same disjuncts in the same order"),
    # FS131-KN7, trial 1 of Generating (each inside a simp list in a proof):
    ("Generating", "Set.mem_ofPred_eq", "Set.mem_setOf_eq", "a Mathlib rename between the pins (setOf became Set.ofPred, 2026-07-09)"),
    ("ErgDecomp", "Function.diag", "(fun y => (id y, id y))", "a Mathlib definition of the later pin; here compProd_trim_condExpKernel is stated with fun ω ↦ (id ω, id ω)"),
]

IMPORT = re.compile(r"^\s*(?:public\s+)?import\s")
HIT = [
    ("#eval", re.compile(r"#eval")),
    ("run_cmd/run_elab/run_meta", re.compile(r"\brun_(cmd|elab|meta)\b")),
    ("initialize", re.compile(r"\binitialize\b")),
    ("unsafe", re.compile(r"\bunsafe\b")),
    ("IO.", re.compile(r"\bIO\.")),
    ("macro/elab/syntax declaration",
     re.compile(r"^\s*(?:@\[[^\]]*\]\s*)?(?:(?:private|protected|local|scoped)\s+)*(?:macro|elab|syntax|macro_rules|elab_rules)\b")),
]


def body(path, ranges):
    lines = path.read_text().splitlines()
    if ranges is not None:
        out = []
        for a, b in ranges:
            out.extend(lines[a - 1:b])
            out.append("")
        return out
    return [l for l in lines if not IMPORT.match(l)]


def make(root, outdir):
    outdir.mkdir(parents=True, exist_ok=True)
    for name, parts in BUNDLES.items():
        text = ["import Mathlib", ""]
        for rel, ranges, wrap in parts:
            text.append(f"-- ==== FS131-KN7 scratch copy of {rel}" + (f" lines {ranges}" if ranges else "") + " ====")
            if wrap:
                text.extend(wrap[0].splitlines())
            src = (pathlib.Path(__file__).resolve().parent.parent / rel[5:]) if rel.startswith("ours:") else root / rel
            text.extend(body(src, ranges))
            if wrap:
                text.extend(wrap[1].splitlines())
            text.append("")
        s = "\n".join(text) + "\n"
        kinds = {}
        for b, old, new, kind in PATCHES:
            if b not in ("*", name):
                continue
            n = s.count(old)
            if n == 0:
                if b == name:
                    print(f"PATCH DID NOT MATCH in {name}: {old!r}")
                    return 1
                continue
            s = s.replace(old, new)
            kinds[kind] = kinds.get(kind, 0) + n
        (outdir / f"{name}.lean").write_text(s)
        print(f"{name}: {len(s.splitlines())} lines from {[p[0].split('/')[-1] for p in parts]}; patches by kind: {kinds or 'none'}")
    return 0


def scan(path, plant):
    lines = path.read_text().splitlines()
    if plant:
        lines = lines + ["#eval (1 : Nat)", "import Evil"]
    hits = []
    for i, l in enumerate(lines, 1):
        if IMPORT.match(l) and not (i == 1 and l.strip() == "import Mathlib"):
            hits.append((i, "import", l))
        for kind, rx in HIT:
            if rx.search(l):
                hits.append((i, kind, l))
    for i, kind, l in hits:
        print(f"HIT {path.name}:{i}: [{kind}] {l.strip()[:160]}")
    print(f"scanned {path.name}: lines={len(lines)} hits={len(hits)}")
    if plant:
        kinds = {k for _, k, _ in hits}
        ok = "#eval" in kinds and "import" in kinds
        print("control", "FIRED" if ok else "DID NOT FIRE")
        return 0 if ok else 1
    return 0 if not hits else 1


def main():
    a = sys.argv[1:]
    if a[:1] == ["make"]:
        return make(pathlib.Path(a[1]), pathlib.Path(a[2]))
    if a[:1] == ["scan"]:
        return scan(pathlib.Path(a[1]), "--plant" in a)
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main())
