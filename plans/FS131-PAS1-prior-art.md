# FS131-PAS1 — the prior-art searches owed by five statements

*Job FS131-PAS1 (brief `data/fs131/briefs/FS131-PAS1-prior-art.md`, on `main` at `f3040dc02`), Ephodos, 2026-10-16. Worktree
`.claude/worktrees/filing2`, branch `fs131-pas1`. A prior-art gate (`.claude/agents/ephodos.md` § The opening job, §PA) run on five
statements already derived or proved; no derivation of its own. Query scripts and logs: `data/fs131/pas1/`.*

## Theorems this phase proved

None. This job searches and reads; it proves nothing.

## Stage 1 — SAVED: the readback

### 1.1 The quotations

`data/fs131/pas1/quote_check.py` reads every block quotation of the brief and checks it, character for character, against the
source file it names. Run against `main` (the brief was committed there after this worktree was cut at `fe00e94d1`):

```
OK   data/fs131/REQUEST-2026-10-13.md 'W2: (2026-10-13, answering the choice between the two publishable form'
OK   plans/FS131-close-inventory.md '1043. **FS131-ICT3 handed back DONE; the three-colour criterion lands '
OK   plans/FS131-close-inventory.md '1021. **FS131-KFR1 reviewed, and its three held items ruled (logged 20'
OK   plans/FS131-close-inventory.md '1027. **FS131-KCS1 handed back DONE: part A planned with a skeleton, p'
OK   plans/FS131-close-inventory.md '1044. **FS131-KRU1 handed back DONE: the ring of unit vectors planned '
mismatches: 0
```

Control: with one word of the W2 quotation changed ("second form" → "first form") the checker prints `MISS` for that quotation and
exits 1. All five quotations are verbatim.

The five statements themselves are the brief's own summaries, not quotations; each was read against its source:
1. against `LEDGER.md` row 79 (the kernel sentence) and `plans/FS131-KTC1-three-colour-plan.md` § 3.6 — agrees;
2. against `LEDGER.md` row 129, `plans/FS103-derivation.md` FS103-F-FRAC and FS103-F-TF, and inventory item 1021 — agrees, with
   one note: the derivation file's F-FRAC is "given MR(F)"; the brief's "at every real number field" is the kernel planner's
   finding (item 1021: every use of MR is discharged by `Rigidity.mrPlus`), so the search is for the statement with no hypothesis;
3. against `LEDGER.md` row 123 (CLS) and `plans/FS100-derivation.md` FS100-CLS — agrees; FS100-CLS's own prior-art line reads
   "the general statement not found (X24R did not search it by name: a debt for the next gate)";
4. against `LEDGER.md` row 100 and `plans/FS91-derivation.md` FS91-J07-4 — agrees; the derivation's gate (FS91 § 1, item (4))
   had "partly in print (`[Fischer1990b]`'s quadratic and multiquadratic cases); the general form not found; Shimura 1964 undecided";
5. against `plans/FS131-KRU1-ring-plan.md` § 2.4, route E (branch `fs131-kru1`) — agrees.

### 1.2 The five statements in the field's own words, and the query terms each suggests

**S1 — three-colourings of abelian Cayley graphs.** *Graph colouring:* a Cayley graph `Cay(A, S)` of an abelian group is
3-colourable iff it has a *circular* 3-colouring of the special form `x ↦ ⌊3θ(x)⌋` for a homomorphism `θ : A → ℝ/ℤ` (a
character) with `θ(S) ⊆ [1/3, 2/3]` — i.e. `χ ≤ 3` iff the *regular chromatic number* (Barajas–Serra; `κ`, the lonely-runner /
view-obstruction parameter) is at most 3. For `A = ℤ` this is "a distance graph `G(ℤ, D)` is 3-colourable iff `κ(D) ≥ 1/3`"; for
`A = (ℤ/2)ⁿ` it gives Payan's theorem (no cube-like graph has `χ = 3`: the characters take only the values 0, 1/2) and the same
for every abelian group of exponent 4. For finite cyclic `A` it says 3-colourability of a circulant is decided by its `n`
characters. *Symbolic dynamics:* the proper 3-colourings form the hom-shift `Hom(Cay(A, S), K₃)`; periodic points are dense and
every point has a height (the universal cover of `K₃` is a line) with a slope. Query terms: "Cayley graph" with "abelian" and
"3-colorable" / "three-colorable" / "3-chromatic"; "circulant" with "3-colorable"; "cube-like" with "chromatic number 3"; "distance
graph" with "chromatic number 3"; "circular chromatic number" with "Cayley graph"; "regular chromatic number"; "hom-shift" /
"homshift" with "periodic" and "dense"; "3-colorings" with "height function" and "Z^d".

**S2 — a finite triangle-free unit-distance graph needing six colours; fractional forms.** *Geometric graph theory:* given
`χ(ℝ²) ≥ 6`, some finite unit-distance graph of girth at least 4 has chromatic number 6; and the fractional chromatic number of
the unit-distance graph on `F²`, `F` a real number field, is `1/α_loc(F)` — the reciprocal of the larger of the plane's
measurable density `m₁(ℝ²)` and the independence ratios of its finite residue targets — equal to `χ_f(ℝ²)` where every target
reads below `m₁(ℝ²)`. Query terms: "unit distance graph" with "triangle-free" and "chromatic number"; "girth" with "unit distance"
and "chromatic"; "fractional chromatic number" with "rational points" / "number field" / "Q^2" / "algebraic"; the 2026 literature
on `χ(ℝ²) ≥ 6` and on six-chromatic unit-distance graphs.

**S3 — CLS.** *Geometric graph theory over fields:* for a real number field `F`, the reductions of the plane `F²` modulo the
primes of `F(i)` fixed by complex conjugation give a 4-colouring exactly at the primes with residue field `𝔽₃` or `𝔽₇`, the
dyadic primes inert in `F(i)/F` of norm at most 32, and the dyadic primes ramified in `F(i)/F`. *Its finite parts in their
own literature:* the chromatic number of the unit-distance graph of the finite Euclidean plane `𝔽_q²` (`x² + y² = 1`), `q ≡ 3
(mod 4)`, is at most 4 only at `q = 3, 7`; and the Cayley graph of `𝔽_{Q²}` on the `(Q+1)`-st roots of unity (the "unit circle"
of `𝔽_{Q²}/𝔽_Q`, a cyclotomic / generalized Paley graph), `Q` a power of 2, is 4-colourable exactly when `Q ≤ 32`. Query terms:
"finite Euclidean graph" / "finite Euclidean plane" with "chromatic"; "unit distance graph" with "finite field"; "chromatic number
of the plane" with "number field" / "algebraic" / "rational"; the author listings of Moorhouse, Fischer, Johnson, Krebs; "unit
circle" with "finite field" and "Cayley graph".

**S4 — Lemma C′.** *Algebraic number theory:* for a quadratic extension `L = F(i)` of a real number field `F`, with `σ` complex
conjugation, the subring of `L` generated (additively, the set being a multiplicative group) by the group `T(F) = {u : uσ(u) = 1}`
of norm-one elements — the rational points of the norm-one torus `R¹_{L/F} 𝔾_m`, the group of Pythagorean triples over `F` —
is the ring of elements integral at every prime of `L` that is inert or ramified over `F`, provided no dyadic prime of `F`
ramifies in `L`. In geometric graph theory: the additive group generated by the unit vectors of `F²` (`[Johnson2000]` §5's
question). Query terms: "norm one" / "norm 1" with "additive" / "generated" / "ring"; "Pythagorean triples" with "number field";
"unit vectors" with "additive group"; "sums of elements of norm one"; Shimura's "Arithmetic of unitary groups"; the author
listings of Zanardo, Zannier, Fischer.

**S5 — degree-one primes of norm `≡ 3 (mod 4)`.** *Elementary / algebraic number theory:* every irreducible `f ∈ ℤ[x]` with a
real root has infinitely many prime divisors `q ≡ 3 (mod 4)` (primes `q` with `f(t) ≡ 0 (mod q)` solvable), equivalently every
real number field has infinitely many primes of degree one over `q ≡ 3 (mod 4)`; proved by a Euclid-style sign-change argument
(Schur's method with a sign condition), where the standard proof is Chebotarev with Frobenius conjugate to complex conjugation.
Query terms: "prime divisors" with "polynomial" and "arithmetic progression"; "real root" with "prime divisors"; "Schur's
theorem" with "prime divisors"; "Euclidean proof" with "Dirichlet"; "degree one primes" with "real field".
