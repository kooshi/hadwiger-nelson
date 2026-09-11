# FS-30 — Consume the rotation list. Nothing has.

> **SEQUENCED 2026-09-11 by Kooshi, as the direct sequel of M63's record phase:** *"After we match or
> beat it, the next high value tweaks are different base graphs, and the additional ~400 rotation angles
> that were discovered previously, which should hopefully let us go even smaller."* So this stub is no
> longer a standalone reading room. It is the next step of the record hunt: rerun M63's loop — the one
> that reproduces or beats `[Parts2020a]`'s 509 — on **other base graphs** and at the **412 admissible
> rotations** (`data/m62/rotations-moser-r2.05.json`; 396 multi-family classes on the other base,
> `data/m62/rotations-r2.05.json`), aimed below whatever M63 lands. The M63 roadmap carries it as the
> phase after the record (`plans/M63-parts-reproduction.md`). Two consequences for M63's own
> instruments: the rotation and the base should be **parameters, not constants**, wherever that is
> cheap; and M63's freeze still pins `ρ₁₅` and radius 2.6 for everything compared with his tables.

*Minted 2026-09-10 at Kooshi's direction. The wind-egg Poros named in the M62 review
(`plans/POROS-2026-09-10-m62.md`): **M62's §R1 calls the 412-rotation list "the derivation" and
nothing reads it.** Read `plans/M62-evolutionary-type-m.md` §R1, §M1.0 and §M2.1 first.*

## What exists, and why it is not yet a result

`tools/typem.py rotations` enumerates, with **no floating point in any verdict**, the rotations that
can carry cross edges between a point set in `K = ℚ(√3,√11)` and a rotated copy of it. The
derivation: for radii `a = |u|²`, `b = |v|²` the rotation must adjoin `√D` with
`D = ab − k²`, `k = (a + b − 1)/2`, all in `K`; and

- `D < 0` — no rotation;
- **`D` a square in `K` — the rotation stays in `K(i)`, the union stays in `K²`, and Theorem B
  four-colours it. Rejected structurally.**
- else — a candidate.

Measured on a Moser-lattice base (873 points, 87 distinct radii, 46 s): 1,336 rotation classes
escape `K`, **412 of them admit the ≥ 2 cross-edge kinds `[Parts2020a]` calls essential**, and the
record's own rotation is among them (rank 58 by family count, carrying both of its known kinds).
Artifact: `data/m62/rotations-moser-r2.05.json`.

**And that is where it stops.** A `grep` over `tools/` finds exactly one consumer — a `print`. Every
arena M62 built is hard-wired to `ρ₁₅ = (7 + i√15)/8`, **the rotation every published construction
already uses**. Admissibility is *necessary and not sufficient*, so the list is currently a filtered
enumeration of one base's radius spectrum, not a derivation of anything.

## The question this stub exists to answer

> `[Parts2020a]` §4, verbatim: *"Working constructions of type M with other rotations are not known
> yet."* **Is that because none exist, or because nobody enumerated the candidates?**

Either answer is a result. A *negative* — a proof or a systematic refutation that no rotation
outside the `√15` class supports a construction — is publishable-adjacent in its own right and
would explain a fifty-year monoculture. A *positive* is a new construction family.

## The work

1. **Pick candidates by theory, not by vote count.** M62 §M2.1 measured that ranking rotations by
   how many cross edges they create is **anti-correlated** with usefulness: maximal coupling means
   the rotation nearly preserves the lattice, means it lies in `K(i)`, means Theorem B kills it. Rank
   instead by: number of distinct radius families; whether the radicand breaks the 2-adic wall
   (`plans/FIELD-WALL-THEOREM.md` §7.3, `tools/wall_break_test.py`); and whether the resulting field
   is **6-open** under the M58 sieve (that is the FS-6 tie, and it is the reason to care).
2. **Build the arena for each** (`typem.Arena`; the cross-edge law must be re-derived per rotation —
   the `ρ₁₅` law in `typem.cross_edges_rho15_fast` is *specific to that rotation's radicand* and
   generalising it is the first code task).
3. **Run the non-vacuity gate** — is the full base at that rotation 5-chromatic? A subgraph of a
   4-colourable graph is 4-colourable, so a SAT here kills the whole rotation in one call. M62 §R3
   and §R14 both show this gate firing usefully in seconds.
4. **Report the census**: of the top `N` admissible rotations, how many pass the gate on a base that
   passes it at `ρ₁₅`.

## Why it may be the binding constraint

M62's best object is ~5,200 vertices against a record of 509, all of it at `ρ₁₅` — the rotation the
record is *already optimal for*, after Heule's and Parts's combined ~1,100 hours of tuning. **We are
unlikely to beat them at their own rotation with a night's tooling.** The one asset they did not have
is the ability to say which *other* rotations can work at all, and it is sitting unread on disk.

## A cheaper lead in the same file, which needs no new machinery

**The record's own rotation admits SEVEN radius families and Parts uses TWO** (M62 §R1). His whole
subtype classification — M3, M6A, M6B, M6C, M10, M12 — counts how much of the **second** kind is
used; he never considers a **third**. Five unused cross-edge kinds sit at the rotation the record is
already built on, and M62's subtype census (`data/m62/subtype-census.json`) already enumerates the
orbits. Days, not weeks, and it is the fastest test of whether extra kinds help at all.
