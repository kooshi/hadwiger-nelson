#!/usr/bin/env python3
"""FS131-L10A: the named hypotheses each theorem of wave 10's first pass takes, read from its signature.

  tools/fs131_l10a_hyps.py [--self-test]        (from the worktree root)

For every theorem of the four first-pass files, the statement (keyword to first ` :=`) is split at its
first top-level colon into binders and conclusion. A *named hypothesis* is one of the planner's § 5.5
table: a binder whose type mentions `BochnerHerglotz`, `BochnerOn`, `OrderBound`, `MulStable`,
`NegCircle`, `StandingFloor`, `TargetFloor`, or whose name is `hRQ4`, `hRQ5` (RQ₄, RQ₅) or `hRow123`
(`Row123Chain`). Printed: one line per theorem that takes one (HYP), and one per theorem whose
conclusion IS one — a model or a producer (CONCL). A theorem that takes none is counted, not listed.

--self-test: a planted file with one theorem taking `BochnerOn` in a binder, one concluding it, one
mentioning it only in a docstring, must read HYP, CONCL and nothing.
"""
import importlib.util
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location("stm", os.path.join(HERE, "fs131_l10a_statements.py"))
stm = importlib.util.module_from_spec(spec)
spec.loader.exec_module(stm)

FILES = ["CharacterColouring", "SpectralInputs", "StationaryRatio", "StandingFive"]
TYPES = ["BochnerHerglotz", "BochnerOn", "OrderBound", "MulStable", "NegCircle", "StandingFloor", "TargetFloor"]
BINDER_NAMES = {"hRQ4": "RQ₄", "hRQ5": "RQ₅", "hRow123": "Row123Chain"}


def split(stmt):
    """(binder groups, conclusion) of a theorem statement."""
    m = re.match(r"\s*(?:@\[[^\]]*\]\s*)*(?:private |protected |noncomputable )*(?:theorem|lemma)\s+\S+", stmt)
    s = stmt[m.end():]
    groups, depth, start, i = [], 0, None, 0
    opens, closes = "([{⦃", ")]}⦄"
    while i < len(s):
        c = s[i]
        if c in opens:
            if depth == 0:
                start = i
            depth += 1
        elif c in closes:
            depth -= 1
            if depth == 0:
                groups.append(s[start:i + 1])
        elif c == ":" and depth == 0:
            return groups, s[i + 1:]
        i += 1
    return groups, ""


def classify(stmt):
    groups, concl = split(stmt)
    hyps = []
    for g in groups:
        inner = g[1:-1]
        bn = inner.split(":")[0].split()
        ty = inner.split(":", 1)[1] if ":" in inner else inner
        for t in TYPES:
            if re.search(r"(?<![\w.])(?:\w+\.)*" + t + r"\b", ty) or re.search(r"\." + t + r"\b", ty):
                hyps.append(t)
        for b in bn:
            if b in BINDER_NAMES:
                hyps.append(BINDER_NAMES[b])
    concl_is = [t for t in TYPES if re.match(r"\s*(?:\(?\w[\w. ()⊥:]*\)?\.)?" + t + r"\b", concl)
                or re.match(r"\s*\(.*\)\." + t + r"\b", concl)]
    return sorted(set(hyps)), concl_is


def run(texts, label):
    rows, n = [], 0
    for fname, text in texts:
        for qual, kind, doc, stmt, short in stm.chunks(text):
            if kind not in ("theorem", "lemma"):
                continue
            n += 1
            hyps, concl_is = classify(stmt)
            if hyps:
                rows.append(("HYP", fname, qual, hyps))
            if concl_is:
                rows.append(("CONCL", fname, qual, concl_is))
    for word, fname, qual, names in rows:
        print(f"{word:5s} {fname:19s} {qual.split('HadwigerNelson.')[-1]:60s} {', '.join(names)}")
    print(f"{label}: {n} theorems read; {sum(r[0] == 'HYP' for r in rows)} take a named hypothesis, "
          f"{sum(r[0] == 'CONCL' for r in rows)} conclude one")
    return rows


def main(argv):
    if argv == ["--self-test"]:
        planted = ("namespace HadwigerNelson.X\n\n"
                   "theorem a1 (t : T) (hB : BochnerOn t) : True := trivial\n\n"
                   "theorem b1 : BochnerOn (⊥ : T) := sorry\n\n"
                   "/-- mentions `BochnerOn` in its docstring only. -/\n"
                   "theorem c1 (x : Nat) : x = x := rfl\n\n"
                   "theorem d1 (I : Interface F) (hcirc : I.NegCircle) (hRQ4 : A ⊆ B) : True := trivial\n\n"
                   "end HadwigerNelson.X\n")
        rows = run([("planted", planted)], "self-test")
        got = {(r[0], r[2].split(".")[-1]): r[3] for r in rows}
        ok = (got.get(("HYP", "a1")) == ["BochnerOn"] and got.get(("CONCL", "b1")) == ["BochnerOn"]
              and not any(k[1] == "c1" for k in got)
              and got.get(("HYP", "d1")) == ["NegCircle", "RQ₄"] and len(rows) == 3)
        print("self-test: PASS" if ok else f"self-test: FAIL {got}")
        return 0 if ok else 1
    texts = [(f, open(f"Proofs/HadwigerNelson/Arith/{f}.lean", encoding="utf-8").read()) for f in FILES]
    run(texts, "named hypotheses")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
