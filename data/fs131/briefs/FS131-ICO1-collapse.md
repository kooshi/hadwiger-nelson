# Brief FS131-ICO1 — prove the collapse: the plane over ℚ(√635087) has the plane's chromatic number, from the skeleton and its plan

*Written 2026-10-16 04:41 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-ICO1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus
  role: the implementer of seven modules a planner typed and planned — ledger row 128's field equality, proved in the kernel with no hypothesis of ours — every `sorry` replaced by a proof without changing a statement, then the full gate on one commit
  launch: now, in the planner's worktree, on a branch cut from its skeleton with `main` merged in; beside you an implementer of one short theorem in another worktree, which may run the gate; neither writes the other's files
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be proved as typed (a statement defect goes back through me, never edited by you), and when the gate is green on one commit; the report goes to `data/fs131/reports/FS131-ICO1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-ICO1-collapse.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/kcl1`, on its branch `fs131-ico1` (at `2e28d8a07`: the planner's branch `fs131-kcl1` with `main` merged in; `.lake/build` current for the skeleton): the seven modules under `Proofs/HadwigerNelson/Collapse/` (their proofs; their statements only by my word); the two drafted edits D-E1 (`Proofs/HadwigerNelson/Arith/FloorPlanes.lean`) and D-E2 (`Proofs/HadwigerNelson/Rigidity/ClassRatio.lean`), which I approve below; `Proofs.lean`; `ARCHITECTURE.md`'s seven module rows (the planner's draft); the gate's inputs (`scripts/Axioms.lean` and the rest) by the gate's own rules; `plans/FS131-ICO1-collapse.md`; your scripts and logs under `data/fs131/ico1/`; `data/fs131/reports/FS131-ICO1.md`. Front-file edits (`LEDGER.md` rows 120 and 128, `CLAUDE.md`, `ROADMAP.md`, `README.md`) are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push
  budget: about 500k by the harness's count, as guidance; save a stage after each module or pair of modules; hand back at a saved stage before about 550k, saying what is left — a successor continues from your record, and that is a good report

Hello. The planner who typed these modules answered a question this morning that decides a good deal: the measure
rigidity the library already proves is exactly what ledger row 128 needs. So the statement that the plane over one
real quadratic field needs as many colours as the whole plane can be a kernel theorem with no hypothesis of ours.
The skeleton builds green; you prove its leaves.

## Why this job

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

Row 128 is that kind of finding: this project's derivation, [hand], given MR. It is one of the strongest things the
library can say about planes over number fields — with the outside release's `6 ≤ χ(ℝ²)` it puts the plane over
ℚ(√635087) at six or seven colours — and with this module it stops being conditional.

## The statements

The row, as the ledger states it now:

> | 128 | **The collapse: given MR, the plane's number is a field's. For every totally real number field `F` whose stable places are all 6-thick (`λ*_v < 1/5` at every level, both signs; `N₆(F) = ∅`, which puts `F` outside row 100's exception), `χ(F²) = χ(ℝ²) = χ_CP(ℝ²)`; instances ℚ(√635087) (first stable place 103, `sup_v λ*_v = 0.192617` exact; MR at degree 2) and de Grey's field `ℚ(√3,√5,√7,√11)` (first stable places over 131 and 479, `sup_v λ*_v = 0.168047`; MR at degree 16 walked at FS-105, one checking reading (FS105-MR16)). The load-bearing step needs no MR: for totally real `F` with `N_k(F) = ∅`, `k ≥ 2`, a `k`-colouring of `F²` gives a CP `k`-colouring of `UD(ℝ²)` or an SP witness — condition on the `T + A` factor, extend to the adelic completion, select over all stable places at once by mixing, the colour count entering only at the covering pigeonhole `max_j m_j ≥ 1/k`. Consequences, given MR: rung D is six over ℚ(√635087), whose plane has no unit triangle (so `χ(ℝ²) ≥ 6` iff some finite triangle-free unit-distance graph is six-chromatic); S_nf ⟹ `χ(ℝ²) ≠ 6`, and over totally real fields S_nf ⟺ `χ_CP(ℝ²) = 5`, or `χ_CP(ℝ²) = 7` and no field with a non-6-thick stable place has `χ(F²) = 6` (finitely many residue sizes, infinitely many local planes — not a finite family)** (FS-103; FS103-LB, SEL, F1, CPUP, 635, 635TF, DG, S, FMT, CTL; `plans/FS103-collapse-cp-plane.md` §R-close). **[hand + tools exact; the load-bearing step two derivations blind to each other and to J39's and J48's proofs (V1; V2) — four derivations with the two held; the assemblies two blind; place lists and spectra tools exact, three code bases; MR row 120's grade; the complex-place widening one mind (V2), not claimed]** Mechanism: a stable place whose local piece mixes drops out (G76's selection over infinitely many places), MR removes the SP witness, and nothing arithmetic is left for a colouring to use (G81). Controls: the chain stops at K(√7) at six (83, `λ* = 0.210818`), at K(√5) at five (11), at ℚ(√167) at five (23, 43), at ℚ at two, and on `Cay(ℝ, {±1, ±√2})` (`χ = 2 < 3 = χ_CP`); at four it reproduces `χ ≥ 5` at ℚ(√167) and de Grey's field. The stub's "a real field with no non-thick place" was MISSTATED. **Since `[OAIMath2026]` (2026-10-06):** the plane half, `χ(ℝ²) = χ_CP(ℝ²)`, holds with no MR — this row's load-bearing step run at `ℝ_alg`, where no place is stable, with a rigidity theorem proved there; the field half, `χ(F²) = χ(ℝ²)`, still needs MR(F). `χ_CP(ℝ²) = 5` is excluded (its Thm 1.4): given MR, `χ(ℚ(√635087)²) = χ(F_dG²) ∈ {6, 7}`, a finite triangle-free six-chromatic unit-distance graph exists, and over totally real fields S_nf ⟺ `χ(ℝ²) = 7` and no field with a non-6-thick stable place has `χ(F²) = 6`. **Not claimed:** the complex-place widening; anything at six. **Prior art:** the plane equality is in print outright in `[OAIMath2026]` family 158 (manuscript dated 2026-09-23, released 2026-10-06; FS-103 is 2026-09-26 and conditional on MR) — independent, and theirs is the theorem; in dimension at least four the collapse is a theorem with no hypothesis — `[Davies2026]` Thm 1.1 (8 October 2026): `χ(ℚ^d) = χ(ℝ^d) = χ^(m)(ℝ^d)` for `d ⩾ 5`, and `χ(ℝ⁴) = χ(ℚ(√n)⁴)` for some non-square `n`, not exhibited — by transferring finite spectral certificates to lattice graphs; for the plane that paper writes "we suspect that a more complicated extension of ℚ² might be required" (p. 5), a suspicion with no argument, which this row's field half contradicts given MR (read in full, FS131-ER1: what it would have to deny is MR at the field or the selection over thick places); the field equality and the selection over stable places not found in print (FS103-G: the posers' zbMATH listings, 39 queries, web, two citation walks); in print, `[Madore2015]` ¶5.4 (`χ(ℝ²)` over the real algebraic numbers, non-constructive, G63) and `[Payne2009]`'s "ambiguous chromatic number" (`χ ≠ χ_m`), whose ambiguous examples are fields with a non-thick place. | `plans/FS103-derivation.md` §1; `plans/FS103-V1-verification.md`; `plans/FS103-V2-verification.md`; `tools/fs103_v1_checks.py`, `tools/fs103_v2_places.py`; `plans/FS105-derivation.md` FS105-MR16 | FS-103 (2026-09-26) |
> — source: LEDGER.md

The skeleton's three headline statements, on your branch (the plan names every other):

> theorem chromaticNumber_planeOver_sqrt635087 :
>     ((unitDistance ℂ).induce (planeOver F635087)).chromaticNumber = (unitDistance ℂ).chromaticNumber :=
> — source: Proofs/HadwigerNelson/Collapse/Headline.lean

> theorem chromaticNumber_planeOver_eq_plane_of_thick {c : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c) (hc : c < 1 / 5) :
>     ((unitDistance ℂ).induce (planeOver F)).chromaticNumber = (unitDistance ℂ).chromaticNumber := by
> — source: Proofs/HadwigerNelson/Collapse/Headline.lean

> theorem chromaticNumber_planeOver_deGrey :
>     ((unitDistance ℂ).induce (planeOver FdG)).chromaticNumber = (unitDistance ℂ).chromaticNumber :=
> — source: Proofs/HadwigerNelson/Collapse/Headline.lean

The plan is `plans/FS131-KCL1-collapse-plan.md` on your branch: § 4.1 reads the target aloud against the row; § 4.2 lists the skeleton; § 4.3 is the
plan per leaf (48 `sorry` leaves); § 4.4 the price (about 3,270 lines) and the order of the leaves; § 4.5 the drafted edits;
§ 4.6 the modeling passes it did not run; § 4.7 the front-page corrections it drafted; § 4.8 its build. Its report is
`data/fs131/reports/FS131-KCL1.md`.

**My rulings on the plan's open choices:**
1. **D-E1 and D-E2 are approved** as drafted in § 4.5 (new public theorems; no stored statement moves). *Why:* about 140
   lines in place of about 350 copied from a private chain, and the two-sided bound is the form a reader wants. Their
   dependents recompile; measure that before you commit to it, and if the rebuild is far over an hour on this laptop,
   say so and take the copy instead.
2. **D-E3 is declined** (it would move a landed stored statement).
3. **De Grey's field rides in this job** (about 65 lines; it discharges row 128's "MR at degree 16 … one checking
   reading").
4. **The general form stays as typed** — every real number field whose stable primes are uniformly `c`-thick with
   `c < 1/5`, no "totally real" — because the kernel is the check; if a leaf turns out to need total reality, that is a
   statement defect: message me.
5. The one non-`sorry` warning (`unusedSectionVars` at `Collapse.ThickAt.mono`) is fixed by the `omit` line the plan names.
6. The experience-modeling pass the planner skipped is owed before the landing (`debruijn-experience-modeling`): the
   headline names and docstrings read as a mathematician would cite them.

## Done means

1. **Stage 1 — the readback.** Check the quotations; restate the target and the order of work in your record.
2. **The leaves**, in the plan's order, re-pricing from the first two leaves of each kind (a copy leaf, a new leaf) and
   writing the re-price into your record; every module built through `./scripts/build.sh` under the slot; a saved stage
   after each module or pair.
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copy it under `data/fs131/ico1/` and point its
   logs there), every count change explained against this morning's run (`data/fs131/clone1/gate/`), the vacuity scan's
   new sites and each structure hypothesis's inhabitant named (`LEAN.md` § The gate), and `#print axioms` of the three
   headlines (expected: the standard three, `Rigidity.positive_entropy_rigidity`, `StandingFive.kloosterman_bound`; the
   six-or-seven corollary adds `Outside.OAI158.no_proper_five_coloring`).
4. **The read-aloud** of each headline against row 128, in your record.
5. **The drafts** for the front files (the planner's § 4.7, brought to what is proved), each naming its slot; novelty as
   the ledger words it — the field equality "prior art: not found in print"; the plane equality is `[OAIMath2026]`'s.
6. **The report**, in the standing rules' form.

## What is yours to decide

The order within the plan's order, every proof, helper lemmas and their modules, and whether a leaf is better proved
another way than the plan says — say so in your record. Not yours: any stored statement of the skeleton or of `main`
(message me with the defect and the form you need).

## The machine

This is the laptop: 12 cores, 31 GB, shared with one other implementer. From inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 12 --cpus 6 -- env MEMMAX=12G BATCH=4 ./scripts/build.sh`;
on exit 75 wait ten minutes and retry; never `lake build`. `lake env lean` (with `-DautoImplicit=false
-DrelaxedAutoImplicit=false`) is for iteration only. `/tmp` is a tmpfs: keep what your record cites under `data/fs131/ico1/`.
