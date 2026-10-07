#!/usr/bin/env python3
"""FS132-I1 — the import's read-back, symbol against symbol, across the two pins.

The two outside theorems of `[OAIMath2026]` enter this library as axioms over copies of the release's
definitions.  `data/fs132/i1/readback/DumpBody.lean.inc` prints a declaration as the kernel holds it (de
Bruijn indices, full constant names with universe arguments, every implicit and instance argument, binder
kinds and binder names); the same file is run at the release's pin on the release's constants and at this
pin on this library's.  This tool compares the two prints.  The namespaces `OAI.EuclideanFiveColor.` and
`HadwigerNelson.Outside.OAI158.` are both written `§.` before comparing; nothing else is normalised.

  fs132_i1_readback.py decls RELEASE.out OURS.out [--expect-different A,B]
      the eight declarations: kind, universe parameters, type, value, and the set of constants named.
      Exit 0 only if all eight are found in both prints and each is IDENTICAL (kinds as expected: the two
      outside theorems are `theorem` there and `axiom` here).  With --expect-different (a control run on a
      print of deliberately altered declarations): exit 0 only if exactly the named ones are DIFFERENT.
  fs132_i1_readback.py level1 RELEASE.out OURS.out
      every Mathlib/core constant the eight declarations name, one step down: its type, and its value (a
      definition) or constructors (an inductive type).  Prints IDENTICAL / DIFFERENT (which part) / MOVED
      (declared in another module) per constant and the counts.  Exit 1 if a constant is ABSENT at a pin or
      the two prints do not list the same constants; a DIFFERENT is printed for reading, not failed.
  fs132_i1_readback.py --self-test RELEASE.out OURS.out
      plants six faults in copies of OURS.out (a changed instance, a binder kind, a numeral, a missing
      declaration, a kind, a constant renamed in the USES list) and requires each refused, and the
      unplanted pair to pass.
"""
import re
import sys
from pathlib import Path

NS = ("OAI.EuclideanFiveColor.", "HadwigerNelson.Outside.OAI158.")
EXPECT = {  # name: (kind at the release's pin, kind at this pin)
    "ProperColoring": ("def", "def"),
    "anglePeriodPositive": ("theorem", "theorem"),
    "Angles": ("def", "def"),
    "angularMeasure": ("def", "def"),
    "direction": ("def", "def"),
    "WeakColoring": ("def", "def"),
    "no_proper_five_coloring": ("theorem", "axiom"),
    "proper_to_borel_weak": ("theorem", "axiom"),
}


def normalise(s: str) -> str:
    for ns in NS:
        s = s.replace(ns, "§.")
    return s


def load_decls(text: str):
    out, cur = {}, None
    for ln in normalise(text).splitlines():
        m = re.match(r"DUMP (\S+) : (\w+) levels=(.*)$", ln)
        if m:
            cur = m.group(1)
            out[cur] = {"kind": m.group(2), "levels": m.group(3), "type": None, "value": None, "uses": {}}
        elif ln.startswith("DUMP   type  = ") and cur:
            out[cur]["type"] = ln[len("DUMP   type  = "):]
        elif ln.startswith("DUMP   value = ") and cur:
            out[cur]["value"] = ln[len("DUMP   value = "):]
        else:
            m = re.match(r"USES (\S+) : (\S+) @ (.*)$", ln)
            if m and m.group(1) in out:
                out[m.group(1)]["uses"][m.group(2)] = m.group(3)
    return out


def first_difference(a: str, b: str, width: int = 90) -> str:
    i = 0
    while i < min(len(a), len(b)) and a[i] == b[i]:
        i += 1
    lo = max(0, i - 30)
    return f"at char {i}: release …{a[lo:i + width]}… | here …{b[lo:i + width]}…"


def compare_decls(rel_text: str, our_text: str):
    """Returns (rows, different_names, fatal) — fatal is a list of reasons the comparison could not be made."""
    rel, our = load_decls(rel_text), load_decls(our_text)
    rows, different, fatal = [], [], []
    for base, (krel, kour) in EXPECT.items():
        name = "§." + base
        if name not in rel or name not in our:
            fatal.append(f"{base}: not found in {'the release print' if name not in rel else 'this pin print'}")
            continue
        r, o = rel[name], our[name]
        why = []
        if r["kind"] != krel:
            why.append(f"kind at the release is {r['kind']}, expected {krel}")
        if o["kind"] != kour:
            why.append(f"kind here is {o['kind']}, expected {kour}")
        if r["levels"] != o["levels"]:
            why.append(f"universe parameters {r['levels']} vs {o['levels']}")
        if r["type"] is None or o["type"] is None:
            fatal.append(f"{base}: no type line")
            continue
        if r["type"] != o["type"]:
            why.append("type " + first_difference(r["type"], o["type"]))
        if (r["value"] is None) != (o["value"] is None):
            why.append("a value at one pin and none at the other")
        elif r["value"] is not None and r["value"] != o["value"]:
            why.append("value " + first_difference(r["value"], o["value"]))
        if set(r["uses"]) != set(o["uses"]):
            only_r = sorted(set(r["uses"]) - set(o["uses"]))
            only_o = sorted(set(o["uses"]) - set(r["uses"]))
            why.append(f"constants named: only at the release {only_r}; only here {only_o}")
        if not r["uses"] or not o["uses"]:
            fatal.append(f"{base}: an empty USES list — the print is incomplete")
        size = len(r["type"]) + len(r["value"] or "")
        if why:
            different.append(base)
            rows.append(f"DIFFERENT  {base}: " + "; ".join(why))
        else:
            rows.append(f"IDENTICAL  {base}: {r['kind']} there, {o['kind']} here; {size} characters of term; "
                        f"{len(r['uses'])} constants named")
    return rows, different, fatal


def run_decls(rel_text, our_text, expect_different):
    rows, different, fatal = compare_decls(rel_text, our_text)
    for r in rows:
        print(r)
    for f in fatal:
        print("FATAL     ", f)
    n = len(EXPECT)
    print(f"declarations: {n}  compared: {len(rows)}  identical: {len(rows) - len(different)}  "
          f"different: {len(different)} {different}")
    if fatal:
        print("READ-BACK NOT MADE — a declaration was not found or a print is incomplete; that is a failure, not a pass")
        return 1
    if expect_different is not None:
        ok = sorted(different) == sorted(expect_different)
        print(f"CONTROL {'FIRED AS EXPECTED' if ok else 'DID NOT MATCH'}: expected different {sorted(expect_different)}")
        return 0 if ok else 1
    if different:
        print("READ-BACK DIFFERS")
        return 1
    print(f"READ-BACK IDENTICAL: all {n} declarations, term for term, modulo the namespace")
    return 0


def load_level1(text: str):
    recs, mods = {}, {}
    for ln in text.splitlines():
        if ln.startswith("L1MOD "):
            m = re.match(r"L1MOD (\S+) @ (.*)$", ln)
            mods[m.group(1)] = m.group(2)
        elif ln.startswith("L1 "):
            name, _, rest = ln[3:].partition(" | ")
            recs[name] = rest
    return recs, mods


def split_level1(rest: str):
    """levels=… | type = … | <kind> … | [value = … / ctors]"""
    parts = rest.split(" | ")
    d = {"levels": parts[0] if parts else "", "type": "", "kind": "", "body": ""}
    if len(parts) > 1:
        d["type"] = parts[1]
    if len(parts) > 2:
        d["kind"] = parts[2].split()[0] if parts[2].split() else ""
        d["body"] = " | ".join(parts[2:])
    return d


def rename_universes(rest: str) -> str:
    """Rename the declared universe parameters to ℓ0, ℓ1, … in the order `levels=[…]` lists them."""
    m = re.match(r"levels=\[([^\]]*)\]", rest)
    if not m:
        return rest
    for i, u in enumerate([x.strip() for x in m.group(1).split(",") if x.strip()]):
        rest = rest.replace(f"(p {u})", f"(p ℓ{i})")
    return re.sub(r"levels=\[[^\]]*\]", "levels=[…]", rest, count=1)


def run_level1(rel_text, our_text):
    rel, relm = load_level1(rel_text)
    our, ourm = load_level1(our_text)
    bad = 0
    if set(rel) != set(our) or not rel:
        print(f"FATAL: the two prints do not list the same constants (release {len(rel)}, here {len(our)}): "
              f"{sorted(set(rel) ^ set(our))}")
        return 1
    ident, diff, moved, uni = [], [], [], []
    for name in sorted(rel):
        if rel[name].strip() == "ABSENT" or our[name].strip() == "ABSENT":
            print(f"ABSENT     {name}: release={rel[name][:20]!r} here={our[name][:20]!r}")
            bad += 1
            continue
        a, b = split_level1(rel[name]), split_level1(our[name])
        where = [k for k in ("levels", "type", "kind") if a[k] != b[k]]
        if a["body"] != b["body"] and "kind" not in where:
            where.append("value" if a["kind"] == "def" else "constructors" if a["kind"] == "inductive" else "body")
        mv = relm.get(name) != ourm.get(name)
        tag = f"  [module: {ourm.get(name)} here, {relm.get(name)} at the release]" if mv else ""
        if mv:
            moved.append(name)
        if where and rename_universes(rel[name]) == rename_universes(our[name]):
            uni.append(name)
            print(f"IDENTICAL up to the NAMES of universe parameters  {name} ({a['kind']}): "
                  f"{a['levels']} there, {b['levels']} here{tag}")
        elif where:
            diff.append(name)
            print(f"DIFFERENT  {name} ({a['kind']}): {', '.join(where)}; {first_difference(rel[name], our[name], 150)}{tag}")
        else:
            ident.append(name)
            print(f"IDENTICAL  {name} ({a['kind']}){tag}")
    print(f"level one: constants {len(rel)}  identical: {len(ident)}  identical up to universe-parameter names: "
          f"{len(uni)}  different: {len(diff)}  absent: {bad}  declared in another module at the other pin: {len(moved)}")
    if diff:
        print("different, to be read: " + ", ".join(diff))
    return 1 if bad else 0


def self_test(rel_text, our_text):
    rows, different, fatal = compare_decls(rel_text, our_text)
    if different or fatal:
        print(f"SELF-TEST FAILED: the unplanted pair is not identical ({different} {fatal})")
        return 1
    plants = {
        "a changed instance (Fin.instMeasurableSpace)": our_text.replace("Fin.instMeasurableSpace", "Fin.instTopMeasurableSpace", 1),
        "a binder kind (the NeZero instance binder made explicit)": our_text.replace("(pi.c inst", "(pi.d inst", 1),
        "a numeral (five colours to four)": re.sub(r"\(nat 5\)", "(nat 4)", our_text, count=1),
        "a missing declaration (WeakColoring's header line)": "\n".join(
            ln for ln in our_text.splitlines() if not ln.startswith(f"DUMP {NS[1]}WeakColoring :")),
        "a kind (the first outside theorem printed as a theorem here)": our_text.replace(
            f"DUMP {NS[1]}no_proper_five_coloring : axiom", f"DUMP {NS[1]}no_proper_five_coloring : theorem", 1),
        "a constant renamed in a USES list": our_text.replace(
            f"USES {NS[1]}direction : AddCircle.toCircle @", f"USES {NS[1]}direction : AddCircle.toCircle' @", 1),
    }
    ok = True
    for name, planted in plants.items():
        if planted == our_text:
            print(f"plant '{name}': DID NOT CHANGE THE PRINT")
            ok = False
            continue
        _, d, f = compare_decls(rel_text, planted)
        fired = bool(d or f)
        print(f"plant '{name}': {'FIRED' if fired else 'SILENT'} ({d if d else f})")
        ok = ok and fired
    print(f"SELF-TEST {'OK' if ok else 'FAILED'}: the unplanted pair identical on {len(rows)} declarations; {len(plants)} plants")
    return 0 if ok else 1


def main(argv):
    argv = list(argv)
    expect = None
    if "--expect-different" in argv:
        i = argv.index("--expect-different")
        if i + 1 >= len(argv):
            print("--expect-different needs a comma-separated list")
            return 2
        expect = [x for x in argv[i + 1].split(",") if x]
        del argv[i:i + 2]
        unknown = [x for x in expect if x not in EXPECT]
        if unknown or not expect:
            print(f"--expect-different: unknown or empty list {unknown}")
            return 2
    args = [a for a in argv[1:] if not a.startswith("--")]
    if "--self-test" in argv and len(args) == 2:
        return self_test(Path(args[0]).read_text(encoding="utf-8"), Path(args[1]).read_text(encoding="utf-8"))
    if len(args) != 3 or args[0] not in ("decls", "level1"):
        print(__doc__)
        return 2
    rel_text = Path(args[1]).read_text(encoding="utf-8")
    our_text = Path(args[2]).read_text(encoding="utf-8")
    if args[0] == "level1":
        return run_level1(rel_text, our_text)
    return run_decls(rel_text, our_text, expect)


if __name__ == "__main__":
    sys.exit(main(sys.argv))
