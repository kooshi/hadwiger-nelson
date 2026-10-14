# FS131-IPA1 — the port of `[OAIMath2026]`'s transfer proof, lanes A (the spectral base) and B (the factor base)

*de Bruijn, the implementer; job FS131-IPA1 (brief: `data/fs131/briefs/FS131-IPA1-port-lanes-ab.md`, on `main`).
Branch `fs131-wpa`, cut from `fs131-wp1` at `89b6a57a3` in the worktree `.claude/worktrees/fs132-wi1`. Working files:
`data/fs131/ipa1/`. The plan is `plans/FS131-KO1-port-plan.md` (this branch). The outside release is `[OAIMath2026]`
family 158 at commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a` of `/home/kooshi/source/math` (read, never written or
run).*

## Theorems this phase proved

None of this project's mathematics. The phase makes modules of the release's own lemmas, each elaborated at this pin
with every proof checked by this kernel (the farm of the plan's § 4.1: `lean -o` with the lakefile's options by flag,
not `./scripts/build.sh`); they are not registered in the library (lane D registers). The kernel receipts per module
are in the stages below.

## Stage 1 — SAVED: the readback

**1.1 The brief's quotations** — `tools/fs131_ipa1_readback.py` (the planner's reader, pointed at this brief and at the
main tree, where the brief and its sources are committed; this branch is cut before them): **3 matched, 0
mismatched**, exit 0 (`data/fs131/ipa1/readback-brief.out`) — W4 against `data/fs131/REQUEST-2026-10-13.md`; items
758 and 759 against `plans/FS131-close-inventory.md`. `--fault` (the last character of each quotation changed): 0
matched, 3 mismatched, exit 1 (`readback-brief-fault.out`). No finding about the brief.

**1.2 The branch.** `fs131-wpa` cut from `fs131-wp1` at `89b6a57a3` (the tree's head at launch, clean).

**1.3 The generator, frozen, run as item 759 says** (`tools/fs131_ko1_port.py`, unchanged):
- `--parse-all`: `PARSE OK: every file of the plan reads as scopes, declarations and scaffolding` (exit 0;
  `data/fs131/ipa1/gen-parse-all.out`);
- the trial's three modules generated into `Proofs/HadwigerNelson/Outside/` from their tables (`gen-trial-write.out`):
  `OAI158Basic` 928 lines sha256 `bb74393f…`, `OAI158InvariantMean` 1,234 `55d8909d…`, `OAI158Centers` 872
  `5c6193de…` — **byte-identical to the trial's copies** (`data/fs131/ko1/trial/generated/SHA256SUMS`, the full
  hashes equal);
- `--self-test`: `SELF-TEST OK: 19 plants refused and 2 partners accepted` (exit 0; `gen-selftest.out`);
- `--check --modules OAI158Basic,OAI158InvariantMean,OAI158Centers`: `CHECK OK` (exit 0; `gen-check-trial.out`).

**1.4 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make the
gate fail; the plan `plans/FS131-KO1-port-plan.md` whole; the generator whole; the three trial tables and the farm
script `data/fs131/ko1/farm1.sh`.

*A slip of order, recorded:* this stage's section was committed after lane A's first elaborations had begun (the
readback itself ran first, and nothing of it changed); nothing of stage 2 is claimed here.
