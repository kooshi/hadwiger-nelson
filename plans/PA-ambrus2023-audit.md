# PA — audit of `[AmbrusEtAl2023]`'s verification code and certificate (crunch job J26)

*de Bruijn, Opus 5.5, 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J26-ambrus2023-audit.md` (with `STANDING-RULES.md`).
Resuming: read this file and the brief, check the last SAVED stage against `git log -- plans/PA-ambrus2023-audit.md`, continue at
the first stage not SAVED.*

**The paper.** G. Ambrus, A. Csiszárik, M. Matolcsi, D. Varga, P. Zsámboki, *The density of planar sets avoiding unit distances*,
arXiv:2207.14179 (v1 28 Jul 2022, v2 20 Oct 2022, v3 28 Jul 2023); published **Mathematical Programming 207 (1–2), 303–327**,
DOI 10.1007/s10107-023-02012-9 — first online 6 October 2023, print issue September 2024 (Crossref, fetched 2026-09-25; received
11 Nov 2022, accepted 25 Jul 2023). Held copy: `~/source/library/pdf/arXiv-2207.14179-ambrus-csiszarik-matolcsi-varga-zsamboki-density-planar-sets.pdf`
(v3, 24 pp.). The published version is paywalled here (Springer page: `"Open Access":"N"`); v3's arXiv comment reads "Final version,
to appear in Mathematical Programming".

## Theorems this phase proved

*(filled at the close of the audit; none expected — this is a reading and a run-or-price.)*

## "Would have searched here" log

*(one line per move that would have been a search, and what was done instead)*

## Stage 1 — SAVED: the ruling, the quotations, and where everything is

### 1.1 The ruling this audit revisits

`plans/FS86-close-inventory.md` item 70, verbatim (its "kind" column: "ruling (owner, at the close)"):

> "**No auditor for C14's external input** (2026-09-25, the close planner's recommendation, owner agreed): C14 is filed at "hand, two
> derivations; at every real place it rests on `[AmbrusEtAl2023]` Thm 1, `m₁(ℝ²) ≤ 0.2470` [external, computer-assisted, published; not
> re-checked here]", and the audit is a named post-close item (an existing checker on an existing certificate, allowed during the ban
> once the certificate and code are found). **Alternative weighed:** an auditor alongside the close. **Why this won:** no certificate
> file or checker is held, so an audit means finding and reproducing their verification code first, a job of unknown size competing
> for the cap; the dependency is only at real places (a complex place behaves like a split place, ratio → 0); nothing else in print
> gives `m₁(ℝ²) < 1/4` (`[KMOR2016]` 0.2588, Ambrus–Matolcsi 0.2544). Confidence medium. The row's grade line is written so it can be
> upgraded in place."

What this audit changes about that ruling's premises is recorded at the verdict (Stage 4). Already at this stage: the premise "no
certificate file or checker is held" is now false in its first half — both are found and held (§1.3) — and the "job of unknown size"
now has a size (Stage 3).

### 1.2 Every quotation in the brief, checked against its source (standing rule 5)

| # | the brief says | the source says | verdict |
|---|---|---|---|
| Q1 | FS-86's C14 "uses, at the real place, the bound `m₁(ℝ²) ≤ 0.2470`" | `plans/FS86-derivation.md` FS86-Cx-C14: "inputs: at every real place AmbrusEtAl2023 Thm 1 (m₁(ℝ²) ≤ 0.2470; external, computer-assisted, published; not re-checked here)"; the paper's Theorem 1 (p. 4): "Any Lebesgue measurable, 1-avoiding planar set has upper density at most 0.2470." | matches |
| Q2 | "G60's `χ_f(K²) = 4` uses the same paper's geometric fractional chromatic number and its graph `G27`" | `CLAUDE.md` G60: "[hand, from `[MatolcsiEtAl2025]`; …]"; Frontier item 13: "`[MatolcsiEtAl2025]`'s blow-up never leaves the field … with their `G27` and Theorem B, **χ_f(K²) = 4**"; `BIBLIOGRAPHY.md` line 176 (`[MatolcsiEtAl2025]`, arXiv:2311.10069): "a 27-vertex witness `G27` … `χ_gf(G27) = 4`, blown up by the amenability of the plane's isometry group". The paper under audit: Definition 2 (p. 9) — "The geometric fractional chromatic number of G, denoted by χgf (G)" — defines `χ_gf`; it contains no `G27` and no blow-up (its Corollary 2 gives only the measurable bound `m₁(ℝ²) ≤ 1/χ_gf(G)`). | **half wrong.** The definition of `χ_gf` is this paper's; `G27` and the blow-up behind G60 are `[MatolcsiEtAl2025]`'s, a different paper (four authors, two shared). G60 reads this paper for a definition only, and no computation of this paper enters it (Stage 4 §4.3). |
| Q3 | "the bibliography holds two keys for this one paper (`[AmbrusEtAl2023]`, held; `[AmbrusEtAl2024]`, "not held, not read")" | `BIBLIOGRAPHY.md` line 188: key column "**[AmbrusEtAl2024]** / **[Ambrus2023]**", copy column "not held", read column "**not read — second-hand (the web-Claude analysis, `[Ducz2026]`, `[MatolcsiEtAl2025]`)**"; line 259: "**[AmbrusEtAl2023]**", copy `pdf/arXiv-2207.14179-…pdf`, "read — §2 (Lemma 1) and §5 (2026-09-14)" | matches in substance; the inner quotation joins two columns and drops "— second-hand (…)"; and the duplicate is **three** keys, not two (`[Ambrus2023]` too) |
| Q4 | "FS-86's close logged (item 70 …): find the authors' verification code and certificate, and run it unmodified" | item 70 (§1.1): "the audit is a named post-close item (an existing checker on an existing certificate, allowed during the ban once the certificate and code are found)" | a paraphrase, unquoted; "run it unmodified" is the brief's instruction, not item 70's words; consistent in substance |
| Q5 | "Ambrus–Matolcsi 0.2544", "`[KMOR2016]` 0.2588" (inside item 70) | the paper p. 4: "Keleti, Matolcsi, de Oliveira Filho and Ruzsa [KeMOR16] showed that m1 (R2 ) ⩽ 0.2588 … Ambrus and Matolcsi [AmM22] proved that m1 (R2 ) ⩽ 0.2544" | matches |

**One slip logged (Q2):** the brief attributes `G27` to this paper; it is `[MatolcsiEtAl2025]`'s. The `CLAUDE.md` Frontier's "Not ours" list
reads "the geometric fractional chromatic number, the blow-up and `G27` (`[AmbrusEtAl2023]`, `[MatolcsiEtAl2025]`)", which is right if
read respectively (the number from the first, the blow-up and `G27` from the second); nothing to correct there.

### 1.3 Where everything is (every version)

| piece | where | version / date | licence | held here |
|---|---|---|---|---|
| arXiv ancillary files | `arxiv.org/abs/2207.14179v1`, `v2`, `v3` — none of the three abstract pages lists ancillary files; `arxiv.org/src/2207.14179vN/anc` returns 404 for N = 1, 2, 3 | — | — | — (there are none) |
| arXiv source | `arxiv.org/e-print/2207.14179vN`: v1 = `main.tex` + 8 figure PDFs (including `x24.pdf`, a 24-point set); v2 = `main.tex` + 8 figures (`x_23.pdf`, `g_23_phi_1000.pdf`); v3 = `main_final_version.tex` + 9 EPS figures (`g_23_phi_10000.eps`) | 2022-07-28, 2022-10-20, 2023-07-28 | arXiv default | not kept (only TeX and figures; no code, no data) |
| the paper's "[Web]" | `https://bit.ly/unit-distances` → HTTP 301 → `https://static.renyi.hu/ai-shared/daniel/unit-distances/`, a page titled "Supplementary material for 'The density of planar sets avoiding unit distances'", section "Verification": "This page contains all the tools necessary to verify the computer-aided proof presented in the paper" | fetched 2026-09-25 | **none stated** (page, notebook and CSV carry no licence or copyright text; grep for "licen"/"copyright" returns 0 in all three) | `data/pa-ambrus2023/index.html` (sha256 `d0732213…`) |
| the checker | `verification23.nb` — "Mathematica notebook for verification"; 450,992 bytes, ASCII, CRLF | server Last-Modified 2022-10-19 19:49:02 GMT | none stated | `data/pa-ambrus2023/verification23.nb` (sha256 `7d230f20d41a2a3355bee78241c9d626134548c18eeec4de8a1d1217a74cecec`) |
| the checker, as run | `verification23.pdf` — "Pdf version of the Mathematica notebook"; 11 pp., Creator "Wolfram Mathematica 13.0.0.0 for Microsoft Windows (64-bit) (December 2, 2021)", created 2022-10-19 | 2022-10-19 | none stated | `data/pa-ambrus2023/verification23.pdf` (sha256 `cab617df632c675c6239080350d9eceaef0bd8ce07e1a9cbd612c52743c0af11`) |
| the certificate | `g23.csv` — "Text file describing the solution of the witness linear program"; 2,350 lines, one non-zero dual coefficient each (`w_0`, `w_T`, `w_1,i`, `w_2,i,j`, `w_C,"{I}","{J}"`) — the paper's "There are 2350 non-zero coefficients, of which 2321 are of type wc (I, J)" (§8) | 2022-10-19 | none stated | `data/pa-ambrus2023/g23.csv` (sha256 `cbfe22f5028f23a84f17d97802a93517e702eea0181d692ad7f5477763cf7274`) |
| the published version's supplement | Springer ESM `10107_2023_2012_MOESM1_ESM.pdf` ("Supplementary file 1 (pdf 219 KB)", the article's only supplementary item) | with the 2023 publication | Springer | **byte-identical to `verification23.pdf`** (same sha256 `cab617df…`), so not kept twice |
| slides | `https://static.renyi.hu/ai-shared/daniel/udg/geoszem-v1.0.pdf` (1.8 MB, 2022-09-24), "a self-contained talk at the Budapest Big Combinatorics + Geometry Seminar" | 2022-09-24 | none stated | not fetched (not a verification input) |

**Runtime needed:** the notebook is Mathematica (13.0, per the PDF's producer). **Nothing that runs a Mathematica notebook is installed
on the desktop**: `wolframscript`, `math`, `MathKernel`, `WolframKernel`, `wolfram`, `mathics`, `mathics3` are all absent (`command -v`),
and there is no `/usr/local/Wolfram`, `/opt/Wolfram` or `~/.Wolfram`. So "run it unmodified" needs an install first (priced in Stage 3).
