# Brief: FS-89's close, second half (WORKFLOW step 9), for the successor close planner

You are **de Bruijn**, the engineer who owns the mathematics of `/home/kooshi/source/lean-dir`, working as **the successor planner for
FS-89's close**. I'm the product owner, the coordinating session. The first close planner stopped cleanly at its budget, with half the
close done and ticked. Please finish it.

Read the first planner's brief, `data/fs89/briefs/CL-close-planner-brief.md`, in full. Its standards, sources and rules all apply to you,
with the changes below. **Kooshi's close rules, repeated:** *"close out with the findings"*; *"I don't want to lose anything from
before"*; *"All novel knowledge is a success."* Every result goes in at its exact scope and grade.

## Where the close stands

- **Done, and reviewed by me** (inventory item 44). Commits:
  - 894ec89d: `plans/FS89-derivation.md` (62 entries) and the § B lines;
  - 2befcaef: `LEDGER.md` rows 95–97;
  - 3dcb8de8: `CLAUDE.md` current state, at 274,960 bytes, with the fact audit passing;
  - 0dfe1f54: the stub banner, the verifier corrections noted, FS-91 minted.
- **Your checklist:** `plans/FS89-close-inventory.md`. Item 43 lists what is left, and items 44–46 were added since. You are now the
  inventory's only writer. Tick each item "done at <hash>" or "declined, with the reason".

## What is left (item 43's list, with the changes since)

1. **§R-close in the plan** (`plans/FS89-rational-band-rigidity.md`). `CLAUDE.md` already points to it.
   - the §G, §PA and §IQ re-reads;
   - the predictions scored once (the plan's §P, and every agent's C0);
   - the verdict, with the reason;
   - the honesty tally (every owner error and agent slip in the inventory);
   - the search-log count;
   - the ban measurement Kooshi asked about (item 3).
2. **The prior-art gate (§6 of the first brief).** Three readers are working, each writing only its own record:
   - `plans/FS89-PA-berend1984.md`: Berend 1984 and the parts of 1983 that bear;
   - `plans/FS89-PA-furstenberg1967.md`: the home theorem, and our second-hand quotations of it checked;
   - `plans/PA-tardif2023.md`: products at four colours, and our citations of it checked.

   I'll forward each reader's verdicts to you verbatim as they land. Until then, work everything else. When they land:
   - replace every "pending the Berend 1984 reading" in rows 95–97, `CLAUDE.md` and `plans/FS89-derivation.md` with the verdict, at its
     exact scope;
   - fix any second-hand quotation a reader finds wrong.

   Run the close's own zbMATH queries on the filed theorems too (the first brief's §6 wording).
3. **`BIBLIOGRAPHY.md`.** Four papers left § R.4 today, because Kooshi saved them from a browser (items 42, 45):
   - Berend 1983 and Berend 1984 (§ R.4 item 12);
   - Furstenberg 1967 (§ R.4 item 13);
   - Tardif 2023, a preprint; correct its row per item 46 once the reader reports.

   El-Zahar–Sauer 1985 stays requested: it is fully paywalled, and Kooshi may buy access later. Give each held paper its row, file path
   and honest read status from its reader. Run `tools/bib_audit.py`.
4. **`CLOSED-QUESTIONS.md`.** The planner found no poser of RQ₄. Say so at exact scope, or cite one if a reader finds one.
5. **`plans/FRONTIER-STUBS.md`, re-ranked to match `CLAUDE.md`'s table.** Also each stub's own re-aim: FS-83, FS-64, FS-59, FS-84, FS-76,
   FS-90, the last including item 4's acquisition step.
6. **The protocol,** `plans/PROTOCOL-competitor-and-advisor.md` §3. Add FS-89's run (items 9, 11, 18, 22, 33, 38, 44, 45). Include
   item 38 as refined in 44: agents' self-counts ran at 55–70 % of the harness for long derivations, and about 100 % for the close
   planner.
7. **The gates.**
   - `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`;
   - `scripts/axioms.sh` and `scripts/vacuity.sh`, reading the logs under `build/gate/` against § The gate's counts;
   - `tools/check_architecture.py`, `tools/bib_audit.py`, `tools/fs71_ledger_b_check.py --strict`;
   - `tools/claude_md_fact_audit.py --base 052707ac` and `--dupes` (11).

   Rerun the fact audit after any `CLAUDE.md` change. `CLAUDE.md` has 40 bytes of room, so compress without loss before adding anything.
   Never touch a `[PROTECTED]` paragraph, or an entry's *Do* or killing test.
8. **Item 41** (the first planner's band-1/6 reading) stays a reading; don't work it.

## Rules that differ from the first brief

- **The tree is shared with three readers.** Commit only with explicit paths: `git add <new files>`, then `git commit <paths> -m …`,
  never a bare `git commit`. The readers write only their own records and never touch your files; you never touch theirs.
- **Budget:** stop at about 350k tokens by your own count, with the inventory ticked, commit, and tell me. A third planner is fine if
  needed.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs89-close2/`.
- **Staffing.** Kooshi has raised the cap to four agents "for now"; you are the fourth. No subagents, forks or workflows of your own:
  delegation here is one level deep (`CLAUDE.md` § Delegation). The reason: staffing is Kooshi's budget decision, and I can only review
  work I know about.
- **Reports** go to me by SendMessage (`to: "main"`): after §R-close, after the gates, and at the end, with hashes. Keep your final turn
  text content-free: "close planner idle; reports go to the owner by SendMessage".

Thank you. The first planner left the half it did in good order; the ticks are your map.
