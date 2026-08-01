import Proofs.HadwigerNelson.Instances.DeGrey.HalfA.Table
import Proofs.HadwigerNelson.Instances.DeGrey.Forcing
import Proofs.HadwigerNelson.Sat.Diagnose

/-!
# The negative controls for the rotation and the composition

`CLAUDE.md`: *a check is not known to work until it has been seen to fail.* The positive claims in
`Instances/DeGrey/{Rotation,Rotated,Forcing,Bound}.lean` would all hold of an argument that was
quietly wrong, so each gets a partner here that goes red — and the partners are **committed**, so they
fire on every build rather than once in a session nobody can re-run.

One failure mode is not exercised at full scale, because the price is not worth paying: corrupting a
clause-table chunk invalidates 1,222 segment modules and hours of kernel time. It is exercised at spec
scale instead — `Sat/ClauseTable.lean` corrupts a chunk and watches `agreesWithCNF` refuse,
`Sat/MaskCheck.lean` hands the checker a satisfiable formula and watches it refuse. **Stated so that
nobody reads the list below as complete.**
-/

set_option maxRecDepth 1000000

namespace HadwigerNelson

/-! ### Relabelling colours must be injective, and here is why

`valid_comp_of_injective` is what lets one certificate cover twenty-four colour patterns. Delete its
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

/-! ### A degenerate pinning is vacuous, not unsound

`Gadget.ofUnsat` is handed a port tuple and a pattern, and nothing in the type stops the tuple from
naming one vertex twice with two different colours in the pattern. That cube is **satisfiable** — the
encoding omits at-most-one-colour clauses on purpose, so pinning one vertex to colour 0 *and* colour 1
asks for two different variables to be true, which any assignment can do.

So a degenerate pinning yields no certificate, and even if one existed the gadget it produced would
admit everything: no proper colouring can give one vertex two colours, so `samePattern` is false at
every real colouring and `admits` is `true` throughout. **Vacuous, never unsound** — and this is the
theorem rather than the sentence: -/
theorem sat_degenerate_cube :
    ∃ a, Std.Sat.CNF.Sat a (coloringCNF 4 2 [] ++ cubeCNF 4 2 [(0, 0), (0, 1)]) :=
  ⟨fun _ => true,
    show Std.Sat.CNF.eval (fun _ => true) (coloringCNF 4 2 [] ++ cubeCNF 4 2 [(0, 0), (0, 1)]) = true
      by decide +kernel⟩

/-! ### The composition must not refute without all three constraints

`deGreyRot_not_colorable_four` says the three gadgets jointly admit nothing. That claim is worth
nothing unless dropping one of them lets a colouring through — otherwise the composition would report
"admits nothing" whatever it were handed.

Drop the joining edge, and exactly the four all-one-colour patterns survive. Those are precisely the
colourings the joining edge forbids, which is the argument stated backwards. -/
theorem deGrey_forcing_alone_admits :
    (deGreyForcedA.inter deGreyForcedB).survivors = [[0, 0, 0], [1, 1, 1], [2, 2, 2], [3, 3, 3]] := by
  decide

/-! ### The rotation must land on the right vertices

`deGreyForcedB` is the first copy's constraint moved by the rotation, and it says something about
vertex 802 only because the rotation sends vertex 11 there. Move either port and the transport does
not typecheck; these pin the two facts it rests on, compiled, on every build. -/

#guard deGreyPhiNat 14 = 14
#guard deGreyPhiNat 11 = 802

-- …and the rotation is a rotation only because `31² + (3√7)² = 32²`. At 30 it is not, and the
-- structure cannot be built at all — so the control here is the arithmetic itself, which a reader can
-- check by eye: 961 + 63 = 1024, and 900 + 63 is not.
#guard 31 * 31 + 3 * 3 * 7 = 32 * 32
#guard 30 * 30 + 3 * 3 * 7 ≠ 32 * 32

/-! ## Cross-filing: a certificate attached to the wrong formula

`ARCHITECTURE.md` lists "a certificate silently attached to the wrong problem" as a defence, and until
M07 it was a *procedure* — regenerate against the other half and watch the build go red. A procedure
that is expensive to run is a procedure nobody runs, and one that is never run is not a defence.

Stated as an obligation instead, it costs a fraction of a second: `agreesWithCNF` is
`(firstFault f).isNone`, and `firstFault` stops at the first clause that disagrees, which for two
different formulas is immediate.

**Read the direction carefully.** `halfA_agrees` says half A's table matches half A's formula; that is
consistent with a table that matches *everything*, which would certify anything. This says it does
not. The pair is what makes either one mean something.

The formula it is checked against is de Grey's *second* half — which no longer has a certificate, but
whose edge list is still emitted, so the control survives the deletion of 1,043 modules. -/

/-- The second half's formula. Its certificate is gone — M09 derives that half from the first by a
rotation — but the formula it would have been filed against is still a formula, and it is exactly
what half A's table must refuse. -/
def halfBCnf : Std.Sat.CNF Nat :=
  coloringCNF 4 1581 deGreyHalfBEdges ++ cubeCNF 4 1581 [(14, 0), (802, 1)]

theorem halfA_table_refuses_halfB_cnf : halfATable.agreesWithCNF halfBCnf = false := by
  decide +kernel

-- And the *diagnosis* a cross-filing produces, pinned. A build-fault table that sends the reader to
-- `#eval t.faultReport f` is only worth reading if what comes back is worth reading, so the rendered
-- text is under regression control here rather than described in prose. Half A's first edge is
-- (0, 5) — variables 0 and 20 at colour 0 — and half B's is (14, 799).
/-- info: "slot 1581: the table holds [(0, false), (20, false)], the formula wants [(56, false), (3196, false)]" -/
#guard_msgs in
#eval halfATable.faultReport halfBCnf

end HadwigerNelson
