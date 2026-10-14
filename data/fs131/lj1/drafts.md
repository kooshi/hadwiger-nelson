
## Drafts for the front page (FS131-LJ1)

*For the coordinator to file; this job files none of them. Each draft names its slot: the file, the section, and **the
exact words on `main` it replaces or follows**. A script checks that each slot occurs exactly once on `main`
(`data/fs131/lj1/drafts-slots.py`, output `drafts-slots.out`). Each draft also names the log line it comes from. The
gated commit is `def7c07f8e7bda496e33aac52ee076cfab554d17`; its logs are `data/fs131/lj1/gate/*-final.*`, and the three scans' full outputs are
`receipt-axioms-final.log`, `receipt-vacuity-final.log` and `receipt-assumptions-final.log`. **Whose the mathematics is,
as the joining job read it against the paper**: the values 2 and 3 and every upper bound are prior art (`[Fischer1990]`
Thms 1, 8, 9, 10(i); `[Johnson1987]`; the residue plane, `[Moorhouse2010]`, `[Madore2015]`). This project's are three
things: the lower bound of four against every colouring at radicands 11 modulo 12; the three-colour criterion over
every real number field (the direction from a colouring to the prime); and the clause for subfields of the reals.
Throughout, the kernel proofs are this project's. Nothing here moves the answer.*

**1. `CLAUDE.md` § Trust ledger, the audit's sentence.** *Replaces* "the current audit reads 7447 clean and 5 declared
purchases, and 26 imported (and 28 axiom-free; 7,506 records at the landing of FS-131's first number-field module, the
residue upper half, FS131-LU1, 2026-10-13)". From `axioms-final.log`, "audited: 7602 records — 7531 clean on the
standard axioms, 28 axiom-free, 38 imported (resting on a declared outside theorem), 5 declared purchase(s)":

> the current audit reads 7531 clean and 5 declared purchases, and 38 imported (and 28 axiom-free; 7,602 records at the
> landing of FS-131's three-and-four-colours line, FS131-LJ1, 2026-10-14)

7447 + 84 = 7531; 26 + 12 = 38; 7,506 + 96 = 7,602; axiom-free and purchases do not move.

**1b. The same paragraph, the import's count.** *Replaces* "`StandingFive.kloosterman_bound` — Weil's bound for
Kloosterman sums, `[Weil1948]` p. 207, read against its page by two readers — with eight imported records;" *by*

> `StandingFive.kloosterman_bound` — Weil's bound for Kloosterman sums, `[Weil1948]` p. 207, read against its page by
> two readers — with twenty imported records (twelve of them the three-colour criterion's and row 99's, FS131-LJ1);

From `records-final.txt`: "records carrying kloosterman_bound: 20 (filed: 20); of the landing's: 12". The rest of the
paragraph stands: "no record rests on two of the three" ("carrying two imports 0").

**2. `CLAUDE.md` § The gate, the vacuity scan's two count lines.** *Replaces* "`declarations=16029
refutations-skipped=228 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`." From
`vacuity-final.log`, "scanned: declarations=16125 refutations-skipped=228" and "sites: sites=1454 vacuous=0 stale=0
declared=3 witnessed=38 generic=1411 unknown=2" (runs of spaces collapsed):

> `declarations=16125 refutations-skipped=228 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`.

One count moves: declarations +96. No site is added, because the scan is silent on the line (stage 5). The baseline's
header is refiled on the branch.

**3. `CLAUDE.md` § Trust ledger, the nine assumption counts and their sentence.** *Replaces* "`axioms=3 rests=26
named=19 inline=15 outside=7 ours=22 open=5 takes=106 mentions=1` — three outside theorems declared as axioms, with
twenty-six theorems resting on them; thirty-four hypotheses, nineteen named and fifteen written out in a binder — seven
standing for outside theorems, twenty-two for hand results of ours and five declared as open questions — taken in 106
(hypothesis, statement) pairs by 52 statements (`scripts/assumptions-ledger.txt` lists each pair; FS131-LT5, 2026-10-06;
one hand result left the list at FS131-LU1, 2026-10-13: the upper half `χ(F²) ≤ L(F)` is the theorem
`UpperHalf.chromaticNumber_planeOver_le_localBound`)". From `receipt-assumptions-final.log`, its `=== TOTALS ===` line,
"axioms=3 rests=39 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1":

> `axioms=3 rests=39 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1` — three outside theorems declared
> as axioms, with thirty-nine theorems resting on them; thirty-three hypotheses, nineteen named and fourteen written out
> in a binder — seven standing for outside theorems, twenty-one for hand results of ours and five declared as open
> questions — taken in 102 (hypothesis, statement) pairs by 52 statements (`scripts/assumptions-ledger.txt` lists each
> pair; FS131-LT5, 2026-10-06; two hand results have left the list since. At FS131-LU1, 2026-10-13: the upper half
> `χ(F²) ≤ L(F)`, now the theorem `UpperHalf.chromaticNumber_planeOver_le_localBound`. At FS131-LJ1, 2026-10-14: row 99's
> lower half through four, `hRow99`, now the theorem `ThreeFourColours.localBound_le_chromaticNumber_of_le_four`, which
> rests on Weil's bound)

Four of the nine move:
- `rests` 26 → 39: the twelve imported records and one private helper.
- `inline` 15 → 14 and `ours` 22 → 21: the entry `inline:Row99` retired.
- `takes` 106 → 102: its four pairs.

The ledger is rewritten on the branch by the script (`--write-ledger`: thirteen rows gained, four lost, 142 rows).

**4. `tools/claude_md_fact_audit.py`, `GATE_CHANGES`.** One entry after the last (`(("7395", "5"), ("7447", "5")):`):

```python
    (("7447", "5"), ("7531", "5")): "FS-131, the landing of its three-and-four-colours line — for squarefree m the plane over Q(sqrt m) needs 2 colours at m != 3 (mod 4), 3 at m = 3, 7 (mod 12), at least 4 at m = 11 (mod 12) and exactly 4 there outside 47, 143, 167 (mod 168); over every real number field a non-bipartite plane is three-chromatic iff a prime has residue field F_3, chi <= 3 iff L <= 3 and chi = L for L <= 4 (on Weil's bound); chi >= 4 over every subfield of R whose unit-vector ring holds 1/3 and whose plane is not bipartite; the values 2 and 3 and every upper bound prior art, the lower bound of four, the criterion and the clause for subfields ours, the kernel proofs ours (FS131-LJ1; copy data/fs131/lj1/gate/receipt-axioms-final.log, gated commit def7c07f8): 7,602 records, 7,531 clean, 28 axiom-free, 38 imported, 5 purchases",
```

**4b. The same file's table of superseded counts.** Every token the drafts retire, in that table's own form, each with
its value as the reason: `"7447"` (7531 clean); `"7,506"` and `"7506"` (7,602 records); `"26 imported"` (38 imported);
`"with eight"` (with twenty); `"declarations=16029"`, `"16029"` and `"declarations=16029 refutations-skipped=228
sites=1454"` (16125); `"rests=26"` (39); `"inline=15"` (14); `"ours=22"` (21); `"takes=106"` (102); `"axioms=3
rests=26 named=19 inline=15 outside=7 ours=22 open=5 takes=106 mentions=1"` (the new nine); `"twenty-six theorems
resting"` (thirty-nine); `"thirty-four hypotheses"` (thirty-three); `"fifteen written out"` (fourteen); `"twenty-two
for hand results"` (twenty-one); `"106 (hypothesis, statement) pairs by 52 statements"` (102 by 52). The reason for
each: "superseded gate count, refiled at FS131-LJ1's landing from data/fs131/lj1/gate/receipt-axioms-final.log (the
vacuity count from receipt-vacuity-final.log, the assumption counts from receipt-assumptions-final.log); the old count
stays in data/fs131/lu1/gate/ and in GATE_CHANGES". **The next landing's previous receipts are
`data/fs131/lj1/gate/receipt-{axioms,vacuity,assumptions}-final.log`.**

**5. `CLAUDE.md` § Where the problem stands, "What the kernel holds, beyond the interval": the sentences on three and
four colours.** *Follows* "`χ(ℚ(√167)²) ≤ 8` and `χ(ℚ(√47)²) ≤ 5` a second way (rows 52, 57, 63, 105, 119, 121;
FS131-LU1; known values and bounds, the kernel proofs ours);" *with*

> **three and four colours over real number fields** (FS131-LJ1). For squarefree `m` the plane over `ℚ(√m)` needs 2
> colours when `m ≢ 3 (mod 4)` and 3 when `m ≡ 3, 7 (mod 12)`. When `m ≡ 11 (mod 12)` it needs at least 4, and exactly 4
> outside the classes 47, 143 and 167 modulo 168. All of this is on the standard three axioms
> (`ThreeFourColours.chromaticNumber_planeOver_sqrt_table`), and the lower bound of four needs no squarefreeness
> (`TorsionExtraction.four_le_chromaticNumber_planeOver_fieldOfRadicands`). Every subfield of `ℝ` whose unit-vector ring
> holds `1/3` has a plane that needs at least four colours unless it is bipartite, and is never exactly three-chromatic
> (`TorsionExtraction.four_le_chromaticNumber_planeOver_of_inv_three_mem`, `…_ne_three_…`; standard three). Over every
> real number field, on one declared outside theorem, Weil's bound: a non-bipartite plane is three-chromatic exactly when
> some prime of `F` has residue field `𝔽₃`; `χ(F²) ≤ 3 ⟺ L(F) ≤ 3`; and `χ(F²) = L(F)` whenever `L(F) ≤ 4`
> (`ThreeFourColours.chromaticNumber_planeOver_eq_three_iff`, `…_le_three_iff`, `…_eq_localBound_of_le_four`; rows 82
> and 99). The values 2 and 3 and every upper bound are `[Fischer1990]`'s (Thms 8, 9, 10(i)) and the residue planes'.
> The lower bound of four against every colouring, the three-colour criterion and the clause for subfields are this
> project's, with every kernel proof;

**6. `CLAUDE.md` § Frontier, the "Last filed" line.** *Replaces* "Last filed: **the landing of FS-131's first
number-field module, the residue upper half**" *by* "Last filed: **the landing of FS-131's three-and-four-colours line**
(FS131-LJ1, 2026-10-14: `Arith/ThreeColourCharacter`, `TorsionExtraction`, `ThreeColourCriterion`, `DyadicQuadratic`,
`ThreeFourColours` and `Instances/UpperHalfCorollaries` through the gate — 94 theorems and 2 definitions, 84 records on
the standard three axioms and 12 on those and Weil's bound; the quadratic table, the three-colour criterion over every
real number field and row 99's first three sentences in the kernel; row 99's `hRow99` discharged; no value moved);
before it **the landing of FS-131's first number-field module, the residue upper half**". The rest of the line stands.

**7. `LEDGER.md` — the rows this line regrades, each only as far as its statement landed** (the joining job's D5 checked
against the built tree; every name below is a kernel theorem of the gated commit, with its axioms from `checks-final.out`
and `records-final.txt`).
- **Row 52.** *Replaces* "The two values stay [hand + tools] until the ramified clause is applied at 11 to `K(√5)` and
  `K(√247)`: no file states those instances." *by* "The ramified clause is applied at 11 since FS131-LJ1: the two values'
  upper halves are [kernel] (`UpperHalf.chromaticNumber_planeOver_sqrt_five_le_five`, `…_sqrt_247_le_five`: `χ ≤ 5` over
  `fieldOfRadicands {11, 3, 5}` and `{11, 3, 247}`, the standard three; prior art). Their lower halves, `χ ≥ 5` over these
  two fields, are stated by no declaration, so the two values stay [hand + tools]." The grade bracket "[kernel for the
  bound; hand + tools for the two values]" stands.
- **Row 73.** *Follows* "four exactly except 47 (≤ 5 at 11)." *with* "Since FS131-LJ1, `χ(ℚ(√11)²) = 4` is also the
  table's dyadic row at `m = 11` (`ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four_of_dyadic`). The five lower
  bounds `χ ≥ 4` at 23, 47, 71, 95 and 191 are instances of row 82's family theorem in the kernel
  (`TorsionExtraction.four_le_chromaticNumber_planeOver_fieldOfRadicands`, standard three), and no longer [certified,
  tools] only. The value is exactly 4 at 23, 71, 95 and 191 (`ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four`:
  each is squarefree and `≡ 11 (mod 12)`, and none is 47, 143 or 167 modulo 168). The case at 23 is an `example` of the
  module; the cases at 71, 95 and 191 are kernel-checked terms of the landing (`data/fs131/lj1/checks.lean`,
  `table_at_71_95_191`), not library theorems."
- **Row 79.** *Follows* the grade "**[hand; two independent derivations — de Bruijn and Coxeter — read by Poros; the
  owner checked the two deciding steps]**" *with* "**Its ⟹ is [kernel] since FS131-LJ1** (standard three), for every
  abelian group and step set: `ThreeColourCharacter.bandSet_three_nonempty_of_proper`, with
  `exists_character_of_properAlong`; and at the plane over every subfield of `ℝ`,
  `fieldBandSet_three_nonempty_of_colorable` and, reading the colouring only on `ℤ[U_F]`,
  `…_of_colorable_unitRing` (FS73-T22's ⟹ and FS81-T2). The ⟸, the density of periodic colourings and the statement
  about forced pairs stay [hand]."
- **Row 82.** *Replaces* the grade "**[hand, two independent derivations]**" *by* "**[kernel since FS131-LJ1, the
  standard three; before it hand, two independent derivations]**". *And replaces*, in its **Not claimed**, "anything in
  the kernel (FS73-T22's ⟹ is hand-proved, never kernel; FS-75);" *by* "a kernel proof beyond what the landing holds —
  the row's theorem is `TorsionExtraction.four_le_chromaticNumber_planeOver_of_inv_three_mem` and
  `chromaticNumber_planeOver_ne_three_of_inv_three_mem`; its family clause is `four_le_chromaticNumber_planeOver_of_sqrt_mem`
  (every subfield of `ℝ` holding `√d`, `d ≡ 11 (mod 12)`, with no squarefreeness), whose character form is
  `fieldBandSet_three_eq_empty_of_sqrt_mem`; T4 is `colorable_two_of_fieldBandSet_three_nonempty`; and 'three-colourability
  of every real quadratic plane is decided exactly' is `ThreeFourColours.chromaticNumber_planeOver_sqrt_table`
  (FS131-LJ1);". The row's prior art stands, with the theorem numbers the joining job read: `[Fischer1990]` Thm 10(ii)
  and Ex. 4 for the unit vector and the additive case.
- **Row 99.** *Replaces* the grade "**[hand (+ Weil, tools exact); S1 three derivations (J02, J09, J09v), S2 and the
  torsion theorem two, S3 three, no mixing two independent (J09; J09v blind, a different route)]**" *by*
  "**[kernel since FS131-LJ1, on one declared outside theorem (Weil's bound), for the row's first three sentences:
  `ThreeFourColours.chromaticNumber_planeOver_le_three_iff`, `chromaticNumber_planeOver_eq_localBound_of_le_four`,
  `chromaticNumber_planeOver_eq_three_iff`; "no mixing" and `χ(ℚ(α,√7)²) = 4` stay hand (+ Weil, tools exact) — S1 three
  derivations (J02, J09, J09v), S2 and the torsion theorem two, S3 three, no mixing two independent (J09; J09v blind, a
  different route)]**". *And replaces*, in its **Not claimed**, "a kernel proof (FS-75) — of which one leaf is in the
  kernel since FS131-LU1, the upper half `χ(F²) ≤ L(F)` for every real number field
  (`UpperHalf.chromaticNumber_planeOver_le_localBound`); every other step of the row stays [hand];" *by* "a kernel proof
  of "no mixing" or of `χ(ℚ(α,√7)²) = 4` — the row's other statements are in the kernel: the upper half since FS131-LU1
  (`UpperHalf.chromaticNumber_planeOver_le_localBound`), and since FS131-LJ1 the lower half
  `ThreeFourColours.localBound_le_chromaticNumber_or_four_le` with its three sentences, on Weil's bound. Weil's bound is
  read at one place, `ThreeColourCriterion.targetFloor_four_weil`, in the case of three colours and not two. The
  direction from the prime to the colouring rests on the standard three (`colorable_three_of_card_three`);".
- **Row 105.** *Replaces* "the reading applied at any named field (`K(√7)`'s "every prime above 2 splits in `K(√7)(i)`"
  is not stated);" *by* "the reading applied at any named field but `K(√7)`. There, its consequence that no stable prime
  of `K(√7)(i)` holds 2 is `UpperHalf.two_notMem_stablePrime_seven` since FS131-LJ1 (standard three). That statement
  ranges over a type the kernel does not show to be non-empty (a stable prime exists by Chebotarev), and the splitting
  itself is not stated;".

**8. `LEAN.md`** — the lines the five records drafted, each for § Searching — Lean, after its last bullet ("`tools/check_architecture.py`
fails on a row's imports cell and on module coverage; a misnamed identifier in a row's description is listed under `[3]`
and does not fail (FS131-IV1, two plants on copies)."), by address, to be filed in their words. Each record is in this
tree:
- FS131-IC1, `plans/FS131-IC1-implementation.md` § D7: `simp [f]` on an upstream definition generates `f.eq_1` in the
  module that asks, so a sibling may hold a second copy (a `GENERATED` row of `scripts/dupnames.sh`).
- FS131-IT1, `plans/FS131-IT1-implementation.md` lines 311–320: four lines (`Int.inductionOn'`; `linear_combination` and
  `Complex.I_sq`; the numeral cast in a subring; an orbit as a `zpow`).
- FS131-IN1, `plans/FS131-IN1-implementation.md` § 5: `letI` against `haveI` for a module structure;
  `ConstantInfo.value?` is `none` for a theorem; a farm for a worktree with no upstream `.olean`; two deprecations.
- FS131-ID1, `plans/FS131-ID1-implementation.md` § D6: three lines (a footer's hygienic names; pricing an exhaustion over
  residues by its modulus; `omega` and `Int.natAbs`).
- FS131-KJ1, `plans/FS131-KJ1-joining-module.md` § Stage 7, D8: four lines.
- **This landing's two**, for § The gate (after the assumptions bullet's sentence "… (`hUpper` of
  `SpectralChain.chromaticNumber_eq_localBound`, proved by `UpperHalf.chromaticNumber_planeOver_le_localBound` and retired
  by FS131-LU1 — its record's stage 4 has the receipt);"):
  "A binder retired on the landing's word is retired on a kernel term, not by eye: apply each theorem that takes it to the
  discharging theorem in a checks file. If the binder's type is not that theorem's, the term does not elaborate; and the
  term's axioms are what feeding the binder costs. When that theorem rests on a declared import, the hand result leaves
  the list and its cost moves to the import's `RESTS` row (`hRow99`, `data/fs131/lj1/checks.lean`; FS131-LJ1)." And, for
  § Trust ledger: "The assumptions step's `rests` counts every theorem whose stored axiom list holds an import, private
  helpers included. The audit's imported count counts only the records it names, which are public, so the two can
  differ: 39 against 38 at FS131-LJ1 (`ThreeColourCriterion.exists_maximal_card_nine_of_quotient`)."

**9. `BIBLIOGRAPHY.md`, the row `[Fischer1990]`.** *Follows* "colorings of the graphs (ℚ²(√m), 1)"*. the upper bound `χ(ℚ(√11)²) ≤ 4` is
kernel-checked since FS131-LU1 (`UpperHalf.chromaticNumber_planeOver_eleven`)." in its "what rests on it" cell (the
words before "the upper bound" are part of the slot: the rest occurs twice in the file) *with*: "His Thms 8, 9, 10(i)
give the values and upper bounds of the quadratic table in the kernel since FS131-LJ1
(`ThreeFourColours.chromaticNumber_planeOver_sqrt_table`). His Thm 1(i)–(iii) are three kernel statements
(`DyadicQuadratic.colorable_planeOver_of_addMonoidHom`, `TorsionExtraction.colorable_two_iff_fieldBandSet_two_nonempty`,
`ThreeColourCriterion.exists_maximal_conj_trivial_of_colorable_two` with `fieldBandSet_two_nonempty_of_conj_trivial`)." In
its reading cell, *after* "… which conclude only the additive case (`LEDGER.md` row 82)": the joining job's sentence,
"re-read 2026-10-13 by FS131-KJ1 (Thm 1 and its proof, Thms 7–10 and their proofs, Ex. 4, against the kernel statements
of the three-and-four-colours line): Thm 1(i)–(iii) are three kernel statements; the two-colour and three-colour maps
are his; his four-colouring at `N ≡ 3 (mod 8)` is `ℤ/(4)`-valued and is not the kernel's."

**10. `CLAUDE.md` § The theory in one paragraph.** *Replaces* "and through
five the bound is exact: χ(F²) = L(F) whenever L(F) ≤ 5 (row 99 below five;" *by* "and through
five the bound is exact: χ(F²) = L(F) whenever L(F) ≤ 5 (row 99 below five — through four [kernel] since FS131-LJ1 on
Weil's bound, `ThreeFourColours.chromaticNumber_planeOver_eq_localBound_of_le_four`;". *(The slot is checked by the
script; if the paragraph's words differ, this draft is dropped, not reworded.)*
