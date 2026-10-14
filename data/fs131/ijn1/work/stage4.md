
## Stage 4 — SAVED: the headline, read from the kernel

**`Rigidity.min_localBound_five_le_chromaticNumber`** (`Proofs/HadwigerNelson/Rigidity/ChainHeadline.lean`, new):
`min_localBound_five_le_chromaticNumber_of_closed F (bochnerHerglotz_of_countable (unitRing F))
(invariantMeasureOnClosed_of_countable F) (Counting.count_of_oneAvoidingDensityBound hOA) (aPlusOfR88 F) (entropySplit F)
(fun _ => zeroEntropyCarried F) (tca_of_five_le_localBound F) hRow99`. Six of the old headline's eight hypotheses are
discharged by proved theorems; `hCount` by the count over `hOA`; `hRow99` kept.

**The stored statement** (`data/fs131/ijn1/lean/HeadlineCheck.lean` → `headline-check.txt`, `pp.explicit` there):

```
∀ (F : Subfield ℝ) [NumberField ↥F],
  HadwigerNelson.Plane.OneAvoidingDensityBound →
    (localBound F ≤ 4 → localBound F ≤ (SimpleGraph.induce (planeOver F) (unitDistance ℂ)).chromaticNumber) →
      min (localBound F) 5 ≤ (SimpleGraph.induce (planeOver F) (unitDistance ℂ)).chromaticNumber
```

**Read aloud.** For every real number field `F`: if every Lebesgue-measurable set of the plane with no two points at
distance exactly 1 has upper density at most `0.2470` about every centre (`[AmbrusEtAl2023]` Thm 1 as printed), and if
`L(F) ≤ 4` implies `L(F) ≤ χ(F²)` (row 99's lower half at four, a theorem on `main` on Weil's bound), then
`min(L(F), 5) ≤ χ(F²)`, where `L(F)` is the least chromatic number of the level-one residue targets at the
conjugation-stable primes of `F(i)` and `χ(F²)` the chromatic number of the unit-distance graph on `F²` (in `ℕ∞`). **Against
the old headline's conclusion**, as the kernel stores both: the two types opened at the same `F` and instance, every
hypothesis stripped, the conclusions compared as terms — **SAME**; control, the old headline's conclusion against its
`hRow99`'s, **DIFFERENT**; `hRow99` new against old: **SAME**. Against the informal claim (the local–global conjecture's
main clause through five, its lower half, `CLAUDE.md` § The local–global conjecture): `χ(F²) ≥ min(L(F), 5)` is what the
chain was built to give; with `UpperHalf.chromaticNumber_planeOver_le_localBound` (`χ(F²) ≤ L(F)`, on `main` and here) it
gives `χ(F²) = L(F)` wherever `L(F) ≤ 5`.

**Its axioms** (`axioms-after.txt`, from build 2's tree): `[propext, sorryAx, Classical.choice, Quot.sound,
HadwigerNelson.Rigidity.positive_entropy_rigidity, HadwigerNelson.StandingFive.kloosterman_bound]` — the standard three,
two declared outside theorems (Einsiedler–Lindenstrauss through `entropySplit`; Weil through M13's `charBound_one_weil`),
and `sorryAx`. **Every leaf its `sorryAx` comes through** (the printer's `SORRY-LEAF`, the line of each name; the build's
warnings name the same lines):

| leaf | module, line | whose |
|---|---|---|
| `card_fibre` (private; Lemma P, Hensel's fibre count) | `Rigidity/ClassRatio` l. 214 | M13's leaves, `fs131-wcm2` |
| `norm_charSum_new_le` (private; Lemma P, a character new at a level) | `Rigidity/ClassRatio` l. 224 | M13's leaves |
| `ratioAtMost_dyadic` (private; the dyadic branch) | `Rigidity/ClassRatio` l. 346 | M13's leaves |
| `chromaticNumber_le_four_of_small` (private; the exclusions at `q ∈ {3, 7}`) | `Rigidity/ClassRatio` l. 351 | M13's leaves |
| `ratioAtMost_cert` (private; **the certificates' link** at `q ∈ {11, 19}`) | `Rigidity/ClassRatio` l. 359 | M13's leaves / the certificates, `fs131-wc16` |
| `charBound_one_exact` (private; the exact spectra at `q ∈ {23, 27, 31}`) | `Rigidity/ClassRatio` l. 366 | M13's leaves |
| `upperDensity_le_of_oneAvoidingDensityBound` (**the density bound's instance**: the paper's form carried to `ℂ`) | `Plane/OneAvoidingDensity` l. 54 | the density bound, `fs131-wdb3` |

As the brief expected: M13's six leaves, the certificates' link among them, and the density bound's instance; nothing
else. `RingScope`'s `unitRing_eq_stableIntegers` (l. 247) is not on the headline's path. **What the headline's `sorryAx`
does not come through:** the entropy side, the zero-entropy side, M11, the count's own modules, M2a/M2b/M3/M10, lane A —
each proved on this branch; on the branch's 870 public records, 851 are on the standard three, 8 on the declared
Einsiedler–Lindenstrauss and no `sorry`, and 11 carry `sorryAx`, every one through the seven leaves above or `RingScope`'s
(`draft-axioms-block.lean`).

**The two hypotheses kept.** `hOA : Plane.OneAvoidingDensityBound` is a named hypothesis standing for an outside theorem
(its docstring: "External: a named hypothesis standing for an outside theorem, not proved in the library"; not declared
as an axiom by the coordinator's ruling of 2026-10-14) — not declared to the assumptions step on this branch (§ Drafts).
`hRow99` is discharged at the landing by `ThreeFourColours.localBound_le_chromaticNumber_of_le_four` (`main`, FS131-LJ1;
its statement, read in `main`'s source, is `hRow99`'s text for text; its stored type is not compared here), which rests on `StandingFive.kloosterman_bound`. So on the
joined `main` the headline would take one hypothesis, the printed theorem of `[AmbrusEtAl2023]`, and rest on two declared
axioms and the seven leaves.
