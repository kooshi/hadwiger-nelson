# Session handoff — 2026-10-06: FS-131, the Lean backlog, in flight (written before a compaction, at Kooshi's word, for an overnight run)

*Written 2026-10-06 by Keryx. Current state only. A successor arriving with nothing reads this first, then `plans/FS131-close-inventory.md` — every item,
ruling and receipt (items 1–533 at this writing; its first two sections are the rules that judge the milestone). The handoff before this one,
`plans/SESSION-HANDOFF-2026-10-04.md`, is superseded; it is kept only for its long list of jobs done before the restart.*

## 1. Read first

1. You are Keryx if your system prompt carries `# Keryx in lean-dir — the workflow` and says **Workflow 3.1**.
2. **The milestone**: FS-131, the Lean backlog (`plans/STUB-lean-backlog.md`; input `plans/LEAN-BACKLOG.md`, 259 rows). Plan: `plans/FS131-kernel-plan.md`
   (ten waves, § 7.1; gate design § 7.5 — nothing with a `sorry` on `main`, a branch and worktree per lane, land by merging `main` in and fast-forwarding
   at a green gate).
3. **Staffing** (Kooshi; items 323, 410, 412): **three Opus slots**; every slot that frees is refilled from § 4's queue. The work runs on a second
   account. Implementers launch with `model: "opus"`.
   A full halt can come at any time: at one, stop launches, have running jobs save and push, copy `/tmp` out (item 407).
4. **Kooshi's standing words since the restart**: `origin` is the backup remote, not GitHub (item 412). Published artifacts stay local — rebuild and
   commit the Proof Atlas at a filing, publish nothing (item 413). Reporting: no per-step reports; a push notification only for what he must know.
5. **`/tmp` is a tmpfs** (wiped at power-off). The pre-halt scratch is in `/home/kooshi/source/lean-dir-tmp-rescue-2026-10-05/tmp/`; a record citing
   `/tmp/claude-1000/…` reads it there. Briefs tell jobs to keep what they cite under their `data/` folder.
6. **Never `cd` into another worktree** from the top-level session: the harness announces it to running agents as their working directory (item 424).
   Use `git -C <tree>` and absolute paths.

## 2. Where the milestone stands

| piece | state |
|---|---|
| waves 1–4, Lebesgue, `localSectors`, Woodall's chain, MERGE | **landed on `main`**, counts filed (items 29, 151, 157, 171, 270, 318, 326, 375) |
| OPEN, the fifth move | **landed on `main`** (item 414: head `7189bdcf`, gated `68670175`); counts filed — 3,912 records, 3,889 clean, 14 axiom-free, 4 imported, 5 purchases; vacuity `declarations=11173 refutations-skipped=118 sites=784`, `vacuous=0 stale=0 declared=3 witnessed=32 generic=747 unknown=2` |
| wave 5, the density half (`fs131-w5` at `8ca5fc67`) | **no open leaf of its own**: the planar chain, `row134BaseUA`, the collar bend (`bend_toward_collar`, item 416), `exists_preBend` and its children, `n3_base`, `localDense`, `dense3`, `bv_l3` (item 424) — all on the standard three; `cv_exists` and `Terminal` there are stale copies of the other line's |
| wave 5, the `Terminal` half (`fs131-w5c`) | `Limit` done; `exists_terminalSeq` proved over two open steps (item 420); **the vertex step is whole in the kernel (item 449: all four cases proved; `Procedure` holds one `sorry`); open: `exists_arcStep` (IA1's groundwork done, item 437: question (5) proved, the statement repaired by ruling 430, one bend missing — `bend_away_part`, KA1 planning it; the assembly split by ruling 438 (c))**; `stuckRun_ne_univ` is **proved** on `fs131-w5s` at `facdf1c2` (item 431), to be merged at the final sync |
| the example maps' landing | **done** (item 496): on `main`, gated at `d9347791`; counts filed (`1adf15ba`): 5,550 records, 5,525 clean; `declarations=13386 … sites=1137`, `vacuous=0`; of wave 5's 62 open gate items 33 closed, 29 remain (MC1's record, draft 5) |
| wave 5's landing | **done** (item 474): on `main`, gated at `1351ebc2`; `CLAUDE.md` counts filed (item 475): 5,221 records, 5,196 clean; `declarations=12999 … sites=1130`, `vacuous=0` |
| waves 6–10 (111 rows) | not started; wave 10 (arithmetic) depends on nothing in waves 4–9 |
| `bend_away` (wave 4's tangent bend) | `sorry` on `fs131-w4ba` at `71cca146`; its planner waits for IA1 to say what statement the arc step needs (item 427 (e)) |

**An open gate item on landed results** (items 419 (d), 426–427): `LEAN.md`'s inhabitant rule asks for a Lean object satisfying every hypothesis of a
theorem at once. The four moves on `main` (`exists_merge`, `exists_rayMerge`, `exists_shave`, `exists_open`) have none in Lean; each has a hand model
(FS131-QA4's record §§ 3.2–3.3; E6's twelve-colour map for OPEN). Truth is not in question (kernel-checked). Kooshi has been told. It closes when the
planted-picture models land (queue item 2).

## 3. Running now (3) — each reports to "main" by hand-back; its report file is on its branch

| job | tree and branch | what | brief | on its hand-back |
|---|---|---|---|---|
| **FS131-I6C** | `.claude/worktrees/fs131-w6c`, `fs131-w6c` (from `32f2ab4c`) | wave 6, the bridge: `Curve`'s six leaves, then `LocalGraph`'s five | `data/fs131/briefs/FS131-I6C-wave6-bridge.md` (with Amendment 1) | review, log; its branch joins wave 6's line at the wave's join; its report says where `local_graph` reads disjointness. (**K6c is done**, item 531: `fs131-w6` at `6fc27fa1`, 34 new leaves in `CoverHull`, `Parallel`, `Centre`, `Accumulation`; ruled next, **briefs written and gated** (item 532): FS131-I6L (`CoverHull`, then `Parallel`), I6Z (`Centre`), I6K (`Accumulation`), on branches cut from `6fc27fa1`, and a fourth planner FS131-K6d for the fragment's six — rulings 531 (b)–(d), 532. **When FS131-I6E launches, amend its brief**: it owns the three cell lemmas of a fan, ruling 531 (c). **I10C is done**, items 519–520; **L10A is running**, next row.) |
| **FS131-L10A** | `.claude/worktrees/fs131-w10l`, `fs131-w10l` (from I10A's `ace98a35`) | **the landing of wave 10's first pass**: merge `fs131-w10b` and `fs131-w10c`, the ruled tidies (nine unread arguments dropped), merge `main`, the full gate, fast-forward `main`, drafts | `data/fs131/briefs/FS131-L10A-wave10-land.md` | **while it is in its landing stage commit nothing to `main` outside `plans/`, `data/`, `.claude/`, `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`** (no `CLAUDE.md` filing until it is back); on its hand-back follow § 5 "At a landing" (the previous receipts: `data/fs131/mc/receipt-axioms-final2.log`, `receipt-vacuity-final2.log`), file the counts, list the open gate items. (**K8 is done**, items 524–525: `fs131-w8` at `f1c13612`, ten leaves; ruled next, **briefs not written**: FS131-I8A — `Plane/RingCalculus/Empty`'s six leaves to `emptyNS`, then `Star`'s two, on a branch to cut from `f1c13612`; FS131-K8b — the nine semi-hub rows and two more, K8's report says what it needs. `emptyNS`'s nine-colour model waits for I6B's `sq9` map, ruling 525 (c).) |
| **FS131-K9** | `.claude/worktrees/fs131-w9`, `fs131-w9` (from `26b08395`) | wave 9's planner: the eleven rows of the reductions and the class statements | `data/fs131/briefs/FS131-K9-wave9.md` (with Amendment 1) | review by artifact, log, rule; implementers by file as its handoff says. **Mid-job (item 533)**: five findings ruled and answered; **owed by K9, to relay to K6d when it comes**: the exact Lean form of FS129-OR1-TOP5's implication hypothesis (FS111-M-REDUCE-I moved to wave 6's fourth pass, ruling 533 (a); K6d's brief carries it as item 6). (**I6B is done**, item 530: `sat_inP` proved at a wider class, `sq9Map : ArcMap 9` built with `IsPlaneMap` only, on `fs131-w6m` at `2e55a2d6`; its three findings relayed to K6c; **`emptyNS`'s model is a job after I8A**, ruling 530 (c) — not written. **I6A is done**, items 516–517. **Wave 10's second pass, K10b, is done**, items 509–510.) |

Agent ids are in this session's scratch (`agents.txt`), never in a file. If the session restarted, resume a job from its record's last SAVED stage with
a fresh agent on the same brief.

## 4. Queue for the next freed slots, in order (item 427; re-ordered by ruling 434)

0. **Order now** (rulings 473, 475): **wave 5 is on `main`** (item 474: gated at `1351ebc2`, landed `ad611866`; counts filed, item 475).
   All three slots are full (MC1, I10A, E8); wave 10 and wave 6 are planned in a first pass (items 484–487). K10 has reported a statement defect in a filed hand result, ruled (items 477–478: TC1-STANDING-FIVE
   takes a second named hypothesis, the finite-target floor; FS89-S0A-10 takes its band's order bound as a hypothesis). In order, as slots free: **FS131-K6b is running** (§ 3; E8 handed back, items 491–492: nine entries derived, its stub lines filed, its errata held for the filing);
   next into free slots:
   **the order, planners and implementers alternating (rulings 495 (d), 497; a planner's hand-back is what implementers wait on, and planners
   find the statement defects): ~~K9~~, ~~I6C~~ (both running), I10D, I6D, I10E, I6E, I10F, then K10c, K7b, I7A, I8A, K8b, then K6d, I6L, I6Z, I6K (**written and gated**, item 532: `FS131-K6d-wave6-fourth.md` on `fs131-w6` itself — its first act merges the two proved branches; `FS131-I6L-wave6-third.md` on `fs131-w6l` (`CoverHull` then `Parallel`; no separate I6H), `FS131-I6Z-wave6-third.md` on `fs131-w6z`, `FS131-I6K-wave6-third.md` on `fs131-w6k`, all from `6fc27fa1`; generators `mk-k6d.py`, `mk-i6k.py L|Z|K [<cell lemmas' commit>]`), then MD1, MD2** (**I7A and I8A are written and gated, trees made**, item 527: `data/fs131/briefs/FS131-I7A-wave7-first.md` on `fs131-w7a` from `b5ef0e39`, `FS131-I8A-wave8-first.md` on `fs131-w8a` from `f1c13612`, generator `mk-i78.py 7|8 [<sq9's commit>]` — regenerate I8A's with I6B's commit once I6B is back; **K7b and K8b are written and gated** too, item 528: `FS131-K7b-wave7-second.md` on `fs131-w7` itself, `FS131-K8b-wave8-second.md` on `fs131-w8` itself, generator `mk-k78b.py 7|8` — new modules only, and each sends me its form of FS114-N7-QOPP to relay to the other; **K10c, MD1, MD2 are written and gated** too, item 529: `FS131-K10c-wave10-third.md` on `fs131-w10k` itself (generator `mk-k10c.py [<branch>=<tip> …]` — regenerate with the second pass's implementers' tips as they return), `FS131-MD1-closers.md` on `fs131-wd1` and `FS131-MD2-closers.md` on `fs131-wd2` (both from `main` at `1ed1cfd2`, generator `mk-md.py 1|2`; the closers do not land — the next landing job merges them); **every job in this order now has a gated brief**) (rulings 502, 505, 507, 510; K7, I10C and I6A are running). **Also ready, briefs gated**: FS131-K6c (wave 6's third planning pass, on `fs131-w6` itself, new modules only;
   `data/fs131/briefs/FS131-K6c-wave6-third.md`, generator `mk-k6c.py`), FS131-I6C (`Curve` then `LocalGraph`, tree `fs131-w6c`) and FS131-I6D
   (`FanBridge`'s existence half with `sq9.SingLocallyFinite`, tree `fs131-w6f`; `data/fs131/briefs/FS131-I6C-wave6-bridge.md`, `FS131-I6D-wave6-bridge.md`,
   generator `mk-i6b.py C|D`; both trees cut from `32f2ab4c`). FS131-I6E (`FanBridge`'s five `Fan` lemmas, tree `fs131-w6g` from `32f2ab4c`;
   `data/fs131/briefs/FS131-I6E-wave6-bridge.md`, `mk-i6b.py E`; I6D and I6E edit one file in disjoint regions, by their briefs). **Not written**: MD1, MD2. The other jobs ready: **FS131-I10C** (`debruijn-implementer`, `model: "opus"`; § 3's I10B row);
   **FS131-I6A** (`Pinch`'s seven leaves, on `fs131-w6p`) and **FS131-I6B** (`MapColouring`'s `sat_inP` and its Lean model, on `fs131-w6m`) — both
   implementers, briefs gated (`data/fs131/briefs/FS131-I6A-wave6.md`, `FS131-I6B-wave6.md`; generator `mk-i6.py A|B`), trees made at `3928644b`;
   **the planners of waves 7–9, FS131-K7, K8, K9** (`debruijn`; **briefs gated, trees made** at `e6e7b312` — `data/fs131/briefs/FS131-K7-wave7.md`,
   `FS131-K8-wave8.md`, `FS131-K9-wave9.md`, generator `mk-kw.py 7|8|9`; item 498: they are independent but for four named rows, so launch K7
   before K8, and **relay K7's decision on the word "simple" to K8**); **FS131-MD1**
   (`stuckModel.IsTerminalMap` whole; MC1's record § 3.2 is its work list) and **FS131-MD2** (`IsClean` for `hornModel`, the contact fact at
   `stuckModel`'s vertex, a named `CollarFitOut` on `awayModel`'s gap) — ruling 497 (b), briefs not written. Then:
   (i) **the example maps' landing** — running as FS131-MC1 (§ 3); it was: the landing job when FS131-MB2 is back — merge `fs131-wm` and `fs131-wmb` (MB2 is
   merging A's half itself), merge `main` (wave 5: the brick facts become three lines; add `stuckModel_terminal`, the sub-arc model of
   `bend_away_whole` by `IsRingArc.mono` (471 (c)), the wave-5 applications, `awayModel` read against `bend_away_part` and
   `exists_arcStep`), apply the docstring lines (KM1's plan § 3.10; the stuck family's notes name `stuckModel_hyps`), the gate with
   `scripts/dupnames.sh` and L5's records check (475 (e)), land; (ii) **wave 10's implementers** from FS131-K10's handoff; (iii) **the
   planners of waves 7–9** (`plans/FS131-kernel-plan.md` § 7.1; wave 6's is running) — each on a branch from `main`, its brief derived from
   `data/fs131/briefs/scripts/mk-k6.py` as that one was from `mk-k10.py`; (iv) the second planning pass for E7's `F₀`, `F₁` (461 (d));
   (v) the tidy moves (the three same-fact pairs, item 468; the `Procedure` re-layout, 450 (d); ruling 421 (c)'s named forms; the stale
   "skeleton" words, item 474; BA1's ten re-proved helpers; the self-test's plant directory, 467 (e)); a tooling job on the vacuity
   scan's three questions (475 (d)). Held for the milestone's filing: 475 (b).
1. **The freed lane's continuation**, if it left leaves on wave 5's path (IR2's will).
2. **FS131-E7 — done** (items 440–441: a model for each of the four sets, no contradiction; a terminal plane map with a stuck vertex at twelve
   colours; `nb4p` restated with one conjunct at the remedy pass; two questions held for Poros). It was: a short Ephodos job (`ephodos`): QA4's rank 9 and rank 10's question (`plans/FS131-QA4-audit.md` § 6.2) — a model or a contradiction
   for the backgrounds of `a4six`, `straddlers_third`, `nb4p` (is `sixFrag` one?) and for a doubly shadowed horn under Condition 5 with `Covers`
   (`flank_ne_of_doublyShadowed`); whether a terminal valid plane map with a stuck vertex exists at some `k ≥ 7`. **Brief written and gated**
   (item 428): `data/fs131/briefs/FS131-E7-models.md`, claim list `data/fs131/claims-E7.md`; it writes on `main` under `plans/` and `data/` only.
3. **The models' planner** (`debruijn`): QA4's ranks 4–6 — the planted picture (`sevenBrickMap` relabelled, fresh-coloured pictures by
   `ArcMap.recolour`; models of the four moves, the vertex step, `cvb_hole_disconnected`), the completed bowtie (the stuck family with `Covers`), and
   `cuspFrag.IsRingArc` for the two bends; one overlay construction or two; on a branch from `main`, landing on its own. **Brief written and gated**
   (item 428): `data/fs131/briefs/FS131-KM1-models.md`; its tree `.claude/worktrees/fs131-wm` (branch `fs131-wm` from `main` at `68a3db1d`) is made,
   built and pushed.
4. **`exists_arcStep`'s assembly** in `Procedure` (after the vertex step; one file, one writer), from IA1's work list. It first makes the statement
   repair of ruling 430: `(hP : F.IsPlaneMap)` added, the degree clause restricted to `x ∈ T` and weakened to `≤`, the consumer's three lines.
5. **`bend_away`'s planner**, to the statement IA1 fixes (the repaired statement is on `fs131-w4ba` at `71cca146`; E5 § 4; plan it where the collar's
   radial push lives — it may be reusable).
6. **Wave 5's final sync and landing**: merge `fs131-w5s`, `fs131-w5a` and `fs131-w5c` into one line (I5q's note, item 424: `fs131-w5`'s side for
   `BaseDense`'s children, `HexRing`, `BaseWalk`; `fs131-w5c`'s for `cv_exists`), then **the remedy pass** (ruling 427 (a)): the 17 `bowtie` notes
   (QA4 § 3.5), `bend_toward_collar` without `hmax` and `hlen` with QA4-C1's conjunction named (`data/fs131/qa4/QA4Collar.lean`), rank 7's and rank
   8's wave-5 docstring lines, the three `[NumberField _]` binders (item 419 (a)); then merge `main`, the full gate, the guarded lint, the notes
   check, land, drafts.
7. After wave 5 lands: the tidy moves (items 387 (a), 406 (a), 416, 421 (a), 424), then waves 6–10's planners.

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
  now `data/fs131/mc/receipt-axioms-final2.log` and `data/fs131/mc/receipt-vacuity-final2.log`); file the drafts (`CLAUDE.md` § Trust ledger and § The
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
| `fs131-w9` | moving (K9; from `26b08395`) | wave 9's plan and skeleton |
| `fs131-w6c` (moving, I6C), `fs131-w6f`, `fs131-w6g` | `32f2ab4c` | made for FS131-I6C (`Curve`, `LocalGraph`), FS131-I6D (`FanBridge`'s existence half) and FS131-I6E (its five `Fan` lemmas); builds copied from `fs131-w6` |
| `fs131-w10b` | `423cd8e8` | idle: `StationaryRatio` proved (item 506) |
| `fs131-w10k` | `330d2f48` | idle: wave 10's second planning pass — ten new modules, eleven leaves (item 509); its implementers' branches are cut from it |
| `fs131-w7` | `b5ef0e39` | idle: wave 7's plan and skeleton after one pass — route T's rows, twenty leaves; `Plane/SimpleOn` whole |
| `fs131-w8` (`f1c13612`, idle: wave 8's plan and skeleton after one pass, ten leaves), `fs131-w9` (`26b08395`: wave 7's and wave 8's shared modules) | from `611ffa39` | made for K8 and K9, fast-forwarded to wave 7's shared-module commit; builds copied from `fs131-wmb` (the first build compiles `SimpleOn`) |
| `fs131-w10c` | `8ee0d85b` | idle: `StandingFive` proved (item 519) |
| `fs131-w7a`, `fs131-w8a` | `b5ef0e39`, `f1c13612` | made for FS131-I7A and FS131-I8A (item 527); builds copied from `fs131-w7`, `fs131-w8` |
| `fs131-wd1`, `fs131-wd2` | `1ed1cfd2` (`main`) | made for FS131-MD1 and FS131-MD2 (item 529); builds copied from `fs131-wmb` |
| `fs131-w6l`, `fs131-w6z`, `fs131-w6k` | `6fc27fa1` | made for FS131-I6L, I6Z, I6K (item 532); builds copied from `fs131-w6` |
| `fs131-w10l` | moving (L10A; from `ace98a35`) | wave 10's first pass, being joined and landed |

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
