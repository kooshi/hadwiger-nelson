JOB TB1 — DONE   harness≈320k (own≈155k; the launch context was ≈165k)
RESULT: `tools/fs71_ledger_b_check.py` reads both derivation-file grammars — DONE. Evidence:
  - On today's tree its output is byte-identical to the baseline in both modes: exit 0, "census: 1003 theorems in 72 derivation
    files", "LEDGER § B rows: 1003 | placeholders: 0".
  - `--self-test` passes 31 cases.
  - Twelve in-memory mutations of the checker each turn the self-test red, and each fails the case it targets.
  - An end-to-end run over a scratch tree holding a new-grammar file passes, and fails when one § B row is removed.
RESULT: the survey — no other tool in tools/ or scripts/ parses derivation-file entries by the older shape. The readers of those files
  are whitespace-normalising quote checkers aimed at fixed older files, plus the fact audit; none misses anything in a new-grammar
  file. Record §3.1.
RECORD: plans/WORKFLOW3-TB1-ledger-check.md   COMMITS: 4e4e3f21 (stage 1), 95efed69 (stage 2: the checker), ef05730b (stage 3), and this report's
INVENTORY:
- result — the checker reads the new grammar per entry, with the gate's own parser (imported, so the census reads what the gate reads); the id rule is kept; --strict requires the gate's mandatory fields plus the words "rests on" in the prose under each entry; an id defined twice fails, in either grammar or across them — record §2.1–2.2; tools/fs71_ledger_b_check.py at 95efed69
- result — the field mapping: *Proof:* → argument:; *Proof verdict:* → verdict: (with minds:); *Prior art:* → prior art:; *Kernel:* → handoff:; *Rests on it:* → no field, so a prose check — record §2.2 (the address the closes' evidence cites)
- tool defect — the new grammar has no *Rests on it* field; a draft replacement for the line in .claude/agents/ephodos.md § The close job ("a prose paragraph opening 'Rests on it:'") is in record §2.2, for Keryx to file; a real grammar field would be Kooshi's call (the skill is upstream)
- tool defect — derive_gate.py silently folds any indented line with an unknown key into the previous field (tested: a misplaced `rests on it:` lands inside handoff:; a misspelled field would be absorbed the same way); documented upstream behaviour, not changed here — record §1.3, §3.2 item 3
- tool defect — the older self-test counted its plants one-sidedly (n ≥ 3) and left its "clean" line out of the verdict; tightened, still passes — record §2.4
- slip — my own: the new self-test's field loop first read the constant under test, so removing a field removed that field's test; the mutation harness found it, and it was fixed before commit (the loop now reads the gate's FIELDS) — record §2.4
- slip — the brief's baseline time (16:55; it was about 16:41); the coordinator has recorded it (plans/WORKFLOW3-test-drive.md F6) — record §1.1
- result — hyphenated bare names (`derivation: N7-3T`) are counted as written, not prefixed; reported mid-flight, and both close briefs were amended at 7ed60495; the checker prints a hint when it sees the pair — record §1.3
- question for another lane — § B lines drafted from new-grammar entries must translate grades into project words: tools/viz_local_global_map_common.py folds "computed over: …" to "open" — record §3.1
HELD FOR THE COORDINATOR:
- whether to file the lane-file line drafted in record §2.2 (the "Rests on it:" marker)
- whether to raise with Kooshi a `rests on:` field for the upstream grammar, and the gate's silent folding of unknown keys
