
-- FS133-IA1 footer (appended to a scratch copy, never to the module): every constant this file declares, with the
-- hash of its stored type and, for a definition, of its stored value.
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let mut rows : Array String := #[]
  for (n, ci) in env.constants.map₂.toList do
    let v := match ci with | .defnInfo d => s!" value={d.value.hash}" | _ => ""
    let k := match ci with | .thmInfo _ => "THM" | .defnInfo _ => "DEF" | .axiomInfo _ => "AXIOM" | _ => "OTHER"
    rows := rows.push s!"FOOT {k} {n} type={ci.type.hash}{v}"
  for r in rows.qsort (· < ·) do IO.println r
  IO.println s!"FOOTDONE {rows.size}"
