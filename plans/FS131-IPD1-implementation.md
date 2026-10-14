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

## Stage 2 — SAVED: the generator's revision (item 786 ruling 1), three changes, each its own commit

*Order of the commits: change 1, then change 3, then change 2 (the header), so that the one change that rewrites every
module's docstring is made last and its kernel-side check covers the generator as finally revised. Working files:
`data/fs131/ipd1/rev/`. The scratch variants of the generator used as controls are kept there (`port_c*_*.py`).*

**2.1 Change 1 — `--axioms-block` covers instances and private declarations** (commit `4ae70f53e`). The block is now
`axioms_block(sel, full)`: one `#print axioms` line per copied declaration in source order — theorems, definitions,
structures **and instances**, each by the name the kernel gives it here (the name map, then the read-back's ANON rule:
an anonymous instance's `_oAI` suffix is `_proofs` here) —, **the instances a `deriving` clause declares** (four in the
31 files: `Spectral.instCommGroupDiscreteE`, `instCommGroupDiscreteF`, `InvariantMean.instAddCommGroupPeriodGroup`,
`Spectral.instAddCommGroupRot`; they have no text of their own and no other record reads them) after their owner's
record, and **every private declaration** in one `section` per module that opens it by `open private <name> from
<module>` (stage 1.5's probe: the record then prints the private name in full). A generated auxiliary has no record.
Each module's block opens with a count line (`-- Outside/<mod>: N records (i instances, d derived instances, p
private)`).
- `--check` on the 25 modules: `CHECK OK`, every file byte-identical to its committed text (`c1-check-after.out`;
  `data/fs131/ipd1/rev-files-before.sha256`); `--parse-all` passes.
- The new self-test partner (on `OAI158Basic`: 16 instances, 2 derived; a private declaration planted by giving one
  copied theorem the release's private form of its name in its `DECL` and `CONE` rows): exactly one record per copied
  declaration and per derived instance, the private one alone inside `section` / `open private … from
  Proofs.HadwigerNelson.Outside.OAI158Basic` / its record / `end` — `COMPLETE`. Self-test: **21 plants refused and 6
  partners accepted** (`c1-selftest.out`).
- Controls, each a scratch copy of the generator with part of the change withdrawn — the whole change, the derived
  instances, the private records, the `section` line: the partner reads **FAILED** in each, the self-test exits 1
  (`c1-control-{withdrawn,noderived,noprivate,nosection}.out`).
- Against the compiled modules (the farm's oleans, dumped whole: 2.4): the block's 1,103 records on the 25 modules
  name 1,103 constants of the dump, none missing; the dump's other named public constants are structure projections,
  constructors and recursors, `congr_simp`/`eq_def` lemmas made on demand, `ext_iff` and `@[simps]` companions, and the
  three derived instances of these modules — which is what the derived-instance clause was added for
  (`axioms-block-25.txt`, 1,106 records with it).

**2.2 Change 3 — a rename matches whole names only** (commit `a558cef8b`). `rename_pattern`: the token may be neither
followed by any of Lean's identifier characters (`isIdRest`, `Init/Meta/Defs.lean` at v4.32.0: ASCII letters and digits,
`_`, `'`, `!`, `?`, the letter-like blocks, the subscripts) nor preceded by one (`!` and `?` excepted: they begin no
identifier); a `.` stays allowed on both sides (a longer qualified name of the same constant before, dot notation
after), as before. The old pattern let `_`, `!`, `?`, letter-like characters and subscripts follow, so a token matched
the start of a longer name (`lipschitzWith` in `lipschitzWith_thickenedIndicator`, FS131-IPB1's note).
- `--check` on the 25: `CHECK OK`, byte-identical — **no table relied on a prefix match** (`c3-check-after.out`);
  `--parse-all` passes.
- The new partner: on the last line of a copied theorem of a source copy, a comment holding the planted token alone,
  qualified and in dot notation (each renamed) and as the start of five longer names (`_long`, `₀`, `'`, `?`, `!`; each
  left alone) — `WHOLE`. Self-test **21 plants refused and 7 partners accepted** (`c3-selftest.out`). Control: the old
  pattern in a scratch copy — the partner **FAILED**, exit 1 (`c3-control-withdrawn.out`).

**2.3 Change 2 — the header worded for a whole-file selection** (commit `68a2a3e24`). The generated title read
"ported: the part the transfer's proof uses" and item 1 "*A selection*: N of its N declarations … — those the transfer
`proper_to_borel_weak` uses", over every declaration of the file. Now: title "ported whole: a file of the transfer's
proof"; item 1 "*The whole file*: all N of its declarations (n of its m lines; its other lines declare nothing). The
cone of the transfer …, as the release's own compiled constants give it (`ConeDump.out`), is the check that the file
holds what the cone names here; the rest is copied too, because a cone computed from compiled constants misses what a
proof uses only definitionally (plan § 3.2)." A selection that is not the whole file is now refused (the wording would
be false). *The title line is changed with item 1*: it made the same claim, and the brief names item 1 — held for the
coordinator below. The cone's count is deliberately not printed: with it, the existing partner "the CONE lines of a
theorem removed change nothing" failed on my first version (the header's count moved), and that partner is the
whole-file method's own invariant, so the count went and the partner stands.
- The 25 modules regenerated; **only the title and item 1 differ** in each: `tools/fs131_ipd1_header_diff.py HEAD
  <the 25>` — `HEADER-DIFF OK: 25 of 25` (`c2-header-diff.out`: outside the docstring every line identical; inside it,
  with the title and item 1's paragraph masked, identical); its control (`--control HEAD OAI158Centers`): a code line
  changed — REPORTED, item 2 changed — REPORTED, item 1 changed (the partner) — PASSED (`c2-header-diff-control.out`).
- `--check` `CHECK OK`, `--parse-all` passes, self-test **21 plants refused and 8 partners accepted**
  (`c2-selftest.out`); the new partner (the header of Basic says all 110 declarations, none of the old wording) —
  `WHOLE FILE`. Control: the old wording in a scratch copy writing to its own output folder, whose 25 outputs are
  byte-identical to the committed files before the change (`c2-control-old-outputs.txt`): the partner **FAILED**, exit 1
  (`c2-control-withdrawn.out`).
- **No stored term moved, from the kernel's side.** Every constant of the 25 modules' own compiled data dumped from the
  farm before any change (`data/fs131/ipd1/lean/ModuleDumpHead.lean` by `data/fs131/ipd1/dump-modules.sh`; FS124-L2's
  line format: kind, name, stored type raw, universe parameters, the value's hash): **1,777 constants**
  (`rev/dump-before.out.xz`); all 25 re-elaborated in dependency order from the regenerated text, **0 errors and 0
  warnings each** (`data/fs131/ipd1/farm/*-rev.out`); dumped again: **byte-identical**, sha256 `7ec0eaee…` both
  (`dump-before.out.sha256`, `dump-after.out.sha256`), and `tools/fs131_ipd1_dumpdiff.py`: `1777 IDENTICAL, 0
  reported` (`c2-dumpdiff.out`). Controls of the comparator: a changed type, a changed value hash, a removed constant
  and a module count off by one, each REPORTED by name (`dumpdiff-control.out`); and of the dump itself, a real stored
  change — `exists_terminal_factor` given a binder `(_hplant : True)` in a copy of `OAI158Stationary`, elaborated into a
  scratch farm of symlinks with that module over it (`plant-OAI158Stationary.lean`, `plant-elab.out`, 0 errors) and
  dumped (`DumpPlant.lean`, `dump-plant-stationary.out`): exactly that constant reported DIFFERENT, 35 IDENTICAL
  (`dumpdiff-plant-stationary.out`).

**2.4 Not changed** (the brief's fence: the revision's three changes only). The generator's own docstring item 4 still
describes a cone selection ("declarations outside the cone are left out") — documentation of the tool, not generated
text; the header's item "Patches …, each to a proof and none to a statement or a definition" is still wrong in letter for
FourierTests' RULED patch (item 763's note); `--self-test` still reads the generated modules from `Proofs/` (item 759
ruling 4); the textual statement guard (item 763) stays covered by the read-back. Tool notes only.

*A slip of bookkeeping:* change 2's commit also carries the farm's logs of lane D's first module (`farm/
OAI158Representations-try{1,2}.*`), written into the same folder while the 25 re-elaborated; nothing of lane D's tables
or modules is in it.
