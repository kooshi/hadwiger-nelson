#!/usr/bin/env python3
"""FS131-ITT1 — no statement and no definition of the modules this job writes changed while it wrote its proofs, but the
one move it was given; and no stored term of the modules downstream of them moved either.

The modules: the six this job writes (`Rigidity/RingScope`, `TateModel`, `TateLocal`, `TateArch`, `TateCharacter`, and
`ThinBoxes`, which the move edits) and the seven downstream of them (`TateKernel`, `TateExists`, `PlaceSizes`,
`Multipliers`, `GlobalPoint`, `WanderingShells`, `ZeroEntropyClosed`).

Two comparisons, both must hold (exit 0), each with planted faults that must be reported (`--control`):

1. The kernel's side.  `before` and `after` are two outputs of `data/fs131/itt1/lean/StatementDump.lean` (every
   constant stored in the compiled data of the thirteen modules, under its module: kind, full name, stored type,
   whether the type is a proposition, for a definition its stored value, and for a definition of a non-proposition its
   DATA view).  Every constant of `before` that is not INTERNAL must be in `after` with the same kind and the same type,
   character for character, **in the same module** — except the constants of MOVED, which must be in the module MOVED
   names and nowhere else, with the same kind and type (reported IDENTICAL, MOVED); a definition must keep its value.
   A constant whose type is a proposition is a proof: its type is compared, its value is not.  Constants only in `after`
   are listed as NEW (public) or NEW PRIVATE (the helpers).  INTERNAL constants are counted, not compared.  The modules
   declare no axiom: any axiom is a failure.

2. The file's side, for what the environment does not keep: every `example` head (from the keyword to its `:=`),
   whitespace-normalized, block comments and docstrings blanked first, of the base commit's file must be in the working
   file, in the base's order.  A head only in the working file is listed as NEW EXAMPLE.

With `--allow-new <file>`: the NEW public constants must be exactly the names listed (one per line); with no such file
there must be none.  With `--dropped <file>`: binders dropped by the standing word of inventory item 726 (each line
`<full name>`: that constant's TYPE may differ and is reported as RULED DROP, never silently).

Usage:  fs131_itt1_statements.py <before.txt> <after.txt> <base-commit> [--allow-new <file>] [--dropped <file>]
        [--moved | --control]
`--moved` requires the move to have happened (the second dump must hold each MOVED constant in its new module); without
it each MOVED constant must be in its old module in both dumps (the comparison before the move, or the dump against
itself).
What this does not see: a change to a docstring or a comment (not a statement).
(FS131-IP23's reader, `tools/fs131_ip23_statements.py`, aimed at these thirteen modules, with modules tracked and one
move; that one is not edited.)
"""
import pathlib
import re
import subprocess
import sys

MODS = ("RingScope", "TateModel", "TateLocal", "TateArch", "TateCharacter", "TateKernel", "TateExists", "PlaceSizes",
        "Multipliers", "ThinBoxes", "GlobalPoint", "WanderingShells", "ZeroEntropyClosed")
FILES = ["Proofs/HadwigerNelson/Rigidity/" + m + ".lean" for m in MODS]
ROOT = pathlib.Path(__file__).resolve().parents[1]
NS = "HadwigerNelson.Rigidity."
MP = "Proofs.HadwigerNelson.Rigidity."
# the one move this job was given (item 811's ruling 2): name -> (old module, new module)
MOVED = {NS + "TateModel.sigmaCompactSpace": (MP + "ThinBoxes", MP + "TateModel")}
# the definitions and the leaves this job must leave as they are (each must be found in both dumps)
REQUIRED = [NS + n for n in (
    "stableIntegers", "exists_mul_stableIntegers_le", "dense_mixedEmbedding_nsmul_unitRing", "unitRing_eq_stableIntegers",
    "IsStablePlace", "SplitPlace", "SAdeleRing", "toSAdele", "TateModel", "TateModel.Λ", "TateModel.mul_mem_Λ",
    "TateModel.π_eq_π_iff", "TateModel.toSAdele_mem_torsionChars", "TateModel.isOpenMap", "TateModel.mem_TA",
    "exists_valuation_le_one_away", "exists_approx_completion", "exists_int_trace_of_integral",
    "exists_trace_not_int_away", "exists_nat_mul_integral_of_trace_int", "compactSpace_adicCompletionIntegers",
    "archTrace", "archTrace_mixedEmbedding", "exists_eq_mixedEmbedding_of_archTrace_int",
    "archTrace_mixedEmbedding_one", "mem_stableIntegers_iff_valuation", "IsApprox", "tateCharFun", "tateChar", "tatePi",
    "exists_isApprox", "tateCharFun_eq", "tatePi_arch_mem", "oAnn", "surjective_tatePi", "exists_tateModel", "WPlace",
    "multiplier", "box", "TateModel.sigmaCompactSpace", "TateModel.thinBox_heavy", "Collision",
    "zeroEntropyCarried_of_tateModel", "zeroEntropyCarried_of_numberField")]


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
    args = [a for a in argv if not a.startswith("--")]
    before, after, base = read_dump(args[0]), read_dump(args[1]), args[2]
    bad, ruled, moved_ok = [], [], []

    for name in REQUIRED:
        for label, d in (("first", before), ("second", after)):
            if name not in d:
                print(f"BROKEN DUMP: {name} is not in the {label} dump")
                sys.exit(2)

    if control:
        # the control runs on a dump against itself, so the move is planted first (the honest part of the control):
        for n, (old, new) in MOVED.items():
            after[n] = dict(after[n], module=new)
        # plant 1: one character of a T-I leaf's stored statement changed in `after`
        victim = NS + "TateModel.π_eq_π_iff"
        t = after[victim]["type"]
        after[victim]["type"] = t[:40] + "X" + t[41:]
        # plant 2: one data definition's value changed in `after`
        after[NS + "archTrace"]["value"] = after[NS + "archTrace"]["value"] + " x"
        # plant 3: a T-L leaf gone from `after`
        del after[NS + "exists_trace_not_int_away"]
        # plant 4: a downstream module's stored statement changed (`ThinBoxes`)
        dv = NS + "TateModel.thinBox_heavy"
        after[dv]["type"] = after[dv]["type"] + " "
        # plant 5: a constant moved to another module that the move does not name
        after[NS + "box"] = dict(after[NS + "box"], module=MP + "TateModel")
        # plant 6: a public constant in `after` that the allow-list does not hold
        after[NS + "planted_new_public"] = {"kind": "THM", "internal": False, "private": None, "prop": True,
                                            "type": "0 x", "value": None, "data": None, "module": MP + "TateArch"}
        # plant 7: an axiom in the modules
        after[NS + "planted_axiom"] = {"kind": "AXIOM", "internal": False, "private": None, "prop": True,
                                       "type": "False", "value": None, "data": None, "module": MP + "TateLocal"}
        # plant 8: a leaf become a definition
        after[NS + "exists_isApprox"]["kind"] = "DEF"
        # plant 9: the moved statement changed in its new home
        mv = NS + "TateModel.sigmaCompactSpace"
        after[mv]["type"] = after[mv]["type"].replace("SAdeleRing", "SAdeleRingX", 1)

    n_cmp = n_val = 0
    for name, b in before.items():
        if b["internal"]:
            continue
        n_cmp += 1
        a = after.get(name)
        if a is None:
            bad.append(f"MISSING  {b['kind']} {name}: in the first dump, not in the second")
            continue
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
                     and a["kind"] != "AXIOM")
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
    for r in ruled:
        print(r)
    for b in bad:
        print(b)
    if control:
        want = 9
        ok = len(bad) == want and not moved_ok
        print(f"CONTROL: {len(bad)} of {want} planted faults reported — "
              f"{'the check can fail' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
        sys.exit(0 if ok else 1)
    print("PASS: no statement and no definition changed" + (" but the move" if moved_mode else "")
          if not bad else f"FAIL: {len(bad)} difference(s)")
    sys.exit(0 if not bad else 1)


if __name__ == "__main__":
    main()
