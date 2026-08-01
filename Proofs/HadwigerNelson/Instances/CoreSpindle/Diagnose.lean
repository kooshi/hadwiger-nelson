import Proofs.HadwigerNelson.Instances.CoreSpindle.Bound

/-!
# What a failed weight bound was about

`noHeavy` answers `true` or `false`, and a `false` is the normal state of affairs while weights are
being searched for. What the next step needs is not an explanation but **the independent set that
beat the bound** — that set is exactly the constraint a cutting-plane search adds before solving
again. So the failure path and a search's inner loop are the same function.

`findHeavy` is that function, and its honesty is a theorem rather than a test:
`findHeavy_isNone` says it returns nothing **exactly** when `noHeavy` returns `true`. The two cannot
drift apart, which is what makes the message quotable — a diagnostic that could disagree with the
check it explains is the failure mode `ARCHITECTURE.md` § 6 names.

It is named for what it does. The search stops at the *first* set it meets over the bound, not the
heaviest, and for a separation oracle any violated constraint will do.

Nothing imports this module, so it may be rewritten for the cost of one file.
-/

namespace HadwigerNelson

open SimpleGraph

variable {n : ℕ}

/-- An independent set the masks admit whose weight exceeds `D`, together with that weight — or
`none`, which by `findHeavy_isNone` means `noHeavy` said `true`.

Same recursion and same prune as `noHeavy`; only the answer differs. This runs compiled, never in
the kernel, so it carries the vertices along for the report. -/
def findHeavy (E : List (Fin n × Fin n)) (w : Fin n → ℕ) (D : ℕ) :
    List (Fin n) → ℕ → List (Fin n) → ℕ → ℕ → Option (List (Fin n) × ℕ)
  | [], _, acc, wt, _ => if D < wt then some (acc.reverse, wt) else none
  | u :: rest, chosen, acc, wt, rem =>
      if wt + rem ≤ D then none
      else
        (findHeavy E w D rest chosen acc wt (rem - w u)).or
          (if nbrMask E u &&& chosen != 0 then none
           else findHeavy E w D rest (chosen ||| 2 ^ u.val) (u :: acc) (wt + w u) (rem - w u))

/-- **The diagnostic cannot drift from the check.** `findHeavy` finds nothing exactly when
`noHeavy` says there is nothing to find. -/
theorem findHeavy_isNone (E : List (Fin n × Fin n)) (w : Fin n → ℕ) (D : ℕ) :
    ∀ (order : List (Fin n)) (chosen : ℕ) (acc : List (Fin n)) (wt rem : ℕ),
      (findHeavy E w D order chosen acc wt rem).isNone = noHeavy D (mkSlots E w order) chosen wt rem
  | [], chosen, acc, wt, rem => by
      have : mkSlots E w ([] : List (Fin n)) = [] := rfl
      rw [this]
      simp only [findHeavy, noHeavy]
      split <;> simp <;> omega
  | u :: rest, chosen, acc, wt, rem => by
      -- Keep `mkSlots E w rest` folded, so it matches the induction hypotheses verbatim.
      have hcons : mkSlots E w (u :: rest) = (2 ^ u.val, nbrMask E u, w u) :: mkSlots E w rest := rfl
      rw [hcons]
      simp only [findHeavy, noHeavy]
      split
      · rename_i h; simp [h]
      · rename_i h
        -- Both induction hypotheses turn the right-hand side back into `Option`s, and then the
        -- claim is eight trivial cases.
        rw [← findHeavy_isNone E w D rest chosen acc wt (rem - w u),
          ← findHeavy_isNone E w D rest (chosen ||| 2 ^ u.val) (u :: acc) (wt + w u) (rem - w u)]
        rcases hfa : findHeavy E w D rest chosen acc wt (rem - w u) with _ | ra <;>
          rcases hfb : findHeavy E w D rest (chosen ||| 2 ^ u.val) (u :: acc) (wt + w u)
            (rem - w u) with _ | rb <;>
          by_cases hblk : nbrMask E u &&& chosen = 0 <;>
          simp [hblk, h]

/-! ## The witness this project ships

Two `#eval`s, both pinned, and between them they say the certificate is **tight**: the heaviest
independent set weighs exactly 72, so `72` is the smallest bound these weights admit and `71` is
already false. -/

/-- info: none -/
#guard_msgs in
#eval findHeavy coreSpindle.edges coreSpindleWeights 72 coreSpindleOrder 0 [] 0 260

/-- info: some ([32, 7, 13, 29, 56, 58, 20, 24, 26, 34, 37, 51, 4, 46, 62, 40], 72) -/
#guard_msgs in
#eval findHeavy coreSpindle.edges coreSpindleWeights 71 coreSpindleOrder 0 [] 0 260

/-- The set the line above reports, written out — the `#guard_msgs` pin is what ties this literal to
what `findHeavy` actually returns, and copying it here means the two checks below cost one list walk
instead of another whole search. -/
def coreSpindleHeavy : List (Fin 63) :=
  [32, 7, 13, 29, 56, 58, 20, 24, 26, 34, 37, 51, 4, 46, 62, 40]

-- **The message, checked by something that has never heard of the search.** The reported set really
-- is independent in the certificate's own edge list...
#guard coreSpindleHeavy.all fun u => coreSpindleHeavy.all fun v =>
  u == v || !(coreSpindle.edges.contains (u, v) || coreSpindle.edges.contains (v, u))

-- ...and really does weigh 72, which is the bound. So `72` is not slack and `71` is genuinely
-- unprovable — a diagnostic that reported a lighter set, or a set with an edge inside it, fails
-- here rather than being believed.
#guard (coreSpindleHeavy.map coreSpindleWeights).sum == 72

end HadwigerNelson
