#!/usr/bin/env python3
"""J30 stage 1: copy rescued scratch files. b-repo -> data/rescued-2026-09-25/, b-disk and render -> ~/source/lean-dir-rescue/,
papers -> ~/source/library. Agent-id-shaped tokens are redacted in every text copy. Writes rescue.log."""
import os, re, shutil
S = "/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad"
R = "/home/kooshi/source/lean-dir"; REPO_DST = os.path.join(R, "data", "rescued-2026-09-25")
DISK_DST = os.path.expanduser("~/source/lean-dir-rescue"); LIB = os.path.expanduser("~/source/library")
AID = re.compile(rb"(?<![0-9a-fA-F])a[0-9a-f]{16}(?![0-9a-fA-F])")
PAPERS = {"degrey2018.pdf": "pdf/deGrey2018-chromatic-number-plane-at-least-5.pdf",
          "ns.pdf": "pdf/GoelPatilVerma2022-nullstellensatze-and-applications.pdf",
          "fs85-audit/cite/1808.09534.pdf": "pdf/Hujdurovic2020-strong-cliques-vertex-transitive-graphs.pdf",
          "fs85-audit/cite/1809.00527.pdf": "pdf/ErskineGriggsSiran2022-clique-partitioned-graphs.pdf",
          "fs85-audit/cite/1910.14454.pdf": "pdf/JanssenMacKeigan2020-orthogonal-colourings-cayley-graphs.pdf",
          "fs85-audit/af2021.html": "notes/polymath16-algebraic-formulation-2021-snapshot.html",
          "fs85-audit/af2022.html": "notes/polymath16-algebraic-formulation-2022-snapshot.html"}
def copy(src, dst):
    os.makedirs(os.path.dirname(dst), exist_ok=True)
    if os.path.exists(dst): return "exists"
    size = os.path.getsize(src)
    if size < 400 * 2**20:
        data = open(src, "rb").read()
        new, n = AID.subn(b"<agent-id redacted>", data)
        if n:
            open(dst, "wb").write(new); shutil.copystat(src, dst); return f"copied, {n} agent-id tokens redacted"
    shutil.copy2(src, dst); return "copied"
log = []
for row in open(os.path.join(S, "j30", "final.tsv")):
    f, size, c, d = row.rstrip("\n").split("\t")
    src = os.path.join(S, f)
    if f in PAPERS: dst = os.path.join(LIB, PAPERS[f])
    elif c == "b-repo" and not f.startswith("fs85-audit/cite/"): dst = os.path.join(REPO_DST, f)
    elif c in ("b-disk", "render") or f.startswith("fs85-audit/cite/"): dst = os.path.join(DISK_DST, f)
    else: continue
    log.append(f"{f}\t{dst}\t{copy(src, dst)}")
open(os.path.join(S, "j30", "rescue.log"), "w").write("\n".join(log) + "\n")
import collections; print(collections.Counter(l.split("\t")[2].split(",")[0] for l in log), sum("redacted" in l for l in log))
