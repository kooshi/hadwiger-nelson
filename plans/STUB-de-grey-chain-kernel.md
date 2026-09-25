# FS-87 — de Grey's lattice in the kernel: the stripe lemma, Parts's trees, and `F = P = 8Λ` as a conditional theorem (stub)

*Minted 2026-09-24 at FS-85's close, from the kernel decisions filed in `plans/FS85-derivation.md` (FS85-V2-T5 "a good small kernel
target", dB2, dB9's V1, dB10, dB11, V7, IA1, R3b) and verifier 2's recommendation (`plans/FS85-V2-verification.md` §C4). Rank 8.
Written for a session with zero conversation memory.*

## What this is

`LEDGER.md` row 85 proves by hand and exact computation that every proper four-colouring of de Grey's lattice `Cay(Λ, U)`
(`Λ = (1/9)·O_E`, `E = ℚ(√−3, √−11)`, 54 unit vectors) is `8Λ`-periodic, local at one prime above 2, pair-linear and striped, 9,120 in
all — given (S″), Parts's no-monochromatic-√3-triple theorem placed in `Λ`, whose nine trees were walked here as a fixed certificate.
**None of it is kernel-checked** (FS-85 added no Lean). Row 78 holds the same `F = 8Λ` by a 2,044-point certificate that Kooshi declined to
formalize ("an algebraic explanation … rather than formalizing a big graph", FS73-T6). This stub is the kernel form of the explanation.

## Targets, cheapest first (price each from its first two leaves, § What compute actually helps)

1. **V2-T5, the stripe lemma** — under NT₀ every proper four-colouring of the triangular lattice is striped (type O/P wheels; propagation
   along a line, then line to line). A finite local lemma plus an induction on lines; the first leaf.
2. **dB9's V1** — adjacent striped `T₀`-cosets share a direction unless one is residue-type: a small finite statement about stripe data.
3. **A kernel checker for Parts's nine trees on G481** — `data/fs85/audit/walk_trees.py` (IA1) is the specification: every cell's neighbours
   are ancestors at unit distance, of the stated colour, every branch refutes its two free colours; coordinates exact in `Λ`. Then IA2
   (Lemma G, the root case split, hand) and IA3 (each root reached under a named symmetry). With V8's placement this makes (S″) kernel.
   Cost model: literals, `Bool` checks through `List.all`, GMP `Nat` (§ The kernel's cost model).
4. **W, the theorem, as a conditional theorem with (S″) a named hypothesis** — C7 in its finite-quotient form (on a periodic colouring the
   distributional step is not needed), C8's character tables, R3a, C15, C9 and the count. Weeks; price after 1–3. Its inhabitant (§ The
   gate): the residue colouring satisfies NT in every family.
5. **dB2 as a small independent instance** — the triangle-free `G(ℤ, D)`, `|D| = 70`, with `F₄ = 4ℤ`: the B₃ condition, the mod-4
   colouring, and Mycielski's theorem (check Mathlib first) for the forced pair.
6. **The second route** (V7: dB10, dB11 with V6's repair) — only if a consumer wants `P = F` by stripe coupling as well.

## Bearing on χ ≥ 6

None. High on the standard of evidence: row 85 moves from a checker's and two readers' word to the kernel's, and a future write-up of
Mixon's 2018 question (`CLOSED-QUESTIONS.md` §2.5; FS-20) needs exactly this.

**Provisional bearings:** § The standard of evidence above rung B; § The kernel's cost model; G18 (certify components, compose in the
kernel); G21 and G30(5) (ship an inhabitant; a conditional theorem over an empty hypothesis is vacuous); G70 (the √3-clean class is the
residue colouring — the conditional theorem's inhabitant); rows 78, 85, 86.

**Solver:** none — the kernel and existing checkers; runs in the finite-witness-free week. **Cost:** targets 1–2 a day or two; 3 days;
4 weeks.
