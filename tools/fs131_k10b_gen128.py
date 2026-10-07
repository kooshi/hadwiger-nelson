#!/usr/bin/env python3
"""FS131-K10b: write the certificate literals of Proofs/HadwigerNelson/Arith/Floor128.lean from
data/fs131/k10b/u128-certificate.json (the output of tools/fs131_k10b_u128.py --json).

Usage: fs131_k10b_gen128.py            print the Lean block between the BEGIN/END markers
       fs131_k10b_gen128.py --check    compare it with the block in the module; exit 1 on any difference
       fs131_k10b_gen128.py --fault    flip one bit of QBIG before comparing (the planted fault: --check must then fail)
"""
import json, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
CERT = ROOT / "data/fs131/k10b/u128-certificate.json"
MOD = ROOT / "Proofs/HadwigerNelson/Arith/Floor128.lean"
BEGIN, END = "-- BEGIN CERTIFICATE (generated: tools/fs131_k10b_gen128.py)", "-- END CERTIFICATE"


def block(fault=False):
    c = {k: int(v, 16) for k, v in json.loads(CERT.read_text()).items()}
    if fault:
        c["QBIG"] ^= 1 << 100
    lines = [BEGIN,
             "/-- The modulus `x¹⁴ + x⁵ + x³ + x + 1`, a primitive polynomial over `𝔽₂` (bits 14, 5, 3, 1, 0). -/",
             f"def P : Nat := {c['P']}",
             "/-- The quotient `(x^(2¹⁴) + x) / P` in `𝔽₂[x]`. -/",
             f"def qBig : Nat := 0x{c['QBIG']:x}",
             "/-- Bézout cofactor of `P` against `x⁴ + x`. -/",
             f"def a4 : Nat := 0x{c['A4']:x}",
             "/-- Bézout cofactor of `x⁴ + x` against `P`. -/",
             f"def b4 : Nat := 0x{c['B4']:x}",
             "/-- Bézout cofactor of `P` against `x¹²⁸ + x`. -/",
             f"def a128 : Nat := 0x{c['A128']:x}",
             "/-- Bézout cofactor of `x¹²⁸ + x` against `P`. -/",
             f"def b128 : Nat := 0x{c['B128']:x}",
             END]
    return "\n".join(lines)


def main():
    b = block("--fault" in sys.argv)
    if "--check" in sys.argv or "--fault" in sys.argv:
        t = MOD.read_text()
        cur = t[t.index(BEGIN): t.index(END) + len(END)]
        ok = cur == b
        print("certificate block matches the JSON" if ok else "MISMATCH between the module's certificate block and the JSON")
        sys.exit(0 if ok else 1)
    print(b)


if __name__ == "__main__":
    main()
