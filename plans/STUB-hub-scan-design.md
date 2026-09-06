# FS-12 — The hub scan as the design instrument: depth-one partners over every field at once (STUB, 2026-09-06; minted at the M59 close)

*Read beside: `plans/M59-finite-plane-lift.md` §S1 (a), §R3; `tools/fplift.py hubs`; `data/fplane/hubs-*.json`; M49 §R8–§R9 (the
kill engine's partner census: 9,485 depth-one points of the seed in 59 quadratic extensions); M50 (`PartnerLattice.lean`:
depth-one candidates are finite, in any field); G37 (the endgame is K-fabric plus one wall-breaking adjunction).*

## 1. Mission context, in plain language

The descent (M49–M53) grows a 5-forcer by adjoining points at unit distance from ≥ 2 of its vertices — glue points, enumerated pair
by pair, each in its own quadratic extension, then tested by a solver. M59 built the same enumeration from the finite side: reduce
the object at an unramified degree-one prime p, and every residue class outside the object is a candidate hub; lifting each
pair's glue point in the class p-adically and counting the neighbours it fits enumerates, in seconds, every point of the plane at
unit distance from ≥ 3 vertices of the object — over EVERY field with such a prime above p at once, the field read off the lift
rather than adjoined by hand — and each passer is exact (the unit-circumcentre of three of its neighbours, in the object's own
field). Measured: Heule-510 at 131 has 1,171 such points (support 3–10; 100 of 100 sampled verified exactly); the 1581 at 131 has
3,739 (support 3–13; none in its half-spindle closure). What the descent wants next is the SAME enumeration one level up — the residue classes carrying
a point at unit distance from ≥ 3 vertices that ALSO breaks a stress (kills a colouring) — and the local test says which classes
carry any point at all before a solver is asked.

## 2. What we know

| fact | where |
|---|---|
| a degree-d residue hub imposes d − 2 first-order conditions; a degree-2 one always lifts (the glue point); ≥ 3 is where the finite plane filters | M59 §S1 (a) |
| the scan is complete except on the residue classes the object's own vertices occupy (≈ |V|/p² of the plane) | M59 §R3 |
| the lift theory needs an UNRAMIFIED degree-one prime: over K, 83, 107, 131, … — never 11 | M59 §R1 |
| Heule-510's hubs: 1,171 at 131 (11 of the strict scan's 64 are Heule-553's discarded vertices, to the p-adic digit); the 1581's: 3,739, supports to 13 | `data/fplane/hubs-{heule510,degrey1581}-p131.json` |

## 3. Derivations first

**D1 — the hub with a colour condition.** The descent's ask is "does adjoining this point kill the separating colourings"; on the
finite side a hub's residue class and support are known before its point is — so the class-avoidance ask (M33's instrument) can be
put to the hub's SUPPORT (its neighbour set) first: a hub whose support is forced rainbow in every separating colouring is a kill by
A1 (`not_colorable_iff_covers`), and that is decided on the object without the point. Derive: the fraction of hubs whose support
is monochromatic-free is the design number.

**D2 — hubs of a 6-open field's object.** The 1581 at 131 and at 479 (its two unramified usable primes); K(√7)-objects at 83; the
scan at two primes intersected (a real hub reduces at both) — the two-prime filter as a completeness check.

## 4. Phases

| phase | what | cost |
|---|---|---|
| 0 | the hub scan on the descent's committed object at its 6-open endgame prime (a K(√7)- or K(√13)-object once one exists; the 1581 at 479 meanwhile) | hours |
| A | D1 on the hubs found: the supports' class-avoidance at five colours; the kill-hubs | days |

## 5. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | the 1581's hub count at 479 agrees with 131 up to the occupied-class loss (the scan is complete) | medium-high |
| P2 | fewer than 1 % of Heule-510's 1,171 hubs have a support forced rainbow at five colours on the 510 | medium |

## 6. Bearing on 6, honestly

Medium-low as an instrument: it makes the descent's depth-one enumeration a seconds-long finite computation over all fields, but
the descent's wall (G37: the endgame must leave K) is unchanged, and no hub is a kill until its support is.

## 7. Addresses

`tools/fplift.py` (`hubs`, `hub_best`), `data/fplane/hubs-*.json`, `plans/M59-finite-plane-lift.md`.
