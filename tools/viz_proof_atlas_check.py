#!/usr/bin/env python3
"""Check the Proof Atlas's fact table against its sources (job VIZ-ATLAS).

Every fact is re-read from the address it names, never from the builder's memory:
  * a node's quote must occur verbatim (after `norm`: markdown marks removed, whitespace collapsed) in the text its address names — one
    LEDGER.md row, one table item, one section, one grokking, one Lean declaration with its docstring, or a whole file;
  * its grade words must occur verbatim at their own address, and the page status must be `fold(grade words)`; a node graded '@lean'
    must name a Lean declaration that exists (`theorem <name>` in the named file);
  * every "also" quote, registered probability (the number must appear in its quoted words) and verbal registration likewise;
  * every edge's quote at its address; both ends must be nodes;
  * every route's links must be nodes, and each node a route reaches must be reachable from its links along the edges;
  * no address may point into tonight's fenced files (another job's working files) — refused before any read.

Exit 0: every fact passes.  Exit 1: FAIL, one line per failed fact, naming it.  Exit 2: ERROR, a source missing or unreadable.
The last line is always the count: "checked N, failed M, errors E".

  python3 tools/viz_proof_atlas_check.py              # check data/viz/proof-atlas/facts.json
  python3 tools/viz_proof_atlas_check.py --self-test  # the controls: the faithful table passes; six plants — a wrong grade, a dead
                                                      # address, a quote not in its source, a wrong registered probability, a fenced
                                                      # address, a route link that is no node — each fire exactly once, naming their
                                                      # fact, and nothing else fires (a two-sided bound: a plant that stops firing, or
                                                      # fires twice, fails the self-test)
"""
import copy, json, pathlib, re, sys

ROOT = pathlib.Path(__file__).resolve().parents[1]
FACTS = ROOT / "data/viz/proof-atlas/facts.json"
sys.path.insert(0, str(ROOT / "tools"))
import viz_proof_atlas_common as C  # noqa: E402


class Report:
    def __init__(s):
        s.n = 0; s.fails = []; s.errors = []

    def ok(s):
        s.n += 1

    def fail(s, fid, msg):
        s.n += 1; s.fails.append(f"FAIL {fid}: {msg}")

    def error(s, fid, msg):
        s.n += 1; s.errors.append(f"ERROR {fid}: {msg}")


def quoted(fid, src, quote, rep, what="quote"):
    """True when `quote` is found at `src`; reports a FAIL (not found / fenced) or an ERROR (unreadable) otherwise."""
    if C.fenced(src["file"]):
        rep.fail(fid, f"{what} address {src['file']} is fenced tonight (another job's working file)"); return False
    try:
        txt = C.text(src)
    except C.SourceError as e:
        msg = str(e)
        (rep.fail if "has no" in msg or "declares no" in msg else rep.error)(fid, f"{what}: {msg}"); return False
    except OSError as e:
        rep.error(fid, f"{what}: cannot read {src['file']}: {e}"); return False
    if C.norm(quote) not in txt:
        rep.fail(fid, f"{what} not found at {C.address_str(src)}: {C.norm(quote)[:90]!r}"); return False
    return True


def check_node(n, rep):
    fid = n["id"]
    if not quoted(fid, n["src"], n["quote"], rep):
        return
    if n["grade"] == "@lean":
        lean = n.get("lean", n["src"])
        if "decl" not in lean:
            rep.fail(fid, "graded kernel through a Lean declaration, but names none"); return
        try:
            C.span(lean)
        except C.SourceError as e:
            rep.fail(fid, f"graded kernel, but {e}"); return
        expect = "kernel"
    else:
        if not quoted(fid, n["grade_src"], n["grade"], rep, "grade words"):
            return
        expect = C.fold(n["grade"])
    if n["status"] != expect:
        rep.fail(fid, f"page status {n['status']!r}, but the source's words {n['grade']!r} fold to {expect!r}"); return
    for a in n.get("also", []):
        if not quoted(fid, a["src"], a["quote"], rep, "second quote"):
            return
    reg = n.get("registered")
    if reg:
        if not quoted(fid, reg["src"], reg["quote"], rep, "registered probability"):
            return
        num = f"{reg['p']:g}"
        pat = r"(?<![\d.])" + re.escape(num) + r"(?![\d])"
        if not re.search(pat, C.norm(reg["quote"])):
            rep.fail(fid, f"registered p = {num} does not appear in its quoted words {reg['quote']!r}"); return
        # and the number must stand at the address — the same row or passage (the quote alone could be edited to agree)
        if not re.search(pat, C.text(reg["src"])):
            rep.fail(fid, f"registered p = {num} not found at {C.address_str(reg['src'])}"); return
    w = n.get("words")
    if w and not quoted(fid, w["src"], w["quote"], rep, "verbal registration"):
        return
    rep.ok()


def check_edge(i, e, ids, rep):
    fid = f"edge {e['source']}→{e['target']}"
    if e["source"] not in ids or e["target"] not in ids:
        rep.fail(fid, "an end is not a node"); return
    if quoted(fid, e["src"], e["quote"], rep):
        rep.ok()


def check_routes(d, rep):
    ids = {n["id"] for n in d["nodes"]}
    succ = {}
    for e in d["edges"]:
        if e["kind"] in ("rests", "half"):
            succ.setdefault(e["source"], set()).add(e["target"])
    for r in d["routes"]:
        fid = f"route {r['id']}"
        missing = [x for x in r["links"] + r["reaches"] if x not in ids]
        if missing:
            rep.fail(fid, f"names no node: {missing}"); continue
        seen, stack = set(r["links"]), list(r["links"])
        while stack:
            for t in succ.get(stack.pop(), ()):
                if t not in seen:
                    seen.add(t); stack.append(t)
        unreached = [x for x in r["reaches"] if x not in seen]
        if unreached:
            rep.fail(fid, f"its links reach no path to {unreached} along the edges"); continue
        rep.ok()


def check_misc(d, rep):
    for c in d["credence"]:
        if c.get("src"):
            if quoted(f"credence {c['status']}", c["src"], c["quote"], rep):
                rep.ok()
    for t in d["notes"]:
        if quoted(f"note {t['id']}", t["src"], t["quote"], rep):
            rep.ok()


def run(d):
    rep = Report()
    ids = {n["id"] for n in d["nodes"]}
    if len(ids) != len(d["nodes"]):
        rep.fail("nodes", "duplicate node ids")
    for n in d["nodes"]:
        check_node(n, rep)
    for i, e in enumerate(d["edges"]):
        check_edge(i, e, ids, rep)
    check_routes(d, rep)
    check_misc(d, rep)
    return rep


def emit(rep):
    for line in rep.fails + rep.errors:
        print(line)
    print(f"checked {rep.n}, failed {len(rep.fails)}, errors {len(rep.errors)}")
    return 2 if rep.errors else 1 if rep.fails else 0


def self_test(d):
    ok = True
    base = run(d)
    if base.fails or base.errors:
        print("SELF-TEST: the faithful table does not pass; fix it first"); emit(base); return 1
    print(f"control 0 (faithful table): PASS — checked {base.n}")

    def plant(name, mutate, expect_fact, expect_kind):
        nonlocal ok
        dd = copy.deepcopy(d); mutate(dd)
        C._cache.clear()
        rep = run(dd)
        lines = rep.fails + rep.errors
        hits = [l for l in lines if expect_fact in l and l.startswith(expect_kind)]
        if len(lines) == 1 and len(hits) == 1:
            print(f"plant {name}: FIRED once, naming {expect_fact} — {hits[0][:130]}")
        else:
            ok = False
            print(f"plant {name}: FAILED CONTROL — expected exactly one {expect_kind} naming {expect_fact}, got {len(lines)}:")
            for l in lines[:6]:
                print("   ", l)

    node = lambda dd, i: next(n for n in dd["nodes"] if n["id"] == i)  # noqa: E731
    plant("wrong grade (MR called kernel)", lambda dd: node(dd, "MR").update(status="kernel"), "MR", "FAIL")
    plant("dead address (row 999)", lambda dd: node(dd, "R131").update(src={"file": "LEDGER.md", "row": "999"}), "R131", "FAIL")
    plant("missing file", lambda dd: node(dd, "R129").update(src={"file": "plans/NO-SUCH-FILE.md"}), "R129", "ERROR")
    plant("quote not in source", lambda dd: node(dd, "R134").update(quote=node(dd, "R134")["quote"].replace("none of radius 1", "none of radius 2")),
          "R134", "FAIL")
    plant("wrong registered p (0.03 → 0.3)", lambda dd: node(dd, "TSMYES")["registered"].update(p=0.3), "TSMYES", "FAIL")
    plant("fenced address", lambda dd: node(dd, "SRAY").update(src={"file": "plans/FS112-YB3-verification.md"}), "SRAY", "FAIL")
    plant("route link that is no node", lambda dd: dd["routes"][2]["links"].append("NOSUCHNODE"), "route wall7", "FAIL")
    # the fence must refuse BEFORE reading: the fenced file is never opened (the cache stays free of it)
    C._cache.clear()
    dd = copy.deepcopy(d); node(dd, "SRAY").update(src={"file": "plans/FS112-YB3-verification.md"}); run(dd)
    if any("YB3" in k for k in C._cache):
        ok = False; print("fence control: FAILED — the fenced file was read")
    else:
        print("fence control: the fenced file was never opened")
    print("SELF-TEST " + ("PASSED" if ok else "FAILED"))
    return 0 if ok else 1


if __name__ == "__main__":
    d = json.loads(FACTS.read_text(encoding="utf-8"))
    if "--self-test" in sys.argv:
        sys.exit(self_test(d))
    sys.exit(emit(run(d)))
