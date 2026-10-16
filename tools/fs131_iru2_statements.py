#!/usr/bin/env python3
"""FS131-IRU2 — the merge of `main` into `fs131-kru1` changed no stored statement or definition of either line, from the
kernel's side. A copy of FS131-IFR2's comparator (`tools/fs131_ifr2_statements.py`): the sides, the ruled publicizations and
the plants replaced; the comparison itself unchanged.

Reads three prints of FS131-ICO2's dumper (format: `## MODULE <m> constants=<n>`, then per constant
`@@ <KIND> <name> [INTERNAL | PRIVATE <user name>] [PROPTYPE]`, `TYPE <hash> <raw>`, and for a definition `VALUE <hash> <raw>`
and, when its type is not a proposition, `DATA <hash> <raw>` — the value with every proof subterm erased):
  IRU1   — FS131-IRU1's gated build 3 (gate `ddb765bac`; `data/fs131/iru1/statements-after-build3.txt.gz`; six modules);
  MAIN   — `main`'s gated build (FS131-IFR2's, of `b8cef1f36`; `data/fs131/ifr2/statements-merged.txt.gz`; 27 modules);
  MERGED — the merged build being gated (`data/fs131/iru2/lean/StatementDump.lean`; the union, 33 modules).

The two sides cover disjoint module sets. For each side S and every constant c of S that is not INTERNAL:
  SAME        MERGED's same module holds c with the same kind, the same flags, the same stored type (text), and for a
              definition the same DATA when S printed one, else the same VALUE;
  PUBLICIZED  c is S's private `_private.<m>.0.<n>`, the OTHER side ruled `n` public (RULED_PUBLIC below), and MERGED holds
              `n` public in the same module with the same kind and the same stored type up to the hygienic hash an instance
              binder's name carries (FS131-ICS1's finding). Idle here: the one ruled set (FS131-IRU1's three lemmas of
              `Rigidity/AdmissiblePrime`, item 1044) is in a module only IRU1's print covers, where they are already public;
  CHANGED     anything else that differs                                                                  -> FAIL;
  MISSING     absent from MERGED                                                                          -> FAIL.
MERGED's constants (not INTERNAL) of a covered module that no side holds under their name, and that are not a PUBLICIZED
form, are ADDED -> FAIL unless GENERATED (`f.congr_simp`, `f.eq_n`, `f.eq_def`: reserved names Lean writes on demand):
a merge adds no declaration. A constant both sides hold with different text is reported CONFLICT -> FAIL. Modules MERGED
holds and no side covers are counted, not compared. INTERNAL constants are counted per module, never compared.
Also reported: for every definition whose DATA (or VALUE) agrees, whether its full VALUE also agrees (VALUE-MOVED is
information: a proof term inside a definition, never a statement).

--plant runs the comparison six more times on MERGED changed in memory and requires each fault reported by name, and
nothing else new: one character of a public stored type in `Rigidity/UnitRingEq` (recompiled by the merge); one public
constant of `Rigidity/UsablePrime` dropped; one unlisted public constant added to `Instances/UnitRingModels`; one character
of a public stored type in `Collapse/Density/Headline`; one public constant of `Rigidity/FourColourPlaces` dropped;
FS131-IRU1's publicization of `exists_integral_primitive` undone (MERGED holding it private).
Usage: fs131_iru2_statements.py IRU1 MAIN MERGED [--plant]   exit 0 iff the comparison is clean (and, with --plant, every
plant fired)
"""
import copy
import gzip
import re
import sys

GENERATED = re.compile(r"\.(congr_simp|eq_\d+|eq_def)$")
AP = "Proofs.HadwigerNelson.Rigidity.AdmissiblePrime"
# The ruled publicizations, each by the landing that ruled it.
RULED_PUBLIC = {
    "HadwigerNelson.Rigidity.exists_integral_primitive": "IRU1",   # inventory item 1044
    "HadwigerNelson.Rigidity.exists_dvd_of_dvd_exponent": "IRU1",  # inventory item 1044
    "HadwigerNelson.Rigidity.nonempty_residueHom": "IRU1",         # inventory item 1044
}
HYG = re.compile(r"(inst\._@\.[A-Za-z0-9_.]+?\.)\d+(\._hygCtx)")


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
                kind, name, flags = parts[1], parts[2], parts[3:]
                private = "PRIVATE" in flags
                mods[cur][name] = {"kind": kind, "flags": " ".join(flags), "internal": "INTERNAL" in flags,
                                   "private": private,
                                   "user": flags[flags.index("PRIVATE") + 1] if private else name}
                last = mods[cur][name]
            elif ln.startswith(("TYPE ", "VALUE ", "DATA ")):
                tag, rest = ln.split(" ", 1)
                _h, raw = rest.split(" ", 1) if " " in rest else (rest, "")
                last[tag] = raw
    return mods


def same(c, a):
    """(statement equal, full value equal)."""
    if a["kind"] != c["kind"] or a["flags"] != c["flags"] or a.get("TYPE") != c.get("TYPE"):
        return False, False
    if c["kind"] == "DEF":
        key = "DATA" if "DATA" in c else "VALUE"
        return a.get(key) == c.get(key), a.get("VALUE") == c.get("VALUE")
    return True, True


def compare(sides, merged, quiet=False):
    fails, info = [], []
    stats = {"SAME": 0, "PUBLICIZED": 0, "VALUE-MOVED": 0}
    covered = {}
    for sname, smods in sides.items():
        for m in smods:
            covered.setdefault(m, []).append(sname)
    # conflicts between the sides
    for m, ss in covered.items():
        if len(ss) == 2:
            a, b = sides[ss[0]][m], sides[ss[1]][m]
            for n in set(a) & set(b):
                if a[n]["internal"]:
                    continue
                if same(a[n], b[n])[0] is False:
                    fails.append(f"CONFLICT {m} {n}: the two sides' stored texts differ")
    for sname, smods in sides.items():
        other = [o for o in sides if o != sname][0]
        for m, consts in smods.items():
            mm = merged.get(m)
            if mm is None:
                fails.append(f"MODULE-MISSING {m} (covered by {sname})")
                continue
            for n, c in consts.items():
                if c["internal"]:
                    continue
                a = mm.get(n)
                if a is not None:
                    st, full = same(c, a)
                    if st:
                        stats["SAME"] += 1
                        if not full:
                            stats["VALUE-MOVED"] += 1
                            info.append(f"VALUE-MOVED {m} {n} (vs {sname})")
                    else:
                        fails.append(f"CHANGED {m} {n} (vs {sname})")
                    continue
                if c["private"] and RULED_PUBLIC.get(c["user"]) == other:
                    pub = mm.get(c["user"])
                    if pub is None or pub["private"] or pub["internal"]:
                        fails.append(f"MISSING {m} {n} (vs {sname}; ruled public by {other}, not public in MERGED)")
                    elif pub["kind"] != c["kind"] or HYG.sub(r"\1#\2", pub.get("TYPE", "")) != HYG.sub(r"\1#\2", c.get("TYPE", "")):
                        fails.append(f"CHANGED {m} {c['user']} (PUBLICIZED by {other}; stored type differs from {sname}'s private one)")
                    else:
                        stats["PUBLICIZED"] += 1
                        info.append(f"PUBLICIZED {m} {c['user']} (private in {sname}, ruled public by {other}; type equal up to the hygienic hash)")
                    continue
                fails.append(f"MISSING {m} {n} (vs {sname})")
    added = []
    for m, ss in covered.items():
        mm = merged.get(m, {})
        for n, a in mm.items():
            if a["internal"]:
                continue
            if any(n in sides[s][m] for s in ss):
                continue
            if not a["private"] and RULED_PUBLIC.get(n) and any(
                    f"_private.{m}.0.{n}" in sides[s][m] for s in ss):
                continue
            if GENERATED.search(n):
                added.append(f"GENERATED {m} {n}")
            else:
                fails.append(f"ADDED {m} {n} ({'private' if a['private'] else 'public'}): a merge adds no declaration")
    uncovered = {m: (sum(1 for a in mm.values() if not a["internal"]), len(mm)) for m, mm in merged.items() if m not in covered}
    if not quiet:
        for m in merged:
            mm = merged[m]
            print(f"MODULE {m}: {len(mm)} constants ({sum(a['internal'] for a in mm.values())} internal); "
                  f"covered by {', '.join(covered.get(m, ['none: counted, not compared']))}")
        for line in info:
            print(line)
        for line in added:
            print(line)
        for m, (k, t) in uncovered.items():
            print(f"UNCOVERED {m}: {k} non-internal of {t} constants, not compared (no gated dump holds it)")
        print(f"COUNTS SAME={stats['SAME']} PUBLICIZED={stats['PUBLICIZED']} VALUE-MOVED={stats['VALUE-MOVED']} "
              f"GENERATED-ADDED={len(added)}")
        for f in fails:
            print("FAIL", f)
        print(f"VERDICT {'CLEAN' if not fails else 'FAILED'}: {len(fails)} failure(s)")
    return fails


def first_public(mods, m, pred=lambda n, a: True):
    for n, a in mods[m].items():
        if not a["internal"] and not a["private"] and pred(n, a):
            return n
    raise SystemExit(f"plant: no public constant in {m}")


def plants(sides, merged):
    out = []
    P = "Proofs.HadwigerNelson."
    URE, USP, URM = P + "Rigidity.UnitRingEq", P + "Rigidity.UsablePrime", P + "Instances.UnitRingModels"
    DEN, FCP = P + "Collapse.Density.Headline", P + "Rigidity.FourColourPlaces"

    def flip(t):
        i = t.index("Real") if "Real" in t else 0
        return t[:i] + ("X" if t[i] != "X" else "Y") + t[i + 1:]

    m1 = copy.deepcopy(merged); n1 = first_public(m1, URE); m1[URE][n1]["TYPE"] = flip(m1[URE][n1]["TYPE"])
    out.append(("ring type changed", m1, f"CHANGED {URE} {n1}"))
    m2 = copy.deepcopy(merged); n2 = first_public(m2, USP); del m2[USP][n2]
    out.append(("ring constant dropped", m2, f"MISSING {USP} {n2}"))
    m3 = copy.deepcopy(merged); n3 = first_public(m3, URM)
    m3[URM]["HadwigerNelson.UnitRingModels.planted_extra"] = dict(m3[URM][n3])
    out.append(("unlisted public added", m3, f"ADDED {URM} HadwigerNelson.UnitRingModels.planted_extra"))
    m4 = copy.deepcopy(merged); n4 = first_public(m4, DEN); m4[DEN][n4]["TYPE"] = flip(m4[DEN][n4]["TYPE"])
    out.append(("density type changed", m4, f"CHANGED {DEN} {n4}"))
    m5 = copy.deepcopy(merged); n5 = first_public(m5, FCP); del m5[FCP][n5]
    out.append(("five-colour constant dropped", m5, f"MISSING {FCP} {n5}"))
    m6 = copy.deepcopy(merged); un = "HadwigerNelson.Rigidity.exists_integral_primitive"
    c = m6[AP].pop(un); c = dict(c); c["private"] = True; c["user"] = un; c["flags"] = f"PRIVATE {un} PROPTYPE"
    m6[AP][f"_private.{AP}.0.{un}"] = c
    out.append(("IRU1's publicization undone", m6, f"MISSING {AP} {un} (vs IRU1)"))
    ok = True
    for label, mm, want in out:
        fails = compare(sides, mm, quiet=True)
        hit = [f for f in fails if f.startswith(want)]
        print(f"PLANT {label}: {'FIRED' if hit else 'NOT FIRED'} ({len(fails)} failure(s); wanted {want!r})")
        for f in fails[:4]:
            print("   ", f)
        ok = ok and bool(hit)
    return ok


def main():
    args = [a for a in sys.argv[1:] if a != "--plant"]
    sides = {"IRU1": read(args[0]), "MAIN": read(args[1])}
    merged = read(args[2])
    fails = compare(sides, merged)
    if "--plant" in sys.argv:
        ok = plants(sides, merged)
        print("PLANTS", "ALL FIRED" if ok else "NOT ALL FIRED")
        sys.exit(0 if (ok and not fails) else 1)
    sys.exit(1 if fails else 0)


main()
