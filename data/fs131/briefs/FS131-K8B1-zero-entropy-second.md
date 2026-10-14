# Brief FS131-K8B1 — the five-colour chain: the zero-entropy side's second half typed to its leaves over the adelic model

*Written 2026-10-14 08:54 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K8B1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the eighth planner on this chain
  role: the kernel lane's planner for M8b's parts 2–4 — thin boxes and Lemma 3.1′, the pigeonhole and the global point, the leaves and the wandering shells — typed to their leaves over the interface `TateModel F` the last planner typed, ending at `zeroEntropyCarried`, the chain's leaf that says a zero-entropy rotation-invariant measure is carried by the smaller set
  launch: now, in the last planner's tree (its job is finished) on a new branch cut from its branch; the chain's pieces implementer works in `fs131-wq1`, the port's last implementer in `fs132-wi1`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect anywhere in the chain, if a typed statement of another module must change (the interface included), if a classical input none of the chain's lists names is needed, and if `zeroEntropyCarried`'s hypothesis `NoRamifiedStableDyadic F` turns out to be read by your plan after all (item 788's ruling keeps it until the proof shows it unread); the report goes to `data/fs131/reports/FS131-K8B1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-K8B1-zero-entropy-second.md` (new, on branch `fs131-wk8b`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch` on a **new branch `fs131-wk8b`** that you cut from its head (`fs131-wkt` at `392fc2b62`; its build is current for that commit): new modules under `Proofs/HadwigerNelson/Rigidity/` with their lines in the build's lists and `ARCHITECTURE.md`; the draft claim list `data/fs131/kn3/claims-M8-zero-entropy-carried.md` where your plan changes it (old text kept in git); `plans/FS131-K8B1-zero-entropy-second.md`; `data/fs131/k8b1/`; `data/fs131/reports/FS131-K8B1.md`. **Not** any typed statement of another module — `Rigidity/TateModel.lean` and lane T's modules, `Rigidity/ZeroEntropyNames.lean`, `Rigidity/RingScope.lean`, `Rigidity/ChainAtTA.lean` (where `zeroEntropyCarried`'s statement lives; it is read, its proof's home is yours to propose) — the declared printed theorem, any module under `Outside/`. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage; save a stage (a commit on your branch) after the readback, after each part's statements, and after each few leaves' plans

Hello. Two planners decided the zero-entropy side's second half in words, and the last one typed the interface to the
adelic model it reads and planned the model's construction at two agent-days. The interface is there so that you can
type the half that reads it now, beside the construction. You do.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

This half is the last unplanned stretch of the chain's measure rigidity: with it typed, every module from the solenoid
to `MRPlus F` has statements an implementer can take.

## The statements

The leaf of the chain's claim list (`data/fs131/claims-NF2.md`) this half carries, and the three dated lines that say
what it now reads:

> NF2-LEAF-21: EF_F⁺ (D:162): the model of the dual as `𝔸_𝒮/D` (FS105:76, FS105-B-M1; X01D § 2.0, :113); Lemma PF, the product-formula gap (X01D:208; Mathlib has the product formula, `NumberField.prod_abs_eq_one`); an expanding place (X01D § 3.2, :214); Lemma 3.1′ (X01D:226); Lemma 3.2′ (a), the pigeonhole with the rational unit vectors as multipliers (X01D § 3.4, :246) over the height count (FS105:106, :110); two scales and one global point (X01D § 3.5–3.6); leaves (§ 3.7); wandering shells (§ 3.8, :301; FS105:86).
> — source: data/fs131/claims-NF2.md

> - 2026-10-14 — **NF2-LEAF-21's height count is replaceable (FS131-KN8).** Lemma 3.2′(a)'s pigeonhole needs `#V_M ≥ c·M^{α′}` for some `α′ > 0` only (its `β` is chosen after `α′`); `z = 1 + 2bi` gives `α′ = 1/(2[F:ℚ])` with no Pythagorean count.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **EF_F⁺ on a weaker reading of the ring (FS131-KN9; a reading, one mind; the kernel is its test).** X01D's model, Lemma PF, the pigeonhole and Step 6's finite orbits read `R` only through `R ⊆ O′` (FS91-J10-L1 (c)) and `c·O′ ⊆ R` for an integer `c ≥ 1` (FS91-J10-L1 (e)), both over every real number field. If M8b's proof is written so (the coordinator's ruling: it is planned so), EF_F⁺ and MR⁺ hold over every real number field, NF2-MRPLUS-SCOPE (a)'s GAP at row 100's exception fields closes, and `R = O′` (Lemma C′) leaves the headline's path unless module M12 reads it; the class `L ≥ 5` is inside the scope either way.
> — source: data/fs131/claims-NF2.md § Dated lines

> - 2026-10-14 — **The model of the dual is typed as an interface, `Rigidity.TateModel F` (FS131-KT1).** `W = L_∞ × ∏′_{w split} L_w` (`Rigidity.SAdeleRing`, the archimedean factor Mathlib's mixed space) and a continuous `π : W → R̂`, equivariant for the unit vectors, onto, with kernel on the diagonal, `O′ ⊆ Λ ⊆ d⁻¹O′`, `W = K + O′` with `K` compact, and `π(L_∞) ⊆ A`; `π(L + L_∞) ⊆ T + A`, `Λ`'s `R`-stability and the openness of `π` are theorems over it. M8b-2..4 are proved over `(D : TateModel F)`; its existence is `Rigidity.exists_tateModel` (lane T). A typed interface, not a theorem.
> — source: data/fs131/claims-NF2.md § Dated lines

The two hand-backs behind this job, as I logged them (their words in quotation marks, the rulings mine):

> 791. **FS131-KN9 handed back: M5 and M9 typed and planned, M8b decided in words (2026-10-14 12:45 UTC logged; "JOB FS131-KN9 — DONE"; 531k by the harness's count — past the line, not to be resumed; branch `fs131-wk9` at `aee998a46`, tree `fs131-wch`; record `plans/FS131-KN9-chain-zero-entropy.md` there).** From its hand-back message: "**M5 is typed and planned** … A new module, `Rigidity/EntropyFibres` (9 leaves) … `Rigidity/PositiveEntropy` (10 leaves, `haar_or_zero_entropy` last)"; "**`haar_or_zero_entropy` no longer takes `[PolishSpace X]`** … The kernel's dump shows exactly that binder removed and nothing else changed … The statement is again FS131-KN7's, character for character"; "**M9 is typed in a new module, `Rigidity/RingScope`** … R ⊆ O′, proved; c·O′ ⊆ R, over every real number field; R = O′ in the scope: typed, off M8b's path, planned in words only"; "**M8b is decided in words, not typed** … I recommend packaging it as a structure `TateModel F`: the five facts M8b reads"; "Tate's duality: Mathlib at the pin has none of it … I recommend formalizing it as lane T, with a planner first. My price, from Mathlib's state and not from an elaborated leaf: several days, two to four thousand lines"; "Strong approximation and Lusin–Souslin: not needed on the routes chosen"; builds 1–4 exit 0, lint passed; an architecture cell failure inherited from the join (fixed on `fs131-wdg` by FS131-IDG1). **My receipt:** the six commits exist; from its compiled tree under the memory tool (scratch `kn9/Ax.lean`): `haar_or_zero_entropy`'s binders read `[AddCommGroup X] [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X]`, no `PolishSpace`; `unitRing_le_stableIntegers` on the standard three. **Rulings, four parts each.** (1) *The `TateModel F` interface:* approved — a structure whose fields are exactly the five facts of its record § 4.1 that M8b reads, each stated as X01D states it, quantifying over nothing of ours beyond what X01D reads; its existence is lane T's leaf; M8b's records print `sorryAx` through it until lane T lands; it is typed first by the next planner (FS131-KT1, item 792) so that lane T and M8b's parts 2–4 can run beside each other; alternative, M8b typed straight over a construction — declined, it serializes the longest stretch of the chain; high. (2) *Lane T, Tate's duality:* **formalize**, a planner first (the same job, after the interface), measuring both forms of the local character on its first two leaves and pricing from them; no axiom declared; if priced over a week, a message to me first; alternative, declare it now from `[Tate1950]` — declined (W2; "when unsure, formalize"); high. (3) *`noRamifiedStableDyadic_of_tca` (lane M9-S):* proved in place in `Rigidity/ChainAtTA` by an implementer, a proof only, off the headline's path; medium-high. (4) *M12's question (does T-C(A) read `R = O′`, or only Lemma C (d)):* carried to M12's planner. (5) *The `Pieces` docstring line:* sent to FS131-IG1 as its Amendment 1. **Filed this commit:** its four dated lines in `data/fs131/claims-NF2.md`, verbatim; two `BIBLIOGRAPHY.md` rows, `[Tate1950]` and `[Weil1967]`, from its drafts (not held, not read; `tools/bib_audit.py` passes). **Owed to the second filing:** its four `LEAN.md` lines. **The chain's ready implementer lanes now:** M5-E, M5-P, M9-R, M9-S, P2, P3 (and S after G, P2, E).
> — source: plans/FS131-close-inventory.md

> 799. **FS131-KT1 handed back: the adelic model's interface typed, lane T planned and priced (2026-10-14 14:20 UTC logged; "JOB FS131-KT1 — DONE"; 501k by the harness's count — past the line, not to be resumed; branch `fs131-wkt` at `392fc2b62`, tree `fs131-wch`; record `plans/FS131-KT1-tate.md` there).** From its hand-back message: "`Rigidity.TateModel F` is typed … The five facts are nine fields … No model of the structure exists short of the construction itself; `exists_tateModel` supplies one"; the two forms of the local character measured — "Form G (global, by approximation): 72 lines, both leaves closed … Form L (local trace): 53 lines closed, one leaf open … form L then needs three inputs absent at the pin … Form G is chosen"; "lane T is typed to its leaves on form G: 34 leaves, all elaborated, with a plan per leaf and 56 Mathlib names checked at the pin"; "the price is about 1,050 lines and about two agent-days of implementer work, about one day of wall time with three lanes running at once"; fact 3's `O′ ⊆ Λ` (item 796 ruling 2's condition) "is the cheapest field … about ten lines", so the interface does not change; a shorter route for `O′^⊥ ⊆ L` with which "the inverse different, the local traces, strong approximation and Lusin–Souslin all leave lane T's inputs"; KN9's price ("several days, two to four thousand lines") replaced by this measured one; build 2 exit 0, lint passed. **My receipt:** the seven commits exist; from its compiled tree under the memory tool (scratch `kt1/Ax.lean`): `exists_tateModel : ∀ (F : Subfield ℝ) [NumberField ↥F], Nonempty (TateModel F)`, its axioms the standard three and `sorryAx` (a skeleton, as reported); `TateModel.mem_TA` the same through the interface's leaves. **Rulings, four parts each.** (1) *Lane T's lanes (T-I, T-L, T-A, T-C, T-K):* queued for implementers, T-I first (M8b's parts read `isOpenMap` and `π_eq_π_iff`); no axiom for Tate's duality — formalized at its measured price; high. (2) *The next slot:* the planner of M8b's parts 2–4 over the interface (FS131-K8B1, item 800); alternative, the ports P2 and P3 (promised at items 790 and 792) — declined once more for this slot: M8b's parts 2–4 are unplanned and on the longest path, while P2 and P3 are hours that block only the split's first leaf; the port's landing, when its last implementer hands back, takes the following slot, and P2 and P3 the one after; medium-high. **Filed:** its two dated lines in `data/fs131/claims-NF2.md`, verbatim, this commit. **Owed to the second filing:** its four `LEAN.md` lines. **For the record of what Mathlib holds:** no adelic duality at the pin (KN9 § 4.3, KT1 § 2.6).
> — source: plans/FS131-close-inventory.md

Where everything is: the zero-entropy planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/plans/FS131-KN9-chain-zero-entropy.md` § 4.2 (parts 2–4 decided over the model, on the weaker
reading) and § 4.4 (what you inherit); the interface planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/plans/FS131-KT1-tate.md` § Stage 2 (the nine fields, what `Λ` is,
what is proved over the interface) and § 4.1–4.2; the interface `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/Proofs/HadwigerNelson/Rigidity/TateModel.lean`; the names already typed and proved
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/Proofs/HadwigerNelson/Rigidity/ZeroEntropyNames.lean` (EN2-ZE, Lemma 3.1′'s part (iii)); `zeroEntropyCarried`'s statement in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/Proofs/HadwigerNelson/Rigidity/ChainAtTA.lean`;
the draft claim list `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/data/fs131/kn3/claims-M8-zero-entropy-carried.md`; the derivations
`plans/FS100-X01D-derivation.md` §§ 3.1–3.8 and `plans/FS131-EN2-derivation.md` (EN2-L31).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the three parts restated from the
   zero-entropy planner's § 4.2 with what each reads of the interface, field by field.
2. **Part 2, thin boxes and Lemma 3.1′** (a saved stage): typed with `sorry` at the leaves only, Lemma 3.1′'s part (iii)
   over the typed EN2-ZE word for word, each statement read aloud against X01D or EN2-L31, each with a model, a plan per
   leaf.
3. **Part 3, the pigeonhole and the global point** (a saved stage), on the shorter height input (the second dated line).
4. **Part 4, the leaves and the wandering shells** (a saved stage), ending at a proof of `zeroEntropyCarried`'s
   statement from parts 2–4 and the interface — its home proposed (it sits upstream of the parts in `ChainAtTA`), the
   composition typed with the parts as leaves.
5. **Whether `NoRamifiedStableDyadic F` is read**: by your plan's every step, stated with where; if no step reads it,
   say so — the implementer then drops it under the standing rule.
6. **Lanes**, sharing no file, with what each needs (lane T's leaves among them); **the domain pass as a fresh skill
   invocation on every new definition, and the obligation pass on every new statement.**
7. **Drafts**: dated lines for the claim list; bibliography lines for every source you read or cite; `LEAN.md` lines.
8. The report in the standing rules' form.

## What is yours to decide

How the modules are cut and named; the order of the parts; where the composition lives. Not yours: a declared axiom;
a change to a typed statement of another module (the interface included) without my ruling; proving leaves beyond a
few lines while testing a plan; lane T; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with small modules stale about 7 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name k8b1 -- <command>`

One file: `--mem 4 --cpus 2` from inside your worktree. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8
./scripts/build.sh`; never `lake build`. On exit 75 wait ten minutes and retry; the port's landing may hold the slot for
up to an hour. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your
record cites lives under `data/fs131/k8b1/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
