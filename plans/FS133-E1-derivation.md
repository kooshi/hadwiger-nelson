# FS133-E1 — the one-class transfer: the opening's record and the derivation of its claims

*Ephodos, job FS133-E1 (brief: `data/fs133/briefs/FS133-E1-opening-and-derivation.md`). The plan, with §G, §PA and §IQ, is
`plans/FS133-one-class-transfer.md`; the claim list is `data/fs133/claims.md`. The outside release is `[OAIMath2026]` family 158 at
commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a` of `/home/kooshi/source/math` (read, never written); **M** is its
`preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/build/sections/`. Checks: `tools/fs133_e1_*.py`; their
outputs and the search files: `data/fs133/e1/`, `data/fs133/pa/`.*

*Notation, fixed once.* `F = ℚ̄ ∩ ℝ`, `E = F(i)` the algebraic plane (Johnson's `𝒜²`), `K = {u ∈ E : |u| = 1}`, `D` the compact dual
of the discrete group `E`, `C ⊂ D` the continuous characters `z ↦ exp(iξ·z)` (M's Definition 2.1). `UD(X)`: the unit-distance graph
on `X ⊆ ℝ²`. `σ`: normalised arc length on `S¹`. For a finite `G ⊂ ℝ²`, `α(G)` is the independence number of `UD(G)` and
`α₁(G) = α(G)/|G|`; `α₁(X) = inf{α₁(G) : G ⊆ X finite}` for `X = ℝ²` or `E` (`[MatolcsiEtAl2025]` p. 5 for `ℝ²`). A measurable
`A ⊆ ℝ²` is *1-avoiding* if no two of its points are at distance 1, and *edge-null* if `(Leb × σ){(x, u) : x ∈ A, x + u ∈ A} = 0`.
`m₁(ℝ²)`: "the supremum of the upper densities of measurable sets A ⊆ R2 containing no two points at distance 1"
(`[DuczVarga2026]` § 2.1). A *window sequence* is a sequence `(X_n)` of bounded measurable subsets of `ℝ²` of positive measure; the
*upper density of `A` along it* is `limsup_n |A ∩ X_n|/|X_n|`. `χ_f(ℝ²)`, `χ_f,0(ℝ²)`: `[MatolcsiEtAl2025]` p. 4, quoted in the
plan's § PA.3.

## Theorems this phase proved

(Filled stage by stage; each line: the entry, its verdict, its grade, its address.)

- Stage 1 proved none (a readback and an opening).

## Stage 1 — SAVED: the readback, the definitions at their pages, and the opening

**1.1 The readback.** `tools/fs133_e1_readback.py` reads every quotation of a file (a run of `> ` lines closed by
`> — source: <path>`) and looks for each quoted line verbatim in its source.
- The brief: **7 quotations, 7 lines matched, 0 mismatched**, exit 0 (`data/fs133/e1/readback-brief.out`).
- The claim list: **4 quotations, 4 matched**, exit 0 (`data/fs133/e1/readback-claims.out`).
- Planted fault (`--fault` changes the last character of each quoted line): 0 matched, 7 mismatched, exit 1
  (`data/fs133/e1/readback-brief-fault.out`) — the check fires.
- No mismatch, so no finding about the brief's quotations. Two notes on what the quoted sources say, neither a mismatch:
  (a) the stub cites FS103-B-AMEN's Følner half as "two blind minds … `plans/FS103-derivation.md` l. 86", and that line grades the
  entry "[hand, one mind (B)]"; row 129 is the source of "two blind: F, B; FS105-W-D1". C133-INV below re-derives the half at `E`
  and rests on neither count. (b) C133-DENS is posed with "`= α` for every `x`"; the field the transfer produces has that mean
  only at almost every `x` (M/transfer.tex:221–224, "correct as an `L²(μ)` representative for almost every `x`"). The derivation
  below is stated at the weaker hypothesis, which is the one the use needs — a statement note for the claim list, reported.

**1.2 What was read before any derivation.** The brief; `plans/STANDING-RULES.md`; `data/fs133/claims.md`;
`plans/STUB-one-class-transfer.md` whole; `plans/EXT-OAI2-reading.md` ll. 1–400 (stages 1–2, § 2.6 whole); `M/transfer.tex` whole
(316 lines) and `M/spectral.tex` ll. 1–100; `plans/EXT-OAI1-audit.md` stage 6 and stage 8; `LEDGER.md` row 129; `plans/FS103-derivation.md`
whole; `plans/FS103-B-verification.md` §§ 2–3; `plans/FS103-F-fractional-shadow.md` § 3; `CLOSED-QUESTIONS.md` ll. 654–667; the
grokkings (preloaded). The four printed sources at their pages (the plan's § PA.3): `[MatolcsiEtAl2025]` pp. 4–5,
`[DuczVarga2026]` pp. 1–4, `[Johnson1996fcn]` pp. 102–107, `[Johnson2000surprises]` pp. 142–143.

**1.3 Three definitions of upper density are in use, and the claims must not depend on which.** `[DuczVarga2026]` and
`[AmbrusEtAl2023]` say "upper density" without a window; `[MatolcsiEtAl2025]` defines `m₁(ℝ²) = inf_X m₁(X)` over sets of finite
positive measure; DeCorte–de Oliveira Filho–Vallentin (arXiv:1804.09099 § 6) use `sup_p limsup_T` over cubes `p + [−T, T]ⁿ`. So
C133-DENS is derived for every window sequence, and the periodisation lemma (stage 5) shows the three suprema are one number.

**1.4 The opening.** §G (twelve entries bear, the rest listed silent), §PA (fifteen arXiv queries, two web searches, four printed
questions read at their pages; zbMATH down, owed at the second pass; **nothing found stating the claim, no listing after
2026-09-28**) and §IQ are in `plans/FS133-one-class-transfer.md`, with the routes, five registered predictions and the stage table.

**1.5 The gate at this stage.** `derive_gate.py all` on this record exits 1 with its one failure "no derivation entry", as it must
before stage 3 writes the first entry; from stage 3 on it is run before every commit.
