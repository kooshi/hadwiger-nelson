# Job LX — report to the owner

*Job LX of the consolidation and library run, 2026-09-27 (de Bruijn, Opus 5.5). Record: `data/consolidation-2026-09-27/lx/record.md`
(stage 1 commit 42493bbd, blind; stage 2 commits 7906f997 and c0aca08d). Neither stage moves the answer to Hadwiger–Nelson. Stage 1 settles
a four-colour question about the rational points of four-dimensional space. Stage 2 changes what the project calls its own.*

## Verdicts

| item | verdict | in one line |
|---|---|---|
| **Stage 1, clause 1:** in every proper four-colouring of the unit-distance graph on `ℚ⁴`, two points get one colour ⟺ `v₂(\|x − y\|²) ≥ 1` | **TRUE** [hand] | Five points force a pair at squared distance 2. Those pairs generate the ideal `P = {v₂ ≥ 1}` of the 2-integral quaternions. The residue colouring rules out anything larger. |
| **clause 2:** forced to different colours ⟺ `= 0` | **TRUE** [hand] | The quotient of the component by `P` has four classes, and a unit tetrahedron meets all four. |
| **clause 3:** free ⟺ `< 0` | **TRUE** [hand] | The pair lies in different components (the component of the origin is Benda–Perles's `H⁴`). |
| **the corollary:** a four-colouring forbidding 1 and `d` exists ⟺ `d² = p/q`, `p, q` odd | **TRUE for every `d` realized in `ℚ⁴` (⟺ `d² ∈ ℚ`); false as worded when `d² ∉ ℚ`** | No pair is at an unrealized distance, so such a colouring exists vacuously. `[Johnson2006]` p. 212's question — *"For which d > 0 does there exist a 4-coloring of ℚ⁴ which forbids both distances 1 and d?"* — is answered once that scope line is added. Its "if" half is `[Johnson1990]` Theorem 3. |
| **Stage 2:** does `[Johnson1982]` hold Theorem A's metric-free form? | **IN PART** | It has the metric-free setting and the coset construction (1982, before `[Fischer1990]`), but only a cyclic target `ℤ/n` with the homomorphism equal to 1 on the differences. That is Theorem A's two-colour case in full, plus a converse. For `n ≥ 3` its colourings map onto an `n`-cycle, so it never colours a graph of chromatic number ≥ 4. |

Stage 1's law is now held by two minds, the second blind: LV's LV-T3, then LX-T1–T6. In plain words it says: every proper four-colouring of
`ℚ⁴`, read as the rational quaternions, is, on each connected piece, the reduction modulo the prime above 2 (four residue classes), with the four
classes given four different colours.

## What `[Johnson1982]` proves (*Coloring abelian groups*, Discrete Math. 40 (1982) 219–223; read in full from the page images)

- **Theorem** (p. 220): *"Suppose S ⊆ G, and n > 1. If S is weakly n-free, then there is an S-alternating n-coloring of G. If n = 2, or if S is
  a singleton, the converse holds; the existence of an S-alternating n-coloring implies that S is weakly n-free."* Weakly `n`-free (p. 219):
  *"Σ_{h∈S} m_h h = 0 implies Σ_{h∈S} m_h ≡ 0 (mod n)"*. The proof colours the subgroup `S` generates by the coefficient sum mod `n` and
  *"Extend the coloring to all of G by coloring the co-sets of H similarly."*
- pp. 219–220: every proper two-colouring is the parity map on each coset. `[Johnson2006]` p. 213 cites the paper for exactly this.
- Corollary 2 (p. 220): the two-colourings of the line forbidding 1 and `s`. Its excluded set is, on the rationals, exactly `v₂(s) ≠ 0`: the
  one-dimensional prototype of the `v₂ = 0` answers, stage 1's included.
- Corollary 3 (p. 221): *"The chromatic number of Q² and Q³ is 2, and of Q⁴ is greater than 2."*
- Remark (ii) (p. 222) asks whether a certain set exists that would four-colour the plane. The answer is **no**, since `χ(ℝ²) ≥ 5`
  (`[deGrey2018]`, rung B here). This is closed by others, not by us.

## Decisions for you (2, both "decide when convenient")

| # | decision | recommendation | default if you do nothing |
|---|---|---|---|
| 1 | Stop calling Theorem A's **statement** ours, keeping the **kernel proof** (drafts D1–D4 in the record: `LEDGER.md` row 57 and the claim list, `CLOSED-QUESTIONS.md` §1.2, `CLAUDE.md` § The prior-art position) | **Yes.** The alternative is keeping "not found in print" for the statement with an arbitrary target and no metric. That is literally true, but the statement is the one-line merge of `[Johnson1982]`'s setting with `[Fischer1990]`'s arbitrary target; nothing in it needs an idea. Confidence **high**. | The front files keep saying `[Johnson1982]` is unread and that the metric-free statement is ours. Both are now wrong. |
| 2 | The one item of D5 not yet applied (the owner's commit 2965c09a already applied the scope line, the regrade and `[Johnson1990]` Thm 3): in `CLOSED-QUESTIONS.md` §3's ℚ⁴ entry, cite Benda–Perles pp. 124–125 (their description of `H⁴`) for "`O₂` is the component of the origin", in place of `[H⁴ : D] = 2` | **Yes.** The alternative is leaving it. But `[H⁴ : D] = 2` is about their odd-denominator subgroup `D`, and it does not show that the component is `O₂`. Confidence **high**. | The entry cites an index where a characterization is meant. A careful reader finds the step unsupported by the page cited. |

## Already settled (skip)

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| Proved stage 1 by a valuation on the rational quaternions and a five-point gadget | Following Zaks's reflection proof, then his Lemma 2 and Theorem 3 case by case | The valuation gives all three clauses at once. Zaks's lemmas are its cases `N = 2, 4, (2k+1)²` | high |
| Graded the corollary TRUE only for realized `d` | Grading it TRUE as the intended reading | Rule 5 of the run: verdicts are on the words. Johnson's own neighbouring theorem carries "actually realized" | high |
| Edited only the `[Johnson1982]`, `[ErdosEtAl1973]` and `[Woodall1973]` rows, plus one library row | Also recording the reading status of `[BendaPerles2000]` and Zaks 1999 | The brief names these rows only. The rest is drafted (D7) | high |
| Checked the arithmetic by exact scripts, each with a planted fault | No scripts, hand only | A few seconds of exact checking. It caught my own first planted fault, which was not a fault (a third valid apex) | high |

## Know, don't decide

- **One slip, reported in the record:** my first render wrote into the session's shared scratchpad, and the `ls` that followed showed me
  other agents' file names. I opened none of them.
- **Zaks 1999 has three misprints:** p. 91 "φ(B) = 4" for φ(D); p. 92 "φ(W)" for φ(W₄); p. 92 D = (0,1,0,0) for (1,1,0,0). The last is already
  in `[Johnson2006]` p. 212. They belong in the Zaks bibliography rows, which I did not open (D7).
- **A confirming instance for G54's reading** (a full-rank forced group where the only prime's target is Hoffman-tight): `ℚ⁴` at four
  colours, target `K₄`, forced group `P` (D7).
- **No search after 2006** for the ℚ⁴ law's "only if" half was run in this job.
