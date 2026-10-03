JOB CL3 — DONE   harness≈about 240k (own≈about 150k)
RESULT: 981 log lines counted (jobs from 2026-09-24 on; 29 written after 2026-10-01): R replaced 511, N none 358, O left open 103, U unclear 9.
RESULT: O 103 of 981 (10.5 %); of these 58 are mixed (they also name a result reached, flag also-R), 5 give a budget/time-box/held-paper reason (flag nonban?), 49 have at least one candidate later entry (a candidate, not a finding).
RESULT: 278 records kept a log; 71 of them have at least one O line; 87 hold only N lines. Records by kind (log / with O): Poros 25/6, verifier 76/24, proof 38/12, construction 13/3, opening 4/0, other 122/26.
RESULT: Lines by kind (R/O/N/U): Poros 25/10/32/0; construction 32/3/7/0; opening 9/0/9/0; proof 100/24/42/1; verifier 169/26/67/4; other 176/40/201/4. Per milestone and per job date: data/workflow3/cl3/counts.md (O by date: 09-24 5, 09-25 50, 09-26 10, 09-27 20, 09-28 6, 09-29 10, 10-03 2).
RESULT: After 2026-10-01: N 19, R 8, O 2 (FS116-Y3-construction.md:48, the HEX3 star; FS116-Y4-construction.md:52, the second shell). The brief's control, FS116-Y4-EMPTY, is among Y3:48's candidates.
RESULT: Context: 292 `derivation:` blocks in 5 files (FS111 85, FS114 47, FS116 91, FS121 65, TC1 4); 704 older-shape entries counted by lines opening "**ID — " in 18 files, agreeing with the headers that state a number; per-job derivation files use neither shape and are not counted.
RESULT: 15 requests/rulings copied verbatim in data/workflow3/cl3/rulings.md, including FS116 items 82, 86, O7 and FS81 item 82 (the ban's minting).
RECORD: plans/WORKFLOW3-CL3-ban-audit.md   COMMITS: e3b13196 (stages 1-3; the report follows)
Files: data/workflow3/cl3/lines.tsv, rulings.md, counts.md, context.tsv, overrides.tsv, aggregates.tsv, plants.txt; tools/cl3_*.py (each with a selftest and a --plant run, shown failing).
INVENTORY:
- result — counts above — plans/WORKFLOW3-CL3-ban-audit.md § Stage 3
- statement defect — the brief says about 277 files mention the phrase; 469 do on 2026-10-03 (151 are briefs, 8 reports) — brief, § What to collect 1
- tool defect — none open; two extractor faults were caught by reading and repaired (close-inventory table rows read as logs) — record § Stage 1
- question for another lane — whether the wallclock-budget policy keeps the log; 5 O lines are non-ban reasons — O list in the record
HELD FOR THE COORDINATOR:
- Precedence rule (mine): a line naming a result is R unless it also carries a strong open marker (GAP, left open, stall, deferred, post-ban); weak "not run / not done" alone gives O only when no result is named. Under a stricter reading O falls toward the 45 non-mixed lines, under a looser one it rises; the 58 mixed lines are flagged also-R so Kooshi can see both.
- CHECK: R lines (511) were scanned by marker, not read one by one; a result word can hide a step that stayed open.
- CHECK: plans/FS107-stability.md:724 — OpenAlex cross-check "a debt"; not a witness search, skipped; class unclear.
- CHECK: plans/FS112-N-proof.md:33 — "not fitted to any figure; read from the printed words only"; unclear.
- CHECK: plans/FS112-NB-verification.md:32 — "a second-order comparison, stated as a sketch"; result or open unclear.
- CHECK: plans/FS114-YB-verification.md:25 — "Stage 1: the four entries at the end of stage 1c"; a pointer, its section not read.
- CHECK: plans/FS114-YB5-verification.md:30 — "registered one probe per check"; a bounded probe was run, unclear.
- CHECK: plans/FS84-S1V-verification.md:171 — "not needed for the claim; logged"; unclear.
- CHECK: plans/FS85-C-deBruijn.md:432 — a logged breach: a sweep was run; no class word settles it.
- CHECK: plans/FS91-S0V-band-to-nine.md:296 — row "| 1 | — | — |"; dashes only.
- CHECK: plans/M3-S1B-rank-one.md:337 — W4, "one D chosen by a stated rule … at the ban's edge"; a bounded run, unclear.
- CHECK: 40 aggregate lines (planners' re-counts of other jobs' lines) are not counted; I checked only that FS106's jobs have their own records in the set. Their sources elsewhere (e.g. FS91 J-numbered jobs) may not.
- CHECK: job dates are first commits and written dates are git blame; a line re-committed later shows the later date.
- CHECK: the 15 rulings are my selection from a 115-row candidate list; the filter run is not saved.
