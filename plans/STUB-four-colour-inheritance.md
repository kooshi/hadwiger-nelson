# FS-76 — four colours: inheritance, certificates and decidability (stub)

*Minted 2026-09-23 at FS-73's close, from `plans/FS73-derivation.md` T29, T30 and §8, and Kooshi's question whether a certificate like
the three-colour `Θ` exists at four colours. Rank 4: mechanism; the next use of the competitor-and-advisor design
(`plans/PROTOCOL-competitor-and-advisor.md` §3).*

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
