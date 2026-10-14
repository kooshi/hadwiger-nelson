# Brief FS131-ITT1 — the five-colour chain: its two newest branches joined, then the adelic model's first lanes proved

*Written 2026-10-14 10:08 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-ITT1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the chain's implementer — first the join of its proof branch (the dual group, Pontryagin duality, the pieces, the entropy file, two ports, all proved) with its planning branch (the deduction under the declared theorem, the ring, the adelic model's interface and construction, the zero-entropy side's second half, all typed); then one statement moved so that two lanes do not declare it twice; then lane T's first lanes — the interface's four derived leaves, the local and the archimedean arithmetic — and the ring's lane M9-R, and the global character's lane T-C as far as you reach
  launch: now, in the last implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; the chain's map planner works in `fs131-wch` on a branch from the planning branch (it types new modules only); the port's landing runs in `fs132-wi1` and may hold the build slot for an hour
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if the join conflicts anywhere but `ARCHITECTURE.md`, if a leaf is false as stated or needs a hypothesis it lacks, and with one line when the joined branch builds; the report goes to `data/fs131/reports/FS131-ITT1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-ITT1-implementation.md` (new, on branch `fs131-wt1`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1` on a **new branch `fs131-wt1`** that you cut from its head (`fs131-wp23` at `28c21407a`; its build is current for that commit) and into which you merge `fs131-wk8b` (at `fec557c9a`) with `--no-ff` as your first commit, `ARCHITECTURE.md`'s conflict resolved by keeping both sides' rows (`git merge-tree` reports that file alone); then: the statement of `Rigidity.TateModel.sigmaCompactSpace` moved, text unchanged, from `Proofs/HadwigerNelson/Rigidity/ThinBoxes.lean` to `Proofs/HadwigerNelson/Rigidity/TateModel.lean` (item 811's ruling 2); then **proofs, private helpers and import lines only — no statement changes, no definition changes** in `Proofs/HadwigerNelson/Rigidity/TateModel.lean`, `TateLocal.lean`, `TateArch.lean`, `TateCharacter.lean` and `RingScope.lean` (its lane M9-R leaves only: `exists_mul_stableIntegers_le`, `dense_mixedEmbedding_nsmul_unitRing`); the docstring drafts D5 of the last implementer's record (prose only, item 815's ruling 1); your checks under `tools/` named for this job; `plans/FS131-ITT1-implementation.md`; `data/fs131/itt1/`; `data/fs131/reports/FS131-ITT1.md`. **Not** `TateKernel.lean`, the M8b modules, `PositiveEntropy.lean`, `EntropyFibres.lean`, `EntropySplitMax.lean`, `ChainAtTA.lean`, any module under `Outside/`, the declared printed theorem. Untracked files from older jobs are in this tree (`data/fs131/iq1/stmt/`, plain-text dumps under `data/fs131/idg1/`, `ig1/`, `ip23/`): leave them. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. Tonight the chain's work forked into two branches: one where implementers proved the dual group, Pontryagin
duality, the pieces with Lemma Γ, the entropy file and two ports of the outside release; one where planners typed the
deduction under the declared theorem, the ring, the adelic model's interface and its construction, and the zero-entropy
side's second half. You join them, and start proving the adelic model.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The adelic model (Tate's self-duality in the form the zero-entropy side reads) is the chain's longest single stretch,
priced by its planner at about two agent-days; its first lanes are the ones everything else in it reads.

## The statements

The two dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what the model is now:

> - 2026-10-14 — **The model of the dual is typed as an interface, `Rigidity.TateModel F` (FS131-KT1).** `W = L_∞ × ∏′_{w split} L_w` (`Rigidity.SAdeleRing`, the archimedean factor Mathlib's mixed space) and a continuous `π : W → R̂`, equivariant for the unit vectors, onto, with kernel on the diagonal, `O′ ⊆ Λ ⊆ d⁻¹O′`, `W = K + O′` with `K` compact, and `π(L_∞) ⊆ A`; `π(L + L_∞) ⊆ T + A`, `Λ`'s `R`-stability and the openness of `π` are theorems over it. M8b-2..4 are proved over `(D : TateModel F)`; its existence is `Rigidity.exists_tateModel` (lane T). A typed interface, not a theorem.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **Tate's self-duality in the form the model reads, on a global character (FS131-KT1; a plan, the kernel its test).** The standard character of `W` is `ψ(a) = e(Tr_∞(a_∞) − Tr(t))` for any `t ∈ O′` congruent to `a` modulo `O_w` at every split prime; it needs no local trace. Two inputs carry it, both over every number field and both elaborated in scratch: approximation away from one prime, by the Chinese remainder theorem, and the integrality of the trace of an element integral at every prime. The product formula on `O′` is then the definition read at one point. `O′^⊥ ⊆ L` follows from the archimedean trace duality, the denominators of the trace dual of `𝓞`, and one element integral off a split prime with a non-integral trace. The inverse different, the local traces `L_w → ℚ_p`, strong approximation and Lusin–Souslin leave lane T's inputs. Priced at about two agent-days.
> — source: data/fs131/claims-NF2.md § Dated lines

The three hand-backs behind this job, as I logged them (their words in quotation marks, the rulings mine):

> 799. **FS131-KT1 handed back: the adelic model's interface typed, lane T planned and priced (2026-10-14 14:20 UTC logged; "JOB FS131-KT1 — DONE"; 501k by the harness's count — past the line, not to be resumed; branch `fs131-wkt` at `392fc2b62`, tree `fs131-wch`; record `plans/FS131-KT1-tate.md` there).** From its hand-back message: "`Rigidity.TateModel F` is typed … The five facts are nine fields … No model of the structure exists short of the construction itself; `exists_tateModel` supplies one"; the two forms of the local character measured — "Form G (global, by approximation): 72 lines, both leaves closed … Form L (local trace): 53 lines closed, one leaf open … form L then needs three inputs absent at the pin … Form G is chosen"; "lane T is typed to its leaves on form G: 34 leaves, all elaborated, with a plan per leaf and 56 Mathlib names checked at the pin"; "the price is about 1,050 lines and about two agent-days of implementer work, about one day of wall time with three lanes running at once"; fact 3's `O′ ⊆ Λ` (item 796 ruling 2's condition) "is the cheapest field … about ten lines", so the interface does not change; a shorter route for `O′^⊥ ⊆ L` with which "the inverse different, the local traces, strong approximation and Lusin–Souslin all leave lane T's inputs"; KN9's price ("several days, two to four thousand lines") replaced by this measured one; build 2 exit 0, lint passed. **My receipt:** the seven commits exist; from its compiled tree under the memory tool (scratch `kt1/Ax.lean`): `exists_tateModel : ∀ (F : Subfield ℝ) [NumberField ↥F], Nonempty (TateModel F)`, its axioms the standard three and `sorryAx` (a skeleton, as reported); `TateModel.mem_TA` the same through the interface's leaves. **Rulings, four parts each.** (1) *Lane T's lanes (T-I, T-L, T-A, T-C, T-K):* queued for implementers, T-I first (M8b's parts read `isOpenMap` and `π_eq_π_iff`); no axiom for Tate's duality — formalized at its measured price; high. (2) *The next slot:* the planner of M8b's parts 2–4 over the interface (FS131-K8B1, item 800); alternative, the ports P2 and P3 (promised at items 790 and 792) — declined once more for this slot: M8b's parts 2–4 are unplanned and on the longest path, while P2 and P3 are hours that block only the split's first leaf; the port's landing, when its last implementer hands back, takes the following slot, and P2 and P3 the one after; medium-high. **Filed:** its two dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit. **Owed to the second filing:** its four `LEAN.md` lines. **For the record of what Mathlib holds:** no adelic duality at the pin (KN9 § 4.3, KT1 § 2.6).
> — source: plans/FS131-close-inventory.md

> 811. **FS131-K8B1 handed back: the zero-entropy side's second half typed over the adelic model, with no scope (2026-10-14 09:54 UTC by the clock; "JOB FS131-K8B1 — DONE"; 505k by the harness's count — past the line, not to be resumed; branch `fs131-wk8b` at `fec557c9a`, tree `fs131-wch`; record `plans/FS131-K8B1-zero-entropy-second.md` there).** From its hand-back message: "M8b's parts 2–4 typed to their leaves over `TateModel F` — five new modules (`Rigidity/PlaceSizes` 23 leaves, `Rigidity/Multipliers` 6, `Rigidity/ThinBoxes` 14, `Rigidity/GlobalPoint` 11, `Rigidity/WanderingShells` 7)"; "Lemma 3.1′ is `TateModel.thinBox_heavy`, EN2-L31 word for word … its part (iii′) `exists_heavy_nameCells` is proved in three lines over the typed EN2-ZE"; "`zeroEntropyCarried_of_numberField (F) [NumberField F] : ZeroEntropyCarried F := (exists_tateModel F).elim zeroEntropyCarried_of_tateModel`"; "`NoRamifiedStableDyadic F` is read by no step"; the wandering-shells route (item 806); "one first-draft statement false, caught before any proof: `exists_orbit_box` needs `0 < n`"; a name collision ahead (`TateModel.sigmaCompactSpace` stated in `ThinBoxes`, needed by lane T-I in `TateModel`); five lanes priced at "about 1,600–1,900 lines, about two and a half agent-days"; and a slip of mine (item 812). **My receipt:** from its compiled tree under the memory tool (scratch `k8b1/Ax.lean`, `Ax2.lean`): `zeroEntropyCarried_of_numberField : ∀ (F : Subfield ℝ) [NumberField ↥F], ZeroEntropyCarried F` — no scope binder, its axioms the standard three and `sorryAx` (a skeleton); `Rigidity.exists_heavy_nameCells` — the standard three alone, since lane N's EN2-ZE is proved on this branch's ancestry (my first probe named it under `TateModel`, its wrong namespace; read with its import list and found in `ThinBoxes` l. 152). **Rulings, four parts each.** (1) *Moving `zeroEntropyCarried` and its two readers out of `Rigidity/ChainAtTA` into `Rigidity/ZeroEntropyClosed`, the scope binder dropped:* approved for the chain's landing, with `entropySplit`'s move (item 761 ruling 5), by the unread-binder rule, each stored statement dumped before and after; alternative, keep the binder at the headline — declined, the rule drops it and the theorem without it is stronger; high. (2) *The `sigmaCompactSpace` collision:* the statement moves now, before either is proved, from `ThinBoxes` to `Rigidity/TateModel` (upstream of both readers), by the first lane T implementer as its first step with a dump; `ThinBoxes` cites it; alternative, rename one — declined, two names for one fact; high. (3) *The five lanes (K8-A, K8-M, K8-B, K8-G, K8-S) and lane T's five:* queued for implementers. (4) *The false first draft:* credit; caught before any proof. **Filed:** its two dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit. **Owed to the second filing:** its five `LEAN.md` lines.
> — source: plans/FS131-close-inventory.md

> 815. **FS131-IP23 handed back: the chain's two ports in, the entropy file and the split's first leaf proved (2026-10-14 10:07 UTC by the clock; "JOB FS131-IP23 — DONE"; 531k by the harness's count — past the line, not to be resumed; branch `fs131-wp23` at `28c21407a`, tree `fs131-wq1`; record `plans/FS131-IP23-implementation.md` there).** From its hand-back message: "**The tenth leaf of `Rigidity/Entropy`** … [kernel], axioms `[propext, Classical.choice, Quot.sound]` … `Rigidity/Entropy` now has no `sorry`"; "**The split's first leaf**, `condExpKernel_ergodicDecomposition` … Its proof is the release's `action_ergodic_decomposition` itself"; "**The two ports**, 64 declarations of `[OAIMath2026]` family 015, all kernel-checked here and all on the standard three or fewer … 14 patches, every one a rename on a proof line … READBACK OK"; "No statement changed … PASS, and the reader's control reported 8 of its 8 planted faults"; build 3 exit 0, lint 14 of 14, `dupnames` clean; it did not run `scripts/axioms.sh` because the branch carries the declared printed theorem not yet declared to the audit (item 750 ruling 1), and classed every record it added by hand. **My receipt:** from the tree's compiled library under the memory tool (scratch `ip23/Ax.lean`): `ksEntropy_eq_iSup_ksEntropyOn` and `condExpKernel_ergodicDecomposition` — each the standard three. `git merge-tree` of `fs131-wp23` with `fs131-wk8b` (the chain's planning branch): one conflict, `ARCHITECTURE.md`; `Proofs.lean` merges itself. **Rulings.** (1) *Its docstring drafts D5 (prose only):* approved, applied by the next job on this line's branch. (2) *Not running the audit on a branch with an undeclared axiom:* accepted — the audit runs at the chain's landing, where the declared theorem gets its entry; hand classing is the receipt until then; high. (3) *The next job:* the join of the chain's two newest branches and lane T's first lanes (FS131-IT1, item 816).
> — source: plans/FS131-close-inventory.md

**Your work, in order.** (1) **The join**: the merge commit; one build under the slot of the joined tree. (2) **The
move**: `TateModel.sigmaCompactSpace`'s statement from `ThinBoxes` to `TateModel`, text unchanged, the stored
statements of both modules dumped before and after (the moved one IDENTICAL, now in `TateModel`; nothing else moved).
(3) **T-I**, `TateModel`'s four derived leaves (`mul_mem_Λ`, `π_eq_π_iff`, `toSAdele_mem_torsionChars`, `isOpenMap`),
`sigmaCompactSpace` with them if `isOpenMap` reads it. (4) **T-L**, `TateLocal`: fold the three proofs closed in the
planner's scratch `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/data/fs131/kt1/scratch/FormG.lean` first, then its other leaves. (5) **T-A**, `TateArch`. (6) **M9-R**, the ring's two leaves on
the model's path. (7) **T-C**, `TateCharacter`, as far as you reach. The plans per leaf: the interface planner's record
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/plans/FS131-KT1-tate.md` § 4.3 (lane T) and § 5.1 (the lanes); the zero-entropy planner's `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/plans/FS131-KN9-chain-zero-entropy.md` § 3 (M9-R); the second-half planner's
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/plans/FS131-K8B1-zero-entropy-second.md` § 6.1 (the collision). The last implementer's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-IP23-implementation.md` is the worked pattern for this chain's files and
holds the docstring drafts D5.

## Done means

1. **The join and the readback** (a saved stage, and the one line to me when the joined tree builds): the quoted lines
   checked against their sources; each leaf's statement restated in one line beside its plan; the stored statements of
   every file you touch dumped from the built joined tree before any edit.
2. **The move** (a saved stage), shown from the kernel's side.
3. **The lanes** (saved stages as leaves fall); re-price what is left of lane T from the first two leaves of each lane
   and say so.
4. **No statement and no definition changed** but the move, shown from the kernel's side against item 1's dump (a
   planted change watched firing); one build under the slot with no warning from your files but their remaining
   leaves'; the axioms of every public declaration of your files printed from the built tree — the standard three, or
   `sorryAx` only through named leaves — each listed, with a planted record watched showing.
5. **Drafts for the landing**, in your record: the audit's block for your files; the models; any `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports; the order inside items 3–7; another route for a leaf where the plan's does not
go through (tell me which). An unread binder of a statement in your files is dropped under item 726's word, listed and
named. Not yours: any other change to a statement or definition; the files listed as not yours; the declared printed
theorem; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 329 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wp23`; the join adds the planning branch's modules, so the
first build compiles them (expect 10–20 minutes). One file through `lake env lean`: 3 to 24 seconds, 3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name itt1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh` from inside the worktree; never `lake build`. On
exit 75 wait ten minutes and retry. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at
power-off: anything your record cites lives under `data/fs131/itt1/`. Report at once any disk, memory or count reading
near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
