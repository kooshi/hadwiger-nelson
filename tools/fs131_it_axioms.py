#!/usr/bin/env python3
"""FS131-IT1: the axioms receipt for T-GRAPH, against the built oleans.

  fs131_it_axioms.py gen            writes data/fs131/it/AxiomsIT1.lean: `#print axioms` (pp.fullNames) for every `HadwigerNelson.Thomassen.*`
                                    record of scripts/Axioms.lean's FS131-IT1 block, plus the leaf, `lemma1`, `triLattice_hyps`, and the
                                    partners `ArcMap.filledGraph_finSep` and `ArcMap.cvb_thom_reduced`, which must show `sorryAx`.
  fs131_it_axioms.py check OUTPUT   parses `lake env lean data/fs131/it/AxiomsIT1.lean`'s output: every clean record's axioms must be a subset of
                                    the standard three, every partner must contain `sorryAx`, every expected record must be present, and no
                                    record may be unexpected.
  fs131_it_axioms.py selftest OUTPUT  the same check with the partner list and a clean name swapped: it must FAIL on both counts (a checker
                                    that cannot see a missing sorryAx or a sorryAx where none belongs has not been tested by passing).
Exit 0 on a pass (or, under selftest, on the expected failures); 1 otherwise.
"""
import re
import sys

STD = {"propext", "Classical.choice", "Quot.sound"}
LEAN = "data/fs131/it/AxiomsIT1.lean"
EXTRA_CLEAN = ["HadwigerNelson.Thomassen.reduced_props_of_planarLike", "HadwigerNelson.Thomassen.lemma1",
               "HadwigerNelson.Thomassen.triLattice_hyps"]
PARTNERS = ["HadwigerNelson.Plane.ArcMap.filledGraph_finSep", "HadwigerNelson.Plane.ArcMap.cvb_thom_reduced"]


def block_names() -> list[str]:
    text = open("scripts/Axioms.lean", encoding="utf-8").read()
    start = text.index("(job FS131-IT1)")
    end = text.index("/-! ##", start + 1) if "/-! ##" in text[start + 1:] else len(text)
    end = min(end, text.index("=== PURCHASED ===", start))
    names = re.findall(r"^#print axioms (\S+)$", text[start:end], re.M)
    return [n for n in names if n.startswith("HadwigerNelson.Thomassen.")]


def parse(text: str) -> dict[str, set[str]]:
    recs = {}
    for m in re.finditer(r"'(\S+?)' (?:depends on axioms: \[([^\]]*)\]|does not depend on any axioms)", text, re.S):
        name, ax = m.group(1), m.group(2)
        recs[name] = set() if ax is None else {a.strip() for a in ax.replace("\n", " ").split(",") if a.strip()}
    return recs


def check(recs: dict[str, set[str]], clean: list[str], sorry: list[str]) -> list[str]:
    fails = []
    for n in clean:
        if n not in recs:
            fails.append(f"{n}: NO RECORD")
        elif not recs[n] <= STD:
            fails.append(f"{n}: NOT CLEAN {sorted(recs[n])}")
    for n in sorry:
        if n not in recs:
            fails.append(f"{n}: NO RECORD")
        elif "sorryAx" not in recs[n]:
            fails.append(f"{n}: PARTNER SHOWS NO sorryAx {sorted(recs[n])}")
    for n in recs:
        if n not in clean and n not in sorry:
            fails.append(f"{n}: RECORD NOT EXPECTED")
    return fails


def main() -> int:
    mode = sys.argv[1]
    clean = block_names() + EXTRA_CLEAN
    if mode == "gen":
        body = "import Proofs.HadwigerNelson.Thomassen\nimport Proofs.HadwigerNelson.Plane.ValidMap.MapGraph\n\nset_option pp.fullNames true\n\n"
        body += "".join(f"#print axioms {n}\n" for n in clean + PARTNERS)
        open(LEAN, "w", encoding="utf-8").write(body)
        print(f"wrote {LEAN}: {len(clean)} clean records, {len(PARTNERS)} partners")
        return 0
    recs = parse(open(sys.argv[2], encoding="utf-8").read())
    if mode == "check":
        fails = check(recs, clean, PARTNERS)
        for f in fails:
            print("FAIL:", f)
        print(f"{'FAIL' if fails else 'OK'}: {len(clean)} clean records on the standard three or fewer, {len(PARTNERS)} partners on sorryAx")
        return 1 if fails else 0
    if mode == "selftest":
        swapped_clean = clean[1:] + [PARTNERS[0]]
        swapped_sorry = [clean[0]] + PARTNERS[1:]
        fails = check(recs, swapped_clean, swapped_sorry)
        seen_partner = any("NOT CLEAN" in f and PARTNERS[0] in f for f in fails)
        seen_clean = any("NO sorryAx" in f and clean[0] in f for f in fails)
        print(f"selftest: partner-as-clean {'caught' if seen_partner else 'MISSED'}; clean-as-partner {'caught' if seen_clean else 'MISSED'}")
        return 0 if seen_partner and seen_clean else 1
    return 1


if __name__ == "__main__":
    sys.exit(main())
