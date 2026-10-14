# Brief FS131-IKC4 — the class-ratio certificates: the checker proved sound, p = 11 into the library, p = 19 in a form that fits

*Written 2026-10-14 19:30 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IKC4
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the fourth implementer of the class-ratio certificates for the five-colour chain — the checker is proved sound and the bound at p = 11 is in the library; you bring in the bound at p = 19 from the day's search's reduced certificate (30× fewer ops than FS-66's), through the present checker if it fits, segmented and measured, and through only those parts of form F2 that the measurement shows are needed, as far as you reach
  launch: now, in the third implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; three other jobs work in other trees (the density equality's landing, the density bound's covering, the chain's implementer) and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if the soundness theorem is false as typed or needs a hypothesis it lacks, if a kernel check needs more than 12 GiB or an hour, if K2's first two children price it above 4,000 lines, and with one line when `sum_le_of_certOK` prints the standard three and when p = 19's check passes; the report goes to `data/fs131/reports/FS131-IKC4.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IKC4-implementation.md` (new, on branch `fs131-wc17`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf` on a **new branch `fs131-wc17`** that you cut from its head (`fs131-wc16` at `af4eb1ab2`; its build is current for that commit): `Proofs/HadwigerNelson/Arith/FibreCertSound.lean` — proofs and private helpers, **the stored statements of `sum_le_of_certOK` and `card_le_of_certOK` unchanged** (F2's changes to `certOK` re-prove its computation half); `Proofs/HadwigerNelson/Arith/FibreCert.lean` — the checker, which you extend for F2's parts (per-segment op lists, tree literals, the cover bitmask); every change to `certOK`'s definition listed beside the proof step that needs it, and the counterexample controls of the first implementer still refused; `Proofs/HadwigerNelson/Arith/FibreCert3.lean`; new generated modules under `Proofs/HadwigerNelson/Arith/` for p = 11 and p = 19 (data and checks) with their lines in the build's lists and `ARCHITECTURE.md`; the converter `tools/fs131_kc13_gen.py` and your tools under `tools/` named for this job; `plans/FS131-IKC4-implementation.md`; `data/fs131/ikc4/`; `data/fs131/reports/FS131-IKC4.md`. **Not** `data/search/2026-10-14/` (read only), `data/fs66/` (read only), any other module, the chain's `Rigidity/ClassRatio` (on another branch; its leaves K3–K5 are a later job). Untracked files from the earlier jobs are in `data/fs131/kc13/`, `data/fs131/ikc1/`, `data/fs131/ikc2/` and `data/fs131/ikc3/`, and a generator summary beside `FibreCert3.lean`: leave them. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. At residue size 19 the class-ratio bound rested on a 10 MB certificate whose kernel check did not fit the present
checker. Today's search found one that is six times smaller — 30× fewer ops, the same block size — and FS-66's frozen
checker accepts it. The present checker is proved sound. You find out whether it carries the new certificate as it is.

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

The planner's hand-back, the last certificate implementer's and the day's search's, as I logged them (their words in
quotation marks, the rulings mine):

> 848. **FS131-KC13 handed back: the p = 11 class-ratio certificate checks in the kernel; p = 19 needs a new form; M13's per-prime leaf planned (logged 2026-10-14 13:44 UTC; "JOB FS131-KC13 — DONE"; 583k by the harness's count — past the line, not to be resumed; branch `fs131-wc13` at `7be9eef34`, tree `fs131-wnf`; record `plans/FS131-KC13-certificates.md` there).** From its hand-back message: "**The p = 11 certificate passes the kernel check.** Every part of `certOK` passes `decide +kernel` on the laptop, under the slot: 185 s of kernel time in all, at most 12.0 GB per declaration" (`segCheck cert11 0` 93.7 s / 12.0 GB, `segCheck cert11 1` 76.4 s / 11.0 GB, `psdAll cert11` 14.8 s / 2.9 GB); "What an accepted certificate means is `FibreCertSound.sum_le_of_certOK` … It is typed, but its proof is `sorry`. So this is a measured price, not yet a result of the library"; planted faults refused (five at p = 3, one at p = 11 in 56.6 s); "The kernel's caches hash a `Nat` literal by its low 64 bits … one computation took 33 s against 1.25 s"; "**The p = 19 certificate does not run in the present form.** One segment of 32 was killed at its 12 GiB cap … Form F2 is priced at about 30 minutes of kernel CPU in about 40 declarations of at most 10 GB each … extrapolated … not run"; at 23 and 31 "rational cosine bounds … About 700–1,200 lines, kernel seconds"; the per-prime leaf planned, "no defect", the q ∈ {11, 19} branch "about 3,500–6,700 lines" (K1 generated checks, K2 the checker's soundness 2,000–4,000, K3 300–500, K4 with Lemma P 1,000–1,800 shared by every branch, K5 and glue). **My receipts:** the five commits exist; `Arith/FibreCert.lean` and `Arith/FibreCert3.lean` hold no `sorry`, `Arith/FibreCertSound.lean` two; from the tree's compiled library (scratch `kc13/Ax.lean`): `FibreCert.cert3_ok : certOK cert3 = true` — `[propext]`, a `decide +kernel` proof of the p = 3 certificate. **Rulings, four parts each.** (1) *p = 11's data and checks into the library now or with the landing:* with the landing, split into four identity segments under the build's 10 GB cap and measured there; alternative, now in two segments — declined, at 11–12 GB they exceed the build's cap, and nothing reads them until the soundness theorem is proved; high. (2) *p = 19 — form F2 now, or the smaller-relaxation search first:* F2 by the next implementer, and the search request queued for the Searcher (`plans/SEARCH-QUEUE.md` row 24) — if a smaller certificate arrives first, the implementer switches; alternative, wait for the search — declined, F2 is about 300 checker lines and 30 minutes of kernel time, affordable now, and the search's yes is not certain; medium-high — changed if the Searcher's run comes before F2's checker is written. (3) *The next job:* an implementer on this branch for K2 (the soundness, the critical part: a reference checker first, then the fast one shown to imply it, the record's mitigation), K1 at p = 11 in four segments, then F2 at p = 19; K3–K5 go to the chain's line after its join, Lemma P with them; alternative, K3–K5 first — declined, they read `Rigidity/ClassRatio`, which is on the chain's unjoined branch; high. **Correction owed, for the map and for Kooshi's next report:** M13's q ∈ {11, 19} branch alone is about 3,500–6,700 lines; the map's 2,500–5,000 for the whole of M13 did not include the checker's soundness. **Generalization, noted:** `sum_le_of_certOK` needs no primality and is stated for every p ≥ 2. **Filed:** its three dated lines in `data/fs131/claims-NF2.md` (each joined onto one line as the file holds them; words unchanged), and the search request as row 24 of `plans/SEARCH-QUEUE.md`, this commit. **Owed to the second filing:** four `LEAN.md` lines (§ The kernel's cost model: the low-64-bit literal hash, intermediates retained to the declaration's end, direct `Nat.*` calls and `Nat.rec` against notation and structural recursion, literal parse and size costs) and its bibliography lines, drafted in its record § 6.2–6.3. **Slips, the job's own, credited:** a `pgrep -f` pattern that matched its own shell (exit 144; nothing lost; then stopped by PID), and a 13 GiB request where 3 GiB served (resubmitted at 5).
> — source: plans/FS131-close-inventory.md

> 902. **FS131-IKC3 handed back at stage 4: p = 11 in the library; F2 at p = 19 designed and probed, not built (logged 2026-10-14 18:46 UTC; "JOB FS131-IKC3 — STAGE 4 SAVED"; branch `fs131-wc16` at `af4eb1ab2`, tree `fs131-wnf`; record `plans/FS131-IKC3-implementation.md` there).** From its hand-back message: "`HadwigerNelson.FibreCert.cert11_ok : certOK cert11 = true` … `[propext, Quot.sound]` … ten `decide +kernel` declarations"; "`sum_le_eleven` … Σφ ≤ 28204320001863099628721379861820 / 10^30 = 28.2043…"; "`card_le_eleven` … an independent set of Cay((ℤ/11)², {a² + b² = 1}) has at most that many points (U/(121·L) = 0.2331…; the comparison with 1/4 is K5's job"; `model_eleven`; "No conclusion weakened … `certOK` is unchanged"; "F2 at p = 19: NOT BUILT" — PSD per block measured (45–62 s, 5.3–5.9 GB), the K table and phase 1's cut probed with planted faults refused, the scatter designed; "the p = 19 data in this encoding … is 96.0 MB of text … F2's K table adds 17.4 MB"; "F2's price is about 40–50 minutes of kernel CPU in 45–60 declarations … about 300 checker lines, 350 converter lines and 800–1,100 proof lines"; "F2 changes `Cert` and `certOK`. So the p = 11 modules landed here have to be regenerated"; a 2^40 witness scale halves the witness text; the converter's summary file lands inside `Proofs/` (a tool defect); about 335 MB of untracked probe data. **My receipts:** item 899 (`card_le_eleven` on the standard three, its statement printed). **Rulings, four parts.** (1) *F2's next step:* the Searcher first, on row 24 (a smaller relaxation at p = 19 that still clears 1/4): a yes shrinks the 110 MB of generated text and the 40–50 minutes of kernel time, and perhaps spares the checker change and its re-proof altogether; alternative, an F2 implementer now — declined while the cheaper answer is one search away; medium-high — changed if the Searcher's run finds no smaller relaxation, when F2 goes to an implementer on this design. (2) *About 110 MB of generated text in git:* not decided now — the size matters for the public push of W6, and it depends on the Searcher's answer; if F2 goes ahead, its implementer takes the 2^40 scale (−25 MB, converter only) and per-block modules each well under GitHub's 100 MB per-file limit, and the total goes to Kooshi with the publication pass; medium. (3) *The chained check modules:* kept as the pattern for heavy certificate modules; a per-module batch option for `build.sh` to the tooling list. (4) *The 335 MB of probe data:* kept until F2's form is decided, then deleted with the tree's cleanup (disk 318 GB free). **Corrections owed:** F2's price (40–50 minutes, not the planner's 30); the converter's summary-file location (tooling list). **The slot:** the Searcher (FS131-S1014), item 903.
> — source: plans/FS131-close-inventory.md

> 908. **SEARCH-2026-10-14 handed back: smaller certificates at both residue sizes (logged 2026-10-14 19:29 UTC; "JOB SEARCH-2026-10-14 — DONE"; 170k by the harness's count; record `plans/SEARCH-2026-10-14.md`).** From its hand-back message: "yes, a smaller relaxation still gets below a quarter at both residue sizes, and FS-66's frozen checker accepts both new certificates. But the frozen format fixes every block at 183 rows (63 at p = 11). So the large positive-definite (PSD) witnesses and the K table do not shrink"; p = 19: "U = 88.643400…, below 90.25 by 1.607 … `--m 4`: [cert] CERTIFIED, exit 0, 4 min 57 s, 3.1 GB … A copy with U_num − 1: REFUSED"; p = 11: "U = 30.077390…, below 30.25 by 0.173 … CERTIFIED"; ops 602,989 → 20,274 at 19; "level one (basis φ_0 alone) fails at both"; readings for the deriver (one distance class alone suffices at 11; five single classes clear 1/4 at 19; "The unit pairs, N(2h) = 1, add nothing at 7, 11 or 19"); a correction owed (row 24 quotes a paraphrase); two slips of its own (an exit-line wrapper; a log-name bug), nothing lost. **My receipts:** the five commits exist; both certificate files are on `main` (above). **Rulings, four parts.** (1) *Filing the certificates:* they stay where they are, `data/search/2026-10-14/certs/`, read by address by the kernel lane — `data/fs66/b1/` is FS-66's frozen record; alternative, copy them there — declined, a second home for one file; high. (2) *The p = 19 leaf:* switched to the reduced certificate, through the present checker first (item 907's ruling); the p = 11 leaf stays on FS-66's certificate (already checked; its margin 2.05 against the reduced one's 0.173); high. (3) *The readings for the deriver* (single distance classes suffice): filed here as an observation [measured, float] for any later write-up; no job now. **Filed:** row 24's fate in `plans/SEARCH-QUEUE.md`, with the paraphrase noted, this commit. **Slips, the job's own, credited.**
> — source: plans/FS131-close-inventory.md

**Your work, in order.** (1) **The reduced certificate through the present checker**: the converter
(`tools/fs131_ikc1_gen.py`) on `data/search/2026-10-14/certs/v-p19-phi0-13-qs.json` (the search's record `/home/kooshi/source/lean-dir/plans/SEARCH-2026-10-14.md` § 4), segmented as p = 11 was; measure the K table's
declaration first (it alone exceeded 12 GiB at FS-66's certificate) and the PSD blocks (45–62 s each, item 908's record).
(2) **Only what the measurement shows is needed of F2**: if the K table still exceeds the cap, its checked-literal form
(the last implementer's probe (b), with `ktable_eq_of_chk` proved) — a change to `certOK` that reopens the computation half
for that part only; the 2^40 witness scale (converter only); per-block modules each well under 100 MB of text. (3)
`cert19_ok` and the bound at p = 19 (`sum_le_nineteen`, `card_le_nineteen` or your names), and the comparison with 1/4.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; K1's and F2's steps restated beside
   their plans; the stored statements of the three `FibreCert` modules dumped from the built tree before any
   edit.
2. **The measurement** (a saved stage): the K table's and each segment's kernel time and peak memory under the present
   checker, and the decision it forces, in a table.
3. **The bound at p = 19** (a saved stage, and the one line to me when it prints the standard three): `cert19_ok`, the
   bound and its comparison with 1/4, each declaration's kernel time and peak memory in a table.
4. **Any part of F2 built** (saved stages): a planted corrupted entry watched being refused in each new part, and the
   soundness proof's reopened part re-proved.
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

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ikc4 -- <command>`

Ask for at most 12 GiB without telling me first, and for what a declaration needs, not more. The build: `--mem 10 --cpus
4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. The density equality's landing runs whole-library
gate steps of about 5.5 GiB and the density bound's covering builds cell modules of up to 1.8 GB each: on exit 75 wait
ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137 (read the system log for
"oom-kill"). Stop a process by its PID, never by matching its command line — a `pgrep -f` pattern matches the shell
running it. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/ikc4/`. Report at once any
disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
