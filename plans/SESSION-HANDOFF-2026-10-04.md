# Session handoff — 2026-10-04: FS-131, the Lean backlog, in flight (written before a compaction, at Kooshi's word)

*Rewritten 2026-10-04 by Keryx at Kooshi's word ("Please update the handoff, and I'll compact."). Current state only. A successor arriving with nothing
reads this first, then `plans/FS131-close-inventory.md` — every item, ruling and receipt (items 1–103 at this writing; its first two sections are the rules
that judge the milestone, written before any job).*

## 1. Read first

1. You are Keryx if your system prompt carries `# Keryx in lean-dir — the workflow` and says **Workflow 3.1**.
2. **The milestone**: FS-131, the Lean backlog (`plans/STUB-lean-backlog.md`; input `plans/LEAN-BACKLOG.md`, 259 rows). Plan: `plans/FS131-kernel-plan.md`
   (dispositions `data/fs131/k1/dispositions.csv`, checker `tools/fs131_k1_dispositions.py`; ten waves, § 7.1; gate design § 7.5 — nothing with a `sorry` on
   `main`, a branch and worktree per wave, land by merging `main` in and fast-forwarding at a green gate).
3. **Staffing (Kooshi, 2026-10-04)**: three Opus-agent slots; a Sonnet agent counts half (`.claude/output-styles/keryx.md` § Staffing). He also authorized
   **one Opus-implementer trial** (item 103): run `debruijn-implementer` with the Agent tool's `model: "opus"` as wave 2's next implementer after FS131-I2e, and
   compare leaves closed per session against I2–I2e (items 49, 58, 70, 82).
4. **Worktree recipe** (Kooshi's): `.lake/packages` symlinked to the main tree's, `.lake/build` copied with `cp -a`; never symlink the build. Up to two 40 GiB
   builds across trees when `scripts/slot.py` admits them (ruling 5).

## 2. State

| job | state | where |
|---|---|---|
| foundation, wave 1 (14 rows) | **landed** on `main` (`d59ffcdf`), the only held wave (item 29) | — |
| wave 2 (28 rows) | 91 `sorry` lines left (I2g, item 148); FALC-RED sorry-free over the declared import; **FS131-T3 must land before wave 2's gate**; next: an Opus implementer | `.claude/worktrees/fs131-w2` |
| wave 3 (20 rows + 6 merged) | 94 of 96 proved (I3–I3g, items 131, 145, 147); **FS131-I3h (Opus) running**: two leaves, gate, landing, then `localSectors` | `.claude/worktrees/fs131-w3` |
| wave 4 (25 rows) | 32 of 86 proved (I4, I4b; items 125, 143); two plan routes owed (`lemmaL`, `lock` clause 1); ~20 leaves wait on `localSectors`; **next: an Opus implementer when a whole slot frees** | `.claude/worktrees/fs131-w4` |
| Woodall's chain (FS106-WO, -TW, -AE-MAP6) | all but two leaves proved (items 150, 156): `exists_sectorsAt` (route ready, next implementer) and `exists_woodallMerged` (Woodall's step 3, **FS131-E3 deriving**) | `.claude/worktrees/fs131-ww` |
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
| FS131-E3 (Woodall's step 3: derive the modification, or a route around it; Ephodos; item 156) | Opus | `data/fs131/briefs/FS131-E3-woodall-step3.md` | `data/fs131/reports/FS131-E3.md` (claim list `data/fs131/claims-E3.md`) |
| FS131-T3 (the axiom gate: CLEAN subset check, IMPORTED category; item 153) | Opus (tooling, main tree) | `data/fs131/briefs/FS131-T3-axiom-gate.md` | `data/fs131/reports/FS131-T3.md` |
| FS131-I3h (wave 3 on **Opus**: last two leaves, the gate, the landing; then `localSectors` on `fs131-w3b`; item 147) | Opus | `data/fs131/briefs/FS131-I3h-wave3.md` | its branch's (`fs131-w3`) `data/fs131/reports/FS131-I3h.md` |


**Implementers are Opus from now on** (Kooshi, item 137): the four Sonnet implementers above finish on Sonnet; each successor launches with `model: "opus"` (the agent file says so too) and counts one slot.

Agent ids are in this session's scratch (`agents.txt`), never in a file. A notification arrives when each hands back; if the session restarted, resume a job from
its record's last SAVED stage with a fresh agent on the same brief.

## 4. Next, in order

1. ~~Fill the free slot~~ — done: FS131-K2d launched (item 104). The next free slot (a half when I3e hands back): FS131-IW or FS131-I4 (Sonnet), briefs derived
   from the nearest earlier brief by script, gated with `python3 .claude/skills/keryx/scripts/brief_gate.py all`.
2. (done) The Opus-implementer trial scored (item 129); Kooshi moved every implementer to Opus (item 137).
3. Then FS131-LEB (Opus planner, Lebesgue's covering theorem; a source to read and a `BIBLIOGRAPHY.md` row to propose — item 66).
4. Wave 5's planner once wave 4's statements stand (they do) — it reads wave 4's § 14.5 first; `Row134Base` needs its stub (item 17 (b)).
5. **E1 done (items 106–107)**; its corrections filed (row 132, § The aim item 4, FS106 errata). Held for Kooshi: a second mind on E1-NO45 (default: none).
   **Queue for whole Opus slots, in order**: Woodall's `exists_sectorsAt` (IWc, the stage-6 route) — wave 4's Opus implementer (I4c: `lebesgue_covering_square`'s one-line discharge, the two plan gaps, `localSectors`
   once I3h states it, `AeProperRegions` as a vacuity carrier) — wave 2's Opus implementer (I2h: QA1's docstrings and FALC-HOSTS (iv) docstring, `CPColouring`
   as a vacuity carrier, T3 before its gate). QA1 done (item 144, grade B+).
   FS131-I4 launched in I2e's half slot (item 115); I3e's half slot, when it frees, goes to FS131-IW once W2 has re-planned, else a wave-2 or wave-4 Sonnet successor.
   FS131-E2 done (items 139–140): the cusp case holds in the simple class; the skeleton's loose form was false (the monster); errata filed. Queued: an Ephodos
   job on `exists_not_uniform_kept`'s fringe colouring only if wave 2's implementer cannot find a proper formula (item 118).
6. **(done) On E1's report**: file its verdicts; if a GAP closes, tell the Woodall implementer; file the row 132 / § The aim corrections per the verdict (W's drafts, plan
   § 5) and the FS106 errata through the record job.
7. **On a landing** (wave 3 is closest): read the worktree's `build/gate/*/latest`, the axioms digest (`scripts/gate_report.py axioms <log> <prev> CLAUDE.md`),
   read one statement back, file the counts (`CLAUDE.md` § Trust ledger line and § The gate counts line; `scripts/vacuity-baseline.txt` header lines 25–26),
   log the receipt. The second of waves 2 and 3 to land merges the first's vacuity carriers. **Before the gate on a merged branch**: run `tools/fs131_qa1_dupes.py`; the later-landing branch renames or deletes its colliding
   names (item 142: six known — `framePt`, `dist_rot`, `eq_norm_mul_e_arg`, `e_add_int_mul_two_pi`, `e_mul_conj_e`, `abs_dot_le`).

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
