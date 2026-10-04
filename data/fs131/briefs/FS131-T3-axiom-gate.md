# Brief FS131-T3 — the axiom gate: check that CLEAN means the standard three, and give declared outside theorems their own category

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-T3
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; this is a project-tooling job (its § Project tooling); you run on Opus, as every implementer now does (inventory item 137)
  role: close the axiom gate's gap the code-quality audit found — a CLEAN record carrying an outside axiom passes today — with a subset check on CLEAN and an IMPORTED category for declared outside theorems, each with a planted control watched firing; leave `main`'s gate green with its counts reconciled
  launch: now, beside FS131-I3h (wave 3) and FS131-IWb (Woodall's chain), each in its own worktree; you work in the main tree
  mission: § Why this job
  statements: § The defect
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job only for a question you cannot work around; the report goes to `data/fs131/reports/FS131-T3.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate and § Trust ledger above all), and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-T3-axioms.md`
  touches: `scripts/axioms.sh`, `scripts/gate_report.py`, `scripts/Axioms.lean` (its banners and its own controls only — never a wave's records), a controls file of your own under `scripts/` if the controls need one, `plans/FS131-T3-axioms.md`, `data/fs131/t3/`, `data/fs131/reports/FS131-T3.md`
  budget: about 250k by the harness's count, as guidance; hand back at a saved stage before about 400k

Hello. The axiom gate (`scripts/axioms.sh` over `scripts/Axioms.lean`, digested by `scripts/gate_report.py`) is what lets this project say "on the standard
three axioms" about a theorem. Until now every outside dependency was a native-evaluation purchase, which has its own PURCHASED section. Wave 2 of the Lean
backlog brings the first *declared outside theorem*: `falconer_lemma2_nonempty`, an `axiom` standing for Falconer's 1981 Lemma 2 (i), with the four items
`LEAN.md` § Assumptions requires done. The code-quality audit FS131-QA1 found that the gate would file it wrongly.

## Why this job

Wave 2 cannot land until its gate reads true, and "clean" must mean what the Trust ledger says it means. Nothing about the standard of evidence moves
(`CLAUDE.md` § Counter-priors, rule 4).

## The defect

The audit's finding and the coordinator's ruling, as logged:

> 144. **FS131-QA1 done, harness ≈ 380k** (report `data/fs131/reports/FS131-QA1.md`; record `plans/FS131-QA1-audit.md`; commits `1905567e`, `bbee15f0`, `e7a91c31`, `2153ea8e`,
> — source: plans/FS131-close-inventory.md

(the item continues there; its part (b) is this job. Its vacuity half — tracking `CPColouring` and `AeProperRegions` — is not yours: those carriers exist only
on waves 2 and 4's branches, so each wave registers them at its own landing.) The rule the CLEAN section is documented to enforce, which the script does not:

> * **CLEAN** — every line must be exactly `propext`, `Classical.choice`, `Quot.sound`. Any
> — source: scripts/Axioms.lean

The script's CLEAN check today rejects only `native_decide`/`ofReduceBool` and `sorryAx` (`scripts/axioms.sh`, the block after "BAD=0"). On wave 2's branch,
`le_chiM_of_falconerFan` sits under CLEAN and depends on `falconer_lemma2_nonempty`; it would pass and be counted clean.

## Done means

1. **The defect reproduced first**, on `main`: a planted record under CLEAN whose axioms include a planted `axiom` passes today; logged in your record.
2. **The fix**: (a) CLEAN fails on any record whose axioms are not a subset of `propext`, `Classical.choice`, `Quot.sound`; (b) an **IMPORTED** section
   (a banner like the two existing ones) for records that depend on a **declared** outside theorem, where "declared" means listed in one place you choose
   and document — `ARCHITECTURE.md` § Trust already lists `falconer_lemma2_nonempty` with its four items — and an IMPORTED record fails if it carries any axiom
   beyond the standard three and declared imports; (c) `scripts/gate_report.py` counts IMPORTED records and reports them in its digest, and its reading of
   `CLAUDE.md` § Trust ledger's sentence learns the new count (draft the new sentence for me).
3. **Controls, each watched firing**: a CLEAN record with an undeclared axiom fails; an IMPORTED record with an undeclared axiom fails; an IMPORTED record with
   only a declared import passes; the existing checks still fire (`sorryAx`, a native purchase under CLEAN, a stale purchase).
4. **`main`'s gate green with the counts reconciled**: `./scripts/axioms.sh` on `main` (no declared import is on `main` yet, so IMPORTED is empty and the clean
   count is unchanged — say so); `./scripts/build.sh` if you touch `scripts/Axioms.lean`.
5. **How a wave declares an import**, written where the next landing implementer will read it (a docstring in `scripts/Axioms.lean` beside the banner, in
   the form of FS131-T1's procedure in `scripts/Vacuity.lean`), so wave 2's landing moves `falconer_reduction`, `le_chiM_of_falconerFan` and any other
   dependent record into IMPORTED.
6. **Drafts for the front page** in your record (`## Drafts for the front page`): `CLAUDE.md` § Trust ledger's sentence with the IMPORTED count, and any
   line `LEAN.md` § Trust ledger needs. I file them; you do not edit those files.
7. Your record in stages headed "Stage n — SAVED", committed by explicit path on `main` and pushed (`main`'s gate green after each commit); the report in
   standing rule 11's form.

## What is yours to decide

The shape of the fix, where the declared-import list lives, the banner's name, and how `scripts/gate_report.py` reads the new section. If matching the documented
rule exactly would break a record on `main`, stop and message me with it — that would be a finding about a theorem, not a tool failure.

## The machine

Builds through `./scripts/build.sh` under the slot (`/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`), never `lake build`; the axiom audit under the slot too (`scripts/slot.py --mem 24 --cpus 4 -- ./scripts/axioms.sh`). Two implementers
are building in other worktrees, so on exit 75 wait ten minutes and retry. Commit by explicit path on `main` and push. You start no agents of your own
(standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
