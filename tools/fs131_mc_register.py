#!/usr/bin/env python3
"""FS131-MC1 — the audit records the example maps still lack: every `theorem` of `Plane/Models/*.lean`, by its full name (the
namespaces read from the file), that `scripts/Axioms.lean` does not print.

  fs131_mc_register.py            list the missing names (and records of the block that name no theorem of the files: STALE)
  fs131_mc_register.py --write    append one block "FS131-MC1" of `#print axioms` lines above the PURCHASED banner
The gate's own check of the result is `tools/fs131_l5_records.py`, which reads the kernel's list and not the source.
"""
import os, re, sys

D = "Proofs/HadwigerNelson/Plane/Models"
AX = "scripts/Axioms.lean"
BANNER = '#eval IO.println "=== PURCHASED ==="'


def theorems():
    out = []
    for f in sorted(os.listdir(D)):
        if not f.endswith(".lean"):
            continue
        stack = []
        for ln in open(os.path.join(D, f)):
            m = re.match(r"namespace (\S+)", ln)
            if m:
                stack.append(m.group(1)); continue
            m = re.match(r"end (\S+)", ln)
            if m and stack and stack[-1] == m.group(1):
                stack.pop(); continue
            m = re.match(r"(?:@\[[^\]]*\]\s*)?(?:theorem|lemma) ([^\s:({\[]+)", ln)
            if m:
                out.append((".".join(stack + [m.group(1)]), f))
    return out


if __name__ == "__main__":
    src = open(AX).read()
    have = set(re.findall(r"^#print axioms (\S+)", src, re.M))
    th = theorems()
    missing = [(n, f) for n, f in th if n not in have]
    names = {n for n, _ in th}
    stale = sorted(n for n in have if ".Plane." in n and re.search(r"\.(hornModel|twoHornModel|stuckModel|shadowModel|awayModel|brickBase|cuspFrag_bend|cuspArc|stuckArcs|stuckCol|shadowArcs|shadowCol|awayArcs)", n) and n not in names
                   and not n.startswith("HadwigerNelson.Plane.ArcMap.cuspFrag"))
    print(f"theorems of {D}: {len(th)}; with a record: {len(th) - len(missing)}; missing: {len(missing)}; stale candidates: {stale}")
    if "--write" in sys.argv and missing:
        assert src.count(BANNER) == 1
        byf = {}
        for n, f in missing:
            byf.setdefault(f, []).append(n)
        blk = ["/-! ## FS-131, the example maps (job FS131-MC1) — the landing: the lane's theorems the four jobs' blocks did not list, and",
               "`Plane/Models/Applied` (the landed theorems applied to the models). Found by reading the files; checked against the kernel's own",
               "list by `tools/fs131_l5_records.py`. -/"]
        for f in sorted(byf):
            blk.append(f"-- {D[len('Proofs/HadwigerNelson/'):]}/{f[:-5]}")
            blk += [f"#print axioms {n}" for n in byf[f]]
        src = src.replace(BANNER, "\n".join(blk) + "\n\n" + BANNER)
        open(AX, "w").write(src)
        print(f"wrote {len(missing)} records")
    else:
        for n, f in missing[:8]:
            print("  missing", f, n)
