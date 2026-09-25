# FS-76 — four colours: inheritance, certificates and decidability (stub)

**At FS-89's close (2026-09-25):** over the type-(B) fields ℚ(√59), ℚ(√83), ℚ(√131) character colourings cannot break four-colour inheritance either: HD1 holds (`LEDGER.md` row 96), every four-colour band character of those planes being a dyadic pullback. A failure `P(R) ≠ F(R)` there needs a colouring no character gives; `F(R)` stays undecided (row 88).

**Re-aimed at FS-86's close (2026-09-25):** over type-(B) fields Kempe swaps (HD4), patchworks (D, D′) and half-space defects (H) cannot break inheritance (row 91); `P(R) ≠ F(R)` there would be a four-colour inheritance failure on a non-finitely-generated abelian Cayley graph.

> **Re-aimed at FS-85's close (2026-09-24).** **`P = F` now holds on de Grey's lattice by derivation, by three mechanisms** (row 85: the
> spectrum, stripe coupling, and FS-73's certificate), `F = P = 8Λ` — a derived positive instance of inheritance at four colours, rank 4.
> And in rank 1, FS85-dB2's triangle-free `G(ℤ, D)`, `|D| = 70`, has `F₄ = P₄ = 4ℤ` (row 86): rigidity and inheritance there need no
> triangle. What is left of this stub: the class statements (plain density false in rank 1, row 80; the rank-1 criterion; C3-aper), the
> decidability question, and the local instances FS-72 and KR6 (FS-77). The one new obstruction: `Cay(Λ/16Λ, U)` is slack yet forces
> (row 87), so a slack period quotient is no evidence of looseness.

*Minted 2026-09-23 at FS-73's close, from `plans/FS73-derivation.md` T29, T30 and §8, and Kooshi's question whether a certificate like
the three-colour `Θ` exists at four colours. Rank 4: mechanism; the next use of the competitor-and-advisor design
(`plans/PROTOCOL-competitor-and-advisor.md` §3).*

**Re-aimed at FS-79's close (2026-09-24; `LEDGER.md` row 80, `plans/FS79-derivation.md` T3, T21, T34–T36).**
- **Question 1 restated.** Plain density of periodic four-colourings is **false** in rank 1: FS73-T30's walls are one-way (T3). What is
  left is existence (C3-aper, `[Ellenberg2018]`'s question at `k = 4`) and inheritance (`P = F`), with `F_μ = P` as the sharper optional
  form. Coxeter's chirality reading is now a theorem (T34, with a torsion repair), the rank-1 criterion is exact (T35: `P ≠ F` iff every
  cyclic phase is rigid and a wall exists), and a scan to `max D = 14`, `|D| ≤ 5` found no counterexample (T36). **Rank 1 closes if
  "every phase rigid ⟹ no wall" is proved** (the reading, unrefuted on 377 of 377 all-rigid sets) — the cheapest open item here.
- **Question 2 (certificates).** The edge-local height format certifies nothing on any graph of the class at four colours (T21); the
  averaged route is FS-80's.
- **Question 3 (decidability).** Stated open in print: `[CGHO2025bg]` §6.2.1 (Question 6.2) carries decidability of emptiness for ℤ^d
  with arbitrary generators as not understood; the MathOverflow thread (`[Ellenberg2018]`) expects "no" by a domino reduction, which
  nobody has carried out; a Cayley graph has one vertex orbit where `[Burr1984]`'s undecidability needs several. A domino-type no would
  likely need cliques or rank ≥ 5 and reach nothing at ℚ(√167) (FS-79's P-rank).
- **Corrections to the text below:** "the one four-colour height is Baxter's on hexagonal fabric" — the edge-local four-colour heights
  are exactly Moore–Newman's on sum-closed halves of `S` (rank ≤ 2, always four-colourable; T21); and "a four-colouring carries no height
  and no slope" holds cell by cell (G73), with wider windows open.

**Overlap with FS-79 (2026-09-23).** `plans/STUB-invariant-question-four-colours.md` asks the structural question that G72 prescribes: what invariant does every four-colouring carry? It takes this stub's questions 2 (certificates) and 3 (decidability) as its outcomes. This stub keeps question 1, the extension question (C3-aper and C3-inherit at four colours), and its rank-1 scan. FS-79 ran first; its answer is the re-aim above.

## Mission, in plain language

FS-73 settled the inheritance question at three colours for every Cayley graph of a finitely generated torsion-free abelian group
(`LEDGER.md` row 79, G71): three-colourability is a polytope question on the character torus, periodic colourings are dense, and a pair
every periodic colouring identifies is forced. **It stops at three by a fact about `K₄`**: a four-colouring carries no height and no slope
(`K₄`'s square complex is `ℝP²`), and `G(ℤ, {1,3,4,5})` is four-colourable with no linear colouring (T29). Every question the hunt asks
lives at four colours and above. Three linked questions:

1. **C3-aper at four colours** (`[AbrishamiEtAl2025]` Problem 4.6 at `k = 4`, restricted to these graphs): does every four-colourable
   Cayley graph of `ℤ^r` have a periodic four-colouring? **C3-inherit** (`P = F`) is the forcing form of the same question.
2. **Certificates** (Kooshi's question): a two-sided finite certificate scheme for four-colourability exists iff four-colourability of
   Cayley graphs of `ℤ^r` is decidable — refusals always have a finite witness (compactness, `forces_iff_exists_finite`), colourability
   has one iff C3-aper holds at four (T29's reduction). The nearest one-sided certificates are listed in `plans/FS73-C3-Coxeter.md` §6
   (fractional, capped by `χ_f(K²) = 4` over K; conditional on a certified finite-index `F`; restricted to additive colourings).
3. **Decidability**: is four-colourability of vertex-transitive `ℤ²`-Cayley graphs decidable? `[Burr1984]`'s undecidability is for
   doubly periodic graphs with several vertex orbits; nothing found for Cayley graphs (the close's gate, `plans/FS73-rigidity-dichotomy.md`
   §R-close.10).

## What is known

- **The shape a counterexample must take** (Coxeter's reading, §6, unproved): a counterexample periodic in `r − 1` directions needs a
  one-way wall between two phases; three-colour and additive phases are never chiral, so it needs a **chiral, non-additive four-colour
  phase**. FS-73's P4 found such colourings common (13 of 16 at `N ≥ 4`) — every one on a loose lattice (T35).
- **The rank-1 laboratory** (T30): at four colours the first walls between rigid phases appear at `max D = 10` (`{1,5,7,10}`, …), every one
  with `P = F = 0`. A wall between two rigid phases of a *common* period would be a rank-1 counterexample to C3.
- **Local instances:** FS-72's rank-8 lattice over ℚ(√3,√5) (no periodic colouring found); **KR6** (FS-77: no periodic colouring at
  `N ≤ 6`, four-colourability open) — if KR6 is four-colourable, it is a C3-aper candidate at four colours.
- **The one four-colour height** is Baxter's on hexagonal fabric (FS-74's lead 4).

## Routes

- **The competition** (G51's *Do*): two competitors and an advisor on "prove C3-inherit at four colours for a named class, or build a
  counterexample", with the protocol's rules as they stand. Two independent attempts meeting one obstruction would license the negative.
- **The rank-1 scan, extended** past `max D = 10`, aimed at walls between rigid phases of a common period (C-6's criterion), with the
  chirality filter.
- **Prior art first:** Liu's 2008 survey (Zbl 1168.05310, withheld), Chandgotia's pivot property, `[ChandgotiaPakTassy2019]`,
  `[GangloffEtAl2026]` (block gluing gives dense periodic points), `[TanZhang2026]` (periodic tilings), and the decidability literature
  for periodic graph colourings.

## Provisional bearings (WORKFLOW 2.0 step 2)

G71 (the dividing line and its forbids), G69 and G68 (looseness without a gap; the Kempe-period criterion), G51 (the design, and its
next wall), G21 (a periodic search measures its period cap), G65 (a refusal is still a finite graph). Rows 78–79; theorems FS73-T21–T24,
T29, T30, T31–T35, T36–T38.

## Bearing on χ ≥ 6

None directly; high on the programme. Every five- or six-forcer the hunt builds is a four- or five-colour compulsion on lattice fabric,
and whether such compulsions are always visible to periodic colourings — and certifiable — is this stub's question.

## Where the 2026-09-25 work on this lives

*Addresses and titles only, added by the 2026-09-25 crunch's bookkeeper (job J30). The index of that day's work, with its results, is `plans/CRUNCH-2026-09-25-INDEX.md`; a blind verifier does not open it.*

- `plans/M3-exotic-colourings.md` — crunch milestone M3's plan (question 1 is this stub in rank one)
- `plans/M3-S1A-rank-one.md` — job J18's record
- `plans/M3-S1B-rank-one.md` — job J19's record (in progress at this writing)
- `data/crunch-2026-09-25/briefs/J20-M3-rank-one-verifier.md` — the queued blind verifier's brief
- `data/crunch-2026-09-25/reports/J06.md`, `J18.md` — the job reports
- `plans/M3-close-inventory.md` rows 5, 8–15 — items for this stub (row 14: its re-aim)
