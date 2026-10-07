# FS132-I2 — the port: the release's lemmas that FS-132's first theorem stands on, proved in this library with no new axiom

*Record of the implementer (de Bruijn, Opus 5.5). Brief: `data/fs132/briefs/FS132-I2-port.md` on `main` at `dcf89464e`.
Branch `fs132-wi2`, cut from `fs132-wk1` at `e3695302c`; worktree `.claude/worktrees/fs132-wi2`. Working files:
`data/fs132/i2/`. Tools: `tools/fs132_i2_port.py` (the generator and its check), `tools/fs132_i2_readback.py` (the
ported statements and definitions against the release's, as the kernel stores them at the two pins). The outside
clone (`/home/kooshi/source/math`, commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a`) and the audit's compiled copy
(`~/.cache/ext-oai1/lean`) were read; nothing was written into either.*

## Theorems this phase proved

*(Filled at the stage that builds them; none before stage 2.)*

## Stage 1 — SAVED (FS132-I2): the readback, and the branch built as given

**The brief's quotations against their sources** (standing rule 3). `tools/fs132_i1_quotes.py` (FS132-I1's tool, run,
not edited) on the brief as it stands on `main`, relative paths read under `main`'s tree:
`data/fs132/i2/quotes.out` — **9 quotations, 9 matched, 0 mismatches**; its self-test on the same brief
(`data/fs132/i2/quotes-selftest.out`): a changed word, a wrong source and an empty quotation each refused.

| # | quotation (first words) | source | result |
|---|---|---|---|
| 1 | "I agree with all 3. let's keep the lean backlog paused. …" | `data/external/EXT-OAI1-request.md` | OK |
| 2 | "1. port or import: let's import and adopt parts piecemeal if needed. …" | `data/external/EXT-OAI1-request.md` | OK |
| 3 | "Do not consider Lean formalization a cost. …" | `CLAUDE.md` § Counter-priors | OK |
| 4 | `lemma palette_transfer_pair (hw : WeakColoring k c) (x : ℂ) :` | release `PaletteDensity.lean` (line 143) | OK |
| 5 | `lemma palette_sixty_disjoint (hw : WeakColoring k c) (x : ℂ) :` | release `PaletteTransport.lean` (line 450) | OK |
| 6 | `lemma two_state_impossible {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c)` | release `States.lean` (line 243) | OK |
| 7 | `lemma mem_spatialSupport_ae (hc : Measurable c) (i : Fin k) :` | release `AngularBoundary.lean` (line 309) | OK |
| 8 | "- **Port, declare nothing further.** C132-M-ORBIT, -M-EXCL, -DIAG-WIDE at `U = ℂ` need three release statements" | `plans/FS132-kernel-plan.md` § 3.6 (branch `fs132-wk1`) | OK |
| 9 | "Stands on two release statements only — `palette_sixty_disjoint`, `palette_transfer_pair` — and on the ported" | `plans/FS132-kernel-plan.md` § 3.3 | OK |

The brief's facts about the branch, checked: `fs132-wi2` is at `e3695302c`, the commit the brief names; the generated
module is 818 lines; `tools/fs132_k1_port.py --check` passes on it as given.

**Read for this stage**: the brief; `plans/STANDING-RULES.md`; `LEAN.md` in full; `RUNNING.md` § Building and § Make the
gate fail; the planner's `plans/FS132-kernel-plan.md` §§ 2.1, 2.4, 2.5, 2.6, 3.3, 3.4, 3.6, 3.7 whole; `tools/fs132_k1_port.py`
whole; `Outside/OAI158Palette.lean`'s header and its first 140 lines; `Outside/OAI158.lean` lines 1–95; the placeholders
of `Plane/SixRing/Orbit.lean` (their names and binders — the file is the planner's successor's, not edited). Of the
release: `Coloring.lean` whole; `PaletteDensity.lean` 1–20, 120–160; `PaletteTransport.lean` 380–458; `States.lean`
1–12, 85–100, 225–315; `AngularBoundary.lean` 140–150, 300–315; the import lines of fifteen files; the `LICENSE`
(Apache-2.0; no `NOTICE` file; the Lean files carry no copyright header).

**The four statements as the release has them** (each under `variable {k : ℕ} (c : ℂ → Fin k) (hc : Measurable c)` but
the third, which binds its own):

```lean
-- PaletteDensity.lean:143–150   (variable {k : ℕ} (c : ℂ → Fin k) (hc : Measurable c), line 79)
lemma palette_transfer_pair (hw : WeakColoring k c) (x : ℂ) :
    ∀ᵐ p ∂angularMeasure.prod angularMeasure,
      c (angularSum x 1 p) ∉ palette c hc x p.1 ∪ palette c hc x p.2 := by
-- PaletteTransport.lean:450–454 (variable {k : ℕ} (c : ℂ → Fin k) (hc : Measurable c), line 432)
lemma palette_sixty_disjoint (hw : WeakColoring k c) (x : ℂ) :
    ∀ᵐ f ∂angularMeasure, Disjoint (palette c hc x f) (palette c hc x (f+(sixty : Angles))) := by
-- States.lean:243–307
lemma two_state_impossible {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c)
    (x : ℂ) (J K : Finset (Fin k)) (hcard : (Finset.univ\(J∪K)).card≤2)
    (s : Angles → Bool) (hs : Measurable s)
    (hJ : RealState hc x {t : ℝ | s (t : Angles)=false} J)
    (hK : RealState hc x {t : ℝ | s (t : Angles)=true} K)
    (hflip : ∀ᵐt∂angularMeasure,s (t+(Real.pi/3 : ℝ))= !(s t)) : False := by
-- AngularBoundary.lean:309–312  (variable {k : ℕ} (c : ℂ → Fin k), line 306)
lemma mem_spatialSupport_ae (hc : Measurable c) (i : Fin k) :
    ∀ᵐz : ℂ∂volume,c z=i → z∈spatialSupport c i :=
```

The planner's placeholders in `Plane/SixRing/Orbit.lean` carry the same names in the namespace `HadwigerNelson.SixRing`,
with `open Outside.OAI158`; the ported theorems are `HadwigerNelson.Outside.OAI158.<same name>` with the release's
binders, so removing a placeholder leaves the name resolving to the ported theorem.

**The branch built as given.** `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh` from the worktree: **exit 0** (`data/fs132/i2/logs/build-0-as-given.exit`, read from the file the
command wrote, not through a pipe), "all 1849 modules already up to date, nothing built, 3 module(s) with warnings", 29
`declaration uses sorry` warnings, all in `Plane/SixRing/{Winding, Orbit, CyclicCentre}` — the planner's skeleton
(`data/fs132/i2/logs/build-0-as-given.out`).

Token count at this stage: own ≈ 135k (an estimate: this harness shows no meter).
