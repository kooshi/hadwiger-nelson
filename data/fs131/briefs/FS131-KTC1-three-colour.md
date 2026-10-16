# Brief FS131-KTC1 — three-colourings of lattice Cayley graphs at the kernel: the criterion's converse, periodicity and density — the map, the skeleton and the price

*Written 2026-10-16 13:33 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KTC1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you run on Opus
  role: the kernel lane's planner for one hand result of ours, ledger row 79 (FS-73's three-colour theorem) — its forward half is a kernel theorem; you map the rest against the library, state it in Lean, build the skeleton with `sorry` at every leaf, plan each leaf and price it in lines of Lean
  launch: now, in a worktree of your own cut from `main`; beside you two other jobs (an implementer finishing another module, and a planner of an unrelated theorem), neither of which writes a file you write
  mission: § Why this job
  statements: § The result
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once for a statement defect (the result false or misstated as written) or a generalization; the report goes to `data/fs131/reports/FS131-KTC1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building
  record: `plans/FS131-KTC1-three-colour-plan.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/kel1`, on its branch `fs131-ktc1` (cut from `main` at `99e78e428`; `.lake/packages` a symlink to the main tree's, `.lake/build` a copy of the main tree's build): `plans/FS131-KTC1-three-colour-plan.md`; skeleton modules under `Proofs/HadwigerNelson/` in files you create, each named in your record, and the import lines that bring them into `Proofs.lean`; `ARCHITECTURE.md` rows for your new modules only; your scripts and outputs under `data/fs131/ktc1/`; `data/fs131/reports/FS131-KTC1.md`. Edits to the front files (`CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`, `ROADMAP.md`, `README.md`) and to existing modules are drafted in your record, not made. Commit on your branch by explicit path; never push
  budget: about 400k by the harness's count, as guidance; save a stage after each of the stages below; hand back at a saved stage before about 500k

Hello. Half of this theorem is already in the kernel, built three days ago for the three-colour results about number
fields; the other half is the part that answers the questions people asked in print.

## Why this job

Kooshi's rule for what this project publishes:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The asking lane ranked the project's findings by interest to the field (`plans/POROS-2026-10-13-number-field-findings.md` § 3.2). Of the four above this one,
two are in the kernel, the third is being finished there (all but its density form), and the fourth is planned beside
you. This is its theorem as a reader would look for it:

> - *The theorem.* Let `A` be a finitely generated torsion-free abelian group and `S = −S ⊂ A ∖ {0}` finite. Then
>   `Cay(A, S)` is three-colourable iff some homomorphism `θ : A → ℝ/ℤ` has `θ(S) ⊆ [1/3, 2/3]`, iff it has a
>   three-colouring periodic under a subgroup of finite index; and the periodic three-colourings are dense among all.
> — source: plans/POROS-2026-10-13-number-field-findings.md § 3.3 The first ten, each as the theorem a reader would look for

The objection it must meet, from the same entry:

> - *The first objection.* Ellenberg asked for every `k`; this is `k = 3`, and at four the record has only no-gos. The
>   height lift is Chandgotia's, and "density at the **standard** generators is expected folklore … and not claimed".
> — source: plans/POROS-2026-10-13-number-field-findings.md § 3.3 The first ten, each as the theorem a reader would look for


## The result

Ledger row 79, quoted whole — its kernel sentence says which half is held:

> | 79 | **Three colours are linear: every Cayley graph of a finitely generated torsion-free abelian group is 3-colourable iff a character puts every generator in `[1/3, 2/3]`, its periodic 3-colourings are dense, and forced pairs are exactly what periodic colourings see** (FS-73's competition; the theorems `plans/FS73-derivation.md` T21–T30, T39–T45; the understanding is G71). **[hand; two independent derivations — de Bruijn and Coxeter — read by Poros; the owner checked the two deciding steps]** **Its ⟹ is [kernel] since FS131-LJ1** (standard three), for every abelian group and step set: `ThreeColourCharacter.bandSet_three_nonempty_of_proper`, with `exists_character_of_properAlong`; and at the plane over every subfield of `ℝ`, `fieldBandSet_three_nonempty_of_colorable` and, reading the colouring only on `ℤ[U_F]`, `…_of_colorable_unitRing` (FS73-T22's ⟹ and FS81-T2). The ⟸, the density of periodic colourings and the statement about forced pairs stay [hand]. For `Λ` finitely generated torsion-free and `S = −S` finite generating: **(criterion)** `Cay(Λ, S)` is 3-colourable ⟺ `Θ₃ = {θ ∈ Hom(Λ, ℝ/ℤ) : θ(S) ⊆ [1/3, 2/3]} ≠ ∅` ⟺ it has a periodic (circular) 3-colouring — every 3-colouring has an integer height through `K₃`'s universal cover whose winding is realised by a point of `Θ₃`; **(density)** periodic 3-colourings are dense, so **`P = F` (C3-inherit) and C3-aper hold at three colours for the whole class, with no arithmetic of the lattice**; **(dichotomy)** `F` has finite index ⟺ the colouring space is finite ⟺ every cell of `Θ₃` is a point, and if every point has order 3 every 3-colouring is affine. This answers `[AbrishamiEtAl2025]` Problem 4.6 at `χ = 3` for these graphs, and reproduces `[FourUnitVectors2025]` Thm 1.2 in one line. **[tools, verified + exact] ℚ(√11)'s `Λ₁₀`** (the 36 unit vectors of denominator dividing 10): **`F = P = 3Λ`**, first by FS-58's two forcers (52 and 65 points, both needed) and ten separators (independently verified: drat-trim and exhaustive enumeration), then **derived with no forcer and no solver**: `Θ₃(Λ₁₀)` is exactly 16 isolated points of order 3, so all 48 three-colourings are affine (one orbit) and `F = ⋂ ker φ = 3Λ`; the 100-vector `Λ₅₀` has `F = P = 3Λ₅₀` (replicated, not independently verified). **[cert] The `Θ`-emptiness certificate** — an exact tree with Farkas leaves and a Fraction-only checker that re-enumerates the lattice's unit vectors from its key: FS-61's ℚ(√47) shape is not 3-colourable in 2,997 nodes (653 KB) against a refusing ball's LRAT of tens of MB; `Θ₃` agrees with the solver record on nine lattices and with a transfer-matrix decider on 2,299 rank-1 sets. **ℚ(√167)** (the conjecture's cheapest exposed prediction, ≥ 6, against a proven 3 before this row): **[cert]** `L3e1c94c6` — P2's "no periodic colouring" — has a gapped residue colouring of period 23 at `(23, √167 − 11)`, its 36 unit vectors reaching half the residue circle; 52 of FS-61's 57 lattices carry certified gapped periodic three-colourings and 3 are 3-integral, so **FS-61's null at 167 is explained** — its one ask that could refuse (the one lattice reaching degree 14 under a 2M-point cap, 1,474,541 points, three-coloured in 3.66 s) is a noisy circular colouring (T20), and its reading that 167's 3-non-integral lattices hold too few unit vectors (20–36 against 11's 108) held for the lattices it asked, while its two richest (44 and 60 unit vectors) are the two the screens left open; the residue sets at 23 that colour are classified (224 classes, 98 colour, every one with a gap; the smallest refusing set a `μ₆` coset) and at 43 need ≥ 5 pairs to refuse — a design rule; **[exact]** `Ld14c588b` is 3-colourable by a linear form of period index 1,080 (Coxeter; the owner verified), past every period the searches reached; **[cert + hand] and `L21cc6506` (60 unit vectors, denominator 420) has `Θ₃ = ∅`, so it is not 3-colourable and `χ(ℚ(√167)²) ≥ 4`** — the first bound above three where the conjecture predicts six (FS-59's first target; at four colours `L21cc6506` is four-colourable and loose, row 81) — by two independent exact certificates: implementer E's two routes (a θ-space tree of 605,203 nodes, 7.7 MB gzipped, accepted by Coxeter's unmodified checker and by E's own; and a structural certificate over the product `U = {1, v, v̄, z, z̄}·U_R`, 4,768 Farkas-refuted cases, 106 KB, with its own standalone checker) and verifier V2's relation-branching tree (written before reading E: 30,344 leaves over 39 relations, 149 KB gzipped, `data/fs73/verify-v2/L21cc6506-empty.json.gz`, a second structurally different tree also passing), each checked by a Fraction/int-only checker that re-enumerates the lattice's unit vectors (`tools/fs73v2_check.py`: the owner re-ran it, PASS, and five planted faults were each refused for its own reason; a fake-empty certificate for a colourable lattice is refused), with the criterion's ⟹ direction (T22) derived independently by both competitors, read by Poros and the owner, and re-derived a third way by V2 (a forward `{1, 2}` lift: no parity step, no generation hypothesis). **A half-page proof exists** (E, checked line by line by V2): the 36 unit vectors `{1, v, z}·U_R` alone have empty `Θ₃` — a minimal obstruction — by four inequality cases. **No finite non-3-colourable graph is exhibited**; compactness guarantees one. **[hand] Four colours have neither, cell by cell** — `K₄`'s square complex is `ℝP²`, whose one loop invariant, a ℤ/2 winding, is fixed by the graph (the relation's parity); an edge-local height exists only on four-colourable presentations of rank ≤ 2 (Moore–Newman's triangular lattice among them), and no edge-local height, hence no slope of that kind, on any other presentation (both row 80); `G(ℤ, {1,3,4,5})` is 4-colourable with no linear colouring — so no `Θ`-type certificate built from edge-local heights exists at four colours, and a two-sided finite certificate scheme exists iff 4-colourability of Cayley graphs of ℤ^r is decidable (stated open in print: `[CGHO2025bg]` §6.2.1). Rank-1 four-colour walls (first at `max D = 10`) all sit where `P = F = 0`. **Predictions:** P-T2 lost at P2 to an outcome it did not name, then answered by C (loose on 52 of 57); Poros's hunches "both competitors drift to rigidity" and "no inheritance theorem" killed (the latter at three colours); P-Q1 ("not landed" 0.60, theorem 0.10) — a theorem at three colours, not landed at four; E's P3b prediction (`Θ₃(L21cc6506)` nonempty, 0.60) lost. **Prior art:** the criterion and density answer, at `k = 3` and every rank, a question posed three times — `[Ellenberg2018]` (MathOverflow, 2018: does a `k`-colourable Cayley graph of ℤ^r have a periodic `k`-colouring?), P. Gibbs and D. Mixon on Polymath16 (2018; `[Polymath16threads]`), carried as open by `[CGHO2025bg]` §6.2.1 (2025) — `CLOSED-QUESTIONS.md` §2.4, with the scope of that check; the height lift is the standard device for four-cycle-free targets (Chandgotia 2017, K. Schmidt's cocycles); circular colourings of distance graphs are classical; density at the *standard* generators is expected folklore (Chandgotia–Marcus 2018, listing) and not claimed; rank 1 (`G(ℤ, D)` 3-colourable iff `κ(D) ≥ 1/3`) not found stated. **Ours:** the arbitrary-generator criterion through the relation lattice, density and the dichotomy for every such graph, `F = 3Λ` derived, the `Θ` certificate and checker, the ℚ(√167) screen and its colourings, **`χ(ℚ(√167)²) ≥ 4`**, the four-colour obstruction's statement. **Not claimed:** `χ(ℚ(√167)²) ≥ 5` (row 123's); that `χ(ℚ(√167)²) ≥ 4` is new (not found in print: zbMATH and the held Polymath16 threads, FS-73's close); anything at four colours beyond the obstruction; C3-aper at `k ≥ 4`; the kernel form, which is row 119 (FS-75). | `plans/FS73-C3-deBruijn.md`, `plans/FS73-C3-Coxeter.md`, `plans/POROS-2026-09-23-fs73-competition.md`, `plans/FS73-derivation.md`, `data/fs73/records/` (`phase-P2.md`, `verify-P2-q11.md`, `phase-P2b-q167.md`), `data/fs73/c3-debruijn/`, `data/fs73/coxeter-c3/` (`certtree.py`, `certcheck.py`, `cert_47.json`), `data/fs73/q167/`, `data/fs73/verify-v2/`, `data/fs73/records/phase-P3b-q167-theta.md`, `data/fs73/records/verify-P3b-q167.md`, `tools/fs73_q167{,_check}.py`, `tools/fs73_theta_*.py`, `tools/fs73v2_*.py`, `tools/fs73v_q11.py` | FS-73 |
> — source: LEDGER.md

The held half, in this library (every abelian group, every step set; on the standard three axioms):

> /-- **NF4-S6 for a group**: a colouring `c : A → ZMod 3` that changes along every step in `U` gives a character of `A`
> with `θ(U) ⊆ [1/3, 2/3]`. -/
> theorem bandSet_three_nonempty_of_proper {U : Set A} {c : A → ZMod 3} (hc : ∀ a, ∀ u ∈ U, c (a + u) ≠ c a) :
>     (bandSet U (band 3)).Nonempty := by
> — source: Proofs/HadwigerNelson/Arith/ThreeColourCharacter.lean

Its neighbours in the same module are `exists_character_of_properAlong` and the plane's forms
`fieldBandSet_three_nonempty_of_colorable`, `…_of_colorable_unitRing`; `bandSet` and `band` are defined in
`Proofs/HadwigerNelson/Arith/CharacterColouring.lean`. Older kernel work on the same objects: `Proofs/HadwigerNelson/ThreeColour.lean` and
`Proofs/HadwigerNelson/ThetaCert.lean` (the winding and the `Θ₃` certificate checker of ledger row 119). The derivation is
`plans/FS73-derivation.md` § 4 (T21–T24, the theorems of this row; T29–T30 the four-colour no-gos; T39–T45 the
ℚ(√167) lattice), with the two independent derivations it merged, `plans/FS73-C3-deBruijn.md` and
`plans/FS73-C3-Coxeter.md`, and `plans/FS73-rigidity-dichotomy.md`. `CLOSED-QUESTIONS.md` § 2.4 records what it answers.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate in your record, in your own
   words, the result, what the kernel holds of it, and what is left; log any mismatch as a finding.
2. **Stage 2 — the map.** Each step of T21–T24 that the unheld parts need (the converse by a character, the periodic
   colouring, the density of periodic colourings, the dichotomy and the forced pairs), set against what this library
   and Mathlib at our pin hold, by declaration name and module; what is missing, with your estimate of each piece in
   lines of Lean. Say which printed results the steps read (the height lift's source, for instance) and whether each is
   formalized here or would be declared (`LEAN.md` § Assumptions: about an hour of agent work is formalized, and when
   unsure, formalize).
3. **Stage 3 — the skeleton and the plan.** The head statements in Lean — the criterion as an equivalence for finitely
   generated torsion-free abelian groups and finite symmetric step sets, the periodic form, the density, and the
   dichotomy if it rides — read back aloud against row 79 in your record, with what is not claimed (Poros's objection:
   `k = 3` only; density at the standard generators); every missing piece as a statement with `sorry`, built through
   `./scripts/build.sh` under the slot; a plan per leaf; the price in lines of Lean in total and per module; then the
   experience-modeling pass on the head statements (`debruijn-experience-modeling`: their names and docstrings as a
   mathematician would cite them). Nothing with a `sorry` reaches `main`; the skeleton stays on your branch.
4. **The report**, in the standing rules' form, with the front-page lines your reading finds owed drafted in your
   record, each naming its slot (row 79's grade sentence among them).

## What is yours to decide

The modules' names and places, the form of every Lean statement (which topology "dense" is read in, in particular,
taken from the derivation), whether a piece is better proved as a general lemma, which parts ride in the first module,
and the order of the leaves. The held forward half is stated for every abelian group: if the converse or the density
holds in a wider class than row 79 says, or fails in the class it says, report it — a wrong statement reported is a
finding, and a better target is welcome with its price.

## The machine

This is the laptop: 12 cores, 31 GB, shared with two other jobs, one of which builds at 16 GiB. Every Lean build and
every `lake env lean` over about 2 GiB goes through the slot with this machine's settings, from inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 6 --cpus 3 -- env MEMMAX=6G BATCH=2 ./scripts/build.sh`
(or `--mem 4 --cpus 1 -- lake env lean …` for one file); never `lake build`. When the slot waits, another job holds the
memory; on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`)
is for iteration only, never evidence that a module is green. The worktree's `.lake/build` is its own copy; never
replace it with a symlink. `/tmp` is a tmpfs: keep anything your record cites under `data/fs131/ktc1/`.
