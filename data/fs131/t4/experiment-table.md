# FS131-T4 — the experiment's table: one name declared by two modules, Lean v4.32.0

*Written by `tools/fs131_t4_experiment.py` from the outputs under `data/fs131/t4/exp-out/` (one file per row, `exit <status>`
then everything Lean printed). The package is `data/fs131/t4/exp/`; each scenario's two siblings are `T4Exp.<S>.A` and
`T4Exp.<S>.B`. Columns: **declared by** — the modules whose compiled data holds the name, in import order; **held** — the
copy the environment's constant is (identified by the constants its value uses); **attributed** — the module
`Environment.getModuleIdxFor?` gives; **printed for the name** — `collectAxioms` of the name, which is what `#print axioms`
prints; **of the held value** — the axioms collected through the constants the held copy's value uses; **the consumer's
print** — `#print axioms` of `down` (declared in the consumer itself, using the name) or of `useA` / `useB` (imported, each
compiled against one sibling alone).*

## S1 — (i) both clean

`A`: `theorem dup : 2 + 2 = 4 := markA`  ·  `B`: `theorem dup : 2 + 2 = 4 := markB`  ·  the name: `T4.S1.dup`

| consumer | imports, in order | exit | declared by | held | attributed | printed for the name | of the held value | the consumer's print |
|---|---|---|---|---|---|---|---|---|
| OnlyA | A | 0 | A (theorem) | A (theorem) | A | [] | [] | `down`: does not depend on any axioms |
| OnlyB | B | 0 | B (theorem) | B (theorem) | B | [] | [] | `down`: does not depend on any axioms |
| TopAB | A, B | 0 | A (theorem), B (theorem) | B (theorem) | A | [] | [] | `down`: does not depend on any axioms |
| TopBA | B, A | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [] | `down`: does not depend on any axioms |
| UseA_B | UseA (← A), B | 0 | A (theorem), B (theorem) | B (theorem) | A | [] | [] | `useA`: does not depend on any axioms |
| B_UseA | B, UseA (← A) | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [] | `useA`: does not depend on any axioms |
| UseB_A | UseB (← B), A | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [] | `useB`: does not depend on any axioms |
| A_UseB | A, UseB (← B) | 0 | A (theorem), B (theorem) | B (theorem) | A | [] | [] | `useB`: does not depend on any axioms |
| UpAB | A; then writes B's declarations | 1 | A (theorem) | A (theorem) | A | [] | [] | — T4Exp/S1/UpAB.lean:7:8: error: `T4.S1.dup` has already been declared; the file declared [T4.S1.markB] |
| UpBA | B; then writes A's declarations | 1 | B (theorem) | B (theorem) | B | [] | [] | — T4Exp/S1/UpBA.lean:7:8: error: `T4.S1.dup` has already been declared; the file declared [T4.S1.markA] |

## S2 — (ii) A is `sorry`, B clean

`A`: `theorem dup : 2 + 2 = 4 := sorry`  ·  `B`: `theorem dup : 2 + 2 = 4 := markB`  ·  the name: `T4.S2.dup`

| consumer | imports, in order | exit | declared by | held | attributed | printed for the name | of the held value | the consumer's print |
|---|---|---|---|---|---|---|---|---|
| OnlyA | A | 0 | A (theorem) | A (theorem) | A | [sorryAx] | [sorryAx] | `down`: depends on axioms: [sorryAx] |
| OnlyB | B | 0 | B (theorem) | B (theorem) | B | [] | [] | `down`: does not depend on any axioms |
| TopAB | A, B | 0 | A (theorem), B (theorem) | B (theorem) | A | [sorryAx] | [] | `down`: depends on axioms: [sorryAx] |
| TopBA | B, A | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [sorryAx] | `down`: does not depend on any axioms |
| UseA_B | UseA (← A), B | 0 | A (theorem), B (theorem) | B (theorem) | A | [sorryAx] | [] | `useA`: depends on axioms: [sorryAx] |
| B_UseA | B, UseA (← A) | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [sorryAx] | `useA`: depends on axioms: [sorryAx] |
| UseB_A | UseB (← B), A | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [sorryAx] | `useB`: does not depend on any axioms |
| A_UseB | A, UseB (← B) | 0 | A (theorem), B (theorem) | B (theorem) | A | [sorryAx] | [] | `useB`: does not depend on any axioms |
| UpAB | A; then writes B's declarations | 1 | A (theorem) | A (theorem) | A | [sorryAx] | [sorryAx] | — T4Exp/S2/UpAB.lean:7:8: error: `T4.S2.dup` has already been declared; the file declared [T4.S2.markB] |
| UpBA | B; then writes A's declarations | 1 | B (theorem) | B (theorem) | B | [] | [] | — T4Exp/S2/UpBA.lean:6:8: error: `T4.S2.dup` has already been declared; the file declared [] |

## S3 — (iii) A rests on a declared `axiom`, B clean

`A`: `theorem dup : 2 + 2 = 4 := axA`  ·  `B`: `theorem dup : 2 + 2 = 4 := markB`  ·  the name: `T4.S3.dup`

| consumer | imports, in order | exit | declared by | held | attributed | printed for the name | of the held value | the consumer's print |
|---|---|---|---|---|---|---|---|---|
| OnlyA | A | 0 | A (theorem) | A (theorem) | A | [T4.S3.axA] | [T4.S3.axA] | `down`: depends on axioms: [T4.S3.axA] |
| OnlyB | B | 0 | B (theorem) | B (theorem) | B | [] | [] | `down`: does not depend on any axioms |
| TopAB | A, B | 0 | A (theorem), B (theorem) | B (theorem) | A | [T4.S3.axA] | [] | `down`: depends on axioms: [T4.S3.axA] |
| TopBA | B, A | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [T4.S3.axA] | `down`: does not depend on any axioms |
| UseA_B | UseA (← A), B | 0 | A (theorem), B (theorem) | B (theorem) | A | [T4.S3.axA] | [] | `useA`: depends on axioms: [T4.S3.axA] |
| B_UseA | B, UseA (← A) | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [T4.S3.axA] | `useA`: depends on axioms: [T4.S3.axA] |
| UseB_A | UseB (← B), A | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [T4.S3.axA] | `useB`: does not depend on any axioms |
| A_UseB | A, UseB (← B) | 0 | A (theorem), B (theorem) | B (theorem) | A | [T4.S3.axA] | [] | `useB`: does not depend on any axioms |
| UpAB | A; then writes B's declarations | 1 | A (theorem) | A (theorem) | A | [T4.S3.axA] | [T4.S3.axA] | — T4Exp/S3/UpAB.lean:7:8: error: `T4.S3.dup` has already been declared; the file declared [T4.S3.markB] |
| UpBA | B; then writes A's declarations | 1 | B (theorem) | B (theorem) | B | [] | [] | — T4Exp/S3/UpBA.lean:7:8: error: `T4.S3.dup` has already been declared; the file declared [T4.S3.axA] |

## S4 — (iv) A is an `axiom` of the name and type, B a theorem

`A`: `axiom dup : 2 + 2 = 4`  ·  `B`: `theorem dup : 2 + 2 = 4 := markB`  ·  the name: `T4.S4.dup`

| consumer | imports, in order | exit | declared by | held | attributed | printed for the name | of the held value | the consumer's print |
|---|---|---|---|---|---|---|---|---|
| OnlyA | A | 0 | A (axiom) | A (axiom) | A | [T4.S4.dup] | [T4.S4.dup] | `down`: depends on axioms: [T4.S4.dup] |
| OnlyB | B | 0 | B (theorem) | B (theorem) | B | [] | [] | `down`: does not depend on any axioms |
| TopAB | A, B | 0 | A (axiom), B (theorem) | B (theorem) | A | [T4.S4.dup] | [] | `down`: depends on axioms: [T4.S4.dup] |
| TopBA | B, A | 0 | B (theorem), A (axiom) | B (theorem) | B | [] | [] | `down`: does not depend on any axioms |
| UseA_B | UseA (← A), B | 0 | A (axiom), B (theorem) | B (theorem) | A | [T4.S4.dup] | [] | `useA`: depends on axioms: [T4.S4.dup] |
| B_UseA | B, UseA (← A) | 0 | B (theorem), A (axiom) | B (theorem) | B | [] | [] | `useA`: depends on axioms: [T4.S4.dup] |
| UseB_A | UseB (← B), A | 0 | B (theorem), A (axiom) | B (theorem) | B | [] | [] | `useB`: does not depend on any axioms |
| A_UseB | A, UseB (← B) | 0 | A (axiom), B (theorem) | B (theorem) | A | [T4.S4.dup] | [] | `useB`: does not depend on any axioms |
| UpAB | A; then writes B's declarations | 1 | A (axiom) | A (axiom) | A | [T4.S4.dup] | [T4.S4.dup] | — T4Exp/S4/UpAB.lean:7:8: error: `T4.S4.dup` has already been declared; the file declared [T4.S4.markB] |
| UpBA | B; then writes A's declarations | 1 | B (theorem) | B (theorem) | B | [] | [] | — T4Exp/S4/UpBA.lean:6:6: error: `T4.S4.dup` has already been declared; the file declared [] |

## S5 — (v) the types differ

`A`: `theorem dup : 2 + 2 = 4 := markA`  ·  `B`: `theorem dup : 2 + 2 = 4 ∧ True := markB`  ·  the name: `T4.S5.dup`

| consumer | imports, in order | exit | declared by | held | attributed | printed for the name | of the held value | the consumer's print |
|---|---|---|---|---|---|---|---|---|
| OnlyA | A | 0 | A (theorem) | A (theorem) | A | [] | [] | `down`: does not depend on any axioms |
| OnlyB | B | 0 | B (theorem) | B (theorem) | B | [] | [] | `down`: does not depend on any axioms |
| TopAB | A, B | 1 | — | — | — | — | — | — T4Exp/S5/TopAB.lean:1:0: error: import T4Exp.S5.B failed, environment already contains 'T4.S5.dup' from T4Exp.S5.A |
| TopBA | B, A | 1 | — | — | — | — | — | — T4Exp/S5/TopBA.lean:1:0: error: import T4Exp.S5.A failed, environment already contains 'T4.S5.dup' from T4Exp.S5.B |
| UseA_B | UseA (← A), B | 1 | — | — | — | — | — | — T4Exp/S5/UseA_B.lean:1:0: error: import T4Exp.S5.B failed, environment already contains 'T4.S5.dup' from T4Exp.S5.A |
| B_UseA | B, UseA (← A) | 1 | — | — | — | — | — | — T4Exp/S5/B_UseA.lean:1:0: error: import T4Exp.S5.A failed, environment already contains 'T4.S5.dup' from T4Exp.S5.B |
| UseB_A | UseB (← B), A | 1 | — | — | — | — | — | — T4Exp/S5/UseB_A.lean:1:0: error: import T4Exp.S5.A failed, environment already contains 'T4.S5.dup' from T4Exp.S5.B |
| A_UseB | A, UseB (← B) | 1 | — | — | — | — | — | — T4Exp/S5/A_UseB.lean:1:0: error: import T4Exp.S5.B failed, environment already contains 'T4.S5.dup' from T4Exp.S5.A |
| UpAB | A; then writes B's declarations | 1 | A (theorem) | A (theorem) | A | [] | [] | — T4Exp/S5/UpAB.lean:7:8: error: `T4.S5.dup` has already been declared; the file declared [T4.S5.markB] |
| UpBA | B; then writes A's declarations | 1 | B (theorem) | B (theorem) | B | [] | [] | — T4Exp/S5/UpBA.lean:7:8: error: `T4.S5.dup` has already been declared; the file declared [T4.S5.markA] |

## S6 — both are `axiom`s of the name and type

`A`: `axiom dup : 2 + 2 = 4`  ·  `B`: `axiom dup : 2 + 2 = 4`  ·  the name: `T4.S6.dup`

| consumer | imports, in order | exit | declared by | held | attributed | printed for the name | of the held value | the consumer's print |
|---|---|---|---|---|---|---|---|---|
| OnlyA | A | 0 | A (axiom) | A (axiom) | A | [T4.S6.dup] | [T4.S6.dup] | `down`: depends on axioms: [T4.S6.dup] |
| OnlyB | B | 0 | B (axiom) | B (axiom) | B | [T4.S6.dup] | [T4.S6.dup] | `down`: depends on axioms: [T4.S6.dup] |
| TopAB | A, B | 0 | A (axiom), B (axiom) | A, B (axiom) | A | [T4.S6.dup] | [T4.S6.dup] | `down`: depends on axioms: [T4.S6.dup] |
| TopBA | B, A | 0 | B (axiom), A (axiom) | B, A (axiom) | B | [T4.S6.dup] | [T4.S6.dup] | `down`: depends on axioms: [T4.S6.dup] |
| UseA_B | UseA (← A), B | 0 | A (axiom), B (axiom) | A, B (axiom) | A | [T4.S6.dup] | [T4.S6.dup] | `useA`: depends on axioms: [T4.S6.dup] |
| B_UseA | B, UseA (← A) | 0 | B (axiom), A (axiom) | B, A (axiom) | B | [T4.S6.dup] | [T4.S6.dup] | `useA`: depends on axioms: [T4.S6.dup] |
| UseB_A | UseB (← B), A | 0 | B (axiom), A (axiom) | B, A (axiom) | B | [T4.S6.dup] | [T4.S6.dup] | `useB`: depends on axioms: [T4.S6.dup] |
| A_UseB | A, UseB (← B) | 0 | A (axiom), B (axiom) | A, B (axiom) | A | [T4.S6.dup] | [T4.S6.dup] | `useB`: depends on axioms: [T4.S6.dup] |
| UpAB | A; then writes B's declarations | 1 | A (axiom) | A (axiom) | A | [T4.S6.dup] | [T4.S6.dup] | — T4Exp/S6/UpAB.lean:6:6: error: `T4.S6.dup` has already been declared; the file declared [] |
| UpBA | B; then writes A's declarations | 1 | B (axiom) | B (axiom) | B | [T4.S6.dup] | [T4.S6.dup] | — T4Exp/S6/UpBA.lean:6:6: error: `T4.S6.dup` has already been declared; the file declared [] |

## S7 — A is by `native_decide`, B clean

`A`: `theorem dup : 2 + 2 = 4 := by native_decide`  ·  `B`: `theorem dup : 2 + 2 = 4 := markB`  ·  the name: `T4.S7.dup`

| consumer | imports, in order | exit | declared by | held | attributed | printed for the name | of the held value | the consumer's print |
|---|---|---|---|---|---|---|---|---|
| OnlyA | A | 0 | A (theorem) | A (theorem) | A | [T4.S7.dup._native.native_decide.ax_1_1] | [T4.S7.dup._native.native_decide.ax_1_1] | `down`: depends on axioms: [T4.S7.dup._native.native_decide.ax_1_1] |
| OnlyB | B | 0 | B (theorem) | B (theorem) | B | [] | [] | `down`: does not depend on any axioms |
| TopAB | A, B | 0 | A (theorem), B (theorem) | B (theorem) | A | [T4.S7.dup._native.native_decide.ax_1_1] | [] | `down`: depends on axioms: [T4.S7.dup._native.native_decide.ax_1_1] |
| TopBA | B, A | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [T4.S7.dup._native.native_decide.ax_1_1] | `down`: does not depend on any axioms |
| UseA_B | UseA (← A), B | 0 | A (theorem), B (theorem) | B (theorem) | A | [T4.S7.dup._native.native_decide.ax_1_1] | [] | `useA`: depends on axioms: [T4.S7.dup._native.native_decide.ax_1_1] |
| B_UseA | B, UseA (← A) | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [T4.S7.dup._native.native_decide.ax_1_1] | `useA`: depends on axioms: [T4.S7.dup._native.native_decide.ax_1_1] |
| UseB_A | UseB (← B), A | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [T4.S7.dup._native.native_decide.ax_1_1] | `useB`: does not depend on any axioms |
| A_UseB | A, UseB (← B) | 0 | A (theorem), B (theorem) | B (theorem) | A | [T4.S7.dup._native.native_decide.ax_1_1] | [] | `useB`: does not depend on any axioms |
| UpAB | A; then writes B's declarations | 1 | A (theorem) | A (theorem) | A | [T4.S7.dup._native.native_decide.ax_1_1] | [T4.S7.dup._native.native_decide.ax_1_1] | — T4Exp/S7/UpAB.lean:7:8: error: `T4.S7.dup` has already been declared; the file declared [T4.S7.markB] |
| UpBA | B; then writes A's declarations | 1 | B (theorem) | B (theorem) | B | [] | [] | — T4Exp/S7/UpBA.lean:6:8: error: `T4.S7.dup` has already been declared; the file declared [] |

## S8 — one type up to bound-variable names

`A`: `theorem dup (n : Nat) : n + 0 = n := markA n`  ·  `B`: `theorem dup (m : Nat) : m + 0 = m := markB m`  ·  the name: `T4.S8.dup`

| consumer | imports, in order | exit | declared by | held | attributed | printed for the name | of the held value | the consumer's print |
|---|---|---|---|---|---|---|---|---|
| OnlyA | A | 0 | A (theorem) | A (theorem) | A | [] | [] | `down`: does not depend on any axioms |
| OnlyB | B | 0 | B (theorem) | B (theorem) | B | [] | [] | `down`: does not depend on any axioms |
| TopAB | A, B | 0 | A (theorem), B (theorem) | B (theorem) | A | [] | [] | `down`: does not depend on any axioms |
| TopBA | B, A | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [] | `down`: does not depend on any axioms |
| UseA_B | UseA (← A), B | 0 | A (theorem), B (theorem) | B (theorem) | A | [] | [] | `useA`: does not depend on any axioms |
| B_UseA | B, UseA (← A) | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [] | `useA`: does not depend on any axioms |
| UseB_A | UseB (← B), A | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [] | `useB`: does not depend on any axioms |
| A_UseB | A, UseB (← B) | 0 | A (theorem), B (theorem) | B (theorem) | A | [] | [] | `useB`: does not depend on any axioms |
| UpAB | A; then writes B's declarations | 1 | A (theorem) | A (theorem) | A | [] | [] | — T4Exp/S8/UpAB.lean:7:8: error: `T4.S8.dup` has already been declared; the file declared [T4.S8.markB] |
| UpBA | B; then writes A's declarations | 1 | B (theorem) | B (theorem) | B | [] | [] | — T4Exp/S8/UpBA.lean:7:8: error: `T4.S8.dup` has already been declared; the file declared [T4.S8.markA] |

## S9 — a `Prop`-valued instance under its generated name

`A`: `instance : Nonempty Tok := ⟨.a⟩`  ·  `B`: `instance : Nonempty Tok := ⟨.b⟩`  ·  the name: `T4.S9.instNonemptyTok`

| consumer | imports, in order | exit | declared by | held | attributed | printed for the name | of the held value | the consumer's print |
|---|---|---|---|---|---|---|---|---|
| OnlyA | A | 0 | A (theorem) | A (theorem) | A | [] | [] | `down`: does not depend on any axioms |
| OnlyB | B | 0 | B (theorem) | B (theorem) | B | [] | [] | `down`: does not depend on any axioms |
| TopAB | A, B | 0 | A (theorem), B (theorem) | B (theorem) | A | [] | [] | `down`: does not depend on any axioms |
| TopBA | B, A | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [] | `down`: does not depend on any axioms |
| UseA_B | UseA (← A), B | 0 | A (theorem), B (theorem) | B (theorem) | A | [] | [] | `useA`: does not depend on any axioms |
| B_UseA | B, UseA (← A) | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [] | `useA`: does not depend on any axioms |
| UseB_A | UseB (← B), A | 0 | B (theorem), A (theorem) | A (theorem) | B | [] | [] | `useB`: does not depend on any axioms |
| A_UseB | A, UseB (← B) | 0 | A (theorem), B (theorem) | B (theorem) | A | [] | [] | `useB`: does not depend on any axioms |
| UpAB | A; then writes B's declarations | 0 | A (theorem) | A (theorem) | A | [] | [] | — no error; the file declared [T4.S9.instNonemptyTok_1] |
| UpBA | B; then writes A's declarations | 0 | B (theorem) | B (theorem) | B | [] | [] | — no error; the file declared [T4.S9.instNonemptyTok_1] |

## S10 — a data-valued instance under its generated name, one body

`A`: `instance : Inhabited Tok := ⟨.a⟩`  ·  `B`: `instance : Inhabited Tok := ⟨.a⟩`  ·  the name: `T4.S10.instInhabitedTok`

| consumer | imports, in order | exit | declared by | held | attributed | printed for the name | of the held value | the consumer's print |
|---|---|---|---|---|---|---|---|---|
| OnlyA | A | 0 | A (def) | A (def) | A | [] | [] | `down`: does not depend on any axioms |
| OnlyB | B | 0 | B (def) | B (def) | B | [] | [] | `down`: does not depend on any axioms |
| TopAB | A, B | 1 | — | — | — | — | — | — T4Exp/S10/TopAB.lean:1:0: error: import T4Exp.S10.B failed, environment already contains 'T4.S10.instInhabitedTok' from T4Exp.S10.A |
| TopBA | B, A | 1 | — | — | — | — | — | — T4Exp/S10/TopBA.lean:1:0: error: import T4Exp.S10.A failed, environment already contains 'T4.S10.instInhabitedTok' from T4Exp.S10.B |
| UseA_B | UseA (← A), B | 1 | — | — | — | — | — | — T4Exp/S10/UseA_B.lean:1:0: error: import T4Exp.S10.B failed, environment already contains 'T4.S10.instInhabitedTok' from T4Exp.S10.A |
| B_UseA | B, UseA (← A) | 1 | — | — | — | — | — | — T4Exp/S10/B_UseA.lean:1:0: error: import T4Exp.S10.A failed, environment already contains 'T4.S10.instInhabitedTok' from T4Exp.S10.B |
| UseB_A | UseB (← B), A | 1 | — | — | — | — | — | — T4Exp/S10/UseB_A.lean:1:0: error: import T4Exp.S10.A failed, environment already contains 'T4.S10.instInhabitedTok' from T4Exp.S10.B |
| A_UseB | A, UseB (← B) | 1 | — | — | — | — | — | — T4Exp/S10/A_UseB.lean:1:0: error: import T4Exp.S10.B failed, environment already contains 'T4.S10.instInhabitedTok' from T4Exp.S10.A |
| UpAB | A; then writes B's declarations | 0 | A (def) | A (def) | A | [] | [] | — no error; the file declared [T4.S10.instInhabitedTok_1] |
| UpBA | B; then writes A's declarations | 0 | B (def) | B (def) | B | [] | [] | — no error; the file declared [T4.S10.instInhabitedTok_1] |

## S11 — two `def`s of one name, type and body

`A`: `def dup : Nat := 4`  ·  `B`: `def dup : Nat := 4`  ·  the name: `T4.S11.dup`

| consumer | imports, in order | exit | declared by | held | attributed | printed for the name | of the held value | the consumer's print |
|---|---|---|---|---|---|---|---|---|
| OnlyA | A | 0 | A (def) | A (def) | A | [] | [] | `down`: does not depend on any axioms |
| OnlyB | B | 0 | B (def) | B (def) | B | [] | [] | `down`: does not depend on any axioms |
| TopAB | A, B | 1 | — | — | — | — | — | — T4Exp/S11/TopAB.lean:1:0: error: import T4Exp.S11.B failed, environment already contains 'T4.S11.dup' from T4Exp.S11.A |
| TopBA | B, A | 1 | — | — | — | — | — | — T4Exp/S11/TopBA.lean:1:0: error: import T4Exp.S11.A failed, environment already contains 'T4.S11.dup' from T4Exp.S11.B |
| UseA_B | UseA (← A), B | 1 | — | — | — | — | — | — T4Exp/S11/UseA_B.lean:1:0: error: import T4Exp.S11.B failed, environment already contains 'T4.S11.dup' from T4Exp.S11.A |
| B_UseA | B, UseA (← A) | 1 | — | — | — | — | — | — T4Exp/S11/B_UseA.lean:1:0: error: import T4Exp.S11.A failed, environment already contains 'T4.S11.dup' from T4Exp.S11.B |
| UseB_A | UseB (← B), A | 1 | — | — | — | — | — | — T4Exp/S11/UseB_A.lean:1:0: error: import T4Exp.S11.A failed, environment already contains 'T4.S11.dup' from T4Exp.S11.B |
| A_UseB | A, UseB (← B) | 1 | — | — | — | — | — | — T4Exp/S11/A_UseB.lean:1:0: error: import T4Exp.S11.B failed, environment already contains 'T4.S11.dup' from T4Exp.S11.A |
| UpAB | A; then writes B's declarations | 1 | A (def) | A (def) | A | [] | [] | — T4Exp/S11/UpAB.lean:6:4: error: `T4.S11.dup` has already been declared; the file declared [] |
| UpBA | B; then writes A's declarations | 1 | B (def) | B (def) | B | [] | [] | — T4Exp/S11/UpBA.lean:6:4: error: `T4.S11.dup` has already been declared; the file declared [] |

## S12 — an equation lemma Lean generates on demand (`T4.fn.eq_1`), asked for in both

`A`: `theorem askA : T4.fn 0 = 1 := T4.fn.eq_1`  ·  `B`: `theorem askB : T4.fn 0 = 1 := T4.fn.eq_1`  ·  the name: `T4.fn.eq_1`

| consumer | imports, in order | exit | declared by | held | attributed | printed for the name | of the held value | the consumer's print |
|---|---|---|---|---|---|---|---|---|
| OnlyA | A | 0 | A (theorem) | A (theorem) | A | [] | [] | `down`: does not depend on any axioms |
| OnlyB | B | 0 | B (theorem) | B (theorem) | B | [] | [] | `down`: does not depend on any axioms |
| TopAB | A, B | 0 | A (theorem), B (theorem) | A, B (theorem) | A | [] | [] | `down`: does not depend on any axioms |
| TopBA | B, A | 0 | B (theorem), A (theorem) | B, A (theorem) | B | [] | [] | `down`: does not depend on any axioms |
| UseA_B | UseA (← A), B | 0 | A (theorem), B (theorem) | A, B (theorem) | A | [] | [] | `useA`: does not depend on any axioms |
| B_UseA | B, UseA (← A) | 0 | B (theorem), A (theorem) | B, A (theorem) | B | [] | [] | `useA`: does not depend on any axioms |
| UseB_A | UseB (← B), A | 0 | B (theorem), A (theorem) | B, A (theorem) | B | [] | [] | `useB`: does not depend on any axioms |
| A_UseB | A, UseB (← B) | 0 | A (theorem), B (theorem) | A, B (theorem) | A | [] | [] | `useB`: does not depend on any axioms |
| UpAB | A; then writes B's declarations | 0 | A (theorem) | A (theorem) | A | [] | [] | — no error; the file declared [T4.S12.askB] |
| UpBA | B; then writes A's declarations | 0 | B (theorem) | B (theorem) | B | [] | [] | — no error; the file declared [T4.S12.askA] |

## The tool's own checks

- all passed: the leaf modules built; every consumer expected to elaborate did, and every one expected to fail did — with
  `environment already contains` for an import of two copies, and `has already been declared` for a redeclaration over an
  imported copy; each `OnlyA` / `OnlyB` partner reports one declaring module, its own copy held, and equal axiom readings; in
  S2 the held value's axioms hold `sorryAx` exactly when the held copy is the `sorry` one; `lake build` of each `Top` module
  agrees with `lake env lean` (status, and the axioms printed).
