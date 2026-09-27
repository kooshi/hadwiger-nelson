*Brief for job **BK**: the bookkeeping of the consolidation run. Opus 5.5, 2026-09-27. Written by the product owner. **Sized for about 300k tokens
by the harness's count. Your own count runs at 55–70 % of it, so hand back with your work saved when your own count reaches about 190k.***

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/consolidation-2026-09-27/briefs/STANDING-RULES.md` is part of
this brief; read it first, rule 0 first.** Then read from disk: `plans/CONSOLIDATION-2026-09-27.md`; `CLAUDE.md`'s header rules (the byte budget,
current state only, one home per fact), § The aim, § Counter-priors, § Where the problem stands and § Paths forward; `WORKFLOW.md` steps 2 and 9;
`plans/RERANK-2026-09-27.md` §§ 3–4; `LEDGER.md` rows 131–134.

## Why this job exists

Kooshi, 2026-09-27: *"The goal of the run will be all of the low urgency items, and full reads of any important papers we haven't read yet,
folding in their info."* The papers go to two other jobs (LP and LW). The low-urgency bookkeeping left by the last three closes (FS-106, FS-107,
FS-110) and the ranking pass is yours.

## The task, in stages (save after each)

1. **CE1–CE7.** FS-110's inventory item 115 records *"Owed: CE1–CE7 derivation entries (no § B lines yet)"*. Write one entry for each of CE1–CE7
   in `plans/FS110-derivation.md`, in that file's entry form, from `plans/FS110-CE-verification.md`'s "Theorems this phase proved" and the sections
   each cites, with grades as item 113 set them; add one `LEDGER.md` § B line each, pointing at row 134. `tools/fs71_ledger_b_check.py` skips three
   header shapes silently, so every header must use an ASCII id, put no parenthetical before the dash, and nest no brackets inside a grade. Run
   `python3 tools/fs71_ledger_b_check.py --strict`, exit status read directly.
2. **The checker's three silent skips** (FS-106 inventory item 83, FS-107 item 39). Make `tools/fs71_ledger_b_check.py` fail loudly on each shape
   rather than skip it: a grade with nested brackets (balance them or name the header), a non-ASCII id, a parenthetical before the dash. Plant one
   header of each shape in a scratch copy of a derivation file and watch `--strict` fail for its own reason, naming the header; then confirm the
   real tree still passes. (The tool is not on the frozen list.)
3. **The 26 stub files' six-framed bearings** (`plans/RERANK-2026-09-27.md` § 3 lists them, one of them twice, with the heading or paragraph in each). Rewrite each
   bearing in current-state words: what the stub would contribute to deciding `χ(ℝ²)`, or to the Lean formalization of whatever decides it, and
   how it relates to the direction (links 1–6 of § The aim) — "none" plainly where that is the truth. The stub's row in `plans/FRONTIER-STUBS.md`
   is authoritative (the ranking pass rewrote it); agree with it, adding only what the stub's own detail supports. Keep grades and soft-as-to-truth
   warnings; do not inflate (Kooshi: *"All novel knowledge is a success"* — a row can bear weakly and still earn its place). Rename the headings
   "Bearing on the answer". Touch nothing else in those files.
4. **The front files' remaining six-framed lines** (`plans/RERANK-2026-09-27.md` § 4): `CLAUDE.md` § Where the problem stands items 28, 29 and 30,
   each ending "Bearing on χ ≥ 6: …"; `plans/FRONTIER-STUBS.md`'s open-milestones table heading "next, and bearing on χ ≥ 6" and its cells, and its
   ranking-rule sentence "a route to χ ≥ 6 must end in a 6-open field". Rewrite each in current-state words, with the answer's framing. **The
   budget:** `CLAUDE.md` is 295,846 bytes against its 300,000 limit; your edits must not grow it. Report the byte count before and after.
5. **The three inventories' open items.** In `plans/FS106-close-inventory.md`, `plans/FS107-close-inventory.md` and
   `plans/FS110-close-inventory.md`, every item whose status cell is still "open": check it against the tree and set its status cell to "done —
   <where>", "declined — <reason>", or "carried — <to which stub or file>". Edit status cells only. An item that needs a front-file change you do
   not own (`BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`, `LEDGER.md` outside § B) goes into your record as a draft for the owner; FS-110's
   `CLOSED-QUESTIONS.md` question is Kooshi's and stays with the owner.
6. **Gates and report.** Each exit status read directly, never through a pipe:
   `python3 tools/claude_md_fact_audit.py --base <HEAD at your launch>` PASS, every ALLOW line stated with its reason;
   `python3 tools/claude_md_fact_audit.py --dupes` not above 10; `python3 tools/fs71_ledger_b_check.py --strict` PASS; `python3 tools/bib_audit.py`
   PASS; `python3 tools/check_architecture.py` PASS; `python3 data/rerank-2026-09-27/rk_mirror_check.py` PASS.

## Rules

- **Touch only:** `plans/FS110-derivation.md`; `LEDGER.md` § B (never § The claim list or a row's text, which job LP may edit); the stub files of
  RERANK § 3 (their bearing section only); `CLAUDE.md` § Where the problem stands items 28–30; `plans/FRONTIER-STUBS.md` (the open-milestones table
  and the ranking-rule sentence; never the ranked table); the three inventories' status cells; `tools/fs71_ledger_b_check.py`; and
  `data/consolidation-2026-09-27/bk/`. Everything else by draft in your record.
- **Record:** `data/consolidation-2026-09-27/bk/record.md`, with a heading "Theorems this phase proved" (expected empty: this job files, it does not
  derive).
- Commits by explicit path, subjects "BK: stage n". Never amend; push after each; never force-push. LP edits `LEDGER.md`'s claim list in parallel:
  on a rebase conflict keep both sides.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- **Report** to `data/consolidation-2026-09-27/reports/BK.md`, committed, and by SendMessage to `"main"`, with: the entries filed, the checker's
  change and its plants, the stubs rewritten, the byte counts, every inventory item's new status, the drafts for the owner, and each gate's result.
  Your final turn's text: "BK idle; report sent to the owner by SendMessage".

Thank you.
