# Brief FS129-AT1 — the Proof Atlas: two stale labels, the one look per theme, the rebuild

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS129-AT1
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your lane's workflow
  role: finish FS-129's filing of the Proof Atlas — correct two node labels to their stubs' current names, take the headless look at each theme, rebuild and check; decide nothing about the mathematics
  launch: now, beside FS131-K1 (de Bruijn's opening of the Lean backlog), which writes Lean modules, `ARCHITECTURE.md`, `scripts/Axioms.lean` and `plans/FS131-kernel-plan.md` — no file of yours
  mission: § Why this job
  statements: § The open item
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind
  channel: message the coordinator ("main") by SendMessage only for a question you cannot work around; the report goes to `data/fs129/reports/FS129-AT1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `data/fs129/at1/README.md`
  touches: `tools/viz_proof_atlas_facts.py`, `data/viz/proof-atlas/facts.json`, `visualizations/proof-atlas/index.html`, `visualizations/proof-atlas/DESIGN.md` (one stage section), `data/fs129/at1/`, `data/fs129/reports/FS129-AT1.md`
  budget: about 120k by the harness's count, as guidance; hand back at a saved stage before about 250k

Hello. The Proof Atlas is the explorable map of this project's results that Kooshi picks targets from (`visualizations/proof-atlas/README.md`, its
first paragraph, says what it is). FS-129's filing rebuilt it and its checker passes, but two things were left: two node labels still carry names
their stubs no longer use, and nobody has looked at the built page. Kooshi wants it current at every filing, and I republish it once you are done.

## Why this job

Kooshi wants the atlas current at every filing (`visualizations/proof-atlas/README.md` § Updating at a close, its first paragraph), and FS-129's
filing left it unlooked-at and unpublished; the Lean backlog's filings will update it again, so it should start from a clean state.

## The open item

The open item, as FS-129's inventory records it:

> 172. **Open — the Proof Atlas republish**: `visualizations/proof-atlas/index.html` is built and checked but not looked at (README step 5's
> — source: plans/FS129-close-inventory.md § Items

(it continues there: the headless look per theme was not done; the artifact has not been republished since before the FS-116/FS-121 filing;
"Next: the headless look, the FS128/FS120 labels, then Keryx republishes.")

1. **The labels.** In `tools/viz_proof_atlas_facts.py` the nodes `FS128` and `FS120` (search for `N("FS128"` and `N("FS120"`) carry titles from
   before FS-129. Their current names are the titles of their stubs, read from disk: `plans/STUB-top-colour.md` and the stub of FS-120 (find it in
   `plans/FRONTIER-STUBS.md` by its number), and the names `CLAUDE.md` § Frontier gives them. Change only each node's title (and its card's plain
   statement only where it names the old title); every quote and address stays as the checker wants it.
2. **The look** (`visualizations/proof-atlas/README.md` § Updating at a close, step 5): one headless screenshot per theme, light and dark, of
   `visualizations/proof-atlas/index.html` wrapped in the publish skeleton, network cut. Earlier looks used headless Firefox under `unshare -rn` (`visualizations/proof-atlas/DESIGN.md`
   § the stage sections, "The one look"); `/usr/bin/firefox` and `/usr/bin/google-chrome-stable` are installed, Playwright is not. Look at each
   screenshot yourself (the Read tool shows images) and note what reads badly: overlapping labels, unreadable text, an empty panel.
3. **The rebuild**, by the README's § Build, check, publish commands, every exit status read directly.

## Done means

- The two titles current; `python3 tools/viz_proof_atlas_check.py` exits 0 with its counts in your record; its `--self-test` passes; the palette
  review and its self-test pass; `python3 visualizations/proof-atlas/build.py` writes `visualizations/proof-atlas/index.html`.
- Two screenshots under `data/fs129/at1/` (one per theme), each with your notes on what reads badly, and one pass of layout fixes if the lint or the
  look shows overlaps (move marks only).
- A stage section in `visualizations/proof-atlas/DESIGN.md`, in the form of the ones before it (what moved, the one look, what was left out).
- Your record and the report in standing rule 11's form.

## What is yours to decide

How to take the screenshots, and the layout moves. If a label's current name is unclear — the stub and `CLAUDE.md` disagree — write a `CHECK:` with
both addresses and leave that label as it is. If the look shows something you cannot fix by moving marks, describe it and leave it for me.

## Your first stage: the readback

Check the quotation above against its source and restate in your record what the two labels must become and where you read each name.
