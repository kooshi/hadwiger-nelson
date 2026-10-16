#!/usr/bin/env python3
"""FS131-IFR1 — no stored statement or definition of the density module's six modules changed but the ruled ones, from the
kernel's side.

Reads two prints of `data/fs131/ifr1/lean/StatementDump.lean` (FS131-ICO2's dumper with this job's module list; format:
`## MODULE <m> constants=<n>`, then per constant `@@ <KIND> <name> [INTERNAL | PRIVATE <user name>] [PROPTYPE]`,
`TYPE <hash> <raw>`, and for a definition `VALUE <hash> <raw>` and, when its type is not a proposition, `DATA <hash> <raw>` —
the value with every proof subterm erased):
  BEFORE — the skeleton's compiled library, printed before any edit (`data/fs131/ifr1/statements-before.txt.gz`);
  AFTER  — the build being gated.

For every constant of BEFORE that is not INTERNAL (a public or a private declaration of the file):
  SAME     present in AFTER's same module, same kind, same stored type (text), and for a definition the same DATA when
           BEFORE printed one (a definition holding proofs moves its VALUE when a proof is filled), else the same VALUE;
  MOVED    one of MOVED below (the coordinator's ruling 3, inventory item 1021: item 1005's splits and the model at `k = 7`
           go from `Collapse/Density/Headline` to `Collapse/Headline`): absent from its old module, present in the new one,
           same kind, and the same stored type and value once the old module's name is rewritten to the new one inside
           hygienic names (`inst._@.<module>…`) and nowhere else (FS131-ITT1's move check);
  PUBLICIZED  the one constant of PUBLICIZED below (ruling 2: `ratioAtMost_of_charBound` made public): BEFORE's private
           constant `_private.<module>.0.<name>` is absent, AFTER holds `<name>` public in the same module with the same kind
           and the same stored type, character for character;
  CHANGED  anything else that differs                                                   -> FAIL;
  MISSING  absent from AFTER                                                            -> FAIL.
AFTER's non-INTERNAL constants absent from BEFORE (and not MOVED or PUBLICIZED) are ADDED: listed by module, public,
private and GENERATED (`f.congr_simp`, `f.eq_n`, `f.eq_def`: reserved names Lean writes on demand) apart. A public one that
is not GENERATED must be in ALLOWED_PUBLIC -> else FAIL. INTERNAL constants are counted per module, never compared.

--plant runs the comparison five more times on AFTER changed in memory and requires each fault reported by name, and
nothing else new: one character of one public stored type; one public constant dropped; one unlisted public constant
added; a moved constant's stored type changed by one character; the publicized constant's type changed by one character.
Usage: fs131_ifr1_statements.py BEFORE AFTER [--plant]   exit 0 iff the comparison is clean (and, with --plant, every
plant fired)
"""
import copy
import gzip
import re
import sys

GENERATED = re.compile(r"\.(congr_simp|eq_\d+|eq_def)$")
OLD_MOD = "Proofs.HadwigerNelson.Collapse.Density.Headline"
NEW_MOD = "Proofs.HadwigerNelson.Collapse.Headline"
MOVED = [
    "HadwigerNelson.Collapse.six_le_chromaticNumber_planeOver_sqrt635087",
    "HadwigerNelson.Collapse.chromaticNumber_planeOver_sqrt635087_le_seven",
    "HadwigerNelson.Collapse.d7",
    "HadwigerNelson.Collapse.F7",
    "HadwigerNelson.Collapse.stablePrime_F7",
    "HadwigerNelson.Collapse.weil_142_lt_sixth",
    "HadwigerNelson.Collapse.exists_model_seven",
]
CR_MOD = "Proofs.HadwigerNelson.Rigidity.ClassRatio"
PUBLICIZED = {
    "_private.Proofs.HadwigerNelson.Rigidity.ClassRatio.0.HadwigerNelson.Rigidity.ratioAtMost_of_charBound":
        "HadwigerNelson.Rigidity.ratioAtMost_of_charBound",
}
# New public constants this job adds, each named with its reason.
ALLOWED_PUBLIC = {
    "HadwigerNelson.Collapse.le_volume_selection": "TJ's second clause (ruling 1, inventory item 1021), FS131-IFR1",
    "HadwigerNelson.Plane.triCentre_sub": "the triangular lattice's linearity (D4's API), FS131-IFR1",
}


def read(path):
    opener = gzip.open if path.endswith(".gz") else open
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


def hyg(text):
    """The old module's name rewritten to the new one inside hygienic names, and nowhere else."""
    return text.replace(f"_@.{OLD_MOD}.", f"_@.{NEW_MOD}.")


def same_decl(c, a, rewrite=False):
    f = hyg if rewrite else (lambda t: t)
    if a["kind"] != c["kind"] or a.get("TYPE") != f(c.get("TYPE", "")):
        return False
    if c["kind"] == "DEF":
        key = "DATA" if "DATA" in c else "VALUE"
        return a.get(key) == f(c.get(key, ""))
    return True


def compare(before, after, quiet=False):
    fails, report = [], []
    moved_seen = set()
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
            if name in MOVED and mod == OLD_MOD:
                a = after.get(NEW_MOD, {}).get(name)
                if name in amod:
                    fails.append(f"MOVED-NOT-REMOVED {name}")
                elif a is None:
                    fails.append(f"MOVED-MISSING {name} (not in {NEW_MOD})")
                elif not same_decl(c, a, rewrite=True):
                    fails.append(f"MOVED-CHANGED {name}")
                else:
                    report.append(f"MOVED OK {name}: {OLD_MOD} -> {NEW_MOD}, stored type and value unchanged")
                moved_seen.add(name)
                continue
            if name in PUBLICIZED and mod == CR_MOD:
                new = PUBLICIZED[name]
                a = amod.get(new)
                if name in amod:
                    fails.append(f"PUBLICIZED-STILL-PRIVATE {name}")
                elif a is None or a["private"]:
                    fails.append(f"PUBLICIZED-MISSING {new}")
                elif not same_decl(c, a):
                    fails.append(f"PUBLICIZED-CHANGED {new}")
                else:
                    report.append(f"PUBLICIZED OK {new}: the word `private` removed, stored type unchanged")
                continue
            a = amod.get(name)
            if a is None:
                fails.append(f"MISSING {name} ({mod})")
                continue
            if same_decl(c, a):
                n_same += 1
            else:
                what = "kind" if a["kind"] != c["kind"] else "type" if a.get("TYPE") != c.get("TYPE") else "value"
                fails.append(f"CHANGED ({what}) {name} ({mod})")
        exempt = set(MOVED) if mod == NEW_MOD else set()
        exempt |= set(PUBLICIZED.values()) if mod == CR_MOD else set()
        added = [(n, a) for n, a in amod.items() if n not in consts and not a["internal"] and n not in exempt]
        a_int = sum(1 for n, a in amod.items() if a["internal"])
        gen = sorted(n for n, a in added if not a["private"] and GENERATED.search(n))
        pub = sorted(n for n, a in added if not a["private"] and not GENERATED.search(n))
        priv = sorted(a["user"] for n, a in added if a["private"])
        for n in pub:
            if n not in ALLOWED_PUBLIC:
                fails.append(f"ADDED-PUBLIC-UNLISTED {n} ({mod})")
        report.append(f"{mod}: before {len(consts)} constants ({n_int} internal); SAME {n_same}; "
                      f"added public {len(pub)} {pub}; added private {len(priv)}; generated on demand {gen}; "
                      f"internal after {a_int}")
        if priv:
            report.append(f"    private added: {priv}")
    for n in MOVED:
        if n not in moved_seen:
            fails.append(f"MOVED-NOT-IN-BEFORE {n}")
    for m in after:
        if m not in before:
            fails.append(f"MODULE-NEW {m}")
    if not quiet:
        for r in report:
            print(r)
    return fails


def bump(t):
    return t[:-1] + ("Y" if t[-1:] == "X" else "X")


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
    mod = "Proofs.HadwigerNelson.Collapse.Density.Headline"
    victim = "HadwigerNelson.Collapse.finIndepRatio_planeOver_eq_localRatio"
    plants = []
    a1 = copy.deepcopy(after); a1[mod][victim]["TYPE"] = bump(a1[mod][victim]["TYPE"])
    plants.append(("a changed stored type", a1, f"CHANGED (type) {victim} ({mod})"))
    a2 = copy.deepcopy(after); del a2[mod][victim]
    plants.append(("a dropped constant", a2, f"MISSING {victim} ({mod})"))
    a3 = copy.deepcopy(after)
    a3[mod]["HadwigerNelson.Collapse.planted_new"] = {"kind": "THM", "internal": False, "private": False,
                                                       "user": "HadwigerNelson.Collapse.planted_new", "TYPE": "True"}
    plants.append(("an unlisted public constant", a3, f"ADDED-PUBLIC-UNLISTED HadwigerNelson.Collapse.planted_new ({mod})"))
    mv = "HadwigerNelson.Collapse.exists_model_seven"
    a4 = copy.deepcopy(after); a4[NEW_MOD][mv]["TYPE"] = bump(a4[NEW_MOD][mv]["TYPE"])
    plants.append(("a moved constant changed", a4, f"MOVED-CHANGED {mv}"))
    pb = "HadwigerNelson.Rigidity.ratioAtMost_of_charBound"
    a5 = copy.deepcopy(after); a5[CR_MOD][pb]["TYPE"] = bump(a5[CR_MOD][pb]["TYPE"])
    plants.append(("the publicized constant changed", a5, f"PUBLICIZED-CHANGED {pb}"))
    for label, a, expect in plants:
        got = compare(before, a, quiet=True)
        new = sorted(set(got) - set(fails))
        hit = expect in new
        extra = [g for g in new if g != expect]
        print(f"PLANT {label}: {'FIRED' if hit and not extra else 'NOT FIRED'} — new failures {new}")
        ok = ok and hit and not extra
    print(f"PLANTS {'ALL FIRED' if ok else 'SOME DID NOT FIRE'}")
    return 0 if ok and not fails else 1


if __name__ == "__main__":
    sys.exit(main())
