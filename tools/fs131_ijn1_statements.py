#!/usr/bin/env python3
"""FS131-IJN1 — no statement and no definition of the modules of `Proofs/HadwigerNelson/Rigidity/` changed at the chain's
join but the ruled ones; read from two dumps of `data/fs131/ijn1/lean/StatementDump.lean` (FS131-IJ3's dump format): the
first taken after the merges' build, before any edit was compiled; the second after the last build. FS131-IJ3's reader
(`tools/fs131_ij3_statements.py`), rewritten for this job's rulings.

The ruled changes, and how each is checked:
- MOVED (items 761 ruling 5, 811 ruling 1): `entropySplit`, `zeroEntropyCarried`, `mrPlus` and
  `min_localBound_five_le_chromaticNumber_closed` from `Rigidity.ChainAtTA` to `Rigidity.ZeroEntropyClosed`: same name,
  kind and propness, the module exactly the ruled one, the stored type equal up to hygienic binder names (whose text names
  the module), or, for the two with a ruled drop, as below.
- RULED DROP (item 770 ruling 2; and the scope binder of the two moved constants that no longer read it): the second
  stored type must equal, hygienic names aside, the `EXPECT` line of `data/fs131/ijn1/drop-expect.txt` — the first stored
  type with exactly the named `∀`-binders removed, computed by the kernel's own term surgery on the merges' build
  (`data/fs131/ijn1/lean/DropExpect.lean`); and that file's `BEFORE` line must equal the first dump's stored type.
  The seventh drop, the unread `[NumberField ↥F]` of `noRamifiedStableDyadic_of_tca` (the coordinator's ruling of
  2026-10-14, after the guarded lint named it), is computed by `DropExpect2.lean` (an anonymous instance binder, matched
  by its binder kind and its type's head) into `drop-expect-2.txt`; the eighth, its cascade — the section instance
  `[NumberField ↥F]` of `Counting.ratio_unramified_of_tca`, unread once the first is gone, omitted by the same ruling —
  by `DropExpect3.lean` into `drop-expect-3.txt`.
- NEW (the headline): `min_localBound_five_le_chromaticNumber` in `Rigidity.ChainHeadline`, the one new public constant.
Everything else: every non-internal constant of the first dump is in the second, with the same kind, module, propness
and stored type (hygienic names aside); a data definition keeps its value (or differs in proof subterms only); the only
axiom is the declared `positive_entropy_rigidity`, unchanged; new private constants are listed; every `example` head of
the base commit's touched files is present, in order, in the working files.

Usage: fs131_ijn1_statements.py <before.txt> <after.txt> <drop-expect.txt,drop-expect-2.txt,drop-expect-3.txt> <base-commit> [--control]
--control plants ten faults in memory and requires each planted constant named by a report and no other report.
"""
import pathlib
import re
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parents[1]
NS = "HadwigerNelson.Rigidity."
MP = "Proofs.HadwigerNelson.Rigidity."
MOVES = {NS + n: (MP + "ChainAtTA", MP + "ZeroEntropyClosed")
         for n in ("entropySplit", "zeroEntropyCarried", "mrPlus", "min_localBound_five_le_chromaticNumber_closed")}
NEW_OK = {NS + "min_localBound_five_le_chromaticNumber": MP + "ChainHeadline"}
AXIOMS_OK = {NS + "positive_entropy_rigidity"}
TOUCHED = ["ChainAtTA", "ZeroEntropyClosed", "PositiveEntropy", "ZeroEntropyNames", "UnitCircle", "ClassRatio",
           "EntropySplitMax", "RingScope", "CountResidue"]
FILES = ["Proofs/HadwigerNelson/Rigidity/" + m + ".lean" for m in TOUCHED]
REQUIRED = [NS + n for n in ("entropySplit", "zeroEntropyCarried", "mrPlus", "noRamifiedStableDyadic_of_tca",
                             "ZdAction.mulTwoThree_model", "card_words_badStarts_le", "positive_entropy_rigidity",
                             "min_localBound_five_le_chromaticNumber_of_closed", "TA", "chainInterface")]


def read_dump(path):
    out, cur, mod, nmods = {}, None, None, None
    for ln in open(path, encoding="utf-8"):
        ln = ln.rstrip("\n")
        if ln.startswith("## MODULES "):
            nmods = int(ln.split(" ")[2])
        elif ln.startswith("## MODULE "):
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
            if mod is None:
                sys.exit(f"BROKEN DUMP {path} at {name}")
            if name in out:
                # a theorem Lean generates on demand in each module that asks (`f.eq_1`; `scripts/dupnames.sh`'s
                # GENERATED class) is declared by two modules: keep each copy, keyed by its module
                if not (cur["internal"] and out[name]["internal"]):
                    sys.exit(f"BROKEN DUMP {path} at {name}: declared twice, not an internal name")
                first = out.pop(name)
                out[f"{name}@{first['module']}"] = first
                name = f"{name}@{mod}"
            elif any(k.startswith(name + "@") for k in out if cur["internal"]):
                name = f"{name}@{mod}"
            out[name] = cur
        elif ln.startswith("TYPE ") and cur is not None:
            cur["type"] = ln[5:]
        elif ln.startswith("VALUE ") and cur is not None:
            cur["value"] = ln[6:]
        elif ln.startswith("DATA ") and cur is not None:
            cur["data"] = ln[5:]
    mods = {c["module"] for c in out.values()}
    if nmods is None or len(mods) != nmods:
        sys.exit(f"BROKEN DUMP {path}: {len(mods)} modules with constants, header says {nmods}")
    for n, c in out.items():
        if c["type"] is None or (c["kind"] == "DEF" and c["value"] is None):
            sys.exit(f"BROKEN DUMP {path}: {n} lacks a TYPE or VALUE line")
    for n in REQUIRED:
        if n not in out:
            sys.exit(f"BROKEN DUMP {path}: {n} missing")
    return out, nmods


def read_expect(paths):
    out, cur = {}, None
    for ln in (l for path in paths.split(",") for l in open(path, encoding="utf-8")):
        ln = ln.rstrip("\n")
        if ln.startswith("@@ "):
            cur = ln.split(" ")[1]
            out[cur] = {}
        elif ln.startswith("BEFORE "):
            out[cur]["before"] = ln[7:]
        elif ln.startswith("EXPECT "):
            out[cur]["expect"] = ln[7:]
    if len(out) != 8 or any(set(v) != {"before", "expect"} for v in out.values()):
        sys.exit(f"BROKEN EXPECT FILES {paths}: {len(out)} entries, 8 expected")
    return out


def body(t):
    return t.split(" ", 1)[1]


def canon(t):
    """alpha-rename hygienic binder names (`inst._@.<module>.<hash>._hygCtx._hyg.<n>`) by order of first appearance: a
    moved declaration's names carry its new module, and a dropped binder renumbers the later ones"""
    seen = {}

    def f(m):
        return seen.setdefault(m.group(0), f"<H{len(seen)}>")
    return re.sub(r"[A-Za-z_][A-Za-z0-9_']*\._@\.[A-Za-z0-9_.]+?\._hygCtx\._hyg\.\d+", f, t)


def example_heads(text):
    text = re.sub(r"/-.*?-/", lambda m: re.sub(r"[^\n]", " ", m.group(0)), text, flags=re.S)
    heads = []
    for m in re.finditer(r"^example\b", text, flags=re.M):
        j = text.index(":=", m.start())
        heads.append(re.sub(r"\s+", " ", text[m.start():j]).strip())
    return heads


def compare(before, after, expect, base):
    bad, ruled = [], []
    n_cmp = n_val = 0
    for name, e in expect.items():
        if name not in before or body(before[name]["type"]) != body(e["before"]):
            bad.append(f"EXPECT   {name}: the expect file's BEFORE is not the first dump's stored type")
    for name, b in before.items():
        if b["internal"]:
            continue
        n_cmp += 1
        a = after.get(name)
        if a is None:
            bad.append(f"MISSING  {b['kind']} {name}")
            continue
        want_mod = b["module"]
        if name in MOVES:
            frm, to = MOVES[name]
            if b["module"] != frm:
                bad.append(f"MOVE     {name}: not in {frm} in the first dump")
            want_mod = to
        if a["kind"] != b["kind"] or a["module"] != want_mod or a["prop"] != b["prop"] or \
                (a["private"] is None) != (b["private"] is None):
            bad.append(f"KIND/MODULE {name}: {b['kind']} {b['module']} -> {a['kind']} {a['module']}")
        elif name in MOVES:
            ruled.append(f"RULED MOVE {name}: {MOVES[name][0]} -> {MOVES[name][1]}")
        if name in expect:
            if canon(body(a["type"])) == canon(body(expect[name]["expect"])):
                ruled.append(f"RULED DROP {name}: the second type is the first with exactly the ruled binders removed "
                             f"(by the kernel's term surgery)")
            else:
                bad.append(f"TYPE     {name}: differs from the ruled drop's expected type")
        elif not (a["type"] == b["type"] or canon(body(a["type"])) == canon(body(b["type"]))):
            bad.append(f"TYPE     {b['kind']} {name}: the stored statement differs")
        if b["kind"] == "DEF" and not b["prop"]:
            n_val += 1
            if not (a["value"] == b["value"] or canon(body(a["value"])) == canon(body(b["value"]))):
                def proofs_erased(t, d):
                    for c in re.findall(r"[A-Za-z0-9_.']+\._proof_\d+", t):
                        if c not in d or d[c]["kind"] != "THM":
                            return None
                    return re.sub(r"[A-Za-z0-9_.']+\._proof_\d+", "<PROOF>", canon(t))
                ea = proofs_erased(body(a["data"]), after) if a["data"] is not None else None
                eb = proofs_erased(body(b["data"]), before) if b["data"] is not None else None
                if ea is not None and ea == eb:
                    ruled.append(f"PROOF-ONLY VALUE DEF {name}: the value differs in proof subterms only")
                else:
                    bad.append(f"VALUE    DEF {name}: the stored definition differs")
    for name in expect:
        if not any(r.startswith(f"RULED DROP {name}:") for r in ruled):
            bad.append(f"DROP     {name}: the ruled drop was not seen")
    for name in MOVES:
        if not any(r.startswith(f"RULED MOVE {name}:") for r in ruled):
            bad.append(f"MOVE     {name}: the ruled move was not seen")
    for d in (before, after):
        for n, c in d.items():
            if c["kind"] == "AXIOM" and n not in AXIOMS_OK:
                bad.append(f"AXIOM    {n}: an axiom the modules must not declare")
    ax = NS + "positive_entropy_rigidity"
    if before[ax]["type"] != after[ax]["type"]:
        bad.append(f"AXIOM    {ax}: its stored statement changed")
    new_pub = sorted(n for n, a in after.items()
                     if n not in before and not a["internal"] and a["private"] is None)
    for n in new_pub:
        if NEW_OK.get(n) == after[n]["module"] and after[n]["kind"] == "THM":
            ruled.append(f"NEW      THM {n} in {after[n]['module']} (the ruled headline)")
        else:
            bad.append(f"NEW      {after[n]['kind']} {n}: a new public constant")
    for n in NEW_OK:
        if n not in after:
            bad.append(f"NEW      {n}: the ruled headline is missing")
    new_priv = sorted(n for n, a in after.items() if n not in before and a["private"] is not None)
    gone_priv = sorted(n for n, b in before.items() if n not in after and b["private"] is not None)
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
    return bad, ruled, new_priv, gone_priv, added, n_cmp, n_val, n_ex


PLANTED = [NS + n for n in ("noRamifiedStableDyadic_of_tca", "TA", "ZdAction.mulTwoThree_model", "entropySplit", "mrPlus",
                            "planted_public", "planted_axiom", "chainInterface", "mrPlus_of_split_of_carried",
                            "min_localBound_five_le_chromaticNumber_of_closed")]


def plant(after):
    after = {k: dict(v) for k, v in after.items()}
    t = after[NS + "noRamifiedStableDyadic_of_tca"]["type"]
    after[NS + "noRamifiedStableDyadic_of_tca"]["type"] = t[:40] + "X" + t[41:]               # 1 a leaf's statement
    after[NS + "TA"]["value"] += " x"                                                          # 2 a definition's value
    after[NS + "TA"]["data"] += " x"
    del after[NS + "ZdAction.mulTwoThree_model"]                                               # 3 a leaf gone
    after[NS + "entropySplit"]["module"] = MP + "ChainHeadline"                                # 4 a move to the wrong place
    t = after[NS + "mrPlus"]["type"]                                                           # 5 a drop not as ruled
    after[NS + "mrPlus"]["type"] = t.replace("HadwigerNelson.Rigidity.MRPlus F", "HadwigerNelson.Rigidity.EntropySplit F")
    assert after[NS + "mrPlus"]["type"] != t, "plant 5 changed nothing"
    after[NS + "planted_public"] = {"kind": "THM", "internal": False, "private": None, "prop": True,
                                    "type": "0 x", "value": None, "data": None, "module": MP + "ChainHeadline"}  # 6
    after[NS + "planted_axiom"] = {"kind": "AXIOM", "internal": False, "private": None, "prop": True,
                                   "type": "0 False", "value": None, "data": None, "module": MP + "ChainAtTA"}  # 7
    after[NS + "chainInterface"]["kind"] = "THM"                                               # 8 a kind
    t = after[NS + "mrPlus_of_split_of_carried"]["type"]                                       # 9 an unruled drop
    after[NS + "mrPlus_of_split_of_carried"]["type"] = t.replace("(HadwigerNelson.Rigidity.EntropySplit F) -> ", "", 1)
    assert after[NS + "mrPlus_of_split_of_carried"]["type"] != t, "plant 9 changed nothing"
    after[NS + "min_localBound_five_le_chromaticNumber_of_closed"]["module"] = MP + "ZeroEntropyClosed"  # 10 unruled move
    return after


def main():
    control = "--control" in sys.argv
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    (before, nb), (after, na) = read_dump(args[0]), read_dump(args[1])
    expect, base = read_expect(args[2]), args[3]
    if control:
        after = plant(after)
    bad, ruled, new_priv, gone_priv, added, n_cmp, n_val, n_ex = compare(before, after, expect, base)
    print(f"modules: {nb} -> {na}; compared: {n_cmp} named constants (kind, module, stored type), {n_val} data "
          f"definitions' values, {n_ex} example heads of the base commit's {len(FILES)} touched files")
    print(f"new private constants: {len(new_priv)}")
    for n in new_priv:
        print(f"  + {after[n]['module']}: {n}")
    print(f"private constants gone: {len(gone_priv)}")
    for n in gone_priv:
        print(f"  - {before[n]['module']}: {n}")
    print(f"new examples: {len(added)}")
    for a in added:
        print(a)
    for r in ruled:
        print(r)
    for b in bad:
        print(b)
    if control:
        # each plant may be reported by more than one check (a wrong move is also a ruled move not seen): every
        # planted constant must be named by some report, and every report must name a planted constant
        named = {p for p in PLANTED if any(re.search(re.escape(p) + r"(?![A-Za-z0-9_.'])", b) for b in bad)}
        stray = [b for b in bad if not any(re.search(re.escape(p) + r"(?![A-Za-z0-9_.'])", b) for p in PLANTED)]
        ok = len(named) == len(PLANTED) and not stray
        print(f"CONTROL: {len(named)} of {len(PLANTED)} planted faults reported, {len(stray)} report(s) naming no plant — "
              f"{'the check can fail' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
        sys.exit(0 if ok else 1)
    print("PASS: no statement and no definition changed but the ruled ones listed above"
          if not bad else f"FAIL: {len(bad)} difference(s)")
    sys.exit(0 if not bad else 1)


if __name__ == "__main__":
    main()
