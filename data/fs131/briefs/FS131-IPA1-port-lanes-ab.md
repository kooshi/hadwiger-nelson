# Brief FS131-IPA1 — the port of the outside release's transfer proof, first two lanes: the spectral base and the factor base

*Written 2026-10-14 05:18 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-14. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IPA1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the port's first implementer — lanes A and B of its planner's four, one after the other on one branch: fifteen files of the outside release made into modules of this library by the planner's generator, each elaborated at this pin with every proof checked by this kernel, no axiom and no `sorry`
  launch: now, in the port planner's tree (its job is finished; nobody else writes there) on a new branch; the chain's planner works in `fs131-wq1` and the chain's implementer in `fs131-wch`, each building now and then
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a site of the adaptation class would need a new hypothesis or binder (stop that module), if a Mathlib definition other than `Measure.map` changed between the pins reaches a release definition or statement, if the generator needs any change (it is frozen: a defect in it is a tool defect for me), and with one line when lane A's ten modules elaborate; the report goes to `data/fs131/reports/FS131-IPA1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IPA1-implementation.md` (new, on branch `fs131-wpa`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1` on a **new branch `fs131-wpa`** that you cut from its head (`fs131-wp1` at `89b6a57a3`): the fifteen generated modules of lanes A and B, `Proofs/HadwigerNelson/Outside/OAI158<Stem>.lean`, written only by the generator; their tables `data/fs131/ko1/port/<Module>.json` (the two trial tables of lane A and the one of lane B included); your checks under `tools/` named for this job (the strip check of the plan's § 4.3, as `tools/fs131_ipa1_strip.py`, if you write the first adaptation); the scratch farm under the tree's ignored `build/`; `plans/FS131-IPA1-implementation.md`; `data/fs131/ipa1/`; `data/fs131/reports/FS131-IPA1.md`. **Not** the generator `tools/fs131_ko1_port.py`, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `Proofs/HadwigerNelson/Outside/OAI158.lean` or any other module of the library (registration and the switch are lane D's); nothing on `main`; nothing in the outside release's clone, which is read only and in which nothing is run
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. This library declares one theorem of the outside release as an axiom: the transfer from an arbitrary proper
colouring of the plane to a measurable one proper at almost every unit pair, on which twelve of its records rest.
Kooshi has approved porting the release's proof of it, so that the axiom becomes a theorem under its present name.
Its planner measured the proof's cone, ran a trial on three files, and cut the work into four lanes. You take the
first two.

## Why this job

Kooshi's word:

> W4: (2026-10-14, at his check-in, after my explanation of the transfer proof and a question of his on upgrading Mathlib) alright, yes to the port, and we'll stay on this version indefinitely. Scheduling the port is up to you.
> — source: data/fs131/REQUEST-2026-10-13.md

The port removes one of the library's three declared outside theorems, and with it a second one the density equality
declares, whose cone lies inside this one's. Every ported proof is checked by this kernel at this pin; the release's
statements are kept, so that each ported theorem is the release's theorem.

## The statements

The planner's trial and my ruling on it, then its hand-back and my rulings (their words in quotation marks):

> 758. **FS131-KO1 — the trial's result, and a ruling on Mathlib's change to `Measure.map` (2026-10-14 06:10 UTC; stage 3 saved, `a6abde395` on `fs131-wp1`).** Its words: "nothing of ours moves beyond instance arguments, and no ported definition differs from fs133-wb1's copy"; "0 DIFFERENT and 0 MISSING across 11 modules … Instance-only moves do occur, all through one module: Mathlib.Order.CompletePartialOrder … With that module left out of the port's imports, nothing moves in any exposed module"; "the 8 declarations of Basic that the density branch copies … are IDENTICAL in type and value. Not yet compared: op, space and the other 45 of OAI158Transfer … step 0 of the join recipe"; on method, "A cone computed from compiled constants misses rfl simp lemmas … The port therefore copies whole files … whole files add 129 declarations (462 lines) beyond the cone"; the trial — Basic "4 patches … 0 errors", InvariantMean "0 patches, clean", Centers "5 renames, then stops at one class"; the class: "At v4.32.0, map of a non-measurable function is 0, and ProbabilityMeasure.map takes the AEMeasurable proof as its explicit argument. At v4.34.1, map is a measure of the same mass even then … Every site's g is measurable … I propose a separate ruled table, adaptations … ProbabilityMeasure appears on 264 lines in 26 of the 31 files, so this class, not the renames, is the port's real cost." **My receipt:** `a6abde395` exists (197 files, almost all under `data/fs131/ko1/`, no compiled file); its record's table rows read `Outside/OAI158` "1 INSTANCES-ONLY: `seven_le_chromaticNumber_plane_iff` | 29 IDENTICAL", `Plane/RadiusOutside` 8 and 8, `Plane/LebesgueNumber` 34 and 34 IDENTICAL, and the shared definitions "8 of 8 IDENTICAL"; the trial's generated modules under `data/fs131/ko1/trial/generated/` carry the release's licence notice and the notice of change. **Ruling, four parts:** the adaptations table is approved — no adaptation adds a hypothesis or binder (each measurability proof a closed term from the statement's context; a site needing a new hypothesis comes to me), refused on the target statements, on any declaration the density branch shares and on anything a statement of ours names, each entry in its module's header, flagged ADAPTED and checked mechanically (the print agrees with the release's once the inserted argument is stripped, with a planted control), and a `LEAN.md` § Assumptions line drafted for the filing; alternative weighed, the refusal kept absolute with measurability added by hand as lane-owned statement changes — declined, slower and a larger change to statements, while the kernel checks every ported proof either way and the table records the one loss (the claim of verbatim text); high; it would change if an ADAPTED site needs a new hypothesis. Also accepted: the import of `Mathlib.Order.CompletePartialOrder` dropped from every module; whole files in place of the cone. Both conditions of item 748 are met as reported. Sent by one message; Amendment 2 appended to the brief, gate PASS. **For Kooshi's report (settled, not his to decide):** the port's real cost is this class of 264 lines, not the renames. **Owed at the landing:** whether the trial's generated copies under `data/fs131/ko1/trial/generated/` stay in `data/` or are dropped once the real modules exist (they carry the licence notice, so either is allowed).
> — source: plans/FS131-close-inventory.md

> 759. **FS131-KO1 handed back: the port's plan is written (2026-10-14 06:30 UTC logged; "JOB FS131-KO1 — DONE"; 572k by the harness's count — past the line, not to be resumed; branch `fs131-wp1` at `89b6a57a3`, cut from `main` at `747e139d0`, tree `fs132-wi1`; record `plans/FS131-KO1-port-plan.md` there).** Its words: "`Outside.OAI158.proper_to_borel_weak` (on main) and `Outside.OAI158.Spectral.residual_fourier` (on fs133-wb1) each become a theorem under its present name. No stored statement of ours moves in the trial's measurement. The plan has four lanes that share no file, a switch for the transfer, and a join recipe for the density branch"; "1,995 constants … 1,299 source declarations and 12,005 source lines in 32 release files … All 1,800 constants of `residual_fourier`'s cone lie inside the transfer's"; lanes (§ 4.2) A, the spectral base (ten modules, 5,035 lines, two done in the trial), and B, the factor base (five modules, 2,668 lines), in parallel; C (ten modules, 5,574 lines) on their merge; D (six modules, 2,656 lines; the switch, the registration, the build, the join recipe's step 0) on C; prices "2–3 h, 2–3 h, 4–6 h, 4–6 h"; the port's landing then reads "imported records 26 → 14; library axioms 3 → 2"; a tool defect of its own exposure reader caught by that reader's control before use; two slips, each a stopped run recorded (a name clash in three density modules, redone; the pricing dump, unfinished, left to lane A). **My receipt:** the seven commits exist on `fs131-wp1`, its tree clean; I ran the generator myself: `--parse-all` — "PARSE OK: every file of the plan reads as scopes, declarations and scaffolding"; `--self-test` on a clean checkout — "SELF-TEST FAILED: the unplanted check does not pass", because its unplanted check reads the generated modules from `Proofs/HadwigerNelson/Outside/`, where none is committed (the trial's copies are under `data/fs131/ko1/trial/generated/`); with those three copies placed there (untracked, removed after, the tree clean again): `--check` — "CHECK OK", `--self-test` — "SELF-TEST OK: 19 plants refused and 2 partners accepted", as reported. **Rulings, four parts each.** (1) *The plan:* accepted as written, with § 4.3 on item 758's conditions; alternative, a second planner's reading first — declined, the trial measured what a reading would guess; high. (2) *Staffing:* lanes A and B go to **one** implementer now (FS131-IPA1, item 760), A first, on one branch from `fs131-wp1` in this tree (its compiled library is `main`'s at `747e139d0`, which the farm reads), so lane C starts from that branch with no merge; alternative, two implementers in parallel — declined, one slot is free (the chain's planner and implementer hold two); medium-high; it would change if a second slot frees early. (3) *Its cut from `747e139d0`, not the brief's `955b0bdda`:* accepted — "no Lean file, lakefile, manifest or toolchain differs between the two"; high. (4) *Tool note (no defect in use):* the generator's self-test passes only with the modules in place; each lane generates into `Proofs/HadwigerNelson/Outside/` and runs it there, so its receipts are sound; giving `--self-test` an output folder is for the generator's next revision between lanes; medium. **Owed to the second filing:** the `LEAN.md` drafts F1 (the adaptation line, the whole-file line) and the three § Searching — Lean bullets, the `[OAIMath2026]` bibliography cell (record § Drafts); the correction owed to `plans/EXT-OAI1-audit.md` § The pieces to adopt ("about 16,600 lines" → 12,005 lines of declarations, 15,964 with scaffolding, measured). **Owed to the density equality's landing:** the join recipe § 4.5, step 0 being lane D's.
> — source: plans/FS131-close-inventory.md

**Your modules.** The plan `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/plans/FS131-KO1-port-plan.md` § 4.2's lanes **A** — `Basic` and `InvariantMean` (the trial's, tables written, 0
errors), `SmallArcs`, `PhaseEncoding`, `Characters`, `PhaseCollision`, `Multipliers`, `ConditionalSelection`,
`FourierTests`, `ConditionalSpectrum` — and **B** — `Centers` (the trial's: five renames in its table, its adaptations
to write), `Amenability`, `NumberFields`, `Selections`, `RelativeCenters`. Lane A first; lane B regenerates `Basic`
from its table, so it follows on the same branch. Their statements are the release's; the generator keeps them. Read
the plan's § 3.1–3.6 (the generator, whole files, the trial, the exposure), § 4.1 (how a module is made; the farm),
§ 4.2 (the five receipts each lane gives, for its own modules), § 4.3 (the adaptation class and its conditions) and
§ 4.7 (open risks). The generator is `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/tools/fs131_ko1_port.py`; the tables are in `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/data/fs131/ko1/port/`; the farm script is `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/data/fs131/ko1/farm1.sh`; the read-back
across pins is `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/tools/fs132_i2_readback.py`, imported as a module the way FS133-IA1 did (`/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/plans/FS133-IA1-implementation.md`, its stage 2).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; your branch cut; the generator's
   `--parse-all` and, with the trial's three modules generated into place, its `--self-test` and `--check` run and
   their last lines recorded (the self-test reads the modules where `--check` does, so it passes only once they are
   generated: item 759).
2. **Lane A** (saved stages every few modules): each of its ten modules generated from its table and elaborated by
   the farm, with the five receipts of § 4.2 for each.
3. **Lane B** (saved stages every few modules): the same for its five, `Centers`' adaptations written under § 4.3's
   conditions, with the strip check and its planted control if you write the first adaptation.
4. **Every table entry with its reason**, and a statement in your record that no entry touches a protected
   declaration (the target statements, a declaration the density branch shares, anything a statement of ours names).
5. **Re-pricing** for lanes C and D from what lanes A and B cost, and the plan's risk 2 (another Mathlib definition
   that changed between the pins) reported for every module you elaborated, with the pricing dump finished if you
   choose to.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The tables' entries within the plan's rules — patches to proofs, renames, the adaptation sites, the scoped and global
instances, the dropped imports; the order inside a lane; whether to finish the pricing dump; how far into lane B you
reach before your hand-back line. Not yours: the generator; any patch to a statement or a definition other than an
adaptation under § 4.3's conditions; any adaptation needing a new hypothesis; registration, the switch, the join; the
landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is `main`'s at `747e139d0`, which the farm reads. One module through the farm:
about 10 seconds and 3.5 GiB, under the memory tool (the farm script calls it).

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ipa1 -- <command>`

On exit 75 wait ten minutes and retry; two other jobs build now and then. Stop a process by its PID or process group,
never by matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under
`data/fs131/ipa1/`. Scratch copies of the release's text stay under the tree's ignored `build/` folder; the release's
text enters a commit only inside a generated module that carries its licence notice. Report at once any disk, memory
or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## Amendment 1 (2026-10-14 05:41 UTC) — three read-back findings ruled

1. **A ruled statement change** (a class beside the adaptations): `DifferenceFourier.differenceLaw_probability` takes exactly the release's own section variables `[MeasurableMul₂ G] [MeasurableInv G]` as binders, and nothing else. The check is mechanical: the erased print equals the release's with exactly those binders inserted, and a planted control (one other binder inserted) is refused. The entry is listed in the module's header and flagged RULED by the read-back. The change is refused, and comes to me, if it would touch a target statement, a declaration the density branch shares, or anything a statement of ours names. Write into your record, for the generator's next revision, that its statement guard is textual and that a proof patch can change a stored type through variable inclusion. The read-back is the gate for that, per module. The generator stays frozen.
2. **`Finset.HasAntidiagonal`'s class parameter** (`AddMonoid` here, `Add` at the release's pin): up to instances, by a named comparator rule. The prints agree once that class argument is erased at its projections, with a planted control. No statement changes.
3. **The `Monoid` structure change** that moves the stored values of the three `deriving` instances: a pin difference, with the same source text and types, and nothing patched. The shared `instCommGroupDiscreteE` stays IDENTICAL to the density branch's copy at this pin.

Inventory item 763. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## Amendment 2 (2026-10-14 05:51 UTC) — you are named to make one generator fix

Your touches are extended by one change to `tools/fs131_ko1_port.py`: its `KEYWORD` pattern allows leading whitespace, and nothing else changes. The fix comes with a new self-test plant (an indented declaration is copied), and every existing plant still refuses. `--check` runs on every module generated so far, before and after; each must be byte-identical, and any difference is a message to me first. `--parse-all` passes. The change goes in its own commit. The textual statement guard of Amendment 1 is not part of this change (inventory item 766).

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
