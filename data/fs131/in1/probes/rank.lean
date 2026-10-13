import Proofs.HadwigerNelson.Arith.TorsionExtraction
-- FS131-IN1 probe: a `letI` module structure makes `inferInstance : Module.Free (ZMod p) M` "stuck"; a `haveI` one does not.
example (M : Type) [AddCommGroup M] (p : ℕ) [hp : Fact p.Prime] (hpx : ∀ x : M, p • x = 0) : True := by
  haveI : Module (ZMod p) M := AddCommGroup.zmodModule hpx
  have h2 : Module.Free (ZMod p) M := inferInstance
  trivial
example (M : Type) [AddCommGroup M] (p : ℕ) [hp : Fact p.Prime] (hpx : ∀ x : M, p • x = 0) : True := by
  letI : Module (ZMod p) M := AddCommGroup.zmodModule hpx
  have h2 : Module.Free (ZMod p) M := inferInstance
  trivial
