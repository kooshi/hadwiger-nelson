#!/usr/bin/env python3
"""FS131-QA4: the census of the inhabitant audit's third pass.

Every theorem and every definition in the audited modules, read from fixed commits with `git show` (never a worktree), and
for each theorem: whether it is a *head* (its docstring names a backlog row, or its name is used in another audited module,
or it is on the list of construction heads), whether its statement concludes `False`, which named predicates its signature
takes, and what its docstring says about an inhabitant. For each definition: whether it is new or changed since the commits
FS131-QA2 and FS131-QA3 read, and how many audited theorems take it in their signature.

Reuses FS131-QA1's parser (`tools/fs131_qa1_decls.py`, imported read-only); the docstring is re-read here in full, since
QA1's parser keeps only its first 400 characters.

Usage:
  fs131_qa4_census.py theorems [--heads]   TSV: body, module, line, name, head-reasons, refut, sorry, inh-note, rows, preds
  fs131_qa4_census.py defs                 TSV: body, module, line, kind, name, status (NEW/CHANGED/SAME), uses
  fs131_qa4_census.py summary              counts per body and module
  fs131_qa4_census.py --self-test          planted controls; exit 1 on any miss

Limits, stated: textual (no elaboration). A name is matched as a whole token, by its last component, so a short common name
can over-match and never under-match inside the audited files. "Refutation-shaped" is read from the signature's last
top-level colon. An inhabitant note is found by words (`inhabitant`, `model`, `no model`), so every hit is read by hand.
"""
import importlib.util
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location("qa1", os.path.join(HERE, "fs131_qa1_decls.py"))
qa1 = importlib.util.module_from_spec(spec)
spec.loader.exec_module(qa1)

P = "Proofs/HadwigerNelson/Plane/"
V = P + "ValidMap/"
W = P + "Woodall/"
MAIN, W5, W5C = "d4403f09", "3b120cd3", "87e95385"
AUDITED = (
    [("main", MAIN, p) for p in (
        P + "LocalStructure.lean", P + "SVMap.lean", P + "StuckChain.lean",
        V + "Basic.lean", V + "Sectors.lean", V + "UnitArc.lean", V + "BaseSteps.lean", V + "Contact.lean",
        V + "Cone.lean", V + "Moves.lean", V + "Surgery.lean", V + "MergeMove.lean", V + "OpenMove.lean",
        W + "Basic.lean", W + "Collar.lean", W + "Merge.lean", W + "NoFourFive.lean", W + "Steps.lean")]
    + [("w5", W5, p) for p in (
        P + "CurveGraph.lean", P + "PlaneTopology.lean", "Proofs/HadwigerNelson/Thomassen.lean",
        V + "MapTopology.lean", V + "MapGraph.lean", V + "BrickMap.lean", V + "Chain.lean", V + "Cor3.lean",
        V + "Dense.lean", V + "FlankUA.lean", V + "HexRing.lean", V + "BaseWalk.lean", V + "BaseDense.lean",
        V + "RadialPush.lean", V + "CollarMap.lean", V + "Pushforward.lean", V + "BendCollar.lean")]
    + [("w5c", W5C, p) for p in (
        V + "Terminal.lean", V + "HornShadow.lean", V + "Limit.lean", V + "Procedure.lean")]
)
# the commits the two earlier passes read (their records' §§ 1.2), for "new or changed since"
OLD_REFS = ["8b30e6e1", "9f54be3d", "f1f26a8a", "89a4aad0", "167a2a74",   # QA2
            "0db34854", "d391f480", "f975677b", "fe10562b"]              # QA3
DEF_KINDS = {"def", "abbrev", "structure", "inductive", "class"}
THM_KINDS = {"theorem", "lemma"}
# construction heads named by the brief: the moves, the bends, the limit, the procedure, the planar reduction, the density steps
CONSTRUCTION_HEADS = {
    "exists_merge", "exists_merge_aux", "exists_rayMerge", "exists_rayMerge_aux", "exists_shave", "exists_shave_aux",
    "exists_open", "bend_toward", "bend_away", "bend_away_whole", "bend_toward_collar", "exists_collarFit",
    "exists_limit", "exists_terminal", "exists_red", "exists_vertexStep", "exists_arcStep", "exists_preBend",
    "n3_base", "localDense", "dense3", "cv_exists", "reduce", "select", "exists_woodallMerged", "aeMap6", "woodall_thm6",
    "cvb_thom", "cvb_thom_reduced", "lemma1", "exists_unenclosed_or_bad", "exists_eleventh", "exists_endpoint",
}
ROW_RE = re.compile(r"\bFS\d{2,3}[A-Za-z]*-[A-Z0-9][A-Za-z0-9′'\-]*|\bE\d-[A-Z][A-Z0-9\-′']*")
INH_RE = re.compile(r"[Ii]nhabit|\b[Mm]odels?\b|[Nn]o model|[Nn]one (is )?expected|refutes the configuration", re.S)


def body_text(text, d):
    lines = text.split("\n")
    return "\n".join(lines[d["line"] - 1: d["line"] - 1 + d["lines"]])


def full_doc(text, d):
    """The whole docstring above declaration `d` (QA1 keeps 400 characters)."""
    lines = text.split("\n")
    j = d["line"] - 2
    while j >= 0 and lines[j].startswith("@["):
        j -= 1
    if j < 0 or not lines[j].rstrip().endswith("-/"):
        return ""
    k = j
    while k >= 0 and "/--" not in lines[k]:
        if "/-!" in lines[k] or (k != j and "-/" in lines[k]):
            return ""
        k -= 1
    return "\n".join(lines[k:j + 1]) if k >= 0 else ""


def conclusion(sig):
    """Text after the last colon at bracket depth 0 of the signature."""
    depth, last = 0, -1
    for i, ch in enumerate(sig):
        if ch in "([{⦃⟨":
            depth += 1
        elif ch in ")]}⦄⟩":
            depth -= 1
        elif ch == ":" and depth == 0 and sig[i:i + 2] != ":=":
            last = i
    return sig[last + 1:].strip() if last >= 0 else ""


def is_refut(sig):
    c = conclusion(sig)
    # the last arrow target at depth 0
    depth, cut = 0, 0
    i = 0
    while i < len(c):
        ch = c[i]
        if ch in "([{⦃⟨":
            depth += 1
        elif ch in ")]}⦄⟩":
            depth -= 1
        elif ch == "→" and depth == 0:
            cut = i + 1
        i += 1
    return c[cut:].strip() == "False"


def is_prop_def(d):
    if d["kind"] in ("structure", "class", "inductive"):
        return True
    c = conclusion(d["sig"])
    return c.endswith("Prop")


def load(sources=None):
    """[(body, ref, path, text, decls)]"""
    out = []
    for body, ref, path in AUDITED:
        text = sources.get((body, path)) if sources is not None else qa1.git_show(ref, path)
        if text is None:
            out.append((body, ref, path, None, []))
            continue
        out.append((body, ref, path, text, qa1.parse(text)))
    return out


def tokens(text):
    return set(re.findall(r"[A-Za-z_][A-Za-z0-9_'′!?]*", qa1.strip_comments(text)))


def theorem_rows(loaded):
    toks = {(b, p): (tokens(t) if t is not None else set()) for b, _, p, t, _ in loaded}
    preds = set()
    for b, _, p, t, ds in loaded:
        for d in ds:
            if d["kind"] in DEF_KINDS and is_prop_def(d):
                preds.add(d["name"].split(".")[-1])
    rows = []
    for b, ref, p, t, ds in loaded:
        if t is None:
            rows.append((b, p, 0, "MISSING", "", "", 0, "", "", ""))
            continue
        for d in ds:
            if d["kind"] not in THM_KINDS:
                continue
            short = d["name"].split(".")[-1]
            doc = full_doc(t, d)
            reasons = []
            rws = sorted(set(ROW_RE.findall(doc)))
            if rws:
                reasons.append("row")
            cited = sorted({os.path.basename(p2)[:-5] for (b2, p2), tk in toks.items()
                            if p2 != p and short in tk})
            if cited:
                reasons.append("cited:" + ",".join(cited[:4]))
            if short in CONSTRUCTION_HEADS:
                reasons.append("construction")
            sig_toks = set(re.findall(r"[A-Za-z_][A-Za-z0-9_'′]*", d["sig"]))
            used = sorted(sig_toks & preds)
            m = INH_RE.search(doc)
            note = ""
            if m:
                s = max(0, m.start() - 40)
                note = " ".join(doc[s:m.start() + 200].split())
            rows.append((b, p, d["line"], d["name"], ";".join(reasons), "REFUT" if is_refut(d["sig"]) else "",
                         d["counts"]["sorry"], note, ",".join(rws), ",".join(used)))
    return rows


def def_rows(loaded, old=None):
    """Each definition, with NEW / CHANGED / SAME against every body any old ref holds under the same last name."""
    if old is None:
        old = {}
        for ref in OLD_REFS:
            for _, _, p in AUDITED:
                t = qa1.git_show(ref, p)
                if t is None:
                    continue
                for d in qa1.parse(t):
                    if d["kind"] in DEF_KINDS:
                        nb = " ".join(qa1.strip_comments(body_text(t, d)).split())
                        old.setdefault(d["name"].split(".")[-1], set()).add(nb)
    thm_sigs = []
    for b, _, p, t, ds in loaded:
        for d in ds:
            if d["kind"] in THM_KINDS:
                thm_sigs.append(set(re.findall(r"[A-Za-z_][A-Za-z0-9_'′]*", d["sig"])))
    rows = []
    for b, ref, p, t, ds in loaded:
        if t is None:
            continue
        for d in ds:
            if d["kind"] not in DEF_KINDS:
                continue
            short = d["name"].split(".")[-1]
            nb = " ".join(qa1.strip_comments(body_text(t, d)).split())
            if short not in old:
                status = "NEW"
            elif nb in old[short]:
                status = "SAME"
            else:
                status = "CHANGED"
            uses = sum(1 for s in thm_sigs if short in s)
            rows.append((b, p, d["line"], d["kind"], d["name"], status, "PROP" if is_prop_def(d) else "data", uses))
    return rows


def self_test():
    fails = 0
    a = ("/-- A predicate. -/\ndef Good (x : Nat) : Prop := x = x\n\n"
         "/-- **FS112-N3-BASE**. **Inhabitant**: `goodModel` below. -/\n"
         "theorem head_row (x : Nat) (h : Good x) : x = x := rfl\n\n"
         "/-- A refutation. No model expected: `head_row` refutes the configuration. -/\n"
         "theorem refut_one (x : Nat) (h : Good x) (h2 : x ≠ x) : False := h2 rfl\n\n"
         "theorem child_only (x : Nat) : x = x := rfl\n\n"
         "theorem cited_elsewhere : True := trivial\n\n"
         "theorem arrow_refut (x : Nat) : Good x → x ≠ x → False := fun _ h => h rfl\n\n"
         "theorem not_refut (x : Nat) : (Good x → False) → True := fun _ => trivial\n")
    b = "theorem user : True := cited_elsewhere\n"
    src = {(bd, p): "" for bd, _, p in AUDITED}
    k0 = (AUDITED[0][0], AUDITED[0][2]); k1 = (AUDITED[1][0], AUDITED[1][2])
    src[k0] = a; src[k1] = b
    rows = {r[3]: r for r in theorem_rows(load(src))}

    def want(cond, msg):
        nonlocal fails
        if not cond:
            print("self-test FAIL:", msg); fails += 1
    want("row" in rows["head_row"][4], "row head missed")
    want(rows["head_row"][8] == "FS112-N3-BASE", f"row id: {rows['head_row'][8]!r}")
    want("nhabitant" in rows["head_row"][7], "inhabitant note missed")
    want(rows["head_row"][9] == "Good", f"predicate in signature missed: {rows['head_row'][9]!r}")
    want(rows["refut_one"][5] == "REFUT", "binder-form refutation missed")
    want(rows["arrow_refut"][5] == "REFUT", "arrow-form refutation missed")
    want(rows["not_refut"][5] == "", "a non-refutation read as one")
    want(rows["child_only"][4] == "", f"a child read as a head: {rows['child_only'][4]!r}")
    want(rows["cited_elsewhere"][4].startswith("cited:"), "cross-module citation missed")
    want("No model expected" in rows["refut_one"][7], "declared-none note missed")
    # planted fault 1: remove the citing module; the head must disappear
    src2 = dict(src); src2[k1] = ""
    r2 = {r[3]: r for r in theorem_rows(load(src2))}
    want(r2["cited_elsewhere"][4] == "", "PLANT: citation still reported after the citing module was emptied")
    # planted fault 2: a missing module is reported
    src3 = dict(src); src3[k1] = None
    want(any(r[3] == "MISSING" for r in theorem_rows(load(src3))), "PLANT: missing module not reported")
    # definitions: NEW / CHANGED / SAME
    old = {"Good": {" ".join("def Good (x : Nat) : Prop := x = x".split())}}
    dr = {r[4]: r for r in def_rows(load(src), old)}
    want(dr["Good"][5] == "SAME" and dr["Good"][7] >= 3, f"def SAME / uses: {dr.get('Good')}")
    src4 = dict(src); src4[k0] = a.replace("x = x\n\n/-- **FS112", "x = 0\n\n/-- **FS112", 1)
    want({r[4]: r for r in def_rows(load(src4), old)}["Good"][5] == "CHANGED", "PLANT: a changed definition read as SAME")
    want({r[4]: r for r in def_rows(load(src), {})}["Good"][5] == "NEW", "PLANT: a new definition not read as NEW")
    print("self-test:", "OK (15 controls, 4 of them planted faults)" if fails == 0 else f"FAIL ({fails})")
    return 1 if fails else 0


def main():
    if len(sys.argv) >= 2 and sys.argv[1] == "--self-test":
        return self_test()
    if len(sys.argv) >= 2 and sys.argv[1] == "theorems":
        heads = "--heads" in sys.argv
        for r in theorem_rows(load()):
            if heads and not r[4] and r[3] != "MISSING":
                continue
            print("\t".join(str(x) for x in r))
        return 0
    if len(sys.argv) >= 2 and sys.argv[1] == "defs":
        for r in def_rows(load()):
            print("\t".join(str(x) for x in r))
        return 0
    if len(sys.argv) >= 2 and sys.argv[1] == "summary":
        import collections
        rows = theorem_rows(load())
        per = collections.OrderedDict()
        for r in rows:
            k = (r[0], os.path.basename(r[1]))
            c = per.setdefault(k, [0, 0, 0, 0, 0])
            c[0] += 1; c[1] += bool(r[4]); c[2] += r[5] == "REFUT"; c[3] += bool(r[6]); c[4] += bool(r[7])
        print("body\tmodule\ttheorems\theads\trefut\tsorry\tinh-note")
        tot = [0] * 5
        for (b, m), c in per.items():
            print(f"{b}\t{m}\t" + "\t".join(str(x) for x in c))
            tot = [x + y for x, y in zip(tot, c)]
        print("TOTAL\t\t" + "\t".join(str(x) for x in tot))
        return 0
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main())
