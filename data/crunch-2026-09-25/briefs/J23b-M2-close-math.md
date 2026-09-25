*Brief for crunch job **J23b**: milestone M2's close (the kernel lane). Opus 5.5, 2026-09-25. Written by the product owner. **Its
template is J23a's brief** (`data/crunch-2026-09-25/briefs/J23a-M1-close-math.md`): read that in full and follow it, with the changes
below, which override it where they differ.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **M2's close planner**, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`.
Read `CLAUDE.md` (§ The gate, § Trust ledger, § Building), `WORKFLOW.md` (steps 8–9) and `DEBRUIJN.md` from disk.
**`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief.** I'm the product owner.

**If your outputs already exist, you are resuming:** the ticks in `plans/M2-close-inventory.md` and the `Stage n — SAVED` headings in the
plan's §R-close are your map; continue at the first stage not SAVED.

## The milestone (replaces J23a's milestone block)

**M2 = the kernel lane** — plan `plans/M2-kernel-lane.md`. Jobs, all DONE when you launch: J04 (reframe), J14 (the chain theorem,
`plans/M2-S1K-chain.md`), J15 (transcendence, `plans/M2-S2K-route-c.md`), J16 (prime inversion and the stripe lemma,
`plans/M2-S3K-unit-ring.md`), J17 (the bridge write-up, `plans/M2-S1D-bridge.md`), J17K (the bridge in the kernel, conditional,
`plans/M2-S4K-bridge.md`), J17K2 (Lemma NP, `plans/M2-S5K-noparam.md`). Sources: `plans/M2-close-inventory.md`, those records, the
reports, and the index `plans/CRUNCH-2026-09-25-INDEX.md` §3.

## Stage 0 — the full gate, once (WORKFLOW step 8; before any drafting)

Run, reading each exit status from the tool itself (never through a pipe), and keep the logs under `build/gate/`:
1. `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh` — green, 0 warnings. **Never `lake build`.**
2. **`lake lint`, once** (the owner's ruling: it runs at M2's close only, right after the green build, under the slot:
   `scripts/slot.py --mem 60 --cpus 16 -- lake lint`). The lakefile's driver is `batteries/runLinter` on `Proofs`. If it tries to
   rebuild anything beyond the lint driver itself, stop it (by pid, verified by effect) and report — do not let Lake build the library
   outside `build.sh`.
3. `scripts/axioms.sh` and `scripts/vacuity.sh` (and `--self-test`), their counts read against § The gate and § Trust ledger.
4. `tools/check_architecture.py`; `grep -rn --include="*.lean" "sorry" Proofs/` (zero).
5. The inventory's two engineering items: `scripts/Axioms.lean` does not print 13 record-named M2 helper theorems (M2 inventory; add them
   if they are public surface, or say why not), and `data/m2/j16/WheelProbe*.lean` are uncommitted leftovers of J16 (commit them as data
   or delete them, with the reason).
Save the gate's results as `Stage 0 — SAVED`.

## Outputs

As J23a's, for M2: `plans/M2-derivation.md` is replaced by **a kernel register** — every declaration M2 added that a result rests on, with
its file and line, its axioms line, what it states in plain words, and its hand-proof ancestor (the `LEDGER.md` row or derivation entry it
promotes to kernel); the plan's §R-close (the §G, §PA, §IQ re-reads; predictions scored once; the verdict in four parts; the honesty
tally; prices against actuals — every M2 leaf was priced high); **drafts** only in §R-close: the `LEDGER.md` rows (numbered "next" — the front-page job J24 assigns row numbers across M1–M3; kernel grade; the
conditional bridge stated with its named hypothesis), the `CLAUDE.md` updates (≤ 4,000 bytes net; the trust-ledger and gate counts from
stage 0; G35, G55, G63 citations; the FS-39, FS-45, FS-47, FS-87 lines), stub re-aims for FS-39, FS-45, FS-47, FS-87.

## Rules (J23a's, with these paths)

Touch only `plans/M2-kernel-lane.md` (§R-close), the kernel register `plans/M2-derivation.md`, `plans/M2-close-inventory.md`, new stub
files, `scripts/Axioms.lean` (stage 0, item 5 only), J16's leftover files, and `data/m2/j23b/`. No Lean proof edits. Subjects "J23b:
stage n". Budget about 350k harness, hand back by 420k; a successor is expected if needed. No subagents (delegation is one level deep;
staffing is Kooshi's budget decision and the owner can only review work it knows about). Report to
`data/crunch-2026-09-25/reports/J23b.md` and by SendMessage `to: "main"`; final text "J23b idle; report sent to the owner by SendMessage".
