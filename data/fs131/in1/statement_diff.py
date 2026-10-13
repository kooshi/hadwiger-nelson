#!/usr/bin/env python3
"""FS131-IN1 — no statement and no definition of `Arith/ThreeColourCriterion` changed while its proofs were written.
(Pattern: data/fs131/iu1/statement_diff.py, FS131-IU1's; two checks added, marked NEW HERE.)

`before` and `after` are two prints in the format of data/fs131/in1/lean/StatementDump.lean (kind, full name, stored
type, and for a definition its stored value), made either from the compiled module (`StatementDump.lean`) or from a
copy of the file with `lean/StatementFooter.lean` appended (the same format; used between builds) — both raw, or both
passed through data/fs131/in1/compact_dump.py (each stored term as Lean's hash, its SHA-256, its length, its head).
Every constant of `before` that is not INTERNAL (a name Lean generates inside a declaration, and every private name)
must be in `after` with the same kind, the same type and, for a definition, the same value, character for character.
Constants only in `after` are listed as NEW: the helpers.  INTERNAL constants are counted, not compared: they move
with a proof.

NEW HERE (1) — names outside the module's namespace.  A `simp [f]` that unfolds another module's definition can make
Lean generate `f.eq_1` (or `f.congr_simp`, …) inside THIS module under that definition's name, which a landing's
doubled-name check then reports.  Every constant of `after` whose name — a private name read through its user name —
is not under `HadwigerNelson.ThreeColourCriterion` is reported as FOREIGN and fails, unless `before` holds it too.

NEW HERE (2) — the file's side.  An `example` is elaborated and discarded, so the `example`s of the base commit's file
and of the working file are compared as text (block comments and docstrings blanked first), each whole, in order.

WIDENED BY RULING — the brief's Amendments 1 and 2 (2026-10-13 20:28 and 20:32 UTC) drop one unread hypothesis from each of the leaves
named in WIDENED below.  Each of them MUST differ from the skeleton in its stored type (if one does not, the ruling was
not carried out: a failure), and is printed as WIDENED; every other constant must be identical as before.  That each
difference is a dropped hypothesis and nothing else is shown by data/fs131/in1/widenings.py (the skeleton's form of
each, proved in one application from the working module's).

Usage:  statement_diff.py <before.txt> <after.txt> [--control] [--no-widening]
`--no-widening`: expect no difference at all (the check as it was before the amendment).
`--control` plants four faults in `after` (one stored statement changed by one character, one definition's value
changed, one skeleton declaration removed, one generated equation lemma under another module's definition's name
added) and must report exactly four; exit 0 only then.
What this does not see: a change to a docstring or a comment (not a statement).
"""
import re, subprocess, sys, pathlib

FILE = "Proofs/HadwigerNelson/Arith/ThreeColourCriterion.lean"
BASE = "34d9113b2"
NS = "HadwigerNelson.ThreeColourCriterion."
# the statements the coordinator's ruling changed (data/fs131/briefs/FS131-IN1-leaves.md, Amendments 1 and 2; a later line
# of this dict is a later ruling, named)
WIDENED = {
    "HadwigerNelson.ThreeColourCriterion.exists_mul_conj_inv_eq_of_mul_conj_eq_one": "Amendment 1: `[Finite k]` dropped",
    "HadwigerNelson.ThreeColourCriterion.eq_zero_of_forall_normOne_eq": "Amendment 1: `hσσ` dropped",
    "HadwigerNelson.ThreeColourCriterion.exists_maximal_conj_trivial": "Amendment 2: `hcc` dropped",
}
ROOT = pathlib.Path(__file__).resolve().parents[3]


def read_dump(path):
    out, cur = {}, None
    for ln in pathlib.Path(path).read_text().splitlines():
        if ln.startswith("@@ "):
            parts = ln.split(" ")
            cur = {"kind": parts[1], "internal": parts[-1] == "INTERNAL", "type": None, "value": None}
            name = " ".join(parts[2:-1] if cur["internal"] else parts[2:])
            if name in out:
                print(f"DUPLICATE NAME IN DUMP {path}: {name}"); sys.exit(2)
            out[name] = cur
        elif ln.startswith("TYPE ") and cur is not None:
            cur["type"] = ln[5:]
        elif ln.startswith("VALUE ") and cur is not None:
            cur["value"] = ln[6:]
    if not out:
        print(f"EMPTY DUMP: {path} — the reader or the dumper is broken"); sys.exit(2)
    return out


def blank_comments(text):
    text = re.sub(r"/-.*?-/", "", text, flags=re.S)       # block comments and docstrings
    return re.sub(r"--.*", "", text)                        # line comments


def examples(text):
    """Each `example`, whole: from its head to the next blank line or top-level keyword."""
    text = blank_comments(text)
    return [re.sub(r"\s+", " ", m.group(0)).strip()
            for m in re.finditer(r"^example\b.*?(?=^\S|\Z)", text, flags=re.M | re.S)]


def user_name(n):
    m = re.match(r"_private\.(.*?)\.0\.(.*)$", n)
    return m.group(2) if m else n


def main():
    control = "--control" in sys.argv
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    before, after = read_dump(args[0]), read_dump(args[1])
    bad = []
    widened = {} if "--no-widening" in sys.argv else WIDENED
    seen_widened = []

    if control:
        # plant 1: one character of one stored statement changed in `after` (its last: a raw dump and a compact one both carry it)
        victim = "HadwigerNelson.ThreeColourCriterion.exists_maximal_of_torsion"
        t = after[victim]["type"]
        after[victim]["type"] = t[:-1] + ("!" if t[-1] != "!" else "?")
        # plant 2: one definition's value changed in `after`
        vdef = "HadwigerNelson.ThreeColourCriterion.conjR"
        after[vdef]["value"] = after[vdef]["value"] + " x"
        # plant 3: one skeleton declaration gone from `after`
        del after["HadwigerNelson.ThreeColourCriterion.comap_conjR_eq"]
        # plant 4: a generated equation lemma under another module's definition's name
        after["HadwigerNelson.SpectralChain.unitRing.eq_1"] = {"kind": "THM", "internal": False, "type": "0 planted", "value": None}

    n_cmp = n_thm = n_def = 0
    for name, b in before.items():
        if b["internal"]:
            continue
        n_cmp += 1
        n_thm += b["kind"] == "THM"
        n_def += b["kind"] == "DEF"
        a = after.get(name)
        if a is None:
            bad.append(f"MISSING  {b['kind']} {name}: in the first dump, not in the second"); continue
        if a["kind"] != b["kind"]:
            bad.append(f"KIND     {name}: {b['kind']} -> {a['kind']}")
        if name in widened:
            if a["type"] == b["type"]:
                bad.append(f"UNCHANGED {b['kind']} {name}: the ruling's widening is not in the second dump ({widened[name]})")
            else:
                seen_widened.append(name)
        elif a["type"] != b["type"]:
            bad.append(f"TYPE     {b['kind']} {name}: the stored statement differs")
        if b["kind"] == "DEF" and a["value"] != b["value"]:
            bad.append(f"VALUE    DEF {name}: the stored definition differs")
    new = sorted(n for n, a in after.items() if n not in before and not a["internal"])

    # a private declaration's stored name (`_private.<module>.0.<name>`) is flagged INTERNAL by the dumper; list the
    # private theorems this job added by their own names (generated children — `_proof_n`, `match_n`, `eq_n` — left out)
    def private_user(n):
        m = re.match(r"_private\.(.*?)\.0\.(.*)$", n)
        if not m:
            return None
        last = m.group(2).split(".")[-1]
        return None if (last.startswith("_") or re.fullmatch(r"(match|eq|proof)_\d+(_\d+)*", last)) else m.group(2)
    new_private = sorted((private_user(n), a["kind"]) for n, a in after.items() if n not in before and private_user(n))
    n_int_b = sum(1 for b in before.values() if b["internal"])
    n_int_a = sum(1 for a in after.values() if a["internal"])

    # NEW HERE (1): names outside the module's namespace
    foreign_b = sorted(n for n in before if not user_name(n).startswith(NS))
    foreign_a = sorted(n for n in after if not user_name(n).startswith(NS))
    for n in foreign_a:
        if n not in before:
            bad.append(f"FOREIGN  {after[n]['kind']} {n}: declared by this module outside `{NS[:-1]}` (a generated lemma under another module's name?)")

    old = subprocess.run(["git", "show", f"{BASE}:{FILE}"], cwd=ROOT, capture_output=True, text=True, check=True).stdout
    cur = (ROOT / FILE).read_text()
    ex_old, ex_new = examples(old), examples(cur)
    if not control and ex_old != ex_new:
        bad.append(f"EXAMPLE  the `example`s differ as text: {len(ex_old)} at {BASE}, {len(ex_new)} in the working file")
    # the reader's own check: every `theorem <name>` / `def <name>` written in the base file is a named constant of `before`
    written = re.findall(r"^(?:noncomputable )?(?:@\[simp\] )?(?:theorem|def|abbrev) ([A-Za-z0-9_.]+)", blank_comments(old), flags=re.M)
    short = {n.split(".")[-1] for n, b in before.items() if not b["internal"]}
    unseen = [w for w in written if w.split(".")[-1] not in short]
    if unseen or not written or not ex_old:
        print(f"READER BROKEN: {len(written)} declarations and {len(ex_old)} examples written at {BASE}; not in the first dump: {unseen}"); sys.exit(2)

    print(f"compared: {n_cmp} named constants of the first dump ({n_thm} theorems, {n_def} definitions; types, and values of definitions); "
          f"{len(written)} declarations written at {BASE}, each found in the first dump")
    print(f"internal (not compared): {n_int_b} before, {n_int_a} after")
    print(f"widened by ruling (stored type differs, as it must): {len(seen_widened)} of {len(widened)}")
    for n in seen_widened:
        print(f"  WIDENED {n} — {widened[n]}")
    print(f"new named constants in the second dump: {len(new)}")
    for n in new:
        print(f"  NEW {after[n]['kind']} {n}")
    print(f"new private declarations in the second dump (counted among the internal): {len(new_private)}")
    for n, k in new_private:
        print(f"  NEW PRIVATE {k} {n}")
    print(f"names outside `{NS[:-1]}`: {len(foreign_b)} before, {len(foreign_a)} after")
    for n in foreign_a:
        print(f"  OUTSIDE {after[n]['kind']} {n}{' (in the first dump too)' if n in before else ''}")
    print(f"`example`s, compared whole as text: {len(ex_old)} at {BASE}, {len(ex_new)} in the working file")
    for b in bad:
        print(b)
    if control:
        want = 4
        ok = len(bad) == want
        print(f"CONTROL: {len(bad)} of {want} planted faults reported — {'the check can fail' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
        sys.exit(0 if ok else 1)
    print((f"PASS: no statement and no definition changed but the {len(seen_widened)} widened by ruling" if widened else
           "PASS: no statement and no definition changed") if not bad else f"FAIL: {len(bad)} difference(s)")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
