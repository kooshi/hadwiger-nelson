#!/usr/bin/env python3
"""FS131-IRU1 — no stored statement or definition of the five skeleton modules of FS131-KRU1, nor of
`Rigidity/AdmissiblePrime`, changed but the ruled ones, from the kernel's side. After FS131-ICO2's
`data/fs131/ico2/statements.py`.

Reads two prints of `data/fs131/iru1/lean/StatementDump.lean` (`## MODULE <m> constants=<n>`, then per constant
`@@ <KIND> <name> [INTERNAL | PRIVATE <user name>] [PROPTYPE]`, `TYPE <hash> <raw>`, and for a definition
`VALUE <hash> <raw>` and, when its type is not a proposition, `DATA <hash> <raw>` — the value with every proof erased):
  BEFORE — the skeleton's compiled library, printed before any edit (`data/fs131/iru1/statements-before.txt.gz`);
  AFTER  — the build being gated.

For every constant of BEFORE that is not INTERNAL:
  SAME     present in AFTER's module under the same name, same kind, same stored type (hash and text), and for a definition
           the same DATA when BEFORE printed one, else the same VALUE;
  DROPPED  one of DROPPED below (inventory item 1049): BEFORE's stored type holds the instance binder's text exactly once,
           and with it removed is AFTER's stored type character for character;
  RENAMED  one of RENAMED below (inventory item 1044, ruling 1: private made public): BEFORE's private constant is absent
           from AFTER, AFTER holds the public name, the kind and Lean's hash of the stored type (`Expr.hash`, which reads no
           binder name) are equal, and the raw texts are equal once the hygienic number of each instance binder of that
           constant — minted from the declaration's name — is blanked in both;
  CHANGED / MISSING -> FAIL.
AFTER's non-INTERNAL constants absent from BEFORE and not a RENAMED target are ADDED: listed by module, private and
GENERATED (`f.congr_simp`, `f.eq_n`, `f.eq_def`) apart; a new public constant that is not GENERATED -> FAIL (none is
expected: every helper this job adds is private).

--plant runs the comparison four more times on AFTER changed in memory and requires each fault reported by name, and nothing
else new: one character of one head statement's stored type; one public constant dropped; one unlisted public constant
added; the dropped binder removed one character short; and a RENAMED constant whose stored hash differs.
Usage: fs131_iru1_statements.py BEFORE AFTER [--plant]   exit 0 iff clean (and, with --plant, every plant fired)
"""
import copy
import gzip
import re
import sys

GENERATED = re.compile(r"\.(congr_simp|eq_\d+|eq_def)$")
ADM = "Proofs.HadwigerNelson.Rigidity.AdmissiblePrime"
PRIV = "_private.Proofs.HadwigerNelson.Rigidity.AdmissiblePrime.0."
RENAMED = {PRIV + "HadwigerNelson.Rigidity." + n: "HadwigerNelson.Rigidity." + n
           for n in ("exists_integral_primitive", "exists_dvd_of_dvd_exponent", "nonempty_residueHom")}
INST_URE = r" \[inst\._@\.Proofs\.HadwigerNelson\.Rigidity\.UnitRingEq\.\d+\._hygCtx\._hyg\.\d+ : "
DROPPED = {
    "HadwigerNelson.Rigidity.not_isRamified_of_odd_mem": (re.compile(INST_URE + r"NumberField\.\{0\} "), "[NumberField ↥F]"),
}
HYG = re.compile(r"(inst\._@\.Proofs\.HadwigerNelson\.Rigidity\.AdmissiblePrime\.)\d+(\._hygCtx\._hyg\.\d+)")


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
                mods[cur][name] = {"kind": kind, "internal": "INTERNAL" in flags, "private": private,
                                   "user": flags[flags.index("PRIVATE") + 1] if private else name}
                last = mods[cur][name]
            elif ln.startswith(("TYPE ", "VALUE ", "DATA ")):
                tag, rest = ln.split(" ", 1)
                h, raw = rest.split(" ", 1) if " " in rest else (rest, "")
                last[tag] = raw
                last[tag + "H"] = h
    return mods


def strip_binder(text, pattern, short=False):
    ms = list(pattern.finditer(text))
    if len(ms) != 1:
        return None
    start = ms[0].start()
    depth, i = 0, start + 2
    while i < len(text):
        if text[i] == "[":
            depth += 1
        elif text[i] == "]":
            if depth == 0:
                return text[:start] + text[i if short else i + 1:]
            depth -= 1
        i += 1
    return None


def compare(before, after, short_strip=False, quiet=False):
    fails, report = [], []
    targets = set(RENAMED.values())
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
            if name in RENAMED:
                new = RENAMED[name]
                a = amod.get(new)
                ok = (a is not None and name not in amod and not a["private"] and a["kind"] == c["kind"]
                      and a.get("TYPEH") == c.get("TYPEH")
                      and HYG.sub(r"\1#\2", a.get("TYPE", "")) == HYG.sub(r"\1#\2", c.get("TYPE", "")))
                report.append(f"RENAMED {'OK' if ok else 'DIFFERS'} {c['user']} -> {new}: private made public, "
                              f"stored type {'equal (hash; text up to the hygienic numbers)' if ok else 'NOT equal'}")
                if not ok:
                    fails.append(f"RENAMED-DIFFERS {new}")
                continue
            a = amod.get(name)
            if a is None:
                fails.append(f"MISSING {name} ({mod})")
                continue
            if name in DROPPED:
                pat, shown = DROPPED[name]
                s = strip_binder(c.get("TYPE", ""), pat, short=short_strip)
                ok = s is not None and a["kind"] == c["kind"] and s == a.get("TYPE")
                report.append(f"DROPPED {'OK' if ok else 'DIFFERS'} {name}: the binder `{shown}` "
                              f"{'removed exactly' if ok else 'is not the whole difference'}")
                if not ok:
                    fails.append(f"DROPPED-DIFFERS {name}")
                continue
            same = a["kind"] == c["kind"] and a.get("TYPE") == c.get("TYPE") and a.get("TYPEH") == c.get("TYPEH")
            if c["kind"] == "DEF":
                key = "DATA" if "DATA" in c else "VALUE"
                same = same and a.get(key) == c.get(key)
            if same:
                n_same += 1
            else:
                what = "kind" if a["kind"] != c["kind"] else "type" if a.get("TYPE") != c.get("TYPE") else "value"
                fails.append(f"CHANGED ({what}) {name} ({mod})")
        added = [(n, a) for n, a in amod.items() if n not in consts and not a["internal"] and n not in targets]
        a_int = sum(1 for n, a in amod.items() if a["internal"])
        gen = sorted(n for n, a in added if not a["private"] and GENERATED.search(n))
        pub = sorted(n for n, a in added if not a["private"] and not GENERATED.search(n))
        priv = sorted(a["user"] for n, a in added if a["private"])
        for n in pub:
            fails.append(f"ADDED-PUBLIC {n} ({mod})")
        report.append(f"{mod}: before {len(consts)} constants ({n_int} internal); SAME {n_same}; added public {pub}; "
                      f"added private {len(priv)} {priv}; generated on demand {gen}; internal after {a_int}")
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
    mod = "Proofs.HadwigerNelson.Rigidity.UnitRingEq"
    victim = "HadwigerNelson.Rigidity.unitRing_eq_stableIntegers"
    plants = []
    a1 = copy.deepcopy(after); t = a1[mod][victim]["TYPE"]; a1[mod][victim]["TYPE"] = t[:-1] + ("Y" if t[-1:] == "X" else "X")
    plants.append(("a changed stored type", a1, False, f"CHANGED (type) {victim} ({mod})"))
    a2 = copy.deepcopy(after); del a2[mod][victim]
    plants.append(("a dropped constant", a2, False, f"MISSING {victim} ({mod})"))
    a3 = copy.deepcopy(after)
    a3[mod]["HadwigerNelson.Rigidity.planted_new"] = {"kind": "THM", "internal": False, "private": False,
                                                      "user": "HadwigerNelson.Rigidity.planted_new", "TYPE": "True"}
    plants.append(("an unlisted public constant", a3, False, f"ADDED-PUBLIC HadwigerNelson.Rigidity.planted_new ({mod})"))
    plants.append(("the dropped binder a near miss", after, True,
                   "DROPPED-DIFFERS HadwigerNelson.Rigidity.not_isRamified_of_odd_mem"))
    a5 = copy.deepcopy(after)
    tgt = "HadwigerNelson.Rigidity.nonempty_residueHom"
    a5[ADM][tgt]["TYPEH"] = str(int(a5[ADM][tgt]["TYPEH"]) + 1)
    plants.append(("a renamed constant with another stored hash", a5, False, f"RENAMED-DIFFERS {tgt}"))
    for label, a, short, expect in plants:
        got = compare(before, a, short_strip=short, quiet=True)
        new = sorted(set(got) - set(fails))
        hit = expect in new
        extra = [g for g in new if g != expect]
        print(f"PLANT {label}: {'FIRED' if hit and not extra else 'NOT FIRED'} — new failures {new}")
        ok = ok and hit and not extra
    print(f"PLANTS {'ALL FIRED' if ok else 'SOME DID NOT FIRE'}")
    return 0 if ok and not fails else 1


if __name__ == "__main__":
    sys.exit(main())
