# Session handoff — 2026-10-06: FS-131, the Lean backlog, in flight (written before a compaction, at Kooshi's word, for an overnight run)

*Written 2026-10-06 by Keryx. Current state only. A successor arriving with nothing reads this first, then `plans/FS131-close-inventory.md` — every item,
ruling and receipt (items 1–459 at this writing; its first two sections are the rules that judge the milestone). The handoff before this one,
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
| wave 5's landing | after the three leaves: the merges, one remedy pass (ruling 427 (a)), the full gate with the guarded lint and the notes check |
| waves 6–10 (111 rows) | not started; wave 10 (arithmetic) depends on nothing in waves 4–9 |
| `bend_away` (wave 4's tangent bend) | `sorry` on `fs131-w4ba` at `71cca146`; its planner waits for IA1 to say what statement the arc step needs (item 427 (e)) |

**An open gate item on landed results** (items 419 (d), 426–427): `LEAN.md`'s inhabitant rule asks for a Lean object satisfying every hypothesis of a
theorem at once. The four moves on `main` (`exists_merge`, `exists_rayMerge`, `exists_shave`, `exists_open`) have none in Lean; each has a hand model
(FS131-QA4's record §§ 3.2–3.3; E6's twelve-colour map for OPEN). Truth is not in question (kernel-checked). Kooshi has been told. It closes when the
planted-picture models land (queue item 2).

## 3. Running now (3) — each reports to "main" by hand-back; its report file is on its branch

| job | tree and branch | what | brief | on its hand-back |
|---|---|---|---|---|
| **FS131-RP1** | `.claude/worktrees/fs131-w5c`, `fs131-w5c` (from `3381e47f`: wave 5 joined, item 458) | the remedy pass: the ruled statement tidies (`nb4p`, `bend_toward_collar`, `exists_rayStep`/`exists_shaveStep`, three `[NumberField _]` binders), the corrected inhabitant notes (17 `bowtie` notes; E7's lines), `conj_e` made one declaration and the statements under several names (ruling 459 (c)); it leaves the bend's modules alone | `data/fs131/briefs/FS131-RP1-remedy.md` | its report ends with the list for after the bend's merge; then: merge `origin/fs131-w5z` into `fs131-w5c` (trial first), that list, `main`, the gate with the doubled-name check, land |
| **FS131-BA3** | `.claude/worktrees/fs131-w5z`, `fs131-w5z` (from `dae3d93e`; it holds `fs131-w5a` merged) | BA2's successor: three ruled removals of unread hypotheses (457 (b)), then the outward bend's last two children, `CollarFitOut.map_R1` and `map_R2` (mirrors of `BendCollar` l. 866–1275; BA2's record § 4.6). With them `bend_away_part` is whole. About one stage | `data/fs131/briefs/FS131-BA3-bend-away-mirrors.md` | merge `origin/fs131-w5z` into `fs131-w5c` (after M7; trial it first, item 451); then every leaf of wave 5 is proved and the landing sequence starts |
| **FS131-KM1** | `.claude/worktrees/fs131-wm`, `fs131-wm` (`main`'s line) | a planner (`debruijn`): the example maps — Lean objects on which the four moves' hypotheses, the stuck vertex's, the two bends', FS131-E7's four sets and the outward bend's (`awayModel`) hold at once; one construction (the brick map relabelled, pictures planted by `recolour`) or two; a skeleton, a plan per leaf, a handoff | `data/fs131/briefs/FS131-KM1-models.md` | brief implementers from its handoff; the lane lands on its own from `main` |

Agent ids are in this session's scratch (`agents.txt`), never in a file. If the session restarted, resume a job from its record's last SAVED stage with
a fresh agent on the same brief.

## 4. Queue for the next freed slots, in order (item 427; re-ordered by ruling 434)

0. **Order now** (rulings 457, 459): **FS131-T4, the gate's doubled-name check** (brief written and gated,
   `data/fs131/briefs/FS131-T4-dupnames.md`; tree `.claude/worktrees/fs131-wop` on branch `fs131-t4` from `main`; `debruijn-implementer`,
   `model: "opus"`) at the next free slot — item 458: Lean accepts one theorem name declared by two sibling modules, and `main` holds such a
   pair, `conj_e`; no theorem is in doubt (ruling 459 (a)); when T4 hands back, file its `LEAN.md` bullet and bring its tools to `main`
   before wave 5's landing, which then runs the check; BA3's successor if it leaves a mirror; KM1's implementers. **Then the landing
   sequence**, one job (brief not written): merge `origin/fs131-w5z` into `fs131-w5c` (it holds `fs131-w5a`; `LocalStep.of_cutArcs` and
   `CollarFit.map_localStep` must then print the standard three, 459 (d)); RP1's post-merge list (`hF` out of `CollarFit.map_hornCount_le`,
   the stale headers, the two `ringPt` forms); merge `main`; the full gate, the guarded lint, the notes check, the doubled-name check; land;
   drafts (item 6 below; `bend_away_part`'s inhabitant may be an open gate item, 455 (a)).
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
- **A new worktree**: `git -C <root> worktree add -q -b <br> <root>/.claude/worktrees/<name> <base>`; `mkdir .lake`; symlink `.lake/packages` to the
  main tree's; `cp -a` `.lake/build` from a tree with **no `lake` running in it** (`pgrep -x lake`, then `readlink /proc/<pid>/cwd`); push with `-u`.
  Idle trees with green builds now: `fs131-w5k` (`fs131-w5`'s line at `3b120cd3`), `fs131-wop` (`main`'s line).
- **At a landing** (as OL1's, items 414–415): `git pull --ff-only` in the main tree; read the saved gate logs; `scripts/gate_report.py axioms <log>
  <previous landing's log> CLAUDE.md` and `scripts/gate_report.py vacuity <log> <prev> scripts/vacuity-baseline.txt CLAUDE.md` (the previous logs are
  now `data/fs131/ol/axioms-receipt-landed.log` and `data/fs131/ol/vacuity-scan-landed.log`); file the drafts (`CLAUDE.md` § Trust ledger and § The
  gate, a `GATE_CHANGES` entry in `tools/claude_md_fact_audit.py`); `tools/claude_md_fact_audit.py --base <last CLAUDE.md commit>` (losses should be
  only the superseded counts) and `--dupes` before committing; push-notify Kooshi. Dates in filed counts are the gate logs' UTC date.
- **Rules a landing brief now carries**: the guarded lint after the green build, `lake lint --no-build -- --no-build --trace` under the slot with
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
| `fs131-w5c` | moving (RP1; M7 left it at `3381e47f`) | **wave 5's one line**: `fs131-w5s`, `fs131-w5y` and the bend's skeleton merged; `Procedure`, `Terminal`, `ArcStep`, the density half with no `sorry`; every open leaf is one of the outward bend's children (proved on `fs131-w5z` but two) |
| `fs131-t4` | `main`'s head | new, idle until FS131-T4 launches (worktree `.claude/worktrees/fs131-wop`) |
| `fs131-w5s` | `facdf1c2` | idle; cut from `fs131-w5c` at `ebb0b292`; `stuckRun_ne_univ` proved, `Terminal` with no `sorry` of its own |
| `fs131-w5a` | `74fbdf16` | idle: the outward bend's first half proved (item 454: `LensOut`, `CollarMapOut`, `BendAway`, no `sorry`; Lean sources at `4559c106`); to be merged into `fs131-w5c` |
| `fs131-w5z` | moving (BA3; BA2 left it at `dae3d93e`) | the outward bend whole but two children (item 456): `fs131-w5a` merged in, 34 of 36 children proved, the toward bend's horn child proved |
| `fs131-w5y` | `3f8270c0` | idle: the arc step's assembly `ArcStep` proved (item 447), the last lines for `Procedure` in its report |
| `fs131-w5k` | `3b120cd3` | idle (the collar's lane; `fs131-w5` was fast-forwarded past it) |
| `fs131-wop` | `4b68d47d` | the branch is merged into `main`; its worktree now holds branch `fs131-t4` |
| `fs131-w4ba` | `71cca146` | no worktree; `bend_away`'s repaired statement |
| `fs131-wm` | moving (KM1) | `main`'s line, for the example maps |

## 8. Held for the milestone's filing

Everything in the superseded handoff's paragraph "Held for the milestone's filing" (wave 2's and wave 4's drafts; rows 134/135/137; the errata of items
262, 264, 277, 288, 291, 294, 300, 322, 372 (d); `InMK`; `ARCHITECTURE.md` prose counts; the stuck-fragment model stub; the consolidated errata
register, offered to Kooshi, default at the filing; finished worktrees' removal after rescuing cited gate logs) and its "Tool defects owed" list, plus,
since then: E6's three dated errata (item 385 (b)) and its `e6-open` block's "not claimed" line with OPEN regraded to [kernel] in its lone form (item
414); the omission of `Covers` in E6's draft § 4.5 (2) and KL1's plan row (item 423); KL1's plan corrections (item 420); KP2's plan § 5.1 (item 416);
IO1's record § 3.3 (item 408); the generalizations of items 416, 418, 420, 424; the docstring lines of QA4's rank 8 on `main`'s files (item 426); one
shared statement checker for FS-131 (item 406 (c)); `tools/fs131_io_axioms.py`'s summary class (item 414); `LEDGER.md` regrades (row 132 for Woodall;
FS110-W-MERGE to [kernel]); the Proof Atlas rebuilt and committed, not published (item 413).

## 9. Held for Kooshi, with defaults

- The external repositories (items 9, 105, 108–122): the outside repository's issue is written; nothing waits on it.
- From FS-129: the order (the backlog, then FS-124) stands; the finite-graph search is held; FS-129 closes when its 32 compositions pass.
- The consolidated errata register: offered; default, at the filing.
- Nothing is waiting on a decision of his today.
