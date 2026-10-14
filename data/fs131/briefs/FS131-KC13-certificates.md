# Brief FS131-KC13 — the five-colour chain: what it costs the kernel to check the class-ratio certificates, and the per-prime leaf planned

*Written 2026-10-14 11:21 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KC13
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the eleventh planner on this chain
  role: the kernel lane's planner for module M13's hard leaf — at each stable prime, one ratio bound below one quarter for every set with no two adjacent points in every level's target — and the measurement the chain's map left owed before that leaf has a price: what it costs this kernel to check FS-66's exact integer sum-of-squares certificates at the residue sizes 11 and 19, where the eigenvalue bound fails, and the exact certificates needed at 23 and 31, where it clears by a hair
  launch: now, in a tree whose last job is long finished, on a branch already cut from `main` (at `c6b1784a4`) with `main`'s compiled library copied in from the reference tree; three other jobs run in other trees and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** with the first measurement (the smaller certificate's check: wall time, peak memory, and the form that worked), if a check needs more than 16 GiB or more than an hour, and for a statement defect anywhere in the chain; the report goes to `data/fs131/reports/FS131-KC13.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-KC13-certificates.md` (new, on branch `fs131-wc13`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf` on its branch `fs131-wc13` (checked out, cut from `main`; its compiled library is `main`'s, copied from `fs131-wrc` by checksum-identical `cp -a`): new modules under `Proofs/HadwigerNelson/Arith/` (the certificate checker, its spec examples, the certificates as Lean literals or data files the checker reads) with their lines in the build's lists and `ARCHITECTURE.md`; your tools under `tools/` named for this job; `plans/FS131-KC13-certificates.md`; `data/fs131/kc13/`; `data/fs131/reports/FS131-KC13.md`. **Not** any existing module's statements, `data/fs66/` (read only), the declared theorems. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage; save a stage (a commit on your branch) after the readback, after each measurement, and after the leaf's plan

Hello. The chain's map priced every module but one cost it could not price: the class-ratio module needs, at two
residue sizes, a ratio bound that rests on exact integer certificates this project found and checked with a frozen
Python checker, never in the kernel. One of them is 0.7 MB, the other 10.4 MB. Whether the kernel checks them in
minutes or days decides whether the chain lands this week. You measure it.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

Under it, a certificate checked only by Python is not a result of the library. The chain's map names this measurement
as owed before the module's price, and the module is on the chain's critical path, upstream of the count.

## The statements

What the chain does not claim, and the dated line that says what the count reads from this module:

> NF2-NC: any size or price of a leaf (the map says none of leaves 8–23 is sized); that the leaf list is complete (the deriver's table names two results read on the path that are not numbered leaves: the density of the ring in its completion, and the ring equalling its maximal order away from the exception fields); that the printed rigidity theorem is formalized (it is declared, with its four items); that any leaf is new mathematics.
> — source: data/fs131/claims-NF2.md § Not claimed

> - 2026-10-14 — **The count reads one constant** (FS131-KR1; the coordinator's ruling): `Interface.Count`'s proof reads `TCA F` together with Weil's bound at the tail, through `Rigidity.tca_uniform` (module M13); no typed statement changes.
> — source: data/fs131/claims-NF2.md § Dated lines

The map planner's hand-back as I logged it (its words in quotation marks, the rulings mine):

> 823. **FS131-KR1 handed back: the chain's whole remaining road on one map (2026-10-14 11:03 UTC; "JOB FS131-KR1 — DONE"; 560k by the harness's count — past the line, not to be resumed; branch `fs131-wkr` at `3fabd5e10`, tree `fs131-wch`; record `plans/FS131-KR1-chain-map.md` there, its § Stage 5 the map).** From its hand-back message: six new modules typed (M2a `Rigidity/Herglotz`, M3 `Rigidity/InvariantMeasure`, M10 `Rigidity/ContinuityGroup`, M2b `Rigidity/BochnerTau`, M13 `Rigidity/ClassRatio`, M12's input `Plane/OneAvoidingDensity`), M11, M12 and M15 read and priced; "My seven modules come to about 14,000–28,000 lines. About half of that is M12, the count … 6,000–12,000 lines, 3–6 weeks; it needs its own planner"; M13 "2,500–5,000 lines plus FS-66's certificates at 11 and 19 … the cost of checking them in the kernel is unmeasured"; "Every price is estimated from what Mathlib at the pin covers, not from a proved leaf"; the critical path "M13's uniform-tail lemma → M12, alongside lane T → M8b and M4 → M10 → M2b → M11"; the density bound typed as `Plane.OneAvoidingDensityBound`, "as you ruled", its model proved; two private lemmas of `ChainAtTA` M10 reads. **My receipt:** the seven commits exist; from its compiled tree (scratch `kr1/Ax.lean`): `Plane.OneAvoidingDensityBound` prints as "∀ A, NullMeasurableSet A volume → (∀ a ∈ A, ∀ b ∈ A, dist a b ≠ 1) → ∀ x, limsup (fun R => volume (A ∩ ball x R) / volume (ball x R)) atTop ≤ ENNReal.ofReal 0.2470" on `EuclideanSpace ℝ (Fin 2)` — read by me against its row 2 table: equal to the page (the page's "independent of the choice of x" makes every centre the same as one); `oneAvoidingDensityBound_model` on the standard three. **Rulings.** (1) *The two private lemmas of `ChainAtTA` (`mem_torsion_mul_arch_iff`, `exists_rat_coords`):* made public by M10's implementer, statements unchanged and dumped (one fact proved once); high. (2) *The draft claim lists' corrections (M2's "existence half", M15's model):* carried by the five dated lines, filed; the generated drafts are left as their generator writes them; high. (3) *The next slot:* M12's planner (FS131-K12, item 824) — the longest single stretch and on the critical path; alternative, the FS-66 certificate measurement for M13 — next, as a short job; medium-high. **Filed:** its five dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit; every bibliography key it cites resolves (`[Rudin1962]`, `[Kakutani1938]`, `[LevitzMott1972]`, `[KMOR2016]`, `[BachocEtAl2014]`, `[Zhang2012]` each have a row); their reading-status lines and its three `LEAN.md` lines are owed to the second filing. **For Kooshi's report:** the chain is weeks from the gate, not days — about 14,000–28,000 lines in its seven unread modules by estimate, M12 alone three to six weeks, and the density bound three to six weeks more if formalized; a fork in scope that is his (what to publish before the chain lands).
> — source: plans/FS131-close-inventory.md

Where everything is: the map planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/plans/FS131-KR1-chain-map.md` § 2.6 (M13 read: the route by residue size, what Hoffman's bound
gives at each, and at (d) the two certificates' sizes and form — "second-level moment relaxation, translation-Fourier
blocks"); the typed module `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` (its per-prime leaf `ratioAtMost_of_five_le_chromaticNumber`, on the map planner's
branch); the certificates `data/fs66/b1/cert-p11.json` and `data/fs66/b1/cert-p19.json` with their checker and controls in
the same folder and FS-66's records under `plans/` (search them by name); `LEAN.md` § The kernel's cost model (literals,
not built tables; GMP-accelerated `Nat`) and the earlier certificate checkers this library holds (the rung-B LRAT checker,
`Floor128`).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the certificates' form read from FS-66's
   records and its Python checker — what the certificate asserts, about which matrix, and what the checker computes; the
   inequality it certifies stated in words and in the form the per-prime leaf reads.
2. **The smaller certificate checked in the kernel** (a saved stage, and the message to me): a Lean checker whose
   soundness theorem says that an accepted certificate implies the inequality (a theorem, not a `native_decide`), the
   certificate supplied as literals, the check run by `decide` or kernel reduction under the slot — its wall time, peak
   memory and the form that worked, with a planted corrupted certificate watched being refused.
3. **The larger certificate measured or extrapolated** (a saved stage): checked if the first measurement says it fits
   in an hour and 16 GiB; otherwise its cost extrapolated from the first and from a cut of it, with the form that would
   reduce it (block structure, the translation-Fourier symmetry, a smaller relaxation).
4. **The exact spectra at 23 and 31** priced in words: what exact certificate is needed there, and whether the same
   checker serves.
5. **The per-prime leaf planned**: its statement read against the map planner's route; a plan per leaf with the
   certificate checks as leaves; its price in lines and in kernel minutes.
6. **Drafts**: dated lines for the claim list; `LEAN.md` lines for the kernel's cost model; bibliography lines for every
   source you read or cite.
7. The report in the standing rules' form.

## What is yours to decide

The checker's design within the kernel's cost model; how the certificate is encoded; whether to cut a certificate for a
first measurement. Not yours: `native_decide` or any trust beyond the kernel in a checker meant for the library; a
change to a typed statement; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 321 GB of disk free.** One file through `lake env lean`: 3 to
24 seconds and 3.6 GB for ordinary files; a certificate check may take far more — run it under the slot with a time
limit and checkpoint the measurement. A build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name kc13 -- <command>`

Three other jobs share the slot; ask for no more than 12 GiB without telling me first. On exit 75 wait ten minutes and
retry. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your record
cites lives under `data/fs131/kc13/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
