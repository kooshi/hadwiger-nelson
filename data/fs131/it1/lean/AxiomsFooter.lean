
/-! FS131-IT1: appended to a copy of `Arith/TorsionExtraction.lean` (never part of the library) — prints the axioms of every
theorem and definition the file declares (private helpers included; names Lean generates inside a declaration skipped),
one line each, sorted. -/
open Lean Elab Command in
run_cmd do
  let env ← getEnv
  let mut rows : Array (String × String) := #[]
  for (n, ci) in env.constants.map₂.toList do
    let isDecl := match ci with | .thmInfo _ => true | .defnInfo _ => true | _ => false
    if !isDecl then continue
    let user := (privateToUserName? n).getD n
    if user.isInternalDetail then continue
    let ax ← liftCoreM <| collectAxioms n
    let axs := (ax.map toString).qsort (· < ·)
    let kind := if (privateToUserName? n).isSome then "private" else "public"
    rows := rows.push (user.toString, s!"AXIOMS {kind} {user} : {axs.toList}")
  for (_, l) in rows.qsort (fun a b => a.1 < b.1) do
    IO.println l
  IO.println s!"AXIOMS-COUNT {rows.size}"
