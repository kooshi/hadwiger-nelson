#!/usr/bin/env python3
"""C1 stage 1: turn sweep.tsv into a final class per file and copy what must be rescued.

Final classes (one per file):
  in-repo      identical blob at HEAD / in history / in the working tree, or a successor (>= 80 % of its lines in one tracked file);
  on-disk      identical bytes already in ~/source/library or ~/source/lean-dir-rescue (J30's rescues included);
  J30:<cls>    J30 classified it and it has not changed since (junk, paper texts);
  inflight     written at or after 2026-09-26 08:00: the consolidation jobs running beside C1, or the owner; left alone;
  junk         HTML error or landing pages saved as .pdf, bytecode, empty harness outputs;
  paper-text   a text extraction of a paper whose PDF ~/source/library holds (regenerable: pdftotext <that PDF>);
  paper-disk   paper material the library does not hold (a source bundle, supplementary notebooks, an unheld paper's text, landing
               pages): copied to ~/source/lean-dir-rescue/consolidation-2026-09-26/papers/;
  regen        regenerable from git by a stated command; copied to disk anyway;
  owner-tasks  the owner session's background-shell outputs (tasks/): the owner's, may hold identifiers; copied to disk, never the repo;
  rescued      work product not in the repository: copied to data/consolidation-2026-09-26/rescued/<scratch|tmp>/<path>, agent-id-shaped
               tokens redacted.
Writes manifest.tsv beside itself and prints the counts.
"""
import collections, os, re, shutil, sys, time

HERE = os.path.dirname(os.path.abspath(__file__))
R = "/home/kooshi/source/lean-dir"
T = "/tmp/claude-1000"
SESSION = os.path.join(T, "-home-kooshi-source-lean-dir", "229be71b-1af0-4601-bef0-f695943ce757")
REPO_DST = os.path.join(R, "data", "consolidation-2026-09-26", "rescued")
DISK_DST = os.path.expanduser("~/source/lean-dir-rescue/consolidation-2026-09-26")
AID = re.compile(rb"(?<![0-9a-fA-F])a[0-9a-f]{16}(?![0-9a-fA-F])")
INFLIGHT_FROM = "09-26 08:00"
LIB = os.path.expanduser("~/source/library/pdf/")
PAPER_TEXT_HELD = {  # scratch path -> the library PDF it was extracted from
    "adfs.txt": "AlonDinurFriedgutSudakov2004-graph-products-fourier-spectral.pdf",
    "amb.txt": "arXiv-2207.14179-ambrus-csiszarik-matolcsi-varga-zsamboki-density-planar-sets.pdf",
    "ambrus.txt": "arXiv-2207.14179-ambrus-csiszarik-matolcsi-varga-zsamboki-density-planar-sets.pdf",
    "bdo.txt": "arXiv-1301.1054-bachoc-decorte-oliveira-vallentin-spectral-bounds-operator.pdf",
    "bm.txt": "BergelsonMoragues2021-ergodic-correspondence-invariant-means.pdf",
    "bs.txt": "BarajasSerra2008-lonely-runner-seven-runners.pdf",
    "cd.txt": "ChenDai2017-minimal-center-attraction-amenable.pdf",
    "ees85.txt": "EggletonErdosSkilton1985-colouring-the-real-line.pdf",
    "kl.txt": "KravitzLeng2025-quantitative-pyjama.pdf",
    "lm.txt": "LevitzMott1972-rings-finite-norm-property.pdf",
    "manners.txt": "Manners2015-solution-pyjama-problem.pdf",
    "mrvz.txt": "arXiv-2311.10069.pdf",
    "t08.txt": "tardif-2008-hedetniemi-conjecture-40-years-later-GTN54.pdf",
    "tardif-2008-hedetniemi-conjecture-40-years-later-GTN54.txt": "tardif-2008-hedetniemi-conjecture-40-years-later-GTN54.pdf",
    "tw.txt": "TardifWrochna2019-hedetniemi-strongly-multiplicative.pdf",
    "wang.txt": "Wang2012-rigidity-commutative-non-hyperbolic-toral.pdf",
    "z25.txt": "arXiv-2502.16078-zhu-survey-hedetniemi.pdf",
    "zhu.txt": "arXiv-2502.16078-zhu-survey-hedetniemi.pdf",
    "Tardif2023-product-5-chromatic-graphs-can-be-4.txt": "Tardif2023-product-5-chromatic-graphs-can-be-4.pdf",
    "GreenwellLovasz1974-applications-of-product-colouring.txt": "GreenwellLovasz1974-applications-of-product-colouring.pdf",
    "j23cpa/bd.txt": "BrakensiekDavies2024-robust-factorizations-colorings-tensor-graphs.pdf",
    "j23cpa/h21.txt": "arXiv-2102.05529-haemers-ratio-bound.pdf",
    "j23cpa/km.txt": "KechrisMarks-descriptive-graph-combinatorics-2020.pdf",
    "j23cpa/pv.txt": "PakVilenchik2013-constructing-uniquely-realizable-graphs.pdf",
    "j23cpa/t08.txt": "tardif-2008-hedetniemi-conjecture-40-years-later-GTN54.pdf",
    "j23cpa/zs.txt": "arXiv-2502.16078-zhu-survey-hedetniemi.pdf",
    "j27d/Tardif2023-product-5-chromatic.txt": "Tardif2023-product-5-chromatic-graphs-can-be-4.pdf",
    "j27d/tardif-2008-hedetniemi-conject.txt": "tardif-2008-hedetniemi-conjecture-40-years-later-GTN54.pdf",
    "j27d/tw.txt": "TardifWrochna2019-hedetniemi-strongly-multiplicative.pdf",
    "txt/GreenwellLovasz1974-applicatio.txt": "GreenwellLovasz1974-applications-of-product-colouring.pdf",
    "txt/LaroseTardif2002-projectivity-.txt": "LaroseTardif2002-projectivity-independent-sets-powers-of-graphs.pdf",
    "txt/PakVilenchik2013-constructing-.txt": "PakVilenchik2013-constructing-uniquely-realizable-graphs.pdf",
    "txt/Tardif2023-product-5-chromatic.txt": "Tardif2023-product-5-chromatic-graphs-can-be-4.pdf",
    "txt/TardifWrochna2019-hedetniemi-s.txt": "TardifWrochna2019-hedetniemi-strongly-multiplicative.pdf",
    "txt/arXiv-1601.04551-wrochna-squar.txt": "arXiv-1601.04551-wrochna-square-free-graphs-are-multiplicative.pdf",
    "txt/arXiv-2502.16078-zhu-survey-he.txt": "arXiv-2502.16078-zhu-survey-hedetniemi.pdf",
    "txt/csernak.txt": "Csernak2023-trivial-coloring-products.pdf",
    "txt/grrsv19.txt": "arXiv-1610.10002-godsil-et-al-graph-homomorphisms-vector-colorings.pdf",
    "txt/tardif-2008-hedetniemi-conject.txt": "tardif-2008-hedetniemi-conjecture-40-years-later-GTN54.pdf",
    "tmp:zhu2021.txt": "arXiv-2004.09028-zhu-relatively-small-counterexamples-hedetniemi.pdf",
}
PAPER_DISK = {  # scratch path -> why it is paper material the library does not hold
    "lin04.txt": "text of Lindenstrauss, Rigidity of multiparameter actions (arXiv math/0402165); no PDF in ~/source/library",
    "esm.txt": "Mathematica verification notebook (text) of [AmbrusEtAl2023]'s electronic supplementary material",
    "ver.txt": "the same notebook as esm.txt (byte-identical)",
    "src-v1": "arXiv source of 2207.14179 ([AmbrusEtAl2023]), v1, gzipped tar",
    "src-v2": "arXiv source of 2207.14179, v2, gzipped tar",
    "src-v3": "arXiv source of 2207.14179, v3, gzipped tar",
    "src-v1.tar": "arXiv source of 2207.14179, v1, tar",
    "src-v2.tar": "arXiv source of 2207.14179, v2, tar",
    "src-v3.tar": "arXiv source of 2207.14179, v3, tar",
    "lm.html": "Cambridge Core landing page of [LevitzMott1972]",
    "springer.html": "Springer landing page of [AmbrusEtAl2023] (Math. Programming)",
    "eu.html": "EuDML landing page, 'On four-colourings of the rational four-space'",
    "dmgt.html": "a journal landing page (DMGT), untitled",
}
JUNK = {
    "pdf/10.1007_BF02579374.pdf": "an HTML landing page saved as .pdf",
    "pdf/10.1007_s00373-022-02576-x.pdf": "an HTML landing page saved as .pdf",
    "pdf/10.1007_s004930070006.pdf": "an HTML landing page saved as .pdf",
    "st.pdf": "an HTML landing page saved as .pdf",
    "adfs.pdf": "an HTTP 404 page saved as .pdf",
    "__pycache__/items.cpython-314.pyc": "bytecode",
}
REGEN = {
    "old-corpus.md": "J55's joined old corpus: git show fd285b33:CLAUDE.md fd285b33:LEDGER.md (its record §1.3)",
    "g4950.txt": "an excerpt of CLAUDE.md's G49-G50 lines (grep -n on CLAUDE.md at its commit)",
}


def dest(tag, rel, base):
    return os.path.join(base, tag, rel)


def copy(src, dst, redact):
    os.makedirs(os.path.dirname(dst), exist_ok=True)
    if os.path.exists(dst):
        if os.path.exists(src) and open(src, "rb").read() == open(dst, "rb").read():
            return "copied (identical to the source)"
        return "EXISTS AND DIFFERS" if os.path.exists(src) else "copied earlier; source gone since"
    if not os.path.exists(src):
        return "gone before the copy (a transient harness file)"
    if redact:
        data = open(src, "rb").read()
        new, n = AID.subn(b"<agent-id redacted>", data)
        if n:
            open(dst, "wb").write(new)
            shutil.copystat(src, dst)
            return f"copied, {n} agent-id tokens redacted"
    shutil.copy2(src, dst)
    return "copied"


def main(do_copy):
    rows = []
    for line in open(os.path.join(HERE, "sweep.tsv")):
        if line.startswith("#"):
            continue
        where, size, mt, cls, det = (line.rstrip("\n").split("\t") + [""] * 5)[:5]
        tag, rel = where.split("/", 1)
        src = {"scratch": os.path.join(SESSION, "scratchpad", rel), "tmp": os.path.join(T, rel),
               "tasks": os.path.join(SESSION, "tasks", rel)}[tag]
        key = rel if tag == "scratch" else f"{tag}:{rel}"
        action, to = "", ""
        if cls.startswith("A-") or cls == "succ":
            fc, note = "in-repo", f"{cls}: {det}"
        elif cls == "C-disk":
            fc, note = "on-disk", det
        elif cls.startswith("J30:") and cls != "J30:inflight":
            fc, note = cls, det or "as J30 classified it"
        elif key in JUNK:
            fc, note = "junk", JUNK[key]
        elif key in PAPER_TEXT_HELD:
            pdf = PAPER_TEXT_HELD[key]
            assert os.path.exists(LIB + pdf), pdf
            fc, note = "paper-text", f"regenerable: pdftotext ~/source/library/pdf/{pdf}"
        elif key in PAPER_DISK or rel.startswith(("x-v1/", "x-v2/", "x-v3/")):
            fc = "paper-disk"
            note = PAPER_DISK.get(key, "extracted arXiv source of 2207.14179 ([AmbrusEtAl2023]), one version per directory")
            to = dest(tag, rel, os.path.join(DISK_DST, "papers"))
        elif mt >= INFLIGHT_FROM and tag != "tasks":
            fc, note = "inflight", "written at or after 08:00 today: a running consolidation job's or the owner's"
        elif key in REGEN:
            fc, note = "regen", REGEN[key]
            to = dest(tag, rel, os.path.join(DISK_DST, "regenerable"))
        elif tag == "tasks":
            fc, note = "owner-tasks", "the owner session's background-shell output"
            to = dest(tag, rel, os.path.join(DISK_DST, "owner-tasks"))
        else:
            fc, note = "rescued", det
            to = dest(tag, rel, REPO_DST)
        if to and do_copy:
            action = copy(src, to, redact=to.startswith(REPO_DST))
        rows.append((where, size, mt, fc, to.replace(R + "/", "").replace(os.path.expanduser("~"), "~"), action, note))
    with open(os.path.join(HERE, "manifest.tsv"), "w") as fh:
        fh.write("# C1 manifest, 2026-09-26: every file swept (sweep.tsv) with its final class and where it is now.\n"
                 "# columns: where swept (scratch/ = session scratch, tmp/ = /tmp/claude-1000, tasks/ = the session's tasks dir); bytes; mtime;"
                 " final class; copied to; copy result; note. Classes: see rescue.py's docstring.\n")
        for r in rows:
            fh.write("\t".join(map(str, r)) + "\n")
    agg = collections.defaultdict(lambda: [0, 0])
    for r in rows:
        agg[r[3]][0] += 1
        agg[r[3]][1] += int(r[1])
    for c, (n, s) in sorted(agg.items()):
        print(f"{c:14s} {n:5d} {s / 2**20:8.2f} MB")
    print("redacted:", sum("redacted" in r[5] for r in rows))


if __name__ == "__main__":
    main("--copy" in sys.argv)
