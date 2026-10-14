# Brief FS131-ITK1 — the five-colour chain: the adelic model finished, then the zero-entropy side's second half proved

*Written 2026-10-14 12:25 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-ITK1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the chain's implementer — lane T's last lane (the kernel of the adelic model's map, its surjectivity and its cocompactness, four leaves the existence of the model waits on), then the five lanes of the zero-entropy side's second half (place sizes, multipliers, thin boxes with Lemma 3.1′, the global point, the wandering shells) over the model, as far as you reach
  launch: now, in the last implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; four other jobs run in other trees (the port's landing, the class-ratio certificates, the density bound's planner) and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, and with one line when `exists_tateModel` prints the standard three; the report goes to `data/fs131/reports/FS131-ITK1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-ITK1-implementation.md` (new, on branch `fs131-wt2`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1` on a **new branch `fs131-wt2`** that you cut from its head (`fs131-wt1` at `72c8520a7`; its build is current for that commit): **proofs, private helpers and import lines only — no statement changes, no definition changes** — in `Proofs/HadwigerNelson/Rigidity/TateKernel.lean`, `PlaceSizes.lean`, `Multipliers.lean`, `ThinBoxes.lean`, `GlobalPoint.lean` and `WanderingShells.lean`; their `ARCHITECTURE.md` rows where a cell's state changes; your checks under `tools/` named for this job; `plans/FS131-ITK1-implementation.md`; `data/fs131/itk1/`; `data/fs131/reports/FS131-ITK1.md`. **Not** `ZeroEntropyClosed.lean` (a composition, proved), `ChainAtTA.lean`, `RingScope.lean`'s `unitRing_eq_stableIntegers` (off the path), any module under `Outside/`, the declared printed theorem. Untracked files from older jobs are in this tree (`data/fs131/iq1/stmt/`, plain-text dumps under `data/fs131/idg1/`, `ig1/`, `ip23/`, `itt1/`): leave them. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. The adelic model the zero-entropy side reads is one lane from done: its last implementer proved twenty-nine
leaves and left four, all in the kernel of the model's map. The zero-entropy side's second half is typed over it, with
its shells on a short route the last planner found. You finish the model and prove the second half.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

With these lanes proved, the chain's zero-entropy half — every zero-entropy rotation-invariant measure is carried by the
smaller set — holds over every real number field on the standard three, if its planner's reading holds in the kernel.

## The statements

The two dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what the second half now is:

> - 2026-10-14 — **M8b's parts 2–4 are typed over `TateModel F`, and EF_F⁺ is stated with no scope (FS131-K8B1).** Lemma PF, Step 0, the multipliers `(1 + 2bi)/(1 − 2bi)`, the thin boxes and Lemma 3.1′ (EN2-L31 word for word, its part (iii′) over EN2-ZE as typed), the pigeonhole, two scales, the global point, the leaves and the shells, in five modules (`Rigidity/PlaceSizes`, `Multipliers`, `ThinBoxes`, `GlobalPoint`, `WanderingShells`); their composition `Rigidity.zeroEntropyCarried_of_tateModel (D : TateModel F) : ZeroEntropyCarried F` is proved from the leaves, and with `exists_tateModel` gives `Rigidity.zeroEntropyCarried_of_numberField (F) [NumberField F] : ZeroEntropyCarried F` (`Rigidity/ZeroEntropyClosed`). No step reads `NoRamifiedStableDyadic F` or `R = O′`: once the leaves land, EF_F⁺ holds over every real number field (a plan, one mind; the kernel is its test).
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **EF_F⁺'s Steps 6–7 on a shorter route (FS131-K8B1; a plan, one mind).** The lift of a point of a leaf `π(ι t + W_{v*})` is unique (`ι(L) ∩ W_{v*} = 0`), so the shells `π(ι t + {a ∈ W_{v*} : |a_w|_w = c})`, `c > 0`, wander under `rot g` for any unit vector `g` with `|g|_w < 1` — `g = γ/γ̄`, `γ ∈ 𝔓_w ∖ σ𝔓_w`, no class number — and a finite invariant measure makes `rot g` conservative: every shell is null. Finite `U`-orbits on `L/Λ`, the stabiliser `U_t`, the measure `ν_t` and the Borel isomorphism `φ_t` leave EF_F⁺'s inputs. Step 0 reads no product formula (integral or not, then Kronecker).
> — source: data/fs131/claims-NF2.md § Dated lines

The three hand-backs behind this job, as I logged them (their words in quotation marks, the rulings mine):

> 799. **FS131-KT1 handed back: the adelic model's interface typed, lane T planned and priced (2026-10-14 14:20 UTC logged; "JOB FS131-KT1 — DONE"; 501k by the harness's count — past the line, not to be resumed; branch `fs131-wkt` at `392fc2b62`, tree `fs131-wch`; record `plans/FS131-KT1-tate.md` there).** From its hand-back message: "`Rigidity.TateModel F` is typed … The five facts are nine fields … No model of the structure exists short of the construction itself; `exists_tateModel` supplies one"; the two forms of the local character measured — "Form G (global, by approximation): 72 lines, both leaves closed … Form L (local trace): 53 lines closed, one leaf open … form L then needs three inputs absent at the pin … Form G is chosen"; "lane T is typed to its leaves on form G: 34 leaves, all elaborated, with a plan per leaf and 56 Mathlib names checked at the pin"; "the price is about 1,050 lines and about two agent-days of implementer work, about one day of wall time with three lanes running at once"; fact 3's `O′ ⊆ Λ` (item 796 ruling 2's condition) "is the cheapest field … about ten lines", so the interface does not change; a shorter route for `O′^⊥ ⊆ L` with which "the inverse different, the local traces, strong approximation and Lusin–Souslin all leave lane T's inputs"; KN9's price ("several days, two to four thousand lines") replaced by this measured one; build 2 exit 0, lint passed. **My receipt:** the seven commits exist; from its compiled tree under the memory tool (scratch `kt1/Ax.lean`): `exists_tateModel : ∀ (F : Subfield ℝ) [NumberField ↥F], Nonempty (TateModel F)`, its axioms the standard three and `sorryAx` (a skeleton, as reported); `TateModel.mem_TA` the same through the interface's leaves. **Rulings, four parts each.** (1) *Lane T's lanes (T-I, T-L, T-A, T-C, T-K):* queued for implementers, T-I first (M8b's parts read `isOpenMap` and `π_eq_π_iff`); no axiom for Tate's duality — formalized at its measured price; high. (2) *The next slot:* the planner of M8b's parts 2–4 over the interface (FS131-K8B1, item 800); alternative, the ports P2 and P3 (promised at items 790 and 792) — declined once more for this slot: M8b's parts 2–4 are unplanned and on the longest path, while P2 and P3 are hours that block only the split's first leaf; the port's landing, when its last implementer hands back, takes the following slot, and P2 and P3 the one after; medium-high. **Filed:** its two dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit. **Owed to the second filing:** its four `LEAN.md` lines. **For the record of what Mathlib holds:** no adelic duality at the pin (KN9 § 4.3, KT1 § 2.6).
> — source: plans/FS131-close-inventory.md

> 811. **FS131-K8B1 handed back: the zero-entropy side's second half typed over the adelic model, with no scope (2026-10-14 09:54 UTC by the clock; "JOB FS131-K8B1 — DONE"; 505k by the harness's count — past the line, not to be resumed; branch `fs131-wk8b` at `fec557c9a`, tree `fs131-wch`; record `plans/FS131-K8B1-zero-entropy-second.md` there).** From its hand-back message: "M8b's parts 2–4 typed to their leaves over `TateModel F` — five new modules (`Rigidity/PlaceSizes` 23 leaves, `Rigidity/Multipliers` 6, `Rigidity/ThinBoxes` 14, `Rigidity/GlobalPoint` 11, `Rigidity/WanderingShells` 7)"; "Lemma 3.1′ is `TateModel.thinBox_heavy`, EN2-L31 word for word … its part (iii′) `exists_heavy_nameCells` is proved in three lines over the typed EN2-ZE"; "`zeroEntropyCarried_of_numberField (F) [NumberField F] : ZeroEntropyCarried F := (exists_tateModel F).elim zeroEntropyCarried_of_tateModel`"; "`NoRamifiedStableDyadic F` is read by no step"; the wandering-shells route (item 806); "one first-draft statement false, caught before any proof: `exists_orbit_box` needs `0 < n`"; a name collision ahead (`TateModel.sigmaCompactSpace` stated in `ThinBoxes`, needed by lane T-I in `TateModel`); five lanes priced at "about 1,600–1,900 lines, about two and a half agent-days"; and a slip of mine (item 812). **My receipt:** from its compiled tree under the memory tool (scratch `k8b1/Ax.lean`, `Ax2.lean`): `zeroEntropyCarried_of_numberField : ∀ (F : Subfield ℝ) [NumberField ↥F], ZeroEntropyCarried F` — no scope binder, its axioms the standard three and `sorryAx` (a skeleton); `Rigidity.exists_heavy_nameCells` — the standard three alone, since lane N's EN2-ZE is proved on this branch's ancestry (my first probe named it under `TateModel`, its wrong namespace; read with its import list and found in `ThinBoxes` l. 152). **Rulings, four parts each.** (1) *Moving `zeroEntropyCarried` and its two readers out of `Rigidity/ChainAtTA` into `Rigidity/ZeroEntropyClosed`, the scope binder dropped:* approved for the chain's landing, with `entropySplit`'s move (item 761 ruling 5), by the unread-binder rule, each stored statement dumped before and after; alternative, keep the binder at the headline — declined, the rule drops it and the theorem without it is stronger; high. (2) *The `sigmaCompactSpace` collision:* the statement moves now, before either is proved, from `ThinBoxes` to `Rigidity/TateModel` (upstream of both readers), by the first lane T implementer as its first step with a dump; `ThinBoxes` cites it; alternative, rename one — declined, two names for one fact; high. (3) *The five lanes (K8-A, K8-M, K8-B, K8-G, K8-S) and lane T's five:* queued for implementers. (4) *The false first draft:* credit; caught before any proof. **Filed:** its two dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit. **Owed to the second filing:** its five `LEAN.md` lines.
> — source: plans/FS131-close-inventory.md

> 829. **FS131-ITT1 handed back: the chain's branches joined, lane T's first lanes and M9-R proved (2026-10-14 11:35 UTC; "JOB FS131-ITT1 — DONE"; 620k by the harness's count — past the line, not to be resumed; branch `fs131-wt1` at `72c8520a7`, tree `fs131-wq1`; record `plans/FS131-ITT1-implementation.md` there).** From its hand-back message: the join (merge `432600f15`, one conflict resolved by rows), the move ("Lean's hash of the statement is equal"), "**The 29 leaves** are kernel theorems on axioms ⊆ `[propext, Classical.choice, Quot.sound]`" — T-I (5, `sigmaCompactSpace` among them "with no Tate model"), T-L (6), T-A (3), T-C (13), M9-R (2: `exists_mul_stableIntegers_le`, `dense_mixedEmbedding_nsmul_unitRing`); "`exists_tateModel` now reaches `sorry` only through four `TateKernel` leaves"; "Every lane came in at 0.5–0.75 of its planned lines. What is left of lane T is T-K: 9 leaves, about 300 lines"; a generated public constant `archTrace.congr_simp` caught by its dump and removed; build 6 green, lint 14 of 14, `dupnames` OK, architecture passes. **My receipt:** from the tree's compiled library (scratch `itt1/Ax.lean`): `TateModel.sigmaCompactSpace`, `exists_mul_stableIntegers_le`, `continuous_tateChar` — each the standard three. **Rulings.** (1) *The unused move of `countable_splitPlace`:* not wanted (item 822). (2) *The audits not run on a branch with the undeclared printed theorem:* accepted as at item 815. (3) *Re-pricing at half to three quarters of the planned lines:* logged as evidence for the chain's estimate — the planners' line counts run high. (4) *The next chain implementer:* T-K and the M8b lanes when a slot frees; this slot goes to the density bound by Kooshi's word (item 830).
> — source: plans/FS131-close-inventory.md

**Your leaves**, in order: (1) **T-K**, the nine leaves of `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/Proofs/HadwigerNelson/Rigidity/TateKernel.lean` (the plan: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/plans/FS131-KT1-tate.md` § 4.2–4.3; the last
implementer's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-ITT1-implementation.md` names the four `exists_tateModel` waits on). (2) **The five M8b lanes** (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/plans/FS131-K8B1-zero-entropy-second.md` § 6.1, a plan
per leaf in its §§ 2–4): K8-A `PlaceSizes`, K8-M `Multipliers`, K8-B `ThinBoxes`, K8-G `GlobalPoint`, K8-S `WanderingShells`,
in the order § 6.1 gives. The last implementer's record is the worked pattern for this chain's files.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; each leaf's statement restated in one
   line beside its plan; the stored statements of your six files dumped from the built tree before any edit.
2. **T-K** (a saved stage, and the one line to me when `exists_tateModel` prints the standard three).
3. **The M8b lanes** (saved stages as leaves fall); re-price what is left from the first two leaves of each and say so.
4. **No statement and no definition changed**, shown from the kernel's side against item 1's dump (a planted change
   watched firing); one build under the slot with no warning from your files but their remaining leaves'; the axioms of
   every public declaration of your files printed from the built tree, each listed, with a planted record watched showing;
   and whether `zeroEntropyCarried_of_numberField` now prints the standard three.
5. **Drafts for the landing**, in your record: the audit's block; the models; any `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports; the order inside the M8b lanes; another route for a leaf where the plan's does not
go through (tell me which). An unread binder of a statement in your files is dropped under item 726's word, listed and
named. Not yours: any other change to a statement or definition; the files listed as not yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 316 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with small modules stale about 7 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name itk1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. The certificate job may hold
12 GiB of the slot for long stretches: on exit 75 wait ten minutes and retry. Stop a process by its PID, never by matching
its command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/itk1/`. Report at once
any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
