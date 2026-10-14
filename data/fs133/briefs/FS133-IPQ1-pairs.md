# Brief FS133-IPQ1 — the density equality's last two leaves: a measurable labelling admissible almost everywhere, and back

*Written 2026-10-14 07:07 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS133-IPQ1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: an implementer on a planned module of eight files, after five who proved all of it but two leaves — you take those two, which together are the module's claim about labellings by pairs, in both directions
  launch: now, in the tree the last implementer handed back, on a new branch cut from its head; the port of the outside release, which this module's landing waits on, runs in `fs132-wi1`; the chain's planner works in `fs131-wch`; the build slot is shared
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if a lemma the route needs is larger than one long stage (say which and its price before you build it), and if a record the plan's § 5.5 lists on the standard three alone prints the declared import; the report goes to `data/fs133/reports/FS133-IPQ1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS133-IPQ1-implementation.md` (new, on branch `fs133-wpq`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1` on a **new branch `fs133-wpq`** that you cut from its head (`b84e09ef8`; its build is current for that commit): `Proofs/HadwigerNelson/Plane/OneClass/Pair.lean` — **proofs and private helpers only, no statement changes**; new lemmas the route needs (the two pieces named below) in `Pair.lean` as private helpers, or as public lemmas in a new module under `Proofs/HadwigerNelson/Plane/OneClass/` with its lines in the build's lists and `ARCHITECTURE.md` if another file would read them; `plans/FS133-IPQ1-implementation.md`; `data/fs133/ipq1/`; `data/fs133/reports/FS133-IPQ1.md`. Nothing on `main`; nothing in the module's other files
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. This module is the density equality for the real plane, and as of the last implementer's hand-back its
headlines have nothing unproved beneath them, resting on the standard three axioms and one declared theorem of the
outside release that the port is turning into a theorem. What is left is its second claim, about labellings of the
plane by a finite set of labels with forbidden pairs at unit distance: two leaves, one each way.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The module passes the gate whole or not at all: until these two leaves are proved, it cannot land, and the density
equality with it.

## The statements

The claim these two leaves prove, and what it does not claim, from the claim list fixed before the module was planned:

> K133-PAIR: (entry at line 649 of the derivation file) an admissible `ℓ : ℝ² → Λ` exists if and only if a Lebesgue-measurable `ℓ : ℝ² → Λ` admissible almost everywhere exists; and an admissible `ℓ : ℝ² → Λ` exists if and only if an admissible `ℓ : E → Λ` exists
> — source: data/fs133/claims-K1.md § Statements

> K133-NC-PAIR: any constraint on three or more points (a monochromatic unit triangle, say) — it is a third moment, and nothing here addresses it; any distance that is not algebraic (the forward direction reads only `E`, where such a constraint is empty); infinitely many labels; that the measurable labelling resembles the one started from; a measurable labelling admissible at **every** pair (for colourings that is `χ_m` against `χ_m⁰`, FS103-M-D, a GAP)
> — source: data/fs133/claims-K1.md § Not claimed

The last implementer's hand-back as I logged it, with my rulings (ruling 1 is this job):

> 779. **FS133-ICD1 handed back: the density equality's headlines have nothing unproved beneath them (2026-10-14 10:25 UTC logged; "JOB FS133-ICD1 — STAGE 4 SAVED"; 485k by the harness's count — not to be resumed; branch `fs133-wcd` at `b84e09ef8`, tree `fs133-wk1`; record `plans/FS133-ICD1-implementation.md` there).** From its hand-back message: "Lane C is finished and lane D is not. 11 of the 13 leaves are proved in the kernel, and no statement changed … In `Pair`, Q4 and Q5 are still `sorry` and were not started"; "the headlines now have no `sorry` beneath them, each on Std + RF: K133-ONE, first line: α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²) … second line: χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²) … C133-FN: f(n)/n → m₁(ℝ²)"; "C133-PAIR is not landed"; "92 stored statements compared … 89 are identical; the 3 made public keep identical stored types"; "all 125 records of the module match plan § 5.5. 110 rest on Std, 11 on Std + RF, and 4 (the open Q4/Q5 records) on `sorryAx`"; a correction owed (an import of `Mathlib.Analysis.Subadditive` not named by the plan; no stored statement moved); a tool note (a `simp only` generated `Subadditive.lim.congr_simp`, replaced by `rw`); Q4 and Q5 "priced at one to two long stages each … Q5 needs two new pieces: a density-point lemma for two sets at radius r; an extension lemma (Rado selection) for a pattern of forbidden label pairs". **My receipt:** from the tree's compiled library under the memory tool (scratch `icd1/Ax.lean`): `OneClass.finIndepRatio_plane_eq_mOne : (unitDistance ℂ).finIndepRatio = Plane.mOne` and `OneClass.fractionalChromaticNumber_plane : (unitDistance ℂ).fractionalChromaticNumber = Plane.mOne⁻¹`, each on the standard three and `Outside.OAI158.Spectral.residual_fourier`; `mOne_le_finIndepRatio` on the standard three. As reported. (The memory tool waited once for room, "ledger 20 + 4 > budget 22 GiB" — its budget, not the machine's: 27 GB of 31 were available.) **What this is:** ledger row 129's plane clause — the largest density of a set with no two points at distance one is the same for arbitrary and for measurable sets, and the plane's fractional chromatic number is one over it — in the kernel, on one declared outside theorem the port is turning into a theorem; not on `main`, not through the gate; the claim list's *not claimed* holds (nothing beyond `1/7 ≤ m₁(ℝ²)` about the value). **Rulings.** (1) *Q4 and Q5:* a fresh implementer in this tree when the next slot frees (the module's landing waits on the port, about 12–20 hours of lanes, so they have slack); its brief carries the two new pieces as planned leaves, and if either is larger than a stage the implementer says so first; alternative, land the module without `Pair` — declined, the module passes the gate whole or not at all, and C133-PAIR is in its claim list; high. (2) *The unnamed import:* accepted (no statement moved); the landing's ARCHITECTURE cell draft carries it. (3) *The `congr_simp` tool note:* for the joins — `dupnames.sh` runs before every audit at a join (the recipe's step 6), which catches it. **For Kooshi's report — the night's headline result, at its grade:** the density equality is proved in the kernel modulo one declared theorem of the outside release, which the port is removing; it answers the first clause of `[DuczVarga2026]`'s Conjecture 1 and `[MatolcsiEtAl2025]` §2's question; it is not yet merged or through the gate.
> — source: plans/FS131-close-inventory.md

**Your two leaves** are the `sorry`s of `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/Proofs/HadwigerNelson/Plane/OneClass/Pair.lean`: **Q4** `exists_measurable_admissibleAe` (in the last implementer's
words, "admissible on `E` gives a labelling with Borel fibres admissible a.e.") and **Q5**
`exists_admissibleOn_of_ae` ("null-measurable fibres admissible a.e. give a labelling admissible at every pair"). Their statements are the file's; read them in the source. **The plan**: `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/plans/FS133-kernel-plan.md` § 5.4 (lane D) and § 5.5
(which records rest on the standard three alone); the last implementer's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/plans/FS133-ICD1-implementation.md` (its table in § 1 restates
both leaves beside their routes; its § 4.5 prices them and names what Q5 needs that the library lacks: a density-point
lemma for two sets at radius `r`, and an extension lemma for a pattern of forbidden label pairs — the library's
`exists_proper_ae_eq_of_proper_on_conull` concludes only `f x ≠ f y`). The derivation: `plans/FS133-E1-derivation.md`
(the entry for C133-PAIR).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; both leaves restated in one line
   beside the plan's route; `Pair`'s stored statements dumped from the built tree before any edit.
2. **Q4** (a saved stage); re-price Q5 from it and say so.
3. **Q5** (saved stages), with its two new pieces stated and proved; if either is larger than one long stage, tell me
   before you build it.
4. **No statement changed**, shown from the kernel's side against item 1's dump (the instrument
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/tools/fs133_ib2_moved.py` is the pattern; a planted change watched firing); no `sorry` left anywhere in the
   module; one build under the slot with no warning from `Pair`; the axioms of every public declaration of the module
   printed from the built tree, each matching its list in the plan's § 5.5, with a planted record watched showing.
5. **Drafts for the landing**, in your record: the audit's lines for C133-PAIR's records (the last implementer's
   draft block names four to file once these are proved); the model for each new hypothesis; the front-page sentence
   for C133-PAIR at its grade, with what is not claimed.
6. The report in the standing rules' form. Leave no process running or queued. Say whether this tree's compiled
   library is still needed after you (the landing will want it).

## What is yours to decide

The proofs; private helpers or a new module for the two pieces; another route for a leaf where the plan's does not go
through (tell me which). An unread binder of a statement in `Pair` is dropped without asking, listed in your
statement check as a ruled difference, and named in your report (the standing word of item 726). Anything else about
a statement comes to me first.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with only small modules stale about 7 to
13 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ipq1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. On exit 75 wait ten
minutes and retry. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off:
anything your record cites lives under `data/fs133/ipq1/`. Report at once any disk, memory or count reading near its
limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
