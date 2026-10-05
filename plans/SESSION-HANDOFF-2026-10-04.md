# Session handoff — 2026-10-04: FS-131, the Lean backlog, in flight (written before a compaction, at Kooshi's word)

*Rewritten 2026-10-04 by Keryx at Kooshi's word ("Please update the handoff, and I'll compact."). Current state only. A successor arriving with nothing
reads this first, then `plans/FS131-close-inventory.md` — every item, ruling and receipt (items 1–320 at this writing; its first two sections are the rules
that judge the milestone, written before any job).*

> **Latest (written before a compaction at Kooshi's word, 2026-10-05 early):** inventory items run to **320**. **Landed on `main`, held in the kernel**: waves 1,
> 2 (item 270; counts filed, item 271), 3 (item 157); Lebesgue (151); `localSectors` (171). **Staffing**: four Opus slots (item 211; no fifth, item 255).
> **WAVE 4 LANDED** (item 318; `main` at `60ff1843`, gated `4fa41167`; counts filed, item 319). **Running (4)**: **FS131-WL1** (`fs131-ww`: Woodall's landing — merge `main`, `framePt → fromFrame` on the branch's side (item 318's correction (1)), delete identical copies, QA2-1's brick-map model, the full gate, fast-forward `main`, drafts of the counts; items 190, 172, 319); **FS131-I5g** (`fs131-w5`: `row134BaseUA`'s four — `reduce`, `select`, `l3_base`, `bv_hex` — then `rot_out`, `rot_in`, `hex_regular`, `bv_nd`, `bv_l3`, then `exists_preBend` over a strengthened-bend child it states against E4-BEND-UN; I5f proved `cor3_local` and `exists_pseudoCircle` and wired `row134BaseUA`; `cv_exists` goes to the `Terminal` implementer, `disc1_local` to the planar lane after the merge-back; items 316–317); **FS131-IP4** (`fs131-w5p`, from IP3's Stage 11: PATH and the strong child, `endpoint_of_far_end` (orientation by PATH's boundary path), the two `retArcs`, F-LOC/CONN/INF/ONE, adversaries, F-RING; `PlaneTopology`, `CurveGraph`, `MapTopology` now sorry-free, the crossing lemma merged in; items 312–313); **FS131-E5** (Ephodos, main tree: Q1 DERIVED — NB3-END item 2 and CVB § 1.4 item 5 hold, no statement change, item 320; now Q2, `bend_away`'s end case; claim list `data/fs131/claims-E5.md`; record `plans/FS131-E5-derivation.md`; items 305–307, 315 (b)). **T-GRAPH is held** on `fs131-w5t` (IT1, item 314: `reduced_props_of_planarLike`, `triLattice_planarLike`, `ladder_adversary`, the block in `Proofs/HadwigerNelson/Thomassen.lean`); IP4 merges that branch at its next saved stage and takes F-SEP (item 315 (a)); `fs131-w5t` then joins the removal list. **The crossing lemma is held** on `fs131-w5x` (IX1, item 302); IP3 merges that branch at its next saved stage (item 303 (b)); `fs131-w5x` then joins the removal list. **G4 ruled mid-job** (item 304): docstring notes, not a model, for the three stuck theorems; the stuck-fragment model is a stub to write. **MERGE left wave 4** (items 294–295): IMM1 proved the gap's clearness at its ends in `MergeMove` (15 theorems) and handed back at its line; MERGE's successor FS131-IMM2 (from `fs131-w4mm`'s record § 4, two to three sessions) takes a slot after wave 4's merge-and-gate and Woodall's landing job, and MERGE lands on its own afterwards (restore `exists_merge` and `exists_merge_aux`). **Slot order** (item 317 (e), ruled per slot as each frees): the `Terminal` implementer (its own worktree cut from `fs131-w5` at launch, with `cv_exists`; E5 § 3 its route for `n3_end_of_not_inType` and `cv_class`), unblocked by item 320; then IMM2; then IMM2; then `bend_away`'s job. **On WL1's hand-back**: read its saved gate logs, file its drafts (`gate_report.py` and the fact audit before committing), push notify. **`bend_away`** is saved on branch `fs131-w4ba` (`71cca146`) for its own job after E5's verdict; **MERGE** lands from `fs131-w4mm` with IMM2 (restore `exists_merge`, `exists_merge_aux`, `Contact`'s header line, the `ARCHITECTURE.md` mentions; `framePt → fromFrame`). **Every unmerged branch** applies `framePt → fromFrame` at its merge (item 318). **Wave 5 lands** after
> wave 4 and after `fs131-w5p` merges back (planar chain six to nine sessions, the longest path; I5c left 37 leaves, 30 the lane's). **Waves 6–10** not
> started; wave 10 independent. **Held for the filing**: wave 2's drafts 5–7 (item 271); rows 134/135/137 (item 227); errata to FS112-N3-PAIRS (I4k's draft,
> item 264), N4-RAY's route (262 (a)), FS112-N2-BENDS (radius-2 arc in the domain, 291), CVB's frame (phantom arcs, 277), NB3-END's case split (288);
> KP's `LEAN.md` line at wave 5's landing (282); `InMK` if unconsumed (274 (a)); the Frontier clauses; the Proof Atlas; `ARCHITECTURE.md` prose counts;
> finished worktrees' removal after rescuing cited gate logs (leb, w1, w2, w2d, w3, w3b, w4c, w5b). **Tool defects owed**: `tools/fs131_i5_dupes.py`'s FORK
> after merges (284); `scripts/vacuity.sh`'s "twenty" banner (271); the axiom self-test's hard-coded counts (259); the brief gate's wrong-§ false pass (206,
> 215). **On each hand-back**: commits, build log's last line and warnings, `sorry` count, axioms print; log; successor brief by script from the previous brief
> (Opus), gate, launch, scratch `agents.txt`, handoff. **On a landing**: gate logs, file counts (`CLAUDE.md` § Trust ledger, § The gate,
> `scripts/vacuity-baseline.txt`, `GATE_CHANGES`), `gate_report.py` and the fact audit **before** committing, push notify. Reporting: no per-step reports;
> push only for what Kooshi must know (memory `reporting-cadence`).

## 1. Read first

1. You are Keryx if your system prompt carries `# Keryx in lean-dir — the workflow` and says **Workflow 3.1**.
2. **The milestone**: FS-131, the Lean backlog (`plans/STUB-lean-backlog.md`; input `plans/LEAN-BACKLOG.md`, 259 rows). Plan: `plans/FS131-kernel-plan.md`
   (dispositions `data/fs131/k1/dispositions.csv`, checker `tools/fs131_k1_dispositions.py`; ten waves, § 7.1; gate design § 7.5 — nothing with a `sorry` on
   `main`, a branch and worktree per wave, land by merging `main` in and fast-forwarding at a green gate).
3. **Staffing (Kooshi, 2026-10-04)**: three Opus-agent slots, **four during FS-131** (item 211); a Sonnet agent counts half (`.claude/output-styles/keryx.md` § Staffing). All implementers are Opus
   since the trial (items 129, 137).
4. **Worktree recipe** (Kooshi's): `.lake/packages` symlinked to the main tree's, `.lake/build` copied with `cp -a`; never symlink the build. Up to two 40 GiB
   builds across trees when `scripts/slot.py` admits them (ruling 5).

## 2. State

| job | state | where |
|---|---|---|
| foundation, wave 1 (14 rows) | **landed** on `main` (`d59ffcdf`) (item 29) | — |
| wave 2 (28 rows) | **LANDED on `main`** (item 270, `6f20e12f`); counts filed (item 271) | — |
| wave 3 (20 rows + 6 merged) | **LANDED** (item 157); `localSectors` and the cusp-free four-colour clause **LANDED** too (item 171, `0131aa59`) | — |
| wave 4 (25 rows) | **LANDED on `main`** (item 318, `60ff1843`); counts filed (item 319); the bends proved, `bend_away` out to `fs131-w4ba`; `Contact` lane merged into `fs131-w4` (item 267); SHAVE, RAY proved on `fs131-w4m` (286); MERGE left wave 4 (295): IMM1 proved its ends on `fs131-w4mm`, IMM2 later, own landing; `n3_end` moved to wave 5 (289); I4n merges and does the bends | `.claude/worktrees/fs131-w4` |
| Woodall's chain (FS106-WO, -TW, -AE-MAP6) | **all five Woodall modules sorry-free** (item 190); the chain theorems wait only on wave 4's statements; **idle** — after wave 4 lands, one Opus job: merge `main`, delete the identical copies, QA2-1's merged `sevenBrickMap`, gate, landing | `.claude/worktrees/fs131-ww` |
| the maps-six GAPs (Ephodos) | **FS131-E1 done** (items 106–107): both bypassed for arc maps by E1-NO45 [hand, one mind]; corrections filed | record `plans/FS131-E1-derivation.md` |
| Lebesgue's covering theorem (FS131-LEB) | **LANDED on `main`** (item 151; `33471a75`): held in the kernel, standard three; wave 4 discharges its `sorry` in one line | `Proofs/HadwigerNelson/Topology/` |
| wave 5 (13 rows + the base) | 28 `sorry` declarations on `fs131-w5` (I5f, item 316): 10 with I5g, 9 in `Terminal` plus `cv_exists` after E5, `disc1_local` to the planar lane; the planar seven on `fs131-w5p` (KP planned, item 282; IP1 proved both pinch-and-hole clauses and the foundation, item 292; IP2 proved E4-OUTERMOST and E4-RIM, item 300; IP3 built BG and `exists_far_end`, item 312; IP4 running; the crossing lemma held on `fs131-w5x`, item 302; T-GRAPH held on `fs131-w5t`, item 314) | `.claude/worktrees/fs131-w5`, `fs131-w5p` |
| waves 6–10 (111 rows) | not started; wave 10 (arithmetic) depends on nothing in waves 4–9 and can be planned whenever a slot frees; wave 9 bound by item 89's note and item 96's vacuity rule | plan § 7 |

**The finding with bearing** (items 88, 91): the repaired proof of "maps need six" has two GAPs — step 7 open in every class (even with no unit-arc boundaries),
step 5's equality case open with unit arcs — one mind (W), from the page images. Route M's "χ_m⁰(ℝ²) ≥ 6 at five" (FS111-M2-REDUCE-C and kin) rests on it.
**Corrections filed** from E1's § 4.3 (item 107): row 132, § The aim item 4, FS106 errata — maps need six for arc maps; Jordan form owed.

**Statement problems so far** (all ruled; none had anything built on it): from derivations or merges — items 18–19, 34, 37, 39, 86; Lean slips — 48, 57, 61,
63, 72, 77, 100; a gap — 56; table edges missed — 69, 79; a non-result in the backlog — item 5 (R1). About 35 generalizations logged for errata.

## 3. Running now (slots used: 1 + 1 + 1 + 1 = 4 of 4, all Opus)

| job | model | brief | reports to |
|---|---|---|---|
| FS131-WL1 (Woodall's landing on `fs131-ww`; items 190, 319) | Opus | `data/fs131/briefs/FS131-WL1-woodall-land.md` | branch `fs131-ww`'s `data/fs131/reports/FS131-WL1.md` |
| FS131-I5g (wave 5's non-`Terminal` half, continued; items 316–317) | Opus | `data/fs131/briefs/FS131-I5g-wave5.md` | branch `fs131-w5`'s `data/fs131/reports/FS131-I5g.md` |
| FS131-IP4 (the planar chain from IP3's Stage 11; items 312–313) | Opus | `data/fs131/briefs/FS131-IP4-planar.md` | branch `fs131-w5p`'s `data/fs131/reports/FS131-IP4.md` |
| FS131-E5 (Ephodos: NB3-END item 2 and `cv_class`'s exclusion; `bend_away`'s end case; items 305–307, 315) | Opus | `data/fs131/briefs/FS131-E5-two-steps.md` | `data/fs131/reports/FS131-E5.md` |


**Implementers are Opus** (Kooshi, item 137): each launches with `model: "opus"` (the agent file says so too) and counts one slot.


Agent ids are in this session's scratch (`agents.txt`), never in a file. A notification arrives when each hands back; if the session restarted, resume a job from
its record's last SAVED stage with a fresh agent on the same brief.

## 4. Next, in order

1. **On each hand-back** (I2n, I4k, IC5, IM1): review by artifact (build log, `sorry` count, axioms print from a saved log), log the inventory item, and if work
   remains brief an Opus successor by script from the job's own last brief (`data/fs131/briefs/`), gate it with
   `python3 .claude/skills/keryx/scripts/brief_gate.py all <brief>` (full worktree paths in source lines; no § inside a heading address), launch with
   `model: "opus"`.
2. **On a landing**: before the gate on the merged branch, `tools/fs131_qa1_dupes.py` (the later branch renames or deletes colliding names); then read the
   worktree's `build/gate/*/latest` and the axioms digest (`scripts/gate_report.py axioms <log> <prev> CLAUDE.md`), read one statement back, file the counts
   (`CLAUDE.md` § Trust ledger sentence and § The gate counts line; `scripts/vacuity-baseline.txt` header lines 25–26; a `GATE_CHANGES` entry in
   `tools/claude_md_fact_audit.py`), run the fact audit with `--base` the last `CLAUDE.md` commit, then commit and log the receipt. The second of waves 2 and 4
   to land merges the first's vacuity carriers. Woodall (IWd) lands after wave 4 and deletes its identical copies of `abs_dot_le`, `dot_add_left`, `dot_e_e`,
   `isOpen_shadow`, and adds QA2-1's brick-map model (item 172).
3. **Wave 5**: planned (items 198, 207, 216) and **GAP-ELEVEN repaired** (items 226–227: `UnenclosedC` on `Row134BaseUA` and `n3_base`; rows 134, 137
   stand; row 135's base clause corrected at the filing). **Wave 5 paused** at 44 leaves on `fs131-w5` (items 238, 246; 7 of them the planar job's, items 239, 242, 247 (b)); it resumes in the
   next free slot (I5b's successor, from I5's record Stage 8; it must also apply ruling 252 — `stuck_structure_ua`'s sides clause to form (b)). **Wave 4's merge**: when FS131-I4k, FS131-IC5 and FS131-IM1 are done: merge `fs131-w4m` into `fs131-w4c`
   (`Contact`'s head block now lives in `Plane/ValidMap/Cone`, item 254; its three moves become citations of `Moves`' `…_aux`), then `fs131-w4c` into `fs131-w4`, then the gate — on Keryx's word (items 209, 236). **Queue**: **FS131-QA3, the definitions audit, takes wave 2's slot when FS131-I2n hands back** (item 256) (Kooshi approved it within the four slots, item 255;
   brief `data/fs131/briefs/FS131-QA3-definitions.md`, gated, ready), then **wave 5's next implementer**, then the planar-infrastructure job (items 218 (c), 227, 239:
   `cvb_thom_reduced`, `retArcs_nested`, `exists_endpoint`, `exists_eleventh`, `exists_unenclosed_or_bad`, and the shared planar lemma). **At the filing**: `LEDGER.md` rows 135, 137, 134 from E4 § 5.4 items 1–3 (item 227).
   **When wave 4 lands**: brief the Woodall landing job (item 190's list).
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
