## Drafts for the front page (FS131-LC1)

*For the coordinator to file; nothing here is filed by this job. Each names its slot — the file, the section, and **the
exact words on `main` it replaces or follows**, each asserted to occur exactly once on `main`
(`data/fs131/lc1/drafts-slots.py`, output `drafts-slots.out`: 14 of 14, the control absent) — and the log line it
comes from. The gated commit is `@@GATED@@`; its logs are `data/fs131/lc1/gate/*-final.*`
(`receipt-axioms-final.log`, `receipt-vacuity-final.log`, `receipt-assumptions-final.log` are the three scans' full
outputs). **Every draft says whose the mathematics is: a printed lemma, formalized here; a declared outside theorem; a
composition.***

**1. `CLAUDE.md` § Trust ledger, the audit's sentence.** *Replaces* "the current audit reads 7364 clean and 5 declared
purchases, and 23 imported (and 28 axiom-free; 7,420 records at the landing of FS-124's second module, FS124-L2,
2026-10-07)" — from `axioms-final.log`, "audited: 7454 records — 7395 clean on the standard axioms, 28 axiom-free, 26
imported (resting on a declared outside theorem), 5 declared purchase(s)":

> the current audit reads 7395 clean and 5 declared purchases, and 26 imported (and 28 axiom-free; 7,454 records at the
> landing of FS-131's measurable number, FS131-LC1, 2026-10-13)

7364 + 31 = 7395 (the landing's 31 records under CLEAN, each on exactly the three: `records-final.txt`); 23 + 3 = 26;
7,420 + 34 = 7,454; axiom-free and purchases do not move. **Twenty more records than the planner's count gives**
(fourteen): every declaration a person typed is filed. Until it is filed the audit flags the sentence stale (not
failed): "7364 clean → 7395, 23 imported → 26".

**2. `CLAUDE.md` § Trust ledger, the transfer's records.** *Replaces* "— a proper `k`-colouring of the plane gives a
Borel one proper at almost every unit pair — with nine; no record rests on two of the three" — from
`records-final.txt`, "whole log: records carrying proper_to_borel_weak: 12 (filed: 12); of the landing's: 3":

> — a proper `k`-colouring of the plane gives a Borel one proper at almost every unit pair — with twelve (three of them
> FS-131's: `χ(ℝ²) = χ_m(ℝ²)`, the Lebesgue-measurable chromatic number, in two forms and colour by colour,
> `Plane/LebesgueNumber`); no record rests on two of the three

**3. `CLAUDE.md` § Trust ledger, the nine assumption counts.** *Replaces* "`axioms=3 rests=23 named=19 inline=16
outside=7 ours=23 open=5 takes=98 mentions=1` — three outside theorems declared as axioms, with twenty-three theorems
resting on them" — from `receipt-assumptions-final.log`, "assumed: axioms=3 rests=26 named=19 inline=16 outside=7
ours=23 open=5 takes=98 mentions=1":

> `axioms=3 rests=26 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1` — three outside theorems declared
> as axioms, with twenty-six theorems resting on them

One of the nine moves, `rests` 23 → 26; the ledger's header is refiled on the branch by the script
(`--write-ledger`: three `RESTS` rows gained, 125 rows). The rest of the paragraph stands: no hypothesis is declared.

**4. `CLAUDE.md` § The gate, the vacuity scan's two count lines.** *Replaces* "`declarations=15928
refutations-skipped=228 sites=1448`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1405 unknown=2`." — from
`vacuity-final.log`, "scanned: declarations=15969 refutations-skipped=228", "sites: sites=1454 vacuous=0 stale=0
declared=3 witnessed=38 generic=1411 unknown=2":

> `declarations=15969 refutations-skipped=228 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`.

Three counts move: declarations +41 (the module's 41 constants), sites +6 and generic +6 (six binders `AeColouring
k`, the caller's `k`; stage 5). The sentences on the baseline's two entries stand; the baseline's header is refiled on
the branch from the scan.

**5. `tools/claude_md_fact_audit.py`, `GATE_CHANGES`** — one entry after the last (`(("6967", "5"), ("7364", "5")):`):

```python
    (("7364", "5"), ("7395", "5")): "FS-131, the landing of the measurable-number module — [Davies2026] Lemma B.1 formalized with its printed proof, chiM0 = chiLebesgue on the standard three, chi(R^2) = chiLebesgue on the declared outside theorem proper_to_borel_weak; other people's mathematics, composed (FS131-LC1; copy data/fs131/lc1/gate/receipt-axioms-final.log, gated commit @@GATED9@@): 7,454 records, 7,395 clean, 28 axiom-free, 26 imported, 5 purchases",
```

and, in the same file's table of superseded counts, in that table's own form: `"7364"` (7395 clean), `"7,420"` (7,454
records), "23 imported" (26), `declarations=15928` (15969), `sites=1448` (1454), `generic=1405` (1411), `rests=23`
(26), "with nine" (twelve), "twenty-three theorems resting" (twenty-six) — "superseded gate count, refiled at
FS131-LC1's landing from data/fs131/lc1/gate/receipt-axioms-final.log (the vacuity counts from
receipt-vacuity-final.log, the assumption counts from receipt-assumptions-final.log); the old count stays in
data/fs124/l2/gate/ and in GATE_CHANGES". **The next landing's previous receipts are
`data/fs131/lc1/gate/receipt-{axioms,vacuity,assumptions}-final.log`.**

**6. `CLAUDE.md` § Where the problem stands, the sentence on Falconer's number** (the planner's draft 3, checked
against what landed: both names are theorems of the gated module; the first prints the standard three, the second
those and the one import). *Replaces* "Falconer's everywhere-proper `χ_m` is one step further, a GAP; by Thm 1.4
`χ_m(ℝ²) ≥ χ_m⁰(ℝ²) ≥ 6`." *by*

> Falconer's everywhere-proper Lebesgue-measurable `χ_m` is the same number, by other people's mathematics composed:
> `Plane.chiM0_eq_chiLebesgue` (`[Davies2026]` Lemma B.1, p. 44, formalized here with its printed proof, with the
> density-point step the library held; no import), so `χ(ℝ²) = χ_m(ℝ²)` on the declared outside theorem
> `Outside.OAI158.proper_to_borel_weak` (`Plane.chromaticNumber_plane_eq_chiLebesgue`; through the gate, FS131-LC1),
> and by Thm 1.4 `χ_m(ℝ²) ≥ 6`; the Borel number `χ_B` (`Plane.chiM`) is not decided against it
> (`Plane.chiLebesgue_le_chiM` is all that is held).

*(Optional, the planner's note: § The aim, link 1 may add `= χ_m(ℝ²)` to its chain with the same attribution. Not
drafted as a replacement: the link's sentence is about `χ_m⁰` and reads true as it stands.)*

**7. `LEDGER.md` row 130** (the planner's draft 1, checked against what landed and against the dated line of 18:00 UTC).
- *Replaces* "**Not claimed:** `χ(ℝ²) = χ_m(ℝ²)` (the null-set step, a GAP in every record); `χ_B` against `χ_m`; any
  value." *by* "**Not claimed:** `χ_B` against `χ_m` (the lemma's colouring is Lebesgue measurable and no more: its
  null set is coloured by compactness; in the kernel `χ_B` is `Plane.chiM` and only `Plane.chiLebesgue_le_chiM` is
  held); the step from almost every pair to every pair in `ℝ^d` for a finite set of distances (it stays [hand], one
  mind: `data/fs131/claims-NF3.md`, the dated line of 2026-10-13 18:00 UTC — the kernel holds the plane and the unit
  distance); that either equality is this project's mathematics; any value."
- *Follows* "need six colours** (FS-103 Phase 3; FS103-M1, M1b, M1c, M-FREE, M-NR, M-NSUPP, M-AE3, M-EASY, M-D,
  M-Q4)." — the closing clause: "*Closed, by other people's mathematics composed (FS131-ER1's reading, FS131-KC1's
  module, FS131-LC1's landing): `χ_m⁰(ℝ²) = χ_m(ℝ²)` — `[Davies2026]` Lemma B.1 (p. 44; a measurable colouring proper
  on a conull set extends, after a null change, to a Lebesgue-measurable proper colouring), formalized with its
  printed proof (`exists_proper_ae_eq_of_proper_on_conull`, in every finite dimension and for any translation-invariant
  relation), with the density-point step (D1, `Plane.AeColouring.dist_ne_one`): `Plane.chiM0_eq_chiLebesgue`, on the
  standard three axioms. With `[OAIMath2026]`'s transfer: `χ(ℝ²) = χ_m(ℝ²)`,
  `Plane.chromaticNumber_plane_eq_chiLebesgue`, on the declared outside theorem
  `Outside.OAI158.proper_to_borel_weak`. The list-colouring reduction of this row (FS103-M-D) is not used: the lemma
  slides each finite set into the good set by a translation.* **[kernel]**, through the gate (FS131-LC1, gated commit
  `@@GATED9@@`); the number is typed over `ℂ` (`Plane.chiLebesgue`)."
- *In the row's chain*, "`χ_m⁰(ℝ²) = χ(A_σ) ≤ χ_m(ℝ²) ≤ χ_B(ℝ²)`" *becomes* "`χ_m⁰(ℝ²) = χ(A_σ) = χ_m(ℝ²) ≤ χ_B(ℝ²)`" —
  the last equality is `Plane.chiM0_eq_chiLebesgue`; the first is the row's own, by hand.

**8. `LEAN.md`** (three of the planner's, each elaborated at the pin in its job and read here against the module; four
of this landing's).

*§ Searching — Lean, following* "a module from another branch with a dump made in that branch's worktree (FS124-L2).":

> - A colouring that must *extend* a given one on a set comes from `Finset.rado_selection` read at singletons (`χ x = g
>   t x` with `x ∈ t`), with no gadget; `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom` cannot carry a
>   precolouring (`exists_proper_ae_eq_of_proper_on_conull`, FS131-KC1).
> - `Besicovitch.ae_tendsto_measure_inter_div μ s` asks no measurability of `s`, and `ae_imp_of_ae_restrict` turns it
>   into `∀ᵐ x ∂μ, x ∈ s → …` with none either: almost every point is a density-one point of its fibre for **any** map
>   with countably many values (`ae_hasDensityOneAt_fibre`). Density one is closed under intersection only with a
>   null-measurable set (`MeasureTheory.measure_union_add_inter₀`; `HasDensityOneAt.inter`) (FS131-KC1).
> - `Measurable f` for `f : ℂ → Fin k` is Borel measurability (`Complex.measurableSpace := borel ℂ`); 'Lebesgue
>   measurable' is `NullMeasurable f volume` — equivalently every fibre a `NullMeasurableSet`
>   (`Plane.nullMeasurable_iff_forall_fibre`), equivalently `AEMeasurable f volume` (`NullMeasurable.aemeasurable`,
>   `AEMeasurable.nullMeasurable`). A docstring that says Lebesgue over `Measurable` names another number wherever the
>   colouring must be proper at every pair (`Plane.chiM` is `χ_B`) (FS131-KC1).
> - A landing that edits docstrings only shows it twice: in text, the file with every block comment removed is the same
>   (`data/fs131/lc1/code_only_diff.py`, with a planted code character), and from the kernel's side by the dump of the
>   edited modules made before the build and after it. A docstring edit in a module the import's module reads
>   (`Plane/AeColouring` is under `Outside/OAI158` and the nine ported modules) recompiles them: both stored-term
>   comparisons with the release are run again (FS131-LC1).

*§ Building, following* "`lake build --no-build` under the cap says so in two seconds. (FS124-K1).":

> - **On the laptop** (12 cores, 31 GB; `SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6`): a build that recompiles 117 modules of
>   `Plane/` and `Outside/` at `BATCH=2` is 47 m 22 s, about half of it the walk (Lake started 947 times); its largest
>   compiler is 5.5 GiB resident (`Plane/CoverExamples`, 134 s) and its largest batch 8.0 GiB. With a known small stale
>   set, `BATCH=10` starts Lake 201 times: @@WALK10@@. Every whole-library gate step — the audit, the two scans, the
>   doubled names, the lint, their self-tests — is one `lean` process of 4.4 to 5.1 GiB resident, of which the kernel
>   charges the step's scope 0.5 to 1.3 GiB when the `.olean` pages are already cached; the audit is 8 s, each scan
>   about two minutes, each self-test two to three. A scope's `memory.peak` is not what a step costs cold: plan a cap
>   from the largest process's resident set (`data/fs131/lc1/in-scope.sh` records both) (FS131-LC1).

*§ The gate, the bullet on `./scripts/vacuity.sh`, following* "a landing reads each skipped declaration of its
modules.":

> A module that takes the library's tracked carrier is not silent: the binder `(a : AeColouring k)` reads `GENERIC`
> (six sites in `Plane/LebesgueNumber`), which is the scan saying the parameter is the caller's; the landing says by
> hand at which `k` the carrier is inhabited, empty given an import, and open (FS131-LC1, its record's stage 5: seven
> and nine; five and below; six).

*§ The gate, the bullet on `./scripts/axioms.sh --self-test`* — no new text: `scripts/axioms-controls.txt`'s own header
carries the rule this landing followed (a record resting on a declared import moves the two state-reading counts).

**9. `BIBLIOGRAPHY.md`.** `[Davies2026]` — *replaces* "**Read: the abstract, Theorem 1.1 and the introduction's
passages on rational points and `ℚ(√n)²`** (2026-10-13, from a text extraction; FS131-PN1); the proofs unread." *by*

> **Read: the abstract, Theorem 1.1 and the introduction's passages on rational points and `ℚ(√n)²`** (2026-10-13, from
> a text extraction; FS131-PN1); **Appendix B, p. 44: its standing hypotheses, Lemma B.1 and its proof, read
> first-hand from the rendered page and formalized** (FS131-KC1, 2026-10-13:
> `Proofs/HadwigerNelson/Plane/LebesgueNumber.lean`; read again clause by clause at the landing, FS131-LC1, with p. 1,
> p. 2's definitions of `χ^(m)`, of a D-avoiding set and of the D-distance graph, and p. 46's first paragraph, the
> density-point argument); the other proofs unread. Rests on it: `Plane.chiM0_eq_chiLebesgue`,
> `Plane.chromaticNumber_plane_eq_chiLebesgue`.

`[DeCorteOliveiraVallentin2022]`, the library table's reading line — *add*: "the end of the proof of Lemma 5.6
(printed p. 22: the density points of a support are an independent set), from a text extraction of the library copy
(FS131-LC1, 2026-10-13) — the passage `[Davies2026]` p. 46 follows; the module cites it as that argument, not as a
statement about colour classes".

**10. The sentence a reader of the repository would be told** (the planner's draft 2, with one clause added: the
lemma alone does not make the correction — the density-point step stands between "almost every pair" and the lemma's
hypothesis):

> The chromatic number of the plane equals its Lebesgue-measurable chromatic number, `χ(ℝ²) = χ_m(ℝ²)` (Falconer's
> number). This library proves it in Lean from one declared outside theorem — the transfer of colourability to
> measurable colourings of `[OAIMath2026]` (family 158), which gives a measurable colouring proper at almost every
> unit pair — together with a lemma of J. Davies (`[Davies2026]`, Lemma B.1, p. 44), formalized here with its printed
> proof, and the density-point argument his paper follows (DeCorte, de Oliveira Filho and Vallentin), which together
> correct such a colouring on a null set to one proper at every unit pair. Those results are theirs; what is done here
> is the formalization of the lemma and the composition, which neither paper states as far as each was read. Nothing
> is said about Borel colourings, and no value is claimed.

**11. `data/fs131/claims-NF3.md`, a dated line** — *follows* the line of 18:00 UTC (ending "it is the step from
"almost every pair" to sets with no pair at the distance that the library holds for the plane only.)"):

> - 2026-10-13 @@GREENTIME@@ UTC — **Through the gate (FS131-LC1; gated commit `@@GATED9@@`; record
>   `plans/FS131-LC1-landing.md`).** NF3-PRINTED: **[kernel]**, formalized with its printed proof on the standard three
>   axioms (`exists_proper_ae_eq_of_proper_on_conull`, `exists_proper_nullMeasurable_of_avoiding_cover`,
>   `davies_lemma_B1_euclidean`, `Plane.davies_lemma_B1`), with fewer hypotheses than the page asks. NF3-WEAK-TO-PROPER:
>   **[kernel] for the plane and the unit distance** on the standard three (`Plane.exists_proper_of_nullMeasurable_weak`,
>   `Plane.chiM0_eq_chiLebesgue`); its clause for `ℝ^d` and a finite set of distances stays **[hand]**. NF3-PLANE:
>   **[kernel] on the one declared outside theorem** `Outside.OAI158.proper_to_borel_weak`
>   (`Plane.chromaticNumber_plane_eq_chiLebesgue`, `Plane.colorable_iff_exists_nullMeasurable_proper`). NF3-NC holds of
>   every docstring as read.

**12. The Frontier line and the Proof Atlas.** *Frontier, "Last filed"* — a clause in that list's own form:

> **the landing of FS-131's measurable number** (FS131-LC1, 2026-10-13: `Plane/LebesgueNumber` through the gate — 31
> theorems and 3 definitions; `χ_m⁰(ℝ²) = χ_m(ℝ²)` on the standard three axioms, a printed lemma of `[Davies2026]`
> formalized with its proof; `χ(ℝ²) = χ_m(ℝ²)`, Lebesgue-measurable classes and every unit pair, on the declared
> outside theorem `Outside.OAI158.proper_to_borel_weak`; other people's mathematics, composed; row 130's gap closed;
> no value moved)

*Proof Atlas*: ER1-WEAK-TO-PROPER's plane clause and ER1-PLANE-FALCONER: **[hand]/[derived] → [kernel]**, the second
with its one outside edge (`proper_to_borel_weak`); the node of `[Davies2026]` Lemma B.1: an outside statement →
**[kernel]** (formalized, no outside edge); ER1-WEAK-TO-PROPER's `ℝ^d` clause: no grade moves. Row 130's GAP node
(the null-set step) closes on `Plane.chiM0_eq_chiLebesgue`. No value moves.

**13. A correction owed that this landing found a second end of** (the planner's inventory item): `LEDGER.md`'s row
holding FS129-SA1-FALC-RED states, by hand and for `[Falconer1981]`'s lemmas, "`χ_m(ℝ²) ≥ k + 1` for Falconer's
everywhere-proper measurable chromatic number". **The kernel form is for the Borel number**: `falconer_reduction` asks
`MeasurableSet` classes and `le_chiM_of_falconerFan` bounds `Plane.chiM`. Wherever that row or the front page cites
either as its kernel theorem, the sentence owes "for Borel classes; `χ_B(ℝ²) ≥ k + 1`" — the bound on
`Plane.chiLebesgue` is not a corollary (`chiLebesgue ≤ chiM` points the other way), and its Lebesgue form (the cover
theorem with `NullMeasurableSet` classes) is stated nowhere in the library. Not drafted as a replacement: the row's
hand statement may well be right as printed in the paper; what is owed is the grade's scope.

**14. `ARCHITECTURE.md`**: nothing to file — the trust row's twelve records and the two corrected rows are on the
branch as landed (stage 3).
