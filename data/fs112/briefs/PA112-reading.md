*Brief for job **FS112-PA**, FS-112's reading job (phase P0). Opus 5.5. Written by the milestone planner FS112-P for the owner to launch. **Sized for
about 200k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs112/briefs/STANDING-RULES.md` is part of this brief; read it in
full, rule 0 first.** You read prior art for both sides of a contest that starts after you; what you file is shared with both, so file statements and
their addresses, and no routes of your own.

## Why

FS-112 asks whether a tight six-map exists once boundary arcs of radius 1 are allowed (`plans/STUB-unit-arc-half.md`; claim list `data/fs112/claims.md`
§1). The planner's prior-art grep (`plans/FS112-unit-arc-half.md` §PA row 3) found that Polymath16 worked this question informally in 2018, in threads
6–9 ("Wrestling with infinite graphs", "Upper bounds", "More upper bounds", "Searching for a 6-coloring") and wrote it up in thread 16, and that the
published residue is `[Polymath2021]` p. 199. FS-110's recorded miss was prior art read in round 3 instead of at the opening (G50); this job reads it first.

## What to read (held; do not fetch anything the brief does not name)

1. `~/source/library/notes/polymath16-threads-1-18-text.txt` — threads 6, 7, 8, 9 and 16 in full (the file's thread boundaries are ragged: a thread's
   header also appears inside other threads' sidebars; find each thread's body by its opening post). About 60,000 words.
2. `~/source/library/pdf/jams-2004-coulson-chromatic-number-plane-tilings.pdf` — the figures (`BIBLIOGRAPHY.md`: "figures not viewed"); render pages with
   `pdftoppm` and read them.
3. `~/source/library/Alexander Soifer - The New Mathematical Coloring Book_ … (2024).pdf` — locate its treatment of `[Thomassen1999]`'s nice colourings
   and of map colourings with unit arcs (grep the text layer; read the pages you find, and say which).

## What to produce

- **`data/fs112/fs112-pa/extracts.md`**: every passage about six-colourings (of the plane, a disk or a strip) whose boundaries include arcs of radius 1,
  and every argument about vertices of degree ≥ 4, six-colour vertices, Reuleaux arcs, "constraints", Siamese tiles or the unit-radius tactic —
  **verbatim**, each with its thread, commenter, date and a locator (a unique phrase), and one line of yours saying what it states.
- **For the print claims in claim list §2 and §6** (HOCK: Hockertz's reduction to straight lines and unit arcs; de Grey's degree-4 and six-colour-vertex
  sketches; Gibbs's "constraint"): the full exchange around each, and a grade — *stated* (no argument), *argued* (a sketch), or *proved* — with a
  one-line reason. Do not derive or repair them; the sides do.
- **The constructions**: every description in the threads of `[AxenovichEtAl2014]`'s six-coloured strip and of `[Polymath2021]`'s six-coloured disk of
  radius `√(5/2 + 9/(2√5))` (its Fig. 10) — especially **any construction rule for the disk** (which edges are unit arcs, where each is centred, which
  points are the pentagon's). If the threads print one, say so first in your report: it replaces the by-eye transcription the plan provides for.
- **A list of anything the threads claim as a six-colouring of the whole plane**, with what was found wrong with it there.
- Your record `plans/FS112-PA-reading.md`: stages SAVED, the heading "Theorems this phase proved" (expected: none), a reading-status line per source
  and per thread, and proposed `BIBLIOGRAPHY.md` rows (standing rule 11).

## Rules

- **Touch only** your record, `data/fs112/fs112-pa/`. Commit by explicit path with neutral subjects "FS112-PA: stage n"; push after each commit; never amend
  or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say which threads are left.
- **The ban** (standing rule 3) applies: reading and quoting only; no fitting of figures.
- **Fences** (standing rule 13): the transcripts under `~/.claude/projects/-home-kooshi-source-lean-dir/`, `chats-bak/`, every shared scratchpad file you did
  not create (work in `scratchpad/fs112-pa/`); the advisors' records `plans/POROS-2026-09-27-fs112-unit-arc-half.md`, `plans/POROS-2026-09-27-fs112-competition.md`;
  the sides' and verifiers' records once they exist; `plans/FS112-close-inventory.md`.
- **Contact:** only `"main"`. Report per standing rule 9 to `data/fs112/reports/FS112-PA.md`, and the same text to `"main"` by SendMessage. Your final
  turn's text: "FS112-PA idle; report sent to the owner by SendMessage".

Thank you.
