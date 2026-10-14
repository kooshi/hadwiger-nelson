# Brief FS131-IDB2 — the density bound: the Fourier side and the window proved, then the certificate's instance and the theorem

*Written 2026-10-14 17:03 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-14. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IDB2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the density bound's second implementer — lane F, the Fourier side (`Autocorr`: the autocorrelation of a window and its positive definiteness by Gaussian regularization), then lane P, the patterns and the window (`Pattern`, `Window`, and the one leaf of `Plane/OneAvoidingDensity`), then lane X, the paper's certificate as a Lean instance and the theorem `m₁(ℝ²) ≤ 0.2470` itself, as far as you reach
  launch: now, in the first implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; four other jobs share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if the first two leaves of a lane price it above twice the planner's lines, if a kernel check needs more than 12 GiB or an hour, if the paper's eq. (22) or Theorem 1 differs in any respect from what the library states, and with one line when `Plane.OneAvoidingDensityBound` is proved; the report goes to `data/fs131/reports/FS131-IDB2.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IDB2-implementation.md` (new, on branch `fs131-wdb2`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g` on a **new branch `fs131-wdb2`** that you cut from its head (`fs131-wdb1` at `c180a0f33`; its build is current for that commit — never switch this tree to another line: its 46 cell modules cost 41 minutes of kernel time to rebuild): **proofs, private helpers and import lines only — no statement changes, no definition changes** in `Proofs/HadwigerNelson/Plane/DensityBound/Autocorr.lean` (lane F), `Pattern.lean` and `Window.lean` (lane P), and in `Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean` the one proof of `upperDensity_le_of_oneAvoidingDensityBound` (approved, item 845 ruling 1; the statements there are the paper's, unchanged); lane X's new modules `Proofs/HadwigerNelson/Plane/DensityBound/X23*.lean` and `Theorem.lean` with their generator `tools/fs131_kdb1_x23.py` (each named in the planner's record § 5) and their lines in the build's lists and `ARCHITECTURE.md`; rows where a cell's state changes; your checks under `tools/` named for this job; `plans/FS131-IDB2-implementation.md`; `data/fs131/idb2/`; `data/fs131/reports/FS131-IDB2.md`. **Not** `Bessel`, `BesselDefect`, `BesselCert`, `BesselCheck` or `Cells/*` (proved), any other module, the paper's certificate files (read only). Untracked logs of the earlier jobs in `data/fs131/kdb1/` and `data/fs131/idb1/`: leave them. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. Kooshi asked for the density bound to be proved here. Its planner found a route with no periodic reduction; its
first implementer checked the Bessel covering in the kernel — the paper's function stays above 0.99994 on all of
`[0, ∞)` — and proved the Bessel lemmas. Three lanes are left. You take them in order.

## Why this job

Kooshi's word, and his rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

His answer of this morning, `data/fs131/REQUEST-2026-10-13.md` W6: "Yes, prove the density bound." The five-colour
chain's count reads the bound through `upperDensity_le_of_oneAvoidingDensityBound`, one of the four leaves its proof now
waits on.

## The statements

The two dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what the route is and what the
certificate costs:

> - 2026-10-14 — **The density bound has a route with no periodic reduction and no Bessel citation** (FS131-KDB1): `DualCert.oneAvoidingDensityBound_of` (`Plane/DensityBound/Window`) — any valid dual certificate with `bound/(1 − µ) ≤ 0.2470` and `ϕ ≥ 1 − µ` on `[0, ∞)` proves `Plane.OneAvoidingDensityBound`; finite window `E = A ∩ B(x₀, R)`, patterns integrated over all of `ℂ`, Gaussian-regularized positive definiteness, `J₀` by its integral, its ODE and the antitone `‖J₀ + iJ₁‖`; `[AmbrusEtAl2023]`'s certificate unchanged.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **The certificate's analytic half is priced in the kernel** (FS131-KDB1): 847 cells cover `[0, 800]` with margin `4.24·10⁻⁶` (≈ 43 min CPU, ≤ 1.8 GB per module), the tail at `T₁ = 800` by the energy with slack 0.0100; the atom check 7.19 M mask tests (≈ 12 min CPU in ≤ 100 k-test theorems); `min V = −6.712244·10⁻⁸` reproduced.
> — source: data/fs131/claims-NF2.md § Dated lines

The planner's and the first implementer's hand-backs, as I logged them (their words in quotation marks, the rulings mine):

> 845. **FS131-KDB1 handed back: the density bound planned to its leaves and priced (logged 2026-10-14 13:18 UTC; "JOB FS131-KDB1 — DONE"; 533k by the harness's count — past the line, not to be resumed; branch `fs131-wdb` at `4311c0fe0`, tree `fs131-w10g`; record `plans/FS131-KDB1-density-bound.md` there).** From its hand-back message: "`Plane.OneAvoidingDensityBound` — PLANNED, not proved: route chosen, statements typed to 28 leaves (build exit 0), priced from three first leaves and two kernel cuts"; "The certificate is the paper's, unchanged"; "three first leaves proved in scratch, each on the standard three: `autocorr_eq_zero_of_norm_eq_one` (KMOR Lemma 3.2 (1), finite-window form, 8 lines), `abs_J0_le_one` (14 lines), `J0_zero` (2 lines)"; "J₀ covering of `[0, 800]` — 847 cells, min margin `4.24·10⁻⁶` … Whole covering ≈ 43 min CPU in ≈ 45 modules"; "atom check — 13,552 independent sets, `min V = −6.712244·10⁻⁸` (J26's, reproduced), 7.19 M mask tests … ≈ 12 min CPU in ≈ 75 theorems"; "price — ≈ 4,250 hand-written lines (range 2,500–6,500) plus two generators; ≈ 1 h kernel CPU in all"; five lanes with no shared file — B (Bessel, 600), F (Fourier, 900), P (patterns and window, 1,150), C (the covering, 900, "the critical path"), X (the instance and the theorem, 700). **My receipts:** the seven commits exist on `fs131-wdb`; the five skeleton modules hold 27 `sorry`s (13 + 4 + 5 + 2 + 3) beside `Plane/OneAvoidingDensity`'s one; `data/fs131/kdb1/leaves/Leaves.lean` elaborated by me under the memory tool against its built tree: the three leaves each `[propext, Classical.choice, Quot.sound]`. **Rulings, four parts each.** (1) *Lane P's proof of `upperDensity_le_of_oneAvoidingDensityBound` inside `Plane/OneAvoidingDensity`:* approved — a proof in a file whose statements stay as taken, the stored statements dumped before and after; alternative, a second module re-stating the lemma — declined, one fact once; high. (2) *The price:* 4,250 planned lines is about 2,100–3,200 at the implementers' measured 0.5–0.75 (item 829), about 2.5–3.5 active hours at the project's rate (item 825), plus about an hour of kernel CPU — it replaces items 818's and 823's "3–6 agent-weeks", which came from Mathlib's coverage alone; high on the order, medium on the range until lanes C and B re-price from their first two leaves. (3) *Staffing:* lanes B and C to one implementer now, C first (the critical path: its checker's soundness and the generated cell modules, whose kernel time can run while B is proved); F, P and X as slots free; alternative, the M11 planner into this slot — next, its implementers wait on M10 and M2b, which the chain's next implementer proves after FS131-ITK1, so its plan is not yet on the critical path; medium-high — changed if FS131-ITK1 hands back first. **Filed:** its two dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit. **Owed to the second filing:** the bibliography's `[AmbrusEtAl2023]` and `[KMOR2016]` read and role columns, five `LEAN.md` lines (§ The kernel's cost model two, § Searching — Lean three), all drafted in its record § Stage 6; **corrections owed** — the formalization price in items 818 and 823 (above), and a grade note on J26/J49's records (`plans/FS100-KT1-ambrus-ball.md` and those it cites): their checks rest on Watson §§ 13.74 and 15.31, which this route does not need (`antitoneOn_norm_Jc` replaces both) — their verdicts unchanged. **Slip, the job's own, credited:** it reported the exit 143 as unexplained and has since written the diagnosis into its record (§ 4.2). **For lane X's first measurement:** whether a module of ten ≤ 100 k-test theorems peaks at one theorem's memory.
> — source: plans/FS131-close-inventory.md

> 866. **FS131-IDB1 handed back: the density bound's covering and its Bessel lemmas proved (logged 2026-10-14 15:11 UTC; "JOB FS131-IDB1 — DONE"; 566k by the harness's count — past the line, not to be resumed; branch `fs131-wdb1` at `c180a0f33`, tree `fs131-w10g`; record `plans/FS131-IDB1-implementation.md` there).** From its hand-back message: "`HadwigerNelson.DensityBound.BesselCert.Cells.phiApprox_ge` … [kernel] … for every list `d` of 27 reals with `|dₖ − Dₖ/2⁶⁴| ≤ 2⁻⁶⁴` and `dₖ ≥ 0` … and every `t ≥ 0`, `99994/100000 ≤ P23.w1N/10²⁰ + Σₖ (P23.Wsₖ/10²⁰)·J₀(t dₖ)`. Read against `[AmbrusEtAl2023]`'s eq. (22) as this repository states it … I did not re-read the paper's page myself"; "847 cells covering `[0, 800]` by `decide +kernel` from `J(0) = (1, 0)`, then the tail past 800 (slack 0.010040)"; lane C's soundness chain and lane B's 17 leaves, each on the standard three; "no statement and no definition changed in `Bessel`, `BesselDefect` or `Window`"; "2,016 public records of the 52 modules … 997 rest on a subset of the standard three and 1,019 on none. No record rests on `sorryAx` or on a native axiom"; "`lake lint` passed"; kernel cost 3,525 s of compile in 46 parts, 1.59–2.38 GB each; two planted faults refused, their partners passing; the generator reproducible; re-priced lane C at 1.3× its plan, lane B at 0.55×. **My receipts:** item 861 (`phiApprox_ge` on the standard three, no `sorry` in the four files); the six commits exist; `Plane/DensityBound/BesselCheck.lean` imports nothing (core only, as reported). **Rulings, four parts.** (1) *The new module `Plane/DensityBound/BesselCheck`, outside the brief's file list:* accepted — the checker's design was the lane's, and the split keeps the 46 cell modules off Mathlib (1.95 GB against 4.60 GB) and off every Bessel edit's rebuild (41 minutes of kernel time); alternative, fold it back into `BesselCert` — declined for those costs; high. (2) *`phiApprox_ge` in `Cells/Covering`, parametric in the distance list `d` with no `t·η′` term:* accepted — the planner's record left lane C's checker functions to the implementer, and lane X reads this form; lane X's brief quotes it and its question (the identification `X23.phi X23w0 t = P23.w1N/P23.WS + jsum P23.Ws d t / P23.WS` and `Close P23.Ds d` from its own distance bounds); medium-high — the read-aloud against the paper's eq. (22) is owed by lane X, which reads the page itself. (3) *The audit block naming each part's `segNN_ok`:* the landing's choice; the audit tool prints every record anyway. **Corrections owed (the planner's record, to the second filing):** its § 4.2 "≤ 1.8 GB per module" holds only for a core-only file (4.60 GB with Mathlib); its § 3.3's separate limit at a = 0 for `norm_Jc_sub_le_of_defect` is not needed. **For lane X:** a module of 18–29 `decide +kernel` theorems peaked at 1.6–2.4 GB (item 845's question answered); a core-only checker saves about 2.7 GB per process. **Design rule drafted for `LEAN.md`:** a certificate's checker in a core-only module, its soundness in a second, the generated modules importing only the first. **Slips, the job's own, credited:** two waiters armed true (a grep matching `build.sh`'s first line; a `pgrep -f` matching its own shell), caught from the log, nothing lost. **The slot:** to the M11 planner (item 867).
> — source: plans/FS131-close-inventory.md

**Your lanes, in order** (the planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g/plans/FS131-KDB1-density-bound.md` § 5 for the lanes, § 3.3 for the plan per leaf): (1) **F** —
`Autocorr` (5 leaves; its first, `autocorr_eq_zero_of_norm_eq_one`, is proved in scratch in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g/data/fs131/kdb1/leaves/Leaves.lean` —
fold it in). (2) **P** — `Pattern`, `Window` and `upperDensity_le_of_oneAvoidingDensityBound`. (3) **X** — the data
generator, edges, congruences, distances and the atom check (≈ 75 theorems of ≤ 100 k mask tests each), then `X23_valid`,
`X23_phi` (from `BesselCert.Cells.phiApprox_ge` as the first implementer stated it — its record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g/plans/FS131-IDB1-implementation.md`, and item 866's
question for lane X), `X23_ratio`, and the theorem. **Before lane X proves anything, read the paper's eq. (22) and
Theorem 1 yourself** in `/home/kooshi/source/library/pdf/arXiv-2207.14179-ambrus-csiszarik-matolcsi-varga-zsamboki-density-planar-sets.pdf` and record, word for word, how the library's `ϕ`, `µ`, `w₀`, `w₁`, `w₂` and the bound
0.2470 match them. Re-price each lane from its first two leaves.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; each leaf's statement restated in one
   line beside its plan; the stored statements of your files dumped from the built tree before any edit.
2. **F, then P** (saved stages as leaves fall); re-priced from their first two leaves.
3. **X** (saved stages): the paper read against the library first; each generated module's kernel time and peak memory in
   a table; a planted corrupted entry refused in each new checker; the generator's output reproducible (run twice,
   identical); and the one line to me when `Plane.OneAvoidingDensityBound` is proved.
4. **No statement and no definition changed**, shown from the kernel's side against item 1's dump (a planted change
   watched firing); one build under the slot with no warning from your files but their remaining leaves'; the axioms of
   every public declaration of your files printed from the built tree, each listed, with a planted record watched
   showing; `native_decide` nowhere.
5. **Drafts for the landing**, in your record: the audit's block; the kernel-cost lines for `LEAN.md`; bibliography lines.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports; the order inside each lane; the checkers' design and the data's encoding within the
kernel's cost model (a checker in a core-only module, its soundness in a second, the generated modules importing only the
first, as the first implementer found); another route for a leaf where the plan's does not go through (tell me which).
An unread binder of a statement in your files is dropped under item 726's word, listed and named. Not yours: any other
change to a statement or definition; `native_decide` or any trust beyond the kernel; the files listed as not yours; the
landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a core-only certificate module 1.6–2.4 GB (the first
implementer's measurement); the atom check's theorems at ≤ 100 k tests each about 15 s and 2.2 GB (the planner's).

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name idb2 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile. The certificate job may hold up to 10 GiB of the slot
for long stretches: on exit 75 wait ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not
137 (read the system log for "oom-kill"). Stop a process by its PID, never by matching its command line — a `pgrep -f`
pattern matches the shell running it. `/tmp` is wiped at power-off: anything your record cites lives under
`data/fs131/idb2/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
