# FS131-KN7 — the five-colour chain, next: the declared printed theorem against its page, lane N typed, the ergodic decomposition measured, the next modules planned

*de Bruijn, the planner; the third on this chain, after FS131-KN3 and FS131-KN6. Brief: `data/fs131/briefs/FS131-KN7-chain-next.md`
(on `main`). Branch `fs131-wk7`, cut from `fs131-wch` at `afd9df200`, in the worktree `.claude/worktrees/fs131-wq1`. Claims:
`data/fs131/claims-NF2.md`. Stands on `plans/FS131-KN6-chain-first-layer.md` (cited KN6 § n), `plans/FS131-KN3-chain-plan.md`
(KN3 § n) and the deriver's `plans/FS131-EN2-derivation.md` (EN2 § n). Working files: `data/fs131/kn7/`.*

## Theorems this phase proved

None in the library: this job writes no proof into a module before the coordinator's ruling on the declared theorem.
Kernel-checked in scratch files only (`data/fs131/kn7/lean/`, against this tree's built library; not modules, not
imported by any), each on the standard three axioms unless said — evidence for the finding of Stage 2:

- `kn7_borel_le_quotient` — the Borel σ-algebra of `X ⧸ G` is contained in Mathlib's quotient σ-algebra, for every
  topological group `X` with Borel sets — `data/fs131/kn7/lean/DeclaredRead.lean`
- `KN7Scratch.ksEntropy_map_mono`, `entropy_borel_le_quotient`, `current_clause_four_implies_r1` — the entropy on the
  factor for the Borel σ-algebra is at most the entropy for the quotient σ-algebra; so the declared clause (4) implies
  the page's — `data/fs131/kn7/lean/RepairR1.lean`
- `KN7Scratch.positive_entropy_rigidity_of_polishSpace` — from the proposed repair R1 (a scratch axiom), the declared
  statement word for word, for Polish `X` (axioms: the standard three and the scratch axiom) — the same file

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_kn7_readback.py` (the method of `tools/fs131_kn6_readback.py`, for this brief): every line `> <text>` of the
brief whose next line is `> — source: <path>` must be one whole line of that file, character for character. Run against
`main`'s tree, where the brief and its sources live:

- `quotations=4 identical=4 differing=0`, exit 0 (`data/fs131/kn7/logs/readback.out`): W2
  (`data/fs131/REQUEST-2026-10-13.md`); NF2-NC and the dated line of 2026-10-14 on the headline's eight hypotheses
  (`data/fs131/claims-NF2.md`); item 722 (`plans/FS131-close-inventory.md`).
- Control (`--plant`: the last character of every matching source line changed in memory): `identical=0 differing=4`,
  exit 1 (`readback-control.out`).
- The quotations inside item 722 that it attributes to the last planner — "the quotient σ-algebra on `X/G_j` is asserted
  Borel from a Mathlib instance that `IsSolenoid X` does not supply", "`ErgodicDecomposition`'s used cone is unmeasured
  (declared: 28 files, 22,632 lines); it decides whether M7's one port input is hours or days", "\"ergodic\" is strict
  invariance, formally the stronger axiom, equal to the textbook's by an argument that is not a theorem here" — each
  found verbatim in `data/fs131/reports/FS131-KN6.md` on branch `fs131-wch` (`grep -F`).

No mismatch: nothing for the coordinator from the readback of text.

### 1.2 The compiled library, brought up to date by copy, and the first build

- **From where**: `.claude/worktrees/fs131-wnf/.lake/build/`. Its `HEAD` is `1e9014443` before and after the copy, its
  work tree clean (`logs/wnf-head-{before,after}.txt`, `wnf-status-{before,after}.txt`, both empty); `git diff
  1e9014443 fs131-wk7 -- Proofs Proofs.lean lakefile.toml lean-toolchain lake-manifest.json` names only the four
  `Rigidity/` modules and `Proofs.lean`. Nothing was written or run in that tree.
- **How**: `rsync -a --checksum` with no `--delete`. Dry run before: 990 lines, of which 121 `.olean` — 1 absent here, 6
  differing in content, 114 identical in content with another time (`logs/rsync-dry-before.out`); the copy
  (`rsync-real.out`, 03:31:52–03:31:54 UTC, `copy-times.txt`); dry run after: **0 lines** (`rsync-dry-after.out`).
- **The manifest** after the copy and before the build: SHA-256 of the 1,908 `.olean`
  (`logs/olean-manifest-after-copy.sha256`). After the build `sha256sum -c` reports one file changed, `Proofs.olean` —
  the root, which the build rebuilt (`logs/manifest-check-1.out`); the four `Rigidity/` modules were absent from the
  manifest and are the build's own.
- **The build** (`data/fs131/kn7/build.sh 1 8`: `./scripts/build.sh` under the slot, `--mem 10 --cpus 4`, `MEMMAX=10G`,
  `BATCH=8`): `==> build: OK — 249 of 249 batches, 5 module(s) rebuilt, 3 module(s) with warnings, 7m21s`, `exit=0`
  (`logs/build-1.log`); rebuilt `Rigidity.Solenoid`, `Rigidity.Entropy`, `Rigidity.PositiveEntropy`, `Rigidity.ChainAtTA`,
  `Proofs`; fifteen warnings, each `declaration uses 'sorry'` (`Entropy` 8, `PositiveEntropy` 1, `ChainAtTA` 6), no other.
  Wall 676 s by the wrapper's clock, of which about four minutes waiting for the slot behind two other jobs; memory
  sample 4.29 GiB summed, 3.39 GiB the largest process (5-second samples, `logs/build-1.times`).

### 1.3 The declared statement, read from the kernel's side

`data/fs131/kn7/lean/DeclaredRead.lean`, elaborated against the built tree (`logs/lean-declared-read.log`, exit 0):

- **Unchanged since the last planner.** The default print of `@positive_entropy_rigidity` (the same `open` lines as its
  file) is character for character KN6's print (`data/fs131/kn6/logs/FirstLayerCheck-after.log`): `old=1765 new=1765
  IDENTICAL`, exit 0 (`tools/fs131_kn7_axiom_print.py`, `logs/axiom-print-compare.out`); control (one `ksEntropy` made
  `ksEntropyOn` in memory): `DIFFER`, exit 1 (`axiom-print-compare-control.out`). `tools/fs131_kn3_axiom_binders.py`
  on the new print: the four instance binders `AddCommGroup X`, `TopologicalSpace X`, `MeasurableSpace X`, `BorelSpace X`.
- **With every implicit and instance argument shown** (`pp.explicit`): `ksEntropy` occurs **once**, at line 134 of the
  print, after the existential at line 18 — in the conclusion, as the left side of `= 0`; no hypothesis mentions an
  entropy. The hypothesis `herg` is `ZdAction.IsErgodicOn … ⊤ μ` (line 12); clause (1) is `IsErgodicOn … Λ (ν j)`, in the
  conclusion (line 42).
- **The σ-algebra on `X ⧸ G j`** in clause (4) — both in `ksEntropy`'s implicit argument and in `Measure.map`'s codomain —
  is `@QuotientAddGroup.measurableSpace X (AddCommGroup.toAddGroup X inst) (G j)` (lines 140, 149). The stored type's
  93 constants (`run_cmd`, `getUsedConstants`) include `QuotientAddGroup.measurableSpace` and **neither `borel` nor any
  `BorelSpace` instance on a quotient**; `BorelSpace` occurs once, as the binder on `X`.

### 1.4 What the last planner left for this job, restated (KN6 § Stage 6)

The four items of `LEAN.md` § Assumptions for `Rigidity.positive_entropy_rigidity`:
1. *Docstring*: names the key, Thm 1.3, § 1.1, pp. 2–3 of arXiv:2101.11120v1, and the sense and direction of its
   entropy. Lacks the journal's page numbers.
2. *Read-back*: KN3 § 5.3's table and KN6 § 5.2's table for the entropy. Lacks a second reader against the page, to be
   told four things: (a) the entropy is the infimum form, occurring once, in the conclusion, as `= 0`; (b) three senses
   the page leaves open — "no virtually cyclic factors" (FS105-VC's forced sense, the axiom's residual trust), "ergodic"
   as triviality of the strictly invariant sets (formally the stronger axiom, equal to the textbook's for a countable
   group by an argument not in the library), the `ν j` as probability measures; (c) **the factor's σ-algebra**: asserted
   Borel in KN3's table from `QuotientAddGroup.borelSpace`, which needs `PolishSpace X`, not supplied by `IsSolenoid X`;
   (d) "compact" as Hausdorff, `d ≥ 2` explicit, every binder in the signature.
3. *A model*: `positive_entropy_rigidity_model`, degenerate (the one-point solenoid). Lacks PE-1′ (module M6).
4. *`ARCHITECTURE.md` § Trust and the audit*: nothing written on a skeleton. Owed at the first landing that proves a record
   from the axiom.

Item 2 (c) is this job's item 2; (a) and the "ergodic" sense of (b) are read in Stage 2 with it.

## Stage 2 — SAVED: the declared theorem against its page

The page: `[EinsiedlerLindenstrauss2022]`, arXiv:2101.11120v1, our copy
`~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf`, read in its text layer
(`pdftotext -layout`, into the ignored `build/fs131-kn7/el.txt`; page numbers by form feed). Read for this stage: Thm 1.3
(pp. 2–3), § 1.3's first paragraph and its two constructions (p. 4), § 4's opening, Thm 4.1, § 4.1 and Lemma 4.2 (pp.
14–15), § 3.2's paragraph on entropy contributions conditional on a factor (p. 13).

### 2.1 The possible defect — the σ-algebra on `X/G_j` — settled: no defect in truth; a gap in the read-back, in the unsafe direction

**What the statement takes.** The stored type (§ 1.3) puts on `X ⧸ G j` Mathlib's `QuotientAddGroup.measurableSpace
(G j)`, which is `MeasurableSpace.map (QuotientAddGroup.mk' G) ‹MeasurableSpace X›` by `rfl` (`DeclaredRead.lean`, (C1)):
a set of `X ⧸ G j` is measurable when its preimage in `X` is Borel. **It asserts no Borel structure on the quotient**: no
`borel`, no `BorelSpace` instance on a quotient and no `PolishSpace` occurs in it. The "assertion" item (b) names is in
prose — KN3 § 5.3's table ("equal: the quotient σ-algebra on `X/G_j` is its Borel σ-algebra for a Polish group … and a
solenoid is compact metrizable (its dual is countable)") and the module docstring of `Rigidity/PositiveEntropy` ("which
for a solenoid is the Borel σ-algebra of `X/G_j`").

**What the page takes.** Thm 1.3 (4), p. 3: "The measure µj induces a measure on the factor X/Gj with hµj(αⁿ_{X/Gj}) = 0
for any n ∈ Λ." The factor of a closed invariant subgroup is built on p. 4, § 1.3, first bullet: "If X′ ⊆ X is a closed
α-invariant subgroup and π : X → X/X′ denotes the canonical projection map, then the preimage A = π⁻¹B_{X/X′} of the
Borel σ-algebra B_{X/X′} of X/X′ is α-invariant." So the page's σ-algebra on `X/G_j` is **the Borel σ-algebra of the
quotient group**.

**How the two compare** (kernel, scratch, the standard three axioms):
- the Borel σ-algebra is contained in the quotient one, for every topological group with Borel sets
  (`kn7_borel_le_quotient`: the projection is continuous);
- so the entropy on the factor for the Borel σ-algebra is at most the entropy for the quotient one
  (`KN7Scratch.entropy_borel_le_quotient`, over `ksEntropy_map_mono`: each Borel label map is a quotient one, and its
  cells have the same mass under both pushed measures because the induced map is continuous, so the cells are Borel);
  and the declared clause (4) gives the page's (`current_clause_four_implies_r1`). **The declared σ-algebra is the finer
  one: where the two differ, the axiom says more than the page.**
- They are one when `X` is Polish and `G j` closed — Mathlib's `QuotientAddGroup.borelSpace` (Lusin–Souslin;
  `DeclaredRead.lean` (C3)); clause (2) gives `G j` closed.

**Whether `IsSolenoid X` gives Polish.** Not in this library and not in Mathlib at the pin: with the four fields of
`IsSolenoid X` made instances, `MetrizableSpace X` is not synthesized, and the partner with `SecondCountableTopology X`
added is (`data/fs131/kn7/lean/PolishProbe.lean`, `logs/lean-polish-probe.log`: one error, at the first example only).
Mathlib's whole Pontryagin duality at the pin is `Topology/Algebra/PontryaginDual.lean` (no duality theorem, no
Peter–Weyl: `grep -rln "Peter.Weyl\|PeterWeyl" Mathlib` is empty). Mathematically every solenoid in the page's sense
**is** metrizable — its dual embeds in `ℚⁿ`, so is countable, and the characters of a compact abelian group separate its
points (Peter–Weyl), so `X` embeds in a countable product of circles — and the page itself reads that duality (§ 4.1, p. 14:
"By Pontryagin duality we also have that X is isomorphic to the quotient of X_m = A^m/Q^m modulo the annihilator K = V⊥").
That last step is **[reading]: classical, recalled, not read in a source here**.

**Verdict.** The declared statement is implied by the page together with one classical theorem outside Mathlib (a
compact abelian group with countable dual is metrizable) and Mathlib's Lusin–Souslin instance; no `X` satisfying its
hypotheses has the two σ-algebras differ, so the axiom is consistent if the page is. **There is no defect in truth.**
There is a defect in the read-back, of the kind `LEAN.md` § Assumptions item 2 rules out ("State the axiom in the paper's
own form and derive the form the library uses"): at clause (4) the stored σ-algebra is not the page's, the difference is
in the unsafe direction, and the bridge is a theorem neither the library nor Mathlib holds. Grades: the containment, the
direction and the equality for Polish `X` [kernel] (scratch files, not the library); the metrizability of every solenoid
[reading].

**Proposed repair R1 — not made; for the coordinator's ruling.** State clause (4) over the page's σ-algebra.

Old (`Rigidity/PositiveEntropy.lean` ll. 73–74):
```lean
        ∀ n ∈ Λ, ∀ h : G j ≤ (G j).comap (α n),
          ksEntropy ((ν j).map (QuotientAddGroup.mk' (G j))) (QuotientAddGroup.map (G j) (G j) (α n) h) = 0
```
New:
```lean
        ∀ n ∈ Λ, ∀ h : G j ≤ (G j).comap (α n),
          @ksEntropy (X ⧸ G j) (borel (X ⧸ G j))
            (@Measure.map X (X ⧸ G j) _ (borel (X ⧸ G j)) (QuotientAddGroup.mk' (G j)) (ν j))
            (QuotientAddGroup.map (G j) (G j) (α n) h) = 0
```
and beside it, a theorem deriving the old form for Polish `X` (`positive_entropy_rigidity_of_polishSpace`, eleven lines,
compiled in `data/fs131/kn7/lean/RepairR1.lean` over a scratch copy of the new axiom). Why the new form is implied by the
page: it is the page's sentence symbol for symbol (`B_{X/X′}` is `borel (X ⧸ G j)`; "induces a measure" is the push-forward
by the projection, which is Borel measurable, so `Measure.map` is the true push-forward); and it is implied by the old
form for every `X` (`current_clause_four_implies_r1`) — R1 can only weaken the axiom. What the chain loses: nothing at a
Polish solenoid, where the old form is a theorem over the new. Every solenoid the chain applies the axiom to is the dual of
a countable discrete group (the pieces `M̂`, module M6), second countable and so Polish — M6's planner shows it.
What it costs a consumer: `haar_or_zero_entropy` (M5) reads clause (4) where every `G j` is finite; if its proof wants the
quotient σ-algebra it takes `[PolishSpace X]` (a hypothesis added to a statement of ours, routed through the
coordinator), else it reads the Borel form directly. Docstring edits that go with R1: the module docstring's "which for a
solenoid is the Borel σ-algebra of `X/G_j`" becomes "the Borel σ-algebra of the quotient group, the page's `B_{X/X′}` (p. 4);
for Polish `X` it is Mathlib's quotient σ-algebra (`positive_entropy_rigidity_of_polishSpace`)".

Alternatives weighed. **R2** — add `[PolishSpace X]` to the axiom and keep Mathlib's σ-algebra: also implied by the page (a
restriction of its class, on which the two σ-algebras agree by a Mathlib theorem), but its read-back of clause (4) goes
through `QuotientAddGroup.borelSpace` rather than symbol against symbol, and the hypothesis is not on the page.
**R0** — keep the statement and write the gap into the docstring and the read-back with the classical theorem named: a
declared statement whose read-back rests on an unformalized theorem, when a literal form costs nothing. **R1 recommended;
confidence high.**

### 2.2 The infimum form of the entropy — no repair

From the stored type (§ 1.3): `ksEntropy` occurs once, in the conclusion, as `= 0`; no hypothesis mentions an entropy. The
page's `h_{µ_j}(αⁿ_{X/G_j})` is the textbook's: for the push-forward (a probability measure, preserved by the induced map
for `n ∈ Λ` because `ν j` is `α_Λ`-invariant and the projection intertwines) the supremum over finite measurable
partitions of `lim_n H_n/n`. The declared number is the supremum of `inf_n H_n/n` over the same partitions (a measurable
label map into `Fin k` is a finite measurable partition, empty cells adding `negMulLog 0 = 0`), and the infimum is below
every reading of the limit for every measure and map (`Rigidity.partitionEntropy_le_liminf`, kernel): the page's `= 0`
gives the declared `= 0`. The base of the logarithm does not enter `= 0`. The cells' masses are true measures, not outer
ones: the induced map is continuous, hence measurable for both σ-algebras on the quotient. Unchanged by R1. **Verdict:
within the page; the safe direction by construction, as KN6 said.**

### 2.3 "Ergodic" as strict invariance — no repair; the bridge is short and planned as a kernel theorem

`herg : α.IsErgodicOn ⊤ μ` (stored type, line 12): every `α n` preserves `μ`, and a measurable set **strictly** fixed by
every `α n` is null or conull. As a hypothesis this asks less of `μ` than the textbook's ergodicity (sets fixed up to a
null set), so formally the axiom applies to more measures. They agree for a countable group, and the argument reads only
what the hypothesis holds: given measurable `s` with `μ((α n)⁻¹' s ∆ s) = 0` for every `n`, put
`s′ := ⋂_{n ∈ ℤ^d} (α n)⁻¹' s`. It is measurable (a countable intersection; each `α n` is continuous on a Borel `X`),
strictly fixed (`(α m)⁻¹' s′ = ⋂_n (α (n + m))⁻¹' s = s′`, since `α (n + m) = α n ∘ α m` and `n ↦ n + m` is a bijection
of `ℤ^d`), and `μ(s ∆ s′) = 0` (a countable union of null sets, using that `α n` preserves `μ`). So the strict form implies
the textbook's, and the page's hypothesis holds whenever the declared one does. In the conclusion, clause (1) in the
strict form is weaker than the page's: safe. **Verdict: within the page.** The argument is about thirty lines and I type
it as a leaf of a new module (§ Stage 5), so that this row of the read-back becomes a kernel theorem.

### 2.4 The read-back of the declared theorem as it stands after this stage

| the page | the Lean statement | direction | how it is known |
|---|---|---|---|
| a `ℤ^d`-action, `d ≥ 2`, by automorphisms of a solenoid | `IsSolenoid X`, `2 ≤ d`, `ZdAction d X`, `[BorelSpace X]` | equal | KN3 § 5.3 |
| no virtually cyclic factors | `NoVirtuallyCyclicFactors` | a sense chosen (FS105-VC) | residual trust, unchanged |
| `µ` invariant, ergodic, probability | `IsProbabilityMeasure μ`, `IsErgodicOn ⊤ μ` (strict) | the strict form implies the textbook's | § 2.3 [hand]; a planned kernel leaf |
| `Λ`, `µ = (1/J) Σ µ_j`, mutually singular; clauses (1)–(3) | as typed | equal | KN3 § 5.3 |
| (4) entropy on `X/G_j` with `B_{X/G_j}` | **as stored: Mathlib's quotient σ-algebra (finer)** | **says more where the two differ**; equal for Polish `X` | § 2.1 [kernel, scratch] and a classical theorem [reading]; **R1 proposed** |
| (4) the entropy itself | `ksEntropy`, the infimum form | below the page's | § 2.2 [kernel] |

