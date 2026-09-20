# FS-61 — proposals to the product owner at the close (phase F items F.3, F.4, F.5)

*Written by the implementer. **These are proposals, not edits**: `CLAUDE.md`, `plans/FRONTIER-STUBS.md` and the
stubs are the owner's files. F.4 — the two sweeps and the §PA re-read — was written at the end of phase E and is
unchanged below. F.3 and F.5 were written at the close, after the second certification pass.*

---

## F.4 — the sweeps


## Sweep 1 — every occurrence of "conjecture" in `plans/FS61-quadratic-census.md`

| line | what it says | mint a stub? |
|---|---|---|
| 23, 35, 105, 256, 719, 753 | all refer to **the project's local–global conjecture (G48)** and to its level-4 clause, which this milestone tests. Not a conjecture this milestone MINTED. | **decline** — it is CLAUDE.md G48, already carried, and FS-59 is its open consumer |
| 206 | Duffus–Sands–Woodrow's statement **B(n)** (1985) is *conjectural*, quoted from the prior-art sweep as the general form behind FS-58 D3.4 | **decline as a stub of ours, but it belongs in the bibliography's read-status**: none of the four originals was reached (all paywalled), so the census cites a conjecture nobody here has read. Recorded, not pursued |
| **T4** (§3 D-F.2, not containing the word) | *for every squarefree `d ≡ 11 (mod 12)`, `χ(ℚ(√d)²) ≥ 4`* — the milestone's own candidate class theorem | **already a named deliverable** (E.5, P10); the close reports it unproved with what was tried |

## Sweep 2 — "not claimed" / "not proved" / "not attempted"

| line | what it says | mint a stub? |
|---|---|---|
| 802 (§M2) | **FS-58 D3.4's repair** — 3-colourings of `G × H` with `χ(H) > 3` factor through `G` when `G` is gap-free — *"not used and not attempted here"*, with an unverified eigenvalue sketch from the prior-art sweep, and the fact measured but unproved at `q = 7, 11` | **MINT A STUB.** The plan itself says *"proposed to the owner as a stub at the close"*, so this is the sweep firing exactly as designed. It is a statement about Hoffman-tight `G` whose proof is not in the literature found, and it is the missing justification under FS-58's D3.4 and under phase A.7's rule for non-affine quotient colourings |

## The §PA re-read — *what did the prior-art gate teach us about our own object?*

Not *were we first*, which is what §PA was filed under. Four answers:

1. **Headline 4 — the unit-vector supply is a class-group question.** `[ZanardoZannier1991]` Thm 3 gives a basis of the
   free part of the norm-one group indexed by the split primes, with the obstruction in `Cl(S)/M`. Phase E's **shape
   table** is the same statement seen from the other end: one integral shape holds 108 unit vectors over `d = 11` and
   20 over `d = 371`, and that count is what decides whether its graph refuses. **The census has measured, field by
   field, the quantity that theorem computes** — and the connection is not drawn anywhere in this repository.
   *Recommendation: a grokking, or a line in the ledger row.*
2. **Headline 2 — Fischer split this family at exactly this modulus in 1990** (`d ≡ 3 mod 8` has an additive
   4-colouring; `d ≡ −1 mod 24` has no additive `k`-colouring for small `k`). Phase E now has **two** `d ≡ 3 (mod 8)`
   fields refusing by the direct route (11 and 59), so the census's lower bounds cut across his division rather than
   along it. *Recommendation: say so in the close; it is the sharpest thing the census says about a published division.*
3. **Headline 1 — Moorhouse asks "What about `χ(ℚ(√47)²)`?" by name**, and the census answers a question he posed in
   general (*"how much can the chromatic number grow for quadratic extensions"*) with a table. *Recommendation: this
   belongs in `CLOSED-QUESTIONS.md`, and the close should state exactly which of his questions is answered and which
   is not.*
4. **Headline 5 — `[Sokolov2018]`'s rank-2 layers.** E.5 now answers it exactly (every witness has ℚ-rank 4), which
   turns an informal FS-58 remark into a checkable column. *Recommendation: one line in the ledger row; no stub.*

---

## F.3 — the ledger row (proposed text for `CLAUDE.md` § The novel-results ledger)

*Row 74, in the ledger's own format. Status tags follow `CLAUDE.md` § Grokkings.*

| # | Result | Where | When |
|---|---|---|---|
| 74 | **The census of real quadratic fields: thirteen planes need four colours, and what decides a field is the supply of unit vectors, not its congruence class** (FS-61). One uniform procedure over the forty squarefree `d ≡ 11 (mod 12)` below 500 — by `[Johnson1987]` and `[Fischer1990]` Thms 8–9 the *only* real quadratic fields whose plane can need four — saturating a lattice of unit vectors, filtering it by finite quotients, refusing a ball of it and shrinking that to a certificate. **[certified, tools]** `χ(ℚ(√d)²) = 4` at **`d = 59, 119, 359, 431`** and `4 ≤ χ ≤ 5` at **`d = 143, 311, 335`** — **seven fields FS-58 never reached, four of them new exact values** — each an independent checker's word (its own LRAT checker, twelve planted faults refused by name, the wrong radicand refused, a second opinion in exact `Fraction` arithmetic with three further solvers, a verified 4-colouring, and the owner's decorrelated recheck); FS-58's six fields re-certified from FS-61's own ball selection, two of them smaller, and **`d = 11` landed by the DIRECT route in nine seconds** (189 points, 1-minimal) where FS-58 needed a forcer and a four-copy chain. Every witness meets the kernel's 3-adic barrier (row 72) by count. **27 of 40 not landed, each null TYPED** — by certificate, by budget, or asked-without-refusal — and the by-certificate null dissolves with depth (at `NMAX = 420` ten of its eleven fields gain open lattices, but 121 of 130 records there are over cap: **depth without unit vectors buys nothing**). **[hand]** *The dyadic law's other half*: for squarefree `d ≡ 7 (mod 8)` no unit vector has least denominator `≡ 2 (mod 4)` — the norm equation mod 8 leaves four residue patterns and **orthogonality read mod 4** kills all four (0 surviving patterns, against 256 in the `d ≡ 3 (mod 8)` control, where such denominators do occur). **[measured]** *One integral shape refuses over one field and carries a verified periodic 3-colouring over another*: of 1,158 shapes, 14 refuse somewhere, and the shape that refuses over 11 with 108 unit vectors is periodically 3-colourable over 35, 59, 131, 179, 371, where it holds 36, 36, 28, 28, 20 — **the ℤ-module is the same and the graph is not, because the field decides how many unit vectors of that height lie in it**, which is `[ZanardoZannier1991]` Thm 3's class-group count seen from the other end. **[measured]** *What decides whether a solver answers a ball is its average degree, not its size*: over 774 asked balls none below degree 6.595 has ever refused, the undecided peak sits at degree 4–6, and predicted degree is `g·φ(R)²` with `φ` the disc/unit-translate overlap **squared for the bidisc** (observed/predicted median 1.0000, range 0.715–1.184). Aimed by it, five fields refused that three earlier tiers had not reached; and **a bigger, denser ball refuses FASTER** (47: 104 s at `R = 1.2`, 0 s at 1.5). **Readings scored: R-cycle won** (odd girth ≤ 9 in every refusing lattice, none above; Fisher `p = 1.2e-06`; necessary and nowhere near sufficient), **R-mod8 lost twice** (11 and 59 both refuse at `d ≡ 3 (mod 8)`, cutting across `[Fischer1990]` Thm 10's division of this family), **R-L lost**, **R-C lost** (all 24 refusing lattices below −1/2), **R-size not decided**; predictions 4 won, 4 lost, 2 not measured. **No class theorem**: T4 — *every squarefree `d ≡ 11 (mod 12)` needs four* — is unproved, and the witness table says why the parametric route is not yet there. **Prior art:** the classification below four is `[Johnson1987]` and `[Fischer1990]`; every upper bound here is a residue plane at 2, 7 or 11 (`[Fischer1990]` Thm 9, `[Moorhouse2010]` Thm 8.1); the question is `[Moorhouse2010slides]`' (*"What about `χ(ℚ(√47)²)`?"*) and Benda–Perles OP 11.6. **Ours:** every lower bound, the dyadic lemma, the degree law, the shape finding. | `data/fs61/` (`README.md`, `census.md`, `readings.md`, `shapes.md`, `aiming-167.md`, `witness-*/`), `plans/FS61-quadratic-census.md` §R, `tools/fs61_census.py`, `tools/fs61_readings.py`, `tools/fs61_recount_landings.py` | FS-61 |

**Two notes on the row, for the owner to accept or cut.**

1. **`d = 239` is deliberately absent from every count above.** It has a refusing ball on record and is a solver
   claim; its certification is **resumable and unfinished** (`data/fs61/records/phase-F.md` §3.1a). Certified it
   would be a fifth new exact value and would make the census fourteen of forty.
2. **The "thirteen" in the headline is the count of fields with a certificate, not the count FS-61 produced.**
   FS-61 produced seven of them and re-certified six of FS-58's. Both numbers are in the row; if only one can be in
   the headline, the honest one is **seven new fields**.

## F.3 — the update to grokking G61 (proposed)

*G61 currently reads "Three colours break at arithmetic, not at size", with three numbered facts over `ℚ(√11)` and
two readings. The census tests it across a family. Proposed changes, smallest first:*

1. **Its reading *T4* is now tested at scale and survives untouched.** 13 of 40 landed, 27 open, **no
   counterexample and no proof**. The entry should say the family-wide statement has been *asked* of forty fields
   and that the nulls are typed, so a later reader does not mistake 27 open rows for 27 negative results.
2. **R-mod8's death belongs in the entry, because it is about the half of the family G61 is written over.** The
   `d ≡ 3 (mod 8)` half is **not** out of the direct route's reach: `d = 11` and `d = 59` both refuse on their own
   lattices, and both are certified. So `[Fischer1990]` Thm 10's split of this family (an additive 4-colouring at
   `N ≡ 3 mod 8`, none with few colours at `N ≡ −1 mod 24`) does **not** predict where a finite refutation lives.
3. **Replace "a coarse lattice with a short odd cycle lands" with what the census measured.** The refusing lattices
   are *rich in classes*, not coarse — `d = 11`'s draws on ten classes and holds 108 unit vectors — and **odd girth
   ≤ 9 is necessary and far from sufficient** (47 % of the lattices that have it refuse; 0 % of those that do not).
4. **Add the mechanism sentence, which is the census's own finding:** over these fields it is the **unit-vector
   count of a shape**, not the shape and not the congruence class, that decides refusal. The same ℤ-module refuses
   over one field and is provably 3-colourable over another, and `[ZanardoZannier1991]` Thm 3 is the theorem that
   computes the quantity the census measured field by field.
5. **Add the instrument sentence, which bears on every future search here, not only on quadratic fields:** a ball's
   **average degree** `2·edges/points`, predicted before the ball is built by `g·φ(R)²`, decides whether a solver
   answers; nothing below 6.6 has ever refused, the hardness peak is at 4–6, and **a radius ladder that walks
   downward walks into it**. *Killing test: a refusing ball below average degree 6.5.*
6. **Keep (1), the 3-adic barrier, and note it is met in all thirteen witnesses by count** — 89 to 2,484 barrier
   edges per witness, never zero, as row 72 requires.

## F.5 — what FS-59 and FS-60 now consume (proposed)

**FS-59 — four colours over `ℚ(√167)`.** `data/fs61/aiming-167.md` is written for it. Four things are new since its
stub:

1. **167 has now been asked one question that was both decidable and capable of refusing, and it coloured** — its
   lattice `L3e1c94c6` at predicted degree 14.0 on 1,474,541 points, **3-colourable in 3.66 s**. Every earlier
   "3-colourable in under two seconds" at 167 was at average degree 3.06, where nothing can refuse.
2. **Only one of 167's sixteen open lattices reaches degree 8 at all under a 2,000,000-point cap.** The aiming note
   gives all sixteen with their covolumes and the best degree each can reach. **Depth is not the constraint; the
   supply of unit vectors is** — which is also the shape finding, and it says the number to search by is the
   denominator at which a lattice first holds enough unit vectors to reach a refusal-capable degree under a cap.
3. **The degree law and its control transfer unchanged**, and with them the warning that FS-58's and phase B′'s
   radius ladders stepped *down* into the hardness peak.
4. **The shape table is FS-59's cheapest negative screen**: before building anything over 167, ask whether that
   integral shape already carries a *verified periodic 3-colouring* over some other field, and — the other way —
   whether a shape that refuses elsewhere holds enough unit vectors over 167.

**FS-60 — the quadratic witnesses in the kernel.** Its input set grows from five fields to **thirteen**, all in
FS-58's `witness.json` + `witness.lrat.gz` format and manifested in `data/fs61/witnesses.jsonl` with sizes, hashes,
minimality and deletion state. Four things it should know:

1. **Sizes range from 131 to 1,739 points and the variation is the deletion budget, not the field.** Seven of the
   thirteen are 1-minimal; the cheapest to formalise first are those.
2. **`d = 59` is the largest certificate in the repository — 39.7 MB of gzipped LRAT on a 1,739-point witness** —
   and `d = 95` is the expensive field to shrink (phase C priced a from-scratch 1-minimal witness there in hours,
   on two different balls). A resumed deletion can never reach 1-minimality, so shrinking either means starting
   over on a smaller ball.
3. **`d = 11` now has a 189-point direct-route witness beside FS-58's 204-point chain witness.** The kernel holds
   the chain one; the direct one is smaller and its provenance is a single ball, which may be the easier object.
4. **The certificate type should be parametric in `d`.** Thirteen fields now share one witness format and one
   checker, and `d = 11` and `d = 311` even share a point count (189) while differing in edges (452 against 460).
