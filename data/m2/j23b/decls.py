"""J23b: list every declaration in M2's ten Lean files with its line, fully qualified name, and whether
scripts/Axioms.lean prints it; mark which names an M2 record mentions. Bookkeeping only (not a gate)."""
import re, sys, json, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
FILES = ["Proofs/HadwigerNelson/Chain.lean", "Proofs/HadwigerNelson/Instances/SqrtTwoThree.lean",
         "Proofs/HadwigerNelson/Instances/SevenConditional.lean", "Proofs/HadwigerNelson/Transcendental.lean",
         "Proofs/HadwigerNelson/UnitRing.lean", "Proofs/HadwigerNelson/Instances/SevenUnitRing.lean",
         "Proofs/HadwigerNelson/Stripe.lean", "Proofs/HadwigerNelson/Bridge.lean",
         "Proofs/HadwigerNelson/RealClosed.lean", "Proofs/HadwigerNelson/NoParam.lean"]
RECORDS = ["plans/M2-kernel-lane.md", "plans/M2-S1K-chain.md", "plans/M2-S2K-route-c.md", "plans/M2-S3K-unit-ring.md",
           "plans/M2-S1D-bridge.md", "plans/M2-S4K-bridge.md", "plans/M2-S5K-noparam.md"]
DECL = re.compile(r"^\s*(?:@\[[^\]]*\]\s*)?(?:(?:private|protected|noncomputable|nonrec|unsafe|partial)\s+)*"
                  r"(theorem|lemma|def|abbrev|instance|structure|inductive|class)\s+([^\s:({\[]+)?")
printed = set()
for ln in (ROOT / "scripts/Axioms.lean").read_text().splitlines():
    m = re.match(r"#print axioms\s+(\S+)", ln)
    if m: printed.add(m.group(1))
rectext = "\n".join((ROOT / r).read_text() for r in RECORDS)
rows = []
for f in FILES:
    ns = []
    in_comment = 0
    for i, ln in enumerate((ROOT / f).read_text().splitlines(), 1):
        s = ln.strip()
        # crude block-comment tracking: skip lines inside /- ... -/ (docstrings end with -/)
        if in_comment:
            if "-/" in s: in_comment = 0
            continue
        if s.startswith("/-") and "-/" not in s[2:]:
            in_comment = 1; continue
        m = re.match(r"^namespace\s+(\S+)", s)
        if m: ns.append(m.group(1)); continue
        m = re.match(r"^end\s+(\S+)", s)
        if m and ns and ns[-1] == m.group(1): ns.pop(); continue
        m = DECL.match(ln)
        if m and not ln.startswith(" "):
            kind, name = m.group(1), m.group(2) or "(anon)"
            if name.startswith("_root_."): full = name[len("_root_."):]
            else: full = ".".join(ns + [name]) if ns else name
            short = full.split(".")[-1]
            named = bool(re.search(r"(?<![\w.])(?:[\w.]*\.)?" + re.escape(short) + r"(?![\w])", rectext)) if short != "(anon)" else False
            rows.append(dict(file=f.replace("Proofs/HadwigerNelson/", ""), line=i, kind=kind, name=full,
                             printed=full in printed, record_named=named))
json.dump(rows, open(ROOT / "data/m2/j23b/decls.json", "w"), indent=0)
th = [r for r in rows if r["kind"] in ("theorem", "lemma")]
print(f"declarations {len(rows)}; theorems {len(th)}; theorems printed {sum(r['printed'] for r in th)}")
miss = [r for r in th if r["record_named"] and not r["printed"]]
print(f"record-named theorems NOT printed: {len(miss)}")
for r in miss: print(f"  {r['file']}:{r['line']} {r['name']}")
other = [r for r in rows if r["printed"] and r["kind"] not in ("theorem", "lemma")]
print("printed non-theorems:", [r["name"] for r in other])
unk = sorted(p for p in printed if any(p.startswith("HadwigerNelson." + x) for x in
      ("Chain.", "SqrtTwoThree.", "SevenConditional.", "RouteC.", "UnitRing.", "SevenUnitRing.", "Stripe.", "Bridge.", "NoParam."))
      and p not in {r["name"] for r in rows})
print("printed M2 names not found by the parser:", unk)
