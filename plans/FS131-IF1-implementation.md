# FS131-IF1 — `[Falconer1981]` Lemma 2 (i) becomes a theorem: the implementer's record

*Job FS131-IF1 (de Bruijn, the implementer), branch `fs131-wf1`, cut from `main` at `ca598960`. Brief:
`data/fs131/briefs/FS131-IF1-falconer-lemma2.md`. Working files: `data/fs131/if1/`.*

## What I may and may not change

- **May**: the keyword `axiom` → `theorem` of `falconer_lemma2_nonempty` in `Proofs/HadwigerNelson/Plane/FalconerReduction.lean`, its
  docstring, and what the change forces there (an import line); a new module of my own under `Proofs/HadwigerNelson/Plane/` with its
  lines in `Proofs.lean` and `ARCHITECTURE.md`; `ARCHITECTURE.md` § 5's row "Imported outside theorems"; `scripts/Axioms.lean` (the
  `declareImport` line, the four records, my registrations); the self-test's expected counts where they move with mine;
  this record, `tools/fs131_if1_*.py`, `data/fs131/if1/`, `data/fs131/reports/FS131-IF1.md`.
- **May not**: the statement of `falconer_lemma2_nonempty` (name, binders, conclusion), any other statement or definition, a new
  `axiom`, `native_decide`; `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `BIBLIOGRAPHY.md` (drafts go below); `main`. I do not land, merge
  another branch, or run the full gate.

## Stage 1 — SAVED (FS131-IF1): readback, and the branch built as given

**Quotations checked against their sources** (`grep -F`, each line of the brief's § Why this job and § The statement; script kept
as `data/fs131/if1/quote-check.sh`): 12 of 12 match — the axiom's two lines, `densityRatio`, `densitySet`, the planner's § 12.1 line,
the four consumers' first lines, `LEAN.md`'s two lines, inventory item 548's line.

**The statement read against the paper's page, first-hand** (`[Falconer1981]` p. 185, the library's copy
`library/papers/falconer-1981-realization-distances-measurable-subsets-covering-Rn-jcta-31-184-189.pdf`, pp. 184–186 read):

> Suppose now that S is a Lebesgue measurable subset of Rⁿ; we define the *metrical boundary* ∂S of S to be those points of Rⁿ at
> which the Lebesgue density of S either fails to exist, or exists and has a value other than 0 or 1. (The Lebesgue density of S
> at x is defined as lim_{δ→0} v(B_δ(x) ∩ S)/v(B_δ(x)), where B_δ(x) is the ball of centre x and radius δ.)

> LEMMA 2. Let S be a measurable subset of Rⁿ with v(S) > 0 and v(Rⁿ∖S) > 0 then (i) ∂S is non-empty and v(∂S) = 0, (ii) S̃ is a
> Borel set. — Proof. […] The author's proof that ∂S is non-empty is given for Lemma 4 of Croft [1] in the plane case; an
> identical proof holds in Rⁿ.

The Lean statement (`Proofs/HadwigerNelson/Plane/FalconerReduction.lean:290–291`):
`{S : Set ℂ} (hS : MeasurableSet S) (h1 : volume S ≠ 0) (h2 : volume Sᶜ ≠ 0) : ∃ x : ℂ, x ∉ densitySet S ∧ x ∉ densitySet Sᶜ`.
Read: `x ∉ densitySet S` is "the density of `S` at `x` does not exist with value `1`"; `x ∉ densitySet Sᶜ` is, for measurable `S`
(the ratios of `S` and `Sᶜ` on a closed ball of positive radius sum to `1`, `densityRatio_add_compl`), "it does not exist with value
`0`"; together, `x ∈ ∂S`. Closed balls against the paper's unspecified ball: a sphere is Lebesgue-null. **Verdict: the paper's (i),
first clause, at `n = 2`, with one difference of scope** — the paper's `S` is Lebesgue measurable, the Lean `S` is `MeasurableSet`
(Borel). As an axiom that is the weaker assumption, so nothing false was assumed; as a theorem it is the paper's lemma on Borel sets.
All four consumers apply it to Borel classes. Not a statement defect; logged as an inventory line. The general theorem of Stage 3
is stated for null-measurable sets in any finite dimension, which is the paper's sentence in full.

**Read**: `FalconerReduction.lean` lines 1–32 and 270–420 (the § on Lemmas 2–4, the model `upperHalfPlane_falconer_hyp`, the one
call site in `exists_mem_falconerE`); `UnitPairs.lean` whole; `Cover.lean`'s density lemmas (`ae_restrict_mem_densitySet`,
`volume_diff_densitySet`, `densityRatio_add_compl`, `densitySet_disjoint_compl`, `volume_closedBall_ofReal`,
`tendsto_densityRatio_compl_of_mem`, `mem_densitySet_of_tendsto_compl`, `measurable_densityRatio_centre`, `densitySet_iff_rat`,
`measurableSet_densitySet`); the planner's § 12.1 (`plans/FS131-w2-kernel-plan.md:671–686`); `scripts/Axioms.lean:1–206` (the
instruments and the IMPORTED banner's procedure); `scripts/axioms.sh` whole; `scripts/axioms-controls.txt` whole.

**Who rests on the axiom**: one call site, `exists_mem_falconerE` (`FalconerReduction.lean:374`); `fan_tip_ae_mem`,
`falconer_reduction` and `le_chiM_of_falconerFan` through it. Modules importing `Plane/FalconerReduction`: `Plane/Slack`,
`Plane/ValidMap/Dense`, `Proofs.lean`.

**The self-test and an empty import list** (found at the readback; the brief asked): three controls in
`scripts/axioms-controls.txt` read the library's state — `baseline` (`imported=4 declared=1 library=1`, and its `old` digest's
text), `imported_declared` (`5 / 2 / 2`), and `banner_dropped` (two consequences naming `falconer_reduction` and
`falconer_lemma2_nonempty`). The file's history (`a09b2254`, FS131-T3) shows the design with no declared import: `0 / 0 / 0`,
`1 / 1 / 1`, and `banner_dropped` expecting only `FAIL banners IMPORTED`; every IMPORTED control plants its own axiom
(`t3c_import`), so the self-test needs no library import. The brief's touch list names `scripts/axioms.sh` for these counts; they
live in `scripts/axioms-controls.txt`, which I will edit in Stage 4 (held for the coordinator as a touch outside the list's letter).

**Build as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0, "all 1805 modules
already up to date, nothing built, 0 module(s) with warnings" (`data/fs131/if1/build-stage1.log`).

## Theorems this phase proved

*(none yet — Stage 1 is the readback)*
