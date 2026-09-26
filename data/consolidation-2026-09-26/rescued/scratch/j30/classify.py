#!/usr/bin/env python3
"""J30 stage 1: classify every swept scratch file into (a) in repo, (b) rescue, (c) paper, (d) junk, owner, in-flight."""
import os, re, collections
S = "/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad"
J = os.path.join(S, "j30")
ov = {}
for row in open(os.path.join(J, "overlap.tsv")):
    f, size, cls, frac, best, n = (row.rstrip("\n").split("\t") + [""] * 6)[:6]
    ov[f] = (frac, best)
OWNER_OLD = ("fs73-owner", "fs79-owner", "fs81-owner")
INFLIGHT = {"delta.py": "J18", "delta2.py": "J18", "price.py": "J18", "swaptail.py": "J18"}
JUNK_EXT = {"pyc", "pid", "pgid", "pids", "leader", "time", "check_cache", "sample", "pack", "idx", "rev"}
PAPER_TXT_LOOSE = {"f90.txt", "fischer.txt", "fischer1990.txt", "madore.txt", "moor.txt", "parts.txt", "tardif.txt", "zhang.txt",
                   "zhu.txt", "zhu2025.txt", "km.txt", "degrey2018.txt", "ns.txt"}
PAPER_TXT_DIR = {"algebra-poros/soifer.txt", "fs85-audit/basic.txt", "fs85-audit/ks.txt", "fs85-audit/nes1973.txt", "fs85-audit/parts.txt",
                 "fs89-pa-berend/b83.txt", "fs89-pa-berend/berend.txt", "fs89-pa-furst/berend-etds.txt", "fs89-pa-furst/furst.txt",
                 "pa-products/lt.txt", "pa-products/zh.txt", "pa-tardif/t.txt", "pa-tardif/zhu.txt"}
FAKE_PDF = {"coste.pdf", "ees.pdf", "fs89-plan/t.pdf"}
RENDER_DIRS = ("fs89-pa-berend", "fs89-pa-furst", "pa-products", "pa-tardif", "fs85-audit", "fs85-verifier")
rows = []
for row in open(os.path.join(J, "sweep.tsv")):
    f, size, cls, where = row.rstrip("\n").split("\t")
    size = int(size); top = f.split("/")[0] if "/" in f else "(loose)"
    ext = f.rsplit(".", 1)[-1] if "." in os.path.basename(f) else "-"
    if top in OWNER_OLD: c, d = "owner", "older owner-naming directory: not swept"
    elif f in INFLIGHT: c, d = "inflight", INFLIGHT[f]
    elif cls.startswith("A-"): c, d = "a", f"{cls}: {where}"
    elif cls == "C-library": c, d = "c-present", where
    elif f.startswith(("fs73-verifier/glucose/", "fs73-verifier/drat-trim/")):
        c, d = "d", "vendored solver source or build (glucose, drat-trim)"
    elif "__pycache__" in f or ext in JUNK_EXT or "/git/" in f or f.startswith("fs73-verifier/") and re.search(r"\.(c|cc|h|mk)$|/[^./]+$", f) and "/" in f[14:]:
        c, d = "d", "junk by type (bytecode, pid file, git internals, vendored source)"
    elif f in FAKE_PDF: c, d = "d", "an HTML error page saved as .pdf"
    elif f.startswith("libtxt/") or f in PAPER_TXT_LOOSE or f in PAPER_TXT_DIR: c, d = "c-text", "text extraction of a paper"
    elif ext == "pdf": c, d = "c-pdf", "paper PDF not byte-identical to a library file"
    elif ext == "png" and top in RENDER_DIRS: c, d = "render", "page/figure render"
    else:
        frac, best = ov.get(f, ("", ""))
        if re.fullmatch(r"\d+/\d+", frac):
            h, n = map(int, frac.split("/"))
            if n and h / n >= 0.8: c, d = "a", f"successor ({h}/{n} lines) in {best}"; rows.append((f, size, c, d)); continue
        c = "b-repo" if size <= 5 * 2**20 and ext not in {"cnf", "gz", "npz", "npy", "pkl", "bz2", "png"} else "b-disk"
        d = f"overlap {frac} best {best}".strip()
    rows.append((f, size, c, d))
with open(os.path.join(J, "final.tsv"), "w") as fh:
    for r in rows: fh.write("\t".join(map(str, r)) + "\n")
agg = collections.defaultdict(lambda: [0, 0])
for f, size, c, d in rows: agg[c][0] += 1; agg[c][1] += size
for c, (n, s) in sorted(agg.items()): print(f"{c:10s} {n:5d} {s/2**20:9.1f} MB")
