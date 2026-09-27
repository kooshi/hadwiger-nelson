#!/usr/bin/env python3
"""FS106-VB quotation check: every verbatim quotation of a printed paper in
data/fs106/claims.md (the ones this job verifies) is looked up, fragment by fragment
(split at the ellipsis "…"), in the paper's `pdftotext -layout` text layer, after
deleting all whitespace on both sides. Exit 0 iff every fragment is found and the
planted control (one character changed) is NOT found.

Usage: fs106_vb_quotes.py <dir holding the three .txt layers>
"""
import re, sys, pathlib

CLAIMS = pathlib.Path(__file__).resolve().parent.parent / "data/fs106/claims.md"
VOR, SV, TW = ("arXiv-2304.10163-voronov.txt", "arXiv-2502.01958-maptype.txt",
               "townsend-1981-every-5-coloured-map-monochrome-unit-jcta-30-114-115.txt")
# (claim label, source file) -> the quoted strings are pulled from claims.md itself
WANT = {"D-NORM": VOR, "D-VPROP": VOR, "D-VMC": VOR, "D-SV": SV,
        "V-1.1": VOR, "V-1.2": VOR, "V-1.3": VOR, "V-2.1": VOR, "V-2.2": VOR,
        "V-P2.2": VOR, "V-4.1": VOR, "V-6.1": VOR, "SV-1": SV, "SV-2": SV,
        "SV-L1": SV, "SV-C2": SV, "SV-C3": SV, "SV-L3": SV, "SV-L4": SV,
        "TW-81": TW, "C-T-CHR4": SV, "C-T-IND": SV, "C-AE-Q2": SV, "C-Q-STAB": SV}

# fragments caught by the quote regex that are NOT quotations of these three papers:
# the list's own quote marks around a word, FS106-A's wording, [Parts2020c]'s abstract.
NOT_THESE_PAPERS = ("(Condition 1) in place of", "— Question 2 as posed.",
                    "for some δ > 0 and every ε > 0, no colouring of the radius-3 disc",
                    "more than 99.985698% of the Euclidean plane")

def squash(s):
    return re.sub(r"\s+", "", s)

def entries(text):
    """Split claims.md into (label, body) at each bullet '- **LABEL**'."""
    out = {}
    parts = re.split(r"\n\s*- \*\*([A-Z][A-Za-z0-9.\-]*)\*\*", "\n" + text)
    for i in range(1, len(parts), 2):
        out[parts[i]] = parts[i + 1]
    return out

def quotes(body):
    # straight or curly double quotes
    return [q for q in re.findall(r"[\"“]([^\"”]{12,})[\"”]", body)]

def main():
    d = pathlib.Path(sys.argv[1])
    # de-hyphenate line breaks ("multi-\ncolor"), and read the OCR's A” / A0 as the scan's A°
    def layer(f):
        t = re.sub(r"-[ \t]*\n\s*", "", (d / f).read_text())
        if f == TW:
            t = t.replace("A”", "A°").replace("A0 ", "A° ").replace("A0\n", "A°\n")
        return squash(t)
    layers = {f: layer(f) for f in (VOR, SV, TW)}
    ent = entries(CLAIMS.read_text())
    bad = 0; checked = 0
    for lab, src in WANT.items():
        if lab not in ent:
            print(f"MISSING-ENTRY {lab}"); bad += 1; continue
        qs = quotes(ent[lab])
        if not qs:
            print(f"NO-QUOTE {lab}"); bad += 1; continue
        for q in qs:
            for frag in q.split("…"):
                frag = frag.strip()
                if "[" in frag and "garbled" in frag:      # the note's own bracket
                    frag = frag.split("[")[0]
                if len(squash(frag)) < 6 or frag.startswith(NOT_THESE_PAPERS):
                    continue
                if src == TW and "garbled" in q and "greater than" in frag:
                    frag = frag.split("greater than")[0] + "greater than"   # constant read from the scan
                if squash(frag) in layers[src]:
                    checked += 1
                else:
                    bad += 1
                    print(f"NOT-FOUND {lab} [{src[:12]}]: {frag[:110]!r}")
    # planted control: a real fragment with one character changed must fail
    plants = [(VOR, "χ[1−ε,1+ε] (R2 ; U ) ≥ 6"),                     # 7 -> 6
              (SV, "bichromatic points with the same multicolor that are exactly two units apart")]
    plant_found = any(squash(t) in layers[f] for f, t in plants)
    print(f"fragments found: {checked}; not found: {bad}; planted control found: {plant_found}")
    if plant_found:
        print("CONTROL FAILED: the planted misquotation was accepted"); return 2
    return 1 if bad else 0

if __name__ == "__main__":
    sys.exit(main())
