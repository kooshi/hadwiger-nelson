# Brief FS131-IKL1 — the five-colour chain: the certificate link at residue sizes 11 and 19

*Written 2026-10-14 21:25 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IKL1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the implementer of the link between the class-ratio certificates and M13 — the certificate planner's leaves K3 (the level-one target at an inert stable prime of residue size `q²`, `q` prime, as the Cayley graph of `(ℤ/q)²` on the unit circle), K4 (a set with no two adjacent points, at every level, gives fibre shares `φ ∈ [0,1]^V` with `q(φ) ≥ 0` and `|I| = q^{2(m−1)}·Σφ`) and K5 (the comparison with 1/4) — composed into the statement M13's private leaf `ratioAtMost_cert` asks for, at `q = 11` from the proved bound, and at `q = 19` over the bound at 19 as a named hypothesis
  launch: now, in a finished tree on a new branch cut from M13's line, with the class-ratio certificates' line merged in; three other jobs work in other trees and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if the link needs a private lemma of `Rigidity/ClassRatio` or of the certificate modules made public, if the first leaves price the link above 2,500 lines, and with one line when the `q = 11` case prints with no `sorryAx`; the report goes to `data/fs131/reports/FS131-IKL1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IKL1-implementation.md` (new, on branch `fs131-wkl`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1` (on `fs131-wla`, clean; its compiled library is that branch's) on a **new branch `fs131-wkl`** that you cut from M13's line (`git checkout -b fs131-wkl fs131-wcm3`, at `c0b6798ed`) and into which you merge the certificates' line (`git merge --no-ff fs131-wc16`, at `af4eb1ab2`; `git merge-tree` reports a conflict in `ARCHITECTURE.md` only — keep both sides): new modules for the link (under `Proofs/HadwigerNelson/Rigidity/` or `Proofs/HadwigerNelson/Arith/`, yours to name) with their lines in the build's lists and `ARCHITECTURE.md`; your checks under `tools/` named for this job; `plans/FS131-IKL1-implementation.md`; `data/fs131/ikl1/`; `data/fs131/reports/FS131-IKL1.md`. **Not** `Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` (M13's, written now on another branch by FS131-ICM4), any `Arith/FibreCert*` module (the certificates' line, written now by FS131-IKC4), any other existing module's file, any module under `Outside/`, the declared `StandingFive.kloosterman_bound`. Nothing on `main`; no push
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage; save a stage (a commit on your branch) after the readback, after the merge builds, and as leaves fall

Hello. The five-colour chain's class-ratio step is proved but for one private leaf at residue sizes 11 and 19, and the
certificate that settles those sizes is checked by the kernel at 11 (the bound at 19 is being brought in now). Nothing
yet connects the two: the certificate speaks of a quadratic form on `(ℤ/q)²`, the leaf of the plane's finite targets at
a prime of a number field, at every level. You build that connection.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The gate takes no `sorry`, so the chain cannot land on `main` until `ratioAtMost_cert` is proved.

## The statements

The dated line of the chain's claim list (`data/fs131/claims-NF2.md`) that says what the checker holds:

> - 2026-10-14 — **The class-ratio checker is proved sound** (FS131-IKC2): `FibreCertSound.sum_le_of_certOK` and `card_le_of_certOK` are kernel theorems on the standard three, their stored statements unchanged since FS131-KC13 typed them; `certOK`'s definition unchanged since FS131-IKC1 strengthened it. An accepted certificate now implies `Σφ ≤ U_num/L` on FS-66's region at its `p`. The p = 11 certificate's library modules (K1) and p = 19's form F2 are not yet built.
> — source: data/fs131/claims-NF2.md § Dated lines

The certificate planner's, the last certificate implementer's and M13's last implementer's hand-backs, as I logged them
(their words in quotation marks, the rulings mine):

> 848. **FS131-KC13 handed back: the p = 11 class-ratio certificate checks in the kernel; p = 19 needs a new form; M13's per-prime leaf planned (logged 2026-10-14 13:44 UTC; "JOB FS131-KC13 — DONE"; 583k by the harness's count — past the line, not to be resumed; branch `fs131-wc13` at `7be9eef34`, tree `fs131-wnf`; record `plans/FS131-KC13-certificates.md` there).** From its hand-back message: "**The p = 11 certificate passes the kernel check.** Every part of `certOK` passes `decide +kernel` on the laptop, under the slot: 185 s of kernel time in all, at most 12.0 GB per declaration" (`segCheck cert11 0` 93.7 s / 12.0 GB, `segCheck cert11 1` 76.4 s / 11.0 GB, `psdAll cert11` 14.8 s / 2.9 GB); "What an accepted certificate means is `FibreCertSound.sum_le_of_certOK` … It is typed, but its proof is `sorry`. So this is a measured price, not yet a result of the library"; planted faults refused (five at p = 3, one at p = 11 in 56.6 s); "The kernel's caches hash a `Nat` literal by its low 64 bits … one computation took 33 s against 1.25 s"; "**The p = 19 certificate does not run in the present form.** One segment of 32 was killed at its 12 GiB cap … Form F2 is priced at about 30 minutes of kernel CPU in about 40 declarations of at most 10 GB each … extrapolated … not run"; at 23 and 31 "rational cosine bounds … About 700–1,200 lines, kernel seconds"; the per-prime leaf planned, "no defect", the q ∈ {11, 19} branch "about 3,500–6,700 lines" (K1 generated checks, K2 the checker's soundness 2,000–4,000, K3 300–500, K4 with Lemma P 1,000–1,800 shared by every branch, K5 and glue). **My receipts:** the five commits exist; `Arith/FibreCert.lean` and `Arith/FibreCert3.lean` hold no `sorry`, `Arith/FibreCertSound.lean` two; from the tree's compiled library (scratch `kc13/Ax.lean`): `FibreCert.cert3_ok : certOK cert3 = true` — `[propext]`, a `decide +kernel` proof of the p = 3 certificate. **Rulings, four parts each.** (1) *p = 11's data and checks into the library now or with the landing:* with the landing, split into four identity segments under the build's 10 GB cap and measured there; alternative, now in two segments — declined, at 11–12 GB they exceed the build's cap, and nothing reads them until the soundness theorem is proved; high. (2) *p = 19 — form F2 now, or the smaller-relaxation search first:* F2 by the next implementer, and the search request queued for the Searcher (`plans/SEARCH-QUEUE.md` row 24) — if a smaller certificate arrives first, the implementer switches; alternative, wait for the search — declined, F2 is about 300 checker lines and 30 minutes of kernel time, affordable now, and the search's yes is not certain; medium-high — changed if the Searcher's run comes before F2's checker is written. (3) *The next job:* an implementer on this branch for K2 (the soundness, the critical part: a reference checker first, then the fast one shown to imply it, the record's mitigation), K1 at p = 11 in four segments, then F2 at p = 19; K3–K5 go to the chain's line after its join, Lemma P with them; alternative, K3–K5 first — declined, they read `Rigidity/ClassRatio`, which is on the chain's unjoined branch; high. **Correction owed, for the map and for Kooshi's next report:** M13's q ∈ {11, 19} branch alone is about 3,500–6,700 lines; the map's 2,500–5,000 for the whole of M13 did not include the checker's soundness. **Generalization, noted:** `sum_le_of_certOK` needs no primality and is stated for every p ≥ 2. **Filed:** its three dated lines in `data/fs131/claims-NF2.md` (each joined onto one line as the file holds them; words unchanged), and the search request as row 24 of `plans/SEARCH-QUEUE.md`, this commit. **Owed to the second filing:** four `LEAN.md` lines (§ The kernel's cost model: the low-64-bit literal hash, intermediates retained to the declaration's end, direct `Nat.*` calls and `Nat.rec` against notation and structural recursion, literal parse and size costs) and its bibliography lines, drafted in its record § 6.2–6.3. **Slips, the job's own, credited:** a `pgrep -f` pattern that matched its own shell (exit 144; nothing lost; then stopped by PID), and a 13 GiB request where 3 GiB served (resubmitted at 5).
> — source: plans/FS131-close-inventory.md

> 902. **FS131-IKC3 handed back at stage 4: p = 11 in the library; F2 at p = 19 designed and probed, not built (logged 2026-10-14 18:46 UTC; "JOB FS131-IKC3 — STAGE 4 SAVED"; branch `fs131-wc16` at `af4eb1ab2`, tree `fs131-wnf`; record `plans/FS131-IKC3-implementation.md` there).** From its hand-back message: "`HadwigerNelson.FibreCert.cert11_ok : certOK cert11 = true` … `[propext, Quot.sound]` … ten `decide +kernel` declarations"; "`sum_le_eleven` … Σφ ≤ 28204320001863099628721379861820 / 10^30 = 28.2043…"; "`card_le_eleven` … an independent set of Cay((ℤ/11)², {a² + b² = 1}) has at most that many points (U/(121·L) = 0.2331…; the comparison with 1/4 is K5's job"; `model_eleven`; "No conclusion weakened … `certOK` is unchanged"; "F2 at p = 19: NOT BUILT" — PSD per block measured (45–62 s, 5.3–5.9 GB), the K table and phase 1's cut probed with planted faults refused, the scatter designed; "the p = 19 data in this encoding … is 96.0 MB of text … F2's K table adds 17.4 MB"; "F2's price is about 40–50 minutes of kernel CPU in 45–60 declarations … about 300 checker lines, 350 converter lines and 800–1,100 proof lines"; "F2 changes `Cert` and `certOK`. So the p = 11 modules landed here have to be regenerated"; a 2^40 witness scale halves the witness text; the converter's summary file lands inside `Proofs/` (a tool defect); about 335 MB of untracked probe data. **My receipts:** item 899 (`card_le_eleven` on the standard three, its statement printed). **Rulings, four parts.** (1) *F2's next step:* the Searcher first, on row 24 (a smaller relaxation at p = 19 that still clears 1/4): a yes shrinks the 110 MB of generated text and the 40–50 minutes of kernel time, and perhaps spares the checker change and its re-proof altogether; alternative, an F2 implementer now — declined while the cheaper answer is one search away; medium-high — changed if the Searcher's run finds no smaller relaxation, when F2 goes to an implementer on this design. (2) *About 110 MB of generated text in git:* not decided now — the size matters for the public push of W6, and it depends on the Searcher's answer; if F2 goes ahead, its implementer takes the 2^40 scale (−25 MB, converter only) and per-block modules each well under GitHub's 100 MB per-file limit, and the total goes to Kooshi with the publication pass; medium. (3) *The chained check modules:* kept as the pattern for heavy certificate modules; a per-module batch option for `build.sh` to the tooling list. (4) *The 335 MB of probe data:* kept until F2's form is decided, then deleted with the tree's cleanup (disk 318 GB free). **Corrections owed:** F2's price (40–50 minutes, not the planner's 30); the converter's summary-file location (tooling list). **The slot:** the Searcher (FS131-S1014), item 903.
> — source: plans/FS131-close-inventory.md

> 922. **FS131-ICM3 handed back at stage 5: the exact spectra at 23, 27 and 31 proved, the dyadic branch down to two certificate children, the amendment done (logged 2026-10-14 20:52 UTC; "JOB FS131-ICM3 — STAGE 5 SAVED"; 548k by the harness's count; branch `fs131-wcm3` at `c0b6798ed`, tree `fs131-wch`; record `plans/FS131-ICM3-implementation.md` there).** From its hand-back message: "**TRUE — `circleCos_bound`**, proved through a new public module, `Arith/CircleCos` (297 lines)", margins "49141/1250000 (3.9·10⁻²) at 23, and 46847/300000000 (1.6·10⁻⁴) at 31", the control failing at 11 and 19; "**TRUE — `charBound_one_exact_27`** (private), [kernel] on the standard three and `StandingFive.kloosterman_bound`. I used another route" (Weil and the parity of `N₀`, `Re Σ ≥ −8`; "This proves the bound λ_min ≥ −8, not FS100-G27's equality"); "**TRUE — Lemma P with no unit 2**" (`SqZeroInvT`, `charBound_of_charBound_oneT`); "**TRUE — EN1-UQ4** (`charSum_dyadic_large`, private)"; "**GAP — `ratioAtMost_dyadic`** is proved except for two closed children": `colorable_four_dyadic_small` ("U_Q is four-colourable at Q ∈ {4, 8, 16, 32}") and `charSum_64_ge` ("λ_min(U₆₄) ≥ −15"), "Both are true by X26B-T1's exact computations [tools]"; the amendment's `ratioAtMost_of_two_notMem` "with the ruled statement verbatim", its `sorry` "from `ratioAtMost_cert` alone"; build 4 green, statements SAME 44 / PRIVATE-SAME 129 / NEW 1 / CHANGED 0 (plants 5/5), 245 records CLEAN 229 / IMPORTED 7 / UPSTREAM 9 / FAIL 0; what is left of the dyadic branch "About 700–1,200 lines in all" (a generic form of `Floor128`'s bridge, then five certificates); generalizations (Lemma P needs only one θ with θ − σθ a unit, so ICM2's odd chain "now exists twice"; `card_eq_sq_of_involution`); a lint finding outside it (`Rigidity.archTop`'s unused `[NumberField ↥F]`, `Rigidity/ContinuityGroup`). **My receipts:** the five commits are on `fs131-wcm3`; from the tree's compiled library (scratch `icm3/Ax1.lean`) `ratioAtMost_of_two_notMem` has the ruled statement and rests on `[propext, sorryAx, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]`, as does `ratioAtMost_of_five_le_chromaticNumber`; `tca_uniform` on the standard three and Weil's bound; `CircleCos.circleCos_ge` on the standard three. **Rulings, four parts.** (1) *The next job on this line:* the two certificate children — the generic binary-field bridge, the four four-colourings and the spectrum at 64 — then, if the budget remains, ICM2's odd Lemma P folded onto `SqZeroInvT` (a fact proved once), in this tree on a new branch (item 923); alternative, leave the dyadic children for the chain's landing — declined: the gate takes no `sorry`, so the chain cannot land without them, and this tree's build is current; high. (2) *The route at 27 through Weil's bound:* accepted — the chain already rests on Weil at M13's tail (`tca_uniform`), so a Weil-free 27 buys nothing for the chain; alternative, the recorded model route at KC13's price — declined; high. (3) *`archTop`'s unused binder:* a definition, so the chain's landing gives it `@[nolint unusedArguments]` with its reason if dropping it moves other stored types, else drops it; high. **Corrections owed (the second filing):** the prices (23 and 31 about 300 lines against KC13's 700–1,200; 27 about 125 against 400–600; EN1-UQ4 about 260 against KR1's 300); EN1-UQ4's grade line in `plans/FS131-EN1-derivation.md` § 7.3, now [kernel]. **Credited:** the 27 route, Lemma P with no unit 2, and the amendment done the same day.
> — source: plans/FS131-close-inventory.md

**The leaf you close** (M13's line, `Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` near l. 2075 on `fs131-wcm3`) is
private: `ratioAtMost_cert [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ} (hQ :
Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hQ1119 : Q = 11 ∨ Q = 19) : ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c` — print it from
the kernel in your readback; `RatioAtMost` is defined there (l. 41) from `levelTarget` (`SpectralChain`). **Since
`ClassRatio` is not yours, state the link's conclusion in a module `ClassRatio` can import** — with `RatioAtMost`'s
body written out (its definition is self-contained over `SpectralChain`), so that at the landing `ratioAtMost_cert` is
one line reading your theorem; show that one line compiles in a scratch copy, not in the file. **At `q = 19`** the bound
is being proved now on the certificates' line (FS131-IKC4): take it as a named hypothesis with the shape of
`sum_le_eleven` (`Arith/FibreCert11Bound`) at 19, its constant left as a parameter or the reduced certificate's
`U = 88.643400…` as a rational bound, your choice, and say which; the landing discharges it by that job's theorem.

**Where everything is:** the certificate planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/plans/FS131-KC13-certificates.md` § 5.2 (K1–K5, their routes and prices; K4's first half
"is **Lemma P**", proved by FS131-ICM2 on M13's line, private, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/plans/FS131-ICM2-implementation.md`) and § 5.1 (the
case split); FS-66's `data/fs66/b1/SOUNDNESS.md` §§ 1–2 (L1, L2 — the fibre shares); the last certificate implementer's
record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/plans/FS131-IKC3-implementation.md`; `Arith/FibreCert11Bound` (`sum_le_eleven`, `card_le_eleven`,
`model_eleven`), `Arith/NormOneTarget`, `Arith/UpperHalf` in your merged tree; M13's last record
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/plans/FS131-ICM3-implementation.md`.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the branch cut, merged and built;
   `ratioAtMost_cert`, `RatioAtMost`, `levelTarget`, `sum_le_eleven` and `card_le_eleven` printed from the kernel and
   restated in one line each; K3–K5 restated beside their routes, with what each reads.
2. **K3, K4, K5 and the composition** (saved stages as they fall): the `q = 11` case with no `sorryAx` (the one line to
   me), the `q = 19` case over its named hypothesis; each statement with a model.
3. **The scratch check**: a copy of `ClassRatio` whose `ratioAtMost_cert` reads your theorem in one line compiles, and
   `ratioAtMost_of_five_le_chromaticNumber` then prints with no `sorryAx` but through the dyadic children FS131-ICM4 is
   proving and the `q = 19` hypothesis — each named.
4. **The gate's items for your files**: one build under the slot with no warning from them; the axioms of every public
   declaration printed from the built tree, each listed, with a planted record watched showing; the guarded lint
   (`lake lint --no-build -- --no-build --trace`) with no finding in your files; no existing statement or definition
   changed by the merge or by you, shown from the kernel's side (a planted change watched firing).
5. **Drafts for the landing**, in your record: the one line for `ratioAtMost_cert`; the audit's block; any `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued. Stopping at a saved stage with a leaf
   left, named with its route, is a good report.

## What is yours to decide

The proofs; the module cut and names; private helpers; imports; the route of each leaf where the plan's does not go
through (tell me which). An unread binder of a statement of yours is dropped. Not yours: an edit to `ClassRatio` or to a
certificate module (ask me: the owning job makes it); a change to any existing statement or definition; a declared
axiom; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 316 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is `fs131-wla`'s, so the first build compiles the count's modules, M13's and the
p = 11 certificate's (about 21 modules of kernel checks, a few minutes): budget 20–40 minutes and read while it runs.
One file through `lake env lean`: 3 to 24 seconds, 3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ikl1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile. The p = 19 job can hold up to 10 GiB of the slot for long
stretches: on exit 75 wait ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137. Stop a
process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your record cites lives
under `data/fs131/ikl1/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your branch and do not push**; I copy the branches to a
local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
