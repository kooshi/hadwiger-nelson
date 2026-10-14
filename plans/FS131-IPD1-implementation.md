# FS131-IPD1 — the port of `[OAIMath2026]`'s transfer proof, last lane: the generator's revision, lane D, the switch, the registration

*de Bruijn, the implementer; job FS131-IPD1 (brief: `data/fs131/briefs/FS131-IPD1-port-lane-d.md`, on `main`).
Branch `fs131-wpl`, cut from `fs131-wpb` at `f4085d2ac` in the worktree `.claude/worktrees/fs132-wi1`. Working files:
`data/fs131/ipd1/`. The plan is `plans/FS131-KO1-port-plan.md`; the earlier implementers' records are
`plans/FS131-IPA1-implementation.md` and `plans/FS131-IPB1-implementation.md` (all this branch). The outside release is
`[OAIMath2026]` family 158 at commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a` of `/home/kooshi/source/math` (read,
never written or run).*

## Theorems this phase proved

None of this project's mathematics. The phase makes modules of the release's own lemmas, each elaborated at this pin
with every proof checked by this kernel, registers the port's thirty-one modules, and turns the declared outside
theorem `Outside.OAI158.proper_to_borel_weak` into the release's theorem under its name (the switch, stage 5). The
kernel receipts are in the stages below.

## Stage 1 — SAVED: the readback

**1.1 The brief's quotations** — `tools/fs131_ipd1_readback.py` (FS131-IPB1's reader with the brief's path changed,
nothing else; pointed at the main tree, where the brief and its sources are committed): **9 matched, 0 mismatched**,
exit 0 (`data/fs131/ipd1/readback-brief.out`) — W4 against `data/fs131/REQUEST-2026-10-13.md`; items 759, 758, 763,
764, 767, 768, 772 and 786 against `plans/FS131-close-inventory.md`. `--fault` (the last character of each quotation
changed): 0 matched, 9 mismatched, exit 1 (`readback-brief-fault.out`). No finding about the brief.

**1.2 The branch.** `fs131-wpl` cut from `fs131-wpb` at `f4085d2ac` (the tree's head at launch, clean).

**1.3 The generator** (`tools/fs131_ko1_port.py` at `7deb20414`, unchanged), on the 25 modules generated so far (lanes
A, B and C; the list is `data/fs131/ipd1/modules25.txt`):
- `--parse-all`: `PARSE OK: every file of the plan reads as scopes, declarations and scaffolding` (exit 0;
  `data/fs131/ipd1/gen-parse-all.out`);
- `--self-test`: `SELF-TEST OK: 21 plants refused and 5 partners accepted` (exit 0; `gen-selftest.out`);
- `--check --modules` the 25: `CHECK OK` (exit 0; `gen-check-25.out`: 25 modules and the licence copy OK).

**1.4 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make the
gate fail; the plan whole (stages 1–4 and the drafts); both earlier implementers' records whole; the generator whole;
`scripts/Axioms.lean`'s instruments and banners, and `scripts/axioms.sh`'s record parser (for the revision's first
change).

**1.5 A probe for the revision's first change** (`data/fs131/ipd1/probes/OpenPrivate{1,2}.lean` with their `.out`, under `import Proofs` as
`scripts/Axioms.lean` is): Batteries' `open private … from <module>` is in the library's import closure; inside a
`section` it makes a private declaration of another module nameable by its user name, and `#print axioms` then prints
the record as `'_private.<module>.0.<name>' depends on axioms: [...]`, the form `scripts/axioms.sh` reads; after `end`
the name is unknown again (exit 1, `Unknown constant`, the probe's last line). The port holds one private declaration
(`BorelTransfer.lean:380`, `pickSupport`); the 25 modules so far hold none, and 63 instances.
