namespace T4P
/-- A two-element type, for the instance pair. -/
inductive Tok where
  | a
  | b
/-- A recursive function, so that Lean generates its equation lemma on demand. -/
def fn : Nat → Nat
  | 0 => 1
  | n + 1 => fn n
end T4P
