# STUB — FS-95: rank-one walls — frozen walls, the binary model, and the completion route (FS-76's rank one, after M3)

*Minted 2026-09-25 at M3's close (crunch job J23c, from `plans/M3-close-inventory.md` rows 33 and 45). Numbered FS-95 by the front-page job (J24). Read first: `plans/M3-derivation.md` §1–§4 and `plans/M3-S1B-rank-one.md` §2.8. Solver column: **none until 2026-10-01**
(the ban); the completion route's first step is an exact enumeration a derivation fixes, and waits for 2026-10-01 by the owner's ruling
(inventory row 60).*

## The mission, in plain language

Colour the integers with four colours so that any two integers whose difference lies in a fixed finite set `D` get different colours.
The colourings form a one-dimensional shift of finite type. FS-76 asks, in rank one, whether every colouring "looks like" a periodic one:
whether a pair of positions that every periodic colouring colours alike is coloured alike by every colouring (`P₄(D) = F₄(D)`). FS-79
proved this fails exactly when every *phase* of the shift (a strongly connected piece of its window graph) is a single cycle and yet a
*wall* (a colouring passing from one phase to another) exists. The reading R2 says that never happens. M3 proved R2 equivalent to
"a countable four-colouring shift of a distance graph is finite" and to "no heteroclinic four-colouring of ℤ has an all-rigid completion"
(J18-DC), and stalled at one step, reached by three minds. This stub carries the three concrete follow-ons M3 named.

## What M3 established (addresses in `plans/M3-derivation.md`)

- In an all-rigid shift every periodic point is gap-free with two-sided Kempe strands (M3-J18-K0loc); the Kempe class of a wall point
  consists of wall points with tails in different labelled phases (M3-J19-KC).
- At a wall whose tails are **Kempe-frozen** (one strand per colour pair) Kempe moves only relabel the tails (M3-J19-FRZ), so KE fails there
  (M3-J19-KEF) and **R2 = FW ∧ the non-frozen rest**, FW ("no all-rigid `X₄(D)` has a wall between Kempe-frozen periodic points") being
  out of reach of every Kempe argument (M3-J19-KT).
- No named set holds a frozen rigid point (M3-J20-NAMED; the 94-phase `{2,6,11,13,14}` included, M3-J19-AF✗): FW has no test case.
- For `D ⊇ {1, 2}` the shift is a 24-to-1 extension of a binary return-time shift with an explicit four-state automaton (M3-J19-BIN).
- Every wall between distinct phases has a chiral end (M3-J19-TW, J20's general form).

## The questions

1. **KE♯ / FW, by derivation first.** Is there any `X₄(D)` — entropy allowed — with a rigid–rigid wall between two Kempe-frozen periodic
   points? A yes refutes KE outright and shows FW is not vacuous; a no-go proof for frozen walls would close FW (half of R2). Which `D`
   admit a frozen rigid periodic point at all (none among seven named sets)?
2. **R2 on the subclass `D ⊇ {1, 2}`** in the binary model: "a binary return-time shift whose periodic points are all isolated in their
   SCCs has no heteroclinic point" — a letter-pattern question where zero entropy and walls can be read off forbidden words.
3. **The completion route to a counterexample (A-C), after 2026-10-01:** J18-DC turns A-C into "find a heteroclinic `c` whose Δ-completion
   kills every non-rigid phase". First exact step (J20 §3.4): the admissible residues mod 20 of FS73-T30's rigid–rigid walls (their ends
   have period 20); then whether adding distances in those residue classes can leave only finitely many periodic points of the parent.

## Registered expectations (to be re-registered at the opening)

- Q1 by derivation: a class of `D` with frozen rigid points is constructed, 0.3; FW proved vacuous (no frozen rigid points in any all-rigid
  shift), 0.2; neither, 0.5.
- Q2: R2 proved on `D ⊇ {1,2}`, 0.2.
- Q3 (post-ban): an all-rigid completion found, 0.1 — it would settle FS-76's rank one negatively (`P₄ ≠ F₄`).

**Failure clauses.** A search over `D` hunting survivors is out of scope until 2026-10-01 and then only at the extent a derivation fixes;
an all-rigid scan's null measures its range (G21; a counterexample must be chiral, FS79-T34); "no frozen point found on these sets" is not
FW.

## Deliverables

A derivation record with a "Theorems this phase proved" heading; for Q3 an exact checker whose plant fires; a derivation file at the close.

## Provisional bearings

G78 (minted at M3's close: rank-one inheritance is countable ⟹ finite; Kempe moves cannot see a frozen wall), G71 and G73 (four colours
have no height; certificates cell by cell are empty), G13/G42 (a fan gap or a finite Kempe component is entropy), G27 (reflection and the
colour group), G21 (a scan's null measures its range), G51 (three minds met one wall), G72 (pose the structural form).
