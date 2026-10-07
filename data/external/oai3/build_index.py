#!/usr/bin/env python3
"""EXT-OAI3 — index of the outside release at /home/kooshi/source/math (read-only).

Builds, mechanically and from the release's own files only:
  families.tsv        one row per result family (372 expected)
  index.jsonl         one row per manuscript (722 expected)
  index.md            the same, readable: family, subject, title, path, Lean status, catalogue sentence, abstract
  index-summary.txt   the counts and the cross-checks

Sources read (nothing is executed from the release, nothing is written into it):
  CONTENTS.md                  family number, title, description; each manuscript's title, pdf path, abstract
  overview.tex                 each family's subject (discipline)
  preprints/<dir>/README.md    the manuscript's own title and date
  preprints/<dir>/*.pdf        first two pages by pdftotext (an independent source of title and abstract)
  lean/formalization.yaml      which pdfs are listed as "sources" (papers with a formalized main result)
  lean/docs/NNN.md             per-family formalization notes, with comparator links

Usage: python3 build_index.py [--no-pdf]    (run from anywhere; output beside this script)
"""
import json, os, re, subprocess, sys, html
from pathlib import Path

REL = Path("/home/kooshi/source/math")
OUT = Path(__file__).resolve().parent
NO_PDF = "--no-pdf" in sys.argv

def clean(s):
    s = html.unescape(s)
    s = re.sub(r"</?i>", "", s)
    s = re.sub(r"\$`(.*?)`\$", r"$\1$", s, flags=re.S)
    return re.sub(r"\s+", " ", s).strip()

# ---- CONTENTS.md -------------------------------------------------------------------------------
text = (REL / "CONTENTS.md").read_text(encoding="utf-8")
blocks = re.split(r"<tbody><tr>\s*<td>", text)[1:]
families, manuscripts = [], []
cur = None
for b in blocks:
    body = b.split("</td>")[0].strip()
    m = re.match(r"\*\*(\d{3})\. (.*?)\*\*\s*(.*)$", body, flags=re.S)
    if m:
        desc = m.group(3)
        lean = re.search(r"\(\[Lean\]\((lean/docs/\d{3}\.md)\)\)", desc)
        desc = re.sub(r"\s*\(\[Lean\]\(lean/docs/\d{3}\.md\)\)", "", desc)
        cur = {"family": m.group(1), "family_title": clean(m.group(2)).rstrip("."),
               "family_desc": clean(desc), "catalogue_lean_link": lean.group(1) if lean else ""}
        families.append(cur)
        continue
    m = re.match(r"&emsp;\[(.*?)\]\((preprints/[^\n]*?\.pdf)\)([^\n]*)\n(.*)$", body, flags=re.S)
    if m:
        manuscripts.append({"family": cur["family"], "title": clean(m.group(1)), "pdf": m.group(2),
                            "dir": m.group(2).split("/")[1], "catalogue_note": clean(m.group(3)).lstrip("— ").strip(),
                            "abstract": clean(m.group(4))})
        continue
    raise SystemExit("unparsed catalogue block: " + body[:200])

# ---- overview.tex: subjects --------------------------------------------------------------------
subj = {}
cursub = None
for line in (REL / "overview.tex").read_text(encoding="utf-8").splitlines():
    m = re.match(r"\\cataloguesection\{(.*?)\}\{(\d+)\}", line)
    if m:
        cursub = m.group(1); continue
    m = re.match(r"\\resultentry\{(\d{3})\}", line)
    if m:
        subj[m.group(1)] = cursub
for f in families:
    f["subject"] = subj.get(f["family"], "")

# ---- lean: formalization.yaml sources, docs --------------------------------------------------
yaml = (REL / "lean/formalization.yaml").read_text(encoding="utf-8")
src_section = yaml.split("\nsources:")[1].split("\nrelated_formalizations:")[0]
yaml_pdfs = set(re.findall(r"id: \.\./(preprints/\S+\.pdf)", src_section))
n_main = len(re.findall(r"- comparator_config:", yaml))
docs = {}
for p in sorted((REL / "lean/docs").glob("*.md")):
    t = p.read_text(encoding="utf-8")
    papers = re.findall(r"\]\(\.\./\.\./(preprints/[^\n]*?\.pdf)\)", t)
    comps = re.findall(r"\]\(\.\./ComparatorChallenges/([^)]*?\.lean)\)", t)
    scope = ""
    ms = re.search(r"## Scope\s*(.*?)(?=\n## |\Z)", t, flags=re.S)
    if ms: scope = clean(ms.group(1))
    docs[p.stem] = {"papers": papers, "comparators": comps, "scope": scope,
                    "has_caveat": bool(re.search(r"(?i)not (yet )?formaliz|does not (formalize|include|cover)|partial|assum|axiom|conditional|only the", t))}
for f in families:
    d = docs.get(f["family"])
    f["lean_doc"] = f"lean/docs/{f['family']}.md" if d else ""
    f["comparators"] = d["comparators"] if d else []
    f["lean_scope"] = d["scope"] if d else ""

# ---- per manuscript: README, pdf first pages ------------------------------------------------
def pdf_head(pdf):
    try:
        r = subprocess.run(["pdftotext", "-l", "2", "-enc", "UTF-8", str(pdf), "-"],
                           capture_output=True, text=True, timeout=60)
        return r.stdout
    except Exception as e:
        return f"[pdftotext failed: {e}]"

def abstract_from_pdf(t):
    m = re.search(r"\bAbstract\b\.?\s*(.*)", t, flags=re.S)
    if not m:
        return re.sub(r"\s+", " ", t[:900]).strip(), False
    a = m.group(1)
    a = re.split(r"\n\s*(?:Contents|1\.?\s+Introduction|1\s*\n\s*Introduction|Introduction\s*\n)", a)[0]
    return re.sub(r"\s+", " ", a[:1500]).strip(), True

dirs_on_disk = sorted(p.name for p in (REL / "preprints").iterdir() if p.is_dir())
seen = set()
for ms in manuscripts:
    d = REL / "preprints" / ms["dir"]
    seen.add(ms["dir"])
    rd = (d / "README.md").read_text(encoding="utf-8") if (d / "README.md").exists() else ""
    m = re.match(r"# \[(.*?)\]\((.*?)\)", rd)
    ms["readme_title"] = clean(m.group(1)) if m else ""
    m = re.search(r"\*\*Date:\*\*\s*(.*)", rd)
    ms["date"] = m.group(1).strip() if m else ""
    ms["pdf_exists"] = (REL / ms["pdf"]).exists()
    ms["has_tex"] = any(d.rglob("*.tex"))
    ms["in_formalization_yaml"] = ms["pdf"] in yaml_pdfs
    fam = next(f for f in families if f["family"] == ms["family"])
    ms["family_title"] = fam["family_title"]; ms["subject"] = fam["subject"]
    ms["in_family_lean_doc"] = ms["pdf"] in (docs.get(ms["family"], {}).get("papers", []))
    if NO_PDF:
        ms["pdf_abstract"], ms["pdf_abstract_found"] = "", False
    else:
        head = pdf_head(REL / ms["pdf"])
        ms["pdf_first_line"] = next((l.strip() for l in head.splitlines() if l.strip()), "")
        ms["pdf_abstract"], ms["pdf_abstract_found"] = abstract_from_pdf(head)

# ---- write ------------------------------------------------------------------------------------
with open(OUT / "index.jsonl", "w", encoding="utf-8") as fh:
    for ms in manuscripts:
        fh.write(json.dumps(ms, ensure_ascii=False) + "\n")
with open(OUT / "families.tsv", "w", encoding="utf-8") as fh:
    fh.write("family\tsubject\tn_manuscripts\tlean_doc\tcomparators\ttitle\tdescription\n")
    for f in families:
        n = sum(1 for ms in manuscripts if ms["family"] == f["family"])
        fh.write("\t".join([f["family"], f["subject"], str(n), f["lean_doc"], ",".join(f["comparators"]),
                            f["family_title"], f["family_desc"]]) + "\n")
with open(OUT / "index.md", "w", encoding="utf-8") as fh:
    fh.write("# EXT-OAI3 index — every family and manuscript of the release (generated by build_index.py; do not edit)\n\n")
    for f in families:
        fh.write(f"## {f['family']}. {f['family_title']}  [{f['subject']}]\n\n")
        fh.write(f"*Catalogue sentence:* {f['family_desc']}\n\n")
        fh.write(f"*Lean:* {('doc ' + f['lean_doc'] + '; comparators: ' + (', '.join(f['comparators']) or 'none linked')) if f['lean_doc'] else 'no family note in lean/docs'}\n\n")
        for ms in manuscripts:
            if ms["family"] != f["family"]: continue
            fh.write(f"- **{ms['title']}** — `{ms['pdf']}` ({ms['date']}; in formalization.yaml sources: {'yes' if ms['in_formalization_yaml'] else 'no'}{'; catalogue note: ' + ms['catalogue_note'] if ms['catalogue_note'] else ''})\n")
            fh.write(f"  - abstract (catalogue): {ms['abstract']}\n")
        fh.write("\n")

fam_nums = [f["family"] for f in families]
summary = [
    f"families parsed from CONTENTS.md: {len(families)} (distinct: {len(set(fam_nums))}; numbered 001..{max(fam_nums)}; contiguous: {fam_nums == [f'{i:03d}' for i in range(1, len(families)+1)]})",
    f"manuscripts parsed from CONTENTS.md: {len(manuscripts)} (distinct pdf paths: {len(set(m['pdf'] for m in manuscripts))})",
    f"preprint folders on disk: {len(dirs_on_disk)}; in catalogue and on disk: {len(seen & set(dirs_on_disk))}; on disk not in catalogue: {sorted(set(dirs_on_disk) - seen)}; in catalogue not on disk: {sorted(seen - set(dirs_on_disk))}",
    f"catalogue pdf missing on disk: {[m['pdf'] for m in manuscripts if not m['pdf_exists']]}",
    f"manuscripts with TeX source in their folder: {sum(m['has_tex'] for m in manuscripts)}",
    f"README title equals catalogue title: {sum(m['readme_title'] == m['title'] for m in manuscripts)} of {len(manuscripts)}",
    f"catalogue notes after a manuscript link: {sorted(set(m['catalogue_note'] for m in manuscripts if m['catalogue_note']))} on {sum(bool(m['catalogue_note']) for m in manuscripts)} manuscripts",
    f"families with a subject from overview.tex: {sum(bool(f['subject']) for f in families)}",
    f"families whose catalogue entry links a Lean note: {sum(bool(f['catalogue_lean_link']) for f in families)}; lean/docs notes on disk: {len(docs)}; families with a note on disk: {sum(bool(f['lean_doc']) for f in families)}; mismatch: {[f['family'] for f in families if bool(f['catalogue_lean_link']) != bool(f['lean_doc'])]}",
    f"formalization.yaml: sources listed {len(yaml_pdfs)}; of them manuscripts in the catalogue {sum(m['in_formalization_yaml'] for m in manuscripts)}; main_results (comparator configs) {n_main}",
    f"manuscripts in a family with a Lean note: {sum(1 for m in manuscripts if docs.get(m['family']))}; manuscripts named in their family's note: {sum(m['in_family_lean_doc'] for m in manuscripts)}",
    f"pdf abstracts located by the heuristic: {sum(m.get('pdf_abstract_found', False) for m in manuscripts)} of {len(manuscripts)}" if not NO_PDF else "pdf extraction skipped",
]
by_subj = {}
for f in families: by_subj[f["subject"]] = by_subj.get(f["subject"], 0) + 1
summary.append("families by subject: " + "; ".join(f"{k} {v}" for k, v in sorted(by_subj.items(), key=lambda kv: -kv[1])))
(OUT / "index-summary.txt").write_text("\n".join(summary) + "\n", encoding="utf-8")
print("\n".join(summary))
