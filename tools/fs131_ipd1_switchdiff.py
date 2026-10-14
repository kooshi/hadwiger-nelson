#!/usr/bin/env python3
"""FS131-IPD1, the switch's step 4 (plans/FS131-KO1-port-plan.md § 4.4): every named constant of the step-0 dump
(`data/fs131/ipd1/lean/SwitchDump.lean`, made before any edit) against the step-4 dump (the same dumper after the
build), by NAME, whatever module holds it now — the five moved declarations are in `Outside/OAI158Collapse` after the
switch, the transfer in `Outside/OAI158BorelTransfer`.

Verdicts per constant of the step-0 dump: IDENTICAL (kind, universe parameters, full type print and, for a definition,
full value print agree); INSTANCES-ONLY (the full prints differ, the prints with instance and proof arguments erased
agree); DIFFERENT; MISSING (not in the step-4 dump).  The one constant whose KIND is allowed to change is the transfer,
`HadwigerNelson.Outside.OAI158.proper_to_borel_weak`: `axiom` at step 0, `theorem` at step 4, its type compared alone
(TYPE-IDENTICAL or TYPE-INSTANCES-ONLY).  Also reported: every constant that changed module, and every constant of the
step-4 dump's modules absent from step 0 (new, listed by module, not judged).

Exit 0 iff every step-0 constant is IDENTICAL, the five moved are among them and now in `OAI158Collapse`, the transfer
is a theorem of `OAI158BorelTransfer` with its type TYPE-IDENTICAL, and nothing else changed module.

Usage: fs131_ipd1_switchdiff.py STEP0 STEP4      (.xz read transparently)
       fs131_ipd1_switchdiff.py --control STEP0   plants in a copy of STEP0 used as step 4: a type changed in instance
                                                  arguments only, a type changed outright, a constant removed, the
                                                  transfer left an axiom; each must be reported as planted
"""
import lzma
import re
import sys

T = "HadwigerNelson.Outside.OAI158.proper_to_borel_weak"
MOVED = ["nonempty_aeColouring_of_colorable", "colorable_iff_nonempty_aeColouring", "chiM0_le_chromaticNumber_plane",
         "chromaticNumber_plane_eq_chiM0", "seven_le_chromaticNumber_plane_iff"]
MOVED = ["HadwigerNelson.Outside.OAI158." + m for m in MOVED]
COLLAPSE = "Proofs.HadwigerNelson.Outside.OAI158Collapse"
PORT = "Proofs.HadwigerNelson.Outside.OAI158BorelTransfer"


def read(path):
    op = lzma.open if path.endswith(".xz") else open
    out, mod, cur, done = {}, None, None, False
    with op(path, "rt") as f:
        for ln in f:
            ln = ln.rstrip("\n")
            m = re.match(r"^## MODULE (\S+) ", ln)
            if m:
                mod = m.group(1)
                continue
            m = re.match(r"^DUMP (\S+) : (.*)$", ln)
            if m and not ln.startswith("DUMP   "):
                cur = m.group(1)
                if cur in out:
                    raise SystemExit(f"{path}: {cur} twice")
                out[cur] = {"mod": mod, "kind": m.group(2)}
                continue
            m = re.match(r"^DUMP   (type|etype|value|evalue)\s*= (.*)$", ln)
            if m and cur:
                out[cur][m.group(1)] = m.group(2)
            if re.match(r"^DONE \d+$", ln):
                done = True
    if not done or not out:
        raise SystemExit(f"{path}: the dump did not finish")
    if any("type" not in v for v in out.values()):
        raise SystemExit(f"{path}: a constant with no type read")
    return out


def judge(a, b):
    res, moved_mod = {}, []
    for n, x in a.items():
        y = b.get(n)
        if y is None:
            res[n] = "MISSING"
            continue
        if x["mod"] != y["mod"]:
            moved_mod.append((n, x["mod"], y["mod"]))
        if n == T:
            kinds = (x["kind"].split()[0], y["kind"].split()[0])
            lv = x["kind"].split()[1:] == y["kind"].split()[1:]
            if kinds != ("axiom", "theorem") or not lv:
                res[n] = f"KIND {kinds[0]} -> {kinds[1]}" + ("" if lv else " (levels differ)")
            elif x["type"] == y["type"]:
                res[n] = "TYPE-IDENTICAL"
            elif x["etype"] == y["etype"]:
                res[n] = "TYPE-INSTANCES-ONLY"
            else:
                res[n] = "TYPE-DIFFERENT"
            continue
        full = all(x.get(k) == y.get(k) for k in ("kind", "type", "value"))
        er = x["kind"] == y["kind"] and all(x.get(k) == y.get(k) for k in ("etype", "evalue"))
        res[n] = "IDENTICAL" if full else ("INSTANCES-ONLY" if er else "DIFFERENT")
    new = sorted((v["mod"], n) for n, v in b.items() if n not in a)
    return res, moved_mod, new


def verdict(a, b, quiet=False):
    res, moved_mod, new = judge(a, b)
    bad = []
    for n, v in sorted(res.items()):
        if v not in ("IDENTICAL", "TYPE-IDENTICAL"):
            bad.append(f"{v}\t{n}")
    want_moves = {(n, "Proofs.HadwigerNelson.Outside.OAI158", COLLAPSE) for n in MOVED} | \
        {(T, "Proofs.HadwigerNelson.Outside.OAI158", PORT)}
    got_moves = set(moved_mod)
    for mv in sorted(got_moves - want_moves):
        bad.append(f"MOVED-UNEXPECTEDLY\t{mv[0]}\t{mv[1]} -> {mv[2]}")
    for mv in sorted(want_moves - got_moves):
        bad.append(f"NOT-MOVED\t{mv[0]}\t(expected in {mv[2]})")
    if not quiet:
        cnt = {}
        for v in res.values():
            cnt[v] = cnt.get(v, 0) + 1
        print(f"step 0: {len(a)} constants; step 4: {len(b)} constants")
        print("verdicts: " + ", ".join(f"{k} {v}" for k, v in sorted(cnt.items())))
        for n, m0, m4 in sorted(moved_mod):
            print(f"module changed: {n}: {m0} -> {m4}")
        by = {}
        for m, n in new:
            by.setdefault(m, []).append(n)
        for m, ns in sorted(by.items()):
            print(f"new at step 4: {m}: {len(ns)} constants")
        for x in bad:
            print("REPORTED\t" + x)
        print(f"SWITCHDIFF {'OK' if not bad else 'FAILED'}: transfer {res.get(T)}")
    return bad, res


def main():
    if sys.argv[1] == "--control":
        a = read(sys.argv[2])
        import copy
        ok = True
        b0 = copy.deepcopy(a)
        for n in MOVED:
            b0[n]["mod"] = COLLAPSE
        b0[T]["mod"] = PORT
        b0[T]["kind"] = b0[T]["kind"].replace("axiom", "theorem", 1)
        bad, _ = verdict(a, b0, quiet=True)
        print(f"partner (the expected moves only): {'PASS' if not bad else 'FAILED ' + str(bad)}")
        ok = ok and not bad
        names = [n for n in sorted(a) if n != T and n not in MOVED and "(c " in a[n]["type"]]
        n1, n2, n3 = names[0], names[len(names) // 2], names[-1]
        b = copy.deepcopy(b0)
        b[n1]["type"] = b[n1]["type"] + " "                       # full print differs, erased print agrees
        b[n2]["type"] = b[n2]["type"] + " "
        b[n2]["etype"] = b[n2]["etype"] + " "                     # both differ
        del b[n3]
        b[T]["type"] = b[T]["type"] + " "
        b[T]["etype"] = b[T]["etype"] + " "
        _, res = verdict(a, b, quiet=True)
        exp = {n1: "INSTANCES-ONLY", n2: "DIFFERENT", n3: "MISSING", T: "TYPE-DIFFERENT"}
        for n, v in exp.items():
            print(f"plant {v} at {n}: {'REPORTED' if res.get(n) == v else 'SILENT (' + str(res.get(n)) + ')'}")
            ok = ok and res.get(n) == v
        b2 = copy.deepcopy(b0)
        b2[T]["kind"] = a[T]["kind"]
        _, res2 = verdict(a, b2, quiet=True)
        print(f"plant 'the transfer left an axiom': {'REPORTED' if res2[T].startswith('KIND') else 'SILENT'}")
        ok = ok and res2[T].startswith("KIND")
        b3 = copy.deepcopy(b0)
        b3[n1]["mod"] = COLLAPSE
        bad3, _ = verdict(a, b3, quiet=True)
        print(f"plant 'another constant moved module': {'REPORTED' if any('MOVED-UNEXPECTEDLY' in x for x in bad3) else 'SILENT'}")
        ok = ok and any("MOVED-UNEXPECTEDLY" in x for x in bad3)
        print("CONTROL OK" if ok else "CONTROL FAILED")
        return 0 if ok else 1
    bad, _ = verdict(read(sys.argv[1]), read(sys.argv[2]))
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
