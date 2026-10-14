# Brief FS131-FC4 — file the front-page drafts of a landing that is already on `main`, verbatim, and run the checks that read the front page

*Written 2026-10-14 13:02 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-FC4
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; here you are the coordinator's pen for one filing
  role: the pen for one filing — the port of an outside library's proof landed on `main` just now and the front page shows the counts from before it; you put the landing agent's drafts into their slots word for word, run the checks that compare the front page with the gate's receipts, and report every place where you would have had to choose
  launch: now, in a tree of your own; three other jobs work in other trees and write no file you write; the next landing (the density equality's) waits for yours and will quote the front page as it stands after it
  mission: § Why this job
  statements: § What is filed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot is not found exactly once, if two drafts touch the same words, or if a check fails in a way no draft explains; the report goes to `data/fs131/reports/FS131-FC4.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `data/fs131/reports/FS131-FC4.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1` (branch `fs131-f4`, cut from `main` just now; the tree holds a compiled library you do not need and must not touch; no build is run): the files the drafts name — whichever of `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `ARCHITECTURE.md` and `tools/claude_md_fact_audit.py` they name — and nothing else of the front files; your own script and outputs under `data/fs131/fc4/`; `data/fs131/reports/FS131-FC4.md`. Commit on your branch by explicit path; the coordinator merges it
  budget: about 200k by the harness's count, as guidance; save a stage (a commit) after the slots are checked, after the drafts are in, and after the checks; hand back at a saved stage if you pass about 300k

Hello. Three filings like this one were done on this machine in the last two days; the last clerk guessed at nothing
and raised a check I then ruled on. This is the same job for the landing that followed, with more drafts.

## Why this job

The port landed on `main` just now through the full gate: the transfer from an arbitrary proper colouring of the plane
to a Borel one proper at almost every unit pair, which this library had taken as a declared outside axiom, is now a
theorem here, ported with its proof from the outside release in 31 generated modules. The library's declared outside
axioms go from three to two, and everything that rested on the transfer now rests on the standard three. Its landing
agent wrote 24 drafts for the front page, each with the exact words it replaces or follows. Until they are filed the
front page (`CLAUDE.md`) shows 7,602 records and three declared axioms where the library has 9,024 records and two.

The drafts are a lane's words and go in verbatim: I coordinate and do not author, and you are my pen. Where you would
otherwise have to guess, write a `CHECK:` line and do not guess.

## What is filed

The landing's hand-back and its merge, as I logged them, with my receipts:

> 840. **FS131-LP1 handed back: the port of the transfer proof through the full gate (logged 2026-10-14 13:01 UTC; "JOB FS131-LP1 — DONE"; 714k by the harness's count — past the line, not to be resumed; branch `fs131-wlp` at `1d98dc942`, gated at `75a0035f1`, tree `fs132-wi1`; record `plans/FS131-LP1-landing.md`).** From its hand-back message: "`HadwigerNelson.Outside.OAI158.proper_to_borel_weak` is now `[OAIMath2026]`'s theorem with its proof ported, on `[propext, Classical.choice, Quot.sound]`"; "Read term for term against the release's statement: the read-back says IDENTICAL, and my own print of the stored types (564 characters) is identical at both pins. Its stored type is also the type of the axiom it replaced"; "the twelve theorems that rested on the axiom now each rest on exactly the standard three" (named: `nonempty_aeColouring_of_colorable`, `colorable_iff_nonempty_aeColouring`, `chiM0_le_chromaticNumber_plane`, `chromaticNumber_plane_eq_chiM0`, `seven_le_chromaticNumber_plane_iff`, `Plane.exists_isWeakColouringOn_of_colorable`, `radius_down`, `colorable_iff_forall_ball`, `seven_le_chromaticNumber_plane_iff_exists_ball`, `colorable_iff_exists_nullMeasurable_proper`, `chromaticNumber_plane_eq_chiLebesgue`, `chromaticNumber_euclidean_plane_eq_chiLebesgue`); every count as predicted; "READBACK OK, 524 constants, 0 failing"; the comparator streaming ("Lane D ran in 1 minute at 4.0 GiB instead of 20 GiB"); the four read-back items closed under rulings 1–3; the lint's 25 findings silenced in-file under Amendment 1 ("`@[nolint]` does attach to anonymous instances at this pin, so the fallback was not needed"); "No stored statement moved". **My receipts:** item 839 (the gate's logs read); the two commits after `75a0035f1` touch only `data/` (59 files) and `plans/` (1); the trial merge with `main` reported no conflict. **Its inventory lines, filed here:** results — the transfer and its twelve consumers on the standard three, the library's declared outside axioms 3 → 2; the comparator streams within 8 GiB with its controls; `generator_unitary`'s two instance paths agree by kernel `rfl`, the planted disagreement refused; the four new skipped refutations named (record stage 4.3). Tool defects (to the tooling list): FS131-IPD1's ADAPTED_VALUE plant changed only an instance argument and is re-aimed; the CLASS_PARAMS withdrawal plant cannot fire on lane D and now reports UNREACHABLE; the lint had never run over the port. **Corrections owed** (to the second filing): `scripts/Vacuity.lean` line 561's history paragraph still calls the transfer "the imported `proper_to_borel_weak`"; `plans/EXT-OAI1-audit.md` "about 16,600 lines" → 12,005 lines of declarations (15,964 with scaffolding; item 759). **For the density equality's landing:** its join (KO1 plan § 4.5, steps 1–9) can read this landing's receipt that the ported `residual_fourier` has exactly that branch's axiom's type. **Open gate items, none a red check:** the density branch's join; `lean4checker` not run on the port; the whole-file comparator kept as a reference; lane D's prints not committed (reproducible by script); ADAPTED_VALUE accepting instance-argument changes, by its ruling; the generator's text-only statement guard; `Vacuity.lean` line 561; EXT-OAI1's line count; `hexShell_plane5`'s classing. Disk: its 2.9 GB of prints deleted; 318 GB free after.
> — source: plans/FS131-close-inventory.md

> 841. **The port merged into `main`; item 808's announcement rule met (2026-10-14 13:01 UTC).** Merge `398523e99` (`--no-ff`, `fs131-wlp` at `1d98dc942`; no conflict). **The check:** `main` against the gated commit `75a0035f1`, outside `plans/` and `data/`, differs in two files only — `.claude/output-styles/keryx.md` (the staffing line, item 825) and `BIBLIOGRAPHY.md` (Rudin's row, item 828) — and those differences are line for line `main`'s own edits since the branch's base `e928d4aa2`; `Proofs/`, `Proofs.lean`, `scripts/`, `tools/`, `ARCHITECTURE.md`, `LEAN.md`, `CLAUDE.md` and the package files are equal to the gated commit. So all three conditions hold: the gate green on one commit, merged into `main`, `main` equal to it outside `plans/` and `data/`. **Held on `main`, through the gate:** `[OAIMath2026]` family 158's transfer from an arbitrary proper colouring of the plane to a Borel one proper at almost every unit pair is a theorem of this library, ported with its proof, on the standard three axioms; with it `χ(ℝ²) = χ_m⁰(ℝ²)`, `7 ≤ χ(ℝ²) ⟺ lim µ₆(ε) < 1`, `χ(ℝ²) = χ_m(ℝ²)` and the disc criterion's half toward seven rest on the standard three; the library declares two outside axioms (Weil's bound, the release's five-colouring theorem). Other people's mathematics, ported; no value moved. **The reference compiled tree for `main` is now `fs132-wi1`** (its build is the gated one, current for `main`'s Lean); `fs131-wrc` holds the pre-port build. **Next, by the handoff's order:** the filing (the Clerk, FS131-FC4, in `fs132-wi1` on a branch from `main`, which changes no Lean source there), then the density equality's landing. **The slot:** the one FS131-LP1 freed; the Clerk counts a half; the density equality's landing (an implementer, a whole slot) waits for the filing's hand-back or the next free slot, so that its drafts quote the front page as filed — alternative, launch it now beside the Clerk — declined, a slot and a half over the cap of four; high.
> — source: plans/FS131-close-inventory.md

**The drafts** are in `plans/FS131-LP1-landing.md`, section "Drafts for the front page (FS131-LP1)" (to the heading "Open gate items at
this landing"; the same text is `data/fs131/lp1/drafts.md`). Each names its file, its section and the exact words on
`main` it replaces or follows. The landing agent's checker of those slots is `data/fs131/lp1/drafts-slots.py`.

**My choices where a draft leaves one to the coordinator** (file what the drafts say; use these only where a draft
offers alternatives or says "the coordinator's"):

1. Whose it is, exactly as the drafts say it: the transfer and every ported proof are the outside release's
   (`[OAIMath2026]` family 158); the port, its tooling and the kernel check at this pin are this project's. Nothing
   here moves a value.
2. The milestone this belongs to (the Lean backlog) changes no state by this filing.
3. The proof atlas is not touched by this job (one rebuild at the cleanup pass).

## Done means

1. **Slots first** (a saved stage): run `python3 data/fs131/lp1/drafts-slots.py main` in your tree; every slot found
   exactly once and the control absent, or you stop and message me with the slot that failed.
2. **The drafts in, by a script** (`data/fs131/fc4/file_fs131_lp1.py`; the pattern is the last filing's
   `data/fs131/fc3/file_fs131_lj1.py`): it asserts every slot before it writes anything, replaces or inserts each
   draft's quoted text exactly (the lines under `>` in the record, joined as the target file wraps its lines; nothing
   reworded, nothing added), and prints what it did per draft. A draft that says counts "stand" changes nothing and
   is reported as such. (A saved stage.)
3. **The checks that read the front page**, each with its full output kept under `data/fs131/fc4/`:
   - the three digests of this landing's receipts against the previous landing's:
     `python3 scripts/gate_report.py axioms data/fs131/lp1/gate/receipt-axioms-final.log data/fs131/lj1/gate/receipt-axioms-final.log CLAUDE.md`,
     the same with `vacuity` and `scripts/vacuity-baseline.txt` before `CLAUDE.md`, and with `assumptions` and
     `scripts/assumptions-ledger.txt` before `CLAUDE.md`;
   - `python3 tools/claude_md_fact_audit.py --base 747e139d0` and the same tool with `--dupes`. **A token the audit
     reports lost is not allow-listed by you**: list it as a `CHECK:` with where it was and what replaced it;
   - `python3 tools/bib_audit.py`;
   - the size budgets the fact audit enforces (`CLAUDE.md` under 80,000 bytes).
4. **The report** (`data/fs131/reports/FS131-FC4.md`, and the same text as your hand-back): per draft — filed, or
   "stands", or `CHECK:` with the reason; each check's last lines; every `CHECK:`; the commits on your branch.

## What is yours to decide

How the script is written; the order of the drafts; how to join a draft's lines to the target file's wrapping.
Nothing about the words: if a draft looks wrong to you — a count that does not match the receipt it cites, a
sentence that contradicts the record's own table — file nothing for that draft and say what you saw.

## The machine

This session is on the laptop, away from the remote: **commit on your branch and do not push**. No Lean build
is part of this job; do not start one, and do not touch the tree's `.lake` folder. `/tmp` is wiped at power-off: keep
what the report cites under `data/fs131/fc4/`.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
