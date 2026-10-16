# Brief FS131-RDM1 — rewrite the README for a human coming to it blind: what this project proved, at what status, and what is new

*Written 2026-10-16 18:56 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-RDM1
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity; this is a writing job, not a derivation: you derive nothing new, and you hold every sentence to the standard of a statement — its grade, its attribution, what is not claimed. Load the `decompress` skill with the Skill tool before you write, and run its validation as the reader before you hand back
  role: the writer of the repository's public front page, `README.md`, from the record as it stands on `main`
  launch: now, in a worktree of your own cut from `main`; beside you four Lean implementers in other worktrees, none of which writes a file you write (they draft README lines in their own records, which I adapt to your page later)
  mission: § Why this job
  statements: § Why this job
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage if a source contradicts another on a result's status or attribution (I rule; you do not pick), and when the draft is ready for my read; the report goes to `data/fs131/reports/FS131-RDM1.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` § Trust ledger and § Assumptions, for what each outside theorem is
  record: `plans/FS131-RDM1-readme.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/rdm1`, on its branch `fs131-rdm1` (cut from `main` at `80629caf3`; no Lean build here): `README.md`; at most one new reference file at the repository's root for the detail the front page no longer carries (name it in your record); `plans/FS131-RDM1-readme.md`; your scripts and outputs under `data/fs131/rdm1/`; `data/fs131/reports/FS131-RDM1.md`. Every other file is read-only to you; a correction another file needs is drafted in your record. Commit on your branch by explicit path; never push
  budget: about 300k by the harness's count, as guidance; save a stage after each stage below; hand back at a saved stage before about 400k

Hello. Kooshi, who owns this project, finds the front page hard to read, in its wording and in its layout on GitHub's
narrow column. It is the first thing a mathematician landing on the repository sees, and it should tell them, in a minute,
what is new here and how sure they can be of it.

## Why this job

His words, verbatim:

> W21: (2026-10-16) I'd also like a complete rewrite of the readme. It's not very human readable, neither in verbiage, nor format, especially on the cramped github screen. It should include a BLUF table, with clear, concise math notation on what this project has proved, its status (lean or hand proved) and a short explanation underneath each (meaning, consequences, caveats, etc.). It should be attractive and easily understandable to a human coming to this blind, and first and foremost cares about what's novel here.
> — source: data/fs131/REQUEST-2026-10-16.md

My reading of them, labelled as mine:

> **W21, read by Keryx (2026-10-16), labelled as mine.** "BLUF" is "bottom line up front": the table comes first on the page. "Status (lean or hand proved)" is each result's grade as the ledger and the gate record it — checked by Lean's kernel (and on which outside theorems), or proved by hand and not yet formalized. "First and foremost cares about what's novel" orders the page by what is this project's, with every attribution kept.
> — source: data/fs131/REQUEST-2026-10-16.md

The project's rule for what it publishes, which is why the status column matters:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

## What the page must do

1. **Lead with a BLUF table**: each result this project proved, in clear and concise mathematical notation (GitHub renders
   `$…$` and ` ```math ` blocks; a `|` inside a table cell must be escaped as `\|` or written `\lvert … \rvert`), with its
   status, and nothing a reader must scroll sideways for on a phone. Below the table, **a short explanation of each row**:
   what it means, why it matters, what it rests on, and its caveats.
2. **Novelty first.** Order and select by what is this project's. Results that are other people's (the classical bounds,
   de Grey's five, `[OAIMath2026]`'s six, Fischer's values) appear where a reader needs them for context, credited as
   `LEDGER.md` § The claim list and its rows credit them — never presented as ours. Where a value is prior art and the
   kernel proof is ours, say exactly that.
3. **Status, exactly.** Two kinds, said plainly: *checked by Lean's kernel* — and then on which axioms: Lean's standard
   three alone, or also one or more of the three declared outside theorems (Weil's bound, Einsiedler–Lindenstrauss
   Thm 1.3, `[OAIMath2026]`'s no-five-colouring theorem), named in words a reader knows — or *proved by hand, not yet
   formalized* (with the ledger's grade, e.g. "one mind"). Only what is on `main` counts as checked: four modules are being
   formalized now (the `p`-adic plane's bound, the three-colour criterion for Cayley graphs, the density form of the
   collapse, the five-colour fields by class) and none of them is held until it merges.
4. **For a reader coming blind**: a one-paragraph statement of the problem before the table, every symbol defined where it
   first appears, no project-internal vocabulary (row numbers, milestone ids, coined terms) as nouns on the page — a row
   number may appear as a link or an address in parentheses. `BIBLIOGRAPHY.md` § E is this project's translation table to
   the literature's words.
5. **Novelty wording** (my instruction, from Kooshi's correction of 2026-10-15): for this project's own results, write the
   ledger's words, "prior art: not found in print", never "first" or "new"; never write "not new" for a result derived
   here before it was formalized — that reads as "known in the literature". Where the ledger says a prior-art search was
   not run, say so.
6. **The rest of the page** — what the library assumes, how to check it, the layout, how it was made, the licence — keeps
   its facts, re-written for the same reader and shortened. Detail a front page should not carry (every Lean name, every
   axiom list, the full results table) may move to the one new reference file, linked from the README. Nothing is lost.
7. **The repository is public.** A commit hook runs the privacy guard on every commit; if it refuses one, reword what it
   names (the rule name says which kind) and commit again; never `--no-verify`. Write no person's private details, no
   local path outside the repository, and no other project on this machine.

The sources: the current `README.md` (its Lean names and axiom lists were printed at the gates); `LEDGER.md` (§ The claim
list first, then the rows the README cites); `CLAUDE.md` § The mission, § The aim and § Where the problem stands (current
state); `ROADMAP.md` (what is not yet formalized); `BIBLIOGRAPHY.md`; `LEAN.md` § Trust ledger; and the asking lane's
reader-facing statements of the project's findings, with who asked for each, `plans/POROS-2026-10-13-number-field-findings.md`
§ 3.3 ("The first ten, each as the theorem a reader would look for").

## Done means

1. **Stage 1 — the readback.** Check the three quotations above against their source; restate in your record what the
   page must do, in your words; list every result you intend to put in the table, each with its source address, its
   status and its attribution as the sources state them.
2. **Stage 2 — the facts, checked.** For every Lean name the new page or the reference file cites: its `#print axioms`
   re-printed from `main`'s build (a scratch file under `data/fs131/rdm1/`, run from the main tree
   `/home/kooshi/source/lean-dir` with `SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 scripts/slot.py --mem 8 --cpus 2 --
   lake env lean data/fs131/rdm1/…` — the main tree's build is current for `main`; write nothing there but your scratch
   file, and copy the output into your worktree), and each result's math notation read against the stored type it
   summarizes. A mismatch between a source and the print is a finding: message me.
3. **Stage 3 — the page.** `README.md` rewritten; the reference file if you use one; then the `decompress` skill's
   validation as the reader (teach-back, dictionary, pointer, stop-anywhere, why and loss audits) written into your record;
   then "nothing lost": every fact of the old `README.md` either on the new page or in the reference file, or named in
   your record with why it was dropped (`tools/claude_md_fact_audit.py --old … --new … --also …` may serve; say what you
   ran). Render it as GitHub would as far as you can locally, at a phone's width as well as a desktop's, and say how you
   checked. Commit (the hook will run).
4. **The report**, in the standing rules' form, with the places where each of the four modules now in flight would add
   or change a row when it lands.

## What is yours to decide

The page's structure, which results lead and how many the table holds, the notation, the wording, the design (headings,
symbols, emoji or badges for status if they help a reader and render on GitHub), and whether a reference file is worth
it. If a result's status or attribution in the sources looks wrong, say so: that is a finding, not a detour.
