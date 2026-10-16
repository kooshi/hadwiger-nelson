# Brief FS131-FC10 — the collapse's filing: FS131-ICO2's thirteen drafts, word for word, and the audits

*Written 2026-10-16 15:09 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-FC10
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; here you are the coordinator's pen for one filing
  role: the pen for the drafts a kernel implementer wrote when its module landed on `main` — thirteen drafts, each naming its slot, filed word for word by a script, then the audits
  launch: now, in a worktree with no Lean build, on a fresh branch cut from `main`; beside you two kernel implementers in other worktrees, writing none of these files
  mission: § Why this job
  statements: § What is filed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a slot is not found exactly once, or a check fails in a way no draft explains; the report goes to `data/fs131/reports/FS131-FC10.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `data/fs131/reports/FS131-FC10.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/filing2` (branch `fs131-fc10`, cut from `main` at `0f81fe2a3`; no Lean build): `CLAUDE.md`, `LEDGER.md`, `README.md`, `ROADMAP.md`, `ARCHITECTURE.md` — each only at the slots the drafts name; `tools/claude_md_fact_audit.py` at its transition table only (one entry, given below); for D13, `tools/viz_proof_atlas_facts.py`, `data/viz/proof-atlas/facts.json` and the built `visualizations/proof-atlas/index.html`, by that folder's README; your scripts and outputs under `data/fs131/fc10/`; `data/fs131/reports/FS131-FC10.md`. Commit on your branch by explicit path; the coordinator merges it; never push; publish nothing
  budget: about 200k by the harness's count, as guidance; save a stage after the readback, after the filing, and after the checks; hand back at a saved stage before about 300k

Hello. A kernel module landed on `main` this afternoon: the statement that the plane over ℚ(√635087) needs exactly as
many colours as the whole plane, now proved with no hypothesis of ours. Its implementer drafted every front-page line the
landing changes. You put them in, exactly as drafted.

## Why this job

The repository is public, and its front page has to say what the kernel now holds. My log of the landing's gate:

> 1004. **FS131-ICO2: the full gate green on one commit, `7c72b9bf7` (logged 2026-10-16 15:00 UTC; by message; branch `fs131-ico1`, stage 7 saved at `e04c74b52`; logs `data/fs131/ico2/gate/` there).** From its message: every step exit 0, tracked files unmodified; no `sorry`, 0 build warnings; audit 11,398 records (10,747 clean, 569 axiom-free, 77 imported, 5 purchases; +96 clean, +15 imported); vacuity no new site, declarations 22,241 → 22,357, refutations-skipped 240 → 242 (`shift_mem_Xk`, `rot_mem_Xk`); assumptions rests 78 → 99, takes 108 → 109; lint 14 of 14; the statement comparison CLEAN but for the three ruled binder drops (items 993, 998). **My receipts:** `run-pass.out` ends "tracked files modified after the pass: 0"; `git diff 7c72b9bf7 HEAD -- Proofs scripts` is empty; I printed from its build (`lake env lean` under the slot, `scratchpad/ico2-axioms.out`): `Collapse.chromaticNumber_planeOver_sqrt635087` and `chromaticNumber_planeOver_deGrey` on the standard three, `Rigidity.positive_entropy_rigidity` and `StandingFive.kloosterman_bound`; `chromaticNumber_planeOver_eq_plane_of_thick` on the standard three and `positive_entropy_rigidity` only (Weil's bound enters at the instances' thickness); D-E1 `StandingFive.norm_normOne_charSum_le` on the standard three, D-E2 `Rigidity.norm_charSum_le_weil` with Weil's bound; the types: both sides `chromaticNumber`, the field's `(unitDistance ℂ).induce (planeOver F)`, the general form for every real number field `F` with `Collapse.Thick F c`, `0 ≤ c`, `c < 1/5`. Waiting for its hand-back (the read-aloud and the drafts) before the merge.
> — source: plans/FS131-close-inventory.md

The merge is `0f81fe2a3` on `main`; the implementer's record is `plans/FS131-ICO2-collapse.md` and its report `data/fs131/reports/FS131-ICO2.md`.

## What is filed

1. **The drafts D1–D13** in `plans/FS131-ICO2-collapse.md` § Drafts for the front page (D1–D8 `CLAUDE.md`, D9 `LEDGER.md` row 128, D10
   `README.md`, D11 `ROADMAP.md`, D12 `ARCHITECTURE.md` § 5, D13 the Proof Atlas). Each names its slot and the words it
   replaces or follows; the implementer checked each slot once in its tree, and `main` has changed since only in `plans/`
   and `data/`, so each should still be found exactly once.
2. **The audit's transition**, because the gate's audit counts move (item 991 of the inventory: last time the audit
   failed on its last line for want of this). The previous entry in `tools/claude_md_fact_audit.py`:

>     (("10650", "5"), ("10651", "5")): "FS-131, the main clause through five as one theorem — Rigidity/MainClauseFive through the gate on one commit: χ(F²) = L(F) whenever L(F) ≤ 5 (Rigidity.chromaticNumber_planeOver_eq_localBound_of_le_five) and min(χ(F²), 5) = min(L(F), 5) (Rigidity.min_chromaticNumber_five_eq_min_localBound_five), on Weil's bound and [EinsiedlerLindenstrauss2022] Thm 1.3, and the model L(ℚ) ≤ 2 on the standard three axioms; the upper half prior art, the lower half this project's derivation (FS131-IL5; copy data/fs131/il5/gate/receipt-axioms.log, gated commit 113ca8ece): 11,287 records, 10,651 clean, 569 axiom-free, 62 imported, 5 purchases",
> — source: tools/claude_md_fact_audit.py

   Add this entry directly after it, exactly as written here (I wrote it; it is the coordinator's bookkeeping):

```
    (("10651", "5"), ("10747", "5")): "FS-131, the collapse — the seven Collapse/ modules and the edits D-E1, D-E2 through the gate on one commit: χ(ℚ(√635087)²) = χ(ℝ²) (Collapse.chromaticNumber_planeOver_sqrt635087) and χ(ℚ(√3,√5,√7,√11)²) = χ(ℝ²) (Collapse.chromaticNumber_planeOver_deGrey), on Weil's bound and [EinsiedlerLindenstrauss2022] Thm 1.3, and χ(F²) = χ(ℝ²) at every real number field uniformly c-thick with c < 1/5 (Collapse.chromaticNumber_planeOver_eq_plane_of_thick) on Thm 1.3 alone; the derivation this project's, row 128 (FS131-KCL1, FS131-ICO1, FS131-ICO2; copy data/fs131/ico2/gate/receipt-axioms.log, gated commit 7c72b9bf7): 11,398 records, 10,747 clean, 569 axiom-free, 77 imported, 5 purchases",
```

3. **D13**: change node `R128`'s entries as the draft says, then rebuild by `visualizations/proof-atlas/README.md` (its
   checker re-reads the quotes from the filed ledger row, so file D9 first); commit the rebuilt page; publish nothing.

## Done means

1. **Stage 1 — the readback.** Check the two quotations above against their sources; list each draft with its slot as
   you find it on your branch (found once, or not).
2. **Stage 2 — the filing, by a script** (`data/fs131/fc10/file_ico2.py`): it asserts every slot exactly once before it
   writes anything, puts each draft's words in exactly, and prints what it did per draft; then the transition; then D13's
   rebuild. (A saved stage.)
3. **Stage 3 — the checks**, each output under `data/fs131/fc10/`:
   `python3 tools/claude_md_fact_audit.py --base 8cab63fa2` and `--base 0f81fe2a3` (the last filing, and this `main`), each
   with its **last line** quoted in your report; the same with `--dupes`; `python3 tools/bib_audit.py`;
   `python3 tools/check_architecture.py`; `CLAUDE.md`'s size against its 80,000-byte budget; and a table of every count
   in `data/fs131/ico2/gate/digest-axioms.txt`, `data/fs131/ico2/gate/digest-vacuity.txt` and
   `data/fs131/ico2/gate/digest-assumptions.txt` against the same count
   as now written in `CLAUDE.md` § Trust ledger and § The gate, `scripts/vacuity-baseline.txt`'s header and
   `scripts/assumptions-ledger.txt`'s header (count, digest, filed, equal or not).
4. **The report**, in the standing rules' form: per draft filed or `CHECK:` with its reason; each check's last lines.

## What is yours to decide

How your script matches a slot and joins a draft to the file's wrapping. Where a draft would make a statement false
against the ledger or the kernel's print, two drafts touch the same words, `CLAUDE.md` goes over its budget, or the audit
reports a token lost, write a `CHECK:` and do not choose: never allow-list a lost token yourself.
