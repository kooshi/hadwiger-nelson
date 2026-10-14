import sys
P = "Proofs/HadwigerNelson/"
E = {
"Outside/OAI158Collapse.lean": [
("""ported theorem is downstream of that module. Where a docstring below says a theorem "rests on the standard three axioms
and `proper_to_borel_weak`", it now names a theorem: each rests on the standard three axioms.""",
"""ported theorem is downstream of that module. Each rests on the standard three axioms: T is the release's theorem, its
proof ported with it and checked by this kernel (FS131-LP1, the port's landing)."""),
("""at almost every unit pair. Rests on the standard three axioms and `proper_to_borel_weak`. Inhabitant of the""",
"""at almost every unit pair. Rests on the standard three axioms (`proper_to_borel_weak` is the release's theorem, its
proof ported). Inhabitant of the"""),
("""the standard three axioms and `proper_to_borel_weak`. -/
theorem chiM0_le_chromaticNumber_plane""",
"""the standard three axioms, through the ported `proper_to_borel_weak`. -/
theorem chiM0_le_chromaticNumber_plane"""),
("""definition, assumed there by the theorems of `Plane/Reduction`; at that wave's join this theorem proves it, and
each of those theorems then holds on this import in its place. -/""",
"""definition, assumed there by the theorems of `Plane/Reduction`; at that wave's join this theorem proves it, and
each of those theorems then holds in its place on the standard three axioms (the transfer is ported). -/"""),
("""axioms — rewritten by `chromaticNumber_plane_eq_chiM0`. Rests on the standard three axioms and `proper_to_borel_weak`
alone: `no_proper_five_coloring` is not used.""",
"""axioms — rewritten by `chromaticNumber_plane_eq_chiM0`. Rests on the standard three axioms alone, through the ported
`proper_to_borel_weak`: `no_proper_five_coloring` is not used."""),
("""lower end of `chromaticNumber_plane_six_or_seven` (which rests on the other import), its negation is `χ = 6`.""",
"""lower end of `chromaticNumber_plane_six_or_seven` (which rests on the declared outside theorem
`no_proper_five_coloring`), its negation is `χ = 6`."""),
],
"Outside/OAI158.lean": [
("""`plans/FS132-I1-implementation.md` (stages 1 and 2): the six copied declarations below and the statements of H and T
are, as the kernel stores them at this pin, the release's as the kernel stores them at the release's pin, term for
term (`tools/fs132_i1_readback.py`, on `data/fs132/i1/readback/`).""",
"""`plans/FS132-I1-implementation.md` (stages 1 and 2): the six copied declarations below and the statement of H — and
of T while it was declared here — are, as the kernel stores them at this pin, the release's as the kernel stores them
at the release's pin, term for term (`tools/fs132_i1_readback.py`, on `data/fs132/i1/readback/`); T as the port's
theorem is read back against the release by the port's own read-back (FS131-LP1: IDENTICAL)."""),
("""(`exists_properColoring_seven`, row 33's upper end), and there its conclusion is a theorem with no axiom
(`proper_to_borel_weak_model`).""",
"""(`exists_properColoring_seven`, row 33's upper end), and there its conclusion is this library's own theorem, with no
use of T (`proper_to_borel_weak_model`) — the model an import asked for, kept as T's model now that T is ported."""),
],
"Plane/RadiusOutside.lean": [
("""# The radius clause, on the two outside theorems: every open set has a weak colouring, and five fail on a disc (FS-124)""",
"""# The radius clause: every open set has a weak colouring (the ported transfer), and five fail on a disc (FS-124)"""),
("""* `radius_down` (C124-RADIUS-DOWN) rests on `Outside.OAI158.proper_to_borel_weak` — `[OAIMath2026]` family 158, the
  transfer of colourability — and on nothing else outside.""",
"""* `radius_down` (C124-RADIUS-DOWN) goes through `Outside.OAI158.proper_to_borel_weak` — `[OAIMath2026]` family 158's
  transfer of colourability, its proof ported and checked by this kernel (`Outside/OAI158BorelTransfer`) — and rests
  on the standard three axioms alone."""),
("""* `colorable_iff_forall_ball`, `seven_le_chromaticNumber_plane_iff_exists_ball` — the join of UP and DOWN, on
  `proper_to_borel_weak`: the plane""",
"""* `colorable_iff_forall_ball`, `seven_le_chromaticNumber_plane_iff_exists_ball` — the join of UP and DOWN, on the
  standard three axioms (DOWN through the ported `proper_to_borel_weak`): the plane"""),
("""weak colouring of every set of the plane. Rests on the standard three axioms and
`Outside.OAI158.proper_to_borel_weak` (`[OAIMath2026]` family 158). Inhabitant""",
"""weak colouring of every set of the plane. Rests on the standard three axioms, through
`Outside.OAI158.proper_to_borel_weak` (`[OAIMath2026]` family 158, its proof ported). Inhabitant"""),
("""Rests on the standard three axioms and the declared outside theorem `Outside.OAI158.proper_to_borel_weak`
(`[OAIMath2026]` family 158: a proper `k`-colouring of the plane gives a Borel one proper at almost every unit pair).""",
"""Rests on the standard three axioms, through `Outside.OAI158.proper_to_borel_weak` (`[OAIMath2026]` family 158's
theorem, its proof ported: a proper `k`-colouring of the plane gives a Borel one proper at almost every unit pair)."""),
("""Which half needs the import: `→` (a colourable plane gives every disc a weak colouring) is C124-RADIUS-DOWN,
`radius_down`, and rests on the declared outside theorem `Outside.OAI158.proper_to_borel_weak` (`[OAIMath2026]`
family 158); `←` (weak colourings of every disc colour the plane) is C124-RADIUS-UP, `radius_up`, and rests on the
standard three axioms alone. Inhabitant of either side: `k = 7`. -/""",
"""Which half needs the release's transfer: `→` (a colourable plane gives every disc a weak colouring) is
C124-RADIUS-DOWN, `radius_down`, through `Outside.OAI158.proper_to_borel_weak` (`[OAIMath2026]` family 158, its proof
ported); `←` (weak colourings of every disc colour the plane) is C124-RADIUS-UP, `radius_up`, which needs nothing of
the release. Both halves rest on the standard three axioms. Inhabitant of either side: `k = 7`. -/"""),
("""Which half needs the import: `→` (if the plane needs seven colours, some disc has no weak six-colouring) is the
contrapositive of C124-RADIUS-UP — `exists_radius_of_not_colorable` at `k = 6` — and rests on the standard three
axioms alone; `←` (**a disc with no weak six-colouring proves seven**) is the contrapositive of C124-RADIUS-DOWN and
rests on the declared outside theorem `Outside.OAI158.proper_to_borel_weak` (`[OAIMath2026]` family 158).""",
"""Which half needs the release's transfer: `→` (if the plane needs seven colours, some disc has no weak six-colouring)
is the contrapositive of C124-RADIUS-UP — `exists_radius_of_not_colorable` at `k = 6` — and needs nothing of the
release; `←` (**a disc with no weak six-colouring proves seven**) is the contrapositive of C124-RADIUS-DOWN, through
`Outside.OAI158.proper_to_borel_weak` (`[OAIMath2026]` family 158, its proof ported). Both halves rest on the standard
three axioms."""),
],
"Plane/LebesgueNumber.lean": [
("""lemma, joins it to a density-point step this library already held, and composes the result with a declared outside
theorem:""",
"""lemma, joins it to a density-point step this library already held, and composes the result with an outside theorem
whose proof is ported:"""),
("""* **The declared outside theorem** `Outside.OAI158.proper_to_borel_weak` (`[OAIMath2026]` family 158): a proper
  `k`-colouring of the plane gives a Borel one proper at almost every unit pair. Only the last section rests on it.""",
"""* **The release's transfer** `Outside.OAI158.proper_to_borel_weak` (`[OAIMath2026]` family 158, its proof ported and
  checked by this kernel, `Outside/OAI158BorelTransfer`): a proper `k`-colouring of the plane gives a Borel one proper
  at almost every unit pair. Only the last section uses it."""),
("""* `Plane.chromaticNumber_plane_eq_chiLebesgue` — `χ(ℝ²) = χ_m(ℝ²)`. On the standard three axioms and the one declared
  outside theorem `Outside.OAI158.proper_to_borel_weak`.""",
"""* `Plane.chromaticNumber_plane_eq_chiLebesgue` — `χ(ℝ²) = χ_m(ℝ²)`. On the standard three axioms, through the ported
  `Outside.OAI158.proper_to_borel_weak`."""),
("""a Lebesgue-measurable set — given the outside theorem; and, with no outside theorem, a Lebesgue-measurable colouring that""",
"""a Lebesgue-measurable set — by the release's transfer; and, with no outside theorem, a Lebesgue-measurable colouring that"""),
("""Hadwiger–Nelson problem given that theorem and `Outside.OAI158.proper_to_borel_weak`
(`Outside.OAI158.colorable_iff_nonempty_aeColouring`).""",
"""Hadwiger–Nelson problem given that theorem, by the ported `Outside.OAI158.proper_to_borel_weak`
(`Outside.OAI158.colorable_iff_nonempty_aeColouring`)."""),
("""/-! ## On the declared outside theorem `Outside.OAI158.proper_to_borel_weak` -/""",
"""/-! ## Through the release's transfer `Outside.OAI158.proper_to_borel_weak` (ported) -/"""),
("""/-- **Colour by colour, on the outside theorem**: the plane""",
"""/-- **Colour by colour, through the release's transfer**: the plane"""),
("""`exists_proper_of_aeColouring` (`[Davies2026]` Lemma B.1). Rests on the standard three axioms and that one declared
outside theorem. Both sides""",
"""`exists_proper_of_aeColouring` (`[Davies2026]` Lemma B.1). Rests on the standard three axioms (the transfer's proof is
ported). Both sides"""),
("""`Outside.OAI158.chromaticNumber_plane_eq_chiM0` — `[OAIMath2026]`'s transfer, a declared outside theorem — and
`chiM0_eq_chiLebesgue` — `[Davies2026]` Lemma B.1, formalized in this module. Rests on the standard three axioms and the
one declared outside theorem `Outside.OAI158.proper_to_borel_weak`. It says""",
"""`Outside.OAI158.chromaticNumber_plane_eq_chiM0` — `[OAIMath2026]`'s transfer, its proof ported — and
`chiM0_eq_chiLebesgue` — `[Davies2026]` Lemma B.1, formalized in this module. Rests on the standard three axioms,
through the ported `Outside.OAI158.proper_to_borel_weak`. It says"""),
],
}
for f, reps in E.items():
    p = P + f
    s = open(p).read()
    for old, new in reps:
        assert s.count(old) == 1, (f, old[:70], s.count(old))
        s = s.replace(old, new)
    open(p, "w").write(s)
    print(f, len(reps), "replacements")
