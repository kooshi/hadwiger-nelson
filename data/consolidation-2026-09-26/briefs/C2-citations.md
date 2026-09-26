*Brief for job **C2**: clean citations. Opus 5.5, 2026-09-26. Written by the product owner.*

Hello. You are de Bruijn (`DEBRUIJN.md`), the bibliographer, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md` (the header's bibliography
rule; G49, G50), `WORKFLOW.md` 3.2, and `DEBRUIJN.md` from disk. **`data/consolidation-2026-09-26/briefs/STANDING-RULES.md` is part of this
brief.**

## Kooshi's words (2026-09-26, verbatim)

> "Now, next, I want to do a documentation consolidation. Let's audit our main files and just make sure that our citations are clean, all
> findings are wired in, all files in /tmp that can't be regenerated are rescued, and all claims are brought up to date with our new evidence."

Your share is **the citations**. C1 (rescue and wiring) and C3a (claims in `CLAUDE.md`, `LEDGER.md`, `CLOSED-QUESTIONS.md`) run beside you.

## What "clean" means here (check each; fix in `BIBLIOGRAPHY.md`)

1. **Every key resolves** (`python3 tools/bib_audit.py`, exit status read directly) — in `CLAUDE.md`, `LEDGER.md`, `CLOSED-QUESTIONS.md`,
   `plans/`, and the Lean docstrings under `Proofs/`.
2. **Every "held at" address exists** — for every row whose copy is in `~/source/library/` (or elsewhere), the file is there (md5 where the row
   gives one). This crunch moved files: the Einsiedler–Fish 2010 PDF, Laca–Warren 2018, Bekka–Francini, the two Huang papers, and J53's
   Einsiedler–Lindenstrauss copy — check each row points at the new address and nothing in the repository still points at an old path.
3. **Read status per section matches the records.** This crunch's records state what was read: Einsiedler–Fish 2010 (read in full, several
   jobs), Einsiedler–Lindenstrauss 2021/2022 (§1 re-read, §2 read in full and §4.1–§4.3, X24R), Laca–Warren 2018, Huang 2017 and Huang–Li–Shi–Xu
   2023 (§1), Lindenstrauss 2004 (pp. 1–6), Bekka–Francini 2022 (Thm 1.1, Remark 1.2), Croft 1967 (via `[AmbrusEtAl2023]`, not held), Sataev 1975
   (not held, not in zbMATH), `[LindSchmidt1999]` (reviews only), Bader–Vigdorovich 2022 (abstract only, initials unchecked). Grep each job's
   record (`plans/FS100-X*.md`, `plans/FS100-X24R-prior-art.md`) for what it says it read, and make the row say exactly that — never more.
4. **The journal-year trap (G50):** a paper held under one key and cited under another (EL2021 vs `[EinsiedlerLindenstrauss2022]`) — add the
   alias the way the bibliography records aliases, so a grep by arXiv id or Zbl number finds the row. Check every row for its arXiv id and Zbl
   number where one exists.
5. **Prior-art debts left open by the crunch** — list them in one block at the end of `BIBLIOGRAPHY.md`'s debts section (or wherever it keeps
   them): Johnson 2000/2006 (Kooshi is pursuing them himself: note "Kooshi, acquiring"), Sataev 1975, `[LindSchmidt1999]` and
   Einsiedler–Lind–Miles (NA₀'s home discipline), Lind–Ward 1988 and Chothi–Everest–Ward 1997 (cited from memory in X01D).
6. **"Rests on it" lines**: each row that this crunch's results rest on (EL2021 Thm 1.2 → PE-2, row 120; Einsiedler–Fish → EF_F⁺; Croft → m₁;
   Fischer 1990/1994; Moorhouse 2010 §7.1 → FS54-T2 …) names the rows that rest on it.

**Do not rename any key** (C3a is editing the files that cite them). Add rows, aliases and fields; fix wrong fields; that is all.

## Stages

1. The audit: run `bib_audit`; build the table of rows touched by the crunch with each check's result. Save it as your record,
   `data/consolidation-2026-09-26/C2-record.md`.
2. The fixes, in `BIBLIOGRAPHY.md` (and, if a key cannot resolve without it, the alias table the audit reads — say so). Save; commit.
3. The report.

## Rules

- **Touch only** `BIBLIOGRAPHY.md`, your record, and `data/consolidation-2026-09-26/`. Never `CLAUDE.md`, `LEDGER.md`, `CLOSED-QUESTIONS.md`,
  plans, stubs, Lean files, frozen tools. If a citation in one of those files is wrong, list it in your report under "owed" for C3a/C3b.
- Fetching a paper to check a field is allowed (G50: grep `BIBLIOGRAPHY.md` and `~/source/library/` first); contacting anyone is Kooshi's call.
- **Budget:** about 150k by the harness's count; hand back by 220k.
- Report per standing rule 9 to `data/consolidation-2026-09-26/reports/C2.md`.

Thank you.
