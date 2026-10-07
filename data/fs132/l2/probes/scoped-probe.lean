-- FS132-L2 probe (iteration only): how `scoped instance` behaves at the pin, for the three instances of
-- `Outside/OAI158Palette` on Mathlib types.  (1) an anonymous instance scoped in a child namespace keeps its generated
-- name; (2) `attribute [scoped instance]` in the parent namespace adds the parent's scope; (3) `private scoped instance`
-- parses; (4) outside the namespace none is found; (5) under `open` each is.
class Foo (α : Type) : Prop
/-- A stand-in for Mathlib's `Fact` (the probe imports nothing). -/
class Fact (p : Prop) : Prop where
  /-- the fact -/
  out : p
namespace A.B
abbrev Space := {n : Nat // n < 3}
scoped instance : Foo Space := ⟨⟩
example : Foo Space := inferInstance
end A.B
namespace A
example : Foo B.Space := by first | exact inferInstance | exact (by trace "NOT FOUND in parent before the attribute (expected)"; exact ⟨⟩)
attribute [scoped instance] B.instFooSpace
example : Foo B.Space := inferInstance
private scoped instance : Fact ((2 : Nat) ≠ 3) := ⟨by decide⟩
example : Fact ((2 : Nat) ≠ 3) := inferInstance
end A
#check @A.B.instFooSpace
example : Foo A.B.Space := by first | exact inferInstance | exact (by trace "NOT FOUND outside the namespace (expected)"; exact ⟨⟩)
example : Fact ((2 : Nat) ≠ 3) := by first | exact inferInstance | exact (by trace "Fact NOT FOUND outside the namespace (expected)"; exact ⟨by decide⟩)
namespace A
example : Foo B.Space := inferInstance
example : Fact ((2 : Nat) ≠ 3) := inferInstance
end A
namespace C
open A
example : Foo A.B.Space := inferInstance
example : Fact ((2 : Nat) ≠ 3) := inferInstance
end C
