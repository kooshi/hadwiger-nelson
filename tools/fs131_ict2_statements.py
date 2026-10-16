#!/usr/bin/env python3
"""FS131-ICT2 — no stored statement or definition of the three-colour landing's three modules changed but the three ruled
ones, from the kernel's side. After FS131-ICO2's `data/fs131/ico2/statements.py`.

Reads two prints of the dumper (`data/fs131/ict1/lean/StatementDump.lean`, `data/fs131/ict2/lean/StatementDump.lean`; one
format: `## MODULE <m> constants=<n>`, then per constant `@@ <KIND> <name> [INTERNAL | PRIVATE <user name>] [PROPTYPE]`,
`TYPE <hash> <raw>`, and for a definition `VALUE <hash> <raw>` and, when its type is not a proposition, `DATA <hash> <raw>` —
the value with every proof subterm erased), and the print of `data/fs131/ict2/lean/ReAdd.lean`:
  BEFORE — FS131-ICT1's print of the skeleton's compiled library, made before its first proof
           (`data/fs131/ict1/statements-before.txt.gz`);
  AFTER  — this job's print of the build being gated;
  READD  — the ruled changes undone by term surgery on AFTER's stored types, with their hashes and controls.

For every constant of BEFORE that is not INTERNAL (a public or a private declaration of the file):
  SAME     present in AFTER's same module, same kind, same stored type (text), and for a definition the same DATA when
           BEFORE printed one (a definition holding proofs moves its VALUE when a proof is filled), else the same VALUE;
  RULED    one of RULED below, checked twice:
           (hash) READD's hash of the undone type is BEFORE's stored hash, READD's AFTER hash is AFTER's stored hash, and
                  each of its controls (CONTROL-TRUE, CONTROL-POS) differs from BEFORE's hash; for `mcshane_model` also
                  `RHS-IS-L1 … true` (the stored right side is exactly the elaborated `l1 x`);
           (text) BEFORE's raw print, with the ruled text removed or replaced exactly once, is AFTER's raw print character
                  for character (a dropped non-dependent binder prints as `(D) -> (∀ more, B)`, and the printer merges
                  `∀ binders, ∀ more,` once the arrow is gone: LEAN.md § Searching — Lean, FS131-ICL2);
  CHANGED  anything else that differs                                                   -> FAIL;
  MISSING  absent from AFTER                                                            -> FAIL.
AFTER's non-INTERNAL constants absent from BEFORE are ADDED: listed by module, public, private and GENERATED (`f.congr_simp`,
`f.eq_n`, `f.eq_def`: reserved names Lean writes on demand) apart. A public one that is not GENERATED must be in
ALLOWED_PUBLIC (the public helpers FS131-ICT1 added, each named in its record §§ 3.4, 4, 5) -> else FAIL; and every name of
ALLOWED_PUBLIC must be ADDED (a list naming a constant that is not there is a wrong list) -> else FAIL.
INTERNAL constants are counted per module, never compared.
Two rules added by FS131-ICT3 at the first run (each with its plant below):
  AUXPROOF  in a DATA comparison, a constant that its own dump lists as `THM … INTERNAL PROPTYPE` in the same module (an
            auxiliary proof the elaborator abstracted, `coloringOneTwo._proof_1`) reads as `True.intro`, as the dumper
            already reads every proof subterm that is not a constant: the skeleton's `sorry` was erased where the filled
            proof became a constant;
  ARROW     a dropped binder followed by another non-dependent binder prints `(D) -> (D2) -> (rest)`, not
            `(D) -> (∀ more, B)`: there exactly `(D) -> ` is removed and nothing is merged (`exists_le_mul_of_imp_eq_zero`,
            whose `hadd` precedes `hsub`).

--plant runs the comparison seven more times, each on one fault planted in memory, and requires each reported by name and
nothing else new: a public stored type changed by one character; a public constant dropped; an unlisted public constant
added; a listed helper absent; a definition's DATA changed; a ruled re-add whose hash is its own position control's; and a
ruled text check given one character too few to remove (a near miss).
Usage: fs131_ict2_statements.py BEFORE AFTER READD [--plant]   exit 0 iff the comparison is clean (and, with --plant,
every plant fired)
"""
import copy
import gzip
import re
import sys

GENERATED = re.compile(r"\.(congr_simp|eq_\d+|eq_def)$")
NS = "HadwigerNelson.CayleyThree."
M_FIBRE = "Proofs.HadwigerNelson.CayleyThree.Fibre"
M_DENS = "Proofs.HadwigerNelson.CayleyThree.Density"
M_CIRC = "Proofs.HadwigerNelson.CayleyThree.Circular"

# The three ruled changes. A DROP removes `(<domain>) -> (` … `)` and merges the binders around it; a REPLACE replaces
# its first text by its second, which must occur exactly once in BEFORE's print, as a suffix.
SUMX = ("(Finset.sum.{0, 0} (Fin m) Int Int.instAddCommMonoid (Finset.univ.{0} (Fin m) (Fin.fintype m)) "
        "(fun (j : Fin m) => x j))")
RULED = {
    NS + "even_pmHeight_sub_sum": ("DROP", "(HadwigerNelson.ThreeColour.ProperAlong.{u_1} A ",
                                   "item 1012: the binder `(hc : ProperAlong s c)`, read by no proof"),
    NS + "exists_le_mul_of_imp_eq_zero": ("DROP", "(forall (x : ι -> Nat), (Membership.mem.{u_2, u_2} (ι -> Nat) "
                                          "(Set.{u_2} (ι -> Nat)) (Set.instMembership.{u_2} (ι -> Nat)) M x) -> "
                                          "(forall (y : ι -> Nat), (Membership.mem.{u_2, u_2} (ι -> Nat) (Set.{u_2} "
                                          "(ι -> Nat)) (Set.instMembership.{u_2} (ι -> Nat)) M y) -> "
                                          "(Membership.mem.{u_2, u_2} (ι -> Nat) (Set.{u_2} (ι -> Nat)) "
                                          "(Set.instMembership.{u_2} (ι -> Nat)) M (HAdd.hAdd",
                                          "item 1012: the binder `(hadd : ∀ x ∈ M, ∀ y ∈ M, x + y ∈ M)`, read by no "
                                          "proof"),
    NS + "mcshane_model": ("REPLACE", (SUMX, "(HadwigerNelson.CayleyThree.l1 m x)"),
                           "item 1003: the right side `∑ j, x j` (false as typed) corrected to `l1 x`"),
}
# Public constants the proofs added, each named in FS131-ICT1's record (§ 2: `Circular`; § 3.4: `Fibre`; § 5: `Density`).
ALLOWED_PUBLIC = {
    NS + "rep01_coe": M_CIRC,
    NS + "relMap_single": M_FIBRE, NS + "relMap_eq_wsum": M_FIBRE, NS + "liftHeight_eq_of_sub": M_FIBRE,
    NS + "height_word_single": M_FIBRE, NS + "liftHeight_of_relMap_eq_zero": M_FIBRE,
    NS + "three_dvd_liftHeight": M_FIBRE, NS + "liftHeight_add_of_relMap_eq_zero": M_FIBRE,
    NS + "l1_nonneg": M_DENS, NS + "l1_neg": M_DENS, NS + "l1_add_le": M_DENS, NS + "l1_sub_le": M_DENS,
    NS + "abs_le_l1": M_DENS, NS + "l1_single_one": M_DENS, NS + "even_l1_sub_sum": M_DENS,
}


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
                mods[cur][name] = {"kind": kind, "internal": "INTERNAL" in flags, "private": private,
                                   "user": flags[flags.index("PRIVATE") + 1] if private else name,
                                   "proptype": "PROPTYPE" in flags}
                last = mods[cur][name]
            elif ln.startswith(("TYPE ", "VALUE ", "DATA ")):
                tag, rest = ln.split(" ", 1)
                h, raw = rest.split(" ", 1) if " " in rest else (rest, "")
                last[tag] = raw
                last[tag + "-HASH"] = h
    return mods


def read_readd(path):
    out = {}
    for ln in open(path, encoding="utf-8"):
        p = ln.split()
        if len(p) == 3 and p[0] in ("AFTER", "READD", "CONTROL-TRUE", "CONTROL-POS", "RHS-IS-L1"):
            out[(p[0], p[1])] = p[2]
    return out


def strip_arrow(t, key, short=False):
    """`t` with the non-dependent binder whose domain opens with `key` removed: `(D) -> (∀ more, B)` becomes `∀ … more, B`,
    the binders merged; None unless `key` occurs exactly once. `short` (the plant) removes one character too few."""
    if t.count(key) != 1:
        return None
    i = t.find(key)
    depth, k = 0, i                      # the domain: `(` at i to its matching `)`
    while k < len(t):
        depth += t[k] == "("
        depth -= t[k] == ")"
        if depth == 0:
            break
        k += 1
    if t[k + 1:k + 6] != " -> (":
        return None
    j = k + 5                            # the `(` that opens the rest
    depth, e = 0, j
    while e < len(t):
        depth += t[e] == "("
        depth -= t[e] == ")"
        if depth == 0:
            break
        e += 1
    if t[e + 1:].startswith(" -> "):     # ARROW: `(D) -> (D2) -> …`, the group at j is the next binder's domain
        return t[:i] + t[k + (4 if short else 5):]
    head, inner, tail = t[:i], t[j + 1:e], t[e + 1:]
    if short:
        inner = inner[1:]
    if head.endswith(", ") and inner.startswith("forall "):
        return head[:-2] + " " + inner[len("forall "):] + tail
    return head + inner + tail


def auxproof(raw, mod):
    """AUXPROOF: `raw` with every constant that `mod` (one module of one dump) lists as an internal theorem of a
    proposition read as `True.intro`."""
    if raw is None:
        return None
    names = [n for n, c in mod.items() if c["internal"] and c["kind"] == "THM" and c.get("proptype")]
    for n in sorted(names, key=len, reverse=True):
        if n in raw:
            raw = re.sub(r"(?<![\w.'])" + re.escape(n) + r"(?![\w.'])", "True.intro", raw)
    return raw


def ruled_text(name, before_t, short=False):
    kind, spec, _ = RULED[name]
    if kind == "DROP":
        return strip_arrow(before_t, spec, short)
    old, new = spec
    if before_t.count(old) != 1 or not before_t.endswith(old):
        return None
    out = before_t[: -len(old)] + new
    return out[:-1] if short else out


def ruled_hash(name, c, a, rd):
    """(ok, detail) for the kernel-side check of one ruled constant."""
    bh, ah = c.get("TYPE-HASH"), a.get("TYPE-HASH")
    got = {k: rd.get((k, name)) for k in ("AFTER", "READD", "CONTROL-TRUE", "CONTROL-POS", "RHS-IS-L1")}
    probs = []
    if got["AFTER"] != ah:
        probs.append(f"ReAdd read another type (AFTER {got['AFTER']} against the dump's {ah})")
    if got["READD"] != bh:
        probs.append(f"undone type hash {got['READD']} is not the skeleton's {bh}")
    for k in ("CONTROL-TRUE", "CONTROL-POS"):
        if k == "CONTROL-POS" and RULED[name][0] != "DROP":
            continue
        if got[k] is None or got[k] == bh:
            probs.append(f"{k} {got[k]} did not differ from the skeleton's hash")
    if RULED[name][0] == "REPLACE" and got["RHS-IS-L1"] != "true":
        probs.append(f"RHS-IS-L1 {got['RHS-IS-L1']}")
    return (not probs), "; ".join(probs) or f"undone hash {bh} = the skeleton's; controls differ"


def compare(before, after, rd, short_text=False, quiet=False):
    fails, report = [], []
    for mod, consts in before.items():
        amod = after.get(mod)
        if amod is None:
            fails.append(f"MODULE-MISSING {mod}")
            continue
        n_same = n_int = 0
        for name, c in consts.items():
            if c["internal"]:
                n_int += 1
                continue
            a = amod.get(name)
            if a is None:
                fails.append(f"MISSING {name} ({mod})")
                continue
            if name in RULED:
                okh, dh = ruled_hash(name, c, a, rd)
                t2 = ruled_text(name, c.get("TYPE", ""), short=short_text)
                okt = t2 is not None and a["kind"] == c["kind"] and t2 == a.get("TYPE")
                report.append(f"RULED {name} — {RULED[name][2]}: hash {'OK' if okh else 'DIFFERS'} ({dh}); "
                              f"text {'OK' if okt else 'DIFFERS'}")
                if not okh:
                    fails.append(f"RULED-HASH-DIFFERS {name}")
                if not okt:
                    fails.append(f"RULED-TEXT-DIFFERS {name}")
                continue
            same = a["kind"] == c["kind"] and a.get("TYPE") == c.get("TYPE")
            if c["kind"] == "DEF":
                key = "DATA" if "DATA" in c else "VALUE"
                if key == "DATA":
                    same = same and auxproof(a.get(key), amod) == auxproof(c.get(key), consts)
                else:
                    same = same and a.get(key) == c.get(key)
            if same:
                n_same += 1
            else:
                what = "kind" if a["kind"] != c["kind"] else "type" if a.get("TYPE") != c.get("TYPE") else "value"
                fails.append(f"CHANGED ({what}) {name} ({mod})")
        added = [(n, a) for n, a in amod.items() if n not in consts and not a["internal"]]
        a_int = sum(1 for n, a in amod.items() if a["internal"])
        gen = sorted(n for n, a in added if not a["private"] and GENERATED.search(n))
        pub = sorted(n for n, a in added if not a["private"] and not GENERATED.search(n))
        priv = sorted(a["user"] for n, a in added if a["private"])
        for n in pub:
            if ALLOWED_PUBLIC.get(n) != mod:
                fails.append(f"ADDED-PUBLIC-UNLISTED {n} ({mod})")
        for n, m in ALLOWED_PUBLIC.items():
            if m == mod and n not in pub:
                fails.append(f"ALLOWED-ABSENT {n} ({mod})")
        report.append(f"{mod}: before {len(consts)} constants ({n_int} internal); SAME {n_same}; "
                      f"added public {len(pub)} {[p.removeprefix(NS) for p in pub]}; added private {len(priv)}; "
                      f"generated on demand {gen}; internal after {a_int}")
        if priv:
            report.append(f"    private added: {[p.removeprefix(NS) for p in priv]}")
    for m in after:
        if m not in before:
            fails.append(f"MODULE-NEW {m}")
    if not quiet:
        for r in report:
            print(r)
    return fails


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    before, after, rd = read(args[0]), read(args[1]), read_readd(args[2])
    if not before or not after or not rd:
        print("NOTHING READ — a dump, the ReAdd print or the reader is broken")
        return 2
    fails = compare(before, after, rd)
    for f in fails:
        print("FAIL", f)
    print(f"VERDICT {'CLEAN' if not fails else 'FAIL'}: {len(fails)} failure(s)")
    if "--plant" not in sys.argv:
        return 1 if fails else 0
    ok = True
    vt, vd = NS + "colorable_three_iff_bandSet_nonempty", M_CIRC
    plants = []
    a1 = copy.deepcopy(after); t = a1[vd][vt]["TYPE"]; a1[vd][vt]["TYPE"] = t[:-1] + ("Y" if t[-1:] == "X" else "X")
    plants.append(("a changed stored type", a1, rd, False, [f"CHANGED (type) {vt} ({vd})"]))
    a2 = copy.deepcopy(after); del a2[vd][vt]
    plants.append(("a dropped constant", a2, rd, False, [f"MISSING {vt} ({vd})"]))
    a3 = copy.deepcopy(after)
    a3[vd][NS + "planted_new"] = {"kind": "THM", "internal": False, "private": False, "user": NS + "planted_new",
                                  "TYPE": "True"}
    plants.append(("an unlisted public constant", a3, rd, False, [f"ADDED-PUBLIC-UNLISTED {NS}planted_new ({vd})"]))
    a4 = copy.deepcopy(after); del a4[M_DENS][NS + "l1_neg"]
    plants.append(("a listed helper absent", a4, rd, False, [f"ALLOWED-ABSENT {NS}l1_neg ({M_DENS})"]))
    defs = [n for n, c in before[M_DENS].items() if c["kind"] == "DEF" and not c["internal"] and "DATA" in c
            and n not in RULED]
    a5 = copy.deepcopy(after); dn = sorted(defs)[0]; a5[M_DENS][dn]["DATA"] = a5[M_DENS][dn]["DATA"] + " "
    plants.append((f"a definition's DATA changed ({dn.removeprefix(NS)})", a5, rd, False,
                   [f"CHANGED (value) {dn} ({M_DENS})"]))
    a5b = copy.deepcopy(after); cn = NS + "coloringOneTwo"
    a5b[M_DENS][cn]["DATA"] = a5b[M_DENS][cn]["DATA"].replace(cn + "._proof_1", "HadwigerNelson.CayleyThree.l1")
    plants.append(("AUXPROOF: an auxiliary proof replaced by a constant that is not one", a5b, rd, False,
                   [f"CHANGED (value) {cn} ({M_DENS})"]))
    r6 = dict(rd); n6 = NS + "even_pmHeight_sub_sum"; r6[("READD", n6)] = rd[("CONTROL-POS", n6)]
    plants.append(("a re-add at its position control", after, r6, False, [f"RULED-HASH-DIFFERS {n6}"]))
    plants.append(("a ruled text check one character short", after, rd, True,
                   [f"RULED-TEXT-DIFFERS {n}" for n in RULED]))
    for label, a, r, short, expect in plants:
        got = compare(before, a, r, short_text=short, quiet=True)
        new = sorted(set(got) - set(fails))
        hit = all(e in new for e in expect)
        extra = [g for g in new if g not in expect]
        print(f"PLANT {label}: {'FIRED' if hit and not extra else 'NOT FIRED'} — new failures {new}")
        ok = ok and hit and not extra
    print(f"PLANTS {'ALL FIRED' if ok else 'SOME DID NOT FIRE'}")
    return 0 if ok and not fails else 1


if __name__ == "__main__":
    sys.exit(main())
