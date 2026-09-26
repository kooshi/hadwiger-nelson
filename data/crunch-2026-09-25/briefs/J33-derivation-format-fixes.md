*Brief for crunch job **J33**: format and field fixes in the derivation files, so `tools/fs71_ledger_b_check.py --strict` can pass
(bookkeeping; Sonnet). 2026-09-25. Written by the product owner.*

Hello. You are a careful bookkeeper in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. Read `CLAUDE.md` (the header
rules and § B's description in `LEDGER.md`'s header), `WORKFLOW.md` step 9 ("Sweep the milestone's phases for theorems and file them"), and
`tools/fs71_ledger_b_check.py` (what `--strict` parses and requires) first. Kooshi: *"I'd rather it be thorough than miss something."*
Thoroughness matters more than speed; **never invent content**.

## What to fix (the front-page job J24 found these; it may not edit these files)

1. **`plans/FS91-derivation.md` and `plans/M3-derivation.md` — ids the checker cannot parse (13):** FS91: J02-A2.1′, J07-8, J11-W3, J12-A1,
   J12-B1, J12-C1, J12-CL, J12-H, J13-T6; M3: J18-KE⟹, J19-AF✗, J19-ENDS, J21-NG2. Causes: grouped headers ("A1, A2, A3 —"), headers
   wrapped over two lines, and the characters ′, ⟹, ✗ in ids. Fix: split a grouped header into one entry header per id (each keeping the
   shared text, or a pointer "as FS91-J12-A1" for a shared proof), unwrap wrapped headers, and respell ids in ASCII (`J02-A2.1p`,
   `J18-KE-implies`, `J19-AF-x` — or whatever form the checker accepts; read its regex), keeping the original spelling in the entry's text
   so nothing is lost. `LEDGER.md` § B lines will cite the respelled ids: list every respelling in your record so J24 uses them.
2. **The same two files — 60 entries missing a field** (FS91 20, M3 40): each entry must carry *Proof:*, *Proof verdict:*, *Rests on it:*,
   *Prior art:* (and *Kernel:*) as `tools/fs71_ledger_b_check.py` requires. Fill each missing field **only from the entry's own text or the
   record the entry cites** (open that record's section and copy what it says); where the record does not state it, write
   `*<Field>:* not stated in the record (<record address>)` — never a guess.
3. **M2's *Kernel:* fields in four older derivation files** — listed in `plans/M2-kernel-lane.md` §R-close (the kernel-column changes, "9
   kernel-column changes" in 4b or near it): for each theorem M2 moved to the kernel, set its *Kernel:* field to the kernel declaration's
   name and file, exactly as M2's kernel register `plans/M2-derivation.md` gives it.
4. **`plans/FS86-derivation.md` C14 and CL1's grade** — J26 re-checked `[AmbrusEtAl2023]`'s certificate: apply the proposed text of
   `plans/PA-ambrus2023-audit.md` §4.4 for those entries ("not re-checked here" → "re-checked here", with J26's address).

After each file, run `python3 tools/fs71_ledger_b_check.py --strict` and record what it still reports (it may fail only on § B lines J24
has not yet added — say which). Read its exit status directly, never through a pipe.

## Rules

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about.
- **Touch only** `plans/FS91-derivation.md`, `plans/M3-derivation.md`, the four derivation files item 3 names, `plans/FS86-derivation.md`, and
  your record `data/crunch-2026-09-25/j33-record.md`. **Never** `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, stubs,
  inventories (a front-page job, J24, is writing those), any job record, or any Lean file.
- Never change a statement, grade or verdict; format and missing fields only (item 4's grade text is J26's, quoted).
- **Commits by explicit path**, one per file, subjects "J33: <file> — format and fields for fs71 --strict"; end commit messages with your
  harness's attribution lines; push; never force-push.
- **Report** to `data/crunch-2026-09-25/reports/J33.md` (committed) and by SendMessage `to: "main"` in ≤ 12 lines: files fixed, the respelled
  ids, fields filled vs marked "not stated", and the checker's final output. Keep your turn's final text content-free: "J33 idle; report sent
  to the owner by SendMessage".
