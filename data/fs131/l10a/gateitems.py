#!/usr/bin/env python3
"""FS131-L10A: for each head of wave 10's first pass, what its docstring says of an inhabitant of its hypotheses.
Read from the landed sources: the docstring (the `/-- … -/` block before the theorem) is searched for a note
(`INHABITANT`, `Inhabitant`, `inhabit`, `model`, `satisfiable`, `open … question`, `no Lean model`), and the statement's
binders are listed by kind (explicit hypotheses `(h… : …)` only). A head with explicit hypotheses and no note is printed
NO-NOTE; with a note, NOTE and the sentence; with no explicit hypothesis, NO-HYPOTHESIS.
usage (from the worktree root): data/fs131/l10a/gateitems.py [--self-test]"""
import importlib.util, re, sys
spec = importlib.util.spec_from_file_location("stm", "tools/fs131_l10a_statements.py")
stm = importlib.util.module_from_spec(spec); spec.loader.exec_module(stm)
spec = importlib.util.spec_from_file_location("hyps", "tools/fs131_l10a_hyps.py")
hy = importlib.util.module_from_spec(spec); spec.loader.exec_module(hy)
NOTE = re.compile(r"INHABITANT|[Ii]nhabitant|inhabit|\bmodel\b|satisfiable|open [a-z-]* ?(question|problem)|no Lean model", re.S)

def classify(doc, stmt):
    groups, _ = hy.split(stmt)
    hyps = [g for g in groups if g.startswith("(") and re.match(r"\((h\w*|hf|hc|hT|hS\w*|hπ|hadd|hcomm|hsymm|hG|hH|hW|hK0|hm|ht)\b", g)]
    m = NOTE.search(doc)
    if not hyps:
        return "NO-HYPOTHESIS", ""
    if not m:
        return "NO-NOTE", ""
    s = doc[max(0, doc.rfind(".", 0, m.start()) + 1):]
    return "NOTE", " ".join(s.split())[:230]

def main(argv):
    if argv == ["--self-test"]:
        a = classify("/-- X. Inhabitant of the hypotheses: `foo`. -/", "theorem a (h : P) : Q")
        b = classify("/-- X. Nothing said. -/", "theorem b (h : P) : Q")
        c = classify("/-- X. -/", "theorem c : Q")
        ok = a[0] == "NOTE" and b[0] == "NO-NOTE" and c[0] == "NO-HYPOTHESIS"
        print("self-test:", "PASS" if ok else f"FAIL {a} {b} {c}"); return 0 if ok else 1
    heads = [h.strip() for h in open("data/fs131/l10a/heads.txt", encoding="utf-8") if h.strip()]
    rows = {}
    for f in hy.FILES:
        for q, k, doc, stmt, short in stm.chunks(open(f"Proofs/HadwigerNelson/Arith/{f}.lean", encoding="utf-8").read()):
            if q in heads:
                rows[q] = classify(doc, stmt)
    n = {"NOTE": 0, "NO-NOTE": 0, "NO-HYPOTHESIS": 0}
    for h in heads:
        v, s = rows.get(h, ("NOT-FOUND", ""))
        n[v] = n.get(v, 0) + 1
        print(f"{v:14s} {h.split('HadwigerNelson.')[-1]:55s} {s}")
    print(f"heads {len(heads)}: " + ", ".join(f"{k} {v}" for k, v in n.items()))
    return 0

if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
