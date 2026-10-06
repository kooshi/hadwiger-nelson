# FS131-LT5 — the gate's assumptions step lands

*The record of job FS131-LT5 (de Bruijn, the implementer; a tooling job and a landing). Brief:
`data/fs131/briefs/FS131-LT5-gate-step-land.md`. Worktree `.claude/worktrees/fs131-wlt`, branch `fs131-lt5`, cut from `main` at
`e9a65a86` and fast-forwarded to `dafb23fa` (the commit that carries the brief) before anything else. Everything this record cites
is under `data/fs131/lt5/`.*

## Theorems this phase proved

None. This job merges a tooling branch, edits docstrings, declares what the library assumes and runs the gate; it proves no
theorem, changes no statement, definition or proof, and moves no axiom count.

## Stage 1 — SAVED (FS131-LT5): the readback, what was read, the build as given

**The quotations.** The brief quotes fourteen statements, each as a first line with its source. All fourteen are whole lines of
their sources, verbatim, and each one cited with a section lies under that heading (`tools/fs131_lt5_readback.py`, output
`data/fs131/lt5/readback.out`: `quotations=14 mismatched=0`). The tool's controls (`--self-test`,
`data/fs131/lt5/readback-selftest.out`, four of four as expected): a faithful quotation reads MATCH; the same line with one
character changed, the same line cited under a section it is not in, and the same line cited from a file that does not exist each
read MISMATCH.

**What was read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and
watch it fail; the step's record on `fs131-t5` (`plans/FS131-T5-assumptions.md`, all six stages, "What is on its way", the eight
drafts) and its report (`data/fs131/reports/FS131-T5.md`); `scripts/Assumptions.lean` on that branch, all 869 lines — the scan and
the declared list, entry by entry; `scripts/assumptions.sh`; inventory items 548, 551 and 562 with its rulings (a)–(h);
`plans/FS131-L10B-landing.md` § Drafts for the front page (its draft 6, the table of hypotheses written for this job, and drafts
7–9) and "Theorems this phase proved, final"; `plans/FS131-L6A-landing.md` § Drafts items 1–6 (item 5, the named hypotheses; item
6, the open gate items). **Read by address, not whole**: the two landings' stage sections; the rest of the inventory.

**What the two landings say they brought, before the step is run** (the expectations the step's output is read against in
stage 3):

| from | what | the landing's reading |
|---|---|---|
| FS131-L10B draft 6 | the axiom `StandingFive.kloosterman_bound` | an outside theorem as an `axiom`, `[Weil1948]` p. 207; eight theorems rest on it |
| FS131-L10B draft 6 | `StandingFive.KloostermanBound` (named former) | the hypothesis form of the same theorem; taken by nine theorems; concluded by `kloostermanBound_of_ringChar_ne_two` over the axiom |
| FS131-L10B draft 6 | `StandingFive.StandingFloor` | discharged over the import (`standingFloor_seven_weil`, `standingFloor_five_weil`); still taken by `seven_le_localBound`, `five_le_chromaticNumber`, `standingFloor_mono` |
| FS131-L10B draft 6 | `five_le_chromaticNumber_weil`, binder `hRow123` | row 123's chain written out in a binder, closed; ours |
| FS131-L10B draft 6 | `sp_if_hypotheses_trivial_bot` | takes `BochnerHerglotz` at `unitRing ⊥` |
| FS131-L10B draft 6 | a hand result written out over a theorem's own variables | "this landing has none" |
| FS131-L10B | `Plane.falconer_lemma2_nonempty` | the axiom is a theorem since FS131-IF1: its four `RESTS` rows are stale |
| FS131-L6A draft 5 | `NoPar 𝒞` (`Plane/Saturated/MapColouring`) | "one named open statement … ours, proved nowhere" (C121-NOPAR at `k = 6`); taken by `gmap_ii`, `sat_noPar` |
| FS131-L6A draft 5 | `c.SingLocallyFinite`, and its local form | "a regularity hypothesis whose truth for every honest saturated colouring is the open claim C121-REGJ"; satisfied by `sq9` |
| FS131-L6A draft 5 | `GFin 𝒞` | "the other named open statement of that row; it stands on one side of `gmap_ii`'s equivalence and is no hypothesis" |

**The records the step resolves against, on this tree**: `BIBLIOGRAPHY.md` holds `**[Rudin1962]**` (l. 113) and
`**[Kakutani1938]**` (l. 114), the two rows the step's first run lacked (ruling 562 (a)), and `**[Lang1953]**` (l. 339).

**The build as given.** `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0: "All targets
up-to-date (5932 jobs)", "all 1831 modules already up to date, nothing built, 0 module(s) with warnings"
(`data/fs131/lt5/build-stage1.log`). No `sorry` as a term or a tactic under `Proofs/` (the word occurs in seven files' comments);
the axiom audit's `sorryAx` check is the receipt, at the gate.

**Token count at this stage**: I have no reading of the harness's count; my own estimate is about 190k, most of it the context
loaded at launch and this stage's reading.

## Stage 2 — SAVED (FS131-LT5): the merge

`git merge origin/fs131-t5` (tip `4dd69014`), trialled with `--no-commit` first (`data/fs131/lt5/merge-trial.out`: "Automatic
merge went well") and committed as `a95cd1ca`. It brings 35 files — `scripts/Assumptions.lean`, `scripts/assumptions.sh`,
`scripts/assumptions-controls.txt`, `scripts/assumptions-ledger.txt`, a change to `scripts/gate_report.py`, two tools, the step's
record and report, and 26 files under `data/fs131/t5/` — and **no file under `Proofs/`** (`git diff --stat HEAD~1 HEAD -- Proofs`
prints nothing). No conflict: `main` had not touched `scripts/gate_report.py` since the branch was cut at `3bfc7d2e`.

## Stage 3 — SAVED (FS131-LT5): the step on today's `main`, read before anything is declared

**The self-test first**, on the merged tree with the list as it came: `scripts/slot.py --mem 16 --cpus 4 -- ./scripts/assumptions.sh
--self-test`, exit 0, "OK — all 32 checks behaved" (`data/fs131/lt5/runs/selftest-as-merged.out`; the planted copy's scan,
`selftest-as-merged.scan.log`). Its controls plant their own axiom, formers and consumers, so they do not move with the library; the
run counts "the shipped list's own failures: 22" and leaves them to the gate.

**Then the gate**: `scripts/slot.py --mem 16 --cpus 4 -- ./scripts/assumptions.sh`, **exit 1, 22 failures**
(`data/fs131/lt5/runs/gate-as-merged.out`; the scan's full output, `scan-as-merged.log`).
`=== SCANNED === constants=13795 theorems=10173 formers=303 hypotheses=17192 closed=1473 untelescoped=0`;
`=== TOTALS === axioms=1 rests=8 named=18 inline=15 outside=5 ours=24 open=4 takes=87 mentions=1 produces=11 sites=26
conditions=31 declaredClosed=31 established=1433 premises=2 refuted=3 refutes=0 silent=11 derived=1 wrappers=0 cohyp=35 hints=4
unseen=15243 fails=8` (the scan's 8; the shell adds the ledger's 14). Against the step's own run at `3bfc7d2e`: 644 more
constants, 28 more formers, 5 more closed hypotheses, `unseen` 14112 → 15243.

**Every failure, by kind, with what it means.**

| kind | n | the rows | what it means |
|---|---|---|---|
| a consumer of an axiom that is gone (`stale-consumer`) | 4 | `RESTS Plane.falconer_lemma2_nonempty` ← `exists_mem_falconerE`, `falconer_reduction`, `fan_tip_ae_mem`, `le_chiM_of_falconerFan` | Falconer's Lemma 2 (i) is a theorem since FS131-IF1 (landed by FS131-L10B): the four rest on no axiom of the library now. The rows leave the ledger. |
| a theorem resting on an axiom the ledger does not list (`unlisted-consumer`, `RESTS`) | 8 | `RESTS StandingFive.kloosterman_bound` ← `circle_sum_le_weil`, `five_le_chromaticNumber_weil`, `kloostermanBound_of_ringChar_ne_two`, `seven_le_localBound_weil`, `standingFloor_five_weil`, `standingFloor_seven_weil`, `targetFloor_seven_weil`, `targetFloor_six_weil` | Weil's bound is the library's one outside axiom (`ref=bib:Weil1948`, read by the scan from the axiom's docstring). The eight are exactly the eight IMPORTED records of FS131-L10B's draft 6 — the scan reads every theorem of the library, not the audit's records, and finds no ninth. The rows enter the ledger. |
| a theorem taking a declared hypothesis that the ledger does not list (`unlisted-consumer`, `TAKES`) | 2 | `BochnerHerglotz` ← `SpectralInputs.sp_if_hypotheses_trivial_bot`; `StandingFloor` ← `StandingFive.standingFloor_mono` | Both landed with wave 10: the model of `sp_if`'s hypotheses is given Herglotz–Bochner (L10B's table); the monotonicity lemma takes the floor at a variable. |
| a former whose docstring calls it an assumption, undeclared (`undeclared-by-docstring`) | 1 | `StandingFive.KloostermanBound` | its docstring: "a named classical hypothesis … (`[Weil1948]` p. 207 …)". The step asks for it. |
| a closed hypothesis nobody declared (`undeclared-closed-hypothesis`) | 4 | `five_le_chromaticNumber_weil:hRow123`; `standingFloor_seven:hK`, `standingFloor_five:hK`, `seven_le_localBound_of_kloosterman:hK` | `hRow123` is row 123's chain written out, the proposition already declared at `five_le_chromaticNumber` (label `Row123Chain`). `hK` is `∀ F [Field F] …, card F % 4 = 3 → 347 ≤ card F → KloostermanBound F`: Weil's bound at a family of fields, a closed statement. |
| a former no theorem concludes, in neither list (`undeclared-never-concluded`) | 3 | `Plane.GrundyBound` (taken by `gmap_i`), `Plane.H1On` (by `AeColouring.twoColourNhd_of_h1`), `Plane.NoPar` (by `sat_noPar`, `gmap_ii`) | wave 6's first half: each is an assumption or a condition, to be said. |
| a declared hypothesis a theorem now proves (`discharged`) | 0 | — | **the step printed none.** `StandingFloor` is proved at 7 and at 5 (`PRODUCES StandingFloor standingFloor_seven_weil uncond`, `…_five_weil uncond`), not over a variable, and the rule fires only on a former proved in general. Stage 4 says what follows. |

22 = 4 + 8 + 2 + 1 + 4 + 3. **Counted, not failing**: `hints` 3 → 4 (`five_le_chromaticNumber_weil`, whose docstring says "a named
hypothesis from outside the backlog" of `hRow123`, undeclared until stage 4); `cohyp` 34 → 35; `silent=11`, the same eleven; the
digest's two flags — the ledger's header stale (`rests 4 → 8, takes 85 → 87`) and the nine counts absent from `CLAUDE.md`.

**What the step did not need to be told**: `SingLocallyFinite` (FS131-L6A draft 5: "a regularity hypothesis whose truth for every
honest saturated colouring is the open claim C121-REGJ") is concluded by a theorem with no assumption (`sq9_singLocallyFinite`), so
the scan reads it as an ordinary predicate of the theorem's colouring; `GFin` stands under `↔` in `gmap_ii` and is taken by nothing.

**Read against the two landings' tables (stage 1)**: every row of the table is met by a row of the scan — the axiom and its eight;
`KloostermanBound`; `hRow123`, closed, found by the step itself; `sp_if_hypotheses_trivial_bot`; Falconer's four stale rows;
`NoPar`. **The scan found two things the tables do not list**: `GrundyBound` and `H1On`, both conditions by my reading (stage 4);
and one consumer, `standingFloor_mono`. No assumption on `main` that no record names.

**The docstrings read for the words** (the class the step cannot see: a hand result written out over a theorem's own variables).
`tools/fs131_lt5_docwords.py` extracts every doc comment of a module with the declaration that follows it and prints those holding
any of 29 words ("named hypothes", "[hand", "open question", "proved nowhere", "assum", …); it decides nothing, and each hit was
read (`--self-test`, `data/fs131/lt5/docwords-selftest.out`: a docstring with a word, one split across two lines and a module doc
are found; a plain docstring and a `--` comment are not).
- **Wave 6's first half, fourteen modules of `Plane/Saturated/`** (`data/fs131/lt5/docwords-wave6.out`): 579 doc comments, 4
  with a word — `gmap_ii` ("C121-NOPAR and G-FIN₆ are the two named open statements, hypotheses here and proved nowhere"),
  `sat_noPar` ("C121-NOPAR, a named open statement"), `sq9Map_sat_model` (a note on the same), and `SingLocallyFinite`'s
  definition ("C121-REGJ's open question, FS-127"). **No hand result or open question is written out in a binder over a theorem's
  own variables**: the one open statement taken is the named former `NoPar`, which the step found.
- **Wave 10's second half, twelve new modules and three changed** (`docwords-wave10.out`): 437 doc comments, 20 with a word, each
  about `KloostermanBound`, `StandingFloor`, `BochnerHerglotz`, `BochnerOn`, the import, or `hRow123`. None beyond those — as
  FS131-L10B's draft 6 says ("this landing has none").

**Token count at this stage**: no reading of the harness's count; own estimate about 300k.

## Stage 4 — SAVED (FS131-LT5): everything declared, from the records

One line of `AssumptionAudit.declared` (`scripts/Assumptions.lean`) per failure of stage 3, each decided from the definition's
docstring and the landings' tables. With them the scan's own failures are 0 (`data/fs131/lt5/runs/gate-declared-before-ledger.out`,
`fails=0`); what remained was the ledger (stage 8).

| failure of stage 3 | the line | decided from |
|---|---|---|
| `undeclared-by-docstring StandingFive.KloostermanBound` | `.former … .outside "[Weil1948] p. 207 (Weil's bound for Kloosterman sums over a finite field), in hypothesis form: the same outside theorem as the import StandingFive.kloosterman_bound, which proves it at characteristic not 2 …"` | its docstring ("a named classical hypothesis … `[Weil1948]` p. 207 … the import is `StandingFive.kloosterman_bound`"); FS131-L10B draft 6, row 1; the brief's pre-ruling ("declared only if the step asks for it; if it does, it is an outside theorem under the key of the import") — the step asked |
| `undeclared-closed-hypothesis` at `hK` of `standingFloor_seven`, `standingFloor_five`, `seven_le_localBound_of_kloosterman` | three `.site … `hK "KloostermanFrom347" .outside "[Weil1948] p. 207, at every finite field of q ≡ 3 (mod 4), q ≥ 347 elements …"` | the theorems' docstrings ("over Weil's bound for Kloosterman sums at the fields of `q ≡ 3 (mod 4)`, `q ≥ 347` elements"); L10B draft 6 names the three |
| `undeclared-closed-hypothesis five_le_chromaticNumber_weil:hRow123` | `.site … `hRow123 "Row123Chain" .ours "row 123 …"`, the label and source of the entry already there for `five_le_chromaticNumber` | its docstring ("row 123's chain (`hRow123`, …, a named hypothesis from outside the backlog; MR is inside it …)"); L10B draft 6, row 4 |
| `undeclared-never-concluded Plane.NoPar` | `.former … .open "C121-NOPAR (𝒫₆ is empty on the locally finite map colourings: the former is stated for every class of families, and the open statement is its instance there; …)"` | `gmap_ii`'s docstring ("C121-NOPAR and G-FIN₆ are the two named open statements, hypotheses here and proved nowhere"), `sat_noPar`'s ("C121-NOPAR, a named open statement"); FS131-L6A draft 5 ("One named open statement is taken as a hypothesis: `NoPar 𝒞`") |
| `undeclared-never-concluded Plane.GrundyBound` | `.condition … "a Grundy-bound family …: a predicate of the theorem's family; no Lean family is shown to be one (an open gate item of FS131-L6A, draft 6)"` | its definition (a property of the family `A`); its one taker `gmap_i`; L6A draft 6 lists it as a missing inhabitant, not as an assumption |
| `undeclared-never-concluded Plane.H1On` | `.condition … "(H1) on N for two classes — every other class is null in N: a predicate of the theorem's family, set and two colours"` | its definition (`∀ j, j ≠ a → j ≠ b → volume (C j ∩ N) = 0`); its taker `AeColouring.twoColourNhd_of_h1` |

**Entries that left.** `.former StandingFive.StandingFloor .ours "G56 …"` — see below. Nothing else: no assumption of the list became
an axiom (Weil's bound was never in the list), and Falconer's lemma was an axiom, so its leaving is the ledger's (stage 8).

**The two pre-ruled cases, and what the step did with each.**

1. **`StandingFloor`: the step's rule did not fire; the entry leaves on the coordinator's ruling, with a docstring edit.** The brief:
   its entry leaves "by the step's own rule for a proved assumption". The rule (`discharged`) fires only on a former proved over its
   own variables with no hypothesis; `standingFloor_seven_weil : StandingFloor 7` and `standingFloor_five_weil` are instances
   (`PRODUCES … uncond`), and the step's own control has as its silent partner "one proved at an instance still is" an assumption.
   So with the entry present the step said nothing; with it removed the two closed takers read `CLOSED ESTABLISHED` — and the scan
   failed `undeclared-by-docstring StandingFloor`, because its docstring said "a named hypothesis from outside the backlog (G56). …
   [tools]/[hand], not kernel", in a module outside the step's draft 8. The step's rules and the reading disagreed, so I messaged the
   coordinator with both ways. **Ruling (the coordinator's message, 2026-10-06): the entry leaves, and docstrings — nothing else — in
   `Arith/StandingFive.lean` may be edited to say what is true now, "over the import", not "proved" alone; "My brief's sentence was
   wrong about the mechanism — the step's rule for a proved assumption does not fire on an instance"; not the other way, which
   "would count as a hand result of ours something the kernel holds over the import at both instances where it is taken closed".**
   After it: `CLOSED ESTABLISHED StandingFive.seven_le_localBound hFloor :: StandingFloor 7` and `… five_le_chromaticNumber hFloor ::
   StandingFloor 5` (`established` 1433 → 1435), each through a theorem that is a `RESTS` row of the import. `le_localBound` and
   `standingFloor_mono` take the floor at a variable `n`: a condition there, in `unseen`.
2. **`KloostermanBound`: the step asked, twice.** By docstring for the former, and by the closed rule for the three `hK` — which
   the former's entry does not cover: the scan reads `TAKES KloostermanBound standingFloor_seven` and still fails the binder, because
   a closed `∀ F, … → KloostermanBound F` is not *headed* by the former (the design's (d): "its head is a declared former (a named
   assumption at a closed instance)"). Declared as three sites under one label. **So Weil's bound is listed in three forms** — the
   axiom (8 theorems rest on it), the named hypothesis (9 statements) and the label `KloostermanFrom347` (3 statements, which are
   also among the 9) — which is what the library holds today. The alternative, making the scan read a closed family of a declared
   former as declared through it, is a rule changed after it failed; not made. Ratified by the coordinator's message ("the rule
   change that would hide the third is rightly not made after a failure").

**A hand result written out over a theorem's own variables** (the one thing the step cannot find): none in either landing —
stage 3's reading of the docstrings, and FS131-L10B's draft 6 for wave 10.

**No assumption that no record names, and no docstring disagreeing with a record about whose a hypothesis is**, beyond case 1.

## Stage 5 — SAVED (FS131-LT5): the second reading of the branch's 31 conditions and 2 premises

Each read against its definition (`data/fs131/lt5/conditions-defs.out`: the definition with its docstring) and the statements that
take it (`data/fs131/lt5/condition-takers.lean`, output `condition-takers.out`: from the stored types, the constants that mention
the former in a hypothesis, in the conclusion, and the definitions whose body holds it). The question asked of each: does a theorem
that takes it ask its reader to accept, on someone's word, a statement about the world — or does it restrict the objects the theorem
is about? **I agree with all 33. None would I class as an assumption.**

| entry | what it is, by its definition | taken by | reading |
|---|---|---|---|
| `SpectralChain.TCA` | every stable place of `F` has all-levels four-colour ratio `< 1/4`: a property of the field | 3 theorems, only as the conclusion of `hCLS` (declared, X23D-CLS) and the antecedent of `hMR`; inside `Interface.Count` | agree — a predicate of `F`; what is assumed about it is `hCLS`, declared |
| `Arith.IsUsablePrime` | a maximal ideal with residue field of size `≡ 3 (mod 4)` | 5 | agree |
| `Arith.NoAffFieldHyp` | a disjunction of conditions on `F` and `k` (a usable prime of a given size, or a bound on `χ(F²)`) | 2 (`noAffine_fields`, `exists_hom_slack`) | agree — the user proves it for their field |
| `ExtensionOrder` | an inductive predicate of a vertex list | its own API, `extends_of_extensionOrder` | agree |
| `IsLift` | a deformation has every listed edge of quadrance one | 2; refuted by 4 `_no_lift` theorems | agree |
| `Plane.AeProperRegions.IsRegion` | a colour and a connected component of its class | 4, its own lemmas | agree |
| `Plane.Arc.IsUnitArc` | an arc of radius 1, by cases on the arc | 8 | agree — decided on written-down data |
| `Plane.ArcMap.BaseCtx` | the bundled hypotheses of `Row134BaseUA` | 35, each a step of the refutation | agree — `BaseCtx.false` proves `False` from it with no other hypothesis (`Plane/ValidMap/BaseDense.lean:174`), so no taker asserts anything on anyone's word |
| `Plane.ArcMap.Condition6` | no trichromatic vertex of degree above 3, read on the theorem's map | 1 (`ts_t_degree_three`) | agree |
| `Plane.ArcMap.CrossesAt` | a colour crosses `ω(v)` at an angle | 4 | agree |
| `Plane.ArcMap.DoubleEvent` | a configuration of two rings | 1 (`bv_nd`) | agree |
| `Plane.ArcMap.HexRing` | six rotating points on a ring | 2 | agree |
| `Plane.ArcMap.IsEssBoundary` | at least two essential colours at a point | 1 (`echo`) | agree |
| `Plane.ArcMap.Near.RayConfig` | a structure of inequalities on a chart's germs | 28, its own lemmas | agree |
| `Plane.ArcMap.OnRingArc` | a point on an arc of `Γ` on `ω(p)` | 16 | agree |
| `Plane.ArcMap.RingProper` | `ω(u)` meets `Γ` finitely and has no like-coloured change points at distance 1 | 2 | agree |
| `Plane.ArcMap.SaturatedAt` | each essential colour at `w` has support at distance 1 | 1 (`echo`) | agree |
| `Plane.ArcMap.Terminal` | no move available anywhere in the theorem's map | 13 | agree — whether a terminal plane map with a stuck vertex exists is an open question, and the takers' docstrings say so; the hypothesis is still about the theorem's map |
| `Plane.ArcMap.Todo` | a move is available or a unit arc is bad at `v` | 4, the procedure's invariant | agree |
| `Plane.BranchGerms.Sorted` | germs sorted lexicographically | 6 | agree |
| `Plane.CPColouring.RotationInvariant` | the law of the theorem's CP colouring is rotation-invariant | 1 | agree |
| `Plane.InSixLens` | a point in a lens | 4 | agree |
| `Plane.IsAdmissible` | measurable classes with null unit pairs | 4 | agree |
| `Plane.IsRegOf` | a region of a family of classes | 4, its own lemmas | agree |
| `Plane.IsSelection` | a measurable colouring choosing from a family | 1 | agree |
| `SpectralInputs.IsHaarFourier` | a probability measure whose Fourier coefficients vanish off 0 | 5; produced by `exists_isHaarFourier` and `sp_if_hypotheses_trivial_bot`, both over `BochnerHerglotz` (declared) | agree — a predicate of the theorem's measure; its existence is the declared outside theorem's, and that is where the assumption is listed |
| `SpectralChain.IsTraceSpectral` | a finite measure with the colouring's correlations as Fourier coefficients | 1; inside `Interface.R88TCA`, `APlus0` | agree |
| `SpectralInputs.IsSpectralMeasureOf` | a spectral measure of a vector | 1 (`spectral_carried_iff`) | agree — no declaration exhibits one (an open gate item, not an assumption) |
| `SpernerGrid.Rainbow` | three labels pairwise distinct | 2 | agree |
| `Strip.WindowProper` | a structure of decidable conditions on a window | its own API, `window_extends` | agree |
| `Thomassen.IsTwoSep` | two distinct vertices whose removal leaves a finite component | 1 | agree |
| premise `deGrey_bound_of_not_colorable:hG` | `¬ (edgeGraph 1581 deGrey.edges).Colorable 4` | — | agree — checked: `deGreyRot_not_colorable_four` proves the rotated presentation's (`Instances/DeGrey/Bound.lean:123`), `chromaticNumber_plane_ge_five` concludes the bound from it with no hypothesis (l. 140), and no declaration under `Proofs/` uses `deGrey_bound_of_not_colorable` (`rg`: its own file and the axiom audit) |
| premise `Plane.voronov11_of_forall_mu_lt:H` | `∀ ε > 0, mu 6 ε < 1` | — | agree — the theorem concludes the declared assumption `Voronov11` from it (`PRODUCES … cond`): one half of the equivalence `forall_mu_six_lt_one_iff`, whose content is the implication |

**The two conditions this job added** (`GrundyBound`, `H1On`) are mine, one mind, and are in stage 4's table for a later reader.
**One thing the reading turned up that is not an assumption**: `Plane.NoPar`'s docstring carries none of the words the step reads
for its kind, so it is the one `SILENT` row (stage 6).

## Stage 6 — SAVED (FS131-LT5): the docstrings — comments and nothing else, shown twice

**The edits** (the step's draft 8, items (a)–(e); and `Arith/StandingFive.lean` on the coordinator's ruling): 22 doc comments in 9
modules.

| item | declaration | what the docstring now says |
|---|---|---|
| (a) | `Bridge.RealAlgebraicDescent` | "an external theorem, taken as a hypothesis … Artin–Lang, `[Lang1953]`, not read: cited through `[GoelPatilVerma2022]` Thm 3.11" |
| (a) | `Interface.RU`, `APlus0`, `PE2`, `EFPlus`, `MR`, `APlusOfR88` (`SpectralChain`); `MulStable`, `NegCircle` (`Arith/SpectralInputs`) | "A hand result of ours ([hand], <its entry>), taken as a hypothesis: not in the kernel." — each grade copied from its record: J45's table (`plans/FS84-SI-D-derivation.md`: J45-RU, -A⁺, -SP-if, each [hand]); row 120 ("[hand; PE-2 two derivations blind to each other (X02D, X02V) …") |
| (a) | `CharacterColouring.OrderBound` | "Where a theorem takes it at a closed instance (`cl2`: the band at 4, `N = 168`) it is a hand result of ours ([hand], FS89-S0A-3, two derivations)" — `LEDGER.md` § B: "hand, two derivations (blind)" |
| (a) | `SevenConditional.G4` | "a measurement of ours, graded [tools] / [measured] — one CaDiCaL refusal with no proof log (`LEDGER.md` rows 103 and 47)" — row 103: "conditional on `G4`, a measurement"; "one CaDiCaL refusal with no proof log (row 47)" |
| (b) | `SpectralChain.BochnerHerglotz`, `SpectralInputs.BochnerOn` | the key in brackets, `[Rudin1962]` |
| (c) | `SpectralChain.InvariantMeasureOnClosed` | "Markov–Kakutani — `[Kakutani1938]`, not read" |
| (d) | `Plane.Voronov11` | **the ruled sentence**: "An outside theorem, not an `axiom` of this library: it is taken as a hypothesis by one theorem, `mu_lt_of_voronov11`, and stated under an equivalence by another, `forall_mu_six_lt_one_iff` (FS106-COMP's second clause), which does not use it." (replacing "Named here, not imported (FS106-COMP's clause is an equivalence, not a use).") |
| (e) | `Plane.ArcMap.flankQ_upper`, `flankQ_lower`, `flankQ_upper_of_qrOnly` | `hQR` is "a condition on the map that holds wherever every unit arc is (Q) or (R2): `flankQ_upper_of_qrOnly` … discharges it"; the words "a named hypothesis" are gone |
| ruling | `StandingFive.StandingFloor` | "**No longer an assumption in hypothesis form**: it is proved at 7 and at 5 over the library's one declared import, Weil's bound for Kloosterman sums (`[Weil1948]` p. 207, the axiom `StandingFive.kloosterman_bound`) … The dependence moved from a hypothesis to that axiom; the theorems below that take the floor as a hypothesis keep their statements." |
| ruling | `StandingFive.seven_le_localBound`; the section heading before `normOneCayley`; the module doc's paragraph "What is not" | the same, in each place that said "a named hypothesis from outside the backlog". **The module doc is a fourth doc comment in that file; the ruling named three.** Its paragraph said the floor "is neither in the kernel nor in the backlog", which the three edits would have left contradicting them; one sentence added. |

**Shown by two instruments** (`tools/fs131_lt5_docstring_check.py`; `--self-test`, `data/fs131/lt5/docstring-check-selftest.out`,
17 of 17: a reworded docstring and module doc pass; a character of a statement, of a `--` comment, of a plain block comment and of a
string literal each fail; a docstring whose terminator is deleted so that it swallows the theorem below fails; a docstring added
fails; and, for the dump, a reworded docstring gives an identical dump while a changed binder, a changed value and a removed theorem
are each named, and a dump cut before its `COUNT` line is refused):

1. **Text**: every doc comment of both versions replaced by a placeholder, the rest compared byte for byte — `text HEAD` before the
   commit: `files=9 doc-comments-changed=22 failed=0` (`data/fs131/lt5/docstring-text-check.out`, which lists the 22 with their
   declarations).
2. **Elaborated**, independent of the lexer: every constant of the nine modules, from the built library — its stored type (hash,
   and the length and hash of its full debug text), kind, universe parameters, and a definition's value hash — dumped before the
   first edit (`sigs-before.txt`) and after the rebuild (`sigs-after.txt`): `before=1453 after=1453 (theorems before=1223)
   missing=0 added=0 changed=0`, "IDENTICAL" (`sigs-compare.out`).

**The rebuild**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0 — "471 of 471 batches,
62 module(s) rebuilt, 0 module(s) with warnings, 17m21s" (`data/fs131/lt5/build-docstrings.log`).

**The step's counts as they now stand**: **`silent=1`** (11 before) — `SILENT HadwigerNelson.Plane.NoPar kind=open`: its docstring
("`𝒫_k` is empty on a class `𝒞` of families (C121-NOPAR is this at `k = 6` for the locally finite map colourings)") has no kind word,
and `Plane/Saturated/MapColouring.lean` is in no list of modules I may edit; a line for the next landing that touches it: add "an open
question" to that docstring. **`hints=0`** (4 before): the three `flankQ_*` reworded, and `five_le_chromaticNumber_weil` is now a
consumer.

## Stage 7 — SAVED (FS131-LT5): the one ruled change to the instrument — absent counts fail

`scripts/gate_report.py`, `assumptions`: when `CLAUDE.md` § Trust ledger records none of the nine counts the digest now **refuses
(exit 3)**, after printing the full digest, with the sentence's counts in the message — "RECORDED COUNTS ABSENT in CLAUDE.md § Trust
ledger — it records none of the nine; add: `axioms=…`" and, in the refusal, "Add the sentence that holds them: `…`".
`scripts/assumptions.sh` turns exit 3 into its own failure, as it did for a partial or doubled record. A drifted record is still
flagged and not failed: a landing moves the counts before the front page is refiled.

**The control, red and green** (`./scripts/assumptions.sh --self-test`, now 33 checks; `data/fs131/lt5/runs/selftest-declared.out`):
`digest match` — a one-section copy of `CLAUDE.md` with the sentence: exit 0, "match (9 of 9 compared)"; `digest absent` — the same
copy with the sentence removed: **exit 3**, "RECORDED COUNTS ABSENT" (it was exit 0 before this change); `digest
absent-says-what-to-add`: exit 3 and the message holds the nine counts to record.

**And on the real file, both ways** (the list as declared, the ledger rewritten):
- against `data/fs131/lt5/drafts/CLAUDE-with-sentence.md` (`ASSUMPTIONS_CLAUDE`; the gate prints a NOTE saying which file it read):
  **exit 0** — "assumptions: OK — 1 outside theorem(s) as axioms, with 8 theorem(s) resting on them; 19 named and 16 inline
  hypotheses (7 outside, 23 ours, 5 open), taken by 98 statement(s) and mentioned by 1"; both records "match (9 of 9 compared)"
  (`data/fs131/lt5/runs/gate-with-draft.out`);
- against the repository's own `CLAUDE.md`, which does not hold the sentence: **exit 1, by that refusal alone** — the scan's
  `fails=0`, the ledger's header "match (9 of 9 compared)", then "assumptions: FAIL — a recorded count is absent or could not be read"
  (`data/fs131/lt5/runs/gate-repo-claude.out`).

**So `./scripts/assumptions.sh` is red on `main` from this landing until the paragraph of draft 1 is filed** — the brief's "The first
filing is then: I add the sentence, and the digest passes". The draft copy is made by `tools/fs131_lt5_claude_draft.py`, which reads
the counts from a scan's saved output and refuses if `CLAUDE.md` already records one.

**A second change, for the control's own control**: `scripts/assumptions.sh` reads the digest script's path from
`ASSUMPTIONS_GATE_REPORT` (default: the shipped one; a NOTE is printed when it is another), as it already read the audit's from
`ASSUMPTIONS_AUDIT`, so that `tools/fs131_lt5_digest_mutate.py` can switch one decision of the digest off in a copy and require the
self-test to fail and name the control built for it. Its result is in stage 9.

## Stage 8 — SAVED (FS131-LT5): the ledger

`./scripts/assumptions.sh --write-ledger` (against the draft copy, since the run refuses on an absent record): exit 0, "ledger
written (107 rows)" (`data/fs131/lt5/runs/write-ledger.out`). 90 rows before; **24 added, 7 removed**. Every row, read:

**Added — each is a statement of this library that is conditional on something.**

| rows | n | read |
|---|---|---|
| `RESTS StandingFive.kloosterman_bound` ← `kloostermanBound_of_ringChar_ne_two`, `circle_sum_le_weil`, `targetFloor_seven_weil`, `targetFloor_six_weil`, `standingFloor_seven_weil`, `standingFloor_five_weil`, `seven_le_localBound_weil`, `five_le_chromaticNumber_weil` | 8 | the eight theorems whose stored axiom lists hold Weil's bound — the passage to the hypothesis form, the circle-sum bound, the floors at seven (`Q ≥ 98`) and six (`Q ≥ 62`) of the norm-one targets, the standing floor at 7 and 5, `7 ≤ L(F)` at the standing field, and `χ(F²) ≥ 5` there (which also takes row 123's chain). The audit's eight IMPORTED records, and no ninth theorem anywhere in the library |
| `TAKES StandingFive.KloostermanBound` ← `circle_sum_le`, `circle_sum_le_of_ne`, `kloosterman_page_of_kloostermanBound` (at the theorem's field); `normOne_charSum_ge`, `targetFloor_seven_of_kloosterman`, `targetFloor_six_of_kloosterman` (at every field of `Q` elements); `standingFloor_seven`, `standingFloor_five`, `seven_le_localBound_of_kloosterman` (at every field of `q ≡ 3 (mod 4)`, `q ≥ 347` elements) | 9 | the hypothesis forms wave 10 kept: each says "if Weil's bound holds at these fields, then …" and prints the standard three; FS131-L10B's nine, name for name |
| `TAKES inline:KloostermanFrom347` ← `standingFloor_seven`, `standingFloor_five`, `seven_le_localBound_of_kloosterman` | 3 | the last three of the nine again: there the hypothesis is closed, and the step wants the binder itself declared (stage 4, case 2) |
| `TAKES inline:Row123Chain` ← `five_le_chromaticNumber_weil` | 1 | `χ(F²) ≥ 5` at the standing field rests on the import **and** on row 123's chain, a hand result of ours with measure rigidity inside it |
| `TAKES SpectralChain.BochnerHerglotz` ← `SpectralInputs.sp_if_hypotheses_trivial_bot` | 1 | the model of `sp_if`'s hypotheses exists given Herglotz–Bochner at `ℚ` |
| `TAKES Plane.NoPar` ← `gmap_ii`, `sat_noPar` | 2 | FS121-C1-GMAP (ii) and FS121-C1-SAT's "so" clause are conditional on `𝒫₆` being empty on the theorem's class — at the locally finite map colourings, the open statement C121-NOPAR |

**Removed.**

| rows | n | read |
|---|---|---|
| `RESTS Plane.falconer_lemma2_nonempty` ← `exists_mem_falconerE`, `falconer_reduction`, `fan_tip_ae_mem`, `le_chiM_of_falconerFan` | 4 | Falconer's Lemma 2 (i) is a theorem: the four are unconditional now |
| `TAKES StandingFive.StandingFloor` ← `five_le_chromaticNumber`, `le_localBound`, `seven_le_localBound` | 3 | the floor left the list (stage 4, case 1); the three still take it in their statements, and the library proves it at 7 and at 5 over the import |

The header: `axioms=1 rests=8 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1` (8 + 98 + 1 = 107 rows).

**Token count at this stage**: no reading of the harness's count; own estimate about 420k.

## Stage 9 — SAVED (FS131-LT5): the full gate on one commit — twice, on `50ad7266` and on the merge of `main`, `c5a4565f`

One pass is every step in order, one at a time under the slot (`data/fs131/lt5/run-gate.sh <tag>`; every log under
`data/fs131/lt5/gate/` with its exit status on its last line; `run-gate-<tag>.head` records the commit and that **no tracked file
was modified**; `run-pass-<tag>.out` holds every step's exit).

- **First pass, tag `final`, on `50ad7266`** (the commit of stages 4–8): every step exit 0 but the one that is red by design.
- **`main` had moved** (15 commits, to `dc738cec`): merged as `c5a4565f`. The merge brings 62 files — `plans/`, `data/`,
  `BIBLIOGRAPHY.md` (four rows amended; the set of `**[Key]**` rows is unchanged, by `diff`), the search lane's four tools, and
  **one file outside the exempt paths, `tools/ext_hn2_links.py`** (another job's reader of an outside repository's README; no gate
  step reads it) — and no file under `Proofs/` or `scripts/` (`data/fs131/lt5/merge-main-nonexempt.txt`). The coordinator's
  word exempts `plans/`, `data/`, `.claude/`, `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md` and `tools/search_20261006_*.py`, and
  "anything else under `tools/` or `scripts/` still" calls for a re-run; so:
- **Second pass, tag `landed`, on `c5a4565f`**: the whole gate again. **Every quoted line of the table below is the same in both
  passes** (the logs are `<step>-final.*` and `<step>-landed.*`).

| step | result, read from its saved log | log (`data/fs131/lt5/gate/`) |
|---|---|---|
| build | "build: OK — all 1831 modules already up to date, nothing built, 0 module(s) with warnings"; the rebuild of these Lean sources is stage 6's — 471 of 471 batches, 62 modules rebuilt, **0 modules with warnings** (the one line holding the word "warning" in each log is that sentence) | `build-final.log`; `../build-docstrings.log` |
| `sorry` | narrow pattern (`^\s*sorry\s*$`, `:= sorry`, `by sorry`): **0** lines; `\bsorry\b`: 8, all prose, the eight `main` holds | `sorry-narrow-final.txt`, `sorry-wide-final.txt` |
| doubled names, **before the audit** | "dupnames: OK — no name is declared by two modules (23 generated on demand, listed above)" | `dupnames-final.log` |
| its self-test | "OK — all 15 controls behaved: every planted fault fired, and every partner passed." | `dupnames-selftest-final.log` |
| axioms | "audited: 6334 records — 6304 clean on the standard axioms, 17 axiom-free, 8 imported (resting on a declared outside theorem), 5 declared purchase(s)"; "declared imports (1): HadwigerNelson.StandingFive.kloosterman_bound"; "axioms: OK" — **the record counts unchanged from the second landing's**, and the digest against its receipt (`data/fs131/l10b/receipt-axioms-final.log`): `CLAUDE.md` "match (clean, purchases and imported compared)" | `axioms-final.log`, `receipt-axioms-final.log`, `digest-axioms-final.txt` |
| its self-test | "OK — every planted fault fired, and every partner passed." (23 controls) | `axioms-selftest-final.log` |
| vacuity | "scanned: declarations=14501  refutations-skipped=199"; "sites:   sites=1269  vacuous=0  stale=0  declared=3  witnessed=38  generic=1226  unknown=2"; "vacuity: OK"; the baseline's header and `CLAUDE.md` § The gate each "match (9 of 9 compared)" — **both lines unchanged**, and against the second landing's receipt "counts: unchanged", "rows: none changed" | `vacuity-final.log`, `receipt-vacuity-final.log`, `digest-vacuity-final.txt` |
| its self-test | "OK — all 65 controls behaved: every one fired, and the silent ones stayed silent." | `vacuity-selftest-final.log` |
| **assumptions**, against the draft copy of `CLAUDE.md` | "assumptions: OK — 1 outside theorem(s) as axioms, with 8 theorem(s) resting on them; 19 named and 16 inline hypotheses (7 outside, 23 ours, 5 open), taken by 98 statement(s) and mentioned by 1"; the ledger's header and the draft each "match (9 of 9 compared)" | `assumptions-draft-claude-final.log`, `receipt-assumptions-final.log` |
| **assumptions**, against the repository's own `CLAUDE.md` | **exit 1, by design** (stage 7): the scan's `fails=0`, then "assumptions: FAIL — a recorded count is absent or could not be read"; green at the filing of draft 1 | `assumptions-repo-claude-final.log` |
| its self-test | "OK — all 33 checks behaved: every planted fault fired, and every partner stayed silent." (21 controls in one planted copy, the two-sided check, 4 accounting, 7 digest) | `assumptions-selftest-final.log`, `receipt-assumptions-self-test-final.log` |
| architecture | "RESULT: PASS" | `arch-final.txt` |
| guarded lint (`lake lint --no-build -- --no-build --trace`, `--mem 8`) | exit 0, "-- Linting passed for Proofs.", 14 linters each "(2/2) Passed!" | `lint-final.log` |
| notes | on this tree (`tools/fs131_l5_notes.py --only-flagged`, QA4's check through its working-tree wrapper, exit 1 on a CONFLICT): "notes read: 196 LOCAL-SAID=31 NO-OBJECT=48 NONE-SAID=59 no-conflict=58", **0 CONFLICT** — `main`'s count, unchanged; `tools/fs131_qa4_notes.py --self-test`: "OK (6 controls, 1 planted)". (`tools/fs131_qa4_notes.py list`, run too, reads QA4's own fixed commits with `git show` and never a working tree: its 17 CONFLICT lines are that audit's finding, repaired since — `notes-qa4-final.txt`.) | `notes-l5-final.txt`, `notes-qa4-selftest-final.txt` |
| records, against the kernel's own list | "main: 9513 theorems; landing: 9513; wave (landing only): 0 …; gone (main only): 0; records in the log: 6334", "records: PASS"; and the kernel's list of declarations (`data/fs131/l5/count-modules.lean`, 14,501 `DECL` lines) is, sorted, byte-identical to the second landing's (`cmp`, exit 0): **this landing adds no declaration and removes none** | `records-final.txt`, `count-modules-final.out` |

**Each check's negative control, watched.** The four self-tests above (15, 23, 65 and 33 controls, each a planted fault seen to
fire with its silent partner). This job's own tools, each with a `--self-test` that plants faults (stages 1, 3, 6). And two
mutation runs, where a decision of the instrument is switched off in a copy and the self-test must fail **and name the control
built for that decision**:

- **The digest's decisions about the recorded counts** (`tools/fs131_lt5_digest_mutate.py`, on `c5a4565f`;
  `data/fs131/lt5/gate/digest-mutations.out`, exit 0): **4 of 4 caught.** With "absence fails" switched off the self-test fails and
  names `digest absent` ("expected exit 3 and 'RECORDED COUNTS ABSENT', got exit 0"); with the refusal's sentence cut it names
  `digest absent-says-what-to-add`; with a doubled record let through, `digest doubled`; with a partial record read as an absent
  one, `digest partial`. Then "restore: scripts/gate_report.py is byte-identical to the start, and no mutant is left", and the
  unmutated self-test passes again.
- **The step's own mutation harness, once more on the joined tree** (`tools/fs131_t5_mutate.py`, as its record's Stage 6 ran it, on
  `c5a4565f`; `data/fs131/lt5/gate/t5-mutations.out`, exit 0): **18 of 18 caught** — each of the scan's and the shell's eighteen
  decisions switched off in a copy, the self-test failed and named its control each time; "restore: the two shipped files are
  byte-identical to the start, and no mutant is left"; "unmutated, again: exit 0 — OK".

**The 24 co-hypotheses this landing added** (`data/fs131/lt5/cohyp-added.txt`: the `COHYP` rows of the declared scan against the
scan at the merge), read one by one: each restricts the theorem's own objects — `a ≠ 0`, `b ≠ 0`, `ψ ≠ 1`, `ringChar F ≠ 2`,
`4 * c * d = a`, `Fintype.card k = Q ^ 2`, `Q % 4 = 3`, `98 ≤ Q`, `62 ≤ Q`, `𝒞 F.region`, `F.IsPlaneMap`, `Saturated c.cls`, the
classes' agreement almost everywhere, and `gmap_ii`'s condition that the class consists of open families with null unit pairs.
None is a hand result or an outside theorem.

**Read aloud against the informal claim.** The claim this landing makes is about the instrument, not a theorem: "the gate lists
everything a theorem rests on that the kernel did not check, in both forms". What the step checks is narrower, and its output says
so on every run: it lists every library axiom with every theorem whose stored axiom list holds it — complete, given no doubled name
(`dupnames` green) — and every hypothesis **that is declared, or closed, or a never-concluded or docstring-marked former**; a hand
result written out over a theorem's own variables under a silent docstring is in `unseen=15214` and is not listed. So "in both
forms" is true of the axioms without qualification and of the hypotheses up to that class, whose only instrument is a reader.

## Stage 10 — SAVED (FS131-LT5): the landing — `main` fast-forwarded to `befb51d3`

- **`main` moved twice more while the gate ran.** To `fb4a064e` (11 commits): `plans/`, `data/`, `BIBLIOGRAPHY.md`, and one file
  outside the paths then exempt, `tools/ext_hn2_sandbox.py` (`data/fs131/lt5/merge-main2-nonexempt.txt`). Merged as `5a62be0a`, and
  on the letter of the rule **the whole gate ran a third time, on `5a62be0a`** (tag `landed2`): every step exit 0 but the assumptions
  step against the repository's own `CLAUDE.md`; every quoted line of stage 9's table the same; the scan's rows identical to the
  second pass's (`cmp` on every `TOTALS`, `TAKES`, `RESTS`, `ASSUMPTION`, `COHYP`, `CLOSED`, `CONDITION` and `SILENT` row). The
  two mutation runs are the second pass's, on `c5a4565f`; nothing under `scripts/` or `Proofs/` differs between the two commits.
  Meanwhile the coordinator's word: `tools/ext_hn2_*.py` are exempt on the same ground as the search lane's scripts.
- **Then to `bd608a11`** (3 commits): two files, both under `plans/` (`data/fs131/lt5/main-since-gate.txt`: `git diff --name-only
  fb4a064e origin/main`). Merged with no re-run, as the brief allows.
- **The gated commit is `5a62be0a`.** The landed tip differs from it in `plans/` and `data/` alone (`git diff --name-only 5a62be0a
  HEAD`, filtered: nothing outside them).
- **The push**: `git push origin HEAD:main` — `bd608a11..befb51d3`, a fast-forward (`origin/main` was an ancestor of `HEAD`); no
  force, no rejection. After a fetch `origin/main` is `befb51d3`.
- **What is red on `main` now, by design**: `./scripts/assumptions.sh` exits 1 until draft 1's paragraph is in `CLAUDE.md` § Trust
  ledger; against the copy with the paragraph it is green on this tree (`assumptions-draft-claude-landed2.log`). The coordinator's
  word: it is filed first.
- No background process is left running; no mutant file is in `scripts/`.

## Drafts for the front page (FS131-LT5)

Each names its slot and the log line it comes from. The gated commit is `5a62be0a`; the receipts are under
`data/fs131/lt5/gate/` (`receipt-assumptions-landed2.log` is the scan's full output on it; `-landed` and `-final` are the two
earlier passes', row for row the same).

**1. `CLAUDE.md` § Trust ledger** — a new paragraph after the paragraph that ends "Rung B holds none." and before "What the audit
accepts and what it buys". **File it first: until it is there `./scripts/assumptions.sh` exits 1 on `main`** (stage 7). Its nine
counts are `receipt-assumptions-landed2.log`'s `=== TOTALS ===` line (`axioms=1 rests=8 named=19 inline=16 outside=7 ours=23 open=5
takes=98 mentions=1 …`), written by `tools/fs131_lt5_claude_draft.py` and never typed; the whole file with it is
`data/fs131/lt5/drafts/CLAUDE-with-sentence.md`, against which the gate passed ("match (9 of 9 compared)"):

> **What the library assumes, in both forms** (`scripts/assumptions.sh`, whose digest reads these counts and fails if
> they are absent): `axioms=1 rests=8 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1` — one outside theorem declared as
> an axiom, with eight theorems resting on it; thirty-five hypotheses, nineteen named and sixteen written out in a
> binder — seven standing for outside theorems, twenty-three for hand results of ours and five for open questions — taken in
> 98 (hypothesis, statement) pairs by 51 statements (`scripts/assumptions-ledger.txt` lists each pair; FS131-LT5,
> 2026-10-06). Weil's bound is counted in each form it takes — the axiom, the named hypothesis `KloostermanBound`, and that
> hypothesis written out at a family of fields: one outside theorem, three entries.

The digest reads every `key=value` of the nine in § Trust ledger, each exactly once: a second mention of, say, `open=5` in that
section is a failure (exit 3, "recorded more than once"). No other count of `CLAUDE.md` moves: the axiom audit's three and the
vacuity scan's nine are `main`'s (stage 9).

**3. `LEAN.md` § The gate.** In the first sentence, after "`./scripts/axioms.sh --self-test` green (23 planted faults, each watched to
fire, two of them partners that must pass)": ", `./scripts/assumptions.sh` and `./scripts/assumptions.sh --self-test` green (21
controls planted in one copy of the audit, 33 checks)" — from `assumptions-selftest-landed2.log`: "21 controls, planted together",
"OK — all 33 checks behaved". And a bullet after the `dupnames` bullet:

> - **`./scripts/assumptions.sh` and `./scripts/assumptions.sh --self-test` are green** — everything a theorem rests on
>   that the kernel did not check is listed, in both forms it takes. An outside theorem declared as an `axiom` shows in
>   `#print axioms`; a hypothesis does not — a theorem that says "if Herglotz–Bochner holds, then …" prints the standard
>   three — so `scripts/Assumptions.lean` reads every hand-written statement as the kernel holds it and prints every
>   library axiom with the theorems whose stored axiom lists hold it (`RESTS`), and every declared hypothesis with its
>   kind (`outside`, `ours`, `open`), its source and the statements that take it (`TAKES`, `MENTIONS`). Whether a
>   hypothesis is an assumption or a condition on the theorem's parameters is intent, which no type records, so the
>   check **requires evidence**: the one list is `AssumptionAudit.declared`. **It fails** on a *closed* hypothesis (no
>   free variable: a statement about the world) that is neither declared, nor proved by the library, nor the one claim
>   a refutation refutes — a closed family `∀ F, … → H F` of a declared `H` included: the binder is declared as a site;
>   on a `Prop`-former taken as a hypothesis that no theorem concludes, or that is concluded only from declared
>   assumptions, or whose docstring uses the words "named hypothesis", "outside the backlog" or "external", when neither
>   list holds it; on a source that is not in `BIBLIOGRAPHY.md`, `LEDGER.md`, the grokkings, the stubs or the
>   derivations; on a declared kind its docstring contradicts; on a declared hypothesis no statement takes, or one a
>   theorem proves over its own variables; on any consumer that `scripts/assumptions-ledger.txt` does not list, or lists
>   and the scan does not find; and **when the nine counts are absent from `CLAUDE.md` § Trust ledger** (a recorded count
>   whose deletion passes is no record; counts that have drifted are flagged, not failed). **It counts and prints, and
>   cannot decide**: the other hypotheses of every consumer (`COHYP`), and `unseen=` — every other hypothesis over a
>   theorem's own variables, among which a hand result written out in a binder, undeclared and unremarked in its
>   docstring, is not told from a condition. **A former proved at the instances where it is taken closed** (not over its
>   own variables) is not reported: its entry leaves on the landing's reading, its docstring is reworded to say over what
>   it is proved, and its closed takers then read `ESTABLISHED` (`StandingFive.StandingFloor`, FS131-LT5). The nine counts
>   are recorded in `CLAUDE.md` § Trust ledger and in the ledger's header, where `scripts/gate_report.py` reads them.

**4. `LEAN.md` § Assumptions: outside theorems and our own.** The third bullet gains a sentence, and a fourth bullet follows it:

> - **Our own hand results** that a module needs before their own module lands enter as explicit hypotheses of the
>   theorems that use them, never as axioms, so they disappear when discharged. **So may an outside theorem** (five do on
>   `main`, in seven entries: Herglotz–Bochner in two forms, Markov–Kakutani, Artin–Lang, Voronov's Thm 1.1, and Weil's
>   bound in the hypothesis forms its modules were proved over), when its statement is better carried as a named `Prop`
>   than as an axiom.
> - **Every assumption in hypothesis form is declared to the gate**, in `AssumptionAudit.declared` at the end of
>   `scripts/Assumptions.lean`, by the landing that brings it: a named one by `.former ``Full.Name kind "source"`; one
>   written out in a binder by `.site ``Theorem `binder "Label" kind "source"`, once per theorem that takes it (sites
>   with one label carry one source, character for character); a former that is only a condition on a theorem's
>   parameters by `.condition ``Full.Name "reason"`; a closed premise that is not an assumption by `.premise ``Theorem
>   `binder "reason"`. The kind is `outside` (source: a `BIBLIOGRAPHY.md` key in brackets), `ours` (a ledger row `row N`,
>   a grokking `G N`, or a derivation entry id) or `open` (those, or a stub `FS-N`); the source opens with that
>   reference. The definition's docstring says whose it is in the words the gate reads — "external" or "classical" or
>   its bracketed key; "[hand]", "[tools]", "[cert]" or "outside the backlog"; "open question" — or it is counted
>   `SILENT`; and a former that is **not** assumed must not use the words "named hypothesis", "outside the backlog" or
>   "external" in its docstring. Then `./scripts/assumptions.sh --self-test`, `./scripts/assumptions.sh`,
>   `./scripts/assumptions.sh --write-ledger` (read the rows it adds: each is a statement that is now conditional), and
>   the nine counts for `CLAUDE.md` § Trust ledger, which the step reads as stale — flagged, not failed — until they are
>   refiled. A hand result written out in a binder over the theorem's own variables is the one thing the gate cannot find
>   by itself: the landing declares it on its own word.

**5. `LEAN.md` § Trust ledger**, the table — a fifth row: "| a hypothesis standing for an outside theorem, a hand result of ours
or an open question | **declared**, with its kind and source, by one line of `AssumptionAudit.declared` in
`scripts/Assumptions.lean`; every statement that takes it listed in `scripts/assumptions-ledger.txt` |". And § Trust ledger's first
sentence ("The audit's counts are recorded in `CLAUDE.md` § Trust ledger, where `scripts/gate_report.py` reads them.") gains: "So are
the assumptions step's nine."

**6. `ARCHITECTURE.md` § 5 Trust** — written on this branch, in the gated commit: the subsection "### Assumed as hypotheses
(`scripts/assumptions.sh`; declared in `scripts/Assumptions.lean`)", after "Imported outside theorems", with the three tables as
they stand on the landed tree (seven, twenty-three, five). Nothing to file.

**7. The line every landing brief carries from now on** (the step's draft 7; the procedure moved in two places — a closed family
needs its binder declared, and the recorded counts must exist):

> A wave that brings an assumption in hypothesis form — a named `Prop` standing for an outside theorem, a hand result
> of ours or an open question, or one written out in a binder — declares it in `AssumptionAudit.declared`
> (`scripts/Assumptions.lean`; the procedure is `LEAN.md` § Assumptions), or `./scripts/assumptions.sh` fails; a closed
> hypothesis `∀ x, … → H x` of a declared `H` is declared at its binder too. The landing runs
> `./scripts/assumptions.sh --self-test`, `./scripts/assumptions.sh` and `--write-ledger` on the merged tree, reads
> every ledger row it gains or loses, and drafts the nine counts for `CLAUDE.md` § Trust ledger (until they are refiled
> the step flags them stale and does not fail; it fails if they are absent). A wave that removes or proves an
> assumption removes its entry and rewords the docstring that called it one.

**8. Docstrings still owed** (not this job's to make). `Plane.NoPar` (`Plane/Saturated/MapColouring.lean`): add "an open question"
to its docstring, and the one `SILENT` row leaves. `Arith/TargetFloors.lean`'s module doc still calls `StandingFloor` "the
hypothesis TC1-STANDING-FIVE's 'so `L(F) ≥ 7`' hid" and is right as history; no edit asked.

**9. `plans/FS131-kernel-plan.md` § 7.4** (the table of named hypotheses): `StandingFloor` is discharged over the import and
`KloostermanBound` is the import's hypothesis form — as FS131-L10B's draft 9 says; the step's list is now the current table.

**10. The Frontier line, the ledger rows and the Proof Atlas**: nothing moves. This landing proves no theorem, changes no
statement and regrades no row; the atlas gains no node (docstrings only under `Proofs/`).

## The enumeration, for the owner — what `main` assumes after this landing

*From the gated receipt (`data/fs131/lt5/gate/receipt-assumptions-landed2.log`) and the ledger (`scripts/assumptions-ledger.txt`).
"Statements" counts the theorems whose own statement takes the hypothesis, or — for the axiom — whose kernel-stored axiom list
holds it.*

**In one sentence.** Of the library's 10,173 theorems, 58 are conditional on something the kernel did not check: 8 rest on the one
outside axiom, 51 take one or more of 35 declared hypotheses in their statements, and one does both. The other theorems rest on
`[propext, Classical.choice, Quot.sound]` (or the five declared native purchases) and on the hypotheses a user of the theorem
supplies about its own objects.

**Weil's bound appears three times below and is one outside theorem**: as the axiom, as a named hypothesis, and as that hypothesis
written out at a family of fields. Counting theorems of the literature and not entries, the library assumes **six**: Weil's bound,
Bochner's theorem (in two forms), Markov–Kakutani, Tarski / Artin–Lang, and Voronov's Theorem 1.1.

### A. Outside theorems — one axiom and seven hypotheses

| what is assumed, in plain words | how it enters | from | statements |
|---|---|---|---|
| **Weil's bound for Kloosterman sums**: over a finite field of `q` elements and odd characteristic, a non-trivial additive character summed over `x ≠ 0` at `cx + d/x` has absolute value at most `2√q` | the axiom `StandingFive.kloosterman_bound` | `[Weil1948]` p. 207, read against the page by two readers | **8 rest on it**: the floors at seven (`Q ≥ 98`) and six (`Q ≥ 62`) of the norm-one targets, `StandingFloor 7` and `5`, `7 ≤ L(F)` at the standing field, `χ(F²) ≥ 5` there, the circle-sum bound, and the passage to the hypothesis form |
| the same bound at the theorem's own field | the named hypothesis `StandingFive.KloostermanBound` | `[Weil1948]` p. 207; the axiom proves it at odd characteristic | 9 (the hypothesis forms wave 10 kept beside the eight) |
| the same bound at every field of `q ≡ 3 (mod 4)`, `q ≥ 347` elements | written out in the binder `hK` | `[Weil1948]` p. 207 | 3 (three of the nine) |
| **Herglotz–Bochner**: every positive-definite function on a discrete abelian group is the Fourier transform of exactly one finite measure on its dual | `SpectralChain.BochnerHerglotz` | `[Rudin1962]` 1.4.3 and 1.3.6 — **not read**: cited from memory, the read-back owed | 13 (row 123's chain, `sp_if`, the Haar-in-Fourier-form lemmas, `χ(ℚ(√47)²) = 5` over the chain) |
| **Bochner's theorem for a topology**: a finite measure whose Fourier transform is continuous for a group topology is carried by the continuous characters | `SpectralInputs.BochnerOn` | `[Rudin1962]` 1.4.3 — not read | 1 (`spectral_carried_iff`) |
| **Markov–Kakutani**: every non-empty closed set of four-colourings of `ℤ[U]`, stable under shifts and rotations, carries a probability measure invariant under both | `SpectralChain.InvariantMeasureOnClosed` | `[Kakutani1938]` — **not read** | 7 |
| **Tarski / Artin–Lang**: a finite system of rational polynomial equations with a real solution has a real algebraic one | `Bridge.RealAlgebraicDescent` | `[Lang1953]` — not read, cited through `[GoelPatilVerma2022]` | 6 (the bridge `χ(ℝ²) = sup_F χ(F²)`, row 107) |
| **Voronov's Theorem 1.1**: for every `ε > 0` no six-colouring of the plane avoids every distance in `[1 − ε, 1 + ε]` | `Plane.Voronov11` | `[Voronov2023]` Thm 1.1 (an unrefereed preprint, its proof repaired locally: row 132) | 1 takes it (`mu_lt_of_voronov11`); 1 states it under `↔` |

### B. Hand results of ours — twenty-three, none in the kernel

| what is assumed | how it enters | from | statements |
|---|---|---|---|
| R-U: every finite rotation-invariant measure on the dual gives `E ∖ (T + A)` measure 0 | `Interface.RU` | J45 § 5.4 [hand] | 6 |
| PE-2: every rotation-invariant measure is a Haar multiple plus a part of zero entropy | `Interface.PE2` | X02D [hand], over Einsiedler–Lindenstrauss Thm 1.2 by statement | 6 |
| EF_F⁺: a rotation-invariant measure of zero entropy lives on `T + A` | `Interface.EFPlus` | FS100-X01D [hand] | 6 |
| A⁺ at `S = ∅`: the spectral inequality is strict for every invariant random four-colouring | `Interface.APlus0` | J45 § 3 [hand]; row 113 | 3 |
| A⁺ follows from R88-TCA | `Interface.APlusOfR88` | J45 [hand] | 3 |
| the count: T-C(A) gives R88-TCA in the class | `Interface.Count` | X23D-TCA [hand] | 3 |
| a band character in `T + A` has order dividing 168 (the band at 4) | `CharacterColouring.OrderBound` | FS89-S0A-3 [hand], two derivations | 2 |
| measure rigidity for the unit-vector group, in Fourier form | `Interface.MR` | row 120 [hand] | 1 |
| `m⁻¹(E) ⊆ E`; and the negative circle | `Interface.MulStable`; `Interface.NegCircle` | J45 § 4.2 steps 2, 3 [hand] | 1 each |
| `χ_CP ≤ χ_m⁰` (the hard direction of row 130) | `Plane.Row130M1` | row 130 [hand] | 1 |
| a finite unit-distance graph over `ℚ(√3,√11)` forces two points `8/3` apart to one colour at four colours | `SevenConditional.G4` | row 103: one solver refusal with no proof log | 1 |
| `χ(F²) = L(F)` where `L(F) ≤ 4` | written out (`hRow99`) | row 99 | 3 |
| `L(F) ≥ 5` implies T-C(A) | written out (`hCLS`) | X23D-CLS | 3 |
| `min(L(F), 5) ≤ χ(F²)` at the standing field (row 123's chain, measure rigidity inside it) | written out (`hRow123`) | row 123 | 2 |
| `χ(F²) ≤ L(F)` | written out (`hUpper`) | row 52 | 1 |
| `Θ₄(ℤ[U_ℚ]) ⊆ T + A`; `Θ₅(ℤ[U_ℚ]) ⊆ T + A` | written out (`hRQ4`, `hRQ5`, one theorem) | FS89-D2-T1; FS89-D5-T2 | 1 each |
| `α(Γ₂₃) ≤ 105`; `α(Γ₈₃) ≤ 1148`; `α(Γ₁₁) ≤ 29` | written out | rows 71, 68, 68: certificates checked outside the kernel | 1 each |
| two facts of the Falconer fan's lattice (a forced difference lies in `8Λ`; the forced group is `0` or `P`) | written out (`hR78`; `hR88`, `hR88per`) | rows 78; 88 | 1 each |

### C. Open questions and design targets — five

| what the theorem is conditional on | how it enters | from | statements |
|---|---|---|---|
| no member of the theorem's class of map colourings lies in `𝒫₆` — at the locally finite map colourings, the open statement C121-NOPAR | `Plane.NoPar` | C121-NOPAR (FS-121) | 2 (`gmap_ii`, `sat_noPar`) |
| every `√3`-pair and every distance-2 pair is separated by every proper five-colouring of the plane | written out (`h3`, `h2`) | row 43 (G26) | 2 |
| the same at six colours | written out | row 61 | 2 |
| its form for the plane of the distances 1 and 2 | written out | row 61 | 1 |
| valid six-coloured fragments exist on discs of every radius | written out | row 145 | 1 |

### What left the list, and what never was on it

- **Falconer's Lemma 2 (i)** was the library's one axiom when the step was written; it is a theorem since FS131-IF1, and its four
  consumers are unconditional.
- **`StandingFive.StandingFloor`** was a hand result of ours taken as a hypothesis; it is proved at 7 and at 5 over Weil's bound,
  so the dependence is now on the axiom, where it is listed.
- **Thirty-three formers are declared conditions, and two closed hypotheses premises**, each with a reason printed every run and
  each read twice (stage 5): a condition restricts the objects a theorem is about and asks nothing to be taken on anyone's word.

### What the step counts and cannot decide

- **`unseen=15214`**: every hypothesis over a theorem's own variables in a statement that takes nothing declared. A hand result or
  an outside theorem written out there, with a docstring that does not say so, **is not told from a condition** — no type separates
  them. The eleven such hand results above were found by reading docstrings, not by the scan. For the two landings since the list
  was made I read every doc comment of their twenty-nine modules for the words (stage 3) and found none; for the rest of the
  library the reading is the step's first author's.
- **`cohyp=58`**: the other hypotheses of the 51 consumers, printed in full on every run — where an undeclared one would most likely
  sit beside a declared one. The 24 rows this landing added I read (stage 9): each restricts the theorem's own objects (`a ≠ 0`,
  `ψ ≠ 1`, `ringChar F ≠ 2`, `Q % 4 = 3`, `98 ≤ Q`, `F.IsPlaneMap`, `Saturated c.cls`, …); the 34 older ones are the step's first
  author's reading.
- **`silent=1`** (`Plane.NoPar`: its docstring does not say whose it is in the words the step reads); **`hints=0`**.
- **A former proved only at instances** is not reported by the step (stage 4, case 1): the landing that proves it must remove it.
- **The step lists; it does not grade.** "Not read" beside four of the six outside theorems is the bibliography's status, repeated
  here because an assumed theorem whose page nobody has read against the Lean statement is the weakest kind of entry on this list.

## Theorems this phase proved, final

**None.** This landing proves no theorem and changes no statement, definition or proof: the kernel's list of the library's 14,501
declarations is, sorted, byte-identical to the second landing's, and the stored type of every one of the 1,453 constants in the
nine modules whose docstrings changed is what it was (stages 6, 9). The audit's counts are the second landing's: 6,334 records —
6,304 clean, 17 axiom-free, 8 imported, 5 declared purchases; one library axiom, `StandingFive.kloosterman_bound`. What it lands
is an instrument and a list: `scripts/assumptions.sh` with `scripts/Assumptions.lean`, its controls, its ledger of 107 rows and a
third digest in `scripts/gate_report.py`; 22 doc comments; `ARCHITECTURE.md` § 5's new subsection.

## Slips, my own

1. A reading aid of mine (a script that printed each declared condition's definition) ran without an end for two minutes over the
   whole of `Proofs/`, generated modules included; I stopped it by its process id and rewrote it with `rg` and a size limit. No
   result was taken from the first one.
2. The first run of `data/fs131/lt5/condition-takers.lean` stopped at the default heartbeat limit after 34 of 36 formers; the limit
   is lifted for that one read-only `#eval` and the run repeated. The 34 printed before agree with the second run.
3. I queued the two mutation runs behind a full slot ledger and then stopped them, before either was admitted, to merge `main`
   first and run them once on the merged commit; nothing had run and nothing was forfeited.
4. `tools/fs131_qa4_notes.py list` is in my runner beside the working-tree wrapper; it reads fixed commits and its 17 CONFLICT lines
   are not this tree's. The gate's notes check is the wrapper's line (0 CONFLICT), as the two landings before ran it.
5. No token count was read at any saved stage: I have no instrument for the harness's count, and wrote my own estimate each time.
