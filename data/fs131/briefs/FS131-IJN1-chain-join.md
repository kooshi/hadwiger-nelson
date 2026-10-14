# Brief FS131-IJN1 — the five-colour chain joined on one branch, its small leaves closed, its headline read from the kernel

*Written 2026-10-14 18:22 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IJN1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the chain's join implementer — merge the finished branches of the chain (M11 and lane A on `fs131-wla`; the count and M13's composition on `fs131-wcm`) into the branch where M2b and the entropy side are proved; prove the two small leaves left there (M9-S and the model `mulTwoThree_model`); carry out the landing rulings that are code (statements moved downstream, a declared theorem registered with the audit, unread binders dropped, shared helpers made one); and state the chain's headline with every proved hypothesis discharged, its axioms printed, so that what is left is named by the kernel
  launch: now, in the entropy implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; three other jobs work on lines that join this one later (M13's leaves on `fs131-wcm2`, the certificates on `fs131-wc16`, the density bound on `fs131-wdb3`) and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a merge conflicts anywhere but `ARCHITECTURE.md` and `Proofs.lean`, if a moved statement's stored type changes beyond the ruled binder, if the headline needs a hypothesis no proved or named leaf supplies, and with one line when the joined branch builds; the report goes to `data/fs131/reports/FS131-IJN1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IJN1-join.md` (new, on branch `fs131-wj`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1` on a **new branch `fs131-wj`** that you cut from its head (`fs131-wt5` at `54c2bc166`; its build is current for that commit), into which you merge `fs131-wla` and `fs131-wcm` with `--no-ff`, one each, conflicts in `ARCHITECTURE.md` and `Proofs.lean` resolved by keeping both sides; then: the proofs of `noRamifiedStableDyadic_of_tca` (in `ChainAtTA`) and `ZdAction.mulTwoThree_model`; the landing rulings below, each a ruled change dumped before and after; a new statement `Rigidity.min_localBound_five_le_chromaticNumber` (or your name) — the headline `min_localBound_five_le_chromaticNumber_of_closed` with each hypothesis it can now discharge discharged by its proved theorem, the rest kept as hypotheses, its conclusion character for character the headline's; docstrings where a moved or proved declaration's text is stale (`UnitCircle`'s two, item 897's D2; `ClassRatio`'s "skeleton"); `scripts/Axioms.lean`'s and `scripts/assumptions-ledger.txt`'s entries for the declared printed theorem; `ARCHITECTURE.md`; your checks under `tools/` named for this job; `plans/FS131-IJN1-join.md`; `data/fs131/ijn1/`; `data/fs131/reports/FS131-IJN1.md`. **Not** M13's six private leaves (another job proves them on `fs131-wcm2`), `Arith/FibreCert*` and the density bound's modules (their own lines), any module under `Outside/`, the declared outside theorems' statements. Untracked files from older jobs are in this tree: leave them. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. The five-colour chain has been proved on branches all day — the adelic model, the zero-entropy side, the entropy
split and the admissible pair, M2b and M11, the count, and M13's composition — and each branch reads the others' statements
as typed. You join the finished branches, close the small leaves, apply the rulings the landing would otherwise carry,
and print what the chain's headline now rests on.

## Why this job

Kooshi's rule for what goes out, and his conditional instruction:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The chain's landing is the trigger for the publication pass (W6 in the same file); its headline, read from the kernel on
one branch, is what tells us how far that is.

## The statements

The dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what the headline takes, what the count
is and what M11 is:

> - 2026-10-14 — **The headline with closed hypotheses takes eight, not nine (FS131-KN6, Amendment 1 of its brief).** `Rigidity.min_localBound_five_le_chromaticNumber_of_closed` no longer takes `TCA F → NoRamifiedStableDyadic F`: at a stable prime on whose residue field conjugation is trivial the level-one target is two-colourable (proved, over `Arith/UpperHalf`), so `5 ≤ L(F)` excludes one. The leaf that left the headline's path is FS100-EXC's (`Rigidity.noRamifiedStableDyadic_of_tca`); it stays stated in module M9's draft claim list, marked off the path.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **The count is typed** (FS131-K12A): `Rigidity.Counting.count_of_oneAvoidingDensityBound : Plane.OneAvoidingDensityBound → (chainInterface F).Count`, for every real number field, composed over 57 leaves in eight modules (`Plane/WindowDensity`, `Rigidity/FiniteZhang`, `PlaneZhang`, `CountTorus`, `CountResidue`, `CountCompletion`, `CountExtension`, `CountDescent`); it reads `tca_uniform`, `noRamifiedStableDyadic_of_tca`, `TA_subset_contChars`, `exists_mul_stableIntegers_le`, `dense_mixedEmbedding_nsmul_unitRing` and `upperDensity_le_of_oneAvoidingDensityBound`; no typed statement of another module changes.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **M11 typed** (FS131-KM11): `Rigidity.aPlusOfR88 (F) [NumberField F] : (chainInterface F).APlusOfR88`, composed over three modules (`Rigidity/SpectralSubspace`, `Rigidity/TraceSplit`, `Rigidity/APlus`; 33 leaves `sorry`); no hypothesis beyond `[NumberField F]`, no typed statement of another module changed.
> — source: data/fs131/claims-NF2.md § Dated lines

The two entropy planners' hand-backs, as I logged them (their words in quotation marks, the rulings mine — item 761's
ruling 5 and item 811's ruling 1 are the moves below):

> 761. **FS131-KN8 handed back: the chain's fourth planner, at stage 6 (2026-10-14 06:55 UTC logged; "JOB FS131-KN8 — STAGE 6 SAVED … Items 1–4 and 6–8 of § Done means are done … Item 5 is done in words"; 471k by the harness's count — not to be resumed; branch `fs131-wk8` at `b531d058e`, tree `fs131-wq1`; record `plans/FS131-KN8-chain-split.md` there).** Its words: four modules typed with `sorry` at the leaves only — `Rigidity/DualGroup` (M4: "the dual of a discrete abelian group as a compact group under the pointwise topology. For countable G it is Polish, its Borel σ-algebra is the cylinder one, and it is a standard Borel space. Also separation of points, Fourier uniqueness, and Haar measure"), `Rigidity/UnitCircle` ("`AdmissiblePair` is the page's admissible Γ"), `Rigidity/Pieces` (M6: "PE-1′, the chain of pieces, Lemma Γ's steps, and Lemma Γ itself … Its hypothesis is `ErgodicSMul p.subgroup (Dual F) ρ`, which is exactly what the release's decomposition outputs"), `Rigidity/EntropySplitMax` (M7b: "the split `entropySplit_of_admissiblePair : EntropySplit F`, from one admissible pair"); "`haar_or_zero_entropy`'s proof does need `[PolishSpace X]` … The kernel's dump shows exactly ` [@PolishSpace.{u_1} X inst_1]` inserted (control fired) and the other three constants byte-identical"; "three statements of mine were false as first typed … lacked `[NumberField F]` … I corrected them before committing. No statement already typed in the chain is defective"; build 2 exit 0, 73 `sorry` warnings and no other; lint 14 passed; architecture PASS. **My receipt:** the five commits exist on `fs131-wk8`; from its compiled tree under the memory tool (scratch `kn8/Ax.lean`): `haar_or_zero_entropy`'s binders read `[BorelSpace X] [PolishSpace X]`; `Rigidity.polishSpace_dual : ∀ (G) [AddCommGroup G] [Countable G], PolishSpace (AddChar G Circle)`; `entropySplit_of_admissiblePair : ∀ {F} [NumberField ↥F] (p : AdmissiblePair F), EntropySplit F`, its axioms the standard three and `sorryAx` (a skeleton, as reported). **Rulings, four parts each.** (1) *The branch:* stays off `main` (a skeleton), the base of the chain's next lanes (D, U, G, S of record § 5.1); high. (2) *Lane PD, Pontryagin duality for a countable discrete group (D1, D2):* **formalize**, a planner first (FS131-KPD1, item 762), the declared form only as a fallback priced over a week, which comes to me (and an axiom added to the library is reported to Kooshi before it is declared); alternative, declare D2 now from `[Rudin1962]` — declined: W2, "when unsure, formalize", and the counter-priors on Lean cost; and a shorter route is in sight (below); high. **A route I saw while reading, labelled mine and unchecked, for the planner:** the one use (record § 2.3: "PE-1′'s total irreducibility needs it at `N = Y^⊥ = 0`") is "a closed subgroup `Y` of `Ĝ` with `Y^⊥ = 0` is all of `Ĝ`"; for discrete `G` a basic neighbourhood reads finitely many points, so restricting to the finitely generated `N = ⟨g₁, …, g_k⟩` (onto `N̂` since the circle is divisible) reduces it to closed subgroups of a torus times a finite group, where annihilators are Kronecker's theorem — no Haar measure, no `L²`, no Peter–Weyl. (3) *Tate's self-duality and strong approximation (M8b's inputs, prior-art debts):* priced by M8b's planner on record § Stage 4's vocabulary; bibliography rows (`[Tate1950]` or `[Weil1967]`) when a job reads one; not now; high. (4) *Lane A, `exists_admissiblePair` over every real number field:* a planner-and-implementer job in the queue; for its brief, a note of mine, unchecked: one completely split prime needs no Chebotarev — for `f` the minimal polynomial of a primitive element of the Galois closure, a prime dividing some `f(n)` and not the discriminant has a degree-one prime above it, hence (Galois) splits completely, and Schur's argument gives infinitely many such primes; medium. (5) *`Rigidity.entropySplit` sits in `ChainAtTA`, upstream of M7b:* owed to the chain's landing — the leaf moves downstream of `EntropySplitMax` with its statement unchanged, or the headline is assembled downstream (an import cycle otherwise); high. (6) *Its generalizations* (step 2 for any group action; the pigeonhole's `α′`; Herglotz–Bochner idle at countable `G`, item 757): filed as its dated lines. (7) *The three statements false as first typed:* credit for catching them before any commit; no workflow change. **Filed:** its four dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit. **Owed to the second filing:** its `LEAN.md` lines (record §§ 3.5, 5.2) and the `[Rudin1962]` reading-status line (§§ 1.5, 2.1 cited, recalled, not read). **The queue's order, re-ruled:** the chain's PD planner takes this slot ahead of the density equality's lanes C and D; alternative, the density lanes now (interleaving) — declined: their landing waits on the port (about four lanes, 12–18 hours by its plan), so they have slack, while PD is on the chain's longest path; medium-high; the density lanes take the next free slot.
> — source: plans/FS131-close-inventory.md

> 791. **FS131-KN9 handed back: M5 and M9 typed and planned, M8b decided in words (2026-10-14 12:45 UTC logged; "JOB FS131-KN9 — DONE"; 531k by the harness's count — past the line, not to be resumed; branch `fs131-wk9` at `aee998a46`, tree `fs131-wch`; record `plans/FS131-KN9-chain-zero-entropy.md` there).** From its hand-back message: "**M5 is typed and planned** … A new module, `Rigidity/EntropyFibres` (9 leaves) … `Rigidity/PositiveEntropy` (10 leaves, `haar_or_zero_entropy` last)"; "**`haar_or_zero_entropy` no longer takes `[PolishSpace X]`** … The kernel's dump shows exactly that binder removed and nothing else changed … The statement is again FS131-KN7's, character for character"; "**M9 is typed in a new module, `Rigidity/RingScope`** … R ⊆ O′, proved; c·O′ ⊆ R, over every real number field; R = O′ in the scope: typed, off M8b's path, planned in words only"; "**M8b is decided in words, not typed** … I recommend packaging it as a structure `TateModel F`: the five facts M8b reads"; "Tate's duality: Mathlib at the pin has none of it … I recommend formalizing it as lane T, with a planner first. My price, from Mathlib's state and not from an elaborated leaf: several days, two to four thousand lines"; "Strong approximation and Lusin–Souslin: not needed on the routes chosen"; builds 1–4 exit 0, lint passed; an architecture cell failure inherited from the join (fixed on `fs131-wdg` by FS131-IDG1). **My receipt:** the six commits exist; from its compiled tree under the memory tool (scratch `kn9/Ax.lean`): `haar_or_zero_entropy`'s binders read `[AddCommGroup X] [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X]`, no `PolishSpace`; `unitRing_le_stableIntegers` on the standard three. **Rulings, four parts each.** (1) *The `TateModel F` interface:* approved — a structure whose fields are exactly the five facts of its record § 4.1 that M8b reads, each stated as X01D states it, quantifying over nothing of ours beyond what X01D reads; its existence is lane T's leaf; M8b's records print `sorryAx` through it until lane T lands; it is typed first by the next planner (FS131-KT1, item 792) so that lane T and M8b's parts 2–4 can run beside each other; alternative, M8b typed straight over a construction — declined, it serializes the longest stretch of the chain; high. (2) *Lane T, Tate's duality:* **formalize**, a planner first (the same job, after the interface), measuring both forms of the local character on its first two leaves and pricing from them; no axiom declared; if priced over a week, a message to me first; alternative, declare it now from `[Tate1950]` — declined (W2; "when unsure, formalize"); high. (3) *`noRamifiedStableDyadic_of_tca` (lane M9-S):* proved in place in `Rigidity/ChainAtTA` by an implementer, a proof only, off the headline's path; medium-high. (4) *M12's question (does T-C(A) read `R = O′`, or only Lemma C (d)):* carried to M12's planner. (5) *The `Pieces` docstring line:* sent to FS131-IG1 as its Amendment 1. **Filed this commit:** its four dated lines in `data/fs131/claims-NF2.md`, verbatim; two `BIBLIOGRAPHY.md` rows, `[Tate1950]` and `[Weil1967]`, from its drafts (not held, not read; `tools/bib_audit.py` passes). **Owed to the second filing:** its four `LEAN.md` lines. **The chain's ready implementer lanes now:** M5-E, M5-P, M9-R, M9-S, P2, P3 (and S after G, P2, E).
> — source: plans/FS131-close-inventory.md

**Your work, in order.** (1) **The merges** (`fs131-wla`, then `fs131-wcm`; `git merge-tree` reports `ARCHITECTURE.md` alone
for each) and one build under the slot. (2) **The two leaves**: `noRamifiedStableDyadic_of_tca` (M9-S, `ChainAtTA`) and
`ZdAction.mulTwoThree_model` (priced 100–150 lines in the last implementer's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-IJ3-implementation.md`). (3) **The landing rulings that
are code**, each listed in your record with its source item, each stored type dumped before and after:
   - `entropySplit` and `zeroEntropyCarried` (with its readers) move out of `ChainAtTA` downstream into
     `Rigidity/ZeroEntropyClosed`, `entropySplit` proved there as `entropySplit_of_admissiblePair _ (exists_admissiblePair _).some`,
     the scope binder dropped where unread (items 761 ruling 5, 811 ruling 1);
   - the declared printed theorem `Rigidity.positive_entropy_rigidity` registered with the audit — its four items from
     `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-KN6-chain-first-layer.md` § Stage 6 and the repair R1 of `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-KN7-chain-next.md`;
   - the five unread binders of lane N's statements dropped with a dump (item 770 ruling 2);
   - Lemma F made public if a second module reads it (item 801 ruling 1);
   - M3's private copies of `main`'s `Plane/OneClass/InvariantLaw` helpers: noted for the landing, which joins `main` (they
     cannot be shared until then — say so in your record).
(4) **The headline closed**: state it as above, prove it from the parts, print its axioms from the built tree, and list
every leaf its `sorryAx` comes through, by name and line. Expect M13's six leaves, the certificates' link, and the
density bound's instance.

## Done means

1. **Readback** (a saved stage, and the one line to me when the joined branch builds).
2. **The two leaves** (a saved stage).
3. **The rulings** (a saved stage), each shown from the kernel's side.
4. **The headline** (a saved stage): its stored statement printed and read aloud against the old headline's conclusion;
   its axioms; the named leaves it still reads.
5. **No other statement or definition changed**, shown from the kernel's side against dumps taken after the merges (a
   planted change watched firing); one build under the slot with no warning but the named leaves'; the guarded lint;
   `dupnames`; the architecture check; the axioms of every public declaration in the files you touch, each listed.
6. **Drafts for the landing**, in your record: the audit's block for the joined chain; the assumptions ledger's lines;
   `LEAN.md` lines.
7. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The order inside each item; the proofs; the headline's name; how the moves are cut so that no import cycle forms. Not
yours: any statement change beyond the ruled ones; M13's leaves; the other lines' files; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wt5`; the merges add M11, lane A, the count and M13's
composition (expect 10–20 minutes for the first build).

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ijn1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile. The certificate job holds up to 10 GiB of the slot for
long stretches: on exit 75 wait ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137.
Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your record cites
lives under `data/fs131/ijn1/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
