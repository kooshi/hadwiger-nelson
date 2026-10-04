#!/usr/bin/env python3
"""FS131-QA2: census of the hypotheses the backlog's Lean takes, read-only, textual.

For every body (a git ref and its own files) it lists the *predicates* — `def`/`abbrev` whose type is
`Prop` (possibly after binders and arrows), `structure`/`class`/`inductive` declarations — and, for each,
the theorems that take it as a hypothesis (in a binder, or as an antecedent of the conclusion's arrows),
refutation-shaped ones (conclusion `False`) flagged; and the declarations that *conclude* it (candidate
inhabitants) or conclude its negation (adversaries).

Usage:
  fs131_qa2_census.py census [--out DIR]     write census.tsv, preds.tsv, uses.tsv to DIR (default data/fs131/qa2)
  fs131_qa2_census.py --self-test            planted controls; exit 1 on any miss

Heuristic, no elaboration: names are matched by their last component as a word (`F.Valid`, `Valid F`,
`ArcMap.Valid`); a common short name can over-match, never under-match within a body's files. Uses
across bodies are attributed to the predicate's defining body only when the using body imports it
(waves 4 and Woodall see main's and their own; wave 2 sees main's; w3b sees main's).
"""
import collections
import json
import os
import re
import subprocess
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs131_qa1_decls as qa1  # noqa: E402  (QA1's parser, imported, never edited)

P = "Proofs/HadwigerNelson/"
BODIES = {
    "main": ("main", [P + f for f in (
        "Arith/FalconerFan.lean", "Arith/NoAffine.lean", "Plane/AeColouring.lean", "Plane/ArcMap.lean",
        "Plane/Basic.lean", "Plane/Chord.lean", "Plane/CircleColouring.lean", "Plane/Closure.lean",
        "Plane/DensityPoints.lean", "Plane/Diameter.lean", "Plane/Lens.lean", "Plane/LocalMap.lean",
        "Plane/LocalMapExamples.lean", "Plane/LocalStructure.lean", "Plane/RingBand.lean",
        "Plane/RingGerm.lean", "Plane/SixFragment.lean", "Plane/Tiles.lean", "Plane/UnitAvoiding.lean",
        "Plane/UnitPairs.lean", "Topology/LebesgueCovering.lean", "Topology/SpernerGrid.lean")]),
    "w2": ("origin/fs131-w2", [P + f for f in (
        "Arith/Dyadic.lean", "Arith/FalconerField.lean", "Arith/PlaceHom.lean",
        "Instances/FalconerOrbit.lean", "Plane/CPColouring.lean", "Plane/Cover.lean",
        "Plane/CoverExamples.lean", "Plane/FalconerReduction.lean", "Plane/MaximalCover.lean",
        "Plane/Slack.lean", "Plane/Stationary.lean", "Plane/Suprema.lean", "Plane/YesLimit.lean")]),
    "w4": ("origin/fs131-w4", [P + f for f in (
        "Plane/SVMap.lean", "Plane/StuckChain.lean", "Plane/ValidMap/BaseSteps.lean",
        "Plane/ValidMap/Basic.lean", "Plane/ValidMap/Contact.lean", "Plane/ValidMap/UnitArc.lean")]),
    "ww": ("origin/fs131-ww", [P + f for f in (
        "Plane/Woodall/Basic.lean", "Plane/Woodall/Collar.lean", "Plane/Woodall/Merge.lean",
        "Plane/Woodall/NoFourFive.lean", "Plane/Woodall/Steps.lean",
        "Plane/ValidMap/Basic.lean", "Plane/SVMap.lean")]),
    "w3b": ("fs131-w3b", [P + f for f in ("Plane/LocalStructure.lean", "Plane/RingGerm.lean")]),
}
SEES = {"main": ["main"], "w2": ["main", "w2"], "w4": ["main", "w4"], "ww": ["main", "ww"],
        "w3b": ["main", "w3b"]}


def split_top(s, seps):
    """Positions of characters in `seps` at bracket depth 0."""
    out, depth = [], 0
    for i, ch in enumerate(s):
        if ch in "([{⦃⟨":
            depth += 1
        elif ch in ")]}⦄⟩":
            depth -= 1
        elif depth == 0 and ch in seps:
            out.append(i)
    return out


def binders_and_concl(sig):
    """Split `theorem name binders : concl` into (list of binder texts, conclusion text)."""
    m = re.match(r"^(?:@\[[^\]]*\]\s*)*(?:\w+\s+)*?(?:theorem|lemma|def|abbrev|instance|example|structure|"
                 r"class|inductive|axiom|opaque)\b\s*([^\s:({\[⦃]*)\s*", sig)
    rest = sig[m.end():] if m else sig
    binders, i, n = [], 0, len(rest)
    while i < n:
        while i < n and rest[i] == " ":
            i += 1
        if i < n and rest[i] in "([{⦃":
            depth, j = 0, i
            while j < n:
                if rest[j] in "([{⦃":
                    depth += 1
                elif rest[j] in ")]}⦄":
                    depth -= 1
                    if depth == 0:
                        break
                j += 1
            binders.append(rest[i:j + 1])
            i = j + 1
        else:
            break
    concl = rest[i:].strip()
    if concl.startswith(":"):
        concl = concl[1:].strip()
    return binders, concl


def concl_parts(concl):
    """Antecedents and final target of a conclusion's top-level arrow chain, after leading ∀/∃-free binders."""
    c = concl
    # strip leading ∀ binders: `∀ x y, body` / `∀ (x : T), body`
    while True:
        m = re.match(r"^∀\s*", c)
        if not m:
            break
        commas = split_top(c, ",")
        if not commas:
            break
        c = c[commas[0] + 1:].strip()
    arrows = split_top(c, "→")
    parts, prev = [], 0
    for a in arrows:
        parts.append(c[prev:a].strip())
        prev = a + 1
    parts.append(c[prev:].strip())
    return parts[:-1], parts[-1]


def is_prop_def(d):
    if d["kind"] not in ("def", "abbrev"):
        return False
    _, concl = binders_and_concl(d["sig"])
    if not concl:
        return False
    _, target = concl_parts(concl)
    # a definition by pattern matching has no `:=`, so its signature runs into `| pat => …`
    return re.match(r"^Prop(\s*\|.*)?$", target.strip()) is not None


def last(name):
    return name.split(".")[-1]


def load():
    rows = []
    for body, (ref, paths) in BODIES.items():
        for p in paths:
            t = qa1.git_show(ref, p)
            if t is None:
                print(f"warning: {ref}:{p} missing", file=sys.stderr)
                continue
            for d in qa1.parse(t):
                d["path"], d["ref"], d["body"] = p, ref, body
                rows.append(d)
    return rows


def census(rows):
    preds = {}
    for d in rows:
        if not d["name"]:
            continue
        if is_prop_def(d) or d["kind"] in ("structure", "class", "inductive"):
            key = (d["body"], d["name"])
            # the ww copies of the K4 skeleton files are the w4 skeleton at fork time: keep ww's own
            if d["body"] == "ww" and "Woodall" not in d["path"]:
                key = ("ww-k4", d["name"])
            preds[key] = d
    uses = []
    for d in rows:
        if d["kind"] not in ("theorem", "lemma", "def", "abbrev", "instance", "example"):
            continue
        binders, concl = binders_and_concl(d["sig"])
        ants, target = concl_parts(concl) if concl else ([], "")
        hyp_text = " ".join(binders) + " " + " ".join(ants)
        refut = target.strip() == "False"
        for (pbody, pname), pd in preds.items():
            vis = SEES[d["body"]]
            pb = "ww" if pbody == "ww-k4" else pbody
            if pb not in vis:
                continue
            if pbody == "ww-k4" and d["body"] != "ww":
                continue
            if d["body"] == "ww" and pbody == "w4":
                continue
            w = re.escape(last(pname))
            pat = r"(?<![\w'])(?:[\w']+\.)*" + w + r"(?![\w'])"
            if d["name"] == pname:
                continue
            in_h = re.search(pat, hyp_text) is not None
            in_t = re.search(pat, target) is not None
            neg_t = re.search(r"¬\s*\(?\s*(?:\S+\.)?" + w + r"(?![\w'])", target) is not None
            if in_h or in_t:
                uses.append({"pred": f"{pbody}:{pname}", "decl": d["name"], "body": d["body"],
                             "where": f"{d['path'].split('HadwigerNelson/')[-1]}:{d['line']}",
                             "kind": d["kind"], "hyp": in_h, "concl": in_t and not in_h, "neg": neg_t,
                             "refut": refut and in_h, "sorry": d["counts"]["sorry"] > 0})
    return preds, uses


def write(preds, uses, out):
    os.makedirs(out, exist_ok=True)
    by = collections.defaultdict(list)
    for u in uses:
        by[u["pred"]].append(u)
    with open(os.path.join(out, "preds.tsv"), "w") as f:
        f.write("pred\tkind\twhere\thyp_uses\trefut_uses\tconcl_decls\tneg_decls\n")
        for (pbody, pname), pd in sorted(preds.items(), key=lambda kv: (kv[0][0], kv[1]["path"], kv[1]["line"])):
            key = f"{pbody}:{pname}"
            us = by.get(key, [])
            f.write("\t".join([key, pd["kind"], f"{pd['path'].split('HadwigerNelson/')[-1]}:{pd['line']}",
                               str(sum(u["hyp"] for u in us)), str(sum(u["refut"] for u in us)),
                               str(sum(u["concl"] for u in us)), str(sum(u["neg"] for u in us))]) + "\n")
    with open(os.path.join(out, "uses.tsv"), "w") as f:
        f.write("pred\tdecl\tbody\twhere\tkind\trole\tsorry\n")
        for u in sorted(uses, key=lambda u: (u["pred"], not u["refut"], not u["hyp"], u["where"])):
            role = "REFUT" if u["refut"] else ("hyp" if u["hyp"] else ("NEG" if u["neg"] else "concl"))
            f.write("\t".join([u["pred"], u["decl"], u["body"], u["where"], u["kind"], role,
                               "sorry" if u["sorry"] else ""]) + "\n")
    with open(os.path.join(out, "predsigs.jsonl"), "w") as f:
        for (pbody, pname), pd in preds.items():
            f.write(json.dumps({"pred": f"{pbody}:{pname}", "kind": pd["kind"], "sig": pd["sig"],
                                "where": f"{pd['path']}:{pd['line']}", "ref": pd["ref"]}, ensure_ascii=False) + "\n")


SELF_TEST = '''import Mathlib

/-- a predicate -/
def Good (x : Nat) : Prop := x = 1

/-- a predicate after arrows -/
def Rel (x : Nat) : Nat → Prop := fun y => x = y

/-- a predicate by pattern matching -/
def Pm : Nat → Prop
  | 0 => True
  | _ => False

/-- data, not a predicate -/
def notPred (x : Nat) : Nat := x

structure Carrier (k : Nat) where
  f : Nat → Fin k

theorem uses_good (x : Nat) (h : Good x) : x = 1 := h

theorem refut_good (x : Nat) (h : Good x) (h2 : x = 2) : False := by omega

theorem refut_arrow (x : Nat) : Good x → x = 2 → False := by intro h h2; omega

theorem inhab : Good 1 := rfl

theorem adv : ¬ Good 2 := by decide

theorem carrier_use {k : Nat} (C : Carrier k) : True := trivial

theorem implicit_only {x : Nat} {h : Good x} : True := trivial

theorem bystander (x : Nat) (h : x = 1) : Goodness x := sorry
'''


def self_test():
    ds = qa1.parse(SELF_TEST)
    for d in ds:
        d["path"], d["ref"], d["body"] = P + "T.lean", "T", "main"
    preds, uses = census(ds)
    names = {k[1] for k in preds}
    roles = {(u["pred"].split(":")[1], u["decl"]): u for u in uses}
    fails = []

    def want(c, m):
        if not c:
            fails.append(m)
    want("Good" in names, "Prop def missed")
    want("Rel" in names, "Prop def after arrows missed")
    want("Pm" in names, "Prop def by pattern matching missed")
    want("notPred" not in names, "data def read as a predicate")
    want("Carrier" in names, "structure missed")
    want(roles.get(("Good", "uses_good"), {}).get("hyp") is True, "hypothesis use missed")
    want(roles.get(("Good", "uses_good"), {}).get("refut") is False, "non-refutation flagged as refutation")
    want(roles.get(("Good", "refut_good"), {}).get("refut") is True, "binder refutation missed")
    want(roles.get(("Good", "refut_arrow"), {}).get("refut") is True, "arrow-antecedent refutation missed")
    want(roles.get(("Good", "inhab"), {}).get("concl") is True, "inhabitant (conclusion) missed")
    want(roles.get(("Good", "adv"), {}).get("neg") is True, "adversary (negated conclusion) missed")
    want(roles.get(("Carrier", "carrier_use"), {}).get("hyp") is True, "carrier binder missed")
    want(roles.get(("Good", "implicit_only"), {}).get("hyp") is True, "implicit binder missed")
    want(("Good", "bystander") not in roles, "a longer name matched as the predicate")
    for f in fails:
        print("FAIL", f)
    print("self-test:", "FAIL" if fails else "OK", f"({len(fails)} misses)")
    return 1 if fails else 0


if __name__ == "__main__":
    if len(sys.argv) >= 2 and sys.argv[1] == "--self-test":
        sys.exit(self_test())
    if len(sys.argv) >= 2 and sys.argv[1] == "census":
        out = "data/fs131/qa2"
        if "--out" in sys.argv:
            out = sys.argv[sys.argv.index("--out") + 1]
        rows = load()
        preds, uses = census(rows)
        write(preds, uses, out)
        print(f"declarations={len(rows)} predicates={len(preds)} uses={len(uses)} "
              f"hyp={sum(u['hyp'] for u in uses)} refut={sum(u['refut'] for u in uses)}")
        sys.exit(0)
    print(__doc__)
    sys.exit(2)
