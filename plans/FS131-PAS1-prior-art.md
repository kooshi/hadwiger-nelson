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

## Stage 3 — SAVED: S2, a finite triangle-free six-chromatic unit-distance graph; the fractional forms

### 3.1 The queries (2026-10-16; tag `S2` in `data/fs131/pas1/queries.jsonl`; 25 queries)

| discipline | queries (hits) |
|---|---|
| geometric graph theory, girth | zb `ab:"unit distance" & ab:"triangle-free"` (3); `ab:"unit-distance" & ab:"triangle-free"` (3); `ab:"unit distance" & ab:"girth" & ab:"chromatic"` (7); `ab:"unit-distance graph" & ab:"girth"` (2); `ab:"chromatic number of the plane" & ab:"triangle"` (4); `ab:"chromatic number" & ab:"triangle-free" & ab:"plane" & ab:"unit"` (2); `ab:"unit distance graph" & ab:"rational points" & ab:"chromatic"` (1); ax `abs:"unit distance" AND abs:"triangle-free"` (1); `abs:"unit-distance" AND abs:"triangle-free"` (1); `abs:"6-chromatic" AND abs:"unit distance"` (0); `abs:"six-chromatic" AND abs:"unit"` (0); every arXiv abstract since 2026-07-01 with "Hadwiger-Nelson" (3) and since 2026-10-01 with "chromatic number of the plane" (1) |
| fractional colouring | zb `ab:"fractional chromatic number" & ab:"unit distance"` (6); `… & ab:"plane" & ab:"rational"` (0); `… & ab:"number field"` (0); `… & ab:"algebraic"` (8, none on the plane); `ab:"fractional chromatic" & ab:"field" & ab:"distance"` (1, unrelated); `ab:"independence ratio" & ab:"unit distance"` (2); `ab:"independence ratio" & ab:"field" & ab:"distance"` (0); `ab:"Hall ratio" & ab:"plane"` (1); ax `abs:"fractional chromatic number" AND abs:"unit distance"` (3) |
| held texts | the eighteen Polymath16 threads (`library/notes/polymath16-threads-1-18-text.txt`), grepped for "triangle-free" (3 lines; read in context); `[OAIMath2026]`'s clone, grepped for "triangle-free" and "girth" in its Hadwiger–Nelson family (none); `[Davies2026]` (held), grepped (none) |

### 3.2 What was read

- **`[deGrey2026]`** — A. de Grey, *A 5-chromatic, triangle-free unit-distance graph in ℝ³ with 61 vertices*, Geombinatorics
  35(3) (2026) 111–118, **held** in the journal copy `library/geombinatorics/geombinatorics-v35-n3-2026-01.pdf` (the bibliography
  row still says "not held … unread"). **Read in full.** Abstract: "We present an embedding of a 61-vertex, 5-chromatic graph of
  girth 4 in R3 as a unit-distance graph (UDG). We speculate that no 6-chromatic case exists, even though 6-chromatic UDGs in R3
  with girth 3 exist having as few as 47 vertices." Closing remarks (p. 116): "Second, do triangle-free 6-chromatic UDGs in R3
  exist? Here we are less optimistic." Introduction: in the plane "no 5-chromatic case is known (indeed, all known 5-chromatic UDGs
  are very triangle-dense)".
- **`[Haugstrup2026]`** — A. Haugstrup, *A tetrahedron-free 6-chromatic unit-distance graph in three-dimensional space*, same issue,
  102–110, **held** in the same copy (row says "not held"). **Read: § 1 and the closing section.** Closing: "Another question to
  consider in R3 is the triangle-free case. Elsewhere in this issue [12] is demonstrated a 5-chromatic such construction, and we are
  curious whether chromatic number 6 is achievable."
- **`[Polymath16threads]`**, eighteenth thread (held): de Grey's post of 17 January 2026 states a conjecture — "For all d >= 2 and 3
  <= n <= d+2, there exists a (d+n-1)-chromatic unit-distance graph in R^d that does not contain any n-simplex" — and calls its
  plane case "proven for both relevant values of n (namely 3 and 4)"; Haugstrup's post of 13 February 2026 sketches "a triangle-free
  6-chromatic UDG in R^4".
- **`[Ducz2026]`** (held, read in full at an earlier gate): geometric 4-colourings of the Moser lattice and of the whole Moser ring,
  so every unit-distance graph in the Moser ring has geometric fractional chromatic number at most 4, and `[MatolcsiEtAl2025]`'s
  27-vertex graph there has exactly 4.
- Abstracts: Bucić–Davies (arXiv:2312.06898; Amer. Math. Monthly 2025: large girth, exponential chromatic number in `ℝ^d`); Silva
  Filho (arXiv:2607.19995: the coordinate fields of Exoo–Ismailescu's triangle-free 4-chromatic graphs); `[DuczVarga2026]`,
  `[MatolcsiEtAl2025]` (held, read before); Alon–Bucić–Davies (arXiv:2609.36220, typical norms) by title only.

### 3.3 Verdict: **not found in print** — and it answers two questions in print, against one speculation

**The finite triangle-free six-chromatic unit-distance graph:** not found in print. No paper or thread found states one, in the
plane or in any dimension below 4. What S2 bears on, given `[OAIMath2026]`'s `χ(ℝ²) ≥ 6` and the collapse's declared outside
theorems (as the kernel corollary states it):
1. **It answers `[deGrey2026]`'s question and `[Haugstrup2026]`'s** — whether a triangle-free 6-chromatic unit-distance graph exists
   in `ℝ³` — **yes**: a planar unit-distance graph is one in `ℝ³`. It is **contrary to `[deGrey2026]`'s abstract**, "We speculate that
   no 6-chromatic case exists" (the case being girth 4 in `ℝ³`; a triangle-free graph of the plane over a field has girth 4 or more,
   and exactly 4 once a unit rhombus is added as a separate component, which changes no chromatic number).
2. In the plane it goes past the triangle-free 5-chromatic graph asked for by `[Soifer2024]`'s Open Problem 55.1 (whose existence
   half row 121 answered at ℚ(√47)), and past the plane case of de Grey's 2026 Polymath16 conjecture (which asks only 4 colours
   without triangles).
3. **A generalization the argument already carries** (no new derivation; a composition of held statements, [derived], one mind):
   the collapse gives `χ(ℚ(√635087)²) = χ(ℝ²)` whatever `χ(ℝ²)` is, and `√3 ∉ ℚ(√635087)`, so by de Bruijn–Erdős **some finite
   triangle-free unit-distance graph has chromatic number exactly `χ(ℝ²)`** — six or seven. Without `[OAIMath2026]` this says
   triangle-free graphs reach the plane's number; with it, six.

**The fractional forms:** `χ_f(F²) = 1/α_loc(F)` at every real number field, and `χ_f(F²) = χ_f(ℝ²)` where the collapse holds: not
found in print. The nearest in print: the plane's `χ_f(ℝ²) = 1/m₁(ℝ²)` question (`[MatolcsiEtAl2025]` §2; row 129, answered by
FS-133); and **one instance partly**: at the Moser ring, `χ_gf = 4` (`[Ducz2026]` Thm 3.1 with `[MatolcsiEtAl2025]`'s `G27`), the
ring-level shadow of `χ_f(K²) = 4` (G60's instance; K's tight dyadic places give `α_loc(K) = 1/4`). The Moser ring is smaller than
the ring `ℤ[U_K]` that the plane over K reaches (Lemma C′ puts the split primes' inverses in it), so the field statement is not
Dúcz's.

**Not read:** the rest of Haugstrup's paper; Rubanov's 2007 and 2013 claims (cited second-hand by both papers, publication not
located by them); Bucić–Davies beyond the abstract.

### 3.4 Drafts (each names its slot)

1. **`README.md`** § 5 (the collapse), **Prior art** bullet, after *"The equality it passes through, between $\chi(\mathbb{R}^2)$
   and the measurable chromatic number, is OpenAI's."*: *"The finite triangle-free six-chromatic graph: not found in print. It
   answers a question of de Grey and of Haugstrup (both 2026), whether a triangle-free six-chromatic unit-distance graph exists even
   in three dimensions — de Grey had speculated that none does."*
2. **`LEDGER.md` row 129**, its **Prior art** field, after *"B-CHIF likely folklore."*: *"The fractional forms at a number field —
   `χ_f(F²) = 1/α_loc(F)` at every real number field, and `= χ_f(ℝ²)` where the collapse holds — not found in print (FS131-PAS1,
   2026-10-16); at the Moser ring the instance `χ_gf = 4` is `[Ducz2026]` Thm 3.1 with `[MatolcsiEtAl2025]`'s `G27`. The finite
   triangle-free six-chromatic unit-distance graph (given `[OAIMath2026]`): not found in print; it answers `[deGrey2026]` p. 116 and
   `[Haugstrup2026]`'s closing question in `ℝ³`, against `[deGrey2026]`'s speculation that none exists."* (If the kernel landing
   files the triangle-free corollary under row 128 instead, the second sentence goes there.)
3. **`CLOSED-QUESTIONS.md`** — a new entry beside § (Soifer 55.1, l. 619): *"**A triangle-free 6-chromatic unit-distance graph in
   ℝ³.** `[deGrey2026]` p. 116: "do triangle-free 6-chromatic UDGs in R3 exist? Here we are less optimistic"; `[Haugstrup2026]`
   (closing section): "we are curious whether chromatic number 6 is achievable". **Answered yes, in the plane, non-constructively**,
   given `[OAIMath2026]`'s `χ(ℝ²) ≥ 6`: `χ(ℚ(√635087)²) = χ(ℝ²)` (row 128) and `√3 ∉ ℚ(√635087)`, so by de Bruijn–Erdős a finite
   triangle-free unit-distance graph has chromatic number `χ(ℝ²) ≥ 6`; [kernel] at the landing of FS131-IFR1's corollary, on the
   collapse's declared outside theorems and `Outside.OAI158.no_proper_five_coloring`. None is constructed."*
4. **`BIBLIOGRAPHY.md`**: `[deGrey2026]` — change the copy column to *"held: `library/geombinatorics/geombinatorics-v35-n3-2026-01.pdf`,
   pp. 111–118"* and the status to *"read in full (FS131-PAS1, 2026-10-16); its question (p. 116) and its abstract's speculation are
   answered by the triangle-free six-chromatic graph, given `[OAIMath2026]`"*; `[Haugstrup2026]` — copy *"held: same issue, pp.
   102–110"*, status *"§ 1 and closing section read (FS131-PAS1); its closing question answered likewise"*.

## Stage 4 — SAVED: S3, CLS (the classification of four-colour places)

### 4.1 The queries (2026-10-16; tag `S3`; 36 queries)

| discipline | queries (hits) |
|---|---|
| geometric graph theory over finite fields | zb `ab:"finite Euclidean" & ab:"chromatic"` (1); `ab:"unit distance" & ab:"finite field" & ab:"chromatic"` (0); `ab:"unit-distance" & ab:"finite field"` (1); `ab:"Euclidean graphs" & ab:"chromatic"` (2); `ti:"finite Euclidean graphs"` (5); `ab:"finite Euclidean graphs"` (8); `ab:"unit graph" & ab:"finite field" & ab:"chromatic"` (0); `ab:"chromatic number" & ab:"F_q^2" & ab:"distance"` (0); `ab:"distance graph" & ab:"finite field" & ab:"chromatic"` (0); `ab:"Euclidean graph" & ab:"finite field" & ab:"chromatic"` (0); ax `abs:"finite Euclidean" AND abs:chromatic` (0); `abs:"unit distance graph" AND abs:"finite field"` (1); `abs:"chromatic number" AND abs:"finite field" AND abs:"unit"` (1: `[Vinh2005]`) |
| the characteristic-2 targets (Cayley graphs of `𝔽_{Q²}` on `μ_{Q+1}`) | zb `ab:"Cayley graph" & ab:"roots of unity" & ab:"chromatic"` (0); `ab:"generalized Paley" & ab:"chromatic number"` (1, unrelated); `ab:"cyclotomic graph" & ab:"chromatic"` (0); `ab:"unit circle" & ab:"finite field" & ab:"graph"` (0); `ab:"Cayley graph" & ab:"norm one" & ab:"finite field"` (0); `ab:"Hermitian" & ab:"unit circle" & ab:"chromatic"` (0) |
| the plane over number fields | zb `ab:"chromatic number of the plane" & ab:"field"` (1, unrelated); `ab:"chromatic number" & ab:"number field" & ab:"plane"` (0); `ab:"chromatic number" & ab:"algebraic number field" & ab:"distance"` (0); `ab:"chromatic number" & ab:"residue field" & ab:"plane"` (0); `ab:"unit vectors" & ab:"chromatic number" & ab:"field"` (1: `[Fischer1990]`); `ab:"chromatic number" & ab:"real quadratic field"` (0); `ab:"unit distance graph" & ab:"quadratic field"` (0); ax `abs:"chromatic number" AND abs:"number field" AND abs:plane` (0); `abs:"chromatic number" AND abs:"quadratic field" AND abs:"unit distance"` (0); `abs:"Hadwiger-Nelson" AND abs:field` (2: `[Madore2015]`, `[BardestaniMallahiKarai2015]`) |
| author listings | zb `au:"Moorhouse, G. Eric"` (28: none on colouring — `[Moorhouse2010]` is an unpublished draft, not indexed); `au:"Fischer, K" & ab:"colorable"` (1) and `& ti:"plane"` (1): `[Fischer1990]` only (`au:"Fischer, Kurt G."` 0); `au:"Johnson, Peter D." & ab:"chromatic"` (33: his fractional and distance-graph papers; *Euclidean distance graphs on the rational points*, 2011, the chapter `BIBLIOGRAPHY.md` holds as `[Johnson2010]`); `au:"Krebs, Mike"` (stage 2) |

### 4.2 What was read

- **`[Moorhouse2010]`** § 8 re-read in full (held): **Theorem 8.1** "If d ≢ 47, 59 or 83 mod 84, then χ(K²) ⩽ 4" for `K = ℚ(√d)`
  real quadratic, from **Lemma 8.2** (a prime `p ≡ 3 (mod 4)` with `d` zero or a residue mod `p` gives `χ(K²) ≤ χ(𝔽_p²)`),
  **Corollary 8.3** (the planes at 3 and 7: `χ(𝔽₃²) = 3`, `χ(𝔽₇²) = 4`), **Lemma 8.4** (`d ≡ 1 (mod 4)`: two colours at the
  dyadic place) and **Theorem 8.5** (`d ≡ 2 (mod 4)`: two colours by a ring of order 8 at the ramified dyadic place); § 6 Table 6.1
  (`χ(𝔽₁₁²) = 5` and the small values, as the existing row records); § 7.1 (odd degree: two colours by the dyadic trace).
- Held and read before, consulted for this statement: `[Vinh2005]` (`√q(1/2 + o(1)) ≤ χ(Γ_q)`, Hoffman with `[MMST1996]`'s
  Kloosterman spectrum), `[Vinh2008]` (Thm 12, the ratio bound with Weil), `[Fischer1990]` Thm 10(i) (`χ ≤ 4` at `d ≡ 3 (mod 8)`),
  `[Madore2015]`, `[BardestaniMallahiKarai2015]` — none states a classification.
- Listings only: Bannai–Shimabukuro–Tanaka 2009, *Finite Euclidean graphs and Ramanujan graphs* (Discrete Math. 309), and Medrano
  et al. 1998 (over rings): spectra, not colourings; unread.

### 4.3 Verdict: **not found in print** as a classification; its quadratic sufficiency half and its odd finite inputs are in print

CLS — for every real number field, the stable places whose residue target is four-colourable are exactly those with residue
field `𝔽₃` or `𝔽₇`, the dyadic ones inert in `F(i)/F` of norm at most 32, and the dyadic ones ramified there, so `L(F) ≥ 5` exactly
when there are none — is **not found in print**. Its parts:
1. **Sufficiency at real quadratic fields: in print.** `[Moorhouse2010]` Thm 8.1 (the places `𝔽₃`, `𝔽₇` and the dyadic ones that
   ramify or split) with `[Fischer1990]` Thm 10(i) (`d ≡ 3 (mod 8)`, where the dyadic place is inert in `F(i)` with norm 2) give
   `χ ≤ 4` off `d ≡ 47, 143, 167 (mod 168)` — Moorhouse's three classes mod 84 are those three and three classes already covered
   by Fischer's. That is the "if" half of CLS at degree 2, and the existing row 117 records it.
2. **The odd finite inputs: in print.** The values `χ(Γ₃) = 3`, `χ(Γ₇) = 4`, `χ(Γ₁₁) = 5` (`[Moorhouse2010]` Table 6.1) and the
   growth of `χ(Γ_q)` (`[Vinh2005]`, `[Vinh2008]`); that no usable `q ≥ 11` is four-colourable needs every `q` up to Weil's threshold,
   which in print is Moorhouse's table at 11 only.
3. **Not found:** the dyadic inert targets `U_Q` and their threshold (four-colourable exactly when `Q ≤ 32`); the all-levels
   reading; any statement over a general real number field, of any degree; the converse direction anywhere (that no other place's
   target is four-colourable). Moorhouse's paper poses no such classification; it bounds fields one prime at a time.

### 4.4 Drafts (each names its slot)

1. **`LEDGER.md` row 123**, its **Prior art** field, after *"so "not found", never "first"."*: *"CLS (the classification of
   four-colour places): not found in print as a classification (FS131-PAS1, 2026-10-16: 36 queries in finite-Euclidean-graph,
   cyclotomic and number-field words; the listings of Moorhouse, Fischer, Johnson, Krebs); its real-quadratic sufficiency half is
   `[Moorhouse2010]` Thm 8.1 (from 𝔽₃, 𝔽₇ and the dyadic place) with `[Fischer1990]` Thm 10(i), and its odd finite inputs are
   `[Moorhouse2010]` Table 6.1 and `[Vinh2005]`, `[Vinh2008]`; the dyadic inert targets `U_Q` and their threshold `Q ≤ 32` not
   found."*
2. **`plans/FS100-derivation.md` FS100-CLS** (an erratum entry under it, the original text left standing, per the record job's rule):
   *"2026-10-16 (FS131-PAS1): the prior-art debt this entry named — "the general statement not found (X24R did not search it by name:
   a debt for the next gate)" — is discharged: searched by name, not found in print; parts in print as `LEDGER.md` row 123's prior-art
   field now says."*
3. **The public page**, when CLS lands (its entry's prior-art bullet): *"Prior art: not found in print as a classification. For real
   quadratic fields the sufficient condition is Moorhouse's (2010, Theorem 8.1) with Fischer's (1990, Theorem 10(i)); the values of
   the small finite planes are Moorhouse's (Table 6.1); the even-characteristic targets and their threshold are this project's."*
4. **`BIBLIOGRAPHY.md` `[Moorhouse2010]`**: no change of substance; its § 8 was re-read by this job (add *"§ 8 re-read in full,
   FS131-PAS1"* to the reading column if the row keeps per-section dates).

## Stage 5 — SAVED: S4, Lemma C′ (the ring the unit vectors generate)

### 5.1 The queries (2026-10-16; tag `S4`; 23 queries)

| discipline | queries (hits) |
|---|---|
| algebraic number theory: norm-one elements | zb `ab:"norm one" & ab:"generated" & ab:"ring"` (3, unrelated); `ab:"elements of norm one" & ab:"additive"` (0); `ab:"elements of norm 1" & ab:"generate"` (0); `ab:"norm-one" & ab:"additively"` (0); `ab:"sums of elements of norm"` (0); `ab:"Hilbert 90" & ab:"additive"` (0); `ab:"norm one" & ab:"torus" & ab:"rational points" & ab:"dense"` (0); ax `abs:"norm one" AND abs:"additively generated"` (0); `abs:"norm one" AND abs:"sums" AND abs:"number field"` (0) |
| additive unit structure (the discipline that asks "is a ring generated by its units") | zb `ab:"unit sum number"` (11); `ab:"sums of units" & ab:"number field"` (1); `ab:"additively generated by" & ab:"units"` (7); `ab:"generated by its units"` (18) |
| Pythagorean triples over number fields | zb `ab:"Pythagorean triples" & ab:"number field"` (2); `ab:"Pythagorean triples" & ab:"group" & ab:"field"` (5); `au:"Zanardo, Paolo" & ab:"Pythagorean"` (0); `ab:"rational points" & ab:"unit circle" & ab:"number field"` (1); ax `abs:"Pythagorean triples" AND abs:"number field"` (1) |
| geometric graph theory (`[Johnson2000]` § 5's question) | zb `ab:"unit vectors" & ab:"additive group"` (0); `ab:"additive group generated" & ab:"unit"` (4, unrelated); ax `abs:"unit vectors" AND abs:"number field" AND abs:"generate"` (1, unrelated) |
| the named candidate | zb `ti:"Arithmetic of unitary groups"` (1: `[Shimura1964]`, Zbl 0144.29504, review withheld) |

### 5.2 What was read

- **`[MinacNguyenTan2026]`** — J. Mináč, T. T. Nguyen, N. D. Tân, *Sums of units in finite rings and applications to Cayley graphs*,
  arXiv:2607.00404v1 (2026), fetched (`library/pdf/arXiv-2607.00404-…pdf`). **Read: abstract and § 3.3 (Question 3.14 to
  Proposition 3.19, and the statement of Theorem 3.16).** Theorem 3.16: "Let F = F_q and L/F be a non-trivial finite field
  extension. Then L is additively generated by U±_{L/F}, i.e., the Cayley graph Γ(L, U±_{L/F}) is always connected", with the least
  number of summands (2, 3 or 4) determined; `U_{L/F}` the norm-one units. This is **the residue-field case of Lemma C′'s local step**
  — at an inert stable place, level one: the norm-one group of `𝔽_{q²}/𝔽_q` generates `𝔽_{q²}` additively.
- **Barroero–Frei–Tichy**, *Additive unit representations in rings over global fields — a survey*, Publ. Math. Debrecen 79 (2011),
  arXiv:1102.0120, fetched; **scanned by search** for norm, norm one, Pythagorean, S-unit: the survey treats generation by all units
  or S-units, never by a norm-one subgroup. zbMATH reviews read for Ziegler 2011 (quadratic orders and S-units), Frei 2012 (rings
  of integers generated by units, Jarden–Narkiewicz's question).
- **`[Fischer1990b]`** (held, read in full at an earlier gate): Thms 1, 3, 4 — the quadratic and multiquadratic cases.
- **`[ZanardoZannier1991]`** (held; its Lemma 1, `T(F) = {y/σy}`, and the prime partition, read second-hand): the group, not the
  ring it generates.
- **`[Shimura1964]`**: not held (JSTOR); its zbMATH review is withheld; **not read**. Its subject is the arithmetic of unitary
  groups of hermitian forms (genera, class numbers, strong approximation); `U(1)` is the norm-one torus, so a statement about the
  ring its rational points generate could sit there, and nothing found by search says it does.

### 5.3 Verdict: **not found in print** in general; the quadratic and multiquadratic cases and one local piece are in print

Lemma C′ — for a real number field `F` with no ramified stable dyadic place, the additive group generated by the unit vectors of
`F²` (the norm-one group `T(F)` of `F(i)/F`) is the ring `O′` of elements of `F(i)` integral at every stable prime — **in this
form, not found in print.** What is in print and how it relates:
1. `[Fischer1990b]` Thms 1, 3, 4: the same statement for real quadratic `F` and (at odd unramified primes) multiquadratic `F` —
   **special cases**, as `LEDGER.md` rows 100 and 105 already record.
2. `[MinacNguyenTan2026]` Thm 3.16: the norm-one units of a finite field extension generate it additively — **the level-one,
   residue-field piece of the local step** at an inert stable prime; the higher levels `O_𝔓/𝔓ⁿ`, the dyadic places and the global
   assembly are not there.
3. In the language of the additive unit structure literature (Jarden–Narkiewicz, Frei, Barroero–Frei–Tichy, Ziegler) Lemma C′
   says: **the ring of `S`-integers of `F(i)`, `S` the primes that split over `F`, is additively generated by the norm-one
   `S`-units.** That literature asks it for all units or all `S`-units of a ring of integers, with a finite `S`; the norm-one
   subgroup and the infinite set of split primes are not its questions. Searched by its words; not found.
4. `[Shimura1964]`: undecided, unread — the one named candidate not cleared.

The rider "infinitely many components in every case" (row 105's, now the kernel planner's `infinite_connectedComponent_planeOver`)
reduces to S5's statement and is searched there.

### 5.4 Drafts (each names its slot)

1. **`LEDGER.md` row 100**, its **Prior art** field, replacing *"Lemma C/C′ partly `[Fischer1990b]`'s (quadratic and multiquadratic
   cases), the general form not found, Shimura 1964 undecided"* by: *"Lemma C/C′ partly `[Fischer1990b]`'s (quadratic and
   multiquadratic cases); the general form not found in print (FS131-PAS1, 2026-10-16: 23 queries in norm-one, additive-unit-structure
   and Pythagorean-triple words); its residue-field piece — the norm-one units of `𝔽_{q^n}/𝔽_q` generate it additively — is
   `[MinacNguyenTan2026]` Thm 3.16; `[Shimura1964]` unread (not held), the one named candidate not cleared"*.
2. **The public page**, when Lemma C′ lands (FS131-KRU1's implementer): *"Prior art: for real quadratic fields, and multiquadratic
   ones away from 2, Fischer (1990); for finite fields, the fact that norm-one elements generate additively is Mináč, Nguyen and Tân
   (2026, Theorem 3.16). The general statement: not found in print; Shimura (1964), the one paper named as a likely place, has not
   been read."*
3. **`BIBLIOGRAPHY.md`**: new **`[MinacNguyenTan2026]`** | J. Mináč, T. T. Nguyen, N. D. Tân, *Sums of units in finite rings and
   applications to Cayley graphs*, arXiv:2607.00404 (2026) | Thm 3.16: a non-trivial extension of finite fields is additively
   generated by its norm-one units, with sum lengths 2–4 — the residue-field piece of Lemma C′'s local step (row 100) |
   `library/pdf/arXiv-2607.00404-minac-nguyen-tan-sums-of-units-finite-rings.pdf` | read: abstract, § 3.3 to Prop. 3.19 and Thm 3.16's
   statement (FS131-PAS1) |; new **`[BarroeroFreiTichy2011]`** | F. Barroero, C. Frei, R. F. Tichy, *Additive unit representations in
   rings over global fields — a survey*, Publ. Math. Debrecen 79 (2011) 291–307, arXiv:1102.0120 | the discipline in whose words
   Lemma C′ is "the `S`-integers, `S` the split primes, are generated by norm-one `S`-units"; nothing on norm-one subgroups |
   `library/pdf/arXiv-1102.0120-barroero-frei-tichy-additive-unit-representations-survey.pdf` | scanned by search (FS131-PAS1) |;
   `[Shimura1964]` (both existing rows, which duplicate one key): reading status unchanged, *"not read; zbMATH review withheld; the
   FS131-PAS1 gate could not clear it"* — and the two rows (l. 69 and l. 365) merged, a bibliography defect noted here.
