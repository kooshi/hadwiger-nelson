"""FS131-ILA1 — no statement and no definition of `Rigidity/UnitCircle` changed while this job wrote the proof of
`exists_admissiblePair` (and imported its new module), and no stored term of the two modules downstream of it moved.
(FS131-IM11's reader, `tools/fs131_im11_statements.py`, aimed at this job's modules, its publicization and dropped-binder
machinery taken out and a module the second dump alone holds admitted by name; that one is not edited.)

The modules: `Rigidity/UnitCircle` (the proof of one theorem, one import line), and `Rigidity/Pieces`,
`Rigidity/EntropySplitMax` (downstream; they recompile when `UnitCircle` does), dumped before any edit and after the last
build by `data/fs131/ila1/lean/StatementDump.lean`; the second dump also holds the new module `Rigidity/AdmissiblePrime`
(`NEWMOD`), every constant of which is new.

Checked: every constant of `before` that is not INTERNAL is in `after` with the same kind, the same stored type, in the same
module; a definition keeps its stored value; `after`'s constants that `before` lacks are NEW (public; each must be listed in
`--allow-new`) or NEW PRIVATE (listed); no module declares an axiom; every `example` head of the base commit's three files
is in the working files, in order. `exists_admissiblePair` must be in both dumps (`REQUIRED`), with the same stored type.

Usage:  fs131_ila1_statements.py <before.txt> <after.txt> <base-commit> [--allow-new <file>] [--control]
--control plants eight faults in memory and requires each to be reported.
"""
import pathlib
import re
import subprocess
import sys

MP = "Proofs.HadwigerNelson.Rigidity."
MODS = ("UnitCircle", "Pieces", "EntropySplitMax")
NEWMOD = "AdmissiblePrime"
FILES = ["Proofs/HadwigerNelson/Rigidity/" + m + ".lean" for m in MODS]
ROOT = pathlib.Path(__file__).resolve().parents[1]
NS = "HadwigerNelson.Rigidity."
REQUIRED = [NS + n for n in (
    "exists_admissiblePair", "AdmissiblePair", "AdmissiblePair.ofPow", "zpowHom", "unitCircle", "toUnitVector",
    "AdmissiblePair.u_nonTorsion", "isHaarFourier_or_ksEntropy_eq_zero")]


def read_dump(path, allowed_mods):
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
    if mods != {MP + m for m in allowed_mods}:
        print(f"BROKEN DUMP {path}: modules {sorted(mods)}, expected {sorted(MP + m for m in allowed_mods)}")
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
    argv = sys.argv[1:]
    allow = opt(argv, "--allow-new")
    args = [a for a in argv if not a.startswith("--")]
    before = read_dump(args[0], MODS)
    after = read_dump(args[1], MODS + (NEWMOD,))
    base = args[2]
    bad = []

    for name in REQUIRED:
        for label, d in (("first", before), ("second", after)):
            if name not in d:
                print(f"BROKEN DUMP: {name} is not in the {label} dump")
                sys.exit(2)

    if control:
        # 1: the leaf's stored statement changed
        v = NS + "exists_admissiblePair"
        t = after[v]["type"]
        after[v]["type"] = t[:40] + "X" + t[41:]
        # 2: a data definition's value changed
        after[NS + "zpowHom"]["value"] = after[NS + "zpowHom"]["value"] + " x"
        # 3: a constant gone
        del after[NS + "AdmissiblePair.ofPow"]
        # 4: a downstream module's stored statement changed
        dv = NS + "isHaarFourier_or_ksEntropy_eq_zero"
        after[dv]["type"] = after[dv]["type"] + " "
        # 5: a constant moved to another module
        after[NS + "toUnitVector"] = dict(after[NS + "toUnitVector"], module=MP + NEWMOD)
        # 6: a public constant that the allow-list does not hold
        after[NS + "planted_new_public"] = {"kind": "THM", "internal": False, "private": None, "prop": True,
                                            "type": "0 x", "value": None, "data": None, "module": MP + NEWMOD}
        # 7: an axiom in the new module
        after[NS + "planted_axiom"] = {"kind": "AXIOM", "internal": False, "private": None, "prop": True,
                                       "type": "0 False", "value": None, "data": None, "module": MP + NEWMOD}
        # 8: a theorem become a definition
        after[NS + "AdmissiblePair.u_nonTorsion"]["kind"] = "DEF"

    n_cmp = n_val = 0
    for bn, b in before.items():
        if b["internal"]:
            continue
        n_cmp += 1
        a = after.get(bn)
        if a is None:
            bad.append(f"MISSING  {b['kind']} {bn}: in the first dump, not in the second")
            continue
        if a["module"] != b["module"]:
            bad.append(f"MODULE   {bn}: {b['module']} -> {a['module']}")
        if a["kind"] != b["kind"]:
            bad.append(f"KIND     {bn}: {b['kind']} -> {a['kind']}")
        if a["prop"] != b["prop"]:
            bad.append(f"PROP     {bn}: proposition {b['prop']} -> {a['prop']}")
        if a["type"] != b["type"]:
            bad.append(f"TYPE     {b['kind']} {bn}: the stored statement differs")
        if b["kind"] == "DEF" and not b["prop"]:
            n_val += 1
            if a["value"] != b["value"]:
                bad.append(f"VALUE    DEF {bn}: the stored definition differs")
    axioms = sorted(n for d in (before, after) for n, c in d.items() if c["kind"] == "AXIOM")
    if axioms:
        bad.append(f"AXIOMS   the modules must declare no axiom: {axioms}")
    new_pub = sorted(n for n, a in after.items() if n not in before and not a["internal"] and a["private"] is None
                     and a["kind"] != "AXIOM")
    new_priv = sorted(n for n, a in after.items() if n not in before and a["private"] is not None)
    new_int = sorted(n for n, a in after.items() if n not in before and a["internal"])
    for n in new_pub:
        if n not in allow:
            bad.append(f"NEW      {after[n]['kind']} {n}: a new public constant that the allow-list does not hold")
    if not control:
        for n in sorted(allow):
            if n not in new_pub:
                bad.append(f"ALLOWED  {n}: listed as new and not found among the second dump's new constants")
    for n in new_pub + new_priv:
        if after[n]["module"] != MP + NEWMOD:
            bad.append(f"NEWPLACE {n}: a new constant outside {NEWMOD} ({after[n]['module']})")

    n_ex = 0
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
                bad.append(f"EXAMPLE  {f} #{k + 1}: its statement is not in the working file (in order)")

    print(f"compared: {n_cmp} named constants of the first dump (kinds, types, modules), {n_val} data definitions' "
          f"values, {n_ex} example heads of the base files")
    print(f"new public constants in the second dump: {len(new_pub)} (allow-list: {len(allow)})")
    for n in new_pub:
        print(f"  NEW {after[n]['kind']} {n}  ({after[n]['module']})")
    print(f"new private constants in the second dump: {len(new_priv)}")
    for n in new_priv:
        print(f"  NEW PRIVATE {after[n]['kind']} {after[n]['private']}  ({after[n]['module']})")
    print(f"new internal constants in the second dump: {len(new_int)}")
    for n in new_int:
        print(f"  NEW INTERNAL {after[n]['kind']} {n}  ({after[n]['module']})")
    for b in bad:
        print(b)
    if control:
        want = 8
        ok = len(bad) == want
        print(f"CONTROL: {len(bad)} of {want} planted faults reported — "
              f"{'the check can fail' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
        sys.exit(0 if ok else 1)
    print("PASS: no statement and no definition changed" if not bad else f"FAIL: {len(bad)} difference(s)")
    sys.exit(0 if not bad else 1)


if __name__ == "__main__":
    main()
