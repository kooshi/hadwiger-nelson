import Mathlib.Order.Filter.Defs
/-! FS131-IP23 — at the RELEASE's pin (Mathlib v4.34.1), run in the audit's working copy by `lake env lean`: the
comparator rule EVENTUALLYEQSET of `tools/fs131_ip23_port_readback.py` writes the release's `Filter.EventuallyEqSet l s t`
as `Filter.EventuallyEq l s t` (sets read as predicates), which is how `s =ᵐ[μ] t` on sets elaborates at this library's
pin.  The kernel checks that the two are one term up to definitional unfolding; the control, the two sets exchanged,
must be refused (`EXPECTED-FAILURE` below). -/
theorem fs131ip23_eventuallyEqSet_rfl {α : Type*} (l : Filter α) (s t : Set α) :
    Filter.EventuallyEqSet l s t = Filter.EventuallyEq l s t := rfl
-- EXPECTED-FAILURE (the control): the sets exchanged on one side
theorem fs131ip23_eventuallyEqSet_control {α : Type*} (l : Filter α) (s t : Set α) :
    Filter.EventuallyEqSet l s t = Filter.EventuallyEq l t s := rfl
#print axioms fs131ip23_eventuallyEqSet_rfl
