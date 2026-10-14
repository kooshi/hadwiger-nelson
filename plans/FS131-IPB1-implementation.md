# FS131-IPB1 — the port of `[OAIMath2026]`'s transfer proof, continued: lane B's last module and read-backs, then lane C

*de Bruijn, the implementer; job FS131-IPB1 (brief: `data/fs131/briefs/FS131-IPB1-port-lanes-bc.md`, on `main`).
Branch `fs131-wpb`, cut from `fs131-wpa` at `f97214de2` in the worktree `.claude/worktrees/fs132-wi1`. Working files:
`data/fs131/ipb1/`. The plan is `plans/FS131-KO1-port-plan.md`; the first implementer's record is
`plans/FS131-IPA1-implementation.md` (both this branch). The outside release is `[OAIMath2026]` family 158 at commit
`adc7f1241b42e322a6451854ab7e4b4c146bf78a` of `/home/kooshi/source/math` (read, never written or run).*

## Theorems this phase proved

None of this project's mathematics. The phase makes modules of the release's own lemmas, each elaborated at this pin
with every proof checked by this kernel (the farm of the plan's § 4.1: `lean -o` with the lakefile's options by flag,
not `./scripts/build.sh`); they are not registered in the library (lane D registers). The kernel receipts per module
are in the stages below.

## Stage 1 — SAVED: the readback

**1.1 The brief's quotations** — `tools/fs131_ipb1_readback.py` (the first implementer's reader with the brief's path
changed, nothing else; pointed at the main tree, where the brief and its sources are committed): **8 matched, 0
mismatched**, exit 0 (`data/fs131/ipb1/readback-brief.out`) — W4 against `data/fs131/REQUEST-2026-10-13.md`; items
759, 763, 764, 766, 767, 768 and 769 against `plans/FS131-close-inventory.md`. `--fault` (the last character of each
quotation changed): 0 matched, 8 mismatched, exit 1 (`readback-brief-fault.out`). No finding about the brief.

**1.2 The branch.** `fs131-wpb` cut from `fs131-wpa` at `f97214de2` (the tree's head at launch, clean).

**1.3 The generator** (`tools/fs131_ko1_port.py` at `666fafdc4`, unchanged), on the 14 modules generated so far (lane
A's ten, and Amenability, NumberFields, Selections, Centers):
- `--parse-all`: `PARSE OK: every file of the plan reads as scopes, declarations and scaffolding` (exit 0;
  `data/fs131/ipb1/gen-parse-all.out`);
- `--self-test`: `SELF-TEST OK: 20 plants refused and 4 partners accepted` (exit 0; `gen-selftest.out`);
- `--check --modules` the 14: `CHECK OK` (exit 0; `gen-check-14.out`, every file and the licence copy OK).

*A stray run, recorded:* my first call of the generator was `--help`, which it does not know; with no `--modules` it
generated every module in memory and refused at `Kernels.lean:658` (an instance in neither table) before writing
anything — `git status` showed no file changed.

**1.4 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make the
gate fail; the plan's § 3.1–3.7 and § 4.1–4.7; the first implementer's record whole; the generator whole.
