# FS131-FC10 — drafts for what the Clerk did not file (every one is Keryx's decision; nothing here is applied)

## P1. The audit's lost tokens (tools/claude_md_fact_audit.py ALLOW / EXTERNAL_HOMES), run `--base 0f81fe2a3` and `--base 8cab63fa2` alike
Lost, with the draft that removed each:
- code `axioms=3 rests=78 named=19 inline=14 outside=7 ours=21 open=5 takes=108 mentions=2`, chunks `rests=78`, `takes=108` (D2: superseded gate count)
- code `declarations=22241 refutations-skipped=240 sites=1455`, chunks `declarations=22241`, `refutations-skipped=240`, number `22241` (D3: superseded gate count)
- number `10651` (D1: the clean count) and `11287` (D1: the record count)
- chunk `L(ℚ)` (D4: the IL5 "Last filed" text, which names "the model `L(ℚ) ≤ 2`"), moved by D4's rule to plans/FILINGS.md
Proposed entries, in the form the IL5 filing used (reasons copied from its pattern; the old counts stay in data/fs131/il5/gate/):
    "axioms=3 rests=78 named=19 inline=14 outside=7 ours=21 open=5 takes=108 mentions=2": "superseded gate count, refiled at FS131-ICO2's filing (2026-10-16) from data/fs131/ico2/gate/; the old count stays in data/fs131/il5/gate/ (rests=78)",
    "rests=78", "takes=108", "declarations=22241 refutations-skipped=240 sites=1455", "declarations=22241", "refutations-skipped=240", "22241", "10651", "11287": each "superseded gate count, refiled at FS131-ICO2's filing (2026-10-16) from data/fs131/ico2/gate/; the old count stays in data/fs131/il5/gate/".
    EXTERNAL_HOMES "L(ℚ)": ("plans/FILINGS.md", "the main clause's entry of CLAUDE.md's \"Last filed\" chain (FS131-IL5, 2026-10-16), moved verbatim to plans/FILINGS.md at FS131-ICO2's filing")
The text to move (verbatim from CLAUDE.md's "Last filed" line before this filing; saved at data/fs131/fc10/il5-last-filed-moved.txt), to go at the top of plans/FILINGS.md (the file's rule: "A filing that leaves the 'Last updated' line is added at the top"), headed "before it" as that file's entries are:
    before it **the main clause through five as one theorem** (FS131-IL5, 2026-10-16: ... the lower half this project's derivation);
(plans/FILINGS.md is not among this brief's touches, so it is not written; note it holds no FS131-IL5 text now.)

## P2. CLAUDE.md is over budget: 81,570 bytes against 80,000 (it was 79,366 at 0f81fe2a3; +2,204)
The audit's per-section byte table is in data/fs131/fc10/audit-0f81fe2a3.out (its CLAUDE.md sections are mixed with other files' sections of the same names there, so it is not summarised here). No cut is chosen.

## P3. Atlas: `viz_proof_atlas_check.py` fails one fact before and after this filing — R129's `posed` question
`FAIL R129: posed question not found at CLAUDE.md § The local–global conjecture: "row 129 (FS-133; one mind) answers the first clause of [DuczVarga2026]'s Conjecture 1 and "` — also on `main` (checked, 239/240 facts as of main at 65ee5a95c). CLAUDE.md now reads "…row 129's plane clause (FS-133) answers the first clause of `[DuczVarga2026]`'s Conjecture 1 and `[MatolcsiEtAl2025]` §2's equality question — formalized: …". `visualizations/proof-atlas/build.py` refuses while any fact fails, so D13's page was not rebuilt. A fix is a one-line edit of the `quote=` of R129's `posed` in `tools/viz_proof_atlas_facts.py` l. 436-437 to words the file now holds; not chosen here.
