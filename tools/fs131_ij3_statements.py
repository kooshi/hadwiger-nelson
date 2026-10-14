#!/usr/bin/env python3
"""FS131-IJ3 — no statement and no definition of the 41 modules of `Proofs/HadwigerNelson/Rigidity/` changed while this
job wrote its proofs, but the ruled ones; read from two dumps of `data/fs131/ij3/lean/StatementDump.lean` (FS131-IJ2's
dump format; this reader is new, written for this job's rulings).

The ruled changes, and how each is checked:
- PUBLICIZED: the eight lemmas of `ContinuityGroup` that item 876 ruling 1 makes public. In the first dump each is
  `_private.Proofs.HadwigerNelson.Rigidity.ContinuityGroup.0.<name>`; in the second it must be `<name>`, public, same kind
  and module, and its stored type (and value, for the two definitions) equal to the first dump's after the eight private
  names are replaced by the public ones everywhere in the first dump (RENAME SUBST). Every other constant is compared
  after the same substitution, and the count of terms it touched is printed.
- RULED DROP (item 726's word, as the brief rules): `exists_pattern_names_le`'s second type must equal its first with
  exactly the binder `[inst… : IsTopologicalAddGroup.{u_1} X …]` removed, and `ZdAction.map_eq_of_isAddHaarMeasure`'s with
  exactly its `[inst… : T2Space X]` removed (the environment linter's `unusedArguments` finding).
Everything else: every non-internal constant of the first dump in the second with the same kind, module, propness and
stored type; a data definition keeps its value; the only axiom is the declared `positive_entropy_rigidity`, unchanged;
no new public constant; new private constants listed; every `example` head of the base commit's seven files present in
order in the working files.

Usage: fs131_ij3_statements.py <before.txt> <after.txt> <base-commit> [--control]
--control plants ten faults in memory and requires exactly those ten reported (and no RENAME/DROP pass for a plant).
"""
import pathlib
import re
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parents[1]
NS = "HadwigerNelson.Rigidity."
MP = "Proofs.HadwigerNelson.Rigidity."
PRIV = "_private.Proofs.HadwigerNelson.Rigidity.ContinuityGroup.0."
PUB = ["archHom", "archTop_eq", "eventually_archTop", "norm_archHom_nsmul", "fivePow", "nsmul_fivePow", "inv_five_mem",
       "exists_nsmul_mem_of_mem_nhds_profTop"]
SUBST = {PRIV + NS + n: NS + n for n in PUB}
DROP = {NS + "exists_pattern_names_le":
        r"\[inst[^ \]]* : IsTopologicalAddGroup\.\{u_1\} X [^\]]*\] ",
        NS + "ZdAction.map_eq_of_isAddHaarMeasure":
        r"\[inst[^ \]]* : T2Space\.\{[^}]*\} X [^\]]*\] "}
AXIOMS_OK = {NS + "positive_entropy_rigidity"}
MINE = ["ContinuityGroup", "BochnerTau", "UnitCircle", "EntropySplitMax", "EntropyFibres", "PositiveEntropy", "ChainAtTA"]
FILES = ["Proofs/HadwigerNelson/Rigidity/" + m + ".lean" for m in MINE]
REQUIRED = [NS + n for n in ("archimedean_support", "bochnerOn_tauPrime", "entropySplit_of_admissiblePair",
                             "measure_haarSet_eq_zero", "exists_pattern_names_le", "ksEntropy_eq_zero_iff_of_finite",
                             "haar_or_zero_entropy", "exists_admissiblePair", "archTop", "tauPrime", "haarSet",
                             "blockLabel", "positive_entropy_rigidity", "noRamifiedStableDyadic_of_tca")]


def read_dump(path):
    out, cur, mod = {}, None, None
    for ln in open(path, encoding="utf-8"):
        ln = ln.rstrip("\n")
        if ln.startswith("## MODULE "):
            mod = ln.split(" ")[2]
        elif ln.startswith("@@ "):
            parts = ln.split(" ")
            kind, name, rest = parts[1], parts[2], parts[3:]
            prop = rest[-1:] == ["PROPTYPE"]
            if prop:
                rest = rest[:-1]
            cur = {"kind": kind, "internal": rest == ["INTERNAL"], "private": None, "prop": prop, "type": None,
                   "value": None, "data": None, "module": mod}
            if rest[:1] == ["PRIVATE"]:
                cur["private"] = " ".join(rest[1:])
            elif rest and rest != ["INTERNAL"]:
                sys.exit(f"UNREADABLE HEAD in {path}: {ln[:200]}")
            if name in out or mod is None:
                sys.exit(f"BROKEN DUMP {path} at {name}")
            out[name] = cur
        elif ln.startswith("TYPE ") and cur is not None:
            cur["type"] = ln[5:]
        elif ln.startswith("VALUE ") and cur is not None:
            cur["value"] = ln[6:]
        elif ln.startswith("DATA ") and cur is not None:
            cur["data"] = ln[5:]
    mods = {c["module"] for c in out.values()}
    if len(mods) != 41:
        sys.exit(f"BROKEN DUMP {path}: {len(mods)} modules, 41 expected")
    for n, c in out.items():
        if c["type"] is None or (c["kind"] == "DEF" and c["value"] is None):
            sys.exit(f"BROKEN DUMP {path}: {n} lacks a TYPE or VALUE line")
    for n in REQUIRED:
        if n not in out and not (n in SUBST.values()):
            sys.exit(f"BROKEN DUMP {path}: {n} missing")
    return out


def body(t):
    return t.split(" ", 1)[1]


def subst(t, counter):
    if t is None:
        return t
    new = t
    for o, n in SUBST.items():
        # a generated constant of a publicized lemma (`archHom.congr_simp`, `archHom.proof_1`) follows its name
        new = re.sub(re.escape(o) + r"(?![A-Za-z0-9_'])", n, new)
    if new != t:
        counter[0] += 1
    return new


def canon(t):
    """alpha-rename hygienic binder names (`inst._@.<module>.<hash>._hygCtx._hyg.<n>`) by order of first appearance:
    dropping one binder renumbers the later ones (FS131-IJ3, `map_eq_of_isAddHaarMeasure`)"""
    seen = {}
    def f(m):
        return seen.setdefault(m.group(0), f"<H{len(seen)}>")
    return re.sub(r"inst\._@\.[A-Za-z0-9_.]+?\._hygCtx\._hyg\.\d+", f, t)


def target_of(name):
    if name in SUBST:
        return SUBST[name]
    for o, n in SUBST.items():
        if name.startswith(o + "."):
            return n + name[len(o):]
    return name


def example_heads(text):
    text = re.sub(r"/-.*?-/", lambda m: re.sub(r"[^\n]", " ", m.group(0)), text, flags=re.S)
    heads = []
    for m in re.finditer(r"^example\b", text, flags=re.M):
        j = text.index(":=", m.start())
        heads.append(re.sub(r"\s+", " ", text[m.start():j]).strip())
    return heads


def compare(before, after, base, control):
    bad, ruled = [], []
    nsub = [0]
    n_cmp = n_val = 0
    for name, b in before.items():
        if b["internal"]:
            continue
        n_cmp += 1
        target = target_of(name)
        a = after.get(target)
        if a is None:
            bad.append(f"MISSING  {b['kind']} {name}" + (f" (as {target})" if target != name else ""))
            continue
        if target != name:
            if a["private"] is not None:
                bad.append(f"PUBLIC   {target}: still private in the second dump")
            else:
                ruled.append(f"RULED PUBLIC {b['kind']} {target} (was private)")
            if target in after and name in after:
                bad.append(f"PUBLIC   {name}: the private constant is still in the second dump")
        if a["kind"] != b["kind"] or a["module"] != b["module"] or a["prop"] != b["prop"]:
            bad.append(f"KIND/MODULE {name}: {b['kind']} {b['module']} -> {a['kind']} {a['module']}")
        tb = subst(b["type"], nsub)
        same = a["type"] == b["type"] or body(a["type"]) == body(tb)
        if not same:
            if name in DROP:
                stripped = re.sub(DROP[name], "", body(tb), count=1)
                if stripped != body(tb) and canon(stripped) == canon(body(a["type"])):
                    ruled.append(f"RULED DROP {name}: the second type is the first with exactly the ruled "
                                 f"binder removed")
                else:
                    bad.append(f"TYPE     {name}: differs, and not by exactly the ruled binder")
            else:
                bad.append(f"TYPE     {b['kind']} {name}: the stored statement differs")
        if b["kind"] == "DEF" and not b["prop"]:
            n_val += 1
            vb = subst(b["value"], nsub)
            if not (a["value"] == b["value"] or body(a["value"]) == body(vb)):
                db = subst(b["data"], nsub)
                # the elaborator shares an auxiliary proof `X._proof_n` between declarations of one file (`LEAN.md`,
                # FS133-IA1): a reference to one is a proof subterm, read as such — each must be a theorem in its dump
                def proofs_erased(t, d):
                    for c in re.findall(r"[A-Za-z0-9_.']+\._proof_\d+", t):
                        if c not in d or d[c]["kind"] != "THM":
                            return None
                    return re.sub(r"[A-Za-z0-9_.']+\._proof_\d+", "<PROOF>", t)
                ea = proofs_erased(body(a["data"]), after) if a["data"] is not None else None
                eb = proofs_erased(body(db), before) if b["data"] is not None else None
                if ea is not None and ea == eb:
                    ruled.append(f"PROOF-ONLY VALUE DEF {name}: the value differs in proof subterms only "
                                 f"(the stored data, proofs erased, is equal)")
                else:
                    bad.append(f"VALUE    DEF {name}: the stored definition differs")
    for d in DROP:
        if not any(r.startswith(f"RULED DROP {d}") for r in ruled) and not control:
            bad.append(f"DROP     {d}: the ruled drop was not seen (is the second dump current?)")
    axioms = {n: c for d in (before, after) for n, c in d.items() if c["kind"] == "AXIOM"}
    for n in axioms:
        if n not in AXIOMS_OK:
            bad.append(f"AXIOM    {n}: an axiom the modules must not declare")
    targets = {target_of(n) for n in before}
    new_pub = sorted(n for n, a in after.items()
                     if n not in before and not a["internal"] and a["private"] is None and n not in targets
                     and a["kind"] != "AXIOM")
    for n in new_pub:
        bad.append(f"NEW      {after[n]['kind']} {n}: a new public constant")
    new_priv = sorted(n for n, a in after.items() if n not in before and a["private"] is not None)
    n_ex, added = 0, []
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
                bad.append(f"EXAMPLE  {f} #{k + 1}: not in the working file, in order")
        added += [f"  NEW EXAMPLE {f}: {y[:120]}" for y in hn if y not in ho]
    return bad, ruled, new_priv, added, n_cmp, n_val, n_ex, nsub[0]


def main():
    control = "--control" in sys.argv
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    before, after, base = read_dump(args[0]), read_dump(args[1]), args[2]
    if control:
        after = {k: dict(v) for k, v in after.items()}
        t = after[NS + "archimedean_support"]["type"]
        after[NS + "archimedean_support"]["type"] = t[:40] + "X" + t[41:]                      # 1 a leaf's statement
        after[NS + "haarSet"]["value"] += " x"                                                 # 2 a definition's value
        del after[NS + "measure_haarSet_eq_zero"]                                              # 3 a leaf gone
        after[NS + "tauPrime"]["type"] += " "                                                  # 4 a definition's type
        after[NS + "blockLabel"]["module"] = MP + "Entropy"                                    # 5 a move
        after[NS + "planted_public"] = {"kind": "THM", "internal": False, "private": None, "prop": True,
                                        "type": "0 x", "value": None, "module": MP + "UnitCircle"}  # 6 a new public
        after[NS + "planted_axiom"] = {"kind": "AXIOM", "internal": False, "private": None, "prop": True,
                                       "type": "0 False", "value": None, "module": MP + "ChainAtTA"}  # 7 an axiom
        after[NS + "haar_or_zero_entropy"]["kind"] = "DEF"                                     # 8 kind
        after[NS + "fivePow"]["private"] = "HadwigerNelson.Rigidity.fivePow"                   # 9 not made public
        t = after[NS + "ksEntropy_eq_zero_iff_of_finite"]["type"]                              # 10 a drop not ruled
        after[NS + "ksEntropy_eq_zero_iff_of_finite"]["type"] = re.sub(DROP[NS + "exists_pattern_names_le"], "",
                                                                        t, count=1)
    bad, ruled, new_priv, added, n_cmp, n_val, n_ex, nsub = compare(before, after, base, control)
    print(f"compared: {n_cmp} named constants (kind, module, stored type), {n_val} data definitions' values, "
          f"{n_ex} example heads of the base files; {nsub} stored terms of the first dump touched by the "
          f"publicity substitution")
    print(f"new private constants: {len(new_priv)}")
    by_mod = {}
    for n in new_priv:
        by_mod.setdefault(after[n]["module"], 0)
        by_mod[after[n]["module"]] += 1
    for m, c in sorted(by_mod.items()):
        print(f"  {m}: {c}")
    print(f"new examples: {len(added)}")
    for a in added:
        print(a)
    for r in ruled:
        print(r)
    for b in bad:
        print(b)
    if control:
        ok = len(bad) == 10
        print(f"CONTROL: {len(bad)} of 10 planted faults reported — "
              f"{'the check can fail' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
        sys.exit(0 if ok else 1)
    print("PASS: no statement and no definition changed but the ruled ones listed above"
          if not bad else f"FAIL: {len(bad)} difference(s)")
    sys.exit(0 if not bad else 1)


if __name__ == "__main__":
    main()
