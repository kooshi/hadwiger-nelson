#!/usr/bin/env python3
"""Check the Local–Global Map's facts table against its sources (crunch job J43).

Every fact is re-read from the file it names: its pattern, filled with its value and the source's grade words, must occur verbatim
(after removing markdown bold and backticks and collapsing whitespace) in that file — or in the one LEDGER.md row or § B entry its
scope names — and the page's grade must be the fold of those words (DESIGN.md §1.3). The fields' places are recomputed here by an
independent method (brute-force square roots, not Euler's criterion) and controlled against data/fplane/map.json. Every theorem
row is re-parsed from LEDGER.md and its grade and keyword tags recomputed.

Exit 0: every fact passes.  Exit 1: FAIL — one line per failed fact, naming it.  Exit 2: ERROR — a source missing or unreadable.
The last line is always the count: "checked N, failed M, errors E".

  python3 tools/viz_local_global_map_check.py              # check data/viz/local-global-map/facts.json
  python3 tools/viz_local_global_map_check.py --self-test  # the controls: a faithful copy passes; a planted wrong grade, a
                                                           # planted wrong number and an unreadable source each fire, naming
                                                           # their fact, and nothing else fires (two-sided bound)
"""
import copy, json, pathlib, re, sys
ROOT = pathlib.Path(__file__).resolve().parents[1]
FACTS = ROOT / "data/viz/local-global-map/facts.json"
sys.path.insert(0, str(ROOT / "tools"))
from viz_local_global_map_common import norm, fold, parse_ledger, row_grade, fill  # text handling only


class Report:
    def __init__(s): s.n = 0; s.fails = []; s.errors = []
    def ok(s): s.n += 1
    def fail(s, fid, msg): s.n += 1; s.fails.append(f"FAIL {fid}: {msg}")
    def error(s, fid, msg): s.n += 1; s.errors.append(f"ERROR {fid}: {msg}")


def texts(src, scope, cache):
    """The normalised text a fact must be found in, or raise OSError when the source cannot be read."""
    if src not in cache:
        cache[src] = (ROOT / src).read_text(encoding="utf-8")   # OSError propagates: an unreadable source is an ERROR, never a pass
    if not scope: return norm(cache[src]), None
    led = cache.setdefault(("ledger", src), parse_ledger(ROOT / src))
    if "row" in scope:
        r = [x for x in led["rows"] if x["n"] == scope["row"]]
        if not r: raise OSError(f"{src} has no row {scope['row']}")
        return r[0]["text"] + " | " + r[0]["where"], r[0]
    r = [x for x in led["B"] if x["id"] == scope["B"]]
    if not r: raise OSError(f"{src} § B has no entry {scope['B']}")
    return r[0]["text"] + " | " + r[0]["grade"], None


def check_fact(f, rep, cache):
    fid = f["id"]
    try:
        txt, row = texts(f["src"], f.get("scope"), cache)
    except OSError as e:
        rep.error(fid, f"cannot read {f['src']}: {e}"); return
    graw = f.get("graw", "")
    want = fill(f["pat"], f, graw)
    if want not in txt:
        rep.fail(fid, f"expected {want!r} in {f['src']}{' row ' + str(f['scope']) if f.get('scope') else ''}; not found"); return
    if f.get("gpat"):
        gw = fill(f["gpat"], f, graw)
        if gw not in txt: rep.fail(fid, f"grade words {gw!r} not found in {f['src']}"); return
    if not graw:           # an existence check of a quoted remainder or of a wall's other side: the text is all it asserts
        rep.ok(); return
    if graw == "@lean":    # a kernel theorem named by its Lean identifier, in a row whose address is a Lean module
        if not row or ".lean" not in row["where"] or not re.search(r"[a-z]+_[A-Za-z0-9_]+", want):
            rep.fail(fid, "graded kernel through a Lean name, but the row names no .lean module or the pattern names no Lean theorem"); return
        expect = "kernel"
    elif graw.startswith("[kernel] (a Lean module"):
        if not row or ".lean" not in row["where"]: rep.fail(fid, "graded kernel by its Lean address, but the row names no .lean module"); return
        expect = "kernel"
    else:
        if row is not None and graw != row_grade(row["text"], row["where"]) and not f.get("gpat"):
            rep.fail(fid, f"grade words {graw!r} are not this row's grade {row_grade(row['text'], row['where'])!r}"); return
        if not f.get("gpat") and graw and not row and graw not in txt and "{g}" not in f["pat"]:
            rep.fail(fid, f"grade words {graw!r} not found in {f['src']}"); return
        expect = fold(graw)
    if f["grade"] != expect:
        rep.fail(fid, f"page grade {f['grade']!r}, but the source's words {graw!r} fold to {expect!r}"); return
    rep.ok()


# ---- independent arithmetic: square roots by brute force; square classes by explicit subset products
def is_square_mod(a, p): return any((x * x - a) % p == 0 for x in range(p))
def sqfree(n):
    out, p = 1, 2
    while p * p <= n:
        while n % (p * p) == 0: n //= p * p
        if n % p == 0: out *= p; n //= p
        p += 1
    return out * n
def subset_classes(rad):
    out = set()
    for m in range(1 << len(rad)):
        prod = 1
        for i, d in enumerate(rad):
            if m >> i & 1: prod *= d
        out.add(sqfree(prod))
    return out
def place_state(rad, pid):
    if pid in ("5", "13", "17", "29", "p1big"): return "split"
    if pid == "big": return "stable"
    if pid == "27": return "absent"
    cl = subset_classes(rad)
    if pid == "2":
        odd = [c for c in cl if c % 2]
        return "split" if any(c % 8 == 7 for c in odd) else "inert" if any(c % 8 == 3 for c in odd) else "ramified"
    p = int(pid)
    return "stable" if all(is_square_mod(c % p, p) for c in cl if c % p) else "split"

RULES = {  # the arithmetic a field fact's `rule` names, recomputed
    "d ≡ 11 (mod 12)": lambda f: f["rad"] and len(f["rad"]) == 1 and f["rad"][0] % 12 == 11,
    "d ≡ 3, 7 (mod 12)": lambda f: f["rad"] and len(f["rad"]) == 1 and f["rad"][0] % 12 in (3, 7),
    "contains K": lambda f: {3, 11} <= set(f["rad"] or []),
    "Heule-510 ⊂ K(√5)": lambda f: set(f["rad"] or []) == {3, 5, 11},
    "K(√5) ⊂ de Grey's field": lambda f: {3, 5, 11} <= set(f["rad"] or []),
    "contains ℚ(√79); 79 ≡ 7 (mod 12)": lambda f: 79 % 12 == 7 and "√79" in f["name"],
}


def run(d, rep):
    cache = {}
    facts = d["targets"] + d["field_facts"] + d["owned"] + d["walls"]
    for sh in d["shadows"]:
        facts += sh["carves"]
        for key in ("remains_src",):
            s = sh[key]; facts.append(dict(id=f"{sh['id']}.remains", v="", grade=fold(""), graw="", src=s["src"], pat=s["pat"], scope=s.get("scope")))
    for w in d["walls"]:
        for key in ("broke_src", "stands_src"):
            if key in w:
                s = w[key]; facts.append(dict(id=f"{w['id']}.{key}", v="", grade=fold(""), graw="", src=s["src"], pat=s["pat"], scope=s.get("scope")))
    for f in facts: check_fact(f, rep, cache)
    fields = {f["id"]: f for f in d["fields"]}
    for f in d["field_facts"]:
        if f.get("rule") and f["field"] in fields:
            if f["rule"] not in RULES: rep.fail(f["id"], f"unknown rule {f['rule']!r}")
            elif not RULES[f["rule"]](fields[f["field"]]): rep.fail(f["id"], f"the field {f['field']} does not satisfy its rule {f['rule']!r}")
            else: rep.ok()
    # places, recomputed; then the control against data/fplane/map.json
    try:
        mj = json.loads((ROOT / "data/fplane/map.json").read_text(encoding="utf-8"))
    except OSError as e:
        rep.error("control.map.json", str(e)); mj = {"rows": []}
    byrad = {tuple(sorted(r["radicands"])): r for r in mj["rows"]}
    ncontrol = 0
    for f in d["fields"]:
        if f["rad"] is None: continue
        for pid, st in f["places"].items():
            if pid == "inf": continue
            mine = place_state(f["rad"], pid)
            if mine != st: rep.fail(f"field.{f['id']}.{pid}", f"page says {st!r}, recomputed {mine!r}")
            else: rep.ok()
        r = byrad.get(tuple(sorted(f["rad"])))
        if r:
            ncontrol += 1
            if (place_state(f["rad"], "2") == "split") != r["wall_broken"]:
                rep.fail(f"control.{f['id']}.2", f"map.json wall_broken={r['wall_broken']} disagrees with the recomputed dyadic state")
            last = max(r["usable"]) if r["usable"] else 0
            for pid in ("3", "7", "11", "19", "23", "31", "43", "47", "59", "67", "71", "79", "83"):
                if int(pid) <= last and (place_state(f["rad"], pid) == "stable") != (int(pid) in r["usable"]):
                    rep.fail(f"control.{f['id']}.{pid}", f"map.json usable list disagrees at {pid}")
            rep.ok()
    if ncontrol < 15: rep.fail("control.map.json", f"only {ncontrol} fields matched map.json rows; the control needs at least 15")
    # theorems: re-parse, recompute grade and tags
    led = parse_ledger(ROOT / "LEDGER.md")
    rx = {ax: {k: re.compile(v) for k, v in rules.items()} for ax, rules in d["tag_rules"].items()}
    src = {f"row{r['n']}": ("row", r) for r in led["rows"]} | {b["id"]: ("B", b) for b in led["B"]}
    blines = sum(1 for l in (ROOT / "LEDGER.md").read_text(encoding="utf-8").split("\n## B.", 1)[1].split("\n")
                 if l.startswith("| ") and not l.startswith("| id ") and not l.startswith("|---"))
    nB = sum(1 for t in d["theorems"] if t["kind"] == "B")
    if nB != blines: rep.fail("theorems.count", f"{nB} § B entries on the page, {blines} table lines in LEDGER.md § B")
    else: rep.ok()
    for t in d["theorems"]:
        if t["id"] not in src: rep.fail(t["id"], "not in LEDGER.md"); continue
        kind, s = src[t["id"]]
        graw = row_grade(s["text"], s["where"]) if kind == "row" else s["grade"]
        g = "kernel" if graw.startswith("[kernel] (a Lean") else fold(graw)
        tags = {ax: sorted(k for k, r in rules.items() if r.search(s["text"])) for ax, rules in rx.items()}
        if not s["text"].startswith(t["text"]): rep.fail(t["id"], "text differs from LEDGER.md")
        elif t["graw"] != graw or t["grade"] != g: rep.fail(t["id"], f"grade {t['grade']!r} ({t['graw']!r}); LEDGER.md gives {g!r} ({graw!r})")
        elif t["tags"] != tags: rep.fail(t["id"], f"tags {t['tags']} differ from the rule's {tags}")
        else: rep.ok()
    for t in d["theorems"]:
        want = (t["n"] in d["crunch"]["rows"]) if t["kind"] == "row" else (t["milestone"] in d["crunch"]["milestones"])
        if t["crunch"] != want: rep.fail(t["id"], f"crunch flag {t['crunch']} but the rule says {want}")


def report(rep, quiet=False):
    if not quiet:
        for l in rep.errors + rep.fails: print(l)
    print(f"checked {rep.n}, failed {len(rep.fails)}, errors {len(rep.errors)}")
    return 2 if rep.errors else 1 if rep.fails else 0


def self_test(d):
    def once(dd):
        r = Report(); run(dd, r); return r
    base = once(d)
    print(f"faithful copy: checked {base.n}, failed {len(base.fails)}, errors {len(base.errors)}")
    assert not base.fails and not base.errors, "the faithful copy must pass"
    plants = []
    g = copy.deepcopy(d); f = next(x for x in g["targets"] if x["id"] == "t.23.floor"); f["grade"] = "kernel"
    plants.append(("wrong grade (the floor at 23 called kernel; its source says [cert])", g, "t.23.floor", "fails"))
    n = copy.deepcopy(d); f = next(x for x in n["targets"] if x["id"] == "t.43.floor"); f["v"] = 5
    plants.append(("wrong number (the floor at 43 set to 5; its source says 6)", n, "t.43.floor", "fails"))
    e = copy.deepcopy(d); f = next(x for x in e["walls"] if x["id"] == "w.real4"); f["src"] = "plans/NO-SUCH-FILE.md"
    plants.append(("unreadable source (the real-place wall pointed at a missing file)", e, "w.real4", "errors"))
    t = copy.deepcopy(d); x = next(x for x in t["theorems"] if x["id"] == "row113"); x["grade"] = "kernel"
    plants.append(("wrong theorem grade (row 113 called kernel)", t, "row113", "fails"))
    q = copy.deepcopy(d); x = next(x for x in q["fields"] if x["id"] == "Q47"); x["places"]["11"] = "split"
    plants.append(("wrong place state (the prime 11 called split in ℚ(√47); 47 is a square mod 11)", q, "field.Q47.11", "fails"))
    ok = True
    for name, dd, fid, kind in plants:
        r = once(dd); got = r.fails if kind == "fails" else r.errors
        extra = len(r.fails) + len(r.errors) - len(base.fails) - len(base.errors)
        named = [l for l in got if f" {fid}:" in l]
        fired = bool(named) and extra == 1          # two-sided: it fires (lower bound) and fires alone (upper bound)
        print(f"{'FIRED ' if fired else 'SILENT'} {name}: {extra} new {kind}; {named[0] if named else 'the fact was not named'}")
        ok &= fired
    print("self-test PASSED" if ok else "self-test FAILED: a control did not fire exactly once, naming its fact")
    return 0 if ok else 1


def main():
    d = json.loads(FACTS.read_text(encoding="utf-8"))
    if "--self-test" in sys.argv: sys.exit(self_test(d))
    rep = Report(); run(d, rep); sys.exit(report(rep))


if __name__ == "__main__":
    main()
