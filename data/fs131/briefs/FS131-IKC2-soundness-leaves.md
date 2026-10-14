# Brief FS131-IKC2 — the class-ratio certificates: the checker proved sound, p = 11 into the library, p = 19 in a form that fits

*Written 2026-10-14 15:50 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IKC2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the second implementer of the class-ratio certificates for the five-colour chain — first the four leaves left in the soundness theorem of the strengthened certificate checker (positive definiteness from the PSD check, the blocks' nonnegativity, two op-sum identities), so that an accepted certificate implies the class-ratio bound on FS-66's region; then the p = 11 certificate's data and kernel checks as library modules at eight segments; then the p = 19 certificate in the form its planner priced, as far as you reach
  launch: now, in the first implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; three other jobs work in other trees (the density equality's landing, the density bound's covering, the chain's implementer) and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if the soundness theorem is false as typed or needs a hypothesis it lacks, if a kernel check needs more than 12 GiB or an hour, if K2's first two children price it above 4,000 lines, and with one line when `sum_le_of_certOK` prints the standard three and when p = 19's check passes; the report goes to `data/fs131/reports/FS131-IKC2.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IKC2-implementation.md` (new, on branch `fs131-wc15`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf` on a **new branch `fs131-wc15`** that you cut from its head (`fs131-wc14` at `45f0661c6`; its build is current for that commit): `Proofs/HadwigerNelson/Arith/FibreCertSound.lean` — proofs and private helpers, **the conclusions of `sum_le_of_certOK` and `card_le_of_certOK` unchanged**; `Proofs/HadwigerNelson/Arith/FibreCert.lean` — the strengthened checker, which you may extend for F2's parts; any change to `certOK`'s definition only adds checks, each listed beside the proof step that needs it; `Proofs/HadwigerNelson/Arith/FibreCert3.lean`; new generated modules under `Proofs/HadwigerNelson/Arith/` for p = 11 and p = 19 (data and checks) with their lines in the build's lists and `ARCHITECTURE.md`; the converter `tools/fs131_kc13_gen.py` and your tools under `tools/` named for this job; `plans/FS131-IKC2-implementation.md`; `data/fs131/ikc2/`; `data/fs131/reports/FS131-IKC2.md`. **Not** `data/fs66/` (read only), any other module, the chain's `Rigidity/ClassRatio` (on another branch; its leaves K3–K5 are a later job). Untracked files from the planner and the first implementer are in `data/fs131/kc13/` and `data/fs131/ikc1/`, and a generator summary beside `FibreCert3.lean`: leave them. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. The first implementer of this checker found it unsound — a certificate it accepted proved a false bound —
strengthened it so that the kernel refuses that certificate and one planted for each gap of the same kind, checked FS-66's
p = 11 certificate against the strengthened checker in about five minutes, and proved the computation half of the
soundness theorem. Four leaves are left; then the certificates come into the library.

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

The planner's hand-back, the counterexample and the first implementer's hand-back, as I logged them (their words in
quotation marks, the rulings mine):

> 848. **FS131-KC13 handed back: the p = 11 class-ratio certificate checks in the kernel; p = 19 needs a new form; M13's per-prime leaf planned (logged 2026-10-14 13:44 UTC; "JOB FS131-KC13 — DONE"; 583k by the harness's count — past the line, not to be resumed; branch `fs131-wc13` at `7be9eef34`, tree `fs131-wnf`; record `plans/FS131-KC13-certificates.md` there).** From its hand-back message: "**The p = 11 certificate passes the kernel check.** Every part of `certOK` passes `decide +kernel` on the laptop, under the slot: 185 s of kernel time in all, at most 12.0 GB per declaration" (`segCheck cert11 0` 93.7 s / 12.0 GB, `segCheck cert11 1` 76.4 s / 11.0 GB, `psdAll cert11` 14.8 s / 2.9 GB); "What an accepted certificate means is `FibreCertSound.sum_le_of_certOK` … It is typed, but its proof is `sorry`. So this is a measured price, not yet a result of the library"; planted faults refused (five at p = 3, one at p = 11 in 56.6 s); "The kernel's caches hash a `Nat` literal by its low 64 bits … one computation took 33 s against 1.25 s"; "**The p = 19 certificate does not run in the present form.** One segment of 32 was killed at its 12 GiB cap … Form F2 is priced at about 30 minutes of kernel CPU in about 40 declarations of at most 10 GB each … extrapolated … not run"; at 23 and 31 "rational cosine bounds … About 700–1,200 lines, kernel seconds"; the per-prime leaf planned, "no defect", the q ∈ {11, 19} branch "about 3,500–6,700 lines" (K1 generated checks, K2 the checker's soundness 2,000–4,000, K3 300–500, K4 with Lemma P 1,000–1,800 shared by every branch, K5 and glue). **My receipts:** the five commits exist; `Arith/FibreCert.lean` and `Arith/FibreCert3.lean` hold no `sorry`, `Arith/FibreCertSound.lean` two; from the tree's compiled library (scratch `kc13/Ax.lean`): `FibreCert.cert3_ok : certOK cert3 = true` — `[propext]`, a `decide +kernel` proof of the p = 3 certificate. **Rulings, four parts each.** (1) *p = 11's data and checks into the library now or with the landing:* with the landing, split into four identity segments under the build's 10 GB cap and measured there; alternative, now in two segments — declined, at 11–12 GB they exceed the build's cap, and nothing reads them until the soundness theorem is proved; high. (2) *p = 19 — form F2 now, or the smaller-relaxation search first:* F2 by the next implementer, and the search request queued for the Searcher (`plans/SEARCH-QUEUE.md` row 24) — if a smaller certificate arrives first, the implementer switches; alternative, wait for the search — declined, F2 is about 300 checker lines and 30 minutes of kernel time, affordable now, and the search's yes is not certain; medium-high — changed if the Searcher's run comes before F2's checker is written. (3) *The next job:* an implementer on this branch for K2 (the soundness, the critical part: a reference checker first, then the fast one shown to imply it, the record's mitigation), K1 at p = 11 in four segments, then F2 at p = 19; K3–K5 go to the chain's line after its join, Lemma P with them; alternative, K3–K5 first — declined, they read `Rigidity/ClassRatio`, which is on the chain's unjoined branch; high. **Correction owed, for the map and for Kooshi's next report:** M13's q ∈ {11, 19} branch alone is about 3,500–6,700 lines; the map's 2,500–5,000 for the whole of M13 did not include the checker's soundness. **Generalization, noted:** `sum_le_of_certOK` needs no primality and is stated for every p ≥ 2. **Filed:** its three dated lines in `data/fs131/claims-NF2.md` (each joined onto one line as the file holds them; words unchanged), and the search request as row 24 of `plans/SEARCH-QUEUE.md`, this commit. **Owed to the second filing:** four `LEAN.md` lines (§ The kernel's cost model: the low-64-bit literal hash, intermediates retained to the declaration's end, direct `Nat.*` calls and `Nat.rec` against notation and structural recursion, literal parse and size costs) and its bibliography lines, drafted in its record § 6.2–6.3. **Slips, the job's own, credited:** a `pgrep -f` pattern that matched its own shell (exit 144; nothing lost; then stopped by PID), and a 13 GiB request where 3 GiB served (resubmitted at 5).
> — source: plans/FS131-close-inventory.md

> 853. **FS131-IKC1 — the certificate checker as typed is unsound: a kernel counterexample to `sum_le_of_certOK`; ruled (notice, 2026-10-14 13:59 UTC; by message).** From its message: "`sum_le_of_certOK` is FALSE as typed over FS131-KC13's `certOK`, and the kernel has checked a counterexample. The certificate `cert3drop` is `cert3` with U_num = 0, and the stream entries of the two ops of the constant class point at slot 64, which no segment owns (nseg = 1). `segAll` checks only segments < nseg and nothing checks that every op's slot lands in one. The kernel proves `certOK cert3drop = true` (decide +kernel) and then `not_sum_le_of_certOK` … with φ the indicator of the origin (q = 0, Σφ = 1 > 0). Axioms: the standard three"; three more gaps "of the same kind, none of them refuted concretely yet": (a) no check that a block's size matches its reps list, so "the matrix checked PSD need not be the matrix used in the identity"; (b) nothing bounds the reps or orbit lists' lengths, which key injectivity needs; (c) the PSD check's digit and column bounds unchecked; "My remedy … add these checks to `certOK`. Adding checks only shrinks the set of certificates accepted and leaves the theorems' conclusions as they are." **My receipt:** `fs131-wnf:data/fs131/ikc1/lean/controls/Drop3.lean` (branch `fs131-wc14`) elaborated by me under the memory tool against its built tree: `FibreCertSound.not_sum_le_of_certOK : ¬ ∀ (C : Cert) [NeZero C.p], certOK C = true → ∀ φ : V C.p → ℝ, (∀ x, 0 ≤ φ x) → (∀ x, φ x ≤ 1) → 0 ≤ qform C.p φ → ∑ x, φ x ≤ (C.unum : ℝ) / C.scale` — `[propext, Classical.choice, Quot.sound]`. **What this changes:** item 848's "the p = 11 certificate passes the kernel check" stands as a computation (`certOK cert11 = true`), but until the checker is sound an accepted certificate implied nothing, and the planner's 185 s / 12.0 GB were measured under the unsound checker. **Ruling, four parts:** strengthen `certOK` (every op's slot in a checked segment; block sizes matched to their reps; list lengths bounded; the PSD check's digit and column bounds checked), the soundness theorems' conclusions unchanged and shown so from the kernel's dump; `Drop3` kept as a negative control the new checker must refuse in the kernel, a planted certificate for each of (a)–(c) refused with its unplanted partner accepted; p = 3 and p = 11 re-checked and re-measured; each added check listed beside the proof step that needs it; alternative, weaken the theorem to the checker as it stands — declined, that theorem is not the class-ratio bound the chain reads; high. Sent by one message. **Statement defect, the planner's (FS131-KC13), credited to FS131-IKC1:** a checker whose acceptance does not imply its typed soundness theorem — exactly what K2's soundness proof exists to catch. **Filed:** a dated line in `data/fs131/claims-NF2.md`, this commit.
> — source: plans/FS131-close-inventory.md

> 869. **FS131-IKC1 handed back at stage 7: the certificate checker strengthened, p = 11 passes it, the soundness proof's computation half proved, four leaves left (logged 2026-10-14 15:47 UTC; "JOB FS131-IKC1 — STAGE 7 SAVED"; 556k by the harness's count — past the line, not to be resumed; branch `fs131-wc14` at `45f0661c6`, tree `fs131-wnf`; record `plans/FS131-IKC1-implementation.md` there).** From its hand-back message: "the strengthened checker (`Arith/FibreCert`, rewritten) refuses that certificate. It also refuses one planted certificate for each of the other gaps: block size, monomial length, PSD digit bound … The unplanted partner `cert3_ok` still passes"; "FS-66's p = 11 certificate passes the strengthened checker in the kernel, in six declarations: about 320 s in all, at most 9.5 GB each … These were probe files run under the slot, not library modules yet"; "K2, the soundness proof, has a GAP at four typed leaves … L1 `psd_of_psdCheck` … L2 `blockT_nonneg` … L3 `opSum_O23_eq` … L4 `opSum_O4_eq`"; proved: "the computation half, `opSum_eq_zero`: an accepted certificate's ops sum to zero at the symmetrised moments", the left side, the rows, the assembly, `card_le_of_certOK` from `sum_le_of_certOK`; "`sum_le_of_certOK` and `card_le_of_certOK` print `[propext, sorryAx, Classical.choice, Quot.sound]`. Their stored statements … are byte-identical to the planner's"; K2 re-priced "about 1,550–2,000 lines … About 600 are done"; "F2 at p = 19 is not started". **My receipts:** the six commits exist; `data/fs131/ikc1/lean/controls/Drop3v2.lean` elaborated by me under the memory tool: `cert3drop_refused : certOK cert3drop = false := by decide +kernel` passes; from the tree's compiled library (scratch `kc13/Ax2.lean`): `FibreCertSound.sum_le_of_certOK` — `[propext, sorryAx, Classical.choice, Quot.sound]`, as reported (the four leaves). **Rulings, four parts.** (1) *p = 11's cut for the landing:* nseg = 8, measured, so each declaration fits a shared 10 GB build batch; the fallback `BATCH=1` for those modules alone if a segment still exceeds it; alternative, `BATCH=1` from the start — declined, it serializes the whole build's last stretch; medium — the measurement decides. (2) *The next job:* a fresh implementer on this branch for L1–L4, then the p = 11 library modules at nseg = 8, then F2 at p = 19 (FS131-IKC2, item 870); alternative, F2 first — declined, the soundness is what makes any accepted certificate mean something; high. **Corrections owed (to the second filing):** the planner's p = 11 figures (superseded: about 320 s, at most 9.5 GB, six declarations); its nseg = 4 estimate of 6–7 GB per segment (measured 7.1–9.5, a segment's fixed cost about 4.5 GB). **Generalization:** `sum_le_of_certOK` needs no primality (L2's route). **Slip, the job's own, credited:** several first probes killed at their caps (exit 143, `oom-kill` in the journal), each traced to its cause and re-run. **Filed:** a dated line in `data/fs131/claims-NF2.md` closing item 853's (the checker strengthened; its controls; p = 11 re-measured), this commit.
> — source: plans/FS131-close-inventory.md

**Your work, in order.** (1) **K2's four leaves** in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/Proofs/HadwigerNelson/Arith/FibreCertSound.lean` — `psd_of_psdCheck`, `blockT_nonneg`,
`opSum_O23_eq`, `opSum_O4_eq` — each with its route in the first implementer's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/plans/FS131-IKC1-implementation.md` (§ Stage 4, § Stage 5) and
priced there at 250–350, 200–300, 350–500 and 150–250 lines; the planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/plans/FS131-KC13-certificates.md` § 5.2 (K2's table) behind them.
(2) **K1 at p = 11** as library modules at eight segments (ruling 1 of the hand-back above), each built under the slot
and measured; `BATCH=1` for those modules alone if a segment exceeds the build's 10 GB; `cert11_ok`, and the bound at
p = 11 from `sum_le_of_certOK`. (3) **F2 at p = 19** (the planner's record § 3.2), its parts measured, a planted
corrupted entry refused in each new part. Row 24 of `plans/SEARCH-QUEUE.md` asks the Searcher whether a smaller
relaxation clears 1/4; if its answer arrives first, I will tell you, and you switch.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the four leaves restated in one line
   each beside their route; the stored statements of the three `FibreCert` modules dumped from the built tree before any
   edit.
2. **K2's four leaves** (saved stages as they fall, and the one line to me when `sum_le_of_certOK` prints the standard
   three); re-price what is left from the first two and say so.
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

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ikc2 -- <command>`

Ask for at most 12 GiB without telling me first, and for what a declaration needs, not more. The build: `--mem 10 --cpus
4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. The density equality's landing runs whole-library
gate steps of about 5.5 GiB and the density bound's covering builds cell modules of up to 1.8 GB each: on exit 75 wait
ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137 (read the system log for
"oom-kill"). Stop a process by its PID, never by matching its command line — a `pgrep -f` pattern matches the shell
running it. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/ikc2/`. Report at once any
disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
