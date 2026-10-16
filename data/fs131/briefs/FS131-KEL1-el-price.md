# Brief FS131-KEL1 — what would it take to prove Einsiedler–Lindenstrauss Theorem 1.3 in this library? A price from first leaves

*Written 2026-10-16 03:57 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KEL1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you run on Opus
  role: the kernel lane's planner pricing one outside theorem — the library's one declared outside theorem from ergodic theory, `Rigidity.positive_entropy_rigidity` — as a formalization: its proof's tree read from the paper and what it cites, each node set against what Mathlib, this library and the outside release's Lean hold, the top of the tree as a skeleton, the first two leaves attempted, and a price in lines of Lean
  launch: now, in a worktree of your own cut from `main`; beside you a second kernel planner (on another question, in another worktree) and a filing job; none writes a file you write
  mission: § Why this job
  statements: § The theorem
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if the declared statement says more or less than the printed theorem, or if a route around the theorem appears for the library's one use of it; the report goes to `data/fs131/reports/FS131-KEL1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (rules 6 and 13 changed today: never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building
  record: `plans/FS131-KEL1-el-price.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/kel1`, on its branch `fs131-kel1` (cut from `main` at `69dc6b0be`; `.lake/packages` a symlink to the main tree's, `.lake/build` a copy of the main tree's gated build): `plans/FS131-KEL1-el-price.md`; skeleton and leaf modules under `Proofs/HadwigerNelson/` in files you create, each named in your record, and their import lines in `Proofs.lean`; your scripts and outputs under `data/fs131/kel1/`; `data/fs131/reports/FS131-KEL1.md`. Never the declared axiom's module or any existing module (draft edits in your record); nothing in `~/source/math` (read it, never write it). Commit on your branch by explicit path; never push
  budget: about 400k by the harness's count, as guidance; save a stage after each stage below; hand back at a saved stage before about 500k

Hello. Kooshi asked for this price two days ago and it was right to wait until the chain that uses the theorem had
landed; it has, and the repository is public. This is the question of what the last outside theorem under the
number-field results would cost to bring inside.

## Why this job

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The chain landed on 2026-10-15: `χ(ℚ(√47)²) = 5` and the main clause through five (`Rigidity.min_localBound_five_le_chromaticNumber`)
are kernel-checked on the standard three axioms and two declared outside theorems — Weil's bound and this one. Every
measure-rigidity consequence in the library (`Rigidity.mrPlus`, the entropy split) rests on it. A price is a decision input
for Kooshi, not a commitment; the counter-priors in `CLAUDE.md` say formalization effort never ranks a route, and the price
is asked for so he can plan, not so a route is chosen by it.

How a price is computed here — in lines of Lean, converted at the project's measured rate:

> W5: (2026-10-14, at his check-in) Increase staffing cap to  4 consecutive subagents. Weeks are days in agent time, so I'm not too worried about it. Calibrate your estimate at lines of lean added per active hour in the git history. Your lines of lean estimate are often accurate, and this will give a better time estimate. That also determines my answers to those questions.
> — source: data/fs131/REQUEST-2026-10-13.md

> 825. **Kooshi's word at his check-in, the staffing raised, the rate measured, the interim report (2026-10-14 11:21 UTC).** His words, verbatim in `data/fs131/REQUEST-2026-10-13.md` as W5: "Increase staffing cap to  4 consecutive subagents. Weeks are days in agent time, so I'm not too worried about it. Calibrate your estimate at lines of lean added per active hour in the git history. Your lines of lean estimate are often accurate, and this will give a better time estimate. That also determines my answers to those questions." — and, confirmed, "apologies, yes I meant concurrent". **Done:** the staffing rule in `.claude/output-styles/keryx.md` § Staffing rewritten to four slots (his words quoted; the Sonnet half-slot kept), the memory index's line likewise. **The rate, measured** (`git log --all --no-merges --numstat -- Proofs`, an active hour being a clock hour with a commit touching a `.lean` file; ported or generated code under `Proofs/HadwigerNelson/Outside/` excluded; scratch script `rate.py`): last 7 days, 32 active hours, 29,227 net hand-written lines, 913 per active hour; last night since 04:40 UTC, 8 active hours, 6,805 net, 851 per hour (and 20,879 ported); the whole history less five bulk certificate commits, 231 active hours, 196,310 net, 850 per hour. **The estimates from it:** the chain's remaining road about 20,000–34,000 lines (the map's 14,000–28,000 plus my rough 6,000 for the typed and planned lanes) — about 17–38 active hours; the density bound's formalization, the planner's three-to-six weeks converted by me at its own two-thousand-lines-a-week to about 6,000–12,000 lines — about 5–13 active hours. **The interim report** sent in the house format with two decisions for him (the density bound: my recommendation formalize, medium; what to publish before the chain: my recommendation merge the port and the density equality now and publish once when the chain lands, medium).
> — source: plans/FS131-close-inventory.md

And the library's pin, which any port of outside Lean must meet:

> W4: (2026-10-14, at his check-in, after my explanation of the transfer proof and a question of his on upgrading Mathlib) alright, yes to the port, and we'll stay on this version indefinitely. Scheduling the port is up to you.
> — source: data/fs131/REQUEST-2026-10-13.md

## The theorem

The declared statement (its docstring, above it in the module, quotes the page and gives its reading choices):

> axiom positive_entropy_rigidity {X : Type*} [AddCommGroup X] [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X]
>     (hX : IsSolenoid X) {d : ℕ} (hd : 2 ≤ d) (α : ZdAction d X)
>     (hα : α.NoVirtuallyCyclicFactors) (μ : Measure X) (hμ : IsProbabilityMeasure μ) (herg : α.IsErgodicOn ⊤ μ) :
>     ∃ (Λ : AddSubgroup (Fin d → ℤ)) (J : ℕ) (ν : Fin J → Measure X) (G : Fin J → AddSubgroup X),
>       Λ.FiniteIndex ∧ 0 < J ∧ μ = (J : ℝ≥0∞)⁻¹ • ∑ j, ν j ∧ (∀ i j, i ≠ j → ν i ⟂ₘ ν j) ∧
>       ∀ j, IsProbabilityMeasure (ν j) ∧ α.IsErgodicOn Λ (ν j) ∧
>         (IsClosed (G j : Set X) ∧ α.InvariantOn Λ (G j) ∧
>           ∀ g ∈ G j, ∀ B : Set X, MeasurableSet B → ν j ((fun x => x + g) ⁻¹' B) = ν j B) ∧
>         (∀ n : Fin d → ℤ, ∃ k, (ν j).map (α n) = ν k ∧ (G j).map (α n) = G k) ∧
>         ∀ n ∈ Λ, ∀ h : G j ≤ (G j).comap (α n),
>           @ksEntropy (X ⧸ G j) (borel (X ⧸ G j))
>             (@Measure.map X (X ⧸ G j) _ (borel (X ⧸ G j)) (QuotientAddGroup.mk' (G j)) (ν j))
>             (QuotientAddGroup.map (G j) (G j) (α n) h) = 0
> — source: Proofs/HadwigerNelson/Rigidity/PositiveEntropy.lean

The paper, and how much of it this project has read:

> | **[EinsiedlerLindenstrauss2022]** | M. Einsiedler, E. Lindenstrauss, *Rigidity properties for commuting automorphisms on tori and solenoids*, Ergodic Theory Dynam. Systems 42(2) (2022) 691–736, doi 10.1017/etds.2021.74, Zbl 1489.37004, arXiv:2101.11120 (v1 2021-01-26). **Cited in prose as "EL2021"**, its arXiv year (alias in § A′); volume, pages, doi and Zbl from the zbMATH API (C2, 2026-09-26) | p. 3: the solenoid form of Wang's classification "does not seem to have been written"; Manners's lemma is its special case (row 98's prior art); FS-100: its Thm 1.2 (EL2003's Thm 1.1) never applies to a finitely generated subgroup of the unit-vector group on `R̂` itself (row 118), and applies on the finitely generated pieces `M̂` under admissibility — PE-2's positive-entropy input (row 120), resting since FS-105 on its Thm 1.3 plus the deduction FS105-DED [hand, two minds], EL2003's proof being an outline; Thm 1.3 is declared to the kernel as the axiom `Rigidity.positive_entropy_rigidity` (FS131-KN3; read back clause by clause, FS131-KN7 § 3.3), and the five-colour chain's headline and values rest on it and on `[Weil1948]` with FS105-DED and the rest of the chain kernel-checked (FS131-LGT1) | `library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` | read: §§1, 2, 4 in full (X02D, X24R, FS105-R, FS105-D); §7's Lemma 7.4, Cor. 7.6 and the proof of Thm 4.1 from Cor. 7.6 in full (FS105-R); §3.1–3.3, §5 (Thm 5.1), §6 and §7 (Thm 7.1, Lemma 7.2, Prop. 7.5) at their statements; §§8–9 unread (not used by Thm 1.3's proof). Thm 1.2 is not proved in it: it is Thm 1.3 plus FS105-DED. Misprints (harmless): Thm 7.1's "without cyclic factors"; `κ > 0` where Lemma 7.2 gives `≥ 0`. §2 is set-up only, PE-2 and EF_F⁺ not in it; Lemma 4.2 a lift for fixed `ℤ^d` (row 120). §1 first read 2026-09-25 (J23p; FS-89 had the abstract); a re-fetched copy (J51; byte-identical, md5 `1a32060a…`) removed from the repository at `0c61c274`; the advisor's third copy (`data/crunch-2026-09-26-x2x3/poros/el2021-2101.11120.pdf`, the same md5) removed at X10F's stage 4; no copy is in the public history (FS131-PS2); the library's copy, the same bytes, is `pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` |
> — source: BIBLIOGRAPHY.md

The paper is in the document library at `/home/kooshi/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf`. The statement's read-back against the page is
`plans/FS131-KN7-chain-next.md` § Stage 3. The library's own entropy (`Rigidity.ksEntropy`, the pinning theorem
`Rigidity.tendsto_blockEntropy_div`) and the theorem's one consumer are in `Proofs/HadwigerNelson/Rigidity/`. The outside
release `[OAIMath2026]` (cloned at `~/source/math`, Apache-2.0, Lean 4.34.1, a later toolchain than this library's) holds
a Lean folder, `~/source/math/lean/OAI/NumberTheory/DukePrimeDegree/` (886 files), that names conditional entropy for countable
partitions, leafwise measures and steps of Einsiedler–Katok; the stub `plans/STUB-mr-in-lean.md` (FS-113) records what was
known of it on 2026-10-07; the release's earlier ports into this library and their method are `plans/EXT-OAI1-audit.md` and
the `Outside/OAI158*` modules.

## Done means

1. **Stage 1 — the readback.** Check each quotation above against its source; restate in your record the theorem, its
   one use in the library, and what a price must contain.
2. **Stage 2 — the tree.** The proof of Theorem 1.3 as the paper gives it, down to what it cites (its sections, and each
   outside result it invokes, with the citation's own statement found and read where it is held — the document library
   first, then `BIBLIOGRAPHY.md`), as a tree of statements; per node, what Mathlib at this pin, this library and the
   release's Lean hold (by declaration name), and the gap. Name the deepest node and what it needs. A reading status per
   section of every paper you open (standing rule 10), and `BIBLIOGRAPHY.md` rows proposed for what you read.
3. **Stage 3 — two leaves, attempted.** The tree's top as Lean statements with `sorry`, built through `./scripts/build.sh`
   under the slot, and two leaves of your choice proved or taken as far as they go — chosen to calibrate, one from the
   release's port path (if its Lean is usable here) and one written fresh. Their lines and active hours are the price's
   calibration (`CLAUDE.md` § What compute actually helps: re-price from the first two leaves, never from a plan's table).
4. **Stage 4 — the price.** Lines of Lean per node and in total, low and high, with the calibration from stage 3, converted
   at the measured rate; what part is porting the release (at this pin) and what part is new; the order you would build it
   in; and whether a narrower statement suffices for the library's one use (the entropy split at one non-torsion rotation)
   and what it would save. Nothing with a `sorry` reaches `main`; the skeleton stays on your branch.
5. **The report**, in the standing rules' form.

## What is yours to decide

Which leaves calibrate best, the skeleton's shape, whether to price a port of the release's development or a fresh proof
or both, and how deep to read the cited machinery — say where you stopped and why. If the declared statement is stronger
or weaker than the page, or a shorter road to the library's one use exists (a weaker rigidity theorem that the entropy
split could rest on), report it: that is a finding at least as valuable as the price.

## The machine

This is the laptop: 12 cores, 31 GB, shared with another planner. Every Lean build and every `lake env lean` over about 2 GiB
goes through the slot with this machine's settings, from inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 10 --cpus 4 -- env MEMMAX=10G BATCH=4 ./scripts/build.sh`;
never `lake build`. On exit 75 another job holds the memory: wait ten minutes and retry. Never build the release itself
(it is on a later toolchain, v4.34.1, and no build of it exists on this machine); read its sources. `lake env lean` (with
`-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only. `/tmp` is a tmpfs: keep anything your record
cites under `data/fs131/kel1/`.
