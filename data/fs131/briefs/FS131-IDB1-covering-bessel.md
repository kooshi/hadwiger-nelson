# Brief FS131-IDB1 — the density bound: the Bessel covering checked in the kernel, then the Bessel function's lemmas proved

*Written 2026-10-14 13:19 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-14. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IDB1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the density bound's first implementer — lane C, the covering of `[0, 800]` by 847 cells that bounds the paper's function `ϕ` below through the Bessel function `J₀` (its checker, the checker's soundness theorem, the generated cell modules checked by `decide +kernel`, the tail at 800), then lane B, the Bessel function's own lemmas (its definition by circle averages, its derivatives, its energy, the defect bounds the checker reads), as far as you reach
  launch: now, in the planner's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; three other jobs work in other trees (the density equality's landing, the class-ratio certificates, the chain's implementer) and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if a cell fails in the kernel, if the first two leaves of a lane price it above twice the planner's lines, if a kernel check needs more than 12 GiB or an hour, and with one line when the whole covering passes in the kernel; the report goes to `data/fs131/reports/FS131-IDB1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IDB1-implementation.md` (new, on branch `fs131-wdb1`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g` on a **new branch `fs131-wdb1`** that you cut from its head (`fs131-wdb` at `4311c0fe0`; its build is current for that commit): **lane C** — new modules `Proofs/HadwigerNelson/Plane/DensityBound/BesselCert.lean` and generated `Proofs/HadwigerNelson/Plane/DensityBound/Cells/*.lean` with their lines in the build's lists and `ARCHITECTURE.md`, and the generator `tools/fs131_kdb1_cells.py` (each named in the planner's record § 5); **lane B** — proofs, private helpers and import lines only, **no statement changes, no definition changes**, in `Proofs/HadwigerNelson/Plane/DensityBound/Bessel.lean` and `BesselDefect.lean`; their `ARCHITECTURE.md` rows where a cell's state changes; your checks under `tools/` named for this job; `plans/FS131-IDB1-implementation.md`; `data/fs131/idb1/`; `data/fs131/reports/FS131-IDB1.md`. **Not** `Autocorr.lean`, `Pattern.lean`, `Window.lean`, `Plane/OneAvoidingDensity.lean` (lanes F and P), the instance modules and the theorem (lane X), any other module, the paper's certificate files (read only). Untracked build logs from the planner are in `data/fs131/kdb1/`: leave them. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. Kooshi asked for the density bound to be proved here rather than assumed, and its planner has just finished:
a route with no periodic reduction and no citation to Watson's book on Bessel functions, typed to 28 leaves, priced
from three first leaves and two cuts of the certificate's arithmetic in the kernel. You take the critical lane — the
covering, whose kernel time is the longest single item — and the Bessel lemmas it reads.

## Why this job

Kooshi's word, and his rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

His answer of this morning, `data/fs131/REQUEST-2026-10-13.md` W6: "Yes, prove the density bound." The five-colour
chain's count reads the bound as a named hypothesis; with it proved, the count rests on nothing of anyone else's but
what the library holds.

## The statements

The two dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what the route is and what the
certificate costs:

> - 2026-10-14 — **The density bound has a route with no periodic reduction and no Bessel citation** (FS131-KDB1): `DualCert.oneAvoidingDensityBound_of` (`Plane/DensityBound/Window`) — any valid dual certificate with `bound/(1 − µ) ≤ 0.2470` and `ϕ ≥ 1 − µ` on `[0, ∞)` proves `Plane.OneAvoidingDensityBound`; finite window `E = A ∩ B(x₀, R)`, patterns integrated over all of `ℂ`, Gaussian-regularized positive definiteness, `J₀` by its integral, its ODE and the antitone `‖J₀ + iJ₁‖`; `[AmbrusEtAl2023]`'s certificate unchanged.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **The certificate's analytic half is priced in the kernel** (FS131-KDB1): 847 cells cover `[0, 800]` with margin `4.24·10⁻⁶` (≈ 43 min CPU, ≤ 1.8 GB per module), the tail at `T₁ = 800` by the energy with slack 0.0100; the atom check 7.19 M mask tests (≈ 12 min CPU in ≤ 100 k-test theorems); `min V = −6.712244·10⁻⁸` reproduced.
> — source: data/fs131/claims-NF2.md § Dated lines

The planner's hand-back as I logged it (its words in quotation marks, the rulings mine):

> 845. **FS131-KDB1 handed back: the density bound planned to its leaves and priced (logged 2026-10-14 13:18 UTC; "JOB FS131-KDB1 — DONE"; 533k by the harness's count — past the line, not to be resumed; branch `fs131-wdb` at `4311c0fe0`, tree `fs131-w10g`; record `plans/FS131-KDB1-density-bound.md` there).** From its hand-back message: "`Plane.OneAvoidingDensityBound` — PLANNED, not proved: route chosen, statements typed to 28 leaves (build exit 0), priced from three first leaves and two kernel cuts"; "The certificate is the paper's, unchanged"; "three first leaves proved in scratch, each on the standard three: `autocorr_eq_zero_of_norm_eq_one` (KMOR Lemma 3.2 (1), finite-window form, 8 lines), `abs_J0_le_one` (14 lines), `J0_zero` (2 lines)"; "J₀ covering of `[0, 800]` — 847 cells, min margin `4.24·10⁻⁶` … Whole covering ≈ 43 min CPU in ≈ 45 modules"; "atom check — 13,552 independent sets, `min V = −6.712244·10⁻⁸` (J26's, reproduced), 7.19 M mask tests … ≈ 12 min CPU in ≈ 75 theorems"; "price — ≈ 4,250 hand-written lines (range 2,500–6,500) plus two generators; ≈ 1 h kernel CPU in all"; five lanes with no shared file — B (Bessel, 600), F (Fourier, 900), P (patterns and window, 1,150), C (the covering, 900, "the critical path"), X (the instance and the theorem, 700). **My receipts:** the seven commits exist on `fs131-wdb`; the five skeleton modules hold 27 `sorry`s (13 + 4 + 5 + 2 + 3) beside `Plane/OneAvoidingDensity`'s one; `data/fs131/kdb1/leaves/Leaves.lean` elaborated by me under the memory tool against its built tree: the three leaves each `[propext, Classical.choice, Quot.sound]`. **Rulings, four parts each.** (1) *Lane P's proof of `upperDensity_le_of_oneAvoidingDensityBound` inside `Plane/OneAvoidingDensity`:* approved — a proof in a file whose statements stay as taken, the stored statements dumped before and after; alternative, a second module re-stating the lemma — declined, one fact once; high. (2) *The price:* 4,250 planned lines is about 2,100–3,200 at the implementers' measured 0.5–0.75 (item 829), about 2.5–3.5 active hours at the project's rate (item 825), plus about an hour of kernel CPU — it replaces items 818's and 823's "3–6 agent-weeks", which came from Mathlib's coverage alone; high on the order, medium on the range until lanes C and B re-price from their first two leaves. (3) *Staffing:* lanes B and C to one implementer now, C first (the critical path: its checker's soundness and the generated cell modules, whose kernel time can run while B is proved); F, P and X as slots free; alternative, the M11 planner into this slot — next, its implementers wait on M10 and M2b, which the chain's next implementer proves after FS131-ITK1, so its plan is not yet on the critical path; medium-high — changed if FS131-ITK1 hands back first. **Filed:** its two dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit. **Owed to the second filing:** the bibliography's `[AmbrusEtAl2023]` and `[KMOR2016]` read and role columns, five `LEAN.md` lines (§ The kernel's cost model two, § Searching — Lean three), all drafted in its record § Stage 6; **corrections owed** — the formalization price in items 818 and 823 (above), and a grade note on J26/J49's records (`plans/FS100-KT1-ambrus-ball.md` and those it cites): their checks rest on Watson §§ 13.74 and 15.31, which this route does not need (`antitoneOn_norm_Jc` replaces both) — their verdicts unchanged. **Slip, the job's own, credited:** it reported the exit 143 as unexplained and has since written the diagnosis into its record (§ 4.2). **For lane X's first measurement:** whether a module of ten ≤ 100 k-test theorems peaks at one theorem's memory.
> — source: plans/FS131-close-inventory.md

**Your lanes, in order.** (1) **Lane C** (the planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g/plans/FS131-KDB1-density-bound.md` § 5, its row C; § 4.2 for the measured cuts; § 3.3
for the leaves `BesselCert` reads from lane B — `norm_Jc_sub_le_of_defect`, `abs_J0_le_of_le`, `abs_J0_sub_le` — which
you may read as `sorry` while you build C): the checker as a function on literal data, its soundness theorem (an
accepted cell implies the bound on its interval), the generator writing the ≈ 45 cell modules from
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g/data/fs131/kdb1/proto/plan800.json` with the states as literals (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g/data/fs131/kdb1/proto/lean-states.txt`; the record's measurement: literal
states 1.5 s per cell, computed states 21.8 s), the covering assembled, the tail at `T₁ = 800` by the energy. The
probe `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g/data/fs131/kdb1/probes/CellProbe.lean` is a measured prototype, not a statement: restructure it as you see fit. (2) **Lane B**,
the 17 leaves of `Bessel` and `BesselDefect` (§ 3.3's plan per leaf); two of them, `abs_J0_le_one` and `J0_zero`, are
already proved in scratch (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g/data/fs131/kdb1/leaves/Leaves.lean`) — fold them in first; the third leaf proved there,
`autocorr_eq_zero_of_norm_eq_one`, is lane F's: leave it.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; each leaf's statement restated in one
   line beside its plan; the stored statements of `Bessel`, `BesselDefect` and `Window` dumped from the built tree
   before any edit.
2. **Lane C** (saved stages as it goes, and the one line to me when the covering passes): the checker and its
   soundness theorem, a planted corrupted cell watched being refused by the kernel; every generated cell module built
   under the slot, each module's kernel time and peak memory in a table; the generator's output reproducible from the
   plan file (run twice, identical); re-price the lane from its first two leaves and say so.
3. **Lane B** (saved stages as leaves fall); re-price it from its first two leaves.
4. **No statement and no definition changed** in `Bessel`, `BesselDefect` and `Window`, shown from the kernel's side
   against item 1's dump (a planted change watched firing); one build under the slot with no warning from your files but
   their remaining leaves'; the axioms of every public declaration of your files printed from the built tree — the
   standard three, or `sorryAx` only through named leaves — each listed, with a planted record watched showing;
   `native_decide` nowhere.
5. **Drafts for the landing**, in your record: the audit's block for your files; the kernel-cost lines for `LEAN.md`.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports; the checker's design and the data's encoding within the kernel's cost model; how
the cells are grouped into modules; the order inside each lane; another route for a leaf where the plan's does not go
through (tell me which). An unread binder of a statement in your files is dropped under item 726's word, listed and
named. Not yours: any other change to a statement or definition; `native_decide` or any trust beyond the kernel; the
files listed as not yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a cell module 1.5–3.1 s per cell and at most 1.8 GB
(the planner's measurement). The covering is about 43 minutes of kernel CPU in all: build its modules in batches the
slot admits, not one process at a time.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name idb1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. The certificate job may
hold 12 GiB of the slot for long stretches and the density equality's landing runs whole-library gate steps of about
5.5 GiB: on exit 75 wait ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137 (read the
system log for "oom-kill"; the planner's probe was one). Stop a process by its PID, never by matching its command line.
`/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/idb1/`. Report at once any disk, memory
or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
