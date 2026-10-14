#!/usr/bin/env python3
"""FS131-IN1L — no statement and no definition of this job's four modules changed while it wrote proofs in them
(`Rigidity/HaarMultiple`, `Rigidity/ZeroEntropyNames`, `Rigidity/SolenoidErgodic`, and lane C's leaves of
`Rigidity/ChainAtTA`), and the only new public constants are the two the coordinator's ruling added
(`rotInv_dirac_one`, `zeroEntropyCarried_model`).

Two comparisons, both must hold (exit 0), each with planted faults that must be reported (`--control`):

1. The kernel's side.  `before` and `after` are two outputs of `data/fs131/in1l/lean/StatementDump.lean` (every
   constant stored in the compiled data of the four modules: kind, full name, stored type, and for a definition its
   stored value).  Every constant of `before` that is not INTERNAL (a name Lean generates inside a declaration) must be
   in `after` with the same kind, the same type and, for a definition, the same value, character for character.
   Constants only in `after` are listed as NEW (public) or NEW PRIVATE (the helpers).  INTERNAL constants are counted,
   not compared: they move with a proof.  The four modules declare no axiom, before or after.

2. The file's side, for what the environment does not keep: an `example` is elaborated and discarded, so its statement
   is compared as text — each `example` head (from the keyword to its `:=`), whitespace-normalized, block comments and
   docstrings blanked first: every head of the base commit's file (`git show <base>:<path>`) must be in the working
   file, in the base's order.  A head only in the working file is listed as NEW EXAMPLE.

With `--allow-new <file>`: the NEW public constants must be exactly the names listed in <file> (one per line).

Usage:  fs131_in1l_statements.py <before.txt> <after.txt> <base-commit> [--allow-new <file>] [--control]
What this does not see: a change to a docstring or a comment (not a statement).
(FS131-IE1's reader, `tools/fs131_ie1_statements.py`, for this job's modules.)
"""
import pathlib
import re
import subprocess
import sys

FILES = ["Proofs/HadwigerNelson/Rigidity/HaarMultiple.lean",
         "Proofs/HadwigerNelson/Rigidity/ZeroEntropyNames.lean",
         "Proofs/HadwigerNelson/Rigidity/SolenoidErgodic.lean",
         "Proofs/HadwigerNelson/Rigidity/ChainAtTA.lean"]
ROOT = pathlib.Path(__file__).resolve().parents[1]
NS = "HadwigerNelson.Rigidity."
# the definitions and the leaves this job must leave as they are (each must be found in both dumps: a dump that lacks
# one is a broken dump, never a pass)
REQUIRED = [NS + n for n in (
    # lane H
    "maxMultiple", "le_maxMultiple", "maxMultiple_smul_le", "smul_le_iff_le_maxMultiple",
    "maxMultiple_le_measure_univ", "sub_maxMultiple_add", "not_smul_le_sub_maxMultiple", "map_sub_maxMultiple",
    "maxMultiple_self",
    # lane N
    "wordBlock", "IsBadStart", "badStarts", "card_words_badStarts_le", "nameOf", "heavyNames",
    "mul_card_heavyNames_le", "mul_measureReal_light_le_blockEntropy", "visits", "measure_frequentVisits_le",
    "badStarts_nameOf_le_visits", "rpow_mul_exp_le_exp", "measureReal_lightCells_le",
    "exists_forall_exp_le_measureReal_nameCell", "zeroEntropyNames_model",
    "ZdAction.IsErgodicOn.null_or_conull_of_ae_invariant",
    # lane C, and the module's definitions and its other statements
    "torsionChars", "archChars", "TA", "measurableSet_TA", "rot_preimage_TA", "exists_nonTorsion_unitVector",
    "chainInterface", "MRPlus", "EntropySplit", "EntropySplitEvery", "ZeroEntropyCarried", "NoRamifiedStableDyadic",
    "IsDyadic", "IsRamified", "mrPlus_of_split_of_carried", "entropySplit", "zeroEntropyCarried",
    "noRamifiedStableDyadic_of_tca", "min_localBound_five_le_chromaticNumber_of_closed",
    "min_localBound_five_le_chromaticNumber_closed")]


def read_dump(path):
    out, cur = {}, None
    for ln in pathlib.Path(path).read_text().splitlines():
        if ln.startswith("@@ "):
            parts = ln.split(" ")
            kind, name, rest = parts[1], parts[2], parts[3:]
            cur = {"kind": kind, "internal": rest == ["INTERNAL"], "private": None, "type": None, "value": None}
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
    if not out:
        print(f"EMPTY DUMP: {path} — the reader or the dumper is broken")
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


def main():
    control = "--control" in sys.argv
    argv = sys.argv[1:]
    allow = None
    if "--allow-new" in argv:
        i = argv.index("--allow-new")
        allow = {ln.strip() for ln in pathlib.Path(argv[i + 1]).read_text().splitlines() if ln.strip()}
        del argv[i:i + 2]
    args = [a for a in argv if not a.startswith("--")]
    before, after, base = read_dump(args[0]), read_dump(args[1]), args[2]
    bad = []

    for name in REQUIRED:
        for label, d in (("first", before), ("second", after)):
            if name not in d:
                print(f"BROKEN DUMP: {name} is not in the {label} dump")
                sys.exit(2)

    if control:
        # plant 1: one character of a leaf's stored statement changed in `after`
        victim = NS + "card_words_badStarts_le"
        t = after[victim]["type"]
        i = t.index("Real.rpow") if "Real.rpow" in t else t.index("HPow.hPow")
        after[victim]["type"] = t[:i] + "X" + t[i + 1:]
        # plant 2: one definition's value changed in `after`
        vdef = NS + "maxMultiple"
        after[vdef]["value"] = after[vdef]["value"] + " x"
        # plant 3: a leaf's statement gone from `after`
        del after[NS + "rot_preimage_TA"]
        # plant 4: a leaf become a definition
        after[NS + "measure_frequentVisits_le"]["kind"] = "DEF"
        # plant 5: a public constant in `after` that the allow-list does not hold
        after[NS + "planted_new_public"] = {"kind": "THM", "internal": False, "private": None, "type": "0 x",
                                            "value": None}
        # plant 6: an axiom in the modules
        after[NS + "planted_axiom"] = {"kind": "AXIOM", "internal": False, "private": None, "type": "False",
                                       "value": None}
        if allow is None:
            allow = set()

    n_cmp = 0
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
        if a["type"] != b["type"]:
            bad.append(f"TYPE     {b['kind']} {name}: the stored statement differs")
        if b["kind"] == "DEF" and a["value"] != b["value"]:
            bad.append(f"VALUE    DEF {name}: the stored definition differs")
    axioms_after = sorted(n for n, a in after.items() if a["kind"] == "AXIOM")
    axioms_before = sorted(n for n, b in before.items() if b["kind"] == "AXIOM")
    if axioms_after or axioms_before:
        bad.append(f"AXIOMS   the modules declare axioms: {axioms_before} before, {axioms_after} after")
    new_pub = sorted(n for n, a in after.items() if n not in before and not a["internal"] and a["private"] is None
                     and a["kind"] != "AXIOM")
    new_priv = sorted(n for n, a in after.items() if n not in before and a["private"] is not None)
    if allow is not None:
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

    print(f"compared: {n_cmp} named constants of the first dump (types; values of definitions), {n_ex} example heads "
          f"of the base files")
    print(f"axioms of the modules: {axioms_before} before, {axioms_after} after")
    print(f"internal (not compared): {n_int_b} before, {n_int_a} after")
    print(f"new public constants in the second dump: {len(new_pub)}"
          + ("" if allow is None else f" (allow-list: {len(allow)})"))
    for n in new_pub:
        print(f"  NEW {after[n]['kind']} {n}")
    print(f"new private constants in the second dump: {len(new_priv)}")
    for n in new_priv:
        print(f"  NEW PRIVATE {after[n]['kind']} {after[n]['private']}")
    print(f"examples in the working files that the base does not hold: {len(added)}")
    for a in added:
        print(a)
    for b in bad:
        print(b)
    if control:
        want = 6
        ok = len(bad) == want
        print(f"CONTROL: {len(bad)} of {want} planted faults reported — "
              f"{'the check can fail' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
        sys.exit(0 if ok else 1)
    print("PASS: no statement and no definition changed" if not bad else f"FAIL: {len(bad)} difference(s)")
    sys.exit(0 if not bad else 1)


if __name__ == "__main__":
    main()
