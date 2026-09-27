# RF1 — the new program into the ranking (record)

*Job RF1, the front-page editor; Opus 5.5 (de Bruijn), 2026-09-26. Brief: `data/reframe-2026-09-26/briefs/RF1-ranking.md`, with
`data/fs105/briefs/STANDING-RULES.md` ("FS-105" read as "this job"). Base for the fact audit: `9ff8cc4a`.*

## Theorems this phase proved

None. This job is editorial: it moves rows, renumbers ranks and writes a banner. It proves nothing and grades nothing.

## Would have searched here

Nothing. No move in this job is a search.

## Stage 1 — SAVED (quotation check, standing rule 5)

Every quotation or near-quotation in the brief, checked against its source on disk at `0774956e`:

| the brief says | source | verdict |
|---|---|---|
| "FS-106, the regular half" | `plans/STUB-regularity-wall.md` heading "## FS-106 — the regular half (first)"; `CLAUDE.md` § The aim, "**FS-106, the regular half**" | match |
| "FS-107, regularity against pathology" | the stub's heading "## FS-107 — regularity against pathology (second; the competitor protocol)"; § The aim, "**FS-107, regularity against pathology**" | match |
| "its null-set step (C-FMT (d)) is now one sub-question of FS-107" | the stub's provisional bearings: "FS-104 (absorbed: the null-set step is one sub-question of FS-107)"; C-FMT (d) is the null-set step by `plans/FS103-M-derivation.md` §3.1 ("Question 2 — C-FMT (d), `χ_m⁰(ℝ²) = χ_m(ℝ²)`: **GAP**, reduced to a finite list-colouring problem on Falconer's null set") and `plans/FS103-derivation.md` FS103-M-D ("The null-set step (C-FMT (d), `χ_m⁰ = χ_m`) reduced, still a GAP") | match. **Note:** the stub says "absorbed" for FS-104 as a whole; the brief says only the null-set step folds and the other items stand. I follow the brief (the owner's later, narrower word), and the banner says so. |
| "Kooshi's adoption of the program (`CLAUDE.md` § The aim)" | § The aim: "**The direction: the regularity wall** (the owner's reading, 2026-09-26, adopted by Kooshi; each link at its grade)" | match |
| "bearing on χ ≥ 6" may read "bearing on the answer" | `CLAUDE.md` § Paths forward intro: "every row there is a full stub with its bearing on χ ≥ 6 stated honestly"; § Counter-priors rule 1: "**Rank a route by its bearing on the answer**" | match |
| "the aim, the counter-priors, 'Last updated' and 'Open milestones' are already written" | `CLAUDE.md` lines 74–135, 205, 340 at `0774956e` | match: all four name FS-106 and FS-107 |
| "FS105-X's lines are the precedent" | `tools/claude_md_fact_audit.py`: ALLOW block "# FS105-X, the front page of FS-105's close" and EXTERNAL_HOMES block of the same name | match |
| the budget suspended | the brief (Kooshi's ruling, relayed); `CLAUDE.md`'s header still says 300,000 | relayed, not checkable on disk; `CLAUDE.md` is 302,692 bytes at `0774956e` |

Baseline gate: `python3 tools/claude_md_fact_audit.py --base 9ff8cc4a` on the untouched tree: **AUDIT PASSED (0 failure(s))**, exit 0.

Baseline FS check on `plans/FRONTIER-STUBS.md` (a Python one-liner reading the ranked table and the closed list): 60 ranked rows, no FS
number twice in the ranked table, every FS-1 … FS-105 present in the ranked table or the closed list; FS-106 and FS-107 in neither.
