
## Drafts for the front page (FS131-LDB1)

*For the coordinator to file; this job files none of them. Each draft names its slot: the file, the section, and the exact
words it replaces or follows. `data/fs131/ldb1/drafts-slots.py` checks that each slot occurs exactly once (on `main` for
the front files, on this branch for the `ARCHITECTURE.md` rows, whose imports cell the gate required here;
`data/fs131/ldb1/drafts-slots.out`: 25 slots, each once, the control absent; the same check at `9fe574044`, before the
merge, fails on 10 slots — `drafts-slots-plant.out`). Each count names the log line it comes from; the gated commit and its
logs are stage 5 (`data/fs131/ldb1/gate/*-final.*`; the scans' full outputs `receipt-axioms-final.log`,
`receipt-vacuity-final.log`, `receipt-assumptions-final.log`).*

**Whose it is.** The theorem is `[AmbrusEtAl2023]`'s — Theorem 1 and its certificate (Table 1, Table 2, the notebook's
points, `g23.csv`), used unchanged. The finite-window route (no periodic reduction, no Bessel citation), the formalization
and the kernel check are this project's: FS131-KDB1's statements and plan, FS131-IDB1's covering and Bessel lemmas,
FS131-IDB2's Fourier side, patterns and window, FS131-IDB3's certificate instance, and this landing. No value of
`χ(ℝ²)` moves; `m₁(ℝ²) ≤ 0.2470` is a known bound, and the kernel proof is new.

**1. `CLAUDE.md` § Trust ledger, the audit's sentence.** *Replaces* "the current audit reads 9038 clean and 5 declared
purchases, and 26 imported (and 32 axiom-free; 9,101 records at the landing of FS-133's density equality, FS133-LD1,
2026-10-14)". From `axioms-final.log`, "audited: 9824 records — 9438 clean on the standard axioms, 355 axiom-free, 26
imported (resting on a declared outside theorem), 5 declared purchase(s)":

> the current audit reads 9438 clean and 5 declared purchases, and 26 imported (and 355 axiom-free; 9,824 records at the
> landing of the density bound, FS131-LDB1, 2026-10-14)

9,101 + 723 = 9,824 (the block's records, stage 2.4); clean 9,038 + 400 = 9,438; axiom-free 32 + 323 = 355; imported and
purchases unchanged.

**2. `CLAUDE.md` § The gate, the vacuity scan's counts.** *Replaces* "`declarations=17902 refutations-skipped=234
sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`." From `vacuity-final.log`, "scanned:
declarations=20563 refutations-skipped=234" and "sites: sites=1454 vacuous=0 stale=0 declared=3 witnessed=38
generic=1411 unknown=2":

> `declarations=20563 refutations-skipped=234 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`.

One count moves: declarations +2,661 — the 83 modules' 2,662, less one generated-on-demand theorem
(`MeasureTheory.Measure.addHaar.congr_simp`) that the joined closure attributes to a Mathlib module (stage 3.5; the scan
difference, module by module, `vacdiff-final.txt`). No site is added: the density bound's binders are no tracked carrier.
The baseline's header is refiled on the branch.

**3. `CLAUDE.md` § Trust ledger, the nine counts.** *No change.* `receipt-assumptions-final.log`'s totals read `axioms=2
rests=27 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1`, and the step reports "recorded counts in
CLAUDE.md § Trust ledger: match (9 of 9 compared)". The density bound adds no axiom and no declared hypothesis: it adds one
`.condition` (`DensityBound.DualCert.IsIndep`, stage 3.5), which no count reads, and it discharges a hypothesis no entry
declared — `Plane.OneAvoidingDensityBound`, taken by three theorems that now read `CLOSED ESTABLISHED`.

**4. `CLAUDE.md` § Where the problem stands, "What the kernel holds, beyond the interval".** *Follows* "anything at a number
field's plane or at six colours; that the result is new (`[Davies2026]`). The kernel proof is this project's;" *with*

> **the density bound** (FS-131, FS131-LDB1): every Lebesgue-measurable planar set with no two points at distance one has
> upper density at most `0.2470`, at every centre (`[AmbrusEtAl2023]` Theorem 1; `Plane.oneAvoidingDensityBound`), so
> `m₁(ℝ²) ≤ 0.2470` and `m₁(ℝ²) < 1/4` with no hypothesis (`Plane.mOne_le_of_oneAvoidingDensityBound` and
> `Plane.mOne_lt_quarter` applied to it), on the density equality's one `Plane.mOne` (its Lebesgue form
> `Plane.mOne_eq_iSup_bandFree`) — so the kernel holds `1/7 ≤ m₁(ℝ²) ≤ 0.2470`; proved from the paper's certificate,
> unchanged, by a finite-window route with no periodic reduction and no Bessel citation, the certificate's 2,321
> congruences, 13,552 independent atoms, 847 cells of the `J₀` covering and 27 distances checked by `decide +kernel` in
> core-only modules, with no `native_decide`; on the standard three axioms. The theorem is `[AmbrusEtAl2023]`'s; the route,
> the formalization and the kernel check are this project's;

**4b. The same sentence's density-equality clause.** *Replaces* "Not claimed: any value of `m₁(ℝ²)` beyond `1/7 ≤
m₁(ℝ²)`, or of a chromatic number;" *by* "Not claimed: any value of `m₁(ℝ²)` beyond `1/7 ≤ m₁(ℝ²) ≤ 0.2470` (the upper
end the density bound's, below), or of a chromatic number;".

**5. `CLAUDE.md` § Frontier, Last filed.** *Replaces* "Last filed: **the landing of FS-133, the density equality**
(FS133-LD1, 2026-10-14:" *by*

> Last filed: **the landing of the density bound** (FS131-LDB1, 2026-10-14: `Plane/DensityBound` and
> `Plane/OneAvoidingDensity` through the gate on the standard three axioms — 83 modules, 723 records;
> `Plane.oneAvoidingDensityBound`, `[AmbrusEtAl2023]` Theorem 1, `m₁(ℝ²) ≤ 0.2470`, from the paper's certificate with no
> periodic reduction and no Bessel citation; `Plane.mOne` defined once, the density equality's, the line's own deleted at the
> join with the bridge `Plane.mOne_eq_iSup_bandFree` (the coordinator's ruling); other people's theorem, the kernel proof
> ours; no value moved); before it **the landing of FS-133, the density equality** (FS133-LD1, 2026-10-14:

**6. `LEDGER.md` row 129, its grade note.** *Replaces* "the interval `[4.04876, 4.35987]` for `1/m₁(ℝ²)` is the
literature's (`[AmbrusEtAl2023]` Theorem 1; Croft's set), not the kernel's, which holds `1/7 ≤ m₁(ℝ²) ≤ 1`" *by*

> the interval `[4.04876, 4.35987]` for `1/m₁(ℝ²)` is the literature's (`[AmbrusEtAl2023]` Theorem 1; Croft's set); the
> kernel holds `1/7 ≤ m₁(ℝ²) ≤ 0.2470` — the upper end `[AmbrusEtAl2023]` Theorem 1 itself, **[kernel]** since FS131-LDB1
> (`Plane.oneAvoidingDensityBound`, with `Plane.mOne_le_of_oneAvoidingDensityBound`; standard three), so `1/m₁(ℝ²) ≥
> 1/0.2470 > 4.0485` there, short of the interval's `4.04876` (the paper's computed `0.24699…`)

The row's own claims keep their grades: the plane's clause is [kernel] already (FS133-LD1); the field form is given MR.

**7. `LEDGER.md` row 92, its real places.** *Replaces* "at every real place it rests on `[AmbrusEtAl2023]` Thm 1,
`m₁(ℝ²) ≤ 0.2470` — external, computer-assisted, published;" *by* "at every real place it rests on `[AmbrusEtAl2023]` Thm 1,
`m₁(ℝ²) ≤ 0.2470` — published, and a kernel theorem since FS131-LDB1 (`Plane.oneAvoidingDensityBound`, standard three);".
The row's grade is not raised by this: it rests on more than the bound.

**8. `LEDGER.md` row 112, its inputs.** *Replaces* "`[AmbrusEtAl2023]` Thm 1 (its certificate re-checked, cert + hand: J26
exact, J49 ball arithmetic; `m₁(ℝ²) ≤ 0.246989`)" *by* "`[AmbrusEtAl2023]` Thm 1 (its certificate re-checked, cert + hand:
J26 exact, J49 ball arithmetic; `m₁(ℝ²) ≤ 0.246989`; `m₁(ℝ²) ≤ 0.2470` a kernel theorem since FS131-LDB1,
`Plane.oneAvoidingDensityBound`)". The row's grade is not raised: it rests on more.

**9. `ARCHITECTURE.md`, the rows' prose** (on this branch: the imports cell of `Plane/OneAvoidingDensity` was the gate's and
is done; the rest is the filing's).
- *(a) the row of `Plane/OneAvoidingDensity`*, its description cell (head "**FS-131 (FS131-KR1), skeleton: 1 leaf
  `sorry`.**", to the cell's end "`mOne_lt_quarter`.") *replaced by* "**FS-131 (FS131-KR1's statements, the leaf FS131-IDB2's;
  landed by FS131-LDB1; no `sorry`).** Module M12's input: `OneAvoidingDensityBound` — `[AmbrusEtAl2023]` Thm 1 (arXiv v3,
  p. 4) in the paper's form, **a theorem** (`Plane.oneAvoidingDensityBound`, `Plane/DensityBound/Theorem`), never declared;
  `mOne_eq_iSup_bandFree` (the ruled bridge: `main`'s `mOne`, from `Plane/OneClass/Defs`, over Lebesgue-measurable sets with
  `BandFree A 0`, the form this module first defined; its own `def mOne` deleted at the landing, the brief's Amendment);
  `oneAvoidingDensityBound_model`; `upperDensity_le_of_oneAvoidingDensityBound`; `mOne_le_of_oneAvoidingDensityBound`,
  `mOne_lt_quarter`."
- *(b) the five rows* `Plane/DensityBound/Bessel`, `BesselDefect`, `Autocorr`, `Pattern`, `Window`: their leads "**FS-131
  (FS131-KDB1), skeleton: N leaves `sorry`.**" *by* "**FS-131 (FS131-KDB1's statements, FS131-IDB1's proofs; landed by
  FS131-LDB1; no `sorry`).**" for `Bessel` and `BesselDefect`, and the same with "FS131-IDB2's proofs" for `Autocorr`,
  `Pattern` and `Window`.
- *(c) § Trust*, the paragraph under the table, *following* "its stored type the declared one's, and its fourteen
  consumers are clean (FS133-LD1).": " `Plane.OneAvoidingDensityBound` (`[AmbrusEtAl2023]`
  Theorem 1) never entered as a purchase: it was a hypothesis of three theorems (FS131-KR1) and is the theorem
  `Plane.oneAvoidingDensityBound` since FS131-LDB1, from the paper's certificate checked by `decide +kernel` — no
  `native_decide`, no axiom."

**10. `BIBLIOGRAPHY.md`, `[AmbrusEtAl2023]`.**
- *(a) the role column, following* "so `m₁(ℝ²) ≤ 0.246989 < 0.2470` is [cert + hand] here; its eq. (23) has a typo —
  `w1(4)` should be `w1(1)` — and its ν is 1e-5 where the notebook's is 1e-6, both valid (J26 §2.3, §4.1)": "; **Theorem 1
  is a kernel theorem since FS131-LDB1** (`HadwigerNelson.Plane.oneAvoidingDensityBound`, on the standard three axioms):
  the paper's certificate, unchanged, read at scale `10²¹` (`ν = 10⁻⁵`, `µ = 6·10⁻⁵`, `(wT + ν)/(1 − µ) = 0.24699745…`),
  on a finite-window route with no periodic reduction (`[deOV10]`, `[KMOR2016]`'s torus) and no Watson §§ 7.21, 13.74, 15.31
  (FS131-KDB1's plan; FS131-IDB1, -IDB2, -IDB3); p. 18's `J0′(t) = J1(t)` should read `−J1(t)`, not material (the proof reads
  `|J0′|`)".
- *(b) the read column, following* "Theorem 1, p. 19's computed `0.24699…` and §4's Remark re-read 2026-09-26 (FS105-W)":
  "; re-read in full, §§ 1–9 and Tables 1–2 (FS131-KDB1, 2026-10-14); pp. 4, 5–6, 9, 13–14, 16–19 against the library
  (FS131-IDB2); pp. 4, 16–19, 23–24, Tables 1–2 line by line against the notebook's points and `g23.csv`, exactly
  (FS131-IDB3); pp. 2 and 4 against the headline (FS131-LDB1)".
- *(c) the library line*, "| `[AmbrusEtAl2023]` | read — §1–§9 in full, with the proofs of Lemmas 1–2, Corollaries 1–2 and
  Proposition 1; Tables 1–2 not line by line (J26, 2026-09-25); the authors' notebook read in full |" *by* "| `[AmbrusEtAl2023]`
  | read — §1–§9 in full, with the proofs of Lemmas 1–2, Corollaries 1–2 and Proposition 1 (J26, 2026-09-25; again
  FS131-KDB1, 2026-10-14); Tables 1–2 line by line (FS131-IDB3, 2026-10-14); the authors' notebook read in full |".

**11. `BIBLIOGRAPHY.md`, `[KMOR2016]`.**
- *(a) the role column, following* "On `𝔽_p²` the three lemmas hold verbatim (densities are counts over `p²`, translates
  are the group) and were measured: 12% below Delsarte at 11, 0.2% at 83": ". Lemma 3.2 (1) in finite-window form is a
  kernel theorem (`DensityBound.autocorr_eq_zero_of_norm_eq_one`, FS131-IDB2), a step of the kernel proof of
  `[AmbrusEtAl2023]` Theorem 1 (FS131-LDB1); the periodic reduction is not used".
- *(b) the read column*, "read — §3 (Lemma 3.2 with its proof, Remarks 3.3–3.4; 2026-09-14) |" *by* "read — §3 (Lemma 3.2
  with its proof, Remarks 3.3–3.4; 2026-09-14); § 3, Lemma 3.2 and pp. 9–11 again (FS131-KDB1, 2026-10-14) |".

**12. `LEAN.md` § The kernel's cost model**, *following* its line on `∀ x ∈ l` (ending "recover the per-element form with
`List.all_eq_true`."), in this order, verbatim from the records:
- FS131-KDB1's two (`plans/FS131-KDB1-density-bound.md` § Stage 6, "**`LEAN.md` § The kernel's cost model**"): the chained
  covering re-pays computed states (21.8 s against 1.5 s per cell); a kernel DFS of mask tests at about 100 µs and 15 KB of
  cache per test, split into theorems of at most about 100 k tests.
- FS131-IDB1's: **its record holds none** — its § "Drafts for the front page" is a copy of FS133-LD1's (lines 264–507, a
  copy slip noted in item 895) and its report's "§ 5.1–5.2" do not exist in any committed version of the record. What
  survives is in its report's INVENTORY (`data/fs131/reports/FS131-IDB1.md` lines 13, 14 and 17 on `fs131-wdb3`), from which
  this draft: *"A certificate's checker in a core-only module, its soundness in a second, and the generated modules importing
  only the first: the 46 cell modules of the `J₀` covering then load no Mathlib (1.95 GB resident against 4.60 GB with
  Mathlib, the same module) and outlive every edit to the Bessel proofs (`Plane/DensityBound/BesselCheck`, `BesselCert`,
  `Cells/*`; FS131-IDB1). A module of 18–29 `decide +kernel` theorems peaks at about one theorem's memory (1.6–2.4 GB)."*
- FS131-IDB2's: none (its § 5.3: "nothing new measured").
- FS131-IDB3's three (`plans/FS131-IDB3-implementation.md` D2): the DFS of mask tests at about 140 µs per test below a
  depth-15 frontier checked once against the DFS's own prefix; a congruence row as an explicit isometry in `ℤ[√3, √11]` at
  about 27 ms; read a certificate's decimals at the scale that makes every one exact (`10²¹`, not `10²⁰`).

**13. `LEAN.md` § Searching — Lean**, *following* its last bullet (ending "Declare it a `.condition` with that model in its
reason (`OneClass.IsShiftInvariantLaw`, FS133-LD1)."), in this order, verbatim from the records: FS131-KDB1's three (§ Stage
6: the 4,669-pair list literal; `Real.circleAverage` and no Bessel function in Mathlib; the micro sign `µ`), FS131-IDB2's
four (§ 5.3: Gaussian regularization with no normalization; the `2π`-periodic `lintegral` shift; `- c⁻¹ * ‖w‖ ^ 2` in `ℂ`;
`simp`'s `measurableSet_setOf` and `two_mul`), FS131-IDB3's four (D3: `Nat.testBit_lor` is Mathlib's; `simp` rewrites `1 &&&
U = 1`; induction on a `List.Forall₂` of applied functions; `bif` in a core-only checker), and this landing's five:
  - *"A join with no conflict in git can still declare one name twice: two lines that each define `Plane.mOne`, in modules
    that do not import each other, merge in silence, every module compiles, and only the root fails, after the whole walk
    (`environment already contains 'HadwigerNelson.Plane.mOne'`); `scripts/dupnames.sh` cannot run until the root builds.
    Before a join's first build, list every constant of the incoming modules and of the other line's library and intersect
    them by name (`data/fs131/ldb1/lean/MainNames.lean`, `collisions.out`; FS131-LDB1)."*
  - *"An import added at a join moves stored types downstream by instance alone: `Plane/OneClass/Defs` brings the port's
    `CommCStarAlgebra ℂ` into `Plane/DensityBound/Window`'s closure, and two of its theorems then store `NormedCommRing ℂ`
    through `CommCStarAlgebra.toNormedCommRing` (three places each). Rebuild the old type from the new by replacing that one
    instance term (`Expr.replace`), check its hash against the dump made before, and have the kernel accept `Eq.refl new :
    old = new` with `Environment.addDeclCore`, a mismatched pair refused (`data/fs131/ldb1/lean/InstanceCheck.lean`;
    FS131-LDB1)."*
  - *"An audit block is checked for coverage as well as for its records' axioms: follow every constant the records' stored
    types and values name, within the landed modules, and require each public constant to be a record or reached
    (`data/fs131/ldb1/lean/Coverage.lean`: 723 records reach the other 1,767 of 2,490 public constants); its control removes
    one implementer's records and must see each reported — removing by name prefix missed one (`dists_ok`) that reached 36
    others (FS131-LDB1)."*
  - *"A former whose docstring calls it a named hypothesis, or external, fails the assumptions step as undeclared once a
    theorem proves it (`undeclared-by-docstring`): the landing that proves it rewords the docstring, and its closed takers then
    read `CLOSED ESTABLISHED` (`Plane.OneAvoidingDensityBound`, FS131-LDB1)."*
  - *"A generator with no `--check` mode is checked by rewriting its modules in place and requiring `git status` clean
    (`tools/fs131_idb1_cells.py chain`, `modules`; `tools/fs131_kdb1_x23.py --write`: the covering's 48 modules and the
    certificate's 23 byte for byte; FS131-LDB1)."*

**14. `tools/claude_md_fact_audit.py`, `GATE_CHANGES`.** One entry after `(("8961", "5"), ("9038", "5")):`'s:

```python
    (("9038", "5"), ("9438", "5")): "FS-131, the landing of the density bound — Plane/DensityBound and Plane/OneAvoidingDensity through the gate: [AmbrusEtAl2023] Theorem 1, every Lebesgue-measurable 1-avoiding planar set has upper density at most 0.2470 (Plane.oneAvoidingDensityBound), from the paper's certificate by decide +kernel with no native_decide, on the standard three axioms; Plane.mOne defined once (the line's own deleted at the join, the bridge mOne_eq_iSup_bandFree, the coordinator's ruling); the theorem [AmbrusEtAl2023]'s, the kernel proof ours (FS131-LDB1; copy data/fs131/ldb1/gate/receipt-axioms-final.log, gated commit 7a2acfef8): 9,824 records, 9,438 clean, 355 axiom-free, 26 imported, 5 purchases",
```

**14b. The same file's table of superseded counts**, every token the drafts retire, each only if the filing leaves it
nowhere in the files the audit joins (the tool flags only a disappearance): `"9038"` (9438 clean); `"9,101"` and `"9101"`
(9,824 records); `"declarations=17902"` and `"17902"` (20563); `"declarations=17902 refutations-skipped=234 sites=1454"`
(20563, 234, 1454). The reason for each: "superseded gate count, refiled at FS131-LDB1's landing from
data/fs131/ldb1/gate/receipt-axioms-final.log (the vacuity count from receipt-vacuity-final.log); the old count stays in
data/fs133/ld1/gate/ and in GATE_CHANGES". The axiom-free count's old `32` is not a retired token: it occurs elsewhere on the
front page ("norm at most 32"). **The next landing's previous receipts are
`data/fs131/ldb1/gate/receipt-{axioms,vacuity,assumptions}-final.log`.**

**15. `data/fs131/claims-NF2.md` § Dated lines**, *following* its last line ("- 2026-10-14 — **The certificate's analytic
half is priced in the kernel** (FS131-KDB1) …"): FS131-IDB3's D5, verbatim from its record, then

> - 2026-10-14 — **The density bound is landed** (FS131-LDB1): `HadwigerNelson.Plane.oneAvoidingDensityBound` through the
>   full gate on one commit (`7a2acfef8`), 723 records of the 83 modules each on a subset of `[propext, Classical.choice,
>   Quot.sound]`, every other public constant reached from them; `Plane.mOne` is the density equality's, this line's own
>   deleted at the join, with `Plane.mOne_eq_iSup_bandFree` (the brief's Amendment); `1/7 ≤ m₁(ℝ²) ≤ 0.2470` on one constant.

**16. The Proof Atlas grade.** `[AmbrusEtAl2023]` Theorem 1 (`m₁(ℝ²) ≤ 0.2470`): from [external] to **[kernel]**
(`Plane.oneAvoidingDensityBound`); `m₁(ℝ²) < 1/4` (the count's input, `Plane.mOne_lt_quarter`): its hypothesis discharged.

## Open gate items at this landing

*Each named, with what would close it; none is a red check of this gate.*

1. **`lean4checker`** (the publication gate, `LEAN.md` § Trust ledger) has not been run over the density bound.
2. **The two instances-only moves** (`DualCert.window_le`, `DualCert.limsup_le`, stage 3.4), which the ruling did not name:
   accepted here on the kernel's `old = new` by `rfl`, sent to the coordinator as a notice; the coordinator rules whether they
   stand.
3. **`DualCert.IsIndep` declared a `.condition`** (stage 3.5), on this landing's word; the alternative, a theorem concluding
   it at a model (the empty set), is a new statement and is not this brief's.
4. **`m₁(ℝ²) < 1/4` with no hypothesis is a term, not a stored theorem** (`mOne_lt_quarter oneAvoidingDensityBound`): a
   closed corollary, if the front page or the chain wants one by name, is a new statement for a planner.
5. **`Chain.out`** (the compiled evaluator's run of the `J₀` chain, the covering generator's input) was not recomputed; the
   kernel re-checks every cell from the literals it produced, so it is an untrusted planning instrument, not a gate input.
6. **FS131-IDB1's record** carries FS133-LD1's drafts in place of its own (item 895's correction owed, still owed); its
   `LEAN.md` drafts are lost but for its report's inventory (draft 12).
7. **The chain's line**: `fs131-wkr`'s copy of `Plane/OneAvoidingDensity` (with its `sorry` and its `def mOne`) meets this
   branch's at one path; the ruling's bridge is the rewrite the chain's readers of the old definition take (the coordinator's
   ruling, part 3).
8. **`ARCHITECTURE.md`'s rows' prose** (draft 9) is the filing's; on this branch the six rows still say "skeleton".
