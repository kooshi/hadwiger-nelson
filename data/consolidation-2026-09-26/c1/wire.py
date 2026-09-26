#!/usr/bin/env python3
"""C1 stage 3: append an address-only pointer block to every older file the 2026-09-26 work bears on and which does not already name the
bearing ledger rows. Pointers, never results: each item is a ledger row and the derivation entries or files it lives in.

Run without arguments for a dry run (prints, per target, the rows it already names and the block it would get); --write appends.
Writes wire.tsv beside itself (target, rows borne, rows already named, rows added)."""
import os, re, sys

R = "/home/kooshi/source/lean-dir"
HERE = os.path.dirname(os.path.abspath(__file__))
D = "`plans/FS100-derivation.md`"
ADDR = {  # row -> where it lives (addresses only)
    116: f"{D} §1", 117: f"{D} FS100-T1, FS100-K0", 118: f"{D} FS100-N1, FS100-T4, FS100-T5, FS100-T2",
    119: "`plans/FS75-derivation.md` FS75-W, FS75-C, FS75-T, FS75-H",
    120: f"{D} FS100-MR, FS100-PE2, FS100-EFP, FS100-HX1", 121: f"{D} FS100-Q47",
    122: f"{D} FS100-FLK, FS100-SPEC, FS100-FLH, FS100-ED1, FS100-ED2",
    123: f"{D} §4, FS100-COR", 124: f"{D} FS100-X22", 125: f"{D} FS100-B12, FS100-B3", 126: f"{D} §5",
    127: "`plans/FS100-K-kernel-47.md`; `Proofs/HadwigerNelson/SpectralChain.lean`, `Proofs/HadwigerNelson/Instances/SqrtFortySeven.lean`",
}
SPECIFIC = {  # (target, row) -> a narrower address than ADDR's
    ("STUB-four-colours-167", 119): "`plans/FS75-derivation.md` FS75-H", ("STUB-four-colours-167", 123): f"{D} FS100-167, FS100-FAM",
    ("STUB-biquadratic-table", 123): f"{D} FS100-Q35, FS100-CTL, FS100-CLS", ("STUB-last-lattice", 123): f"{D} FS100-Q35",
    ("STUB-residue-tower-drop", 123): f"{D} FS100-DLP, FS100-CLS", ("STUB-residue-tower-drop", 117): f"{D} FS100-T1",
    ("STUB-rigidity-dichotomy", 119): "`plans/FS75-derivation.md` FS75-C, FS75-H", ("STUB-unit-vector-ring-kernel", 123): f"{D} FS100-EXC",
    ("STUB-twenty-seven", 123): f"{D} FS100-G27", ("FS54-twenty-seven", 123): f"{D} FS100-G27",
    ("FS66-residue-tower-drop", 123): f"{D} FS100-DLP", ("FS73-rigidity-dichotomy", 119): "`plans/FS75-derivation.md` FS75-C, FS75-H",
    ("FS91-character-local-global", 118): f"{D} FS100-N1, FS100-T4",
    ("R88-derivation", 117): f"{D} FS100-T1", ("R88-derivation", 123): f"{D} FS100-TCA",
    ("FS84-SI-D-derivation", 117): f"{D} FS100-K0", ("FS84-SI-V-verification", 117): f"{D} FS100-K0",
    ("FS84-SI-D-derivation", 123): f"{D} FS100-K0b, FS100-SPC", ("FS84-SI-V-verification", 123): f"{D} FS100-K0b, FS100-SPC",
    ("STUB-unit-vector-ring-kernel", 120): f"{D} FS100-MR (its hypothesis `R = O′`)",
}
EXTRA = {  # target -> addresses beyond the rows
    "STUB-measure-rigidity-three-fields": ["`plans/FS100-three-field-lemma.md` §R-close (J53, J53b), §R-close (stage 5), (stage 5, wave 3), (stage 5, wave 3b)"],
    "STUB-infinite-place-spectra": ["FS-100's stub, `plans/STUB-measure-rigidity-three-fields.md`"],
    "FS84-five-colours-47": ["`plans/FS100-three-field-lemma.md` §R-close (stage 5)"],
    "FS86-row88-rigidity": ["`plans/FS100-three-field-lemma.md` §R-close (stage 5, wave 3), (stage 5, wave 3b)"],
}
TARGETS = {  # file stem -> rows the 2026-09-26 work bears on it with
    "STUB-measure-rigidity-three-fields": [116, 117, 118, 120, 121, 122, 123, 124, 125, 126, 127],   # FS-100
    "STUB-four-colours-167": [117, 119, 123, 125],          # FS-59
    "STUB-five-colours-47": [121, 122, 127],                 # FS-84
    "STUB-ultrametric-continuation": [120, 124, 126],        # FS-98
    "STUB-adelic-window-colouring": [117, 125],              # FS-64
    "STUB-windows-five-nonmixing": [125],                    # FS-96
    "STUB-infinite-place-spectra": [120, 121, 122, 126],     # FS-97
    "STUB-biquadratic-table": [123],                         # FS-48
    "STUB-last-lattice": [123],                              # FS-72
    "STUB-six-is-not-a-value": [123, 125],                   # FS-62
    "STUB-certificate-at-43": [125],                         # FS-69
    "STUB-residue-tower-drop": [117, 123],                   # FS-66
    "STUB-rigidity-dichotomy": [119],                        # FS-73
    "STUB-unit-vector-ring-kernel": [120, 123],              # FS-47
    "STUB-twenty-seven": [123],                              # FS-54
    "STUB-isometric-measure-rigidity": [120],                # FS-89's stub
    "STUB-dyadic-rigidity-triangle-free": [124, 126],        # FS-86
    "STUB-three-colour-criterion-kernel": [119],             # FS-75
    "STUB-quadratic-witnesses-kernel": [119],                # FS-60
    "STUB-main-clause-five-kernel": [123, 127],              # FS-101
    "FS84-five-colours-47": [121, 122, 127],                 # FS-84's plan
    "FS84-SI-D-derivation": [117, 121, 123],                 # FS-84's SI, derived
    "FS84-SI-V-verification": [117, 121, 123],               # FS-84's SI, blind
    "FS86-row88-rigidity": [120, 124, 126],                  # row 88's plan
    "FS86-dyadic-rigidity": [124, 126],                      # FS-86's plan
    "FS89-rational-band-rigidity": [120],                    # FS-89's plan
    "M3-exotic-colourings": [125],                           # M3's plan (windows at five over Q(sqrt 167))
    "FS91-character-local-global": [116, 118],               # FS-91's plan
    "FS73-rigidity-dichotomy": [119],                        # FS-73's plan
    "FS66-residue-tower-drop": [123],                        # FS-66's plan
    "FS54-twenty-seven": [123],                              # FS-54's plan
    "R88-derivation": [117, 121, 123, 124, 126],             # row 88's derivation register
}
ROWLIST = re.compile(r"rows?\s+((?:\d{2,3}(?:\s*[–-]\s*\d{2,3})?(?:\s*(?:,|and|&)\s*)?)+)")


def named_rows(text):
    got = set()
    for m in ROWLIST.finditer(text):
        for a, b in re.findall(r"(\d{2,3})(?:\s*[–-]\s*(\d{2,3}))?", m.group(1)):
            a = int(a)
            got.update(range(a, int(b) + 1) if b else [a])
    return got


def block(stem, rows):
    items = [f"row {r} ({SPECIFIC.get((stem, r), ADDR[r])})" for r in rows]
    items += EXTRA.get(stem, [])
    return ("\n\n## Where the 2026-09-26 work on this lives\n\n"
            "*Pointer block (consolidation job C1, 2026-09-26): addresses only — each result lives in its ledger row and derivation entry; "
            "the per-job index is `plans/CRUNCH-2026-09-26-x2x3-INDEX.md`.*\n\n"
            "See: `LEDGER.md` " + "; ".join(items) + ".\n")


def main(write):
    out = []
    for stem, rows in TARGETS.items():
        p = os.path.join(R, "plans", stem + ".md")
        text = open(p, encoding="utf-8").read()
        have = named_rows(text)
        missing = [r for r in rows if r not in have]
        already = "## Where the 2026-09-26 work on this lives" in text
        out.append((stem, rows, sorted(have & set(rows)), missing, already))
        if missing and not already:
            b = block(stem, missing)
            if write:
                with open(p, "a", encoding="utf-8") as fh:
                    if not text.endswith("\n"):
                        fh.write("\n")
                    fh.write(b.lstrip("\n") if text.endswith("\n\n") else b[1:])
            else:
                print(f"== {stem}: +{missing}\n{b.strip()}\n")
    with open(os.path.join(HERE, "wire.tsv"), "w") as fh:
        fh.write("# C1 stage 3: target; rows the 2026-09-26 work bears on it with; rows it already named; rows the pointer block adds\n")
        for stem, rows, had, missing, already in out:
            fh.write(f"plans/{stem}.md\t{rows}\t{had}\t{missing if not already else 'block already present'}\n")
    print(sum(1 for o in out if o[3]), "blocks", "written" if write else "(dry run)", "of", len(out), "targets")


if __name__ == "__main__":
    main("--write" in sys.argv)
