"""FS131-IJ2 — no statement and no definition of the modules this job writes changed while it wrote its proofs, and no
stored term of the modules downstream of them moved. (FS131-IJ1's reader, `tools/fs131_ij1_statements.py`, aimed at this
job's eight modules; that one is not edited. This job was given no ruled change: the replacement, rename and publicity
rules of IJ1's reader are kept as options and are not used here.)

The modules: the three this job writes (`Rigidity/ContinuityGroup` — one attribute; `InvariantMeasure`, `BochnerTau` —
proofs) and the five downstream of `ContinuityGroup` it does not write (`CountTorus`, `CountResidue`, `CountCompletion`,
`CountExtension`, `CountDescent`).

Every constant of `before` that is not INTERNAL must be in `after` with the same kind and type, in the same module; a
definition keeps its value; constants only in `after` are NEW (public; must be listed in `--allow-new`) or NEW PRIVATE;
the modules declare no axiom; every `example` head of the base commit's files is in the working files, in order.

Usage:  fs131_ij2_statements.py <before.txt> <after.txt> <base-commit> [--allow-new <file>] [--control]
"""
import pathlib
import re
import subprocess
import sys

MODS = ("ContinuityGroup", "InvariantMeasure", "BochnerTau", "CountTorus", "CountResidue", "CountCompletion",
        "CountExtension", "CountDescent")
FILES = ["Proofs/HadwigerNelson/Rigidity/" + m + ".lean" for m in MODS]
ROOT = pathlib.Path(__file__).resolve().parents[1]
NS = "HadwigerNelson.Rigidity."
MP = "Proofs.HadwigerNelson.Rigidity."
# this job was given no move
MOVED = {}
# the definitions and the leaves this job must leave as they are (each must be found in both dumps)
REQUIRED = [NS + n for n in (
    "profTop", "archTop", "tauPrime", "isTopologicalAddGroup_tauPrime", "isCountablyGenerated_nhds_tauPrime",
    "TA_subset_contChars", "mem_archChars_of_continuousAt", "archContinuousAt_pow_of_mem_contChars",
    "contChars_subset_TA", "contChars_tauPrime", "exists_shiftInvariant_on", "exists_rotInvariant_of_shiftInvariant",
    "invariantMeasureOnClosed_of_countable", "finite_quotient_nsmul", "archimedean_support", "exists_twisted_parts",
    "bochnerOn_tauPrime", "Counting.count_of_oneAvoidingDensityBound")]
SUBST_OLD, SUBST_NEW = "HadwigerNelson.Rigidity.Counting.toL", "HadwigerNelson.Rigidity.ofUnitRing"


def read_dump(path):
    out, cur, mod = {}, None, None
    for ln in pathlib.Path(path).read_text().splitlines():
        if ln.startswith("## MODULE "):
            mod = ln.split(" ")[2]
        elif ln.startswith("@@ "):
            parts = ln.split(" ")
            kind, name, rest = parts[1], parts[2], parts[3:]
            prop = False
            if rest[-1:] == ["PROPTYPE"]:
                prop, rest = True, rest[:-1]
            cur = {"kind": kind, "internal": rest == ["INTERNAL"], "private": None, "prop": prop, "type": None,
                   "value": None, "data": None, "module": mod}
            if rest[:1] == ["PRIVATE"]:
                cur["private"] = " ".join(rest[1:])
            elif rest and rest != ["INTERNAL"]:
                print(f"UNREADABLE HEAD in {path}: {ln[:200]}")
                sys.exit(2)
            if name in out:
                print(f"DUPLICATE NAME IN DUMP {path}: {name} (modules {out[name]['module']}, {mod})")
                sys.exit(2)
            if mod is None:
                print(f"NO MODULE LINE before {name} in {path}")
                sys.exit(2)
            out[name] = cur
        elif ln.startswith("TYPE ") and cur is not None:
            cur["type"] = ln[5:]
        elif ln.startswith("VALUE ") and cur is not None:
            cur["value"] = ln[6:]
        elif ln.startswith("DATA ") and cur is not None:
            cur["data"] = ln[5:]
    if not out:
        print(f"EMPTY DUMP: {path} — the reader or the dumper is broken")
        sys.exit(2)
    mods = {c["module"] for c in out.values()}
    if mods != {MP + m for m in MODS}:
        print(f"BROKEN DUMP {path}: modules {sorted(mods)}")
        sys.exit(2)
    for name, c in out.items():
        if c["type"] is None or (c["kind"] == "DEF" and c["value"] is None) or \
                (c["kind"] == "DEF" and not c["prop"] and c["data"] is None):
            print(f"BROKEN DUMP {path}: {name} lacks its TYPE, VALUE or DATA line")
            sys.exit(2)
    return out


def example_heads(text):
    """every `example` head: from the keyword at the start of a line to the first ` :=` (the statement, as text)"""
    heads = []
    text = re.sub(r"/-.*?-/", lambda m: re.sub(r"[^\n]", " ", m.group(0)), text, flags=re.S)
    for m in re.finditer(r"^example\b", text, flags=re.M):
        j = text.index(":=", m.start())
        heads.append(re.sub(r"\s+", " ", text[m.start():j]).strip())
    return heads


def opt(argv, flag):
    if flag in argv:
        i = argv.index(flag)
        v = {ln.strip() for ln in pathlib.Path(argv[i + 1]).read_text().splitlines()
             if ln.strip() and not ln.startswith("#")}
        del argv[i:i + 2]
        return v
    return set()


def main():
    control = "--control" in sys.argv
    moved_mode = "--moved" in sys.argv or control
    argv = sys.argv[1:]
    allow = opt(argv, "--allow-new")
    dropped = opt(argv, "--dropped")
    ruled_type = opt(argv, "--ruled-type")
    deleted = opt(argv, "--deleted")
    renamed = dict(ln.split() for ln in opt(argv, "--renamed"))
    publicized = opt(argv, "--publicized")
    def subst(t):
        if t is None:
            return t
        for o, n in renamed.items():
            t = re.sub(re.escape(o) + r"(?![A-Za-z0-9_'.])", n, t)
        if SUBST_OLD not in deleted:  # the substitution is the replacement's: off unless `toL` is listed as deleted
            return t
        return re.sub(re.escape(SUBST_OLD) + r"(?![A-Za-z0-9_'])", SUBST_NEW, t)
    subst_ok, pub_ok = [], []
    args = [a for a in argv if not a.startswith("--")]
    before, after, base = read_dump(args[0]), read_dump(args[1]), args[2]
    bad, ruled, moved_ok = [], [], []

    for name in REQUIRED:
        for label, d in (("first", before), ("second", after)):
            if name not in d:
                print(f"BROKEN DUMP: {name} is not in the {label} dump")
                sys.exit(2)

    if control:
        # plant 1: one character of an M3 leaf's stored statement changed in `after`
        victim = NS + "exists_shiftInvariant_on"
        t = after[victim]["type"]
        after[victim]["type"] = t[:40] + "X" + t[41:]
        # plant 2: one data definition's value changed in `after` (the definition the attribute is on)
        after[NS + "archTop"]["value"] = after[NS + "archTop"]["value"] + " x"
        # plant 3: an M2b leaf gone from `after`
        del after[NS + "archimedean_support"]
        # plant 4: a downstream module's stored statement changed (`CountDescent`)
        dv = NS + "Counting.count_of_oneAvoidingDensityBound"
        after[dv]["type"] = after[dv]["type"] + " "
        # plant 5: a constant moved to another module
        after[NS + "tauPrime"] = dict(after[NS + "tauPrime"], module=MP + "BochnerTau")
        # plant 6: a public constant in `after` that the allow-list does not hold
        after[NS + "planted_new_public"] = {"kind": "THM", "internal": False, "private": None, "prop": True,
                                            "type": "0 x", "value": None, "data": None, "module": MP + "InvariantMeasure"}
        # plant 7: an axiom in the modules
        after[NS + "planted_axiom"] = {"kind": "AXIOM", "internal": False, "private": None, "prop": True,
                                       "type": "False", "value": None, "data": None, "module": MP + "ContinuityGroup"}
        # plant 8: a leaf become a definition
        after[NS + "exists_twisted_parts"]["kind"] = "DEF"

    n_cmp = n_val = 0
    priv_by_user = {b["private"]: n for n, b in before.items() if b["private"] is not None}
    for p in sorted(publicized):
        bn = priv_by_user.get(p)
        a = after.get(p)
        if bn is None or a is None or a["private"] is not None:
            bad.append(f"PUBLIC   {p}: not a private constant of the first dump made public in the second")
        elif a["kind"] != before[bn]["kind"] or a["type"] != before[bn]["type"] or a["module"] != before[bn]["module"]:
            bad.append(f"PUBLIC   {p}: kind, stored type or module differs from the private constant's")
        else:
            pub_ok.append(f"RULED PUBLIC {a['kind']} {p}: was {bn}; stored type identical, module {a['module']}")
    for name, b in before.items():
        if b["internal"]:
            continue
        if b["private"] is not None and b["private"] in publicized:
            continue
        n_cmp += 1
        if name in deleted:
            if name in after:
                bad.append(f"DELETED  {name}: listed as deleted and still in the second dump")
            else:
                ruled.append(f"RULED DELETE {b['kind']} {name}: in the first dump only (the ruled replacement)")
            continue
        aname = renamed.get(name, name)
        a = after.get(aname)
        if a is None:
            bad.append(f"MISSING  {b['kind']} {name}: in the first dump, not in the second")
            continue
        if aname != name:
            if name in after:
                bad.append(f"RENAMED  {name}: listed as renamed to {aname} and still in the second dump")
            ruled.append(f"RULED RENAME {b['kind']} {name} -> {aname}")
        # a stored term's line is `<Lean's hash> <the term>`: the hash moves with the name, so the substitution is
        # compared on the term alone
        def body(t):
            return t.split(" ", 1)[1]
        # a renamed theorem's instance binders carry a hygienic hash minted from its name
        # (`inst._@.<module>.<hash>._hygCtx._hyg.<k>`): for a renamed constant alone, that hash is blanked
        def hyg(t):
            return re.sub(r"(_@\.[A-Za-z0-9_.]+?\.)\d+(\._hygCtx)", r"\1<H>\2", t) if aname != name else t
        if a["type"] != b["type"] and hyg(body(a["type"])) == hyg(body(subst(b["type"]))):
            nh = sum(1 for x, y in zip(body(subst(b["type"])).split(" "), body(a["type"]).split(" ")) if x != y)
            subst_ok.append(f"RULED SUBST TYPE {b['kind']} {name}: differs only in the replaced name"
                            + (f" (and the hygienic hash of {nh} binder-name tokens of the renamed theorem)" if nh else ""))
            b = dict(b, type=a["type"])
        if b["kind"] == "DEF" and not b["prop"] and a["value"] != b["value"] and body(a["value"]) == body(subst(b["value"])):
            subst_ok.append(f"RULED SUBST VALUE DEF {name}: differs only in the replaced name")
            b = dict(b, value=a["value"])
        if name in MOVED:
            old, new = MOVED[name]
            want_b, want_a = old, (new if moved_mode else old)
            if b["module"] != want_b or a["module"] != want_a:
                bad.append(f"MOVE     {name}: {b['module']} -> {a['module']}; expected {want_b} -> {want_a}")
        elif a["module"] != b["module"]:
            bad.append(f"MODULE   {name}: {b['module']} -> {a['module']} (a move the job was not given)")
        if a["kind"] != b["kind"]:
            bad.append(f"KIND     {name}: {b['kind']} -> {a['kind']}")
        if a["prop"] != b["prop"]:
            bad.append(f"PROP     {name}: proposition {b['prop']} -> {a['prop']}")
        hyg = 0
        if a["type"] != b["type"] and name in MOVED:
            # a statement elaborated in another file stores its instance binders under names that carry the file's
            # module (`inst._@.<module>.<n>._hygCtx._hyg.<k>`, LEAN.md FS131-IU1, FS131-ID1): rewrite the old and the new
            # module's name there and no other, and compare Lean's hash (blind to binder names) unrewritten
            old, new = MOVED[name]
            def norm(t):
                return t.replace(f"_@.{old}.", "_@.<MOVED>.").replace(f"_@.{new}.", "_@.<MOVED>.")
            ha, hb = a["type"].split(" ", 1)[0], b["type"].split(" ", 1)[0]
            if ha == hb and norm(a["type"]) == norm(b["type"]):
                hyg = sum(1 for x, y in zip(b["type"].split(" "), a["type"].split(" ")) if x != y)
        if a["type"] != b["type"] and not hyg:
            if name in dropped:
                ruled.append(f"RULED DROP {b['kind']} {name}: the stored statement differs (a dropped unread binder)")
            elif name in ruled_type:
                ruled.append(f"RULED TYPE {b['kind']} {name}: the stored statement differs (a change the coordinator ruled)")
            else:
                bad.append(f"TYPE     {b['kind']} {name}: the stored statement differs")
        elif name in MOVED and a["kind"] == b["kind"]:
            how = (f"identical up to the module's name in {hyg} hygienic instance-binder names, Lean's hash equal"
                   if hyg else "stored type unchanged")
            moved_ok.append(f"IDENTICAL {b['kind']} {name}: {how}; module {b['module']} -> {a['module']}")
        if b["kind"] == "DEF" and not b["prop"]:
            n_val += 1
            if a["value"] != b["value"]:
                bad.append(f"VALUE    DEF {name}: the stored definition differs")
    for d in sorted(dropped):
        if d not in before:
            bad.append(f"DROPPED  {d}: listed as a dropped binder's statement and not in the first dump")
    axioms = sorted(n for d in (before, after) for n, c in d.items() if c["kind"] == "AXIOM")
    if axioms:
        bad.append(f"AXIOMS   the modules must declare no axiom: {axioms}")
    new_pub = sorted(n for n, a in after.items() if n not in before and not a["internal"] and a["private"] is None
                     and a["kind"] != "AXIOM" and n not in publicized and n not in renamed.values())
    new_priv = sorted(n for n, a in after.items() if n not in before and a["private"] is not None)
    for n in new_pub:
        if n not in allow:
            bad.append(f"NEW      {after[n]['kind']} {n}: a new public constant that the allow-list does not hold")
    if not control:
        for n in sorted(allow):
            if n not in new_pub:
                bad.append(f"ALLOWED  {n}: listed as new and not found among the second dump's new constants")
    n_int_b = sum(1 for b in before.values() if b["internal"])
    n_int_a = sum(1 for a in after.values() if a["internal"])

    n_ex = 0
    added = []
    for f in FILES:
        old = subprocess.run(["git", "show", f"{base}:{f}"], cwd=ROOT, capture_output=True, text=True, check=True).stdout
        new_text = (ROOT / f).read_text()
        ho, hn = example_heads(old), example_heads(new_text)
        pos = 0
        for k, x in enumerate(ho):
            n_ex += 1
            try:
                pos = hn.index(x, pos) + 1
            except ValueError:
                bad.append(f"EXAMPLE  {f} #{k + 1}: its statement is not in the working file (in order)\n    was: {x[:160]}")
        for y in hn:
            if y not in ho:
                added.append(f"  NEW EXAMPLE {f}: {y[:150]}")

    print(f"compared: {n_cmp} named constants of the first dump (kinds, types, modules), {n_val} data definitions' "
          f"values, {n_ex} example heads of the base files")
    print(f"internal (not compared): {n_int_b} before, {n_int_a} after")
    for m in moved_ok:
        print(m)
    print(f"new public constants in the second dump: {len(new_pub)} (allow-list: {len(allow)})")
    for n in new_pub:
        print(f"  NEW {after[n]['kind']} {n}")
    print(f"new private constants in the second dump: {len(new_priv)}")
    for n in new_priv:
        print(f"  NEW PRIVATE {after[n]['kind']} {after[n]['private']}  ({after[n]['module']})")
    print(f"examples in the working files that the base does not hold: {len(added)}")
    for a in added:
        print(a)
    for r in ruled + pub_ok + subst_ok:
        print(r)
    for b in bad:
        print(b)
    if control:
        want = 8
        ok = len(bad) == want and not moved_ok
        print(f"CONTROL: {len(bad)} of {want} planted faults reported — "
              f"{'the check can fail' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
        sys.exit(0 if ok else 1)
    print("PASS: no statement and no definition changed but the ruled ones listed above"
          if not bad else f"FAIL: {len(bad)} difference(s)")
    sys.exit(0 if not bad else 1)


if __name__ == "__main__":
    main()
