#!/usr/bin/env python3
"""FS131-L10A, stage 5: wave 10's first pass registered with the vacuity scan, by the scan's own procedure
(`scripts/Vacuity.lean`, "How a later wave registers its carriers"). Exact insertions, each anchor matched once.
usage (from the worktree root): data/fs131/l10a/vacuity_register.py"""
import sys

def edit(path, pairs):
    s = open(path, encoding="utf-8").read()
    for old, new in pairs:
        if s.count(old) != 1:
            sys.exit(f"{path}: anchor found {s.count(old)} time(s): {old[:70]!r}")
        s = s.replace(old, new)
    open(path, "w", encoding="utf-8").write(s)
    print(f"{path}: {len(pairs)} insertion(s)")

ENTRY = """* **Wave 10's first pass (FS131-L10A, by the procedure below; `Arith/{CharacterColouring, SpectralInputs, StationaryRatio,
  StandingFive}`).** The four modules declare ten hypothesis-formers (`data/fs131/l10a/census.lean`, wave 5's census with its scope
  changed, lists them with what the library proves of each): none has an unconditional `¬ P …` or an `IsEmpty` at a closed instance.
  **IN, by ruling** (inventory item 507 (d)): `StationaryRatio.StationarySet` — a stationary random set as a system: a probability
  space, a jointly measurable measure-preserving action of the group, an event. By step (1)'s law alone it would be OUT, like `UDCert`:
  it is a record that exists at every group by construction (`StationarySet.empty G`, one point and the empty event), so no instance of
  it is empty and **step (3)'s `VACUOUS` control cannot be planted** — there is nothing to refute. What entering it buys is the
  inhabitant rule made mechanical for this one structure: a theorem taking `(W : StationarySet G)` at a CONCRETE group reads `UNKNOWN`
  until a closed inhabitant at that group is a declaration (`StationarySet.empty` takes its group as an argument, so `gather` does not
  read it as evidence); at a variable group it reads `GENERIC`, which is every site today. Its inhabitants: `StationarySet.empty`
  (every group; a.e.-independent for every connection measure, `StationarySet.empty_aeIndependent`); `StationarySet.parity`
  (`ZMod 2` on itself, the event `{0}`, `P(B) = 1/2`, a.e.-independent for `δ₁`: `parity_aeIndependent`, `parity_prob` — the one
  closed inhabitant, and the scan's one witness for the family); and, for the other hypotheses of X25B-L1
  (`ratio_prod_le_iSup_levels`), the levels `cantorLevel` of `ℕ → ZMod 2` (`exists_cantorLevel_subset`). Controls 63–65: `GENERIC`
  at a variable group, `WITNESSED` at `ZMod 2` (by `parity`), and `UNKNOWN` at `ℤ` — inhabited (by `empty ℤ`) and proved so by no
  closed declaration: the load-bearing half, the family at an instance the evidence does not reach, which must read `UNKNOWN` and
  never `WITNESSED`. **OUT**, each a predicate with no refutation theorem to collect:
  - `StationarySet.AEIndependent` — a predicate of a system and a connection measure, at a variable system at each of its four sites;
    satisfied by `empty_aeIndependent` at every `ν` and by `parity_aeIndependent`; register it when a theorem refutes it at a closed
    instance;
  - **named hypotheses, closed propositions consumed as such** (`LEAN.md` § Assumptions: each leaves when discharged; the
    `Row130M1` case again): `CharacterColouring.OrderBound` (the band's order bound — ours, FS89-S0A-3 at `k = 4`, J08-11, J08-10 —
    taken at the closed instance `OrderBound (unitSet ⊥) (band 4) 168` by `cl2`) and `StandingFive.StandingFloor` (the finite-target
    floor, G56 — taken at `7` and at `5` by `seven_le_localBound`, `five_le_chromaticNumber`; satisfiable at `0`,
    `targetFloor_zero`), with its clause `StandingFive.TargetFloor` (no site). Tracked, each closed site would read `UNKNOWN` — true
    of a hand result not yet in the kernel, and nothing the shrink-only baseline can hold; they are listed at the landing as the
    hypotheses the theorems rest on;
  - `SpectralInputs.BochnerOn` (a classical hypothesis about a topology; holds at the discrete one, `bochnerOn_bot`, at a variable
    group, which is no evidence to this scan), `SpectralInputs.IsHaarFourier` (a predicate of a measure; satisfiable given
    Herglotz–Bochner, `exists_isHaarFourier`), `SpectralInputs.IsSpectralMeasureOf` (a predicate of a vector and a measure) — at a
    variable instance at every site;
  - `SpectralChain.Interface.MulStable`, `SpectralChain.Interface.NegCircle` — predicates of an interface, each at one site
    (`sp_if`), at a variable interface. `MulStable` holds at `Interface.trivial` (an empty `E`); **`NegCircle` has no Lean model on
    file** (one is planned at `F = ℚ` on the wave's second pass), which `sp_if`'s docstring says and the landing lists as an open
    gate item: a hypothesis set that holds together on no object of the library is a conjunction across binders, which this
    per-binder scan cannot see.

"""

edit("scripts/Vacuity.lean", [
    ("**How a later wave registers its carriers.** A new structure or predicate that a theorem may take as a\n",
     ENTRY + "**How a later wave registers its carriers.** A new structure or predicate that a theorem may take as a\n"),
    ("   `HadwigerNelson.Plane.ArcMap.WoodallMerged, `HadwigerNelson.Plane.ArcMap.WoodallNormal]\n",
     "   `HadwigerNelson.Plane.ArcMap.WoodallMerged, `HadwigerNelson.Plane.ArcMap.WoodallNormal,\n"
     "   -- wave 10's stationary systems (FS131-L10A, ruling 507 (d))\n"
     "   `HadwigerNelson.StationaryRatio.StationarySet]\n"),
])

CONTROLS = """/-- CONTROL 63 — wave 10's `StationarySet` at a variable group: `GENERIC` (FS131-L10A). -/
theorem planted_generic_stationary {G : Type} [AddCommGroup G] [MeasurableSpace G]
    (W : StationaryRatio.StationarySet G) : W.B = W.B := rfl

/-- CONTROL 64 — `StationarySet` at `ZMod 2`, where `StationarySet.parity` is a closed inhabitant: `WITNESSED`. -/
theorem planted_witnessed_stationary (W : StationaryRatio.StationarySet (ZMod 2)) : W.B = W.B := rfl

/-- CONTROL 65 — `StationarySet` at `ℤ`: inhabited (`StationarySet.empty ℤ`), but by a construction that takes its group as an
argument, which is no evidence to this scan, and by no closed declaration. `UNKNOWN`, never `WITNESSED` and never `VACUOUS`: the
load-bearing half — the family at an instance the evidence does not reach. (No `VACUOUS` control exists for this carrier: it is
empty at no group.) -/
theorem planted_unknown_stationary (W : StationaryRatio.StationarySet ℤ) : W.B = W.B := rfl

end HadwigerNelson
"""
edit("scripts/vacuity-controls.lean", [
    ("theorem planted_unknown_normal (_h : Plane.halfDisc.WoodallNormal Set.univ) : (1 : ℕ) = 1 := rfl\n\nend HadwigerNelson\n",
     "theorem planted_unknown_normal (_h : Plane.halfDisc.WoodallNormal Set.univ) : (1 : ℕ) = 1 := rfl\n\n" + CONTROLS),
])

edit("scripts/vacuity.sh", [
    ('  silent planted_arrow_false              "a genuine refutation P → False over the empty carrier stays skipped"\n',
     '  expect_site GENERIC planted_generic_stationary "StationarySet at a variable group: parametric (wave 10, FS131-L10A)"\n'
     '  expect_site WITNESSED planted_witnessed_stationary "StationarySet at ZMod 2, which StationarySet.parity inhabits"\n'
     '  expect UNKNOWN planted_unknown_stationary "StationarySet at ℤ, inhabited by a construction and by no closed declaration: the load-bearing half"\n'
     '  silent planted_arrow_false              "a genuine refutation P → False over the empty carrier stays skipped"\n'),
])
