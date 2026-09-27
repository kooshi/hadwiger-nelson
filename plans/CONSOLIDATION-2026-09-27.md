# The consolidation and library run, 2026-09-27 — run record and inventory

*Opened by the product owner (the top-level session), 2026-09-27 16:00 UTC by the clock. The owner is its only writer; jobs send their items
to the owner, who logs them the same turn (WORKFLOW step 5's inventory rule, applied to a run that is not a milestone). Agent ids live only in
the owner's job log, never here.*

## Kooshi's words (verbatim, 2026-09-27)

*"Next I'll compact, then we'll do a consolidation / bookkeeping / library download and reading run, then the milestone you suggested unless
something comes up from the prior art. […] […] The archive is at `https://geombinatorics.uccs.edu/archive/index.php/home/issue/archive`.
[…] I'm sure you can still use it effectively. I got Johnson 2006 at
`/home/kooshi/Downloads/62-Article Text-324-1-10-20200330.pdf` from `https://geombinatorics.uccs.edu/archive/index.php/home/article/view/62/198`.
The goal of the run will be all of the low urgency items, and full reads of any important papers we haven't read yet, folding in their info.
Additionally, this whole journal is one of the most rich authorities on what we've been looking for, perhaps with the exception of where the
domain landed, but look around the recent articles for anything that might be useful."*

**The milestone after this run:** FS-112, the unit-arc half (`plans/STUB-unit-arc-half.md`, rank 1), unless the prior art changes it.

## The archive, and the fetch rule

- **Access.** The archive is an Open Journal Systems site behind a Cloudflare browser check that refuses plain HTTP clients (403 "Just a
  moment…"). `tools/geomb_fetch.sh` (e11db724) drives the desktop's Chrome headless through Playwright (venv `build/venv-geomb`, regenerable),
  passes the check and downloads through the browser. Checked: Johnson 2006's galley downloads byte-identical to Kooshi's copy.
- **Shape of the archive.** 142 issues, July 1991 (vol. 1 no. 1) to July 2026 (vol. XXXVI no. 1). Issues up to about 2021 are listed as one
  "article" per issue whose galleys (one per paper) did not list for the tool; every issue has a full-issue
  galley, which is what the run downloads. Old issues are image scans, two journal pages per landscape sheet, no text layer; recent issues are
  born-digital with a text layer. No OCR tool is installed: scans are read by rendering pages (`pdftoppm`) and viewing them.
- **The fetch rule (owner, 2026-09-27).** Jobs run the wrapper and never read `.env`, print their environment, or edit the fetcher.

## Held in the library (`~/source/library/`)

| file | what | source |
|---|---|---|
| `pdf/johnson-2006-coloring-rational-points-forbid-distance-one-geombinatorics-16-1-209-218.pdf` | `[Johnson2006]`, 6 sheets (pp. 208–219), image scan; sha256 9b567210… | Kooshi's download |
| `geombinatorics/geombinatorics-v09-n3-2000-01.pdf` | vol. IX no. 3 (January 2000), full issue, 28 sheets: `[BendaPerles2000]` pp. 113–126 and Johnson's introduction pp. 110–112 | archive, issue 35 |
| `geombinatorics/geombinatorics-v09-n4-2000-04.pdf` | vol. IX no. 4 (April 2000), full issue, 28 sheets: `[Johnson2000]` pp. 170–179 | archive, issue 36 |
| `geombinatorics/geombinatorics-v14-n4-2005-04.pdf` | vol. XIV no. 4 (April 2005), full issue, 32 sheets: `[Townsend2005]` pp. 184–193 | archive, issue 56 |
| `geombinatorics/geomb-issue-<issue>-<galley>.pdf` | the 45 full issues from vol. 25 no. 2 (October 2015) to vol. XXXVI no. 1 (July 2026); the issue ids and titles are in the walk's catalogue | archive, issues 98–150 |

## Jobs

| job | brief | touches | state |
|---|---|---|---|
| **LP** — the papers | `data/consolidation-2026-09-27/briefs/LP-papers.md` | `BIBLIOGRAPHY.md` (its papers' entries, § R), `CLOSED-QUESTIONS.md`, `LEDGER.md` (claim list and novelty sentences), `plans/STUB-regular-half-residuals.md`, library notes; `CLAUDE.md` by draft only | launched |
| **LW** — the archive walk | `data/consolidation-2026-09-27/briefs/LW-archive-walk.md` | `~/source/library/geombinatorics/`, `BIBLIOGRAPHY.md` (a new section), its record; everything else by draft | launched |
| **BK** — the bookkeeping | `data/consolidation-2026-09-27/briefs/BK-bookkeeping.md` | `CLAUDE.md` (§ Where the problem stands items 28–30 only), `plans/FRONTIER-STUBS.md`, the 26 stub files of `plans/RERANK-2026-09-27.md` § 3, `plans/FS110-derivation.md`, `LEDGER.md` § B, the FS-106/107/110 inventories' status cells | launched |

## Items

| # | kind | item | source | status |
|---|---|---|---|---|
| 1 | owner ruling | `.env` made git-ignored before any use (1797700a); the fetcher committed (e11db724) with no credential in it | owner | done |
| 2 | owner ruling | Johnson 2006 filed (identity checked from the rendered first sheet: title, author, pp. 209 ff.); the three old issues and the 45 recent ones filed under `~/source/library/geombinatorics/` | owner | done |
| 3 | owner question | For Kooshi: does S–V Question 2's Condition-5 half (row 134) get a `CLOSED-QUESTIONS.md` row (the owner recommends yes, as a partial answer)? Does MR in full in Lean get its own stub? | RK §4; FS-110 report | asked |
