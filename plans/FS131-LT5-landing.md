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
