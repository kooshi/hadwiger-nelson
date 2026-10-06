# Session handoff — 2026-10-06: FS-131, the Lean backlog, in flight (written before a compaction, at Kooshi's word, for an overnight run)

*Written 2026-10-06 by Keryx. Current state only. A successor arriving with nothing reads this first, then `plans/FS131-close-inventory.md` — every item,
ruling and receipt (items 1–579 at this writing; its first two sections are the rules that judge the milestone). The handoff before this one,
`plans/SESSION-HANDOFF-2026-10-04.md`, is superseded; it is kept only for its long list of jobs done before the restart.*

## 1. Read first

1. You are Keryx if your system prompt carries `# Keryx in lean-dir — the workflow` and says **Workflow 3.1**.
2. **The milestone**: FS-131, the Lean backlog (`plans/STUB-lean-backlog.md`; input `plans/LEAN-BACKLOG.md`, 259 rows). Plan: `plans/FS131-kernel-plan.md`
   (ten waves, § 7.1; gate design § 7.5 — nothing with a `sorry` on `main`, a branch and worktree per lane, land by merging `main` in and fast-forwarding
   at a green gate).
3. **Staffing** (Kooshi; items 323, 410, 412, 551): **three Opus slots** (the special-purpose fourth for FS131-T5 is **closed**: T5 handed back, item 562); every slot that frees is refilled from § 4's queue. The work runs on a second
   account. Implementers launch with `model: "opus"`.
   A full halt can come at any time: at one, stop launches, have running jobs save and push, copy `/tmp` out (item 407).
4. **Kooshi's standing words since the restart**: `origin` is the backup remote, not GitHub (item 412). Published artifacts stay local — rebuild and
   commit the Proof Atlas at a filing, publish nothing (item 413). Reporting: no per-step reports; a push notification only for what he must know.
5. **`/tmp` is a tmpfs** (wiped at power-off). The pre-halt scratch is in `/home/kooshi/source/lean-dir-tmp-rescue-2026-10-05/tmp/`; a record citing
   `/tmp/claude-1000/…` reads it there. Briefs tell jobs to keep what they cite under their `data/` folder.
6. **Never `cd` into another worktree** from the top-level session: the harness announces it to running agents as their working directory (item 424).
   Use `git -C <tree>` and absolute paths.

## 2. Where the milestone stands (rewritten 2026-10-06, about 20:45 UTC, at Kooshi's word)

| piece | state |
|---|---|
| **on `main`** | waves 1–5, the example maps, **wave 10's first and second passes**, wave 6's first half (items 474, 496, 535, 558, 575). Counts filed at `e9a65a86`: 6,334 records, 6,304 clean, 5 purchases, 8 imported on **one outside axiom (Weil's bound)**, 17 axiom-free; vacuity `declarations=14501 refutations-skipped=199 sites=1269`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1226 unknown=2`. No `sorry`. |
| **the gate's step listing what the library assumes** (FS131-T5, done) | on `fs131-t5` at `4dd69014`, **not on `main`**; **FS131-LT5 is landing it now** (§ 3). On `main` as of `3bfc7d2e`: 34 assumptions — 6 outside theorems, 24 hand results of ours, 4 open questions (item 562). |
| **wave 6, third and fourth passes** | `fs131-w6` at `2aa3f720`: 62 leaves — `CoverHull` and `Parallel` — **15 of 17 proved** on `fs131-w6l` at `b5b8f4be` (item 576; two open, a deriver's), `Centre` — **4 of 7 proved** on `fs131-w6z` at `94a98a58` (item 579; a continuation owed), `Accumulation` 10 (**I6K running**), and the fourth planner's `Fragment` 19, `ReduceI` 1, `Owed` 8 (three implementer jobs owed, its lines X, Y, W; briefs not written). A gap found in FS111-M-REDUCE-I (item 566): ledger row 154 owes an erratum. |
| **wave 7** | `fs131-w7` at `195c7855`: 39 leaves stated (`Count` 19, `Rainbow` 1, `FourColour/Local` 13, `Bowtie` 6). **`Count` is proved** on `fs131-w7a` at `5777e8e7` (item 564), not yet merged into the wave's line. Left: `anchor`, `Local`, `Bowtie`; the pinwheel and eight rows unstated; the bowtie fragment's four jobs (item 553). |
| **wave 8** | `fs131-w8` at `8d979793`: **`emptyNS`, `doubleTip` proved** (item 569; `star_recip` too, on `fs131-w8a` at `e1e0c74d`); 26 leaves — `SemiHub` 17, `SemiHubPlaces` 6, `Star` 2, `Empty` 1. **I8B launch-ready** (the merge, `star_anti` at its ruled statement, the shared lemmas). Two rows unstated. `emptyNS`'s nine-colour model owed. |
| **wave 9** | `fs131-w9` at `50c0edc5`: five leaves after one pass (item 536); its second planner owed. |
| **wave 10 beyond the landing** | `fs131-w10k` at `e09209e4`: `LevelGraph` 2 and `UsablePlace` 1 leaves; a fourth planning pass owed (item 555). |
| **the example maps' closers** | FS131-MD1, FS131-MD2: briefs gated, trees `fs131-wd1`, `fs131-wd2` at `1ed1cfd2`; they do not land. |
| `bend_away` (wave 4's tangent bend) | `sorry` on `fs131-w4ba` at `71cca146`; its planner waits on the arc step's statement (item 427 (e)) |

**An open gate item on landed results** (items 419 (d), 426–427): `LEAN.md`'s inhabitant rule asks for a Lean object satisfying every hypothesis of a
theorem at once. The four moves on `main` (`exists_merge`, `exists_rayMerge`, `exists_shave`, `exists_open`) have none in Lean; each has a hand model
(FS131-QA4's record §§ 3.2–3.3; E6's twelve-colour map for OPEN). Truth is not in question (kernel-checked). Kooshi has been told. It closes when the
planted-picture models land (queue item 2).

## 3. Running now (3) — each reports to "main" by hand-back; its report file is on its branch

| job | tree and branch | what | brief | on its hand-back |
|---|---|---|---|---|
| **the Searcher** (`SEARCH-2026-10-06`) | the main tree (it reads `Count.lean` in `fs131-w7a`'s tree) | one request, queue line 8: a six-colour `CountData` on a map of Euler characteristic 0 — a model, or a bounded null (Kooshi's conditional word, item 574) | `data/search/briefs/SEARCH-2026-10-06.md` | **mid-run it reports a model** (item 578: a six-colouring of `torusGrid 12 12`, `data/search/2026-10-06/MODEL-torusGrid-12-12.json`, three of its seven conditions re-checked by me) — on its hand-back: file its fate line in `plans/SEARCH-QUEUE.md` line 8, and **write FS131-I7M's brief** (a small implementer job from `fs131-w7a` at `5777e8e7`: the model as a `CountData _ 6` by the kernel's evaluation, the smallest object the run found; `example`s applying the six theorems; their docstrings name it); a null goes to the wave's stub lines as a deriver's question; tell Kooshi either way. (**I6L is done**, item 576: `fs131-w6l` at `b5b8f4be` — 15 of 17 leaves; open: `curvature_integer_ae`, `finite_pieces_of_radius`. **A deriver's job, FS131-E9, is ruled (576 (a)) — claim list and brief NOT written**: INTRAD (i) along a general chart (I6L's record § 4 has a route), INTRAD (iii) without `Fan.ends_centre`, and item 566's gap (interfaces locally finitely many segments and arcs); `ephodos`; it writes on `main` under `plans/` and `data/` only; sources: K6c's drafted question (the plan's § 15.4 item 3), K6d's `ReduceI`, `plans/FS111-M-regularity.md` § 5.1. **I8A is done**, item 569.) |
| **FS131-I6K** | `.claude/worktrees/fs131-w6k`, `fs131-w6k` (at `2aa3f720`) | wave 6's third pass, third implementer: `Accumulation`'s ten leaves (the short ones first; three carry the price) | `data/fs131/briefs/FS131-I6K-wave6-third.md` (with Amendment 1, regenerated at launch) | review, log; `#check` its heads; most of its theorems have no known object satisfying their hypotheses, as ruled. (**I6Z is done**, item 579: `fs131-w6z` at `94a98a58` — 4 of 7 leaves; **owed, brief not written: FS131-I6Z2** (`vt_w`, `erosion`, `pencil_window`; first child a chart-restriction lemma; it merges `origin/fs131-w6l` for the tangent-type fact; its record § 4.3). **K8b is done**, item 572; wave 8's order: I8B (launch-ready), then I8C and I8D from its tip, then K8c; `emptyNS`'s nine-colour model (needs wave 6's `sq9Map_valid`). **K6d is done**, item 566; three jobs owed on its lines X, Y, W; **FS131-K9b's brief (not written) must carry ruling 566 (a)**; **FS131-K7c's brief (not written) must carry item 571's relay, ruling 564 (f), and the search's model as an inhabitant if I7M has not stated it**.) |
| **FS131-LT5** | `.claude/worktrees/fs131-wlt`, `fs131-lt5` (from the filed `main` at `e9a65a86`) | the gate step's landing: merges `fs131-t5`, declares what two landings brought, a second reading of 33 declared reasons, draft 8's docstring edits, absent counts made to fail, the ledger rewritten, the full gate with the new step, `main` fast-forwarded | `data/fs131/briefs/FS131-LT5-gate-step-land.md` | **while it is in flight commit nothing to `main` outside `plans/`, `data/`, `.claude/`, `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`.** On its hand-back: § 5's landing procedure (previous receipts `data/fs131/l10b/receipt-axioms-final.log`, `receipt-vacuity-final.log`; fact audit `--base e9a65a86`), **and the first filing of the assumptions' nine counts**: add T5's draft 1 paragraph to `CLAUDE.md` § Trust ledger with its landed counts, then `scripts/gate_report.py`'s third digest must read "match"; file its `LEAN.md` drafts (§ The gate, § Assumptions, § Trust ledger); **send Kooshi the enumeration on the landed tree**; add its draft 7 line to every landing brief written after. (**L10B is done and filed**, item 575: wave 10's second landing on `main`, gated `f0cc3018`, filing `e9a65a86`. **I7A is done**, item 564. **K10c is done**, item 555; **FS131-I10G's brief (not written) carries ruling 575 (a)**: the usable place, two Lean models of about 55 lines, `FloorPlanes`' docstring; cut it from a merge of `main` into `e09209e4`.) |

**FS131-T5 is done (item 562)** — branch `fs131-t5` at `4dd69014`, tree `.claude/worktrees/fs131-wt5`, record `plans/FS131-T5-assumptions.md` there: the gate step `scripts/assumptions.sh` lists what the library assumes in both forms. It is **not on `main`**. **It lands in a job of its own, FS131-LT5, the next landing after FS131-L10B (ruling 562 (e)) — its generator is written and dry-checked (`data/fs131/briefs/scripts/mk-lt5.py`); once L10B has landed: make the tree (`git -C <root> worktree add -q -b fs131-lt5 <root>/.claude/worktrees/fs131-wlt origin/main`, `.lake` as usual with the build copied from `fs131-w10m`, push), run the generator, gate, launch (`debruijn-implementer`, `model: "opus"`)**. What the brief asks: merge `origin/fs131-t5` into `main`'s tip then; make its draft 8's docstring edits under `Proofs/` (a rebuild), with `Voronov11`'s sentence (ruling 562 (b)); declare what wave 6's first half and wave 10's second half brought (L10B's drafts carry a table for it; wave 6's first landing's record names its hypotheses); `--write-ledger` (Falconer's rows leave, Weil's arrive); read its 31 conditions and 2 premises as a second reader; make absent counts fail once filed (ruling 562 (d)); the full gate; land; then **I file its drafts 1, 3–6** (`CLAUDE.md` § Trust ledger's nine counts, `LEAN.md` § The gate, § Assumptions, § Trust ledger, `ARCHITECTURE.md` § 5) and add its draft 7 — the line every landing brief carries — to every landing brief written after. The two bibliography rows it needed are filed. Kooshi has the complete list he was owed (my report after item 563).

Agent ids are in this session's scratch (`agents.txt`), never in a file. If the session restarted, resume a job from its record's last SAVED stage with
a fresh agent on the same brief.

## 4. Queue for the next freed slots (rewritten 2026-10-06, about 20:45 UTC; the superseded text is in git)

**Launch-ready, in this order** (each `debruijn-implementer`, `model: "opus"`, unless said):
1. ~~The Searcher~~ — running (item 576 (f)). Was: `data/search/briefs/SEARCH-2026-10-06.md` (generator `mk-search-1006.py`, gate exit 0), `subagent_type: "searcher"`, into the next free slot that is not a landing's. Kooshi's conditional word and my check of its two conditions: item 574. It counts as one of the three. On its hand-back: file its fate line in `plans/SEARCH-QUEUE.md` line 8; a model goes to wave 7's line as an inhabitant to state; a null goes to the wave's stub lines as a deriver's question.
2. ~~FS131-LT5~~ — running (item 575 (e)).
3. **FS131-I6K** — `data/fs131/briefs/FS131-I6K-wave6-third.md` (with Amendment 1), tree `fs131-w6k` at `2aa3f720`.
4. **FS131-I8B** — `data/fs131/briefs/FS131-I8B-wave8-join.md`, tree `fs131-w8b` at `8d979793`. It messages the shared module's hash mid-job: then cut I8C's and I8D's branches.
5. **FS131-MD1**, **FS131-MD2** — `data/fs131/briefs/FS131-MD1-closers.md`, `FS131-MD2-closers.md`, trees `fs131-wd1`, `fs131-wd2` (cut from `main` at `1ed1cfd2`: add a dated amendment at launch saying `main` has moved and they do not merge it).

**Briefs to write, planners first** (a planner's hand-back is what implementers wait on):
- **FS131-K7c** (`debruijn`, on `fs131-w7`): first act, merge `origin/fs131-w7a` (ruling 564 (f); my trial conflicts in `scripts/Axioms.lean` only) and fix `ARCHITECTURE.md`'s row for `Count`; then the discrepancy between `tools/fs114_y2_k1.py` and `data/fs116/n1/ring-survey-bowtie.out` about FS114-Y2-BOWTIE's ring (ruling 553 (a)); the pinwheel and eight rows; `rstopAll`'s `SimpleOn` narrowing; **item 571's relay** (four of its five QOPP theorems follow from wave 3's two cone lemmas; `qArc_inner`'s first clause is wave 8's `qcol_inner_tile`); `#check` every leaf it states (item 564: four of its predecessor's were false for a missing section variable).
- **FS131-K9b** (`debruijn`, on `fs131-w9`): item 536's order (K9b before I9A; both readings of "simple" land; five models are a gate condition); **the join takes `reduce_i_of_arcInterfaces` over the named open statement `ArcInterfacesOfRegJ`** (ruling 566 (a)), by ancestry from `fs131-w6` at `2aa3f720`, and derives its own finding (3) (item 533) from wave 6's leaf or the reverse — one statement, one name.
- **FS131-K10d** (`debruijn`, from `e09209e4`): J45-SI-5, SI-C over `IsPlaceFilter`; the link from `normOneCayley` to `finitePlane Q` as a row (ruling 555 (c)). **FS131-I10G**: `LevelGraph` 2 and `UsablePlace` 1 leaves, from `e09209e4` (about 730 lines); after L10B lands, cut from a merge of `main`.
- **FS131-I8C** (`SemiHub`, 17 leaves, about 1,700 lines) and **FS131-I8D** (`SemiHubPlaces` 6 with `outerAdj`, about 1,800) — from I8B's tip, in parallel (ruling 572 (a)); the planner's § 9.8 calls them "I8B" and "I8C". **FS131-K8c**: FS116-N2-SIXRING and RING-TWIST-C (K8b's record § 9.7).
- **Wave 6's lines X, Y, W** (K6d's record § 24: `Fragment`'s PARTNER, RUNG, SATPIN leaves; its AXIS, KAPPA, PAIR leaves; `ReduceI` and `Owed`), after the third pass's three.
- **FS131-I7L** (`FourColour/Local`, with `anchor` first and its two import lines, ruling 564 (a)–(b)), **FS131-I7B** (`Bowtie`), the bowtie fragment's four jobs — after K7c. **FS131-I9B**, **I9A** — after K9b. `emptyNS`'s nine-colour model (needs wave 6's `sq9Map_valid`, a leaf of `Owed`). A tidy job for wave 6 (ruling 544 (d); the landed `Pinch` docstring, ruling 561 (c)).
- **Landings**: wave 6's second, waves 7, 8, 9 — each brief adapted from `mk-l10b.py`, and each **carries T5's draft 7** (the line on declaring assumptions) once LT5 has landed. Then the milestone's filing (§ 8).
- **Every implementer brief from now on** asks for the guarded lint at its last stage (item 573) and a `#check`-level statement check (item 556; the tools are `tools/fs131_i7a_stmt_check.py` on `fs131-w7a` and `tools/fs131_i8a_stmt.py` on `fs131-w8a`).

**Generators** (`data/fs131/briefs/scripts/`): `mkbrief.py` (the helper), `mk-l10b.py`, `mk-lt5.py`, `mk-i8b.py`, `mk-i6k-amend.py` (re-runnable while unlaunched), `mk-k8b-amend.py`, `mk-search-1006.py`, `mk-i78.py`, `mk-k78b.py`, `mk-md.py`, `mk-i6k.py`, `mk-k6d.py`, `mk-l6a.py`, `mk-if1.py`, `mk-t5.py`.

## 5. Procedures

- **On each hand-back**: review by artifact — commits exist and are pushed; the build log's last line reads "Build completed successfully", with 0
  warnings other than `sorry` (`grep '^warning' | grep -v 'declaration uses .sorry.'`); `sorry` by `grep -cP '^\s*sorry\s*$|:= sorry|by sorry'`; the
  axioms print parsed by script (rejoin wrapped lines, then `'(.+?)' depends on axioms: \[([^\]]*)\]`, against `{propext, Classical.choice,
  Quot.sound}`); one statement read back against its source (match the name with a trailing space: `^theorem bv_l3 ` also matches `bv_l3_dbl`
  without it). Log the item with the receipt, rule its held items in four parts, refill the slot. Replace, do not reuse, an agent past about 500k.
- **Briefs**: written by a script from exact source lines (the helper is `data/fs131/briefs/scripts/mkbrief.py`, with `example-ia1.py` beside it as
  a worked brief: `Q(path, prefix, heading)` quotes the unique line with that prefix, `item(n)` an inventory item's first line), gated with `python3 .claude/skills/keryx/scripts/brief_gate.py all <brief>`; branch-only
  files need their full worktree path; the statements section needs at least one quotation. A mid-job change is a dated amendment appended to the
  brief, gated, then one message pointing at it.
- **Brief hygiene learned this session** (items 453, 467 (g)): commit a brief only on the gate's **own exit status** (run it to a file, read
  `$?`; a pipe through `tail` hides a FAIL); a bare file name or a backticked token beginning with a dot (`.toward`) fails the gate — write
  full paths and full names; each job's generator is in `data/fs131/briefs/scripts/` (`mk-<job>.py`; `mk-i10.py B|C`, `mk-ma.py`, `mk-k6.py`
  are reusable); **two branches never state one lemma under one name** — a line that needs another's lemma takes it as a hypothesis.
- **A hand-back's statement check must read the kernel's statements** (item 556): a section `variable` enters a theorem only if its
  statement mentions it, so a leaf can be stated without a hypothesis its file shows, and a textual check passes it. At a review,
  `#check` at least the row's heads (`lake env lean` on a three-line file under the slot); landing briefs ask it of every head.
- **Learned 2026-10-06, afternoon** (items 560–574): **a brief not yet launched is rewritten, not amended** (regenerate its amendment; a launched one gets a dated amendment); **when a job of a wave hands back, fast-forward every unstarted branch of that wave onto its tip and copy its build** (no `lake` running in the source tree), so the next job has its lemmas by ancestry; **check the import direction before telling a job to cite a lemma** (a module that imports yours cannot lend you one: item 566 (d) — the lemma moves instead); **a planner's hypothesis can be wider than its row** — read the row's "not claimed" line against the binder (item 568: `interior` of a cone admitted the whole circle); **the harness's "completed" notice can be interim** ("stopped with background work still running"): a slot is free only when the hand-back message has arrived; **a hand-back past about 550k** happened three times today (planners and implementers at 524k–609k): brief planners at 400k with a hand-back line at 500k; an inventory append asserts on the file's last two words only (lines wrap); a `Q()` prefix holding braces is built outside the f-string.
- **Usage** (item 574 (c)): The cap stays at three slots, the Searcher included; the coordinator's own context is the other lever.
- **An implementer's last stage runs the guarded lint** (item 573: a landing's gate went red on an unused instance binder no branch had linted) — say so in every implementer brief written from now on: `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8`, after its last green build.
- **Prices, calibrated** (item 541; `data/fs131/calibration/price-vs-actual.md`): one implementer job is about an hour, about 430k
  tokens, about 1,300 lines of Lean (`tokens ≈ 311k + 129 per line`); read a planner's price in **lines** (÷ 1,500 = jobs, plus a planning
  pass if unstated) — token prices run a third low, line counts are right, sessions are twice high, day-prices ten times high in jobs.
  Planners' briefs ask for lines and jobs, never days. Expect FS131-I6L, I6Z, I6K to need continuation jobs (49 planner-days, three briefs).
- **Learned since the last compaction** (items 511, 521, 523, 526): **a definition two waves need is shared by ancestry** — its
  planner commits the module alone after a build and sends the hash, and an unstarted branch is fast-forwarded to it (`git -C <tree>
  merge --ff-only <hash>`), never re-declared; **never `cd` inside a compound command on a worktree** (item 521's slip: use `git -C`
  and absolute paths throughout); **a statement defect reported mid-job is logged and routed at once, and announced to Kooshi as a
  defect only when its reporter's saved stage carries it** (item 526: one was retracted by its reporter within the hour); after
  editing a brief generator, read its own exit status before the gate's (twice a block was placed before the values it reads); a
  hand-back's review reads the last *real* build's full log (the one that rebuilt modules), not a later "nothing built" confirmation.
- **A new worktree**: `git -C <root> worktree add -q -b <br> <root>/.claude/worktrees/<name> <base>`; `mkdir .lake`; symlink `.lake/packages` to the
  main tree's; `cp -a` `.lake/build` from a tree with **no `lake` running in it** (`pgrep -x lake`, then `readlink /proc/<pid>/cwd`); push with `-u`.
  Idle trees with green builds now: `fs131-w5k` (`fs131-w5`'s line at `3b120cd3`), `fs131-wop` (`main`'s line).
- **At a landing** (as OL1's, items 414–415): `git pull --ff-only` in the main tree; read the saved gate logs; `scripts/gate_report.py axioms <log>
  <previous landing's log> CLAUDE.md` and `scripts/gate_report.py vacuity <log> <prev> scripts/vacuity-baseline.txt CLAUDE.md` (the previous logs are
  now `data/fs131/l10a/receipt-axioms-first.log` and `data/fs131/l10a/receipt-vacuity-first.log`); file the drafts (`CLAUDE.md` § Trust ledger and § The
  gate, a `GATE_CHANGES` entry in `tools/claude_md_fact_audit.py`); `tools/claude_md_fact_audit.py --base <last CLAUDE.md commit>` (losses should be
  only the superseded counts) and `--dupes` before committing; push-notify Kooshi. Dates in filed counts are the gate logs' UTC date.
- **Rules a landing brief now carries**: **the doubled-name check on the joined tree, after the build and before the axiom audit** —
  `scripts/slot.py --mem 16 --cpus 8 -- ./scripts/dupnames.sh`, then `scripts/slot.py --mem 4 --cpus 4 -- ./scripts/dupnames.sh --self-test`
  (item 467 (b); with a doubled theorem name an axioms print can be clean over a `sorry` copy, item 466); two lines never state one lemma under
  one name (467 (g)); the guarded lint after the green build, `lake lint --no-build -- --no-build --trace` under the slot with
  `--mem 8` (`LEAN.md` § The gate; items 418–419); `tools/fs131_qa4_notes.py` with a conflict fixed before the push (427 (d)); a re-run of the gate is
  not needed for new `main` commits touching only `plans/`, `data/`, `.claude/`, `BIBLIOGRAPHY.md`, `LEDGER.md` (415 (b)); and the coordinator commits
  nothing else to `main` while a landing is in flight.

## 6. Rulings in force made since the restart (the inventory has each in four parts)

| item | ruling |
|---|---|
| 419 (a) | the three unused `[NumberField _]` binders are removed, at the remedy pass |
| 419 (c) | an unused hypothesis a ruling kept (underscore-named or read by `have _ :=`) stays; logged as a generalization for the errata |
| 419 (d) | `LEAN.md`'s inhabitant rule means every hypothesis at once (my ruling 417 (b) from memory was wrong and is withdrawn) |
| 421 (a) | `clean` and `cleanKeep` both stay until wave 5 has landed; unifying them is a tidy move |
| 421 (c) | new declarations may be added to `Moves`, `MergeMove`, `OpenMove`, `Surgery` (and `UnitArc`, for the bends) on wave 5's branches — nothing existing changed |
| 423 | `exists_vertexStep` takes `(hv : F.Covers v 1)` in place of `(hv : v ∈ F.dom)` |
| 430 | `exists_arcStep` gains `(hP : F.IsPlaneMap)`; its degree clause becomes `(∀ x ∈ T, ∀ m, F.HasDegree x m → ∃ m' ≤ m, F'.HasDegree x m')`; the horn clause stays unless IA1 reports it resists (then `∀ x ∈ T`, pre-ruled); the edit to `Procedure.lean` is the assembly job's (or IR2's successor's, if IR2 hands back first) |
| 427 (d) | the inhabitant rule's four unclear cases: open-question sets say so (filed in `LEAN.md`); universal-hypothesis heads may share a module-level line; a note naming a hand model is an open gate item until a Lean model lands; notes are checked at each landing |

## 7. Branch tips at this writing (all pushed to `origin`; every tree clean but the three running)

| branch | tip | holds |
|---|---|---|
| `main` | this commit | waves 1–4, Woodall, MERGE, OPEN; the inventory, briefs, audits |
| `fs131-w5` | `8ca5fc67` | wave 5's density half, whole |
| `fs131-w5c` | `ad611866` = `main` (landed; idle) | **wave 5's one line**: `fs131-w5s`, `fs131-w5y` and the bend's skeleton merged; `Procedure`, `Terminal`, `ArcStep`, the density half with no `sorry`; every open leaf is one of the outward bend's children (proved on `fs131-w5z` but two) |
| `fs131-t4` | `f53b7bdf` | merged into `main` (item 467 (c)): the doubled-name check; its worktree `.claude/worktrees/fs131-wop` is idle, a green build of `main`'s line |
| `fs131-wmb` | `4b46d755` (landed; idle) | the example maps, merged into `main` |
| `fs131-w5s` | `facdf1c2` | idle; cut from `fs131-w5c` at `ebb0b292`; `stuckRun_ne_univ` proved, `Terminal` with no `sorry` of its own |
| `fs131-w5a` | `74fbdf16` | idle: the outward bend's first half proved (item 454: `LensOut`, `CollarMapOut`, `BendAway`, no `sorry`; Lean sources at `4559c106`); to be merged into `fs131-w5c` |
| `fs131-w5z` | `d4f04ff3` | idle: **the outward bend whole** (item 464: all 36 children and the toward bend's horn child proved; `fs131-w5a` merged in); to be merged into `fs131-w5c` by the landing job |
| `fs131-w5y` | `3f8270c0` | idle: the arc step's assembly `ArcStep` proved (item 447), the last lines for `Procedure` in its report |
| `fs131-w5k` | `3b120cd3` | idle (the collar's lane; `fs131-w5` was fast-forwarded past it) |
| `fs131-wop` | `4b68d47d` | the branch is merged into `main`; its worktree now holds branch `fs131-t4` |
| `fs131-w4ba` | `71cca146` | no worktree; `bend_away`'s repaired statement |
| `fs131-wm` | `87699974` | idle: the example maps' half A whole (item 472: `Paint`, `Moves` with no `sorry`; the four moves' models on the standard three); MB2 is merging it into `fs131-wmb` |
| `fs131-w10` | `ace98a35` | idle: wave 10's plan and skeleton, implementer A's two files proved (item 493); 12 leaves left in the other two files |
| `fs131-w6` | `6fc27fa1` | idle: wave 6's plan and skeleton after three passes, 65 leaves (31 being proved on other branches, 34 new in four modules, item 531); the bridge's implementers' branches are cut from `32f2ab4c`, the third pass's from `6fc27fa1` |
| `fs131-w6p` | `43ea4886` | idle: `Pinch` proved (item 516) |
| `fs131-w6m` | `2e55a2d6` | idle: `MapColouring` proved with `MapEdge` and `Sq9Map` (item 530); joins wave 6's line at the wave's join |
| `fs131-w9` | `50c0edc5` | idle: wave 9's plan and skeleton after one pass, five leaves (item 536) |
| `fs131-w6c` (`d62406a2`, idle: `Curve`, `LocalGraph` proved), `fs131-w6f` (`8e81fedd`, idle: the bridge's existence half proved), `fs131-w6g` (`b3b67f23`, idle: the five fan lemmas proved) | `32f2ab4c` | made for FS131-I6C (`Curve`, `LocalGraph`), FS131-I6D (`FanBridge`'s existence half) and FS131-I6E (its five `Fan` lemmas); builds copied from `fs131-w6` |
| `fs131-w10b` | `423cd8e8` | idle: `StationaryRatio` proved (item 506) |
| `fs131-w10k` | `330d2f48` | idle: wave 10's second planning pass — ten new modules, eleven leaves (item 509); its implementers' branches are cut from it |
| `fs131-w7` | `b5ef0e39` | idle: wave 7's plan and skeleton after one pass — route T's rows, twenty leaves; `Plane/SimpleOn` whole |
| `fs131-w8` (`f1c13612`, idle: wave 8's plan and skeleton after one pass, ten leaves), `fs131-w9` (`26b08395`: wave 7's and wave 8's shared modules) | from `611ffa39` | made for K8 and K9, fast-forwarded to wave 7's shared-module commit; builds copied from `fs131-wmb` (the first build compiles `SimpleOn`) |
| `fs131-w10c` | `8ee0d85b` | idle: `StandingFive` proved (item 519) |
| `fs131-w7a`, `fs131-w8a` | `b5ef0e39`, `f1c13612` | made for FS131-I7A and FS131-I8A (item 527); builds copied from `fs131-w7`, `fs131-w8` |
| `fs131-wd1`, `fs131-wd2` | `1ed1cfd2` (`main`) | made for FS131-MD1 and FS131-MD2 (item 529); builds copied from `fs131-wmb` |
| `fs131-w6l`, `fs131-w6z`, `fs131-w6k` | `6fc27fa1` | made for FS131-I6L, I6Z, I6K (item 532); builds copied from `fs131-w6` |
| `fs131-w10l` | `b344490e` = `main` at the landing (idle) | wave 10's first pass, landed (item 535) |
| `fs131-w10m` | `248f8f4f` | made for FS131-L10B (item 560); build copied from `fs131-w10k` |

## 8. Held for the milestone's filing

Everything in the superseded handoff's paragraph "Held for the milestone's filing" (wave 2's and wave 4's drafts; rows 134/135/137; the errata of items
262, 264, 277, 288, 291, 294, 300, 322, 372 (d); `InMK`; `ARCHITECTURE.md` prose counts; the stuck-fragment model stub; the consolidated errata
register, offered to Kooshi, default at the filing; finished worktrees' removal after rescuing cited gate logs) and its "Tool defects owed" list, plus,
since then: E6's three dated errata (item 385 (b)) and its `e6-open` block's "not claimed" line with OPEN regraded to [kernel] in its lone form (item
414); the omission of `Covers` in E6's draft § 4.5 (2) and KL1's plan row (item 423); KL1's plan corrections (item 420); KP2's plan § 5.1 (item 416);
IO1's record § 3.3 (item 408); the generalizations of items 416, 418, 420, 424; the docstring lines of QA4's rank 8 on `main`'s files (item 426); one
shared statement checker for FS-131 (item 406 (c)); E8's drafts (ruling 492 (c): the errata lines under FS111-M-C11 and FS111-M-PINCH, the
note for `data/fs121/claims.md`, G85's replacement words, the G92 instance — texts at `plans/FS131-E8-derivation.md` §§ 4.4, 4.6) and the rewrite
of REG-J′ to "Σ locally finite" once the bridge is in the kernel (ruling 492 (a)); `tools/fs131_io_axioms.py`'s summary class (item 414); `LEDGER.md` regrades (row 132 for Woodall;
FS110-W-MERGE to [kernel]); the Proof Atlas rebuilt and committed, not published (item 413).

## 9. Held for Kooshi, with defaults

- **Falconer's lemma is pulled into this milestone, by his word, 2026-10-06** (item 548: "Agree, pull in Falconer's."): **FS131-IF1** takes the next free slot — `data/fs131/briefs/FS131-IF1-falconer-lemma2.md`, tree `fs131-wf1` from `main` at `ca598960`, `debruijn-implementer`, `model: "opus"` (item 550): one implementer replaces the axiom `falconer_lemma2_nonempty` by a theorem, from a candidate route that is mine and unchecked (said so in the brief); it does not land; if the route fails at a step, a deriver's job is launched on that step. **The complete list of what the library assumes was sent to him after item 563** (from T5's record, stage 5).
- **Measure rigidity in Lean (FS-113) and the main clause through five (FS-101): held, by his word, 2026-10-06** (item 488) — *"Let's keep
  holding off on formalizing or pricing MR for now. That backlog is big enough that I might request community support for filling it. I'm
  going to wait to do that too though."* Do not open, price or re-offer them; the backlog's rows take their results as the named hypotheses
  `Row123Chain` and `Row130Collapse`. He is also watching a rumoured outside release of proofs of open problems; nothing here waits on it.
- **Conditional, his words** (item 489): *"if they release an HN proof, we will analyze the hell out of it."* Trigger: a published or claimed
  proof that decides the problem or moves a bound, brought by Kooshi or found by the Searcher. Then: stop launches at the next hand-backs,
  read it in full, a bibliography entry that day, and brief the lanes to analyze it against row 33 and rows 131–154. Nothing changes before.
- **The two papers asked of him are in the library** (item 515: Weil 1948 and Li 1992, identity checked; `BIBLIOGRAPHY.md` current). Weil's
  p. 207 states the Kloosterman bound at every finite field of odd characteristic. **Owed, a planner's**: the read-back against
  `KloostermanBound` and the axiom with its four items (stated with characteristic not 2) — the first item of FS131-K10c's brief when it is
  written (it now is: item 529). **Correction owed to him, not yet told** (item 529): the import takes the library's declared outside theorems from one to two; the audit's "imported" count is of records and rises from 4 by the records resting on the new axiom — not "from 4 to 5" as I told him twice.
- The example maps landed without `stuckModel_terminal` (ruling 482); FS131-MD1 proves `stuckModel.IsTerminalMap` whole (ruling 497 (b)).

- The external repositories (items 9, 105, 108–122): the outside repository's issue is written; nothing waits on it.
- From FS-129: the order (the backlog, then FS-124) stands; the finite-graph search is held; FS-129 closes when its 32 compositions pass.
- The consolidated errata register: offered; default, at the filing.
- Nothing is waiting on a decision of his today.
