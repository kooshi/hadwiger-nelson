#!/usr/bin/env python3
"""FS131-L6A: every declaration name cited in ARCHITECTURE.md's rows for wave 6's fourteen modules is a declaration.

  tools/fs131_l6a_archrows.py [--self-test] [ARCHITECTURE.md]

For each row `| `Plane/Saturated/<M>` | <description> | <imports> | … |`, every backticked token of the description
that is shaped like a declaration name (letters, digits, `_`, `'`, `.`, subscripts; no space, no `/`) is looked up:

  module    declared in `Proofs/HadwigerNelson/Plane/Saturated/<M>.lean` (theorem, def, abbrev, structure, instance,
            lemma, inductive, class; by its last component, or as a field `  name :` of a structure there);
  wave      declared in another of the fourteen modules;
  library   declared elsewhere under `Proofs/`;
  MISSING   nowhere — a row that cites a name nothing declares.

Also checked: the fourteen rows exist, one each; none says "skeleton"; none says "leaves" or "sorry" except in the
phrase "no `sorry`". Exit 0 iff no MISSING and those hold.
--self-test: the file as it stands must pass, and a copy in which one cited name is misspelt must read MISSING and a
copy in which one row says "skeleton" must fail on that word.
"""
import glob
import os
import re
import sys
import tempfile

DIR = "Proofs/HadwigerNelson/Plane/Saturated"
MODS = ["Basic", "Pinch", "MapEdge", "Sq9Map", "MapColouring", "Fan", "FanExamples", "Curve", "CurveArc", "ArcContinuation",
        "FanArcs", "FanBuild", "LocalGraph", "FanBridge"]
NAME = re.compile(r"^\.?[A-Za-z_][\w'.₀-₉′]*$")
KW = r"(?:theorem|def|abbrev|structure|instance|lemma|inductive|class)"


def declared(short, src):
    return bool(re.search(r"\b" + KW + r"\s+(?:\S*\.)?" + re.escape(short) + r"(?![\w'.])", src)
                or re.search(r"^\s+" + re.escape(short) + r"\s*:", src, re.M))


def check(path, quiet=False):
    text = open(path, encoding="utf-8").read()
    srcs = {m: open(f"{DIR}/{m}.lean", encoding="utf-8").read() for m in MODS}
    lib = None
    faults, tally = [], {}
    for m in MODS:
        rows = [l for l in text.split("\n") if l.startswith(f"| `Plane/Saturated/{m}` |")]
        if len(rows) != 1:
            faults.append(f"ROWS {m}: {len(rows)} row(s)")
            continue
        desc = rows[0].split("|")[2]
        if "skeleton" in desc.lower():
            faults.append(f"SKELETON {m}: the row says 'skeleton'")
        stale = re.sub(r"no `sorry`", "", desc, flags=re.I)
        for w in ("`sorry`", " leaves"):
            if w in stale:
                faults.append(f"STALE {m}: the row says {w.strip()!r}")
        t = {"module": 0, "wave": 0, "library": 0, "MISSING": []}
        for tok in re.findall(r"`([^`]+)`", desc):
            if not NAME.match(tok) or tok in ("sorry",):
                continue
            short = tok.split(".")[-1]
            if len(short) < 2:
                continue
            if declared(short, srcs[m]):
                t["module"] += 1
            elif any(declared(short, s) for k, s in srcs.items() if k != m):
                t["wave"] += 1
            else:
                if lib is None:
                    lib = "\n".join(open(f, encoding="utf-8").read()
                                    for f in glob.glob("Proofs/**/*.lean", recursive=True) if DIR not in f)
                if declared(short, lib):
                    t["library"] += 1
                else:
                    t["MISSING"].append(tok)
        tally[m] = t
        for tok in t["MISSING"]:
            faults.append(f"MISSING {m}: `{tok}`")
        if not quiet:
            print(f"{m}: cited names — in the module {t['module']}, elsewhere in the wave {t['wave']}, elsewhere in the "
                  f"library {t['library']}, MISSING {len(t['MISSING'])} {t['MISSING']}")
    for f in faults:
        print("  " + f)
    return faults


def main(argv):
    args = [a for a in argv if not a.startswith("--")]
    path = args[0] if args else "ARCHITECTURE.md"
    faults = check(path)
    if "--self-test" not in argv:
        print("arch rows: PASS" if not faults else f"arch rows: FAIL ({len(faults)})")
        return 1 if faults else 0
    ok = not faults
    text = open(path, encoding="utf-8").read()
    plants = [("MISSING", text.replace("`fan_of_isolated`", "`fan_of_isolatedd`", 1)),
              ("SKELETON", text.replace("| `Plane/Saturated/Fan` | **FS-131 wave 6**", "| `Plane/Saturated/Fan` | **FS-131 wave 6, skeleton**", 1))]
    for word, planted in plants:
        if planted == text:
            print(f"plant {word}: COULD NOT BE PLANTED")
            ok = False
            continue
        with tempfile.NamedTemporaryFile("w", suffix=".md", delete=False, encoding="utf-8") as fh:
            fh.write(planted)
        fl = check(fh.name, quiet=True)
        os.unlink(fh.name)
        fired = any(f.startswith(word) for f in fl)
        print(f"plant {word}: {'fired' if fired else 'DID NOT FIRE'}")
        ok = ok and fired
    print("self-test: PASS" if ok else "self-test: FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
