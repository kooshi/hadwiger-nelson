*Instance file for job **FS112-NB2**, the round-2 blind verifier of FS-112's proof side. Its brief is `data/fs112/briefs/NB112-verify-proof.md`; this
file is part of it and overrides it where they differ. Filled in by the owner on 2026-09-27, when FS112-N2 handed back.*

## Overrides of the brief for this instance

- **Your job id** is FS112-NB2; **your record** `plans/FS112-NB2-verification.md`; **your working directory** `data/fs112/fs112-nb2/`; **your tools**
  `tools/fs112_nb2_*.py`; **your commit subjects** "FS112-NB2: stage n"; **your report** `data/fs112/reports/FS112-NB2.md`; **your scratch**
  `scratchpad/fs112-nb2/`.
- **The side verified:** round 2 of the proof side, FS112-N2, whose work is the section "§ Continuation — FS112-N2" of `plans/FS112-N-proof.md`. **That
  section, and N2's tools `tools/fs112_n2_*.py` and outputs `data/fs112/fs112-n/n2-*`, stay fenced until your stage 1 is committed.** The earlier sections of
  `plans/FS112-N-proof.md` (stages 1–2, round 1) are open to you, as is round 1's verifier record `plans/FS112-NB-verification.md` and its report
  `data/fs112/reports/FS112-NB.md` — they are what round 2 built on.
- **Also fenced:** `data/fs112/fs112-a2/`, `data/fs112/fs112-a3/` (the advisors' cards), with the rest of your brief's list.

## The statements to derive (verbatim from N2's "theorems this continuation proved" table; each is claimed, its grade withheld)

Derive each, refute it, or name the step that is missing. **Priority, if you must stop early: N2-RAY, then N2-DENSE, then N2-RED with N2-TOWARD, N2-AWAY
and N2-TAN, then the rest.**

- **N2-RAY:** "N4-FIN's application fails at a chain's end; a one-sided stuck chain (`λ_k = −1/(k+1)`, `υ_k = 0`) is consistent with N4-FIN; N4-CONE is a GAP
  under unit arcs"
- **N2-DENSE:** "in `M*`, every trichromatic cubic vertex has a unit-arc centre within 4 or a stuck vertex within 3; every disc of radius 5 contains one"
  (`M*` is the terminal modification of N2-TERM; the side rests it on row 134's base, on NB4′, and on N2-TERM)
- **N2-RED:** "N112-RED with its end-vertex and isolated-contact GAPs closed, and its termination (no stubs)"
- **N2-TOWARD:** "`s_out ∉ P_cl(P)` ⟹ the whole unit arc, end vertices included, bends toward `P` (no stub)"
- **N2-AWAY:** "`s_in ∉ P_cl(P)` and no `s_in` tile touching `R₂(α)` (ends included) ⟹ the whole arc bends away; the end vertex's only blocker is R2 at the end"
- **N2-TAN:** "isolated R2 contacts (and ends of R2 sub-arcs) are cleared by a tangent bend; only R2 along an arc blocks (NB-ISO closed)"
- **N2-TERM:** "the terminal map: arcs (Q)/(R2); vertices cubic, NB4′ exceptions, or stuck on chains ending near (Q)/(R2)/NB4′ or running to infinity (GAP)"
- **N2-FLANK-Q:** "a horn bound `±1` sits on a (Q) arc (FLANK's in-type exception, then two-sided) or an (R2) arc (FLANK's out-type tile along the radius-2 circle)"
- **N2-SIGN:** "every point `≠ P` of a side-colour tile is within `< 1` of all of `int α` or `> 1` from all of it (near / far tiles)"
- **N2-ENV:** "a lens point's disc leaves the union of unit discs about `ᾱ` only near `P` (toward lens) or near `R₂(α)` (away lens), within `r(ψ) → 0`"

The notation (`s_in`, `s_out`, `R₂(α)`, (Q), (R2), `λ_k`, `υ_k`, horns, stuck chains) is the claim list's and round 1's (`data/fs112/claims.md`;
`plans/FS112-N-proof.md` §§1.3, 2.2–2.3; `plans/FS110-N-proof.md` §N4-2 for the N4 frame). Where a statement's symbol is defined only in the fenced
section, say so and derive under the most natural reading, naming it.

**After stage 1 is committed:** read N2's section and tools, and list every divergence (truth, scope, grade) with both addresses — your brief's stage 2.
