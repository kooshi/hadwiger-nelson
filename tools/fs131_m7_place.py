#!/usr/bin/env python3
"""FS131-M7: place the arc step's last lines into `Procedure.lean` from the text FS131-IA2 compiled, and check they are that text.

The source of every proof line is `data/fs131/ia2/ProcedureLastLines.lean` (FS131-IA2's scratch file, which elaborated against
`Procedure` and `ArcStep`), copied by this script, never retyped:
  * W5: the block from the docstring of `IsMaxRingArc.meet` to the end of its proof, placed after `IsMaxRingArc.not_regularAt`;
  * `exists_arcStep`'s proof: the lines between `-- BEGIN last lines` and `-- END last lines`, with the scratch stand-in
    `bend_away_part_weak` replaced by `bend_away_part` (it must occur exactly once), placed where the `sorry` stood.
The docstring of `exists_arcStep` is the one in FS131-IA2's report (`data/fs131/reports/FS131-IA2.md`, the `lean` block that opens
`/-- **The arc step** (a collar bend`), with the inhabitant note of the docstring it replaces kept as its last sentence (DOC_TAIL).
The import of `Plane/ValidMap/ArcStep` goes after `Procedure`'s last import. The module docstring's two passages about the arc step
are replaced (MODDOC). The STATEMENT of `exists_arcStep` is not written by this script: `--apply` and `--check` both require the
text between `theorem exists_arcStep` and its `:= by` to equal the scratch file's `exists_arcStep'` statement, name apart.

Every anchor must occur EXACTLY once, or the tool exits 1 naming it.

  python3 tools/fs131_m7_place.py --apply       # edit Procedure.lean in place (refuses if the lines are already placed)
  python3 tools/fs131_m7_place.py --check       # Procedure.lean holds exactly the compiled text; exit 0 only then
  python3 tools/fs131_m7_place.py --self-test   # after --apply: six plants on Procedure's text, each must fail --check's test
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PROC = ROOT / "Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean"
SCRATCH = ROOT / "data/fs131/ia2/ProcedureLastLines.lean"
REPORT = ROOT / "data/fs131/reports/FS131-IA2.md"

IMPORT_ANCHOR = "import Proofs.HadwigerNelson.Plane.ValidMap.FlankUA\n"
IMPORT_LINE = "import Proofs.HadwigerNelson.Plane.ValidMap.ArcStep\n"
DOC_TAIL = ("\nInhabitant: no Lean model on file; `l60Frag` cleaned, its whole arc, at [hand] (FS131-QA4 § 6.2, rank 7). -/\n")
MODDOC = [
    ("or an **arc step** (a\n"
     "toward or away bend of a maximal bad unit arc, then cleaned: the point's count of maximal bad arcs drops, `exists_arcStep`). A site is\n",
     "or an **arc step** (a\n"
     "toward or away collar bend of a maximal bad unit arc, uncleaned — the bent map of a clean map is clean: the point's count of maximal\n"
     "bad arcs drops, `exists_arcStep`). A site is\n"),
    ("**Where the steps' proofs live** (inventory items 371–372, 411): `exists_vertexStep` and `exists_arcStep` read the moves' constructions —\n"
     "`Moves` (`exists_shave_aux`, `exists_rayMerge_aux` through `Near.move`), `MergeMove` (`exists_merge_aux`), `OpenMove` (`exists_open`) and\n"
     "`UnitArc` (`bend_toward`, `bend_away_whole`, the N2-TAN bend) — each cleaned with its colour kept (`cleanKeep`, `LocalStep.cleanKeep`:\n"
     "`ArcMap.clean` itself is no local step, its colour function being a choice on the arcs); they are stated here and are open until\n"
     "proved from those constructions (the plan's § 3.3; new declarations downstream only). A move's surgery is a local step on its closed\n"
     "ball (`surgery_localStep`).\n",
     "**Where the steps' proofs live** (inventory items 371–372, 411, 447–450): `exists_vertexStep` reads the moves' constructions —\n"
     "`Moves` (`exists_shave_aux`, `exists_rayMerge_aux` through `Near.move`), `MergeMove` (`exists_merge_aux`) and `OpenMove` (`exists_open`) —\n"
     "each cleaned with its colour kept (`cleanKeep`, `LocalStep.cleanKeep`: `ArcMap.clean` itself is no local step, its colour function\n"
     "being a choice on the arcs); a move's surgery is a local step on its closed ball (`surgery_localStep`). `exists_arcStep` reads a\n"
     "collar bend, uncleaned, through the interface of `Plane/ValidMap/ArcStep` (`ArcBend`: the toward bend `exists_arcBend_toward`; the\n"
     "away bend `bend_away_part` of `Plane/ValidMap/BendStep`, with `ArcBend.of_away`) — not `UnitArc`'s bends. Both steps are proved here\n"
     "from those constructions (the plan's § 3.3; new declarations downstream only).\n"),
]
W5_AFTER = "theorem IsMaxRingArc.not_regularAt "
STMT = re.compile(r"^theorem exists_arcStep('?) (.*?) := by\n", re.S | re.M)
OLD_DOC = re.compile(r"/-- \*\*The arc step\*\* \(a bend of a maximal bad unit arc, then `exists_clean`\).*?-/\n(?=theorem exists_arcStep )", re.S)
NEW_DOC = re.compile(r"/-- \*\*The arc step\*\* \(a collar bend of a maximal bad unit arc;.*?-/\n", re.S)


def once(text, pat, what):
    n = text.count(pat)
    if n != 1:
        raise SystemExit(f"FAIL: {what} occurs {n} times, must occur once: {pat.splitlines()[0][:80]!r}")


def pieces():
    """(W5 block, proof lines, docstring, the scratch statement) from FS131-IA2's files."""
    s = SCRATCH.read_text()
    a = "/-- **A ring arc about `P` whose open arc meets a maximal ring arc's has its sides and lies in it**"
    b = "/-! ## The last lines: `exists_arcStep`, repaired statement (record § 3.6) -/"
    once(s, a, "W5's docstring in the scratch file")
    once(s, b, "the header after W5 in the scratch file")
    w5 = s[s.index(a):s.index(b)].rstrip("\n") + "\n"
    once(s, "  -- BEGIN last lines\n", "BEGIN marker")
    once(s, "  -- END last lines\n", "END marker")
    proof = s[s.index("  -- BEGIN last lines\n") + len("  -- BEGIN last lines\n"):s.index("  -- END last lines\n")]
    once(proof, "bend_away_part_weak", "the stand-in's name in the scratch proof")
    proof = proof.replace("bend_away_part_weak", "bend_away_part")
    m = STMT.search(s)
    if not m or m.group(1) != "'":
        raise SystemExit("FAIL: the scratch statement `exists_arcStep'` not found")
    r = REPORT.read_text()
    docs = NEW_DOC.findall(r)
    if len(docs) != 1:
        raise SystemExit(f"FAIL: the report holds {len(docs)} docstrings opening '**The arc step** (a collar bend', must hold one")
    doc = docs[0]
    if not doc.endswith(" -/\n"):
        raise SystemExit("FAIL: the report's docstring does not end ' -/'")
    doc = doc[:-len(" -/\n")] + DOC_TAIL
    return w5, proof, doc, m.group(2)


def apply(t):
    w5, proof, doc, stmt = pieces()
    if IMPORT_LINE in t or "theorem IsMaxRingArc.meet " in t:
        raise SystemExit("FAIL: the lines are already placed (the import or IsMaxRingArc.meet is present)")
    once(t, IMPORT_ANCHOR, "the import anchor")
    t = t.replace(IMPORT_ANCHOR, IMPORT_ANCHOR + IMPORT_LINE)
    for old, new in MODDOC:
        once(t, old, "a module-docstring passage")
        t = t.replace(old, new)
    once(t, W5_AFTER, "the theorem W5 follows")
    i = t.index(W5_AFTER)
    j = t.index("\n\n", i)  # the blank line that ends `IsMaxRingArc.not_regularAt`'s proof
    t = t[:j + 2] + w5 + "\n" + t[j + 2:]
    m = STMT.search(t)
    if not m or m.group(1) != "" or len(STMT.findall(t)) != 1:
        raise SystemExit("FAIL: `theorem exists_arcStep … := by` not found exactly once in Procedure.lean")
    if m.group(2) != stmt:
        raise SystemExit("FAIL: Procedure's statement of exists_arcStep is not the scratch file's exists_arcStep'")
    if not t[m.end():].startswith("  sorry\n\n"):
        raise SystemExit("FAIL: exists_arcStep's body is not the single `sorry`")
    t = t[:m.end()] + proof + t[m.end() + len("  sorry\n"):]
    if len(OLD_DOC.findall(t)) != 1:
        raise SystemExit("FAIL: exists_arcStep's old docstring not found exactly once")
    t = OLD_DOC.sub(lambda _: doc, t)
    return t


def check(t):
    """Failure lines; empty when Procedure's text holds exactly the compiled text."""
    w5, proof, doc, stmt = pieces()
    bad = []
    if t.count(IMPORT_LINE) != 1:
        bad.append(f"the import of ArcStep occurs {t.count(IMPORT_LINE)} times")
    if t.count(w5) != 1:
        bad.append("W5 (`IsMaxRingArc.meet`, docstring and proof) is not in Procedure.lean byte for byte as compiled")
    ms = list(STMT.finditer(t))
    if len(ms) != 1 or ms[0].group(1) != "":
        bad.append("`theorem exists_arcStep … := by` not found exactly once")
    else:
        m = ms[0]
        if m.group(2) != stmt:
            bad.append("the statement of exists_arcStep is not the one the proof was compiled against")
        if not t[m.end():].startswith(proof + "\n"):
            bad.append("exists_arcStep's proof is not the compiled lines (BEGIN..END, `bend_away_part` for the stand-in)")
        if not t[:m.start()].endswith(doc):
            bad.append("exists_arcStep's docstring is not the report's (with the inhabitant note)")
    for old, new in MODDOC:
        if t.count(new) != 1 or old in t:
            bad.append(f"module docstring: the passage opening {new.splitlines()[0][:50]!r} is not in place")
    code = re.sub(r"/-.*?-/", "", t, flags=re.S)
    code = re.sub(r"--[^\n]*", "", code)
    n = len(re.findall(r"\bsorry\b", code))
    if n:
        bad.append(f"{n} `sorry` token(s) outside comments")
    return bad


def main():
    t = PROC.read_text()
    if "--apply" in sys.argv:
        new = apply(t)
        bad = check(new)
        if bad:
            raise SystemExit("FAIL after placing (nothing written): " + "; ".join(bad))
        PROC.write_text(new)
        print(f"placed: {len(new.splitlines()) - len(t.splitlines())} lines added to {PROC.relative_to(ROOT)}")
        return
    bad = check(t)
    if "--self-test" not in sys.argv:
        for b in bad:
            print("FAIL", b)
        print("RESULT:", "PASS — Procedure.lean holds the compiled text" if not bad else f"FAIL ({len(bad)})")
        sys.exit(1 if bad else 0)
    print("unplanted:", "PASS" if not bad else f"FAIL {bad}")
    plants = {
        "a token of the proof changed": ("hB.maxBad_other hF hc hε1.le hQP hcol", "hB.maxBad_other hF hc hε1.le hQP hcol.symm"),
        "a token of W5's proof changed": ("obtain ⟨hcd, hcd'⟩ := hmax.1.sides_eq hD' hθ hθ'", "obtain ⟨hcd, hcd'⟩ := hmax.1.sides_eq hD' hθ' hθ"),
        "the statement changed (the withdrawn degree clause back)":
            ("      (∀ x ∈ T, ∀ m, F.HasDegree x m → ∃ m' ≤ m, F'.HasDegree x m') ∧\n      (∀ x j, F.HasHornCount x j → ∃ j' ≤ j, F'.HasHornCount x j') ∧\n      ∀ Q ∈ T, Q ≠ P →",
             "      (∀ x m, F.HasDegree x m → F'.HasDegree x m) ∧\n      (∀ x j, F.HasHornCount x j → ∃ j' ≤ j, F'.HasHornCount x j') ∧\n      ∀ Q ∈ T, Q ≠ P →"),
        "a sorry in a proof": ("  obtain ⟨ε, hε0, hεδ, hε1, hεT⟩ := exists_arcStep_radius hT P θ₁ θ₂ hδ\n", "  sorry\n"),
        "the import dropped": (IMPORT_LINE, ""),
        "the docstring's inhabitant note dropped": (DOC_TAIL, " -/\n"),
    }
    ok = not bad
    for name, (old, new) in plants.items():
        if t.count(old) != 1:
            raise SystemExit(f"PLANT TARGET occurs {t.count(old)} times in Procedure.lean: {old[:60]!r}")
        b2 = check(t.replace(old, new, 1))
        print(f"plant — {name}: {'FIRED' if b2 else 'DID NOT FIRE'}  {b2[:1]}")
        ok = ok and bool(b2)
    print("SELF-TEST:", "every plant fired, the unplanted run passed" if ok else "FAILED")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
