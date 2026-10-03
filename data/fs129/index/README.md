# FS129-IX1 — the index: record

*The Clerk, Sonnet 5.5, 2026-10-03. Brief: `data/fs129/briefs/FS129-IX1-index.md`. Script: `tools/fs129_index.py`. Everything below is read from files by that script or by the commands shown; nothing is judged.*

## Stage 1 — SAVED (readback, script, self-test)

### The readback

The brief's two quotations were checked against their sources by exact substring comparison (read as one line, line breaks joined):

| quotation in the brief | source | result |
|---|---|---|
| Kooshi 2026-10-03, "Right after this close, we'll be refining the workflow again... File that as a special case stub for after the workflow refinements." | `plans/STUB-cross-application-audit.md` § The request (line 9) | identical |
| Kooshi's four answers, "1. yes, we don't want O(N^2) here. … so it'll pick up the latest changes." | `plans/FS129-cross-application-audit.md` § 1 (the decisions block) | identical |

No mismatch. One small finding about the brief: it cites the second quotation's source as `§ 1. Kooshi's words`; the section is headed `## 1. Kooshi's words`, so the address is right.

**What `edges.csv` must contain, in my words.** One row per ordered pair (Y, X) of theorems such that X uses Y, so the edge points from the used result to its user (from "what is upstream" to "what is downstream"). A pair is there if X's `uses only:` line names Y (source `uses`), or if Y's "Rests on it" paragraph names X (source `rests`), and `both` if the two records agree. Where one direction says it and the other direction's text exists and omits it, the pair is still an edge (it has one source), and is also listed in `disagreements.md`. Only ids that resolve to an entry make an edge; everything else is in `unresolved.md`.

**What `lean-order.md` must contain.** The theorems whose `handoff:` field names de Bruijn (the results whose next stop is Lean), and every theorem they depend on, directly or through any chain of edges, in one list ordered so that each theorem stands after every theorem it uses. A dependency cycle is printed with its members together and flagged, never silently broken.

### The corpus recount

The plan's § 2 commands, run 2026-10-03 on commit `c791976a6c`'s tree:

| pile | plan's count | recount | note |
|---|---|---|---|
| `ls plans/*-derivation.md \| wc -l` | 99 | 99 | same |
| `awk 'NR>=195' LEDGER.md \| grep -cP '^\s*[-\|]'` | 1,297 | 1,297 | the 1,297 lines are 1,295 theorem rows plus the table's header line and its `---` line; the census finds 1,295 § B rows and 1,295 entries |
| `cat plans/*-derivation.md \| grep -cP '^derivation: '` | 292 | 292 | same; the census reads 292 new-grammar entries in 5 files (FS111, FS114, FS116, FS121, TC1) |
| `grep -oF 'Rests on it' plans/*-derivation.md \| wc -l` | 1,304 | 1,304 | same; in 78 files (`grep -lF`, 78) |
| files with no "Rests on it" | 21 | 21 | same |
| `handoff:` lines naming de Bruijn (the plan's grep) | 77 | 77 | the script's field-based count is 78: see CHECK 1 |
| ledger rows | 148 | 148 | `## A.` has 148 `\| N \|` rows |
| grokkings | G1–G91 | 91 | `^\* \*\*G\d+ — ` headers, G1 to G91 with no gap |
| derivation files holding at least one entry | — | 77 (of 99) | `fs71_ledger_b_check.py`'s census; the other 22 files hold no entry in either grammar |

### Resolution rules and encodings the script fixed (what is mine to decide)

- **An id.** Every entry's id is the census's `full_id` (a name with a hyphen stands as written, a bare one takes the file's prefix). Ids are unique corpus-wide; a duplicate is a failure of the run (exit 1), the first is indexed and the second dropped. The run found none.
- **A token in `uses only:` or a "Rests on it" paragraph resolves** in this order: (1) it is exactly an entry id; (2) `<prefix of the file the text sits in>-<token>` is an entry id (a bare `T3`, `V5-RING`); (3) otherwise it does not resolve. A token that is the tail of some entry id (`C-HULL` for `FS111-C-HULL`) is **not** resolved: choosing it would be a guess, so it is printed beside the token in `unresolved.md` as a "suffix candidate", with every candidate id.
- **What counts as an id-shaped token** for `unresolved.md`: a token beginning with a milestone prefix and a hyphen (`prefixed`); another capitalised hyphenated name (`hyphenated`: claim names, constants, shorthand); a short bare token like `T3`, `R7` (`bare`; `G<n>` excluded); a milestone pointer like `FS-126` (`milestone`). A token that is a file name (ends `.md`, `.py`, …, or follows a `/`) is skipped. Ordinary words never count.
- **Rows and grokkings in `uses only:`** are *not* graph nodes. The numbers after `row`/`rows` are kept in the record's `uses_rows`, the `G<n>` tokens in `uses_grokkings`; the raw text is in `uses_raw`. **Lean declarations**: none occurs in any `uses only:` line (checked: no `Proofs/`, `.lean`, `HadwigerNelson`, `Mathlib`, `Lean` in any), so there is nothing to represent and none is.
- **The "Rests on it" paragraph.** New grammar: the text from the first "Rests on it" in the prose between the entry's block and the next heading or `derivation:` header, to the end of that paragraph (blank line); old grammar: the text of the `*Rests on it:*` field up to the next of the five markers. `rests_form` records `label`; a fallback to the phrase "rests on" with no "it" exists in the script and fired for no entry.
- **Old-format entries** (1,003): `statement` is the text between the header and `*Proof:*`; `title` is the header's title; `grade` is the header's bracket, verbatim (it carries the prover and the verdict words, so `minds` is left empty, never read from it); `verdict` is the `*Proof verdict:*` field; `kernel` is the `*Kernel:*` field; `not_claimed`, `uses_raw`, `handoff` are empty (no such field). `verdict_class` is the verdict's first word lower-cased (old verdicts begin with `closes`, `TRUE`, `the`, …; open-steps takes a class of `gap`, `stalls` or `refuted` only).
- **Era.** M<n> prefixes, and FS<n> with n ≤ 103, are `A`; FS<n> with n ≥ 104 is `R`. A prefix with no number (`ASTRA-2026-09-14`, `MASCOT`, `R52`, `R57`, `R59`, `R88`, `TC1`) is placed by the § B milestone column only if that holds `M<n>` or `FS-<n>`; those columns hold dates, `row 88` or `TC1`, so all of those are `CHECK`. (§ B is one flat table, not sections; the milestone column is the placement it offers.)
- **Citations.** A ledger row cites a theorem when the row's text (§ A) contains its id as a whole token; likewise a grokking's entry text. A theorem *mentions* a grokking when the token `G<n>` is anywhere in its entry text (`mentions_grokkings`); `grokking-uses.md` is built from mentions.
- **Output encodings.** `theorems.jsonl`'s first line is a `{"_header": …}` object and `edges.csv`'s first line begins `#`; consumers skip them. The `.md` files carry the header as an HTML comment on line 1. Extra files beyond the brief's list: `cycles.md` (the dependency cycles), `checks.md` (every CHECK the script raised), `statements-CHECK.md` (the statements of era-CHECK theorems, which the two era files would otherwise drop).

### The tool and its negative controls

`python3 tools/fs129_index.py --self-test` plants, in memory, beside a clean corpus of two new-grammar and two older-grammar entries: an entry with no statement, a `uses only:` id that resolves to nothing, a dependency cycle, an id defined in two files, a header the census rejects, a disagreement, an unplaceable era, the era boundary FS103/FS104, and a cycle among handed-off results. Each plant fires once and for its own reason; the clean corpus is indexed field by field (each field compared with its expected value) with no defect and no unresolved token; exit 0, `RESULT: PASS`.

The test's own sensitivity: six mutants of the script (duplicate-id detection off, cycle detection off two ways, no-statement off, unresolved listing off, census-failure capture off) each made `--self-test` print `False` for the matching plant and exit 1; the mutant files lived in the session scratch directory, not in the repository. The first run of the self-test also caught one flaw in my own plant (an era plant that the planted ledger's milestone column placed after all), fixed in the test, not in the script.
