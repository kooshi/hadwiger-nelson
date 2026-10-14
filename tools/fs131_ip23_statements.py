#!/usr/bin/env python3
"""FS131-IP23 — no statement and no definition of `Rigidity/Entropy` or `Rigidity/EntropySplitMax` changed while this
job wrote its two proofs and added the ported modules under them, and no stored term of the modules downstream of them
(`Rigidity/PositiveEntropy`, `ChainAtTA`, `ZeroEntropyNames`, `Pieces`) moved either.

Two comparisons, both must hold (exit 0), each with planted faults that must be reported (`--control`):

1. The kernel's side.  `before` and `after` are two outputs of `data/fs131/ip23/lean/StatementDump.lean` (every
   constant stored in the compiled data of the six modules: kind, full name, stored type, whether the type is a
   proposition, for a definition its stored value, and for a definition of a non-proposition its DATA view — the value
   with every proof subterm erased).  Every constant of `before` that is not INTERNAL (a name Lean generates inside a
   declaration) must be in `after` with the same kind and the same type, character for character; a definition must
   keep its value.  A constant whose type is a proposition is a proof: its type is compared, its value is not.
   Constants only in `after` are listed as NEW (public) or NEW PRIVATE (the helpers).  INTERNAL constants are counted,
   not compared: they move with a proof.  The six modules declare exactly one axiom, AXIOM below (`Rigidity/
   PositiveEntropy`, the declared printed theorem, not this job's): it must be in both dumps, an axiom in both, with
   one stored type; any other axiom is a failure.

2. The file's side, for what the environment does not keep: an `example` is elaborated and discarded, so its statement
   is compared as text — each `example` head (from the keyword to its `:=`), whitespace-normalized, block comments and
   docstrings blanked first: every head of the base commit's file (`git show <base>:<path>`) must be in the working
   file, in the base's order.  A head only in the working file is listed as NEW EXAMPLE.

With `--allow-new <file>`: the NEW public constants must be exactly the names listed in <file> (one per line); with no
such file there must be none.  With `--dropped <file>`: binders dropped by the standing word of inventory item 726
(each line `<full name>`: that constant's TYPE may differ and is reported as RULED DROP, never silently).

Usage:  fs131_ip23_statements.py <before.txt> <after.txt> <base-commit> [--allow-new <file>] [--dropped <file>] [--control]
What this does not see: a change to a docstring or a comment (not a statement).
(FS131-IG1's reader, `tools/fs131_ig1_statements.py`, aimed at this job's six modules, with the one declared axiom; that
one is not edited.)
"""
import pathlib
import re
import subprocess
import sys

FILES = ["Proofs/HadwigerNelson/Rigidity/" + m + ".lean" for m in
         ("Entropy", "PositiveEntropy", "ChainAtTA", "ZeroEntropyNames", "Pieces", "EntropySplitMax")]
ROOT = pathlib.Path(__file__).resolve().parents[1]
NS = "HadwigerNelson.Rigidity."
AXIOM = NS + "positive_entropy_rigidity"
# the definitions and the leaves this job must leave as they are (each must be found in both dumps: a dump that lacks
# one is a broken dump, never a pass)
REQUIRED = [NS + n for n in (
    # Entropy: the definitions, the tenth leaf, its neighbours
    "nameCell", "blockEntropy", "partitionEntropy", "ksEntropyOn", "ksEntropy",
    "ksEntropy_eq_iSup_ksEntropyOn", "ksEntropy_eq_measureEntropy", "ksEntropy_bind_eq_zero", "ksEntropyOn_le_ksEntropy",
    # EntropySplitMax: the definitions, the first leaf, the other leaves
    "invariantSigma", "invariantSigma_le", "haarSet", "condExpKernel_ergodicDecomposition", "rotInv_sub_maxMultiple",
    "measure_haarSet_eq_zero", "ksEntropy_eq_zero_of_not_smul_le", "entropySplit_of_admissiblePair",
    "not_smul_dualHaar_le_dirac_one",
    # downstream: one statement or definition of each
    "positive_entropy_rigidity", "EntropySplit", "ksEntropy_rot_eq_iSup", "isHaarFourier_or_ksEntropy_eq_zero",
    "ZeroEntropyCarried")]


def read_dump(path):
    out, cur = {}, None
    for ln in pathlib.Path(path).read_text().splitlines():
        if ln.startswith("@@ "):
            parts = ln.split(" ")
            kind, name, rest = parts[1], parts[2], parts[3:]
            prop = False
            if rest[-1:] == ["PROPTYPE"]:
                prop, rest = True, rest[:-1]
            cur = {"kind": kind, "internal": rest == ["INTERNAL"], "private": None, "prop": prop, "type": None,
                   "value": None, "data": None}
            if rest[:1] == ["PRIVATE"]:
                cur["private"] = " ".join(rest[1:])
            elif rest and rest != ["INTERNAL"]:
                print(f"UNREADABLE HEAD in {path}: {ln[:200]}")
                sys.exit(2)
            if name in out:
                print(f"DUPLICATE NAME IN DUMP {path}: {name}")
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
    dropped = opt(argv, "--dropped")
    args = [a for a in argv if not a.startswith("--")]
    before, after, base = read_dump(args[0]), read_dump(args[1]), args[2]
    bad, ruled = [], []

    for name in REQUIRED:
        for label, d in (("first", before), ("second", after)):
            if name not in d:
                print(f"BROKEN DUMP: {name} is not in the {label} dump")
                sys.exit(2)

    if control:
        # plant 1: one character of the tenth leaf's stored statement changed in `after`
        victim = NS + "ksEntropy_eq_iSup_ksEntropyOn"
        t = after[victim]["type"]
        i = t.index("iSup")
        after[victim]["type"] = t[:i] + "X" + t[i + 1:]
        # plant 2: one data definition's value changed in `after`
        after[NS + "ksEntropyOn"]["value"] = after[NS + "ksEntropyOn"]["value"] + " x"
        # plant 3: the first leaf gone from `after`
        del after[NS + "condExpKernel_ergodicDecomposition"]
        # plant 4: a downstream module's stored statement changed (`Pieces`)
        dv = NS + "ksEntropy_rot_eq_iSup"
        after[dv]["type"] = after[dv]["type"] + " "
        # plant 5: the declared axiom's stored statement changed
        after[AXIOM]["type"] = after[AXIOM]["type"].replace("ksEntropy", "ksEntropyX", 1)
        # plant 6: a public constant in `after` that the allow-list does not hold
        after[NS + "planted_new_public"] = {"kind": "THM", "internal": False, "private": None, "prop": True,
                                            "type": "0 x", "value": None, "data": None}
        # plant 7: a second axiom in the modules
        after[NS + "planted_axiom"] = {"kind": "AXIOM", "internal": False, "private": None, "prop": True,
                                       "type": "False", "value": None, "data": None}
        # plant 8: a leaf become a definition
        after[NS + "ksEntropy_bind_eq_zero"]["kind"] = "DEF"

    n_cmp = n_val = 0
    for name, b in before.items():
        if b["internal"]:
            continue
        n_cmp += 1
        a = after.get(name)
        if a is None:
            bad.append(f"MISSING  {b['kind']} {name}: in the first dump, not in the second")
            continue
        if a["kind"] != b["kind"]:
            bad.append(f"KIND     {name}: {b['kind']} -> {a['kind']}")
        if a["prop"] != b["prop"]:
            bad.append(f"PROP     {name}: proposition {b['prop']} -> {a['prop']}")
        if a["type"] != b["type"]:
            if name in dropped:
                ruled.append(f"RULED DROP {b['kind']} {name}: the stored statement differs (a dropped unread binder)")
            else:
                bad.append(f"TYPE     {b['kind']} {name}: the stored statement differs")
        if b["kind"] == "DEF" and not b["prop"]:
            n_val += 1
            if a["value"] != b["value"]:
                bad.append(f"VALUE    DEF {name}: the stored definition differs")
    for d in sorted(dropped):
        if d not in before:
            bad.append(f"DROPPED  {d}: listed as a dropped binder's statement and not in the first dump")
    axioms_after = sorted(n for n, a in after.items() if a["kind"] == "AXIOM")
    axioms_before = sorted(n for n, b in before.items() if b["kind"] == "AXIOM")
    if axioms_before != [AXIOM] or axioms_after != [AXIOM]:
        bad.append(f"AXIOMS   the modules must declare exactly {AXIOM}: {axioms_before} before, {axioms_after} after")
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

    print(f"compared: {n_cmp} named constants of the first dump (kinds and types), {n_val} data definitions' values, "
          f"{n_ex} example heads of the base files")
    print(f"axioms of the modules: {axioms_before} before, {axioms_after} after")
    print(f"internal (not compared): {n_int_b} before, {n_int_a} after")
    print(f"new public constants in the second dump: {len(new_pub)} (allow-list: {len(allow)})")
    for n in new_pub:
        print(f"  NEW {after[n]['kind']} {n}")
    print(f"new private constants in the second dump: {len(new_priv)}")
    for n in new_priv:
        print(f"  NEW PRIVATE {after[n]['kind']} {after[n]['private']}")
    print(f"examples in the working files that the base does not hold: {len(added)}")
    for a in added:
        print(a)
    for r in ruled:
        print(r)
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
