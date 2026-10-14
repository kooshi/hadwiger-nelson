# Brief FS131-IKC1 — the class-ratio certificates: the checker proved sound, p = 11 into the library, p = 19 in a form that fits

*Written 2026-10-14 13:45 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IKC1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the implementer of the class-ratio certificates for the five-colour chain — first the soundness theorem of the certificate checker (an accepted certificate implies the class-ratio bound on FS-66's region), by a reference checker proved sound and the fast checker shown to imply it; then the p = 11 certificate's data and kernel checks as library modules, cut to fit the build's memory cap; then the p = 19 certificate in the new form its planner priced, as far as you reach
  launch: now, in the certificate planner's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; three other jobs work in other trees (the density equality's landing, the density bound's covering, the chain's implementer) and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if the soundness theorem is false as typed or needs a hypothesis it lacks, if a kernel check needs more than 12 GiB or an hour, if K2's first two children price it above 4,000 lines, and with one line when `sum_le_of_certOK` prints the standard three and when p = 19's check passes; the report goes to `data/fs131/reports/FS131-IKC1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IKC1-implementation.md` (new, on branch `fs131-wc14`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf` on a **new branch `fs131-wc14`** that you cut from its head (`fs131-wc13` at `7be9eef34`; its build is current for that commit): `Proofs/HadwigerNelson/Arith/FibreCertSound.lean` — proofs and private helpers, **the conclusions of `sum_le_of_certOK` and `card_le_of_certOK` unchanged**; `Proofs/HadwigerNelson/Arith/FibreCert.lean` — the checker, which you may restructure (a reference checker beside it, F2's parts), each change to `certOK`'s definition listed and shown not to weaken what the soundness theorem concludes; `Proofs/HadwigerNelson/Arith/FibreCert3.lean`; new generated modules under `Proofs/HadwigerNelson/Arith/` for p = 11 and p = 19 (data and checks) with their lines in the build's lists and `ARCHITECTURE.md`; the converter `tools/fs131_kc13_gen.py` and your tools under `tools/` named for this job; `plans/FS131-IKC1-implementation.md`; `data/fs131/ikc1/`; `data/fs131/reports/FS131-IKC1.md`. **Not** `data/fs66/` (read only), any other module, the chain's `Rigidity/ClassRatio` (on another branch; its leaves K3–K5 are a later job). Untracked files from the planner are in `data/fs131/kc13/`: leave them. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. The five-colour chain needs, at the two residue sizes where the eigenvalue bound fails, a ratio bound that
rests on exact integer certificates this project found earlier (FS-66) and checked only by Python. Its planner has just
shown the kernel checks the smaller one in about three minutes, typed what an accepted certificate means, and priced
the rest. You make the checker's meaning a theorem, and bring both certificates in.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

Under it, a certificate checked only by Python is not a result of the library; an accepted certificate is one only
once the checker is proved sound. The class-ratio module is on the chain's critical path, upstream of the count.

## The statements

The three dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what is checked, what is not
yet, and what it costs:

> - 2026-10-14 — **FS-66's p = 11 certificate is kernel-checked; what it implies is typed, its proof planned** (FS131-KC13): `certOK cert11` passes `decide +kernel` in three declarations. The identity takes 93.7 s / 12.0 GB and 76.4 s / 11.0 GB, positive definiteness 14.8 s / 2.9 GB. The converter is untrusted. `Arith/FibreCertSound.sum_le_of_certOK` (`Σφ ≤ U_num/L` on FS-66's region) is typed with its proof `sorry`, planned in `plans/FS131-KC13-certificates.md` § 5.2 (K2). No typed statement of the chain changes.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **The p = 19 certificate does not fit the present checker's form** (FS131-KC13 § 3): one segment of 32, and the K table alone, each exceeded a 12 GiB cap. Form F2 is priced at about 30 minutes of kernel CPU in about 40 declarations of at most 10 GB (extrapolated from p = 11's decomposition, not run). F2 repeats no phase 1 and gives each segment its own op list.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **M13's per-prime leaf at q ∈ {11, 19} is priced at about 3,500–6,700 lines** (FS131-KC13 § 5.2). The checker's soundness (K2, 2,000–4,000) is not inside the map's 2,500–5,000 for M13. Lemma P (K4) is one leaf shared by every branch.
> — source: data/fs131/claims-NF2.md § Dated lines

The planner's hand-back as I logged it (its words in quotation marks, the rulings mine):

> 848. **FS131-KC13 handed back: the p = 11 class-ratio certificate checks in the kernel; p = 19 needs a new form; M13's per-prime leaf planned (logged 2026-10-14 13:44 UTC; "JOB FS131-KC13 — DONE"; 583k by the harness's count — past the line, not to be resumed; branch `fs131-wc13` at `7be9eef34`, tree `fs131-wnf`; record `plans/FS131-KC13-certificates.md` there).** From its hand-back message: "**The p = 11 certificate passes the kernel check.** Every part of `certOK` passes `decide +kernel` on the laptop, under the slot: 185 s of kernel time in all, at most 12.0 GB per declaration" (`segCheck cert11 0` 93.7 s / 12.0 GB, `segCheck cert11 1` 76.4 s / 11.0 GB, `psdAll cert11` 14.8 s / 2.9 GB); "What an accepted certificate means is `FibreCertSound.sum_le_of_certOK` … It is typed, but its proof is `sorry`. So this is a measured price, not yet a result of the library"; planted faults refused (five at p = 3, one at p = 11 in 56.6 s); "The kernel's caches hash a `Nat` literal by its low 64 bits … one computation took 33 s against 1.25 s"; "**The p = 19 certificate does not run in the present form.** One segment of 32 was killed at its 12 GiB cap … Form F2 is priced at about 30 minutes of kernel CPU in about 40 declarations of at most 10 GB each … extrapolated … not run"; at 23 and 31 "rational cosine bounds … About 700–1,200 lines, kernel seconds"; the per-prime leaf planned, "no defect", the q ∈ {11, 19} branch "about 3,500–6,700 lines" (K1 generated checks, K2 the checker's soundness 2,000–4,000, K3 300–500, K4 with Lemma P 1,000–1,800 shared by every branch, K5 and glue). **My receipts:** the five commits exist; `Arith/FibreCert.lean` and `Arith/FibreCert3.lean` hold no `sorry`, `Arith/FibreCertSound.lean` two; from the tree's compiled library (scratch `kc13/Ax.lean`): `FibreCert.cert3_ok : certOK cert3 = true` — `[propext]`, a `decide +kernel` proof of the p = 3 certificate. **Rulings, four parts each.** (1) *p = 11's data and checks into the library now or with the landing:* with the landing, split into four identity segments under the build's 10 GB cap and measured there; alternative, now in two segments — declined, at 11–12 GB they exceed the build's cap, and nothing reads them until the soundness theorem is proved; high. (2) *p = 19 — form F2 now, or the smaller-relaxation search first:* F2 by the next implementer, and the search request queued for the Searcher (`plans/SEARCH-QUEUE.md` row 24) — if a smaller certificate arrives first, the implementer switches; alternative, wait for the search — declined, F2 is about 300 checker lines and 30 minutes of kernel time, affordable now, and the search's yes is not certain; medium-high — changed if the Searcher's run comes before F2's checker is written. (3) *The next job:* an implementer on this branch for K2 (the soundness, the critical part: a reference checker first, then the fast one shown to imply it, the record's mitigation), K1 at p = 11 in four segments, then F2 at p = 19; K3–K5 go to the chain's line after its join, Lemma P with them; alternative, K3–K5 first — declined, they read `Rigidity/ClassRatio`, which is on the chain's unjoined branch; high. **Correction owed, for the map and for Kooshi's next report:** M13's q ∈ {11, 19} branch alone is about 3,500–6,700 lines; the map's 2,500–5,000 for the whole of M13 did not include the checker's soundness. **Generalization, noted:** `sum_le_of_certOK` needs no primality and is stated for every p ≥ 2. **Filed:** its three dated lines in `data/fs131/claims-NF2.md` (each joined onto one line as the file holds them; words unchanged), and the search request as row 24 of `plans/SEARCH-QUEUE.md`, this commit. **Owed to the second filing:** four `LEAN.md` lines (§ The kernel's cost model: the low-64-bit literal hash, intermediates retained to the declaration's end, direct `Nat.*` calls and `Nat.rec` against notation and structural recursion, literal parse and size costs) and its bibliography lines, drafted in its record § 6.2–6.3. **Slips, the job's own, credited:** a `pgrep -f` pattern that matched its own shell (exit 144; nothing lost; then stopped by PID), and a 13 GiB request where 3 GiB served (resubmitted at 5).
> — source: plans/FS131-close-inventory.md

**Your work, in order.** (1) **K2, the soundness** (the planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/plans/FS131-KC13-certificates.md` § 5.2, its table K2a–K2i and "What is
hard"): write the specification `ops` and a reference checker on it first, prove the reference sound (K2e–K2i), then
prove the fast checker's acceptance implies the reference's (K2a–K2c); where a computation lemma resists, simplify the
fast checker there and re-measure. The p = 3 check (`cert3_ok`, in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/Proofs/HadwigerNelson/Arith/FibreCert3.lean`) then gives the first
instance of the bound. (2) **K1 at p = 11** (§ 5.4): the data module and the identity checks in four segments, each
built under the slot within the build's 10 GB cap, measured. (3) **F2 at p = 19** (§ 3.2): the K table as checked
literals, phase 1 once per orbit range, per-segment op lists, the cover check, PSD block by block; measure each part.
Row 24 of `plans/SEARCH-QUEUE.md` asks the Searcher whether a smaller relaxation clears 1/4; if its answer arrives
first, I will tell you, and you switch.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; K2's children restated in one line
   each beside their plan; the stored statements of the three `FibreCert` modules dumped from the built tree before any
   edit.
2. **K2** (saved stages as children fall, and the one line to me when `sum_le_of_certOK` prints the standard three);
   re-price it from its first two children and say so.
3. **K1** (a saved stage): p = 11's modules built under the slot, each declaration's kernel time and peak memory in a
   table; `cert11_ok` from them, and the bound at p = 11 from `sum_le_of_certOK` if it is proved by then.
4. **F2** (saved stages): its parts built and measured, a planted corrupted entry watched being refused in each new
   part; `cert19_ok` if it passes.
5. **No conclusion weakened**: the soundness theorems' stored statements shown from the kernel's side against item 1's
   dump (a planted change watched firing), every change to `certOK`'s definition listed; one build under the slot with
   no warning from your files but their remaining leaves'; the axioms of every public declaration of your files printed
   from the built tree, each listed, with a planted record watched showing; `native_decide` nowhere.
6. **Drafts for the landing**, in your record: the audit's block; the kernel-cost lines for `LEAN.md`.
7. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; the checker's design within the kernel's cost model (the planner's record § 2.1 and its
cost facts are measurements, not statements); the data's encoding; how declarations are cut into modules; the order
inside each item; another route for a child where the plan's does not go through (tell me which). Not yours: a change
to what the soundness theorems conclude; `native_decide` or any trust beyond the kernel; the files listed as not
yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a certificate declaration up to 12 GB (the
planner's measurements, record § 2.2 and § 3.1). The kernel's caches hash a `Nat` literal by its low 64 bits (record
§ 2.1): tag the low digit of packed data.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ikc1 -- <command>`

Ask for at most 12 GiB without telling me first, and for what a declaration needs, not more. The build: `--mem 10 --cpus
4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. The density equality's landing runs whole-library
gate steps of about 5.5 GiB and the density bound's covering builds cell modules of up to 1.8 GB each: on exit 75 wait
ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137 (read the system log for
"oom-kill"). Stop a process by its PID, never by matching its command line — a `pgrep -f` pattern matches the shell
running it. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/ikc1/`. Report at once any
disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
