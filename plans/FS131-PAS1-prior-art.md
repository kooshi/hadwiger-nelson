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

## Stage 2 — SAVED: S1, the three-colour criterion past row 79's class

### 2.1 The queries (zbMATH Open API and arXiv API, 2026-10-16; every hit logged in `data/fs131/pas1/queries.jsonl`, tag `S1`)

| discipline | queries (hits) |
|---|---|
| graph colouring | zb `ab:"cube-like" & ab:"chromatic"` (4); `ab:"Cayley graph" & ab:"abelian" & ab:"3-colorable"` (4); `… & ab:"chromatic number 3"` (3); `… & ab:"3-chromatic"` (0); `… & ab:"three colors"` (0); `… & ab:"circular chromatic"` (0); `ab:"circulant" & ab:"3-colorable"` (4); `ab:"circulant" & ab:"chromatic number 3"` (0); `ab:"exponent 4" & ab:"chromatic number"` (0); `ab:"regular chromatic number"` (4); `ab:"distance graph" & ab:"3-colorable"` (0); `… & ab:"three colors"` (0); `ab:"distance graph" & ab:"chromatic number" & ab:"kappa"` (1); `ab:"circular coloring" & ab:"Cayley graph"` (0); `ab:"circular chromatic number" & ab:"abelian"` (1); `ab:"3-colorings" & ab:"Cayley graph"` (1); `ab:"homomorphisms" & ab:"Cayley graph" & ab:"abelian group" & ab:"cycle"` (0); `ab:"circulant" & ab:"NP-complete" & ab:"color"` (0); `ab:"circulant graph" & ab:"3-coloring"` (0); ax `abs:"Cayley graph" AND abs:abelian AND abs:"3-coloring"` (5); `abs:"three-colorings" AND abs:"Cayley"` (1); `ti:"3-chromatic Cayley graphs"` (1) |
| symbolic dynamics | zb `ab:"hom-shift"` (1); `ab:"homshift"` (1); `ab:"hom shifts" & ab:"periodic"` (0); `ab:"periodic points" & ab:"dense" & ab:"coloring"` (0); `ab:"periodic points" & ab:"dense" & ab:"graph homomorphisms"` (0); `ab:"periodic configurations" & ab:"dense" & ab:"coloring"` (0); `ab:"3-colorings" & ab:"periodic"` (2, unrelated); ax `abs:"hom-shift" AND abs:periodic` (0); `abs:"3-colorings" AND abs:"height function"` (4: the Peled school's random-height papers, standard generators); `abs:"periodic points are dense" AND abs:homomorphism` (0) |
| topological combinatorics (found through the colouring hits) | the discrete-fundamental-group papers below, reached by citation |
| author listings | zb `au:"Krebs, Mike"` (29); ax `au:Krebs_M` (16, all physics: a namesake); zb `au:"Chandgotia, Nishant"` (19) |
| citation graph | Semantic Scholar, works citing `[KrebsSankar2024]` (2), `[CervantesKrebs2023]`'s matrix paper (17), Cervantes–Krebs's Payan note (1) — the list is `data/fs131/pas1/s2-citations.jsonl` |

FS-79's gate (`plans/FS79-invariant-question.md` §PA.2) searched row 79's own class on 2026-09-23 in the same five disciplines;
these queries add the words of the widening (torsion, every abelian group, exponent, cube-like, circulant) and the year since.

### 2.2 What was read

- **`[KrebsSankar2024]`** — M. Krebs, M. Sankar, *Abelian groups without 3-chromatic Cayley graphs*, arXiv:2410.11028v2, now J.
  Combin. Theory Ser. B 179 (2026) 205–218 (held: `library/pdf/arXiv-2410.11028-…pdf`). **Read in full** (§§ 1–5, references).
  Theorem 1.2: "Let G be an abelian group. There exists a symmetric subset S of G such that χ(Cay(G, S)) = 3 if and only if
  exp(G) ∉ {1, 2, 4}." Theorem 4.1: "Let X be a connected non-bipartite graph. If π₁(X) is torsion, then χ(X) ≥ 4", with π₁ the
  discrete (four-cycle) fundamental group; Remark 3.7: a proper 3-colouring's winding `wind(−, c)` is a group homomorphism
  `π₁(X) → ℤ`; Theorem 3.3 presents `π₁` of an abelian Cayley graph as `R[S]/H[S]` (relations modulo the trivial ones). § 5.1:
  the infinite case uses the axiom of choice. § 5.2 Question 5.2: is such a classification possible for `k > 3`? **No character,
  no circle group, no criterion for a given `S`**: the paper classifies groups, not graphs.
- **`[EnamiMatsushita2026]`** — K. Enami, T. Matsushita, *Cayley graphs of abelian groups, circular colorings and discrete
  fundamental groups*, arXiv:2610.21940v1, 15 October 2026 (fetched: `library/pdf/arXiv-2610.21940-enami-matsushita-…pdf`). **Read:
  §§ 1–2, § 4's Theorem 4.2 with its proof, the references; § 3's constructions and § 4.1's presentation skimmed.** Theorem 1.3:
  "Let k ≥ 2 be an integer. For an abelian group Γ, the following are equivalent: (1) exp(Γ) ∈ {1, · · · , k} ∪ {2, 4, · · · , 2k}.
  (2) There is no symmetric subset S of Γ such that 2 < χc(Cay(Γ, S)) < 2 + 2/(k−1)." Method: Matsushita's `k`-fundamental group
  and a torsion obstruction to circular colourings (their Theorem 2.6, from their JCTB 180 (2026) paper). Again a classification of
  groups; no character criterion for a given `S`.
- **`[Davidson2026]`** — J. Davidson, *Coloring monomial Cayley graphs: the one-parameter case*, arXiv:2610.09474v1, 7 October 2026
  (fetched: `library/pdf/arXiv-2610.09474-davidson-…pdf`). **Read: abstract, § 1, § 2.1–2.2 (Lemmas 2.2–2.4); the rest scanned
  by search.** Uses characters `ψ : ℤ[α] → ℝ/ℤ` with `‖ψ(s)‖ ≥ δ` on every step to colour (Lemma 2.2, "Character separation":
  the ⟸ direction), for the graph on `ℤ[α]` with steps `±αⁿ`; no converse. Its abstract conjectures "that three colors suffice for
  every algebraic noninteger direction parameter and that four suffice for every direction parameter" — a statement the criterion
  turns into a question about one character (INVENTORY: a question for the asking lane).
- **`[Payan1992]`** — zbMATH review (Liu Yanpei) read: "no cube-like graph has chromatic number 3"; the paper itself unread.
- Abstracts only (arXiv): `[CervantesKrebs2023]`'s Payan note (arXiv:2303.06267, a Heuberger-matrix proof of Payan), *Cases of
  small dimension and rank* (arXiv:2303.06272), Ahmed et al. (arXiv:2607.23841), García-Marco–Knauer–Menara (arXiv:2607.26942,
  circular chromatic number ≤ 4 for semiminimal abelian Cayley graphs), Krebs–Pan–Prakash (arXiv:2512.05302), Bašić
  (arXiv:2609.03184), Tung (arXiv:2606.23762), Godsil–Rooney (arXiv:1502.00965). None states a criterion for a given `S`.

### 2.3 Verdict: **not found in print**; two of its corollaries are in print

The criterion (every abelian `A`, every `S ∌ 0`: 3-colourable ⟺ a character puts every step in `[1/3, 2/3]`), its periodic form
with torsion, and density for finite generating `S` with torsion or asymmetric `S`: **not found**. What is in print, and how it
relates:
1. **`[Payan1992]`** (no cube-like graph is 3-chromatic) and **`[KrebsSankar2024]` Theorem 1.2's "if" half** (no abelian group of
   exponent 1, 2 or 4 has a 3-chromatic Cayley graph) are **special cases, as corollaries**: a character of a group whose exponent
   divides 4 takes values in `¼ℤ/ℤ`, whose only point in `[1/3, 2/3]` is `1/2`, so a band character makes `x ↦ ⌊3θ(x)⌋` a
   2-colouring; hence such a Cayley graph is 3-colourable only if bipartite. (A one-line derivation from the criterion, [hand],
   one mind; it uses the criterion's ⟹ only.) Their "only if" half (constructions) is not a consequence and needs none.
2. **The mechanism's first half is in print**: Krebs–Sankar's winding homomorphism (Remark 3.7; Theorem 4.1) is the height a
   3-colouring carries through `K₃`'s universal cover, read on closed walks. What the criterion adds is the passage from that
   winding on the relation lattice to a character of `A` with every step in the band — the step neither paper takes, and the
   reason they classify groups while the criterion classifies graphs.
3. **`[EnamiMatsushita2026]`** (three days before this search) extends the group classification to circular chromatic number.
   It neither implies nor is implied by the criterion: at `k = 2` it says a non-bipartite Cayley graph on a group of exponent 1, 2
   or 4 has `χ_c ≥ 4`, which is stronger than `χ ≠ 3` there; the criterion says nothing about `χ_c` above 3.
4. The ⟸ (a band character colours) is classical — circular colourings from characters (`[BarajasSerra2008]`'s regular chromatic
   number for circulants; Davidson's Lemma 2.2 in 2026) — as FS131-KTC1's plan § 3.6 already said.

A consistency check, recorded because it could have refuted: for finite `A` the criterion decides 3-colourability by `|A|`
characters, so 3-colourability of a finite abelian Cayley graph given by its group table is polynomial-time; the hardness results
in print (Codenotti–Gerace–Vigna 1998 for circulants; Godsil–Rooney 2017 for `Gⁿ`) are for the chromatic number, or take the group
in a compressed form (abstract of Godsil–Rooney read; Codenotti et al. recalled from Godsil–Rooney's abstract, not read). No
conflict found.

**Not read:** Payan's paper itself; Cervantes–Krebs's matrix paper beyond `BIBLIOGRAPHY.md`'s existing reading; Enami–Matsushita's
earlier JCTB 180 paper (their [9]); the hom-shift literature beyond FS-79's reading and these queries.

### 2.4 Drafts (Keryx files; each names its slot)

1. **`LEDGER.md` row 79**, replacing *"Prior art for the widening past this row's class: not yet searched (FS131-KTC1's plan § 3.6)."*
   by: *"Prior art for the widening past this row's class: not found in print (FS131-PAS1, 2026-10-16: 45 queries in graph-colouring
   and symbolic-dynamics words, the citation lists of `[KrebsSankar2024]` and `[CervantesKrebs2023]`); two of its corollaries are in
   print — `[Payan1992]` (no cube-like graph is 3-chromatic) and `[KrebsSankar2024]` Thm 1.2's nontrivial half (no abelian group of
   exponent 1, 2 or 4 has a 3-chromatic Cayley graph), since a character of a group of exponent dividing 4 meets `[1/3, 2/3]` only at
   `1/2` — and Krebs–Sankar's winding homomorphism of a 3-colouring (their Thm 4.1, Remark 3.7) is the height's first step;
   `[EnamiMatsushita2026]` extends their group classification to circular chromatic number and is not implied."*
2. **`README.md`** § (the three-colour criterion), its **Prior art** bullet, replacing *"for the wider class the Lean proof covers,
   prior art not yet searched."* by: *"for the wider class the Lean proof covers, not found in print either; two consequences of it
   are in print — Payan (1992: no Cayley graph on $(\mathbb{Z}/2)^m$ needs exactly three colours) and Krebs and Sankar (2026, Theorem
   1.2: none on an abelian group of exponent 1, 2 or 4 does), which follow because such a group's characters meet $[1/3, 2/3]$ only
   at $1/2$."*
3. **`RESULTS.md`** § (the same result), **Whose** bullet, replacing *"the wider class the kernel proves: prior art not yet
   searched."* by: *"the wider class the kernel proves: prior art not found in print (FS131-PAS1); `[Payan1992]` and
   `[KrebsSankar2024]` Theorem 1.2's nontrivial half are corollaries of it."*
4. **`CLOSED-QUESTIONS.md` § 2.4**, after *"stays [hand]."* (the end of the kernel-status sentences): *"For the wider class, prior
   art not found in print (FS131-PAS1); its group-level corollary — which abelian groups carry a 3-chromatic Cayley graph — is
   `[KrebsSankar2024]` Thm 1.2, and `[EnamiMatsushita2026]` carries that classification to circular chromatic number."*
5. **`BIBLIOGRAPHY.md`**:
   - `[KrebsSankar2024]` (existing row, § as filed): update the citation to *"J. Combin. Theory Ser. B 179 (2026) 205–218"* and the
     reading status from *"second-hand: abstract and §1 read by FS-61's sweep agent"* to *"read in full, FS131-PAS1 (2026-10-16)"*;
     add to its role: *"Thm 1.2's nontrivial half and `[Payan1992]` are corollaries of row 79's criterion as the kernel states it
     (every abelian group); its winding homomorphism (Thm 4.1, Remark 3.7) is the height's first step"*.
   - new **`[EnamiMatsushita2026]`** | K. Enami, T. Matsushita, *Cayley graphs of abelian groups, circular colorings and discrete
     fundamental groups*, arXiv:2610.21940 (2026) | Thm 1.3: an abelian group has no Cayley graph with `2 < χ_c < 2 + 2/(k−1)` iff
     its exponent is in `{1, …, k} ∪ {2, 4, …, 2k}`; the group-level neighbour of row 79's criterion, not implied by it |
     `library/pdf/arXiv-2610.21940-enami-matsushita-cayley-abelian-circular-colorings.pdf` | read: §§ 1–2, Thm 4.2 and proof,
     references; § 3, § 4.1 skimmed (FS131-PAS1) |
   - new **`[Davidson2026]`** | J. Davidson, *Coloring monomial Cayley graphs: the one-parameter case*, arXiv:2610.09474 (2026) |
     unit-distance Cayley graphs on `ℤ[α]` with steps `±αⁿ`; colourings from characters (Lemma 2.2); conjectures three colours for
     every algebraic noninteger `α` and four for every `α`; cites `[OAIMath2026]` | `library/pdf/arXiv-2610.09474-davidson-monomial-cayley-graphs-one-parameter.pdf` |
     read: abstract, § 1, § 2.1–2.2; the rest scanned (FS131-PAS1) |
   - `[Payan1992]` (existing row): add *"zbMATH 0772.05043; its review read (FS131-PAS1); a corollary of row 79's criterion"*.
