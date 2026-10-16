#!/usr/bin/env python3
"""FS131-ICO2 — no stored statement or definition of the collapse's nine modules changed but the ruled ones, from the
kernel's side.

Reads two prints of `data/fs131/ico2/lean/StatementDump.lean` (or of FS131-ICO1's dumper, the same format: `## MODULE <m>
constants=<n>`, then per constant `@@ <KIND> <name> [INTERNAL | PRIVATE <user name>] [PROPTYPE]`, `TYPE <hash> <raw>`, and
for a definition `VALUE <hash> <raw>` and, when its type is not a proposition, `DATA <hash> <raw>` — the value with every
proof subterm erased):
  BEFORE — FS131-ICO1's print of the skeleton's compiled library, made before the first rebuild
           (`data/fs131/ico1/statements-before.txt.gz`);
  AFTER  — this job's print of the build being gated.

For every constant of BEFORE that is not INTERNAL (a public or a private declaration of the file):
  SAME     present in AFTER's same module, same kind, same stored type (text), and for a definition the same DATA when
           BEFORE printed one (a definition holding proofs moves its VALUE when a proof is filled), else the same VALUE;
  RULED    one of RULED below: BEFORE's stored type holds the binder's text exactly once, and with it removed is AFTER's
           stored type character for character (FS131-KN9's one-binder check; item 993's ruling);
  CHANGED  anything else that differs                                                   -> FAIL;
  MISSING  absent from AFTER                                                            -> FAIL.
AFTER's non-INTERNAL constants absent from BEFORE are ADDED: listed by module, public and private apart. A public one must be
in ALLOWED_PUBLIC (the approved edits' two theorems, and the public helpers the implementers added, each named) -> else FAIL.
INTERNAL constants (generated: `_proof_n`, `eq_n`, `match_n`, `_simp_n`, `congr_simp`, …) are counted per module, never
compared: they are what the proofs generate, and the proofs are what changed.

--plant runs the comparison four more times on AFTER changed in memory and requires each fault reported by name, and nothing
else new: one character of one public stored type; one public constant dropped; one unlisted public constant added; and the
ruled binder removed one character short (a check that cannot tell the binder from a near miss would pass it).
Usage: statements.py BEFORE AFTER [--plant]          exit 0 iff the comparison is clean (and, with --plant, every plant fired)
"""
import copy
import gzip
import lzma
import re
import sys

NUMBER_FIELD_BINDER = re.compile(r" \[inst\._@\.Proofs\.HadwigerNelson\.Collapse\.\w+\.\d+\._hygCtx\._hyg\.\d+ : NumberField\.\{0\} ")

# The ruled changes: the stored type loses one instance binder `[NumberField ↥F]` (item 993's ruling, two parts).
RULED = {
    "HadwigerNelson.Collapse.ThickAt.mono": "NumberField",
    "HadwigerNelson.Collapse.measure_ne_eq_k": "NumberField",
}
# Public constants a module may gain: the approved edits D-E1 and D-E2 (brief FS131-ICO1, ruling 1). Every other new
# public constant must be named here before it passes, with the job that added it.
ALLOWED_PUBLIC = {
    "HadwigerNelson.StandingFive.norm_normOne_charSum_le": "D-E1, FS131-ICO1",
    "HadwigerNelson.Rigidity.norm_charSum_le_weil": "D-E2, FS131-ICO1",
}


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


def strip_binder(text, short=False):
    """BEFORE's type with the one `[inst… : NumberField.{0} …]` binder removed, or None unless it occurs exactly once.
    `short` (the plant) keeps the binder's closing bracket: a near miss by one character."""
    ms = list(NUMBER_FIELD_BINDER.finditer(text))
    if len(ms) != 1:
        return None
    start = ms[0].start()
    depth, i = 0, start + 1
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
            a = amod.get(name)
            if a is None:
                fails.append(f"MISSING {name} ({mod})")
                continue
            if name in RULED:
                s = strip_binder(c.get("TYPE", ""), short=short_strip)
                ok = s is not None and a["kind"] == c["kind"] and s == a.get("TYPE")
                report.append(f"RULED {'OK' if ok else 'DIFFERS'} {name}: the binder `[… : NumberField ↥F]` "
                              f"{'removed exactly' if ok else 'is not the whole difference'}")
                if not ok:
                    fails.append(f"RULED-DIFFERS {name}")
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
        pub = sorted(n for n, a in added if not a["private"])
        priv = sorted(a["user"] for n, a in added if a["private"])
        for n in pub:
            if n not in ALLOWED_PUBLIC:
                fails.append(f"ADDED-PUBLIC-UNLISTED {n} ({mod})")
        report.append(f"{mod}: before {len(consts)} constants ({n_int} internal); SAME {n_same}; "
                      f"added public {len(pub)} {pub}; added private {len(priv)}; internal after {a_int}")
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
    mod = "Proofs.HadwigerNelson.Collapse.Headline"
    victim = "HadwigerNelson.Collapse.chromaticNumber_planeOver_sqrt635087"
    plants = []
    a1 = copy.deepcopy(after); t = a1[mod][victim]["TYPE"]; a1[mod][victim]["TYPE"] = t[:-1] + ("Y" if t[-1:] == "X" else "X")
    plants.append(("a changed stored type", a1, False, f"CHANGED (type) {victim} ({mod})"))
    a2 = copy.deepcopy(after); del a2[mod][victim]
    plants.append(("a dropped constant", a2, False, f"MISSING {victim} ({mod})"))
    a3 = copy.deepcopy(after)
    a3[mod]["HadwigerNelson.Collapse.planted_new"] = {"kind": "THM", "internal": False, "private": False,
                                                       "user": "HadwigerNelson.Collapse.planted_new", "TYPE": "True"}
    plants.append(("an unlisted public constant", a3, False, f"ADDED-PUBLIC-UNLISTED HadwigerNelson.Collapse.planted_new ({mod})"))
    plants.append(("the ruled binder a near miss", after, True, "RULED-DIFFERS HadwigerNelson.Collapse.ThickAt.mono"))
    for label, a, short, expect in plants:
        got = compare(before, a, short_strip=short, quiet=True)
        new = sorted(set(got) - set(fails))
        hit = expect in new
        extra = [g for g in new if g != expect and not (short and g.startswith("RULED-DIFFERS"))]
        print(f"PLANT {label}: {'FIRED' if hit and not extra else 'NOT FIRED'} — new failures {new}")
        ok = ok and hit and not extra
    print(f"PLANTS {'ALL FIRED' if ok else 'SOME DID NOT FIRE'}")
    return 0 if ok and not fails else 1


if __name__ == "__main__":
    sys.exit(main())
