open Lean Elab Command in
run_cmd do
  -- the constants this file declares, the footer's own two left out
  FS131IN1Axioms.run (((← getEnv).constants.map₂.toList.map (·.1)).filter (!(`FS131IN1Axioms).isPrefixOf ·)).toArray
