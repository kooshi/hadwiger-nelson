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

## Stage 2 — SAVED

### 2.1 The change (`tools/fs71_ledger_b_check.py`)

- **How the grammars are told apart: per entry, not per file.** Every derivation file is read by both parsers and the results are
  merged (`read_file`, which `load()` now calls). A file may hold both grammars. An id defined twice fails, whether within the older
  grammar (a new check; the dict used to keep one of the two in silence, and today's tree has no case), within the new one, or across
  the two.
- **The new grammar is read with the gate's own parser.** `.claude/skills/ephodos/scripts/derive_gate.py` is imported, and its
  `strip_fences`, `blocks`, `HEAD`, `HEAD_LOOSE`, `unread_heads` and `STRICT` are used as they stand. So the census reads exactly what
  the gate reads. If the gate cannot be imported, the run prints a FAIL and exits 2; it never falls back to the older grammar alone.
- **What counts, and what is noted.** Each `derivation:` block is one entry. A `control:` block is not. A `verification:` or
  `invention:` block, or a `derivation:` header inside a code fence, is not counted but is printed as a `note:` line. A header the gate
  cannot read (for example a capital letter, bold, or a trailing note) FAILS the run, as a malformed older header does.
- **The census line is unchanged.** One extra line, "of which in the new grammar (`derivation:` blocks): …", prints only when
  new-grammar entries exist. So today's output is byte-identical.

### 2.2 The field mapping, the id rule and the "rests on" check (the address the closes' evidence cites)

**The id rule** (`full_id`, one function for both grammars, unchanged from the older code): a name containing a hyphen stands as
written; a bare name inherits the file's prefix. So `derivation: N8` in `FS99-derivation.md` is counted as `FS99-N8`, while
`derivation: N7-3T` is counted as `N7-3T`. When an unmatched entry `X` and an unmatched § B row `<prefix>-X` both exist, the run prints
both FAILs and then a `hint:` telling the writer to qualify the header.

**What `--strict` requires of a new-grammar entry.** This is what the gate makes mandatory, checked for presence and a non-empty value.
The gate itself lints the values.
- `statement:`, `argument:` and `verdict:` always.
- With verdict exactly `derived`, also `uses only:`, `not claimed:`, `grade:`, `minds:`, `model:`, `prior art:` and `handoff:`.
- `converse:` as well, when the statement is strictly two-way (the gate's `STRICT` words).
- **Prose naming what rests on it.** The run looks for the words "rests on" in the text between the entry's block and the next
  `derivation:` header or markdown heading. A paragraph opening "Rests on it: …" satisfies it. If "rests on" appears only inside the
  block, as an indented line the gate folds into the field above it, the FAIL says so.

Without `--strict`, each of these is a `warn:` line, as the older fields' absences are.

**The mapping from the old five fields:** *Proof:* → `argument:`; *Proof verdict:* → `verdict:` (with `minds:`); *Prior art:* →
`prior art:`; *Kernel:* → `handoff:`; *Rests on it:* → no field, so the prose check above.

**The finding on *Rests on it*** (the brief's question). The new grammar has no field for it. The lane file asks for it "in prose"
and fixes no marker. The gate silently folds an indented `rests on it:` line into the field above it (tested, §1.3). So the census
cannot read this obligation exactly. What it now does is the nearest honest reading: it requires the lane file's own words, "rests
on", in the prose under each entry. **The right fix is outside this checker, in `.claude/agents/ephodos.md` § The close job**, which
Keryx writes. Draft for Keryx, to replace the bullet "Under each entry, in prose, write what rests on it.":

> - Under each entry, after its block's blank line, a prose paragraph opening "Rests on it:" names what rests on it (the census,
>   `tools/fs71_ledger_b_check.py --strict`, requires the words "rests on" there; an indented `rests on it:` line inside the block
>   is not a field of the grammar, and the gate folds it silently into the field above it).

A field in the grammar itself (for example `rests on:`) would be the exact fix. But the grammar is the identity's upstream skill,
copied verbatim from `~/source/agent-forge` and held to it by `scripts/identities.py check`, so that is Kooshi's call and not
something to draft here.

### 2.3 The regression run, beside the baseline

| run | baseline (stage 1, `1a2d6020`, 16:44) | after the change (`673b400b` + this change, 16:53) |
|---|---|---|
| `--strict` | exit 0; "census: 1003 theorems in 72 derivation files"; "LEDGER § B rows: 1003 \| placeholders: 0"; PASS | **byte-identical** (`diff` empty): exit 0, the same three lines |
| plain | exit 0; PASS | **byte-identical** |
| `--self-test` | exit 0 | exit 0, 31 cases true, 0 false |

Files: `data/workflow3/tb1/{baseline,after}-{strict,plain}.txt`, `after-selftest.txt`.

### 2.4 The extended self-test

**The existing test, tightened without loosening anything.** Its census plants now pass only on exactly the expected count (`n ==
expect`, where it was `n >= 3`). The "unplanted id check clean" line it prints now counts in its verdict. Both still pass on today's
tree.

**The new-grammar plants** (`self_test_new`). Each one runs alone beside the faithful entry `FS99-N0` (with a control block), through
the same `read_file` → `parse_ledger_b` → `check` path the real run takes. Every line printed must fullmatch exactly one expected
pattern, and every pattern must match exactly one line. So each plant is seen to fire, to fire once, and for its own reason, and a
stray line anywhere turns the case red.
- **The four the brief names:**
  - a new-grammar entry with no § B row;
  - a § B row whose entry is missing;
  - an entry lacking `model:`, in both modes: FAIL under `--strict`, and a `warn:` with zero failures without it;
  - the faithful entry alone, which must print nothing.
- **Beside them:**
  - no "rests on" prose;
  - `rests on it:` indented inside the block;
  - a header the gate cannot read;
  - a hyphenated bare name beside a prefixed row, where the hint must print;
  - a bare name without a hyphen, which must pass;
  - `verification:`, `control:` and a fenced `derivation:`, which must produce notes only;
  - an id twice in the new grammar;
  - an id in both grammars;
  - a stalled entry with only statement, argument and verdict, which must pass;
  - a derived "if and only if" with no `converse:`;
  - a field loop that drops each field of **the gate's own list** (`FIELDS["derivation"]`, converse aside) one at a time.
- **The gate as the second judge.** On the cases that carry a gate expectation, the self-test runs the gate
  (`derive_gate.py entries`) on the planted file:
  - The faithful file passes it (exit 0), so the plant is the new grammar and not my reading of it.
  - Every missing-field plant fails it (exit 1), so "mandatory" is the gate's word, field by field.
  - The stalled entry passes it.
  - Both "rests on" plants pass it, which is exactly why the census must check them itself.

**The negative controls** (`data/workflow3/tb1/mutate.py`, output `mutate-run.txt`, exit 0). Twelve mutations of the checker are
compiled in memory under the real path, so nothing on disk changes and nothing needs restoring. Each must turn the self-test red and
fail the case it breaks, and all twelve do. The unmutated source is green. Then an end-to-end run of `load()`/`main()` over a scratch
tree holding one new-grammar derivation file, with the shipped gate:
- `--strict` and plain both exit 0 and print "of which in the new grammar (`derivation:` blocks): 2 in 1 files: FS99=2";
- with one § B row removed, the run exits 1, naming that entry.

**One defect the harness found in my own control, fixed.** The field loop first iterated over the checker's own constant
(`NEW_ALWAYS + NEW_DERIVED`). The mutation "drop `model:` from the derived list" therefore removed the model case along with the model
requirement. The self-test still went red, but only through the explicit `model:` case, so the loop was blind to it. It now iterates
over the gate's list, and the mutation turns the loop's own model case red. This is `CLAUDE.md` § Make the gate fail's "a check must
read the value the code SHIPS, never a copy of it", met from the other side: a control must not read its expectations from the code
it tests.

### 2.5 What the self-test does not see

- It checks that fields are present, not their values; the gate lints the values.
- The "rests on" check is a word match. It cannot tell a sentence that names what rests on the entry from one that merely uses the
  words.
- The region the check reads ends at the next `derivation:` header or heading. So a file that gathers every entry's "rests on" prose
  in one later section would fail every entry. That is the right verdict under the lane file's "under each entry", but a reader should
  know where the region ends.

## Stage 3 — SAVED

### 3.1 The survey: other tools that read `plans/*-derivation.md` entries by their older shape

**Method.** I grepped every file in `tools/` and `scripts/` for the derivation-file path, for the older header regex (a bold span
opening a line), for the five italic field labels, and for globs over `plans/`. Then I read each hit's reading code. Most hits are
mentions in docstrings or comments.

**Result: no other tool parses derivation-file entries by the older shape.** `tools/fs71_ledger_b_check.py` is the only reader of
entries (the only glob over `plans/*-derivation.md` and the only `ENTRY_RE`). The tools that do read derivation files read them as
text, and here is what each would miss in a new-grammar file:

| tool | what it reads | what it would miss in a new-grammar file |
|---|---|---|
| the quote checkers: `tools/fs110_nb_quotes.py`, `fs112_y_quotes.py`, `fs112_y3_quotes.py`, `fs112_yb3_quotes.py`, `fs114_n_quotes.py`, `fs114_n3_quotes.py`, `fs114_n4_quotes.py`, `fs114_n7_quotes.py`, `fs114_y_quotes.py` … `fs114_y6_quotes.py`, `fs114_l60_quotes.py`, `crunch_j27d_quotes.py` | a verbatim quotation, found as a substring after collapsing whitespace, in a fixed older file (`FS110-`, `FS112-`, a crunch brief) | nothing. Collapsing whitespace absorbs the grammar's indented continuation lines. `fs114_l60_quotes.py` anchors quotes by line number, and one quote is FS112's literal "Rests on it: …" line; both suit its fixed older target and would not carry over to a new file, but no one points it at one. |
| `tools/claude_md_fact_audit.py` | a "home" file's normalised text, for a token's presence | nothing: it reads tokens, not grammar |
| the Proof Atlas (`tools/viz_proof_atlas_common.py`, `_facts.py`, `_check.py`) | `LEDGER.md` § B rows, CLAUDE.md sections, grokkings, Lean declarations | nothing: it has no address form for a derivation entry in either grammar |
| `tools/viz_local_global_map_common.py` | `LEDGER.md` § B's grade column, folded by keywords | not a derivation-file reader, but a consumer of the § B lines a close drafts from new-grammar entries. Its fold reads "hand", "tools", "cert", "derived", "two derivations", "one mind" and similar words. A § B grade copied verbatim from a `grade: computed over: …` field matches none of them and folds to **open**. The lane file's translation table ("`computed over: <set>`" → "[tools]") prevents this, but only if it is followed. |

### 3.2 Findings for the coordinator

1. **Hyphenated bare names.** Under the older id rule `derivation: N7-3T` is counted as `N7-3T`, not `FS114-N7-3T`. Reported
   mid-flight; the coordinator amended both close briefs (`7ed60495`). The checker prints a hint when it sees the pair.
2. ***Rests on it* has no field in the new grammar, and the gate silently folds an indented `rests on it:` line into the field above
   it.** The checker now requires the words "rests on" in the prose under each entry. A draft replacement for the lane file's line is
   in §2.2, for Keryx to file. A true field in the grammar would be Kooshi's call, because the skill is upstream.
3. **The gate's folding is general, not special to *Rests on it*.** Any indented `key: value` line whose key is not a field of the
   block is appended to the previous field's value, with no warning. So a misspelled field (`prior-art:`, `hand off:`) is absorbed,
   not flagged. `derive_gate.py` documents the behaviour ("an indented line whose key is not a field of the block continues the
   previous field's value"), so it is a design choice upstream. It is also a silent path of the kind `CLAUDE.md` § Make the gate fail
   warns about. For Kooshi's upstream skill; not changed here.
4. **§ B lines drafted from new-grammar grades must use the project's words**, or the local–global map folds them to "open" (§3.1).
5. **The existing self-test's two weaknesses, fixed in stage 2**: `clean` was outside the verdict, and the count check was one-sided.
6. **My own control defect, found by the mutation harness and fixed before commit** (§2.4): the field loop read the constant under test.

### 3.3 What is left

Nothing in this job's scope. The closes run `--strict` on a scratch copy with their drafts applied (their briefs say so); the checker
and its evidence are at `95efed69`.
