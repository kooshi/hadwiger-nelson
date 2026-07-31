import Proofs.HadwigerNelson.Instances.DeGrey.Split
import Proofs.HadwigerNelson.Instances.DeGrey.HalfA.Table
import Proofs.HadwigerNelson.Instances.DeGrey.HalfB.Table
import Proofs.HadwigerNelson.Sat.Forcing

/-!
# The negative controls for the split and the forcing argument

`CLAUDE.md`: *a check is not known to work until it has been seen to fail.* The positive claims in
`Instances/DeGrey/{Split,Forcing,Bound}.lean` would all hold of a decomposition that was quietly
wrong, so each gets a partner here that goes red — and the partners are **committed**, so they fire on
every build rather than once in a session nobody can re-run.

Two of M06's failure modes are not exercised at full scale, because the price is not worth paying:
corrupting a clause-table chunk or moving the joining edge invalidates 2,265 segment modules and four
hours of kernel time. They are exercised at spec scale instead — `Sat/ClauseTable.lean` corrupts a
chunk and watches `agreesWithCNF` refuse, `Sat/MaskCheck.lean` hands the checker a satisfiable formula
and watches it refuse. **Stated so that nobody reads the list below as complete.**

What is here is two hypotheses shown load-bearing by **countermodel** — a theorem, where a failed build
is only an anecdote — and one where no countermodel exists and the section says so instead of
pretending otherwise. The second countermodel found a false claim in a docstring of mine, which is the
best argument for writing these at all.
-/

namespace HadwigerNelson

/-! ### Relabelling colours must be injective, and here is why

`valid_comp_of_injective` is what lets one certificate cover three colour cases. Delete its
injectivity hypothesis and the statement becomes **false**: a relabelling that merges two colours
turns a proper colouring into an improper one, so the symmetry argument would conclude anything.

The witness is the smallest one there is — one edge, two colours, and the constant relabelling. -/
theorem not_valid_comp_of_not_injective :
    ¬ ∀ (f : Fin 2 → Fin 4) (σ : Fin 4 → Fin 4),
        (∀ i j, (edgeGraph 2 [(0, 1)]).Adj i j → f i ≠ f j) →
        ∀ i j, (edgeGraph 2 [(0, 1)]).Adj i j → σ (f i) ≠ σ (f j) := by
  intro h
  have hadj : (edgeGraph 2 [(0, 1)]).Adj 0 1 := edgeGraph_adj_of_mem (by decide) (by decide)
  exact h (fun i => i.castLE (by norm_num)) (fun _ => 0)
    (fun i j hij hg => hij.1 (Fin.castLE_injective (by norm_num) hg)) 0 1 hadj rfl

/-! ### A degenerate cube is unprovable, not free — and that corrected a docstring

`eq_of_pinned_unsat` is handed its cube as a literal, so nothing in the type stops
`[(u, 0), (u, 1)]`. Its docstring used to claim such a cube makes the pinned formula "trivially
unsatisfiable". **It does not**, and this is the control that caught it: the encoding omits
at-most-one-colour clauses on purpose, so pinning one vertex to colour 0 *and* colour 1 asks for two
different variables to be true, which any assignment can do.

The safety argument is therefore the other one — the conclusion `f u = f u` is trivially true — and
the degenerate hypothesis is simply unprovable. Proved here, so the claim is a theorem rather than a
sentence: -/
theorem sat_degenerate_cube :
    ∃ a, Std.Sat.CNF.Sat a (coloringCNF 4 2 [] ++ cubeCNF 4 2 [(0, 0), (0, 1)]) :=
  ⟨fun _ => true,
    show Std.Sat.CNF.eval (fun _ => true) (coloringCNF 4 2 [] ++ cubeCNF 4 2 [(0, 0), (0, 1)]) = true
      by decide +kernel⟩

/-! ### The two ends of the joining edge must be distinct, and this one cannot be a countermodel

`not_colorable_of_forcing` derives that both ends of the joining edge take the shared vertex's colour
and then contradicts adjacency; at `a = b` there is nothing to contradict. The hypothesis `hab` is what
stops that, and dropping it is caught by the elaborator rather than by a countermodel — **because no
countermodel exists at a size anyone can write down.** A countermodel would need a small graph in which
two non-adjacent vertices are genuinely forced to share a colour, and forcing of that kind is exactly
what de Grey's construction is for: measured, it does not even appear in the 395-vertex layer of his own
graph, where all four pin combinations are satisfiable.

**So there is no control for `hab` here, and that is the honest report rather than an oversight.** Its
necessity is carried by the signature — `not_colorable_of_forcing` cannot be applied without it, and
attempting `a = b` fails on the joining edge instead, since `(11, 11)` is not in the edge list. What
cannot be exhibited is a *model* in which dropping it produces a false theorem.

The one control this project has for that class of hypothesis remains M05's: the non-tautology
hypothesis of `propagate_prop_sound`, where a countermodel does exist and is committed. -/

/-! ## Cross-filing: a certificate attached to the wrong formula

`ARCHITECTURE.md` lists "a certificate silently attached to the wrong problem" as a defence, and until
now it was a *procedure* — regenerate against the other half and watch the build go red. A procedure
that is expensive to run is a procedure nobody runs, and one that is never run is not a defence.

Stated as an obligation instead, it costs a fraction of a second: `agreesWithCNF` is
`(firstFault f).isNone`, and `firstFault` stops at the first clause that disagrees, which for two
different formulas is immediate. So the control is now a theorem that fires on every build.

**Read the direction carefully.** `halfA_agrees` says half A's table matches half A's formula; that is
consistent with a table that matches *everything*, which would certify anything. This says it does
not. The pair is what makes either one mean something. -/
theorem halfA_table_refuses_halfB_cnf : halfATable.agreesWithCNF halfBCnf = false := by
  decide +kernel

theorem halfB_table_refuses_halfA_cnf : halfBTable.agreesWithCNF halfACnf = false := by
  decide +kernel

end HadwigerNelson
