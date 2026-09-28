#!/usr/bin/env python3
"""FS114-NB5: verbatim-quotation check (pattern of tools/fs114_nb4_quotes.py, copied, not edited) (standing rule 5).

Input: a TSV file, one line per quotation: <quote>\t<source path>.
Each quote and source is normalised the same way (whitespace collapsed,
'**' removed) and the quote must occur as a substring of the source.
--plant alters the first quote (one word changed) and adds its faithful twin,
so a run must show exactly one NOT FOUND (the plant) and the twin FOUND.
--loose ignores case, all whitespace, backticks and asterisks (a second, weaker pass;
a quotation found only loosely differs from its source in those respects alone).
Exit status 0 iff every non-plant quote is FOUND (and, under --plant, the
plant is NOT FOUND and the twin FOUND).
"""
import re, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent

LOOSE = False

def norm(s: str) -> str:
    s = s.replace("**", "")
    if LOOSE:  # --loose: case, all whitespace, backticks and asterisks ignored
        return re.sub(r"[\s`*]+", "", s).lower()
    return re.sub(r"\s+", " ", s).strip()

def main() -> int:
    args = sys.argv[1:]
    global LOOSE
    plant = "--plant" in args
    LOOSE = "--loose" in args
    args = [a for a in args if a not in ("--plant", "--loose")]
    tsv = pathlib.Path(args[0])
    rows = []
    for ln in tsv.read_text().splitlines():
        if not ln.strip() or ln.startswith("#"):
            continue
        q, src = ln.split("\t")
        rows.append((q, src.strip(), "real"))
    if plant:
        q0, s0, _ = rows[0]
        words = q0.split()
        i = len(words) // 2
        words[i] = words[i] + "XPLANT"
        rows.insert(0, (" ".join(words), s0, "plant"))
        rows.insert(1, (q0, s0, "twin"))
    cache = {}
    bad = 0
    for q, src, kind in rows:
        if src not in cache:
            cache[src] = norm((ROOT / src).read_text())
        found = norm(q) in cache[src]
        tag = "FOUND" if found else "NOT FOUND"
        print(f"{tag}\t[{kind}]\t{src}\t{q[:70]}")
        if kind == "plant":
            bad += found            # a plant that is found is a failure
        elif not found:
            bad += 1
    n = sum(1 for r in rows if r[2] == "real")
    f = sum(1 for q, s, k in rows if k == "real" and norm(q) in cache[s])
    print(f"SUMMARY: {f} of {n} real quotations FOUND; plant={'on' if plant else 'off'}")
    return 1 if bad else 0

if __name__ == "__main__":
    sys.exit(main())
