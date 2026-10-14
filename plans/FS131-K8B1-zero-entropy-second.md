# FS131-K8B1 — the five-colour chain: M8b's parts 2–4 typed to their leaves over `TateModel F`, ending at `zeroEntropyCarried`

*de Bruijn, the planner (the eighth on this chain). Brief: `data/fs131/briefs/FS131-K8B1-zero-entropy-second.md` (on `main`).
Branch `fs131-wk8b`, cut from `fs131-wkt` at `392fc2b62`, in the worktree `.claude/worktrees/fs131-wch`. Working files:
`data/fs131/k8b1/`.*

## Theorems this phase proved

A planning job; it proves no theorem of the mathematics. (Compositions of typed leaves, each a few lines, are listed in the
stage that typed them.)

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`data/fs131/k8b1/readback.py` (FS131-KT1's reader, copied; unchanged in logic) reads every block of the brief that begins with
`> ` and ends with `> — source: <path>`, and checks its text, character for character, as a substring of the source on `main`.
**Seven quotations, seven matches** (`logs/readback.log`): W2 (`data/fs131/REQUEST-2026-10-13.md`), NF2-LEAF-21 and the three
dated lines (`data/fs131/claims-NF2.md`), inventory items 791 and 799 (`plans/FS131-close-inventory.md`). **The control**:
`--plant` changes one character of the first quotation; the run reports exactly that one `MISMATCH` (`logs/readback-plant.log`).

**One finding about the record the brief quotes, not about the brief:** items 791 and 799 say "12:45 UTC logged" and "14:20 UTC
logged", and this job started at 08:55 UTC (`date -u`); the commit that files item 799 is `fcb1922ed`, 2026-10-14 08:54 +0000
= 08:54 UTC. The inventory's "UTC" times run about five and a half hours ahead of the clock (a slip in the inventory's clock
line; the brief's own "08:54 UTC" is right).

### 1.2 The build of the branch

`lake build --no-build` under the slot: `exit=0`, "All targets up-to-date (6064 jobs)" (`logs/nobuild0.log`). The tree's build
is current for `392fc2b62`.

### 1.3 The three parts, restated from FS131-KN9 § 4.2, with what each reads of the interface, field by field

The interface's nine fields (`Rigidity/TateModel`): `π`; `continuous_π`; `π_unit_mul`; `surjective_π`; `ker_subset`;
`stableIntegers_le` (`O′ ⊆ Λ`); `exists_nat_mul_mem` (`Λ ⊆ d⁻¹O′`); `exists_isCompact` (`W = K + O′`); `arch_mem`. Its
theorems: `ker_eq`, `mul_mem_Λ`, `π_eq_π_iff`, `toSAdele_mem_torsionChars`, `mem_TA`, `isOpenMap`.

| part (KN9 § 4.2) | X01D | reads of the interface |
|---|---|---|
| **M8b-2**: thin boxes; Lemma PF; the expanding place; local injectivity; Lemma 3.1′ over EN2-ZE | §§ 3.1–3.3 | `exists_nat_mul_mem` (Lemma PF for `Λ`, through `d·Λ ⊆ O′`); `isOpenMap` (`π(c + Q(ε))` open, part (i)); `surjective_π` (the translates cover, part (i)); `π_unit_mul` (the orbit of a lift, part (ii)); `π_eq_π_iff` (lifts differ by `Λ`, part (ii)); `continuous_π` and `exists_isCompact` (images of closed sets are Borel: `W` σ-compact) |
| **M8b-3**: the pigeonhole over `z = 1 + 2bi`; two scales; one global point | §§ 3.4–3.6 | `π_unit_mul` (`v·B = π(v(x̃ + Q))`); `π_eq_π_iff` (the collision `r ∈ Λ`); `mul_mem_Λ` (`z = ℓ₂r₁ − ℓ₁r₂ ∈ Λ`); `exists_nat_mul_mem` (Lemma PF); `continuous_π`, `exists_isCompact` (measurability of the boxes' images) |
| **M8b-4**: leaves and wandering shells; the conclusion | §§ 3.7–3.8 | `π_eq_π_iff` (the leaf of a point is unique); `π_unit_mul` (a rotation moves a shell); `continuous_π`, `exists_isCompact` (shells are Borel); `mem_TA` (through `toSAdele_mem_torsionChars`, i.e. `stableIntegers_le`, and `arch_mem`) |

`ker_subset` is read only through `π_eq_π_iff`; `stableIntegers_le` only through `mem_TA` (the torsion half). Every field is read.
