"""FS131-IM11 — no statement and no definition of the modules this job writes changed while it wrote its proofs, but
the ruled one (helpers of `Rigidity/ContinuityGroup` made public, inventory item 873 ruling 1); and no stored term of the
modules downstream of `ContinuityGroup` moved. (FS131-IJ1's reader, `tools/fs131_ij1_statements.py`, aimed at this job's
ten modules, its replacement machinery taken out and the publicization made checkable; that one is not edited.)

The modules: the four this job writes (`Rigidity/SpectralSubspace`, `TraceSplit`, `APlus` — proofs and private helpers;
`ContinuityGroup` — `private` removed from named helpers) and the six downstream of `ContinuityGroup` it does not write
(`BochnerTau`, `CountTorus`, `CountResidue`, `CountCompletion`, `CountExtension`, `CountDescent`).

**The ruled change, checked mechanically** (`--publicized <file>`, lines `<public full name>`): the first dump's private
constant of that user name must be in the second as the public constant, with the same kind and module, and the same
stored type and (for a definition) value once the substitution below is made (`RULED PUBLIC`). **The substitution**
(`SUBST`): in every stored term of the first dump, each publicized constant's private name
`_private.<module>.0.<name>` — and any name it prefixes (`<name>._proof_1`, `<name>.congr_simp`) — is replaced by the
public name. A constant whose stored term differs as stored and agrees after the substitution is reported
`RULED SUBST` (listed); one that differs after the substitution fails. A first-dump private constant whose user name is
prefixed by a publicized name (`archHom.congr_simp`, a generated theorem) is compared with the second dump's public
constant of that name when the second has it, and is otherwise reported `GONE GENERATED` (a theorem Lean generates on
demand; not a statement of the file).

Otherwise as FS131-IJ1's reader: every constant of `before` that is not INTERNAL must be in `after` with the same kind
and type, in the same module; a definition keeps its value; constants only in `after` are NEW (public; must be listed in
`--allow-new`) or NEW PRIVATE; the modules declare no axiom; every `example` head of the base commit's files is in the
working files, in order.

Usage:  fs131_im11_statements.py <before.txt> <after.txt> <base-commit> [--publicized <file>] [--allow-new <file>]
        [--control]
"""
import pathlib
import re
import subprocess
import sys

MODS = ("SpectralSubspace", "TraceSplit", "APlus", "ContinuityGroup", "BochnerTau", "CountTorus", "CountResidue",
        "CountCompletion", "CountExtension", "CountDescent")
FILES = ["Proofs/HadwigerNelson/Rigidity/" + m + ".lean" for m in MODS]
ROOT = pathlib.Path(__file__).resolve().parents[1]
NS = "HadwigerNelson.Rigidity."
MP = "Proofs.HadwigerNelson.Rigidity."
# the definitions and the leaves this job must leave as they are (each must be found in both dumps)
REQUIRED = [NS + n for n in (
    "trigPoly", "koopmanSum", "gram_sum_eq", "posDef_koopman", "exists_isSpectralMeasureOf", "spectral_null_of_orthogonal",
    "isSpectralMeasureOf_condExpL2", "spectral_null_model", "colourShift", "colourFactor", "colourInd", "colourCond",
    "trace_decomp", "setIntegral_compl_TA_re", "setIntegral_compl_TA_rot", "colourRot", "minSel", "factorColouring",
    "EqualAtUnits", "factorLaw", "factorLaw_trace_null", "aPlusOfR88", "numberField_bot", "aplus_model", "profTop",
    "archTop", "tauPrime", "contChars_tauPrime", "bochnerOn_tauPrime", "Counting.count_of_oneAvoidingDensityBound")]


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


def body(t):
    """a stored term's line is `<Lean's hash> <the term>`: the hash moves with every constant's name"""
    return None if t is None else t.split(" ", 1)[1]


def main():
    control = "--control" in sys.argv
    argv = sys.argv[1:]
    allow = opt(argv, "--allow-new")
    publicized = opt(argv, "--publicized")
    args = [a for a in argv if not a.startswith("--")]
    before, after, base = read_dump(args[0]), read_dump(args[1]), args[2]
    bad, ruled, subst_ok, pub_ok = [], [], [], []

    # the private full name of each publicized constant, from the first dump
    priv_by_user = {b["private"]: n for n, b in before.items() if b["private"] is not None}
    prefixes = {}
    for p in sorted(publicized):
        if p not in priv_by_user:
            bad.append(f"PUBLIC   {p}: no private constant of that user name in the first dump")
        else:
            prefixes[priv_by_user[p]] = p

    def subst(t):
        if t is None:
            return t
        for old, new in prefixes.items():
            t = re.sub(re.escape(old) + r"(?![A-Za-z0-9_'])", new, t)
        return t

    def pub_target(bn, b):
        """the public name a first-dump private constant becomes, if it is publicized or prefixed by one"""
        u = b["private"]
        if u is None:
            return None
        for p in publicized:
            if u == p or u.startswith(p + "."):
                return u
        return None

    for name in REQUIRED:
        for label, d in (("first", before), ("second", after)):
            if name not in d:
                print(f"BROKEN DUMP: {name} is not in the {label} dump")
                sys.exit(2)

    if control:
        # plant 1: one character of an M11 leaf's stored statement changed in `after`
        victim = NS + "spectral_null_of_orthogonal"
        t = after[victim]["type"]
        after[victim]["type"] = t[:40] + "X" + t[41:]
        # plant 2: one data definition's value changed in `after`
        after[NS + "colourShift"]["value"] = after[NS + "colourShift"]["value"] + " x"
        # plant 3: an M11 leaf gone from `after`
        del after[NS + "factorLaw_trace_null"]
        # plant 4: a downstream module's stored statement changed (`CountDescent`)
        dv = NS + "Counting.count_of_oneAvoidingDensityBound"
        after[dv]["type"] = after[dv]["type"] + " "
        # plant 5: a constant moved to another module
        after[NS + "trigPoly"] = dict(after[NS + "trigPoly"], module=MP + "TraceSplit")
        # plant 6: a public constant in `after` that the allow-list does not hold
        after[NS + "planted_new_public"] = {"kind": "THM", "internal": False, "private": None, "prop": True,
                                            "type": "0 x", "value": None, "data": None, "module": MP + "APlus"}
        # plant 7: an axiom in the modules
        after[NS + "planted_axiom"] = {"kind": "AXIOM", "internal": False, "private": None, "prop": True,
                                       "type": "0 False", "value": None, "data": None, "module": MP + "TraceSplit"}
        # plant 8: a leaf become a definition
        after[NS + "setIntegral_compl_TA_rot"]["kind"] = "DEF"
        # plant 9: a publicized helper whose stored statement moved by more than its name
        pv = NS + "mem_nhds_profTop"
        if pv in after:
            after[pv]["type"] = after[pv]["type"].replace("profTop", "profTopX", 1)
        # plant 10: a private constant (not publicized) whose stored type mentions a publicized one, changed
        tv = "_private.Proofs.HadwigerNelson.Rigidity.ContinuityGroup.0.HadwigerNelson.Rigidity.tendsto_archHom"
        if tv in after:
            after[tv]["type"] = after[tv]["type"] + " "

    n_cmp = n_val = 0
    for bn, b in before.items():
        if b["internal"]:
            continue
        n_cmp += 1
        tgt = pub_target(bn, b)
        aname = tgt if tgt is not None else bn
        a = after.get(aname)
        if a is None:
            if tgt is not None and tgt not in publicized:
                ruled.append(f"GONE GENERATED {b['kind']} {b['private']}: a generated theorem, not regenerated")
                continue
            bad.append(f"MISSING  {b['kind']} {bn}: in the first dump, not in the second")
            continue
        if tgt is not None and a["private"] is not None:
            bad.append(f"PUBLIC   {tgt}: still private in the second dump")
            continue
        sb_type, sb_value = subst(b["type"]), subst(b["value"])
        if a["module"] != b["module"]:
            bad.append(f"MODULE   {bn}: {b['module']} -> {a['module']} (a move the job was not given)")
        if a["kind"] != b["kind"]:
            bad.append(f"KIND     {bn}: {b['kind']} -> {a['kind']}")
        if a["prop"] != b["prop"]:
            bad.append(f"PROP     {bn}: proposition {b['prop']} -> {a['prop']}")
        if a["type"] != b["type"]:
            if body(a["type"]) == body(sb_type):
                subst_ok.append(f"RULED SUBST TYPE {b['kind']} {bn}: differs only in the publicized names")
            else:
                bad.append(f"TYPE     {b['kind']} {bn}: the stored statement differs")
        if b["kind"] == "DEF" and not b["prop"]:
            n_val += 1
            if a["value"] != b["value"]:
                if body(a["value"]) == body(sb_value):
                    subst_ok.append(f"RULED SUBST VALUE DEF {bn}: differs only in the publicized names")
                else:
                    bad.append(f"VALUE    DEF {bn}: the stored definition differs")
        if tgt is not None and tgt in publicized:
            pub_ok.append(f"RULED PUBLIC {a['kind']} {tgt}: was {bn}; kind, module and stored type (after SUBST) "
                          f"identical")
    axioms = sorted(n for d in (before, after) for n, c in d.items() if c["kind"] == "AXIOM")
    if axioms:
        bad.append(f"AXIOMS   the modules must declare no axiom: {axioms}")
    became_public = {pub_target(bn, b) for bn, b in before.items() if pub_target(bn, b) is not None}
    new_pub = sorted(n for n, a in after.items() if n not in before and not a["internal"] and a["private"] is None
                     and a["kind"] != "AXIOM" and n not in became_public)
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
    print(f"publicized (ruled): {sorted(publicized)}")
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
        want = 10
        ok = len(bad) == want
        print(f"CONTROL: {len(bad)} of {want} planted faults reported — "
              f"{'the check can fail' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
        sys.exit(0 if ok else 1)
    print("PASS: no statement and no definition changed but the ruled ones listed above"
          if not bad else f"FAIL: {len(bad)} difference(s)")
    sys.exit(0 if not bad else 1)


if __name__ == "__main__":
    main()
