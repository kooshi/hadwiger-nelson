# Session handoff — 2026-10-04: FS-131, the Lean backlog, in flight (written before a compaction, at Kooshi's word)

*Rewritten 2026-10-04 by Keryx at Kooshi's word ("Please update the handoff, and I'll compact."). Current state only. A successor arriving with nothing
reads this first, then `plans/FS131-close-inventory.md` — every item, ruling and receipt (items 1–183 at this writing; its first two sections are the rules
that judge the milestone, written before any job).*

> **Latest (written at the context limit, 2026-10-04 late):** inventory items run to **186**. **Landed on `main`, held in the kernel**: wave 1, wave 3 (item 157),
> Lebesgue's covering theorem (151), `localSectors` + the separation lemma + `four_of_bothKind_simple` without `hnc` (171); the axiom gate repaired with an IMPORTED
> section (160). **Running (3 Opus slots)**: FS131-I2j (wave 2, 46 lines → landing; item 183), FS131-I4f (wave 4, 45 left, `bowtieCol_locallyConstant` first; item 186), FS131-IWd (Woodall's last 3
> `Merge` leaves, then after wave 4 lands: merge, QA2-1 brick model, gate, landing; item 181). Agent ids in scratch `agents.txt`. **On each hand-back**: check the
> build log, `sorry` count and axioms print; log; brief a successor by script from the previous brief (all implementers Opus, `model: "opus"`); gate; launch.
> **On a landing**: read the gate logs, file counts (`CLAUDE.md` § Trust ledger three-count sentence, § The gate, `scripts/vacuity-baseline.txt`, `GATE_CHANGES` in
> `tools/claude_md_fact_audit.py`), run `gate_report.py` and the fact audit **before** committing. Woodall lands after wave 4 (and deletes its identical copies of
> `abs_dot_le`, `dot_add_left`, `dot_e_e`, `isOpen_shadow`). Kooshi has nothing pending; he approved Opus implementers (137) and the QA2 audit (165, done: 172).
> The Frontier clauses for waves 1/3 and `localSectors` are held for the milestone's filing with the rows' regrading. Waves 5–10 not started (wave 5's planner next
> after a slot frees and waves 2/4 are near landing).

## 1. Read first

1. You are Keryx if your system prompt carries `# Keryx in lean-dir — the workflow` and says **Workflow 3.1**.
2. **The milestone**: FS-131, the Lean backlog (`plans/STUB-lean-backlog.md`; input `plans/LEAN-BACKLOG.md`, 259 rows). Plan: `plans/FS131-kernel-plan.md`
   (dispositions `data/fs131/k1/dispositions.csv`, checker `tools/fs131_k1_dispositions.py`; ten waves, § 7.1; gate design § 7.5 — nothing with a `sorry` on
   `main`, a branch and worktree per wave, land by merging `main` in and fast-forwarding at a green gate).
3. **Staffing (Kooshi, 2026-10-04)**: three Opus-agent slots; a Sonnet agent counts half (`.claude/output-styles/keryx.md` § Staffing). All implementers are Opus
   since the trial (items 129, 137).
4. **Worktree recipe** (Kooshi's): `.lake/packages` symlinked to the main tree's, `.lake/build` copied with `cp -a`; never symlink the build. Up to two 40 GiB
   builds across trees when `scripts/slot.py` admits them (ruling 5).

## 2. State

| job | state | where |
|---|---|---|
| foundation, wave 1 (14 rows) | **landed** on `main` (`d59ffcdf`), the only held wave (item 29) | — |
| wave 2 (28 rows) | 46 lines left (item 182: FS106-REM, V0-RESCALE, `χ_m⁰ ≤ χ_CP` on the branch; docstrings done); **FS131-I2j (Opus) running** to the landing | `.claude/worktrees/fs131-w2` |
| wave 3 (20 rows + 6 merged) | **LANDED** (item 157); `localSectors` and the cusp-free four-colour clause **LANDED** too (item 171, `0131aa59`) | — |
| wave 4 (25 rows) | 41 of 86 proved (item 184: `lock`, the bowtie at `E`); **FS131-I4f (Opus) running** | `.claude/worktrees/fs131-w4` |
| Woodall's chain (FS106-WO, -TW, -AE-MAP6) | 3 leaves left (item 180: E3-W, the E3-BALL composition, `Basic` sorry-free); **FS131-IWd (Opus) running**; lands after wave 4 | `.claude/worktrees/fs131-ww` |
| the maps-six GAPs (Ephodos) | **FS131-E1 done** (items 106–107): both bypassed for arc maps by E1-NO45 [hand, one mind]; corrections filed | record `plans/FS131-E1-derivation.md` |
| Lebesgue's covering theorem (FS131-LEB) | **LANDED on `main`** (item 151; `33471a75`): held in the kernel, standard three; wave 4 discharges its `sorry` in one line | `Proofs/HadwigerNelson/Topology/` |
| waves 5–10 (124 rows) | not started; wave 5 carries C-DOUBLE + Y3-END-NEEDS (item 69) and FLANK-Q's discharge (item 79); wave 9 bound by item 89's note and item 96's vacuity rule | plan § 7 |

**The finding with bearing** (items 88, 91): the repaired proof of "maps need six" has two GAPs — step 7 open in every class (even with no unit-arc boundaries),
step 5's equality case open with unit arcs — one mind (W), from the page images. Route M's "χ_m⁰(ℝ²) ≥ 6 at five" (FS111-M2-REDUCE-C and kin) rests on it.
**Corrections filed** from E1's § 4.3 (item 107): row 132, § The aim item 4, FS106 errata — maps need six for arc maps; Jordan form owed.

**Statement problems so far** (all ruled; none had anything built on it): from derivations or merges — items 18–19, 34, 37, 39, 86; Lean slips — 48, 57, 61,
63, 72, 77, 100; a gap — 56; table edges missed — 69, 79; a non-result in the backlog — item 5 (R1). About 35 generalizations logged for errata.

## 3. Running now (slots used: 1 + 1 + 1 = 3 of 3, all Opus)

| job | model | brief | reports to |
|---|---|---|---|
| FS131-IWd (Woodall's last three leaves; after wave 4 lands: merge, brick-map model, gate, landing; item 181) | Opus | `data/fs131/briefs/FS131-IWd-woodall-merge.md` | branch `fs131-ww`'s `data/fs131/reports/FS131-IWd.md` |
| FS131-I4f (wave 4 on Opus: `bowtieCol_locallyConstant` first, the bowtie, the rest, the landing; item 186) | Opus | `data/fs131/briefs/FS131-I4f-wave4.md` | branch `fs131-w4`'s `data/fs131/reports/FS131-I4f.md` |
| FS131-I2j (wave 2 on Opus: 46 lines, the carriers, the gate, the landing; item 183) | Opus | `data/fs131/briefs/FS131-I2j-wave2.md` | branch `fs131-w2`'s `data/fs131/reports/FS131-I2j.md` |


**Implementers are Opus** (Kooshi, item 137): each launches with `model: "opus"` (the agent file says so too) and counts one slot.


Agent ids are in this session's scratch (`agents.txt`), never in a file. A notification arrives when each hands back; if the session restarted, resume a job from
its record's last SAVED stage with a fresh agent on the same brief.

## 4. Next, in order

1. **On each hand-back** (I2j, I4f, IWd): review by artifact (build log, `sorry` count, axioms print from a saved log), log the inventory item, and if work
   remains brief an Opus successor by script from the job's own last brief (`data/fs131/briefs/`), gate it with
   `python3 .claude/skills/keryx/scripts/brief_gate.py all <brief>` (full worktree paths in source lines; no § inside a heading address), launch with
   `model: "opus"`.
2. **On a landing**: before the gate on the merged branch, `tools/fs131_qa1_dupes.py` (the later branch renames or deletes colliding names); then read the
   worktree's `build/gate/*/latest` and the axioms digest (`scripts/gate_report.py axioms <log> <prev> CLAUDE.md`), read one statement back, file the counts
   (`CLAUDE.md` § Trust ledger sentence and § The gate counts line; `scripts/vacuity-baseline.txt` header lines 25–26; a `GATE_CHANGES` entry in
   `tools/claude_md_fact_audit.py`), run the fact audit with `--base` the last `CLAUDE.md` commit, then commit and log the receipt. The second of waves 2 and 4
   to land merges the first's vacuity carriers. Woodall (IWd) lands after wave 4 and deletes its identical copies of `abs_dot_le`, `dot_add_left`, `dot_e_e`,
   `isOpen_shadow`, and adds QA2-1's brick-map model (item 172).
3. **When a slot frees with waves 2 and 4 near landing**: wave 5's planner (Opus `debruijn`) — reads wave 4's plan § 14.5 first; carries C-DOUBLE +
   Y3-END-NEEDS (item 69) and FLANK-Q's discharge (item 79); `Row134Base` needs its stub (item 17 (b)).
4. **Queued, conditional**: an Ephodos job on `exists_not_uniform_kept`'s fringe colouring only if wave 2's implementer cannot find a proper formula (item 118).
5. **At the milestone's filing**: the Frontier clauses (I3h's and I3i's drafts), the rows regraded to [kernel], the Proof Atlas update, `ARCHITECTURE.md` § 3's
   stale prose counts, the `LEAN.md` pattern line for `threeSectorDisc` adversaries (at Woodall's landing). Optional stub: Woodall's horn-only form everywhere
   (no consumer).

## 5. Process notes that saved slips

- Quote a report from its **file**, never from the hand-back text (they differ; item 32). Worktree files are addressed by their worktree path in a brief's source line.
- `merged_into` can name two rows separated by `;` (item 28).
- Subagents see the `CLAUDE.md` loaded at their launch, not the file on disk (item 43).
- Every implementer so far has handed back at 300k–490k with leaves left: brief successors from the shared record's last stage.

## 6. Held for Kooshi, with defaults

- The GitHub repository `decalion89/chromatic-number-of-the-plane` (release v1.1.0; claims Lean proofs of rows 103 and 57; item 9) — Kooshi is reading it; the
  record holds its name from a search listing only, and the same pass saw an unread Zenodo record claiming a formal verification that the plane is
  seven-chromatic (`plans/FS131-kernel-plan.md` § 3.2). Addresses (item 105). **Audited (EXT-HN1, items 108–122)**: the outside-account-1 repository (= the Zenodo record) states no Hadwiger–Nelson result;
  The outside repository's issue is written. The audit's Mathlib harness was deleted at Kooshi's word (item 123); the evidence is in `data/external/hn1/`.
- From FS-129: the order (backlog, then FS-124 — stands); the finite-graph search (held); a blind second mind on FS129-OR1-QFREE (none); FS-129 closes when its 32
  compositions pass (spread across waves).
- The Proof Atlas: two stale page notes and the zoomed labels (item 4), at the next atlas update.
