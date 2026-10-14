#!/usr/bin/env python3
"""FS131-IKC1 -- no conclusion weakened: the soundness theorems' stored statements, and every definition they name,
are the same before and after this job, read from the kernel's side.

`before` and `after` are outputs of data/fs131/ikc1/lean/StatementDump.lean (every constant stored in the compiled
data of Arith/FibreCert, Arith/FibreCert3 and Arith/FibreCertSound: kind, full name, stored type, a definition's
stored value), `before` made on the planner's build before any edit (stage 1), `after` on this job's build.

PROTECTED (exit 1 if any differs): the stored types of `sum_le_of_certOK` and `card_le_of_certOK`; the stored types
and values of `V`, `unitCircle`, `qform`; the stored types and values of the projections `Cert.p`, `Cert.scale`,
`Cert.unum` that the conclusions read. Instance binder names minted in the file (`inst._@.<module>.<n>._hygCtx._hyg.<k>`)
carry a hash of the declaration's position, so they are compared with the `<n>` blanked (the raw comparison is
reported too). Everything else is reported, not judged: the checker was rewritten by design (record § 2.1).

Usage:  fs131_ikc1_statements.py <before.txt> <after.txt> [--control]
--control plants one character into the after-dump's stored type of `sum_le_of_certOK` and must exit 1.
"""
import re, sys, pathlib

PROT_TYPE = ["HadwigerNelson.FibreCertSound.sum_le_of_certOK", "HadwigerNelson.FibreCertSound.card_le_of_certOK"]
PROT_DEF = ["HadwigerNelson.FibreCertSound.V", "HadwigerNelson.FibreCertSound.unitCircle",
            "HadwigerNelson.FibreCertSound.qform", "HadwigerNelson.FibreCert.Cert.p",
            "HadwigerNelson.FibreCert.Cert.scale", "HadwigerNelson.FibreCert.Cert.unum"]
HYG = re.compile(r"(_@\.Proofs\.HadwigerNelson\.Arith\.FibreCert\w*)\.\d+(\._hygCtx\._hyg\.\d+)")


def read_dump(path):
    out, cur = {}, None
    for ln in pathlib.Path(path).read_text().splitlines():
        if ln.startswith("@@ "):
            parts = ln.split(" ")
            internal = parts[-1] == "INTERNAL"
            name = " ".join(parts[2:-1] if internal else parts[2:])
            cur = {"kind": parts[1], "internal": internal, "type": None, "value": None}
            if name in out:
                print(f"DUPLICATE NAME IN DUMP {path}: {name}"); sys.exit(2)
            out[name] = cur
        elif ln.startswith("TYPE ") and cur is not None:
            cur["type"] = ln[5:].split(" ", 1)[1]
        elif ln.startswith("VALUE ") and cur is not None:
            cur["value"] = ln[6:].split(" ", 1)[1]
    if not out:
        print(f"EMPTY DUMP: {path}"); sys.exit(2)
    return out


def norm(t):
    return None if t is None else HYG.sub(r"\1.N\2", t)


def main():
    control = "--control" in sys.argv
    a = [x for x in sys.argv[1:] if not x.startswith("--")]
    before, after = read_dump(a[0]), read_dump(a[1])
    if control:
        n = PROT_TYPE[0]
        after[n]["type"] = after[n]["type"].replace("LE.le", "LT.lt", 1)
        print("CONTROL: planted LE.le -> LT.lt in the after-dump's type of", n)
    bad = []
    for n in PROT_TYPE + PROT_DEF:
        if n not in before or n not in after:
            bad.append(f"MISSING {n}"); continue
        b, f = before[n], after[n]
        raw = b["type"] == f["type"]
        ok = b["kind"] == f["kind"] and norm(b["type"]) == norm(f["type"])
        if n in PROT_DEF:
            ok = ok and norm(b["value"]) == norm(f["value"])
            raw = raw and b["value"] == f["value"]
        print(f"{'SAME' if ok else 'DIFFERS'} {n} (raw text {'identical' if raw else 'differs only in hygienic binder names' if ok else 'differs'})")
        if not ok:
            bad.append(n)
    pub_b = {k for k, v in before.items() if not v["internal"]}
    pub_a = {k for k, v in after.items() if not v["internal"]}
    chg = sorted(k for k in pub_b & pub_a if norm(before[k]["type"]) != norm(after[k]["type"]) or
                 norm(before[k]["value"]) != norm(after[k]["value"]))
    print(f"constants: before {len(before)}, after {len(after)}; public removed {len(pub_b - pub_a)}, added "
          f"{len(pub_a - pub_b)}, changed {len(chg)} (the checker, by design)")
    for k in chg:
        print("  CHANGED", k)
    for k in sorted(pub_b - pub_a):
        print("  REMOVED", k)
    if bad:
        print("FAIL:", bad); sys.exit(1)
    print("PASS: the protected statements and definitions are unchanged")


if __name__ == "__main__":
    main()
