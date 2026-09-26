# STUB — FS-97: invariant four-colourings whose spectrum reads infinitely many places (T-C′, the remainder of row 88's measure half)

> **Absorbed into FS-100 (2026-09-26; owner ruling on J47's proposal, applied by front-page job J25).** Its questions are FS-100's
> (`plans/STUB-measure-rigidity-three-fields.md` §9): Q2 is MR (SP ⟺ ¬MR, two derivations), Q3 is answered at type (A) by R-U and reduced
> to T-B1 at type (B) by T-J38-2, Q4 is SP-Cor, and (R1) at type (B) is reached through T-B1 (FS-98). Its priors carry to FS-100 §4. **Answered at FS-100 stage 5 (the ×2×3
> crunch, 2026-09-26):** MR is proved for every real number field with `R = O′` (`plans/FS100-derivation.md` FS100-MR), so Q2 is settled (every
> `U`-invariant `E`-null measure is a Haar multiple), (R1) and (R2) at type (A) are closed through SP-Cor, the entropy question is answered
> (zero entropy for one `u` ⟹ carried by `T + A`; positive entropy ⟹ Haar plus a zero-entropy part), and the ℚ(√47) form is `χ(ℚ(√47)²) = 5`.
> At type (B) only T-B1 remains (FS-98). Kept as the record of its minting; demoted, never deleted.

*Minted 2026-09-25 at the close of the milestone "row 88's question" (crunch job J41, from `plans/FS86-row88-close-inventory.md` row 48 and
J28D's §5.1). Read first: `plans/R88-derivation.md` §2 (R88-TC, R88-TCA) and its §G ("T-C′"); `plans/FS86-R88-D-derivation.md` §5.1;
`plans/FS86-R88-V-verification.md` §2.1. Solver column: **none** — a derivation question; no finite witness bears on it.*

## The mission, in plain language

Over the fields ℚ(√59), ℚ(√83), ℚ(√131), the plane is four-colourable, and the open question (`LEDGER.md` row 88) is whether every
four-colouring is the "dyadic pullback" — read off the field's one tight 2-adic place. Row 88's milestone split that question in two
(row 111): a **measure half** — is every translation-invariant *random* four-colouring a pullback? — and a **transience half** (FS-98). It then
proved the measure half for every random colouring whose *spectrum* (the frequencies its colour pattern carries, as characters of the
unit-vector ring) reads only finitely many places of the field: such a colouring extends to the locally compact completion at those places,
where a counting argument against the tight factor forces the pullback (row 112, Theorem C). Over ℚ(√47), where the conjecture predicts five
colours against a proven four, the same count shows no invariant random four-colouring of that spectral type exists at all (row 113). **This
stub carries what is left of the measure half: invariant four-colourings whose spectrum reads infinitely many split places.**

## The remainder, exactly (J28D §5.1; no truth claim)

Q-μ needs every translation-invariant `μ` on `X₄(F)` whose spectral measure is
- **(R1)** carried by `⋃_S (T + A + Fin_S)`, `S` ranging over finite sets of split places, but by no single `T + A + Fin_S` — the completion over
  all split places is their full product, Polish but not locally compact, so there is no Haar measure for the Fubini steps of row 112; or
- **(R2)** charging characters outside every `T + A + Fin_S` (reading infinitely many split places at once — HD1's infinite type).

At ℚ(√47) the same two classes are where a four-colouring, if one exists, must put the spectrum of an invariant measure on its orbit closure
(row 113) — "reads infinitely many split places" **in aggregate**: (R1) allows finitely many places per frequency.

## The questions

1. **(R1) by a limit.** Does row 112's count survive an increasing union of finite `S`: is a measure carried by `⋃_S (T + A + Fin_S)` a limit of
   measures each carried by one, in a sense the count respects? Or is there an (R1) measure no finite-`S` argument sees?
2. **(R2) and entropy.** J28D's reading (one mind): the colouring constraint `σ̂|_U = −1/3` is linear in the Fourier coefficients and shows no
   mechanism forcing positive entropy for the `U`-action on `R̂`, so the positive-entropy measure-rigidity theorems (Rudolph 1990, A. Johnson
   1992, Host 1995, Einsiedler–Lindenstrauss; none held) do not visibly apply, and the zero-entropy case is Furstenberg's ×2×3 measure question's
   analogue. Is that right, or does the unit-distance constraint force entropy?
3. **Rotations cannot be averaged in.** The spectral measure of a merely translation-invariant `μ` is not `U`-invariant, and a `U`-average's
   weak-* limit can move mass onto the closed set Pull (the plan's §M.1). So even a classification of `U`-invariant measures leaves Q-μ open without
   an isolation statement (FS-98's T-B1). What is the right intermediate object?
4. **The ℚ(√47) form.** Does any structure of (R1)/(R2) spectra refuse four colours at ℚ(√47) — the one route by which the measure half could
   bear on `χ(ℚ(√47)²)` (FS-84)?

## What sits beside it

- **J36** (a Poros session, `plans/POROS-2026-09-25-infinitely-many-primes.md`, in progress at this stub's minting; its stage 1 is expectations
  written before reading the derivations): its E1 raises the same single-`S` versus union scope as (R1), and its E3 (b) expects the zero-entropy
  part to be ×2×3 in disguise. **Expectations, not findings** — re-read that record at the opening and cite its later stages, never copy its
  recommendations as settled.
- Row 92 (measurable windows over finitely many places) and M3's rows 109–110 (the mixing selection, windows at five): the window side of the same
  question; row 112 is its invariant-measure side.
- Rows 95–98, 102: closed-set Furstenberg–Berend rigidity on `R̂` holds at two or more primes and fails at one — the closed-set analogue.

## Registered expectations (to be re-registered at the opening)

- (R1) closes by a limit argument: 0.3 (J41's prior, from the records only).
- (R2) contains a genuinely open measure-rigidity problem: 0.6.

## Deliverables

A derivation record with, per question, TRUE / FALSE / GAP at a named step; the prior-art gate in ergodic theory (measure rigidity of
`S`-arithmetic actions; invariant random colourings; Furstenberg's measure conjecture) with the four papers above fetched and read first (G50).

## Provisional bearings

**Provisional bearings, updated at row 88's and FS-67's closes (2026-09-25, J44):** G79 — this stub's class is what a counterexample must carry and may be empty; flip the poster and ask what every invariant four-colouring must carry. The wanted-poster session J38 is its first test.

G76 (the frame and its narrowed reading), G72 (move 3: invariant measures), G74 (gluing across infinitely many layers), G48 (the colouring-level
Hasse principle), G60 (`F ⊆ F_μ ⊆ P`), G54 (spectra cannot pin on a slack plane; row 112 goes through `m₁`), G50 (the unheld measure-rigidity papers).
