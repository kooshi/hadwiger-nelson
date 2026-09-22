# FS-25 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Filed 2026-09-23 by the FS-71 batch-5a implementer (the theorem audit, `plans/FS71-theorem-audit.md`). FS-25 is the
"explain the unexplained" package of the 2026-09-09 six-way consolidation; its content lives entirely in
`plans/FS25-P2.md` (package P2, items E4, E3, E5 — items E1, E2, E6, E7 belong elsewhere or were not attempted, per
that file's own header). Enumeration: `plans/FS25-P2.md` read in full (660 lines, including its own §PA prior-art
gate).*

## The theorems

**T1 — De Grey's 1581-vertex graph forces no pair at five colours, via three exhibited critical vertices. [derived
(row 48); tools; the FS-25/P2 implementer]** De Grey's 1581-vertex 5-chromatic unit-distance graph is a 1-sum of two
791-vertex halves `A`, `B` sharing exactly the vertex `14`, joined by exactly one cross edge `(11, 802)` (verified
exhaustively against `tools/degrey.py`'s output: 7,877 edges, 0 outside the decomposition). Both halves are
4-colourable (`tools/fs25_e4.py`, cadical, re-verified against the edge lists outside the solver: `[A]` all 3,938
edges proper, `[B]` all 3,938 edges proper; both refuse three colours). Gluing gives three critical vertices at four
colours — `11`, `802` (delete either and the halves share only `14`, glue by matching palettes there) and `14`
(delete it and the halves share no vertex, glue by *dis*agreeing across `(11,802)`) — each independently confirmed by
the solver on the deletion itself. Since a forced-equal pair at five colours has at most two critical vertices at
four colours (`CriticalSet.encard_criticalSet_le_two_of_forces`, row 48, `plans/M54-derivation.md` M54-T1, kernel),
and this graph has three, **the graph forces no pair to share a colour in any proper 5-colouring** — the whole
forced-equal half of M48's 1,248,990-pair arity-2 sweep, established with no sweep. *Proof:* `plans/FS25-P2.md`
§1.2–§1.3; witnesses `data/e4-critical-vertices.json`; generator `tools/fs25_e4.py`. *Proof verdict:* closes.
*Rests on it:* row 48 (`M54-T1`'s kernel localization theorem); row 43 (the 1581's arity floor at five colours, 4 or
5); `CLAUDE.md` G31's sentence "forcing at χ allows ≤ 2 critical vertices, and this 1-sum has 3, so de Grey's 1581
has no forced pair at five" — this entry is that sentence's home, flagged for it by `data/fs71/batch-3a.md`'s own
cross-batch note ("the '≤ 2 critical vertices' half is M54-T1; the 'this 1-sum has 3' half and the corollary's own
combination trace to `plans/FS25-P2.md`"). *Prior art:* ours for the corollary; the 1-sum structure is de Grey's own
construction (`arXiv:1804.02385` §5.1), already recorded in this repository three ways before this package
(`plans/M06-chi-ge-five.md`, `plans/M09-gadget-algebra.md`, `Instances/DeGrey/Split.lean`) — no novelty claimed for
it; the colouring lemma behind the gluing ("a graph is `k`-colourable iff each block is") is textbook (Diestel,
*Graph Theory*), absent from Mathlib. The specific claim "which vertices of the 1581 are critical" was searched for
directly (de Grey-graph structure and criticality, MathWorld's page, the Polymath16 proposal thread) and not found;
MathWorld's *"at most 4 vertices can be removed without introducing a 4-coloring"* is vertex-*minimality*, a
different quantity. zbMATH: `ab:"vertex critical" & ab:"de Grey"` (0), `ab:"critical graph" & ab:"5-chromatic" &
ab:"unit distance"` (0). *Kernel:* declined — the general localization theorem is already kernel (row 48); this
entry is a computed instance about one specific object (the 1-sum decomposition and the three exhibited
colourings), and `plans/FS25-P2.md` §1.6 prices formalizing it at about a day for a negative about one object,
judged not worth it at the time; no stub raised since.

**T2 — The periodic quotient of a finite Euclidean plane, identified as one explicit circulant. [derived; the
FS-25/P2 implementer]** For `p ≡ 3 (mod 4)` prime, identify `𝔽_p² ≅ 𝔽_p(i)`; for a line `ℓ_γ` (kernel of `z ↦
Tr(γz)`, `γ ≠ 0`) missing the unit circle `μ_{p+1}` — equivalently `ν := N(γ)` a non-square in `𝔽_p^×` — the periodic
quotient of the plane's colouring along `ℓ_γ` is exactly the circulant graph `Cay(ℤ/p, D)` with `D = { t ∈ 𝔽_p : t² −
4ν is a non-square }`: this is the trace set `Tr{ w : N(w) = ν }`, since every element of the norm-`ν` fibre has
`𝔽_p`-degree exactly 2 (it lies off `𝔽_p`, `ν` being a non-square) and `X² − tX + ν` is its minimal polynomial, whose
discriminant `t² − 4ν` is a non-square exactly on that fibre. Consequences, each proved from this: `|D| = (p+1)/2`
(the fibre's `p+1` elements pair off by conjugation), `D = −D`, `0 ∉ D` (since `−4ν` is a square: `4` is a square,
`ν` a non-square, `−1` a non-square as `p ≡ 3 (mod 4)`), and `D` is independent of the choice of `ν` up to a
dilation (`D_{c²ν} = c·D_ν`, an isomorphism of the circulant) — so `C_p := Cay(ℤ/p, D)` really is one graph per
prime. The complement `D^c = { x + ν/x : x ∈ 𝔽_p^× }` is the trace set of the *split* torus at determinant `ν`, of
size `(p−1)/2`, giving the combinatorial description `α(C_p) = ` the size of a maximal subset of `ℤ/p` whose
differences all take that form. *Proof:* `plans/FS25-P2.md` §2.2 (the minimal-polynomial/trace argument, from
elementary local-field-free algebra over `𝔽_p`), verified line by line — not sampled — against the direct
construction (build the circle in `𝔽_p²`, find every line that misses it, project, compare) at eight primes (3, 7,
11, 19, 23, 31, 43, 47; `tools/fs25_e3.py`), and `α`, `χ` checked against `plans/M61-local-global-tightness.md`'s own
solver table at the seven primes where that table is exact. *Proof verdict:* closes. *Rests on it:* T3 below (the
spectral consequence); the periodic-quotient machinery of `plans/M61-derivation.md` M61-T4 (row 56), of which this
is the closed-form instance the record's own §S3 states only "one prime at a time with a SAT solver". *Prior art:*
ours — searched (delegated, ~30 queries, primary sources opened) under finite-geometry vocabulary (finite Euclidean
graphs, unit-quadrance graphs, Cayley graphs over finite fields, Paley/Peisert/cyclotomic graphs, circulant chromatic
numbers) and under analytic-number-theory vocabulary (Kloosterman sums, Salié sums, character sums over tori, Weil
bounds); not found in `[Vinh2005]`, `[Vinh2006]`, `[Moorhouse2010]`, `[Krebs2022]`, `[LorenzZimmermann2023]` — all of
which stay on `𝔽_q^n` and never take the one-dimensional quotient — nor in the circulant-chromatic-number
literature, which treats a fixed small generator count, structurally unlike a `D` of size `(p+1)/2`. Confidence
medium-high (a classification-code search, MathSciNet/zbMATH, could still overturn it; this repository's own zbMATH
gate, below, is exactly that search and stayed negative). zbMATH (this batch, verbatim): `ab:"finite Euclidean
graph" & ab:"circulant"` (0), `ab:"quadratic form" & ab:"trace" & ab:"circulant"` (1, irrelevant — "Metric algebraic
geometry", unrelated to this object). *Kernel:* declined — no Lean consumer; the fact is number-theoretic
bookkeeping behind M61's own solver table, not itself cited by any kernel statement.

**T3 — The spectral halving of the periodic-quotient circulant, and its Weil/Hoffman consequence. [derived; the
FS-25/P2 implementer]** With `D` as in T2, the circulant's spectrum is exactly half the plane's own, at a rescaled
frequency: `λ_{C_p}(a) = ½ · λ_{UD(𝔽_p,2)}(a·γ)` for every `a ∈ 𝔽_p` — because characters of `ℤ/p` pull back to
characters of `𝔽_p²` trivial on `ℓ_γ`, and the projection `π` restricted to the unit circle is exactly 2-to-1 onto
`D` (a fibre of `Tr` over `t ∈ D` meets the circle in the two roots of `X² − tX + ν`, never in one, since `t² = 4ν`
is impossible for `t ∈ D`). So `C_p`'s eigenvalues are the same Kloosterman sums M58 identified for the plane
itself (row 53, `λ(c) = −K(1, c/4)`), obeying the identical Weil bound `|λ| ≤ 2√p`, halved to `√p`, giving by
Hoffman `χ(C_p) ≥ 1 + (p+1)/(2√p)` with no computation — exceeding 5 from `p ≥ 67`. The **exact** spectrum, computed
here (a sum of at most 66 cosines, no numerical delicacy), pushes the crossing to `p = 59`. So of the registered
prediction P7 (`χ(C_p) ≥ 6` for every `p ≥ 23`, `plans/M61-local-global-tightness.md`), only `p ∈ {23, 31, 43, 47}`
remain open — each now a ≤ 376-variable SAT instance, "genuinely kernel-promotable by `decide` or a short LRAT
chain", rather than an open-ended table. *Proof:* `plans/FS25-P2.md` §2.4 (the 2-to-1 fibre argument, one line from
T2's minimal-polynomial fact) plus the exact-spectrum table (`tools/fs25_e3.py --hoffman`, reproduced at 11 primes
23–131). *Proof verdict:* closes. *Rests on it:* T2; row 53 (`plans/M58-derivation.md`'s Kloosterman
identification); `plans/M61-local-global-tightness.md`'s registered prediction P7, which this closes to a four-row
table plus a proved tail. *Prior art:* the Weil bound on the character sum over the norm-one torus of `𝔽_{q²}` is
`[LiFeng1992]` (*Character sums and abelian Ramanujan graphs*, J. Number Theory 41 (1992), under the name "twisted
generalized Kloosterman sum") — a citation for the bound, not a derivation of this consequence; the classical
elementary evaluation is Salié (1931); Katz's *Gauss Sums, Kloosterman Sums, and Monodromy Groups* (1988) has the
modern conic framing. The spectral halving and its chromatic consequence for this specific circulant are ours, not
found under the same search as T2. zbMATH: `ab:"Kloosterman sum" & ab:"circulant graph"` (0). *Kernel:* declined —
no Lean consumer; the four remaining primes are left as M61's solver table, not kernel-promoted here.

**T4 — The valuation law is the exponent-2 member of the additive-colouring family. [hand; the FS-25/P2 implementer, from kernel rows 50 and 59]** For a `K`-object, every
additive `k`-colouring's floor is `kΛ` — a nonvanishing additive homomorphism to a group of order `k` identifies
every pair whose difference lies in `kΛ` (kernel, `Additive.addMonoidHom_apply_eq_of_sub_eq_nsmul`), sharpened for a
non-cyclic target of exponent `e < k` to the strictly larger `eΛ` (kernel,
`addMonoidHom_apply_eq_of_sub_eq_exponent_nsmul`). At four colours the residue colouring of Theorem B is exactly the
exponent-2 instance of this family: its target is `𝔽₄`'s additive group, `ℤ/2 × ℤ/2`, of exponent 2 — so the
valuation law's verdict ("forced ⟹ 2-adic depth ≥ 1", row 59) is the *whole reach* of every additive four-colouring,
and **no additive four-colouring can ever separate a pair of 2-adic depth ≥ 2** (using all six `ℤ/4` and two `ℤ/2 ×
ℤ/2` homomorphisms buys exactly one more level of depth beyond the valuation law's own, and no member of the family
buys a second). Consequently a pair at depth ≥ 3 — such as the 16-pair residue measured on the 1,953-point object
`object-pth1-vdel28-it2v2-depth1` (13,796 unit edges; `data/m56/kempe-object-pth1-vdel28-it2v2-depth1-k4.json`,
reproduced exactly here: 178 pairs at `d² = 64/9`, 11 at `d² = 64/3`, matching the artifact's `F_add = 2,513`,
`F_K = 187`, `F_true = 171`, residue `= 16` counts) — cannot be explained or refuted by any arithmetic in this
family; the question of whether those 16 pairs are forced belongs to the reconfiguration graph of the colouring
space (Kempe swaps), not to the lattice. *Proof:* `plans/FS25-P2.md` §3.4 (the reconciliation) and §3.2's
artifact-level re-derivation. *Proof verdict:* closes. *Rests on it:* row 50 (M56, the additive yardstick and its
exponent lemma, kernel); row 59 (the valuation law, kernel); row 51 (M57's additive rigidity, whose analogous `k=5`
floor `5Λ` is the sibling statement §3.4's closing paragraph names). *Prior art:* the order-form floor (`kΛ`) is
`[Fischer1990]`'s central obstruction, used at least three times in his paper (checked directly against the held
copy: p. 182's example, the `Q^d` result, §5's close) and restated in `[Polymath16wiki]` (2018, "a linear
`k`-coloring is always periodic with period `k`") and used live in the 2018 blog threads (Gibbs at `k=5, d=5/3`;
Harder at `k=4, d=8/3`) — no novelty claimed. The exponent refinement (a non-cyclic target sees further than its
order) was searched for specifically ("exponent", "Klein four", "non-cyclic", "invariant factor") across Fischer's
paper, the wiki, the blog threads and `[CervantesKrebs2023]`, and not found — but it is **already a kernel lemma**
(`addMonoidHom_apply_eq_of_sub_eq_exponent_nsmul`), so what is new here is the *reconciliation reading*, not the
arithmetic fact. zbMATH: `ab:"additive coloring" & ab:"exponent"` (0), `ab:"linear coloring" & ab:"unit distance
graph"` (0). *Kernel:* declined — both halves of the floor are already kernel (`Additive.lean`); this entry connects
them to the valuation law (row 59) by an interpretive argument that needs no new Lean.

## Readings and measurements that were called theorems, or that could be mistaken for them

- **The forced/unforced-pair radius and density tendency (§3.3 of the source).** On the same 1,953-point object, the
  171 pairs forced by the object (of 189 total at the two forcing distances) have outer radius from the centroid
  never above 3.212 and median local density 742 within distance 2, against 2.398/530 for the 18 unforced pairs —
  "a tendency and not a separator": three of the eighteen unforced pairs sit at densities above the forced median.
  `[measured, this object only]`, not filed — the pair *classification* (171/18) is exact, the radius/density
  statistics are float geometry over exact coordinates and are explicitly not claimed as a theorem in the source.
- **The registered prediction P7, scored** (`χ(C_p) ≥ 6` for every `p ≥ 23`) — the scoring itself (T3's consequence)
  is filed; the bare prediction is `plans/M61-local-global-tightness.md`'s, not this package's.

## Conjectures surfaced, not claimed

None. Every claim in `plans/FS25-P2.md` that reaches a conclusion closes; the package's own §4 lists three items of
"candidate Lean work — stated, not started" (the 1-sum colourability lemma, the exponent-floor lemma packaged in the
`Separated` vocabulary, the circulant identification as a Lean statement), none of which is itself a theorem — they
are kernel-target proposals, and none has a consumer today, so none is stubbed.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| T1 | declined — the general theorem (row 48) is kernel; this is a computed instance, priced at ~a day, no consumer |
| T2 | declined — no Lean consumer |
| T3 | declined — no Lean consumer; the four open primes are M61's solver table |
| T4 | declined — both arithmetic halves are already kernel; this is an interpretive reconciliation |
