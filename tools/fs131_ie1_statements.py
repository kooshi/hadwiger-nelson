#!/usr/bin/env python3
"""FS131-IE1 — no statement and no definition of the chain's first layer changed while this job wrote proofs in
`Rigidity/Entropy` and put the ported modules under it (`Rigidity/Entropy`, and the modules that import it or sit
beside it: `Rigidity/Solenoid`, `Rigidity/PositiveEntropy` — which holds the declared printed theorem —,
`Rigidity/ChainAtTA`).  The three ported modules are generated and new; their statements are compared with the
release's by `tools/fs131_ie1_port_readback.py`.

Two comparisons, both must hold (exit 0), each with planted faults that must be reported (`--control`):

1. The kernel's side.  `before` and `after` are two outputs of `data/fs131/ie1/lean/StatementDump.lean` (every
   constant stored in the compiled data of the four modules: kind, full name, stored type, and for a definition its
   stored value).  Every constant of `before` that is not INTERNAL (a name Lean generates inside a declaration) must be
   in `after` with the same kind, the same type and, for a definition, the same value, character for character.
   Constants only in `after` are listed as NEW (public) or NEW PRIVATE (the helpers).  INTERNAL constants are counted,
   not compared: they move with a proof.  The declared `axiom` is named and required: it must be in both dumps, an
   AXIOM in both, with one type; and the modules' set of axioms must be the same in both.

2. The file's side, for what the environment does not keep: an `example` is elaborated and discarded, so its statement
   is compared as text — each `example` head (from the keyword to its `:=`), whitespace-normalized: every head of the
   base commit's file (`git show <base>:<path>`) must be in the working file, in the base's order.  A head only in the
   working file is an example this job added; it is listed as NEW EXAMPLE.  (The count is printed, so that "none" is
   a reading and not a silence.)

With `--allow-new <file>`: the NEW public constants must be exactly the names listed in <file> (one per line; the
bridge lemmas the plan's § 5.4 moves into the module); any other new public constant is a failure.

Usage:  fs131_ie1_statements.py <before.txt> <after.txt> <base-commit> [--allow-new <file>] [--control]
What this does not see: a change to a docstring or a comment (not a statement).
(FS124-I3's reader, through FS133-IA1's `tools/fs133_ia1_statements.py`, for this job's modules.)
"""
import pathlib
import re
import subprocess
import sys

FILES = ["Proofs/HadwigerNelson/Rigidity/Entropy.lean"]
ROOT = pathlib.Path(__file__).resolve().parents[1]
NS = "HadwigerNelson.Rigidity."
AXIOM = NS + "positive_entropy_rigidity"
# the definitions, the skeleton's leaves and the declared statement this job must leave as they are (each must be
# found in both dumps: a dump that lacks one is a broken dump, never a pass)
REQUIRED = [AXIOM] + [NS + n for n in (
    "nameCell", "blockEntropy", "partitionEntropy", "ksEntropyOn", "ksEntropy",
    "blockEntropy_one", "ksEntropy_id", "tendsto_blockEntropy_div", "ksEntropy_map", "ksEntropy_dirac",
    "exists_blockEntropy_le_mul", "ksEntropy_eq_iSup_ksEntropyOn", "ksEntropy_bind_eq_zero",
    "haar_or_zero_entropy", "positive_entropy_rigidity_model", "MRPlus",
    "min_localBound_five_le_chromaticNumber_of_closed")]


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
        victim = NS + "ksEntropy_bind_eq_zero"
        t = after[victim]["type"]
        i = t.index("IsMarkovKernel")
        after[victim]["type"] = t[:i] + "IsMarkovKernal" + t[i + 14:]
        # plant 2: one definition's value changed in `after`
        vdef = NS + "partitionEntropy"
        after[vdef]["value"] = after[vdef]["value"] + " x"
        # plant 3: the declared axiom's statement changed by one character in `after`
        t = after[AXIOM]["type"]
        i = t.index("ksEntropy")
        after[AXIOM]["type"] = t[:i] + "ksEntropz" + t[i + 9:]
        # plant 4: the declared axiom become a theorem
        after[AXIOM]["kind"] = "THM"
        # plant 5: a leaf's statement gone from `after`
        del after[NS + "ksEntropy_map"]
        # plant 6: a public constant in `after` that the allow-list does not hold
        after[NS + "planted_new_public"] = {"kind": "THM", "internal": False, "private": None, "type": "0 x",
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
    if not control and (before[AXIOM]["kind"] != "AXIOM" or after[AXIOM]["kind"] != "AXIOM"):
        bad.append(f"AXIOM    {AXIOM}: not an axiom in both dumps")
    axioms_after = sorted(n for n, a in after.items() if a["kind"] == "AXIOM")
    axioms_before = sorted(n for n, b in before.items() if b["kind"] == "AXIOM")
    if not control and axioms_after != axioms_before:
        bad.append(f"AXIOMS   the modules' axioms moved: {axioms_before} -> {axioms_after}")
    new_pub = sorted(n for n, a in after.items() if n not in before and not a["internal"] and a["private"] is None)
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
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
