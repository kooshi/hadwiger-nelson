# FS131-ICT2 — the three-colour criterion to the gate: the ruled drops, lint, the gate on one commit, the read-aloud, the drafts

*Implementer: de Bruijn (Opus 5.5), job FS131-ICT2, brief `data/fs131/briefs/FS131-ICT2-three-colour.md` (on `main`). Worktree
`.claude/worktrees/kel1`, branch `fs131-ktc1`, at `ffe203401` on arrival (FS131-ICT1's last commit `0ab9c6614` with `main`
merged in). Started 2026-10-16 15:50 UTC. No fence (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1). The
predecessor's record is `plans/FS131-ICT1-three-colour.md`; the plan is `plans/FS131-KTC1-three-colour-plan.md`.*

## Theorems this phase proved

None yet (the mathematics was done by FS131-ICT1; this job gates it). Filled in at the gate.

## Stage 1 — SAVED: the readback

### 1.1 The quotations of the brief, checked against their sources

`tools/fs131_ict2_quotes.py` (FS131-ICT1's checker with this brief's path: each quotation, as a contiguous block of whole
lines, against its source in this worktree and in the main tree): `data/fs131/ict2/quote_check.out` — **2 quotations, 0
mismatched** (inventory items 1012 and 1003 of `plans/FS131-close-inventory.md`, found in both trees). Its control
(`--plant`: one character changed in the longest line of each quotation) reports both (`quote_check_plant.out`, exit 0).

The brief's receipts, checked on the branch: `grep -cw sorry` reads 0 in the three modules; `even_pmHeight_sub_sum` (then
`Fibre.lean` l. 179) took `(hc : ProperAlong s c)` and read it only by `have _ := hc`; `exists_le_mul_of_imp_eq_zero` (then
l. 433) took `(hadd : ∀ x ∈ M, ∀ y ∈ M, x + y ∈ M)` and read it only by `have _ := hadd` — as the brief says.

### 1.2 What is left, and the order

1. **The ruled drops** (item 1012): `hc` from `CayleyThree.even_pmHeight_sub_sum`, `hadd` from
   `CayleyThree.exists_le_mul_of_imp_eq_zero`; their call sites (`Density.lean`, three uses of the first; `Fibre.lean`'s
   `exists_slack_bound`, one of the second) updated. With them, before the first build: the three module titles lose the word
   "skeleton" (doc text only; the modules compile in this build anyway), and the Dickson lemma's docstring loses "closed under
   sums" with its hypothesis.
2. **The build** (`./scripts/build.sh` under the slot, the brief's line), then **`lake lint`** — a saved stage.
3. **The gate on one commit**: `data/fs131/clone1/run-gate.sh`'s steps copied to `data/fs131/ict2/run-gate.sh`, logs under
   `data/fs131/ict2/gate/`, every count change explained against `data/fs131/ico2/gate/` (gated on `7c72b9bf7`); first its
   inputs: the audit block for the three modules in `scripts/Axioms.lean` (generated from the kernel's print of every record,
   LEAN.md § Searching — Lean, FS131-LGT1's method), the `ARCHITECTURE.md` rows brought to "landed", the vacuity scan's new sites
   with each structure's inhabitant (plan § 3.7), the assumptions step (no hypothesis of ours expected); the statement
   comparison against `data/fs131/ict1/statements-before.txt.gz` with the three ruled changes and the new helper constants; `#print
   axioms` of every head statement — a saved stage.
4. **The read-aloud** of each head statement against ledger row 79, with what is not claimed — a saved stage.
5. **The drafts** for the front files (plan § 3.8 brought to what is proved; "prior art not yet searched" where a novelty line
   would go, item 1000) — a saved stage.
6. **The report**.
