# TB1 — the ledger's census checker learns the new derivation-file grammar (job record)

*de Bruijn (Opus 5.5), 2026-09-28, from the brief `data/workflow3/briefs/TB1-ledger-check.md` and its standing rules
`plans/STANDING-RULES.md`. A tooling job: `tools/fs71_ledger_b_check.py` is the only code it changes.*

## Theorems this phase proved

None. A tooling job proves no theorem.

## "Would have searched here" log

None. The job has no search move; every check is an exact reading of files on disk.

## Stage 1 — SAVED

### 1.1 The readback of the brief

The job: `tools/fs71_ledger_b_check.py` is the bridge between the derivation files `plans/*-derivation.md` and `LEDGER.md` § B. It
reads only the older entry shape, so an entry in the new grammar (`derivation: <id>` blocks, `.claude/skills/ephodos/SKILL.md`
`<the_entry>`) is invisible to it, and every § B line the FS-114 and FS-111 closes add would fail as having no derivation entry. Done
means: the checker reads both grammars, counting a new-grammar entry under its file's prefix by the older id rule; `--strict` holds a
new-grammar entry to the fields that grammar makes mandatory, with the mapping from the old five fields named here; today's run reads as
it does now; the self-test gains new-grammar plants, each firing once for its own reason beside a faithful entry that passes; a survey of
every other tool reading the older shape, reported and not fixed; and the report.

**Quotations checked against their sources** (standing rule 3):

| the brief's quotation | source | result |
|---|---|---|
| the older header "`**<id> — <title>. [<grade>; <prover>]**` with the fields *Proof:*, *Proof verdict:*, *Rests on it:*, *Prior art:*, *Kernel:*" | the checker's docstring, lines 4–5: "one `**<id> — <title>. [<grade>; <prover>]**` paragraph per theorem, with the fields *Proof:*, *Proof verdict:*, *Rests on it:*, *Prior art:*, *Kernel:*" | FOUND |
| "has no derivation entry" | the checker, `check()`: "FAIL: LEDGER.md § B row {k} has no derivation entry" | FOUND |
| the lane file asks for *Rests on it* "in prose under each entry" | `.claude/agents/ephodos.md` § The close job: "Under each entry, in prose, write what rests on it." | FOUND (the brief paraphrases outside quotation marks; the sense holds) |
| "Files written before 2026-09-28 keep their older shape" | `.claude/agents/ephodos.md` § The close job: "Files written before 2026-09-28 keep their older shape; they are history." | FOUND |
| "a qualified id such as `FS114-N7-3T` stands; a bare one inherits the prefix" | the checker's docstring: "an entry written as a bare `**T3 — …**` inherits the file's prefix"; `parse_entries`: "A bare id like `T3`, `W`, `L1`, `D2-A` inherits the prefix; a qualified one (`FS70-T3`) stands." | FOUND — but see the finding below: the older rule treats *any* name containing a hyphen as qualified |
| "`control:` blocks are not entries" | `SKILL.md` `<the_entry>`: entries are `derivation:` blocks; `control:` is its own block kind | FOUND |
| the baseline "census: 1003 theorems in 72 derivation files" and "LEDGER § B rows: 1003 \| placeholders: 0", exit 0 | my run, 2026-09-28 21:44 UTC, HEAD `1a2d6020`, `data/workflow3/tb1/baseline-strict.txt` | REPRODUCED, exit 0 |

**A slip in the brief:** it says the baseline was "taken 2026-09-28 21:55 UTC"; the brief was committed at 16:43 (`1df7db6a`) and my
reproduction ran at 16:44, so 16:55 cannot be the time it was taken. The numbers reproduce, so nothing rests on it.

### 1.2 The two grammars, read

**The older one** (the checker's `ENTRY_RE`; `plans/FS112-derivation.md` as the live instance): a bold header line
`**<id> — <title>. [<grade>; <prover>]**`, then a prose paragraph carrying the five italic field labels. The census is the set of
headers; `--strict` checks each label's presence in the entry's body (the text up to the next header, cut at the next `## `).

**The new one** (`SKILL.md` `<the_entry>`, its grammar fence; `scripts/example-clean.md`, `scripts/example-verification.md`; the gate
`scripts/derive_gate.py`, whose `HEAD`, `KV`, `FIELDS`, `blocks()` and `strip_fences()` are the grammar as executed): a line
`derivation: <one token>` at column 0 (a leading `- ` allowed), then indented `field: value` lines, a value continuing on further
indented lines; a blank or unindented line ends the block. Headers inside a code fence are not blocks. Four block kinds exist —
`derivation:`, `control:`, `verification:`, `invention:` — and only `derivation:` is an entry. The gate's mandatory fields
(`check_entries`): **every** entry needs `statement:`, `argument:`, `verdict:`; a **derived** one (verdict exactly `derived`) also needs
`uses only:`, `not claimed:`, `grade:`, `minds:`, `model:`, `prior art:`, `handoff:`, and `converse:` when the statement is strictly
two-way (the gate's `STRICT` words) — where "needs" means the gate fails without it.

**The mapping from the old five fields** (for the record the brief asks for):

| old field | new-grammar home | note |
|---|---|---|
| *Proof:* | `argument:` | an address; the gate resolves it from the file's own folder |
| *Proof verdict:* | `verdict:` (with `minds:` for who checked it) | the old field held the checking mind's verdict in prose; the new grammar splits the verdict from the count of minds |
| *Rests on it:* | **no field** | the lane file asks for it "in prose" under each entry |
| *Prior art:* | `prior art:` | `new` must name two counted queries |
| *Kernel:* | `handoff:` | the lane file: "each derived entry's `handoff:` field is its kernel decision" |

### 1.3 Findings so far (sent to the coordinator at once, since the two closes are writing now)

1. **A hyphenated bare name will not meet its § B line.** The older id rule (which the brief asks me to keep) lets any name containing a
   hyphen stand as written: that is why `plans/M2-derivation.md`'s `J17-T1` is counted as `J17-T1` and § B keys it so. The close briefs
   say "key each § B line by its entry's qualified id, `FS114-<name>`" (`data/fs114/briefs/C114-close.md`). So `derivation: N7-3T`
   would be counted as `N7-3T` and its § B line `FS114-N7-3T` would fail twice, once from each side. A name with no hyphen (`DENSE3`)
   inherits the prefix. The remedy is at the writer: qualify every header, `derivation: FS114-N7-3T`. The checker will say so when it
   sees the pair (a hint line, stage 2).
2. **The new grammar has no *Rests on it* field, and an indented `rests on it:` line is silently misread by the gate.** The gate's
   `blocks()` folds an indented line whose key is not a field of the block into the previous field's value. Tested: an entry ending
   `handoff: none — r` then `rests on it: C114-X` is read with `handoff = "none — r rests on it: C114-X"`, and no warning. So the prose
   must sit under the block, after its blank line, as the lane file says. The checker (stage 2) will look, under `--strict`, for the
   words "rests on" in the prose between an entry's block and the next `derivation:` header or heading, and name the folded-field shape
   if it finds it inside the block instead.

### 1.4 The baseline, reproduced

At HEAD `1a2d6020`, 21:44 UTC, `tools/fs71_ledger_b_check.py` sha256 `f6d547b4ecb39d91…`, `LEDGER.md` `9a393e976c80f6d6…`:
`--strict` exit 0, "census: 1003 theorems in 72 derivation files", "LEDGER § B rows: 1003 | placeholders: 0", "RESULT: PASS"; plain
exit 0; `--self-test` exit 0 (six header plants fire, the three census plants report 3 failures). Saved in full:
`data/workflow3/tb1/baseline-{strict,plain,selftest}.txt`. No file under `plans/` holds a new-grammar block today (a grep for
`^derivation:` finds two prose lines, in `plans/M3-S1A-rank-one.md` and `plans/STUB-consume-rotation-list.md`, neither a derivation
file and neither a header the gate reads: each has more than one token after the colon).

**Two weaknesses in the existing self-test**, to be tightened in stage 2 without loosening anything: its verdict ignores the
"unplanted id check clean" line it prints (`clean` is not in the returned conjunction), and its census plants pass on `n >= 3`, a
one-sided bound that cannot see a plant firing too much.
