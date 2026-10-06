exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
T=WT+"fs131-wop/"
ENV="/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/src/lean/Lean/Environment.lean"
M7=WT+"fs131-w5c/plans/FS131-M7-sync.md"
b=f'''# Brief FS131-T4 — the gate's doubled-name check: a scan that fails when two modules declare one name, and the experiment that says what Lean does with such a pair

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-T4
  identity: {IDENT}
  role: a tooling job — build the gate's check for a name declared by more than one module (a Lean-side scan of every module's constants, with a wrapper script in the form of the gate's other steps), make it fail on a planted pair and on the pair `main` holds today, and run the experiment nobody has run: which copy a downstream `#print axioms` follows when one copy is proved and one is not
  launch: when a slot frees, beside wave 5's jobs on other branches; you work on `main`'s line in a tree of your own
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a second doubled name in the library (at once, with both addresses), an experiment whose outcome means an audited axiom print on `main` could be wrong (at once), or a question you cannot work around; the report goes to `data/fs131/reports/FS131-T4.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail — the second is this job's method
  record: `plans/FS131-T4-dupnames.md` (new, on branch `fs131-t4`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop` (branch `fs131-t4`, cut from `main`; the directory keeps an older lane's name): new files under `scripts/` for the check and its wrapper (names yours, in the pattern of `scripts/Axioms.lean` with `scripts/axioms.sh` and `scripts/Vacuity.lean` with `scripts/vacuity.sh`), a controls file for it, `tools/fs131_t4_*.py`, `data/fs131/t4/` (the planted libraries live here, never under `Proofs/`), `plans/FS131-T4-dupnames.md`, `data/fs131/reports/FS131-T4.md`; **not** anything under `Proofs/` (the pair on `main` is repaired on wave 5's line by another job; here it is your positive control), `LEAN.md`, `CLAUDE.md` or `RUNNING.md` (you draft their lines; I file them), the gate's existing scripts beyond reading them
  budget: about 250k by the harness's count, as guidance; hand back at a saved stage before about 400k — read your token count at every saved stage

Hello. A join of four branches last night found something the gate of this project does not check. The Lean backlog (FS-131) turns hand-derived
results into kernel-checked ones, and its gate — the build, zero `sorry`, the axiom audit, the linters, the vacuity scan — is what "kernel-checked"
means here. The join's implementer, FS131-M7, found one theorem name declared by two modules on `main`, both proved, standing since 2026-10-04 — and
the reason no step saw it: at import, Lean accepts a second constant of a name when both are theorems of one type. You build the check that would
have caught it, and you find out by experiment what such a pair does to the axiom audit.

## Why this job

`CLAUDE.md` § The standard of evidence and `RUNNING.md` § Make the gate fail, and watch it fail: a check counts when it has been seen to fail on the
thing it is for. The risk here is narrow and worth pinning down. By the importer's source, a later-imported theorem of the same name and type
replaces the earlier one; so a downstream `#print axioms` follows one copy, and nobody has tested which, nor what happens when one copy rests on
`sorry` or on a bought axiom and the other is clean. My reading is that no statement can gain a proof it lacks (the two have one type), so this is
hygiene and not soundness — but that is a reading of thirteen lines, by one mind, untested. Kooshi, on what this project's evidence must be:

{Q("CLAUDE.md","- **The artifact is the certificate plus the checker, never the search.**","§ The standard of evidence above rung B")}
The finding and the rulings that launch you:

{item(458)}
{item(459)}
{item(443)}
## The statements

The pair on `main` (identical statements; each proved), and the importer's rule in the pinned toolchain (read l. 2209–2300 of that file whole):

{Q("Proofs/HadwigerNelson/Plane/Chord.lean","theorem conj_e ")}
{Q("Proofs/HadwigerNelson/Plane/SixFragment.lean","theorem conj_e ")}
{Q(ENV,"private def subsumesInfo ")}
{Q(ENV,"    | .thmInfo tval₁, .thmInfo tval₂ => tval₁.all == tval₂.all")}
{Q(ENV,"    | .thmInfo tval₁, .axiomInfo aval₂ => tval₁.all == [aval₂.name] && !aval₂.isUnsafe")}
FS131-M7's account of how it found the pair, what it tested and what it only read (its § 6.3, and the `LEAN.md` bullet it drafted):

{Q(M7,"### 6.3 ")}
## Done means

1. **Your readback first**: check every quotation above against its source; read M7's § 6.3 and its scanner
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/tools/fs131_m7_dupes.py`: textual, and its normalizer has a known false-pair class),
   the importer's code, and the gate's two Lean-side steps as models (`scripts/Axioms.lean` with `scripts/axioms.sh`; `scripts/Vacuity.lean` with
   `scripts/vacuity.sh`; `scripts/gate_report.py`). Build the branch once as given (expect it up to date). Open your record. Commit and push.
2. **The experiment, before the tool** — in a scratch Lake library under `data/fs131/t4/` (its own tiny package against the same toolchain; nothing
   under `Proofs/`): two sibling modules that each declare a theorem of one name and type, and a third that imports both and uses it. Record, for
   each import order: does it build; which copy does the downstream environment hold; what does `#print axioms` of the downstream theorem print
   when (i) both are clean, (ii) one is `sorry`, (iii) one rests on a declared `axiom` — and (iv) one copy is an `axiom` of that name and type and
   the other a theorem; (v) the types differ (expect an error: watch it). Then the same with one module upstream of the other. Write the table.
   **If any row shows a downstream print that is clean while the copy a proof was compiled against is not, message me at once.**
3. **The check**: a Lean-side scan over the built library that reports every name declared by two or more modules of this package — constants as
   the kernel sees them, so instances and generated declarations are covered, with whatever exclusion list turns out to be needed stated and
   justified (compiler-generated names that legitimately repeat, if any) — and a wrapper that exits non-zero on any report and prints the pair with
   both modules. Whether it also compares against the dependencies' names (Mathlib) is yours to decide and say.
4. **Watch it fail, three ways**: on your planted pair; on `main` as it stands — it must report `conj_e` in `Plane/Chord` and `Plane/SixFragment`,
   and you say whether it reports anything else (a second pair is a message to me); and with the check itself broken (a planted fault in the tool
   that makes it pass, watched to be caught by its control). A controls file in the pattern of `scripts/axioms-controls.txt`.
5. **The drafts**, in your record under "Drafts for the front page", each with its slot: the bullet for `LEAN.md` § The gate (start from M7's
   draft; state what the experiment showed, at the grade it showed it); the line for the landing procedure (when the check runs, its command); one
   line for `plans/STANDING-RULES.md` only if you think every lane should know this (say why).
6. No file under `Proofs/` changed; no gate run on `main` by you (your check is run by you on this tree as its own evidence). Run long processes
   under the slot (`/home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 8 -- <command>`); never `lake build` in this tree (the scratch
   package under `data/fs131/t4/` is its own tiny build and may use `lake` there, under the slot). Leave no background process running.
7. **Your record**, stages headed "Stage n — SAVED (FS131-T4)"; the report in standing rule 11's form. Stopping at a saved stage with the
   experiment's table written and the tool not finished is a good report: the table is the part nobody has.

## What is yours to decide

The scan's implementation (reading each module's compiled data, or walking the environment with each constant's module index), its exclusions, the
wrapper's form, and how far the experiment goes beyond the rows above. If the experiment contradicts my reading — or M7's — say so plainly; the
`LEAN.md` bullet follows the experiment, not either of us. If you find the pair's presence could have changed any filed count of the axiom audit,
say which and how. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it
knows exists).

## The machine

`/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record cites under `data/fs131/t4/`. The tree's `.lake/build` is its own
copy of a green build of `main`'s line; never replace it with a symlink, and do not rebuild `Proofs` beyond the as-given check. Nothing with a `sorry`
reaches `main`.
'''
open(ROOT+"data/fs131/briefs/FS131-T4-dupnames.md","w").write(b)
