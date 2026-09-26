# J28V — blind verification of row 88's claims T-A, T-B1, T-B2, T-C, T-C(A) (crunch job J28V, 2026-09-25)

*Blind verifier for the milestone "row 88's question" (`plans/FS86-row88-rigidity.md`), de Bruijn (Opus 5.5). Brief:
`data/crunch-2026-09-25/briefs/J28V-row88-verifier.md`, with `data/crunch-2026-09-25/briefs/STANDING-RULES.md`. Data: `data/fs86r88/j28v/`.
Blind until stage 2 is committed: nothing listed in the brief's "Fenced" section has been opened (the plan's §S.2, §M, §IQ; J28D's
derivation record, data, tools, brief and report; the crunch index; J28D commits). Read so far: the plan's header, §0, §S.0, §S.1, §P;
`LEDGER.md` rows 67, 75, 80, 88–97; `plans/FS86-derivation.md` Notation, §1, §5, §6, §9–§11; `plans/FS86-V-D-verification.md` in full.*

## Theorems this phase proved

*(filled at each stage; one line per theorem, grade, address)*

## Would-have-searched-here log

*(one line per move I would have made by search, and what I did instead)*

## Stage 1 — SAVED (quotation check; C0 predictions)

### 1.1 Quotation check (standing rule 5)

The brief's "fixed claim list" (its §S.0 definitions and §S.1 target statements, from "### S.0 Definitions" to the controls paragraph)
was extracted mechanically and diffed against `plans/FS86-row88-rigidity.md` lines 388–428. **Result: identical**, character for
character, except for one trailing blank line in the brief. No paraphrase, no dropped qualifier. The brief's other quotations: the
fenced list and the stage list are the brief's own words, nothing to check; §0 item 3's two quotations (CLG, J21-MX) are the plan's,
not the brief's, and are checked when used.

One note on the definitions, logged now so it is not mistaken later for a finding: §S.0's `F_μ(R)` quantifies over
translation-invariant measures only (§M.1's remark is quoted inside §S.0, so the definition is fixed as stated); T-A (ii)–(iv) are
verified against exactly this definition.

### 1.2 C0 — predictions (written before any derivation; first ideas recorded so they can be scored)

| claim | TRUE | GAP | FALSE | the first idea behind it |
|---|---|---|---|---|
| T-A (i)–(vi) | 0.88 | 0.08 | 0.04 | (i)–(iv) are bookkeeping on the frame (V2's ideal argument run on measures; a periodic colouring's finite orbit is an invariant measure); (v) is the Furstenberg correspondence for clopen sets on a countable amenable group; (vi) is "an isolated point in an orbit closure is hit by the orbit". Risk: a quantifier in (v), or (ii) needing more than the frame |
| T-C | 0.35 | 0.55 | 0.10 | VD-C's two-point spectral route cannot work over a real field: FS86-dB-C0 gives a positive-definite function with value −1/3 on every unit vector and archimedean spectrum. A route: spectral support on `T + A + Fin_S` makes the unitary representation extend to the `S`-completion `G_S` (all stable places, the archimedean ones, `S`), so the colouring becomes a stationary measurable window colouring of `Cay(G_S, T_S)`, and then C14/C14′'s product counting — with infinitely many stable places, the tail handled by Hoffman. Risk: C14′ is one mind, and C14 is stated for finitely many places |
| T-C(A) | 0.35 | 0.55 | 0.10 | the same reduction; then CL1's count (every factor `< 1/4`) leaves no measure at all. Risk: dyadic split places in `S` (C14.2 (c) at `p = 2`) |
| T-B1 | 0.10 | 0.75 | 0.15 | isolation of a pullback from a finite patch is a finite-forcing statement conditional on a pattern; nothing on the record gives it short of row 88 itself (if `F(R) ≠ 0`, `X₄ = Pull` is finite and T-B1 is free; if FALSE, row 88 is answered no) |
| T-B2 | 0.20 | 0.65 | 0.15 | a defect at `z` against a gap-free pullback forces defects on an infinite subset of the circle `z + U`, but a circle has upper Banach density 0 in `R`; Q-tr would imply T-B2, not conversely |

Registered consequence: if T-B1 comes out TRUE by derivation, I would be surprised (0.10) and would audit it first (G21).
