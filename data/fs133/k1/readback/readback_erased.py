#!/usr/bin/env python3
"""FS133-K1 — the second read-back: the eight declarations with every instance argument and every proof argument
erased (FS132-I2's dumper, `ErasedBody.lean.inc`, run at both pins).  For each: FULL identical, or ERASED identical
(the two stored terms differ only inside instance and proof arguments; the constants named at one pin only are
listed), or DIFFERENT.  The release's namespaces are already written `§.` by the dump's labels; inside terms the two
prefix pairs are normalised here, and Mathlib's rename `Set.ofPred` (there) -> `setOf` (here) is applied to the
release's print.  Exit 0 only with no DIFFERENT.   --control: plants a fault in the erased type of the axiom here (a
binder kind) and a constant of its erased type (`kCoeff`), and requires each DIFFERENT."""
import re, sys, pathlib
PAIRS = [("OAI.PlaneFiveColor.Spectral.", "HadwigerNelson.Outside.OAI158.Spectral.", "§.Spectral."),
         ("OAI.EuclideanFiveColor.", "HadwigerNelson.Outside.OAI158.", "§.")]
def norm(s, release):
    for a, b, to in PAIRS:
        s = s.replace(a, to).replace(b, to)
    if release:
        s = re.sub(r"(?<![\w.])Set\.ofPred(?![\w.])", "setOf", s)
    return s
def load(path, release):
    out, cur = {}, None
    for ln in norm(pathlib.Path(path).read_text(), release).splitlines():
        m = re.match(r"DUMP (\S+) : (\w+) levels=(.*)$", ln)
        if m:
            cur = m.group(1); out[cur] = {"kind": m.group(2), "levels": m.group(3), "uses": set()}; continue
        m = re.match(r"DUMP   (type |etype|value|evalue)\s*= (.*)$", ln)
        if m and cur:
            out[cur][m.group(1).strip()] = m.group(2); continue
        m = re.match(r"USES (\S+) : (\S+) @", ln)
        if m and m.group(1) in out:
            out[m.group(1)]["uses"].add(m.group(2))
    return out
def compare(rel, our):
    bad, rows = 0, []
    for name in rel:
        if name not in our:
            rows.append(f"DIFFERENT        {name}: absent here"); bad += 1; continue
        r, o = rel[name], our[name]
        full = r.get("type") == o.get("type") and r.get("value") == o.get("value") and r["levels"] == o["levels"]
        erased = r.get("etype") == o.get("etype") and r.get("evalue") == o.get("evalue") and r["levels"] == o["levels"]
        if full:
            rows.append(f"IDENTICAL        {name}")
        elif erased:
            rows.append(f"UP-TO-INSTANCES  {name}: only there {sorted(r['uses'] - o['uses'])}; only here {sorted(o['uses'] - r['uses'])}")
        else:
            rows.append(f"DIFFERENT        {name}"); bad += 1
    return bad, rows
rel, our = load(sys.argv[1], True), load(sys.argv[2], False)
if "--control" in sys.argv:
    import copy
    a = copy.deepcopy(our); a["§.Spectral.residual_fourier"]["etype"] = a["§.Spectral.residual_fourier"]["etype"].replace("(pi.d U ", "(pi.i U ", 1)
    b = copy.deepcopy(our); b["§.Spectral.residual_fourier"]["etype"] = b["§.Spectral.residual_fourier"]["etype"].replace("§.Spectral.kCoeff", "§.Spectral.K", 1)
    ok = True
    for what, x in (("a binder kind of the axiom", a), ("a constant of the axiom (kCoeff)", b)):
        if x == our: print("CONTROL NOT PLANTED:", what); ok = False; continue
        n, _ = compare(rel, x); print(f"CONTROL {'refused' if n == 1 else 'NOT REFUSED'}: {what}"); ok = ok and n == 1
    sys.exit(0 if ok else 1)
bad, rows = compare(rel, our)
print("\n".join(rows)); print(f"declarations: {len(rel)}  different: {bad}")
sys.exit(1 if bad else 0)
