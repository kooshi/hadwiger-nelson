*Brief for crunch job **J24a**: the front-page pointers (a small front-page-lane job, ahead of the closes). Opus 5.5, 2026-09-25.
Written by the product owner.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`,
`WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.**
I'm the product owner; I coordinate and review by artifact.

**If your record already exists, you are resuming:** read it and this brief, check the last SAVED stage against
`git log -- data/crunch-2026-09-25/j24a-record.md`, and continue at the first stage not SAVED.

## Why

Kooshi asked for the day's work to be easy to find from related things. The bookkeeper (J30) built the index
`plans/CRUNCH-2026-09-25-INDEX.md` and wired pointers into the stubs and plans, but it may not edit the four front-page files —
`CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md` — which are the front-page lane's alone. It wrote the edits they
need as proposals, in the index's §5.1 (rows C1–C4, L1–L4, F1–F3, B1–B8). You are the front-page lane for this one job. Right now
`CLAUDE.md` says "**Open milestones, in order.** **None is open.**" — false since the crunch opened three — and `tools/bib_audit.py`
reports 11 cited keys undefined.

## What to apply — pointers and state only, never results

Blind verifiers are running and read `CLAUDE.md` and `plans/FRONTIER-STUBS.md` from disk. So **no result, verdict, number or statement
from the crunch enters any front-page file in this job**; those arrive at each milestone's close. Apply:
- **C2** (the open-milestones line) and **F1**, **F2**, **F3** — state and address pointers. Read each proposal in §5.1 and check it
  against the file's current text first.
- **C1 only if** it says something C2 does not (one home per fact: `CLAUDE.md`'s header rule); otherwise decline it with that reason.
- **B1–B8** — the bibliography entries, so that `tools/bib_audit.py` passes: add each held paper's entry with its key, full reference,
  library path, what of ours cites it, and an **honest read status** taken from the record that read it (a paper read at its abstract is
  "abstract only"; never upgrade a read status). Two notes of mine:
  - Kooshi fetched R. B. Eggleton, P. Erdős, D. K. Skilton, "Colouring the Real Line", *J. Combin. Theory Ser. B* **39** (1985) 86–100,
    now at `~/source/library/pdf/EggletonErdosSkilton1985-colouring-the-real-line.pdf` (a scan). The existing 1990 key is a different
    paper by the same authors, "Colouring prime distance graphs", *Graphs and Combinatorics* **6** (1990), DOI 10.1007/BF01787476 —
    not held. Give each its own entry, and correct any entry or citation that conflates the two.
  - Where the keys `[GoelPatilVerma2022]` and `[KechrisMarks2020]` are cited, their papers are held (see the index §1 and §5.1).
- **L1–L4 only if** each is an address-only pointer carrying no new result; otherwise decline it for the milestone's close, with that
  reason.
- **Not now:** C3, C4 (trust and vacuity counts — M2's close, after its last kernel job), and anything that states a result.

## Gates

- `CLAUDE.md`'s budget is 300,000 bytes (it stands near 275,000). Never touch a `[PROTECTED]` paragraph, or a grokking's *Do* or killing
  test.
- After any `CLAUDE.md` change: `tools/claude_md_fact_audit.py --base <FS-89's closing commit>` (find it: the latest commit in
  `git log --oneline -- plans/FS89-close-inventory.md`) must pass, and `--dupes` must read 11.
- `tools/bib_audit.py` must pass. If you touch `LEDGER.md`, `tools/fs71_ledger_b_check.py --strict` too.
- Read each gate's exit status from the gate itself, never through a pipe.

## Rules

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved stage and tell me what is left.
- **Touch only** the four front-page files and your record `data/crunch-2026-09-25/j24a-record.md` (a short log: each proposal applied
  or declined, with the reason, and each gate's result). Not `ARCHITECTURE.md` or any Lean file (a kernel job is in flight), not the
  index, not any plan or stub.
- **Commits by explicit path** (`git diff -- <path>` first; `git commit <paths> -m …`, never a bare `git commit`). Subjects
  "J24a: …". End commit messages with your harness's attribution lines. Push after committing; never force-push.
- **No finite-witness search** (the ban to 2026-10-01) — none is needed.
- **Budget:** about 150k by the harness's count.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J24a.md`, committed, and sent to me by
  SendMessage `to: "main"`. Keep your turn's final text content-free: "J24a idle; report sent to the owner by SendMessage".

Thank you.
