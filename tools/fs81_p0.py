#!/usr/bin/env python3
"""FS-81 phase 0 driver: controls (P0.0) and the small-D configurations over the 40 census fields (P0.2).

Untrusted.  Every EMPTY/NONEMPTY verdict is written as a certificate under data/fs81/phase0/certs/ and handed to a checker that
imports nothing from here: the frozen `tools/fs73v2_check.py` when its exhaustive unit enumeration is affordable (≈ 4.2·D³/d
loop iterations), otherwise `tools/fs81_theta_check.py --no-enumerate` (sound for the listed units; the owner plants a fault in
it before its verdicts are believed).

Records: one JSON line per item, fsync'd, in data/fs81/phase0/<stage>.jsonl.  Resume: re-run the same command; recorded items are
skipped and the in-flight tree resumes from data/fs81/phase0/ckpt/<tag>.json(.stack).

Usage:
  fs81_p0.py controls [--cap-s 1800]
  fs81_p0.py configs  [--cap-s 1800] [--fields d1,d2,...] [--names A,B,...] [--K 1]
"""
from __future__ import annotations

import argparse
import gzip
import json
import math
import os
import shutil
import subprocess
import sys
import time
from fractions import Fraction as F
from pathlib import Path

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs81_theta as T                                          # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
P0 = ROOT / "data/fs81/phase0"
CERTS = P0 / "certs"
CKPT = P0 / "ckpt"
FROZEN = ROOT / "tools/fs73v2_check.py"
NEWCHK = ROOT / "tools/fs81_theta_check.py"
FROZEN_BUDGET = 1.5e9          # 4.2·D³/d loop iterations the frozen checker's enumeration may cost (≈ 5–8 min)

CENSUS = [11, 23, 35, 47, 59, 71, 83, 95, 107, 119, 131, 143, 155, 167, 179, 191, 203, 215, 227, 239, 251, 263, 287, 299, 311,
          323, 335, 347, 359, 371, 383, 395, 407, 419, 431, 443, 455, 467, 479, 491]
OPEN = [35, 83, 107, 131, 155, 179, 203, 215, 227, 251, 263, 287, 299, 323, 347, 371, 383, 395, 407, 419, 443, 455, 467, 479, 491]


def append(path, rec):
    with open(path, "a") as fh:
        fh.write(json.dumps(rec) + "\n")
        fh.flush()
        os.fsync(fh.fileno())


def done_tags(path):
    if not os.path.exists(path):
        return set()
    return {json.loads(l)["tag"] for l in open(path) if l.strip()}


def enumerate_units(d, M):
    """Every unit vector (a, b, c, e) of ℚ(√d)² at denominator M (points ((a+b√d)/M, (c+e√d)/M)), by a loop over (a, c):
    then b(a,c) ⊥ ... : ab + ce = 0 forces (b, e) = k(−c, a)/g, and d k² (a² + c²)/g² = M² − a² − c²."""
    out = set()
    MM = M * M
    for a in range(-M, M + 1):
        cm = math.isqrt(MM - a * a)
        for c in range(-cm, cm + 1):
            s = MM - a * a - c * c
            if s % d:
                continue
            t = s // d
            if a == 0 and c == 0:
                bm = math.isqrt(t)
                for b in range(-bm, bm + 1):
                    e2 = t - b * b
                    r = math.isqrt(e2) if e2 >= 0 else -1
                    if r >= 0 and r * r == e2:
                        out.add((0, b, 0, r))
                        out.add((0, b, 0, -r))
                continue
            if t == 0:
                out.add((a, 0, c, 0))
                continue
            g = math.gcd(a, c)
            base = (a * a + c * c) // (g * g)
            if t % base:
                continue
            k = math.isqrt(t // base)
            if k * k * base != t:
                continue
            for kk in (k, -k):
                out.add((a, kk * (-c) // g, c, kk * a // g))
    W = sorted(out)
    assert all(a * a + d * b * b + c * c + d * e * e == MM and a * b + c * e == 0 for a, b, c, e in W)
    return W


def half(U):
    return sorted({max(tuple(u), tuple(-x for x in u)) for u in U})


def units_of_key(d, key):
    """All unit vectors of a key lattice (the key's own denominator), one per ± pair."""
    D, rows = key.split("|")
    D = int(D)
    H = T.hnf([[int(x) for x in r.split(",")] for r in rows.split(";")])
    from fs73v2_units import in_lattice
    return D, half(u for u in enumerate_units(d, D) if in_lattice(H, u))


def run_check(cert_path, d, D, verdict, listed_only):
    """Run the frozen checker when affordable, else the new one without enumeration.  Returns (checker, status, line)."""
    cost = 4.2 * D ** 3 / d
    if cost <= FROZEN_BUDGET:
        cmd = [sys.executable, str(FROZEN), str(cert_path)]
        name = "fs73v2_check.py (frozen)"
    else:
        cmd = [sys.executable, str(NEWCHK), "--no-enumerate", str(cert_path)]
        name = "fs81_theta_check.py --no-enumerate"
        if not NEWCHK.exists():
            return name, "PENDING", f"frozen enumeration cost {cost:.2e} > budget; new checker not yet written"
    t0 = time.time()
    try:
        p = subprocess.run(cmd, capture_output=True, text=True, timeout=3600)
    except subprocess.TimeoutExpired:
        return name, "TIMEOUT", "checker ran past 3600 s"
    line = (p.stdout.strip().splitlines() or [""])[-1]
    status = "PASS" if p.returncode == 0 and line.startswith("PASS") else "FAIL"
    return name, status, f"{line} ({time.time() - t0:.1f} s)"


def run_item(stage, tag, d, D, units, cap_s, meta):
    out = P0 / f"{stage}.jsonl"
    if tag in done_tags(out):
        return None
    CERTS.mkdir(parents=True, exist_ok=True)
    CKPT.mkdir(parents=True, exist_ok=True)
    cert = CERTS / f"{tag}.json"
    t0 = time.time()
    try:
        res = T.decide(d, D, units, str(cert), str(CKPT / f"{tag}.json"), cap_s=cap_s, ckpt_s=60.0)
    except RuntimeError as e:
        rec = dict(meta, tag=tag, d=d, D=D, N=len(units), verdict="ERROR", error=str(e), wall_s=round(time.time() - t0, 1))
        append(out, rec)
        print(json.dumps(rec), flush=True)
        return rec
    rec = dict(meta, tag=tag, d=d, D=D, N=len(units), key=res["key"], verdict=res["verdict"], stats=res["stats"])
    if res["verdict"] == "NONEMPTY":
        rec["theta_abce_dual"] = res["theta_abce_dual"]
        rec["exact_check_listed"] = res["exact_check"]
    if res["verdict"] in ("EMPTY", "NONEMPTY"):
        name, status, line = run_check(cert, d, D, res["verdict"], True)
        rec.update(checker=name, check=status, check_line=line)
        if status == "FAIL" and res["verdict"] == "NONEMPTY" and "frozen" in name and NEWCHK.exists():
            # the frozen checker tests θ on EVERY unit of the key lattice; a configuration lists only some of them
            p = subprocess.run([sys.executable, str(NEWCHK), "--no-enumerate", str(cert)], capture_output=True, text=True,
                               timeout=3600)
            rec.update(checker2="fs81_theta_check.py --no-enumerate",
                       check2="PASS" if p.returncode == 0 else "FAIL",
                       check2_line=(p.stdout.strip().splitlines() or [""])[-1])
        gz = str(cert) + ".gz"
        with open(cert, "rb") as fi, gzip.open(gz, "wb") as fo:
            shutil.copyfileobj(fi, fo)
        os.remove(cert)
        rec["cert"] = str(Path(gz).relative_to(ROOT))
    append(out, rec)
    print(json.dumps({k: v for k, v in rec.items() if k not in ("theta_abce_dual", "key")}), flush=True)
    return rec


# ================================================================ P0.0 controls

def witness_units(d, path):
    """The edge directions of a certified FS-61 witness, as unit vectors at their common denominator."""
    w = json.load(open(path))
    pts = w["points"]
    dirs = set()
    for i, j in w["edges"]:
        a1, b1, c1, e1, m1 = pts[i]
        a2, b2, c2, e2, m2 = pts[j]
        x = (F(a2, m2) - F(a1, m1), F(b2, m2) - F(b1, m1), F(c2, m2) - F(c1, m1), F(e2, m2) - F(e1, m1))
        dirs.add(x)
    D = 1
    for x in dirs:
        for t in x:
            D = D * t.denominator // math.gcd(D, t.denominator)
    return D, half(tuple(int(t * D) for t in x) for x in dirs)


def cmd_controls(cap_s):
    items = []
    # positives: EMPTY expected
    D, U = T.units_of(167, T.configuration(167, "C:15:14:+"))
    items.append(("pos", "ctl-pos-167-T41-1vz", 167, D, U, "the 36-vector T41 obstruction {1, v, z}·U^(5), z at (15, 14)"))
    D, U = units_of_key(47, "60|5,1,5,3;0,2,0,2;0,0,10,2;0,0,0,4")
    items.append(("pos", "ctl-pos-47-cert47", 47, D, U, "Coxeter's cert_47 lattice (FS-61 shape over ℚ(√47))"))
    D, U = units_of_key(11, "30|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2")
    items.append(("pos", "ctl-pos-11-Ld65c8ee8", 11, D, U, "E's Ld65c8ee8 over ℚ(√11), d ≡ 3 (mod 8)"))
    D, U = witness_units(59, ROOT / "data/fs61/witness-59/witness.json")
    items.append(("pos", "ctl-pos-59-witness", 59, D, U, "the edge directions of the certified ℚ(√59) witness (1,739 points)"))
    # negatives: a point expected
    D, U = units_of_key(59, "30|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2")
    items.append(("neg", "ctl-neg-59-Ld65c8ee8", 59, D, U, "Ld65c8ee8 over ℚ(√59) (a slack-0 point, T43)"))
    D, U = units_of_key(167, "348|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2")
    items.append(("neg", "ctl-neg-167-Ld14c588b", 167, D, U, "Ld14c588b over ℚ(√167) (a full-dimensional cell, T27)"))
    for d in (3, 7):
        seen = set()
        for M in range(1, 61):
            U = half(enumerate_units(d, M))
            pts = frozenset(tuple(F(t, M) for t in u) for u in U)
            if not U or pts in seen:
                continue
            try:
                T.key_of(U, M)
            except AssertionError:
                continue                                  # rank < 4
            seen.add(pts)
            items.append(("neg", f"ctl-neg-{d}-L{M}", d, M, U, f"Λ_{M} over ℚ(√{d}) (plane 3-colourable)"))
    for kind, tag, d, D, U, what in items:
        run_item("controls", tag, d, D, U, cap_s, {"kind": kind, "expect": "EMPTY" if kind == "pos" else "NONEMPTY",
                                                   "what": what})


# ================================================================ P0.2 configurations

def cmd_configs(cap_s, fields, names, K, stage):
    for d in fields:
        for name in (names or T.config_names(d)):
            try:
                layers = T.configuration(d, name, K)
            except (AssertionError, ValueError, IndexError):
                continue
            D, U = T.units_of(d, layers, K)
            tag = f"d{d}-{name.replace(':', '_').replace('+', 'p').replace('-', 'm')}-K{K}"
            run_item(stage, tag, d, D, U, cap_s, {"config": name, "K": K, "open": d in OPEN})


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="cmd", required=True)
    c = sub.add_parser("controls")
    c.add_argument("--cap-s", type=float, default=1800.0)
    g = sub.add_parser("configs")
    g.add_argument("--cap-s", type=float, default=1800.0)
    g.add_argument("--fields", default=None)
    g.add_argument("--names", default=None)
    g.add_argument("--K", type=int, default=1)
    g.add_argument("--stage", default="configs")
    a = ap.parse_args()
    if a.cmd == "controls":
        cmd_controls(a.cap_s)
    else:
        fields = [int(x) for x in a.fields.split(",")] if a.fields else CENSUS
        names = a.names.split(",") if a.names else None
        cmd_configs(a.cap_s, fields, names, a.K, a.stage)


if __name__ == "__main__":
    main()
