# Brief FS131-ILA1 — the five-colour chain: one admissible pair of unit vectors at every real number field

*Written 2026-10-14 16:54 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-ILA1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the implementer of lane A — the one `sorry` of `Rigidity/UnitCircle`, `exists_admissiblePair`: at every real number field, a pair of unit vectors of the kind the entropy split needs (its definition, `AdmissiblePair`, is typed and read by `EntropySplitMax`), proved by the valuation route the last chain implementer planned in seven leaves, as private helpers of its file or a new module beside it
  launch: now, in M11's implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; the chain's entropy implementer proves the split and the positive-entropy files in another tree on the same line (it does not touch `UnitCircle`); three other jobs share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if the statement is false as typed or needs a hypothesis it lacks, if the first two leaves price the lane above 1,500 lines, if a classical input is missing at the pin, and with one line when `exists_admissiblePair` prints the standard three; the report goes to `data/fs131/reports/FS131-ILA1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-ILA1-implementation.md` (new, on branch `fs131-wla`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1` on a **new branch `fs131-wla`** that you cut from its head (`fs131-wm12` at `e736212f2`; its build is current for that commit): **the proof of `exists_admissiblePair`, private helpers and import lines only — no statement changes, no definition changes** in `Proofs/HadwigerNelson/Rigidity/UnitCircle.lean`; a new module `Proofs/HadwigerNelson/Rigidity/AdmissiblePrime.lean` for the leaves if they are better public (its lines in the build's lists and `ARCHITECTURE.md`); their `ARCHITECTURE.md` rows where a cell's state changes; your checks under `tools/` named for this job; `plans/FS131-ILA1-implementation.md`; `data/fs131/ila1/`; `data/fs131/reports/FS131-ILA1.md`. **Not** `EntropySplitMax.lean`, `EntropyFibres.lean`, `PositiveEntropy.lean` (another job's, on another branch), M11's modules, the count's modules, any module under `Outside/`, the declared printed theorem. Untracked files of the last two jobs are in `data/fs131/km11/` and `data/fs131/im11/`: leave them. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. The entropy split — the chain's positive-entropy half — takes one admissible pair of unit vectors as an input.
Whether such a pair exists at every real number field is the one statement of `Rigidity/UnitCircle` left unproved. The
chain's entropy implementer planned it, priced it at about 1,000 lines, and handed it on so that its own lanes could go
first. You prove it.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

With lane A proved, the models that are conditional on an admissible pair become unconditional (inventory item 801,
ruling 2), and the entropy split reads a pair that exists at every real number field.

## The statements

The dated line of the chain's claim list (`data/fs131/claims-NF2.md`) on the split, and the hand-backs behind this job as
I logged them (their words in quotation marks, the rulings mine; item 761's ruling 4 is a note of mine, unchecked, on a
completely split prime — the planned route below takes another prime and does not need it):

> - 2026-10-14 — **NF2-LEAF-20 is narrowed: the entropy split is read at one rotation (FS131-KN7, Amendment 2 of its brief).** `Rigidity.EntropySplit` asks for entropy zero at one rotation by a non-torsion unit vector, which is all `mrPlus_of_split_of_carried` reads; PE-2 at every rotation is `Rigidity.EntropySplitEvery`, which implies it and is off the headline's path. Off the path with it: Lemma W for every non-torsion vector and the torsion case (X02D ll. 156, 166); on the path: one admissible `Γ`. `mrPlus_of_split_of_carried` is now a theorem on the standard three axioms.
> — source: data/fs131/claims-NF2.md § Dated lines

> 761. **FS131-KN8 handed back: the chain's fourth planner, at stage 6 (2026-10-14 06:55 UTC logged; "JOB FS131-KN8 — STAGE 6 SAVED … Items 1–4 and 6–8 of § Done means are done … Item 5 is done in words"; 471k by the harness's count — not to be resumed; branch `fs131-wk8` at `b531d058e`, tree `fs131-wq1`; record `plans/FS131-KN8-chain-split.md` there).** Its words: four modules typed with `sorry` at the leaves only — `Rigidity/DualGroup` (M4: "the dual of a discrete abelian group as a compact group under the pointwise topology. For countable G it is Polish, its Borel σ-algebra is the cylinder one, and it is a standard Borel space. Also separation of points, Fourier uniqueness, and Haar measure"), `Rigidity/UnitCircle` ("`AdmissiblePair` is the page's admissible Γ"), `Rigidity/Pieces` (M6: "PE-1′, the chain of pieces, Lemma Γ's steps, and Lemma Γ itself … Its hypothesis is `ErgodicSMul p.subgroup (Dual F) ρ`, which is exactly what the release's decomposition outputs"), `Rigidity/EntropySplitMax` (M7b: "the split `entropySplit_of_admissiblePair : EntropySplit F`, from one admissible pair"); "`haar_or_zero_entropy`'s proof does need `[PolishSpace X]` … The kernel's dump shows exactly ` [@PolishSpace.{u_1} X inst_1]` inserted (control fired) and the other three constants byte-identical"; "three statements of mine were false as first typed … lacked `[NumberField F]` … I corrected them before committing. No statement already typed in the chain is defective"; build 2 exit 0, 73 `sorry` warnings and no other; lint 14 passed; architecture PASS. **My receipt:** the five commits exist on `fs131-wk8`; from its compiled tree under the memory tool (scratch `kn8/Ax.lean`): `haar_or_zero_entropy`'s binders read `[BorelSpace X] [PolishSpace X]`; `Rigidity.polishSpace_dual : ∀ (G) [AddCommGroup G] [Countable G], PolishSpace (AddChar G Circle)`; `entropySplit_of_admissiblePair : ∀ {F} [NumberField ↥F] (p : AdmissiblePair F), EntropySplit F`, its axioms the standard three and `sorryAx` (a skeleton, as reported). **Rulings, four parts each.** (1) *The branch:* stays off `main` (a skeleton), the base of the chain's next lanes (D, U, G, S of record § 5.1); high. (2) *Lane PD, Pontryagin duality for a countable discrete group (D1, D2):* **formalize**, a planner first (FS131-KPD1, item 762), the declared form only as a fallback priced over a week, which comes to me (and an axiom added to the library is reported to Kooshi before it is declared); alternative, declare D2 now from `[Rudin1962]` — declined: W2, "when unsure, formalize", and the counter-priors on Lean cost; and a shorter route is in sight (below); high. **A route I saw while reading, labelled mine and unchecked, for the planner:** the one use (record § 2.3: "PE-1′'s total irreducibility needs it at `N = Y^⊥ = 0`") is "a closed subgroup `Y` of `Ĝ` with `Y^⊥ = 0` is all of `Ĝ`"; for discrete `G` a basic neighbourhood reads finitely many points, so restricting to the finitely generated `N = ⟨g₁, …, g_k⟩` (onto `N̂` since the circle is divisible) reduces it to closed subgroups of a torus times a finite group, where annihilators are Kronecker's theorem — no Haar measure, no `L²`, no Peter–Weyl. (3) *Tate's self-duality and strong approximation (M8b's inputs, prior-art debts):* priced by M8b's planner on record § Stage 4's vocabulary; bibliography rows (`[Tate1950]` or `[Weil1967]`) when a job reads one; not now; high. (4) *Lane A, `exists_admissiblePair` over every real number field:* a planner-and-implementer job in the queue; for its brief, a note of mine, unchecked: one completely split prime needs no Chebotarev — for `f` the minimal polynomial of a primitive element of the Galois closure, a prime dividing some `f(n)` and not the discriminant has a degree-one prime above it, hence (Galois) splits completely, and Schur's argument gives infinitely many such primes; medium. (5) *`Rigidity.entropySplit` sits in `ChainAtTA`, upstream of M7b:* owed to the chain's landing — the leaf moves downstream of `EntropySplitMax` with its statement unchanged, or the headline is assembled downstream (an import cycle otherwise); high. (6) *Its generalizations* (step 2 for any group action; the pigeonhole's `α′`; Herglotz–Bochner idle at countable `G`, item 757): filed as its dated lines. (7) *The three statements false as first typed:* credit for catching them before any commit; no workflow change. **Filed:** its four dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit. **Owed to the second filing:** its `LEAN.md` lines (record §§ 3.5, 5.2) and the `[Rudin1962]` reading-status line (§§ 1.5, 2.1 cited, recalled, not read). **The queue's order, re-ruled:** the chain's PD planner takes this slot ahead of the density equality's lanes C and D; alternative, the density lanes now (interleaving) — declined: their landing waits on the port (about four lanes, 12–18 hours by its plan), so they have slack, while PD is on the chain's longest path; medium-high; the density lanes take the next free slot.
> — source: plans/FS131-close-inventory.md

> 880. **FS131-IJ3 — lane A priced at about 1,000 lines from its plan; proposed as a job of its own (notice, 2026-10-14 16:47 UTC; by message).** From its message: "I priced it from my plan at 800–1,250 lines, about 1,000 … The price comes from the plan, not from proved leaves"; the route "X02D's valuation argument at a degree-one, unramified, odd prime P of L = F(i)", seven leaves (A1 Schur about 80; A2 a degree-one prime 200–300 through `discr_mul_isIntegral_mem_adjoin` and `not_dvd_discr_iff_forall_mem`; A3 a principal power by the class group's finiteness 30–50; A4 the conjugate prime differs 40–70; A5 the core, no power of `w = z/z̄` in a proper subfield, by `Ideal.sum_ramification_inertia` over `𝓞_M`, 300–450; A6 independence at a second prime 100–150; A7 assembly through `AdmissiblePair.ofPow` 60–100); "neither a complex absolute value nor real parts can replace the p-adic step. When F is totally real, L is a CM field and every conjugate of every unit vector lies on the unit circle"; "Proposal: I do the entropy split next. `entropySplit_of_admissiblePair` takes the pair as an argument, so it does not wait on lane A. Then M5-E and M5-P. Lane A would go to a job of its own … I write lane A's plan into my record." **Ruling, four parts:** approved as proposed — the split, M5-E and M5-P in this job; lane A, planned in its record, to a job of its own in the queue; alternative, lane A here first — declined, its price and the job's budget do not fit together, and the split does not wait on it; high. No reply sent (its course stands unless told otherwise). **The queue gains lane A** (one implementer, from the plan in `fs131-wq1:plans/FS131-IJ3-implementation.md`).
> — source: plans/FS131-close-inventory.md

> 881. **FS131-IM11 handed back: M11 proved, all 33 leaves (logged 2026-10-14 16:53 UTC; "JOB FS131-IM11 — DONE"; 525k by the harness's count — past the line, not to be resumed; branch `fs131-wm12` at `e736212f2`, tree `fs132-wi1`; record `plans/FS131-IM11-implementation.md` there).** From its hand-back message: "All 33 leaves of M11 are proved. `aPlusOfR88` now rests on one open leaf only: M2b's `bochnerOn_tauPrime`"; "`Rigidity.aPlusOfR88 (F) [NumberField F] : (chainInterface F).APlusOfR88` — [kernel] on `[propext, sorryAx, Classical.choice, Quot.sound]` … The `sorryAx` comes only through `Rigidity.bochnerOn_tauPrime`", read against J45 Lemma A⁺ with remark (ii) at S = ∅: "if no invariant random proper four-colouring of Cay(ℤ[U_F], U_F) has a trace spectral measure null off T + A, then for every invariant colouring and every trace spectral measure of it, the integral of Re χ(1) over the characters off T + A is strictly negative"; `spectral_null_of_orthogonal`, `isSpectralMeasureOf_condExpL2`, `trace_decomp` on the standard three; the models (`spectral_null_model` clean; two over M3's leaves); "121 records: 114 CLEAN, 7 resting on M2b or M3 only"; statements PASS with two ruled changes (`mem_nhds_profTop` public; one unread binder dropped, `inner_colourInd_comp_unit`); "0.6–0.85 of what the plan left"; of item 873's three helpers only `mem_nhds_profTop` made public — its route reads neither `archHom` nor `eventually_archTop`. **My receipts:** the six commits exist; `SpectralSubspace`, `TraceSplit`, `APlus` hold no `sorry`; from the tree's compiled library (scratch `km11/Ax2.lean`): `spectral_null_of_orthogonal` and `trace_decomp` — each `[propext, Classical.choice, Quot.sound]`. **So on the chain's branches, with M2b proved on `fs131-wt5` (item 879, my kernel receipt pending) and M3 on `fs131-wt4` (item 876): A⁺ at the empty set — the chain's hypothesis `APlusOfR88` — is proved once the branches are joined.** **Rulings, four parts.** (1) *Two of item 873's three helpers left private:* accepted — no reader, no fact proved twice; making them public would need `archHom`'s unread binder and `eventually_archTop`'s docstring repaired for no use; high. (2) *The three generated `congr_simp` theorems:* allowed, listed for the landing (as item 850's five). **The slot:** to lane A (item 882), in this tree, whose build is now current for the chain's line. **Prediction scored:** 0.6–0.85 of what the plan left.
> — source: plans/FS131-close-inventory.md

**The plan** is item 880 above — seven leaves A1–A7 at a degree-one, unramified, odd prime of `L = F(i)`, about 1,000
lines — written in full in the last chain implementer's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-IJ3-implementation.md` § 2.5 (in its tree; read it there). Read
`exists_admissiblePair`'s stored statement and `AdmissiblePair`'s definition from your built tree first; restate the
plan against them in your record; then prove A1–A7 in the plan's order or yours.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; `exists_admissiblePair` and
   `AdmissiblePair` printed from the kernel and restated; the plan's seven leaves restated against them, each with the
   Mathlib names it reads `#check`ed at the pin.
2. **The leaves** (saved stages as they fall, and the one line to me when `exists_admissiblePair` prints the standard
   three); re-price from the first two and say so.
3. **No statement and no definition changed**, shown from the kernel's side against a dump of `UnitCircle`'s stored
   statements taken before any edit (a planted change watched firing); one build under the slot with no warning from your
   files; the axioms of every public declaration of your files printed from the built tree, each listed, with a planted
   record watched showing; the guarded lint with no finding in your files.
4. **Drafts for the landing**, in your record: the audit's block; any `LEAN.md` lines; bibliography lines for every source
   you read (X02D's derivation entry by address; Schur's theorem by its printed source if you cite one).
5. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proof; private helpers or the new module; imports; the route of any leaf where the plan's does not go through (tell
me which). Not yours: a change to `exists_admissiblePair`'s statement or `AdmissiblePair`'s definition; the files listed as
not yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wm12`. One file through `lake env lean`: 3 to 24 seconds,
3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ila1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile. The certificate job holds up to 10 GiB of the slot for
long stretches: on exit 75 wait ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137.
Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your record cites
lives under `data/fs131/ila1/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
