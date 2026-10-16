#!/usr/bin/env python3
"""FS131-ICS1 — no stored statement or definition of the 21 dumped modules changed but the ruled ones, from the kernel's
side. A copy of FS131-ICO2's comparator (`data/fs131/ico2/statements.py`) with this landing's rules.

Reads two prints of `data/fs131/ics1/lean/StatementDump.lean` (format: `## MODULE <m> constants=<n>`, then per constant
`@@ <KIND> <name> [INTERNAL | PRIVATE <user name>] [PROPTYPE]`, `TYPE <hash> <raw>`, and for a definition `VALUE <hash> <raw>`
and, when its type is not a proposition, `DATA <hash> <raw>` — the value with every proof subterm erased):
  BEFORE — the print of the skeleton's compiled library, made before the first proof edit
           (`data/fs131/ics1/statements-before.txt.gz`, at `9db09ce35`);
  AFTER  — the print of the build being gated.

For every constant of BEFORE that is not INTERNAL:
  SAME        present in AFTER's same module, same kind, same stored type (text), and for a definition the same DATA when
              BEFORE printed one, else the same VALUE;
  PUBLICIZED  one of PUBLICIZED below (inventory items 1027 (1), 1029 (a)): PRIVATE in BEFORE, absent from AFTER under its
              private name, present in AFTER under its user name as a public constant of the same kind, and its stored type
              equal to BEFORE's once the hygienic hash its instance binders carry (minted from the declaration's name,
              `LEAN.md` § Searching — Lean) is blanked in both — that hash and nothing else;
  CHANGED     anything else that differs                                                   -> FAIL;
  MISSING     absent from AFTER                                                            -> FAIL.
AFTER's non-INTERNAL constants absent from BEFORE are ADDED: listed by module, public, private and GENERATED (`f.congr_simp`,
`f.eq_n`, `f.eq_def`: reserved names Lean writes on demand) apart. A public one that is not GENERATED and not a PUBLICIZED
user name must be in ALLOWED_PUBLIC (item 1027 (1)'s new lemma) -> else FAIL. INTERNAL constants are counted, never
compared: they are what the proofs generate.

--plant runs the comparison five more times on AFTER changed in memory and requires each fault reported by name, and nothing
else new: one character of one public stored type; one public constant dropped; one unlisted public constant added; one
PUBLICIZED type changed outside the blanked hash; one PUBLICIZED constant's hash blanking widened to a second binder name
that differs (a check that blanks too much would pass it).
Usage: statements.py BEFORE AFTER [--plant]          exit 0 iff the comparison is clean (and, with --plant, every plant fired)
"""
import copy
import gzip
import lzma
import re
import sys

# Theorems Lean generates on demand under a declaration's name in whichever module asks (reserved names no author can
# declare; LEAN.md § Searching — Lean, FS131-IM11, FS131-ITK1): listed as GENERATED, never as new statements.
GENERATED = re.compile(r"\.(congr_simp|eq_\d+|eq_def)$")
INST = r" \[inst\._@\.Proofs\.HadwigerNelson\.Collapse\.\w+\.\d+\._hygCtx\._hyg\.\d+ : "

# The ruled publicizations (items 1027 (1), 1029 (a)): private theorems of `Rigidity/ClassRatio` made public, statements unchanged.
PUBLICIZED = {
    "HadwigerNelson.Rigidity.exists_card_two_pow_sq",
    "HadwigerNelson.Rigidity.chromaticNumber_le_four_dyadic",
    "HadwigerNelson.Rigidity.chromaticNumber_le_four_of_small",
}
# The hygienic hash of an instance binder minted in `ClassRatio`: blanked only for a PUBLICIZED constant.
HYG = re.compile(r"(inst\._@\.Proofs\.HadwigerNelson\.Rigidity\.ClassRatio)\.\d+(\._hygCtx\._hyg\.\d+)")
# Public constants a module may gain: item 1027 (1)'s new lemma. Every other new public constant must be named here first.
ALLOWED_PUBLIC = {
    "HadwigerNelson.Rigidity.ratioAtMost_dyadic_of_six_le": "item 1027 (1), item 1029 (b): FS131-ICS1",
    "HadwigerNelson.Rigidity.exists_isFourColourPlace_rat": "FS131-ICS1: the model the assumptions step asks of IsFourColourPlace (LEAN.md § The gate, FS124-L2's rule)",
}


def blank(t, widen=False):
    if widen:  # the plant: blank every hygienic binder name, from any module, on the raw text
        t = re.sub(r"inst\._@\.[\w.]+?\._hygCtx\._hyg\.\d+", "inst#", t)
    return HYG.sub(lambda m: m.group(1) + ".#" + m.group(2), t)


def read(path):
    opener = gzip.open if path.endswith(".gz") else lzma.open if path.endswith(".xz") else open
    mods, cur, last = {}, None, None
    with opener(path, "rt", encoding="utf-8") as f:
        for ln in f:
            ln = ln.rstrip("\n")
            if ln.startswith("## MODULE "):
                cur = ln.split()[2]
                mods[cur] = {}
            elif ln.startswith("@@ "):
                parts = ln.split()
                kind, name = parts[1], parts[2]
                flags = parts[3:]
                internal = "INTERNAL" in flags
                private = "PRIVATE" in flags
                mods[cur][name] = {"kind": kind, "internal": internal, "private": private,
                                   "user": flags[flags.index("PRIVATE") + 1] if private else name}
                last = mods[cur][name]
            elif ln.startswith(("TYPE ", "VALUE ", "DATA ")):
                tag, rest = ln.split(" ", 1)
                h, raw = rest.split(" ", 1) if " " in rest else (rest, "")
                last[tag] = raw
    return mods


def compare(before, after, widen=False, quiet=False):
    fails, report = [], []
    for mod, consts in before.items():
        amod = after.get(mod)
        if amod is None:
            fails.append(f"MODULE-MISSING {mod}")
            continue
        n_same = n_int = 0
        for name, c in consts.items():
            if c["internal"]:
                n_int += 1
                continue
            if c["private"] and c["user"] in PUBLICIZED:
                a = amod.get(c["user"])
                ok = (a is not None and not a["private"] and a["kind"] == c["kind"] and name not in amod
                      and blank(c.get("TYPE", ""), widen) == blank(a.get("TYPE", ""), widen))
                report.append(f"PUBLICIZED {'OK' if ok else 'DIFFERS'} {c['user']}: "
                              f"{'public, its stored type the private one up to the name-minted binder hash' if ok else 'not the ruled change'}")
                if not ok:
                    fails.append(f"PUBLICIZED-DIFFERS {c['user']}")
                continue
            a = amod.get(name)
            if a is None:
                fails.append(f"MISSING {name} ({mod})")
                continue
            same = a["kind"] == c["kind"] and a.get("TYPE") == c.get("TYPE")
            if c["kind"] == "DEF":
                key = "DATA" if "DATA" in c else "VALUE"
                same = same and a.get(key) == c.get(key)
            if same:
                n_same += 1
            else:
                what = "kind" if a["kind"] != c["kind"] else "type" if a.get("TYPE") != c.get("TYPE") else "value"
                fails.append(f"CHANGED ({what}) {name} ({mod})")
        added = [(n, a) for n, a in amod.items() if n not in consts and not a["internal"]]
        a_int = sum(1 for n, a in amod.items() if a["internal"])
        gen = sorted(n for n, a in added if not a["private"] and GENERATED.search(n))
        pub = sorted(n for n, a in added if not a["private"] and not GENERATED.search(n))
        priv = sorted(a["user"] for n, a in added if a["private"])
        for n in pub:
            if n not in ALLOWED_PUBLIC and n not in PUBLICIZED:
                fails.append(f"ADDED-PUBLIC-UNLISTED {n} ({mod})")
        report.append(f"{mod}: before {len(consts)} constants ({n_int} internal); SAME {n_same}; "
                      f"added public {len(pub)} {pub}; added private {len(priv)}; generated on demand {gen}; "
                      f"internal after {a_int}")
        if priv:
            report.append(f"    private added: {priv}")
    for m in after:
        if m not in before:
            fails.append(f"MODULE-NEW {m}")
    if not quiet:
        for r in report:
            print(r)
    return fails


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    before, after = read(args[0]), read(args[1])
    if not before or not after:
        print("NO MODULES READ — the dump or the reader is broken")
        return 2
    fails = compare(before, after)
    for f in fails:
        print("FAIL", f)
    print(f"VERDICT {'CLEAN' if not fails else 'FAIL'}: {len(fails)} failure(s)")
    if "--plant" not in sys.argv:
        return 1 if fails else 0
    ok = True
    mod = "Proofs.HadwigerNelson.Instances.SqrtTwentyThreeCbrtTwo"
    victim = "HadwigerNelson.SqrtTwentyThreeCbrtTwo.chromaticNumber_planeOver_sqrt23_cbrt2_eq_five"
    cr = "Proofs.HadwigerNelson.Rigidity.ClassRatio"
    pub = "HadwigerNelson.Rigidity.chromaticNumber_le_four_of_small"
    plants = []
    a1 = copy.deepcopy(after); t = a1[mod][victim]["TYPE"]; a1[mod][victim]["TYPE"] = t[:-1] + ("Y" if t[-1:] == "X" else "X")
    plants.append(("a changed stored type", a1, False, f"CHANGED (type) {victim} ({mod})"))
    a2 = copy.deepcopy(after); del a2[mod][victim]
    plants.append(("a dropped constant", a2, False, f"MISSING {victim} ({mod})"))
    a3 = copy.deepcopy(after)
    a3[mod]["HadwigerNelson.SqrtTwentyThreeCbrtTwo.planted_new"] = {"kind": "THM", "internal": False, "private": False,
                                                         "user": "HadwigerNelson.SqrtTwentyThreeCbrtTwo.planted_new", "TYPE": "True"}
    plants.append(("an unlisted public constant", a3, False,
                   f"ADDED-PUBLIC-UNLISTED HadwigerNelson.SqrtTwentyThreeCbrtTwo.planted_new ({mod})"))
    a4 = copy.deepcopy(after); t = a4[cr][pub]["TYPE"]; a4[cr][pub]["TYPE"] = t[:-1] + ("Y" if t[-1:] == "X" else "X")
    plants.append(("a changed publicized type", a4, False, f"PUBLICIZED-DIFFERS {pub}"))
    a5 = copy.deepcopy(after)
    for n in a5[cr]:
        if a5[cr][n].get("user") == pub or n == pub:
            a5[cr][n]["TYPE"] = a5[cr][n]["TYPE"].replace("inst._@.Proofs.HadwigerNelson.Rigidity.ClassRatio", "inst._@.Proofs.HadwigerNelson.Rigidity.Elsewhere", 1)
    plants.append(("a publicized binder from another module, under widened blanking", a5, True, None))
    for label, a, widen, expect in plants:
        got = compare(before, a, widen=widen, quiet=True)
        new = sorted(set(got) - set(fails))
        if expect is None:
            # the widened blanking must hide the planted difference: a check that blanks too much passes it
            hit = not new
            plain = sorted(set(compare(before, a, widen=False, quiet=True)) - set(fails))
            fired = f"PUBLICIZED-DIFFERS {pub}" in plain
            print(f"PLANT {label}: {'FIRED' if fired and hit else 'NOT FIRED'} — the ruled blanking reports {plain}, "
                  f"the widened one {new}")
            ok = ok and fired and hit
            continue
        hit = expect in new
        extra = [g for g in new if g != expect]
        print(f"PLANT {label}: {'FIRED' if hit and not extra else 'NOT FIRED'} — new failures {new}")
        ok = ok and hit and not extra
    print(f"PLANTS {'ALL FIRED' if ok else 'SOME DID NOT FIRE'}")
    return 0 if ok and not fails else 1


if __name__ == "__main__":
    sys.exit(main())
