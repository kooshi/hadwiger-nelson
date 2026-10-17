#!/usr/bin/env python3
"""FS131-IRF1 — the implementer changed no stored statement or definition of the planner's skeleton, from the kernel's side.

Shaped like FS131-IRU2's comparator (`tools/fs131_iru2_statements.py`): two prints of the dumper
`data/fs131/irf1/lean/StatementDump.lean` (format: `## MODULE <m> constants=<n>`, then per constant
`@@ <KIND> <name> [INTERNAL | PRIVATE <user name>] [PROPTYPE]`, `TYPE <hash> <raw>`, and for a definition `VALUE <hash> <raw>`
and, when its type is not a proposition, `DATA <hash> <raw>` — the value with every proof subterm erased):
  BASE  — the skeleton as the planner built it (`statements-skeleton.txt`, made before the first proof edit);
  AFTER — the filled modules.

For every constant of BASE that is not INTERNAL:
  SAME     AFTER's same module holds it with the same kind, flags and stored type (text), and for a definition the same
           DATA when BASE printed one, else the same VALUE;
  CHANGED  anything else                                                                  -> FAIL;
  MISSING  absent from AFTER                                                              -> FAIL.
AFTER's constants (not INTERNAL) that BASE does not hold are ADDED: each is listed, private or public, and those not in
EXPECTED_HEADS (the one added head, A3, by the brief) are printed as helpers. A generated name (`f.congr_simp`, `f.eq_n`,
`f.eq_def`, `f.match_n`) is listed apart. Also reported for every definition whose DATA agrees: whether its full VALUE agrees
(VALUE-MOVED is information: a proof inside a definition, never a statement).

`example`s are not stored: their heads (from `example` to the first `:=` at depth zero, block comments and docstrings blanked
first) are compared as text, module by module and in order, between the base commit's source and the working tree's.

--plant runs the comparison five more times with AFTER (or the AFTER sources) changed in memory and requires each fault
reported by name: one character of a public stored type in `Compulsion`; one public constant of `Order` dropped; the DATA of
`residueCol` changed; one example head of `Forbid` changed; one example dropped from `Basic`.
Usage: statements.py BASE AFTER BASE_COMMIT [--plant]   exit 0 iff clean (and, with --plant, every plant fired)
"""
import copy
import gzip
import re
import subprocess
import sys

GENERATED = re.compile(r"\.(congr_simp|eq_\d+|eq_def|match_\d+(_\d+)?)$")
EXPECTED_HEADS = {"HadwigerNelson.RationalFour.exists_equiv_coloring_add_eq_residue"}
MODS = ["Basic", "Order", "Compulsion", "Forbid"]
SRC = "Proofs/HadwigerNelson/RationalFour/{}.lean"


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


def blank_comments(s):
    """Blank `/- … -/` (nested, docstrings included) and `--` line comments, keeping offsets."""
    out, i, depth = list(s), 0, 0
    while i < len(s):
        if s.startswith("/-", i):
            depth += 1
            out[i] = out[i + 1] = " "
            i += 2
            continue
        if depth and s.startswith("-/", i):
            depth -= 1
            out[i] = out[i + 1] = " "
            i += 2
            continue
        if depth:
            if s[i] != "\n":
                out[i] = " "
            i += 1
            continue
        if s.startswith("--", i):
            j = s.find("\n", i)
            j = len(s) if j < 0 else j
            for k in range(i, j):
                out[k] = " "
            i = j
            continue
        i += 1
    return "".join(out)


def example_heads(text):
    t = blank_comments(text)
    heads = []
    for m in re.finditer(r"(?m)^example\b", t):
        i, depth = m.start(), 0
        while i < len(t):
            c = t[i]
            if c in "([{⟨":
                depth += 1
            elif c in ")]}⟩":
                depth -= 1
            elif depth == 0 and t.startswith(":=", i):
                break
            i += 1
        heads.append(re.sub(r"\s+", " ", t[m.start():i]).strip())
    return heads


def compare(base, after, srcs_base, srcs_after):
    fails, info, added = [], [], []
    stats = {"SAME": 0, "VALUE-MOVED": 0}
    for m, consts in base.items():
        am = after.get(m)
        if am is None:
            fails.append(f"MODULE-MISSING {m}")
            continue
        for n, c in consts.items():
            if c["internal"]:
                continue
            a = am.get(n)
            if a is None:
                fails.append(f"MISSING {m} {n}")
                continue
            if a["kind"] != c["kind"] or a["flags"] != c["flags"] or a.get("TYPE") != c.get("TYPE"):
                fails.append(f"CHANGED {m} {n} (kind, flags or stored type)")
                continue
            if c["kind"] == "DEF":
                key = "DATA" if "DATA" in c else "VALUE"
                if a.get(key) != c.get(key):
                    fails.append(f"CHANGED {m} {n} ({key})")
                    continue
                if a.get("VALUE") != c.get("VALUE"):
                    stats["VALUE-MOVED"] += 1
                    info.append(f"VALUE-MOVED {m} {n}")
            stats["SAME"] += 1
    for m, am in after.items():
        bm = base.get(m, {})
        for n, a in am.items():
            if a["internal"] or n in bm:
                continue
            tag = "GENERATED" if GENERATED.search(n) else ("HEAD" if n in EXPECTED_HEADS else "HELPER")
            added.append(f"ADDED-{tag} {m} {n} ({'private' if a['private'] else 'public'} {a['kind']})")
    for h in EXPECTED_HEADS:
        if not any(h in am for am in after.values()):
            fails.append(f"HEAD-ABSENT {h}")
    for mod in MODS:
        hb, ha = example_heads(srcs_base[mod]), example_heads(srcs_after[mod])
        if hb != ha:
            fails.append(f"EXAMPLES-DIFFER {mod}: base {len(hb)} heads, after {len(ha)}; first difference: "
                         + next((f"#{i}: {x!r} vs {y!r}" for i, (x, y) in enumerate(zip(hb, ha)) if x != y),
                                "a head added or dropped"))
        else:
            info.append(f"EXAMPLES-SAME {mod}: {len(hb)} heads")
    return fails, info, added, stats


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    plant = "--plant" in sys.argv
    base, after = read(args[0]), read(args[1])
    commit = args[2]
    srcs_base = {m: subprocess.run(["git", "show", f"{commit}:{SRC.format(m)}"], capture_output=True, text=True,
                                   check=True).stdout for m in MODS}
    srcs_after = {m: open(SRC.format(m), encoding="utf-8").read() for m in MODS}
    fails, info, added, stats = compare(base, after, srcs_base, srcs_after)
    for ln in info + added:
        print(ln)
    for ln in fails:
        print("FAIL", ln)
    nb = sum(1 for cs in base.values() for c in cs.values() if not c["internal"])
    print(f"base public-or-private non-internal constants: {nb}; SAME {stats['SAME']}; VALUE-MOVED {stats['VALUE-MOVED']}; "
          f"ADDED {len(added)}; FAILS {len(fails)}")
    ok = not fails
    if plant:
        C, O, B, F = (f"Proofs.HadwigerNelson.RationalFour.{x}" for x in ("Compulsion", "Order", "Basic", "Forbid"))
        plants = []
        a1 = copy.deepcopy(after)
        n1 = "HadwigerNelson.RationalFour.forall_coloring_eq_iff"
        a1[C][n1]["TYPE"] = a1[C][n1]["TYPE"].replace("1", "2", 1)
        plants.append(("type char", a1, srcs_after, f"CHANGED {C} {n1}"))
        a2 = copy.deepcopy(after)
        n2 = "HadwigerNelson.RationalFour.mem_comp_iff"
        del a2[O][n2]
        plants.append(("dropped", a2, srcs_after, f"MISSING {O} {n2}"))
        a3 = copy.deepcopy(after)
        n3 = "HadwigerNelson.RationalFour.residueCol"
        a3[C][n3]["DATA"] = a3[C][n3]["DATA"] + " "
        plants.append(("data", a3, srcs_after, f"CHANGED {C} {n3} (DATA)"))
        s4 = dict(srcs_after)
        s4["Forbid"] = s4["Forbid"].replace("sqDist4 x y = 2 → c x ≠ c y", "sqDist4 x y = 4 → c x ≠ c y", 1)
        plants.append(("example head", after, s4, "EXAMPLES-DIFFER Forbid"))
        s5 = dict(srcs_after)
        s5["Basic"] = s5["Basic"].replace("example : val ⟨1 / 3, 0, 0, 0⟩ = 0", "theorem dropped_ex : val ⟨1 / 3, 0, 0, 0⟩ = 0", 1)
        plants.append(("example dropped", after, s5, "EXAMPLES-DIFFER Basic"))
        for label, aa, ss, want in plants:
            f2, _, _, _ = compare(base, aa, srcs_base, ss)
            new = [x for x in f2 if x not in fails]
            hit = any(x.startswith(want) for x in new)
            print(f"PLANT {label}: {'FIRED' if hit else 'SILENT'} ({len(new)} new: {new[:2]})")
            ok = ok and hit and len(new) == 1
    sys.exit(0 if ok else 1)


main()
