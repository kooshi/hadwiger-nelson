# F1 — audit of `CLAUDE.md`'s git history for text compressed out (record)

*Job F1 of the 2026-09-26 documentation consolidation. Opus 5.5, as Coxeter (archivist). Brief:
`data/consolidation-2026-09-26/briefs/F1-history-audit.md` (+ `STANDING-RULES.md`). HEAD at launch: `d03df9a8` (E2's report).
Working files (read-only helpers and per-commit candidate lists): `data/consolidation-2026-09-26/f1/`.*

**Gates at launch** (exit statuses read directly): `claude_md_fact_audit.py --base d03df9a8` PASS; `--dupes` = 10 repeated runs;
`fs71_ledger_b_check.py --strict` PASS; `bib_audit.py` PASS; `check_architecture.py` PASS. `CLAUDE.md` 283,274 bytes;
`plans/GROKKING-INSTANCES.md` 9,599 bytes.

**Standard** (E1's brief, E2's report): *intrinsic* = a rule's statement, its reasoning (the *why*), a condition, a *Do* line, a killing
test, a demotion record, an entry's only example; *incidental* = a second or later instance, an incident story behind a rule already
stated. **My working classification of a removal:** *current-state* = a superseded claim replaced by its correction, a correction trail,
milestone narrative or history (dates, run times of a superseded attempt, search query words) — the header sends these to git, so they
are left; *compression* = text whose content was still current, cut or shortened to fit the byte budget — judged intrinsic or incidental.

## Method

`f1/lost.py <commit>` joins the hard-wrapped lines of `<commit>^:CLAUDE.md` into blocks, splits them into sentences, and for every sentence
the commit removed (under 60 % of its 5-word shingles left in `<commit>:CLAUDE.md`) prints how much survives today in (a) `CLAUDE.md`,
(b) + `LEDGER.md` + `plans/GROKKING-INSTANCES.md`, (c) + every `plans/*.md` and `data/**/*.md`. Candidates are the sentences with (a) < 0.5;
each is then read in place and judged by hand. `f1/removed_words.tsv` counts, for every commit touching `CLAUDE.md`, the words it
removed (multiset difference) and added. The detector is a finder, not a verdict: a sentence re-worded in full reads as "lost" (it is then
checked by hand), and a sentence whose words all survive elsewhere in the file reads as "kept" even if its sense went (the risk is
accepted: a cut sentence whose every 5-word run survives verbatim somewhere is rare).

## Stage 1 — SAVED

**The compression commits** — every commit that the history shows cutting text to a byte budget (the header's four raises, the commit
messages' own words, and a removed-words count), with `CLAUDE.md`'s bytes before → after and the words it removed:

| commit | date | bytes | words removed / added | why (from its message) |
|---|---|---|---|---|
| `c5e55f12` | 09-10 | 564,620 → 83,841 | 76,001 / 1,670 | "current state only" — the narrative cut (full narrative last at `fd658af`); audited once already by `724d4411`, `3b813df1` (09-12) and `6852a2ae` (09-15, the checkpointing rule) |
| `00923679` | 09-13 | 152,371 → 149,397 | 673 / 193 | the wall-breaking pass, under the 150,000 ceiling |
| `34464cba` | 09-13 | 149,388 → 149,695 | 2,071 / 2,044 | FS-38 close: "to stay under the ceiling, superseded narration came out of rows 64–65, G52, G31, G21, G53, G51's extension and the longest gate-failure paragraphs — every rule and every instance kept" |
| `fc2775f2` | 09-13 | 149,695 → 149,899 | 893 / 936 | "to hold the 150,000-byte ceiling … the September-12 gate narratives are compressed to their rules and G7, G21, G31, G46, G49, G51–G54 and rows 64–65 tightened" |
| `ce22f675` | 09-14 | 149,899 → 148,998 | 364 / 241 | the paths-forward mirror's low ranks collapsed (the "2026-09-14 trims") |
| `2f53a4ca` | 09-14 | 148,998 → 149,519 | 93 / 184 | FS-50 minted at the ceiling |
| `267b42f0`, `ece3905e`, `3779cb50`, `cf647b23` | 09-16/17 | 187,151 → 199,785 | 701 / 2,587 | closes at the 200,000 ceiling ("superseded Q(√167) detail trimmed from row 71") |
| `3bfdc209` | 09-21 | 239,632 → 249,994 | 153 / 1,716 | FS-66 close at 249,994 of 250,000 |
| `d0df4f82` | 09-21 | 246,496 → 242,682 | 768 / 109 | "trim ahead of FS-66's close … Narrative and correction trails out … no method rule's reasoning touched" |
| `f7f1433e`, `d6901249`, `f74ade25`, `d87fa955`, `10802f79`, `b441fb56` | 09-21 | 242,682 → 239,632 | 1,061 / 642 | the no-loss compression pass (A, W, B, C), fact-audited; measured floor ≈ 228k |
| `1f43ba40` | 09-22 | 272,577 → 272,208 | 87 / 11 | G56's two retellings of row 69 → pointers |
| `b1fc5bbc` | 09-22 | 272,208 → 211,073 | 8,852 / 41 | rows 1–75 extracted verbatim to `LEDGER.md` |
| `18ce5980`, `9ac6a758`, `df202277`, `de8bb61c`, `3dcb8de8`, `2ac6a338` | 09-24/25 | 247,561 → 274,896 | 3,147 / 6,720 | closes at the 275,000 ceiling; `de8bb61c` "compressed to budget … Compression without loss" |
| `0f4cf93a`, `15f5f37e` | 09-25 | 275,608 → 294,994 | 483 / 3,444 | J24 / J44 rewrites during the crunch (temporary 325k) |
| `179c6c5b` … `17a8602e` (J05 batches 1–7) | 09-25 | 296,413 → 283,826 | 2,334 / 332 | J05's no-loss compression pass (`data/crunch-2026-09-25/j05-record.md`) |
| `28caf446`, `dcf26687`, `f24b4f4e` (E1) | 09-26 | 299,491 → 281,823 | 2,715 / 66 | design (b): incidentals out to `plans/GROKKING-INSTANCES.md`; verified passage by passage by E2 — not re-audited here beyond the owner's two items |

Out of scope, with the reason: `93f3d2eb` (09-02, "scrub the low-level fault vocabulary … the record does not need its forensics") — a
deliberate removal of incident forensics before any budget existed; the G67 pass (09-22, seven batches) — additive (0–44 words removed a
batch); every other commit — under 60 removed words, or a close that rewrote its own rows to current state.
