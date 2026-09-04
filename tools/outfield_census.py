#!/usr/bin/env python3
"""outfield_census — RISKS R1's test read from three replay checkpoints (M53 §B D3, §Bʺ.3, §Bʹʹʹ.2).

    python3 tools/outfield_census.py --residual --infield <replay dir> --out build/m53-p0/residual-rows.txt
    python3 tools/outfield_census.py --classes <classes.jsonl> --batch u-v,… --label <object> \
        --infield <dir> --full <dir> --outfield <dir> \
        --manifest-in <json> --manifest-full <json> --manifest-out <json> --result data/m53/outfield-census-<label>.json
    python3 tools/outfield_census.py --self-test

Pools P_in, P_out ⊆ P (disjoint, exhaustive) over one class list. Verdicts are monotone: an extension
over a superset restricts to one over the subset, so killed(Q) ⟹ killed(Q′ ⊇ Q) and survives(Q′) ⟹
survives(Q). The join over (in, full): (killed, survives) is IMPOSSIBLE and REFUSED (an instrument
fault, never a finding); (survives, killed) is THE NUMBER — classes provably beyond in-field material
at depth 1 and provably within the full pool's; (survives, survives) beyond depth 1 entirely;
(unknown, killed) undecided for the test; (unknown, survives) ⟹ survives in-field, DERIVED and labelled;
(survives, unknown) undecided. With P_out on the same residual the number splits into out-alone
(killed_out) and cooperative (survives_out ∧ killed_full). R1 reads FIRST HORN when the number is 0
with no unknowns anywhere in the residual, SECOND HORN when it is positive, UNDECIDED otherwise. A
checkpoint over a different class list, or an unfinished replay of its rows, is refused. UNTRUSTED
like all of tools/; the headline carries every population and cap."""
from __future__ import annotations
import argparse, hashlib, json, os, sys, tempfile, time
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
VERDICTS = ("killed", "survives", "unknown")


def read_checkpoint(d: Path):
    """(N, pool_fp, budget, {idx: verdict})."""
    p = Path(d) / "verdicts.jsonl"
    if not p.exists():
        raise SystemExit(f"[census] REFUSED: no verdicts.jsonl in {d}")
    lines = p.read_text().splitlines()
    h = lines[0].split(); assert h[0] == "#", lines[0]
    N, fp = int(h[1]), h[2]
    budget = " ".join(h[3:])
    V = {}
    for l in lines[1:]:
        if not l.strip():
            continue
        i, v = l.split(); i = int(i)
        assert v in VERDICTS, (d, i, v)
        assert i not in V, f"[census] REFUSED: class {i} answered twice in {d}"
        V[i] = v
    return N, fp, budget, V


def residual(a):
    N, fp, budget, V = read_checkpoint(Path(a.infield))
    missing = [i for i in range(N) if i not in V]
    if missing:
        raise SystemExit(f"[census] REFUSED: the in-field replay is unfinished — {len(missing)} of {N} classes have no verdict "
                         f"(first {missing[:5]}); re-run it (it resumes) before asking for the residual")
    rows = sorted(i for i, v in V.items() if v != "killed")
    Path(a.out).write_text("".join(f"{i}\n" for i in rows))
    ks = sum(1 for v in V.values() if v == "killed"); ss = sum(1 for v in V.values() if v == "survives"); us = N - ks - ss
    print(f"[census] in-field ({fp}, {budget}): {ks} killed, {ss} survive, {us} unknown of {N}; residual S_in ∪ U_in = {len(rows)} rows → {a.out}")


def census(a, log=print):
    classes = Path(a.classes)
    lines = classes.read_text().splitlines(); head = json.loads(lines[0]); n_classes = len([l for l in lines[1:] if l.strip()])
    sha = hashlib.sha256(classes.read_bytes()).hexdigest()[:16]
    mans = {k: json.loads(Path(p).read_text()) for k, p in (("in", a.manifest_in), ("full", a.manifest_full), ("out", a.manifest_out))}
    fp_full = mans["full"]["pool"]["fingerprint"]
    for k in ("in", "out"):
        der = mans[k].get("derived_from", {})
        if der.get("pool_fingerprint") != fp_full:
            raise SystemExit(f"[census] REFUSED: the {k} pool is not derived from the full pool ({der.get('pool_fingerprint')} vs {fp_full})")
    cps = {}
    for k, d in (("in", a.infield), ("full", a.full), ("out", a.outfield)):
        N, fp, budget, V = read_checkpoint(Path(d))
        if N != n_classes:
            raise SystemExit(f"[census] REFUSED: the {k} checkpoint names {N} classes, the list has {n_classes} — different class lists")
        if fp != mans[k]["pool"]["fingerprint"]:
            raise SystemExit(f"[census] REFUSED: the {k} checkpoint's pool {fp} is not the {k} manifest's {mans[k]['pool']['fingerprint']}")
        cps[k] = (V, budget)
    Vin, Vfull, Vout = cps["in"][0], cps["full"][0], cps["out"][0]
    missing = [i for i in range(n_classes) if i not in Vin]
    if missing:
        raise SystemExit(f"[census] REFUSED: the in-field replay is unfinished ({len(missing)} classes unanswered)")
    resid = sorted(i for i, v in Vin.items() if v != "killed")
    for k, V in (("full", Vfull), ("out", Vout)):
        miss = [i for i in resid if i not in V]
        if miss:
            raise SystemExit(f"[census] REFUSED: the {k} replay is unfinished over the residual ({len(miss)} of {len(resid)} rows unanswered; "
                             f"first {miss[:5]}) — an unfinished replay is not a census; re-run it (it resumes)")
    # the join table
    cells: dict[tuple, list] = {}
    per_class = {}
    for i in resid:
        vi, vf, vo = Vin[i], Vfull[i], Vout[i]
        if vi == "killed" and vf == "survives":
            raise SystemExit(f"[census] REFUSED (instrument fault): class {i} is KILLED on the in-field pool and SURVIVES the full pool — "
                             f"monotonicity violated; the checkpoints are not over the same object/pools")
        if vo == "killed" and vf == "survives":
            raise SystemExit(f"[census] REFUSED (instrument fault): class {i} is KILLED on the out-of-field pool and SURVIVES the full pool")
        derived = None
        if vi == "unknown" and vf == "survives":
            derived = "survives-in-field (derived from the full pool's survival)"
        cells.setdefault((vi, vf), []).append(i)
        per_class[i] = {"in": vi, "full": vf, "out": vo, **({"derived": derived} if derived else {})}
    S_in = [i for i in resid if Vin[i] == "survives"]; U_in = [i for i in resid if Vin[i] == "unknown"]
    X = [i for i in S_in if Vfull[i] == "killed"]; Y = [i for i in S_in if Vfull[i] == "survives"]; Z = [i for i in S_in if Vfull[i] == "unknown"]
    Uk = [i for i in U_in if Vfull[i] == "killed"]; Us = [i for i in U_in if Vfull[i] == "survives"]; Uu = [i for i in U_in if Vfull[i] == "unknown"]
    W = [i for i in X if Vout[i] == "killed"]; coop = [i for i in X if Vout[i] == "survives"]; Wu = [i for i in X if Vout[i] == "unknown"]
    K_in = n_classes - len(resid)
    if len(X) > 0:
        horn = "SECOND HORN — some class of this batch provably needs out-of-field material at depth 1 (the tiers hide it)"
    elif len(Z) == 0 and len(U_in) == 0:
        horn = "FIRST HORN — no class of this batch needs an out-of-field point at depth 1 (every in-field survivor survives the full pool too)"
    else:
        horn = "UNDECIDED — the number is 0 but unknowns remain in the residual"
    n_in, n_full, n_out = (mans[k]["pool"]["n_points"] for k in ("in", "full", "out"))
    headline = (f"B₀ = {{{a.batch}}} ({len(a.batch.split(','))} cheats) on {a.label}: {n_classes:,} classes. In-field pool ({n_in:,} points; rule: "
                f"{mans['in']['pool']['params'].get('rule', '?')}; {cps['in'][1]}): {K_in:,} killed, {len(S_in):,} survive (proof), {len(U_in):,} unknown. "
                f"Full pool ({n_full:,} points; {cps['full'][1]}) on the residual S_in ∪ U_in = {len(resid):,}: of S_in — {len(X)} killed "
                f"= classes provably needing out-of-field material at depth 1, {len(Y)} survive the full pool too, {len(Z)} unknown; "
                f"of U_in — {len(Uk)} killed, {len(Us)} survive (⟹ survive in-field, derived), {len(Uu)} unknown. "
                f"Out-of-field pool ({n_out:,} points; {cps['out'][1]}) alone on the number: {len(W)} out-alone, {len(coop)} cooperative, "
                f"{len(Wu)} unknown. R1 reads: {horn}.")
    res = {"kind": "outfield-census", "label": a.label, "batch": a.batch.split(","), "classes": n_classes, "classes_sha256_16": sha,
           "stage_fingerprint": head.get("stage_fingerprint"), "headline": headline, "horn": horn.split(" — ")[0],
           "number": len(X), "table": {"K_in": K_in, "S_in": len(S_in), "U_in": len(U_in), "residual": len(resid),
                                       "S_in×full": {"killed": len(X), "survives": len(Y), "unknown": len(Z)},
                                       "U_in×full": {"killed": len(Uk), "survives(derived survives_in)": len(Us), "unknown": len(Uu)},
                                       "number×out": {"out-alone": len(W), "cooperative": len(coop), "unknown": len(Wu)},
                                       "impossible_cells": "refused, never written"},
           "classes_by_cell": {"S_in_killed_full": X, "S_in_survives_full": Y, "S_in_unknown_full": Z, "U_in_killed_full": Uk,
                               "U_in_survives_full": Us, "U_in_unknown_full": Uu, "out_alone": W, "cooperative": coop},
           "per_class": per_class,
           "conditioning": {"pools": {k: {"fingerprint": mans[k]["pool"]["fingerprint"], "n_points": mans[k]["pool"]["n_points"],
                                          "params": mans[k]["pool"].get("params"), "budget": cps[k][1]} for k in ("in", "full", "out")},
                            "machine": os.uname().nodename, "written": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())},
           "claim_scope": "one batch on one object; 'survives' is a proof of extension over the named pool; 'killed' transfers upward; "
                          "unknowns are caps and never folded; the number counts in-field SURVIVORS killed on the full pool"}
    if a.result:
        Path(a.result).parent.mkdir(parents=True, exist_ok=True); Path(a.result).write_text(json.dumps(res, indent=1))
    log(f"[census] {headline}")
    if a.result:
        log(f"[census] wrote {a.result}")
    return res


def self_test():
    tmp = Path(tempfile.mkdtemp(prefix="census-selftest-"))
    def write(d, N, fp, rows, budget="conflicts=1"):
        (tmp / d).mkdir(); (tmp / d / "verdicts.jsonl").write_text(f"# {N} {fp} {budget}\n" + "".join(f"{i} {v}\n" for i, v in rows))
    def man(name, fp, n, derived=None, params=None):
        m = {"schema_version": 1, "kind": "pool-export", "pool": {"fingerprint": fp, "name": name, "n_points": n, "params": params or {}}}
        if derived:
            m["derived_from"] = {"pool_fingerprint": derived}
        p = tmp / f"{name}.json"; p.write_text(json.dumps(m)); return str(p)
    cl = tmp / "classes.jsonl"; cl.write_text(json.dumps({"kind": "enumeration-header", "stage_fingerprint": "s"}) + "\n" + "".join('"0"\n' for _ in range(10)))
    # in-field: 0-2 killed, 3-5 survive, 6-9 unknown; full on residual 3..9; out on residual
    write("in", 10, "fin", [(i, "killed") for i in range(3)] + [(i, "survives") for i in (3, 4, 5)] + [(i, "unknown") for i in (6, 7, 8, 9)])
    write("full", 10, "ffull", [(3, "killed"), (4, "survives"), (5, "unknown"), (6, "killed"), (7, "survives"), (8, "unknown"), (9, "killed")])
    write("out", 10, "fout", [(3, "killed"), (4, "survives"), (5, "unknown"), (6, "killed"), (7, "survives"), (8, "unknown"), (9, "survives")])
    class A: pass
    a = A(); a.classes = str(cl); a.batch = "1-2,3-4"; a.label = "T"; a.infield = str(tmp / "in"); a.full = str(tmp / "full"); a.outfield = str(tmp / "out")
    a.manifest_in = man("in", "fin", 3, "ffull", {"rule": "test"}); a.manifest_full = man("full", "ffull", 10); a.manifest_out = man("out", "fout", 7, "ffull"); a.result = None
    res = census(a, log=lambda *x: None)
    t = res["table"]
    assert (t["K_in"], t["S_in"], t["U_in"]) == (3, 3, 4) and t["S_in×full"] == {"killed": 1, "survives": 1, "unknown": 1}
    assert t["U_in×full"] == {"killed": 2, "survives(derived survives_in)": 1, "unknown": 1} and res["number"] == 1
    assert t["number×out"] == {"out-alone": 1, "cooperative": 0, "unknown": 0} and res["per_class"][7]["derived"]
    assert res["horn"] == "SECOND HORN"
    print("[census self-test] every cell of the join table counted; the derived survives_in labelled; the number = 1 → SECOND HORN")
    # the impossible cell must refuse
    write("bad", 10, "ffull", [(3, "killed"), (4, "survives"), (5, "unknown"), (6, "killed"), (7, "survives"), (8, "unknown"), (9, "killed")])
    (tmp / "in" / "verdicts.jsonl").write_text("# 10 fin c\n" + "".join(f"{i} killed\n" for i in range(3)) + "3 killed\n4 survives\n5 survives\n6 unknown\n7 unknown\n8 unknown\n9 unknown\n")
    # now class 3 is killed in-field → not in the residual; make class 4 killed in-field but survives on full: impossible
    (tmp / "in" / "verdicts.jsonl").write_text("# 10 fin c\n" + "".join(f"{i} killed\n" for i in range(3)) + "3 survives\n4 survives\n5 survives\n6 unknown\n7 unknown\n8 unknown\n9 unknown\n")
    (tmp / "full" / "verdicts.jsonl").write_text("# 10 ffull c\n3 killed\n4 survives\n5 unknown\n6 killed\n7 survives\n8 unknown\n9 killed\n")
    (tmp / "out" / "verdicts.jsonl").write_text("# 10 fout c\n3 killed\n4 killed\n5 unknown\n6 killed\n7 survives\n8 unknown\n9 survives\n")
    try:
        census(a, log=lambda *x: None); raise AssertionError("the impossible cell was accepted")
    except SystemExit as ex:
        assert "instrument fault" in str(ex) and "out-of-field" in str(ex)
    print("[census self-test] the impossible cell (killed on a sub-pool, survives on the full pool) is REFUSED as an instrument fault")
    # a different class count is refused; an unfinished residual is refused
    (tmp / "out" / "verdicts.jsonl").write_text("# 10 fout c\n3 killed\n4 survives\n5 unknown\n6 killed\n7 survives\n8 unknown\n")
    try:
        census(a, log=lambda *x: None); raise AssertionError("an unfinished replay was accepted")
    except SystemExit as ex:
        assert "unfinished" in str(ex)
    (tmp / "out" / "verdicts.jsonl").write_text("# 11 fout c\n" + "".join(f"{i} killed\n" for i in range(3, 10)))
    try:
        census(a, log=lambda *x: None); raise AssertionError("a foreign class count was accepted")
    except SystemExit as ex:
        assert "different class lists" in str(ex)
    print("[census self-test] an unfinished residual replay and a checkpoint over another class list are REFUSED")
    # the first horn
    (tmp / "out" / "verdicts.jsonl").write_text("# 10 fout c\n3 survives\n4 survives\n5 survives\n")
    (tmp / "in" / "verdicts.jsonl").write_text("# 10 fin c\n" + "".join(f"{i} killed\n" for i in range(3)) + "3 survives\n4 survives\n5 survives\n6 killed\n7 killed\n8 killed\n9 killed\n")
    (tmp / "full" / "verdicts.jsonl").write_text("# 10 ffull c\n3 survives\n4 survives\n5 survives\n")
    res = census(a, log=lambda *x: None); assert res["horn"] == "FIRST HORN" and res["number"] == 0
    print("[census self-test] zero with no unknowns reads FIRST HORN; all green")
    import shutil; shutil.rmtree(tmp)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--residual", action="store_true"); ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--infield"); ap.add_argument("--full"); ap.add_argument("--outfield"); ap.add_argument("--out")
    ap.add_argument("--classes"); ap.add_argument("--batch"); ap.add_argument("--label")
    ap.add_argument("--manifest-in"); ap.add_argument("--manifest-full"); ap.add_argument("--manifest-out"); ap.add_argument("--result")
    a = ap.parse_args()
    if a.self_test:
        return self_test()
    if a.residual:
        return residual(a)
    census(a)


if __name__ == "__main__":
    main()
