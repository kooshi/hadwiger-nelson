# FS131-LP1 — the landing of the port of `[OAIMath2026]`'s transfer proof

*de Bruijn, the implementer; job FS131-LP1 (brief: `data/fs131/briefs/FS131-LP1-landing.md`, on `main`). Branch
`fs131-wlp`, cut from `fs131-wpl` at `4ecf6eaeb` in the worktree `.claude/worktrees/fs132-wi1`. Working files:
`data/fs131/lp1/`. The plan is `plans/FS131-KO1-port-plan.md`; the lanes' records are `plans/FS131-IPA1-implementation.md`,
`plans/FS131-IPB1-implementation.md`, `plans/FS131-IPD1-implementation.md` (this branch). The outside release is
`[OAIMath2026]` family 158 at commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a` of `/home/kooshi/source/math` (read,
never written).*

## Theorems this phase proved

None of this project's mathematics. The landing takes the port — the release's own declarations, every proof checked by
this kernel at this pin — through the gate. The kernel theorem it makes held is `[OAIMath2026]`'s:
`HadwigerNelson.Outside.OAI158.proper_to_borel_weak` (ported; its axioms are read in stage 5 below).

## Stage 1 — SAVED (FS131-LP1): the readback

**1.1 The brief's quotations** — `tools/fs131_lp1_readback.py` (FS131-IPD1's reader with the brief's path changed and
nothing else; the diff is three lines, two of them its docstring): **8 matched, 0 mismatched**, exit 0
(`data/fs131/lp1/readback-brief.out`) — W4 and W2 against `data/fs131/REQUEST-2026-10-13.md`; items 759, 807, 758, 763,
767 and 772 against `plans/FS131-close-inventory.md`. `--fault` (the last character of each quotation changed): 0
matched, 8 mismatched, exit 1 (`readback-brief-fault.out`). No finding about the brief.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole (§ The gate, § Assumptions and § Trust
ledger as they stand on `main`); `RUNNING.md` § Building and § Make the gate fail; FS131-IPD1's record whole; the plan's
§ 4.3–4.7 and its drafts; FS131-IPB1's stage 5; the comparator `tools/fs131_ipa1_readback_port.py` whole and the parts of
FS132-I2's `tools/fs132_i2_readback.py` it calls (`load`, `judge`, `compare`, the dumper's `report`).

**1.3 The branch and the merge.** `fs131-wlp` cut from `fs131-wpl` at `4ecf6eaeb` (clean). The trial (`git merge
--no-commit --no-ff main`, `main` at `e928d4aa2`): no conflict; 40 files, every one under `plans/` or `data/` but
`BIBLIOGRAPHY.md`; no `.lean` file, lakefile, manifest, toolchain, script or tool; no file changed on both sides. Merged
as `c1725a7d8`.

**1.4 The build as it stands.** `lake build --no-build` under the slot: `All targets up-to-date (6177 jobs)`, exit 0,
4.7 s (`data/fs131/lp1/nobuild-0.out`) — the tree's compiled library is current for the merged commit.

**1.5 The stored statements before any edit** — `data/fs131/lp1/lean/StmtDump.lean`, FS131-IPD1's switch dumper
`data/fs131/ipd1/lean/SwitchDump4.lean` with its header changed and its body byte-identical (`diff` of everything after
the header: none): every named and private constant of `Outside/OAI158`, of the 24 modules downstream of it that the
switch read (`Plane/RadiusOutside` and `Plane/LebesgueNumber` among them), of `Outside/OAI158Collapse` and of
`Outside/OAI158BorelTransfer`, from the build by `lake env lean` under the slot: **`DONE 541`**, exit 0, 1 m 15 s, 5.5 GiB
resident (`data/fs131/lp1/stmt/before.out`, its sha256 `1e6ae66d…`). It is **byte-identical** to FS131-IPD1's step-4 dump
(`data/fs131/ipd1/switch/step4.out.xz`, the same sha256): nothing moved between that job's build and this landing.
