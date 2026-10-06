chk() { if grep -qF -- "$2" "$1"; then echo "MATCH  $1 :: ${2:0:70}"; else echo "MISMATCH $1 :: ${2:0:70}"; fi; }
chk CLAUDE.md "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time."
chk plans/FS131-kernel-plan.md "### 7.3 What each wave's planning job must hold"
chk plans/FS131-kernel-plan.md '1. **Reads its rows'"'"' derivation entries in full** (the CSV gives each row'"'"'s address in `plans/LEAN-BACKLOG.md`, which gives the derivation file'"'"'s line),'
chk plans/FS131-kernel-plan.md '3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in'
chk plans/FS131-kernel-plan.md '4. **Names every hypothesis from outside the backlog** in the declaration'"'"'s docstring and in § 7.4'"'"'s list; never imports a hand result of ours as an'
chk plans/FS131-kernel-plan.md '**Wave 10** (14 rows):'
chk plans/FS131-kernel-plan.md '- `Arith/StandingFive`: TC1-STANDING-FIVE'
chk plans/FS131-kernel-plan.md '- `Arith/CharacterColouring`: FS89-CL2, FS89-S0A-10, FS89-S0A-2'
chk plans/FS131-kernel-plan.md '- `Arith/SpectralInputs`: J45-N1, J45-N2, J45-SI-4, J45-SI-5, J45-SI-C, J45-SI-J, J45-SP-if, J45-SP-oi'
chk plans/FS131-kernel-plan.md '- `Arith/StationaryRatio`: X25B-L1, X25B-PZ'
chk plans/FS131-kernel-plan.md '| `Row123Chain` | row 123'"'"'s chain (`min(L(F), 5) ≤ χ(F²)` for every real number field, given MR) | TC1-STANDING-FIVE'"'"'s MR clause (wave 10) | FS-101 |'
