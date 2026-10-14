# Brief FS131-IKC3 — the class-ratio certificates: the checker proved sound, p = 11 into the library, p = 19 in a form that fits

*Written 2026-10-14 17:42 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IKC3
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the third implementer of the class-ratio certificates for the five-colour chain — the checker is now proved sound; first the p = 11 certificate's data and kernel checks as library modules at eight segments, measured, and the class-ratio bound at p = 11 as a named theorem; then the p = 19 certificate in form F2 — its checker parts, then the soundness proof's computation half re-proved for the changed checker — as far as you reach
  launch: now, in the second implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; three other jobs work in other trees (the density equality's landing, the density bound's covering, the chain's implementer) and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if the soundness theorem is false as typed or needs a hypothesis it lacks, if a kernel check needs more than 12 GiB or an hour, if K2's first two children price it above 4,000 lines, and with one line when `sum_le_of_certOK` prints the standard three and when p = 19's check passes; the report goes to `data/fs131/reports/FS131-IKC3.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IKC3-implementation.md` (new, on branch `fs131-wc16`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf` on a **new branch `fs131-wc16`** that you cut from its head (`fs131-wc15` at `1e0990dad`; its build is current for that commit): `Proofs/HadwigerNelson/Arith/FibreCertSound.lean` — proofs and private helpers, **the stored statements of `sum_le_of_certOK` and `card_le_of_certOK` unchanged** (F2's changes to `certOK` re-prove its computation half); `Proofs/HadwigerNelson/Arith/FibreCert.lean` — the checker, which you extend for F2's parts (per-segment op lists, tree literals, the cover bitmask); every change to `certOK`'s definition listed beside the proof step that needs it, and the counterexample controls of the first implementer still refused; `Proofs/HadwigerNelson/Arith/FibreCert3.lean`; new generated modules under `Proofs/HadwigerNelson/Arith/` for p = 11 and p = 19 (data and checks) with their lines in the build's lists and `ARCHITECTURE.md`; the converter `tools/fs131_kc13_gen.py` and your tools under `tools/` named for this job; `plans/FS131-IKC3-implementation.md`; `data/fs131/ikc3/`; `data/fs131/reports/FS131-IKC3.md`. **Not** `data/fs66/` (read only), any other module, the chain's `Rigidity/ClassRatio` (on another branch; its leaves K3–K5 are a later job). Untracked files from the earlier jobs are in `data/fs131/kc13/`, `data/fs131/ikc1/` and `data/fs131/ikc2/`, and a generator summary beside `FibreCert3.lean`: leave them. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. The class-ratio checker was found unsound, strengthened, and is now proved sound in the kernel: an accepted
certificate implies the bound. What is left is to bring the two certificates into the library — p = 11 in a form that is
already measured, p = 19 in a new form its planner priced and the last implementer flagged as reopening part of the proof.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

Under it, a certificate checked only by Python is not a result of the library; an accepted certificate is one only
once the checker is proved sound. The class-ratio module is on the chain's critical path, upstream of the count.

## The statements

The dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what is checked, what was wrong with
the first checker, what is left, and what it costs:

> - 2026-10-14 — **FS-66's p = 11 certificate is kernel-checked; what it implies is typed, its proof planned** (FS131-KC13): `certOK cert11` passes `decide +kernel` in three declarations. The identity takes 93.7 s / 12.0 GB and 76.4 s / 11.0 GB, positive definiteness 14.8 s / 2.9 GB. The converter is untrusted. `Arith/FibreCertSound.sum_le_of_certOK` (`Σφ ≤ U_num/L` on FS-66's region) is typed with its proof `sorry`, planned in `plans/FS131-KC13-certificates.md` § 5.2 (K2). No typed statement of the chain changes.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **The p = 19 certificate does not fit the present checker's form** (FS131-KC13 § 3): one segment of 32, and the K table alone, each exceeded a 12 GiB cap. Form F2 is priced at about 30 minutes of kernel CPU in about 40 declarations of at most 10 GB (extrapolated from p = 11's decomposition, not run). F2 repeats no phase 1 and gives each segment its own op list.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **M13's per-prime leaf at q ∈ {11, 19} is priced at about 3,500–6,700 lines** (FS131-KC13 § 5.2). The checker's soundness (K2, 2,000–4,000) is not inside the map's 2,500–5,000 for M13. Lemma P (K4) is one leaf shared by every branch.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **The certificate checker as first typed accepted a certificate it should not** (FS131-IKC1; a kernel counterexample, the coordinator's ruling): `FibreCert.certOK` checked only the segments below `nseg`, not that every op's slot lies in one, so a copy of the p = 3 certificate with the constant class's two ops sent to an unowned slot and `U_num = 0` is accepted, and `sum_le_of_certOK` is false over that checker (`not_sum_le_of_certOK`, on the standard three). The checker is being strengthened — every op's slot owned, block sizes matched to their reps, list lengths bounded, the PSD check's digit and column bounds checked — so that it accepts fewer certificates; the soundness theorems' statements do not change. FS131-KC13's p = 11 measurement stands as a computation and is re-run under the strengthened checker.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **The certificate checker is strengthened; p = 11 passes it** (FS131-IKC1, the coordinator's ruling of inventory item 853): `FibreCert.certOK` now checks that every op's slot lies in a checked segment, every block's size against its reps, the monomials' lengths, and the PSD check's digit and column bounds; the kernel refuses the counterexample certificate and one planted certificate per gap, and accepts the p = 3 certificate; FS-66's p = 11 certificate passes in six declarations, about 320 s and at most 9.5 GB each (probe files, not yet library modules). `sum_le_of_certOK`'s statement is unchanged; its proof's computation half is proved, four leaves (`psd_of_psdCheck`, `blockT_nonneg`, `opSum_O23_eq`, `opSum_O4_eq`) remain.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **The class-ratio checker is proved sound** (FS131-IKC2): `FibreCertSound.sum_le_of_certOK` and `card_le_of_certOK` are kernel theorems on the standard three, their stored statements unchanged since FS131-KC13 typed them; `certOK`'s definition unchanged since FS131-IKC1 strengthened it. An accepted certificate now implies `Σφ ≤ U_num/L` on FS-66's region at its `p`. The p = 11 certificate's library modules (K1) and p = 19's form F2 are not yet built.
> — source: data/fs131/claims-NF2.md § Dated lines

The planner's hand-back and the first two implementers' hand-backs, as I logged them (their words in
quotation marks, the rulings mine):

> 848. **FS131-KC13 handed back: the p = 11 class-ratio certificate checks in the kernel; p = 19 needs a new form; M13's per-prime leaf planned (logged 2026-10-14 13:44 UTC; "JOB FS131-KC13 — DONE"; 583k by the harness's count — past the line, not to be resumed; branch `fs131-wc13` at `7be9eef34`, tree `fs131-wnf`; record `plans/FS131-KC13-certificates.md` there).** From its hand-back message: "**The p = 11 certificate passes the kernel check.** Every part of `certOK` passes `decide +kernel` on the laptop, under the slot: 185 s of kernel time in all, at most 12.0 GB per declaration" (`segCheck cert11 0` 93.7 s / 12.0 GB, `segCheck cert11 1` 76.4 s / 11.0 GB, `psdAll cert11` 14.8 s / 2.9 GB); "What an accepted certificate means is `FibreCertSound.sum_le_of_certOK` … It is typed, but its proof is `sorry`. So this is a measured price, not yet a result of the library"; planted faults refused (five at p = 3, one at p = 11 in 56.6 s); "The kernel's caches hash a `Nat` literal by its low 64 bits … one computation took 33 s against 1.25 s"; "**The p = 19 certificate does not run in the present form.** One segment of 32 was killed at its 12 GiB cap … Form F2 is priced at about 30 minutes of kernel CPU in about 40 declarations of at most 10 GB each … extrapolated … not run"; at 23 and 31 "rational cosine bounds … About 700–1,200 lines, kernel seconds"; the per-prime leaf planned, "no defect", the q ∈ {11, 19} branch "about 3,500–6,700 lines" (K1 generated checks, K2 the checker's soundness 2,000–4,000, K3 300–500, K4 with Lemma P 1,000–1,800 shared by every branch, K5 and glue). **My receipts:** the five commits exist; `Arith/FibreCert.lean` and `Arith/FibreCert3.lean` hold no `sorry`, `Arith/FibreCertSound.lean` two; from the tree's compiled library (scratch `kc13/Ax.lean`): `FibreCert.cert3_ok : certOK cert3 = true` — `[propext]`, a `decide +kernel` proof of the p = 3 certificate. **Rulings, four parts each.** (1) *p = 11's data and checks into the library now or with the landing:* with the landing, split into four identity segments under the build's 10 GB cap and measured there; alternative, now in two segments — declined, at 11–12 GB they exceed the build's cap, and nothing reads them until the soundness theorem is proved; high. (2) *p = 19 — form F2 now, or the smaller-relaxation search first:* F2 by the next implementer, and the search request queued for the Searcher (`plans/SEARCH-QUEUE.md` row 24) — if a smaller certificate arrives first, the implementer switches; alternative, wait for the search — declined, F2 is about 300 checker lines and 30 minutes of kernel time, affordable now, and the search's yes is not certain; medium-high — changed if the Searcher's run comes before F2's checker is written. (3) *The next job:* an implementer on this branch for K2 (the soundness, the critical part: a reference checker first, then the fast one shown to imply it, the record's mitigation), K1 at p = 11 in four segments, then F2 at p = 19; K3–K5 go to the chain's line after its join, Lemma P with them; alternative, K3–K5 first — declined, they read `Rigidity/ClassRatio`, which is on the chain's unjoined branch; high. **Correction owed, for the map and for Kooshi's next report:** M13's q ∈ {11, 19} branch alone is about 3,500–6,700 lines; the map's 2,500–5,000 for the whole of M13 did not include the checker's soundness. **Generalization, noted:** `sum_le_of_certOK` needs no primality and is stated for every p ≥ 2. **Filed:** its three dated lines in `data/fs131/claims-NF2.md` (each joined onto one line as the file holds them; words unchanged), and the search request as row 24 of `plans/SEARCH-QUEUE.md`, this commit. **Owed to the second filing:** four `LEAN.md` lines (§ The kernel's cost model: the low-64-bit literal hash, intermediates retained to the declaration's end, direct `Nat.*` calls and `Nat.rec` against notation and structural recursion, literal parse and size costs) and its bibliography lines, drafted in its record § 6.2–6.3. **Slips, the job's own, credited:** a `pgrep -f` pattern that matched its own shell (exit 144; nothing lost; then stopped by PID), and a 13 GiB request where 3 GiB served (resubmitted at 5).
> — source: plans/FS131-close-inventory.md

> 869. **FS131-IKC1 handed back at stage 7: the certificate checker strengthened, p = 11 passes it, the soundness proof's computation half proved, four leaves left (logged 2026-10-14 15:47 UTC; "JOB FS131-IKC1 — STAGE 7 SAVED"; 556k by the harness's count — past the line, not to be resumed; branch `fs131-wc14` at `45f0661c6`, tree `fs131-wnf`; record `plans/FS131-IKC1-implementation.md` there).** From its hand-back message: "the strengthened checker (`Arith/FibreCert`, rewritten) refuses that certificate. It also refuses one planted certificate for each of the other gaps: block size, monomial length, PSD digit bound … The unplanted partner `cert3_ok` still passes"; "FS-66's p = 11 certificate passes the strengthened checker in the kernel, in six declarations: about 320 s in all, at most 9.5 GB each … These were probe files run under the slot, not library modules yet"; "K2, the soundness proof, has a GAP at four typed leaves … L1 `psd_of_psdCheck` … L2 `blockT_nonneg` … L3 `opSum_O23_eq` … L4 `opSum_O4_eq`"; proved: "the computation half, `opSum_eq_zero`: an accepted certificate's ops sum to zero at the symmetrised moments", the left side, the rows, the assembly, `card_le_of_certOK` from `sum_le_of_certOK`; "`sum_le_of_certOK` and `card_le_of_certOK` print `[propext, sorryAx, Classical.choice, Quot.sound]`. Their stored statements … are byte-identical to the planner's"; K2 re-priced "about 1,550–2,000 lines … About 600 are done"; "F2 at p = 19 is not started". **My receipts:** the six commits exist; `data/fs131/ikc1/lean/controls/Drop3v2.lean` elaborated by me under the memory tool: `cert3drop_refused : certOK cert3drop = false := by decide +kernel` passes; from the tree's compiled library (scratch `kc13/Ax2.lean`): `FibreCertSound.sum_le_of_certOK` — `[propext, sorryAx, Classical.choice, Quot.sound]`, as reported (the four leaves). **Rulings, four parts.** (1) *p = 11's cut for the landing:* nseg = 8, measured, so each declaration fits a shared 10 GB build batch; the fallback `BATCH=1` for those modules alone if a segment still exceeds it; alternative, `BATCH=1` from the start — declined, it serializes the whole build's last stretch; medium — the measurement decides. (2) *The next job:* a fresh implementer on this branch for L1–L4, then the p = 11 library modules at nseg = 8, then F2 at p = 19 (FS131-IKC2, item 870); alternative, F2 first — declined, the soundness is what makes any accepted certificate mean something; high. **Corrections owed (to the second filing):** the planner's p = 11 figures (superseded: about 320 s, at most 9.5 GB, six declarations); its nseg = 4 estimate of 6–7 GB per segment (measured 7.1–9.5, a segment's fixed cost about 4.5 GB). **Generalization:** `sum_le_of_certOK` needs no primality (L2's route). **Slip, the job's own, credited:** several first probes killed at their caps (exit 143, `oom-kill` in the journal), each traced to its cause and re-run. **Filed:** a dated line in `data/fs131/claims-NF2.md` closing item 853's (the checker strengthened; its controls; p = 11 re-measured), this commit.
> — source: plans/FS131-close-inventory.md

> 886. **FS131-IKC2 handed back at stage 6: the class-ratio certificate checker proved sound (logged 2026-10-14 17:09 UTC; "JOB FS131-IKC2 — STAGE 6 SAVED"; 579k by the harness's count — past the line, not to be resumed; branch `fs131-wc15` at `1e0990dad`, tree `fs131-wnf`; record `plans/FS131-IKC2-implementation.md` there).** From its hand-back message: "TRUE — `HadwigerNelson.FibreCertSound.sum_le_of_certOK` is a kernel theorem … `[propext, Classical.choice, Quot.sound]`, printed from the built tree … if `certOK C = true`, then every `φ : (ℤ/p)² → [0,1]` with `q(φ) = 2Σφ(1−φ) − ΣΣ_{s∈S} φ_x φ_{x+s} ≥ 0` has `Σφ ≤ U_num/L`, for every `p` with `NeZero p`. Its stored statement is byte-identical to the one FS131-KC13 typed"; "`card_le_of_certOK` … an independent set of `Cay((ℤ/p)², S)` has at most `U_num/L` points"; the four leaves L1–L4 proved; "no change to `certOK`'s definition was made or needed"; "205 public records and 418 private theorems, every one a subset of the standard three"; "NOT REACHED — K1 at p = 11 … and F2 at p = 19"; K2 took "about 2,450 lines of proof in all"; "F2 changes `certOK` … That reopens K2's computation half … so F2 should be priced as a checker job plus a proof job". **My receipts:** the nine commits exist; from the tree's compiled library (scratch `kc13/Ax2.lean`, re-run against this build): `FibreCertSound.sum_le_of_certOK` — `[propext, Classical.choice, Quot.sound]` (item 883's receipt now complete). **So: an accepted certificate implies the class-ratio bound, a kernel theorem; with the p = 3 certificate's check (`cert3_ok`), the bound at p = 3 follows; p = 11 needs its library modules (K1), p = 19 a new checker form (F2).** **Rulings, four parts.** (1) *F2's reopening of the soundness:* priced as a checker job plus a proof job, after K1; and the Searcher's row 24 (a smaller relaxation at 19) moves up — a yes there would spare F2 entirely; medium-high. (2) *The next certificate job (K1 at p = 11):* queued; the chain's own work (the count's last leaf, M13's K3–K5 with Lemma P) takes this slot first, because it waits on nothing of this line and K1 is a generation-and-build job of minutes per module; medium — changed if the chain's join needs `cert11_ok` before K3–K5 are done. **Correction owed:** K2's price — about 2,450 lines against item 869's 1,550–2,000 (inside the planner's 2,000–4,000). **Generalization noted:** L1 reads `b.tri` exactly as decoded. **Filed:** its dated line in `data/fs131/claims-NF2.md` (joined onto one line), this commit.
> — source: plans/FS131-close-inventory.md

**Your work, in order.** (1) **K1 at p = 11** as library modules at eight segments (the first implementer's converter
`tools/fs131_ikc1_gen.py --nseg 8`), each declaration built under the slot and measured (`BATCH=1` for those modules alone
if a segment exceeds the build's 10 GB); `cert11_ok`; and the bound at p = 11 as a named public theorem from
`card_le_of_certOK` and `sum_le_of_certOK`. (2) **F2 at p = 19** (the planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/plans/FS131-KC13-certificates.md` § 3.2; the last implementer's
record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/plans/FS131-IKC2-implementation.md` § What is left): first the checker's new parts, each with a planted corrupted entry refused; then K2's
computation half (`sum_shadow`, `seg_shadow`) re-proved for the changed `certOK`; then the p = 19 modules built and
measured, `cert19_ok`, and the bound at p = 19. Row 24 of `plans/SEARCH-QUEUE.md` asks whether a smaller relaxation
clears 1/4 at p = 19; if its answer arrives first, I will tell you, and you switch.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; K1's and F2's steps restated beside
   their plans; the stored statements of the three `FibreCert` modules dumped from the built tree before any
   edit.
2. **K1** (a saved stage, and the one line to me when the bound at p = 11 prints the standard three); the per-declaration
   table of kernel time and peak memory.
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

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ikc3 -- <command>`

Ask for at most 12 GiB without telling me first, and for what a declaration needs, not more. The build: `--mem 10 --cpus
4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. The density equality's landing runs whole-library
gate steps of about 5.5 GiB and the density bound's covering builds cell modules of up to 1.8 GB each: on exit 75 wait
ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137 (read the system log for
"oom-kill"). Stop a process by its PID, never by matching its command line — a `pgrep -f` pattern matches the shell
running it. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/ikc3/`. Report at once any
disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
