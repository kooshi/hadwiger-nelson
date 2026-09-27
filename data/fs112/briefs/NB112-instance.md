*Instance file for job **FS112-NB**, added by the owner at launch (2026-09-27), as `NB112-verify-proof.md` asks: the claim ids FS112-N's report gives
verdicts on, **with each verdict withheld**, and the side's new statements quoted verbatim from its record's "Theorems this phase proved" table (each is a
claim; its grade is withheld). Derive your own verdict on each and commit stage 1 before you open `plans/FS112-N-proof.md`.*

**Fence addition:** `data/fs112/fs112-a2/` (the competition advisor's working directory, which holds its cards) is fenced like its record, until your stage 1
is committed. Every brief other than yours, this file, `N112-proof.md` and `STANDING-RULES.md` stays fenced.

## Order of work

1. **The chain walk first** (your brief's item 3): C-CHAIN-1 … C-CHAIN-18 (claim list §3), each given one verdict with unit arcs allowed — holds as written;
   holds off a named exception (name it); fails (give the configuration) — and the circles each step reads.
2. **The side's new statements**, verbatim (derive each, or refute it, or name the step that is missing):
   - **N112-U1:** "At a unit arc `α ⊂ ω(P)` of angular length `ℓ`: an inner side colour in `P_cl(P)` has all its sectors at `P` in the closed cone of
     angle `π − ℓ` facing `α`; an outer one, in the cone facing away; the outer tile's shadow near `P` is, to first order, the open cone of angle `π + ℓ`
     facing `α` (a wedge, not a circle side)"
   - **N112-SIX:** "A vertex with `|P_cl(v)| = 5` has unit arcs centred at `v` of total length `≥ 180°`; with `|P_cl(v)| = 6`, `ω(v) ⊆ Γ`"
   - **N112-NB4′:** NB-4's general form (`plans/FS110-derivation.md`; `plans/FS110-NB-verification.md` l. 164) as corrected: "the six orbit points need
     `{e, f} ⊆ P_cl(y_k)`, which fails only at an arc of `ω(v)` containing an orbit point in its closure; "passes through `y_k`" read as "has `y_k` in its
     closure"" — and the claim that the bound `|P_cl(y_k)| ≤ 4` is not needed.
   - **N112-END:** "In a stuck chain (N4-STUCK's structure at every `P_k`) the horn curvatures cannot reach the closed ends: `λ_{k+1} = −1` or `υ_{k−1} = 1`
     contradicts N112-U1 at `P_k`"
   - **N112-L60:** "A boundary arc of radius 1 with constant sides has angular length `< 60°` (its outer tile would have diameter `> 1`); along `ω(P)` neither
     side colour recurs `60°` apart"
   - **N112-LOCK:** "For `w` interior to a unit arc `α ⊂ ω(P)`, a tile of either side colour touches `ω(w)` only at `P` (inner colour: facing cone; outer:
     away cone) or, for the inner colour only, at `P + 2e_w` from outside `B(P, 2)`"
   - **N112-BEND:** "Off its end vertices, a unit arc can be bent off radius 1, keeping validity and creating no unit arc: toward `P` unless its outer colour
     is at `P`; away from `P` unless its inner colour is at `P` or lies along the radius-2 circle"
   - **N112-RED:** "Every valid map has a valid modification (merges, bends) in which every unit arc is (Q) centred at a vertex with `≥ 4` colours carrying
     both its side colours, or (R2) out-contact with the inner colour along the radius-2 circle"
3. **The claim-list ids the side gives verdicts on** (claim list §2 and §6; your verdict on each, derived): C-UA-WEDGE; C-UA-BUDGET (each branch
   separately, and whether they exclude each other); ARC-INERT; C-SEAMS-TWO; C-UA-CHAIN; C-V56 (its covering claim); C-LOCAL; C-BEYOND (the step it
   names); and A4-SIX-ARCS (FS-110's, one mind there).

**The priority, if you must stop early:** item 1, then N112-RED with the four lemmas it rests on (N112-U1, L60, LOCK, BEND), then the rest.
