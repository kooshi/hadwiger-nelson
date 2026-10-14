# Brief FS131-KDB1 — the density bound `m₁(ℝ²) ≤ 0.2470`, planned for the kernel to its leaves and priced

*Written 2026-10-14 11:36 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-14. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KDB1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: the kernel lane's planner for one published, computer-assisted theorem the five-colour chain reads — `[AmbrusEtAl2023]` Theorem 1, every Lebesgue-measurable planar set with no two points at distance one has upper density at most 0.2470 — typed as the library's named hypothesis `Plane.OneAvoidingDensityBound`, now to be proved: its route chosen, its statements typed to their leaves, each classical input and the certificate's arithmetic priced from first leaves written in scratch
  launch: now, in a tree whose last job is long finished, on a branch already cut from `main` (at `432c6f7cf`) with `main`'s compiled library copied in from the reference tree; four other jobs run in other trees and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if the paper's statement differs from the typed one in any respect, if a classical input (Bessel functions, positive-definite functions, the reduction to periodic sets) is priced over two thousand lines from its first leaf, and if the certificate's arithmetic looks out of the kernel's reach (more than an hour or 16 GiB for a cut of it); the report goes to `data/fs131/reports/FS131-KDB1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-KDB1-density-bound.md` (new, on branch `fs131-wdb`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g` on its branch `fs131-wdb` (checked out, cut from `main`; its compiled library is `main`'s, copied from `fs131-wrc`): first, `Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean` taken from branch `fs131-wkr` (at `3fabd5e10`) by `git checkout fs131-wkr -- <that path>`, **text unchanged**, with its line in the build's lists and its row in `ARCHITECTURE.md`; then new modules under `Proofs/HadwigerNelson/Plane/` or `Proofs/HadwigerNelson/Analysis/` for the proof, with their lines and rows; your tools under `tools/` named for this job; `plans/FS131-KDB1-density-bound.md`; `data/fs131/kdb1/`; `data/fs131/reports/FS131-KDB1.md`. **Not** the statement of `OneAvoidingDensityBound` (it is the paper's, read aloud by its typist; a change comes to me), any other existing module's statements, the paper's certificate files (read only), the declared theorems. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage; save a stage (a commit on your branch) after the readback, after the route's choice, after each part's statements and after each priced first leaf

Hello. The five-colour chain's count reads one published bound: no measurable planar set avoiding distance one has
upper density above 0.2470. Its authors proved it with a computer-assisted Fourier argument, and this project already
re-checked their certificate outside the kernel, exactly and in ball arithmetic. Kooshi has decided it is to be proved
here, not assumed. You plan it.

## Why this job

Kooshi's word, and his rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

His answer this morning, `data/fs131/REQUEST-2026-10-13.md` W6: "Yes, prove the density bound." The chain's map priced
the formalization at three to six agent-weeks from Mathlib's coverage alone; this project's measured rate is about 900
lines of Lean per active hour, and implementers have been coming in at half to three quarters of their planners' lines.
A price from first leaves is what decides how it is staffed.

## The statements

My rulings on the bound, the map planner's hand-back, and Kooshi's answer as I logged them (their words in quotation
marks, the rulings mine):

> 818. **FS131-KR1 — a classical input priced over a week: `m₁(ℝ²) < 1/4` (`[AmbrusEtAl2023]` Theorem 1); BochnerOn priced under a week; a shared lemma placed once (2026-10-14 10:21 UTC; by message).** From its message: "The source is `[AmbrusEtAl2023]` Theorem 1, p. 4 of arXiv v3: 'Any Lebesgue measurable, 1-avoiding planar set has upper density at most 0.2470.' … The paper is held and was read in full (J26). This repository already checks its certificate: H1–H3 and H6 exactly, and H4–H5 in ball arithmetic (J49) … Mathlib at the pin has no J₀ and no positive-definite or autocorrelation machinery on ℝ². My price, from Mathlib's coverage and not from an elaborated leaf: about 3–6 agent-weeks. Recommendation: declare it as an import with the four items … printed bounds before this paper are all above 1/4 (KMOR 0.2544). So formalizing is the only alternative to declaring"; "BochnerOn τ′_∅ … about 2,000–2,500 lines, about 4–6 agent-days … I plan to formalize it"; "the lemma that the tail's ratios are bounded uniformly is shared with M13 (CLS). I will put it upstream of both, in M13". **Rulings.** (1) *Declaring `m₁(ℝ²) < 1/4`:* **Kooshi's decision** — it adds an axiom to the library at a price past his "a week or so" for the standard three; put to him report with the price and the recommendation; meanwhile nothing is declared: it is typed as a named hypothesis of ours standing for an outside theorem (the statement as printed at p. 4 with p. 2's definitions and eq. (1)), taken by M12's count lemma, and its four items drafted for a one-edit declaration; the formalization's first leaf and Mathlib's gaps written down for his choice; alternative, declare on my ruling — declined, an axiom is reported to him first (item 761 ruling 2); high that it is his. (2) *BochnerOn:* formalize on its route; a message if a first leaf reprices it over a week; high. (3) *The uniform-tail lemma:* once, upstream in M13; high. Sent by one message. **For Kooshi's report — a decision for him:** declare the density bound `m₁(ℝ²) < 0.2470` (Ambrus–Csiszárik–Matolcsi–Varga–Zsámboki 2023, its certificate already checked here) as an outside theorem, or formalize it (priced at three to six agent-weeks, unmeasured); default if he does nothing: it stays a named hypothesis of the chain's headline, and the chain's theorem is stated over it.
> — source: plans/FS131-close-inventory.md

> 823. **FS131-KR1 handed back: the chain's whole remaining road on one map (2026-10-14 11:03 UTC; "JOB FS131-KR1 — DONE"; 560k by the harness's count — past the line, not to be resumed; branch `fs131-wkr` at `3fabd5e10`, tree `fs131-wch`; record `plans/FS131-KR1-chain-map.md` there, its § Stage 5 the map).** From its hand-back message: six new modules typed (M2a `Rigidity/Herglotz`, M3 `Rigidity/InvariantMeasure`, M10 `Rigidity/ContinuityGroup`, M2b `Rigidity/BochnerTau`, M13 `Rigidity/ClassRatio`, M12's input `Plane/OneAvoidingDensity`), M11, M12 and M15 read and priced; "My seven modules come to about 14,000–28,000 lines. About half of that is M12, the count … 6,000–12,000 lines, 3–6 weeks; it needs its own planner"; M13 "2,500–5,000 lines plus FS-66's certificates at 11 and 19 … the cost of checking them in the kernel is unmeasured"; "Every price is estimated from what Mathlib at the pin covers, not from a proved leaf"; the critical path "M13's uniform-tail lemma → M12, alongside lane T → M8b and M4 → M10 → M2b → M11"; the density bound typed as `Plane.OneAvoidingDensityBound`, "as you ruled", its model proved; two private lemmas of `ChainAtTA` M10 reads. **My receipt:** the seven commits exist; from its compiled tree (scratch `kr1/Ax.lean`): `Plane.OneAvoidingDensityBound` prints as "∀ A, NullMeasurableSet A volume → (∀ a ∈ A, ∀ b ∈ A, dist a b ≠ 1) → ∀ x, limsup (fun R => volume (A ∩ ball x R) / volume (ball x R)) atTop ≤ ENNReal.ofReal 0.2470" on `EuclideanSpace ℝ (Fin 2)` — read by me against its row 2 table: equal to the page (the page's "independent of the choice of x" makes every centre the same as one); `oneAvoidingDensityBound_model` on the standard three. **Rulings.** (1) *The two private lemmas of `ChainAtTA` (`mem_torsion_mul_arch_iff`, `exists_rat_coords`):* made public by M10's implementer, statements unchanged and dumped (one fact proved once); high. (2) *The draft claim lists' corrections (M2's "existence half", M15's model):* carried by the five dated lines, filed; the generated drafts are left as their generator writes them; high. (3) *The next slot:* M12's planner (FS131-K12, item 824) — the longest single stretch and on the critical path; alternative, the FS-66 certificate measurement for M13 — next, as a short job; medium-high. **Filed:** its five dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit; every bibliography key it cites resolves (`[Rudin1962]`, `[Kakutani1938]`, `[LevitzMott1972]`, `[KMOR2016]`, `[BachocEtAl2014]`, `[Zhang2012]` each have a row); their reading-status lines and its three `LEAN.md` lines are owed to the second filing. **For Kooshi's report:** the chain is weeks from the gate, not days — about 14,000–28,000 lines in its seven unread modules by estimate, M12 alone three to six weeks, and the density bound three to six weeks more if formalized; a fork in scope that is his (what to publish before the chain lands).
> — source: plans/FS131-close-inventory.md

> 828. **Kooshi's answers to the interim report (W6, 2026-10-14 11:35 UTC; verbatim in `data/fs131/REQUEST-2026-10-13.md`).** "Here's the book: https://math-books.github.io/theory/(Math%20Book)%20Fourier%20Analysis%20on%20Groups%20(Walter%20Rudin)%20(1990).pdf"; "Yes, prove the density bound."; "Once the chain lands, we'll do some sanitization, git history rewrites, some nice readmes, a public readable roadmap of what's left to be formalized, and push to github. Not a full writeup, just that. Then we'll get back to work. That also solves our backup issue." **Done:** the book downloaded into its own new folder, its identity checked from its title pages ("FOURIER ANALYSIS ON GROUPS", Walter Rudin, "Wiley Classics Library Edition Published 1990", 294 pp.), moved to `~/source/library/pdf/Rudin1962-fourier-analysis-on-groups-wiley-classics-1990.pdf` (sha256 begins `b2be3297559f2639`), and `[Rudin1962]`'s row now says held, not read; `tools/bib_audit.py` passes. **The density bound:** formalized, not declared — a planner launches on it (item 830). **The conditional instruction** written to disk with its trigger: when the five-colour chain lands (row 121's `χ(ℚ(√47)²) = 5` through the gate on `main`, no hypothesis of ours left), the publication pass — sanitization, history rewrites, READMEs, a public roadmap of what is left to formalize, a push to GitHub; each irreversible step confirmed with him at the time. **The other question** (what to publish before the chain) is answered by it: nothing before the chain lands.
> — source: plans/FS131-close-inventory.md

**The statement to prove** is the definition `Plane.OneAvoidingDensityBound` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean` (on branch `fs131-wkr`; it
comes onto your branch by your first commit), read aloud there against the paper and the subject of its four drafted
items in the map planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/plans/FS131-KR1-chain-map.md` § 6.3. Its proof is the theorem `Plane.oneAvoidingDensityBound :
OneAvoidingDensityBound` (or your name) — the statement unchanged.

Where everything is: the paper, held and read in full by an earlier job, `/home/kooshi/source/library/pdf/arXiv-2207.14179-ambrus-csiszarik-matolcsi-varga-zsamboki-density-planar-sets.pdf` (Theorem 1 p. 4; the definitions p.
2 and eq. (1); its §§ 2–5: the reduction, Lemma 1's configuration, the Fourier side and its function `ϕ`); the earlier
bound it builds on, `/home/kooshi/source/library/pdf/arXiv-1501.00168-keleti-matolcsi-oliveira-ruzsa-planar-sets-avoiding-unit-distances.pdf` (`[KMOR2016]`; Lemma 3.2 (1) is the first leaf the map planner named); this project's checks of
the certificate — `plans/FS100-KT1-ambrus-ball.md` (J49: the obligation H4 in ball arithmetic, its covering of `[0, 10⁴]`
and its Lipschitz enclosures) and the records it cites for J26 (the exact checks H1–H3 and H6); `plans/FS100-K-kernel-47.md`
(row X-AMB: what a kernel certificate would need); the map planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/plans/FS131-KR1-chain-map.md` § 2.5 (what Mathlib lacks: J₀,
positive-definite functions on the plane). `LEAN.md` § The kernel's cost model.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; your first commit (the statement module,
   unchanged) built; the paper's proof restated in your record as a chain of steps, each with its page and what it reads.
2. **The route** (a saved stage): for each step, what Mathlib at the pin holds (searched by name), what must be built,
   and the choice among routes where there are two — the Fourier side in the plane (autocorrelation, positive
   definiteness, the radial reduction), the Bessel function `J₀` (a definition and the bounds the paper's `ϕ` needs:
   power series, integral representation, or the enclosures J49 used), the reduction from upper density to periodic sets,
   Lemma 1's inclusion–exclusion over its configuration, and the certificate's arithmetic in the kernel (exact rationals,
   interval or ball arithmetic as literals; no `native_decide`).
3. **The statements typed** (saved stages): with `sorry` at the leaves only, each read aloud against the paper, each with a
   model, a plan per leaf naming Mathlib's declarations; the composition proving `OneAvoidingDensityBound` from the parts.
   **The domain pass as a fresh skill invocation on every new definition, and the obligation pass on every new statement.**
4. **Priced from first leaves** (written in scratch, elaborated, measured): at least KMOR's Lemma 3.2 (1), one `J₀` bound
   of the kind `ϕ` needs, and a cut of the certificate's arithmetic in the kernel — its time and memory, extrapolated to the
   whole covering.
5. **Lanes**, sharing no file, each with its measured price and what it waits on.
6. **Drafts**: dated lines for the chain's claim list (`data/fs131/claims-NF2.md`); bibliography lines for every source you
   read or cite; `LEAN.md` lines.
7. The report in the standing rules' form.

## What is yours to decide

The route; how the modules are cut; how the certificate is encoded; the order after item 1. Not yours: the statement;
`native_decide` or any trust beyond the kernel; a declared axiom (the bound is now to be proved, by Kooshi's word); a change
to a typed statement of another module; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 316 GB of disk free.** One file through `lake env lean`: 3 to 24
seconds and 3.6 GB for ordinary files; a certificate cut may take far more — run it under the slot with a time limit and
checkpoint the measurement. A build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name kdb1 -- <command>`

Four other jobs share the slot; ask for no more than 12 GiB without telling me first. On exit 75 wait ten minutes and
retry. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your record
cites lives under `data/fs131/kdb1/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
