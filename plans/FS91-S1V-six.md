# FS-91 S1V-six — blind verification of J08's claims (character colourings at the exposed fields), job J11

*Crunch job J11, 2026-09-25, Opus 5.5, acting as de Bruijn (a blind verifier). Brief:
`data/crunch-2026-09-25/briefs/J11-M1-six-blind-verifier.md` with `STANDING-RULES.md`. The verdicts are mine. Fenced until the phase-1
verdicts are committed: J08's record, data, tools and commits; the plan `plans/FS91-character-local-global.md` beyond the quoted blocks;
every other crunch record.*

## Stage 1 — SAVED (quotation check and C0)

### Q. Quotation check (standing rule 5)

Every quotation in the brief checked against `plans/FS91-character-local-global.md` (only the lines named below were opened).

| brief item | source | result |
|---|---|---|
| W1 = SIX-a, "For a prime `q ≡ 3 (mod 4)`, every band `k`-character … non-square or 0}`." | plan l. 458–460 | **verbatim** |
| W2 = SIX-b, "The complete list of `c ∈ 𝔽_q^×` … `χ_char(Γ₄₃)`" | plan l. 461–462 | text identical; the source does not put it in quotation marks (it is a task line, not a claim) |
| W3 = SIX-c, "For `k ∈ {6, 7}`: an explicit `Q_k` … the complete list below it." | plan l. 463–464 | text identical; unquoted in the source, as W2 |
| W4 = SIX-e, "Given CLG_6 and CLG_7 (J07, unverified): … de Grey's field `K(√5,√7)`." | plan l. 467–468 | **verbatim** |
| `κ(Γ_q) = max{β : some character λ has λ(μ_{q+1}) ⊆ [β, 1 − β]}` | plan l. 519 (§M.1): "`κ(G, S) = max{β : some character λ has λ(S) ⊆ B_β}` (compactness makes it a maximum); `χ_char = ⌈1/κ⌉`", with `B_β = [β, 1 − β]` (plan, `0 < β ≤ ½`) | a faithful **instantiation** at `S = μ_{q+1}`, not a quotation; the source also states `χ_char = ⌈1/κ⌉` |
| "band `k`-character … `λ(S) ⊆ [1/k, 1 − 1/k]`" (brief's first paragraph) | plan l. 434: "`λ(S) ⊆ B_k`" | faithful (B_k = [1/k, 1 − 1/k]) |
| "A band six-character of Γ₂₃ or Γ₄₃ would be the first exactly six-chromatic finite Euclidean plane (`CLAUDE.md` G56)" | `CLAUDE.md` § Where the problem stands item 11, G56; rows 69, 71, 75 (five refused at 23 and 43) | correct: a band six-character six-colours the plane, and five is refused at both |
| positive control: "some band eight-character should exist at 23 and 43, or explain why those colourings are not characters" | the brief's own expectation | logged as the brief's expectation, to be scored |

**What else was opened, and why (logged, not hidden).** W4's hypothesis "CLG_6 and CLG_7" is not quoted in the brief, and an implication
cannot be checked without its hypothesis. So I read the plan's §S definitions and the CLG_k statement, l. 431–441 (statements only, no
route), and l. 519–520 (the κ definition, whose next clause begins "CLG in its converged form: `κ(R_F, U_F) = max over stable places 𝔓
of κ(O_𝔓, S_𝔓)`, under `H_β` …" — read in passing). Verbatim, the hypothesis I use:

> **CLG_k.** "Let `k ≥ 3` satisfy `H_k`, and let `F` be a real number field. Then `Θ_k(R_F) ≠ ∅` if and only if some stable place `𝔓` of
> `F(i)` and some level `m ≥ 1` have a band `k`-character of `T_{𝔓,m}`. Hence `χ_char(F²) = min_{𝔓,m} χ_char(T_{𝔓,m})`, and a character
> `k`-colouring of `F²` exists only if some residue target of `F` is `k`-colourable." (plan l. 439–441)

> **`H_k`** "is the hypothesis `Θ_k(R_F) ⊆ T + A` for every real number field `F`" (plan l. 435); the owner's news: J01-7 verified, so
> `H_k` holds at every `k`, with `A(R_F) = Hom_ℚ(F(i), ℝ)` mod 1 (every archimedean embedding).

> "The **residue target at level `m`** is `T_{𝔓,m} = Cay(O_𝔓/𝔓^m, S_{𝔓,m})`, `S_{𝔓,m}` the image of the local norm-one group"; "a
> **stable place** is a prime `𝔓` of `L` with `c(𝔓) = 𝔓`" (plan l. 432–434).

Nothing of J08's record, data, tools or commits, nor §PA.1, §P or §P.basis, was opened.

### C0. Predictions (probabilities), written before any tool is written

*Honesty note:* W1's reduction is two lines and I derived it while reading the inputs, before writing this section, so P(W1) is not an
independent prediction. Everything below it was written before any computation.

| claim | P(TRUE as stated) | reasoning at this point |
|---|---|---|
| W1 (SIX-a) | 0.97 | trace form nondegenerate; `aμ_{q+1}` is the norm-`N(a)` circle; `Tr = t, N = c` solvable off `𝔽_q` iff `X² − tX + c` irreducible, in `𝔽_q` only at discriminant 0 |
| W2 (SIX-b): J08's lists match mine value by value | 0.80 | a finite exact list; errors would be in the reading of `(−q/2, q/2)` or of `c` |
| W3 (SIX-c): J08's `Q_k` valid and its list complete | 0.75 | my Weil threshold: a triangle minorant gives "band `k` ⟹ `q + 1 ≤ 2(k − 1)√q`", i.e. `q ≤ 97` (k = 6), `q ≤ 141` (k = 7) — the same line as the Hoffman ratio bound, since a band `k`-character has a colour class of `q⌈q/k⌉ ≥ q²/k` points |
| W4 (SIX-e): TRUE / GAP / FALSE | 0.55 / 0.40 / 0.05 | GAP risk: "`χ_char = min` over targets" needs CLG at the minimising `k` (or only its easy pullback half) and, for "targets" read at level 1, a level collapse; FALSE risk: a wrong target list |
| **a band six-character exists at 23 or at 43** | **0.04** | `data/fplane/periodic-below-71.json`: every band character has `c` a non-square (else `0 ∈ V_c`), and all non-square `c` give isomorphic circulants `Cay(ℤ/q, V_c)` (`V_{m²c} = mV_c`); the file's circulant has `0 ∉ D`, so it IS that class, and its (untrusted) solver reads `α = 3` at 23 and `α = 6` at 43, while band six needs the interval `{0,…,3}` (23) or `{0,…,7}` (43) independent there; and 23's local-search plateau is 87 < 92 = 23·⌈23/6⌉ |
| a band seven-character at 23 or 43 | 0.05 | the same file: band seven needs `{0,…,3}` (23) and `{0,…,6}` (43) independent |
| band eight at 23 / at 43 (the brief's positive control) | 0.88 / 0.50 | at 23 two square conditions on 11 non-squares; at 43 five on 21 |
| `χ_char(Γ₂₃) = 8`; `χ_char(Γ₄₃) ∈ {8, 9}` | 0.80; 0.70 | the circulant file's 8-colourings; none need be an interval colouring |
